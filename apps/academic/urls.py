from django.urls import path
from . import views

app_name = 'academic'

urlpatterns = [
    # 课程列表和选课相关
    path('courses/', views.course_list, name='course_list'),
    path('courses/<int:course_id>/', views.course_detail, name='course_detail'),
    path('courses/<int:course_id>/enroll/', views.enroll_course, name='enroll_course'),
    path('courses/<int:course_id>/drop/', views.drop_course, name='drop_course'),
    
    # 课程管理（教师用）
    path('courses/create/', views.course_create, name='course_create'),
    
    # 课表
    path('schedule/', views.schedule_view, name='schedule'),
] 