ALTER TABLE `owned_vehicles` ADD COLUMN IF NOT EXISTS `vinscratch` INT(1) DEFAULT 0;

CREATE TABLE IF NOT EXISTS `av_boosting` (
  `identifier` varchar(50) DEFAULT NULL,
  `name` varchar(50) DEFAULT NULL,
  `photo` longtext DEFAULT NULL,
  `level` varchar(50) DEFAULT '0',
  `hacks` int(11) DEFAULT 0,
  `deliveries` int(11) DEFAULT 0,
  `time` varchar(50) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;