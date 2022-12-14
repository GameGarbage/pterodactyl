-- MariaDB dump 10.19  Distrib 10.5.18-MariaDB, for debian-linux-gnu (aarch64)
--
-- Host: localhost    Database: panel
-- ------------------------------------------------------
-- Server version	10.5.18-MariaDB-1:10.5.18+maria~ubu2004

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
-- Current Database: `panel`
--

CREATE DATABASE /*!32312 IF NOT EXISTS*/ `panel` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci */;

USE `panel`;

--
-- Table structure for table `activity_log_subjects`
--

DROP TABLE IF EXISTS `activity_log_subjects`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `activity_log_subjects` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `activity_log_id` bigint(20) unsigned NOT NULL,
  `subject_type` varchar(191) NOT NULL,
  `subject_id` bigint(20) unsigned NOT NULL,
  PRIMARY KEY (`id`),
  KEY `activity_log_subjects_activity_log_id_foreign` (`activity_log_id`),
  KEY `activity_log_subjects_subject_type_subject_id_index` (`subject_type`,`subject_id`),
  CONSTRAINT `activity_log_subjects_activity_log_id_foreign` FOREIGN KEY (`activity_log_id`) REFERENCES `activity_logs` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `activity_log_subjects`
--

LOCK TABLES `activity_log_subjects` WRITE;
/*!40000 ALTER TABLE `activity_log_subjects` DISABLE KEYS */;
INSERT INTO `activity_log_subjects` VALUES (1,1,'user',2),(2,2,'user',2);
/*!40000 ALTER TABLE `activity_log_subjects` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `activity_logs`
--

DROP TABLE IF EXISTS `activity_logs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `activity_logs` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `batch` char(36) DEFAULT NULL,
  `event` varchar(191) NOT NULL,
  `ip` varchar(191) NOT NULL,
  `description` text DEFAULT NULL,
  `actor_type` varchar(191) DEFAULT NULL,
  `actor_id` bigint(20) unsigned DEFAULT NULL,
  `api_key_id` int(10) unsigned DEFAULT NULL,
  `properties` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL CHECK (json_valid(`properties`)),
  `timestamp` timestamp NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`),
  KEY `activity_logs_actor_type_actor_id_index` (`actor_type`,`actor_id`),
  KEY `activity_logs_event_index` (`event`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `activity_logs`
--

LOCK TABLES `activity_logs` WRITE;
/*!40000 ALTER TABLE `activity_logs` DISABLE KEYS */;
INSERT INTO `activity_logs` VALUES (1,NULL,'auth:success','172.20.0.1',NULL,'user',2,NULL,'{\"ip\":\"172.20.0.1\",\"useragent\":\"Mozilla\\/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit\\/537.36 (KHTML, like Gecko) Chrome\\/107.0.0.0 Safari\\/537.36 Edg\\/107.0.1418.56\"}','2022-11-30 13:29:54'),(2,NULL,'auth:success','172.20.0.1',NULL,'user',2,NULL,'{\"ip\":\"172.20.0.1\",\"useragent\":\"Mozilla\\/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit\\/537.36 (KHTML, like Gecko) Chrome\\/107.0.0.0 Safari\\/537.36 Edg\\/107.0.1418.62\"}','2022-12-03 10:03:15');
/*!40000 ALTER TABLE `activity_logs` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `allocations`
--

DROP TABLE IF EXISTS `allocations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `allocations` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `node_id` int(10) unsigned NOT NULL,
  `ip` varchar(191) NOT NULL,
  `ip_alias` text DEFAULT NULL,
  `port` mediumint(8) unsigned NOT NULL,
  `server_id` int(10) unsigned DEFAULT NULL,
  `notes` varchar(191) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `allocations_node_id_ip_port_unique` (`node_id`,`ip`,`port`),
  KEY `allocations_server_id_foreign` (`server_id`),
  CONSTRAINT `allocations_node_id_foreign` FOREIGN KEY (`node_id`) REFERENCES `nodes` (`id`) ON DELETE CASCADE,
  CONSTRAINT `allocations_server_id_foreign` FOREIGN KEY (`server_id`) REFERENCES `servers` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `allocations`
--

LOCK TABLES `allocations` WRITE;
/*!40000 ALTER TABLE `allocations` DISABLE KEYS */;
INSERT INTO `allocations` VALUES (1,1,'127.0.0.1','hub',25566,NULL,NULL,NULL,'2022-12-03 15:17:56');
/*!40000 ALTER TABLE `allocations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `api_keys`
--

DROP TABLE IF EXISTS `api_keys`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `api_keys` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` int(10) unsigned NOT NULL,
  `key_type` tinyint(3) unsigned NOT NULL DEFAULT 0,
  `identifier` char(16) DEFAULT NULL,
  `token` text NOT NULL,
  `allowed_ips` text DEFAULT NULL,
  `memo` text DEFAULT NULL,
  `last_used_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `r_servers` tinyint(3) unsigned NOT NULL DEFAULT 0,
  `r_nodes` tinyint(3) unsigned NOT NULL DEFAULT 0,
  `r_allocations` tinyint(3) unsigned NOT NULL DEFAULT 0,
  `r_users` tinyint(3) unsigned NOT NULL DEFAULT 0,
  `r_locations` tinyint(3) unsigned NOT NULL DEFAULT 0,
  `r_nests` tinyint(3) unsigned NOT NULL DEFAULT 0,
  `r_eggs` tinyint(3) unsigned NOT NULL DEFAULT 0,
  `r_database_hosts` tinyint(3) unsigned NOT NULL DEFAULT 0,
  `r_server_databases` tinyint(3) unsigned NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`),
  UNIQUE KEY `api_keys_identifier_unique` (`identifier`),
  KEY `api_keys_user_id_foreign` (`user_id`),
  CONSTRAINT `api_keys_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `api_keys`
--

LOCK TABLES `api_keys` WRITE;
/*!40000 ALTER TABLE `api_keys` DISABLE KEYS */;
INSERT INTO `api_keys` VALUES (1,2,2,'ptla_i9onqlr9lUU','eyJpdiI6Im5WWUtxMWpSWWIxdytsaDl0UmY2ZHc9PSIsInZhbHVlIjoiYUFyRytrb2FUNGxmdmJZd3plbXRUMGlFSnJmM2tJM2RzZ01VK3FOM1dDTElWUlBvUTVMVUpzeFZraytMZVZYQSIsIm1hYyI6IjMzMzdjZjE4MWE2YWE3ZjhlMDc4MDJlNTM1NDAxYmEwYzhiMjFlOTRkNmEwYzc2OWQ1YWY0YjJkOTI4YzdhZDEiLCJ0YWciOiIifQ==','[]','Automatically generated node deployment key.',NULL,'2022-12-03 15:14:03','2022-12-03 15:14:03',0,1,0,0,0,0,0,0,0);
/*!40000 ALTER TABLE `api_keys` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `api_logs`
--

DROP TABLE IF EXISTS `api_logs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `api_logs` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `authorized` tinyint(1) NOT NULL,
  `error` text DEFAULT NULL,
  `key` char(16) DEFAULT NULL,
  `method` char(6) NOT NULL,
  `route` text NOT NULL,
  `content` text DEFAULT NULL,
  `user_agent` text NOT NULL,
  `request_ip` varchar(45) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `api_logs`
--

LOCK TABLES `api_logs` WRITE;
/*!40000 ALTER TABLE `api_logs` DISABLE KEYS */;
/*!40000 ALTER TABLE `api_logs` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `audit_logs`
--

DROP TABLE IF EXISTS `audit_logs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `audit_logs` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `uuid` char(36) NOT NULL,
  `is_system` tinyint(1) NOT NULL DEFAULT 0,
  `user_id` int(10) unsigned DEFAULT NULL,
  `server_id` int(10) unsigned DEFAULT NULL,
  `action` varchar(191) NOT NULL,
  `subaction` varchar(191) DEFAULT NULL,
  `device` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL CHECK (json_valid(`device`)),
  `metadata` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL CHECK (json_valid(`metadata`)),
  `created_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`id`),
  KEY `audit_logs_user_id_foreign` (`user_id`),
  KEY `audit_logs_server_id_foreign` (`server_id`),
  KEY `audit_logs_action_server_id_index` (`action`,`server_id`),
  CONSTRAINT `audit_logs_server_id_foreign` FOREIGN KEY (`server_id`) REFERENCES `servers` (`id`) ON DELETE CASCADE,
  CONSTRAINT `audit_logs_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `audit_logs`
--

LOCK TABLES `audit_logs` WRITE;
/*!40000 ALTER TABLE `audit_logs` DISABLE KEYS */;
/*!40000 ALTER TABLE `audit_logs` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `backups`
--

DROP TABLE IF EXISTS `backups`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `backups` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `server_id` int(10) unsigned NOT NULL,
  `uuid` char(36) NOT NULL,
  `upload_id` text DEFAULT NULL,
  `is_successful` tinyint(1) NOT NULL DEFAULT 0,
  `is_locked` tinyint(3) unsigned NOT NULL DEFAULT 0,
  `name` varchar(191) NOT NULL,
  `ignored_files` text NOT NULL,
  `disk` varchar(191) NOT NULL,
  `checksum` varchar(191) DEFAULT NULL,
  `bytes` bigint(20) unsigned NOT NULL DEFAULT 0,
  `completed_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `backups_uuid_unique` (`uuid`),
  KEY `backups_server_id_foreign` (`server_id`),
  CONSTRAINT `backups_server_id_foreign` FOREIGN KEY (`server_id`) REFERENCES `servers` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `backups`
--

LOCK TABLES `backups` WRITE;
/*!40000 ALTER TABLE `backups` DISABLE KEYS */;
/*!40000 ALTER TABLE `backups` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `database_hosts`
--

DROP TABLE IF EXISTS `database_hosts`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `database_hosts` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(191) NOT NULL,
  `host` varchar(191) NOT NULL,
  `port` int(10) unsigned NOT NULL,
  `username` varchar(191) NOT NULL,
  `password` text NOT NULL,
  `max_databases` int(10) unsigned DEFAULT NULL,
  `node_id` int(10) unsigned DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `database_hosts_node_id_foreign` (`node_id`),
  CONSTRAINT `database_hosts_node_id_foreign` FOREIGN KEY (`node_id`) REFERENCES `nodes` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `database_hosts`
--

LOCK TABLES `database_hosts` WRITE;
/*!40000 ALTER TABLE `database_hosts` DISABLE KEYS */;
/*!40000 ALTER TABLE `database_hosts` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `databases`
--

DROP TABLE IF EXISTS `databases`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `databases` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `server_id` int(10) unsigned NOT NULL,
  `database_host_id` int(10) unsigned NOT NULL,
  `database` varchar(191) NOT NULL,
  `username` varchar(191) NOT NULL,
  `remote` varchar(191) NOT NULL DEFAULT '%',
  `password` text NOT NULL,
  `max_connections` int(11) DEFAULT 0,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `databases_database_host_id_username_unique` (`database_host_id`,`username`),
  UNIQUE KEY `databases_database_host_id_server_id_database_unique` (`database_host_id`,`server_id`,`database`),
  KEY `databases_server_id_foreign` (`server_id`),
  CONSTRAINT `databases_database_host_id_foreign` FOREIGN KEY (`database_host_id`) REFERENCES `database_hosts` (`id`),
  CONSTRAINT `databases_server_id_foreign` FOREIGN KEY (`server_id`) REFERENCES `servers` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `databases`
--

LOCK TABLES `databases` WRITE;
/*!40000 ALTER TABLE `databases` DISABLE KEYS */;
/*!40000 ALTER TABLE `databases` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `egg_mount`
--

DROP TABLE IF EXISTS `egg_mount`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `egg_mount` (
  `egg_id` int(10) unsigned NOT NULL,
  `mount_id` int(10) unsigned NOT NULL,
  UNIQUE KEY `egg_mount_egg_id_mount_id_unique` (`egg_id`,`mount_id`),
  KEY `egg_mount_mount_id_foreign` (`mount_id`),
  CONSTRAINT `egg_mount_egg_id_foreign` FOREIGN KEY (`egg_id`) REFERENCES `eggs` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `egg_mount_mount_id_foreign` FOREIGN KEY (`mount_id`) REFERENCES `mounts` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `egg_mount`
--

LOCK TABLES `egg_mount` WRITE;
/*!40000 ALTER TABLE `egg_mount` DISABLE KEYS */;
/*!40000 ALTER TABLE `egg_mount` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `egg_variables`
--

DROP TABLE IF EXISTS `egg_variables`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `egg_variables` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `egg_id` int(10) unsigned NOT NULL,
  `name` varchar(191) NOT NULL,
  `description` text NOT NULL,
  `env_variable` varchar(191) NOT NULL,
  `default_value` text NOT NULL,
  `user_viewable` tinyint(3) unsigned NOT NULL,
  `user_editable` tinyint(3) unsigned NOT NULL,
  `rules` text DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `service_variables_egg_id_foreign` (`egg_id`),
  CONSTRAINT `service_variables_egg_id_foreign` FOREIGN KEY (`egg_id`) REFERENCES `eggs` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=68 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `egg_variables`
--

LOCK TABLES `egg_variables` WRITE;
/*!40000 ALTER TABLE `egg_variables` DISABLE KEYS */;
INSERT INTO `egg_variables` VALUES (1,1,'Bungeecord Version','The version of Bungeecord to download and use.','BUNGEE_VERSION','latest',1,1,'required|alpha_num|between:1,6','2022-11-27 16:19:20','2022-12-04 10:47:18'),(2,1,'Bungeecord Jar File','The name of the Jarfile to use when running Bungeecord.','SERVER_JARFILE','bungeecord.jar',1,1,'required|regex:/^([\\w\\d._-]+)(\\.jar)$/','2022-11-27 16:19:20','2022-12-04 10:47:18'),(3,2,'Server Jar File','The name of the server jarfile to run the server with.','SERVER_JARFILE','server.jar',1,1,'required|regex:/^([\\w\\d._-]+)(\\.jar)$/','2022-11-27 16:19:20','2022-12-04 10:47:18'),(4,2,'Server Version','The version of Minecraft Vanilla to install. Use \"latest\" to install the latest version, or use \"snapshot\" to install the latest snapshot. Go to Settings > Reinstall Server to apply.','VANILLA_VERSION','latest',1,1,'required|string|between:3,15','2022-11-27 16:19:20','2022-12-04 10:47:18'),(5,3,'Minecraft Version','The version of minecraft to download. \r\n\r\nLeave at latest to always get the latest version. Invalid versions will default to latest.','MINECRAFT_VERSION','latest',1,1,'nullable|string|max:20','2022-11-27 16:19:20','2022-12-04 10:47:18'),(6,3,'Server Jar File','The name of the server jarfile to run the server with.','SERVER_JARFILE','server.jar',1,1,'required|regex:/^([\\w\\d._-]+)(\\.jar)$/','2022-11-27 16:19:20','2022-12-04 10:47:18'),(7,3,'Download Path','A URL to use to download a server.jar rather than the ones in the install script. This is not user viewable.','DL_PATH','',0,0,'nullable|string','2022-11-27 16:19:20','2022-12-04 10:47:18'),(8,3,'Build Number','The build number for the paper release.\r\n\r\nLeave at latest to always get the latest version. Invalid versions will default to latest.','BUILD_NUMBER','latest',1,1,'required|string|max:20','2022-11-27 16:19:20','2022-12-04 10:47:18'),(9,4,'Server Jar File','The name of the Jarfile to use when running Forge version below 1.17.','SERVER_JARFILE','server.jar',1,1,'required|regex:/^([\\w\\d._-]+)(\\.jar)$/','2022-11-27 16:19:20','2022-12-04 10:47:18'),(10,4,'Minecraft Version','The version of minecraft you want to install for.\r\n\r\nLeaving latest will install the latest recommended version.','MC_VERSION','latest',1,1,'required|string|max:9','2022-11-27 16:19:20','2022-12-04 10:47:18'),(11,4,'Build Type','The type of server jar to download from forge.\r\n\r\nValid types are \"recommended\" and \"latest\".','BUILD_TYPE','recommended',1,1,'required|string|in:recommended,latest','2022-11-27 16:19:20','2022-12-04 10:47:18'),(12,4,'Forge Version','Gets an exact version.\r\n\r\nEx. 1.15.2-31.2.4\r\n\r\nOverrides MC_VERSION and BUILD_TYPE. If it fails to download the server files it will fail to install.','FORGE_VERSION','',1,1,'nullable|string|max:25','2022-11-27 16:19:20','2022-12-04 10:47:18'),(13,5,'Sponge Version','The version of SpongeVanilla to download and use.','SPONGE_VERSION','1.12.2-7.3.0',1,1,'required|regex:/^([a-zA-Z0-9.\\-_]+)$/','2022-11-27 16:19:20','2022-12-04 10:47:18'),(14,5,'Server Jar File','The name of the Jarfile to use when running SpongeVanilla.','SERVER_JARFILE','server.jar',1,1,'required|regex:/^([\\w\\d._-]+)(\\.jar)$/','2022-11-27 16:19:20','2022-12-04 10:47:18'),(15,6,'Map','The default map for the server.','SRCDS_MAP','gm_flatgrass',1,1,'required|string|alpha_dash','2022-11-27 16:19:20','2022-12-04 10:47:18'),(16,6,'Steam Account Token','The Steam Account Token required for the server to be displayed publicly.','STEAM_ACC','',1,1,'nullable|string|alpha_num|size:32','2022-11-27 16:19:20','2022-12-04 10:47:18'),(17,6,'Source AppID','Required for game to update on server restart. Do not modify this.','SRCDS_APPID','4020',0,0,'required|string|max:20','2022-11-27 16:19:20','2022-12-04 10:47:18'),(18,6,'Workshop ID','The ID of your workshop collection (the numbers at the end of the URL)','WORKSHOP_ID','',1,1,'nullable|integer','2022-11-27 16:19:20','2022-12-04 10:47:18'),(19,6,'Gamemode','The gamemode of your server.','GAMEMODE','sandbox',1,1,'required|string','2022-11-27 16:19:20','2022-12-04 10:47:18'),(20,6,'Max Players','The maximum amount of players allowed on your game server.','MAX_PLAYERS','32',1,1,'required|integer|max:128','2022-11-27 16:19:20','2022-12-04 10:47:18'),(21,6,'Tickrate','The tickrate defines how fast the server will update each entity\'s location.','TICKRATE','22',1,1,'required|integer|max:100','2022-11-27 16:19:20','2022-12-04 10:47:18'),(22,6,'Lua Refresh','0 = disable Lua refresh,\r\n1 = enable Lua refresh','LUA_REFRESH','0',1,1,'required|boolean','2022-11-27 16:19:20','2022-12-04 10:47:18'),(23,7,'Game ID','The ID corresponding to the game to download and run using SRCDS.','SRCDS_APPID','',1,0,'required|numeric|digits_between:1,6','2022-11-27 16:19:20','2022-12-04 10:47:18'),(24,7,'Game Name','The name corresponding to the game to download and run using SRCDS.','SRCDS_GAME','',1,0,'required|alpha_dash|between:1,100','2022-11-27 16:19:20','2022-12-04 10:47:18'),(25,7,'Map','The default map for the server.','SRCDS_MAP','',1,1,'required|string|alpha_dash','2022-11-27 16:19:20','2022-12-04 10:47:18'),(26,7,'Steam Username','','STEAM_USER','',1,1,'nullable|string','2022-11-27 16:19:20','2022-12-04 10:47:18'),(27,7,'Steam Password','','STEAM_PASS','',1,1,'nullable|string','2022-11-27 16:19:20','2022-12-04 10:47:18'),(28,7,'Steam Auth','','STEAM_AUTH','',1,1,'nullable|string','2022-11-27 16:19:20','2022-12-04 10:47:18'),(29,8,'Game ID','The ID corresponding to the game to download and run using SRCDS.','SRCDS_APPID','237410',1,0,'required|regex:/^(237410)$/','2022-11-27 16:19:20','2022-12-04 10:47:18'),(30,8,'Default Map','The default map to use when starting the server.','SRCDS_MAP','sinjar',1,1,'required|regex:/^(\\w{1,20})$/','2022-11-27 16:19:20','2022-12-04 10:47:18'),(31,9,'Server Password','If specified, players must provide this password to join the server.','ARK_PASSWORD','',1,1,'nullable|alpha_dash|between:1,100','2022-11-27 16:19:20','2022-12-04 10:47:18'),(32,9,'Admin Password','If specified, players must provide this password (via the in-game console) to gain access to administrator commands on the server.','ARK_ADMIN_PASSWORD','PleaseChangeMe',1,1,'required|alpha_dash|between:1,100','2022-11-27 16:19:20','2022-12-04 10:47:18'),(33,9,'Server Map','Available Maps: TheIsland, TheCenter, Ragnarok, ScorchedEarth_P, Aberration_P, Extinction, Valguero_P, Genesis, CrystalIsles, Gen2, LostIsland, Fjordur','SERVER_MAP','TheIsland',1,1,'required|string|max:20','2022-11-27 16:19:20','2022-12-04 10:47:18'),(34,9,'Server Name','ARK server name','SESSION_NAME','A Pterodactyl Hosted ARK Server',1,1,'required|string|max:128','2022-11-27 16:19:20','2022-12-04 10:47:18'),(35,9,'Rcon Port','ARK rcon port used by rcon tools.','RCON_PORT','27020',1,1,'required|numeric','2022-11-27 16:19:20','2022-12-04 10:47:18'),(36,9,'Query Port','ARK query port used by steam server browser and ark client server browser.','QUERY_PORT','27015',1,1,'required|numeric','2022-11-27 16:19:20','2022-12-04 10:47:18'),(37,9,'Auto-update server','This is to enable auto-updating for servers.\r\n\r\nDefault is 0. Set to 1 to update','AUTO_UPDATE','0',1,1,'required|boolean','2022-11-27 16:19:20','2022-12-04 10:47:18'),(38,9,'Battle Eye','Enable BattleEye\r\n\r\n0 to disable\r\n1 to enable\r\n\r\ndefault=\"1\"','BATTLE_EYE','1',1,1,'required|boolean','2022-11-27 16:19:20','2022-12-04 10:47:18'),(39,9,'App ID','ARK steam app id for auto updates. Leave blank to avoid auto update.','SRCDS_APPID','376030',1,0,'nullable|numeric','2022-11-27 16:19:20','2022-12-04 10:47:18'),(40,9,'Additional Arguments','Specify additional launch parameters such as -crossplay. You must include a dash - and separate each parameter with space: -crossplay -exclusivejoin','ARGS','',1,1,'nullable|string','2022-11-27 16:19:20','2022-12-04 10:47:18'),(41,10,'Map','The default map for the server.','SRCDS_MAP','de_dust2',1,1,'required|string|alpha_dash','2022-11-27 16:19:20','2022-12-04 10:47:18'),(42,10,'Steam Account Token','The Steam Account Token required for the server to be displayed publicly.','STEAM_ACC','',1,1,'required|string|alpha_num|size:32','2022-11-27 16:19:20','2022-12-04 10:47:18'),(43,10,'Source AppID','Required for game to update on server restart. Do not modify this.','SRCDS_APPID','740',0,0,'required|string|max:20','2022-11-27 16:19:20','2022-12-04 10:47:18'),(44,11,'Game ID','The ID corresponding to the game to download and run using SRCDS.','SRCDS_APPID','232250',1,0,'required|regex:/^(232250)$/','2022-11-27 16:19:20','2022-12-04 10:47:18'),(45,11,'Default Map','The default map to use when starting the server.','SRCDS_MAP','cp_dustbowl',1,1,'required|regex:/^(\\w{1,20})$/','2022-11-27 16:19:20','2022-12-04 10:47:18'),(46,11,'Steam','The Steam Game Server Login Token to display servers publicly. Generate one at https://steamcommunity.com/dev/managegameservers','STEAM_ACC','',1,1,'required|string|alpha_num|size:32','2022-11-27 16:19:20','2022-12-04 10:47:18'),(47,12,'Maximum Users','Maximum concurrent users on the mumble server.','MAX_USERS','100',1,0,'required|numeric|digits_between:1,5','2022-11-27 16:19:20','2022-12-04 10:47:18'),(48,12,'Server Version','Version of Mumble Server to download and use.','MUMBLE_VERSION','latest',1,1,'required|string','2022-11-27 16:19:20','2022-12-04 10:47:18'),(49,13,'Server Version','The version of Teamspeak 3 to use when running the server.','TS_VERSION','latest',1,1,'required|string|max:6','2022-11-27 16:19:20','2022-12-04 10:47:18'),(50,13,'File Transfer Port','The Teamspeak file transfer port','FILE_TRANSFER','30033',1,0,'required|integer|between:1,65535','2022-11-27 16:19:20','2022-12-04 10:47:18'),(51,13,'Query Port','The Teamspeak Query Port','QUERY_PORT','10011',1,0,'required|integer|between:1,65535','2022-11-27 16:19:20','2022-12-04 10:47:18'),(52,14,'Server Name','The name of your server in the public server list.','HOSTNAME','A Rust Server',1,1,'required|string|max:60','2022-11-27 16:19:20','2022-12-04 10:47:18'),(53,14,'OxideMod','Set whether you want the server to use and auto update OxideMod or not. Valid options are \"1\" for true and \"0\" for false.','OXIDE','0',1,1,'required|boolean','2022-11-27 16:19:20','2022-12-04 10:47:18'),(54,14,'Level','The world file for Rust to use.','LEVEL','Procedural Map',1,1,'required|string|max:20','2022-11-27 16:19:20','2022-12-04 10:47:18'),(55,14,'Description','The description under your server title. Commonly used for rules & info. Use \\n for newlines.','DESCRIPTION','Powered by Pterodactyl',1,1,'required|string','2022-11-27 16:19:20','2022-12-04 10:47:18'),(56,14,'URL','The URL for your server. This is what comes up when clicking the \"Visit Website\" button.','SERVER_URL','http://pterodactyl.io',1,1,'nullable|url','2022-11-27 16:19:20','2022-12-04 10:47:18'),(57,14,'World Size','The world size for a procedural map.','WORLD_SIZE','3000',1,1,'required|integer','2022-11-27 16:19:20','2022-12-04 10:47:18'),(58,14,'World Seed','The seed for a procedural map.','WORLD_SEED','',1,1,'nullable|string','2022-11-27 16:19:20','2022-12-04 10:47:18'),(59,14,'Max Players','The maximum amount of players allowed in the server at once.','MAX_PLAYERS','40',1,1,'required|integer','2022-11-27 16:19:20','2022-12-04 10:47:18'),(60,14,'Server Image','The header image for the top of your server listing.','SERVER_IMG','',1,1,'nullable|url','2022-11-27 16:19:20','2022-12-04 10:47:18'),(61,14,'RCON Port','Port for RCON connections.','RCON_PORT','28016',1,0,'required|integer','2022-11-27 16:19:20','2022-12-04 10:47:18'),(62,14,'RCON Password','RCON access password.','RCON_PASS','CHANGEME',1,1,'required|regex:/^[\\w.-]*$/|max:64','2022-11-27 16:19:20','2022-12-04 10:47:18'),(63,14,'Save Interval','Sets the server’s auto-save interval in seconds.','SAVEINTERVAL','60',1,1,'required|integer','2022-11-27 16:19:20','2022-12-04 10:47:18'),(64,14,'Additional Arguments','Add additional startup parameters to the server.','ADDITIONAL_ARGS','',1,1,'nullable|string','2022-11-27 16:19:20','2022-12-04 10:47:18'),(65,14,'App Port','Port for the Rust+ App. -1 to disable.','APP_PORT','28082',1,0,'required|integer','2022-11-27 16:19:20','2022-12-04 10:47:18'),(66,14,'Server Logo','The circular server logo for the Rust+ app.','SERVER_LOGO','',1,1,'nullable|url','2022-11-27 16:19:20','2022-12-04 10:47:18'),(67,14,'Custom Map URL','Overwrites the map with the one from the direct download URL. Invalid URLs will cause the server to crash.','MAP_URL','',1,1,'nullable|url','2022-11-27 16:19:20','2022-12-04 10:47:18');
/*!40000 ALTER TABLE `egg_variables` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `eggs`
--

DROP TABLE IF EXISTS `eggs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `eggs` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `uuid` char(36) NOT NULL,
  `nest_id` int(10) unsigned NOT NULL,
  `author` varchar(191) NOT NULL,
  `name` varchar(191) NOT NULL,
  `description` text DEFAULT NULL,
  `features` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL CHECK (json_valid(`features`)),
  `docker_images` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL CHECK (json_valid(`docker_images`)),
  `file_denylist` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL CHECK (json_valid(`file_denylist`)),
  `update_url` text DEFAULT NULL,
  `config_files` text DEFAULT NULL,
  `config_startup` text DEFAULT NULL,
  `config_logs` text DEFAULT NULL,
  `config_stop` varchar(191) DEFAULT NULL,
  `config_from` int(10) unsigned DEFAULT NULL,
  `startup` text DEFAULT NULL,
  `script_container` varchar(191) NOT NULL DEFAULT 'alpine:3.4',
  `copy_script_from` int(10) unsigned DEFAULT NULL,
  `script_entry` varchar(191) NOT NULL DEFAULT 'ash',
  `script_is_privileged` tinyint(1) NOT NULL DEFAULT 1,
  `script_install` text DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `force_outgoing_ip` tinyint(1) NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`),
  UNIQUE KEY `service_options_uuid_unique` (`uuid`),
  KEY `service_options_nest_id_foreign` (`nest_id`),
  KEY `eggs_config_from_foreign` (`config_from`),
  KEY `eggs_copy_script_from_foreign` (`copy_script_from`),
  CONSTRAINT `eggs_config_from_foreign` FOREIGN KEY (`config_from`) REFERENCES `eggs` (`id`) ON DELETE SET NULL,
  CONSTRAINT `eggs_copy_script_from_foreign` FOREIGN KEY (`copy_script_from`) REFERENCES `eggs` (`id`) ON DELETE SET NULL,
  CONSTRAINT `service_options_nest_id_foreign` FOREIGN KEY (`nest_id`) REFERENCES `nests` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `eggs`
--

LOCK TABLES `eggs` WRITE;
/*!40000 ALTER TABLE `eggs` DISABLE KEYS */;
INSERT INTO `eggs` VALUES (1,'05daae03-e866-4079-bfe5-a960346d7e75',1,'support@pterodactyl.io','Bungeecord','For a long time, Minecraft server owners have had a dream that encompasses a free, easy, and reliable way to connect multiple Minecraft servers together. BungeeCord is the answer to said dream. Whether you are a small server wishing to string multiple game-modes together, or the owner of the ShotBow Network, BungeeCord is the ideal solution for you. With the help of BungeeCord, you will be able to unlock your community\'s full potential.','[\"eula\",\"java_version\",\"pid_limit\"]','{\"Java 17\":\"ghcr.io\\/pterodactyl\\/yolks:java_17\",\"Java 16\":\"ghcr.io\\/pterodactyl\\/yolks:java_16\",\"Java 11\":\"ghcr.io\\/pterodactyl\\/yolks:java_11\",\"Java 8\":\"ghcr.io\\/pterodactyl\\/yolks:java_8\"}','[]',NULL,'{\r\n    \"config.yml\": {\r\n        \"parser\": \"yaml\",\r\n        \"find\": {\r\n            \"listeners[0].query_port\": \"{{server.build.default.port}}\",\r\n            \"listeners[0].host\": \"0.0.0.0:{{server.build.default.port}}\",\r\n            \"servers.*.address\": {\r\n                \"regex:^(127\\\\.0\\\\.0\\\\.1|localhost)(:\\\\d{1,5})?$\": \"{{config.docker.interface}}$2\"\r\n            }\r\n        }\r\n    }\r\n}','{\r\n    \"done\": \"Listening on \"\r\n}','{}','end',NULL,'java -Xms128M -XX:MaxRAMPercentage=95.0 -jar {{SERVER_JARFILE}}','ghcr.io/pterodactyl/installers:alpine',NULL,'ash',1,'#!/bin/ash\r\n# Bungeecord Installation Script\r\n#\r\n# Server Files: /mnt/server\r\n\r\ncd /mnt/server\r\n\r\nif [ -z \"${BUNGEE_VERSION}\" ] || [ \"${BUNGEE_VERSION}\" == \"latest\" ]; then\r\n    BUNGEE_VERSION=\"lastStableBuild\"\r\nfi\r\n\r\ncurl -o ${SERVER_JARFILE} https://ci.md-5.net/job/BungeeCord/${BUNGEE_VERSION}/artifact/bootstrap/target/BungeeCord.jar','2022-11-27 16:19:20','2022-11-27 16:19:20',0),(2,'a993e17c-00fa-49f6-b94d-be9e1d65fd44',1,'support@pterodactyl.io','Vanilla Minecraft','Minecraft is a game about placing blocks and going on adventures. Explore randomly generated worlds and build amazing things from the simplest of homes to the grandest of castles. Play in Creative Mode with unlimited resources or mine deep in Survival Mode, crafting weapons and armor to fend off dangerous mobs. Do all this alone or with friends.','[\"eula\",\"java_version\",\"pid_limit\"]','{\"Java 17\":\"ghcr.io\\/pterodactyl\\/yolks:java_17\",\"Java 16\":\"ghcr.io\\/pterodactyl\\/yolks:java_16\",\"Java 11\":\"ghcr.io\\/pterodactyl\\/yolks:java_11\",\"Java 8\":\"ghcr.io\\/pterodactyl\\/yolks:java_8\"}','[]',NULL,'{\r\n    \"server.properties\": {\r\n        \"parser\": \"properties\",\r\n        \"find\": {\r\n            \"server-ip\": \"0.0.0.0\",\r\n            \"server-port\": \"{{server.build.default.port}}\",\r\n            \"query.port\": \"{{server.build.default.port}}\"\r\n        }\r\n    }\r\n}','{\r\n    \"done\": \")! For help, type \"\r\n}','{}','stop',NULL,'java -Xms128M -XX:MaxRAMPercentage=95.0 -jar {{SERVER_JARFILE}}','ghcr.io/pterodactyl/installers:alpine',NULL,'ash',1,'#!/bin/ash\r\n# Vanilla MC Installation Script\r\n#\r\n# Server Files: /mnt/server\r\nmkdir -p /mnt/server\r\ncd /mnt/server\r\n\r\nLATEST_VERSION=`curl https://launchermeta.mojang.com/mc/game/version_manifest.json | jq -r \'.latest.release\'`\r\nLATEST_SNAPSHOT_VERSION=`curl https://launchermeta.mojang.com/mc/game/version_manifest.json | jq -r \'.latest.snapshot\'`\r\n\r\necho -e \"latest version is $LATEST_VERSION\"\r\necho -e \"latest snapshot is $LATEST_SNAPSHOT_VERSION\"\r\n\r\nif [ -z \"$VANILLA_VERSION\" ] || [ \"$VANILLA_VERSION\" == \"latest\" ]; then\r\n  MANIFEST_URL=$(curl -sSL https://launchermeta.mojang.com/mc/game/version_manifest.json | jq --arg VERSION $LATEST_VERSION -r \'.versions | .[] | select(.id== $VERSION )|.url\')\r\nelif [ \"$VANILLA_VERSION\" == \"snapshot\" ]; then\r\n  MANIFEST_URL=$(curl -sSL https://launchermeta.mojang.com/mc/game/version_manifest.json | jq --arg VERSION $LATEST_SNAPSHOT_VERSION -r \'.versions | .[] | select(.id== $VERSION )|.url\')\r\nelse\r\n  MANIFEST_URL=$(curl -sSL https://launchermeta.mojang.com/mc/game/version_manifest.json | jq --arg VERSION $VANILLA_VERSION -r \'.versions | .[] | select(.id== $VERSION )|.url\')\r\nfi\r\n\r\nDOWNLOAD_URL=$(curl ${MANIFEST_URL} | jq .downloads.server | jq -r \'. | .url\')\r\n\r\necho -e \"running: curl -o ${SERVER_JARFILE} $DOWNLOAD_URL\"\r\ncurl -o ${SERVER_JARFILE} $DOWNLOAD_URL\r\n\r\necho -e \"Install Complete\"','2022-11-27 16:19:20','2022-11-27 16:19:20',0),(3,'e38b0fb1-e2c8-48bb-a9b9-fcb17e11b82b',1,'parker@pterodactyl.io','Paper','High performance Spigot fork that aims to fix gameplay and mechanics inconsistencies.','[\"eula\",\"java_version\",\"pid_limit\"]','{\"Java 17\":\"ghcr.io\\/pterodactyl\\/yolks:java_17\",\"Java 16\":\"ghcr.io\\/pterodactyl\\/yolks:java_16\",\"Java 11\":\"ghcr.io\\/pterodactyl\\/yolks:java_11\",\"Java 8\":\"ghcr.io\\/pterodactyl\\/yolks:java_8\"}','[]',NULL,'{\r\n    \"server.properties\": {\r\n        \"parser\": \"properties\",\r\n        \"find\": {\r\n            \"server-ip\": \"0.0.0.0\",\r\n            \"server-port\": \"{{server.build.default.port}}\",\r\n            \"query.port\": \"{{server.build.default.port}}\"\r\n        }\r\n    }\r\n}','{\r\n    \"done\": \")! For help, type \"\r\n}','{}','stop',NULL,'java -Xms128M -XX:MaxRAMPercentage=95.0 -Dterminal.jline=false -Dterminal.ansi=true -jar {{SERVER_JARFILE}}','ghcr.io/pterodactyl/installers:alpine',NULL,'ash',1,'#!/bin/ash\r\n# Paper Installation Script\r\n#\r\n# Server Files: /mnt/server\r\nPROJECT=paper\r\n\r\nif [ -n \"${DL_PATH}\" ]; then\r\n	echo -e \"Using supplied download url: ${DL_PATH}\"\r\n	DOWNLOAD_URL=`eval echo $(echo ${DL_PATH} | sed -e \'s/{{/${/g\' -e \'s/}}/}/g\')`\r\nelse\r\n	VER_EXISTS=`curl -s https://api.papermc.io/v2/projects/${PROJECT} | jq -r --arg VERSION $MINECRAFT_VERSION \'.versions[] | contains($VERSION)\' | grep -m1 true`\r\n	LATEST_VERSION=`curl -s https://api.papermc.io/v2/projects/${PROJECT} | jq -r \'.versions\' | jq -r \'.[-1]\'`\r\n\r\n	if [ \"${VER_EXISTS}\" == \"true\" ]; then\r\n		echo -e \"Version is valid. Using version ${MINECRAFT_VERSION}\"\r\n	else\r\n		echo -e \"Specified version not found. Defaulting to the latest ${PROJECT} version\"\r\n		MINECRAFT_VERSION=${LATEST_VERSION}\r\n	fi\r\n\r\n	BUILD_EXISTS=`curl -s https://api.papermc.io/v2/projects/${PROJECT}/versions/${MINECRAFT_VERSION} | jq -r --arg BUILD ${BUILD_NUMBER} \'.builds[] | tostring | contains($BUILD)\' | grep -m1 true`\r\n	LATEST_BUILD=`curl -s https://api.papermc.io/v2/projects/${PROJECT}/versions/${MINECRAFT_VERSION} | jq -r \'.builds\' | jq -r \'.[-1]\'`\r\n\r\n	if [ \"${BUILD_EXISTS}\" == \"true\" ]; then\r\n		echo -e \"Build is valid for version ${MINECRAFT_VERSION}. Using build ${BUILD_NUMBER}\"\r\n	else\r\n		echo -e \"Using the latest ${PROJECT} build for version ${MINECRAFT_VERSION}\"\r\n		BUILD_NUMBER=${LATEST_BUILD}\r\n	fi\r\n\r\n	JAR_NAME=${PROJECT}-${MINECRAFT_VERSION}-${BUILD_NUMBER}.jar\r\n\r\n	echo \"Version being downloaded\"\r\n	echo -e \"MC Version: ${MINECRAFT_VERSION}\"\r\n	echo -e \"Build: ${BUILD_NUMBER}\"\r\n	echo -e \"JAR Name of Build: ${JAR_NAME}\"\r\n	DOWNLOAD_URL=https://api.papermc.io/v2/projects/${PROJECT}/versions/${MINECRAFT_VERSION}/builds/${BUILD_NUMBER}/downloads/${JAR_NAME}\r\nfi\r\n\r\ncd /mnt/server\r\n\r\necho -e \"Running curl -o ${SERVER_JARFILE} ${DOWNLOAD_URL}\"\r\n\r\nif [ -f ${SERVER_JARFILE} ]; then\r\n	mv ${SERVER_JARFILE} ${SERVER_JARFILE}.old\r\nfi\r\n\r\ncurl -o ${SERVER_JARFILE} ${DOWNLOAD_URL}\r\n\r\nif [ ! -f server.properties ]; then\r\n    echo -e \"Downloading MC server.properties\"\r\n    curl -o server.properties https://raw.githubusercontent.com/parkervcp/eggs/master/minecraft/java/server.properties\r\nfi','2022-11-27 16:19:20','2022-11-27 16:19:20',0),(4,'f37f481a-328c-4dac-aed6-607332ac6b09',1,'support@pterodactyl.io','Forge Minecraft','Minecraft Forge Server. Minecraft Forge is a modding API (Application Programming Interface), which makes it easier to create mods, and also make sure mods are compatible with each other.','[\"eula\",\"java_version\",\"pid_limit\"]','{\"Java 17\":\"ghcr.io\\/pterodactyl\\/yolks:java_17\",\"Java 16\":\"ghcr.io\\/pterodactyl\\/yolks:java_16\",\"Java 11\":\"ghcr.io\\/pterodactyl\\/yolks:java_11\",\"Java 8\":\"ghcr.io\\/pterodactyl\\/yolks:java_8\"}','[]',NULL,'{\r\n    \"server.properties\": {\r\n        \"parser\": \"properties\",\r\n        \"find\": {\r\n            \"server-ip\": \"0.0.0.0\",\r\n            \"server-port\": \"{{server.build.default.port}}\",\r\n            \"query.port\": \"{{server.build.default.port}}\"\r\n        }\r\n    }\r\n}','{\r\n    \"done\": \")! For help, type \"\r\n}','{}','stop',NULL,'java -Xms128M -XX:MaxRAMPercentage=95.0 -Dterminal.jline=false -Dterminal.ansi=true $( [[  ! -f unix_args.txt ]] && printf %s \"-jar {{SERVER_JARFILE}}\" || printf %s \"@unix_args.txt\" )','openjdk:8-jdk-slim',NULL,'bash',1,'#!/bin/bash\r\n# Forge Installation Script\r\n#\r\n# Server Files: /mnt/server\r\napt update\r\napt install -y curl jq\r\n\r\nif [[ ! -d /mnt/server ]]; then\r\n  mkdir /mnt/server\r\nfi\r\n\r\ncd /mnt/server\r\n\r\n# Remove spaces from the version number to avoid issues with curl\r\nFORGE_VERSION=\"$(echo \"$FORGE_VERSION\" | tr -d \' \')\"\r\nMC_VERSION=\"$(echo \"$MC_VERSION\" | tr -d \' \')\"\r\n\r\nif [[ ! -z ${FORGE_VERSION} ]]; then\r\n  DOWNLOAD_LINK=https://maven.minecraftforge.net/net/minecraftforge/forge/${FORGE_VERSION}/forge-${FORGE_VERSION}\r\n  FORGE_JAR=forge-${FORGE_VERSION}*.jar\r\nelse\r\n  JSON_DATA=$(curl -sSL https://files.minecraftforge.net/maven/net/minecraftforge/forge/promotions_slim.json)\r\n\r\n  if [[ \"${MC_VERSION}\" == \"latest\" ]] || [[ \"${MC_VERSION}\" == \"\" ]]; then\r\n    echo -e \"getting latest version of forge.\"\r\n    MC_VERSION=$(echo -e ${JSON_DATA} | jq -r \'.promos | del(.\"latest-1.7.10\") | del(.\"1.7.10-latest-1.7.10\") | to_entries[] | .key | select(contains(\"latest\")) | split(\"-\")[0]\' | sort -t. -k 1,1n -k 2,2n -k 3,3n -k 4,4n | tail -1)\r\n    BUILD_TYPE=latest\r\n  fi\r\n\r\n  if [[ \"${BUILD_TYPE}\" != \"recommended\" ]] && [[ \"${BUILD_TYPE}\" != \"latest\" ]]; then\r\n    BUILD_TYPE=recommended\r\n  fi\r\n\r\n  echo -e \"minecraft version: ${MC_VERSION}\"\r\n  echo -e \"build type: ${BUILD_TYPE}\"\r\n\r\n  ## some variables for getting versions and things\r\n  FILE_SITE=https://maven.minecraftforge.net/net/minecraftforge/forge/\r\n  VERSION_KEY=$(echo -e ${JSON_DATA} | jq -r --arg MC_VERSION \"${MC_VERSION}\" --arg BUILD_TYPE \"${BUILD_TYPE}\" \'.promos | del(.\"latest-1.7.10\") | del(.\"1.7.10-latest-1.7.10\") | to_entries[] | .key | select(contains($MC_VERSION)) | select(contains($BUILD_TYPE))\')\r\n\r\n  ## locating the forge version\r\n  if [[ \"${VERSION_KEY}\" == \"\" ]] && [[ \"${BUILD_TYPE}\" == \"recommended\" ]]; then\r\n    echo -e \"dropping back to latest from recommended due to there not being a recommended version of forge for the mc version requested.\"\r\n    VERSION_KEY=$(echo -e ${JSON_DATA} | jq -r --arg MC_VERSION \"${MC_VERSION}\" \'.promos | del(.\"latest-1.7.10\") | del(.\"1.7.10-latest-1.7.10\") | to_entries[] | .key | select(contains($MC_VERSION)) | select(contains(\"latest\"))\')\r\n  fi\r\n\r\n  ## Error if the mc version set wasn\'t valid.\r\n  if [ \"${VERSION_KEY}\" == \"\" ] || [ \"${VERSION_KEY}\" == \"null\" ]; then\r\n    echo -e \"The install failed because there is no valid version of forge for the version of minecraft selected.\"\r\n    exit 1\r\n  fi\r\n\r\n  FORGE_VERSION=$(echo -e ${JSON_DATA} | jq -r --arg VERSION_KEY \"$VERSION_KEY\" \'.promos | .[$VERSION_KEY]\')\r\n\r\n  if [[ \"${MC_VERSION}\" == \"1.7.10\" ]] || [[ \"${MC_VERSION}\" == \"1.8.9\" ]]; then\r\n    DOWNLOAD_LINK=${FILE_SITE}${MC_VERSION}-${FORGE_VERSION}-${MC_VERSION}/forge-${MC_VERSION}-${FORGE_VERSION}-${MC_VERSION}\r\n    FORGE_JAR=forge-${MC_VERSION}-${FORGE_VERSION}-${MC_VERSION}.jar\r\n    if [[ \"${MC_VERSION}\" == \"1.7.10\" ]]; then\r\n      FORGE_JAR=forge-${MC_VERSION}-${FORGE_VERSION}-${MC_VERSION}-universal.jar\r\n    fi\r\n  else\r\n    DOWNLOAD_LINK=${FILE_SITE}${MC_VERSION}-${FORGE_VERSION}/forge-${MC_VERSION}-${FORGE_VERSION}\r\n    FORGE_JAR=forge-${MC_VERSION}-${FORGE_VERSION}.jar\r\n  fi\r\nfi\r\n\r\n#Adding .jar when not eding by SERVER_JARFILE\r\nif [[ ! $SERVER_JARFILE = *\\.jar ]]; then\r\n  SERVER_JARFILE=\"$SERVER_JARFILE.jar\"\r\nfi\r\n\r\n#Downloading jars\r\necho -e \"Downloading forge version ${FORGE_VERSION}\"\r\necho -e \"Download link is ${DOWNLOAD_LINK}\"\r\n\r\nif [[ ! -z \"${DOWNLOAD_LINK}\" ]]; then\r\n  if curl --output /dev/null --silent --head --fail ${DOWNLOAD_LINK}-installer.jar; then\r\n    echo -e \"installer jar download link is valid.\"\r\n  else\r\n    echo -e \"link is invalid. Exiting now\"\r\n    exit 2\r\n  fi\r\nelse\r\n  echo -e \"no download link provided. Exiting now\"\r\n  exit 3\r\nfi\r\n\r\ncurl -s -o installer.jar -sS ${DOWNLOAD_LINK}-installer.jar\r\n\r\n#Checking if downloaded jars exist\r\nif [[ ! -f ./installer.jar ]]; then\r\n  echo \"!!! Error downloading forge version ${FORGE_VERSION} !!!\"\r\n  exit\r\nfi\r\n\r\nfunction  unix_args {\r\n  echo -e \"Detected Forge 1.17 or newer version. Setting up forge unix args.\"\r\n  ln -sf libraries/net/minecraftforge/forge/*/unix_args.txt unix_args.txt\r\n}\r\n\r\n# Delete args to support downgrading/upgrading\r\nrm -rf libraries/net/minecraftforge/forge\r\nrm unix_args.txt\r\n\r\n#Installing server\r\necho -e \"Installing forge server.\\n\"\r\njava -jar installer.jar --installServer || { echo -e \"\\nInstall failed using Forge version ${FORGE_VERSION} and Minecraft version ${MINECRAFT_VERSION}.\\nShould you be using unlimited memory value of 0, make sure to increase the default install resource limits in the Wings config or specify exact allocated memory in the server Build Configuration instead of 0! \\nOtherwise, the Forge installer will not have enough memory.\"; exit 4; }\r\n\r\n# Check if we need a symlink for 1.17+ Forge JPMS args\r\nif [[ $MC_VERSION =~ ^1\\.(17|18|19|20|21|22|23) || $FORGE_VERSION =~ ^1\\.(17|18|19|20|21|22|23) ]]; then\r\n  unix_args\r\n\r\n# Check if someone has set MC to latest but overwrote it with older Forge version, otherwise we would have false positives\r\nelif [[ $MC_VERSION == \"latest\" && $FORGE_VERSION =~ ^1\\.(17|18|19|20|21|22|23) ]]; then\r\n  unix_args\r\nelse\r\n  # For versions below 1.17 that ship with jar\r\n  mv $FORGE_JAR $SERVER_JARFILE\r\nfi\r\n\r\necho -e \"Deleting installer.jar file.\\n\"\r\nrm -rf installer.jar\r\necho -e \"Installation process is completed\"','2022-11-27 16:19:20','2022-11-27 16:19:20',0),(5,'7ef9ecae-4ff3-4f3d-b16a-3eafb79f228b',1,'support@pterodactyl.io','Sponge (SpongeVanilla)','SpongeVanilla is the SpongeAPI implementation for Vanilla Minecraft.','[\"eula\",\"java_version\",\"pid_limit\"]','{\"Java 16\":\"ghcr.io\\/pterodactyl\\/yolks:java_16\",\"Java 11\":\"ghcr.io\\/pterodactyl\\/yolks:java_11\",\"Java 8\":\"ghcr.io\\/pterodactyl\\/yolks:java_8\"}','[]',NULL,'{\r\n    \"server.properties\": {\r\n        \"parser\": \"properties\",\r\n        \"find\": {\r\n            \"server-ip\": \"0.0.0.0\",\r\n            \"server-port\": \"{{server.build.default.port}}\",\r\n            \"query.port\": \"{{server.build.default.port}}\"\r\n        }\r\n    }\r\n}','{\r\n    \"done\": \")! For help, type \"\r\n}','{}','stop',NULL,'java -Xms128M -XX:MaxRAMPercentage=95.0 -jar {{SERVER_JARFILE}}','ghcr.io/pterodactyl/installers:alpine',NULL,'ash',1,'#!/bin/ash\r\n# Sponge Installation Script\r\n#\r\n# Server Files: /mnt/server\r\n\r\ncd /mnt/server\r\n\r\ncurl -sSL \"https://repo.spongepowered.org/maven/org/spongepowered/spongevanilla/${SPONGE_VERSION}/spongevanilla-${SPONGE_VERSION}.jar\" -o ${SERVER_JARFILE}','2022-11-27 16:19:20','2022-11-27 16:19:20',0),(6,'767883d2-a01c-4ca4-b161-2bd428732195',2,'support@pterodactyl.io','Garrys Mod','Garrys Mod, is a sandbox physics game created by Garry Newman, and developed by his company, Facepunch Studios.','[\"gsl_token\",\"steam_disk_space\"]','{\"ghcr.io\\/pterodactyl\\/games:source\":\"ghcr.io\\/pterodactyl\\/games:source\"}','[]',NULL,'{}','{\r\n    \"done\": \"gameserver Steam ID\"\r\n}','{}','quit',NULL,'./srcds_run -game garrysmod -console -port {{SERVER_PORT}} +ip 0.0.0.0 +host_workshop_collection {{WORKSHOP_ID}} +map {{SRCDS_MAP}} +gamemode {{GAMEMODE}} -strictportbind -norestart +sv_setsteamaccount {{STEAM_ACC}} +maxplayers {{MAX_PLAYERS}}  -tickrate {{TICKRATE}}  $( [ \"$LUA_REFRESH\" == \"1\" ] || printf %s \'-disableluarefresh\' )','ghcr.io/pterodactyl/installers:debian',NULL,'bash',1,'#!/bin/bash\r\n# steamcmd Base Installation Script\r\n#\r\n# Server Files: /mnt/server\r\n\r\n## just in case someone removed the defaults.\r\nif [ \"${STEAM_USER}\" == \"\" ]; then\r\n    echo -e \"steam user is not set.\\n\"\r\n    echo -e \"Using anonymous user.\\n\"\r\n    STEAM_USER=anonymous\r\n    STEAM_PASS=\"\"\r\n    STEAM_AUTH=\"\"\r\nelse\r\n    echo -e \"user set to ${STEAM_USER}\"\r\nfi\r\n\r\n## download and install steamcmd\r\ncd /tmp\r\nmkdir -p /mnt/server/steamcmd\r\ncurl -sSL -o steamcmd.tar.gz https://steamcdn-a.akamaihd.net/client/installer/steamcmd_linux.tar.gz\r\ntar -xzvf steamcmd.tar.gz -C /mnt/server/steamcmd\r\nmkdir -p /mnt/server/steamapps # Fix steamcmd disk write error when this folder is missing\r\ncd /mnt/server/steamcmd\r\n\r\n# SteamCMD fails otherwise for some reason, even running as root.\r\n# This is changed at the end of the install process anyways.\r\nchown -R root:root /mnt\r\nexport HOME=/mnt/server\r\n\r\n## install game using steamcmd\r\n./steamcmd.sh +force_install_dir /mnt/server +login ${STEAM_USER} ${STEAM_PASS} ${STEAM_AUTH} $( [[ \"${WINDOWS_INSTALL}\" == \"1\" ]] && printf %s \'+@sSteamCmdForcePlatformType windows\' ) +app_update ${SRCDS_APPID} ${EXTRA_FLAGS} validate +quit ## other flags may be needed depending on install. looking at you cs 1.6\r\n\r\n## set up 32 bit libraries\r\nmkdir -p /mnt/server/.steam/sdk32\r\ncp -v linux32/steamclient.so ../.steam/sdk32/steamclient.so\r\n\r\n## set up 64 bit libraries\r\nmkdir -p /mnt/server/.steam/sdk64\r\ncp -v linux64/steamclient.so ../.steam/sdk64/steamclient.so\r\n\r\n# Creating needed default files for the game\r\ncd /mnt/server/garrysmod/lua/autorun/server\r\necho \'\r\n-- Docs: https://wiki.garrysmod.com/page/resource/AddWorkshop\r\n-- Place the ID of the workshop addon you want to be downloaded to people who join your server, not the collection ID\r\n-- Use https://beta.configcreator.com/create/gmod/resources.lua to easily create a list based on your collection ID\r\n\r\nresource.AddWorkshop( \"\" )\r\n\' > workshop.lua\r\n\r\ncd /mnt/server/garrysmod/cfg\r\necho \'\r\n// Please do not set RCon in here, use the startup parameters.\r\n\r\nhostname		\"New Gmod Server\"\r\nsv_password		\"\"\r\nsv_loadingurl   \"\"\r\nsv_downloadurl  \"\"\r\n\r\n// Steam Server List Settings\r\n// sv_location \"eu\"\r\nsv_region \"255\"\r\nsv_lan \"0\"\r\nsv_max_queries_sec_global \"30000\"\r\nsv_max_queries_window \"45\"\r\nsv_max_queries_sec \"5\"\r\n\r\n// Server Limits\r\nsbox_maxprops		100\r\nsbox_maxragdolls	5\r\nsbox_maxnpcs		10\r\nsbox_maxballoons	10\r\nsbox_maxeffects		10\r\nsbox_maxdynamite	10\r\nsbox_maxlamps		10\r\nsbox_maxthrusters	10\r\nsbox_maxwheels		10\r\nsbox_maxhoverballs	10\r\nsbox_maxvehicles	20\r\nsbox_maxbuttons		10\r\nsbox_maxsents		20\r\nsbox_maxemitters	5\r\nsbox_godmode		0\r\nsbox_noclip		    0\r\n\r\n// Network Settings - Please keep these set to default.\r\n\r\nsv_minrate		75000\r\nsv_maxrate		0\r\ngmod_physiterations	2\r\nnet_splitpacket_maxrate	45000\r\ndecalfrequency		12 \r\n\r\n// Execute Ban Files - Please do not edit\r\nexec banned_ip.cfg \r\nexec banned_user.cfg \r\n\r\n// Add custom lines under here\r\n\' > server.cfg','2022-11-27 16:19:20','2022-11-27 16:19:20',0),(7,'cb06db8a-25e8-4436-b2fc-103fe26af294',2,'support@pterodactyl.io','Custom Source Engine Game','This option allows modifying the startup arguments and other details to run a custom SRCDS based game on the panel.','[\"steam_disk_space\"]','{\"ghcr.io\\/pterodactyl\\/games:source\":\"ghcr.io\\/pterodactyl\\/games:source\"}','[]',NULL,'{}','{\r\n    \"done\": \"gameserver Steam ID\"\r\n}','{}','quit',NULL,'./srcds_run -game {{SRCDS_GAME}} -console -port {{SERVER_PORT}} +map {{SRCDS_MAP}} +ip 0.0.0.0 -strictportbind -norestart','ghcr.io/pterodactyl/installers:debian',NULL,'bash',1,'#!/bin/bash\r\n# steamcmd Base Installation Script\r\n#\r\n# Server Files: /mnt/server\r\n\r\n##\r\n#\r\n# Variables\r\n# STEAM_USER, STEAM_PASS, STEAM_AUTH - Steam user setup. If a user has 2fa enabled it will most likely fail due to timeout. Leave blank for anon install.\r\n# WINDOWS_INSTALL - if it\'s a windows server you want to install set to 1\r\n# SRCDS_APPID - steam app id ffound here - https://developer.valvesoftware.com/wiki/Dedicated_Servers_List\r\n# EXTRA_FLAGS - when a server has extra glas for things like beta installs or updates.\r\n#\r\n##\r\n\r\n\r\n## just in case someone removed the defaults.\r\nif [ \"${STEAM_USER}\" == \"\" ]; then\r\n    echo -e \"steam user is not set.\\n\"\r\n    echo -e \"Using anonymous user.\\n\"\r\n    STEAM_USER=anonymous\r\n    STEAM_PASS=\"\"\r\n    STEAM_AUTH=\"\"\r\nelse\r\n    echo -e \"user set to ${STEAM_USER}\"\r\nfi\r\n\r\n## download and install steamcmd\r\ncd /tmp\r\nmkdir -p /mnt/server/steamcmd\r\ncurl -sSL -o steamcmd.tar.gz https://steamcdn-a.akamaihd.net/client/installer/steamcmd_linux.tar.gz\r\ntar -xzvf steamcmd.tar.gz -C /mnt/server/steamcmd\r\nmkdir -p /mnt/server/steamapps # Fix steamcmd disk write error when this folder is missing\r\ncd /mnt/server/steamcmd\r\n\r\n# SteamCMD fails otherwise for some reason, even running as root.\r\n# This is changed at the end of the install process anyways.\r\nchown -R root:root /mnt\r\nexport HOME=/mnt/server\r\n\r\n## install game using steamcmd\r\n./steamcmd.sh +force_install_dir /mnt/server +login ${STEAM_USER} ${STEAM_PASS} ${STEAM_AUTH} $( [[ \"${WINDOWS_INSTALL}\" == \"1\" ]] && printf %s \'+@sSteamCmdForcePlatformType windows\' ) +app_update ${SRCDS_APPID} ${EXTRA_FLAGS} validate +quit ## other flags may be needed depending on install. looking at you cs 1.6\r\n\r\n## set up 32 bit libraries\r\nmkdir -p /mnt/server/.steam/sdk32\r\ncp -v linux32/steamclient.so ../.steam/sdk32/steamclient.so\r\n\r\n## set up 64 bit libraries\r\nmkdir -p /mnt/server/.steam/sdk64\r\ncp -v linux64/steamclient.so ../.steam/sdk64/steamclient.so','2022-11-27 16:19:20','2022-11-27 16:19:20',0),(8,'60c8f3d2-996c-467c-9433-42cfe70ae8ce',2,'support@pterodactyl.io','Insurgency','Take to the streets for intense close quarters combat, where a team\'s survival depends upon securing crucial strongholds and destroying enemy supply in this multiplayer and cooperative Source Engine based experience.','[\"steam_disk_space\"]','{\"ghcr.io\\/pterodactyl\\/games:source\":\"ghcr.io\\/pterodactyl\\/games:source\"}','[]',NULL,'{}','{\r\n    \"done\": \"gameserver Steam ID\"\r\n}','{}','quit',NULL,'./srcds_run -game insurgency -console -port {{SERVER_PORT}} +map {{SRCDS_MAP}} +ip 0.0.0.0 -strictportbind -norestart','ghcr.io/pterodactyl/installers:debian',NULL,'bash',1,'#!/bin/bash\r\n# steamcmd Base Installation Script\r\n#\r\n# Server Files: /mnt/server\r\n\r\n## download and install steamcmd\r\ncd /tmp\r\nmkdir -p /mnt/server/steamcmd\r\ncurl -sSL -o steamcmd.tar.gz https://steamcdn-a.akamaihd.net/client/installer/steamcmd_linux.tar.gz\r\ntar -xzvf steamcmd.tar.gz -C /mnt/server/steamcmd\r\ncd /mnt/server/steamcmd\r\n\r\n# SteamCMD fails otherwise for some reason, even running as root.\r\n# This is changed at the end of the install process anyways.\r\nchown -R root:root /mnt\r\nexport HOME=/mnt/server\r\n\r\n## install game using steamcmd\r\n./steamcmd.sh +force_install_dir /mnt/server +login anonymous +app_update ${SRCDS_APPID} ${EXTRA_FLAGS} +quit\r\n\r\n## set up 32 bit libraries\r\nmkdir -p /mnt/server/.steam/sdk32\r\ncp -v linux32/steamclient.so ../.steam/sdk32/steamclient.so\r\n\r\n## set up 64 bit libraries\r\nmkdir -p /mnt/server/.steam/sdk64\r\ncp -v linux64/steamclient.so ../.steam/sdk64/steamclient.so','2022-11-27 16:19:20','2022-11-27 16:19:20',0),(9,'8a0bd9dd-2192-4a9d-94de-3d6ce05e7412',2,'dev@shepper.fr','Ark: Survival Evolved','As a man or woman stranded, naked, freezing, and starving on the unforgiving shores of a mysterious island called ARK, use your skill and cunning to kill or tame and ride the plethora of leviathan dinosaurs and other primeval creatures roaming the land. Hunt, harvest resources, craft items, grow crops, research technologies, and build shelters to withstand the elements and store valuables, all while teaming up with (or preying upon) hundreds of other players to survive, dominate... and escape! — Gamepedia: ARK','[\"steam_disk_space\"]','{\"quay.io\\/parkervcp\\/pterodactyl-images:debian_source\":\"quay.io\\/parkervcp\\/pterodactyl-images:debian_source\"}','[]',NULL,'{}','{\r\n    \"done\": \"Waiting commands for 127.0.0.1:\"\r\n}','{}','^C',NULL,'rmv() { echo -e \"stopping server\"; rcon -t rcon -a 127.0.0.1:${RCON_PORT} -p ${ARK_ADMIN_PASSWORD} -c saveworld && rcon -a 127.0.0.1:${RCON_PORT} -p ${ARK_ADMIN_PASSWORD} -c DoExit; }; trap rmv 15; cd ShooterGame/Binaries/Linux && ./ShooterGameServer {{SERVER_MAP}}?listen?SessionName=\"{{SESSION_NAME}}\"?ServerPassword={{ARK_PASSWORD}}?ServerAdminPassword={{ARK_ADMIN_PASSWORD}}?Port={{SERVER_PORT}}?RCONPort={{RCON_PORT}}?QueryPort={{QUERY_PORT}}?RCONEnabled=True$( [ \"$BATTLE_EYE\" == \"1\" ] || printf %s \' -NoBattlEye\' ) -server {{ARGS}} -log & until echo \"waiting for rcon connection...\"; rcon -t rcon -a 127.0.0.1:${RCON_PORT} -p ${ARK_ADMIN_PASSWORD}; do sleep 5; done','ghcr.io/pterodactyl/installers:debian',NULL,'bash',1,'#!/bin/bash\r\n# steamcmd Base Installation Script\r\n#\r\n# Server Files: /mnt/server\r\n# Image to install with is \'ubuntu:18.04\'\r\n\r\n## just in case someone removed the defaults.\r\nif [ \"${STEAM_USER}\" == \"\" ]; then\r\n    STEAM_USER=anonymous\r\n    STEAM_PASS=\"\"\r\n    STEAM_AUTH=\"\"\r\nfi\r\n\r\n## download and install steamcmd\r\ncd /tmp\r\nmkdir -p /mnt/server/steamcmd\r\ncurl -sSL -o steamcmd.tar.gz https://steamcdn-a.akamaihd.net/client/installer/steamcmd_linux.tar.gz\r\ntar -xzvf steamcmd.tar.gz -C /mnt/server/steamcmd\r\n\r\nmkdir -p /mnt/server/Engine/Binaries/ThirdParty/SteamCMD/Linux\r\ntar -xzvf steamcmd.tar.gz -C /mnt/server/Engine/Binaries/ThirdParty/SteamCMD/Linux\r\nmkdir -p /mnt/server/steamapps # Fix steamcmd disk write error when this folder is missing\r\ncd /mnt/server/steamcmd\r\n\r\n# SteamCMD fails otherwise for some reason, even running as root.\r\n# This is changed at the end of the install process anyways.\r\nchown -R root:root /mnt\r\nexport HOME=/mnt/server\r\n\r\n## install game using steamcmd\r\n./steamcmd.sh +force_install_dir /mnt/server +login ${STEAM_USER} ${STEAM_PASS} ${STEAM_AUTH} +app_update ${SRCDS_APPID} ${EXTRA_FLAGS} +quit ## other flags may be needed depending on install. looking at you cs 1.6\r\n\r\n## set up 32 bit libraries\r\nmkdir -p /mnt/server/.steam/sdk32\r\ncp -v linux32/steamclient.so ../.steam/sdk32/steamclient.so\r\n\r\n## set up 64 bit libraries\r\nmkdir -p /mnt/server/.steam/sdk64\r\ncp -v linux64/steamclient.so ../.steam/sdk64/steamclient.so\r\n\r\n## create a symbolic link for loading mods\r\ncd /mnt/server/Engine/Binaries/ThirdParty/SteamCMD/Linux\r\nln -sf ../../../../../Steam/steamapps steamapps\r\ncd /mnt/server','2022-11-27 16:19:20','2022-11-27 16:19:20',0),(10,'bd6350c6-bd39-4c68-a0b3-cab1d8e47c33',2,'support@pterodactyl.io','Counter-Strike: Global Offensive','Counter-Strike: Global Offensive is a multiplayer first-person shooter video game developed by Hidden Path Entertainment and Valve Corporation.','[\"gsl_token\",\"steam_disk_space\"]','{\"ghcr.io\\/pterodactyl\\/games:source\":\"ghcr.io\\/pterodactyl\\/games:source\"}','[]',NULL,'{}','{\r\n    \"done\": \"Connection to Steam servers successful\"\r\n}','{}','quit',NULL,'./srcds_run -game csgo -console -port {{SERVER_PORT}} +ip 0.0.0.0 +map {{SRCDS_MAP}} -strictportbind -norestart +sv_setsteamaccount {{STEAM_ACC}}','ghcr.io/pterodactyl/installers:debian',NULL,'bash',1,'#!/bin/bash\r\n# steamcmd Base Installation Script\r\n#\r\n# Server Files: /mnt/server\r\n\r\n## just in case someone removed the defaults.\r\nif [ \"${STEAM_USER}\" == \"\" ]; then\r\n    STEAM_USER=anonymous\r\n    STEAM_PASS=\"\"\r\n    STEAM_AUTH=\"\"\r\nfi\r\n\r\n## download and install steamcmd\r\ncd /tmp\r\nmkdir -p /mnt/server/steamcmd\r\ncurl -sSL -o steamcmd.tar.gz https://steamcdn-a.akamaihd.net/client/installer/steamcmd_linux.tar.gz\r\ntar -xzvf steamcmd.tar.gz -C /mnt/server/steamcmd\r\nmkdir -p /mnt/server/steamapps # Fix steamcmd disk write error when this folder is missing\r\ncd /mnt/server/steamcmd\r\n\r\n# SteamCMD fails otherwise for some reason, even running as root.\r\n# This is changed at the end of the install process anyways.\r\nchown -R root:root /mnt\r\nexport HOME=/mnt/server\r\n\r\n## install game using steamcmd\r\n./steamcmd.sh +force_install_dir /mnt/server +login ${STEAM_USER} ${STEAM_PASS} ${STEAM_AUTH} +app_update ${SRCDS_APPID} ${EXTRA_FLAGS} +quit ## other flags may be needed depending on install. looking at you cs 1.6\r\n\r\n## set up 32 bit libraries\r\nmkdir -p /mnt/server/.steam/sdk32\r\ncp -v linux32/steamclient.so ../.steam/sdk32/steamclient.so\r\n\r\n## set up 64 bit libraries\r\nmkdir -p /mnt/server/.steam/sdk64\r\ncp -v linux64/steamclient.so ../.steam/sdk64/steamclient.so','2022-11-27 16:19:20','2022-11-27 16:19:20',0),(11,'333c66c6-0866-448b-9f33-be0f017e87da',2,'support@pterodactyl.io','Team Fortress 2','Team Fortress 2 is a team-based first-person shooter multiplayer video game developed and published by Valve Corporation. It is the sequel to the 1996 mod Team Fortress for Quake and its 1999 remake.','[\"gsl_token\",\"steam_disk_space\"]','{\"ghcr.io\\/pterodactyl\\/games:source\":\"ghcr.io\\/pterodactyl\\/games:source\"}','[]',NULL,'{}','{\r\n    \"done\": \"gameserver Steam ID\"\r\n}','{}','quit',NULL,'./srcds_run -game tf -console -port {{SERVER_PORT}} +map {{SRCDS_MAP}} +ip 0.0.0.0 -strictportbind -norestart +sv_setsteamaccount {{STEAM_ACC}}','ghcr.io/pterodactyl/installers:debian',NULL,'bash',1,'#!/bin/bash\r\n# steamcmd Base Installation Script\r\n#\r\n# Server Files: /mnt/server\r\n# Image to install with is \'debian:buster-slim\'\r\n\r\n##\r\n#\r\n# Variables\r\n# STEAM_USER, STEAM_PASS, STEAM_AUTH - Steam user setup. If a user has 2fa enabled it will most likely fail due to timeout. Leave blank for anon install.\r\n# WINDOWS_INSTALL - if it\'s a windows server you want to install set to 1\r\n# SRCDS_APPID - steam app id ffound here - https://developer.valvesoftware.com/wiki/Dedicated_Servers_List\r\n# EXTRA_FLAGS - when a server has extra glas for things like beta installs or updates.\r\n#\r\n##\r\n\r\n## just in case someone removed the defaults.\r\nif [ \"${STEAM_USER}\" == \"\" ]; then\r\n    echo -e \"steam user is not set.\\n\"\r\n    echo -e \"Using anonymous user.\\n\"\r\n    STEAM_USER=anonymous\r\n    STEAM_PASS=\"\"\r\n    STEAM_AUTH=\"\"\r\nelse\r\n    echo -e \"user set to ${STEAM_USER}\"\r\nfi\r\n\r\n## download and install steamcmd\r\ncd /tmp\r\nmkdir -p /mnt/server/steamcmd\r\ncurl -sSL -o steamcmd.tar.gz https://steamcdn-a.akamaihd.net/client/installer/steamcmd_linux.tar.gz\r\ntar -xzvf steamcmd.tar.gz -C /mnt/server/steamcmd\r\nmkdir -p /mnt/server/steamapps # Fix steamcmd disk write error when this folder is missing\r\ncd /mnt/server/steamcmd\r\n\r\n# SteamCMD fails otherwise for some reason, even running as root.\r\n# This is changed at the end of the install process anyways.\r\nchown -R root:root /mnt\r\nexport HOME=/mnt/server\r\n\r\n## install game using steamcmd\r\n./steamcmd.sh +force_install_dir /mnt/server +login ${STEAM_USER} ${STEAM_PASS} ${STEAM_AUTH} $( [[ \"${WINDOWS_INSTALL}\" == \"1\" ]] && printf %s \'+@sSteamCmdForcePlatformType windows\' ) +app_update ${SRCDS_APPID} ${EXTRA_FLAGS} validate +quit ## other flags may be needed depending on install. looking at you cs 1.6\r\n\r\n## set up 32 bit libraries\r\nmkdir -p /mnt/server/.steam/sdk32\r\ncp -v linux32/steamclient.so ../.steam/sdk32/steamclient.so\r\n\r\n## set up 64 bit libraries\r\nmkdir -p /mnt/server/.steam/sdk64\r\ncp -v linux64/steamclient.so ../.steam/sdk64/steamclient.so','2022-11-27 16:19:20','2022-11-27 16:19:20',0),(12,'1570b271-8c97-4776-ad07-4ddda325abeb',3,'support@pterodactyl.io','Mumble Server','Mumble is an open source, low-latency, high quality voice chat software primarily intended for use while gaming.',NULL,'{\"ghcr.io\\/pterodactyl\\/yolks:alpine\":\"ghcr.io\\/pterodactyl\\/yolks:alpine\"}','[]',NULL,'{\r\n    \"murmur.ini\": {\r\n        \"parser\": \"ini\",\r\n        \"find\": {\r\n            \"logfile\": \"murmur.log\",\r\n            \"port\": \"{{server.build.default.port}}\",\r\n            \"host\": \"0.0.0.0\",\r\n            \"users\": \"{{server.build.env.MAX_USERS}}\"\r\n        }\r\n    }\r\n}','{\r\n    \"done\": \"Server listening on\"\r\n}','{\r\n    \"custom\": true,\r\n    \"location\": \"logs/murmur.log\"\r\n}','^C',NULL,'./murmur.x86 -fg','ghcr.io/pterodactyl/installers:alpine',NULL,'ash',1,'#!/bin/ash\r\n# Mumble Installation Script\r\n#\r\n# Server Files: /mnt/server\r\nGITHUB_PACKAGE=mumble-voip/mumble\r\nMATCH=murmur-static\r\n\r\nif [ ! -d /mnt/server/ ]; then\r\n    mkdir /mnt/server/\r\nfi\r\n\r\ncd /mnt/server\r\n\r\nif [ -z \"${GITHUB_USER}\" ] && [ -z \"${GITHUB_OAUTH_TOKEN}\" ] ; then\r\n    echo -e \"using anon api call\"\r\nelse\r\n    echo -e \"user and oauth token set\"\r\n    alias curl=\'curl -u ${GITHUB_USER}:${GITHUB_OAUTH_TOKEN} \'\r\nfi\r\n\r\n## get release info and download links\r\nLATEST_JSON=$(curl --silent \"https://api.github.com/repos/${GITHUB_PACKAGE}/releases/latest\")\r\nRELEASES=$(curl --silent \"https://api.github.com/repos/${GITHUB_PACKAGE}/releases\")\r\n\r\nif [ -z \"${VERSION}\" ] || [ \"${VERSION}\" == \"latest\" ]; then\r\n    DOWNLOAD_LINK=$(echo ${LATEST_JSON} | jq .assets | jq -r .[].browser_download_url | grep -m 1 -i ${MATCH})\r\nelse\r\n    VERSION_CHECK=$(echo ${RELEASES} | jq -r --arg VERSION \"${VERSION}\" \'.[] | select(.tag_name==$VERSION) | .tag_name\')\r\n    if [ \"${VERSION}\" == \"${VERSION_CHECK}\" ]; then\r\n        DOWNLOAD_LINK=$(echo ${RELEASES} | jq -r --arg VERSION \"${VERSION}\" \'.[] | select(.tag_name==$VERSION) | .assets[].browser_download_url\' | grep -m 1 -i ${MATCH})\r\n    else\r\n        echo -e \"defaulting to latest release\"\r\n        DOWNLOAD_LINK=$(echo ${LATEST_JSON} | jq .assets | jq -r .[].browser_download_url)\r\n    fi\r\nfi\r\n\r\ncurl -L ${DOWNLOAD_LINK} | tar xjv --strip-components=1','2022-11-27 16:19:20','2022-11-27 16:19:20',0),(13,'6e0744e6-e27e-4d48-afb8-8169b03a6b7f',3,'support@pterodactyl.io','Teamspeak3 Server','VoIP software designed with security in mind, featuring crystal clear voice quality, endless customization options, and scalabilty up to thousands of simultaneous users.',NULL,'{\"ghcr.io\\/pterodactyl\\/yolks:debian\":\"ghcr.io\\/pterodactyl\\/yolks:debian\"}','[]',NULL,'{}','{\r\n    \"done\": \"listening on 0.0.0.0:\"\r\n}','{\r\n    \"custom\": true,\r\n    \"location\": \"logs/ts3.log\"\r\n}','^C',NULL,'./ts3server default_voice_port={{SERVER_PORT}} query_port={{QUERY_PORT}} filetransfer_ip=0.0.0.0 filetransfer_port={{FILE_TRANSFER}} license_accepted=1','ghcr.io/pterodactyl/installers:alpine',NULL,'ash',1,'#!/bin/ash\r\n# TS3 Installation Script\r\n#\r\n# Server Files: /mnt/server\r\n\r\nif [ -z ${TS_VERSION} ] || [ ${TS_VERSION} == latest ]; then\r\n    TS_VERSION=$(curl -sSL https://teamspeak.com/versions/server.json | jq -r \'.linux.x86_64.version\')\r\nfi\r\n\r\ncd /mnt/server\r\n\r\necho -e \"getting files from http://files.teamspeak-services.com/releases/server/${TS_VERSION}/teamspeak3-server_linux_amd64-${TS_VERSION}.tar.bz2\" \r\ncurl -L http://files.teamspeak-services.com/releases/server/${TS_VERSION}/teamspeak3-server_linux_amd64-${TS_VERSION}.tar.bz2 | tar -xvj --strip-components=1','2022-11-27 16:19:20','2022-11-27 16:19:20',0),(14,'95ca6e82-5aab-4e5b-9626-bd38bcd819bf',4,'support@pterodactyl.io','Rust','The only aim in Rust is to survive. To do this you will need to overcome struggles such as hunger, thirst and cold. Build a fire. Build a shelter. Kill animals for meat. Protect yourself from other players, and kill them for meat. Create alliances with other players and form a town. Do whatever it takes to survive.','[\"steam_disk_space\"]','{\"quay.io\\/pterodactyl\\/core:rust\":\"quay.io\\/pterodactyl\\/core:rust\"}','[]',NULL,'{}','{\r\n    \"done\": \"Server startup complete\"\r\n}','{}','quit',NULL,'./RustDedicated -batchmode +server.port {{SERVER_PORT}} +server.identity \"rust\" +rcon.port {{RCON_PORT}} +rcon.web true +server.hostname \\\"{{HOSTNAME}}\\\" +server.level \\\"{{LEVEL}}\\\" +server.description \\\"{{DESCRIPTION}}\\\" +server.url \\\"{{SERVER_URL}}\\\" +server.headerimage \\\"{{SERVER_IMG}}\\\" +server.logoimage \\\"{{SERVER_LOGO}}\\\" +server.maxplayers {{MAX_PLAYERS}} +rcon.password \\\"{{RCON_PASS}}\\\" +server.saveinterval {{SAVEINTERVAL}} +app.port {{APP_PORT}}  $( [ -z ${MAP_URL} ] && printf %s \"+server.worldsize \\\"{{WORLD_SIZE}}\\\" +server.seed \\\"{{WORLD_SEED}}\\\"\" || printf %s \"+server.levelurl {{MAP_URL}}\" ) {{ADDITIONAL_ARGS}}','ghcr.io/pterodactyl/installers:debian',NULL,'bash',1,'#!/bin/bash\r\n# steamcmd Base Installation Script\r\n#\r\n# Server Files: /mnt/server\r\n\r\nSRCDS_APPID=258550\r\n\r\n## just in case someone removed the defaults.\r\nif [ \"${STEAM_USER}\" == \"\" ]; then\r\n    echo -e \"steam user is not set.\\n\"\r\n    echo -e \"Using anonymous user.\\n\"\r\n    STEAM_USER=anonymous\r\n    STEAM_PASS=\"\"\r\n    STEAM_AUTH=\"\"\r\nelse\r\n    echo -e \"user set to ${STEAM_USER}\"\r\nfi\r\n\r\n## download and install steamcmd\r\ncd /tmp\r\nmkdir -p /mnt/server/steamcmd\r\ncurl -sSL -o steamcmd.tar.gz https://steamcdn-a.akamaihd.net/client/installer/steamcmd_linux.tar.gz\r\ntar -xzvf steamcmd.tar.gz -C /mnt/server/steamcmd\r\nmkdir -p /mnt/server/steamapps # Fix steamcmd disk write error when this folder is missing\r\ncd /mnt/server/steamcmd\r\n\r\n# SteamCMD fails otherwise for some reason, even running as root.\r\n# This is changed at the end of the install process anyways.\r\nchown -R root:root /mnt\r\nexport HOME=/mnt/server\r\n\r\n## install game using steamcmd\r\n./steamcmd.sh +force_install_dir /mnt/server +login ${STEAM_USER} ${STEAM_PASS} ${STEAM_AUTH} +app_update ${SRCDS_APPID} ${EXTRA_FLAGS} validate +quit ## other flags may be needed depending on install. looking at you cs 1.6\r\n\r\n## set up 32 bit libraries\r\nmkdir -p /mnt/server/.steam/sdk32\r\ncp -v linux32/steamclient.so ../.steam/sdk32/steamclient.so\r\n\r\n## set up 64 bit libraries\r\nmkdir -p /mnt/server/.steam/sdk64\r\ncp -v linux64/steamclient.so ../.steam/sdk64/steamclient.so','2022-11-27 16:19:20','2022-11-27 16:19:20',0);
/*!40000 ALTER TABLE `eggs` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `failed_jobs`
--

DROP TABLE IF EXISTS `failed_jobs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `failed_jobs` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `connection` text NOT NULL,
  `queue` text NOT NULL,
  `payload` longtext NOT NULL,
  `failed_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `exception` text NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `failed_jobs`
--

LOCK TABLES `failed_jobs` WRITE;
/*!40000 ALTER TABLE `failed_jobs` DISABLE KEYS */;
INSERT INTO `failed_jobs` VALUES (1,'redis','standard','{\"uuid\":\"83733290-280d-4487-8d45-6f216f7adb5f\",\"timeout\":null,\"id\":\"5syR4WO4d8VAxVzbXvaaaX8lzMM6abjX\",\"backoff\":null,\"displayName\":\"Pterodactyl\\\\Notifications\\\\AccountCreated\",\"maxTries\":null,\"failOnTimeout\":false,\"maxExceptions\":null,\"retryUntil\":null,\"job\":\"Illuminate\\\\Queue\\\\CallQueuedHandler@call\",\"data\":{\"command\":\"O:48:\\\"Illuminate\\\\Notifications\\\\SendQueuedNotifications\\\":16:{s:11:\\\"notifiables\\\";O:45:\\\"Illuminate\\\\Contracts\\\\Database\\\\ModelIdentifier\\\":4:{s:5:\\\"class\\\";s:23:\\\"Pterodactyl\\\\Models\\\\User\\\";s:2:\\\"id\\\";a:1:{i:0;i:1;}s:9:\\\"relations\\\";a:0:{}s:10:\\\"connection\\\";s:5:\\\"mysql\\\";}s:12:\\\"notification\\\";O:40:\\\"Pterodactyl\\\\Notifications\\\\AccountCreated\\\":13:{s:5:\\\"token\\\";N;s:4:\\\"user\\\";O:45:\\\"Illuminate\\\\Contracts\\\\Database\\\\ModelIdentifier\\\":4:{s:5:\\\"class\\\";s:23:\\\"Pterodactyl\\\\Models\\\\User\\\";s:2:\\\"id\\\";i:1;s:9:\\\"relations\\\";a:0:{}s:10:\\\"connection\\\";s:5:\\\"mysql\\\";}s:2:\\\"id\\\";s:36:\\\"d9bd02a4-bd85-40dd-bf55-9987290b0977\\\";s:6:\\\"locale\\\";N;s:10:\\\"connection\\\";N;s:5:\\\"queue\\\";N;s:15:\\\"chainConnection\\\";N;s:10:\\\"chainQueue\\\";N;s:19:\\\"chainCatchCallbacks\\\";N;s:5:\\\"delay\\\";N;s:11:\\\"afterCommit\\\";N;s:10:\\\"middleware\\\";a:0:{}s:7:\\\"chained\\\";a:0:{}}s:8:\\\"channels\\\";a:1:{i:0;s:4:\\\"mail\\\";}s:5:\\\"tries\\\";N;s:7:\\\"timeout\\\";N;s:17:\\\"shouldBeEncrypted\\\";b:0;s:3:\\\"job\\\";N;s:10:\\\"connection\\\";N;s:5:\\\"queue\\\";N;s:15:\\\"chainConnection\\\";N;s:10:\\\"chainQueue\\\";N;s:19:\\\"chainCatchCallbacks\\\";N;s:5:\\\"delay\\\";N;s:11:\\\"afterCommit\\\";N;s:10:\\\"middleware\\\";a:0:{}s:7:\\\"chained\\\";a:0:{}}\",\"commandName\":\"Illuminate\\\\Notifications\\\\SendQueuedNotifications\"},\"attempts\":2}','2022-11-27 16:36:09','Swift_TransportException: Connection could not be established with host mail :stream_socket_client(): Unable to connect to 1://mail:1025 (Connection refused) in /app/vendor/swiftmailer/swiftmailer/lib/classes/Swift/Transport/StreamBuffer.php:261\nStack trace:\n#0 [internal function]: Swift_Transport_StreamBuffer->{closure}(2, \'stream_socket_c...\', \'/app/vendor/swi...\', 264)\n#1 /app/vendor/swiftmailer/swiftmailer/lib/classes/Swift/Transport/StreamBuffer.php(264): stream_socket_client(\'1://mail:1025\', 0, \'\', 30, 4, Resource id #1145)\n#2 /app/vendor/swiftmailer/swiftmailer/lib/classes/Swift/Transport/StreamBuffer.php(58): Swift_Transport_StreamBuffer->establishSocketConnection()\n#3 /app/vendor/swiftmailer/swiftmailer/lib/classes/Swift/Transport/AbstractSmtpTransport.php(143): Swift_Transport_StreamBuffer->initialize(Array)\n#4 /app/vendor/swiftmailer/swiftmailer/lib/classes/Swift/Mailer.php(65): Swift_Transport_AbstractSmtpTransport->start()\n#5 /app/vendor/laravel/framework/src/Illuminate/Mail/Mailer.php(521): Swift_Mailer->send(Object(Swift_Message), Array)\n#6 /app/vendor/laravel/framework/src/Illuminate/Mail/Mailer.php(288): Illuminate\\Mail\\Mailer->sendSwiftMessage(Object(Swift_Message))\n#7 /app/vendor/laravel/framework/src/Illuminate/Notifications/Channels/MailChannel.php(65): Illuminate\\Mail\\Mailer->send(Object(Illuminate\\Support\\HtmlString), Array, Object(Closure))\n#8 /app/vendor/laravel/framework/src/Illuminate/Notifications/NotificationSender.php(148): Illuminate\\Notifications\\Channels\\MailChannel->send(Object(Pterodactyl\\Models\\User), Object(Pterodactyl\\Notifications\\AccountCreated))\n#9 /app/vendor/laravel/framework/src/Illuminate/Notifications/NotificationSender.php(106): Illuminate\\Notifications\\NotificationSender->sendToNotifiable(Object(Pterodactyl\\Models\\User), \'f9de977c-64c8-4...\', Object(Pterodactyl\\Notifications\\AccountCreated), \'mail\')\n#10 /app/vendor/laravel/framework/src/Illuminate/Support/Traits/Localizable.php(19): Illuminate\\Notifications\\NotificationSender->Illuminate\\Notifications\\{closure}()\n#11 /app/vendor/laravel/framework/src/Illuminate/Notifications/NotificationSender.php(109): Illuminate\\Notifications\\NotificationSender->withLocale(NULL, Object(Closure))\n#12 /app/vendor/laravel/framework/src/Illuminate/Notifications/ChannelManager.php(54): Illuminate\\Notifications\\NotificationSender->sendNow(Object(Illuminate\\Database\\Eloquent\\Collection), Object(Pterodactyl\\Notifications\\AccountCreated), Array)\n#13 /app/vendor/laravel/framework/src/Illuminate/Notifications/SendQueuedNotifications.php(104): Illuminate\\Notifications\\ChannelManager->sendNow(Object(Illuminate\\Database\\Eloquent\\Collection), Object(Pterodactyl\\Notifications\\AccountCreated), Array)\n#14 /app/vendor/laravel/framework/src/Illuminate/Container/BoundMethod.php(36): Illuminate\\Notifications\\SendQueuedNotifications->handle(Object(Illuminate\\Notifications\\ChannelManager))\n#15 /app/vendor/laravel/framework/src/Illuminate/Container/Util.php(40): Illuminate\\Container\\BoundMethod::Illuminate\\Container\\{closure}()\n#16 /app/vendor/laravel/framework/src/Illuminate/Container/BoundMethod.php(93): Illuminate\\Container\\Util::unwrapIfClosure(Object(Closure))\n#17 /app/vendor/laravel/framework/src/Illuminate/Container/BoundMethod.php(37): Illuminate\\Container\\BoundMethod::callBoundMethod(Object(Illuminate\\Foundation\\Application), Array, Object(Closure))\n#18 /app/vendor/laravel/framework/src/Illuminate/Container/Container.php(653): Illuminate\\Container\\BoundMethod::call(Object(Illuminate\\Foundation\\Application), Array, Array, NULL)\n#19 /app/vendor/laravel/framework/src/Illuminate/Bus/Dispatcher.php(128): Illuminate\\Container\\Container->call(Array)\n#20 /app/vendor/laravel/framework/src/Illuminate/Pipeline/Pipeline.php(128): Illuminate\\Bus\\Dispatcher->Illuminate\\Bus\\{closure}(Object(Illuminate\\Notifications\\SendQueuedNotifications))\n#21 /app/vendor/laravel/framework/src/Illuminate/Pipeline/Pipeline.php(103): Illuminate\\Pipeline\\Pipeline->Illuminate\\Pipeline\\{closure}(Object(Illuminate\\Notifications\\SendQueuedNotifications))\n#22 /app/vendor/laravel/framework/src/Illuminate/Bus/Dispatcher.php(132): Illuminate\\Pipeline\\Pipeline->then(Object(Closure))\n#23 /app/vendor/laravel/framework/src/Illuminate/Queue/CallQueuedHandler.php(120): Illuminate\\Bus\\Dispatcher->dispatchNow(Object(Illuminate\\Notifications\\SendQueuedNotifications), false)\n#24 /app/vendor/laravel/framework/src/Illuminate/Pipeline/Pipeline.php(128): Illuminate\\Queue\\CallQueuedHandler->Illuminate\\Queue\\{closure}(Object(Illuminate\\Notifications\\SendQueuedNotifications))\n#25 /app/vendor/laravel/framework/src/Illuminate/Pipeline/Pipeline.php(103): Illuminate\\Pipeline\\Pipeline->Illuminate\\Pipeline\\{closure}(Object(Illuminate\\Notifications\\SendQueuedNotifications))\n#26 /app/vendor/laravel/framework/src/Illuminate/Queue/CallQueuedHandler.php(122): Illuminate\\Pipeline\\Pipeline->then(Object(Closure))\n#27 /app/vendor/laravel/framework/src/Illuminate/Queue/CallQueuedHandler.php(70): Illuminate\\Queue\\CallQueuedHandler->dispatchThroughMiddleware(Object(Illuminate\\Queue\\Jobs\\RedisJob), Object(Illuminate\\Notifications\\SendQueuedNotifications))\n#28 /app/vendor/laravel/framework/src/Illuminate/Queue/Jobs/Job.php(98): Illuminate\\Queue\\CallQueuedHandler->call(Object(Illuminate\\Queue\\Jobs\\RedisJob), Array)\n#29 /app/vendor/laravel/framework/src/Illuminate/Queue/Worker.php(428): Illuminate\\Queue\\Jobs\\Job->fire()\n#30 /app/vendor/laravel/framework/src/Illuminate/Queue/Worker.php(378): Illuminate\\Queue\\Worker->process(\'redis\', Object(Illuminate\\Queue\\Jobs\\RedisJob), Object(Illuminate\\Queue\\WorkerOptions))\n#31 /app/vendor/laravel/framework/src/Illuminate/Queue/Worker.php(172): Illuminate\\Queue\\Worker->runJob(Object(Illuminate\\Queue\\Jobs\\RedisJob), \'redis\', Object(Illuminate\\Queue\\WorkerOptions))\n#32 /app/vendor/laravel/framework/src/Illuminate/Queue/Console/WorkCommand.php(117): Illuminate\\Queue\\Worker->daemon(\'redis\', \'high,standard,l...\', Object(Illuminate\\Queue\\WorkerOptions))\n#33 /app/vendor/laravel/framework/src/Illuminate/Queue/Console/WorkCommand.php(101): Illuminate\\Queue\\Console\\WorkCommand->runWorker(\'redis\', \'high,standard,l...\')\n#34 /app/vendor/laravel/framework/src/Illuminate/Container/BoundMethod.php(36): Illuminate\\Queue\\Console\\WorkCommand->handle()\n#35 /app/vendor/laravel/framework/src/Illuminate/Container/Util.php(40): Illuminate\\Container\\BoundMethod::Illuminate\\Container\\{closure}()\n#36 /app/vendor/laravel/framework/src/Illuminate/Container/BoundMethod.php(93): Illuminate\\Container\\Util::unwrapIfClosure(Object(Closure))\n#37 /app/vendor/laravel/framework/src/Illuminate/Container/BoundMethod.php(37): Illuminate\\Container\\BoundMethod::callBoundMethod(Object(Illuminate\\Foundation\\Application), Array, Object(Closure))\n#38 /app/vendor/laravel/framework/src/Illuminate/Container/Container.php(653): Illuminate\\Container\\BoundMethod::call(Object(Illuminate\\Foundation\\Application), Array, Array, NULL)\n#39 /app/vendor/laravel/framework/src/Illuminate/Console/Command.php(136): Illuminate\\Container\\Container->call(Array)\n#40 /app/vendor/symfony/console/Command/Command.php(298): Illuminate\\Console\\Command->execute(Object(Symfony\\Component\\Console\\Input\\ArgvInput), Object(Illuminate\\Console\\OutputStyle))\n#41 /app/vendor/laravel/framework/src/Illuminate/Console/Command.php(121): Symfony\\Component\\Console\\Command\\Command->run(Object(Symfony\\Component\\Console\\Input\\ArgvInput), Object(Illuminate\\Console\\OutputStyle))\n#42 /app/vendor/symfony/console/Application.php(1024): Illuminate\\Console\\Command->run(Object(Symfony\\Component\\Console\\Input\\ArgvInput), Object(Symfony\\Component\\Console\\Output\\ConsoleOutput))\n#43 /app/vendor/symfony/console/Application.php(299): Symfony\\Component\\Console\\Application->doRunCommand(Object(Illuminate\\Queue\\Console\\WorkCommand), Object(Symfony\\Component\\Console\\Input\\ArgvInput), Object(Symfony\\Component\\Console\\Output\\ConsoleOutput))\n#44 /app/vendor/symfony/console/Application.php(171): Symfony\\Component\\Console\\Application->doRun(Object(Symfony\\Component\\Console\\Input\\ArgvInput), Object(Symfony\\Component\\Console\\Output\\ConsoleOutput))\n#45 /app/vendor/laravel/framework/src/Illuminate/Console/Application.php(94): Symfony\\Component\\Console\\Application->run(Object(Symfony\\Component\\Console\\Input\\ArgvInput), Object(Symfony\\Component\\Console\\Output\\ConsoleOutput))\n#46 /app/vendor/laravel/framework/src/Illuminate/Foundation/Console/Kernel.php(129): Illuminate\\Console\\Application->run(Object(Symfony\\Component\\Console\\Input\\ArgvInput), Object(Symfony\\Component\\Console\\Output\\ConsoleOutput))\n#47 /app/artisan(37): Illuminate\\Foundation\\Console\\Kernel->handle(Object(Symfony\\Component\\Console\\Input\\ArgvInput), Object(Symfony\\Component\\Console\\Output\\ConsoleOutput))\n#48 {main}'),(2,'redis','standard','{\"uuid\":\"78c42393-a144-4573-bbae-2b782399d66e\",\"timeout\":null,\"id\":\"P9T8ZCD2pXUPMOFnC4tjCfqrV0Rw28ig\",\"backoff\":null,\"displayName\":\"Pterodactyl\\\\Notifications\\\\AccountCreated\",\"maxTries\":null,\"failOnTimeout\":false,\"maxExceptions\":null,\"retryUntil\":null,\"job\":\"Illuminate\\\\Queue\\\\CallQueuedHandler@call\",\"data\":{\"command\":\"O:48:\\\"Illuminate\\\\Notifications\\\\SendQueuedNotifications\\\":16:{s:11:\\\"notifiables\\\";O:45:\\\"Illuminate\\\\Contracts\\\\Database\\\\ModelIdentifier\\\":4:{s:5:\\\"class\\\";s:23:\\\"Pterodactyl\\\\Models\\\\User\\\";s:2:\\\"id\\\";a:1:{i:0;i:2;}s:9:\\\"relations\\\";a:0:{}s:10:\\\"connection\\\";s:5:\\\"mysql\\\";}s:12:\\\"notification\\\";O:40:\\\"Pterodactyl\\\\Notifications\\\\AccountCreated\\\":13:{s:5:\\\"token\\\";N;s:4:\\\"user\\\";O:45:\\\"Illuminate\\\\Contracts\\\\Database\\\\ModelIdentifier\\\":4:{s:5:\\\"class\\\";s:23:\\\"Pterodactyl\\\\Models\\\\User\\\";s:2:\\\"id\\\";i:2;s:9:\\\"relations\\\";a:0:{}s:10:\\\"connection\\\";s:5:\\\"mysql\\\";}s:2:\\\"id\\\";s:36:\\\"29487a98-1c7c-4251-9b38-b879e2384511\\\";s:6:\\\"locale\\\";N;s:10:\\\"connection\\\";N;s:5:\\\"queue\\\";N;s:15:\\\"chainConnection\\\";N;s:10:\\\"chainQueue\\\";N;s:19:\\\"chainCatchCallbacks\\\";N;s:5:\\\"delay\\\";N;s:11:\\\"afterCommit\\\";N;s:10:\\\"middleware\\\";a:0:{}s:7:\\\"chained\\\";a:0:{}}s:8:\\\"channels\\\";a:1:{i:0;s:4:\\\"mail\\\";}s:5:\\\"tries\\\";N;s:7:\\\"timeout\\\";N;s:17:\\\"shouldBeEncrypted\\\";b:0;s:3:\\\"job\\\";N;s:10:\\\"connection\\\";N;s:5:\\\"queue\\\";N;s:15:\\\"chainConnection\\\";N;s:10:\\\"chainQueue\\\";N;s:19:\\\"chainCatchCallbacks\\\";N;s:5:\\\"delay\\\";N;s:11:\\\"afterCommit\\\";N;s:10:\\\"middleware\\\";a:0:{}s:7:\\\"chained\\\";a:0:{}}\",\"commandName\":\"Illuminate\\\\Notifications\\\\SendQueuedNotifications\"},\"attempts\":2}','2022-11-27 16:42:13','Swift_TransportException: Connection could not be established with host mail :stream_socket_client(): Unable to connect to 1://mail:1025 (Connection refused) in /app/vendor/swiftmailer/swiftmailer/lib/classes/Swift/Transport/StreamBuffer.php:261\nStack trace:\n#0 [internal function]: Swift_Transport_StreamBuffer->{closure}(2, \'stream_socket_c...\', \'/app/vendor/swi...\', 264)\n#1 /app/vendor/swiftmailer/swiftmailer/lib/classes/Swift/Transport/StreamBuffer.php(264): stream_socket_client(\'1://mail:1025\', 0, \'\', 30, 4, Resource id #1165)\n#2 /app/vendor/swiftmailer/swiftmailer/lib/classes/Swift/Transport/StreamBuffer.php(58): Swift_Transport_StreamBuffer->establishSocketConnection()\n#3 /app/vendor/swiftmailer/swiftmailer/lib/classes/Swift/Transport/AbstractSmtpTransport.php(143): Swift_Transport_StreamBuffer->initialize(Array)\n#4 /app/vendor/swiftmailer/swiftmailer/lib/classes/Swift/Mailer.php(65): Swift_Transport_AbstractSmtpTransport->start()\n#5 /app/vendor/laravel/framework/src/Illuminate/Mail/Mailer.php(521): Swift_Mailer->send(Object(Swift_Message), Array)\n#6 /app/vendor/laravel/framework/src/Illuminate/Mail/Mailer.php(288): Illuminate\\Mail\\Mailer->sendSwiftMessage(Object(Swift_Message))\n#7 /app/vendor/laravel/framework/src/Illuminate/Notifications/Channels/MailChannel.php(65): Illuminate\\Mail\\Mailer->send(Object(Illuminate\\Support\\HtmlString), Array, Object(Closure))\n#8 /app/vendor/laravel/framework/src/Illuminate/Notifications/NotificationSender.php(148): Illuminate\\Notifications\\Channels\\MailChannel->send(Object(Pterodactyl\\Models\\User), Object(Pterodactyl\\Notifications\\AccountCreated))\n#9 /app/vendor/laravel/framework/src/Illuminate/Notifications/NotificationSender.php(106): Illuminate\\Notifications\\NotificationSender->sendToNotifiable(Object(Pterodactyl\\Models\\User), \'34d513af-ebbc-4...\', Object(Pterodactyl\\Notifications\\AccountCreated), \'mail\')\n#10 /app/vendor/laravel/framework/src/Illuminate/Support/Traits/Localizable.php(19): Illuminate\\Notifications\\NotificationSender->Illuminate\\Notifications\\{closure}()\n#11 /app/vendor/laravel/framework/src/Illuminate/Notifications/NotificationSender.php(109): Illuminate\\Notifications\\NotificationSender->withLocale(NULL, Object(Closure))\n#12 /app/vendor/laravel/framework/src/Illuminate/Notifications/ChannelManager.php(54): Illuminate\\Notifications\\NotificationSender->sendNow(Object(Illuminate\\Database\\Eloquent\\Collection), Object(Pterodactyl\\Notifications\\AccountCreated), Array)\n#13 /app/vendor/laravel/framework/src/Illuminate/Notifications/SendQueuedNotifications.php(104): Illuminate\\Notifications\\ChannelManager->sendNow(Object(Illuminate\\Database\\Eloquent\\Collection), Object(Pterodactyl\\Notifications\\AccountCreated), Array)\n#14 /app/vendor/laravel/framework/src/Illuminate/Container/BoundMethod.php(36): Illuminate\\Notifications\\SendQueuedNotifications->handle(Object(Illuminate\\Notifications\\ChannelManager))\n#15 /app/vendor/laravel/framework/src/Illuminate/Container/Util.php(40): Illuminate\\Container\\BoundMethod::Illuminate\\Container\\{closure}()\n#16 /app/vendor/laravel/framework/src/Illuminate/Container/BoundMethod.php(93): Illuminate\\Container\\Util::unwrapIfClosure(Object(Closure))\n#17 /app/vendor/laravel/framework/src/Illuminate/Container/BoundMethod.php(37): Illuminate\\Container\\BoundMethod::callBoundMethod(Object(Illuminate\\Foundation\\Application), Array, Object(Closure))\n#18 /app/vendor/laravel/framework/src/Illuminate/Container/Container.php(653): Illuminate\\Container\\BoundMethod::call(Object(Illuminate\\Foundation\\Application), Array, Array, NULL)\n#19 /app/vendor/laravel/framework/src/Illuminate/Bus/Dispatcher.php(128): Illuminate\\Container\\Container->call(Array)\n#20 /app/vendor/laravel/framework/src/Illuminate/Pipeline/Pipeline.php(128): Illuminate\\Bus\\Dispatcher->Illuminate\\Bus\\{closure}(Object(Illuminate\\Notifications\\SendQueuedNotifications))\n#21 /app/vendor/laravel/framework/src/Illuminate/Pipeline/Pipeline.php(103): Illuminate\\Pipeline\\Pipeline->Illuminate\\Pipeline\\{closure}(Object(Illuminate\\Notifications\\SendQueuedNotifications))\n#22 /app/vendor/laravel/framework/src/Illuminate/Bus/Dispatcher.php(132): Illuminate\\Pipeline\\Pipeline->then(Object(Closure))\n#23 /app/vendor/laravel/framework/src/Illuminate/Queue/CallQueuedHandler.php(120): Illuminate\\Bus\\Dispatcher->dispatchNow(Object(Illuminate\\Notifications\\SendQueuedNotifications), false)\n#24 /app/vendor/laravel/framework/src/Illuminate/Pipeline/Pipeline.php(128): Illuminate\\Queue\\CallQueuedHandler->Illuminate\\Queue\\{closure}(Object(Illuminate\\Notifications\\SendQueuedNotifications))\n#25 /app/vendor/laravel/framework/src/Illuminate/Pipeline/Pipeline.php(103): Illuminate\\Pipeline\\Pipeline->Illuminate\\Pipeline\\{closure}(Object(Illuminate\\Notifications\\SendQueuedNotifications))\n#26 /app/vendor/laravel/framework/src/Illuminate/Queue/CallQueuedHandler.php(122): Illuminate\\Pipeline\\Pipeline->then(Object(Closure))\n#27 /app/vendor/laravel/framework/src/Illuminate/Queue/CallQueuedHandler.php(70): Illuminate\\Queue\\CallQueuedHandler->dispatchThroughMiddleware(Object(Illuminate\\Queue\\Jobs\\RedisJob), Object(Illuminate\\Notifications\\SendQueuedNotifications))\n#28 /app/vendor/laravel/framework/src/Illuminate/Queue/Jobs/Job.php(98): Illuminate\\Queue\\CallQueuedHandler->call(Object(Illuminate\\Queue\\Jobs\\RedisJob), Array)\n#29 /app/vendor/laravel/framework/src/Illuminate/Queue/Worker.php(428): Illuminate\\Queue\\Jobs\\Job->fire()\n#30 /app/vendor/laravel/framework/src/Illuminate/Queue/Worker.php(378): Illuminate\\Queue\\Worker->process(\'redis\', Object(Illuminate\\Queue\\Jobs\\RedisJob), Object(Illuminate\\Queue\\WorkerOptions))\n#31 /app/vendor/laravel/framework/src/Illuminate/Queue/Worker.php(172): Illuminate\\Queue\\Worker->runJob(Object(Illuminate\\Queue\\Jobs\\RedisJob), \'redis\', Object(Illuminate\\Queue\\WorkerOptions))\n#32 /app/vendor/laravel/framework/src/Illuminate/Queue/Console/WorkCommand.php(117): Illuminate\\Queue\\Worker->daemon(\'redis\', \'high,standard,l...\', Object(Illuminate\\Queue\\WorkerOptions))\n#33 /app/vendor/laravel/framework/src/Illuminate/Queue/Console/WorkCommand.php(101): Illuminate\\Queue\\Console\\WorkCommand->runWorker(\'redis\', \'high,standard,l...\')\n#34 /app/vendor/laravel/framework/src/Illuminate/Container/BoundMethod.php(36): Illuminate\\Queue\\Console\\WorkCommand->handle()\n#35 /app/vendor/laravel/framework/src/Illuminate/Container/Util.php(40): Illuminate\\Container\\BoundMethod::Illuminate\\Container\\{closure}()\n#36 /app/vendor/laravel/framework/src/Illuminate/Container/BoundMethod.php(93): Illuminate\\Container\\Util::unwrapIfClosure(Object(Closure))\n#37 /app/vendor/laravel/framework/src/Illuminate/Container/BoundMethod.php(37): Illuminate\\Container\\BoundMethod::callBoundMethod(Object(Illuminate\\Foundation\\Application), Array, Object(Closure))\n#38 /app/vendor/laravel/framework/src/Illuminate/Container/Container.php(653): Illuminate\\Container\\BoundMethod::call(Object(Illuminate\\Foundation\\Application), Array, Array, NULL)\n#39 /app/vendor/laravel/framework/src/Illuminate/Console/Command.php(136): Illuminate\\Container\\Container->call(Array)\n#40 /app/vendor/symfony/console/Command/Command.php(298): Illuminate\\Console\\Command->execute(Object(Symfony\\Component\\Console\\Input\\ArgvInput), Object(Illuminate\\Console\\OutputStyle))\n#41 /app/vendor/laravel/framework/src/Illuminate/Console/Command.php(121): Symfony\\Component\\Console\\Command\\Command->run(Object(Symfony\\Component\\Console\\Input\\ArgvInput), Object(Illuminate\\Console\\OutputStyle))\n#42 /app/vendor/symfony/console/Application.php(1024): Illuminate\\Console\\Command->run(Object(Symfony\\Component\\Console\\Input\\ArgvInput), Object(Symfony\\Component\\Console\\Output\\ConsoleOutput))\n#43 /app/vendor/symfony/console/Application.php(299): Symfony\\Component\\Console\\Application->doRunCommand(Object(Illuminate\\Queue\\Console\\WorkCommand), Object(Symfony\\Component\\Console\\Input\\ArgvInput), Object(Symfony\\Component\\Console\\Output\\ConsoleOutput))\n#44 /app/vendor/symfony/console/Application.php(171): Symfony\\Component\\Console\\Application->doRun(Object(Symfony\\Component\\Console\\Input\\ArgvInput), Object(Symfony\\Component\\Console\\Output\\ConsoleOutput))\n#45 /app/vendor/laravel/framework/src/Illuminate/Console/Application.php(94): Symfony\\Component\\Console\\Application->run(Object(Symfony\\Component\\Console\\Input\\ArgvInput), Object(Symfony\\Component\\Console\\Output\\ConsoleOutput))\n#46 /app/vendor/laravel/framework/src/Illuminate/Foundation/Console/Kernel.php(129): Illuminate\\Console\\Application->run(Object(Symfony\\Component\\Console\\Input\\ArgvInput), Object(Symfony\\Component\\Console\\Output\\ConsoleOutput))\n#47 /app/artisan(37): Illuminate\\Foundation\\Console\\Kernel->handle(Object(Symfony\\Component\\Console\\Input\\ArgvInput), Object(Symfony\\Component\\Console\\Output\\ConsoleOutput))\n#48 {main}');
/*!40000 ALTER TABLE `failed_jobs` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `jobs`
--

DROP TABLE IF EXISTS `jobs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `jobs` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `queue` varchar(191) NOT NULL,
  `payload` longtext NOT NULL,
  `attempts` tinyint(3) unsigned NOT NULL,
  `reserved_at` int(10) unsigned DEFAULT NULL,
  `available_at` int(10) unsigned NOT NULL,
  `created_at` int(10) unsigned NOT NULL,
  PRIMARY KEY (`id`),
  KEY `jobs_queue_reserved_at_index` (`queue`,`reserved_at`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `jobs`
--

LOCK TABLES `jobs` WRITE;
/*!40000 ALTER TABLE `jobs` DISABLE KEYS */;
/*!40000 ALTER TABLE `jobs` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `locations`
--

DROP TABLE IF EXISTS `locations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `locations` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `short` varchar(191) NOT NULL,
  `long` text DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `locations_short_unique` (`short`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `locations`
--

LOCK TABLES `locations` WRITE;
/*!40000 ALTER TABLE `locations` DISABLE KEYS */;
INSERT INTO `locations` VALUES (1,'test location',NULL,'2022-12-03 10:28:04','2022-12-03 10:28:04');
/*!40000 ALTER TABLE `locations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `migrations`
--

DROP TABLE IF EXISTS `migrations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `migrations` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `migration` varchar(191) NOT NULL,
  `batch` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=192 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `migrations`
--

LOCK TABLES `migrations` WRITE;
/*!40000 ALTER TABLE `migrations` DISABLE KEYS */;
INSERT INTO `migrations` VALUES (1,'2016_01_23_195641_add_allocations_table',1),(2,'2016_01_23_195851_add_api_keys',1),(3,'2016_01_23_200044_add_api_permissions',1),(4,'2016_01_23_200159_add_downloads',1),(5,'2016_01_23_200421_create_failed_jobs_table',1),(6,'2016_01_23_200440_create_jobs_table',1),(7,'2016_01_23_200528_add_locations',1),(8,'2016_01_23_200648_add_nodes',1),(9,'2016_01_23_201433_add_password_resets',1),(10,'2016_01_23_201531_add_permissions',1),(11,'2016_01_23_201649_add_server_variables',1),(12,'2016_01_23_201748_add_servers',1),(13,'2016_01_23_202544_add_service_options',1),(14,'2016_01_23_202731_add_service_varibles',1),(15,'2016_01_23_202943_add_services',1),(16,'2016_01_23_203119_create_settings_table',1),(17,'2016_01_23_203150_add_subusers',1),(18,'2016_01_23_203159_add_users',1),(19,'2016_01_23_203947_create_sessions_table',1),(20,'2016_01_25_234418_rename_permissions_column',1),(21,'2016_02_07_172148_add_databases_tables',1),(22,'2016_02_07_181319_add_database_servers_table',1),(23,'2016_02_13_154306_add_service_option_default_startup',1),(24,'2016_02_20_155318_add_unique_service_field',1),(25,'2016_02_27_163411_add_tasks_table',1),(26,'2016_02_27_163447_add_tasks_log_table',1),(27,'2016_03_18_155649_add_nullable_field_lastrun',1),(28,'2016_08_30_212718_add_ip_alias',1),(29,'2016_08_30_213301_modify_ip_storage_method',1),(30,'2016_09_01_193520_add_suspension_for_servers',1),(31,'2016_09_01_211924_remove_active_column',1),(32,'2016_09_02_190647_add_sftp_password_storage',1),(33,'2016_09_04_171338_update_jobs_tables',1),(34,'2016_09_04_172028_update_failed_jobs_table',1),(35,'2016_09_04_182835_create_notifications_table',1),(36,'2016_09_07_163017_add_unique_identifier',1),(37,'2016_09_14_145945_allow_longer_regex_field',1),(38,'2016_09_17_194246_add_docker_image_column',1),(39,'2016_09_21_165554_update_servers_column_name',1),(40,'2016_09_29_213518_rename_double_insurgency',1),(41,'2016_10_07_152117_build_api_log_table',1),(42,'2016_10_14_164802_update_api_keys',1),(43,'2016_10_23_181719_update_misnamed_bungee',1),(44,'2016_10_23_193810_add_foreign_keys_servers',1),(45,'2016_10_23_201624_add_foreign_allocations',1),(46,'2016_10_23_202222_add_foreign_api_keys',1),(47,'2016_10_23_202703_add_foreign_api_permissions',1),(48,'2016_10_23_202953_add_foreign_database_servers',1),(49,'2016_10_23_203105_add_foreign_databases',1),(50,'2016_10_23_203335_add_foreign_nodes',1),(51,'2016_10_23_203522_add_foreign_permissions',1),(52,'2016_10_23_203857_add_foreign_server_variables',1),(53,'2016_10_23_204157_add_foreign_service_options',1),(54,'2016_10_23_204321_add_foreign_service_variables',1),(55,'2016_10_23_204454_add_foreign_subusers',1),(56,'2016_10_23_204610_add_foreign_tasks',1),(57,'2016_11_04_000949_add_ark_service_option_fixed',1),(58,'2016_11_11_220649_add_pack_support',1),(59,'2016_11_11_231731_set_service_name_unique',1),(60,'2016_11_27_142519_add_pack_column',1),(61,'2016_12_01_173018_add_configurable_upload_limit',1),(62,'2016_12_02_185206_correct_service_variables',1),(63,'2017_01_03_150436_fix_misnamed_option_tag',1),(64,'2017_01_07_154228_create_node_configuration_tokens_table',1),(65,'2017_01_12_135449_add_more_user_data',1),(66,'2017_02_02_175548_UpdateColumnNames',1),(67,'2017_02_03_140948_UpdateNodesTable',1),(68,'2017_02_03_155554_RenameColumns',1),(69,'2017_02_05_164123_AdjustColumnNames',1),(70,'2017_02_05_164516_AdjustColumnNamesForServicePacks',1),(71,'2017_02_09_174834_SetupPermissionsPivotTable',1),(72,'2017_02_10_171858_UpdateAPIKeyColumnNames',1),(73,'2017_03_03_224254_UpdateNodeConfigTokensColumns',1),(74,'2017_03_05_212803_DeleteServiceExecutableOption',1),(75,'2017_03_10_162934_AddNewServiceOptionsColumns',1),(76,'2017_03_10_173607_MigrateToNewServiceSystem',1),(77,'2017_03_11_215455_ChangeServiceVariablesValidationRules',1),(78,'2017_03_12_150648_MoveFunctionsFromFileToDatabase',1),(79,'2017_03_14_175631_RenameServicePacksToSingluarPacks',1),(80,'2017_03_14_200326_AddLockedStatusToTable',1),(81,'2017_03_16_181109_ReOrganizeDatabaseServersToDatabaseHost',1),(82,'2017_03_16_181515_CleanupDatabasesDatabase',1),(83,'2017_03_18_204953_AddForeignKeyToPacks',1),(84,'2017_03_31_221948_AddServerDescriptionColumn',1),(85,'2017_04_02_163232_DropDeletedAtColumnFromServers',1),(86,'2017_04_15_125021_UpgradeTaskSystem',1),(87,'2017_04_20_171943_AddScriptsToServiceOptions',1),(88,'2017_04_21_151432_AddServiceScriptTrackingToServers',1),(89,'2017_04_27_145300_AddCopyScriptFromColumn',1),(90,'2017_04_27_223629_AddAbilityToDefineConnectionOverSSLWithDaemonBehindProxy',1),(91,'2017_05_01_141528_DeleteDownloadTable',1),(92,'2017_05_01_141559_DeleteNodeConfigurationTable',1),(93,'2017_06_10_152951_add_external_id_to_users',1),(94,'2017_06_25_133923_ChangeForeignKeyToBeOnCascadeDelete',1),(95,'2017_07_08_152806_ChangeUserPermissionsToDeleteOnUserDeletion',1),(96,'2017_07_08_154416_SetAllocationToReferenceNullOnServerDelete',1),(97,'2017_07_08_154650_CascadeDeletionWhenAServerOrVariableIsDeleted',1),(98,'2017_07_24_194433_DeleteTaskWhenParentServerIsDeleted',1),(99,'2017_08_05_115800_CascadeNullValuesForDatabaseHostWhenNodeIsDeleted',1),(100,'2017_08_05_144104_AllowNegativeValuesForOverallocation',1),(101,'2017_08_05_174811_SetAllocationUnqiueUsingMultipleFields',1),(102,'2017_08_15_214555_CascadeDeletionWhenAParentServiceIsDeleted',1),(103,'2017_08_18_215428_RemovePackWhenParentServiceOptionIsDeleted',1),(104,'2017_09_10_225749_RenameTasksTableForStructureRefactor',1),(105,'2017_09_10_225941_CreateSchedulesTable',1),(106,'2017_09_10_230309_CreateNewTasksTableForSchedules',1),(107,'2017_09_11_002938_TransferOldTasksToNewScheduler',1),(108,'2017_09_13_211810_UpdateOldPermissionsToPointToNewScheduleSystem',1),(109,'2017_09_23_170933_CreateDaemonKeysTable',1),(110,'2017_09_23_173628_RemoveDaemonSecretFromServersTable',1),(111,'2017_09_23_185022_RemoveDaemonSecretFromSubusersTable',1),(112,'2017_10_02_202000_ChangeServicesToUseAMoreUniqueIdentifier',1),(113,'2017_10_02_202007_ChangeToABetterUniqueServiceConfiguration',1),(114,'2017_10_03_233202_CascadeDeletionWhenServiceOptionIsDeleted',1),(115,'2017_10_06_214026_ServicesToNestsConversion',1),(116,'2017_10_06_214053_ServiceOptionsToEggsConversion',1),(117,'2017_10_06_215741_ServiceVariablesToEggVariablesConversion',1),(118,'2017_10_24_222238_RemoveLegacySFTPInformation',1),(119,'2017_11_11_161922_Add2FaLastAuthorizationTimeColumn',1),(120,'2017_11_19_122708_MigratePubPrivFormatToSingleKey',1),(121,'2017_12_04_184012_DropAllocationsWhenNodeIsDeleted',1),(122,'2017_12_12_220426_MigrateSettingsTableToNewFormat',1),(123,'2018_01_01_122821_AllowNegativeValuesForServerSwap',1),(124,'2018_01_11_213943_AddApiKeyPermissionColumns',1),(125,'2018_01_13_142012_SetupTableForKeyEncryption',1),(126,'2018_01_13_145209_AddLastUsedAtColumn',1),(127,'2018_02_04_145617_AllowTextInUserExternalId',1),(128,'2018_02_10_151150_remove_unique_index_on_external_id_column',1),(129,'2018_02_17_134254_ensure_unique_allocation_id_on_servers_table',1),(130,'2018_02_24_112356_add_external_id_column_to_servers_table',1),(131,'2018_02_25_160152_remove_default_null_value_on_table',1),(132,'2018_02_25_160604_define_unique_index_on_users_external_id',1),(133,'2018_03_01_192831_add_database_and_port_limit_columns_to_servers_table',1),(134,'2018_03_15_124536_add_description_to_nodes',1),(135,'2018_05_04_123826_add_maintenance_to_nodes',1),(136,'2018_09_03_143756_allow_egg_variables_to_have_longer_values',1),(137,'2018_09_03_144005_allow_server_variables_to_have_longer_values',1),(138,'2019_03_02_142328_set_allocation_limit_default_null',1),(139,'2019_03_02_151321_fix_unique_index_to_account_for_host',1),(140,'2020_03_22_163911_merge_permissions_table_into_subusers',1),(141,'2020_03_22_164814_drop_permissions_table',1),(142,'2020_04_03_203624_add_threads_column_to_servers_table',1),(143,'2020_04_03_230614_create_backups_table',1),(144,'2020_04_04_131016_add_table_server_transfers',1),(145,'2020_04_10_141024_store_node_tokens_as_encrypted_value',1),(146,'2020_04_17_203438_allow_nullable_descriptions',1),(147,'2020_04_22_055500_add_max_connections_column',1),(148,'2020_04_26_111208_add_backup_limit_to_servers',1),(149,'2020_05_20_234655_add_mounts_table',1),(150,'2020_05_21_192756_add_mount_server_table',1),(151,'2020_07_02_213612_create_user_recovery_tokens_table',1),(152,'2020_07_09_201845_add_notes_column_for_allocations',1),(153,'2020_08_20_205533_add_backup_state_column_to_backups',1),(154,'2020_08_22_132500_update_bytes_to_unsigned_bigint',1),(155,'2020_08_23_175331_modify_checksums_column_for_backups',1),(156,'2020_09_13_110007_drop_packs_from_servers',1),(157,'2020_09_13_110021_drop_packs_from_api_key_permissions',1),(158,'2020_09_13_110047_drop_packs_table',1),(159,'2020_09_13_113503_drop_daemon_key_table',1),(160,'2020_10_10_165437_change_unique_database_name_to_account_for_server',1),(161,'2020_10_26_194904_remove_nullable_from_schedule_name_field',1),(162,'2020_11_02_201014_add_features_column_to_eggs',1),(163,'2020_12_12_102435_support_multiple_docker_images_and_updates',1),(164,'2020_12_14_013707_make_successful_nullable_in_server_transfers',1),(165,'2020_12_17_014330_add_archived_field_to_server_transfers_table',1),(166,'2020_12_24_092449_make_allocation_fields_json',1),(167,'2020_12_26_184914_add_upload_id_column_to_backups_table',1),(168,'2021_01_10_153937_add_file_denylist_to_egg_configs',1),(169,'2021_01_13_013420_add_cron_month',1),(170,'2021_01_17_102401_create_audit_logs_table',1),(171,'2021_01_17_152623_add_generic_server_status_column',1),(172,'2021_01_26_210502_update_file_denylist_to_json',1),(173,'2021_02_23_205021_add_index_for_server_and_action',1),(174,'2021_02_23_212657_make_sftp_port_unsigned_int',1),(175,'2021_03_21_104718_force_cron_month_field_to_have_value_if_missing',1),(176,'2021_05_01_092457_add_continue_on_failure_option_to_tasks',1),(177,'2021_05_01_092523_add_only_run_when_server_online_option_to_schedules',1),(178,'2021_05_03_201016_add_support_for_locking_a_backup',1),(179,'2021_07_12_013420_remove_userinteraction',1),(180,'2021_07_17_211512_create_user_ssh_keys_table',1),(181,'2021_08_03_210600_change_successful_field_to_default_to_false_on_backups_table',1),(182,'2021_08_21_175111_add_foreign_keys_to_mount_node_table',1),(183,'2021_08_21_175118_add_foreign_keys_to_mount_server_table',1),(184,'2021_08_21_180921_add_foreign_keys_to_egg_mount_table',1),(185,'2022_01_25_030847_drop_google_analytics',1),(186,'2022_05_07_165334_migrate_egg_images_array_to_new_format',1),(187,'2022_05_28_135717_create_activity_logs_table',1),(188,'2022_05_29_140349_create_activity_log_actors_table',1),(189,'2022_06_18_112822_track_api_key_usage_for_activity_events',1),(190,'2022_08_16_214400_add_force_outgoing_ip_column_to_eggs_table',1),(191,'2022_08_16_230204_add_installed_at_column_to_servers_table',1);
/*!40000 ALTER TABLE `migrations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `mount_node`
--

DROP TABLE IF EXISTS `mount_node`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mount_node` (
  `node_id` int(10) unsigned NOT NULL,
  `mount_id` int(10) unsigned NOT NULL,
  UNIQUE KEY `mount_node_node_id_mount_id_unique` (`node_id`,`mount_id`),
  KEY `mount_node_mount_id_foreign` (`mount_id`),
  CONSTRAINT `mount_node_mount_id_foreign` FOREIGN KEY (`mount_id`) REFERENCES `mounts` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `mount_node_node_id_foreign` FOREIGN KEY (`node_id`) REFERENCES `nodes` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `mount_node`
--

LOCK TABLES `mount_node` WRITE;
/*!40000 ALTER TABLE `mount_node` DISABLE KEYS */;
/*!40000 ALTER TABLE `mount_node` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `mount_server`
--

DROP TABLE IF EXISTS `mount_server`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mount_server` (
  `server_id` int(10) unsigned NOT NULL,
  `mount_id` int(10) unsigned NOT NULL,
  UNIQUE KEY `mount_server_server_id_mount_id_unique` (`server_id`,`mount_id`),
  KEY `mount_server_mount_id_foreign` (`mount_id`),
  CONSTRAINT `mount_server_mount_id_foreign` FOREIGN KEY (`mount_id`) REFERENCES `mounts` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `mount_server_server_id_foreign` FOREIGN KEY (`server_id`) REFERENCES `servers` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `mount_server`
--

LOCK TABLES `mount_server` WRITE;
/*!40000 ALTER TABLE `mount_server` DISABLE KEYS */;
/*!40000 ALTER TABLE `mount_server` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `mounts`
--

DROP TABLE IF EXISTS `mounts`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mounts` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `uuid` char(36) NOT NULL,
  `name` varchar(191) NOT NULL,
  `description` text DEFAULT NULL,
  `source` varchar(191) NOT NULL,
  `target` varchar(191) NOT NULL,
  `read_only` tinyint(3) unsigned NOT NULL,
  `user_mountable` tinyint(3) unsigned NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `mounts_id_unique` (`id`),
  UNIQUE KEY `mounts_uuid_unique` (`uuid`),
  UNIQUE KEY `mounts_name_unique` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `mounts`
--

LOCK TABLES `mounts` WRITE;
/*!40000 ALTER TABLE `mounts` DISABLE KEYS */;
/*!40000 ALTER TABLE `mounts` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `nests`
--

DROP TABLE IF EXISTS `nests`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `nests` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `uuid` char(36) NOT NULL,
  `author` char(191) NOT NULL,
  `name` varchar(191) NOT NULL,
  `description` text DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `services_uuid_unique` (`uuid`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `nests`
--

LOCK TABLES `nests` WRITE;
/*!40000 ALTER TABLE `nests` DISABLE KEYS */;
INSERT INTO `nests` VALUES (1,'16b968d0-29c1-4625-a946-d471db690035','support@pterodactyl.io','Minecraft','Minecraft - the classic game from Mojang. With support for Vanilla MC, Spigot, and many others!','2022-11-27 16:19:20','2022-11-27 16:19:20'),(2,'11c0c0ce-e266-4fe1-9dc7-f81d02808a95','support@pterodactyl.io','Source Engine','Includes support for most Source Dedicated Server games.','2022-11-27 16:19:20','2022-11-27 16:19:20'),(3,'764fb7e1-62bd-4115-84b8-d822d4d3c59c','support@pterodactyl.io','Voice Servers','Voice servers such as Mumble and Teamspeak 3.','2022-11-27 16:19:20','2022-11-27 16:19:20'),(4,'14491acc-e063-4060-ae9f-21b0c99a2493','support@pterodactyl.io','Rust','Rust - A game where you must fight to survive.','2022-11-27 16:19:20','2022-11-27 16:19:20');
/*!40000 ALTER TABLE `nests` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `nodes`
--

DROP TABLE IF EXISTS `nodes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `nodes` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `uuid` char(36) NOT NULL,
  `public` smallint(5) unsigned NOT NULL,
  `name` varchar(191) NOT NULL,
  `description` text DEFAULT NULL,
  `location_id` int(10) unsigned NOT NULL,
  `fqdn` varchar(191) NOT NULL,
  `scheme` varchar(191) NOT NULL DEFAULT 'https',
  `behind_proxy` tinyint(1) NOT NULL DEFAULT 0,
  `maintenance_mode` tinyint(1) NOT NULL DEFAULT 0,
  `memory` int(10) unsigned NOT NULL,
  `memory_overallocate` int(11) NOT NULL DEFAULT 0,
  `disk` int(10) unsigned NOT NULL,
  `disk_overallocate` int(11) NOT NULL DEFAULT 0,
  `upload_size` int(10) unsigned NOT NULL DEFAULT 100,
  `daemon_token_id` char(16) NOT NULL,
  `daemon_token` text NOT NULL,
  `daemonListen` smallint(5) unsigned NOT NULL DEFAULT 8080,
  `daemonSFTP` smallint(5) unsigned NOT NULL DEFAULT 2022,
  `daemonBase` varchar(191) NOT NULL DEFAULT '/home/daemon-files',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `nodes_uuid_unique` (`uuid`),
  UNIQUE KEY `nodes_daemon_token_id_unique` (`daemon_token_id`),
  KEY `nodes_location_id_foreign` (`location_id`),
  CONSTRAINT `nodes_location_id_foreign` FOREIGN KEY (`location_id`) REFERENCES `locations` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `nodes`
--

LOCK TABLES `nodes` WRITE;
/*!40000 ALTER TABLE `nodes` DISABLE KEYS */;
INSERT INTO `nodes` VALUES (1,'6a92554f-c06e-43ae-9935-3d4550dfa1c7',1,'Node test',NULL,1,'127.0.0.1','https',0,0,100,80,100,80,100,'Xdezy80zeV1wrFJg','eyJpdiI6IlRhdkh2cmpSeVljaitxYy9GcHBjOFE9PSIsInZhbHVlIjoieHJacksyL1VmcDlhNlhzS29Gc0ZBb0Q0Tm81dDFrMmc2OVhQb0JmVUw5QkJvbk5RemFHNVh2OUtpSm1ZdFc4eDdIcmRSUFIrUmo2RkFzRVZ0RzJIK1dLeEM1RWlsaGdCOEQ4YW5uN1E0YlU9IiwibWFjIjoiZmQ2ZjdiN2ZkZjJjMWVkNGM4Zjc5ZGRiYzgyNjgyYjMxMDk1MWVhOGRkNDc4YmRjNzhmYmJkMThhMGI4NDFkYiIsInRhZyI6IiJ9',8080,2022,'/var/lib/pterodactyl/volumes','2022-12-03 10:33:14','2022-12-03 15:16:57');
/*!40000 ALTER TABLE `nodes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `notifications`
--

DROP TABLE IF EXISTS `notifications`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `notifications` (
  `id` varchar(191) NOT NULL,
  `type` varchar(191) NOT NULL,
  `notifiable_type` varchar(191) NOT NULL,
  `notifiable_id` bigint(20) unsigned NOT NULL,
  `data` text NOT NULL,
  `read_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `notifications_notifiable_type_notifiable_id_index` (`notifiable_type`,`notifiable_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `notifications`
--

LOCK TABLES `notifications` WRITE;
/*!40000 ALTER TABLE `notifications` DISABLE KEYS */;
/*!40000 ALTER TABLE `notifications` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `password_resets`
--

DROP TABLE IF EXISTS `password_resets`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `password_resets` (
  `email` varchar(191) NOT NULL,
  `token` varchar(191) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  KEY `password_resets_email_index` (`email`),
  KEY `password_resets_token_index` (`token`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `password_resets`
--

LOCK TABLES `password_resets` WRITE;
/*!40000 ALTER TABLE `password_resets` DISABLE KEYS */;
/*!40000 ALTER TABLE `password_resets` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `recovery_tokens`
--

DROP TABLE IF EXISTS `recovery_tokens`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `recovery_tokens` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` int(10) unsigned NOT NULL,
  `token` varchar(191) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `recovery_tokens_user_id_foreign` (`user_id`),
  CONSTRAINT `recovery_tokens_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `recovery_tokens`
--

LOCK TABLES `recovery_tokens` WRITE;
/*!40000 ALTER TABLE `recovery_tokens` DISABLE KEYS */;
/*!40000 ALTER TABLE `recovery_tokens` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `schedules`
--

DROP TABLE IF EXISTS `schedules`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `schedules` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `server_id` int(10) unsigned NOT NULL,
  `name` varchar(191) NOT NULL,
  `cron_day_of_week` varchar(191) NOT NULL,
  `cron_month` varchar(191) NOT NULL,
  `cron_day_of_month` varchar(191) NOT NULL,
  `cron_hour` varchar(191) NOT NULL,
  `cron_minute` varchar(191) NOT NULL,
  `is_active` tinyint(1) NOT NULL,
  `is_processing` tinyint(1) NOT NULL,
  `only_when_online` tinyint(3) unsigned NOT NULL DEFAULT 0,
  `last_run_at` timestamp NULL DEFAULT NULL,
  `next_run_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `schedules_server_id_foreign` (`server_id`),
  CONSTRAINT `schedules_server_id_foreign` FOREIGN KEY (`server_id`) REFERENCES `servers` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `schedules`
--

LOCK TABLES `schedules` WRITE;
/*!40000 ALTER TABLE `schedules` DISABLE KEYS */;
/*!40000 ALTER TABLE `schedules` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `server_transfers`
--

DROP TABLE IF EXISTS `server_transfers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `server_transfers` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `server_id` int(10) unsigned NOT NULL,
  `successful` tinyint(1) DEFAULT NULL,
  `old_node` int(10) unsigned NOT NULL,
  `new_node` int(10) unsigned NOT NULL,
  `old_allocation` int(10) unsigned NOT NULL,
  `new_allocation` int(10) unsigned NOT NULL,
  `old_additional_allocations` longtext DEFAULT NULL COMMENT '(DC2Type:json)',
  `new_additional_allocations` longtext DEFAULT NULL COMMENT '(DC2Type:json)',
  `archived` tinyint(1) NOT NULL DEFAULT 0,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `server_transfers_server_id_foreign` (`server_id`),
  CONSTRAINT `server_transfers_server_id_foreign` FOREIGN KEY (`server_id`) REFERENCES `servers` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `server_transfers`
--

LOCK TABLES `server_transfers` WRITE;
/*!40000 ALTER TABLE `server_transfers` DISABLE KEYS */;
/*!40000 ALTER TABLE `server_transfers` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `server_variables`
--

DROP TABLE IF EXISTS `server_variables`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `server_variables` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `server_id` int(10) unsigned DEFAULT NULL,
  `variable_id` int(10) unsigned NOT NULL,
  `variable_value` text NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `server_variables_server_id_foreign` (`server_id`),
  KEY `server_variables_variable_id_foreign` (`variable_id`),
  CONSTRAINT `server_variables_server_id_foreign` FOREIGN KEY (`server_id`) REFERENCES `servers` (`id`) ON DELETE CASCADE,
  CONSTRAINT `server_variables_variable_id_foreign` FOREIGN KEY (`variable_id`) REFERENCES `egg_variables` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `server_variables`
--

LOCK TABLES `server_variables` WRITE;
/*!40000 ALTER TABLE `server_variables` DISABLE KEYS */;
/*!40000 ALTER TABLE `server_variables` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `servers`
--

DROP TABLE IF EXISTS `servers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `servers` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `external_id` varchar(191) DEFAULT NULL,
  `uuid` char(36) NOT NULL,
  `uuidShort` char(8) NOT NULL,
  `node_id` int(10) unsigned NOT NULL,
  `name` varchar(191) NOT NULL,
  `description` text NOT NULL,
  `status` varchar(191) DEFAULT NULL,
  `skip_scripts` tinyint(1) NOT NULL DEFAULT 0,
  `owner_id` int(10) unsigned NOT NULL,
  `memory` int(10) unsigned NOT NULL,
  `swap` int(11) NOT NULL,
  `disk` int(10) unsigned NOT NULL,
  `io` int(10) unsigned NOT NULL,
  `cpu` int(10) unsigned NOT NULL,
  `threads` varchar(191) DEFAULT NULL,
  `oom_disabled` tinyint(3) unsigned NOT NULL DEFAULT 0,
  `allocation_id` int(10) unsigned NOT NULL,
  `nest_id` int(10) unsigned NOT NULL,
  `egg_id` int(10) unsigned NOT NULL,
  `startup` text NOT NULL,
  `image` varchar(191) NOT NULL,
  `allocation_limit` int(10) unsigned DEFAULT NULL,
  `database_limit` int(10) unsigned DEFAULT 0,
  `backup_limit` int(10) unsigned NOT NULL DEFAULT 0,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `installed_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `servers_uuid_unique` (`uuid`),
  UNIQUE KEY `servers_uuidshort_unique` (`uuidShort`),
  UNIQUE KEY `servers_allocation_id_unique` (`allocation_id`),
  UNIQUE KEY `servers_external_id_unique` (`external_id`),
  KEY `servers_node_id_foreign` (`node_id`),
  KEY `servers_owner_id_foreign` (`owner_id`),
  KEY `servers_nest_id_foreign` (`nest_id`),
  KEY `servers_egg_id_foreign` (`egg_id`),
  CONSTRAINT `servers_allocation_id_foreign` FOREIGN KEY (`allocation_id`) REFERENCES `allocations` (`id`),
  CONSTRAINT `servers_egg_id_foreign` FOREIGN KEY (`egg_id`) REFERENCES `eggs` (`id`),
  CONSTRAINT `servers_nest_id_foreign` FOREIGN KEY (`nest_id`) REFERENCES `nests` (`id`),
  CONSTRAINT `servers_node_id_foreign` FOREIGN KEY (`node_id`) REFERENCES `nodes` (`id`),
  CONSTRAINT `servers_owner_id_foreign` FOREIGN KEY (`owner_id`) REFERENCES `users` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `servers`
--

LOCK TABLES `servers` WRITE;
/*!40000 ALTER TABLE `servers` DISABLE KEYS */;
/*!40000 ALTER TABLE `servers` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sessions`
--

DROP TABLE IF EXISTS `sessions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sessions` (
  `id` varchar(191) NOT NULL,
  `user_id` int(11) DEFAULT NULL,
  `ip_address` varchar(45) DEFAULT NULL,
  `user_agent` text DEFAULT NULL,
  `payload` text NOT NULL,
  `last_activity` int(11) NOT NULL,
  UNIQUE KEY `sessions_id_unique` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sessions`
--

LOCK TABLES `sessions` WRITE;
/*!40000 ALTER TABLE `sessions` DISABLE KEYS */;
/*!40000 ALTER TABLE `sessions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `settings`
--

DROP TABLE IF EXISTS `settings`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `settings` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `key` varchar(191) NOT NULL,
  `value` text NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `settings_key_unique` (`key`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `settings`
--

LOCK TABLES `settings` WRITE;
/*!40000 ALTER TABLE `settings` DISABLE KEYS */;
/*!40000 ALTER TABLE `settings` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `subusers`
--

DROP TABLE IF EXISTS `subusers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `subusers` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` int(10) unsigned NOT NULL,
  `server_id` int(10) unsigned NOT NULL,
  `permissions` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL CHECK (json_valid(`permissions`)),
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `subusers_user_id_foreign` (`user_id`),
  KEY `subusers_server_id_foreign` (`server_id`),
  CONSTRAINT `subusers_server_id_foreign` FOREIGN KEY (`server_id`) REFERENCES `servers` (`id`) ON DELETE CASCADE,
  CONSTRAINT `subusers_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `subusers`
--

LOCK TABLES `subusers` WRITE;
/*!40000 ALTER TABLE `subusers` DISABLE KEYS */;
/*!40000 ALTER TABLE `subusers` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tasks`
--

DROP TABLE IF EXISTS `tasks`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tasks` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `schedule_id` int(10) unsigned NOT NULL,
  `sequence_id` int(10) unsigned NOT NULL,
  `action` varchar(191) NOT NULL,
  `payload` text NOT NULL,
  `time_offset` int(10) unsigned NOT NULL,
  `is_queued` tinyint(1) NOT NULL,
  `continue_on_failure` tinyint(3) unsigned NOT NULL DEFAULT 0,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `tasks_schedule_id_sequence_id_index` (`schedule_id`,`sequence_id`),
  CONSTRAINT `tasks_schedule_id_foreign` FOREIGN KEY (`schedule_id`) REFERENCES `schedules` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tasks`
--

LOCK TABLES `tasks` WRITE;
/*!40000 ALTER TABLE `tasks` DISABLE KEYS */;
/*!40000 ALTER TABLE `tasks` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tasks_log`
--

DROP TABLE IF EXISTS `tasks_log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tasks_log` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `task_id` int(10) unsigned NOT NULL,
  `run_time` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `run_status` int(10) unsigned NOT NULL,
  `response` text NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tasks_log`
--

LOCK TABLES `tasks_log` WRITE;
/*!40000 ALTER TABLE `tasks_log` DISABLE KEYS */;
/*!40000 ALTER TABLE `tasks_log` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user_ssh_keys`
--

DROP TABLE IF EXISTS `user_ssh_keys`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `user_ssh_keys` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` int(10) unsigned NOT NULL,
  `name` varchar(191) NOT NULL,
  `fingerprint` varchar(191) NOT NULL,
  `public_key` text NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `user_ssh_keys_user_id_foreign` (`user_id`),
  CONSTRAINT `user_ssh_keys_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user_ssh_keys`
--

LOCK TABLES `user_ssh_keys` WRITE;
/*!40000 ALTER TABLE `user_ssh_keys` DISABLE KEYS */;
/*!40000 ALTER TABLE `user_ssh_keys` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `users` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `external_id` varchar(191) DEFAULT NULL,
  `uuid` char(36) NOT NULL,
  `username` varchar(191) NOT NULL,
  `email` varchar(191) NOT NULL,
  `name_first` varchar(191) DEFAULT NULL,
  `name_last` varchar(191) DEFAULT NULL,
  `password` text NOT NULL,
  `remember_token` varchar(191) DEFAULT NULL,
  `language` char(5) NOT NULL DEFAULT 'en',
  `root_admin` tinyint(3) unsigned NOT NULL DEFAULT 0,
  `use_totp` tinyint(3) unsigned NOT NULL,
  `totp_secret` text DEFAULT NULL,
  `totp_authenticated_at` timestamp NULL DEFAULT NULL,
  `gravatar` tinyint(1) NOT NULL DEFAULT 1,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `users_uuid_unique` (`uuid`),
  UNIQUE KEY `users_email_unique` (`email`),
  UNIQUE KEY `users_username_unique` (`username`),
  KEY `users_external_id_index` (`external_id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` VALUES (1,NULL,'8a5b7ab6-5b51-4e19-bce7-0b65019758f2','phatnguyen','phatnguyentan0491@gmail.com','phat','nguyen','$2y$10$Giumk1xTvAcJGw0laJ6CNeT/4645257Bei9lhP05RkfmYNZQdwFxS',NULL,'en',1,0,NULL,NULL,1,'2022-11-27 16:36:08','2022-11-30 14:07:41'),(2,NULL,'1e0d6f43-d1e7-48d2-a2e1-915be6881708','tanphat','tanphat082@gmail.com','phat','tan','$2y$10$nH18nWXJ.cnpiduOOSUz1epNbFZ.MZAnCZvdT.IyQGqAeQIEbOnL6','lKTt4KZXmrawnSQ9kgYXEWIzKkJv01xnx3zM0bPNAViirdvRUOud590ek1Hx','en',1,0,NULL,NULL,1,'2022-11-27 16:42:11','2022-11-27 16:42:11');
/*!40000 ALTER TABLE `users` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2022-12-04 10:49:00
