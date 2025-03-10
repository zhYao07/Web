/*
 Navicat Premium Data Transfer

 Source Server         : Shiyan
 Source Server Type    : MySQL
 Source Server Version : 80022
 Source Host           : localhost:3306
 Source Schema         : campus_assistant

 Target Server Type    : MySQL
 Target Server Version : 80022
 File Encoding         : 65001

 Date: 23/12/2024 19:13:27
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for academic_course
-- ----------------------------
DROP TABLE IF EXISTS `academic_course`;
CREATE TABLE `academic_course`  (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `code` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `description` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `credit` int NOT NULL,
  `capacity` int NOT NULL,
  `teacher_id` bigint NOT NULL,
  `college` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `enrolled` int NOT NULL,
  `weekday` int NOT NULL,
  `classroom` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `end_time` time(6) NOT NULL,
  `start_time` time(6) NOT NULL,
  `course_type` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `courses_teacher_id_79a070ce_fk_users_id`(`teacher_id` ASC) USING BTREE,
  CONSTRAINT `courses_teacher_id_79a070ce_fk_users_id` FOREIGN KEY (`teacher_id`) REFERENCES `users` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 100 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of academic_course
-- ----------------------------
INSERT INTO `academic_course` VALUES (1, '高等数学', 'MATH101', '本课程介绍微积分基础知识', 4, 50, 2, 'computer', 5, 1, '2217', '09:40:00.000000', '08:00:00.000000', 'required');
INSERT INTO `academic_course` VALUES (2, '大学物理', 'PHYS101', '物理学基础课程', 3, 40, 2, 'computer', 4, 2, '2210', '11:40:00.000000', '10:00:00.000000', 'required');
INSERT INTO `academic_course` VALUES (3, '程序设计', 'CS101', '计算机编程入门', 4, 45, 3, 'computer', 4, 5, 'B517', '11:40:00.000000', '10:00:00.000000', 'required');
INSERT INTO `academic_course` VALUES (4, '数据结构', 'CS201', '数据结构与算法基础', 4, 35, 3, 'computer', 3, 4, '2310', '17:40:00.000000', '16:00:00.000000', 'required');

-- ----------------------------
-- Table structure for academic_exam
-- ----------------------------
DROP TABLE IF EXISTS `academic_exam`;
CREATE TABLE `academic_exam`  (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `title` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `description` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `date` datetime(6) NOT NULL,
  `location` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `duration` int NOT NULL,
  `created_at` datetime(6) NOT NULL,
  `updated_at` datetime(6) NOT NULL,
  `course_id` bigint NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `academic_exam_course_id_d64898bf_fk_courses_id`(`course_id` ASC) USING BTREE,
  CONSTRAINT `academic_exam_course_id_d64898bf_fk_courses_id` FOREIGN KEY (`course_id`) REFERENCES `academic_course` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 4 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of academic_exam
-- ----------------------------
INSERT INTO `academic_exam` VALUES (1, '期中考试', '本学期期中考试', '2024-12-30 09:00:00.000000', '教学楼A101', 120, '2024-12-18 19:46:20.000000', '2024-12-18 19:46:20.000000', 1);
INSERT INTO `academic_exam` VALUES (2, '期末考试', '本学期期末考试', '2025-01-15 14:00:00.000000', '教学楼B202', 150, '2024-12-18 19:46:20.000000', '2024-12-18 19:46:20.000000', 2);
INSERT INTO `academic_exam` VALUES (3, '阶段测试', '第一单元测试', '2024-12-25 10:00:00.000000', '教学楼C303', 90, '2024-12-18 19:46:20.000000', '2024-12-18 19:46:20.000000', 3);

-- ----------------------------
-- Table structure for announcements
-- ----------------------------
DROP TABLE IF EXISTS `announcements`;
CREATE TABLE `announcements`  (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `title` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `content` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` datetime(6) NOT NULL,
  `updated_at` datetime(6) NOT NULL,
  `is_active` tinyint(1) NOT NULL,
  `author_id` bigint NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `announcements_author_id_f03fe4c4_fk_users_id`(`author_id` ASC) USING BTREE,
  CONSTRAINT `announcements_author_id_f03fe4c4_fk_users_id` FOREIGN KEY (`author_id`) REFERENCES `users` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 101 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of announcements
-- ----------------------------
INSERT INTO `announcements` VALUES (1, '期末考试安排', '本学期期末考试将于2024年1月8日开始，请同学们做好准备。', '2024-12-18 00:10:28.000000', '2024-12-18 00:10:28.000000', 1, 2);
INSERT INTO `announcements` VALUES (2, '教务系统维护通知', '系统将于本周六进行例行维护，请提前处理相关事务。', '2024-12-18 00:10:28.000000', '2024-12-18 00:10:28.000000', 1, 1);
INSERT INTO `announcements` VALUES (3, '图书馆开放时间调整', '寒假期间图书馆开放时间调整为9:00-17:00。', '2024-12-18 00:10:28.000000', '2024-12-18 00:10:28.000000', 1, 1);

-- ----------------------------
-- Table structure for auth_group
-- ----------------------------
DROP TABLE IF EXISTS `auth_group`;
CREATE TABLE `auth_group`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(150) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `name`(`name` ASC) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of auth_group
-- ----------------------------

-- ----------------------------
-- Table structure for auth_group_permissions
-- ----------------------------
DROP TABLE IF EXISTS `auth_group_permissions`;
CREATE TABLE `auth_group_permissions`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `group_id` int NOT NULL,
  `permission_id` int NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `auth_group_permissions_group_id_permission_id_0cd325b0_uniq`(`group_id` ASC, `permission_id` ASC) USING BTREE,
  INDEX `auth_group_permissio_permission_id_84c5c92e_fk_auth_perm`(`permission_id` ASC) USING BTREE,
  CONSTRAINT `auth_group_permissio_permission_id_84c5c92e_fk_auth_perm` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `auth_group_permissions_group_id_b120cbf9_fk_auth_group_id` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of auth_group_permissions
-- ----------------------------

-- ----------------------------
-- Table structure for auth_permission
-- ----------------------------
DROP TABLE IF EXISTS `auth_permission`;
CREATE TABLE `auth_permission`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `content_type_id` int NOT NULL,
  `codename` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `auth_permission_content_type_id_codename_01ab375a_uniq`(`content_type_id` ASC, `codename` ASC) USING BTREE,
  CONSTRAINT `auth_permission_content_type_id_2f476e4b_fk_django_co` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 69 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of auth_permission
-- ----------------------------
INSERT INTO `auth_permission` VALUES (1, 'Can add log entry', 1, 'add_logentry');
INSERT INTO `auth_permission` VALUES (2, 'Can change log entry', 1, 'change_logentry');
INSERT INTO `auth_permission` VALUES (3, 'Can delete log entry', 1, 'delete_logentry');
INSERT INTO `auth_permission` VALUES (4, 'Can view log entry', 1, 'view_logentry');
INSERT INTO `auth_permission` VALUES (5, 'Can add permission', 2, 'add_permission');
INSERT INTO `auth_permission` VALUES (6, 'Can change permission', 2, 'change_permission');
INSERT INTO `auth_permission` VALUES (7, 'Can delete permission', 2, 'delete_permission');
INSERT INTO `auth_permission` VALUES (8, 'Can view permission', 2, 'view_permission');
INSERT INTO `auth_permission` VALUES (9, 'Can add group', 3, 'add_group');
INSERT INTO `auth_permission` VALUES (10, 'Can change group', 3, 'change_group');
INSERT INTO `auth_permission` VALUES (11, 'Can delete group', 3, 'delete_group');
INSERT INTO `auth_permission` VALUES (12, 'Can view group', 3, 'view_group');
INSERT INTO `auth_permission` VALUES (13, 'Can add content type', 4, 'add_contenttype');
INSERT INTO `auth_permission` VALUES (14, 'Can change content type', 4, 'change_contenttype');
INSERT INTO `auth_permission` VALUES (15, 'Can delete content type', 4, 'delete_contenttype');
INSERT INTO `auth_permission` VALUES (16, 'Can view content type', 4, 'view_contenttype');
INSERT INTO `auth_permission` VALUES (17, 'Can add session', 5, 'add_session');
INSERT INTO `auth_permission` VALUES (18, 'Can change session', 5, 'change_session');
INSERT INTO `auth_permission` VALUES (19, 'Can delete session', 5, 'delete_session');
INSERT INTO `auth_permission` VALUES (20, 'Can view session', 5, 'view_session');
INSERT INTO `auth_permission` VALUES (21, 'Can add 用户', 6, 'add_user');
INSERT INTO `auth_permission` VALUES (22, 'Can change 用户', 6, 'change_user');
INSERT INTO `auth_permission` VALUES (23, 'Can delete 用户', 6, 'delete_user');
INSERT INTO `auth_permission` VALUES (24, 'Can view 用户', 6, 'view_user');
INSERT INTO `auth_permission` VALUES (25, 'Can add 课程', 7, 'add_course');
INSERT INTO `auth_permission` VALUES (26, 'Can change 课程', 7, 'change_course');
INSERT INTO `auth_permission` VALUES (27, 'Can delete 课程', 7, 'delete_course');
INSERT INTO `auth_permission` VALUES (28, 'Can view 课程', 7, 'view_course');
INSERT INTO `auth_permission` VALUES (29, 'Can add 课程安排', 8, 'add_schedule');
INSERT INTO `auth_permission` VALUES (30, 'Can change 课程安排', 8, 'change_schedule');
INSERT INTO `auth_permission` VALUES (31, 'Can delete 课程安排', 8, 'delete_schedule');
INSERT INTO `auth_permission` VALUES (32, 'Can view 课程安排', 8, 'view_schedule');
INSERT INTO `auth_permission` VALUES (33, 'Can add 选课记录', 9, 'add_enrollment');
INSERT INTO `auth_permission` VALUES (34, 'Can change 选课记录', 9, 'change_enrollment');
INSERT INTO `auth_permission` VALUES (35, 'Can delete 选课记录', 9, 'delete_enrollment');
INSERT INTO `auth_permission` VALUES (36, 'Can view 选课记录', 9, 'view_enrollment');
INSERT INTO `auth_permission` VALUES (37, 'Can add 失物招领', 10, 'add_lostfound');
INSERT INTO `auth_permission` VALUES (38, 'Can change 失物招领', 10, 'change_lostfound');
INSERT INTO `auth_permission` VALUES (39, 'Can delete 失物招领', 10, 'delete_lostfound');
INSERT INTO `auth_permission` VALUES (40, 'Can view 失物招领', 10, 'view_lostfound');
INSERT INTO `auth_permission` VALUES (41, 'Can add 公告', 11, 'add_announcement');
INSERT INTO `auth_permission` VALUES (42, 'Can change 公告', 11, 'change_announcement');
INSERT INTO `auth_permission` VALUES (43, 'Can delete 公告', 11, 'delete_announcement');
INSERT INTO `auth_permission` VALUES (44, 'Can view 公告', 11, 'view_announcement');
INSERT INTO `auth_permission` VALUES (45, 'Can add 校园活动', 12, 'add_activity');
INSERT INTO `auth_permission` VALUES (46, 'Can change 校园活动', 12, 'change_activity');
INSERT INTO `auth_permission` VALUES (47, 'Can delete 校园活动', 12, 'delete_activity');
INSERT INTO `auth_permission` VALUES (48, 'Can view 校园活动', 12, 'view_activity');
INSERT INTO `auth_permission` VALUES (49, 'Can add 私信', 13, 'add_message');
INSERT INTO `auth_permission` VALUES (50, 'Can change 私信', 13, 'change_message');
INSERT INTO `auth_permission` VALUES (51, 'Can delete 私信', 13, 'delete_message');
INSERT INTO `auth_permission` VALUES (52, 'Can view 私信', 13, 'view_message');
INSERT INTO `auth_permission` VALUES (53, 'Can add 评论', 14, 'add_comment');
INSERT INTO `auth_permission` VALUES (54, 'Can change 评论', 14, 'change_comment');
INSERT INTO `auth_permission` VALUES (55, 'Can delete 评论', 14, 'delete_comment');
INSERT INTO `auth_permission` VALUES (56, 'Can view 评论', 14, 'view_comment');
INSERT INTO `auth_permission` VALUES (57, 'Can add 考试', 15, 'add_exam');
INSERT INTO `auth_permission` VALUES (58, 'Can change 考试', 15, 'change_exam');
INSERT INTO `auth_permission` VALUES (59, 'Can delete 考试', 15, 'delete_exam');
INSERT INTO `auth_permission` VALUES (60, 'Can view 考试', 15, 'view_exam');
INSERT INTO `auth_permission` VALUES (61, 'Can add 校园卡消费', 16, 'add_cardconsumption');
INSERT INTO `auth_permission` VALUES (62, 'Can change 校园卡消费', 16, 'change_cardconsumption');
INSERT INTO `auth_permission` VALUES (63, 'Can delete 校园卡消费', 16, 'delete_cardconsumption');
INSERT INTO `auth_permission` VALUES (64, 'Can view 校园卡消费', 16, 'view_cardconsumption');
INSERT INTO `auth_permission` VALUES (65, 'Can add 活动参与者', 17, 'add_activityparticipant');
INSERT INTO `auth_permission` VALUES (66, 'Can change 活动参与者', 17, 'change_activityparticipant');
INSERT INTO `auth_permission` VALUES (67, 'Can delete 活动参与者', 17, 'delete_activityparticipant');
INSERT INTO `auth_permission` VALUES (68, 'Can view 活动参与者', 17, 'view_activityparticipant');

-- ----------------------------
-- Table structure for campus_life_activity
-- ----------------------------
DROP TABLE IF EXISTS `campus_life_activity`;
CREATE TABLE `campus_life_activity`  (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `title` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `description` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `location` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `start_time` datetime(6) NOT NULL,
  `end_time` datetime(6) NOT NULL,
  `max_participants` int NOT NULL,
  `created_at` datetime(6) NOT NULL,
  `organizer_id` bigint NOT NULL,
  `current_participants` int NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `activities_organizer_id_4820101e_fk_users_id`(`organizer_id` ASC) USING BTREE,
  CONSTRAINT `activities_organizer_id_4820101e_fk_users_id` FOREIGN KEY (`organizer_id`) REFERENCES `users` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 101 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of campus_life_activity
-- ----------------------------
INSERT INTO `campus_life_activity` VALUES (1, '迎新晚会', '2024年迎新晚会，欢迎新同学参加', '大礼堂', '2024-01-01 19:00:00.000000', '2025-01-01 21:30:00.000000', 500, '2024-12-18 00:10:28.000000', 1, 3);
INSERT INTO `campus_life_activity` VALUES (2, '编程竞赛', '第三届校园编程大赛', '计算机楼', '2024-01-15 09:00:00.000000', '2025-01-15 17:00:00.000000', 100, '2024-12-18 00:10:28.000000', 3, 8);
INSERT INTO `campus_life_activity` VALUES (3, '读书分享会', '主题：如何高效学习', '图书馆报告厅', '2024-01-20 14:00:00.000000', '2025-01-20 16:00:00.000000', 50, '2024-12-18 00:10:28.000000', 2, 2);
INSERT INTO `campus_life_activity` VALUES (100, '首届CCF算法能力大赛', '无', 'B517', '2024-12-18 11:21:00.000000', '2025-12-28 11:21:00.000000', 5, '2024-12-18 11:21:50.534373', 1000, 5);

-- ----------------------------
-- Table structure for campus_life_activityparticipant
-- ----------------------------
DROP TABLE IF EXISTS `campus_life_activityparticipant`;
CREATE TABLE `campus_life_activityparticipant`  (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `join_time` datetime(6) NOT NULL,
  `activity_id` bigint NOT NULL,
  `user_id` bigint NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `campus_life_activitypart_activity_id_user_id_e83bb211_uniq`(`activity_id` ASC, `user_id` ASC) USING BTREE,
  INDEX `campus_life_activityparticipant_user_id_19bae431_fk_users_id`(`user_id` ASC) USING BTREE,
  CONSTRAINT `campus_life_activity_activity_id_131661e3_fk_campus_li` FOREIGN KEY (`activity_id`) REFERENCES `campus_life_activity` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `campus_life_activityparticipant_user_id_19bae431_fk_users_id` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 6 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of campus_life_activityparticipant
-- ----------------------------
INSERT INTO `campus_life_activityparticipant` VALUES (1, '2024-12-22 15:12:39.579441', 1, 1001);
INSERT INTO `campus_life_activityparticipant` VALUES (2, '2024-12-22 15:12:45.252872', 2, 1001);
INSERT INTO `campus_life_activityparticipant` VALUES (3, '2024-12-22 15:13:20.174855', 3, 1001);
INSERT INTO `campus_life_activityparticipant` VALUES (4, '2024-12-22 15:40:36.576490', 3, 1000);
INSERT INTO `campus_life_activityparticipant` VALUES (5, '2024-12-22 20:54:16.963659', 2, 1000);

-- ----------------------------
-- Table structure for campus_life_lostfound
-- ----------------------------
DROP TABLE IF EXISTS `campus_life_lostfound`;
CREATE TABLE `campus_life_lostfound`  (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `title` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `description` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `status` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `contact` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `location` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` datetime(6) NOT NULL,
  `user_id` bigint NOT NULL,
  `updated_at` datetime(6) NOT NULL,
  `image` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `lost_founds_user_id_692e43dc_fk_users_id`(`user_id` ASC) USING BTREE,
  CONSTRAINT `lost_founds_user_id_692e43dc_fk_users_id` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 10 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of campus_life_lostfound
-- ----------------------------
INSERT INTO `campus_life_lostfound` VALUES (1, '寻找学生卡', '在教学楼A区丢失学生卡，学号2021001', 'lost', '13800138000', '教学楼A区', '2024-12-18 00:10:28.000000', 4, '2024-12-19 21:13:16.321220', NULL);
INSERT INTO `campus_life_lostfound` VALUES (2, '找到一个钱包', '在图书馆二楼找到一个蓝色钱包', 'claimed', '13900139000', '图书馆二楼', '2024-12-18 00:10:28.000000', 5, '2024-12-19 21:13:16.321220', 'lost_found/wallet.jpg');
INSERT INTO `campus_life_lostfound` VALUES (3, '丢失笔记本电脑', '在食堂丢失一台黑色联想笔记本', 'lost', '13700137000', '第一食堂', '2024-12-18 00:10:28.000000', 4, '2024-12-19 21:13:16.321220', 'lost_found/thinkbook.jpg');
INSERT INTO `campus_life_lostfound` VALUES (5, 'zxy', '丢失在B517', 'completed', '2022211727', '明志苑439', '2024-12-19 21:05:51.911793', 1000, '2024-12-19 21:47:29.149498', '');
INSERT INTO `campus_life_lostfound` VALUES (7, '蓝牙耳机', 'redmi budspro', 'lost', '17783142217', '明志苑', '2024-12-19 21:48:26.167460', 1000, '2024-12-19 21:56:28.883859', 'lost_found/budspro_0yhVNvw.jpg');
INSERT INTO `campus_life_lostfound` VALUES (8, '丢失钥匙', '在滨湖餐厅丢失钥匙', 'lost', '13800138000', '滨湖餐厅', '2024-12-20 18:53:04.000000', 5, '2024-12-20 18:53:04.000000', 'lost_found/key.jpg');
INSERT INTO `campus_life_lostfound` VALUES (9, 'U盘', '在B517拾到U盘', 'claimed', '1888741106', 'B517', '2024-12-20 18:57:49.000000', 4, '2024-12-20 18:57:49.000000', 'lost_found/U.jpg');

-- ----------------------------
-- Table structure for card_consumptions
-- ----------------------------
DROP TABLE IF EXISTS `card_consumptions`;
CREATE TABLE `card_consumptions`  (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `amount` decimal(8, 2) NOT NULL,
  `type` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `location` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` datetime(6) NOT NULL,
  `description` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `user_id` bigint NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `card_consumptions_user_id_5488feb2_fk_users_id`(`user_id` ASC) USING BTREE,
  CONSTRAINT `card_consumptions_user_id_5488feb2_fk_users_id` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 8 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of card_consumptions
-- ----------------------------
INSERT INTO `card_consumptions` VALUES (1, 15.50, 'canteen', '第一食堂', '2024-12-12 19:56:48.000000', '午餐', 1000);
INSERT INTO `card_consumptions` VALUES (2, 12.00, 'canteen', '第二食堂', '2024-12-13 19:56:48.000000', '早餐', 1000);
INSERT INTO `card_consumptions` VALUES (3, 25.00, 'shop', '校园超市', '2024-12-14 19:56:48.000000', '日用品', 1000);
INSERT INTO `card_consumptions` VALUES (4, 50.00, 'canteen', '第一食堂', '2024-12-15 19:56:48.000000', '晚餐', 1000);
INSERT INTO `card_consumptions` VALUES (5, 100.00, 'print', '图书馆打印室', '2024-12-16 19:56:48.000000', '打印资料', 1000);
INSERT INTO `card_consumptions` VALUES (6, 50.00, 'canteen', '第二食堂', '2024-12-17 19:56:48.000000', '午餐', 1000);
INSERT INTO `card_consumptions` VALUES (7, 16.50, 'canteen', '第一食堂', '2024-12-18 19:56:48.000000', '早餐', 1000);

-- ----------------------------
-- Table structure for comments
-- ----------------------------
DROP TABLE IF EXISTS `comments`;
CREATE TABLE `comments`  (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `content` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` datetime(6) NOT NULL,
  `object_id` int UNSIGNED NOT NULL,
  `content_type_id` int NOT NULL,
  `user_id` bigint NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `comments_content_type_id_ea0670fe_fk_django_content_type_id`(`content_type_id` ASC) USING BTREE,
  INDEX `comments_user_id_b8fd0b64_fk_users_id`(`user_id` ASC) USING BTREE,
  CONSTRAINT `comments_content_type_id_ea0670fe_fk_django_content_type_id` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `comments_user_id_b8fd0b64_fk_users_id` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `comments_chk_1` CHECK (`object_id` >= 0)
) ENGINE = InnoDB AUTO_INCREMENT = 4 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of comments
-- ----------------------------
INSERT INTO `comments` VALUES (1, '活动很有意义，期待参加！', '2024-12-18 00:10:28.000000', 1, 1, 4);
INSERT INTO `comments` VALUES (2, '请问具体的比赛规则是什么？', '2024-12-18 00:10:28.000000', 2, 1, 5);
INSERT INTO `comments` VALUES (3, '欢迎同学们积极参与。', '2024-12-18 00:10:28.000000', 2, 1, 2);

-- ----------------------------
-- Table structure for course_schedules
-- ----------------------------
DROP TABLE IF EXISTS `course_schedules`;
CREATE TABLE `course_schedules`  (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `weekday` int NOT NULL,
  `start_time` time(6) NOT NULL,
  `end_time` time(6) NOT NULL,
  `classroom` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `course_id` bigint NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `course_schedules_course_id_51b46c6c_fk`(`course_id` ASC) USING BTREE,
  CONSTRAINT `course_schedules_course_id_51b46c6c_fk` FOREIGN KEY (`course_id`) REFERENCES `academic_course` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 87 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of course_schedules
-- ----------------------------
INSERT INTO `course_schedules` VALUES (83, 1, '08:00:00.000000', '09:40:00.000000', '2217', 1);
INSERT INTO `course_schedules` VALUES (84, 2, '10:00:00.000000', '11:40:00.000000', '2210', 2);
INSERT INTO `course_schedules` VALUES (85, 5, '10:00:00.000000', '11:40:00.000000', 'B517', 3);
INSERT INTO `course_schedules` VALUES (86, 4, '16:00:00.000000', '17:40:00.000000', '2310', 4);

-- ----------------------------
-- Table structure for django_admin_log
-- ----------------------------
DROP TABLE IF EXISTS `django_admin_log`;
CREATE TABLE `django_admin_log`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `action_time` datetime(6) NOT NULL,
  `object_id` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL,
  `object_repr` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `action_flag` smallint UNSIGNED NOT NULL,
  `change_message` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `content_type_id` int NULL DEFAULT NULL,
  `user_id` bigint NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `django_admin_log_content_type_id_c4bce8eb_fk_django_co`(`content_type_id` ASC) USING BTREE,
  INDEX `django_admin_log_user_id_c564eba6_fk_users_id`(`user_id` ASC) USING BTREE,
  CONSTRAINT `django_admin_log_content_type_id_c4bce8eb_fk_django_co` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `django_admin_log_user_id_c564eba6_fk_users_id` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `django_admin_log_chk_1` CHECK (`action_flag` >= 0)
) ENGINE = InnoDB AUTO_INCREMENT = 3 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of django_admin_log
-- ----------------------------
INSERT INTO `django_admin_log` VALUES (1, '2024-12-22 21:03:33.882682', '100', 'Announcement object (100)', 1, '[{\"added\": {}}]', 11, 1000);
INSERT INTO `django_admin_log` VALUES (2, '2024-12-22 21:18:05.168954', '79', '数据结构 - 周四 17:40-16:00', 3, '', 8, 1000);

-- ----------------------------
-- Table structure for django_content_type
-- ----------------------------
DROP TABLE IF EXISTS `django_content_type`;
CREATE TABLE `django_content_type`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `app_label` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `model` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `django_content_type_app_label_model_76bd3d3b_uniq`(`app_label` ASC, `model` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 18 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of django_content_type
-- ----------------------------
INSERT INTO `django_content_type` VALUES (7, 'academic', 'course');
INSERT INTO `django_content_type` VALUES (9, 'academic', 'enrollment');
INSERT INTO `django_content_type` VALUES (15, 'academic', 'exam');
INSERT INTO `django_content_type` VALUES (8, 'academic', 'schedule');
INSERT INTO `django_content_type` VALUES (1, 'admin', 'logentry');
INSERT INTO `django_content_type` VALUES (3, 'auth', 'group');
INSERT INTO `django_content_type` VALUES (2, 'auth', 'permission');
INSERT INTO `django_content_type` VALUES (12, 'campus_life', 'activity');
INSERT INTO `django_content_type` VALUES (17, 'campus_life', 'activityparticipant');
INSERT INTO `django_content_type` VALUES (11, 'campus_life', 'announcement');
INSERT INTO `django_content_type` VALUES (16, 'campus_life', 'cardconsumption');
INSERT INTO `django_content_type` VALUES (10, 'campus_life', 'lostfound');
INSERT INTO `django_content_type` VALUES (14, 'communication', 'comment');
INSERT INTO `django_content_type` VALUES (13, 'communication', 'message');
INSERT INTO `django_content_type` VALUES (4, 'contenttypes', 'contenttype');
INSERT INTO `django_content_type` VALUES (5, 'sessions', 'session');
INSERT INTO `django_content_type` VALUES (6, 'users', 'user');

-- ----------------------------
-- Table structure for django_migrations
-- ----------------------------
DROP TABLE IF EXISTS `django_migrations`;
CREATE TABLE `django_migrations`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `app` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `applied` datetime(6) NOT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 39 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of django_migrations
-- ----------------------------
INSERT INTO `django_migrations` VALUES (1, 'contenttypes', '0001_initial', '2024-12-18 00:02:01.284501');
INSERT INTO `django_migrations` VALUES (2, 'contenttypes', '0002_remove_content_type_name', '2024-12-18 00:02:01.364108');
INSERT INTO `django_migrations` VALUES (3, 'auth', '0001_initial', '2024-12-18 00:02:01.586044');
INSERT INTO `django_migrations` VALUES (4, 'auth', '0002_alter_permission_name_max_length', '2024-12-18 00:02:01.641422');
INSERT INTO `django_migrations` VALUES (5, 'auth', '0003_alter_user_email_max_length', '2024-12-18 00:02:01.647650');
INSERT INTO `django_migrations` VALUES (6, 'auth', '0004_alter_user_username_opts', '2024-12-18 00:02:01.654153');
INSERT INTO `django_migrations` VALUES (7, 'auth', '0005_alter_user_last_login_null', '2024-12-18 00:02:01.658697');
INSERT INTO `django_migrations` VALUES (8, 'auth', '0006_require_contenttypes_0002', '2024-12-18 00:02:01.666134');
INSERT INTO `django_migrations` VALUES (9, 'auth', '0007_alter_validators_add_error_messages', '2024-12-18 00:02:01.673116');
INSERT INTO `django_migrations` VALUES (10, 'auth', '0008_alter_user_username_max_length', '2024-12-18 00:02:01.678571');
INSERT INTO `django_migrations` VALUES (11, 'auth', '0009_alter_user_last_name_max_length', '2024-12-18 00:02:01.683093');
INSERT INTO `django_migrations` VALUES (12, 'auth', '0010_alter_group_name_max_length', '2024-12-18 00:02:01.699369');
INSERT INTO `django_migrations` VALUES (13, 'auth', '0011_update_proxy_permissions', '2024-12-18 00:02:01.705422');
INSERT INTO `django_migrations` VALUES (14, 'auth', '0012_alter_user_first_name_max_length', '2024-12-18 00:02:01.710354');
INSERT INTO `django_migrations` VALUES (15, 'users', '0001_initial', '2024-12-18 00:02:01.966428');
INSERT INTO `django_migrations` VALUES (16, 'academic', '0001_initial', '2024-12-18 00:02:02.258472');
INSERT INTO `django_migrations` VALUES (17, 'admin', '0001_initial', '2024-12-18 00:02:02.366328');
INSERT INTO `django_migrations` VALUES (18, 'admin', '0002_logentry_remove_auto_add', '2024-12-18 00:02:02.375342');
INSERT INTO `django_migrations` VALUES (19, 'admin', '0003_logentry_add_action_flag_choices', '2024-12-18 00:02:02.384805');
INSERT INTO `django_migrations` VALUES (20, 'campus_life', '0001_initial', '2024-12-18 00:02:02.646750');
INSERT INTO `django_migrations` VALUES (21, 'communication', '0001_initial', '2024-12-18 00:02:02.876380');
INSERT INTO `django_migrations` VALUES (22, 'sessions', '0001_initial', '2024-12-18 00:02:02.916849');
INSERT INTO `django_migrations` VALUES (23, 'academic', '0002_alter_course_id_alter_enrollment_id_and_more', '2024-12-18 10:35:16.931187');
INSERT INTO `django_migrations` VALUES (24, 'campus_life', '0002_alter_activity_id_alter_announcement_id_and_more', '2024-12-18 10:35:17.149721');
INSERT INTO `django_migrations` VALUES (25, 'communication', '0002_alter_comment_id_alter_message_id', '2024-12-18 10:35:17.299320');
INSERT INTO `django_migrations` VALUES (26, 'academic', '0003_exam', '2024-12-18 19:45:11.154717');
INSERT INTO `django_migrations` VALUES (27, 'campus_life', '0003_cardconsumption', '2024-12-18 19:56:29.146422');
INSERT INTO `django_migrations` VALUES (28, 'academic', '0004_remove_course_classroom_remove_course_semester_and_more', '2024-12-18 21:34:49.866594');
INSERT INTO `django_migrations` VALUES (29, 'academic', '0005_course_classroom_course_time_slot_course_weekday', '2024-12-19 19:18:59.290770');
INSERT INTO `django_migrations` VALUES (30, 'academic', '0006_remove_course_classroom_remove_course_time_slot_and_more', '2024-12-19 19:33:56.366499');
INSERT INTO `django_migrations` VALUES (31, 'campus_life', '0004_lostfound_updated_at_alter_lostfound_created_at_and_more', '2024-12-19 21:13:16.577438');
INSERT INTO `django_migrations` VALUES (32, 'campus_life', '0005_lostfound_image', '2024-12-19 21:34:15.461912');
INSERT INTO `django_migrations` VALUES (33, 'campus_life', '0006_alter_lostfound_image', '2024-12-20 19:12:36.232474');
INSERT INTO `django_migrations` VALUES (34, 'campus_life', '0007_activity_current_participants', '2024-12-20 19:21:12.348644');
INSERT INTO `django_migrations` VALUES (35, 'academic', '0007_course_classroom_course_end_time_course_start_time', '2024-12-21 10:24:56.860271');
INSERT INTO `django_migrations` VALUES (36, 'academic', '0008_course_course_type', '2024-12-21 11:13:51.395248');
INSERT INTO `django_migrations` VALUES (37, 'campus_life', '0008_alter_activity_options_alter_activity_table_and_more', '2024-12-22 15:11:42.013375');
INSERT INTO `django_migrations` VALUES (38, 'users', '0002_alter_user_role', '2024-12-22 15:11:42.066069');

-- ----------------------------
-- Table structure for django_session
-- ----------------------------
DROP TABLE IF EXISTS `django_session`;
CREATE TABLE `django_session`  (
  `session_key` varchar(40) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `session_data` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `expire_date` datetime(6) NOT NULL,
  PRIMARY KEY (`session_key`) USING BTREE,
  INDEX `django_session_expire_date_a5c62663`(`expire_date` ASC) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of django_session
-- ----------------------------
INSERT INTO `django_session` VALUES ('tigyr1edr2mxkx8lac2mopd5pq9lvwpk', '.eJxVjMsOwiAQRf-FtSEDTHm4dN9vIAyMUjU0Ke3K-O_apAvd3nPOfYmYtrXGrfMSpyLOQgGAOP3OlPKD287KPbXbLPPc1mUiuSvyoF2Oc-Hn5XD_Dmrq9VsH1mQBizdM5DAzac-eB1SDNhSCYceABNY7S6UEY9xVMUFGhwCZxfsDUGA4Zw:1tPgDy:basmdrmrW4uzs6EiQDq9sMjn2F3zMY5eMXgBv8J1tIE', '2025-01-06 19:03:46.329257');

-- ----------------------------
-- Table structure for enrollments
-- ----------------------------
DROP TABLE IF EXISTS `enrollments`;
CREATE TABLE `enrollments`  (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `score` double NULL DEFAULT NULL,
  `created_at` datetime(6) NOT NULL,
  `course_id` bigint NOT NULL,
  `student_id` bigint NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `enrollments_student_id_course_id_bba60245_uniq`(`student_id` ASC, `course_id` ASC) USING BTREE,
  INDEX `enrollments_course_id_8964c6c8_fk`(`course_id` ASC) USING BTREE,
  CONSTRAINT `enrollments_course_id_8964c6c8_fk` FOREIGN KEY (`course_id`) REFERENCES `academic_course` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `enrollments_student_id_19c0bed4_fk_users_id` FOREIGN KEY (`student_id`) REFERENCES `users` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 161 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of enrollments
-- ----------------------------
INSERT INTO `enrollments` VALUES (1, 85.5, '2024-12-18 00:10:28.000000', 1, 4);
INSERT INTO `enrollments` VALUES (2, 88, '2024-12-18 00:10:28.000000', 2, 4);
INSERT INTO `enrollments` VALUES (3, 92, '2024-12-18 00:10:28.000000', 1, 5);
INSERT INTO `enrollments` VALUES (4, 90.5, '2024-12-18 00:10:28.000000', 3, 5);
INSERT INTO `enrollments` VALUES (9, NULL, '2024-12-18 19:14:07.739534', 1, 1001);
INSERT INTO `enrollments` VALUES (145, NULL, '2024-12-22 13:46:40.093040', 1, 1002);
INSERT INTO `enrollments` VALUES (146, NULL, '2024-12-22 13:46:40.690415', 2, 1002);
INSERT INTO `enrollments` VALUES (147, NULL, '2024-12-22 13:46:41.660493', 3, 1002);
INSERT INTO `enrollments` VALUES (148, NULL, '2024-12-22 13:46:43.138208', 4, 1002);
INSERT INTO `enrollments` VALUES (149, NULL, '2024-12-22 15:08:06.779508', 2, 1001);
INSERT INTO `enrollments` VALUES (153, NULL, '2024-12-22 21:06:12.695067', 4, 1001);
INSERT INTO `enrollments` VALUES (154, NULL, '2024-12-22 21:06:13.978976', 3, 1001);
INSERT INTO `enrollments` VALUES (157, NULL, '2024-12-23 19:13:02.271525', 1, 1000);
INSERT INTO `enrollments` VALUES (158, NULL, '2024-12-23 19:13:04.124677', 2, 1000);
INSERT INTO `enrollments` VALUES (159, NULL, '2024-12-23 19:13:06.126767', 3, 1000);
INSERT INTO `enrollments` VALUES (160, NULL, '2024-12-23 19:13:07.249296', 4, 1000);

-- ----------------------------
-- Table structure for messages
-- ----------------------------
DROP TABLE IF EXISTS `messages`;
CREATE TABLE `messages`  (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `content` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` datetime(6) NOT NULL,
  `is_read` tinyint(1) NOT NULL,
  `receiver_id` bigint NOT NULL,
  `sender_id` bigint NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `messages_receiver_id_874b4e0a_fk_users_id`(`receiver_id` ASC) USING BTREE,
  INDEX `messages_sender_id_dc5a0bbd_fk_users_id`(`sender_id` ASC) USING BTREE,
  CONSTRAINT `messages_receiver_id_874b4e0a_fk_users_id` FOREIGN KEY (`receiver_id`) REFERENCES `users` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `messages_sender_id_dc5a0bbd_fk_users_id` FOREIGN KEY (`sender_id`) REFERENCES `users` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 12 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of messages
-- ----------------------------
INSERT INTO `messages` VALUES (1, '老师，我想请教一道数学题', '2024-12-18 00:10:28.000000', 0, 2, 4);
INSERT INTO `messages` VALUES (2, '好的，你说说看是哪道题', '2024-12-18 00:10:28.000000', 1, 4, 2);
INSERT INTO `messages` VALUES (3, '老师，我可以参加编程竞赛吗？', '2024-12-18 00:10:28.000000', 0, 3, 5);
INSERT INTO `messages` VALUES (4, '2024.12.18', '2024-12-18 11:39:13.323535', 1, 1000, 1000);
INSERT INTO `messages` VALUES (5, '1235465', '2024-12-18 19:01:35.685136', 1, 1000, 1000);
INSERT INTO `messages` VALUES (6, '666', '2024-12-18 19:14:24.586358', 1, 1000, 1001);
INSERT INTO `messages` VALUES (7, '132', '2024-12-18 19:23:31.108359', 0, 1, 1000);

-- ----------------------------
-- Table structure for users
-- ----------------------------
DROP TABLE IF EXISTS `users`;
CREATE TABLE `users`  (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `password` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `last_login` datetime(6) NULL DEFAULT NULL,
  `is_superuser` tinyint(1) NOT NULL,
  `username` varchar(150) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `first_name` varchar(150) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `last_name` varchar(150) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `email` varchar(254) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `is_staff` tinyint(1) NOT NULL,
  `is_active` tinyint(1) NOT NULL,
  `date_joined` datetime(6) NOT NULL,
  `role` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `student_id` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `phone` varchar(11) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `username`(`username` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1005 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of users
-- ----------------------------
INSERT INTO `users` VALUES (1, 'pbkdf2_sha256$260000$abcdef123456$', NULL, 1, 'admin', 'Admin', 'User', 'admin@example.com', 1, 1, '2024-12-18 00:10:28.000000', 'admin', NULL, NULL);
INSERT INTO `users` VALUES (2, 'pbkdf2_sha256$260000$abcdef123456$', NULL, 0, 'teacher1', 'Teacher1', 'Name', 'teacher1@example.com', 0, 1, '2024-12-18 00:10:28.000000', 'teacher', NULL, NULL);
INSERT INTO `users` VALUES (3, 'pbkdf2_sha256$260000$abcdef123456$', NULL, 0, 'teacher2', 'Teacher2', 'Name', 'teacher2@example.com', 0, 1, '2024-12-18 00:10:28.000000', 'teacher', NULL, NULL);
INSERT INTO `users` VALUES (4, 'pbkdf2_sha256$260000$abcdef123456$', NULL, 0, 'student1', 'Student1', 'Name', 'student1@example.com', 0, 1, '2024-12-18 00:10:28.000000', 'student', NULL, NULL);
INSERT INTO `users` VALUES (5, 'pbkdf2_sha256$260000$abcdef123456$', NULL, 0, 'student2', 'Student2', 'Name', 'student2@example.com', 0, 1, '2024-12-18 00:10:28.000000', 'student', NULL, NULL);
INSERT INTO `users` VALUES (1000, 'pbkdf2_sha256$600000$ocV4b3V8w2AIEG36pwGpox$YHV+fqZUF0FJ5IhCEDU0aRoKG9TKEgg+LIhTJh75f8Y=', '2024-12-23 19:03:46.325251', 1, 'yzh', '', '', '1957679251@qq.com', 1, 1, '2024-12-18 00:21:40.125450', 'student', NULL, NULL);
INSERT INTO `users` VALUES (1001, 'pbkdf2_sha256$600000$NLNzdX4S6W73jLND1EClrj$C3w7SvBQYA4N9CfRAvk4JcNeVqCvPIrQ7ie2tMJwB+E=', '2024-12-22 21:05:59.522352', 0, 'zxy', '', '', '123456@qq.com', 0, 1, '2024-12-18 19:12:45.174692', 'student', '2022211727', '123456789');
INSERT INTO `users` VALUES (1002, 'pbkdf2_sha256$600000$xU3JpLn9qSxwCYffX6SOTU$iptcQj1ok/r8eQ04Y4azhwItuJ6MzTMXkepFGPo1EhU=', '2024-12-22 13:46:30.380050', 0, 'zxy1', '', '', '123@qq.com', 0, 1, '2024-12-22 13:46:30.089573', 'student', NULL, NULL);
INSERT INTO `users` VALUES (1003, 'pbkdf2_sha256$600000$Q1HA1KOcffXzPrhPNXumPX$XQbJr9xzrskQVLNN9zxj4E0UFSfTrbXmV8ISZZq7yEM=', '2024-12-22 14:44:13.543894', 0, 'ldc', '', '', '123@qq.com', 0, 1, '2024-12-22 14:44:13.196303', 'student', '', '');
INSERT INTO `users` VALUES (1004, 'pbkdf2_sha256$600000$439MoawgShmfjxdI4zi9ai$tB1IiaXV4I1FA0oF3lFzR6Kn3MZCgBxmErwfXPZxfLk=', '2024-12-22 14:48:35.674293', 0, 'ldc1', '', '', '123@qq.com', 0, 1, '2024-12-22 14:48:35.330372', 'student', '', '');

-- ----------------------------
-- Table structure for users_groups
-- ----------------------------
DROP TABLE IF EXISTS `users_groups`;
CREATE TABLE `users_groups`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `user_id` bigint NOT NULL,
  `group_id` int NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `users_groups_user_id_group_id_fc7788e8_uniq`(`user_id` ASC, `group_id` ASC) USING BTREE,
  INDEX `users_groups_group_id_2f3517aa_fk_auth_group_id`(`group_id` ASC) USING BTREE,
  CONSTRAINT `users_groups_group_id_2f3517aa_fk_auth_group_id` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `users_groups_user_id_f500bee5_fk_users_id` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of users_groups
-- ----------------------------

-- ----------------------------
-- Table structure for users_user_permissions
-- ----------------------------
DROP TABLE IF EXISTS `users_user_permissions`;
CREATE TABLE `users_user_permissions`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `user_id` bigint NOT NULL,
  `permission_id` int NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `users_user_permissions_user_id_permission_id_3b86cbdf_uniq`(`user_id` ASC, `permission_id` ASC) USING BTREE,
  INDEX `users_user_permissio_permission_id_6d08dcd2_fk_auth_perm`(`permission_id` ASC) USING BTREE,
  CONSTRAINT `users_user_permissio_permission_id_6d08dcd2_fk_auth_perm` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `users_user_permissions_user_id_92473840_fk_users_id` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of users_user_permissions
-- ----------------------------

SET FOREIGN_KEY_CHECKS = 1;
