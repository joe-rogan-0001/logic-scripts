/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8 */;
/*!2552553 SET NAMES utf8mb4 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

CREATE TABLE IF NOT EXISTS `phone_adverts` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `company` varchar(255) COLLATE utf8mb4_turkish_ci DEFAULT NULL,
  `text` longtext COLLATE utf8mb4_turkish_ci DEFAULT NULL,
  `number` varchar(45) COLLATE utf8mb4_turkish_ci DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_turkish_ci;

/*!40000 ALTER TABLE `phone_adverts` DISABLE KEYS */;
REPLACE INTO `phone_adverts` (`id`, `company`, `text`, `number`) VALUES
	(1, 'asdgasdg', 'asdgsdga', '4161420'),
	(2, 'adsgasdga', 'sdg', '1525280873'),
	(3, 'test', 'qwe', '1525280873');
/*!40000 ALTER TABLE `phone_adverts` ENABLE KEYS */;

CREATE TABLE IF NOT EXISTS `phone_bank_logs` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `identifier` varchar(255) COLLATE utf8mb4_turkish_ci NOT NULL DEFAULT '0',
  `amount` varchar(255) COLLATE utf8mb4_turkish_ci NOT NULL DEFAULT '0',
  `comment` longtext COLLATE utf8mb4_turkish_ci NOT NULL,
  `type` varchar(255) COLLATE utf8mb4_turkish_ci DEFAULT NULL,
  `name` varchar(255) COLLATE utf8mb4_turkish_ci DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_turkish_ci;

/*!40000 ALTER TABLE `phone_bank_logs` DISABLE KEYS */;
/*!40000 ALTER TABLE `phone_bank_logs` ENABLE KEYS */;

CREATE TABLE IF NOT EXISTS `phone_cases` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `victim` varchar(255) COLLATE utf8mb4_turkish_ci NOT NULL DEFAULT '0',
  `judge` varchar(255) COLLATE utf8mb4_turkish_ci NOT NULL DEFAULT '0',
  `date` varchar(255) COLLATE utf8mb4_turkish_ci DEFAULT NULL,
  `time` varchar(255) COLLATE utf8mb4_turkish_ci DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_turkish_ci;

/*!40000 ALTER TABLE `phone_cases` DISABLE KEYS */;
/*!40000 ALTER TABLE `phone_cases` ENABLE KEYS */;

CREATE TABLE IF NOT EXISTS `phone_events` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `time` varchar(255) COLLATE utf8mb4_turkish_ci DEFAULT NULL,
  `date` varchar(255) COLLATE utf8mb4_turkish_ci DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_turkish_ci;

/*!40000 ALTER TABLE `phone_events` DISABLE KEYS */;
REPLACE INTO `phone_events` (`id`, `time`, `date`) VALUES
	(1, '20:30', '21/12/2021');
/*!40000 ALTER TABLE `phone_events` ENABLE KEYS */;

CREATE TABLE IF NOT EXISTS `phone_invoices` (
  `invoiceid` int(11) NOT NULL AUTO_INCREMENT,
  `citizenid` varchar(255) DEFAULT NULL,
  `amount` int(11) NOT NULL DEFAULT 0,
  `society` varchar(255) DEFAULT NULL,
  `title` varchar(2255) DEFAULT NULL,
  PRIMARY KEY (`invoiceid`) USING BTREE,
  KEY `citizenid` (`citizenid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*!40000 ALTER TABLE `phone_invoices` DISABLE KEYS */;
/*!40000 ALTER TABLE `phone_invoices` ENABLE KEYS */;

CREATE TABLE IF NOT EXISTS `phone_mails` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `subject` varchar(255) COLLATE utf8mb4_turkish_ci DEFAULT NULL,
  `sender` varchar(255) COLLATE utf8mb4_turkish_ci DEFAULT NULL,
  `identifier` varchar(255) COLLATE utf8mb4_turkish_ci DEFAULT NULL,
  `message` longtext COLLATE utf8mb4_turkish_ci DEFAULT NULL,
  `time` longtext COLLATE utf8mb4_turkish_ci DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_turkish_ci;

/*!40000 ALTER TABLE `phone_mails` DISABLE KEYS */;
REPLACE INTO `phone_mails` (`id`, `subject`, `sender`, `identifier`, `message`, `time`) VALUES
	(6, 'Test Subject', 'Allah', 'MWG59565', 'Test Message', '{"month":1,"year":2022,"min":21,"sec":29,"hour":5,"day":13}'),
	(7, 'Test Subject', 'Allah', 'MWG59565', 'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry\'s standard dummy text ever since the 12550s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.', '{"month":1,"year":2022,"min":21,"sec":29,"hour":5,"day":13}'),
	(8, 'Mail Testing', 'LD Phone', 'MWG59565', 'This is a test mail', '{"min":28,"hour":1,"day":15,"year":2022,"month":1,"sec":7}'),
	(9, 'Mail Testing', 'LD Phone', 'MWG59565', 'This is a test mail', '{"sec":10,"month":1,"year":2022,"min":29,"day":15,"hour":1}'),
	(16, 'Mail Testing', 'LD Phone', 'MWG59565', 'This is a test mail', '{"sec":57,"day":15,"month":1,"year":2022,"hour":21,"min":16}'),
	(17, 'Mail Testing', 'LD Phone', 'MWG59565', 'This is a test mail', '{"min":17,"day":15,"month":1,"year":2022,"hour":21,"sec":45}'),
	(18, 'Mail Testing', 'LD Phone', 'MWG59565', 'This is a test mail', '{"min":17,"day":15,"month":1,"year":2022,"hour":21,"sec":53}');
/*!40000 ALTER TABLE `phone_mails` ENABLE KEYS */;

CREATE TABLE IF NOT EXISTS `phone_messages` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `number` bigint(20) DEFAULT NULL,
  `messagenumber` bigint(20) DEFAULT NULL,
  `time` int(11) DEFAULT NULL,
  `sonmesaj` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

/*!40000 ALTER TABLE `phone_messages` DISABLE KEYS */;
REPLACE INTO `phone_messages` (`id`, `number`, `messagenumber`, `time`, `sonmesaj`) VALUES
	(56, 5354922729, 5353535565, 1643467210, 'selamın aleyküm kem küm'),
	(57, 5353535565, 5354922729, 1643466100, 'allah'),
	(59, 5354922729, 1231241244, 213, 'SA KARDESIM'),
	(60, 5354922729, 3523523523, 213, 'as'),
	(61, 4161420, 3151252215, 1644358789, 'asdg'),
	(62, 1525280873, 3151252215, 1644521531, 'asdfasdf'),
	(63, 1525280873, 1525280873, 1645200461, 'safasdg');
/*!40000 ALTER TABLE `phone_messages` ENABLE KEYS */;

CREATE TABLE IF NOT EXISTS `phone_messagesinner` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `number` bigint(20) NOT NULL DEFAULT 0,
  `gonderenumber` bigint(20) NOT NULL DEFAULT 0,
  `mesaj` varchar(255) DEFAULT NULL,
  `time` int(11) NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

/*!40000 ALTER TABLE `phone_messagesinner` DISABLE KEYS */;
REPLACE INTO `phone_messagesinner` (`id`, `number`, `gonderenumber`, `mesaj`, `time`) VALUES
	(163, 5335555555, 5354922729, '125125', 213),
	(164, 5335555555, 5354922729, 'asdfasdf', 213),
	(165, 5335555555, 5354922729, '\nasfdasdf', 213),
	(166, 5335555555, 5354922729, 'asdgfsdgasdg\n', 213),
	(167, 5335555555, 5354922729, '\n12312312312', 213),
	(168, 5335555555, 5354922729, 'asdfasdf', 213),
	(169, 5335555555, 5354922729, 'qweqwe', 213),
	(170, 5353535565, 5354922729, 'testtt', 1643467210),
	(171, 5354922729, 5353535565, 'allah', 1643466100),
	(172, 5353535565, 5354922729, 'deneme allah yok', 1643547915),
	(173, 5353535565, 5354922729, 'qwe', 1643629486),
	(174, 5353535565, 5354922729, 'asdfasdg', 1643630175),
	(175, 5353535565, 5354922729, '\nagasdgasdasdh', 1643630181),
	(176, 5353535565, 5354922729, '-test\n', 1643897948),
	(177, 5353535565, 5354922729, 'qwe', 1643898040),
	(178, 5353535565, 5354922729, 'asdfasdg', 213),
	(179, 5353535565, 5354922729, 'asdg', 213),
	(180, 5353535565, 5354922729, 'qw\n', 213),
	(181, 5353535565, 5354922729, 'asd', 213),
	(182, 5353535565, 5354922729, 'gg', 213),
	(183, 5353535565, 5354922729, 'ggg', 213),
	(184, 5353535565, 5354922729, 'ggg', 213),
	(185, 5353535565, 5354922729, 'asdgasdh', 213),
	(186, 5353535565, 5354922729, 'asdg', 213),
	(187, 5353535565, 5354922729, '\n', 213),
	(188, 5353535565, 5354922729, '\n', 213),
	(189, 5353535565, 5354922729, '.', 213),
	(190, 5353535565, 5354922729, '  ', 213),
	(191, 5353535565, 5354922729, '\n ', 213),
	(192, 5353535565, 5354922729, '\n ', 213),
	(193, 1231241244, 5354922729, 'SA KARDESIM', 213),
	(194, 3523523523, 5354922729, 'sa', 213),
	(195, 3523523523, 5354922729, 'as', 213),
	(196, 5353535565, 5354922729, 'yarrami ye', 213),
	(197, 5353535565, 5354922729, 'selamın aleyküm kem küm', 1644252996),
	(198, 3151252215, 4161420, 'test', 1644358789),
	(199, 3151252215, 4161420, 'asdg', 1644517676),
	(200, 3151252215, 1525280873, 'asdgasdhasd', 1644521531),
	(201, 3151252215, 1525280873, 'test', 1645200326),
	(202, 3151252215, 1525280873, 'asdfasdf', 1645200386),
	(203, 1525280873, 1525280873, 'test', 1645200461),
	(204, 1525280873, 1525280873, 'qwe', 1645200479),
	(205, 1525280873, 1525280873, 'safasdg', 1645200529);
/*!40000 ALTER TABLE `phone_messagesinner` ENABLE KEYS */;

CREATE TABLE IF NOT EXISTS `phone_tweets` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `identifier` varchar(255) COLLATE utf8mb4_turkish_ci DEFAULT NULL,
  `text` varchar(255) COLLATE utf8mb4_turkish_ci DEFAULT NULL,
  `attachment` longtext COLLATE utf8mb4_turkish_ci DEFAULT '',
  `name` varchar(255) COLLATE utf8mb4_turkish_ci DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_turkish_ci;

/*!40000 ALTER TABLE `phone_tweets` DISABLE KEYS */;
REPLACE INTO `phone_tweets` (`id`, `identifier`, `text`, `attachment`, `name`) VALUES
	(1, 'steam:11000011a333b94', 'allah varsa da anasini sikeyim', 'https://cdn.discordapp.com/attachments/727853376729120811/927160597018206258/unknown.png', NULL),
	(8, 'steam:11000011a333b94', 'asdgasdgas', 'https://cdn.discordapp.com/attachments/727853376729120811/927160597018206258/unknown.png', NULL),
	(9, 'steam:11000011a333b94', 'adgasdgasdg', '', NULL),
	(15, 'steam:11000011a333b94', 'asdfasdf', '', 'allah yok'),
	(16, 'steam:11000011a333b94', 'testt', '', 'allah yok'),
	(17, 'steam:11000011a333b94', 'RT @allah yok \n                    testt\n         ', '', 'allah yok'),
	(18, 'steam:11000011a333b94', '@allah yok\nsus amk', '', 'allah yok'),
	(19, 'steam:11000011a333b94', 'deneme', '', 'allah yok'),
	(20, 'steam:11000011a333b94', 'denemeee', '', 'Serhat Almez'),
	(21, 'steam:11000011a333b94', 'asdfasdg', '', 'Serhat Almez'),
	(22, 'steam:11000011a333b94', 'gggg', '', 'Serhat Almez'),
	(23, 'LWD56494', 'deneme', '', 'Tuna Boz'),
	(24, 'MWG59565', 'testset', '', 'Serhat Almez');
/*!40000 ALTER TABLE `phone_tweets` ENABLE KEYS */;

CREATE TABLE IF NOT EXISTS `player_contacts` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `identifier` varchar(255) DEFAULT NULL,
  `name` varchar(255) DEFAULT NULL,
  `number` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `identifier` (`identifier`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

/*!40000 ALTER TABLE `player_contacts` DISABLE KEYS */;
REPLACE INTO `player_contacts` (`id`, `identifier`, `name`, `number`) VALUES
	(12460, 'MWG59565', 'test', '1231241244'),
	(12463, 'MWG59565', 'Deneme', '5353535565'),
	(12464, 'MWG59565', 'deneme', '3151252215'),
	(12465, 'MWG59565', 'Ben', '1525280873');
/*!40000 ALTER TABLE `player_contacts` ENABLE KEYS */;

/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IFNULL(@OLD_FOREIGN_KEY_CHECKS, 1) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40111 SET SQL_NOTES=IFNULL(@OLD_SQL_NOTES, 1) */;
