-- --------------------------------------------------------
-- Host:                         localhost
-- Server version:               10.3.18-MariaDB-1:10.3.18+maria~bionic - mariadb.org binary distribution
-- Server OS:                    debian-linux-gnu
-- HeidiSQL Version:             10.1.0.5464
-- KEH Customer Module:          0.0.1
-- Updated:                      02/13/2014
-- --------------------------------------------------------

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8 */;
/*!50503 SET NAMES utf8mb4 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;

-- Dumping structure for table customer_eav.attribute
CREATE TABLE IF NOT EXISTS `attribute` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `type` enum('ENTITY','SELECT','MULTISELECT','NUMERIC','TEXT','HTML','BOOLEAN','DATE','TIMESTAMP','DECIMAL','URL','EMAIL') NOT NULL,
  `tag` varchar(64) NOT NULL COMMENT 'Tag/Code',
  `description` varchar(128) DEFAULT NULL COMMENT 'Description/Label',
  `required` tinyint(1) NOT NULL DEFAULT 0,
  `default` mediumtext DEFAULT NULL,
  `disabled` tinyint(1) NOT NULL DEFAULT 0,
  `created` timestamp NOT NULL DEFAULT current_timestamp(),
  `modified` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `ref_type_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `tag` (`tag`)
) ENGINE=InnoDB AUTO_INCREMENT=0 DEFAULT CHARSET=utf8;

-- Data exporting was unselected.
-- Dumping structure for table customer_eav.entity
CREATE TABLE IF NOT EXISTS `entity` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=0 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT;

-- Data exporting was unselected.
-- Dumping structure for table customer_eav.entity_attribute_value
CREATE TABLE IF NOT EXISTS `entity_attribute_value` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `entity_id` int(11) NOT NULL,
  `type_attribute_id` int(11) NOT NULL,
  `val_entity` int(11) DEFAULT NULL,
  `val_text` mediumtext DEFAULT NULL,
  `val_number` decimal(18,6) DEFAULT NULL,
  `val_temporal` datetime DEFAULT NULL,
  `created` timestamp NOT NULL DEFAULT current_timestamp(),
  `modified` timestamp NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`),
  KEY `fk_entity_attribute_value_entity1_idx` (`entity_id`),
  KEY `fk_entity_attribute_value_entity2_idx` (`val_entity`),
  KEY `fk_entity_attribute_value_type_attribute1_idx` (`type_attribute_id`),
  KEY `val_number` (`val_number`),
  KEY `val_text` (`val_text`(100)),
  KEY `val_temporal` (`val_temporal`),
  CONSTRAINT `fk_entity_attribute_value_entity1` FOREIGN KEY (`entity_id`) REFERENCES `entity` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_entity_attribute_value_entity2` FOREIGN KEY (`val_entity`) REFERENCES `entity` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_entity_attribute_value_type_attribute1` FOREIGN KEY (`type_attribute_id`) REFERENCES `type_attribute` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=0 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT;

-- Data exporting was unselected.
-- Dumping structure for table customer_eav.entity_type
CREATE TABLE IF NOT EXISTS `entity_type` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `entity_id` int(11) NOT NULL,
  `type_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_entity_type_entity1_idx` (`entity_id`),
  KEY `fk_entity_type_type1_idx` (`type_id`),
  CONSTRAINT `fk_entity_type_entity1` FOREIGN KEY (`entity_id`) REFERENCES `entity` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_entity_type_type1` FOREIGN KEY (`type_id`) REFERENCES `type` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=0 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT;

-- Data exporting was unselected.
-- Dumping structure for table customer_eav.type
CREATE TABLE IF NOT EXISTS `type` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `tag` varchar(64) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `tag` (`tag`)
) ENGINE=InnoDB AUTO_INCREMENT=0 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT;

-- Data exporting was unselected.
-- Dumping structure for table customer_eav.type_attribute
CREATE TABLE IF NOT EXISTS `type_attribute` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `type_id` int(11) NOT NULL,
  `attribute_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_attribute_type_type1_idx` (`type_id`),
  KEY `fk_attribute_type_attribute1_idx` (`attribute_id`),
  CONSTRAINT `fk_attribute_type_attribute1` FOREIGN KEY (`attribute_id`) REFERENCES `attribute` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_attribute_type_type1` FOREIGN KEY (`type_id`) REFERENCES `type` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=0 DEFAULT CHARSET=latin1;

-- Data exporting was unselected.
/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IF(@OLD_FOREIGN_KEY_CHECKS IS NULL, 1, @OLD_FOREIGN_KEY_CHECKS) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;

INSERT INTO `attribute` (`id`, `type`, `tag`, `description`, `required`, `default`, `disabled`, `created`, `modified`, `ref_type_id`) VALUES (1, 'BOOLEAN', 'disabled', 'Indicates if a record is valid. 0 = record is valid, 1 = record is invalid', 1, '0', 0, '2020-02-13 22:43:02', '2020-02-13 22:43:02', NULL);
INSERT INTO `attribute` (`id`, `type`, `tag`, `description`, `required`, `default`, `disabled`, `created`, `modified`, `ref_type_id`) VALUES (2, 'DATE', 'created', 'shows the date the record was created', 1, NULL, 0, '2020-02-13 22:43:54', '2020-02-13 22:43:54', NULL);
INSERT INTO `attribute` (`id`, `type`, `tag`, `description`, `required`, `default`, `disabled`, `created`, `modified`, `ref_type_id`) VALUES (3, 'ENTITY', 'customer_id', 'guid for an customer entity', 0, NULL, 0, '2020-02-13 22:45:00', '2020-02-18 13:19:58', NULL);
INSERT INTO `attribute` (`id`, `type`, `tag`, `description`, `required`, `default`, `disabled`, `created`, `modified`, `ref_type_id`) VALUES (4, 'ENTITY', 'address_id', 'guid for an address_id', 0, NULL, 0, '2020-02-13 22:46:09', '2020-02-18 14:54:17', NULL);
INSERT INTO `attribute` (`id`, `type`, `tag`, `description`, `required`, `default`, `disabled`, `created`, `modified`, `ref_type_id`) VALUES (5, 'ENTITY', 'contact_id', 'guid for an contact entity', 0, NULL, 0, '2020-02-13 22:46:37', '2020-02-13 22:46:37', NULL);
INSERT INTO `attribute` (`id`, `type`, `tag`, `description`, `required`, `default`, `disabled`, `created`, `modified`, `ref_type_id`) VALUES (6, 'ENTITY', 'country_id', 'guid for an country entity', 0, NULL, 0, '2020-02-13 22:47:06', '2020-02-13 22:47:06', NULL);
INSERT INTO `attribute` (`id`, `type`, `tag`, `description`, `required`, `default`, `disabled`, `created`, `modified`, `ref_type_id`) VALUES (7, 'ENTITY', 'type_id', 'guid for an contactType entity', 0, NULL, 0, '2020-02-13 22:47:49', '2020-02-18 15:22:26', NULL);
INSERT INTO `attribute` (`id`, `type`, `tag`, `description`, `required`, `default`, `disabled`, `created`, `modified`, `ref_type_id`) VALUES (8, 'TEXT', 'title', 'person title abbrivation ', 0, NULL, 0, '2020-02-13 22:48:45', '2020-02-13 22:48:45', NULL);
INSERT INTO `attribute` (`id`, `type`, `tag`, `description`, `required`, `default`, `disabled`, `created`, `modified`, `ref_type_id`) VALUES (9, 'TEXT', 'first', 'given name of a person', 0, NULL, 0, '2020-02-13 22:50:07', '2020-02-13 22:50:07', NULL);
INSERT INTO `attribute` (`id`, `type`, `tag`, `description`, `required`, `default`, `disabled`, `created`, `modified`, `ref_type_id`) VALUES (10, 'TEXT', 'middle', 'middle name of a person', 0, NULL, 0, '2020-02-13 22:51:05', '2020-02-13 22:51:05', NULL);
INSERT INTO `attribute` (`id`, `type`, `tag`, `description`, `required`, `default`, `disabled`, `created`, `modified`, `ref_type_id`) VALUES (11, 'TEXT', 'last', 'persons surname', 0, NULL, 0, '2020-02-13 22:51:51', '2020-02-13 22:51:51', NULL);
INSERT INTO `attribute` (`id`, `type`, `tag`, `description`, `required`, `default`, `disabled`, `created`, `modified`, `ref_type_id`) VALUES (12, 'EMAIL', 'email', 'fully qualified email', 0, NULL, 0, '2020-02-13 22:52:27', '2020-02-13 22:52:27', NULL);
INSERT INTO `attribute` (`id`, `type`, `tag`, `description`, `required`, `default`, `disabled`, `created`, `modified`, `ref_type_id`) VALUES (13, 'DATE', 'birthday', 'birthday of a person', 0, NULL, 0, '2020-02-13 22:53:09', '2020-02-13 22:53:09', NULL);
INSERT INTO `attribute` (`id`, `type`, `tag`, `description`, `required`, `default`, `disabled`, `created`, `modified`, `ref_type_id`) VALUES (14, 'URL', 'facebook', 'facebook link ', 0, NULL, 0, '2020-02-13 22:53:48', '2020-02-13 22:53:48', NULL);
INSERT INTO `attribute` (`id`, `type`, `tag`, `description`, `required`, `default`, `disabled`, `created`, `modified`, `ref_type_id`) VALUES (15, 'URL', 'twitter', 'twitter link', 0, NULL, 0, '2020-02-13 22:54:10', '2020-02-13 22:54:10', NULL);
INSERT INTO `attribute` (`id`, `type`, `tag`, `description`, `required`, `default`, `disabled`, `created`, `modified`, `ref_type_id`) VALUES (16, 'URL', 'instagram', 'instagram url', 0, NULL, 0, '2020-02-13 22:54:35', '2020-02-13 22:54:35', NULL);
INSERT INTO `attribute` (`id`, `type`, `tag`, `description`, `required`, `default`, `disabled`, `created`, `modified`, `ref_type_id`) VALUES (17, 'URL', 'pintrest', 'pintrest url', 0, NULL, 0, '2020-02-13 22:55:11', '2020-02-18 08:05:49', NULL);
INSERT INTO `attribute` (`id`, `type`, `tag`, `description`, `required`, `default`, `disabled`, `created`, `modified`, `ref_type_id`) VALUES (18, 'URL', 'periscope', 'periscope url', 0, NULL, 0, '2020-02-13 22:55:37', '2020-02-13 22:55:37', NULL);
INSERT INTO `attribute` (`id`, `type`, `tag`, `description`, `required`, `default`, `disabled`, `created`, `modified`, `ref_type_id`) VALUES (19, 'TEXT', 'other', 'any other links, or urls that may useful for the customer record', 0, NULL, 0, '2020-02-13 22:56:20', '2020-02-13 22:56:20', NULL);
INSERT INTO `attribute` (`id`, `type`, `tag`, `description`, `required`, `default`, `disabled`, `created`, `modified`, `ref_type_id`) VALUES (20, 'URL', 'webpage', 'person or company webpage ', 0, NULL, 0, '2020-02-13 22:57:13', '2020-02-13 22:57:13', NULL);
INSERT INTO `attribute` (`id`, `type`, `tag`, `description`, `required`, `default`, `disabled`, `created`, `modified`, `ref_type_id`) VALUES (21, 'TEXT', 'type', 'the type of the entity, not to confuse with the entity type', 0, NULL, 0, '2020-02-13 22:59:40', '2020-02-13 22:59:40', NULL);
INSERT INTO `attribute` (`id`, `type`, `tag`, `description`, `required`, `default`, `disabled`, `created`, `modified`, `ref_type_id`) VALUES (22, 'NUMERIC', 'phone_country_code', 'the international phone country code', 0, NULL, 0, '2020-02-13 23:01:04', '2020-02-13 23:01:04', NULL);
INSERT INTO `attribute` (`id`, `type`, `tag`, `description`, `required`, `default`, `disabled`, `created`, `modified`, `ref_type_id`) VALUES (23, 'TEXT', 'phone_number', 'the phone number in the format of the country it is issued', 0, NULL, 0, '2020-02-13 23:01:49', '2020-02-13 23:01:49', NULL);
INSERT INTO `attribute` (`id`, `type`, `tag`, `description`, `required`, `default`, `disabled`, `created`, `modified`, `ref_type_id`) VALUES (24, 'NUMERIC', 'phone_ext', 'a phone extension', 0, NULL, 0, '2020-02-13 23:02:28', '2020-02-13 23:02:28', NULL);
INSERT INTO `attribute` (`id`, `type`, `tag`, `description`, `required`, `default`, `disabled`, `created`, `modified`, `ref_type_id`) VALUES (25, 'TEXT', 'company_name', 'name of a company', 0, NULL, 0, '2020-02-13 23:03:26', '2020-02-13 23:03:26', NULL);
INSERT INTO `attribute` (`id`, `type`, `tag`, `description`, `required`, `default`, `disabled`, `created`, `modified`, `ref_type_id`) VALUES (26, 'TEXT', 'address_1', 'first address line', 1, NULL, 0, '2020-02-13 23:03:53', '2020-02-13 23:04:09', NULL);
INSERT INTO `attribute` (`id`, `type`, `tag`, `description`, `required`, `default`, `disabled`, `created`, `modified`, `ref_type_id`) VALUES (27, 'TEXT', 'address_2', 'second address line if needed', 0, NULL, 0, '2020-02-13 23:04:35', '2020-02-13 23:04:35', NULL);
INSERT INTO `attribute` (`id`, `type`, `tag`, `description`, `required`, `default`, `disabled`, `created`, `modified`, `ref_type_id`) VALUES (28, 'TEXT', 'address_3', 'third address line if needed', 0, NULL, 0, '2020-02-13 23:05:01', '2020-02-13 23:05:01', NULL);
INSERT INTO `attribute` (`id`, `type`, `tag`, `description`, `required`, `default`, `disabled`, `created`, `modified`, `ref_type_id`) VALUES (29, 'TEXT', 'country_short', 'internation abbriviation of an country', 0, NULL, 0, '2020-02-13 23:06:55', '2020-02-13 23:06:55', NULL);
INSERT INTO `attribute` (`id`, `type`, `tag`, `description`, `required`, `default`, `disabled`, `created`, `modified`, `ref_type_id`) VALUES (30, 'TEXT', 'city', 'city name', 0, NULL, 0, '2020-02-13 23:07:33', '2020-02-13 23:07:33', NULL);
INSERT INTO `attribute` (`id`, `type`, `tag`, `description`, `required`, `default`, `disabled`, `created`, `modified`, `ref_type_id`) VALUES (31, 'TEXT', 'state', 'USA state abbrivation, or full state name if none US address', 0, NULL, 0, '2020-02-13 23:08:18', '2020-02-13 23:08:18', NULL);
INSERT INTO `attribute` (`id`, `type`, `tag`, `description`, `required`, `default`, `disabled`, `created`, `modified`, `ref_type_id`) VALUES (32, 'TEXT', 'postal_code', 'the postal code (zip) of the address, can be a US or international format', 0, NULL, 0, '2020-02-13 23:09:20', '2020-02-13 23:09:20', NULL);
INSERT INTO `attribute` (`id`, `type`, `tag`, `description`, `required`, `default`, `disabled`, `created`, `modified`, `ref_type_id`) VALUES (33, 'TEXT', 'abbreviated_code_2', 'two letter international (ISO) country code', 0, NULL, 0, '2020-02-13 23:10:53', '2020-02-13 23:10:53', NULL);
INSERT INTO `attribute` (`id`, `type`, `tag`, `description`, `required`, `default`, `disabled`, `created`, `modified`, `ref_type_id`) VALUES (34, 'TEXT', 'abbreviated_code_3', 'three letter internation (ISO) country code', 0, NULL, 0, '2020-02-13 23:11:48', '2020-02-13 23:11:48', NULL);
INSERT INTO `attribute` (`id`, `type`, `tag`, `description`, `required`, `default`, `disabled`, `created`, `modified`, `ref_type_id`) VALUES (35, 'TEXT', 'phone_code', 'the international telephone code', 0, NULL, 0, '2020-02-13 23:12:25', '2020-02-13 23:12:25', NULL);
INSERT INTO `attribute` (`id`, `type`, `tag`, `description`, `required`, `default`, `disabled`, `created`, `modified`, `ref_type_id`) VALUES (36, 'TEXT', 'extended_description', 'an extended description of an object', 0, NULL, 0, '2020-02-13 23:13:27', '2020-02-13 23:13:27', NULL);
INSERT INTO `attribute` (`id`, `type`, `tag`, `description`, `required`, `default`, `disabled`, `created`, `modified`, `ref_type_id`) VALUES (37, 'TEXT', 'tag', 'a tag of an object', 0, NULL, 0, '2020-02-13 23:14:26', '2020-02-13 23:14:26', NULL);
INSERT INTO `attribute` (`id`, `type`, `tag`, `description`, `required`, `default`, `disabled`, `created`, `modified`, `ref_type_id`) VALUES (38, 'TEXT', 'residential_status', 'if status of an confirmed address to business or residental, or N/A ', 0, NULL, 0, '2020-02-13 23:17:20', '2020-02-13 23:17:20', NULL);
INSERT INTO `attribute` (`id`, `type`, `tag`, `description`, `required`, `default`, `disabled`, `created`, `modified`, `ref_type_id`) VALUES (39, 'BOOLEAN', 'confirmed', 'indicate if an object is confirmed, 0 = not confirmed, 1 = confirmed', 0, '0', 0, '2020-02-13 23:18:11', '2020-02-13 23:20:33', NULL);

INSERT INTO `type` (`id`, `tag`) VALUES (3, 'Address');
INSERT INTO `type` (`id`, `tag`) VALUES (2, 'Contact');
INSERT INTO `type` (`id`, `tag`) VALUES (5, 'ContactType');
INSERT INTO `type` (`id`, `tag`) VALUES (4, 'Country');
INSERT INTO `type` (`id`, `tag`) VALUES (1, 'Customer');

INSERT INTO `type_attribute` (`id`, `type_id`, `attribute_id`) VALUES (1, 1, 1);
INSERT INTO `type_attribute` (`id`, `type_id`, `attribute_id`) VALUES (2, 1, 2);
INSERT INTO `type_attribute` (`id`, `type_id`, `attribute_id`) VALUES (3, 1, 8);
INSERT INTO `type_attribute` (`id`, `type_id`, `attribute_id`) VALUES (4, 1, 9);
INSERT INTO `type_attribute` (`id`, `type_id`, `attribute_id`) VALUES (5, 1, 10);
INSERT INTO `type_attribute` (`id`, `type_id`, `attribute_id`) VALUES (6, 1, 11);
INSERT INTO `type_attribute` (`id`, `type_id`, `attribute_id`) VALUES (7, 1, 12);
INSERT INTO `type_attribute` (`id`, `type_id`, `attribute_id`) VALUES (8, 1, 13);
INSERT INTO `type_attribute` (`id`, `type_id`, `attribute_id`) VALUES (9, 1, 14);
INSERT INTO `type_attribute` (`id`, `type_id`, `attribute_id`) VALUES (10, 1, 15);
INSERT INTO `type_attribute` (`id`, `type_id`, `attribute_id`) VALUES (11, 1, 16);
INSERT INTO `type_attribute` (`id`, `type_id`, `attribute_id`) VALUES (12, 1, 17);
INSERT INTO `type_attribute` (`id`, `type_id`, `attribute_id`) VALUES (13, 1, 18);
INSERT INTO `type_attribute` (`id`, `type_id`, `attribute_id`) VALUES (14, 1, 19);
INSERT INTO `type_attribute` (`id`, `type_id`, `attribute_id`) VALUES (15, 1, 20);
INSERT INTO `type_attribute` (`id`, `type_id`, `attribute_id`) VALUES (16, 2, 1);
INSERT INTO `type_attribute` (`id`, `type_id`, `attribute_id`) VALUES (17, 2, 2);
INSERT INTO `type_attribute` (`id`, `type_id`, `attribute_id`) VALUES (18, 2, 3);
INSERT INTO `type_attribute` (`id`, `type_id`, `attribute_id`) VALUES (19, 2, 4);
INSERT INTO `type_attribute` (`id`, `type_id`, `attribute_id`) VALUES (20, 2, 21);
INSERT INTO `type_attribute` (`id`, `type_id`, `attribute_id`) VALUES (21, 2, 22);
INSERT INTO `type_attribute` (`id`, `type_id`, `attribute_id`) VALUES (22, 2, 23);
INSERT INTO `type_attribute` (`id`, `type_id`, `attribute_id`) VALUES (23, 2, 24);
INSERT INTO `type_attribute` (`id`, `type_id`, `attribute_id`) VALUES (24, 2, 12);
INSERT INTO `type_attribute` (`id`, `type_id`, `attribute_id`) VALUES (25, 3, 1);
INSERT INTO `type_attribute` (`id`, `type_id`, `attribute_id`) VALUES (26, 3, 2);
INSERT INTO `type_attribute` (`id`, `type_id`, `attribute_id`) VALUES (27, 3, 25);
INSERT INTO `type_attribute` (`id`, `type_id`, `attribute_id`) VALUES (28, 3, 9);
INSERT INTO `type_attribute` (`id`, `type_id`, `attribute_id`) VALUES (29, 3, 10);
INSERT INTO `type_attribute` (`id`, `type_id`, `attribute_id`) VALUES (30, 3, 11);
INSERT INTO `type_attribute` (`id`, `type_id`, `attribute_id`) VALUES (31, 3, 8);
INSERT INTO `type_attribute` (`id`, `type_id`, `attribute_id`) VALUES (32, 3, 26);
INSERT INTO `type_attribute` (`id`, `type_id`, `attribute_id`) VALUES (33, 3, 27);
INSERT INTO `type_attribute` (`id`, `type_id`, `attribute_id`) VALUES (34, 3, 28);
INSERT INTO `type_attribute` (`id`, `type_id`, `attribute_id`) VALUES (35, 3, 29);
INSERT INTO `type_attribute` (`id`, `type_id`, `attribute_id`) VALUES (36, 3, 30);
INSERT INTO `type_attribute` (`id`, `type_id`, `attribute_id`) VALUES (37, 3, 31);
INSERT INTO `type_attribute` (`id`, `type_id`, `attribute_id`) VALUES (38, 3, 32);
INSERT INTO `type_attribute` (`id`, `type_id`, `attribute_id`) VALUES (39, 3, 38);
INSERT INTO `type_attribute` (`id`, `type_id`, `attribute_id`) VALUES (40, 3, 39);
INSERT INTO `type_attribute` (`id`, `type_id`, `attribute_id`) VALUES (41, 4, 1);
INSERT INTO `type_attribute` (`id`, `type_id`, `attribute_id`) VALUES (42, 4, 2);
INSERT INTO `type_attribute` (`id`, `type_id`, `attribute_id`) VALUES (43, 4, 33);
INSERT INTO `type_attribute` (`id`, `type_id`, `attribute_id`) VALUES (44, 4, 34);
INSERT INTO `type_attribute` (`id`, `type_id`, `attribute_id`) VALUES (45, 4, 35);
INSERT INTO `type_attribute` (`id`, `type_id`, `attribute_id`) VALUES (46, 4, 36);
INSERT INTO `type_attribute` (`id`, `type_id`, `attribute_id`) VALUES (47, 5, 1);
INSERT INTO `type_attribute` (`id`, `type_id`, `attribute_id`) VALUES (48, 5, 2);
INSERT INTO `type_attribute` (`id`, `type_id`, `attribute_id`) VALUES (49, 5, 37);
INSERT INTO `type_attribute` (`id`, `type_id`, `attribute_id`) VALUES (50, 3, 3);
INSERT INTO `type_attribute` (`id`, `type_id`, `attribute_id`) VALUES (51, 3, 6);
INSERT INTO `type_attribute` (`id`, `type_id`, `attribute_id`) VALUES (52, 2, 7);
INSERT INTO `type_attribute` (`id`, `type_id`, `attribute_id`) VALUES (53, 2, 6);


