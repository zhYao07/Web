from django.shortcuts import render, get_object_or_404, redirect
from django.contrib.auth.decorators import login_required
from django.contrib import messages
from .models import Course, Enrollment, Schedule, TIME_SLOTS, WEEKDAY_CHOICES
from .forms import CourseForm, ScheduleForm
from django.utils import timezone
from django.db.models import Count, Avg
from .models import Exam
from apps.campus_life.models import Activity, Announcement, CardConsumption
from datetime import timedelta
from django.db.models.functions import TruncDate
from django.db.models import Sum, Q
from apps.users.models import User
from datetime import datetime
from apps.communication.models import Message

# Read - 课程列表
@login_required
def course_list(request):
    # 获取已选课程
    enrolled_courses = Enrollment.objects.filter(
        student=request.user
    ).select_related('course', 'course__teacher')
    
    # 获取搜索参数
    search_query = request.GET.get('search', '')
    college = request.GET.get('college', '')
    teacher = request.GET.get('teacher', '')
    
    # 构建查询条件
    courses = Course.objects.all()
    if search_query:
        courses = courses.filter(name__icontains=search_query)
    if college:
        courses = courses.filter(college=college)
    if teacher:
        courses = courses.filter(teacher__username__icontains=teacher)
    
    # 获取所有教师列表（用于筛选）
    teachers = User.objects.filter(role='teacher')
    
    context = {
        'enrolled_courses': enrolled_courses,
        'available_courses': courses,
        'teachers': teachers,
        'college_choices': Course.COLLEGE_CHOICES,
        'current_college': college,
        'current_teacher': teacher,
        'search_query': search_query
    }
    
    return render(request, 'academic/course_list.html', context)

# Read - 课程详情
@login_required
def course_detail(request, course_id):
    course = get_object_or_404(Course, id=course_id)
    
    # 格式化时间
    course.formatted_time = f"{course.get_weekday_display()} {course.start_time.strftime('%H:%M')}-{course.end_time.strftime('%H:%M')}"
    
    context = {
        'course': course,
    }
    
    if request.user.role == 'student':
        enrollment = Enrollment.objects.filter(
            student=request.user,
            course=course
        ).first()
        context['is_enrolled'] = enrollment is not None
        context['enrollment'] = enrollment
    
    return render(request, 'academic/course_detail.html', context)

# Create - 创建课程
@login_required
def course_create(request):
    if request.user.role != 'teacher':
        messages.error(request, '只有教师可以创建课程！')
        return redirect('academic:course_list')
        
    if request.method == 'POST':
        form = CourseForm(request.POST)
        if form.is_valid():
            course = form.save(commit=False)
            course.teacher = request.user
            course.save()
            messages.success(request, '课程创建成功！')
            return redirect('academic:course_detail', course_id=course.id)
    else:
        form = CourseForm()
    
    return render(request, 'academic/course_form.html', {
        'form': form,
        'title': '创建课程'
    })

# Update - 更新课程
@login_required
def course_update(request, course_id):
    course = get_object_or_404(Course, id=course_id)
    if request.method == 'POST':
        form = CourseForm(request.POST, instance=course)
        if form.is_valid():
            form.save()
            messages.success(request, '课程更新成功！')
            return redirect('course_detail', course_id=course.id)
    else:
        form = CourseForm(instance=course)
    
    return render(request, 'academic/course_form.html', {
        'form': form,
        'title': '更新课程'
    })

# Delete - 删除课程
@login_required
def course_delete(request, course_id):
    course = get_object_or_404(Course, id=course_id)
    if request.method == 'POST':
        course.delete()
        messages.success(request, '课程删除成功！')
        return redirect('course_list')
    
    return render(request, 'academic/course_confirm_delete.html', {
        'course': course
    })

@login_required
def schedule_view(request):
    # 获取用户的课程表
    schedule_data = {}
    
    # 获取该用户的所有课程安排
    if request.user.role == 'student':
        # 学生通过选课记录获取课程
        enrolled_courses = Course.objects.filter(
            enrollments__student=request.user
        )
        schedules = Schedule.objects.filter(
            course__in=enrolled_courses
        ).select_related('course', 'course__teacher')
    else:  # teacher
        # 教师获取自己教授的课程
        schedules = Schedule.objects.filter(
            course__teacher=request.user
        ).select_related('course', 'course__teacher')
    
    # 构建课程表数据结构
    for schedule in schedules:
        # 根据开始时间确定时间段
        start_time = schedule.start_time.strftime('%H:%M')
        time_slot = None
        
        # 根据时间段划分
        if '08:00' <= start_time <= '09:40':
            time_slot = '1'
        elif '10:00' <= start_time <= '11:40':
            time_slot = '2'
        elif '14:00' <= start_time <= '15:40':
            time_slot = '3'
        elif '16:00' <= start_time <= '17:40':
            time_slot = '4'
        elif '19:00' <= start_time <= '20:40':
            time_slot = '5'
        
        if time_slot:
            weekday = str(schedule.weekday)
            
            if time_slot not in schedule_data:
                schedule_data[time_slot] = {}
                
            schedule_data[time_slot][weekday] = {
                'id': schedule.course.id,
                'name': schedule.course.name,
                'teacher': schedule.course.teacher,
                'classroom': schedule.classroom
            }
    
    context = {
        'schedule': schedule_data,
        'weekdays': dict(WEEKDAY_CHOICES),
        'time_slots': dict(TIME_SLOTS)
    }
    
    return render(request, 'academic/schedule.html', context)

@login_required
def course_enroll(request, course_id):
    if request.user.role != 'student':
        messages.error(request, '只有学生可以选课！')
        return redirect('academic:course_detail', course_id=course_id)
        
    course = get_object_or_404(Course, id=course_id)
    
    # 检查是否已选
    if Enrollment.objects.filter(student=request.user, course=course).exists():
        messages.warning(request, '你已经选修了这门课程！')
        return redirect('academic:course_detail', course_id=course_id)
    
    # 检查课程容量
    if course.enrollments.count() >= course.capacity:
        messages.error(request, '该课程已达到人数上限！')
        return redirect('academic:course_detail', course_id=course_id)
    
    # 创建选课记录
    Enrollment.objects.create(
        student=request.user,
        course=course
    )
    messages.success(request, '选课成功！')
    return redirect('academic:course_detail', course_id=course_id)

@login_required
def dashboard(request):
    today = timezone.now().date()
    
    # 获取今日课程数量
    if request.user.role == 'student':
        today_courses_count = Course.objects.filter(
            schedules__weekday=today.weekday() + 1,
            enrollments__student=request.user
        ).distinct().count()
    else:
        today_courses_count = Course.objects.filter(
            schedules__weekday=today.weekday() + 1,
            teacher=request.user
        ).distinct().count()
    
    # 获取当天的课程列表
    if request.user.role == 'student':
        today_courses = Course.objects.filter(
            schedules__weekday=today.weekday() + 1,
            enrollments__student=request.user
        ).select_related('teacher').prefetch_related('schedules').distinct()
    else:
        today_courses = Course.objects.filter(
            schedules__weekday=today.weekday() + 1,
            teacher=request.user
        ).select_related('teacher').prefetch_related('schedules').distinct()
    
    # 为每个课程添加时间信息
    courses_with_schedule = []
    for course in today_courses:
        schedule = course.schedules.filter(weekday=today.weekday() + 1).first()
        if schedule:
            courses_with_schedule.append({
                'name': course.name,
                'classroom': schedule.classroom,
                'time_slot': f"{schedule.start_time.strftime('%H:%M')}-{schedule.end_time.strftime('%H:%M')}"
            })
    
    # 按时间排序
    courses_with_schedule.sort(key=lambda x: x['time_slot'])
    
    # 其他统计数据
    announcements = Announcement.objects.filter(
        is_active=True
    ).count()
    
    social_updates = 0
    
    activities = Activity.objects.filter(
        end_time__gte=timezone.now()
    ).count()
    
    # 计算GPA
    if request.user.role == 'student':
        enrollments = Enrollment.objects.filter(
            student=request.user,
            score__isnull=False
        )
        total_score = sum(enrollment.score * enrollment.course.credit for enrollment in enrollments)
        total_credits = sum(enrollment.course.credit for enrollment in enrollments)
        gpa = round(total_score / total_credits, 2) if total_credits > 0 else 0
    else:
        gpa = 0
    
    # 获取最近7天的消费数据
    end_date = timezone.now().date()
    start_date = end_date - timedelta(days=6)
    
    daily_consumption = CardConsumption.objects.filter(
        user=request.user,
        created_at__date__range=[start_date, end_date]
    ).annotate(
        date=TruncDate('created_at')
    ).values('date').annotate(
        total=Sum('amount')
    ).order_by('date')
    
    # 构建消费数据字典
    consumption_data = {}
    current_date = start_date
    while current_date <= end_date:
        consumption_data[current_date.strftime('%m-%d')] = 0
        current_date += timedelta(days=1)
    
    # 填充实际消费数据
    for item in daily_consumption:
        date_str = item['date'].strftime('%m-%d')
        consumption_data[date_str] = float(item['total'])
    
    # 计算本周总消费
    total_consumption = sum(consumption_data.values())
    
    # 获取课程统计数据
    if request.user.role == 'student':
        # 获取学生的选课记录
        enrollments = Enrollment.objects.filter(student=request.user).select_related('course')
        
        # 统计必修和选修课程数量
        required_courses = [e for e in enrollments if e.course.course_type == 'required']
        elective_courses = [e for e in enrollments if e.course.course_type == 'elective']
        required_course_count = len(required_courses)
        elective_course_count = len(elective_courses)
        total_courses = required_course_count + elective_course_count
        
        # 计算百分比
        required_course_percent = (required_course_count / total_courses * 100) if total_courses > 0 else 0
        elective_course_percent = (elective_course_count / total_courses * 100) if total_courses > 0 else 0
        
        # 计算学分
        completed_credits = sum(e.course.credit for e in enrollments if e.score)
        total_required_credits = 150  # 假设总学分要求是150
    else:
        # 教师用户显示其他统计数据
        required_course_count = 0
        elective_course_count = 0
        required_course_percent = 0
        elective_course_percent = 0
        completed_credits = 0
        total_required_credits = 0

    # 获取即将到来的考试
    today = timezone.now()
    if request.user.role == 'student':
        upcoming_exams = Exam.objects.filter(
            course__enrollments__student=request.user,
            date__gt=today
        ).select_related('course').order_by('date')[:5]  # 最近5个考试

        # 计算每个考试的倒计时天数
        for exam in upcoming_exams:
            exam.days_until = (exam.date.date() - today.date()).days
    else:
        upcoming_exams = []

    context = {
        'today_courses_count': today_courses_count,  # 添加今日课程数量
        'today_courses': courses_with_schedule,      # 课程列表
        'announcements': announcements,
        'social_updates': social_updates,
        'activities': activities,
        'gpa': gpa,
        'consumption_data': consumption_data,
        'total_consumption': round(total_consumption, 2),
        'required_course_count': required_course_count,
        'elective_course_count': elective_course_count,
        'required_course_percent': required_course_percent,
        'elective_course_percent': elective_course_percent,
        'completed_credits': completed_credits,
        'total_required_credits': total_required_credits,
        'upcoming_exams': upcoming_exams,
    }
    
    return render(request, 'academic/dashboard.html', context)

@login_required
def enroll_course(request, course_id):
    if request.method == 'POST':
        course = get_object_or_404(Course, id=course_id)
        # 检查是否已经选过这门课
        if not Enrollment.objects.filter(student=request.user, course=course).exists():
            # 检查课程容量
            current_enrolled = Enrollment.objects.filter(course=course).count()
            if current_enrolled < course.capacity:
                # 创建选课记录
                Enrollment.objects.create(student=request.user, course=course)
                
                # 创建课程安排记录，使用课程表中的信息
                Schedule.objects.create(
                    course=course,
                    weekday=course.weekday,
                    start_time=course.start_time,
                    end_time=course.end_time,
                    classroom=course.classroom
                )
                
                # 更新已选人数
                course.enrolled = current_enrolled + 1
                course.save()
                messages.success(request, f'成功选择课程：{course.name}')
            else:
                messages.error(request, '该课程已经达到容量上限')
        else:
            messages.error(request, '你已经选择了这门课程')
    
    return redirect('academic:course_list')

@login_required
def drop_course(request, course_id):
    if request.method == 'POST':
        course = get_object_or_404(Course, id=course_id)
        enrollment = get_object_or_404(Enrollment, student=request.user, course=course)
        
        # 删除该学生的课程安排记录
        Schedule.objects.filter(course=course).delete()
        
        # 删除选课记录
        enrollment.delete()
        
        # 更新已选人数
        current_enrolled = Enrollment.objects.filter(course=course).count()
        course.enrolled = current_enrolled
        course.save()
        
        messages.success(request, f'已退选课程：{course.name}')
    
    return redirect('academic:course_list')
  