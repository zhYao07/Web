# Generated by Django 4.2.17 on 2024-12-20 19:21

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ("campus_life", "0006_alter_lostfound_image"),
    ]

    operations = [
        migrations.AddField(
            model_name="activity",
            name="current_participants",
            field=models.IntegerField(default=0, verbose_name="当前参与人数"),
        ),
    ]
