 -- MySQL dump 10.13  Distrib 8.0.20, for Win64 (x86_64)
--
-- Host: 127.0.0.1    Database: mydb
-- ------------------------------------------------------
-- Server version	8.0.20

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
-- Table structure for table `rep_ciudad`
--

DROP TABLE IF EXISTS `rep_ciudad`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `rep_ciudad` (
  `Indice` int NOT NULL AUTO_INCREMENT,
  `Ciudad` varchar(45) DEFAULT NULL,
  `Region` int DEFAULT NULL,
  PRIMARY KEY (`Indice`),
  KEY `REGION_idx` (`Region`),
  CONSTRAINT `REGION` FOREIGN KEY (`Region`) REFERENCES `rep_region` (`Indice`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `rep_ciudad`
--

LOCK TABLES `rep_ciudad` WRITE;
/*!40000 ALTER TABLE `rep_ciudad` DISABLE KEYS */;
INSERT INTO `rep_ciudad` VALUES (1,'Temuco',1);
/*!40000 ALTER TABLE `rep_ciudad` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `rep_datosproveedor`
--

DROP TABLE IF EXISTS `rep_datosproveedor`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `rep_datosproveedor` (
  `id_proveedor` int NOT NULL AUTO_INCREMENT,
  `Id_usuario` int DEFAULT NULL,
  `Nombre_Negocio` varchar(45) DEFAULT NULL,
  `Telefono_Negocio` int DEFAULT NULL,
  `Descripcion_Negocio` varchar(200) DEFAULT NULL,
  `Tipo_Servicio` int DEFAULT NULL,
  `Valoracion` int NOT NULL DEFAULT '5',
  PRIMARY KEY (`id_proveedor`),
  KEY `SERVICIO_idx` (`Tipo_Servicio`),
  KEY `USUARIO_idx` (`Id_usuario`),
  CONSTRAINT `SERVICIO` FOREIGN KEY (`Tipo_Servicio`) REFERENCES `rep_tiposervicio` (`Indice`),
  CONSTRAINT `USUARIO` FOREIGN KEY (`Id_usuario`) REFERENCES `rep_datosusuario` (`Id_Usuario`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `rep_datosproveedor`
--

LOCK TABLES `rep_datosproveedor` WRITE;
/*!40000 ALTER TABLE `rep_datosproveedor` DISABLE KEYS */;
INSERT INTO `rep_datosproveedor` VALUES (3,3,'Electricidad Inacap',551682456,'Los Mejores',2,4),(4,4,'Electricidad UCT',1111111,'Los no tan Mejores',2,5),(5,5,'gasfiteria UCT',1111111,'Los no tan Mejores',1,5),(6,6,'gasfiteria OK',1111111,'Los no tan Mejores',1,5);
/*!40000 ALTER TABLE `rep_datosproveedor` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `rep_datosusuario`
--

DROP TABLE IF EXISTS `rep_datosusuario`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `rep_datosusuario` (
  `Id_Usuario` int NOT NULL AUTO_INCREMENT,
  `Rut` char(10) NOT NULL,
  `Nombres` varchar(45) DEFAULT NULL,
  `Apellidos` varchar(45) DEFAULT NULL,
  `Telefono` int DEFAULT NULL,
  `Direccion` varchar(45) DEFAULT NULL,
  `Email` varchar(45) DEFAULT NULL,
  `Ciudad` int DEFAULT NULL,
  `Password` varchar(200) DEFAULT NULL,
  `Tipo_Usuario` int DEFAULT '1',
  PRIMARY KEY (`Id_Usuario`),
  KEY `TIPO_idx` (`Tipo_Usuario`),
  KEY `CIUDAD_idx` (`Ciudad`),
  CONSTRAINT `CIUDAD` FOREIGN KEY (`Ciudad`) REFERENCES `rep_ciudad` (`Indice`),
  CONSTRAINT `TIPO` FOREIGN KEY (`Tipo_Usuario`) REFERENCES `rep_tipousuario` (`Indice`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `rep_datosusuario`
--

LOCK TABLES `rep_datosusuario` WRITE;
/*!40000 ALTER TABLE `rep_datosusuario` DISABLE KEYS */;
INSERT INTO `rep_datosusuario` VALUES (2,'5846416465','Emanuel','Toro',989180394,'fresia 415','asdasd@asdasdasd',1,'$2a$10$6dmf43QuGqpdHsnauLOqZ.6PeUXyv3ZgjzbKDGoK9mLEHBt.RaOpe',1),(3,'4569','Emanuel','Toro',989180394,'fresia 415','eaaa@aaaa',1,'$2a$10$aRT4m2RQlGSZE16lmE4iaeHxH4Yok8RQYX5gl6U3VvR0W5Y426Cj.',1),(4,'88888','88888','8888',88888,'88888','8888@8888',1,'$2a$10$3K3QTWFcuqiUF9gfEN1nuOcrEq3KOl6.rMszUShTfM2eg8.L/6gmC',1),(5,'88888','88888','8888',88888,'88888','8888@8888',1,'$2a$10$y/8I0bYnfoBDSGXYmmo4lO8wJTyMPDnrDVjijNwVVCeUKvSFf7MZ6',1),(6,'111111','11111','11111',11111111,'11111','11111@11111',1,'$2a$10$BLW1R0X0WnQ9KKf3ZlP4ye/omyaXkFLQ1Kt/l3AQ7iz8Zq4uIJRp2',1),(7,'1','e','e',989180394,'Blue ranch','a@a',1,'$2a$10$1uw2k2umkj7FFGorhmYIXO6SgRurKYWby7k5LR/n9ibA9ULphXT6y',1);
/*!40000 ALTER TABLE `rep_datosusuario` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `rep_estadosservicios`
--

DROP TABLE IF EXISTS `rep_estadosservicios`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `rep_estadosservicios` (
  `Indice_Estado` int NOT NULL AUTO_INCREMENT,
  `Descripcion_Estado` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`Indice_Estado`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `rep_estadosservicios`
--

LOCK TABLES `rep_estadosservicios` WRITE;
/*!40000 ALTER TABLE `rep_estadosservicios` DISABLE KEYS */;
/*!40000 ALTER TABLE `rep_estadosservicios` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `rep_fichaservicio`
--

DROP TABLE IF EXISTS `rep_fichaservicio`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `rep_fichaservicio` (
  `Indice_Ficha` int NOT NULL AUTO_INCREMENT,
  `Solicitud` int DEFAULT NULL,
  `Id_proveedor` int DEFAULT NULL,
  `Fecha_Trabajo` date DEFAULT NULL,
  `Observacion_Cliente` varchar(200) DEFAULT NULL,
  `Observacion_Proveedor` varchar(200) DEFAULT NULL,
  `Valoracion_Cliente` int DEFAULT NULL,
  `Valoracion_Proveedor` int DEFAULT NULL,
  PRIMARY KEY (`Indice_Ficha`),
  KEY `Solicitud_idx` (`Solicitud`),
  KEY `Proveedor_idx` (`Id_proveedor`),
  CONSTRAINT `Proveedor_Ficha` FOREIGN KEY (`Id_proveedor`) REFERENCES `rep_datosproveedor` (`id_proveedor`),
  CONSTRAINT `Solicitud` FOREIGN KEY (`Solicitud`) REFERENCES `rep_solicitudservicio` (`Indice_Solicitud`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `rep_fichaservicio`
--

LOCK TABLES `rep_fichaservicio` WRITE;
/*!40000 ALTER TABLE `rep_fichaservicio` DISABLE KEYS */;
/*!40000 ALTER TABLE `rep_fichaservicio` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `rep_region`
--

DROP TABLE IF EXISTS `rep_region`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `rep_region` (
  `Indice` int NOT NULL AUTO_INCREMENT,
  `Region` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`Indice`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `rep_region`
--

LOCK TABLES `rep_region` WRITE;
/*!40000 ALTER TABLE `rep_region` DISABLE KEYS */;
INSERT INTO `rep_region` VALUES (1,'Araucania');
/*!40000 ALTER TABLE `rep_region` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `rep_solicitudservicio`
--

DROP TABLE IF EXISTS `rep_solicitudservicio`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `rep_solicitudservicio` (
  `Indice_Solicitud` int NOT NULL AUTO_INCREMENT,
  `Fecha_Solicitud` date DEFAULT NULL,
  `Titulo_Servicio` varchar(45) NOT NULL,
  `Descripcion_Solicitud` varchar(200) NOT NULL,
  `Ciudad_Servicio` varchar(45) NOT NULL,
  `Comuna_Servicio` varchar(45) NOT NULL,
  `Direccion_Servicio` varchar(45) NOT NULL,
  `Estado_Solicitud` int DEFAULT NULL,
  `Cotizacion_Tecnico` varchar(200) DEFAULT NULL,
  `Id_proveedor` int DEFAULT NULL,
  `Fecha_Solicitud_Servicio` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `Id_Usuario` int DEFAULT NULL,
  PRIMARY KEY (`Indice_Solicitud`),
  KEY `Estado_idx` (`Estado_Solicitud`),
  KEY `Proveedor_idx` (`Id_proveedor`),
  CONSTRAINT `Estado` FOREIGN KEY (`Estado_Solicitud`) REFERENCES `rep_estadosservicios` (`Indice_Estado`),
  CONSTRAINT `Proveedor` FOREIGN KEY (`Id_proveedor`) REFERENCES `rep_datosproveedor` (`id_proveedor`)
) ENGINE=InnoDB AUTO_INCREMENT=24 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `rep_solicitudservicio`
--

LOCK TABLES `rep_solicitudservicio` WRITE;
/*!40000 ALTER TABLE `rep_solicitudservicio` DISABLE KEYS */;
INSERT INTO `rep_solicitudservicio` VALUES (20,NULL,'Problema con lavaplatos','Ayuda','Temuco','Temuco','local host 4000',NULL,NULL,NULL,'2020-07-20 15:09:40',NULL),(23,NULL,'problema de fuga','Fuga','Temuco','Temuco','av siempre viva',NULL,NULL,NULL,'2020-07-20 17:02:39',7);
/*!40000 ALTER TABLE `rep_solicitudservicio` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `rep_tiposervicio`
--

DROP TABLE IF EXISTS `rep_tiposervicio`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `rep_tiposervicio` (
  `Indice` int NOT NULL AUTO_INCREMENT,
  `Descripcion` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`Indice`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `rep_tiposervicio`
--

LOCK TABLES `rep_tiposervicio` WRITE;
/*!40000 ALTER TABLE `rep_tiposervicio` DISABLE KEYS */;
INSERT INTO `rep_tiposervicio` VALUES (1,'Gasfiter'),(2,'Electricista');
/*!40000 ALTER TABLE `rep_tiposervicio` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `rep_tipousuario`
--

DROP TABLE IF EXISTS `rep_tipousuario`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `rep_tipousuario` (
  `Indice` int NOT NULL,
  `Descripción` varchar(10) DEFAULT NULL,
  PRIMARY KEY (`Indice`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `rep_tipousuario`
--

LOCK TABLES `rep_tipousuario` WRITE;
/*!40000 ALTER TABLE `rep_tipousuario` DISABLE KEYS */;
INSERT INTO `rep_tipousuario` VALUES (1,'Cliente');
/*!40000 ALTER TABLE `rep_tipousuario` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sessions`
--

DROP TABLE IF EXISTS `sessions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `sessions` (
  `session_id` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `expires` int unsigned NOT NULL,
  `data` mediumtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin,
  PRIMARY KEY (`session_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sessions`
--

LOCK TABLES `sessions` WRITE;
/*!40000 ALTER TABLE `sessions` DISABLE KEYS */;
INSERT INTO `sessions` VALUES ('5gjtRJEWC9tnEsS686V0a1qbGCa00eIi',1595351765,'{\"cookie\":{\"originalMaxAge\":null,\"expires\":null,\"httpOnly\":true,\"path\":\"/\"},\"flash\":{},\"passport\":{\"user\":7}}'),('BtKOvHzoIAZNujBjJBobvZhBaNa0Y7hA',1595312352,'{\"cookie\":{\"originalMaxAge\":null,\"expires\":null,\"httpOnly\":true,\"path\":\"/\"},\"flash\":{},\"passport\":{\"user\":3}}'),('S1jZnFJP0hzQjVy1zY7Cio61mreBDRD1',1595311917,'{\"cookie\":{\"originalMaxAge\":null,\"expires\":null,\"httpOnly\":true,\"path\":\"/\"},\"flash\":{},\"passport\":{\"user\":2}}'),('qEHLtgLIaXR5n79LL6m5nmaRACU4PGfg',1595312659,'{\"cookie\":{\"originalMaxAge\":null,\"expires\":null,\"httpOnly\":true,\"path\":\"/\"},\"flash\":{},\"passport\":{\"user\":5}}'),('uK9ULJTZHUX9oIGht8TBrgzO2BPh3Ygn',1595347341,'{\"cookie\":{\"originalMaxAge\":null,\"expires\":null,\"httpOnly\":true,\"path\":\"/\"},\"flash\":{},\"passport\":{\"user\":7}}');
/*!40000 ALTER TABLE `sessions` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2020-07-20 13:32:49