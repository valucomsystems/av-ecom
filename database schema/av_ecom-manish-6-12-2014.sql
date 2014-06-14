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



CREATE TABLE `av_ecom`.`dispentrel` (
  `CATENTRY_ID` BIGINT NOT NULL COMMENT 'The reference number of the CatalogEntry for which this page name displays. A value of 0 indicates that this page name will be used for for all CatalogEntries.',
  `DISPENTREL_ID` BIGINT NOT NULL COMMENT 'The reference number of this entry.',
  `LANGUAGE_ID` INT NULL COMMENT 'The language in which this page displays. For a list of language components, see the LANGUAGE table.',
  `DEVICEFMT_ID` INT NOT NULL COMMENT 'The reference number of the device type that the page will be displayed on. Foreign key to the DEVICEFMT table.',
  `STOREENT_ID` INT NOT NULL COMMENT 'The reference number of the Store for which this page will be displayed.',
  `PAGENAME` VARCHAR(254) NOT NULL COMMENT 'The name and path of the display template page. The path is relative to the application document root.',
  `CATENTTYPE_ID` CHAR(16) NOT NULL DEFAULT 0 COMMENT 'The type of CatalogEntry that this page will be used to display. Foreign key to the CATENTTYPE table. For example, if this column is designated as \"BundleBean\", then this page will be used to display Bundles.',
  `AUCTIONSTATE` INT NOT NULL DEFAULT 0 COMMENT 'The flag that indicates that this template page displays a CatalogEntry that is on auction. A value of 0 indicates that it is not an auction template, while a value of 1 indicates that it is.',
  `MBRGRP_ID` BIGINT NOT NULL COMMENT 'The reference number of the MemberGroup for which this template page will be displayed. A value of 0 indicates that this template page will be used for for all MemberGroups.',
  `DESCRIPTION` VARCHAR(45) NULL COMMENT 'A description of this display page.',
  `FIELD1` VARCHAR(254) NULL COMMENT 'Customizable',
  `RANK` DOUBLE NULL COMMENT 'A sequence number used to break ties when more than one page satisfies the selection criteria. The larger the rank, the lower the precedence of the page.',
  `FIELD2` VARCHAR(254) NULL COMMENT 'Customizable',
  `OPTCOUNTER` INT NULL COMMENT 'The optimistic concurrency control counter for the table.',
  PRIMARY KEY (`DISPENTREL_ID`),
  UNIQUE INDEX `I0000092` (`DISPENTREL_ID` ASC, `STOREENT_ID` ASC, `CATENTRY_ID` ASC, `CATENTTYPE_ID` ASC, `MBRGRP_ID` ASC, `AUCTIONSTATE` ASC, `RANK` ASC, `LANGUAGE_ID` ASC),
  INDEX `I0000093` (`AUCTIONSTATE` ASC, `MBRGRP_ID` ASC, `CATENTRY_ID` ASC, `STOREENT_ID` ASC),
  INDEX `I0000094` (`CATENTRY_ID` ASC, `CATENTTYPE_ID` ASC, `STOREENT_ID` ASC, `MBRGRP_ID` ASC),
  INDEX `CATENTTYPE_ID` (`CATENTTYPE_ID` ASC),
  INDEX `MBRGRP_ID` (`MBRGRP_ID` ASC),
  INDEX `STOREENT_ID` (`STOREENT_ID` ASC))
COMMENT = 'This table holds the page names used to display CatalogEntri' /* comment truncated */ /*es. The selection is based on Store, MemberGroup, DeviceType, CatalogEntryType, CatalogEntry, AuctionState, Language, or any combination of the above.*/;


CREATE TABLE `catentattr` (
  `CATENTATTR_ID` bigint(20) NOT NULL,
  `LANGUAGE_ID` int(11) NOT NULL,
  `CATENTRY_ID` bigint(20) NOT NULL,
  `NAME` varchar(254) NOT NULL,
  `VALUE` varchar(254) NOT NULL,
  `DESCRIPTION` varchar(254) DEFAULT NULL,
  `FIELD1` int(11) DEFAULT NULL,
  `FIELD2` varchar(254) DEFAULT NULL,
  `FIELD3` varchar(254) DEFAULT NULL,
  `OPTCOUNTER` smallint(6) DEFAULT NULL,
  PRIMARY KEY (`CATENTATTR_ID`),
  UNIQUE KEY `CATENTRY_ID+LANGUAGE_ID+NAME` (`CATENTRY_ID`,`LANGUAGE_ID`,`NAME`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COMMENT='This table is deprecated and is provided for backward compat';

CREATE TABLE `catgroup` (
  `CATGROUP_ID` bigint(20) NOT NULL,
  `MEMBER_ID` bigint(20) NOT NULL,
  `IDENTIFIER` varchar(254) DEFAULT NULL,
  `MARKFORDELETE` int(11) NOT NULL,
  `LASTUPDATE` timestamp NULL DEFAULT NULL,
  `FIELD1` varchar(254) DEFAULT NULL,
  `FIELD2` varchar(254) DEFAULT NULL,
  `RANK` double DEFAULT NULL,
  `OPTCOUNTER` int(11) DEFAULT NULL COMMENT 'The optimistic concurrency control counter for the table.',
  `UP_IDENTIFIER` varchar(254) DEFAULT NULL COMMENT 'The equivalent value of the IDENTIFIER column in upper case characters. This column is used only for DB2 (LUW) database-types to enhance performance of text-based searches issued from Management Center.',
  PRIMARY KEY (`CATGROUP_ID`),
  UNIQUE KEY `IDENTIFIER+MEMBER_ID` (`IDENTIFIER`,`MEMBER_ID`),
  KEY `MEMBER_ID` (`MEMBER_ID`),
  KEY `UP_IDENTIFIER` (`UP_IDENTIFIER`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COMMENT='This table hold the information related to a catalog group. ';

CREATE TABLE `mbrgrp` (
  `MBRGRP_ID` bigint(20) NOT NULL,
  `OWNER_ID` bigint(20) NOT NULL,
  `FIELD1` varchar(254) DEFAULT NULL,
  `DESCRIPTION` varchar(512) DEFAULT NULL,
  `FIELD2` varchar(254) DEFAULT NULL,
  `MBRGRPNAME` varchar(254) NOT NULL,
  `FIELD3` varchar(254) DEFAULT NULL,
  `OID` varchar(64) DEFAULT NULL,
  `LASTUPDATE` timestamp NULL DEFAULT NULL,
  `LASTUPDATEDBY` varchar(254) DEFAULT NULL,
  `OPTCOUNTER` smallint(6) DEFAULT NULL,
  `UP_MBRGRPNAME` varchar(254) DEFAULT NULL,
  PRIMARY KEY (`MBRGRP_ID`),
  UNIQUE KEY `OWNER_ID+MBRGRPNAME` (`OWNER_ID`,`MBRGRP_ID`,`UP_MBRGRPNAME`),
  KEY `UP_MBRGRPNAME` (`UP_MBRGRPNAME`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COMMENT='This table stores member groups defined in the WebSphere Com';


CREATE TABLE `storecent` (
  `STOREENT_ID` int(11) NOT NULL,
  `CATENTRY_ID` bigint(20) NOT NULL,
  `OPTCOUNTER` smallint(6) DEFAULT NULL,
  PRIMARY KEY (`STOREENT_ID`,`CATENTRY_ID`),
  KEY `CATENTRY_ID` (`CATENTRY_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COMMENT='This table holds the relationship between StoreEntities and ';


CREATE TABLE `baseitem` (
  `BASEITEM_ID` bigint(20) NOT NULL,
  `MEMBER_ID` bigint(20) NOT NULL,
  `ITEMTYPE_ID` char(4) NOT NULL,
  `QUANTITYMEASURE` char(16) NOT NULL DEFAULT 'C62',
  `LASTUPDATE` timestamp NULL DEFAULT NULL,
  `MARKFORDELETE` int(11) NOT NULL,
  `PARTNUMBER` varchar(72) NOT NULL,
  `QUANTITYMULTIPLE` double NOT NULL DEFAULT '1',
  `OPTCOUNTER` smallint(6) DEFAULT NULL,
  PRIMARY KEY (`BASEITEM_ID`),
  UNIQUE KEY `MEMBER_ID+PARTNUMBER` (`MEMBER_ID`,`PARTNUMBER`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COMMENT='BaseItems represent a general family of goods with a common ';


CREATE TABLE `itemspc` (
  `ITEMSPC_ID` bigint(20) NOT NULL,
  `LASTUPDATE` timestamp NULL DEFAULT NULL,
  `MEMBER_ID` bigint(20) NOT NULL,
  `MARKFORDELETE` int(11) NOT NULL,
  `BASEITEM_ID` bigint(20) NOT NULL,
  `DISCONTINUED` char(1) NOT NULL DEFAULT 'N',
  `PARTNUMBER` varchar(64) NOT NULL,
  `OPTCOUNTER` smallint(6) DEFAULT NULL,
  PRIMARY KEY (`ITEMSPC_ID`),
  UNIQUE KEY `PARTNUMBER+MEMBER_ID` (`PARTNUMBER`,`MEMBER_ID`),
  KEY `BASEITEM_ID+ITEMSPC_ID` (`BASEITEM_ID`,`ITEMSPC_ID`),
  KEY `ITEMSPC_ID+BASEITEM_ID+PARTNUMBER` (`ITEMSPC_ID`,`BASEITEM_ID`,`PARTNUMBER`),
  KEY `MEMBER_ID` (`MEMBER_ID`),
  KEY `DISCONTINUED` (`DISCONTINUED`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COMMENT='Information about specified items. A specified item is a pro';
