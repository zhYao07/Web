from django import forms
from .models import Announcement, LostFound, Activity

class AnnouncementForm(forms.ModelForm):
    class Meta:
        model = Announcement
        fields = ['title', 'content', 'is_active']

class LostFoundForm(forms.ModelForm):
    class Meta:
        model = LostFound
        fields = ['title', 'description', 'location', 'contact', 'status', 'image']
        widgets = {
            'description': forms.Textarea(attrs={'rows': 4}),
            'status': forms.Select(attrs={'class': 'form-select'}),
            'image': forms.FileInput(attrs={'class': 'form-control'})
        }

class ActivityForm(forms.ModelForm):
    class Meta:
        model = Activity
        fields = ['title', 'description', 'location', 'start_time', 'end_time', 'max_participants']
        widgets = {
            'start_time': forms.DateTimeInput(attrs={'type': 'datetime-local'}),
            'end_time': forms.DateTimeInput(attrs={'type': 'datetime-local'}),
        } 