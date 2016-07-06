DROP DATABASE IF EXISTS mlglpku2014;
CREATE DATABASE IF NOT EXISTS mlglpku2014 DEFAULT CHARACTER SET latin1 COLLATE latin1_swedish_ci;
USE mlglpku2014;

DELIMITER $$
DROP PROCEDURE IF EXISTS add_keyword$$
CREATE PROCEDURE add_keyword(IN inKeywordTerm VARCHAR(100))
BEGIN
 INSERT INTO keyword (keyword_term) VALUES (inKeywordTerm);
END$$

DROP PROCEDURE IF EXISTS add_keyword_to_module$$
CREATE PROCEDURE add_keyword_to_module(IN inModuleID INT, IN inKeywordID INT)
BEGIN
 INSERT INTO module_keyword (module_id, keyword_id) VALUES (inModuleID, inKeywordID);
END$$

DROP PROCEDURE IF EXISTS add_module$$
CREATE PROCEDURE add_module(IN inModuleTitle TEXT, IN inModuleLeader TEXT, IN inModuleDescription TEXT, IN inImage TEXT, IN inCategory TEXT)
BEGIN
 INSERT INTO module (module_title, module_leader, module_description, module_image, module_category)
        VALUES (inModuleTitle, inModuleLeader, inModuleDescription, inImage, inCategory);
END$$

DROP PROCEDURE IF EXISTS count_keyword_category_result$$
CREATE PROCEDURE count_keyword_category_result(IN inKeyword TEXT, IN inCategory TEXT)
BEGIN
    PREPARE statement FROM
      "SELECT   count(*)
       FROM     module, module_keyword, keyword
       WHERE    module.module_id = module_keyword.module_id AND keyword.keyword_id = module_keyword.keyword_id AND keyword_term = ?
       AND	module_category = ?";
	SET @p1 = inKeyword;
	SET @p2 = inCategory;
	EXECUTE statement USING @p1, @p2;
END$$

DROP PROCEDURE IF EXISTS count_modules_in_collection$$
CREATE PROCEDURE count_modules_in_collection()
BEGIN
  SELECT COUNT(*) AS modules_in_collection_count
  FROM   module;
END$$

DROP PROCEDURE IF EXISTS count_modules_in_collection_by_category$$
CREATE PROCEDURE count_modules_in_collection_by_category(IN inCategory TEXT)
BEGIN
  SELECT COUNT(*) AS modules_in_collection_count
  FROM   module
  WHERE module_category = inCategory;
END$$

DROP PROCEDURE IF EXISTS count_modules_in_collection_by_keyword$$
CREATE PROCEDURE count_modules_in_collection_by_keyword(IN inKeyword TEXT)
BEGIN
  SELECT COUNT(*) AS modules_in_collection_count
  FROM   module, module_keyword, keyword
  WHERE module.module_id = module_keyword.module_id AND keyword.keyword_id = module_keyword.keyword_id AND keyword_term = inKeyword;
END$$

DROP PROCEDURE IF EXISTS count_search_category_result$$
CREATE PROCEDURE count_search_category_result(IN inSearchString TEXT, IN inCategory TEXT)
BEGIN
    PREPARE statement FROM
      "SELECT   count(*)
       FROM     module
       WHERE    module_category = ?
       AND	(module_title like ?
       OR 	module_leader like ?)";
	SET @p1 = inCategory;
	SET @p2 = concat('%', inSearchString, '%') ;
	EXECUTE statement USING @p1, @p2, @p2;
END$$

DROP PROCEDURE IF EXISTS count_search_keyword_result$$
CREATE PROCEDURE count_search_keyword_result(IN inSearchString TEXT, IN inKeyword TEXT)
BEGIN
    PREPARE statement FROM
      "SELECT   count(*)
       FROM     module, module_keyword, keyword
       WHERE    module.module_id = module_keyword.module_id AND keyword.keyword_id = module_keyword.keyword_id AND keyword_term = ?
       AND	(module_title like ?
       OR 	module_leader like ?)";
	SET @p1 = inKeyword;
	SET @p2 = concat('%', inSearchString, '%') ;
	EXECUTE statement USING @p1, @p2, @p2;
END$$

DROP PROCEDURE IF EXISTS count_search_result$$
CREATE PROCEDURE count_search_result(IN inSearchString VARCHAR(50))
BEGIN
    PREPARE statement FROM
      "SELECT   count(*)
       FROM     module
       WHERE    module_title like ?
       OR 	module_leader like ?";
	SET @p1 = concat('%', inSearchString, '%') ;
	EXECUTE statement USING @p1, @p1;
END$$

DROP PROCEDURE IF EXISTS get_category_list$$
CREATE PROCEDURE get_category_list()
BEGIN
	SELECT module_category, count(*) as count FROM module group by module_category order by count desc, module_category;
END$$

DROP PROCEDURE IF EXISTS get_category_list_search$$
CREATE PROCEDURE get_category_list_search(IN inSearchString TEXT)
BEGIN
    PREPARE statement FROM
      "SELECT   module_category, count(*) as count
       FROM     module
       WHERE    module_title like ?
       OR 	module_leader like ?
		 group by module_category order by count desc, module_category";
	SET @p1 = concat('%', inSearchString, '%') ;
	EXECUTE statement USING @p1, @p1;		 
END$$

DROP PROCEDURE IF EXISTS get_keyword_category_list$$
CREATE PROCEDURE get_keyword_category_list(IN inKeyword TEXT)
BEGIN
    PREPARE statement FROM
      "SELECT   module_category, count(*) as count
       FROM     module, module_keyword, keyword
       WHERE    module.module_id = module_keyword.module_id AND keyword.keyword_id = module_keyword.keyword_id AND keyword_term like ?
		 group by module_category order by count desc, module_category";
	SET @p1 = inKeyword;
	EXECUTE statement USING @p1;		 
END$$

DROP PROCEDURE IF EXISTS get_modules_by_category$$
CREATE PROCEDURE get_modules_by_category(IN inCategory TEXT, IN inModulesPerPage INT, IN inStartItem INT)
BEGIN
    SET @p1 = inCategory;
	SET @p2 = inStartItem;
	SET @p3 = inModulesPerPage;
	PREPARE statement FROM
      "SELECT   module.module_id, module_title,
                module_leader,
                module_description, module_image
       FROM     module
       WHERE  module_category = ? 
       ORDER BY module.module_id
       LIMIT    ?, ?";
	EXECUTE statement USING @p1, @p2, @p3;
END$$

DROP PROCEDURE IF EXISTS get_modules_by_keyword$$
CREATE PROCEDURE get_modules_by_keyword(IN inKeyword TEXT, IN inModulesPerPage INT, IN inStartItem INT)
BEGIN
    SET @p1 = inKeyword;
	SET @p2 = inStartItem;
	SET @p3 = inModulesPerPage;
	PREPARE statement FROM
      "SELECT   module.module_id, module_title,
                module_leader,
                module_description, module_image
       FROM     module, module_keyword, keyword
       WHERE  module.module_id = module_keyword.module_id AND keyword.keyword_id = module_keyword.keyword_id AND keyword_term = ? 
       ORDER BY module.module_id
       LIMIT    ?, ?";
	EXECUTE statement USING @p1, @p2, @p3;
END$$

DROP PROCEDURE IF EXISTS get_modules_by_keyword_category$$
CREATE PROCEDURE get_modules_by_keyword_category(IN inKeyword TEXT, IN inCategory TEXT, IN inModulesPerPage INT, IN inStartItem INT)
BEGIN
    SET @p1 = inKeyword;
    SET @p2 = inCategory;	
	SET @p3 = inStartItem;
	SET @p4 = inModulesPerPage;
	PREPARE statement FROM
      "SELECT   module.module_id, module_title,
                module_leader,
                module_description, module_image
       FROM     module, module_keyword, keyword
       WHERE  module.module_id = module_keyword.module_id AND keyword.keyword_id = module_keyword.keyword_id AND keyword_term = ? AND module_category = ?
       ORDER BY module.module_id
       LIMIT    ?, ?";
	EXECUTE statement USING @p1, @p2, @p3, @p4;
END$$

DROP PROCEDURE IF EXISTS get_modules_latest$$
CREATE PROCEDURE get_modules_latest()
BEGIN
	SELECT module_id, module_title, module_leader, module_description, module_image, module_category FROM module ORDER BY module_id desc limit 12;
END$$

DROP PROCEDURE IF EXISTS get_modules_list$$
CREATE PROCEDURE get_modules_list()
BEGIN
	SELECT module_id, module_title, module_leader, module_description, module_image, module_category FROM module ORDER BY module_id desc limit 12;
END$$

DROP PROCEDURE IF EXISTS get_modules_on_collection$$
CREATE PROCEDURE get_modules_on_collection(IN inModulesPerPage INT, IN inStartItem INT)
BEGIN
	PREPARE statement FROM
    "SELECT   module_id, module_title, module_leader, module_description, module_image, module_category
     FROM     module
     LIMIT    ?, ?";
	SET @p1 = inStartItem;
	SET @p2 = inModulesPerPage;
	EXECUTE statement USING @p1, @p2;
END$$

DROP PROCEDURE IF EXISTS get_module_details$$
CREATE PROCEDURE get_module_details(IN inModuleId INT)
BEGIN
	SELECT module_title, module_leader, module_description, module_image, module_category
	FROM   module
	WHERE  module_id = inModuleId;
END$$

DROP PROCEDURE IF EXISTS get_module_keywords$$
CREATE PROCEDURE get_module_keywords(IN inModuleId INT)
BEGIN
	SELECT keyword.keyword_id, keyword_term
	FROM   keyword, module_keyword
	WHERE  module_id = inModuleId
	AND	   keyword.keyword_id = module_keyword.keyword_id
	ORDER BY keyword.keyword_term;
END$$

DROP PROCEDURE IF EXISTS get_module_leaders_list$$
CREATE PROCEDURE get_module_leaders_list()
BEGIN
	SELECT module_leader, count(*) as modules FROM module Group By module_leader Order by modules desc, module_leader;
END$$

DROP PROCEDURE IF EXISTS get_module_leaders_modules$$
CREATE PROCEDURE get_module_leaders_modules(IN inModuleLeader TEXT)
BEGIN
	SET @pattern = CONCAT('%',inModuleLeader,'%');
	PREPARE statement FROM
      "SELECT   module_id, module_title,
                module_leader, module_description, image
       FROM     module
       WHERE    module_leader LIKE ?
       ORDER BY module_id";
	SET @p1 = inModuleLeader;
	EXECUTE statement USING @p1;
END$$

DROP PROCEDURE IF EXISTS get_module_leader_modules$$
CREATE PROCEDURE get_module_leader_modules(IN inModuleLeader TEXT)
BEGIN
	SET @pattern = CONCAT('%',inModuleLeader,'%');
	PREPARE statement FROM
      "SELECT   module_id, module_title,
                module_leader, module_description, module_image, module_category
       FROM     module
       WHERE    module_leader LIKE ?
       ORDER BY module_id";
	SET @p1 = inModuleLeader;
	EXECUTE statement USING @p1;
END$$

DROP PROCEDURE IF EXISTS get_module_moduleleader$$
CREATE PROCEDURE get_module_moduleleader(IN inModuleId INT)
BEGIN
	SELECT module_leader
	FROM   module
	WHERE  module_id = inModuleId;
END$$

DROP PROCEDURE IF EXISTS get_random_modules$$
CREATE PROCEDURE get_random_modules()
BEGIN
	SELECT module_id, module_title, module_leader, module_description, module_image, module_category FROM module ORDER BY RAND() desc limit 12;
END$$

DROP PROCEDURE IF EXISTS get_random_module$$
CREATE PROCEDURE get_random_module()
BEGIN
	SELECT module_id, module_title, module_leader, module_description, module_image, module_category FROM module ORDER BY RAND() desc limit 1;
END$$

DROP PROCEDURE IF EXISTS search$$
CREATE PROCEDURE search(IN inSearchString VARCHAR(50), IN inModulesPerPage INT, IN inStartItem INT)
BEGIN
    PREPARE statement FROM
      "SELECT   module_id, module_title,
                module_leader, module_description, module_image, module_category
       FROM     module
       WHERE    module_title like ?
				OR 
				module_leader like ?
       ORDER BY module_title
       LIMIT    ?, ?";
	SET @p1 = concat('%', inSearchString, '%');
	SET @p2 = inStartItem;
	SET @p3 = inModulesPerPage;
	EXECUTE statement USING @p1, @p1, @p2, @p3;
END$$

DROP PROCEDURE IF EXISTS search_category$$
CREATE PROCEDURE search_category(IN inSearchString TEXT, IN inCategory TEXT, IN inModulesPerPage INT, IN inStartItem INT)
BEGIN
    PREPARE statement FROM
      "SELECT   module_id, module_title,
                module_leader, module_description, module_image
       FROM     module
       WHERE    module_category = ?
	AND (module_title like ?
	OR module_leader like ?)
       ORDER BY module_title
       LIMIT    ?, ?";
	SET @p1 = inCategory;
	SET @p2 = concat('%', inSearchString, '%');
	SET @p3 = inStartItem;
	SET @p4 = inModulesPerPage;
	EXECUTE statement USING @p1, @p2, @p2, @p3, @p4;
END$$

DROP PROCEDURE IF EXISTS search_keyword$$
CREATE PROCEDURE search_keyword(IN inSearchString TEXT, IN inKeyword TEXT, IN inModulesPerPage INT, IN inStartItem INT)
BEGIN
    PREPARE statement FROM
      "SELECT   module.module_id, module_title,
                module_leader, module_description, module_image
       FROM     module, module_keyword, keyword
       WHERE    module.module_id = module_keyword.module_id AND keyword.keyword_id = module_keyword.keyword_id AND keyword_term = ?
	AND (module_title like ?
	OR module_leader like ?)
       ORDER BY module_title
       LIMIT    ?, ?";
	SET @p1 = inKeyword;
	SET @p2 = concat('%', inSearchString, '%');
	SET @p3 = inStartItem;
	SET @p4 = inModulesPerPage;
	EXECUTE statement USING @p1, @p2, @p2, @p3, @p4;
END$$

DROP PROCEDURE IF EXISTS update_module$$
CREATE PROCEDURE update_module(IN inModuleId INT, IN inModuleTitle TEXT, IN inModuleLeader TEXT, IN inModuleDescription TEXT, IN inmodule_image TEXT, IN inCategory TEXT)
BEGIN
	UPDATE module
	SET    module_title = inModuleTitle, module_leader = inModuleLeader, module_description = inModuleDescription, module_image = inmodule_image, module_category = inCategory
	WHERE  module_id = inModuleId;
END$$



DELIMITER ;

DROP TABLE IF EXISTS keyword;
CREATE TABLE IF NOT EXISTS keyword (
keyword_id int(11) NOT NULL,
  keyword_term varchar(100) NOT NULL
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=637 ;

INSERT INTO keyword (keyword_id, keyword_term) VALUES
(1, '007'),
(2, '1950s'),
(3, '1960s'),
(4, '3D Modelling'),
(5, '50s'),
(6, '50s Films'),
(7, '60s'),
(8, 'ABC'),
(9, 'Academic'),
(10, 'Acoustic'),
(11, 'Active'),
(12, 'Actor'),
(13, 'Adult'),
(14, 'Advanced Techniques'),
(15, 'Advancements'),
(16, 'Adventure'),
(17, 'Age Of Character'),
(18, 'Air'),
(19, 'Air Hostess'),
(20, 'Air Travel'),
(21, 'Aircraft'),
(22, 'Airlines'),
(23, 'Airport'),
(24, 'Airport Career'),
(25, 'AJAX'),
(26, 'Album'),
(27, 'Alcohol'),
(28, 'Alternative'),
(29, 'AMD'),
(30, 'America'),
(31, 'American'),
(32, 'Analysing'),
(33, 'Analysis'),
(34, 'Android'),
(35, 'Animal'),
(36, 'Apple'),
(37, 'Application'),
(38, 'Applications'),
(39, 'Applied Ethics'),
(40, 'Architect'),
(41, 'Architecture'),
(42, 'Arsenal'),
(43, 'Art'),
(44, 'Artistic'),
(45, 'Asian'),
(46, 'ASP.NET'),
(47, 'Astronomy'),
(48, 'Astrophysics'),
(49, 'Attraction'),
(50, 'Author'),
(51, 'Automation'),
(52, 'Ayrshire'),
(53, 'B/W'),
(54, 'Band'),
(55, 'Bands Of The 60s'),
(56, 'Banjo'),
(57, 'Barney Gumble'),
(58, 'Basketball'),
(59, 'Bass Guitar'),
(60, 'Beginner'),
(61, 'Beginner Workouts'),
(62, 'Better Together'),
(63, 'Big Cats'),
(64, 'Bike'),
(65, 'Biology'),
(66, 'Bird'),
(67, 'Black-And-White'),
(68, 'Blood'),
(69, 'Blue'),
(70, 'Bolivarianism'),
(71, 'Books'),
(72, 'Brazil'),
(73, 'Brewing'),
(74, 'Bridge'),
(75, 'Britain'),
(76, 'British'),
(77, 'British Music'),
(78, 'BritPop'),
(79, 'Broadcasting'),
(80, 'Broomstick'),
(81, 'Brush'),
(82, 'Building'),
(83, 'Business'),
(84, 'Cabin Crew Training'),
(85, 'Camera'),
(86, 'Camera Work'),
(87, 'Car'),
(88, 'Cara Delevingne'),
(89, 'Caravan'),
(90, 'Carbon'),
(91, 'Cardinality'),
(92, 'Career'),
(93, 'Carving'),
(94, 'Cell Biochemistry'),
(95, 'Cells'),
(96, 'Cereal'),
(97, 'Chanel'),
(98, 'Charm'),
(99, 'Chef'),
(100, 'Chemistry'),
(101, 'Chess'),
(102, 'Chicago'),
(103, 'Children'),
(104, 'City'),
(105, 'Classic'),
(106, 'Classics'),
(107, 'Cleaning'),
(108, 'Cloning'),
(109, 'Coach'),
(110, 'Coco'),
(111, 'Coco Chanel'),
(112, 'Code'),
(113, 'Coding'),
(114, 'Colour'),
(115, 'Colour Of The Console'),
(116, 'Colouring'),
(117, 'Combination'),
(118, 'Comedian'),
(119, 'Comic Book'),
(120, 'Competition'),
(121, 'Competitive'),
(122, 'Components'),
(123, 'Computer Technology'),
(124, 'Computers'),
(125, 'Computing'),
(126, 'Concerts'),
(127, 'Conflict Management'),
(128, 'Console'),
(129, 'Construction'),
(130, 'Cook'),
(131, 'Cookies'),
(132, 'Cooking'),
(133, 'Corruption'),
(134, 'Cosmos'),
(135, 'Cost'),
(136, 'Country'),
(137, 'Cowboys'),
(138, 'Crafts'),
(139, 'Creative'),
(140, 'Creativity'),
(141, 'Cricket'),
(142, 'Cricketer'),
(143, 'Cross Country'),
(144, 'Cruise Company'),
(145, 'CSS'),
(146, 'Cuisine'),
(147, 'Culinary'),
(148, 'Culture'),
(149, 'Curse'),
(150, 'Curtom'),
(151, 'Customer Service'),
(152, 'Cyber'),
(153, 'Cycle'),
(154, 'Cycling'),
(155, 'Daniel Lloyd'),
(156, 'Darling'),
(157, 'Data Collection'),
(158, 'Data Privacy'),
(159, 'Data Storage'),
(160, 'Database'),
(161, 'Database Design'),
(162, 'Debates'),
(163, 'Defence'),
(164, 'Deploying'),
(165, 'Design'),
(166, 'Developing'),
(167, 'Development'),
(168, 'Development And Design'),
(169, 'Diet'),
(170, 'Dietary Guidelines'),
(171, 'Digital'),
(172, 'Director'),
(173, 'Distributed Systems'),
(174, 'DNA'),
(175, 'Doctor'),
(176, 'Downhill'),
(177, 'Drama'),
(178, 'Dreamcast'),
(179, 'Dribbling'),
(180, 'Drink'),
(181, 'Drive'),
(182, 'Driver'),
(183, 'Driving'),
(184, 'Drugs'),
(185, 'Drums'),
(186, 'Ear'),
(187, 'Eat'),
(188, 'Education'),
(189, 'Eiffel Tower'),
(190, 'Electronica'),
(191, 'Emulation'),
(192, 'Engine'),
(193, 'Engineering'),
(194, 'Enlightenment'),
(195, 'Enterprise'),
(196, 'Esports'),
(197, 'Ethical Boundaries'),
(198, 'Ethics'),
(199, 'Ethologist'),
(200, 'Europe'),
(201, 'Evaluation'),
(202, 'Everton'),
(203, 'Evolution'),
(204, 'Exercise Variations'),
(205, 'Extinct Dinosaurs'),
(206, 'Famous'),
(207, 'Fashion'),
(208, 'Fashion House'),
(209, 'Fastest Animal'),
(210, 'Fender'),
(211, 'Fields'),
(212, 'Film'),
(213, 'Fitness Health And Safety'),
(214, 'Fitness Organisations'),
(215, 'Flavour'),
(216, 'Flow'),
(217, 'Fly'),
(218, 'Food'),
(219, 'Food Prep'),
(220, 'Food Safety'),
(221, 'Football'),
(222, 'Fork'),
(223, 'FPS'),
(224, 'Frame'),
(225, 'Framework'),
(226, 'France'),
(227, 'Free'),
(228, 'FreeBSD'),
(229, 'Freedom'),
(230, 'Freemasons'),
(231, 'French'),
(232, 'Frisbee'),
(233, 'Frontman'),
(234, 'Fun'),
(235, 'Funds'),
(236, 'Funk'),
(237, 'Funk Rock'),
(238, 'Future'),
(239, 'Gadgets'),
(240, 'Gallery'),
(241, 'Game Company'),
(242, 'Game Developers'),
(243, 'Game Development'),
(244, 'Games'),
(245, 'Games Reviews'),
(246, 'Gaming'),
(247, 'Gardening'),
(248, 'Garth Brooks'),
(249, 'Gas'),
(250, 'Genre'),
(251, 'Glasgow'),
(252, 'Glue'),
(253, 'Go Karting'),
(254, 'God Of Cricket'),
(255, 'Goddesses'),
(256, 'Gods'),
(257, 'Gourmet'),
(258, 'Graphic'),
(259, 'Graphic Design'),
(260, 'Graphics'),
(261, 'Greatest Actors'),
(262, 'Greek'),
(263, 'Gregorian'),
(264, 'Ground Operations'),
(265, 'Guitar'),
(266, 'Guitarist'),
(267, 'Haggis'),
(268, 'Hardware'),
(269, 'Health'),
(270, 'Health Care Practice'),
(271, 'Healthy Diet'),
(272, 'Healthy Nutrition'),
(273, 'Healthy Physique'),
(274, 'Heisenberg'),
(275, 'Heroes'),
(276, 'Hex'),
(277, 'Historic Actors'),
(278, 'History'),
(279, 'Hobbyist'),
(280, 'Homer Simpson'),
(281, 'Horror'),
(282, 'Horticulture'),
(283, 'How To'),
(284, 'HTML'),
(285, 'HTTP'),
(286, 'Human Anatomy'),
(287, 'Human Health'),
(288, 'Human Physiology'),
(289, 'Illuminati'),
(290, 'Images'),
(291, 'Independence'),
(292, 'India'),
(293, 'Indian'),
(294, 'Indie'),
(295, 'Indie Rock'),
(296, 'Industrial Work Experience'),
(297, 'Influential Actors'),
(298, 'Information'),
(299, 'Innovate'),
(300, 'Instagram'),
(301, 'Instant TV'),
(302, 'Instrumental'),
(303, 'Instruments'),
(304, 'Intelligence'),
(305, 'Interface'),
(306, 'Interior'),
(307, 'Interior Design'),
(308, 'Interior Designer'),
(309, 'International Business'),
(310, 'Internet'),
(311, 'Investigation'),
(312, 'iOS'),
(313, 'James Bond'),
(314, 'Java'),
(315, 'Javascript'),
(316, 'John Wayne'),
(317, 'jQuery'),
(318, 'jUnit'),
(319, 'Justification'),
(320, 'Kal Penn'),
(321, 'Karl Lagerfeld'),
(322, 'Karting'),
(323, 'Kenny Chesney'),
(324, 'Killing'),
(325, 'Kitchen'),
(326, 'Knowledge Management'),
(327, 'Landmarks'),
(328, 'Landscapes'),
(329, 'Landscaping'),
(330, 'Language'),
(331, 'Largest'),
(332, 'Leader'),
(333, 'League Titles Won'),
(334, 'Learning'),
(335, 'Legality'),
(336, 'Lifestyle'),
(337, 'Linux'),
(338, 'Lionel Hutz'),
(339, 'Little Master'),
(340, 'Liverpool'),
(341, 'Location'),
(342, 'Lock Out'),
(343, 'Luthier Mas Hirade'),
(344, 'Macronutrients'),
(345, 'Magic'),
(346, 'Management'),
(347, 'Manager'),
(348, 'Manchester City'),
(349, 'Mark Shuttleworth'),
(350, 'Marvel'),
(351, 'Master Blaster'),
(352, 'Maths'),
(353, 'Meal'),
(354, 'Media'),
(355, 'Medical Uses'),
(356, 'Medicine'),
(357, 'Meta Ethics'),
(358, 'Method'),
(359, 'Microsoft'),
(360, 'Migration'),
(361, 'Mobile'),
(362, 'Model'),
(363, 'Models'),
(364, 'Modern Languages'),
(365, 'Money'),
(366, 'Morality'),
(367, 'Motivation'),
(368, 'Movement'),
(369, 'Movies'),
(370, 'MTB'),
(371, 'Multimedia Systems'),
(372, 'Multiplayer'),
(373, 'Music'),
(374, 'Music Production'),
(375, 'Musician'),
(376, 'MVC'),
(377, 'MySQL'),
(378, 'Myths'),
(379, 'NASA'),
(380, 'Negative'),
(381, 'Nelson Muntz'),
(382, 'Netflix'),
(383, 'Network'),
(384, 'Networking'),
(385, 'Night'),
(386, 'Nikola Tesla'),
(387, 'No'),
(388, 'Nocturnal'),
(389, 'Normative Ethics'),
(390, 'Notable People'),
(391, 'NVIDIA'),
(392, 'Oasis'),
(393, 'Obstacles'),
(394, 'Occult'),
(395, 'ODI'),
(396, 'Offline'),
(397, 'Oil'),
(398, 'Okeh'),
(399, 'Old Dinosaurs'),
(400, 'Olympian'),
(401, 'Online'),
(402, 'Opera'),
(403, 'Operating System'),
(404, 'Organizational Culture'),
(405, 'OS'),
(406, 'OSX'),
(407, 'Outdoor'),
(408, 'Paganini'),
(409, 'Paint'),
(410, 'Paintbrush'),
(411, 'Painting'),
(412, 'Paper'),
(413, 'Paris'),
(414, 'Passing'),
(415, 'PC'),
(416, 'PDO'),
(417, 'People'),
(418, 'Percentage'),
(419, 'Philosophy'),
(420, 'Photographs'),
(421, 'Photography'),
(422, 'PHP'),
(423, 'Physics'),
(424, 'Pink Floyd'),
(425, 'Place'),
(426, 'Places'),
(427, 'Plagiarism'),
(428, 'Plane'),
(429, 'Planets'),
(430, 'Platform'),
(431, 'Poet'),
(432, 'Politics'),
(433, 'Potion'),
(434, 'Powder'),
(435, 'Power'),
(436, 'Powers'),
(437, 'Principles'),
(438, 'Print'),
(439, 'Pro'),
(440, 'Professional'),
(441, 'Profit'),
(442, 'Program'),
(443, 'Programmer'),
(444, 'Programmes'),
(445, 'Programming'),
(446, 'Progression'),
(447, 'Project'),
(448, 'Protection'),
(449, 'PS2'),
(450, 'Psychology'),
(451, 'Quality Standards'),
(452, 'Racing'),
(453, 'Rap'),
(454, 'Ratings'),
(455, 'Read'),
(456, 'Records'),
(457, 'Referendum'),
(458, 'Relationships'),
(459, 'Research'),
(460, 'Responsibility'),
(461, 'Restaurants'),
(462, 'Review'),
(463, 'Revolution'),
(464, 'Revolutionise'),
(465, 'Riding'),
(466, 'Risk'),
(467, 'River'),
(468, 'Rock'),
(469, 'Rock Band'),
(470, 'Roles'),
(471, 'Romantic City'),
(472, 'Ronaldinho'),
(473, 'Rounders'),
(474, 'RPG'),
(475, 'Ruby'),
(476, 'Ryan Jarman'),
(477, 'Sachin Tendulkar'),
(478, 'Safety'),
(479, 'Sakashita'),
(480, 'Salmond'),
(481, 'Samba'),
(482, 'Scale'),
(483, 'Science'),
(484, 'Scientific'),
(485, 'Scientist'),
(486, 'Scope Of Tourism'),
(487, 'Scotch'),
(488, 'Scotland'),
(489, 'Scott'),
(490, 'Scottish'),
(491, 'Scottish Actors'),
(492, 'Scottish Universities'),
(493, 'Sculpture'),
(494, 'Sean Connery'),
(495, 'Seasoning'),
(496, 'Security'),
(497, 'Selfie'),
(498, 'Series'),
(499, 'Seymour Skinner'),
(500, 'Shooting'),
(501, 'Shopping'),
(502, 'Side Effects'),
(503, 'Simulation'),
(504, 'Singer'),
(505, 'Singing'),
(506, 'Sitcom'),
(507, 'Skiing'),
(508, 'Skill'),
(509, 'Skis'),
(510, 'Sky'),
(511, 'Smartphones'),
(512, 'SNES'),
(513, 'Snow'),
(514, 'Snow Plough'),
(515, 'Social Capital'),
(516, 'Socialist'),
(517, 'Society'),
(518, 'Software'),
(519, 'Software Analysis'),
(520, 'Software Design'),
(521, 'Software Development Practice'),
(522, 'Software Process'),
(523, 'Solo'),
(524, 'Song'),
(525, 'Songs'),
(526, 'Sony'),
(527, 'Soul'),
(528, 'Sound'),
(529, 'Space'),
(530, 'Spanish'),
(531, 'Special One'),
(532, 'Speed'),
(533, 'Spider-Man'),
(534, 'Sport'),
(535, 'Sports'),
(536, 'Sportsman'),
(537, 'Stage Presence'),
(538, 'Star Wars'),
(539, 'Stars'),
(540, 'Stealth Animal'),
(541, 'Stealth Hunting'),
(542, 'Stem Cell'),
(543, 'Stevie Wariner'),
(544, 'Story'),
(545, 'Strategy'),
(546, 'Stratocaster'),
(547, 'Streaming'),
(548, 'Strength'),
(549, 'Strings'),
(550, 'Success'),
(551, 'Supernatural'),
(552, 'Suspension'),
(553, 'Swapping'),
(554, 'Taiwan'),
(555, 'Takamine'),
(556, 'Talent'),
(557, 'Tapping'),
(558, 'Team Sports'),
(559, 'Tech'),
(560, 'Technique'),
(561, 'Technology'),
(562, 'Teen'),
(563, 'Test'),
(564, 'Testing'),
(565, 'The Beatles'),
(566, 'The Cribs'),
(567, 'Ticket Prices'),
(568, 'Timeline'),
(569, 'Titans'),
(570, 'Topic'),
(571, 'Tour Operations'),
(572, 'Tour Operator'),
(573, 'Tourism'),
(574, 'Tourism Industries'),
(575, 'Tourist Destinations'),
(576, 'Town'),
(577, 'Train'),
(578, 'Training'),
(579, 'Training Fitness Clients'),
(580, 'Training Principles'),
(581, 'Transfer Fees'),
(582, 'Transport'),
(583, 'Travel'),
(584, 'Travel Agent'),
(585, 'Travel Industries'),
(586, 'Trend'),
(587, 'TV'),
(588, 'TV Series'),
(589, 'UK'),
(590, 'United Kingdom'),
(591, 'University'),
(592, 'Urban'),
(593, 'USA'),
(594, 'Vampires'),
(595, 'Vee-Jay'),
(596, 'Vehicle'),
(597, 'Video'),
(598, 'Video Games'),
(599, 'Violence'),
(600, 'Violin'),
(601, 'Virtual'),
(602, 'Virus Attacks'),
(603, 'Vodka'),
(604, 'Voice'),
(605, 'Vote'),
(606, 'Wakefield'),
(607, 'Wand'),
(608, 'Web'),
(609, 'Web Application'),
(610, 'Web Architecture'),
(611, 'Web Design'),
(612, 'Web Development'),
(613, 'Web Programming'),
(614, 'Web Sites'),
(615, 'West Ham'),
(616, 'Whiskey'),
(617, 'Whisky'),
(618, 'White Beard'),
(619, 'White House Office Of Public Engagement'),
(620, 'Windows 7'),
(621, 'Windows 8'),
(622, 'Windows 8.1'),
(623, 'Wit'),
(624, 'Wrestling'),
(625, 'Wright'),
(626, 'Writer'),
(627, 'Writing'),
(628, 'XBOX'),
(629, 'X-Men'),
(630, 'Yes'),
(631, 'Yngwie Malmsteen'),
(632, 'Yosemite'),
(633, 'Zend'),
(634, 'Zombie Apocalypse'),
(635, 'Zombies'),
(636, 'Zone System');

DROP TABLE IF EXISTS module;
CREATE TABLE IF NOT EXISTS module (
module_id int(11) NOT NULL,
  module_title varchar(100) NOT NULL,
  module_leader varchar(50) NOT NULL,
  module_description varchar(1000) NOT NULL,
  module_image varchar(150) DEFAULT NULL,
  module_category varchar(20) NOT NULL
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=145;

INSERT INTO module (module_id, module_title, module_leader, module_description, module_image, module_category) VALUES
(1, 'Ryan Jarman - Modern Guitar Heroes', 'Ajod Singh', 'Ryan Jarman is a guitarist in the indie rock band "The Cribs". He is born and resides from Wakefield along with his brothers who are also in the band, Ross (drummer) is his younger brother and Gary (bassist) is his twin brother. In 2013 "The Cribs" were awarded the Outstanding Contribution To Music award by the NME and The Spirit Of Independence award by Q magazine. Ryan has suffered from a few health issues in the past, he has accidently cut himself in 2007 at the NME award which required internal stiches and has also suffered from physiological problem which caused him to lose weight. He also been in NME cool list in 2006 and 2007.', 'as_ryanjarman.jpg', 'Music'),
(2, 'Kalpen Suresh Modi (Kal penn) - Not Your Typical Hollwood Star', 'Ajod Singh', 'Kal penn is an Asian American actor that has starred in a variety of movies and sitcoms including the "Harold & Kumar" and "How I met your mother". He was born and grew up in Montclair, New Jersey USA although his mother and father were originally Gujarati immigrants from India. Kal penn has strong political interests and was part of president Obama presidency campaign. In 2009 he was appointed associate director of the "White House Office of Public Engagement" which involved him reaching out and liaising with the Asian American, Pacific Islander and arts communities.', 'as_kalpenn.jpg', 'Actor'),
(3, 'Sachin Tendulkar (cricketer) - The Little Master', 'Ajod Singh', 'Sachin Tendulkar is a former Indian cricketer born in Bombay who made his international ODI debut aged 16 for India.  He his incredibly talented batsmen and has made over 34,000 runs in all forms of international cricket and is the only player to do so yet. He is also scored the most runs in Test cricket. He also holds the record for most centuries in ODI and Test cricket. In 2013 his estimated net worth was 160 million USD according to wealth x. In April 2012, Tendulkar accepted the "Rajya Sabha" (upper house of the parliament of India) nomination proposed by the President of India and became the first active sportsperson and cricketer to have been nominated.', 'as_sachintendulkar.jpg', 'Sports'),
(4, 'Oasis', 'Alexander Mackenzie', 'Info on the bands history, members, records and other info', 'am_oasis.png', 'Music'),
(5, 'Scottish Independence', 'Alexander Mackenzie', 'Info on the run up to the vote, the outcome and the debates afterwards (unbiased)', 'am_independence.png', 'Politics'),
(6, 'Alcohol', 'Alexander Mackenzie', 'Various info on different types of alcohol and their histories and how they are made', 'am_alcohol.png', 'Food and Drink'),
(7, 'Shopping In The East End Of Glasgow', 'Amanda Bell', 'Glasgow Fort is a shopping center which is located in Easterhouse, Glasgow. It has some well-known shops as well as food restaurants.', 'ab_glasgowfort.jpg', 'Shopping'),
(8, 'Building Brig O''Doon Bridge', 'Amanda Bell', 'Brig O''Doon is a medieval bridge in Ayrshire, Scotland. It was built around the fifteenth centaury by James Kennedy. It is a crossing over the River Doon.', 'ab_brigodoon.jpg', 'Architecture'),
(9, 'An Introduction To University', 'Amanda Bell', 'Glasgow Caledonian University is in Glasgow. It has become one of the largest universities in Scotland with around 17,000 students.', 'ab_unilogo.jpg', 'Education'),
(10, 'The Rise of Online Competition', 'Andrew Glazier', 'In this day and age ESports have become a large part of modern culture with some competitive online games exceeding 65 million unique users. As well as this they create huge tournaments with rise to over 100,000 unique viewers', 'ag_cup.png', 'Gaming'),
(11, 'The Languages of Century 21', 'Andrew Glazier', 'As technology advances so do the number of different ways of reaching it''s potential through programming. Utilising languages such as C++, C, Java, Scala, F# and C# there are many different benefits to each and through such a programmer can meet their needs.', 'ag_code.png', 'Computing'),
(12, 'A Few Drives Worthy of Interest', 'Andrew Glazier', 'As the human race makes scientific advances, day to day life begins to evolve. As such cars are now commonplace in most human lives, depending on the person and place, people strive for comfort, efficiency, robustness and speed in their choice of vehicle.', 'ag_car.png', 'Motoring'),
(13, 'Learn Swift', 'Callum Smith', 'Swift is an innovative new programming language for Cocoa and Cocoa Touch. Writing code is interactive and fun, the syntax is concise yet expressive, and apps run lightning-fast. Swift is ready for your next iOS and OS X project - or for addition into your current app - because Swift code works side-by-side with Objective-C.', 'cs_swiftlogo.png', 'Computing'),
(14, 'History of Scotland', 'Callum Smith', 'People lived in Scotland for at least 8,500 years before recorded history dealt with Britain. Learn as much as there is to know about this once proud and innovative nation.', 'cs_lionrampant.png', 'History'),
(15, 'Home Brewing', 'Callum Smith', 'Homebrewing is the brewing of beer, sake, and other beverages through fermentation on a small scale as a hobby for personal consumption, free distribution at social gatherings, amateur brewing competitions or other non-commercial reasons. Both alcoholic and non-alcoholic beverages can be made at home. The term is also used informally for the production of non-brewed alcoholic drinks such as wine, cider and perry.', 'cs_beer.png', 'Food and Drink'),
(16, 'Scotland''s Greatest Footballers', 'Christopher Barr', 'This module will describe some of the greatest Scottish footballers that have ever lived.  It will give detailed statistics of each player to show why they merit the title of one of Scotland''s greats. An example on some of the information you will learn is Amount of Goals and Appearances they made.', 'cb_archiegemmell.jpg', 'Sports'),
(17, 'Places to visit before you die', 'Christopher Barr', 'This module will describe some of the must see places around the world.  It will explain why each place is so desirable to go to and where you can find them.  These places will be like monuments, buildings, beaches, etc.', 'cb_londoneye.jpg', 'Travel'),
(18, 'Scottish Bands', 'Christopher Barr', 'This module will talk about popular Scottish bands that have made a name for themselves.  The module will teach you where the bands came from in Scotland and how they first made their success. You will also learn other information like how many albums they have sold and when the band was formed.', 'cb_biffyclyro.jpg', 'Music'),
(19, 'Artificial intelligence 1', 'Christopher Friel', 'Course includes a general overview of AI: Statistics; Machine Learning; Logic and Planning', 'cf_johnmccarthy.jpg', 'Computing'),
(20, 'Rock and Roll History', 'Christopher Friel', 'Overview of Rock origins; A look at psychedelic rock; A study of Pink Floyd', 'cf_wishyouwerehere.jpg', 'Music'),
(21, 'Computer Architecture', 'Christopher Friel', 'Overview of basic computer architecture: Binary mathematics; Intro to Electronic Engineering', 'cf_johnvonneumann.gif', 'Computing'),
(22, 'The art of music production and live shows', 'Chris Scullion', 'The best music producers today are in high demand not just for their ability to create memorable music but to deliver unforgettable live performances. The course sets out to teach and familiarise students with high quality music production, understand stage presence and how to deliver a world class live show.', 'csc_jamesmurphy.jpg', 'Music'),
(23, 'Sports Teams as a successful business', 'Chris Scullion', 'In today''s world, sport and business go hand in hand. Some of the largest and most successful companies around are also some of the largest sporting franchises. The challenges faced by large sports team are very often financial problems rather than performance. This module aims to demonstrate to students the how a sports team balances its success on the field with its fiscal responsibilities.', 'csc_sportsteams.jpg', 'Sports'),
(24, 'The steps to finding success after university.', 'Chris Scullion', 'Success is not something that comes overnight. Some of the biggest names today did not find their success until well into their working lives. This module aims to inform students that success can be a goal to work towards throughout their lives and work out strategies to achieve realistic expectations.', 'csc_success.jpg', 'Education'),
(25, 'An Introduction to Star Wars by George Lucas', 'Claire Maclennan', 'This module will serve an introductory guide to the Star Wars universe. Whether students have never studied the films in depth before, or are looking for a refresher on Lucas'' creation, this module will help you distinguish your Wookies from  your Gungans and give you the knowledge you need to prepare yourself for more advanced classes.', 'cmacl_starwars.jpg', 'Film and TV'),
(26, 'History of Rock and Roll by Keith Richards', 'Claire Maclennan', 'Don''t know your Costello''s from your Presley''s? This module is for you. Delving into the history of some of the most famous musicians alive, this module will leave students with an extensive knowledge on some of the world''s greatest stars, exploring their stories, music and much more.', 'cmacl_keithrichards.jpg', 'Music'),
(27, 'Ultimate Frisbee by John Smith', 'Claire Maclennan', 'An extremely hands on module, Ultimate Frisbee is not for the faint-hearted. With a majority of students time spent heavily involved with the sport aspect of things, the module is popular among most students, though the theoretical side is not to be underestimated!', 'cmacl_frisbee.jpg', 'Sports'),
(28, 'Graphics Cards', 'Craig Miller', 'A module where you learn about Graphics cards for computers.', 'cm_graphicscard.jpg', 'Computing'),
(29, 'Breaking Bad', 'Craig Miller', 'A module dedicated to the TV series: Breaking Bad', 'cm_breakingbad.jpg', 'Film and TV'),
(30, 'Owls', 'Craig Miller', 'A module for learning about the bird called an Owl.', 'cm_owl.jpg', 'Nature'),
(31, 'Rock of Ages', 'Daniel Ferguson', 'A history and overview of Rock music from its conception in the 1950''s to the modern day global rock super-bands.', 'df_elvispresley.png', 'Music'),
(32, 'Modern Science vs Ethics', 'Daniel Ferguson', 'An in-depth look at the controversies caused by modern science from child vaccination arguments to moralities of cloning cells.', 'df_science.png', 'Science'),
(33, 'Fine Foods of Scotland', 'Daniel Ferguson', 'A look at the various culinary highlights of Scottish cuisine including drink, their origins, and more modern infamous innovations to the food world.', 'df_whisky.jpg', 'Food and Drink'),
(34, 'Written Cynicism', 'Dyllan Munro', 'Oscar Wilde was a 19th century novelist and poet famous for his cynical wit and flamboyant personal affairs. Often quoted and rarely understood, Wilde had a dramatic effect on many subsequent literary figures. Foremost amongst his works is the classic novel, The Picture of Dorian Gray. Wilde died destitute at the age of 46.', 'dm_oscarwilde.jpg', 'Literature'),
(35, 'King Of Cool', 'Dyllan Munro', 'Dean Martin was an American singer, actor and comedian famous for his participation in the iconic Rat Pack. Martin found fame with hits such as That''s Amore and Ain''t That A Kick In The Head as well as movies like Rio Bravo and Who Was That Lady? Effortlessly charming and confident, Martin left an impressive legacy after his death in 1995.', 'dm_deanmartin.jpg', 'Music'),
(36, 'Appetite For Destruction', 'Dyllan Munro', 'Slash, born Saul Hudson, achieved fame as the lead guitarist of Guns N'' Roses during the 1990s. Critically acclaimed, his ability to merge the classic blues he loved with the aggression of hard rock helped provide the soundtrack for a generation. Often featuring on Greatest Guitarists lists for his Guns N'' Roses work, Slash was also lauded for his work with Velvet Revolver as well as his own solo projects. Famous works include Sweet Child O'' Mine, Paradise City and Slither.', 'dm_slash.jpg', 'Music'),
(37, 'Web Programming 2', 'Edmond Hobeika', 'Web programming 2 will be handling all of the PHP & Java Script language during the length of the course and will teach how to run a code through a database and display the results out on a HTML CSS web page.', NULL, 'Computing'),
(38, 'Software Process and Practices', 'Edmond Hobeika', 'Software Process and Practices is a module that teaches how to develop testing units for Java application.', NULL, 'Computing'),
(39, 'Database Systems Development 1', 'Edmond Hobeika', 'This module practices the use of databases of which data is stored and is retrieved to display on webpages by many different languages.', NULL, 'Computing'),
(40, 'Leopard', 'Fahad Khalil', 'Leopard is found in Saharan Africa and Is one of the 5 biggest Cats. It is part of felidae family and has similar skull to jaquar. It can run up to 56 mph. it is well known for climbing trees and its stealth ability.', 'fk_leopard.jpg', 'Nature'),
(41, 'Argentinosaurus', 'Fahad Khalil', 'One of The biggest Dinosaurs known. The dinosaurs Lived on islands of south America approximately 94 millions years ago. First fossils were found in 1987. The length of this animal was up to 35 meters. Weighting 80 - 100 tonnes.', 'fk_argentinosaurus.jpg', 'Nature'),
(42, 'Peregrine Falcon', 'Fahad Khalil', 'Fastest Animal in Animal Kingdom reaching speed up to 200 mph. Female are Larger Than males. It can be found everywhere in world. This falcon has body length measuring from 34cm to 58cm.', 'fk_peregrinefalcon.jpg', 'Nature'),
(43, 'Samba Style', 'Frazer Carnie', 'Every football fan has seen their favourite worldwide superstar pulling off incredible tricks to get past their man, but they all have the same thought on their mind - How can I do that? Well that is exactly what this class teaches, with world renowned football legend Ronaldinho Gaucho...anything is possible.', 'fc_ronaldinho.jpg', 'Sports'),
(44, 'Gaming Wars', 'Frazer Carnie', 'The age-old debate about what system to use in order to play your games has been going on for years and it doesn''t look like it has any sign of changing soon. In this module you will learn the ins and outs of each system and their advantages/disadvantages. This world is constantly changing and with innovation happening every moment of the day, you need to stay up-to-date in order to future proof yourself.', 'fc_consolewars.jpg', 'Gaming'),
(45, 'Smartphone Tech', 'Frazer Carnie', 'In this day and age technology is moving at a rapid pace and with it, a new breed of ever-changing technology; Smartphones. These great gadgets have been around for a while now however they are quickly becoming closer and closer to fully-fledged miniature PCs, it can be hard to know which is best for you. This class will help you to understand what goes into a smartphone and just exactly how it works.', 'fc_smartphone.jpg', 'Technology'),
(46, 'Beginners Guide to Skiing', 'Heather Dawson', 'Learn the basics of side stepping up the snow on your skis and snow ploughing down. May include turns.', 'hd_skiing.jpg', 'Sports'),
(47, 'Hitting the High Note', 'Heather Dawson', 'Learn the basics of singing in an operatic fashion. Learn how to project your voice and hit that high note.', 'hd_sydneyoperahouse.jpg', 'Music'),
(48, 'Keeping it Country', 'Heather Dawson', 'Learn about the origins of country music and how it has progressed through the years. Get involved playing some of the traditional and not so traditional instruments.', 'hd_guitar.jpg', 'Music'),
(49, 'Snowboard Competition', 'Jack McInnes', 'This module will give details of every contestant in a snowboarding competition. The specific details given about each contestant will be their name, age, height and weight along with a small biography detailing the person''s nationality and their experience in previous competitions. If more people enter the competition the list can easily be updated.', 'jmci_snowboarder.jpg', 'Sports'),
(50, 'Employees', 'Jack McInnes', 'This module will list every employee in a shop and give some detail about them. Every employee''s name, their date of birth and their salary will be listed within this module and will be used by the store manager to handle employee information. If a customer stops working in this shop or another person enters the shop then the list can be modified simply.', 'jmci_shopcrew.jpg', 'Business'),
(51, 'Upcoming Games', 'Jack McInnes', 'This module will contain a list of all upcoming games for this year. The details given about each item will be the name of the game, the production company, the date of release and the platforms that it will be released on. Should another game be announced or the details of another game are changed in some way, this list can be changed to account for this.', 'jmci_supported3dgamelist.jpg', 'Gaming'),
(52, 'Psychology of Business Management', 'James Twigg', 'The module analyses the psychology behind business management focusing on the technology industry and researches the type of character and skill set required to successfully manage a global enterprise.', 'jt_psychologyofbusinessmanagement.png', 'Business'),
(53, 'The Essence of Gaming', 'James Twigg', 'The module researches the fundamentals of gaming through the eyes of a renowned game designer and explores why gaming is attractive to millions of people worldwide', 'jt_theessenceofgaming.png', 'Gaming'),
(54, 'Ubiquitous Programs', 'James Twigg', 'The module gives an insight into the programs that are essential in our everyday lives, from washing machine programs and cash machine programs to security and internet based programs, and how modern day living depends highly upon these innovations.', 'jt_ubiquitousprograms.png', 'Computing'),
(55, 'Cara Delevingne', 'Jamie Hammond', 'Born into a blue blooded line this model went from privileged kid to being the most wanted model on earth. She has walked every catwalk show from Fendi, Chanel, and Burberry to Marc Jacobs. Cara Delevingne really is the most wanted model of the 21st century.', 'jh_caradelevingne.jpg', 'Entertainment'),
(56, 'Chanel', 'Jamie Hammond', 'One of the worldâ€™s most prestigious fashion houses Coco Chanel took her ideas and built the empire that is now Chanel. Now run by Karl Lagerfeld who is the genius behind the iconic brands present designs. This is the evolution of an iconic name.', 'jh_chanel.png', 'Business'),
(57, 'Paris', 'Jamie Hammond', 'The most romantic city in the world located in the heart of France. People from all over the world descend on this city whether it is to climb the iconic Eiffel Tower or to indulge in the local delicacies.', 'jh_paris.jpg', 'Travel'),
(58, 'Web Programming 2', 'Joao Cochofel', 'In this module I will learn some web driven programming languages such as ASP.NET, MVC, Zend, Ruby on Rails. In this module I will also learn some concepts about web programming and also some techniques referring to web development.', 'jc_websitedevelopment.jpg', 'Computing'),
(59, 'Management Strategy and Practice', 'Joao Cochofel', 'This module will enable me to better understand the key concepts on management strategies of enterprises. It will also give an insight of organizational functioning, both formal and informal.', 'jc_bestpractices.jpg', 'Business'),
(60, 'Database System development', 'Joao Cochofel', 'With this module I''ll learn to design, create and implement databases using SQL.', 'jc_sql.png', 'Computing'),
(61, 'Video Game emulation', 'Jordan Ferries', 'In this module students will learn an understanding of emulation mainly focusing on the emulation of gaming consoles on PC hardware.  The content taught in this module will give students a better understand of how their code can be ported to hardware in which it wasnâ€™t developed for and the law behind emulating hardware for gaming purposes. The module consists of coursework and a class test. The coursework will give students a partly working NES emulator and their job is to get it working with their own NES style game.', 'jf_vge.jpg', 'Gaming'),
(62, 'Home automation development', 'Jordan Ferries', 'Students will gain an understanding of the hardware and software involved in the ever growing home automation part of computing systems. During this module students will get a chance to design and develop their own application to extent the connected home. The coursework of this module will be the 100% of the module mark which will ask students to design a web based application which controls the home in a certain way, this may be remote controlled lights or heating or something completely new.', 'jf_homeautomationdevelopment.jpg', 'Computing'),
(63, 'Mobile Application Development', 'Jordan Ferries', 'With the ever growing mobile market students must have a knowledge of the development of applications which can either be ported to mobile or work out the box on mobile devices therefore this module will give students an understanding of development on the open source mobile OS: Android. Students will create an android application to give them a better understanding of the mobile world. This module will consist of a class test and coursework.', 'jf_mobileappdev.jpg', 'Computing'),
(64, 'Attractions of the United Kingdom', 'Jordan Gilmartin', 'The page layout will consist of many must see places in each area of the UK; this module will provide information on popular tourist attractions around the country, the layout will consist of a home page, and an option to select a certain area (such as London, south west, north east, Scotland and Wales) each of these will contain the attraction within that area. The user will also be able to select that image, which will contain a brief history, and exact location. ', 'jg_westminsterabbey.png', 'Travel'),
(65, 'Universities of Scotland', 'Jordan Gilmartin', 'This layout will contain the 15 universities of Scotland, their history, location, what they excel in, and (if any) notable students. This module is designed to teach more about the universities themselves, and maybe help people decide if that is the university for them. The layout will consist of a home page; areas of Scotland, such as Glasgow and Dundee, and within these will contain the any university that resides within that area (city). There will also be a rating chart, inform users where in the world their university is ranked amongst both Scottish and rest of the worldâ€™s universities.', 'jg_abertay.jpg', 'Education'),
(66, 'Games and their developers', 'Jordan Gilmartin', 'The layout would contain a list of game developers and within each, a list of the games they have developed over the years. Each game will have information detailing its genre and review ratings and additional information such as controversies. Along with the games, the user will also be able to select on the game developer itself, there the user will find information on the game company, such as awards, its history and controversies (if any). This site will help gamers decide what games are worth buying and what are not.', 'jg_rockstar.png', 'Gaming'),
(67, 'Introduction to Fitness', 'Justin Joseph', 'This 20 credits level 5 module will introduce the first level fitness concepts for beginners, who found their interest in physical fitness and to pursue a career in fitness industry. The main goal of this module is to prepare the student to apply his/her understanding to their own participation in physical workouts and workout program creativity, through both theoretical and practical learning strategies. Some of the underpinning concepts students learn in this module, which enhance their sound knowledge, includes: Health Benefits of Fitness, Anatomy of Human Body, Fitness Organisation Provision in UK, Principles of Fitness Training, Safety and Legal Aspects of Fitness and Customer Service. Successful students are able to find careers in the field, such as fitness instruction, fitness management.', 'jj_fitness.jpg', 'Fitness'),
(68, 'Access to Travel and Tourism', 'Justin Joseph', 'This 20 credits level 5 module aim to prepare students, who would like to pursue a career in Travel and Tourism Industry. The wide scope of this module aims to cover variety of interesting units - Retail Travel, Worldwide Geography, Cabin Crew, Reception Skills, Tour Operations and Air travel. The advantage of achieving a work experience as part of syllabus, will enrich and enhance the studentâ€™s experience and confidence. The main goal of this module is that participating students in a real-time role play scenarios, to prepare for the interactions with clients, which is a core requirement in assessments. Range of practical skill sets are achievable upon completion of the module, such as maintaining efficient customer service and excellent communication, especially writing skill. Successful students may progress on to the higher level qualification, or opt to secure employment within the travel industries, such as airports or travel agencies.', 'jj_travel.jpg', 'Travel'),
(69, 'Access to Nutrition', 'Justin Joseph', 'This 20 credits level 6 module aim to prepare students for university level entry, whose higher education qualification did not meet the entry requirements. However, this module is also suitable for health care practitioners, who would like to specialise on nutrition and its application to their practice. Developing knowledge of nutrients and its effects on human physiology and cells is the primary goal of this module. It aims to cover topics, such as Human Anatomy, Dietary Requirements, Macronutrients, Food Safety and Regulations, Diet and Health, etc., through a blend of case studies, reports and research activities. The module also consider, for research purposes, to follow updated dietary guidance and explores the implications of dietary changes on health conditions. Upon successful completion of this module, students are eligible to progress on to university level for higher education.', 'jj_nutrition.jpg', 'Food and Drink'),
(70, 'How to be successful like me', 'Keifer Steyn', 'Influential rapper, Kanye West has decided to provide all necessary information he 		thinks anyone might need to be successful like him in the music industry.', 'ks_kanyewest.jpg', 'Music'),
(71, 'Let''s get going in the kitchen', 'Keifer Steyn', 'World famous chef Gordon Ramsay has designed a course on how to cook 			incredible meals from simple ingredients!', 'ks_gordonramsay.jpg', 'Food and Drink'),
(72, 'Racing made easy', 'Keifer Steyn', 'Racing driver, Lewis Hamilton has designed a module that eliminates difficulty 			during racing for young drivers.', 'ks_lewishamilton.jpg', 'Sports'),
(73, 'Chicago Soul', 'Kieran Harris', 'Chicago soul music is often forgotten about in comparison to the offerings from Detroit''s Motown and Memphis'' Stax Records. Though Curtis Mayfield was mainly known for his funk output of the 1970s, his contribution to Chicago''s soul music scene from the late 1950s throughout the 1960s was immense. In this module, students will learn of the music from Chess Records, OKeh Records, Jerry Butler, Etta James, Billy Stewart and much more.', 'kh_chicagosoul.jpg', 'Music'),
(74, 'American Landscapes', 'Kieran Harris', 'Ansel Adams photographic career begun in the 1920s. He was famous for his black and white landscapes, particularly of Yosemite National Park. His precise technical mastery of photography, including the use of his own Zone System, helped him create some of America''s most treasured photographs. This module will celebrate his vast body of work.', 'kh_americanlandscapes.jpg', 'Photography'),
(75, 'The Cosmos', 'Kieran Harris', 'Carl Sagan is perhaps the most famous scientist of his generation. He contributed greatly to the fields of astronomy, astrophysics as well as many other areas. He also helped popularise science, both through his books and through his television series, The Cosmos, which was first broadcast in 1980. In this module, he will teach of the many wonders of our universe.', 'kh_thecosmos.jpg', 'Science'),
(76, 'Freedom of Software, by Mark Shuttleworth', 'Kieran Parker', 'Mark Shuttleworth, technology entrepreneur and former CEO of Ubuntu, the most popular Linux distribution in the world, will be discussed about with open source software. The three main points will be covered:\r\n\r\nOpen source is the practice of releasing the source code of an application with the final product for all to see, improve on or fork into their own projects.\r\n\r\nThe future holds many opportunities for open source, with many of the worldâ€™s largest computer hardware manufacturers getting on-board with developing on current software as well as their own. The recently released Dell Sputnik developer laptop (shipping with Ubuntu in place of Windows) is an excellent example of this.\r\n\r\nWhat can we, as a consumer, do to help forward the success of open source? There are a number of positions for coders to help with coding and developing. No problem if you don''t code yourself, as there is multiple tasks always needing completion, such as bug reports and management.', 'kp_mark.jpg', 'Computing'),
(77, 'How to Eat Cereal, by Nikola Tesla', 'Kieran Parker', 'Nikola Tesla, renowned inventor and founder of the alternating current, has been vital in providing his famous cereal techniques, including how to eat on the move, prevent getting milk on yourself, and other great methods that will hopefully revolutionise how we all eat our cereal.', 'kp_tesla.jpeg', 'Food and Drink'),
(78, 'Cycling Like a Pro, by Daniel Lloyd', 'Kieran Parker', 'Daniel Lloyd, former rider of team CervÃ©lo and current presenter of the Global Cycling Network, has sent many years cycling with the pro''s, completing a number of well-earned challenges and events. Daniel has a number of great tips on how to get started with cycling, how to up your game, what bicycle suits you best, maintenance and more.\r\nThere will be a number of points covered by Lloyd, including: Physical and mental training; Riding techniques; Cycle choice; Diet', 'kp_daniel.jpg', 'Sports'),
(79, 'Vampire Diaries', 'Kirsty Louise Deary', 'Vampire Diaries is an American tv show that was first aired in 10th of September 2009. It is owned by the American network  the CW, the show has made 5 seasons and is releasing the 6th in October 2014. The main character of the show is Elena Gilbert (Nina Dobrev) she is a freshermen at highschool. Her and her brother Jeremy are getting over the death of they parents who die in a car crash, where Elena was saved from. She starts back at school where she falls in love with the dreamy new guy in Mystic Falls, Virginia but Stefen (Paul Wesley) the dreamy guy has a secret, a blood-thirsty condition that he shares with his vampire brother Damon (Ian Someralders). Elena must choice between the two bothers but will she still want any of them after she knows the secret. ', 'kld_thevampirediaries.png', 'Film and TV'),
(80, 'Zeus - Greek Mythology', 'Kirsty Louise Deary', 'Greek Myths were about the gods who controlled and ruled the elements of nature. There was the original 12 greek gods, these 12 gods were known as the Olympian because of they home on top of Mount Olympus in Greece.\r\nThe chef of gods was Zeus, he controlled heaven and carried around a thunderbolt. Zeus is married to Hera the goddess of marriage and women. \r\nPoseidon was Zeus brother and the god of the sea. He lived in an underwear palace, he had a long white beard and carried a trident.  Athena the daughter of Zeus was the goddess of wisdom and city of Athens.', 'kld_greekgod.png', 'Mythology'),
(81, 'The Wright brothers and their aircrafts', 'Kirsty Louise Deary', 'On the 17th of December 1903 over 110 years ago, the Wright brothers Orville and Wilbur invented and built the first ever airplane. Between 1905 and 1907 they developed their flying machine to have fixed-wings. The brothers started by creating gliders, in 1900 they successful tested a 50-pound glider with a wing-span of 17 foot. After this test much time and practice was put in to create the craft known as the flyer. This craft had a motor and weighed in at 700 pounds. It was launched off a moveable track. On the 17th of December 1903 Orville piloted the first successful flight that lasted 12-seconds. November the next year 1904 Wilbur flow the flyer 2 which lasted more then 5 minutes. Wilbur died at 45 in 1912 and Orville 76 in 1948. The brothers were the invents of the first piloted aircraft.', 'kld_thewrightbrothers.png', 'History'),
(82, 'Takamine History - Born of new Acoustic Star', 'Krzysztof Bronski', 'For more than half a century now, Takamine has proudly dedicated itself to the art of fine guitar craftsmanship. Its longstanding devotion to innovation and continual improvement has placed it among the worldâ€™s premier acoustic guitar makers, with truly fine instruments that are the first choice of performing guitarists worldwide.', 'kb_takamine.png', 'Music'),
(83, 'Scott MTB', 'Krzysztof Bronski', 'SCOTT Sports has been in the outdoor sporting world since 1958 and entered the cycling arena in 1986, with the creation of their first mountain bike.\r\nWith expertise from both skiing and motocross, SCOTTâ€™s passion and dedication to fulfil its mantra INNOVATION,TECHNOLOGY, DESIGN continued, with the revolutionary Aero Bar, taking Greg Lemond to Tour De France victory in 1989. \r\nMountain bikes have continued to set SCOTT apart from the competition, with the development of full suspension bikes and the introduction of carbon to the market. Carbon forms part of SCOTTâ€™s heritage, with a host of Carbon Design Experts and a dedicated carbon factory to protect the unique, high quality building process that goes towards creating world-class bikes, encompassing road, TT and mountain. \r\nBoth in the UK and globally, SCOTT have cycling as part of their lifestyle, with lunchtime rides a regular part of working life and a sporting commonality between employees, whether theyâ€™re a cyclist, runner', 'kb_scott.png', 'Sports'),
(84, 'Yngwiee  Malmstein', 'Krzysztof Bronski', 'Yngwie Johan Malmsteen - born Lars Johan Yngve LannerbÃ¤ck, 30 June 1963) is a Swedish guitarist, songwriter, multi-instrumentalist and bandleader. Malmsteen became known for his neo-classical playing style in heavy metal. Malmsteen has been a longtime user of Fender Stratocasters. His most famous Stratocaster is his 1972 blonde Strat, nicknamed "The Duck" because of its yellow finish and the Donald Duck stickers on the headstock. An alternative nickname for this guitar is "Play Loud" due to a sticker on the upper horn of the guitar. Fender made 100 replica copies of this guitar and marketed it as the "Play Loud Guitar". He also has a signature Stratocaster. It comes in a Vintage White finish with a maple neck, either a maple or rosewood fretboard with scalloped frets and, from 2010, Seymour Duncan STK-S10 YJM "Fury" Model pickups. There is also a signature YJM100 Marshall amplifier, based on the 1959 amplifier range.', 'kb_yngwieemalmstein.png', 'Music'),
(85, 'A guide to Netflix', 'Lauren Edwardson', 'A guide to Netflix will allow students to study the making of Netflix and how to get the best out of Netflix. Students will work on building there Netflix homepage which will produce the best results for themselves. Students must also review a number of movies and TV shows.', 'le_netflix.jpg', 'Film and TV'),
(86, 'How to take the perfect selfie', 'Lauren Edwardson', 'How to take the â€˜perfectâ€™ selfie will show students how to take self-portraits. Students will learn what lighting should be used, how to angle the camera, their face and body. Students will be assessed on how well they can incorporate these things into a selfie.', 'le_selfie.jpg', 'Art'),
(87, 'Go Karting', 'Lauren Edwardson', 'This module is the perfect stepping stone for students who foresee a future in higher echelons of motorsports. This module will teach the safety procedures necessary when go karting and how to drive go karts. Students will start off in the smallest go kart engine size however as studentsâ€™ progress go karts will get larger. Students will regularly take part races.', 'le_gokarting.jpg', 'Sports'),
(88, 'Travel and Tourism', 'Lauren McDougall', 'This module provides detailed coverage on different aspects of the travel industry and develops an understanding of the tourism sector. This will include Retail Travel, Air Travel, Tourist Destinations, Tourism, Marketing and Communication. This module will help on building organizational skills and help show the importance of team work and the main issues involved when organising a tourism event.', 'lmcd_travelandtourism.jpg', 'Travel'),
(89, 'Spanish', 'Lauren McDougall', 'The aim of this module is to enhance students knowledge of Spanish. This module will improve the students basic understanding of Spanish, it will also help to develop students communication and presentation skills in both English and Spanish. This module will enhance the students understanding of Spanish that they should be able to fluently speak Spanish, and interpret between Spanish and English.', 'lmcd_spanish.jpg', 'Language'),
(90, 'Interior Design', 'Lauren McDougall', 'In this module you will learn what the role of an interior designer actually is. Interior Design requires that you are imaginative and creative and can work well as a team. Interior Design is a new role within the construction industry, however they are highly relied on now by the clients. This module will help you think more creatively, enhance your ICT skills, enhance your communication and presentation skills, help you work better in a team, get you to produce professional like drawings and modules for coursework projects.', 'lmcd_interiordesign.jpg', 'Art'),
(91, 'Barclays premier league teams', 'Lewis Sidebotham', 'All the teams who have been in the Barclays Premier League since its inception', 'ls_bpl.jpg', 'Sports'),
(92, 'Video Game consoles', 'Lewis Sidebotham', 'All of the home consoles since the 1970s', 'ls_vgc.jpg', 'Gaming'),
(93, 'Simpsons characters', 'Lewis Sidebotham', 'All of the main recurring Simpson characters to appear on the show since Dec 1989', 'ls_simpsons.jpg', 'Film and TV'),
(94, 'Eating vitamins and saying prayers', 'Lewis Wardle', 'Taught by wrestling legend, Hulk Hogan, the course consists of information and advice on all aspects of becoming a wrestler.', 'lw_hulkhogan.jpg', 'Sports'),
(95, 'Becoming a legendary frontman', 'Lewis Wardle', 'Taught by legendary musician, Ian Brown, of The Stone Roses, the course consists of information and advice on following in his footsteps to become a legendary frontman in a band.', 'lw_ianbrown.jpg', 'Music'),
(96, 'Extreme Gardening', 'Lewis Wardle', 'Taught by TV gardener, Alan Titchsmarsh, this course is designed to give students an insight into the world of â€œExtreme Gardeningâ€.', 'lw_titchsmarsh.jpg', 'Gardening'),
(97, 'Impressionism - Vincent van Gogh', 'Luke Belcourt', 'The course of this module is dedicated to the use of bright colours and metaphor within painting.', 'lb_starrystarrynight.jpg', 'Art'),
(98, 'Practical Magic - Harold Potter', 'Luke Belcourt', 'Content warning for occult practices. No house elves were harmed during the making of this module.', 'lb_magic.png', 'Entertainment'),
(99, 'How To Build An Enterprise - Walter White', 'Luke Belcourt', 'This module is about finding a niche product which can fill a large market gap for maximum profits.', 'lb_enterprise.jpg', 'Business'),
(100, 'Glaswegian Architecture', 'Martin Conway', 'Glasgow has a multitude of architectural masterpieces including the Kelvingrove Art Galleries, Hamden Park, and the Peopleâ€™s Palace. It was also home to a multitude of famous architects such as Charles Rennie Mackintosh.', 'mc_mackintosh.png', 'Architecture'),
(101, 'Smartphones', 'Martin Conway', 'Over the past five years the use of smartphones has skyrocketed making them one of the bestselling electronic devices of all time. There are several different Operating Systems used on smartphones, primarily being Appleâ€™s iOS and Googleâ€™s Android.', 'mc_smartphones.png', 'Technology'),
(102, 'Retro Videogames', 'Martin Conway', 'Video games have come a long way since their inception, coming from single dots on the screen to full HD displays. This module will cover games from previous console generations and the development of them into todayâ€™s visual masterpieces.', 'mc_retrovideogames.png', 'Gaming'),
(103, 'String instruments (Guitars)', 'Martin McGoldrick', 'In the module Students will learn to use string instruments such as the Guitar or Bass Guitar. They will be taught various musical techniques and how to enact them absolute correctness.', 'mmcg_guitar.gif', 'Music'),
(104, 'Food preparation', 'Martin McGoldrick', 'In the module Students will learn how to prepare food in the kitchen. They will learn the basics of sanitation and cleanliness in the kitchen. They will also be taught on the basics of cooking various meals.', 'mmcg_cooking.jpg', 'Food and Drink'),
(105, 'Painting', 'Martin McGoldrick', 'In this module students will be unleash their creativity with the use of paint and canvas, they will build upon and refine their artistic techniques. They will also learn the more advanced methods of painting and will endeavour to create their own art.', 'mmcg_painting.jpg', 'Art'),
(106, 'Introduction to basketball', 'Michael Gourlay', 'In this module the student will be provided with the basic knowledge of a basic basketball skill set, to which they can implement and progress on their own basic skill set of passing dribbling shooting and defence.', 'mg_basketball.jpg', 'Sports'),
(107, 'music reviews ', 'Michael Gourlay', 'in this module the student will learn about musical albums and how to properly review the contents within them in the form of the flow of the album and progression of previous material in that genre/previous albums.', 'mg_queenii.jpg', 'Music'),
(108, 'cooking for intermediates', 'Michael Gourlay', 'In the module the student will follow on from the previous module of cooking for beginners, taking a more in depth look at flavouring, seasoning and combination of different styles learned in the previous module.', 'mg_pasta.jpg', 'Food and Drink'),
(109, 'Web Programming 2', 'Miguel Landu', 'Teaches very important concept on  how to create a websites, from basic to more complex  principles, like how to integrate a database on web, and how use different technologies and frameworks', 'ml_webprogramming2.jpg', 'Computing'),
(110, 'IT Project Management 2', 'Miguel Landu', 'Teaches business principles, how an organisation is structure and works, and what different roles are available, and what requirements need to fill out those roles.', 'ml_itprojectmanagement2.jpg', 'Computing'),
(111, 'Honours Research & Project Methods Module', 'Miguel Landu', 'Teaches how to became  independent learner , how to do an deep and more precise investigation  on your honour subject , how to schedule and planning  the project in an efficient ways', 'ml_honoursresearchandprojectmethods.jpg', 'Computing'),
(112, 'Web Programing2', 'Mohammed Youssouf Ali', 'The appropriate module is to facilitate to build up a modern and more powerful web site, using open-source, PHP SCRIPTING LANGUAGE AND MySQL database .the course include the fundamental of programing with PHP relational, Database design and operation with MySQL and web solution using PHP and MySQL.', 'mya_webprogramming2.jpg', 'Computing'),
(113, 'Softwar Practice and process', 'Mohammed Youssouf Ali', 'This module provides detailed coverage of the processes and practices used in the development and evolution of software Systems. Coverage includes modern approaches to the software process such as the Unified Process (UP) and Agiledevelopment.', 'mya_softwareprocessandpractice.jpg', 'Computing'),
(114, 'Database development', 'Mohammed Youssouf Ali', 'This module gives better understanding of the technique in term of designing and implementing  in order to relational Database system .this include the generalisation of the detailed principal relational Data modelling ,data definition , and querying using SQL, database application, database admin, security and the distribution of database.', 'mya_databasedevelopment.jpg', 'Computing'),
(115, 'Urban Architecture', 'Oksana Kalinova', 'The program includes the theory and history of architecture, urban planning, philosophy and social sciences, practical training under the guidance of leading architects, study of modern technologies, structures and materials, study of the legislative framework of architectural practice and management.', 'ok_architecture.jpg', 'Architecture'),
(116, 'Modern Art and Design', 'Oksana Kalinova', 'Our program offers a wide range of disciplines in Art and Design sphere: painting, fine arts, sculpture, graphic design, design of interiors, spaces and surfaces, textile design, fashion design and styling, three-dimensional design.', 'ok_heads.jpg', 'Art'),
(117, 'Digital Photography', 'Oksana Kalinova', 'The program includes the theory and techniques of photography, history of photography and its contemporary aspects, practical techniques of digital image processing, techniques of B/W (black-and- white) photos and professional issues in professional photography.', 'ok_camera.jpg', 'Art'),
(118, 'Why The Beatles are the best', 'Paul Owens', 'This module will look at all aspects concerning the life and times of The Beatles and why they are the greatest musical achievement of all time. The module will cover the history of the band beginning in Liverpool in the 1960â€™s to their surviving members and their contributions to the modern world. We will also discuss in length how all bands ever are basically just trying to copy the beatles.', 'po_thebeatles.jpg', 'Music'),
(119, 'John Wayne the Greatest', 'Paul Owens', 'This module of the course will cover the life of John Wayne. The module will cover all his greatest movies and how he portrayed so many historic characters. What made John Wayne so distinctive? Why he is still important in todayâ€™s culture?', 'po_johnwayne.jpg', 'Film and TV'),
(120, 'Sean Connery: The Greatest Scot', 'Paul Owens', 'This module will allow students the chance to learn about the greatest and most recognised Scottish actor in history. From his instantly recognisable voice to his massive contributions to acting this module will enhance anyone knowledge of Sean.', 'po_seanconnery.jpg', 'Film and TV'),
(124, 'Paisley', 'Ross Dickson', 'A town in Scotland seven or so miles from Glasgow, The town is situated at the northern edge of the glenniffer braes, straddling the white cart river.', 'rd_paisley.jpg', 'Travel'),
(125, 'Richard Dawkins', 'Ross Dickson', 'Born on the 26th of March 1941 as Clinton Richard Dawkins, he is best known as an Ethologist, Evolutionary Biologist and writer.', 'rd_richarddawkins.jpg', 'Science'),
(126, 'Taipei 101', 'Ross Dickson', 'Formerly the world tallest building, Taipei 101 is the most famous building in Taiwan`s Capital (Taipei).  The building comprises of 101 floors above ground, and 5 below.', 'rd_taipei101.jpg', 'Architecture'),
(127, 'Jose Mourinho - The Special One', 'Scott Wylie', 'A chance to learn about arguably one of the greatest managers there has ever been in the world of football. Witty interviews and arrogance included.', 'sw_josemourinho.jpg', 'Sports'),
(128, 'Red Hot Chili Peppers - 30 years on', 'Scott Wylie', 'From number one albums to major drug battles, an insight into the Red Hot Chili Peppers (Not the Red Hot Chili Pipers).', 'sw_redhotchilipeppers.jpg', 'Music'),
(129, 'Rick Grimes - Surviving a zombie apocalypse', 'Scott Wylie', 'A module based on the TV series â€œThe Walking Deadâ€ and itâ€™s main character Rick Grimes. Thankfully, Carl isnâ€™t included.', 'sw_thewalkingdead.jpg', 'Film and TV'),
(130, 'Art Attack', 'Shannon Middleton', 'This module consists of all things arts and crafts. Learn to make anything from old junk lying around the house and turn it into something new and cool. Prepare to get messy.', 'sm_paint.jpg', 'Art'),
(131, 'Out & About', 'Shannon Middleton', 'Explore the outside world with fun in games in this fun packed outdoor activities. Loads of outdoor games and activities to keep you fit and active and enjoy being outside.', 'sm_footballgirl.jpg', 'Sports'),
(132, 'What''s the story?', 'Shannon Middleton', 'Here you will explore the world or reading. Loads of books to read and enjoy & learn lots of new things.  Discover new authors and the latest books to read.', 'sm_books.jpg', 'Literature'),
(133, 'Iraq at a Glance', 'Shatha Hameed', 'Iraq is one of the Arabic states which located in the west south of the Asian continent. Umm Qasr is the crucial Iraq seaport on the Arabian Gulf. The two rivers "Tigris" and "Euphrates" passes from the north of country to the south where the merge together to form Shatt al-Arab.', 'sh_iraqataglance.gif', 'Travel'),
(134, 'Baghdad', 'Shatha Hameed', 'Baghdad is the capital of Iraq, with an estimated population of 8 millions. The name of Baghdad used to evoke images of Arabian Nights. The fairytale city it once was, capital of the Abbasid Caliphate, was destroyed by the Mongol invaders in 1258. Baghdad did recover and has always played an important role in Arab cultural life and has been the home of noted writers, musicians and visual artists.', 'sh_baghdad.gif', 'Travel'),
(135, 'Mosul', 'Shatha Hameed', 'Mosul, 400 km north of Baghdad, is Iraq''s 2nd largest city, a center for the tourist resorts of northern Iraq. It is called Um Al-Rabi''ain (The City of Two Springs), because autumn and spring are very much alike there. The original city stands on the west bank of the Tigris River, opposite the ancient Assyrian city of Nineveh on the east bank.', 'sh_mosul.gif', 'Travel');
INSERT INTO module (module_id, module_title, module_leader, module_description, module_image, module_category) VALUES
(136, 'British Architecture', 'Shaun Geraghty', 'Detailed module covering a vast range of iconic landmarks and building throughout Britain, with a particular focus on Glasgow and its historical architecture', 'sg_glasgowarchitecture.jpg', 'Architecture'),
(137, 'History of Marvel', 'Shaun Geraghty', 'Module following the history of Marvel Comics from itâ€™s creation and creator Stan Lee, through the creation and development of itâ€™s most iconic characters all the way through to todays big budget blockbuster movies.', 'sg_marvel.jpg', 'Art'),
(138, 'Effects of Video Games', 'Shaun Geraghty', 'Module focused on the effect video games has on todays children and adults. Itâ€™s increasing popularity and the scientific evidence behind itâ€™s effects on individuals.', 'sg_controller.jpg', 'Gaming'),
(139, 'Gorillaz', 'Stuart Lockhart', 'Gorillaz is the most successful virtual band ever, fronted by four wildly talented but totally disparate characters: pretty-but-vacant singer 2D, satanic bassist Murdoc Niccals, Japanese guitar prodigy Noodle and amiable man-mountain drummer Russel Hobbs.\r\n\r\nThe band''s 2001 debut album Gorillaz sold over seven million copies and earned them an entry in the Guinness Book of World Records as the Most Successful Virtual Band. It was nominated for the Mercury Prize in 2001, but the nomination was later withdrawn at the band''s request. They have released 4 studio albums.', 'sl_gorillaz.jpg', 'Music'),
(140, 'Bryan Cranston', 'Stuart Lockhart', 'Bryan Lee Cranston is an American actor, voice actor, screenwriter, director, and producer. He is known for portraying Walter White in the crime drama series Breaking Bad for which he has won four consecutive Outstanding Lead Actor in a Drama Series Emmy Awards. he is also known for the portrayal of Hal in the comedy series Malcolm in the Middle.\r\n\r\nBryan Cranston was born in Canoga Park, California, to Audrey Peggy Sell, a radio actress, and Joseph Louis Cranston, who was also an actor.', 'sl_bryancranston.jpg', 'Film and TV'),
(141, 'Hugo Chavez', 'Stuart Lockhart', 'Hugo Rafael ChÃ¡vez FrÃ­as was a Venezuelan politician and the President of Venezuela from 1999 until his death in 2013. He was the leader of the Fifth Republic Movement from its foundation in 1997 until 2007, when it merged with several other parties to form the United Socialist Party of Venezuela (PSUV), which he led until 2012.\r\n\r\nHuge Chavez is a man who was adorned by much of  the Venezuelan people, though comes under international criticism. Much of this critisism comes from britiain and the US and stems form the fact that he didn''t allow the US and British oil corporations to exploit the resources of his country at a discounted/privileged price.', 'sl_hugochavez.jpg', 'Politics'),
(142, 'Scottish Enlightenment', 'Stuart McLay', 'An in-depth look at historical Scottish figures from the 18th century that shaped Scotland from Economics to Poetry all the way through to Engineering and Philosophy.  This module will introduce historical figures such as the 18th Century Scottish Philosopher David Hume, Economist and Philosopher Adam Smith, Inventor and Mechanical Engineer James Watt, Geologist James Hutton, poet and songwriter Alison Rutherford. The Module will include a discussion and evaluation on what they brought to the world as we now know it and how the world viewed them at the time, what were they like in person (Devine, et al., 2014).', 'smcl_thegoldenage.png', 'History'),
(143, 'Truth or Fiction', 'Stuart McLay', 'According to Conspiracy Theorists the world we live in may not be as it seems, are Governments controlled by Corporations and Bankers? Is there a hidden agenda? Is there a secret organisations stemming from the Knights Templar, the Freemasons and Illuminati through to the 13 families suspected of owning 99% of the worldâ€™s wealth?  The Module will focus on some the most famous Conspiracy theories ranging from the first man on the moon, corporate bankers, money mechanics and symbolism through to the occult, famous TV, Film and Music stars that are now viewed to be part of the conspiracy.', 'smcl_truthorfiction.png', 'History'),
(144, 'I think therefore I am', 'Stuart McLay', 'In this Module we take a look at the different schools of philosophy and ethics, what are ethics and how can they be put into practice.  We look at the three ethical theories e.g. applied ethics which deals with capital punishment, war and animal rights etc.  Normative Ethics which is concerned with the content of moral Judgments and the criteria for what is right and what is wrong.  Meta Ethics which deals with the nature of moral judgment the origins and meaning of ethical principles.  The module will also cover the dilemmas of how to live a good life, our rights and responsibilities, the language of right and wrong and moral decisions i.e. what is good and what is bad (BBC, 2014)', 'smcl_phylosophy.png', 'Philosophy');

DROP TABLE IF EXISTS module_keyword;
CREATE TABLE IF NOT EXISTS module_keyword (
  module_id int(11) NOT NULL,
  keyword_id int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

INSERT INTO module_keyword (module_id, keyword_id) VALUES
(1, 265),
(1, 266),
(1, 295),
(1, 373),
(1, 375),
(1, 476),
(1, 566),
(1, 606),
(2, 12),
(2, 31),
(2, 45),
(2, 172),
(2, 293),
(2, 320),
(2, 369),
(2, 506),
(2, 619),
(2, 626),
(3, 141),
(3, 142),
(3, 254),
(3, 292),
(3, 293),
(3, 339),
(3, 351),
(3, 395),
(3, 477),
(3, 536),
(3, 563),
(4, 54),
(4, 78),
(4, 294),
(4, 373),
(4, 392),
(4, 456),
(5, 62),
(5, 75),
(5, 156),
(5, 291),
(5, 387),
(5, 432),
(5, 457),
(5, 480),
(5, 488),
(5, 589),
(5, 590),
(5, 605),
(5, 630),
(6, 27),
(6, 355),
(6, 356),
(6, 418),
(6, 502),
(6, 548),
(6, 603),
(6, 616),
(7, 251),
(7, 461),
(7, 501),
(8, 52),
(8, 74),
(8, 467),
(8, 488),
(9, 251),
(9, 488),
(9, 591),
(10, 120),
(10, 121),
(10, 196),
(10, 246),
(10, 401),
(10, 535),
(11, 113),
(11, 124),
(11, 167),
(11, 443),
(12, 87),
(12, 181),
(12, 182),
(12, 192),
(12, 582),
(12, 596),
(13, 36),
(13, 406),
(13, 445),
(14, 278),
(14, 488),
(15, 27),
(15, 73),
(15, 279),
(16, 221),
(16, 488),
(16, 534),
(17, 49),
(17, 327),
(17, 573),
(18, 43),
(18, 373),
(18, 488),
(19, 125),
(19, 304),
(19, 352),
(19, 483),
(20, 265),
(20, 278),
(20, 373),
(20, 424),
(20, 468),
(21, 41),
(21, 125),
(21, 193),
(21, 352),
(21, 483),
(21, 561),
(22, 126),
(22, 374),
(22, 456),
(22, 537),
(23, 535),
(23, 558),
(23, 567),
(23, 581),
(24, 92),
(24, 367),
(24, 550),
(25, 212),
(25, 354),
(25, 538),
(26, 278),
(26, 373),
(26, 468),
(27, 11),
(27, 232),
(27, 534),
(28, 29),
(28, 122),
(28, 260),
(28, 391),
(28, 415),
(29, 184),
(29, 274),
(29, 498),
(29, 587),
(29, 593),
(30, 35),
(30, 66),
(30, 217),
(30, 385),
(30, 388),
(31, 43),
(31, 148),
(31, 185),
(31, 265),
(31, 278),
(31, 368),
(31, 373),
(31, 468),
(31, 504),
(31, 524),
(31, 568),
(32, 15),
(32, 65),
(32, 95),
(32, 100),
(32, 108),
(32, 162),
(32, 174),
(32, 198),
(32, 238),
(32, 335),
(32, 356),
(32, 366),
(32, 423),
(32, 483),
(32, 542),
(32, 561),
(33, 132),
(33, 146),
(33, 147),
(33, 180),
(33, 218),
(33, 267),
(33, 278),
(33, 353),
(33, 487),
(33, 488),
(33, 490),
(33, 617),
(34, 106),
(34, 431),
(34, 623),
(34, 626),
(35, 12),
(35, 118),
(35, 369),
(35, 504),
(36, 266),
(36, 373),
(36, 375),
(36, 468),
(37, 145),
(37, 284),
(37, 285),
(37, 315),
(37, 317),
(37, 416),
(37, 422),
(38, 314),
(38, 318),
(38, 564),
(39, 25),
(39, 377),
(39, 422),
(40, 63),
(40, 532),
(40, 541),
(41, 205),
(41, 331),
(41, 399),
(42, 209),
(42, 540),
(43, 72),
(43, 221),
(43, 472),
(43, 481),
(44, 128),
(44, 246),
(44, 415),
(45, 239),
(45, 511),
(45, 561),
(46, 60),
(46, 507),
(46, 509),
(46, 513),
(46, 514),
(47, 373),
(47, 402),
(47, 505),
(47, 525),
(47, 604),
(48, 56),
(48, 136),
(48, 265),
(48, 303),
(48, 373),
(48, 525),
(48, 600),
(52, 33),
(52, 83),
(52, 167),
(52, 195),
(52, 201),
(52, 346),
(52, 450),
(52, 459),
(52, 561),
(52, 586),
(53, 4),
(53, 13),
(53, 16),
(53, 103),
(53, 165),
(53, 188),
(53, 223),
(53, 246),
(53, 372),
(53, 430),
(53, 474),
(53, 503),
(53, 535),
(53, 544),
(53, 545),
(53, 601),
(54, 37),
(54, 112),
(54, 152),
(54, 299),
(54, 305),
(54, 310),
(54, 330),
(54, 383),
(54, 396),
(54, 401),
(54, 442),
(54, 496),
(54, 518),
(54, 608),
(55, 76),
(55, 88),
(55, 207),
(55, 362),
(55, 363),
(56, 97),
(56, 110),
(56, 111),
(56, 207),
(56, 208),
(56, 321),
(56, 413),
(57, 0),
(57, 104),
(57, 189),
(57, 200),
(57, 226),
(57, 231),
(57, 413),
(57, 471),
(58, 46),
(58, 131),
(58, 160),
(58, 225),
(58, 376),
(58, 475),
(58, 612),
(58, 614),
(58, 633),
(59, 127),
(59, 197),
(59, 326),
(59, 384),
(59, 404),
(59, 451),
(59, 515),
(60, 91),
(60, 161),
(60, 173),
(60, 458),
(61, 105),
(61, 191),
(61, 243),
(61, 244),
(61, 268),
(61, 360),
(61, 445),
(62, 51),
(62, 145),
(62, 167),
(62, 268),
(62, 284),
(62, 315),
(62, 317),
(62, 518),
(62, 613),
(63, 34),
(63, 38),
(63, 168),
(63, 314),
(63, 361),
(63, 445),
(64, 49),
(64, 278),
(64, 341),
(64, 426),
(64, 575),
(64, 590),
(65, 188),
(65, 278),
(65, 390),
(65, 444),
(65, 492),
(65, 591),
(66, 241),
(66, 242),
(66, 244),
(66, 245),
(66, 454),
(67, 61),
(67, 204),
(67, 213),
(67, 214),
(67, 273),
(67, 286),
(67, 579),
(67, 580),
(68, 20),
(68, 24),
(68, 84),
(68, 151),
(68, 264),
(68, 296),
(68, 486),
(68, 571),
(68, 574),
(68, 585),
(69, 94),
(69, 170),
(69, 220),
(69, 270),
(69, 271),
(69, 272),
(69, 286),
(69, 287),
(69, 288),
(69, 344),
(70, 336),
(70, 365),
(70, 373),
(70, 453),
(71, 132),
(71, 218),
(71, 269),
(72, 183),
(72, 452),
(72, 508),
(73, 2),
(73, 3),
(73, 5),
(73, 7),
(73, 8),
(73, 30),
(73, 101),
(73, 102),
(73, 150),
(73, 236),
(73, 373),
(73, 398),
(73, 456),
(73, 527),
(73, 595),
(74, 85),
(74, 212),
(74, 240),
(74, 328),
(74, 380),
(74, 420),
(74, 421),
(74, 438),
(74, 632),
(74, 636),
(75, 47),
(75, 48),
(75, 134),
(75, 379),
(75, 423),
(75, 429),
(75, 483),
(75, 484),
(75, 485),
(75, 529),
(75, 539),
(76, 227),
(76, 229),
(76, 238),
(76, 349),
(76, 518),
(76, 559),
(76, 561),
(77, 96),
(77, 187),
(77, 283),
(77, 386),
(77, 463),
(77, 464),
(77, 560),
(78, 64),
(78, 153),
(78, 154),
(78, 155),
(78, 169),
(78, 439),
(78, 440),
(78, 465),
(78, 560),
(78, 577),
(78, 578),
(79, 68),
(79, 177),
(79, 281),
(79, 324),
(79, 385),
(79, 551),
(79, 562),
(79, 594),
(80, 255),
(80, 256),
(80, 262),
(80, 275),
(80, 378),
(80, 400),
(80, 569),
(81, 21),
(81, 428),
(81, 625),
(82, 10),
(82, 43),
(82, 248),
(82, 265),
(82, 323),
(82, 343),
(82, 373),
(82, 479),
(82, 528),
(82, 543),
(82, 549),
(82, 555),
(83, 18),
(83, 64),
(83, 90),
(83, 143),
(83, 176),
(83, 222),
(83, 224),
(83, 249),
(83, 342),
(83, 370),
(83, 397),
(83, 489),
(83, 552),
(84, 210),
(84, 265),
(84, 408),
(84, 468),
(84, 482),
(84, 523),
(84, 546),
(84, 553),
(84, 557),
(84, 631),
(85, 301),
(85, 382),
(85, 587),
(86, 86),
(86, 300),
(86, 421),
(86, 497),
(87, 183),
(87, 253),
(87, 322),
(87, 452),
(88, 19),
(88, 22),
(88, 23),
(88, 144),
(88, 572),
(88, 583),
(88, 584),
(89, 309),
(89, 364),
(89, 530),
(90, 129),
(90, 139),
(90, 307),
(90, 308),
(91, 42),
(91, 202),
(91, 333),
(91, 348),
(91, 615),
(92, 115),
(92, 178),
(92, 449),
(92, 512),
(92, 628),
(93, 17),
(93, 57),
(93, 280),
(93, 338),
(93, 381),
(93, 499),
(94, 535),
(94, 578),
(94, 624),
(95, 233),
(95, 373),
(95, 375),
(95, 505),
(96, 247),
(96, 282),
(96, 329),
(97, 114),
(97, 186),
(97, 211),
(97, 328),
(97, 410),
(97, 417),
(97, 510),
(98, 80),
(98, 98),
(98, 149),
(98, 276),
(98, 345),
(98, 433),
(98, 607),
(99, 69),
(99, 89),
(99, 130),
(99, 235),
(99, 365),
(99, 434),
(100, 41),
(100, 43),
(100, 148),
(101, 125),
(101, 561),
(102, 43),
(102, 125),
(102, 246),
(103, 59),
(103, 265),
(103, 303),
(103, 373),
(103, 549),
(104, 99),
(104, 107),
(104, 218),
(104, 219),
(104, 257),
(104, 325),
(104, 478),
(105, 14),
(105, 43),
(105, 44),
(105, 81),
(105, 165),
(105, 409),
(106, 58),
(106, 163),
(106, 179),
(106, 414),
(106, 500),
(107, 26),
(107, 216),
(107, 250),
(107, 302),
(107, 373),
(107, 446),
(107, 462),
(108, 117),
(108, 132),
(108, 215),
(108, 495),
(109, 32),
(109, 164),
(109, 166),
(109, 225),
(109, 437),
(109, 445),
(109, 561),
(109, 564),
(110, 135),
(110, 346),
(110, 358),
(110, 441),
(110, 447),
(110, 460),
(110, 466),
(110, 470),
(111, 9),
(111, 298),
(111, 311),
(111, 319),
(111, 334),
(111, 427),
(111, 459),
(111, 570),
(112, 609),
(112, 610),
(112, 611),
(112, 612),
(113, 519),
(113, 520),
(113, 521),
(113, 522),
(114, 157),
(114, 159),
(114, 161),
(115, 40),
(115, 41),
(115, 82),
(115, 561),
(115, 592),
(116, 43),
(116, 93),
(116, 114),
(116, 140),
(116, 165),
(116, 258),
(116, 306),
(116, 411),
(116, 493),
(117, 53),
(117, 67),
(117, 85),
(117, 140),
(117, 171),
(117, 421),
(118, 3),
(118, 55),
(118, 77),
(118, 188),
(118, 340),
(118, 373),
(118, 565),
(119, 6),
(119, 137),
(119, 261),
(119, 277),
(119, 297),
(119, 316),
(120, 1),
(120, 206),
(120, 313),
(120, 491),
(120, 494),
(120, 618),
(124, 278),
(124, 425),
(124, 488),
(124, 576),
(125, 175),
(125, 199),
(125, 203),
(125, 627),
(126, 41),
(126, 82),
(126, 554),
(127, 109),
(127, 221),
(127, 346),
(127, 347),
(127, 531),
(127, 535),
(128, 237),
(128, 373),
(128, 469),
(129, 588),
(129, 634),
(129, 635),
(130, 43),
(130, 116),
(130, 138),
(130, 234),
(130, 252),
(130, 409),
(130, 412),
(131, 221),
(131, 234),
(131, 244),
(131, 393),
(131, 407),
(131, 473),
(132, 50),
(132, 71),
(132, 234),
(132, 455),
(132, 544),
(133, 583),
(134, 104),
(134, 583),
(135, 104),
(135, 583),
(136, 40),
(136, 41),
(136, 259),
(136, 278),
(137, 119),
(137, 275),
(137, 278),
(137, 350),
(137, 436),
(137, 533),
(137, 629),
(138, 128),
(138, 359),
(138, 517),
(138, 526),
(138, 598),
(138, 599),
(139, 28),
(139, 190),
(139, 468),
(140, 12),
(140, 274),
(140, 556),
(141, 70),
(141, 332),
(141, 516),
(142, 188),
(142, 194),
(142, 263),
(142, 278),
(142, 488),
(143, 133),
(143, 230),
(143, 289),
(143, 365),
(143, 394),
(143, 435),
(144, 39),
(144, 198),
(144, 357),
(144, 389),
(144, 419);

DROP TABLE IF EXISTS module_student;
CREATE TABLE IF NOT EXISTS module_student (
  module_id int(11) NOT NULL,
  student_id int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

INSERT INTO module_student (module_id, student_id) VALUES
(1, 1),
(2, 10);

DROP TABLE IF EXISTS student;
CREATE TABLE IF NOT EXISTS student (
student_id int(11) NOT NULL,
  student_title varchar(5) DEFAULT NULL,
  student_name varchar(50) NOT NULL,
  student_DOB date NOT NULL,
  student_image varchar(150) DEFAULT NULL
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=3 ;

INSERT INTO student (student_id, student_title, student_name, student_DOB, student_image) VALUES
(1, 'Mr', 'Xavi Hernandez', '1976-10-11', 'xavihernandez.jpg'),
(2, 'Mrs', 'Carly Simon', '1956-03-17', 'carlysimon.jpg');


ALTER TABLE keyword
 ADD PRIMARY KEY (keyword_id);

ALTER TABLE module
 ADD PRIMARY KEY (module_id);

ALTER TABLE module_keyword
 ADD PRIMARY KEY (module_id,keyword_id);

ALTER TABLE module_student
 ADD PRIMARY KEY (module_id,student_id);

ALTER TABLE student
 ADD PRIMARY KEY (student_id);


ALTER TABLE keyword
MODIFY keyword_id int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=637;
ALTER TABLE module
MODIFY module_id int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=145;
ALTER TABLE student
MODIFY student_id int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=3;

GRANT ALL ON mlglpku2014.* to 'moduleadmin'@'localhost' identified by 'moduleadmin';

