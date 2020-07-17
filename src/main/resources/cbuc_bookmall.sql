/*
Navicat MySQL Data Transfer

Source Server         : 本地数据库
Source Server Version : 80019
Source Host           : localhost:3306
Source Database       : cbuc_bookmall

Target Server Type    : MYSQL
Target Server Version : 80019
File Encoding         : 65001

Date: 2020-06-28 20:55:00
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for bm_category
-- ----------------------------
DROP TABLE IF EXISTS `bm_category`;
CREATE TABLE `bm_category` (
  `id` int NOT NULL AUTO_INCREMENT COMMENT '主键ID',
  `name` varchar(128) DEFAULT NULL COMMENT '分类名称',
  `status` varchar(10) NOT NULL COMMENT '状态：E-存在  D-删除',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- ----------------------------
-- Records of bm_category
-- ----------------------------
INSERT INTO `bm_category` VALUES ('1', '电子书 / 网络文学', 'E');
INSERT INTO `bm_category` VALUES ('2', '教育', 'E');
INSERT INTO `bm_category` VALUES ('3', '经典小说', 'E');
INSERT INTO `bm_category` VALUES ('4', '文艺', 'E');
INSERT INTO `bm_category` VALUES ('5', '青春文学 / 动漫', 'E');
INSERT INTO `bm_category` VALUES ('6', '童书', 'E');
INSERT INTO `bm_category` VALUES ('7', '经营', 'E');
INSERT INTO `bm_category` VALUES ('8', '成功 / 励志', 'E');
INSERT INTO `bm_category` VALUES ('9', '英文原版书', 'E');
INSERT INTO `bm_category` VALUES ('10', '小黄精品', 'E');

-- ----------------------------
-- Table structure for bm_comment
-- ----------------------------
DROP TABLE IF EXISTS `bm_comment`;
CREATE TABLE `bm_comment` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '主键ID',
  `product_id` bigint DEFAULT NULL COMMENT '被评商品',
  `commentator` bigint DEFAULT NULL COMMENT '评论人ID',
  `create_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '评论时间',
  `like_count` bigint DEFAULT NULL COMMENT '点赞数',
  `msg` varchar(255) DEFAULT NULL COMMENT '评论内容',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- ----------------------------
-- Records of bm_comment
-- ----------------------------
INSERT INTO `bm_comment` VALUES ('1', '1', '2', '2019-10-05 08:36:49', '3', '书的包装很不错，内容也很精彩');
INSERT INTO `bm_comment` VALUES ('2', '1', '1', '2019-10-05 10:05:51', '0', '人面桃花，山河入梦，春尽江南，好美，感觉很江南~（入了好几本都很喜欢');
INSERT INTO `bm_comment` VALUES ('3', '1', '3', '2019-10-05 10:05:53', '0', '“杏花春雨江南，灯灰冬雪夜长”。拿到书时刚好是一个夏雨的夜晚，新版的设计太有诗意了。');
INSERT INTO `bm_comment` VALUES ('4', '1', '2', '2019-10-05 08:37:51', '0', '这本书首先说纸质，很不错，不是那种盗版，其次就是字的大小，也比较好，里面的内容还没有看，不能评价，应该是不错的经典！');
INSERT INTO `bm_comment` VALUES ('5', '5', '2', '2019-10-05 08:38:38', '0', '赫尔岑说：“书——这是一代对另一代精神上的遗训，这是行将就木的老人对刚刚开始生活的青年人的中选，这是行将去休息的站岗人对走来接替他的岗位的站岗人的命令。”期待一本新书！期待一种精神！');
INSERT INTO `bm_comment` VALUES ('6', '5', '2', '2019-10-05 08:39:06', '0', '第一眼被这本书的封面给吸引住了，感觉很清纯、唯美，打开书感觉一种很真挚、很热烈的感情，渐渐的被麦家的文字给打动了。');
INSERT INTO `bm_comment` VALUES ('7', '5', '2', '2019-10-05 08:39:12', '2', '非常让人心疼的一本书，上一次有这种感觉还是《活着》，再早是《你在天国遇到的五个人》，还有《追风筝的人》，还有我最最习惯的《挪威的森林》，值得一读的好书，四个小时读完！！！');
INSERT INTO `bm_comment` VALUES ('8', '1', '2', '2019-10-16 10:02:08', '0', '巨好看！！！');
INSERT INTO `bm_comment` VALUES ('9', '1', '2', '2019-10-16 10:03:56', '0', '测试评论！！！');
INSERT INTO `bm_comment` VALUES ('10', '3', '2', '2019-10-16 10:07:25', '0', '测试评论2');
INSERT INTO `bm_comment` VALUES ('11', '1', '2', '2019-10-16 10:14:37', '0', '测试测试！！！');
INSERT INTO `bm_comment` VALUES ('12', '3', '2', '2019-10-16 10:20:55', '0', '测试显示');
INSERT INTO `bm_comment` VALUES ('13', '1', '2', '2019-10-16 22:19:00', '0', '测试评价');
INSERT INTO `bm_comment` VALUES ('14', '4', '2', '2019-10-20 21:06:30', '0', '书很好看');
INSERT INTO `bm_comment` VALUES ('15', '4', '2', '2019-10-20 21:06:59', '0', '书很好看');

-- ----------------------------
-- Table structure for bm_contact
-- ----------------------------
DROP TABLE IF EXISTS `bm_contact`;
CREATE TABLE `bm_contact` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '主键ID',
  `contactor` bigint DEFAULT NULL COMMENT '留言者ID',
  `receiveror` bigint DEFAULT NULL COMMENT '接收消息者',
  `content` varchar(128) DEFAULT NULL COMMENT '留言内容',
  `create_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `status` varchar(2) DEFAULT 'E' COMMENT '状态  E :  启用  D ： 失效',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=25 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- ----------------------------
-- Records of bm_contact
-- ----------------------------
INSERT INTO `bm_contact` VALUES ('1', '2', '1', 'nihao', '2019-11-11 21:10:10', '2019-11-11 21:10:10', 'E');
INSERT INTO `bm_contact` VALUES ('2', '2', '1', 'nihao', '2019-11-11 21:10:10', '2019-11-11 21:10:10', 'E');
INSERT INTO `bm_contact` VALUES ('3', '2', '1', 'nihao', '2019-11-11 21:15:29', '2019-11-11 21:15:29', 'E');
INSERT INTO `bm_contact` VALUES ('4', '2', '1', '测试留言', '2019-11-11 21:15:41', '2019-11-11 21:15:41', 'E');
INSERT INTO `bm_contact` VALUES ('5', '3', '1', '测试留言+1', '2019-11-11 21:55:16', '2019-11-11 21:55:16', 'E');
INSERT INTO `bm_contact` VALUES ('6', '1', '3', '收到留言', '2019-11-11 22:16:51', '2019-11-11 22:16:51', 'E');
INSERT INTO `bm_contact` VALUES ('7', '1', '2', '测试回复!!!!!测试回复!!!!!测试回复!!!!!测试回复!!!!!测试回复!!!!!测试回复!!!!!测试回复!!!!!测试回复!!!!!测试回复!!!!!测试回复!!!!!测试回复!!!!!', '2019-11-11 22:17:27', '2019-11-12 09:06:49', 'E');
INSERT INTO `bm_contact` VALUES ('8', '1', '2', '测试回复', '2019-11-11 22:17:42', '2019-11-12 09:06:49', 'E');
INSERT INTO `bm_contact` VALUES ('9', '1', '2', '测试', '2019-11-11 22:18:54', '2019-11-12 09:06:49', 'E');
INSERT INTO `bm_contact` VALUES ('10', '1', '2', '1111111', '2019-11-11 22:19:02', '2019-11-12 09:08:38', 'D');
INSERT INTO `bm_contact` VALUES ('11', '1', '2', '123123123', '2019-11-11 22:19:18', '2019-11-11 23:28:56', 'D');
INSERT INTO `bm_contact` VALUES ('12', '1', '3', '123123', '2019-11-11 22:19:42', '2019-11-11 22:19:42', 'E');
INSERT INTO `bm_contact` VALUES ('13', '2', '1', '测试回复功能!!!', '2019-11-11 23:33:44', '2019-11-11 23:33:44', 'E');
INSERT INTO `bm_contact` VALUES ('14', '2', '1', '11111', '2019-11-11 23:34:30', '2020-03-01 15:55:40', 'D');
INSERT INTO `bm_contact` VALUES ('15', '1', '2', 'HUIFU', '2019-11-11 23:34:39', '2019-11-11 23:34:47', 'D');
INSERT INTO `bm_contact` VALUES ('16', '1', '2', '测试导航条', '2019-11-11 23:34:39', '2019-11-11 23:34:39', 'E');
INSERT INTO `bm_contact` VALUES ('17', '1', '2', '测试导航条', '2019-11-11 23:34:39', '2019-11-11 23:34:39', 'E');
INSERT INTO `bm_contact` VALUES ('18', '1', '2', '测试导航条', '2019-11-11 23:34:39', '2019-11-11 23:34:39', 'E');
INSERT INTO `bm_contact` VALUES ('19', '1', '2', '测试导航条', '2019-11-11 23:34:39', '2019-11-11 23:34:39', 'E');
INSERT INTO `bm_contact` VALUES ('20', '1', '2', '测试导航条测试导航条数量展示', '2019-11-11 23:34:39', '2019-11-11 23:34:39', 'E');
INSERT INTO `bm_contact` VALUES ('21', '1', '2', '测试导航条数量', '2019-11-11 23:34:39', '2019-11-11 23:34:39', 'D');
INSERT INTO `bm_contact` VALUES ('22', '1', '2', '测试导航条测试导航条测试导航条测试导航条测试导航条测试导航条测试导航条测试导航条测试导航条测试导航条', '2019-11-11 23:34:39', '2019-11-11 23:34:39', 'D');
INSERT INTO `bm_contact` VALUES ('23', '2', '1', '123', '2019-11-11 23:34:39', '2020-03-01 15:55:36', 'D');
INSERT INTO `bm_contact` VALUES ('24', '1', '2', '收到留言', '2019-11-12 10:14:10', '2019-11-12 10:14:18', 'D');

-- ----------------------------
-- Table structure for bm_order
-- ----------------------------
DROP TABLE IF EXISTS `bm_order`;
CREATE TABLE `bm_order` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '主键ID',
  `product_id` bigint DEFAULT NULL COMMENT '商品ID',
  `user_id` bigint DEFAULT NULL COMMENT '卖家ID',
  `order_code` varchar(128) DEFAULT NULL COMMENT '订单号',
  `num` int DEFAULT NULL COMMENT '购买数量',
  `price` float DEFAULT NULL COMMENT '购买总价',
  `postage` float DEFAULT NULL COMMENT '邮费 （0：普通快递 1：小黄速运）',
  `addr` varchar(255) DEFAULT NULL COMMENT '发货地址',
  `post` varchar(10) DEFAULT NULL COMMENT '邮政邮编',
  `receiver` varchar(32) DEFAULT NULL COMMENT '收货人姓名',
  `phone` varchar(16) DEFAULT NULL COMMENT '收货人号码',
  `comment` varchar(255) DEFAULT NULL COMMENT '买家留言',
  `create_date` datetime DEFAULT NULL COMMENT '订单创建时间',
  `update_date` datetime DEFAULT NULL COMMENT '订单修改时间',
  `pay_date` datetime DEFAULT NULL COMMENT '付款时间',
  `delivery_date` datetime DEFAULT NULL COMMENT '发货时间',
  `confirm_date` datetime DEFAULT NULL COMMENT '确认收货时间',
  `status` varchar(32) DEFAULT NULL COMMENT '订单状态: WP:待付款 WD:待发货 WC:待收货 DD:取消订单  WR:待评价',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=39 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- ----------------------------
-- Records of bm_order
-- ----------------------------
INSERT INTO `bm_order` VALUES ('1', '1', '2', 'c5cce', '1', '118.5', '0', '福建省莆田市仙游县', '351264', 'cbuc', '13588886666', '', '2019-10-16 22:19:35', '2019-10-16 22:19:35', '2019-10-16 22:19:35', '2019-10-16 22:19:35', '2019-10-16 22:19:35', 'DD');
INSERT INTO `bm_order` VALUES ('2', '3', '2', 'c8302', '1', '59.5', '0', '福建省福州市软件园', '350000', '菜菜菜', '15011112222', '尽快发货！！！', '2019-10-12 16:54:00', '2019-10-12 16:54:00', '2019-10-12 16:54:00', '2019-10-12 16:54:00', '2019-10-12 16:54:00', 'SS');
INSERT INTO `bm_order` VALUES ('5', '5', '2', '7726b', '1', '41.2', '0', '福建莆田', '351264', 'cbuc', '1358889999', '尽快发货！！！', '2019-10-13 20:58:12', '2019-10-13 20:58:12', '2019-10-13 20:58:12', '2019-10-13 20:58:12', '2019-10-13 20:58:12', 'DD');
INSERT INTO `bm_order` VALUES ('8', '1', '2', '1ab4e', '3', '355.5', '0', '福建省-莆田-仙游县', '00000', 'Cbuc', '15857565554', '', '2019-10-20 21:02:28', '2019-10-20 21:02:29', '2019-10-20 21:02:28', '2019-10-20 21:02:28', '2019-10-20 21:02:28', 'DD');
INSERT INTO `bm_order` VALUES ('9', '4', '2', 'a56d4', '1', '28', '0', '福建省-莆田-仙游县', '00000', 'Cbuc', '15857565554', '', '2019-10-20 21:06:52', '2019-10-20 21:06:52', '2019-10-20 21:06:52', '2019-10-20 21:06:52', '2019-10-20 21:06:53', 'SS');
INSERT INTO `bm_order` VALUES ('10', '2', '2', 'bde15', '1', '46.5', '0', '福建省-莆田-仙游县', '00000', 'Cbuc', '15857565554', '好书', '2019-10-14 11:20:29', '2019-10-14 11:20:30', '2019-10-14 11:20:29', '2019-10-14 11:20:29', '2019-10-14 11:20:29', 'DD');
INSERT INTO `bm_order` VALUES ('11', '8', '2', '4fa5a', '1', '50.6', '0', '福建省-莆田-仙游县', '00000', 'Cbuc', '15857565554', '好书', '2019-10-14 11:18:56', '2019-10-14 11:18:56', '2019-10-14 11:18:56', '2019-10-14 11:18:56', '2019-10-14 11:18:56', 'DD');
INSERT INTO `bm_order` VALUES ('12', '7', '2', '6d31d', '1', '31.5', '0', '福建省-莆田-仙游县', '00000', 'Cbuc', '15857565554', '', '2019-10-13 20:32:53', '2019-10-13 20:32:54', '2019-10-13 20:32:53', '2019-10-13 20:32:53', '2019-10-13 20:32:53', 'DD');
INSERT INTO `bm_order` VALUES ('13', '1', '2', '21b9a', '1', '118.5', '0', '福建省-莆田-仙游县', '00000', 'Cbuc', '15857565554', '', '2019-10-13 20:43:40', '2019-10-13 20:43:40', '2019-10-13 20:43:40', '2019-10-13 20:43:40', '2019-10-13 20:43:40', 'DD');
INSERT INTO `bm_order` VALUES ('14', '9', '2', '341f4', '1', '18.3', '0', '福建省-莆田-仙游县', '00000', 'Cbuc', '15857565554', '', '2019-10-13 20:32:45', '2019-10-13 20:32:37', '2019-10-13 20:32:45', '2019-10-13 20:32:45', '2019-10-13 20:32:45', 'DD');
INSERT INTO `bm_order` VALUES ('15', '2', '2', '1c985', '1', '46.5', '0', '福建省-莆田-仙游县', '00000', 'Cbuc', '15857565554', '', '2019-10-13 20:43:36', '2019-10-13 20:43:37', '2019-10-13 20:43:36', '2019-10-13 20:43:36', '2019-10-13 20:43:36', 'DD');
INSERT INTO `bm_order` VALUES ('16', '4', '2', '0dc55142-13', '1', '28', '0', '福建省-莆田-仙游县', '00000', 'Cbuc', '15857565554', '', '2019-10-13 19:34:32', '2019-10-13 19:34:00', '2019-10-13 19:34:32', '2019-10-13 19:34:32', '2019-10-13 19:34:32', 'DD');
INSERT INTO `bm_order` VALUES ('17', '5', '2', '3d8eef5e-f2', '1', '41.2', '0', '福建省-莆田-仙游县', '00000', 'Cbuc', '15857565554', '', '2019-10-20 21:02:42', '2019-10-20 21:02:42', '2019-10-20 21:06:49', '2019-10-20 21:02:42', '2019-10-20 21:02:42', 'WD');
INSERT INTO `bm_order` VALUES ('18', '2', '2', '3bb23d86-9a', '1', '46.5', '0', '福建省-莆田-仙游县', '00000', 'Cbuc', '15857565554', '', '2019-10-13 20:44:12', '2019-10-13 20:44:12', '2019-10-13 20:58:02', '2019-10-13 20:44:12', '2019-10-13 20:44:12', 'WD');
INSERT INTO `bm_order` VALUES ('19', '1', '2', '704c6120-57', '1', '118.5', '0', '福建省-莆田-仙游县', '00000', 'Cbuc', '15857565554', '', '2019-10-16 22:18:18', '2019-10-16 22:18:18', '2019-10-16 22:18:23', '2019-10-16 22:18:23', '2019-10-16 22:18:23', 'WD');
INSERT INTO `bm_order` VALUES ('20', '1', '18', '23a246df-8f', '1', '118.5', '0', '福建省-莆田-仙游县', '00000', 'Cbuc', '15857565554', '', '2019-10-20 20:47:47', '2019-10-20 20:47:47', '2019-10-20 20:47:47', '2019-10-20 20:47:47', '2019-10-20 20:47:47', 'WC');
INSERT INTO `bm_order` VALUES ('21', '6', '18', '107045ca-f0', '1', '21.2', '0', '福建省-莆田-仙游县', '00000', 'Cbuc', '15857565554', '', '2019-10-20 20:01:10', '2019-10-20 20:01:10', '2019-10-20 20:01:10', '2019-10-20 20:01:10', '2019-10-20 20:01:10', 'WR');
INSERT INTO `bm_order` VALUES ('22', '6', '18', '8af5fa2d-e0', '1', '21.2', '0', '福建省-莆田-仙游县', '00000', 'Cbuc', '15857565554', '', '2019-10-19 12:55:24', '2019-10-19 12:55:24', '2019-10-19 12:55:24', '2019-11-05 09:30:36', '2019-10-19 12:55:24', 'WC');
INSERT INTO `bm_order` VALUES ('23', '7', '18', 'de97e6d7-2d', '1', '31.5', '0', '福建省-莆田-仙游县', '00000', 'Cbuc', '15857565554', '', '2019-10-20 20:03:24', '2019-10-20 20:03:24', '2019-10-20 20:03:24', '2019-10-20 20:03:24', '2019-10-20 20:03:24', 'WP');
INSERT INTO `bm_order` VALUES ('24', '6', '18', '3767383d-ef', '1', '21.2', '0', '福建省-莆田-仙游县', '00000', 'Cbuc', '15857565554', '', '2019-10-20 20:26:08', '2019-10-20 20:26:08', '2019-10-20 20:26:08', '2019-10-20 20:26:08', '2019-10-20 20:26:08', 'WD');
INSERT INTO `bm_order` VALUES ('25', '7', '18', '58c814cd-ff', '1', '31.5', '0', '福建省-莆田-仙游县', '00000', 'Cbuc', '15857565554', '', '2019-10-20 20:03:33', '2019-10-20 20:03:33', '2019-10-20 20:03:33', '2019-10-20 20:03:33', '2019-10-20 20:03:33', 'WP');
INSERT INTO `bm_order` VALUES ('26', '1', '2', 'a9cb4d56-c0', '1', '118.5', '0', '福建省-莆田-仙游县', '00000', 'Cbuc', '15857565554', '', '2019-10-20 21:02:25', '2019-10-20 21:02:25', '2019-10-20 21:02:25', '2019-10-20 21:02:25', '2019-10-20 21:02:25', 'DD');
INSERT INTO `bm_order` VALUES ('27', '1', '2', '108bf431-bf', '3', '355.5', '0', '福建省-莆田-仙游县', '00000', 'Cbuc', '15857565554', '', '2019-10-20 20:43:17', '2019-10-20 20:43:18', '2019-10-20 20:43:17', '2019-10-20 20:43:17', '2019-10-20 20:43:17', 'DD');
INSERT INTO `bm_order` VALUES ('28', '4', '2', '65dabe39-47', '1', '28', '0', '福建省-莆田-仙游县', '00000', 'Cbuc', '15857565554', '', '2019-10-20 21:01:55', '2019-10-20 21:01:55', '2019-10-20 21:01:55', '2019-10-20 21:01:55', '2019-10-20 21:01:55', 'SS');
INSERT INTO `bm_order` VALUES ('29', '5', '2', 'de057025-22', '1', '41.2', '0', '福建省-莆田-仙游县', '00000', 'Cbuc', '15857565554', '', '2019-10-20 21:05:46', '2019-10-20 21:05:46', '2019-10-20 21:05:51', '2019-10-20 21:05:50', '2019-10-20 21:05:50', 'WD');
INSERT INTO `bm_order` VALUES ('30', '5', '2', '5d3b8e8a-f2', '3', '123.6', '0', '福建省-莆田-仙游县', '00000', 'Cbuc', '15857565554', '', '2019-10-20 21:06:07', '2019-10-20 21:06:07', '2019-10-20 21:06:09', '2019-10-20 21:06:09', '2019-10-20 21:06:09', 'WD');
INSERT INTO `bm_order` VALUES ('31', '2', '2', 'b40d1293-6e', '1', '46.5', '0', '福建省-莆田', '00000', 'Cbuc', '15866885488', '', '2019-10-24 13:53:59', '2019-10-24 13:53:59', '2019-10-24 13:53:59', '2019-10-24 13:53:59', '2019-10-24 13:53:59', 'DD');
INSERT INTO `bm_order` VALUES ('32', '3', '2', 'c29d5e7f-f9', '1', '59.5', '0', '福建省-莆田', '00000', 'Cbuc', '15866885488', '', '2019-10-30 10:40:58', '2019-10-30 10:40:58', null, null, null, 'WP');
INSERT INTO `bm_order` VALUES ('33', '4', '2', 'dc76d63a-31', '2', '56', '0', '福建省-莆田', '00000', 'Cbuc', '15866885488', '', '2019-10-30 10:40:58', '2019-10-30 10:40:58', null, null, null, 'WP');
INSERT INTO `bm_order` VALUES ('34', '3', '2', '9433732a-75', '1', '59.5', '0', '福建省-莆田', '00000', 'Cbuc', '15866885488', '', '2019-10-30 10:46:03', '2019-10-30 10:46:03', null, null, null, 'WP');
INSERT INTO `bm_order` VALUES ('35', '4', '2', 'b88d65e4-31', '2', '56', '0', '福建省-莆田', '00000', 'Cbuc', '15866885488', '', '2019-10-30 10:46:03', '2019-10-30 10:46:03', null, null, null, 'WP');
INSERT INTO `bm_order` VALUES ('36', '3', '2', 'dacc9181-3d', '1', '59.5', '0', '福建省-莆田', '00000', 'Cbuc', '15866885488', '', '2019-10-30 10:55:22', '2019-10-30 10:55:22', '2019-10-30 10:55:25', null, null, 'WD');
INSERT INTO `bm_order` VALUES ('37', '4', '2', 'd57d521c-b2', '2', '56', '0', '福建省-莆田', '00000', 'Cbuc', '15866885488', '', '2019-10-30 10:55:22', '2019-10-30 10:55:22', '2019-10-30 10:55:26', null, null, 'WD');
INSERT INTO `bm_order` VALUES ('38', '4', '1', '5553d9a9-05', '1', '28', '0', '全国', '00000', 'admin', '13566668888', '', '2020-03-01 15:56:05', '2020-03-01 15:56:05', '2020-03-01 15:56:10', null, null, 'WD');

-- ----------------------------
-- Table structure for bm_order_log
-- ----------------------------
DROP TABLE IF EXISTS `bm_order_log`;
CREATE TABLE `bm_order_log` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '主键ID',
  `product_id` bigint DEFAULT NULL COMMENT '商品ID',
  `order_id` bigint DEFAULT NULL COMMENT '订单ID',
  `user_id` bigint DEFAULT NULL COMMENT '买家ID',
  `num` int DEFAULT NULL COMMENT '购买数量',
  `status` varchar(20) DEFAULT NULL COMMENT '状态：E-存在  D-删除  Y-已下单',
  `type` varchar(20) DEFAULT NULL COMMENT '操作类型：BC:加购  BN:立即购买',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=36 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- ----------------------------
-- Records of bm_order_log
-- ----------------------------
INSERT INTO `bm_order_log` VALUES ('1', '1', '8', '2', '6', 'Y', 'BC');
INSERT INTO `bm_order_log` VALUES ('2', '4', '9', '2', '1', 'Y', 'BC');
INSERT INTO `bm_order_log` VALUES ('5', '3', '1', '2', '1', 'E', 'BN');
INSERT INTO `bm_order_log` VALUES ('7', '3', '2', '2', '1', 'E', 'BN');
INSERT INTO `bm_order_log` VALUES ('9', '5', '5', '2', '1', 'E', 'BN');
INSERT INTO `bm_order_log` VALUES ('10', '2', '10', '2', '1', 'Y', 'BC');
INSERT INTO `bm_order_log` VALUES ('11', '8', '11', '2', '1', 'Y', 'BC');
INSERT INTO `bm_order_log` VALUES ('12', '7', '12', '2', '1', 'Y', 'BN');
INSERT INTO `bm_order_log` VALUES ('13', '1', '13', '2', '1', 'Y', 'BC');
INSERT INTO `bm_order_log` VALUES ('14', '9', '14', '2', '1', 'Y', 'BC');
INSERT INTO `bm_order_log` VALUES ('15', '2', '15', '2', '1', 'Y', 'BN');
INSERT INTO `bm_order_log` VALUES ('16', '4', '16', '2', '1', 'Y', 'BC');
INSERT INTO `bm_order_log` VALUES ('17', '5', '17', '2', '1', 'Y', 'BC');
INSERT INTO `bm_order_log` VALUES ('18', '2', '18', '2', '1', 'Y', 'BC');
INSERT INTO `bm_order_log` VALUES ('19', '1', '19', '2', '1', 'Y', 'BC');
INSERT INTO `bm_order_log` VALUES ('20', '1', '20', '2', '1', 'Y', 'BN');
INSERT INTO `bm_order_log` VALUES ('21', '6', '21', '2', '1', 'Y', 'BN');
INSERT INTO `bm_order_log` VALUES ('22', '6', '22', '2', '1', 'Y', 'BC');
INSERT INTO `bm_order_log` VALUES ('23', '7', '23', '2', '1', 'Y', 'BC');
INSERT INTO `bm_order_log` VALUES ('24', '6', '24', '2', '1', 'Y', 'BC');
INSERT INTO `bm_order_log` VALUES ('25', '7', '25', '2', '1', 'Y', 'BC');
INSERT INTO `bm_order_log` VALUES ('26', '1', '27', '2', '3', 'Y', 'BC');
INSERT INTO `bm_order_log` VALUES ('27', '1', '26', '2', '1', 'Y', 'BN');
INSERT INTO `bm_order_log` VALUES ('28', '4', '28', '2', '1', 'Y', 'BN');
INSERT INTO `bm_order_log` VALUES ('29', '5', '30', '2', '3', 'Y', 'BC');
INSERT INTO `bm_order_log` VALUES ('30', '5', '29', '2', '1', 'Y', 'BN');
INSERT INTO `bm_order_log` VALUES ('31', '3', '36', '2', '1', 'Y', 'BC');
INSERT INTO `bm_order_log` VALUES ('32', '2', '31', '2', '1', 'Y', 'BN');
INSERT INTO `bm_order_log` VALUES ('33', '4', '37', '2', '2', 'Y', 'BC');
INSERT INTO `bm_order_log` VALUES ('34', '2', null, '2', '3', 'E', 'BC');
INSERT INTO `bm_order_log` VALUES ('35', '4', '38', '1', '1', 'Y', 'BC');

-- ----------------------------
-- Table structure for bm_product
-- ----------------------------
DROP TABLE IF EXISTS `bm_product`;
CREATE TABLE `bm_product` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '主键ID',
  `category_id` int DEFAULT NULL COMMENT '分类ID',
  `user_id` bigint DEFAULT NULL COMMENT '卖家ID',
  `name` varchar(128) DEFAULT NULL COMMENT '产品名称',
  `title` varchar(128) DEFAULT NULL COMMENT '标题',
  `price` float DEFAULT NULL COMMENT '价格',
  `saled` int DEFAULT NULL COMMENT '销售量',
  `stock` int DEFAULT NULL COMMENT '库存量',
  `img` varchar(255) DEFAULT NULL COMMENT '商品图片',
  `active` varchar(8) DEFAULT NULL COMMENT '是否参加活动 （1：是；0：否）',
  `status` varchar(10) NOT NULL COMMENT '状态：E-存在  D-删除',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- ----------------------------
-- Records of bm_product
-- ----------------------------
INSERT INTO `bm_product` VALUES ('1', '3', '2', '江南三部曲（共3册）', '格非：江南三部曲（共3册）（茅盾文学奖超高票获奖 当当专享签名本）', '118.5', '2', '89', '/27913883-1_l_3.png', '1', 'E');
INSERT INTO `bm_product` VALUES ('2', '3', '2', '三体：全三册', '刘慈欣代表作，亚洲首部“雨果奖”获奖作品！', '46.5', '256', '97', '/23579654-1_b_2.jpg', '0', 'E');
INSERT INTO `bm_product` VALUES ('3', '3', '2', '长安十二时辰（上下册）', '作家马伯庸长篇代表作，突破真实与虚构界限，打造令人窒息的历史悬疑巨制，揭秘不为人知的十二时辰', '59.5', '125', '99', '/24156030-1_b_12.jpg', '1', 'E');
INSERT INTO `bm_product` VALUES ('4', '3', '2', '活着（2017年新版）', '余华是我国当代著名作家，也是享誉世界的小说家，曾荣获众多国内外奖项。《活着》是其代表作，在全球广泛传播，销量逾千万册，获得了普遍好评，已成为中国乃至世界当代文学的经典', '28', '495', '96', '/25137790-1_b_4.jpg', '0', 'E');
INSERT INTO `bm_product` VALUES ('5', '3', '2', '人生海海', '（麦家重磅新作！莫言、董卿、王家卫、高晓松、杨洋倾力推荐）', '41.2', '162', '96', '/26921715-1_b_2.jpg', '1', 'E');
INSERT INTO `bm_product` VALUES ('6', '1', '18', '死亡作业', '科幻灵异', '21.5', '168', '98', '/1960404810_ii_cover.jpg', '0', 'E');
INSERT INTO `bm_product` VALUES ('7', '1', '17', '噬帝重生', '男频道', '31.5', '122', '98', '/1960419013_ii_cover.jpg', '1', 'E');
INSERT INTO `bm_product` VALUES ('8', '1', '18', '南宋游记', '历史军事', '50.6', '198', '99', '/1960440975_ii_cover.jpg', '1', 'E');
INSERT INTO `bm_product` VALUES ('9', '1', '18', '刺情', '现代言情', '18.3', '16', '99', '/1960414988_ii_cover.jpg', '0', 'E');
INSERT INTO `bm_product` VALUES ('10', '1', '18', '\r\n乡村妙手小仙医', '现代都市', '16.6', '100', '100', '/1960181021_ii_cover.jpg', '0', 'E');
INSERT INTO `bm_product` VALUES ('14', '6', '18', '漫画中国史（半小时）', '漫画', '23', '0', '111', '/27931943-1_l_3.jpg', '0', 'E');

-- ----------------------------
-- Table structure for bm_property
-- ----------------------------
DROP TABLE IF EXISTS `bm_property`;
CREATE TABLE `bm_property` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '主键ID',
  `product_id` bigint DEFAULT NULL,
  `category_id` int DEFAULT NULL COMMENT '分类ID',
  `name` varchar(32) DEFAULT NULL COMMENT '属性名称',
  `value` varchar(255) DEFAULT NULL,
  `status` varchar(20) DEFAULT NULL COMMENT '状态：E-存在  D-删除',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=41 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- ----------------------------
-- Records of bm_property
-- ----------------------------
INSERT INTO `bm_property` VALUES ('1', '1', '3', '开本', '32开', 'E');
INSERT INTO `bm_property` VALUES ('2', '1', '3', '纸张', '胶版纸', 'E');
INSERT INTO `bm_property` VALUES ('3', '1', '3', '包装', '平装-胶钉', 'E');
INSERT INTO `bm_property` VALUES ('4', '1', '3', '是否套装', '是', 'E');
INSERT INTO `bm_property` VALUES ('5', '2', '3', '开本', '32开', 'E');
INSERT INTO `bm_property` VALUES ('6', '2', '3', '纸张', '胶版纸', 'E');
INSERT INTO `bm_property` VALUES ('7', '2', '3', '包装', '平装-胶钉', 'E');
INSERT INTO `bm_property` VALUES ('8', '2', '3', '是否套装', '是', 'E');
INSERT INTO `bm_property` VALUES ('9', '3', '3', '开本', '32开', 'E');
INSERT INTO `bm_property` VALUES ('10', '3', '3', '纸张', '胶版纸', 'E');
INSERT INTO `bm_property` VALUES ('11', '3', '3', '包装', '平装-胶钉', 'E');
INSERT INTO `bm_property` VALUES ('12', '3', '3', '是否套装', '是', 'E');
INSERT INTO `bm_property` VALUES ('13', '4', '3', '开本', '32开', 'E');
INSERT INTO `bm_property` VALUES ('14', '4', '3', '纸张', '胶版纸', 'E');
INSERT INTO `bm_property` VALUES ('15', '4', '3', '包装', '平装-胶钉', 'E');
INSERT INTO `bm_property` VALUES ('16', '4', '3', '是否套装', '是', 'E');
INSERT INTO `bm_property` VALUES ('17', '5', '3', '开本', '32开', 'E');
INSERT INTO `bm_property` VALUES ('18', '5', '3', '纸张', '胶版纸', 'E');
INSERT INTO `bm_property` VALUES ('19', '5', '3', '包装', '平装-胶钉', 'E');
INSERT INTO `bm_property` VALUES ('20', '5', '3', '是否套装', '是', 'E');
INSERT INTO `bm_property` VALUES ('21', '6', '1', '开本', '32开', 'E');
INSERT INTO `bm_property` VALUES ('22', '6', '1', '纸张', '胶版纸', 'E');
INSERT INTO `bm_property` VALUES ('23', '6', '1', '包装', '平装-胶钉', 'E');
INSERT INTO `bm_property` VALUES ('24', '6', '1', '是否套装', '是', 'E');
INSERT INTO `bm_property` VALUES ('25', '7', '1', '开本', '32开', 'E');
INSERT INTO `bm_property` VALUES ('26', '7', '1', '纸张', '胶版纸', 'E');
INSERT INTO `bm_property` VALUES ('27', '7', '1', '包装', '平装-胶钉', 'E');
INSERT INTO `bm_property` VALUES ('28', '7', '1', '是否套装', '是', 'E');
INSERT INTO `bm_property` VALUES ('29', '8', '1', '开本', '32开', 'E');
INSERT INTO `bm_property` VALUES ('30', '8', '1', '纸张', '胶版纸', 'E');
INSERT INTO `bm_property` VALUES ('31', '8', '1', '包装', '平装-胶钉', 'E');
INSERT INTO `bm_property` VALUES ('32', '8', '1', '是否套装', '是', 'E');
INSERT INTO `bm_property` VALUES ('33', '9', '1', '开本', '32开', 'E');
INSERT INTO `bm_property` VALUES ('34', '9', '1', '纸张', '胶版纸', 'E');
INSERT INTO `bm_property` VALUES ('35', '9', '1', '包装', '平装-胶钉', 'E');
INSERT INTO `bm_property` VALUES ('36', '9', '1', '是否套装', '是', 'E');
INSERT INTO `bm_property` VALUES ('37', '10', '1', '开本', '32开', 'E');
INSERT INTO `bm_property` VALUES ('38', '10', '1', '纸张', '胶版纸', 'E');
INSERT INTO `bm_property` VALUES ('39', '10', '1', '包装', '平装-胶钉', 'E');
INSERT INTO `bm_property` VALUES ('40', '10', '1', '是否套装', '是', 'E');

-- ----------------------------
-- Table structure for bm_user
-- ----------------------------
DROP TABLE IF EXISTS `bm_user`;
CREATE TABLE `bm_user` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '主键ID',
  `user_name` varchar(64) DEFAULT NULL COMMENT '用户名',
  `pwd` varchar(64) DEFAULT NULL COMMENT '用户密码',
  `phone` varchar(16) DEFAULT NULL COMMENT '联系电话',
  `sex` varchar(2) DEFAULT NULL COMMENT '性别',
  `img` varchar(255) DEFAULT NULL COMMENT '用户头像',
  `addr` varchar(512) DEFAULT NULL COMMENT '地址',
  `balance` float DEFAULT NULL COMMENT '余额',
  `create_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '更新时间',
  `status` varchar(10) NOT NULL COMMENT '状态：E-存在  D-删除',
  `type` varchar(10) NOT NULL COMMENT '用户类型：B：买家  S：卖家',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=24 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- ----------------------------
-- Records of bm_user
-- ----------------------------
INSERT INTO `bm_user` VALUES ('1', 'admin', 'admin', '13566668888', '1', '/abc.jpg', '全国', '0', '2019-10-19 10:40:23', '2019-10-19 10:40:23', 'E', '超级管理员');
INSERT INTO `bm_user` VALUES ('2', 'Cbuc', '123456', '15866885488', '1', '/109.jpg', '福建省-莆田', '898', '2019-10-24 13:53:51', '2019-10-24 13:53:51', 'E', 'B');
INSERT INTO `bm_user` VALUES ('3', 'cscscs', '123456', '15688884444', '1', '/abc.jpg', '福建省-莆田-仙游县', '0', '2019-10-20 21:09:38', '2019-10-20 21:09:38', 'E', 'B');
INSERT INTO `bm_user` VALUES ('4', 'sh', '123123', '15688886666', '1', '/123.jpg', '福建省-莆田-仙游县', '0', '2019-10-19 10:40:23', '2019-10-19 10:40:23', 'E', 'S');
INSERT INTO `bm_user` VALUES ('9', 'cs1', '123456', '12345678911', '1', '/github.jpg', '福建省-莆田-仙游县', '0', '2019-10-19 10:40:23', '2019-10-19 10:40:23', 'E', 'B');
INSERT INTO `bm_user` VALUES ('10', 'cs2', '123123', '13566668888', '1', '/default-avatar.png', '福建省-莆田-仙游县', '0', '2019-10-19 10:40:23', '2019-10-19 10:40:23', 'E', 'B');
INSERT INTO `bm_user` VALUES ('11', 'cs3', '123456', '13566668888', '0', '/123.jpg', '福建省-莆田-仙游县', '0', '2019-10-19 10:40:23', '2019-10-19 10:40:23', 'E', 'B');
INSERT INTO `bm_user` VALUES ('13', 'cs4', '123123', '13588886666', '1', '/github.jpg', '福建省-莆田-仙游县', '0', '2019-10-19 10:40:23', '2019-10-19 10:40:23', 'E', 'S');
INSERT INTO `bm_user` VALUES ('17', '测测测', '123456', '15688889999', '0', '/default-avatar.png', '福建省-莆田', '31.5', '2019-10-19 10:55:02', '2019-10-19 10:55:02', 'E', 'S');
INSERT INTO `bm_user` VALUES ('18', 'cssh', '123456', '13566668888', '1', '/default-avatar.png', '福建省-莆田-仙游县', '95.1', '2019-10-19 10:55:02', '2019-10-19 10:55:02', 'E', 'S');
INSERT INTO `bm_user` VALUES ('19', '1号', '123456', '13599998888', '1', '/default-avatar.png', '福建省-仙游县', '0', '2019-10-20 21:09:20', '2019-10-20 21:09:20', 'E', 'B');
INSERT INTO `bm_user` VALUES ('21', 'ccc', '123456', '15688884444', '1', '/cbuc.png', '福建省-莆田-仙游县', '0', '2019-10-20 20:41:32', '2019-10-20 20:41:32', 'E', 'B');
INSERT INTO `bm_user` VALUES ('22', 'cdcd', '123456', '15688889999', '1', '/cbuc.png', '福建省-莆田-仙游县', '0', '2019-10-20 21:09:22', '2019-10-20 21:09:22', 'D', 'B');
INSERT INTO `bm_user` VALUES ('23', 'cscs22', '123456', '15688889999', '1', '/default-avatar.png', '福建省-莆田-仙游县', '0', '2019-10-20 21:10:06', '2019-10-20 21:10:06', 'E', 'S');
