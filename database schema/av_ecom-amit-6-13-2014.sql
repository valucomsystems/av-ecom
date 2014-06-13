CREATE DATABASE  IF NOT EXISTS `av_ecom` /*!40100 DEFAULT CHARACTER SET utf8 */;
USE `av_ecom`;
-- MySQL dump 10.13  Distrib 5.6.17, for Win32 (x86)
--
-- Host: localhost    Database: av_ecom
-- ------------------------------------------------------
-- Server version	5.5.38

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
-- Table structure for table `attribute`
--

DROP TABLE IF EXISTS `attribute`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `attribute` (
  `ATTRIBUTE_ID` bigint(20) NOT NULL COMMENT 'The internal reference number of the attribute.',
  `LANGUAGE_ID` int(11) NOT NULL COMMENT 'The language to which this attribute pertains to For a list of language components, see the LANGUAGE table.',
  `ATTRTYPE_ID` char(16) NOT NULL COMMENT 'The type of the corresponding attribute value. Foreign key to the ATTRTYPE table.',
  `NAME` char(254) DEFAULT NULL COMMENT 'The name given to this attribute.',
  `SEQUENCE` double NOT NULL DEFAULT '0' COMMENT 'A sequence number that determines the display order of attributes for a given product.',
  `DESCRIPTION` varchar(254) DEFAULT NULL COMMENT 'The attribute description.',
  `CATENTRY_ID` bigint(20) DEFAULT NULL COMMENT 'The reference number of the product to which this attribute belongs.',
  `DESCRIPTION2` varchar(254) DEFAULT NULL COMMENT 'An additional description field for this attribute.',
  `USAGE` char(1) DEFAULT '1' COMMENT 'A code that represents the purpose of the attribute. NULL or "1" indicates SKU-resolution. "2" indicates a descriptive attribute and should not be used to resolve SKUs. The values NULL and "0" through "9" are reserved for IBM internal use.',
  `QTYUNIT_ID` char(45) DEFAULT NULL COMMENT 'The units in which this attribute is measured.',
  `GROUPNAME` varchar(64) DEFAULT NULL COMMENT 'Specifies the name of the group of attributes. All related attributes should be created with the same groupname.',
  `NOTEINFO` varchar(64) DEFAULT NULL COMMENT 'Auxiliary attribute data such as a footnote.',
  `MULTITYPE` char(1) DEFAULT NULL COMMENT 'Reserved for IBM internal use.',
  `OPTCOUNTER` smallint(6) DEFAULT NULL COMMENT 'Reserved for internal use.',
  PRIMARY KEY (`ATTRIBUTE_ID`,`LANGUAGE_ID`),
  UNIQUE KEY `index2` (`CATENTRY_ID`,`LANGUAGE_ID`,`NAME`),
  KEY `index3` (`GROUPNAME`,`SEQUENCE`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='This table holds product attributes which are used for descriptive or SKU resolution purposes.';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `attribute`
--

LOCK TABLES `attribute` WRITE;
/*!40000 ALTER TABLE `attribute` DISABLE KEYS */;
/*!40000 ALTER TABLE `attribute` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `attrtype`
--

DROP TABLE IF EXISTS `attrtype`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `attrtype` (
  `ATTRTYPE_ID` char(16) NOT NULL COMMENT 'The ID of the attribute type. Valid values: INTEGER, STRING, FLOAT, DATETIME, FREEFORM or BIGINT.',
  `DESCRIPTION` varchar(254) DEFAULT NULL COMMENT 'The description of the attribute type.',
  `OPTCOUNTER` smallint(6) DEFAULT NULL COMMENT 'Reserved for internal use.',
  PRIMARY KEY (`ATTRTYPE_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='This table holds the type identifier for product attributes.';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `attrtype`
--

LOCK TABLES `attrtype` WRITE;
/*!40000 ALTER TABLE `attrtype` DISABLE KEYS */;
/*!40000 ALTER TABLE `attrtype` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `attrval`
--

DROP TABLE IF EXISTS `attrval`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `attrval` (
  `ATTRVAL_ID` bigint(20) NOT NULL COMMENT 'The unique identifier for this attribute value.',
  `ATTR_ID` bigint(20) NOT NULL COMMENT 'The reference number of the attribute to which this attribute value applies.',
  `IDENTIFIER` varchar(254) DEFAULT NULL COMMENT 'An external identifier for the attibute value.',
  `VALUSAGE` int(11) DEFAULT NULL COMMENT '1Predefined allowed value. (For example, one of the allowed values of Color is Blue)2Default predefined allowed value (When assign attribute to catalog entry, default predefined allowed value will be selected by default)nullAssigned attribute value. (For example Product''s Length is 30. Length attribute does not have allowed values).',
  `STOREENT_ID` int(11) NOT NULL COMMENT 'The reference number of the store entity to which this attribute belongs.',
  `OPTCOUNTER` smallint(6) NOT NULL DEFAULT '0' COMMENT 'The optimistic concurrency control counter for the table.',
  PRIMARY KEY (`ATTRVAL_ID`),
  UNIQUE KEY `index2` (`ATTR_ID`,`IDENTIFIER`),
  KEY `index3` (`ATTR_ID`,`STOREENT_ID`,`VALUSAGE`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='This table holds an attribute value that can be a shareable global attribute value or a local attribute value defined for a catalog entry.';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `attrval`
--

LOCK TABLES `attrval` WRITE;
/*!40000 ALTER TABLE `attrval` DISABLE KEYS */;
/*!40000 ALTER TABLE `attrval` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `attrvalue`
--

DROP TABLE IF EXISTS `attrvalue`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `attrvalue` (
  `ATTRVALUE_ID` bigint(20) NOT NULL COMMENT 'The unique identifier for this attribute value.',
  `LANGUAGE_ID` int(11) NOT NULL COMMENT 'The Identifier of the language. For a list of language components, see the LANGUAGE table.',
  `ATTRIBUTE_ID` bigint(20) NOT NULL COMMENT 'The reference number of the attribute to which this attribute value applies.',
  `ATTRTYPE_ID` char(16) NOT NULL COMMENT 'The type of the attribute value. Valid types are STRING, INTEGER and FLOAT.',
  `STRINGVALUE` char(254) DEFAULT NULL COMMENT 'If this type of attribute value is STRING, then this column will hold the attribute value. If the type is not STRING, then this column will be NULL.',
  `SEQUENCE` double NOT NULL DEFAULT '0' COMMENT 'A sequence number that determines the display order of attribute values for a given attribute.',
  `INTEGERVALUE` int(11) DEFAULT NULL COMMENT 'If this type of attribute value is INTEGER, then this column will hold the attribute value. If the type is not INTEGER, then this column will be NULL.',
  `FLOATVALUE` double DEFAULT NULL COMMENT 'If this type of attribute value is FLOAT, then this column will hold the attribute value. If the type is not FLOAT, then this column will be NULL.',
  `CATENTRY_ID` bigint(20) NOT NULL COMMENT 'The unique identifier of the catalog entry that is assigned this attribute value.',
  `NAME` varchar(254) DEFAULT NULL COMMENT 'The name given to this attribute value.',
  `IMAGE1` varchar(254) DEFAULT NULL COMMENT 'The path of the first image of this attribute value.',
  `IMAGE2` varchar(254) DEFAULT NULL COMMENT 'The path of the second image of this attribute value.',
  `QTYUNIT_ID` char(16) DEFAULT NULL COMMENT 'The units in which this attribute value is measured.',
  `ATTACHMENT_ID` bigint(20) DEFAULT NULL COMMENT 'The reference number of an attachment that is associated with the attribute value.',
  `OPTCOUNTER` smallint(6) DEFAULT NULL COMMENT 'Reserved for internal use.',
  PRIMARY KEY (`ATTRVALUE_ID`,`LANGUAGE_ID`),
  UNIQUE KEY `index2` (`ATTRIBUTE_ID`,`CATENTRY_ID`,`LANGUAGE_ID`,`NAME`),
  UNIQUE KEY `index3` (`CATENTRY_ID`,`ATTRVALUE_ID`,`STRINGVALUE`,`LANGUAGE_ID`,`INTEGERVALUE`,`FLOATVALUE`),
  KEY `index4` (`CATENTRY_ID`),
  KEY `index5` (`CATENTRY_ID`,`ATTRIBUTE_ID`,`LANGUAGE_ID`,`SEQUENCE`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='This table holds the values assigned to product attributes and relates them back to catalog entries for SKU resolution.';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `attrvalue`
--

LOCK TABLES `attrvalue` WRITE;
/*!40000 ALTER TABLE `attrvalue` DISABLE KEYS */;
/*!40000 ALTER TABLE `attrvalue` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `catalog`
--

DROP TABLE IF EXISTS `catalog`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `catalog` (
  `CATALOG_ID` bigint(20) NOT NULL COMMENT 'The internal reference number of the catalog.',
  `MEMBER_ID` bigint(20) NOT NULL COMMENT 'The internal reference number that identifies the owner of the catalog. Along with the IDENTIFIER, these columns are a unique index.',
  `IDENTIFIER` varchar(254) NOT NULL COMMENT 'The external identifier used to identify the catalog. Along with the MEMBER_ID, these columns are a unique index.',
  `DESCRIPTION` varchar(254) DEFAULT NULL COMMENT 'An administrative description of the catalog.',
  `OPTCOUNTER` smallint(6) DEFAULT NULL COMMENT 'The optimistic concurrency control counter for the table.',
  PRIMARY KEY (`CATALOG_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='This table holds the information related to a catalog.';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `catalog`
--

LOCK TABLES `catalog` WRITE;
/*!40000 ALTER TABLE `catalog` DISABLE KEYS */;
/*!40000 ALTER TABLE `catalog` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `catalogdsc`
--

DROP TABLE IF EXISTS `catalogdsc`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `catalogdsc` (
  `CATALOG_ID` bigint(20) NOT NULL COMMENT 'The internal reference number relating this language specific information to a catalog.',
  `LANGUAGE_ID` int(11) NOT NULL COMMENT 'The identifier of the language. For a list of language identifiers, see the LANGUAGE table.',
  `NAME` varchar(254) NOT NULL COMMENT 'The language-dependent name of this catalog.',
  `SHORTDESCRIPTION` varchar(254) DEFAULT NULL COMMENT 'A short description of this catalog.',
  `LONGDESCRIPTION` varchar(4000) DEFAULT NULL COMMENT 'A long description of this catalog.',
  `THUMBNAIL` varchar(254) DEFAULT NULL COMMENT 'The thumbnail image path of this catalog.',
  `FULLIMAGE` varchar(254) DEFAULT NULL COMMENT 'The image path of this catalog.',
  `OPTCOUNTER` smallint(6) DEFAULT NULL COMMENT 'The optimistic concurrency control counter for the table.',
  PRIMARY KEY (`CATALOG_ID`,`LANGUAGE_ID`),
  UNIQUE KEY `index2` (`CATALOG_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='This table holds language-dependent information related to a catalog.';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `catalogdsc`
--

LOCK TABLES `catalogdsc` WRITE;
/*!40000 ALTER TABLE `catalogdsc` DISABLE KEYS */;
/*!40000 ALTER TABLE `catalogdsc` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `catentry`
--

DROP TABLE IF EXISTS `catentry`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `catentry` (
  `CATENTRY_ID` bigint(20) NOT NULL COMMENT 'The internal reference number of the catalog entry.',
  `MEMBER_ID` bigint(20) NOT NULL COMMENT 'The reference number that identifies the owner of the catalog entry. Along with the PARTNUMBER, these columns are a unique index.',
  `ITEMSPC_ID` bigint(20) DEFAULT NULL COMMENT 'The specified item that this catalog entry relates to. This column should only be populated for catalog entries that are of type "ItemBean", "PackageBean", or "DynamicKitBean". Specified items are used for fulfillment.',
  `CATENTTYPE_ID` char(16) NOT NULL COMMENT 'Identifies the type of catalog entry. Foreign key to the CATENTTYPE table. The supported default types are: ProductBean, ItemBean, PackageBean, BundleBean and DynamicKitBean.',
  `PARTNUMBER` varchar(64) NOT NULL COMMENT 'The reference number that identifies the part number of the catalog entry. Along with the MEMBER_ID, these columns are a unique index.',
  `MFPARTNUMBER` varchar(64) DEFAULT NULL COMMENT 'The part number used by the manufacturer to identify this catalog entry.',
  `MFNAME` varchar(64) DEFAULT NULL COMMENT 'The name of the manufacturer of this catalog entry.',
  `MARKFORDELETE` int(11) NOT NULL COMMENT 'Indicates if this catalog entry has been marked for deletion: ',
  `URL` varchar(254) DEFAULT NULL COMMENT 'The URL to this catalog entry, which can be used as a download URL for soft goods.',
  `LASTUPDATE` timestamp NULL DEFAULT NULL COMMENT 'Indicates the last time the catalog entry was updated.',
  `ONSPECIAL` int(11) DEFAULT NULL,
  `ONAUCTION` int(11) DEFAULT NULL COMMENT 'This flag identifies if this catalog entry is on auction.',
  `BUYABLE` int(11) DEFAULT NULL COMMENT 'Indicates whether this catalog entry can be purchased individually: 1=yes and 0=no.',
  `BASEITEM_ID` bigint(20) DEFAULT NULL COMMENT 'The base item to which this catalog entry relates. This column should only be populated for catalog entries that are of type ProductBean, PackageBean or DynamicKitBean. Base items are used for fulfillment.',
  `STATE` char(1) DEFAULT '1' COMMENT 'Reserved for internal use.',
  `STARTDATE` timestamp NULL DEFAULT NULL COMMENT 'The date when this catalog entry is introduced. This column is for your interpretation and information only.',
  `ENDDATE` timestamp NULL DEFAULT NULL COMMENT 'The date when this catalog entry is withdrawn. This column is for your interpretation and information only.',
  `OPTCOUNTER` smallint(6) DEFAULT NULL COMMENT 'The optimistic concurrency control counter for the table.',
  `AVAILABILITYDATE` timestamp NULL DEFAULT NULL COMMENT 'The date that the product is available to customers for purchase. This column is for your interpretation and information only.',
  `LASTORDERDATE` timestamp NULL DEFAULT NULL COMMENT 'The final date that the product is available for order. This is the latest date a customer can order the product. This column is for your interpretation and information only.',
  `ENDOFSERVICEDATE` timestamp NULL DEFAULT NULL COMMENT 'The date when the product is no longer in service. For example, this date can be the date that a software manufacturer stops providing upgrades for a version of their product. This column is for your interpretation and information only.',
  `DISCONTINUEDATE` timestamp NULL DEFAULT NULL COMMENT 'The date when the product is discontinued. For example, this date can be the date the manufacturer stops producing the product, or the date your store stops selling the product. It is recommended that this column be used consistently to avoid confusion. This column is for your interpretation and information only.',
  `UP_MFNAME` varchar(64) DEFAULT NULL COMMENT 'The equivalent value of the MFNAME column in upper case characters. This column is used only for DB2 (LUW) database-types to enhance performance of text-based searches issued from Management Center.',
  `UP_MFPARTNUMBER` varchar(64) DEFAULT NULL COMMENT 'The equivalent value of the MFPARTNUMBER column in upper case characters. This column is used only for DB2 (LUW) database-types to enhance performance of text-based searches issued from Management Center.',
  `UP_PARTNUMBER` varchar(64) DEFAULT NULL COMMENT 'The equivalent value of the PARTNUMBER column in upper case characters. This column is used only for DB2 (LUW) database-types to enhance performance of text-based searches issued from Management Center.',
  PRIMARY KEY (`CATENTRY_ID`),
  UNIQUE KEY `index2` (`PARTNUMBER`,`MEMBER_ID`),
  KEY `index3` (`CATENTRY_ID`,`MARKFORDELETE`),
  KEY `index4` (`CATENTRY_ID`,`CATENTTYPE_ID`,`BUYABLE`),
  KEY `index5` (`CATENTTYPE_ID`),
  KEY `index6` (`MEMBER_ID`),
  KEY `index7` (`CATENTTYPE_ID`,`CATENTRY_ID`),
  KEY `index8` (`ITEMSPC_ID`),
  KEY `index9` (`BASEITEM_ID`),
  KEY `index10` (`UP_MFNAME`),
  KEY `index11` (`UP_PARTNUMBER`),
  KEY `index12` (`UP_MFPARTNUMBER`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='This table holds the information related to a catalog entry. Examples of catalog entries include products, items, packages, and bundles.';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `catentry`
--

LOCK TABLES `catentry` WRITE;
/*!40000 ALTER TABLE `catentry` DISABLE KEYS */;
/*!40000 ALTER TABLE `catentry` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `catgpenrel`
--

DROP TABLE IF EXISTS `catgpenrel`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `catgpenrel` (
  `CATGROUP_ID` bigint(20) NOT NULL COMMENT 'The source catalog group of this relationship.',
  `CATALOG_ID` bigint(20) NOT NULL COMMENT 'The catalog inside of which this relationship is found.',
  `CATENTRY_ID` bigint(20) NOT NULL COMMENT 'The target catalog entry of this relationship.',
  `SEQUENCE` double DEFAULT NULL COMMENT 'The sequence number that determines the display order of the contents of the catalog group.',
  `LASTUPDATE` timestamp NULL DEFAULT NULL COMMENT 'Indicates the last time that this relationship was updated.',
  `OPTCOUNTER` smallint(6) DEFAULT NULL COMMENT 'The optimistic concurrency control counter for the table.',
  PRIMARY KEY (`CATGROUP_ID`,`CATALOG_ID`,`CATENTRY_ID`),
  KEY `index2` (`CATALOG_ID`),
  KEY `index3` (`CATENTRY_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='This table relates catalog groups (or categories) to the catalog entries that are inside them. You can also use this table to dictate the navigational flow from catalog groups to catalog entries. Each relationship is also qualified by a Catalog ID.';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `catgpenrel`
--

LOCK TABLES `catgpenrel` WRITE;
/*!40000 ALTER TABLE `catgpenrel` DISABLE KEYS */;
/*!40000 ALTER TABLE `catgpenrel` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `catgroup`
--

DROP TABLE IF EXISTS `catgroup`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `catgroup` (
  `CATGROUP_ID` bigint(20) NOT NULL COMMENT 'The internal reference number of the catalog group.',
  `MEMBER_ID` bigint(20) DEFAULT NULL COMMENT 'The internal reference number that identifies the owner of the catalog group. Along with IDENTIFIER, these columns are a unique index.',
  `IDENTIFIER` varchar(254) DEFAULT NULL COMMENT 'The external name that is used to identify the catalog group. Along with MEMBER_ID, these columns are a unique index.',
  `MARKFORDELETE` int(11) NOT NULL COMMENT 'Indicates if this catalog group has been marked for deletion: ',
  `LASTUPDATE` timestamp NULL DEFAULT NULL COMMENT 'Indicates the last time that this catalog group was updated.',
  `OPTCOUNTER` smallint(6) DEFAULT NULL COMMENT 'The optimistic concurrency control counter for the table.',
  `UP_IDENTIFIER` varchar(254) DEFAULT NULL COMMENT 'The equivalent value of the IDENTIFIER column in upper case characters. This column is used only for DB2 (LUW) database-types to enhance performance of text-based searches issued from Management Center.',
  PRIMARY KEY (`CATGROUP_ID`),
  UNIQUE KEY `index2` (`MEMBER_ID`,`IDENTIFIER`),
  KEY `index3` (`MEMBER_ID`),
  KEY `index4` (`UP_IDENTIFIER`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='This table hold the information related to a catalog group. A catalog group is similar to a generic category that can contain both other catalog groups and also catalog entries.';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `catgroup`
--

LOCK TABLES `catgroup` WRITE;
/*!40000 ALTER TABLE `catgroup` DISABLE KEYS */;
/*!40000 ALTER TABLE `catgroup` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `catgrprel`
--

DROP TABLE IF EXISTS `catgrprel`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `catgrprel` (
  `CATGROUP_ID_PARENT` bigint(20) NOT NULL COMMENT 'The source catalog group of this relationship.',
  `CATGROUP_ID_CHILD` bigint(20) NOT NULL COMMENT 'The target catalog group of this relationship.',
  `CATALOG_ID` bigint(20) NOT NULL COMMENT 'The catalog in which this relationship is found.',
  `SEQUENCE` double NOT NULL COMMENT 'The sequence number that determines the display order of the contents of the catalog group.',
  `LASTUPDATE` timestamp NULL DEFAULT NULL COMMENT 'Indicates the last time that this relationship was updated.',
  `OPTCOUNTER` smallint(6) DEFAULT NULL COMMENT 'The optimistic concurrency control counter for the table.',
  PRIMARY KEY (`CATGROUP_ID_PARENT`,`CATGROUP_ID_CHILD`,`CATALOG_ID`),
  KEY `index2` (`CATALOG_ID`),
  KEY `index3` (`CATGROUP_ID_PARENT`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='This table relates catalog groups (or categories) to child catalog group (or child categories). You can use this table to dictate the navigational flow from catalog groups to child catalog groups. Each relationship is also qualified by a Catalog ID.';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `catgrprel`
--

LOCK TABLES `catgrprel` WRITE;
/*!40000 ALTER TABLE `catgrprel` DISABLE KEYS */;
/*!40000 ALTER TABLE `catgrprel` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `catgrptpc`
--

DROP TABLE IF EXISTS `catgrptpc`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `catgrptpc` (
  `CATALOG_ID` bigint(20) NOT NULL COMMENT 'The reference number of the catalog.',
  `CATGROUP_ID` bigint(20) NOT NULL DEFAULT '0' COMMENT 'The reference number of the catalog group.',
  `TRADEPOSCN_ID` bigint(20) NOT NULL COMMENT 'The reference number of the trading position container',
  `STORE_ID` int(11) NOT NULL DEFAULT '0' COMMENT 'The reference number of the store to which this trading position container relationship refers.',
  `OPTCOUNTER` smallint(6) DEFAULT NULL COMMENT 'The optimistic concurrency control counter for the table.',
  PRIMARY KEY (`CATALOG_ID`,`CATGROUP_ID`,`TRADEPOSCN_ID`,`STORE_ID`),
  UNIQUE KEY `index2` (`TRADEPOSCN_ID`),
  UNIQUE KEY `index3` (`STORE_ID`),
  UNIQUE KEY `index4` (`CATGROUP_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='This table relates master catalogs with trading position containers. Each catalog entry belonging to the indicated master catalog must have a standard price offer supplied for the specified trading position container.';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `catgrptpc`
--

LOCK TABLES `catgrptpc` WRITE;
/*!40000 ALTER TABLE `catgrptpc` DISABLE KEYS */;
/*!40000 ALTER TABLE `catgrptpc` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cattogrp`
--

DROP TABLE IF EXISTS `cattogrp`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cattogrp` (
  `CATALOG_ID` bigint(20) NOT NULL COMMENT 'The reference number of the catalog.',
  `CATGROUP_ID` bigint(20) NOT NULL COMMENT 'The reference number of the catalog group.',
  `LASTUPDATE` timestamp NULL DEFAULT NULL COMMENT 'The last time that this relationship was updated.',
  `SEQUENCE` double DEFAULT NULL COMMENT 'The sequence number used to determine display order.',
  `OPTCOUNTER` smallint(6) DEFAULT NULL COMMENT 'The optimistic concurrency control counter for the table.',
  PRIMARY KEY (`CATALOG_ID`,`CATGROUP_ID`),
  UNIQUE KEY `index2` (`CATGROUP_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='This table identifies the root catalog groups (or root categories) contained within a catalog.';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cattogrp`
--

LOCK TABLES `cattogrp` WRITE;
/*!40000 ALTER TABLE `cattogrp` DISABLE KEYS */;
/*!40000 ALTER TABLE `cattogrp` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `language`
--

DROP TABLE IF EXISTS `language`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `language` (
  `LANGUAGE_ID` int(11) NOT NULL COMMENT 'The language ID (primary key of this table) for each language. Foreign key to the tables that contain language-dependent information. The following is the list of language components (language ID codes) of the locale: ',
  `LOCALENAME` char(16) NOT NULL COMMENT 'A Java locale used to represent a political, geographical, or cultural region that has a distinct language and customs. The following is the list of locale used for formatting: ',
  `LANGUAGE` char(5) DEFAULT NULL COMMENT 'Language component of the locale. ',
  `COUNTRY` char(5) DEFAULT NULL COMMENT 'Country or region component of the locale. ',
  `VARIANT` char(10) DEFAULT NULL COMMENT 'Variant component of the locale. Used to specify the locale encoding character set or to further segregate a distinct formatting custom for a political, geographical, or cultural region.',
  `ENCODING` varchar(45) DEFAULT NULL COMMENT 'The character encoding value that the browser uses to display the page in the selected language.',
  `MIMECHARSET` varchar(45) DEFAULT NULL COMMENT 'The MIME character encoding value that the notification system uses to encode a message for the selected language.',
  `OPTCOUNTER` smallint(6) DEFAULT NULL COMMENT 'The optimistic concurrency control counter for the table.',
  PRIMARY KEY (`LANGUAGE_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Each row of this table represents a language. WebSphere Commerce supports multiple languages and is translated into ten languages by default. Using the predefined ISO codes users can add other supported languages.';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `language`
--

LOCK TABLES `language` WRITE;
/*!40000 ALTER TABLE `language` DISABLE KEYS */;
/*!40000 ALTER TABLE `language` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `member`
--

DROP TABLE IF EXISTS `member`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `member` (
  `MEMBER_ID` bigint(20) NOT NULL COMMENT 'ID for the member, a unique primary key for this table.',
  `TYPE` char(3) NOT NULL COMMENT 'The type of member as follows: ',
  `STATE` int(11) DEFAULT NULL COMMENT 'The registration approval status as follows: ',
  `OPTCOUNTER` smallint(6) DEFAULT NULL COMMENT 'The optimistic concurrency control counter for the table.',
  PRIMARY KEY (`MEMBER_ID`),
  KEY `index2` (`MEMBER_ID`,`TYPE`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Stores the list of members (participants) of the WebSphere Commerce system. A member is either a user, an organizational entity or a member group.';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `member`
--

LOCK TABLES `member` WRITE;
/*!40000 ALTER TABLE `member` DISABLE KEYS */;
/*!40000 ALTER TABLE `member` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `qtyunit`
--

DROP TABLE IF EXISTS `qtyunit`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `qtyunit` (
  `QTYUNIT_ID` char(16) NOT NULL COMMENT 'A uniquely assigned identifier. Several identifiers are defined. They are specified in the UN/CEFACT Working Party. Which is on Facilitation of International Trade Procedures (WP.4), Recommendation No. 20, Codes for Units of Measure Used in International Trade.',
  `OPTCOUNTER` smallint(6) DEFAULT NULL COMMENT 'Reserved for internal use.',
  PRIMARY KEY (`QTYUNIT_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Each row of this table represents a QuantityUnit. A QuantityUnit is a unit of measurement, such as kilogram, meter, liter, pound, foot, quart, and so on. Note: Do not remove the row for the default QTYUNIT_ID C62 (the unitless unit).';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `qtyunit`
--

LOCK TABLES `qtyunit` WRITE;
/*!40000 ALTER TABLE `qtyunit` DISABLE KEYS */;
/*!40000 ALTER TABLE `qtyunit` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `store`
--

DROP TABLE IF EXISTS `store`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `store` (
  `STORE_ID` int(11) NOT NULL COMMENT 'Generated unique key.',
  `STOREGRP_ID` int(11) NOT NULL COMMENT 'The store group for this store.',
  `STORECGRY_ID` int(11) DEFAULT NULL COMMENT 'The store category, if any, for this store.',
  `LANGUAGE_ID` int(11) DEFAULT NULL COMMENT 'The default language for information displayed to customers shopping in the store. For a list of language components, see the LANGUAGE table.',
  `FFMCENTER_ID` int(11) DEFAULT NULL COMMENT 'The default fulfillment center for the store.',
  `STATUS` int(11) NOT NULL DEFAULT '1' COMMENT 'The status of the store. Valid values are: 1open0closed-1suspended',
  `STORELEVEL` char(10) DEFAULT NULL COMMENT 'STORELEVEL column is used as a flag to tell if various features are used in the store. The possible values are MC and MOBILE comma separated. MCThe store uses store functions in Management Center.MOBILEThe store has a mobile presence. Enables mapping of user agent to device format by using the wc-devices.xml file.',
  `DIRECTORY` varchar(254) DEFAULT NULL COMMENT 'The base name of the directory in which store-specific Web assets, such as JSP files and property files, are found.',
  `QUOTEGOODFOR` int(11) DEFAULT '43200' COMMENT 'If this many seconds have passed since an Order was prepared and the customer has not committed to pay, the prices and other monetary amounts in the Order may change when OrderProcess is run.',
  `ALLOCATIONGOODFOR` int(11) NOT NULL DEFAULT '43200' COMMENT 'When this many seconds have passed since the allocations were made, the ReleaseExpiredAllocations scheduler job can reverse available to promise (ATP) inventory allocations. If 0, ATP inventory allocation is not used by this store, and the INVENTORY table is used instead.',
  `MAXBOOFFSET` int(11) NOT NULL DEFAULT '7776000' COMMENT 'The maximum number of seconds that an item can be backordered. If the estimated availability time for a backordered order item exceeds this many seconds into the future, the availability date will automatically be set to this many seconds into the future. Thus, an item cannot be backordered longer than the interval specified here.',
  `REJECTEDORDEXPIRY` int(11) DEFAULT '259200' COMMENT 'Orders with payment in declined state longer than this many seconds are candidates for cancellation.',
  `FFMCSELECTIONFLAGS` int(11) NOT NULL DEFAULT '0' COMMENT 'Contains bit flags that specify policy used by the default implementation of GetEligibleFulfillmentCenters concerning the selection of a fulfillment center for an order item whose status is: •1 = preferCurrent, give preference to the currently assigned fulfillment center, if an',
  `BOPMPADFACTOR` int(11) DEFAULT '0' COMMENT 'If this store calculates order amounts (such as taxes or shipping charges) differently for different fulfillment centers, the order amount for a previously submitted order might change when fulfillment centers are allocated for backordered order items. This column specifies the percentage amount ("padding factor") by which the order amount presented to WebSphere Commerce Payments can be increased, if necessary. For example, specify 5 to allow an increase of up to 5 percent.',
  `RTNFFMCTR_ID` int(11) DEFAULT NULL COMMENT 'The ID of the fulfillment center that is used as the default for returning merchandise to the store.',
  `DEFAULTBOOFFSET` int(11) NOT NULL DEFAULT '7776000' COMMENT 'When an estimated availability time cannot be determined for a backordered order item, by default, it will be set to this many seconds into the future.',
  `PRICEREFFLAGS` int(11) NOT NULL DEFAULT '0' COMMENT 'Contains bit flags that control which trading agreements and offers are searched when prices are refreshed by the default implementation of the GetContractunitPrices task command: •0 = Default. Use trading agreements and offers referenced by order items. The task command fails if the trading agreements or offers cannot be used. The tradingId and offerId are not saved to the ORDITRD and ORDIOFFER table',
  `STORETYPE` char(1) DEFAULT NULL COMMENT 'Indicates one of the following store types. This indicator is used by a user interface to provide appropriate functions depending on the store type: •B2C = Consumer dire',
  `RMAGOODFOR` int(11) DEFAULT '86400' COMMENT 'The time period in seconds for which return merchandise authorization (RMA) calculations are valid. If this time period elapses before an RMA is completed, charges or credits and approval will be recalculated.',
  `AVSACCEPTCODES` varchar(64) DEFAULT NULL COMMENT 'The WebSphere Commerce Payments AVS result codes that the store considers acceptable: •0 = Both street address and postal code matc',
  `CRTDBYCNTR_ID` bigint(20) DEFAULT NULL COMMENT 'The contract used to create the store.',
  `LASTUPDATESTATUS` timestamp NULL DEFAULT NULL COMMENT 'Indicates the last time the status of the store was updated.',
  `OPTCOUNTER` smallint(6) DEFAULT NULL COMMENT 'The optimistic concurrency control counter for the table.',
  `ALLOCATIONOFFSET` int(11) NOT NULL DEFAULT '86400' COMMENT 'Amount of time before the requested ship date when inventory allocation should be performed. This time period provides a buffer for the store to reserve the inventory to the order and also allow for enough time to obtain inventory should there be an insufficient amount. See REQUESTEDSHIPDATE in ORDERITEMS.',
  `MAXFOOFFSET` int(11) DEFAULT '7776000' COMMENT 'The maximum period of time that can be requested for a future ship date after the date the requested ship date is entered. See REQUESTEDSHIPDATE in ORDERITEMS.',
  `INVENTORYOPFLAG` int(11) NOT NULL DEFAULT '0' COMMENT 'Contains bit flags indicating how to perform inventory operations. A value of 1 indicates that the RECEIPT table is updated during shipment confirmation.',
  `BLOCKINGACTIVE` smallint(6) DEFAULT '1' COMMENT 'Specifies whether the order blocking feature is in use. The order blocking feature can be disabled for this particular store by setting this field to 0. The default value is 1.',
  `BLKEXTASYNCH` smallint(6) NOT NULL DEFAULT '1' COMMENT 'Allows the merchant-extensible code for order blocking to be run asynchronously. This column can be used when a merchant wants to test for blocking conditions by connecting to external systems. To enable this feature, this column must be set to 1. By default, it is turned off (that is, set to 0).',
  `PERSISTENTSESSION` smallint(6) DEFAULT NULL COMMENT '•0 = The rememberMe function is disabled for registered customers and guest customers. This is the default valu',
  `ORDERHISTACTIVE` char(1) NOT NULL DEFAULT 'Y' COMMENT 'Indicates whether order change history tracking is enabled. The default value is Y (Yes).',
  `INVENTORYSYSTEM` smallint(6) NOT NULL DEFAULT '-1' COMMENT 'Indicates which inventory system is used: •-1 = ATP (Default valu',
  `UP_DIRECTORY` varchar(254) DEFAULT NULL COMMENT 'The equivalent value of the DIRECTORY column in upper case characters. This column is used only for DB2 (LUW) database-types to enhance performance of text-based searches issued from Management Center.',
  PRIMARY KEY (`STORE_ID`),
  KEY `index2` (`FFMCENTER_ID`),
  KEY `index3` (`STORECGRY_ID`),
  KEY `index4` (`RTNFFMCTR_ID`),
  KEY `index5` (`CRTDBYCNTR_ID`),
  KEY `index6` (`STOREGRP_ID`),
  KEY `index7` (`UP_DIRECTORY`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Each row of this table represents a store. A store is a store entity.';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `store`
--

LOCK TABLES `store` WRITE;
/*!40000 ALTER TABLE `store` DISABLE KEYS */;
/*!40000 ALTER TABLE `store` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `storecat`
--

DROP TABLE IF EXISTS `storecat`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `storecat` (
  `CATALOG_ID` bigint(20) NOT NULL COMMENT 'The reference number of the Catalog.',
  `STOREENT_ID` int(11) NOT NULL COMMENT 'The reference number of the StoreEntity.',
  `MASTERCATALOG` char(1) DEFAULT NULL COMMENT 'Specifies a master catalog for the Store. A value of 1 indicates that this Catalog is designated as a master catalog.',
  `LASTUPDATE` timestamp NULL DEFAULT NULL COMMENT 'Indicates the last time that this relationship was updated.',
  `OPTCOUNTER` smallint(6) DEFAULT NULL COMMENT 'The optimistic concurrency control counter for the table.',
  PRIMARY KEY (`CATALOG_ID`,`STOREENT_ID`),
  KEY `index2` (`STOREENT_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='This table holds the relationship between StoreEntities and the Catalogs that they offer.';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `storecat`
--

LOCK TABLES `storecat` WRITE;
/*!40000 ALTER TABLE `storecat` DISABLE KEYS */;
/*!40000 ALTER TABLE `storecat` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `storeent`
--

DROP TABLE IF EXISTS `storeent`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `storeent` (
  `STOREENT_ID` int(11) NOT NULL COMMENT 'Generated unique key.',
  `MEMBER_ID` bigint(20) NOT NULL COMMENT 'The owner of the StoreEntity.',
  `TYPE` char(1) NOT NULL COMMENT 'The kind of StoreEntity this row represents. Valid values are as follows: ',
  `SETCCURR` char(3) DEFAULT NULL COMMENT 'The default currency for a StoreEntity that will be used by a customer who has not specified a preferred currency. This is a currency code as per ISO 4217 standards. If the currency code is NULL for a Store, the default currency is obtained from its StoreGroup. See also the STORELANG table.',
  `IDENTIFIER` varchar(254) NOT NULL COMMENT 'A string that, together with MEMBER_ID, uniquely identifies the StoreEntity.',
  `MARKFORDELETE` int(11) NOT NULL DEFAULT '0' COMMENT 'Indicates if the StoreEntity has been marked for deletion: ',
  `OPTCOUNTER` smallint(6) DEFAULT NULL COMMENT 'The optimistic concurrency control counter for the table.',
  PRIMARY KEY (`STOREENT_ID`),
  UNIQUE KEY `UNIQUEINDEX` (`MEMBER_ID`,`IDENTIFIER`),
  KEY `index3` (`MEMBER_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Each row of this table represents a StoreEntity. A StoreEntity is an abstract superclass that can represent either a Store or a StoreGroup.';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `storeent`
--

LOCK TABLES `storeent` WRITE;
/*!40000 ALTER TABLE `storeent` DISABLE KEYS */;
/*!40000 ALTER TABLE `storeent` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2014-06-13 16:38:51
