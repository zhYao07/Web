from django.db import models
from apps.users.models import User

class Announcement(models.Model):
    title = models.CharField('标题', max_length=200)
    content = models.TextField('内容')
    author = models.ForeignKey(User, on_delete=models.CASCADE, related_name='announcements')
    created_at = models.DateTimeField('发布时间', auto_now_add=True)
    updated_at = models.DateTimeField('更新时间', auto_now=True)
    is_active = models.BooleanField('是否有效', default=True)
    
    class Meta:
        db_table = 'announcements'
        verbose_name = '公告'
        verbose_name_plural = verbose_name

class LostFound(models.Model):
    STATUS_CHOICES = (
        ('lost', '丢失'),
        ('claimed', '认领'),
        ('completed', '已完成')
    )
    
    title = models.CharField('标题', max_length=100)
    description = models.TextField('描述')
    location = models.CharField('地点', max_length=100)
    contact = models.CharField('联系方式', max_length=100)
    user = models.ForeignKey(User, on_delete=models.CASCADE, related_name='lost_founds')
    status = models.CharField('状态', max_length=20, choices=STATUS_CHOICES, default='lost')
    image = models.ImageField('物品图片', upload_to='lost_found', blank=True, null=True)
    created_at = models.DateTimeField('创建时间', auto_now_add=True)
    updated_at = models.DateTimeField('更新时间', auto_now=True)
    
    class Meta:
        verbose_name = '失物招领'
        verbose_name_plural = verbose_name

class Activity(models.Model):
    title = models.CharField('活动名称', max_length=200)
    description = models.TextField('活动描述')
    organizer = models.ForeignKey(User, on_delete=models.CASCADE, related_name='organized_activities')
    location = models.CharField('活动地点', max_length=200)
    start_time = models.DateTimeField('开始时间')
    end_time = models.DateTimeField('结束时间')
    max_participants = models.IntegerField('最大参与人数')
    current_participants = models.IntegerField('当前参与人数', default=0)
    created_at = models.DateTimeField('创建时间', auto_now_add=True)
    participants = models.ManyToManyField(
        User,
        through='ActivityParticipant',
        related_name='participated_activities',
        verbose_name='参与者'
    )

    class Meta:
        verbose_name = '活动'
        verbose_name_plural = verbose_name
        ordering = ['-created_at']

    def __str__(self):
        return self.title

    @property
    def is_full(self):
        return self.current_participants >= self.max_participants

class ActivityParticipant(models.Model):
    activity = models.ForeignKey(Activity, on_delete=models.CASCADE)
    user = models.ForeignKey(User, on_delete=models.CASCADE)
    join_time = models.DateTimeField('参加时间', auto_now_add=True)

    class Meta:
        unique_together = ('activity', 'user')  # 确保用户不能重复参加同一活动
        verbose_name = '活动参与者'
        verbose_name_plural = verbose_name

class CardConsumption(models.Model):
    CONSUMPTION_TYPES = (
        ('canteen', '食堂'),
        ('shop', '超市'),
        ('print', '打印'),
        ('other', '其他'),
    )
    
    user = models.ForeignKey(User, on_delete=models.CASCADE, related_name='consumptions')
    amount = models.DecimalField('消费金额', max_digits=8, decimal_places=2)
    type = models.CharField('消费类型', max_length=20, choices=CONSUMPTION_TYPES)
    location = models.CharField('消费地点', max_length=100)
    created_at = models.DateTimeField('消费时间', auto_now_add=True)
    description = models.CharField('消费说明', max_length=200, blank=True)

    class Meta:
        db_table = 'card_consumptions'
        verbose_name = '校园卡消费'
        verbose_name_plural = verbose_name
        ordering = ['-created_at']

    def __str__(self):
        return f"{self.user.username} - {self.amount} - {self.get_type_display()}" 