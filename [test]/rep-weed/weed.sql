CREATE TABLE IF NOT EXISTS `weed_plants` (
`id` int(11) NOT NULL AUTO_INCREMENT,
`timestamp` varchar(255) DEFAULT NULL,
`citizenid` varchar(255) DEFAULT NULL,
`x` varchar(255) DEFAULT NULL,
`y` varchar(255) DEFAULT NULL,
`z` varchar(255) DEFAULT NULL,
`gender` int(1) DEFAULT 0,
`water` float(2) DEFAULT 10,
`strain` text DEFAULT NULL,
`harvest` int(1) DEFAULT 0,
PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8mb4;

CREATE TABLE IF NOT EXISTS `strain` (
`id` int(11) NOT NULL AUTO_INCREMENT,
`owner` varchar(255) DEFAULT NULL,
`name` varchar(255) DEFAULT NULL,
`n` int(2) DEFAULT 0,
`p` int(2) DEFAULT 0,
`k` int(2) DEFAULT 0,
`rep` int(2) DEFAULT 0,
PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8mb4;