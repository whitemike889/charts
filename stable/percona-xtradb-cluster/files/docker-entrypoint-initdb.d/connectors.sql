-- Copyright (C) 2007-2011, GoodData(R) Corporation. All rights reserved.
-- MySQL dump 10.11
--
-- Host: localhost    Database: connectors
-- ------------------------------------------------------
-- Server version	5.0.84-log

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

DROP TABLE IF EXISTS `connector_zendesk4`;
DROP TABLE IF EXISTS `connector_zendesk4_endpoint`;
DROP TABLE IF EXISTS `connector_zendesk4_persistence`;
DROP TABLE IF EXISTS `connector_zendesk4_reload`;
DROP TABLE IF EXISTS `connector_zendesk4_batch`;
DROP TABLE IF EXISTS `connector_zendesk4_task`;
DROP TABLE IF EXISTS `connector_pardot`;
DROP TABLE IF EXISTS `connector_pardot_entity`;
DROP TABLE IF EXISTS `connector_pardot_field`;
DROP TABLE IF EXISTS `connector_coupa`;
DROP TABLE IF EXISTS `connector_coupa_instance`;
DROP TABLE IF EXISTS `connector_coupa_custom_entity`;
DROP TABLE IF EXISTS `connector_coupa_custom_field`;
DROP TABLE IF EXISTS `integration`;
DROP TABLE IF EXISTS `log`;
DROP TABLE IF EXISTS `const`;


--
-- Table structure for table `integration`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `integration` (
  `id` int(11) NOT NULL auto_increment,
  `integration_type` ENUM('PARDOT','COUPA','ZENDESK4') NOT NULL,
  `active` int(1) NOT NULL default 1,
  `created_at` timestamp NOT NULL default '0000-00-00 00:00:00',
  `created_by` int(11) default NULL,
  `modified_at` timestamp NOT NULL default CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP,
  `modified_by` int(11) default NULL,
  `uri` varchar(255) collate utf8_unicode_ci NOT NULL,
  `template_uri` varchar(255) collate utf8_unicode_ci NOT NULL,
  PRIMARY KEY  (`id`),
  INDEX (`uri`),
  UNIQUE KEY `unique_integration_type_per_project` (`integration_type`, `uri`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;
/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;


--
-- Table structure for table `const`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `const` (
  `name` varchar(255) collate utf8_unicode_ci NOT NULL,
  `value` varchar(255) collate utf8_unicode_ci NOT NULL,
  PRIMARY KEY  (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `const`
--

LOCK TABLES `const` WRITE;
/*!40000 ALTER TABLE `const` DISABLE KEYS */;
/*!40000 ALTER TABLE `const` ENABLE KEYS */;
INSERT INTO `const` VALUES ('create_time',CURRENT_TIMESTAMP),('dbClass','connectors'),('version','2.09');

UNLOCK TABLES;

--
-- Table structure for table `log`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `log` (
  `id` int(11) NOT NULL auto_increment,
  `message` text collate utf8_unicode_ci default NULL,
  `description` text collate utf8_unicode_ci default NULL,
  `state` varchar(255) collate utf8_unicode_ci default NULL,
  `process_id` varchar(255) collate utf8_unicode_ci NOT NULL,
  `time` datetime NOT NULL,
  `expires` datetime default NULL,
  `integration_id` int(11) NOT NULL,
  PRIMARY KEY  (`id`),
  INDEX (`process_id`),
  INDEX (`state`),
  INDEX (`expires`),
  CONSTRAINT FOREIGN KEY (`integration_id`) REFERENCES `integration` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `connector_zendesk4`
--

CREATE TABLE `connector_zendesk4` (
  `id` int(11) NOT NULL auto_increment,
  `api_url` varchar(255) collate utf8_unicode_ci,
  `zopim_url` varchar(255) collate utf8_unicode_ci,
  `account` varchar(255) collate utf8_unicode_ci,
  `sync_time` varchar(255) NOT NULL collate utf8_unicode_ci,
  `sync_time_zone` varchar(255) NOT NULL collate utf8_unicode_ci,
  `overridden` int(1) NOT NULL default 0,
  `enterprise_load_interval_minutes` int NOT NULL DEFAULT 60,
  `account_type` varchar(255) NOT NULL DEFAULT 'plus',
  `created_from` varchar(255) collate utf8_unicode_ci,
  `backlog_synchronized` int(1) NOT NULL default 1,
  `large_project` int(1) NOT NULL DEFAULT 0,
  `parallel_downloads` int NULL DEFAULT NULL,
  `parallel_download_batch_seconds` int NULL DEFAULT NULL,
  `last_tickets_start_time` bigint NULL DEFAULT NULL,
  `last_ticket_events_start_time` bigint NULL DEFAULT NULL,
  `last_organizations_start_time` bigint NULL DEFAULT NULL,
  `last_users_start_time` bigint NULL DEFAULT NULL,
  `last_responses_start_time` bigint NULL DEFAULT NULL,
  `last_ticket_metric_events_start_time` bigint NULL DEFAULT NULL,
  `last_calls_start_time` bigint NULL DEFAULT NULL,
  `last_legs_start_time` bigint NULL DEFAULT NULL,
  `last_automatic_answers_start_time` bigint NULL DEFAULT NULL,
  `last_knowledge_capture_events_start_time` bigint NULL DEFAULT NULL,
  `last_knowledge_events_start_time` bigint NULL DEFAULT NULL,
  `last_chats_start_time` bigint NULL DEFAULT NULL,
  `last_agent_timeline_start_time` bigint NULL DEFAULT NULL,
  `integration_id` int(11) NOT NULL,
  PRIMARY KEY  (`id`),
  CONSTRAINT `zendesk4_integration_id` FOREIGN KEY (integration_id) REFERENCES integration(id) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Table structure for table `connector_zendesk4_persistence`
--

CREATE TABLE `connector_zendesk4_endpoint` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `expr` varchar(255) NOT NULL COLLATE utf8_unicode_ci,
  `api_key` varchar(255) NOT NULL COLLATE utf8_unicode_ci,
  `zopim_id` varchar(255) COLLATE utf8_unicode_ci,
  `api_call_interval_millis` bigint,
  `retries_count` int(11),
  `window_timeout_seconds` int(11),
  `conn_request_timeout` int(11),
  `conn_timeout` int(11),
  `socket_timeout` int(11),
  `max_parallel_downloads` int(11),
  `use_api_proxy` boolean DEFAULT FALSE,
  PRIMARY KEY (`id`),
  UNIQUE KEY `expr` (`expr`, `zopim_id`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

CREATE TABLE `connector_zendesk4_persistence` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `expr` varchar(255) NOT NULL COLLATE utf8_unicode_ci,
  `priority` smallint DEFAULT NULL,
  `url` varchar(255) NOT NULL COLLATE utf8_unicode_ci,
  `username` varchar(255) NOT NULL COLLATE utf8_unicode_ci,
  `password` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `dbschema` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `expr` (`expr`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Table structures for zendesk4 reloads
--
CREATE TABLE `connector_zendesk4_reload_task` (
  `id` int(11) NOT NULL auto_increment,
  `name` varchar(255) collate utf8_unicode_ci NOT NULL,
  `description` text collate utf8_unicode_ci default NULL,
  `tickets_start_time` bigint NULL DEFAULT NULL,
  `ticket_events_start_time` bigint NULL DEFAULT NULL,
  `organizations_start_time` bigint NULL DEFAULT NULL,
  `users_start_time` bigint NULL DEFAULT NULL,
  `responses_start_time` bigint NULL DEFAULT NULL,
  `ticket_metric_events_start_time` bigint NULL DEFAULT NULL,
  `calls_start_time` bigint NULL DEFAULT NULL,
  `legs_start_time` bigint NULL DEFAULT NULL,
  `automatic_answers_start_time` bigint NULL DEFAULT NULL,
  `knowledge_capture_events_start_time` bigint NULL DEFAULT NULL,
  `knowledge_events_start_time` bigint NULL DEFAULT NULL,
  `chats_start_time` bigint NULL DEFAULT NULL,
  `agent_timeline_start_time` bigint NULL DEFAULT NULL,
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

CREATE TABLE `connector_zendesk4_reload_batch` (
  `id` int(11) NOT NULL auto_increment,
  `task_id` int(11) NOT NULL,
  `name` varchar(255) collate utf8_unicode_ci NOT NULL,
  `window_from` timestamp NULL DEFAULT NULL,
  `window_to` timestamp NULL DEFAULT NULL,
  `due_date` timestamp NULL DEFAULT NULL,
  PRIMARY KEY  (`id`),
  CONSTRAINT `reload_task_id` FOREIGN KEY (task_id) REFERENCES connector_zendesk4_reload_task(id) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

CREATE TABLE `connector_zendesk4_reload` (
  `id` int(11) NOT NULL auto_increment,
  `zendesk4_id` int(11) NOT NULL,
  `batch_id` int(11) NOT NULL,
  `status` varchar(255) collate utf8_unicode_ci NOT NULL,
  `process_id` varchar(255) collate utf8_unicode_ci NULL DEFAULT NULL,
  `parallel_downloads` int NULL DEFAULT NULL,
  `parallel_download_batch_seconds` int NULL DEFAULT NULL,
  `use_s3_download` BOOLEAN NOT NULL DEFAULT FALSE,
  PRIMARY KEY  (`id`),
  CONSTRAINT `zendesk4_id` FOREIGN KEY (zendesk4_id) REFERENCES connector_zendesk4(id) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `reload_batch_id` FOREIGN KEY (batch_id) REFERENCES connector_zendesk4_reload_batch(id) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

CREATE TABLE `connector_zendesk4_download` (
  `id` int(11) NOT NULL auto_increment,
  `api_url` varchar(255) collate utf8_unicode_ci UNIQUE NOT NULL,
  `parallel_downloads` int NULL DEFAULT NULL,
  `parallel_download_batch_seconds` int NULL DEFAULT NULL,
  `enabled` BOOLEAN NOT NULL DEFAULT TRUE,
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

CREATE TABLE `connector_zendesk4_download_part` (
  `id` int(11) NOT NULL auto_increment,
  `download_file` varchar(255) collate utf8_unicode_ci NOT NULL,
  `download_from` bigint NOT NULL,
  `download_to` bigint NOT NULL,
  `download_id` int(11) NOT NULL,
  PRIMARY KEY  (`id`),
  CONSTRAINT `download_id` FOREIGN KEY (download_id) REFERENCES connector_zendesk4_download(id) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

CREATE TABLE `connector_zendesk4_download_start_time` (
  `id` int(11) NOT NULL auto_increment,
  `start_time` bigint NULL DEFAULT NULL,
  `name` varchar(255) collate utf8_unicode_ci NOT NULL,
  `download_part_id` int(11) NOT NULL,
  PRIMARY KEY  (`id`),
  UNIQUE `unique_index`(`download_part_id`, `name`),
  CONSTRAINT `download_part_id` FOREIGN KEY (download_part_id) REFERENCES connector_zendesk4_download_part(id) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `connector_pardot` (
  `id` int(11) NOT NULL auto_increment,
  `account_id` varchar(255) collate utf8_unicode_ci,
  `s3_location` varchar(255) collate utf8_unicode_ci,
  `integration_id` int(11) NOT NULL,
  PRIMARY KEY  (`id`),
  CONSTRAINT `pardot_integration_id` FOREIGN KEY (integration_id) REFERENCES integration(id) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

CREATE TABLE `connector_pardot_entity` (
  `id` int(11) NOT NULL auto_increment,
  `pardot_id` int(11) NOT NULL,
  `name` varchar(255) collate utf8_unicode_ci,
  PRIMARY KEY  (`id`),
  CONSTRAINT `pardot_id` FOREIGN KEY (pardot_id) REFERENCES connector_pardot(id) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

CREATE TABLE `connector_pardot_field` (
  `id` int(11) NOT NULL auto_increment,
  `pardot_entity_id` int(11) NOT NULL,
  `custom_field_id` varchar(255) collate utf8_unicode_ci,
  `label` varchar(255) collate utf8_unicode_ci,
  `name` varchar(255) collate utf8_unicode_ci,
  `ldm_type` varchar(255) collate utf8_unicode_ci,
  PRIMARY KEY  (`id`),
  CONSTRAINT `pardot_entity_id` FOREIGN KEY (pardot_entity_id) REFERENCES connector_pardot_entity(id) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

CREATE TABLE `connector_coupa` (
  `id` int(11) NOT NULL auto_increment,
  `integration_id` int(11) NOT NULL,
  `timezone` varchar(255) collate utf8_unicode_ci,
  `modified_at` timestamp NULL,
  PRIMARY KEY  (`id`),
  CONSTRAINT `coupa_integration_id` FOREIGN KEY (integration_id) REFERENCES integration(id) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

CREATE TABLE `connector_coupa_instance` (
  `id` int(11) NOT NULL auto_increment,
  `coupa_id` int(11) NOT NULL,
  `name` varchar(255) collate utf8_unicode_ci,
  `api_url` varchar(255) collate utf8_unicode_ci,
  `api_key` varchar(255) collate utf8_unicode_ci,
  PRIMARY KEY  (`id`),
  CONSTRAINT `coupa_id` FOREIGN KEY (coupa_id) REFERENCES connector_coupa(id) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

CREATE TABLE `connector_coupa_custom_entity` (
  `id` int(11) NOT NULL auto_increment,
  `coupa_id` int(11) NOT NULL,
  `name` varchar(255) NOT NULL collate utf8_unicode_ci,
  `dataset` varchar(255) NOT NULL collate utf8_unicode_ci,
  `modified_at` timestamp NOT NULL,
  PRIMARY KEY  (`id`),
  CONSTRAINT `connector_coupa_id` FOREIGN KEY (coupa_id) REFERENCES connector_coupa(id) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

CREATE TABLE `connector_coupa_custom_field` (
  `id` int(11) NOT NULL auto_increment,
  `entity_id` int(11) NOT NULL,
  `name` varchar(255) NOT NULL collate utf8_unicode_ci,
  `xml_path` varchar(255) NOT NULL collate utf8_unicode_ci,
  PRIMARY KEY  (`id`),
  CONSTRAINT `entity_id` FOREIGN KEY (entity_id) REFERENCES connector_coupa_custom_entity(id) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
