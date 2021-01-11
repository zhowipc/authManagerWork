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

 Date: 11/01/2021 23:36:31
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
INSERT INTO `acl_permission` VALUES ('1343875433787043842', '1', '权限管理', 1, 'AUTH', '/acl-permission/menu/list', NULL, NULL, NULL, 0, '2020-12-29 19:04:06', '2020-12-29 19:04:06');
INSERT INTO `acl_permission` VALUES ('1343875564854849538', '1343875433787043842', '用户管理', 1, 'auth.user', '/acl-user/user/list', NULL, NULL, NULL, 0, '2020-12-29 19:04:37', '2020-12-29 19:04:37');
INSERT INTO `acl_permission` VALUES ('1343875708920803329', '1343875433787043842', '菜单管理', 1, 'AUTH_MENU', '/acl-permission/menu/list', NULL, NULL, NULL, 0, '2020-12-29 19:05:12', '2020-12-29 19:05:12');
INSERT INTO `acl_permission` VALUES ('1343875801275183105', '1343875433787043842', '角色管理', 1, 'auth.role', '/acl-role/role/list', NULL, NULL, NULL, 0, '2020-12-29 19:05:34', '2020-12-29 19:05:34');
INSERT INTO `acl_permission` VALUES ('1344132190828507137', '1', '商品管理', 1, 'goods', '/goods/list', NULL, NULL, NULL, 0, '2020-12-30 12:04:22', '2020-12-30 12:04:22');
INSERT INTO `acl_permission` VALUES ('1344208844275871745', '1', '商品展示', 1, 'goods.toShow', '/goods/toshow', NULL, NULL, NULL, 0, '2020-12-30 17:08:57', '2020-12-30 17:08:57');
INSERT INTO `acl_permission` VALUES ('1344349150971469825', '1', '订单管理', 1, 't-order.list', '/t-order/list', NULL, NULL, NULL, 0, '2020-12-31 02:26:29', '2020-12-31 02:26:29');
INSERT INTO `acl_permission` VALUES ('1345636906230104065', '1343875433787043842', '123', 1, '', '', NULL, NULL, NULL, 0, '2021-01-03 15:43:34', '2021-01-11 23:29:14');

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
INSERT INTO `acl_role` VALUES ('1196300996034977794', 'test', NULL, NULL, 0, '2019-11-18 13:35:58', '2020-12-22 09:34:08');
INSERT INTO `acl_role` VALUES ('1344887044329037826', 'admin', NULL, 'ddd', 0, '2021-01-01 14:03:53', '2021-01-01 14:03:53');
INSERT INTO `acl_role` VALUES ('1344887407731924993', '超级管理员', NULL, '', 0, '2021-01-01 14:05:19', '2021-01-01 14:05:19');

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
INSERT INTO `acl_role_permission` VALUES ('1344950843887075330', '1344887044329037826', '1', 0, '2021-01-01 18:17:24', '2021-01-01 18:17:24');
INSERT INTO `acl_role_permission` VALUES ('1344950844012904449', '1344887044329037826', '1344132190828507137', 0, '2021-01-01 18:17:24', '2021-01-01 18:17:24');
INSERT INTO `acl_role_permission` VALUES ('1344950844012904450', '1344887044329037826', '1344208844275871745', 0, '2021-01-01 18:17:24', '2021-01-01 18:17:24');
INSERT INTO `acl_role_permission` VALUES ('1344950844080013314', '1344887044329037826', '1344349150971469825', 0, '2021-01-01 18:17:24', '2021-01-01 18:17:24');
INSERT INTO `acl_role_permission` VALUES ('1344950870755786753', '1196300996034977794', '1', 0, '2021-01-01 18:17:30', '2021-01-01 18:17:30');
INSERT INTO `acl_role_permission` VALUES ('1344950870822895618', '1196300996034977794', '1344208844275871745', 0, '2021-01-01 18:17:30', '2021-01-01 18:17:30');
INSERT INTO `acl_role_permission` VALUES ('1344950870822895619', '1196300996034977794', '1344349150971469825', 0, '2021-01-01 18:17:30', '2021-01-01 18:17:30');
INSERT INTO `acl_role_permission` VALUES ('1344950894310998018', '1', '1', 0, '2021-01-01 18:17:36', '2021-01-01 18:17:36');
INSERT INTO `acl_role_permission` VALUES ('1344950894310998019', '1', '1343875433787043842', 0, '2021-01-01 18:17:36', '2021-01-01 18:17:36');
INSERT INTO `acl_role_permission` VALUES ('1344950894310998020', '1', '1343875564854849538', 0, '2021-01-01 18:17:36', '2021-01-01 18:17:36');
INSERT INTO `acl_role_permission` VALUES ('1344950894378106882', '1', '1343875708920803329', 0, '2021-01-01 18:17:36', '2021-01-01 18:17:36');
INSERT INTO `acl_role_permission` VALUES ('1344950894378106883', '1', '1343875801275183105', 0, '2021-01-01 18:17:36', '2021-01-01 18:17:36');
INSERT INTO `acl_role_permission` VALUES ('1348653263108534274', '1344887407731924993', '1', 0, '2021-01-11 23:29:29', '2021-01-11 23:29:29');
INSERT INTO `acl_role_permission` VALUES ('1348653263108534275', '1344887407731924993', '1343875433787043842', 0, '2021-01-11 23:29:29', '2021-01-11 23:29:29');
INSERT INTO `acl_role_permission` VALUES ('1348653263108534276', '1344887407731924993', '1343875564854849538', 0, '2021-01-11 23:29:29', '2021-01-11 23:29:29');
INSERT INTO `acl_role_permission` VALUES ('1348653263108534277', '1344887407731924993', '1343875708920803329', 0, '2021-01-11 23:29:29', '2021-01-11 23:29:29');
INSERT INTO `acl_role_permission` VALUES ('1348653263167254529', '1344887407731924993', '1343875801275183105', 0, '2021-01-11 23:29:29', '2021-01-11 23:29:29');
INSERT INTO `acl_role_permission` VALUES ('1348653263167254530', '1344887407731924993', '1345636906230104065', 0, '2021-01-11 23:29:29', '2021-01-11 23:29:29');
INSERT INTO `acl_role_permission` VALUES ('1348653263167254531', '1344887407731924993', '1344132190828507137', 0, '2021-01-11 23:29:29', '2021-01-11 23:29:29');
INSERT INTO `acl_role_permission` VALUES ('1348653263167254532', '1344887407731924993', '1344208844275871745', 0, '2021-01-11 23:29:29', '2021-01-11 23:29:29');
INSERT INTO `acl_role_permission` VALUES ('1348653263167254533', '1344887407731924993', '1344349150971469825', 0, '2021-01-11 23:29:29', '2021-01-11 23:29:29');

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
INSERT INTO `acl_user` VALUES ('1', 'admin', '96e79218965eb72c92a549dd5a330112', 'admin', '', NULL, 0, '2019-11-01 10:39:47', '2021-01-01 18:34:38');
INSERT INTO `acl_user` VALUES ('1212', 'ss', 'df', NULL, NULL, NULL, 0, '2020-12-12 03:02:00', '2020-12-12 03:44:00');
INSERT INTO `acl_user` VALUES ('12121', 'ss1', 'df', NULL, NULL, NULL, 0, '2020-12-12 03:02:00', '2020-12-12 03:44:00');
INSERT INTO `acl_user` VALUES ('12122', 'ss2', 'df', NULL, NULL, NULL, 0, '2020-12-12 03:02:00', '2020-12-12 03:44:00');
INSERT INTO `acl_user` VALUES ('1344472195585392641', '123', '202cb962ac59075b964b07152d234b70', NULL, NULL, NULL, 0, '2020-12-31 10:35:25', '2021-01-01 14:22:06');
INSERT INTO `acl_user` VALUES ('1344475531864702978', 'jack', '202cb962ac59075b964b07152d234b70', NULL, NULL, NULL, 0, '2020-12-31 10:48:41', '2021-01-01 14:37:06');
INSERT INTO `acl_user` VALUES ('1344476885567930369', 'guest', '202cb962ac59075b964b07152d234b70', NULL, NULL, NULL, 0, '2020-12-31 10:54:03', '2021-01-01 13:12:40');
INSERT INTO `acl_user` VALUES ('2', 'test', '96e79218965eb72c92a549dd5a330112', 'test', NULL, NULL, 0, '2019-11-01 16:36:07', '2021-01-01 18:34:32');

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
INSERT INTO `acl_user_role` VALUES ('1343466061277753345', '1196300996034977794', '1342310795677102000', 0, '2020-12-28 15:57:24', '2020-12-28 15:57:24');
INSERT INTO `acl_user_role` VALUES ('1343481589165740034', '1196300996034977794', '1341194645878628354', 0, '2020-12-28 16:59:06', '2020-12-28 16:59:06');
INSERT INTO `acl_user_role` VALUES ('1343483301008011267', '1196300996034977794', '1343483279008886786', 0, '2020-12-28 17:05:54', '2020-12-28 17:05:54');
INSERT INTO `acl_user_role` VALUES ('1343483313523814402', '1196300996034977794', '1343483257110425602', 0, '2020-12-28 17:05:57', '2020-12-28 17:05:57');
INSERT INTO `acl_user_role` VALUES ('1343484234324570114', '1196300996034977794', '1343484213982195713', 0, '2020-12-28 17:09:37', '2020-12-28 17:09:37');
INSERT INTO `acl_user_role` VALUES ('1343504425418797057', '1196300996034977794', '1343484770297896961', 0, '2020-12-28 18:29:51', '2020-12-28 18:29:51');
INSERT INTO `acl_user_role` VALUES ('1343541714639409155', '1196300996034977794', '1343484820868620290', 1, '2020-12-28 20:58:01', '2020-12-28 20:58:01');
INSERT INTO `acl_user_role` VALUES ('1343551372183740417', '1196300996034977794', '1343547449817432065', 1, '2020-12-28 21:36:24', '2020-12-28 21:36:24');
INSERT INTO `acl_user_role` VALUES ('1344874156914663426', '1196300996034977794', '1344476885567930369', 0, '2021-01-01 13:12:40', '2021-01-01 13:12:40');
INSERT INTO `acl_user_role` VALUES ('1344891630808764418', '1344887407731924993', '1344472195585392641', 0, '2021-01-01 14:22:06', '2021-01-01 14:22:06');
INSERT INTO `acl_user_role` VALUES ('1344895404767993857', '1', '1344475531864702978', 0, '2021-01-01 14:37:06', '2021-01-01 14:37:06');
INSERT INTO `acl_user_role` VALUES ('1344955154738200577', '1196300996034977794', '2', 0, '2021-01-01 18:34:32', '2021-01-01 18:34:32');
INSERT INTO `acl_user_role` VALUES ('1344955180059213825', '1344887044329037826', '1', 0, '2021-01-01 18:34:38', '2021-01-01 18:34:38');

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
INSERT INTO `goods` VALUES ('1344474651794980865', '三阶魔方', 19.90, 'https://five-team.oss-cn-guangzhou.aliyuncs.com/2020/12/31/0951857fb08d405eaaa7a04cbaa136aaSnipaste_2020-12-31_08-11-46.png', NULL, NULL, '好玩', '1344472195585392641', 0, 0, 0, '2020-12-31 10:45:11', '2020-12-31 10:45:11');
INSERT INTO `goods` VALUES ('1344476094819991554', '4阶魔方', 232.12, 'https://five-team.oss-cn-guangzhou.aliyuncs.com/2020/12/31/b50ba98f5c7e49c7bff4d54d21e3ad54Snipaste_2020-12-31_08-11-46.png', NULL, NULL, '好玩', '1344472195585392641', 0, 0, 0, '2020-12-31 10:50:55', '2020-12-31 10:51:04');
INSERT INTO `goods` VALUES ('1344865051089051650', 'Apple/苹果 iPhone X 苹果xr全新xs max手机iphone 8 plus苹果8p', 800.00, 'https://five-team.oss-cn-guangzhou.aliyuncs.com/2021/01/01/3afbf86f3323411cac3f7c85524b21c8Snipaste_2021-01-01_12-36-19.png', NULL, NULL, '机身颜色: iPhone8【黑色】4.7寸 iPhone8【银色】4.7寸 iPhone8【金色】4.7寸 iPhone8【红色】4.7寸 iPhone8Plus【黑', '1344472195585392641', 0, 0, 0, '2021-01-01 12:36:29', '2021-01-01 12:36:29');
INSERT INTO `goods` VALUES ('1344865229367943170', '【限时抢购】华为/HUAWEI P40 | 5GSoC芯片超感知徕卡三摄华为p40 5g手机华为官方旗舰店', 4488.00, 'https://five-team.oss-cn-guangzhou.aliyuncs.com/2021/01/01/2dcdc965f1294317ab508f49af7b648fSnipaste_2021-01-01_12-37-02.png', NULL, NULL, '购机尊享500元超值云服务礼包 ', '1344472195585392641', 0, 0, 0, '2021-01-01 12:37:12', '2021-01-01 12:37:12');
INSERT INTO `goods` VALUES ('1344865374675410945', '元中国时代 公元前2300-前1800年华夏大地场景 李琳之 商务印书馆 正版书籍 新华书店旗舰店文轩官网 ', 72.40, 'https://five-team.oss-cn-guangzhou.aliyuncs.com/2021/01/01/83e1b6f22bc64a2b84af55b91a11ec5eSnipaste_2021-01-01_12-37-38.png', NULL, NULL, '新华书店正版 中国历史 文轩网 ', '1344472195585392641', 0, 0, 0, '2021-01-01 12:37:46', '2021-01-01 12:37:46');
INSERT INTO `goods` VALUES ('1344865481479168002', '北平学人访问记（下）(碎金文丛5) ', 37.90, 'https://five-team.oss-cn-guangzhou.aliyuncs.com/2021/01/01/940bc62da43d4e68a089244887ab6da1Snipaste_2021-01-01_12-38-03.png', NULL, NULL, '新华书店正版 中国历史 文轩网 ', '1344472195585392641', 0, 0, 0, '2021-01-01 12:38:12', '2021-01-01 12:38:12');
INSERT INTO `goods` VALUES ('1344865767706861570', 'izzue男装时尚外套秋冬款字母图案休闲保暖工装服7121F8B ', 989.00, 'https://five-team.oss-cn-guangzhou.aliyuncs.com/2021/01/01/d6d10e7e3aa54970aa5c954e0e4e016bSnipaste_2021-01-01_12-39-13.png', NULL, NULL, '夹克版型 加厚休闲 时尚大方 ', '1344472195585392641', 0, 0, 0, '2021-01-01 12:39:20', '2021-01-01 12:39:20');
INSERT INTO `goods` VALUES ('1344866100764033025', '西服休闲套装男修身潮流商务正装男士新郎伴郎结婚礼服西装三件套 ', 768.00, 'https://five-team.oss-cn-guangzhou.aliyuncs.com/2021/01/01/8864207c64ab4a788a5321f46da6959fSnipaste_2021-01-01_12-40-30.png', NULL, NULL, '', '1344472195585392641', 0, 0, 0, '2021-01-01 12:40:39', '2021-01-01 12:40:39');
INSERT INTO `goods` VALUES ('1344873939867820034', '代码出售', 1.20, 'https://five-team.oss-cn-guangzhou.aliyuncs.com/2021/01/01/eefe9eb3bd6149399efd4e41f568825dSnipaste_2020-12-31_08-24-59.png', NULL, NULL, '33', '1344472195585392641', 0, 0, 0, '2021-01-01 13:11:48', '2021-01-01 18:03:42');
INSERT INTO `goods` VALUES ('1344874391388839937', '魔方出售', 12.20, 'https://five-team.oss-cn-guangzhou.aliyuncs.com/2021/01/01/2462ae09dcb34abe8cfef7b05e7fd261Snipaste_2020-12-31_08-11-46.png', NULL, NULL, '', '1344472195585392641', 0, 0, 0, '2021-01-01 13:13:36', '2021-01-01 18:03:52');

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
  `cover` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '商品封面',
  `buy_count` int(11) NULL DEFAULT NULL COMMENT '购买数量',
  `title` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '商品标题',
  `gmt_create` datetime(0) NOT NULL COMMENT '创建时间',
  `gmt_modified` datetime(0) NOT NULL COMMENT '修改时间',
  `belong_id` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '商家id',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '订单表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of t_order
-- ----------------------------
INSERT INTO `t_order` VALUES ('1344457548387926018', '1344441969442656257', '1344150972779212801', 23.00, NULL, 'https://five-team.oss-cn-guangzhou.aliyuncs.com/2020/12/31/38989ee345fa465485c3f1eed2d4071bSnipaste_2020-12-31_08-11-46.png', 1, '122', '2020-12-31 09:37:13', '2020-12-31 09:37:13', '1344150972779212801');
INSERT INTO `t_order` VALUES ('1344459234896519169', '1344441104413511682', '1344150972779212801', 65.00, NULL, 'https://five-team.oss-cn-guangzhou.aliyuncs.com/2020/12/31/e17f659ebb1040d1a44bdbe360c34595Snipaste_2020-12-31_08-11-46.png', 13, '5', '2020-12-31 09:43:55', '2020-12-31 09:43:55', '1344150972779212801');
INSERT INTO `t_order` VALUES ('1344459359530262529', '1344436102085234690', '1344150972779212801', 1918.80, NULL, NULL, 123, '魔方', '2020-12-31 09:44:25', '2020-12-31 09:44:25', '1344150972779212801');
INSERT INTO `t_order` VALUES ('1344467522635796481', '1344131898292588545', '1344150972779212801', 0.00, NULL, NULL, 1123, '21', '2020-12-31 10:16:51', '2020-12-31 10:16:51', '1');
INSERT INTO `t_order` VALUES ('1344474682853801986', '1344474651794980865', '1344472195585392641', 39.80, NULL, 'https://five-team.oss-cn-guangzhou.aliyuncs.com/2020/12/31/0951857fb08d405eaaa7a04cbaa136aaSnipaste_2020-12-31_08-11-46.png', 2, '三阶魔方', '2020-12-31 10:45:18', '2020-12-31 10:45:18', '1344472195585392641');
INSERT INTO `t_order` VALUES ('1344476485347442690', '1344476094819991554', '1344472195585392641', 928.48, NULL, 'https://five-team.oss-cn-guangzhou.aliyuncs.com/2020/12/31/b50ba98f5c7e49c7bff4d54d21e3ad54Snipaste_2020-12-31_08-11-46.png', 4, '4阶魔方', '2020-12-31 10:52:28', '2020-12-31 10:52:28', '1344472195585392641');
INSERT INTO `t_order` VALUES ('1344866446320156674', '1344866100764033025', '1344472195585392641', 3840.00, NULL, 'https://five-team.oss-cn-guangzhou.aliyuncs.com/2021/01/01/8864207c64ab4a788a5321f46da6959fSnipaste_2021-01-01_12-40-30.png', 5, '西服休闲套装男修身潮流商务正装男士新郎伴郎结婚礼服西装三件套 ', '2021-01-01 12:42:02', '2021-01-01 12:42:02', '1344472195585392641');
INSERT INTO `t_order` VALUES ('1344874437811396610', '1344874391388839937', '1344472195585392641', 170.80, NULL, 'https://five-team.oss-cn-guangzhou.aliyuncs.com/2021/01/01/2462ae09dcb34abe8cfef7b05e7fd261Snipaste_2020-12-31_08-11-46.png', 14, '564', '2021-01-01 13:13:47', '2021-01-01 13:13:47', '1344472195585392641');

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

-- ----------------------------
-- Table structure for user
-- ----------------------------
DROP TABLE IF EXISTS `user`;
CREATE TABLE `user`  (
  `id` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `first_name` varchar(225) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `last_name` varchar(225) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `id_card` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `information` varchar(225) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `create_time` datetime(0) NULL DEFAULT NULL,
  UNIQUE INDEX `id`(`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of user
-- ----------------------------

SET FOREIGN_KEY_CHECKS = 1;
