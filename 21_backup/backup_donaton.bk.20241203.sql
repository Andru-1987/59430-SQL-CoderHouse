-- MySQL dump 10.13  Distrib 8.0.38, for Win64 (x86_64)
--
-- Host: 127.0.0.1    Database: donaton_bk
-- ------------------------------------------------------
-- Server version	9.0.1

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Current Database: `donaton_bk`
--

USE `donaton_bk`;

--
-- Table structure for table `beneficiario`
--

DROP TABLE IF EXISTS `beneficiario`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `beneficiario` (
  `id_beneficiario` int NOT NULL AUTO_INCREMENT,
  `direccion` varchar(200) DEFAULT NULL,
  `nombre_encargado` varchar(200) DEFAULT NULL,
  `fecha_creacion` date DEFAULT NULL,
  PRIMARY KEY (`id_beneficiario`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `beneficiario`
--

LOCK TABLES `beneficiario` WRITE;
/*!40000 ALTER TABLE `beneficiario` DISABLE KEYS */;
INSERT INTO `beneficiario` VALUES (1,'Calle 1 #123','Jos?? Mart??nez','2024-01-15'),(2,'Av. Principal 456','Mar??a Rodr??guez','2024-02-01'),(3,'Plaza Central 789','Roberto Garc??a','2024-02-15'),(4,'Paseo Norte 321','Ana L??pez','2024-03-01'),(5,'Calle Sur 654','Carolina Torres','2024-03-15');
/*!40000 ALTER TABLE `beneficiario` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `categoria_donacion`
--

DROP TABLE IF EXISTS `categoria_donacion`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `categoria_donacion` (
  `id_categoria_donacion` int NOT NULL AUTO_INCREMENT,
  `descripcion` varchar(200) DEFAULT NULL,
  `tipo` varchar(200) DEFAULT NULL,
  PRIMARY KEY (`id_categoria_donacion`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `categoria_donacion`
--

LOCK TABLES `categoria_donacion` WRITE;
/*!40000 ALTER TABLE `categoria_donacion` DISABLE KEYS */;
INSERT INTO `categoria_donacion` VALUES (1,'Alimentos no perecederos','Alimentaci??n'),(2,'Ropa de invierno','Vestimenta'),(3,'??tiles escolares','Educaci??n'),(4,'Art??culos de higiene','Salud'),(5,'Juguetes','Recreaci??n');
/*!40000 ALTER TABLE `categoria_donacion` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `categoria_voluntario`
--

DROP TABLE IF EXISTS `categoria_voluntario`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `categoria_voluntario` (
  `id_categoria_voluntario` int NOT NULL AUTO_INCREMENT,
  `descripcion_tareas` varchar(200) DEFAULT NULL,
  PRIMARY KEY (`id_categoria_voluntario`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `categoria_voluntario`
--

LOCK TABLES `categoria_voluntario` WRITE;
/*!40000 ALTER TABLE `categoria_voluntario` DISABLE KEYS */;
INSERT INTO `categoria_voluntario` VALUES (1,'Clasificaci??n de donaciones'),(2,'Distribuci??n de alimentos'),(3,'Apoyo en eventos especiales'),(4,'Atenci??n a beneficiarios'),(5,'Log??stica y transporte');
/*!40000 ALTER TABLE `categoria_voluntario` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `centro_recepcion`
--

DROP TABLE IF EXISTS `centro_recepcion`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `centro_recepcion` (
  `id_centro_recepcion` int NOT NULL AUTO_INCREMENT,
  `ubicacion` varchar(200) NOT NULL,
  `encargado` varchar(200) NOT NULL,
  PRIMARY KEY (`id_centro_recepcion`),
  UNIQUE KEY `ubicacion` (`ubicacion`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `centro_recepcion`
--

LOCK TABLES `centro_recepcion` WRITE;
/*!40000 ALTER TABLE `centro_recepcion` DISABLE KEYS */;
INSERT INTO `centro_recepcion` VALUES (1,'Av. Principal 123','Pedro Ram??rez'),(2,'Calle Central 456','Laura Torres'),(3,'Plaza Mayor 789','Miguel ??ngel Ruiz'),(4,'Av. Libertad 321','Carmen Vega'),(5,'Paseo del Sol 654','Daniel Morales');
/*!40000 ALTER TABLE `centro_recepcion` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `centro_recepcion_beneficiario`
--

DROP TABLE IF EXISTS `centro_recepcion_beneficiario`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `centro_recepcion_beneficiario` (
  `id_centro_recepcion_beneficiario` int NOT NULL AUTO_INCREMENT,
  `id_beneficiario` int DEFAULT NULL,
  `id_centro_recepcion` int DEFAULT NULL,
  `voluntario` int DEFAULT NULL,
  `fecha_entrega` date DEFAULT NULL,
  PRIMARY KEY (`id_centro_recepcion_beneficiario`),
  KEY `fk_const_id_beneficiario` (`id_beneficiario`),
  KEY `fk_const_id_centro_recepcion` (`id_centro_recepcion`),
  CONSTRAINT `fk_const_id_beneficiario` FOREIGN KEY (`id_beneficiario`) REFERENCES `beneficiario` (`id_beneficiario`),
  CONSTRAINT `fk_const_id_centro_recepcion` FOREIGN KEY (`id_centro_recepcion`) REFERENCES `centro_recepcion` (`id_centro_recepcion`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `centro_recepcion_beneficiario`
--

LOCK TABLES `centro_recepcion_beneficiario` WRITE;
/*!40000 ALTER TABLE `centro_recepcion_beneficiario` DISABLE KEYS */;
INSERT INTO `centro_recepcion_beneficiario` VALUES (1,1,3,2,'2024-04-15'),(2,2,1,4,'2024-04-16'),(3,3,2,1,'2024-04-17'),(4,4,5,3,'2024-04-18'),(5,5,4,5,'2024-04-19'),(6,1,2,3,'2024-04-20'),(7,2,3,1,'2024-04-21'),(8,3,4,2,'2024-04-22'),(9,4,1,5,'2024-04-23'),(10,5,5,4,'2024-04-24');
/*!40000 ALTER TABLE `centro_recepcion_beneficiario` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `centro_recepcion_voluntario`
--

DROP TABLE IF EXISTS `centro_recepcion_voluntario`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `centro_recepcion_voluntario` (
  `id_centro_recepcion_voluntario` int NOT NULL AUTO_INCREMENT,
  `id_centro_recepcion` int DEFAULT NULL,
  `id_voluntario` int DEFAULT NULL,
  `fecha_inicio_voluntario` date DEFAULT NULL,
  `fecha_fin_voluntario` date DEFAULT NULL,
  PRIMARY KEY (`id_centro_recepcion_voluntario`),
  KEY `fk_c_id_centro_recepcion` (`id_centro_recepcion`),
  KEY `fk_c_id_voluntario` (`id_voluntario`),
  CONSTRAINT `fk_c_id_centro_recepcion` FOREIGN KEY (`id_centro_recepcion`) REFERENCES `centro_recepcion` (`id_centro_recepcion`),
  CONSTRAINT `fk_c_id_voluntario` FOREIGN KEY (`id_voluntario`) REFERENCES `voluntario` (`id_voluntario`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `centro_recepcion_voluntario`
--

LOCK TABLES `centro_recepcion_voluntario` WRITE;
/*!40000 ALTER TABLE `centro_recepcion_voluntario` DISABLE KEYS */;
INSERT INTO `centro_recepcion_voluntario` VALUES (1,1,3,'2024-01-01','2024-06-30'),(2,2,4,'2024-01-15','2024-07-15'),(3,3,1,'2024-02-01','2024-08-01'),(4,4,5,'2024-02-15','2024-08-15'),(5,5,2,'2024-03-01','2024-09-01'),(6,1,5,'2024-03-15','2024-09-15'),(7,2,3,'2024-04-01','2024-10-01'),(8,3,4,'2024-04-15','2024-10-15'),(9,4,1,'2024-05-01','2024-11-01'),(10,5,2,'2024-05-15','2024-11-15');
/*!40000 ALTER TABLE `centro_recepcion_voluntario` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `donacion`
--

DROP TABLE IF EXISTS `donacion`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `donacion` (
  `id_donacion` int NOT NULL AUTO_INCREMENT,
  `id_donador` int DEFAULT NULL,
  `id_categoria_donacion` int DEFAULT NULL,
  `id_centro_recepcion` int DEFAULT NULL,
  `cantidad` decimal(10,2) DEFAULT NULL,
  `detalles` varchar(200) DEFAULT NULL,
  `fecha_donacion` datetime DEFAULT (now()),
  `fecha_termino_donacion` date DEFAULT NULL,
  PRIMARY KEY (`id_donacion`),
  KEY `fk_constraint_id_donador` (`id_donador`),
  KEY `fk_constraint_id_categoria_donacion` (`id_categoria_donacion`),
  KEY `fk_constraint_id_centro_recepcion` (`id_centro_recepcion`),
  CONSTRAINT `fk_constraint_id_categoria_donacion` FOREIGN KEY (`id_categoria_donacion`) REFERENCES `categoria_donacion` (`id_categoria_donacion`),
  CONSTRAINT `fk_constraint_id_centro_recepcion` FOREIGN KEY (`id_centro_recepcion`) REFERENCES `centro_recepcion` (`id_centro_recepcion`),
  CONSTRAINT `fk_constraint_id_donador` FOREIGN KEY (`id_donador`) REFERENCES `donador` (`id_donador`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `donacion`
--

LOCK TABLES `donacion` WRITE;
/*!40000 ALTER TABLE `donacion` DISABLE KEYS */;
INSERT INTO `donacion` VALUES (1,1,2,3,500.00,'Donaci??n de ropa de invierno','2024-12-03 22:19:52','2024-06-30'),(2,2,1,1,1000.00,'Alimentos no perecederos','2024-12-03 22:19:52','2024-05-15'),(3,3,4,2,300.00,'Art??culos de higiene personal','2024-12-03 22:19:52','2024-07-01'),(4,4,3,4,750.00,'??tiles escolares para primaria','2024-12-03 22:19:52','2024-08-15'),(5,5,5,5,250.00,'Juguetes educativos','2024-12-03 22:19:52','2024-06-15'),(6,1,1,2,800.00,'Alimentos para comedor comunitario','2024-12-03 22:19:52','2024-05-30'),(7,2,3,3,450.00,'Material escolar','2024-12-03 22:19:52','2024-07-15'),(8,3,2,1,600.00,'Ropa para ni??os','2024-12-03 22:19:52','2024-06-01'),(9,4,5,5,350.00,'Juguetes para navidad','2024-12-03 22:19:52','2024-12-24'),(10,5,4,4,900.00,'Kit de higiene familiar','2024-12-03 22:19:52','2024-08-01');
/*!40000 ALTER TABLE `donacion` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `donador`
--

DROP TABLE IF EXISTS `donador`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `donador` (
  `id_donador` int NOT NULL AUTO_INCREMENT,
  `nombre` varchar(100) DEFAULT NULL,
  `email` varchar(200) DEFAULT NULL,
  `status_donador` enum('ANONIMO','PUBLICA') DEFAULT NULL,
  PRIMARY KEY (`id_donador`),
  UNIQUE KEY `email` (`email`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `donador`
--

LOCK TABLES `donador` WRITE;
/*!40000 ALTER TABLE `donador` DISABLE KEYS */;
INSERT INTO `donador` VALUES (1,'Juan P??rez','juan.perez@email.com','PUBLICA'),(2,'Mar??a Garc??a','maria.garcia@email.com','ANONIMO'),(3,'Carlos L??pez','carlos.lopez@email.com','PUBLICA'),(4,'Ana Mart??nez','ana.martinez@email.com','PUBLICA'),(5,'Roberto S??nchez','roberto.sanchez@email.com','ANONIMO');
/*!40000 ALTER TABLE `donador` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `voluntario`
--

DROP TABLE IF EXISTS `voluntario`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `voluntario` (
  `id_voluntario` int NOT NULL AUTO_INCREMENT,
  `nombre` varchar(200) NOT NULL,
  `fecha_nacimiento` date DEFAULT NULL,
  PRIMARY KEY (`id_voluntario`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `voluntario`
--

LOCK TABLES `voluntario` WRITE;
/*!40000 ALTER TABLE `voluntario` DISABLE KEYS */;
INSERT INTO `voluntario` VALUES (1,'Luis Gonz??lez','1990-05-15'),(2,'Patricia Flores','1988-09-22'),(3,'Fernando Castro','1995-03-10'),(4,'Alejandra D??az','1992-11-30'),(5,'Ricardo Mendoza','1985-07-25');
/*!40000 ALTER TABLE `voluntario` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `voluntario_categoria`
--

DROP TABLE IF EXISTS `voluntario_categoria`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `voluntario_categoria` (
  `id_voluntario_categoria` int NOT NULL AUTO_INCREMENT,
  `id_categoria_` int DEFAULT NULL,
  `id_beneficiario` int DEFAULT NULL,
  PRIMARY KEY (`id_voluntario_categoria`),
  KEY `fk_const_id_categoria_` (`id_categoria_`),
  KEY `fk_const_id_beneficiario_categoria` (`id_beneficiario`),
  CONSTRAINT `fk_const_id_beneficiario_categoria` FOREIGN KEY (`id_beneficiario`) REFERENCES `beneficiario` (`id_beneficiario`),
  CONSTRAINT `fk_const_id_categoria_` FOREIGN KEY (`id_categoria_`) REFERENCES `categoria_voluntario` (`id_categoria_voluntario`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `voluntario_categoria`
--

LOCK TABLES `voluntario_categoria` WRITE;
/*!40000 ALTER TABLE `voluntario_categoria` DISABLE KEYS */;
INSERT INTO `voluntario_categoria` VALUES (1,1,3),(2,2,1),(3,3,2),(4,4,5),(5,5,4),(6,1,2),(7,2,3),(8,3,1),(9,4,4),(10,5,5);
/*!40000 ALTER TABLE `voluntario_categoria` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Temporary view structure for view `vw_donaciones_por_categoria`
--

DROP TABLE IF EXISTS `vw_donaciones_por_categoria`;
/*!50001 DROP VIEW IF EXISTS `vw_donaciones_por_categoria`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `vw_donaciones_por_categoria` AS SELECT 
 1 AS `tipo`,
 1 AS `descripcion`,
 1 AS `cantidad_donaciones`,
 1 AS `monto_total`,
 1 AS `donadores_unicos`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `vw_donaciones_por_periodo`
--

DROP TABLE IF EXISTS `vw_donaciones_por_periodo`;
/*!50001 DROP VIEW IF EXISTS `vw_donaciones_por_periodo`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `vw_donaciones_por_periodo` AS SELECT 
 1 AS `periodo`,
 1 AS `total_donaciones`,
 1 AS `monto_total`,
 1 AS `promedio_donacion`*/;
SET character_set_client = @saved_cs_client;

--
-- Dumping routines for database 'donaton_bk'
--
/*!50003 DROP FUNCTION IF EXISTS `fx_mayor_edad` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`%` FUNCTION `fx_mayor_edad`( dob DATE ) RETURNS tinyint(1)
    READS SQL DATA
BEGIN
	RETURN (DATEDIFF( current_date (), dob ) / 365 ) > 18;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_donadores_segun_fecha` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`%` PROCEDURE `sp_donadores_segun_fecha`(IN periodo DATE )
BEGIN

    
    DECLARE existen_donadores BOOLEAN DEFAULT FALSE;
    SELECT 

        COUNT(1) > 0  INTO existen_donadores
    FROM donaton.donacion
    WHERE fecha_donacion BETWEEN periodo AND DATE_ADD(periodo, INTERVAL 1 MONTH);

    IF existen_donadores THEN
        DROP TABLE IF EXISTS donaton.donadores_fecha;

        CREATE TABLE donaton.donadores_fecha
            AS
            SELECT  nombre,
                    total_donaciones,
                    periodo AS fecha_muestreo,
                    DATE_ADD(periodo, INTERVAL 1 MONTH) AS fecha_cierre
            FROM (
                SELECT 
                    do.nombre,
                    COUNT(1) AS total_donaciones
                FROM donaton.donador AS do
                LEFT JOIN donaton.donacion AS don
                    USING(id_donador)
                WHERE don.fecha_donacion BETWEEN periodo AND DATE_ADD(periodo, INTERVAL 1 MONTH)
                GROUP BY id_donador) AS data_proc;


        ELSE
        
        SELECT CONCAT('No se encontraron donaciones para el per??odo: ', 
                     DATE_FORMAT(periodo, '%Y-%m-%d'), 
                     ' al ', 
                     DATE_FORMAT(DATE_ADD(periodo, INTERVAL 1 MONTH), '%Y-%m-%d')) 
        AS mensaje;

    END IF;

    SELECT * FROM donaton.donadores_fecha;
        

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Current Database: `donaton_bk`
--

USE `donaton_bk`;

--
-- Final view structure for view `vw_donaciones_por_categoria`
--

/*!50001 DROP VIEW IF EXISTS `vw_donaciones_por_categoria`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`%` SQL SECURITY DEFINER */
/*!50001 VIEW `vw_donaciones_por_categoria` AS select `cd`.`tipo` AS `tipo`,`cd`.`descripcion` AS `descripcion`,count(1) AS `cantidad_donaciones`,sum(`d`.`cantidad`) AS `monto_total`,count(distinct `d`.`id_donador`) AS `donadores_unicos` from (`categoria_donacion` `cd` left join `donacion` `d` on((`cd`.`id_categoria_donacion` = `d`.`id_categoria_donacion`))) group by `cd`.`id_categoria_donacion` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `vw_donaciones_por_periodo`
--

/*!50001 DROP VIEW IF EXISTS `vw_donaciones_por_periodo`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`%` SQL SECURITY DEFINER */
/*!50001 VIEW `vw_donaciones_por_periodo` AS select date_format(`donacion`.`fecha_donacion`,'%Y-%m') AS `periodo`,count(1) AS `total_donaciones`,sum(`donacion`.`cantidad`) AS `monto_total`,avg(`donacion`.`cantidad`) AS `promedio_donacion` from `donacion` group by date_format(`donacion`.`fecha_donacion`,'%Y-%m') */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2024-12-03 20:48:00
