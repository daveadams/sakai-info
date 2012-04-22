-- mysql-auto-2.7.2.sql
--   dump file from auto-generated Sakai 2.7.2 schema
--
-- Generated 2012-04-22 daveadams@gmail.com
--
-- MySQL dump 10.13  Distrib 5.1.61, for debian-linux-gnu (x86_64)
-- ------------------------------------------------------
-- Server version	5.1.61-0ubuntu0.10.04.1

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
-- Table structure for table `announcement_channel`
--

DROP TABLE IF EXISTS `announcement_channel`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `announcement_channel` (
  `CHANNEL_ID` varchar(255) NOT NULL,
  `NEXT_ID` int(11) DEFAULT NULL,
  `XML` longtext,
  UNIQUE KEY `ANNOUNCEMENT_CHANNEL_INDEX` (`CHANNEL_ID`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `announcement_channel`
--

LOCK TABLES `announcement_channel` WRITE;
/*!40000 ALTER TABLE `announcement_channel` DISABLE KEYS */;
/*!40000 ALTER TABLE `announcement_channel` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `announcement_message`
--

DROP TABLE IF EXISTS `announcement_message`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `announcement_message` (
  `CHANNEL_ID` varchar(255) NOT NULL,
  `MESSAGE_ID` varchar(36) NOT NULL,
  `DRAFT` char(1) DEFAULT NULL,
  `PUBVIEW` char(1) DEFAULT NULL,
  `OWNER` varchar(99) DEFAULT NULL,
  `MESSAGE_DATE` datetime NOT NULL,
  `XML` longtext,
  PRIMARY KEY (`CHANNEL_ID`,`MESSAGE_ID`),
  KEY `IE_ANNC_MSG_CHANNEL` (`CHANNEL_ID`),
  KEY `IE_ANNC_MSG_ATTRIB` (`DRAFT`,`PUBVIEW`,`OWNER`),
  KEY `IE_ANNC_MSG_DATE` (`MESSAGE_DATE`),
  KEY `IE_ANNC_MSG_DATE_DESC` (`MESSAGE_DATE`),
  KEY `ANNOUNCEMENT_MESSAGE_CDD` (`CHANNEL_ID`,`MESSAGE_DATE`,`DRAFT`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `announcement_message`
--

LOCK TABLES `announcement_message` WRITE;
/*!40000 ALTER TABLE `announcement_message` DISABLE KEYS */;
/*!40000 ALTER TABLE `announcement_message` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `asn_ap_item_access_t`
--

DROP TABLE IF EXISTS `asn_ap_item_access_t`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `asn_ap_item_access_t` (
  `ID` bigint(20) NOT NULL AUTO_INCREMENT,
  `ITEM_ACCESS` varchar(255) DEFAULT NULL,
  `ASN_AP_ITEM_ID` bigint(20) NOT NULL,
  PRIMARY KEY (`ID`),
  UNIQUE KEY `ITEM_ACCESS` (`ITEM_ACCESS`,`ASN_AP_ITEM_ID`),
  KEY `FK573733586E844C61` (`ASN_AP_ITEM_ID`),
  CONSTRAINT `FK573733586E844C61` FOREIGN KEY (`ASN_AP_ITEM_ID`) REFERENCES `asn_ap_item_t` (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `asn_ap_item_access_t`
--

LOCK TABLES `asn_ap_item_access_t` WRITE;
/*!40000 ALTER TABLE `asn_ap_item_access_t` DISABLE KEYS */;
/*!40000 ALTER TABLE `asn_ap_item_access_t` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `asn_ap_item_t`
--

DROP TABLE IF EXISTS `asn_ap_item_t`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `asn_ap_item_t` (
  `ID` bigint(20) NOT NULL,
  `ASSIGNMENT_ID` varchar(255) DEFAULT NULL,
  `TITLE` varchar(255) DEFAULT NULL,
  `TEXT` text,
  `RELEASE_DATE` datetime DEFAULT NULL,
  `RETRACT_DATE` datetime DEFAULT NULL,
  `HIDE` bit(1) DEFAULT NULL,
  PRIMARY KEY (`ID`),
  KEY `FK514CEE15935EEE07` (`ID`),
  CONSTRAINT `FK514CEE15935EEE07` FOREIGN KEY (`ID`) REFERENCES `asn_sup_item_t` (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `asn_ap_item_t`
--

LOCK TABLES `asn_ap_item_t` WRITE;
/*!40000 ALTER TABLE `asn_ap_item_t` DISABLE KEYS */;
/*!40000 ALTER TABLE `asn_ap_item_t` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `asn_ma_item_t`
--

DROP TABLE IF EXISTS `asn_ma_item_t`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `asn_ma_item_t` (
  `ID` bigint(20) NOT NULL,
  `ASSIGNMENT_ID` varchar(255) DEFAULT NULL,
  `TEXT` text,
  `SHOW_TO` int(11) DEFAULT NULL,
  PRIMARY KEY (`ID`),
  KEY `FK2E508110935EEE07` (`ID`),
  CONSTRAINT `FK2E508110935EEE07` FOREIGN KEY (`ID`) REFERENCES `asn_sup_item_t` (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `asn_ma_item_t`
--

LOCK TABLES `asn_ma_item_t` WRITE;
/*!40000 ALTER TABLE `asn_ma_item_t` DISABLE KEYS */;
/*!40000 ALTER TABLE `asn_ma_item_t` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `asn_note_item_t`
--

DROP TABLE IF EXISTS `asn_note_item_t`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `asn_note_item_t` (
  `ID` bigint(20) NOT NULL AUTO_INCREMENT,
  `ASSIGNMENT_ID` varchar(255) DEFAULT NULL,
  `NOTE` text,
  `CREATOR_ID` varchar(255) DEFAULT NULL,
  `SHARE_WITH` int(11) DEFAULT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `asn_note_item_t`
--

LOCK TABLES `asn_note_item_t` WRITE;
/*!40000 ALTER TABLE `asn_note_item_t` DISABLE KEYS */;
/*!40000 ALTER TABLE `asn_note_item_t` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `asn_sup_attach_t`
--

DROP TABLE IF EXISTS `asn_sup_attach_t`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `asn_sup_attach_t` (
  `ID` bigint(20) NOT NULL AUTO_INCREMENT,
  `ATTACHMENT_ID` varchar(255) DEFAULT NULL,
  `ASN_SUP_ITEM_ID` bigint(20) NOT NULL,
  PRIMARY KEY (`ID`),
  UNIQUE KEY `ATTACHMENT_ID` (`ATTACHMENT_ID`,`ASN_SUP_ITEM_ID`),
  KEY `FK560294CEDE4CD07F` (`ASN_SUP_ITEM_ID`),
  CONSTRAINT `FK560294CEDE4CD07F` FOREIGN KEY (`ASN_SUP_ITEM_ID`) REFERENCES `asn_sup_item_t` (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='This table is for assignment supplement item attachment.';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `asn_sup_attach_t`
--

LOCK TABLES `asn_sup_attach_t` WRITE;
/*!40000 ALTER TABLE `asn_sup_attach_t` DISABLE KEYS */;
/*!40000 ALTER TABLE `asn_sup_attach_t` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `asn_sup_item_t`
--

DROP TABLE IF EXISTS `asn_sup_item_t`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `asn_sup_item_t` (
  `ID` bigint(20) NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `asn_sup_item_t`
--

LOCK TABLES `asn_sup_item_t` WRITE;
/*!40000 ALTER TABLE `asn_sup_item_t` DISABLE KEYS */;
/*!40000 ALTER TABLE `asn_sup_item_t` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `assignment_assignment`
--

DROP TABLE IF EXISTS `assignment_assignment`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `assignment_assignment` (
  `ASSIGNMENT_ID` varchar(99) NOT NULL,
  `CONTEXT` varchar(99) DEFAULT NULL,
  `XML` longtext,
  UNIQUE KEY `ASSIGNMENT_ASSIGNMENT_INDEX` (`ASSIGNMENT_ID`),
  KEY `ASSIGNMENT_ASSIGNMENT_CONTEXT` (`CONTEXT`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `assignment_assignment`
--

LOCK TABLES `assignment_assignment` WRITE;
/*!40000 ALTER TABLE `assignment_assignment` DISABLE KEYS */;
/*!40000 ALTER TABLE `assignment_assignment` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `assignment_content`
--

DROP TABLE IF EXISTS `assignment_content`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `assignment_content` (
  `CONTENT_ID` varchar(99) NOT NULL,
  `CONTEXT` varchar(99) DEFAULT NULL,
  `XML` longtext,
  UNIQUE KEY `ASSIGNMENT_CONTENT_INDEX` (`CONTENT_ID`),
  KEY `ASSIGNMENT_CONTENT_CONTEXT` (`CONTEXT`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `assignment_content`
--

LOCK TABLES `assignment_content` WRITE;
/*!40000 ALTER TABLE `assignment_content` DISABLE KEYS */;
/*!40000 ALTER TABLE `assignment_content` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `assignment_submission`
--

DROP TABLE IF EXISTS `assignment_submission`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `assignment_submission` (
  `SUBMISSION_ID` varchar(99) NOT NULL,
  `CONTEXT` varchar(99) NOT NULL,
  `SUBMITTER_ID` varchar(99) NOT NULL,
  `SUBMIT_TIME` varchar(99) DEFAULT NULL,
  `SUBMITTED` varchar(6) DEFAULT NULL,
  `GRADED` varchar(6) DEFAULT NULL,
  `XML` longtext,
  UNIQUE KEY `ASSIGNMENT_SUBMISSION_INDEX` (`SUBMISSION_ID`),
  UNIQUE KEY `ASSIGNMENT_SUBMISSION_SUBMITTER_INDEX` (`CONTEXT`,`SUBMITTER_ID`),
  KEY `ASSIGNMENT_SUBMISSION_CONTEXT` (`CONTEXT`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `assignment_submission`
--

LOCK TABLES `assignment_submission` WRITE;
/*!40000 ALTER TABLE `assignment_submission` DISABLE KEYS */;
/*!40000 ALTER TABLE `assignment_submission` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `calendar_calendar`
--

DROP TABLE IF EXISTS `calendar_calendar`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `calendar_calendar` (
  `CALENDAR_ID` varchar(99) NOT NULL,
  `NEXT_ID` int(11) DEFAULT NULL,
  `XML` longtext,
  UNIQUE KEY `CALENDAR_CALENDAR_INDEX` (`CALENDAR_ID`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `calendar_calendar`
--

LOCK TABLES `calendar_calendar` WRITE;
/*!40000 ALTER TABLE `calendar_calendar` DISABLE KEYS */;
/*!40000 ALTER TABLE `calendar_calendar` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `calendar_event`
--

DROP TABLE IF EXISTS `calendar_event`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `calendar_event` (
  `CALENDAR_ID` varchar(99) NOT NULL,
  `EVENT_ID` varchar(36) NOT NULL,
  `EVENT_START` datetime NOT NULL,
  `EVENT_END` datetime NOT NULL,
  `RANGE_START` int(11) NOT NULL,
  `RANGE_END` int(11) NOT NULL,
  `XML` longtext,
  UNIQUE KEY `EVENT_INDEX` (`EVENT_ID`),
  KEY `CALENDAR_EVENT_INDEX` (`CALENDAR_ID`),
  KEY `CALENDAR_EVENT_RSTART` (`RANGE_START`),
  KEY `CALENDAR_EVENT_REND` (`RANGE_END`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `calendar_event`
--

LOCK TABLES `calendar_event` WRITE;
/*!40000 ALTER TABLE `calendar_event` DISABLE KEYS */;
/*!40000 ALTER TABLE `calendar_event` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `chat2_channel`
--

DROP TABLE IF EXISTS `chat2_channel`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `chat2_channel` (
  `CHANNEL_ID` varchar(99) NOT NULL,
  `PLACEMENT_ID` varchar(99) DEFAULT NULL,
  `CONTEXT` varchar(99) NOT NULL,
  `CREATION_DATE` datetime DEFAULT NULL,
  `title` varchar(64) DEFAULT NULL,
  `description` varchar(255) DEFAULT NULL,
  `filterType` varchar(25) DEFAULT NULL,
  `filterParam` int(11) DEFAULT NULL,
  `timeParam` int(11) NOT NULL,
  `numberParam` int(11) NOT NULL,
  `placementDefaultChannel` bit(1) DEFAULT NULL,
  `ENABLE_USER_OVERRIDE` bit(1) DEFAULT NULL,
  `migratedChannelId` varchar(99) DEFAULT NULL,
  PRIMARY KEY (`CHANNEL_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='This table stores chat channels';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `chat2_channel`
--

LOCK TABLES `chat2_channel` WRITE;
/*!40000 ALTER TABLE `chat2_channel` DISABLE KEYS */;
/*!40000 ALTER TABLE `chat2_channel` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `chat2_message`
--

DROP TABLE IF EXISTS `chat2_message`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `chat2_message` (
  `MESSAGE_ID` varchar(99) NOT NULL,
  `CHANNEL_ID` varchar(99) DEFAULT NULL,
  `OWNER` varchar(96) NOT NULL,
  `MESSAGE_DATE` datetime DEFAULT NULL,
  `BODY` text NOT NULL,
  `migratedMessageId` varchar(99) DEFAULT NULL,
  PRIMARY KEY (`MESSAGE_ID`),
  KEY `FK720F9882555E0B79` (`CHANNEL_ID`),
  CONSTRAINT `FK720F9882555E0B79` FOREIGN KEY (`CHANNEL_ID`) REFERENCES `chat2_channel` (`CHANNEL_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='This table stores chat messages';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `chat2_message`
--

LOCK TABLES `chat2_message` WRITE;
/*!40000 ALTER TABLE `chat2_message` DISABLE KEYS */;
/*!40000 ALTER TABLE `chat2_message` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `citation_citation`
--

DROP TABLE IF EXISTS `citation_citation`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `citation_citation` (
  `CITATION_ID` varchar(36) NOT NULL,
  `PROPERTY_NAME` varchar(255) DEFAULT NULL,
  `PROPERTY_VALUE` longtext,
  KEY `CITATION_CITATION_INDEX` (`CITATION_ID`),
  KEY `CITATION_CITATION_INDEX2` (`CITATION_ID`,`PROPERTY_NAME`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `citation_citation`
--

LOCK TABLES `citation_citation` WRITE;
/*!40000 ALTER TABLE `citation_citation` DISABLE KEYS */;
/*!40000 ALTER TABLE `citation_citation` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `citation_collection`
--

DROP TABLE IF EXISTS `citation_collection`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `citation_collection` (
  `COLLECTION_ID` varchar(36) NOT NULL,
  `PROPERTY_NAME` varchar(255) DEFAULT NULL,
  `PROPERTY_VALUE` longtext,
  KEY `CITATION_COLLECTION_INDEX` (`COLLECTION_ID`),
  KEY `CITATION_COLLECTION_INDEX2` (`COLLECTION_ID`,`PROPERTY_NAME`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `citation_collection`
--

LOCK TABLES `citation_collection` WRITE;
/*!40000 ALTER TABLE `citation_collection` DISABLE KEYS */;
/*!40000 ALTER TABLE `citation_collection` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `citation_schema`
--

DROP TABLE IF EXISTS `citation_schema`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `citation_schema` (
  `SCHEMA_ID` varchar(36) NOT NULL,
  `PROPERTY_NAME` varchar(255) DEFAULT NULL,
  `PROPERTY_VALUE` longtext,
  KEY `CITATION_SCHEMA_INDEX` (`SCHEMA_ID`),
  KEY `CITATION_SCHEMA_INDEX2` (`SCHEMA_ID`,`PROPERTY_NAME`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `citation_schema`
--

LOCK TABLES `citation_schema` WRITE;
/*!40000 ALTER TABLE `citation_schema` DISABLE KEYS */;
INSERT INTO `citation_schema` VALUES ('unknown','sakai:hasField','creator'),('unknown','sakai:hasField','title'),('unknown','sakai:hasField','year'),('unknown','sakai:hasField','date'),('unknown','sakai:hasField','publisher'),('unknown','sakai:hasField','publicationLocation'),('unknown','sakai:hasField','volume'),('unknown','sakai:hasField','issue'),('unknown','sakai:hasField','pages'),('unknown','sakai:hasField','startPage'),('unknown','sakai:hasField','endPage'),('unknown','sakai:hasField','edition'),('unknown','sakai:hasField','editor'),('unknown','sakai:hasField','sourceTitle'),('unknown','sakai:hasField','Language'),('unknown','sakai:hasField','abstract'),('unknown','sakai:hasField','note'),('unknown','sakai:hasField','isnIdentifier'),('unknown','sakai:hasField','subject'),('unknown','sakai:hasField','locIdentifier'),('unknown','sakai:hasField','dateRetrieved'),('unknown','sakai:hasField','openURL'),('unknown','sakai:hasField','doi'),('unknown','sakai:hasField','rights'),('article','sakai:hasField','creator'),('article','sakai:hasField','title'),('article','sakai:hasField','sourceTitle'),('article','sakai:hasField','year'),('article','sakai:hasField','date'),('article','sakai:hasField','volume'),('article','sakai:hasField','issue'),('article','sakai:hasField','pages'),('article','sakai:hasField','startPage'),('article','sakai:hasField','endPage'),('article','sakai:hasField','abstract'),('article','sakai:hasField','note'),('article','sakai:hasField','isnIdentifier'),('article','sakai:hasField','subject'),('article','sakai:hasField','Language'),('article','sakai:hasField','locIdentifier'),('article','sakai:hasField','dateRetrieved'),('article','sakai:hasField','openURL'),('article','sakai:hasField','doi'),('article','sakai:hasField','rights'),('book','sakai:hasField','creator'),('book','sakai:hasField','title'),('book','sakai:hasField','year'),('book','sakai:hasField','date'),('book','sakai:hasField','publisher'),('book','sakai:hasField','publicationLocation'),('book','sakai:hasField','edition'),('book','sakai:hasField','editor'),('book','sakai:hasField','sourceTitle'),('book','sakai:hasField','abstract'),('book','sakai:hasField','note'),('book','sakai:hasField','isnIdentifier'),('book','sakai:hasField','subject'),('book','sakai:hasField','Language'),('book','sakai:hasField','locIdentifier'),('book','sakai:hasField','dateRetrieved'),('book','sakai:hasField','openURL'),('book','sakai:hasField','doi'),('book','sakai:hasField','rights'),('chapter','sakai:hasField','creator'),('chapter','sakai:hasField','title'),('chapter','sakai:hasField','year'),('chapter','sakai:hasField','date'),('chapter','sakai:hasField','publisher'),('chapter','sakai:hasField','publicationLocation'),('chapter','sakai:hasField','edition'),('chapter','sakai:hasField','editor'),('chapter','sakai:hasField','sourceTitle'),('chapter','sakai:hasField','pages'),('chapter','sakai:hasField','startPage'),('chapter','sakai:hasField','endPage'),('chapter','sakai:hasField','abstract'),('chapter','sakai:hasField','note'),('chapter','sakai:hasField','isnIdentifier'),('chapter','sakai:hasField','subject'),('chapter','sakai:hasField','Language'),('chapter','sakai:hasField','locIdentifier'),('chapter','sakai:hasField','dateRetrieved'),('chapter','sakai:hasField','openURL'),('chapter','sakai:hasField','doi'),('chapter','sakai:hasField','rights'),('report','sakai:hasField','creator'),('report','sakai:hasField','title'),('report','sakai:hasField','year'),('report','sakai:hasField','date'),('report','sakai:hasField','publisher'),('report','sakai:hasField','publicationLocation'),('report','sakai:hasField','editor'),('report','sakai:hasField','edition'),('report','sakai:hasField','sourceTitle'),('report','sakai:hasField','pages'),('report','sakai:hasField','abstract'),('report','sakai:hasField','isnIdentifier'),('report','sakai:hasField','note'),('report','sakai:hasField','subject'),('report','sakai:hasField','Language'),('report','sakai:hasField','locIdentifier'),('report','sakai:hasField','dateRetrieved'),('report','sakai:hasField','openURL'),('report','sakai:hasField','doi'),('report','sakai:hasField','rights'),('proceed','sakai:hasField','creator'),('proceed','sakai:hasField','title'),('proceed','sakai:hasField','year'),('proceed','sakai:hasField','volume'),('proceed','sakai:hasField','pages'),('proceed','sakai:hasField','sourceTitle'),('proceed','sakai:hasField','note'),('electronic','sakai:hasField','title'),('electronic','sakai:hasField','year'),('electronic','sakai:hasField','sourceTitle'),('electronic','sakai:hasField','abstract'),('electronic','sakai:hasField','subject'),('thesis','sakai:hasField','creator'),('thesis','sakai:hasField','title'),('thesis','sakai:hasField','year'),('thesis','sakai:hasField','publisher'),('thesis','sakai:hasField','pages'),('thesis','sakai:hasField','note'),('thesis','sakai:hasField','subject');
/*!40000 ALTER TABLE `citation_schema` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `citation_schema_field`
--

DROP TABLE IF EXISTS `citation_schema_field`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `citation_schema_field` (
  `SCHEMA_ID` varchar(36) NOT NULL,
  `FIELD_ID` varchar(36) NOT NULL,
  `PROPERTY_NAME` varchar(255) DEFAULT NULL,
  `PROPERTY_VALUE` longtext,
  KEY `CITATION_SCHEMA_FIELD_INDEX` (`SCHEMA_ID`,`FIELD_ID`),
  KEY `CITATION_SCHEMA_FIELD_INDEX2` (`SCHEMA_ID`,`FIELD_ID`,`PROPERTY_NAME`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `citation_schema_field`
--

LOCK TABLES `citation_schema_field` WRITE;
/*!40000 ALTER TABLE `citation_schema_field` DISABLE KEYS */;
INSERT INTO `citation_schema_field` VALUES ('unknown','creator','sakai:hasOrder','0'),('unknown','creator','sakai:required','false'),('unknown','creator','sakai:minCardinality','0'),('unknown','creator','sakai:maxCardinality','2147483647'),('unknown','creator','sakai:valueType','shorttext'),('unknown','creator','sakai:ris_identifier','A1,AU'),('unknown','title','sakai:hasOrder','1'),('unknown','title','sakai:required','true'),('unknown','title','sakai:minCardinality','1'),('unknown','title','sakai:maxCardinality','1'),('unknown','title','sakai:valueType','shorttext'),('unknown','title','sakai:ris_identifier','T1,TI,CT,BT'),('unknown','year','sakai:hasOrder','2'),('unknown','year','sakai:required','false'),('unknown','year','sakai:minCardinality','0'),('unknown','year','sakai:maxCardinality','1'),('unknown','year','sakai:valueType','number'),('unknown','date','sakai:hasOrder','3'),('unknown','date','sakai:required','false'),('unknown','date','sakai:minCardinality','0'),('unknown','date','sakai:maxCardinality','1'),('unknown','date','sakai:valueType','number'),('unknown','date','sakai:ris_identifier','Y1,PY'),('unknown','publisher','sakai:hasOrder','4'),('unknown','publisher','sakai:required','false'),('unknown','publisher','sakai:minCardinality','0'),('unknown','publisher','sakai:maxCardinality','1'),('unknown','publisher','sakai:valueType','shorttext'),('unknown','publisher','sakai:ris_identifier','PB'),('unknown','publicationLocation','sakai:hasOrder','5'),('unknown','publicationLocation','sakai:required','false'),('unknown','publicationLocation','sakai:minCardinality','0'),('unknown','publicationLocation','sakai:maxCardinality','1'),('unknown','publicationLocation','sakai:valueType','shorttext'),('unknown','publicationLocation','sakai:ris_identifier','CY'),('unknown','volume','sakai:hasOrder','6'),('unknown','volume','sakai:required','false'),('unknown','volume','sakai:minCardinality','0'),('unknown','volume','sakai:maxCardinality','1'),('unknown','volume','sakai:valueType','number'),('unknown','volume','sakai:ris_identifier','VL'),('unknown','issue','sakai:hasOrder','7'),('unknown','issue','sakai:required','false'),('unknown','issue','sakai:minCardinality','0'),('unknown','issue','sakai:maxCardinality','1'),('unknown','issue','sakai:valueType','number'),('unknown','issue','sakai:ris_identifier','IS'),('unknown','pages','sakai:hasOrder','8'),('unknown','pages','sakai:required','false'),('unknown','pages','sakai:minCardinality','0'),('unknown','pages','sakai:maxCardinality','1'),('unknown','pages','sakai:valueType','number'),('unknown','pages','sakai:ris_identifier','SP'),('unknown','startPage','sakai:hasOrder','9'),('unknown','startPage','sakai:required','false'),('unknown','startPage','sakai:minCardinality','0'),('unknown','startPage','sakai:maxCardinality','1'),('unknown','startPage','sakai:valueType','number'),('unknown','startPage','sakai:ris_identifier','SP'),('unknown','endPage','sakai:hasOrder','10'),('unknown','endPage','sakai:required','false'),('unknown','endPage','sakai:minCardinality','0'),('unknown','endPage','sakai:maxCardinality','1'),('unknown','endPage','sakai:valueType','number'),('unknown','endPage','sakai:ris_identifier','EP'),('unknown','edition','sakai:hasOrder','11'),('unknown','edition','sakai:required','false'),('unknown','edition','sakai:minCardinality','0'),('unknown','edition','sakai:maxCardinality','1'),('unknown','edition','sakai:valueType','number'),('unknown','edition','sakai:ris_identifier','VL'),('unknown','editor','sakai:hasOrder','12'),('unknown','editor','sakai:required','false'),('unknown','editor','sakai:minCardinality','0'),('unknown','editor','sakai:maxCardinality','2147483647'),('unknown','editor','sakai:valueType','shorttext'),('unknown','editor','sakai:ris_identifier','ED,A2,A3'),('unknown','sourceTitle','sakai:hasOrder','13'),('unknown','sourceTitle','sakai:required','false'),('unknown','sourceTitle','sakai:minCardinality','0'),('unknown','sourceTitle','sakai:maxCardinality','1'),('unknown','sourceTitle','sakai:valueType','shorttext'),('unknown','sourceTitle','sakai:ris_identifier','T3'),('unknown','Language','sakai:hasOrder','14'),('unknown','Language','sakai:required','false'),('unknown','Language','sakai:minCardinality','0'),('unknown','Language','sakai:maxCardinality','1'),('unknown','Language','sakai:valueType','number'),('unknown','abstract','sakai:hasOrder','15'),('unknown','abstract','sakai:required','false'),('unknown','abstract','sakai:minCardinality','0'),('unknown','abstract','sakai:maxCardinality','1'),('unknown','abstract','sakai:valueType','longtext'),('unknown','abstract','sakai:ris_identifier','N2,AB'),('unknown','note','sakai:hasOrder','16'),('unknown','note','sakai:required','false'),('unknown','note','sakai:minCardinality','0'),('unknown','note','sakai:maxCardinality','2147483647'),('unknown','note','sakai:valueType','shorttext'),('unknown','note','sakai:ris_identifier','N1,AB'),('unknown','isnIdentifier','sakai:hasOrder','17'),('unknown','isnIdentifier','sakai:required','false'),('unknown','isnIdentifier','sakai:minCardinality','0'),('unknown','isnIdentifier','sakai:maxCardinality','1'),('unknown','isnIdentifier','sakai:valueType','shorttext'),('unknown','isnIdentifier','sakai:ris_identifier','SN'),('unknown','subject','sakai:hasOrder','18'),('unknown','subject','sakai:required','false'),('unknown','subject','sakai:minCardinality','0'),('unknown','subject','sakai:maxCardinality','2147483647'),('unknown','subject','sakai:valueType','shorttext'),('unknown','subject','sakai:ris_identifier','KW'),('unknown','locIdentifier','sakai:hasOrder','19'),('unknown','locIdentifier','sakai:required','false'),('unknown','locIdentifier','sakai:minCardinality','0'),('unknown','locIdentifier','sakai:maxCardinality','1'),('unknown','locIdentifier','sakai:valueType','shorttext'),('unknown','locIdentifier','sakai:ris_identifier','M1'),('unknown','dateRetrieved','sakai:hasOrder','20'),('unknown','dateRetrieved','sakai:required','false'),('unknown','dateRetrieved','sakai:minCardinality','0'),('unknown','dateRetrieved','sakai:maxCardinality','1'),('unknown','dateRetrieved','sakai:valueType','date'),('unknown','openURL','sakai:hasOrder','21'),('unknown','openURL','sakai:required','false'),('unknown','openURL','sakai:minCardinality','0'),('unknown','openURL','sakai:maxCardinality','1'),('unknown','openURL','sakai:valueType','shorttext'),('unknown','doi','sakai:hasOrder','22'),('unknown','doi','sakai:required','false'),('unknown','doi','sakai:minCardinality','0'),('unknown','doi','sakai:maxCardinality','1'),('unknown','doi','sakai:valueType','number'),('unknown','rights','sakai:hasOrder','23'),('unknown','rights','sakai:required','false'),('unknown','rights','sakai:minCardinality','0'),('unknown','rights','sakai:maxCardinality','2147483647'),('unknown','rights','sakai:valueType','shorttext'),('article','creator','sakai:hasOrder','0'),('article','creator','sakai:required','false'),('article','creator','sakai:minCardinality','0'),('article','creator','sakai:maxCardinality','2147483647'),('article','creator','sakai:valueType','shorttext'),('article','creator','sakai:ris_identifier','A1,AU'),('article','title','sakai:hasOrder','1'),('article','title','sakai:required','true'),('article','title','sakai:minCardinality','1'),('article','title','sakai:maxCardinality','1'),('article','title','sakai:valueType','shorttext'),('article','title','sakai:ris_identifier','T1,TI,CT'),('article','sourceTitle','sakai:hasOrder','2'),('article','sourceTitle','sakai:required','false'),('article','sourceTitle','sakai:minCardinality','0'),('article','sourceTitle','sakai:maxCardinality','1'),('article','sourceTitle','sakai:valueType','shorttext'),('article','sourceTitle','sakai:ris_identifier','JF,JO,JA,J1,J2,BT'),('article','year','sakai:hasOrder','3'),('article','year','sakai:required','false'),('article','year','sakai:minCardinality','0'),('article','year','sakai:maxCardinality','1'),('article','year','sakai:valueType','number'),('article','date','sakai:hasOrder','4'),('article','date','sakai:required','false'),('article','date','sakai:minCardinality','0'),('article','date','sakai:maxCardinality','1'),('article','date','sakai:valueType','number'),('article','date','sakai:ris_identifier','Y1,PY'),('article','volume','sakai:hasOrder','5'),('article','volume','sakai:required','false'),('article','volume','sakai:minCardinality','0'),('article','volume','sakai:maxCardinality','1'),('article','volume','sakai:valueType','number'),('article','volume','sakai:ris_identifier','VL'),('article','issue','sakai:hasOrder','6'),('article','issue','sakai:required','false'),('article','issue','sakai:minCardinality','0'),('article','issue','sakai:maxCardinality','1'),('article','issue','sakai:valueType','number'),('article','issue','sakai:ris_identifier','IS'),('article','pages','sakai:hasOrder','7'),('article','pages','sakai:required','false'),('article','pages','sakai:minCardinality','0'),('article','pages','sakai:maxCardinality','1'),('article','pages','sakai:valueType','number'),('article','startPage','sakai:hasOrder','8'),('article','startPage','sakai:required','false'),('article','startPage','sakai:minCardinality','0'),('article','startPage','sakai:maxCardinality','1'),('article','startPage','sakai:valueType','number'),('article','startPage','sakai:ris_identifier','SP'),('article','endPage','sakai:hasOrder','9'),('article','endPage','sakai:required','false'),('article','endPage','sakai:minCardinality','0'),('article','endPage','sakai:maxCardinality','1'),('article','endPage','sakai:valueType','number'),('article','endPage','sakai:ris_identifier','EP'),('article','abstract','sakai:hasOrder','10'),('article','abstract','sakai:required','false'),('article','abstract','sakai:minCardinality','0'),('article','abstract','sakai:maxCardinality','1'),('article','abstract','sakai:valueType','longtext'),('article','abstract','sakai:ris_identifier','N2,AB'),('article','note','sakai:hasOrder','11'),('article','note','sakai:required','false'),('article','note','sakai:minCardinality','0'),('article','note','sakai:maxCardinality','2147483647'),('article','note','sakai:valueType','shorttext'),('article','note','sakai:ris_identifier','N1,AB'),('article','isnIdentifier','sakai:hasOrder','12'),('article','isnIdentifier','sakai:required','false'),('article','isnIdentifier','sakai:minCardinality','0'),('article','isnIdentifier','sakai:maxCardinality','1'),('article','isnIdentifier','sakai:valueType','shorttext'),('article','isnIdentifier','sakai:ris_identifier','SN'),('article','subject','sakai:hasOrder','13'),('article','subject','sakai:required','false'),('article','subject','sakai:minCardinality','0'),('article','subject','sakai:maxCardinality','2147483647'),('article','subject','sakai:valueType','shorttext'),('article','subject','sakai:ris_identifier','KW'),('article','Language','sakai:hasOrder','14'),('article','Language','sakai:required','false'),('article','Language','sakai:minCardinality','0'),('article','Language','sakai:maxCardinality','1'),('article','Language','sakai:valueType','number'),('article','locIdentifier','sakai:hasOrder','15'),('article','locIdentifier','sakai:required','false'),('article','locIdentifier','sakai:minCardinality','0'),('article','locIdentifier','sakai:maxCardinality','1'),('article','locIdentifier','sakai:valueType','shorttext'),('article','locIdentifier','sakai:ris_identifier','M1'),('article','dateRetrieved','sakai:hasOrder','16'),('article','dateRetrieved','sakai:required','false'),('article','dateRetrieved','sakai:minCardinality','0'),('article','dateRetrieved','sakai:maxCardinality','1'),('article','dateRetrieved','sakai:valueType','date'),('article','openURL','sakai:hasOrder','17'),('article','openURL','sakai:required','false'),('article','openURL','sakai:minCardinality','0'),('article','openURL','sakai:maxCardinality','1'),('article','openURL','sakai:valueType','shorttext'),('article','doi','sakai:hasOrder','18'),('article','doi','sakai:required','false'),('article','doi','sakai:minCardinality','0'),('article','doi','sakai:maxCardinality','1'),('article','doi','sakai:valueType','number'),('article','rights','sakai:hasOrder','19'),('article','rights','sakai:required','false'),('article','rights','sakai:minCardinality','0'),('article','rights','sakai:maxCardinality','2147483647'),('article','rights','sakai:valueType','shorttext'),('book','creator','sakai:hasOrder','0'),('book','creator','sakai:required','true'),('book','creator','sakai:minCardinality','1'),('book','creator','sakai:maxCardinality','2147483647'),('book','creator','sakai:valueType','shorttext'),('book','creator','sakai:ris_identifier','A1,AU'),('book','title','sakai:hasOrder','1'),('book','title','sakai:required','true'),('book','title','sakai:minCardinality','1'),('book','title','sakai:maxCardinality','1'),('book','title','sakai:valueType','shorttext'),('book','title','sakai:ris_identifier','BT,T1,TI'),('book','year','sakai:hasOrder','2'),('book','year','sakai:required','false'),('book','year','sakai:minCardinality','0'),('book','year','sakai:maxCardinality','1'),('book','year','sakai:valueType','number'),('book','date','sakai:hasOrder','3'),('book','date','sakai:required','false'),('book','date','sakai:minCardinality','0'),('book','date','sakai:maxCardinality','1'),('book','date','sakai:valueType','number'),('book','date','sakai:ris_identifier','Y1,PY'),('book','publisher','sakai:hasOrder','4'),('book','publisher','sakai:required','false'),('book','publisher','sakai:minCardinality','0'),('book','publisher','sakai:maxCardinality','1'),('book','publisher','sakai:valueType','shorttext'),('book','publisher','sakai:ris_identifier','PB'),('book','publicationLocation','sakai:hasOrder','5'),('book','publicationLocation','sakai:required','false'),('book','publicationLocation','sakai:minCardinality','0'),('book','publicationLocation','sakai:maxCardinality','1'),('book','publicationLocation','sakai:valueType','shorttext'),('book','publicationLocation','sakai:ris_identifier','CY'),('book','edition','sakai:hasOrder','6'),('book','edition','sakai:required','false'),('book','edition','sakai:minCardinality','0'),('book','edition','sakai:maxCardinality','1'),('book','edition','sakai:valueType','number'),('book','edition','sakai:ris_identifier','VL'),('book','editor','sakai:hasOrder','7'),('book','editor','sakai:required','false'),('book','editor','sakai:minCardinality','0'),('book','editor','sakai:maxCardinality','2147483647'),('book','editor','sakai:valueType','shorttext'),('book','editor','sakai:ris_identifier','ED,A2,A3'),('book','sourceTitle','sakai:hasOrder','8'),('book','sourceTitle','sakai:required','false'),('book','sourceTitle','sakai:minCardinality','0'),('book','sourceTitle','sakai:maxCardinality','1'),('book','sourceTitle','sakai:valueType','shorttext'),('book','sourceTitle','sakai:ris_identifier','T3'),('book','abstract','sakai:hasOrder','9'),('book','abstract','sakai:required','false'),('book','abstract','sakai:minCardinality','0'),('book','abstract','sakai:maxCardinality','1'),('book','abstract','sakai:valueType','longtext'),('book','abstract','sakai:ris_identifier','N2,AB'),('book','note','sakai:hasOrder','10'),('book','note','sakai:required','false'),('book','note','sakai:minCardinality','0'),('book','note','sakai:maxCardinality','2147483647'),('book','note','sakai:valueType','shorttext'),('book','note','sakai:ris_identifier','N1,AB'),('book','isnIdentifier','sakai:hasOrder','11'),('book','isnIdentifier','sakai:required','false'),('book','isnIdentifier','sakai:minCardinality','0'),('book','isnIdentifier','sakai:maxCardinality','1'),('book','isnIdentifier','sakai:valueType','shorttext'),('book','isnIdentifier','sakai:ris_identifier','SN'),('book','subject','sakai:hasOrder','12'),('book','subject','sakai:required','false'),('book','subject','sakai:minCardinality','0'),('book','subject','sakai:maxCardinality','2147483647'),('book','subject','sakai:valueType','shorttext'),('book','subject','sakai:ris_identifier','KW'),('book','Language','sakai:hasOrder','13'),('book','Language','sakai:required','false'),('book','Language','sakai:minCardinality','0'),('book','Language','sakai:maxCardinality','1'),('book','Language','sakai:valueType','number'),('book','locIdentifier','sakai:hasOrder','14'),('book','locIdentifier','sakai:required','false'),('book','locIdentifier','sakai:minCardinality','0'),('book','locIdentifier','sakai:maxCardinality','1'),('book','locIdentifier','sakai:valueType','shorttext'),('book','locIdentifier','sakai:ris_identifier','M1'),('book','dateRetrieved','sakai:hasOrder','15'),('book','dateRetrieved','sakai:required','false'),('book','dateRetrieved','sakai:minCardinality','0'),('book','dateRetrieved','sakai:maxCardinality','1'),('book','dateRetrieved','sakai:valueType','date'),('book','openURL','sakai:hasOrder','16'),('book','openURL','sakai:required','false'),('book','openURL','sakai:minCardinality','0'),('book','openURL','sakai:maxCardinality','1'),('book','openURL','sakai:valueType','shorttext'),('book','doi','sakai:hasOrder','17'),('book','doi','sakai:required','false'),('book','doi','sakai:minCardinality','0'),('book','doi','sakai:maxCardinality','1'),('book','doi','sakai:valueType','number'),('book','rights','sakai:hasOrder','18'),('book','rights','sakai:required','false'),('book','rights','sakai:minCardinality','0'),('book','rights','sakai:maxCardinality','2147483647'),('book','rights','sakai:valueType','shorttext'),('chapter','creator','sakai:hasOrder','0'),('chapter','creator','sakai:required','true'),('chapter','creator','sakai:minCardinality','1'),('chapter','creator','sakai:maxCardinality','2147483647'),('chapter','creator','sakai:valueType','shorttext'),('chapter','creator','sakai:ris_identifier','A1,AU'),('chapter','title','sakai:hasOrder','1'),('chapter','title','sakai:required','true'),('chapter','title','sakai:minCardinality','1'),('chapter','title','sakai:maxCardinality','1'),('chapter','title','sakai:valueType','shorttext'),('chapter','title','sakai:ris_identifier','CT,T1,TI'),('chapter','year','sakai:hasOrder','2'),('chapter','year','sakai:required','false'),('chapter','year','sakai:minCardinality','0'),('chapter','year','sakai:maxCardinality','1'),('chapter','year','sakai:valueType','number'),('chapter','date','sakai:hasOrder','3'),('chapter','date','sakai:required','false'),('chapter','date','sakai:minCardinality','0'),('chapter','date','sakai:maxCardinality','1'),('chapter','date','sakai:valueType','number'),('chapter','date','sakai:ris_identifier','Y1,PY'),('chapter','publisher','sakai:hasOrder','4'),('chapter','publisher','sakai:required','false'),('chapter','publisher','sakai:minCardinality','0'),('chapter','publisher','sakai:maxCardinality','1'),('chapter','publisher','sakai:valueType','shorttext'),('chapter','publisher','sakai:ris_identifier','PB'),('chapter','publicationLocation','sakai:hasOrder','5'),('chapter','publicationLocation','sakai:required','false'),('chapter','publicationLocation','sakai:minCardinality','0'),('chapter','publicationLocation','sakai:maxCardinality','1'),('chapter','publicationLocation','sakai:valueType','shorttext'),('chapter','publicationLocation','sakai:ris_identifier','CY'),('chapter','edition','sakai:hasOrder','6'),('chapter','edition','sakai:required','false'),('chapter','edition','sakai:minCardinality','0'),('chapter','edition','sakai:maxCardinality','1'),('chapter','edition','sakai:valueType','number'),('chapter','edition','sakai:ris_identifier','VL'),('chapter','editor','sakai:hasOrder','7'),('chapter','editor','sakai:required','false'),('chapter','editor','sakai:minCardinality','0'),('chapter','editor','sakai:maxCardinality','2147483647'),('chapter','editor','sakai:valueType','shorttext'),('chapter','editor','sakai:ris_identifier','ED,A2,A3'),('chapter','sourceTitle','sakai:hasOrder','8'),('chapter','sourceTitle','sakai:required','false'),('chapter','sourceTitle','sakai:minCardinality','0'),('chapter','sourceTitle','sakai:maxCardinality','1'),('chapter','sourceTitle','sakai:valueType','shorttext'),('chapter','sourceTitle','sakai:ris_identifier','BT'),('chapter','pages','sakai:hasOrder','9'),('chapter','pages','sakai:required','false'),('chapter','pages','sakai:minCardinality','0'),('chapter','pages','sakai:maxCardinality','1'),('chapter','pages','sakai:valueType','number'),('chapter','pages','sakai:ris_identifier','SP'),('chapter','startPage','sakai:hasOrder','10'),('chapter','startPage','sakai:required','false'),('chapter','startPage','sakai:minCardinality','0'),('chapter','startPage','sakai:maxCardinality','1'),('chapter','startPage','sakai:valueType','number'),('chapter','startPage','sakai:ris_identifier','SP'),('chapter','endPage','sakai:hasOrder','11'),('chapter','endPage','sakai:required','false'),('chapter','endPage','sakai:minCardinality','0'),('chapter','endPage','sakai:maxCardinality','1'),('chapter','endPage','sakai:valueType','number'),('chapter','endPage','sakai:ris_identifier','EP'),('chapter','abstract','sakai:hasOrder','12'),('chapter','abstract','sakai:required','false'),('chapter','abstract','sakai:minCardinality','0'),('chapter','abstract','sakai:maxCardinality','1'),('chapter','abstract','sakai:valueType','longtext'),('chapter','abstract','sakai:ris_identifier','N2,AB'),('chapter','note','sakai:hasOrder','13'),('chapter','note','sakai:required','false'),('chapter','note','sakai:minCardinality','0'),('chapter','note','sakai:maxCardinality','2147483647'),('chapter','note','sakai:valueType','shorttext'),('chapter','note','sakai:ris_identifier','N1,AB'),('chapter','isnIdentifier','sakai:hasOrder','14'),('chapter','isnIdentifier','sakai:required','false'),('chapter','isnIdentifier','sakai:minCardinality','0'),('chapter','isnIdentifier','sakai:maxCardinality','1'),('chapter','isnIdentifier','sakai:valueType','shorttext'),('chapter','isnIdentifier','sakai:ris_identifier','SN'),('chapter','subject','sakai:hasOrder','15'),('chapter','subject','sakai:required','false'),('chapter','subject','sakai:minCardinality','0'),('chapter','subject','sakai:maxCardinality','2147483647'),('chapter','subject','sakai:valueType','shorttext'),('chapter','subject','sakai:ris_identifier','KW'),('chapter','Language','sakai:hasOrder','16'),('chapter','Language','sakai:required','false'),('chapter','Language','sakai:minCardinality','0'),('chapter','Language','sakai:maxCardinality','1'),('chapter','Language','sakai:valueType','number'),('chapter','locIdentifier','sakai:hasOrder','17'),('chapter','locIdentifier','sakai:required','false'),('chapter','locIdentifier','sakai:minCardinality','0'),('chapter','locIdentifier','sakai:maxCardinality','1'),('chapter','locIdentifier','sakai:valueType','shorttext'),('chapter','locIdentifier','sakai:ris_identifier','M1'),('chapter','dateRetrieved','sakai:hasOrder','18'),('chapter','dateRetrieved','sakai:required','false'),('chapter','dateRetrieved','sakai:minCardinality','0'),('chapter','dateRetrieved','sakai:maxCardinality','1'),('chapter','dateRetrieved','sakai:valueType','date'),('chapter','openURL','sakai:hasOrder','19'),('chapter','openURL','sakai:required','false'),('chapter','openURL','sakai:minCardinality','0'),('chapter','openURL','sakai:maxCardinality','1'),('chapter','openURL','sakai:valueType','shorttext'),('chapter','doi','sakai:hasOrder','20'),('chapter','doi','sakai:required','false'),('chapter','doi','sakai:minCardinality','0'),('chapter','doi','sakai:maxCardinality','1'),('chapter','doi','sakai:valueType','number'),('chapter','rights','sakai:hasOrder','21'),('chapter','rights','sakai:required','false'),('chapter','rights','sakai:minCardinality','0'),('chapter','rights','sakai:maxCardinality','2147483647'),('chapter','rights','sakai:valueType','shorttext'),('report','creator','sakai:hasOrder','0'),('report','creator','sakai:required','true'),('report','creator','sakai:minCardinality','1'),('report','creator','sakai:maxCardinality','2147483647'),('report','creator','sakai:valueType','shorttext'),('report','creator','sakai:ris_identifier','A1,AU'),('report','title','sakai:hasOrder','1'),('report','title','sakai:required','true'),('report','title','sakai:minCardinality','1'),('report','title','sakai:maxCardinality','1'),('report','title','sakai:valueType','shorttext'),('report','title','sakai:ris_identifier','T1,TI'),('report','year','sakai:hasOrder','2'),('report','year','sakai:required','false'),('report','year','sakai:minCardinality','0'),('report','year','sakai:maxCardinality','1'),('report','year','sakai:valueType','number'),('report','date','sakai:hasOrder','3'),('report','date','sakai:required','false'),('report','date','sakai:minCardinality','0'),('report','date','sakai:maxCardinality','1'),('report','date','sakai:valueType','number'),('report','date','sakai:ris_identifier','Y1,PY'),('report','publisher','sakai:hasOrder','4'),('report','publisher','sakai:required','false'),('report','publisher','sakai:minCardinality','0'),('report','publisher','sakai:maxCardinality','1'),('report','publisher','sakai:valueType','shorttext'),('report','publisher','sakai:ris_identifier','PB'),('report','publicationLocation','sakai:hasOrder','5'),('report','publicationLocation','sakai:required','false'),('report','publicationLocation','sakai:minCardinality','0'),('report','publicationLocation','sakai:maxCardinality','1'),('report','publicationLocation','sakai:valueType','shorttext'),('report','publicationLocation','sakai:ris_identifier','CY'),('report','editor','sakai:hasOrder','6'),('report','editor','sakai:required','false'),('report','editor','sakai:minCardinality','0'),('report','editor','sakai:maxCardinality','2147483647'),('report','editor','sakai:valueType','shorttext'),('report','editor','sakai:ris_identifier','ED,A2,A3'),('report','edition','sakai:hasOrder','7'),('report','edition','sakai:required','false'),('report','edition','sakai:minCardinality','0'),('report','edition','sakai:maxCardinality','1'),('report','edition','sakai:valueType','number'),('report','edition','sakai:ris_identifier','VL'),('report','sourceTitle','sakai:hasOrder','8'),('report','sourceTitle','sakai:required','false'),('report','sourceTitle','sakai:minCardinality','0'),('report','sourceTitle','sakai:maxCardinality','1'),('report','sourceTitle','sakai:valueType','shorttext'),('report','sourceTitle','sakai:ris_identifier','T3'),('report','pages','sakai:hasOrder','9'),('report','pages','sakai:required','false'),('report','pages','sakai:minCardinality','0'),('report','pages','sakai:maxCardinality','1'),('report','pages','sakai:valueType','number'),('report','pages','sakai:ris_identifier','SP'),('report','abstract','sakai:hasOrder','10'),('report','abstract','sakai:required','false'),('report','abstract','sakai:minCardinality','0'),('report','abstract','sakai:maxCardinality','1'),('report','abstract','sakai:valueType','longtext'),('report','abstract','sakai:ris_identifier','N2,AB'),('report','isnIdentifier','sakai:hasOrder','11'),('report','isnIdentifier','sakai:required','false'),('report','isnIdentifier','sakai:minCardinality','0'),('report','isnIdentifier','sakai:maxCardinality','1'),('report','isnIdentifier','sakai:valueType','shorttext'),('report','isnIdentifier','sakai:ris_identifier','SN'),('report','note','sakai:hasOrder','12'),('report','note','sakai:required','false'),('report','note','sakai:minCardinality','0'),('report','note','sakai:maxCardinality','2147483647'),('report','note','sakai:valueType','shorttext'),('report','note','sakai:ris_identifier','N1,AB'),('report','subject','sakai:hasOrder','13'),('report','subject','sakai:required','false'),('report','subject','sakai:minCardinality','0'),('report','subject','sakai:maxCardinality','2147483647'),('report','subject','sakai:valueType','shorttext'),('report','subject','sakai:ris_identifier','KW'),('report','Language','sakai:hasOrder','14'),('report','Language','sakai:required','false'),('report','Language','sakai:minCardinality','0'),('report','Language','sakai:maxCardinality','1'),('report','Language','sakai:valueType','number'),('report','locIdentifier','sakai:hasOrder','15'),('report','locIdentifier','sakai:required','false'),('report','locIdentifier','sakai:minCardinality','0'),('report','locIdentifier','sakai:maxCardinality','1'),('report','locIdentifier','sakai:valueType','shorttext'),('report','locIdentifier','sakai:ris_identifier','M1'),('report','dateRetrieved','sakai:hasOrder','16'),('report','dateRetrieved','sakai:required','false'),('report','dateRetrieved','sakai:minCardinality','0'),('report','dateRetrieved','sakai:maxCardinality','1'),('report','dateRetrieved','sakai:valueType','date'),('report','openURL','sakai:hasOrder','17'),('report','openURL','sakai:required','false'),('report','openURL','sakai:minCardinality','0'),('report','openURL','sakai:maxCardinality','1'),('report','openURL','sakai:valueType','shorttext'),('report','doi','sakai:hasOrder','18'),('report','doi','sakai:required','false'),('report','doi','sakai:minCardinality','0'),('report','doi','sakai:maxCardinality','1'),('report','doi','sakai:valueType','number'),('report','rights','sakai:hasOrder','19'),('report','rights','sakai:required','false'),('report','rights','sakai:minCardinality','0'),('report','rights','sakai:maxCardinality','2147483647'),('report','rights','sakai:valueType','shorttext'),('proceed','creator','sakai:hasOrder','0'),('proceed','creator','sakai:required','false'),('proceed','creator','sakai:minCardinality','0'),('proceed','creator','sakai:maxCardinality','2147483647'),('proceed','creator','sakai:valueType','shorttext'),('proceed','creator','sakai:ris_identifier','AU'),('proceed','title','sakai:hasOrder','1'),('proceed','title','sakai:required','true'),('proceed','title','sakai:minCardinality','1'),('proceed','title','sakai:maxCardinality','1'),('proceed','title','sakai:valueType','shorttext'),('proceed','title','sakai:ris_identifier','CT'),('proceed','year','sakai:hasOrder','2'),('proceed','year','sakai:required','false'),('proceed','year','sakai:minCardinality','0'),('proceed','year','sakai:maxCardinality','1'),('proceed','year','sakai:valueType','number'),('proceed','year','sakai:ris_identifier','PY'),('proceed','volume','sakai:hasOrder','3'),('proceed','volume','sakai:required','false'),('proceed','volume','sakai:minCardinality','0'),('proceed','volume','sakai:maxCardinality','1'),('proceed','volume','sakai:valueType','number'),('proceed','volume','sakai:ris_identifier','VL'),('proceed','pages','sakai:hasOrder','4'),('proceed','pages','sakai:required','false'),('proceed','pages','sakai:minCardinality','0'),('proceed','pages','sakai:maxCardinality','1'),('proceed','pages','sakai:valueType','number'),('proceed','pages','sakai:ris_identifier','SP'),('proceed','sourceTitle','sakai:hasOrder','5'),('proceed','sourceTitle','sakai:required','false'),('proceed','sourceTitle','sakai:minCardinality','0'),('proceed','sourceTitle','sakai:maxCardinality','1'),('proceed','sourceTitle','sakai:valueType','shorttext'),('proceed','sourceTitle','sakai:ris_identifier','BT'),('proceed','note','sakai:hasOrder','6'),('proceed','note','sakai:required','false'),('proceed','note','sakai:minCardinality','0'),('proceed','note','sakai:maxCardinality','2147483647'),('proceed','note','sakai:valueType','shorttext'),('proceed','note','sakai:ris_identifier','N1,AB'),('electronic','title','sakai:hasOrder','0'),('electronic','title','sakai:required','true'),('electronic','title','sakai:minCardinality','1'),('electronic','title','sakai:maxCardinality','1'),('electronic','title','sakai:valueType','shorttext'),('electronic','title','sakai:ris_identifier','CT'),('electronic','year','sakai:hasOrder','1'),('electronic','year','sakai:required','false'),('electronic','year','sakai:minCardinality','0'),('electronic','year','sakai:maxCardinality','1'),('electronic','year','sakai:valueType','number'),('electronic','year','sakai:ris_identifier','PY'),('electronic','sourceTitle','sakai:hasOrder','2'),('electronic','sourceTitle','sakai:required','false'),('electronic','sourceTitle','sakai:minCardinality','0'),('electronic','sourceTitle','sakai:maxCardinality','1'),('electronic','sourceTitle','sakai:valueType','shorttext'),('electronic','sourceTitle','sakai:ris_identifier','T3'),('electronic','abstract','sakai:hasOrder','3'),('electronic','abstract','sakai:required','false'),('electronic','abstract','sakai:minCardinality','0'),('electronic','abstract','sakai:maxCardinality','1'),('electronic','abstract','sakai:valueType','longtext'),('electronic','abstract','sakai:ris_identifier','N2,AB'),('electronic','subject','sakai:hasOrder','4'),('electronic','subject','sakai:required','false'),('electronic','subject','sakai:minCardinality','0'),('electronic','subject','sakai:maxCardinality','2147483647'),('electronic','subject','sakai:valueType','shorttext'),('electronic','subject','sakai:ris_identifier','KW'),('thesis','creator','sakai:hasOrder','0'),('thesis','creator','sakai:required','false'),('thesis','creator','sakai:minCardinality','0'),('thesis','creator','sakai:maxCardinality','2147483647'),('thesis','creator','sakai:valueType','shorttext'),('thesis','creator','sakai:ris_identifier','AU'),('thesis','title','sakai:hasOrder','1'),('thesis','title','sakai:required','true'),('thesis','title','sakai:minCardinality','1'),('thesis','title','sakai:maxCardinality','1'),('thesis','title','sakai:valueType','shorttext'),('thesis','title','sakai:ris_identifier','CT'),('thesis','year','sakai:hasOrder','2'),('thesis','year','sakai:required','false'),('thesis','year','sakai:minCardinality','0'),('thesis','year','sakai:maxCardinality','1'),('thesis','year','sakai:valueType','number'),('thesis','year','sakai:ris_identifier','PY'),('thesis','publisher','sakai:hasOrder','3'),('thesis','publisher','sakai:required','false'),('thesis','publisher','sakai:minCardinality','0'),('thesis','publisher','sakai:maxCardinality','1'),('thesis','publisher','sakai:valueType','shorttext'),('thesis','publisher','sakai:ris_identifier','PB'),('thesis','pages','sakai:hasOrder','4'),('thesis','pages','sakai:required','false'),('thesis','pages','sakai:minCardinality','0'),('thesis','pages','sakai:maxCardinality','1'),('thesis','pages','sakai:valueType','number'),('thesis','pages','sakai:ris_identifier','SP'),('thesis','note','sakai:hasOrder','5'),('thesis','note','sakai:required','false'),('thesis','note','sakai:minCardinality','0'),('thesis','note','sakai:maxCardinality','2147483647'),('thesis','note','sakai:valueType','shorttext'),('thesis','note','sakai:ris_identifier','N1,AB'),('thesis','subject','sakai:hasOrder','6'),('thesis','subject','sakai:required','false'),('thesis','subject','sakai:minCardinality','0'),('thesis','subject','sakai:maxCardinality','2147483647'),('thesis','subject','sakai:valueType','shorttext'),('thesis','subject','sakai:ris_identifier','KW');
/*!40000 ALTER TABLE `citation_schema_field` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cm_academic_session_t`
--

DROP TABLE IF EXISTS `cm_academic_session_t`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cm_academic_session_t` (
  `ACADEMIC_SESSION_ID` bigint(20) NOT NULL AUTO_INCREMENT,
  `VERSION` int(11) NOT NULL,
  `LAST_MODIFIED_BY` varchar(255) DEFAULT NULL,
  `LAST_MODIFIED_DATE` date DEFAULT NULL,
  `CREATED_BY` varchar(255) DEFAULT NULL,
  `CREATED_DATE` date DEFAULT NULL,
  `ENTERPRISE_ID` varchar(255) NOT NULL,
  `TITLE` varchar(255) NOT NULL,
  `DESCRIPTION` varchar(255) NOT NULL,
  `START_DATE` date DEFAULT NULL,
  `END_DATE` date DEFAULT NULL,
  `IS_CURRENT` bit(1) NOT NULL,
  PRIMARY KEY (`ACADEMIC_SESSION_ID`),
  UNIQUE KEY `ENTERPRISE_ID` (`ENTERPRISE_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cm_academic_session_t`
--

LOCK TABLES `cm_academic_session_t` WRITE;
/*!40000 ALTER TABLE `cm_academic_session_t` DISABLE KEYS */;
/*!40000 ALTER TABLE `cm_academic_session_t` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cm_course_set_canon_assoc_t`
--

DROP TABLE IF EXISTS `cm_course_set_canon_assoc_t`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cm_course_set_canon_assoc_t` (
  `CANON_COURSE` bigint(20) NOT NULL,
  `COURSE_SET` bigint(20) NOT NULL,
  PRIMARY KEY (`COURSE_SET`,`CANON_COURSE`),
  KEY `FKBFCBD9AE2D306E01` (`COURSE_SET`),
  KEY `FKBFCBD9AE7F976CD6` (`CANON_COURSE`),
  CONSTRAINT `FKBFCBD9AE7F976CD6` FOREIGN KEY (`CANON_COURSE`) REFERENCES `cm_member_container_t` (`MEMBER_CONTAINER_ID`),
  CONSTRAINT `FKBFCBD9AE2D306E01` FOREIGN KEY (`COURSE_SET`) REFERENCES `cm_member_container_t` (`MEMBER_CONTAINER_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cm_course_set_canon_assoc_t`
--

LOCK TABLES `cm_course_set_canon_assoc_t` WRITE;
/*!40000 ALTER TABLE `cm_course_set_canon_assoc_t` DISABLE KEYS */;
/*!40000 ALTER TABLE `cm_course_set_canon_assoc_t` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cm_course_set_offering_assoc_t`
--

DROP TABLE IF EXISTS `cm_course_set_offering_assoc_t`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cm_course_set_offering_assoc_t` (
  `COURSE_OFFERING` bigint(20) NOT NULL,
  `COURSE_SET` bigint(20) NOT NULL,
  PRIMARY KEY (`COURSE_SET`,`COURSE_OFFERING`),
  KEY `FK5B9A5CFD26827043` (`COURSE_OFFERING`),
  KEY `FK5B9A5CFD2D306E01` (`COURSE_SET`),
  CONSTRAINT `FK5B9A5CFD2D306E01` FOREIGN KEY (`COURSE_SET`) REFERENCES `cm_member_container_t` (`MEMBER_CONTAINER_ID`),
  CONSTRAINT `FK5B9A5CFD26827043` FOREIGN KEY (`COURSE_OFFERING`) REFERENCES `cm_member_container_t` (`MEMBER_CONTAINER_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cm_course_set_offering_assoc_t`
--

LOCK TABLES `cm_course_set_offering_assoc_t` WRITE;
/*!40000 ALTER TABLE `cm_course_set_offering_assoc_t` DISABLE KEYS */;
/*!40000 ALTER TABLE `cm_course_set_offering_assoc_t` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cm_cross_listing_t`
--

DROP TABLE IF EXISTS `cm_cross_listing_t`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cm_cross_listing_t` (
  `CROSS_LISTING_ID` bigint(20) NOT NULL AUTO_INCREMENT,
  `VERSION` int(11) NOT NULL,
  `LAST_MODIFIED_BY` varchar(255) DEFAULT NULL,
  `LAST_MODIFIED_DATE` date DEFAULT NULL,
  `CREATED_BY` varchar(255) DEFAULT NULL,
  `CREATED_DATE` date DEFAULT NULL,
  PRIMARY KEY (`CROSS_LISTING_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cm_cross_listing_t`
--

LOCK TABLES `cm_cross_listing_t` WRITE;
/*!40000 ALTER TABLE `cm_cross_listing_t` DISABLE KEYS */;
/*!40000 ALTER TABLE `cm_cross_listing_t` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cm_enrollment_set_t`
--

DROP TABLE IF EXISTS `cm_enrollment_set_t`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cm_enrollment_set_t` (
  `ENROLLMENT_SET_ID` bigint(20) NOT NULL AUTO_INCREMENT,
  `VERSION` int(11) NOT NULL,
  `LAST_MODIFIED_BY` varchar(255) DEFAULT NULL,
  `LAST_MODIFIED_DATE` date DEFAULT NULL,
  `CREATED_BY` varchar(255) DEFAULT NULL,
  `CREATED_DATE` date DEFAULT NULL,
  `ENTERPRISE_ID` varchar(255) NOT NULL,
  `TITLE` varchar(255) NOT NULL,
  `DESCRIPTION` varchar(255) NOT NULL,
  `CATEGORY` varchar(255) NOT NULL,
  `DEFAULT_CREDITS` varchar(255) NOT NULL,
  `COURSE_OFFERING` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`ENROLLMENT_SET_ID`),
  UNIQUE KEY `ENTERPRISE_ID` (`ENTERPRISE_ID`),
  KEY `FK99479DD126827043` (`COURSE_OFFERING`),
  CONSTRAINT `FK99479DD126827043` FOREIGN KEY (`COURSE_OFFERING`) REFERENCES `cm_member_container_t` (`MEMBER_CONTAINER_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cm_enrollment_set_t`
--

LOCK TABLES `cm_enrollment_set_t` WRITE;
/*!40000 ALTER TABLE `cm_enrollment_set_t` DISABLE KEYS */;
/*!40000 ALTER TABLE `cm_enrollment_set_t` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cm_enrollment_t`
--

DROP TABLE IF EXISTS `cm_enrollment_t`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cm_enrollment_t` (
  `ENROLLMENT_ID` bigint(20) NOT NULL AUTO_INCREMENT,
  `VERSION` int(11) NOT NULL,
  `LAST_MODIFIED_BY` varchar(255) DEFAULT NULL,
  `LAST_MODIFIED_DATE` date DEFAULT NULL,
  `CREATED_BY` varchar(255) DEFAULT NULL,
  `CREATED_DATE` date DEFAULT NULL,
  `USER_ID` varchar(255) NOT NULL,
  `STATUS` varchar(255) NOT NULL,
  `CREDITS` varchar(255) NOT NULL,
  `GRADING_SCHEME` varchar(255) NOT NULL,
  `DROPPED` bit(1) DEFAULT NULL,
  `ENROLLMENT_SET` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`ENROLLMENT_ID`),
  UNIQUE KEY `USER_ID` (`USER_ID`,`ENROLLMENT_SET`),
  KEY `FK7A7F878E456D3EA1` (`ENROLLMENT_SET`),
  CONSTRAINT `FK7A7F878E456D3EA1` FOREIGN KEY (`ENROLLMENT_SET`) REFERENCES `cm_enrollment_set_t` (`ENROLLMENT_SET_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cm_enrollment_t`
--

LOCK TABLES `cm_enrollment_t` WRITE;
/*!40000 ALTER TABLE `cm_enrollment_t` DISABLE KEYS */;
/*!40000 ALTER TABLE `cm_enrollment_t` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cm_meeting_t`
--

DROP TABLE IF EXISTS `cm_meeting_t`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cm_meeting_t` (
  `MEETING_ID` bigint(20) NOT NULL AUTO_INCREMENT,
  `LOCATION` varchar(255) DEFAULT NULL,
  `START_TIME` time DEFAULT NULL,
  `FINISH_TIME` time DEFAULT NULL,
  `NOTES` varchar(255) DEFAULT NULL,
  `MONDAY` bit(1) DEFAULT NULL,
  `TUESDAY` bit(1) DEFAULT NULL,
  `WEDNESDAY` bit(1) DEFAULT NULL,
  `THURSDAY` bit(1) DEFAULT NULL,
  `FRIDAY` bit(1) DEFAULT NULL,
  `SATURDAY` bit(1) DEFAULT NULL,
  `SUNDAY` bit(1) DEFAULT NULL,
  `SECTION_ID` bigint(20) NOT NULL,
  PRIMARY KEY (`MEETING_ID`),
  KEY `FKE15DCD9BD0506F16` (`SECTION_ID`),
  CONSTRAINT `FKE15DCD9BD0506F16` FOREIGN KEY (`SECTION_ID`) REFERENCES `cm_member_container_t` (`MEMBER_CONTAINER_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cm_meeting_t`
--

LOCK TABLES `cm_meeting_t` WRITE;
/*!40000 ALTER TABLE `cm_meeting_t` DISABLE KEYS */;
/*!40000 ALTER TABLE `cm_meeting_t` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cm_member_container_t`
--

DROP TABLE IF EXISTS `cm_member_container_t`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cm_member_container_t` (
  `MEMBER_CONTAINER_ID` bigint(20) NOT NULL AUTO_INCREMENT,
  `CLASS_DISCR` varchar(100) NOT NULL,
  `VERSION` int(11) NOT NULL,
  `LAST_MODIFIED_BY` varchar(255) DEFAULT NULL,
  `LAST_MODIFIED_DATE` date DEFAULT NULL,
  `CREATED_BY` varchar(255) DEFAULT NULL,
  `CREATED_DATE` date DEFAULT NULL,
  `ENTERPRISE_ID` varchar(100) NOT NULL,
  `TITLE` varchar(255) NOT NULL,
  `DESCRIPTION` varchar(255) NOT NULL,
  `CROSS_LISTING` bigint(20) DEFAULT NULL,
  `STATUS` varchar(255) DEFAULT NULL,
  `START_DATE` date DEFAULT NULL,
  `END_DATE` date DEFAULT NULL,
  `CANONICAL_COURSE` bigint(20) DEFAULT NULL,
  `ACADEMIC_SESSION` bigint(20) DEFAULT NULL,
  `CATEGORY` varchar(255) DEFAULT NULL,
  `PARENT_COURSE_SET` bigint(20) DEFAULT NULL,
  `COURSE_OFFERING` bigint(20) DEFAULT NULL,
  `ENROLLMENT_SET` bigint(20) DEFAULT NULL,
  `PARENT_SECTION` bigint(20) DEFAULT NULL,
  `MAXSIZE` int(11) DEFAULT NULL,
  PRIMARY KEY (`MEMBER_CONTAINER_ID`),
  UNIQUE KEY `CLASS_DISCR` (`CLASS_DISCR`,`ENTERPRISE_ID`),
  KEY `FKD96A9BC626827043` (`COURSE_OFFERING`),
  KEY `FKD96A9BC6D05F59F1` (`CANONICAL_COURSE`),
  KEY `FKD96A9BC6456D3EA1` (`ENROLLMENT_SET`),
  KEY `FKD96A9BC6661E50E9` (`ACADEMIC_SESSION`),
  KEY `FKD96A9BC649A68CB6` (`PARENT_COURSE_SET`),
  KEY `FKD96A9BC63B0306B1` (`PARENT_SECTION`),
  KEY `FKD96A9BC64F7C8841` (`CROSS_LISTING`),
  CONSTRAINT `FKD96A9BC64F7C8841` FOREIGN KEY (`CROSS_LISTING`) REFERENCES `cm_cross_listing_t` (`CROSS_LISTING_ID`),
  CONSTRAINT `FKD96A9BC626827043` FOREIGN KEY (`COURSE_OFFERING`) REFERENCES `cm_member_container_t` (`MEMBER_CONTAINER_ID`),
  CONSTRAINT `FKD96A9BC63B0306B1` FOREIGN KEY (`PARENT_SECTION`) REFERENCES `cm_member_container_t` (`MEMBER_CONTAINER_ID`),
  CONSTRAINT `FKD96A9BC6456D3EA1` FOREIGN KEY (`ENROLLMENT_SET`) REFERENCES `cm_enrollment_set_t` (`ENROLLMENT_SET_ID`),
  CONSTRAINT `FKD96A9BC649A68CB6` FOREIGN KEY (`PARENT_COURSE_SET`) REFERENCES `cm_member_container_t` (`MEMBER_CONTAINER_ID`),
  CONSTRAINT `FKD96A9BC6661E50E9` FOREIGN KEY (`ACADEMIC_SESSION`) REFERENCES `cm_academic_session_t` (`ACADEMIC_SESSION_ID`),
  CONSTRAINT `FKD96A9BC6D05F59F1` FOREIGN KEY (`CANONICAL_COURSE`) REFERENCES `cm_member_container_t` (`MEMBER_CONTAINER_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cm_member_container_t`
--

LOCK TABLES `cm_member_container_t` WRITE;
/*!40000 ALTER TABLE `cm_member_container_t` DISABLE KEYS */;
/*!40000 ALTER TABLE `cm_member_container_t` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cm_membership_t`
--

DROP TABLE IF EXISTS `cm_membership_t`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cm_membership_t` (
  `MEMBER_ID` bigint(20) NOT NULL AUTO_INCREMENT,
  `VERSION` int(11) NOT NULL,
  `USER_ID` varchar(255) NOT NULL,
  `ROLE` varchar(255) NOT NULL,
  `MEMBER_CONTAINER_ID` bigint(20) DEFAULT NULL,
  `STATUS` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`MEMBER_ID`),
  UNIQUE KEY `USER_ID` (`USER_ID`,`MEMBER_CONTAINER_ID`),
  KEY `FK9FBBBFE067131463` (`MEMBER_CONTAINER_ID`),
  CONSTRAINT `FK9FBBBFE067131463` FOREIGN KEY (`MEMBER_CONTAINER_ID`) REFERENCES `cm_member_container_t` (`MEMBER_CONTAINER_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cm_membership_t`
--

LOCK TABLES `cm_membership_t` WRITE;
/*!40000 ALTER TABLE `cm_membership_t` DISABLE KEYS */;
/*!40000 ALTER TABLE `cm_membership_t` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cm_official_instructors_t`
--

DROP TABLE IF EXISTS `cm_official_instructors_t`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cm_official_instructors_t` (
  `ENROLLMENT_SET_ID` bigint(20) NOT NULL,
  `INSTRUCTOR_ID` varchar(255) DEFAULT NULL,
  UNIQUE KEY `ENROLLMENT_SET_ID` (`ENROLLMENT_SET_ID`,`INSTRUCTOR_ID`),
  KEY `FK470F8ACCC28CC1AD` (`ENROLLMENT_SET_ID`),
  KEY `CM_ENR_SET_INSTR_IDX` (`INSTRUCTOR_ID`),
  CONSTRAINT `FK470F8ACCC28CC1AD` FOREIGN KEY (`ENROLLMENT_SET_ID`) REFERENCES `cm_enrollment_set_t` (`ENROLLMENT_SET_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cm_official_instructors_t`
--

LOCK TABLES `cm_official_instructors_t` WRITE;
/*!40000 ALTER TABLE `cm_official_instructors_t` DISABLE KEYS */;
/*!40000 ALTER TABLE `cm_official_instructors_t` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cm_sec_category_t`
--

DROP TABLE IF EXISTS `cm_sec_category_t`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cm_sec_category_t` (
  `CAT_CODE` varchar(255) NOT NULL,
  `CAT_DESCR` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`CAT_CODE`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cm_sec_category_t`
--

LOCK TABLES `cm_sec_category_t` WRITE;
/*!40000 ALTER TABLE `cm_sec_category_t` DISABLE KEYS */;
/*!40000 ALTER TABLE `cm_sec_category_t` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cmn_type_t`
--

DROP TABLE IF EXISTS `cmn_type_t`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cmn_type_t` (
  `ID` bigint(20) NOT NULL AUTO_INCREMENT,
  `VERSION` int(11) NOT NULL,
  `UUID` varchar(36) NOT NULL,
  `LAST_MODIFIED_BY` varchar(36) NOT NULL,
  `LAST_MODIFIED_DATE` datetime NOT NULL,
  `CREATED_BY` varchar(36) NOT NULL,
  `CREATED_DATE` datetime NOT NULL,
  `AUTHORITY` varchar(100) NOT NULL,
  `DOMAIN` varchar(100) NOT NULL,
  `KEYWORD` varchar(100) NOT NULL,
  `DISPLAY_NAME` varchar(255) NOT NULL,
  `DESCRIPTION` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`ID`),
  UNIQUE KEY `UUID` (`UUID`),
  UNIQUE KEY `AUTHORITY` (`AUTHORITY`,`DOMAIN`,`KEYWORD`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cmn_type_t`
--

LOCK TABLES `cmn_type_t` WRITE;
/*!40000 ALTER TABLE `cmn_type_t` DISABLE KEYS */;
INSERT INTO `cmn_type_t` VALUES (1,0,'930255bc-a71c-4324-892d-961fc78ca786','SYSTEM','2012-04-22 16:35:33','SYSTEM','2012-04-22 16:35:33','org.sakaiproject.component.app.messageforums','sakai_messageforums','Owner Permission Level','Owner Permission Level','Owner Permission Level'),(2,0,'6747d673-9a4c-48a0-8d4b-1f1036fb719f','SYSTEM','2012-04-22 16:35:33','SYSTEM','2012-04-22 16:35:33','org.sakaiproject.component.app.messageforums','sakai_messageforums','Author Permission Level','Author Permission Level','Author Permission Level'),(3,0,'030c33aa-7c2c-413f-9c61-375cf03e4870','SYSTEM','2012-04-22 16:35:33','SYSTEM','2012-04-22 16:35:33','org.sakaiproject.component.app.messageforums','sakai_messageforums','Nonediting Author Permission Level','Nonediting Author Permission Level','Nonediting Author Permission Level'),(4,0,'639dbcca-0111-4b3a-b51f-6d10ab9fc962','SYSTEM','2012-04-22 16:35:33','SYSTEM','2012-04-22 16:35:33','org.sakaiproject.component.app.messageforums','sakai_messageforums','Reviewer Permission Level','Reviewer Permission Level','Reviewer Permission Level'),(5,0,'5e6ab371-3d62-4594-aef6-6aab0d6ea084','SYSTEM','2012-04-22 16:35:33','SYSTEM','2012-04-22 16:35:33','org.sakaiproject.component.app.messageforums','sakai_messageforums','Contributor Permission Level','Contributor Permission Level','Contributor Permission Level'),(6,0,'117e234f-bdf3-47fc-863f-d93cdb5895cb','SYSTEM','2012-04-22 16:35:33','SYSTEM','2012-04-22 16:35:33','org.sakaiproject.component.app.messageforums','sakai_messageforums','None Permission Level','None Permission Level','None Permission Level'),(7,0,'f0e58834-2205-4c81-bbcc-5aa4b3885cbb','SYSTEM','2012-04-22 16:35:33','SYSTEM','2012-04-22 16:35:33','org.sakaiproject.component.app.messageforums','sakai_messageforums','Custom Permission Level','Custom Permission Level','Custom Permission Level'),(8,0,'a378099d-fb25-499c-8e2f-161a44961fe6','SYSTEM','2012-04-22 16:35:34','SYSTEM','2012-04-22 16:35:34','org.sakaiproject','api.common.edu.person','SakaiPerson.recordType.systemMutable','System Mutable SakaiPerson','System Mutable SakaiPerson'),(9,0,'1e5e0c66-29c1-41d4-a8a7-b8aec6af5fce','SYSTEM','2012-04-22 16:35:34','SYSTEM','2012-04-22 16:35:34','org.sakaiproject','api.common.edu.person','SakaiPerson.recordType.userMutable','User Mutable SakaiPerson','User Mutable SakaiPerson');
/*!40000 ALTER TABLE `cmn_type_t` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `content_collection`
--

DROP TABLE IF EXISTS `content_collection`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `content_collection` (
  `COLLECTION_ID` varchar(255) NOT NULL,
  `IN_COLLECTION` varchar(255) DEFAULT NULL,
  `XML` longtext,
  `BINARY_ENTITY` blob,
  UNIQUE KEY `CONTENT_COLLECTION_INDEX` (`COLLECTION_ID`),
  KEY `CONTENT_IN_COLLECTION_INDEX` (`IN_COLLECTION`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `content_collection`
--

LOCK TABLES `content_collection` WRITE;
/*!40000 ALTER TABLE `content_collection` DISABLE KEYS */;
INSERT INTO `content_collection` VALUES ('/','',NULL,'CHSBCE\0\0\0\0\0\0\n\0/\0%org.sakaiproject.content.types.folder\0	inherited\0\0\0\0ÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿ\0\0\0\0\0\0\0\0\0\0\r\0\0\0\0\0\0d\0\0\0\0\0\0e\0DAV:getlastmodified\020020401000000000\0\0\0e\0DAV:displayname\0root\0\0\0e\0CHEF:creator\0admin\0\0\0e\0DAV:creationdate\020020401000000000\0\0\0e\0CHEF:is-collection\0true\0\0\0e\0CHEF:modifiedby\0admin\0\0\0'),('/group/','/',NULL,'CHSBCE\0\0\0\0\0\0\n\0/group/\0%org.sakaiproject.content.types.folder\0	inherited\0\0\0\0ÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿ\0\0\0\0\0\0\0\0\0\0\r\0\0\0\0\0\0d\0\0\0\0\0\0e\0DAV:getlastmodified\020020401000000000\0\0\0e\0DAV:displayname\0group\0\0\0e\0CHEF:creator\0admin\0\0\0e\0DAV:creationdate\020020401000000000\0\0\0e\0CHEF:is-collection\0true\0\0\0e\0CHEF:modifiedby\0admin\0\0\0'),('/public/','/',NULL,'CHSBCE\0\0\0\0\0\0\n\0/public/\0%org.sakaiproject.content.types.folder\0	inherited\0\0\0\0ÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿ\0\0\0\0\0\0\0\0\0\0\r\0\0\0\0\0\0d\0\0\0\0\0\0e\0DAV:getlastmodified\020020401000000000\0\0\0e\0DAV:displayname\0public\0\0\0e\0CHEF:creator\0admin\0\0\0e\0DAV:creationdate\020020401000000000\0\0\0e\0CHEF:is-collection\0true\0\0\0e\0CHEF:modifiedby\0admin\0\0\0'),('/attachment/','/',NULL,'CHSBCE\0\0\0\0\0\0\n\0/attachment/\0%org.sakaiproject.content.types.folder\0	inherited\0\0\0\0ÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿ\0\0\0\0\0\0\0\0\0\0\r\0\0\0\0\0\0d\0\0\0\0\0\0e\0DAV:getlastmodified\020020401000000000\0\0\0e\0DAV:displayname\0\nattachment\0\0\0e\0CHEF:creator\0admin\0\0\0e\0DAV:creationdate\020020401000000000\0\0\0e\0CHEF:is-collection\0true\0\0\0e\0CHEF:modifiedby\0admin\0\0\0'),('/group/PortfolioAdmin/system/','/group/PortfolioAdmin/',NULL,'CHSBCE\0\0\0\0\0\0\n\0/group/PortfolioAdmin/system/\0%org.sakaiproject.content.types.folder\0	inherited\0\0\0\0ÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿ\0\0\0\0\0\0\0\0\0\0\r\0\0\0\0\0\0d\0\0\0\0\0\0e\0DAV:getlastmodified\020120422213534169\0\0\0e\0DAV:displayname\0system\0\0\0e\0SAKAI:content_priority\02\0\0\0e\0CHEF:creator\0admin\0\0\0e\0DAV:creationdate\020120422213534167\0\0\0e\0CHEF:is-collection\0true\0\0\0e\0CHEF:modifiedby\0admin\0\0\0'),('/private/','/',NULL,'CHSBCE\0\0\0\0\0\0\n\0	/private/\0%org.sakaiproject.content.types.folder\0	inherited\0\0\0\0ÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿ\0\0\0\0\0\0\0\0\0\0\r\0\0\0\0\0\0d\0\0\0\0\0\0e\0DAV:getlastmodified\020020401000000000\0\0\0e\0DAV:displayname\0private\0\0\0e\0CHEF:creator\0admin\0\0\0e\0DAV:creationdate\020020401000000000\0\0\0e\0CHEF:is-collection\0true\0\0\0e\0CHEF:modifiedby\0admin\0\0\0'),('/user/','/',NULL,'CHSBCE\0\0\0\0\0\0\n\0/user/\0%org.sakaiproject.content.types.folder\0	inherited\0\0\0\0ÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿ\0\0\0\0\0\0\0\0\0\0\r\0\0\0\0\0\0d\0\0\0\0\0\0e\0DAV:getlastmodified\020020401000000000\0\0\0e\0DAV:displayname\0user\0\0\0e\0CHEF:creator\0admin\0\0\0e\0DAV:creationdate\020020401000000000\0\0\0e\0CHEF:is-collection\0true\0\0\0e\0CHEF:modifiedby\0admin\0\0\0'),('/group/PortfolioAdmin/','/group/',NULL,'CHSBCE\0\0\0\0\0\0\n\0/group/PortfolioAdmin/\0%org.sakaiproject.content.types.folder\0	inherited\0\0\0\0ÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿ\0\0\0\0\0\0\0\0\0\0\r\0\0\0\0\0\0d\0\0\0\0\0\0e\0DAV:getlastmodified\020120422213534160\0\0\0e\0DAV:displayname\0Portfolio Admin\0\0\0e\0SAKAI:content_priority\02\0\0\0e\0CHEF:creator\0admin\0\0\0e\0DAV:creationdate\020120422213534158\0\0\0e\0CHEF:is-collection\0true\0\0\0e\0CHEF:modifiedby\0admin\0\0\0'),('/group-user/','/',NULL,'CHSBCE\0\0\0\0\0\0\n\0/group-user/\0%org.sakaiproject.content.types.folder\0	inherited\0\0\0\0ÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿ\0\0\0\0\0\0\0\0\0\0\r\0\0\0\0\0\0d\0\0\0\0\0\0e\0DAV:getlastmodified\020020401000000000\0\0\0e\0DAV:displayname\0\ngroup-user\0\0\0e\0CHEF:creator\0admin\0\0\0e\0DAV:creationdate\020020401000000000\0\0\0e\0CHEF:is-collection\0true\0\0\0e\0CHEF:modifiedby\0admin\0\0\0'),('/user/admin/','/user/',NULL,'CHSBCE\0\0\0\0\0\0\n\0/user/admin/\0%org.sakaiproject.content.types.folder\0	inherited\0\0\0\0ÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿ\0\0\0\0\0\0\0\0\0\0\r\0\0\0\0\0\0d\0\0\0\0\0\0e\0DAV:getlastmodified\020120422213536267\0\0\0e\0DAV:displayname\0admin\0\0\0e\0SAKAI:content_priority\02\0\0\0e\0CHEF:creator\0admin\0\0\0e\0DAV:creationdate\020120422213536266\0\0\0e\0CHEF:is-collection\0true\0\0\0e\0CHEF:modifiedby\0admin\0\0\0');
/*!40000 ALTER TABLE `content_collection` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `content_dropbox_changes`
--

DROP TABLE IF EXISTS `content_dropbox_changes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `content_dropbox_changes` (
  `DROPBOX_ID` varchar(255) NOT NULL,
  `IN_COLLECTION` varchar(255) DEFAULT NULL,
  `LAST_UPDATE` varchar(24) DEFAULT NULL,
  UNIQUE KEY `CONTENT_DROPBOX_CI` (`DROPBOX_ID`),
  KEY `CONTENT_DROPBOX_II` (`IN_COLLECTION`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `content_dropbox_changes`
--

LOCK TABLES `content_dropbox_changes` WRITE;
/*!40000 ALTER TABLE `content_dropbox_changes` DISABLE KEYS */;
/*!40000 ALTER TABLE `content_dropbox_changes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `content_resource`
--

DROP TABLE IF EXISTS `content_resource`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `content_resource` (
  `RESOURCE_ID` varchar(255) NOT NULL,
  `RESOURCE_UUID` varchar(36) DEFAULT NULL,
  `IN_COLLECTION` varchar(255) DEFAULT NULL,
  `CONTEXT` varchar(99) DEFAULT NULL,
  `FILE_PATH` varchar(128) DEFAULT NULL,
  `FILE_SIZE` bigint(20) DEFAULT NULL,
  `RESOURCE_TYPE_ID` varchar(255) DEFAULT NULL,
  `XML` longtext,
  `BINARY_ENTITY` blob,
  UNIQUE KEY `CONTENT_RESOURCE_INDEX` (`RESOURCE_ID`),
  KEY `CONTENT_IN_RESOURCE_INDEX` (`IN_COLLECTION`),
  KEY `CONTENT_RESOURCE_CI` (`CONTEXT`),
  KEY `CONTENT_UUID_RESOURCE_INDEX` (`RESOURCE_UUID`),
  KEY `CONTENT_RESOURCE_RTI` (`RESOURCE_TYPE_ID`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `content_resource`
--

LOCK TABLES `content_resource` WRITE;
/*!40000 ALTER TABLE `content_resource` DISABLE KEYS */;
INSERT INTO `content_resource` VALUES ('/group/PortfolioAdmin/system/formCreate.xslt',NULL,'/group/PortfolioAdmin/system/','PortfolioAdmin','/2012/113/21/6b024a00-ec1d-41e9-a14f-4a18ea50003a',12616,'org.sakaiproject.content.types.fileUpload',NULL,'CHSBRE\0\0\0\0\0\0\n\0,/group/PortfolioAdmin/system/formCreate.xslt\0)org.sakaiproject.content.types.fileUpload\0	inherited\0\0\0\0ÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿ\0\0\0\0\0\0\0\0\0\0\r\0\0\0\0\0\0d\0\0\0\0\0\0e\0DAV:getcontenttype\0text/xml\0\0\0e\0DAV:getlastmodified\020120422213534190\0\0\0e\0DAV:displayname\0formCreate.xslt\0\0\0e\0SAKAI:content_priority\0	268435457\0\0\0e\0encoding\0UTF-8\0\0\0e\0CHEF:creator\0admin\0\0\0e\0DAV:creationdate\020120422213534187\0\0\0e\0CHEF:is-collection\0false\0\0\0e\0CHEF:description\01used for default rendering of form add and update\0\0\0e\0DAV:getcontentlength\012616\0\0\0e\0CHEF:modifiedby\0admin\0\0\0\0text/xml\0\0\0\0\0\01H\01/2012/113/21/6b024a00-ec1d-41e9-a14f-4a18ea50003a\0\0\0'),('/group/PortfolioAdmin/system/formFieldTemplate.xslt',NULL,'/group/PortfolioAdmin/system/','PortfolioAdmin','/2012/113/21/b7e826ab-c286-476a-b9d2-03cbe0bb4d77',64699,'org.sakaiproject.content.types.fileUpload',NULL,'CHSBRE\0\0\0\0\0\0\n\03/group/PortfolioAdmin/system/formFieldTemplate.xslt\0)org.sakaiproject.content.types.fileUpload\0	inherited\0\0\0\0ÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿ\0\0\0\0\0\0\0\0\0\0\r\0\0\0\0\0\0d\0\0\0\0\0\0e\0DAV:getcontenttype\0text/xml\0\0\0e\0DAV:getlastmodified\020120422213534289\0\0\0e\0DAV:displayname\0formFieldTemplate.xslt\0\0\0e\0SAKAI:content_priority\0	268435458\0\0\0e\0encoding\0UTF-8\0\0\0e\0CHEF:creator\0admin\0\0\0e\0DAV:creationdate\020120422213534288\0\0\0e\0CHEF:is-collection\0false\0\0\0e\0CHEF:description\0)used for default rendering of form fields\0\0\0e\0DAV:getcontentlength\064699\0\0\0e\0CHEF:modifiedby\0admin\0\0\0\0text/xml\0\0\0\0\0\0ü»\01/2012/113/21/b7e826ab-c286-476a-b9d2-03cbe0bb4d77\0\0\0'),('/group/PortfolioAdmin/system/formView.xslt',NULL,'/group/PortfolioAdmin/system/','PortfolioAdmin','/2012/113/21/498f5a53-f0d9-4be7-8dc2-135f973040f6',19385,'org.sakaiproject.content.types.fileUpload',NULL,'CHSBRE\0\0\0\0\0\0\n\0*/group/PortfolioAdmin/system/formView.xslt\0)org.sakaiproject.content.types.fileUpload\0	inherited\0\0\0\0ÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿ\0\0\0\0\0\0\0\0\0\0\r\0\0\0\0\0\0d\0\0\0\0\0\0e\0DAV:getcontenttype\0text/xml\0\0\0e\0DAV:getlastmodified\020120422213534338\0\0\0e\0DAV:displayname\0\rformView.xslt\0\0\0e\0SAKAI:content_priority\0	268435459\0\0\0e\0encoding\0UTF-8\0\0\0e\0CHEF:creator\0admin\0\0\0e\0DAV:creationdate\020120422213534337\0\0\0e\0CHEF:is-collection\0false\0\0\0e\0CHEF:description\0*used for default rendering of form viewing\0\0\0e\0DAV:getcontentlength\019385\0\0\0e\0CHEF:modifiedby\0admin\0\0\0\0text/xml\0\0\0\0\0\0K¹\01/2012/113/21/498f5a53-f0d9-4be7-8dc2-135f973040f6\0\0\0'),('/group/PortfolioAdmin/system/freeFormRenderer.xml','663fc393-3b09-41d5-9c20-854a46f81f6d','/group/PortfolioAdmin/system/','PortfolioAdmin','/2012/113/21/41a570c3-b3bb-4ec3-a612-7204ed6e5714',6499,'org.sakaiproject.content.types.fileUpload',NULL,'CHSBRE\0\0\0\0\0\0\n\01/group/PortfolioAdmin/system/freeFormRenderer.xml\0)org.sakaiproject.content.types.fileUpload\0	inherited\0\0\0\0ÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿ\0\0\0\0\0\0\0\0\0\0\r\0\0\0\0\0\0d\0\0\0\0\0\0e\0DAV:getcontenttype\0text/xml\0\0\0e\0DAV:getlastmodified\020120422213536010\0\0\0e\0DAV:displayname\0freeFormRenderer.xml\0\0\0e\0SAKAI:content_priority\0	268435460\0\0\0e\0encoding\0UTF-8\0\0\0e\0CHEF:creator\0admin\0\0\0e\0DAV:creationdate\020120422213536009\0\0\0e\0CHEF:is-collection\0false\0\0\0e\0CHEF:description\0)used for rendering the free form template\0\0\0e\0DAV:getcontentlength\06499\0\0\0e\0CHEF:modifiedby\0admin\0\0\0\0text/xml\0\0\0\0\0\0c\01/2012/113/21/41a570c3-b3bb-4ec3-a612-7204ed6e5714\0\0\0'),('/group/PortfolioAdmin/system/contentOverText.jpg','cfc9da48-84d0-43a6-9eb2-e25450b46b54','/group/PortfolioAdmin/system/','PortfolioAdmin','/2012/113/21/8faf49e2-4dfb-46f1-9ce1-9e1dec3ef3f1',2611,'org.sakaiproject.content.types.fileUpload',NULL,'CHSBRE\0\0\0\0\0\0\n\00/group/PortfolioAdmin/system/contentOverText.jpg\0)org.sakaiproject.content.types.fileUpload\0	inherited\0\0\0\0ÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿ\0\0\0\0\0\0\0\0\0\0\r\0\0\0\0\0\0d\0\0\0\0\0\0e\0DAV:getcontenttype\0\nimage/jpeg\0\0\0e\0DAV:getlastmodified\020120422213536065\0\0\0e\0DAV:displayname\0contentOverText.jpg\0\0\0e\0SAKAI:content_priority\0	268435461\0\0\0e\0encoding\0UTF-8\0\0\0e\0CHEF:creator\0admin\0\0\0e\0DAV:creationdate\020120422213536064\0\0\0e\0CHEF:is-collection\0false\0\0\0e\0CHEF:description\0contentOverText layout preview\0\0\0e\0DAV:getcontentlength\02611\0\0\0e\0CHEF:modifiedby\0admin\0\0\0\0\nimage/jpeg\0\0\0\0\0\0\n3\01/2012/113/21/8faf49e2-4dfb-46f1-9ce1-9e1dec3ef3f1\0\0\0'),('/group/PortfolioAdmin/system/contentOverText.xml','72a37b49-733b-4dd1-9588-92e66ed1e054','/group/PortfolioAdmin/system/','PortfolioAdmin','/2012/113/21/2da95957-68fc-4728-8654-d76f4b7895cd',1767,'org.sakaiproject.content.types.fileUpload',NULL,'CHSBRE\0\0\0\0\0\0\n\00/group/PortfolioAdmin/system/contentOverText.xml\0)org.sakaiproject.content.types.fileUpload\0	inherited\0\0\0\0ÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿ\0\0\0\0\0\0\0\0\0\0\r\0\0\0\0\0\0d\0\0\0\0\0\0e\0DAV:getcontenttype\0text/xml\0\0\0e\0DAV:getlastmodified\020120422213536086\0\0\0e\0DAV:displayname\0contentOverText.xml\0\0\0e\0SAKAI:content_priority\0	268435462\0\0\0e\0encoding\0UTF-8\0\0\0e\0CHEF:creator\0admin\0\0\0e\0DAV:creationdate\020120422213536085\0\0\0e\0CHEF:is-collection\0false\0\0\0e\0CHEF:description\0contentOverText layout file\0\0\0e\0DAV:getcontentlength\01767\0\0\0e\0CHEF:modifiedby\0admin\0\0\0\0text/xml\0\0\0\0\0\0ç\01/2012/113/21/2da95957-68fc-4728-8654-d76f4b7895cd\0\0\0'),('/group/PortfolioAdmin/system/2column.jpg','16e7e745-b09f-4bdb-97e5-3f161e2bcc9f','/group/PortfolioAdmin/system/','PortfolioAdmin','/2012/113/21/460906b3-7596-4dfc-90d4-d6be153ed29c',2450,'org.sakaiproject.content.types.fileUpload',NULL,'CHSBRE\0\0\0\0\0\0\n\0(/group/PortfolioAdmin/system/2column.jpg\0)org.sakaiproject.content.types.fileUpload\0	inherited\0\0\0\0ÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿ\0\0\0\0\0\0\0\0\0\0\r\0\0\0\0\0\0d\0\0\0\0\0\0e\0DAV:getcontenttype\0\nimage/jpeg\0\0\0e\0DAV:getlastmodified\020120422213536111\0\0\0e\0DAV:displayname\02column.jpg\0\0\0e\0SAKAI:content_priority\0	268435463\0\0\0e\0encoding\0UTF-8\0\0\0e\0CHEF:creator\0admin\0\0\0e\0DAV:creationdate\020120422213536110\0\0\0e\0CHEF:is-collection\0false\0\0\0e\0CHEF:description\0twoColumn layout preview\0\0\0e\0DAV:getcontentlength\02450\0\0\0e\0CHEF:modifiedby\0admin\0\0\0\0\nimage/jpeg\0\0\0\0\0\0	’\01/2012/113/21/460906b3-7596-4dfc-90d4-d6be153ed29c\0\0\0'),('/group/PortfolioAdmin/system/twoColumn.xml','6033e84a-4903-4bf8-8c6e-9429599015a8','/group/PortfolioAdmin/system/','PortfolioAdmin','/2012/113/21/d180e0f7-dec3-42bf-94f9-aa161a45ac28',1729,'org.sakaiproject.content.types.fileUpload',NULL,'CHSBRE\0\0\0\0\0\0\n\0*/group/PortfolioAdmin/system/twoColumn.xml\0)org.sakaiproject.content.types.fileUpload\0	inherited\0\0\0\0ÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿ\0\0\0\0\0\0\0\0\0\0\r\0\0\0\0\0\0d\0\0\0\0\0\0e\0DAV:getcontenttype\0text/xml\0\0\0e\0DAV:getlastmodified\020120422213536132\0\0\0e\0DAV:displayname\0\rtwoColumn.xml\0\0\0e\0SAKAI:content_priority\0	268435464\0\0\0e\0encoding\0UTF-8\0\0\0e\0CHEF:creator\0admin\0\0\0e\0DAV:creationdate\020120422213536131\0\0\0e\0CHEF:is-collection\0false\0\0\0e\0CHEF:description\0twoColumn layout file\0\0\0e\0DAV:getcontentlength\01729\0\0\0e\0CHEF:modifiedby\0admin\0\0\0\0text/xml\0\0\0\0\0\0Á\01/2012/113/21/d180e0f7-dec3-42bf-94f9-aa161a45ac28\0\0\0'),('/group/PortfolioAdmin/system/Simplehtml.jpg','2228a4e3-0c76-4d4f-a13f-2ea9bf552fa7','/group/PortfolioAdmin/system/','PortfolioAdmin','/2012/113/21/e9a0249a-27d7-4c51-a044-62613d934ea0',4044,'org.sakaiproject.content.types.fileUpload',NULL,'CHSBRE\0\0\0\0\0\0\n\0+/group/PortfolioAdmin/system/Simplehtml.jpg\0)org.sakaiproject.content.types.fileUpload\0	inherited\0\0\0\0ÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿ\0\0\0\0\0\0\0\0\0\0\r\0\0\0\0\0\0d\0\0\0\0\0\0e\0DAV:getcontenttype\0\nimage/jpeg\0\0\0e\0DAV:getlastmodified\020120422213536155\0\0\0e\0DAV:displayname\0Simplehtml.jpg\0\0\0e\0SAKAI:content_priority\0	268435465\0\0\0e\0encoding\0UTF-8\0\0\0e\0CHEF:creator\0admin\0\0\0e\0DAV:creationdate\020120422213536154\0\0\0e\0CHEF:is-collection\0false\0\0\0e\0CHEF:description\0simpleRichText layout preview\0\0\0e\0DAV:getcontentlength\04044\0\0\0e\0CHEF:modifiedby\0admin\0\0\0\0\nimage/jpeg\0\0\0\0\0\0Ì\01/2012/113/21/e9a0249a-27d7-4c51-a044-62613d934ea0\0\0\0'),('/group/PortfolioAdmin/system/simpleRichText.xml','3b882a44-8806-499d-b2dc-fd8f566a8bcb','/group/PortfolioAdmin/system/','PortfolioAdmin','/2012/113/21/7a74d925-c76e-4de7-ac1c-671ac46c1973',552,'org.sakaiproject.content.types.fileUpload',NULL,'CHSBRE\0\0\0\0\0\0\n\0//group/PortfolioAdmin/system/simpleRichText.xml\0)org.sakaiproject.content.types.fileUpload\0	inherited\0\0\0\0ÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿ\0\0\0\0\0\0\0\0\0\0\r\0\0\0\0\0\0d\0\0\0\0\0\0e\0DAV:getcontenttype\0text/xml\0\0\0e\0DAV:getlastmodified\020120422213536175\0\0\0e\0DAV:displayname\0simpleRichText.xml\0\0\0e\0SAKAI:content_priority\0	268435466\0\0\0e\0encoding\0UTF-8\0\0\0e\0CHEF:creator\0admin\0\0\0e\0DAV:creationdate\020120422213536174\0\0\0e\0CHEF:is-collection\0false\0\0\0e\0CHEF:description\0\ZsimpleRichText layout file\0\0\0e\0DAV:getcontentlength\0552\0\0\0e\0CHEF:modifiedby\0admin\0\0\0\0text/xml\0\0\0\0\0\0(\01/2012/113/21/7a74d925-c76e-4de7-ac1c-671ac46c1973\0\0\0');
/*!40000 ALTER TABLE `content_resource` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `content_resource_body_binary`
--

DROP TABLE IF EXISTS `content_resource_body_binary`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `content_resource_body_binary` (
  `RESOURCE_ID` varchar(255) NOT NULL,
  `BODY` longblob,
  UNIQUE KEY `CONTENT_RESOURCE_BB_INDEX` (`RESOURCE_ID`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `content_resource_body_binary`
--

LOCK TABLES `content_resource_body_binary` WRITE;
/*!40000 ALTER TABLE `content_resource_body_binary` DISABLE KEYS */;
/*!40000 ALTER TABLE `content_resource_body_binary` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `content_resource_delete`
--

DROP TABLE IF EXISTS `content_resource_delete`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `content_resource_delete` (
  `RESOURCE_ID` varchar(255) NOT NULL,
  `RESOURCE_UUID` varchar(36) DEFAULT NULL,
  `IN_COLLECTION` varchar(255) DEFAULT NULL,
  `CONTEXT` varchar(99) DEFAULT NULL,
  `FILE_PATH` varchar(128) DEFAULT NULL,
  `FILE_SIZE` bigint(20) DEFAULT NULL,
  `RESOURCE_TYPE_ID` varchar(255) DEFAULT NULL,
  `DELETE_DATE` datetime DEFAULT NULL,
  `DELETE_USERID` varchar(36) DEFAULT NULL,
  `XML` longtext,
  `BINARY_ENTITY` blob,
  UNIQUE KEY `CONTENT_RESOURCE_UUID_DELETE_I` (`RESOURCE_UUID`),
  KEY `CONTENT_RESOURCE_DELETE_INDEX` (`RESOURCE_ID`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `content_resource_delete`
--

LOCK TABLES `content_resource_delete` WRITE;
/*!40000 ALTER TABLE `content_resource_delete` DISABLE KEYS */;
/*!40000 ALTER TABLE `content_resource_delete` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `content_resource_lock`
--

DROP TABLE IF EXISTS `content_resource_lock`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `content_resource_lock` (
  `id` varchar(36) NOT NULL,
  `asset_id` varchar(36) DEFAULT NULL,
  `qualifier_id` varchar(36) DEFAULT NULL,
  `is_active` bit(1) DEFAULT NULL,
  `is_system` bit(1) DEFAULT NULL,
  `reason` varchar(36) DEFAULT NULL,
  `date_added` datetime DEFAULT NULL,
  `date_removed` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `content_resource_lock`
--

LOCK TABLES `content_resource_lock` WRITE;
/*!40000 ALTER TABLE `content_resource_lock` DISABLE KEYS */;
INSERT INTO `content_resource_lock` VALUES ('014b43bd-c52b-419e-8a3a-6f60e877bcc2','663fc393-3b09-41d5-9c20-854a46f81f6d','freeFormTemplate','','','saving a presentation template','2012-04-22 16:35:36',NULL),('14d1e040-f1a3-4e3c-8f8e-b8121eac35ca','3b882a44-8806-499d-b2dc-fd8f566a8bcb','simpleRichText','','','saving a presentation layout','2012-04-22 16:35:36',NULL),('21c8a84e-5453-4106-8092-5183ed8d2fde','2228a4e3-0c76-4d4f-a13f-2ea9bf552fa7','simpleRichText','','','saving a presentation layout','2012-04-22 16:35:36',NULL),('623353d4-ddf9-4a09-8216-ecf83eba9a9b','16e7e745-b09f-4bdb-97e5-3f161e2bcc9f','twoColumn','','','saving a presentation layout','2012-04-22 16:35:36',NULL),('a221a4cd-9a32-45b0-bde2-e2daf6aa5799','cfc9da48-84d0-43a6-9eb2-e25450b46b54','contentOverText','','','saving a presentation layout','2012-04-22 16:35:36',NULL),('b0b6740c-dc66-461d-95f9-972b47ef70bf','6033e84a-4903-4bf8-8c6e-9429599015a8','twoColumn','','','saving a presentation layout','2012-04-22 16:35:36',NULL),('f4b3af82-565d-4ef0-a433-8f46a45717f1','72a37b49-733b-4dd1-9588-92e66ed1e054','contentOverText','','','saving a presentation layout','2012-04-22 16:35:36',NULL);
/*!40000 ALTER TABLE `content_resource_lock` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `content_type_registry`
--

DROP TABLE IF EXISTS `content_type_registry`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `content_type_registry` (
  `CONTEXT_ID` varchar(99) NOT NULL,
  `RESOURCE_TYPE_ID` varchar(255) DEFAULT NULL,
  `ENABLED` varchar(1) DEFAULT NULL,
  KEY `content_type_registry_idx` (`CONTEXT_ID`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `content_type_registry`
--

LOCK TABLES `content_type_registry` WRITE;
/*!40000 ALTER TABLE `content_type_registry` DISABLE KEYS */;
/*!40000 ALTER TABLE `content_type_registry` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `dw_assignment_status`
--

DROP TABLE IF EXISTS `dw_assignment_status`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `dw_assignment_status` (
  `USER_ID` varchar(99) NOT NULL,
  `ASSIGNMENT_ID` varchar(99) NOT NULL,
  `COURSE_TITLE` text,
  `ASSIGNMENT_TITLE` text,
  `ASSIGNMENT_STATUS` varchar(64) DEFAULT NULL,
  `ASSIGNMENT_GRADE` varchar(64) DEFAULT NULL,
  `STUDENT_FIRST_NAME` varchar(128) DEFAULT NULL,
  `STUDENT_LAST_NAME` varchar(128) DEFAULT NULL,
  `SCHOOL` varchar(128) DEFAULT NULL,
  `DISTRICT` varchar(128) DEFAULT NULL,
  `CLASS_YEAR` varchar(128) DEFAULT NULL,
  `ADVISOR` varchar(128) DEFAULT NULL,
  `COURSE_TERM` varchar(128) DEFAULT NULL,
  `COURSE_CODE` varchar(128) DEFAULT NULL,
  `COURSE_SECTION` varchar(128) DEFAULT NULL,
  `COURSE_START_DATE` varchar(128) DEFAULT NULL,
  `INSTRUCTOR` varchar(128) DEFAULT NULL,
  PRIMARY KEY (`ASSIGNMENT_ID`,`USER_ID`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dw_assignment_status`
--

LOCK TABLES `dw_assignment_status` WRITE;
/*!40000 ALTER TABLE `dw_assignment_status` DISABLE KEYS */;
/*!40000 ALTER TABLE `dw_assignment_status` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `dw_content_resource_lock`
--

DROP TABLE IF EXISTS `dw_content_resource_lock`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `dw_content_resource_lock` (
  `id` varchar(36) NOT NULL,
  `asset_id` varchar(36) DEFAULT NULL,
  `qualifier_id` varchar(36) DEFAULT NULL,
  `is_active` tinyint(4) DEFAULT NULL,
  `is_system` tinyint(4) DEFAULT NULL,
  `reason` varchar(36) DEFAULT NULL,
  `date_added` datetime DEFAULT NULL,
  `date_removed` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dw_content_resource_lock`
--

LOCK TABLES `dw_content_resource_lock` WRITE;
/*!40000 ALTER TABLE `dw_content_resource_lock` DISABLE KEYS */;
/*!40000 ALTER TABLE `dw_content_resource_lock` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `dw_guidance`
--

DROP TABLE IF EXISTS `dw_guidance`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `dw_guidance` (
  `id` varchar(36) NOT NULL,
  `description` varchar(255) DEFAULT NULL,
  `site_id` varchar(36) NOT NULL,
  `securityQualifier` varchar(255) DEFAULT NULL,
  `securityViewFunction` varchar(255) NOT NULL,
  `securityEditFunction` varchar(255) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dw_guidance`
--

LOCK TABLES `dw_guidance` WRITE;
/*!40000 ALTER TABLE `dw_guidance` DISABLE KEYS */;
/*!40000 ALTER TABLE `dw_guidance` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `dw_guidance_item`
--

DROP TABLE IF EXISTS `dw_guidance_item`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `dw_guidance_item` (
  `id` varchar(36) NOT NULL,
  `type` varchar(255) DEFAULT NULL,
  `guidance_id` varchar(36) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `FK605DDBA7BE2FA762` (`guidance_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dw_guidance_item`
--

LOCK TABLES `dw_guidance_item` WRITE;
/*!40000 ALTER TABLE `dw_guidance_item` DISABLE KEYS */;
/*!40000 ALTER TABLE `dw_guidance_item` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `dw_guidance_item_file`
--

DROP TABLE IF EXISTS `dw_guidance_item_file`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `dw_guidance_item_file` (
  `id` varchar(36) NOT NULL,
  `baseReference` varchar(255) DEFAULT NULL,
  `fullReference` varchar(255) DEFAULT NULL,
  `item_id` varchar(36) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `FK297703147E22B9C7` (`item_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dw_guidance_item_file`
--

LOCK TABLES `dw_guidance_item_file` WRITE;
/*!40000 ALTER TABLE `dw_guidance_item_file` DISABLE KEYS */;
/*!40000 ALTER TABLE `dw_guidance_item_file` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `dw_matrix`
--

DROP TABLE IF EXISTS `dw_matrix`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `dw_matrix` (
  `id` varchar(36) NOT NULL,
  `owner` varchar(255) NOT NULL,
  `scaffolding_id` varchar(36) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `FK5A17205459517621` (`scaffolding_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dw_matrix`
--

LOCK TABLES `dw_matrix` WRITE;
/*!40000 ALTER TABLE `dw_matrix` DISABLE KEYS */;
/*!40000 ALTER TABLE `dw_matrix` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `dw_matrix_cell`
--

DROP TABLE IF EXISTS `dw_matrix_cell`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `dw_matrix_cell` (
  `id` varchar(36) NOT NULL,
  `matrix_id` varchar(36) NOT NULL,
  `wizard_page_id` varchar(36) NOT NULL,
  `scaffolding_cell_id` varchar(36) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `FK8C1D366D9AAD0C05` (`scaffolding_cell_id`),
  KEY `FK8C1D366D3E503659` (`matrix_id`),
  KEY `FK8C1D366DFE6D91AF` (`wizard_page_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dw_matrix_cell`
--

LOCK TABLES `dw_matrix_cell` WRITE;
/*!40000 ALTER TABLE `dw_matrix_cell` DISABLE KEYS */;
/*!40000 ALTER TABLE `dw_matrix_cell` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `dw_metaobj_form_def`
--

DROP TABLE IF EXISTS `dw_metaobj_form_def`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `dw_metaobj_form_def` (
  `id` varchar(36) NOT NULL,
  `description` varchar(255) DEFAULT NULL,
  `documentRoot` varchar(255) NOT NULL,
  `owner` varchar(255) NOT NULL,
  `created` datetime NOT NULL,
  `modified` datetime NOT NULL,
  `systemOnly` tinyint(4) NOT NULL,
  `externalType` varchar(255) NOT NULL,
  `siteId` varchar(255) DEFAULT NULL,
  `siteState` int(11) NOT NULL,
  `globalState` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dw_metaobj_form_def`
--

LOCK TABLES `dw_metaobj_form_def` WRITE;
/*!40000 ALTER TABLE `dw_metaobj_form_def` DISABLE KEYS */;
/*!40000 ALTER TABLE `dw_metaobj_form_def` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `dw_pres_itemdef_mimetype`
--

DROP TABLE IF EXISTS `dw_pres_itemdef_mimetype`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `dw_pres_itemdef_mimetype` (
  `item_def_id` varchar(36) NOT NULL,
  `primaryMimeType` varchar(36) DEFAULT NULL,
  `secondaryMimeType` varchar(36) DEFAULT NULL,
  KEY `FK9EA59837CEC82A41` (`item_def_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dw_pres_itemdef_mimetype`
--

LOCK TABLES `dw_pres_itemdef_mimetype` WRITE;
/*!40000 ALTER TABLE `dw_pres_itemdef_mimetype` DISABLE KEYS */;
/*!40000 ALTER TABLE `dw_pres_itemdef_mimetype` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `dw_presentation`
--

DROP TABLE IF EXISTS `dw_presentation`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `dw_presentation` (
  `id` varchar(36) NOT NULL,
  `owner_id` varchar(255) NOT NULL,
  `template_id` varchar(36) NOT NULL,
  `name` varchar(255) DEFAULT NULL,
  `description` varchar(255) DEFAULT NULL,
  `isDefault` tinyint(4) DEFAULT NULL,
  `isPublic` tinyint(4) DEFAULT NULL,
  `expiresOn` datetime DEFAULT NULL,
  `created` datetime NOT NULL,
  `modified` datetime NOT NULL,
  PRIMARY KEY (`id`),
  KEY `FKA9028D6D697A9B00` (`template_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dw_presentation`
--

LOCK TABLES `dw_presentation` WRITE;
/*!40000 ALTER TABLE `dw_presentation` DISABLE KEYS */;
/*!40000 ALTER TABLE `dw_presentation` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `dw_presentation_comment`
--

DROP TABLE IF EXISTS `dw_presentation_comment`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `dw_presentation_comment` (
  `id` varchar(36) NOT NULL,
  `title` varchar(255) NOT NULL,
  `creator_id` varchar(255) NOT NULL,
  `presentation_id` varchar(36) NOT NULL,
  `visibility` tinyint(4) NOT NULL,
  `created` datetime NOT NULL,
  PRIMARY KEY (`id`),
  KEY `FK1E7E658D662DE460` (`presentation_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dw_presentation_comment`
--

LOCK TABLES `dw_presentation_comment` WRITE;
/*!40000 ALTER TABLE `dw_presentation_comment` DISABLE KEYS */;
/*!40000 ALTER TABLE `dw_presentation_comment` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `dw_presentation_item`
--

DROP TABLE IF EXISTS `dw_presentation_item`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `dw_presentation_item` (
  `presentation_id` varchar(36) NOT NULL,
  `artifact_id` varchar(36) DEFAULT NULL,
  `item_definition_id` varchar(36) NOT NULL,
  KEY `FK2FA02A5FB2AC75B` (`item_definition_id`),
  KEY `FK2FA02A5662DE460` (`presentation_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dw_presentation_item`
--

LOCK TABLES `dw_presentation_item` WRITE;
/*!40000 ALTER TABLE `dw_presentation_item` DISABLE KEYS */;
/*!40000 ALTER TABLE `dw_presentation_item` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `dw_presentation_item_def`
--

DROP TABLE IF EXISTS `dw_presentation_item_def`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `dw_presentation_item_def` (
  `id` varchar(36) NOT NULL,
  `name` varchar(255) DEFAULT NULL,
  `title` varchar(255) DEFAULT NULL,
  `description` varchar(255) DEFAULT NULL,
  `allowMultiple` tinyint(4) DEFAULT NULL,
  `type` varchar(255) DEFAULT NULL,
  `external_type` varchar(255) DEFAULT NULL,
  `sequence_no` int(11) DEFAULT NULL,
  `template_id` varchar(36) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `FK1B6ADB6B697A9B00` (`template_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dw_presentation_item_def`
--

LOCK TABLES `dw_presentation_item_def` WRITE;
/*!40000 ALTER TABLE `dw_presentation_item_def` DISABLE KEYS */;
/*!40000 ALTER TABLE `dw_presentation_item_def` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `dw_presentation_item_property`
--

DROP TABLE IF EXISTS `dw_presentation_item_property`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `dw_presentation_item_property` (
  `id` varchar(36) NOT NULL,
  `presentation_page_item_id` varchar(36) NOT NULL,
  `property_key` varchar(255) NOT NULL,
  `property_value` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FK86B136F2150091C` (`presentation_page_item_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dw_presentation_item_property`
--

LOCK TABLES `dw_presentation_item_property` WRITE;
/*!40000 ALTER TABLE `dw_presentation_item_property` DISABLE KEYS */;
/*!40000 ALTER TABLE `dw_presentation_item_property` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `dw_presentation_layout`
--

DROP TABLE IF EXISTS `dw_presentation_layout`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `dw_presentation_layout` (
  `id` varchar(36) NOT NULL,
  `name` varchar(255) NOT NULL,
  `description` varchar(255) DEFAULT NULL,
  `globalState` tinyint(4) DEFAULT NULL,
  `owner_id` varchar(255) NOT NULL,
  `created` datetime NOT NULL,
  `modified` datetime NOT NULL,
  `xhtml_file_id` varchar(36) NOT NULL,
  `preview_image_id` varchar(36) DEFAULT NULL,
  `tool_id` varchar(36) DEFAULT NULL,
  `site_id` varchar(36) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dw_presentation_layout`
--

LOCK TABLES `dw_presentation_layout` WRITE;
/*!40000 ALTER TABLE `dw_presentation_layout` DISABLE KEYS */;
/*!40000 ALTER TABLE `dw_presentation_layout` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `dw_presentation_log`
--

DROP TABLE IF EXISTS `dw_presentation_log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `dw_presentation_log` (
  `id` varchar(36) NOT NULL,
  `viewer_id` varchar(255) NOT NULL,
  `presentation_id` varchar(36) NOT NULL,
  `view_date` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FK2120E172662DE460` (`presentation_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dw_presentation_log`
--

LOCK TABLES `dw_presentation_log` WRITE;
/*!40000 ALTER TABLE `dw_presentation_log` DISABLE KEYS */;
/*!40000 ALTER TABLE `dw_presentation_log` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `dw_presentation_page`
--

DROP TABLE IF EXISTS `dw_presentation_page`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `dw_presentation_page` (
  `id` varchar(36) NOT NULL,
  `title` varchar(255) DEFAULT NULL,
  `presentation_id` varchar(36) NOT NULL,
  `layout_id` varchar(36) NOT NULL,
  `style_id` varchar(255) DEFAULT NULL,
  `seq_num` varchar(255) DEFAULT NULL,
  `created` datetime NOT NULL,
  `modified` datetime NOT NULL,
  PRIMARY KEY (`id`),
  KEY `FK2FCEA21662DE460` (`presentation_id`),
  KEY `FK2FCEA21AE13AE50` (`layout_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dw_presentation_page`
--

LOCK TABLES `dw_presentation_page` WRITE;
/*!40000 ALTER TABLE `dw_presentation_page` DISABLE KEYS */;
/*!40000 ALTER TABLE `dw_presentation_page` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `dw_presentation_page_item`
--

DROP TABLE IF EXISTS `dw_presentation_page_item`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `dw_presentation_page_item` (
  `id` varchar(36) NOT NULL,
  `presentation_page_region_id` varchar(36) NOT NULL,
  `type` varchar(255) DEFAULT NULL,
  `value` text,
  `seq_num` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FK64176719185445B` (`presentation_page_region_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dw_presentation_page_item`
--

LOCK TABLES `dw_presentation_page_item` WRITE;
/*!40000 ALTER TABLE `dw_presentation_page_item` DISABLE KEYS */;
/*!40000 ALTER TABLE `dw_presentation_page_item` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `dw_presentation_page_region`
--

DROP TABLE IF EXISTS `dw_presentation_page_region`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `dw_presentation_page_region` (
  `id` varchar(36) NOT NULL,
  `presentation_page_id` varchar(36) NOT NULL,
  `region_id` varchar(255) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `FK8A46C2D295B9BCA6` (`presentation_page_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dw_presentation_page_region`
--

LOCK TABLES `dw_presentation_page_region` WRITE;
/*!40000 ALTER TABLE `dw_presentation_page_region` DISABLE KEYS */;
/*!40000 ALTER TABLE `dw_presentation_page_region` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `dw_presentation_template`
--

DROP TABLE IF EXISTS `dw_presentation_template`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `dw_presentation_template` (
  `id` varchar(36) NOT NULL,
  `name` varchar(255) DEFAULT NULL,
  `description` varchar(255) DEFAULT NULL,
  `includeHeaderAndFooter` tinyint(4) DEFAULT NULL,
  `published` tinyint(4) DEFAULT NULL,
  `owner_id` varchar(255) NOT NULL,
  `renderer` varchar(36) DEFAULT NULL,
  `propertyPage` varchar(36) DEFAULT NULL,
  `documentRoot` varchar(255) DEFAULT NULL,
  `created` datetime NOT NULL,
  `modified` datetime NOT NULL,
  `site_id` varchar(36) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dw_presentation_template`
--

LOCK TABLES `dw_presentation_template` WRITE;
/*!40000 ALTER TABLE `dw_presentation_template` DISABLE KEYS */;
/*!40000 ALTER TABLE `dw_presentation_template` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `dw_resource`
--

DROP TABLE IF EXISTS `dw_resource`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `dw_resource` (
  `ID` varchar(36) NOT NULL,
  `URI` varchar(255) NOT NULL,
  `RESOURCE_TYPE` varchar(255) NOT NULL,
  `SUB_TYPE` varchar(255) DEFAULT NULL,
  `PRIMARY_MIME_TYPE` varchar(255) DEFAULT NULL,
  `SUB_MIME_TYPE` varchar(255) DEFAULT NULL,
  `PARENT_COLLECTION` varchar(255) DEFAULT NULL,
  `CREATED_BY` varchar(255) DEFAULT NULL,
  `MODIFIED_BY` varchar(255) DEFAULT NULL,
  `DESCRIPTION` varchar(255) DEFAULT NULL,
  `COPYRIGHT_CHOICE` varchar(255) DEFAULT NULL,
  `COPYRIGHT` varchar(255) DEFAULT NULL,
  `CONTENT_LENGTH` int(11) DEFAULT NULL,
  `CREATED` datetime DEFAULT NULL,
  `MODIFIED` datetime DEFAULT NULL,
  `DISPLAY_NAME` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`ID`),
  KEY `FK_RESORUCE_PARENT` (`PARENT_COLLECTION`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dw_resource`
--

LOCK TABLES `dw_resource` WRITE;
/*!40000 ALTER TABLE `dw_resource` DISABLE KEYS */;
/*!40000 ALTER TABLE `dw_resource` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `dw_resource_collection`
--

DROP TABLE IF EXISTS `dw_resource_collection`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `dw_resource_collection` (
  `ID` varchar(36) NOT NULL,
  `URI` varchar(255) DEFAULT NULL,
  `PARENT_COLLECTION` varchar(255) DEFAULT NULL,
  `CREATED_BY` varchar(255) DEFAULT NULL,
  `MODIFIED_BY` varchar(255) DEFAULT NULL,
  `CREATED` datetime DEFAULT NULL,
  `MODIFIED` datetime DEFAULT NULL,
  `DISPLAY_NAME` varchar(255) DEFAULT NULL,
  `SPACE_USED` int(11) DEFAULT NULL,
  `SPACE_AVAILABLE` int(11) DEFAULT NULL,
  PRIMARY KEY (`ID`),
  KEY `FK_COLLECTION_PARENT` (`PARENT_COLLECTION`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dw_resource_collection`
--

LOCK TABLES `dw_resource_collection` WRITE;
/*!40000 ALTER TABLE `dw_resource_collection` DISABLE KEYS */;
/*!40000 ALTER TABLE `dw_resource_collection` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `dw_review_items`
--

DROP TABLE IF EXISTS `dw_review_items`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `dw_review_items` (
  `id` varchar(36) NOT NULL,
  `review_content_id` varchar(36) DEFAULT NULL,
  `site_id` varchar(36) DEFAULT NULL,
  `parent_id` varchar(36) NOT NULL,
  `review_device_id` varchar(36) DEFAULT NULL,
  `review_type` int(11) DEFAULT NULL,
  `securityQualifier` varchar(255) DEFAULT NULL,
  `securityViewFunction` varchar(255) DEFAULT NULL,
  `securityEditFunction` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FK4240ED2786D510` (`parent_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dw_review_items`
--

LOCK TABLES `dw_review_items` WRITE;
/*!40000 ALTER TABLE `dw_review_items` DISABLE KEYS */;
/*!40000 ALTER TABLE `dw_review_items` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `dw_scaffolding`
--

DROP TABLE IF EXISTS `dw_scaffolding`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `dw_scaffolding` (
  `id` varchar(36) NOT NULL,
  `ownerId` varchar(36) NOT NULL,
  `title` varchar(255) DEFAULT NULL,
  `description` varchar(255) DEFAULT NULL,
  `worksiteId` varchar(255) DEFAULT NULL,
  `published` tinyint(4) DEFAULT NULL,
  `publishedBy` varchar(255) DEFAULT NULL,
  `publishedDate` datetime DEFAULT NULL,
  `columnLabel` varchar(255) DEFAULT NULL,
  `rowLabel` varchar(255) DEFAULT NULL,
  `readyColor` varchar(7) DEFAULT NULL,
  `pendingColor` varchar(7) DEFAULT NULL,
  `completedColor` varchar(7) DEFAULT NULL,
  `lockedColor` varchar(7) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dw_scaffolding`
--

LOCK TABLES `dw_scaffolding` WRITE;
/*!40000 ALTER TABLE `dw_scaffolding` DISABLE KEYS */;
/*!40000 ALTER TABLE `dw_scaffolding` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `dw_scaffolding_cell`
--

DROP TABLE IF EXISTS `dw_scaffolding_cell`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `dw_scaffolding_cell` (
  `id` varchar(36) NOT NULL,
  `rootcriterion_id` varchar(36) DEFAULT NULL,
  `level_id` varchar(36) DEFAULT NULL,
  `scaffolding_id` varchar(36) NOT NULL,
  `wizardPageDef_id` varchar(36) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `FK184EAE6880F1F7B6` (`level_id`),
  KEY `FK184EAE68C604760E` (`scaffolding_id`),
  KEY `FK184EAE685827115B` (`rootcriterion_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dw_scaffolding_cell`
--

LOCK TABLES `dw_scaffolding_cell` WRITE;
/*!40000 ALTER TABLE `dw_scaffolding_cell` DISABLE KEYS */;
/*!40000 ALTER TABLE `dw_scaffolding_cell` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `dw_scaffolding_cell_evaluators`
--

DROP TABLE IF EXISTS `dw_scaffolding_cell_evaluators`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `dw_scaffolding_cell_evaluators` (
  `scaffolding_cell_id` varchar(36) NOT NULL,
  `id` varchar(255) DEFAULT NULL,
  KEY `FK184EAE6880F1F7B4` (`scaffolding_cell_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dw_scaffolding_cell_evaluators`
--

LOCK TABLES `dw_scaffolding_cell_evaluators` WRITE;
/*!40000 ALTER TABLE `dw_scaffolding_cell_evaluators` DISABLE KEYS */;
/*!40000 ALTER TABLE `dw_scaffolding_cell_evaluators` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `dw_scaffolding_criteria`
--

DROP TABLE IF EXISTS `dw_scaffolding_criteria`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `dw_scaffolding_criteria` (
  `id` varchar(36) NOT NULL,
  `scaffolding_id` varchar(36) DEFAULT NULL,
  `sequenceNumber` varchar(36) DEFAULT NULL,
  `description` varchar(255) DEFAULT NULL,
  `color` varchar(36) DEFAULT NULL,
  `textColor` varchar(36) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dw_scaffolding_criteria`
--

LOCK TABLES `dw_scaffolding_criteria` WRITE;
/*!40000 ALTER TABLE `dw_scaffolding_criteria` DISABLE KEYS */;
/*!40000 ALTER TABLE `dw_scaffolding_criteria` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `dw_scaffolding_levels`
--

DROP TABLE IF EXISTS `dw_scaffolding_levels`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `dw_scaffolding_levels` (
  `id` varchar(36) NOT NULL,
  `scaffolding_id` varchar(36) DEFAULT NULL,
  `sequenceNumber` varchar(36) DEFAULT NULL,
  `description` varchar(255) DEFAULT NULL,
  `color` varchar(36) DEFAULT NULL,
  `textColor` varchar(36) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FK4EBCD0F5C604760E` (`scaffolding_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dw_scaffolding_levels`
--

LOCK TABLES `dw_scaffolding_levels` WRITE;
/*!40000 ALTER TABLE `dw_scaffolding_levels` DISABLE KEYS */;
/*!40000 ALTER TABLE `dw_scaffolding_levels` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `dw_session`
--

DROP TABLE IF EXISTS `dw_session`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `dw_session` (
  `id` varchar(99) DEFAULT NULL,
  `server` varchar(99) DEFAULT NULL,
  `userId` varchar(99) DEFAULT NULL,
  `ip` varchar(99) DEFAULT NULL,
  `user_agent` varchar(99) DEFAULT NULL,
  `startTime` datetime DEFAULT NULL,
  `endTime` datetime DEFAULT NULL,
  `durationSeconds` int(11) DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dw_session`
--

LOCK TABLES `dw_session` WRITE;
/*!40000 ALTER TABLE `dw_session` DISABLE KEYS */;
/*!40000 ALTER TABLE `dw_session` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `dw_site_users`
--

DROP TABLE IF EXISTS `dw_site_users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `dw_site_users` (
  `site_id` varchar(99) NOT NULL,
  `user_id` varchar(99) NOT NULL,
  `user_eid` varchar(99) DEFAULT NULL,
  `user_display_id` varchar(99) DEFAULT NULL,
  `role` varchar(99) DEFAULT NULL,
  `permission` int(11) DEFAULT NULL,
  PRIMARY KEY (`site_id`,`user_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dw_site_users`
--

LOCK TABLES `dw_site_users` WRITE;
/*!40000 ALTER TABLE `dw_site_users` DISABLE KEYS */;
/*!40000 ALTER TABLE `dw_site_users` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `dw_sites`
--

DROP TABLE IF EXISTS `dw_sites`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `dw_sites` (
  `id` varchar(99) NOT NULL,
  `type` varchar(99) DEFAULT NULL,
  `title` varchar(99) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dw_sites`
--

LOCK TABLES `dw_sites` WRITE;
/*!40000 ALTER TABLE `dw_sites` DISABLE KEYS */;
/*!40000 ALTER TABLE `dw_sites` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `dw_template_file_ref`
--

DROP TABLE IF EXISTS `dw_template_file_ref`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `dw_template_file_ref` (
  `id` varchar(36) NOT NULL,
  `file_id` varchar(36) DEFAULT NULL,
  `file_type_id` varchar(36) DEFAULT NULL,
  `usage_desc` varchar(255) DEFAULT NULL,
  `template_id` varchar(36) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `FK4B70FB02697A9B00` (`template_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dw_template_file_ref`
--

LOCK TABLES `dw_template_file_ref` WRITE;
/*!40000 ALTER TABLE `dw_template_file_ref` DISABLE KEYS */;
/*!40000 ALTER TABLE `dw_template_file_ref` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `dw_users`
--

DROP TABLE IF EXISTS `dw_users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `dw_users` (
  `user_id` varchar(99) NOT NULL,
  `user_eid` varchar(99) DEFAULT NULL,
  `email` varchar(255) DEFAULT NULL,
  `email_lc` varchar(255) DEFAULT NULL,
  `type` varchar(255) DEFAULT NULL,
  `first_name` varchar(255) DEFAULT NULL,
  `last_name` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`user_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dw_users`
--

LOCK TABLES `dw_users` WRITE;
/*!40000 ALTER TABLE `dw_users` DISABLE KEYS */;
/*!40000 ALTER TABLE `dw_users` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `dw_wizard`
--

DROP TABLE IF EXISTS `dw_wizard`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `dw_wizard` (
  `id` varchar(36) NOT NULL,
  `owner_id` varchar(255) NOT NULL,
  `name` varchar(255) DEFAULT NULL,
  `description` text,
  `keywords` text,
  `created` datetime NOT NULL,
  `modified` datetime NOT NULL,
  `site_id` varchar(99) NOT NULL,
  `guidance_id` varchar(36) DEFAULT NULL,
  `published` tinyint(4) DEFAULT NULL,
  `wizard_type` varchar(255) DEFAULT NULL,
  `exposed_page_id` varchar(36) DEFAULT NULL,
  `root_category` varchar(36) DEFAULT NULL,
  `seq_num` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dw_wizard`
--

LOCK TABLES `dw_wizard` WRITE;
/*!40000 ALTER TABLE `dw_wizard` DISABLE KEYS */;
/*!40000 ALTER TABLE `dw_wizard` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `dw_wizard_category`
--

DROP TABLE IF EXISTS `dw_wizard_category`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `dw_wizard_category` (
  `id` varchar(36) NOT NULL,
  `title` varchar(255) DEFAULT NULL,
  `description` varchar(255) DEFAULT NULL,
  `keywords` varchar(255) DEFAULT NULL,
  `created` datetime DEFAULT NULL,
  `modified` datetime DEFAULT NULL,
  `wizard_id` varchar(36) DEFAULT NULL,
  `parent_category_id` varchar(36) DEFAULT NULL,
  `seq_num` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dw_wizard_category`
--

LOCK TABLES `dw_wizard_category` WRITE;
/*!40000 ALTER TABLE `dw_wizard_category` DISABLE KEYS */;
/*!40000 ALTER TABLE `dw_wizard_category` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `dw_wizard_completed`
--

DROP TABLE IF EXISTS `dw_wizard_completed`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `dw_wizard_completed` (
  `id` varchar(36) NOT NULL,
  `owner_id` varchar(36) DEFAULT NULL,
  `created` datetime DEFAULT NULL,
  `lastVisited` datetime DEFAULT NULL,
  `status` varchar(255) DEFAULT NULL,
  `wizard_id` varchar(36) NOT NULL,
  `root_category` varchar(36) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dw_wizard_completed`
--

LOCK TABLES `dw_wizard_completed` WRITE;
/*!40000 ALTER TABLE `dw_wizard_completed` DISABLE KEYS */;
/*!40000 ALTER TABLE `dw_wizard_completed` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `dw_wizard_completed_category`
--

DROP TABLE IF EXISTS `dw_wizard_completed_category`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `dw_wizard_completed_category` (
  `id` varchar(36) NOT NULL,
  `completed_wizard_id` varchar(36) DEFAULT NULL,
  `category_id` varchar(36) NOT NULL,
  `parent_category_id` varchar(36) DEFAULT NULL,
  `expanded` int(11) DEFAULT NULL,
  `seq_num` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dw_wizard_completed_category`
--

LOCK TABLES `dw_wizard_completed_category` WRITE;
/*!40000 ALTER TABLE `dw_wizard_completed_category` DISABLE KEYS */;
/*!40000 ALTER TABLE `dw_wizard_completed_category` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `dw_wizard_completed_page`
--

DROP TABLE IF EXISTS `dw_wizard_completed_page`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `dw_wizard_completed_page` (
  `id` varchar(36) NOT NULL,
  `completed_category_id` varchar(36) NOT NULL,
  `wizard_page_def_id` varchar(36) NOT NULL,
  `wizard_page_id` varchar(36) NOT NULL,
  `seq_num` int(11) DEFAULT NULL,
  `created` datetime DEFAULT NULL,
  `lastVisited` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dw_wizard_completed_page`
--

LOCK TABLES `dw_wizard_completed_page` WRITE;
/*!40000 ALTER TABLE `dw_wizard_completed_page` DISABLE KEYS */;
/*!40000 ALTER TABLE `dw_wizard_completed_page` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `dw_wizard_page`
--

DROP TABLE IF EXISTS `dw_wizard_page`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `dw_wizard_page` (
  `id` varchar(36) NOT NULL,
  `status` varchar(255) DEFAULT NULL,
  `wizard_page_def_id` varchar(36) NOT NULL,
  `modified` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dw_wizard_page`
--

LOCK TABLES `dw_wizard_page` WRITE;
/*!40000 ALTER TABLE `dw_wizard_page` DISABLE KEYS */;
/*!40000 ALTER TABLE `dw_wizard_page` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `dw_wizard_page_attachments`
--

DROP TABLE IF EXISTS `dw_wizard_page_attachments`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `dw_wizard_page_attachments` (
  `id` varchar(36) NOT NULL,
  `artifact_id` varchar(36) DEFAULT NULL,
  `wizard_page_id` varchar(36) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dw_wizard_page_attachments`
--

LOCK TABLES `dw_wizard_page_attachments` WRITE;
/*!40000 ALTER TABLE `dw_wizard_page_attachments` DISABLE KEYS */;
/*!40000 ALTER TABLE `dw_wizard_page_attachments` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `dw_wizard_page_def`
--

DROP TABLE IF EXISTS `dw_wizard_page_def`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `dw_wizard_page_def` (
  `id` varchar(36) NOT NULL,
  `initialStatus` varchar(255) DEFAULT NULL,
  `title` varchar(255) DEFAULT NULL,
  `description` varchar(255) DEFAULT NULL,
  `site_id` varchar(36) DEFAULT NULL,
  `guidance_id` varchar(36) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dw_wizard_page_def`
--

LOCK TABLES `dw_wizard_page_def` WRITE;
/*!40000 ALTER TABLE `dw_wizard_page_def` DISABLE KEYS */;
/*!40000 ALTER TABLE `dw_wizard_page_def` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `dw_wizard_page_def_add_forms`
--

DROP TABLE IF EXISTS `dw_wizard_page_def_add_forms`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `dw_wizard_page_def_add_forms` (
  `wizard_page_def_id` varchar(36) NOT NULL,
  `form_def_id` varchar(36) NOT NULL,
  `seq_num` int(11) DEFAULT NULL,
  PRIMARY KEY (`wizard_page_def_id`,`form_def_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dw_wizard_page_def_add_forms`
--

LOCK TABLES `dw_wizard_page_def_add_forms` WRITE;
/*!40000 ALTER TABLE `dw_wizard_page_def_add_forms` DISABLE KEYS */;
/*!40000 ALTER TABLE `dw_wizard_page_def_add_forms` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `dw_wizard_page_forms`
--

DROP TABLE IF EXISTS `dw_wizard_page_forms`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `dw_wizard_page_forms` (
  `id` varchar(36) NOT NULL,
  `artifact_id` varchar(36) DEFAULT NULL,
  `wizard_page_id` varchar(36) NOT NULL,
  `form_type` varchar(36) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dw_wizard_page_forms`
--

LOCK TABLES `dw_wizard_page_forms` WRITE;
/*!40000 ALTER TABLE `dw_wizard_page_forms` DISABLE KEYS */;
/*!40000 ALTER TABLE `dw_wizard_page_forms` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `dw_wizard_page_sequence`
--

DROP TABLE IF EXISTS `dw_wizard_page_sequence`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `dw_wizard_page_sequence` (
  `id` varchar(36) NOT NULL,
  `category_id` varchar(36) DEFAULT NULL,
  `wiz_page_def_id` varchar(36) DEFAULT NULL,
  `seq_num` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dw_wizard_page_sequence`
--

LOCK TABLES `dw_wizard_page_sequence` WRITE;
/*!40000 ALTER TABLE `dw_wizard_page_sequence` DISABLE KEYS */;
/*!40000 ALTER TABLE `dw_wizard_page_sequence` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `dw_wizard_style`
--

DROP TABLE IF EXISTS `dw_wizard_style`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `dw_wizard_style` (
  `id` varchar(36) NOT NULL,
  `name` varchar(255) DEFAULT NULL,
  `description` varchar(255) DEFAULT NULL,
  `globalState` int(11) DEFAULT NULL,
  `owner` varchar(255) NOT NULL,
  `styleFile` varchar(36) DEFAULT NULL,
  `siteId` varchar(36) DEFAULT NULL,
  `created` datetime DEFAULT NULL,
  `modified` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dw_wizard_style`
--

LOCK TABLES `dw_wizard_style` WRITE;
/*!40000 ALTER TABLE `dw_wizard_style` DISABLE KEYS */;
/*!40000 ALTER TABLE `dw_wizard_style` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `dw_wizard_support_item`
--

DROP TABLE IF EXISTS `dw_wizard_support_item`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `dw_wizard_support_item` (
  `id` varchar(36) NOT NULL,
  `wizard_id` varchar(36) NOT NULL,
  `item_id` varchar(36) NOT NULL,
  `generic_type` varchar(255) NOT NULL,
  `content_type` varchar(255) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dw_wizard_support_item`
--

LOCK TABLES `dw_wizard_support_item` WRITE;
/*!40000 ALTER TABLE `dw_wizard_support_item` DISABLE KEYS */;
/*!40000 ALTER TABLE `dw_wizard_support_item` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `dw_workflow_parent`
--

DROP TABLE IF EXISTS `dw_workflow_parent`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `dw_workflow_parent` (
  `id` varchar(36) NOT NULL,
  `reflection_device_id` varchar(36) DEFAULT NULL,
  `reflection_device_type` varchar(255) DEFAULT NULL,
  `evaluation_device_id` varchar(36) DEFAULT NULL,
  `evaluation_device_type` varchar(255) DEFAULT NULL,
  `review_device_id` varchar(36) DEFAULT NULL,
  `review_device_type` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dw_workflow_parent`
--

LOCK TABLES `dw_workflow_parent` WRITE;
/*!40000 ALTER TABLE `dw_workflow_parent` DISABLE KEYS */;
/*!40000 ALTER TABLE `dw_workflow_parent` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `email_template_item`
--

DROP TABLE IF EXISTS `email_template_item`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `email_template_item` (
  `ID` bigint(20) NOT NULL AUTO_INCREMENT,
  `LAST_MODIFIED` datetime NOT NULL,
  `OWNER` varchar(255) NOT NULL,
  `SUBJECT` longtext NOT NULL,
  `MESSAGE` longtext NOT NULL,
  `HTMLMESSAGE` longtext,
  `TEMPLATE_KEY` varchar(255) NOT NULL,
  `TEMPLATE_LOCALE` varchar(255) DEFAULT NULL,
  `defaultType` varchar(255) DEFAULT NULL,
  `VERSION` int(11) DEFAULT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `email_template_item`
--

LOCK TABLES `email_template_item` WRITE;
/*!40000 ALTER TABLE `email_template_item` DISABLE KEYS */;
INSERT INTO `email_template_item` VALUES (1,'2012-04-22 16:35:37','admin','[${localSakaiName}] A poll option you voted for has been deleted','Dear ${recipientFirstName},\n\nThe poll option you voted for in the site \'${siteTitle}\' has been deleted by a poll maintainer. The poll question is:\n\n${pollQuestion}\n\nPlease log in to ${localSakaiName} and place a new vote for the poll.',NULL,'polls.notifyDeletedOption','',NULL,1),(2,'2012-04-22 16:35:40','admin','${localSakaiName} Site Notification','\n			Dear ${userName},\n\n				You have been added to the following ${localSakaiName} site: \n					${siteName}\n				by ${currentUserName}.\n			\n			<#if newNonOfficialAccount == \"true\" >\n			<#if hasNonOfficialAccountUrl == \"true\" >	\n				To get a guest account, open the following site:\n					${nonOfficialAccountUrl}\n				and follow the steps listed.\n			\n			</#if>\n				Once you have your guest account, you can log in to ${localSakaiName}:\n				\n					1. Open ${localSakaiName}: ${localSakaiURL}\n					2. Click the Login button.\n					3. Type your guest account login and password, and click Login.\n					4. Click on the site tab to go to the site. (You will see two or more tabs in a row across the upper part of the screen.)\n			\n			<#else>		\n				To log in:\n\n					1. Open ${localSakaiName}: ${localSakaiURL}\n					2. Click the Login button.\n					3. Enter your username and password, and click Login.\n					4. Click on the site tab to go to the site. (You will see two or more tabs in a row across the upper part of the screen.)\n			</#if>\n		',NULL,'sitemange.notifyAddedParticipant','',NULL,1),(3,'2012-04-22 16:35:40','admin','${localSakaiName} NotificaciÃ³ de lloc\n		','${userName}: Se us ha\n			afegit al/s segÃ¼ent/s ${localSakaiName} lloc: per\n			${currentUserDisplayName}. <#if newNonOfficialAccount == \"true\" >Insert your institutions specific instructions for new guest users here \n\nQuan tingueu el vostre compte de convidat, ja podeu accedir-hi. ${localSakaiName} : \n1. Obriu ${localSakaiName} : ${localSakaiURL}\n2. Feu clic al botÃ³ Entrar.\n3. Escriviu el vostre compte d\'amic d\'inici de sessiÃ³ i contrasenya, i feu clic a Entrar.\n<#else >Per entrar:\n1. Obriu ${localSakaiName} : ${localSakaiURL}\n2. Feu clic al botÃ³ Entrar.\n3. Escriviu el vostre nom d\'usuari i contrasenya i feu clic a Entrar.\n</#if>4. Aneu al lloc, feu clic a la pestanya del lloc (veureu dues o mÃ©s pestanyes en una fila a la part superior de la pantalla).',NULL,'sitemange.notifyAddedParticipant','ca',NULL,1),(4,'2012-04-22 16:35:40','admin','${localSakaiName} ','${userName}:\n\n ${localSakaiName}\n ${userName}. \n\n<#if newNonOfficialAccount == \"true\" >Insert your institutions specific instructions for new guest users here \n\n ${localSakaiName} : \n ${localSakaiName} : ${localSakaiURL}\n\n\n<#else >\n ${localSakaiName} : ${localSakaiURL}\n\n\n</#if>',NULL,'sitemange.notifyAddedParticipant','en_GB',NULL,1),(5,'2012-04-22 16:35:40','admin','${localSakaiName} Site melding','${userName}:\n\nU bent toegevoegd aan de volgende ${localSakaiName}  site:\ndoor ${currentUserDisplayName}. \n\n<#if newNonOfficialAccount == \"true\" >Insert your institutions specific instructions for new guest users here \n\nZodra u uw gastaccount heeft, kunt u inloggen voor ${localSakaiName} : \n1. Open ${localSakaiName} : ${localSakaiURL}\n2. Klik op de inlog knop.\n3. Vul uw inloggegevens als gast in en klik op Inloggen.\n<#else >Voor inlog:\n1. Open ${localSakaiName} : ${localSakaiURL}\n2. Klik op de inlog knop.\n3. Vul uw gebruikersnaam en wachtwoord in en klik op Inloggen.\n</#if>4. Ga naar de site en klik op de site tab. (U ziet twee of meer tabs naast elkaar over het bovenste deel van het scherm.)',NULL,'sitemange.notifyAddedParticipant','nl',NULL,1),(6,'2012-04-22 16:35:40','admin','${localSakaiName} New User Notification ','Dear ${userName},\n\n An account on ${localSakaiName} (${localSakaiURL}) has been created for you by ${currentUserDisplayName}. To access your account:\n\n	1) Go to:\n		${localSakaiURL}\n	\n	2) Login using:\n		User Id: 	${userEid}\n		password: 	${newPassword} \n You can change your password after you have logged in, using the Account tool in your My Workspace.\n \n (This is an automated message from ${localSakaiName}.)\n',NULL,'sitemanage.notifyNewUserEmail','',NULL,1),(7,'2012-04-22 16:35:40','admin','${localSakaiName} Notificaci al nou usuari','${userName}:\n\nUs hem afegit a ${localSakaiName} (${localSakaiURL})per ${currentUserDisplayName}. \n\nLa vostra contrasenya Ã©s \n ${newPassword} \n\nDesprÃ©s podeu anar a l\'eina de Comptes al vostre lloc El meu espai de treball per reajustar-la.\n\n',NULL,'sitemanage.notifyNewUserEmail','ca',NULL,1),(8,'2012-04-22 16:35:40','admin','${localSakaiName} Nieuwe gebruiker melding','${userName}:\n\nJe bent toegevoegd aan ${localSakaiName} (${localSakaiURL})door ${currentUserDisplayName}. \n\nUw wachtwoord is \n ${newPassword} \n\nU kunt naar de \'Accountgegevens\' gaan in \'Mijn Werkruimte\' om het wachtwoord te wijzigen.\n\n',NULL,'sitemanage.notifyNewUserEmail','nl',NULL,1),(9,'2012-04-22 16:35:40','admin','${localSakaiName} ','${userName}:\n\nHa sido aÃ±adido a ${localSakaiName} (${localSakaiURL})por ${currentUserDisplayName}. \n\nSu password es \n ${newPassword} \n\nPuede ir a la herramienta de Cuentas en \'Mi Sito de Trabajo\' para inicializarlo.\n\n',NULL,'sitemanage.notifyNewUserEmail','es',NULL,1);
/*!40000 ALTER TABLE `email_template_item` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `gb_category_t`
--

DROP TABLE IF EXISTS `gb_category_t`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `gb_category_t` (
  `ID` bigint(20) NOT NULL AUTO_INCREMENT,
  `VERSION` int(11) NOT NULL,
  `GRADEBOOK_ID` bigint(20) NOT NULL,
  `NAME` varchar(255) NOT NULL,
  `WEIGHT` double DEFAULT NULL,
  `DROP_LOWEST` int(11) DEFAULT NULL,
  `REMOVED` bit(1) DEFAULT NULL,
  `IS_EXTRA_CREDIT` bit(1) DEFAULT NULL,
  `IS_EQUAL_WEIGHT_ASSNS` bit(1) DEFAULT NULL,
  `IS_UNWEIGHTED` bit(1) DEFAULT NULL,
  `CATEGORY_ORDER` int(11) DEFAULT NULL,
  `ENFORCE_POINT_WEIGHTING` bit(1) DEFAULT NULL,
  PRIMARY KEY (`ID`),
  KEY `FKCD333737325D7986` (`GRADEBOOK_ID`),
  CONSTRAINT `FKCD333737325D7986` FOREIGN KEY (`GRADEBOOK_ID`) REFERENCES `gb_gradebook_t` (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `gb_category_t`
--

LOCK TABLES `gb_category_t` WRITE;
/*!40000 ALTER TABLE `gb_category_t` DISABLE KEYS */;
/*!40000 ALTER TABLE `gb_category_t` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `gb_comment_t`
--

DROP TABLE IF EXISTS `gb_comment_t`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `gb_comment_t` (
  `ID` bigint(20) NOT NULL AUTO_INCREMENT,
  `VERSION` int(11) NOT NULL,
  `GRADER_ID` varchar(255) NOT NULL,
  `STUDENT_ID` varchar(255) NOT NULL,
  `COMMENT_TEXT` text,
  `DATE_RECORDED` datetime NOT NULL,
  `GRADABLE_OBJECT_ID` bigint(20) NOT NULL,
  PRIMARY KEY (`ID`),
  UNIQUE KEY `STUDENT_ID` (`STUDENT_ID`,`GRADABLE_OBJECT_ID`),
  KEY `FK7977DFF06F98CFF` (`GRADABLE_OBJECT_ID`),
  CONSTRAINT `FK7977DFF06F98CFF` FOREIGN KEY (`GRADABLE_OBJECT_ID`) REFERENCES `gb_gradable_object_t` (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `gb_comment_t`
--

LOCK TABLES `gb_comment_t` WRITE;
/*!40000 ALTER TABLE `gb_comment_t` DISABLE KEYS */;
/*!40000 ALTER TABLE `gb_comment_t` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `gb_gradable_object_t`
--

DROP TABLE IF EXISTS `gb_gradable_object_t`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `gb_gradable_object_t` (
  `ID` bigint(20) NOT NULL AUTO_INCREMENT,
  `OBJECT_TYPE_ID` int(11) NOT NULL,
  `VERSION` int(11) NOT NULL,
  `GRADEBOOK_ID` bigint(20) NOT NULL,
  `NAME` varchar(255) NOT NULL,
  `REMOVED` bit(1) DEFAULT NULL,
  `SORT_ORDER` int(11) DEFAULT NULL,
  `POINTS_POSSIBLE` double DEFAULT NULL,
  `DUE_DATE` date DEFAULT NULL,
  `NOT_COUNTED` bit(1) DEFAULT NULL,
  `EXTERNALLY_MAINTAINED` bit(1) DEFAULT NULL,
  `EXTERNAL_STUDENT_LINK` varchar(255) DEFAULT NULL,
  `EXTERNAL_INSTRUCTOR_LINK` varchar(255) DEFAULT NULL,
  `EXTERNAL_ID` varchar(255) DEFAULT NULL,
  `EXTERNAL_APP_NAME` varchar(255) DEFAULT NULL,
  `IS_EXTRA_CREDIT` bit(1) DEFAULT NULL,
  `ASSIGNMENT_WEIGHTING` double DEFAULT NULL,
  `RELEASED` bit(1) DEFAULT NULL,
  `CATEGORY_ID` bigint(20) DEFAULT NULL,
  `UNGRADED` bit(1) DEFAULT NULL,
  `IS_NULL_ZERO` bit(1) DEFAULT NULL,
  PRIMARY KEY (`ID`),
  KEY `FK759996A7F09DEFAE` (`CATEGORY_ID`),
  KEY `FK759996A7325D7986` (`GRADEBOOK_ID`),
  KEY `GB_GRADABLE_OBJ_ASN_IDX` (`OBJECT_TYPE_ID`,`GRADEBOOK_ID`,`NAME`,`REMOVED`),
  CONSTRAINT `FK759996A7325D7986` FOREIGN KEY (`GRADEBOOK_ID`) REFERENCES `gb_gradebook_t` (`ID`),
  CONSTRAINT `FK759996A7F09DEFAE` FOREIGN KEY (`CATEGORY_ID`) REFERENCES `gb_category_t` (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `gb_gradable_object_t`
--

LOCK TABLES `gb_gradable_object_t` WRITE;
/*!40000 ALTER TABLE `gb_gradable_object_t` DISABLE KEYS */;
/*!40000 ALTER TABLE `gb_gradable_object_t` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `gb_grade_map_t`
--

DROP TABLE IF EXISTS `gb_grade_map_t`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `gb_grade_map_t` (
  `ID` bigint(20) NOT NULL AUTO_INCREMENT,
  `OBJECT_TYPE_ID` int(11) NOT NULL,
  `VERSION` int(11) NOT NULL,
  `GRADEBOOK_ID` bigint(20) NOT NULL,
  `GB_GRADING_SCALE_T` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`ID`),
  KEY `FKADE11225181E947A` (`GB_GRADING_SCALE_T`),
  KEY `FKADE11225325D7986` (`GRADEBOOK_ID`),
  CONSTRAINT `FKADE11225325D7986` FOREIGN KEY (`GRADEBOOK_ID`) REFERENCES `gb_gradebook_t` (`ID`),
  CONSTRAINT `FKADE11225181E947A` FOREIGN KEY (`GB_GRADING_SCALE_T`) REFERENCES `gb_grading_scale_t` (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `gb_grade_map_t`
--

LOCK TABLES `gb_grade_map_t` WRITE;
/*!40000 ALTER TABLE `gb_grade_map_t` DISABLE KEYS */;
/*!40000 ALTER TABLE `gb_grade_map_t` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `gb_grade_record_t`
--

DROP TABLE IF EXISTS `gb_grade_record_t`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `gb_grade_record_t` (
  `ID` bigint(20) NOT NULL AUTO_INCREMENT,
  `OBJECT_TYPE_ID` int(11) NOT NULL,
  `VERSION` int(11) NOT NULL,
  `GRADABLE_OBJECT_ID` bigint(20) NOT NULL,
  `STUDENT_ID` varchar(255) NOT NULL,
  `GRADER_ID` varchar(255) NOT NULL,
  `DATE_RECORDED` datetime NOT NULL,
  `POINTS_EARNED` double DEFAULT NULL,
  `IS_EXCLUDED_FROM_GRADE` bit(1) DEFAULT NULL,
  `ENTERED_GRADE` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`ID`),
  UNIQUE KEY `GRADABLE_OBJECT_ID` (`GRADABLE_OBJECT_ID`,`STUDENT_ID`),
  KEY `FK46ACF7526F98CFF` (`GRADABLE_OBJECT_ID`),
  KEY `GB_GRADE_RECORD_O_T_IDX` (`OBJECT_TYPE_ID`),
  KEY `GB_GRADE_RECORD_STUDENT_ID_IDX` (`STUDENT_ID`),
  CONSTRAINT `FK46ACF7526F98CFF` FOREIGN KEY (`GRADABLE_OBJECT_ID`) REFERENCES `gb_gradable_object_t` (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `gb_grade_record_t`
--

LOCK TABLES `gb_grade_record_t` WRITE;
/*!40000 ALTER TABLE `gb_grade_record_t` DISABLE KEYS */;
/*!40000 ALTER TABLE `gb_grade_record_t` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `gb_grade_to_percent_mapping_t`
--

DROP TABLE IF EXISTS `gb_grade_to_percent_mapping_t`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `gb_grade_to_percent_mapping_t` (
  `GRADE_MAP_ID` bigint(20) NOT NULL,
  `PERCENT` double DEFAULT NULL,
  `LETTER_GRADE` varchar(255) NOT NULL,
  PRIMARY KEY (`GRADE_MAP_ID`,`LETTER_GRADE`),
  KEY `FKCDEA021162B659F1` (`GRADE_MAP_ID`),
  CONSTRAINT `FKCDEA021162B659F1` FOREIGN KEY (`GRADE_MAP_ID`) REFERENCES `gb_grade_map_t` (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `gb_grade_to_percent_mapping_t`
--

LOCK TABLES `gb_grade_to_percent_mapping_t` WRITE;
/*!40000 ALTER TABLE `gb_grade_to_percent_mapping_t` DISABLE KEYS */;
/*!40000 ALTER TABLE `gb_grade_to_percent_mapping_t` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `gb_gradebook_t`
--

DROP TABLE IF EXISTS `gb_gradebook_t`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `gb_gradebook_t` (
  `ID` bigint(20) NOT NULL AUTO_INCREMENT,
  `VERSION` int(11) NOT NULL,
  `GRADEBOOK_UID` varchar(255) NOT NULL,
  `NAME` varchar(255) NOT NULL,
  `SELECTED_GRADE_MAPPING_ID` bigint(20) DEFAULT NULL,
  `ASSIGNMENTS_DISPLAYED` bit(1) NOT NULL,
  `COURSE_GRADE_DISPLAYED` bit(1) NOT NULL,
  `ALL_ASSIGNMENTS_ENTERED` bit(1) NOT NULL,
  `LOCKED` bit(1) NOT NULL,
  `GRADE_TYPE` int(11) NOT NULL,
  `CATEGORY_TYPE` int(11) NOT NULL,
  `IS_EQUAL_WEIGHT_CATS` bit(1) DEFAULT NULL,
  `IS_SCALED_EXTRA_CREDIT` bit(1) DEFAULT NULL,
  `DO_SHOW_MEAN` bit(1) DEFAULT NULL,
  `DO_SHOW_MEDIAN` bit(1) DEFAULT NULL,
  `DO_SHOW_MODE` bit(1) DEFAULT NULL,
  `DO_SHOW_RANK` bit(1) DEFAULT NULL,
  `DO_SHOW_ITEM_STATS` bit(1) DEFAULT NULL,
  PRIMARY KEY (`ID`),
  UNIQUE KEY `GRADEBOOK_UID` (`GRADEBOOK_UID`),
  KEY `FK7C870191552B7E63` (`SELECTED_GRADE_MAPPING_ID`),
  CONSTRAINT `FK7C870191552B7E63` FOREIGN KEY (`SELECTED_GRADE_MAPPING_ID`) REFERENCES `gb_grade_map_t` (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `gb_gradebook_t`
--

LOCK TABLES `gb_gradebook_t` WRITE;
/*!40000 ALTER TABLE `gb_gradebook_t` DISABLE KEYS */;
/*!40000 ALTER TABLE `gb_gradebook_t` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `gb_grading_event_t`
--

DROP TABLE IF EXISTS `gb_grading_event_t`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `gb_grading_event_t` (
  `ID` bigint(20) NOT NULL AUTO_INCREMENT,
  `GRADABLE_OBJECT_ID` bigint(20) NOT NULL,
  `GRADER_ID` varchar(255) NOT NULL,
  `STUDENT_ID` varchar(255) NOT NULL,
  `DATE_GRADED` datetime NOT NULL,
  `GRADE` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`ID`),
  KEY `FK4C9D99E06F98CFF` (`GRADABLE_OBJECT_ID`),
  CONSTRAINT `FK4C9D99E06F98CFF` FOREIGN KEY (`GRADABLE_OBJECT_ID`) REFERENCES `gb_gradable_object_t` (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `gb_grading_event_t`
--

LOCK TABLES `gb_grading_event_t` WRITE;
/*!40000 ALTER TABLE `gb_grading_event_t` DISABLE KEYS */;
/*!40000 ALTER TABLE `gb_grading_event_t` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `gb_grading_scale_grades_t`
--

DROP TABLE IF EXISTS `gb_grading_scale_grades_t`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `gb_grading_scale_grades_t` (
  `GRADING_SCALE_ID` bigint(20) NOT NULL,
  `LETTER_GRADE` varchar(255) DEFAULT NULL,
  `GRADE_IDX` int(11) NOT NULL,
  PRIMARY KEY (`GRADING_SCALE_ID`,`GRADE_IDX`),
  KEY `FK5D3F0C95605CD0C5` (`GRADING_SCALE_ID`),
  CONSTRAINT `FK5D3F0C95605CD0C5` FOREIGN KEY (`GRADING_SCALE_ID`) REFERENCES `gb_grading_scale_t` (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `gb_grading_scale_grades_t`
--

LOCK TABLES `gb_grading_scale_grades_t` WRITE;
/*!40000 ALTER TABLE `gb_grading_scale_grades_t` DISABLE KEYS */;
/*!40000 ALTER TABLE `gb_grading_scale_grades_t` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `gb_grading_scale_percents_t`
--

DROP TABLE IF EXISTS `gb_grading_scale_percents_t`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `gb_grading_scale_percents_t` (
  `GRADING_SCALE_ID` bigint(20) NOT NULL,
  `PERCENT` double DEFAULT NULL,
  `LETTER_GRADE` varchar(255) NOT NULL,
  PRIMARY KEY (`GRADING_SCALE_ID`,`LETTER_GRADE`),
  KEY `FKC98BE467605CD0C5` (`GRADING_SCALE_ID`),
  CONSTRAINT `FKC98BE467605CD0C5` FOREIGN KEY (`GRADING_SCALE_ID`) REFERENCES `gb_grading_scale_t` (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `gb_grading_scale_percents_t`
--

LOCK TABLES `gb_grading_scale_percents_t` WRITE;
/*!40000 ALTER TABLE `gb_grading_scale_percents_t` DISABLE KEYS */;
/*!40000 ALTER TABLE `gb_grading_scale_percents_t` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `gb_grading_scale_t`
--

DROP TABLE IF EXISTS `gb_grading_scale_t`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `gb_grading_scale_t` (
  `ID` bigint(20) NOT NULL AUTO_INCREMENT,
  `OBJECT_TYPE_ID` int(11) NOT NULL,
  `VERSION` int(11) NOT NULL,
  `SCALE_UID` varchar(255) NOT NULL,
  `NAME` varchar(255) NOT NULL,
  `UNAVAILABLE` bit(1) DEFAULT NULL,
  PRIMARY KEY (`ID`),
  UNIQUE KEY `SCALE_UID` (`SCALE_UID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `gb_grading_scale_t`
--

LOCK TABLES `gb_grading_scale_t` WRITE;
/*!40000 ALTER TABLE `gb_grading_scale_t` DISABLE KEYS */;
/*!40000 ALTER TABLE `gb_grading_scale_t` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `gb_lettergrade_mapping`
--

DROP TABLE IF EXISTS `gb_lettergrade_mapping`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `gb_lettergrade_mapping` (
  `LG_MAPPING_ID` bigint(20) NOT NULL,
  `value` double DEFAULT NULL,
  `grade` varchar(255) NOT NULL,
  PRIMARY KEY (`LG_MAPPING_ID`,`grade`),
  KEY `FKC8CDDC5C626E35B6` (`LG_MAPPING_ID`),
  CONSTRAINT `FKC8CDDC5C626E35B6` FOREIGN KEY (`LG_MAPPING_ID`) REFERENCES `gb_lettergrade_percent_mapping` (`LGP_MAPPING_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `gb_lettergrade_mapping`
--

LOCK TABLES `gb_lettergrade_mapping` WRITE;
/*!40000 ALTER TABLE `gb_lettergrade_mapping` DISABLE KEYS */;
/*!40000 ALTER TABLE `gb_lettergrade_mapping` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `gb_lettergrade_percent_mapping`
--

DROP TABLE IF EXISTS `gb_lettergrade_percent_mapping`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `gb_lettergrade_percent_mapping` (
  `LGP_MAPPING_ID` bigint(20) NOT NULL AUTO_INCREMENT,
  `VERSION` int(11) NOT NULL,
  `MAPPING_TYPE` int(11) NOT NULL,
  `GRADEBOOK_ID` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`LGP_MAPPING_ID`),
  UNIQUE KEY `MAPPING_TYPE` (`MAPPING_TYPE`,`GRADEBOOK_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `gb_lettergrade_percent_mapping`
--

LOCK TABLES `gb_lettergrade_percent_mapping` WRITE;
/*!40000 ALTER TABLE `gb_lettergrade_percent_mapping` DISABLE KEYS */;
/*!40000 ALTER TABLE `gb_lettergrade_percent_mapping` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `gb_permission_t`
--

DROP TABLE IF EXISTS `gb_permission_t`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `gb_permission_t` (
  `GB_PERMISSION_ID` bigint(20) NOT NULL AUTO_INCREMENT,
  `VERSION` int(11) NOT NULL,
  `GRADEBOOK_ID` bigint(20) NOT NULL,
  `USER_ID` varchar(255) NOT NULL,
  `FUNCTION_NAME` varchar(255) NOT NULL,
  `CATEGORY_ID` bigint(20) DEFAULT NULL,
  `GROUP_ID` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`GB_PERMISSION_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `gb_permission_t`
--

LOCK TABLES `gb_permission_t` WRITE;
/*!40000 ALTER TABLE `gb_permission_t` DISABLE KEYS */;
/*!40000 ALTER TABLE `gb_permission_t` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `gb_property_t`
--

DROP TABLE IF EXISTS `gb_property_t`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `gb_property_t` (
  `ID` bigint(20) NOT NULL AUTO_INCREMENT,
  `VERSION` int(11) NOT NULL,
  `NAME` varchar(255) NOT NULL,
  `VALUE` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`ID`),
  UNIQUE KEY `NAME` (`NAME`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `gb_property_t`
--

LOCK TABLES `gb_property_t` WRITE;
/*!40000 ALTER TABLE `gb_property_t` DISABLE KEYS */;
/*!40000 ALTER TABLE `gb_property_t` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `gb_spreadsheet_t`
--

DROP TABLE IF EXISTS `gb_spreadsheet_t`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `gb_spreadsheet_t` (
  `ID` bigint(20) NOT NULL AUTO_INCREMENT,
  `VERSION` int(11) NOT NULL,
  `CREATOR` varchar(255) NOT NULL,
  `NAME` varchar(255) NOT NULL,
  `CONTENT` mediumtext NOT NULL,
  `DATE_CREATED` datetime NOT NULL,
  `GRADEBOOK_ID` bigint(20) NOT NULL,
  PRIMARY KEY (`ID`),
  KEY `FKB2FE801D325D7986` (`GRADEBOOK_ID`),
  CONSTRAINT `FKB2FE801D325D7986` FOREIGN KEY (`GRADEBOOK_ID`) REFERENCES `gb_gradebook_t` (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `gb_spreadsheet_t`
--

LOCK TABLES `gb_spreadsheet_t` WRITE;
/*!40000 ALTER TABLE `gb_spreadsheet_t` DISABLE KEYS */;
/*!40000 ALTER TABLE `gb_spreadsheet_t` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `mailarchive_channel`
--

DROP TABLE IF EXISTS `mailarchive_channel`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mailarchive_channel` (
  `CHANNEL_ID` varchar(99) NOT NULL,
  `NEXT_ID` int(11) DEFAULT NULL,
  `XML` longtext,
  UNIQUE KEY `MAILARCHIVE_CHANNEL_INDEX` (`CHANNEL_ID`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `mailarchive_channel`
--

LOCK TABLES `mailarchive_channel` WRITE;
/*!40000 ALTER TABLE `mailarchive_channel` DISABLE KEYS */;
INSERT INTO `mailarchive_channel` VALUES ('/mailarchive/channel/!site/postmaster',1,'<?xml version=\"1.0\" encoding=\"UTF-8\"?> <channel context=\"!site\" id=\"postmaster\" next-message-id=\"1\"> <properties/> </channel> ');
/*!40000 ALTER TABLE `mailarchive_channel` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `mailarchive_message`
--

DROP TABLE IF EXISTS `mailarchive_message`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mailarchive_message` (
  `CHANNEL_ID` varchar(99) NOT NULL,
  `MESSAGE_ID` varchar(36) NOT NULL,
  `DRAFT` char(1) DEFAULT NULL,
  `PUBVIEW` char(1) DEFAULT NULL,
  `OWNER` varchar(99) DEFAULT NULL,
  `MESSAGE_DATE` datetime NOT NULL,
  `XML` longtext,
  `SUBJECT` varchar(255) DEFAULT NULL,
  `BODY` longtext,
  PRIMARY KEY (`CHANNEL_ID`,`MESSAGE_ID`),
  KEY `IE_MAILARC_MSG_CHAN` (`CHANNEL_ID`),
  KEY `IE_MAILARC_MSG_ATTRIB` (`DRAFT`,`PUBVIEW`,`OWNER`),
  KEY `IE_MAILARC_MSG_DATE` (`MESSAGE_DATE`),
  KEY `IE_MAILARC_MSG_DATE_DESC` (`MESSAGE_DATE`),
  KEY `MAILARC_MSG_CDD` (`CHANNEL_ID`,`MESSAGE_DATE`,`DRAFT`),
  KEY `IE_MAILARC_SUBJECT` (`SUBJECT`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `mailarchive_message`
--

LOCK TABLES `mailarchive_message` WRITE;
/*!40000 ALTER TABLE `mailarchive_message` DISABLE KEYS */;
/*!40000 ALTER TABLE `mailarchive_message` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `metaobj_form_def`
--

DROP TABLE IF EXISTS `metaobj_form_def`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `metaobj_form_def` (
  `id` varchar(36) NOT NULL,
  `description` varchar(255) DEFAULT NULL,
  `documentRoot` varchar(255) NOT NULL,
  `owner` varchar(255) NOT NULL,
  `created` datetime NOT NULL,
  `modified` datetime NOT NULL,
  `systemOnly` bit(1) NOT NULL,
  `externalType` varchar(255) NOT NULL,
  `siteId` varchar(255) DEFAULT NULL,
  `siteState` int(11) NOT NULL,
  `globalState` int(11) NOT NULL,
  `schemaData` longblob NOT NULL,
  `instruction` text,
  `schema_hash` varchar(255) DEFAULT NULL,
  `alternateCreateXslt` varchar(36) DEFAULT NULL,
  `alternateViewXslt` varchar(36) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `metaobj_form_def`
--

LOCK TABLES `metaobj_form_def` WRITE;
/*!40000 ALTER TABLE `metaobj_form_def` DISABLE KEYS */;
/*!40000 ALTER TABLE `metaobj_form_def` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `mfr_area_t`
--

DROP TABLE IF EXISTS `mfr_area_t`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mfr_area_t` (
  `ID` bigint(20) NOT NULL AUTO_INCREMENT,
  `VERSION` int(11) NOT NULL,
  `UUID` varchar(36) NOT NULL,
  `CREATED` datetime NOT NULL,
  `CREATED_BY` varchar(36) NOT NULL,
  `MODIFIED` datetime NOT NULL,
  `MODIFIED_BY` varchar(36) NOT NULL,
  `CONTEXT_ID` varchar(255) NOT NULL,
  `NAME` varchar(255) NOT NULL,
  `HIDDEN` bit(1) NOT NULL,
  `TYPE_UUID` varchar(36) NOT NULL,
  `ENABLED` bit(1) NOT NULL,
  `SENDEMAILOUT` bit(1) NOT NULL,
  `LOCKED` bit(1) NOT NULL,
  `MODERATED` bit(1) NOT NULL,
  `AUTO_MARK_THREADS_READ` bit(1) NOT NULL,
  PRIMARY KEY (`ID`),
  UNIQUE KEY `CONTEXT_ID` (`CONTEXT_ID`,`TYPE_UUID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `mfr_area_t`
--

LOCK TABLES `mfr_area_t` WRITE;
/*!40000 ALTER TABLE `mfr_area_t` DISABLE KEYS */;
/*!40000 ALTER TABLE `mfr_area_t` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `mfr_attachment_t`
--

DROP TABLE IF EXISTS `mfr_attachment_t`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mfr_attachment_t` (
  `ID` bigint(20) NOT NULL AUTO_INCREMENT,
  `VERSION` int(11) NOT NULL,
  `UUID` varchar(36) NOT NULL,
  `CREATED` datetime NOT NULL,
  `CREATED_BY` varchar(255) NOT NULL,
  `MODIFIED` datetime NOT NULL,
  `MODIFIED_BY` varchar(255) NOT NULL,
  `ATTACHMENT_ID` varchar(255) NOT NULL,
  `ATTACHMENT_URL` varchar(255) NOT NULL,
  `ATTACHMENT_NAME` varchar(255) NOT NULL,
  `ATTACHMENT_SIZE` varchar(255) NOT NULL,
  `ATTACHMENT_TYPE` varchar(255) NOT NULL,
  `m_surrogateKey` bigint(20) DEFAULT NULL,
  `of_surrogateKey` bigint(20) DEFAULT NULL,
  `pf_surrogateKey` bigint(20) DEFAULT NULL,
  `t_surrogateKey` bigint(20) DEFAULT NULL,
  `of_urrogateKey` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`ID`),
  KEY `FK7B2D5CDE5B252FAE` (`of_urrogateKey`),
  KEY `FK7B2D5CDE7DEF8466` (`t_surrogateKey`),
  KEY `FK7B2D5CDE74C7E92B` (`of_surrogateKey`),
  KEY `FK7B2D5CDE82FAB29` (`pf_surrogateKey`),
  KEY `FK7B2D5CDE58F99AA5` (`m_surrogateKey`),
  CONSTRAINT `FK7B2D5CDE58F99AA5` FOREIGN KEY (`m_surrogateKey`) REFERENCES `mfr_message_t` (`ID`),
  CONSTRAINT `FK7B2D5CDE5B252FAE` FOREIGN KEY (`of_urrogateKey`) REFERENCES `mfr_open_forum_t` (`ID`),
  CONSTRAINT `FK7B2D5CDE74C7E92B` FOREIGN KEY (`of_surrogateKey`) REFERENCES `mfr_open_forum_t` (`ID`),
  CONSTRAINT `FK7B2D5CDE7DEF8466` FOREIGN KEY (`t_surrogateKey`) REFERENCES `mfr_topic_t` (`ID`),
  CONSTRAINT `FK7B2D5CDE82FAB29` FOREIGN KEY (`pf_surrogateKey`) REFERENCES `mfr_private_forum_t` (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `mfr_attachment_t`
--

LOCK TABLES `mfr_attachment_t` WRITE;
/*!40000 ALTER TABLE `mfr_attachment_t` DISABLE KEYS */;
/*!40000 ALTER TABLE `mfr_attachment_t` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `mfr_date_restrictions_t`
--

DROP TABLE IF EXISTS `mfr_date_restrictions_t`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mfr_date_restrictions_t` (
  `ID` bigint(20) NOT NULL AUTO_INCREMENT,
  `VERSION` int(11) NOT NULL,
  `VISIBLE` datetime NOT NULL,
  `VISIBLE_POST_ON_SCHEDULE` bit(1) NOT NULL,
  `POSTING_ALLOWED` datetime NOT NULL,
  `PSTNG_ALLWD_PST_ON_SCHD` bit(1) NOT NULL,
  `READ_ONLY` datetime NOT NULL,
  `READ_ONLY_POST_ON_SCHEDULE` bit(1) NOT NULL,
  `HIDDEN` datetime NOT NULL,
  `HIDDEN_POST_ON_SCHEDULE` bit(1) NOT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `mfr_date_restrictions_t`
--

LOCK TABLES `mfr_date_restrictions_t` WRITE;
/*!40000 ALTER TABLE `mfr_date_restrictions_t` DISABLE KEYS */;
/*!40000 ALTER TABLE `mfr_date_restrictions_t` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `mfr_email_notification_t`
--

DROP TABLE IF EXISTS `mfr_email_notification_t`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mfr_email_notification_t` (
  `ID` bigint(20) NOT NULL AUTO_INCREMENT,
  `VERSION` int(11) NOT NULL,
  `USER_ID` varchar(255) NOT NULL,
  `CONTEXT_ID` varchar(255) NOT NULL,
  `NOTIFICATION_LEVEL` varchar(1) NOT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `mfr_email_notification_t`
--

LOCK TABLES `mfr_email_notification_t` WRITE;
/*!40000 ALTER TABLE `mfr_email_notification_t` DISABLE KEYS */;
/*!40000 ALTER TABLE `mfr_email_notification_t` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `mfr_label_t`
--

DROP TABLE IF EXISTS `mfr_label_t`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mfr_label_t` (
  `ID` bigint(20) NOT NULL AUTO_INCREMENT,
  `VERSION` int(11) NOT NULL,
  `UUID` varchar(36) NOT NULL,
  `CREATED` datetime NOT NULL,
  `CREATED_BY` varchar(36) NOT NULL,
  `MODIFIED` datetime NOT NULL,
  `MODIFIED_BY` varchar(36) NOT NULL,
  `KEY_C` varchar(255) NOT NULL,
  `VALUE_C` varchar(255) NOT NULL,
  `df_surrogateKey` bigint(20) DEFAULT NULL,
  `df_index_col` int(11) DEFAULT NULL,
  `dt_surrogateKey` bigint(20) DEFAULT NULL,
  `dt_index_col` int(11) DEFAULT NULL,
  PRIMARY KEY (`ID`),
  KEY `FKC661154329B20882` (`df_surrogateKey`),
  KEY `FKC661154320BD9842` (`dt_surrogateKey`),
  CONSTRAINT `FKC661154320BD9842` FOREIGN KEY (`dt_surrogateKey`) REFERENCES `mfr_topic_t` (`ID`),
  CONSTRAINT `FKC661154329B20882` FOREIGN KEY (`df_surrogateKey`) REFERENCES `mfr_open_forum_t` (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `mfr_label_t`
--

LOCK TABLES `mfr_label_t` WRITE;
/*!40000 ALTER TABLE `mfr_label_t` DISABLE KEYS */;
/*!40000 ALTER TABLE `mfr_label_t` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `mfr_membership_item_t`
--

DROP TABLE IF EXISTS `mfr_membership_item_t`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mfr_membership_item_t` (
  `ID` bigint(20) NOT NULL AUTO_INCREMENT,
  `VERSION` int(11) NOT NULL,
  `UUID` varchar(36) NOT NULL,
  `CREATED` datetime NOT NULL,
  `CREATED_BY` varchar(255) NOT NULL,
  `MODIFIED` datetime NOT NULL,
  `MODIFIED_BY` varchar(255) NOT NULL,
  `NAME` varchar(255) NOT NULL,
  `TYPE` int(11) NOT NULL,
  `PERMISSION_LEVEL_NAME` varchar(255) NOT NULL,
  `PERMISSION_LEVEL` bigint(20) DEFAULT NULL,
  `t_surrogateKey` bigint(20) DEFAULT NULL,
  `of_surrogateKey` bigint(20) DEFAULT NULL,
  `a_surrogateKey` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`ID`),
  UNIQUE KEY `PERMISSION_LEVEL` (`PERMISSION_LEVEL`),
  KEY `FKE03761CBA306F94D` (`a_surrogateKey`),
  KEY `FKE03761CB7DEF8466` (`t_surrogateKey`),
  KEY `FKE03761CB74C7E92B` (`of_surrogateKey`),
  KEY `FKE03761CB88085F8E` (`PERMISSION_LEVEL`),
  CONSTRAINT `FKE03761CB88085F8E` FOREIGN KEY (`PERMISSION_LEVEL`) REFERENCES `mfr_permission_level_t` (`ID`),
  CONSTRAINT `FKE03761CB74C7E92B` FOREIGN KEY (`of_surrogateKey`) REFERENCES `mfr_open_forum_t` (`ID`),
  CONSTRAINT `FKE03761CB7DEF8466` FOREIGN KEY (`t_surrogateKey`) REFERENCES `mfr_topic_t` (`ID`),
  CONSTRAINT `FKE03761CBA306F94D` FOREIGN KEY (`a_surrogateKey`) REFERENCES `mfr_area_t` (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `mfr_membership_item_t`
--

LOCK TABLES `mfr_membership_item_t` WRITE;
/*!40000 ALTER TABLE `mfr_membership_item_t` DISABLE KEYS */;
/*!40000 ALTER TABLE `mfr_membership_item_t` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `mfr_message_t`
--

DROP TABLE IF EXISTS `mfr_message_t`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mfr_message_t` (
  `ID` bigint(20) NOT NULL AUTO_INCREMENT,
  `MESSAGE_DTYPE` varchar(2) NOT NULL,
  `VERSION` int(11) NOT NULL,
  `UUID` varchar(36) NOT NULL,
  `CREATED` datetime NOT NULL,
  `CREATED_BY` varchar(36) NOT NULL,
  `MODIFIED` datetime NOT NULL,
  `MODIFIED_BY` varchar(36) NOT NULL,
  `TITLE` varchar(255) NOT NULL,
  `BODY` text,
  `AUTHOR` varchar(255) NOT NULL,
  `HAS_ATTACHMENTS` bit(1) NOT NULL,
  `GRADEASSIGNMENTNAME` varchar(255) DEFAULT NULL,
  `NUM_READERS` int(11) DEFAULT NULL,
  `LABEL` varchar(255) DEFAULT NULL,
  `IN_REPLY_TO` bigint(20) DEFAULT NULL,
  `THREADID` bigint(20) DEFAULT NULL,
  `LASTTHREADATE` datetime DEFAULT NULL,
  `LASTTHREAPOST` bigint(20) DEFAULT NULL,
  `TYPE_UUID` varchar(36) NOT NULL,
  `APPROVED` bit(1) DEFAULT NULL,
  `DRAFT` bit(1) NOT NULL,
  `DELETED` bit(1) NOT NULL,
  `surrogateKey` bigint(20) DEFAULT NULL,
  `EXTERNAL_EMAIL` bit(1) DEFAULT NULL,
  `EXTERNAL_EMAIL_ADDRESS` varchar(255) DEFAULT NULL,
  `RECIPIENTS_AS_TEXT` text,
  PRIMARY KEY (`ID`),
  KEY `FK80C1A316A2D0BE7B` (`surrogateKey`),
  KEY `FK80C1A31650339D56` (`IN_REPLY_TO`),
  CONSTRAINT `FK80C1A31650339D56` FOREIGN KEY (`IN_REPLY_TO`) REFERENCES `mfr_message_t` (`ID`),
  CONSTRAINT `FK80C1A316A2D0BE7B` FOREIGN KEY (`surrogateKey`) REFERENCES `mfr_topic_t` (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `mfr_message_t`
--

LOCK TABLES `mfr_message_t` WRITE;
/*!40000 ALTER TABLE `mfr_message_t` DISABLE KEYS */;
/*!40000 ALTER TABLE `mfr_message_t` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `mfr_open_forum_t`
--

DROP TABLE IF EXISTS `mfr_open_forum_t`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mfr_open_forum_t` (
  `ID` bigint(20) NOT NULL AUTO_INCREMENT,
  `FORUM_DTYPE` varchar(2) NOT NULL,
  `VERSION` int(11) NOT NULL,
  `UUID` varchar(36) NOT NULL,
  `CREATED` datetime NOT NULL,
  `CREATED_BY` varchar(36) NOT NULL,
  `MODIFIED` datetime NOT NULL,
  `MODIFIED_BY` varchar(36) NOT NULL,
  `DEFAULTASSIGNNAME` varchar(255) DEFAULT NULL,
  `TITLE` varchar(255) NOT NULL,
  `SHORT_DESCRIPTION` varchar(255) DEFAULT NULL,
  `EXTENDED_DESCRIPTION` longtext,
  `TYPE_UUID` varchar(36) NOT NULL,
  `SORT_INDEX` int(11) NOT NULL,
  `LOCKED` bit(1) NOT NULL,
  `DRAFT` bit(1) DEFAULT NULL,
  `surrogateKey` bigint(20) DEFAULT NULL,
  `MODERATED` bit(1) NOT NULL,
  `AUTO_MARK_THREADS_READ` bit(1) NOT NULL,
  PRIMARY KEY (`ID`),
  KEY `FKC17608478B5E2A2F` (`surrogateKey`),
  CONSTRAINT `FKC17608478B5E2A2F` FOREIGN KEY (`surrogateKey`) REFERENCES `mfr_area_t` (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `mfr_open_forum_t`
--

LOCK TABLES `mfr_open_forum_t` WRITE;
/*!40000 ALTER TABLE `mfr_open_forum_t` DISABLE KEYS */;
/*!40000 ALTER TABLE `mfr_open_forum_t` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `mfr_permission_level_t`
--

DROP TABLE IF EXISTS `mfr_permission_level_t`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mfr_permission_level_t` (
  `ID` bigint(20) NOT NULL AUTO_INCREMENT,
  `VERSION` int(11) NOT NULL,
  `UUID` varchar(36) NOT NULL,
  `CREATED` datetime NOT NULL,
  `CREATED_BY` varchar(255) NOT NULL,
  `MODIFIED` datetime NOT NULL,
  `MODIFIED_BY` varchar(255) NOT NULL,
  `NAME` varchar(50) NOT NULL,
  `TYPE_UUID` varchar(36) NOT NULL,
  `CHANGE_SETTINGS` bit(1) NOT NULL,
  `DELETE_ANY` bit(1) NOT NULL,
  `DELETE_OWN` bit(1) NOT NULL,
  `MARK_AS_READ` bit(1) NOT NULL,
  `MOVE_POSTING` bit(1) NOT NULL,
  `NEW_FORUM` bit(1) NOT NULL,
  `NEW_RESPONSE` bit(1) NOT NULL,
  `NEW_RESPONSE_TO_RESPONSE` bit(1) NOT NULL,
  `NEW_TOPIC` bit(1) NOT NULL,
  `POST_TO_GRADEBOOK` bit(1) NOT NULL,
  `X_READ` bit(1) NOT NULL,
  `REVISE_ANY` bit(1) NOT NULL,
  `REVISE_OWN` bit(1) NOT NULL,
  `MODERATE_POSTINGS` bit(1) NOT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `mfr_permission_level_t`
--

LOCK TABLES `mfr_permission_level_t` WRITE;
/*!40000 ALTER TABLE `mfr_permission_level_t` DISABLE KEYS */;
INSERT INTO `mfr_permission_level_t` VALUES (1,0,'fdf8f0b8-0600-40a3-a1da-5db4d86e004e','2012-04-22 16:35:33','test-user','2012-04-22 16:35:33','test-user','Owner','930255bc-a71c-4324-892d-961fc78ca786','','','\0','','','','','','','','','','\0',''),(2,0,'3c09c4a7-c1a1-4713-a8d3-a57c23f5728f','2012-04-22 16:35:33','test-user','2012-04-22 16:35:33','test-user','Author','6747d673-9a4c-48a0-8d4b-1f1036fb719f','','\0','','','','','','','','','','\0','','\0'),(3,0,'cd99b965-a20a-4db4-9648-373a0d247a82','2012-04-22 16:35:33','test-user','2012-04-22 16:35:33','test-user','Contributor','5e6ab371-3d62-4594-aef6-6aab0d6ea084','\0','\0','\0','','\0','\0','','','\0','\0','','\0','\0','\0'),(4,0,'e87bb121-1a5d-49c0-bda1-8798e2088266','2012-04-22 16:35:33','test-user','2012-04-22 16:35:33','test-user','Reviewer','639dbcca-0111-4b3a-b51f-6d10ab9fc962','\0','\0','\0','','\0','\0','\0','\0','\0','\0','','\0','\0','\0'),(5,0,'bc3ae19a-4204-4449-a88f-13fce5d14f97','2012-04-22 16:35:33','test-user','2012-04-22 16:35:33','test-user','Nonediting Author','030c33aa-7c2c-413f-9c61-375cf03e4870','','\0','\0','','\0','','','','','','','\0','','\0'),(6,0,'e4cb5d95-6952-4247-8108-61f85bcd29f2','2012-04-22 16:35:33','test-user','2012-04-22 16:35:33','test-user','None','117e234f-bdf3-47fc-863f-d93cdb5895cb','\0','\0','\0','\0','\0','\0','\0','\0','\0','\0','\0','\0','\0','\0');
/*!40000 ALTER TABLE `mfr_permission_level_t` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `mfr_private_forum_t`
--

DROP TABLE IF EXISTS `mfr_private_forum_t`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mfr_private_forum_t` (
  `ID` bigint(20) NOT NULL AUTO_INCREMENT,
  `VERSION` int(11) NOT NULL,
  `UUID` varchar(36) NOT NULL,
  `CREATED` datetime NOT NULL,
  `CREATED_BY` varchar(36) NOT NULL,
  `MODIFIED` datetime NOT NULL,
  `MODIFIED_BY` varchar(36) NOT NULL,
  `TITLE` varchar(255) NOT NULL,
  `SHORT_DESCRIPTION` varchar(255) DEFAULT NULL,
  `EXTENDED_DESCRIPTION` longtext,
  `TYPE_UUID` varchar(36) NOT NULL,
  `SORT_INDEX` int(11) NOT NULL,
  `OWNER` varchar(255) NOT NULL,
  `AUTO_FORWARD` bit(1) DEFAULT NULL,
  `AUTO_FORWARD_EMAIL` varchar(255) DEFAULT NULL,
  `PREVIEW_PANE_ENABLED` bit(1) DEFAULT NULL,
  `surrogateKey` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`ID`),
  UNIQUE KEY `OWNER` (`OWNER`,`surrogateKey`),
  KEY `FKA9EE57548B5E2A2F` (`surrogateKey`),
  CONSTRAINT `FKA9EE57548B5E2A2F` FOREIGN KEY (`surrogateKey`) REFERENCES `mfr_area_t` (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `mfr_private_forum_t`
--

LOCK TABLES `mfr_private_forum_t` WRITE;
/*!40000 ALTER TABLE `mfr_private_forum_t` DISABLE KEYS */;
/*!40000 ALTER TABLE `mfr_private_forum_t` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `mfr_pvt_msg_usr_t`
--

DROP TABLE IF EXISTS `mfr_pvt_msg_usr_t`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mfr_pvt_msg_usr_t` (
  `messageSurrogateKey` bigint(20) NOT NULL,
  `USER_ID` varchar(255) NOT NULL,
  `TYPE_UUID` varchar(255) NOT NULL,
  `CONTEXT_ID` varchar(255) NOT NULL,
  `READ_STATUS` bit(1) NOT NULL,
  `user_index_col` int(11) NOT NULL,
  PRIMARY KEY (`messageSurrogateKey`,`user_index_col`),
  KEY `FKC4DE0E1473D286ED` (`messageSurrogateKey`),
  CONSTRAINT `FKC4DE0E1473D286ED` FOREIGN KEY (`messageSurrogateKey`) REFERENCES `mfr_message_t` (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `mfr_pvt_msg_usr_t`
--

LOCK TABLES `mfr_pvt_msg_usr_t` WRITE;
/*!40000 ALTER TABLE `mfr_pvt_msg_usr_t` DISABLE KEYS */;
/*!40000 ALTER TABLE `mfr_pvt_msg_usr_t` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `mfr_synoptic_item`
--

DROP TABLE IF EXISTS `mfr_synoptic_item`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mfr_synoptic_item` (
  `SYNOPTIC_ITEM_ID` bigint(20) NOT NULL AUTO_INCREMENT,
  `VERSION` int(11) NOT NULL,
  `USER_ID` varchar(36) NOT NULL,
  `SITE_ID` varchar(99) NOT NULL,
  `SITE_TITLE` varchar(255) DEFAULT NULL,
  `NEW_MESSAGES_COUNT` int(11) DEFAULT NULL,
  `MESSAGES_LAST_VISIT_DT` datetime DEFAULT NULL,
  `NEW_FORUM_COUNT` int(11) DEFAULT NULL,
  `FORUM_LAST_VISIT_DT` datetime DEFAULT NULL,
  `HIDE_ITEM` bit(1) DEFAULT NULL,
  PRIMARY KEY (`SYNOPTIC_ITEM_ID`),
  UNIQUE KEY `USER_ID` (`USER_ID`,`SITE_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `mfr_synoptic_item`
--

LOCK TABLES `mfr_synoptic_item` WRITE;
/*!40000 ALTER TABLE `mfr_synoptic_item` DISABLE KEYS */;
/*!40000 ALTER TABLE `mfr_synoptic_item` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `mfr_topic_t`
--

DROP TABLE IF EXISTS `mfr_topic_t`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mfr_topic_t` (
  `ID` bigint(20) NOT NULL AUTO_INCREMENT,
  `TOPIC_DTYPE` varchar(2) NOT NULL,
  `VERSION` int(11) NOT NULL,
  `UUID` varchar(36) NOT NULL,
  `CREATED` datetime NOT NULL,
  `CREATED_BY` varchar(36) NOT NULL,
  `MODIFIED` datetime NOT NULL,
  `MODIFIED_BY` varchar(36) NOT NULL,
  `DEFAULTASSIGNNAME` varchar(255) DEFAULT NULL,
  `TITLE` varchar(255) NOT NULL,
  `SHORT_DESCRIPTION` varchar(255) DEFAULT NULL,
  `EXTENDED_DESCRIPTION` longtext,
  `MODERATED` bit(1) NOT NULL,
  `AUTO_MARK_THREADS_READ` bit(1) NOT NULL,
  `MUTABLE` bit(1) NOT NULL,
  `SORT_INDEX` int(11) NOT NULL,
  `TYPE_UUID` varchar(36) NOT NULL,
  `of_surrogateKey` bigint(20) DEFAULT NULL,
  `pf_surrogateKey` bigint(20) DEFAULT NULL,
  `USER_ID` varchar(255) DEFAULT NULL,
  `CONTEXT_ID` varchar(36) DEFAULT NULL,
  `pt_surrogateKey` bigint(20) DEFAULT NULL,
  `LOCKED` bit(1) DEFAULT NULL,
  `DRAFT` bit(1) DEFAULT NULL,
  `CONFIDENTIAL_RESPONSES` bit(1) DEFAULT NULL,
  `MUST_RESPOND_BEFORE_READING` bit(1) DEFAULT NULL,
  `HOUR_BEFORE_RESPONSES_VISIBLE` int(11) DEFAULT NULL,
  PRIMARY KEY (`ID`),
  KEY `FK863DC0BEFF3B3AE9` (`pt_surrogateKey`),
  KEY `FK863DC0BE74C7E92B` (`of_surrogateKey`),
  KEY `FK863DC0BE82FAB29` (`pf_surrogateKey`),
  CONSTRAINT `FK863DC0BE82FAB29` FOREIGN KEY (`pf_surrogateKey`) REFERENCES `mfr_private_forum_t` (`ID`),
  CONSTRAINT `FK863DC0BE74C7E92B` FOREIGN KEY (`of_surrogateKey`) REFERENCES `mfr_open_forum_t` (`ID`),
  CONSTRAINT `FK863DC0BEFF3B3AE9` FOREIGN KEY (`pt_surrogateKey`) REFERENCES `mfr_topic_t` (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `mfr_topic_t`
--

LOCK TABLES `mfr_topic_t` WRITE;
/*!40000 ALTER TABLE `mfr_topic_t` DISABLE KEYS */;
/*!40000 ALTER TABLE `mfr_topic_t` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `mfr_unread_status_t`
--

DROP TABLE IF EXISTS `mfr_unread_status_t`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mfr_unread_status_t` (
  `ID` bigint(20) NOT NULL AUTO_INCREMENT,
  `VERSION` int(11) NOT NULL,
  `TOPIC_C` bigint(20) NOT NULL,
  `MESSAGE_C` bigint(20) NOT NULL,
  `USER_C` varchar(255) NOT NULL,
  `READ_C` bit(1) NOT NULL,
  PRIMARY KEY (`ID`),
  UNIQUE KEY `TOPIC_C` (`TOPIC_C`,`MESSAGE_C`,`USER_C`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `mfr_unread_status_t`
--

LOCK TABLES `mfr_unread_status_t` WRITE;
/*!40000 ALTER TABLE `mfr_unread_status_t` DISABLE KEYS */;
/*!40000 ALTER TABLE `mfr_unread_status_t` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `osp_authz_simple`
--

DROP TABLE IF EXISTS `osp_authz_simple`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `osp_authz_simple` (
  `id` varchar(36) NOT NULL,
  `qualifier_id` varchar(255) NOT NULL,
  `agent_id` varchar(255) NOT NULL,
  `function_name` varchar(255) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `osp_authz_simple`
--

LOCK TABLES `osp_authz_simple` WRITE;
/*!40000 ALTER TABLE `osp_authz_simple` DISABLE KEYS */;
/*!40000 ALTER TABLE `osp_authz_simple` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `osp_completed_wiz_category`
--

DROP TABLE IF EXISTS `osp_completed_wiz_category`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `osp_completed_wiz_category` (
  `id` varchar(36) NOT NULL,
  `completed_wizard_id` varchar(36) DEFAULT NULL,
  `category_id` varchar(36) DEFAULT NULL,
  `expanded` bit(1) DEFAULT NULL,
  `seq_num` int(11) DEFAULT NULL,
  `parent_category_id` varchar(36) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FK4EC54F7C21B27839` (`completed_wizard_id`),
  KEY `FK4EC54F7C6EA23D5D` (`category_id`),
  KEY `FK4EC54F7CF992DFC3` (`parent_category_id`),
  CONSTRAINT `FK4EC54F7CF992DFC3` FOREIGN KEY (`parent_category_id`) REFERENCES `osp_completed_wiz_category` (`id`),
  CONSTRAINT `FK4EC54F7C21B27839` FOREIGN KEY (`completed_wizard_id`) REFERENCES `osp_completed_wizard` (`id`),
  CONSTRAINT `FK4EC54F7C6EA23D5D` FOREIGN KEY (`category_id`) REFERENCES `osp_wizard_category` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `osp_completed_wiz_category`
--

LOCK TABLES `osp_completed_wiz_category` WRITE;
/*!40000 ALTER TABLE `osp_completed_wiz_category` DISABLE KEYS */;
/*!40000 ALTER TABLE `osp_completed_wiz_category` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `osp_completed_wizard`
--

DROP TABLE IF EXISTS `osp_completed_wizard`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `osp_completed_wizard` (
  `id` varchar(36) NOT NULL,
  `owner_id` varchar(255) NOT NULL,
  `created` datetime NOT NULL,
  `lastVisited` datetime NOT NULL,
  `status` varchar(255) DEFAULT NULL,
  `wizard_id` varchar(36) DEFAULT NULL,
  `root_category` varchar(36) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `root_category` (`root_category`),
  KEY `FKABC9DEB2D62513B2` (`wizard_id`),
  KEY `FKABC9DEB2D4C797` (`root_category`),
  CONSTRAINT `FKABC9DEB2D4C797` FOREIGN KEY (`root_category`) REFERENCES `osp_completed_wiz_category` (`id`),
  CONSTRAINT `FKABC9DEB2D62513B2` FOREIGN KEY (`wizard_id`) REFERENCES `osp_wizard` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `osp_completed_wizard`
--

LOCK TABLES `osp_completed_wizard` WRITE;
/*!40000 ALTER TABLE `osp_completed_wizard` DISABLE KEYS */;
/*!40000 ALTER TABLE `osp_completed_wizard` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `osp_completed_wizard_page`
--

DROP TABLE IF EXISTS `osp_completed_wizard_page`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `osp_completed_wizard_page` (
  `id` varchar(36) NOT NULL,
  `completed_category_id` varchar(36) DEFAULT NULL,
  `wizard_page_def_id` varchar(36) DEFAULT NULL,
  `wizard_page_id` varchar(36) DEFAULT NULL,
  `seq_num` int(11) DEFAULT NULL,
  `created` datetime NOT NULL,
  `lastVisited` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `wizard_page_id` (`wizard_page_id`),
  KEY `FK52DE9BFC473463E4` (`completed_category_id`),
  KEY `FK52DE9BFCE4E7E6D3` (`wizard_page_id`),
  KEY `FK52DE9BFC2E24C4` (`wizard_page_def_id`),
  CONSTRAINT `FK52DE9BFC2E24C4` FOREIGN KEY (`wizard_page_def_id`) REFERENCES `osp_wizard_page_sequence` (`id`),
  CONSTRAINT `FK52DE9BFC473463E4` FOREIGN KEY (`completed_category_id`) REFERENCES `osp_completed_wiz_category` (`id`),
  CONSTRAINT `FK52DE9BFCE4E7E6D3` FOREIGN KEY (`wizard_page_id`) REFERENCES `osp_wizard_page` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `osp_completed_wizard_page`
--

LOCK TABLES `osp_completed_wizard_page` WRITE;
/*!40000 ALTER TABLE `osp_completed_wizard_page` DISABLE KEYS */;
/*!40000 ALTER TABLE `osp_completed_wizard_page` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `osp_guidance`
--

DROP TABLE IF EXISTS `osp_guidance`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `osp_guidance` (
  `id` varchar(36) NOT NULL,
  `description` varchar(255) DEFAULT NULL,
  `site_id` varchar(99) NOT NULL,
  `securityQualifier` varchar(255) DEFAULT NULL,
  `securityViewFunction` varchar(255) NOT NULL,
  `securityEditFunction` varchar(255) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `osp_guidance`
--

LOCK TABLES `osp_guidance` WRITE;
/*!40000 ALTER TABLE `osp_guidance` DISABLE KEYS */;
/*!40000 ALTER TABLE `osp_guidance` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `osp_guidance_item`
--

DROP TABLE IF EXISTS `osp_guidance_item`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `osp_guidance_item` (
  `id` varchar(36) NOT NULL,
  `type` varchar(255) DEFAULT NULL,
  `text` text,
  `guidance_id` varchar(36) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `FK605DDBA737209105` (`guidance_id`),
  CONSTRAINT `FK605DDBA737209105` FOREIGN KEY (`guidance_id`) REFERENCES `osp_guidance` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `osp_guidance_item`
--

LOCK TABLES `osp_guidance_item` WRITE;
/*!40000 ALTER TABLE `osp_guidance_item` DISABLE KEYS */;
/*!40000 ALTER TABLE `osp_guidance_item` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `osp_guidance_item_file`
--

DROP TABLE IF EXISTS `osp_guidance_item_file`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `osp_guidance_item_file` (
  `id` varchar(36) NOT NULL,
  `baseReference` varchar(255) DEFAULT NULL,
  `fullReference` varchar(255) DEFAULT NULL,
  `item_id` varchar(36) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `FK29770314DB93091D` (`item_id`),
  CONSTRAINT `FK29770314DB93091D` FOREIGN KEY (`item_id`) REFERENCES `osp_guidance_item` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `osp_guidance_item_file`
--

LOCK TABLES `osp_guidance_item_file` WRITE;
/*!40000 ALTER TABLE `osp_guidance_item_file` DISABLE KEYS */;
/*!40000 ALTER TABLE `osp_guidance_item_file` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `osp_help_glossary`
--

DROP TABLE IF EXISTS `osp_help_glossary`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `osp_help_glossary` (
  `id` varchar(36) NOT NULL,
  `worksite_id` varchar(255) DEFAULT NULL,
  `term` varchar(255) NOT NULL,
  `description` varchar(255) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `osp_help_glossary`
--

LOCK TABLES `osp_help_glossary` WRITE;
/*!40000 ALTER TABLE `osp_help_glossary` DISABLE KEYS */;
/*!40000 ALTER TABLE `osp_help_glossary` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `osp_help_glossary_desc`
--

DROP TABLE IF EXISTS `osp_help_glossary_desc`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `osp_help_glossary_desc` (
  `id` varchar(36) NOT NULL,
  `entry_id` varchar(255) DEFAULT NULL,
  `long_description` text,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `osp_help_glossary_desc`
--

LOCK TABLES `osp_help_glossary_desc` WRITE;
/*!40000 ALTER TABLE `osp_help_glossary_desc` DISABLE KEYS */;
/*!40000 ALTER TABLE `osp_help_glossary_desc` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `osp_list_config`
--

DROP TABLE IF EXISTS `osp_list_config`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `osp_list_config` (
  `id` varchar(36) NOT NULL,
  `owner_id` varchar(255) NOT NULL,
  `tool_id` varchar(36) DEFAULT NULL,
  `title` varchar(255) DEFAULT NULL,
  `height` int(11) DEFAULT NULL,
  `numRows` int(11) DEFAULT NULL,
  `selected_columns` varchar(255) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `osp_list_config`
--

LOCK TABLES `osp_list_config` WRITE;
/*!40000 ALTER TABLE `osp_list_config` DISABLE KEYS */;
/*!40000 ALTER TABLE `osp_list_config` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `osp_matrix`
--

DROP TABLE IF EXISTS `osp_matrix`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `osp_matrix` (
  `id` varchar(36) NOT NULL,
  `owner` varchar(255) NOT NULL,
  `scaffolding_id` varchar(36) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `FK5A172054A6286438` (`scaffolding_id`),
  CONSTRAINT `FK5A172054A6286438` FOREIGN KEY (`scaffolding_id`) REFERENCES `osp_scaffolding` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `osp_matrix`
--

LOCK TABLES `osp_matrix` WRITE;
/*!40000 ALTER TABLE `osp_matrix` DISABLE KEYS */;
/*!40000 ALTER TABLE `osp_matrix` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `osp_matrix_cell`
--

DROP TABLE IF EXISTS `osp_matrix_cell`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `osp_matrix_cell` (
  `id` varchar(36) NOT NULL,
  `matrix_id` varchar(36) NOT NULL,
  `wizard_page_id` varchar(36) DEFAULT NULL,
  `scaffolding_cell_id` varchar(36) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `wizard_page_id` (`wizard_page_id`),
  KEY `FK8C1D366DCD99D2B1` (`scaffolding_cell_id`),
  KEY `FK8C1D366DE4E7E6D3` (`wizard_page_id`),
  KEY `FK8C1D366D2D955C` (`matrix_id`),
  CONSTRAINT `FK8C1D366D2D955C` FOREIGN KEY (`matrix_id`) REFERENCES `osp_matrix` (`id`),
  CONSTRAINT `FK8C1D366DCD99D2B1` FOREIGN KEY (`scaffolding_cell_id`) REFERENCES `osp_scaffolding_cell` (`id`),
  CONSTRAINT `FK8C1D366DE4E7E6D3` FOREIGN KEY (`wizard_page_id`) REFERENCES `osp_wizard_page` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `osp_matrix_cell`
--

LOCK TABLES `osp_matrix_cell` WRITE;
/*!40000 ALTER TABLE `osp_matrix_cell` DISABLE KEYS */;
/*!40000 ALTER TABLE `osp_matrix_cell` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `osp_matrix_label`
--

DROP TABLE IF EXISTS `osp_matrix_label`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `osp_matrix_label` (
  `id` varchar(36) NOT NULL,
  `type` char(1) NOT NULL,
  `description` varchar(255) DEFAULT NULL,
  `color` varchar(7) DEFAULT NULL,
  `textColor` varchar(7) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `osp_matrix_label`
--

LOCK TABLES `osp_matrix_label` WRITE;
/*!40000 ALTER TABLE `osp_matrix_label` DISABLE KEYS */;
/*!40000 ALTER TABLE `osp_matrix_label` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `osp_portal_category_pages`
--

DROP TABLE IF EXISTS `osp_portal_category_pages`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `osp_portal_category_pages` (
  `category_id` varchar(36) NOT NULL,
  `page` longblob,
  `page_locale` varchar(255) NOT NULL,
  PRIMARY KEY (`category_id`,`page_locale`),
  KEY `FK5453883DA502DE9` (`category_id`),
  CONSTRAINT `FK5453883DA502DE9` FOREIGN KEY (`category_id`) REFERENCES `osp_portal_tool_category` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `osp_portal_category_pages`
--

LOCK TABLES `osp_portal_category_pages` WRITE;
/*!40000 ALTER TABLE `osp_portal_category_pages` DISABLE KEYS */;
/*!40000 ALTER TABLE `osp_portal_category_pages` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `osp_portal_site_type`
--

DROP TABLE IF EXISTS `osp_portal_site_type`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `osp_portal_site_type` (
  `id` varchar(36) NOT NULL,
  `type_key` varchar(255) NOT NULL,
  `type_name` varchar(255) DEFAULT NULL,
  `type_description` varchar(255) DEFAULT NULL,
  `skin` varchar(255) DEFAULT NULL,
  `firstCategory` int(11) NOT NULL,
  `lastCategory` int(11) NOT NULL,
  `type_order` int(11) NOT NULL,
  `hidden` bit(1) DEFAULT NULL,
  `display_tab` bit(1) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `type_key` (`type_key`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `osp_portal_site_type`
--

LOCK TABLES `osp_portal_site_type` WRITE;
/*!40000 ALTER TABLE `osp_portal_site_type` DISABLE KEYS */;
/*!40000 ALTER TABLE `osp_portal_site_type` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `osp_portal_special_sites`
--

DROP TABLE IF EXISTS `osp_portal_special_sites`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `osp_portal_special_sites` (
  `site_type_id` varchar(36) NOT NULL,
  `site_type` varchar(255) DEFAULT NULL,
  `site_index` int(11) NOT NULL,
  PRIMARY KEY (`site_type_id`,`site_index`),
  KEY `FKCB5737C68CA05920` (`site_type_id`),
  CONSTRAINT `FKCB5737C68CA05920` FOREIGN KEY (`site_type_id`) REFERENCES `osp_portal_site_type` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `osp_portal_special_sites`
--

LOCK TABLES `osp_portal_special_sites` WRITE;
/*!40000 ALTER TABLE `osp_portal_special_sites` DISABLE KEYS */;
/*!40000 ALTER TABLE `osp_portal_special_sites` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `osp_portal_tool_category`
--

DROP TABLE IF EXISTS `osp_portal_tool_category`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `osp_portal_tool_category` (
  `id` varchar(36) NOT NULL,
  `type_key` varchar(255) NOT NULL,
  `type_description` varchar(255) DEFAULT NULL,
  `category_order` int(11) DEFAULT NULL,
  `home_page_path` varchar(255) DEFAULT NULL,
  `site_type_id` varchar(36) DEFAULT NULL,
  `category_index` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `type_key` (`type_key`),
  KEY `FKFBED88858CA05920` (`site_type_id`),
  CONSTRAINT `FKFBED88858CA05920` FOREIGN KEY (`site_type_id`) REFERENCES `osp_portal_site_type` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `osp_portal_tool_category`
--

LOCK TABLES `osp_portal_tool_category` WRITE;
/*!40000 ALTER TABLE `osp_portal_tool_category` DISABLE KEYS */;
/*!40000 ALTER TABLE `osp_portal_tool_category` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `osp_portal_tool_functions`
--

DROP TABLE IF EXISTS `osp_portal_tool_functions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `osp_portal_tool_functions` (
  `tool_type_id` varchar(36) NOT NULL,
  `function_name` varchar(255) DEFAULT NULL,
  `function_index` int(11) NOT NULL,
  PRIMARY KEY (`tool_type_id`,`function_index`),
  KEY `FK1C0DACF4F73EFC42` (`tool_type_id`),
  CONSTRAINT `FK1C0DACF4F73EFC42` FOREIGN KEY (`tool_type_id`) REFERENCES `osp_portal_tool_type` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `osp_portal_tool_functions`
--

LOCK TABLES `osp_portal_tool_functions` WRITE;
/*!40000 ALTER TABLE `osp_portal_tool_functions` DISABLE KEYS */;
/*!40000 ALTER TABLE `osp_portal_tool_functions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `osp_portal_tool_type`
--

DROP TABLE IF EXISTS `osp_portal_tool_type`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `osp_portal_tool_type` (
  `id` varchar(36) NOT NULL,
  `qualifier_type` varchar(255) DEFAULT NULL,
  `category_id` varchar(36) DEFAULT NULL,
  `tool_id` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FK58EA3641DA502DE9` (`category_id`),
  CONSTRAINT `FK58EA3641DA502DE9` FOREIGN KEY (`category_id`) REFERENCES `osp_portal_tool_category` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `osp_portal_tool_type`
--

LOCK TABLES `osp_portal_tool_type` WRITE;
/*!40000 ALTER TABLE `osp_portal_tool_type` DISABLE KEYS */;
/*!40000 ALTER TABLE `osp_portal_tool_type` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `osp_pres_itemdef_mimetype`
--

DROP TABLE IF EXISTS `osp_pres_itemdef_mimetype`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `osp_pres_itemdef_mimetype` (
  `item_def_id` varchar(36) NOT NULL,
  `primaryMimeType` varchar(36) DEFAULT NULL,
  `secondaryMimeType` varchar(36) DEFAULT NULL,
  KEY `FK9EA59837650346CA` (`item_def_id`),
  CONSTRAINT `FK9EA59837650346CA` FOREIGN KEY (`item_def_id`) REFERENCES `osp_presentation_item_def` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `osp_pres_itemdef_mimetype`
--

LOCK TABLES `osp_pres_itemdef_mimetype` WRITE;
/*!40000 ALTER TABLE `osp_pres_itemdef_mimetype` DISABLE KEYS */;
/*!40000 ALTER TABLE `osp_pres_itemdef_mimetype` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `osp_presentation`
--

DROP TABLE IF EXISTS `osp_presentation`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `osp_presentation` (
  `id` varchar(36) NOT NULL,
  `owner_id` varchar(255) NOT NULL,
  `template_id` varchar(36) NOT NULL,
  `name` varchar(255) DEFAULT NULL,
  `description` varchar(255) DEFAULT NULL,
  `isDefault` bit(1) DEFAULT NULL,
  `isPublic` bit(1) DEFAULT NULL,
  `isCollab` bit(1) DEFAULT NULL,
  `presentationType` varchar(255) NOT NULL,
  `expiresOn` datetime DEFAULT NULL,
  `created` datetime NOT NULL,
  `modified` datetime NOT NULL,
  `allowComments` bit(1) DEFAULT NULL,
  `site_id` varchar(99) NOT NULL,
  `properties` blob,
  `property_form` varchar(36) DEFAULT NULL,
  `layout_id` varchar(36) DEFAULT NULL,
  `style_id` varchar(36) DEFAULT NULL,
  `advanced_navigation` bit(1) DEFAULT NULL,
  `tool_id` varchar(36) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FKA9028D6DFAEA67E8` (`style_id`),
  KEY `FKA9028D6D533F283D` (`layout_id`),
  KEY `FKA9028D6D6FE1417D` (`template_id`),
  CONSTRAINT `FKA9028D6D6FE1417D` FOREIGN KEY (`template_id`) REFERENCES `osp_presentation_template` (`id`),
  CONSTRAINT `FKA9028D6D533F283D` FOREIGN KEY (`layout_id`) REFERENCES `osp_presentation_layout` (`id`),
  CONSTRAINT `FKA9028D6DFAEA67E8` FOREIGN KEY (`style_id`) REFERENCES `osp_style` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `osp_presentation`
--

LOCK TABLES `osp_presentation` WRITE;
/*!40000 ALTER TABLE `osp_presentation` DISABLE KEYS */;
/*!40000 ALTER TABLE `osp_presentation` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `osp_presentation_comment`
--

DROP TABLE IF EXISTS `osp_presentation_comment`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `osp_presentation_comment` (
  `id` varchar(36) NOT NULL,
  `title` varchar(255) NOT NULL,
  `commentText` varchar(1024) DEFAULT NULL,
  `creator_id` varchar(255) NOT NULL,
  `presentation_id` varchar(36) NOT NULL,
  `visibility` tinyint(4) NOT NULL,
  `created` datetime NOT NULL,
  PRIMARY KEY (`id`),
  KEY `FK1E7E658D7658ED43` (`presentation_id`),
  CONSTRAINT `FK1E7E658D7658ED43` FOREIGN KEY (`presentation_id`) REFERENCES `osp_presentation` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `osp_presentation_comment`
--

LOCK TABLES `osp_presentation_comment` WRITE;
/*!40000 ALTER TABLE `osp_presentation_comment` DISABLE KEYS */;
/*!40000 ALTER TABLE `osp_presentation_comment` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `osp_presentation_item`
--

DROP TABLE IF EXISTS `osp_presentation_item`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `osp_presentation_item` (
  `presentation_id` varchar(36) NOT NULL,
  `artifact_id` varchar(36) NOT NULL,
  `item_definition_id` varchar(36) NOT NULL,
  PRIMARY KEY (`presentation_id`,`artifact_id`,`item_definition_id`),
  KEY `FK2FA02A59165E3E4` (`item_definition_id`),
  KEY `FK2FA02A57658ED43` (`presentation_id`),
  CONSTRAINT `FK2FA02A57658ED43` FOREIGN KEY (`presentation_id`) REFERENCES `osp_presentation` (`id`),
  CONSTRAINT `FK2FA02A59165E3E4` FOREIGN KEY (`item_definition_id`) REFERENCES `osp_presentation_item_def` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `osp_presentation_item`
--

LOCK TABLES `osp_presentation_item` WRITE;
/*!40000 ALTER TABLE `osp_presentation_item` DISABLE KEYS */;
/*!40000 ALTER TABLE `osp_presentation_item` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `osp_presentation_item_def`
--

DROP TABLE IF EXISTS `osp_presentation_item_def`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `osp_presentation_item_def` (
  `id` varchar(36) NOT NULL,
  `name` varchar(255) DEFAULT NULL,
  `title` varchar(255) DEFAULT NULL,
  `description` varchar(255) DEFAULT NULL,
  `allowMultiple` bit(1) DEFAULT NULL,
  `type` varchar(255) DEFAULT NULL,
  `external_type` varchar(255) DEFAULT NULL,
  `sequence_no` int(11) DEFAULT NULL,
  `template_id` varchar(36) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `FK1B6ADB6B6FE1417D` (`template_id`),
  CONSTRAINT `FK1B6ADB6B6FE1417D` FOREIGN KEY (`template_id`) REFERENCES `osp_presentation_template` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `osp_presentation_item_def`
--

LOCK TABLES `osp_presentation_item_def` WRITE;
/*!40000 ALTER TABLE `osp_presentation_item_def` DISABLE KEYS */;
INSERT INTO `osp_presentation_item_def` VALUES ('F368DDB6B2327B12E6CC731DA2EE5602','freeFormItem',NULL,NULL,'',NULL,NULL,0,'freeFormTemplate');
/*!40000 ALTER TABLE `osp_presentation_item_def` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `osp_presentation_item_property`
--

DROP TABLE IF EXISTS `osp_presentation_item_property`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `osp_presentation_item_property` (
  `id` varchar(36) NOT NULL,
  `presentation_page_item_id` varchar(36) NOT NULL,
  `property_key` varchar(255) NOT NULL,
  `property_value` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FK86B1362FA9B15561` (`presentation_page_item_id`),
  CONSTRAINT `FK86B1362FA9B15561` FOREIGN KEY (`presentation_page_item_id`) REFERENCES `osp_presentation_page_item` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `osp_presentation_item_property`
--

LOCK TABLES `osp_presentation_item_property` WRITE;
/*!40000 ALTER TABLE `osp_presentation_item_property` DISABLE KEYS */;
/*!40000 ALTER TABLE `osp_presentation_item_property` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `osp_presentation_layout`
--

DROP TABLE IF EXISTS `osp_presentation_layout`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `osp_presentation_layout` (
  `id` varchar(36) NOT NULL,
  `name` varchar(255) NOT NULL,
  `description` varchar(255) DEFAULT NULL,
  `globalState` int(11) NOT NULL,
  `owner_id` varchar(255) NOT NULL,
  `created` datetime NOT NULL,
  `modified` datetime NOT NULL,
  `xhtml_file_id` varchar(36) NOT NULL,
  `preview_image_id` varchar(36) DEFAULT NULL,
  `tool_id` varchar(36) DEFAULT NULL,
  `site_id` varchar(99) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `osp_presentation_layout`
--

LOCK TABLES `osp_presentation_layout` WRITE;
/*!40000 ALTER TABLE `osp_presentation_layout` DISABLE KEYS */;
INSERT INTO `osp_presentation_layout` VALUES ('contentOverText','Content Over Text','Content Over Text Layout File',2,'admin','2012-04-22 16:35:36','2012-04-22 16:35:36','72a37b49-733b-4dd1-9588-92e66ed1e054','cfc9da48-84d0-43a6-9eb2-e25450b46b54',NULL,NULL),('simpleRichText','Simple HTML','Single HTML Layout File',2,'admin','2012-04-22 16:35:36','2012-04-22 16:35:36','3b882a44-8806-499d-b2dc-fd8f566a8bcb','2228a4e3-0c76-4d4f-a13f-2ea9bf552fa7',NULL,NULL),('twoColumn','Two Column','Two Column Layout File',2,'admin','2012-04-22 16:35:36','2012-04-22 16:35:36','6033e84a-4903-4bf8-8c6e-9429599015a8','16e7e745-b09f-4bdb-97e5-3f161e2bcc9f',NULL,NULL);
/*!40000 ALTER TABLE `osp_presentation_layout` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `osp_presentation_log`
--

DROP TABLE IF EXISTS `osp_presentation_log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `osp_presentation_log` (
  `id` varchar(36) NOT NULL,
  `viewer_id` varchar(255) NOT NULL,
  `presentation_id` varchar(36) NOT NULL,
  `view_date` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FK2120E1727658ED43` (`presentation_id`),
  CONSTRAINT `FK2120E1727658ED43` FOREIGN KEY (`presentation_id`) REFERENCES `osp_presentation` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `osp_presentation_log`
--

LOCK TABLES `osp_presentation_log` WRITE;
/*!40000 ALTER TABLE `osp_presentation_log` DISABLE KEYS */;
/*!40000 ALTER TABLE `osp_presentation_log` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `osp_presentation_page`
--

DROP TABLE IF EXISTS `osp_presentation_page`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `osp_presentation_page` (
  `id` varchar(36) NOT NULL,
  `title` varchar(255) DEFAULT NULL,
  `description` varchar(255) DEFAULT NULL,
  `keywords` varchar(255) DEFAULT NULL,
  `presentation_id` varchar(36) NOT NULL,
  `layout_id` varchar(36) NOT NULL,
  `style_id` varchar(36) DEFAULT NULL,
  `seq_num` int(11) DEFAULT NULL,
  `created` datetime NOT NULL,
  `modified` datetime NOT NULL,
  PRIMARY KEY (`id`),
  KEY `FK2FCEA21FAEA67E8` (`style_id`),
  KEY `FK2FCEA21533F283D` (`layout_id`),
  KEY `FK2FCEA217658ED43` (`presentation_id`),
  CONSTRAINT `FK2FCEA217658ED43` FOREIGN KEY (`presentation_id`) REFERENCES `osp_presentation` (`id`),
  CONSTRAINT `FK2FCEA21533F283D` FOREIGN KEY (`layout_id`) REFERENCES `osp_presentation_layout` (`id`),
  CONSTRAINT `FK2FCEA21FAEA67E8` FOREIGN KEY (`style_id`) REFERENCES `osp_style` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `osp_presentation_page`
--

LOCK TABLES `osp_presentation_page` WRITE;
/*!40000 ALTER TABLE `osp_presentation_page` DISABLE KEYS */;
/*!40000 ALTER TABLE `osp_presentation_page` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `osp_presentation_page_item`
--

DROP TABLE IF EXISTS `osp_presentation_page_item`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `osp_presentation_page_item` (
  `id` varchar(36) NOT NULL,
  `presentation_page_region_id` varchar(36) NOT NULL,
  `type` varchar(255) DEFAULT NULL,
  `value` longtext,
  `seq_num` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `FK6417671954DB801` (`presentation_page_region_id`),
  CONSTRAINT `FK6417671954DB801` FOREIGN KEY (`presentation_page_region_id`) REFERENCES `osp_presentation_page_region` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `osp_presentation_page_item`
--

LOCK TABLES `osp_presentation_page_item` WRITE;
/*!40000 ALTER TABLE `osp_presentation_page_item` DISABLE KEYS */;
/*!40000 ALTER TABLE `osp_presentation_page_item` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `osp_presentation_page_region`
--

DROP TABLE IF EXISTS `osp_presentation_page_region`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `osp_presentation_page_region` (
  `id` varchar(36) NOT NULL,
  `presentation_page_id` varchar(36) NOT NULL,
  `region_id` varchar(255) NOT NULL,
  `type` varchar(255) DEFAULT NULL,
  `help_text` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FK8A46C2D215C572B8` (`presentation_page_id`),
  CONSTRAINT `FK8A46C2D215C572B8` FOREIGN KEY (`presentation_page_id`) REFERENCES `osp_presentation_page` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `osp_presentation_page_region`
--

LOCK TABLES `osp_presentation_page_region` WRITE;
/*!40000 ALTER TABLE `osp_presentation_page_region` DISABLE KEYS */;
/*!40000 ALTER TABLE `osp_presentation_page_region` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `osp_presentation_template`
--

DROP TABLE IF EXISTS `osp_presentation_template`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `osp_presentation_template` (
  `id` varchar(36) NOT NULL,
  `name` varchar(255) DEFAULT NULL,
  `description` varchar(255) DEFAULT NULL,
  `includeHeaderAndFooter` bit(1) DEFAULT NULL,
  `published` bit(1) DEFAULT NULL,
  `owner_id` varchar(255) NOT NULL,
  `renderer` varchar(36) DEFAULT NULL,
  `markup` varchar(4000) DEFAULT NULL,
  `propertyPage` varchar(36) DEFAULT NULL,
  `propertyFormType` varchar(36) DEFAULT NULL,
  `documentRoot` varchar(255) DEFAULT NULL,
  `created` datetime NOT NULL,
  `modified` datetime NOT NULL,
  `site_id` varchar(99) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `osp_presentation_template`
--

LOCK TABLES `osp_presentation_template` WRITE;
/*!40000 ALTER TABLE `osp_presentation_template` DISABLE KEYS */;
INSERT INTO `osp_presentation_template` VALUES ('freeFormTemplate','Free Form Presentation',NULL,'\0','\0','anonymous','663fc393-3b09-41d5-9c20-854a46f81f6d',NULL,NULL,NULL,NULL,'2012-04-22 16:35:36','2012-04-22 16:35:36','46A7D95C6579A22EAFD11254B03C6F3E');
/*!40000 ALTER TABLE `osp_presentation_template` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `osp_review`
--

DROP TABLE IF EXISTS `osp_review`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `osp_review` (
  `id` varchar(36) NOT NULL,
  `review_content_id` varchar(36) DEFAULT NULL,
  `site_id` varchar(99) NOT NULL,
  `parent_id` varchar(36) DEFAULT NULL,
  `review_device_id` varchar(36) DEFAULT NULL,
  `review_item_id` varchar(36) DEFAULT NULL,
  `review_type` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `osp_review`
--

LOCK TABLES `osp_review` WRITE;
/*!40000 ALTER TABLE `osp_review` DISABLE KEYS */;
/*!40000 ALTER TABLE `osp_review` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `osp_scaffolding`
--

DROP TABLE IF EXISTS `osp_scaffolding`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `osp_scaffolding` (
  `id` varchar(36) NOT NULL,
  `ownerId` varchar(255) NOT NULL,
  `title` varchar(255) DEFAULT NULL,
  `description` text,
  `worksiteId` varchar(255) DEFAULT NULL,
  `generalFeedbackOption` int(11) NOT NULL,
  `itemFeedbackOption` int(11) NOT NULL,
  `preview` bit(1) NOT NULL,
  `published` bit(1) DEFAULT NULL,
  `publishedBy` varchar(255) DEFAULT NULL,
  `publishedDate` datetime DEFAULT NULL,
  `modifiedDate` datetime DEFAULT NULL,
  `columnLabel` varchar(255) NOT NULL,
  `rowLabel` varchar(255) NOT NULL,
  `readyColor` varchar(7) DEFAULT NULL,
  `pendingColor` varchar(7) DEFAULT NULL,
  `completedColor` varchar(7) DEFAULT NULL,
  `lockedColor` varchar(7) DEFAULT NULL,
  `returnedColor` varchar(7) DEFAULT NULL,
  `workflowOption` int(11) NOT NULL,
  `allowRequestFeedback` bit(1) DEFAULT NULL,
  `hideEvaluations` bit(1) DEFAULT NULL,
  `defaultFormsMatrixVersion` bit(1) DEFAULT NULL,
  `exposed_page_id` varchar(36) DEFAULT NULL,
  `style_id` varchar(36) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FK65135779FAEA67E8` (`style_id`),
  KEY `FK65135779C73F84BD` (`id`),
  CONSTRAINT `FK65135779C73F84BD` FOREIGN KEY (`id`) REFERENCES `osp_workflow_parent` (`id`),
  CONSTRAINT `FK65135779FAEA67E8` FOREIGN KEY (`style_id`) REFERENCES `osp_style` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `osp_scaffolding`
--

LOCK TABLES `osp_scaffolding` WRITE;
/*!40000 ALTER TABLE `osp_scaffolding` DISABLE KEYS */;
/*!40000 ALTER TABLE `osp_scaffolding` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `osp_scaffolding_attachments`
--

DROP TABLE IF EXISTS `osp_scaffolding_attachments`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `osp_scaffolding_attachments` (
  `id` varchar(36) NOT NULL,
  `artifact_id` varchar(255) DEFAULT NULL,
  `seq_num` int(11) NOT NULL,
  PRIMARY KEY (`id`,`seq_num`),
  KEY `FK529713EAE023FB45` (`id`),
  CONSTRAINT `FK529713EAE023FB45` FOREIGN KEY (`id`) REFERENCES `osp_scaffolding` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `osp_scaffolding_attachments`
--

LOCK TABLES `osp_scaffolding_attachments` WRITE;
/*!40000 ALTER TABLE `osp_scaffolding_attachments` DISABLE KEYS */;
/*!40000 ALTER TABLE `osp_scaffolding_attachments` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `osp_scaffolding_cell`
--

DROP TABLE IF EXISTS `osp_scaffolding_cell`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `osp_scaffolding_cell` (
  `id` varchar(36) NOT NULL,
  `rootcriterion_id` varchar(36) DEFAULT NULL,
  `level_id` varchar(36) DEFAULT NULL,
  `scaffolding_id` varchar(36) NOT NULL,
  `wiz_page_def_id` varchar(36) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `wiz_page_def_id` (`wiz_page_def_id`),
  KEY `FK184EAE68754F20BD` (`wiz_page_def_id`),
  KEY `FK184EAE689FECDBB8` (`level_id`),
  KEY `FK184EAE68A6286438` (`scaffolding_id`),
  KEY `FK184EAE6870EDF97A` (`rootcriterion_id`),
  CONSTRAINT `FK184EAE6870EDF97A` FOREIGN KEY (`rootcriterion_id`) REFERENCES `osp_matrix_label` (`id`),
  CONSTRAINT `FK184EAE68754F20BD` FOREIGN KEY (`wiz_page_def_id`) REFERENCES `osp_wizard_page_def` (`id`),
  CONSTRAINT `FK184EAE689FECDBB8` FOREIGN KEY (`level_id`) REFERENCES `osp_matrix_label` (`id`),
  CONSTRAINT `FK184EAE68A6286438` FOREIGN KEY (`scaffolding_id`) REFERENCES `osp_scaffolding` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `osp_scaffolding_cell`
--

LOCK TABLES `osp_scaffolding_cell` WRITE;
/*!40000 ALTER TABLE `osp_scaffolding_cell` DISABLE KEYS */;
/*!40000 ALTER TABLE `osp_scaffolding_cell` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `osp_scaffolding_cell_form_defs`
--

DROP TABLE IF EXISTS `osp_scaffolding_cell_form_defs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `osp_scaffolding_cell_form_defs` (
  `wiz_page_def_id` varchar(36) NOT NULL,
  `form_def_id` varchar(255) DEFAULT NULL,
  `seq_num` int(11) NOT NULL,
  PRIMARY KEY (`wiz_page_def_id`,`seq_num`),
  KEY `FK904DCA92754F20BD` (`wiz_page_def_id`),
  CONSTRAINT `FK904DCA92754F20BD` FOREIGN KEY (`wiz_page_def_id`) REFERENCES `osp_wizard_page_def` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `osp_scaffolding_cell_form_defs`
--

LOCK TABLES `osp_scaffolding_cell_form_defs` WRITE;
/*!40000 ALTER TABLE `osp_scaffolding_cell_form_defs` DISABLE KEYS */;
/*!40000 ALTER TABLE `osp_scaffolding_cell_form_defs` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `osp_scaffolding_criteria`
--

DROP TABLE IF EXISTS `osp_scaffolding_criteria`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `osp_scaffolding_criteria` (
  `scaffolding_id` varchar(36) NOT NULL,
  `elt` varchar(36) NOT NULL,
  `seq_num` int(11) NOT NULL,
  PRIMARY KEY (`scaffolding_id`,`seq_num`),
  KEY `FK8634116518C870CC` (`elt`),
  KEY `FK86341165A6286438` (`scaffolding_id`),
  CONSTRAINT `FK86341165A6286438` FOREIGN KEY (`scaffolding_id`) REFERENCES `osp_scaffolding` (`id`),
  CONSTRAINT `FK8634116518C870CC` FOREIGN KEY (`elt`) REFERENCES `osp_matrix_label` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `osp_scaffolding_criteria`
--

LOCK TABLES `osp_scaffolding_criteria` WRITE;
/*!40000 ALTER TABLE `osp_scaffolding_criteria` DISABLE KEYS */;
/*!40000 ALTER TABLE `osp_scaffolding_criteria` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `osp_scaffolding_form_defs`
--

DROP TABLE IF EXISTS `osp_scaffolding_form_defs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `osp_scaffolding_form_defs` (
  `id` varchar(36) NOT NULL,
  `form_def_id` varchar(255) DEFAULT NULL,
  `seq_num` int(11) NOT NULL,
  PRIMARY KEY (`id`,`seq_num`),
  KEY `FK95431263E023FB45` (`id`),
  CONSTRAINT `FK95431263E023FB45` FOREIGN KEY (`id`) REFERENCES `osp_scaffolding` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `osp_scaffolding_form_defs`
--

LOCK TABLES `osp_scaffolding_form_defs` WRITE;
/*!40000 ALTER TABLE `osp_scaffolding_form_defs` DISABLE KEYS */;
/*!40000 ALTER TABLE `osp_scaffolding_form_defs` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `osp_scaffolding_levels`
--

DROP TABLE IF EXISTS `osp_scaffolding_levels`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `osp_scaffolding_levels` (
  `scaffolding_id` varchar(36) NOT NULL,
  `elt` varchar(36) NOT NULL,
  `seq_num` int(11) NOT NULL,
  PRIMARY KEY (`scaffolding_id`,`seq_num`),
  KEY `FK4EBCD0F51EFC6CAF` (`elt`),
  KEY `FK4EBCD0F5A6286438` (`scaffolding_id`),
  CONSTRAINT `FK4EBCD0F5A6286438` FOREIGN KEY (`scaffolding_id`) REFERENCES `osp_scaffolding` (`id`),
  CONSTRAINT `FK4EBCD0F51EFC6CAF` FOREIGN KEY (`elt`) REFERENCES `osp_matrix_label` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `osp_scaffolding_levels`
--

LOCK TABLES `osp_scaffolding_levels` WRITE;
/*!40000 ALTER TABLE `osp_scaffolding_levels` DISABLE KEYS */;
/*!40000 ALTER TABLE `osp_scaffolding_levels` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `osp_site_tool`
--

DROP TABLE IF EXISTS `osp_site_tool`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `osp_site_tool` (
  `id` varchar(40) NOT NULL,
  `site_id` varchar(99) DEFAULT NULL,
  `tool_id` varchar(36) DEFAULT NULL,
  `listener_id` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `osp_site_tool`
--

LOCK TABLES `osp_site_tool` WRITE;
/*!40000 ALTER TABLE `osp_site_tool` DISABLE KEYS */;
INSERT INTO `osp_site_tool` VALUES ('56D11FCDF09DCA94336BF4D3EF0E8A3B','PortfolioAdmin','5239fcc9-80fe-47ad-acfd-e4c92b903713','org.theospi.portfolio.security.mgt.ToolPermissionManager.presentationTemplate'),('66FBEBB9737B2466A79F74912D340D8D','PortfolioAdmin','7ee3840d-ceae-45c7-a53d-2a1b0bdf0ef9','org.theospi.portfolio.security.mgt.ToolPermissionManager.presentation'),('748C828DA98AD2748C1308C47D8DA7D9','PortfolioAdmin','8e2825c1-4e22-4ba5-b94d-e306527d6e9c','org.theospi.portfolio.security.mgt.ToolPermissionManager.style'),('CC1A3DB0DE8EA9BCF60B9AF298CB6F61','PortfolioAdmin','74db52ce-480f-42e9-85a7-1df6ac500e08','org.theospi.portfolio.security.mgt.ToolPermissionManager.presentationLayout'),('D35C0B9FEB0A60562B853B884C66C9AA','PortfolioAdmin','7a4c2606-d913-4014-8262-833b6277a40b','org.theospi.portfolio.security.mgt.ToolPermissionManager.glossaryGlobal');
/*!40000 ALTER TABLE `osp_site_tool` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `osp_style`
--

DROP TABLE IF EXISTS `osp_style`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `osp_style` (
  `id` varchar(36) NOT NULL,
  `name` varchar(255) DEFAULT NULL,
  `description` varchar(255) DEFAULT NULL,
  `globalState` int(11) NOT NULL,
  `owner_id` varchar(255) NOT NULL,
  `style_file_id` varchar(36) DEFAULT NULL,
  `site_id` varchar(99) DEFAULT NULL,
  `created` datetime NOT NULL,
  `modified` datetime NOT NULL,
  `style_hash` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `osp_style`
--

LOCK TABLES `osp_style` WRITE;
/*!40000 ALTER TABLE `osp_style` DISABLE KEYS */;
/*!40000 ALTER TABLE `osp_style` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `osp_template_file_ref`
--

DROP TABLE IF EXISTS `osp_template_file_ref`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `osp_template_file_ref` (
  `id` varchar(36) NOT NULL,
  `file_id` varchar(36) DEFAULT NULL,
  `file_type_id` varchar(36) DEFAULT NULL,
  `usage_desc` varchar(255) DEFAULT NULL,
  `template_id` varchar(36) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `FK4B70FB026FE1417D` (`template_id`),
  CONSTRAINT `FK4B70FB026FE1417D` FOREIGN KEY (`template_id`) REFERENCES `osp_presentation_template` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `osp_template_file_ref`
--

LOCK TABLES `osp_template_file_ref` WRITE;
/*!40000 ALTER TABLE `osp_template_file_ref` DISABLE KEYS */;
/*!40000 ALTER TABLE `osp_template_file_ref` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `osp_wiz_page_attachment`
--

DROP TABLE IF EXISTS `osp_wiz_page_attachment`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `osp_wiz_page_attachment` (
  `id` varchar(36) NOT NULL,
  `artifactId` varchar(36) DEFAULT NULL,
  `page_id` varchar(36) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `FK2257FCC9BDC195A7` (`page_id`),
  CONSTRAINT `FK2257FCC9BDC195A7` FOREIGN KEY (`page_id`) REFERENCES `osp_wizard_page` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `osp_wiz_page_attachment`
--

LOCK TABLES `osp_wiz_page_attachment` WRITE;
/*!40000 ALTER TABLE `osp_wiz_page_attachment` DISABLE KEYS */;
/*!40000 ALTER TABLE `osp_wiz_page_attachment` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `osp_wiz_page_def_attachments`
--

DROP TABLE IF EXISTS `osp_wiz_page_def_attachments`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `osp_wiz_page_def_attachments` (
  `wiz_page_def_id` varchar(36) NOT NULL,
  `artifact_id` varchar(255) DEFAULT NULL,
  `seq_num` int(11) NOT NULL,
  PRIMARY KEY (`wiz_page_def_id`,`seq_num`),
  KEY `FK331C8290754F20BD` (`wiz_page_def_id`),
  CONSTRAINT `FK331C8290754F20BD` FOREIGN KEY (`wiz_page_def_id`) REFERENCES `osp_wizard_page_def` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `osp_wiz_page_def_attachments`
--

LOCK TABLES `osp_wiz_page_def_attachments` WRITE;
/*!40000 ALTER TABLE `osp_wiz_page_def_attachments` DISABLE KEYS */;
/*!40000 ALTER TABLE `osp_wiz_page_def_attachments` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `osp_wiz_page_form`
--

DROP TABLE IF EXISTS `osp_wiz_page_form`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `osp_wiz_page_form` (
  `id` varchar(36) NOT NULL,
  `artifactId` varchar(36) DEFAULT NULL,
  `page_id` varchar(36) NOT NULL,
  `formType` varchar(36) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FK4725E4EABDC195A7` (`page_id`),
  CONSTRAINT `FK4725E4EABDC195A7` FOREIGN KEY (`page_id`) REFERENCES `osp_wizard_page` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `osp_wiz_page_form`
--

LOCK TABLES `osp_wiz_page_form` WRITE;
/*!40000 ALTER TABLE `osp_wiz_page_form` DISABLE KEYS */;
/*!40000 ALTER TABLE `osp_wiz_page_form` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `osp_wizard`
--

DROP TABLE IF EXISTS `osp_wizard`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `osp_wizard` (
  `id` varchar(36) NOT NULL,
  `owner_id` varchar(255) NOT NULL,
  `name` varchar(255) DEFAULT NULL,
  `description` varchar(1024) DEFAULT NULL,
  `keywords` varchar(1024) DEFAULT NULL,
  `created` datetime NOT NULL,
  `modified` datetime NOT NULL,
  `site_id` varchar(99) NOT NULL,
  `guidance_id` varchar(36) DEFAULT NULL,
  `published` bit(1) DEFAULT NULL,
  `preview` bit(1) DEFAULT NULL,
  `wizard_type` varchar(255) DEFAULT NULL,
  `style_id` varchar(36) DEFAULT NULL,
  `exposed_page_id` varchar(36) DEFAULT NULL,
  `root_category` varchar(36) DEFAULT NULL,
  `seq_num` int(11) DEFAULT NULL,
  `generalFeedbackOption` int(11) NOT NULL,
  `itemFeedbackOption` int(11) NOT NULL,
  `reviewerGroupAccess` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `root_category` (`root_category`),
  KEY `FK6B9ACDFEFAEA67E8` (`style_id`),
  KEY `FK6B9ACDFEC73F84BD` (`id`),
  KEY `FK6B9ACDFEE831DD1C` (`root_category`),
  CONSTRAINT `FK6B9ACDFEE831DD1C` FOREIGN KEY (`root_category`) REFERENCES `osp_wizard_category` (`id`),
  CONSTRAINT `FK6B9ACDFEC73F84BD` FOREIGN KEY (`id`) REFERENCES `osp_workflow_parent` (`id`),
  CONSTRAINT `FK6B9ACDFEFAEA67E8` FOREIGN KEY (`style_id`) REFERENCES `osp_style` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `osp_wizard`
--

LOCK TABLES `osp_wizard` WRITE;
/*!40000 ALTER TABLE `osp_wizard` DISABLE KEYS */;
/*!40000 ALTER TABLE `osp_wizard` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `osp_wizard_category`
--

DROP TABLE IF EXISTS `osp_wizard_category`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `osp_wizard_category` (
  `id` varchar(36) NOT NULL,
  `name` varchar(255) DEFAULT NULL,
  `description` varchar(255) DEFAULT NULL,
  `keywords` varchar(255) DEFAULT NULL,
  `created` datetime NOT NULL,
  `modified` datetime NOT NULL,
  `wizard_id` varchar(36) DEFAULT NULL,
  `parent_category_id` varchar(36) DEFAULT NULL,
  `seq_num` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FK3A81FE1FD62513B2` (`wizard_id`),
  KEY `FK3A81FE1FE0EFF548` (`parent_category_id`),
  CONSTRAINT `FK3A81FE1FE0EFF548` FOREIGN KEY (`parent_category_id`) REFERENCES `osp_wizard_category` (`id`),
  CONSTRAINT `FK3A81FE1FD62513B2` FOREIGN KEY (`wizard_id`) REFERENCES `osp_wizard` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `osp_wizard_category`
--

LOCK TABLES `osp_wizard_category` WRITE;
/*!40000 ALTER TABLE `osp_wizard_category` DISABLE KEYS */;
/*!40000 ALTER TABLE `osp_wizard_category` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `osp_wizard_page`
--

DROP TABLE IF EXISTS `osp_wizard_page`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `osp_wizard_page` (
  `id` varchar(36) NOT NULL,
  `owner` varchar(255) NOT NULL,
  `status` varchar(255) DEFAULT NULL,
  `wiz_page_def_id` varchar(36) DEFAULT NULL,
  `modified` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FK4CFB5C30754F20BD` (`wiz_page_def_id`),
  CONSTRAINT `FK4CFB5C30754F20BD` FOREIGN KEY (`wiz_page_def_id`) REFERENCES `osp_wizard_page_def` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `osp_wizard_page`
--

LOCK TABLES `osp_wizard_page` WRITE;
/*!40000 ALTER TABLE `osp_wizard_page` DISABLE KEYS */;
/*!40000 ALTER TABLE `osp_wizard_page` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `osp_wizard_page_def`
--

DROP TABLE IF EXISTS `osp_wizard_page_def`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `osp_wizard_page_def` (
  `id` varchar(36) NOT NULL,
  `initialStatus` varchar(255) DEFAULT NULL,
  `name` varchar(255) DEFAULT NULL,
  `description` text,
  `SUPPRESS_ITEMS` bit(1) DEFAULT NULL,
  `site_id` varchar(255) DEFAULT NULL,
  `guidance_id` varchar(255) DEFAULT NULL,
  `style_id` varchar(36) DEFAULT NULL,
  `defaultCustomForm` bit(1) DEFAULT NULL,
  `defaultReflectionForm` bit(1) DEFAULT NULL,
  `defaultFeedbackForm` bit(1) DEFAULT NULL,
  `defaultReviewers` bit(1) DEFAULT NULL,
  `defaultEvaluationForm` bit(1) DEFAULT NULL,
  `defaultEvaluators` bit(1) DEFAULT NULL,
  `allowRequestFeedback` bit(1) DEFAULT NULL,
  `hideEvaluations` bit(1) DEFAULT NULL,
  `type` varchar(1) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `FK6ABE7776FAEA67E8` (`style_id`),
  KEY `FK6ABE7776C73F84BD` (`id`),
  CONSTRAINT `FK6ABE7776C73F84BD` FOREIGN KEY (`id`) REFERENCES `osp_workflow_parent` (`id`),
  CONSTRAINT `FK6ABE7776FAEA67E8` FOREIGN KEY (`style_id`) REFERENCES `osp_style` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `osp_wizard_page_def`
--

LOCK TABLES `osp_wizard_page_def` WRITE;
/*!40000 ALTER TABLE `osp_wizard_page_def` DISABLE KEYS */;
/*!40000 ALTER TABLE `osp_wizard_page_def` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `osp_wizard_page_sequence`
--

DROP TABLE IF EXISTS `osp_wizard_page_sequence`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `osp_wizard_page_sequence` (
  `id` varchar(36) NOT NULL,
  `seq_num` int(11) DEFAULT NULL,
  `category_id` varchar(36) NOT NULL,
  `wiz_page_def_id` varchar(36) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `wiz_page_def_id` (`wiz_page_def_id`),
  KEY `FKA5A702F0754F20BD` (`wiz_page_def_id`),
  KEY `FKA5A702F06EA23D5D` (`category_id`),
  CONSTRAINT `FKA5A702F06EA23D5D` FOREIGN KEY (`category_id`) REFERENCES `osp_wizard_category` (`id`),
  CONSTRAINT `FKA5A702F0754F20BD` FOREIGN KEY (`wiz_page_def_id`) REFERENCES `osp_wizard_page_def` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `osp_wizard_page_sequence`
--

LOCK TABLES `osp_wizard_page_sequence` WRITE;
/*!40000 ALTER TABLE `osp_wizard_page_sequence` DISABLE KEYS */;
/*!40000 ALTER TABLE `osp_wizard_page_sequence` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `osp_workflow`
--

DROP TABLE IF EXISTS `osp_workflow`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `osp_workflow` (
  `id` varchar(36) NOT NULL,
  `title` varchar(255) DEFAULT NULL,
  `parent_id` varchar(36) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `FK2065879242A62872` (`parent_id`),
  CONSTRAINT `FK2065879242A62872` FOREIGN KEY (`parent_id`) REFERENCES `osp_workflow_parent` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `osp_workflow`
--

LOCK TABLES `osp_workflow` WRITE;
/*!40000 ALTER TABLE `osp_workflow` DISABLE KEYS */;
/*!40000 ALTER TABLE `osp_workflow` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `osp_workflow_item`
--

DROP TABLE IF EXISTS `osp_workflow_item`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `osp_workflow_item` (
  `id` varchar(36) NOT NULL,
  `actionType` int(11) NOT NULL,
  `action_object_id` varchar(255) NOT NULL,
  `action_value` varchar(255) NOT NULL,
  `workflow_id` varchar(36) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `FKB38697A091A4BC5E` (`workflow_id`),
  CONSTRAINT `FKB38697A091A4BC5E` FOREIGN KEY (`workflow_id`) REFERENCES `osp_workflow` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `osp_workflow_item`
--

LOCK TABLES `osp_workflow_item` WRITE;
/*!40000 ALTER TABLE `osp_workflow_item` DISABLE KEYS */;
/*!40000 ALTER TABLE `osp_workflow_item` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `osp_workflow_parent`
--

DROP TABLE IF EXISTS `osp_workflow_parent`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `osp_workflow_parent` (
  `id` varchar(36) NOT NULL,
  `reflection_device_id` varchar(36) DEFAULT NULL,
  `reflection_device_type` varchar(255) DEFAULT NULL,
  `evaluation_device_id` varchar(36) DEFAULT NULL,
  `evaluation_device_type` varchar(255) DEFAULT NULL,
  `review_device_id` varchar(36) DEFAULT NULL,
  `review_device_type` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `osp_workflow_parent`
--

LOCK TABLES `osp_workflow_parent` WRITE;
/*!40000 ALTER TABLE `osp_workflow_parent` DISABLE KEYS */;
/*!40000 ALTER TABLE `osp_workflow_parent` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `poll_option`
--

DROP TABLE IF EXISTS `poll_option`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `poll_option` (
  `OPTION_ID` bigint(20) NOT NULL AUTO_INCREMENT,
  `OPTION_POLL_ID` bigint(20) DEFAULT NULL,
  `OPTION_TEXT` text,
  `OPTION_UUID` varchar(255) DEFAULT NULL,
  `DELETED` bit(1) DEFAULT NULL,
  PRIMARY KEY (`OPTION_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `poll_option`
--

LOCK TABLES `poll_option` WRITE;
/*!40000 ALTER TABLE `poll_option` DISABLE KEYS */;
/*!40000 ALTER TABLE `poll_option` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `poll_poll`
--

DROP TABLE IF EXISTS `poll_poll`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `poll_poll` (
  `POLL_ID` bigint(20) NOT NULL AUTO_INCREMENT,
  `POLL_OWNER` varchar(255) DEFAULT NULL,
  `POLL_SITE_ID` varchar(255) DEFAULT NULL,
  `POLL_DETAILS` text,
  `POLL_CREATION_DATE` datetime DEFAULT NULL,
  `POLL_TEXT` text,
  `POLL_VOTE_OPEN` datetime DEFAULT NULL,
  `POLL_VOTE_CLOSE` datetime DEFAULT NULL,
  `POLL_MIN_OPTIONS` int(11) DEFAULT NULL,
  `POLL_MAX_OPTIONS` int(11) DEFAULT NULL,
  `POLL_DISPLAY_RESULT` varchar(255) DEFAULT NULL,
  `POLL_LIMIT_VOTE` bit(1) DEFAULT NULL,
  `POLL_UUID` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`POLL_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `poll_poll`
--

LOCK TABLES `poll_poll` WRITE;
/*!40000 ALTER TABLE `poll_poll` DISABLE KEYS */;
/*!40000 ALTER TABLE `poll_poll` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `poll_vote`
--

DROP TABLE IF EXISTS `poll_vote`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `poll_vote` (
  `VOTE_ID` bigint(20) NOT NULL AUTO_INCREMENT,
  `USER_ID` varchar(255) DEFAULT NULL,
  `VOTE_IP` varchar(255) DEFAULT NULL,
  `VOTE_DATE` datetime DEFAULT NULL,
  `VOTE_POLL_ID` bigint(20) DEFAULT NULL,
  `VOTE_OPTION` bigint(20) DEFAULT NULL,
  `VOTE_SUBMISSION_ID` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`VOTE_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `poll_vote`
--

LOCK TABLES `poll_vote` WRITE;
/*!40000 ALTER TABLE `poll_vote` DISABLE KEYS */;
/*!40000 ALTER TABLE `poll_vote` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `profile_external_integration_t`
--

DROP TABLE IF EXISTS `profile_external_integration_t`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `profile_external_integration_t` (
  `USER_UUID` varchar(99) NOT NULL,
  `TWITTER_TOKEN` varchar(255) DEFAULT NULL,
  `TWITTER_SECRET` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`USER_UUID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `profile_external_integration_t`
--

LOCK TABLES `profile_external_integration_t` WRITE;
/*!40000 ALTER TABLE `profile_external_integration_t` DISABLE KEYS */;
/*!40000 ALTER TABLE `profile_external_integration_t` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `profile_friends_t`
--

DROP TABLE IF EXISTS `profile_friends_t`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `profile_friends_t` (
  `ID` bigint(20) NOT NULL AUTO_INCREMENT,
  `USER_UUID` varchar(99) NOT NULL,
  `FRIEND_UUID` varchar(99) NOT NULL,
  `RELATIONSHIP` int(11) NOT NULL,
  `REQUESTED_DATE` datetime NOT NULL,
  `CONFIRMED` bit(1) NOT NULL,
  `CONFIRMED_DATE` datetime DEFAULT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `profile_friends_t`
--

LOCK TABLES `profile_friends_t` WRITE;
/*!40000 ALTER TABLE `profile_friends_t` DISABLE KEYS */;
/*!40000 ALTER TABLE `profile_friends_t` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `profile_images_external_t`
--

DROP TABLE IF EXISTS `profile_images_external_t`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `profile_images_external_t` (
  `USER_UUID` varchar(99) NOT NULL,
  `URL_MAIN` varchar(4000) NOT NULL,
  `URL_THUMB` varchar(4000) DEFAULT NULL,
  PRIMARY KEY (`USER_UUID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `profile_images_external_t`
--

LOCK TABLES `profile_images_external_t` WRITE;
/*!40000 ALTER TABLE `profile_images_external_t` DISABLE KEYS */;
/*!40000 ALTER TABLE `profile_images_external_t` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `profile_images_t`
--

DROP TABLE IF EXISTS `profile_images_t`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `profile_images_t` (
  `ID` bigint(20) NOT NULL AUTO_INCREMENT,
  `USER_UUID` varchar(99) NOT NULL,
  `RESOURCE_MAIN` varchar(4000) NOT NULL,
  `RESOURCE_THUMB` varchar(4000) NOT NULL,
  `IS_CURRENT` bit(1) NOT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `profile_images_t`
--

LOCK TABLES `profile_images_t` WRITE;
/*!40000 ALTER TABLE `profile_images_t` DISABLE KEYS */;
/*!40000 ALTER TABLE `profile_images_t` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `profile_preferences_t`
--

DROP TABLE IF EXISTS `profile_preferences_t`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `profile_preferences_t` (
  `USER_UUID` varchar(99) NOT NULL,
  `EMAIL_REQUEST` bit(1) NOT NULL,
  `EMAIL_CONFIRM` bit(1) NOT NULL,
  PRIMARY KEY (`USER_UUID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `profile_preferences_t`
--

LOCK TABLES `profile_preferences_t` WRITE;
/*!40000 ALTER TABLE `profile_preferences_t` DISABLE KEYS */;
/*!40000 ALTER TABLE `profile_preferences_t` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `profile_privacy_t`
--

DROP TABLE IF EXISTS `profile_privacy_t`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `profile_privacy_t` (
  `USER_UUID` varchar(99) NOT NULL,
  `PROFILE_IMAGE` int(11) NOT NULL,
  `BASIC_INFO` int(11) NOT NULL,
  `CONTACT_INFO` int(11) NOT NULL,
  `ACADEMIC_INFO` int(11) NOT NULL,
  `PERSONAL_INFO` int(11) NOT NULL,
  `BIRTH_YEAR` bit(1) NOT NULL,
  `SEARCH` int(11) NOT NULL,
  `MY_FRIENDS` int(11) NOT NULL,
  `MY_STATUS` int(11) NOT NULL,
  PRIMARY KEY (`USER_UUID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `profile_privacy_t`
--

LOCK TABLES `profile_privacy_t` WRITE;
/*!40000 ALTER TABLE `profile_privacy_t` DISABLE KEYS */;
/*!40000 ALTER TABLE `profile_privacy_t` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `profile_status_t`
--

DROP TABLE IF EXISTS `profile_status_t`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `profile_status_t` (
  `USER_UUID` varchar(99) NOT NULL,
  `MESSAGE` varchar(255) NOT NULL,
  `DATE_ADDED` datetime NOT NULL,
  PRIMARY KEY (`USER_UUID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `profile_status_t`
--

LOCK TABLES `profile_status_t` WRITE;
/*!40000 ALTER TABLE `profile_status_t` DISABLE KEYS */;
/*!40000 ALTER TABLE `profile_status_t` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `qrtz_blob_triggers`
--

DROP TABLE IF EXISTS `qrtz_blob_triggers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `qrtz_blob_triggers` (
  `TRIGGER_NAME` varchar(80) NOT NULL,
  `TRIGGER_GROUP` varchar(80) NOT NULL,
  `BLOB_DATA` blob,
  PRIMARY KEY (`TRIGGER_NAME`,`TRIGGER_GROUP`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `qrtz_blob_triggers`
--

LOCK TABLES `qrtz_blob_triggers` WRITE;
/*!40000 ALTER TABLE `qrtz_blob_triggers` DISABLE KEYS */;
/*!40000 ALTER TABLE `qrtz_blob_triggers` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `qrtz_calendars`
--

DROP TABLE IF EXISTS `qrtz_calendars`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `qrtz_calendars` (
  `CALENDAR_NAME` varchar(80) NOT NULL,
  `CALENDAR` blob NOT NULL,
  PRIMARY KEY (`CALENDAR_NAME`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `qrtz_calendars`
--

LOCK TABLES `qrtz_calendars` WRITE;
/*!40000 ALTER TABLE `qrtz_calendars` DISABLE KEYS */;
/*!40000 ALTER TABLE `qrtz_calendars` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `qrtz_cron_triggers`
--

DROP TABLE IF EXISTS `qrtz_cron_triggers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `qrtz_cron_triggers` (
  `TRIGGER_NAME` varchar(80) NOT NULL,
  `TRIGGER_GROUP` varchar(80) NOT NULL,
  `CRON_EXPRESSION` varchar(80) NOT NULL,
  `TIME_ZONE_ID` varchar(80) DEFAULT NULL,
  PRIMARY KEY (`TRIGGER_NAME`,`TRIGGER_GROUP`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `qrtz_cron_triggers`
--

LOCK TABLES `qrtz_cron_triggers` WRITE;
/*!40000 ALTER TABLE `qrtz_cron_triggers` DISABLE KEYS */;
/*!40000 ALTER TABLE `qrtz_cron_triggers` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `qrtz_fired_triggers`
--

DROP TABLE IF EXISTS `qrtz_fired_triggers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `qrtz_fired_triggers` (
  `ENTRY_ID` varchar(95) NOT NULL,
  `TRIGGER_NAME` varchar(80) NOT NULL,
  `TRIGGER_GROUP` varchar(80) NOT NULL,
  `IS_VOLATILE` varchar(1) NOT NULL,
  `INSTANCE_NAME` varchar(80) NOT NULL,
  `FIRED_TIME` bigint(13) NOT NULL,
  `STATE` varchar(16) NOT NULL,
  `JOB_NAME` varchar(80) DEFAULT NULL,
  `JOB_GROUP` varchar(80) DEFAULT NULL,
  `IS_STATEFUL` varchar(1) DEFAULT NULL,
  `REQUESTS_RECOVERY` varchar(1) DEFAULT NULL,
  `PRIORITY` int(11) NOT NULL,
  PRIMARY KEY (`ENTRY_ID`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `qrtz_fired_triggers`
--

LOCK TABLES `qrtz_fired_triggers` WRITE;
/*!40000 ALTER TABLE `qrtz_fired_triggers` DISABLE KEYS */;
/*!40000 ALTER TABLE `qrtz_fired_triggers` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `qrtz_job_details`
--

DROP TABLE IF EXISTS `qrtz_job_details`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `qrtz_job_details` (
  `JOB_NAME` varchar(80) NOT NULL,
  `JOB_GROUP` varchar(80) NOT NULL,
  `DESCRIPTION` varchar(120) DEFAULT NULL,
  `JOB_CLASS_NAME` varchar(128) NOT NULL,
  `IS_DURABLE` varchar(1) NOT NULL,
  `IS_VOLATILE` varchar(1) NOT NULL,
  `IS_STATEFUL` varchar(1) NOT NULL,
  `REQUESTS_RECOVERY` varchar(1) NOT NULL,
  `JOB_DATA` blob,
  PRIMARY KEY (`JOB_NAME`,`JOB_GROUP`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `qrtz_job_details`
--

LOCK TABLES `qrtz_job_details` WRITE;
/*!40000 ALTER TABLE `qrtz_job_details` DISABLE KEYS */;
INSERT INTO `qrtz_job_details` VALUES ('org.sakaiproject.component.app.scheduler.ScheduledInvocationManagerImpl.runner','org.sakaiproject.component.app.scheduler.ScheduledInvocationManagerImpl',NULL,'org.sakaiproject.component.app.scheduler.jobs.ScheduledInvocationRunner','0','0','1','0','#\n#Sun Apr 22 16:35:33 CDT 2012\n');
/*!40000 ALTER TABLE `qrtz_job_details` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `qrtz_job_listeners`
--

DROP TABLE IF EXISTS `qrtz_job_listeners`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `qrtz_job_listeners` (
  `JOB_NAME` varchar(80) NOT NULL,
  `JOB_GROUP` varchar(80) NOT NULL,
  `JOB_LISTENER` varchar(80) NOT NULL,
  PRIMARY KEY (`JOB_NAME`,`JOB_GROUP`,`JOB_LISTENER`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `qrtz_job_listeners`
--

LOCK TABLES `qrtz_job_listeners` WRITE;
/*!40000 ALTER TABLE `qrtz_job_listeners` DISABLE KEYS */;
/*!40000 ALTER TABLE `qrtz_job_listeners` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `qrtz_locks`
--

DROP TABLE IF EXISTS `qrtz_locks`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `qrtz_locks` (
  `LOCK_NAME` varchar(40) NOT NULL,
  PRIMARY KEY (`LOCK_NAME`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `qrtz_locks`
--

LOCK TABLES `qrtz_locks` WRITE;
/*!40000 ALTER TABLE `qrtz_locks` DISABLE KEYS */;
INSERT INTO `qrtz_locks` VALUES ('CALENDAR_ACCESS'),('JOB_ACCESS'),('MISFIRE_ACCESS'),('STATE_ACCESS'),('TRIGGER_ACCESS');
/*!40000 ALTER TABLE `qrtz_locks` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `qrtz_paused_trigger_grps`
--

DROP TABLE IF EXISTS `qrtz_paused_trigger_grps`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `qrtz_paused_trigger_grps` (
  `TRIGGER_GROUP` varchar(80) NOT NULL,
  PRIMARY KEY (`TRIGGER_GROUP`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `qrtz_paused_trigger_grps`
--

LOCK TABLES `qrtz_paused_trigger_grps` WRITE;
/*!40000 ALTER TABLE `qrtz_paused_trigger_grps` DISABLE KEYS */;
/*!40000 ALTER TABLE `qrtz_paused_trigger_grps` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `qrtz_scheduler_state`
--

DROP TABLE IF EXISTS `qrtz_scheduler_state`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `qrtz_scheduler_state` (
  `INSTANCE_NAME` varchar(80) NOT NULL,
  `LAST_CHECKIN_TIME` bigint(13) NOT NULL,
  `CHECKIN_INTERVAL` bigint(13) NOT NULL,
  `RECOVERER` varchar(80) DEFAULT NULL,
  PRIMARY KEY (`INSTANCE_NAME`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `qrtz_scheduler_state`
--

LOCK TABLES `qrtz_scheduler_state` WRITE;
/*!40000 ALTER TABLE `qrtz_scheduler_state` DISABLE KEYS */;
/*!40000 ALTER TABLE `qrtz_scheduler_state` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `qrtz_simple_triggers`
--

DROP TABLE IF EXISTS `qrtz_simple_triggers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `qrtz_simple_triggers` (
  `TRIGGER_NAME` varchar(80) NOT NULL,
  `TRIGGER_GROUP` varchar(80) NOT NULL,
  `REPEAT_COUNT` bigint(7) NOT NULL,
  `REPEAT_INTERVAL` bigint(12) NOT NULL,
  `TIMES_TRIGGERED` bigint(7) NOT NULL,
  PRIMARY KEY (`TRIGGER_NAME`,`TRIGGER_GROUP`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `qrtz_simple_triggers`
--

LOCK TABLES `qrtz_simple_triggers` WRITE;
/*!40000 ALTER TABLE `qrtz_simple_triggers` DISABLE KEYS */;
INSERT INTO `qrtz_simple_triggers` VALUES ('org.sakaiproject.component.app.scheduler.ScheduledInvocationManagerImpl.runner','org.sakaiproject.component.app.scheduler.ScheduledInvocationManagerImpl',-1,600000,0);
/*!40000 ALTER TABLE `qrtz_simple_triggers` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `qrtz_trigger_listeners`
--

DROP TABLE IF EXISTS `qrtz_trigger_listeners`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `qrtz_trigger_listeners` (
  `TRIGGER_NAME` varchar(80) NOT NULL,
  `TRIGGER_GROUP` varchar(80) NOT NULL,
  `TRIGGER_LISTENER` varchar(80) NOT NULL,
  PRIMARY KEY (`TRIGGER_NAME`,`TRIGGER_GROUP`,`TRIGGER_LISTENER`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `qrtz_trigger_listeners`
--

LOCK TABLES `qrtz_trigger_listeners` WRITE;
/*!40000 ALTER TABLE `qrtz_trigger_listeners` DISABLE KEYS */;
/*!40000 ALTER TABLE `qrtz_trigger_listeners` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `qrtz_triggers`
--

DROP TABLE IF EXISTS `qrtz_triggers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `qrtz_triggers` (
  `TRIGGER_NAME` varchar(80) NOT NULL,
  `TRIGGER_GROUP` varchar(80) NOT NULL,
  `JOB_NAME` varchar(80) NOT NULL,
  `JOB_GROUP` varchar(80) NOT NULL,
  `IS_VOLATILE` varchar(1) NOT NULL,
  `DESCRIPTION` varchar(120) DEFAULT NULL,
  `NEXT_FIRE_TIME` bigint(13) DEFAULT NULL,
  `PREV_FIRE_TIME` bigint(13) DEFAULT NULL,
  `TRIGGER_STATE` varchar(16) NOT NULL,
  `TRIGGER_TYPE` varchar(8) NOT NULL,
  `START_TIME` bigint(13) NOT NULL,
  `END_TIME` bigint(13) DEFAULT NULL,
  `CALENDAR_NAME` varchar(80) DEFAULT NULL,
  `MISFIRE_INSTR` smallint(2) DEFAULT NULL,
  `PRIORITY` int(11) DEFAULT NULL,
  `JOB_DATA` blob,
  PRIMARY KEY (`TRIGGER_NAME`,`TRIGGER_GROUP`),
  KEY `JOB_NAME` (`JOB_NAME`,`JOB_GROUP`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `qrtz_triggers`
--

LOCK TABLES `qrtz_triggers` WRITE;
/*!40000 ALTER TABLE `qrtz_triggers` DISABLE KEYS */;
INSERT INTO `qrtz_triggers` VALUES ('org.sakaiproject.component.app.scheduler.ScheduledInvocationManagerImpl.runner','org.sakaiproject.component.app.scheduler.ScheduledInvocationManagerImpl','org.sakaiproject.component.app.scheduler.ScheduledInvocationManagerImpl.runner','org.sakaiproject.component.app.scheduler.ScheduledInvocationManagerImpl','0',NULL,1335131133327,-1,'WAITING','SIMPLE',1335131133327,0,NULL,0,5,'');
/*!40000 ALTER TABLE `qrtz_triggers` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `report_xsl_file`
--

DROP TABLE IF EXISTS `report_xsl_file`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `report_xsl_file` (
  `reportDefId` varchar(255) NOT NULL,
  `reportXslFileRef` varchar(255) DEFAULT NULL,
  `xslFile` longblob,
  `xslFileHash` varchar(50) NOT NULL,
  PRIMARY KEY (`reportDefId`,`xslFileHash`),
  KEY `FK6C32ED588EA2574` (`reportDefId`),
  CONSTRAINT `FK6C32ED588EA2574` FOREIGN KEY (`reportDefId`) REFERENCES `reports_def_xml` (`reportDefId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `report_xsl_file`
--

LOCK TABLES `report_xsl_file` WRITE;
/*!40000 ALTER TABLE `report_xsl_file` DISABLE KEYS */;
INSERT INTO `report_xsl_file` VALUES ('sessionAdmin-000-111-222','/org/sakaiproject/reports/xsl/shared/defaultExport.xsl','<?xml version=\"1.0\" ?>\n<xsl:stylesheet version=\"1.0\" xmlns:xsl=\"http://www.w3.org/1999/XSL/Transform\">\n	\n	<xsl:template match=\"reportResult\">\n	   <reportResult>\n	      	<xsl:copy-of select=\"*\"></xsl:copy-of>\n	   </reportResult>\n	</xsl:template>\n\n</xsl:stylesheet>\n\n','38b660fd1d8cc281e13e201ad1d9c242'),('sessionAdmin-000-111-222','/org/sakaiproject/reports/xsl/usage/sessionReport.xsl','<?xml version=\"1.0\" encoding=\"utf-8\"?>\n<xsl:stylesheet xmlns:xsl=\"http://www.w3.org/1999/XSL/Transform\" version=\"1.0\">\n	<xsl:template match=\"reportResult\">\n<style>\n.reportTable1 {\n	font-family: Arial, Helvetica, sans-serif;\n	font-size: 11px;\n	font-style: normal;\n	font-weight: normal;\n	font-variant: normal;\n	border: 1px solid #CCCCCC;\n	color: #666666;\n}\n.reportTable1Label1 {\n	background-color: #F4F4F4;\n	width: 40%;\n	border-right: 1px solid #CCCCCC;\n	border-bottom: 1px solid #CCCCCC;\n}\n.reportTable2Header {\n	background-color: #E5E5E5;\n	border-bottom: 1px solid White;\n	font-weight: bold;\n	padding-top: 12px;\n	padding-right: 12px;\n	padding-bottom: 12px;\n	padding-left: 8px;\n}\n.reportTable2 {\n	font-family: Arial, Helvetica, sans-serif;\n	font-size: 11px;\n	font-style: normal;\n	font-weight: normal;\n	font-variant: normal;\n	color: #666666;\n}\n.reportTable2Labels {\n	font-weight: bold;\n	background-color: #F4F4F4;\n	width: 20%;\n}\n.reportTable2Data {\n	border-bottom-width: 1px;\n	border-bottom-style: dashed;\n	border-bottom-color: #E5E5E5;\n}\n.reportTable2Footer {\n	font-weight: bold;\n	border-bottom-width: medium;\n	border-bottom-style: solid;\n	border-bottom-color: #F4F4F4;\n}\n.reportTable1Data1 {\n	padding-left: 20px;\n	vertical-align: top;\n	border-bottom: 1px solid #CCCCCC;\n	line-height: 18px;\n}\n.reportTable2Labels2 {\n	font-weight: bold;\n	background-color: #F4F4F4;\n}\n.reportTable1Label2 {\n	background-color: #F4F4F4;\n	width: 40%;\n	border-right: 1px solid #CCCCCC;\n	vertical-align: top;\n}\n.reportTable1Data2 {\n	padding-left: 20px;\n	vertical-align: top;\n	line-height: 18px;\n}\n.reportTableLabelEmphasis {\n	font-weight: bold;\n}\n.reportData1 {\n	font-family: Arial, Helvetica, sans-serif;\n	font-size: 14px;\n	color: #666666;\n}\n.reportInfo {\n	color: #999999;\n	font-weight: normal;\n}\n.reportTableDataEmphasis {\n	font-weight: bold;\n}\n.reportTable1 a, .reportTable1 a:link {\n	color: #6699CC;\n	padding-left: 5px;\n}\n.reportTable2Header a, .reportTable2Header a:link {\n	color: #666666;\n	text-decoration: none;\n}\n.reportTable2Header a:hover {\n	text-decoration: underline;\n}\n\n.reportTable2DataOdd {\n	background-color: #F4F4F4;\n}\n.reportTable2DataEven {\n	background-color: White;\n}\n</style>\n		<xsl:variable name=\"absentees\">\n			<xsl:value-of select=\"count(extraReportResult[@index=\'2\']/data/datarow)\"/>\n		</xsl:variable>\n		<xsl:variable name=\"totalVisitors\">\n			<xsl:value-of select=\"$absentees + extraReportResult/data/datarow/element[@colName=\'UNIQUEVISITS\']\"/>\n		</xsl:variable>		\n		<xsl:variable name=\"avgsession\">\n			<xsl:value-of select=\"extraReportResult/data/datarow/element[@colName=\'AVGSESSIONINSECONDS\']\"/>\n		</xsl:variable>\n		<xsl:variable name=\"avgsessionHours\">\n			<xsl:value-of select=\"floor($avgsession div 3600)\"/>\n		</xsl:variable>\n		<xsl:variable name=\"avgsessionMinutes\">\n			<xsl:value-of select=\"floor((($avgsession - $avgsessionHours*3600) div 60))\"/>\n		</xsl:variable>\n		<xsl:variable name=\"avgsessionSeconds\">\n			<xsl:value-of select=\"format-number((($avgsession - $avgsessionHours*3600 - $avgsessionMinutes*60)),\'###.0\')\"/>\n		</xsl:variable>\n		<script type=\"\">\n			function toggle(obj) {\n				var el = document.getElementById(obj);\n				if ( el.style.display != \'none\' ) {\n					el.style.display = \'none\';\n				}\n				else {\n					el.style.display = \'\';\n				}\n			}		\n		</script>\n		<div class=\"reportData1\">Date Range: <xsl:value-of select=\"parameters/parameter[@name=\'startdate\']\"/> - <xsl:value-of select=\"parameters/parameter[@name=\'enddate\']\"/>\n		</div>\n		<br/>\n		<table width=\"100%\" border=\"0\" cellpadding=\"8\" cellspacing=\"0\" class=\"reportTable1\">\n			<tr>\n				<td class=\"reportTable1Label1\">\n					<span class=\"reportTableLabelEmphasis\">Total Visitors:</span>\n					<br/>\n					<span class=\"reportInfo\">All visitors (both unique and returning) that have logged in during the given date range</span>\n				</td>\n				<td class=\"reportTable1Data1\">\n					<xsl:value-of select=\"$totalVisitors\"/>\n				</td>\n			</tr>\n			<tr>\n				<td class=\"reportTable1Label1\">\n					<span class=\"reportTableLabelEmphasis\">Total Unique Visitors:</span>\n					<br/>\n					<span class=\"reportInfo\">Only unique visitors that have logged in during the given date range</span>\n				</td>\n				<td class=\"reportTable1Data1\">\n					<xsl:value-of select=\"extraReportResult/data/datarow/element[@colName=\'UNIQUEVISITS\']\"/> (about <xsl:value-of select=\"format-number(extraReportResult/data/datarow/element[@colName=\'UNIQUEVISITS\'] div $totalVisitors*100,\'###.0\')\"/>\n					<xsl:text>%</xsl:text>)<br/>\n					<span class=\"reportInfo\">Percentage is with respect to the total number of users in the system</span>\n				</td>\n			</tr>\n			<tr>\n				<td class=\"reportTable1Label1\">\n					<span class=\"reportTableLabelEmphasis\">Average Session Length:</span>\n					<br/>\n					<span class=\"reportInfo\">Average length of time each visitor was logged in for during the given date range</span>\n				</td>\n				<td class=\"reportTable1Data1\">\n					<xsl:value-of select=\"$avgsessionHours\"/>h:<xsl:value-of select=\"$avgsessionMinutes\"/>m:<xsl:value-of select=\"$avgsessionSeconds\"/>s\n				</td>\n			</tr>\n			<tr>\n				<td class=\"reportTable1Label2\">\n					<span class=\"reportTableLabelEmphasis\">Absentees:</span>\n					<br/>\n					<span class=\"reportInfo\">Users that have not logged-in during the given date range </span>\n				</td>\n				<td class=\"reportTable1Data2\">\n					<span class=\"reportTableDataEmphasis\">\n						<xsl:value-of select=\"$absentees\"/>\n					</span>\n					<xsl:if test=\"$absentees != 0\">\n						<a id=\"listLink\" href=\"javascript:toggle(\'absenteeList\');\">view/hide list</a>\n						<div id=\"absenteeList\" style=\"display:none;\">\n						<table border=\"0\" cellspacing=\"0\" cellpadding=\"5\" class=\"reportTable2\">\n							<tr>\n								<td class=\"reportTableDataEmphasis\">User Id:</td>\n								<td class=\"reportTableDataEmphasis\">First Name:</td>\n								<td class=\"reportTableDataEmphasis\">Last Name:</td>\n							</tr>\n							<xsl:for-each select=\"extraReportResult[@index=\'2\']/data/datarow\">\n							<tr>\n								<td><xsl:value-of select=\"element[@colName=\'USER_EID\']\"/></td>\n								<td>\n								<xsl:choose>\n									<xsl:when test=\"element[@colName=\'FIRST_NAME\'] = \'\'\">\n										<xsl:text>(not provided)</xsl:text>\n									</xsl:when>\n									<xsl:otherwise>\n										<xsl:value-of select=\"element[@colName=\'FIRST_NAME\']\"/>\n									</xsl:otherwise>\n								</xsl:choose>\n								</td>\n								<td>\n								<xsl:choose>\n									<xsl:when test=\"element[@colName=\'LAST_NAME\'] = \'\'\">\n										<xsl:text>(not provided)</xsl:text>\n									</xsl:when>\n									<xsl:otherwise>\n										<xsl:value-of select=\"element[@colName=\'LAST_NAME\']\"/>\n									</xsl:otherwise>\n								</xsl:choose>\n								</td>\n							</tr>\n							</xsl:for-each>\n						</table>\n						</div>\n					</xsl:if>\n				</td>\n			</tr>\n		</table>\n	</xsl:template>\n</xsl:stylesheet>\n','a85455e5fcf3d4dc9f48f5439416f253'),('totalStorageReport-01','/org/sakaiproject/reports/xsl/shared/defaultExport.xsl','<?xml version=\"1.0\" ?>\n<xsl:stylesheet version=\"1.0\" xmlns:xsl=\"http://www.w3.org/1999/XSL/Transform\">\n	\n	<xsl:template match=\"reportResult\">\n	   <reportResult>\n	      	<xsl:copy-of select=\"*\"></xsl:copy-of>\n	   </reportResult>\n	</xsl:template>\n\n</xsl:stylesheet>\n\n','38b660fd1d8cc281e13e201ad1d9c242'),('totalStorageReport-01','/org/sakaiproject/reports/xsl/usage/currentStorage.xsl','<?xml version=\"1.0\" encoding=\"utf-8\"?>\n<?altova_samplexml currentStorageReport.xml?>\n<xsl:stylesheet xmlns:xsl=\"http://www.w3.org/1999/XSL/Transform\" version=\"1.0\">\n\n    <xsl:template match=\"reportResult\">\n           <style>\n            .reportTable1 {\n                font-family: Arial, Helvetica, sans-serif;\n                font-size: 11px;\n                font-style: normal;\n                font-weight: normal;\n                font-variant: normal;\n                border: 1px solid #CCCCCC;\n                color: #666666;\n            }\n            .reportTable1Label1 {\n                background-color: #F4F4F4;\n                width: 40%;\n                border-right: 1px solid #CCCCCC;\n                border-bottom: 1px solid #CCCCCC;\n            }\n            .reportTable2Header {\n                background-color: #E5E5E5;\n                border-bottom: 1px solid White;\n                font-weight: bold;\n                padding-top: 12px;\n                padding-right: 12px;\n                padding-bottom: 12px;\n                padding-left: 8px;\n            }\n            .reportTable2 {\n                font-family: Arial, Helvetica, sans-serif;\n                font-size: 11px;\n                font-style: normal;\n                font-weight: normal;\n                font-variant: normal;\n                color: #666666;\n            }\n            .reportTable2Labels {\n                font-weight: bold;\n                background-color: #F4F4F4;\n                width: 20%;\n            }\n            .reportTable2Data {\n                border-bottom-width: 1px;\n                border-bottom-style: dashed;\n                border-bottom-color: #E5E5E5;\n            }\n            .reportTable2Footer {\n                font-weight: bold;\n                border-bottom-width: medium;\n                border-bottom-style: solid;\n                border-bottom-color: #F4F4F4;\n            }\n            .reportTable1Data1 {\n                padding-left: 20px;\n                vertical-align: top;\n                border-bottom: 1px solid #CCCCCC;\n                line-height: 18px;\n            }\n            .reportTable2Labels2 {\n\n                font-weight: bold;\n                background-color: #F4F4F4;\n            }\n            .reportTable1Label2 {\n                background-color: #F4F4F4;\n                width: 40%;\n                border-right: 1px solid #CCCCCC;\n                vertical-align: top;\n            }\n            .reportTable1Data2 {\n                padding-left: 20px;\n                vertical-align: top;\n                line-height: 18px;\n            }\n            .reportTableLabelEmphasis {\n                font-weight: bold;\n            }\n            .reportData1 {\n                font-family: Arial, Helvetica, sans-serif;\n                font-size: 14px;\n                color: #666666;\n            }\n            .reportInfo {\n                color: #999999;\n            }\n            .reportTableDataEmphasis {\n\n                font-weight: bold;\n            }\n            .reportTable1 a, .reportTable1 a:link {\n                color: #6699CC;\n                padding-left: 5px;\n            }\n\n        </style>\n        <table width=\"100%\" border=\"0\" cellpadding=\"8\" cellspacing=\"0\" class=\"reportTable1\">\n			<tr>\n				<td class=\"reportTable1Label1\">\n					<span class=\"reportTableDataEmphasis\">Average Number of Files Stored</span>\n					<br/>\n					<span class=\"reportInfo\">On average, users are storing this many files</span>\n				</td>\n				<td class=\"reportTable1Data1\">\n					<xsl:value-of select=\"data/datarow/element[@colName=\'AVG(FILE_COUNT)\']\"/>\n				</td>\n			</tr>\n			<tr>\n				<td class=\"reportTable1Label1\">\n					<span class=\"reportTableDataEmphasis\">Average Size of Files Stored</span>\n					<br/>\n					<span class=\"reportInfo\">On average, user files are this large</span>\n				</td>\n				<td class=\"reportTable1Data1\">\n					<xsl:call-template name=\"chooseSize\">\n						<xsl:with-param name=\"num\"><xsl:value-of select=\"data/datarow/element[@colName=\'AVG(AVG_SIZE)\']\"/></xsl:with-param>\n					</xsl:call-template>\n				</td>\n			</tr>\n			<tr>\n				<td class=\"reportTable1Label2\">\n					<span class=\"reportTableDataEmphasis\">Average Disk Space Used</span>\n					<br/>\n					<span class=\"reportInfo\">On average, users occupy this much disk space</span>\n				</td>\n				<td class=\"reportTable1Data2\">\n					<xsl:call-template name=\"chooseSize\">\n						<xsl:with-param name=\"num\"><xsl:value-of select=\"data/datarow/element[@colName=\'AVG(AVG_SPACE)\']\"/></xsl:with-param>\n					</xsl:call-template>\n				</td>\n			</tr>\n		</table>\n		<br/>\n		<table width=\"100%\" border=\"0\" cellpadding=\"8\" cellspacing=\"0\" class=\"reportTable2\">\n			<tr>\n				<td colspan=\"4\" class=\"reportTable2Header\">Storage Summary</td>\n			</tr>\n			<tr>\n				<td class=\"reportTable2Labels\">File Type</td>\n				<td class=\"reportTable2Labels2\">Total</td>\n				<td class=\"reportTable2Labels2\">Avg. Size</td>\n				<td class=\"reportTable2Labels2\">Total Size</td>\n			</tr>\n			<xsl:for-each select=\"extraReportResult/data/datarow\">\n				<tr>\n					<td class=\"reportTable2Data\">\n						<xsl:value-of select=\"element[@colName=\'FILE_TYPE\']\"/>\n					</td>\n					<td class=\"reportTable2Data\">\n						<xsl:value-of select=\"element[@colName=\'TOTAL_FILES\']\"/>\n					</td>\n					<td class=\"reportTable2Data\">\n					<xsl:if test=\"element[@colName=\'AVG_SIZE\'] and element[@colName=\'AVG_SIZE\'] != \'\'\">\n						<xsl:call-template name=\"chooseSize\">\n							<xsl:with-param name=\"num\"><xsl:value-of select=\"element[@colName=\'AVG_SIZE\']\"/></xsl:with-param>\n						</xsl:call-template>\n					</xsl:if>\n					</td>\n					<td class=\"reportTable2Data\">\n					<xsl:if test=\"element[@colName=\'TOTAL_SIZE\'] and element[@colName=\'TOTAL_SIZE\'] != \'\'\">\n						<xsl:call-template name=\"chooseSize\">\n							<xsl:with-param name=\"num\"><xsl:value-of select=\"element[@colName=\'TOTAL_SIZE\']\"/></xsl:with-param>\n						</xsl:call-template>\n					</xsl:if>\n					</td>\n				</tr>\n			</xsl:for-each>\n			<tr>\n				<td class=\"reportTable2Footer\">Totals:</td>\n				<td class=\"reportTable2Footer\">\n					<xsl:value-of select=\"sum(extraReportResult/data/datarow/element[@colName=\'TOTAL_FILES\'])\"/>\n				</td>\n				<td class=\"reportTable2Footer\">\n					<xsl:call-template name=\"chooseSize\">\n						<xsl:with-param name=\"num\"><xsl:value-of select=\"sum(extraReportResult/data/datarow/element[@colName=\'AVG_SIZE\']) div count(extraReportResult/data/datarow)\"/></xsl:with-param>\n					</xsl:call-template>\n				</td>\n				<td class=\"reportTable2Footer\">\n					<xsl:call-template name=\"chooseSize\">\n						<xsl:with-param name=\"num\"><xsl:value-of select=\"sum(extraReportResult/data/datarow/element[@colName=\'TOTAL_SIZE\'])\"/></xsl:with-param>\n					</xsl:call-template>\n					<span class=\"reportInfo\">\n						<xsl:text> - Out of </xsl:text>\n						<xsl:call-template name=\"chooseSize\">\n							<xsl:with-param name=\"num\"><xsl:value-of select=\"extraReportResult[@index=\'1\']/data/datarow/element[@colName=\'TOTALALOCATEDSPACE\']\"/></xsl:with-param>\n						</xsl:call-template>\n					</span>\n				</td>\n			</tr>\n		</table>\n	</xsl:template>\n	<xsl:template name=\"chooseSize\">\n		<xsl:param name=\"num\"/>\n		<xsl:choose>\n			<xsl:when test=\"($num div 1048576) >= 1\">\n				<xsl:value-of select=\"format-number($num div 1048576,\'###,###.0\')\"/> GB\n			</xsl:when>\n			<xsl:when test=\"($num div 1024) >= 1\">\n				<xsl:value-of select=\"format-number($num div 1024,\'###,###.0\')\"/> MB\n			</xsl:when>\n			<xsl:otherwise>\n				<xsl:value-of select=\"format-number($num,\'###,##0.0\')\"/> KB\n			</xsl:otherwise>\n		</xsl:choose>\n	</xsl:template>\n\n</xsl:stylesheet>\n','67815b48eb39d96f6966edb56f02cb51'),('userStorage-01','/org/sakaiproject/reports/xsl/usage/userStorage.xsl','<?xml version=\"1.0\" encoding=\"utf-8\"?>\n<xsl:stylesheet xmlns:xsl=\"http://www.w3.org/1999/XSL/Transform\" version=\"1.0\">\n    <link rel=\"stylesheet\" media=\"all\"\n					href=\"/library/skin/default/tool.css\" type=\"text/css\" />\n    <xsl:template match=\"reportResult\">\n           <style>\n            .reportTable1 {\n                font-family: Arial, Helvetica, sans-serif;\n                font-size: 11px;\n                font-style: normal;\n                font-weight: normal;\n                font-variant: normal;\n                border: 1px solid #CCCCCC;\n                color: #666666;\n            }\n            .reportTable1Label1 {\n                background-color: #F4F4F4;\n                width: 40%;\n                border-right: 1px solid #CCCCCC;\n                border-bottom: 1px solid #CCCCCC;\n            }\n            .reportTable2Header {\n                background-color: #E5E5E5;\n                border-bottom: 1px solid White;\n                font-weight: bold;\n                padding-top: 12px;\n                padding-right: 12px;\n                padding-bottom: 12px;\n                padding-left: 8px;\n            }\n            .reportTable2 {\n                font-family: Arial, Helvetica, sans-serif;\n                font-size: 11px;\n                font-style: normal;\n                font-weight: normal;\n                font-variant: normal;\n                color: #666666;\n            }\n            .reportTable2Labels {\n                font-weight: bold;\n                background-color: #F4F4F4;\n                width: 20%;\n            }\n            .reportTable2Data {\n                border-bottom-width: 1px;\n                border-bottom-style: dashed;\n                border-bottom-color: #E5E5E5;\n            }\n            .reportTable2Footer {\n                font-weight: bold;\n                border-bottom-width: medium;\n                border-bottom-style: solid;\n                border-bottom-color: #F4F4F4;\n            }\n            .reportTable1Data1 {\n                padding-left: 20px;\n                vertical-align: top;\n                border-bottom: 1px solid #CCCCCC;\n                line-height: 18px;\n            }\n            .reportTable2Labels2 {\n\n                font-weight: bold;\n                background-color: #F4F4F4;\n            }\n            .reportTable1Label2 {\n                background-color: #F4F4F4;\n                width: 40%;\n                border-right: 1px solid #CCCCCC;\n                vertical-align: top;\n            }\n            .reportTable1Data2 {\n                padding-left: 20px;\n                vertical-align: top;\n                line-height: 18px;\n            }\n            .reportTableLabelEmphasis {\n                font-weight: bold;\n            }\n            .reportData1 {\n                font-family: Arial, Helvetica, sans-serif;\n                font-size: 14px;\n                color: #666666;\n            }\n            .reportInfo {\n                color: #999999;\n            }\n            .reportTableDataEmphasis {\n\n                font-weight: bold;\n            }\n            .reportTable1 a, .reportTable1 a:link {\n                color: #6699CC;\n                padding-left: 5px;\n            }\n\n        </style>\n        <table width=\"100%\" border=\"0\" cellpadding=\"8\" cellspacing=\"0\" class=\"reportTable2\">\n			<tr>\n				<td class=\"reportTable2Header\">ID</td>\n				<td class=\"reportTable2Header\">Last Name</td>\n				<td class=\"reportTable2Header\">First Name</td>\n				<td class=\"reportTable2Header\">Disk Space Used in Workspace</td>\n				<td class=\"reportTable2Header\">Disk Space Used in Site Folder(s)</td>\n				<td class=\"reportTable2Header\">Total Disk Space Used</td>\n			</tr>\n			<xsl:for-each select=\"data/datarow\">\n				<xsl:sort select=\"element[@colName=\'LAST_NAME\']\" />\n				<xsl:variable name=\"setClass\">\n				<xsl:choose>\n					<xsl:when test=\"@index mod 2 = 0\"><xsl:text>reportTable2DataOdd</xsl:text></xsl:when>\n					<xsl:otherwise><xsl:text>reportTable2DataEven</xsl:text></xsl:otherwise>\n				</xsl:choose>\n				</xsl:variable>\n				<tr>\n					<td>\n						<xsl:attribute name=\"class\"><xsl:value-of select=\"$setClass\"/></xsl:attribute>\n						<xsl:value-of select=\"element[@colName=\'USER_EID\']\"/>\n					</td>\n					<td>\n						<xsl:attribute name=\"class\"><xsl:value-of select=\"$setClass\"/></xsl:attribute>\n						<xsl:value-of select=\"element[@colName=\'LAST_NAME\']\"/>\n					</td>\n					<td>\n						<xsl:attribute name=\"class\"><xsl:value-of select=\"$setClass\"/></xsl:attribute>\n						<xsl:value-of select=\"element[@colName=\'FIRST_NAME\']\"/>\n					</td>\n					<td>\n						<xsl:attribute name=\"class\"><xsl:value-of select=\"$setClass\"/></xsl:attribute>\n						<xsl:call-template name=\"chooseSize\">\n							<xsl:with-param name=\"num\">\n								<xsl:value-of select=\"element[@colName=\'WORK_SPACE_USED\']\"/>\n							</xsl:with-param>\n						</xsl:call-template>\n					</td>\n					<td>\n						<xsl:attribute name=\"class\"><xsl:value-of select=\"$setClass\"/></xsl:attribute>\n						<xsl:call-template name=\"chooseSize\">\n							<xsl:with-param name=\"num\">\n								<xsl:value-of select=\"element[@colName=\'SITE_SPACE_USED\']\"/>\n							</xsl:with-param>\n						</xsl:call-template>\n					</td>\n					<td>\n						<xsl:attribute name=\"class\"><xsl:value-of select=\"$setClass\"/></xsl:attribute>\n						<xsl:call-template name=\"chooseSize\">\n							<xsl:with-param name=\"num\">\n								<xsl:value-of select=\"element[@colName=\'(WORK_SPACE_USED +  SITE_SPACE_USED)\']\"/>\n							</xsl:with-param>\n						</xsl:call-template>\n					</td>\n				</tr>\n			</xsl:for-each>\n		</table>\n	</xsl:template>\n	<xsl:template name=\"chooseSize\">\n		<xsl:param name=\"num\"/>\n		<xsl:choose>\n			<xsl:when test=\"($num div 1048576) >= 1\">\n				<xsl:value-of select=\"format-number($num div 1048576,\'###,###.#\')\"/> GB\n			</xsl:when>\n			<xsl:when test=\"($num div 1024) >= 1\">\n				<xsl:value-of select=\"format-number($num div 1024,\'###,###.#\')\"/> MB\n			</xsl:when>\n			<xsl:otherwise>\n				<xsl:value-of select=\"format-number($num,\'###,##0.0\')\"/> KB\n			</xsl:otherwise>\n		</xsl:choose>\n	</xsl:template>\n</xsl:stylesheet>\n','3012b54f1ee801d19a92664f01109459'),('userStorage-01','/org/sakaiproject/reports/xsl/shared/defaultExport.xsl','<?xml version=\"1.0\" ?>\n<xsl:stylesheet version=\"1.0\" xmlns:xsl=\"http://www.w3.org/1999/XSL/Transform\">\n	\n	<xsl:template match=\"reportResult\">\n	   <reportResult>\n	      	<xsl:copy-of select=\"*\"></xsl:copy-of>\n	   </reportResult>\n	</xsl:template>\n\n</xsl:stylesheet>\n\n','38b660fd1d8cc281e13e201ad1d9c242'),('userStorageByUserId-01','/org/sakaiproject/reports/xsl/shared/defaultExport.xsl','<?xml version=\"1.0\" ?>\n<xsl:stylesheet version=\"1.0\" xmlns:xsl=\"http://www.w3.org/1999/XSL/Transform\">\n	\n	<xsl:template match=\"reportResult\">\n	   <reportResult>\n	      	<xsl:copy-of select=\"*\"></xsl:copy-of>\n	   </reportResult>\n	</xsl:template>\n\n</xsl:stylesheet>\n\n','38b660fd1d8cc281e13e201ad1d9c242'),('userStorageByUserId-01','/org/sakaiproject/reports/xsl/usage/userStorageDetails.xsl','<?xml version=\"1.0\" encoding=\"utf-8\"?>\n<?altova_samplexml userstoragedetail.xml?>\n<xsl:stylesheet xmlns:xsl=\"http://www.w3.org/1999/XSL/Transform\" version=\"1.0\">\n    <link rel=\"stylesheet\" media=\"all\"\n					href=\"/library/skin/default/tool.css\" type=\"text/css\" />\n    <xsl:template match=\"reportResult\">\n		<div class=\"reportData1\">User ID: <xsl:value-of select=\"parameters/parameter[@name=\'userId\']\"/></div>\n		<br/>\n		<table width=\"100%\" border=\"0\" cellpadding=\"8\" cellspacing=\"0\" class=\"reportTable2\">\n			<tr>\n				<td colspan=\"4\" class=\"reportTable2Header\">My Workspace</td>\n			</tr>\n			<tr>\n				<td class=\"reportTable2Labels\">File Type</td>\n				<td class=\"reportTable2Labels2\">Total</td>\n				<td class=\"reportTable2Labels2\">Avg. Size</td>\n				<td class=\"reportTable2Labels2\">Total Size</td>\n			</tr>\n			<xsl:for-each select=\"extraReportResult[1]/data/datarow\">\n				<tr>\n					<td class=\"reportTable2Data\">\n						<xsl:value-of select=\"element[@colName=\'FILE_TYPE\']\"/>\n					</td>\n					<td class=\"reportTable2Data\">\n						<xsl:value-of select=\"element[@colName=\'TOTAL_FILES\']\"/>\n					</td>\n					<td class=\"reportTable2Data\">\n						<xsl:call-template name=\"chooseSize\">\n							<xsl:with-param name=\"num\"><xsl:value-of select=\"element[@colName=\'AVG_SIZE\']\"/></xsl:with-param>\n						</xsl:call-template>\n					</td>\n					<td class=\"reportTable2Data\">\n						<xsl:call-template name=\"chooseSize\">\n							<xsl:with-param name=\"num\"><xsl:value-of select=\"element[@colName=\'TOTAL_SIZE\']\"/></xsl:with-param>\n						</xsl:call-template>\n					</td>\n				</tr>\n			</xsl:for-each>\n			<tr>\n				<td class=\"reportTable2Footer\">Totals:</td>\n				<td class=\"reportTable2Footer\">\n					<xsl:value-of select=\"sum(extraReportResult[1]/data/datarow/element[@colName=\'TOTAL_FILES\'])\"/>\n				</td>\n				<td class=\"reportTable2Footer\">\n					<xsl:call-template name=\"chooseSize\">\n						<xsl:with-param name=\"num\"><xsl:value-of select=\"sum(extraReportResult[1]/data/datarow/element[@colName=\'AVG_SIZE\']) div count(extraReportResult[1]/data/datarow)\"/></xsl:with-param>\n					</xsl:call-template>\n				</td>\n				<td class=\"reportTable2Footer\">\n					<xsl:call-template name=\"chooseSize\">\n						<xsl:with-param name=\"num\"><xsl:value-of select=\"sum(extraReportResult[1]/data/datarow/element[@colName=\'TOTAL_SIZE\'])\"/></xsl:with-param>\n					</xsl:call-template>\n					<span class=\"reportInfo\"> <xsl:text> - Out of </xsl:text>\n						<xsl:call-template name=\"chooseSize\">\n							<xsl:with-param name=\"num\"><xsl:value-of select=\"extraReportResult[@index=\'2\']/data/datarow/element[@colName=\'WORKSPACETOTALALLOCATEDSPACE\']\"/></xsl:with-param>\n						</xsl:call-template></span>\n				</td>\n			</tr>\n		</table>\n		<br/>\n		<table width=\"100%\" border=\"0\" cellpadding=\"8\" cellspacing=\"0\" class=\"reportTable2\">\n			<tr>\n				<td colspan=\"4\" class=\"reportTable2Header\">Site Folder(s)</td>\n			</tr>\n			<tr>\n				<td class=\"reportTable2Labels\">File Type</td>\n				<td class=\"reportTable2Labels2\">Total</td>\n				<td class=\"reportTable2Labels2\">Avg. Size</td>\n				<td class=\"reportTable2Labels2\">Total Size</td>\n			</tr>\n			<xsl:for-each select=\"extraReportResult[2]/data/datarow\">\n				<tr>\n					<td class=\"reportTable2Data\">\n						<xsl:value-of select=\"element[@colName=\'FILE_TYPE\']\"/>\n					</td>\n					<td class=\"reportTable2Data\">\n						<xsl:value-of select=\"element[@colName=\'TOTAL_FILES\']\"/>\n					</td>\n					<td class=\"reportTable2Data\">\n						<xsl:call-template name=\"chooseSize\">\n							<xsl:with-param name=\"num\"><xsl:value-of select=\"element[@colName=\'AVG_SIZE\']\"/></xsl:with-param>\n						</xsl:call-template>\n					</td>\n					<td class=\"reportTable2Data\">\n						<xsl:call-template name=\"chooseSize\">\n							<xsl:with-param name=\"num\"><xsl:value-of select=\"element[@colName=\'TOTAL_SIZE\']\"/></xsl:with-param>\n						</xsl:call-template>\n					</td>\n				</tr>\n			</xsl:for-each>\n			<tr>\n				<td class=\"reportTable2Footer\">Totals:</td>\n				<td class=\"reportTable2Footer\">\n					<xsl:value-of select=\"sum(extraReportResult[2]/data/datarow/element[@colName=\'TOTAL_FILES\'])\"/>\n				</td>\n				<td class=\"reportTable2Footer\">\n					<xsl:call-template name=\"chooseSize\">\n						<xsl:with-param name=\"num\"><xsl:value-of select=\"sum(extraReportResult[2]/data/datarow/element[@colName=\'AVG_SIZE\']) div count(extraReportResult[2]/data/datarow)\"/></xsl:with-param>\n					</xsl:call-template>\n				</td>\n				<td class=\"reportTable2Footer\">\n					<xsl:call-template name=\"chooseSize\">\n						<xsl:with-param name=\"num\"><xsl:value-of select=\"sum(extraReportResult[2]/data/datarow/element[@colName=\'TOTAL_SIZE\'])\"/></xsl:with-param>\n					</xsl:call-template>\n					<span class=\"reportInfo\"> <xsl:text> - Out of </xsl:text>\n						<xsl:call-template name=\"chooseSize\">\n							<xsl:with-param name=\"num\"><xsl:value-of select=\"extraReportResult[@index=\'3\']/data/datarow/element[@colName=\'SITETOTALALLOCATEDSPACE\']\"/></xsl:with-param>\n						</xsl:call-template></span>\n				</td>\n			</tr>\n		</table>	</xsl:template>\n	<xsl:template name=\"chooseSize\">\n		<xsl:param name=\"num\"/>\n		<xsl:choose>\n			<xsl:when test=\"($num div 1048576) >= 1\">\n				<xsl:value-of select=\"format-number($num div 1048576,\'###,###.0\')\"/> GB\n			</xsl:when>\n			<xsl:when test=\"($num div 1024) >= 1\">\n				<xsl:value-of select=\"format-number($num div 1024,\'###,###.0\')\"/> MB\n			</xsl:when>\n			<xsl:otherwise>\n				<xsl:value-of select=\"format-number($num,\'###,###.0\')\"/> KB\n			</xsl:otherwise>\n		</xsl:choose>\n	</xsl:template>\n</xsl:stylesheet>\n','46c596f71e81ff254195615d14c2f660');
/*!40000 ALTER TABLE `report_xsl_file` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `reports_def_xml`
--

DROP TABLE IF EXISTS `reports_def_xml`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `reports_def_xml` (
  `reportDefId` varchar(255) NOT NULL,
  `xmlFile` longblob NOT NULL,
  PRIMARY KEY (`reportDefId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `reports_def_xml`
--

LOCK TABLES `reports_def_xml` WRITE;
/*!40000 ALTER TABLE `reports_def_xml` DISABLE KEYS */;
INSERT INTO `reports_def_xml` VALUES ('sessionAdmin-000-111-222','<?xml version=\"1.0\" encoding=\"UTF-8\"?>\n<!DOCTYPE beans PUBLIC \"-//SPRING//DTD BEAN//EN\" \"http://www.springframework.org/dtd/spring-beans.dtd\">\n<!--\n	Notes:\n\n	Each report MUST have a different idString.  This is how saved reports are\n	linked back to the report definition\n\n    ALL YOUR BASE ARE BELONG TO US!\n-->\n<beans>\n\n\n    <bean id=\"sessionAdminReport\"\n        class=\"org.sakaiproject.reports.model.ReportDefinition\">\n\n        <property name=\"idString\">\n            <value>sessionAdmin-000-111-222</value>\n        </property>\n        <property name=\"usesWarehouse\"><value>true</value></property>\n        <property name=\"title\">\n            <value>\n                Session Report\n            </value>\n        </property>\n       <property name=\"query\">\n            <list>\n               <value>\n                  <![CDATA[select count(*) \"totalVisits\" from dw_session where startTime between ? and ?  ]]>\n               </value>\n                 <value>\n                  <![CDATA[select count(distinct userId) \"uniqueVisits\" from dw_session  where startTime between ? and ?    ]]>\n               </value>\n               <value>\n                   <![CDATA[select avg(durationSeconds) \"avgSessionInSeconds\"  from dw_session  where startTime between ? and ?  ]]>\n               </value>\n               <value>\n                   <![CDATA[select Distinct(user_eid), first_name, last_name from dw_users\n                   where user_id not  in (select distinct userId from dw_session where startTime between ? and ?)\n                    ]]>\n               </value>\n            </list>\n        </property>\n        <property name=\"vendorQuery\">\n             <map>\n                <entry key=\"oracle\">\n                    <list>\n               <value>\n                  <![CDATA[select count(*) \"totalVisits\" from dw_session where startTime between to_date(?) and to_date(?)  ]]>\n               </value>\n                 <value>\n                  <![CDATA[select count(distinct userId) \"uniqueVisits\" from dw_session  where startTime between to_date(?) and to_date(?)    ]]>\n               </value>\n               <value>\n                   <![CDATA[select avg(durationSeconds) \"avgSessionInSeconds\"  from dw_session  where startTime between to_date(?) and to_date(?)  ]]>\n               </value>\n               <value>\n                   <![CDATA[select Distinct(user_eid), first_name, last_name from dw_users\n                   where user_id not  in (select distinct userId from dw_session where startTime between to_date(?) and to_date(?))\n                    ]]>\n               </value>\n                    </list>\n                </entry>\n            </map>\n        </property>\n        <property name=\"description\">\n            <value>\n                Session report\n            </value>\n        </property>\n        <property name=\"siteType\"><!-- some acceptable values: admin,course,project,cig  -->\n            <value>~admin,!admin, portfolioAdmin</value>\n        </property>\n        <property name=\"role\">\n            <value>maintain,admin, Program Admin</value>\n        </property>\n         <property name=\"paramTitle\">\n            <value>\n                Select the following options:\n            </value>\n        </property>\n\n        <property name=\"reportDefinitionParams\">\n            <list>\n                <bean class=\"org.sakaiproject.reports.model.ReportDefinitionParam\">\n                    <property name=\"title\"><value>Start Date:</value></property>\n                    <property name=\"paramName\"><value>startdate</value></property>\n                    <property name=\"description\"><value></value></property>\n                    <property name=\"type\"><value>date</value></property>\n                    <property name=\"valueType\"><value>fillin</value></property>\n                    <property name=\"value\"><value></value></property>\n                </bean>\n                <bean class=\"org.sakaiproject.reports.model.ReportDefinitionParam\">\n                    <property name=\"title\"><value>End Date:</value></property>\n                    <property name=\"paramName\"><value>enddate</value></property>\n                    <property name=\"description\"><value></value></property>\n                    <property name=\"type\"><value>date</value></property>\n                    <property name=\"valueType\"><value>fillin</value></property>\n                    <property name=\"value\"><value></value></property>\n                </bean>\n            </list>\n        </property>\n\n        <property name=\"xsls\">\n            <list>\n                <bean id=\"sessionReport\" class=\"org.sakaiproject.reports.model.ReportXsl\">\n                    <property name=\"xslLink\"><value>/org/sakaiproject/reports/xsl/usage/sessionReport.xsl</value></property>\n                    <property name=\"title\"><value>Session Report</value></property>\n                    <property name=\"isExport\"><value>false</value></property>\n                </bean>\n                 <bean id=\"defaultExport\" class=\"org.sakaiproject.reports.model.ReportXsl\">\n                    <property name=\"title\"><value>CSV</value></property>\n                    <property name=\"xslLink\"><value>/org/sakaiproject/reports/xsl/shared/defaultExport.xsl</value></property>\n                    <property name=\"isExport\"><value>true</value></property>\n                    <property name=\"extension\"><value>csv</value></property>\n                    <property name=\"target\"><value>_self</value></property>\n                    <property name=\"contentType\"><value>application/x-csv</value></property>\n                    <property name=\"resultsPostProcessor\">\n                        <ref bean=\"org.sakaiproject.reports.service.ResultsPostProcessor.csv\"/>\n                    </property>\n                </bean>\n                <bean id=\"exportHTML\" class=\"org.sakaiproject.reports.model.ReportXsl\">\n                    <property name=\"xslLink\"><value>/org/sakaiproject/reports/xsl/usage/sessionReport.xsl</value></property>\n                    <property name=\"title\"><value>HTML</value></property>\n                    <property name=\"isExport\"><value>true</value></property>\n                    <property name=\"contentType\"><value>text/html</value></property>\n                </bean>\n\n            </list>\n           \n        </property>\n\n        <property name=\"defaultXsl\">\n                <bean class=\"org.sakaiproject.reports.model.ReportXsl\">\n                    <property name=\"xslLink\"><value>/org/sakaiproject/reports/xsl/usage/sessionReport.xsl</value></property>\n                    <property name=\"isExport\"><value>false</value></property>\n                </bean>\n        </property>\n\n    </bean>\n    </beans>'),('totalStorageReport-01','<?xml version=\"1.0\" encoding=\"UTF-8\"?>\n<!DOCTYPE beans PUBLIC \"-//SPRING//DTD BEAN//EN\" \"http://www.springframework.org/dtd/spring-beans.dtd\">\n<!--\n	Notes:\n\n	Each report MUST have a different idString.  This is how saved reports are\n	linked back to the report definition\n\n    ALL YOUR BASE ARE BELONG TO US!\n-->\n<beans>\n\n\n    <bean id=\"totalStorageReport\"\n        class=\"org.sakaiproject.reports.model.ReportDefinition\">\n\n        <property name=\"idString\">\n            <value>totalStorageReport-01</value>\n        </property>\n        <property name=\"usesWarehouse\"><value>true</value></property>\n        <property name=\"title\">\n            <value>\n                Current storage in system\n            </value>\n        </property>\n       <property name=\"query\">\n            <list>\n               <value>\n                  <![CDATA[select avg(file_count),  avg(avg_size), avg(avg_space)\n                   from ( select  created_by, avg(content_length/1024) as avg_size from dw_resource group by created_by) avg_size,\n                   ( select  created_by, sum(content_length/2024) as avg_space from dw_resource group by created_by) avg_space,\n                   ( select  created_by, count(*) as file_count  from dw_resource group by created_by) file_count\n                    ]]>\n               </value>\n\n               <value>\n                 <![CDATA[select sub_mime_type \"file_type\", count(*) \"total_files\" ,\n                 avg(content_length/1024) \"avg_size\" , sum(content_length/1024) \"total_size\"\n                 from dw_resource  group by sub_mime_type\n                  ]]>\n               </value>\n               <value>\n                   <![CDATA[select sum(space_available) \"totalAlocatedSpace\"\n                   from dw_resource_collection where parent_collection = \'/\'\n                    ]]>\n               </value>\n            </list>\n        </property>\n        <property name=\"description\">\n            <value>\n                Reports on current storage in system\n            </value>\n        </property>\n        <property name=\"siteType\"><!-- some acceptable values: admin,course,project,cig  -->\n            <value>~admin,!admin, portfolioAdmin</value>\n        </property>\n        <property name=\"role\">\n            <value>maintain,admin, Program Admin</value>\n        </property>\n        <property name=\"reportDefinitionParams\">\n            <list>\n\n            </list>\n        </property>\n\n         <property name=\"xsls\">\n            <list>\n                <bean id=\"currentStorage\" class=\"org.sakaiproject.reports.model.ReportXsl\">\n                    <property name=\"xslLink\"><value>/org/sakaiproject/reports/xsl/usage/currentStorage.xsl</value></property>\n                    <property name=\"title\"><value>Current Storage</value></property>\n                    <property name=\"isExport\"><value>false</value></property>\n                </bean>\n                 <bean id=\"defaultExport\" class=\"org.sakaiproject.reports.model.ReportXsl\">\n                    <property name=\"title\"><value>CSV</value></property>\n                    <property name=\"xslLink\"><value>/org/sakaiproject/reports/xsl/shared/defaultExport.xsl</value></property>\n                    <property name=\"isExport\"><value>true</value></property>\n                    <property name=\"extension\"><value>csv</value></property>\n                    <property name=\"target\"><value>_self</value></property>\n                    <property name=\"contentType\"><value>application/x-csv</value></property>\n                    <property name=\"resultsPostProcessor\">\n                        <ref bean=\"org.sakaiproject.reports.service.ResultsPostProcessor.csv\"/>\n                    </property>\n                </bean>\n                <bean id=\"exportHTML\" class=\"org.sakaiproject.reports.model.ReportXsl\">\n                    <property name=\"xslLink\"><value>/org/sakaiproject/reports/xsl/usage/currentStorage.xsl</value></property>\n                    <property name=\"title\"><value>HTML</value></property>\n                    <property name=\"isExport\"><value>true</value></property>\n                    <property name=\"contentType\"><value>text/html</value></property>\n                </bean>\n            </list>\n\n        </property>\n\n        <property name=\"defaultXsl\">\n                <bean class=\"org.sakaiproject.reports.model.ReportXsl\">\n                    <property name=\"xslLink\"><value>/org/sakaiproject/reports/xsl/usage/currentStorage.xsl</value></property>\n                    <property name=\"isExport\"><value>false</value></property>\n                </bean>\n        </property>\n\n    </bean>\n    </beans>'),('userStorage-01','<?xml version=\"1.0\" encoding=\"UTF-8\"?>\n<!DOCTYPE beans PUBLIC \"-//SPRING//DTD BEAN//EN\" \"http://www.springframework.org/dtd/spring-beans.dtd\">\n<!--\n	Notes:\n\n	Each report MUST have a different idString.  This is how saved reports are\n	linked back to the report definition\n\n    ALL YOUR BASE ARE BELONG TO US!\n-->\n<beans>\n\n\n    <bean id=\"userStorage-01\"\n        class=\"org.sakaiproject.reports.model.ReportDefinition\">\n\n        <property name=\"idString\">\n            <value>userStorage-01</value>\n        </property>\n        <property name=\"usesWarehouse\"><value>true</value></property>\n        <property name=\"title\">\n            <value>\n                User Storage Report\n            </value>\n        </property>\n       <property name=\"query\">\n            <list>\n               <value>\n                  <![CDATA[select dw_users.user_eid,  dw_users.first_name, dw_users.last_name, created_by, work_space_used, site_space_used, (work_space_used +  site_space_used)\n                   FROM (SELECT created_by, space_used as work_space_used  from dw_resource_collection where parent_collection = \'/user/\' )  work_space,\n                   (SELECT sum(space_used) as site_space_used  from dw_resource_collection where parent_collection = \'/group/\' )  site_space,\n                   dw_users\n                   where dw_users.user_id = created_by and ((work_space_used + site_space_used) /1024) > ?\n                   ]]>\n               </value>\n            </list>\n        </property>\n        <property name=\"description\">\n            <value>\n                Allows you to specify size and view users who have used more than that amount of space\n            </value>\n        </property>\n        <property name=\"siteType\"><!-- some acceptable values: admin,course,project,cig  -->\n            <value>~admin,!admin,portfolioAdmin</value>\n        </property>\n        <property name=\"role\">\n            <value>maintain,admin, Program Admin</value>\n        </property>\n         <property name=\"paramTitle\">\n            <value>\n                Find users storing more than:\n            </value>\n        </property>\n        <property name=\"paramInstruction\">\n            <value>\n                Warning! This may be a large report that will require a lengthy download period.\n            </value>\n        </property>\n        <property name=\"reportDefinitionParams\">\n            <list>\n                <bean class=\"org.sakaiproject.reports.model.ReportDefinitionParam\">\n                    <property name=\"title\"><value>MB</value></property>\n                    <property name=\"paramName\"><value>size</value></property>\n                    <property name=\"description\"><value>Finds users storing more than specified amount.  May be large report.</value></property>\n                    <property name=\"type\"><value>int</value></property>\n                                    <!-- int/float/date/string -->\n                    <property name=\"valueType\"><value>fillin</value></property>\n                                    <!-- fillin/set/multiset/sql/multisql/static -->\n                    <property name=\"value\"><value></value></property>\n                           \n                </bean>\n            </list>\n        </property>\n\n        <property name=\"xsls\">\n            <list>\n                <bean id=\"userStorage\" class=\"org.sakaiproject.reports.model.ReportXsl\">\n                    <property name=\"xslLink\"><value>/org/sakaiproject/reports/xsl/usage/userStorage.xsl</value></property>\n                    <property name=\"title\"><value>User Storage</value></property>\n                    <property name=\"isExport\"><value>false</value></property>\n                </bean>\n                 <bean id=\"defaultExport\" class=\"org.sakaiproject.reports.model.ReportXsl\">\n                    <property name=\"title\"><value>CSV</value></property>\n                    <property name=\"xslLink\"><value>/org/sakaiproject/reports/xsl/shared/defaultExport.xsl</value></property>\n                    <property name=\"isExport\"><value>true</value></property>\n                    <property name=\"extension\"><value>csv</value></property>\n                    <property name=\"target\"><value>_self</value></property>\n                    <property name=\"contentType\"><value>application/x-csv</value></property>\n                    <property name=\"resultsPostProcessor\">\n                        <ref bean=\"org.sakaiproject.reports.service.ResultsPostProcessor.csv\"/>\n                    </property>\n                </bean>\n                <bean id=\"exportHTML\" class=\"org.sakaiproject.reports.model.ReportXsl\">\n                    <property name=\"xslLink\"><value>/org/sakaiproject/reports/xsl/usage/userStorage.xsl</value></property>\n                    <property name=\"title\"><value>HTML</value></property>\n                    <property name=\"isExport\"><value>true</value></property>\n                    <property name=\"contentType\"><value>text/html</value></property>\n                </bean>\n            </list>\n\n        </property>\n\n        <property name=\"defaultXsl\">\n                <bean class=\"org.sakaiproject.reports.model.ReportXsl\">\n                    <property name=\"xslLink\"><value>/org/sakaiproject/reports/xsl/usage/userStorage.xsl</value></property>\n                    <property name=\"isExport\"><value>false</value></property>\n                </bean>\n        </property>\n\n    </bean>\n    </beans>'),('userStorageByUserId-01','<?xml version=\"1.0\" encoding=\"UTF-8\"?>\n<!DOCTYPE beans PUBLIC \"-//SPRING//DTD BEAN//EN\" \"http://www.springframework.org/dtd/spring-beans.dtd\">\n<!--\n	Notes:\n\n	Each report MUST have a different idString.  This is how saved reports are\n	linked back to the report definition\n\n    ALL YOUR BASE ARE BELONG TO US!\n-->\n<beans>\n\n\n    <bean id=\"userStorageByUserId-01\"\n        class=\"org.sakaiproject.reports.model.ReportDefinition\">\n\n        <property name=\"idString\">\n            <value>userStorageByUserId-01</value>\n        </property>\n        <property name=\"usesWarehouse\"><value>true</value></property>\n        <property name=\"title\">\n            <value>\n                User Storage Details Report\n            </value>\n        </property>\n       <property name=\"query\">\n            <list>\n                <value>\n                    <![CDATA[\n                 select user_eid, first_name, last_name from dw_users where user_eid = ?\n                    ]]>\n                </value>\n               <value>\n                   <![CDATA[\n                 select sub_mime_type \"file_type\", count(*) \"total_files\" , avg(content_length) \"avg_size\" , sum(content_length) \"total_size\"\n                   from dw_resource where created_by = (select dw_users.user_id from dw_users\n                   where dw_users.user_eid = ? ) and parent_collection  like \'/user/%\'  group by sub_mime_type\n                   ]]>\n               </value>\n                <value>\n                    <![CDATA[\n                  select sub_mime_type \"file_type\", count(*) \"total_files\" , avg(content_length) \"avg_size\" , sum(content_length) \"total_size\"\n                    from dw_resource where created_by = (select dw_users.user_id from dw_users\n                    where dw_users.user_eid = ? ) and parent_collection  like \'/group/%\'  group by sub_mime_type\n                    ]]>\n               </value>\n                <value>\n                    <![CDATA[\n                    select space_available  \"workspaceTotalAllocatedSpace\" from dw_resource_collection\n                    where  created_by=?  and uri= \'/user/\'\n                    ]]>\n                </value>\n                <value>\n                    <![CDATA[\n                    select sum(space_available)  \"siteTotalAllocatedSpace\" from dw_resource_collection\n                    where uri in (select distinct parent_collection from dw_resource  where created_by = ?)\n                    ]]>\n                </value>\n            </list>\n        </property>\n        <property name=\"description\">\n            <value>\n                View space used by specified user id\n            </value>\n        </property>\n        <property name=\"siteType\"><!-- some acceptable values: admin,course,project,cig  -->\n            <value>~admin,!admin,portfolioAdmin</value>\n        </property>\n        <property name=\"role\">\n            <value>maintain,admin, Program Admin</value>\n        </property>\n         <property name=\"paramTitle\">\n            <value>\n                Specify a User ID:\n            </value>\n        </property>\n        \n        <property name=\"reportDefinitionParams\">\n            <list>\n               <bean class=\"org.sakaiproject.reports.model.ReportDefinitionParam\">\n                    <property name=\"title\"><value>User Id</value></property>\n                    <property name=\"paramName\"><value>userId</value></property>\n                    <property name=\"description\"><value>User Id</value></property>\n                    <property name=\"type\"><value>string</value></property>\n                                    <!-- int/float/date/string -->\n                    <property name=\"valueType\"><value>fillin</value></property>\n                                    <!-- fillin/set/multiset/sql/multisql/static -->\n                    <property name=\"value\"><value></value></property>\n\n                </bean>\n            </list>\n        </property>\n\n         <property name=\"xsls\">\n            <list>\n                <bean id=\"userStorageDetails\" class=\"org.sakaiproject.reports.model.ReportXsl\">\n                    <property name=\"xslLink\"><value>/org/sakaiproject/reports/xsl/usage/userStorageDetails.xsl</value></property>\n                    <property name=\"title\"><value>User Storage Details</value></property>\n                    <property name=\"isExport\"><value>false</value></property>\n                </bean>\n                 <bean id=\"defaultExport\" class=\"org.sakaiproject.reports.model.ReportXsl\">\n                    <property name=\"title\"><value>CSV</value></property>\n                    <property name=\"xslLink\"><value>/org/sakaiproject/reports/xsl/shared/defaultExport.xsl</value></property>\n                    <property name=\"isExport\"><value>true</value></property>\n                    <property name=\"extension\"><value>csv</value></property>\n                    <property name=\"target\"><value>_self</value></property>\n                    <property name=\"contentType\"><value>application/x-csv</value></property>\n                    <property name=\"resultsPostProcessor\">\n                        <ref bean=\"org.sakaiproject.reports.service.ResultsPostProcessor.csv\"/>\n                    </property>\n                </bean>\n                <bean id=\"exportHTML\" class=\"org.sakaiproject.reports.model.ReportXsl\">\n                    <property name=\"xslLink\"><value>/org/sakaiproject/reports/xsl/usage/userStorageDetails.xsl</value></property>\n                    <property name=\"title\"><value>HTML</value></property>\n                    <property name=\"isExport\"><value>true</value></property>\n                    <property name=\"contentType\"><value>text/html</value></property>\n                </bean>\n            </list>\n\n        </property>\n\n        <property name=\"defaultXsl\">\n                <bean class=\"org.sakaiproject.reports.model.ReportXsl\">\n                    <property name=\"xslLink\"><value>/org/sakaiproject/reports/xsl/usage/userStorageDetails.xsl</value></property>\n                    <property name=\"isExport\"><value>false</value></property>\n                </bean>\n        </property>\n\n    </bean>\n    </beans>');
/*!40000 ALTER TABLE `reports_def_xml` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `reports_param`
--

DROP TABLE IF EXISTS `reports_param`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `reports_param` (
  `paramId` varchar(36) NOT NULL,
  `reportId` varchar(36) DEFAULT NULL,
  `reportDefParamIdMark` varchar(255) DEFAULT NULL,
  `value` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`paramId`),
  KEY `FKD3B8420DC896C347` (`reportId`),
  CONSTRAINT `FKD3B8420DC896C347` FOREIGN KEY (`reportId`) REFERENCES `reports_report` (`reportId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `reports_param`
--

LOCK TABLES `reports_param` WRITE;
/*!40000 ALTER TABLE `reports_param` DISABLE KEYS */;
/*!40000 ALTER TABLE `reports_param` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `reports_report`
--

DROP TABLE IF EXISTS `reports_report`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `reports_report` (
  `reportId` varchar(36) NOT NULL,
  `reportDefIdMark` varchar(255) DEFAULT NULL,
  `userId` varchar(255) DEFAULT NULL,
  `title` varchar(255) DEFAULT NULL,
  `keywords` varchar(255) DEFAULT NULL,
  `description` varchar(255) DEFAULT NULL,
  `isLive` bit(1) DEFAULT NULL,
  `creationDate` datetime DEFAULT NULL,
  `type` varchar(255) DEFAULT NULL,
  `display` bit(1) DEFAULT NULL,
  PRIMARY KEY (`reportId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `reports_report`
--

LOCK TABLES `reports_report` WRITE;
/*!40000 ALTER TABLE `reports_report` DISABLE KEYS */;
/*!40000 ALTER TABLE `reports_report` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `reports_result`
--

DROP TABLE IF EXISTS `reports_result`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `reports_result` (
  `resultId` varchar(36) NOT NULL,
  `reportId` varchar(36) DEFAULT NULL,
  `userId` varchar(255) DEFAULT NULL,
  `title` varchar(255) DEFAULT NULL,
  `keywords` varchar(255) DEFAULT NULL,
  `description` varchar(255) DEFAULT NULL,
  `creationDate` datetime DEFAULT NULL,
  `xml` mediumtext,
  PRIMARY KEY (`resultId`),
  KEY `FKA6F2CE9DC896C347` (`reportId`),
  CONSTRAINT `FKA6F2CE9DC896C347` FOREIGN KEY (`reportId`) REFERENCES `reports_report` (`reportId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `reports_result`
--

LOCK TABLES `reports_result` WRITE;
/*!40000 ALTER TABLE `reports_result` DISABLE KEYS */;
/*!40000 ALTER TABLE `reports_result` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `rwikicurrentcontent`
--

DROP TABLE IF EXISTS `rwikicurrentcontent`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `rwikicurrentcontent` (
  `id` varchar(36) NOT NULL,
  `rwikiid` varchar(36) NOT NULL,
  `content` mediumtext,
  PRIMARY KEY (`id`),
  KEY `irwikicurrentcontent_rwi` (`rwikiid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `rwikicurrentcontent`
--

LOCK TABLES `rwikicurrentcontent` WRITE;
/*!40000 ALTER TABLE `rwikicurrentcontent` DISABLE KEYS */;
/*!40000 ALTER TABLE `rwikicurrentcontent` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `rwikihistory`
--

DROP TABLE IF EXISTS `rwikihistory`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `rwikihistory` (
  `id` varchar(36) NOT NULL,
  `version` datetime DEFAULT NULL,
  `name` varchar(255) NOT NULL,
  `realm` varchar(255) DEFAULT NULL,
  `referenced` varchar(4000) DEFAULT NULL,
  `userid` varchar(64) DEFAULT NULL,
  `owner` varchar(64) DEFAULT NULL,
  `ownerRead` bit(1) DEFAULT NULL,
  `ownerWrite` bit(1) DEFAULT NULL,
  `ownerAdmin` bit(1) DEFAULT NULL,
  `groupRead` bit(1) DEFAULT NULL,
  `groupWrite` bit(1) DEFAULT NULL,
  `groupAdmin` bit(1) DEFAULT NULL,
  `publicRead` bit(1) DEFAULT NULL,
  `publicWrite` bit(1) DEFAULT NULL,
  `sha1` varchar(64) DEFAULT NULL,
  `revision` int(11) DEFAULT NULL,
  `rwikiobjectid` varchar(36) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `name_idx` (`name`),
  KEY `rwikiobjectid_idx` (`rwikiobjectid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `rwikihistory`
--

LOCK TABLES `rwikihistory` WRITE;
/*!40000 ALTER TABLE `rwikihistory` DISABLE KEYS */;
/*!40000 ALTER TABLE `rwikihistory` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `rwikihistorycontent`
--

DROP TABLE IF EXISTS `rwikihistorycontent`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `rwikihistorycontent` (
  `id` varchar(36) NOT NULL,
  `rwikiid` varchar(36) NOT NULL,
  `content` mediumtext,
  PRIMARY KEY (`id`),
  KEY `irwikihistorycontent_rwi` (`rwikiid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `rwikihistorycontent`
--

LOCK TABLES `rwikihistorycontent` WRITE;
/*!40000 ALTER TABLE `rwikihistorycontent` DISABLE KEYS */;
/*!40000 ALTER TABLE `rwikihistorycontent` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `rwikiobject`
--

DROP TABLE IF EXISTS `rwikiobject`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `rwikiobject` (
  `id` varchar(36) NOT NULL,
  `version` datetime NOT NULL,
  `name` varchar(255) NOT NULL,
  `realm` varchar(255) DEFAULT NULL,
  `referenced` varchar(4000) DEFAULT NULL,
  `userid` varchar(64) DEFAULT NULL,
  `owner` varchar(64) DEFAULT NULL,
  `ownerRead` bit(1) DEFAULT NULL,
  `ownerWrite` bit(1) DEFAULT NULL,
  `ownerAdmin` bit(1) DEFAULT NULL,
  `groupRead` bit(1) DEFAULT NULL,
  `groupWrite` bit(1) DEFAULT NULL,
  `groupAdmin` bit(1) DEFAULT NULL,
  `publicRead` bit(1) DEFAULT NULL,
  `publicWrite` bit(1) DEFAULT NULL,
  `sha1` varchar(64) DEFAULT NULL,
  `revision` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`),
  KEY `irwikiobject_realm` (`realm`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `rwikiobject`
--

LOCK TABLES `rwikiobject` WRITE;
/*!40000 ALTER TABLE `rwikiobject` DISABLE KEYS */;
/*!40000 ALTER TABLE `rwikiobject` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `rwikipagemessage`
--

DROP TABLE IF EXISTS `rwikipagemessage`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `rwikipagemessage` (
  `id` varchar(36) NOT NULL,
  `sessionid` varchar(255) DEFAULT NULL,
  `userid` varchar(64) NOT NULL,
  `pagespace` varchar(255) DEFAULT NULL,
  `pagename` varchar(255) DEFAULT NULL,
  `lastseen` datetime DEFAULT NULL,
  `message` text,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `rwikipagemessage`
--

LOCK TABLES `rwikipagemessage` WRITE;
/*!40000 ALTER TABLE `rwikipagemessage` DISABLE KEYS */;
/*!40000 ALTER TABLE `rwikipagemessage` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `rwikipagepresence`
--

DROP TABLE IF EXISTS `rwikipagepresence`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `rwikipagepresence` (
  `id` varchar(36) NOT NULL,
  `sessionid` varchar(255) DEFAULT NULL,
  `userid` varchar(64) NOT NULL,
  `pagespace` varchar(255) DEFAULT NULL,
  `pagename` varchar(255) DEFAULT NULL,
  `lastseen` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `irwikipagepresence_sid` (`sessionid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `rwikipagepresence`
--

LOCK TABLES `rwikipagepresence` WRITE;
/*!40000 ALTER TABLE `rwikipagepresence` DISABLE KEYS */;
/*!40000 ALTER TABLE `rwikipagepresence` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `rwikipagetrigger`
--

DROP TABLE IF EXISTS `rwikipagetrigger`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `rwikipagetrigger` (
  `id` varchar(36) NOT NULL,
  `userid` varchar(64) NOT NULL,
  `pagespace` varchar(255) DEFAULT NULL,
  `pagename` varchar(255) DEFAULT NULL,
  `lastseen` datetime DEFAULT NULL,
  `triggerspec` text,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `rwikipagetrigger`
--

LOCK TABLES `rwikipagetrigger` WRITE;
/*!40000 ALTER TABLE `rwikipagetrigger` DISABLE KEYS */;
/*!40000 ALTER TABLE `rwikipagetrigger` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `rwikipreference`
--

DROP TABLE IF EXISTS `rwikipreference`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `rwikipreference` (
  `id` varchar(36) NOT NULL,
  `userid` varchar(64) NOT NULL,
  `lastseen` datetime DEFAULT NULL,
  `prefcontext` varchar(255) DEFAULT NULL,
  `preftype` varchar(64) DEFAULT NULL,
  `preference` text,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `rwikipreference`
--

LOCK TABLES `rwikipreference` WRITE;
/*!40000 ALTER TABLE `rwikipreference` DISABLE KEYS */;
/*!40000 ALTER TABLE `rwikipreference` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `rwikiproperties`
--

DROP TABLE IF EXISTS `rwikiproperties`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `rwikiproperties` (
  `id` varchar(36) NOT NULL,
  `name` varchar(255) NOT NULL,
  `value` varchar(4000) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `rwikiproperties`
--

LOCK TABLES `rwikiproperties` WRITE;
/*!40000 ALTER TABLE `rwikiproperties` DISABLE KEYS */;
INSERT INTO `rwikiproperties` VALUES ('402880e536dbfaef0136dbfb7fa20002','schema-version','20051107');
/*!40000 ALTER TABLE `rwikiproperties` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sakai_alias`
--

DROP TABLE IF EXISTS `sakai_alias`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sakai_alias` (
  `ALIAS_ID` varchar(99) NOT NULL,
  `TARGET` varchar(255) DEFAULT NULL,
  `CREATEDBY` varchar(99) NOT NULL,
  `MODIFIEDBY` varchar(99) NOT NULL,
  `CREATEDON` datetime NOT NULL,
  `MODIFIEDON` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`ALIAS_ID`),
  KEY `IE_SAKAI_ALIAS_CREATED` (`CREATEDBY`,`CREATEDON`),
  KEY `IE_SAKAI_ALIAS_MODDED` (`MODIFIEDBY`,`MODIFIEDON`),
  KEY `IE_SAKAI_ALIAS_TARGET` (`TARGET`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sakai_alias`
--

LOCK TABLES `sakai_alias` WRITE;
/*!40000 ALTER TABLE `sakai_alias` DISABLE KEYS */;
/*!40000 ALTER TABLE `sakai_alias` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sakai_alias_property`
--

DROP TABLE IF EXISTS `sakai_alias_property`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sakai_alias_property` (
  `ALIAS_ID` varchar(99) NOT NULL,
  `NAME` varchar(99) NOT NULL,
  `VALUE` longtext,
  PRIMARY KEY (`ALIAS_ID`,`NAME`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sakai_alias_property`
--

LOCK TABLES `sakai_alias_property` WRITE;
/*!40000 ALTER TABLE `sakai_alias_property` DISABLE KEYS */;
/*!40000 ALTER TABLE `sakai_alias_property` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sakai_cluster`
--

DROP TABLE IF EXISTS `sakai_cluster`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sakai_cluster` (
  `SERVER_ID` varchar(64) NOT NULL DEFAULT '',
  `UPDATE_TIME` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`SERVER_ID`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sakai_cluster`
--

LOCK TABLES `sakai_cluster` WRITE;
/*!40000 ALTER TABLE `sakai_cluster` DISABLE KEYS */;
/*!40000 ALTER TABLE `sakai_cluster` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sakai_digest`
--

DROP TABLE IF EXISTS `sakai_digest`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sakai_digest` (
  `DIGEST_ID` varchar(99) NOT NULL,
  `XML` longtext,
  UNIQUE KEY `SAKAI_DIGEST_INDEX` (`DIGEST_ID`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sakai_digest`
--

LOCK TABLES `sakai_digest` WRITE;
/*!40000 ALTER TABLE `sakai_digest` DISABLE KEYS */;
/*!40000 ALTER TABLE `sakai_digest` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sakai_event`
--

DROP TABLE IF EXISTS `sakai_event`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sakai_event` (
  `EVENT_ID` bigint(20) NOT NULL AUTO_INCREMENT,
  `EVENT_DATE` datetime DEFAULT NULL,
  `EVENT` varchar(32) DEFAULT NULL,
  `REF` varchar(255) DEFAULT NULL,
  `CONTEXT` varchar(255) DEFAULT NULL,
  `SESSION_ID` varchar(163) DEFAULT NULL,
  `EVENT_CODE` varchar(1) DEFAULT NULL,
  PRIMARY KEY (`EVENT_ID`),
  KEY `IE_SAKAI_EVENT_SESSION_ID` (`SESSION_ID`)
) ENGINE=MyISAM AUTO_INCREMENT=54 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sakai_event`
--

LOCK TABLES `sakai_event` WRITE;
/*!40000 ALTER TABLE `sakai_event` DISABLE KEYS */;
INSERT INTO `sakai_event` VALUES (1,'2012-04-22 16:35:13','server.start','2.7.0/DEV',NULL,'~localhost~?','a'),(2,'2012-04-22 16:35:34','content.new','/content/group/PortfolioAdmin/','PortfolioAdmin','~localhost~admin','m'),(3,'2012-04-22 16:35:34','content.new','/content/group/PortfolioAdmin/system/','PortfolioAdmin','~localhost~admin','m'),(4,'2012-04-22 16:35:34','content.new','/content/group/PortfolioAdmin/system/formCreate.xslt','PortfolioAdmin','~localhost~admin','m'),(5,'2012-04-22 16:35:34','content.available','/content/group/PortfolioAdmin/system/formCreate.xslt','PortfolioAdmin','~localhost~admin','a'),(6,'2012-04-22 16:35:34','realm.add','/realm//content/group/PortfolioAdmin/system/formCreate.xslt',NULL,'~localhost~admin','m'),(7,'2012-04-22 16:35:34','realm.upd','/realm//content/group/PortfolioAdmin/system/formCreate.xslt',NULL,'~localhost~admin','m'),(8,'2012-04-22 16:35:34','content.new','/content/group/PortfolioAdmin/system/formFieldTemplate.xslt','PortfolioAdmin','~localhost~admin','m'),(9,'2012-04-22 16:35:34','content.available','/content/group/PortfolioAdmin/system/formFieldTemplate.xslt','PortfolioAdmin','~localhost~admin','a'),(10,'2012-04-22 16:35:34','realm.add','/realm//content/group/PortfolioAdmin/system/formFieldTemplate.xslt',NULL,'~localhost~admin','m'),(11,'2012-04-22 16:35:34','realm.upd','/realm//content/group/PortfolioAdmin/system/formFieldTemplate.xslt',NULL,'~localhost~admin','m'),(12,'2012-04-22 16:35:34','content.new','/content/group/PortfolioAdmin/system/formView.xslt','PortfolioAdmin','~localhost~admin','m'),(13,'2012-04-22 16:35:34','content.available','/content/group/PortfolioAdmin/system/formView.xslt','PortfolioAdmin','~localhost~admin','a'),(14,'2012-04-22 16:35:34','realm.add','/realm//content/group/PortfolioAdmin/system/formView.xslt',NULL,'~localhost~admin','m'),(15,'2012-04-22 16:35:34','realm.upd','/realm//content/group/PortfolioAdmin/system/formView.xslt',NULL,'~localhost~admin','m'),(16,'2012-04-22 16:35:35','realm.upd','/realm/!site.template.portfolio',NULL,'~localhost~admin','m'),(17,'2012-04-22 16:35:35','realm.upd','/realm/!group.template.portfolio',NULL,'~localhost~admin','m'),(18,'2012-04-22 16:35:35','realm.upd','/realm/!site.template.portfolioAdmin',NULL,'~localhost~admin','m'),(19,'2012-04-22 16:35:36','content.new','/content/group/PortfolioAdmin/system/freeFormRenderer.xml','PortfolioAdmin','~localhost~admin','m'),(20,'2012-04-22 16:35:36','content.available','/content/group/PortfolioAdmin/system/freeFormRenderer.xml','PortfolioAdmin','~localhost~admin','a'),(21,'2012-04-22 16:35:36','org.theospi.template.add','freeFormTemplate',NULL,'~localhost~admin','m'),(22,'2012-04-22 16:35:36','content.new','/content/group/PortfolioAdmin/system/contentOverText.jpg','PortfolioAdmin','~localhost~admin','m'),(23,'2012-04-22 16:35:36','content.available','/content/group/PortfolioAdmin/system/contentOverText.jpg','PortfolioAdmin','~localhost~admin','a'),(24,'2012-04-22 16:35:36','content.new','/content/group/PortfolioAdmin/system/contentOverText.xml','PortfolioAdmin','~localhost~admin','m'),(25,'2012-04-22 16:35:36','content.available','/content/group/PortfolioAdmin/system/contentOverText.xml','PortfolioAdmin','~localhost~admin','a'),(26,'2012-04-22 16:35:36','content.new','/content/group/PortfolioAdmin/system/2column.jpg','PortfolioAdmin','~localhost~admin','m'),(27,'2012-04-22 16:35:36','content.available','/content/group/PortfolioAdmin/system/2column.jpg','PortfolioAdmin','~localhost~admin','a'),(28,'2012-04-22 16:35:36','content.new','/content/group/PortfolioAdmin/system/twoColumn.xml','PortfolioAdmin','~localhost~admin','m'),(29,'2012-04-22 16:35:36','content.available','/content/group/PortfolioAdmin/system/twoColumn.xml','PortfolioAdmin','~localhost~admin','a'),(30,'2012-04-22 16:35:36','content.new','/content/group/PortfolioAdmin/system/Simplehtml.jpg','PortfolioAdmin','~localhost~admin','m'),(31,'2012-04-22 16:35:36','content.available','/content/group/PortfolioAdmin/system/Simplehtml.jpg','PortfolioAdmin','~localhost~admin','a'),(32,'2012-04-22 16:35:36','content.new','/content/group/PortfolioAdmin/system/simpleRichText.xml','PortfolioAdmin','~localhost~admin','m'),(33,'2012-04-22 16:35:36','content.available','/content/group/PortfolioAdmin/system/simpleRichText.xml','PortfolioAdmin','~localhost~admin','a'),(34,'2012-04-22 16:35:36','content.new','/content/user/admin/','~admin','~localhost~admin','m'),(35,'2012-04-22 16:35:36','realm.add','/realm//site/PortfolioAdmin',NULL,'~localhost~admin','m'),(36,'2012-04-22 16:35:36','realm.upd','/realm//site/PortfolioAdmin',NULL,'~localhost~admin','m'),(37,'2012-04-22 16:35:36','site.add','/site/PortfolioAdmin',NULL,'~localhost~admin','m'),(38,'2012-04-22 16:35:36','site.upd','/site/PortfolioAdmin',NULL,'~localhost~admin','m'),(39,'2012-04-22 16:35:36','site.upd','/site/PortfolioAdmin',NULL,'~localhost~admin','m'),(40,'2012-04-22 16:35:36','site.upd','/site/PortfolioAdmin',NULL,'~localhost~admin','m'),(41,'2012-04-22 16:35:36','site.upd','/site/PortfolioAdmin',NULL,'~localhost~admin','m'),(42,'2012-04-22 16:35:36','site.upd','/site/PortfolioAdmin',NULL,'~localhost~admin','m'),(43,'2012-04-22 16:35:36','site.upd','/site/PortfolioAdmin',NULL,'~localhost~admin','m'),(44,'2012-04-22 16:35:36','site.upd','/site/PortfolioAdmin',NULL,'~localhost~admin','m'),(45,'2012-04-22 16:35:36','site.upd','/site/PortfolioAdmin',NULL,'~localhost~admin','m'),(46,'2012-04-22 16:35:36','site.upd','/site/PortfolioAdmin',NULL,'~localhost~admin','m'),(47,'2012-04-22 16:35:36','site.upd','/site/PortfolioAdmin',NULL,'~localhost~admin','m'),(48,'2012-04-22 16:35:36','site.upd','/site/PortfolioAdmin',NULL,'~localhost~admin','m'),(49,'2012-04-22 16:35:36','site.upd','/site/PortfolioAdmin',NULL,'~localhost~admin','m'),(50,'2012-04-22 16:35:38','realm.add','/realm//site/citationsAdmin',NULL,'~localhost~admin','m'),(51,'2012-04-22 16:35:38','realm.upd','/realm//site/citationsAdmin',NULL,'~localhost~admin','m'),(52,'2012-04-22 16:35:38','site.add','/site/citationsAdmin',NULL,'~localhost~admin','m'),(53,'2012-04-22 16:35:38','site.upd','/site/citationsAdmin',NULL,'~localhost~admin','m');
/*!40000 ALTER TABLE `sakai_event` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sakai_event_delay`
--

DROP TABLE IF EXISTS `sakai_event_delay`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sakai_event_delay` (
  `EVENT_DELAY_ID` bigint(20) NOT NULL AUTO_INCREMENT,
  `EVENT` varchar(32) DEFAULT NULL,
  `REF` varchar(255) DEFAULT NULL,
  `USER_ID` varchar(99) DEFAULT NULL,
  `EVENT_CODE` varchar(1) DEFAULT NULL,
  `PRIORITY` smallint(6) DEFAULT NULL,
  PRIMARY KEY (`EVENT_DELAY_ID`),
  KEY `IE_SAKAI_EVENT_DELAY_RESOURCE` (`REF`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sakai_event_delay`
--

LOCK TABLES `sakai_event_delay` WRITE;
/*!40000 ALTER TABLE `sakai_event_delay` DISABLE KEYS */;
/*!40000 ALTER TABLE `sakai_event_delay` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sakai_locks`
--

DROP TABLE IF EXISTS `sakai_locks`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sakai_locks` (
  `TABLE_NAME` varchar(64) DEFAULT NULL,
  `RECORD_ID` varchar(512) DEFAULT NULL,
  `LOCK_TIME` datetime DEFAULT NULL,
  `USAGE_SESSION_ID` varchar(36) DEFAULT NULL,
  UNIQUE KEY `SAKAI_LOCKS_INDEX` (`TABLE_NAME`,`RECORD_ID`(128))
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sakai_locks`
--

LOCK TABLES `sakai_locks` WRITE;
/*!40000 ALTER TABLE `sakai_locks` DISABLE KEYS */;
/*!40000 ALTER TABLE `sakai_locks` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sakai_notification`
--

DROP TABLE IF EXISTS `sakai_notification`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sakai_notification` (
  `NOTIFICATION_ID` varchar(99) NOT NULL,
  `XML` longtext,
  UNIQUE KEY `SAKAI_NOTIFICATION_INDEX` (`NOTIFICATION_ID`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sakai_notification`
--

LOCK TABLES `sakai_notification` WRITE;
/*!40000 ALTER TABLE `sakai_notification` DISABLE KEYS */;
/*!40000 ALTER TABLE `sakai_notification` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sakai_person_meta_t`
--

DROP TABLE IF EXISTS `sakai_person_meta_t`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sakai_person_meta_t` (
  `ID` bigint(20) NOT NULL AUTO_INCREMENT,
  `USER_UUID` varchar(99) NOT NULL,
  `PROPERTY` varchar(255) NOT NULL,
  `VALUE` varchar(255) NOT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sakai_person_meta_t`
--

LOCK TABLES `sakai_person_meta_t` WRITE;
/*!40000 ALTER TABLE `sakai_person_meta_t` DISABLE KEYS */;
/*!40000 ALTER TABLE `sakai_person_meta_t` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sakai_postem_gradebook`
--

DROP TABLE IF EXISTS `sakai_postem_gradebook`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sakai_postem_gradebook` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `lockId` int(11) NOT NULL,
  `title` varchar(255) NOT NULL,
  `context` varchar(36) NOT NULL,
  `creator` varchar(36) NOT NULL,
  `created` datetime NOT NULL,
  `last_updater` varchar(36) NOT NULL,
  `last_updated` datetime NOT NULL,
  `released` bit(1) NOT NULL,
  `stats` bit(1) NOT NULL,
  `template` varchar(4000) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `title` (`title`,`context`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sakai_postem_gradebook`
--

LOCK TABLES `sakai_postem_gradebook` WRITE;
/*!40000 ALTER TABLE `sakai_postem_gradebook` DISABLE KEYS */;
/*!40000 ALTER TABLE `sakai_postem_gradebook` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sakai_postem_headings`
--

DROP TABLE IF EXISTS `sakai_postem_headings`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sakai_postem_headings` (
  `gradebook_id` bigint(20) NOT NULL,
  `heading` varchar(500) NOT NULL,
  `location` int(11) NOT NULL,
  PRIMARY KEY (`gradebook_id`,`location`),
  KEY `FKF54C1C2E8B6B03CE` (`gradebook_id`),
  CONSTRAINT `FKF54C1C2E8B6B03CE` FOREIGN KEY (`gradebook_id`) REFERENCES `sakai_postem_gradebook` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sakai_postem_headings`
--

LOCK TABLES `sakai_postem_headings` WRITE;
/*!40000 ALTER TABLE `sakai_postem_headings` DISABLE KEYS */;
/*!40000 ALTER TABLE `sakai_postem_headings` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sakai_postem_student`
--

DROP TABLE IF EXISTS `sakai_postem_student`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sakai_postem_student` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `lockId` int(11) NOT NULL,
  `username` varchar(36) NOT NULL,
  `last_checked` datetime DEFAULT NULL,
  `surrogate_key` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FK4FBA80FE56A169CC` (`surrogate_key`),
  CONSTRAINT `FK4FBA80FE56A169CC` FOREIGN KEY (`surrogate_key`) REFERENCES `sakai_postem_gradebook` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sakai_postem_student`
--

LOCK TABLES `sakai_postem_student` WRITE;
/*!40000 ALTER TABLE `sakai_postem_student` DISABLE KEYS */;
/*!40000 ALTER TABLE `sakai_postem_student` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sakai_postem_student_grades`
--

DROP TABLE IF EXISTS `sakai_postem_student_grades`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sakai_postem_student_grades` (
  `student_id` bigint(20) NOT NULL,
  `grade` varchar(2000) DEFAULT NULL,
  `location` int(11) NOT NULL,
  PRIMARY KEY (`student_id`,`location`),
  KEY `FK321A31DDD3321FCA` (`student_id`),
  CONSTRAINT `FK321A31DDD3321FCA` FOREIGN KEY (`student_id`) REFERENCES `sakai_postem_student` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sakai_postem_student_grades`
--

LOCK TABLES `sakai_postem_student_grades` WRITE;
/*!40000 ALTER TABLE `sakai_postem_student_grades` DISABLE KEYS */;
/*!40000 ALTER TABLE `sakai_postem_student_grades` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sakai_preferences`
--

DROP TABLE IF EXISTS `sakai_preferences`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sakai_preferences` (
  `PREFERENCES_ID` varchar(99) NOT NULL,
  `XML` longtext,
  UNIQUE KEY `SAKAI_PREFERENCES_INDEX` (`PREFERENCES_ID`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sakai_preferences`
--

LOCK TABLES `sakai_preferences` WRITE;
/*!40000 ALTER TABLE `sakai_preferences` DISABLE KEYS */;
/*!40000 ALTER TABLE `sakai_preferences` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sakai_presence`
--

DROP TABLE IF EXISTS `sakai_presence`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sakai_presence` (
  `SESSION_ID` varchar(36) DEFAULT NULL,
  `LOCATION_ID` varchar(255) DEFAULT NULL,
  KEY `SAKAI_PRESENCE_SESSION_INDEX` (`SESSION_ID`),
  KEY `SAKAI_PRESENCE_LOCATION_INDEX` (`LOCATION_ID`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sakai_presence`
--

LOCK TABLES `sakai_presence` WRITE;
/*!40000 ALTER TABLE `sakai_presence` DISABLE KEYS */;
/*!40000 ALTER TABLE `sakai_presence` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sakai_privacy_record`
--

DROP TABLE IF EXISTS `sakai_privacy_record`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sakai_privacy_record` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `lockId` int(11) NOT NULL,
  `contextId` varchar(100) NOT NULL,
  `recordType` varchar(100) NOT NULL,
  `userId` varchar(100) NOT NULL,
  `viewable` bit(1) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `contextId` (`contextId`,`recordType`,`userId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sakai_privacy_record`
--

LOCK TABLES `sakai_privacy_record` WRITE;
/*!40000 ALTER TABLE `sakai_privacy_record` DISABLE KEYS */;
/*!40000 ALTER TABLE `sakai_privacy_record` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sakai_realm`
--

DROP TABLE IF EXISTS `sakai_realm`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sakai_realm` (
  `REALM_KEY` int(11) NOT NULL AUTO_INCREMENT,
  `REALM_ID` varchar(255) NOT NULL,
  `PROVIDER_ID` varchar(1024) DEFAULT NULL,
  `MAINTAIN_ROLE` int(11) DEFAULT NULL,
  `CREATEDBY` varchar(99) DEFAULT NULL,
  `MODIFIEDBY` varchar(99) DEFAULT NULL,
  `CREATEDON` datetime DEFAULT NULL,
  `MODIFIEDON` datetime DEFAULT NULL,
  PRIMARY KEY (`REALM_KEY`),
  UNIQUE KEY `AK_SAKAI_REALM_ID` (`REALM_ID`),
  KEY `IE_SAKAI_REALM_CREATED` (`CREATEDBY`,`CREATEDON`),
  KEY `IE_SAKAI_REALM_MODDED` (`MODIFIEDBY`,`MODIFIEDON`),
  KEY `MAINTAIN_ROLE` (`MAINTAIN_ROLE`)
) ENGINE=MyISAM AUTO_INCREMENT=32 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sakai_realm`
--

LOCK TABLES `sakai_realm` WRITE;
/*!40000 ALTER TABLE `sakai_realm` DISABLE KEYS */;
INSERT INTO `sakai_realm` VALUES (1,'!site.helper','',NULL,'admin','admin','2012-04-22 16:35:13','2012-04-22 16:35:13'),(2,'!site.user','',NULL,'admin','admin','2012-04-22 16:35:13','2012-04-22 16:35:13'),(3,'!user.template','',NULL,'admin','admin','2012-04-22 16:35:13','2012-04-22 16:35:13'),(4,'!user.template.guest','',NULL,'admin','admin','2012-04-22 16:35:13','2012-04-22 16:35:13'),(5,'!user.template.maintain','',NULL,'admin','admin','2012-04-22 16:35:13','2012-04-22 16:35:13'),(6,'!user.template.registered','',NULL,'admin','admin','2012-04-22 16:35:13','2012-04-22 16:35:13'),(7,'!user.template.sample','',NULL,'admin','admin','2012-04-22 16:35:13','2012-04-22 16:35:13'),(8,'!site.template','',9,'admin','admin','2012-04-22 16:35:13','2012-04-22 16:35:13'),(9,'!site.template.course','',8,'admin','admin','2012-04-22 16:35:14','2012-04-22 16:35:14'),(10,'!site.template.portfolio',NULL,5,'admin','admin','2012-04-22 16:35:14','2012-04-22 16:35:35'),(11,'!site.template.portfolioAdmin',NULL,10,'admin','admin','2012-04-22 16:35:14','2012-04-22 16:35:35'),(12,'!group.template','',NULL,'admin','admin','2012-04-22 16:35:14','2012-04-22 16:35:14'),(13,'!group.template.course','',8,'admin','admin','2012-04-22 16:35:14','2012-04-22 16:35:14'),(14,'!group.template.portfolio',NULL,5,'admin','admin','2012-04-22 16:35:15','2012-04-22 16:35:35'),(15,'/content/public/','',NULL,'admin','admin','2012-04-22 16:35:15','2012-04-22 16:35:15'),(16,'/content/attachment/','',NULL,'admin','admin','2012-04-22 16:35:15','2012-04-22 16:35:15'),(17,'/announcement/channel/!site/motd','',NULL,'admin','admin','2012-04-22 16:35:15','2012-04-22 16:35:15'),(18,'!pubview','',NULL,'admin','admin','2012-04-22 16:35:15','2012-04-22 16:35:15'),(19,'/site/!gateway','',NULL,'admin','admin','2012-04-22 16:35:15','2012-04-22 16:35:15'),(20,'/site/!error','',NULL,'admin','admin','2012-04-22 16:35:15','2012-04-22 16:35:15'),(21,'/site/!urlError','',NULL,'admin','admin','2012-04-22 16:35:15','2012-04-22 16:35:15'),(22,'/site/mercury','',NULL,'admin','admin','2012-04-22 16:35:15','2012-04-22 16:35:15'),(23,'/site/!admin','',4,'admin','admin','2012-04-22 16:35:15','2012-04-22 16:35:15'),(24,'!matrix.template.portfolio','',NULL,'admin','admin','2012-04-22 16:35:15','2012-04-22 16:35:15'),(25,'!matrix.template.course','',NULL,'admin','admin','2012-04-22 16:35:15','2012-04-22 16:35:15'),(26,'!matrix.template.project','',NULL,'admin','admin','2012-04-22 16:35:15','2012-04-22 16:35:15'),(27,'/content/group/PortfolioAdmin/system/formCreate.xslt',NULL,NULL,'admin','admin','2012-04-22 16:35:34','2012-04-22 16:35:34'),(28,'/content/group/PortfolioAdmin/system/formFieldTemplate.xslt',NULL,NULL,'admin','admin','2012-04-22 16:35:34','2012-04-22 16:35:34'),(29,'/content/group/PortfolioAdmin/system/formView.xslt',NULL,NULL,'admin','admin','2012-04-22 16:35:34','2012-04-22 16:35:34'),(30,'/site/PortfolioAdmin',NULL,10,'admin','admin','2012-04-22 16:35:36','2012-04-22 16:35:36'),(31,'/site/citationsAdmin',NULL,9,'admin','admin','2012-04-22 16:35:38','2012-04-22 16:35:38');
/*!40000 ALTER TABLE `sakai_realm` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sakai_realm_function`
--

DROP TABLE IF EXISTS `sakai_realm_function`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sakai_realm_function` (
  `FUNCTION_KEY` int(11) NOT NULL AUTO_INCREMENT,
  `FUNCTION_NAME` varchar(99) NOT NULL,
  PRIMARY KEY (`FUNCTION_KEY`),
  UNIQUE KEY `IE_SAKAI_REALM_FUNCTION_NAME` (`FUNCTION_NAME`),
  KEY `SAKAI_REALM_FUNCTION_KN` (`FUNCTION_KEY`,`FUNCTION_NAME`)
) ENGINE=MyISAM AUTO_INCREMENT=181 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sakai_realm_function`
--

LOCK TABLES `sakai_realm_function` WRITE;
/*!40000 ALTER TABLE `sakai_realm_function` DISABLE KEYS */;
INSERT INTO `sakai_realm_function` VALUES (1,'annc.all.groups'),(2,'annc.delete.any'),(3,'annc.delete.own'),(4,'annc.new'),(5,'annc.read'),(6,'annc.read.drafts'),(7,'annc.revise.any'),(8,'annc.revise.own'),(9,'asn.delete'),(10,'asn.grade'),(11,'asn.new'),(12,'asn.read'),(13,'asn.revise'),(14,'asn.submit'),(15,'asn.all.groups'),(16,'assessment.createAssessment'),(17,'assessment.deleteAssessment.any'),(18,'assessment.deleteAssessment.own'),(19,'assessment.editAssessment.any'),(20,'assessment.editAssessment.own'),(21,'assessment.gradeAssessment.any'),(22,'assessment.gradeAssessment.own'),(23,'assessment.publishAssessment.any'),(24,'assessment.publishAssessment.own'),(25,'assessment.questionpool.copy.own'),(26,'assessment.questionpool.create'),(27,'assessment.questionpool.delete.own'),(28,'assessment.questionpool.edit.own'),(29,'assessment.submitAssessmentForGrade'),(30,'assessment.takeAssessment'),(31,'assessment.template.create'),(32,'assessment.template.delete.own'),(33,'assessment.template.edit.own'),(34,'calendar.delete.any'),(35,'calendar.delete.own'),(36,'calendar.new'),(37,'calendar.read'),(38,'calendar.revise.any'),(39,'calendar.revise.own'),(40,'calendar.all.groups'),(41,'chat.delete.any'),(42,'chat.delete.own'),(43,'chat.delete.channel'),(44,'chat.new'),(45,'chat.new.channel'),(46,'chat.read'),(47,'chat.revise.channel'),(48,'content.delete.any'),(49,'content.delete.own'),(50,'content.new'),(51,'content.read'),(52,'content.revise.any'),(53,'content.revise.own'),(54,'content.all.groups'),(55,'content.hidden'),(56,'disc.delete.any'),(57,'disc.delete.own'),(58,'disc.new'),(59,'disc.new.topic'),(60,'disc.read'),(61,'disc.revise.any'),(62,'disc.revise.own'),(63,'dropbox.own'),(64,'dropbox.maintain'),(65,'gradebook.editAssignments'),(66,'gradebook.gradeAll'),(67,'gradebook.gradeSection'),(68,'gradebook.viewOwnGrades'),(69,'mail.delete.any'),(70,'mail.new'),(71,'mail.read'),(72,'msg.emailout'),(73,'metaobj.create'),(74,'metaobj.edit'),(75,'metaobj.export'),(76,'metaobj.delete'),(77,'metaobj.publish'),(78,'metaobj.suggest.global.publish'),(79,'prefs.add'),(80,'prefs.del'),(81,'prefs.upd'),(82,'realm.add'),(83,'realm.del'),(84,'realm.upd'),(85,'reports.view'),(86,'reports.run'),(87,'reports.create'),(88,'reports.edit'),(89,'reports.delete'),(90,'reports.share'),(91,'roster.export'),(92,'roster.viewallmembers'),(93,'roster.viewhidden'),(94,'roster.viewofficialphoto'),(95,'roster.viewenrollmentstatus'),(96,'roster.viewprofile'),(97,'roster.viewgroup'),(98,'realm.upd.own'),(99,'section.role.instructor'),(100,'section.role.student'),(101,'section.role.ta'),(102,'site.add'),(103,'site.add.course'),(104,'site.add.usersite'),(105,'site.del'),(106,'site.upd'),(107,'site.upd.site.mbrshp'),(108,'site.upd.grp.mbrshp'),(109,'site.viewRoster'),(110,'site.visit'),(111,'site.visit.unp'),(112,'user.add'),(113,'user.upd.own'),(114,'rwiki.admin'),(115,'rwiki.create'),(116,'rwiki.delete'),(117,'rwiki.read'),(118,'rwiki.superadmin'),(119,'rwiki.update'),(120,'mailtool.admin'),(121,'mailtool.send'),(122,'poll.add'),(123,'poll.deleteAny'),(124,'poll.deleteOwn'),(125,'poll.editAny'),(126,'poll.editOwn'),(127,'poll.vote'),(128,'osp.style.globalPublish'),(129,'osp.style.publish'),(130,'osp.style.delete'),(131,'osp.style.create'),(132,'osp.style.edit'),(133,'osp.style.suggestGlobalPublish'),(134,'osp.help.glossary.delete'),(135,'osp.help.glossary.add'),(136,'osp.help.glossary.edit'),(137,'osp.help.glossary.export'),(138,'osp.matrix.scaffolding.create'),(139,'osp.matrix.scaffolding.revise.any'),(140,'osp.matrix.scaffolding.revise.own'),(141,'osp.matrix.scaffolding.delete.any'),(142,'osp.matrix.scaffolding.delete.own'),(143,'osp.matrix.scaffolding.publish.any'),(144,'osp.matrix.scaffolding.publish.own'),(145,'osp.matrix.scaffolding.export.any'),(146,'osp.matrix.scaffolding.export.own'),(147,'osp.matrix.scaffoldingSpecific.accessAll'),(148,'osp.matrix.scaffoldingSpecific.viewEvalOther'),(149,'osp.matrix.scaffoldingSpecific.viewFeedbackOther'),(150,'osp.matrix.scaffoldingSpecific.manageStatus'),(151,'osp.matrix.scaffoldingSpecific.accessUserList'),(152,'osp.matrix.scaffoldingSpecific.viewAllGroups'),(153,'osp.matrix.scaffoldingSpecific.use'),(154,'osp.matrix.viewOwner'),(155,'osp.portfolio.evaluation.use'),(156,'osp.presentation.create'),(157,'osp.presentation.edit'),(158,'osp.presentation.delete'),(159,'osp.presentation.copy'),(160,'osp.presentation.comment'),(161,'osp.presentation.review'),(162,'osp.presentation.template.copy'),(163,'osp.presentation.template.publish'),(164,'osp.presentation.template.delete'),(165,'osp.presentation.template.create'),(166,'osp.presentation.template.edit'),(167,'osp.presentation.template.export'),(168,'osp.presentation.layout.publish'),(169,'osp.presentation.layout.delete'),(170,'osp.presentation.layout.create'),(171,'osp.presentation.layout.edit'),(172,'osp.presentation.layout.suggestPublish'),(173,'osp.wizard.publish'),(174,'osp.wizard.delete'),(175,'osp.wizard.create'),(176,'osp.wizard.edit'),(177,'osp.wizard.review'),(178,'osp.wizard.export'),(179,'osp.wizard.view'),(180,'osp.wizard.evaluate');
/*!40000 ALTER TABLE `sakai_realm_function` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sakai_realm_property`
--

DROP TABLE IF EXISTS `sakai_realm_property`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sakai_realm_property` (
  `REALM_KEY` int(11) NOT NULL,
  `NAME` varchar(99) NOT NULL,
  `VALUE` mediumtext,
  PRIMARY KEY (`REALM_KEY`,`NAME`),
  KEY `FK_SAKAI_REALM_PROPERTY` (`REALM_KEY`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sakai_realm_property`
--

LOCK TABLES `sakai_realm_property` WRITE;
/*!40000 ALTER TABLE `sakai_realm_property` DISABLE KEYS */;
/*!40000 ALTER TABLE `sakai_realm_property` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sakai_realm_provider`
--

DROP TABLE IF EXISTS `sakai_realm_provider`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sakai_realm_provider` (
  `REALM_KEY` int(11) NOT NULL,
  `PROVIDER_ID` varchar(200) NOT NULL,
  PRIMARY KEY (`REALM_KEY`,`PROVIDER_ID`),
  KEY `FK_SAKAI_REALM_PROVIDER` (`REALM_KEY`),
  KEY `IE_SAKAI_REALM_PROVIDER_ID` (`PROVIDER_ID`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sakai_realm_provider`
--

LOCK TABLES `sakai_realm_provider` WRITE;
/*!40000 ALTER TABLE `sakai_realm_provider` DISABLE KEYS */;
/*!40000 ALTER TABLE `sakai_realm_provider` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sakai_realm_rl_fn`
--

DROP TABLE IF EXISTS `sakai_realm_rl_fn`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sakai_realm_rl_fn` (
  `REALM_KEY` int(11) NOT NULL,
  `ROLE_KEY` int(11) NOT NULL,
  `FUNCTION_KEY` int(11) NOT NULL,
  PRIMARY KEY (`REALM_KEY`,`ROLE_KEY`,`FUNCTION_KEY`),
  KEY `FK_SAKAI_REALM_RL_FN_REALM` (`REALM_KEY`),
  KEY `FK_SAKAI_REALM_RL_FN_FUNC` (`FUNCTION_KEY`),
  KEY `FJ_SAKAI_REALM_RL_FN_ROLE` (`ROLE_KEY`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sakai_realm_rl_fn`
--

LOCK TABLES `sakai_realm_rl_fn` WRITE;
/*!40000 ALTER TABLE `sakai_realm_rl_fn` DISABLE KEYS */;
INSERT INTO `sakai_realm_rl_fn` VALUES (1,9,83),(1,9,84),(2,3,5),(2,3,37),(2,3,44),(2,3,46),(2,3,51),(2,3,58),(2,3,60),(2,3,62),(2,3,68),(2,3,71),(2,3,110),(2,3,115),(2,3,117),(2,3,119),(2,3,121),(2,9,2),(2,9,3),(2,9,4),(2,9,5),(2,9,6),(2,9,7),(2,9,8),(2,9,34),(2,9,35),(2,9,36),(2,9,37),(2,9,38),(2,9,39),(2,9,41),(2,9,42),(2,9,43),(2,9,44),(2,9,45),(2,9,46),(2,9,47),(2,9,48),(2,9,49),(2,9,50),(2,9,51),(2,9,52),(2,9,53),(2,9,55),(2,9,56),(2,9,57),(2,9,58),(2,9,59),(2,9,60),(2,9,61),(2,9,62),(2,9,64),(2,9,65),(2,9,66),(2,9,69),(2,9,70),(2,9,71),(2,9,83),(2,9,84),(2,9,106),(2,9,107),(2,9,108),(2,9,109),(2,9,110),(2,9,111),(2,9,114),(2,9,115),(2,9,117),(2,9,119),(2,9,120),(2,9,121),(3,1,112),(3,2,79),(3,2,80),(3,2,81),(3,2,82),(3,2,98),(3,2,104),(3,2,112),(3,2,113),(4,1,112),(4,2,79),(4,2,80),(4,2,81),(4,2,82),(4,2,98),(4,2,104),(4,2,112),(4,2,113),(5,1,112),(5,2,79),(5,2,80),(5,2,81),(5,2,82),(5,2,98),(5,2,102),(5,2,103),(5,2,104),(5,2,112),(5,2,113),(6,1,112),(6,2,79),(6,2,80),(6,2,81),(6,2,82),(6,2,98),(6,2,102),(6,2,103),(6,2,104),(6,2,112),(6,2,113),(7,1,112),(7,2,79),(7,2,80),(7,2,81),(7,2,82),(7,2,98),(7,2,102),(7,2,103),(7,2,104),(7,2,112),(7,2,113),(8,3,5),(8,3,12),(8,3,14),(8,3,29),(8,3,30),(8,3,37),(8,3,44),(8,3,46),(8,3,51),(8,3,58),(8,3,60),(8,3,62),(8,3,63),(8,3,68),(8,3,71),(8,3,91),(8,3,92),(8,3,96),(8,3,100),(8,3,110),(8,3,115),(8,3,117),(8,3,119),(8,3,121),(8,3,127),(8,3,131),(8,3,156),(8,3,159),(8,3,160),(8,3,169),(8,3,170),(8,3,171),(8,3,179),(8,9,1),(8,9,2),(8,9,3),(8,9,4),(8,9,5),(8,9,6),(8,9,7),(8,9,8),(8,9,9),(8,9,10),(8,9,11),(8,9,12),(8,9,13),(8,9,14),(8,9,15),(8,9,16),(8,9,17),(8,9,18),(8,9,19),(8,9,20),(8,9,21),(8,9,22),(8,9,23),(8,9,24),(8,9,25),(8,9,26),(8,9,27),(8,9,28),(8,9,31),(8,9,32),(8,9,33),(8,9,34),(8,9,35),(8,9,36),(8,9,37),(8,9,38),(8,9,39),(8,9,40),(8,9,41),(8,9,42),(8,9,43),(8,9,44),(8,9,45),(8,9,46),(8,9,47),(8,9,48),(8,9,49),(8,9,50),(8,9,51),(8,9,52),(8,9,53),(8,9,54),(8,9,55),(8,9,56),(8,9,57),(8,9,58),(8,9,59),(8,9,60),(8,9,61),(8,9,62),(8,9,64),(8,9,65),(8,9,66),(8,9,69),(8,9,70),(8,9,71),(8,9,72),(8,9,73),(8,9,74),(8,9,76),(8,9,77),(8,9,78),(8,9,83),(8,9,84),(8,9,85),(8,9,86),(8,9,87),(8,9,88),(8,9,89),(8,9,90),(8,9,91),(8,9,92),(8,9,96),(8,9,97),(8,9,99),(8,9,105),(8,9,106),(8,9,107),(8,9,108),(8,9,109),(8,9,110),(8,9,111),(8,9,114),(8,9,115),(8,9,117),(8,9,119),(8,9,120),(8,9,121),(8,9,122),(8,9,123),(8,9,124),(8,9,125),(8,9,126),(8,9,127),(8,9,128),(8,9,129),(8,9,130),(8,9,131),(8,9,132),(8,9,133),(8,9,134),(8,9,135),(8,9,136),(8,9,137),(8,9,138),(8,9,139),(8,9,140),(8,9,141),(8,9,142),(8,9,143),(8,9,144),(8,9,145),(8,9,146),(8,9,154),(8,9,155),(8,9,156),(8,9,157),(8,9,158),(8,9,159),(8,9,160),(8,9,162),(8,9,163),(8,9,164),(8,9,165),(8,9,166),(8,9,167),(8,9,168),(8,9,169),(8,9,170),(8,9,171),(8,9,172),(8,9,173),(8,9,174),(8,9,175),(8,9,176),(8,9,177),(8,9,178),(9,8,1),(9,8,2),(9,8,3),(9,8,4),(9,8,5),(9,8,6),(9,8,7),(9,8,8),(9,8,9),(9,8,10),(9,8,11),(9,8,12),(9,8,13),(9,8,14),(9,8,15),(9,8,16),(9,8,17),(9,8,18),(9,8,19),(9,8,20),(9,8,21),(9,8,22),(9,8,23),(9,8,24),(9,8,25),(9,8,26),(9,8,27),(9,8,28),(9,8,31),(9,8,32),(9,8,33),(9,8,34),(9,8,35),(9,8,36),(9,8,37),(9,8,38),(9,8,39),(9,8,40),(9,8,41),(9,8,42),(9,8,43),(9,8,44),(9,8,45),(9,8,46),(9,8,47),(9,8,48),(9,8,49),(9,8,50),(9,8,51),(9,8,52),(9,8,53),(9,8,54),(9,8,55),(9,8,56),(9,8,57),(9,8,58),(9,8,59),(9,8,60),(9,8,61),(9,8,62),(9,8,64),(9,8,65),(9,8,66),(9,8,69),(9,8,70),(9,8,71),(9,8,72),(9,8,73),(9,8,74),(9,8,76),(9,8,77),(9,8,78),(9,8,83),(9,8,84),(9,8,85),(9,8,86),(9,8,87),(9,8,88),(9,8,89),(9,8,90),(9,8,91),(9,8,92),(9,8,93),(9,8,94),(9,8,95),(9,8,96),(9,8,97),(9,8,99),(9,8,105),(9,8,106),(9,8,107),(9,8,108),(9,8,109),(9,8,110),(9,8,111),(9,8,114),(9,8,115),(9,8,117),(9,8,119),(9,8,120),(9,8,121),(9,8,122),(9,8,123),(9,8,124),(9,8,125),(9,8,126),(9,8,127),(9,8,128),(9,8,129),(9,8,130),(9,8,131),(9,8,132),(9,8,133),(9,8,134),(9,8,135),(9,8,136),(9,8,137),(9,8,138),(9,8,139),(9,8,140),(9,8,141),(9,8,142),(9,8,143),(9,8,144),(9,8,145),(9,8,146),(9,8,154),(9,8,155),(9,8,156),(9,8,157),(9,8,158),(9,8,159),(9,8,160),(9,8,162),(9,8,163),(9,8,164),(9,8,165),(9,8,166),(9,8,167),(9,8,168),(9,8,169),(9,8,170),(9,8,171),(9,8,172),(9,8,173),(9,8,174),(9,8,175),(9,8,176),(9,8,177),(9,8,178),(9,14,5),(9,14,12),(9,14,14),(9,14,29),(9,14,30),(9,14,37),(9,14,44),(9,14,46),(9,14,51),(9,14,58),(9,14,60),(9,14,62),(9,14,63),(9,14,68),(9,14,71),(9,14,96),(9,14,100),(9,14,110),(9,14,117),(9,14,121),(9,14,127),(9,14,131),(9,14,156),(9,14,159),(9,14,160),(9,14,169),(9,14,170),(9,14,171),(9,14,179),(9,15,5),(9,15,12),(9,15,21),(9,15,22),(9,15,37),(9,15,44),(9,15,46),(9,15,51),(9,15,55),(9,15,58),(9,15,60),(9,15,62),(9,15,63),(9,15,67),(9,15,68),(9,15,71),(9,15,85),(9,15,86),(9,15,90),(9,15,91),(9,15,93),(9,15,94),(9,15,96),(9,15,101),(9,15,108),(9,15,110),(9,15,115),(9,15,117),(9,15,119),(9,15,120),(9,15,121),(9,15,127),(9,15,131),(9,15,156),(9,15,159),(9,15,160),(9,15,169),(9,15,170),(9,15,171),(9,15,179),(10,5,1),(10,5,2),(10,5,3),(10,5,4),(10,5,5),(10,5,6),(10,5,7),(10,5,8),(10,5,9),(10,5,10),(10,5,11),(10,5,12),(10,5,13),(10,5,14),(10,5,15),(10,5,16),(10,5,17),(10,5,18),(10,5,19),(10,5,20),(10,5,21),(10,5,22),(10,5,23),(10,5,24),(10,5,25),(10,5,26),(10,5,27),(10,5,28),(10,5,31),(10,5,32),(10,5,33),(10,5,34),(10,5,35),(10,5,36),(10,5,37),(10,5,38),(10,5,39),(10,5,41),(10,5,42),(10,5,44),(10,5,46),(10,5,48),(10,5,49),(10,5,50),(10,5,51),(10,5,52),(10,5,53),(10,5,54),(10,5,55),(10,5,56),(10,5,57),(10,5,58),(10,5,59),(10,5,60),(10,5,61),(10,5,62),(10,5,64),(10,5,69),(10,5,70),(10,5,71),(10,5,72),(10,5,73),(10,5,74),(10,5,75),(10,5,76),(10,5,77),(10,5,78),(10,5,83),(10,5,84),(10,5,85),(10,5,86),(10,5,87),(10,5,88),(10,5,89),(10,5,90),(10,5,91),(10,5,92),(10,5,93),(10,5,94),(10,5,95),(10,5,96),(10,5,97),(10,5,99),(10,5,105),(10,5,106),(10,5,107),(10,5,108),(10,5,109),(10,5,110),(10,5,111),(10,5,114),(10,5,115),(10,5,117),(10,5,119),(10,5,128),(10,5,129),(10,5,130),(10,5,131),(10,5,132),(10,5,133),(10,5,134),(10,5,135),(10,5,136),(10,5,137),(10,5,138),(10,5,139),(10,5,140),(10,5,141),(10,5,142),(10,5,143),(10,5,144),(10,5,145),(10,5,146),(10,5,154),(10,5,155),(10,5,156),(10,5,157),(10,5,158),(10,5,159),(10,5,160),(10,5,162),(10,5,163),(10,5,164),(10,5,165),(10,5,166),(10,5,167),(10,5,168),(10,5,169),(10,5,170),(10,5,171),(10,5,172),(10,5,173),(10,5,174),(10,5,175),(10,5,176),(10,5,177),(10,5,178),(10,6,5),(10,6,12),(10,6,14),(10,6,29),(10,6,30),(10,6,37),(10,6,44),(10,6,46),(10,6,51),(10,6,58),(10,6,60),(10,6,62),(10,6,63),(10,6,71),(10,6,96),(10,6,100),(10,6,110),(10,6,115),(10,6,117),(10,6,119),(10,6,131),(10,6,156),(10,6,159),(10,6,160),(10,6,169),(10,6,170),(10,6,171),(10,6,179),(10,7,5),(10,7,12),(10,7,14),(10,7,29),(10,7,30),(10,7,37),(10,7,44),(10,7,46),(10,7,51),(10,7,58),(10,7,60),(10,7,62),(10,7,63),(10,7,71),(10,7,85),(10,7,86),(10,7,91),(10,7,93),(10,7,94),(10,7,96),(10,7,100),(10,7,110),(10,7,115),(10,7,117),(10,7,119),(10,7,154),(10,7,155),(10,7,159),(10,7,160),(10,7,180),(10,13,5),(10,13,12),(10,13,14),(10,13,29),(10,13,30),(10,13,37),(10,13,44),(10,13,46),(10,13,51),(10,13,58),(10,13,60),(10,13,62),(10,13,63),(10,13,71),(10,13,85),(10,13,86),(10,13,91),(10,13,93),(10,13,94),(10,13,96),(10,13,100),(10,13,110),(10,13,115),(10,13,117),(10,13,119),(10,13,159),(10,13,160),(10,13,177),(11,10,1),(11,10,2),(11,10,3),(11,10,4),(11,10,5),(11,10,6),(11,10,7),(11,10,8),(11,10,9),(11,10,10),(11,10,11),(11,10,12),(11,10,13),(11,10,14),(11,10,15),(11,10,16),(11,10,17),(11,10,18),(11,10,19),(11,10,20),(11,10,21),(11,10,22),(11,10,23),(11,10,24),(11,10,25),(11,10,26),(11,10,27),(11,10,28),(11,10,31),(11,10,32),(11,10,33),(11,10,34),(11,10,35),(11,10,36),(11,10,37),(11,10,38),(11,10,39),(11,10,41),(11,10,42),(11,10,44),(11,10,46),(11,10,48),(11,10,49),(11,10,50),(11,10,51),(11,10,52),(11,10,53),(11,10,56),(11,10,57),(11,10,58),(11,10,59),(11,10,60),(11,10,61),(11,10,62),(11,10,64),(11,10,69),(11,10,70),(11,10,71),(11,10,72),(11,10,73),(11,10,74),(11,10,75),(11,10,76),(11,10,77),(11,10,78),(11,10,83),(11,10,84),(11,10,99),(11,10,105),(11,10,106),(11,10,107),(11,10,108),(11,10,109),(11,10,110),(11,10,111),(11,10,114),(11,10,115),(11,10,117),(11,10,119),(11,10,128),(11,10,129),(11,10,130),(11,10,131),(11,10,132),(11,10,133),(11,10,134),(11,10,135),(11,10,136),(11,10,137),(11,10,138),(11,10,139),(11,10,140),(11,10,141),(11,10,142),(11,10,143),(11,10,144),(11,10,145),(11,10,146),(11,10,154),(11,10,155),(11,10,156),(11,10,157),(11,10,158),(11,10,159),(11,10,160),(11,10,162),(11,10,163),(11,10,164),(11,10,165),(11,10,166),(11,10,167),(11,10,168),(11,10,169),(11,10,170),(11,10,171),(11,10,172),(11,10,173),(11,10,174),(11,10,175),(11,10,176),(11,10,177),(11,10,178),(11,11,1),(11,11,2),(11,11,3),(11,11,4),(11,11,5),(11,11,6),(11,11,7),(11,11,8),(11,11,9),(11,11,10),(11,11,11),(11,11,12),(11,11,13),(11,11,14),(11,11,15),(11,11,16),(11,11,17),(11,11,18),(11,11,19),(11,11,20),(11,11,21),(11,11,22),(11,11,23),(11,11,24),(11,11,25),(11,11,26),(11,11,27),(11,11,28),(11,11,31),(11,11,32),(11,11,33),(11,11,34),(11,11,35),(11,11,36),(11,11,37),(11,11,38),(11,11,39),(11,11,41),(11,11,42),(11,11,44),(11,11,46),(11,11,48),(11,11,49),(11,11,50),(11,11,51),(11,11,52),(11,11,53),(11,11,56),(11,11,57),(11,11,58),(11,11,59),(11,11,60),(11,11,61),(11,11,62),(11,11,64),(11,11,69),(11,11,70),(11,11,71),(11,11,72),(11,11,73),(11,11,74),(11,11,75),(11,11,76),(11,11,77),(11,11,78),(11,11,83),(11,11,84),(11,11,99),(11,11,105),(11,11,106),(11,11,107),(11,11,108),(11,11,109),(11,11,110),(11,11,111),(11,11,114),(11,11,115),(11,11,117),(11,11,119),(11,11,128),(11,11,129),(11,11,130),(11,11,131),(11,11,132),(11,11,133),(11,11,134),(11,11,135),(11,11,136),(11,11,137),(11,11,138),(11,11,139),(11,11,140),(11,11,141),(11,11,142),(11,11,143),(11,11,144),(11,11,145),(11,11,146),(11,11,154),(11,11,155),(11,11,156),(11,11,157),(11,11,158),(11,11,159),(11,11,160),(11,11,162),(11,11,163),(11,11,164),(11,11,165),(11,11,166),(11,11,167),(11,11,168),(11,11,169),(11,11,170),(11,11,171),(11,11,172),(11,11,173),(11,11,174),(11,11,175),(11,11,176),(11,11,177),(11,11,178),(12,3,5),(12,3,12),(12,3,14),(12,3,37),(12,3,51),(12,3,68),(12,3,97),(12,3,100),(12,3,110),(12,3,121),(12,3,127),(12,3,131),(12,3,156),(12,3,159),(12,3,160),(12,3,169),(12,3,170),(12,3,171),(12,3,179),(12,9,2),(12,9,3),(12,9,4),(12,9,5),(12,9,6),(12,9,7),(12,9,8),(12,9,9),(12,9,10),(12,9,11),(12,9,12),(12,9,13),(12,9,14),(12,9,34),(12,9,35),(12,9,36),(12,9,37),(12,9,38),(12,9,39),(12,9,48),(12,9,49),(12,9,50),(12,9,51),(12,9,52),(12,9,53),(12,9,55),(12,9,65),(12,9,66),(12,9,99),(12,9,109),(12,9,110),(12,9,111),(12,9,120),(12,9,121),(12,9,122),(12,9,123),(12,9,124),(12,9,125),(12,9,126),(12,9,127),(12,9,128),(12,9,129),(12,9,130),(12,9,131),(12,9,132),(12,9,133),(12,9,134),(12,9,135),(12,9,136),(12,9,137),(12,9,138),(12,9,139),(12,9,140),(12,9,141),(12,9,142),(12,9,143),(12,9,144),(12,9,145),(12,9,146),(12,9,154),(12,9,155),(12,9,156),(12,9,157),(12,9,158),(12,9,159),(12,9,160),(12,9,162),(12,9,163),(12,9,164),(12,9,165),(12,9,166),(12,9,167),(12,9,168),(12,9,169),(12,9,170),(12,9,171),(12,9,172),(12,9,173),(12,9,174),(12,9,175),(12,9,176),(12,9,177),(12,9,178),(13,8,2),(13,8,3),(13,8,4),(13,8,5),(13,8,6),(13,8,7),(13,8,8),(13,8,9),(13,8,10),(13,8,11),(13,8,12),(13,8,13),(13,8,14),(13,8,34),(13,8,35),(13,8,36),(13,8,37),(13,8,38),(13,8,39),(13,8,48),(13,8,49),(13,8,50),(13,8,51),(13,8,52),(13,8,53),(13,8,55),(13,8,65),(13,8,66),(13,8,85),(13,8,86),(13,8,87),(13,8,88),(13,8,89),(13,8,90),(13,8,93),(13,8,99),(13,8,109),(13,8,110),(13,8,111),(13,8,120),(13,8,121),(13,8,122),(13,8,123),(13,8,124),(13,8,125),(13,8,126),(13,8,127),(13,8,128),(13,8,129),(13,8,130),(13,8,131),(13,8,132),(13,8,133),(13,8,134),(13,8,135),(13,8,136),(13,8,137),(13,8,138),(13,8,139),(13,8,140),(13,8,141),(13,8,142),(13,8,143),(13,8,144),(13,8,145),(13,8,146),(13,8,154),(13,8,155),(13,8,156),(13,8,157),(13,8,158),(13,8,159),(13,8,160),(13,8,162),(13,8,163),(13,8,164),(13,8,165),(13,8,166),(13,8,167),(13,8,168),(13,8,169),(13,8,170),(13,8,171),(13,8,172),(13,8,173),(13,8,174),(13,8,175),(13,8,176),(13,8,177),(13,8,178),(13,14,5),(13,14,12),(13,14,14),(13,14,37),(13,14,51),(13,14,68),(13,14,92),(13,14,97),(13,14,100),(13,14,110),(13,14,121),(13,14,127),(13,14,131),(13,14,156),(13,14,159),(13,14,160),(13,14,169),(13,14,170),(13,14,171),(13,14,179),(13,15,2),(13,15,3),(13,15,4),(13,15,5),(13,15,6),(13,15,7),(13,15,8),(13,15,9),(13,15,10),(13,15,11),(13,15,12),(13,15,13),(13,15,34),(13,15,35),(13,15,36),(13,15,37),(13,15,38),(13,15,39),(13,15,48),(13,15,49),(13,15,50),(13,15,51),(13,15,52),(13,15,53),(13,15,55),(13,15,67),(13,15,85),(13,15,86),(13,15,90),(13,15,92),(13,15,93),(13,15,97),(13,15,101),(13,15,110),(13,15,120),(13,15,121),(13,15,127),(13,15,131),(13,15,156),(13,15,159),(13,15,160),(13,15,169),(13,15,170),(13,15,171),(13,15,179),(14,5,1),(14,5,2),(14,5,3),(14,5,4),(14,5,5),(14,5,6),(14,5,7),(14,5,8),(14,5,9),(14,5,10),(14,5,11),(14,5,12),(14,5,13),(14,5,14),(14,5,15),(14,5,16),(14,5,17),(14,5,18),(14,5,19),(14,5,20),(14,5,21),(14,5,22),(14,5,23),(14,5,24),(14,5,25),(14,5,26),(14,5,27),(14,5,28),(14,5,31),(14,5,32),(14,5,33),(14,5,34),(14,5,35),(14,5,36),(14,5,37),(14,5,38),(14,5,39),(14,5,41),(14,5,42),(14,5,44),(14,5,46),(14,5,48),(14,5,49),(14,5,50),(14,5,51),(14,5,52),(14,5,53),(14,5,54),(14,5,55),(14,5,56),(14,5,57),(14,5,58),(14,5,59),(14,5,60),(14,5,61),(14,5,62),(14,5,64),(14,5,69),(14,5,70),(14,5,71),(14,5,73),(14,5,74),(14,5,75),(14,5,76),(14,5,77),(14,5,78),(14,5,83),(14,5,84),(14,5,85),(14,5,86),(14,5,87),(14,5,88),(14,5,89),(14,5,90),(14,5,99),(14,5,105),(14,5,106),(14,5,107),(14,5,108),(14,5,109),(14,5,110),(14,5,111),(14,5,114),(14,5,115),(14,5,117),(14,5,119),(14,5,128),(14,5,129),(14,5,130),(14,5,131),(14,5,132),(14,5,133),(14,5,134),(14,5,135),(14,5,136),(14,5,137),(14,5,138),(14,5,139),(14,5,140),(14,5,141),(14,5,142),(14,5,143),(14,5,144),(14,5,145),(14,5,146),(14,5,154),(14,5,155),(14,5,156),(14,5,157),(14,5,158),(14,5,159),(14,5,160),(14,5,162),(14,5,163),(14,5,164),(14,5,165),(14,5,166),(14,5,167),(14,5,168),(14,5,169),(14,5,170),(14,5,171),(14,5,172),(14,5,173),(14,5,174),(14,5,175),(14,5,176),(14,5,177),(14,5,178),(14,6,5),(14,6,12),(14,6,14),(14,6,29),(14,6,30),(14,6,37),(14,6,44),(14,6,46),(14,6,51),(14,6,58),(14,6,60),(14,6,62),(14,6,63),(14,6,71),(14,6,100),(14,6,110),(14,6,115),(14,6,117),(14,6,119),(14,6,131),(14,6,156),(14,6,159),(14,6,160),(14,6,169),(14,6,170),(14,6,171),(14,6,179),(14,7,5),(14,7,12),(14,7,14),(14,7,29),(14,7,30),(14,7,37),(14,7,44),(14,7,46),(14,7,51),(14,7,58),(14,7,60),(14,7,62),(14,7,63),(14,7,71),(14,7,85),(14,7,86),(14,7,100),(14,7,110),(14,7,115),(14,7,117),(14,7,119),(14,7,154),(14,7,155),(14,7,159),(14,7,160),(14,7,180),(14,13,5),(14,13,12),(14,13,14),(14,13,29),(14,13,30),(14,13,37),(14,13,44),(14,13,46),(14,13,51),(14,13,58),(14,13,60),(14,13,62),(14,13,63),(14,13,71),(14,13,85),(14,13,86),(14,13,100),(14,13,110),(14,13,115),(14,13,117),(14,13,119),(14,13,159),(14,13,160),(14,13,177),(15,1,51),(15,2,51),(16,1,51),(16,2,48),(16,2,49),(16,2,50),(16,2,51),(16,2,52),(16,2,53),(17,1,5),(17,2,5),(18,12,5),(18,12,37),(18,12,46),(18,12,51),(18,12,60),(18,12,71),(18,12,110),(19,1,110),(19,2,110),(20,1,110),(20,2,110),(21,1,110),(21,2,110),(22,3,5),(22,3,12),(22,3,14),(22,3,37),(22,3,44),(22,3,46),(22,3,51),(22,3,58),(22,3,60),(22,3,62),(22,3,63),(22,3,68),(22,3,71),(22,3,97),(22,3,110),(22,3,115),(22,3,117),(22,3,119),(22,3,121),(22,3,127),(22,9,2),(22,9,3),(22,9,4),(22,9,5),(22,9,6),(22,9,7),(22,9,8),(22,9,9),(22,9,10),(22,9,11),(22,9,12),(22,9,13),(22,9,14),(22,9,34),(22,9,35),(22,9,36),(22,9,37),(22,9,38),(22,9,39),(22,9,41),(22,9,42),(22,9,43),(22,9,44),(22,9,45),(22,9,46),(22,9,47),(22,9,48),(22,9,49),(22,9,50),(22,9,51),(22,9,52),(22,9,53),(22,9,55),(22,9,56),(22,9,57),(22,9,58),(22,9,59),(22,9,60),(22,9,61),(22,9,62),(22,9,64),(22,9,65),(22,9,66),(22,9,69),(22,9,70),(22,9,71),(22,9,73),(22,9,74),(22,9,76),(22,9,77),(22,9,78),(22,9,83),(22,9,84),(22,9,91),(22,9,92),(22,9,105),(22,9,106),(22,9,107),(22,9,108),(22,9,109),(22,9,110),(22,9,111),(22,9,114),(22,9,115),(22,9,117),(22,9,119),(22,9,120),(22,9,121),(22,9,122),(22,9,123),(22,9,124),(22,9,125),(22,9,126),(22,9,127),(23,4,106),(24,5,147),(24,5,148),(24,5,149),(24,5,150),(24,5,151),(24,5,152),(24,6,153),(24,7,151),(24,13,151),(25,8,147),(25,8,148),(25,8,149),(25,8,150),(25,8,151),(25,8,152),(25,14,153),(25,15,147),(25,15,148),(25,15,149),(25,15,150),(25,15,151),(25,15,152),(26,3,153),(26,9,147),(26,9,148),(26,9,149),(26,9,150),(26,9,151),(26,9,152),(27,1,51),(28,1,51),(29,1,51),(30,10,1),(30,10,2),(30,10,3),(30,10,4),(30,10,5),(30,10,6),(30,10,7),(30,10,8),(30,10,9),(30,10,10),(30,10,11),(30,10,12),(30,10,13),(30,10,14),(30,10,15),(30,10,16),(30,10,17),(30,10,18),(30,10,19),(30,10,20),(30,10,21),(30,10,22),(30,10,23),(30,10,24),(30,10,25),(30,10,26),(30,10,27),(30,10,28),(30,10,31),(30,10,32),(30,10,33),(30,10,34),(30,10,35),(30,10,36),(30,10,37),(30,10,38),(30,10,39),(30,10,41),(30,10,42),(30,10,44),(30,10,46),(30,10,48),(30,10,49),(30,10,50),(30,10,51),(30,10,52),(30,10,53),(30,10,56),(30,10,57),(30,10,58),(30,10,59),(30,10,60),(30,10,61),(30,10,62),(30,10,64),(30,10,69),(30,10,70),(30,10,71),(30,10,72),(30,10,73),(30,10,74),(30,10,75),(30,10,76),(30,10,77),(30,10,78),(30,10,83),(30,10,84),(30,10,99),(30,10,105),(30,10,106),(30,10,107),(30,10,108),(30,10,109),(30,10,110),(30,10,111),(30,10,114),(30,10,115),(30,10,117),(30,10,119),(30,10,128),(30,10,129),(30,10,130),(30,10,131),(30,10,132),(30,10,133),(30,10,134),(30,10,135),(30,10,136),(30,10,137),(30,10,138),(30,10,139),(30,10,140),(30,10,141),(30,10,142),(30,10,143),(30,10,144),(30,10,145),(30,10,146),(30,10,154),(30,10,155),(30,10,156),(30,10,157),(30,10,158),(30,10,159),(30,10,160),(30,10,162),(30,10,163),(30,10,164),(30,10,165),(30,10,166),(30,10,167),(30,10,168),(30,10,169),(30,10,170),(30,10,171),(30,10,172),(30,10,173),(30,10,174),(30,10,175),(30,10,176),(30,10,177),(30,10,178),(30,11,1),(30,11,2),(30,11,3),(30,11,4),(30,11,5),(30,11,6),(30,11,7),(30,11,8),(30,11,9),(30,11,10),(30,11,11),(30,11,12),(30,11,13),(30,11,14),(30,11,15),(30,11,16),(30,11,17),(30,11,18),(30,11,19),(30,11,20),(30,11,21),(30,11,22),(30,11,23),(30,11,24),(30,11,25),(30,11,26),(30,11,27),(30,11,28),(30,11,31),(30,11,32),(30,11,33),(30,11,34),(30,11,35),(30,11,36),(30,11,37),(30,11,38),(30,11,39),(30,11,41),(30,11,42),(30,11,44),(30,11,46),(30,11,48),(30,11,49),(30,11,50),(30,11,51),(30,11,52),(30,11,53),(30,11,56),(30,11,57),(30,11,58),(30,11,59),(30,11,60),(30,11,61),(30,11,62),(30,11,64),(30,11,69),(30,11,70),(30,11,71),(30,11,72),(30,11,73),(30,11,74),(30,11,75),(30,11,76),(30,11,77),(30,11,78),(30,11,83),(30,11,84),(30,11,99),(30,11,105),(30,11,106),(30,11,107),(30,11,108),(30,11,109),(30,11,110),(30,11,111),(30,11,114),(30,11,115),(30,11,117),(30,11,119),(30,11,128),(30,11,129),(30,11,130),(30,11,131),(30,11,132),(30,11,133),(30,11,134),(30,11,135),(30,11,136),(30,11,137),(30,11,138),(30,11,139),(30,11,140),(30,11,141),(30,11,142),(30,11,143),(30,11,144),(30,11,145),(30,11,146),(30,11,154),(30,11,155),(30,11,156),(30,11,157),(30,11,158),(30,11,159),(30,11,160),(30,11,162),(30,11,163),(30,11,164),(30,11,165),(30,11,166),(30,11,167),(30,11,168),(30,11,169),(30,11,170),(30,11,171),(30,11,172),(30,11,173),(30,11,174),(30,11,175),(30,11,176),(30,11,177),(30,11,178),(31,3,5),(31,3,12),(31,3,14),(31,3,29),(31,3,30),(31,3,37),(31,3,44),(31,3,46),(31,3,51),(31,3,58),(31,3,60),(31,3,62),(31,3,63),(31,3,68),(31,3,71),(31,3,91),(31,3,92),(31,3,96),(31,3,100),(31,3,110),(31,3,115),(31,3,117),(31,3,119),(31,3,121),(31,3,127),(31,3,131),(31,3,156),(31,3,159),(31,3,160),(31,3,169),(31,3,170),(31,3,171),(31,3,179),(31,9,1),(31,9,2),(31,9,3),(31,9,4),(31,9,5),(31,9,6),(31,9,7),(31,9,8),(31,9,9),(31,9,10),(31,9,11),(31,9,12),(31,9,13),(31,9,14),(31,9,15),(31,9,16),(31,9,17),(31,9,18),(31,9,19),(31,9,20),(31,9,21),(31,9,22),(31,9,23),(31,9,24),(31,9,25),(31,9,26),(31,9,27),(31,9,28),(31,9,31),(31,9,32),(31,9,33),(31,9,34),(31,9,35),(31,9,36),(31,9,37),(31,9,38),(31,9,39),(31,9,40),(31,9,41),(31,9,42),(31,9,43),(31,9,44),(31,9,45),(31,9,46),(31,9,47),(31,9,48),(31,9,49),(31,9,50),(31,9,51),(31,9,52),(31,9,53),(31,9,54),(31,9,55),(31,9,56),(31,9,57),(31,9,58),(31,9,59),(31,9,60),(31,9,61),(31,9,62),(31,9,64),(31,9,65),(31,9,66),(31,9,69),(31,9,70),(31,9,71),(31,9,72),(31,9,73),(31,9,74),(31,9,76),(31,9,77),(31,9,78),(31,9,83),(31,9,84),(31,9,85),(31,9,86),(31,9,87),(31,9,88),(31,9,89),(31,9,90),(31,9,91),(31,9,92),(31,9,96),(31,9,97),(31,9,99),(31,9,105),(31,9,106),(31,9,107),(31,9,108),(31,9,109),(31,9,110),(31,9,111),(31,9,114),(31,9,115),(31,9,117),(31,9,119),(31,9,120),(31,9,121),(31,9,122),(31,9,123),(31,9,124),(31,9,125),(31,9,126),(31,9,127),(31,9,128),(31,9,129),(31,9,130),(31,9,131),(31,9,132),(31,9,133),(31,9,134),(31,9,135),(31,9,136),(31,9,137),(31,9,138),(31,9,139),(31,9,140),(31,9,141),(31,9,142),(31,9,143),(31,9,144),(31,9,145),(31,9,146),(31,9,154),(31,9,155),(31,9,156),(31,9,157),(31,9,158),(31,9,159),(31,9,160),(31,9,162),(31,9,163),(31,9,164),(31,9,165),(31,9,166),(31,9,167),(31,9,168),(31,9,169),(31,9,170),(31,9,171),(31,9,172),(31,9,173),(31,9,174),(31,9,175),(31,9,176),(31,9,177),(31,9,178);
/*!40000 ALTER TABLE `sakai_realm_rl_fn` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sakai_realm_rl_gr`
--

DROP TABLE IF EXISTS `sakai_realm_rl_gr`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sakai_realm_rl_gr` (
  `REALM_KEY` int(11) NOT NULL,
  `USER_ID` varchar(99) NOT NULL,
  `ROLE_KEY` int(11) NOT NULL,
  `ACTIVE` char(1) DEFAULT NULL,
  `PROVIDED` char(1) DEFAULT NULL,
  PRIMARY KEY (`REALM_KEY`,`USER_ID`),
  KEY `FK_SAKAI_REALM_RL_GR_REALM` (`REALM_KEY`),
  KEY `FK_SAKAI_REALM_RL_GR_ROLE` (`ROLE_KEY`),
  KEY `IE_SAKAI_REALM_RL_GR_ACT` (`ACTIVE`),
  KEY `IE_SAKAI_REALM_RL_GR_USR` (`USER_ID`),
  KEY `IE_SAKAI_REALM_RL_GR_PRV` (`PROVIDED`),
  KEY `SAKAI_REALM_RL_GR_RAU` (`ROLE_KEY`,`ACTIVE`,`USER_ID`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sakai_realm_rl_gr`
--

LOCK TABLES `sakai_realm_rl_gr` WRITE;
/*!40000 ALTER TABLE `sakai_realm_rl_gr` DISABLE KEYS */;
INSERT INTO `sakai_realm_rl_gr` VALUES (22,'admin',9,'1','0'),(23,'admin',4,'1','0'),(30,'admin',10,'1','0'),(31,'admin',9,'1','0');
/*!40000 ALTER TABLE `sakai_realm_rl_gr` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sakai_realm_role`
--

DROP TABLE IF EXISTS `sakai_realm_role`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sakai_realm_role` (
  `ROLE_KEY` int(11) NOT NULL AUTO_INCREMENT,
  `ROLE_NAME` varchar(99) NOT NULL,
  PRIMARY KEY (`ROLE_KEY`),
  UNIQUE KEY `IE_SAKAI_REALM_ROLE_NAME` (`ROLE_NAME`)
) ENGINE=MyISAM AUTO_INCREMENT=16 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sakai_realm_role`
--

LOCK TABLES `sakai_realm_role` WRITE;
/*!40000 ALTER TABLE `sakai_realm_role` DISABLE KEYS */;
INSERT INTO `sakai_realm_role` VALUES (1,'.anon'),(2,'.auth'),(3,'access'),(4,'admin'),(5,'CIG Coordinator'),(6,'CIG Participant'),(7,'Evaluator'),(8,'Instructor'),(9,'maintain'),(10,'Program Admin'),(11,'Program Coordinator'),(12,'pubview'),(13,'Reviewer'),(14,'Student'),(15,'Teaching Assistant');
/*!40000 ALTER TABLE `sakai_realm_role` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sakai_realm_role_desc`
--

DROP TABLE IF EXISTS `sakai_realm_role_desc`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sakai_realm_role_desc` (
  `REALM_KEY` int(11) NOT NULL,
  `ROLE_KEY` int(11) NOT NULL,
  `DESCRIPTION` mediumtext,
  `PROVIDER_ONLY` char(1) DEFAULT NULL,
  PRIMARY KEY (`REALM_KEY`,`ROLE_KEY`),
  KEY `FK_SAKAI_REALM_ROLE_DESC_REALM` (`REALM_KEY`),
  KEY `ROLE_KEY` (`ROLE_KEY`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sakai_realm_role_desc`
--

LOCK TABLES `sakai_realm_role_desc` WRITE;
/*!40000 ALTER TABLE `sakai_realm_role_desc` DISABLE KEYS */;
INSERT INTO `sakai_realm_role_desc` VALUES (9,8,'Can read, revise, delete and add both content and participants to a site.','0'),(9,14,'Can read content, and add content to a site where appropriate.','0'),(9,15,'Can read, add, and revise most content in their sections.','0'),(13,8,'Can read, revise, delete and add both content and participants to a site.','0'),(13,14,'Can read content, and add content to a site where appropriate.','0'),(13,15,'Can read, add, and revise most content in their sections.','0'),(27,1,NULL,'0'),(28,1,NULL,'0'),(29,1,NULL,'0'),(10,6,NULL,'0'),(10,7,NULL,'0'),(10,5,NULL,'0'),(10,13,NULL,'0'),(14,6,NULL,'0'),(14,7,NULL,'0'),(14,5,NULL,'0'),(14,13,NULL,'0'),(11,11,NULL,'0'),(11,10,NULL,'0'),(30,11,NULL,'0'),(30,10,NULL,'0'),(31,3,NULL,'0'),(31,9,NULL,'0');
/*!40000 ALTER TABLE `sakai_realm_role_desc` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sakai_session`
--

DROP TABLE IF EXISTS `sakai_session`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sakai_session` (
  `SESSION_ID` varchar(36) DEFAULT NULL,
  `SESSION_SERVER` varchar(64) DEFAULT NULL,
  `SESSION_USER` varchar(99) DEFAULT NULL,
  `SESSION_IP` varchar(128) DEFAULT NULL,
  `SESSION_HOSTNAME` varchar(255) DEFAULT NULL,
  `SESSION_USER_AGENT` varchar(255) DEFAULT NULL,
  `SESSION_START` datetime DEFAULT NULL,
  `SESSION_END` datetime DEFAULT NULL,
  `SESSION_ACTIVE` tinyint(1) DEFAULT NULL,
  UNIQUE KEY `SAKAI_SESSION_INDEX` (`SESSION_ID`),
  KEY `SAKAI_SESSION_SERVER_INDEX` (`SESSION_SERVER`),
  KEY `SAKAI_SESSION_START_END_IE` (`SESSION_START`,`SESSION_END`,`SESSION_ID`),
  KEY `SESSION_ACTIVE_IE` (`SESSION_ACTIVE`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sakai_session`
--

LOCK TABLES `sakai_session` WRITE;
/*!40000 ALTER TABLE `sakai_session` DISABLE KEYS */;
/*!40000 ALTER TABLE `sakai_session` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sakai_site`
--

DROP TABLE IF EXISTS `sakai_site`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sakai_site` (
  `SITE_ID` varchar(99) NOT NULL,
  `TITLE` varchar(99) DEFAULT NULL,
  `TYPE` varchar(99) DEFAULT NULL,
  `SHORT_DESC` longtext,
  `DESCRIPTION` longtext,
  `ICON_URL` varchar(255) DEFAULT NULL,
  `INFO_URL` varchar(255) DEFAULT NULL,
  `SKIN` varchar(255) DEFAULT NULL,
  `PUBLISHED` int(11) DEFAULT NULL,
  `JOINABLE` char(1) DEFAULT NULL,
  `PUBVIEW` char(1) DEFAULT NULL,
  `JOIN_ROLE` varchar(99) DEFAULT NULL,
  `CREATEDBY` varchar(99) DEFAULT NULL,
  `MODIFIEDBY` varchar(99) DEFAULT NULL,
  `CREATEDON` datetime DEFAULT NULL,
  `MODIFIEDON` datetime DEFAULT NULL,
  `IS_SPECIAL` char(1) DEFAULT NULL,
  `IS_USER` char(1) DEFAULT NULL,
  `CUSTOM_PAGE_ORDERED` char(1) DEFAULT NULL,
  PRIMARY KEY (`SITE_ID`),
  KEY `IE_SAKAI_SITE_CREATED` (`CREATEDBY`,`CREATEDON`),
  KEY `IE_SAKAI_SITE_MODDED` (`MODIFIEDBY`,`MODIFIEDON`),
  KEY `IE_SAKAI_SITE_FLAGS` (`SITE_ID`,`IS_SPECIAL`,`IS_USER`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sakai_site`
--

LOCK TABLES `sakai_site` WRITE;
/*!40000 ALTER TABLE `sakai_site` DISABLE KEYS */;
INSERT INTO `sakai_site` VALUES ('~admin','Administration Workspace',NULL,NULL,'Administration Workspace',NULL,NULL,NULL,1,'0','0','','admin','admin','2012-04-22 16:35:13','2012-04-22 16:35:13','0','1','0'),('!admin','Administration Workspace',NULL,NULL,'Administration Workspace',NULL,NULL,NULL,1,'0','0','','admin','admin','2012-04-22 16:35:13','2012-04-22 16:35:13','0','0','0'),('!error','Site Unavailable',NULL,NULL,'The site you requested is not available.',NULL,NULL,NULL,1,'0','0','','admin','admin','2012-04-22 16:35:13','2012-04-22 16:35:13','1','0','0'),('!urlError','Invalid URL',NULL,NULL,'The URL you entered is invalid.  SOLUTIONS: Please check for spelling errors or typos.  Make sure you are using the right URL.  Type a URL to try again.',NULL,NULL,NULL,1,'0','0','','admin','admin','2012-04-22 16:35:13','2012-04-22 16:35:13','1','0','0'),('!gateway','Gateway',NULL,NULL,'The Gateway Site',NULL,NULL,NULL,1,'0','0','','admin','admin','2012-04-22 16:35:13','2012-04-22 16:35:13','1','0','0'),('!user','My Workspace',NULL,NULL,'My Workspace Site',NULL,NULL,NULL,1,'0','0','','admin','admin','2012-04-22 16:35:13','2012-04-22 16:35:13','1','0','0'),('!worksite','worksite',NULL,NULL,NULL,'','',NULL,0,'0','0','access','admin','admin','2012-04-22 16:35:13','2012-04-22 16:35:13','1','0','0'),('mercury','mercury site',NULL,NULL,NULL,'','',NULL,1,'1','1','access','admin','admin','2012-04-22 16:35:13','2012-04-22 16:35:13','0','0','0'),('PortfolioAdmin','Portfolio Admin','portfolioAdmin',NULL,'Site for portfolio administration',NULL,NULL,NULL,1,'0','0',NULL,'admin','admin','2012-04-22 16:35:36','2012-04-22 16:35:36','0','0','0'),('citationsAdmin','Citations Admin','project',NULL,NULL,NULL,NULL,NULL,1,'0','0',NULL,'admin','admin','2012-04-22 16:35:38','2012-04-22 16:35:38','0','0','0');
/*!40000 ALTER TABLE `sakai_site` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sakai_site_group`
--

DROP TABLE IF EXISTS `sakai_site_group`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sakai_site_group` (
  `GROUP_ID` varchar(99) NOT NULL,
  `SITE_ID` varchar(99) NOT NULL,
  `TITLE` varchar(99) DEFAULT NULL,
  `DESCRIPTION` longtext,
  PRIMARY KEY (`GROUP_ID`),
  KEY `IE_SAKAI_SITE_GRP_SITE` (`SITE_ID`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sakai_site_group`
--

LOCK TABLES `sakai_site_group` WRITE;
/*!40000 ALTER TABLE `sakai_site_group` DISABLE KEYS */;
/*!40000 ALTER TABLE `sakai_site_group` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sakai_site_group_property`
--

DROP TABLE IF EXISTS `sakai_site_group_property`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sakai_site_group_property` (
  `SITE_ID` varchar(99) NOT NULL,
  `GROUP_ID` varchar(99) NOT NULL,
  `NAME` varchar(99) NOT NULL,
  `VALUE` longtext,
  PRIMARY KEY (`GROUP_ID`,`NAME`),
  KEY `IE_SAKAI_SITE_GRP_PROP_SITE` (`SITE_ID`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sakai_site_group_property`
--

LOCK TABLES `sakai_site_group_property` WRITE;
/*!40000 ALTER TABLE `sakai_site_group_property` DISABLE KEYS */;
/*!40000 ALTER TABLE `sakai_site_group_property` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sakai_site_page`
--

DROP TABLE IF EXISTS `sakai_site_page`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sakai_site_page` (
  `PAGE_ID` varchar(99) NOT NULL,
  `SITE_ID` varchar(99) NOT NULL,
  `TITLE` varchar(99) DEFAULT NULL,
  `LAYOUT` char(1) DEFAULT NULL,
  `SITE_ORDER` int(11) NOT NULL,
  `POPUP` char(1) DEFAULT NULL,
  PRIMARY KEY (`PAGE_ID`),
  KEY `SITE_ID` (`SITE_ID`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sakai_site_page`
--

LOCK TABLES `sakai_site_page` WRITE;
/*!40000 ALTER TABLE `sakai_site_page` DISABLE KEYS */;
INSERT INTO `sakai_site_page` VALUES ('~admin-100','~admin','Home','0',1,'0'),('~admin-200','~admin','Users','0',2,'0'),('~admin-250','~admin','Aliases','0',3,'0'),('~admin-300','~admin','Sites','0',4,'0'),('~admin-350','~admin','Realms','0',5,'0'),('~admin-360','~admin','Worksite Setup','0',6,'0'),('~admin-400','~admin','MOTD','0',7,'0'),('~admin-500','~admin','Resources','0',8,'0'),('~admin-600','~admin','On-Line','0',9,'0'),('~admin-700','~admin','Memory','0',10,'0'),('~admin-900','~admin','Site Archive','0',11,'0'),('~admin-1000','~admin','Job Scheduler','0',12,'0'),('~admin-1100','~admin','Become User','0',13,'0'),('~admin-1200','~admin','User Membership','0',14,'0'),('!admin-100','!admin','Home','0',1,'0'),('!admin-200','!admin','Users','0',2,'0'),('!admin-250','!admin','Aliases','0',3,'0'),('!admin-300','!admin','Sites','0',4,'0'),('!admin-350','!admin','Realms','0',5,'0'),('!admin-360','!admin','Worksite Setup','0',6,'0'),('!admin-400','!admin','MOTD','0',7,'0'),('!admin-500','!admin','Resources','0',8,'0'),('!admin-600','!admin','On-Line','0',9,'0'),('!admin-700','!admin','Memory','0',10,'0'),('!admin-900','!admin','Site Archive','0',11,'0'),('!admin-1000','!admin','Job Scheduler','0',12,'0'),('!admin-1100','!admin','Become User','0',13,'0'),('!admin-1200','!admin','User Membership','0',14,'0'),('!admin-1205','!admin','Email Templates','0',15,'0'),('!error-100','!error','Site Unavailable','1',1,'0'),('!urlError-100','!urlError','Invalid URL','1',1,'0'),('!gateway-100','!gateway','Welcome','0',1,'0'),('!gateway-200','!gateway','About','0',2,'0'),('!gateway-300','!gateway','Features','0',3,'0'),('!gateway-400','!gateway','Sites','0',4,'0'),('!gateway-500','!gateway','Training','0',5,'0'),('!gateway-600','!gateway','Acknowledgements','0',6,'0'),('!gateway-700','!gateway','New Account','0',7,'0'),('!user-100','!user','Home','1',1,'0'),('!user-150','!user','Profile','0',2,'0'),('!user-200','!user','Membership','0',3,'0'),('!user-300','!user','Schedule','0',4,'0'),('!user-400','!user','Resources','0',5,'0'),('!user-450','!user','Announcements','0',6,'0'),('!user-500','!user','Worksite Setup','0',7,'0'),('!user-600','!user','Preferences','0',8,'0'),('!user-700','!user','Account','0',9,'0'),('!worksite-100','!worksite','Home','1',1,'0'),('!worksite-200','!worksite','Schedule','0',2,'0'),('!worksite-300','!worksite','Announcements','0',3,'0'),('!worksite-400','!worksite','Resources','0',4,'0'),('!worksite-500','!worksite','Discussion','0',5,'0'),('!worksite-600','!worksite','Assignments','0',6,'0'),('!worksite-700','!worksite','Drop Box','0',7,'0'),('!worksite-800','!worksite','Chat','0',8,'0'),('!worksite-900','!worksite','Email Archive','0',9,'0'),('mercury-100','mercury','Home','1',1,'0'),('mercury-200','mercury','Schedule','0',2,'0'),('mercury-300','mercury','Announcements','0',3,'0'),('mercury-400','mercury','Resources','0',4,'0'),('mercury-500','mercury','Discussion','0',5,'0'),('mercury-600','mercury','Assignments','0',6,'0'),('mercury-700','mercury','Drop Box','0',7,'0'),('mercury-800','mercury','Chat','0',8,'0'),('mercury-900','mercury','Email Archive','0',9,'0'),('mercury-1000','mercury','Site Info','0',10,'0'),('aab39440-e27d-4d68-8136-87346e70bb22','PortfolioAdmin','Reports','0',10,'0'),('3e615d66-b16e-4488-96d8-e20b626469f4','PortfolioAdmin','Forms','0',9,'0'),('25b6d28d-8268-4ddd-8d70-3d355b57f589','PortfolioAdmin','Glossary','0',8,'0'),('61713f24-ac8a-469f-b17f-57c5ad8cfd0b','PortfolioAdmin','Styles','0',7,'0'),('37904dfe-092b-4f5c-9007-75d768cb0e00','PortfolioAdmin','Portfolio Layouts','0',6,'0'),('97d487b2-93cb-44e4-8252-ec98f03bdd91','PortfolioAdmin','Portfolio Templates','0',5,'0'),('8a9ba94e-4448-4132-9b76-70507d155467','PortfolioAdmin','Portfolio','0',4,'0'),('5530a76e-b50a-45da-a5e2-3341d95f8576','PortfolioAdmin','Email Archive','0',3,'0'),('a6d01e34-8148-40ef-9fe7-05a9aea03ce6','PortfolioAdmin','Resources','0',2,'0'),('4b35cae6-1163-486b-9a1c-7c883bc56502','PortfolioAdmin','Home','0',1,'0'),('5968d039-d4ed-4799-93f4-52637626d962','PortfolioAdmin','Site Info','0',11,'0'),('3b2bb17c-892d-470c-9f94-f58db32eb7bc','citationsAdmin','Resources','0',1,'0');
/*!40000 ALTER TABLE `sakai_site_page` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sakai_site_page_property`
--

DROP TABLE IF EXISTS `sakai_site_page_property`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sakai_site_page_property` (
  `SITE_ID` varchar(99) NOT NULL,
  `PAGE_ID` varchar(99) NOT NULL,
  `NAME` varchar(99) NOT NULL,
  `VALUE` longtext,
  PRIMARY KEY (`PAGE_ID`,`NAME`),
  KEY `IE_SAKAI_SITE_PAGE_PROP_SITE` (`SITE_ID`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sakai_site_page_property`
--

LOCK TABLES `sakai_site_page_property` WRITE;
/*!40000 ALTER TABLE `sakai_site_page_property` DISABLE KEYS */;
INSERT INTO `sakai_site_page_property` VALUES ('~admin','~admin-100','is_home_page','true'),('~admin','~admin-400','sitePage.customTitle','true'),('!admin','!admin-100','is_home_page','true'),('!gateway','!gateway-200','sitePage.customTitle','true'),('!gateway','!gateway-300','sitePage.customTitle','true'),('!gateway','!gateway-500','sitePage.customTitle','true'),('!gateway','!gateway-600','sitePage.customTitle','true'),('!user','!user-100','is_home_page','true'),('!worksite','!worksite-100','is_home_page','true'),('mercury','mercury-100','is_home_page','true');
/*!40000 ALTER TABLE `sakai_site_page_property` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sakai_site_property`
--

DROP TABLE IF EXISTS `sakai_site_property`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sakai_site_property` (
  `SITE_ID` varchar(99) NOT NULL,
  `NAME` varchar(99) NOT NULL,
  `VALUE` longtext,
  PRIMARY KEY (`SITE_ID`,`NAME`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sakai_site_property`
--

LOCK TABLES `sakai_site_property` WRITE;
/*!40000 ALTER TABLE `sakai_site_property` DISABLE KEYS */;
/*!40000 ALTER TABLE `sakai_site_property` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sakai_site_tool`
--

DROP TABLE IF EXISTS `sakai_site_tool`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sakai_site_tool` (
  `TOOL_ID` varchar(99) NOT NULL,
  `PAGE_ID` varchar(99) NOT NULL,
  `SITE_ID` varchar(99) NOT NULL,
  `REGISTRATION` varchar(99) NOT NULL,
  `PAGE_ORDER` int(11) NOT NULL,
  `TITLE` varchar(99) DEFAULT NULL,
  `LAYOUT_HINTS` varchar(99) DEFAULT NULL,
  PRIMARY KEY (`TOOL_ID`),
  KEY `PAGE_ID` (`PAGE_ID`),
  KEY `SITE_ID` (`SITE_ID`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sakai_site_tool`
--

LOCK TABLES `sakai_site_tool` WRITE;
/*!40000 ALTER TABLE `sakai_site_tool` DISABLE KEYS */;
INSERT INTO `sakai_site_tool` VALUES ('~admin-110','~admin-100','~admin','sakai.motd',1,'Message of the Day',NULL),('~admin-120','~admin-100','~admin','sakai.iframe.myworkspace',2,'My Workspace Information',NULL),('~admin-210','~admin-200','~admin','sakai.users',1,'Users',NULL),('~admin-260','~admin-250','~admin','sakai.aliases',1,'Aliases',NULL),('~admin-310','~admin-300','~admin','sakai.sites',1,'Sites',NULL),('~admin-355','~admin-350','~admin','sakai.realms',1,'Realms',NULL),('~admin-365','~admin-360','~admin','sakai.sitesetup',1,'Worksite Setup',NULL),('~admin-410','~admin-400','~admin','sakai.announcements',1,'MOTD',NULL),('~admin-510','~admin-500','~admin','sakai.resources',1,'Resources',NULL),('~admin-610','~admin-600','~admin','sakai.online',1,'On-Line',NULL),('~admin-710','~admin-700','~admin','sakai.memory',1,'Memory',NULL),('~admin-910','~admin-900','~admin','sakai.archive',1,'Site Archive / Import',NULL),('~admin-1010','~admin-1000','~admin','sakai.scheduler',1,'Job Scheduler',NULL),('~admin-1110','~admin-1100','~admin','sakai.su',1,'Become User',NULL),('~admin-1210','~admin-1200','~admin','sakai.usermembership',1,'User Membership',NULL),('!admin-110','!admin-100','!admin','sakai.motd',1,'Message of the Day',NULL),('!admin-120','!admin-100','!admin','sakai.iframe.myworkspace',2,'My Workspace Information',NULL),('!admin-210','!admin-200','!admin','sakai.users',1,'Users',NULL),('!admin-260','!admin-250','!admin','sakai.aliases',1,'Aliases',NULL),('!admin-310','!admin-300','!admin','sakai.sites',1,'Sites',NULL),('!admin-355','!admin-350','!admin','sakai.realms',1,'Realms',NULL),('!admin-365','!admin-360','!admin','sakai.sitesetup',1,'Worksite Setup',NULL),('!admin-410','!admin-400','!admin','sakai.announcements',1,'MOTD',NULL),('!admin-510','!admin-500','!admin','sakai.resources',1,'Resources',NULL),('!admin-610','!admin-600','!admin','sakai.online',1,'On-Line',NULL),('!admin-710','!admin-700','!admin','sakai.memory',1,'Memory',NULL),('!admin-910','!admin-900','!admin','sakai.archive',1,'Site Archive / Import',NULL),('!admin-1010','!admin-1000','!admin','sakai.scheduler',1,'Job Scheduler',NULL),('!admin-1110','!admin-1100','!admin','sakai.su',1,'Become User',NULL),('!admin-1210','!admin-1200','!admin','sakai.usermembership',1,'User Membership',NULL),('!admin-1211','!admin-1205','!admin','sakai.emailtemplateservice',1,'Email Templates',NULL),('!error-110','!error-100','!error','sakai.iframe.site',1,'Site Unavailable',NULL),('!urlError-110','!urlError-100','!urlError','sakai.iframe.site',1,'Invalid URL',NULL),('!gateway-110','!gateway-100','!gateway','sakai.motd',1,'Message of the day',NULL),('!gateway-120','!gateway-100','!gateway','sakai.iframe.service',2,'Welcome!',NULL),('!gateway-210','!gateway-200','!gateway','sakai.iframe',1,'About',NULL),('!gateway-310','!gateway-300','!gateway','sakai.iframe',1,'Features',NULL),('!gateway-410','!gateway-400','!gateway','sakai.sitebrowser',1,'Sites',NULL),('!gateway-510','!gateway-500','!gateway','sakai.iframe',1,'Training',NULL),('!gateway-610','!gateway-600','!gateway','sakai.iframe',1,'Acknowledgments',NULL),('!gateway-710','!gateway-700','!gateway','sakai.createuser',1,'New Account',NULL),('!user-110','!user-100','!user','sakai.motd',1,'Message of the Day','0,0'),('!user-120','!user-100','!user','sakai.iframe.myworkspace',2,'My Workspace Information','1,0'),('!user-130','!user-100','!user','sakai.summary.calendar',2,'Calendar','0,1'),('!user-140','!user-100','!user','sakai.synoptic.announcement',2,'Recent Announcements','1,1'),('!user-145','!user-100','!user','sakai.synoptic.messagecenter',2,'Unread Messages and Forums','1,1'),('!user-165','!user-150','!user','sakai.profile2',1,'Profile',NULL),('!user-210','!user-200','!user','sakai.membership',1,'Membership',NULL),('!user-310','!user-300','!user','sakai.schedule',1,'Schedule',NULL),('!user-410','!user-400','!user','sakai.resources',1,'Resources',NULL),('!user-455','!user-450','!user','sakai.announcements',1,'Announcements',NULL),('!user-510','!user-500','!user','sakai.sitesetup',1,'Worksite Setup',NULL),('!user-610','!user-600','!user','sakai.preferences',1,'Preferences',NULL),('!user-710','!user-700','!user','sakai.singleuser',1,'Account',NULL),('!worksite-110','!worksite-100','!worksite','sakai.iframe.site',1,'My Workspace Information',NULL),('!worksite-120','!worksite-100','!worksite','sakai.synoptic.announcement',2,'Recent Announcements',NULL),('!worksite-140','!worksite-100','!worksite','sakai.synoptic.chat',4,'Recent Chat Messages',NULL),('!worksite-210','!worksite-200','!worksite','sakai.schedule',1,'Schedule',NULL),('!worksite-310','!worksite-300','!worksite','sakai.announcements',1,'Announcements',NULL),('!worksite-410','!worksite-400','!worksite','sakai.resources',1,'Resources',NULL),('7a4c2606-d913-4014-8262-833b6277a40b','25b6d28d-8268-4ddd-8d70-3d355b57f589','PortfolioAdmin','osp.glossary',1,'(title unknown)','0,0'),('!worksite-610','!worksite-600','!worksite','sakai.assignment.grades',1,'Assignments',NULL),('!worksite-710','!worksite-700','!worksite','sakai.dropbox',1,'Drop Box',NULL),('!worksite-810','!worksite-800','!worksite','sakai.chat',1,'Chat',NULL),('!worksite-910','!worksite-900','!worksite','sakai.mailbox',1,'Email Archive',NULL),('mercury-110','mercury-100','mercury','sakai.iframe.site',1,'My Workspace Information',NULL),('mercury-120','mercury-100','mercury','sakai.synoptic.announcement',2,'Recent Announcements',NULL),('mercury-140','mercury-100','mercury','sakai.synoptic.chat',4,'Recent Chat Messages',NULL),('mercury-210','mercury-200','mercury','sakai.schedule',1,'Schedule',NULL),('mercury-310','mercury-300','mercury','sakai.announcements',1,'Announcements',NULL),('mercury-410','mercury-400','mercury','sakai.resources',1,'Resources',NULL),('mercury-610','mercury-600','mercury','sakai.assignment.grades',1,'Assignments',NULL),('mercury-710','mercury-700','mercury','sakai.dropbox',1,'Drop Box',NULL),('mercury-810','mercury-800','mercury','sakai.chat',1,'Chat',NULL),('mercury-910','mercury-900','mercury','sakai.mailbox',1,'Email Archive',NULL),('mercury-1010','mercury-1000','mercury','sakai.siteinfo',1,'Site Info',NULL),('c87c2308-9dc1-4efb-ae0c-d5964af79d06','aab39440-e27d-4d68-8136-87346e70bb22','PortfolioAdmin','sakai.reports',1,'(title unknown)','0,0'),('cd7ede58-9408-483e-b173-b34d8a82d621','3e615d66-b16e-4488-96d8-e20b626469f4','PortfolioAdmin','sakai.metaobj',1,'(title unknown)','0,0'),('8e2825c1-4e22-4ba5-b94d-e306527d6e9c','61713f24-ac8a-469f-b17f-57c5ad8cfd0b','PortfolioAdmin','osp.style',1,'(title unknown)','0,0'),('74db52ce-480f-42e9-85a7-1df6ac500e08','37904dfe-092b-4f5c-9007-75d768cb0e00','PortfolioAdmin','osp.presLayout',1,'(title unknown)','0,0'),('5239fcc9-80fe-47ad-acfd-e4c92b903713','97d487b2-93cb-44e4-8252-ec98f03bdd91','PortfolioAdmin','osp.presTemplate',1,'(title unknown)','0,0'),('7ee3840d-ceae-45c7-a53d-2a1b0bdf0ef9','8a9ba94e-4448-4132-9b76-70507d155467','PortfolioAdmin','osp.presentation',1,'(title unknown)','0,0'),('3920f5bd-952c-4f83-b3e4-45cc28cdcab3','5530a76e-b50a-45da-a5e2-3341d95f8576','PortfolioAdmin','sakai.mailbox',1,'(title unknown)','0,0'),('33c0b8a6-1cf1-49ad-924a-757c4ba35b60','a6d01e34-8148-40ef-9fe7-05a9aea03ce6','PortfolioAdmin','sakai.resources',1,'(title unknown)','0,0'),('a6c91c4a-234c-4657-be28-8a1270516e80','4b35cae6-1163-486b-9a1c-7c883bc56502','PortfolioAdmin','sakai.iframe.site',1,'Worksite Information','0,0'),('4030c71d-1333-4e16-9e9c-a8c7ed579e09','5968d039-d4ed-4799-93f4-52637626d962','PortfolioAdmin','sakai.siteinfo',1,NULL,'0,0'),('0d05aca0-eeb3-426d-878d-5c1f1decb2b1','3b2bb17c-892d-470c-9f94-f58db32eb7bc','citationsAdmin','sakai.resources',1,'(title unknown)',NULL);
/*!40000 ALTER TABLE `sakai_site_tool` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sakai_site_tool_property`
--

DROP TABLE IF EXISTS `sakai_site_tool_property`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sakai_site_tool_property` (
  `SITE_ID` varchar(99) NOT NULL,
  `TOOL_ID` varchar(99) NOT NULL,
  `NAME` varchar(99) NOT NULL,
  `VALUE` longtext,
  PRIMARY KEY (`TOOL_ID`,`NAME`),
  KEY `IE_SAKAI_SITE_TOOL_PROP_SITE` (`SITE_ID`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sakai_site_tool_property`
--

LOCK TABLES `sakai_site_tool_property` WRITE;
/*!40000 ALTER TABLE `sakai_site_tool_property` DISABLE KEYS */;
INSERT INTO `sakai_site_tool_property` VALUES ('~admin','~admin-410','channel','/announcement/channel/!site/motd'),('~admin','~admin-510','home','/'),('!admin','!admin-410','channel','/announcement/channel/!site/motd'),('!admin','!admin-510','home','/'),('!error','!error-110','height','400px'),('!urlError','!urlError-110','height','400px'),('!gateway','!gateway-210','height','500px'),('!gateway','!gateway-210','source','/library/content/gateway/about.html'),('!gateway','!gateway-310','height','500px'),('!gateway','!gateway-310','source','/library/content/gateway/features.html'),('!gateway','!gateway-510','height','500px'),('!gateway','!gateway-510','source','/library/content/gateway/training.html'),('!gateway','!gateway-610','height','500px'),('!gateway','!gateway-610','source','/library/content/gateway/acknowledgments.html'),('!user','!user-710','include-password','true'),('!worksite','!worksite-110','height','100px'),('!worksite','!worksite-710','resources_mode','dropbox'),('!worksite','!worksite-810','display-date','true'),('!worksite','!worksite-810','filter-param','3'),('!worksite','!worksite-810','display-time','true'),('!worksite','!worksite-810','sound-alert','true'),('!worksite','!worksite-810','filter-type','SelectMessagesByTime'),('!worksite','!worksite-810','display-user','true'),('mercury','mercury-710','resources_mode','dropbox'),('mercury','mercury-810','display-date','true'),('mercury','mercury-810','filter-param','3'),('mercury','mercury-810','display-time','true'),('mercury','mercury-810','sound-alert','true'),('mercury','mercury-810','filter-type','SelectMessagesByTime'),('mercury','mercury-810','display-user','true'),('PortfolioAdmin','7a4c2606-d913-4014-8262-833b6277a40b','theospi.toolListenerId','org.theospi.portfolio.security.mgt.ToolPermissionManager.glossaryGlobal'),('PortfolioAdmin','74db52ce-480f-42e9-85a7-1df6ac500e08','theospi.toolListenerId','org.theospi.portfolio.security.mgt.ToolPermissionManager.presentationLayout'),('PortfolioAdmin','8e2825c1-4e22-4ba5-b94d-e306527d6e9c','theospi.toolListenerId','org.theospi.portfolio.security.mgt.ToolPermissionManager.style'),('PortfolioAdmin','74db52ce-480f-42e9-85a7-1df6ac500e08','theospi.resetUrl','/listLayout.osp'),('PortfolioAdmin','7ee3840d-ceae-45c7-a53d-2a1b0bdf0ef9','theospi.resetUrl','/member/listPresentation.osp'),('PortfolioAdmin','7ee3840d-ceae-45c7-a53d-2a1b0bdf0ef9','theospi.toolListenerId','org.theospi.portfolio.security.mgt.ToolPermissionManager.presentation'),('PortfolioAdmin','5239fcc9-80fe-47ad-acfd-e4c92b903713','theospi.toolListenerId','org.theospi.portfolio.security.mgt.ToolPermissionManager.presentationTemplate'),('PortfolioAdmin','5239fcc9-80fe-47ad-acfd-e4c92b903713','theospi.resetUrl','/member/listTemplate.osp');
/*!40000 ALTER TABLE `sakai_site_tool_property` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sakai_site_user`
--

DROP TABLE IF EXISTS `sakai_site_user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sakai_site_user` (
  `SITE_ID` varchar(99) NOT NULL,
  `USER_ID` varchar(99) NOT NULL,
  `PERMISSION` int(11) NOT NULL,
  PRIMARY KEY (`SITE_ID`,`USER_ID`),
  KEY `IE_SAKAI_SITE_USER_USER` (`USER_ID`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sakai_site_user`
--

LOCK TABLES `sakai_site_user` WRITE;
/*!40000 ALTER TABLE `sakai_site_user` DISABLE KEYS */;
INSERT INTO `sakai_site_user` VALUES ('!admin','admin',-1),('PortfolioAdmin','admin',-1),('citationsAdmin','admin',-1);
/*!40000 ALTER TABLE `sakai_site_user` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sakai_syllabus_attach`
--

DROP TABLE IF EXISTS `sakai_syllabus_attach`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sakai_syllabus_attach` (
  `syllabusAttachId` bigint(20) NOT NULL AUTO_INCREMENT,
  `lockId` int(11) NOT NULL,
  `attachmentId` varchar(256) NOT NULL,
  `syllabusAttachName` varchar(256) NOT NULL,
  `syllabusAttachSize` varchar(256) DEFAULT NULL,
  `syllabusAttachType` varchar(256) DEFAULT NULL,
  `createdBy` varchar(256) DEFAULT NULL,
  `syllabusAttachUrl` varchar(256) NOT NULL,
  `lastModifiedBy` varchar(256) DEFAULT NULL,
  `syllabusId` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`syllabusAttachId`),
  KEY `FK4BF41E45AE4A118A` (`syllabusId`),
  CONSTRAINT `FK4BF41E45AE4A118A` FOREIGN KEY (`syllabusId`) REFERENCES `sakai_syllabus_data` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sakai_syllabus_attach`
--

LOCK TABLES `sakai_syllabus_attach` WRITE;
/*!40000 ALTER TABLE `sakai_syllabus_attach` DISABLE KEYS */;
/*!40000 ALTER TABLE `sakai_syllabus_attach` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sakai_syllabus_data`
--

DROP TABLE IF EXISTS `sakai_syllabus_data`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sakai_syllabus_data` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `lockId` int(11) NOT NULL,
  `asset` mediumtext,
  `position_c` int(11) NOT NULL,
  `title` varchar(256) DEFAULT NULL,
  `xview` varchar(16) DEFAULT NULL,
  `status` varchar(64) DEFAULT NULL,
  `emailNotification` varchar(128) DEFAULT NULL,
  `surrogateKey` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FK3BC123AA391BE33A` (`surrogateKey`),
  CONSTRAINT `FK3BC123AA391BE33A` FOREIGN KEY (`surrogateKey`) REFERENCES `sakai_syllabus_item` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sakai_syllabus_data`
--

LOCK TABLES `sakai_syllabus_data` WRITE;
/*!40000 ALTER TABLE `sakai_syllabus_data` DISABLE KEYS */;
/*!40000 ALTER TABLE `sakai_syllabus_data` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sakai_syllabus_item`
--

DROP TABLE IF EXISTS `sakai_syllabus_item`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sakai_syllabus_item` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `lockId` int(11) NOT NULL,
  `userId` varchar(36) NOT NULL,
  `contextId` varchar(255) NOT NULL,
  `redirectURL` varchar(512) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `userId` (`userId`,`contextId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sakai_syllabus_item`
--

LOCK TABLES `sakai_syllabus_item` WRITE;
/*!40000 ALTER TABLE `sakai_syllabus_item` DISABLE KEYS */;
/*!40000 ALTER TABLE `sakai_syllabus_item` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sakai_user`
--

DROP TABLE IF EXISTS `sakai_user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sakai_user` (
  `USER_ID` varchar(99) NOT NULL,
  `EMAIL` varchar(255) DEFAULT NULL,
  `EMAIL_LC` varchar(255) DEFAULT NULL,
  `FIRST_NAME` varchar(255) DEFAULT NULL,
  `LAST_NAME` varchar(255) DEFAULT NULL,
  `TYPE` varchar(255) DEFAULT NULL,
  `PW` varchar(255) DEFAULT NULL,
  `CREATEDBY` varchar(99) NOT NULL,
  `MODIFIEDBY` varchar(99) NOT NULL,
  `CREATEDON` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `MODIFIEDON` datetime NOT NULL,
  PRIMARY KEY (`USER_ID`),
  KEY `IE_SAKAI_USER_CREATED` (`CREATEDBY`,`CREATEDON`),
  KEY `IE_SAKAI_USER_MODDED` (`MODIFIEDBY`,`MODIFIEDON`),
  KEY `IE_SAKAI_USER_EMAIL` (`EMAIL_LC`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sakai_user`
--

LOCK TABLES `sakai_user` WRITE;
/*!40000 ALTER TABLE `sakai_user` DISABLE KEYS */;
INSERT INTO `sakai_user` VALUES ('admin','','','Sakai','Administrator','','ISMvKXpXpadDiUoOSoAfww==','admin','admin','2012-04-22 21:35:26','2012-04-22 16:35:26'),('postmaster','','','Sakai','Postmaster','','','postmaster','postmaster','2012-04-22 21:35:26','2012-04-22 16:35:26');
/*!40000 ALTER TABLE `sakai_user` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sakai_user_id_map`
--

DROP TABLE IF EXISTS `sakai_user_id_map`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sakai_user_id_map` (
  `USER_ID` varchar(99) NOT NULL,
  `EID` varchar(255) NOT NULL,
  PRIMARY KEY (`USER_ID`),
  UNIQUE KEY `AK_SAKAI_USER_ID_MAP_EID` (`EID`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sakai_user_id_map`
--

LOCK TABLES `sakai_user_id_map` WRITE;
/*!40000 ALTER TABLE `sakai_user_id_map` DISABLE KEYS */;
INSERT INTO `sakai_user_id_map` VALUES ('admin','admin'),('postmaster','postmaster');
/*!40000 ALTER TABLE `sakai_user_id_map` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sakai_user_property`
--

DROP TABLE IF EXISTS `sakai_user_property`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sakai_user_property` (
  `USER_ID` varchar(99) NOT NULL,
  `NAME` varchar(99) NOT NULL,
  `VALUE` longtext,
  PRIMARY KEY (`USER_ID`,`NAME`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sakai_user_property`
--

LOCK TABLES `sakai_user_property` WRITE;
/*!40000 ALTER TABLE `sakai_user_property` DISABLE KEYS */;
/*!40000 ALTER TABLE `sakai_user_property` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sam_answer_t`
--

DROP TABLE IF EXISTS `sam_answer_t`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sam_answer_t` (
  `ANSWERID` bigint(20) NOT NULL AUTO_INCREMENT,
  `ITEMTEXTID` bigint(20) NOT NULL,
  `ITEMID` bigint(20) NOT NULL,
  `TEXT` varchar(4000) DEFAULT NULL,
  `SEQUENCE` bigint(20) NOT NULL,
  `LABEL` varchar(20) DEFAULT NULL,
  `ISCORRECT` bit(1) DEFAULT NULL,
  `GRADE` varchar(80) DEFAULT NULL,
  `SCORE` float DEFAULT NULL,
  `DISCOUNT` float DEFAULT NULL,
  `PARTIAL_CREDIT` float DEFAULT NULL,
  PRIMARY KEY (`ANSWERID`),
  KEY `FKDD0580933288DBBD` (`ITEMID`),
  KEY `FKDD058093278A7DAD` (`ITEMTEXTID`),
  CONSTRAINT `FKDD058093278A7DAD` FOREIGN KEY (`ITEMTEXTID`) REFERENCES `sam_itemtext_t` (`ITEMTEXTID`),
  CONSTRAINT `FKDD0580933288DBBD` FOREIGN KEY (`ITEMID`) REFERENCES `sam_item_t` (`ITEMID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sam_answer_t`
--

LOCK TABLES `sam_answer_t` WRITE;
/*!40000 ALTER TABLE `sam_answer_t` DISABLE KEYS */;
/*!40000 ALTER TABLE `sam_answer_t` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sam_answerfeedback_t`
--

DROP TABLE IF EXISTS `sam_answerfeedback_t`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sam_answerfeedback_t` (
  `ANSWERFEEDBACKID` bigint(20) NOT NULL AUTO_INCREMENT,
  `ANSWERID` bigint(20) NOT NULL,
  `TYPEID` varchar(255) DEFAULT NULL,
  `TEXT` varchar(4000) DEFAULT NULL,
  PRIMARY KEY (`ANSWERFEEDBACKID`),
  KEY `FK58CEF0D8DEC85889` (`ANSWERID`),
  CONSTRAINT `FK58CEF0D8DEC85889` FOREIGN KEY (`ANSWERID`) REFERENCES `sam_answer_t` (`ANSWERID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sam_answerfeedback_t`
--

LOCK TABLES `sam_answerfeedback_t` WRITE;
/*!40000 ALTER TABLE `sam_answerfeedback_t` DISABLE KEYS */;
/*!40000 ALTER TABLE `sam_answerfeedback_t` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sam_assessaccesscontrol_t`
--

DROP TABLE IF EXISTS `sam_assessaccesscontrol_t`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sam_assessaccesscontrol_t` (
  `ASSESSMENTID` bigint(20) NOT NULL,
  `SUBMISSIONSALLOWED` int(11) DEFAULT NULL,
  `UNLIMITEDSUBMISSIONS` bit(1) DEFAULT NULL,
  `SUBMISSIONSSAVED` int(11) DEFAULT NULL,
  `ASSESSMENTFORMAT` int(11) DEFAULT NULL,
  `BOOKMARKINGITEM` int(11) DEFAULT NULL,
  `TIMELIMIT` int(11) DEFAULT NULL,
  `TIMEDASSESSMENT` int(11) DEFAULT NULL,
  `RETRYALLOWED` int(11) DEFAULT NULL,
  `LATEHANDLING` int(11) DEFAULT NULL,
  `STARTDATE` datetime DEFAULT NULL,
  `DUEDATE` datetime DEFAULT NULL,
  `SCOREDATE` datetime DEFAULT NULL,
  `FEEDBACKDATE` datetime DEFAULT NULL,
  `RETRACTDATE` datetime DEFAULT NULL,
  `AUTOSUBMIT` int(11) DEFAULT NULL,
  `ITEMNAVIGATION` int(11) DEFAULT NULL,
  `ITEMNUMBERING` int(11) DEFAULT NULL,
  `SUBMISSIONMESSAGE` varchar(4000) DEFAULT NULL,
  `RELEASETO` varchar(255) DEFAULT NULL,
  `USERNAME` varchar(255) DEFAULT NULL,
  `PASSWORD` varchar(255) DEFAULT NULL,
  `FINALPAGEURL` varchar(1023) DEFAULT NULL,
  `MARKFORREVIEW` int(11) DEFAULT NULL,
  PRIMARY KEY (`ASSESSMENTID`),
  KEY `FKC945448A694216CC` (`ASSESSMENTID`),
  CONSTRAINT `FKC945448A694216CC` FOREIGN KEY (`ASSESSMENTID`) REFERENCES `sam_assessmentbase_t` (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sam_assessaccesscontrol_t`
--

LOCK TABLES `sam_assessaccesscontrol_t` WRITE;
/*!40000 ALTER TABLE `sam_assessaccesscontrol_t` DISABLE KEYS */;
INSERT INTO `sam_assessaccesscontrol_t` VALUES (1,NULL,'',1,1,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,NULL,NULL,1,2,1,'','','','','',NULL),(2,NULL,'',1,1,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,NULL,NULL,1,2,1,'','','','','',1),(3,1,'\0',1,3,NULL,NULL,NULL,NULL,2,NULL,NULL,NULL,NULL,NULL,1,1,1,'','','','','',NULL),(4,NULL,'',1,2,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,NULL,NULL,1,2,1,'','','','','',NULL),(5,1,'\0',1,1,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,NULL,NULL,1,2,1,'','','','','',NULL),(6,1,'\0',1,1,NULL,NULL,NULL,NULL,2,NULL,NULL,NULL,NULL,NULL,1,1,1,'','','','','',NULL),(7,1,'\0',1,1,NULL,NULL,NULL,NULL,2,NULL,NULL,NULL,NULL,NULL,1,1,1,'','','','','',NULL);
/*!40000 ALTER TABLE `sam_assessaccesscontrol_t` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sam_assessevaluation_t`
--

DROP TABLE IF EXISTS `sam_assessevaluation_t`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sam_assessevaluation_t` (
  `ASSESSMENTID` bigint(20) NOT NULL,
  `EVALUATIONCOMPONENTS` varchar(255) DEFAULT NULL,
  `SCORINGTYPE` int(11) DEFAULT NULL,
  `NUMERICMODELID` varchar(255) DEFAULT NULL,
  `FIXEDTOTALSCORE` int(11) DEFAULT NULL,
  `GRADEAVAILABLE` int(11) DEFAULT NULL,
  `ISSTUDENTIDPUBLIC` int(11) DEFAULT NULL,
  `ANONYMOUSGRADING` int(11) DEFAULT NULL,
  `AUTOSCORING` int(11) DEFAULT NULL,
  `TOGRADEBOOK` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`ASSESSMENTID`),
  KEY `FK6A6F29F5694216CC` (`ASSESSMENTID`),
  CONSTRAINT `FK6A6F29F5694216CC` FOREIGN KEY (`ASSESSMENTID`) REFERENCES `sam_assessmentbase_t` (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sam_assessevaluation_t`
--

LOCK TABLES `sam_assessevaluation_t` WRITE;
/*!40000 ALTER TABLE `sam_assessevaluation_t` DISABLE KEYS */;
INSERT INTO `sam_assessevaluation_t` VALUES (1,'',1,'',NULL,NULL,NULL,1,NULL,'2'),(2,'',1,'',NULL,NULL,NULL,1,NULL,'2'),(3,'',1,'',NULL,NULL,NULL,2,NULL,'2'),(4,'',1,'',NULL,NULL,NULL,2,NULL,'2'),(5,'',1,'',NULL,NULL,NULL,1,NULL,'2'),(6,'',1,'',NULL,NULL,NULL,1,NULL,'2'),(7,'',1,'',NULL,NULL,NULL,1,NULL,'2');
/*!40000 ALTER TABLE `sam_assessevaluation_t` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sam_assessfeedback_t`
--

DROP TABLE IF EXISTS `sam_assessfeedback_t`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sam_assessfeedback_t` (
  `ASSESSMENTID` bigint(20) NOT NULL,
  `FEEDBACKDELIVERY` int(11) DEFAULT NULL,
  `FEEDBACKAUTHORING` int(11) DEFAULT NULL,
  `EDITCOMPONENTS` int(11) DEFAULT NULL,
  `SHOWQUESTIONTEXT` bit(1) DEFAULT NULL,
  `SHOWSTUDENTRESPONSE` bit(1) DEFAULT NULL,
  `SHOWCORRECTRESPONSE` bit(1) DEFAULT NULL,
  `SHOWSTUDENTSCORE` bit(1) DEFAULT NULL,
  `SHOWSTUDENTQUESTIONSCORE` bit(1) DEFAULT NULL,
  `SHOWQUESTIONLEVELFEEDBACK` bit(1) DEFAULT NULL,
  `SHOWSELECTIONLEVELFEEDBACK` bit(1) DEFAULT NULL,
  `SHOWGRADERCOMMENTS` bit(1) DEFAULT NULL,
  `SHOWSTATISTICS` bit(1) DEFAULT NULL,
  PRIMARY KEY (`ASSESSMENTID`),
  KEY `FK557D4CFE694216CC` (`ASSESSMENTID`),
  CONSTRAINT `FK557D4CFE694216CC` FOREIGN KEY (`ASSESSMENTID`) REFERENCES `sam_assessmentbase_t` (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sam_assessfeedback_t`
--

LOCK TABLES `sam_assessfeedback_t` WRITE;
/*!40000 ALTER TABLE `sam_assessfeedback_t` DISABLE KEYS */;
INSERT INTO `sam_assessfeedback_t` VALUES (1,3,1,1,'','\0','\0','\0','\0','\0','\0','\0','\0'),(2,3,3,1,'','\0','\0','\0','\0','\0','\0','\0','\0'),(3,3,1,1,'','\0','\0','\0','\0','\0','\0','\0','\0'),(4,3,1,1,'','\0','\0','\0','\0','\0','\0','\0','\0'),(5,1,3,1,'\0','','\0','\0','\0','\0','\0','\0',''),(6,3,1,1,'','\0','\0','\0','\0','\0','\0','\0','\0'),(7,3,1,1,'','\0','\0','\0','\0','\0','\0','\0','\0');
/*!40000 ALTER TABLE `sam_assessfeedback_t` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sam_assessmentbase_t`
--

DROP TABLE IF EXISTS `sam_assessmentbase_t`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sam_assessmentbase_t` (
  `ID` bigint(20) NOT NULL AUTO_INCREMENT,
  `isTemplate` varchar(255) NOT NULL,
  `PARENTID` bigint(20) DEFAULT NULL,
  `TITLE` varchar(255) DEFAULT NULL,
  `DESCRIPTION` varchar(4000) DEFAULT NULL,
  `COMMENTS` varchar(4000) DEFAULT NULL,
  `TYPEID` bigint(20) DEFAULT NULL,
  `INSTRUCTORNOTIFICATION` int(11) DEFAULT NULL,
  `TESTEENOTIFICATION` int(11) DEFAULT NULL,
  `MULTIPARTALLOWED` int(11) DEFAULT NULL,
  `STATUS` int(11) NOT NULL,
  `CREATEDBY` varchar(255) NOT NULL,
  `CREATEDDATE` datetime NOT NULL,
  `LASTMODIFIEDBY` varchar(255) NOT NULL,
  `LASTMODIFIEDDATE` datetime NOT NULL,
  `ASSESSMENTTEMPLATEID` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sam_assessmentbase_t`
--

LOCK TABLES `sam_assessmentbase_t` WRITE;
/*!40000 ALTER TABLE `sam_assessmentbase_t` DISABLE KEYS */;
INSERT INTO `sam_assessmentbase_t` VALUES (1,'1',0,'Default Assessment Type','System Defined Assessment Type','comments',142,1,1,1,1,'admin','2005-01-01 12:00:00','admin','2005-01-01 12:00:00',NULL),(2,'1',0,'Formative Assessment','System Defined Assessment Type','',142,1,1,1,1,'admin','2006-06-01 12:00:00','admin','2006-06-01 12:00:00',NULL),(3,'1',0,'Quiz','System Defined Assessment Type','',142,1,1,1,1,'admin','2006-06-01 12:00:00','admin','2006-06-01 12:00:00',NULL),(4,'1',0,'Problem Set','System Defined Assessment Type','',142,1,1,1,1,'admin','2006-06-01 12:00:00','admin','2006-06-01 12:00:00',NULL),(5,'1',0,'Survey','System Defined Assessment Type','',142,1,1,1,1,'admin','2006-06-01 12:00:00','admin','2006-06-01 12:00:00',NULL),(6,'1',0,'Test','System Defined Assessment Type','',142,1,1,1,1,'admin','2006-06-01 12:00:00','admin','2006-06-01 12:00:00',NULL),(7,'1',0,'Timed Test','System Defined Assessment Type','',142,1,1,1,1,'admin','2006-06-01 12:00:00','admin','2006-06-01 12:00:00',NULL);
/*!40000 ALTER TABLE `sam_assessmentbase_t` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sam_assessmentgrading_t`
--

DROP TABLE IF EXISTS `sam_assessmentgrading_t`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sam_assessmentgrading_t` (
  `ASSESSMENTGRADINGID` bigint(20) NOT NULL AUTO_INCREMENT,
  `PUBLISHEDASSESSMENTID` bigint(20) NOT NULL,
  `AGENTID` varchar(255) NOT NULL,
  `SUBMITTEDDATE` datetime DEFAULT NULL,
  `ISLATE` bit(1) NOT NULL,
  `FORGRADE` bit(1) NOT NULL,
  `TOTALAUTOSCORE` float DEFAULT NULL,
  `TOTALOVERRIDESCORE` float DEFAULT NULL,
  `FINALSCORE` float DEFAULT NULL,
  `COMMENTS` varchar(4000) DEFAULT NULL,
  `GRADEDBY` varchar(255) DEFAULT NULL,
  `GRADEDDATE` datetime DEFAULT NULL,
  `STATUS` int(11) NOT NULL,
  `ATTEMPTDATE` datetime DEFAULT NULL,
  `TIMEELAPSED` int(11) DEFAULT NULL,
  `ISAUTOSUBMITTED` bit(1) DEFAULT NULL,
  PRIMARY KEY (`ASSESSMENTGRADINGID`),
  KEY `SAM_PUBLISHEDASSESSMENT_I` (`PUBLISHEDASSESSMENTID`),
  KEY `SAM_ASSGRAD_AID_PUBASSEID_T` (`AGENTID`,`PUBLISHEDASSESSMENTID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sam_assessmentgrading_t`
--

LOCK TABLES `sam_assessmentgrading_t` WRITE;
/*!40000 ALTER TABLE `sam_assessmentgrading_t` DISABLE KEYS */;
/*!40000 ALTER TABLE `sam_assessmentgrading_t` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sam_assessmetadata_t`
--

DROP TABLE IF EXISTS `sam_assessmetadata_t`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sam_assessmetadata_t` (
  `ASSESSMENTMETADATAID` bigint(20) NOT NULL AUTO_INCREMENT,
  `ASSESSMENTID` bigint(20) NOT NULL,
  `LABEL` varchar(255) NOT NULL,
  `ENTRY` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`ASSESSMENTMETADATAID`),
  KEY `FK7E6F9A28694216CC` (`ASSESSMENTID`),
  CONSTRAINT `FK7E6F9A28694216CC` FOREIGN KEY (`ASSESSMENTID`) REFERENCES `sam_assessmentbase_t` (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=224 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sam_assessmetadata_t`
--

LOCK TABLES `sam_assessmetadata_t` WRITE;
/*!40000 ALTER TABLE `sam_assessmetadata_t` DISABLE KEYS */;
INSERT INTO `sam_assessmetadata_t` VALUES (1,1,'finalPageURL_isInstructorEditable','true'),(2,1,'anonymousRelease_isInstructorEditable','true'),(3,1,'dueDate_isInstructorEditable','true'),(4,1,'description_isInstructorEditable','true'),(5,1,'metadataQuestions_isInstructorEditable','true'),(6,1,'bgImage_isInstructorEditable','true'),(7,1,'feedbackComponents_isInstructorEditable','true'),(8,1,'retractDate_isInstructorEditable','true'),(9,1,'feedbackType_isInstructorEditable','true'),(10,1,'timedAssessmentAutoSubmit_isInstructorEditable','true'),(11,1,'toGradebook_isInstructorEditable','true'),(12,1,'displayChunking_isInstructorEditable','true'),(13,1,'recordedScore_isInstructorEditable','true'),(14,1,'authenticatedRelease_isInstructorEditable','true'),(15,1,'displayNumbering_isInstructorEditable','true'),(16,1,'submissionMessage_isInstructorEditable','true'),(17,1,'releaseDate_isInstructorEditable','true'),(18,1,'assessmentAuthor_isInstructorEditable','true'),(19,1,'passwordRequired_isInstructorEditable','true'),(20,1,'author',''),(21,1,'submissionModel_isInstructorEditable','true'),(22,1,'ipAccessType_isInstructorEditable','true'),(23,1,'timedAssessment_isInstructorEditable','true'),(24,1,'metadataAssess_isInstructorEditable','true'),(25,1,'bgColor_isInstructorEditable','true'),(26,1,'testeeIdentity_isInstructorEditable','true'),(27,1,'templateInfo_isInstructorEditable','true'),(28,1,'itemAccessType_isInstructorEditable','true'),(29,1,'lateHandling_isInstructorEditable','true'),(30,1,'feedbackAuthoring_isInstructorEditable','true'),(31,1,'releaseTo','SITE_MEMBERS'),(32,2,'finalPageURL_isInstructorEditable','true'),(33,2,'anonymousRelease_isInstructorEditable','true'),(34,2,'dueDate_isInstructorEditable','true'),(35,2,'description_isInstructorEditable','true'),(36,2,'metadataQuestions_isInstructorEditable','true'),(37,2,'bgImage_isInstructorEditable','true'),(38,2,'feedbackComponents_isInstructorEditable','true'),(39,2,'retractDate_isInstructorEditable','true'),(40,2,'feedbackType_isInstructorEditable','true'),(41,2,'timedAssessmentAutoSubmit_isInstructorEditable','true'),(42,2,'toGradebook_isInstructorEditable','false'),(43,2,'displayChunking_isInstructorEditable','true'),(44,2,'recordedScore_isInstructorEditable','false'),(45,2,'authenticatedRelease_isInstructorEditable','true'),(46,2,'displayNumbering_isInstructorEditable','true'),(47,2,'submissionMessage_isInstructorEditable','true'),(48,2,'releaseDate_isInstructorEditable','true'),(49,2,'assessmentAuthor_isInstructorEditable','true'),(50,2,'passwordRequired_isInstructorEditable','false'),(51,2,'author',''),(52,2,'submissionModel_isInstructorEditable','true'),(53,2,'ipAccessType_isInstructorEditable','false'),(54,2,'timedAssessment_isInstructorEditable','true'),(55,2,'metadataAssess_isInstructorEditable','true'),(56,2,'bgColor_isInstructorEditable','true'),(57,2,'testeeIdentity_isInstructorEditable','false'),(58,2,'templateInfo_isInstructorEditable','true'),(59,2,'itemAccessType_isInstructorEditable','true'),(60,2,'lateHandling_isInstructorEditable','false'),(61,2,'feedbackAuthoring_isInstructorEditable','true'),(62,2,'releaseTo','SITE_MEMBERS'),(63,3,'finalPageURL_isInstructorEditable','true'),(64,3,'anonymousRelease_isInstructorEditable','false'),(65,3,'dueDate_isInstructorEditable','true'),(66,3,'description_isInstructorEditable','true'),(67,3,'metadataQuestions_isInstructorEditable','true'),(68,3,'bgImage_isInstructorEditable','true'),(69,3,'feedbackComponents_isInstructorEditable','true'),(70,3,'retractDate_isInstructorEditable','true'),(71,3,'feedbackType_isInstructorEditable','true'),(72,3,'timedAssessmentAutoSubmit_isInstructorEditable','false'),(73,3,'toGradebook_isInstructorEditable','true'),(74,3,'displayChunking_isInstructorEditable','true'),(75,3,'recordedScore_isInstructorEditable','false'),(76,3,'authenticatedRelease_isInstructorEditable','true'),(77,3,'displayNumbering_isInstructorEditable','true'),(78,3,'submissionMessage_isInstructorEditable','true'),(79,3,'releaseDate_isInstructorEditable','true'),(80,3,'assessmentAuthor_isInstructorEditable','true'),(81,3,'passwordRequired_isInstructorEditable','false'),(82,3,'author',''),(83,3,'submissionModel_isInstructorEditable','true'),(84,3,'ipAccessType_isInstructorEditable','false'),(85,3,'timedAssessment_isInstructorEditable','false'),(86,3,'metadataAssess_isInstructorEditable','true'),(87,3,'bgColor_isInstructorEditable','true'),(88,3,'testeeIdentity_isInstructorEditable','true'),(89,3,'templateInfo_isInstructorEditable','true'),(90,3,'itemAccessType_isInstructorEditable','true'),(91,3,'lateHandling_isInstructorEditable','true'),(92,3,'feedbackAuthoring_isInstructorEditable','true'),(93,3,'releaseTo','SITE_MEMBERS'),(94,4,'finalPageURL_isInstructorEditable','true'),(95,4,'anonymousRelease_isInstructorEditable','false'),(96,4,'dueDate_isInstructorEditable','true'),(97,4,'description_isInstructorEditable','true'),(98,4,'metadataQuestions_isInstructorEditable','true'),(99,4,'bgImage_isInstructorEditable','true'),(100,4,'feedbackComponents_isInstructorEditable','true'),(101,4,'retractDate_isInstructorEditable','true'),(102,4,'feedbackType_isInstructorEditable','true'),(103,4,'timedAssessmentAutoSubmit_isInstructorEditable','false'),(104,4,'toGradebook_isInstructorEditable','true'),(105,4,'displayChunking_isInstructorEditable','true'),(106,4,'recordedScore_isInstructorEditable','true'),(107,4,'authenticatedRelease_isInstructorEditable','true'),(108,4,'displayNumbering_isInstructorEditable','true'),(109,4,'submissionMessage_isInstructorEditable','true'),(110,4,'releaseDate_isInstructorEditable','true'),(111,4,'assessmentAuthor_isInstructorEditable','true'),(112,4,'passwordRequired_isInstructorEditable','false'),(113,4,'author',''),(114,4,'submissionModel_isInstructorEditable','true'),(115,4,'ipAccessType_isInstructorEditable','false'),(116,4,'timedAssessment_isInstructorEditable','false'),(117,4,'metadataAssess_isInstructorEditable','true'),(118,4,'bgColor_isInstructorEditable','true'),(119,4,'testeeIdentity_isInstructorEditable','true'),(120,4,'templateInfo_isInstructorEditable','true'),(121,4,'itemAccessType_isInstructorEditable','true'),(122,4,'lateHandling_isInstructorEditable','true'),(123,4,'feedbackAuthoring_isInstructorEditable','true'),(124,4,'releaseTo','SITE_MEMBERS'),(125,5,'finalPageURL_isInstructorEditable','true'),(126,5,'anonymousRelease_isInstructorEditable','true'),(127,5,'dueDate_isInstructorEditable','true'),(128,5,'description_isInstructorEditable','true'),(129,5,'metadataQuestions_isInstructorEditable','true'),(130,5,'bgImage_isInstructorEditable','true'),(131,5,'feedbackComponents_isInstructorEditable','true'),(132,5,'retractDate_isInstructorEditable','true'),(133,5,'feedbackType_isInstructorEditable','true'),(134,5,'timedAssessmentAutoSubmit_isInstructorEditable','false'),(135,5,'toGradebook_isInstructorEditable','true'),(136,5,'displayChunking_isInstructorEditable','true'),(137,5,'recordedScore_isInstructorEditable','false'),(138,5,'authenticatedRelease_isInstructorEditable','false'),(139,5,'displayNumbering_isInstructorEditable','true'),(140,5,'submissionMessage_isInstructorEditable','true'),(141,5,'releaseDate_isInstructorEditable','true'),(142,5,'assessmentAuthor_isInstructorEditable','true'),(143,5,'passwordRequired_isInstructorEditable','false'),(144,5,'author',''),(145,5,'submissionModel_isInstructorEditable','true'),(146,5,'ipAccessType_isInstructorEditable','false'),(147,5,'timedAssessment_isInstructorEditable','false'),(148,5,'metadataAssess_isInstructorEditable','true'),(149,5,'bgColor_isInstructorEditable','true'),(150,5,'testeeIdentity_isInstructorEditable','true'),(151,5,'templateInfo_isInstructorEditable','true'),(152,5,'itemAccessType_isInstructorEditable','true'),(153,5,'lateHandling_isInstructorEditable','false'),(154,5,'feedbackAuthoring_isInstructorEditable','false'),(155,5,'releaseTo','SITE_MEMBERS'),(156,6,'finalPageURL_isInstructorEditable','true'),(157,6,'anonymousRelease_isInstructorEditable','false'),(158,6,'dueDate_isInstructorEditable','true'),(159,6,'description_isInstructorEditable','true'),(160,6,'metadataQuestions_isInstructorEditable','true'),(161,6,'bgImage_isInstructorEditable','true'),(162,6,'feedbackComponents_isInstructorEditable','true'),(163,6,'retractDate_isInstructorEditable','true'),(164,6,'feedbackType_isInstructorEditable','true'),(165,6,'timedAssessmentAutoSubmit_isInstructorEditable','false'),(166,6,'toGradebook_isInstructorEditable','true'),(167,6,'displayChunking_isInstructorEditable','true'),(168,6,'recordedScore_isInstructorEditable','false'),(169,6,'authenticatedRelease_isInstructorEditable','false'),(170,6,'displayNumbering_isInstructorEditable','true'),(171,6,'submissionMessage_isInstructorEditable','true'),(172,6,'releaseDate_isInstructorEditable','true'),(173,6,'assessmentAuthor_isInstructorEditable','true'),(174,6,'passwordRequired_isInstructorEditable','true'),(175,6,'author',''),(176,6,'submissionModel_isInstructorEditable','true'),(177,6,'ipAccessType_isInstructorEditable','false'),(178,6,'timedAssessment_isInstructorEditable','false'),(179,6,'metadataAssess_isInstructorEditable','true'),(180,6,'bgColor_isInstructorEditable','true'),(181,6,'testeeIdentity_isInstructorEditable','true'),(182,6,'templateInfo_isInstructorEditable','true'),(183,6,'itemAccessType_isInstructorEditable','true'),(184,6,'lateHandling_isInstructorEditable','true'),(185,6,'feedbackAuthoring_isInstructorEditable','true'),(186,6,'releaseTo','SITE_MEMBERS'),(187,7,'finalPageURL_isInstructorEditable','true'),(188,7,'anonymousRelease_isInstructorEditable','false'),(189,7,'dueDate_isInstructorEditable','true'),(190,7,'description_isInstructorEditable','true'),(191,7,'metadataQuestions_isInstructorEditable','true'),(192,7,'bgImage_isInstructorEditable','true'),(193,7,'feedbackComponents_isInstructorEditable','true'),(194,7,'retractDate_isInstructorEditable','true'),(195,7,'feedbackType_isInstructorEditable','true'),(196,7,'timedAssessmentAutoSubmit_isInstructorEditable','true'),(197,7,'toGradebook_isInstructorEditable','true'),(198,7,'displayChunking_isInstructorEditable','true'),(199,7,'recordedScore_isInstructorEditable','false'),(200,7,'authenticatedRelease_isInstructorEditable','false'),(201,7,'displayNumbering_isInstructorEditable','true'),(202,7,'submissionMessage_isInstructorEditable','true'),(203,7,'releaseDate_isInstructorEditable','true'),(204,7,'assessmentAuthor_isInstructorEditable','true'),(205,7,'passwordRequired_isInstructorEditable','true'),(206,7,'author',''),(207,7,'submissionModel_isInstructorEditable','true'),(208,7,'ipAccessType_isInstructorEditable','false'),(209,7,'timedAssessment_isInstructorEditable','true'),(210,7,'metadataAssess_isInstructorEditable','true'),(211,7,'bgColor_isInstructorEditable','true'),(212,7,'testeeIdentity_isInstructorEditable','true'),(213,7,'templateInfo_isInstructorEditable','true'),(214,7,'itemAccessType_isInstructorEditable','true'),(215,7,'lateHandling_isInstructorEditable','true'),(216,7,'feedbackAuthoring_isInstructorEditable','true'),(217,7,'releaseTo','SITE_MEMBERS'),(218,1,'markForReview_isInstructorEditable','true'),(219,2,'markForReview_isInstructorEditable','true'),(220,3,'markForReview_isInstructorEditable','true'),(221,4,'markForReview_isInstructorEditable','true'),(222,6,'markForReview_isInstructorEditable','true'),(223,7,'markForReview_isInstructorEditable','true');
/*!40000 ALTER TABLE `sam_assessmetadata_t` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sam_attachment_t`
--

DROP TABLE IF EXISTS `sam_attachment_t`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sam_attachment_t` (
  `ATTACHMENTID` bigint(20) NOT NULL AUTO_INCREMENT,
  `ATTACHMENTTYPE` varchar(255) NOT NULL,
  `RESOURCEID` varchar(255) DEFAULT NULL,
  `FILENAME` varchar(255) DEFAULT NULL,
  `MIMETYPE` varchar(80) DEFAULT NULL,
  `FILESIZE` bigint(20) DEFAULT NULL,
  `DESCRIPTION` varchar(4000) DEFAULT NULL,
  `LOCATION` varchar(4000) DEFAULT NULL,
  `ISLINK` bit(1) DEFAULT NULL,
  `STATUS` int(11) NOT NULL,
  `CREATEDBY` varchar(255) NOT NULL,
  `CREATEDDATE` datetime NOT NULL,
  `LASTMODIFIEDBY` varchar(255) NOT NULL,
  `LASTMODIFIEDDATE` datetime NOT NULL,
  `ASSESSMENTID` bigint(20) DEFAULT NULL,
  `SECTIONID` bigint(20) DEFAULT NULL,
  `ITEMID` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`ATTACHMENTID`),
  KEY `FK99FA8CB83288DBBD` (`ITEMID`),
  KEY `FK99FA8CB870CE2BD` (`SECTIONID`),
  KEY `FK99FA8CB8CAC2365B` (`ASSESSMENTID`),
  CONSTRAINT `FK99FA8CB8CAC2365B` FOREIGN KEY (`ASSESSMENTID`) REFERENCES `sam_assessmentbase_t` (`ID`),
  CONSTRAINT `FK99FA8CB83288DBBD` FOREIGN KEY (`ITEMID`) REFERENCES `sam_item_t` (`ITEMID`),
  CONSTRAINT `FK99FA8CB870CE2BD` FOREIGN KEY (`SECTIONID`) REFERENCES `sam_section_t` (`SECTIONID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sam_attachment_t`
--

LOCK TABLES `sam_attachment_t` WRITE;
/*!40000 ALTER TABLE `sam_attachment_t` DISABLE KEYS */;
/*!40000 ALTER TABLE `sam_attachment_t` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sam_authzdata_t`
--

DROP TABLE IF EXISTS `sam_authzdata_t`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sam_authzdata_t` (
  `ID` bigint(20) NOT NULL AUTO_INCREMENT,
  `lockId` int(11) NOT NULL,
  `AGENTID` varchar(255) NOT NULL,
  `FUNCTIONID` varchar(36) NOT NULL,
  `QUALIFIERID` varchar(36) NOT NULL,
  `EFFECTIVEDATE` date DEFAULT NULL,
  `EXPIRATIONDATE` date DEFAULT NULL,
  `LASTMODIFIEDBY` varchar(255) NOT NULL,
  `LASTMODIFIEDDATE` date NOT NULL,
  `ISEXPLICIT` bit(1) DEFAULT NULL,
  PRIMARY KEY (`ID`),
  UNIQUE KEY `AGENTID` (`AGENTID`,`FUNCTIONID`,`QUALIFIERID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sam_authzdata_t`
--

LOCK TABLES `sam_authzdata_t` WRITE;
/*!40000 ALTER TABLE `sam_authzdata_t` DISABLE KEYS */;
/*!40000 ALTER TABLE `sam_authzdata_t` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sam_functiondata_t`
--

DROP TABLE IF EXISTS `sam_functiondata_t`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sam_functiondata_t` (
  `FUNCTIONID` bigint(20) NOT NULL AUTO_INCREMENT,
  `REFERENCENAME` varchar(255) NOT NULL,
  `DISPLAYNAME` varchar(255) DEFAULT NULL,
  `DESCRIPTION` varchar(4000) DEFAULT NULL,
  `FUNCTIONTYPEID` varchar(4000) DEFAULT NULL,
  PRIMARY KEY (`FUNCTIONID`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sam_functiondata_t`
--

LOCK TABLES `sam_functiondata_t` WRITE;
/*!40000 ALTER TABLE `sam_functiondata_t` DISABLE KEYS */;
INSERT INTO `sam_functiondata_t` VALUES (1,'take.published.assessment','Take Assessment','Take Assessment','81'),(2,'view.published.assessment','View Assessment','View Assessment','81'),(3,'submit.assessment','Submit Assessment','Submit Assessment','81'),(4,'submit.assessment.forgrade','Submit Assessment For Grade','Submit Assessment For Grade','81');
/*!40000 ALTER TABLE `sam_functiondata_t` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sam_gradingattachment_t`
--

DROP TABLE IF EXISTS `sam_gradingattachment_t`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sam_gradingattachment_t` (
  `ATTACHMENTID` bigint(20) NOT NULL AUTO_INCREMENT,
  `ATTACHMENTTYPE` varchar(255) NOT NULL,
  `RESOURCEID` varchar(255) DEFAULT NULL,
  `FILENAME` varchar(255) DEFAULT NULL,
  `MIMETYPE` varchar(80) DEFAULT NULL,
  `FILESIZE` bigint(20) DEFAULT NULL,
  `DESCRIPTION` varchar(4000) DEFAULT NULL,
  `LOCATION` varchar(4000) DEFAULT NULL,
  `ISLINK` bit(1) DEFAULT NULL,
  `STATUS` int(11) NOT NULL,
  `CREATEDBY` varchar(255) NOT NULL,
  `CREATEDDATE` datetime NOT NULL,
  `LASTMODIFIEDBY` varchar(255) NOT NULL,
  `LASTMODIFIEDDATE` datetime NOT NULL,
  `ITEMGRADINGID` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`ATTACHMENTID`),
  KEY `FK28156C6C4D7EA7B3` (`ITEMGRADINGID`),
  CONSTRAINT `FK28156C6C4D7EA7B3` FOREIGN KEY (`ITEMGRADINGID`) REFERENCES `sam_itemgrading_t` (`ITEMGRADINGID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sam_gradingattachment_t`
--

LOCK TABLES `sam_gradingattachment_t` WRITE;
/*!40000 ALTER TABLE `sam_gradingattachment_t` DISABLE KEYS */;
/*!40000 ALTER TABLE `sam_gradingattachment_t` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sam_gradingsummary_t`
--

DROP TABLE IF EXISTS `sam_gradingsummary_t`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sam_gradingsummary_t` (
  `ASSESSMENTGRADINGSUMMARYID` bigint(20) NOT NULL AUTO_INCREMENT,
  `PUBLISHEDASSESSMENTID` bigint(20) NOT NULL,
  `AGENTID` varchar(255) NOT NULL,
  `TOTALSUBMITTED` int(11) DEFAULT NULL,
  `TOTALSUBMITTEDFORGRADE` int(11) DEFAULT NULL,
  `LASTSUBMITTEDDATE` datetime DEFAULT NULL,
  `LASTSUBMITTEDASSESSMENTISLATE` bit(1) NOT NULL,
  `SUMOF_AUTOSCOREFORGRADE` float DEFAULT NULL,
  `AVERAGE_AUTOSCOREFORGRADE` float DEFAULT NULL,
  `HIGHEST_AUTOSCOREFORGRADE` float DEFAULT NULL,
  `LOWEST_AUTOSCOREFORGRADE` float DEFAULT NULL,
  `LAST_AUTOSCOREFORGRADE` float DEFAULT NULL,
  `SUMOF_OVERRIDESCOREFORGRADE` float DEFAULT NULL,
  `AVERAGE_OVERRIDESCOREFORGRADE` float DEFAULT NULL,
  `HIGHEST_OVERRIDESCOREFORGRADE` float DEFAULT NULL,
  `LOWEST_OVERRIDESCOREFORGRADE` float DEFAULT NULL,
  `LAST_OVERRIDESCOREFORGRADE` float DEFAULT NULL,
  `SCORINGTYPE` int(11) DEFAULT NULL,
  `ACCEPTEDASSESSMENTISLATE` bit(1) DEFAULT NULL,
  `FINALASSESSMENTSCORE` float DEFAULT NULL,
  `FEEDTOGRADEBOOK` bit(1) DEFAULT NULL,
  PRIMARY KEY (`ASSESSMENTGRADINGSUMMARYID`),
  KEY `FKBC88AA27D02EF633` (`PUBLISHEDASSESSMENTID`),
  CONSTRAINT `FKBC88AA27D02EF633` FOREIGN KEY (`PUBLISHEDASSESSMENTID`) REFERENCES `sam_publishedassessment_t` (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sam_gradingsummary_t`
--

LOCK TABLES `sam_gradingsummary_t` WRITE;
/*!40000 ALTER TABLE `sam_gradingsummary_t` DISABLE KEYS */;
/*!40000 ALTER TABLE `sam_gradingsummary_t` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sam_item_t`
--

DROP TABLE IF EXISTS `sam_item_t`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sam_item_t` (
  `ITEMID` bigint(20) NOT NULL AUTO_INCREMENT,
  `SECTIONID` bigint(20) DEFAULT NULL,
  `ITEMIDSTRING` varchar(255) DEFAULT NULL,
  `SEQUENCE` int(11) DEFAULT NULL,
  `DURATION` int(11) DEFAULT NULL,
  `TRIESALLOWED` int(11) DEFAULT NULL,
  `INSTRUCTION` varchar(4000) DEFAULT NULL,
  `DESCRIPTION` varchar(4000) DEFAULT NULL,
  `TYPEID` bigint(20) NOT NULL,
  `GRADE` varchar(80) DEFAULT NULL,
  `SCORE` float DEFAULT NULL,
  `PARTIAL_CREDIT_FLAG` bit(1) DEFAULT NULL,
  `DISCOUNT` float DEFAULT NULL,
  `HINT` varchar(4000) DEFAULT NULL,
  `HASRATIONALE` bit(1) DEFAULT NULL,
  `STATUS` int(11) NOT NULL,
  `CREATEDBY` varchar(255) NOT NULL,
  `CREATEDDATE` datetime NOT NULL,
  `LASTMODIFIEDBY` varchar(255) NOT NULL,
  `LASTMODIFIEDDATE` datetime NOT NULL,
  PRIMARY KEY (`ITEMID`),
  KEY `FK3AAC5EA870CE2BD` (`SECTIONID`),
  CONSTRAINT `FK3AAC5EA870CE2BD` FOREIGN KEY (`SECTIONID`) REFERENCES `sam_section_t` (`SECTIONID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sam_item_t`
--

LOCK TABLES `sam_item_t` WRITE;
/*!40000 ALTER TABLE `sam_item_t` DISABLE KEYS */;
/*!40000 ALTER TABLE `sam_item_t` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sam_itemfeedback_t`
--

DROP TABLE IF EXISTS `sam_itemfeedback_t`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sam_itemfeedback_t` (
  `ITEMFEEDBACKID` bigint(20) NOT NULL AUTO_INCREMENT,
  `ITEMID` bigint(20) NOT NULL,
  `TYPEID` varchar(255) NOT NULL,
  `TEXT` varchar(4000) DEFAULT NULL,
  PRIMARY KEY (`ITEMFEEDBACKID`),
  KEY `FK3254E9ED3288DBBD` (`ITEMID`),
  CONSTRAINT `FK3254E9ED3288DBBD` FOREIGN KEY (`ITEMID`) REFERENCES `sam_item_t` (`ITEMID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sam_itemfeedback_t`
--

LOCK TABLES `sam_itemfeedback_t` WRITE;
/*!40000 ALTER TABLE `sam_itemfeedback_t` DISABLE KEYS */;
/*!40000 ALTER TABLE `sam_itemfeedback_t` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sam_itemgrading_t`
--

DROP TABLE IF EXISTS `sam_itemgrading_t`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sam_itemgrading_t` (
  `ITEMGRADINGID` bigint(20) NOT NULL AUTO_INCREMENT,
  `ASSESSMENTGRADINGID` bigint(20) NOT NULL,
  `PUBLISHEDITEMID` bigint(20) NOT NULL,
  `PUBLISHEDITEMTEXTID` bigint(20) NOT NULL,
  `AGENTID` varchar(255) NOT NULL,
  `SUBMITTEDDATE` datetime DEFAULT NULL,
  `PUBLISHEDANSWERID` bigint(20) DEFAULT NULL,
  `RATIONALE` varchar(4000) DEFAULT NULL,
  `ANSWERTEXT` varchar(4000) DEFAULT NULL,
  `AUTOSCORE` float DEFAULT NULL,
  `OVERRIDESCORE` float DEFAULT NULL,
  `COMMENTS` varchar(4000) DEFAULT NULL,
  `GRADEDBY` varchar(255) DEFAULT NULL,
  `GRADEDDATE` datetime DEFAULT NULL,
  `REVIEW` bit(1) DEFAULT NULL,
  `ATTEMPTSREMAINING` int(11) DEFAULT NULL,
  `LASTDURATION` varchar(36) DEFAULT NULL,
  PRIMARY KEY (`ITEMGRADINGID`),
  KEY `FKB68E675667B430D5` (`ASSESSMENTGRADINGID`),
  KEY `SAM_ITEMGRADING_ITEM_I` (`PUBLISHEDITEMID`),
  KEY `SAM_ITEMGRADING_ITEMTEXT_I` (`PUBLISHEDITEMTEXTID`),
  KEY `SAM_ITEMGRADING_PUBANS_I` (`PUBLISHEDANSWERID`),
  CONSTRAINT `FKB68E675667B430D5` FOREIGN KEY (`ASSESSMENTGRADINGID`) REFERENCES `sam_assessmentgrading_t` (`ASSESSMENTGRADINGID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sam_itemgrading_t`
--

LOCK TABLES `sam_itemgrading_t` WRITE;
/*!40000 ALTER TABLE `sam_itemgrading_t` DISABLE KEYS */;
/*!40000 ALTER TABLE `sam_itemgrading_t` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sam_itemmetadata_t`
--

DROP TABLE IF EXISTS `sam_itemmetadata_t`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sam_itemmetadata_t` (
  `ITEMMETADATAID` bigint(20) NOT NULL AUTO_INCREMENT,
  `ITEMID` bigint(20) NOT NULL,
  `LABEL` varchar(255) NOT NULL,
  `ENTRY` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`ITEMMETADATAID`),
  KEY `FK5B4737173288DBBD` (`ITEMID`),
  CONSTRAINT `FK5B4737173288DBBD` FOREIGN KEY (`ITEMID`) REFERENCES `sam_item_t` (`ITEMID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sam_itemmetadata_t`
--

LOCK TABLES `sam_itemmetadata_t` WRITE;
/*!40000 ALTER TABLE `sam_itemmetadata_t` DISABLE KEYS */;
/*!40000 ALTER TABLE `sam_itemmetadata_t` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sam_itemtext_t`
--

DROP TABLE IF EXISTS `sam_itemtext_t`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sam_itemtext_t` (
  `ITEMTEXTID` bigint(20) NOT NULL AUTO_INCREMENT,
  `ITEMID` bigint(20) NOT NULL,
  `SEQUENCE` bigint(20) NOT NULL,
  `TEXT` varchar(4000) DEFAULT NULL,
  PRIMARY KEY (`ITEMTEXTID`),
  KEY `FK271D63153288DBBD` (`ITEMID`),
  CONSTRAINT `FK271D63153288DBBD` FOREIGN KEY (`ITEMID`) REFERENCES `sam_item_t` (`ITEMID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sam_itemtext_t`
--

LOCK TABLES `sam_itemtext_t` WRITE;
/*!40000 ALTER TABLE `sam_itemtext_t` DISABLE KEYS */;
/*!40000 ALTER TABLE `sam_itemtext_t` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sam_media_t`
--

DROP TABLE IF EXISTS `sam_media_t`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sam_media_t` (
  `MEDIAID` bigint(20) NOT NULL AUTO_INCREMENT,
  `ITEMGRADINGID` bigint(20) DEFAULT NULL,
  `MEDIA` longblob,
  `FILESIZE` bigint(20) DEFAULT NULL,
  `MIMETYPE` varchar(80) DEFAULT NULL,
  `DESCRIPTION` varchar(4000) DEFAULT NULL,
  `LOCATION` varchar(255) DEFAULT NULL,
  `FILENAME` varchar(255) DEFAULT NULL,
  `ISLINK` bit(1) DEFAULT NULL,
  `ISHTMLINLINE` bit(1) DEFAULT NULL,
  `STATUS` int(11) DEFAULT NULL,
  `CREATEDBY` varchar(255) DEFAULT NULL,
  `CREATEDDATE` datetime DEFAULT NULL,
  `LASTMODIFIEDBY` varchar(255) DEFAULT NULL,
  `LASTMODIFIEDDATE` datetime DEFAULT NULL,
  `DURATION` varchar(36) DEFAULT NULL,
  PRIMARY KEY (`MEDIAID`),
  KEY `FKD4CF5A194D7EA7B3` (`ITEMGRADINGID`),
  CONSTRAINT `FKD4CF5A194D7EA7B3` FOREIGN KEY (`ITEMGRADINGID`) REFERENCES `sam_itemgrading_t` (`ITEMGRADINGID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sam_media_t`
--

LOCK TABLES `sam_media_t` WRITE;
/*!40000 ALTER TABLE `sam_media_t` DISABLE KEYS */;
/*!40000 ALTER TABLE `sam_media_t` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sam_publishedaccesscontrol_t`
--

DROP TABLE IF EXISTS `sam_publishedaccesscontrol_t`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sam_publishedaccesscontrol_t` (
  `ASSESSMENTID` bigint(20) NOT NULL,
  `UNLIMITEDSUBMISSIONS` bit(1) DEFAULT NULL,
  `SUBMISSIONSALLOWED` int(11) DEFAULT NULL,
  `SUBMISSIONSSAVED` int(11) DEFAULT NULL,
  `ASSESSMENTFORMAT` int(11) DEFAULT NULL,
  `BOOKMARKINGITEM` int(11) DEFAULT NULL,
  `TIMELIMIT` int(11) DEFAULT NULL,
  `TIMEDASSESSMENT` int(11) DEFAULT NULL,
  `RETRYALLOWED` int(11) DEFAULT NULL,
  `LATEHANDLING` int(11) DEFAULT NULL,
  `STARTDATE` datetime DEFAULT NULL,
  `DUEDATE` datetime DEFAULT NULL,
  `SCOREDATE` datetime DEFAULT NULL,
  `FEEDBACKDATE` datetime DEFAULT NULL,
  `RETRACTDATE` datetime DEFAULT NULL,
  `AUTOSUBMIT` int(11) DEFAULT NULL,
  `ITEMNAVIGATION` int(11) DEFAULT NULL,
  `ITEMNUMBERING` int(11) DEFAULT NULL,
  `SUBMISSIONMESSAGE` varchar(4000) DEFAULT NULL,
  `RELEASETO` varchar(255) DEFAULT NULL,
  `USERNAME` varchar(255) DEFAULT NULL,
  `PASSWORD` varchar(255) DEFAULT NULL,
  `FINALPAGEURL` varchar(1023) DEFAULT NULL,
  `MARKFORREVIEW` int(11) DEFAULT NULL,
  PRIMARY KEY (`ASSESSMENTID`),
  KEY `FK2EDF39E09482C945` (`ASSESSMENTID`),
  CONSTRAINT `FK2EDF39E09482C945` FOREIGN KEY (`ASSESSMENTID`) REFERENCES `sam_publishedassessment_t` (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sam_publishedaccesscontrol_t`
--

LOCK TABLES `sam_publishedaccesscontrol_t` WRITE;
/*!40000 ALTER TABLE `sam_publishedaccesscontrol_t` DISABLE KEYS */;
/*!40000 ALTER TABLE `sam_publishedaccesscontrol_t` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sam_publishedanswer_t`
--

DROP TABLE IF EXISTS `sam_publishedanswer_t`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sam_publishedanswer_t` (
  `ANSWERID` bigint(20) NOT NULL AUTO_INCREMENT,
  `ITEMTEXTID` bigint(20) NOT NULL,
  `ITEMID` bigint(20) NOT NULL,
  `TEXT` varchar(4000) DEFAULT NULL,
  `SEQUENCE` bigint(20) NOT NULL,
  `LABEL` varchar(20) DEFAULT NULL,
  `ISCORRECT` bit(1) DEFAULT NULL,
  `GRADE` varchar(80) DEFAULT NULL,
  `SCORE` float DEFAULT NULL,
  `PARTIAL_CREDIT` float DEFAULT NULL,
  `DISCOUNT` float DEFAULT NULL,
  PRIMARY KEY (`ANSWERID`),
  KEY `FKB41EA36131446627` (`ITEMID`),
  KEY `FKB41EA36126460817` (`ITEMTEXTID`),
  CONSTRAINT `FKB41EA36126460817` FOREIGN KEY (`ITEMTEXTID`) REFERENCES `sam_publisheditemtext_t` (`ITEMTEXTID`),
  CONSTRAINT `FKB41EA36131446627` FOREIGN KEY (`ITEMID`) REFERENCES `sam_publisheditem_t` (`ITEMID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sam_publishedanswer_t`
--

LOCK TABLES `sam_publishedanswer_t` WRITE;
/*!40000 ALTER TABLE `sam_publishedanswer_t` DISABLE KEYS */;
/*!40000 ALTER TABLE `sam_publishedanswer_t` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sam_publishedanswerfeedback_t`
--

DROP TABLE IF EXISTS `sam_publishedanswerfeedback_t`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sam_publishedanswerfeedback_t` (
  `ANSWERFEEDBACKID` bigint(20) NOT NULL AUTO_INCREMENT,
  `ANSWERID` bigint(20) NOT NULL,
  `TYPEID` varchar(255) DEFAULT NULL,
  `TEXT` varchar(4000) DEFAULT NULL,
  PRIMARY KEY (`ANSWERFEEDBACKID`),
  KEY `FK6CB765A624D77573` (`ANSWERID`),
  CONSTRAINT `FK6CB765A624D77573` FOREIGN KEY (`ANSWERID`) REFERENCES `sam_publishedanswer_t` (`ANSWERID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sam_publishedanswerfeedback_t`
--

LOCK TABLES `sam_publishedanswerfeedback_t` WRITE;
/*!40000 ALTER TABLE `sam_publishedanswerfeedback_t` DISABLE KEYS */;
/*!40000 ALTER TABLE `sam_publishedanswerfeedback_t` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sam_publishedassessment_t`
--

DROP TABLE IF EXISTS `sam_publishedassessment_t`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sam_publishedassessment_t` (
  `ID` bigint(20) NOT NULL AUTO_INCREMENT,
  `TITLE` varchar(255) DEFAULT NULL,
  `ASSESSMENTID` bigint(20) DEFAULT NULL,
  `DESCRIPTION` varchar(4000) DEFAULT NULL,
  `COMMENTS` varchar(255) DEFAULT NULL,
  `TYPEID` bigint(20) DEFAULT NULL,
  `INSTRUCTORNOTIFICATION` int(11) DEFAULT NULL,
  `TESTEENOTIFICATION` int(11) DEFAULT NULL,
  `MULTIPARTALLOWED` int(11) DEFAULT NULL,
  `STATUS` int(11) NOT NULL,
  `CREATEDBY` varchar(255) NOT NULL,
  `CREATEDDATE` datetime NOT NULL,
  `LASTMODIFIEDBY` varchar(255) NOT NULL,
  `LASTMODIFIEDDATE` datetime NOT NULL,
  `LASTNEEDRESUBMITDATE` datetime DEFAULT NULL,
  PRIMARY KEY (`ID`),
  KEY `SAM_PUBA_ASSESSMENT_I` (`ASSESSMENTID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sam_publishedassessment_t`
--

LOCK TABLES `sam_publishedassessment_t` WRITE;
/*!40000 ALTER TABLE `sam_publishedassessment_t` DISABLE KEYS */;
/*!40000 ALTER TABLE `sam_publishedassessment_t` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sam_publishedattachment_t`
--

DROP TABLE IF EXISTS `sam_publishedattachment_t`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sam_publishedattachment_t` (
  `ATTACHMENTID` bigint(20) NOT NULL AUTO_INCREMENT,
  `ATTACHMENTTYPE` varchar(255) NOT NULL,
  `RESOURCEID` varchar(255) DEFAULT NULL,
  `FILENAME` varchar(255) DEFAULT NULL,
  `MIMETYPE` varchar(80) DEFAULT NULL,
  `FILESIZE` bigint(20) DEFAULT NULL,
  `DESCRIPTION` varchar(4000) DEFAULT NULL,
  `LOCATION` varchar(4000) DEFAULT NULL,
  `ISLINK` bit(1) DEFAULT NULL,
  `STATUS` int(11) NOT NULL,
  `CREATEDBY` varchar(255) NOT NULL,
  `CREATEDDATE` datetime NOT NULL,
  `LASTMODIFIEDBY` varchar(255) NOT NULL,
  `LASTMODIFIEDDATE` datetime NOT NULL,
  `ASSESSMENTID` bigint(20) DEFAULT NULL,
  `SECTIONID` bigint(20) DEFAULT NULL,
  `ITEMID` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`ATTACHMENTID`),
  KEY `FK2709988631446627` (`ITEMID`),
  KEY `FK27099886895D4813` (`SECTIONID`),
  KEY `FK270998869482C945` (`ASSESSMENTID`),
  CONSTRAINT `FK270998869482C945` FOREIGN KEY (`ASSESSMENTID`) REFERENCES `sam_publishedassessment_t` (`ID`),
  CONSTRAINT `FK2709988631446627` FOREIGN KEY (`ITEMID`) REFERENCES `sam_publisheditem_t` (`ITEMID`),
  CONSTRAINT `FK27099886895D4813` FOREIGN KEY (`SECTIONID`) REFERENCES `sam_publishedsection_t` (`SECTIONID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sam_publishedattachment_t`
--

LOCK TABLES `sam_publishedattachment_t` WRITE;
/*!40000 ALTER TABLE `sam_publishedattachment_t` DISABLE KEYS */;
/*!40000 ALTER TABLE `sam_publishedattachment_t` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sam_publishedevaluation_t`
--

DROP TABLE IF EXISTS `sam_publishedevaluation_t`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sam_publishedevaluation_t` (
  `ASSESSMENTID` bigint(20) NOT NULL,
  `EVALUATIONCOMPONENTS` varchar(255) DEFAULT NULL,
  `SCORINGTYPE` int(11) DEFAULT NULL,
  `NUMERICMODELID` varchar(255) DEFAULT NULL,
  `FIXEDTOTALSCORE` int(11) DEFAULT NULL,
  `GRADEAVAILABLE` int(11) DEFAULT NULL,
  `ISSTUDENTIDPUBLIC` int(11) DEFAULT NULL,
  `ANONYMOUSGRADING` int(11) DEFAULT NULL,
  `AUTOSCORING` int(11) DEFAULT NULL,
  `TOGRADEBOOK` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`ASSESSMENTID`),
  KEY `FK94CB245F9482C945` (`ASSESSMENTID`),
  CONSTRAINT `FK94CB245F9482C945` FOREIGN KEY (`ASSESSMENTID`) REFERENCES `sam_publishedassessment_t` (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sam_publishedevaluation_t`
--

LOCK TABLES `sam_publishedevaluation_t` WRITE;
/*!40000 ALTER TABLE `sam_publishedevaluation_t` DISABLE KEYS */;
/*!40000 ALTER TABLE `sam_publishedevaluation_t` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sam_publishedfeedback_t`
--

DROP TABLE IF EXISTS `sam_publishedfeedback_t`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sam_publishedfeedback_t` (
  `ASSESSMENTID` bigint(20) NOT NULL,
  `FEEDBACKDELIVERY` int(11) DEFAULT NULL,
  `FEEDBACKAUTHORING` int(11) DEFAULT NULL,
  `EDITCOMPONENTS` int(11) DEFAULT NULL,
  `SHOWQUESTIONTEXT` bit(1) DEFAULT NULL,
  `SHOWSTUDENTRESPONSE` bit(1) DEFAULT NULL,
  `SHOWCORRECTRESPONSE` bit(1) DEFAULT NULL,
  `SHOWSTUDENTSCORE` bit(1) DEFAULT NULL,
  `SHOWSTUDENTQUESTIONSCORE` bit(1) DEFAULT NULL,
  `SHOWQUESTIONLEVELFEEDBACK` bit(1) DEFAULT NULL,
  `SHOWSELECTIONLEVELFEEDBACK` bit(1) DEFAULT NULL,
  `SHOWGRADERCOMMENTS` bit(1) DEFAULT NULL,
  `SHOWSTATISTICS` bit(1) DEFAULT NULL,
  PRIMARY KEY (`ASSESSMENTID`),
  KEY `FK1488D9E89482C945` (`ASSESSMENTID`),
  CONSTRAINT `FK1488D9E89482C945` FOREIGN KEY (`ASSESSMENTID`) REFERENCES `sam_publishedassessment_t` (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sam_publishedfeedback_t`
--

LOCK TABLES `sam_publishedfeedback_t` WRITE;
/*!40000 ALTER TABLE `sam_publishedfeedback_t` DISABLE KEYS */;
/*!40000 ALTER TABLE `sam_publishedfeedback_t` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sam_publisheditem_t`
--

DROP TABLE IF EXISTS `sam_publisheditem_t`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sam_publisheditem_t` (
  `ITEMID` bigint(20) NOT NULL AUTO_INCREMENT,
  `SECTIONID` bigint(20) NOT NULL,
  `ITEMIDSTRING` varchar(255) DEFAULT NULL,
  `SEQUENCE` int(11) DEFAULT NULL,
  `DURATION` int(11) DEFAULT NULL,
  `TRIESALLOWED` int(11) DEFAULT NULL,
  `INSTRUCTION` varchar(4000) DEFAULT NULL,
  `DESCRIPTION` varchar(4000) DEFAULT NULL,
  `TYPEID` bigint(20) NOT NULL,
  `GRADE` varchar(80) DEFAULT NULL,
  `SCORE` float DEFAULT NULL,
  `DISCOUNT` float DEFAULT NULL,
  `HINT` varchar(4000) DEFAULT NULL,
  `HASRATIONALE` bit(1) DEFAULT NULL,
  `PARTIAL_CREDIT_FLAG` bit(1) DEFAULT NULL,
  `STATUS` int(11) NOT NULL,
  `CREATEDBY` varchar(255) NOT NULL,
  `CREATEDDATE` datetime NOT NULL,
  `LASTMODIFIEDBY` varchar(255) NOT NULL,
  `LASTMODIFIEDDATE` datetime NOT NULL,
  PRIMARY KEY (`ITEMID`),
  KEY `FK53ABDCF6895D4813` (`SECTIONID`),
  CONSTRAINT `FK53ABDCF6895D4813` FOREIGN KEY (`SECTIONID`) REFERENCES `sam_publishedsection_t` (`SECTIONID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sam_publisheditem_t`
--

LOCK TABLES `sam_publisheditem_t` WRITE;
/*!40000 ALTER TABLE `sam_publisheditem_t` DISABLE KEYS */;
/*!40000 ALTER TABLE `sam_publisheditem_t` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sam_publisheditemfeedback_t`
--

DROP TABLE IF EXISTS `sam_publisheditemfeedback_t`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sam_publisheditemfeedback_t` (
  `ITEMFEEDBACKID` bigint(20) NOT NULL AUTO_INCREMENT,
  `ITEMID` bigint(20) NOT NULL,
  `TYPEID` varchar(255) NOT NULL,
  `TEXT` varchar(4000) DEFAULT NULL,
  PRIMARY KEY (`ITEMFEEDBACKID`),
  KEY `FKB7D03A3B31446627` (`ITEMID`),
  CONSTRAINT `FKB7D03A3B31446627` FOREIGN KEY (`ITEMID`) REFERENCES `sam_publisheditem_t` (`ITEMID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sam_publisheditemfeedback_t`
--

LOCK TABLES `sam_publisheditemfeedback_t` WRITE;
/*!40000 ALTER TABLE `sam_publisheditemfeedback_t` DISABLE KEYS */;
/*!40000 ALTER TABLE `sam_publisheditemfeedback_t` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sam_publisheditemmetadata_t`
--

DROP TABLE IF EXISTS `sam_publisheditemmetadata_t`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sam_publisheditemmetadata_t` (
  `ITEMMETADATAID` bigint(20) NOT NULL AUTO_INCREMENT,
  `ITEMID` bigint(20) NOT NULL,
  `LABEL` varchar(255) NOT NULL,
  `ENTRY` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`ITEMMETADATAID`),
  KEY `FKE0C2876531446627` (`ITEMID`),
  CONSTRAINT `FKE0C2876531446627` FOREIGN KEY (`ITEMID`) REFERENCES `sam_publisheditem_t` (`ITEMID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sam_publisheditemmetadata_t`
--

LOCK TABLES `sam_publisheditemmetadata_t` WRITE;
/*!40000 ALTER TABLE `sam_publisheditemmetadata_t` DISABLE KEYS */;
/*!40000 ALTER TABLE `sam_publisheditemmetadata_t` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sam_publisheditemtext_t`
--

DROP TABLE IF EXISTS `sam_publisheditemtext_t`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sam_publisheditemtext_t` (
  `ITEMTEXTID` bigint(20) NOT NULL AUTO_INCREMENT,
  `ITEMID` bigint(20) NOT NULL,
  `SEQUENCE` bigint(20) NOT NULL,
  `TEXT` varchar(4000) DEFAULT NULL,
  PRIMARY KEY (`ITEMTEXTID`),
  KEY `FK9C790A6331446627` (`ITEMID`),
  CONSTRAINT `FK9C790A6331446627` FOREIGN KEY (`ITEMID`) REFERENCES `sam_publisheditem_t` (`ITEMID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sam_publisheditemtext_t`
--

LOCK TABLES `sam_publisheditemtext_t` WRITE;
/*!40000 ALTER TABLE `sam_publisheditemtext_t` DISABLE KEYS */;
/*!40000 ALTER TABLE `sam_publisheditemtext_t` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sam_publishedmetadata_t`
--

DROP TABLE IF EXISTS `sam_publishedmetadata_t`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sam_publishedmetadata_t` (
  `ASSESSMENTMETADATAID` bigint(20) NOT NULL AUTO_INCREMENT,
  `ASSESSMENTID` bigint(20) NOT NULL,
  `LABEL` varchar(255) NOT NULL,
  `ENTRY` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`ASSESSMENTMETADATAID`),
  KEY `FK3D7B27129482C945` (`ASSESSMENTID`),
  CONSTRAINT `FK3D7B27129482C945` FOREIGN KEY (`ASSESSMENTID`) REFERENCES `sam_publishedassessment_t` (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sam_publishedmetadata_t`
--

LOCK TABLES `sam_publishedmetadata_t` WRITE;
/*!40000 ALTER TABLE `sam_publishedmetadata_t` DISABLE KEYS */;
/*!40000 ALTER TABLE `sam_publishedmetadata_t` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sam_publishedsection_t`
--

DROP TABLE IF EXISTS `sam_publishedsection_t`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sam_publishedsection_t` (
  `SECTIONID` bigint(20) NOT NULL AUTO_INCREMENT,
  `ASSESSMENTID` bigint(20) NOT NULL,
  `DURATION` int(11) DEFAULT NULL,
  `SEQUENCE` int(11) DEFAULT NULL,
  `TITLE` varchar(255) DEFAULT NULL,
  `DESCRIPTION` varchar(4000) DEFAULT NULL,
  `TYPEID` bigint(20) NOT NULL,
  `STATUS` int(11) NOT NULL,
  `CREATEDBY` varchar(255) NOT NULL,
  `CREATEDDATE` datetime NOT NULL,
  `LASTMODIFIEDBY` varchar(255) NOT NULL,
  `LASTMODIFIEDDATE` datetime NOT NULL,
  PRIMARY KEY (`SECTIONID`),
  KEY `FK424F87CC9482C945` (`ASSESSMENTID`),
  CONSTRAINT `FK424F87CC9482C945` FOREIGN KEY (`ASSESSMENTID`) REFERENCES `sam_publishedassessment_t` (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sam_publishedsection_t`
--

LOCK TABLES `sam_publishedsection_t` WRITE;
/*!40000 ALTER TABLE `sam_publishedsection_t` DISABLE KEYS */;
/*!40000 ALTER TABLE `sam_publishedsection_t` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sam_publishedsectionmetadata_t`
--

DROP TABLE IF EXISTS `sam_publishedsectionmetadata_t`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sam_publishedsectionmetadata_t` (
  `PUBLISHEDSECTIONMETADATAID` bigint(20) NOT NULL AUTO_INCREMENT,
  `SECTIONID` bigint(20) NOT NULL,
  `LABEL` varchar(255) NOT NULL,
  `ENTRY` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`PUBLISHEDSECTIONMETADATAID`),
  KEY `FKDF50FC3B895D4813` (`SECTIONID`),
  CONSTRAINT `FKDF50FC3B895D4813` FOREIGN KEY (`SECTIONID`) REFERENCES `sam_publishedsection_t` (`SECTIONID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sam_publishedsectionmetadata_t`
--

LOCK TABLES `sam_publishedsectionmetadata_t` WRITE;
/*!40000 ALTER TABLE `sam_publishedsectionmetadata_t` DISABLE KEYS */;
/*!40000 ALTER TABLE `sam_publishedsectionmetadata_t` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sam_publishedsecuredip_t`
--

DROP TABLE IF EXISTS `sam_publishedsecuredip_t`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sam_publishedsecuredip_t` (
  `IPADDRESSID` bigint(20) NOT NULL AUTO_INCREMENT,
  `ASSESSMENTID` bigint(20) NOT NULL,
  `HOSTNAME` varchar(255) DEFAULT NULL,
  `IPADDRESS` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`IPADDRESSID`),
  KEY `FK1EDEA25B9482C945` (`ASSESSMENTID`),
  CONSTRAINT `FK1EDEA25B9482C945` FOREIGN KEY (`ASSESSMENTID`) REFERENCES `sam_publishedassessment_t` (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sam_publishedsecuredip_t`
--

LOCK TABLES `sam_publishedsecuredip_t` WRITE;
/*!40000 ALTER TABLE `sam_publishedsecuredip_t` DISABLE KEYS */;
/*!40000 ALTER TABLE `sam_publishedsecuredip_t` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sam_qualifierdata_t`
--

DROP TABLE IF EXISTS `sam_qualifierdata_t`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sam_qualifierdata_t` (
  `QUALIFIERID` bigint(20) NOT NULL,
  `REFERENCENAME` varchar(255) NOT NULL,
  `DISPLAYNAME` varchar(255) DEFAULT NULL,
  `DESCRIPTION` varchar(4000) DEFAULT NULL,
  `QUALIFIERTYPEID` varchar(4000) DEFAULT NULL,
  PRIMARY KEY (`QUALIFIERID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sam_qualifierdata_t`
--

LOCK TABLES `sam_qualifierdata_t` WRITE;
/*!40000 ALTER TABLE `sam_qualifierdata_t` DISABLE KEYS */;
/*!40000 ALTER TABLE `sam_qualifierdata_t` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sam_questionpool_t`
--

DROP TABLE IF EXISTS `sam_questionpool_t`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sam_questionpool_t` (
  `QUESTIONPOOLID` bigint(20) NOT NULL AUTO_INCREMENT,
  `TITLE` varchar(255) DEFAULT NULL,
  `DESCRIPTION` varchar(255) DEFAULT NULL,
  `PARENTPOOLID` bigint(20) DEFAULT NULL,
  `OWNERID` varchar(255) DEFAULT NULL,
  `ORGANIZATIONNAME` varchar(255) DEFAULT NULL,
  `DATECREATED` datetime DEFAULT NULL,
  `LASTMODIFIEDDATE` datetime DEFAULT NULL,
  `LASTMODIFIEDBY` varchar(255) DEFAULT NULL,
  `DEFAULTACCESSTYPEID` bigint(20) DEFAULT NULL,
  `OBJECTIVE` varchar(255) DEFAULT NULL,
  `KEYWORDS` varchar(255) DEFAULT NULL,
  `RUBRIC` varchar(4000) DEFAULT NULL,
  `TYPEID` bigint(20) DEFAULT NULL,
  `INTELLECTUALPROPERTYID` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`QUESTIONPOOLID`),
  KEY `SAM_QPOOL_OWNER_I` (`OWNERID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sam_questionpool_t`
--

LOCK TABLES `sam_questionpool_t` WRITE;
/*!40000 ALTER TABLE `sam_questionpool_t` DISABLE KEYS */;
/*!40000 ALTER TABLE `sam_questionpool_t` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sam_questionpoolaccess_t`
--

DROP TABLE IF EXISTS `sam_questionpoolaccess_t`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sam_questionpoolaccess_t` (
  `QUESTIONPOOLID` bigint(20) NOT NULL,
  `AGENTID` varchar(255) NOT NULL,
  `ACCESSTYPEID` bigint(20) NOT NULL,
  PRIMARY KEY (`QUESTIONPOOLID`,`AGENTID`,`ACCESSTYPEID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sam_questionpoolaccess_t`
--

LOCK TABLES `sam_questionpoolaccess_t` WRITE;
/*!40000 ALTER TABLE `sam_questionpoolaccess_t` DISABLE KEYS */;
/*!40000 ALTER TABLE `sam_questionpoolaccess_t` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sam_questionpoolitem_t`
--

DROP TABLE IF EXISTS `sam_questionpoolitem_t`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sam_questionpoolitem_t` (
  `QUESTIONPOOLID` bigint(20) NOT NULL,
  `ITEMID` varchar(255) NOT NULL,
  PRIMARY KEY (`QUESTIONPOOLID`,`ITEMID`),
  KEY `FKF0FAAE2A39ED26BB` (`QUESTIONPOOLID`),
  CONSTRAINT `FKF0FAAE2A39ED26BB` FOREIGN KEY (`QUESTIONPOOLID`) REFERENCES `sam_questionpool_t` (`QUESTIONPOOLID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sam_questionpoolitem_t`
--

LOCK TABLES `sam_questionpoolitem_t` WRITE;
/*!40000 ALTER TABLE `sam_questionpoolitem_t` DISABLE KEYS */;
/*!40000 ALTER TABLE `sam_questionpoolitem_t` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sam_section_t`
--

DROP TABLE IF EXISTS `sam_section_t`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sam_section_t` (
  `SECTIONID` bigint(20) NOT NULL AUTO_INCREMENT,
  `ASSESSMENTID` bigint(20) NOT NULL,
  `DURATION` int(11) DEFAULT NULL,
  `SEQUENCE` int(11) DEFAULT NULL,
  `TITLE` varchar(255) DEFAULT NULL,
  `DESCRIPTION` varchar(4000) DEFAULT NULL,
  `TYPEID` bigint(20) DEFAULT NULL,
  `STATUS` int(11) NOT NULL,
  `CREATEDBY` varchar(255) NOT NULL,
  `CREATEDDATE` datetime NOT NULL,
  `LASTMODIFIEDBY` varchar(255) NOT NULL,
  `LASTMODIFIEDDATE` datetime NOT NULL,
  PRIMARY KEY (`SECTIONID`),
  KEY `FK364450DACAC2365B` (`ASSESSMENTID`),
  CONSTRAINT `FK364450DACAC2365B` FOREIGN KEY (`ASSESSMENTID`) REFERENCES `sam_assessmentbase_t` (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sam_section_t`
--

LOCK TABLES `sam_section_t` WRITE;
/*!40000 ALTER TABLE `sam_section_t` DISABLE KEYS */;
/*!40000 ALTER TABLE `sam_section_t` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sam_sectionmetadata_t`
--

DROP TABLE IF EXISTS `sam_sectionmetadata_t`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sam_sectionmetadata_t` (
  `SECTIONMETADATAID` bigint(20) NOT NULL AUTO_INCREMENT,
  `SECTIONID` bigint(20) NOT NULL,
  `LABEL` varchar(255) NOT NULL,
  `ENTRY` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`SECTIONMETADATAID`),
  KEY `FK762AD74970CE2BD` (`SECTIONID`),
  CONSTRAINT `FK762AD74970CE2BD` FOREIGN KEY (`SECTIONID`) REFERENCES `sam_section_t` (`SECTIONID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sam_sectionmetadata_t`
--

LOCK TABLES `sam_sectionmetadata_t` WRITE;
/*!40000 ALTER TABLE `sam_sectionmetadata_t` DISABLE KEYS */;
/*!40000 ALTER TABLE `sam_sectionmetadata_t` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sam_securedip_t`
--

DROP TABLE IF EXISTS `sam_securedip_t`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sam_securedip_t` (
  `IPADDRESSID` bigint(20) NOT NULL AUTO_INCREMENT,
  `ASSESSMENTID` bigint(20) NOT NULL,
  `HOSTNAME` varchar(255) DEFAULT NULL,
  `IPADDRESS` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`IPADDRESSID`),
  KEY `FKE8C55FE9694216CC` (`ASSESSMENTID`),
  CONSTRAINT `FKE8C55FE9694216CC` FOREIGN KEY (`ASSESSMENTID`) REFERENCES `sam_assessmentbase_t` (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sam_securedip_t`
--

LOCK TABLES `sam_securedip_t` WRITE;
/*!40000 ALTER TABLE `sam_securedip_t` DISABLE KEYS */;
/*!40000 ALTER TABLE `sam_securedip_t` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sam_studentgradingsummary_t`
--

DROP TABLE IF EXISTS `sam_studentgradingsummary_t`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sam_studentgradingsummary_t` (
  `STUDENTGRADINGSUMMARYID` bigint(20) NOT NULL AUTO_INCREMENT,
  `PUBLISHEDASSESSMENTID` bigint(20) NOT NULL,
  `AGENTID` varchar(255) NOT NULL,
  `NUMBERRETAKE` int(11) DEFAULT NULL,
  `CREATEDBY` varchar(255) NOT NULL,
  `CREATEDDATE` datetime NOT NULL,
  `LASTMODIFIEDBY` varchar(255) NOT NULL,
  `LASTMODIFIEDDATE` datetime NOT NULL,
  PRIMARY KEY (`STUDENTGRADINGSUMMARYID`),
  KEY `SAM_PUBLISHEDASSESSMENT2_I` (`PUBLISHEDASSESSMENTID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sam_studentgradingsummary_t`
--

LOCK TABLES `sam_studentgradingsummary_t` WRITE;
/*!40000 ALTER TABLE `sam_studentgradingsummary_t` DISABLE KEYS */;
/*!40000 ALTER TABLE `sam_studentgradingsummary_t` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sam_type_t`
--

DROP TABLE IF EXISTS `sam_type_t`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sam_type_t` (
  `TYPEID` bigint(20) NOT NULL AUTO_INCREMENT,
  `AUTHORITY` varchar(255) DEFAULT NULL,
  `DOMAIN` varchar(255) DEFAULT NULL,
  `KEYWORD` varchar(255) DEFAULT NULL,
  `DESCRIPTION` varchar(4000) DEFAULT NULL,
  `STATUS` int(11) NOT NULL,
  `CREATEDBY` varchar(255) NOT NULL,
  `CREATEDDATE` datetime NOT NULL,
  `LASTMODIFIEDBY` varchar(255) NOT NULL,
  `LASTMODIFIEDDATE` datetime NOT NULL,
  PRIMARY KEY (`TYPEID`)
) ENGINE=InnoDB AUTO_INCREMENT=143 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sam_type_t`
--

LOCK TABLES `sam_type_t` WRITE;
/*!40000 ALTER TABLE `sam_type_t` DISABLE KEYS */;
INSERT INTO `sam_type_t` VALUES (1,'stanford.edu','assessment.item','Multiple Choice',NULL,1,'1','2005-01-01 12:00:00','1','2005-01-01 12:00:00'),(2,'stanford.edu','assessment.item','Multiple Correct',NULL,1,'1','2005-01-01 12:00:00','1','2005-01-01 12:00:00'),(3,'stanford.edu','assessment.item','Multiple Choice Survey',NULL,1,'1','2005-01-01 12:00:00','1','2005-01-01 12:00:00'),(4,'stanford.edu','assessment.item','True - False',NULL,1,'1','2005-01-01 12:00:00','1','2005-01-01 12:00:00'),(5,'stanford.edu','assessment.item','Short Answer/Essay',NULL,1,'1','2005-01-01 12:00:00','1','2005-01-01 12:00:00'),(6,'stanford.edu','assessment.item','File Upload',NULL,1,'1','2005-01-01 12:00:00','1','2005-01-01 12:00:00'),(7,'stanford.edu','assessment.item','Audio Recording',NULL,1,'1','2005-01-01 12:00:00','1','2005-01-01 12:00:00'),(8,'stanford.edu','assessment.item','Fill in Blank',NULL,1,'1','2005-01-01 12:00:00','1','2005-01-01 12:00:00'),(9,'stanford.edu','assessment.item','Matching',NULL,1,'1','2005-01-01 12:00:00','1','2005-01-01 12:00:00'),(11,'stanford.edu','assessment.item','Numeric Response',NULL,1,'1','2005-01-01 12:00:00','1','2005-01-01 12:00:00'),(12,'stanford.edu','assessment.item','Multiple Correct Single Selection',NULL,1,'1','2005-01-01 12:00:00','1','2005-01-01 12:00:00'),(21,'stanford.edu','assessment.section','Default',NULL,1,'1','2005-01-01 12:00:00','1','2005-01-01 12:00:00'),(22,'stanford.edu','assessment.section','Normal',NULL,1,'1','2005-01-01 12:00:00','1','2005-01-01 12:00:00'),(30,'stanford.edu','assessment.questionpool.access','Access Denied','Access Denied',1,'1','2005-01-01 12:00:00','1','2005-01-01 12:00:00'),(31,'stanford.edu','assessment.questionpool.access','Read Only','Read Only',1,'1','2005-01-01 12:00:00','1','2005-01-01 12:00:00'),(32,'stanford.edu','assessment.questionpool.access','Read and Copy','Read and Copy',1,'1','2005-01-01 12:00:00','1','2005-01-01 12:00:00'),(33,'stanford.edu','assessment.questionpool.access','Read/Write','Read/Write',1,'1','2005-01-01 12:00:00','1','2005-01-01 12:00:00'),(34,'stanford.edu','assessment.questionpool.access','Administration','Adminstration',1,'1','2005-01-01 12:00:00','1','2005-01-01 12:00:00'),(41,'stanford.edu','assessment.template','Quiz',NULL,1,'1','2005-01-01 12:00:00','1','2005-01-01 12:00:00'),(42,'stanford.edu','assessment.template','Homework',NULL,1,'1','2005-01-01 12:00:00','1','2005-01-01 12:00:00'),(43,'stanford.edu','assessment.template','Mid Term',NULL,1,'1','2005-01-01 12:00:00','1','2005-01-01 12:00:00'),(44,'stanford.edu','assessment.template','Final',NULL,1,'1','2005-01-01 12:00:00','1','2005-01-01 12:00:00'),(61,'stanford.edu','assessment','Quiz',NULL,1,'1','2005-01-01 12:00:00','1','2005-01-01 12:00:00'),(62,'stanford.edu','assessment','Homework',NULL,1,'1','2005-01-01 12:00:00','1','2005-01-01 12:00:00'),(63,'stanford.edu','assessment','Mid Term',NULL,1,'1','2005-01-01 12:00:00','1','2005-01-01 12:00:00'),(64,'stanford.edu','assessment','Final',NULL,1,'1','2005-01-01 12:00:00','1','2005-01-01 12:00:00'),(65,'stanford.edu','assessment.questionpool','Default','Stanford Question Pool',1,'1','2005-01-01 12:00:00','1','2005-01-01 12:00:00'),(81,'stanford.edu','assessment.taking','Taking Assessment','Taking Assessment',1,'1','2005-01-01 12:00:00','1','2005-01-01 12:00:00'),(101,'stanford.edu','assessment.published','A Published Assessment','A Published Assessment',1,'1','2005-01-01 12:00:00','1','2005-01-01 12:00:00'),(142,'stanford.edu','assessment.template.system','System Defined',NULL,1,'1','2006-01-01 12:00:00','1','2005-06-01 12:00:00');
/*!40000 ALTER TABLE `sam_type_t` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `scheduler_delayed_invocation`
--

DROP TABLE IF EXISTS `scheduler_delayed_invocation`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `scheduler_delayed_invocation` (
  `INVOCATION_ID` varchar(36) NOT NULL,
  `INVOCATION_TIME` datetime NOT NULL,
  `COMPONENT` varchar(2000) NOT NULL,
  `CONTEXT` varchar(2000) DEFAULT NULL,
  PRIMARY KEY (`INVOCATION_ID`),
  KEY `SCHEDULER_DI_TIME_INDEX` (`INVOCATION_TIME`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `scheduler_delayed_invocation`
--

LOCK TABLES `scheduler_delayed_invocation` WRITE;
/*!40000 ALTER TABLE `scheduler_delayed_invocation` DISABLE KEYS */;
/*!40000 ALTER TABLE `scheduler_delayed_invocation` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `search_journal`
--

DROP TABLE IF EXISTS `search_journal`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `search_journal` (
  `txid` bigint(20) NOT NULL,
  `txts` bigint(20) NOT NULL,
  `indexwriter` varchar(255) NOT NULL,
  `status` varchar(32) NOT NULL,
  PRIMARY KEY (`txid`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `search_journal`
--

LOCK TABLES `search_journal` WRITE;
/*!40000 ALTER TABLE `search_journal` DISABLE KEYS */;
/*!40000 ALTER TABLE `search_journal` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `search_node_status`
--

DROP TABLE IF EXISTS `search_node_status`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `search_node_status` (
  `jid` bigint(20) NOT NULL,
  `jidts` bigint(20) NOT NULL,
  `serverid` varchar(255) NOT NULL,
  PRIMARY KEY (`serverid`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `search_node_status`
--

LOCK TABLES `search_node_status` WRITE;
/*!40000 ALTER TABLE `search_node_status` DISABLE KEYS */;
/*!40000 ALTER TABLE `search_node_status` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `search_segments`
--

DROP TABLE IF EXISTS `search_segments`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `search_segments` (
  `name_` varchar(254) NOT NULL,
  `version_` bigint(20) NOT NULL,
  `size_` bigint(20) NOT NULL,
  `packet_` longblob,
  PRIMARY KEY (`name_`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `search_segments`
--

LOCK TABLES `search_segments` WRITE;
/*!40000 ALTER TABLE `search_segments` DISABLE KEYS */;
/*!40000 ALTER TABLE `search_segments` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `search_transaction`
--

DROP TABLE IF EXISTS `search_transaction`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `search_transaction` (
  `txname` varchar(64) NOT NULL,
  `txid` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`txname`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `search_transaction`
--

LOCK TABLES `search_transaction` WRITE;
/*!40000 ALTER TABLE `search_transaction` DISABLE KEYS */;
INSERT INTO `search_transaction` VALUES ('optimizeSequence',0),('mergeSequence',0),('sharedOptimizeSequence',0),('indexerTransaction',0),('itemQueueLock',2001);
/*!40000 ALTER TABLE `search_transaction` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `searchbuilderitem`
--

DROP TABLE IF EXISTS `searchbuilderitem`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `searchbuilderitem` (
  `id` varchar(64) NOT NULL,
  `version` datetime NOT NULL,
  `name` varchar(255) NOT NULL,
  `context` varchar(255) NOT NULL,
  `searchaction` int(11) DEFAULT NULL,
  `searchstate` int(11) DEFAULT NULL,
  `itemscope` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`),
  KEY `isearchbuilderitem_name` (`name`),
  KEY `isearchbuilderitem_ctx` (`context`),
  KEY `isearchbuilderitem_act_sta` (`searchstate`,`searchaction`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `searchbuilderitem`
--

LOCK TABLES `searchbuilderitem` WRITE;
/*!40000 ALTER TABLE `searchbuilderitem` DISABLE KEYS */;
/*!40000 ALTER TABLE `searchbuilderitem` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `searchwriterlock`
--

DROP TABLE IF EXISTS `searchwriterlock`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `searchwriterlock` (
  `id` varchar(64) NOT NULL,
  `lockkey` varchar(64) NOT NULL,
  `nodename` varchar(64) DEFAULT NULL,
  `expires` datetime NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `lockkey` (`lockkey`),
  KEY `isearchwriterlock_lk` (`lockkey`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `searchwriterlock`
--

LOCK TABLES `searchwriterlock` WRITE;
/*!40000 ALTER TABLE `searchwriterlock` DISABLE KEYS */;
/*!40000 ALTER TABLE `searchwriterlock` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `siteassoc_context_association`
--

DROP TABLE IF EXISTS `siteassoc_context_association`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `siteassoc_context_association` (
  `FROM_CONTEXT` varchar(99) NOT NULL,
  `TO_CONTEXT` varchar(99) NOT NULL,
  `VERSION` int(11) NOT NULL,
  PRIMARY KEY (`FROM_CONTEXT`,`TO_CONTEXT`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `siteassoc_context_association`
--

LOCK TABLES `siteassoc_context_association` WRITE;
/*!40000 ALTER TABLE `siteassoc_context_association` DISABLE KEYS */;
/*!40000 ALTER TABLE `siteassoc_context_association` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ssq_answer`
--

DROP TABLE IF EXISTS `ssq_answer`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ssq_answer` (
  `ID` varchar(99) NOT NULL,
  `ANSWER` varchar(255) DEFAULT NULL,
  `ANSWER_STRING` varchar(255) DEFAULT NULL,
  `FILL_IN_BLANK` bit(1) DEFAULT NULL,
  `ORDER_NUM` int(11) DEFAULT NULL,
  `QUESTION_ID` varchar(99) DEFAULT NULL,
  PRIMARY KEY (`ID`),
  KEY `FK390C0DCC6B21AFB4` (`QUESTION_ID`),
  CONSTRAINT `FK390C0DCC6B21AFB4` FOREIGN KEY (`QUESTION_ID`) REFERENCES `ssq_question` (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ssq_answer`
--

LOCK TABLES `ssq_answer` WRITE;
/*!40000 ALTER TABLE `ssq_answer` DISABLE KEYS */;
/*!40000 ALTER TABLE `ssq_answer` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ssq_question`
--

DROP TABLE IF EXISTS `ssq_question`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ssq_question` (
  `ID` varchar(99) NOT NULL,
  `QUESTION` varchar(255) DEFAULT NULL,
  `REQUIRED` bit(1) DEFAULT NULL,
  `MULTIPLE_ANSWERS` bit(1) DEFAULT NULL,
  `ORDER_NUM` int(11) DEFAULT NULL,
  `IS_CURRENT` varchar(255) DEFAULT NULL,
  `SITETYPE_ID` varchar(99) DEFAULT NULL,
  PRIMARY KEY (`ID`),
  KEY `FKFE88BA7443AD4C69` (`SITETYPE_ID`),
  CONSTRAINT `FKFE88BA7443AD4C69` FOREIGN KEY (`SITETYPE_ID`) REFERENCES `ssq_sitetype_questions` (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='This table stores site setup questions';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ssq_question`
--

LOCK TABLES `ssq_question` WRITE;
/*!40000 ALTER TABLE `ssq_question` DISABLE KEYS */;
/*!40000 ALTER TABLE `ssq_question` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ssq_sitetype_questions`
--

DROP TABLE IF EXISTS `ssq_sitetype_questions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ssq_sitetype_questions` (
  `ID` varchar(99) NOT NULL,
  `SITE_TYPE` varchar(255) DEFAULT NULL,
  `INSTRUCTION` varchar(255) DEFAULT NULL,
  `URL` varchar(255) DEFAULT NULL,
  `URL_LABEL` varchar(255) DEFAULT NULL,
  `URL_Target` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ssq_sitetype_questions`
--

LOCK TABLES `ssq_sitetype_questions` WRITE;
/*!40000 ALTER TABLE `ssq_sitetype_questions` DISABLE KEYS */;
/*!40000 ALTER TABLE `ssq_sitetype_questions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ssq_user_answer`
--

DROP TABLE IF EXISTS `ssq_user_answer`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ssq_user_answer` (
  `ID` varchar(99) NOT NULL,
  `SITE_ID` varchar(255) DEFAULT NULL,
  `USER_ID` varchar(255) DEFAULT NULL,
  `ANSWER_STRING` varchar(255) DEFAULT NULL,
  `ANSWER_ID` varchar(255) DEFAULT NULL,
  `QUESTION_ID` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ssq_user_answer`
--

LOCK TABLES `ssq_user_answer` WRITE;
/*!40000 ALTER TABLE `ssq_user_answer` DISABLE KEYS */;
/*!40000 ALTER TABLE `ssq_user_answer` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sst_events`
--

DROP TABLE IF EXISTS `sst_events`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sst_events` (
  `ID` bigint(20) NOT NULL AUTO_INCREMENT,
  `USER_ID` varchar(99) NOT NULL,
  `SITE_ID` varchar(99) NOT NULL,
  `EVENT_ID` varchar(32) NOT NULL,
  `EVENT_DATE` date NOT NULL,
  `EVENT_COUNT` bigint(20) NOT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sst_events`
--

LOCK TABLES `sst_events` WRITE;
/*!40000 ALTER TABLE `sst_events` DISABLE KEYS */;
/*!40000 ALTER TABLE `sst_events` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sst_job_run`
--

DROP TABLE IF EXISTS `sst_job_run`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sst_job_run` (
  `ID` bigint(20) NOT NULL AUTO_INCREMENT,
  `JOB_START_DATE` datetime DEFAULT NULL,
  `JOB_END_DATE` datetime DEFAULT NULL,
  `START_EVENT_ID` bigint(20) DEFAULT NULL,
  `END_EVENT_ID` bigint(20) DEFAULT NULL,
  `LAST_EVENT_DATE` datetime DEFAULT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sst_job_run`
--

LOCK TABLES `sst_job_run` WRITE;
/*!40000 ALTER TABLE `sst_job_run` DISABLE KEYS */;
/*!40000 ALTER TABLE `sst_job_run` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sst_preferences`
--

DROP TABLE IF EXISTS `sst_preferences`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sst_preferences` (
  `ID` bigint(20) NOT NULL AUTO_INCREMENT,
  `SITE_ID` varchar(99) NOT NULL,
  `PREFS` text NOT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sst_preferences`
--

LOCK TABLES `sst_preferences` WRITE;
/*!40000 ALTER TABLE `sst_preferences` DISABLE KEYS */;
/*!40000 ALTER TABLE `sst_preferences` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sst_reports`
--

DROP TABLE IF EXISTS `sst_reports`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sst_reports` (
  `ID` bigint(20) NOT NULL AUTO_INCREMENT,
  `SITE_ID` varchar(99) DEFAULT NULL,
  `TITLE` varchar(255) NOT NULL,
  `DESCRIPTION` longtext,
  `HIDDEN` bit(1) DEFAULT NULL,
  `REPORT_DEF` text NOT NULL,
  `CREATED_BY` varchar(99) NOT NULL,
  `CREATED_ON` datetime NOT NULL,
  `MODIFIED_BY` varchar(99) DEFAULT NULL,
  `MODIFIED_ON` datetime DEFAULT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sst_reports`
--

LOCK TABLES `sst_reports` WRITE;
/*!40000 ALTER TABLE `sst_reports` DISABLE KEYS */;
/*!40000 ALTER TABLE `sst_reports` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sst_resources`
--

DROP TABLE IF EXISTS `sst_resources`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sst_resources` (
  `ID` bigint(20) NOT NULL AUTO_INCREMENT,
  `USER_ID` varchar(99) NOT NULL,
  `SITE_ID` varchar(99) NOT NULL,
  `RESOURCE_REF` varchar(255) NOT NULL,
  `RESOURCE_ACTION` varchar(12) NOT NULL,
  `RESOURCE_DATE` date NOT NULL,
  `RESOURCE_COUNT` bigint(20) NOT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sst_resources`
--

LOCK TABLES `sst_resources` WRITE;
/*!40000 ALTER TABLE `sst_resources` DISABLE KEYS */;
/*!40000 ALTER TABLE `sst_resources` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sst_siteactivity`
--

DROP TABLE IF EXISTS `sst_siteactivity`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sst_siteactivity` (
  `ID` bigint(20) NOT NULL AUTO_INCREMENT,
  `SITE_ID` varchar(99) NOT NULL,
  `ACTIVITY_DATE` date NOT NULL,
  `EVENT_ID` varchar(32) NOT NULL,
  `ACTIVITY_COUNT` bigint(20) NOT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sst_siteactivity`
--

LOCK TABLES `sst_siteactivity` WRITE;
/*!40000 ALTER TABLE `sst_siteactivity` DISABLE KEYS */;
/*!40000 ALTER TABLE `sst_siteactivity` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sst_sitevisits`
--

DROP TABLE IF EXISTS `sst_sitevisits`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sst_sitevisits` (
  `ID` bigint(20) NOT NULL AUTO_INCREMENT,
  `SITE_ID` varchar(99) NOT NULL,
  `VISITS_DATE` date NOT NULL,
  `TOTAL_VISITS` bigint(20) NOT NULL,
  `TOTAL_UNIQUE` bigint(20) NOT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sst_sitevisits`
--

LOCK TABLES `sst_sitevisits` WRITE;
/*!40000 ALTER TABLE `sst_sitevisits` DISABLE KEYS */;
/*!40000 ALTER TABLE `sst_sitevisits` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `taggable_link`
--

DROP TABLE IF EXISTS `taggable_link`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `taggable_link` (
  `LINK_ID` varchar(36) NOT NULL,
  `VERSION` int(11) NOT NULL,
  `ACTIVITY_REF` varchar(255) NOT NULL,
  `TAG_CRITERIA_REF` varchar(255) NOT NULL,
  `RUBRIC` text,
  `RATIONALE` text,
  `EXPORT_STRING` int(11) NOT NULL,
  `VISIBLE` bit(1) NOT NULL,
  `LOCKED` bit(1) NOT NULL,
  PRIMARY KEY (`LINK_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `taggable_link`
--

LOCK TABLES `taggable_link` WRITE;
/*!40000 ALTER TABLE `taggable_link` DISABLE KEYS */;
/*!40000 ALTER TABLE `taggable_link` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2012-04-22 16:43:19
