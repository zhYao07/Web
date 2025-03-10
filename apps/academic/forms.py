from django import forms
from .models import Course, Schedule

class CourseForm(forms.ModelForm):
    class Meta:
        model = Course
        fields = [
            'name',
            'code',
            'description',
            'credit',
            'capacity',
            'college'
        ]
        widgets = {
            'description': forms.Textarea(attrs={'rows': 4}),
        }

class ScheduleForm(forms.ModelForm):
    class Meta:
        model = Schedule
        fields = [
            'weekday',
            'start_time',
            'end_time',
            'classroom'
        ]
        widgets = {
            'start_time': forms.TimeInput(attrs={'type': 'time'}),
            'end_time': forms.TimeInput(attrs={'type': 'time'}),
        } 