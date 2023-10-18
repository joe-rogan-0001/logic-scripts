CREATE TABLE IF NOT EXISTS `av_items` (
  `job` varchar(50) NOT NULL,
  `name` varchar(50) NOT NULL,
  `label` varchar(50) DEFAULT NULL,
  `type` varchar(50) DEFAULT NULL,
  `image` longtext DEFAULT NULL,
  `description` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`name`),
  KEY `job` (`job`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE IF NOT EXISTS `av_restaurants` (
  `name` varchar(50) NOT NULL,
  `job` varchar(50) DEFAULT NULL,
  `type` varchar(50) DEFAULT NULL,
  `data` longtext DEFAULT NULL,
  PRIMARY KEY (`name`),
  KEY `name` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE IF NOT EXISTS `av_society` (
  `job` varchar(50) DEFAULT NULL,
  `money` varchar(50) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

ALTER TABLE `av_items` ADD COLUMN IF NOT EXISTS `weight` varchar(50) NULL DEFAULT NULL COLLATE 'utf8mb4_general_ci';
ALTER TABLE `av_items` ADD COLUMN IF NOT EXISTS `ingredients` longtext NULL DEFAULT NULL COLLATE 'utf8mb4_general_ci';