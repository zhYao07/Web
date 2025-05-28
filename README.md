---
# 🌟 Campus Assistant 项目

📌 **cqupt web综合设计。基于 Django 的校园助手项目，包含选课、查询课表、校园活动、失物招领，公告，发信息等功能。**

---

## 📦 环境配置

请确保已安装 `Python`，然后使用 `pip` 安装 `Django`：

```bash
pip install django
```

⚠️ 运行时如果缺少其他依赖，请根据提示安装相应的库。

---

## 🚀 如何运行

### **1️⃣ 数据库配置**
- 在 **MySQL** 中创建 `campus_assistant` 数据库
- 将 `campus_assistant.sql` 文件导入数据库

### **2️⃣ 数据库迁移**
确保在 `campus_assistant/settings.py` 文件中正确配置数据库连接信息，然后执行：

```bash
python manage.py migrate
python manage.py makemigrations
```

### **3️⃣ 启动项目**
运行以下命令启动 Django 服务器：

```bash
python manage.py runserver
```

---

## 🎨 效果展示

### **🔐 登录界面**
![登录界面](https://github.com/user-attachments/assets/7398d412-1a84-4337-a31f-d446f68b7426)

### **🏠 首页**
![首页](https://github.com/user-attachments/assets/153e7fd6-1798-49ad-9e74-35bd919e4940)

### **📚 选课**
![选课](https://github.com/user-attachments/assets/64b5719d-aa05-4406-a40b-15a2d9fa8d12)

### **🎉 校园活动**
![校园活动](https://github.com/user-attachments/assets/ca9873f9-6fd4-432c-8649-8285c7890fa4)

### **🔍 失物招领**
![失物招领](https://github.com/user-attachments/assets/5d91c124-93bb-4a06-b07c-b894df858f03)
