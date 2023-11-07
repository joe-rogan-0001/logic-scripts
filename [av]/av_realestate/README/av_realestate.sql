CREATE TABLE IF NOT EXISTS `av_realestate` (
  `groupName` varchar(50) NOT NULL DEFAULT '',
  `type` varchar(50) DEFAULT NULL,
  `identifier` varchar(50) DEFAULT NULL,
  `name` varchar(50) DEFAULT NULL,
  `customer_identifier` varchar(50) DEFAULT NULL,
  `customer` varchar(50) DEFAULT NULL,
  `phone` varchar(50) DEFAULT NULL,
  `initial` text DEFAULT NULL,
  `nextDate` text DEFAULT NULL,
  `price` varchar(50) DEFAULT NULL,
  `password` varchar(4) DEFAULT '1234',
  `entrance` text DEFAULT '{}',
  `inventory` varchar(50) DEFAULT NULL,
  `interior` varchar(50) DEFAULT NULL,
  `available` int(11) DEFAULT 1,
  KEY `group` (`groupName`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;