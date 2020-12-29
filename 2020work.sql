/*
 Navicat Premium Data Transfer

 Source Server         : localhost
 Source Server Type    : MySQL
 Source Server Version : 50732
 Source Host           : localhost:3306
 Source Schema         : 2020work

 Target Server Type    : MySQL
 Target Server Version : 50732
 File Encoding         : 65001

 Date: 30/12/2020 01:44:39
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for acl_permission
-- ----------------------------
DROP TABLE IF EXISTS `acl_permission`;
CREATE TABLE `acl_permission`  (
  `id` char(19) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '编号',
  `pid` char(19) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '所属上级',
  `title` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '名称',
  `type` tinyint(3) NOT NULL DEFAULT 0 COMMENT '类型(1:菜单,2:按钮)',
  `permission_value` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '权限值',
  `path` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '访问路径',
  `component` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '组件路径',
  `icon` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '图标',
  `status` tinyint(4) NULL DEFAULT NULL COMMENT '状态(0:禁止,1:正常)',
  `is_deleted` tinyint(1) UNSIGNED NOT NULL DEFAULT 0 COMMENT '逻辑删除 1（true）已删除， 0（false）未删除',
  `gmt_create` datetime(0) NULL DEFAULT NULL COMMENT '创建时间',
  `gmt_modified` datetime(0) NULL DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `idx_pid`(`pid`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '权限' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of acl_permission
-- ----------------------------
INSERT INTO `acl_permission` VALUES ('1', '0', '全部数据', 0, NULL, NULL, NULL, NULL, NULL, 0, '2019-11-15 17:13:06', '2019-11-15 17:13:06');
INSERT INTO `acl_permission` VALUES ('1195349439240048642', '1', '讲师管理', 1, NULL, '/edu/teacher', 'Layout', NULL, NULL, 0, '2019-11-15 22:34:49', '2019-11-15 22:34:49');
INSERT INTO `acl_permission` VALUES ('1195349699995734017', '1195349439240048642', '讲师列表', 1, NULL, 'list', '/edu/teacher/list', NULL, NULL, 0, '2019-11-15 22:35:52', '2019-11-15 22:35:52');
INSERT INTO `acl_permission` VALUES ('1195349810561781761', '1195349439240048642', '添加讲师', 1, NULL, 'create', '/edu/teacher/form', NULL, NULL, 0, '2019-11-15 22:36:18', '2019-11-15 22:36:18');
INSERT INTO `acl_permission` VALUES ('1195349876252971010', '1195349810561781761', '添加', 2, 'teacher.add', '', '', NULL, NULL, 0, '2019-11-15 22:36:34', '2019-11-15 22:36:34');
INSERT INTO `acl_permission` VALUES ('1195349979797753857', '1195349699995734017', '查看', 2, 'teacher.list', '', '', NULL, NULL, 0, '2019-11-15 22:36:58', '2019-11-15 22:36:58');
INSERT INTO `acl_permission` VALUES ('1195350117270261762', '1195349699995734017', '修改', 2, 'teacher.update', 'edit/:id', '/edu/teacher/form', NULL, NULL, 0, '2019-11-15 22:37:31', '2019-11-15 22:37:31');
INSERT INTO `acl_permission` VALUES ('1195350188359520258', '1195349699995734017', '删除', 2, 'teacher.remove', '', '', NULL, NULL, 0, '2019-11-15 22:37:48', '2019-11-15 22:37:48');
INSERT INTO `acl_permission` VALUES ('1195350299365969922', '1', '课程分类', 1, NULL, '/edu/subject', 'Layout', NULL, NULL, 0, '2019-11-15 22:38:15', '2019-11-15 22:38:15');
INSERT INTO `acl_permission` VALUES ('1195350397751758850', '1195350299365969922', '课程分类列表', 1, NULL, 'list', '/edu/subject/list', NULL, NULL, 0, '2019-11-15 22:38:38', '2019-11-15 22:38:38');
INSERT INTO `acl_permission` VALUES ('1195350500512206850', '1195350299365969922', '导入课程分类', 1, NULL, 'import', '/edu/subject/import', NULL, NULL, 0, '2019-11-15 22:39:03', '2019-11-15 22:39:03');
INSERT INTO `acl_permission` VALUES ('1195350612172967938', '1195350397751758850', '查看', 2, 'subject.list', '', '', NULL, NULL, 0, '2019-11-15 22:39:29', '2019-11-15 22:39:29');
INSERT INTO `acl_permission` VALUES ('1195350687590748161', '1195350500512206850', '导入', 2, 'subject.import', '', '', NULL, NULL, 0, '2019-11-15 22:39:47', '2019-11-15 22:39:47');
INSERT INTO `acl_permission` VALUES ('1195350831744782337', '1', '课程管理', 1, NULL, '/edu/course', 'Layout', NULL, NULL, 0, '2019-11-15 22:40:21', '2019-11-15 22:40:21');
INSERT INTO `acl_permission` VALUES ('1195350919074385921', '1195350831744782337', '课程列表', 1, NULL, 'list', '/edu/course/list', NULL, NULL, 0, '2019-11-15 22:40:42', '2019-11-15 22:40:42');
INSERT INTO `acl_permission` VALUES ('1195351020463296513', '1195350831744782337', '发布课程', 1, NULL, 'info', '/edu/course/info', NULL, NULL, 0, '2019-11-15 22:41:06', '2019-11-15 22:41:06');
INSERT INTO `acl_permission` VALUES ('1195351159672246274', '1195350919074385921', '完成发布', 2, 'course.publish', 'publish/:id', '/edu/course/publish', NULL, NULL, 0, '2019-11-15 22:41:40', '2019-11-15 22:44:01');
INSERT INTO `acl_permission` VALUES ('1195351326706208770', '1195350919074385921', '编辑课程', 2, 'course.update', 'info/:id', '/edu/course/info', NULL, NULL, 0, '2019-11-15 22:42:19', '2019-11-15 22:42:19');
INSERT INTO `acl_permission` VALUES ('1195351566221938690', '1195350919074385921', '编辑课程大纲', 2, 'chapter.update', 'chapter/:id', '/edu/course/chapter', NULL, NULL, 0, '2019-11-15 22:43:17', '2019-11-15 22:43:17');
INSERT INTO `acl_permission` VALUES ('1195351862889254913', '1', '统计分析', 1, NULL, '/statistics/daily', 'Layout', NULL, NULL, 0, '2019-11-15 22:44:27', '2019-11-15 22:44:27');
INSERT INTO `acl_permission` VALUES ('1195351968841568257', '1195351862889254913', '生成统计', 1, NULL, 'create', '/statistics/daily/create', NULL, NULL, 0, '2019-11-15 22:44:53', '2019-11-15 22:44:53');
INSERT INTO `acl_permission` VALUES ('1195352054917074946', '1195351862889254913', '统计图表', 1, NULL, 'chart', '/statistics/daily/chart', NULL, NULL, 0, '2019-11-15 22:45:13', '2019-11-15 22:45:13');
INSERT INTO `acl_permission` VALUES ('1195352127734386690', '1195352054917074946', '查看', 2, 'daily.list', '', '', NULL, NULL, 0, '2019-11-15 22:45:30', '2019-11-15 22:45:30');
INSERT INTO `acl_permission` VALUES ('1195352215768633346', '1195351968841568257', '生成', 2, 'daily.add', '', '', NULL, NULL, 0, '2019-11-15 22:45:51', '2019-11-15 22:45:51');
INSERT INTO `acl_permission` VALUES ('1195352547621965825', '1', 'CMS管理', 1, NULL, '/cms', 'Layout', NULL, NULL, 0, '2019-11-15 22:47:11', '2019-11-18 10:51:46');
INSERT INTO `acl_permission` VALUES ('1195352856645701633', '1195353513549205505', '查看', 2, 'banner.list', '', NULL, NULL, NULL, 0, '2019-11-15 22:48:24', '2019-11-15 22:48:24');
INSERT INTO `acl_permission` VALUES ('1195352909401657346', '1195353513549205505', '添加', 2, 'banner.add', 'banner/add', '/cms/banner/form', NULL, NULL, 0, '2019-11-15 22:48:37', '2019-11-18 10:52:10');
INSERT INTO `acl_permission` VALUES ('1195353051395624961', '1195353513549205505', '修改', 2, 'banner.update', 'banner/update/:id', '/cms/banner/form', NULL, NULL, 0, '2019-11-15 22:49:11', '2019-11-18 10:52:05');
INSERT INTO `acl_permission` VALUES ('1195353513549205505', '1195352547621965825', 'Bander列表', 1, NULL, 'banner/list', '/cms/banner/list', NULL, NULL, 0, '2019-11-15 22:51:01', '2019-11-18 10:51:29');
INSERT INTO `acl_permission` VALUES ('1195353672110673921', '1195353513549205505', '删除', 2, 'banner.remove', '', '', NULL, NULL, 0, '2019-11-15 22:51:39', '2019-11-15 22:51:39');
INSERT INTO `acl_permission` VALUES ('1195354076890370050', '1', '订单管理', 1, NULL, '/order', 'Layout', NULL, NULL, 0, '2019-11-15 22:53:15', '2019-11-15 22:53:15');
INSERT INTO `acl_permission` VALUES ('1195354153482555393', '1195354076890370050', '订单列表', 1, NULL, 'list', '/order/list', NULL, NULL, 0, '2019-11-15 22:53:33', '2019-11-15 22:53:58');
INSERT INTO `acl_permission` VALUES ('1195354315093282817', '1195354153482555393', '查看', 2, 'order.list', '', '', NULL, NULL, 0, '2019-11-15 22:54:12', '2019-11-15 22:54:12');
INSERT INTO `acl_permission` VALUES ('1343875433787043842', '1', '权限管理', 1, '', '/acl-permission/menu/list', NULL, NULL, NULL, 0, '2020-12-29 19:04:06', '2020-12-29 19:04:06');
INSERT INTO `acl_permission` VALUES ('1343875564854849538', '1343875433787043842', '用户管理', 1, '', '/acl-user/user/list', NULL, NULL, NULL, 0, '2020-12-29 19:04:37', '2020-12-29 19:04:37');
INSERT INTO `acl_permission` VALUES ('1343875708920803329', '1343875433787043842', '菜单管理', 1, '', '/acl-permission/menu/list', NULL, NULL, NULL, 0, '2020-12-29 19:05:12', '2020-12-29 19:05:12');
INSERT INTO `acl_permission` VALUES ('1343875801275183105', '1343875433787043842', '角色管理', 1, '', '/acl-role/role/list', NULL, NULL, NULL, 0, '2020-12-29 19:05:34', '2020-12-29 19:05:34');
INSERT INTO `acl_permission` VALUES ('1343957564701822977', '1343875564854849538', '添加', 2, 'USER_ADD', '', NULL, NULL, NULL, 0, '2020-12-30 00:30:28', '2020-12-30 00:41:14');
INSERT INTO `acl_permission` VALUES ('1343957855211900930', '1343875801275183105', '添加', 2, 'ROLE_ADD', '', NULL, NULL, NULL, 0, '2020-12-30 00:31:37', '2020-12-30 00:41:20');
INSERT INTO `acl_permission` VALUES ('1343957973180895234', '1343875801275183105', '修改', 2, 'ROLE_EDIT', '', NULL, NULL, NULL, 0, '2020-12-30 00:32:05', '2020-12-30 00:32:05');
INSERT INTO `acl_permission` VALUES ('1343958073051467777', '1343875801275183105', '删除', 2, 'ROLE_DEL', '', NULL, NULL, NULL, 0, '2020-12-30 00:32:29', '2020-12-30 00:32:29');
INSERT INTO `acl_permission` VALUES ('1343958218451210242', '1343875564854849538', '修改', 2, 'USER_EDIT', '', NULL, NULL, NULL, 0, '2020-12-30 00:33:03', '2020-12-30 00:33:03');
INSERT INTO `acl_permission` VALUES ('1343958280866648065', '1343875564854849538', '删除', 2, 'USER_DEL', '', NULL, NULL, NULL, 0, '2020-12-30 00:33:18', '2020-12-30 00:33:18');

-- ----------------------------
-- Table structure for acl_role
-- ----------------------------
DROP TABLE IF EXISTS `acl_role`;
CREATE TABLE `acl_role`  (
  `id` char(19) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '角色id',
  `role_name` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '角色名称',
  `role_code` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '角色编码',
  `remark` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '备注',
  `is_deleted` tinyint(1) UNSIGNED NOT NULL DEFAULT 0 COMMENT '逻辑删除 1（true）已删除， 0（false）未删除',
  `gmt_create` datetime(0) NOT NULL COMMENT '创建时间',
  `gmt_modified` datetime(0) NOT NULL COMMENT '更新时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of acl_role
-- ----------------------------
INSERT INTO `acl_role` VALUES ('1', '普通管理员1', NULL, NULL, 0, '2019-11-11 13:09:32', '2020-12-22 09:31:56');
INSERT INTO `acl_role` VALUES ('1193757683205607426', '课程管理员', NULL, NULL, 0, '2019-11-11 13:09:45', '2019-11-18 10:25:44');
INSERT INTO `acl_role` VALUES ('1196300996034977794', 'test', NULL, NULL, 0, '2019-11-18 13:35:58', '2020-12-22 09:34:08');
INSERT INTO `acl_role` VALUES ('1343943617718358018', '超级管理员', NULL, '超级管理员', 0, '2020-12-29 23:35:02', '2020-12-29 23:35:02');

-- ----------------------------
-- Table structure for acl_role_permission
-- ----------------------------
DROP TABLE IF EXISTS `acl_role_permission`;
CREATE TABLE `acl_role_permission`  (
  `id` char(19) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '',
  `role_id` char(19) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '',
  `permission_id` char(19) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '',
  `is_deleted` tinyint(1) UNSIGNED NOT NULL DEFAULT 0 COMMENT '逻辑删除 1（true）已删除， 0（false）未删除',
  `gmt_create` datetime(0) NOT NULL COMMENT '创建时间',
  `gmt_modified` datetime(0) NOT NULL COMMENT '更新时间',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `idx_role_id`(`role_id`) USING BTREE,
  INDEX `idx_permission_id`(`permission_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '角色权限' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of acl_role_permission
-- ----------------------------
INSERT INTO `acl_role_permission` VALUES ('1343955410125598721', '1193757683205607426', '1', 0, '2020-12-30 00:21:54', '2020-12-30 00:21:54');
INSERT INTO `acl_role_permission` VALUES ('1343955410125598722', '1193757683205607426', '1195350831744782337', 0, '2020-12-30 00:21:54', '2020-12-30 00:21:54');
INSERT INTO `acl_role_permission` VALUES ('1343955410125598723', '1193757683205607426', '1195350919074385921', 0, '2020-12-30 00:21:54', '2020-12-30 00:21:54');
INSERT INTO `acl_role_permission` VALUES ('1343955410125598724', '1193757683205607426', '1195351159672246274', 0, '2020-12-30 00:21:54', '2020-12-30 00:21:54');
INSERT INTO `acl_role_permission` VALUES ('1343955410125598725', '1193757683205607426', '1195351326706208770', 0, '2020-12-30 00:21:54', '2020-12-30 00:21:54');
INSERT INTO `acl_role_permission` VALUES ('1343955410125598726', '1193757683205607426', '1195351566221938690', 0, '2020-12-30 00:21:54', '2020-12-30 00:21:54');
INSERT INTO `acl_role_permission` VALUES ('1343955410125598727', '1193757683205607426', '1195351020463296513', 0, '2020-12-30 00:21:54', '2020-12-30 00:21:54');
INSERT INTO `acl_role_permission` VALUES ('1343955729471516673', '1196300996034977794', '1', 0, '2020-12-30 00:23:10', '2020-12-30 00:23:10');
INSERT INTO `acl_role_permission` VALUES ('1343968132686970882', '1343943617718358018', '1', 0, '2020-12-30 01:12:27', '2020-12-30 01:12:27');
INSERT INTO `acl_role_permission` VALUES ('1343968132707942401', '1343943617718358018', '1343875433787043842', 0, '2020-12-30 01:12:27', '2020-12-30 01:12:27');
INSERT INTO `acl_role_permission` VALUES ('1343968132707942402', '1343943617718358018', '1343875564854849538', 0, '2020-12-30 01:12:27', '2020-12-30 01:12:27');
INSERT INTO `acl_role_permission` VALUES ('1343968132707942403', '1343943617718358018', '1343957564701822977', 0, '2020-12-30 01:12:27', '2020-12-30 01:12:27');
INSERT INTO `acl_role_permission` VALUES ('1343968132707942404', '1343943617718358018', '1343958218451210242', 0, '2020-12-30 01:12:27', '2020-12-30 01:12:27');
INSERT INTO `acl_role_permission` VALUES ('1343968132707942405', '1343943617718358018', '1343958280866648065', 0, '2020-12-30 01:12:27', '2020-12-30 01:12:27');
INSERT INTO `acl_role_permission` VALUES ('1343968132770856962', '1343943617718358018', '1343875708920803329', 0, '2020-12-30 01:12:27', '2020-12-30 01:12:27');
INSERT INTO `acl_role_permission` VALUES ('1343968132770856963', '1343943617718358018', '1343875801275183105', 0, '2020-12-30 01:12:27', '2020-12-30 01:12:27');
INSERT INTO `acl_role_permission` VALUES ('1343968132770856964', '1343943617718358018', '1343957855211900930', 0, '2020-12-30 01:12:27', '2020-12-30 01:12:27');
INSERT INTO `acl_role_permission` VALUES ('1343968132770856965', '1343943617718358018', '1343957973180895234', 0, '2020-12-30 01:12:27', '2020-12-30 01:12:27');
INSERT INTO `acl_role_permission` VALUES ('1343968132770856966', '1343943617718358018', '1343958073051467777', 0, '2020-12-30 01:12:27', '2020-12-30 01:12:27');

-- ----------------------------
-- Table structure for acl_user
-- ----------------------------
DROP TABLE IF EXISTS `acl_user`;
CREATE TABLE `acl_user`  (
  `id` varchar(19) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '会员id',
  `username` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '微信openid',
  `password` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '密码',
  `nick_name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '昵称',
  `salt` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '用户头像',
  `token` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '用户签名',
  `is_deleted` tinyint(1) UNSIGNED NOT NULL DEFAULT 0 COMMENT '逻辑删除 1（true）已删除， 0（false）未删除',
  `gmt_create` datetime(0) NOT NULL COMMENT '创建时间',
  `gmt_modified` datetime(0) NOT NULL COMMENT '更新时间',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `uk_username`(`username`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '用户表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of acl_user
-- ----------------------------
INSERT INTO `acl_user` VALUES ('1', 'admin', '96e79218965eb72c92a549dd5a330112', 'admin', '', NULL, 0, '2019-11-01 10:39:47', '2020-12-29 23:36:23');
INSERT INTO `acl_user` VALUES ('1341194645878628354', '22', '96e79218965eb72c92a549dd5a330112', '1', NULL, NULL, 0, '2020-12-22 09:31:36', '2020-12-22 09:31:36');
INSERT INTO `acl_user` VALUES ('1341695065864650753', 'tom', 'e10adc3949ba59abbe56e057f20f883e', 'tom', NULL, NULL, 0, '2020-12-23 18:40:06', '2020-12-23 18:40:06');
INSERT INTO `acl_user` VALUES ('1343484751352225794', 'eqeqwe', 'qwe', NULL, NULL, NULL, 0, '2020-12-28 17:11:40', '2020-12-28 17:11:40');
INSERT INTO `acl_user` VALUES ('1343484820868620290', 'eqeqw wer', 'qwe', NULL, NULL, NULL, 1, '2020-12-28 17:11:57', '2020-12-28 20:58:01');
INSERT INTO `acl_user` VALUES ('1343547404766412802', 'tom234', '234', NULL, NULL, NULL, 0, '2020-12-28 21:20:38', '2020-12-28 21:20:38');
INSERT INTO `acl_user` VALUES ('1343547416627904514', 'tom234123', '234', NULL, NULL, NULL, 0, '2020-12-28 21:20:41', '2020-12-28 21:20:41');
INSERT INTO `acl_user` VALUES ('1343547438161461250', 'tom2342', '234', NULL, NULL, NULL, 1, '2020-12-28 21:20:46', '2020-12-28 21:35:49');
INSERT INTO `acl_user` VALUES ('1343547449817432065', 'df', '234', NULL, NULL, NULL, 1, '2020-12-28 21:20:49', '2020-12-28 21:36:24');
INSERT INTO `acl_user` VALUES ('1343547459988619265', 'dfddf', '234', NULL, NULL, NULL, 1, '2020-12-28 21:20:51', '2020-12-29 19:01:18');
INSERT INTO `acl_user` VALUES ('1343955043916722177', 'session', '123', NULL, NULL, NULL, 0, '2020-12-30 00:20:27', '2020-12-30 00:20:34');
INSERT INTO `acl_user` VALUES ('2', 'test', '96e79218965eb72c92a549dd5a330112', 'test', NULL, NULL, 0, '2019-11-01 16:36:07', '2019-11-01 16:40:08');

-- ----------------------------
-- Table structure for acl_user_role
-- ----------------------------
DROP TABLE IF EXISTS `acl_user_role`;
CREATE TABLE `acl_user_role`  (
  `id` char(19) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '主键id',
  `role_id` char(19) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '0' COMMENT '角色id',
  `user_id` char(19) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '0' COMMENT '用户id',
  `is_deleted` tinyint(1) UNSIGNED NOT NULL DEFAULT 0 COMMENT '逻辑删除 1（true）已删除， 0（false）未删除',
  `gmt_create` datetime(0) NOT NULL COMMENT '创建时间',
  `gmt_modified` datetime(0) NOT NULL COMMENT '更新时间',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `idx_role_id`(`role_id`) USING BTREE,
  INDEX `idx_user_id`(`user_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of acl_user_role
-- ----------------------------
INSERT INTO `acl_user_role` VALUES ('1341699187330367489', '1193757683205607426', '2', 0, '2020-12-23 18:56:28', '2020-12-23 18:56:28');
INSERT INTO `acl_user_role` VALUES ('1343466061109981185', '1193757683205607426', '1342310795677102000', 0, '2020-12-28 15:57:24', '2020-12-28 15:57:24');
INSERT INTO `acl_user_role` VALUES ('1343466061277753345', '1196300996034977794', '1342310795677102000', 0, '2020-12-28 15:57:24', '2020-12-28 15:57:24');
INSERT INTO `acl_user_role` VALUES ('1343481589165740033', '1193757683205607426', '1341194645878628354', 0, '2020-12-28 16:59:06', '2020-12-28 16:59:06');
INSERT INTO `acl_user_role` VALUES ('1343481589165740034', '1196300996034977794', '1341194645878628354', 0, '2020-12-28 16:59:06', '2020-12-28 16:59:06');
INSERT INTO `acl_user_role` VALUES ('1343482741995343873', '1193757683205607426', '1342310795677102081', 0, '2020-12-28 17:03:41', '2020-12-28 17:03:41');
INSERT INTO `acl_user_role` VALUES ('1343483301008011266', '1193757683205607426', '1343483279008886786', 0, '2020-12-28 17:05:54', '2020-12-28 17:05:54');
INSERT INTO `acl_user_role` VALUES ('1343483301008011267', '1196300996034977794', '1343483279008886786', 0, '2020-12-28 17:05:54', '2020-12-28 17:05:54');
INSERT INTO `acl_user_role` VALUES ('1343483313456705538', '1193757683205607426', '1343483257110425602', 0, '2020-12-28 17:05:57', '2020-12-28 17:05:57');
INSERT INTO `acl_user_role` VALUES ('1343483313523814402', '1196300996034977794', '1343483257110425602', 0, '2020-12-28 17:05:57', '2020-12-28 17:05:57');
INSERT INTO `acl_user_role` VALUES ('1343484234324570114', '1196300996034977794', '1343484213982195713', 0, '2020-12-28 17:09:37', '2020-12-28 17:09:37');
INSERT INTO `acl_user_role` VALUES ('1343504425418797057', '1196300996034977794', '1343484770297896961', 0, '2020-12-28 18:29:51', '2020-12-28 18:29:51');
INSERT INTO `acl_user_role` VALUES ('1343541714639409154', '1193757683205607426', '1343484820868620290', 1, '2020-12-28 20:58:01', '2020-12-28 20:58:01');
INSERT INTO `acl_user_role` VALUES ('1343541714639409155', '1196300996034977794', '1343484820868620290', 1, '2020-12-28 20:58:01', '2020-12-28 20:58:01');
INSERT INTO `acl_user_role` VALUES ('1343551372183740417', '1196300996034977794', '1343547449817432065', 1, '2020-12-28 21:36:24', '2020-12-28 21:36:24');
INSERT INTO `acl_user_role` VALUES ('1343943956018335746', '1343943617718358018', '1', 0, '2020-12-29 23:36:23', '2020-12-29 23:36:23');
INSERT INTO `acl_user_role` VALUES ('1343955076644876289', '1193757683205607426', '1343955043916722177', 0, '2020-12-30 00:20:34', '2020-12-30 00:20:34');

-- ----------------------------
-- Table structure for goods
-- ----------------------------
DROP TABLE IF EXISTS `goods`;
CREATE TABLE `goods`  (
  `id` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '商品id',
  `title` varchar(250) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '商品标题',
  `price` decimal(10, 2) NULL DEFAULT 0.00 COMMENT '商品价格',
  `cover` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '商品封面',
  `subject_first_id` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '一级分类',
  `subject_second_id` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '二级分类',
  `intro` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '商品简介',
  `member_id` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '提供该商品的商家id',
  `view_count` bigint(10) NULL DEFAULT 0 COMMENT '商品浏览人数',
  `buy_count` bigint(10) NULL DEFAULT 0 COMMENT '商品购买人数',
  `review_count` bigint(10) NULL DEFAULT 0 COMMENT '商品评论人数',
  `gmt_create` datetime(0) NOT NULL COMMENT '创建时间',
  `gmt_modified` datetime(0) NOT NULL COMMENT '更新时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '商品表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of goods
-- ----------------------------

-- ----------------------------
-- Table structure for review
-- ----------------------------
DROP TABLE IF EXISTS `review`;
CREATE TABLE `review`  (
  `id` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '评论id编号',
  `goods_id` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '被评论的商品id',
  `content` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '评论内容',
  `member_id` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '发表评论的用户',
  `nickname` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '用户昵称',
  `specifications` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '发表评论用户购买的商品规格',
  `gmt_create` datetime(0) NOT NULL COMMENT '创建时间',
  `gmt_modified` datetime(0) NOT NULL COMMENT '更新时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '评论表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of review
-- ----------------------------

-- ----------------------------
-- Table structure for specification
-- ----------------------------
DROP TABLE IF EXISTS `specification`;
CREATE TABLE `specification`  (
  `id` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '商品规格id',
  `goods_id` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '该规格指向的商品',
  `price` decimal(10, 2) NULL DEFAULT 0.00 COMMENT '该规格的价格',
  `count` int(11) NULL DEFAULT 0 COMMENT '库存',
  `cover` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '该规格的图片',
  `gmt_create` datetime(0) NOT NULL COMMENT '创建时间',
  `gmt_modified` datetime(0) NOT NULL COMMENT '修改时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '规格表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of specification
-- ----------------------------

-- ----------------------------
-- Table structure for subject
-- ----------------------------
DROP TABLE IF EXISTS `subject`;
CREATE TABLE `subject`  (
  `id` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '类别id',
  `title` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '类别名称',
  `parent_id` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '0' COMMENT '父id',
  `gmt_create` datetime(0) NOT NULL COMMENT '创建时间',
  `gmt_modified` datetime(0) NOT NULL COMMENT '修改时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '类别表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of subject
-- ----------------------------

-- ----------------------------
-- Table structure for t_order
-- ----------------------------
DROP TABLE IF EXISTS `t_order`;
CREATE TABLE `t_order`  (
  `id` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '订单id',
  `goods_id` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '商品id',
  `member_id` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '用户id',
  `price` decimal(10, 2) NULL DEFAULT 0.00 COMMENT '商品价格',
  `specification` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '商品规格',
  `cover` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '商品封面',
  `buy_count` int(11) NULL DEFAULT NULL COMMENT '购买数量',
  `title` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '商品标题',
  `gmt_create` datetime(0) NOT NULL COMMENT '创建时间',
  `gmt_modified` datetime(0) NOT NULL COMMENT '修改时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '订单表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of t_order
-- ----------------------------

-- ----------------------------
-- Table structure for testnn
-- ----------------------------
DROP TABLE IF EXISTS `testnn`;
CREATE TABLE `testnn`  (
  `name` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `id` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `addr` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `gmt_create` datetime(0) NULL DEFAULT NULL,
  `gmt_modified` datetime(0) NULL DEFAULT NULL,
  `birth` date NULL DEFAULT NULL,
  `intro` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of testnn
-- ----------------------------
INSERT INTO `testnn` VALUES ('vbs', '1339093220604297217', 'string', '2020-12-16 14:21:18', '2020-12-16 14:21:18', '2020-12-16', '阿斯蒂芬');
INSERT INTO `testnn` VALUES ('string', '1339182438668050434', 'string', '2020-12-16 20:15:49', '2020-12-16 20:15:49', '2020-12-16', 'string');
INSERT INTO `testnn` VALUES ('周伟标', '1339189560747298818', '上海市,上海市,闵行区,莘松路958弄', '2020-12-16 20:44:07', '2020-12-16 20:44:07', '2020-12-20', '');

-- ----------------------------
-- Table structure for ucenter_member
-- ----------------------------
DROP TABLE IF EXISTS `ucenter_member`;
CREATE TABLE `ucenter_member`  (
  `id` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '用户id',
  `name` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '用户姓名',
  `mobile` varchar(11) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '用户手机号码',
  `email` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '电子邮箱',
  `address` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '用户地址',
  `nickname` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '用户昵称',
  `password` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '密码',
  `sex` varchar(2) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '性别（1代表男，2代表女）',
  `age` int(3) NULL DEFAULT NULL COMMENT '年龄',
  `avatar` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '用户头像',
  `is_disable` varchar(2) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '0' COMMENT '账号是否被禁用（0没有  1禁用）',
  `is_delete` varchar(2) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '0' COMMENT '账号是否删除(0没有， 1禁用)',
  `description` varchar(250) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '用户简介',
  `gmt_create` datetime(0) NOT NULL COMMENT '创建时间',
  `gmt_modified` datetime(0) NOT NULL COMMENT '更新时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '用户表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of ucenter_member
-- ----------------------------
INSERT INTO `ucenter_member` VALUES ('1339220875139989506', NULL, NULL, NULL, NULL, 'tom', '202cb962ac59075b964b07152d234b70', NULL, NULL, NULL, '0', '0', NULL, '2020-12-16 22:48:33', '2020-12-16 22:48:33');

SET FOREIGN_KEY_CHECKS = 1;
