from django.urls import path
from . import views

app_name = 'communication'

urlpatterns = [
    path('messages/', views.message_list, name='message_list'),
    path('messages/create/', views.message_create, name='message_create'),
    path('messages/<int:message_id>/', views.message_detail, name='message_detail'),
    path('messages/<int:message_id>/reply/', views.message_reply, name='message_reply'),
    path('messages/<int:message_id>/delete/', views.message_delete, name='message_delete'),
] 