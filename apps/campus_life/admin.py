from django.contrib import admin
from .models import Announcement, LostFound, Activity, ActivityParticipant, CardConsumption

@admin.register(Announcement)
class AnnouncementAdmin(admin.ModelAdmin):
    list_display = ('title', 'author', 'created_at', 'is_active')
    list_filter = ('is_active', 'created_at')
    search_fields = ('title', 'content', 'author__username')

@admin.register(LostFound)
class LostFoundAdmin(admin.ModelAdmin):
    list_display = ('title', 'user', 'status', 'location', 'created_at')
    list_filter = ('status', 'created_at')
    search_fields = ('title', 'description', 'user__username')

@admin.register(Activity)
class ActivityAdmin(admin.ModelAdmin):
    list_display = ('title', 'organizer', 'location', 'start_time', 'end_time', 'current_participants', 'max_participants')
    list_filter = ('start_time', 'created_at')
    search_fields = ('title', 'description', 'organizer__username')

@admin.register(ActivityParticipant)
class ActivityParticipantAdmin(admin.ModelAdmin):
    list_display = ('activity', 'user', 'join_time')
    list_filter = ('join_time',)
    search_fields = ('activity__title', 'user__username')

@admin.register(CardConsumption)
class CardConsumptionAdmin(admin.ModelAdmin):
    list_display = ('user', 'amount', 'type', 'location', 'created_at')
    list_filter = ('type', 'created_at')
    search_fields = ('user__username', 'location', 'description') 