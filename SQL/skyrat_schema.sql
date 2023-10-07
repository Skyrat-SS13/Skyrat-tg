/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;


--
-- Table structure for table `player_rank`.
--
DROP TABLE IF EXISTS `player_rank`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `player_rank` (
  `ckey` VARCHAR(32) NOT NULL,
  `rank` VARCHAR(12) NOT NULL,
  `admin_ckey` VARCHAR(32) NOT NULL,
  `date_added` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `last_modified` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `deleted` BOOLEAN NOT NULL DEFAULT FALSE,
  PRIMARY KEY (`ckey`, `rank`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;


--
-- Table structure for table `player_rank_log`.
--
DROP TABLE IF EXISTS `player_rank_log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `player_rank_log` (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `ckey` VARCHAR(32) NOT NULL,
  `rank` VARCHAR(12) NOT NULL,
  `admin_ckey` VARCHAR(32) NOT NULL,
  `action` ENUM('ADDED', 'REMOVED') NOT NULL DEFAULT 'ADDED',
  `date` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;


--
-- Trigger structure for trigger `log_player_rank_additions`.
--
DROP TRIGGER IF EXISTS `log_player_rank_additions`;
CREATE TRIGGER `log_player_rank_additions`
AFTER INSERT ON `player_rank`
FOR EACH ROW
INSERT INTO player_rank_log (ckey, rank, admin_ckey, `action`) VALUES (NEW.ckey, NEW.rank, NEW.admin_ckey, 'ADDED');


--
-- Trigger structure for trigger `log_player_rank_changes`.
--
DROP TRIGGER IF EXISTS `log_player_rank_changes`;
DELIMITER //
CREATE TRIGGER `log_player_rank_changes`
AFTER UPDATE ON `player_rank`
FOR EACH ROW
BEGIN
 IF NEW.deleted = 1 THEN
  INSERT INTO player_rank_log (ckey, rank, admin_ckey, `action`) VALUES (NEW.ckey, NEW.rank, NEW.admin_ckey, 'REMOVED');
 ELSE
  INSERT INTO player_rank_log (ckey, rank, admin_ckey, `action`) VALUES (NEW.ckey, NEW.rank, NEW.admin_ckey, 'ADDED');
 END IF;
END; //
DELIMITER ;


/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
