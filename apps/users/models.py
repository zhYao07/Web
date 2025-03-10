from django.db import models
from django.contrib.auth.models import AbstractUser

class User(AbstractUser):
    ROLE_CHOICES = (
        ('student', '学生'),
        ('admin', '管理员'),
    )
    
    role = models.CharField(
        '角色',
        max_length=20,
        choices=ROLE_CHOICES,
        default='student'
    )
    student_id = models.CharField(
        '学号',
        max_length=20,
        blank=True,
        null=True
    )
    phone = models.CharField(
        '手机号',
        max_length=11,
        blank=True,
        null=True
    )
    
    class Meta:
        db_table = 'users'
        verbose_name = '用户'
        verbose_name_plural = verbose_name 