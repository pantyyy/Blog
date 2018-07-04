/*
Navicat MySQL Data Transfer

Source Server         : mysql
Source Server Version : 50720
Source Host           : localhost:3306
Source Database       : blog

Target Server Type    : MYSQL
Target Server Version : 50720
File Encoding         : 65001

Date: 2018-07-04 17:58:28
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for type_info
-- ----------------------------
DROP TABLE IF EXISTS `type_info`;
CREATE TABLE `type_info` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(20) NOT NULL,
  `sort` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of type_info
-- ----------------------------
INSERT INTO `type_info` VALUES ('1', 'javaEE', '1');
INSERT INTO `type_info` VALUES ('2', 'javaSE', '1');
INSERT INTO `type_info` VALUES ('3', 'Python', '1');
