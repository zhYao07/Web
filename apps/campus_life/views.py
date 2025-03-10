from django.shortcuts import render, get_object_or_404, redirect
from django.contrib.auth.decorators import login_required
from django.contrib import messages
from .models import Announcement, LostFound, Activity, ActivityParticipant
from .forms import AnnouncementForm, LostFoundForm, ActivityForm
from django.db.models import Q
from django.db import IntegrityError

# 公告相关视图
@login_required
def announcement_list(request):
    announcements = Announcement.objects.all().order_by('-created_at')
    return render(request, 'campus_life/announcement_list.html', {
        'announcements': announcements
    })

@login_required
def announcement_create(request):
    if request.user.role not in ['teacher', 'admin']:
        messages.error(request, '只有教师和管理员可以发布公告！')
        return redirect('campus_life:announcement_list')
        
    if request.method == 'POST':
        form = AnnouncementForm(request.POST)
        if form.is_valid():
            announcement = form.save(commit=False)
            announcement.author = request.user
            announcement.save()
            messages.success(request, '公告发布成功！')
            return redirect('campus_life:announcement_list')
    else:
        form = AnnouncementForm()
    
    return render(request, 'campus_life/announcement_form.html', {
        'form': form,
        'title': '发布公告'
    })

@login_required
def announcement_update(request, announcement_id):
    announcement = get_object_or_404(Announcement, id=announcement_id)
    if request.user != announcement.author and request.user.role != 'admin':
        messages.error(request, '您没有权限修改此公告！')
        return redirect('campus_life:announcement_list')
        
    if request.method == 'POST':
        form = AnnouncementForm(request.POST, instance=announcement)
        if form.is_valid():
            form.save()
            messages.success(request, '公告更新成功！')
            return redirect('campus_life:announcement_list')
    else:
        form = AnnouncementForm(instance=announcement)
    
    return render(request, 'campus_life/announcement_form.html', {
        'form': form,
        'title': '编辑公告'
    })

@login_required
def announcement_delete(request, announcement_id):
    announcement = get_object_or_404(Announcement, id=announcement_id)
    if request.user != announcement.author and request.user.role != 'admin':
        messages.error(request, '您没有权限删除此公告！')
        return redirect('campus_life:announcement_list')
        
    if request.method == 'POST':
        announcement.delete()
        messages.success(request, '公告删除成功！')
    return redirect('campus_life:announcement_list')

# 失物招领相关视图
@login_required
def lost_found_list(request):
    # 获取未完成的物品（状态不为completed）
    lost_founds = LostFound.objects.exclude(status='completed').order_by('-created_at')
    
    # 获取搜索参数
    search_query = request.GET.get('search', '')
    if search_query:
        lost_founds = lost_founds.filter(
            Q(title__icontains=search_query) |
            Q(description__icontains=search_query) |
            Q(location__icontains=search_query)
        )
    
    context = {
        'lost_founds': lost_founds,
        'search_query': search_query
    }
    
    return render(request, 'campus_life/lost_found_list.html', context)

@login_required
def lost_found_create(request):
    if request.method == 'POST':
        form = LostFoundForm(request.POST, request.FILES)
        if form.is_valid():
            lost_found = form.save(commit=False)
            lost_found.user = request.user
            lost_found.save()
            messages.success(request, '信息发布成功！')
            return redirect('campus_life:lost_found_list')
    else:
        form = LostFoundForm()
    
    return render(request, 'campus_life/lost_found_form.html', {
        'form': form,
        'title': '发布失物招领'
    })

@login_required
def lost_found_update(request, lost_found_id):
    lost_found = get_object_or_404(LostFound, id=lost_found_id)
    if request.user != lost_found.user:
        messages.error(request, '您没有权限修改此信息！')
        return redirect('campus_life:lost_found_list')
        
    if request.method == 'POST':
        form = LostFoundForm(request.POST, request.FILES, instance=lost_found)
        if form.is_valid():
            form.save()
            messages.success(request, '信息更新成功！')
            return redirect('campus_life:lost_found_list')
    else:
        form = LostFoundForm(instance=lost_found)
    
    return render(request, 'campus_life/lost_found_form.html', {
        'form': form,
        'title': '更新失物招领'
    })

# 活动相关视图
@login_required
def activity_list(request):
    # 获取所有活动并按创建时间倒序排序
    activities = Activity.objects.all().order_by('-created_at')
    
    # 不需要手动设置 is_full，因为已经在模型中定义了 @property
    return render(request, 'campus_life/activity_list.html', {
        'activities': activities
    })

@login_required
def activity_detail(request, activity_id):
    activity = get_object_or_404(Activity, id=activity_id)
    
    # 检查当前用户是否已参加
    has_joined = ActivityParticipant.objects.filter(
        activity=activity,
        user=request.user
    ).exists()
    
    context = {
        'activity': activity,
        'has_joined': has_joined,
    }
    
    return render(request, 'campus_life/activity_detail.html', context)

@login_required
def activity_create(request):
    if request.method == 'POST':
        form = ActivityForm(request.POST)
        if form.is_valid():
            activity = form.save(commit=False)
            activity.organizer = request.user
            activity.save()
            messages.success(request, '活动创建成功！')
            return redirect('campus_life:activity_list')
    else:
        form = ActivityForm()
    
    return render(request, 'campus_life/activity_form.html', {
        'form': form,
        'title': '创建活动'
    })

@login_required
def activity_update(request, activity_id):
    activity = get_object_or_404(Activity, id=activity_id)
    if request.user != activity.organizer:
        messages.error(request, '您没有权限修改此活动！')
        return redirect('campus_life:activity_list')
        
    if request.method == 'POST':
        form = ActivityForm(request.POST, instance=activity)
        if form.is_valid():
            form.save()
            messages.success(request, '活动更新成功！')
            return redirect('campus_life:activity_list')
    else:
        form = ActivityForm(instance=activity)
    
    return render(request, 'campus_life/activity_form.html', {
        'form': form,
        'title': '编辑活动'
    })

@login_required
def activity_join(request, activity_id):
    activity = get_object_or_404(Activity, id=activity_id)
    
    # 检查是否已经参加
    if ActivityParticipant.objects.filter(activity=activity, user=request.user).exists():
        messages.error(request, '您已经参加过这个活动了！')
        return redirect('campus_life:activity_detail', activity_id=activity_id)
    
    # 检查是否已满
    if activity.current_participants >= activity.max_participants:
        messages.error(request, '抱歉，活动人数已满！')
        return redirect('campus_life:activity_detail', activity_id=activity_id)
    
    try:
        # 创建参与记录
        ActivityParticipant.objects.create(activity=activity, user=request.user)
        
        # 增加参与人数
        activity.current_participants += 1
        activity.save()
        
        messages.success(request, '成功加入活动！')
    except IntegrityError:
        messages.error(request, '您已经参加过这个活动了！')
    
    return redirect('campus_life:activity_detail', activity_id=activity_id) 