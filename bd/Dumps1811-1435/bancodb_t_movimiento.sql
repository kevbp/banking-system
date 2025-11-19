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
-- Table structure for table `t_movimiento`
--

DROP TABLE IF EXISTS `t_movimiento`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `t_movimiento` (
  `codMovimiento` varchar(20) NOT NULL,
  `codTransaccion` varchar(20) DEFAULT NULL,
  `numCuenta` varchar(20) DEFAULT NULL,
  `fec` datetime DEFAULT NULL,
  `codTipMovimiento` varchar(20) DEFAULT NULL,
  `monto` decimal(18,4) DEFAULT NULL,
  `salFin` decimal(18,4) DEFAULT NULL,
  `des` varchar(255) DEFAULT NULL,
  `numCueDes` varchar(20) DEFAULT NULL,
  `codEstado` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`codMovimiento`),
  KEY `codTransaccion` (`codTransaccion`),
  KEY `codTipMovimiento` (`codTipMovimiento`),
  KEY `codEstado` (`codEstado`),
  KEY `idx_movimiento_cuenta` (`numCuenta`),
  CONSTRAINT `t_movimiento_ibfk_1` FOREIGN KEY (`codTransaccion`) REFERENCES `t_transaccion` (`codTransaccion`),
  CONSTRAINT `t_movimiento_ibfk_2` FOREIGN KEY (`numCuenta`) REFERENCES `t_cuentas` (`numCuenta`),
  CONSTRAINT `t_movimiento_ibfk_3` FOREIGN KEY (`codTipMovimiento`) REFERENCES `t_tipomovimiento` (`codTipMovimiento`),
  CONSTRAINT `t_movimiento_ibfk_4` FOREIGN KEY (`codEstado`) REFERENCES `t_estado` (`codEstado`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `t_movimiento`
--

LOCK TABLES `t_movimiento` WRITE;
/*!40000 ALTER TABLE `t_movimiento` DISABLE KEYS */;
INSERT INTO `t_movimiento` VALUES ('M047B13E1-B7AA-40E5','TR1763507645052484','18762403204596','2025-11-18 18:14:05','TM001',1000.0000,1300.0000,'DEPÓSITO (Efectivo) - ','18762403204596','S0008'),('M06F892EE-DFB2-40DE','TR1763508938556411','18762403204596','2025-11-18 18:35:38','TM001',2100.0000,3200.0000,'DEPÓSITO (Efectivo) -  | Origen: Recibo por honorarios','18762403204596','S0008'),('M202FB59E-EF51-43D9','TR1763510019294551','12743226960489','2025-11-18 18:53:39','TM004',200.0000,1973.0000,'TRANSF. DE 18762403204596 - ','18762403204596','S0008'),('M65308A37-E8F8-4D83','TR1763510019294551','18762403204596','2025-11-18 18:53:39','TM003',200.0000,3000.0000,'TRANSF. A 12743226960489 - ','12743226960489','S0008'),('M965371D0-CCDD-4835','TR1763504133343945','12743226960489','2025-11-18 17:15:33','TM001',150.0000,1773.0000,'DEPÓSITO (Efectivo) - ','12743226960489','S0008'),('MF5893B6F-88CD-4203','TR1763508919444916','18762403204596','2025-11-18 18:35:19','TM002',200.0000,1100.0000,'RETIRO VENTANILLA - ',NULL,'S0008');
/*!40000 ALTER TABLE `t_movimiento` ENABLE KEYS */;
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
