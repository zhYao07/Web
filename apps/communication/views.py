from django.shortcuts import render, redirect, get_object_or_404
from django.contrib.auth.decorators import login_required
from django.contrib import messages
from django.db.models import Q
from django.urls import reverse
from .models import Message
from .forms import MessageForm, MessageReplyForm

@login_required
def message_list(request):
    # 获取当前选中的标签
    active_tab = request.GET.get('tab', 'received')
    
    if active_tab == 'sent':
        # 获取发送的消息
        messages_list = Message.objects.filter(sender=request.user).order_by('-created_at')
    else:
        # 获取收到的消息
        messages_list = Message.objects.filter(receiver=request.user).order_by('-created_at')
    
    context = {
        'messages_list': messages_list,
        'active_tab': active_tab
    }
    
    return render(request, 'communication/message_list.html', context)

@login_required
def message_create(request):
    if request.method == 'POST':
        form = MessageForm(request.POST)
        if form.is_valid():
            message = form.save(commit=False)
            message.sender = request.user
            message.save()
            messages.success(request, '消息发送成功！')
            return redirect('communication:message_list')
    else:
        form = MessageForm()
        form.fields['receiver'].queryset = form.fields['receiver'].queryset.exclude(id=request.user.id)
    
    return render(request, 'communication/message_form.html', {
        'form': form,
        'title': '发送新消息'
    })

@login_required
def message_reply(request, message_id):
    original_message = get_object_or_404(Message, id=message_id)
    if request.user != original_message.receiver:
        messages.error(request, '您没有权限回复此消息！')
        return redirect('communication:message_list')
    
    if request.method == 'POST':
        form = MessageReplyForm(request.POST)
        if form.is_valid():
            reply = form.save(commit=False)
            reply.sender = request.user
            reply.receiver = original_message.sender
            reply.save()
            messages.success(request, '回复发送成功！')
            return redirect('communication:message_list')
    else:
        form = MessageReplyForm()
    
    return render(request, 'communication/message_reply.html', {
        'form': form,
        'original_message': original_message
    })

@login_required
def message_detail(request, message_id):
    message = get_object_or_404(Message.objects.filter(
        Q(sender=request.user) | Q(receiver=request.user),
        id=message_id
    ))
    
    # 如果是接收者查看，标记为已读
    if request.user == message.receiver and not message.is_read:
        message.is_read = True
        message.save()
    
    return render(request, 'communication/message_detail.html', {
        'message': message
    })

@login_required
def message_delete(request, message_id):
    # 获取消息，确保只能删除自己发送或接收的消息
    message = get_object_or_404(Message.objects.filter(
        Q(sender=request.user) | Q(receiver=request.user),
        id=message_id
    ))
    
    if request.method == 'POST':
        # 记住当前标签页
        active_tab = 'sent' if message.sender == request.user else 'received'
        # 删除消息
        message.delete()
        messages.success(request, '消息已删除！')
        # 重定向时保持在当前标签页
        return redirect(f'{reverse("communication:message_list")}?tab={active_tab}')
    
    return redirect('communication:message_list') 