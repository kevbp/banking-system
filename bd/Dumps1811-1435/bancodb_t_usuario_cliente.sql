-- MySQL dump 10.13  Distrib 8.0.43, for Win64 (x86_64)
--
-- Host: localhost    Database: bancodb
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
-- Table structure for table `t_usuario_cliente`
--

DROP TABLE IF EXISTS `t_usuario_cliente`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `t_usuario_cliente` (
  `codUsuarioWeb` int NOT NULL AUTO_INCREMENT,
  `codCliente` varchar(20) NOT NULL,
  `nomUsuario` varchar(50) NOT NULL,
  `claveWeb` varchar(255) NOT NULL,
  `palabraRecuperacion` varchar(255) NOT NULL,
  `estado` varchar(20) DEFAULT 'ACTIVO',
  `fechaRegistro` datetime DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`codUsuarioWeb`),
  UNIQUE KEY `unique_nomUsuario` (`nomUsuario`),
  UNIQUE KEY `unique_cliente` (`codCliente`),
  CONSTRAINT `fk_web_cliente` FOREIGN KEY (`codCliente`) REFERENCES `t_cliente` (`codCliente`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `t_usuario_cliente`
--

LOCK TABLES `t_usuario_cliente` WRITE;
/*!40000 ALTER TABLE `t_usuario_cliente` DISABLE KEYS */;
INSERT INTO `t_usuario_cliente` VALUES (1,'C0003','crios','$2a$10$nDYchPTavhUfonmpfSa/WeFzD.RXKhtClDq7qlCo6hVsGjfEn4rPK','$2a$10$T5jht5giEgU8GL/D.8JT6.vQHZGk8imUcsjjmhUOXe/MwWlvS48k2','ACTIVO','2025-11-18 12:40:28');
/*!40000 ALTER TABLE `t_usuario_cliente` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2025-11-18 14:53:32
