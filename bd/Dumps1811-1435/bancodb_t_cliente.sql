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
-- Table structure for table `t_cliente`
--

DROP TABLE IF EXISTS `t_cliente`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `t_cliente` (
  `codCliente` varchar(20) NOT NULL,
  `nomCompleto` varchar(300) DEFAULT NULL,
  `tipoDoc` varchar(20) DEFAULT NULL,
  `numDoc` varchar(20) DEFAULT NULL,
  `fecNac` date DEFAULT NULL,
  `dir` varchar(200) DEFAULT NULL,
  `codUbigeo` varchar(20) DEFAULT NULL,
  `tel` varchar(20) DEFAULT NULL,
  `cel` varchar(20) DEFAULT NULL,
  `email` varchar(100) DEFAULT NULL,
  `fecReg` datetime DEFAULT NULL,
  `codEstado` varchar(20) DEFAULT NULL,
  `codUsuCre` varchar(20) DEFAULT NULL,
  `fecUsuCre` datetime DEFAULT NULL,
  `codUsuMod` varchar(20) DEFAULT NULL,
  `fecUsuMod` datetime DEFAULT NULL,
  PRIMARY KEY (`codCliente`),
  UNIQUE KEY `numDoc` (`numDoc`),
  KEY `codUbigeo` (`codUbigeo`),
  KEY `codEstado` (`codEstado`),
  KEY `idx_cliente_doc` (`numDoc`),
  CONSTRAINT `t_cliente_ibfk_1` FOREIGN KEY (`codUbigeo`) REFERENCES `t_ubigeo` (`codUbigeo`),
  CONSTRAINT `t_cliente_ibfk_2` FOREIGN KEY (`codEstado`) REFERENCES `t_estado` (`codEstado`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `t_cliente`
--

LOCK TABLES `t_cliente` WRITE;
/*!40000 ALTER TABLE `t_cliente` DISABLE KEYS */;
INSERT INTO `t_cliente` VALUES ('C0001','KEVIN LUIS ANGEL','dni','75897738','1997-04-08','Calle No 556 Los Jazmines','150142','','995789852','U19200579@utp.edu.pe','2025-10-14 00:00:00','S0001','U0001','2025-10-14 00:00:00','U0001','2025-11-18 09:38:14'),('C0002','KATHERIN','dni','47839302','1998-01-31','Av San Felipe N° 135','20101','7840502','998568998','u19265682@utp.edu.pe','2025-10-14 00:00:00','S0001','U0001','2025-10-14 00:00:00',NULL,NULL),('C0003','CARLOS AMADOR RIOS ORDUÑA','dni','07017086','1997-07-15','Calle No 556 Los Jazmines','150701','8568956','996896996','crios@utp.edu.pe','2025-11-14 15:57:24','S0002','U0001','2025-11-14 15:57:24','U0001','2025-11-14 16:18:17');
/*!40000 ALTER TABLE `t_cliente` ENABLE KEYS */;
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
