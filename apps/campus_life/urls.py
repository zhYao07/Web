from django.urls import path
from . import views

app_name = 'campus_life'

urlpatterns = [
    # 公告相关URL
    path('announcements/', views.announcement_list, name='announcement_list'),
    path('announcements/create/', views.announcement_create, name='announcement_create'),
    path('announcements/<int:announcement_id>/update/', views.announcement_update, name='announcement_update'),
    path('announcements/<int:announcement_id>/delete/', views.announcement_delete, name='announcement_delete'),
    
    # 失物招领相关URL
    path('lost-found/', views.lost_found_list, name='lost_found_list'),
    path('lost-found/create/', views.lost_found_create, name='lost_found_create'),
    path('lost-found/<int:lost_found_id>/update/', views.lost_found_update, name='lost_found_update'),
    
    # 活动相关URL
    path('activities/', views.activity_list, name='activity_list'),
    path('activities/create/', views.activity_create, name='activity_create'),
    path('activities/<int:activity_id>/', views.activity_detail, name='activity_detail'),
    path('activities/<int:activity_id>/update/', views.activity_update, name='activity_update'),
    path('activities/<int:activity_id>/join/', views.activity_join, name='activity_join'),
] 