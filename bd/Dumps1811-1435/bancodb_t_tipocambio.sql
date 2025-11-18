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
-- Table structure for table `t_tipocambio`
--

DROP TABLE IF EXISTS `t_tipocambio`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `t_tipocambio` (
  `idTipoCambio` int NOT NULL AUTO_INCREMENT,
  `fecha` datetime NOT NULL,
  `horaRegistro` time NOT NULL,
  `monedaOrigen` char(3) NOT NULL,
  `monedaDestino` char(3) NOT NULL,
  `tasaCompra` decimal(10,4) NOT NULL,
  `tasaVenta` decimal(10,4) NOT NULL,
  `codUsuCre` varchar(20) NOT NULL,
  `fecUsuCre` datetime NOT NULL,
  `codUsuMod` varchar(20) DEFAULT NULL,
  `fecUsuMod` datetime DEFAULT NULL,
  PRIMARY KEY (`idTipoCambio`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `t_tipocambio`
--

LOCK TABLES `t_tipocambio` WRITE;
/*!40000 ALTER TABLE `t_tipocambio` DISABLE KEYS */;
INSERT INTO `t_tipocambio` VALUES (1,'2025-11-18 00:00:00','10:46:32','USD','PEN',3.3590,3.3720,'U0001','2025-11-18 10:46:32',NULL,NULL),(2,'2025-11-18 00:00:00','10:48:50','USD','PEN',3.3700,3.3925,'U0001','2025-11-18 10:48:50',NULL,NULL);
/*!40000 ALTER TABLE `t_tipocambio` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2025-11-18 14:35:30
