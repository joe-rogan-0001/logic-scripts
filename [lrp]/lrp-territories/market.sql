/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8 */;
/*!50503 SET NAMES utf8mb4 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;

CREATE TABLE IF NOT EXISTS `market` (
  `id` varchar(30) NOT NULL,
  `quantity` int NOT NULL DEFAULT '0',
  `type` varchar(15) NOT NULL,
  `basePrice` int NOT NULL,
  `label` varchar(50) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

/*!40000 ALTER TABLE `market` DISABLE KEYS */;
INSERT INTO `market` (`id`, `quantity`, `type`, `basePrice`, `label`) VALUES
	('blocohaxixe', 0, 'drugs', 3000, 'Haxixe'),
	('caixacoke', 0, 'drugs', 1800, 'Cocaina'),
	('caixaheroin', 0, 'drugs', 1950, 'Heroina'),
	('marijuana', 0, 'drugs', 1200, 'Marijuana'),
	('meth', 0, 'drugs', 2200, 'Metanfetamina');
/*!40000 ALTER TABLE `market` ENABLE KEYS */;

/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IF(@OLD_FOREIGN_KEY_CHECKS IS NULL, 1, @OLD_FOREIGN_KEY_CHECKS) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
