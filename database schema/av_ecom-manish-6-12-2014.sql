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


CREATE TABLE `catreltype` (
  `CATRELTYPE_ID` char(32) NOT NULL COMMENT 'The identifier of this catalog entry relationship type:',
  `DESCRIPTION` varchar(254) DEFAULT NULL COMMENT 'A description for this catalog entry relationship type.',
  `FIELD1` int(11) DEFAULT NULL COMMENT 'Customizable',
  `FIELD2` float(20,5) DEFAULT NULL COMMENT 'Customizable',
  `FIELD3` varchar(254) DEFAULT NULL COMMENT 'Customizable',
  `OPTCOUNTER` int(11) DEFAULT NULL COMMENT 'The optimistic concurrency control counter for the table.',
  PRIMARY KEY (`CATRELTYPE_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COMMENT='This table describes the types of containment relationships ';


CREATE TABLE `devicefmt` (
  `DEVICETYPE_ID` CHAR(64) NOT NULL COMMENT 'Device type ID.',
  `DEVICEFMT_ID` INT NOT NULL COMMENT 'Device format ID. The default device format is -1, which t represents an HTTP Web browser.',
  `DISPLAYNAME` VARCHAR(254) NOT NULL COMMENT 'Display name for the device format.',
  `OPTCOUNTER` INT NULL COMMENT 'The optimistic concurrency control counter for the table.',
  PRIMARY KEY (`DEVICETYPE_ID`))ENGINE=InnoDB DEFAULT CHARSET=latin1 COMMENT='This table is for defining all the device format types.';
  
  
  CREATE TABLE `av_ecom`.`catentdesc` (
  `CATENTRY_ID` BIGINT NOT NULL,
  `LANGUAGE_ID` INT NOT NULL,
  `NAME` CHAR(128) NULL,
  `SHORTDESCRIPTION` VARCHAR(254) NULL,
  `LONGDESCRIPTION` LONGBLOB NULL,
  `THUMBNAIL` VARCHAR(254) NULL,
  `FULLIMAGE` VARCHAR(254) NULL COMMENT 'Indicates the length of time to availability of this catalog entry. Do not use this column to indicate inventory levels.',
  `AUXDESCRIPTION1` VARCHAR(4000) NULL,
  `AUXDESCRIPTION2` VARCHAR(4000) NULL,
  `AVAILABLE` INT NOT NULL COMMENT 'Indicates the length of time to availability of this catalog entry. Do not use this column to indicate inventory levels.',
  `XMLDETAIL` LONGBLOB NULL COMMENT 'Indicates the length of time to availability of this catalog entry. Do not use this column to indicate inventory levels.',
  `PUBLISHED` INT NOT NULL COMMENT 'Indicates whether this catalog entry should be displayed for the language indicated by LANGUAGE_ID:0/Catalog entry should not be displayed-1/catalog entry should be displayed',
  `AVAILABILITYDATE` TIMESTAMP NULL COMMENT 'Date this catalog entry becomes available.',
  `KEYWORD` VARCHAR(254) NULL COMMENT 'A keyword used for searching.',
  `OPTCOUNTER` INT NULL COMMENT 'The optimistic concurrency control counter for the table.',
  `UP_NAME` CHAR(128) NULL COMMENT 'The equivalent value of the NAME column in upper case characters. This column is used only for DB2 (LUW) database-types to enhance performance of text-based searches issued from Management Center.',
  PRIMARY KEY (`CATENTRY_ID`, `LANGUAGE_ID`),
  INDEX `LANGUAGE_ID+CATENTRY_ID+NAME+PUBLISHED` (`LANGUAGE_ID` ASC, `CATENTRY_ID` ASC, `NAME` ASC, `PUBLISHED` ASC),
  INDEX `NAME+LANGUAGE_ID+PUBLISHED` (`NAME` ASC, `LANGUAGE_ID` ASC, `PUBLISHED` ASC),
  INDEX `CATENTRY_ID` (`CATENTRY_ID` ASC),
  INDEX `UP_NAME` (`UP_NAME` ASC))
COMMENT = 'This table holds language-dependent information related to a' /* comment truncated */ /* catalog entry.*/;



