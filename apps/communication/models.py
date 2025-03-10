from django.db import models
from apps.users.models import User

class Message(models.Model):
    sender = models.ForeignKey(User, on_delete=models.CASCADE, related_name='sent_messages')
    receiver = models.ForeignKey(User, on_delete=models.CASCADE, related_name='received_messages')
    content = models.TextField('消息内容')
    created_at = models.DateTimeField('发送时间', auto_now_add=True)
    is_read = models.BooleanField('是否已读', default=False)
    
    class Meta:
        db_table = 'messages'
        verbose_name = '私信'
        verbose_name_plural = verbose_name

class Comment(models.Model):
    user = models.ForeignKey(User, on_delete=models.CASCADE, related_name='comments')
    content = models.TextField('评论内容')
    created_at = models.DateTimeField('评论时间', auto_now_add=True)
    # 通用外键，可以关联到任何模型
    content_type = models.ForeignKey('contenttypes.ContentType', on_delete=models.CASCADE)
    object_id = models.PositiveIntegerField()
    
    class Meta:
        db_table = 'comments'
        verbose_name = '评论'
        verbose_name_plural = verbose_name 