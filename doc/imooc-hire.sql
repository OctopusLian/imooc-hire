/*
 Navicat Premium Data Transfer

 Source Server         : 慕聘网
 Source Server Type    : MySQL
 Source Server Version : 80027
 Source Host           : 47.93.58.227:6022
 Source Schema         : imooc-hire

 Target Server Type    : MySQL
 Target Server Version : 80027
 File Encoding         : 65001

 Date: 19/08/2022 12:06:22
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for admin
-- ----------------------------
DROP TABLE IF EXISTS `admin`;
CREATE TABLE `admin` (
  `id` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `username` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '登录名',
  `password` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '密码',
  `slat` varchar(8) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '用户混合加密的盐',
  `remark` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '备注',
  `face` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '头像',
  `create_time` datetime NOT NULL,
  `updated_time` datetime NOT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='慕聘网运营管理系统的admin账户表，仅登录，不提供注册';

-- ----------------------------
-- Records of admin
-- ----------------------------
BEGIN;
INSERT INTO `admin` VALUES ('1001', 'admin', '62d09f7ec589014407809387f342456b', '8111', '管理员', 'http://hire.t.mukewang.com/static/adminFace/644842e3-0173-42c0-a7a9-abdba09c358b.png', '2022-06-10 11:03:29', '2022-08-19 11:44:32');
INSERT INTO `admin` VALUES ('1539127633931186177', '热3r', 'ff4cc0d027568a49c60bca2b8f61671c', '2896', '43热3', NULL, '2022-06-21 14:06:38', '2022-06-21 22:44:34');
INSERT INTO `admin` VALUES ('1539128195129061378', 'qq', 'b3cf9e3a24330d6b566df5420cb1f583', '9619', '哈哈，我更新啦222', 'http://192.168.1.5:8000/static/adminFace/34247857-2b77-4cf9-b688-71968b550323.png', '2022-06-21 14:08:52', '2022-06-22 12:24:35');
INSERT INTO `admin` VALUES ('1539128221037277186', 'dwq', 'b8a11861a1162913f683a4b1039eb4fa', '1027', 'dwqdwq', NULL, '2022-06-21 14:08:58', '2022-06-21 22:44:50');
INSERT INTO `admin` VALUES ('1539128286099320833', 'dwqf', '3134f0873e6d865c5a551c2a34e8d420', '1315', 'dwqdwq', NULL, '2022-06-21 14:09:14', '2022-06-21 14:09:14');
INSERT INTO `admin` VALUES ('1539128442525888513', '543543', 'c38759e493a70cbc28c2a5f23a91fe29', '7881', '', NULL, '2022-06-21 14:09:51', '2022-06-21 14:09:51');
INSERT INTO `admin` VALUES ('1539128858982526978', 'ew', '98050f2d4df3576aee2da9d2cf75778b', '8009', 'ewdewdew', NULL, '2022-06-21 14:11:30', '2022-06-21 14:11:30');
INSERT INTO `admin` VALUES ('1539129547347505154', 'gtr', '7473cfac929f12f7ba9f996cfe4286bc', '1813', 'trgrt', NULL, '2022-06-21 14:14:14', '2022-06-21 14:14:14');
INSERT INTO `admin` VALUES ('1539129616809373698', '32e32e', 'ffe04e51d7249e4f2d55bf988ef69387', '6449', 'trgrt33', NULL, '2022-06-21 14:14:31', '2022-06-21 14:14:31');
INSERT INTO `admin` VALUES ('1540179945319563266', 'aaa', '4fc119974bec528eab70e2b281a7dc02', '3179', 'aaa', NULL, '2022-06-24 11:48:09', '2022-06-24 11:48:09');
INSERT INTO `admin` VALUES ('1540180057273925633', 'qqqq', 'a1086003e6bbfa2304089eadc800bdae', '1380', 'qq', NULL, '2022-06-24 11:48:35', '2022-06-24 11:48:35');
COMMIT;

-- ----------------------------
-- Table structure for article
-- ----------------------------
DROP TABLE IF EXISTS `article`;
CREATE TABLE `article` (
  `id` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `title` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '文章标题',
  `content` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '文章内容，长度不超过9999，自行在前后端判断',
  `article_cover` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '文章封面图，article_type=1 的时候展示',
  `publish_admin_id` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '发布者amin_id',
  `publish_time` datetime DEFAULT NULL COMMENT '文章发布时间（也是预约发布的时间）',
  `publisher` varchar(24) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '发布者，字段冗余，避免多表关联',
  `publisher_face` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '发布者头像，字段冗余',
  `status` int NOT NULL COMMENT '文章状态：0：关闭，待发布，1：正常，可查阅，2：删除，无法查看',
  `create_time` datetime NOT NULL,
  `update_time` datetime NOT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='文章表';

-- ----------------------------
-- Records of article
-- ----------------------------
BEGIN;
INSERT INTO `article` VALUES ('1551157924451385345', '福利待遇', 'fcew分为', 'articleCover', '1539128195129061378', NULL, 'qq', NULL, 0, '2022-07-24 18:50:43', '2022-07-24 18:50:43');
INSERT INTO `article` VALUES ('1551158139875033089', '福利待遇', 'fcew分为', 'articleCover', '1539128195129061378', '2022-07-24 23:12:10', 'qq', NULL, 0, '2022-07-24 18:51:34', '2022-07-24 18:51:34');
INSERT INTO `article` VALUES ('1551175222499250178', '福利待遇', 'fcew分为', 'articleCover', '1539128195129061378', '2022-07-24 23:12:10', 'qq', NULL, 0, '2022-07-24 19:59:27', '2022-07-24 19:59:27');
INSERT INTO `article` VALUES ('1551213374572150785', '福利待遇22', 'deqwdqw的味道', 'articleCover', '1539128195129061378', '2022-07-24 23:12:10', 'qq', NULL, 1, '2022-07-24 22:31:03', '2022-07-24 22:31:13');
INSERT INTO `article` VALUES ('1551416988058013698', 'aaa', '<p>分为分为</p>', 'http://192.168.1.4:8000/static/photo/article/cover/847b8987-d4cc-43f8-9a41-d6cb6094faa0.jpeg', '1539128195129061378', NULL, 'admin', NULL, 0, '2022-07-25 12:00:09', '2022-08-19 11:55:16');
INSERT INTO `article` VALUES ('1551417441906872322', '入2日3', '<p>入2入2</p>', 'http://192.168.1.4:8000/static/photo/article/cover/5e5e6e69-e3ca-4a0d-b954-508068ac0b31.png', '1539128195129061378', NULL, 'admin', NULL, 0, '2022-07-25 12:01:57', '2022-08-19 11:55:17');
INSERT INTO `article` VALUES ('1551418418361815042', 'r43r43', '<p>tg53t34</p>', 'http://192.168.1.4:8000/static/photo/article/cover/bd406d5f-c79e-42e1-9c33-83f2adb338a9.png', '1539128195129061378', '2022-07-23 00:00:00', 'admin', NULL, 1, '2022-07-25 12:05:50', '2022-07-25 12:06:00');
INSERT INTO `article` VALUES ('1551421712614313985', 'wdfwd分为分为', '<p>g仍无法岗位分为</p>', 'http://192.168.1.4:8000/static/photo/article/cover/c0c94254-204c-4764-ba06-99e0637c80c7.png', '1539128195129061378', '2022-07-22 00:00:00', 'admin', NULL, 2, '2022-07-25 12:18:55', '2022-07-25 12:19:05');
INSERT INTO `article` VALUES ('1551421886526935041', '分为分为', '<p>g仍无法岗位分为分为的期望</p>', 'http://192.168.1.4:8000/static/photo/article/cover/0204efe0-1ce5-4c0a-95c5-78257d3723c3.png', '1539128195129061378', '2022-07-21 00:00:00', 'admin', NULL, 1, '2022-07-25 12:19:36', '2022-07-25 12:19:46');
INSERT INTO `article` VALUES ('1551422464921456642', '热闻', '<p>g仍无法岗位分为分为的期望</p>', 'http://192.168.1.4:8000/static/photo/article/cover/36923399-17e5-4162-bcf3-0b2cf47bc376.jpeg', '1539128195129061378', '2022-07-01 00:00:00', 'admin', NULL, 0, '2022-07-25 12:21:54', '2022-08-19 11:55:18');
INSERT INTO `article` VALUES ('1551423130431672321', 'fewfew', '<p>&nbsp;fewdwe&nbsp;</p>', 'http://192.168.1.4:8000/static/photo/article/cover/505bedf5-046f-4cf8-94c9-dc8e3e5ec919.png', '1539128195129061378', '2022-07-06 00:00:00', 'admin', NULL, 0, '2022-07-25 12:24:33', '2022-08-19 11:55:20');
INSERT INTO `article` VALUES ('1551423274925445121', 'fewfew', '<p>fewfew</p>', 'http://192.168.1.4:8000/static/photo/article/cover/491de09a-907a-491c-964f-15c16ba5c9c1.jpeg', '1539128195129061378', '2022-07-03 00:00:00', 'admin', NULL, 0, '2022-07-25 12:25:07', '2022-08-19 11:55:18');
INSERT INTO `article` VALUES ('1551423418416779265', 'fewfwe', '<p>few</p>', 'http://192.168.1.4:8000/static/photo/article/cover/4722f51c-003a-4fe2-8103-ac4c97c7dcc5.png', '1539128195129061378', '2022-07-25 00:00:00', 'admin', NULL, 1, '2022-07-25 12:25:42', '2022-07-25 12:25:52');
INSERT INTO `article` VALUES ('1551423799699984386', 'htrrt', '<p>htrhthrt</p>', '', '1539128195129061378', '2022-07-24 00:00:00', 'admin', NULL, 1, '2022-07-25 12:27:13', '2022-07-25 12:27:22');
INSERT INTO `article` VALUES ('1551438462168956929', 'r2534r', '<p>r32r23</p>', 'http://192.168.1.4:8000/static/photo/article/cover/33b765f7-de7c-499a-a70b-bb585b698340.png', '1539128195129061378', '2022-07-04 00:00:00', 'admin', NULL, 0, '2022-07-25 13:25:28', '2022-08-19 11:55:20');
INSERT INTO `article` VALUES ('1551439734372663298', 'r2534r', '<p>r32r23</p>', 'http://192.168.1.4:8000/static/photo/article/cover/33b765f7-de7c-499a-a70b-bb585b698340.png', '1539128195129061378', '2022-07-04 00:00:00', 'admin', NULL, 0, '2022-07-25 13:30:32', '2022-08-19 11:55:19');
INSERT INTO `article` VALUES ('1551439785316679682', 'r2534rgre', '<p>r32r23gregr</p>', 'http://192.168.1.4:8000/static/photo/article/cover/33b765f7-de7c-499a-a70b-bb585b698340.png', '1539128195129061378', '2022-07-10 00:00:00', 'admin', NULL, 0, '2022-07-25 13:30:44', '2022-08-19 11:55:21');
INSERT INTO `article` VALUES ('1551439903591858178', '哈哈哈哈', '<p>r32r23gregr</p>', 'http://192.168.1.4:8000/static/photo/article/cover/33b765f7-de7c-499a-a70b-bb585b698340.png', '1539128195129061378', '2022-07-10 00:00:00', 'admin', NULL, 1, '2022-07-25 13:31:12', '2022-07-25 14:46:28');
INSERT INTO `article` VALUES ('1551440004053827586', 'r2534rgre', '<p>r32r23gregr</p>', 'http://192.168.1.4:8000/static/photo/article/cover/33b765f7-de7c-499a-a70b-bb585b698340.png', '1539128195129061378', '2022-07-10 00:00:00', 'admin', NULL, 2, '2022-07-25 13:31:36', '2022-07-25 14:46:27');
INSERT INTO `article` VALUES ('1551440386125561857', '废物范围发我', '<p>r32r23gregr</p>', 'http://192.168.1.4:8000/static/photo/article/cover/33b765f7-de7c-499a-a70b-bb585b698340.png', '1539128195129061378', '2022-07-10 00:00:00', 'admin', NULL, 1, '2022-07-25 13:33:07', '2022-07-25 14:46:24');
INSERT INTO `article` VALUES ('1551453169126813697', '新增文章被修改了', '<p>123456</p>', 'http://192.168.1.4:8000/static/photo/article/cover/66fd7920-b265-4a33-879a-41378b152545.png', '1539128195129061378', '2022-07-21 00:00:00', 'admin', NULL, 2, '2022-07-25 14:23:55', '2022-07-25 14:31:19');
INSERT INTO `article` VALUES ('1551565005654335490', '测试文字啦~~~~', '<p data-track=\"1\">连日来，我国多地遭遇40℃以上的高温，重庆、四川、浙江、江苏等地连发高温红色预警。</p>\n<p data-track=\"2\">国家气候中心监测数据显示，今年6月至7月上旬，全国平均高温日数5.3天，为1961年以来历史同期最多，综合强度为1961年以来第6强。</p>\n<p data-track=\"3\">在高温&ldquo;超长待机&rdquo;模式下，空调变成不可或缺的&ldquo;续命神器&rdquo;，而与此同时，关于集中供冷的话题也引发了越来越多的讨论。</p>\n<p data-track=\"4\">尤其是在济南CBD片区试行集中供冷之后，有关&ldquo;不开空调也能将室温保持26℃&rdquo;的报道，对于酷暑难耐的人们来说，充满了吸引力。</p>\n<p data-track=\"5\">毕竟在炎炎夏日，如果能像集中供暖一样实现集中供冷，&ldquo;幸福指数&rdquo;必然会得到大幅提升。</p>\n<p data-track=\"6\">不过，相比北方已经试行了数十年的集中供暖，集中供冷对大部分人而言显然还很陌生。集中供冷是否涉及现有市政设施改造、供冷费怎么收、什么条件能大面积推广等，都是大家关注的话题。</p>\n<p data-track=\"7\"><strong>制冷效果不错</strong></p>\n<p data-track=\"8\">据报道，从今年起，济南CBD片区开始集中供冷模式试运行，已经覆盖该片区商场、写字楼等约21万平方米范围。</p>\n<div class=\"pgc-img\"><img class=\"syl-page-img\" src=\"https://p26.toutiaoimg.com/origin/tos-cn-i-qvj2lq49k0/df9408f8c98144b496f29c34888cf56d?from=pc\" alt=\"集中供冷要来了，未来不开空调室温26℃？\" />\n<p class=\"pgc-img-caption\">&nbsp;</p>\n</div>\n<p data-track=\"9\">济南CBD片区</p>\n<p data-track=\"10\">值得关注的是，济南CBD片区采用了国内最大规模的冷暖同供网，冬天供暖夏季供冷&mdash;&mdash;同一套管网系统，无疑可以节省重复建设成本和空间资源。</p>\n<p data-track=\"11\">那么，&ldquo;制冷&rdquo;与&ldquo;制热&rdquo;模式的切换是如何实现的？其实，管网中的媒介始终是水，供冷还是供热取决于水温的高低。</p>\n<p data-track=\"12\">冬季集中供暖时，热源采用章丘电厂余热，通过43.8公里的长输管网将热水输送到CBD片区，再通过热力交换站，将热水送到每一位用户的末端系统，例如暖气片、地暖等。</p>\n<p data-track=\"13\">夏季集中供冷时，使用南部能源中心冷源，利用CBD区域内现有冬季供热管网，把冷冻水输送到位于区域内的换热站，通过冷交换后将7℃-9℃的冷冻水输送到用户的末端风盘系统。</p>\n<p data-track=\"14\">此外，集中供冷也可以手动调节温度。据了解，济南CBD片区用户末端散冷设施均采用风机盘管形式，该种设备自带温度控制面板，用户可以根据需求自主调节室内温度。</p>\n<p data-track=\"15\">&ldquo;室内保持在26℃左右，效果非常好。供冷费按用冷量来结算，挂表计量，如果不使用无任何费用。&rdquo;在济南CBD片区办公的山东港口物流集团酒店管理公司综合部张梓浩说。</p>\n<p data-track=\"16\">负责济南CBD集中供冷的山东睿冠电能热力有限公司董事长崔玥曾对媒体介绍，从目前片区已经使用集中供冷的用户反馈来看，效果不错。</p>\n<p data-track=\"17\">&ldquo;从运行初期到现在，用户有一个逐渐认知的过程，就像上世纪90年代初济南刚开始集中供暖时一样。&rdquo;崔玥说。</p>\n<p data-track=\"18\">一位业内人士告诉中国新闻周刊，济南CBD片区得以实行集中供冷，与2017年5月济南市政府编制的《济南CBD城市设计及导则》有关，里面规定该片区在沿用济南市原有集中供热的基础上，同时采用区域集中供冷。</p>\n<p data-track=\"19\">&ldquo;现在集中供冷的应用仍很局限。一般情况下，在大型商场、车站、写字楼以及医院、实验室、工厂等特殊场所，才能看到。CBD片区为商业集聚区，区域内冷热需求的建筑密度大，且较为集中。这是该片区能同时实现冬季供暖夏季集中供冷的重要前提条件。&rdquo;该业内人士说。</p>\n<p data-track=\"20\">这种商业集聚区使用集中供冷相比自己建设空调设备，不但减少了机房占地、冷却塔屋面占地，且减少了建筑用于空调制冷的电增容费，而且无空调外挂机影响建筑美观。</p>\n<p data-track=\"21\">同圆设计集团总工程师李刚曾表示，在商业集聚区，可以利用不同功能商业楼宇用能需求高峰时间不同的特点，配合冰蓄冷和水蓄冷系统的设计，充分利用峰谷电差价蓄冷调峰，既降低了系统运行费用，又实现了电网的削峰填谷。</p>\n<p data-track=\"22\">据估算，未来济南CBD片区供冷面积达到220万平方米以后，每年可以减少大约12万吨的二氧化碳排放量，大约相当于1万户家庭整个夏季空调制冷所产生的碳排放。</p>\n<p data-track=\"23\"><strong>尚处起步阶段</strong></p>\n<p data-track=\"24\">集中供冷的概念早在20世纪40年代就有人提出，但一直到1961年，美国康涅狄格州首府哈特福德（Hartford）才开始尝试集中供冷。但受到当时技术条件的影响，其系统的热力系数很低，且经济性也不高，甚至无法和传统的空调系统相比，因此发展并不顺利。</p>\n<p data-track=\"25\">之后，日本、法国、挪威、丹麦、瑞典等国家都有所尝试。一些北欧国家尤其擅长利用海水、湖水、地下水等自然冷量制冷。</p>\n<p data-track=\"26\">在集中供冷领域，中国目前还处于起步阶段。</p>\n<p data-track=\"27\">当前，我国城市居民夏季制冷主要采用分体式电空调，该制冷方式从发电、输电，到空调室内外气体的热量传递，都在不断加剧&ldquo;热岛效应&rdquo;。</p>\n<p data-track=\"28\">此外，空调制冷还存在能耗高、滴水扰民、室外机影响建筑物美观等问题，空调中制冷剂氟立昂的使用，也受到环保专家的普遍质疑。因此，对于生态环境而言，空调并不是那么&ldquo;友好&rdquo;。</p>\n<p data-track=\"29\">2000年，中国印发《关于发展热电联产的规定》，鼓励各地区积极发展城市热水供应和集中供冷，扩大夏季制冷负荷，提高全年运行效率。自此，中国城市步入了建设区域供冷系统的探索。</p>\n<p data-track=\"30\">当前，我国广州大学城、深圳前海区、北京中关村科技园等区域也采用了集中供冷方式，并已投入运行。</p>\n<p data-track=\"31\">广州大学城是我国最早实行集中供冷的区域之一，也是当时全球供冷量最大的区域供冷项目之一。</p>\n<p data-track=\"32\">该大学城由10所大学及中心区构成，工程总建筑面积约800万平方米，大学城能源系统采用了分布式能源系统（又称&ldquo;冷热电三联供&rdquo;），整个系统由分布式能源站、区域供冷系统和集中生活热水系统组成。</p>\n<p data-track=\"33\">分布式能源站以液化燃气为燃料，燃烧获得燃气，燃气先用来发电，余热产生的部分蒸汽通过集中生活热水系统向大学城区供应热水，另一部分蒸汽进入区域供冷系统，这种类似家用空调的装置产生2.5℃左右的冷水，冷水通过与风扇交换热能产生冷气，颇受当地师生喜爱。</p>\n<p data-track=\"34\">与此同时，今年7月，深圳前海5号冷站&ldquo;集中监控和展示中心&rdquo;宣布正式启用。前海5号冷站是前海区域集中供冷系统的中心站，也是前海深港合作区前湾片区的首个冷站，目前已为前海嘉里中心、前海中集国际中心等10余家建筑综合体集中供冷。</p>\n<p data-track=\"35\">&ldquo;集中监控和展示中心&rdquo;的正式启用，意味着未来运行管理人员可通过集中监控系统，远程操控前海所有冷站设备的&ldquo;中心站&rdquo;，实现前海区域供冷系统的集中调度、控制和管理，大大提高系统管理效能。</p>\n<p data-track=\"36\">但并不是每个集中供冷项目都能顺利推进。</p>\n<p data-track=\"37\">2014年，太原供冷项目由于道路改造与热源电厂的拆除，不得不面临暂停的厄运。</p>\n<p data-track=\"38\">时间回到2000年，当年太原市热力公司为提升供暖设备使用率，在原有设备基础上进行了改造，改变了供暖设备过去&ldquo;冬季运作夏季闲置&rdquo;的状况，每年集中供冷时间为6月20日&mdash;8月20日。</p>\n<p data-track=\"39\">但在运行的十多年时间里，太原实际的供冷面积不到5万平方米，使用集中供冷的单位，也仅有太原火车站、太原市公安局、美特好超市（五一店）3家单位。而数据显示，太原市集中供冷能力已达100万平方米。</p>\n<p data-track=\"40\">当时，该项目负责人称，由于社会公众认识不到位，造成集中供冷项目难推广，过低的使用率让制冷设备&ldquo;名存实亡&rdquo;，使得该项目运行15年也仅能够维持成本。</p>\n<p data-track=\"41\"><strong>&ldquo;经济账&rdquo;难算</strong></p>\n<p data-track=\"42\">集中供冷在商业区实现了试运行，但如何才能走进千家万户，在住宅中大面积使用？</p>\n<p data-track=\"43\">重庆亿众数字能源科技有限公司总经理吴小龙在接受中国新闻周刊采访时谈道，在住宅中实现集中供冷，在技术层面上并不困难，甚至还能根据不同使用场景提供多套技术方案以供选择。但集中供冷面临的首要问题，在于人们的认知度。</p>\n<p data-track=\"44\">现阶段，我国冬季供热取暖属于&ldquo;温饱型&rdquo;的刚性需求，夏季供冷则属&ldquo;享受型&rdquo;的软性消费，对于很多用户而言，供冷是一种生活质量的改善而非保障性因素，因此并不是所有的人都愿意为此买单。</p>\n<p data-track=\"45\">理论上来说，只要有集中供热的地方都能实现集中供冷，无论是对原有的热力站加以改造，安装制冷设备，还是重新铺设冷暖同供管网&mdash;&mdash;经过改造之后的热力站成为集供热、供冷、供生活热水功能于一身的&ldquo;集中能源站&rdquo;。</p>\n<p data-track=\"46\">然而在实际操作层面上，要面对的问题却有很多。吴小龙曾做过估算，&ldquo;成本并不低&rdquo;。</p>\n<p data-track=\"47\">据了解，输冷管道比供热管道在保温密封程度方面的要求高，冷气管道的保温材料稍有缝隙，就会在冷气管道外表产生冷凝水、结霜，造成能源消耗。此外，居民家中现有的暖气片无法发挥散冷作用，要统一改装风机盘管风口。风机盘管风口的原理类似空调室内机的出风口，通过这个风口供热或供冷。</p>\n<p data-track=\"48\">制冷管道改造时，还需要做增减管线、墙体穿洞等施工，现在居民家中多数都装修过，重新铺设管线会对居民家中原有的装修造成损坏。再加上由于管道设施指标要求很高，造成改造的一次性投入花费并不低。</p>\n<p data-track=\"49\">&ldquo;对于已经完成装修，并购置好空调的住宅用户，很少愿意再额外支付供冷费。&rdquo;吴小龙坦言，&ldquo;除非像北方的供暖设备，预先安置在即将交付的新房中，用户才会慢慢习以为常。&rdquo;</p>\n<p data-track=\"50\">由此可见，建成住宅的难以改造以及新建住宅的契机缺乏，成为集中供冷走进百姓生活的阻力之一。</p>\n<p data-track=\"51\">供冷费也是人们较为关心的话题之一。</p>\n<p data-track=\"52\">吴小龙介绍，当前冷站的辐射范围在5公里之内，不像集中供暖，管道可以铺得很长。由于使用规模无法扩大，随着供应成本的提高，企业受困于有限的用户和过低的使用率，往往造成运营上的困难。</p>\n<p data-track=\"53\">在北方，供暖期可长达5个月，较少会有人去停暖气，但集中供冷不同，如果觉得气温不合适，可以随时手动关掉。&ldquo;假设一个小区供冷面积为10万平方米，而往往实际使用面积只有3到4万平方米。&rdquo;吴小龙说。</p>\n<p data-track=\"54\">他谈道，在部分南方已推广集中供冷的小区，每月供冷费在700元左右，&ldquo;略高于空调费。&rdquo;</p>\n<p data-track=\"55\">吴小龙和团队曾在南方做过一个大范围调研，关于是否要实行集中供冷。调查初期，参与调研人员几乎踊跃支持，但到了真正付费时，却发现愿意买单的人数远远低于预期。</p>\n<p data-track=\"56\">&ldquo;南方其实早就有不少集中供冷项目，为何缺乏宣传？因为严格来说没有一个真正挣钱的。&rdquo;他说。</p>\n<p data-track=\"57\">因此，对于投资方而言，如何算好&ldquo;经济账&rdquo;成为一大难题。</p>\n<p data-track=\"58\">吴小龙认为，集中供冷虽然属于民生工程，但如何将其做成一个完整的、具有可复制性的盈利项目，才是集中供冷能否大面积推广的关键因素。</p>', '', '1001', '2022-08-18 00:00:00', 'admin', 'http://122.152.205.72:88/group1/M00/00/05/CpoxxF6ZUySASMbOAABBAXhjY0Y649.png', 1, '2022-07-25 21:48:19', '2022-07-25 21:48:29');
INSERT INTO `article` VALUES ('1560472466672439297', 'centos6中安装新版 Elasticsearch 7.x', '<p>es出新版了，虽然公司里还是用的老版本，但是本地还是有必要自己安装了玩玩</p>\n<p>下载地址：<a href=\"https://www.elastic.co/cn/downloads/elasticsearch\">https://www.elastic.co/cn/downloads/elasticsearch</a></p>\n<p><img class=\"\" title=\"\" src=\"https://img3.sycdn.imooc.com/5ce2c65d0001d98318900984.jpg\" alt=\"https://img3.sycdn.imooc.com/5ce2c65d0001d98318900984.jpg\" data-src=\"https://img3.sycdn.imooc.com/5ce2c65d0001d98318900984.jpg\" data-original=\"https://img3.sycdn.imooc.com/5ce2c65d0001d98318900984.jpg\" /></p>\n<p>那么一般来说还是建议安装到linux里，当然选择在win和mac也ok，我们这里以linux安装为主</p>\n<p>下载完毕以后上传到linux中：</p>\n<p><img class=\"\" title=\"\" src=\"https://img1.sycdn.imooc.com/5ce2c7130001fee121180418.jpg\" alt=\"https://img1.sycdn.imooc.com/5ce2c7130001fee121180418.jpg\" data-src=\"https://img1.sycdn.imooc.com/5ce2c7130001fee121180418.jpg\" data-original=\"https://img1.sycdn.imooc.com/5ce2c7130001fee121180418.jpg\" /></p>\n<p>安装es之前，务必安装jdk1.8以上，官方说到openjdk也可以，但是没试过，大家可以自行尝试，以下就是官方的依赖说明，怎么安装jdk的，不多说了。。应该都会</p>\n<p><img class=\"\" title=\"\" src=\"https://img3.sycdn.imooc.com/5ce2c9870001803113820174.jpg\" alt=\"https://img3.sycdn.imooc.com/5ce2c9870001803113820174.jpg\" data-src=\"https://img3.sycdn.imooc.com/5ce2c9870001803113820174.jpg\" data-original=\"https://img3.sycdn.imooc.com/5ce2c9870001803113820174.jpg\" /></p>\n<p>解压es的tar包：</p>\n<p><img class=\"\" title=\"\" src=\"https://img3.sycdn.imooc.com/5ce2cad70001a69118620074.jpg\" alt=\"https://img3.sycdn.imooc.com/5ce2cad70001a69118620074.jpg\" data-src=\"https://img3.sycdn.imooc.com/5ce2cad70001a69118620074.jpg\" data-original=\"https://img3.sycdn.imooc.com/5ce2cad70001a69118620074.jpg\" /></p>\n<p>&nbsp;随后进入解压后es的目录，如下：</p>\n<p><img class=\"\" title=\"\" src=\"https://img1.sycdn.imooc.com/5ce2cb480001177e15080510.jpg\" alt=\"https://img1.sycdn.imooc.com/5ce2cb480001177e15080510.jpg\" data-src=\"https://img1.sycdn.imooc.com/5ce2cb480001177e15080510.jpg\" data-original=\"https://img1.sycdn.imooc.com/5ce2cb480001177e15080510.jpg\" /></p>\n<p>依次说一下目录结构吧：</p>\n<p>bin：可执行文件在里面，运行es的命令就在这个里面</p>\n<p>config：配置文件目录</p>\n<p>lib：依赖的jar</p>\n<p>logs：日志</p>\n<p>modules：模块</p>\n<p>plugins：可以自己开发的插件</p>\n<p>data，这个目录，没有，自己新建一下：mkdir data，这个作为索引目录</p>\n<p>&nbsp;</p>\n<p>随后进入conf目录，使用vim 修改 elasticearch.yml</p>\n<p><img class=\"\" title=\"\" src=\"https://img4.sycdn.imooc.com/5ce2cc6000010e1015300516.jpg\" alt=\"https://img4.sycdn.imooc.com/5ce2cc6000010e1015300516.jpg\" data-src=\"https://img4.sycdn.imooc.com/5ce2cc6000010e1015300516.jpg\" data-original=\"https://img4.sycdn.imooc.com/5ce2cc6000010e1015300516.jpg\" /></p>\n<p>修改集群名称，默认是elasticsearch，虽然目前是单机，但是也会有默认的</p>\n<p><img class=\"\" title=\"\" src=\"https://img2.sycdn.imooc.com/5ce2cce60001157207680052.jpg\" alt=\"https://img2.sycdn.imooc.com/5ce2cce60001157207680052.jpg\" data-src=\"https://img2.sycdn.imooc.com/5ce2cce60001157207680052.jpg\" data-original=\"https://img2.sycdn.imooc.com/5ce2cce60001157207680052.jpg\" /></p>\n<p>&nbsp;为当前的es节点取个名称，名称随意，如果在集群环境中，都要有相应的名字</p>\n<p><img class=\"\" title=\"\" src=\"https://img4.sycdn.imooc.com/5ce2cd6a0001ff5805980070.jpg\" alt=\"https://img4.sycdn.imooc.com/5ce2cd6a0001ff5805980070.jpg\" data-src=\"https://img4.sycdn.imooc.com/5ce2cd6a0001ff5805980070.jpg\" data-original=\"https://img4.sycdn.imooc.com/5ce2cd6a0001ff5805980070.jpg\" /></p>\n<p>这是修改数据和日志的存储目录</p>\n<p><img class=\"\" title=\"\" src=\"https://img4.sycdn.imooc.com/5ce2ce1a0001524e12400402.jpg\" alt=\"https://img4.sycdn.imooc.com/5ce2ce1a0001524e12400402.jpg\" data-src=\"https://img4.sycdn.imooc.com/5ce2ce1a0001524e12400402.jpg\" data-original=\"https://img4.sycdn.imooc.com/5ce2ce1a0001524e12400402.jpg\" /></p>\n<p>设置绑定的ip，和redis一个道理，设置为0.0.0.0以后就可以让任何计算机节点访问到你了&nbsp;</p>\n<p><img class=\"\" title=\"\" src=\"https://img3.sycdn.imooc.com/5ce2ce87000131a509540360.jpg\" alt=\"https://img3.sycdn.imooc.com/5ce2ce87000131a509540360.jpg\" data-src=\"https://img3.sycdn.imooc.com/5ce2ce87000131a509540360.jpg\" data-original=\"https://img3.sycdn.imooc.com/5ce2ce87000131a509540360.jpg\" /></p>\n<p>&nbsp;设置在集群中的所有节点名称，这个节点名称就是之前所修改的，当然你也可以采用默认的也行，目前是单机，放入一个节点即可</p>\n<p><img class=\"\" title=\"\" src=\"https://img4.sycdn.imooc.com/5ce2cf3200016cad11580082.jpg\" alt=\"https://img4.sycdn.imooc.com/5ce2cf3200016cad11580082.jpg\" data-src=\"https://img4.sycdn.imooc.com/5ce2cf3200016cad11580082.jpg\" data-original=\"https://img4.sycdn.imooc.com/5ce2cf3200016cad11580082.jpg\" /></p>\n<p>修改完毕后，保存退出vim，随后就准备启动es了，进入到bin目录，运行es：./elasticsearch</p>\n<p>这个时候报了一个异常：</p>\n<blockquote>\n<pre>java.lang.RuntimeException:&nbsp;can&nbsp;not&nbsp;run&nbsp;elasticsearch&nbsp;as&nbsp;root</pre>\n</blockquote>\n<p>很明显，提示说我们无法使用root用户来运行es，这是es的设计，为了安全</p>\n<p>那么这个时候就需要创建一个新用户，并且为这个用户添加es目录的操作权限了</p>\n<p><img class=\"\" title=\"\" src=\"https://img1.sycdn.imooc.com/5ce2d1f40001561b15760132.jpg\" alt=\"https://img1.sycdn.imooc.com/5ce2d1f40001561b15760132.jpg\" data-src=\"https://img1.sycdn.imooc.com/5ce2d1f40001561b15760132.jpg\" data-original=\"https://img1.sycdn.imooc.com/5ce2d1f40001561b15760132.jpg\" /></p>\n<p>切换用户以后，再次运行&nbsp; ./elasticserch&nbsp;</p>\n<p>&nbsp;</p>\n<p>此时又报错，来看一下：</p>\n<blockquote>\n<p>java.lang.UnsupportedOperationException: seccomp unavailable: requires kernel 3.5+ with CONFIG_SECCOMP and CONFIG_SECCOMP_FILTER</p>\n</blockquote>\n<p>其实从异常可以看出是不支持的操作系统，主要是 seccomp，那么重新进入 conf 下去配置 elasticsearch.yml&nbsp;</p>\n<p>增加下面这一行配置，用于禁用seccomp<img class=\"\" title=\"\" src=\"https://img4.sycdn.imooc.com/5ce2d3350001bec514120374.jpg\" alt=\"https://img4.sycdn.imooc.com/5ce2d3350001bec514120374.jpg\" data-src=\"https://img4.sycdn.imooc.com/5ce2d3350001bec514120374.jpg\" data-original=\"https://img4.sycdn.imooc.com/5ce2d3350001bec514120374.jpg\" /></p>\n<p>回到bin目录再次启动es，又发现如下3个错误：</p>\n<table class=\"syntaxhighlighter  bash\" border=\"0\" cellspacing=\"0\" cellpadding=\"0\">\n<tbody>\n<tr>\n<td class=\"gutter\">\n<div class=\"line number1 index0 alt2\">1</div>\n<div class=\"line number2 index1 alt1\">2</div>\n<div class=\"line number3 index2 alt2\">3</div>\n<div class=\"line number4 index3 alt1\">4</div>\n</td>\n<td class=\"code\">\n<div class=\"container\">\n<div class=\"line number1 index0 alt2\"><code class=\"bash plain\">ERROR:&nbsp;[3]&nbsp;bootstrap&nbsp;checks&nbsp;failed[1]:&nbsp;</code></div>\n<div class=\"line number2 index1 alt1\"><code class=\"bash plain\">max&nbsp;</code><code class=\"bash functions\">file</code>&nbsp;<code class=\"bash plain\">descriptors&nbsp;[4096]&nbsp;</code><code class=\"bash keyword\">for</code>&nbsp;<code class=\"bash plain\">elasticsearch&nbsp;process&nbsp;is&nbsp;too&nbsp;low,&nbsp;increase&nbsp;to&nbsp;at&nbsp;least&nbsp;[65535]</code></div>\n<div class=\"line number3 index2 alt2\"><code class=\"bash plain\">[2]:&nbsp;max&nbsp;number&nbsp;of&nbsp;threads&nbsp;[1024]&nbsp;</code><code class=\"bash keyword\">for</code>&nbsp;<code class=\"bash plain\">user&nbsp;[lee]&nbsp;is&nbsp;too&nbsp;low,&nbsp;increase&nbsp;to&nbsp;at&nbsp;least&nbsp;[4096]</code></div>\n<div class=\"line number4 index3 alt1\"><code class=\"bash plain\">[3]:&nbsp;max&nbsp;virtual&nbsp;memory&nbsp;areas&nbsp;vm.max_map_count&nbsp;[65530]&nbsp;is&nbsp;too&nbsp;low,&nbsp;increase&nbsp;to&nbsp;at&nbsp;least&nbsp;[262144]</code></div>\n</div>\n</td>\n</tr>\n</tbody>\n</table>\n<p>&nbsp;</p>\n<p>那么依次去修改，不过得重新切换到root用户， su root</p>\n<p><img class=\"\" title=\"\" src=\"https://img1.sycdn.imooc.com/5ce2d4610001938013420220.jpg\" alt=\"https://img1.sycdn.imooc.com/5ce2d4610001938013420220.jpg\" data-src=\"https://img1.sycdn.imooc.com/5ce2d4610001938013420220.jpg\" data-original=\"https://img1.sycdn.imooc.com/5ce2d4610001938013420220.jpg\" /></p>\n<p>修改如下文件</p>\n<p><img class=\"\" title=\"\" src=\"https://img1.sycdn.imooc.com/5ce2d4aa000133c507820052.jpg\" alt=\"https://img1.sycdn.imooc.com/5ce2d4aa000133c507820052.jpg\" data-src=\"https://img1.sycdn.imooc.com/5ce2d4aa000133c507820052.jpg\" data-original=\"https://img1.sycdn.imooc.com/5ce2d4aa000133c507820052.jpg\" /></p>\n<p>添加如下：</p>\n<table class=\"syntaxhighlighter  bash\" border=\"0\" cellspacing=\"0\" cellpadding=\"0\">\n<tbody>\n<tr>\n<td class=\"gutter\">\n<div class=\"line number1 index0 alt2\">1</div>\n<div class=\"line number2 index1 alt1\">2</div>\n<div class=\"line number3 index2 alt2\">3</div>\n<div class=\"line number4 index3 alt1\">4</div>\n</td>\n<td class=\"code\">\n<div class=\"container\">\n<div class=\"line number1 index0 alt2\"><code class=\"bash plain\">*&nbsp;soft&nbsp;nofile&nbsp;65536</code></div>\n<div class=\"line number2 index1 alt1\"><code class=\"bash plain\">*&nbsp;hard&nbsp;nofile&nbsp;131072</code></div>\n<div class=\"line number3 index2 alt2\"><code class=\"bash plain\">*&nbsp;soft&nbsp;nproc&nbsp;2048</code></div>\n<div class=\"line number4 index3 alt1\"><code class=\"bash plain\">*&nbsp;hard&nbsp;nproc&nbsp;4096</code></div>\n</div>\n</td>\n</tr>\n</tbody>\n</table>\n<p>vim&nbsp;/etc/security/limits.d/90-nproc.conf 修改此文件</p>\n<p>改为4096</p>\n<p><img class=\"\" title=\"\" src=\"https://img1.sycdn.imooc.com/5ce2d68300011cc410200170.jpg\" alt=\"https://img1.sycdn.imooc.com/5ce2d68300011cc410200170.jpg\" data-src=\"https://img1.sycdn.imooc.com/5ce2d68300011cc410200170.jpg\" data-original=\"https://img1.sycdn.imooc.com/5ce2d68300011cc410200170.jpg\" /></p>\n<p>改完以后重新切换到非root用户lee下，运行es</p>\n<p>这个时候发现已经成功启动了，如下是es的相关信息：</p>\n<p><img class=\"\" title=\"\" src=\"https://img2.sycdn.imooc.com/5ce2d71b00016e0618881232.jpg\" alt=\"https://img2.sycdn.imooc.com/5ce2d71b00016e0618881232.jpg\" data-src=\"https://img2.sycdn.imooc.com/5ce2d71b00016e0618881232.jpg\" data-original=\"https://img2.sycdn.imooc.com/5ce2d71b00016e0618881232.jpg\" /></p>\n<p>&nbsp;</p>\n<p>&nbsp;那么现在是前台启动方式，我们需要改为后台启动方式来运行es，这样会更好</p>\n<p>能看懂吧？不多说了哈</p>\n<p><img class=\"\" title=\"\" src=\"https://img2.sycdn.imooc.com/5ce2d7c1000125da13580278.jpg\" alt=\"https://img2.sycdn.imooc.com/5ce2d7c1000125da13580278.jpg\" data-src=\"https://img2.sycdn.imooc.com/5ce2d7c1000125da13580278.jpg\" data-original=\"https://img2.sycdn.imooc.com/5ce2d7c1000125da13580278.jpg\" /></p>\n<p>那么安装到此完毕！</p>\n<p><br />作者：风间影月<br />链接：https://www.imooc.com/article/286936<br />来源：慕课网</p>', 'http://hire.t.mukewang.com/static/photo/article/cover/b0cc4a7a-82bc-4778-81e7-4097c6b50091.png', '1001', '2022-08-19 11:42:46', 'admin', 'http://hire.t.mukewang.com/static/adminFace/4a82f3d7-45c9-47fe-85bf-84fab1d1b6e9.png', 1, '2022-08-19 11:43:23', '2022-08-19 11:43:33');
INSERT INTO `article` VALUES ('1560472972660690946', '【DB优化1】高并发数据库读写分离架构', '<p>在微服务开发中，随着业务量数据量的提升，数据库必定遭遇高并发等风险。这里我们可以先来看一下如下图：</p>\n<p><img class=\"\" title=\"\" src=\"https://img1.sycdn.imooc.com/625c28340001b5ea08920686.jpg\" alt=\"https://img1.sycdn.imooc.com/625c28340001b5ea08920686.jpg\" data-src=\"https://img1.sycdn.imooc.com/625c28340001b5ea08920686.jpg\" data-original=\"https://img1.sycdn.imooc.com/625c28340001b5ea08920686.jpg\" /></p>\n<p>这是一个典型的微服务实例，假设现在有一个订单微服务（可以是一个服务集群），这个服务必定对应一个业务库，那就是订单数据库，订单微服务处于一整个服务调用的链路中，他会被其他微服务来进行调用，可以是rest请求也可以是rpc等调用。</p>\n<p>这个订单库是单库，单库在高并发的情况下必定出现瓶颈。此时，我们需要进行一定的优化。</p>\n<p>根据&ldquo;二八原则&rdquo;，80%都是读请求，甚至更多，20%都是写请求，甚至更少。所以绝大多数的业务场景之下都是高并发读。假设我们现在的目的是，要提高并发读的性能以及高可用读。那么这个时候我们可以将单数据库优化为如下：<br /><br /></p>\n<p><img class=\"\" title=\"\" src=\"https://img3.sycdn.imooc.com/625c283f00015ec317801036.jpg\" alt=\"https://img3.sycdn.imooc.com/625c283f00015ec317801036.jpg\" data-src=\"https://img3.sycdn.imooc.com/625c283f00015ec317801036.jpg\" data-original=\"https://img3.sycdn.imooc.com/625c283f00015ec317801036.jpg\" /></p>\n<p>从图中可以看到，用户的请求并不是全部都到达一个单库，而是会被分流，这是一个非常典型的读写分离架构。一个主库对应三个从库，主从之间通过binlog进行数据复制，而且主从的表数据结构完全一致，数据也都一样。</p>\n<p>像这样的一个主从架构可以保证高性能读以及高并发读，如果读库集群再次达到瓶颈则可以继续进行水平扩展。</p>\n<p><br />作者：风间影月<br />链接：https://www.imooc.com/article/324986<br />来源：慕课网</p>', 'http://hire.t.mukewang.com/static/photo/article/cover/678487b4-b9d6-439c-9448-a4c000a3e686.png', '1001', '2022-08-19 11:45:02', 'admin', 'http://hire.t.mukewang.com/static/adminFace/644842e3-0173-42c0-a7a9-abdba09c358b.png', 1, '2022-08-19 11:45:24', '2022-08-19 11:45:34');
INSERT INTO `article` VALUES ('1560473121122275329', 'Java架构师薪资路线进阶与技能要求', '<h3>Java 卷之又卷（内卷）（10min）</h3>\n<p><img class=\"\" src=\"https://img1.sycdn.imooc.com/61baa824000130cf12000587.jpg\" alt=\"https://img1.sycdn.imooc.com/61baa824000130cf12000587.jpg\" data-src=\"https://img1.sycdn.imooc.com/61baa824000130cf12000587.jpg\" data-original=\"https://img1.sycdn.imooc.com/61baa824000130cf12000587.jpg\" /></p>\n<p>image</p>\n<p>现状其实做java的人很多，所以竞争很大，也很内卷。 先来聊一下这个<code>内卷</code>，这个是我们最近一直讨论最多的一个关键字。</p>\n<p>以前还好，也就最近一两年、两三年吧，一直被提起，其实一直以来就存在，各行各业都存在这个现象。</p>\n<p>有没有不知道内卷是什么意思的同学啊？需不需要咱们解释一波？可以在公屏上来一波1。</p>\n<p>内卷： 啥是内卷，举个例子就比如说，本来我们公司5点半下班，现在少数几个人6点下班，老板看了觉得你可能在多干活，于是越来越多的人都6点下班，于是再到7点，再到8点最后演变为996。</p>\n<p>有的公司的确有这样的企业文化，的确挺恶心人的，我们不能在这里明说啊，我有一个学生，他已经面试全过了，最后offer口头说要发，但是最后hr说他的气场不合？啥意思？就是你不符合我们的企业文化，这是不是很扯？说多了啊，这是题外话。</p>\n<p>回到内卷，那现在大家应该对内卷这个词语有所了解了吧。懂了的来一波666。</p>\n<h3>Java的今天与未来（现状与前景）</h3>\n<p><img class=\"\" src=\"https://img2.sycdn.imooc.com/61baa8240001766e12000588.jpg\" alt=\"https://img2.sycdn.imooc.com/61baa8240001766e12000588.jpg\" data-src=\"https://img2.sycdn.imooc.com/61baa8240001766e12000588.jpg\" data-original=\"https://img2.sycdn.imooc.com/61baa8240001766e12000588.jpg\" /></p>\n<p>image</p>\n<p>先问下各位，有没有人正准备入行或者准备学习Java的？</p>\n<p>很早以前有一些学生很焦虑，问我要不要转别的语言，比如go或者Python。说java是不是未来有很多未知性，或者说未来可能走下坡路。</p>\n<p>其实不用怕的，也不会这么发展的，因为： Java Everywhere，java无处不在。 java可以做：</p>\n<ul class=\"list-paddingleft-2\">\n<li>\n<p>桌面端应用程序。</p>\n</li>\n<li>\n<p>移动设备。</p>\n</li>\n<li>\n<p>上千万的java开发人员。</p>\n</li>\n<li>\n<p>企业开发的首选开发语言。</p>\n</li>\n</ul>\n<p>正因为学java的人多，做java的人也多，所以人多的地方必然内卷啊，这是肯定的。毕竟java的应用面是很广泛的。</p>\n<p>java的分类：</p>\n<ul class=\"list-paddingleft-2\">\n<li>\n<p>J2SE / C# Winform（.net）</p>\n</li>\n<li>\n<p>早期是共存的，但是相对来说，做桌面应用，我们毕竟在pc机很多的情况下，那么市场占有率还是以C#为主，毕竟是微软亲儿子嘛，在windows上肯定更好。</p>\n</li>\n<li>\n<p>J2ME / Windows Mobile / ios&amp;Android</p>\n</li>\n<li>\n<p>相对来说，J2ME在一些移动设备上用的还是挺多的，windows mobile很不错，但是市场认可度不高，所以并没有完全推广开来，甚至很多人也许都没听过对吧？</p>\n</li>\n<li>\n<p>2008年ios开始流行，然后就是安卓，移动互联网大爆发，ios和安卓目前都是最流行的。</p>\n</li>\n<li>\n<p>J2EE / .Net</p>\n</li>\n<li>\n<p>后端开发语言中目前必定是以Java为主的，曾经有段时间其实还是有.Net开发的，现在几乎没了，而且市面上全大多数的公司，都是采用Java来进行开发的。因为Java的生态更完善啊，技术圈以及社区都很丰富啊。</p>\n</li>\n</ul>\n<p>越来越多的人选择java这个领域，而且薪资都还不错，非常可观。</p>\n<h3>Java路线（10min）</h3>\n<p><img class=\"\" src=\"https://img3.sycdn.imooc.com/61baa82400011b8212000609.jpg\" alt=\"https://img3.sycdn.imooc.com/61baa82400011b8212000609.jpg\" data-src=\"https://img3.sycdn.imooc.com/61baa82400011b8212000609.jpg\" data-original=\"https://img3.sycdn.imooc.com/61baa82400011b8212000609.jpg\" /></p>\n<p>image</p>\n<p>初级</p>\n<ul class=\"list-paddingleft-2\">\n<li>\n<p>java基础</p>\n</li>\n<li>\n<p>数据库，mysql，jdbc</p>\n</li>\n<li>\n<p>javaweb，servlet，filter，listener，session，cookie，http</p>\n</li>\n<li>\n<p>前端基础，html，css，js，建议学习</p>\n</li>\n<li>\n<p>常用框架，spring，springmvc，springboot，mybatis（plus），hibernate，jpa，maven分层聚合，git代码管理，ssm/ssb整合。</p>\n</li>\n</ul>\n<p><img class=\"\" src=\"https://img1.sycdn.imooc.com/61baa8250001e85712000702.jpg\" alt=\"https://img1.sycdn.imooc.com/61baa8250001e85712000702.jpg\" data-src=\"https://img1.sycdn.imooc.com/61baa8250001e85712000702.jpg\" data-original=\"https://img1.sycdn.imooc.com/61baa8250001e85712000702.jpg\" /></p>\n<p>image</p>\n<p>进阶：</p>\n<ul class=\"list-paddingleft-2\">\n<li>\n<p>Linux，centos7，要去学习一下，有的公司的调试会基于linux，所以基本的操作命令啊啥的你得会</p>\n</li>\n<li>\n<p>微服务，springcloud，springcloudAlibaba，redis</p>\n</li>\n<li>\n<p>权限管理：shiro，springsecurity，jwt</p>\n</li>\n<li>\n<p>项目实战：推荐我的短视频（初级）和自媒体实战（高级进阶），提一下薪资offer截图，基本上20k左右没问题的 到这里基本上工作没问题了</p>\n</li>\n</ul>\n<p>以上这些你都能在慕课网学习到。主要是一些实战课程。</p>\n<p><img class=\"\" src=\"https://img1.sycdn.imooc.com/61baa8250001b7bc12000638.jpg\" alt=\"https://img1.sycdn.imooc.com/61baa8250001b7bc12000638.jpg\" data-src=\"https://img1.sycdn.imooc.com/61baa8250001b7bc12000638.jpg\" data-original=\"https://img1.sycdn.imooc.com/61baa8250001b7bc12000638.jpg\" /></p>\n<p>image</p>\n<p>高级提升：</p>\n<ul class=\"list-paddingleft-2\">\n<li>\n<p>分布式，redis，elasticsearch，zookeeper，nginx，分布式文件存储，消息队列（rabbitmq，kafka，rocketmq），netty，mycat，sharding-jdbc，mongodb</p>\n</li>\n<li>\n<p>devops：docker，k8s，jenkins，ci/cd(持续基础，持续交付，持续部署)</p>\n</li>\n<li>\n<p>监控：zabbix，</p>\n</li>\n<li>\n<p>优化：JVM优化，数据库mysql优化，tomcat优化，open-restry</p>\n</li>\n<li>\n<p>云平台的搭建与设计：云服务器的购买选型，服务器实例、负载均衡SLB/CLB，弹性扩缩容，对象存储OSS，CDN内容分发网络，云中间件，集群搭建配置，安全防范等。</p>\n</li>\n<li>\n<p>推荐架构师一期，基本上25k-30k左右，目前最高的37k</p>\n</li>\n</ul>\n<h3>Java 薪资路线（10min）</h3>\n<p><img class=\"\" src=\"https://img1.sycdn.imooc.com/61baa82500016e1212000660.jpg\" alt=\"https://img1.sycdn.imooc.com/61baa82500016e1212000660.jpg\" data-src=\"https://img1.sycdn.imooc.com/61baa82500016e1212000660.jpg\" data-original=\"https://img1.sycdn.imooc.com/61baa82500016e1212000660.jpg\" /></p>\n<p>image</p>\n<ul class=\"list-paddingleft-2\">\n<li>\n<p>1-2年：技术积累期，积累经验，积累技术，10k-15K</p>\n</li>\n<li>\n<p>3-5年：薪资上涨期，通过积累的技术与项目经验，跳槽涨薪，幅度区间也比较大，20k-30k，达到35k以上的也有</p>\n</li>\n<li>\n<p>5年以上：</p>\n</li>\n<li>\n<p>平稳期（舒适圈）：35k-50k左右，学不进了，舒适，或者想作几年转行。这个大有人在，我身边的目前有转保险的，开滴滴的，开水果店的，开超市的，都有。我上次做曹操专车，那司机就是做前端的，32岁。</p>\n</li>\n<li>\n<p>卷之又卷：技术更深层次的提升，做业务，做事说话圆滑，多看多听，多拍马屁，最终往P8/P9进阶。基本上越往后，你要想升职，一定跟你做人做事情商等有关，技术再好，也不一定能升的上去。能上这个层次，基本上可以80k-100k。（在这里推荐一些我的项目管理课程）</p>\n</li>\n</ul>\n<p>其实java后端的薪资头两年是很低的，甚至有的城市达不到1万，基本上7-8k的样子，等你进阶了各种技术以后，那么你的薪资就会飞速提升了。</p>\n<h3>拓展技术，做<code>T</code>字型人才：（10min）</h3>\n<p><img class=\"\" src=\"https://img4.sycdn.imooc.com/61baa825000172b412000668.jpg\" alt=\"https://img4.sycdn.imooc.com/61baa825000172b412000668.jpg\" data-src=\"https://img4.sycdn.imooc.com/61baa825000172b412000668.jpg\" data-original=\"https://img4.sycdn.imooc.com/61baa825000172b412000668.jpg\" /></p>\n<p>image</p>\n<p>java为自己的主要技术领域，这个是直线。其他的分支技能，比如你要了解前端，其实最好学一下html，css，以及js。 此外别的平台比如小程序啊，安卓ios是怎么回事，了解一下，去看看，多好。毕竟如果你作为技术总监，这些你都不知道，那肯定不行，而且也不会升你的职位啊。</p>\n<p>其次运维方面的，很多小公司是没有运维的，如果你有这个经验，那不是更好吗？</p>\n<p>对大数据的了解，有的公司会有大数据职位，如果你是java，那么你的竞争力更好，进去了也容易转职。</p>\n<p>掌握多门开发语言，比如，go和python，这个是我比较推荐的，值得去学一学的。</p>\n<p>也就是说，你不要只局限于自己的技术领域，其他领域你都要去看看了解一下，这也是为以后奠定基础，因为你不可能一辈子做技术写代码的。</p>\n<h3>Java技能薪资水平汇总（资料可以加二维码提供）（上半场结束）</h3>\n<p>&nbsp;</p>\n<p>&nbsp;</p>\n<p>前面我们看的是职位以及相关的薪资水平，在这里，我附上薪资水平以及对应的招聘用人要求。主要是技术栈相关的。 这是一份PDF的文档，如果有需要的，可以公众号回复：JAVAPDF，就可以获得连接下载哈~</p>\n<p><img class=\"\" src=\"https://img3.sycdn.imooc.com/61baa8250001c6dd12000751.jpg\" alt=\"https://img3.sycdn.imooc.com/61baa8250001c6dd12000751.jpg\" data-src=\"https://img3.sycdn.imooc.com/61baa8250001c6dd12000751.jpg\" data-original=\"https://img3.sycdn.imooc.com/61baa8250001c6dd12000751.jpg\" /></p>\n<p>image</p>\n<h3>架构师</h3>\n<p><img class=\"\" src=\"https://img4.sycdn.imooc.com/61baa826000115cb12000607.jpg\" alt=\"https://img4.sycdn.imooc.com/61baa826000115cb12000607.jpg\" data-src=\"https://img4.sycdn.imooc.com/61baa826000115cb12000607.jpg\" data-original=\"https://img4.sycdn.imooc.com/61baa826000115cb12000607.jpg\" /></p>\n<p>image</p>\n<p>架构师是长啥样的？ 找图，风度翩翩的？ 还是邋里邋遢？其实生活中的架构师都有，我见过很帅的，也见过由头满面的，哈哈哈。</p>\n<p>&nbsp;</p>\n<p>&nbsp;</p>\n<p>架构师的定义：</p>\n<p><img class=\"\" src=\"https://img1.sycdn.imooc.com/61baa8260001446c12000664.jpg\" alt=\"https://img1.sycdn.imooc.com/61baa8260001446c12000664.jpg\" data-src=\"https://img1.sycdn.imooc.com/61baa8260001446c12000664.jpg\" data-original=\"https://img1.sycdn.imooc.com/61baa8260001446c12000664.jpg\" /></p>\n<p>image</p>\n<p>来，我们一起来给架构师定义一下，什么是架构师：</p>\n<ul class=\"list-paddingleft-2\">\n<li>\n<p>熟悉自身的技术领域</p>\n</li>\n<li>\n<p>比如：java技术领域，前端或go或大数据某个特定的技术领域</p>\n</li>\n<li>\n<p>运维领域（服务器怎么购买的，整个架构拓扑如何设计，怎么配置，这个你要和运维团队一起设计的）</p>\n</li>\n<li>\n<p>一定的测试领域（这个可以不要求，但是我见过有的架构师是从java转测试再转的架构师）</p>\n</li>\n<li>\n<p>一定的大数据领域（我以前的项目leader目前在美国，他就是在java领域以外，现在也是大数据架构师）</p>\n</li>\n<li>\n<p>除了自身的java技术栈，其他的可以不必精通，但是你要熟悉，至少也要了解把。要不然怎么上得了百万年薪呢？对吧</p>\n</li>\n<li>\n<p>其实这也是基于Java的T字形人才。</p>\n</li>\n</ul>\n<h4>架构师的类型：</h4>\n<p><img class=\"\" src=\"https://img2.sycdn.imooc.com/61baa8380001c14012000644.jpg\" alt=\"https://img2.sycdn.imooc.com/61baa8380001c14012000644.jpg\" data-src=\"https://img2.sycdn.imooc.com/61baa8380001c14012000644.jpg\" data-original=\"https://img2.sycdn.imooc.com/61baa8380001c14012000644.jpg\" /></p>\n<p>image</p>\n<p>不同领域的专家，他的定位也不一样，而且在有的大公司，架构师可以有专门的团队，根据职能可以如下划分：</p>\n<ul class=\"list-paddingleft-2\">\n<li>\n<p>技术架构师：以技术为导向的开发人员，java技术leader，技术经理，偏技术的架构师，统称为技术架构师，或者开发经理。</p>\n</li>\n<li>\n<p>薪资：差不多50w-60w</p>\n</li>\n<li>\n<p>业务架构师：以业务为导向的，负责业务设计，推动公司产品，推动战略规划的业务型人才，可以是从java开发转产品再转业务架构师，或者项目经理转过来的，都可以。</p>\n</li>\n<li>\n<p>薪资：60w-80w</p>\n</li>\n<li>\n<p>运维架构师：偏系统、网络和硬件，精通linux和网络。有的还会go语言或者Python，会构建基础平台，构建开发底层。很厉害</p>\n</li>\n<li>\n<p>薪资：40w-70w</p>\n</li>\n<li>\n<p>大数据架构师：java领域和大数据领域的精英，</p>\n</li>\n<li>\n<p>薪资：70w+</p>\n</li>\n</ul>\n<h4>架构师每天做些啥？</h4>\n<p><img class=\"\" src=\"https://img1.sycdn.imooc.com/61baa839000101bc12000644.jpg\" alt=\"https://img1.sycdn.imooc.com/61baa839000101bc12000644.jpg\" data-src=\"https://img1.sycdn.imooc.com/61baa839000101bc12000644.jpg\" data-original=\"https://img1.sycdn.imooc.com/61baa839000101bc12000644.jpg\" /></p>\n<p>image</p>\n<p>首先提出疑问，架构师还要写代码吗？ 觉得要写代码的请在公屏上敲1，觉得不要写代码的，请在敲2。 * 其实还是需要写一部分的代码，比如基础框架和架构，一些组件的脚手架，一些通用功能的基础封装，底层代码的修改与拓展。其他的更多的时间可以专注业务领域和解决方案。</p>\n<p>工作内容：</p>\n<ul class=\"list-paddingleft-2\">\n<li>\n<p>庖丁解牛：有强大的解耦拆分能力，把产品业务细分为能够落地的架构以及细分的功能点。</p>\n</li>\n<li>\n<p>技术选型：什么业务场景使用什么技术，用最适合的技术，而不是最牛的技术，去解决实际问题。比如消息队列的选择，rabbitmq，rocketmq，kafka，怎么选？用哪个？这的结合产品的业务。</p>\n</li>\n<li>\n<p>底层优化：当自己使用的框架无法满足项目需求，是不是要优化底层，是不是要做底层的相关开发呀~ 想我没自己的，jvm和jms都是经过一些重构的，加入了我们的自己编写的一部分代码。</p>\n</li>\n<li>\n<p>文档能力：会写word/ppt，要写的漂亮，因为有的公司会时不时要你汇报，你能做的好看，哪怕吹牛逼，那你也厉害啊，领导喜欢你啊。正所谓PPT架构师嘛。当然会吹牛也是本领，一般人都实实在在的老实人。</p>\n</li>\n<li>\n<p>做事圆滑：情商高，见人说人话，见鬼说鬼话，两面三刀，我见过这样的人，我一个朋友就是这么混到高层的，以前也是做java的，但是会拍马屁啊，会战队啊，有时候当着面夸你，背后捅你一刀，有的人的确是这么爬上去的，但是，尽量不要做损人的事。</p>\n</li>\n<li>\n<p>项目管理：因为你是架构师了，你不再是一个人，你要考团队的，所以基本的团队管理，软技能，你得会，我就举个例子，如果你是架构师，你看到你的组员在上班时间玩手机，你该怎么处理？你要不要处理？你如何用巧妙的方式去说，还是让别的同事去说？所以你要往上爬，项目管理的各种方方面面的都需要学习一下，比如你可以看老师的项目管理实战，也不错，比价便宜，可以购买，并且我还赠书~</p>\n</li>\n<li>\n<p>另外说一下，现在很少有那种纯管理的岗位，如果有，一般也是空降的，而且职位很高。如果你又懂技术又懂管理，这个是最好的，也是最万金油的，企业也更青睐。</p>\n</li>\n</ul>\n<h4>架构师的必备技能</h4>\n<p><img class=\"\" src=\"https://img4.sycdn.imooc.com/61baa83a0001b21212000644.jpg\" alt=\"https://img4.sycdn.imooc.com/61baa83a0001b21212000644.jpg\" data-src=\"https://img4.sycdn.imooc.com/61baa83a0001b21212000644.jpg\" data-original=\"https://img4.sycdn.imooc.com/61baa83a0001b21212000644.jpg\" /></p>\n<p>image</p>\n<p>内功心法：</p>\n<ul class=\"list-paddingleft-2\">\n<li>\n<p>算法</p>\n</li>\n<li>\n<p>设计模式</p>\n</li>\n<li>\n<p>数据结构</p>\n</li>\n<li>\n<p>网络通信</p>\n</li>\n<li>\n<p>操作系统</p>\n</li>\n<li>\n<p>JVM底层</p>\n</li>\n</ul>\n<p>框架源码：</p>\n<ul class=\"list-paddingleft-2\">\n<li>\n<p>java集合</p>\n</li>\n<li>\n<p>Spring（一定要看）</p>\n</li>\n<li>\n<p>SpringBoot/MVC</p>\n</li>\n<li>\n<p>SpringCloud</p>\n</li>\n<li>\n<p>Zookeeper/Dubbo</p>\n</li>\n<li>\n<p>Mybatis</p>\n</li>\n<li>\n<p>Netty</p>\n</li>\n<li>\n<p>Tomcat(通过源码可以去优化)</p>\n</li>\n</ul>\n<p><br />作者：风间影月<br />链接：https://www.imooc.com/article/322424<br />来源：慕课网</p>', 'http://hire.t.mukewang.com/static/photo/article/cover/3b1f102e-06a0-4f01-9480-0f25fc3953d9.png', '1001', '2022-08-19 11:45:32', 'admin', 'http://hire.t.mukewang.com/static/adminFace/644842e3-0173-42c0-a7a9-abdba09c358b.png', 1, '2022-08-19 11:45:59', '2022-08-19 11:46:09');
INSERT INTO `article` VALUES ('1560473516104077314', '程序员35以后，你也可以成为职业经理人~', '<div class=\"cl-preview-section\">\n<p>在如今的中国职场，尤其是在互联网行业，很多公司&ldquo;歧视35岁&rdquo;，已经成了一件非常正常的事了，司空见惯。都35岁了，还没有进入到管理层，就会成为很多公司的&ldquo;吊车尾&rdquo;。<br /><img class=\"lazyload\" src=\"data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAAEAAAABCAYAAAAfFcSJAAAAAXNSR0IArs4c6QAAAARnQU1BAACxjwv8YQUAAAAJcEhZcwAADsQAAA7EAZUrDhsAAAANSURBVBhXYzh8+PB/AAffA0nNPuCLAAAAAElFTkSuQmCC\" alt=\"-w1742\" data-original=\"https://lee-blog.oss-cn-shanghai.aliyuncs.com/2021/05/11/16207037242362.jpg\" /></p>\n</div>\n<div class=\"cl-preview-section\">\n<p>各大互联网公司从2019年至今，已经裁员很多了，不满35还处于技术基层岗位的，一并裁员：</p>\n</div>\n<div class=\"cl-preview-section\">\n<blockquote>\n<p>滴滴裁员2000人，<br />腾讯裁员35岁以上非高层人员，<br />苏宁裁员程序员70%（转外包），<br />摩拜裁员30%，<br />甲骨文中国裁员将近900多人，<br />网易裁员30%-40%，<br />人人车裁员上千人<br />&hellip;</p>\n</blockquote>\n</div>\n<div class=\"cl-preview-section\">\n<p>这一波又一波的裁员信息，想必任何人看到都会非常焦虑吧。</p>\n</div>\n<div class=\"cl-preview-section\">\n<p>据统计，21-25岁的程序员占比45%左右，31-40岁程序员占比10%甚至更少，40岁以上1%不到。看到这则信息，你对以后的技术路线应该怎么考虑呢？<br /><img class=\"lazyload\" src=\"data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAAEAAAABCAYAAAAfFcSJAAAAAXNSR0IArs4c6QAAAARnQU1BAACxjwv8YQUAAAAJcEhZcwAADsQAAA7EAZUrDhsAAAANSURBVBhXYzh8+PB/AAffA0nNPuCLAAAAAElFTkSuQmCC\" alt=\"-w1195\" data-original=\"https://lee-blog.oss-cn-shanghai.aliyuncs.com/2021/05/11/16207037578305.jpg\" /></p>\n</div>\n<div class=\"cl-preview-section\">\n<p>所以，很多人应该要好好想一想，人到中年应该怎么办？你应该如何去保证自己，保证家庭的生活水平，延迟自己的职业生涯自己的饭碗，这是非常重要的一件事。主流的三条路，可以去选择：</p>\n</div>\n<div class=\"cl-preview-section\">\n<ul>\n<li>35的时候转国企，转机关转事业单位，虽然工资不高，但是非常稳定，但是前提是你要有好的学历。这也是为的你能在40以后50以后有一个保障。</li>\n<li>做技术的，说真的，绝大多数，从初入职场到35，一致埋头干技术，其实已经被淘汰了，每天面对的是电脑，没有自己的圈子，没有人脉，除了极少数人才能在技术路线走到底，他们持有工匠精神，越做越吃香，但这是极少数的技术路线。</li>\n<li>成为整合者，如果说35之前你是做技术的，也就是内容生产者，到如今，你应该知道应该能够面对大部分的资源，进行整合，你得知道什么场景下应该能够做什么，怎么做能成功，能够依靠身边的资源进行整合，能够搞出点名堂来，如此从内容生产者成为资源整合者，那么就是有能力去成为一名经理人。<br />这3个选择，其实绝大多数人，应该走第三条了，转管理，成为资源整合者，做管理可以延长职业生命生涯，而且做了管理以后会拥有各种各方的资源，你会面对非常多的机遇和机会，对于你以后的创业也是非常有帮助的。<br /><img class=\"lazyload\" src=\"data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAAEAAAABCAYAAAAfFcSJAAAAAXNSR0IArs4c6QAAAARnQU1BAACxjwv8YQUAAAAJcEhZcwAADsQAAA7EAZUrDhsAAAANSURBVBhXYzh8+PB/AAffA0nNPuCLAAAAAElFTkSuQmCC\" alt=\"-w953\" data-original=\"https://lee-blog.oss-cn-shanghai.aliyuncs.com/2021/05/11/16207038016363.jpg\" /></li>\n</ul>\n</div>\n<div class=\"cl-preview-section\">\n<p>那么其实呢</p>\n</div>\n<div class=\"cl-preview-section\">\n<ul>\n<li>在职场中越往上走，拼得越不是技术，而是能力。</li>\n<li>项目管理是每个人所应该有的综合能力，这也是各类企业的核心竞争力。能力越高，收入也就越高。</li>\n<li>2027年，项目管理职位空缺到达8000多万。</li>\n<li>项目经理在各行各业都能游刃有余，可以高效的进行资源整合，实现最终目标。</li>\n<li>万事皆项目，灵活运用项目管理知识，更好的管理自我、管理生活、管理时间。</li>\n</ul>\n</div>\n<div class=\"cl-preview-section\">\n<p><img class=\"lazyload\" src=\"data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAAEAAAABCAYAAAAfFcSJAAAAAXNSR0IArs4c6QAAAARnQU1BAACxjwv8YQUAAAAJcEhZcwAADsQAAA7EAZUrDhsAAAANSURBVBhXYzh8+PB/AAffA0nNPuCLAAAAAElFTkSuQmCC\" alt=\"-w950\" data-original=\"https://lee-blog.oss-cn-shanghai.aliyuncs.com/2021/05/11/16207038182611.jpg\" /></p>\n</div>\n<div class=\"cl-preview-section\">\n<p>很多人都说要年薪百万，那么到底你离年薪100万有多远呢？ 做技术到100万，有，但是很少很难。做项目经理后。随着天花板的提高，可能你的收入会上升至40到50万，甚至再多一些。当你的视野更加宽阔，为公司、为团队、为项目、付出贡献的更多的时候，你将会成为职业经理人，也就是公司的中高层，中高管。年薪会在100万以上。所以项目管理完全值得你来学习，完全指的你去转型。<br /><img class=\"lazyload\" src=\"data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAAEAAAABCAYAAAAfFcSJAAAAAXNSR0IArs4c6QAAAARnQU1BAACxjwv8YQUAAAAJcEhZcwAADsQAAA7EAZUrDhsAAAANSURBVBhXYzh8+PB/AAffA0nNPuCLAAAAAElFTkSuQmCC\" alt=\"-w1706\" data-original=\"https://lee-blog.oss-cn-shanghai.aliyuncs.com/2021/05/11/16207038373605.jpg\" /></p>\n</div>\n<div class=\"cl-preview-section\">\n<p>其实所以啊，技术转管理，已经是我们买过35门槛的首要任务啦~ 我们做任何职业都要提前规划，提前布局，围绕项目并且成为项目型人才，而并不是到了35岁，你才开始考虑的，要不然你会相当焦虑，那么在这里呢，老师最近新推出了一门项目管理课程，非常的入门，简单易懂，课程中会讲述<code>整合</code>、<code>范围</code>、<code>进度</code>、<code>成本</code>、<code>质量</code>、<code>沟通</code>、<code>干系人</code>、<code>团队</code>、<code>风险</code>、<code>采购</code>等相关内容。</p>\n</div>\n<div class=\"cl-preview-section\">\n<p>此外我们还有电子书以及项目管理文档和模板，都是课程中的输出噢，大家也能参考~<br /><img class=\"lazyload\" src=\"data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAAEAAAABCAYAAAAfFcSJAAAAAXNSR0IArs4c6QAAAARnQU1BAACxjwv8YQUAAAAJcEhZcwAADsQAAA7EAZUrDhsAAAANSURBVBhXYzh8+PB/AAffA0nNPuCLAAAAAElFTkSuQmCC\" alt=\"-w358\" data-original=\"https://lee-blog.oss-cn-shanghai.aliyuncs.com/2021/05/11/16207011581593.jpg\" /></p>\n</div>\n<div class=\"cl-preview-section\">\n<p>当然最后了，一旦你开始转型，你的职业规划会更加明确，可以参考如下图，这个在课程中也是有详细说明的哦~<br /><img class=\"\" src=\"https://img1.sycdn.imooc.com/609a7bb2000194d235002056.jpg\" alt=\"-w1750\" data-original=\"https://img1.sycdn.imooc.com/609a7bb2000194d235002056.jpg\" /></p>\n</div>\n<div class=\"cl-preview-section\">\n<p>所以，每一个想从技术转型项目管理的你，都应该尽早开始规划项目管理。详细内容请访问&nbsp;<a href=\"https://coding.imooc.com/class/476.html\">https://coding.imooc.com/class/476.html</a>&nbsp;另外小伙伴们记得进群参与赠书活动噢~</p>\n</div>\n<p><br />作者：风间影月<br />链接：https://www.imooc.com/article/317492<br />来源：慕课网</p>', 'http://hire.t.mukewang.com/static/photo/article/cover/ba9c9dea-8bb6-47c8-9e81-bc0931c54761.png', '1001', '2022-08-19 11:46:53', 'admin', 'http://hire.t.mukewang.com/static/adminFace/644842e3-0173-42c0-a7a9-abdba09c358b.png', 1, '2022-08-19 11:47:33', '2022-08-19 11:47:43');
INSERT INTO `article` VALUES ('1560473770853519362', 'Redis6直播笔记 - 下（多线程/哈希slot/集群）', '<div class=\"cl-preview-section\">\n<h3>io多线程</h3>\n<p>以前的redis是单线程模型，其实就是多路复用机制，知道多路复用的来一波6，我们在架构师课程中讲过，那么netty也有，看过老师相关课程的也应该知道。这里不多说了。</p>\n<p>Redis6开始有了IO读写多线程，只不过执行用户的命令和早期版本也是一样的，都是单线程执行，所以线程安全。</p>\n<p>我们先来看一下老版本的单线程：<br /><img class=\"\" src=\"https://img4.sycdn.imooc.com/601223ba0001d25835001570.jpg\" alt=\"https://img4.sycdn.imooc.com/601223ba0001d25835001570.jpg\" data-src=\"https://img4.sycdn.imooc.com/601223ba0001d25835001570.jpg\" data-original=\"https://img4.sycdn.imooc.com/601223ba0001d25835001570.jpg\" /></p>\n<p>首先读取客户端的命令，读取后执行命令，然后回写给客户端，这个就是一组命令的执行，由于单线程安全，他们会一组一组的去进行执行。</p>\n<p>他们的读写命令以及执行命令都是在一个线程中执行的，这个线程在redis6中称之为主线程。</p>\n<p>在这里我们可以回顾一下netty的reactor的线程模型，也就是多路复用。<br /><img class=\"\" src=\"https://img1.sycdn.imooc.com/601223bc0001574d30101708.jpg\" alt=\"https://img1.sycdn.imooc.com/601223bc0001574d30101708.jpg\" data-src=\"https://img1.sycdn.imooc.com/601223bc0001574d30101708.jpg\" data-original=\"https://img1.sycdn.imooc.com/601223bc0001574d30101708.jpg\" /><br />你可以把这个单线程理解为是一个人，他是酒吧会所的接待员，在门口接待了以后，然后还要领到里面去一个一个的招待他们。</p>\n<p>我们可以打开redis.conf配置文件，看一下：<br /><img class=\"\" src=\"https://img4.sycdn.imooc.com/601223bd00015f0a24321108.jpg\" alt=\"https://img4.sycdn.imooc.com/601223bd00015f0a24321108.jpg\" data-src=\"https://img4.sycdn.imooc.com/601223bd00015f0a24321108.jpg\" data-original=\"https://img4.sycdn.imooc.com/601223bd00015f0a24321108.jpg\" /><br />默认情况下，是按照老版本的样子，如果要使用多线程，那么开启即可，这里的<code>io-threads</code>就是设置多线程的数量，开启多线程后，整体的性能要比单线程要更高。</p>\n<p><code>io-threads</code>设置的数量最大不建议超过8，提升的空间不大。另外线程数和服务器的硬件配置也是有关系的。比如4核8g，那么建议设置2或者3，如果8核建议设置6或者7，因为一定要预留，万事兜底万事保底，这一点和nginx的配置也是同样的道理。</p>\n<p>假设现在<code>io-threads</code>设置为4，那么他的模型就如下：<br /><img class=\"\" src=\"https://img1.sycdn.imooc.com/601223be0001171626781696.jpg\" alt=\"https://img1.sycdn.imooc.com/601223be0001171626781696.jpg\" data-src=\"https://img1.sycdn.imooc.com/601223be0001171626781696.jpg\" data-original=\"https://img1.sycdn.imooc.com/601223be0001171626781696.jpg\" /></p>\n<p>那么在这里，读用户的命令以及执行命令都是在一个线程中执行的，然后写操作是多线程执行。在这里如果比作是一个银行的话，那么<code>读操作</code>相当于是门口的保安，给你测个体温，<code>执行</code>就是店里的大堂经理，会带你去取号，多个<code>写操作</code>就是窗口的办事人员。</p>\n<p>可以参考一下图：<br /><img class=\"\" src=\"https://img1.sycdn.imooc.com/601223bf00018b9a34081708.jpg\" alt=\"https://img1.sycdn.imooc.com/601223bf00018b9a34081708.jpg\" data-src=\"https://img1.sycdn.imooc.com/601223bf00018b9a34081708.jpg\" data-original=\"https://img1.sycdn.imooc.com/601223bf00018b9a34081708.jpg\" /><br />刚刚我们举例是只有一个人在接待和招待，这个时候接待只有一个人，他只在门口把客人带进里面，里面会有专门的多个招待员来处理这些客人的请求。</p>\n<h3>读操作能不能设置多线程呢？</h3>\n<p><img class=\"\" src=\"https://img4.sycdn.imooc.com/601223c000010dfa21440974.jpg\" alt=\"https://img4.sycdn.imooc.com/601223c000010dfa21440974.jpg\" data-src=\"https://img4.sycdn.imooc.com/601223c000010dfa21440974.jpg\" data-original=\"https://img4.sycdn.imooc.com/601223c000010dfa21440974.jpg\" /><br />如果想要读操作也编程多线程读的话，那么<code>io-threads-do-reads</code>可以开启，设置为yes就行。这个时候他的模型就是下面这张图：<br /><img class=\"\" src=\"https://img1.sycdn.imooc.com/601223c10001fa8526541744.jpg\" alt=\"https://img1.sycdn.imooc.com/601223c10001fa8526541744.jpg\" data-src=\"https://img1.sycdn.imooc.com/601223c10001fa8526541744.jpg\" data-original=\"https://img1.sycdn.imooc.com/601223c10001fa8526541744.jpg\" /></p>\n<p>只不过官方说明，这个多线程读开启的意义不大，不会帮助很多的。<br /><img class=\"\" src=\"https://img3.sycdn.imooc.com/601223c2000199f833441688.jpg\" alt=\"https://img3.sycdn.imooc.com/601223c2000199f833441688.jpg\" data-src=\"https://img3.sycdn.imooc.com/601223c2000199f833441688.jpg\" data-original=\"https://img3.sycdn.imooc.com/601223c2000199f833441688.jpg\" /><br />这个时候，还是引入刚刚的例子，客人多了，生意好了，门口的接待员增加了，那么两边接待和招待都是多个员工在处理客人了。</p>\n<p>那么在这里说明一点，多线程只针对数据的读写以及协议的解析。真正用户端的命令执行还是单线程，所以是线程安全的。</p>\n<h3>Redis集群原理</h3>\n<p><img class=\"\" src=\"https://img4.sycdn.imooc.com/601223c300017bbf26541376.jpg\" alt=\"https://img4.sycdn.imooc.com/601223c300017bbf26541376.jpg\" data-src=\"https://img4.sycdn.imooc.com/601223c300017bbf26541376.jpg\" data-original=\"https://img4.sycdn.imooc.com/601223c300017bbf26541376.jpg\" /></p>\n<p>其实只要涉及到中间件，那么必定会有集群的概念，一方面为了高可用，一方面为了达到水平扩容，那么这次来讲一下redis的集群。</p>\n<p>其实在很早以前，早期的redis版本是没有集群这个概念的，你需要实现集群得依靠一些中间件，比如codis，还有twemproxy。redis集群概念是在3.0开始引入的，它是自带的分布式存储方案，是一个去中心化的集群，叫做Redis Cluster，是由多个主从节点共同存在的一个模式，一般以3主3从为比较经典的模式，当然多主多从也可以。其中master负责读写请求以及整个集群信息的维护，slave只做他所对应的主节点数据和状态信息的复制。</p>\n<h3>Redis Cluster</h3>\n<p>关于集群，有两点需要注意</p>\n<ul class=\"list-paddingleft-2\">\n<li>\n<p>之前我们聊过主从模式，可以做读写分离，redis集群虽然是3主3从，也有主从的概念，但是我们并不会做读写分离，读写都是交给master去处理，数据会同步给slave，如果集群做读写分离一方面没有意义一方面slave就没有容错机制了，这一点是需要注意。</p>\n</li>\n<li>\n<p>此外还有一点，单节点的redis默认有16个db，但是在集群模式下，这些db都融合了，没有db库的概念，他是一片汪洋大海。</p>\n</li>\n</ul>\n<p>按照单节点，主从，哨兵来说的话，redis始终都可以说是单库，数据存储量是有上限的，你的服务器节点内存有多大，那么这个就是存储上限。一旦到达存储上限，redis就会进行缓存key的自我淘汰机制。很明显，这种方式面对海量数据的时候并不太好，哪怕你买1个t内存的，也总有一天会到达存储瓶颈，所以任何分布式系统我们都要考虑一个水平扩容机制，这个redis集群就可以做到。扩容的同时也满足高可用机制。</p>\n<p>同时，使用集群之后，数据其实进行了分片，多个master节点都能够提供读写服务，这样整体集群的响应能力就要比原先单节点来的更好。并且，在集群模式下，任意节点发生故障时，集群还是可以继续对外提供服务，主节点有故障转移的功能。</p>\n<h3>传统的水平扩容</h3>\n<p>传统早期的redis扩容方案其实是基于业务层的，在业务层进行redis的分割，可以扩容，可以集群隔离。<br />我们之前讲过redis主从，以这个为例，当然用哨兵也可以，我们可以手动来实现redis的扩容，先看下图：<br /><img class=\"\" src=\"https://img3.sycdn.imooc.com/601223c400014bfb34241638.jpg\" alt=\"https://img3.sycdn.imooc.com/601223c400014bfb34241638.jpg\" data-src=\"https://img3.sycdn.imooc.com/601223c400014bfb34241638.jpg\" data-original=\"https://img3.sycdn.imooc.com/601223c400014bfb34241638.jpg\" /></p>\n<p>上图中的3主3从其实是由3个主从redis构成的，用户在进行set或者get的时候，首先需要对key做哈希，哈希后的值对节点数求模，取模的值就是数据路由到某个主从库里，就针对这个主从库去做set和get的操作，这个哈希原理其实和nginx的ip_hash道理是一样的，数据库分库也是这个道理。目的就是根据key哈希后的结果去寻址找到最终他的存储位置去存值或取值。这个其实就是<code>哈希取模</code>。</p>\n<p>那么哈希以及寻址的这个过程需要自己在业务层去封装实现，但是本质目的就已经达到了横向扩容，假设每个主从容量是8g，那么目前总容量就是24g，想怎么扩容直接加机器就行。<br /><img class=\"lazyload\" src=\"data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAAEAAAABCAYAAAAfFcSJAAAAAXNSR0IArs4c6QAAAARnQU1BAACxjwv8YQUAAAAJcEhZcwAADsQAAA7EAZUrDhsAAAANSURBVBhXYzh8+PB/AAffA0nNPuCLAAAAAElFTkSuQmCC\" alt=\"-w569\" data-original=\"https://lee-blog.oss-cn-shanghai.aliyuncs.com/2021/01/28/16111988959530.jpg\" /></p>\n<p>这这样的情况之下，那么扩容会代理一个弊端，这个弊端也就是哈希取模带来的，一旦有节点宕机或者增加节点，那么就需要重新哈希和求模运算，这么一来会影响所有的缓存数据，这个时候所有数据会重新路由，影响会很大，怎么解决呢？可以使用一致性哈希算法，就是小部分数据受影响，这个我们在架构班里有提到过的吧。</p>\n<h3>一致性哈希</h3>\n<p><img class=\"lazyload\" src=\"data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAAEAAAABCAYAAAAfFcSJAAAAAXNSR0IArs4c6QAAAARnQU1BAACxjwv8YQUAAAAJcEhZcwAADsQAAA7EAZUrDhsAAAANSURBVBhXYzh8+PB/AAffA0nNPuCLAAAAAElFTkSuQmCC\" alt=\"-w1620\" data-original=\"https://lee-blog.oss-cn-shanghai.aliyuncs.com/2021/01/28/16111992598172.jpg\" /><br />首先他会有一个域，这个域很长，有2的32次方减1，哈希不仅针对key，也会针对服务器节点，我们这里是redis，如果是服务器集群那么道理也是一样。<br /><img class=\"lazyload\" src=\"data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAAEAAAABCAYAAAAfFcSJAAAAAXNSR0IArs4c6QAAAARnQU1BAACxjwv8YQUAAAAJcEhZcwAADsQAAA7EAZUrDhsAAAANSURBVBhXYzh8+PB/AAffA0nNPuCLAAAAAElFTkSuQmCC\" alt=\"-w1736\" data-original=\"https://lee-blog.oss-cn-shanghai.aliyuncs.com/2021/01/28/16111993460724.jpg\" /></p>\n<h3>Redis集群 - hash slot 算法</h3>\n<p>上面的传统方式是很古老的，我曾经也见识过一次，我们了解一下就行了。现在都使用redis cluster，这种模式下，redis可以有多个master节点，每个master节点下又可以对应1~n个slave节点，这样会形成一个多主多从的集群模式，这种模式下不再需要向上面讲过的那样需要在业务层去处理，redis自身帮我们做好了存取的过程，我们可以不用过多关注业务过程就可以直接使用和应用了。他自身是基于hash slot的算法来存值的，不论是哪种算法，其实本质为了解决的就是数据分布的问题。</p>\n<p>redis集群其实是把数据分片了，由于他有多个master共同构成，他会分数据，他有一个hash slot算法，也可以称之为哈希槽，每个槽上存放了一些数据，slot的范围是0~16384，redis对key的存取会有一个CRC16的算法，得到的值，在对16384做取模，最终判断该key应该在哪个slot中进行存取，本质和服务器节点数取模是一样的，只不过redis cluster的slot算法更精妙，成本更低廉。</p>\n<p>以三主三从为例，这个时候的slot总数会平均等份，使得每个master节点中都会有slot，目前3个的话那就是{0..5461}{5462..10922}{10923..16383}，这个取值区间在搭建好集群之后是可以看到的。</p>\n<p>如果这个时候，集群环境增加或者减少节点，slot可以重新迁移或者合并，那么slot中的缓存key其实还是存在的，如此一来，节点宕机或者新增就不会造成缓存丢失了。这就相当于家里房子拆迁，我到新家里以后，会把我的私人物品家具啊电器啊一起携带过去，东西跟着人走，东西就是缓存key，人就slot，服务器节点是redis实例，比较灵活。并不是说你房子没了，家里的东西就没了。<br /><img class=\"lazyload\" src=\"data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAAEAAAABCAYAAAAfFcSJAAAAAXNSR0IArs4c6QAAAARnQU1BAACxjwv8YQUAAAAJcEhZcwAADsQAAA7EAZUrDhsAAAANSURBVBhXYzh8+PB/AAffA0nNPuCLAAAAAElFTkSuQmCC\" alt=\"-w1671\" data-original=\"https://lee-blog.oss-cn-shanghai.aliyuncs.com/2021/01/28/16112001620017.jpg\" /><br />提问：搬家的过程，新家能住人吗？<br />当然，你搬家并不是马上就能完成的，搬家需要耗时，需要等待，所以等待期间你的家具啊电器啊不可用。redis slot也是这样，宕机的时候，那部分需要迁移的slot是不可用，会有一个短暂的迁移的过程，等待迁移完成之后，才能为用户提供读写服务。</p>\n<p>hash slot 图示：<br /><img class=\"lazyload\" src=\"data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAAEAAAABCAYAAAAfFcSJAAAAAXNSR0IArs4c6QAAAARnQU1BAACxjwv8YQUAAAAJcEhZcwAADsQAAA7EAZUrDhsAAAANSURBVBhXYzh8+PB/AAffA0nNPuCLAAAAAElFTkSuQmCC\" alt=\"\" data-original=\"https://lee-blog.oss-cn-shanghai.aliyuncs.com/2021/01/28/15919361461695.jpg\" /></p>\n<p>如下图：中间的master宕机了，slot会迁移到slave<br /><img class=\"lazyload\" src=\"data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAAEAAAABCAYAAAAfFcSJAAAAAXNSR0IArs4c6QAAAARnQU1BAACxjwv8YQUAAAAJcEhZcwAADsQAAA7EAZUrDhsAAAANSURBVBhXYzh8+PB/AAffA0nNPuCLAAAAAElFTkSuQmCC\" alt=\"-w1054\" data-original=\"https://lee-blog.oss-cn-shanghai.aliyuncs.com/2021/01/28/15927828746019.jpg\" /></p>\n<p>如果，新增master节点，重新分配，那么会把一些slot迁移过去，缓存数据不变，跟着slot走，虽然slot会变动到其他的master节点，但是数据key哈希的时候，还是会到跟着固定的slot。</p>\n<h3>格子铺</h3>\n<p>如果还不能理解，那就再举个栗子，格子铺，每个格子归属一个卖家，这个卖家把各自托管给某些商铺，由他们代运营，如果商铺倒闭，格子还是存在的，他可以把各自带着走，各自里的商品就是redis集群中的数据呀，它是不会发生更改的，只是外壳换了一家商铺而已。</p>\n<h3>Redis集群搭建</h3>\n<p>时间关系，我们在这里就只讲原理了，操作部分，我们提供了慕课网的手记文档，很简单，大家可以去看一下就行。<br />链接地址：<a href=\"https://www.imooc.com/article/313301\">https://www.imooc.com/article/313301</a></p>\n<p>只不过在集群中有一些注意点，我们大致总结了如下：</p>\n<ol class=\"list-paddingleft-2\">\n<li>\n<p>读写都是在master，slave加入集群，会进行数据同步，连接集群中的任意主或从节点去读写数据，都会根据key哈希取模后路由到某个master节点去处理。slave不提供读写服务，只会同步数据。</p>\n</li>\n<li>\n<p>关闭任意一主，会导致部分写操作失败，是由于从节点不能执行写操作，在Slave升级为Master期间可能会有少量的失败。</p>\n</li>\n<li>\n<p>关闭从节点对于整个集群没有影响</p>\n</li>\n<li>\n<p>某个主节点和他麾下的所有从节点全部挂掉，我们集群就进入faill状态，不可用。因为slot不完整。</p>\n</li>\n<li>\n<p>如果集群超过半数以上master挂掉，无论他们是否有对应slave，集群进入fail状态，因为无法选举。</p>\n</li>\n<li>\n<p>如果集群中的任意master宕机，且此master没有slave。集群不可用。（同3）</p>\n</li>\n<li>\n<p>投票选举过程是集群中所有master参与，如果半数以上master节点与master节点通信超时(cluster-node-timeout)，认为当前master节点挂掉。</p>\n</li>\n<li>\n<p>选举只会针对某个master下的所有slave选举，而不是对所有全量的slave选举。</p>\n</li>\n<li>\n<p>原先的master重新恢复连接后，他会成为新master的从服务器。由于主从同步，客户端的写入命令，有可能会丢失。redis并非强一致性，由于主从特性，所以最后一部分数据会丢失。这也符合CAP理论。</p>\n</li>\n<li>\n<p>集群只实现了主节点的故障转移；从节点故障时只会被下线，不会进行故障转移。因此，使用集群时，一般不会使用读写分离技术，因为从节点故障会导致读服务不可用，可用性变差了。所以不要在集群里做读写分离。</p>\n</li>\n</ol>\n<p>需要注意，为了保证集群的完整性，只有当16384个槽slot完全的全部分配完毕，集群才可以上线。而且，如果主节点发生故障转移，并且处于故障转移过程中还未完成时，原主节点的槽slot不会在任何节点中，集群会处于下线状态，客户端无法调用。CAP原理。</p>\n<h3>Redis集群数据迁移</h3>\n<h3>已有数据的单节点的redis如何扩展为集群</h3>\n<p>搭建集群的时候，包清除节点中现有的aof以及rdb文件，那么如果现在本来就是单节点，那么如何扩展为集群呢？并且要保证数据不丢失。其实原理就是把rdb或者aof文件保存以后，再导入，然后通过slot来分配。具体步骤如下：<br /><img class=\"lazyload\" src=\"data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAAEAAAABCAYAAAAfFcSJAAAAAXNSR0IArs4c6QAAAARnQU1BAACxjwv8YQUAAAAJcEhZcwAADsQAAA7EAZUrDhsAAAANSURBVBhXYzh8+PB/AAffA0nNPuCLAAAAAElFTkSuQmCC\" alt=\"-w1098\" data-original=\"https://lee-blog.oss-cn-shanghai.aliyuncs.com/2021/01/28/15936963330711.jpg\" /><br />如上图，其原理就是slot迁移。整个过程阻塞，网站服务不对外提供服务。如果使用自建集群，那么运维成本很高，一般采用云redis的话会更好。哪怕阿里云，也会在配置变更的时候出现网络中断的情况。</p>\n<p><br />作者：风间影月<br />链接：https://www.imooc.com/article/314805<br />来源：慕课网</p>\n</div>', 'http://hire.t.mukewang.com/static/photo/article/cover/f7ac7eeb-d0dc-4359-812a-e0b53a251c22.png', '1001', '2022-08-19 11:48:13', 'admin', 'http://hire.t.mukewang.com/static/adminFace/644842e3-0173-42c0-a7a9-abdba09c358b.png', 1, '2022-08-19 11:48:34', '2022-08-19 11:48:44');
INSERT INTO `article` VALUES ('1560473936503361538', 'Redis6直播笔记 - 上（acl/客户端缓存/多级缓存）', '<div class=\"cl-preview-section\">\n<p><img class=\"\" src=\"https://img4.sycdn.imooc.com/6010e46c000122f228141262.jpg\" alt=\"https://img4.sycdn.imooc.com/6010e46c000122f228141262.jpg\" data-src=\"https://img4.sycdn.imooc.com/6010e46c000122f228141262.jpg\" data-original=\"https://img4.sycdn.imooc.com/6010e46c000122f228141262.jpg\" /></p>\n<h3>redis6安装注意点</h3>\n<p><img class=\"\" src=\"https://img3.sycdn.imooc.com/6010e46e00015d0c28501130.jpg\" alt=\"https://img3.sycdn.imooc.com/6010e46e00015d0c28501130.jpg\" data-src=\"https://img3.sycdn.imooc.com/6010e46e00015d0c28501130.jpg\" data-original=\"https://img3.sycdn.imooc.com/6010e46e00015d0c28501130.jpg\" /></p>\n<p>我们课程里忽略了，就不去安装了，仅仅只提供安装文档，redis6的安装其实和redis5安装差不多，只是需要注意gcc的版本需要提高，不然编译会出错。<br />参考慕课网手记地址：<a href=\"https://www.imooc.com/article/313200\">https://www.imooc.com/article/313200</a></p>\n<h3>acl权限策略</h3>\n<h4>基础概念</h4>\n<p><img class=\"\" src=\"https://img1.sycdn.imooc.com/6010e46f0001ad6928561530.jpg\" alt=\"https://img1.sycdn.imooc.com/6010e46f0001ad6928561530.jpg\" data-src=\"https://img1.sycdn.imooc.com/6010e46f0001ad6928561530.jpg\" data-original=\"https://img1.sycdn.imooc.com/6010e46f0001ad6928561530.jpg\" /></p>\n<p>不知道大家有没有听过acl，zookeeper中也有，acl就是access control list，权限控制列表，和平时接触的管理系统的权限是一样的，可以限制不同角色的操作权。</p>\n<p>在redis6中，我们可以设置不同的用户，对他们进行授权命令，控制可读可写，限制访问缓存key的前缀等。这样可以更加提高redis6的数据安全性。由于是对于一些公司的生产库，可以让很多人去连接查看，就特别有用。但是一般来说都是只有运维或者redis工程师才能访问的。</p>\n<p>大家想一想，早期版本通过requirepass设置密码，这个不去设置，你的服务器很有可能被攻击，这个我们架构班的同学有遇到过，被勒索比特币，或者成为肉鸡挖矿。所以这个密码肯定要设置。</p>\n<h3>ACL 存储模式</h3>\n<p><img class=\"\" src=\"https://img3.sycdn.imooc.com/6010e470000151a426461196.jpg\" alt=\"https://img3.sycdn.imooc.com/6010e470000151a426461196.jpg\" data-src=\"https://img3.sycdn.imooc.com/6010e470000151a426461196.jpg\" data-original=\"https://img3.sycdn.imooc.com/6010e470000151a426461196.jpg\" /></p>\n<p>acl的权限的存储模式可以配置到redis.conf中，也可以外部文件aclfile，我个人偏好后者，这也是官方推荐的方式。（因为aclfile文件发生修改只需要重载acl即可，而conf方式需要重启redis）</p>\n<p>我们可以直接在命令行中创建用户去权限，然后再把用户保存到conf或者aclfile中。命令如下：</p>\n<pre>#&nbsp;将ACL权限持久化到redis.conf\nconfig&nbsp;rewrite\n&nbsp;\n#&nbsp;将ACL权限持久化到users.acl\nacl&nbsp;save</pre>\n<h3>实操演练</h3>\n<ul class=\"list-paddingleft-2\">\n<li>\n<p>开启aclfile，指定路径<br /><img class=\"\" src=\"https://img4.sycdn.imooc.com/6010e4710001372122340700.jpg\" alt=\"https://img4.sycdn.imooc.com/6010e4710001372122340700.jpg\" data-src=\"https://img4.sycdn.imooc.com/6010e4710001372122340700.jpg\" data-original=\"https://img4.sycdn.imooc.com/6010e4710001372122340700.jpg\" /></p>\n</li>\n<li>\n<p>创建权限acl文件（注意：需要他前创建acl空文件，否则重启redis会报错）</p>\n<pre>touch&nbsp;/usr/local/redis/users.acl</pre>\n<p><img class=\"\" src=\"https://img2.sycdn.imooc.com/6010e47200010d2e18960430.jpg\" alt=\"https://img2.sycdn.imooc.com/6010e47200010d2e18960430.jpg\" data-src=\"https://img2.sycdn.imooc.com/6010e47200010d2e18960430.jpg\" data-original=\"https://img2.sycdn.imooc.com/6010e47200010d2e18960430.jpg\" /></p>\n</li>\n</ul>\n<h3>重启redis并且进入客户端</h3>\n<p>查看进程<br /><img class=\"\" src=\"https://img1.sycdn.imooc.com/6010e473000167c223080204.jpg\" alt=\"https://img1.sycdn.imooc.com/6010e473000167c223080204.jpg\" data-src=\"https://img1.sycdn.imooc.com/6010e473000167c223080204.jpg\" data-original=\"https://img1.sycdn.imooc.com/6010e473000167c223080204.jpg\" /></p>\n<pre>./redis-cli&nbsp;shutdown</pre>\n<pre>./redis-server&nbsp;redis.conf</pre>\n<pre>./redis-cli\nauth&nbsp;default&nbsp;&nbsp;&nbsp;&nbsp;#&nbsp;默认用户无密码</pre>\n<p>或者</p>\n<pre>./redis-cli&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;#&nbsp;可以直接进入</pre>\n<h4>ACL的使用</h4>\n<ul class=\"list-paddingleft-2\">\n<li>\n<p>查看acl命令帮助（学习一个新东西，基本上他们都会有帮助文档的。像在linux中，大多都是help，就有一大堆的命令提示，后面还有英文的解释，这是最直接的学习方式）<code>acl help</code>相信但凡有一些经验的，这些其实都应该看得懂</p>\n</li>\n</ul>\n<pre>1)ACL：命令参数，要以&nbsp;ACL&nbsp;开头\n2)LOAD：重新加载acl文件，手动修改acl文件后，需要让redis服务重新加载，才能生效\n3)SAVE：保存当前用户权限配置到acl文件\n4)LIST：展示用户权限的详细信息\n5)USERS：展示所有用户名\n6)SETUSER：设置或者修改用户\n7)GETUSER：获得用户全新信息\n8)DELUSER：删除用户以及权限\n9)CAT：展示所有权限分类，不同的操作归类不同\n10)CAT&nbsp;&lt;某分类名&gt;：展示某分类具体包含哪些操作\n11)GENPASS：生成密码\n12)WHOAMI：当前登录者\n13)LOG：日志</pre>\n<p><img class=\"\" src=\"https://img2.sycdn.imooc.com/6010e4730001d11a23880852.jpg\" alt=\"https://img2.sycdn.imooc.com/6010e4730001d11a23880852.jpg\" data-src=\"https://img2.sycdn.imooc.com/6010e4730001d11a23880852.jpg\" data-original=\"https://img2.sycdn.imooc.com/6010e4730001d11a23880852.jpg\" /></p>\n<ul class=\"list-paddingleft-2\">\n<li>\n<p>默认没有配置的时候，会有一个default用户，<code>on</code>代表开启，<code>off</code>代表禁用。<code>default</code>为用户名，后面的内容为ACL规则描述，<code>~*</code>&nbsp;表示所有key，<code>+@all</code>&nbsp;表示所有命令。所以这个表示用户default开启状态，并且，没有密码而且可以访问所有命令以及所有数据。<br /><img class=\"\" src=\"https://img3.sycdn.imooc.com/6010e4740001aaad11360148.jpg\" alt=\"https://img3.sycdn.imooc.com/6010e4740001aaad11360148.jpg\" data-src=\"https://img3.sycdn.imooc.com/6010e4740001aaad11360148.jpg\" data-original=\"https://img3.sycdn.imooc.com/6010e4740001aaad11360148.jpg\" /></p>\n</li>\n<li>\n<p>获得所有的用户名<br /><img class=\"\" src=\"https://img4.sycdn.imooc.com/6010e47500018b0708500150.jpg\" alt=\"https://img4.sycdn.imooc.com/6010e47500018b0708500150.jpg\" data-src=\"https://img4.sycdn.imooc.com/6010e47500018b0708500150.jpg\" data-original=\"https://img4.sycdn.imooc.com/6010e47500018b0708500150.jpg\" /></p>\n</li>\n<li>\n<p>当前登录用户是谁<br /><img class=\"lazyload\" src=\"data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAAEAAAABCAYAAAAfFcSJAAAAAXNSR0IArs4c6QAAAARnQU1BAACxjwv8YQUAAAAJcEhZcwAADsQAAA7EAZUrDhsAAAANSURBVBhXYzh8+PB/AAffA0nNPuCLAAAAAElFTkSuQmCC\" alt=\"-w420\" data-original=\"https://lee-blog.oss-cn-shanghai.aliyuncs.com/2021/01/27/16076598464399.jpg\" /></p>\n</li>\n<li>\n<p>查看命令的分类：</p>\n<ul class=\"list-paddingleft-2\">\n<li>\n<p><code>acl cat</code>：显示所有的命令类别<img class=\"lazyload\" src=\"data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAAEAAAABCAYAAAAfFcSJAAAAAXNSR0IArs4c6QAAAARnQU1BAACxjwv8YQUAAAAJcEhZcwAADsQAAA7EAZUrDhsAAAANSURBVBhXYzh8+PB/AAffA0nNPuCLAAAAAElFTkSuQmCC\" alt=\"-w381\" data-original=\"https://lee-blog.oss-cn-shanghai.aliyuncs.com/2021/01/27/16076599011934.jpg\" /></p>\n</li>\n<li>\n<p>查某个类别下有哪些操作，就比如如下危险操作，这些命令都是危险的，对当前redis库可能会造成影响<img class=\"lazyload\" src=\"data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAAEAAAABCAYAAAAfFcSJAAAAAXNSR0IArs4c6QAAAARnQU1BAACxjwv8YQUAAAAJcEhZcwAADsQAAA7EAZUrDhsAAAANSURBVBhXYzh8+PB/AAffA0nNPuCLAAAAAElFTkSuQmCC\" alt=\"-w564\" data-original=\"https://lee-blog.oss-cn-shanghai.aliyuncs.com/2021/01/27/16076599481144.jpg\" /></p>\n</li>\n</ul>\n</li>\n</ul>\n<h3>创建用户</h3>\n<p>现在我们来创建一下用户</p>\n<ul class=\"list-paddingleft-2\">\n<li>\n<p>创建或者修改用户，用户名区分大小写，但是不建议把同样的用户名分为大小写不同的两个</p>\n<pre><code># 新增默认所有权限的用户\nACL SETUSER imooc on &gt;123456 ~* +@all<br /># 新增用户itzixi，密码123456，只能允许访问order前缀的key，可以使用set和get和acl命令<br />ACL SETUSER itzixi on &gt;123456 ~order* +get +set +acl</code></pre>\n</li>\n<li>\n<p>这个时候打开acl文件是空的，需要执行保存命令</p>\n</li>\n<li>\n<p>保存命令到aclfile</p>\n<pre>acl&nbsp;save</pre>\n<p><img class=\"lazyload\" src=\"data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAAEAAAABCAYAAAAfFcSJAAAAAXNSR0IArs4c6QAAAARnQU1BAACxjwv8YQUAAAAJcEhZcwAADsQAAA7EAZUrDhsAAAANSURBVBhXYzh8+PB/AAffA0nNPuCLAAAAAElFTkSuQmCC\" alt=\"-w1546\" data-original=\"https://lee-blog.oss-cn-shanghai.aliyuncs.com/2021/01/27/16076607782714.jpg\" /></p>\n</li>\n</ul>\n<h3>切换用户进行测试</h3>\n<ul class=\"list-paddingleft-2\">\n<li>\n<p>切换到itzixi用户，并且测试，他只能set和get，order前缀的key<img class=\"lazyload\" src=\"data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAAEAAAABCAYAAAAfFcSJAAAAAXNSR0IArs4c6QAAAARnQU1BAACxjwv8YQUAAAAJcEhZcwAADsQAAA7EAZUrDhsAAAANSURBVBhXYzh8+PB/AAffA0nNPuCLAAAAAElFTkSuQmCC\" alt=\"-w1284\" data-original=\"https://lee-blog.oss-cn-shanghai.aliyuncs.com/2021/01/27/16076610021507.jpg\" /></p>\n<ul class=\"list-paddingleft-2\">\n<li>\n<p>mget不可用<img class=\"lazyload\" src=\"data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAAEAAAABCAYAAAAfFcSJAAAAAXNSR0IArs4c6QAAAARnQU1BAACxjwv8YQUAAAAJcEhZcwAADsQAAA7EAZUrDhsAAAANSURBVBhXYzh8+PB/AAffA0nNPuCLAAAAAElFTkSuQmCC\" alt=\"-w1276\" data-original=\"https://lee-blog.oss-cn-shanghai.aliyuncs.com/2021/01/27/16076612141788.jpg\" /></p>\n</li>\n</ul>\n</li>\n</ul>\n<h3>为用户增加类别权限访问</h3>\n<ul class=\"list-paddingleft-2\">\n<li>\n<p>为用户itzixi新增某一个类别下的所有操作，比如这个类别就是read类别的所有读操作：</p>\n<pre>ACL&nbsp;SETUSER&nbsp;itzixi&nbsp;+@read</pre>\n<p><img class=\"lazyload\" src=\"data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAAEAAAABCAYAAAAfFcSJAAAAAXNSR0IArs4c6QAAAARnQU1BAACxjwv8YQUAAAAJcEhZcwAADsQAAA7EAZUrDhsAAAANSURBVBhXYzh8+PB/AAffA0nNPuCLAAAAAElFTkSuQmCC\" alt=\"-w624\" data-original=\"https://lee-blog.oss-cn-shanghai.aliyuncs.com/2021/01/27/16076614575650.jpg\" /></p>\n<ul class=\"list-paddingleft-2\">\n<li>\n<p>多了一个read类别<br /><img class=\"lazyload\" src=\"data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAAEAAAABCAYAAAAfFcSJAAAAAXNSR0IArs4c6QAAAARnQU1BAACxjwv8YQUAAAAJcEhZcwAADsQAAA7EAZUrDhsAAAANSURBVBhXYzh8+PB/AAffA0nNPuCLAAAAAElFTkSuQmCC\" alt=\"-w1652\" data-original=\"https://lee-blog.oss-cn-shanghai.aliyuncs.com/2021/01/27/16076614703568.jpg\" /></p>\n</li>\n<li>\n<p>这个时候可以使用mget操作了：<br /><img class=\"lazyload\" src=\"data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAAEAAAABCAYAAAAfFcSJAAAAAXNSR0IArs4c6QAAAARnQU1BAACxjwv8YQUAAAAJcEhZcwAADsQAAA7EAZUrDhsAAAANSURBVBhXYzh8+PB/AAffA0nNPuCLAAAAAElFTkSuQmCC\" alt=\"-w423\" data-original=\"https://lee-blog.oss-cn-shanghai.aliyuncs.com/2021/01/27/16076615089028.jpg\" /></p>\n</li>\n</ul>\n</li>\n</ul>\n<h4>附</h4>\n<p>ACL LOAD：我们也可以直接在aclfile中修改或新增ACL权限，修改之后不会立刻生效，我们可以在redis命令行中执行acl load将该aclfile中的权限加载至redis服务中。</p>\n<h3>客户端缓存 Client Side Cache</h3>\n<p><img class=\"lazyload\" src=\"data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAAEAAAABCAYAAAAfFcSJAAAAAXNSR0IArs4c6QAAAARnQU1BAACxjwv8YQUAAAAJcEhZcwAADsQAAA7EAZUrDhsAAAANSURBVBhXYzh8+PB/AAffA0nNPuCLAAAAAElFTkSuQmCC\" alt=\"-w1409\" data-original=\"https://lee-blog.oss-cn-shanghai.aliyuncs.com/2021/01/27/16110295995919.jpg\" /><br />这是他的官网地址，有兴趣可以看看：<br /><a href=\"https://redis.io/topics/client-side-caching\">https://redis.io/topics/client-side-caching</a></p>\n<p>我们应该都知道，redis作为缓存中间件，目的是为了减少热点数据对数据库的压力，并且提供更快的访问速度，redis的性能要比普通数据库快很多。</p>\n<p>但是redis也有瓶颈上线，因为请求到redis一定会有网络io的损耗，并且也有数据的序列化以及反序列化的等等的一些开销，所以如果在本地把热数据再做一次缓存的话（Guava Cache 进程缓存，可能会有不一致的情况），那么可以使得请求性能更好，加速访问，提升客户端的响应速度了，因为数据延迟就降低并且减少了很多嘛。</p>\n<p>大家可以想一下，什么场景下可以使用？<br />其实只要满足大量的请求，不怎么更改的数据，都可以。比如数据字典，我们的项目中涉及到一些超大型物流车的参数信息，这些基本上不会变动的，除非有相关的一些政策改变，那么有些参数信息就要变更，要不然直接存本地缓存是非常舒服的。</p>\n<p>可以看一下这图，他本质上就是基于redis-server服务端来维系和应用后端的关系，用的pub/sub发布订阅的通知机制，如果服务端缓存发生更改，那么可以向应用后端来推送，让其更新本地缓存。<br />其中应用是指的我们的部署的项目，调用端。</p>\n<blockquote>\n<p>了解一下：在Reds6之前的版本，使用的是RESP2协议，现在是RESP3，这个是REdisSerializationProtocol，是 Redis 服务端与客户端之间通信的协议。</p>\n</blockquote>\n<h3>实现客户端缓存的方式 - 默认模式</h3>\n<p>Redis-server 服务端会记录客户端访问了哪些key，这客户端id与key有唯一的映射关系，当其中的key发生变更时给客户端发送失效信息。这种模式会占用服务端所在服务器的内存。</p>\n<p><img class=\"lazyload\" src=\"data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAAEAAAABCAYAAAAfFcSJAAAAAXNSR0IArs4c6QAAAARnQU1BAACxjwv8YQUAAAAJcEhZcwAADsQAAA7EAZUrDhsAAAANSURBVBhXYzh8+PB/AAffA0nNPuCLAAAAAElFTkSuQmCC\" alt=\"-w912\" data-original=\"https://lee-blog.oss-cn-shanghai.aliyuncs.com/2021/01/27/16079178734955.jpg\" /></p>\n<h3>实现客户端缓存的方式 - 广播机制</h3>\n<p>客户端订阅访问过的key的前缀，当符合的key发生变更就会被redis-server通知（如果变更的key没有被客户端缓存，也会通知），由于服务器端不记录客户端访问的key，所以不会过多占用redis-server端的服务器内存；</p>\n<p><img class=\"lazyload\" src=\"data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAAEAAAABCAYAAAAfFcSJAAAAAXNSR0IArs4c6QAAAARnQU1BAACxjwv8YQUAAAAJcEhZcwAADsQAAA7EAZUrDhsAAAANSURBVBhXYzh8+PB/AAffA0nNPuCLAAAAAElFTkSuQmCC\" alt=\"-w998\" data-original=\"https://lee-blog.oss-cn-shanghai.aliyuncs.com/2021/01/27/16079182923906.jpg\" /></p>\n<p>在这种模式下，服务端维护的是前缀key，而不是默认模式的所有key，所以这样对于内存的占用不会很高，只要修改匹配的前缀key，那么订阅的客户端都会收到失效key的通知。只不过由于定订阅的是前缀，他会收到很多的无效通知。</p>\n<blockquote>\n<p>在广播模式下，只要符合客户端设置的key前缀的key发生新增、修改、删除、还有过期、淘汰等动作，即使该key没有被该客户端缓存，也会收到key的失效消息；</p>\n</blockquote>\n<h3>多级缓存</h3>\n<p>直播过程中提到了多级缓存架构，可以通过这图了解一下，更具体的可以做到4层，nginx可以做两层：</p>\n<h3><br />作者：风间影月<br />链接：https://www.imooc.com/article/314764<br />来源：慕课网</h3>\n</div>', 'http://hire.t.mukewang.com/static/photo/article/cover/6118463a-dca0-45dd-874f-aef13a24febd.png', '1001', '2022-08-19 11:48:40', 'admin', 'http://hire.t.mukewang.com/static/adminFace/644842e3-0173-42c0-a7a9-abdba09c358b.png', 1, '2022-08-19 11:49:13', '2022-08-19 11:49:23');
INSERT INTO `article` VALUES ('1560474094133694466', 'Redis6安装 - 集群与故障转移', '<div class=\"cl-preview-section\">\n<div class=\"cl-preview-section\">\n<h3>Redis Cluster 搭建准备工作</h3>\n</div>\n<div class=\"cl-preview-section\">\n<ol>\n<li>\n<p>搭建集群之前，务必有一点需要注意就是选举，因为在如今很多的分布式中间件里，集群都会有选举这个概念，一定要达到半数以上的节点，才能够发起公平的投票，否则就会脑裂，比如redis，zk，es等，所以至少保证3个master节点，master会发起选举投票的。这一点要须知。</p>\n</li>\n<li>\n<p>配置6个节点的虚拟机（预先做好）</p>\n<ul>\n<li>192.168.1.221</li>\n<li>192.168.1.222</li>\n<li>192.168.1.223</li>\n<li>192.168.1.224</li>\n<li>192.168.1.225</li>\n<li>192.168.1.226</li>\n<li>192.168.1.227（新增Master）</li>\n<li>192.168.1.228（新增Slave）</li>\n</ul>\n</li>\n<li>\n<p>每个节点搭建单机redis，清理aof和rdb文件（预先做好）</p>\n</li>\n<li>\n<p>如果为单实例的Redis设置了密码password，那么每个节点都必须要设置masterauth，也就是对应密码，这样是为了master挂掉以后，对应的slave可以升级为master。</p>\n</li>\n<li>\n<p>需要注意，选举的过程会短暂的对外不可用。</p>\n</li>\n</ol>\n</div>\n<div class=\"cl-preview-section\">\n<h3>Redis Cluster 搭建实操演练</h3>\n</div>\n<div class=\"cl-preview-section\">\n<p>附：<br />关闭redis</p>\n</div>\n<div class=\"cl-preview-section\">\n<pre><code>./redis-cli -p &lt;修改的端口号&gt; -a &lt;修改的密码&gt; shutdown\n</code></pre>\n</div>\n<div class=\"cl-preview-section\">\n<p>开启redis：</p>\n</div>\n<div class=\"cl-preview-section\">\n<pre><code>./redis-server redis.conf\n</code></pre>\n</div>\n<div class=\"cl-preview-section\">\n<p>每个单实例中的 redis.conf 配置：</p>\n</div>\n<div class=\"cl-preview-section\">\n<pre><code># 配置redis日志，便于检查\nlogfile /usr/local/redis/redis-221.log\n\n# 开启集群模式\ncluster-enabled yes\n# 每一个节点需要有一个配置文件，需要6份。每个节点处于集群的角色都需要告知其他所有节点，彼此知道，这个文件用于存储集群模式下的集群状态等信息，这个文件是由redis自己维护，我们不用管。如果你要重新创建集群，那么把这个文件删了就行\ncluster-config-file nodes-221.conf\n# 超时时间，超时则认为master宕机，随后主备切换\ncluster-node-timeout 5000\n# 开启AOF\nappendonly yes\n</code></pre>\n</div>\n<div class=\"cl-preview-section\">\n<p>创建集群，在任意节点运行如下命令一次：</p>\n</div>\n<div class=\"cl-preview-section\">\n<pre><code>#####\n# 注意1：如果你使用的是redis3.x版本，需要使用redis-trib.rb来构建集群，最新版使用C语言来构建了，这个要注意\n# 注意2：以下为新版的redis构建方式\n#####\n\n# 创建集群，主节点和从节点比例为1，1-3为主，4-6为从，这也是最经典用的最多的集群模式。cluster-replicas是几个slave，-a是执行秘密。\n./redis-cli --cluster create ip1:port1 ip2:port2 ip3:port3 ip4:port4 ip5:port5 ip6:port6 --cluster-replicas 1 -a 123456\n</code></pre>\n</div>\n<div class=\"cl-preview-section\">\n<p><img class=\"lazyload\" src=\"data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAAEAAAABCAYAAAAfFcSJAAAAAXNSR0IArs4c6QAAAARnQU1BAACxjwv8YQUAAAAJcEhZcwAADsQAAA7EAZUrDhsAAAANSURBVBhXYzh8+PB/AAffA0nNPuCLAAAAAElFTkSuQmCC\" alt=\"-w1836\" data-original=\"https://lee-blog.oss-cn-shanghai.aliyuncs.com/2020/12/16/15927853028186.jpg\" /><br /><img class=\"lazyload\" src=\"data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAAEAAAABCAYAAAAfFcSJAAAAAXNSR0IArs4c6QAAAARnQU1BAACxjwv8YQUAAAAJcEhZcwAADsQAAA7EAZUrDhsAAAANSURBVBhXYzh8+PB/AAffA0nNPuCLAAAAAElFTkSuQmCC\" alt=\"-w708\" data-original=\"https://lee-blog.oss-cn-shanghai.aliyuncs.com/2020/12/16/15927853619097.jpg\" /></p>\n</div>\n<div class=\"cl-preview-section\">\n<p>从上图中可以看到，slots槽，用于装数据，主节点有，从节点没有。</p>\n</div>\n<div class=\"cl-preview-section\">\n<p>在任意节点查看集群信息：</p>\n</div>\n<div class=\"cl-preview-section\">\n<pre><code>./redis-cli --cluster check 192.168.1.221:6379 -a 123456\n</code></pre>\n</div>\n<div class=\"cl-preview-section\">\n<p>查看主从状态信息：</p>\n</div>\n<div class=\"cl-preview-section\">\n<pre><code>./redis-cli -a 123456\ninfo replication\n</code></pre>\n</div>\n<div class=\"cl-preview-section\">\n<p><img class=\"lazyload\" src=\"data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAAEAAAABCAYAAAAfFcSJAAAAAXNSR0IArs4c6QAAAARnQU1BAACxjwv8YQUAAAAJcEhZcwAADsQAAA7EAZUrDhsAAAANSURBVBhXYzh8+PB/AAffA0nNPuCLAAAAAElFTkSuQmCC\" alt=\"-w1077\" data-original=\"https://lee-blog.oss-cn-shanghai.aliyuncs.com/2020/12/16/15927856721558.jpg\" /><br /><img class=\"lazyload\" src=\"data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAAEAAAABCAYAAAAfFcSJAAAAAXNSR0IArs4c6QAAAARnQU1BAACxjwv8YQUAAAAJcEhZcwAADsQAAA7EAZUrDhsAAAANSURBVBhXYzh8+PB/AAffA0nNPuCLAAAAAElFTkSuQmCC\" alt=\"-w1069\" data-original=\"https://lee-blog.oss-cn-shanghai.aliyuncs.com/2020/12/16/15927857301519.jpg\" /></p>\n</div>\n<div class=\"cl-preview-section\">\n<h3>搭建集群时的日志</h3>\n</div>\n<div class=\"cl-preview-section\">\n<p>M221与S225<br /><img class=\"lazyload\" src=\"data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAAEAAAABCAYAAAAfFcSJAAAAAXNSR0IArs4c6QAAAARnQU1BAACxjwv8YQUAAAAJcEhZcwAADsQAAA7EAZUrDhsAAAANSURBVBhXYzh8+PB/AAffA0nNPuCLAAAAAElFTkSuQmCC\" alt=\"-w1845\" data-original=\"https://lee-blog.oss-cn-shanghai.aliyuncs.com/2020/12/16/15927858478428.jpg\" /></p>\n</div>\n<div class=\"cl-preview-section\">\n<p>M222与S226<br /><img class=\"lazyload\" src=\"data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAAEAAAABCAYAAAAfFcSJAAAAAXNSR0IArs4c6QAAAARnQU1BAACxjwv8YQUAAAAJcEhZcwAADsQAAA7EAZUrDhsAAAANSURBVBhXYzh8+PB/AAffA0nNPuCLAAAAAElFTkSuQmCC\" alt=\"-w1838\" data-original=\"https://lee-blog.oss-cn-shanghai.aliyuncs.com/2020/12/16/15927860126498.jpg\" /></p>\n</div>\n<div class=\"cl-preview-section\">\n<p>M223与S224<br /><img class=\"lazyload\" src=\"data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAAEAAAABCAYAAAAfFcSJAAAAAXNSR0IArs4c6QAAAARnQU1BAACxjwv8YQUAAAAJcEhZcwAADsQAAA7EAZUrDhsAAAANSURBVBhXYzh8+PB/AAffA0nNPuCLAAAAAElFTkSuQmCC\" alt=\"-w1833\" data-original=\"https://lee-blog.oss-cn-shanghai.aliyuncs.com/2020/12/16/15927861170135.jpg\" /></p>\n</div>\n<div class=\"cl-preview-section\">\n<p>从节点日志，主要进行复制：<br /><img class=\"lazyload\" src=\"data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAAEAAAABCAYAAAAfFcSJAAAAAXNSR0IArs4c6QAAAARnQU1BAACxjwv8YQUAAAAJcEhZcwAADsQAAA7EAZUrDhsAAAANSURBVBhXYzh8+PB/AAffA0nNPuCLAAAAAElFTkSuQmCC\" alt=\"-w1834\" data-original=\"https://lee-blog.oss-cn-shanghai.aliyuncs.com/2020/12/16/15927862271609.jpg\" /></p>\n</div>\n<div class=\"cl-preview-section\">\n<p><code>cluster nodes</code>&nbsp;查看各个节点的信息<br /><img class=\"lazyload\" src=\"data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAAEAAAABCAYAAAAfFcSJAAAAAXNSR0IArs4c6QAAAARnQU1BAACxjwv8YQUAAAAJcEhZcwAADsQAAA7EAZUrDhsAAAANSURBVBhXYzh8+PB/AAffA0nNPuCLAAAAAElFTkSuQmCC\" alt=\"-w1558\" data-original=\"https://lee-blog.oss-cn-shanghai.aliyuncs.com/2020/12/16/15930605791772.jpg\" /></p>\n</div>\n<div class=\"cl-preview-section\">\n<h3>故障转移</h3>\n</div>\n<div class=\"cl-preview-section\">\n<p>如果一个master挂了，那么剩余的2个master会发起投票选举，从挂了的master对应的slave中选举出一个新的master，发生故障的master不会参与投票，这个要注意。</p>\n</div>\n<div class=\"cl-preview-section\">\n<p>选举的时候需要半数以上的master都投票给同一个slave，那么他才会成为新的master。所以redis集群中至少需要3个主节点，2个是不行的。而且我们也是建议在不同的物理节点上去进行配置，如果是伪分布式集群，那么可能会有问题。</p>\n</div>\n<div class=\"cl-preview-section\">\n<p>故障转移的主要流程首先是主观下线，然后是客观下线，这个我们在课程里有说过，要以客观为主，也就是半数以上的master都收不到某节点的心跳，则认为他宕机了，此时发起选举。</p>\n</div>\n<div class=\"cl-preview-section\">\n<h3>验证故障转移</h3>\n</div>\n<div class=\"cl-preview-section\">\n<ol>\n<li>\n<p>redis宕机，停止某一台master，观察日志，以及对应的从。<br /><img class=\"lazyload\" src=\"data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAAEAAAABCAYAAAAfFcSJAAAAAXNSR0IArs4c6QAAAARnQU1BAACxjwv8YQUAAAAJcEhZcwAADsQAAA7EAZUrDhsAAAANSURBVBhXYzh8+PB/AAffA0nNPuCLAAAAAElFTkSuQmCC\" alt=\"-w1079\" data-original=\"https://lee-blog.oss-cn-shanghai.aliyuncs.com/2020/12/16/15927866239125.jpg\" /><br />上图中，225升级为master，原来的221下线。slots自动重新分配。</p>\n</li>\n<li>\n<p>重启原来的221，可以发现，他加入到了225的麾下，成为他的slave，并且进行了主从数据同步。<br /><img class=\"lazyload\" src=\"data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAAEAAAABCAYAAAAfFcSJAAAAAXNSR0IArs4c6QAAAARnQU1BAACxjwv8YQUAAAAJcEhZcwAADsQAAA7EAZUrDhsAAAANSURBVBhXYzh8+PB/AAffA0nNPuCLAAAAAElFTkSuQmCC\" alt=\"-w1839\" data-original=\"https://lee-blog.oss-cn-shanghai.aliyuncs.com/2020/12/16/15927867377513.jpg\" /><br />在新的主225中可以看到221的加入ask询问同步等信息<br /><img class=\"lazyload\" src=\"data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAAEAAAABCAYAAAAfFcSJAAAAAXNSR0IArs4c6QAAAARnQU1BAACxjwv8YQUAAAAJcEhZcwAADsQAAA7EAZUrDhsAAAANSURBVBhXYzh8+PB/AAffA0nNPuCLAAAAAElFTkSuQmCC\" alt=\"-w1835\" data-original=\"https://lee-blog.oss-cn-shanghai.aliyuncs.com/2020/12/16/15927868945958.jpg\" /></p>\n</li>\n<li>\n<p>直接关闭225服务器，直接关停，相当于服务器炸了。测试后发现，221成为新的master，也就是说不论是redis宕机还是服务器炸了，对应的slave都能被选举为新的master，因为只要master集群客观认为你下线了，那么就会进行选举。</p>\n</li>\n</ol>\n</div>\n<div class=\"cl-preview-section\">\n<h3>验证数据能否都在主从中获取</h3>\n</div>\n<div class=\"cl-preview-section\">\n<pre><code>./redis-cli -a 123456 -c\n set name lee\n</code></pre>\n</div>\n<div class=\"cl-preview-section\">\n<p><img class=\"lazyload\" src=\"data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAAEAAAABCAYAAAAfFcSJAAAAAXNSR0IArs4c6QAAAARnQU1BAACxjwv8YQUAAAAJcEhZcwAADsQAAA7EAZUrDhsAAAANSURBVBhXYzh8+PB/AAffA0nNPuCLAAAAAElFTkSuQmCC\" alt=\"-w1093\" data-original=\"https://lee-blog.oss-cn-shanghai.aliyuncs.com/2020/12/16/15927874694192.jpg\" /><br />集群中设值与取值，需要加<code>-c</code>。<br />图中数据进入到了主222中，那么验证一下从某个从节点中能不能获取，他会跳转到222中去获取，因为现在是一个集群形态。<br /><img class=\"lazyload\" src=\"data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAAEAAAABCAYAAAAfFcSJAAAAAXNSR0IArs4c6QAAAARnQU1BAACxjwv8YQUAAAAJcEhZcwAADsQAAA7EAZUrDhsAAAANSURBVBhXYzh8+PB/AAffA0nNPuCLAAAAAElFTkSuQmCC\" alt=\"-w1108\" data-original=\"https://lee-blog.oss-cn-shanghai.aliyuncs.com/2020/12/16/15927875953957.jpg\" /></p>\n</div>\n<div class=\"cl-preview-section\">\n<p>如果不加<code>-c</code>，以单实例形式去操作，那么会报错。<br /><img class=\"lazyload\" src=\"data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAAEAAAABCAYAAAAfFcSJAAAAAXNSR0IArs4c6QAAAARnQU1BAACxjwv8YQUAAAAJcEhZcwAADsQAAA7EAZUrDhsAAAANSURBVBhXYzh8+PB/AAffA0nNPuCLAAAAAElFTkSuQmCC\" alt=\"-w1098\" data-original=\"https://lee-blog.oss-cn-shanghai.aliyuncs.com/2020/12/16/15927876265943.jpg\" /></p>\n</div>\n<div class=\"cl-preview-section\">\n<p>关闭主222，观察原来设置的数据，在slave226转变为master后，数据是否存在：<br /><img class=\"lazyload\" src=\"data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAAEAAAABCAYAAAAfFcSJAAAAAXNSR0IArs4c6QAAAARnQU1BAACxjwv8YQUAAAAJcEhZcwAADsQAAA7EAZUrDhsAAAANSURBVBhXYzh8+PB/AAffA0nNPuCLAAAAAElFTkSuQmCC\" alt=\"-w1071\" data-original=\"https://lee-blog.oss-cn-shanghai.aliyuncs.com/2020/12/16/15927880221948.jpg\" /><br />因为数据会主从同步，所以master宕机后，slave中还是会有他的数据。这些数据都是跟着slot走的。</p>\n</div>\n<div class=\"cl-preview-section\">\n<h3>master宕机，他的slave升级为master，再次宕机，看看剩余的2主2从能否运行</h3>\n</div>\n<div class=\"cl-preview-section\">\n<p>紧接上面的，接着关闭新主226，剩余2主2从，查看状态，你会发现出错，提示说slots分配不均匀，因为有一对主从没有的slot都没了。<br /><img class=\"lazyload\" src=\"data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAAEAAAABCAYAAAAfFcSJAAAAAXNSR0IArs4c6QAAAARnQU1BAACxjwv8YQUAAAAJcEhZcwAADsQAAA7EAZUrDhsAAAANSURBVBhXYzh8+PB/AAffA0nNPuCLAAAAAElFTkSuQmCC\" alt=\"-w1094\" data-original=\"https://lee-blog.oss-cn-shanghai.aliyuncs.com/2020/12/16/15927883312600.jpg\" /><br />随后在任意节点去查询数据，提示说当前集群不可用，我们需要恢复了。<br /><img class=\"lazyload\" src=\"data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAAEAAAABCAYAAAAfFcSJAAAAAXNSR0IArs4c6QAAAARnQU1BAACxjwv8YQUAAAAJcEhZcwAADsQAAA7EAZUrDhsAAAANSURBVBhXYzh8+PB/AAffA0nNPuCLAAAAAElFTkSuQmCC\" alt=\"-w1092\" data-original=\"https://lee-blog.oss-cn-shanghai.aliyuncs.com/2020/12/16/15927883962226.jpg\" /></p>\n</div>\n<div class=\"cl-preview-section\">\n<h3>多master宕机数超过半数以上，集群不可用</h3>\n</div>\n<div class=\"cl-preview-section\">\n<p>同时有2个redis-master都宕机，那么无法达到半数以上，此时无法选举，当前集群不可用。由于速度比较快，虚拟机里难以演示，所以此处意会一下哈~<br />(如果半数以上 Master 处于关闭状态那么整个集群处于不可用状态。)</p>\n</div>\n<div class=\"cl-preview-section\">\n<h3>集群节点通信 gossip了解即可，无需深究</h3>\n</div>\n<div class=\"cl-preview-section\">\n<p>redis集群模式下的几个节点之间也会相互通信，他们的通信协议是gossip，各个节点之间会有ping pong等消息类型，每个节点也维护着redis的元数据，一旦发生更改会相互发送。</p>\n</div>\n<div class=\"cl-preview-section\">\n<h3>redis 水平扩容，增加节点，重新shard分配slot</h3>\n</div>\n<div class=\"cl-preview-section\">\n<p>新增192.168.1.227<br />修改redis.conf文件后，启动服务。查看分片信息：<br /><img class=\"lazyload\" src=\"data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAAEAAAABCAYAAAAfFcSJAAAAAXNSR0IArs4c6QAAAARnQU1BAACxjwv8YQUAAAAJcEhZcwAADsQAAA7EAZUrDhsAAAANSURBVBhXYzh8+PB/AAffA0nNPuCLAAAAAElFTkSuQmCC\" alt=\"-w862\" data-original=\"https://lee-blog.oss-cn-shanghai.aliyuncs.com/2020/12/16/15930600667271.jpg\" /><br />对比现有的master<br /><img class=\"lazyload\" src=\"data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAAEAAAABCAYAAAAfFcSJAAAAAXNSR0IArs4c6QAAAARnQU1BAACxjwv8YQUAAAAJcEhZcwAADsQAAA7EAZUrDhsAAAANSURBVBhXYzh8+PB/AAffA0nNPuCLAAAAAElFTkSuQmCC\" alt=\"-w702\" data-original=\"https://lee-blog.oss-cn-shanghai.aliyuncs.com/2020/12/16/15930602000577.jpg\" /><br />对比后他自己虽然标识master，但是没起作用，也没加入到现有的集群</p>\n</div>\n<div class=\"cl-preview-section\">\n<p>这个时候需要使用如下命令，把节点加入到当前集群：</p>\n</div>\n<div class=\"cl-preview-section\">\n<pre><code># 添加一个新的节点到现有的集群中。第一个ip为新节点，第二个ip为现有集群中的某个节点ip\n新增192.168.1.227\n./redis-cli --cluster add-node 192.168.1.227:6379 192.168.1.221:6379 -a 123456\n</code></pre>\n</div>\n<div class=\"cl-preview-section\">\n<p><img class=\"lazyload\" src=\"data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAAEAAAABCAYAAAAfFcSJAAAAAXNSR0IArs4c6QAAAARnQU1BAACxjwv8YQUAAAAJcEhZcwAADsQAAA7EAZUrDhsAAAANSURBVBhXYzh8+PB/AAffA0nNPuCLAAAAAElFTkSuQmCC\" alt=\"-w1100\" data-original=\"https://lee-blog.oss-cn-shanghai.aliyuncs.com/2020/12/16/15930608737056.jpg\" /><br />如上图，新节点，加入成功。<br /><img class=\"lazyload\" src=\"data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAAEAAAABCAYAAAAfFcSJAAAAAXNSR0IArs4c6QAAAARnQU1BAACxjwv8YQUAAAAJcEhZcwAADsQAAA7EAZUrDhsAAAANSURBVBhXYzh8+PB/AAffA0nNPuCLAAAAAElFTkSuQmCC\" alt=\"-w1162\" data-original=\"https://lee-blog.oss-cn-shanghai.aliyuncs.com/2020/12/16/15930609161729.jpg\" /><br />这个时候新加入的节点为master了，但是从图中看的出来，并没有slot槽位信息，我们还需要重新分槽，才能使用。</p>\n</div>\n<div class=\"cl-preview-section\">\n<pre><code># ip端口是集群中任意一个节点和对应端口号\n./redis-cli --cluster reshard  ip:port -a 密码\n</code></pre>\n</div>\n<div class=\"cl-preview-section\">\n<p><img class=\"lazyload\" src=\"data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAAEAAAABCAYAAAAfFcSJAAAAAXNSR0IArs4c6QAAAARnQU1BAACxjwv8YQUAAAAJcEhZcwAADsQAAA7EAZUrDhsAAAANSURBVBhXYzh8+PB/AAffA0nNPuCLAAAAAElFTkSuQmCC\" alt=\"-w653\" data-original=\"https://lee-blog.oss-cn-shanghai.aliyuncs.com/2020/12/16/15930611769623.jpg\" /><br />询问需要迁移多少个slots，迁移之后，原来的数据还是存在与slots中的，因为哈希后取模的接口还是对应某个slot，数据还在。</p>\n</div>\n<div class=\"cl-preview-section\">\n<p>填入需要迁移的节点id，也就是新增的master的id，复制进去。<br /><img class=\"lazyload\" src=\"data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAAEAAAABCAYAAAAfFcSJAAAAAXNSR0IArs4c6QAAAARnQU1BAACxjwv8YQUAAAAJcEhZcwAADsQAAA7EAZUrDhsAAAANSURBVBhXYzh8+PB/AAffA0nNPuCLAAAAAElFTkSuQmCC\" alt=\"-w1097\" data-original=\"https://lee-blog.oss-cn-shanghai.aliyuncs.com/2020/12/16/15930613473033.jpg\" /></p>\n</div>\n<div class=\"cl-preview-section\">\n<p>随后输入<code>all</code>，表示从每个现有master中都取出一定的slot进行迁移。（<code>done</code>的话是从指定的节点中拿出一部分slot来迁移）<br />然后再<code>yes</code>，表示执行reshard操作。<br /><img class=\"lazyload\" src=\"data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAAEAAAABCAYAAAAfFcSJAAAAAXNSR0IArs4c6QAAAARnQU1BAACxjwv8YQUAAAAJcEhZcwAADsQAAA7EAZUrDhsAAAANSURBVBhXYzh8+PB/AAffA0nNPuCLAAAAAElFTkSuQmCC\" alt=\"-w747\" data-original=\"https://lee-blog.oss-cn-shanghai.aliyuncs.com/2020/12/16/15930614870716.jpg\" /><br />等待一段时间迁移后，迁移成功。重新检查集群信息。这个时候227中有2000个slot，分别都是从其他节点迁移的一部分共同组合的。<br /><img class=\"lazyload\" src=\"data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAAEAAAABCAYAAAAfFcSJAAAAAXNSR0IArs4c6QAAAARnQU1BAACxjwv8YQUAAAAJcEhZcwAADsQAAA7EAZUrDhsAAAANSURBVBhXYzh8+PB/AAffA0nNPuCLAAAAAElFTkSuQmCC\" alt=\"-w918\" data-original=\"https://lee-blog.oss-cn-shanghai.aliyuncs.com/2020/12/16/15930615867132.jpg\" /><br />如此一来，新的master节点加入到集群了。</p>\n</div>\n<div class=\"cl-preview-section\">\n<p>之前的name是在别的master中，由于slot迁移了，这个时候再查询的时候，他会路由到227节点，说明了数据不会因为节点增加而丢失，都会跟着slot走。<br /><img class=\"lazyload\" src=\"data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAAEAAAABCAYAAAAfFcSJAAAAAXNSR0IArs4c6QAAAARnQU1BAACxjwv8YQUAAAAJcEhZcwAADsQAAA7EAZUrDhsAAAANSURBVBhXYzh8+PB/AAffA0nNPuCLAAAAAElFTkSuQmCC\" alt=\"-w715\" data-original=\"https://lee-blog.oss-cn-shanghai.aliyuncs.com/2020/12/16/15930620685965.jpg\" /></p>\n</div>\n<div class=\"cl-preview-section\">\n<p>测试关闭这台新的master，由于slot不完整，集群不可用。其实也就是说明了整个集群形态下，总数16384个哈希槽必须都存在，缺少了就不完整了。所以就必定需要使用高可用，每个master下都要挂在至少1个slave。<br /><img class=\"lazyload\" src=\"data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAAEAAAABCAYAAAAfFcSJAAAAAXNSR0IArs4c6QAAAARnQU1BAACxjwv8YQUAAAAJcEhZcwAADsQAAA7EAZUrDhsAAAANSURBVBhXYzh8+PB/AAffA0nNPuCLAAAAAElFTkSuQmCC\" alt=\"-w472\" data-original=\"https://lee-blog.oss-cn-shanghai.aliyuncs.com/2020/12/16/15930617541399.jpg\" /></p>\n</div>\n<div class=\"cl-preview-section\">\n<h3>新加slave，把他安排到某个特定的master之下</h3>\n</div>\n<div class=\"cl-preview-section\">\n<p>执行如下命令：</p>\n</div>\n<div class=\"cl-preview-section\">\n<pre><code>./redis-cli --cluster add-node --cluster-slave --cluster-master-id [master-id] [slave-ip:port] [master-ip:port]\n</code></pre>\n</div>\n<div class=\"cl-preview-section\">\n<p><img class=\"lazyload\" src=\"data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAAEAAAABCAYAAAAfFcSJAAAAAXNSR0IArs4c6QAAAARnQU1BAACxjwv8YQUAAAAJcEhZcwAADsQAAA7EAZUrDhsAAAANSURBVBhXYzh8+PB/AAffA0nNPuCLAAAAAElFTkSuQmCC\" alt=\"-w1851\" data-original=\"https://lee-blog.oss-cn-shanghai.aliyuncs.com/2020/12/16/15930628386215.jpg\" /><br />添加节点成功。<br />这个时候查看，可以看到228加入到集群，并且成为了slave：<br /><img class=\"lazyload\" src=\"data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAAEAAAABCAYAAAAfFcSJAAAAAXNSR0IArs4c6QAAAARnQU1BAACxjwv8YQUAAAAJcEhZcwAADsQAAA7EAZUrDhsAAAANSURBVBhXYzh8+PB/AAffA0nNPuCLAAAAAElFTkSuQmCC\" alt=\"-w859\" data-original=\"https://lee-blog.oss-cn-shanghai.aliyuncs.com/2020/12/16/15930628981047.jpg\" /><br />228的分片信息slave归属为227，如此一来slave添加到某个master下成功了</p>\n</div>\n<p><br />作者：风间影月<br />链接：https://www.imooc.com/article/313301<br />来源：慕课网</p>\n</div>', 'http://hire.t.mukewang.com/static/photo/article/cover/f7d1132c-bbb5-42fe-86ce-4ca5c588f321.png', '1001', '2022-08-19 11:49:23', 'admin', 'http://hire.t.mukewang.com/static/adminFace/644842e3-0173-42c0-a7a9-abdba09c358b.png', 1, '2022-08-19 11:49:51', '2022-08-19 11:50:01');
INSERT INTO `article` VALUES ('1560474234974228481', '新课推荐：融合主流的技术 分布式中间件+微服务+微架构架构', '<p>近期以来其实一直觉得学习技术不仅是光学，还要融入项目，尤其是一些刚毕业或者工作1-2年的。很多学了一些技术，但是没有融入到项目里去使用，这样很多会因为时间久远会忘记。那么近期在慕课网上架了一门课程，融入了主流的技术，实战级别的课程，很多中间件分布式技术都会随着项目进阶一起学习，渐进式的方式手把手教学。并且还有springcloud微服务的内容。<br /><img class=\"\" src=\"https://img1.sycdn.imooc.com/5f6186150001ccb720640362.jpg\" alt=\"https://img1.sycdn.imooc.com/5f6186150001ccb720640362.jpg\" data-src=\"https://img1.sycdn.imooc.com/5f6186150001ccb720640362.jpg\" data-original=\"https://img1.sycdn.imooc.com/5f6186150001ccb720640362.jpg\" /></p>\n<p>当然课程是长期更新迭代的，后续会加入zookeeper，elasticsearch，springcloud alibaba等，包括业务上的功能升级诸如 微信支付，新功能开发等等，也都会有。整体课程的目标是微服务微架构微体系，有兴趣的同学可以点击<code>原文链接</code>了解一下噢~&nbsp;<a href=\"https://coding.imooc.com/class/456.html\">https://coding.imooc.com/class/456.html</a><img class=\"\" src=\"https://img1.sycdn.imooc.com/5f61861700013c7624120768.jpg\" alt=\"https://img1.sycdn.imooc.com/5f61861700013c7624120768.jpg\" data-src=\"https://img1.sycdn.imooc.com/5f61861700013c7624120768.jpg\" data-original=\"https://img1.sycdn.imooc.com/5f61861700013c7624120768.jpg\" /></p>\n<p><img class=\"\" src=\"https://img3.sycdn.imooc.com/5f61861900019da221121312.jpg\" alt=\"https://img3.sycdn.imooc.com/5f61861900019da221121312.jpg\" data-src=\"https://img3.sycdn.imooc.com/5f61861900019da221121312.jpg\" data-original=\"https://img3.sycdn.imooc.com/5f61861900019da221121312.jpg\" /><br /><img class=\"\" src=\"https://img1.sycdn.imooc.com/5f61861e0001757a21420958.jpg\" alt=\"https://img1.sycdn.imooc.com/5f61861e0001757a21420958.jpg\" data-src=\"https://img1.sycdn.imooc.com/5f61861e0001757a21420958.jpg\" data-original=\"https://img1.sycdn.imooc.com/5f61861e0001757a21420958.jpg\" /><br /><img class=\"\" src=\"https://img3.sycdn.imooc.com/5f61861f00019d7914081034.jpg\" alt=\"https://img3.sycdn.imooc.com/5f61861f00019d7914081034.jpg\" data-src=\"https://img3.sycdn.imooc.com/5f61861f00019d7914081034.jpg\" data-original=\"https://img3.sycdn.imooc.com/5f61861f00019d7914081034.jpg\" /></p>\n<p>&nbsp;</p>\n<p><br />作者：风间影月<br />链接：https://www.imooc.com/article/310706<br />来源：慕课网</p>', 'http://hire.t.mukewang.com/static/photo/article/cover/fa22d75f-0b16-4beb-a754-0e83c33e6526.png', '1001', '2022-08-19 11:50:15', 'admin', 'http://hire.t.mukewang.com/static/adminFace/644842e3-0173-42c0-a7a9-abdba09c358b.png', 1, '2022-08-19 11:50:24', '2022-08-19 11:50:34');
INSERT INTO `article` VALUES ('1560474374556471298', '安装与配置最新版本的RabbitMQ-3.8.5（附视频）', '<div class=\"cl-preview-section\">\n<h3>引子</h3>\n</div>\n<div class=\"cl-preview-section\">\n<p>之前装过3.7.x的，最新的已经到了3.8.5，RabbitMQ恶心的一点就是版本太混乱，而且每隔几个版本，安装方式都略有不同，这次再来更新一下吧。</p>\n</div>\n<div class=\"cl-preview-section\">\n<h3>安装RabbitMQ</h3>\n</div>\n<div class=\"cl-preview-section\">\n<ol>\n<li>\n<p>看官网：<a href=\"https://www.rabbitmq.com/install-rpm.html\">https://www.rabbitmq.com/install-rpm.html</a><br /><img class=\"lazyload\" src=\"data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAAEAAAABCAYAAAAfFcSJAAAAAXNSR0IArs4c6QAAAARnQU1BAACxjwv8YQUAAAAJcEhZcwAADsQAAA7EAZUrDhsAAAANSURBVBhXYzh8+PB/AAffA0nNPuCLAAAAAElFTkSuQmCC\" alt=\"-w264\" data-original=\"https://lee-blog.oss-cn-shanghai.aliyuncs.com/2020/06/17/15922834900421.jpg\" /></p>\n</li>\n<li>\n<p>看匹配版本：<a href=\"https://www.rabbitmq.com/which-erlang.html\">https://www.rabbitmq.com/which-erlang.html</a><br /><img class=\"lazyload\" src=\"data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAAEAAAABCAYAAAAfFcSJAAAAAXNSR0IArs4c6QAAAARnQU1BAACxjwv8YQUAAAAJcEhZcwAADsQAAA7EAZUrDhsAAAANSURBVBhXYzh8+PB/AAffA0nNPuCLAAAAAElFTkSuQmCC\" alt=\"-w991\" data-original=\"https://lee-blog.oss-cn-shanghai.aliyuncs.com/2020/06/17/15922835083929.jpg\" /><br />那么3.8.5的对应erlang版本区间如上图，这个要匹配。rabbitmq和erlang的版本对应都需要匹配上，才能安装rabbitmq，也就是说必须得有erlang的环境，就跟java需要jvm一个道理。</p>\n</li>\n<li>\n<p>随后点击步骤1中第一个红框链接<code>Install: RPM-based Linux</code>，进入安装，Windows和mac安装相对简单，就不多说了，我们主要说说在linux中的安装。打开这个链接后看到其实挺乱的，要一个个去看才行，也没有大小标题和序号，给第一次进来的开发者很不友好的感觉，尤其是英文不太好的，，，不过没关系，跟着步骤一步步就能安装。找到<code>Install RabbitMQ Server</code>，如下图：<br /><img class=\"lazyload\" src=\"data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAAEAAAABCAYAAAAfFcSJAAAAAXNSR0IArs4c6QAAAARnQU1BAACxjwv8YQUAAAAJcEhZcwAADsQAAA7EAZUrDhsAAAANSURBVBhXYzh8+PB/AAffA0nNPuCLAAAAAElFTkSuQmCC\" alt=\"-w1025\" data-original=\"https://lee-blog.oss-cn-shanghai.aliyuncs.com/2020/06/17/15922839021356.jpg\" /><br />上图中点击第一个链接<code>install a recent Erlang version via yum</code>，进入到如下页面：<br /><img class=\"lazyload\" src=\"data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAAEAAAABCAYAAAAfFcSJAAAAAXNSR0IArs4c6QAAAARnQU1BAACxjwv8YQUAAAAJcEhZcwAADsQAAA7EAZUrDhsAAAANSURBVBhXYzh8+PB/AAffA0nNPuCLAAAAAElFTkSuQmCC\" alt=\"-w1764\" data-original=\"https://lee-blog.oss-cn-shanghai.aliyuncs.com/2020/06/17/15922840843695.jpg\" /><br />这个是用于安装erlang的前置脚本文件，拷贝一下到自己的linux系统进行运行：</p>\n<pre><code class=\"eye-protector-processed\">curl -s https://packagecloud.io/install/repositories/rabbitmq/erlang/script.rpm.sh | sudo bash\n</code></pre>\n</li>\n</ol>\n</div>\n<div class=\"cl-preview-section\">\n<p>运行后看到如下提示，说明文件依赖库已经配置好了，现在可以继续往下安装了。<br /><img class=\"lazyload\" src=\"data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAAEAAAABCAYAAAAfFcSJAAAAAXNSR0IArs4c6QAAAARnQU1BAACxjwv8YQUAAAAJcEhZcwAADsQAAA7EAZUrDhsAAAANSURBVBhXYzh8+PB/AAffA0nNPuCLAAAAAElFTkSuQmCC\" alt=\"-w1000\" data-original=\"https://lee-blog.oss-cn-shanghai.aliyuncs.com/2020/06/17/15922842013500.jpg\" /></p>\n</div>\n<div class=\"cl-preview-section\">\n<ol start=\"4\">\n<li>\n<p>在linux中安装erlang环境：</p>\n<pre><code class=\"eye-protector-processed\">yum install erlang\n</code></pre>\n</li>\n</ol>\n</div>\n<div class=\"cl-preview-section\">\n<p>运行后安装成功<br /><img class=\"lazyload\" src=\"data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAAEAAAABCAYAAAAfFcSJAAAAAXNSR0IArs4c6QAAAARnQU1BAACxjwv8YQUAAAAJcEhZcwAADsQAAA7EAZUrDhsAAAANSURBVBhXYzh8+PB/AAffA0nNPuCLAAAAAElFTkSuQmCC\" alt=\"-w698\" data-original=\"https://lee-blog.oss-cn-shanghai.aliyuncs.com/2020/06/17/15922843497752.jpg\" /></p>\n</div>\n<div class=\"cl-preview-section\">\n<ol start=\"5\">\n<li>\n<p>安装完毕erlang以后可以检查一下版本号等信息，如下：<br /><img class=\"lazyload\" src=\"data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAAEAAAABCAYAAAAfFcSJAAAAAXNSR0IArs4c6QAAAARnQU1BAACxjwv8YQUAAAAJcEhZcwAADsQAAA7EAZUrDhsAAAANSURBVBhXYzh8+PB/AAffA0nNPuCLAAAAAElFTkSuQmCC\" alt=\"-w1338\" data-original=\"https://lee-blog.oss-cn-shanghai.aliyuncs.com/2020/06/17/15922844295776.jpg\" /><br /><img class=\"lazyload\" src=\"data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAAEAAAABCAYAAAAfFcSJAAAAAXNSR0IArs4c6QAAAARnQU1BAACxjwv8YQUAAAAJcEhZcwAADsQAAA7EAZUrDhsAAAANSURBVBhXYzh8+PB/AAffA0nNPuCLAAAAAElFTkSuQmCC\" alt=\"-w1328\" data-original=\"https://lee-blog.oss-cn-shanghai.aliyuncs.com/2020/06/17/15922844626891.jpg\" /></p>\n</li>\n<li>\n<p>通过上面的脚本检测，可以看到erlang的版本是符合23.x的<br /><img class=\"lazyload\" src=\"data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAAEAAAABCAYAAAAfFcSJAAAAAXNSR0IArs4c6QAAAARnQU1BAACxjwv8YQUAAAAJcEhZcwAADsQAAA7EAZUrDhsAAAANSURBVBhXYzh8+PB/AAffA0nNPuCLAAAAAElFTkSuQmCC\" alt=\"-w341\" data-original=\"https://lee-blog.oss-cn-shanghai.aliyuncs.com/2020/06/17/15922844820658.jpg\" /></p>\n</li>\n<li>\n<p>那么接下来就要安装rabbitmq-server了，之前的截图里有下面黑色一块内容，这里面需要导入两个key，直接复制一下到linux运行即可：<br /><img class=\"lazyload\" src=\"data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAAEAAAABCAYAAAAfFcSJAAAAAXNSR0IArs4c6QAAAARnQU1BAACxjwv8YQUAAAAJcEhZcwAADsQAAA7EAZUrDhsAAAANSURBVBhXYzh8+PB/AAffA0nNPuCLAAAAAElFTkSuQmCC\" alt=\"-w959\" data-original=\"https://lee-blog.oss-cn-shanghai.aliyuncs.com/2020/06/17/15922845947298.jpg\" /></p>\n<pre><code class=\"eye-protector-processed\">rpm --import https://packagecloud.io/rabbitmq/rabbitmq-server/gpgkey\nrpm --import https://packagecloud.io/gpg.key\n</code></pre>\n</li>\n</ol>\n</div>\n<div class=\"cl-preview-section\">\n<p><img class=\"lazyload\" src=\"data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAAEAAAABCAYAAAAfFcSJAAAAAXNSR0IArs4c6QAAAARnQU1BAACxjwv8YQUAAAAJcEhZcwAADsQAAA7EAZUrDhsAAAANSURBVBhXYzh8+PB/AAffA0nNPuCLAAAAAElFTkSuQmCC\" alt=\"-w1349\" data-original=\"https://lee-blog.oss-cn-shanghai.aliyuncs.com/2020/06/17/15922846862533.jpg\" /><br />导入key成功，不报错就OK。</p>\n</div>\n<div class=\"cl-preview-section\">\n<ol start=\"8\">\n<li>\n<p>然后再为安装<code>rabbitmq-server</code>做一个前置准备：<br /><img class=\"lazyload\" src=\"data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAAEAAAABCAYAAAAfFcSJAAAAAXNSR0IArs4c6QAAAARnQU1BAACxjwv8YQUAAAAJcEhZcwAADsQAAA7EAZUrDhsAAAANSURBVBhXYzh8+PB/AAffA0nNPuCLAAAAAElFTkSuQmCC\" alt=\"-w971\" data-original=\"https://lee-blog.oss-cn-shanghai.aliyuncs.com/2020/06/17/15922847534746.jpg\" /><br />点击红框中的<code>Package Cloud</code>，打开后如下：<br /><img class=\"lazyload\" src=\"data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAAEAAAABCAYAAAAfFcSJAAAAAXNSR0IArs4c6QAAAARnQU1BAACxjwv8YQUAAAAJcEhZcwAADsQAAA7EAZUrDhsAAAANSURBVBhXYzh8+PB/AAffA0nNPuCLAAAAAElFTkSuQmCC\" alt=\"-w1467\" data-original=\"https://lee-blog.oss-cn-shanghai.aliyuncs.com/2020/06/17/15922848249049.jpg\" /><br />拷贝这段命令到linux并且运行：</p>\n<pre><code class=\"eye-protector-processed\">curl -s https://packagecloud.io/install/repositories/rabbitmq/rabbitmq-server/script.rpm.sh | sudo bash\n</code></pre>\n<p><img class=\"lazyload\" src=\"data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAAEAAAABCAYAAAAfFcSJAAAAAXNSR0IArs4c6QAAAARnQU1BAACxjwv8YQUAAAAJcEhZcwAADsQAAA7EAZUrDhsAAAANSURBVBhXYzh8+PB/AAffA0nNPuCLAAAAAElFTkSuQmCC\" alt=\"-w873\" data-original=\"https://lee-blog.oss-cn-shanghai.aliyuncs.com/2020/06/17/15922849620911.jpg\" /><br />提示安装成功，接下来就可以正式安装rabbitmq的安装包了！</p>\n</li>\n<li>\n<p>安装RabbitMQ-Server，找到<code>Download the Server</code>，然后下载红框中的rpm，这个需要安装，下载的时候根据自己的centos版本去下载，我这里用的centos7，那么centos6有点老，centos8太新了。<br /><img class=\"lazyload\" src=\"data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAAEAAAABCAYAAAAfFcSJAAAAAXNSR0IArs4c6QAAAARnQU1BAACxjwv8YQUAAAAJcEhZcwAADsQAAA7EAZUrDhsAAAANSURBVBhXYzh8+PB/AAffA0nNPuCLAAAAAElFTkSuQmCC\" alt=\"-w1053\" data-original=\"https://lee-blog.oss-cn-shanghai.aliyuncs.com/2020/06/17/15922851014522.jpg\" /></p>\n</li>\n<li>\n<p>上传上图中下载的rpm文件到自己的linux系统：<br /><img class=\"lazyload\" src=\"data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAAEAAAABCAYAAAAfFcSJAAAAAXNSR0IArs4c6QAAAARnQU1BAACxjwv8YQUAAAAJcEhZcwAADsQAAA7EAZUrDhsAAAANSURBVBhXYzh8+PB/AAffA0nNPuCLAAAAAElFTkSuQmCC\" alt=\"-w1330\" data-original=\"https://lee-blog.oss-cn-shanghai.aliyuncs.com/2020/06/17/15922860581932.jpg\" /></p>\n</li>\n<li>\n<p>安装rabbitmq-server，运行如下脚本：</p>\n<pre><code class=\"eye-protector-processed\">rpm -ivh rabbitmq-server-3.8.5-1.el7.noarch.rpm\n</code></pre>\n</li>\n</ol>\n</div>\n<div class=\"cl-preview-section\">\n<p>运行后报错：<br /><img class=\"lazyload\" src=\"data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAAEAAAABCAYAAAAfFcSJAAAAAXNSR0IArs4c6QAAAARnQU1BAACxjwv8YQUAAAAJcEhZcwAADsQAAA7EAZUrDhsAAAANSURBVBhXYzh8+PB/AAffA0nNPuCLAAAAAElFTkSuQmCC\" alt=\"-w1391\" data-original=\"https://lee-blog.oss-cn-shanghai.aliyuncs.com/2020/06/17/15922861666614.jpg\" /><br />图中这是说没有key，也没有socat，没关系，装上就行。找到这个位置，然后复制key到命令行中运行：<br /><img class=\"lazyload\" src=\"data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAAEAAAABCAYAAAAfFcSJAAAAAXNSR0IArs4c6QAAAARnQU1BAACxjwv8YQUAAAAJcEhZcwAADsQAAA7EAZUrDhsAAAANSURBVBhXYzh8+PB/AAffA0nNPuCLAAAAAElFTkSuQmCC\" alt=\"-w999\" data-original=\"https://lee-blog.oss-cn-shanghai.aliyuncs.com/2020/06/17/15922862725121.jpg\" /><br />复制到命令行运行导入：<br /><code>rpm --import https://www.rabbitmq.com/rabbitmq-release-signing-key.asc</code></p>\n</div>\n<div class=\"cl-preview-section\">\n<ol start=\"12\">\n<li>\n<p>再次运行安装<code>rabbitmq-server</code>的脚本：</p>\n<pre><code class=\"eye-protector-processed\">rpm -ivh rabbitmq-server-3.8.5-1.el7.noarch.rpm\n</code></pre>\n<p><img class=\"lazyload\" src=\"data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAAEAAAABCAYAAAAfFcSJAAAAAXNSR0IArs4c6QAAAARnQU1BAACxjwv8YQUAAAAJcEhZcwAADsQAAA7EAZUrDhsAAAANSURBVBhXYzh8+PB/AAffA0nNPuCLAAAAAElFTkSuQmCC\" alt=\"-w1155\" data-original=\"https://lee-blog.oss-cn-shanghai.aliyuncs.com/2020/06/17/15922863934260.jpg\" /><br />这个时候提示需要安装<code>socat</code>，运行如下脚本进行安装，安装过程比较慢，耐心等待即可：</p>\n<pre><code class=\"eye-protector-processed\">yum -y install epel-release\nyum -y install socat\n</code></pre>\n<p><img class=\"lazyload\" src=\"data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAAEAAAABCAYAAAAfFcSJAAAAAXNSR0IArs4c6QAAAARnQU1BAACxjwv8YQUAAAAJcEhZcwAADsQAAA7EAZUrDhsAAAANSURBVBhXYzh8+PB/AAffA0nNPuCLAAAAAElFTkSuQmCC\" alt=\"-w625\" data-original=\"https://lee-blog.oss-cn-shanghai.aliyuncs.com/2020/06/17/15922865221440.jpg\" /><br /><img class=\"lazyload\" src=\"data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAAEAAAABCAYAAAAfFcSJAAAAAXNSR0IArs4c6QAAAARnQU1BAACxjwv8YQUAAAAJcEhZcwAADsQAAA7EAZUrDhsAAAANSURBVBhXYzh8+PB/AAffA0nNPuCLAAAAAElFTkSuQmCC\" alt=\"-w643\" data-original=\"https://lee-blog.oss-cn-shanghai.aliyuncs.com/2020/06/17/15922872358603.jpg\" /></p>\n</li>\n<li>\n<p>上面两个安装OK后，随后就再次安装rabbitmq-server</p>\n<pre><code class=\"eye-protector-processed\">rpm -ivh rabbitmq-server-3.8.5-1.el7.noarch.rpm\n</code></pre>\n<p><img class=\"lazyload\" src=\"data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAAEAAAABCAYAAAAfFcSJAAAAAXNSR0IArs4c6QAAAARnQU1BAACxjwv8YQUAAAAJcEhZcwAADsQAAA7EAZUrDhsAAAANSURBVBhXYzh8+PB/AAffA0nNPuCLAAAAAElFTkSuQmCC\" alt=\"-w1188\" data-original=\"https://lee-blog.oss-cn-shanghai.aliyuncs.com/2020/06/17/15922872868118.jpg\" /><br />这个时候如上图，rabbitmq安装完毕！！</p>\n</li>\n</ol>\n</div>\n<div class=\"cl-preview-section\">\n<h3>配置RabbitMQ</h3>\n</div>\n<div class=\"cl-preview-section\">\n<ol>\n<li>\n<p>RMQ已经安装完毕，但是还需要配置一下才能使用。</p>\n</li>\n<li>\n<p>以前的版本是可以直接找到的，现在得去手动复制一下，<a href=\"https://github.com/rabbitmq/rabbitmq-server/blob/master/docs/rabbitmq.conf.example%EF%BC%8C%E8%BF%99%E4%B8%AA%E8%BF%9E%E6%8E%A5%E6%A0%B7%E4%BE%8B%E9%85%8D%E7%BD%AE%E6%96%87%E4%BB%B6\">https://github.com/rabbitmq/rabbitmq-server/blob/master/docs/rabbitmq.conf.example，这个连接样例配置文件</a></p>\n</li>\n<li>\n<p>复制里面的配置内容到本地，重命名为<code>rabbitmq.conf</code>，如下：<br /><img class=\"lazyload\" src=\"data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAAEAAAABCAYAAAAfFcSJAAAAAXNSR0IArs4c6QAAAARnQU1BAACxjwv8YQUAAAAJcEhZcwAADsQAAA7EAZUrDhsAAAANSURBVBhXYzh8+PB/AAffA0nNPuCLAAAAAElFTkSuQmCC\" alt=\"-w296\" data-original=\"https://lee-blog.oss-cn-shanghai.aliyuncs.com/2020/06/17/15922896101335.jpg\" /></p>\n</li>\n<li>\n<p>然后修改文件内容，务必注意，大括号最后没有<code>逗号</code>：<br /><img class=\"lazyload\" src=\"data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAAEAAAABCAYAAAAfFcSJAAAAAXNSR0IArs4c6QAAAARnQU1BAACxjwv8YQUAAAAJcEhZcwAADsQAAA7EAZUrDhsAAAANSURBVBhXYzh8+PB/AAffA0nNPuCLAAAAAElFTkSuQmCC\" alt=\"-w855\" data-original=\"https://lee-blog.oss-cn-shanghai.aliyuncs.com/2020/06/17/15922898292531.jpg\" /><br />这个是代表运行 guest 默认用户可以在非本地环境登录</p>\n</li>\n<li>\n<p>上传配置文件到rabbitmq目录：<br /><img class=\"lazyload\" src=\"data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAAEAAAABCAYAAAAfFcSJAAAAAXNSR0IArs4c6QAAAARnQU1BAACxjwv8YQUAAAAJcEhZcwAADsQAAA7EAZUrDhsAAAANSURBVBhXYzh8+PB/AAffA0nNPuCLAAAAAElFTkSuQmCC\" alt=\"-w249\" data-original=\"https://lee-blog.oss-cn-shanghai.aliyuncs.com/2020/06/17/15922899437114.jpg\" /><br /><img class=\"lazyload\" src=\"data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAAEAAAABCAYAAAAfFcSJAAAAAXNSR0IArs4c6QAAAARnQU1BAACxjwv8YQUAAAAJcEhZcwAADsQAAA7EAZUrDhsAAAANSURBVBhXYzh8+PB/AAffA0nNPuCLAAAAAElFTkSuQmCC\" alt=\"-w910\" data-original=\"https://lee-blog.oss-cn-shanghai.aliyuncs.com/2020/06/17/15922899706402.jpg\" /></p>\n</li>\n<li>\n<p>随后启用rabbitmq的管理平台插件，启用以后会在/etc/rabbitmq 目录下多出一个 enabled_plugins，字面意思应该能理解，不多说，就是开启插件<br /><img class=\"lazyload\" src=\"data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAAEAAAABCAYAAAAfFcSJAAAAAXNSR0IArs4c6QAAAARnQU1BAACxjwv8YQUAAAAJcEhZcwAADsQAAA7EAZUrDhsAAAANSURBVBhXYzh8+PB/AAffA0nNPuCLAAAAAElFTkSuQmCC\" alt=\"-w1159\" data-original=\"https://lee-blog.oss-cn-shanghai.aliyuncs.com/2020/06/17/15922901110908.jpg\" /></p>\n</li>\n<li>\n<p>到此配置全部结束，最后一步就是启动rabbitmq server了</p>\n<pre><code class=\"eye-protector-processed\">service rabbitmq-server start\n</code></pre>\n<p>启动以后报错，真是坑。。。<br /><img class=\"lazyload\" src=\"data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAAEAAAABCAYAAAAfFcSJAAAAAXNSR0IArs4c6QAAAARnQU1BAACxjwv8YQUAAAAJcEhZcwAADsQAAA7EAZUrDhsAAAANSURBVBhXYzh8+PB/AAffA0nNPuCLAAAAAElFTkSuQmCC\" alt=\"-w1394\" data-original=\"https://lee-blog.oss-cn-shanghai.aliyuncs.com/2020/06/17/15922904201937.jpg\" /></p>\n</li>\n<li>\n<p>遇到坑不要怕，尝试自己去解决就行，输入命令行：</p>\n<pre><code class=\"eye-protector-processed\">journalctl -xe\n</code></pre>\n</li>\n</ol>\n</div>\n<div class=\"cl-preview-section\">\n<p>然后有这么一句话，说是节点<code>rabbit</code>没有启动，连不上，看一下图中内容，连接到某个端口不行，看到端口第一反应就是<code>端口占用</code>，检查一下<br /><img class=\"lazyload\" src=\"data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAAEAAAABCAYAAAAfFcSJAAAAAXNSR0IArs4c6QAAAARnQU1BAACxjwv8YQUAAAAJcEhZcwAADsQAAA7EAZUrDhsAAAANSURBVBhXYzh8+PB/AAffA0nNPuCLAAAAAElFTkSuQmCC\" alt=\"-w653\" data-original=\"https://lee-blog.oss-cn-shanghai.aliyuncs.com/2020/06/17/15922924300178.jpg\" /><br />检查端口：<br /><img class=\"lazyload\" src=\"data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAAEAAAABCAYAAAAfFcSJAAAAAXNSR0IArs4c6QAAAARnQU1BAACxjwv8YQUAAAAJcEhZcwAADsQAAA7EAZUrDhsAAAANSURBVBhXYzh8+PB/AAffA0nNPuCLAAAAAElFTkSuQmCC\" alt=\"-w1259\" data-original=\"https://lee-blog.oss-cn-shanghai.aliyuncs.com/2020/06/17/15922925120057.jpg\" /><br />然后kill进程<br /><img class=\"lazyload\" src=\"data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAAEAAAABCAYAAAAfFcSJAAAAAXNSR0IArs4c6QAAAARnQU1BAACxjwv8YQUAAAAJcEhZcwAADsQAAA7EAZUrDhsAAAANSURBVBhXYzh8+PB/AAffA0nNPuCLAAAAAElFTkSuQmCC\" alt=\"-w579\" data-original=\"https://lee-blog.oss-cn-shanghai.aliyuncs.com/2020/06/17/15922925379896.jpg\" /></p>\n</div>\n<div class=\"cl-preview-section\">\n<ol start=\"9\">\n<li>\n<p>最后再次重启RabbitMQ</p>\n<pre><code class=\"eye-protector-processed\">service rabbitmq-server start\n</code></pre>\n</li>\n<li>\n<p>这个时候又报错了，，，看一下吧，配置文件格式有问题，我们之前增加了一行配置，是用guest，那么现在我们注释掉<br /><img class=\"lazyload\" src=\"data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAAEAAAABCAYAAAAfFcSJAAAAAXNSR0IArs4c6QAAAARnQU1BAACxjwv8YQUAAAAJcEhZcwAADsQAAA7EAZUrDhsAAAANSURBVBhXYzh8+PB/AAffA0nNPuCLAAAAAElFTkSuQmCC\" alt=\"-w1428\" data-original=\"https://lee-blog.oss-cn-shanghai.aliyuncs.com/2020/06/17/15922926532081.jpg\" /></p>\n</li>\n<li>\n<p>注释以后重启，矮油居然可以启动成功了：<br /><img class=\"lazyload\" src=\"data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAAEAAAABCAYAAAAfFcSJAAAAAXNSR0IArs4c6QAAAARnQU1BAACxjwv8YQUAAAAJcEhZcwAADsQAAA7EAZUrDhsAAAANSURBVBhXYzh8+PB/AAffA0nNPuCLAAAAAElFTkSuQmCC\" alt=\"-w904\" data-original=\"https://lee-blog.oss-cn-shanghai.aliyuncs.com/2020/06/17/15922930463774.jpg\" /><br /><img class=\"lazyload\" src=\"data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAAEAAAABCAYAAAAfFcSJAAAAAXNSR0IArs4c6QAAAARnQU1BAACxjwv8YQUAAAAJcEhZcwAADsQAAA7EAZUrDhsAAAANSURBVBhXYzh8+PB/AAffA0nNPuCLAAAAAElFTkSuQmCC\" alt=\"-w729\" data-original=\"https://lee-blog.oss-cn-shanghai.aliyuncs.com/2020/06/17/15922931554341.jpg\" /></p>\n</li>\n<li>\n<p>打开默认的mq管理界面，用户名密码默认都是guest，登录提示说该用户只能在localhost中登录，也就是只能在虚拟机里登录。<br /><img class=\"lazyload\" src=\"data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAAEAAAABCAYAAAAfFcSJAAAAAXNSR0IArs4c6QAAAARnQU1BAACxjwv8YQUAAAAJcEhZcwAADsQAAA7EAZUrDhsAAAANSURBVBhXYzh8+PB/AAffA0nNPuCLAAAAAElFTkSuQmCC\" alt=\"-w796\" data-original=\"https://lee-blog.oss-cn-shanghai.aliyuncs.com/2020/06/17/15922930989170.jpg\" /></p>\n</li>\n<li>\n<p>在配置文件中看到这么一句话，想要让guest用户在任何地方都能有权限访问，则把注释去了，那么现在去了试试看，不要忘记重启mq服务<br /><img class=\"lazyload\" src=\"data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAAEAAAABCAYAAAAfFcSJAAAAAXNSR0IArs4c6QAAAARnQU1BAACxjwv8YQUAAAAJcEhZcwAADsQAAA7EAZUrDhsAAAANSURBVBhXYzh8+PB/AAffA0nNPuCLAAAAAElFTkSuQmCC\" alt=\"-w840\" data-original=\"https://lee-blog.oss-cn-shanghai.aliyuncs.com/2020/06/17/15922934080033.jpg\" /><br /><img class=\"lazyload\" src=\"data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAAEAAAABCAYAAAAfFcSJAAAAAXNSR0IArs4c6QAAAARnQU1BAACxjwv8YQUAAAAJcEhZcwAADsQAAA7EAZUrDhsAAAANSURBVBhXYzh8+PB/AAffA0nNPuCLAAAAAElFTkSuQmCC\" alt=\"-w718\" data-original=\"https://lee-blog.oss-cn-shanghai.aliyuncs.com/2020/06/17/15922934912581.jpg\" /></p>\n</li>\n<li>\n<p>OK了，这个时候可以登录进去，也就是说现在新版本的mq对guest的开放访问形式和以往不同了，很坑，这一点需要注意<br /><img class=\"lazyload\" src=\"data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAAEAAAABCAYAAAAfFcSJAAAAAXNSR0IArs4c6QAAAARnQU1BAACxjwv8YQUAAAAJcEhZcwAADsQAAA7EAZUrDhsAAAANSURBVBhXYzh8+PB/AAffA0nNPuCLAAAAAElFTkSuQmCC\" alt=\"-w1846\" data-original=\"https://lee-blog.oss-cn-shanghai.aliyuncs.com/2020/06/17/15922935280467.jpg\" /></p>\n</li>\n<li>\n<p>添加新的管理员用户admin：<br /><img class=\"lazyload\" src=\"data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAAEAAAABCAYAAAAfFcSJAAAAAXNSR0IArs4c6QAAAARnQU1BAACxjwv8YQUAAAAJcEhZcwAADsQAAA7EAZUrDhsAAAANSURBVBhXYzh8+PB/AAffA0nNPuCLAAAAAElFTkSuQmCC\" alt=\"-w975\" data-original=\"https://lee-blog.oss-cn-shanghai.aliyuncs.com/2020/06/17/15922936642592.jpg\" /></p>\n</li>\n<li>\n<p>给admin提供权限<br /><img class=\"lazyload\" src=\"data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAAEAAAABCAYAAAAfFcSJAAAAAXNSR0IArs4c6QAAAARnQU1BAACxjwv8YQUAAAAJcEhZcwAADsQAAA7EAZUrDhsAAAANSURBVBhXYzh8+PB/AAffA0nNPuCLAAAAAElFTkSuQmCC\" alt=\"-w589\" data-original=\"https://lee-blog.oss-cn-shanghai.aliyuncs.com/2020/06/17/15922937241182.jpg\" /></p>\n</li>\n<li>\n<p>直接点击set即可<br /><img class=\"lazyload\" src=\"data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAAEAAAABCAYAAAAfFcSJAAAAAXNSR0IArs4c6QAAAARnQU1BAACxjwv8YQUAAAAJcEhZcwAADsQAAA7EAZUrDhsAAAANSURBVBhXYzh8+PB/AAffA0nNPuCLAAAAAElFTkSuQmCC\" alt=\"-w1145\" data-original=\"https://lee-blog.oss-cn-shanghai.aliyuncs.com/2020/06/17/15922937606723.jpg\" /><br /><img class=\"lazyload\" src=\"data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAAEAAAABCAYAAAAfFcSJAAAAAXNSR0IArs4c6QAAAARnQU1BAACxjwv8YQUAAAAJcEhZcwAADsQAAA7EAZUrDhsAAAANSURBVBhXYzh8+PB/AAffA0nNPuCLAAAAAElFTkSuQmCC\" alt=\"-w542\" data-original=\"https://lee-blog.oss-cn-shanghai.aliyuncs.com/2020/06/17/15922937796844.jpg\" /></p>\n</li>\n</ol>\n</div>\n<div class=\"cl-preview-section\">\n<h3>小节</h3>\n</div>\n<div class=\"cl-preview-section\">\n<p>欧了，RabbitMQ 搞定安装完毕，装mq是一直以来很糟心的事，一不小心就失败。后续空了录个视频，会发出来。</p>\n</div>\n<div class=\"cl-preview-section\">\n<p>另外关于rabbitmq更多配置信息可以参考如下链接：<a href=\"https://www.rabbitmq.com/configure.html\">https://www.rabbitmq.com/configure.html</a></p>\n</div>\n<p><br />作者：风间影月<br />链接：https://www.imooc.com/article/305858<br />来源：慕课网</p>', 'http://hire.t.mukewang.com/static/photo/article/cover/ec92259a-af7e-4394-bf13-4adfdeed75bb.png', '1001', '2022-08-19 11:50:50', 'admin', 'http://hire.t.mukewang.com/static/adminFace/644842e3-0173-42c0-a7a9-abdba09c358b.png', 1, '2022-08-19 11:50:58', '2022-08-19 11:51:08');
INSERT INTO `article` VALUES ('1560474465501564930', '非HTTP状态下开启web视频的临时方案', '<div class=\"cl-preview-section\">\n<div class=\"cl-preview-section\">\n<p>新版本的chrome在调用摄像头的时候，会有安全警告，所以调用摄像头的js方法就无法使用了，如下：<br /><img class=\"\" src=\"https://img1.sycdn.imooc.com/5e9bdabe000140df32080140.jpg\" alt=\"-w1604\" data-original=\"https://img1.sycdn.imooc.com/5e9bdabe000140df32080140.jpg\" /><br />意思是保证安全，你要在HTTPS的情况下，才能调用浏览器摄像头。但是我们平时开发的时候，本地环境往往没有HTTPS，如何解决呢？</p>\n</div>\n<div class=\"cl-preview-section\">\n<h3>禁用浏览器默认安全模式</h3>\n</div>\n<div class=\"cl-preview-section\">\n<p>复制如下命令到浏览器的地址栏：<br />chrome://flags/#unsafely-treat-insecure-origin-as-secure<br />如下图，找到黄色部分，然后enabled开启，并且把你自己本地模拟的域名放进去，如此就增加了白名单。设置好需要重启浏览器。<br /><img class=\"\" src=\"https://img1.sycdn.imooc.com/5e9bdabf0001387824260560.jpg\" alt=\"-w1213\" data-original=\"https://img1.sycdn.imooc.com/5e9bdabf0001387824260560.jpg\" /></p>\n</div>\n<div class=\"cl-preview-section\">\n<p>回到浏览器测试视频，结果OK，如下：<br /><img class=\"\" src=\"https://img3.sycdn.imooc.com/5e9bdac00001dae518560728.jpg\" alt=\"-w928\" data-original=\"https://img3.sycdn.imooc.com/5e9bdac00001dae518560728.jpg\" /></p>\n</div>\n<div class=\"cl-preview-section\">\n<p>电脑上的绿色点表示摄像头打开。<br /><img class=\"\" src=\"https://img1.sycdn.imooc.com/5e9bdac10001548309840494.jpg\" alt=\"-w492\" data-original=\"https://img1.sycdn.imooc.com/5e9bdac10001548309840494.jpg\" /></p>\n</div>\n<h3><br />作者：风间影月<br />链接：https://www.imooc.com/article/303483<br />来源：慕课网</h3>\n</div>', 'http://hire.t.mukewang.com/static/photo/article/cover/d1874698-dce4-4b52-992a-f4fe0db76fd6.png', '1001', '2022-08-19 11:51:03', 'admin', 'http://hire.t.mukewang.com/static/adminFace/644842e3-0173-42c0-a7a9-abdba09c358b.png', 1, '2022-08-19 11:51:19', '2022-08-19 11:51:29');
INSERT INTO `article` VALUES ('1560474567192465409', '人人都要关注的分布式系统中的CAP理论', '<div class=\"cl-preview-section\">\n<div class=\"cl-preview-section\">\n<div class=\"cl-preview-section\">\n<h3>分布式系统</h3>\n</div>\n<div class=\"cl-preview-section\">\n<p>相信大家看过我的文章或者视频的，都应该知道什么是分布式系统，分布式系统就是一个系统由多个组成部分共同构成，用户的一个请求可能会经过多个不同的计算机节点之后，通过运算才会把结果响应给用户，那么这个请求所经过的不同的几个系统就是分布式系统。对于用户来讲，你是不是分布式系统，对他来讲是透明的。参考如下图：<br /><img class=\"\" src=\"https://img4.sycdn.imooc.com/5e78a6370001e86c10400214.jpg\" alt=\"-w520\" data-original=\"https://img4.sycdn.imooc.com/5e78a6370001e86c10400214.jpg\" /><br />图中就表示一个用户在经历下单过程会经过多个系统，他们是分布式的，共同组成一个整体。</p>\n</div>\n<div class=\"cl-preview-section\">\n<h3>CAP 概念</h3>\n</div>\n<div class=\"cl-preview-section\">\n<p>在分布式系统中，必定会遇到CAP，如下：</p>\n</div>\n<div class=\"cl-preview-section\">\n<ul>\n<li>\n<p>C（Consistency）：一致性</p>\n<ul>\n<li>在分布式系统中，所有的计算机节点的数据在同一时刻都是相同的，数据都是一致的。不能因为分布式导致不同系统拿到的数据不一致。也就是说，用户在某一个节点写了数据，在其他节点获得该数据的值是最新的；如若是更新操作，那么所有用户看到的也是更新后的新的值，不论哪个节点，不论集群，不论主备，获得的数据都是相同的。\n<ul>\n<li>如下图：共有5个节点，往A节点去写，那么其他节点的数据在同一时间都是相同的，其他用户读取的时候也都是相同的，数据的一致性很强。<br /><img class=\"\" src=\"https://img3.sycdn.imooc.com/5e78a6380001d7f811780942.jpg\" alt=\"-w589\" data-original=\"https://img3.sycdn.imooc.com/5e78a6380001d7f811780942.jpg\" /></li>\n</ul>\n</li>\n</ul>\n</li>\n<li>\n<p>A（Availability）：可用性</p>\n<ul>\n<li>保证你的系统可用，也就是说无论任何时候，系统都可以被用户访问到，用户可以获得正常的响应结果。比如做好集群啊，做好主备啊等等，这个就是高可用。\n<ul>\n<li>如下图：集群是一个整体，不论是否有节点宕机，那么作为整体，他还是可以继续对外提供服务的，保证了系统的可用性。<br /><img class=\"\" src=\"https://img3.sycdn.imooc.com/5e78a63800012c0f11700930.jpg\" alt=\"-w585\" data-original=\"https://img3.sycdn.imooc.com/5e78a63800012c0f11700930.jpg\" /></li>\n</ul>\n</li>\n</ul>\n</li>\n<li>\n<p>P（Partition tolerance）：分区容错性</p>\n<ul>\n<li>在整个分布式系统中，我们都是部署在不同的节点上，或者是不同的机房甚至是不同的地域，部署的时候会有一些子网，某一些服务会部署在不同的子网，每个子网就是一个区，也就是网络分区，分区和分区之间的通信也有可能出现通信故障。某个节点或者网络或者地域（分区）出现问题，整体整个系统还是照样能够提供一致性和可用性的服务。也就是说部分系统故障不会影响整体。为什么会这样，主要是因为有程序bug，计算机硬件问题，网络问题，网线被挖断了等等造成的综合因素。所以呢，我们的诉求就是即使小部分出问题，也要保全整体。并且对于任何分布式系统来讲，都需要去考虑分区容错的问题。</li>\n<li>附，以腾讯云为例，图中就有两处不同分区，第一个是在上海这个地域有不同的区域，不同区域通信走公网，可能有通信故障。其次就是私有网络，也就是子网络，他可以创建很多个，自己去定义不同的网段ip。<br /><img class=\"\" src=\"https://img4.sycdn.imooc.com/5e78a6390001acb209160934.jpg\" alt=\"-w458\" data-original=\"https://img4.sycdn.imooc.com/5e78a6390001acb209160934.jpg\" /></li>\n</ul>\n</li>\n</ul>\n</div>\n<div class=\"cl-preview-section\">\n<h3>CAP 无法同时满足</h3>\n</div>\n<div class=\"cl-preview-section\">\n<p>如果从理论上来讲，以上三点C/A/P都应该满足吧，但是系统是人开发的，那肯定会或多或少有各种各样的问题。在分布式系统中同时满足这三点是不可能的。所以对于CAP来讲，只能满足其中两者，要么AP，要么CP，要么CA。如下图：<br /><img class=\"\" src=\"https://img1.sycdn.imooc.com/5e78a63900019f7c11781158.jpg\" alt=\"-w589\" data-original=\"https://img1.sycdn.imooc.com/5e78a63900019f7c11781158.jpg\" /></p>\n</div>\n<div class=\"cl-preview-section\">\n<p>为什么会这样呢？我们举一个例子，来看一下CAP能不能同时满足，如下图：<br /><img class=\"\" src=\"https://img4.sycdn.imooc.com/5e78a63900019d0012440900.jpg\" alt=\"-w622\" data-original=\"https://img4.sycdn.imooc.com/5e78a63900019d0012440900.jpg\" /><br />上图中，ABCDE这5个节点都是分别部署在不同地域的机房的节点，假设现在我们的分区容错性P做的很好，保证不会出现网络方面的故障，这个时候我们来看一下一致性C和可用性A。现在有一个请求把数据写入到了A节点，随后用户的下一个请求要访问B节点，那么由于他们之间在不同的地域，数据同步需要有时间延迟，可能几百毫秒可能1-2秒。那么读请求要请求到一致的数据，就会被阻塞，阻塞的时候当前这个系统就不可用了，因为数据同步需要时间，所以此时的可用性A就无法满足，只能满足CP；那么再来看，假设要满足系统可用性，那么请求读到的数据，在节点同步的过程中就会是一个老的数据，数据就不能达到一致性C，所以这个时候就是AP。OK不？那么我们平时开发系统倒是在C和A之间取其一来搭配P的</p>\n</div>\n<div class=\"cl-preview-section\">\n<h3>组合搭配</h3>\n</div>\n<div class=\"cl-preview-section\">\n<p>那么 CP,AP,CA，这三种，哪个好呢？</p>\n</div>\n<div class=\"cl-preview-section\">\n<ul>\n<li>CP：满足一致性和分区容错的系统，性能不会很高，因为一致性是时时保持的。就比如说我提交一个订单，这个订单的数据要同步到各个系统，保证强一致性。那么这样用户请求大多都会被阻塞。需要耗时等待。redis，mongodb，hbase都是CP。（redis集群如果一个主节点挂了，那么slave成为master，他会有一个时间段导致不可用，A不满足）</li>\n<li>CA：满足一致性，满足可用性，一般来说都是以单体存在的集群架构，可扩展性不高。一般都是关系型数据库。</li>\n<li><code>AP</code>：满足可用性和分区容错，那么这样就不是一致性了，往往会采用弱一致性，或者最终一致性。这也是通常用的最多的。 我们平时开发的系统就是以AP来展开工作的。</li>\n</ul>\n</div>\n<div class=\"cl-preview-section\">\n<p>对于我们平时开发的时候，<code>分区容错P</code>是一定要满足的，因为我们在部署的时候往往都都是多节点集群部署，设置异地互备，比如北京机房和机房都提供服务 ，所以，一定要容错。</p>\n</div>\n<div class=\"cl-preview-section\">\n<p>那么接下来我们要抉择<code>一致性</code>还是<code>可用性</code>呢？<br />一般来说，往往我们在大家网站架构的时候，我们都会采用AP，主流的互联网公司也是如此，也就是数据的弱一致性，因为要保证系统的整体的高可用性以及容错性。啥叫弱一致性，比如我们经常看头条，头条的点赞数评论数或者微博粉丝数，具体的数值每个人浏览的时候可能不一样，这个其实无所谓的，这就是弱一致性。而像Redis啊MongoDB这样的中间件，是CP，也就是要保证数据的一致性，因为毕竟要为网站提供数据服务的，一致性必须满足。</p>\n</div>\n<div class=\"cl-preview-section\">\n<h3>关于弱一致性</h3>\n</div>\n<div class=\"cl-preview-section\">\n<p>其实现在的互联网环境里，很多项目都不会采用强一致性，因为很难做，而往往采用弱一致性，因为用户可以接受。比如双11或者618的时候，订单蹭蹭蹭的海量增加，我们只需要关注订单下单成功就行，具体多少订单，具体多少金额，我们不会去实时的统计计算的，因为没必要，会在高峰期过后逐步去统计，慢慢的实现一致性。那么这个就是目前主流的做法。</p>\n</div>\n<div class=\"cl-preview-section\">\n<p>但是一定要注意，数据层面的交互，关系型数据库，redis，mongodb等，他们肯定是强一致性，因为需要提供给你的网站数据服务。</p>\n</div>\n<div class=\"cl-preview-section\">\n<p>其实呢，我们在互联网环境里，往往会采用BASE理论，<br />Base = Basically Available Soft-state Eventually-Consistent<br />也就是达到基本可用软状态的最终一致性。它是比较平衡了CAP后得到的结论，这也是绝大多数互联网系统实践后的一个结果，他主要的核心思想就是忽略强一致性，使用弱一致性来达到最终一致。</p>\n</div>\n<p><br />作者：风间影月<br />链接：https://www.imooc.com/article/302353<br />来源：慕课网</p>\n</div>\n</div>', 'http://hire.t.mukewang.com/static/photo/article/cover/093e07c9-a3c3-45eb-a364-7b59bc514720.png', '1001', '2022-08-19 11:51:24', 'admin', 'http://hire.t.mukewang.com/static/adminFace/644842e3-0173-42c0-a7a9-abdba09c358b.png', 1, '2022-08-19 11:51:44', '2022-08-19 11:51:54');
INSERT INTO `article` VALUES ('1560474729113571330', 'Hystrix 简单聊聊断路器/熔断器', '<div class=\"cl-preview-section\">\n<div class=\"cl-preview-section\">\n<div class=\"cl-preview-section\">\n<div class=\"cl-preview-section\">\n<h3>什么是Hystrix</h3>\n</div>\n<div class=\"cl-preview-section\">\n<p>Hystrix 在SpringCloud中负责服务熔断服务降级的作用。<br />Hystrix 存在的目的也是为了防止过多超时导致系统瘫痪。比如多个服务之间的相互调用，如下图：<br /><img class=\"\" src=\"https://img4.sycdn.imooc.com/5e6f1af80001209615141138.jpg\" alt=\"-w757\" data-original=\"https://img4.sycdn.imooc.com/5e6f1af80001209615141138.jpg\" /></p>\n</div>\n<div class=\"cl-preview-section\">\n<blockquote>\n<p>订单-&gt;商品-&gt;积分-&gt;日志<br />订单-&gt;支付-&gt;日志<br />商品-&gt;风控-&gt;日志<br />服务之间相互调用，假设某个链路上的某个服务比如日志服务超时了，不可被调用，那么其他的服务全部卡死，导致崩溃。</p>\n</blockquote>\n</div>\n<div class=\"cl-preview-section\">\n<p>举一个生活中的例子：<br /><img class=\"\" src=\"https://img3.sycdn.imooc.com/5e6f1af9000134a515341060.jpg\" alt=\"-w767\" data-original=\"https://img3.sycdn.imooc.com/5e6f1af9000134a515341060.jpg\" /><br />在家里，我开了很多电器，这个时候如果没有一个保护装置的话，由于某个电器过载，最终会导致整个电路断掉，那么每户人家肯定会有一个装置叫做<code>保险丝</code>，那么Hystrix断路器就起到了保险丝的作用，他可以保护整个系统。<br />Hystrix在分布式系统或者微服务中，一旦出现了超时或者依赖服务不可用调用失败异常等情况，他能够保证整个系统不会整体宕机崩溃，从而提高整个系统的健壮性。</p>\n</div>\n<div class=\"cl-preview-section\">\n<p>Hystrix的原理就是当某一个服务发生故障的时候，这个时候是不会有任何的正常响应的，但是通过Hystrix可以返回一个备用响应，也就是所谓的backup，如此一来，发生异常的系统就不会造成不必要的超时等异常现象，这就好比打篮球，上场必须要5人，但是如果有人受伤要下场，这个时候就必须要有backup球员，如果没有，这个球队很难进行比赛了。</p>\n</div>\n<div class=\"cl-preview-section\">\n<blockquote>\n<p>简单一句话总结，就是Hystrix可以保证在众多微服务中一个服务出现了问题不会引发整体系统奔溃的一个开源组件。</p>\n</blockquote>\n</div>\n<div class=\"cl-preview-section\">\n<h3>服务熔断</h3>\n</div>\n<div class=\"cl-preview-section\">\n<p>熔断是一种微服务链路的保护机制，当某个服务（依赖）不可用/宕机/超时/异常的时候，会进行服务的熔断（是一个开关，会开启），这个发生故障的节点就被<code>熔断了</code>也就是不可用，不会再让用户调用到，那么此时就需要降级，来直接会返回一个错误的异常响应信息。当这个节点OK恢复了，hystrix会检测到，然后再把他恢复到整个链路。</p>\n</div>\n<div class=\"cl-preview-section\">\n<blockquote>\n<p>熔断机制在很多行业里都有，比如股市，金融行业，都是为了更好更有效的控制，把损失控制在一定的范围内。</p>\n</blockquote>\n</div>\n<div class=\"cl-preview-section\">\n<h3>代码演示</h3>\n</div>\n<div class=\"cl-preview-section\">\n<ul>\n<li>pom 中加入依赖</li>\n</ul>\n</div>\n<div class=\"cl-preview-section\">\n<pre><code>&lt;dependency&gt;\n			&lt;groupId&gt;org.springframework.cloud&lt;/groupId&gt;\n			&lt;artifactId&gt;spring-cloud-starter-netflix-hystrix&lt;/artifactId&gt;\n		&lt;/dependency&gt;\n</code></pre>\n</div>\n<div class=\"cl-preview-section\">\n<ul>\n<li>启动类开启熔断器</li>\n</ul>\n</div>\n<div class=\"cl-preview-section\">\n<pre><code>@EnableCircuitBreaker\n</code></pre>\n</div>\n<div class=\"cl-preview-section\">\n<ul>\n<li>编写错误的controller</li>\n</ul>\n</div>\n<div class=\"cl-preview-section\">\n<pre><code>// 一旦服务调用失败，发生异常，会调用@HystrixCommand中的[graceDisplay]方法，这个方法就是兜底方法\n    @HystrixCommand(fallbackMethod = \"graceDisplay\")\n    public String helloHystrix() {\n\n        Object o = \"Hello hystrix~\";\n\n        int a = 1 / 0;\n\n        return \"Hello hystrix~\";\n    }\n\n    public String graceDisplay() {\n        return \"Hello another me~\";\n    }\n</code></pre>\n</div>\n<div class=\"cl-preview-section\">\n<ul>\n<li>测试：\n<ol>\n<li>\n<p>如果正常访问，显示&nbsp;<code>Hello hystrix~</code></p>\n</li>\n<li>\n<p>发生异常熔断，则展示：</p>\n<p><img class=\"\" src=\"https://img1.sycdn.imooc.com/5e6f1af90001723508320232.jpg\" alt=\"-w416\" data-original=\"https://img1.sycdn.imooc.com/5e6f1af90001723508320232.jpg\" /></p>\n</li>\n</ol>\n</li>\n</ul>\n</div>\n<div class=\"cl-preview-section\">\n<h3>服务器降级</h3>\n</div>\n<div class=\"cl-preview-section\">\n<p>当某个服务资源不够的时候，可以启用降级处理。</p>\n</div>\n<div class=\"cl-preview-section\">\n<p>举一个例子，如下图：<br /><img class=\"\" src=\"https://img1.sycdn.imooc.com/5e6f1afa0001d9e414481130.jpg\" alt=\"-w724\" data-original=\"https://img1.sycdn.imooc.com/5e6f1afa0001d9e414481130.jpg\" /><br />假设我们家里用很多电器，其他电器正在使用中并且占用的电流啊电压啥的很大，空调我这个时候可以不用，把资源给到其他的电器，这时我们是直接把空调插头拔出，区别于熔断，熔断的话是发生异常后和谐的响应信息，而降级是我把这个服务关停了，随后在响应给用户。需要注意，由于服务关闭了，所以响应是发生在调用方的，也就是客户端，比如图中的<code>电热水壶</code>和<code>微波炉</code>。当电压电流恢复后，我们再把空调插头插上即可，那么这就是降级的一种方式。</p>\n</div>\n<div class=\"cl-preview-section\">\n<p>那么熔断和降级的异同点是啥呢？</p>\n</div>\n<div class=\"cl-preview-section\">\n<ul>\n<li>相同点：\n<ul>\n<li>都是为了提升系统的可靠性</li>\n<li>都为了正确的返回响应给用户</li>\n</ul>\n</li>\n<li>不同点：\n<ul>\n<li>熔断：被调用的服务方（下游）发生故障导致</li>\n<li>降级：全局整体服务负载过高，有效调动资源服务，由调用方（上游）控制</li>\n</ul>\n</li>\n</ul>\n</div>\n<div class=\"cl-preview-section\">\n<h3>熔断解耦分离</h3>\n</div>\n<div class=\"cl-preview-section\">\n<p>当使用<code>@HystrixCommand</code>的时候，每有一个controller的接口api，就会有一个熔断方法，这是成倍的增长的，数量会很多，维护不方便，所以需要解耦开来。而且，当我们关闭不用的微服务时，上游还是会调用下游，所以我们需要在上游服务这块，去增加降级的方法，如果服务无法调用，则调用上游服务中的降级方法即可。并且下游服务如果被我们关闭，上游的调用还是可以有响应给用户的。</p>\n</div>\n<div class=\"cl-preview-section\">\n<pre><code>@Component\npublic class HystrixFactoryCallback implements FallbackFactory&lt;HystrixFactoryControllerApi&gt; {\n\n    @Override\n    public HystrixFactoryControllerApi create(Throwable throwable) {\n        return new HystrixFactoryControllerApi() {\n            @Override\n            public String helloFactory() {\n                return \"优雅的处理，只在客户端直接返回，下游服务关闭不影响\";\n            }\n        };\n    }\n}\n\n</code></pre>\n</div>\n<div class=\"cl-preview-section\">\n<pre><code>\n@FeignClient(value = EurekaServiceList.SERVICE_HYSTRIX, fallbackFactory = HystrixFactoryCallback.class)\npublic interface HystrixFactoryControllerApi {\n\n    // 当前类的所有接口只要有问题都会被HystrixFactoryCallback给处理\n\n// 测试hystrix降级解耦\n    @GetMapping(\"/helloFactory\")\n    public String helloFactory();\n}\n\n</code></pre>\n</div>\n<div class=\"cl-preview-section\">\n<pre><code>spring:\n  main:\n    allow-bean-definition-overriding: true    # 允许 @FeignClient 同名\n\nfeign:\n  hystrix:\n    enabled: true   # 开启@FeignClient的降级功能 fallbackFactory\n</code></pre>\n</div>\n<div class=\"cl-preview-section\">\n<p>上游：</p>\n</div>\n<div class=\"cl-preview-section\">\n<pre><code>\n    @Autowired\n    HystrixFactoryControllerApi hystrixFactoryControllerApi;\n    \n        @GetMapping(\"/testHystrixFactoryApi\")\n    public Object testHystrixFactoryApi() {\n        String result = hystrixFactoryControllerApi.helloFactory();\n        return result;\n    }\n</code></pre>\n</div>\n<div class=\"cl-preview-section\">\n<p>下游：</p>\n</div>\n<div class=\"cl-preview-section\">\n<pre><code>@RestController\npublic class FactoryController implements HystrixFactoryControllerApi {\n\n    @Override\n    public String helloFactory() {\n        Object o = \"Hello hystrix factory~\";\n\n        int a = 1 / 0;\n\n        return \"Hello hystrix factory~\";\n    }\n}\n\n</code></pre>\n</div>\n<div class=\"cl-preview-section\">\n<h3>简单总结一下</h3>\n</div>\n<div class=\"cl-preview-section\">\n<p>熔断：当一个服务发生故障异常，这个时候熔断当前整个服务，把这个服务变的不可被访问，而不是客户端请求这个服务的时候一直处于超时。<br />降级：当服务熔断后，我们需要提供新的一个兜底接口返回响应数据，如此一来，客户端能够友好的接受到响应消息。</p>\n</div>\n<h3><br />作者：风间影月<br />链接：https://www.imooc.com/article/302031<br />来源：慕课网</h3>\n</div>\n</div>\n</div>', 'http://hire.t.mukewang.com/static/photo/article/cover/a6e074f1-0806-459a-8278-288ce7db619f.png', '1001', '2022-08-19 11:51:50', 'admin', 'http://hire.t.mukewang.com/static/adminFace/644842e3-0173-42c0-a7a9-abdba09c358b.png', 1, '2022-08-19 11:52:22', '2022-08-19 11:52:32');
INSERT INTO `article` VALUES ('1560474805928054785', '大白话告诉你倒排索引是个啥', '<div class=\"cl-preview-section\">\n<div class=\"cl-preview-section\">\n<div class=\"cl-preview-section\">\n<div class=\"cl-preview-section\">\n<div class=\"cl-preview-section\">\n<h3>引子</h3>\n</div>\n<div class=\"cl-preview-section\">\n<p>很多搜索引擎都是基于倒排索引比如luncenesolr以及elasticsearch</p>\n</div>\n<div class=\"cl-preview-section\">\n<h3>正排索引</h3>\n</div>\n<div class=\"cl-preview-section\">\n<p>聊倒排搜索之前先来看看正排索引正排其实就是数据库表他通过id和数据进行关联如下</p>\n</div>\n<div class=\"cl-preview-section\">\n<div class=\"table-wrapper\">\n<table>\n<thead>\n<tr>\n<th>数据id</th>\n<th>数据内容</th>\n</tr>\n</thead>\n<tbody>\n<tr>\n<td>1001</td>\n<td>苹果公司发布iPhone</td>\n</tr>\n<tr>\n<td>1002</td>\n<td>地球引力起源于苹果</td>\n</tr>\n<tr>\n<td>1003</td>\n<td>iPhone屏幕碎了</td>\n</tr>\n<tr>\n<td>1004</td>\n<td>我在苹果商店维修屏幕</td>\n</tr>\n<tr>\n<td>1005</td>\n<td>我刚刚吃了苹果</td>\n</tr>\n</tbody>\n</table>\n</div>\n</div>\n<div class=\"cl-preview-section\">\n<p>我们可以通过搜索id来获得相应的数据也能删除数据。你买了一本书书的目录其实也是正排搜索。</p>\n</div>\n<div class=\"cl-preview-section\">\n<p>假设现在我要搜<code>苹果</code>俩字那么他会对这张表格中每一行的数据做匹配去查找一下是否包含<code>苹果</code>这两个字从第一条匹配到最后一条如果一张表中数据量不多几万十几万那么问题不大但是一旦数据量有上百万上千万那么全表扫描这种的搜索性能就会有影响。</p>\n</div>\n<div class=\"cl-preview-section\">\n<p>其次这个时候我想搜索<code>苹果iPhone</code>那么我们无法把这词汇拆开再到数据库去搜索。</p>\n</div>\n<div class=\"cl-preview-section\">\n<ul>\n<li>优点使用起来方便原理也简单比较入门</li>\n<li>缺点检索效率低下适合简单场景使用比如传统项目数据量较小的项目。不支持分词搜索。</li>\n</ul>\n</div>\n<div class=\"cl-preview-section\">\n<h3>倒排索引</h3>\n</div>\n<div class=\"cl-preview-section\">\n<p>与正排是反着来的他会把文档内容进行分词比如<code>苹果公司发布iPhone</code>是一个文档数据当我们把他存入到搜索引擎中去的时候会有一个文档id这个文档id就类似于数据库主键。但是这文档存储的时候和数据库不一样他会进行一个分词参照上面的表格分词后的结果如下</p>\n</div>\n<div class=\"cl-preview-section\">\n<div class=\"table-wrapper\">\n<table>\n<thead>\n<tr>\n<th>文档数据</th>\n<th>分词结果</th>\n</tr>\n</thead>\n<tbody>\n<tr>\n<td>苹果公司发布iPhone</td>\n<td>苹果公司发布iPhone</td>\n</tr>\n<tr>\n<td>地球引力起源于苹果</td>\n<td>地球引力起源于苹果</td>\n</tr>\n<tr>\n<td>iPhone屏幕碎了</td>\n<td>iPhone屏幕碎了</td>\n</tr>\n<tr>\n<td>我在苹果商店维修屏幕</td>\n<td>我在苹果商店维修屏幕</td>\n</tr>\n<tr>\n<td>我刚刚吃了苹果</td>\n<td>我刚刚吃了苹果</td>\n</tr>\n</tbody>\n</table>\n</div>\n</div>\n<div class=\"cl-preview-section\">\n<p>每一个词汇都会和文档id关联起来可以根据词汇来找到所有出现的id列表如下</p>\n</div>\n<div class=\"cl-preview-section\">\n<div class=\"table-wrapper\">\n<table>\n<thead>\n<tr>\n<th>词汇</th>\n<th>文档ids</th>\n</tr>\n</thead>\n<tbody>\n<tr>\n<td>苹果</td>\n<td>1001100210041005</td>\n</tr>\n<tr>\n<td>iPhone</td>\n<td>10011003</td>\n</tr>\n<tr>\n<td>公司</td>\n<td>1001</td>\n</tr>\n<tr>\n<td>发布</td>\n<td>1001</td>\n</tr>\n<tr>\n<td>地球</td>\n<td>1001</td>\n</tr>\n<tr>\n<td>引力</td>\n<td>1001</td>\n</tr>\n<tr>\n<td>起源</td>\n<td>1001</td>\n</tr>\n<tr>\n<td>于</td>\n<td>1001</td>\n</tr>\n<tr>\n<td>屏幕</td>\n<td>10031004</td>\n</tr>\n<tr>\n<td>碎了</td>\n<td>1003</td>\n</tr>\n<tr>\n<td>我</td>\n<td>10041005</td>\n</tr>\n<tr>\n<td>在</td>\n<td>1004</td>\n</tr>\n<tr>\n<td>商店</td>\n<td>1004</td>\n</tr>\n<tr>\n<td>维修</td>\n<td>1004</td>\n</tr>\n<tr>\n<td>刚刚</td>\n<td>1005</td>\n</tr>\n<tr>\n<td>吃了</td>\n<td>1005</td>\n</tr>\n</tbody>\n</table>\n</div>\n</div>\n<div class=\"cl-preview-section\">\n<p>假设现在我要搜索<code>iPhone</code>如果是数据库搜索假设有1亿条数据那么会匹配1亿次全表扫描。最后再把数据返回出来。<br />如果是搜索引擎那么有可能第一次就把所有文档数据给查出来当然也有可能是第N次当然他肯定要比数据库的搜索效率更高。如图中位置他会直接把<code>10011003</code>两个文档返回。</p>\n</div>\n<div class=\"cl-preview-section\">\n<p>可能会有同学会问数据库和搜索引擎都是1000万数据搜索的词汇在搜索引擎中正好是第1000万条那么会不会慢其实这个肯定会比数据库更快数据库要匹配是一个文本中的内容和关键词匹配而搜索引擎是直接把关键字做匹配效率肯定后者更快。</p>\n</div>\n<div class=\"cl-preview-section\">\n<ul>\n<li>有点搜索更快耗时短用户体验高精装度也高</li>\n<li>缺点维护成本高索引新建后要修改必须先删除前期需要很好地规划</li>\n</ul>\n</div>\n<h3><br />作者：风间影月<br />链接：https://www.imooc.com/article/301727<br />来源：慕课网</h3>\n</div>\n</div>\n</div>\n</div>', 'http://hire.t.mukewang.com/static/photo/article/cover/d62aaafe-3651-4198-a949-722870626201.png', '1001', '2022-08-19 11:52:28', 'admin', 'http://hire.t.mukewang.com/static/adminFace/644842e3-0173-42c0-a7a9-abdba09c358b.png', 1, '2022-08-19 11:52:41', '2022-08-19 11:52:51');
INSERT INTO `article` VALUES ('1560474939625689089', 'MongoDB-3 GUI客户端工具与用户权限', '<div class=\"cl-preview-section\">\n<div class=\"cl-preview-section\">\n<div class=\"cl-preview-section\">\n<div class=\"cl-preview-section\">\n<div class=\"cl-preview-section\">\n<div class=\"cl-preview-section\">\n<h1>MongoDB-3 GUI客户端工具与用户权限</h1>\n</div>\n<div class=\"cl-preview-section\">\n<h3>引子</h3>\n</div>\n<div class=\"cl-preview-section\">\n<p>不论是mysql或者redis或者es，我们都会使用远程的客户端工具来连接数据库server，那么目前的linux上锁安装的MongoDB就是server端，我们需要有一个客户端来进行可视化的管理，常用的可以使用Navcat来操作，当然使用其他的GUI工具也都行。</p>\n</div>\n<div class=\"cl-preview-section\">\n<h3>GUI 连接 MongoDB</h3>\n</div>\n<div class=\"cl-preview-section\">\n<ul>\n<li>创建连接</li>\n</ul>\n</div>\n<div class=\"cl-preview-section\">\n<p><img class=\"\" src=\"https://img1.sycdn.imooc.com/5e4e784c0001ac5f03940732.jpg\" alt=\"屏幕快照 2020-02-04 14.28.33\" data-original=\"https://img1.sycdn.imooc.com/5e4e784c0001ac5f03940732.jpg\" /></p>\n</div>\n<div class=\"cl-preview-section\">\n<ul>\n<li>填入你的host所在ip，注意需要内网互通</li>\n</ul>\n</div>\n<div class=\"cl-preview-section\">\n<p><img class=\"\" src=\"https://img2.sycdn.imooc.com/5e4e784d000144b012560816.jpg\" alt=\"-w628\" data-original=\"https://img2.sycdn.imooc.com/5e4e784d000144b012560816.jpg\" /></p>\n</div>\n<div class=\"cl-preview-section\">\n<ul>\n<li>双击连接如果图标可以点亮，说明连接没问题<br /><img class=\"\" src=\"https://img2.sycdn.imooc.com/5e4e784e0001a53f05720076.jpg\" alt=\"-w286\" data-original=\"https://img2.sycdn.imooc.com/5e4e784e0001a53f05720076.jpg\" /></li>\n<li>如下图，创建连接1后，school为数据库，3为集合，也就是创建的表<br /><img class=\"\" src=\"https://img3.sycdn.imooc.com/5e4e784f00019e4105660646.jpg\" alt=\"-w283\" data-original=\"https://img3.sycdn.imooc.com/5e4e784f00019e4105660646.jpg\" /></li>\n</ul>\n</div>\n<div class=\"cl-preview-section\">\n<h3>创建MongoDB用户账号权限</h3>\n</div>\n<div class=\"cl-preview-section\">\n<p>上述的创建连接是以匿名的方式去连接的，这样在公网环境下回很危险，和redis一样，都要创建用户和密码，才能连接到MongoDB，否则暴露在公网环境在忘记关闭端口的情况下会被黑客攻击。</p>\n</div>\n<div class=\"cl-preview-section\">\n<ul>\n<li>修改mongodb.conf，auth改为true就代表启用授权模式：</li>\n</ul>\n</div>\n<div class=\"cl-preview-section\">\n<p><img class=\"\" src=\"https://img3.sycdn.imooc.com/5e4e784f0001e47b07560264.jpg\" alt=\"-w378\" data-original=\"https://img3.sycdn.imooc.com/5e4e784f0001e47b07560264.jpg\" /></p>\n</div>\n<div class=\"cl-preview-section\">\n<ul>\n<li>重启mongodb（步骤略，参考上一篇博文）</li>\n<li>进入到mongodb控制台：</li>\n</ul>\n</div>\n<div class=\"cl-preview-section\">\n<pre><code>mongo\n</code></pre>\n</div>\n<div class=\"cl-preview-section\">\n<p><img class=\"\" src=\"https://img2.sycdn.imooc.com/5e4e78500001e81724200382.jpg\" alt=\"-w1210\" data-original=\"https://img2.sycdn.imooc.com/5e4e78500001e81724200382.jpg\" /></p>\n</div>\n<div class=\"cl-preview-section\">\n<ul>\n<li>在控制台输入如下命令：\n<ul>\n<li>\n<p>使用admin库，账号再这里创建</p>\n<pre><code>use admin\n</code></pre>\n</li>\n<li>\n<p>创建用户，账号密码分布为root，root，roles为角色root，代表超级权限</p>\n</li>\n</ul>\n<pre><code></code></pre>\n</li>\n</ul>\n</div>\n<div class=\"cl-preview-section\">\n<p>db.createUser({user:&ldquo;root&rdquo;,pwd:&ldquo;root&rdquo;,roles:[&ldquo;root&rdquo;]})<br />```</p>\n<pre><code>* 附：更多角色参考如下：\n</code></pre>\n</div>\n<div class=\"cl-preview-section\">\n<p><img class=\"\" src=\"https://img2.sycdn.imooc.com/5e4e78510001ab6208000420.jpg\" alt=\"file\" data-original=\"https://img2.sycdn.imooc.com/5e4e78510001ab6208000420.jpg\" /></p>\n<pre><code>* 登录：\n\n    ```\n    db.auth(\"root\",\"root\")\n    ``` \n* 查看用户：\n\n    ```\n    show users\n    ```\n			\n截图：\n\n![-w1455](http://img3.sycdn.imooc.com/5e4e78550001d29029101758.jpg)\n</code></pre>\n</div>\n<div class=\"cl-preview-section\">\n<h3>使用Navcat重新连接</h3>\n</div>\n<div class=\"cl-preview-section\">\n<p>使用密码方式登录，输入root/root，随后即可打开连接</p>\n</div>\n<div class=\"cl-preview-section\">\n<p><img class=\"\" src=\"https://img1.sycdn.imooc.com/5e4e78570001e45413560920.jpg\" alt=\"-w678\" data-original=\"https://img1.sycdn.imooc.com/5e4e78570001e45413560920.jpg\" /></p>\n</div>\n<div class=\"cl-preview-section\">\n<h3>SpringBoot整合 MongoDB</h3>\n</div>\n<div class=\"cl-preview-section\">\n<p>yml 配置文件</p>\n</div>\n<div class=\"cl-preview-section\">\n<pre><code>spring:\n  data:\n    mongodb:\n      uri: mongodb://root:root@192.168.1.71:27017\n      database: lou1yan\n</code></pre>\n</div>\n<div class=\"cl-preview-section\">\n<h3>MongoDB 的CRUD（代码略）</h3>\n</div>\n<div class=\"cl-preview-section\">\n<p>可以使用MongoRepository或者mongoTemplate实现基本的CRUD</p>\n</div>\n<h3><br />作者：风间影月<br />链接：https://www.imooc.com/article/300920<br />来源：慕课网</h3>\n</div>\n</div>\n</div>\n</div>\n</div>', 'http://hire.t.mukewang.com/static/photo/article/cover/5f46215a-be29-4ec8-bb8f-7fe7d615d56b.png', '1001', '2022-08-19 11:52:55', 'admin', 'http://hire.t.mukewang.com/static/adminFace/644842e3-0173-42c0-a7a9-abdba09c358b.png', 1, '2022-08-19 11:53:12', '2022-08-19 11:53:22');
INSERT INTO `article` VALUES ('1560475056785182722', 'MongoDB-2 安装与配置', '<div class=\"cl-preview-section\">\n<div class=\"cl-preview-section\">\n<div class=\"cl-preview-section\">\n<div class=\"cl-preview-section\">\n<div class=\"cl-preview-section\">\n<div class=\"cl-preview-section\">\n<div class=\"cl-preview-section\">\n<h3>安装建议</h3>\n</div>\n<div class=\"cl-preview-section\">\n<p>MongoDB 可以在mac/win/linux上安装，我个人建议在linux上安装会更好，这样测试起来更方便。一般来说本地只装mysql或者MariaDB，其余的中间件一律放linux，让电脑软件解耦，毕竟你的电脑不是一直处于工作状态，有时候也是用于娱乐的~</p>\n</div>\n<div class=\"cl-preview-section\">\n<h3>安装步骤</h3>\n</div>\n<div class=\"cl-preview-section\">\n<ul>\n<li>打开官网：<a href=\"https://www.mongodb.com/download-center/community\">https://www.mongodb.com/download-center/community</a></li>\n<li>选择版本进行下载，在这里就以linux为安装演示</li>\n<li>需要注意，4.0.16包含linux 64位版本下载，而4.2.3中暂未包含，当然你要选择其他的linux版本下载也可以，另外最新的4.3.3位开发版，不建议使用<br /><img class=\"\" src=\"https://img1.sycdn.imooc.com/5e46242100015ad907540314.jpg\" alt=\"file\" data-original=\"https://img1.sycdn.imooc.com/5e46242100015ad907540314.jpg\" /></li>\n<li>下载好后，上传到linux中，如下：</li>\n</ul>\n</div>\n<div class=\"cl-preview-section\">\n<p><img class=\"\" src=\"https://img4.sycdn.imooc.com/5e4624210001d3d508000152.jpg\" alt=\"file\" data-original=\"https://img4.sycdn.imooc.com/5e4624210001d3d508000152.jpg\" /></p>\n</div>\n<div class=\"cl-preview-section\">\n<ul>\n<li>\n<p>解压缩：</p>\n<pre><code>tar -zxvf mongodb-linux-x86_64-4.0.16.tgz\n</code></pre>\n<p>得到：</p>\n</li>\n</ul>\n</div>\n<div class=\"cl-preview-section\">\n<p><img class=\"\" src=\"https://img2.sycdn.imooc.com/5e46242200010b0608000468.jpg\" alt=\"file\" data-original=\"https://img2.sycdn.imooc.com/5e46242200010b0608000468.jpg\" /></p>\n</div>\n<div class=\"cl-preview-section\">\n<ul>\n<li>\n<p>重命名解压缩后的文件夹并且移动到&nbsp;<code>/usr/local</code>&nbsp;中：</p>\n<pre><code>mv mongodb-linux-x86_64-4.0.16 /usr/local/mongodb\n</code></pre>\n<p><img class=\"\" src=\"https://img2.sycdn.imooc.com/5e46242200018de208000310.jpg\" alt=\"file\" data-original=\"https://img2.sycdn.imooc.com/5e46242200018de208000310.jpg\" /></p>\n</li>\n<li>\n<p>配置环境变量：</p>\n<pre><code>vim /etc/profile\n</code></pre>\n<pre><code># Set MongoDB Configration\nexport PATH=/usr/local/mongodb/bin:$PATH\n</code></pre>\n<p><img class=\"\" src=\"https://img4.sycdn.imooc.com/5e462423000157ad08000198.jpg\" alt=\"file\" data-original=\"https://img4.sycdn.imooc.com/5e462423000157ad08000198.jpg\" /></p>\n</li>\n<li>\n<p>使其生效：</p>\n<pre><code>source /etc/profile\n</code></pre>\n</li>\n<li>\n<p>查看MongoDB版本：</p>\n<pre><code>mongo -version\n</code></pre>\n<p><img class=\"\" src=\"https://img1.sycdn.imooc.com/5e462424000136b708000246.jpg\" alt=\"file\" data-original=\"https://img1.sycdn.imooc.com/5e462424000136b708000246.jpg\" /></p>\n</li>\n</ul>\n</div>\n<div class=\"cl-preview-section\">\n<h3>配置MongoDB</h3>\n</div>\n<div class=\"cl-preview-section\">\n<ul>\n<li>\n<p>在MongoDB根目录中创建 data/db 目录，用于存储数据库文件数据，并且再创建 data/logs/mongodb.log 用于存储日志</p>\n<p><img class=\"\" src=\"https://img1.sycdn.imooc.com/5e46242400012d1208000236.jpg\" alt=\"file\" data-original=\"https://img1.sycdn.imooc.com/5e46242400012d1208000236.jpg\" /></p>\n<p><img class=\"\" src=\"https://img2.sycdn.imooc.com/5e4624240001746008000514.jpg\" alt=\"file\" data-original=\"https://img2.sycdn.imooc.com/5e4624240001746008000514.jpg\" /></p>\n</li>\n<li>\n<p>在mongodb根目录下创建核心配置文件，并且追加配置内容如下：</p>\n<pre><code>vim mongodb.conf\n</code></pre>\n<pre><code># 端口号\nport=27017\n# 数据库文件位置\ndbpath=/usr/local/mongodb/data/db\n# 日志文件位置\nlogpath=/usr/local/mongodb/data/logs/mongodb.log\n\n# 以追加日志的形式记录\nlogappend=true\n# 滤掉无用日志信息，若需要调试使用请设置为false\nquiet=true\n# 以后台方式运行\nfork=true\n# 最大同时连接数\nmaxConns=100\n# 不启用验证权限\nnoauth=true\n# 启用用户账号权限\n# auth=true\n# 开启日志，默认true\njournal=true\n# 提供外网访问，不对ip进行绑定，原理同redis的bindip\nbind_ip = 0.0.0.0\n</code></pre>\n</li>\n<li>\n<p>最终创建的目录以及文件树形结构为：</p>\n<pre><code>mongodb\n    |- mongodb.conf\n    |- data\n         |- db\n         |- logs\n              |- mongodb.log\n</code></pre>\n</li>\n<li>\n<p>启动MongoDB：</p>\n<pre><code>mongod -f mongodb.conf\n</code></pre>\n<p><img class=\"\" src=\"https://img2.sycdn.imooc.com/5e4624250001f75a08000093.jpg\" alt=\"file\" data-original=\"https://img2.sycdn.imooc.com/5e4624250001f75a08000093.jpg\" /></p>\n<p><img class=\"\" src=\"https://img2.sycdn.imooc.com/5e4624260001a10308000070.jpg\" alt=\"file\" data-original=\"https://img2.sycdn.imooc.com/5e4624260001a10308000070.jpg\" /></p>\n<p><img class=\"\" src=\"https://img3.sycdn.imooc.com/5e46242600010dc208000052.jpg\" alt=\"file\" data-original=\"https://img3.sycdn.imooc.com/5e46242600010dc208000052.jpg\" /></p>\n</li>\n</ul>\n</div>\n<div class=\"cl-preview-section\">\n<h3>MongoDB 的一些基本命令</h3>\n</div>\n<div class=\"cl-preview-section\">\n<ul>\n<li>\n<p>启动MongoDB：</p>\n<pre><code>mongod -f mongodb.conf\n</code></pre>\n</li>\n<li>\n<p>关闭MongoDB：</p>\n<p><img class=\"\" src=\"https://img1.sycdn.imooc.com/5e462ae000015dee22480198.jpg\" alt=\"图片描述\" data-original=\"https://img1.sycdn.imooc.com/5e462ae000015dee22480198.jpg\" /><br />8456为进程号</p>\n<pre><code>kill -2 8456 （优雅关闭）\n或者\nkill -9 8456 （不建议）\n</code></pre>\n<p>或者使用如下命令也行，如果自定义MongoDB的db目录，则需要追加 --dbpath，否则使用默认目录即可：</p>\n<pre><code>mongod --shutdown --dbpath /usr/local/mongodb/data/db/\n</code></pre>\n<p><img class=\"\" src=\"https://img4.sycdn.imooc.com/5e4624270001486408000080.jpg\" alt=\"file\" data-original=\"https://img4.sycdn.imooc.com/5e4624270001486408000080.jpg\" /></p>\n</li>\n</ul>\n</div>\n<h1><br />作者：风间影月<br />链接：https://www.imooc.com/article/300636<br />来源：慕课网</h1>\n</div>\n</div>\n</div>\n</div>\n</div>\n</div>', 'http://hire.t.mukewang.com/static/photo/article/cover/5d1bbdb2-be97-4706-b776-ecaa6202b7c0.png', '1001', '2022-08-19 11:53:19', 'admin', 'http://hire.t.mukewang.com/static/adminFace/644842e3-0173-42c0-a7a9-abdba09c358b.png', 1, '2022-08-19 11:53:40', '2022-08-19 11:53:50');
INSERT INTO `article` VALUES ('1560475122434428930', 'MongoDB-1 入门', '<div class=\"cl-preview-section\">\n<div class=\"cl-preview-section\">\n<div class=\"cl-preview-section\">\n<div class=\"cl-preview-section\">\n<div class=\"cl-preview-section\">\n<div class=\"cl-preview-section\">\n<div class=\"cl-preview-section\">\n<div class=\"cl-preview-section\">\n<h3>基础概念</h3>\n</div>\n<div class=\"cl-preview-section\">\n<p>MongoDB 是非关系型数据库，也就是nosql，存储json数据格式会非常灵活，要比mysql更好，同时也能为mysql分摊一部分的流量压力。另外呢，对于非事务的数据完全可以保存到MongoDB中，这些数据往往也是非核心数据。</p>\n</div>\n<div class=\"cl-preview-section\">\n<p>以下是MongoDB和数据库以及ElasticSearch的术语对比：</p>\n</div>\n<div class=\"cl-preview-section\">\n<div class=\"table-wrapper\">\n<table>\n<thead>\n<tr>\n<th>数据库</th>\n<th>ElasticSearch</th>\n<th>MongoDB</th>\n</tr>\n</thead>\n<tbody>\n<tr>\n<td>database</td>\n<td>es库</td>\n<td>database</td>\n</tr>\n<tr>\n<td>table 表</td>\n<td>index 索引</td>\n<td>collection 数据集合</td>\n</tr>\n<tr>\n<td>row 行（记录）</td>\n<td>document 文档（json）</td>\n<td>document 文档（json）</td>\n</tr>\n<tr>\n<td>column 字段列</td>\n<td>field 域</td>\n<td>field 域</td>\n</tr>\n<tr>\n<td>index 索引</td>\n<td>-</td>\n<td>index 索引</td>\n</tr>\n<tr>\n<td>join 表关联查询</td>\n<td>-</td>\n<td>-</td>\n</tr>\n<tr>\n<td>pk 主键</td>\n<td>_id</td>\n<td>_id</td>\n</tr>\n</tbody>\n</table>\n</div>\n</div>\n<div class=\"cl-preview-section\">\n<ul>\n<li>MongoDB可以创建多个数据库（同mysql）</li>\n<li>一个数据库可以创建多个collection（同mysql创建多表）</li>\n<li>一个集合可以包含很多文档数据（同mysql一张表包含很多行记录）</li>\n</ul>\n</div>\n<div class=\"cl-preview-section\">\n<p>我们可以通过如下代码片段来更好的理解MongoDB的数据对比，假设这张表中总记录有3条：</p>\n</div>\n<div class=\"cl-preview-section\">\n<pre><code>UserList: [\n	{\n		userId: \"1001\",\n		username: \"lee\",\n		age: 18,\n		sex: \"boy\"	\n	},\n	{\n		userId: \"1002\",\n		username: \"jay\",\n		age: 20,\n		sex: \"boy\"	\n	},\n	{\n		userId: \"1003\",\n		username: \"jolin\",\n		age: 19,\n		sex: \"girl\"	\n	}\n]\n</code></pre>\n</div>\n<div class=\"cl-preview-section\">\n<p>如上述代码中：</p>\n</div>\n<div class=\"cl-preview-section\">\n<ul>\n<li>UserList是一个<code>collection</code>，在mysql中可以当做是一张表</li>\n<li>UserList中的每个<code>{}</code>都是一个json对象，他们称之为<code>document文档</code>，在mysql中称之为行记录</li>\n<li>userId、username、age、sex 这些都是<code>field 域</code>，在MySQL中称之为column列字段</li>\n</ul>\n</div>\n<div class=\"cl-preview-section\">\n<h4>文章比较短，下一遍会来讲一下怎么搭建运行的</h4>\n</div>\n<h3><br />作者：风间影月<br />链接：https://www.imooc.com/article/300487<br />来源：慕课网</h3>\n</div>\n</div>\n</div>\n</div>\n</div>\n</div>\n</div>', '', '1001', '2022-08-19 11:53:45', 'admin', 'http://hire.t.mukewang.com/static/adminFace/644842e3-0173-42c0-a7a9-abdba09c358b.png', 1, '2022-08-19 11:53:56', '2022-08-19 11:54:06');
INSERT INTO `article` VALUES ('1560475229515010050', 'SSI 网页内嵌技术', '<div class=\"cl-preview-section\">\n<div class=\"cl-preview-section\">\n<div class=\"cl-preview-section\">\n<div class=\"cl-preview-section\">\n<div class=\"cl-preview-section\">\n<div class=\"cl-preview-section\">\n<div class=\"cl-preview-section\">\n<div class=\"cl-preview-section\">\n<div class=\"cl-preview-section\">\n<h3>引子</h3>\n</div>\n<div class=\"cl-preview-section\">\n<p>一般来说我们开发网页的时候，大多都会以一个大的HTML页面来做，来开发，来发布，来维护。初期可能就1-2人维护，随着业务发展，功能迭代，一个首页会相当复杂，那么就有可能会有一个团队来维护，首页包含的功能会有很多，比如，轮播图，分类，商品推荐，广告等等，可以看一下京东：<br /><img class=\"\" src=\"https://img1.sycdn.imooc.com/5e37e4030001dbc836981476.jpg\" alt=\"图片描述\" data-original=\"https://img1.sycdn.imooc.com/5e37e4030001dbc836981476.jpg\" /><br /><img class=\"\" src=\"https://img1.sycdn.imooc.com/5e37e41e0001ef0c36941426.jpg\" alt=\"图片描述\" data-original=\"https://img1.sycdn.imooc.com/5e37e41e0001ef0c36941426.jpg\" /><br /><img class=\"\" src=\"https://img1.sycdn.imooc.com/5e37e431000139fe36921426.jpg\" alt=\"图片描述\" data-original=\"https://img1.sycdn.imooc.com/5e37e431000139fe36921426.jpg\" /></p>\n</div>\n<div class=\"cl-preview-section\">\n<p>以上三张图中的红框部分，其实都是每个页面中的一个小功能，他们都可以单独拿出来作为一个单独的页面，随后再嵌入到页面中，如此一来，就更加便于团队的开发和维护了，同时也能提供公用化的功能，减少重复代码。</p>\n</div>\n<div class=\"cl-preview-section\">\n<h3>SSI</h3>\n</div>\n<div class=\"cl-preview-section\">\n<p>那么如何进行网页内嵌呢，我相信经历过jsp时代的应该会知道include，其实我们这里使用的原理也是一样的。</p>\n</div>\n<div class=\"cl-preview-section\">\n<p>SSI就是server side include，网页服务端内嵌技术，像Apache，Nginx都支持。可以把页面拆分成小页面后，再合并聚合在一起显示给用户。</p>\n</div>\n<div class=\"cl-preview-section\">\n<p>ssi的可定义扩展名为：<em>.stm、</em>&nbsp;<em>.shtm、</em>&nbsp;<em>.shtml</em></p>\n</div>\n<div class=\"cl-preview-section\">\n<h3>标签使用</h3>\n</div>\n<div class=\"cl-preview-section\">\n<p>如下，看似和jsp的include是类似的，道理也是一样的</p>\n</div>\n<div class=\"cl-preview-section\">\n<pre><code>&lt;!--#include virtual=\"/pages/index/abc.html\"  --&gt;\n</code></pre>\n</div>\n<div class=\"cl-preview-section\">\n<h3>在nginx中配置ssi</h3>\n</div>\n<div class=\"cl-preview-section\">\n<ul>\n<li>\n<p>如何安装nginx的，不多说了，参考我以前的博客：<br /><a href=\"https://www.cnblogs.com/leechenxiang/p/7086298.html\">https://www.cnblogs.com/leechenxiang/p/7086298.html</a></p>\n</li>\n<li>\n<p>准备如下页面，主要是配置首页的include标签：</p>\n</li>\n<li>\n<p>nginx中的ssi配置如下：<br /><img class=\"\" src=\"https://img1.sycdn.imooc.com/5e37e4470001595f22061158.jpg\" alt=\"图片描述\" data-original=\"https://img1.sycdn.imooc.com/5e37e4470001595f22061158.jpg\" /></p>\n</li>\n<li>\n<p>nginx.conf 配置：</p>\n</li>\n</ul>\n</div>\n<div class=\"cl-preview-section\">\n<pre><code>    server {\n        listen       80;\n        server_name  localhost;\n\n        # 开启 ssi\n        ssi on;\n        # ssi 出错是不会打印日志\n        ssi_silent_errors on;\n        # 默认的静态页面后缀为 html，如果想自定义，比如使用shtml则开启下方注释\n        # ssi_types text/shtml;\n\n        location / {\n            # root   html;\n            # 指定静态文件所在位置\n            root        ssi;\n            # 默认首页，如果你的后缀在上方修改为 *.shtml，则下方也需要跟着修改\n            index       index.html index.htm;\n        }\n    }\n</code></pre>\n</div>\n<div class=\"cl-preview-section\">\n<ul>\n<li>html如下：<br /><img class=\"\" src=\"https://img1.sycdn.imooc.com/5e37e4670001c7e120361078.jpg\" alt=\"图片描述\" data-original=\"https://img1.sycdn.imooc.com/5e37e4670001c7e120361078.jpg\" /></li>\n<li>github地址：<a href=\"https://github.com/leechenxiang/ssi-demo\">https://github.com/leechenxiang/ssi-demo</a></li>\n</ul>\n</div>\n<div class=\"cl-preview-section\">\n<h3>精品推荐</h3>\n</div>\n<div class=\"cl-preview-section\">\n<p>如果你是一名java开发人员，在如此激烈的竞争中，为亲爱的你推荐如下架构师进阶课程噢~<br /><a href=\"https://class.imooc.com/sale/javaarchitect\">https://class.imooc.com/sale/javaarchitect</a><br /><img class=\"\" src=\"https://img1.sycdn.imooc.com/5e37e4a00001ec4713540486.jpg\" alt=\"图片描述\" data-original=\"https://img1.sycdn.imooc.com/5e37e4a00001ec4713540486.jpg\" /></p>\n</div>\n<div class=\"cl-preview-section\">\n<p><img class=\"\" src=\"https://img1.sycdn.imooc.com/5e37e4b1000188b721180650.jpg\" alt=\"图片描述\" data-original=\"https://img1.sycdn.imooc.com/5e37e4b1000188b721180650.jpg\" /></p>\n</div>\n<h3><br />作者：风间影月<br />链接：https://www.imooc.com/article/300244<br />来源：慕课网</h3>\n</div>\n</div>\n</div>\n</div>\n</div>\n</div>\n</div>\n</div>', 'http://hire.t.mukewang.com/static/photo/article/cover/b629cef0-bfd8-45e7-9978-7674e12a3016.png', '1001', '2022-08-19 11:54:01', 'admin', 'http://hire.t.mukewang.com/static/adminFace/644842e3-0173-42c0-a7a9-abdba09c358b.png', 1, '2022-08-19 11:54:22', '2022-08-19 11:54:32');
COMMIT;

-- ----------------------------
-- Table structure for chat_message
-- ----------------------------
DROP TABLE IF EXISTS `chat_message`;
CREATE TABLE `chat_message` (
  `id` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `sender_id` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '发送者的用户id',
  `receiver_id` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '接受者的用户id',
  `receiver_type` int NOT NULL COMMENT '消息接受者的类型，是HR还是求职者，目的为了让前端不同页面接受判断并且处理显示',
  `msg` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '聊天内容',
  `msg_type` int NOT NULL COMMENT '消息类型，有文字类、图片类、视频类...等，详见枚举类',
  `chat_time` datetime NOT NULL COMMENT '消息的聊天时间，既是发送者的发送时间、又是接受者的接受时间',
  `show_msg_date_time_flag` int NOT NULL COMMENT '标记存储数据库，用于历史展示。每超过1分钟，则显示聊天时间，前端可以控制时间长短',
  `video_path` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '视频地址',
  `video_width` int DEFAULT NULL COMMENT '视频宽度',
  `video_height` int DEFAULT NULL COMMENT '视频高度',
  `video_times` int DEFAULT NULL COMMENT '视频时间',
  `voice_path` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '语音地址',
  `speak_voice_duration` int DEFAULT NULL COMMENT '语音时长',
  `is_read` tinyint(1) DEFAULT NULL COMMENT '语音消息标记是否已读未读，true: 已读，false: 未读',
  `resume_user_id` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '候选人用户id',
  `resume_name` varchar(24) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '简历名称（候选人名称）  \n简历名称与职位使用字段冗余，目的相当于快照，只记录当时信息',
  `resume_position` varchar(24) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '候选人职位  \n简历名称与职位使用字段冗余，目的相当于快照，只记录当时信息',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='聊天信息存储表';

-- ----------------------------
-- Records of chat_message
-- ----------------------------
BEGIN;
INSERT INTO `chat_message` VALUES ('1553428639288483841', '1551835815514251265', '1541299724478681090', 1, '啊啊啊', 1, '2022-07-31 01:13:44', 0, '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `chat_message` VALUES ('1553428656313163778', '1551835815514251265', '1541299724478681090', 1, '[006][008][008][008]', 1, '2022-07-31 01:13:48', 0, '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `chat_message` VALUES ('1553428750571757569', '1551835815514251265', '1541299724478681090', 1, 'http://192.168.1.10:8000/static/1551835815514251265/chatVideo/ff27ee69-d761-4bdf-b45c-c852730e6490.jpg', 4, '2022-07-31 01:14:10', 0, 'http://192.168.1.10:8000/static/1551835815514251265/chatVideo/ff27ee69-d761-4bdf-b45c-c852730e6490.mp4', 772, 540, 14, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `chat_message` VALUES ('1553590064191410177', '1541299724478681090', '1551835815514251265', 2, '哈哈哈', 1, '2022-07-31 11:55:10', 1, '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `chat_message` VALUES ('1553590102024032258', '1551835815514251265', '1541299724478681090', 1, '123', 1, '2022-07-31 11:55:19', 0, '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `chat_message` VALUES ('1553590733841403905', '1541299724478681090', '1551835815514251265', 2, 'KKK', 1, '2022-07-31 11:57:44', 1, '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `chat_message` VALUES ('1553707366748639233', '1551835815514251265', '1541299724478681090', 1, '', 1, '2022-07-31 19:41:17', 1, '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `chat_message` VALUES ('1553707471182614529', '1551835815514251265', '1541299724478681090', 1, 'r32r32', 1, '2022-07-31 19:41:42', 0, '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `chat_message` VALUES ('1553707542741635073', '1551835815514251265', '1541299724478681090', 1, 'few', 1, '2022-07-31 19:41:59', 0, '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `chat_message` VALUES ('1553707666452631554', '1551835815514251265', '1541299724478681090', 1, '1111122222', 1, '2022-07-31 19:42:29', 0, '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `chat_message` VALUES ('1553707808119443458', '1551835815514251265', '1541299724478681090', 1, '', 1, '2022-07-31 19:43:03', 0, '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `chat_message` VALUES ('1553716816997781505', '1551835815514251265', '1541299724478681090', 1, 'rewrew', 1, '2022-07-31 20:18:50', 1, '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `chat_message` VALUES ('1553717049425137665', '1551835815514251265', '1541299724478681090', 1, '', 5, '2022-07-31 20:19:46', 0, '', NULL, NULL, NULL, NULL, NULL, NULL, '1551835815514251265', '我是求职的', '初级Java');
INSERT INTO `chat_message` VALUES ('1553725860345024514', '1551835815514251265', '1541299724478681090', 1, '', 5, '2022-07-31 20:54:47', 1, '', NULL, NULL, NULL, NULL, NULL, NULL, '1551835815514251265', '我是求职的', '初级Java');
INSERT INTO `chat_message` VALUES ('1553729145948868609', '1551835815514251265', '1541299724478681090', 1, '', 5, '2022-07-31 21:07:50', 1, '', NULL, NULL, NULL, NULL, NULL, NULL, '1551835815514251265', '我是求职的', '初级Java');
INSERT INTO `chat_message` VALUES ('1553729223728041985', '1551835815514251265', '1541299724478681090', 1, '', 5, '2022-07-31 21:08:08', 0, '', NULL, NULL, NULL, NULL, NULL, NULL, '1551835815514251265', '我是求职的', '初级Java');
INSERT INTO `chat_message` VALUES ('1553729236378062849', '1551835815514251265', '1541299724478681090', 1, '', 5, '2022-07-31 21:08:11', 0, '', NULL, NULL, NULL, NULL, NULL, NULL, '1551835815514251265', '我是求职的', '初级Java');
INSERT INTO `chat_message` VALUES ('1553729257156644865', '1551835815514251265', '1541299724478681090', 1, 'http://192.168.1.10:8000/static/1551835815514251265/chatPhoto/23bf2f85-c121-40df-b1b7-35760b2a3e35.gif', 2, '2022-07-31 21:08:16', 0, '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `chat_message` VALUES ('1553729290845294593', '1551835815514251265', '1541299724478681090', 1, '十几块钱啦 ', 1, '2022-07-31 21:08:24', 0, '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `chat_message` VALUES ('1553729345790676993', '1551835815514251265', '1541299724478681090', 1, '', 5, '2022-07-31 21:08:38', 0, '', NULL, NULL, NULL, NULL, NULL, NULL, '1551835815514251265', '我是求职的', '初级Java');
INSERT INTO `chat_message` VALUES ('1553729364623101954', '1551835815514251265', '1541299724478681090', 1, '', 5, '2022-07-31 21:08:42', 0, '', NULL, NULL, NULL, NULL, NULL, NULL, '1551835815514251265', '我是求职的', '初级Java');
INSERT INTO `chat_message` VALUES ('1553734862638419969', '1541299724478681090', '1551835815514251265', 2, '的', 1, '2022-07-31 21:30:33', 1, '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `chat_message` VALUES ('1553734878098624513', '1541299724478681090', '1551835815514251265', 2, '饿的', 1, '2022-07-31 21:30:37', 0, '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `chat_message` VALUES ('1553737787704139777', '1551835815514251265', '1541299724478681090', 1, 'fewfwe', 1, '2022-07-31 21:42:10', 1, '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `chat_message` VALUES ('1553737835905081346', '1551835815514251265', '1541299724478681090', 1, 'fefew', 1, '2022-07-31 21:42:22', 0, '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `chat_message` VALUES ('1553737856486531073', '1551835815514251265', '1541299724478681090', 1, '', 5, '2022-07-31 21:42:27', 0, '', NULL, NULL, NULL, NULL, NULL, NULL, '1551835815514251265', '我是求职的', '初级Java');
INSERT INTO `chat_message` VALUES ('1553951156725886977', '1541299724478681090', '1551835815514251265', 2, '1553951155559972866', 7, '2022-08-01 11:50:01', 1, '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `chat_message` VALUES ('1553995302052327426', '1541299724478681090', '1551835815514251265', 2, '1553953942289104898', 71, '2022-08-01 14:45:26', 0, '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `chat_message` VALUES ('1554008496468697089', '1551835815514251265', '1541299724478681090', 1, '21若1', 1, '2022-08-01 15:37:52', 1, '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `chat_message` VALUES ('1554008536444608513', '1551835815514251265', '1541299724478681090', 1, '我oi', 1, '2022-08-01 15:38:02', 0, '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `chat_message` VALUES ('1554008592841220097', '1551835815514251265', '1541299724478681090', 1, '15313513', 1, '2022-08-01 15:38:15', 0, '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `chat_message` VALUES ('1554088800449486849', '1551835815514251265', '1541299724478681090', 1, '[009][008]', 1, '2022-08-01 20:56:58', 1, '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `chat_message` VALUES ('1554096615897456641', '1541299724478681090', '1554096527766749186', 2, '健康码', 1, '2022-08-01 21:28:02', 1, '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `chat_message` VALUES ('1554103828695244802', '1541299724478681090', '1554096527766749186', 2, 'KKK', 1, '2022-08-01 21:56:41', 1, '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `chat_message` VALUES ('1554104462639128577', '1554096527766749186', '1541299724478681090', 1, '拉大鹅考皮卡丘', 1, '2022-08-01 21:59:12', 1, '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `chat_message` VALUES ('1554106833075200002', '1551835815514251265', '1541299724478681090', 1, '用', 1, '2022-08-01 22:08:37', 1, '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `chat_message` VALUES ('1554839963616735233', '1541299724478681090', '1554096527766749186', 2, '1553949520217620481', 71, '2022-08-03 22:41:49', 0, '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `chat_message` VALUES ('1554857053337743361', '1541299724478681090', '1551835815514251265', 2, '各个', 1, '2022-08-03 23:49:44', 1, '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `chat_message` VALUES ('1554857156257574913', '1541299724478681090', '1551835815514251265', 2, '红翼', 1, '2022-08-03 23:50:09', 0, '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `chat_message` VALUES ('1554858029037711362', '1541299724478681090', '1551835815514251265', 2, '给你', 1, '2022-08-03 23:53:37', 1, '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `chat_message` VALUES ('1554858039951290370', '1541299724478681090', '1551835815514251265', 2, '么得', 1, '2022-08-03 23:53:39', 0, '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `chat_message` VALUES ('1554858083051958274', '1541299724478681090', '1551835815514251265', 2, 'http://192.168.1.10:8000/static/1541299724478681090/chatPhoto/7efca4be-c6a7-4227-973a-6eeca0430c15.jpg', 2, '2022-08-03 23:53:50', 0, '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `chat_message` VALUES ('1554859263412989953', '1541299724478681090', '1551835815514251265', 2, '哈哈', 1, '2022-08-03 23:58:31', 1, '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `chat_message` VALUES ('1554859718088126466', '1551835815514251265', '1541299724478681090', 1, '1', 1, '2022-08-04 00:00:19', 1, '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `chat_message` VALUES ('1554859725390409729', '1551835815514251265', '1541299724478681090', 1, '2', 1, '2022-08-04 00:00:21', 0, '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `chat_message` VALUES ('1554859733485416450', '1551835815514251265', '1541299724478681090', 1, '3', 1, '2022-08-04 00:00:23', 0, '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `chat_message` VALUES ('1554859740229857282', '1551835815514251265', '1541299724478681090', 1, '4', 1, '2022-08-04 00:00:25', 0, '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `chat_message` VALUES ('1554859745992830978', '1551835815514251265', '1541299724478681090', 1, '5', 1, '2022-08-04 00:00:26', 0, '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `chat_message` VALUES ('1554859756604420098', '1551835815514251265', '1541299724478681090', 1, '6', 1, '2022-08-04 00:00:29', 0, '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `chat_message` VALUES ('1554859765861249026', '1551835815514251265', '1541299724478681090', 1, '7', 1, '2022-08-04 00:00:31', 0, '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `chat_message` VALUES ('1556635847178371073', '1541299724478681090', '1551835815514251265', 2, '你好', 1, '2022-08-08 21:38:01', 1, '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `chat_message` VALUES ('1556635900005629954', '1551835815514251265', '1541299724478681090', 1, '', 5, '2022-08-08 21:38:14', 0, '', NULL, NULL, NULL, NULL, NULL, NULL, '1551835815514251265', '我是求职的', '初级Java');
INSERT INTO `chat_message` VALUES ('1556636093119774721', '1541299724478681090', '1551835815514251265', 2, '欢迎来我们公司面试[001][001][001]', 1, '2022-08-08 21:39:00', 0, '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `chat_message` VALUES ('1560448490394996737', '1560289757970927618', '1553737574100766721', 1, '笑死我了', 1, '2022-08-19 10:08:06', 1, '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `chat_message` VALUES ('1560453338712625154', '1560289757970927618', '1553737574100766721', 1, 'http://hire.t.mukewang.com/static/1560289757970927618/chatVideo/c047278d-9713-4102-a30b-8142b0ea22fe.jpg', 4, '2022-08-19 10:27:22', 1, 'http://hire.t.mukewang.com/static/1560289757970927618/chatVideo/c047278d-9713-4102-a30b-8142b0ea22fe.mp4', 220, 480, 9, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `chat_message` VALUES ('341430551904780288', '1541299724478681090', '1551835815514251265', 2, '看监控', 1, '2022-07-31 12:03:07', 1, '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `chat_message` VALUES ('341430593466138624', '1551835815514251265', '1541299724478681090', 1, 'fewfwe', 1, '2022-07-31 12:03:17', 0, '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `chat_message` VALUES ('341430609337384960', '1541299724478681090', '1551835815514251265', 2, '邻居同居', 1, '2022-07-31 12:03:21', 0, '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `chat_message` VALUES ('341432338690867200', '1541299724478681090', '1551835815514251265', 2, '哈哈哈', 1, '2022-07-31 12:10:13', 1, '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `chat_message` VALUES ('341432450204827648', '1541299724478681090', '1551835815514251265', 2, '', 3, '2022-07-31 12:10:40', 0, '', NULL, NULL, NULL, 'http://192.168.1.4:8000/static/1541299724478681090/chatVoice/c47ac049-3a07-489c-87e6-61766c479cde.mp3', 3, NULL, NULL, NULL, NULL);
INSERT INTO `chat_message` VALUES ('341433097746644992', '1541299724478681090', '1551835815514251265', 2, '', 3, '2022-07-31 12:13:14', 1, '', NULL, NULL, NULL, 'http://192.168.1.4:8000/static/1541299724478681090/chatVoice/1fdebd51-a9ac-4251-b0dc-4c36d4cded7c.mp3', 4, NULL, NULL, NULL, NULL);
INSERT INTO `chat_message` VALUES ('341433989057216512', '1551835815514251265', '1541299724478681090', 1, '多方额度期望', 1, '2022-07-31 12:16:47', 1, '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `chat_message` VALUES ('341434299033059328', '1541299724478681090', '1551835815514251265', 2, '看看', 1, '2022-07-31 12:18:00', 1, '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `chat_message` VALUES ('341434314581344256', '1541299724478681090', '1551835815514251265', 2, '', 3, '2022-07-31 12:18:04', 0, '', NULL, NULL, NULL, 'http://192.168.1.4:8000/static/1541299724478681090/chatVoice/19c04ae1-991b-43a7-a540-513ca38ddc3f.mp3', 2, NULL, NULL, NULL, NULL);
INSERT INTO `chat_message` VALUES ('341434656219987968', '1541299724478681090', '1551835815514251265', 2, '希望', 1, '2022-07-31 12:19:26', 1, '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `chat_message` VALUES ('341434680874106880', '1541299724478681090', '1551835815514251265', 2, '', 3, '2022-07-31 12:19:31', 0, '', NULL, NULL, NULL, 'http://192.168.1.4:8000/static/1541299724478681090/chatVoice/e2ee79ba-2e8e-4080-adb9-68356fbd6aae.mp3', 2, 1, NULL, NULL, NULL);
INSERT INTO `chat_message` VALUES ('341434878560043008', '1551835815514251265', '1541299724478681090', 1, 'fewfew', 1, '2022-07-31 12:20:19', 0, '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `chat_message` VALUES ('341434902224306176', '1541299724478681090', '1551835815514251265', 2, '', 3, '2022-07-31 12:20:24', 0, '', NULL, NULL, NULL, 'http://192.168.1.4:8000/static/1541299724478681090/chatVoice/7a6a3dff-e448-40d4-81a2-7c54498d84d0.mp3', 1, 1, NULL, NULL, NULL);
INSERT INTO `chat_message` VALUES ('341435582666244096', '1541299724478681090', '1551835815514251265', 2, '哈哈', 1, '2022-07-31 12:23:06', 1, '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `chat_message` VALUES ('341435603339968512', '1541299724478681090', '1551835815514251265', 2, '', 3, '2022-07-31 12:23:11', 0, '', NULL, NULL, NULL, 'http://192.168.1.4:8000/static/1541299724478681090/chatVoice/db4e51db-5d1f-45ac-a9b9-f29be4d4a8f5.mp3', 2, 1, NULL, NULL, NULL);
INSERT INTO `chat_message` VALUES ('341435666598461440', '1541299724478681090', '1551835815514251265', 2, '', 3, '2022-07-31 12:23:26', 0, '', NULL, NULL, NULL, 'http://192.168.1.4:8000/static/1541299724478681090/chatVoice/07231fee-eccf-4ca8-a864-01f8c1777025.mp3', 1, 1, NULL, NULL, NULL);
INSERT INTO `chat_message` VALUES ('341436123500773376', '1541299724478681090', '1551835815514251265', 2, ' KKK', 1, '2022-07-31 12:25:15', 1, '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `chat_message` VALUES ('341437604207525888', '1541299724478681090', '1551835815514251265', 2, '', 3, '2022-07-31 12:31:08', 1, '', NULL, NULL, NULL, 'http://192.168.1.4:8000/static/1541299724478681090/chatVoice/1c339905-823d-48ba-8d82-8e7c8bb171dd.mp3', 2, 1, NULL, NULL, NULL);
INSERT INTO `chat_message` VALUES ('341439163045773312', '1551835815514251265', '1541299724478681090', 1, '123', 1, '2022-07-31 12:37:20', 1, '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `chat_message` VALUES ('341439175280558080', '1541299724478681090', '1551835815514251265', 2, '', 3, '2022-07-31 12:37:23', 0, '', NULL, NULL, NULL, 'http://192.168.1.4:8000/static/1541299724478681090/chatVoice/af0c9a2e-503c-4dde-b11f-f6101ee908ac.mp3', 1, 1, NULL, NULL, NULL);
INSERT INTO `chat_message` VALUES ('341446306889203712', '1541299724478681090', '1551835815514251265', 2, '你跟你妈', 1, '2022-07-31 13:05:43', 1, '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `chat_message` VALUES ('341446324635303936', '1551835815514251265', '1541299724478681090', 1, '123', 1, '2022-07-31 13:05:48', 0, '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `chat_message` VALUES ('341446337499234304', '1541299724478681090', '1551835815514251265', 2, '哈哈', 1, '2022-07-31 13:05:51', 0, '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `chat_message` VALUES ('341446394910867456', '1541299724478681090', '1551835815514251265', 2, '', 3, '2022-07-31 13:06:04', 0, '', NULL, NULL, NULL, 'http://192.168.1.4:8000/static/1541299724478681090/chatVoice/c8a34f90-7124-45ca-9957-a06ade9ad258.mp3', 3, 1, NULL, NULL, NULL);
INSERT INTO `chat_message` VALUES ('341537287449870336', '1541299724478681090', '1551835815514251265', 2, '', 3, '2022-07-31 19:07:15', 1, '', NULL, NULL, NULL, 'http://192.168.1.10:8000/static/1541299724478681090/chatVoice/1af77bfd-aa72-4fc9-9142-b7488d960945.mp3', 2, 1, NULL, NULL, NULL);
INSERT INTO `chat_message` VALUES ('341537365719777280', '1551835815514251265', '1541299724478681090', 1, '', 3, '2022-07-31 19:07:33', 0, '', NULL, NULL, NULL, 'http://192.168.1.10:8000/static/1551835815514251265/chatVoice/8b037774-491c-4c08-af9f-357061399646.mp3', 1, 1, NULL, NULL, NULL);
INSERT INTO `chat_message` VALUES ('341537431100588032', '1551835815514251265', '1541299724478681090', 1, '', 3, '2022-07-31 19:07:49', 0, '', NULL, NULL, NULL, 'http://192.168.1.10:8000/static/1551835815514251265/chatVoice/03ec3796-7164-42c5-8eeb-462141f14583.mp3', 1, 0, NULL, NULL, NULL);
INSERT INTO `chat_message` VALUES ('341537512524611584', '1541299724478681090', '1551835815514251265', 2, '', 3, '2022-07-31 19:08:08', 0, '', NULL, NULL, NULL, 'http://192.168.1.10:8000/static/1541299724478681090/chatVoice/7edf2fab-264e-47c6-a3ff-919f30a4f148.mp3', 1, 1, NULL, NULL, NULL);
INSERT INTO `chat_message` VALUES ('341537623820468224', '1551835815514251265', '1541299724478681090', 1, '', 3, '2022-07-31 19:08:35', 0, '', NULL, NULL, NULL, 'http://192.168.1.10:8000/static/1551835815514251265/chatVoice/242b0e55-5384-41f0-89ad-51ef8264692c.mp3', 1, 0, NULL, NULL, NULL);
INSERT INTO `chat_message` VALUES ('341538088180252672', '1541299724478681090', '1551835815514251265', 2, '', 3, '2022-07-31 19:10:26', 1, '', NULL, NULL, NULL, 'http://192.168.1.10:8000/static/1541299724478681090/chatVoice/cf493d7d-10d6-46a0-974c-e159cd98e44c.mp3', 1, 0, NULL, NULL, NULL);
INSERT INTO `chat_message` VALUES ('341538176763953152', '1541299724478681090', '1551835815514251265', 2, '', 3, '2022-07-31 19:10:47', 0, '', NULL, NULL, NULL, 'http://192.168.1.10:8000/static/1541299724478681090/chatVoice/62d1c1eb-a630-41c0-b62c-edadfce1fac2.mp3', 1, 0, NULL, NULL, NULL);
INSERT INTO `chat_message` VALUES ('341538870183067648', '1541299724478681090', '1551835815514251265', 2, '是', 1, '2022-07-31 19:13:32', 1, '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `chat_message` VALUES ('341538889808216064', '1541299724478681090', '1551835815514251265', 2, '', 3, '2022-07-31 19:13:37', 0, '', NULL, NULL, NULL, 'http://192.168.1.10:8000/static/1541299724478681090/chatVoice/8c26979c-a92c-4091-975d-a6556cf5b28c.mp3', 1, 1, NULL, NULL, NULL);
INSERT INTO `chat_message` VALUES ('341539113154904064', '1541299724478681090', '1551835815514251265', 2, '', 3, '2022-07-31 19:14:30', 0, '', NULL, NULL, NULL, 'http://192.168.1.10:8000/static/1541299724478681090/chatVoice/e5b27cd9-d414-4dc9-a812-e11b5e9000ba.mp3', 2, 1, NULL, NULL, NULL);
INSERT INTO `chat_message` VALUES ('341539164249915392', '1551835815514251265', '1541299724478681090', 1, '', 3, '2022-07-31 19:14:42', 0, '', NULL, NULL, NULL, 'http://192.168.1.10:8000/static/1551835815514251265/chatVoice/e1eeff42-3fbf-4280-be06-76cdcd41a1bf.mp3', 1, 0, NULL, NULL, NULL);
INSERT INTO `chat_message` VALUES ('341539191802298368', '1551835815514251265', '1541299724478681090', 1, '', 3, '2022-07-31 19:14:49', 0, '', NULL, NULL, NULL, 'http://192.168.1.10:8000/static/1551835815514251265/chatVoice/e2e8304a-8060-46ab-b7e4-1e810b312f85.mp3', 1, 0, NULL, NULL, NULL);
INSERT INTO `chat_message` VALUES ('341539234772942848', '1541299724478681090', '1551835815514251265', 2, '', 3, '2022-07-31 19:14:59', 0, '', NULL, NULL, NULL, 'http://192.168.1.10:8000/static/1541299724478681090/chatVoice/1a846fd5-60e4-4644-9a3c-118f4fabc843.mp3', 1, 0, NULL, NULL, NULL);
INSERT INTO `chat_message` VALUES ('341539259158626304', '1551835815514251265', '1541299724478681090', 1, '', 3, '2022-07-31 19:15:05', 0, '', NULL, NULL, NULL, 'http://192.168.1.10:8000/static/1551835815514251265/chatVoice/39f769d9-0ce7-414c-90cc-e01c44868b06.mp3', 2, 1, NULL, NULL, NULL);
INSERT INTO `chat_message` VALUES ('341539533726154752', '1551835815514251265', '1541299724478681090', 1, '', 3, '2022-07-31 19:16:10', 1, '', NULL, NULL, NULL, 'http://192.168.1.10:8000/static/1551835815514251265/chatVoice/20fd0a64-74ef-4d38-8064-bf2c43553236.mp3', 1, 1, NULL, NULL, NULL);
INSERT INTO `chat_message` VALUES ('341539546132905984', '1541299724478681090', '1551835815514251265', 2, 'KKK', 1, '2022-07-31 19:16:13', 0, '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `chat_message` VALUES ('341561879463723008', '1551835815514251265', '1541299724478681090', 1, '', 5, '2022-07-31 20:44:58', 1, '', NULL, NULL, NULL, NULL, NULL, NULL, '1551835815514251265', '我是求职的', '初级Java');
INSERT INTO `chat_message` VALUES ('341562267948548096', '1551835815514251265', '1541299724478681090', 1, '', 5, '2022-07-31 20:46:31', 1, '', NULL, NULL, NULL, NULL, NULL, NULL, '1551835815514251265', '我是求职的', '初级Java');
INSERT INTO `chat_message` VALUES ('341562361217286144', '1551835815514251265', '1541299724478681090', 1, '', 5, '2022-07-31 20:46:53', 0, '', NULL, NULL, NULL, NULL, NULL, NULL, '1551835815514251265', '我是求职的', '初级Java');
INSERT INTO `chat_message` VALUES ('341562368511180800', '1551835815514251265', '1541299724478681090', 1, '', 5, '2022-07-31 20:46:55', 0, '', NULL, NULL, NULL, NULL, NULL, NULL, '1551835815514251265', '我是求职的', '初级Java');
INSERT INTO `chat_message` VALUES ('341563044284858368', '1551835815514251265', '1541299724478681090', 1, '分为赴美我就佛文件莫if及偶尔玩if饿哦i分为赴美我就佛文件莫if及偶尔玩if饿哦i分为赴美我就佛文件莫if及偶尔玩if饿哦i分为赴美我就佛文件莫if及偶尔玩if饿哦i分为赴美我就佛文件莫if及偶尔玩if饿哦i分为赴美我就佛文件莫if及偶尔玩if饿哦i分为赴美我就佛文件莫if及偶尔玩if饿哦i分为赴美我就佛文件莫if及偶尔玩if饿哦i', 1, '2022-07-31 20:49:36', 1, '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `chat_message` VALUES ('341563408400777216', '1551835815514251265', '1541299724478681090', 1, '', 5, '2022-07-31 20:51:03', 1, '', NULL, NULL, NULL, NULL, NULL, NULL, '1551835815514251265', '我是求职的', '初级Java');
INSERT INTO `chat_message` VALUES ('341564451444490240', '1551835815514251265', '1541299724478681090', 1, '', 5, '2022-07-31 20:55:11', 0, '', NULL, NULL, NULL, NULL, NULL, NULL, '1551835815514251265', '我是求职的', '初级Java');
INSERT INTO `chat_message` VALUES ('341564905167519744', '1551835815514251265', '1541299724478681090', 1, '', 5, '2022-07-31 20:56:59', 1, '', NULL, NULL, NULL, NULL, NULL, NULL, '1551835815514251265', '我是求职的', '初级Java');
INSERT INTO `chat_message` VALUES ('341564913942003712', '1551835815514251265', '1541299724478681090', 1, '', 5, '2022-07-31 20:57:01', 0, '', NULL, NULL, NULL, NULL, NULL, NULL, '1551835815514251265', '我是求职的', '初级Java');
INSERT INTO `chat_message` VALUES ('341565293044170752', '1541299724478681090', '1551835815514251265', 2, '好的', 1, '2022-07-31 20:58:32', 1, '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `chat_message` VALUES ('341565328645423104', '1551835815514251265', '1541299724478681090', 1, '', 5, '2022-07-31 20:58:40', 0, '', NULL, NULL, NULL, NULL, NULL, NULL, '1551835815514251265', '我是求职的', '初级Java');
INSERT INTO `chat_message` VALUES ('341568040078409728', '1551835815514251265', '1541299724478681090', 1, '', 5, '2022-07-31 21:09:27', 0, '', NULL, NULL, NULL, NULL, NULL, NULL, '1551835815514251265', '我是求职的', '初级Java');
INSERT INTO `chat_message` VALUES ('341568059992965120', '1551835815514251265', '1541299724478681090', 1, '', 5, '2022-07-31 21:09:32', 0, '', NULL, NULL, NULL, NULL, NULL, NULL, '1551835815514251265', '我是求职的', '初级Java');
INSERT INTO `chat_message` VALUES ('341568082470240256', '1551835815514251265', '1541299724478681090', 1, '', 3, '2022-07-31 21:09:37', 0, '', NULL, NULL, NULL, 'http://192.168.1.10:8000/static/1551835815514251265/chatVoice/ae65e0e7-f4ec-4f87-ab6e-c7431614ce19.mp3', 2, 0, NULL, NULL, NULL);
INSERT INTO `chat_message` VALUES ('341572506223640576', '1541299724478681090', '1541299724478681090', 1, '你明明', 1, '2022-07-31 21:27:12', 1, '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `chat_message` VALUES ('341572521595764736', '1541299724478681090', '1541299724478681090', 1, '1664', 1, '2022-07-31 21:27:15', 0, '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `chat_message` VALUES ('341573158219808768', '1541299724478681090', '1541299724478681090', 1, '听你', 1, '2022-07-31 21:29:47', 1, '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `chat_message` VALUES ('341573168437133312', '1541299724478681090', '1541299724478681090', 1, '哦哦哦', 1, '2022-07-31 21:29:49', 0, '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `chat_message` VALUES ('341573268093796352', '1541299724478681090', '1541299724478681090', 2, 'KKK', 1, '2022-07-31 21:30:13', 0, '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `chat_message` VALUES ('341573325513818112', '1541299724478681090', '1541299724478681090', 2, '的', 1, '2022-07-31 21:30:27', 0, '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `chat_message` VALUES ('341573415829766144', '1541299724478681090', '1541299724478681090', 2, '九龙', 1, '2022-07-31 21:30:48', 0, '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `chat_message` VALUES ('341573471072944128', '1541299724478681090', '1541299724478681090', 2, '数据库', 1, '2022-07-31 21:31:02', 0, '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `chat_message` VALUES ('341576579903651840', '1541299724478681090', '1551835815514251265', 2, '哈哈', 1, '2022-07-31 21:43:23', 0, '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `chat_message` VALUES ('341579061203566592', '1541299724478681090', '1551835815514251265', 2, '惠山区', 1, '2022-07-31 21:53:14', 1, '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `chat_message` VALUES ('341609728683540480', '1541299724478681090', '1551835815514251265', 2, 'http://192.168.1.10:8000/static/1541299724478681090/chatPhoto/3d8810e4-e482-4f40-a582-0d62e4e1adc3.JPG', 2, '2022-07-31 23:55:06', 1, '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `chat_message` VALUES ('341611701113716736', '1541299724478681090', '1551835815514251265', 2, '哈哈', 1, '2022-08-01 00:02:56', 0, '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `chat_message` VALUES ('341780836422516736', '1541299724478681090', '1551835815514251265', 2, '模糊', 1, '2022-08-01 11:15:01', 1, '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `chat_message` VALUES ('341790634840948736', '1541299724478681090', '1551835815514251265', 2, '秃头', 1, '2022-08-01 11:53:58', 1, '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `chat_message` VALUES ('341791098298957824', '1541299724478681090', '1551835815514251265', 2, '那就', 1, '2022-08-01 11:55:48', 1, '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `chat_message` VALUES ('341791124379140096', '1541299724478681090', '1551835815514251265', 2, '1553952636212199426', 7, '2022-08-01 11:55:54', 0, '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `chat_message` VALUES ('341792295563034624', '1541299724478681090', '1551835815514251265', 2, 'KKK', 1, '2022-08-01 12:00:33', 1, '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `chat_message` VALUES ('341792325262901248', '1541299724478681090', '1551835815514251265', 2, '1553953837112737794', 7, '2022-08-01 12:00:41', 0, '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `chat_message` VALUES ('341792430380548096', '1541299724478681090', '1551835815514251265', 2, '1553953942289104898', 7, '2022-08-01 12:01:06', 0, '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `chat_message` VALUES ('341834929283268608', '1541299724478681090', '1551835815514251265', 2, '1553953942289104898', 71, '2022-08-01 14:49:58', 0, '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `chat_message` VALUES ('341834961248059392', '1541299724478681090', '1551835815514251265', 2, '1553953837112737794', 71, '2022-08-01 14:50:06', 0, '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `chat_message` VALUES ('341834983754694656', '1541299724478681090', '1551835815514251265', 2, 'two', 1, '2022-08-01 14:50:11', 0, '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `chat_message` VALUES ('341834993640669184', '1541299724478681090', '1551835815514251265', 2, '哦哦', 1, '2022-08-01 14:50:13', 0, '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `chat_message` VALUES ('341835010757623808', '1541299724478681090', '1551835815514251265', 2, '录制', 1, '2022-08-01 14:50:18', 0, '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `chat_message` VALUES ('341835075471540224', '1551835815514251265', '1541299724478681090', 1, 'r32r', 1, '2022-08-01 14:50:33', 0, '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `chat_message` VALUES ('341835091078545408', '1551835815514251265', '1541299724478681090', 1, 'r32.', 1, '2022-08-01 14:50:37', 0, '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `chat_message` VALUES ('341835100062744576', '1541299724478681090', '1551835815514251265', 2, '停课了', 1, '2022-08-01 14:50:39', 0, '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `chat_message` VALUES ('341835116886097920', '1541299724478681090', '1551835815514251265', 2, '哦哦', 1, '2022-08-01 14:50:43', 0, '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `chat_message` VALUES ('341835129489981440', '1551835815514251265', '1541299724478681090', 1, '21', 1, '2022-08-01 14:50:46', 0, '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `chat_message` VALUES ('341835218870599680', '1551835815514251265', '1541299724478681090', 1, 'dwdwdqw', 1, '2022-08-01 14:51:07', 0, '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `chat_message` VALUES ('341835241100410880', '1541299724478681090', '1551835815514251265', 2, '哦哦', 1, '2022-08-01 14:51:12', 0, '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `chat_message` VALUES ('341835251800080384', '1551835815514251265', '1541299724478681090', 1, 'r32e32', 1, '2022-08-01 14:51:15', 0, '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `chat_message` VALUES ('341836357842239488', '1541299724478681090', '1551835815514251265', 2, '1553953942289104898', 71, '2022-08-01 14:55:39', 0, '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `chat_message` VALUES ('341836383414910976', '1551835815514251265', '1541299724478681090', 1, '分为分为', 1, '2022-08-01 14:55:45', 0, '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `chat_message` VALUES ('341836424720416768', '1541299724478681090', '1551835815514251265', 2, '1553953837112737794', 71, '2022-08-01 14:55:55', 0, '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `chat_message` VALUES ('341836498355617792', '1551835815514251265', '1541299724478681090', 1, '1553953942289104898', 73, '2022-08-01 14:56:12', 0, '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `chat_message` VALUES ('341836781089456128', '1551835815514251265', '1541299724478681090', 1, '1553953837112737794', 73, '2022-08-01 14:57:20', 0, '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `chat_message` VALUES ('341838334290558976', '1551835815514251265', '1541299724478681090', 1, '1553953942289104898', 72, '2022-08-01 15:03:30', 0, '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `chat_message` VALUES ('341838377760325632', '1551835815514251265', '1541299724478681090', 1, '1553953837112737794', 72, '2022-08-01 15:03:40', 0, '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `chat_message` VALUES ('341847139200008192', '1551835815514251265', '1541299724478681090', 1, '123123', 1, '2022-08-01 15:38:29', 0, '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `chat_message` VALUES ('341893652160708608', '1541299724478681090', '1551835815514251265', 2, '哈哈', 1, '2022-08-01 18:43:19', 1, '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `chat_message` VALUES ('341893697551466496', '1541299724478681090', '1551835815514251265', 2, '1554055209115983873', 7, '2022-08-01 18:43:30', 0, '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `chat_message` VALUES ('341893728530595840', '1541299724478681090', '1551835815514251265', 2, '1554055209115983873', 71, '2022-08-01 18:43:37', 0, '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `chat_message` VALUES ('341893889281490944', '1541299724478681090', '1551835815514251265', 2, '哈哈', 1, '2022-08-01 18:44:15', 0, '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `chat_message` VALUES ('341894121603989504', '1541299724478681090', '1551835815514251265', 2, '哈哈哈', 1, '2022-08-01 18:45:11', 0, '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `chat_message` VALUES ('341894153178710016', '1541299724478681090', '1551835815514251265', 2, '[003][002]', 1, '2022-08-01 18:45:18', 0, '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `chat_message` VALUES ('341894186657644544', '1541299724478681090', '1551835815514251265', 2, 'http://192.168.1.10:8000/static/1541299724478681090/chatPhoto/c6746029-5866-45c1-9bc3-76f04c28fc99.jpg', 2, '2022-08-01 18:45:26', 0, '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `chat_message` VALUES ('341894240302792704', '1541299724478681090', '1551835815514251265', 2, 'http://192.168.1.10:8000/static/1541299724478681090/chatVideo/e131e191-341d-4e2c-9839-d4afcde90d50.jpg', 4, '2022-08-01 18:45:39', 0, 'http://192.168.1.10:8000/static/1541299724478681090/chatVideo/e131e191-341d-4e2c-9839-d4afcde90d50.mp4', 320, 184, 12, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `chat_message` VALUES ('341894280249344000', '1551835815514251265', '1541299724478681090', 1, '123', 1, '2022-08-01 18:45:49', 0, '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `chat_message` VALUES ('341894329561776128', '1541299724478681090', '1551835815514251265', 2, '1554055841457643521', 7, '2022-08-01 18:46:00', 0, '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `chat_message` VALUES ('341894369730625536', '1541299724478681090', '1551835815514251265', 2, '1554055841457643521', 71, '2022-08-01 18:46:10', 0, '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `chat_message` VALUES ('341894404140695552', '1541299724478681090', '1551835815514251265', 2, '哈哈', 1, '2022-08-01 18:46:18', 0, '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `chat_message` VALUES ('341894419894501376', '1541299724478681090', '1551835815514251265', 2, '饿了客厅', 1, '2022-08-01 18:46:22', 0, '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `chat_message` VALUES ('341894510407581696', '1541299724478681090', '1551835815514251265', 2, '1554056022349586433', 7, '2022-08-01 18:46:43', 0, '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `chat_message` VALUES ('341894532008247296', '1551835815514251265', '1541299724478681090', 1, '1554056022349586433', 73, '2022-08-01 18:46:49', 0, '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `chat_message` VALUES ('341895519284494336', '1541299724478681090', '1551835815514251265', 2, '1554057031096475650', 7, '2022-08-01 18:50:44', 1, '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `chat_message` VALUES ('341895600310059008', '1541299724478681090', '1551835815514251265', 2, '看看', 1, '2022-08-01 18:51:03', 0, '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `chat_message` VALUES ('341895757378355200', '1551835815514251265', '1541299724478681090', 1, '看看', 1, '2022-08-01 18:51:41', 0, '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `chat_message` VALUES ('341895859241222144', '1541299724478681090', '1551835815514251265', 2, '停课了', 1, '2022-08-01 18:52:05', 0, '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `chat_message` VALUES ('341895880376320000', '1551835815514251265', '1541299724478681090', 1, '123', 1, '2022-08-01 18:52:10', 0, '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `chat_message` VALUES ('341895904258686976', '1551835815514251265', '1541299724478681090', 1, '噜噜噜', 1, '2022-08-01 18:52:16', 0, '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `chat_message` VALUES ('341896155992424448', '1551835815514251265', '1541299724478681090', 1, '屠龙记', 1, '2022-08-01 18:53:16', 0, '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `chat_message` VALUES ('341896168386592768', '1541299724478681090', '1551835815514251265', 2, '妥', 1, '2022-08-01 18:53:19', 0, '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `chat_message` VALUES ('341925396704395264', '1551835815514251265', '1541299724478681090', 1, 'gregre ', 1, '2022-08-01 20:49:27', 1, '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `chat_message` VALUES ('341925414253363200', '1551835815514251265', '1541299724478681090', 1, 'rewrwe', 1, '2022-08-01 20:49:31', 0, '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `chat_message` VALUES ('341925434566377472', '1541299724478681090', '1551835815514251265', 2, '可以摸', 1, '2022-08-01 20:49:36', 0, '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `chat_message` VALUES ('341925580297469952', '1541299724478681090', '1551835815514251265', 2, '[004]', 1, '2022-08-01 20:50:11', 0, '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `chat_message` VALUES ('341925803086315520', '1541299724478681090', '1551835815514251265', 2, '[004]', 1, '2022-08-01 20:51:04', 0, '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `chat_message` VALUES ('341925856307838976', '1551835815514251265', '1541299724478681090', 1, '[003][015][005]', 1, '2022-08-01 20:51:17', 0, '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `chat_message` VALUES ('341925914910654464', '1541299724478681090', '1551835815514251265', 2, '[002][003]', 1, '2022-08-01 20:51:31', 0, '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `chat_message` VALUES ('341926053570150400', '1541299724478681090', '1551835815514251265', 2, '[003]', 1, '2022-08-01 20:52:04', 0, '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `chat_message` VALUES ('341928224185384960', '1541299724478681090', '1551835815514251265', 2, '[004]', 1, '2022-08-01 21:00:41', 1, '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `chat_message` VALUES ('341928362970710016', '1541299724478681090', '1551835815514251265', 2, '图灵', 1, '2022-08-01 21:01:14', 0, '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `chat_message` VALUES ('341928769226801152', '1541299724478681090', '1551835815514251265', 2, '[001][002]', 1, '2022-08-01 21:02:51', 1, '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `chat_message` VALUES ('341928796707880960', '1541299724478681090', '1551835815514251265', 2, '[003][001][002][010][012]', 1, '2022-08-01 21:02:58', 0, '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `chat_message` VALUES ('341928817763287040', '1541299724478681090', '1551835815514251265', 2, '[012][012][012][012]', 1, '2022-08-01 21:03:03', 0, '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `chat_message` VALUES ('341933142795354112', '1551835815514251265', '1541299724478681090', 1, 'rw', 1, '2022-08-01 21:20:14', 1, '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `chat_message` VALUES ('341933150907138048', '1551835815514251265', '1541299724478681090', 1, 'rwqr', 1, '2022-08-01 21:20:16', 0, '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `chat_message` VALUES ('341933175334764544', '1551835815514251265', '1541299724478681090', 1, 'gergre', 1, '2022-08-01 21:20:22', 0, '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `chat_message` VALUES ('341933328204562432', '1541299724478681090', '1551835815514251265', 2, '来咯来咯', 1, '2022-08-01 21:20:58', 0, '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `chat_message` VALUES ('341933337062932480', '1541299724478681090', '1551835815514251265', 2, '看到', 1, '2022-08-01 21:21:00', 0, '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `chat_message` VALUES ('341934410175610880', '1541299724478681090', '1551835815514251265', 2, '哈哈哈', 1, '2022-08-01 21:25:16', 1, '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `chat_message` VALUES ('341934440773058560', '1541299724478681090', '1551835815514251265', 2, '醒酒', 1, '2022-08-01 21:25:24', 0, '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `chat_message` VALUES ('341934467025207296', '1541299724478681090', '1551835815514251265', 2, '司机', 1, '2022-08-01 21:25:30', 0, '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `chat_message` VALUES ('341934480430202880', '1541299724478681090', '1551835815514251265', 2, '魔喉', 1, '2022-08-01 21:25:33', 0, '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `chat_message` VALUES ('341934494313349120', '1541299724478681090', '1551835815514251265', 2, '可得提提', 1, '2022-08-01 21:25:36', 0, '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `chat_message` VALUES ('341934512713760768', '1541299724478681090', '1551835815514251265', 2, '哈哈哈哈哈', 1, '2022-08-01 21:25:41', 0, '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `chat_message` VALUES ('341934526185865216', '1541299724478681090', '1551835815514251265', 2, '[002][012][010]', 1, '2022-08-01 21:25:44', 0, '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `chat_message` VALUES ('341934554581303296', '1541299724478681090', '1551835815514251265', 2, '[003]', 1, '2022-08-01 21:25:51', 0, '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `chat_message` VALUES ('341935437364854784', '1541299724478681090', '1554096527766749186', 2, '你好', 1, '2022-08-01 21:29:21', 1, '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `chat_message` VALUES ('341935448903385088', '1541299724478681090', '1554096527766749186', 2, '哈哈哈', 1, '2022-08-01 21:29:24', 0, '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `chat_message` VALUES ('341935471946891264', '1554096527766749186', '1541299724478681090', 1, '可以', 1, '2022-08-01 21:29:29', 0, '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `chat_message` VALUES ('341935498693967872', '1554096527766749186', '1541299724478681090', 1, '来来来', 1, '2022-08-01 21:29:36', 0, '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `chat_message` VALUES ('341935520605011968', '1554096527766749186', '1541299724478681090', 1, '哪里哪里', 1, '2022-08-01 21:29:41', 0, '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `chat_message` VALUES ('341943004816211968', '1554096527766749186', '1541299724478681090', 1, '设计思路哭了', 1, '2022-08-01 21:59:25', 0, '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `chat_message` VALUES ('342695671687544832', '1551835815514251265', '1541299724478681090', 1, '123', 1, '2022-08-03 23:50:15', 0, '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `chat_message` VALUES ('342695690306060288', '1551835815514251265', '1541299724478681090', 1, '5965965', 1, '2022-08-03 23:50:20', 0, '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `chat_message` VALUES ('342695709385949184', '1541299724478681090', '1551835815514251265', 2, '好的', 1, '2022-08-03 23:50:24', 0, '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `chat_message` VALUES ('342695725311721472', '1541299724478681090', '1551835815514251265', 2, 'h', 1, '2022-08-03 23:50:28', 0, '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `chat_message` VALUES ('342698264451088384', '1541299724478681090', '1551835815514251265', 2, '把', 1, '2022-08-04 00:00:33', 0, '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `chat_message` VALUES ('342698278288097280', '1551835815514251265', '1541299724478681090', 1, '8', 1, '2022-08-04 00:00:37', 0, '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `chat_message` VALUES ('342698288849354752', '1551835815514251265', '1541299724478681090', 1, '9', 1, '2022-08-04 00:00:39', 0, '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `chat_message` VALUES ('342698301033807872', '1551835815514251265', '1541299724478681090', 1, '10', 1, '2022-08-04 00:00:42', 0, '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `chat_message` VALUES ('342698308310925312', '1551835815514251265', '1541299724478681090', 1, '11', 1, '2022-08-04 00:00:44', 0, '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `chat_message` VALUES ('342698315223138304', '1551835815514251265', '1541299724478681090', 1, '12', 1, '2022-08-04 00:00:45', 0, '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `chat_message` VALUES ('342698344247721984', '1551835815514251265', '1541299724478681090', 1, '13', 1, '2022-08-04 00:00:52', 0, '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `chat_message` VALUES ('342698355589120000', '1551835815514251265', '1541299724478681090', 1, '14', 1, '2022-08-04 00:00:55', 0, '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `chat_message` VALUES ('342698365722558464', '1551835815514251265', '1541299724478681090', 1, '15', 1, '2022-08-04 00:00:57', 0, '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `chat_message` VALUES ('342698377030402048', '1551835815514251265', '1541299724478681090', 1, '16', 1, '2022-08-04 00:01:00', 0, '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `chat_message` VALUES ('342698386622775296', '1551835815514251265', '1541299724478681090', 1, '17', 1, '2022-08-04 00:01:02', 0, '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `chat_message` VALUES ('342698397326639104', '1551835815514251265', '1541299724478681090', 1, '18', 1, '2022-08-04 00:01:05', 0, '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `chat_message` VALUES ('342698406457638912', '1551835815514251265', '1541299724478681090', 1, '19', 1, '2022-08-04 00:01:07', 0, '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `chat_message` VALUES ('342698415919988736', '1551835815514251265', '1541299724478681090', 1, '20', 1, '2022-08-04 00:01:09', 0, '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `chat_message` VALUES ('342698423033528320', '1551835815514251265', '1541299724478681090', 1, 'r23r', 1, '2022-08-04 00:01:11', 0, '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `chat_message` VALUES ('342698432961445888', '1551835815514251265', '1541299724478681090', 1, 'gtr', 1, '2022-08-04 00:01:13', 0, '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `chat_message` VALUES ('342698438934134784', '1551835815514251265', '1541299724478681090', 1, 'hrt', 1, '2022-08-04 00:01:15', 0, '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `chat_message` VALUES ('342698449470226432', '1551835815514251265', '1541299724478681090', 1, '3t45g54', 1, '2022-08-04 00:01:17', 0, '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `chat_message` VALUES ('342698456780898304', '1551835815514251265', '1541299724478681090', 1, 'jnytht', 1, '2022-08-04 00:01:19', 0, '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `chat_message` VALUES ('342698463026216960', '1551835815514251265', '1541299724478681090', 1, 'h6yg45', 1, '2022-08-04 00:01:21', 0, '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `chat_message` VALUES ('342698472962523136', '1551835815514251265', '1541299724478681090', 1, 'njtyhyt', 1, '2022-08-04 00:01:23', 0, '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `chat_message` VALUES ('342698480306749440', '1551835815514251265', '1541299724478681090', 1, 'y54y', 1, '2022-08-04 00:01:25', 0, '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `chat_message` VALUES ('342698488359813120', '1551835815514251265', '1541299724478681090', 1, 'hnytjnmt', 1, '2022-08-04 00:01:27', 0, '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `chat_message` VALUES ('344474423388012544', '1541299724478681090', '1551835815514251265', 2, '好的', 1, '2022-08-08 21:38:23', 0, '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `chat_message` VALUES ('344474450776817664', '1541299724478681090', '1551835815514251265', 2, '收到', 1, '2022-08-08 21:38:29', 0, '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `chat_message` VALUES ('344474490845003776', '1541299724478681090', '1551835815514251265', 2, '1556636002573123586', 7, '2022-08-08 21:38:39', 0, '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `chat_message` VALUES ('344474914738143232', '1551835815514251265', '1541299724478681090', 1, '收到', 1, '2022-08-08 21:40:20', 1, '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `chat_message` VALUES ('344474953942302720', '1541299724478681090', '1551835815514251265', 2, '', 3, '2022-08-08 21:40:29', 0, '', NULL, NULL, NULL, 'http://192.168.1.10:8000/static/1541299724478681090/chatVoice/c436d34b-93cc-41de-af43-f73b722e5828.mp3', 6, 0, NULL, NULL, NULL);
INSERT INTO `chat_message` VALUES ('344475033202065408', '1541299724478681090', '1551835815514251265', 2, 'http://192.168.1.10:8000/static/1541299724478681090/chatVideo/98acf29d-ad46-4403-bd7c-098b28c32528.jpg', 4, '2022-08-08 21:40:48', 0, 'http://192.168.1.10:8000/static/1541299724478681090/chatVideo/98acf29d-ad46-4403-bd7c-098b28c32528.mp4', 220, 480, 9, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `chat_message` VALUES ('344475122649792512', '1541299724478681090', '1551835815514251265', 2, 'http://192.168.1.10:8000/static/1541299724478681090/chatPhoto/7e1cce42-421f-40b1-9ace-7140da3c5d0d.PNG', 2, '2022-08-08 21:41:09', 0, '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `chat_message` VALUES ('348287496624275456', '1560289757970927618', '1553737574100766721', 1, '在吗', 1, '2022-08-19 10:10:10', 1, '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `chat_message` VALUES ('348287641264848896', '1553737574100766721', '1560289757970927618', 2, '咋个？', 1, '2022-08-19 10:10:45', 0, '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `chat_message` VALUES ('348287667739295744', '1560289757970927618', '1553737574100766721', 1, '', 3, '2022-08-19 10:10:51', 0, '', NULL, NULL, NULL, 'http://hire.t.mukewang.com/static/1560289757970927618/chatVoice/2aaaf061-e33d-417e-9edf-cc2c36cb5ff9.mp3', 4, 1, NULL, NULL, NULL);
INSERT INTO `chat_message` VALUES ('348287966193385472', '1560289757970927618', '1553737574100766721', 1, 'http://hire.t.mukewang.com/static/1560289757970927618/chatVideo/9d955bc0-3d13-432a-9652-40a5601be118.jpg', 4, '2022-08-19 10:12:02', 1, 'http://hire.t.mukewang.com/static/1560289757970927618/chatVideo/9d955bc0-3d13-432a-9652-40a5601be118.mp4', 360, 640, 75, NULL, NULL, NULL, NULL, NULL, NULL);
COMMIT;

-- ----------------------------
-- Table structure for company
-- ----------------------------
DROP TABLE IF EXISTS `company`;
CREATE TABLE `company` (
  `id` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `company_name` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '企业名称',
  `short_name` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '企业短名',
  `logo` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '企业logo',
  `biz_license` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '营业执照',
  `country` varchar(24) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '企业所在国家',
  `province` varchar(24) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '所在省份',
  `city` varchar(24) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '所在市',
  `district` varchar(24) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '所在区县',
  `address` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '公司办公地址',
  `nature` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '公司性质',
  `people_size` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '人员规模/企业规模',
  `industry` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '所在行业',
  `financ_stage` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '融资阶段',
  `work_time` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '工作时间，例：9:00-18:00 周末单休',
  `introduction` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '公司简介',
  `advantage` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '公司优势，例：领导和睦 岗位晋升\n',
  `benefits` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '福利待遇，例：五险一金 定期体检\n',
  `bonus` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '薪资福利（奖金），例：年底双薪',
  `subsidy` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '补助津贴，例：住房补贴',
  `build_date` date DEFAULT NULL COMMENT '成立时间',
  `regist_capital` varchar(24) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '注册资本',
  `regist_place` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '注册地址',
  `legal_representative` varchar(24) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '法人代表',
  `review_status` int NOT NULL DEFAULT '0' COMMENT '审核状态\n0：未发起审核认证(未进入审核流程)\n1：审核认证通过\n2：审核认证失败\n3：审核中（等待审核）',
  `review_replay` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '审核回复/审核意见',
  `auth_letter` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '入驻平台授权书',
  `commit_user_id` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '提交申请人的用户id',
  `commit_user_mobile` varchar(11) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '提交申请人的手机号',
  `commit_date` date DEFAULT NULL COMMENT '提交审核的日期',
  `is_vip` int NOT NULL COMMENT '0: 否  1: 是',
  `vip_expire_date` date DEFAULT NULL COMMENT 'Vip过期日期，判断企业是否vip，需要is_vip=1并且过期日期>=当前日期',
  `created_time` datetime NOT NULL,
  `updated_time` datetime NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE KEY `company_name` (`company_name`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='企业表';

-- ----------------------------
-- Records of company
-- ----------------------------
BEGIN;
INSERT INTO `company` VALUES ('1001', '江苏好厉害科技有限公司', '好厉害科技', 'http://122.152.205.72:88/group1/M00/00/05/CpoxxF6ZUySASMbOAABBAXhjY0Y649.png', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, 0, NULL, '2022-06-13 11:28:59', '2022-06-13 11:29:06');
INSERT INTO `company` VALUES ('1538744733746421761', '很牛逼公司', '大牛', 'http://192.168.1.4:8000/static/bizLicense/ef72dd93-21a6-48ec-85bf-00b7d70d4c87.png', 'http://192.168.1.5:8000/static/bizLicense/ef72dd93-21a6-48ec-85bf-00b7d70d4c87.png', NULL, NULL, NULL, NULL, NULL, NULL, '100人', '高科技', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, 1, '2022-07-19', '2022-06-20 12:45:08', '2022-06-20 12:45:08');
INSERT INTO `company` VALUES ('1538749984465575938', '哈哈哈公司', 'aa', 'http://192.168.1.4:8000/static/logo/4d09e3fc-1748-41da-b3a8-56d659c5e00a.jpeg', 'http://192.168.1.5:8000/static/bizLicense/4c1f6e1f-ff80-4025-8e60-71ba24999e97.png', NULL, NULL, NULL, NULL, NULL, NULL, '100-499人', '广告/传媒/文化/体育', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, '通过啦~~ 13812345699', 'http://192.168.1.5:8000/static/bizLicense/ef72dd93-21a6-48ec-85bf-00b7d70d4c87.png', '1536563316312514561', '13812345699', '2022-06-25', 1, '2022-07-18', '2022-06-20 13:06:00', '2022-06-27 12:53:16');
INSERT INTO `company` VALUES ('1538911263268315137', '大头娃娃', '大头', 'http://192.168.1.10:8000/static/logo/e6b7bf65-9bcc-44e4-adff-0b5a0f58ec30.png', 'http://192.168.1.10:8000/static/bizLicense/a6337642-c1f6-4845-8bff-e67e65647a65.png', NULL, NULL, NULL, NULL, NULL, NULL, '100-499人', '广告/传媒/文化/体育', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, NULL, 'http://192.168.1.10:8000/static/authLetter/3bdc9339-34ab-4a95-b488-a00fb22f7e82.png', '1534766306928394242', '13812345678', NULL, 1, '2022-07-20', '2022-06-20 23:46:51', '2022-06-27 13:46:48');
INSERT INTO `company` VALUES ('1538912084034887682', 'rerwe', 'rew', 'http://192.168.1.10:8000/static/logo/64ad33cf-e96b-450d-94b8-305d369b430e.png', 'http://192.168.1.10:8000/static/bizLicense/b17592da-6122-4370-abbb-173927c4b0f4.png', NULL, NULL, NULL, NULL, NULL, NULL, '100-499人', '广告/传媒/文化/体育', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, 0, NULL, '2022-06-20 23:50:07', '2022-06-20 23:50:07');
INSERT INTO `company` VALUES ('1538915076037451777', '444trt', 'rfw', 'http://192.168.1.10:8000/static/logo/6f104cc1-7dde-41c9-9da0-14734ae6d757.png', 'http://192.168.1.10:8000/static/bizLicense/e8a7d417-c1c1-4ea1-bb2c-c91a0c9e825e.gif', NULL, NULL, NULL, NULL, NULL, NULL, '100-499人', '广告/传媒/文化/体育', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 3, NULL, 'http://192.168.1.10:8000/static/authLetter/32d4f75f-ea89-4911-a19e-570659d8cc4e.png', '1534766306928394242', '13812345678', NULL, 0, NULL, '2022-06-21 00:02:00', '2022-06-21 00:02:00');
INSERT INTO `company` VALUES ('1538917367352172546', 'fe444', 'r234', 'http://192.168.1.10:8000/static/logo/c4096d2f-e571-4d83-912c-68b6b675054d.png', 'http://192.168.1.10:8000/static/bizLicense/d7291f5d-503a-4960-afca-df6b37bdadb4.png', NULL, NULL, NULL, NULL, NULL, NULL, '100-499人', '广告/传媒/文化/体育', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, 0, NULL, '2022-06-21 00:11:07', '2022-06-21 00:11:07');
INSERT INTO `company` VALUES ('1538917594586980353', 'wdadwadwa', '111', 'http://192.168.1.10:8000/static/logo/01c80c0a-6e57-483f-ae4d-60277cfc6543.png', 'http://192.168.1.10:8000/static/bizLicense/f24daccc-39fb-4f18-8644-18ecd225a20e.png', NULL, NULL, NULL, NULL, NULL, NULL, '100-499人', '广告/传媒/文化/体育', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 3, NULL, 'http://192.168.1.10:8000/static/authLetter/d29bfd8a-be48-4889-9c6c-b4f27b52cada.png', '1534766306928394242', '13812345678', NULL, 0, NULL, '2022-06-21 00:12:01', '2022-06-21 00:18:58');
INSERT INTO `company` VALUES ('1538919451191451649', 'aaa1', '111', 'http://192.168.1.10:8000/static/logo/37a248dd-70f1-4209-92a6-cf2726cc8470.png', 'http://192.168.1.10:8000/static/bizLicense/f93b2454-385e-4fb5-8ad1-da2b703c7965.png', NULL, NULL, NULL, NULL, NULL, NULL, '100-499人', '广告/传媒/文化/体育', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 3, NULL, 'http://192.168.1.10:8000/static/authLetter/b8cf50f4-8714-4bac-93a8-3b8d142f776d.png', '1534766306928394242', '13812345678', NULL, 0, NULL, '2022-06-21 00:19:24', '2022-06-21 00:19:33');
INSERT INTO `company` VALUES ('1538922979372867585', '很高效公司', '好笑', 'http://192.168.1.10:8000/static/logo/e6cfa3f4-6284-45c7-938d-cd1cc2d33e36.png', 'http://192.168.1.10:8000/static/bizLicense/0a745869-df8d-4039-9150-e42345808738.png', NULL, NULL, NULL, NULL, NULL, NULL, '100-499人', '广告/传媒/文化/体育', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, 'http://192.168.1.10:8000/static/authLetter/d1e4016b-997c-4c99-8023-4a7a501db42a.png', '1534766306928394242', '13812345678', NULL, 0, NULL, '2022-06-21 00:33:25', '2022-06-21 01:00:55');
INSERT INTO `company` VALUES ('1538929868865396738', 'dwqdqw', '以', 'http://192.168.1.10:8000/static/logo/872a05ad-3b76-4d18-b16c-1d0fd1d114da.png', 'http://192.168.1.10:8000/static/bizLicense/8d1ccb54-1342-4c9a-98c1-605c8e51ffc9.png', NULL, NULL, NULL, NULL, NULL, NULL, '100-499人', '广告/传媒/文化/体育', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, 0, NULL, '2022-06-21 01:00:47', '2022-06-21 01:00:47');
INSERT INTO `company` VALUES ('1539074019103604738', '东侧的', '单位去多无群', 'http://192.168.1.4:8000/static/logo/ec095ddf-3d02-47ad-a6f2-5f46b520375d.png', 'http://192.168.1.5:8000/static/bizLicense/85dc3d08-fc28-40fb-9937-8345c145661b.gif', NULL, NULL, NULL, NULL, NULL, NULL, '500-999人', '互联网/IT/电子/通信', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, '企业名称不对', 'http://192.168.1.5:8000/static/authLetter/ab6f205b-0c41-4f9f-9efd-fe84aca268fd.png', '1534766306928394242', '13112345678', NULL, 0, NULL, '2022-06-21 10:33:35', '2022-06-27 12:12:40');
INSERT INTO `company` VALUES ('1539077905927372802', '哈哈哈科技', '哈哈科技', 'http://192.168.1.4:8000/static/logo/8986ff7c-052c-4f1e-a9be-5b2ebdfd9ed4.jpg', 'http://192.168.1.5:8000/static/bizLicense/4b95700b-1272-47f6-a73b-bd3eee760811.jpg', NULL, NULL, NULL, NULL, NULL, NULL, '1-49人', '教育培训', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, '什么玩意', 'http://192.168.1.5:8000/static/authLetter/37b3a162-a087-432b-b620-922e4ae746d4.PNG', '1539076736920449026', '13812345633', '2022-06-01', 0, NULL, '2022-06-21 10:49:02', '2022-06-27 12:53:49');
INSERT INTO `company` VALUES ('1541300495639175169', '超级厉害公司', '慕课网', 'http://192.168.1.10:8000/static/logo/1a600b48-c2c8-4da2-8dc2-a0b9732aca9b.png', 'http://192.168.1.10:8000/static/bizLicense/3ef3dba6-f47b-4289-8cb7-b2b9f0eaaa14.jpg', NULL, NULL, NULL, NULL, '惹人分为', '私营·民营企业', '500-990人', '网络设备', 'C轮', '8:30-17:00 大小周 偶尔加班', 'sadfa', ',Advantage_PositionUp,', ',Benefit_Physical,Benefit_Cake,Benefit_Doctor,', ',Salary_Money,Salary_Stock,', ',Subsidy_Phone,Subsidy_Launch,Subsidy_Allowance,', '1999-01-02', 'rewr', 'r43r4', '2211', 1, '企业名称不对', 'http://192.168.1.10:8000/static/authLetter/e158f394-b916-4e05-9f53-937895b3a796.jpg', '1541299724478681090', '13812345678', '2022-07-03', 1, '2022-12-06', '2022-06-27 14:00:49', '2022-08-10 09:26:58');
INSERT INTO `company` VALUES ('1543470160318599169', '哈哈都比', '哈都', 'http://192.168.1.10:8000/static/logo/7f1018e1-f0e8-4b83-af3c-b507fe2ae941.jpg', 'http://192.168.1.10:8000/static/bizLicense/7a0bae4a-3209-49b3-be27-3fe905cc89aa.jpg', NULL, NULL, NULL, NULL, NULL, NULL, '5000-10000人', '拍卖', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, NULL, 'http://192.168.1.10:8000/static/authLetter/bf0f05fa-419a-4317-9e30-dc5051aaed31.jpg', '1543468858024927233', '13812345608', '2022-07-03', 0, NULL, '2022-07-03 13:42:17', '2022-07-03 13:43:43');
INSERT INTO `company` VALUES ('1560274281974820865', '风间影月和他的小伙伴们网络科技有限公司', '风间影月', 'http://hire.t.mukewang.com/static/logo/f3d78e2f-94a3-4f2f-ac5c-31fadd6dc40e.PNG', 'http://hire.t.mukewang.com/static/bizLicense/1c1e6a03-c536-4c24-a101-e944161f1310.jpg', NULL, NULL, NULL, NULL, '江苏某科技产业园区天鹅座', '国内上市公司', '50-99人', '电子商务', '天使轮', '8:30-16:00 周末双休 不加班', '我们拥有非常牛的技术团队', ',Advantage_PositionUp,', ',Benefit_Briefcase,', ',Salary_Bonus,', ',Subsidy_House,', '2020-01-01', '100万', '江苏南京', '风间影月', 1, '审核通过', 'http://hire.t.mukewang.com/static/authLetter/257f7a89-7503-4373-9893-7d93eed02fe1.jpg', '1553737574100766721', '13912345678', '2022-08-18', 1, '2022-09-18', '2022-08-18 22:35:52', '2022-08-19 11:24:36');
COMMIT;

-- ----------------------------
-- Table structure for company_photo
-- ----------------------------
DROP TABLE IF EXISTS `company_photo`;
CREATE TABLE `company_photo` (
  `company_id` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '企业id',
  `photos` varchar(2048) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`company_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='企业相册表，本表只存企业上传的图片';

-- ----------------------------
-- Records of company_photo
-- ----------------------------
BEGIN;
INSERT INTO `company_photo` VALUES ('1543470160318599169', 'http://192.168.1.10:8000/static/photo/1541300495639175169/0b031d8e-8a4c-45ff-bc7b-c132c2afd758.png,http://192.168.1.10:8000/static/photo/1541300495639175169/f3d79ad6-7f33-4fc7-93b5-1696e72088bb.png,http://192.168.1.10:8000/static/photo/1541300495639175169/062af03e-18d2-4c5c-929b-24679a2a8ca6.jpeg');
INSERT INTO `company_photo` VALUES ('1560274281974820865', 'http://hire.t.mukewang.com/static/photo/1560274281974820865/a28683d8-65fa-4fed-a2cc-fcc51b8cfed3.jpg,http://hire.t.mukewang.com/static/photo/1560274281974820865/aa1a8ba7-6802-4c37-8939-a50cec5911e6.jpg');
COMMIT;

-- ----------------------------
-- Table structure for data_dictionary
-- ----------------------------
DROP TABLE IF EXISTS `data_dictionary`;
CREATE TABLE `data_dictionary` (
  `id` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `type_code` varchar(24) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '数据字典的类别代码code，根据本code可以找到对应的所有下属的value列表，例如：benefits（同一类型item所对应的code都是一致的）',
  `type_name` varchar(24) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '数据字典的类别名称，例如：福利待遇（同一类型item所对应的name都是一致的）',
  `item_key` varchar(24) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '字典项，数据字典类别下的所有key，每个key对应一个value，可以根据类型key和字典key同时找到具体某一项字典value，例如：travel-旅游',
  `item_value` varchar(24) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '每个单个的数据字典的值，唯一key所对应的值value，例如：旅游',
  `sort` int DEFAULT NULL COMMENT '排序',
  `icon` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '对应的字体图标，可以为空',
  `enable` tinyint(1) NOT NULL COMMENT '是否开启，1：启用，0：停用',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE KEY `item_value` (`item_value`,`item_key`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='数据字典表';

-- ----------------------------
-- Records of data_dictionary
-- ----------------------------
BEGIN;
INSERT INTO `data_dictionary` VALUES ('1540214720453451777', 'StaffCounts', '人员规模', 'Counts1_49', '1-49人', 1, '', 1);
INSERT INTO `data_dictionary` VALUES ('1540214922325303298', 'StaffCounts', '人员规模', 'Counts50_99', '50-99人', 2, '', 1);
INSERT INTO `data_dictionary` VALUES ('1540215315239313410', 'StaffCounts', '人员规模', 'Counts100_499', '100-499人', 3, '', 1);
INSERT INTO `data_dictionary` VALUES ('1540215540980948994', 'StaffCounts', '人员规模', 'Counts500_999', '500-999人', 4, '', 1);
INSERT INTO `data_dictionary` VALUES ('1540215688716918785', 'StaffCounts', '人员规模', 'Counts1000_2000', '1000-2000人', 5, '', 1);
INSERT INTO `data_dictionary` VALUES ('1540215938424807425', 'StaffCounts', '人员规模', 'Counts2000_5000', '2000-5000人', 6, '', 1);
INSERT INTO `data_dictionary` VALUES ('1540216169879085057', 'StaffCounts', '人员规模', 'Counts5000_10000', '5000-10000人', 7, '', 1);
INSERT INTO `data_dictionary` VALUES ('1540216388368769026', 'StaffCounts', '人员规模', 'CountsAbove10000', '10000人以上', 8, '', 1);
INSERT INTO `data_dictionary` VALUES ('1541800701975691266', 'CompanyNature', '企业性质', 'Nature_Foreign', '外商独资·外企办事处', 1, '', 1);
INSERT INTO `data_dictionary` VALUES ('1541801166390001666', 'CompanyNature', '企业性质', 'Nature_ChinaAndForeign', '中外合资', 2, '', 1);
INSERT INTO `data_dictionary` VALUES ('1541801372183527426', 'CompanyNature', '企业性质', 'Nature_Self', '私营·民营企业', 3, '', 1);
INSERT INTO `data_dictionary` VALUES ('1541801525300789249', 'CompanyNature', '企业性质', 'Nature_Country', '国有企业', 4, '', 1);
INSERT INTO `data_dictionary` VALUES ('1541801795745316866', 'CompanyNature', '企业性质', 'Nature_Inner', '国内上市公司', 5, '', 1);
INSERT INTO `data_dictionary` VALUES ('1541801885461479425', 'CompanyNature', '企业性质', 'Nature_Gov', '政府机关/非盈利机构', 6, '', 1);
INSERT INTO `data_dictionary` VALUES ('1541802118333431809', 'CompanyNature', '企业性质', 'Nature_Institutions', '事业单位', 7, '', 1);
INSERT INTO `data_dictionary` VALUES ('1541802213367971842', 'CompanyNature', '企业性质', 'Nature_Other', '其他', 8, '', 1);
INSERT INTO `data_dictionary` VALUES ('1541968530507071489', 'FinanceStage', '融资阶段', 'Finance_None', '未融资', 1, '', 1);
INSERT INTO `data_dictionary` VALUES ('1541969042916802562', 'FinanceStage', '融资阶段', 'Finance_Angel', '天使轮', 2, '', 1);
INSERT INTO `data_dictionary` VALUES ('1541969181702127618', 'FinanceStage', '融资阶段', 'Finance_A', 'A轮', 3, '', 1);
INSERT INTO `data_dictionary` VALUES ('1541969285586649089', 'FinanceStage', '融资阶段', 'Finance_B', 'B轮', 4, '', 1);
INSERT INTO `data_dictionary` VALUES ('1541969427597393922', 'FinanceStage', '融资阶段', 'Finance_C', 'C轮', 5, '', 1);
INSERT INTO `data_dictionary` VALUES ('1541969546149396482', 'FinanceStage', '融资阶段', 'Finance_Dplus', 'D轮及以上', 6, '', 1);
INSERT INTO `data_dictionary` VALUES ('1541969837703856130', 'FinanceStage', '融资阶段', 'Finance_Listed', '已上市', 7, '', 1);
INSERT INTO `data_dictionary` VALUES ('1541969957598035969', 'FinanceStage', '融资阶段', 'Finance_Strategic', '战略融资', 8, '', 1);
INSERT INTO `data_dictionary` VALUES ('1541970074182909953', 'FinanceStage', '融资阶段', 'Finance_NoNeed', '不需要融资', 9, '', 1);
INSERT INTO `data_dictionary` VALUES ('1541970782684725249', 'FinanceStage', '融资阶段', 'Finance_Other', '其他', 10, '', 1);
INSERT INTO `data_dictionary` VALUES ('1541996080281174018', 'CompanyAdvantage', '公司优势', 'Advantage_BossGood', '领导好', 1, 'icon-boss-good', 1);
INSERT INTO `data_dictionary` VALUES ('1541997058376089601', 'CompanyAdvantage', '公司优势', 'Advantage_PositionUp', '岗位晋升', 2, 'icon-position-up', 1);
INSERT INTO `data_dictionary` VALUES ('1541999479382884354', 'CompanyAdvantage', '公司优势', 'Advantage_Management', '扁平化管理', 3, 'icon-management', 1);
INSERT INTO `data_dictionary` VALUES ('1541999648623050754', 'CompanyAdvantage', '公司优势', 'Advantage_Standard', '管理规范', 4, 'icon-standard', 1);
INSERT INTO `data_dictionary` VALUES ('1541999785369944066', 'CompanyAdvantage', '公司优势', 'Advantage_Training', '技能培训', 5, 'icon-training', 1);
INSERT INTO `data_dictionary` VALUES ('1542000620887883777', 'CompanyBenefit', '公司福利', 'Benefit_Umbrella', '五险一金', 1, 'icon-umbrella', 1);
INSERT INTO `data_dictionary` VALUES ('1542000879718383618', 'CompanyBenefit', '公司福利', 'Benefit_Physical', '定期体检', 2, 'icon-physical-examination', 1);
INSERT INTO `data_dictionary` VALUES ('1542001001458057217', 'CompanyBenefit', '公司福利', 'Benefit_Briefcase', '弹性工作', 3, 'icon-briefcase', 1);
INSERT INTO `data_dictionary` VALUES ('1542001093476892674', 'CompanyBenefit', '公司福利', 'Benefit_Cake', '节日礼物', 4, 'icon-cake', 1);
INSERT INTO `data_dictionary` VALUES ('1542001206848929794', 'CompanyBenefit', '公司福利', 'Benefit_Daba', '免费班车', 5, 'icon-daba', 1);
INSERT INTO `data_dictionary` VALUES ('1542001311425511425', 'CompanyBenefit', '公司福利', 'Benefit_Trip', '年度旅游', 6, 'icon-trip', 1);
INSERT INTO `data_dictionary` VALUES ('1542001415037403138', 'CompanyBenefit', '公司福利', 'Benefit_Team', '团队聚餐', 7, 'icon-team-building', 1);
INSERT INTO `data_dictionary` VALUES ('1542001525808971778', 'CompanyBenefit', '公司福利', 'Benefit_Doctor', '子女福利', 8, 'icon-doctor', 1);
INSERT INTO `data_dictionary` VALUES ('1542001638627360770', 'CompanyBenefit', '公司福利', 'Benefit_Car', '公司提供专车', 9, 'icon-car', 1);
INSERT INTO `data_dictionary` VALUES ('1542001847424008193', 'CompanySalary', '薪资福利', 'Salary_Money', '年底双薪', 1, 'icon-money', 1);
INSERT INTO `data_dictionary` VALUES ('1542001991930363906', 'CompanySalary', '薪资福利', 'Salary_Bonus', '绩效奖金', 2, 'icon-bonus', 1);
INSERT INTO `data_dictionary` VALUES ('1542002089380823041', 'CompanySalary', '薪资福利', 'Salary_Stock', '股票期权', 3, 'icon-stock', 1);
INSERT INTO `data_dictionary` VALUES ('1542002198290120705', 'CompanySalary', '薪资福利', 'Salary_Vacation', '带薪年假', 4, 'icon-vacation', 1);
INSERT INTO `data_dictionary` VALUES ('1542002402359787522', 'CompanySubsidy', '补助津贴', 'Subsidy_Car2', '交通补助', 1, 'icon-car2', 1);
INSERT INTO `data_dictionary` VALUES ('1542003377199923202', 'CompanySubsidy', '补助津贴', 'Subsidy_Phone', '通讯津贴', 2, 'icon-phone', 1);
INSERT INTO `data_dictionary` VALUES ('1542003516392095745', 'CompanySubsidy', '补助津贴', 'Subsidy_Launch', '午餐补助', 3, 'icon-launch', 1);
INSERT INTO `data_dictionary` VALUES ('1542003656402157569', 'CompanySubsidy', '补助津贴', 'Subsidy_House', '购房津贴', 4, 'icon-house', 1);
INSERT INTO `data_dictionary` VALUES ('1542003868310978561', 'CompanySubsidy', '补助津贴', 'Subsidy_Car2', '车辆津贴', 5, 'icon-car2', 1);
INSERT INTO `data_dictionary` VALUES ('1542004273082286081', 'CompanySubsidy', '补助津贴', 'Subsidy_Allowance', '外派津贴', 6, 'icon-allowance', 1);
INSERT INTO `data_dictionary` VALUES ('1542004430788116481', 'CompanySubsidy', '补助津贴', 'Subsidy_Feeding', '生育津贴', 7, 'icon-feeding-bottle', 1);
INSERT INTO `data_dictionary` VALUES ('1547193893000605698', 'ResumeOpenStatus', '简历求职(开放)状态', 'off_job_looking', '离职，正在找工作', 1, '', 1);
INSERT INTO `data_dictionary` VALUES ('1547194253840773122', 'ResumeOpenStatus', '简历求职(开放)状态', 'on_job_looking', '在职，急寻新工作', 2, '', 1);
INSERT INTO `data_dictionary` VALUES ('1547194368714371073', 'ResumeOpenStatus', '简历求职(开放)状态', 'on_job_new_chance', '在职，看看新机会', 3, '', 1);
INSERT INTO `data_dictionary` VALUES ('1547194471776808962', 'ResumeOpenStatus', '简历求职(开放)状态', 'on_job_no_change', '在职，暂无跳槽打算', 4, '', 1);
INSERT INTO `data_dictionary` VALUES ('1547457852064694274', 'JobExperienceNeed', '招聘工作经验要求', 'exp_no', '不限', 1, '', 1);
INSERT INTO `data_dictionary` VALUES ('1547458110672896002', 'JobExperienceNeed', '招聘工作经验要求', 'exp_below_1year', '1年以下', 2, '', 1);
INSERT INTO `data_dictionary` VALUES ('1547458947654647809', 'JobExperienceNeed', '招聘工作经验要求', 'exp_between_1and3year', '1-3年', 3, '', 1);
INSERT INTO `data_dictionary` VALUES ('1547459038041899010', 'JobExperienceNeed', '招聘工作经验要求', 'exp_between_3and5year', '3-5年', 4, '', 1);
INSERT INTO `data_dictionary` VALUES ('1547459133122576386', 'JobExperienceNeed', '招聘工作经验要求', 'exp_between_5and10year', '5-10年', 5, '', 1);
INSERT INTO `data_dictionary` VALUES ('1547459234251440129', 'JobExperienceNeed', '招聘工作经验要求', 'exp_up_10year', '10年以上', 6, '', 1);
INSERT INTO `data_dictionary` VALUES ('1547459498970742786', 'JobEducationNeed', '招聘学历要求', 'edu_no', '不限', 1, '', 1);
INSERT INTO `data_dictionary` VALUES ('1547459930145193986', 'JobEducationNeed', '招聘学历要求', 'edu_tech_school ', '中专/技校', 2, '', 1);
INSERT INTO `data_dictionary` VALUES ('1547460084243922945', 'JobEducationNeed', '招聘学历要求', 'edu_junior_college', '大专', 3, '', 1);
INSERT INTO `data_dictionary` VALUES ('1547460192188530689', 'JobEducationNeed', '招聘学历要求', 'edi_undergraduate', '本科', 4, '', 1);
INSERT INTO `data_dictionary` VALUES ('1547460338720735233', 'JobEducationNeed', '招聘学历要求', 'edu_master', '硕士', 5, '', 1);
INSERT INTO `data_dictionary` VALUES ('1547460437706309634', 'JobEducationNeed', '招聘学历要求', 'edu_mba', 'MBA/EMBA', 6, '', 1);
INSERT INTO `data_dictionary` VALUES ('1547460553712369666', 'JobEducationNeed', '招聘学历要求', 'edu_doctor', '博士', 7, '', 1);
INSERT INTO `data_dictionary` VALUES ('1548272415165247490', 'CollegeType', '院校类型', 'college_type_1', '985', 1, '', 1);
INSERT INTO `data_dictionary` VALUES ('1548272603401416705', 'CollegeType', '院校类型', 'college_type_2', '211', 2, '', 1);
INSERT INTO `data_dictionary` VALUES ('1548272785367101442', 'CollegeType', '院校类型', 'college_type_3', '双一流院校', 3, '', 1);
INSERT INTO `data_dictionary` VALUES ('1548273190968881154', 'CollegeType', '院校类型', 'college_type_4', '留学', 4, '', 1);
INSERT INTO `data_dictionary` VALUES ('1548273289300144130', 'CollegeType', '院校类型', 'college_type_', '国内外名校', 5, '', 1);
COMMIT;

-- ----------------------------
-- Table structure for industry
-- ----------------------------
DROP TABLE IF EXISTS `industry`;
CREATE TABLE `industry` (
  `id` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `name` varchar(24) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '行业名称',
  `sort` int NOT NULL COMMENT '排序',
  `father_id` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '为0则当前为第一级分类，否则当前为fatherId所对应行业的子分类',
  `is_leaf` tinyint(1) NOT NULL COMMENT '用于提供给前端tree显示标记是否展示下拉箭头，一级分类与二级分类为true，三级分类也就是最后一级分类是false',
  `level` int NOT NULL COMMENT '分类层级，用于标记',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='行业表';

-- ----------------------------
-- Records of industry
-- ----------------------------
BEGIN;
INSERT INTO `industry` VALUES ('1539849439025561601', '互联网·游戏·软件', 1, '0', 0, 1);
INSERT INTO `industry` VALUES ('1539849504666419201', '互联网/电商', 1, '1539849439025561601', 0, 2);
INSERT INTO `industry` VALUES ('1539849555862093826', '电子商务', 1, '1539849504666419201', 1, 3);
INSERT INTO `industry` VALUES ('1539849596215492610', '人工智能', 2, '1539849504666419201', 1, 3);
INSERT INTO `industry` VALUES ('1539850057848979457', '文娱/内容平台', 3, '1539849504666419201', 1, 3);
INSERT INTO `industry` VALUES ('1539850087561428994', '社交网络', 4, '1539849504666419201', 1, 3);
INSERT INTO `industry` VALUES ('1539850138098597889', '互联网金融', 5, '1539849504666419201', 1, 3);
INSERT INTO `industry` VALUES ('1539850167349673986', '大数据', 6, '1539849504666419201', 1, 3);
INSERT INTO `industry` VALUES ('1539850203882061825', '区块链', 7, '1539849504666419201', 1, 3);
INSERT INTO `industry` VALUES ('1539850246206783489', '智能硬件', 8, '1539849504666419201', 1, 3);
INSERT INTO `industry` VALUES ('1539850274983903234', '互联网+', 9, '1539849504666419201', 1, 3);
INSERT INTO `industry` VALUES ('1539850309247172609', 'O2O服务', 10, '1539849504666419201', 1, 3);
INSERT INTO `industry` VALUES ('1539850467380822018', '游戏产业', 2, '1539849439025561601', 0, 2);
INSERT INTO `industry` VALUES ('1539850527661359105', '游戏衍生品', 1, '1539850467380822018', 1, 3);
INSERT INTO `industry` VALUES ('1539850558099423234', '游戏媒体社区', 2, '1539850467380822018', 1, 3);
INSERT INTO `industry` VALUES ('1539850633936633858', '游戏平台', 3, '1539850467380822018', 1, 3);
INSERT INTO `industry` VALUES ('1539850663653277697', '游戏发行', 4, '1539850467380822018', 1, 3);
INSERT INTO `industry` VALUES ('1539850686021500929', '游戏开发', 5, '1539850467380822018', 1, 3);
INSERT INTO `industry` VALUES ('1539850708159037441', '游戏硬件', 6, '1539850467380822018', 1, 3);
INSERT INTO `industry` VALUES ('1539850734717370370', '电子竞技', 7, '1539850467380822018', 1, 3);
INSERT INTO `industry` VALUES ('1539850801205477377', '计算机软件', 3, '1539849439025561601', 0, 2);
INSERT INTO `industry` VALUES ('1539850838580920322', '个人工具软件', 1, '1539850801205477377', 1, 3);
INSERT INTO `industry` VALUES ('1539850911582781442', '企业服务软件', 2, '1539850801205477377', 1, 3);
INSERT INTO `industry` VALUES ('1539850939130970114', 'IT服务', 4, '1539849439025561601', 0, 2);
INSERT INTO `industry` VALUES ('1539850996399996929', '开发者服务', 1, '1539850939130970114', 1, 3);
INSERT INTO `industry` VALUES ('1539851018445258753', '企业安全', 2, '1539850939130970114', 1, 3);
INSERT INTO `industry` VALUES ('1539851037424484353', '云服务', 3, '1539850939130970114', 1, 3);
INSERT INTO `industry` VALUES ('1539851901597908994', '电子·通信·硬件', 2, '0', 0, 1);
INSERT INTO `industry` VALUES ('1539854303105384449', '电子/芯片/半导体', 1, '1539851901597908994', 0, 2);
INSERT INTO `industry` VALUES ('1539854336081002497', '通信业', 2, '1539851901597908994', 0, 2);
INSERT INTO `industry` VALUES ('1539854373871681537', '计算机/网络设备', 3, '1539851901597908994', 0, 2);
INSERT INTO `industry` VALUES ('1539854752717996034', '计算机设备', 1, '1539854373871681537', 1, 3);
INSERT INTO `industry` VALUES ('1539854825392701441', '通信基础设施', 1, '1539854336081002497', 1, 3);
INSERT INTO `industry` VALUES ('1539854863758000130', '通信技术提供商', 2, '1539854336081002497', 1, 3);
INSERT INTO `industry` VALUES ('1539854906179190786', '电信运营商', 3, '1539854336081002497', 1, 3);
INSERT INTO `industry` VALUES ('1539854964836532226', '通信设备', 4, '1539854336081002497', 1, 3);
INSERT INTO `industry` VALUES ('1539855023862972418', '电子设备', 1, '1539854303105384449', 1, 3);
INSERT INTO `industry` VALUES ('1539855072135217153', '芯片/集成电路', 2, '1539854303105384449', 1, 3);
INSERT INTO `industry` VALUES ('1539855296505315329', '半导体', 3, '1539854303105384449', 1, 3);
INSERT INTO `industry` VALUES ('1539855413908078594', '网络设备', 2, '1539854373871681537', 1, 3);
INSERT INTO `industry` VALUES ('1539855636587872258', '房地产·建筑·物业', 3, '0', 0, 1);
INSERT INTO `industry` VALUES ('1539855678476386306', '房地产/建筑', 1, '1539855636587872258', 0, 2);
INSERT INTO `industry` VALUES ('1539856132841144321', '房地产服务', 2, '1539855636587872258', 0, 2);
INSERT INTO `industry` VALUES ('1539856191959859201', '规划/设计/装潢', 3, '1539855636587872258', 0, 2);
INSERT INTO `industry` VALUES ('1539856275153879042', '房产开发', 1, '1539855678476386306', 1, 3);
INSERT INTO `industry` VALUES ('1539856312999084034', '工程服务', 2, '1539855678476386306', 1, 3);
INSERT INTO `industry` VALUES ('1539856336344580097', '建材', 3, '1539855678476386306', 1, 3);
INSERT INTO `industry` VALUES ('1539856352387792898', '建筑', 4, '1539855678476386306', 1, 3);
INSERT INTO `industry` VALUES ('1539856467747930113', '房产交易', 1, '1539856132841144321', 1, 3);
INSERT INTO `industry` VALUES ('1539856489654779906', '房产服务', 2, '1539856132841144321', 1, 3);
INSERT INTO `industry` VALUES ('1539856528498229249', '室内设计', 1, '1539856191959859201', 1, 3);
INSERT INTO `industry` VALUES ('1539856577517060098', '家居家纺', 2, '1539856191959859201', 1, 3);
INSERT INTO `industry` VALUES ('1539856608705904641', '装修装潢', 3, '1539856191959859201', 1, 3);
INSERT INTO `industry` VALUES ('1539865611443896322', '金融', 4, '0', 0, 1);
INSERT INTO `industry` VALUES ('1539865653462433794', '银行', 1, '1539865611443896322', 0, 2);
INSERT INTO `industry` VALUES ('1539865676166201345', '保险', 2, '1539865611443896322', 0, 2);
INSERT INTO `industry` VALUES ('1539865720038621186', '基金/证券/投资', 3, '1539865611443896322', 0, 2);
INSERT INTO `industry` VALUES ('1539865799273218049', '会计/审计', 4, '1539865611443896322', 0, 2);
INSERT INTO `industry` VALUES ('1539865862082920450', '信托/担保/拍卖', 5, '1539865611443896322', 0, 2);
INSERT INTO `industry` VALUES ('1539865973009678338', '信托', 1, '1539865862082920450', 1, 3);
INSERT INTO `industry` VALUES ('1539866007222616065', '消费金融', 2, '1539865862082920450', 1, 3);
INSERT INTO `industry` VALUES ('1539866060498665473', '拍卖', 3, '1539865862082920450', 1, 3);
INSERT INTO `industry` VALUES ('1539866119906787329', '借贷', 4, '1539865862082920450', 1, 3);
INSERT INTO `industry` VALUES ('1539866149912838146', '融资', 5, '1539865862082920450', 1, 3);
INSERT INTO `industry` VALUES ('1539866186717855745', '融资租赁', 6, '1539865862082920450', 1, 3);
INSERT INTO `industry` VALUES ('1539866361876185089', '会计与审计', 1, '1539865799273218049', 1, 3);
INSERT INTO `industry` VALUES ('1539866392217780225', '基金', 1, '1539865720038621186', 1, 3);
INSERT INTO `industry` VALUES ('1539866411226365953', '投资理财', 2, '1539865720038621186', 1, 3);
INSERT INTO `industry` VALUES ('1539866431145115649', '证券', 3, '1539865720038621186', 1, 3);
INSERT INTO `industry` VALUES ('1539866451906920450', '股票', 4, '1539865720038621186', 1, 3);
INSERT INTO `industry` VALUES ('1539866474182868993', '期货', 5, '1539865720038621186', 1, 3);
INSERT INTO `industry` VALUES ('1539866491262074881', '外汇', 6, '1539865720038621186', 1, 3);
INSERT INTO `industry` VALUES ('1539866547973259266', '保险业务', 1, '1539865676166201345', 1, 3);
INSERT INTO `industry` VALUES ('1539866590914543618', '银行业务', 1, '1539865653462433794', 1, 3);
INSERT INTO `industry` VALUES ('1539867132252389378', '消费品', 5, '0', 0, 1);
INSERT INTO `industry` VALUES ('1539867193396953090', '食品/饮料/日化', 1, '1539867132252389378', 0, 2);
INSERT INTO `industry` VALUES ('1539867256533811201', '批发零售', 2, '1539867132252389378', 0, 2);
INSERT INTO `industry` VALUES ('1539867309239435265', '服装纺织', 3, '1539867132252389378', 0, 2);
INSERT INTO `industry` VALUES ('1539867353405456385', '家具/家电', 4, '1539867132252389378', 0, 2);
INSERT INTO `industry` VALUES ('1539867380538408961', '办公设备', 5, '1539867132252389378', 0, 2);
INSERT INTO `industry` VALUES ('1539867420547874817', '奢侈品/收藏品', 6, '1539867132252389378', 0, 2);
INSERT INTO `industry` VALUES ('1539867504450732033', '珠宝/玩具/工艺品', 7, '1539867132252389378', 0, 2);
INSERT INTO `industry` VALUES ('1539867538000969729', '工艺品', 1, '1539867504450732033', 1, 3);
INSERT INTO `industry` VALUES ('1539867554128068609', '珠宝', 2, '1539867504450732033', 1, 3);
INSERT INTO `industry` VALUES ('1539867569709907970', '玩具', 3, '1539867504450732033', 1, 3);
INSERT INTO `industry` VALUES ('1539867590937280513', '奢侈品', 1, '1539867420547874817', 1, 3);
INSERT INTO `industry` VALUES ('1539867623170506754', '收藏品/古董', 2, '1539867420547874817', 1, 3);
INSERT INTO `industry` VALUES ('1539867726933393410', '办公设备用品', 1, '1539867380538408961', 1, 3);
INSERT INTO `industry` VALUES ('1539867774924619778', '消费电子', 1, '1539867353405456385', 1, 3);
INSERT INTO `industry` VALUES ('1539867875478863874', '家具制造', 2, '1539867353405456385', 1, 3);
INSERT INTO `industry` VALUES ('1539867905296171010', '家电制造', 3, '1539867353405456385', 1, 3);
INSERT INTO `industry` VALUES ('1539867932060024834', '服装纺织品', 1, '1539867309239435265', 1, 3);
INSERT INTO `industry` VALUES ('1539867969045397506', '批发零售用品', 1, '1539867256533811201', 1, 3);
INSERT INTO `industry` VALUES ('1539868017128898561', '个人护理品', 1, '1539867193396953090', 1, 3);
INSERT INTO `industry` VALUES ('1539868044404457474', '酒水', 2, '1539867193396953090', 1, 3);
INSERT INTO `industry` VALUES ('1539868076490883074', '食品饮料', 3, '1539867193396953090', 1, 3);
INSERT INTO `industry` VALUES ('1539868113719525378', '烟草', 4, '1539867193396953090', 1, 3);
INSERT INTO `industry` VALUES ('1539869456572088322', '汽车·机械·制造', 6, '0', 0, 1);
INSERT INTO `industry` VALUES ('1539869520874962945', '汽车/摩托车', 1, '1539869456572088322', 0, 2);
INSERT INTO `industry` VALUES ('1539869590995337217', '机械/机电/重工', 2, '1539869456572088322', 0, 2);
INSERT INTO `industry` VALUES ('1539869667809820673', '印刷/包装/造纸', 3, '1539869456572088322', 0, 2);
INSERT INTO `industry` VALUES ('1539869751427465217', '仪器/电气/自动化', 4, '1539869456572088322', 0, 2);
INSERT INTO `industry` VALUES ('1539869820557983745', '原材料加工', 5, '1539869456572088322', 0, 2);
INSERT INTO `industry` VALUES ('1539870014779424769', '非金属矿物物品', 1, '1539869820557983745', 1, 3);
INSERT INTO `industry` VALUES ('1539870077152919554', '木材加工和制造', 2, '1539869820557983745', 1, 3);
INSERT INTO `industry` VALUES ('1539870206119378946', '橡塑制品', 3, '1539869820557983745', 1, 3);
INSERT INTO `industry` VALUES ('1539870266701905921', '工业信息化', 1, '1539869751427465217', 1, 3);
INSERT INTO `industry` VALUES ('1539870292136165378', '工业自动化', 2, '1539869751427465217', 1, 3);
INSERT INTO `industry` VALUES ('1539870322523897857', '仪器仪表', 3, '1539869751427465217', 1, 3);
INSERT INTO `industry` VALUES ('1539870361602228225', '电气机械和器材', 4, '1539869751427465217', 1, 3);
INSERT INTO `industry` VALUES ('1539870417323556866', '印刷业', 1, '1539869667809820673', 1, 3);
INSERT INTO `industry` VALUES ('1539870459602141186', '造纸和纸制品', 2, '1539869667809820673', 1, 3);
INSERT INTO `industry` VALUES ('1539870507874385922', '高端制造', 1, '1539869590995337217', 1, 3);
INSERT INTO `industry` VALUES ('1539870531857416193', '机电设备', 2, '1539869590995337217', 1, 3);
INSERT INTO `industry` VALUES ('1539870568695988225', '机械设备制造', 3, '1539869590995337217', 1, 3);
INSERT INTO `industry` VALUES ('1539870601919070209', '军工产品', 4, '1539869590995337217', 1, 3);
INSERT INTO `industry` VALUES ('1539870633959358465', '特种设备', 5, '1539869590995337217', 1, 3);
INSERT INTO `industry` VALUES ('1539872436016906241', '汽车交易', 1, '1539869520874962945', 1, 3);
INSERT INTO `industry` VALUES ('1539872482447851521', '汽车研发', 2, '1539869520874962945', 1, 3);
INSERT INTO `industry` VALUES ('1539872533458976770', '汽车后市场', 3, '1539869520874962945', 1, 3);
INSERT INTO `industry` VALUES ('1539872588802818050', '车联网', 4, '1539869520874962945', 1, 3);
INSERT INTO `industry` VALUES ('1539872796332785665', '其他交通工具制造', 5, '1539869520874962945', 1, 3);
INSERT INTO `industry` VALUES ('1539873100885393410', '服务·外包·中介', 7, '0', 0, 1);
INSERT INTO `industry` VALUES ('1539873157877596162', '中介服务', 1, '1539873100885393410', 0, 2);
INSERT INTO `industry` VALUES ('1539873190333120514', '专业服务', 2, '1539873100885393410', 0, 2);
INSERT INTO `industry` VALUES ('1539873212084781057', '外包服务', 3, '1539873100885393410', 0, 2);
INSERT INTO `industry` VALUES ('1539873256779284482', '检测/认证', 4, '1539873100885393410', 0, 2);
INSERT INTO `industry` VALUES ('1539873380687413250', '餐饮/酒旅/服务', 5, '1539873100885393410', 0, 2);
INSERT INTO `industry` VALUES ('1539873417928638465', '租赁服务', 6, '1539873100885393410', 0, 2);
INSERT INTO `industry` VALUES ('1539873476799889410', '全部租赁服务', 1, '1539873417928638465', 1, 3);
INSERT INTO `industry` VALUES ('1539873525650948097', '旅游户外', 1, '1539873380687413250', 1, 3);
INSERT INTO `industry` VALUES ('1539873546400169986', '餐饮服务', 2, '1539873380687413250', 1, 3);
INSERT INTO `industry` VALUES ('1539873567837257730', '生活服务', 3, '1539873380687413250', 1, 3);
INSERT INTO `industry` VALUES ('1539873615220310017', '检测与认证', 1, '1539873256779284482', 1, 3);
INSERT INTO `industry` VALUES ('1539873648107847682', '全部外包服务', 1, '1539873212084781057', 1, 3);
INSERT INTO `industry` VALUES ('1539873702931595265', '全部中介服务', 1, '1539873157877596162', 1, 3);
INSERT INTO `industry` VALUES ('1539873742668431361', '行业解决方案', 1, '1539873190333120514', 1, 3);
INSERT INTO `industry` VALUES ('1539873771441356801', '财税服务', 2, '1539873190333120514', 1, 3);
INSERT INTO `industry` VALUES ('1539873859869868033', '创业服务', 3, '1539873190333120514', 1, 3);
INSERT INTO `industry` VALUES ('1539873887422251010', '法律服务', 4, '1539873190333120514', 1, 3);
INSERT INTO `industry` VALUES ('1539873992044969986', '工商服务', 5, '1539873190333120514', 1, 3);
INSERT INTO `industry` VALUES ('1539874046453481473', '供应链管理', 6, '1539873190333120514', 1, 3);
INSERT INTO `industry` VALUES ('1539874076874768385', '人力资源', 7, '1539873190333120514', 1, 3);
INSERT INTO `industry` VALUES ('1539874110009769986', '商业策划', 8, '1539873190333120514', 1, 3);
INSERT INTO `industry` VALUES ('1539874148303765506', '设计服务', 9, '1539873190333120514', 1, 3);
INSERT INTO `industry` VALUES ('1539874202259292162', '知识产权服务', 10, '1539873190333120514', 1, 3);
INSERT INTO `industry` VALUES ('1539874233267781634', '咨询服务', 11, '1539873190333120514', 1, 3);
INSERT INTO `industry` VALUES ('1539874255719890945', '企业培训', 12, '1539873190333120514', 1, 3);
INSERT INTO `industry` VALUES ('1539893326473625601', '广告·传媒·教育·文化', 8, '0', 0, 1);
INSERT INTO `industry` VALUES ('1539893436997730306', '文体娱乐', 1, '1539893326473625601', 0, 2);
INSERT INTO `industry` VALUES ('1539893510045728769', '广告/市场/会展', 2, '1539893326473625601', 0, 2);
INSERT INTO `industry` VALUES ('1539893543885373441', '影视文化', 3, '1539893326473625601', 0, 2);
INSERT INTO `industry` VALUES ('1539893565439901697', '教育培训', 4, '1539893326473625601', 0, 2);
INSERT INTO `industry` VALUES ('1539893637565153281', 'K12教育', 1, '1539893565439901697', 1, 3);
INSERT INTO `industry` VALUES ('1539893661720150017', '学前教育', 2, '1539893565439901697', 1, 3);
INSERT INTO `industry` VALUES ('1539893686806282241', '素质教育', 3, '1539893565439901697', 1, 3);
INSERT INTO `industry` VALUES ('1539893716237713409', '知识付费', 4, '1539893565439901697', 1, 3);
INSERT INTO `industry` VALUES ('1539893748856815618', '高等教育', 5, '1539893565439901697', 1, 3);
INSERT INTO `industry` VALUES ('1539893868956516353', '职业教育', 6, '1539893565439901697', 1, 3);
INSERT INTO `industry` VALUES ('1539893898085957633', '语言学习', 7, '1539893565439901697', 1, 3);
INSERT INTO `industry` VALUES ('1539893932663799810', '留学服务', 8, '1539893565439901697', 1, 3);
INSERT INTO `industry` VALUES ('1539893961818406914', '教育信息化', 9, '1539893565439901697', 1, 3);
INSERT INTO `industry` VALUES ('1539894012376547329', '科研及技术服务', 10, '1539893565439901697', 1, 3);
INSERT INTO `industry` VALUES ('1539894073105874945', '教辅资料及设备', 11, '1539893565439901697', 1, 3);
INSERT INTO `industry` VALUES ('1539894328039866369', '传媒', 1, '1539893543885373441', 1, 3);
INSERT INTO `industry` VALUES ('1539894354052939778', '影视文娱', 2, '1539893543885373441', 1, 3);
INSERT INTO `industry` VALUES ('1539894383815720962', '新闻和出版社', 3, '1539893543885373441', 1, 3);
INSERT INTO `industry` VALUES ('1539894440703066113', '体育', 1, '1539893436997730306', 1, 3);
INSERT INTO `industry` VALUES ('1539894458122010625', '娱乐', 2, '1539893436997730306', 1, 3);
INSERT INTO `industry` VALUES ('1539894498039201794', '会展服务', 1, '1539893510045728769', 1, 3);
INSERT INTO `industry` VALUES ('1539894522450051074', '广告营销', 2, '1539893510045728769', 1, 3);
INSERT INTO `industry` VALUES ('1539894541005651970', '公关服务', 3, '1539893510045728769', 1, 3);
INSERT INTO `industry` VALUES ('1539894997169766401', '交通·贸易·物流', 9, '0', 0, 1);
INSERT INTO `industry` VALUES ('1539895070800773121', '交通/物流/运输', 1, '1539894997169766401', 0, 2);
INSERT INTO `industry` VALUES ('1539895248035282946', '贸易/进出口', 2, '1539894997169766401', 0, 2);
INSERT INTO `industry` VALUES ('1539895286450913282', '航空/航天', 3, '1539894997169766401', 0, 2);
INSERT INTO `industry` VALUES ('1539895460304814081', '出行服务', 1, '1539895070800773121', 1, 3);
INSERT INTO `industry` VALUES ('1539895486833786882', '物流运输', 2, '1539895070800773121', 1, 3);
INSERT INTO `industry` VALUES ('1539895511525654529', '仓储服务', 3, '1539895070800773121', 1, 3);
INSERT INTO `industry` VALUES ('1539895537752637442', '物流信息化', 4, '1539895070800773121', 1, 3);
INSERT INTO `industry` VALUES ('1539895569746788354', '配送服务', 5, '1539895070800773121', 1, 3);
INSERT INTO `industry` VALUES ('1539895619579314178', '全部贸易/进出口', 1, '1539895248035282946', 1, 3);
INSERT INTO `industry` VALUES ('1539895645651107841', '全部航空/航天', 1, '1539895286450913282', 1, 3);
INSERT INTO `industry` VALUES ('1539895945740976129', '制药·医疗', 10, '0', 0, 1);
INSERT INTO `industry` VALUES ('1539896085662957569', '制药/生物工程', 1, '1539895945740976129', 0, 2);
INSERT INTO `industry` VALUES ('1539896133188616194', '医疗/保健/美容', 2, '1539895945740976129', 0, 2);
INSERT INTO `industry` VALUES ('1539896159063277569', '医疗器械', 3, '1539895945740976129', 0, 2);
INSERT INTO `industry` VALUES ('1539896190809964546', '全部医疗器械', 1, '1539896159063277569', 1, 3);
INSERT INTO `industry` VALUES ('1539896228944576514', '医疗服务', 1, '1539896133188616194', 1, 3);
INSERT INTO `industry` VALUES ('1539896266743644162', '心理健康', 2, '1539896133188616194', 1, 3);
INSERT INTO `industry` VALUES ('1539896295378157569', '医美整形', 3, '1539896133188616194', 1, 3);
INSERT INTO `industry` VALUES ('1539896331512086529', '医疗信息化', 4, '1539896133188616194', 1, 3);
INSERT INTO `industry` VALUES ('1539896354916302850', '医疗机构', 5, '1539896133188616194', 1, 3);
INSERT INTO `industry` VALUES ('1539896409618415618', '药物研发', 1, '1539896085662957569', 1, 3);
INSERT INTO `industry` VALUES ('1539896441897779201', '药品生产', 2, '1539896085662957569', 1, 3);
INSERT INTO `industry` VALUES ('1539896467822772226', '生物工程', 3, '1539896085662957569', 1, 3);
INSERT INTO `industry` VALUES ('1539896505139494913', '医药销售', 4, '1539896085662957569', 1, 3);
INSERT INTO `industry` VALUES ('1539896946543853569', '能源·化工·环保', 11, '0', 0, 1);
INSERT INTO `industry` VALUES ('1539897016500649985', '环保', 1, '1539896946543853569', 0, 2);
INSERT INTO `industry` VALUES ('1539897044422131714', '石油/化工', 2, '1539896946543853569', 0, 2);
INSERT INTO `industry` VALUES ('1539897523126435841', '采掘/冶炼/矿产', 3, '1539896946543853569', 0, 2);
INSERT INTO `industry` VALUES ('1539897567036604418', '能源/水利', 4, '1539896946543853569', 0, 2);
INSERT INTO `industry` VALUES ('1539897592969986049', '新能源', 5, '1539896946543853569', 0, 2);
INSERT INTO `industry` VALUES ('1539897721588318209', '环保业', 1, '1539897016500649985', 1, 3);
INSERT INTO `industry` VALUES ('1539897753200787457', '化学化工', 1, '1539897044422131714', 1, 3);
INSERT INTO `industry` VALUES ('1539897793969422337', '石油煤炭加工', 2, '1539897044422131714', 1, 3);
INSERT INTO `industry` VALUES ('1539897862516932609', '冶金工业', 1, '1539897523126435841', 1, 3);
INSERT INTO `industry` VALUES ('1539897904732602370', '开采装备', 2, '1539897523126435841', 1, 3);
INSERT INTO `industry` VALUES ('1539897937951490050', '矿产开采', 3, '1539897523126435841', 1, 3);
INSERT INTO `industry` VALUES ('1539897970637701121', '能源开采', 4, '1539897523126435841', 1, 3);
INSERT INTO `industry` VALUES ('1539898002115952641', '资源勘探', 5, '1539897523126435841', 1, 3);
INSERT INTO `industry` VALUES ('1539898061956087810', '电力', 1, '1539897567036604418', 1, 3);
INSERT INTO `industry` VALUES ('1539898167618994178', '煤炭能源', 2, '1539897567036604418', 1, 3);
INSERT INTO `industry` VALUES ('1539898210979708930', '能源技术', 3, '1539897567036604418', 1, 3);
INSERT INTO `industry` VALUES ('1539898235277312002', '燃气', 4, '1539897567036604418', 1, 3);
INSERT INTO `industry` VALUES ('1539898261458157569', '热力', 5, '1539897567036604418', 1, 3);
INSERT INTO `industry` VALUES ('1539898284514246657', '水利', 6, '1539897567036604418', 1, 3);
INSERT INTO `industry` VALUES ('1539898508624297986', '新能源行业', 1, '1539897592969986049', 1, 3);
INSERT INTO `industry` VALUES ('1539898956693405697', '政府·农林牧渔', 12, '0', 0, 1);
INSERT INTO `industry` VALUES ('1539899435741642754', '政务/公共服务', 1, '1539898956693405697', 0, 2);
INSERT INTO `industry` VALUES ('1539899945538322433', '农林牧渔', 2, '1539898956693405697', 0, 2);
INSERT INTO `industry` VALUES ('1539900009849585666', '其他行业', 3, '1539898956693405697', 0, 2);
INSERT INTO `industry` VALUES ('1539900046646214657', '全部其他行业', 1, '1539900009849585666', 1, 3);
INSERT INTO `industry` VALUES ('1539900150551707649', '畜牧业', 1, '1539899945538322433', 1, 3);
INSERT INTO `industry` VALUES ('1539900194411544577', '林业', 2, '1539899945538322433', 1, 3);
INSERT INTO `industry` VALUES ('1539900221703880705', '渔业', 3, '1539899945538322433', 1, 3);
INSERT INTO `industry` VALUES ('1539900265316253698', '农业', 4, '1539899945538322433', 1, 3);
INSERT INTO `industry` VALUES ('1539900401555636226', '公益组织', 2, '1539899435741642754', 1, 3);
INSERT INTO `industry` VALUES ('1539900505171722242', '政府机构', 1, '1539899435741642754', 1, 3);
INSERT INTO `industry` VALUES ('1539900537002295298', '社会工作', 3, '1539899435741642754', 1, 3);
COMMIT;

-- ----------------------------
-- Table structure for interview
-- ----------------------------
DROP TABLE IF EXISTS `interview`;
CREATE TABLE `interview` (
  `id` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `hr_user_id` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '本面试属于哪个hr的',
  `company_id` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '本面试属于哪一个公司的',
  `cand_user_id` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '面试者，候选人id',
  `job_id` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '面试的岗位id',
  `job_name` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '面试的岗位名称',
  `interview_time` datetime NOT NULL COMMENT '面试时间',
  `interview_address` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '面试地点',
  `remark` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '备注信息',
  `status` int NOT NULL COMMENT '面试邀约的状态\n1：等待候选人接受面试\n2：候选人已接受面试\n3：候选人已拒绝面试\n4：HR已取消面试\n5：面试通过',
  `cand_name` varchar(24) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '候选人名称（候选人名称）  \n简历名称与职位使用字段冗余，目的相当于快照，只记录当时信息',
  `cand_face` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '候选人头像  \n简历名称与职位使用字段冗余，目的相当于快照，只记录当时信息',
  `cand_position` varchar(24) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '候选人职位  \n简历名称与职位使用字段冗余，目的相当于快照，只记录当时信息',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='面试邀约表\n本表为次表，可做冗余，可以用mongo或者es替代';

-- ----------------------------
-- Records of interview
-- ----------------------------
BEGIN;
INSERT INTO `interview` VALUES ('1553764130923802625', '1111', '2222', '3333', '4444', NULL, '2022-08-01 12:12:12', '无锡传感园天鹅座', '请自行带好纸质简历~', 1, NULL, NULL, NULL);
INSERT INTO `interview` VALUES ('1553767645998030850', '1541299724478681090', '1541300495639175169', '1551835815514251265', '1549673794110795777', NULL, '2022-08-02 08:14:00', '日32让2', '', 2, NULL, NULL, NULL);
INSERT INTO `interview` VALUES ('1553767665908391937', '1541299724478681090', '1541300495639175169', '1551835815514251265', '1549673794110795777', NULL, '2022-08-02 08:14:00', '日32让2', '', 3, NULL, NULL, NULL);
INSERT INTO `interview` VALUES ('1553767846892609538', '1541299724478681090', '1541300495639175169', '1551835815514251265', '1549673794110795777', NULL, '2022-07-31 00:00:00', '日32让2', '', 1, NULL, NULL, NULL);
INSERT INTO `interview` VALUES ('1553768393917947905', '1541299724478681090', '1541300495639175169', '1551835815514251265', '1549673794110795777', NULL, '2022-07-31 10:00:00', '日32让2', '', 2, NULL, NULL, NULL);
INSERT INTO `interview` VALUES ('1553768823859273730', '1541299724478681090', '1541300495639175169', '1551835815514251265', '1549673794110795777', NULL, '2022-07-31 10:00:00', '日32让2', '弄得', 1, NULL, NULL, NULL);
INSERT INTO `interview` VALUES ('1553768826837229569', '1541299724478681090', '1541300495639175169', '1551835815514251265', '1549673794110795777', NULL, '2022-07-31 10:00:00', '日32让2', '弄得', 2, NULL, NULL, NULL);
INSERT INTO `interview` VALUES ('1553771257834856449', '1541299724478681090', '1541300495639175169', '1551835815514251265', '1549673794110795777', NULL, '2022-07-31 10:00:00', '日32让2', '', 1, NULL, NULL, NULL);
INSERT INTO `interview` VALUES ('1553771482620190721', '1541299724478681090', '1541300495639175169', '1551835815514251265', '1549673794110795777', NULL, '2022-07-31 10:00:00', '日32让2', '', 4, NULL, NULL, NULL);
INSERT INTO `interview` VALUES ('1553771501733634049', '1541299724478681090', '1541300495639175169', '1551835815514251265', '', NULL, '2022-07-31 10:00:00', '', '', 3, NULL, NULL, NULL);
INSERT INTO `interview` VALUES ('1553773145930162177', '1541299724478681090', '1541300495639175169', '1551835815514251265', '1549673794110795777', NULL, '2022-08-01 10:00:00', '日32让2', '', 4, NULL, NULL, NULL);
INSERT INTO `interview` VALUES ('1553780028241903618', '1541299724478681090', '1541300495639175169', '1551835815514251265', '1547541384921362433', NULL, '2022-08-01 10:00:00', 'gregre', '', 4, NULL, NULL, NULL);
INSERT INTO `interview` VALUES ('1553781038645542913', '1541299724478681090', '1541300495639175169', '1551835815514251265', '1547541384921362433', NULL, '2022-08-01 10:00:00', 'gregre', '', 3, NULL, NULL, NULL);
INSERT INTO `interview` VALUES ('1553781481664708610', '1541299724478681090', '1541300495639175169', '1551835815514251265', '1547541384921362433', NULL, '2022-08-01 10:00:00', 'gregre', '', 4, NULL, NULL, NULL);
INSERT INTO `interview` VALUES ('1553781759105335298', '1541299724478681090', '1541300495639175169', '1551835815514251265', '1547541384921362433', NULL, '2022-08-01 10:00:00', 'gregre', '', 2, NULL, NULL, NULL);
INSERT INTO `interview` VALUES ('1553935659070423041', '1541299724478681090', '1541300495639175169', '1551835815514251265', '1547541384921362433', NULL, '2022-08-01 10:00:00', 'gregre', '', 4, NULL, NULL, NULL);
INSERT INTO `interview` VALUES ('1553942316835930114', '1541299724478681090', '1541300495639175169', '1551835815514251265', '1547541384921362433', NULL, '2022-08-01 10:00:00', 'gregre', '', 1, '我是求职的', NULL, '初级Java');
INSERT INTO `interview` VALUES ('1553942438164561922', '1541299724478681090', '1541300495639175169', '1551835815514251265', '1549673794110795777', NULL, '2022-08-01 10:00:00', '日32让2', '', 4, '我是求职的', NULL, '初级Java');
INSERT INTO `interview` VALUES ('1553944584440270850', '1541299724478681090', '1541300495639175169', '1551835815514251265', '1547549009855713282', 'CTO', '2022-08-01 10:00:00', '啊啊啊', '', 4, '我是求职的', 'http://192.168.1.4:8000/static/face/1551835815514251265.png', '初级Java');
INSERT INTO `interview` VALUES ('1553945464426221570', '1541299724478681090', '1541300495639175169', '1551835815514251265', '1547549006563184642', '架构师111', '2022-08-01 10:00:00', '啊啊啊', '请带好简历。\n我们不提供打印。请带好简历。\n我们不提供打印。请带好简历。\n我们不提供打印。', 1, '我是求职的', 'http://192.168.1.4:8000/static/face/1551835815514251265.png', '初级Java');
INSERT INTO `interview` VALUES ('1553947099164594177', '1541299724478681090', '1541300495639175169', '1551835815514251265', '1549673794110795777', '牛逼的97架构师', '2022-08-01 10:00:00', '日32让2', '请带好简历。\n我们不提供打印。\n请带好简历。\n我们不提供打印。\n请带好简历。\n我们不提供打印。', 1, '我是求职的', 'http://192.168.1.4:8000/static/face/1551835815514251265.png', '初级Java');
INSERT INTO `interview` VALUES ('1553948431443316738', '1541299724478681090', '1541300495639175169', '1551835815514251265', '1549673794110795777', '牛逼的97架构师', '2022-08-01 10:00:00', '日32让2', '测试', 2, NULL, NULL, NULL);
INSERT INTO `interview` VALUES ('1553948809740271618', '1541299724478681090', '1541300495639175169', '1551835815514251265', '1547541384921362433', 'dwqd', '2022-08-01 10:00:00', 'gregre', '参加', 3, '我是求职的', 'http://192.168.1.4:8000/static/face/1551835815514251265.png', '初级Java');
INSERT INTO `interview` VALUES ('1553949520217620481', '1541299724478681090', '1541300495639175169', '1551835815514251265', '1549673794110795777', '牛逼的97架构师', '2022-08-01 10:00:00', '日32让2', '自备简历', 4, '我是求职的', 'http://192.168.1.4:8000/static/face/1551835815514251265.png', '初级Java');
INSERT INTO `interview` VALUES ('1553951155559972866', '1541299724478681090', '1541300495639175169', '1551835815514251265', '1549673794110795777', '牛逼的97架构师', '2022-08-01 10:00:00', '日32让2', '哈哈哈', 1, '我是求职的', 'http://192.168.1.4:8000/static/face/1551835815514251265.png', '初级Java');
INSERT INTO `interview` VALUES ('1553952636212199426', '1541299724478681090', '1541300495639175169', '1551835815514251265', '1547541384921362433', 'dwqd', '2022-08-01 10:00:00', 'gregre', '', 2, '我是求职的', 'http://192.168.1.4:8000/static/face/1551835815514251265.png', '初级Java');
INSERT INTO `interview` VALUES ('1553953837112737794', '1541299724478681090', '1541300495639175169', '1551835815514251265', '1547541384921362433', 'dwqd', '2022-08-01 10:00:00', 'gregre', '', 3, '我是求职的', 'http://192.168.1.4:8000/static/face/1551835815514251265.png', '初级Java');
INSERT INTO `interview` VALUES ('1553953942289104898', '1541299724478681090', '1541300495639175169', '1551835815514251265', '1549673794110795777', '牛逼的97架构师', '2022-08-01 10:00:00', '日32让2', '', 3, '我是求职的', 'http://192.168.1.4:8000/static/face/1551835815514251265.png', '初级Java');
INSERT INTO `interview` VALUES ('1554055209115983873', '1541299724478681090', '1541300495639175169', '1551835815514251265', '1549673794110795777', '牛逼的97架构师', '2022-08-01 10:00:00', '日32让2', '', 4, '我是求职的', 'http://192.168.1.10:8000/static/face/1551835815514251265.png', '初级Java');
INSERT INTO `interview` VALUES ('1554055841457643521', '1541299724478681090', '1541300495639175169', '1551835815514251265', '1547541384921362433', 'dwqd', '2022-08-01 10:00:00', 'gregre', '', 4, '我是求职的', 'http://192.168.1.10:8000/static/face/1551835815514251265.png', '初级Java');
INSERT INTO `interview` VALUES ('1554056022349586433', '1541299724478681090', '1541300495639175169', '1551835815514251265', '1547541384921362433', 'dwqd', '2022-08-01 10:00:00', 'gregre', '', 2, '我是求职的', 'http://192.168.1.10:8000/static/face/1551835815514251265.png', '初级Java');
INSERT INTO `interview` VALUES ('1554057031096475650', '1541299724478681090', '1541300495639175169', '1551835815514251265', '1547541384921362433', 'dwqd', '2022-08-01 10:00:00', 'gregre', '', 3, '我是求职的', 'http://192.168.1.10:8000/static/face/1551835815514251265.png', '初级Java');
INSERT INTO `interview` VALUES ('1554387877544341505', '1541299724478681090', '1541300495639175169', '1551835815514251265', '1547541384921362433', 'dwqd', '2022-08-02 10:00:00', 'gregre', '', 4, '我是求职的', 'http://192.168.1.10:8000/static/face/1551835815514251265.png', '初级Java');
INSERT INTO `interview` VALUES ('1554387937254453250', '1541299724478681090', '1541300495639175169', '1551835815514251265', '1547517235993849858', 'reasd', '2022-08-02 10:00:00', 'fewfwe', '', 2, '我是求职的', 'http://192.168.1.10:8000/static/face/1551835815514251265.png', '初级Java');
INSERT INTO `interview` VALUES ('1554388736224382977', '1541299724478681090', '1541300495639175169', '1551835815514251265', '1549673794110795777', '牛逼的97架构师', '2022-08-02 10:00:00', '日32让2', '', 2, '我是求职的', 'http://192.168.1.10:8000/static/face/1551835815514251265.png', '初级Java');
INSERT INTO `interview` VALUES ('1554388779413131266', '1541299724478681090', '1541300495639175169', '1554096527766749186', '1547549009855713282', 'CTO', '2022-08-02 10:00:00', '啊啊啊', '', 1, '用户：13******677', 'http://122.152.205.72:88/group1/M00/00/05/CpoxxF6ZUySASMbOAABBAXhjY0Y649.png', '底层码农');
INSERT INTO `interview` VALUES ('1556636002573123586', '1541299724478681090', '1541300495639175169', '1551835815514251265', '1549673794110795777', '牛逼的97架构师', '2022-08-08 10:00:00', '日32让2', '', 1, '我是求职的', 'http://192.168.1.10:8000/static/face/1551835815514251265.png', '初级Java');
COMMIT;

-- ----------------------------
-- Table structure for job
-- ----------------------------
DROP TABLE IF EXISTS `job`;
CREATE TABLE `job` (
  `id` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `hr_id` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '谁的职位，HR角色用户id',
  `company_id` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '职位所属哪家公司的，HR离职后则不能查询到',
  `job_name` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '职位名称',
  `job_type` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '职位类别',
  `exp_years` varchar(256) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '工作经验年限',
  `edu` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '技能标签',
  `begin_salary` int NOT NULL COMMENT '薪资要求区间-起始',
  `end_salary` int NOT NULL COMMENT '薪资要求区间-结束',
  `monthly_salary` int NOT NULL COMMENT '总共几个月工资',
  `job_desc` varchar(4000) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '职位描述',
  `tags` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '职位标签',
  `city` varchar(24) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '工作城市',
  `address` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '工作地点',
  `status` int NOT NULL COMMENT '1：招聘中，open\n2：已关闭，close\n3：违规删除，delete',
  `violate_reason` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '违规原因',
  `create_time` datetime NOT NULL,
  `updated_time` datetime NOT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='HR发布的职位表';

-- ----------------------------
-- Records of job
-- ----------------------------
BEGIN;
INSERT INTO `job` VALUES ('1541300495639175169', '1541299724478681090', '1541300495639175169', '架构师111w', 'CTO', '20', '本科', 10, 20, 16, '分为肉脯grew官方推然后给', ',dedew,dewfcew,few,', '无锡', '啊啊啊', 3, NULL, '2022-07-14 19:50:08', '2022-07-23 18:04:48');
INSERT INTO `job` VALUES ('1547454147718361090', '1534766306928394242', '1541300495639175169', '架构师111', 'CTO', '20', '本科', 10, 20, 16, '分为肉脯grew官方推然后给', ',dedew,dewfcew,few,', '无锡', '啊啊啊', 1, NULL, '2022-07-14 13:33:14', '2022-07-14 13:33:34');
INSERT INTO `job` VALUES ('1547517235993849858', '1541299724478681090', '1541300495639175169', 'reasd', 'CTO', '3-5年', '博士', 2, 7, 16, 'fwefwef', 'fewfew', '长治市', 'fewfwe', 1, NULL, '2022-07-14 17:43:55', '2022-07-14 17:43:55');
INSERT INTO `job` VALUES ('1547541384921362433', '1541299724478681090', '1541300495639175169', 'dwqd', 'CTO', '不限', '不限', 1, 2, 15, 'gtrev ', 'gre', '长治市', 'gregre', 1, NULL, '2022-07-14 19:19:53', '2022-07-31 22:35:18');
INSERT INTO `job` VALUES ('1547548985600053250', '1541299724478681090123', '1541300495639175169', '架构师111', 'CTO', '20', '本科', 10, 20, 16, '分为肉脯grew官方推然后给', ',dedew,dewfcew,few,', '无锡', '啊啊啊', 2, NULL, '2022-07-14 19:50:05', '2022-07-14 19:50:05');
INSERT INTO `job` VALUES ('1547548989291040770', '1541299724478681090', '1541300495639175169', '架构师111', 'CTO', '20', '本科', 10, 20, 16, '分为肉脯grew官方推然后给', ',dedew,dewfcew,few,', '无锡', '啊啊啊', 3, NULL, '2022-07-14 19:50:06', '2022-07-14 19:50:06');
INSERT INTO `job` VALUES ('1547548991916675073', '1541299724478681090', '1541300495639175169', '架构师111', 'CTO', '20', '本科', 10, 20, 16, '分为肉脯grew官方推然后给', ',dedew,dewfcew,few,', '无锡', '啊啊啊', 3, NULL, '2022-07-14 19:50:06', '2022-07-14 19:50:06');
INSERT INTO `job` VALUES ('1547548993325961218', '1541299724478681090', '1541300495639175169', '架构师111', 'CTO', '20', '本科', 10, 20, 16, '分为肉脯grew官方推然后给', ',dedew,dewfcew,few,', '无锡', '啊啊啊', 1, NULL, '2022-07-14 19:50:07', '2022-07-14 19:50:07');
INSERT INTO `job` VALUES ('1547548995284701186', '1541299724478681090', '1541300495639175169', '架构师111', 'CTO', '20', '本科', 10, 20, 16, '分为肉脯grew官方推然后给', ',dedew,dewfcew,few,', '无锡', '啊啊啊', 3, NULL, '2022-07-14 19:50:07', '2022-07-14 19:50:07');
INSERT INTO `job` VALUES ('1547548996878536705', '1541299724478681090', '1541300495639175169', '架构师111', 'CTO', '20', '本科', 10, 20, 16, '分为肉脯grew官方推然后给', ',dedew,dewfcew,few,', '无锡', '啊啊啊', 1, NULL, '2022-07-14 19:50:08', '2022-07-14 19:50:08');
INSERT INTO `job` VALUES ('1547548998677893121', '1541299724478681090', '1541300495639175169', '架构师111', 'CTO', '20', '本科', 10, 20, 16, '分为肉脯grew官方推然后给', ',dedew,dewfcew,few,', '无锡', '啊啊啊', 1, NULL, '2022-07-14 19:50:08', '2022-07-14 19:50:08');
INSERT INTO `job` VALUES ('1547549001991393282', '1541299724478681090', '1541300495639175169', '架构师111', 'CTO', '20', '本科', 10, 20, 16, '分为肉脯grew官方推然后给', ',dedew,dewfcew,few,', '无锡', '啊啊啊', 1, NULL, '2022-07-14 19:50:09', '2022-07-14 19:50:09');
INSERT INTO `job` VALUES ('1547549003761389570', '1541299724478681090', '1541300495639175169', '架构师111', 'CTO', '20', '本科', 10, 20, 16, '分为肉脯grew官方推然后给', ',dedew,dewfcew,few,', '无锡', '啊啊啊', 1, NULL, '2022-07-14 19:50:09', '2022-07-14 19:50:09');
INSERT INTO `job` VALUES ('1547549005292310529', '1541299724478681090', '123', '架构师111', 'CTO', '20', '本科', 10, 20, 16, '分为肉脯grew官方推然后给', ',dedew,dewfcew,few,', '无锡', '啊啊啊', 1, NULL, '2022-07-14 19:50:10', '2022-07-14 19:50:10');
INSERT INTO `job` VALUES ('1547549006563184642', '1541299724478681090', '1541300495639175169', '架构师111', 'CTO', '20', '本科', 10, 20, 16, '分为肉脯grew官方推然后给', ',dedew,dewfcew,few,', '无锡', '啊啊啊', 1, NULL, '2022-07-14 19:50:10', '2022-07-14 19:50:10');
INSERT INTO `job` VALUES ('1547549008299626497', '1541299724478681090', '1541300495639175169', '架构师111', 'CTO', '20', '本科', 10, 20, 16, '分为肉脯grew官方推然后给', ',dedew,dewfcew,few,', '无锡', '啊啊啊', 1, NULL, '2022-07-14 19:50:10', '2022-07-14 19:50:10');
INSERT INTO `job` VALUES ('1547549009855713282', '1541299724478681090', '1541300495639175169', 'CTO', 'CTO', '20', '本科', 10, 20, 16, '分为肉脯grew官方推然后给', ',dedew,dewfcew,few,', '无锡', '啊啊啊', 1, NULL, '2022-07-14 19:50:11', '2022-07-14 19:50:11');
INSERT INTO `job` VALUES ('1547549011244027906', '1541299724478681090', '1541300495639175169', '全栈工程师', '全栈工程师', '20', '本科', 10, 20, 16, '分为肉脯grew官方推然后给', ',dedew,dewfcew,few,', '无锡', '啊啊啊', 3, NULL, '2022-07-14 19:50:11', '2022-07-23 17:42:44');
INSERT INTO `job` VALUES ('1547599841879957505', '1541299724478681090', '1541300495639175169', 'Java高级工程师2', 'Python', '10年以上', '博士', 6, 7, 16, '1. 精通java\n2. 精通网络编程\n3. 非常牛\n4. 能说会道\n5. 能忽悠人\n6. 海王', 'java,hibernate,架构师,spring', '白山市', '苏州园区大裤衩88楼88室2-202', 3, '地址不存在', '2022-07-14 23:12:10', '2022-07-23 18:01:44');
INSERT INTO `job` VALUES ('1549673794110795777', '1541299724478681090', '1541300495639175169', '牛逼的97架构师', 'C++', '1年以下', '中专/技校', 21, 25, 15, '法测定测温', '入2,入2日3日3', '秦皇岛市', '日32让2', 1, NULL, '2022-07-20 16:33:19', '2022-07-20 16:33:19');
INSERT INTO `job` VALUES ('1560283331810668545', '1553737574100766721', '1560274281974820865', 'Java架构师', 'Java', '10年以上', '大专', 20, 40, 15, '1. 精通Java开发，熟悉各种数据库\n2. 精通JavaWeb以及各大框架，熟悉Spring, SpringCloud微服务, MyBatis 三大框架\n3. 熟悉各种中间件安装与配置，掌握其原理以及开发应用。Redis, RabbitMQ, kafka, 工作流, Zookeeper, ElasticSearch, logstash, Canal等\n4. 熟悉容器化Devop云原生，K8S\n5. 熟悉手机安卓开发以及全栈\n6. 精通前端技术栈开发', '架构师,Java,牛逼', '北京市', '南京雨花台传感园区', 1, NULL, '2022-08-18 23:11:50', '2022-08-18 23:11:50');
INSERT INTO `job` VALUES ('1560283755527647233', '1553737574100766721', '1560274281974820865', '技术组长', 'Java', '不限', '不限', 13, 22, 13, '1. 熟悉java开发\n2. 熟悉各类web架构\n3. 精通网络编程\n4. 有一定的表达能力沟通能力\n5. 有责任心\n6. 能有抗压能力', '管理,Java,技术', '北京市', '北京周边', 1, NULL, '2022-08-18 23:13:31', '2022-08-18 23:13:31');
INSERT INTO `job` VALUES ('1560284015343808513', '1553737574100766721', '1560274281974820865', '房产经纪人', '置业顾问', '不限', '不限', 7, 13, 19, '1. 负责房产销售\n2. 负责客户关系长期保持\n3. 负责接送客户到楼盘\n4. 有一定的表达能力沟通能力\n5. 有责任心\n6. 能有抗压能力 ', '百万年薪,卖房子', '北京市', '江南地区', 1, NULL, '2022-08-18 23:14:33', '2022-08-18 23:14:33');
INSERT INTO `job` VALUES ('1560284299067502594', '1553737574100766721', '1560274281974820865', '高级测试', '软件测试', '不限', '不限', 7, 15, 14, '要有牛逼的测试技术', '白盒测试,压力测试', '北京市', '江苏地区', 1, NULL, '2022-08-18 23:15:40', '2022-08-18 23:15:40');
INSERT INTO `job` VALUES ('1560284574251593730', '1553737574100766721', '1560274281974820865', 'Java高级工程师', 'Java', '不限', '不限', 12, 27, 16, '1. 精通Java开发，熟悉各种数据库\n2. 精通JavaWeb以及各大框架，熟悉Spring, SpringCloud微服务, MyBatis 三大框架\n3. 熟悉各种中间件安装与配置，掌握其原理以及开发应用。Redis, RabbitMQ, kafka, 工作流, Zookeeper, ElasticSearch, logstash, Canal等\n4. 熟悉容器化Devop云原生，K8S\n5. 熟悉手机安卓开发以及全栈\n6. 精通前端技术栈开发', 'Java,微服务', '北京市', '北京中科园区', 1, NULL, '2022-08-18 23:16:46', '2022-08-18 23:16:46');
INSERT INTO `job` VALUES ('1560284983057821698', '1553737574100766721', '1560274281974820865', 'CTO', '总裁/总经理/CEO', '不限', '不限', 65, 145, 12, '能够给公司带来每年1000万的收益与1个小目标的投资。\n', 'Cto,高级管理', '北京市', '苏州园区', 1, NULL, '2022-08-18 23:18:23', '2022-08-18 23:18:23');
INSERT INTO `job` VALUES ('1560285699654660097', '1553737574100766721', '1560274281974820865', '高级产品经理', '产品经理', '不限', '不限', 11, 19, 21, '1. 从产品开发和市场营销战略研究到成品的全程跟踪，管理及监管运营；\n2. 对新项目调研和按计划实施；\n3. 制作产品策略相应的推广工具，负责产品知识和市场知识的销售培训；\n4. 配合、协调运营、研发等相关部门资源推动产品发展；\n5. 对日常用户、运营数据进行跟踪和研究，定期分析运营效果，掌握产品运行现状。', '产品研发', '北京市', '南京某园区', 1, NULL, '2022-08-18 23:21:14', '2022-08-18 23:21:52');
COMMIT;

-- ----------------------------
-- Table structure for job_type
-- ----------------------------
DROP TABLE IF EXISTS `job_type`;
CREATE TABLE `job_type` (
  `id` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `name` varchar(24) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '行业名称',
  `sort` int NOT NULL COMMENT '排序',
  `father_id` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '为0则当前为第一级分类，否则当前为fatherId所对应行业的子分类',
  `is_leaf` tinyint(1) NOT NULL COMMENT '用于提供给前端tree显示标记是否展示下拉箭头，一级分类与二级分类为true，三级分类也就是最后一级分类是false',
  `level` int NOT NULL COMMENT '分类层级，用于标记',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='职位类别';

-- ----------------------------
-- Records of job_type
-- ----------------------------
BEGIN;
INSERT INTO `job_type` VALUES ('1546726718246776834', 'IT互联网技术', 1, '0', 0, 1);
INSERT INTO `job_type` VALUES ('1546726766594519041', '电子/通信', 2, '0', 0, 1);
INSERT INTO `job_type` VALUES ('1546726915978850306', '产品', 3, '0', 0, 1);
INSERT INTO `job_type` VALUES ('1546727040302215169', '运营/客服', 4, '0', 0, 1);
INSERT INTO `job_type` VALUES ('1546727138113384449', '销售', 5, '0', 0, 1);
INSERT INTO `job_type` VALUES ('1546727732551118849', '人事/行政/法务', 6, '0', 0, 1);
INSERT INTO `job_type` VALUES ('1546727788402470913', '财务/审计/税务', 7, '0', 0, 1);
INSERT INTO `job_type` VALUES ('1546727835013771266', '生产制造', 8, '0', 0, 1);
INSERT INTO `job_type` VALUES ('1546727893234905089', '生活服务/零售', 9, '0', 0, 1);
INSERT INTO `job_type` VALUES ('1546728889956724738', '餐饮', 10, '0', 0, 1);
INSERT INTO `job_type` VALUES ('1546728963302518786', '酒店/旅游', 11, '0', 0, 1);
INSERT INTO `job_type` VALUES ('1546729029299892226', '教育培训', 12, '0', 0, 1);
INSERT INTO `job_type` VALUES ('1546729087458111489', '设计', 13, '0', 0, 1);
INSERT INTO `job_type` VALUES ('1546729124095356929', '房地产/建筑', 14, '0', 0, 1);
INSERT INTO `job_type` VALUES ('1546729166420078593', '影视传媒', 15, '0', 0, 1);
INSERT INTO `job_type` VALUES ('1546729251728027649', '市场/公关/广告', 16, '0', 0, 1);
INSERT INTO `job_type` VALUES ('1546729300927213570', '供应链/物流', 17, '0', 0, 1);
INSERT INTO `job_type` VALUES ('1546729339112157186', '采购/贸易', 18, '0', 0, 1);
INSERT INTO `job_type` VALUES ('1546729377531981825', '医疗健康', 19, '0', 0, 1);
INSERT INTO `job_type` VALUES ('1546729481181622273', '金融', 20, '0', 0, 1);
INSERT INTO `job_type` VALUES ('1546729557564092418', '咨询/翻译/法律', 21, '0', 0, 1);
INSERT INTO `job_type` VALUES ('1546729606780055554', '农业/环保', 22, '0', 0, 1);
INSERT INTO `job_type` VALUES ('1546729642997870593', '高级管理', 23, '0', 0, 1);
INSERT INTO `job_type` VALUES ('1546729670227292161', '其他', 24, '0', 0, 1);
INSERT INTO `job_type` VALUES ('1546730610594443266', '后端开发', 1, '1546726718246776834', 0, 2);
INSERT INTO `job_type` VALUES ('1546730635131121666', '前端开发', 2, '1546726718246776834', 0, 2);
INSERT INTO `job_type` VALUES ('1546730668010270722', '移动开发', 3, '1546726718246776834', 0, 2);
INSERT INTO `job_type` VALUES ('1546730695894003714', '测试', 4, '1546726718246776834', 0, 2);
INSERT INTO `job_type` VALUES ('1546730735819583489', '运维/技术支持', 5, '1546726718246776834', 0, 2);
INSERT INTO `job_type` VALUES ('1546730778995748866', '销售技术支持', 6, '1546726718246776834', 0, 2);
INSERT INTO `job_type` VALUES ('1546730808389431297', '数据', 7, '1546726718246776834', 0, 2);
INSERT INTO `job_type` VALUES ('1546730838928158722', '人工智能', 8, '1546726718246776834', 0, 2);
INSERT INTO `job_type` VALUES ('1546730873812185090', '技术项目管理', 9, '1546726718246776834', 0, 2);
INSERT INTO `job_type` VALUES ('1546730906712305665', '高端技术职位', 10, '1546726718246776834', 0, 2);
INSERT INTO `job_type` VALUES ('1546730931253178370', '其他技术职位', 11, '1546726718246776834', 0, 2);
INSERT INTO `job_type` VALUES ('1546731108932284418', 'Java', 1, '1546730610594443266', 1, 3);
INSERT INTO `job_type` VALUES ('1546731129551482882', 'C++', 2, '1546730610594443266', 1, 3);
INSERT INTO `job_type` VALUES ('1546731174510227458', 'Python', 3, '1546730610594443266', 1, 3);
INSERT INTO `job_type` VALUES ('1546731193485258753', 'PHP', 4, '1546730610594443266', 1, 3);
INSERT INTO `job_type` VALUES ('1546731225424883714', 'Golang', 5, '1546730610594443266', 1, 3);
INSERT INTO `job_type` VALUES ('1546731251714781185', '.Net', 6, '1546730610594443266', 1, 3);
INSERT INTO `job_type` VALUES ('1546731275110608898', 'C#', 7, '1546730610594443266', 1, 3);
INSERT INTO `job_type` VALUES ('1546731291782967297', 'C', 8, '1546730610594443266', 1, 3);
INSERT INTO `job_type` VALUES ('1546731365426556929', '全栈工程师', 9, '1546730610594443266', 1, 3);
INSERT INTO `job_type` VALUES ('1546731448117260290', '语音/视频/图形开发', 10, '1546730610594443266', 1, 3);
INSERT INTO `job_type` VALUES ('1546731471450173442', '数据采集', 11, '1546730610594443266', 1, 3);
INSERT INTO `job_type` VALUES ('1546731521811181569', 'GIS工程师', 12, '1546730610594443266', 1, 3);
INSERT INTO `job_type` VALUES ('1546731559396339713', 'Node.js', 13, '1546730610594443266', 1, 3);
INSERT INTO `job_type` VALUES ('1546731601469403138', 'Hadoop', 14, '1546730610594443266', 1, 3);
INSERT INTO `job_type` VALUES ('1546731651863965697', 'Delphi', 15, '1546730610594443266', 1, 3);
INSERT INTO `job_type` VALUES ('1546731671908544513', 'VB', 16, '1546730610594443266', 1, 3);
INSERT INTO `job_type` VALUES ('1546731702430494722', 'Ruby', 17, '1546730610594443266', 1, 3);
INSERT INTO `job_type` VALUES ('1546731794923286530', 'Perl', 18, '1546730610594443266', 1, 3);
INSERT INTO `job_type` VALUES ('1546731820697284609', '后端开发', 19, '1546730610594443266', 1, 3);
INSERT INTO `job_type` VALUES ('1546732146565345282', 'web前端', 1, '1546730635131121666', 1, 3);
INSERT INTO `job_type` VALUES ('1546732181428400129', 'Flash开发', 2, '1546730635131121666', 1, 3);
INSERT INTO `job_type` VALUES ('1546732253817892865', 'JavaScript', 3, '1546730635131121666', 1, 3);
INSERT INTO `job_type` VALUES ('1546732375213633538', 'Android', 1, '1546730668010270722', 1, 3);
INSERT INTO `job_type` VALUES ('1546732422995144705', 'U3D', 3, '1546730668010270722', 1, 3);
INSERT INTO `job_type` VALUES ('1546732463075913729', 'UE4', 4, '1546730668010270722', 1, 3);
INSERT INTO `job_type` VALUES ('1546732483988713473', 'Cocos', 5, '1546730668010270722', 1, 3);
INSERT INTO `job_type` VALUES ('1546732565882499073', '测试工程师', 1, '1546730695894003714', 1, 3);
INSERT INTO `job_type` VALUES ('1546732590918299650', '软件测试', 2, '1546730695894003714', 1, 3);
INSERT INTO `job_type` VALUES ('1546732612896452610', '自动化测试', 3, '1546730695894003714', 1, 3);
INSERT INTO `job_type` VALUES ('1546732639345733634', '功能测试', 4, '1546730695894003714', 1, 3);
INSERT INTO `job_type` VALUES ('1546732665455276033', '硬件测试', 5, '1546730695894003714', 1, 3);
INSERT INTO `job_type` VALUES ('1546732694580523010', '游戏测试', 6, '1546730695894003714', 1, 3);
INSERT INTO `job_type` VALUES ('1546732717653389313', '性能测试', 7, '1546730695894003714', 1, 3);
INSERT INTO `job_type` VALUES ('1546732743158951938', '渗透测试', 8, '1546730695894003714', 1, 3);
INSERT INTO `job_type` VALUES ('1546732811698073601', '运维工程师', 1, '1546730735819583489', 1, 3);
INSERT INTO `job_type` VALUES ('1546732857021722626', 'IT技术支持', 2, '1546730735819583489', 1, 3);
INSERT INTO `job_type` VALUES ('1546732987196141570', '网络工程师', 3, '1546730735819583489', 1, 3);
INSERT INTO `job_type` VALUES ('1546733031936782338', '网络安全', 4, '1546730735819583489', 1, 3);
INSERT INTO `job_type` VALUES ('1546733057635282946', '系统工程师', 5, '1546730735819583489', 1, 3);
INSERT INTO `job_type` VALUES ('1546733117601247233', '运维开发工程师', 6, '1546730735819583489', 1, 3);
INSERT INTO `job_type` VALUES ('1546733307217342466', '系统管理员', 7, '1546730735819583489', 1, 3);
INSERT INTO `job_type` VALUES ('1546733335688278017', 'DBA', 8, '1546730735819583489', 1, 3);
INSERT INTO `job_type` VALUES ('1546733367892144130', '系统安全', 9, '1546730735819583489', 1, 3);
INSERT INTO `job_type` VALUES ('1546733451069386753', '售前支持', 1, '1546730778995748866', 1, 3);
INSERT INTO `job_type` VALUES ('1546733472233844737', '售后支持', 2, '1546730778995748866', 1, 3);
INSERT INTO `job_type` VALUES ('1546733602152411137', '数据分析师', 1, '1546730808389431297', 1, 3);
INSERT INTO `job_type` VALUES ('1546733619583938562', '数据开发', 2, '1546730808389431297', 1, 3);
INSERT INTO `job_type` VALUES ('1546733638722547714', '数据仓库', 3, '1546730808389431297', 1, 3);
INSERT INTO `job_type` VALUES ('1546733674629984258', 'ETL工程师', 4, '1546730808389431297', 1, 3);
INSERT INTO `job_type` VALUES ('1546733708050198529', '数据挖掘', 5, '1546730808389431297', 1, 3);
INSERT INTO `job_type` VALUES ('1546733748936273922', '数据架构师', 6, '1546730808389431297', 1, 3);
INSERT INTO `job_type` VALUES ('1546733807660724225', '算法工程师', 1, '1546730838928158722', 1, 3);
INSERT INTO `job_type` VALUES ('1546733833359224833', '图像识别', 2, '1546730838928158722', 1, 3);
INSERT INTO `job_type` VALUES ('1546733858915119106', '机器学习', 3, '1546730838928158722', 1, 3);
INSERT INTO `job_type` VALUES ('1546733886379421697', '深度学习', 4, '1546730838928158722', 1, 3);
INSERT INTO `job_type` VALUES ('1546733913558511618', '自然语言', 5, '1546730838928158722', 1, 3);
INSERT INTO `job_type` VALUES ('1546733948362846209', '算法研究院', 6, '1546730838928158722', 1, 3);
INSERT INTO `job_type` VALUES ('1546734029212250113', '智能驾驶系统工程师', 7, '1546730838928158722', 1, 3);
INSERT INTO `job_type` VALUES ('1546734086212841474', '推荐算法', 8, '1546730838928158722', 1, 3);
INSERT INTO `job_type` VALUES ('1546734127065362434', '语音识别', 9, '1546730838928158722', 1, 3);
INSERT INTO `job_type` VALUES ('1546734175861895170', '搜索算法', 10, '1546730838928158722', 1, 3);
INSERT INTO `job_type` VALUES ('1546734241414672385', '反欺诈/风控算法', 11, '1546730838928158722', 1, 3);
INSERT INTO `job_type` VALUES ('1546734286469885954', '项目经理/主管', 1, '1546730873812185090', 1, 3);
INSERT INTO `job_type` VALUES ('1546734310855569410', '项目助理', 2, '1546730873812185090', 1, 3);
INSERT INTO `job_type` VALUES ('1546734329453113345', '项目专员', 3, '1546730873812185090', 1, 3);
INSERT INTO `job_type` VALUES ('1546734359484329985', '实施工程师', 4, '1546730873812185090', 1, 3);
INSERT INTO `job_type` VALUES ('1546734389423271938', '需求分析工程师', 5, '1546730873812185090', 1, 3);
INSERT INTO `job_type` VALUES ('1546734471145091074', '技术经理', 1, '1546730906712305665', 1, 3);
INSERT INTO `job_type` VALUES ('1546734491667820545', '架构师', 2, '1546730906712305665', 1, 3);
INSERT INTO `job_type` VALUES ('1546734514128318466', '技术总监', 3, '1546730906712305665', 1, 3);
INSERT INTO `job_type` VALUES ('1546734534411972609', 'CTO', 4, '1546730906712305665', 1, 3);
INSERT INTO `job_type` VALUES ('1546734558705381377', '测试经理', 5, '1546730906712305665', 1, 3);
INSERT INTO `job_type` VALUES ('1546734582923292674', '技术合伙人', 6, '1546730906712305665', 1, 3);
INSERT INTO `job_type` VALUES ('1546734609271910401', '运维总监', 7, '1546730906712305665', 1, 3);
INSERT INTO `job_type` VALUES ('1546734655371505665', '部门经理', 8, '1546730906712305665', 1, 3);
INSERT INTO `job_type` VALUES ('1546734700963590145', '其他技术岗位', 1, '1546730931253178370', 1, 3);
INSERT INTO `job_type` VALUES ('1546735777599483905', '电子/半导体', 1, '1546726766594519041', 0, 2);
INSERT INTO `job_type` VALUES ('1546735802350071809', '硬件开发', 2, '1546726766594519041', 0, 2);
INSERT INTO `job_type` VALUES ('1546735824114315266', '通信', 3, '1546726766594519041', 0, 2);
INSERT INTO `job_type` VALUES ('1546736141237252098', '电气工程师', 1, '1546735777599483905', 1, 3);
INSERT INTO `job_type` VALUES ('1546736173483061250', '电子工程师', 2, '1546735777599483905', 1, 3);
INSERT INTO `job_type` VALUES ('1546736204902592513', '电气设计工程师', 3, '1546735777599483905', 1, 3);
INSERT INTO `job_type` VALUES ('1546736255720779778', '集成电路IC设计', 4, '1546735777599483905', 1, 3);
INSERT INTO `job_type` VALUES ('1546736279749947393', 'FAE', 5, '1546735777599483905', 1, 3);
INSERT INTO `job_type` VALUES ('1546736321269362690', 'IC验证工程师', 6, '1546735777599483905', 1, 3);
INSERT INTO `job_type` VALUES ('1546736475179347969', '硬件工程师', 1, '1546735802350071809', 1, 3);
INSERT INTO `job_type` VALUES ('1546736501477634050', '嵌入式', 2, '1546735802350071809', 1, 3);
INSERT INTO `job_type` VALUES ('1546736521111171073', '自动化', 3, '1546735802350071809', 1, 3);
INSERT INTO `job_type` VALUES ('1546736555630292993', 'FPGA开发', 4, '1546735802350071809', 1, 3);
INSERT INTO `job_type` VALUES ('1546736580049530881', '单片机', 5, '1546735802350071809', 1, 3);
INSERT INTO `job_type` VALUES ('1546736611582308354', '驱动开发', 6, '1546735802350071809', 1, 3);
INSERT INTO `job_type` VALUES ('1546736661016375298', 'PCB工艺', 7, '1546735802350071809', 1, 3);
INSERT INTO `job_type` VALUES ('1546736693702586369', '射频工程师', 8, '1546735802350071809', 1, 3);
INSERT INTO `job_type` VALUES ('1546736723830272001', '电路设计', 8, '1546735802350071809', 1, 3);
INSERT INTO `job_type` VALUES ('1546736765198692354', '系统集成', 9, '1546735802350071809', 1, 3);
INSERT INTO `job_type` VALUES ('1546736799944306689', '光学工程师', 10, '1546735802350071809', 1, 3);
INSERT INTO `job_type` VALUES ('1546736825391149057', 'DSP开发', 11, '1546735802350071809', 1, 3);
INSERT INTO `job_type` VALUES ('1546736850351452161', 'ARM开发', 12, '1546735802350071809', 1, 3);
INSERT INTO `job_type` VALUES ('1546736938146623490', '通信项目专员', 1, '1546735824114315266', 1, 3);
INSERT INTO `job_type` VALUES ('1546736959885701121', '通信项目经理', 2, '1546735824114315266', 1, 3);
INSERT INTO `job_type` VALUES ('1546736991892434946', '通信技术工程师', 3, '1546735824114315266', 1, 3);
INSERT INTO `job_type` VALUES ('1546737026948427777', '通信研发工程师', 4, '1546735824114315266', 1, 3);
INSERT INTO `job_type` VALUES ('1546737107168686081', '无线/射频通信工程师', 5, '1546735824114315266', 1, 3);
INSERT INTO `job_type` VALUES ('1546737194095636481', '移动通信工程师', 6, '1546735824114315266', 1, 3);
INSERT INTO `job_type` VALUES ('1546737232498683906', '电信网络工程师', 7, '1546735824114315266', 1, 3);
INSERT INTO `job_type` VALUES ('1546737276887003137', '数据通信工程师', 8, '1546735824114315266', 1, 3);
INSERT INTO `job_type` VALUES ('1546737322688802818', '通信测试工程师', 9, '1546735824114315266', 1, 3);
INSERT INTO `job_type` VALUES ('1546737500493737985', '光通信工程师', 10, '1546735824114315266', 1, 3);
INSERT INTO `job_type` VALUES ('1546737541157515265', '光传输工程师', 11, '1546735824114315266', 1, 3);
INSERT INTO `job_type` VALUES ('1546737571297783810', '光网络工程师', 12, '1546735824114315266', 1, 3);
INSERT INTO `job_type` VALUES ('1546737636095586306', '通信电源工程师', 13, '1546735824114315266', 1, 3);
INSERT INTO `job_type` VALUES ('1546737671776530434', '有线传输工程师', 14, '1546735824114315266', 1, 3);
INSERT INTO `job_type` VALUES ('1546737706438258689', '通信设备工程师', 15, '1546735824114315266', 1, 3);
INSERT INTO `job_type` VALUES ('1546737771357696001', '核心网工程师', 16, '1546735824114315266', 1, 3);
INSERT INTO `job_type` VALUES ('1546737813254598657', '通信标准化工程师', 17, '1546735824114315266', 1, 3);
INSERT INTO `job_type` VALUES ('1546737854325223425', '电信交换工程师', 18, '1546735824114315266', 1, 3);
INSERT INTO `job_type` VALUES ('1546737969882492930', '互联网产品经理', 1, '1546726915978850306', 0, 2);
INSERT INTO `job_type` VALUES ('1546738043014377473', '游戏策划/制作', 2, '1546726915978850306', 0, 2);
INSERT INTO `job_type` VALUES ('1546738072915570689', '用户研究', 3, '1546726915978850306', 0, 2);
INSERT INTO `job_type` VALUES ('1546738096340758530', '高端产品职位', 4, '1546726915978850306', 0, 2);
INSERT INTO `job_type` VALUES ('1546738131681964033', '其他产品职位', 5, '1546726915978850306', 0, 2);
INSERT INTO `job_type` VALUES ('1546738163097300994', '产品经理', 1, '1546737969882492930', 1, 3);
INSERT INTO `job_type` VALUES ('1546738196618178562', '产品专员/助理', 2, '1546737969882492930', 1, 3);
INSERT INTO `job_type` VALUES ('1546738268634378242', '游戏策划', 1, '1546738043014377473', 1, 3);
INSERT INTO `job_type` VALUES ('1546738316080345089', '游戏制作人', 2, '1546738043014377473', 1, 3);
INSERT INTO `job_type` VALUES ('1546738349680914434', '用户研究员', 1, '1546738072915570689', 1, 3);
INSERT INTO `job_type` VALUES ('1546738376549625858', '用户研究经理', 2, '1546738072915570689', 1, 3);
INSERT INTO `job_type` VALUES ('1546738400339718146', '用户研究总监', 3, '1546738072915570689', 1, 3);
INSERT INTO `job_type` VALUES ('1546738478395715585', '产品总监/VP', 1, '1546738096340758530', 1, 3);
INSERT INTO `job_type` VALUES ('1546738533651476481', '金融产品经理', 1, '1546738131681964033', 1, 3);
INSERT INTO `job_type` VALUES ('1546738554404892674', '硬件产品经理', 2, '1546738131681964033', 1, 3);
INSERT INTO `job_type` VALUES ('1546738591973273602', '亚马逊产品开发', 3, '1546738131681964033', 1, 3);
INSERT INTO `job_type` VALUES ('1546738649003225090', '化妆品产品经理', 4, '1546738131681964033', 1, 3);
INSERT INTO `job_type` VALUES ('1546738694192656386', '其他产品岗位', 5, '1546738131681964033', 1, 3);
INSERT INTO `job_type` VALUES ('1546738781601951745', '客服', 1, '1546727040302215169', 0, 2);
INSERT INTO `job_type` VALUES ('1546738807354978305', '内容运营', 2, '1546727040302215169', 0, 2);
INSERT INTO `job_type` VALUES ('1546738833263194113', '电商运营', 3, '1546727040302215169', 0, 2);
INSERT INTO `job_type` VALUES ('1546738871179702274', '业务运营', 4, '1546727040302215169', 0, 2);
INSERT INTO `job_type` VALUES ('1546738892906196993', '线下运营', 5, '1546727040302215169', 0, 2);
INSERT INTO `job_type` VALUES ('1546738923956629506', '编辑', 6, '1546727040302215169', 0, 2);
INSERT INTO `job_type` VALUES ('1546738969959755777', '高端运营岗位', 7, '1546727040302215169', 0, 2);
INSERT INTO `job_type` VALUES ('1546738993888260098', '其他运营岗位', 8, '1546727040302215169', 0, 2);
INSERT INTO `job_type` VALUES ('1546739146359599105', '客服专员', 1, '1546738781601951745', 1, 3);
INSERT INTO `job_type` VALUES ('1546739171395399681', '客服主管', 2, '1546738781601951745', 1, 3);
INSERT INTO `job_type` VALUES ('1546739196221485057', '客服经理', 3, '1546738781601951745', 1, 3);
INSERT INTO `job_type` VALUES ('1546739230891601922', '网络客服', 4, '1546738781601951745', 1, 3);
INSERT INTO `job_type` VALUES ('1546739296289189889', '电话客服', 5, '1546738781601951745', 1, 3);
INSERT INTO `job_type` VALUES ('1546739348902539266', '售前客服', 6, '1546738781601951745', 1, 3);
INSERT INTO `job_type` VALUES ('1546739368557047810', '售后客服', 7, '1546738781601951745', 1, 3);
INSERT INTO `job_type` VALUES ('1546739415373869057', '咨询热线/呼叫中心客服', 8, '1546738781601951745', 1, 3);
INSERT INTO `job_type` VALUES ('1546739466368217090', '新媒体运营', 1, '1546738807354978305', 1, 3);
INSERT INTO `job_type` VALUES ('1546739481312522242', '直播运营', 2, '1546738807354978305', 1, 3);
INSERT INTO `job_type` VALUES ('1546739504658018305', '视频运营', 3, '1546738807354978305', 1, 3);
INSERT INTO `job_type` VALUES ('1546739546252931074', '微信(公众号)运营', 3, '1546738807354978305', 1, 3);
INSERT INTO `job_type` VALUES ('1546739597557657601', '国内电商运营', 1, '1546738833263194113', 1, 3);
INSERT INTO `job_type` VALUES ('1546739635679686658', '跨境电商运营', 2, '1546738833263194113', 1, 3);
INSERT INTO `job_type` VALUES ('1546739685734510594', '淘宝/天猫运营', 3, '1546738833263194113', 1, 3);
INSERT INTO `job_type` VALUES ('1546739723831373826', '京东运营', 4, '1546738833263194113', 1, 3);
INSERT INTO `job_type` VALUES ('1546739750481981442', '亚马逊运营', 5, '1546738833263194113', 1, 3);
INSERT INTO `job_type` VALUES ('1546739780366397441', '拼多多运营', 6, '1546738833263194113', 1, 3);
INSERT INTO `job_type` VALUES ('1546739860389523458', '运营助理/专员', 1, '1546738871179702274', 1, 3);
INSERT INTO `job_type` VALUES ('1546739891028914177', '产品运营', 2, '1546738871179702274', 1, 3);
INSERT INTO `job_type` VALUES ('1546739920040914945', '社区运营', 3, '1546738871179702274', 1, 3);
INSERT INTO `job_type` VALUES ('1546739943168307201', '游戏运营', 4, '1546738871179702274', 1, 3);
INSERT INTO `job_type` VALUES ('1546739992220692482', '网站运营', 5, '1546738871179702274', 1, 3);
INSERT INTO `job_type` VALUES ('1546740044175536130', '车辆运营', 1, '1546738892906196993', 1, 3);
INSERT INTO `job_type` VALUES ('1546740078891790338', '线下拓展运营', 2, '1546738892906196993', 1, 3);
INSERT INTO `job_type` VALUES ('1546740118582489089', '文案编辑', 1, '1546738923956629506', 1, 3);
INSERT INTO `job_type` VALUES ('1546740144872386561', '网站编辑', 2, '1546738923956629506', 1, 3);
INSERT INTO `job_type` VALUES ('1546740174182182913', '医学编辑', 3, '1546738923956629506', 1, 3);
INSERT INTO `job_type` VALUES ('1546740199637413890', '采编', 4, '1546738923956629506', 1, 3);
INSERT INTO `job_type` VALUES ('1546740228137709569', '采编编辑', 5, '1546738923956629506', 1, 3);
INSERT INTO `job_type` VALUES ('1546740307011596289', '运营经理/主管', 1, '1546738969959755777', 1, 3);
INSERT INTO `job_type` VALUES ('1546740330474532865', '运营总监', 2, '1546738969959755777', 1, 3);
INSERT INTO `job_type` VALUES ('1546740352163278850', 'COO', 3, '1546738969959755777', 1, 3);
INSERT INTO `job_type` VALUES ('1546740377274576897', '客服总监', 4, '1546738969959755777', 1, 3);
INSERT INTO `job_type` VALUES ('1546740429829206018', '其他运营职位', 1, '1546738993888260098', 1, 3);
INSERT INTO `job_type` VALUES ('1546740794049982466', '销售类', 1, '1546727138113384449', 0, 2);
INSERT INTO `job_type` VALUES ('1546740826845245442', '销售管理', 2, '1546727138113384449', 0, 2);
INSERT INTO `job_type` VALUES ('1546740868373049345', '销售行政/商务', 3, '1546727138113384449', 0, 2);
INSERT INTO `job_type` VALUES ('1546740904595058690', '外贸销售', 4, '1546727138113384449', 0, 2);
INSERT INTO `job_type` VALUES ('1546740932197773314', '课程销售', 5, '1546727138113384449', 0, 2);
INSERT INTO `job_type` VALUES ('1546740963332091905', '汽车销售', 6, '1546727138113384449', 0, 2);
INSERT INTO `job_type` VALUES ('1546741017824489473', '房地产销售/招商', 7, '1546727138113384449', 0, 2);
INSERT INTO `job_type` VALUES ('1546741067279527937', '服务业销售', 8, '1546727138113384449', 0, 2);
INSERT INTO `job_type` VALUES ('1546741163073236994', '医疗销售', 10, '1546727138113384449', 0, 2);
INSERT INTO `job_type` VALUES ('1546741194404687874', '广告/会展销售', 11, '1546727138113384449', 0, 2);
INSERT INTO `job_type` VALUES ('1546741221235650562', '金融销售', 12, '1546727138113384449', 0, 2);
INSERT INTO `job_type` VALUES ('1546741382024294401', '销售专员', 1, '1546740794049982466', 1, 3);
INSERT INTO `job_type` VALUES ('1546741410126131201', '销售顾问', 2, '1546740794049982466', 1, 3);
INSERT INTO `job_type` VALUES ('1546741444708167681', '电话销售', 3, '1546740794049982466', 1, 3);
INSERT INTO `job_type` VALUES ('1546741496373604354', 'BD经理', 4, '1546740794049982466', 1, 3);
INSERT INTO `job_type` VALUES ('1546741522923548673', '客户经理', 5, '1546740794049982466', 1, 3);
INSERT INTO `job_type` VALUES ('1546741570965106689', '销售客户代表', 6, '1546740794049982466', 1, 3);
INSERT INTO `job_type` VALUES ('1546741620709552129', '销售经理', 1, '1546740826845245442', 1, 3);
INSERT INTO `job_type` VALUES ('1546741643669172225', '销售总监', 2, '1546740826845245442', 1, 3);
INSERT INTO `job_type` VALUES ('1546741666234527745', '销售VP', 3, '1546740826845245442', 1, 3);
INSERT INTO `job_type` VALUES ('1546741710803202050', '销售助理', 1, '1546740868373049345', 1, 3);
INSERT INTO `job_type` VALUES ('1546741731254628354', '销售运营', 2, '1546740868373049345', 1, 3);
INSERT INTO `job_type` VALUES ('1546741752653967362', '商务经理', 3, '1546740868373049345', 1, 3);
INSERT INTO `job_type` VALUES ('1546741776624414721', '商务总监', 4, '1546740868373049345', 1, 3);
INSERT INTO `job_type` VALUES ('1546741815178457089', '外贸业务员', 1, '1546740904595058690', 1, 3);
INSERT INTO `job_type` VALUES ('1546741847231328257', '课程顾问', 1, '1546740932197773314', 1, 3);
INSERT INTO `job_type` VALUES ('1546741871734452226', '招生顾问', 2, '1546740932197773314', 1, 3);
INSERT INTO `job_type` VALUES ('1546741908761767937', '留学顾问', 3, '1546740932197773314', 1, 3);
INSERT INTO `job_type` VALUES ('1546741951568834561', '汽车销售员', 1, '1546740963332091905', 1, 3);
INSERT INTO `job_type` VALUES ('1546741985320398849', '汽车配件销售', 2, '1546740963332091905', 1, 3);
INSERT INTO `job_type` VALUES ('1546742098050707458', '置业顾问', 1, '1546741017824489473', 1, 3);
INSERT INTO `job_type` VALUES ('1546742131802271745', '地产中介', 2, '1546741017824489473', 1, 3);
INSERT INTO `job_type` VALUES ('1546742192472879106', '服装导购', 1, '1546741067279527937', 1, 3);
INSERT INTO `job_type` VALUES ('1546742228787163137', '珠宝销售/导购', 2, '1546741067279527937', 1, 3);
INSERT INTO `job_type` VALUES ('1546742253873295362', '美容顾问', 3, '1546741067279527937', 1, 3);
INSERT INTO `job_type` VALUES ('1546742311893102594', '医药代表', 1, '1546741163073236994', 1, 3);
INSERT INTO `job_type` VALUES ('1546742338870865922', '医美咨询', 2, '1546741163073236994', 1, 3);
INSERT INTO `job_type` VALUES ('1546742380285423617', '健康顾问', 3, '1546741163073236994', 1, 3);
INSERT INTO `job_type` VALUES ('1546743380131999746', '广告销售', 1, '1546741194404687874', 1, 3);
INSERT INTO `job_type` VALUES ('1546743409739591681', '媒介顾问', 2, '1546741194404687874', 1, 3);
INSERT INTO `job_type` VALUES ('1546743438369910786', '会展活动销售', 3, '1546741194404687874', 1, 3);
INSERT INTO `job_type` VALUES ('1546743486734430209', '理财顾问', 1, '1546741221235650562', 1, 3);
INSERT INTO `job_type` VALUES ('1546743510390304769', '保险顾问', 2, '1546741221235650562', 1, 3);
INSERT INTO `job_type` VALUES ('1546743542078271490', '证券经纪人', 3, '1546741221235650562', 1, 3);
INSERT INTO `job_type` VALUES ('1546743622139146241', '行政', 1, '1546727732551118849', 0, 2);
INSERT INTO `job_type` VALUES ('1546743638765367298', '人力资源', 2, '1546727732551118849', 0, 2);
INSERT INTO `job_type` VALUES ('1546743657782341633', '法务', 3, '1546727732551118849', 0, 2);
INSERT INTO `job_type` VALUES ('1546743697930219522', '行政专员/助理', 1, '1546743622139146241', 1, 3);
INSERT INTO `job_type` VALUES ('1546743742255624194', '行政经理/主管', 2, '1546743622139146241', 1, 3);
INSERT INTO `job_type` VALUES ('1546743786581028866', '行政总监', 3, '1546743622139146241', 1, 3);
INSERT INTO `job_type` VALUES ('1546743818105417730', '前台', 4, '1546743622139146241', 1, 3);
INSERT INTO `job_type` VALUES ('1546743854142877698', '后勤', 5, '1546743622139146241', 1, 3);
INSERT INTO `job_type` VALUES ('1546743885541437442', '经理助理', 6, '1546743622139146241', 1, 3);
INSERT INTO `job_type` VALUES ('1546743960313294849', '人力资源专员/助理', 1, '1546743638765367298', 1, 3);
INSERT INTO `job_type` VALUES ('1546744005385285633', '人力资源经理/主管', 2, '1546743638765367298', 1, 3);
INSERT INTO `job_type` VALUES ('1546744030546915329', '人力资源总监', 3, '1546743638765367298', 1, 3);
INSERT INTO `job_type` VALUES ('1546744059651190785', 'CHO', 3, '1546743638765367298', 1, 3);
INSERT INTO `job_type` VALUES ('1546744091515318273', '招聘专员', 4, '1546743638765367298', 1, 3);
INSERT INTO `job_type` VALUES ('1546744125484986369', '培训专员', 5, '1546743638765367298', 1, 3);
INSERT INTO `job_type` VALUES ('1546744177318195201', '法务专员', 1, '1546743657782341633', 1, 3);
INSERT INTO `job_type` VALUES ('1546744194703585281', '法务经理', 2, '1546743657782341633', 1, 3);
INSERT INTO `job_type` VALUES ('1546744244108292098', '法律顾问', 4, '1546743657782341633', 1, 3);
INSERT INTO `job_type` VALUES ('1546744277176184834', '律师', 5, '1546743657782341633', 1, 3);
INSERT INTO `job_type` VALUES ('1546744481304571905', '会计', 1, '1546727788402470913', 0, 2);
INSERT INTO `job_type` VALUES ('1546744517891485698', '审计/税务', 2, '1546727788402470913', 0, 2);
INSERT INTO `job_type` VALUES ('1546744557728985089', '高级财务职位', 3, '1546727788402470913', 0, 2);
INSERT INTO `job_type` VALUES ('1546744615467773954', '会计专员', 1, '1546744481304571905', 1, 3);
INSERT INTO `job_type` VALUES ('1546744652591558657', '总账会计', 2, '1546744481304571905', 1, 3);
INSERT INTO `job_type` VALUES ('1546744669012258818', '成本会计', 3, '1546744481304571905', 1, 3);
INSERT INTO `job_type` VALUES ('1546744690042499074', '结算会计', 4, '1546744481304571905', 1, 3);
INSERT INTO `job_type` VALUES ('1546744731645800449', '审计', 1, '1546744517891485698', 1, 3);
INSERT INTO `job_type` VALUES ('1546744746183258114', '税务', 2, '1546744517891485698', 1, 3);
INSERT INTO `job_type` VALUES ('1546744789028073473', '财务主管', 1, '1546744557728985089', 1, 3);
INSERT INTO `job_type` VALUES ('1546744814139371521', '财务总监', 2, '1546744557728985089', 1, 3);
INSERT INTO `job_type` VALUES ('1546744833806462978', 'CFO', 3, '1546744557728985089', 1, 3);
INSERT INTO `job_type` VALUES ('1546747250337935361', '技工/普工', 1, '1546727835013771266', 0, 2);
INSERT INTO `job_type` VALUES ('1546747275466010625', '质量安全', 2, '1546727835013771266', 0, 2);
INSERT INTO `job_type` VALUES ('1546747302426996738', '生产运营', 3, '1546727835013771266', 0, 2);
INSERT INTO `job_type` VALUES ('1546747334362427393', '化工', 4, '1546727835013771266', 0, 2);
INSERT INTO `job_type` VALUES ('1546747382332682242', '服装/纺织/皮革', 5, '1546727835013771266', 0, 2);
INSERT INTO `job_type` VALUES ('1546747418818932737', '新能源', 6, '1546727835013771266', 0, 2);
INSERT INTO `job_type` VALUES ('1546747450125217793', '汽车制造', 7, '1546727835013771266', 0, 2);
INSERT INTO `job_type` VALUES ('1546747479812501506', '环保', 8, '1546727835013771266', 0, 2);
INSERT INTO `job_type` VALUES ('1546747555028955137', '操作工/技工/普工', 1, '1546747250337935361', 1, 3);
INSERT INTO `job_type` VALUES ('1546747575564267522', '包装工', 2, '1546747250337935361', 1, 3);
INSERT INTO `job_type` VALUES ('1546747595332022273', '组装工', 3, '1546747250337935361', 1, 3);
INSERT INTO `job_type` VALUES ('1546747622834073602', '电工', 4, '1546747250337935361', 1, 3);
INSERT INTO `job_type` VALUES ('1546747648603877377', '木工', 5, '1546747250337935361', 1, 3);
INSERT INTO `job_type` VALUES ('1546747676475027458', '焊工', 6, '1546747250337935361', 1, 3);
INSERT INTO `job_type` VALUES ('1546747725556772866', '钳工', 7, '1546747250337935361', 1, 3);
INSERT INTO `job_type` VALUES ('1546747755474743298', '车工', 8, '1546747250337935361', 1, 3);
INSERT INTO `job_type` VALUES ('1546747837041373186', '磨工', 9, '1546747250337935361', 1, 3);
INSERT INTO `job_type` VALUES ('1546747882637651970', '磨具工', 10, '1546747250337935361', 1, 3);
INSERT INTO `job_type` VALUES ('1546747927147606017', '切割工', 11, '1546747250337935361', 1, 3);
INSERT INTO `job_type` VALUES ('1546747960165167105', '注塑工', 12, '1546747250337935361', 1, 3);
INSERT INTO `job_type` VALUES ('1546747990011834370', '抛光工', 13, '1546747250337935361', 1, 3);
INSERT INTO `job_type` VALUES ('1546748027907371010', '叉车工', 14, '1546747250337935361', 1, 3);
INSERT INTO `job_type` VALUES ('1546748057502380034', '机修工', 15, '1546747250337935361', 1, 3);
INSERT INTO `job_type` VALUES ('1546748101576126465', '油漆工', 16, '1546747250337935361', 1, 3);
INSERT INTO `job_type` VALUES ('1546748139748487170', '缝纫工', 17, '1546747250337935361', 1, 3);
INSERT INTO `job_type` VALUES ('1546748275006402562', '质检员', 1, '1546747275466010625', 1, 3);
INSERT INTO `job_type` VALUES ('1546748416283144194', '质量管理/测试', 2, '1546747275466010625', 1, 3);
INSERT INTO `job_type` VALUES ('1546748450089234434', '体系工程师', 3, '1546747275466010625', 1, 3);
INSERT INTO `job_type` VALUES ('1546748476710481922', '认证工程师', 4, '1546747275466010625', 1, 3);
INSERT INTO `job_type` VALUES ('1546748506662006786', '故障分析师', 5, '1546747275466010625', 1, 3);
INSERT INTO `job_type` VALUES ('1546749095504539650', '生产计划管理', 1, '1546747302426996738', 1, 3);
INSERT INTO `job_type` VALUES ('1546749120271904769', '生产员', 2, '1546747302426996738', 1, 3);
INSERT INTO `job_type` VALUES ('1546749152404467714', '生产组长', 3, '1546747302426996738', 1, 3);
INSERT INTO `job_type` VALUES ('1546749178358820865', '厂长', 4, '1546747302426996738', 1, 3);
INSERT INTO `job_type` VALUES ('1546749215839121409', '车间主任', 5, '1546747302426996738', 1, 3);
INSERT INTO `job_type` VALUES ('1546749274966224898', '生产营运', 6, '1546747302426996738', 1, 3);
INSERT INTO `job_type` VALUES ('1546749346428776449', '化工工程师', 1, '1546747334362427393', 1, 3);
INSERT INTO `job_type` VALUES ('1546749373482037249', '实验室技术员', 2, '1546747334362427393', 1, 3);
INSERT INTO `job_type` VALUES ('1546749400392691714', '化学分析', 3, '1546747334362427393', 1, 3);
INSERT INTO `job_type` VALUES ('1546749447737995265', '食品饮料研发', 4, '1546747334362427393', 1, 3);
INSERT INTO `job_type` VALUES ('1546749469892308994', '化妆品研发', 5, '1546747334362427393', 1, 3);
INSERT INTO `job_type` VALUES ('1546749524510535682', '涂料研发', 6, '1546747334362427393', 1, 3);
INSERT INTO `job_type` VALUES ('1546749563085549570', '化工项目经理', 7, '1546747334362427393', 1, 3);
INSERT INTO `job_type` VALUES ('1546749622418173953', '服装/纺织/皮革跟单', 1, '1546747382332682242', 1, 3);
INSERT INTO `job_type` VALUES ('1546749662398279681', '打样/制版', 2, '1546747382332682242', 1, 3);
INSERT INTO `job_type` VALUES ('1546749705603805186', '服装纺织设计', 3, '1546747382332682242', 1, 3);
INSERT INTO `job_type` VALUES ('1546749755163701249', '面料辅料开发', 4, '1546747382332682242', 1, 3);
INSERT INTO `job_type` VALUES ('1546749798818017282', '电池工程师', 1, '1546747418818932737', 1, 3);
INSERT INTO `job_type` VALUES ('1546749827356061698', '电机工程师', 2, '1546747418818932737', 1, 3);
INSERT INTO `job_type` VALUES ('1546749887582072834', '充电桩设计开发', 3, '1546747418818932737', 1, 3);
INSERT INTO `job_type` VALUES ('1546749936579932161', '汽车设计', 1, '1546747450125217793', 1, 3);
INSERT INTO `job_type` VALUES ('1546749969823985666', '汽车电子工程师', 2, '1546747450125217793', 1, 3);
INSERT INTO `job_type` VALUES ('1546750005576232962', '汽车零部件设计', 3, '1546747450125217793', 1, 3);
INSERT INTO `job_type` VALUES ('1546750058852282370', '内外饰设计', 4, '1546747450125217793', 1, 3);
INSERT INTO `job_type` VALUES ('1546750104998014978', '动力系统工程师', 5, '1546747450125217793', 1, 3);
INSERT INTO `job_type` VALUES ('1546750131430518785', '底盘工程师', 6, '1546747450125217793', 1, 3);
INSERT INTO `job_type` VALUES ('1546750174933839873', '车身/造型设计', 7, '1546747450125217793', 1, 3);
INSERT INTO `job_type` VALUES ('1546750242017538049', '总装工程师', 8, '1546747450125217793', 1, 3);
INSERT INTO `job_type` VALUES ('1546750275999789058', '汽车项目经理', 9, '1546747450125217793', 1, 3);
INSERT INTO `job_type` VALUES ('1546750339241504770', 'EHS工程师', 1, '1546747479812501506', 1, 3);
INSERT INTO `job_type` VALUES ('1546750379229999105', '环境检测员', 2, '1546747479812501506', 1, 3);
INSERT INTO `job_type` VALUES ('1546750410183962626', '环评工程师', 3, '1546747479812501506', 1, 3);
INSERT INTO `job_type` VALUES ('1546750442983419905', '环保工程师', 4, '1546747479812501506', 1, 3);
INSERT INTO `job_type` VALUES ('1546750482485374977', '碳排放管理师', 5, '1546747479812501506', 1, 3);
INSERT INTO `job_type` VALUES ('1546769322648825857', '零售', 1, '1546727893234905089', 0, 2);
INSERT INTO `job_type` VALUES ('1546769349433651202', '美容美发', 2, '1546727893234905089', 0, 2);
INSERT INTO `job_type` VALUES ('1546769381541048322', '理疗保健', 3, '1546727893234905089', 0, 2);
INSERT INTO `job_type` VALUES ('1546769406325190657', '安保服务', 4, '1546727893234905089', 0, 2);
INSERT INTO `job_type` VALUES ('1546769451187466241', '家政保洁/维修', 5, '1546727893234905089', 0, 2);
INSERT INTO `job_type` VALUES ('1546769481004773378', '宠物服务', 6, '1546727893234905089', 0, 2);
INSERT INTO `job_type` VALUES ('1546769510322958337', '运动健身', 7, '1546727893234905089', 0, 2);
INSERT INTO `job_type` VALUES ('1546769594473279490', '店员/营业员', 1, '1546769322648825857', 1, 3);
INSERT INTO `job_type` VALUES ('1546769634335944705', '收银', 2, '1546769322648825857', 1, 3);
INSERT INTO `job_type` VALUES ('1546769647724163074', '导购', 3, '1546769322648825857', 1, 3);
INSERT INTO `job_type` VALUES ('1546769689419739138', '促销员', 4, '1546769322648825857', 1, 3);
INSERT INTO `job_type` VALUES ('1546769725746606082', '门店店长', 5, '1546769322648825857', 1, 3);
INSERT INTO `job_type` VALUES ('1546769763461787650', '卖场经理', 6, '1546769322648825857', 1, 3);
INSERT INTO `job_type` VALUES ('1546769802414288898', '美容师', 1, '1546769349433651202', 1, 3);
INSERT INTO `job_type` VALUES ('1546769825684287490', '美甲师', 2, '1546769349433651202', 1, 3);
INSERT INTO `job_type` VALUES ('1546769854792757250', '美睫师', 3, '1546769349433651202', 1, 3);
INSERT INTO `job_type` VALUES ('1546769882760376322', '发型师', 4, '1546769349433651202', 1, 3);
INSERT INTO `job_type` VALUES ('1546769911986286593', '化妆师', 5, '1546769349433651202', 1, 3);
INSERT INTO `job_type` VALUES ('1546769964834516994', '理疗师', 1, '1546769381541048322', 1, 3);
INSERT INTO `job_type` VALUES ('1546769993045405697', '针灸推拿', 2, '1546769381541048322', 1, 3);
INSERT INTO `job_type` VALUES ('1546770034699038722', '按摩师', 3, '1546769381541048322', 1, 3);
INSERT INTO `job_type` VALUES ('1546770050884857858', '足疗师', 4, '1546769381541048322', 1, 3);
INSERT INTO `job_type` VALUES ('1546770085022298114', '保安', 1, '1546769406325190657', 1, 3);
INSERT INTO `job_type` VALUES ('1546770099035467778', '保安经理', 2, '1546769406325190657', 1, 3);
INSERT INTO `job_type` VALUES ('1546770132686368769', '消防中控员', 3, '1546769406325190657', 1, 3);
INSERT INTO `job_type` VALUES ('1546770166781865986', '地铁安检', 4, '1546769406325190657', 1, 3);
INSERT INTO `job_type` VALUES ('1546770188151844865', '押运员', 5, '1546769406325190657', 1, 3);
INSERT INTO `job_type` VALUES ('1546770224860393473', '保洁', 1, '1546769451187466241', 1, 3);
INSERT INTO `job_type` VALUES ('1546770251246759938', '产后康复师', 2, '1546769451187466241', 1, 3);
INSERT INTO `job_type` VALUES ('1546770273745006594', '育婴师', 3, '1546769451187466241', 1, 3);
INSERT INTO `job_type` VALUES ('1546770311963504641', '保姆/护工', 4, '1546769451187466241', 1, 3);
INSERT INTO `job_type` VALUES ('1546770337443901441', '月嫂', 5, '1546769451187466241', 1, 3);
INSERT INTO `job_type` VALUES ('1546770362915909633', '家电维修', 6, '1546769451187466241', 1, 3);
INSERT INTO `job_type` VALUES ('1546770380351631362', '手机维修', 7, '1546769451187466241', 1, 3);
INSERT INTO `job_type` VALUES ('1546770434047111169', '宠物美容', 1, '1546769481004773378', 1, 3);
INSERT INTO `job_type` VALUES ('1546770449557647361', '宠物医生', 2, '1546769481004773378', 1, 3);
INSERT INTO `job_type` VALUES ('1546770494323453953', '健身教练', 1, '1546769510322958337', 1, 3);
INSERT INTO `job_type` VALUES ('1546770530209918978', '舞蹈老师', 2, '1546769510322958337', 1, 3);
INSERT INTO `job_type` VALUES ('1546770554885009410', '瑜伽老师', 3, '1546769510322958337', 1, 3);
INSERT INTO `job_type` VALUES ('1546770576238211073', '救生员', 4, '1546769510322958337', 1, 3);
INSERT INTO `job_type` VALUES ('1546770608391745537', '游泳教练', 5, '1546769510322958337', 1, 3);
INSERT INTO `job_type` VALUES ('1546770709390585858', '前厅', 1, '1546728889956724738', 0, 2);
INSERT INTO `job_type` VALUES ('1546770727388344321', '后厨', 2, '1546728889956724738', 0, 2);
INSERT INTO `job_type` VALUES ('1546770753841819650', '餐饮管理', 3, '1546728889956724738', 0, 2);
INSERT INTO `job_type` VALUES ('1546770790558756865', '甜点饮品', 4, '1546728889956724738', 0, 2);
INSERT INTO `job_type` VALUES ('1546770841704099841', '服务员', 1, '1546770709390585858', 1, 3);
INSERT INTO `job_type` VALUES ('1546770860771405826', '收银员', 2, '1546770709390585858', 1, 3);
INSERT INTO `job_type` VALUES ('1546770982188118018', '礼仪/迎宾/接待', 3, '1546770709390585858', 1, 3);
INSERT INTO `job_type` VALUES ('1546771043525619713', '厨师', 1, '1546770727388344321', 1, 3);
INSERT INTO `job_type` VALUES ('1546771173251248130', '面点师', 2, '1546770727388344321', 1, 3);
INSERT INTO `job_type` VALUES ('1546771196970037250', '洗碗工', 3, '1546770727388344321', 1, 3);
INSERT INTO `job_type` VALUES ('1546771264510914562', '餐饮店长', 1, '1546770753841819650', 1, 3);
INSERT INTO `job_type` VALUES ('1546771294688931841', '领班', 2, '1546770753841819650', 1, 3);
INSERT INTO `job_type` VALUES ('1546771327433863170', '储备店长', 3, '1546770753841819650', 1, 3);
INSERT INTO `job_type` VALUES ('1546771348510240769', '厨师长', 4, '1546770753841819650', 1, 3);
INSERT INTO `job_type` VALUES ('1546771390503612417', '行政总厨', 5, '1546770753841819650', 1, 3);
INSERT INTO `job_type` VALUES ('1546771435491717121', '咖啡师', 1, '1546770790558756865', 1, 3);
INSERT INTO `job_type` VALUES ('1546771454210895874', '西点师', 2, '1546770790558756865', 1, 3);
INSERT INTO `job_type` VALUES ('1546771472665833473', '烘焙师', 3, '1546770790558756865', 1, 3);
INSERT INTO `job_type` VALUES ('1546771492148375554', '茶艺师', 4, '1546770790558756865', 1, 3);
INSERT INTO `job_type` VALUES ('1546771530547228673', '奶茶店员', 5, '1546770790558756865', 1, 3);
INSERT INTO `job_type` VALUES ('1546771553364242433', '调酒师', 6, '1546770790558756865', 1, 3);
INSERT INTO `job_type` VALUES ('1546771612503928834', '酒店', 1, '1546728963302518786', 0, 2);
INSERT INTO `job_type` VALUES ('1546771667231207425', '旅游服务', 2, '1546728963302518786', 0, 2);
INSERT INTO `job_type` VALUES ('1546771708675125250', '旅游产品开发/策划', 3, '1546728963302518786', 0, 2);
INSERT INTO `job_type` VALUES ('1546772104617422850', '大堂收银', 1, '1546771612503928834', 1, 3);
INSERT INTO `job_type` VALUES ('1546772134883520513', '酒店前台', 2, '1546771612503928834', 1, 3);
INSERT INTO `job_type` VALUES ('1546772600463847425', '礼仪/迎宾/接待', 3, '1546771612503928834', 1, 3);
INSERT INTO `job_type` VALUES ('1546772680486973441', '酒店经理', 4, '1546771612503928834', 1, 3);
INSERT INTO `job_type` VALUES ('1546772725181476866', '旅游顾问', 1, '1546771667231207425', 1, 3);
INSERT INTO `job_type` VALUES ('1546772769490104321', '导游', 2, '1546771667231207425', 1, 3);
INSERT INTO `job_type` VALUES ('1546772859021717506', '讲解员', 3, '1546771667231207425', 1, 3);
INSERT INTO `job_type` VALUES ('1546773083236626434', '旅游产品开发/策划员', 1, '1546771708675125250', 1, 3);
INSERT INTO `job_type` VALUES ('1546773111451709442', '旅游产品经理', 2, '1546771708675125250', 1, 3);
INSERT INTO `job_type` VALUES ('1546773136483315714', '旅游策划师', 3, '1546771708675125250', 1, 3);
INSERT INTO `job_type` VALUES ('1546773196759658497', '教师', 1, '1546729029299892226', 0, 2);
INSERT INTO `job_type` VALUES ('1546773224135880706', '教育行政', 2, '1546729029299892226', 0, 2);
INSERT INTO `job_type` VALUES ('1546773246088867842', '培训', 3, '1546729029299892226', 0, 2);
INSERT INTO `job_type` VALUES ('1546773267228160001', 'IT培训', 4, '1546729029299892226', 0, 2);
INSERT INTO `job_type` VALUES ('1546773301801807873', '教育产品研发', 5, '1546729029299892226', 0, 2);
INSERT INTO `job_type` VALUES ('1546773547764183041', '教师/老师', 1, '1546773196759658497', 1, 3);
INSERT INTO `job_type` VALUES ('1546773570107240449', '助教', 2, '1546773196759658497', 1, 3);
INSERT INTO `job_type` VALUES ('1546773585106071553', '家教', 3, '1546773196759658497', 1, 3);
INSERT INTO `job_type` VALUES ('1546773627703422977', '幼教', 4, '1546773196759658497', 1, 3);
INSERT INTO `job_type` VALUES ('1546773649912262658', '早教', 5, '1546773196759658497', 1, 3);
INSERT INTO `job_type` VALUES ('1546773683508637697', '小学老师', 6, '1546773196759658497', 1, 3);
INSERT INTO `job_type` VALUES ('1546773706631835649', '初中老师', 7, '1546773196759658497', 1, 3);
INSERT INTO `job_type` VALUES ('1546773738261082114', '高中老师', 8, '1546773196759658497', 1, 3);
INSERT INTO `job_type` VALUES ('1546773762462216193', '就业老师', 9, '1546773196759658497', 1, 3);
INSERT INTO `job_type` VALUES ('1546773798982021122', '理科老师', 10, '1546773196759658497', 1, 3);
INSERT INTO `job_type` VALUES ('1546773820578492418', '文科老师', 11, '1546773196759658497', 1, 3);
INSERT INTO `job_type` VALUES ('1546773889490907137', '教务管理', 1, '1546773224135880706', 1, 3);
INSERT INTO `job_type` VALUES ('1546773924349767681', '班主任/辅导员', 2, '1546773224135880706', 1, 3);
INSERT INTO `job_type` VALUES ('1546773957296025601', '校长/副校长', 3, '1546773224135880706', 1, 3);
INSERT INTO `job_type` VALUES ('1546774010639183873', '园长/副园长', 4, '1546773224135880706', 1, 3);
INSERT INTO `job_type` VALUES ('1546774036375433217', '教学管理', 5, '1546773224135880706', 1, 3);
INSERT INTO `job_type` VALUES ('1546774169624276993', '篮球/羽毛球老师', 1, '1546773246088867842', 1, 3);
INSERT INTO `job_type` VALUES ('1546774254122725377', '游泳老师', 2, '1546773246088867842', 1, 3);
INSERT INTO `job_type` VALUES ('1546774294375460866', '健身老师', 3, '1546773246088867842', 1, 3);
INSERT INTO `job_type` VALUES ('1546774320522752002', '武术老师', 4, '1546773246088867842', 1, 3);
INSERT INTO `job_type` VALUES ('1546774349371174913', '书法老师', 5, '1546773246088867842', 1, 3);
INSERT INTO `job_type` VALUES ('1546774376957112322', '播音老师', 6, '1546773246088867842', 1, 3);
INSERT INTO `job_type` VALUES ('1546774401305047042', '乐高老师', 7, '1546773246088867842', 1, 3);
INSERT INTO `job_type` VALUES ('1546774487816761346', 'Java讲师', 1, '1546773267228160001', 1, 3);
INSERT INTO `job_type` VALUES ('1546774513276186626', 'C语言讲师', 2, '1546773267228160001', 1, 3);
INSERT INTO `job_type` VALUES ('1546774544678940673', '前端web讲师', 3, '1546773267228160001', 1, 3);
INSERT INTO `job_type` VALUES ('1546774573879685122', '设计讲师', 4, '1546773267228160001', 1, 3);
INSERT INTO `job_type` VALUES ('1546774597237764098', '测试讲师', 5, '1546773267228160001', 1, 3);
INSERT INTO `job_type` VALUES ('1546774621350817793', '动漫讲师', 5, '1546773267228160001', 1, 3);
INSERT INTO `job_type` VALUES ('1546774645161881602', '安卓讲师', 6, '1546773267228160001', 1, 3);
INSERT INTO `job_type` VALUES ('1546774669761474562', 'ios讲师', 7, '1546773267228160001', 1, 3);
INSERT INTO `job_type` VALUES ('1546774727424765953', '培训师', 1, '1546773301801807873', 1, 3);
INSERT INTO `job_type` VALUES ('1546774747549036545', '课程设计', 2, '1546773301801807873', 1, 3);
INSERT INTO `job_type` VALUES ('1546774768067571713', '教学经理', 3, '1546773301801807873', 1, 3);
INSERT INTO `job_type` VALUES ('1546774804306358273', '教学课程策划', 4, '1546773301801807873', 1, 3);
INSERT INTO `job_type` VALUES ('1546774924628357122', '视觉/交互设计', 1, '1546729087458111489', 0, 2);
INSERT INTO `job_type` VALUES ('1546774960141529089', '工业/家居设计', 2, '1546729087458111489', 0, 2);
INSERT INTO `job_type` VALUES ('1546774986515312642', '服装设计', 3, '1546729087458111489', 0, 2);
INSERT INTO `job_type` VALUES ('1546775031763464193', '美术/3D/动画', 4, '1546729087458111489', 0, 2);
INSERT INTO `job_type` VALUES ('1546775072825700354', '游戏设计', 5, '1546729087458111489', 0, 2);
INSERT INTO `job_type` VALUES ('1546775114118623233', '展示/照明设计', 6, '1546729087458111489', 0, 2);
INSERT INTO `job_type` VALUES ('1546775190287183874', '高端设计岗位', 7, '1546729087458111489', 0, 2);
INSERT INTO `job_type` VALUES ('1546775225649360898', '平面设计', 1, '1546774924628357122', 1, 3);
INSERT INTO `job_type` VALUES ('1546775246243393538', '美工', 2, '1546774924628357122', 1, 3);
INSERT INTO `job_type` VALUES ('1546775277457403906', 'UI设计师', 3, '1546774924628357122', 1, 3);
INSERT INTO `job_type` VALUES ('1546775318729355265', '广告/包装设计', 4, '1546774924628357122', 1, 3);
INSERT INTO `job_type` VALUES ('1546775958775951361', '网页设计', 5, '1546774924628357122', 1, 3);
INSERT INTO `job_type` VALUES ('1546776071791472642', 'APP设计', 6, '1546774924628357122', 1, 3);
INSERT INTO `job_type` VALUES ('1546776110685253633', '室内设计', 1, '1546774960141529089', 1, 3);
INSERT INTO `job_type` VALUES ('1546776132596297729', '家具设计', 2, '1546774960141529089', 1, 3);
INSERT INTO `job_type` VALUES ('1546776162547822594', '家居设计', 3, '1546774960141529089', 1, 3);
INSERT INTO `job_type` VALUES ('1546776184752467970', '珠宝设计', 4, '1546774960141529089', 1, 3);
INSERT INTO `job_type` VALUES ('1546776259109089282', '服装/纺织设计', 1, '1546774986515312642', 1, 3);
INSERT INTO `job_type` VALUES ('1546776321935568898', '面料辅料设计开发', 2, '1546774986515312642', 1, 3);
INSERT INTO `job_type` VALUES ('1546776385076621314', '3D设计师', 1, '1546775031763464193', 1, 3);
INSERT INTO `job_type` VALUES ('1546776476709580801', '插画师', 2, '1546775031763464193', 1, 3);
INSERT INTO `job_type` VALUES ('1546776501275619330', '动画设计', 3, '1546775031763464193', 1, 3);
INSERT INTO `job_type` VALUES ('1546776605021728769', '游戏场景', 1, '1546775072825700354', 1, 3);
INSERT INTO `job_type` VALUES ('1546776625464766466', '游戏角色', 2, '1546775072825700354', 1, 3);
INSERT INTO `job_type` VALUES ('1546776648088842241', '游戏界面设计', 3, '1546775072825700354', 1, 3);
INSERT INTO `job_type` VALUES ('1546776695899713538', '游戏特效', 4, '1546775072825700354', 1, 3);
INSERT INTO `job_type` VALUES ('1546776730725019650', '游戏动作设计', 5, '1546775072825700354', 1, 3);
INSERT INTO `job_type` VALUES ('1546776790087004161', '陈列设计', 1, '1546775114118623233', 1, 3);
INSERT INTO `job_type` VALUES ('1546776811545063426', '展览设计', 2, '1546775114118623233', 1, 3);
INSERT INTO `job_type` VALUES ('1546776861708939266', '设计主管', 1, '1546775190287183874', 1, 3);
INSERT INTO `job_type` VALUES ('1546776932051611649', '设计总监', 2, '1546775190287183874', 1, 3);
INSERT INTO `job_type` VALUES ('1546777035076300801', '建筑工人', 1, '1546729124095356929', 0, 2);
INSERT INTO `job_type` VALUES ('1546777069150826498', '工程管理', 2, '1546729124095356929', 0, 2);
INSERT INTO `job_type` VALUES ('1546777104097767425', '工程开发技术专员', 3, '1546729124095356929', 0, 2);
INSERT INTO `job_type` VALUES ('1546777153728966658', '物业管理', 4, '1546729124095356929', 0, 2);
INSERT INTO `job_type` VALUES ('1546777208670154753', '高端房地产岗位', 5, '1546729124095356929', 0, 2);
INSERT INTO `job_type` VALUES ('1546777263288381442', '电工/焊工/木工', 1, '1546777035076300801', 1, 3);
INSERT INTO `job_type` VALUES ('1546777291482492930', '空调工', 2, '1546777035076300801', 1, 3);
INSERT INTO `job_type` VALUES ('1546777313271902210', '电梯工', 3, '1546777035076300801', 1, 3);
INSERT INTO `job_type` VALUES ('1546777370796781570', '施工现场管理', 1, '1546777069150826498', 1, 3);
INSERT INTO `job_type` VALUES ('1546777391680221186', '资料员', 2, '1546777069150826498', 1, 3);
INSERT INTO `job_type` VALUES ('1546777417450024962', '工程造价', 3, '1546777069150826498', 1, 3);
INSERT INTO `job_type` VALUES ('1546777448114581505', '工程监理', 4, '1546777069150826498', 1, 3);
INSERT INTO `job_type` VALUES ('1546777469258067969', '工程预算', 5, '1546777069150826498', 1, 3);
INSERT INTO `job_type` VALUES ('1546777492318351362', '施工员', 6, '1546777069150826498', 1, 3);
INSERT INTO `job_type` VALUES ('1546777563566993409', '测绘', 1, '1546777104097767425', 1, 3);
INSERT INTO `job_type` VALUES ('1546777593149419521', '弱电工程师', 2, '1546777104097767425', 1, 3);
INSERT INTO `job_type` VALUES ('1546777623335825409', '暖通工程师', 3, '1546777104097767425', 1, 3);
INSERT INTO `job_type` VALUES ('1546777645636939777', '消防工程师', 4, '1546777104097767425', 1, 3);
INSERT INTO `job_type` VALUES ('1546777663945076737', '施工工程师', 4, '1546777104097767425', 1, 3);
INSERT INTO `job_type` VALUES ('1546777720471711746', '物业经理', 1, '1546777153728966658', 1, 3);
INSERT INTO `job_type` VALUES ('1546777745142607874', '物业维修', 2, '1546777153728966658', 1, 3);
INSERT INTO `job_type` VALUES ('1546777801283366914', '地产项目总监', 1, '1546777208670154753', 1, 3);
INSERT INTO `job_type` VALUES ('1546777823072776193', '地产策划总监', 2, '1546777208670154753', 1, 3);
INSERT INTO `job_type` VALUES ('1546777849849212929', '地产招标总监', 3, '1546777208670154753', 1, 3);
INSERT INTO `job_type` VALUES ('1546777941549281282', '影视/传媒', 1, '1546729166420078593', 0, 2);
INSERT INTO `job_type` VALUES ('1546777963955253249', '广告', 2, '1546729166420078593', 0, 2);
INSERT INTO `job_type` VALUES ('1546777990907850754', '公关媒介', 3, '1546729166420078593', 0, 2);
INSERT INTO `job_type` VALUES ('1546778040711016449', '采编/写作/出版', 4, '1546729166420078593', 0, 2);
INSERT INTO `job_type` VALUES ('1546778091705364482', '主播', 1, '1546777941549281282', 1, 3);
INSERT INTO `job_type` VALUES ('1546778125737947137', '摄影/摄像', 2, '1546777941549281282', 1, 3);
INSERT INTO `job_type` VALUES ('1546778147921620994', '剪辑师', 3, '1546777941549281282', 1, 3);
INSERT INTO `job_type` VALUES ('1546778168150749185', '后期制作', 4, '1546777941549281282', 1, 3);
INSERT INTO `job_type` VALUES ('1546778199004049409', '导演编导', 5, '1546777941549281282', 1, 3);
INSERT INTO `job_type` VALUES ('1546778219644219393', '经纪人', 6, '1546777941549281282', 1, 3);
INSERT INTO `job_type` VALUES ('1546778261947969538', '演员/模特', 7, '1546777941549281282', 1, 3);
INSERT INTO `job_type` VALUES ('1546778297591164930', '主持人', 8, '1546777941549281282', 1, 3);
INSERT INTO `job_type` VALUES ('1546778346068930561', '广告制作', 1, '1546777963955253249', 1, 3);
INSERT INTO `job_type` VALUES ('1546778366352584705', '广告文案', 2, '1546777963955253249', 1, 3);
INSERT INTO `job_type` VALUES ('1546778393791721474', '广告创意设计', 3, '1546777963955253249', 1, 3);
INSERT INTO `job_type` VALUES ('1546778422577229826', '策划经理', 4, '1546777963955253249', 1, 3);
INSERT INTO `job_type` VALUES ('1546778456270073857', '美术指导', 5, '1546777963955253249', 1, 3);
INSERT INTO `job_type` VALUES ('1546778522397470722', '媒介专员', 1, '1546777990907850754', 1, 3);
INSERT INTO `job_type` VALUES ('1546778604706492417', '活动策划', 2, '1546777990907850754', 1, 3);
INSERT INTO `job_type` VALUES ('1546778647626805250', '品牌公关', 3, '1546777990907850754', 1, 3);
INSERT INTO `job_type` VALUES ('1546778680996687874', '公关', 4, '1546777990907850754', 1, 3);
INSERT INTO `job_type` VALUES ('1546778775058149377', '主编', 1, '1546778040711016449', 1, 3);
INSERT INTO `job_type` VALUES ('1546778800945393665', '记者', 2, '1546778040711016449', 1, 3);
INSERT INTO `job_type` VALUES ('1546778835145748482', '撰稿人', 3, '1546778040711016449', 1, 3);
INSERT INTO `job_type` VALUES ('1546778861561475073', '出版发行', 4, '1546778040711016449', 1, 3);
INSERT INTO `job_type` VALUES ('1546778948324847617', '市场/营销', 1, '1546729251728027649', 0, 2);
INSERT INTO `job_type` VALUES ('1546779085604417537', '政府事务', 2, '1546729251728027649', 0, 2);
INSERT INTO `job_type` VALUES ('1546779121591545857', '会务会展', 3, '1546729251728027649', 0, 2);
INSERT INTO `job_type` VALUES ('1546779211462897666', '市场营销', 1, '1546778948324847617', 1, 3);
INSERT INTO `job_type` VALUES ('1546779234556735489', '市场推广', 2, '1546778948324847617', 1, 3);
INSERT INTO `job_type` VALUES ('1546779255163351042', '网络推广', 3, '1546778948324847617', 1, 3);
INSERT INTO `job_type` VALUES ('1546779292962418690', 'SEO', 4, '1546778948324847617', 1, 3);
INSERT INTO `job_type` VALUES ('1546779355860201473', '政府关系', 1, '1546779085604417537', 1, 3);
INSERT INTO `job_type` VALUES ('1546779380749201410', '政策研究', 2, '1546779085604417537', 1, 3);
INSERT INTO `job_type` VALUES ('1546779599847059457', '会务活动策划', 1, '1546779121591545857', 1, 3);
INSERT INTO `job_type` VALUES ('1546779623897198594', '会务活动执行', 2, '1546779121591545857', 1, 3);
INSERT INTO `job_type` VALUES ('1546779691731677185', '交通/运输', 1, '1546729300927213570', 0, 2);
INSERT INTO `job_type` VALUES ('1546779710501187586', '仓储', 2, '1546729300927213570', 0, 2);
INSERT INTO `job_type` VALUES ('1546779730117947393', '物流', 3, '1546729300927213570', 0, 2);
INSERT INTO `job_type` VALUES ('1546779874875961345', '货运司机', 1, '1546779691731677185', 1, 3);
INSERT INTO `job_type` VALUES ('1546779904001208322', '商务司机', 2, '1546779691731677185', 1, 3);
INSERT INTO `job_type` VALUES ('1546779952776769537', '驾校司机', 3, '1546779691731677185', 1, 3);
INSERT INTO `job_type` VALUES ('1546779979842613250', '配送员', 4, '1546779691731677185', 1, 3);
INSERT INTO `job_type` VALUES ('1546780011211812865', '快递员', 5, '1546779691731677185', 1, 3);
INSERT INTO `job_type` VALUES ('1546780055247810561', '仓库管理员', 1, '1546779710501187586', 1, 3);
INSERT INTO `job_type` VALUES ('1546780074453528578', '仓库文员', 2, '1546779710501187586', 1, 3);
INSERT INTO `job_type` VALUES ('1546780097836773378', '仓库经理', 3, '1546779710501187586', 1, 3);
INSERT INTO `job_type` VALUES ('1546780136055271425', '物流专员', 1, '1546779730117947393', 1, 3);
INSERT INTO `job_type` VALUES ('1546780154090778625', '物流经理', 2, '1546779730117947393', 1, 3);
INSERT INTO `job_type` VALUES ('1546780176387698690', '供应链总监', 3, '1546779730117947393', 1, 3);
INSERT INTO `job_type` VALUES ('1546780235196035073', '核销员', 4, '1546779730117947393', 1, 3);
INSERT INTO `job_type` VALUES ('1546780270671458306', '集装箱管理员', 5, '1546779730117947393', 1, 3);
INSERT INTO `job_type` VALUES ('1546780373742284802', '调度员', 6, '1546779730117947393', 1, 3);
INSERT INTO `job_type` VALUES ('1546780874487656450', '采购', 1, '1546729339112157186', 0, 2);
INSERT INTO `job_type` VALUES ('1546780944457035777', '进出口贸易', 2, '1546729339112157186', 0, 2);
INSERT INTO `job_type` VALUES ('1546780980758736897', '采购专员', 1, '1546780874487656450', 1, 3);
INSERT INTO `job_type` VALUES ('1546781001109499905', '采购经理', 2, '1546780874487656450', 1, 3);
INSERT INTO `job_type` VALUES ('1546781038384279553', '商品经理', 3, '1546780874487656450', 1, 3);
INSERT INTO `job_type` VALUES ('1546781137730564098', '贸易跟单', 1, '1546780944457035777', 1, 3);
INSERT INTO `job_type` VALUES ('1546781168223154178', '单证员', 2, '1546780944457035777', 1, 3);
INSERT INTO `job_type` VALUES ('1546781199823040513', '报关员', 3, '1546780944457035777', 1, 3);
INSERT INTO `job_type` VALUES ('1546781400998637570', '护士/护理', 1, '1546729377531981825', 0, 2);
INSERT INTO `job_type` VALUES ('1546781469449678849', '医生', 2, '1546729377531981825', 0, 2);
INSERT INTO `job_type` VALUES ('1546781502001672194', '保健理疗', 3, '1546729377531981825', 0, 2);
INSERT INTO `job_type` VALUES ('1546781527645646850', '药店', 4, '1546729377531981825', 0, 2);
INSERT INTO `job_type` VALUES ('1546781560835174401', '生物医药', 5, '1546729377531981825', 0, 2);
INSERT INTO `job_type` VALUES ('1546781602396532737', '医疗器械', 6, '1546729377531981825', 0, 2);
INSERT INTO `job_type` VALUES ('1546781651440529409', '护士', 1, '1546781400998637570', 1, 3);
INSERT INTO `job_type` VALUES ('1546781672709844993', '护士长', 2, '1546781400998637570', 1, 3);
INSERT INTO `job_type` VALUES ('1546781696298610690', '护工', 3, '1546781400998637570', 1, 3);
INSERT INTO `job_type` VALUES ('1546781724668882946', '核酸采样员', 4, '1546781400998637570', 1, 3);
INSERT INTO `job_type` VALUES ('1546781815106465794', '医生/医护人员', 1, '1546781469449678849', 1, 3);
INSERT INTO `job_type` VALUES ('1546781857200500737', '中医', 2, '1546781469449678849', 1, 3);
INSERT INTO `job_type` VALUES ('1546781890578771970', '药剂师', 3, '1546781469449678849', 1, 3);
INSERT INTO `job_type` VALUES ('1546781949668126722', '整形医师', 4, '1546781469449678849', 1, 3);
INSERT INTO `job_type` VALUES ('1546782027917062145', '营养师', 1, '1546781502001672194', 1, 3);
INSERT INTO `job_type` VALUES ('1546782067523874818', '理疗康复师', 2, '1546781502001672194', 1, 3);
INSERT INTO `job_type` VALUES ('1546782176026324994', '药店店员', 1, '1546781527645646850', 1, 3);
INSERT INTO `job_type` VALUES ('1546782199577341954', '药店店长', 2, '1546781527645646850', 1, 3);
INSERT INTO `job_type` VALUES ('1546782256078811138', '生物制药', 1, '1546781560835174401', 1, 3);
INSERT INTO `job_type` VALUES ('1546782286521069570', '医药研发', 2, '1546781560835174401', 1, 3);
INSERT INTO `job_type` VALUES ('1546782315948306433', '药品生产', 3, '1546781560835174401', 1, 3);
INSERT INTO `job_type` VALUES ('1546782404439732225', '医疗器械生产与管理', 1, '1546781602396532737', 1, 3);
INSERT INTO `job_type` VALUES ('1546782430037569537', '医疗器械研发', 2, '1546781602396532737', 1, 3);
INSERT INTO `job_type` VALUES ('1546782463361314817', '试剂研发', 3, '1546781602396532737', 1, 3);
INSERT INTO `job_type` VALUES ('1546782522370977793', '银行', 1, '1546729481181622273', 0, 2);
INSERT INTO `job_type` VALUES ('1546782561826795522', '证券/基金/期货', 2, '1546729481181622273', 0, 2);
INSERT INTO `job_type` VALUES ('1546782590293536769', '互联网金融', 3, '1546729481181622273', 0, 2);
INSERT INTO `job_type` VALUES ('1546782636346994690', '投融资', 4, '1546729481181622273', 0, 2);
INSERT INTO `job_type` VALUES ('1546782654755794945', '保险', 5, '1546729481181622273', 0, 2);
INSERT INTO `job_type` VALUES ('1546782705037111298', '信贷管理', 1, '1546782522370977793', 1, 3);
INSERT INTO `job_type` VALUES ('1546782762704596994', '柜员', 2, '1546782522370977793', 1, 3);
INSERT INTO `job_type` VALUES ('1546782792278634497', '大堂经理', 3, '1546782522370977793', 1, 3);
INSERT INTO `job_type` VALUES ('1546782818165878786', '商务渠道', 4, '1546782522370977793', 1, 3);
INSERT INTO `job_type` VALUES ('1546782841221967873', '分析师', 5, '1546782522370977793', 1, 3);
INSERT INTO `job_type` VALUES ('1546783092100067329', '证券交易员', 1, '1546782561826795522', 1, 3);
INSERT INTO `job_type` VALUES ('1546783138933665793', '买卖分析师', 2, '1546782561826795522', 1, 3);
INSERT INTO `job_type` VALUES ('1546783169887629314', '投资银行业务员', 3, '1546782561826795522', 1, 3);
INSERT INTO `job_type` VALUES ('1546783195661627394', '基金经理', 4, '1546782561826795522', 1, 3);
INSERT INTO `job_type` VALUES ('1546783217711083521', '证券师', 5, '1546782561826795522', 1, 3);
INSERT INTO `job_type` VALUES ('1546783282785710081', '催收员', 1, '1546782590293536769', 1, 3);
INSERT INTO `job_type` VALUES ('1546783354197929986', '投资经理', 2, '1546782590293536769', 1, 3);
INSERT INTO `job_type` VALUES ('1546783381133750273', '清算', 3, '1546782590293536769', 1, 3);
INSERT INTO `job_type` VALUES ('1546783459391074306', '投资合伙人', 1, '1546782636346994690', 1, 3);
INSERT INTO `job_type` VALUES ('1546783498532319233', '投资经理人', 2, '1546782636346994690', 1, 3);
INSERT INTO `job_type` VALUES ('1546783881363222529', '行业研究', 3, '1546782636346994690', 1, 3);
INSERT INTO `job_type` VALUES ('1546783910530412545', '融资', 4, '1546782636346994690', 1, 3);
INSERT INTO `job_type` VALUES ('1546783937705308162', '并购', 5, '1546782636346994690', 1, 3);
INSERT INTO `job_type` VALUES ('1546783972119572481', '保险理赔', 1, '1546782654755794945', 1, 3);
INSERT INTO `job_type` VALUES ('1546783995712532481', '保险精算师', 2, '1546782654755794945', 1, 3);
INSERT INTO `job_type` VALUES ('1546784045033353217', '翻译', 1, '1546729557564092418', 0, 2);
INSERT INTO `job_type` VALUES ('1546784111546626049', '咨询/调研', 2, '1546729557564092418', 0, 2);
INSERT INTO `job_type` VALUES ('1546784151715475457', '律师业', 3, '1546729557564092418', 0, 2);
INSERT INTO `job_type` VALUES ('1546784197265616898', '英语翻译', 1, '1546784045033353217', 1, 3);
INSERT INTO `job_type` VALUES ('1546784214210605058', '日语翻译', 2, '1546784045033353217', 1, 3);
INSERT INTO `job_type` VALUES ('1546784255423836161', '其他语言翻译', 3, '1546784045033353217', 1, 3);
INSERT INTO `job_type` VALUES ('1546784324499828737', '知识产权/专利/商标代理人', 1, '1546784111546626049', 1, 3);
INSERT INTO `job_type` VALUES ('1546784365306212353', '咨询项目管理', 2, '1546784111546626049', 1, 3);
INSERT INTO `job_type` VALUES ('1546784402589380610', '企业战略咨询师', 3, '1546784111546626049', 1, 3);
INSERT INTO `job_type` VALUES ('1546784450236674050', 'IT咨询', 4, '1546784111546626049', 1, 3);
INSERT INTO `job_type` VALUES ('1546784477055053826', '咨询经理', 5, '1546784111546626049', 1, 3);
INSERT INTO `job_type` VALUES ('1546784495346413570', '咨询总监', 6, '1546784111546626049', 1, 3);
INSERT INTO `job_type` VALUES ('1546784552888070145', '数据分析咨询师', 7, '1546784111546626049', 1, 3);
INSERT INTO `job_type` VALUES ('1546784594378125313', '事务所律师', 1, '1546784151715475457', 1, 3);
INSERT INTO `job_type` VALUES ('1546784621007761409', '律师助理', 2, '1546784151715475457', 1, 3);
INSERT INTO `job_type` VALUES ('1546784667170271233', '专利知识产权律师', 3, '1546784151715475457', 1, 3);
INSERT INTO `job_type` VALUES ('1546784712967876609', '律师/法务', 4, '1546784151715475457', 1, 3);
INSERT INTO `job_type` VALUES ('1546784800691744769', '农业/林业', 1, '1546729606780055554', 0, 2);
INSERT INTO `job_type` VALUES ('1546784833671557122', '畜牧/渔业', 2, '1546729606780055554', 0, 2);
INSERT INTO `job_type` VALUES ('1546784896594505730', '农业/林业技术员', 1, '1546784800691744769', 1, 3);
INSERT INTO `job_type` VALUES ('1546784957504188417', '畜牧/水产养殖技术员', 1, '1546784833671557122', 1, 3);
INSERT INTO `job_type` VALUES ('1546784979578810370', '饲养员', 2, '1546784833671557122', 1, 3);
INSERT INTO `job_type` VALUES ('1546785006573350913', '畜牧兽医', 3, '1546784833671557122', 1, 3);
INSERT INTO `job_type` VALUES ('1546785023795163138', '海王', 4, '1546784833671557122', 1, 3);
INSERT INTO `job_type` VALUES ('1546785096864133122', '高级管理职位', 1, '1546729642997870593', 0, 2);
INSERT INTO `job_type` VALUES ('1546785149829804033', '总裁/总经理/CEO', 1, '1546785096864133122', 1, 3);
INSERT INTO `job_type` VALUES ('1546785227776749570', '区域负责人(管辖多个分公司)', 2, '1546785096864133122', 1, 3);
INSERT INTO `job_type` VALUES ('1546785285184188418', '副总裁/副总经理/VP', 3, '1546785096864133122', 1, 3);
INSERT INTO `job_type` VALUES ('1546785387776864258', '总助/CEO助理/董事长助理', 4, '1546785096864133122', 1, 3);
INSERT INTO `job_type` VALUES ('1546785458027261953', '分公司/代表处负责人', 5, '1546785096864133122', 1, 3);
INSERT INTO `job_type` VALUES ('1546785486422700033', '董事会秘书', 6, '1546785096864133122', 1, 3);
INSERT INTO `job_type` VALUES ('1546785513912168450', '联合创始人', 7, '1546785096864133122', 1, 3);
INSERT INTO `job_type` VALUES ('1546785560695435265', '其他岗位', 1, '1546729670227292161', 0, 2);
INSERT INTO `job_type` VALUES ('1546785606937636866', '其他职位', 1, '1546785560695435265', 1, 3);
COMMIT;

-- ----------------------------
-- Table structure for orders
-- ----------------------------
DROP TABLE IF EXISTS `orders`;
CREATE TABLE `orders` (
  `id` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `user_id` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '用户主键id',
  `company_id` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '购买用户所在的企业主键id',
  `item_name` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '商品名称',
  `total_amount` int NOT NULL COMMENT '订单总价',
  `real_pay_amount` int NOT NULL COMMENT '实际支付总价格',
  `post_amount` int DEFAULT NULL COMMENT '邮费;默认可以为零，代表包邮',
  `pay_method` int NOT NULL COMMENT '支付方式',
  `status` int NOT NULL COMMENT '订单状态',
  `extend` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '扩展字段',
  `created_time` datetime NOT NULL COMMENT '创建时间',
  `updated_time` datetime NOT NULL COMMENT '更新时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='订单表';

-- ----------------------------
-- Records of orders
-- ----------------------------
BEGIN;
INSERT INTO `orders` VALUES ('220804343051336541011968', '1541299724478681090', '1541300495639175169', 'VIP企业会员-1个月', 1, 1, 0, 1, 10, NULL, '2022-08-04 23:23:32', '2022-08-04 23:23:32');
INSERT INTO `orders` VALUES ('220804343057093936283648', '1541299724478681090', '1541300495639175169', 'VIP企业会员-1个月', 1, 1, 0, 1, 10, NULL, '2022-08-04 23:46:25', '2022-08-04 23:46:25');
INSERT INTO `orders` VALUES ('220805343224929543520256', '1541299724478681090', '1541300495639175169', 'VIP企业会员-1个月', 1, 1, 0, 1, 50, NULL, '2022-08-05 10:53:20', '2022-08-05 10:53:20');
INSERT INTO `orders` VALUES ('220805343227459723853824', '1541299724478681090', '1541300495639175169', 'VIP企业会员-1个月', 1, 1, 0, 1, 10, NULL, '2022-08-05 11:03:23', '2022-08-05 11:03:23');
INSERT INTO `orders` VALUES ('220805343227694026063872', '1541299724478681090', '1541300495639175169', 'VIP企业会员-1个月', 1, 1, 0, 1, 10, NULL, '2022-08-05 11:04:19', '2022-08-05 11:04:19');
INSERT INTO `orders` VALUES ('220805343227708429303808', '1541299724478681090', '1541300495639175169', 'VIP企业会员-1个月', 1, 1, 0, 1, 10, NULL, '2022-08-05 11:04:23', '2022-08-05 11:04:23');
INSERT INTO `orders` VALUES ('220805343227791870787584', '1541299724478681090', '1541300495639175169', 'VIP企业会员-1个月', 1, 1, 0, 1, 50, NULL, '2022-08-05 11:04:42', '2022-08-05 11:04:42');
INSERT INTO `orders` VALUES ('220805343227808660586496', '1541299724478681090', '1541300495639175169', 'VIP企业会员-1个月', 1, 1, 0, 1, 10, NULL, '2022-08-05 11:04:46', '2022-08-05 11:04:46');
INSERT INTO `orders` VALUES ('220805343227821138640896', '1541299724478681090', '1541300495639175169', 'VIP企业会员-1个月', 1, 1, 0, 1, 10, NULL, '2022-08-05 11:04:49', '2022-08-05 11:04:49');
INSERT INTO `orders` VALUES ('220805343227836011642880', '1541299724478681090', '1541300495639175169', 'VIP企业会员-1个月', 1, 1, 0, 1, 10, NULL, '2022-08-05 11:04:53', '2022-08-05 11:04:53');
INSERT INTO `orders` VALUES ('220805343227849232089088', '1541299724478681090', '1541300495639175169', 'VIP企业会员-1个月', 1, 1, 0, 1, 10, NULL, '2022-08-05 11:04:56', '2022-08-05 11:04:56');
INSERT INTO `orders` VALUES ('220805343227898938785792', '1541299724478681090', '1541300495639175169', 'VIP企业会员-1个月', 1, 1, 0, 1, 50, NULL, '2022-08-05 11:05:08', '2022-08-05 11:05:08');
INSERT INTO `orders` VALUES ('220805343227909156110336', '1541299724478681090', '1541300495639175169', 'VIP企业会员-1个月', 1, 1, 0, 1, 10, NULL, '2022-08-05 11:05:10', '2022-08-05 11:05:10');
INSERT INTO `orders` VALUES ('220805343228337222582272', '1541299724478681090', '1541300495639175169', 'VIP企业会员-1个月', 1, 1, 0, 1, 10, NULL, '2022-08-05 11:06:52', '2022-08-05 11:06:52');
INSERT INTO `orders` VALUES ('220805343228405312913408', '1541299724478681090', '1541300495639175169', 'VIP企业会员-1个月', 1, 1, 0, 1, 10, NULL, '2022-08-05 11:07:09', '2022-08-05 11:07:09');
INSERT INTO `orders` VALUES ('220805343228414129340416', '1541299724478681090', '1541300495639175169', 'VIP企业会员-1个月', 1, 1, 0, 1, 10, NULL, '2022-08-05 11:07:11', '2022-08-05 11:07:11');
INSERT INTO `orders` VALUES ('220805343228509503619072', '1541299724478681090', '1541300495639175169', 'VIP企业会员-1个月', 1, 1, 0, 1, 10, NULL, '2022-08-05 11:07:34', '2022-08-05 11:07:34');
INSERT INTO `orders` VALUES ('220805343228539736162304', '1541299724478681090', '1541300495639175169', 'VIP企业会员-1个月', 1, 1, 0, 1, 10, NULL, '2022-08-05 11:07:41', '2022-08-05 11:07:41');
INSERT INTO `orders` VALUES ('220805343228560363749376', '1541299724478681090', '1541300495639175169', 'VIP企业会员-1个月', 1, 1, 0, 1, 10, NULL, '2022-08-05 11:07:46', '2022-08-05 11:07:46');
INSERT INTO `orders` VALUES ('220805343228592672473088', '1541299724478681090', '1541300495639175169', 'VIP企业会员-1个月', 1, 1, 0, 1, 10, NULL, '2022-08-05 11:07:53', '2022-08-05 11:07:53');
INSERT INTO `orders` VALUES ('220805343228603103707136', '1541299724478681090', '1541300495639175169', 'VIP企业会员-1个月', 1, 1, 0, 1, 10, NULL, '2022-08-05 11:07:56', '2022-08-05 11:07:56');
INSERT INTO `orders` VALUES ('220805343230522580795392', '1541299724478681090', '1541300495639175169', 'VIP企业会员-1个月', 1, 1, 0, 1, 10, NULL, '2022-08-05 11:15:34', '2022-08-05 11:15:34');
INSERT INTO `orders` VALUES ('220805343230587764473856', '1541299724478681090', '1541300495639175169', 'VIP企业会员-1个月', 1, 1, 0, 1, 40, NULL, '2022-08-05 11:15:49', '2022-08-05 11:16:46');
INSERT INTO `orders` VALUES ('220805343235339122376704', '1541299724478681090', '1541300495639175169', 'VIP企业会员-1个月', 1, 1, 0, 1, 10, NULL, '2022-08-05 11:34:42', '2022-08-05 11:34:42');
INSERT INTO `orders` VALUES ('220805343236972313051136', '1541299724478681090', '1541300495639175169', 'VIP企业会员-1个月', 1, 1, 0, 1, 10, NULL, '2022-08-05 11:41:11', '2022-08-05 11:41:11');
INSERT INTO `orders` VALUES ('220805343242253981974528', '1541299724478681090', '1541300495639175169', 'VIP企业会员-1个月', 1, 1, 0, 1, 40, NULL, '2022-08-05 12:02:10', '2022-08-05 12:06:51');
INSERT INTO `orders` VALUES ('220805343242886088753152', '1541299724478681090', '1541300495639175169', 'VIP企业会员-1个月', 1, 1, 0, 1, 40, NULL, '2022-08-05 12:04:41', '2022-08-05 12:04:48');
INSERT INTO `orders` VALUES ('220805343243078137544704', '1541299724478681090', '1541300495639175169', 'VIP企业会员-1个月', 1, 1, 0, 1, 40, NULL, '2022-08-05 12:05:27', '2022-08-05 12:05:43');
INSERT INTO `orders` VALUES ('220810345007333555830784', '1541299724478681090', '1541300495639175169', 'VIP企业会员-1个月', 1, 1, 0, 1, 40, NULL, '2022-08-10 08:55:58', '2022-08-10 08:56:37');
INSERT INTO `orders` VALUES ('220810345007498740105216', '1541299724478681090', '1541300495639175169', 'VIP企业会员-1个月', 1, 1, 0, 1, 10, NULL, '2022-08-10 08:56:38', '2022-08-10 08:56:38');
INSERT INTO `orders` VALUES ('220810345009246754045952', '1541299724478681090', '1541300495639175169', 'VIP企业会员-1个月', 1, 1, 0, 1, 10, NULL, '2022-08-10 09:03:34', '2022-08-10 09:03:34');
INSERT INTO `orders` VALUES ('220810345014289112760320', '1541299724478681090', '1541300495639175169', 'VIP企业会员-1个月', 1, 1, 0, 1, 10, NULL, '2022-08-10 09:23:37', '2022-08-10 09:23:37');
INSERT INTO `orders` VALUES ('220810345014299384610816', '1541299724478681090', '1541300495639175169', 'VIP企业会员-1个月', 1, 1, 0, 1, 10, NULL, '2022-08-10 09:23:39', '2022-08-10 09:23:39');
INSERT INTO `orders` VALUES ('220810345014336353206272', '1541299724478681090', '1541300495639175169', 'VIP企业会员-1个月', 1, 1, 0, 1, 10, NULL, '2022-08-10 09:23:48', '2022-08-10 09:23:48');
INSERT INTO `orders` VALUES ('220810345014477516701696', '1541299724478681090', '1541300495639175169', 'VIP企业会员-1个月', 1, 1, 0, 1, 10, NULL, '2022-08-10 09:24:21', '2022-08-10 09:24:21');
INSERT INTO `orders` VALUES ('220810345014859546492928', '1541299724478681090', '1541300495639175169', 'VIP企业会员-1个月', 1, 1, 0, 1, 40, NULL, '2022-08-10 09:25:53', '2022-08-10 09:26:58');
INSERT INTO `orders` VALUES ('220810345015472963452928', '1541299724478681090', '1541300495639175169', 'VIP企业会员-1个月', 1, 1, 0, 1, 10, NULL, '2022-08-10 09:28:19', '2022-08-10 09:28:19');
INSERT INTO `orders` VALUES ('220810345040589911228416', '1541299724478681090', '1541300495639175169', 'VIP企业会员-1个月', 1, 1, 0, 1, 10, NULL, '2022-08-10 11:08:07', '2022-08-10 11:08:07');
INSERT INTO `orders` VALUES ('220818348121151358107648', '1553737574100766721', '1560274281974820865', 'VIP企业会员-1个月', 1, 1, 0, 1, 10, NULL, '2022-08-18 23:09:10', '2022-08-18 23:09:10');
INSERT INTO `orders` VALUES ('220818348125471226986496', '1553737574100766721', '1560274281974820865', 'VIP企业会员-1个月', 1, 1, 0, 1, 40, NULL, '2022-08-18 23:26:20', '2022-08-18 23:26:37');
INSERT INTO `orders` VALUES ('220818348126848422510592', '1553737574100766721', '1560274281974820865', 'VIP企业会员-1个月', 1, 1, 0, 1, 10, NULL, '2022-08-18 23:31:49', '2022-08-18 23:31:49');
INSERT INTO `orders` VALUES ('220818348128688904077312', '1553737574100766721', '1560274281974820865', 'VIP企业会员-1个月', 1, 1, 0, 1, 10, NULL, '2022-08-18 23:39:07', '2022-08-18 23:39:07');
COMMIT;

-- ----------------------------
-- Table structure for report_job
-- ----------------------------
DROP TABLE IF EXISTS `report_job`;
CREATE TABLE `report_job` (
  `id` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `job_id` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '被举报的职位id',
  `report_user_id` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '举报人id',
  `report_user_name` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '举报人姓名',
  `report_reason` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '举报原因',
  `job_name` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '被举报的职位名称',
  `company_name` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '被举报的公司名称',
  `deal_status` int NOT NULL COMMENT '处理状态：0：待处理，1：已处理，2：忽略、无需处理',
  `created_time` datetime NOT NULL,
  `updated_time` datetime NOT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='举报职位';

-- ----------------------------
-- Table structure for resume
-- ----------------------------
DROP TABLE IF EXISTS `resume`;
CREATE TABLE `resume` (
  `id` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `user_id` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '谁的简历，用户id',
  `advantage` varchar(2048) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '个人优势',
  `advantage_html` varchar(10240) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '个人优势的html内容，用于展示',
  `credentials` varchar(256) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '资格证书',
  `skills` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '技能标签',
  `status` varchar(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '求职状态',
  `refresh_time` datetime DEFAULT NULL COMMENT '刷新简历时间',
  `create_time` datetime NOT NULL,
  `updated_time` datetime NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE KEY `user_id` (`user_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='简历表';

-- ----------------------------
-- Records of resume
-- ----------------------------
BEGIN;
INSERT INTO `resume` VALUES ('1543531836451627009', '1541299724478681090', 'fwerf\nfew\nfd\newf\new\nfe\nwf\new\n', '<p>fwerf</p><p>few</p><p>fd</p><p>ewf</p><p>ew</p><p>fe</p><p>wf</p><p>ew</p>', ',aa,bb,fwewe,PMP国际项目经理认证,', ',r432r23,222,333,www,spring,hibernate,', '在职，暂无跳槽打算', '2022-07-13 22:43:09', '2022-07-03 17:47:22', '2022-07-16 20:24:43');
INSERT INTO `resume` VALUES ('1543595502089867266', '1543595500261138433', '11', '11', '', '风间11の 地方', '啊啊啊', '2022-07-15 22:55:04', '2022-07-03 22:00:21', '2022-07-09 22:55:04');
INSERT INTO `resume` VALUES ('1548665906496045058', '1548665904348557313', '我很厉害\n', '<p>我很厉害</p>', NULL, NULL, NULL, NULL, '2022-07-17 21:48:20', '2022-07-17 21:49:31');
INSERT INTO `resume` VALUES ('1551835816311136257', '1551835815514251265', '我很厉害，精通各种编程技术，碉堡了\n', '<p>我很厉害，精通各种编程技术，碉堡了</p>', ',PMP,Java,', ',spring,springboot,', '在职，急寻新工作', '2022-07-26 16:10:00', '2022-07-26 15:44:25', '2022-07-26 16:11:22');
INSERT INTO `resume` VALUES ('1553737575296151553', '1553737574100766721', NULL, NULL, NULL, NULL, NULL, '2022-08-18 23:24:45', '2022-07-31 21:41:20', '2022-08-18 23:24:45');
INSERT INTO `resume` VALUES ('1554096529033404418', '1554096527766749186', NULL, NULL, NULL, NULL, NULL, NULL, '2022-08-01 21:27:41', '2022-08-01 21:27:41');
INSERT INTO `resume` VALUES ('1560289758931431425', '1560289757970927618', '精通java。\n精通全栈。\n精通大数据。\n能搬砖，能修理下水道。\n', '<p>精通java。</p><p>精通全栈。</p><p>精通大数据。</p><p>能搬砖，能修理下水道。</p>', ',PMP,项目经理资质,', ',Java,PMP,Spring,微服务,架构师,', '在职，看看新机会', '2022-08-19 11:56:26', '2022-08-18 23:37:22', '2022-08-19 12:05:07');
COMMIT;

-- ----------------------------
-- Table structure for resume_education
-- ----------------------------
DROP TABLE IF EXISTS `resume_education`;
CREATE TABLE `resume_education` (
  `id` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `user_id` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '谁的教育经历，用户id',
  `resume_id` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '属于哪份简历id',
  `school` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '学校名称',
  `education` varchar(16) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '学历',
  `major` varchar(16) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '专业名称',
  `begin_date` varchar(24) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '开始日期',
  `end_date` varchar(24) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '结束日期',
  `create_time` datetime NOT NULL,
  `updated_time` datetime NOT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='教育经历表';

-- ----------------------------
-- Records of resume_education
-- ----------------------------
BEGIN;
INSERT INTO `resume_education` VALUES ('1544617484256354305', '1543595500261138433', '1543595502089867266', '33', '硕士', 'content', '2022-01-01', '2022-02-02', '2022-07-06 17:41:20', '2022-07-06 17:41:20');
INSERT INTO `resume_education` VALUES ('1545113322601', '1541299724478681090', '1543531836451627009', '北京大学', '本科', '2234北2dw', '2021-03', '2023-01', '2022-07-08 13:21:43', '2022-07-08 13:21:43');
INSERT INTO `resume_education` VALUES ('1545113322601111', '1541299724478681090', '1543531836451627009', '清华大学', '硕士', 'dw清dqw', '2023-03', '2026-01', '2022-07-08 13:21:43', '2022-07-08 13:21:43');
INSERT INTO `resume_education` VALUES ('1545276921396633601', '1541299724478681090', '1543531836451627009', '红翔技校', '博士', 'aaa', '2014-03', '2027-01', '2022-07-08 13:21:43', '2022-07-08 13:21:43');
INSERT INTO `resume_education` VALUES ('1548666428242296833', '1548665904348557313', '1548665906496045058', '王牌学院', '硕士', '计算机', '2020-01', '2024-01', '2022-07-17 21:50:24', '2022-07-17 21:50:24');
INSERT INTO `resume_education` VALUES ('1551842057427099650', '1551835815514251265', '1551835816311136257', '北京大学', '本科', '计算机', '2020-01', '2024-02', '2022-07-26 16:09:13', '2022-07-26 16:09:13');
INSERT INTO `resume_education` VALUES ('1560468585905238017', '1560289757970927618', '1560289758931431425', '南京某大学', '本科', '计算机', '2016-01', '2024-01', '2022-08-19 11:27:58', '2022-08-19 11:27:58');
COMMIT;

-- ----------------------------
-- Table structure for resume_expect
-- ----------------------------
DROP TABLE IF EXISTS `resume_expect`;
CREATE TABLE `resume_expect` (
  `id` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `user_id` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '谁的求职期望，用户id',
  `resume_id` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '属于哪份简历id',
  `job_name` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '期望职位',
  `city` varchar(16) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '工作所在城市',
  `industry` varchar(16) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '工作对应所处行业',
  `begin_salary` int NOT NULL COMMENT '薪资要求区间-起始',
  `end_salary` int NOT NULL COMMENT '薪资要求区间-结束',
  `create_time` datetime NOT NULL,
  `updated_time` datetime NOT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='求职期望表';

-- ----------------------------
-- Records of resume_expect
-- ----------------------------
BEGIN;
INSERT INTO `resume_expect` VALUES ('1547058989743058946', '1543595500261138433', '1543595502089867266', 'Java工程师', '无锡', 'content', 30, 50, '2022-07-13 11:23:01', '2022-07-13 11:23:20');
INSERT INTO `resume_expect` VALUES ('1547135841128001538', '1541299724478681090', '1543531836451627009', '全栈工程师', '秦皇岛市', '社会工作', 10, 20, '2022-07-13 16:28:24', '2022-07-15 13:34:00');
INSERT INTO `resume_expect` VALUES ('1547135973336657922', '1541299724478681090', '1543531836451627009', 'CTO', '长治市', '借贷', 5, 15, '2022-07-13 16:28:55', '2022-07-13 16:28:55');
INSERT INTO `resume_expect` VALUES ('1547188062024671233', '1541299724478681090', '1543531836451627009', 'Golang', '上海市', '消费金融', 10, 30, '2022-07-13 19:55:54', '2022-07-13 19:55:54');
INSERT INTO `resume_expect` VALUES ('1551842359249215490', '1551835815514251265', '1551835816311136257', 'Java', '北京市', '电子商务', 10, 20, '2022-07-26 16:10:25', '2022-07-26 16:10:25');
INSERT INTO `resume_expect` VALUES ('1560468056428883969', '1560289757970927618', '1560289758931431425', 'Java', '北京市', '电子商务', 7, 17, '2022-08-19 11:25:51', '2022-08-19 11:25:51');
INSERT INTO `resume_expect` VALUES ('1560468215472697345', '1560289757970927618', '1560289758931431425', '总裁/总经理/CEO', '上海市', '银行业务', 10, 55, '2022-08-19 11:26:29', '2022-08-19 11:26:29');
COMMIT;

-- ----------------------------
-- Table structure for resume_project_exp
-- ----------------------------
DROP TABLE IF EXISTS `resume_project_exp`;
CREATE TABLE `resume_project_exp` (
  `id` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `user_id` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '谁的项目经验，用户id',
  `resume_id` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '属于哪份简历id',
  `project_name` varchar(24) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '项目名称',
  `role_name` varchar(16) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '担任角色',
  `begin_date` varchar(24) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '项目开始日期',
  `end_date` varchar(24) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '项目结束日期',
  `content` varchar(2048) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '项目描述',
  `content_html` varchar(4096) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '项目描述',
  `create_time` datetime NOT NULL,
  `updated_time` datetime NOT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='项目经验表';

-- ----------------------------
-- Records of resume_project_exp
-- ----------------------------
BEGIN;
INSERT INTO `resume_project_exp` VALUES ('1544560732500508674', '222', '333', '33', '44', '2022-01-01', '2022-02-02', 'content', '123', '2022-07-06 13:55:50', '2022-07-06 14:03:45');
INSERT INTO `resume_project_exp` VALUES ('1544575131671969794', '1541299724478681090', '1543531836451627009', '新修改2', '架构师', '2018-04', '至今', '太厉害了\n', '<p>太厉害了</p>', '2022-07-06 14:53:03', '2022-07-06 15:22:14');
INSERT INTO `resume_project_exp` VALUES ('1544575690567094274', '1541299724478681090', '1543531836451627009', 'fewfew', 'fewf', '2019-01', '2018-01', 'fewfew\n', '<p>fewfew</p>', '2022-07-06 14:55:16', '2022-07-06 14:55:16');
INSERT INTO `resume_project_exp` VALUES ('1551841965135634434', '1551835815514251265', '1551835816311136257', '招聘项目', 'java后端', '2018-04', '2022-02', '很好的完成了任务\n', '<p>很好的完成了任务</p>', '2022-07-26 16:08:51', '2022-07-26 16:08:51');
INSERT INTO `resume_project_exp` VALUES ('1560476621847769090', '1560289757970927618', '1560289758931431425', '慕聘网', '技术经理', '2021-01', '至今', '1. 工作表现突出，能够996抗压\n2. 为大家提供各类帮助解决方案\n3. 为项目经理背锅\n4. 为架构师写PPT\n5. 为销售背稿子\n6. 为产品抗压力\n', '<p>1. 工作表现突出，能够996抗压</p><p>2. 为大家提供各类帮助解决方案</p><p>3. 为项目经理背锅</p><p>4. 为架构师写PPT</p><p>5. 为销售背稿子</p><p>6. 为产品抗压力</p>', '2022-08-19 11:59:54', '2022-08-19 11:59:54');
COMMIT;

-- ----------------------------
-- Table structure for resume_work_exp
-- ----------------------------
DROP TABLE IF EXISTS `resume_work_exp`;
CREATE TABLE `resume_work_exp` (
  `id` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `user_id` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '谁的工作经验，用户id',
  `resume_id` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '属于哪份简历id',
  `company_name` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '就职公司名称',
  `industry` varchar(24) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '行业',
  `begin_date` varchar(24) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '在职时间-开始',
  `end_date` varchar(24) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '在职时间-结束',
  `position` varchar(16) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '职位名称',
  `department` varchar(16) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '所在部门名称',
  `content` varchar(2048) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '工作内容、业绩、职责等',
  `content_html` varchar(4096) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '工作内容、业绩、职责等',
  `create_time` datetime NOT NULL,
  `updated_time` datetime NOT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='工作经验表';

-- ----------------------------
-- Records of resume_work_exp
-- ----------------------------
BEGIN;
INSERT INTO `resume_work_exp` VALUES ('1544335044161851393', '1541299724478681090', '1543531836451627009', '慕课网', '电子商务', '2019-02', '2021-01', '高级开发', '图3热脱附r', '若3无发热查给他5 \n', '<p>若3无发热查给他5 </p>', '2022-07-05 22:59:02', '2022-07-06 15:01:34');
INSERT INTO `resume_work_exp` VALUES ('1544575852362371073', '1541299724478681090', '1543531836451627009', '太厉害公司', '信托', '2018-01', '至今', '架构师', 'iulk', 'liului\n', '<p>liului</p>', '2022-07-06 14:55:55', '2022-07-08 13:16:42');
INSERT INTO `resume_work_exp` VALUES ('1544887785976262658', '1541299724478681090', '1543531836451627009', '太牛公司', '通信基础设施', '2021-01', '2022-03', '初级开发', 'ewfewf', 'undefinedfwefwe\n', '<p>undefinedfwefwe</p>', '2022-07-07 11:35:25', '2022-07-07 11:35:25');
INSERT INTO `resume_work_exp` VALUES ('1548666330091388930', '1548665904348557313', '1548665906496045058', '97公司', '工程服务', '2019-01', '至今', '架构师', '技术部', '啊啊啊啊啊啊\n', '<p>啊啊啊啊啊啊</p>', '2022-07-17 21:50:01', '2022-07-17 21:50:01');
INSERT INTO `resume_work_exp` VALUES ('1551841798256861186', '1551835815514251265', '1551835816311136257', '慕聘网', '计算机设备', '2020-01', '至今', '初级开发', '技术部', '工作取得重大进步\n', '<p>工作取得重大进步</p>', '2022-07-26 16:08:11', '2022-07-26 16:08:11');
INSERT INTO `resume_work_exp` VALUES ('1560476315818766338', '1560289757970927618', '1560289758931431425', '慕课网', '电子商务', '2021-01', '至今', '架构师', '技术部', '1. 工作表现突出，能够996抗压\n2. 为大家提供各类帮助解决方案\n3. 为项目经理背锅\n4. 为架构师写PPT\n5. 为销售背稿子\n6. 为产品抗压力\n', '<p>1. 工作表现突出，能够996抗压</p><p>2. 为大家提供各类帮助解决方案</p><p>3. 为项目经理背锅</p><p>4. 为架构师写PPT</p><p>5. 为销售背稿子</p><p>6. 为产品抗压力</p>', '2022-08-19 11:58:41', '2022-08-19 11:58:41');
INSERT INTO `resume_work_exp` VALUES ('1560476515408916482', '1560289757970927618', '1560289758931431425', '招聘网络公司', '社交网络', '2018-08', '2021-01', '背锅侠', '管理部', '1. 项目很大，负责独立模块开发\n2. 负责技术方案落地\n3. 带团开展打主宰\n', '<p>1. 项目很大，负责独立模块开发</p><p>2. 负责技术方案落地</p><p>3. 带团开展打主宰</p>', '2022-08-19 11:59:28', '2022-08-19 11:59:28');
COMMIT;

-- ----------------------------
-- Table structure for stu
-- ----------------------------
DROP TABLE IF EXISTS `stu`;
CREATE TABLE `stu` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `age` int NOT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=1002 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ----------------------------
-- Records of stu
-- ----------------------------
BEGIN;
INSERT INTO `stu` VALUES (1001, 'jame', 18);
COMMIT;

-- ----------------------------
-- Table structure for sys_params
-- ----------------------------
DROP TABLE IF EXISTS `sys_params`;
CREATE TABLE `sys_params` (
  `id` int NOT NULL,
  `max_resume_refresh_counts` int NOT NULL COMMENT '每日最大简历被刷新的次数',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='系统参数配置表，本表仅有一条记录';

-- ----------------------------
-- Records of sys_params
-- ----------------------------
BEGIN;
INSERT INTO `sys_params` VALUES (1001, 3);
COMMIT;

-- ----------------------------
-- Table structure for users
-- ----------------------------
DROP TABLE IF EXISTS `users`;
CREATE TABLE `users` (
  `id` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `mobile` varchar(11) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '手机号',
  `nickname` varchar(16) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '昵称',
  `real_name` varchar(16) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '真实姓名',
  `show_which_name` int NOT NULL DEFAULT '2' COMMENT '对外展示名，1：真实姓名，2：昵称',
  `sex` int NOT NULL COMMENT '性别，1:男 0:女 2:保密',
  `face` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '用户头像',
  `email` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '邮箱',
  `birthday` date DEFAULT NULL COMMENT '生日',
  `country` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '国家',
  `province` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '省份',
  `city` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '城市',
  `district` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '区县',
  `description` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '介绍',
  `start_work_date` date DEFAULT NULL COMMENT '我参加工作的时间',
  `position` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '我当前职位/职务',
  `role` int NOT NULL COMMENT '身份角色，1: 求职者，2: 求职者可以切换为HR进行招聘，同时拥有两个身份',
  `hr_in_which_company_id` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '成为HR后，认证的（绑定的）公司主键id',
  `hr_signature` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '我的一句话签名',
  `hr_tags` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '我的个性化标签',
  `created_time` datetime NOT NULL COMMENT '创建时间',
  `updated_time` datetime NOT NULL COMMENT '更新时间',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE KEY `mobile` (`mobile`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='用户表';

-- ----------------------------
-- Records of users
-- ----------------------------
BEGIN;
INSERT INTO `users` VALUES ('1534756548502724610', '13961884811', '123abcde', '用户：13******846', 2, 1, '111', 'abc@imooc.com', '1999-02-28', '中国', '', '', '', '这家伙很懒，什么都没留下~', '2022-06-09', '架构师', 1, '1001', NULL, NULL, '2022-06-09 12:37:30', '2022-06-09 12:37:30');
INSERT INTO `users` VALUES ('1534766306928394242', '13811112222', '风间影yue', '与一塌糊涂', 1, 0, 'http://192.168.1.5:8000/static/face/1534766306928394242.png', 'fewfewf!@', '2022-03-05', '中国', '', '', '', '这家伙很懒，什么都没留下~', '2022-12-01', '架构师', 2, '1538922979372867585', '哈哈哈\n笑死我了哈哈哈哈哈哈', ',资深架构师,资深HR,目标管理,OKR管理,游戏宅,亲和力,乐观主义,行业大牛,扁平化管理,', '2022-06-09 13:16:17', '2022-06-27 13:46:48');
INSERT INTO `users` VALUES ('1536563316312514561', '13822223333', '用户：13******699', '用户：13******699', 2, 2, 'http://122.152.205.72:88/group1/M00/00/05/CpoxxF6ZUySASMbOAABBAXhjY0Y649.png', '', '1900-01-01', '中国', '', '', '', '这家伙很懒，什么都没留下~', NULL, '底层码农', 2, '1538749984465575938', NULL, NULL, '2022-06-14 12:16:57', '2022-06-27 12:53:16');
INSERT INTO `users` VALUES ('1541299724478681090', '13812345678', '风间影月', '用户：13******678', 2, 1, 'http://122.152.205.72:88/group1/M00/00/05/CpoxxF6ZUySASMbOAABBAXhjY0Y649.png', '', '2013-01-01', '中国', '', '', '', '这家伙很懒，什么都没留下~', '2020-01-01', '底层码农2', 2, '1541300495639175169', '哈哈哈', ',资深架构师,团队负责人,目标管理,扁平化管理,游戏宅,', '2022-06-27 13:57:45', '2022-07-26 16:14:20');
INSERT INTO `users` VALUES ('1541300942626197505', '13812345633', '用户：13******633', '用户：13******633', 2, 2, 'http://122.152.205.72:88/group1/M00/00/05/CpoxxF6ZUySASMbOAABBAXhjY0Y649.png', '', '1900-01-01', '中国', '', '', '', '这家伙很懒，什么都没留下~', NULL, '底层码农', 2, '1541300495639175169', NULL, NULL, '2022-06-27 14:02:35', '2022-07-02 14:43:58');
INSERT INTO `users` VALUES ('1543468858024927233', '13812345608', '用啊啊啊补', '用户：13******608', 2, 2, 'http://122.152.205.72:88/group1/M00/00/05/CpoxxF6ZUySASMbOAABBAXhjY0Y649.png', '', '1900-01-01', '中国', '', '', '', '这家伙很懒，什么都没留下~', '1990-01-01', '底层码农', 2, '1543470160318599169', 'r4f2rf4', ',职场老司机,创业达人,目标管理,团队建设,团队负责人,批判性思维,亲和力,资深架构师,', '2022-07-03 13:37:07', '2022-07-03 16:16:36');
INSERT INTO `users` VALUES ('1543593000204279810', '13812345600', '用户：13******600', '用户：13******600', 2, 2, 'http://122.152.205.72:88/group1/M00/00/05/CpoxxF6ZUySASMbOAABBAXhjY0Y649.png', '', '1900-01-01', '中国', '', '', '', '这家伙很懒，什么都没留下~', NULL, '底层码农', 1, '', NULL, NULL, '2022-07-03 21:50:24', '2022-07-03 21:50:24');
INSERT INTO `users` VALUES ('1543593506435801090', '13961881231', '用户：13******231', '用户：13******231', 2, 2, 'http://122.152.205.72:88/group1/M00/00/05/CpoxxF6ZUySASMbOAABBAXhjY0Y649.png', '', '1900-01-01', '中国', '', '', '', '这家伙很懒，什么都没留下~', NULL, '底层码农', 1, '', NULL, NULL, '2022-07-03 21:52:25', '2022-07-03 21:52:25');
INSERT INTO `users` VALUES ('1543595500261138433', '13923881231', '11间月月', '用户：13******231', 2, 2, 'http://122.152.205.72:88/group1/M00/00/05/CpoxxF6ZUySASMbOAABBAXhjY0Y649.png', '', '1900-01-01', '中国', '', '', '', '这家伙很懒，什么都没留下~', NULL, '底层码农', 1, '', NULL, NULL, '2022-07-03 22:00:21', '2022-07-03 22:00:21');
INSERT INTO `users` VALUES ('1548665904348557313', '13912345888', '慕课架构师', '用户：13******888', 2, 0, 'http://122.152.205.72:88/group1/M00/00/05/CpoxxF6ZUySASMbOAABBAXhjY0Y649.png', '', '1997-01-01', '中国', '', '', '', '这家伙很懒，什么都没留下~', '2018-05-01', '底层码农', 1, '', NULL, NULL, '2022-07-17 21:48:19', '2022-07-17 21:49:16');
INSERT INTO `users` VALUES ('1551835815514251265', '13812349876', '我是求职的', '用户：13******876', 2, 1, 'http://192.168.1.10:8000/static/face/1551835815514251265.png', 'abc@aaaq.com', '1994-09-16', '中国', '', '', '', '这家伙很懒，什么都没留下~', '2012-01-01', '初级Java', 1, '', NULL, NULL, '2022-07-26 15:44:25', '2022-08-01 18:42:17');
INSERT INTO `users` VALUES ('1553737574100766721', '13912345678', '慕聘测试账号', '用户：13******678', 2, 1, 'http://hire.t.mukewang.com/static/face/1553737574100766721.jpg', 'test@imooc.com', '1996-05-06', '中国', '', '', '', '这家伙很懒，什么都没留下~', '2022-07-31', '招聘总监', 2, '1560274281974820865', '团队牛逼，奖金丰厚，欢迎加入我们', ',创业达人,目标管理,团队建设,亲和力,完美主义者,', '2022-07-31 21:41:19', '2022-08-19 11:22:05');
INSERT INTO `users` VALUES ('1554096527766749186', '13812345677', '用户：13******677', '用户：13******677', 2, 2, 'http://122.152.205.72:88/group1/M00/00/05/CpoxxF6ZUySASMbOAABBAXhjY0Y649.png', '', '1900-01-01', '中国', '', '', '', '这家伙很懒，什么都没留下~', '2022-08-01', '底层码农', 1, '', NULL, NULL, '2022-08-01 21:27:41', '2022-08-01 21:27:41');
INSERT INTO `users` VALUES ('1560289757970927618', '13961881122', '风间影月', '用户：13******846', 2, 2, 'http://hire.t.mukewang.com/static/face/1560289757970927618.jpg', 'Fjyy@admin.com', '1900-01-01', '中国', '', '', '', '这家伙很懒，什么都没留下~', '2018-07-01', '底层码农', 1, '', NULL, NULL, '2022-08-18 23:37:22', '2022-08-19 12:01:50');
COMMIT;

SET FOREIGN_KEY_CHECKS = 1;
