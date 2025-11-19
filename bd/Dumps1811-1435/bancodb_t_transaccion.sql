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
-- Table structure for table `t_transaccion`
--

DROP TABLE IF EXISTS `t_transaccion`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `t_transaccion` (
  `codTransaccion` varchar(20) NOT NULL,
  `numCuentaOrigen` varchar(20) DEFAULT NULL,
  `numCuentaDestino` varchar(20) DEFAULT NULL,
  `codTipMovimiento` varchar(20) DEFAULT NULL,
  `fec` datetime DEFAULT NULL,
  `monto` decimal(18,4) DEFAULT NULL,
  `canal` varchar(50) DEFAULT NULL,
  `codEstado` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`codTransaccion`),
  KEY `numCuentaOrigen` (`numCuentaOrigen`),
  KEY `numCuentaDestino` (`numCuentaDestino`),
  KEY `codTipMovimiento` (`codTipMovimiento`),
  KEY `codEstado` (`codEstado`),
  KEY `idx_transaccion_fecha` (`fec`),
  CONSTRAINT `t_transaccion_ibfk_1` FOREIGN KEY (`numCuentaOrigen`) REFERENCES `t_cuentas` (`numCuenta`),
  CONSTRAINT `t_transaccion_ibfk_2` FOREIGN KEY (`numCuentaDestino`) REFERENCES `t_cuentas` (`numCuenta`),
  CONSTRAINT `t_transaccion_ibfk_3` FOREIGN KEY (`codTipMovimiento`) REFERENCES `t_tipomovimiento` (`codTipMovimiento`),
  CONSTRAINT `t_transaccion_ibfk_4` FOREIGN KEY (`codEstado`) REFERENCES `t_estado` (`codEstado`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `t_transaccion`
--

LOCK TABLES `t_transaccion` WRITE;
/*!40000 ALTER TABLE `t_transaccion` DISABLE KEYS */;
INSERT INTO `t_transaccion` VALUES ('TR1763504133343945',NULL,'12743226960489','TM001','2025-11-18 17:15:33',150.0000,'VENTANILLA','S0008'),('TR1763507645052484',NULL,'18762403204596','TM001','2025-11-18 18:14:05',1000.0000,'VENTANILLA','S0008'),('TR1763508919444916','18762403204596',NULL,'TM002','2025-11-18 18:35:19',200.0000,'VENTANILLA','S0008'),('TR1763508938556411',NULL,'18762403204596','TM001','2025-11-18 18:35:38',2100.0000,'VENTANILLA','S0008'),('TR1763510019294551','18762403204596','12743226960489','TM003','2025-11-18 18:53:39',200.0000,'VENTANILLA','S0008');
/*!40000 ALTER TABLE `t_transaccion` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2025-11-18 19:52:18
