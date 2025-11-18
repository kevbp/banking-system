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
-- Table structure for table `t_tipocuenta`
--

DROP TABLE IF EXISTS `t_tipocuenta`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `t_tipocuenta` (
  `codTipCuenta` varchar(20) NOT NULL,
  `descTipo` varchar(100) DEFAULT NULL,
  `tasaInt` decimal(5,2) DEFAULT NULL,
  `codMoneda` varchar(20) DEFAULT NULL,
  `codEstado` varchar(20) DEFAULT NULL,
  `codUsuCre` varchar(20) DEFAULT NULL,
  `fecUsuCre` datetime DEFAULT NULL,
  `codUsuMod` varchar(20) DEFAULT NULL,
  `fecUsuMod` datetime DEFAULT NULL,
  PRIMARY KEY (`codTipCuenta`),
  KEY `codMoneda` (`codMoneda`),
  KEY `codEstado` (`codEstado`),
  CONSTRAINT `t_tipocuenta_ibfk_1` FOREIGN KEY (`codMoneda`) REFERENCES `t_moneda` (`codMoneda`),
  CONSTRAINT `t_tipocuenta_ibfk_2` FOREIGN KEY (`codEstado`) REFERENCES `t_estado` (`codEstado`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `t_tipocuenta`
--

LOCK TABLES `t_tipocuenta` WRITE;
/*!40000 ALTER TABLE `t_tipocuenta` DISABLE KEYS */;
INSERT INTO `t_tipocuenta` VALUES ('TC001','Cuenta de Ahorros',1.50,'PEN','S0001','U0001','2025-11-18 10:31:55',NULL,NULL),('TC002','Cuenta Corriente',0.00,'PEN','S0001','U0001','2025-11-18 10:31:55',NULL,NULL),('TC003','Cuenta a Plazo Fijo',4.50,'PEN','S0001','U0001','2025-11-18 10:31:55',NULL,NULL),('TC004','Cuenta de Ahorros USD',0.50,'USD','S0001','U0001','2025-11-18 10:31:55',NULL,NULL),('TC005','Cuenta Corriente Dolares',3.50,'USD','S0001',NULL,NULL,NULL,NULL);
/*!40000 ALTER TABLE `t_tipocuenta` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2025-11-18 14:35:28
