/*
 Navicat Premium Data Transfer

 Source Server         : 本地
 Source Server Type    : MySQL
 Source Server Version : 80028
 Source Host           : localhost:3306
 Source Schema         : laborer-bus

 Target Server Type    : MySQL
 Target Server Version : 80028
 File Encoding         : 65001

 Date: 04/03/2023 10:08:25
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for bus_route
-- ----------------------------
DROP TABLE IF EXISTS `bus_route`;
CREATE TABLE `bus_route`  (
                              `id` bigint(0) NOT NULL AUTO_INCREMENT,
                              `car_number` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '车牌号',
                              `car_type` int(0) NULL DEFAULT NULL COMMENT '车型 1大巴 2中巴',
                              `capacity` int(0) NOT NULL COMMENT '座位数',
                              `driver_uid` bigint(0) NULL DEFAULT NULL COMMENT '司机uid',
                              `start_address` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '起始地址',
                              `end_address` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '目的地址',
                              `plan_depart_time` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_as_ci NOT NULL COMMENT '计划发车时间\n',
                              `state` tinyint(0) NOT NULL DEFAULT 1 COMMENT '状态  \n0删除\n1启用\n',
                              `create_by` bigint(0) NULL DEFAULT NULL,
                              `create_date` datetime(0) NULL DEFAULT NULL,
                              `update_by` bigint(0) NULL DEFAULT NULL,
                              `update_date` datetime(0) NULL DEFAULT NULL,
                              PRIMARY KEY (`id`) USING BTREE,
                              INDEX `driver_uid`(`driver_uid`) USING BTREE,
                              INDEX `idx_projectid_startaddress`(`start_address`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 70 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci COMMENT = '班车线路表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of bus_route
-- ----------------------------
INSERT INTO `bus_route` VALUES (67, '京B123456', 2, 40, 1, '霍营', '北土城', '09:00', 1, NULL, NULL, NULL, NULL);
INSERT INTO `bus_route` VALUES (68, '京A123123', 1, 50, 4, '西直门', '霍营', '20:03', 1, NULL, NULL, NULL, NULL);
INSERT INTO `bus_route` VALUES (69, '京A88888', 1, 50, 1, '霍营', '天安门', '20:00', 1, NULL, NULL, NULL, NULL);

-- ----------------------------
-- Table structure for bus_route_appointment
-- ----------------------------
DROP TABLE IF EXISTS `bus_route_appointment`;
CREATE TABLE `bus_route_appointment`  (
                                          `id` bigint(0) NOT NULL AUTO_INCREMENT,
                                          `route_id` bigint(0) NOT NULL COMMENT '班车线路id',
                                          `appointment_uid` bigint(0) NOT NULL DEFAULT 0 COMMENT '预约人uid',
                                          `appointment_date` date NOT NULL COMMENT '预约乘车日期',
                                          `depart_time` datetime(0) NULL DEFAULT NULL COMMENT '乘车时间',
                                          `depart_id` bigint(0) NULL DEFAULT NULL COMMENT '发车记录id',
                                          `state` tinyint(0) NOT NULL DEFAULT 0 COMMENT '状态 0预约成功 \n1取消 2已乘车',
                                          `create_by` bigint(0) NULL DEFAULT NULL,
                                          `create_date` datetime(0) NULL DEFAULT NULL,
                                          `update_by` bigint(0) NULL DEFAULT NULL,
                                          `update_date` datetime(0) NULL DEFAULT NULL,
                                          PRIMARY KEY (`id`) USING BTREE,
                                          INDEX `FK_bus_route_appointment_bus_route`(`route_id`) USING BTREE,
                                          INDEX `appointment_uid`(`appointment_uid`) USING BTREE,
                                          INDEX `depart_id`(`depart_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 48 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci COMMENT = '班车预约表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of bus_route_appointment
-- ----------------------------
INSERT INTO `bus_route_appointment` VALUES (44, 68, 1, '2023-03-03', NULL, NULL, 1, NULL, NULL, NULL, NULL);
INSERT INTO `bus_route_appointment` VALUES (45, 68, 1, '2023-03-05', NULL, NULL, 0, NULL, NULL, NULL, NULL);
INSERT INTO `bus_route_appointment` VALUES (46, 67, 1, '2023-03-07', NULL, 2, 2, NULL, NULL, NULL, NULL);
INSERT INTO `bus_route_appointment` VALUES (47, 69, 1, '2023-03-04', '2023-03-03 19:12:41', 29, 2, NULL, NULL, NULL, NULL);

-- ----------------------------
-- Table structure for bus_route_depart
-- ----------------------------
DROP TABLE IF EXISTS `bus_route_depart`;
CREATE TABLE `bus_route_depart`  (
                                     `id` bigint(0) NOT NULL AUTO_INCREMENT,
                                     `route_id` bigint(0) NOT NULL COMMENT '班车线路id',
                                     `plan_depart_time` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '计划发车时间\n',
                                     `depart_time` datetime(0) NOT NULL COMMENT '实际发车时间',
                                     `state` tinyint(0) NOT NULL DEFAULT 1 COMMENT '状态  \n0删除\n1启用\n',
                                     `create_by` bigint(0) NULL DEFAULT NULL,
                                     `create_date` datetime(0) NULL DEFAULT NULL,
                                     `update_by` bigint(0) NULL DEFAULT NULL,
                                     `update_date` datetime(0) NULL DEFAULT NULL,
                                     PRIMARY KEY (`id`) USING BTREE,
                                     INDEX `FK_bus_route_depart_bus_route`(`route_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 30 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci COMMENT = '班车发车记录表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of bus_route_depart
-- ----------------------------
INSERT INTO `bus_route_depart` VALUES (28, 67, '2023-03-07 09:00', '2023-03-03 17:41:33', 1, NULL, NULL, NULL, NULL);
INSERT INTO `bus_route_depart` VALUES (29, 69, '2023-03-04 20:00', '2023-03-03 19:07:35', 1, NULL, NULL, NULL, NULL);

-- ----------------------------
-- Table structure for schedule_job
-- ----------------------------
DROP TABLE IF EXISTS `schedule_job`;
CREATE TABLE `schedule_job`  (
                                 `id` bigint(0) NOT NULL AUTO_INCREMENT COMMENT '主键',
                                 `bean` varchar(150) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT 'bean名称',
                                 `method` varchar(150) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '方法名',
                                 `params` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '参数',
                                 `cron` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT 'cron表达式',
                                 `status` tinyint(0) NOT NULL DEFAULT 1 COMMENT '状态。0：运行中；1：已暂停；2：已完成；3：运行失败；',
                                 `remark` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '备注',
                                 `create_time` timestamp(0) NOT NULL DEFAULT CURRENT_TIMESTAMP(0) COMMENT '创建时间',
                                 PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 2 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '定时任务表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of schedule_job
-- ----------------------------
INSERT INTO `schedule_job` VALUES (1, 'helloJob', NULL, NULL, '0 0 12 * * ?', 1, '无参测试', '2019-08-18 13:30:08');

-- ----------------------------
-- Table structure for sys_dept
-- ----------------------------
DROP TABLE IF EXISTS `sys_dept`;
CREATE TABLE `sys_dept`  (
                             `id` bigint(0) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '主键',
                             `parent_id` bigint(0) NOT NULL COMMENT '上级部门ID。一级部门为0',
                             `name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '部门名称',
                             `type` tinyint(0) NOT NULL COMMENT '类型。0：公司；1：部门；2：科室/小组',
                             `area_id` bigint(0) NULL DEFAULT NULL COMMENT '所在区域ID',
                             `sort` int(0) NOT NULL DEFAULT 0 COMMENT '排序值。越小越靠前',
                             `status` tinyint(0) NOT NULL DEFAULT 0 COMMENT '状态。0：正常；1：禁用',
                             `update_time` timestamp(0) NOT NULL DEFAULT CURRENT_TIMESTAMP(0) ON UPDATE CURRENT_TIMESTAMP(0) COMMENT '修改时间',
                             `create_by` bigint(0) NULL DEFAULT NULL COMMENT '创建人',
                             `create_time` timestamp(0) NOT NULL DEFAULT CURRENT_TIMESTAMP(0) COMMENT '创建时间',
                             PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 4 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '部门表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_dept
-- ----------------------------
INSERT INTO `sys_dept` VALUES (1, 0, 'Kalvin', 0, 1, 0, 0, '2019-05-11 15:35:24', 1, '2019-05-01 16:40:08');
INSERT INTO `sys_dept` VALUES (2, 1, 'IT部', 1, 1, 0, 0, '2019-05-01 17:12:54', NULL, '2019-05-01 17:12:54');
INSERT INTO `sys_dept` VALUES (3, 2, '研发组', 2, 1, 0, 0, '2019-05-01 17:13:48', NULL, '2019-05-01 17:13:48');

-- ----------------------------
-- Table structure for sys_dict
-- ----------------------------
DROP TABLE IF EXISTS `sys_dict`;
CREATE TABLE `sys_dict`  (
                             `id` bigint(0) NOT NULL AUTO_INCREMENT COMMENT '主键',
                             `parent_id` bigint(0) NOT NULL COMMENT '父级ID',
                             `name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '字典名称',
                             `type` tinyint(0) NOT NULL DEFAULT 0 COMMENT '类型。0：字典类别；1：字典项；',
                             `code` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '字典码',
                             `value` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '字典值',
                             `status` tinyint(0) NOT NULL DEFAULT 0 COMMENT '状态。0：有效；1：无效',
                             `sort` int(0) NOT NULL DEFAULT 0 COMMENT '排序值。越小越靠前',
                             `remark` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '备注',
                             PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 8 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '字典表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_dict
-- ----------------------------
INSERT INTO `sys_dict` VALUES (1, 0, '根目录', 0, 'ROOT', '', 0, 0, NULL);
INSERT INTO `sys_dict` VALUES (2, 1, '性别', 0, 'SEX', '', 0, 0, NULL);
INSERT INTO `sys_dict` VALUES (3, 2, '未知', 1, 'SEX_UNKNOWN', '0', 0, 0, NULL);
INSERT INTO `sys_dict` VALUES (4, 2, '男', 1, 'SEX_MAN', '1', 0, 0, NULL);
INSERT INTO `sys_dict` VALUES (5, 2, '女', 1, 'SEX_LADY', '2', 0, 0, NULL);

-- ----------------------------
-- Table structure for sys_log
-- ----------------------------
DROP TABLE IF EXISTS `sys_log`;
CREATE TABLE `sys_log`  (
                            `id` bigint(0) NOT NULL AUTO_INCREMENT COMMENT '主键',
                            `user_id` bigint(0) NOT NULL COMMENT '用户ID',
                            `username` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '登录名称',
                            `operation` varchar(150) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '操作功能',
                            `forward_action` varchar(300) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '操作uri',
                            `ip` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT 'IP',
                            `browser` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '0' COMMENT '浏览器',
                            `os` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '系统',
                            `time` bigint(0) NOT NULL DEFAULT 0 COMMENT '请求耗时。毫秒',
                            `create_time` timestamp(0) NOT NULL DEFAULT CURRENT_TIMESTAMP(0) COMMENT '创建时间',
                            PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 102 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '日志表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_log
-- ----------------------------
INSERT INTO `sys_log` VALUES (1, 1, 'admin', '登录', '/login', '127.0.0.1', 'Chrome 110.0.0.0', 'Windows', 273, '2023-03-01 19:10:59');
INSERT INTO `sys_log` VALUES (2, 1, 'admin', '登录', '/login', '127.0.0.1', 'Chrome 110.0.0.0', 'Windows', 265, '2023-03-01 19:13:00');
INSERT INTO `sys_log` VALUES (3, 1, 'admin', '登录', '/login', '127.0.0.1', 'Chrome 110.0.0.0', 'Windows', 236, '2023-03-01 19:14:25');
INSERT INTO `sys_log` VALUES (4, 1, 'admin', '登录', '/login', '127.0.0.1', 'Chrome 110.0.0.0', 'Windows', 273, '2023-03-01 19:39:14');
INSERT INTO `sys_log` VALUES (5, 1, 'admin', '登录', '/login', '127.0.0.1', 'Chrome 110.0.0.0', 'Windows', 246, '2023-03-01 19:40:54');
INSERT INTO `sys_log` VALUES (6, 1, 'admin', '登录', '/login', '127.0.0.1', 'Chrome 110.0.0.0', 'Windows', 243, '2023-03-01 19:44:27');
INSERT INTO `sys_log` VALUES (7, 1, 'admin', '登录', '/login', '127.0.0.1', 'Chrome 110.0.0.0', 'Windows', 7, '2023-03-01 20:19:48');
INSERT INTO `sys_log` VALUES (8, 1, 'admin', '登录', '/login', '127.0.0.1', 'Chrome 110.0.0.0', 'Windows', 277, '2023-03-01 20:35:16');
INSERT INTO `sys_log` VALUES (9, 1, 'admin', '登录', '/login', '127.0.0.1', 'Chrome 110.0.0.0', 'Windows', 271, '2023-03-01 20:57:51');
INSERT INTO `sys_log` VALUES (10, 1, 'admin', '登录', '/login', '127.0.0.1', 'Chrome 110.0.0.0', 'Windows', 233, '2023-03-01 21:03:16');
INSERT INTO `sys_log` VALUES (11, 1, 'admin', '登录', '/login', '127.0.0.1', 'Chrome 110.0.0.0', 'Windows', 231, '2023-03-01 21:06:29');
INSERT INTO `sys_log` VALUES (12, 1, 'admin', '登录', '/login', '127.0.0.1', 'Chrome 110.0.0.0', 'Windows', 234, '2023-03-01 21:09:02');
INSERT INTO `sys_log` VALUES (13, 1, 'admin', '登录', '/login', '127.0.0.1', 'Chrome 110.0.0.0', 'Windows', 231, '2023-03-01 21:49:53');
INSERT INTO `sys_log` VALUES (14, 1, 'admin', '登录', '/login', '127.0.0.1', 'Chrome 110.0.0.0', 'Windows', 238, '2023-03-01 22:05:06');
INSERT INTO `sys_log` VALUES (15, 1, 'admin', '登录', '/login', '127.0.0.1', 'Chrome 110.0.0.0', 'Windows', 234, '2023-03-01 22:10:38');
INSERT INTO `sys_log` VALUES (16, 1, 'admin', '登录', '/login', '127.0.0.1', 'Chrome 110.0.0.0', 'Windows', 238, '2023-03-02 12:11:26');
INSERT INTO `sys_log` VALUES (17, 1, 'admin', '登录', '/login', '127.0.0.1', 'Chrome 110.0.0.0', 'Windows', 235, '2023-03-02 12:38:11');
INSERT INTO `sys_log` VALUES (18, 1, 'admin', '登录', '/login', '127.0.0.1', 'Chrome 110.0.0.0', 'Windows', 236, '2023-03-02 12:41:16');
INSERT INTO `sys_log` VALUES (19, 1, 'admin', '登录', '/login', '127.0.0.1', 'Chrome 110.0.0.0', 'Windows', 35, '2023-03-02 18:47:19');
INSERT INTO `sys_log` VALUES (20, 1, 'admin', '登录', '/login', '127.0.0.1', 'Chrome 110.0.0.0', 'Windows', 245, '2023-03-02 18:49:35');
INSERT INTO `sys_log` VALUES (21, 1, 'admin', '登录', '/login', '127.0.0.1', 'Chrome 110.0.0.0', 'Windows', 248, '2023-03-02 19:02:38');
INSERT INTO `sys_log` VALUES (22, 1, 'admin', '登录', '/login', '127.0.0.1', 'Chrome 110.0.0.0', 'Windows', 252, '2023-03-02 19:04:05');
INSERT INTO `sys_log` VALUES (23, 1, 'admin', '登录', '/login', '127.0.0.1', 'Chrome 110.0.0.0', 'Windows', 253, '2023-03-02 19:08:40');
INSERT INTO `sys_log` VALUES (24, 1, 'admin', '登录', '/login', '127.0.0.1', 'Chrome 110.0.0.0', 'Windows', 247, '2023-03-02 19:11:03');
INSERT INTO `sys_log` VALUES (25, 1, 'admin', '登录', '/login', '127.0.0.1', 'Chrome 110.0.0.0', 'Windows', 251, '2023-03-02 19:12:49');
INSERT INTO `sys_log` VALUES (26, 1, 'admin', '登录', '/login', '127.0.0.1', 'Chrome 110.0.0.0', 'Windows', 273, '2023-03-02 19:29:12');
INSERT INTO `sys_log` VALUES (27, 1, 'admin', '登录', '/login', '127.0.0.1', 'Chrome 110.0.0.0', 'Windows', 243, '2023-03-02 19:32:34');
INSERT INTO `sys_log` VALUES (28, 1, 'admin', '登录', '/login', '127.0.0.1', 'Chrome 110.0.0.0', 'Windows', 243, '2023-03-02 19:37:09');
INSERT INTO `sys_log` VALUES (29, 1, 'admin', '登录', '/login', '127.0.0.1', 'Chrome 110.0.0.0', 'Windows', 245, '2023-03-02 19:39:11');
INSERT INTO `sys_log` VALUES (30, 1, 'admin', '退出', '/logout', '127.0.0.1', 'Chrome 110.0.0.0', 'Windows', 0, '2023-03-02 19:54:18');
INSERT INTO `sys_log` VALUES (31, 1, 'admin', '登录', '/login', '127.0.0.1', 'Chrome 110.0.0.0', 'Windows', 38, '2023-03-02 19:54:26');
INSERT INTO `sys_log` VALUES (32, 1, 'admin', '登录', '/login', '127.0.0.1', 'Chrome 110.0.0.0', 'Windows', 270, '2023-03-02 21:52:34');
INSERT INTO `sys_log` VALUES (33, 1, 'admin', '登录', '/login', '127.0.0.1', 'Chrome 110.0.0.0', 'Windows', 238, '2023-03-02 21:54:19');
INSERT INTO `sys_log` VALUES (34, 1, 'admin', '登录', '/login', '127.0.0.1', 'Chrome 110.0.0.0', 'Windows', 235, '2023-03-02 22:00:28');
INSERT INTO `sys_log` VALUES (35, 1, 'admin', '登录', '/login', '127.0.0.1', 'Chrome 110.0.0.0', 'Windows', 237, '2023-03-02 22:15:57');
INSERT INTO `sys_log` VALUES (36, 1, 'admin', '登录', '/login', '127.0.0.1', 'Chrome 110.0.0.0', 'Windows', 243, '2023-03-02 22:26:48');
INSERT INTO `sys_log` VALUES (37, 1, 'admin', '登录', '/login', '127.0.0.1', 'Chrome 110.0.0.0', 'Windows', 235, '2023-03-02 22:28:47');
INSERT INTO `sys_log` VALUES (38, 1, 'admin', '登录', '/login', '127.0.0.1', 'Chrome 110.0.0.0', 'Windows', 234, '2023-03-02 22:30:51');
INSERT INTO `sys_log` VALUES (39, 1, 'admin', '登录', '/login', '127.0.0.1', 'Chrome 110.0.0.0', 'Windows', 235, '2023-03-03 09:14:42');
INSERT INTO `sys_log` VALUES (40, 1, 'admin', '登录', '/login', '127.0.0.1', 'Chrome 110.0.0.0', 'Windows', 235, '2023-03-03 09:18:18');
INSERT INTO `sys_log` VALUES (41, 1, 'admin', '登录', '/login', '127.0.0.1', 'Chrome 110.0.0.0', 'Windows', 233, '2023-03-03 09:22:34');
INSERT INTO `sys_log` VALUES (42, 1, 'admin', '登录', '/login', '127.0.0.1', 'Chrome 110.0.0.0', 'Windows', 248, '2023-03-03 09:30:51');
INSERT INTO `sys_log` VALUES (43, 1, 'admin', '登录', '/login', '127.0.0.1', 'Chrome 110.0.0.0', 'Windows', 256, '2023-03-03 09:39:58');
INSERT INTO `sys_log` VALUES (44, 1, 'admin', '登录', '/login', '127.0.0.1', 'Chrome 110.0.0.0', 'Windows', 248, '2023-03-03 09:44:04');
INSERT INTO `sys_log` VALUES (45, 1, 'admin', '登录', '/login', '127.0.0.1', 'Chrome 110.0.0.0', 'Windows', 267, '2023-03-03 09:46:22');
INSERT INTO `sys_log` VALUES (46, 1, 'admin', '登录', '/login', '127.0.0.1', 'Chrome 110.0.0.0', 'Windows', 235, '2023-03-03 09:54:35');
INSERT INTO `sys_log` VALUES (47, 1, 'admin', '登录', '/login', '127.0.0.1', 'Chrome 110.0.0.0', 'Windows', 238, '2023-03-03 09:56:56');
INSERT INTO `sys_log` VALUES (48, 1, 'admin', '登录', '/login', '127.0.0.1', 'Chrome 110.0.0.0', 'Windows', 234, '2023-03-03 10:01:03');
INSERT INTO `sys_log` VALUES (49, 1, 'admin', '登录', '/login', '127.0.0.1', 'Chrome 110.0.0.0', 'Windows', 237, '2023-03-03 10:04:20');
INSERT INTO `sys_log` VALUES (50, 1, 'admin', '登录', '/login', '127.0.0.1', 'Chrome 110.0.0.0', 'Windows', 233, '2023-03-03 10:07:39');
INSERT INTO `sys_log` VALUES (51, 1, 'admin', '登录', '/login', '127.0.0.1', 'Chrome 110.0.0.0', 'Windows', 232, '2023-03-03 10:10:38');
INSERT INTO `sys_log` VALUES (52, 1, 'admin', '登录', '/login', '127.0.0.1', 'Chrome 110.0.0.0', 'Windows', 234, '2023-03-03 10:13:58');
INSERT INTO `sys_log` VALUES (53, 1, 'admin', '登录', '/login', '127.0.0.1', 'Chrome 110.0.0.0', 'Windows', 243, '2023-03-03 10:15:02');
INSERT INTO `sys_log` VALUES (54, 1, 'admin', '登录', '/login', '127.0.0.1', 'Chrome 110.0.0.0', 'Windows', 242, '2023-03-03 10:15:47');
INSERT INTO `sys_log` VALUES (55, 1, 'admin', '登录', '/login', '127.0.0.1', 'Chrome 110.0.0.0', 'Windows', 40, '2023-03-03 11:06:20');
INSERT INTO `sys_log` VALUES (56, 1, 'admin', '登录', '/login', '127.0.0.1', 'Chrome 110.0.0.0', 'Windows', 266, '2023-03-03 11:09:43');
INSERT INTO `sys_log` VALUES (57, 1, 'admin', '登录', '/login', '127.0.0.1', 'Chrome 110.0.0.0', 'Windows', 232, '2023-03-03 11:10:39');
INSERT INTO `sys_log` VALUES (58, 1, 'admin', '登录', '/login', '127.0.0.1', 'Chrome 110.0.0.0', 'Windows', 232, '2023-03-03 11:17:04');
INSERT INTO `sys_log` VALUES (59, 1, 'admin', '登录', '/login', '127.0.0.1', 'Chrome 110.0.0.0', 'Windows', 233, '2023-03-03 11:23:42');
INSERT INTO `sys_log` VALUES (60, 1, 'admin', '登录', '/login', '127.0.0.1', 'Chrome 110.0.0.0', 'Windows', 234, '2023-03-03 12:07:02');
INSERT INTO `sys_log` VALUES (61, 1, 'admin', '登录', '/login', '127.0.0.1', 'Chrome 110.0.0.0', 'Windows', 238, '2023-03-03 12:16:15');
INSERT INTO `sys_log` VALUES (62, 1, 'admin', '登录', '/login', '127.0.0.1', 'Chrome 110.0.0.0', 'Windows', 235, '2023-03-03 12:41:47');
INSERT INTO `sys_log` VALUES (63, 1, 'admin', '登录', '/login', '127.0.0.1', 'Chrome 110.0.0.0', 'Windows', 234, '2023-03-03 12:46:51');
INSERT INTO `sys_log` VALUES (64, 1, 'admin', '登录', '/login', '127.0.0.1', 'Chrome 110.0.0.0', 'Windows', 239, '2023-03-03 12:50:42');
INSERT INTO `sys_log` VALUES (65, 1, 'admin', '登录', '/login', '127.0.0.1', 'Chrome 110.0.0.0', 'Windows', 236, '2023-03-03 12:54:12');
INSERT INTO `sys_log` VALUES (66, 1, 'admin', '登录', '/login', '127.0.0.1', 'Chrome 110.0.0.0', 'Windows', 237, '2023-03-03 13:00:22');
INSERT INTO `sys_log` VALUES (67, 1, 'admin', '登录', '/login', '127.0.0.1', 'Chrome 110.0.0.0', 'Windows', 6, '2023-03-03 13:37:56');
INSERT INTO `sys_log` VALUES (68, 1, 'admin', '登录', '/login', '127.0.0.1', 'Chrome 110.0.0.0', 'Windows', 235, '2023-03-03 13:39:54');
INSERT INTO `sys_log` VALUES (69, 1, 'admin', '登录', '/login', '127.0.0.1', 'Chrome 110.0.0.0', 'Windows', 236, '2023-03-03 13:43:49');
INSERT INTO `sys_log` VALUES (70, 1, 'admin', '登录', '/login', '127.0.0.1', 'Chrome 110.0.0.0', 'Windows', 234, '2023-03-03 13:46:01');
INSERT INTO `sys_log` VALUES (71, 1, 'admin', '登录', '/login', '127.0.0.1', 'Chrome 110.0.0.0', 'Windows', 311, '2023-03-03 13:47:26');
INSERT INTO `sys_log` VALUES (72, 1, 'admin', '登录', '/login', '127.0.0.1', 'Chrome 110.0.0.0', 'Windows', 240, '2023-03-03 13:54:37');
INSERT INTO `sys_log` VALUES (73, 1, 'admin', '登录', '/login', '127.0.0.1', 'Chrome 110.0.0.0', 'Windows', 41, '2023-03-03 14:37:40');
INSERT INTO `sys_log` VALUES (74, 1, 'admin', '登录', '/login', '127.0.0.1', 'Chrome 110.0.0.0', 'Windows', 245, '2023-03-03 15:17:26');
INSERT INTO `sys_log` VALUES (75, 1, 'admin', '登录', '/login', '127.0.0.1', 'Chrome 110.0.0.0', 'Windows', 266, '2023-03-03 15:33:48');
INSERT INTO `sys_log` VALUES (76, 1, 'admin', '登录', '/login', '127.0.0.1', 'Chrome 110.0.0.0', 'Windows', 8, '2023-03-03 15:34:41');
INSERT INTO `sys_log` VALUES (77, 1, 'admin', '登录', '/login', '127.0.0.1', 'Chrome 110.0.0.0', 'Windows', 234, '2023-03-03 15:36:09');
INSERT INTO `sys_log` VALUES (78, 1, 'admin', '登录', '/login', '127.0.0.1', 'Chrome 110.0.0.0', 'Windows', 234, '2023-03-03 16:11:29');
INSERT INTO `sys_log` VALUES (79, 1, 'admin', '登录', '/login', '127.0.0.1', 'Chrome 110.0.0.0', 'Windows', 234, '2023-03-03 16:27:54');
INSERT INTO `sys_log` VALUES (80, 1, 'admin', '登录', '/login', '127.0.0.1', 'Chrome 110.0.0.0', 'Windows', 30, '2023-03-03 17:18:20');
INSERT INTO `sys_log` VALUES (81, 1, 'admin', '登录', '/login', '127.0.0.1', 'Chrome 110.0.0.0', 'Windows', 242, '2023-03-03 17:32:25');
INSERT INTO `sys_log` VALUES (82, 1, 'admin', '登录', '/login', '127.0.0.1', 'Chrome 110.0.0.0', 'Windows', 236, '2023-03-03 17:35:02');
INSERT INTO `sys_log` VALUES (83, 1, 'admin', '登录', '/login', '127.0.0.1', 'Chrome 110.0.0.0', 'Windows', 235, '2023-03-03 17:37:37');
INSERT INTO `sys_log` VALUES (84, 1, 'admin', '登录', '/login', '127.0.0.1', 'Chrome 110.0.0.0', 'Windows', 242, '2023-03-03 17:40:31');
INSERT INTO `sys_log` VALUES (85, 1, 'admin', '登录', '/login', '127.0.0.1', 'Chrome 110.0.0.0', 'Windows', 241, '2023-03-03 17:41:24');
INSERT INTO `sys_log` VALUES (86, 1, 'admin', '登录', '/login', '127.0.0.1', 'Chrome 110.0.0.0', 'Windows', 237, '2023-03-03 17:45:59');
INSERT INTO `sys_log` VALUES (87, 1, 'admin', '登录', '/login', '127.0.0.1', 'Chrome 110.0.0.0', 'Windows', 235, '2023-03-03 18:13:34');
INSERT INTO `sys_log` VALUES (88, 1, 'admin', '登录', '/login', '127.0.0.1', 'Chrome 110.0.0.0', 'Windows', 239, '2023-03-03 18:15:09');
INSERT INTO `sys_log` VALUES (89, 1, 'admin', '登录', '/login', '127.0.0.1', 'Chrome 110.0.0.0', 'Windows', 233, '2023-03-03 18:17:12');
INSERT INTO `sys_log` VALUES (90, 1, 'admin', '登录', '/login', '127.0.0.1', 'Chrome 110.0.0.0', 'Windows', 247, '2023-03-03 18:21:33');
INSERT INTO `sys_log` VALUES (91, 1, 'admin', '登录', '/login', '127.0.0.1', 'Chrome 110.0.0.0', 'Windows', 236, '2023-03-03 18:23:21');
INSERT INTO `sys_log` VALUES (92, 1, 'admin', '登录', '/login', '127.0.0.1', 'Chrome 110.0.0.0', 'Windows', 234, '2023-03-03 18:28:16');
INSERT INTO `sys_log` VALUES (93, 1, 'admin', '登录', '/login', '127.0.0.1', 'Chrome 110.0.0.0', 'Windows', 234, '2023-03-03 18:36:07');
INSERT INTO `sys_log` VALUES (94, 1, 'admin', '登录', '/login', '127.0.0.1', 'Chrome 110.0.0.0', 'Windows', 238, '2023-03-03 18:38:05');
INSERT INTO `sys_log` VALUES (95, 1, 'admin', '登录', '/login', '127.0.0.1', 'Chrome 110.0.0.0', 'Windows', 240, '2023-03-03 18:42:11');
INSERT INTO `sys_log` VALUES (96, 1, 'admin', '登录', '/login', '127.0.0.1', 'Chrome 110.0.0.0', 'Windows', 234, '2023-03-03 18:43:02');
INSERT INTO `sys_log` VALUES (97, 1, 'admin', '登录', '/login', '127.0.0.1', 'Chrome 110.0.0.0', 'Windows', 8, '2023-03-03 18:44:23');
INSERT INTO `sys_log` VALUES (98, 1, 'admin', '登录', '/login', '127.0.0.1', 'Chrome 110.0.0.0', 'Windows', 236, '2023-03-03 19:05:18');
INSERT INTO `sys_log` VALUES (99, 1, 'admin', '登录', '/login', '127.0.0.1', 'Chrome 110.0.0.0', 'Windows', 238, '2023-03-03 19:12:26');
INSERT INTO `sys_log` VALUES (100, 1, 'admin', '登录', '/login', '127.0.0.1', 'Chrome 110.0.0.0', 'Windows', 226, '2023-03-03 19:57:07');
INSERT INTO `sys_log` VALUES (101, 1, 'admin', '登录', '/login', '127.0.0.1', 'Chrome 110.0.0.0', 'Windows', 222, '2023-03-03 20:11:55');
INSERT INTO `sys_log` VALUES (102, 1, 'admin', '登录', '/login', '127.0.0.1', 'Chrome 110.0.0.0', 'Windows', 40, '2023-03-03 21:20:05');
INSERT INTO `sys_log` VALUES (103, 1, 'admin', '登录', '/login', '127.0.0.1', 'Chrome 110.0.0.0', 'Windows', 10, '2023-03-04 09:30:28');

-- ----------------------------
-- Table structure for sys_menu
-- ----------------------------
DROP TABLE IF EXISTS `sys_menu`;
CREATE TABLE `sys_menu`  (
                             `id` bigint(0) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '主键',
                             `parent_id` bigint(0) NOT NULL COMMENT '父菜单ID。一级菜单为0',
                             `name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '菜单名称',
                             `url` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '菜单URL',
                             `permission` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '授权标识。多个用逗号分隔，如：user:list,user:create',
                             `type` tinyint(0) NULL DEFAULT NULL COMMENT '类型。0：目录；1：菜单；2：按钮；3：导航菜单',
                             `icon` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '菜单图标',
                             `status` tinyint(0) NOT NULL DEFAULT 0 COMMENT '状态。0：正常；1：禁用',
                             `sort` int(0) NOT NULL DEFAULT 0 COMMENT '排序值。越小越靠前',
                             `create_by` bigint(0) NULL DEFAULT NULL COMMENT '创建人',
                             `create_time` timestamp(0) NOT NULL DEFAULT CURRENT_TIMESTAMP(0) COMMENT '创建时间',
                             PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 55 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '菜单表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_menu
-- ----------------------------
INSERT INTO `sys_menu` VALUES (1, 0, '系统管理', NULL, '', 0, 'fa fa-cogs', 0, 0, NULL, '2019-05-06 21:46:33');
INSERT INTO `sys_menu` VALUES (2, 1, '用户管理', 'sys/user/index', 'sys:user:index', 1, NULL, 0, 0, NULL, '2019-05-06 21:46:47');
INSERT INTO `sys_menu` VALUES (3, 1, '菜单管理', 'sys/menu/index', 'sys:menu:index', 1, NULL, 0, 2, NULL, '2019-05-11 11:50:57');
INSERT INTO `sys_menu` VALUES (4, 1, '角色管理', 'sys/role/index', 'sys:role:index', 1, NULL, 0, 3, NULL, '2019-05-11 11:51:31');
INSERT INTO `sys_menu` VALUES (5, 1, '部门管理', 'sys/dept/index', 'sys:dept:index', 1, NULL, 0, 1, NULL, '2019-05-11 11:51:58');
INSERT INTO `sys_menu` VALUES (7, 0, '系统审计', NULL, '', 0, 'fa fa-industry', 0, 1, NULL, '2019-05-11 12:04:09');
INSERT INTO `sys_menu` VALUES (9, 7, '操作日志', 'sys/log/index', 'sys:log:index', 1, NULL, 0, 0, NULL, '2019-05-11 13:26:02');
INSERT INTO `sys_menu` VALUES (10, 2, '添加', NULL, 'sys:user:add', 2, NULL, 0, 0, NULL, '2019-05-07 21:25:46');
INSERT INTO `sys_menu` VALUES (11, 2, '删除', NULL, 'sys:user:del', 2, NULL, 0, 2, NULL, '2019-05-11 14:26:54');
INSERT INTO `sys_menu` VALUES (12, 2, '编辑', NULL, 'sys:user:edit', 2, NULL, 0, 1, NULL, '2019-05-11 14:28:06');
INSERT INTO `sys_menu` VALUES (13, 3, '添加', NULL, 'sys:menu:add', 2, NULL, 0, 0, NULL, '2019-05-11 14:28:59');
INSERT INTO `sys_menu` VALUES (14, 3, '编辑', NULL, 'sys:menu:edit', 2, NULL, 0, 1, NULL, '2019-05-11 14:29:35');
INSERT INTO `sys_menu` VALUES (15, 3, '删除', NULL, 'sys:menu:del', 2, NULL, 0, 2, NULL, '2019-05-11 14:29:55');
INSERT INTO `sys_menu` VALUES (16, 4, '添加', NULL, 'sys:role:add', 2, NULL, 0, 0, NULL, '2019-05-11 14:30:07');
INSERT INTO `sys_menu` VALUES (17, 4, '编辑', NULL, 'sys:role:edit', 2, NULL, 0, 1, NULL, '2019-05-11 14:30:28');
INSERT INTO `sys_menu` VALUES (18, 4, '删除', NULL, 'sys:role:del', 2, NULL, 0, 2, NULL, '2019-05-11 14:30:37');
INSERT INTO `sys_menu` VALUES (19, 4, '权限设置', NULL, 'sys:role:permission', 2, NULL, 0, 3, NULL, '2019-05-11 14:30:37');
INSERT INTO `sys_menu` VALUES (20, 5, '添加', NULL, 'sys:dept:add', 2, NULL, 0, 0, NULL, '2019-05-11 14:30:47');
INSERT INTO `sys_menu` VALUES (21, 5, '编辑', NULL, 'sys:dept:edit', 2, NULL, 0, 1, NULL, '2019-05-11 14:30:58');
INSERT INTO `sys_menu` VALUES (22, 5, '删除', NULL, 'sys:dept:del', 2, NULL, 0, 2, NULL, '2019-05-11 14:31:13');
INSERT INTO `sys_menu` VALUES (23, 2, '重置密码', NULL, 'sys:user:reset', 2, NULL, 0, 3, NULL, '2019-05-12 18:01:10');
INSERT INTO `sys_menu` VALUES (24, 0, 'Druid监控', 'druid/index.html', NULL, 3, 'fa fa-eye', 0, 0, NULL, '2019-05-20 22:43:09');
INSERT INTO `sys_menu` VALUES (25, 0, '代码生成', '', NULL, 0, 'fa fa-bolt', 0, 2, NULL, '2019-06-10 22:47:31');
INSERT INTO `sys_menu` VALUES (26, 25, '生成管理', 'generator/table/index', 'gen:table:index', 1, NULL, 0, 0, NULL, '2019-06-10 22:50:09');
INSERT INTO `sys_menu` VALUES (27, 1, '字典管理', 'sys/dict/index', 'sys:dict:index', 1, NULL, 0, 4, NULL, '2019-08-12 09:47:31');
INSERT INTO `sys_menu` VALUES (28, 27, '添加', NULL, 'sys:dict:add', 2, NULL, 0, 0, NULL, '2019-08-12 09:48:03');
INSERT INTO `sys_menu` VALUES (29, 27, '编辑', NULL, 'sys:dict:edit', 2, NULL, 0, 0, NULL, '2019-08-12 09:48:20');
INSERT INTO `sys_menu` VALUES (30, 27, '删除', NULL, 'sys:dict:del', 2, NULL, 0, 0, NULL, '2019-08-12 09:48:45');
INSERT INTO `sys_menu` VALUES (31, 1, '定时任务', 'schedule/job/index', 'schedule:job:index', 1, NULL, 0, 5, NULL, '2019-08-17 18:13:22');
INSERT INTO `sys_menu` VALUES (32, 31, '添加', NULL, 'schedule:job:add', 2, NULL, 0, 0, NULL, '2019-08-17 18:14:20');
INSERT INTO `sys_menu` VALUES (33, 31, '编辑', NULL, 'schedule:job:edit', 2, NULL, 0, 0, NULL, '2019-08-17 18:14:36');
INSERT INTO `sys_menu` VALUES (34, 31, '删除', NULL, 'schedule:job:del', 2, NULL, 0, 0, NULL, '2019-08-17 18:14:55');
INSERT INTO `sys_menu` VALUES (35, 31, '暂停', NULL, 'schedule:job:pause', 2, NULL, 0, 0, NULL, '2019-08-17 18:16:10');
INSERT INTO `sys_menu` VALUES (36, 31, '恢复', NULL, 'schedule:job:resume', 2, NULL, 0, 0, NULL, '2019-08-17 18:16:28');
INSERT INTO `sys_menu` VALUES (37, 0, '组件管理', NULL, NULL, 0, 'fa fa-th-large', 0, 3, NULL, '2020-03-31 11:14:02');
INSERT INTO `sys_menu` VALUES (38, 37, '富文本', 'sys/component/ueditor/index', 'component:ueditor:index', 1, NULL, 0, 1, NULL, '2020-03-31 11:17:55');
INSERT INTO `sys_menu` VALUES (39, 37, '图标库', 'sys/component/icons/index', 'component:icons:index', 1, NULL, 0, 0, NULL, '2020-03-31 11:22:09');
INSERT INTO `sys_menu` VALUES (40, 0, '班车管理', '', NULL, 0, 'fa fa-bus', 0, 0, NULL, '2023-03-01 19:22:30');
INSERT INTO `sys_menu` VALUES (41, 55, '预约记录', 'bus/routeAppointment/record', 'bus:routeAppointment:record', 1, NULL, 0, 2, NULL, '2023-03-01 19:23:29');
INSERT INTO `sys_menu` VALUES (42, 40, '班车管理', 'bus/route/index', 'bus:route:index', 1, NULL, 0, 0, NULL, '2023-03-01 19:24:14');
INSERT INTO `sys_menu` VALUES (43, 55, '可预约班车列表', 'bus/routeAppointment/index', 'bus:routeAppointment:index', 1, NULL, 0, 1, NULL, '2023-03-01 19:31:12');
INSERT INTO `sys_menu` VALUES (44, 40, '待发车列表', 'bus/routeDepart/index', 'bus:routeDepart:index', 1, NULL, 0, 3, NULL, '2023-03-01 19:33:30');
INSERT INTO `sys_menu` VALUES (45, 40, '发车记录', 'bus/routeDepart/record', 'bus:routeDepart:record', 1, NULL, 0, 4, NULL, '2023-03-01 19:34:51');
INSERT INTO `sys_menu` VALUES (46, 42, '添加', NULL, 'bus:route:add', 2, NULL, 0, 0, NULL, '2023-03-02 12:12:46');
INSERT INTO `sys_menu` VALUES (47, 42, '编辑', NULL, 'bus:route:edit', 2, NULL, 0, 1, NULL, '2023-03-02 12:13:06');
INSERT INTO `sys_menu` VALUES (48, 42, '删除', NULL, 'bus:route:del', 2, NULL, 0, 3, NULL, '2023-03-02 12:13:22');
INSERT INTO `sys_menu` VALUES (49, 43, '立即预约', NULL, 'bus:routeAppointment:add', 2, NULL, 0, 0, NULL, '2023-03-03 10:02:28');
INSERT INTO `sys_menu` VALUES (50, 41, '修改预约', NULL, 'bus:routeAppointment:edit', 2, NULL, 0, 1, NULL, '2023-03-03 10:02:47');
INSERT INTO `sys_menu` VALUES (51, 41, '取消预约', NULL, 'bus:routeAppointment:del', 2, NULL, 0, 2, NULL, '2023-03-03 10:03:24');
INSERT INTO `sys_menu` VALUES (52, 41, '乘车', NULL, 'bus:routeAppointment:depart', 2, NULL, 0, 0, NULL, '2023-03-03 14:04:23');
INSERT INTO `sys_menu` VALUES (53, 44, '立即发车', NULL, 'bus:routeDepart:depart', 2, NULL, 0, 0, NULL, '2023-03-03 16:28:31');
INSERT INTO `sys_menu` VALUES (54, 40, '班车统计', 'bus/routeDepart/list', 'bus:routeDepart:list', 1, NULL, 0, 5, NULL, '2023-03-03 18:37:28');
INSERT INTO `sys_menu` VALUES (55, 0, '班车预约', '', NULL, 0, 'fa fa-thumb-tack', 0, 0, NULL, '2023-03-03 20:37:59');

-- ----------------------------
-- Table structure for sys_role
-- ----------------------------
DROP TABLE IF EXISTS `sys_role`;
CREATE TABLE `sys_role`  (
                             `id` bigint(0) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '主键',
                             `name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '角色名称',
                             `parent_id` bigint(0) NOT NULL COMMENT '父级ID',
                             `type` tinyint(0) NOT NULL COMMENT '类型。0：分类；1：角色',
                             `remarks` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '备注',
                             `create_by` bigint(0) NULL DEFAULT NULL COMMENT '创建人',
                             `update_time` timestamp(0) NOT NULL DEFAULT CURRENT_TIMESTAMP(0) ON UPDATE CURRENT_TIMESTAMP(0) COMMENT '修改时间',
                             `create_time` timestamp(0) NOT NULL DEFAULT CURRENT_TIMESTAMP(0) COMMENT '创建时间',
                             PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 6 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '角色表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_role
-- ----------------------------
INSERT INTO `sys_role` VALUES (1, '系统角色', 0, 0, '', NULL, '2019-05-19 22:32:38', '2019-05-08 22:07:14');
INSERT INTO `sys_role` VALUES (2, '普通员工', 0, 0, '', NULL, '2023-03-03 20:00:40', '2019-05-08 22:17:09');
INSERT INTO `sys_role` VALUES (3, '系统管理员', 1, 1, NULL, NULL, '2019-05-19 22:33:12', '2019-05-19 22:33:12');
INSERT INTO `sys_role` VALUES (4, '普通员工', 2, 1, '', NULL, '2023-03-03 20:00:51', '2019-05-19 22:33:32');
INSERT INTO `sys_role` VALUES (5, '司机', 0, 1, '', NULL, '2023-03-03 20:00:23', '2019-06-07 19:42:14');

-- ----------------------------
-- Table structure for sys_role_menu
-- ----------------------------
DROP TABLE IF EXISTS `sys_role_menu`;
CREATE TABLE `sys_role_menu`  (
                                  `id` bigint(0) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '主键',
                                  `role_id` bigint(0) NOT NULL COMMENT '角色ID',
                                  `menu_id` bigint(0) NOT NULL COMMENT '菜单ID',
                                  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 75 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '角色菜单表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_role_menu
-- ----------------------------
INSERT INTO `sys_role_menu` VALUES (1, 3, 7);
INSERT INTO `sys_role_menu` VALUES (2, 3, 9);
INSERT INTO `sys_role_menu` VALUES (3, 3, 1);
INSERT INTO `sys_role_menu` VALUES (4, 3, 2);
INSERT INTO `sys_role_menu` VALUES (5, 3, 10);
INSERT INTO `sys_role_menu` VALUES (6, 3, 12);
INSERT INTO `sys_role_menu` VALUES (7, 3, 11);
INSERT INTO `sys_role_menu` VALUES (8, 3, 23);
INSERT INTO `sys_role_menu` VALUES (13, 3, 3);
INSERT INTO `sys_role_menu` VALUES (14, 3, 13);
INSERT INTO `sys_role_menu` VALUES (15, 3, 14);
INSERT INTO `sys_role_menu` VALUES (16, 3, 15);
INSERT INTO `sys_role_menu` VALUES (17, 3, 4);
INSERT INTO `sys_role_menu` VALUES (18, 3, 16);
INSERT INTO `sys_role_menu` VALUES (19, 3, 17);
INSERT INTO `sys_role_menu` VALUES (20, 3, 18);
INSERT INTO `sys_role_menu` VALUES (21, 3, 19);
INSERT INTO `sys_role_menu` VALUES (34, 3, 27);
INSERT INTO `sys_role_menu` VALUES (35, 3, 30);
INSERT INTO `sys_role_menu` VALUES (36, 3, 28);
INSERT INTO `sys_role_menu` VALUES (37, 3, 29);
INSERT INTO `sys_role_menu` VALUES (49, 3, 40);
INSERT INTO `sys_role_menu` VALUES (50, 3, 42);
INSERT INTO `sys_role_menu` VALUES (51, 3, 43);
INSERT INTO `sys_role_menu` VALUES (52, 3, 41);
INSERT INTO `sys_role_menu` VALUES (55, 3, 46);
INSERT INTO `sys_role_menu` VALUES (56, 3, 47);
INSERT INTO `sys_role_menu` VALUES (57, 3, 48);
INSERT INTO `sys_role_menu` VALUES (58, 3, 49);
INSERT INTO `sys_role_menu` VALUES (59, 3, 50);
INSERT INTO `sys_role_menu` VALUES (60, 3, 51);
INSERT INTO `sys_role_menu` VALUES (61, 3, 52);
INSERT INTO `sys_role_menu` VALUES (63, 3, 54);
INSERT INTO `sys_role_menu` VALUES (64, 4, 40);
INSERT INTO `sys_role_menu` VALUES (65, 4, 43);
INSERT INTO `sys_role_menu` VALUES (66, 4, 49);
INSERT INTO `sys_role_menu` VALUES (67, 4, 41);
INSERT INTO `sys_role_menu` VALUES (68, 4, 52);
INSERT INTO `sys_role_menu` VALUES (69, 4, 50);
INSERT INTO `sys_role_menu` VALUES (70, 4, 51);
INSERT INTO `sys_role_menu` VALUES (71, 5, 40);
INSERT INTO `sys_role_menu` VALUES (72, 5, 44);
INSERT INTO `sys_role_menu` VALUES (73, 5, 53);
INSERT INTO `sys_role_menu` VALUES (74, 5, 45);

-- ----------------------------
-- Table structure for sys_user
-- ----------------------------
DROP TABLE IF EXISTS `sys_user`;
CREATE TABLE `sys_user`  (
                             `id` bigint(0) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '主键',
                             `dept_id` bigint(0) NOT NULL COMMENT '归属部门',
                             `username` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '登录名',
                             `password` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '密码',
                             `realname` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '姓名',
                             `sex` tinyint(0) NOT NULL DEFAULT 0 COMMENT '性别。0：未知；1：男；2：女',
                             `phone` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '手机号码',
                             `tel` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '固定电话',
                             `email` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '邮箱',
                             `avatar` varchar(300) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '用户头像',
                             `job_title` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '职务名称',
                             `status` tinyint(0) NOT NULL DEFAULT 0 COMMENT '用户状态。0：正常；1：禁用',
                             `sort` int(0) NOT NULL DEFAULT 0 COMMENT '排序。值越小越靠前',
                             `del_flag` int(0) NOT NULL DEFAULT 0 COMMENT '删除标识。0：未删除；1：已删除',
                             `create_by` bigint(0) NULL DEFAULT NULL COMMENT '创建人',
                             `update_time` timestamp(0) NOT NULL DEFAULT CURRENT_TIMESTAMP(0) ON UPDATE CURRENT_TIMESTAMP(0) COMMENT '更新时间',
                             `create_time` timestamp(0) NOT NULL DEFAULT CURRENT_TIMESTAMP(0) COMMENT '创建时间',
                             PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 6 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '用户表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_user
-- ----------------------------
INSERT INTO `sys_user` VALUES (1, 3, 'admin', 'e10adc3949ba59abbe56e057f20f883e', '系统管理员', 1, '18218798428', '123', '123', 'static/image/avatar/tz.jpeg', '超级管理员', 0, 0, 0, NULL, '2019-05-19 17:39:12', '2019-04-30 22:44:17');
INSERT INTO `sys_user` VALUES (2, 2, 'dev', 'e10adc3949ba59abbe56e057f20f883e', '开发人员', 2, '18218798428', '131', '123', NULL, '开发人员', 0, 1, 0, NULL, '2019-05-19 18:34:16', '2019-05-02 12:22:38');
INSERT INTO `sys_user` VALUES (3, 2, 'hanmei', 'e10adc3949ba59abbe56e057f20f883e', '韩梅', 2, '18218798428', '131', '123', NULL, '测试', 0, 1, 0, NULL, '2023-03-03 20:22:36', '2019-05-02 12:22:38');
INSERT INTO `sys_user` VALUES (4, 2, 'zhangsan', 'e10adc3949ba59abbe56e057f20f883e', '张三', 1, '15865235256', '', '1354@qq.com', NULL, '', 0, 0, 0, NULL, '2023-03-02 12:17:29', '2023-03-02 12:17:29');
INSERT INTO `sys_user` VALUES (5, 1, 'lisi', 'e10adc3949ba59abbe56e057f20f883e', '李四', 1, '13547854584', '', '', NULL, '', 0, 0, 0, NULL, '2023-03-02 12:19:19', '2023-03-02 12:19:19');
INSERT INTO `sys_user` VALUES (6, 0, 'lilei', 'e10adc3949ba59abbe56e057f20f883e', '李雷', 1, '15896532568', '', '4894651@qq.com', NULL, '', 0, 0, 0, NULL, '2023-03-03 21:23:44', '2023-03-03 21:23:27');

-- ----------------------------
-- Table structure for sys_user_role
-- ----------------------------
DROP TABLE IF EXISTS `sys_user_role`;
CREATE TABLE `sys_user_role`  (
                                  `id` bigint(0) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '主键',
                                  `user_id` bigint(0) NULL DEFAULT NULL COMMENT '用户ID',
                                  `role_id` bigint(0) NULL DEFAULT NULL COMMENT '角色ID',
                                  `create_time` timestamp(0) NOT NULL DEFAULT CURRENT_TIMESTAMP(0) COMMENT '创建时间',
                                  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 6 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '用户与角色对应关系' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_user_role
-- ----------------------------
INSERT INTO `sys_user_role` VALUES (1, 1, 3, '2019-05-09 22:06:16');
INSERT INTO `sys_user_role` VALUES (2, 2, 5, '2019-05-10 21:25:08');
INSERT INTO `sys_user_role` VALUES (3, 3, 4, '2019-05-10 21:25:08');
INSERT INTO `sys_user_role` VALUES (4, 4, 5, '2023-03-02 12:17:29');
INSERT INTO `sys_user_role` VALUES (5, 5, 5, '2023-03-02 12:19:19');
INSERT INTO `sys_user_role` VALUES (6, 6, 4, '2023-03-03 21:23:27');

SET FOREIGN_KEY_CHECKS = 1;
