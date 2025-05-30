# Generated by Django 4.2.17 on 2024-12-18 19:45

from django.db import migrations, models
import django.db.models.deletion


class Migration(migrations.Migration):

    dependencies = [
        ("academic", "0002_alter_course_id_alter_enrollment_id_and_more"),
    ]

    operations = [
        migrations.CreateModel(
            name="Exam",
            fields=[
                (
                    "id",
                    models.BigAutoField(
                        auto_created=True,
                        primary_key=True,
                        serialize=False,
                        verbose_name="ID",
                    ),
                ),
                ("title", models.CharField(max_length=100, verbose_name="考试名称")),
                ("description", models.TextField(blank=True, verbose_name="考试说明")),
                ("date", models.DateTimeField(verbose_name="考试时间")),
                ("location", models.CharField(max_length=100, verbose_name="考试地点")),
                ("duration", models.IntegerField(verbose_name="考试时长(分钟)")),
                (
                    "created_at",
                    models.DateTimeField(auto_now_add=True, verbose_name="创建时间"),
                ),
                (
                    "updated_at",
                    models.DateTimeField(auto_now=True, verbose_name="更新时间"),
                ),
                (
                    "course",
                    models.ForeignKey(
                        on_delete=django.db.models.deletion.CASCADE,
                        related_name="exams",
                        to="academic.course",
                        verbose_name="课程",
                    ),
                ),
            ],
            options={
                "verbose_name": "考试",
                "verbose_name_plural": "考试",
                "ordering": ["date"],
            },
        ),
    ]
