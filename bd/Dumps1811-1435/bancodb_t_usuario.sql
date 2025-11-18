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
-- Table structure for table `t_usuario`
--

DROP TABLE IF EXISTS `t_usuario`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `t_usuario` (
  `codUsuario` varchar(20) NOT NULL,
  `usn` varchar(50) DEFAULT NULL,
  `psw` varchar(255) DEFAULT NULL,
  `nom` varchar(100) DEFAULT NULL,
  `ape` varchar(100) DEFAULT NULL,
  `carg` varchar(100) DEFAULT NULL,
  `idRol` varchar(20) DEFAULT NULL,
  `codEstado` varchar(20) DEFAULT NULL,
  `intentos` int DEFAULT '0',
  `fechaBloqueo` datetime DEFAULT NULL,
  `ultimoLogin` datetime DEFAULT NULL,
  `codUsuCre` varchar(20) DEFAULT NULL,
  `fecUsuCre` datetime DEFAULT NULL,
  `codUsuMod` varchar(20) DEFAULT NULL,
  `fecUsuMod` datetime DEFAULT NULL,
  PRIMARY KEY (`codUsuario`),
  UNIQUE KEY `usn` (`usn`),
  KEY `idRol` (`idRol`),
  KEY `codEstado` (`codEstado`),
  CONSTRAINT `t_usuario_ibfk_1` FOREIGN KEY (`idRol`) REFERENCES `t_rol` (`codRol`),
  CONSTRAINT `t_usuario_ibfk_2` FOREIGN KEY (`codEstado`) REFERENCES `t_estado` (`codEstado`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `t_usuario`
--

LOCK TABLES `t_usuario` WRITE;
/*!40000 ALTER TABLE `t_usuario` DISABLE KEYS */;
INSERT INTO `t_usuario` VALUES ('U0001','admin','$2a$10$mRPG.peijK/l20.kYpoKROprUSE4iG6V06T8xU5WKrzn9ZMwp4eIG','Administrador del sistema',' ','Administrador','R0001','S0001',0,'2025-11-18 14:06:00',NULL,'U0002','2025-10-17 00:00:00',NULL,NULL),('U0002','crios','$2a$10$8a8LXcALkBBDSw2HFuU.GuBTbtMmtLSINffHN8VZoY9O7EnNV.ymG','Carlos','Rios','Jefe','R0001','S0001',0,NULL,NULL,'U0001','2025-10-16 00:00:00',NULL,NULL),('U0003','pcastillo','$2a$10$3wz1d2ZC/nHhBrNKsnXZlexsgBF5Ks7jTxeX8zujU.qOcK1IRgKv.','Pedro','Castillo','Prosor','R0001','S0001',0,NULL,NULL,'U0001','2025-10-17 00:00:00',NULL,NULL),('U0004','lcaceres','$2a$10$vocK00fXFH3CXSvqHyxds.PoTaV6P5Niyq7mSLuhdBwbvh5taP50q','Luis','Caceres','Supervisor','R0001','S0001',0,NULL,NULL,'U0001','2025-10-17 00:00:00',NULL,NULL),('U0005','jpablo','$2a$10$oxpoyzSJGXVFH1l0F8QQi.pWxNjr60JIPFqzBzey4nvOECK5Yn3hy','Juan','Pablo','Supervisor','R0001','S0001',0,NULL,NULL,'U0001','2025-10-17 00:00:00',NULL,NULL),('U0006','mmendes','$2a$10$f1hX/czO9G754Bq7uwvaie2Yqg6w1dpvcA1EHRjvaeV2geJOoIJKa','Maria','Mendes','Supervisor','R0001','S0001',0,NULL,NULL,'U0001','2025-10-17 00:00:00',NULL,NULL),('U0007','jlima','$2a$10$FjDF0ZE1IFNYW5P8pVlRMOk5rztNgG9l8sW7ziN0kcbyWiI7fnnsS','Juana','Limaña','Supervisor','R0001','S0001',0,NULL,NULL,'U0001','2025-10-17 00:00:00',NULL,NULL);
/*!40000 ALTER TABLE `t_usuario` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2025-11-18 14:35:29
