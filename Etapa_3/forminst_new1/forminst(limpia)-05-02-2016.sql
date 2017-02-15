-- MySQL dump 10.13  Distrib 5.6.23, for Win32 (x86)
--
-- Host: localhost    Database: forminst
-- ------------------------------------------------------
-- Server version	5.6.23-log

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
) ENGINE=InnoDB AUTO_INCREMENT=434 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `actividad`
--

LOCK TABLES `actividad` WRITE;
/*!40000 ALTER TABLE `actividad` DISABLE KEYS */;
INSERT INTO `actividad` VALUES (47,1,'Dictar un curso de Pregrado',0),(48,1,'Dictar un curso de Pregrado',0),(49,1,'Dictar un curso de Pregrado',0),(50,1,'Dictar un curso de Pregrado',0),(51,2,'Realizar al menos una exposición en el Seminario de Análisis',0),(52,2,'Realizar al menos una exposición en el Seminario de Análisis',0),(53,2,'Realizar al menos una exposición en el Seminario de Análisis',0),(54,2,'Realizar al menos una exposición en el Seminario de Análisis',0),(59,2,'Redacción del Trabajo de Grado de Maestría',0),(60,2,'Estudiar el artículo publicado por Y. Kakihara en Kodai Math. J., en el año 1983, donde se dan aplicaciones al análisis armónico de los módulos de Hilbert',0),(61,2,'Presentación y defensa del Trabajo de Grado de Maestría',0),(62,2,'Estudiar espacios de Hilbert con núcleo reproductor',0),(63,2,'Realizar una revisión bibliográfica de libros relacionados con los temas de\r\nMódulos C*, preferiblemente el libro de Lance y el libro de Manuilov y Troitsky',0),(64,2,'Formulación oral en privado, ante algunos doctores del Centro de Análisis Matemático, de posibles nuevos proyectos de investigación',0),(65,2,'Comenzará a redactar una monografía que debe incluir los resultados obtenidos en el Trabajo de Grado de Maestría y resultados de investigación adicionales',0),(66,2,'Formulación oral en privado, ante algunos doctores del Centro de Análisis Matemático, de posibles nuevos proyectos de investigación',0),(67,2,'Presentar y discutir en público, en el Seminario de Análisis, las posibilidades de desarrollos futuros de su trabajo de investigación',0),(68,2,'Culminará la redacción de una monografía que debe incluir los resultados obtenidos en el Trabajo de Grado de Maestría y resultados de investigación adicionales, en la misma línea de investigación, que a juicio del tutor del Plan de Formación resulten\r\nsuficientes para la culminación del plan\r\n',0),(69,2,'Se recomienda cursar estudios de algún idioma extranjero. Esta actividad está sujeta a disponibilidad de financiamiento',0),(70,5,'Realizar las actividad administrativas y de extensión que le sean asignadas por la Escuela o la Facultad. Estas actividad deberían contar con el aval del tutor',0),(71,5,'Realizar las actividad administrativas y de extensión que le sean asignadas por la Escuela o la Facultad. Estas actividad deberían contar con el aval del tutor',0),(72,5,'Realizar las actividad administrativas y de extensión que le sean asignadas por la Escuela o la Facultad. Estas actividad deberían contar con el aval del tutor',0),(73,5,'Realizar las actividad administrativas y de extensión que le sean asignadas por la Escuela o la Facultad. Estas actividad deberían contar con el aval del tutor',0),(74,4,'Asistir a las exposiciones que se realizan en el Seminario de Análisis',0),(75,4,'Asistir a las exposiciones que se realizan en el Seminario de Análisis',0),(76,4,'Asistir a las exposiciones que se realizan en el Seminario de Análisis',0),(77,4,'Asistir a las exposiciones que se realizan en el Seminario de Análisis',0),(78,4,'Consignar el certificado de aprobación del curso de capacitación docente',0),(79,4,'Consignar ante la oficina del Postgrado en Matemática el ejemplar del Trabajo de Grado de Maestría, para solicitar el nombramiento del jurado',0),(80,4,'Solicitar admisión al Doctorado en Matemática',0),(81,4,'Consignar el certificado de aprobación del curso de Inducción al Servicio Comunitario',0),(82,4,'Inscribirse en el Doctorado en Matemática ante la Secretaría de la UCV',0),(83,4,'Aprobar al menos dos créditos en el Doctorado en Matemática',0),(84,4,'Aprobar al menos dos créditos en el Doctorado en Matemática.',0),(85,4,'Solicitar reconocimiento de créditos de las asignaturas que aprobó en la maestría que también son asignaturas del doctorado. Estas son cuatro obligatorias: Análisis Real, Probabilidades, Variable Compleja y Algebra (de 5 créditos cada una) y tres electivas (de 4 créditos cada una). Total 32 créditos',0),(86,4,'Aprobar al menos dos créditos en el Doctorado en Matemática',0),(87,4,'Consignar el título de Magister Scientiarum',0),(88,4,'Inscribir en el Doctorado en Matemáticas la asignatura Proyecto de Tesis',0),(89,3,'Participar en las actividad de extensión propias de la Facultad de Ciencias, en especial en aquellas que se desarrollen desde la Escuela de Matemática',0),(90,3,'Participar en las actividad de extensión propias de la Facultad de Ciencias, en especial en aquellas que se desarrollen desde la Escuela de Matemática',0),(91,3,'Participar en las actividad de extensión propias de la Facultad de Ciencias, en especial en aquellas que se desarrollen desde la Escuela de Matemática',0),(92,3,'Participar en las actividad de extensión propias de la Facultad de Ciencias, en especial en aquellas que se desarrollen desde la Escuela de Matemática',0),(93,3,'Desempeñarse como tutor de servicio comunitario en caso de que le sea asignada esta tarea',0),(94,3,'Desempeñarse como tutor de servicio comunitario en caso de que le sea asignada esta tarea',0),(95,3,'Desempeñarse como tutor de servicio comunitario en caso de que le sea asignada esta tarea',0),(96,3,'Desempeñarse como tutor de servicio comunitario en caso de que le sea asignada esta tarea',0),(97,2,'Cumplir con lo estipulado en el literal (a) de la disposición del Consejo de Facultad del día 04 de abril de 2005, es decir deberá:\r\n(i)	 Tener la escolaridad completa de la Maestría.\r\n(ii)	 Aprobar el Trabajo de Grado de Maestría.\r\n',0),(98,2,'Deberá cumplir al menos dos de las siguientes condiciones:\r\n(i)	 Presentar un trabajo de investigación en un evento científico.\r\n(ii)	 Tomar un curso en la Escuela Venezolana de Matemáticas.\r\n(iii)	 Poseer una publicación en una revista especializada.\r\n(iv)	 Haber realizado al menos tres exposiciones en el Seminario de Análisis, que cuenten con evaluación positiva por parte del coordinador o los coordinadores del seminario.\r\n',0),(99,4,'Aprobar las asignaturas obligatorias, electivas y seminarios que corresponden al programa de Doctorado en Matemática, en cuanto a la asignatura Proyecto de Tesis Doctoral deberá inscribirla.',0),(100,1,'Participar en la asignatura obligatoria de pregrado Laboratorio de Ecología II',0),(101,1,'Participación en la asignatura obligatoria de pregrado Laboratorio de Ecología I',0),(102,1,'Participación en la asignatura obligatoria de pregrado Laboratorio de Ecología II',0),(103,1,'Participación en la asignatura obligatoria de Pregrado Laboratorio de Ecología I.\r\nParticipación en la asignatura electiva de pregrado Introducción al Plancton.',0),(104,2,'Asistir al X Congreso Venezolano de Ecología (CVE) en la ciudad de Mucumbarila Edo. Mérida Venezuela, noviembre 2013.\r\nParticipar en el proyecto \"Implicaciones de comunidades planctonicas en la calidad del agua y su potencialidad para la producción pesquera de la Laguna de Tacarigua en beneficio de comunidades aledañas, Edo. Miranda\"\r\nParticipar en el proyecto \"Desarrollo de un modelo para conservación de ecosistemas amenazados por el cambio climático mediante la caracterización ecológica de un sistema de menor escala\"',0),(105,2,'Desarrollo de un Proyecto de investigación individual dentro del área de Ecología de Plancton',0),(106,4,'Asistencia a cursos de capacitación, dictado por SADPRO.',0),(107,3,'Actividad de extensión inherentes al quehacer universitario y aquellas en las que el IZET requiera.',0),(108,2,'Asistencia a eventos científicos, así como preparación de manuscritos a ser publicados.',0),(109,6,'Es integrante de la comisión de extensión de la Facultad de Ciencias.',0),(177,1,'Dictar un curso de Pregrado',0),(178,6,'Es integrante de la comisión de extensión de la Facultad de Ciencias.',0),(179,4,'Consignar ante la oficina del Postgrado en Matemática el ejemplar del Trabajo de Grado de Maestría, para solicitar el nombramiento del jurado',0),(180,6,'Es integrante de la comisión de extensión de la Facultad de Ciencias.',0),(181,4,'Solicitar admisión al Doctorado en Matemática',0),(182,6,'Es integrante de la comisión de extensión de la Facultad de Ciencias.',0),(183,6,'Es integrante de la comisión de extensión de la Facultad de Ciencias.',0),(184,4,'Solicitar admisión al Doctorado en Matemática',0),(185,6,'Es integrante de la comisión de extensión de la Facultad de Ciencias.',0),(186,4,'Consignar ante la oficina del Postgrado en Matemática el ejemplar del Trabajo de Grado de Maestría, para solicitar el nombramiento del jurado',0),(187,6,'Es integrante de la comisión de extensión de la Facultad de Ciencias.',0),(188,1,'Dictar un curso de Pregrado',0),(189,6,'Es integrante de la comisión de extensión de la Facultad de Ciencias.',0),(190,1,'Dictar un curso de Pregrado',0),(191,6,'Es integrante de la comisión de extensión de la Facultad de Ciencias.',0),(192,4,'Solicitar admisión al Doctorado en Matemática',0),(193,6,'Es integrante de la comisión de extensión de la Facultad de Ciencias.',0),(194,2,'Realizar al menos una exposición en el Seminario de Análisis',0),(195,2,'Redacción del Trabajo de Grado de Maestría',0),(196,2,'Estudiar el artículo publicado por Y. Kakihara en Kodai Math. J., en el ao 1983, donde se dan aplicaciones al análisis armónico de los mdulos de Hilbert',0),(197,4,'Asistir a las exposiciones que se realizan en el Seminario de Análisis',0),(198,4,'Consignar el certificado de aprobación del curso de capacitación docente',0),(199,4,'Consignar ante la oficina del Postgrado en Matemática el ejemplar del Trabajo de Grado de Maestría, para solicitar el nombramiento del jurado',0),(200,1,'Dictar un curso de Pregrado ',0),(201,3,'Participar en las actividad de extensión propias de la Facultad de Ciencias, en especial en aquellas que se desarrollen desde la Escuela de Matemática',0),(202,3,'Desempeñarse como tutor de servicio comunitario en caso de que le sea asignada esta tarea',0),(203,1,'Dictar la asignatura que le sea asignada por el Departamento de Matemática.',0),(204,1,'Dictar la asignatura que le sea asignada por el Departamento de Matemática.',0),(205,1,'Dictar la asignatura que le sea asignada por el Departamento de Matemática.',0),(206,1,'Dictar la asignatura que le sea asignada por el Departamento de Matemática.',0),(211,4,'Inscribir el trabajo de grado de Maestría.',0),(212,4,'Se recomienda tomar el curso de Inducción al Servicio Comunitario en este período.',0),(213,4,'Se recomienda tomar el curso de capacitación docente en este período.',0),(214,4,'Asistir a las exposiciones del seminario de Lógica.',0),(215,4,'Culminar la redacción del Trabajo de Grado de Maestría y solicitar nombramiento de Jurado. Se recomienda su defensa en este período.',0),(216,4,'Realizar el Curso de Inducción de Servicio Comunitario, en caso de no haberlo realizado el semestre anterior. ',0),(217,4,'Realizar el curso de capacitación docente en este período, en caso de no haberlo realizado el semestre anterior.',0),(218,4,'Se recomienda cursar estudios de algún idioma extranjero.  Esta actividad está sujeta a disponibilidad de financiamiento.',0),(219,4,'Asistir a las exposiciones del seminario de Lógica.',0),(220,4,'Inscribirse en el programa de Doctorado del Postgrado en Matemática.',0),(221,4,'Inscribir y  aprobar al menos 5 créditos del programa de Doctorado del Postgrado en Matemática.',0),(222,4,'Asistir a las exposiciones del seminario de Lógica.',0),(223,4,'Se recomienda cursar estudios de algún idioma extranjero.  Esta actividad está sujeta a disponibilidad de financiamiento.',0),(224,4,'Inscribir y aprobar al menos 4 créditos del programa de Doctorado del Postgrado en Matemática.',0),(225,4,'Asistir a las exposiciones del seminario de Lógica.',0),(226,2,'Iniciar la redacción del Trabajo de Grado de Maestría.',0),(227,2,'Realizar una exposición en el Seminario de Lógica.',0),(228,2,'Realizar al menos una exposición  en alguno de los seminarios que tienen lugar en la Escuela de Matemática relacionada con su proyecto de Trabajo de Grado de Maestría.',0),(229,2,'Se recomienda la defensa de su Trabajo de Grado de Maestría en este período.',0),(230,2,'Defender el Trabajo de grado de Maestría, en caso de no haberlo realizado en el período anterior.',0),(231,2,'Presentar los resultados de su trabajo de Grado de Maestría en algún evento científico, nacional o internacional, en caso de contar con financiamiento.',0),(232,2,'Realizar una pasantía en algún Instituto de Investigación de prestigio Esta actividad está sujeta a disponibilidad de financiamiento.',0),(233,2,'Realizar una pasantía en algún Instituto de Investigación de prestigio. Esta actividad está sujeta a disponibilidad de financiamiento.',0),(234,2,'Formular en forma oral posibles proyectos de investigación.',0),(235,2,'Presentar y discutir en el seminario de Lógica las posibilidades de desarrollos futuros que hayan surgido de los resultados de su Trabajo de Grado de Maestría.',0),(236,3,'Participar en las actividad de extensión propias de la  Facultad de Ciencias, en especial en aquellas que se desarrollen desde la Escuela de Matemática.\r\n',0),(237,3,'Participar en las actividad de extensión propias de la  Facultad de Ciencias, en especial en aquellas que se desarrollen desde la Escuela de Matemática. ',0),(238,3,'Desempeñarse como tutor de servicio comunitario en caso de que le sea asignada esta tarea.',0),(239,3,'Participar en las actividad de extensión propias de la  Facultad de Ciencias, en especial en aquellas que se desarrollen desde la Escuela de Matemática.',0),(240,3,'Desempeñarse como tutor de servicio comunitario en caso de que le sea asignada esta tarea.',0),(241,3,'Participar en las actividad de extensión propias de la  Facultad de Ciencias, en especial en aquellas que se desarrollen desde la Escuela de Matemática.',0),(242,3,'Desempeñarse como tutor de servicio comunitario en caso de que le sea asignada esta tarea.',0),(243,5,'Realizar las actividad administrativas y de extensión que le sean asignadas por la Escuela o la Facultad.',0),(244,5,'Realizar las actividad administrativas y de extensión que le sean asignadas por la Escuela.',0),(245,5,'Realizar las actividad administrativas y de extensión que le sean asignadas por la Escuela.',0),(246,5,'Realizar las actividad administrativas y de extensión que le sean asignadas por la Escuela.',0),(247,6,'Es integrante de la Comisión de Extensión de la Escuela de Matemática',0),(268,1,' Participar en la asignatura “Introducción a la ME”, dictada para los pregrados de Física, Geoquímica y Química',0),(269,1,'Participar en la asignatura “Principios de Fisicoquímica” del pregrado de la Escuela de Biología',0),(270,1,'Participar en la asignatura “Introducción a la ME”, dictada para los pregrados de Física, Geoquímica y Química',0),(271,1,'Participar en la asignatura “Principios de Fisicoquímica” del pregrado de la Escuela de Biología',0),(272,2,'Realizar la Revisión bibliográfica relacionada con su Tesis Doctoral. ',0),(273,2,'Sintetizar aluminosilicatos a base de materia prima nacional, correspondientes a la  Tesis Doctoral.\r\n',0),(275,2,'Caracterizar las estructuras sintetizadas\r\n\r\n',0),(276,4,'Realizar un curso de capacitación docente y el curso de Inducción del Servicio Comunitario. Todos los cursos deben ser certificados por la Universidad Central de Venezuela\r\n\r\n',0),(277,4,'Realizar un curso de capacitación docente y culminar un  curso de Inducción del Servicio Comunitario. Todos los cursos deben ser certificados por la Universidad Central de Venezuela\r\n\r\n',0),(278,4,'Culminar un curso de capacitación docente certificado por la Universidad Central de Venezuela\r\n\r\n',0),(279,4,'Publicar un artículo en una revista indexada\r\n',0),(281,3,'Participar en las actividad de extensión propias de la Facultad de Ciencias y en especial las que programe el Centro de Microscopía Electrónica “Dr. Mitsuo Ogura\"',0),(282,3,'Participar en las actividad de extensión propias de la Facultad de Ciencias y en especial las que programe el Centro de Microscopía Electrónica “Dr. Mitsuo Ogura',0),(283,3,'Participar en las actividad de extensión propias de la Facultad de Ciencias y en especial las que programe el Centro de Microscopía Electrónica “Dr. Mitsuo Ogura”',0),(284,3,'Participar en las actividad de extensión propias de la Facultad de Ciencias y en especial las que programe el Centro de Microscopía Electrónica “Dr. Mitsuo Ogura”',0),(285,2,'Plantear un proyecto de investigación relacionado con la Tesis Doctoral a ser sometido ante una Institución a fin de obtener el financiamiento económico. ',0),(286,2,'Obtener catalizadores estructurados a partir de los aluminosilicatos sintetizados ',0),(287,2,'Proporcionar formas tipo esponjas al desecho de lodo rojo ',0),(288,2,'Evaluar la caída de presión y la resistencia mecánica de las estructuras obtenidas ',0),(289,4,'Preparar el Seminario I correspondiente al plan doctoral.',0),(290,4,'	Presentar Seminario I correspondiente al plan doctoral.',0),(291,4,'	Presentar Seminario II correspondiente al plan doctoral',0),(292,4,'Presentar un trabajo en un Congreso Internacional \r\n',0),(293,4,'Presentar el Examen Doctoral\r\n',0),(294,4,'Introducir el Proyecto de Tesis Doctoral\r\n',0),(295,5,'Entrenamiento en el uso del microscopio electrónico de barrido Quanta 250 FEG.',0),(296,5,'Entrenamiento en el uso del microscopio electrónico de barrido Quanta 250 FEG.',0),(297,5,'Entrenamiento en el uso del microscopio electrónico de Tecnai G220.',0),(298,5,'Entrenamiento en el uso del microscopio electrónico de Tecnai G220.',0),(299,1,'Participar en el dictado de la asignatura de Introducción Microscopía Electrónica para Licenciaturas de Química, Física y Geoquímica.',0),(300,1,'Participar en el dictado de la asignatura de Fisicoquímica para la Licenciatura de Biología',0),(301,1,'Participar en el dictado de la asignatura de Introducción Microscopía Electrónica para Licenciaturas de Química, Física y Geoquímica.',0),(302,1,'Participar en el dictado de la asignatura de Fisicoquímica para la Licenciatura de Biología.',0),(303,2,'Sintetizar por temperatura programada los catalizadores soportados de molibdeno y vanadio. Caracterizar los sólidos obtenidos.',0),(304,2,'Evaluar la Actividad Catalítica de los catalizadores de niobio, tungsteno, molibdeno y vanadio sintetizados por STP, en reacciones de hidrotratamiento con moléculas modelos.',0),(305,2,'Sintetizar por el método de reducción en solución los catalizadores de niobio, tungsteno, molibdeno y vanadio. Caracterizar los sólidos obtenidos.',0),(306,2,'Evaluar la Actividad Catalítica de los catalizadores de niobio, tungsteno, molibdeno y vanadio soportados, sintetizados por el método de reducción, en reacciones de hidrotratamiento con moléculas modelos',0),(307,2,'Culminar la redacción y presentación de la Tesis Doctoral',0),(308,4,'Inicio del Diplomado en Formación Integral para el Docente de la UCV Aletheia. (SADPRO-UCV)',0),(309,4,'Realizar el curso de Inducción del Servicio Comunitario dictado por la Facultad de Ciencias, UCV',0),(310,4,'Realizar el Curso de Inglés, nivel Intermedio III.',0),(311,4,'Escribir un artículo para Revista Nacional con la finalidad de completar los créditos de su Plan Doctoral.',0),(312,4,'Continuación del Diplomado en Formación Integral para el Docente de la UCV Aletheia. (SADPRO-UCV)',0),(313,4,'Continuar el Curso de Inglés ',0),(314,4,'Asistencia a Congreso Nacional con publicación en Extenso ',0),(315,4,'Escribir un artículo para Revista Internacional, con la finalidad de completar los créditos de su Plan Doctoral.',0),(316,4,'La Instructora estará finalizando el Diplomado de Aletheia',0),(317,4,'Presentar Seminario II del Postgrado Individualizado de Ingeniería',0),(318,4,'Escribir un artículo para Revista Nacional con la finalidad de completar los créditos de su Plan Doctoral.',0),(319,4,'La Instructora Morgado deberá presentar su Tesis Doctoral ',0),(320,3,'Presentar un trabajo en las Jornadas de la Facultad de Ciencias',0),(321,3,'Participar en las actividad de extensión propias de la Facultad de Ciencias y en especial las que programe el Centro de Microscopía Electrónica “Dr. Mitsuo Ogura',0),(322,3,'Participar en las actividad de extensión propias de la Facultad de Ciencias y en especial las que programe el Centro de Microscopía Electrónica “Dr. Mitsuo Ogura',0),(323,3,'Participar en las actividad de extensión propias de la Facultad de Ciencias y en especial las que programe el Centro de Microscopía Electrónica “Dr. Mitsuo Ogura',0),(327,5,'Entrenamiento en el uso del microscopio electrónico de Tecnai G220.',0),(328,5,'Entrenamiento en el uso del microscopio electrónico de barrido Quanta 250 FEG.',0),(329,5,'Entrenamiento en el uso del microscopio electrónico de barrido Quanta 250 FEG.',0),(330,5,'Entrenamiento en el uso del microscopio electrónico de Tecnai G220.',0),(331,1,'Dictar un curso de Pregrado',0),(332,2,'Realizar al menos una exposición en el Seminario de Análisis',0),(333,2,'Presentación y defensa del Trabajo de Grado de Maestría',0),(334,2,'Estudiar espacios de Hilbert con núcleo reproductor',0),(335,4,'Asistir a las exposiciones que se realizan en el Seminario de Análisis',0),(336,4,'Consignar el certificado de aprobación del curso de Inducción al Servicio Comunitario',0),(337,4,'Inscribirse en el Doctorado en Matemática ante la Secretaría de la UCV',0),(338,4,'Aprobar al menos dos créditos en el Doctorado en Matemática',0),(339,3,'Participar en las actividad de extensión propias de la Facultad de Ciencias, en especial en aquellas que se desarrollen desde la Escuela de Matemática',0),(340,3,'Desempeñarse como tutor de servicio comunitario en caso de que le sea asignada esta tarea',0),(341,6,'Es integrante de la Comisión de Extensión de la Escuela de Matemática',0),(342,6,'Jurado del Trabajo Especial de Grado del estudiante Alejandro Labarca, CI:. 19.763.974',0),(343,6,'Jurado de concurso de Preparador II ',0),(344,6,'Pertenece a la Comisión de Extensión, participó como ponente en el taller titulado \"Una mañana con las Ciencias Básicas\", realizado el 31 de octubre 2014 y con una duración de 6 horas',0),(345,6,'Pertenece a la comisión de extensión',0),(346,6,'Pertenece a la Comisión de Extensión de la Facultad de Ciencias',0),(348,1,'Dictar la asignatura que le sea asignada por el Departamento de Matemática',0),(349,1,'Dictar la asignatura que le sea asignada por el Departamento de Matemática',0),(350,1,'Dictar la asignatura que le sea asignada por el Departamento de Matemática',0),(351,1,'Dictar la asignatura que le sea asignada por el Departamento de Matemática',0),(352,2,'Iniciar la redacción del Trabajo de Grado de Maestría.\r\n',0),(353,2,'Realizar una exposición en el Seminario de Álgebra.',0),(354,2,'Realizar al menos una exposición  en alguno de los seminarios que tienen lugar en la Escuela de Matemática relacionada con su proyecto de Trabajo de Grado de Maestría.',0),(355,2,'Se recomienda la defensa de su Trabajo de Grado de Maestría en este período.',0),(356,2,'Defender el Trabajo de grado de Maestría, en caso de no haberlo realizado en el período anterior.',0),(357,2,'Presentar los resultados de su trabajo de Grado de Maestría en algún evento científico, nacional o internacional, en caso de contar con financiamiento.',0),(358,2,'Realizar una pasantía en algún Instituto de Investigación de prestigio Esta actividad está sujeta a disponibilidad de financiamiento.',0),(359,2,'Realizar una pasantía en algún Instituto de Investigación de prestigio. Esta actividad está sujeta a disponibilidad de financiamiento.',0),(360,2,'Formular en forma oral posibles proyectos de investigación.',0),(361,2,'Presentar y discutir en el seminario de Álgebra las posibilidades de desarrollos futuros que hayan surgido de los resultados de su Trabajo de Grado de Maestría.',0),(362,4,'Inscribir el trabajo de grado de Maestría.',0),(363,4,'Se recomienda tomar el curso de capacitación docente en este período.',0),(364,4,'Asistir a las exposiciones del seminario de Álgebra.',0),(365,4,'Culminar la redacción del Trabajo de Grado de Maestría y solicitar nombramiento de Jurado. Se recomienda su defensa en este período.',0),(366,4,'Se recomienda tomar el curso de Inducción al Servicio Comunitario en este período.',0),(367,4,'Realizar el curso de capacitación docente en este período, en caso de no haberlo realizado el semestre anterior.',0),(368,4,'Se recomienda cursar estudios de algún idioma extranjero.  Esta actividad está sujeta a disponibilidad de financiamiento.',0),(369,4,'Asistir a las exposiciones del seminario de Álgebra.',0),(370,4,'Inscribirse en el programa de Doctorado del Postgrado en Matemática. ',0),(371,4,'Inscribir y  aprobar al menos 5 créditos del programa de Doctorado del Postgrado en Matemática.',0),(372,4,'Asistir a las exposiciones del seminario de Álgebra.',0),(373,4,'Realizar el Curso de Inducción de Servicio Comunitario, en caso de no haberlo realizado el semestre anterior.',0),(374,4,'Se recomienda cursar estudios de algún idioma extranjero.  Esta actividad está sujeta a disponibilidad de financiamiento.',0),(375,4,'Inscribir y aprobar al menos 4 créditos del programa de Doctorado del Postgrado en Matemática.',0),(376,4,'Asistir a las exposiciones del seminario de Álgebra.',0),(377,3,'Participar en las actividad de extensión propias de la  Facultad de Ciencias, en especial en aquellas que se desarrollen desde la Escuela de Matemática.',0),(378,3,'Participar en las actividad de extensión propias de la  Facultad de Ciencias, en especial en aquellas que se desarrollen desde la Escuela de Matemática.',0),(379,3,'Desempeñarse como tutor de servicio comunitario en caso de que le sea asignada esta tarea.',0),(380,3,'Participar en las actividad de extensión propias de la  Facultad de Ciencias, en especial en aquellas que se desarrollen desde la Escuela de Matemática.',0),(381,3,'Desempeñarse como tutor de servicio comunitario en caso de que le sea asignada esta tarea.',0),(382,3,'Participar en las actividad de extensión propias de la  Facultad de Ciencias, en especial en aquellas que se desarrollen desde la Escuela de Matemática.',0),(383,3,'Desempeñarse como tutor de servicio comunitario en caso de que le sea asignada esta tarea.',0),(384,5,'Realizar las actividad administrativas y de extensión que le sean asignadas por la Escuela o la Facultad.',0),(385,5,'Realizar las actividad administrativas y de extensión que le sean asignadas por la Escuela o la Facultad.',0),(386,5,'Realizar las actividad administrativas y de extensión que le sean asignadas por la Escuela o la Facultad.',0),(387,5,'Realizar las actividad administrativas y de extensión que le sean asignadas por la Escuela o la Facultad.',0),(388,6,'* La Instructora Torrealba presentó la ponencia titulada: \"Sobre  espacio Ramsey - Topológico\" en el marco de la Semana de la Investigación y Extensión de la Facultad de Ciencias, UCV, realizada del 13 al 17 de mayo de 2013.\r\n\r\n* La Instructora Torrealba visitó el Departamento de Matemáticas de la Universidad Javeriana, Bogotá, Colombia, del 22 de julio al 2 de agosto.  Durante este lapso se entrevistó varias veces con su tutor de trabajo de grado de maestría, el Prof. José Gregorio Mijares, quien es profesor del Departamento de Matemáticas de la Universidad Javeriana y participó de otras actividad propias de esa Institución.  Estas entrevistas tuvieron por objeto ultimar los detalles y revision del trabajo de grado de maestría de la Instructora Torrealba y además explorar posibles tópicos de futuras investigaciones relacionadas con el trabajo de grado de maestría de la Instructora Torrealba.\r\n\r\n*  La Instructora Torrealba presentó la ponencia titulada: \"Espacios Ramsey - Topológicos\" en el Coloquio del Departamento de Matemáticas de la Universidad Javeriana, Bogotá, Colombia, el 30 de julio de 2013',0),(389,6,'•	La Instructora Torrealba es Coordinadora de la Comisión para la Prevención del Consumo de Drogas desde el año 2009.\r\n•	La Instructora Torrealba  forma parte del equipo organizador del Seminario de Lógica\r\n',0),(390,1,'Dictar una asignatura obligatoria del Departamento de Computación o una asignatura de la opción Computación Gráfica.',0),(391,1,'Dictar una asignatura obligatoria del Departamento de Computación o una asignatura de la opción Computación Gráfica.',0),(392,1,'Dictar una asignatura obligatoria del Departamento de Computación o una asignatura de la opción Computación Gráfica.',0),(393,1,'Dictar una asignatura obligatoria del Departamento de Computación o una asignatura de la opción Computación Gráfica.',0),(396,2,'Participación en un proyecto de visualización científica',0),(397,2,'Participación en un proyecto de visualización científica',0),(398,2,'Participación en un proyecto de visualización científica',0),(399,2,'Participación en un proyecto de visualización científica',0),(400,2,'Publicar un reporte técnico en las lecturas en Ciencias de la Computación',0),(401,2,'Presentar un artículo de investigación in extenso en un congreso/simposio científico nacional o internacional arbitrado, o publicarlo en revista científica nacional o internacional arbitrada.',0),(402,2,'Realizar pasantía para formación y/o investigación en alguna de las Universidades extranjeras con las cuales el Centro de Computación Gráfica mantiene relaciones de trabajo. Esta participación estará sujeta a la disponibilidad de los recursos económicos necesarios, de acuerdo a los programas de financiamiento destinados para tal fin.',0),(403,2,'Realizar pasantía para formación y/o investigación en alguna de las Universidades extranjeras con las cuales el Centro de Computación Gráfica mantiene relaciones de trabajo. Esta participación estará sujeta a la disponibilidad de los recursos económicos necesarios, de acuerdo a los programas de financiamiento destinados para tal fin.',0),(404,2,'Presentar un artículo de investigación in extenso en un congreso científico nacional o internacional arbitrado, o publicarlo en revista científica nacional o internacional arbitrada.',0),(406,4,'Inscribir las asignaturas Seminario y Anteproyecto de Tesis en el Postgrado en Ciencias de La Computación de la UCV.',0),(407,4,'Inscribir la tesis de Maestría en el Postgrado en Ciencias de La Computación de la UCV.',0),(408,4,'Realizar curso de Inglés.',0),(409,4,'Realizar curso de Inglés.',0),(410,4,'Realizar curso de Inglés.',0),(411,4,'Realizar curso de Inglés.',0),(412,4,'Realizar uno de los cursos de Formación Integral para el Docente UCV (Aletheia).',0),(413,4,'Realizar uno de los cursos de Formación Integral para el Docente UCV (Aletheia).',0),(414,4,'Consignar y/o defender tesis de Maestría en el postgrado en Ciencias de la Computación.',0),(415,4,'Inscribirse en el Doctorado en Ciencias de la Computación',0),(416,3,'Participar en las actividad de extensión del Centro de Computación Gráfica y/o de la Escuela de Computación, y servicio comunitario',0),(417,3,'Participar en las actividad de extensión del Centro de Computación Gráfica y/o de la Escuela de Computación, y servicio comunitario',0),(418,3,'Participar en las actividad de extensión del Centro de Computación Gráfica y/o de la Escuela de Computación, y servicio comunitario',0),(419,3,'Participar en las actividad de extensión del Centro de Computación Gráfica y/o de la Escuela de Computación, y servicio comunitario',0),(420,2,'Someter un artículo en una revista internacional arbitrada.',0),(433,6,'Autorizadas por el Tutor:\r\n•	La Instructora Torrealba es Coordinadora de la Comisión para la Prevención del Consumo de Drogas desde el año 2009.\r\n•	La Instructora Torrealba  forma parte del equipo organizador del Seminario de Lógica.\r\n•	La Instructora Torrealba fue suplente de la Profesora Yeiremi Freites en el curso Elementos de la Matemática del 07 de abril al 30 de abril de 2014.\r\n',0);
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
) ENGINE=InnoDB AUTO_INCREMENT=110 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `actividad_ejecutada`
--

LOCK TABLES `actividad_ejecutada` WRITE;
/*!40000 ALTER TABLE `actividad_ejecutada` DISABLE KEYS */;
INSERT INTO `actividad_ejecutada` VALUES (1,'Dictó Análisis II',NULL,NULL,163),(2,'Dictó Métodos Matemáticos. El número de estudiantes inscritos fue entre 5 y 20, que es lo usual en esa asignatura. Dictó cuatro horas de teoría y cuatro horas de práctica.',NULL,NULL,200),(3,'Dictó un curso de pregrado.\r\n\r\nEste fue Análisis Funcional, le correspondió dictar cuatro horas de teoría y dos horas de práctica.',NULL,NULL,232),(4,'Le correspondió dictar Matemática I (4 horas de teoría y 4 horas de práctica). Además coordinó a los otros profesores y a los preparadores que dictaban esa asignatura.',NULL,NULL,247),(5,'Realizó una exposición en el Seminario de Análisis. A continuación se indican los detalles.\r\nFecha: Martes 02 de julio.\r\nHora: 11:00 a.m.\r\nExpositor: Kenyer Aguiar (UCV).\r\nTítulo de la charla: Representación integral de funciones definidas positivas a valores\r\noperadores sobre un módulo de Hilbert.\r\nLugar: Sala Raimundo Chela.',NULL,NULL,164),(6,'El 4 de febrero realizó una exposición en el Seminario de Análisis titulada Núcleos reproductivos en espacios de Bergman.',NULL,NULL,201),(7,'El 10 de junio realizó una exposición en el\r\nSeminario de Análisis titulada Semigrupos de operadores en módulos de Hilbert.\r\n',NULL,NULL,233),(8,'El 25 de noviembre realizó una exposición en el Seminario de Análisis titulada \"El teorema de Stone\".',NULL,NULL,248),(9,'Redactó el Trabajo de Grado de Maestría.',NULL,NULL,165),(10,'Estudió en detalle el artículo publicado por Y. Kakihara en Kodai Math. J., en el año 1983, donde se dan aplicaciones al análisis armónico de los módulos de Hilbert.',NULL,NULL,166),(11,'Presentó y defendió el Trabajo de Grado de Maestría',NULL,NULL,202),(12,'Estudió espacios de Hilbert con núcleo reproductor',NULL,NULL,203),(13,'Realizó una revisión bibliográfica de libros relacionados con los temas de Módulos C*, usó especialmente el libro de Lance y el libro de Manuilov y Troitsky',NULL,NULL,234),(14,'En reuniones con los doctores R. Bruzual y M. Domínguez está formulando posibles nuevos proyectos de investigación relacionados con el teorema de Stone.',NULL,NULL,235),(15,'Está redactando y tipeando en latex una monografía que incluye los resultados obtenidos en el Trabajo de Grado de Maestría y resultados de investigación adicionales ',NULL,NULL,236),(16,'En reuniones con el Dr. Ramón Bruzual y la Dra. Marisela Domínguez, ambos del Centro de Análisis Matemático, se ha hablado de un proyecto de investigación que consiste en la posible extensión del teorema de Stone en el contexto de los módulos de Hilbert.',NULL,NULL,249),(17,'En varias oportunidades, en las sesiones del Seminario de Análisis, ha presentado y discutido  las posibilidades de desarrollos futuros de su trabajo de investigación, concretamente en problemas relacionados con el teorema de Stone y con los módulos de Hilbert.',NULL,NULL,250),(18,'Culminó la redacción de una monografía que incluye  los resultados obtenidos en el Trabajo de Grado de Maestría y resultados de investigación adicionales, en la misma línea de investigación. Incorporó los temas referentes al teorema de Stone y espacios de Bergman. \r\n\r\nCon respecto a este punto, como tutor del Plan de Formación, considero que esto resulta suficiente para la culminación del plan',NULL,NULL,251),(19,'Tal como fue informado en informes previos, aprobó el curso \"Inglés para adultos\", en el nivel \"Conversación Básico\". Esto lo hizo en el período que corresponde al segundo semestre de su Plan de Formación y Capacitación.',NULL,NULL,252),(20,'Asistió regularmente a las exposiciones que se realizan en el Seminario de Análisis',NULL,NULL,167),(21,'Asistió a las exposiciones que se realizan en el Seminario de Análisis',NULL,NULL,237),(22,'Asistió regularmente a las exposiciones que se realizan en el Seminario de Análisis',NULL,NULL,204),(23,'Asistió a las exposiciones que se realizan en el Seminario de Análisis.',NULL,NULL,253),(24,'Consignó el certificado de aprobación del curso de capacitación docente',NULL,NULL,168),(25,'Consignó ante la oficina del Postgrado en Matemática el ejemplar del Trabajo de Grado de Maestría, para solicitar el nombramiento del jurado ',NULL,NULL,169),(26,'Solicitó admisión al Doctorado en Matemática.',NULL,NULL,170),(27,'Este curso no se dictó en el período que corresponde a este semestre del plan de formación. Se inscribió en el curso de Inducción al Servicio Comunitario que se dictará en mayo o en junio del presente año. ',NULL,NULL,205),(28,'Se inscribió en el Doctorado en Matemática\r\npara el semestre II año lectivo 2013.',NULL,NULL,206),(29,'Aprobó cuatro créditos en el Doctorado en Matemática',NULL,NULL,207),(30,'Aprobó dos créditos en el Doctorado en\r\nMatemática. Asistió regularmente a las exposiciones que se realizan en el Seminario de Análisis.',NULL,NULL,238),(31,'Solicitó reconocimiento de créditos de las asignaturas que aprobó en la maestría que también son asignaturas del doctorado. Estas son cuatro obligatorias: Análisis Real, Probabilidades, Variable Compleja y Algebra (de 5 créditos cada una) y tres electivas (de 4 créditos cada una). Total 32 créditos',NULL,NULL,239),(32,'Aprobó Seminario de Análisis II (2 créditos).',NULL,NULL,254),(33,'Consignó copia del título de Magister Scientiarum.',NULL,NULL,255),(34,'Inscribió en el Doctorado en Matemáticas la asignatura Proyecto de Tesis. ',NULL,NULL,256),(35,'Asiste regularmente a las reuniones de la comisión de extensión de la Facultad de Ciencias',NULL,NULL,171),(36,'Participó en las actividades de extensión propias de la Facultad de Ciencias, en especial en aquellas que se desarrollen desde la Escuela de Matemática. Le ha correspondido visitar liceos.\r\n',NULL,NULL,208),(37,'Participó en las actividades de extensión propias de la Facultad de Ciencias, en especial en aquellas que se desarrollan desde la Escuela de Matemática. Participó como ponente en el taller titulado “Una mañana con las Ciencias Básicas”, realizado el 31 de octubre 2014, con una duración de 6 horas',NULL,NULL,240),(38,'Es miembro de la Comisión de Extensión.',NULL,NULL,257),(39,'No le fue asignada esa tarea',NULL,NULL,172),(40,'No le ha sido asignada esta tarea.',NULL,NULL,209),(41,'Es tutor de servicio comunitario de la bachiller Katherine V. Gil L. C.I: 23949189',NULL,NULL,241),(42,'Es tutor de servicio comunitario de la bachiller Katherine V. Gil L. C.I: 23949189 ',NULL,NULL,258),(43,'Cumplió totalmente con lo estipulado en el literal (a) de la disposición del Consejo de Facultad del día 04 de abril de 2005, es decir: (i) Tiene la escolaridad completa de la Maestría. (ii) Aprobó el Trabajo de Grado de Maestría. Esto lo culminó en semestres anteriores.',NULL,NULL,259),(44,'Aunque se le pedía cumplir con al menos dos de las condiciones, cumplió con tres: \r\n(i) Presentó un trabajo de investigación en un evento científico. En el marco de las Jornadas de Investigación y Extensión Facultad de Ciencias 2014 (en el Seminario de Análisis) presentó su trabajo de investigación titulado\r\n\"Funciones definidas positivas a valores operadores en un módulo de Hilbert\". Fecha: Martes 13 de mayo de 2014.\r\n(ii) Tomó un curso en la Escuela Venezolana de Matemáticas, titulado \"Desarrollo de los conceptos de funciones convexas\". Fecha 1 al 6 de septiembre de 2013.\r\n(iii) Realizó varias exposiciones en el Seminario de Análisis, que cuentan con evaluación positiva por parte de los coordinadores del seminario. Esto lo hizo a lo largo de los dos años de su Plan de Formación.',NULL,NULL,260),(45,'Aprobó las obligatorias: Análisis Real, Probabilidades, Variable Compleja y Algebra (de 5 créditos cada una).\r\nAprobó las electivas: Espacios con Métrica Indefinida, Representación de formas positivas, Teoría Espectral, Espacios con Núcleo Reproductor (de 4 créditos cada una).\r\nAprobó los seminarios: Seminario de Análisis I y Seminario de Análisis II (de 2 créditos cada uno).\r\n\r\nTomando en cuenta su solicitud de reconocimiento de créditos, hecha durante el semestre pasado, \r\ntendría aprobadas las asignaturas obligatorias, electivas y seminarios que corresponden al programa de Doctorado en Matemática.\r\n\r\nTotal 40 créditos. \r\n\r\nInscribió Proyecto de Tesis (5 créditos).',NULL,NULL,261),(46,NULL,NULL,NULL,173),(47,'Dictó Análisis II',NULL,NULL,174),(48,NULL,NULL,NULL,175),(49,'Consignó ante la oficina del Postgrado en Matemática el ejemplar del Trabajo de Grado de Maestría, para solicitar el nombramiento del jurado ',NULL,NULL,176),(50,NULL,NULL,NULL,177),(51,'Entre el 18-06-2013 y el 19-07-2013 solicitó admisión al Doctorado en Matemática.',NULL,NULL,178),(52,NULL,NULL,NULL,179),(53,NULL,NULL,NULL,180),(54,'Solicitó admisión al Doctorado en Matemática.',NULL,NULL,181),(55,NULL,NULL,NULL,182),(56,'Consignó ante la oficina del Postgrado en Matemática el ejemplar del Trabajo de Grado de Maestría, para solicitar el nombramiento del jurado ',NULL,NULL,183),(57,NULL,NULL,NULL,184),(58,'Dictó Análisis II',NULL,NULL,185),(59,NULL,NULL,NULL,186),(60,'Dictó Análisis II',NULL,NULL,187),(61,NULL,NULL,NULL,188),(62,'Solicitó admisión al Doctorado en Matemática.',NULL,NULL,189),(63,NULL,NULL,NULL,190),(64,'Realizó una exposición en el Seminario de Análisis. A continuación se indican los detalles.\nFecha: Martes 02 de julio.\nHora: 11:00 a.m.\nExpositor: Kenyer Aguiar (UCV).\nTtulo de la charla: Representación integral de funciones definidas positivas a valores\noperadores sobre un módulo de Hilbert.\nLugar: Sala Raimundo Chela.',NULL,NULL,191),(65,'Redactó el Trabajo de Grado de Maestría.',NULL,NULL,192),(66,'Estudió en detalle el artículo publicado por Y. Kakihara en Kodai Math. J., en el ao 1983, donde se dan aplicaciones al análisis armónico de los módulos de Hilbert.',NULL,NULL,193),(67,'Asistió regularmente a las exposiciones que se realizan en el Seminario de Análisis',NULL,NULL,194),(68,'Consignó el certificado de aprobación del curso de capacitación docente',NULL,NULL,195),(69,'Consignó ante la oficina del Postgrado en Matemática el ejemplar del Trabajo de Grado de Maestría, para solicitar el nombramiento del jurado ',NULL,NULL,196),(70,'Dictó Análisis II',NULL,NULL,197),(71,'Asiste regularmente a las reuniones de la comisión de extensión de la Facultad de Ciencias ',NULL,NULL,198),(72,'No le fue asignada esa tarea ',NULL,NULL,199),(73,'Dictó el curso de Álgebra 2 (semestre I-2013).\r\nDuración: 8 horas a la semana.\r\nN° de estudiantes inscritos: 17',NULL,NULL,222),(74,'1) La Instructora Torrealba dictó el curso Álgebra 2  (semestre I-2013)\r\n    Duración: 8 horas a la semana.\r\n   N° de estudiantes inscritos:  12\r\n2)  La Instructora Torrealba dictó el curso Álgebra 2  (semestre II-2013)\r\n   Duración: 8 horas a la semana.\r\n   N° de estudiantes inscritos:  17\r\n',NULL,NULL,262),(75,'La Instructora Torrealba inscribió el trabajo de grado de maestría\r\n',NULL,NULL,223),(76,NULL,NULL,NULL,224),(77,NULL,NULL,NULL,225),(78,'La Instructora Torrealba asistió a las charlas dadas en el marco del Seminario de Lógica en este período',NULL,NULL,226),(79,'La Instructora Torrealba  continuó y culminó con la redacción del trabajo de Grado. \r\n2)  La Instructora Torrealba  realizó la solicitud de Jurado para presentación de Trabajo de Grado el día 13 de noviembre de 2013.\r\n3)  La Instructora Torrealba  presentó y defendió exitosamente el Trabajo de Grado de Maestría titulado \"Un Espacio de Ramsey topológico de estructuras métricas y su relación con el Espacio de Urysohn\", en el que obtuvo una calificación de \"Excelente\". La presentación y defensa se realizó el 06 de diciembre de 2013.\r\n',NULL,NULL,263),(80,')  La Instructora Torrealba  inscribió el Curso de Inducción del Servicio Comunitario  (23 de abril de 2014).',NULL,NULL,264),(81,'1)   Durante este período no hubo ofertas de cursos de capacitación docente.\r\n',NULL,NULL,265),(82,'Durante este período no hubo financiamiento para cursos de algún idioma extranjero .',NULL,NULL,266),(83,'La Instructora Torrealba  asistió a todas las exposiciones del seminario de Lógica en este período.',NULL,NULL,267),(84,'La Instructora Torrealba inició la redacción del trabajo de Grado de Maestría',NULL,NULL,227),(85,'La Instructora Torrealba presentó en el  Seminario de Lógica el día 25 de septiembre de 2013 la charla titulada: \"El Espacio de Urysohn\"',NULL,NULL,228),(86,'1) La Instructora Torrealba  presentó en el Seminario de Lógica el día 27 de noviembre de 2013 la charla titulada \" El Espacio de Urysohn, Segunda Parte\".',NULL,NULL,268),(87,'2) La Instructora Torrealba  presentó en el Seminario de Lógica el día 29 de abril de 2014 la charla titulada \"Un Espacio de  Ramsey topológico de estructuras métricas y su relación con el espacio de Urysohn \".\r\n3) La Instructora Torrealba  presentó y defendió exitosamente el Trabajo de Grado de Maestría titulado \"Un Espacio de Ramsey topológico de estructuras métricas y su relación con el Espacio de Urysohn\", en el que obtuvo una calificación de \"Excelente\". La presentación y defensa se realizó el 06 de diciembre de 2013.\r\n',NULL,NULL,269),(88,'La Instructora Torrealba formó parte de la organización de la actividad realizada por el Grupo de Álgebra y Lógica durante la realización de la Semana de la Investigación y Extensión de la Facultad de Ciencias, UCV, realizadas del 13 al 17 de mayo de 2013.',NULL,NULL,229),(89,'Formó parte de la organización del Coloquio de Matemáticas. ',NULL,NULL,270),(90,NULL,NULL,NULL,210),(91,'Dictó Métodos Matemáticos. El número de estudiantes inscritos fue entre 5 y 20, que es lo usual en esa asignatura. Dictó cuatro horas de teoría y cuatro horas de práctica.',NULL,NULL,211),(92,'El 4 de febrero realizó una exposición en el Seminario de Análisis titulada Núcleos reproductivos en espacios de Bergman.',NULL,NULL,212),(93,'Presentó y defendió el Trabajo de Grado de Maestría. El veredicto se envía como soporte, en él se pueden ver los detalles de la presentación. El jurado le otorgó la calificación de excelente.',NULL,NULL,213),(94,'Estudió espacios de Hilbert con núcleo reproductor',NULL,NULL,214),(95,'Asistió regularmente a las exposiciones que se realizan en el Seminario de Análisis',NULL,NULL,215),(96,'Este curso no se dictó en el período que corresponde a este semestre del plan de formación. Se inscribió en el curso de Inducción al Servicio Comunitario que se dictará en mayo o en junio del presente año. ',NULL,NULL,216),(97,'Se inscribió en el Doctorado en Matemática\r\npara el semestre II año lectivo 2013.',NULL,NULL,217),(98,'Aprobó cuatro créditos en el Doctorado en Matemática',NULL,NULL,218),(99,'Participó en las actividades de extensión propias de la Facultad de Ciencias, en especial en aquellas que se desarrollen desde la Escuela de Matemática. Le ha correspondido visitar liceos.\r\n',NULL,NULL,219),(100,'No le ha sido asignada esta tarea.',NULL,NULL,220),(101,NULL,NULL,NULL,221),(102,NULL,NULL,NULL,242),(103,NULL,NULL,NULL,243),(104,NULL,NULL,NULL,244),(105,NULL,NULL,NULL,245),(106,NULL,NULL,NULL,246),(107,NULL,NULL,NULL,230),(108,NULL,NULL,NULL,231),(109,NULL,NULL,NULL,271);
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
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `adecuacion`
--

LOCK TABLES `adecuacion` WRITE;
/*!40000 ALTER TABLE `adecuacion` DISABLE KEYS */;
INSERT INTO `adecuacion` VALUES (1,1,4,NULL,NULL,NULL),(2,2,12,NULL,NULL,NULL),(3,3,11,NULL,NULL,NULL),(4,4,20,NULL,NULL,NULL),(5,5,20,NULL,NULL,NULL),(6,6,23,NULL,NULL,NULL),(7,7,24,NULL,NULL,NULL);
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
) ENGINE=InnoDB AUTO_INCREMENT=272 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `adecuacion_actividad`
--

LOCK TABLES `adecuacion_actividad` WRITE;
/*!40000 ALTER TABLE `adecuacion_actividad` DISABLE KEYS */;
INSERT INTO `adecuacion_actividad` VALUES (1,1,47,0,1),(2,1,48,0,2),(3,1,49,0,3),(4,1,50,0,4),(5,1,51,0,1),(6,1,52,0,2),(7,1,53,0,3),(8,1,54,0,4),(9,1,59,0,1),(10,1,60,0,1),(11,1,61,0,2),(12,1,62,0,2),(13,1,63,0,3),(14,1,64,0,3),(15,1,65,0,3),(16,1,66,0,4),(17,1,67,0,4),(18,1,68,0,4),(19,1,69,0,4),(20,1,70,0,1),(21,1,71,0,2),(22,1,72,0,3),(23,1,73,0,4),(24,1,74,0,1),(25,1,75,0,2),(26,1,76,0,3),(27,1,77,0,4),(28,1,78,0,1),(29,1,79,0,1),(30,1,80,0,1),(31,1,81,0,2),(32,1,82,0,2),(33,1,83,0,2),(34,1,84,0,3),(35,1,85,0,3),(36,1,86,0,4),(37,1,87,0,4),(38,1,88,0,4),(39,1,89,0,1),(40,1,90,0,2),(41,1,91,0,3),(42,1,92,0,4),(43,1,93,0,1),(44,1,94,0,2),(45,1,95,0,3),(46,1,96,0,4),(47,1,97,0,4),(48,1,98,0,4),(49,1,99,0,4),(50,2,100,0,1),(51,2,101,0,2),(52,2,102,0,3),(53,2,103,0,4),(54,2,104,0,2),(55,2,105,0,3),(56,2,106,0,2),(57,2,107,0,1),(58,2,108,0,4),(60,1,177,0,1),(62,1,179,0,1),(64,1,181,0,1),(67,1,184,0,1),(69,1,186,0,1),(71,1,188,0,1),(73,1,190,0,1),(75,1,192,0,1),(77,1,194,0,1),(78,1,195,0,1),(79,1,196,0,1),(80,1,197,0,1),(81,1,198,0,1),(82,1,199,0,1),(83,1,200,0,1),(84,1,201,0,1),(85,1,202,0,1),(86,3,203,0,1),(87,3,204,0,2),(88,3,205,0,3),(89,3,206,0,4),(90,3,211,0,1),(91,3,212,0,1),(92,3,213,0,1),(93,3,214,0,1),(94,3,215,0,2),(95,3,216,0,2),(96,3,217,0,2),(97,3,218,0,2),(98,3,219,0,2),(99,3,220,0,3),(100,3,221,0,3),(101,3,222,0,3),(102,3,223,0,3),(103,3,224,0,4),(104,3,225,0,4),(105,3,226,0,1),(106,3,227,0,1),(107,3,228,0,2),(108,3,229,0,2),(109,3,230,0,3),(110,3,231,0,3),(111,3,232,0,3),(112,3,233,0,4),(113,3,234,0,4),(114,3,235,0,4),(115,3,236,0,1),(116,3,237,0,2),(117,3,238,0,2),(118,3,239,0,3),(119,3,240,0,3),(120,3,241,0,4),(121,3,242,0,4),(122,3,243,0,1),(123,3,244,0,2),(124,3,245,0,3),(125,3,246,0,4),(127,4,268,0,1),(128,4,269,0,2),(129,4,270,0,3),(130,4,271,0,4),(131,4,272,0,1),(132,4,273,0,2),(133,4,275,0,4),(134,4,276,0,1),(135,4,277,0,2),(136,4,278,0,3),(137,4,279,0,4),(138,4,281,0,2),(139,4,282,0,3),(140,4,283,0,4),(141,4,284,0,1),(142,4,285,0,2),(143,4,286,0,3),(144,4,287,0,3),(145,4,288,0,3),(146,4,289,0,1),(147,4,290,0,2),(148,4,291,0,3),(149,4,292,0,4),(150,4,293,0,4),(151,4,294,0,4),(152,4,295,0,1),(153,4,296,0,2),(154,4,297,0,3),(155,4,298,0,4),(156,5,299,0,1),(157,5,300,0,2),(158,5,301,0,3),(159,5,302,0,4),(160,5,303,0,1),(161,5,304,0,2),(162,5,305,0,3),(163,5,306,0,3),(164,5,307,0,4),(165,5,308,0,1),(166,5,309,0,1),(167,5,310,0,1),(168,5,311,0,1),(169,5,312,0,2),(170,5,313,0,2),(171,5,314,0,2),(172,5,315,0,2),(173,5,316,0,3),(174,5,317,0,3),(175,5,318,0,3),(176,5,319,0,4),(177,5,320,0,1),(178,5,321,0,2),(179,5,322,0,3),(180,5,323,0,4),(181,5,327,0,4),(182,5,328,0,1),(183,5,329,0,2),(184,5,330,0,3),(185,1,331,0,2),(186,1,332,0,2),(187,1,333,0,2),(188,1,334,0,2),(189,1,335,0,3),(190,1,336,0,2),(191,1,337,0,2),(192,1,338,0,2),(193,1,339,0,2),(194,1,340,0,2),(199,1,345,0,3),(201,6,348,0,1),(202,6,349,0,2),(203,6,350,0,3),(204,6,351,0,4),(205,6,352,0,1),(206,6,353,0,1),(207,6,354,0,2),(208,6,355,0,2),(209,6,356,0,3),(210,6,357,0,3),(211,6,358,0,3),(212,6,359,0,4),(213,6,360,0,4),(214,6,361,0,4),(215,6,362,0,1),(216,6,363,0,1),(217,6,364,0,1),(218,6,365,0,2),(219,6,366,0,2),(220,6,367,0,2),(221,6,368,0,2),(222,6,369,0,2),(223,6,370,0,3),(224,6,371,0,3),(225,6,372,0,3),(226,6,373,0,3),(227,6,374,0,3),(228,6,375,0,4),(229,6,376,0,4),(230,6,377,0,1),(231,6,378,0,2),(232,6,379,0,2),(233,6,380,0,3),(234,6,381,0,3),(235,6,382,0,4),(236,6,383,0,4),(237,6,384,0,1),(238,6,385,0,2),(239,6,386,0,3),(240,6,387,0,4),(243,7,390,0,1),(244,7,391,0,2),(245,7,392,0,3),(246,7,393,0,4),(247,7,396,0,1),(248,7,397,0,2),(249,7,398,0,3),(250,7,399,0,4),(251,7,400,0,2),(252,7,401,0,2),(253,7,402,0,3),(254,7,403,0,4),(255,7,404,0,4),(256,7,406,0,1),(257,7,407,0,2),(258,7,408,0,1),(259,7,409,0,2),(260,7,410,0,3),(261,7,411,0,4),(262,7,412,0,1),(263,7,413,0,2),(264,7,414,0,3),(265,7,415,0,4),(266,7,416,0,1),(267,7,417,0,2),(268,7,418,0,3),(269,7,419,0,4),(270,7,420,0,4),(271,3,433,0,2);
/*!40000 ALTER TABLE `adecuacion_actividad` ENABLE KEYS */;
UNLOCK TABLES;

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
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `estatus_adecuacion`
--

LOCK TABLES `estatus_adecuacion` WRITE;
/*!40000 ALTER TABLE `estatus_adecuacion` DISABLE KEYS */;
INSERT INTO `estatus_adecuacion` VALUES (1,1,'2013-09-27',1,1),(2,2,'2014-01-15',2,1),(3,3,'2014-05-22',1,1),(4,4,'2014-09-18',3,1),(5,5,'2014-09-29',3,1),(6,6,'2014-12-16',4,1),(7,7,'2015-01-26',5,1);
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
) ENGINE=InnoDB AUTO_INCREMENT=18 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `estatus_informe`
--

LOCK TABLES `estatus_informe` WRITE;
/*!40000 ALTER TABLE `estatus_informe` DISABLE KEYS */;
INSERT INTO `estatus_informe` VALUES (1,1,'2014-02-04',5,1),(2,2,'2014-01-29',6,1),(3,3,'2014-01-29',6,1),(4,4,'2014-01-29',6,1),(5,5,'2014-01-29',6,1),(6,6,'2014-01-29',6,1),(7,7,'2014-02-04',6,1),(8,8,'2014-02-04',6,1),(9,9,'2014-02-04',6,1),(10,10,'2014-02-26',1,1),(11,11,'2014-06-11',7,1),(12,12,'2014-10-01',1,1),(13,13,'2015-01-19',1,1),(14,14,'2014-11-26',1,1),(15,15,'2014-11-07',1,1),(16,16,'2014-12-09',6,1),(17,17,'2015-02-12',6,1);
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
  `fecha_modificacion` date DEFAULT NULL,
  `tipo_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `informePlanFormacion` (`planformacion_id`),
  KEY `informeusuario` (`tutor_id`),
  KEY `informetipo` (`tipo_id`),
  CONSTRAINT `informePlanFormacion` FOREIGN KEY (`planformacion_id`) REFERENCES `planformacion` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `informetipo` FOREIGN KEY (`tipo_id`) REFERENCES `tipo_informe` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `informeusuario` FOREIGN KEY (`tutor_id`) REFERENCES `usuario` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=18 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `informe`
--

LOCK TABLES `informe` WRITE;
/*!40000 ALTER TABLE `informe` DISABLE KEYS */;
INSERT INTO `informe` VALUES (1,1,4,'Considero que el desempeño del instructor en esta etapa fue  satisfactorio.','Las actividad programadas para esta etapa se cumplieron.',NULL,NULL,NULL,NULL,NULL),(2,1,4,'Considero que el desempeño del instructor en esta etapa fue  satisfactorio.','Las actividad programadas para esta etapa se cumplieron.',NULL,NULL,NULL,NULL,NULL),(3,1,4,'Considero que el desempeño del instructor en esta etapa fue  satisfactorio.','Las actividad programadas para esta etapa se cumplieron.',NULL,NULL,NULL,NULL,NULL),(4,1,4,'Considero que el desempeño del instructor en esta etapa fue  satisfactorio.','Las actividad programadas para esta etapa se cumplieron.',NULL,NULL,NULL,NULL,NULL),(5,1,4,'Considero que el desempeño del instructor en esta etapa fue  satisfactorio.','Las actividad programadas para esta etapa se cumplieron.',NULL,NULL,NULL,NULL,NULL),(6,1,4,'Considero que el desempeño del instructor en esta etapa fue  satisfactorio.','Las actividad programadas para esta etapa se cumplieron.',NULL,NULL,NULL,NULL,NULL),(7,1,4,'Considero que el desempeño del instructor en esta etapa fue  satisfactorio.','Las actividad programadas para esta etapa se cumplieron.',NULL,NULL,NULL,NULL,NULL),(8,1,4,'Considero que el desempeño del instructor en esta etapa fue  satisfactorio.','Las actividad programadas para esta etapa se cumplieron.',NULL,NULL,NULL,NULL,NULL),(9,1,4,'Considero que el desempeño del instructor en esta etapa fue  satisfactorio.','Las actividad programadas para esta etapa se cumplieron.',NULL,NULL,NULL,NULL,NULL),(10,1,4,'Considero que el desempeño del instructor en esta etapa fue  satisfactorio.','Las actividad programadas para esta etapa se cumplieron.',NULL,NULL,NULL,NULL,NULL),(11,1,4,'Considero que el desempeño del instructor en esta etapa fue satisfactorio.',NULL,NULL,NULL,NULL,NULL,NULL),(12,1,4,'Considero que el desempeño del instructor en esta etapa fue satisfactorio.',NULL,NULL,NULL,NULL,NULL,NULL),(13,3,11,'Considero que el desempeño de la Instructora Daniela Torrealba en el desarrollo de este período de su plan de formación y capacitación fue altamente satisfactorio','La Instructora Torrealba cumplió satisfactoriamente las actividad contempladas en el plan de formación y capacitación programadas para este período.',NULL,NULL,NULL,NULL,NULL),(14,1,4,'Considero que el desempeño del instructor en esta etapa fue satisfactorio.','El instructor cumplió con todo lo programado para estos tres primeros semestres. \r\n\r\nCon este informe se entrega el certificado de curso de servivio comunitario, el cual había sido programado para el segundo semestre. EL instructor no pudo tomarlo en esa oprtunidad porque no se dictó.',NULL,NULL,NULL,NULL,NULL),(15,1,4,'Opino que el instructor ha tenido un desempeño excelente y que se merece que los trámites administrativos correspondientes a sus informe no se atrasen por observaciones de forma.','Las actividad programas se cumplieron totalmente. \r\n\r\nEl curso de servicio comunitario estaba programado para el segundo semestre, en ese año se inscribió, sin embargo este curso se dictó en el tercer semestre. En los soportes coloco el certificado y lo colocaré también en el informe del tercer semestre. Creo que es mejor que sobre y no que falte, espero que esto no ocasione ni demoras, ni malentendidos.',NULL,NULL,NULL,NULL,NULL),(16,1,4,'Considero que el desempeño del instructor en esta etapa fue altamente satisfactorio.','El instructor Kenyer Aguiar cumpló totalmente con las actividad contempladas para el cuarto semestre de su Plan de Formación.',NULL,NULL,NULL,NULL,NULL),(17,3,11,'Considero que el desempeño de la Instructora Daniela Torrealba  en el desarrollo de  este período de su Plan de Formación y Capacitación fue Altamente Satisfactorio.','La Instructora Torrealba Cumplió Satisfactoriamente las actividad contempladas en el Plan de Formación y Capacitación programadas para este período.',NULL,NULL,NULL,NULL,NULL);
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
  `resultado_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `informeActividadActividad` (`actividad_id`),
  KEY `informeActividadinforme` (`informe_id`),
  KEY `informe_actividad_ibfk_1` (`resultado_id`),
  CONSTRAINT `informeActividadActividad` FOREIGN KEY (`actividad_id`) REFERENCES `actividad` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `informeActividadinforme` FOREIGN KEY (`informe_id`) REFERENCES `informe` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `informe_actividad_ibfk_1` FOREIGN KEY (`resultado_id`) REFERENCES `resultado` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=272 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `informe_actividad`
--

LOCK TABLES `informe_actividad` WRITE;
/*!40000 ALTER TABLE `informe_actividad` DISABLE KEYS */;
INSERT INTO `informe_actividad` VALUES (163,1,47,NULL),(164,1,51,NULL),(165,1,59,NULL),(166,1,60,NULL),(167,1,74,NULL),(168,1,78,NULL),(169,1,79,NULL),(170,1,80,NULL),(171,1,89,NULL),(172,1,93,NULL),(173,1,109,NULL),(174,2,177,NULL),(175,2,178,NULL),(176,3,179,NULL),(177,3,180,NULL),(178,4,181,NULL),(179,4,182,NULL),(180,5,183,NULL),(181,6,184,NULL),(182,6,185,NULL),(183,7,186,NULL),(184,7,187,NULL),(185,8,188,NULL),(186,8,189,NULL),(187,9,190,NULL),(188,9,191,NULL),(189,10,192,NULL),(190,10,193,NULL),(191,10,194,NULL),(192,10,195,NULL),(193,10,196,NULL),(194,10,197,NULL),(195,10,198,NULL),(196,10,199,NULL),(197,10,200,NULL),(198,10,201,NULL),(199,10,202,NULL),(200,11,48,NULL),(201,11,52,NULL),(202,11,61,NULL),(203,11,62,NULL),(204,11,76,NULL),(205,11,81,NULL),(206,11,82,NULL),(207,11,83,NULL),(208,11,90,NULL),(209,11,94,NULL),(210,11,247,NULL),(211,12,331,NULL),(212,12,332,NULL),(213,12,333,NULL),(214,12,334,NULL),(215,12,335,NULL),(216,12,336,NULL),(217,12,337,NULL),(218,12,338,NULL),(219,12,339,NULL),(220,12,340,NULL),(221,12,341,NULL),(222,13,203,NULL),(223,13,211,NULL),(224,13,212,NULL),(225,13,213,NULL),(226,13,214,NULL),(227,13,226,NULL),(228,13,227,NULL),(229,13,236,NULL),(230,13,388,NULL),(231,13,389,NULL),(232,14,49,NULL),(233,14,53,NULL),(234,14,63,NULL),(235,14,64,NULL),(236,14,65,NULL),(237,14,75,NULL),(238,14,84,NULL),(239,14,85,NULL),(240,14,91,NULL),(241,14,95,NULL),(242,14,342,NULL),(243,14,343,NULL),(244,14,344,NULL),(245,14,345,NULL),(246,14,346,NULL),(247,16,50,NULL),(248,16,54,NULL),(249,16,66,NULL),(250,16,67,NULL),(251,16,68,NULL),(252,16,69,NULL),(253,16,77,NULL),(254,16,86,NULL),(255,16,87,NULL),(256,16,88,NULL),(257,16,92,NULL),(258,16,96,NULL),(259,16,97,NULL),(260,16,98,NULL),(261,16,99,NULL),(262,17,204,NULL),(263,17,215,NULL),(264,17,216,NULL),(265,17,217,NULL),(266,17,218,NULL),(267,17,219,NULL),(268,17,228,NULL),(269,17,229,NULL),(270,17,237,NULL),(271,17,433,NULL);
/*!40000 ALTER TABLE `informe_actividad` ENABLE KEYS */;
UNLOCK TABLES;

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
  PRIMARY KEY (`id`),
  KEY `observacionActividadAdecuacionActividad` (`adecuacionactividad_id`),
  KEY `observacionActividadRevision` (`revision_id`),
  CONSTRAINT `observacionActividadAdecuacionActividad` FOREIGN KEY (`adecuacionactividad_id`) REFERENCES `adecuacion_actividad` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `observacionActividadRevision` FOREIGN KEY (`revision_id`) REFERENCES `revision` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=23 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `observacion_actividad_adecuacion`
--

LOCK TABLES `observacion_actividad_adecuacion` WRITE;
/*!40000 ALTER TABLE `observacion_actividad_adecuacion` DISABLE KEYS */;
INSERT INTO `observacion_actividad_adecuacion` VALUES (20,NULL,247,'Se recomienda su participación en un proyecto que esté preferiblemente relacionado con su tesis de maestría. ',NULL),(21,NULL,247,'Se recomienda su participación en un proyecto que esté preferiblemente relacionado con su tesis de maestría. ',NULL),(22,NULL,258,'Esta actividad no debe ser obligatoria, pues va a depender de los recursos de la Escuela para su financiamiento. Aplica a los 4 semestres del plan de formación.',NULL);
/*!40000 ALTER TABLE `observacion_actividad_adecuacion` ENABLE KEYS */;
UNLOCK TABLES;

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
  PRIMARY KEY (`id`),
  KEY `observacionActividadinformeRevision` (`revision_id`),
  KEY `observacionActividadinformeinformeActividad` (`informe_actividad_id`),
  CONSTRAINT `observacionActividadinformeRevision` FOREIGN KEY (`revision_id`) REFERENCES `revision` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `observacionActividadinformeinformeActividad` FOREIGN KEY (`informe_actividad_id`) REFERENCES `informe_actividad` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=17 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `observacion_actividad_informe`
--

LOCK TABLES `observacion_actividad_informe` WRITE;
/*!40000 ALTER TABLE `observacion_actividad_informe` DISABLE KEYS */;
INSERT INTO `observacion_actividad_informe` VALUES (1,166,NULL,' En la presentación del plan, esta actividad se ubica en investigación y no en extensión.'),(2,166,NULL,' En la presentación del plan esta actividad se ubica en investigación y no en extensión.'),(3,166,NULL,'Esta actividad no corresponde a extensión sino a invstigación'),(4,166,NULL,'Esta actividad debería estar en Investigación y no en Extensión.'),(5,166,NULL,'este p unto está fuera de orden'),(6,171,NULL,'No'),(7,169,NULL,'Agregar fecha de consignación del ejemplar del trabajo de grado de maestría.'),(8,170,NULL,'Agregar fecha de presentación del trabajo de grado de maestría y la fecha de admisión en el doctorado.'),(9,163,NULL,'Recomendamos colocar No. de Estudiantes inscritos en el curso de Análisis II. Dedicación 8 horas semanales'),(10,169,NULL,'Recomendamos colocar fecha de la consignación del ejemplar en la Ofc del Postgrado de Matemática.'),(11,170,NULL,'Sugerencia: Fue admitido en el Doctorado en Matemática a partir del semestre 2 2013.'),(12,202,NULL,'Debe colocar la fecha de defensa del Trabajo de Grado de Maestría.'),(13,202,NULL,'Debe colocar la fecha de defensa del Trabajo de Grado de Maestría.'),(14,200,NULL,'Especificar el numero exacto de estudiantes.'),(15,202,NULL,'Colocar la fecha de presentación y defensa del trabajo de grado de maestría.'),(16,208,NULL,'  Cambiar redacción por: Como miembro de la Comisión de Extensión de la Escuela de Matemática, ha participado como ponente en eventos divulgativos sobre las carreras científicas, dirigidos a estudiantes y profesores de colegios y liceos. Dichos eventos han sido promocionados por la Coordinación de Extensión de la Facultad de Ciencias.');
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
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
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
) ENGINE=InnoDB AUTO_INCREMENT=51 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `persona`
--

LOCK TABLES `persona` WRITE;
/*!40000 ALTER TABLE `persona` DISABLE KEYS */;
INSERT INTO `persona` VALUES (28,1,'Zaira P. Yepez',NULL,NULL,'0',NULL,NULL,NULL,NULL,NULL,NULL),(29,2,'Concettina Di Vasta',NULL,NULL,'10503806',NULL,NULL,NULL,NULL,'Computación','Base de Datos'),(30,4,'Marisela Dominguez',NULL,NULL,'5299337',NULL,NULL,NULL,NULL,NULL,NULL),(31,10,'Renny Hernandez',NULL,NULL,'17440014',NULL,NULL,NULL,NULL,NULL,NULL),(32,11,'Manuel Maia',NULL,NULL,'16378282',NULL,NULL,NULL,NULL,NULL,NULL),(33,12,'Evelyn Zoppi',NULL,NULL,'1877100',NULL,NULL,NULL,NULL,NULL,NULL),(34,14,'Vansa Leguizamo',NULL,NULL,'13309245',NULL,NULL,NULL,NULL,NULL,NULL),(35,16,'Mariela Castillo',NULL,NULL,'6510885',NULL,NULL,NULL,NULL,NULL,NULL),(36,17,'Tomas Guardia',NULL,NULL,'14876973',NULL,NULL,NULL,NULL,NULL,NULL),(37,19,'Antonio Silva',NULL,NULL,'9663887',NULL,NULL,NULL,NULL,NULL,NULL),(38,20,'Caribay Urbina',NULL,NULL,'3973369',NULL,NULL,NULL,NULL,NULL,NULL),(39,22,'Myloa Morgado',NULL,NULL,'14351182',NULL,NULL,NULL,NULL,NULL,NULL),(40,23,'Irene Santos',NULL,NULL,'15152698',NULL,NULL,NULL,NULL,NULL,NULL),(41,24,'Rhadames Carmona',NULL,NULL,'10804242',NULL,NULL,NULL,NULL,NULL,NULL),(42,25,'Ivan Flores',NULL,NULL,'10334608',NULL,NULL,NULL,NULL,NULL,NULL),(43,10,'RENNY ALEXANDER ','HERNANDEZ GUDIÑO',NULL,'17440014','04168126914','02126051065',NULL,NULL,NULL,NULL),(44,26,'Kenyer Eduardo','Aguiar Aponte',NULL,'19156429','04165340134','02469959109',NULL,NULL,'Matemática','Teoría de Operadores'),(45,27,'Rubén Erasmo','Torres Parra',NULL,'11405173','04164271024',NULL,NULL,NULL,'Ecología Acuática',NULL),(46,28,'Daniela Esperanza','Torrealba Gómez',NULL,'18031914','04126105810',NULL,NULL,NULL,'Álgebra y Lógica','teoría de Conjuntos y Teoría de Ramsey'),(47,29,'Natalia','Ortega Arias',NULL,'14906162','04141050855','02126051608',NULL,NULL,'Microscopía Electrónica','Catálisis'),(48,30,'Myloa Milagros','Morgado Vargas',NULL,'14351182','04142678127','02126051532',NULL,NULL,'Microscopía Electrónica','Catálisis'),(49,31,'Alfonso Gadir','Garmendia González',NULL,'18269302','04141203728','02392820128',NULL,NULL,'Matemática',NULL),(50,32,'Francisco Javier','Sans Palacios',NULL,'18244557','04127398830','02126051390',NULL,NULL,'Computación Gráfica',NULL);
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
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `planformacion`
--

LOCK TABLES `planformacion` WRITE;
/*!40000 ALTER TABLE `planformacion` DISABLE KEYS */;
INSERT INTO `planformacion` VALUES (1,'2013-09-27',NULL,1,26,4,NULL,'Escuela de Matemática','Centro de Análisis Matemático'),(2,'2014-01-15',NULL,1,27,12,NULL,'Escuela de Biología','Instituto de Zoología y Ecología Tropical'),(3,'2014-05-22',NULL,1,28,11,NULL,'Escuela de Matemática','Escuela de Matemática'),(4,'2014-09-18',NULL,1,29,20,NULL,'Centro de Microscopía Electrónica','Centro de Microscopía Electrónica'),(5,'2014-09-29',NULL,1,30,20,NULL,'Centro de Microscopía Electrónica','Centro de Microscopía Electrónica'),(6,'2014-12-16',NULL,1,31,23,NULL,'Grupo de Álgebra y Lógica',NULL),(7,'2015-01-26',NULL,1,32,24,NULL,'Escuela de Computacion','Centro de Computación Gráfica');
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
INSERT INTO `prorroga` VALUES (1,1,NULL,NULL),(2,2,NULL,NULL),(3,3,NULL,NULL),(4,4,NULL,NULL),(5,5,NULL,NULL),(6,6,NULL,NULL),(7,7,NULL,NULL);
/*!40000 ALTER TABLE `prorroga` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `resultado`
--

DROP TABLE IF EXISTS `resultado`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `resultado` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `tipo_resultado_id` int(11) DEFAULT NULL,
  `concepto` longtext,
  `tipo_publicacion` varchar(255) DEFAULT NULL,
  `titulo` varchar(255) DEFAULT NULL,
  `autor` varchar(255) DEFAULT NULL,
  `titulo_capitulo` varchar(255) DEFAULT NULL,
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
  PRIMARY KEY (`id`),
  KEY `resultadoTipoResultado` (`tipo_resultado_id`),
  CONSTRAINT `resultadoTipoResultado` FOREIGN KEY (`tipo_resultado_id`) REFERENCES `tipo_resultado` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
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
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
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
INSERT INTO `tipo_estatus` VALUES (1,'APROBADO POR CONSEJO DE FACULTAD'),(2,'ENVIADO A CONSEJO TÉCNICO'),(3,'ENVIADO A COMISIÓN DE INVESTIGACIÓN'),(4,'ENVIADO A CONSEJO DE FACULTAD'),(5,'APROBADO CON OBSERVACIONES POR CONSEJO DE FACULTAD'),(6,'GUARDADO'),(7,'EN REVISIÓN MENOR POR COMISIÓN DE INVESTIGACIÓN'),(8,'ENVIADO A CONSEJO DE ESCUELA');
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
INSERT INTO `tipo_resultado` VALUES (1,'Trabajos publicados'),(2,'Presentación de ponencias'),(3,'Presentación de informes técnicos'),(4,'Otros'),(5,'Asistencia a eventos científicos'),(6,'Organización de eventos científicos'),(7,'Dictado de cursos o seminarios científicos'),(8,'Grado de avance en los estudios de postgrado'),(9,'No contempladas en en el plan');
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
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=36 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `usuario`
--

LOCK TABLES `usuario` WRITE;
/*!40000 ALTER TABLE `usuario` DISABLE KEYS */;
INSERT INTO `usuario` VALUES (1,'zairap.yepez',1,1,NULL,NULL),(2,'tdivasta',1,1,NULL,NULL),(3,'comisioninv.computacion',1,1,NULL,NULL),(4,'marisela.dominguez',1,1,NULL,NULL),(5,'comisioninv.matematica',1,1,NULL,NULL),(6,'consejo.matematica',1,1,NULL,NULL),(7,'seconfac',1,1,NULL,NULL),(8,'consejo.computacion',1,1,NULL,NULL),(9,'consultace.matematica',1,1,NULL,NULL),(10,'renny.hernandez',1,1,NULL,NULL),(11,'manuel.maia',1,1,NULL,NULL),(12,'ezoppi',1,1,NULL,NULL),(13,'consultaci.computacion',1,1,NULL,NULL),(14,'vleguiza',1,1,NULL,NULL),(15,'consultaci.matematica',1,1,NULL,NULL),(16,'mariela.castillo',1,1,NULL,NULL),(17,'tomas_guardia',1,1,NULL,NULL),(18,'consulta.seconfac',1,1,NULL,NULL),(19,'asilva',1,1,NULL,NULL),(20,'curbina',1,1,NULL,NULL),(21,'consultace.computacion',1,1,NULL,NULL),(22,'myloa.morgado',1,1,NULL,NULL),(23,'irene.santos',1,1,NULL,NULL),(24,'rhadames.carmona',1,1,NULL,NULL),(25,'ivan.flores',1,1,NULL,NULL),(26,'kenyer.aguiar',1,1,NULL,NULL),(27,'ruben.torres',1,1,NULL,NULL),(28,'daniela.torrealba',1,1,NULL,NULL),(29,'natalia.ortega',1,1,NULL,NULL),(30,'myloa.morgado',1,1,NULL,NULL),(31,'alfonso.garmendia',1,1,NULL,NULL),(32,'francisco.sans',1,1,NULL,NULL),(35,'consejo.facultad',1,1,NULL,NULL);
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
  CONSTRAINT `usuarioEntidadEntidad` FOREIGN KEY (`entidad_id`) REFERENCES `entidad` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `usuarioEntidadUsuario` FOREIGN KEY (`usuario_id`) REFERENCES `usuario` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `usuarioEscuela` FOREIGN KEY (`escuela_id`) REFERENCES `escuela` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=37 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `usuarioentidad`
--

LOCK TABLES `usuarioentidad` WRITE;
/*!40000 ALTER TABLE `usuarioentidad` DISABLE KEYS */;
INSERT INTO `usuarioentidad` VALUES (1,1,18,NULL),(2,2,18,2),(3,3,8,2),(4,4,18,NULL),(5,5,11,9),(6,6,5,9),(7,7,13,11),(8,8,2,2),(9,9,11,9),(10,10,18,NULL),(11,11,18,NULL),(12,12,18,NULL),(13,13,8,2),(14,14,18,NULL),(15,15,5,9),(16,16,18,9),(17,17,18,9),(18,18,13,11),(19,19,18,NULL),(20,20,18,1),(21,21,8,2),(22,22,18,NULL),(23,23,18,NULL),(24,24,18,2),(25,25,18,2),(26,26,19,NULL),(27,27,19,NULL),(28,28,19,NULL),(29,29,19,NULL),(30,30,19,NULL),(31,31,19,NULL),(32,32,19,NULL),(36,35,13,NULL);
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

-- Dump completed on 2016-02-05  8:14:39