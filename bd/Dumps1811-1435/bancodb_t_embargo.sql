-- MySQL dump 10.13  Distrib 8.0.43, for Win64 (x86_64)
--
-- Host: 127.0.0.1    Database: bancodb
-- ------------------------------------------------------
-- Server version	8.0.43

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `t_embargo`
--

DROP TABLE IF EXISTS `t_embargo`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `t_embargo` (
  `codEmbargo` varchar(20) NOT NULL,
  `numCuenta` varchar(20) DEFAULT NULL,
  `mon` decimal(18,4) DEFAULT NULL,
  `expedienteJudicial` varchar(50) DEFAULT NULL,
  `descripcion` varchar(255) DEFAULT NULL,
  `montoLiberado` decimal(18,4) DEFAULT '0.0000',
  `codEstado` varchar(20) DEFAULT NULL,
  `codUsuCre` varchar(20) DEFAULT NULL,
  `fecUsuCre` datetime DEFAULT NULL,
  `codUsuMod` varchar(20) DEFAULT NULL,
  `fecUsuMod` datetime DEFAULT NULL,
  PRIMARY KEY (`codEmbargo`),
  KEY `codEstado` (`codEstado`),
  KEY `idx_embargo_cuenta` (`numCuenta`),
  CONSTRAINT `t_embargo_ibfk_1` FOREIGN KEY (`numCuenta`) REFERENCES `t_cuentas` (`numCuenta`),
  CONSTRAINT `t_embargo_ibfk_2` FOREIGN KEY (`codEstado`) REFERENCES `t_estado` (`codEstado`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `t_embargo`
--

LOCK TABLES `t_embargo` WRITE;
/*!40000 ALTER TABLE `t_embargo` DISABLE KEYS */;
INSERT INTO `t_embargo` VALUES ('EM0001','68759444679140',200.0000,'EXP-ASASD3651145','judicial',0.0000,'S0001','U0001','2025-11-18 16:42:47',NULL,NULL),('EM0002','68759444679140',200.0000,'EXP-ASASD36545','alimentos\r\n',0.0000,'S0001','U0001','2025-11-18 16:43:11',NULL,NULL),('EM0003','96409957196140',100.0000,'EXP-AS4565','Deuda',100.0000,'S0007','U0001','2025-11-18 16:43:52',NULL,'2025-11-18 18:44:49'),('EM0004','12743226960489',150.0000,'EXP-AS4565','judicial\r\n',150.0000,'S0007','U0001','2025-11-18 16:52:36',NULL,'2025-11-18 16:52:50');
/*!40000 ALTER TABLE `t_embargo` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2025-11-18 19:52:19
