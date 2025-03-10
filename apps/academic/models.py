from django.db import models
from django.utils.timezone import now
from apps.users.models import User

# 将选项常量移到模型外部
WEEKDAY_CHOICES = (
    (1, '周一'),
    (2, '周二'),
    (3, '周三'),
    (4, '周四'),
    (5, '周五'),
    (6, '周六'),
    (7, '周日'),
)

TIME_SLOTS = (
    ('1', '第一节\n8:00-9:40'),
    ('2', '第二节\n10:00-11:40'),
    ('3', '第三节\n14:00-15:40'),
    ('4', '第四节\n16:00-17:40'),
    ('5', '第五节\n19:00-20:40'),
)

class Course(models.Model):
    COLLEGE_CHOICES = (
        ('computer', '计算机科学与技术学院'),
        ('communication', '通信与信息工程学院'),
        ('automation', '自动化学院'),
        ('economics', '经济管理学院'),
        ('science', '理学院'),
        ('foreign', '外国语学院'),
    )
    
    COURSE_TYPE_CHOICES = (
        ('required', '必修课'),
        ('elective', '选修课'),
    )
    
    name = models.CharField('课程名称', max_length=100)
    code = models.CharField('课程代码', max_length=20)
    teacher = models.ForeignKey(User, on_delete=models.CASCADE, related_name='courses')
    description = models.TextField('课程描述', blank=True)
    credit = models.IntegerField('学分')
    capacity = models.IntegerField('容量')
    enrolled = models.IntegerField('已选人数', default=0)
    college = models.CharField('开设学院', max_length=50, choices=COLLEGE_CHOICES, default='computer')
    weekday = models.IntegerField('上课日期', choices=WEEKDAY_CHOICES)
    start_time = models.TimeField('上课时间', default=now)
    end_time = models.TimeField('下课时间', default=now)
    classroom = models.CharField('教室', max_length=50, default='待定')
    course_type = models.CharField('课程类型', max_length=20, choices=COURSE_TYPE_CHOICES, default='required')
    
    def __str__(self):
        return f"{self.name} ({self.code})"
    
    class Meta:
        verbose_name = '课程'
        verbose_name_plural = verbose_name

    @property
    def is_full(self):
        return self.enrolled >= self.capacity

class Schedule(models.Model):
    course = models.ForeignKey(Course, on_delete=models.CASCADE, related_name='schedules')
    weekday = models.IntegerField('星期', choices=WEEKDAY_CHOICES)
    start_time = models.TimeField('开始时间')
    end_time = models.TimeField('结束时间')
    classroom = models.CharField('教室', max_length=50)
    
    def __str__(self):
        return f"{self.course.name} - {self.get_weekday_display()} {self.start_time.strftime('%H:%M')}-{self.end_time.strftime('%H:%M')}"
    
    class Meta:
        db_table = 'course_schedules'
        verbose_name = '课程安排'
        verbose_name_plural = verbose_name

class Enrollment(models.Model):
    student = models.ForeignKey(User, on_delete=models.CASCADE, related_name='enrollments')
    course = models.ForeignKey(Course, on_delete=models.CASCADE, related_name='enrollments')
    score = models.FloatField('成绩', null=True, blank=True)
    created_at = models.DateTimeField('选课时间', auto_now_add=True)
    
    def __str__(self):
        return f"{self.student.username} - {self.course.name}"
    
    class Meta:
        db_table = 'enrollments'
        verbose_name = '选课记录'
        verbose_name_plural = verbose_name
        unique_together = ('student', 'course') 

class Exam(models.Model):
    course = models.ForeignKey(
        Course,
        on_delete=models.CASCADE,
        related_name='exams',
        verbose_name='课程'
    )
    title = models.CharField('考试名称', max_length=100)
    description = models.TextField('考试说明', blank=True)
    date = models.DateTimeField('考试时间')
    location = models.CharField('考试地点', max_length=100)
    duration = models.IntegerField('考试时长(分钟)')
    created_at = models.DateTimeField('创建时间', auto_now_add=True)
    updated_at = models.DateTimeField('更新时间', auto_now=True)

    def __str__(self):
        return f"{self.course.name} - {self.title}"
    
    class Meta:
        verbose_name = '考试'
        verbose_name_plural = '考试'
        ordering = ['date']
  