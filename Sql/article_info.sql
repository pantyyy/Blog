/*
Navicat MySQL Data Transfer

Source Server         : mysql
Source Server Version : 50720
Source Host           : localhost:3306
Source Database       : blog

Target Server Type    : MYSQL
Target Server Version : 50720
File Encoding         : 65001

Date: 2018-07-04 17:58:20
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for article_info
-- ----------------------------
DROP TABLE IF EXISTS `article_info`;
CREATE TABLE `article_info` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(50) NOT NULL,
  `content` varchar(255) NOT NULL,
  `content_text` varchar(200) NOT NULL,
  `cover` varchar(100) NOT NULL,
  `view_count` int(11) NOT NULL,
  `update_time` datetime NOT NULL ON UPDATE CURRENT_TIMESTAMP,
  `status` int(11) NOT NULL,
  `type_id` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of article_info
-- ----------------------------
INSERT INTO `article_info` VALUES ('1', '大话设计模式', '测试', '测试', '1.jpg', '3', '2018-06-26 16:55:10', '1', '1');
