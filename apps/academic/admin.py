from django.contrib import admin
from .models import Course, Schedule, Enrollment, Exam

@admin.register(Course)
class CourseAdmin(admin.ModelAdmin):
    list_display = ('name', 'code', 'teacher', 'credit', 'capacity', 'enrolled', 'college', 'course_type')
    list_filter = ('college', 'course_type', 'teacher')
    search_fields = ('name', 'code', 'teacher__username')
    ordering = ('-id',)

@admin.register(Schedule)
class ScheduleAdmin(admin.ModelAdmin):
    list_display = ('course', 'weekday', 'start_time', 'end_time', 'classroom')
    list_filter = ('weekday', 'classroom')
    search_fields = ('course__name', 'classroom')

@admin.register(Enrollment)
class EnrollmentAdmin(admin.ModelAdmin):
    list_display = ('student', 'course', 'score', 'created_at')
    list_filter = ('course', 'created_at')
    search_fields = ('student__username', 'course__name')

@admin.register(Exam)
class ExamAdmin(admin.ModelAdmin):
    list_display = ('title', 'course', 'date', 'location', 'duration')
    list_filter = ('course', 'date')
    search_fields = ('title', 'course__name', 'location')
    date_hierarchy = 'date' 