from django.shortcuts import render, redirect
from django.contrib.auth import authenticate, login, logout
from django.contrib import messages
from django.contrib.auth.decorators import login_required
from .forms import UserRegistrationForm, UserLoginForm
from .models import User

def login_view(request):
    if request.user.is_authenticated:
        return redirect('dashboard')
        
    if request.method == 'POST':
        username = request.POST.get('username')
        password = request.POST.get('password')
        
        try:
            # 检查用户是否存在
            user_exists = User.objects.filter(username=username).exists()
            if not user_exists:
                messages.error(request, '用户不存在！')
                return render(request, 'users/login.html')
                
            user = authenticate(request, username=username, password=password)
            
            if user is not None:
                if user.is_active:
                    login(request, user)
                    messages.success(request, f'欢迎回来，{user.username}！')
                    return redirect('dashboard')
                else:
                    messages.error(request, '账户未激活！')
            else:
                messages.error(request, '密码错误！')
        except Exception as e:
            messages.error(request, f'登录过程中出现错误：{str(e)}')
    
    return render(request, 'users/login.html')

def register_view(request):
    if request.user.is_authenticated:
        return redirect('dashboard')
        
    if request.method == 'POST':
        form = UserRegistrationForm(request.POST)
        print("POST data:", request.POST)  # 打印POST数据
        if form.is_valid():
            try:
                # 创建用户但不保存
                user = form.save(commit=False)
                # 设置角色（直接从POST数据获取）
                user.role = request.POST.get('role', 'student')
                user.student_id = form.cleaned_data.get('student_id', '')
                user.phone = form.cleaned_data.get('phone', '')
                user.is_active = True
                # 保存用户
                user.save()
                
                # 尝试登录
                login_user = authenticate(
                    username=form.cleaned_data['username'],
                    password=form.cleaned_data['password1']
                )
                
                if login_user is not None:
                    login(request, login_user)
                    messages.success(request, '注册成功！')
                    return redirect('dashboard')
                else:
                    messages.error(request, '注册成功但登录失败，请尝试直接登录。')
                    return redirect('users:login')
                    
            except Exception as e:
                print("Registration error:", str(e))  # 打印错误信息
                messages.error(request, f'注册过程中出现错误：{str(e)}')
        else:
            print("Form errors:", form.errors)  # 打印表单错误
            for field, errors in form.errors.items():
                for error in errors:
                    messages.error(request, f'{field}: {error}')
    else:
        form = UserRegistrationForm()
    
    return render(request, 'users/register.html', {
        'form': form
    })

@login_required
def logout_view(request):
    logout(request)
    messages.success(request, '您已成功退出登录！')
    return redirect('users:login')
 