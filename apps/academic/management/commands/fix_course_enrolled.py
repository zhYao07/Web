from django.core.management.base import BaseCommand
from apps.academic.models import Course
from django.db.models import Count

class Command(BaseCommand):
    help = '修复课程的已选人数'

    def handle(self, *args, **options):
        courses = Course.objects.annotate(actual_enrolled=Count('enrollments'))
        updated = 0
        
        for course in courses:
            if course.enrolled != course.actual_enrolled:
                course.enrolled = course.actual_enrolled
                course.save()
                updated += 1
                
        self.stdout.write(
            self.style.SUCCESS(f'成功更新了 {updated} 个课程的已选人数')
        ) 