-- MariaDB dump 10.19-11.3.2-MariaDB, for Win64 (AMD64)
--
-- Host: localhost    Database: board
-- ------------------------------------------------------
-- Server version	11.3.2-MariaDB

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `author`
--

DROP TABLE IF EXISTS `author`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `author` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  `email` varchar(255) DEFAULT NULL,
  `password` varchar(255) DEFAULT NULL,
  `address` varchar(255) DEFAULT NULL,
  `age` tinyint(3) unsigned DEFAULT NULL,
  `profile_image` longblob DEFAULT NULL,
  `role` enum('user','myuser','admin') NOT NULL DEFAULT 'user',
  `birth_day` date DEFAULT NULL,
  `created_time` datetime DEFAULT current_timestamp(),
  `post_count` int(11) DEFAULT 0,
  PRIMARY KEY (`id`),
  UNIQUE KEY `email` (`email`)
) ENGINE=InnoDB AUTO_INCREMENT=106 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `author`
--

LOCK TABLES `author` WRITE;
/*!40000 ALTER TABLE `author` DISABLE KEYS */;
INSERT INTO `author` VALUES
(4,'lee','lee@naver.com',NULL,NULL,30,NULL,'myuser',NULL,NULL,0),
(7,'hong','hellohello@naver.com',NULL,NULL,24,NULL,'myuser',NULL,NULL,0),
(8,'kwak','byebye@naver.com',NULL,NULL,35,NULL,'myuser',NULL,NULL,0),
(9,'홍길동','sky@naver.com',NULL,NULL,22,NULL,'myuser',NULL,NULL,0),
(10,'김길동','ten@naver.com',NULL,NULL,21,NULL,'myuser',NULL,NULL,0),
(11,'정길동','ten1@naver.com',NULL,NULL,38,NULL,'myuser',NULL,NULL,0),
(12,'박길동','hello@naver.com',NULL,NULL,50,NULL,'user','1999-05-01',NULL,0),
(13,'이길동','hello11@naver.com',NULL,NULL,27,NULL,'user','1999-05-02',NULL,0),
(14,NULL,'hello22@naver.com',NULL,NULL,65,NULL,'user',NULL,'2009-11-23 08:12:38',0),
(15,NULL,'hello33@naver.com',NULL,NULL,78,NULL,'user',NULL,'2024-05-17 12:33:26',0),
(100,'abc','abc@test.com',NULL,NULL,44,NULL,'myuser',NULL,NULL,0),
(101,'kimkim','kimkim@naver.com',NULL,NULL,NULL,NULL,'user',NULL,'2024-05-20 15:38:02',0),
(104,'kimkimkim','kimkimkim@naver.com',NULL,NULL,NULL,NULL,'user',NULL,'2024-05-20 15:39:23',0),
(105,'kimkimkim','kimkimkim1@naver.com',NULL,NULL,NULL,NULL,'user',NULL,'2024-05-20 15:39:41',0);
/*!40000 ALTER TABLE `author` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `post`
--

DROP TABLE IF EXISTS `post`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `post` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `title` varchar(255) NOT NULL,
  `contents` varchar(3000) DEFAULT NULL,
  `author_id` bigint(20) DEFAULT NULL,
  `price` decimal(10,3) DEFAULT NULL,
  `created_time` datetime DEFAULT current_timestamp(),
  `user_id` char(36) DEFAULT uuid(),
  PRIMARY KEY (`id`),
  KEY `author_id` (`author_id`),
  CONSTRAINT `post_author_fk` FOREIGN KEY (`author_id`) REFERENCES `author` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=37 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `post`
--

LOCK TABLES `post` WRITE;
/*!40000 ALTER TABLE `post` DISABLE KEYS */;
INSERT INTO `post` VALUES
(1,'hello','hello world java',100,1000.000,NULL,'ff4184c4-141e-11ef-93ee-8cb0e9d9411a'),
(2,'hello','hello world java',4,5000.000,NULL,'ff418576-141e-11ef-93ee-8cb0e9d9411a'),
(3,'hi','transaction',NULL,7800.000,NULL,'ff4185a6-141e-11ef-93ee-8cb0e9d9411a'),
(8,'hello hi',NULL,4,12000.000,'1999-05-02 13:24:26','ff4186b8-141e-11ef-93ee-8cb0e9d9411a'),
(9,'hello good','good',NULL,1300.000,'2021-11-29 16:15:31','ff4186dd-141e-11ef-93ee-8cb0e9d9411a'),
(10,'hello good','good',NULL,4500.000,'2018-05-01 16:15:35','ff4186f9-141e-11ef-93ee-8cb0e9d9411a'),
(11,'hello uuid',NULL,NULL,2000.000,'2024-05-17 16:28:30','0f1bf3fb-141f-11ef-93ee-8cb0e9d9411a'),
(21,'hello Java',NULL,7,1000.000,'2024-05-20 12:30:14','4645bc42-1659-11ef-93ee-8cb0e9d9411a'),
(22,'hello Java',NULL,8,4000.000,'2024-05-20 12:30:31','50271e3a-1659-11ef-93ee-8cb0e9d9411a'),
(23,'hello Java',NULL,8,7500.000,'2022-12-09 12:31:23','6f7bffe6-1659-11ef-93ee-8cb0e9d9411a'),
(32,'hello world java',NULL,100,5500.000,'2024-05-20 14:43:38','e9406bed-166b-11ef-93ee-8cb0e9d9411a');
/*!40000 ALTER TABLE `post` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2024-05-22 16:26:59
