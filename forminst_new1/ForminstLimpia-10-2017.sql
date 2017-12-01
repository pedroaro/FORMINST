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
) ENGINE=InnoDB AUTO_INCREMENT=0 DEFAULT CHARSET=utf8;
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
) ENGINE=InnoDB AUTO_INCREMENT=0 DEFAULT CHARSET=utf8;
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
  `mensaje` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `adecuacionPlanformacion` (`planformacion_id`),
  KEY `adecuacionUsuario` (`tutor_id`),
  CONSTRAINT `adecuacionPlanformacion` FOREIGN KEY (`planformacion_id`) REFERENCES `planformacion` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `adecuacionUsuario` FOREIGN KEY (`tutor_id`) REFERENCES `usuario` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=0 DEFAULT CHARSET=utf8;
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
) ENGINE=InnoDB AUTO_INCREMENT=0 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `adecuacion_actividad`
--

LOCK TABLES `adecuacion_actividad` WRITE;
/*!40000 ALTER TABLE `adecuacion_actividad` DISABLE KEYS */;
/*!40000 ALTER TABLE `adecuacion_actividad` ENABLE KEYS */;
UNLOCK TABLES;

DROP TABLE IF EXISTS `departamento`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `departamento` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `nombre` varchar(255) DEFAULT NULL,
  `escuela_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `escuelaDepartamento` (`escuela_id`),
  CONSTRAINT `escuelaDepartamento` FOREIGN KEY (`escuela_id`) REFERENCES `escuela` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=0 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `departamento`
--

LOCK TABLES `departamento` WRITE;
/*!40000 ALTER TABLE `departamento` DISABLE KEYS */;
INSERT INTO `departamento` VALUES (1,'Departamento de Biología Celular', 1),(2,'Departamento de Botanica', 1),(3,'Departamento de Ecología', 1),(4,'Departamento de Tecnología de Alimentos', 1),(5,'Departamento de Zoología',1),(6,'Centro de Microscopía Electrónica',1),(7,'Departamento de Física',3),(8,'Departamento de Química',10),(9,'Departamento de Computación',2),(10,'Departamento de Geoquímica', 4),(11,'Departamento de Matemática',9),(12,'Desconocida', 12);
/*!40000 ALTER TABLE `departamento` ENABLE KEYS */;
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
  `actividad_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `documentinstructor` (`instructor_id`),
  KEY `documenttutor` (`tutor_id`),
  KEY `documentadecuacion` (`adecuacion_id`),
  KEY `documentinforme` (`informe_id`),
  KEY `documentactividad` (`actividad_id`),
  CONSTRAINT `documentinstructor` FOREIGN KEY (`instructor_id`) REFERENCES `usuario` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `documenttutor` FOREIGN KEY (`tutor_id`) REFERENCES `usuario` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `documentadecuacion` FOREIGN KEY (`adecuacion_id`) REFERENCES `adecuacion` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `documentinforme` FOREIGN KEY (`informe_id`) REFERENCES `informe` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `documentactividad` FOREIGN KEY (`actividad_id`) REFERENCES `actividad` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
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
) ENGINE=InnoDB AUTO_INCREMENT=0 DEFAULT CHARSET=utf8;
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
) ENGINE=InnoDB AUTO_INCREMENT=0 DEFAULT CHARSET=utf8;
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
) ENGINE=InnoDB AUTO_INCREMENT=0 DEFAULT CHARSET=utf8;
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
) ENGINE=InnoDB AUTO_INCREMENT=0 DEFAULT CHARSET=utf8;
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
  `justificaciones` longtext,
  PRIMARY KEY (`id`),
  KEY `informePlanFormacion` (`planformacion_id`),
  KEY `informeusuario` (`tutor_id`),
  KEY `informetipo` (`tipo_id`),
  CONSTRAINT `informetipo` FOREIGN KEY (`tipo_id`) REFERENCES `tipo_informe` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `informePlanFormacion` FOREIGN KEY (`planformacion_id`) REFERENCES `planformacion` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `informeusuario` FOREIGN KEY (`tutor_id`) REFERENCES `usuario` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=0 DEFAULT CHARSET=utf8;
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
) ENGINE=InnoDB AUTO_INCREMENT=0 DEFAULT CHARSET=utf8;
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
  CONSTRAINT `notificacioninstructor` FOREIGN KEY (`instructor_id`) REFERENCES `usuario` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `notificaciontutor` FOREIGN KEY (`tutor_id`) REFERENCES `usuario` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `notificacionadecuacion` FOREIGN KEY (`adecuacion_id`) REFERENCES `adecuacion` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `notificacioninforme` FOREIGN KEY (`informe_id`) REFERENCES `informe` (`id`) ON DELETE CASCADE ON UPDATE CASCADE

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
  CONSTRAINT `instructortutorinstructorid` FOREIGN KEY (`instructor_id`) REFERENCES `usuario` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `instructortutortutorid` FOREIGN KEY (`tutor_id`) REFERENCES `usuario` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=0 DEFAULT CHARSET=utf8;
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
) ENGINE=InnoDB AUTO_INCREMENT=0 DEFAULT CHARSET=utf8;
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
) ENGINE=InnoDB AUTO_INCREMENT=0 DEFAULT CHARSET=utf8;
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
) ENGINE=InnoDB AUTO_INCREMENT=0 DEFAULT CHARSET=utf8;
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
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `persona`
--

LOCK TABLES `persona` WRITE;
/*!40000 ALTER TABLE `persona` DISABLE KEYS */;
INSERT INTO `persona` VALUES (52,36,'Secretaria J.','Uno W.',NULL,'10531496',NULL,NULL,NULL,NULL,NULL,NULL),(57,47,'Secretaria J.','Biología',NULL,'10531496',NULL,NULL,NULL,NULL,NULL,NULL);
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
  `mensaje` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `PlanFormacionInstructor` (`instructor_id`),
  KEY `PlanFormacionTutor` (`tutor_id`),
  CONSTRAINT `PlanFormacionInstructor` FOREIGN KEY (`instructor_id`) REFERENCES `usuario` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `PlanFormacionTutor` FOREIGN KEY (`tutor_id`) REFERENCES `usuario` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=0 DEFAULT CHARSET=utf8;
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
  CONSTRAINT `respaldoinstructor` FOREIGN KEY (`instructor_id`) REFERENCES `usuario` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `respaldotutor` FOREIGN KEY (`tutor_id`) REFERENCES `usuario` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `respaldoadecuacion` FOREIGN KEY (`adecuacion_id`) REFERENCES `adecuacion` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `respaldoinforme` FOREIGN KEY (`informe_id`) REFERENCES `informe` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
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
INSERT INTO `tipo_actividad` VALUES (1,'Docencia'),(2,'Investigacion'),(3,'Extension'),(4,'Formacion'),(5,'Otras Actividad'),(6,'No Contempladas en el Plan'), (7,'Obligatorias'), (8,'Descripcion'), (9,'Presentacion');
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
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tipo_estatus`
--

LOCK TABLES `tipo_estatus` WRITE;
/*!40000 ALTER TABLE `tipo_estatus` DISABLE KEYS */;
INSERT INTO `tipo_estatus` VALUES (1,'APROBADO POR CONSEJO DE FACULTAD'),(2,'ENVIADO A CONSEJO TÉCNICO'),(3,'ENVIADO A COMISIÓN DE INVESTIGACIÓN'),(4,'ENVIADO A CONSEJO DE FACULTAD'),(5,'APROBADO CON OBSERVACIONES POR CONSEJO DE FACULTAD'),(6,'GUARDADO'),(7,'EN REVISIÓN MENOR POR COMISIÓN DE INVESTIGACIÓN'),(8,'ENVIADO A CONSEJO DE ESCUELA'),(9, 'RECHAZADO POR CONSEJO DE FACULTAD'),(12, 'ENVIADO A CONSEJO TÉCNICO SIN REVISIÓN'),(13, 'ENVIADO A COMISIÓN DE INVESTIGACIÓN SIN REVISIÓN'),(14, 'ENVIADO A CONSEJO DE FACULTAD SIN REVISIÓN'),(18, 'ENVIADO A CONSEJO DE ESCUELA SIN REVISIÓN');
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
) ENGINE=InnoDB AUTO_INCREMENT=22 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `usuario`
--

LOCK TABLES `usuario` WRITE;
/*!40000 ALTER TABLE `usuario` DISABLE KEYS */;
INSERT INTO `usuario` VALUES (1, "departamento.biologia.celular",0,1,"dbc","departamento.biologia.celular","Institucional"), (2, "departamento.botanica",0,1,"db","departamento.botanica","Institucional"), (3, "departamento.ecologia",0,1,"de","departamento.ecologia","Institucional"), (4, "departamento.tecnologia.alimentos",0,1,"dta","departamento.tecnologia.alimentos","Institucional"), (5, "departamento.zoologia",0,1,"dz","departamento.zoologia","Institucional"), (6, "centro.microscopia.electronica",0,1,"cme","centro.microscopia.electronica","Institucional"), (7, "escuela.biologia",0,1,"eb","escuela.biologia","Institucional"), (8, "comision.investigacion.fisica",0,1,"cif","comision.investigacion.fisica","Institucional"), (9, "consejo.escuela.fisica",0,1,"cef","consejo.escuela.fisica","Institucional"), (10, "comision.investigacion.quimica",0,1,"ciq","comision.investigacion.quimica","Institucional"), (11, "consejo.escuela.quimica",0,1,"ceq","consejo.escuela.quimica","Institucional"), (12, "comision.investigacion.computacion",0,1,"cic","comision.investigacion.computacion","Institucional"), (13, "consejo.escuela.computacion",0,1,"cec","consejo.escuela.computacion","Institucional"), (14, "comision.investigacion.geoquimica",0,1,"cig","comision.investigacion.geoquimica","Institucional"), (15, "consejo.escuela.geoquimica",0,1,"ceg","consejo.escuela.geoquimica","Institucional"), (16, "comision.investigacion.matematica",0,1,"cim","comision.investigacion.matematica","Institucional"), (17, "consejo.escuela.matematica",0,1,"cem","consejo.escuela.matematica","Institucional"), (18, "consejo.facultad",0,1,"cf","consejo.facultad","Institucional"), (19, "consejo.ibe",0,1,"cibe","consejo.ibe","Institucional"), (20, "consejo.ict",0,1,"cict","consejo.ict","Institucional"), (21, "consejo.icta",0,1,"cicta","consejo.icta","Institucional"), (22, "consejo.izet",0,1,"izet","consejo.izet","Institucional");
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
  `departamento_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `usuarioEntidadEntidad` (`entidad_id`),
  KEY `usuarioEntidadUsuario` (`usuario_id`),
  KEY `usuarioEscuela` (`escuela_id`),
  KEY `departamentoUsuario` (`departamento_id`),
  CONSTRAINT `usuarioEscuela` FOREIGN KEY (`escuela_id`) REFERENCES `escuela` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `usuarioEntidadEntidad` FOREIGN KEY (`entidad_id`) REFERENCES `entidad` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `usuarioEntidadUsuario` FOREIGN KEY (`usuario_id`) REFERENCES `usuario` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `departamentoUsuario` FOREIGN KEY (`departamento_id`) REFERENCES `departamento` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=23 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `usuarioentidad`
--

LOCK TABLES `usuarioentidad` WRITE;
/*!40000 ALTER TABLE `usuarioentidad` DISABLE KEYS */;
INSERT INTO `usuarioentidad` VALUES (1,1,7,1,1), (2,2,7,1,2), (3,3,7,1,3), (4,4,7,1,4), (5,5,7,1,5), (6,6,7,1,6), (7,7,1,1,NULL), (8,8,9,3,7), (9,9,3,3,NULL), (10,10,12,10,8), (11,11,6,10,NULL), (12,12,8,2,9), (13,13,2,2,NULL), (14,14,10,4,10), (15,15,4,4,null), (16,16,11,9,11), (17,17,5,9,NULL), (18,18,13,NULL,NULL), (19,19,14,NULL,NULL), (20,20,15,NULL,NULL), (21,21,16,NULL,NULL), (22,22,17,NULL,NULL);
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
