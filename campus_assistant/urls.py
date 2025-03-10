from django.contrib import admin
from django.urls import path, include
from django.contrib.auth.decorators import login_required
from apps.academic.views import dashboard
from django.conf import settings
from django.conf.urls.static import static

urlpatterns = [
    path('admin/', admin.site.urls),
    path('', include('apps.users.urls')),
    path('dashboard/', login_required(dashboard), name='dashboard'),
    path('academic/', include('apps.academic.urls', namespace='academic')),
    path('campus-life/', include('apps.campus_life.urls')),
    path('communication/', include('apps.communication.urls')),
] + static(settings.MEDIA_URL, document_root=settings.MEDIA_ROOT) 