create database if not exists `av_ecom`;

USE `av_ecom`;

CREATE DATABASE `av_ecom` /*!40100 DEFAULT CHARACTER SET latin1 */;
CREATE TABLE `catentship` (
  `CATENTRY_ID` bigint(20) NOT NULL AUTO_INCREMENT,
  `WEIGHT` float(5,2) NOT NULL DEFAULT '0.00',
  `WEIGHTMEASURE` char(16) DEFAULT NULL,
  `LENGTH` float(5,2) DEFAULT NULL,
  `WIDTH` float(5,2) DEFAULT NULL,
  `HEIGHT` float(5,2) DEFAULT NULL,
  `SIZEMEASURE` char(16) DEFAULT NULL,
  `NOMINALQUANTITY` float(5,2) NOT NULL DEFAULT '1.00',
  `QUANTITYMULTIPLE` float(5,2) NOT NULL DEFAULT '1.00',
  `QUANTITYMEASURE` char(16) NOT NULL DEFAULT 'C62',
  `OPTCOUNTER` int(5) DEFAULT NULL,
  PRIMARY KEY (`CATENTRY_ID`)
) ENGINE=MyISAM AUTO_INCREMENT=181 DEFAULT CHARSET=latin1;

CREATE TABLE `listprice` (
  `CATENTRY_ID` bigint(20) NOT NULL,
  `CURRENCY` char(3) NOT NULL,
  `LISTPRICE` float(20,5) NOT NULL,
  `OPTCOUNTER` int(5) DEFAULT NULL,
  PRIMARY KEY (`CATENTRY_ID`,`CURRENCY`),
  KEY `idx_listprice_CATENTRY_ID_CURRENCY_LISTPRICE` (`CATENTRY_ID`,`CURRENCY`,`LISTPRICE`),
  KEY `idx_listprice_CATENTRY_ID` (`CATENTRY_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

CREATE TABLE `setcurr` (
  `SETCCURR` char(3) NOT NULL,
  `SETCCODE` int(11) NOT NULL,
  `SETCEXP` int(11) NOT NULL,
  `SETCNOTE` varchar(45) DEFAULT NULL,
  `OPTCOUNTER` int(11) DEFAULT NULL,
  PRIMARY KEY (`SETCCURR`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COMMENT='The table contains information about the different national ';

CREATE TABLE `av_ecom`.`catenttype` (
  `CATENTTYPE_ID` CHAR(16) NOT NULL COMMENT 'The identifier of this catalog entry type.',
  `DESCRIPTION` VARCHAR(254) NULL COMMENT 'The description for this catalog entry type.',
  `OPTCOUNTER` INT NULL COMMENT 'The optimistic concurrency control counter for the table.',
  PRIMARY KEY (`CATENTTYPE_ID`))
COMMENT = 'This table defines all possible types of catalog entries. Ex' /* comment truncated */ /*amples of catalog entry types are ProductBean, ItemBean, PackageBean, BundleBean and DynamicKitBean.*/;


CREATE TABLE `catentrel` (
  `CATENTRY_ID_PARENT` bigint(20) NOT NULL COMMENT 'The reference number of the source catalog entry in this relationship.',
  `CATRELTYPE_ID` char(32) NOT NULL COMMENT 'The type of relationship:',
  `SEQUENCE` bigint(20) NOT NULL DEFAULT '0' COMMENT 'The reference number of the target catalog entry in this relationship.',
  `QUANTITY` double DEFAULT NULL COMMENT 'A quantity that can be associated with the relationship.',
  `FIELD1` varchar(254) DEFAULT NULL COMMENT 'Customizable',
  `FIELD2` int(11) DEFAULT NULL COMMENT 'Customizable',
  `FIELD3` float(20,5) DEFAULT NULL COMMENT 'Customizable',
  `OPTCOUNTER` int(11) DEFAULT NULL COMMENT 'The optimistic concurrency control counter for the table.',
  `CATENTRY_ID_CHILD` bigint(20) NOT NULL COMMENT 'The reference number of the target catalog entry in this relationship.',
  PRIMARY KEY (`CATENTRY_ID_PARENT`,`CATRELTYPE_ID`,`CATENTRY_ID_CHILD`),
  KEY `CATENTRY_ID_CHILD+CATRELTYPE_ID` (`CATENTRY_ID_CHILD`,`CATRELTYPE_ID`),
  KEY `CATENTRY_ID_PARENT` (`CATENTRY_ID_PARENT`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COMMENT='This table holds containment relationships between catalog e';


