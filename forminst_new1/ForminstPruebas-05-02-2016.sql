-- MySQL dump 10.13  Distrib 5.5.40, for debian-linux-gnu (x86_64)
--
-- Host: localhost    Database: forminst
-- ------------------------------------------------------
-- Server version	5.5.40-0+wheezy1

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `actividad`
--

DROP TABLE IF EXISTS `actividad`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `actividad` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `tipo_actividad_id` int(11) DEFAULT NULL,
  `actividad` longtext,
  `anulada` tinyint(1) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `actividadTipoactividad` (`tipo_actividad_id`),
  CONSTRAINT `actividadTipoactividad` FOREIGN KEY (`tipo_actividad_id`) REFERENCES `tipo_actividad` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=561 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `actividad`
--

LOCK TABLES `actividad` WRITE;
/*!40000 ALTER TABLE `actividad` DISABLE KEYS */;
/*!40000 ALTER TABLE `actividad` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `actividad_ejecutada`
--

DROP TABLE IF EXISTS `actividad_ejecutada`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `actividad_ejecutada` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `descripcion` longtext,
  `fecha` date DEFAULT NULL,
  `actual` tinyint(1) DEFAULT NULL,
  `informe_actividad_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `actividadejecutadaInformeactividad` (`informe_actividad_id`),
  CONSTRAINT `actividadejecutadaInformeactividad` FOREIGN KEY (`informe_actividad_id`) REFERENCES `informe_actividad` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=303 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `actividad_ejecutada`
--

LOCK TABLES `actividad_ejecutada` WRITE;
/*!40000 ALTER TABLE `actividad_ejecutada` DISABLE KEYS */;
/*!40000 ALTER TABLE `actividad_ejecutada` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `adecuacion`
--

DROP TABLE IF EXISTS `adecuacion`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `adecuacion` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `planformacion_id` int(11) DEFAULT NULL,
  `tutor_id` int(11) DEFAULT NULL,
  `fecha_modificacion` date DEFAULT NULL,
  `fecha_creacion` date DEFAULT NULL,
  `estado` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `adecuacionPlanformacion` (`planformacion_id`),
  KEY `adecuacionUsuario` (`tutor_id`),
  CONSTRAINT `adecuacionPlanformacion` FOREIGN KEY (`planformacion_id`) REFERENCES `planformacion` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `adecuacionUsuario` FOREIGN KEY (`tutor_id`) REFERENCES `usuario` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=19 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `adecuacion`
--

LOCK TABLES `adecuacion` WRITE;
/*!40000 ALTER TABLE `adecuacion` DISABLE KEYS */;
/*!40000 ALTER TABLE `adecuacion` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `adecuacion_actividad`
--

DROP TABLE IF EXISTS `adecuacion_actividad`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `adecuacion_actividad` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `adecuacion_id` int(11) DEFAULT NULL,
  `actividad_id` int(11) DEFAULT NULL,
  `anulada` tinyint(1) DEFAULT NULL,
  `semestre` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `adecuacionactividadActividad` (`actividad_id`),
  KEY `adecuacionactividadAdecuacion` (`adecuacion_id`),
  CONSTRAINT `adecuacionactividadActividad` FOREIGN KEY (`actividad_id`) REFERENCES `actividad` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `adecuacionactividadAdecuacion` FOREIGN KEY (`adecuacion_id`) REFERENCES `adecuacion` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=399 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `adecuacion_actividad`
--

LOCK TABLES `adecuacion_actividad` WRITE;
/*!40000 ALTER TABLE `adecuacion_actividad` DISABLE KEYS */;
/*!40000 ALTER TABLE `adecuacion_actividad` ENABLE KEYS */;
UNLOCK TABLES;

DROP TABLE IF EXISTS `document`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `document` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `filename` varchar(255) DEFAULT NULL,
  `content_type` varchar(255) DEFAULT NULL,
  `file_contents` MEDIUMBLOB DEFAULT NULL,
  `created_at` datetime  NOT NULL,
  `updated_at` datetime NOT NULL,
  `instructor_id` int(11) DEFAULT NULL,
  `tutor_id` int(11) DEFAULT NULL,
  `adecuacion_id` int(11) DEFAULT NULL,
  `informe_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `documentinstructor` (`instructor_id`),
  KEY `documenttutor` (`tutor_id`),
  KEY `documentadecuacion` (`adecuacion_id`),
  KEY `documentinforme` (`informe_id`),
  CONSTRAINT `documentinstructor` FOREIGN KEY (`instructor_id`) REFERENCES `usuario` (`id`),
  CONSTRAINT `documenttutor` FOREIGN KEY (`tutor_id`) REFERENCES `usuario` (`id`),
  CONSTRAINT `documentadecuacion` FOREIGN KEY (`adecuacion_id`) REFERENCES `adecuacion` (`id`),
  CONSTRAINT `documentinforme` FOREIGN KEY (`informe_id`) REFERENCES `informe` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `documento`
--

DROP TABLE IF EXISTS `documento`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `documento` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `informe_actividad_id` int(11) DEFAULT NULL,
  `archivo` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `documentoInformeactividad` (`informe_actividad_id`),
  CONSTRAINT `documentoInformeactividad` FOREIGN KEY (`informe_actividad_id`) REFERENCES `informe_actividad` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `documento`
--

LOCK TABLES `documento` WRITE;
/*!40000 ALTER TABLE `documento` DISABLE KEYS */;
/*!40000 ALTER TABLE `documento` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `documento_informe`
--

DROP TABLE IF EXISTS `documento_informe`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `documento_informe` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `informe_id` int(11) DEFAULT NULL,
  `archivo` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `documentoInforme` (`informe_id`),
  CONSTRAINT `documentoInforme` FOREIGN KEY (`informe_id`) REFERENCES `informe` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `documento_informe`
--

LOCK TABLES `documento_informe` WRITE;
/*!40000 ALTER TABLE `documento_informe` DISABLE KEYS */;
/*!40000 ALTER TABLE `documento_informe` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `documento_plan`
--

DROP TABLE IF EXISTS `documento_plan`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `documento_plan` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `planformacion_id` int(11) DEFAULT NULL,
  `archivo` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `documentoPlan` (`planformacion_id`),
  CONSTRAINT `documentoPlan` FOREIGN KEY (`planformacion_id`) REFERENCES `planformacion` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `documento_plan`
--

LOCK TABLES `documento_plan` WRITE;
/*!40000 ALTER TABLE `documento_plan` DISABLE KEYS */;
/*!40000 ALTER TABLE `documento_plan` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `entidad`
--

DROP TABLE IF EXISTS `entidad`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `entidad` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `nombre` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=20 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `entidad`
--

LOCK TABLES `entidad` WRITE;
/*!40000 ALTER TABLE `entidad` DISABLE KEYS */;
INSERT INTO `entidad` VALUES (1,'Consejo de Escuela de Biología'),(2,'Consejo de Escuela de Computación'),(3,'Consejo de Escuela de Física'),(4,'Consejo de Escuela de Geoquímica'),(5,'Consejo de Escuela de Matemática'),(6,'Consejo de Escuela de Química'),(7,'Comisión de Investigación de Biología'),(8,'Comisión de Investigación de Computación'),(9,'Comisión de Investigación de Física'),(10,'Comisión de Investigación de Geoquímica'),(11,'Comisión de Investigación de Matemática'),(12,'Comisión de Investigación de Química'),(13,'Consejo de Facultad'),(14,'Consejo Técnico del IBE'),(15,'Consejo Técnico del ICT'),(16,'Consejo Técnico del ICTA'),(17,'Consejo Técnico del IZET'),(18,'tutor'),(19,'instructor');
/*!40000 ALTER TABLE `entidad` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `escuela`
--

DROP TABLE IF EXISTS `escuela`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `escuela` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `nombre` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `escuela`
--

LOCK TABLES `escuela` WRITE;
/*!40000 ALTER TABLE `escuela` DISABLE KEYS */;
INSERT INTO `escuela` VALUES (1,'Escuela de Biología'),(2,'Escuela de Computación'),(3,'Escuela de Física'),(4,'Escuela de Geoqímica'),(5,'Instituto Biología Experimental'),(6,'Instituto de Ciencia y Tecnología de Alimentos'),(7,'Instituto de Ciencias de la Tierra'),(8,'Instituto de Zoología y Ecología Tropical'),(9,'Escuela de Matemática'),(10,'Escuela de Química'),(11,'Consejo de Facultad'),(12,'Desconocida');
/*!40000 ALTER TABLE `escuela` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `estatus_adecuacion`
--

DROP TABLE IF EXISTS `estatus_adecuacion`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `estatus_adecuacion` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `adecuacion_id` int(11) DEFAULT NULL,
  `fecha` date DEFAULT NULL,
  `estatus_id` int(11) DEFAULT NULL,
  `actual` tinyint(1) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `estatusAdecuacionAdecuacion` (`adecuacion_id`),
  KEY `estatusAdecuacionTipoEstatus` (`estatus_id`),
  CONSTRAINT `estatusAdecuacionAdecuacion` FOREIGN KEY (`adecuacion_id`) REFERENCES `adecuacion` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `estatusAdecuacionTipoEstatus` FOREIGN KEY (`estatus_id`) REFERENCES `tipo_estatus` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=25 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `estatus_adecuacion`
--

LOCK TABLES `estatus_adecuacion` WRITE;
/*!40000 ALTER TABLE `estatus_adecuacion` DISABLE KEYS */;
/*!40000 ALTER TABLE `estatus_adecuacion` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `estatus_informe`
--

DROP TABLE IF EXISTS `estatus_informe`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `estatus_informe` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `informe_id` int(11) DEFAULT NULL,
  `fecha` date DEFAULT NULL,
  `estatus_id` int(11) DEFAULT NULL,
  `actual` tinyint(1) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `estatus_informeTipoEstatus` (`estatus_id`),
  KEY `estatus_informeinforme` (`informe_id`),
  CONSTRAINT `estatus_informeTipoEstatus` FOREIGN KEY (`estatus_id`) REFERENCES `tipo_estatus` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `estatus_informeinforme` FOREIGN KEY (`informe_id`) REFERENCES `informe` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=100 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `estatus_informe`
--

LOCK TABLES `estatus_informe` WRITE;
/*!40000 ALTER TABLE `estatus_informe` DISABLE KEYS */;
/*!40000 ALTER TABLE `estatus_informe` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `historial_actividad`
--

DROP TABLE IF EXISTS `historial_actividad`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `historial_actividad` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `actividad_id` int(11) NOT NULL,
  `actividad` longtext NOT NULL,
  `fecha_modificacion` date NOT NULL,
  PRIMARY KEY (`id`),
  KEY `historial_actividad_fk` (`actividad_id`),
  CONSTRAINT `historial_actividad_fk` FOREIGN KEY (`actividad_id`) REFERENCES `actividad` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `historial_actividad`
--

LOCK TABLES `historial_actividad` WRITE;
/*!40000 ALTER TABLE `historial_actividad` DISABLE KEYS */;
/*!40000 ALTER TABLE `historial_actividad` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `historial_resultado`
--

DROP TABLE IF EXISTS `historial_resultado`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `historial_resultado` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `resultado_id` int(11) NOT NULL,
  `resultado` longtext NOT NULL,
  `fecha_modificacion` date NOT NULL,
  PRIMARY KEY (`id`),
  KEY `historial_resultado_fk` (`resultado_id`),
  CONSTRAINT `historial_resultado_fk` FOREIGN KEY (`resultado_id`) REFERENCES `resultado` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `historial_resultado`
--

LOCK TABLES `historial_resultado` WRITE;
/*!40000 ALTER TABLE `historial_resultado` DISABLE KEYS */;
/*!40000 ALTER TABLE `historial_resultado` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `informe`
--

DROP TABLE IF EXISTS `informe`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `informe` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `planformacion_id` int(11) DEFAULT NULL,
  `tutor_id` int(11) DEFAULT NULL,
  `opinion_tutor` longtext,
  `conclusiones` longtext,
  `numero` int(11) DEFAULT NULL,
  `fecha_creacion` date DEFAULT NULL,
  `estado` varchar(255) DEFAULT NULL,
  `fecha_inicio` date DEFAULT NULL,
  `fecha_fin` date DEFAULT NULL,
  `fecha_modificacion` date DEFAULT NULL,
  `tipo_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `informePlanFormacion` (`planformacion_id`),
  KEY `informeusuario` (`tutor_id`),
  KEY `informetipo` (`tipo_id`),
  CONSTRAINT `informetipo` FOREIGN KEY (`tipo_id`) REFERENCES `tipo_informe` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `informePlanFormacion` FOREIGN KEY (`planformacion_id`) REFERENCES `planformacion` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `informeusuario` FOREIGN KEY (`tutor_id`) REFERENCES `usuario` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=57 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `informe`
--

LOCK TABLES `informe` WRITE;
/*!40000 ALTER TABLE `informe` DISABLE KEYS */;
/*!40000 ALTER TABLE `informe` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `informe_actividad`
--

DROP TABLE IF EXISTS `informe_actividad`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `informe_actividad` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `informe_id` int(11) DEFAULT NULL,
  `actividad_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `informeActividadActividad` (`actividad_id`),
  KEY `informeActividadinforme` (`informe_id`),
  CONSTRAINT `informeActividadActividad` FOREIGN KEY (`actividad_id`) REFERENCES `actividad` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `informeActividadinforme` FOREIGN KEY (`informe_id`) REFERENCES `informe` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=484 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `informe_actividad`
--

LOCK TABLES `informe_actividad` WRITE;
/*!40000 ALTER TABLE `informe_actividad` DISABLE KEYS */;
/*!40000 ALTER TABLE `informe_actividad` ENABLE KEYS */;
UNLOCK TABLES;


--
-- Table structure for table `notificacion`
--

DROP TABLE IF EXISTS `notificacion`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `notificacion` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `instructor_id` int(11) DEFAULT NULL,
  `tutor_id` int(11) DEFAULT NULL,
  `adecuacion_id` int(11) DEFAULT NULL,
  `informe_id` int(11) DEFAULT NULL,
  `actual` int(11) DEFAULT NULL,
  `mensaje` longtext,
  PRIMARY KEY (`id`),
  KEY `notificacioninstructor` (`instructor_id`),
  KEY `notificaciontutor` (`tutor_id`),
  KEY `notificacionadecuacion` (`adecuacion_id`),
  KEY `notificacioninforme` (`informe_id`),
  CONSTRAINT `notificacioninstructor` FOREIGN KEY (`instructor_id`) REFERENCES `usuario` (`id`),
  CONSTRAINT `notificaciontutor` FOREIGN KEY (`tutor_id`) REFERENCES `usuario` (`id`),
  CONSTRAINT `notificacionadecuacion` FOREIGN KEY (`adecuacion_id`) REFERENCES `adecuacion` (`id`),
  CONSTRAINT `notificacioninforme` FOREIGN KEY (`informe_id`) REFERENCES `informe` (`id`)

) ENGINE=InnoDB AUTO_INCREMENT=0 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `instructortutor`
--

DROP TABLE IF EXISTS `instructortutor`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `instructortutor` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `instructor_id` int(11) DEFAULT NULL,
  `tutor_id` int(11) DEFAULT NULL,
  `actual` int(11) DEFAULT NULL,
  `fecha_inicio` date DEFAULT NULL,
  `fecha_fin` date DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `instructortutorinstructorid` (`instructor_id`),
  KEY `instructortutortutorid` (`tutor_id`),
  CONSTRAINT `instructortutorinstructorid` FOREIGN KEY (`instructor_id`) REFERENCES `usuario` (`id`),
  CONSTRAINT `instructortutortutorid` FOREIGN KEY (`tutor_id`) REFERENCES `usuario` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `instructortutor`
--

-- LOCK TABLES `instructortutor` WRITE;
/*!40000 ALTER TABLE `instructortutor` DISABLE KEYS */;
-- INSERT INTO `instructortutor` VALUES (1,26,4,1),(2,27,12,1),(3,28,11,1),(4,29,20,1),(5,30,20,1),(6,31,23,1),(7,32,24,1),(8,2,1,1),(9,10,24,1),(10,10,25,1),(11,26,1,1),(12,10,1,1),(13,34,1,1);
/*!40000 ALTER TABLE `instructortutor` ENABLE KEYS */;
-- UNLOCK TABLES;

--
-- Table structure for table `observacion_actividad_adecuacion`
--

DROP TABLE IF EXISTS `observacion_actividad_adecuacion`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `observacion_actividad_adecuacion` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `revision_id` int(11) DEFAULT NULL,
  `adecuacionactividad_id` int(11) DEFAULT NULL,
  `observaciones` longtext,
  `fecha` date DEFAULT NULL,
  `actual` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `observacionActividadAdecuacionActividad` (`adecuacionactividad_id`),
  KEY `observacionActividadRevision` (`revision_id`),
  CONSTRAINT `observacionActividadAdecuacionActividad` FOREIGN KEY (`adecuacionactividad_id`) REFERENCES `adecuacion_actividad` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `observacionActividadRevision` FOREIGN KEY (`revision_id`) REFERENCES `revision` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=35 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `observacion_actividad_adecuacion`
--


--
-- Table structure for table `observacion_actividad_informe`
--

DROP TABLE IF EXISTS `observacion_actividad_informe`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `observacion_actividad_informe` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `informe_actividad_id` int(11) DEFAULT NULL,
  `revision_id` int(11) DEFAULT NULL,
  `observaciones` longtext,
  `actual` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `observacionActividadinformeRevision` (`revision_id`),
  KEY `observacionActividadinformeinformeActividad` (`informe_actividad_id`),
  CONSTRAINT `observacionActividadinformeRevision` FOREIGN KEY (`revision_id`) REFERENCES `revision` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `observacionActividadinformeinformeActividad` FOREIGN KEY (`informe_actividad_id`) REFERENCES `informe_actividad` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=44 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `observacion_actividad_informe`
--

LOCK TABLES `observacion_actividad_informe` WRITE;
/*!40000 ALTER TABLE `observacion_actividad_informe` DISABLE KEYS */;
/*!40000 ALTER TABLE `observacion_actividad_informe` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `observacion_tutor`
--

DROP TABLE IF EXISTS `observacion_tutor`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `observacion_tutor` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `informe_actividad_id` int(11) DEFAULT NULL,
  `observaciones` longtext,
  `fecha` date DEFAULT NULL,
  `actual` tinyint(1) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `observacionTutorinformeActividad` (`informe_actividad_id`),
  CONSTRAINT `observacionTutorinformeActividad` FOREIGN KEY (`informe_actividad_id`) REFERENCES `informe_actividad` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=37 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `observacion_tutor`
--

LOCK TABLES `observacion_tutor` WRITE;
/*!40000 ALTER TABLE `observacion_tutor` DISABLE KEYS */;
/*!40000 ALTER TABLE `observacion_tutor` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `permiso`
--

DROP TABLE IF EXISTS `permiso`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `permiso` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `concepto` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `permiso`
--

LOCK TABLES `permiso` WRITE;
/*!40000 ALTER TABLE `permiso` DISABLE KEYS */;
/*!40000 ALTER TABLE `permiso` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `permisologia`
--

DROP TABLE IF EXISTS `permisologia`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `permisologia` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `permiso_id` int(11) DEFAULT NULL,
  `usuario_id` int(11) DEFAULT NULL,
  `attribute` varchar(255) DEFAULT NULL,
  `read` tinyint(1) DEFAULT NULL,
  `write` tinyint(1) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `permisologiaPermiso` (`permiso_id`),
  KEY `permisologiaUsuario` (`usuario_id`),
  CONSTRAINT `permisologiaPermiso` FOREIGN KEY (`permiso_id`) REFERENCES `permiso` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `permisologiaUsuario` FOREIGN KEY (`usuario_id`) REFERENCES `usuario` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `permisologia`
--

LOCK TABLES `permisologia` WRITE;
/*!40000 ALTER TABLE `permisologia` DISABLE KEYS */;
/*!40000 ALTER TABLE `permisologia` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `persona`
--

DROP TABLE IF EXISTS `persona`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `persona` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `usuario_id` int(11) DEFAULT NULL,
  `nombres` varchar(255) DEFAULT NULL,
  `apellidos` varchar(255) DEFAULT NULL,
  `fecha_nacimiento` date DEFAULT NULL,
  `ci` varchar(255) DEFAULT NULL,
  `telefono1` varchar(255) DEFAULT NULL,
  `telefono2` varchar(255) DEFAULT NULL,
  `direccion` varchar(255) DEFAULT NULL,
  `grado_instruccion` varchar(255) DEFAULT NULL,
  `area` varchar(255) DEFAULT NULL,
  `subarea` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `personausuario` (`usuario_id`),
  CONSTRAINT `personausuario` FOREIGN KEY (`usuario_id`) REFERENCES `usuario` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=53 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `persona`
--

LOCK TABLES `persona` WRITE;
/*!40000 ALTER TABLE `persona` DISABLE KEYS */;
INSERT INTO `persona` VALUES (28,1,'Zaira P. Yepez',NULL,NULL,'0',NULL,NULL,NULL,NULL,NULL,NULL),(29,2,'Concettina Di Vasta','',NULL,'10503806','','',NULL,'','Computación','Base de Datos'),(30,4,'Marisela Dominguez',NULL,NULL,'5299337',NULL,NULL,NULL,NULL,NULL,NULL),(31,10,'Renny Hernandez','',NULL,'17440014','','',NULL,'','',''),(32,11,'Manuel Maia',NULL,NULL,'16378282',NULL,NULL,NULL,NULL,NULL,NULL),(33,12,'Evelyn Zoppi',NULL,NULL,'1877100',NULL,NULL,NULL,NULL,NULL,NULL),(34,14,'Vansa Leguizamo',NULL,NULL,'13309245',NULL,NULL,NULL,NULL,NULL,NULL),(35,16,'Mariela Castillo',NULL,NULL,'6510885',NULL,NULL,NULL,NULL,NULL,NULL),(36,17,'Tomas Guardia',NULL,NULL,'14876973',NULL,NULL,NULL,NULL,NULL,NULL),(37,19,'Antonio Silva',NULL,NULL,'9663887',NULL,NULL,NULL,NULL,NULL,NULL),(38,20,'Caribay Urbina',NULL,NULL,'3973369',NULL,NULL,NULL,NULL,NULL,NULL),(39,22,'Myloa Morgado',NULL,NULL,'14351182',NULL,NULL,NULL,NULL,NULL,NULL),(40,23,'Irene Santos',NULL,NULL,'15152698',NULL,NULL,NULL,NULL,NULL,NULL),(41,24,'Rhadames Carmona',NULL,'0000-00-00','10804242','1234567','1234567','kajshsjkas','Licenciado','Computacion Grafica','computacion'),(42,25,'Ivan Flores',NULL,'0000-00-00','10334608','1234567','1234567','kajshsjkas','Licenciado','Inteligencia Artificial','Mineria de Datos'),(43,10,'RENNY ALEXANDER ','HERNANDEZ GUDIÑO',NULL,'17440014','04168126914','02126051065',NULL,NULL,NULL,NULL),(44,26,'Kenyer Eduardo','Aguiar Aponte',NULL,'19156429','04165340134','02469959109',NULL,NULL,'Matemática','Teoría de Operadores'),(45,27,'Rubén Erasmo','Torres Parra',NULL,'11405173','04164271024',NULL,NULL,NULL,'Ecología Acuática',NULL),(46,28,'Daniela Esperanza','Torrealba Gómez',NULL,'18031914','04126105810',NULL,NULL,NULL,'Álgebra y Lógica','teoría de Conjuntos y Teoría de Ramsey'),(47,29,'Natalia','Ortega Arias',NULL,'14906162','04141050855','02126051608',NULL,NULL,'Microscopía Electrónica','Catálisis'),(48,30,'Myloa Milagros','Morgado Vargas',NULL,'14351182','04142678127','02126051532',NULL,NULL,'Microscopía Electrónica','Catálisis'),(49,31,'Alfonso Gadir','Garmendia González',NULL,'18269302','04141203728','02392820128',NULL,NULL,'Matemática',NULL),(50,32,'Francisco Javier','Sans Palacios',NULL,'18244557','04127398830','02126051390',NULL,NULL,'Computación Gráfica',NULL),(51,34,'Jefferson','Santiago','1994-04-26','22540515','04168231673','04142144171','San Antonio de los Altos','Bachiller','Nose','Tampocose'),(52,36,'Secretaria J.','Uno W.',NULL,'10531496',NULL,NULL,NULL,NULL,NULL,NULL);
/*!40000 ALTER TABLE `persona` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `planformacion`
--

DROP TABLE IF EXISTS `planformacion`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `planformacion` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `fecha_inicio` date DEFAULT NULL,
  `fecha_fin` date DEFAULT NULL,
  `activo` tinyint(1) DEFAULT NULL,
  `instructor_id` int(11) DEFAULT NULL,
  `tutor_id` int(11) DEFAULT NULL,
  `fecha_modificacion` date DEFAULT NULL,
  `adscripcion_docencia` varchar(255) DEFAULT NULL,
  `adscripcion_investigacion` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `PlanFormacionInstructor` (`instructor_id`),
  KEY `PlanFormacionTutor` (`tutor_id`),
  CONSTRAINT `PlanFormacionInstructor` FOREIGN KEY (`instructor_id`) REFERENCES `usuario` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `PlanFormacionTutor` FOREIGN KEY (`tutor_id`) REFERENCES `usuario` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `planformacion`
--

LOCK TABLES `planformacion` WRITE;
/*!40000 ALTER TABLE `planformacion` DISABLE KEYS */;
/*!40000 ALTER TABLE `planformacion` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `prorroga`
--

DROP TABLE IF EXISTS `prorroga`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `prorroga` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `planformacion_id` int(11) DEFAULT NULL,
  `fecha_aprobacion` date DEFAULT NULL,
  `duracion` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `prorrogaPlanFormacion` (`planformacion_id`),
  CONSTRAINT `prorrogaPlanFormacion` FOREIGN KEY (`planformacion_id`) REFERENCES `planformacion` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `prorroga`
--

LOCK TABLES `prorroga` WRITE;
/*!40000 ALTER TABLE `prorroga` DISABLE KEYS */;
/*!40000 ALTER TABLE `prorroga` ENABLE KEYS */;
UNLOCK TABLES;


--
-- Table structure for table `respaldo`
--


DROP TABLE IF EXISTS `respaldo`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `respaldo` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `filename` varchar(255) DEFAULT NULL,
  `content_type` varchar(255) DEFAULT NULL,
  `file_contents` MEDIUMBLOB DEFAULT NULL,
  `created_at` datetime  NOT NULL,
  `version` int(3) NOT NULL,
  `actual` int(1) NOT NULL,
  `estatus` varchar(255) DEFAULT NULL,
  `instructor_id` int(11) DEFAULT NULL,
  `tutor_id` int(11) DEFAULT NULL,
  `adecuacion_id` int(11) DEFAULT NULL,
  `informe_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `respaldoinstructor` (`instructor_id`),
  KEY `respaldotutor` (`tutor_id`),
  KEY `respaldoadecuacion` (`adecuacion_id`),
  KEY `respaldoinforme` (`informe_id`),
  CONSTRAINT `respaldoinstructor` FOREIGN KEY (`instructor_id`) REFERENCES `usuario` (`id`),
  CONSTRAINT `respaldotutor` FOREIGN KEY (`tutor_id`) REFERENCES `usuario` (`id`),
  CONSTRAINT `respaldoadecuacion` FOREIGN KEY (`adecuacion_id`) REFERENCES `adecuacion` (`id`),
  CONSTRAINT `respaldoinforme` FOREIGN KEY (`informe_id`) REFERENCES `informe` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


--
-- Table structure for table `resultado`
--


DROP TABLE IF EXISTS `resultado`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `resultado` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `informe_actividad_id` int(11) DEFAULT NULL,
  `tipo_resultado_id` int(11) DEFAULT NULL,
  `concepto` longtext,
  `tipo_publicacion` varchar(255) DEFAULT NULL,
  `nombre_capitulo` varchar(255) DEFAULT NULL,
  `infoafiliaion` varchar(255) DEFAULT NULL,
  `cptipo` varchar(255) DEFAULT NULL,
  `nombre` varchar(255) DEFAULT NULL,
  `titulo` varchar(255) DEFAULT NULL,
  `autor` varchar(255) DEFAULT NULL,
  `autor_capitulo` varchar(255) DEFAULT NULL,
  `dia` int(11) DEFAULT NULL,
  `mes` varchar(255) DEFAULT NULL,
  `ano` int(11) DEFAULT NULL,
  `ciudad` varchar(255) DEFAULT NULL,
  `estado` varchar(255) DEFAULT NULL,
  `pais` varchar(255) DEFAULT NULL,
  `organizador` varchar(255) DEFAULT NULL,
  `duracion` varchar(255) DEFAULT NULL,
  `editor` varchar(255) DEFAULT NULL,
  `titulo_libro` varchar(255) DEFAULT NULL,
  `autor_libro` varchar(255) DEFAULT NULL,
  `nombre_revista` varchar(255) DEFAULT NULL,
  `nombre_periodico` varchar(255) DEFAULT NULL,
  `nombre_acto` varchar(255) DEFAULT NULL,
  `paginas` varchar(255) DEFAULT NULL,
  `nombre_paginaw` varchar(255) DEFAULT NULL,
  `sitio_paginaw` varchar(255) DEFAULT NULL,
  `url` varchar(255) DEFAULT NULL,
  `ISSN_impreso` varchar(255) DEFAULT NULL,
  `ISSN_electro` varchar(255) DEFAULT NULL,
  `volumen` varchar(255) DEFAULT NULL,
  `edicion` varchar(255) DEFAULT NULL,
  `DOI` varchar(255) DEFAULT NULL,
  `ISBN` varchar(255) DEFAULT NULL,
  `universidad` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `resultadoTipoResultado` (`tipo_resultado_id`),
  KEY `resultadoInformeActividad` (`informe_actividad_id`),
  CONSTRAINT `resultadoTipoResultado` FOREIGN KEY (`tipo_resultado_id`) REFERENCES `tipo_resultado` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `resultadoInformeActividad` FOREIGN KEY (`informe_actividad_id`) REFERENCES `informe_actividad` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `resultado`
--

LOCK TABLES `resultado` WRITE;
/*!40000 ALTER TABLE `resultado` DISABLE KEYS */;
/*!40000 ALTER TABLE `resultado` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `revision`
--

DROP TABLE IF EXISTS `revision`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `revision` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `informe_id` int(11) DEFAULT NULL,
  `fecha` date DEFAULT NULL,
  `usuario_id` int(11) DEFAULT NULL,
  `adecuacion_id` int(11) DEFAULT NULL,
  `estatus_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `revisionAdecuacion` (`adecuacion_id`),
  KEY `revisionTipoEstatus` (`estatus_id`),
  KEY `revisioninforme` (`informe_id`),
  KEY `revisionusuario` (`usuario_id`),
  CONSTRAINT `revisionAdecuacion` FOREIGN KEY (`adecuacion_id`) REFERENCES `adecuacion` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `revisionTipoEstatus` FOREIGN KEY (`estatus_id`) REFERENCES `tipo_estatus` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `revisioninforme` FOREIGN KEY (`informe_id`) REFERENCES `informe` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `revisionusuario` FOREIGN KEY (`usuario_id`) REFERENCES `usuario` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `revision`
--

LOCK TABLES `revision` WRITE;
/*!40000 ALTER TABLE `revision` DISABLE KEYS */;
/*!40000 ALTER TABLE `revision` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tipo_actividad`
--

DROP TABLE IF EXISTS `tipo_actividad`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tipo_actividad` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `concepto` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tipo_actividad`
--

LOCK TABLES `tipo_actividad` WRITE;
/*!40000 ALTER TABLE `tipo_actividad` DISABLE KEYS */;
INSERT INTO `tipo_actividad` VALUES (1,'Docencia'),(2,'Investigacion'),(3,'Extension'),(4,'Formacion'),(5,'Otras Actividad'),(6,'No Contempladas en el Plan');
/*!40000 ALTER TABLE `tipo_actividad` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tipo_estatus`
--

DROP TABLE IF EXISTS `tipo_estatus`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tipo_estatus` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `concepto` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tipo_estatus`
--

LOCK TABLES `tipo_estatus` WRITE;
/*!40000 ALTER TABLE `tipo_estatus` DISABLE KEYS */;
INSERT INTO `tipo_estatus` VALUES (1,'APROBADO POR CONSEJO DE FACULTAD'),(2,'ENVIADO A CONSEJO TÉCNICO'),(3,'ENVIADO A COMISIÓN DE INVESTIGACIÓN'),(4,'ENVIADO A CONSEJO DE FACULTAD'),(5,'APROBADO CON OBSERVACIONES POR CONSEJO DE FACULTAD'),(6,'GUARDADO'),(7,'EN REVISIÓN MENOR POR COMISIÓN DE INVESTIGACIÓN'),(8,'ENVIADO A CONSEJO DE ESCUELA'),(9, 'RECHAZADO POR CONSEJO DE FACULTAD');
/*!40000 ALTER TABLE `tipo_estatus` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tipo_informe`
--

DROP TABLE IF EXISTS `tipo_informe`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tipo_informe` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `tipo` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tipo_informe`
--

LOCK TABLES `tipo_informe` WRITE;
/*!40000 ALTER TABLE `tipo_informe` DISABLE KEYS */;
INSERT INTO `tipo_informe` VALUES (1,'Semestral'),(2,'Anual'),(3,'Final');
/*!40000 ALTER TABLE `tipo_informe` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tipo_resultado`
--

DROP TABLE IF EXISTS `tipo_resultado`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tipo_resultado` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `concepto` longtext,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tipo_resultado`
--

LOCK TABLES `tipo_resultado` WRITE;
/*!40000 ALTER TABLE `tipo_resultado` DISABLE KEYS */;
INSERT INTO `tipo_resultado` VALUES (1,'Trabajos publicados'),(2,'Presentacin de ponencias'),(3,'Presentacin de informes tcnicos'),(4,'Otros'),(5,'Asistencia a eventos cientficos'),(6,'Organizacin de eventos cientficos'),(7,'Dictado de cursos o seminarios cientficos'),(8,'Grado de avance en los estudios de postgrado'),(9,'No contempladas en en el plan');
/*!40000 ALTER TABLE `tipo_resultado` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `usuario`
--

DROP TABLE IF EXISTS `usuario`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `usuario` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user` varchar(255) DEFAULT NULL,
  `ldap` tinyint(1) DEFAULT NULL,
  `activo` tinyint(1) DEFAULT NULL,
  `password` varchar(255) DEFAULT NULL,
  `email` varchar(255) DEFAULT NULL,
  `tipo` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=37 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `usuario`
--

LOCK TABLES `usuario` WRITE;
/*!40000 ALTER TABLE `usuario` DISABLE KEYS */;
INSERT INTO `usuario` VALUES (1,'zairap.yepez',1,1,NULL,NULL,'Docente'),(2,'tdivasta',1,1,NULL,NULL,'Docente'),(3,'comisioninv.computacion',1,1,NULL,NULL,'Institucional'),(4,'marisela.dominguez',1,1,NULL,NULL,'Docente'),(5,'comisioninv.matematica',1,1,NULL,NULL,'Institucional'),(6,'consejo.matematica',1,1,NULL,NULL,'Institucional'),(7,'seconfac',1,1,NULL,NULL,'Docente'),(8,'consejo.computacion',1,1,NULL,NULL,'Institucional'),(9,'consultace.matematica',1,1,NULL,NULL,'Institucional'),(10,'renny.hernandez',1,1,NULL,NULL,'Docente'),(11,'manuel.maia',1,1,NULL,NULL,'Docente'),(12,'ezoppi',1,1,NULL,NULL,'Docente'),(13,'consultaci.computacion',1,1,NULL,NULL,'Docente'),(14,'vleguiza',1,1,NULL,NULL,'Docente'),(15,'consultaci.matematica',1,1,NULL,NULL,'Docente'),(16,'mariela.castillo',1,1,NULL,NULL,'Docente'),(17,'tomas_guardia',1,1,NULL,NULL,'Docente'),(18,'consulta.seconfac',1,1,NULL,NULL,'Docente'),(19,'asilva',1,1,NULL,NULL,'Docente'),(20,'curbina',1,1,NULL,NULL,'Docente'),(21,'consultace.computacion',1,1,NULL,NULL,'Docente'),(22,'myloa.morgado',1,1,NULL,NULL,'Docente'),(23,'irene.santos',1,1,NULL,NULL,'Docente'),(24,'rhadames.carmona',1,1,NULL,NULL,'Docente'),(25,'ivan.flores',1,1,NULL,NULL,'Docente'),(26,'kenyer.aguiar',1,1,NULL,NULL,'Docente'),(27,'ruben.torres',1,1,NULL,NULL,'Docente'),(28,'daniela.torrealba',1,1,NULL,NULL,'Docente'),(29,'natalia.ortega',1,1,NULL,NULL,'Docente'),(30,'myloa.morgado',1,1,NULL,NULL,'Docente'),(31,'alfonso.garmendia',1,1,NULL,NULL,'Docente'),(32,'francisco.sans',1,1,NULL,NULL,'Docente'),(34,'jefferson.santiago',0,1,'4659589','jefferson.santiago','Docente'),(35,'consejo.facultad',1,1,NULL,NULL,'Institucional'),(36,'secretaria.uno',0,1,'secretaria','secretaria.uno','Secretaria');
/*!40000 ALTER TABLE `usuario` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `usuarioentidad`
--

DROP TABLE IF EXISTS `usuarioentidad`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `usuarioentidad` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `usuario_id` int(11) DEFAULT NULL,
  `entidad_id` int(11) DEFAULT NULL,
  `escuela_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `usuarioEntidadEntidad` (`entidad_id`),
  KEY `usuarioEntidadUsuario` (`usuario_id`),
  KEY `usuarioEscuela` (`escuela_id`),
  CONSTRAINT `usuarioEscuela` FOREIGN KEY (`escuela_id`) REFERENCES `escuela` (`id`),
  CONSTRAINT `usuarioEntidadEntidad` FOREIGN KEY (`entidad_id`) REFERENCES `entidad` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `usuarioEntidadUsuario` FOREIGN KEY (`usuario_id`) REFERENCES `usuario` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=37 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `usuarioentidad`
--

LOCK TABLES `usuarioentidad` WRITE;
/*!40000 ALTER TABLE `usuarioentidad` DISABLE KEYS */;
INSERT INTO `usuarioentidad` VALUES (1,1,18,2),(2,2,18,2),(3,3,8,2),(4,4,18,NULL),(5,5,11,9),(6,6,5,9),(7,7,13,11),(8,8,2,2),(9,9,11,9),(10,10,18,12),(11,11,18,NULL),(12,12,18,NULL),(13,13,8,2),(14,14,18,NULL),(15,15,5,9),(16,16,18,9),(17,17,18,9),(18,18,13,11),(19,19,18,NULL),(20,20,18,1),(21,21,8,2),(22,22,18,NULL),(23,23,18,NULL),(24,24,18,2),(25,25,18,2),(26,26,19,NULL),(27,27,19,NULL),(28,28,19,NULL),(29,29,19,NULL),(30,30,19,NULL),(31,31,19,NULL),(32,32,19,12),(34,34,19,2),(35,35,13,NULL),(36,36,2,2);
/*!40000 ALTER TABLE `usuarioentidad` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2016-02-05 14:30:27
