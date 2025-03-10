# Generated by Django 4.2.17 on 2024-12-18 19:56

from django.conf import settings
from django.db import migrations, models
import django.db.models.deletion


class Migration(migrations.Migration):

    dependencies = [
        migrations.swappable_dependency(settings.AUTH_USER_MODEL),
        ("campus_life", "0002_alter_activity_id_alter_announcement_id_and_more"),
    ]

    operations = [
        migrations.CreateModel(
            name="CardConsumption",
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
                (
                    "amount",
                    models.DecimalField(
                        decimal_places=2, max_digits=8, verbose_name="消费金额"
                    ),
                ),
                (
                    "type",
                    models.CharField(
                        choices=[
                            ("canteen", "食堂"),
                            ("shop", "超市"),
                            ("print", "打印"),
                            ("other", "其他"),
                        ],
                        max_length=20,
                        verbose_name="消费类型",
                    ),
                ),
                ("location", models.CharField(max_length=100, verbose_name="消费地点")),
                (
                    "created_at",
                    models.DateTimeField(auto_now_add=True, verbose_name="消费时间"),
                ),
                (
                    "description",
                    models.CharField(blank=True, max_length=200, verbose_name="消费说明"),
                ),
                (
                    "user",
                    models.ForeignKey(
                        on_delete=django.db.models.deletion.CASCADE,
                        related_name="consumptions",
                        to=settings.AUTH_USER_MODEL,
                    ),
                ),
            ],
            options={
                "verbose_name": "校园卡消费",
                "verbose_name_plural": "校园卡消费",
                "db_table": "card_consumptions",
                "ordering": ["-created_at"],
            },
        ),
    ]
