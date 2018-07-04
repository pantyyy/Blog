/*
Navicat MySQL Data Transfer

Source Server         : mysql
Source Server Version : 50720
Source Host           : localhost:3306
Source Database       : blog

Target Server Type    : MYSQL
Target Server Version : 50720
File Encoding         : 65001

Date: 2018-07-04 17:58:35
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for user_info
-- ----------------------------
DROP TABLE IF EXISTS `user_info`;
CREATE TABLE `user_info` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `login_name` varchar(50) DEFAULT NULL,
  `pass_word` varchar(50) DEFAULT NULL,
  `type` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of user_info
-- ----------------------------
INSERT INTO `user_info` VALUES ('1', 'admin', '123456', null);
INSERT INTO `user_info` VALUES ('2', 'lck', '123', null);
INSERT INTO `user_info` VALUES ('3', 'lck', '123', null);
