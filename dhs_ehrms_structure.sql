-- --------------------------------------------------------
-- Host:                         10.193.111.234
-- Server version:               10.6.22-MariaDB-0ubuntu0.22.04.1-log - Ubuntu 22.04
-- Server OS:                    debian-linux-gnu
-- HeidiSQL Version:             12.10.0.7000
-- --------------------------------------------------------

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8 */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;


-- Dumping database structure for dhs_ehrms
CREATE DATABASE IF NOT EXISTS `dhs_ehrms` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci */;
USE `dhs_ehrms`;

-- Dumping structure for table dhs_ehrms.aebas_attendance_details
CREATE TABLE IF NOT EXISTS `aebas_attendance_details` (
  `org_id` varchar(10) NOT NULL,
  `log_date` date NOT NULL,
  `emp_id` varchar(20) NOT NULL,
  `org_emp_code` varchar(50) NOT NULL,
  `in_device_id` varchar(10) NOT NULL,
  `in_time` datetime NOT NULL,
  `out_device_id` varchar(10) NOT NULL,
  `out_time` datetime NOT NULL,
  `at_type` char(1) NOT NULL,
  `flag` tinyint(1) DEFAULT NULL,
  `scode` varchar(5) DEFAULT NULL,
  `state` varchar(50) DEFAULT NULL,
  `dcode` varchar(10) DEFAULT NULL,
  `district` varchar(50) DEFAULT NULL,
  `gps_lat` varchar(20) DEFAULT NULL,
  `gps_long` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`emp_id`,`log_date`),
  CONSTRAINT `FK_aebas_attendance_details_aebas_employee_details` FOREIGN KEY (`emp_id`) REFERENCES `aebas_employee_details` (`emp_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Data exporting was unselected.

-- Dumping structure for table dhs_ehrms.aebas_employee_details
CREATE TABLE IF NOT EXISTS `aebas_employee_details` (
  `emp_id` varchar(20) NOT NULL,
  `emp_cat` varchar(20) NOT NULL,
  `org_emp_code` varchar(50) NOT NULL,
  `org_id` varchar(50) NOT NULL,
  `org_name` varchar(255) NOT NULL,
  `dist_code` varchar(10) NOT NULL,
  `state_code` varchar(5) NOT NULL,
  `state` varchar(50) NOT NULL,
  `district` varchar(50) NOT NULL,
  `office_loc` varchar(10) NOT NULL,
  `loc_name` varchar(255) DEFAULT NULL,
  `designation` varchar(255) DEFAULT NULL,
  `emp_name` varchar(255) NOT NULL,
  `emp_dob` date DEFAULT NULL,
  `gender` char(1) NOT NULL,
  `emp_mail` varchar(255) DEFAULT NULL,
  `emp_mobile` varchar(15) DEFAULT NULL,
  `creation_date` datetime DEFAULT NULL,
  `division` varchar(100) DEFAULT NULL,
  `active_status` char(1) NOT NULL COMMENT 'A (Active)\r\nI (InActive)\r\nR (New Registered)\r\nT (Transfered)\r\nX (Blocked)',
  `is_bond_doctor` tinyint(3) unsigned NOT NULL DEFAULT 0,
  PRIMARY KEY (`emp_id`),
  KEY `FK_aebas_employee_details_aebas_mas_location` (`office_loc`) USING BTREE,
  KEY `is_bond_doctor` (`is_bond_doctor`),
  CONSTRAINT `FK_aebas_employee_details_aebas_mas_location` FOREIGN KEY (`office_loc`) REFERENCES `aebas_mas_location` (`loc_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Data exporting was unselected.

-- Dumping structure for table dhs_ehrms.aebas_employee_mapping
CREATE TABLE IF NOT EXISTS `aebas_employee_mapping` (
  `emp_code` bigint(20) unsigned NOT NULL,
  `attendance_id` varchar(8) NOT NULL,
  `office_loc` varchar(8) NOT NULL,
  `is_active` tinyint(4) unsigned NOT NULL DEFAULT 0,
  `created_at` datetime NOT NULL DEFAULT current_timestamp(),
  `created_by` bigint(20) unsigned NOT NULL,
  `updated_at` datetime DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `updated_by` bigint(20) unsigned DEFAULT NULL,
  `ip_address` varchar(50) DEFAULT NULL,
  `updated_ip_address` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`emp_code`),
  UNIQUE KEY `attendance_id_unq` (`attendance_id`) USING BTREE,
  KEY `FK_aebas_employee_mapping_aebas_mas_location` (`office_loc`),
  CONSTRAINT `FK_aebas_employee_mapping_aebas_employee_details` FOREIGN KEY (`attendance_id`) REFERENCES `aebas_employee_details` (`emp_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `FK_aebas_employee_mapping_aebas_mas_location` FOREIGN KEY (`office_loc`) REFERENCES `aebas_mas_location` (`loc_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `FK_aebas_employee_mapping_emp_basic_details` FOREIGN KEY (`emp_code`) REFERENCES `emp_basic_details` (`emp_code`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Data exporting was unselected.

-- Dumping structure for table dhs_ehrms.aebas_mas_designation
CREATE TABLE IF NOT EXISTS `aebas_mas_designation` (
  `desig_id` varchar(10) NOT NULL,
  `designation` varchar(255) NOT NULL,
  `desig_type` varchar(10) NOT NULL,
  `active_status` char(1) NOT NULL,
  `created_by` varchar(50) DEFAULT NULL,
  `creation_date` datetime DEFAULT NULL,
  `last_updated` varchar(50) DEFAULT NULL,
  `flag` tinyint(1) DEFAULT NULL,
  `desigeq_id` varchar(10) DEFAULT NULL,
  PRIMARY KEY (`desig_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Data exporting was unselected.

-- Dumping structure for table dhs_ehrms.aebas_mas_district
CREATE TABLE IF NOT EXISTS `aebas_mas_district` (
  `scode` varchar(5) NOT NULL,
  `dcode` varchar(10) NOT NULL,
  `district` varchar(100) NOT NULL,
  `active_status` char(1) DEFAULT NULL,
  `flag` tinyint(1) DEFAULT NULL,
  PRIMARY KEY (`dcode`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Data exporting was unselected.

-- Dumping structure for table dhs_ehrms.aebas_mas_location
CREATE TABLE IF NOT EXISTS `aebas_mas_location` (
  `loc_id` varchar(10) NOT NULL,
  `loc_name` varchar(100) NOT NULL,
  `state_code` varchar(5) NOT NULL,
  `dist_code` varchar(10) NOT NULL,
  `subdist_code` varchar(10) NOT NULL,
  `active_status` char(1) DEFAULT NULL,
  `created_by` varchar(50) DEFAULT NULL,
  `creation_date` datetime DEFAULT NULL,
  `last_updated` varchar(50) DEFAULT NULL,
  `flag` tinyint(1) DEFAULT NULL,
  `gps_lat` varchar(20) DEFAULT NULL,
  `gps_long` varchar(20) DEFAULT NULL,
  `type_id` int(11) unsigned DEFAULT NULL,
  `order_no` tinyint(4) unsigned DEFAULT NULL,
  PRIMARY KEY (`loc_id`),
  KEY `dist_code` (`dist_code`),
  KEY `FK_aebas_mas_location_mas_health_center_type` (`type_id`),
  CONSTRAINT `FK_aebas_mas_location_aebas_mas_district` FOREIGN KEY (`dist_code`) REFERENCES `aebas_mas_district` (`dcode`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `FK_aebas_mas_location_mas_health_center_type` FOREIGN KEY (`type_id`) REFERENCES `mas_health_center_type` (`type_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Data exporting was unselected.

-- Dumping structure for table dhs_ehrms.aebas_mas_org_building
CREATE TABLE IF NOT EXISTS `aebas_mas_org_building` (
  `build_id` varchar(10) NOT NULL,
  `org_id` varchar(10) DEFAULT NULL,
  `loc_id` varchar(10) NOT NULL,
  `build_name` varchar(150) DEFAULT NULL,
  `state_code` varchar(5) DEFAULT NULL,
  `dist_code` varchar(10) NOT NULL,
  `gps_cord` varchar(50) DEFAULT NULL,
  `active_status` char(1) DEFAULT NULL,
  `created_by` varchar(50) DEFAULT NULL,
  `creation_date` datetime DEFAULT NULL,
  `last_updated` datetime DEFAULT NULL,
  `flag` tinyint(1) DEFAULT NULL,
  PRIMARY KEY (`build_id`),
  KEY `FK_aebas_mas_org_building_aebas_mas_location` (`loc_id`),
  KEY `FK_aebas_mas_org_building_aebas_mas_district` (`dist_code`),
  CONSTRAINT `FK_aebas_mas_org_building_aebas_mas_district` FOREIGN KEY (`dist_code`) REFERENCES `aebas_mas_district` (`dcode`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `FK_aebas_mas_org_building_aebas_mas_location` FOREIGN KEY (`loc_id`) REFERENCES `aebas_mas_location` (`loc_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Data exporting was unselected.

-- Dumping structure for table dhs_ehrms.aebas_mas_org_shift
CREATE TABLE IF NOT EXISTS `aebas_mas_org_shift` (
  `org_id` varchar(10) NOT NULL,
  `shift_name` varchar(100) NOT NULL,
  `shift_start_date` date DEFAULT NULL,
  `shift_start_time` time DEFAULT NULL,
  `shift_end_date` date DEFAULT NULL,
  `shift_end_time` time DEFAULT NULL,
  `shift_type` char(1) DEFAULT NULL,
  `created_by` varchar(50) DEFAULT NULL,
  `created_date` datetime DEFAULT NULL,
  `modified_by` varchar(50) DEFAULT NULL,
  `modified_date` datetime DEFAULT NULL,
  `active_status` tinyint(1) DEFAULT NULL,
  PRIMARY KEY (`org_id`,`shift_name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Data exporting was unselected.

-- Dumping structure for table dhs_ehrms.aebas_mas_state
CREATE TABLE IF NOT EXISTS `aebas_mas_state` (
  `scode` varchar(5) NOT NULL,
  `state` varchar(100) NOT NULL,
  `active_status` char(1) DEFAULT NULL,
  `flag` tinyint(1) DEFAULT NULL,
  PRIMARY KEY (`scode`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Data exporting was unselected.

-- Dumping structure for table dhs_ehrms.aebas_today_attendance_details
CREATE TABLE IF NOT EXISTS `aebas_today_attendance_details` (
  `org_id` varchar(10) NOT NULL,
  `log_date` date NOT NULL,
  `emp_id` varchar(20) NOT NULL,
  `org_emp_code` varchar(50) NOT NULL,
  `in_device_id` varchar(10) DEFAULT NULL,
  `in_time` varchar(50) DEFAULT NULL,
  `out_device_id` varchar(10) DEFAULT NULL,
  `out_time` varchar(50) DEFAULT NULL,
  `at_type` char(1) DEFAULT NULL,
  `flag` tinyint(1) DEFAULT NULL,
  `scode` varchar(5) DEFAULT NULL,
  `state` varchar(50) DEFAULT NULL,
  `dcode` varchar(10) DEFAULT NULL,
  `district` varchar(50) DEFAULT NULL,
  `gps_lat` varchar(20) NOT NULL,
  `gps_long` varchar(20) NOT NULL,
  PRIMARY KEY (`emp_id`,`log_date`) USING BTREE,
  CONSTRAINT `FK_aebas_today_attendance_details_aebas_employee_details` FOREIGN KEY (`emp_id`) REFERENCES `aebas_employee_details` (`emp_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;

-- Data exporting was unselected.

-- Dumping structure for table dhs_ehrms.apk_application_details
CREATE TABLE IF NOT EXISTS `apk_application_details` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(250) DEFAULT NULL,
  `version` varchar(50) DEFAULT NULL,
  `apk_url` varchar(250) DEFAULT NULL,
  `remark` varchar(250) DEFAULT NULL,
  `is_live` enum('Yes','No') DEFAULT NULL,
  `entry_date` datetime DEFAULT current_timestamp(),
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Data exporting was unselected.

-- Dumping structure for table dhs_ehrms.bond_doctor_aebas
CREATE TABLE IF NOT EXISTS `bond_doctor_aebas` (
  `emp_id` varchar(50) NOT NULL,
  `attendance_id` varchar(8) NOT NULL,
  `is_active` char(50) NOT NULL,
  UNIQUE KEY `attendance_id` (`attendance_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Data exporting was unselected.

-- Dumping structure for table dhs_ehrms.bond_doctor_aebas_employee_details
CREATE TABLE IF NOT EXISTS `bond_doctor_aebas_employee_details` (
  `emp_id` varchar(20) NOT NULL,
  `emp_cat` varchar(20) NOT NULL,
  `org_emp_code` varchar(50) NOT NULL,
  `org_id` varchar(50) NOT NULL,
  `org_name` varchar(255) NOT NULL,
  `dist_code` varchar(10) NOT NULL,
  `state_code` varchar(5) NOT NULL,
  `state` varchar(50) NOT NULL,
  `district` varchar(50) NOT NULL,
  `office_loc` varchar(10) NOT NULL,
  `loc_name` varchar(255) DEFAULT NULL,
  `designation` varchar(255) DEFAULT NULL,
  `emp_name` varchar(255) NOT NULL,
  `emp_dob` date DEFAULT NULL,
  `gender` char(1) NOT NULL,
  `emp_mail` varchar(255) DEFAULT NULL,
  `emp_mobile` varchar(15) DEFAULT NULL,
  `creation_date` datetime DEFAULT NULL,
  `division` varchar(100) DEFAULT NULL,
  `active_status` char(1) NOT NULL COMMENT 'A (Active)\r\nI (InActive)\r\nR (New Registered)\r\nT (Transfered)\r\nX (Blocked)',
  `is_bond_doctor` tinyint(3) unsigned NOT NULL DEFAULT 0,
  PRIMARY KEY (`emp_id`) USING BTREE,
  KEY `FK_aebas_employee_details_aebas_mas_location` (`office_loc`) USING BTREE,
  KEY `is_bond_doctor` (`is_bond_doctor`) USING BTREE,
  KEY `emp_name` (`emp_name`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Data exporting was unselected.

-- Dumping structure for table dhs_ehrms.bond_doctor_details
CREATE TABLE IF NOT EXISTS `bond_doctor_details` (
  `roundNo` int(11) NOT NULL DEFAULT 0,
  `enrollmentNo` varchar(50) NOT NULL DEFAULT '',
  `instituteId` varchar(10) DEFAULT NULL,
  `hc_type` varchar(7) DEFAULT NULL,
  `district_id` int(11) DEFAULT NULL,
  `rank` double DEFAULT NULL,
  `stateRank` double DEFAULT NULL,
  `type` varchar(50) DEFAULT NULL,
  `optNo` int(11) DEFAULT NULL,
  `regNo` varchar(50) DEFAULT NULL,
  `name` varchar(50) DEFAULT NULL,
  `programRank` varchar(3) DEFAULT NULL,
  `programName` varchar(50) DEFAULT NULL,
  `programId` varchar(3) DEFAULT NULL,
  `mobile_no` varchar(10) DEFAULT NULL,
  `c_type` varchar(2) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '',
  `treasury_emp_code` varchar(20) NOT NULL DEFAULT '',
  `attendance_id` varchar(20) NOT NULL DEFAULT '',
  `year` smallint(6) NOT NULL DEFAULT 0,
  `updated_at` datetime DEFAULT NULL ON UPDATE current_timestamp(),
  `updated_by` bigint(20) unsigned DEFAULT NULL,
  `updated_ip_address` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `is_active` tinyint(4) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci ROW_FORMAT=DYNAMIC;

-- Data exporting was unselected.

-- Dumping structure for table dhs_ehrms.bond_doctor_details_old
CREATE TABLE IF NOT EXISTS `bond_doctor_details_old` (
  `roundNo` int(11) NOT NULL DEFAULT 0,
  `enrollmentNo` varchar(50) NOT NULL DEFAULT '',
  `instituteId` varchar(10) DEFAULT NULL,
  `hc_type` varchar(7) DEFAULT NULL,
  `district_id` int(11) DEFAULT NULL,
  `rank` double DEFAULT NULL,
  `stateRank` double DEFAULT NULL,
  `type` varchar(50) DEFAULT NULL,
  `optNo` int(11) DEFAULT NULL,
  `regNo` varchar(50) DEFAULT NULL,
  `name` varchar(50) DEFAULT NULL,
  `programRank` varchar(3) DEFAULT NULL,
  `programName` varchar(50) DEFAULT NULL,
  `programId` varchar(3) DEFAULT NULL,
  `mobile_no` varchar(10) DEFAULT NULL,
  `c_type` varchar(2) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '',
  `treasury_emp_code` varchar(20) NOT NULL DEFAULT '',
  `attendance_id` varchar(20) NOT NULL DEFAULT '',
  `year` smallint(6) NOT NULL DEFAULT 0,
  `updated_at` datetime DEFAULT NULL ON UPDATE current_timestamp(),
  `updated_by` bigint(20) unsigned DEFAULT NULL,
  `updated_ip_address` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;

-- Data exporting was unselected.

-- Dumping structure for table dhs_ehrms.bond_ug_doctor_details
CREATE TABLE IF NOT EXISTS `bond_ug_doctor_details` (
  `bond_ug_registration_number` varchar(15) NOT NULL,
  `enrollment_number` varchar(20) NOT NULL,
  `candidate_name` varchar(50) NOT NULL,
  `contact_number` varchar(20) NOT NULL,
  `email_id` varchar(125) NOT NULL,
  `alt_mobile_number` varchar(50) DEFAULT NULL,
  `posting_place` varchar(255) NOT NULL,
  `district_name_en` varchar(125) NOT NULL,
  `district_code` smallint(6) unsigned NOT NULL,
  PRIMARY KEY (`bond_ug_registration_number`),
  UNIQUE KEY `enrollment_number` (`enrollment_number`),
  KEY `district_code` (`district_code`),
  CONSTRAINT `FK_bond_ug_doctor_details_mas_district` FOREIGN KEY (`district_code`) REFERENCES `mas_district` (`district_code`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Data exporting was unselected.

-- Dumping structure for table dhs_ehrms.channel_flow_details
CREATE TABLE IF NOT EXISTS `channel_flow_details` (
  `channel_flow_detail_code` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `channel_flow_main_code` bigint(20) unsigned NOT NULL,
  `send_by` bigint(20) unsigned NOT NULL,
  `send_by_designation` int(11) DEFAULT NULL,
  `send_to` bigint(20) unsigned NOT NULL,
  `sent_to_designation` int(11) DEFAULT NULL,
  `action_group_code` smallint(5) unsigned NOT NULL,
  `action_code` tinyint(4) DEFAULT NULL,
  `action_dt` datetime DEFAULT NULL,
  `remark` varchar(255) DEFAULT NULL,
  `read_dt` datetime DEFAULT NULL,
  `is_cancel` tinyint(4) DEFAULT NULL,
  `cancel_remark` varchar(100) DEFAULT NULL,
  `created_by` bigint(20) unsigned NOT NULL,
  `created_at` datetime NOT NULL DEFAULT current_timestamp(),
  `ip_address` varchar(50) NOT NULL,
  `updated_at` datetime DEFAULT NULL ON UPDATE current_timestamp(),
  `updated_by` bigint(20) unsigned DEFAULT NULL,
  `updated_ip_address` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`channel_flow_detail_code`),
  KEY `FK1_channel_flow_main_code` (`channel_flow_main_code`),
  KEY `FK_channel_flow_detail_mas_action_group` (`action_group_code`),
  CONSTRAINT `FK_channel_flow_detail_channel_flow_main` FOREIGN KEY (`channel_flow_main_code`) REFERENCES `channel_flow_main` (`channel_flow_main_code`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `FK_channel_flow_detail_mas_action_group` FOREIGN KEY (`action_group_code`) REFERENCES `mas_action_group` (`action_group_code`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Data exporting was unselected.

-- Dumping structure for table dhs_ehrms.channel_flow_main
CREATE TABLE IF NOT EXISTS `channel_flow_main` (
  `channel_flow_main_code` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `application_code` bigint(20) unsigned NOT NULL,
  `channel_purpose_code` int(11) unsigned NOT NULL,
  `last_update_date` datetime NOT NULL DEFAULT current_timestamp(),
  `last_update_by` bigint(20) unsigned NOT NULL,
  `action_code` smallint(5) unsigned NOT NULL,
  `is_read` tinyint(3) unsigned NOT NULL DEFAULT 0,
  `created_at` datetime NOT NULL DEFAULT current_timestamp(),
  `created_by` bigint(20) unsigned NOT NULL,
  `ip_address` varchar(50) NOT NULL,
  `updated_at` datetime DEFAULT NULL ON UPDATE current_timestamp(),
  `updated_by` bigint(20) unsigned DEFAULT NULL,
  `updated_ip_address` varchar(50) DEFAULT NULL,
  `channel_flow_details_last_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`channel_flow_main_code`) USING BTREE,
  UNIQUE KEY `leave_main_code` (`application_code`) USING BTREE,
  KEY `FK_channel_flow_main_mas_action` (`action_code`),
  KEY `FK_channel_flow_main_channel_purpose` (`channel_purpose_code`),
  CONSTRAINT `FK_channel_flow_main_channel_purpose` FOREIGN KEY (`channel_purpose_code`) REFERENCES `channel_purpose` (`channel_purpose_code`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `FK_channel_flow_main_mas_action` FOREIGN KEY (`action_code`) REFERENCES `mas_action` (`action_code`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;

-- Data exporting was unselected.

-- Dumping structure for table dhs_ehrms.channel_purpose
CREATE TABLE IF NOT EXISTS `channel_purpose` (
  `channel_purpose_code` int(11) unsigned NOT NULL,
  `channel_purpose_name_en` varchar(255) NOT NULL,
  `channel_purpose_name_hi` varchar(255) NOT NULL,
  `remark` varchar(255) NOT NULL,
  `created_at` datetime NOT NULL DEFAULT current_timestamp(),
  `created_by` bigint(20) unsigned NOT NULL,
  `ip_address` varchar(50) NOT NULL,
  `updated_at` datetime DEFAULT NULL ON UPDATE current_timestamp(),
  `updated_by` bigint(20) unsigned DEFAULT NULL,
  `updated_ip_address` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`channel_purpose_code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Data exporting was unselected.

-- Dumping structure for table dhs_ehrms.ddo_master_health
CREATE TABLE IF NOT EXISTS `ddo_master_health` (
  `DEPT_CODE` int(11) NOT NULL DEFAULT 0,
  `DDO_CODE` varchar(200) NOT NULL DEFAULT '',
  `DESIG_NAME` varchar(200) NOT NULL,
  `DISTRICT` varchar(100) NOT NULL,
  `BLOCK` varchar(100) NOT NULL,
  `PIN_CODE` int(11) NOT NULL DEFAULT 0,
  `CONTROLLING_OFFICER_NAME` varchar(400) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Data exporting was unselected.

-- Dumping structure for table dhs_ehrms.deptwise_designation
CREATE TABLE IF NOT EXISTS `deptwise_designation` (
  `DEPTCODE` bigint(20) DEFAULT NULL,
  `department name english` text DEFAULT NULL,
  `department name unicode` text DEFAULT NULL,
  `DESIG_CODE` bigint(20) NOT NULL,
  `NAME_ENG` text DEFAULT NULL,
  `NAME_UNI` text DEFAULT NULL,
  `fifth_pay` text DEFAULT NULL,
  `sixth_pay` text DEFAULT NULL,
  `SEVENTHPAY` text DEFAULT NULL,
  `GRADE` text DEFAULT NULL,
  `REMARK` text DEFAULT NULL,
  `is_active` int(11) DEFAULT NULL,
  PRIMARY KEY (`DESIG_CODE`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Data exporting was unselected.

-- Dumping structure for table dhs_ehrms.emp_authority_mapping
CREATE TABLE IF NOT EXISTS `emp_authority_mapping` (
  `hc_id` int(11) NOT NULL,
  `emp_code` bigint(20) NOT NULL,
  `district_code` int(11) NOT NULL,
  `designation_id` int(11) DEFAULT NULL,
  `created_at` datetime NOT NULL DEFAULT current_timestamp(),
  `created_by` bigint(20) unsigned NOT NULL,
  `updated_at` datetime DEFAULT NULL,
  `updated_by` bigint(20) unsigned DEFAULT NULL,
  `ip_address` varchar(50) NOT NULL,
  UNIQUE KEY `hc_id` (`hc_id`,`designation_id`) USING BTREE,
  UNIQUE KEY `emp_code` (`emp_code`,`designation_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Data exporting was unselected.

-- Dumping structure for table dhs_ehrms.emp_basic_details
CREATE TABLE IF NOT EXISTS `emp_basic_details` (
  `emp_code` bigint(20) unsigned NOT NULL,
  `actual_emp_code` varchar(50) NOT NULL,
  `aebas_attendance_id` varchar(8) NOT NULL,
  `aebas_office_loc_id` varchar(50) NOT NULL,
  `posted_hc_id` int(10) unsigned NOT NULL,
  `current_hc_id` int(11) unsigned NOT NULL,
  `ddo_code` int(11) unsigned NOT NULL,
  `status_code` int(11) DEFAULT NULL,
  `name_en` varchar(200) NOT NULL,
  `doj` date NOT NULL,
  `dob` date NOT NULL,
  `ekarmik_designation_code` int(11) NOT NULL,
  `payroll_designation_code` int(11) DEFAULT NULL,
  `mobile_no` bigint(10) unsigned NOT NULL,
  `dor` date NOT NULL,
  `photo` varchar(255) DEFAULT NULL,
  `created_at` datetime NOT NULL DEFAULT current_timestamp(),
  `created_by` bigint(20) unsigned NOT NULL,
  `updated_at` datetime DEFAULT NULL ON UPDATE current_timestamp(),
  `updated_by` bigint(20) unsigned DEFAULT NULL,
  `ip_address` varchar(50) NOT NULL,
  `updated_ip_address` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`emp_code`),
  UNIQUE KEY `mobile_no` (`mobile_no`),
  UNIQUE KEY `aebas_attendance_id` (`aebas_attendance_id`),
  UNIQUE KEY `actual_emp_code` (`actual_emp_code`),
  KEY `FK_hc_id` (`posted_hc_id`),
  KEY `FK_current_hc_id` (`current_hc_id`),
  KEY `FK3_ddo_code` (`ddo_code`),
  KEY `FK_emp_basic_details_aebas_mas_location` (`aebas_office_loc_id`),
  KEY `idx_empbasic_ddo` (`ddo_code`),
  KEY `idx_empbasic_hc` (`current_hc_id`),
  KEY `idx_empbasic_desig` (`ekarmik_designation_code`),
  KEY `FK_emp_basic_details_mas_status` (`status_code`),
  FULLTEXT KEY `name_en` (`name_en`),
  FULLTEXT KEY `name_en_2` (`name_en`,`aebas_attendance_id`),
  FULLTEXT KEY `name_en_3` (`name_en`),
  CONSTRAINT `FK3_ddo_code` FOREIGN KEY (`ddo_code`) REFERENCES `mas_ddo_office` (`ddo_code`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `FK_current_hc_id` FOREIGN KEY (`current_hc_id`) REFERENCES `health_center` (`hc_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `FK_emp_basic_details_aebas_employee_details` FOREIGN KEY (`aebas_attendance_id`) REFERENCES `aebas_employee_details` (`emp_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `FK_emp_basic_details_aebas_mas_location` FOREIGN KEY (`aebas_office_loc_id`) REFERENCES `aebas_mas_location` (`loc_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `FK_emp_basic_details_mas_status` FOREIGN KEY (`status_code`) REFERENCES `mas_status` (`status_code`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `FK_hc_id` FOREIGN KEY (`posted_hc_id`) REFERENCES `health_center` (`hc_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Data exporting was unselected.

-- Dumping structure for table dhs_ehrms.emp_education_details
CREATE TABLE IF NOT EXISTS `emp_education_details` (
  `emp_code` bigint(20) NOT NULL,
  `actual_emp_code` varchar(50) DEFAULT NULL,
  `exam_type` tinyint(4) DEFAULT NULL,
  `exam_type_name` varchar(50) DEFAULT NULL,
  `pass_year` mediumint(9) DEFAULT NULL,
  `board` varchar(255) DEFAULT NULL,
  `subject` varchar(150) DEFAULT NULL,
  `division` char(10) DEFAULT NULL,
  `created_at` datetime DEFAULT current_timestamp(),
  `created_by` bigint(20) DEFAULT NULL,
  `updated_by` bigint(20) DEFAULT NULL,
  `ip_address` varchar(50) DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL ON UPDATE current_timestamp(),
  `updated_ip_address` varchar(50) DEFAULT NULL,
  KEY `emp_code` (`emp_code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Data exporting was unselected.

-- Dumping structure for table dhs_ehrms.emp_gradation_details
CREATE TABLE IF NOT EXISTS `emp_gradation_details` (
  `emp_code` bigint(20) unsigned NOT NULL,
  `actual_emp_code` varchar(20) NOT NULL,
  `emp_name` varchar(50) NOT NULL,
  `gradation_no` int(11) DEFAULT NULL,
  `ekarmik_designation_code` int(11) NOT NULL,
  `category_code` tinyint(4) unsigned NOT NULL,
  `dob` date NOT NULL,
  `dor` date NOT NULL,
  `doj` date NOT NULL,
  `created_at` datetime NOT NULL DEFAULT current_timestamp(),
  `created_by` bigint(20) unsigned NOT NULL,
  `ip_address` varchar(50) NOT NULL,
  `updated_at` datetime DEFAULT NULL ON UPDATE current_timestamp(),
  `updated_by` bigint(20) unsigned DEFAULT NULL,
  `updated_ip_address` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`emp_code`),
  UNIQUE KEY `actual_emp_code` (`actual_emp_code`),
  UNIQUE KEY `ekarmik_designation_code` (`ekarmik_designation_code`,`gradation_no`),
  KEY `FK_emp_gradation_details_mas_category` (`category_code`),
  CONSTRAINT `FK_emp_gradation_details_emp_basic_details` FOREIGN KEY (`emp_code`) REFERENCES `emp_basic_details` (`emp_code`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `FK_emp_gradation_details_mas_category` FOREIGN KEY (`category_code`) REFERENCES `mas_category` (`category_code`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Data exporting was unselected.

-- Dumping structure for table dhs_ehrms.emp_incentive_details
CREATE TABLE IF NOT EXISTS `emp_incentive_details` (
  `district_code` int(11) DEFAULT NULL,
  `hc_name` varchar(255) DEFAULT NULL,
  `hc_id` varchar(255) DEFAULT NULL,
  `emp_code` bigint(20) DEFAULT NULL,
  `emp_name` varchar(255) DEFAULT NULL,
  `designation` varchar(255) DEFAULT NULL,
  `utr_date` varchar(255) DEFAULT NULL,
  `paid_cases` varchar(255) DEFAULT NULL,
  `paid_amount` double DEFAULT NULL,
  KEY `emp_code` (`emp_code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Data exporting was unselected.

-- Dumping structure for table dhs_ehrms.emp_nominee_details
CREATE TABLE IF NOT EXISTS `emp_nominee_details` (
  `emp_code` bigint(20) NOT NULL,
  `actual_emp_code` varchar(50) DEFAULT '' COMMENT 'tresary',
  `nominee_first_name` varchar(100) DEFAULT NULL,
  `nominee_middle_name` varchar(100) DEFAULT NULL,
  `nominee_last_name` varchar(100) DEFAULT NULL,
  `dob` date DEFAULT NULL,
  `relation` varchar(50) DEFAULT NULL,
  `gratuity` tinyint(4) DEFAULT NULL,
  `gpf` tinyint(4) DEFAULT NULL,
  `dpf` tinyint(4) DEFAULT NULL,
  `pran` tinyint(4) DEFAULT NULL,
  `gis` tinyint(4) DEFAULT NULL,
  `fbf` tinyint(4) DEFAULT NULL,
  `created_at` date DEFAULT current_timestamp(),
  `created_by` bigint(20) DEFAULT NULL,
  `updated_at` date DEFAULT NULL,
  `updated_by` bigint(20) DEFAULT NULL,
  `ip_address` varchar(50) DEFAULT NULL,
  `updated_ip_address` varchar(50) DEFAULT NULL,
  KEY `emp_code` (`emp_code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Data exporting was unselected.

-- Dumping structure for table dhs_ehrms.emp_opd_count_details_next_gen
CREATE TABLE IF NOT EXISTS `emp_opd_count_details_next_gen` (
  `opd_dashboard_nextgen_id` varchar(255) NOT NULL,
  `department_name` varchar(255) NOT NULL,
  `clinic_name` varchar(255) DEFAULT NULL,
  `practitioner_id` varchar(50) NOT NULL,
  `health_facility_id` int(11) NOT NULL,
  `practitioner_name` varchar(255) NOT NULL,
  `opd_assigned` int(11) NOT NULL,
  `opd_date` date DEFAULT NULL,
  `created_at` datetime NOT NULL DEFAULT current_timestamp(),
  `created_by` bigint(20) unsigned NOT NULL,
  `updated_at` datetime DEFAULT NULL,
  `updated_by` bigint(20) unsigned DEFAULT NULL,
  `ip_address` varchar(50) NOT NULL,
  `updated_ip_address` varchar(50) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Data exporting was unselected.

-- Dumping structure for table dhs_ehrms.emp_personal_details
CREATE TABLE IF NOT EXISTS `emp_personal_details` (
  `emp_code` bigint(20) unsigned NOT NULL,
  `actual_emp_code` varchar(50) DEFAULT NULL,
  `f_designation_code` int(11) DEFAULT NULL,
  `emp_type_code` tinyint(4) unsigned NOT NULL,
  `father_name` varchar(100) NOT NULL,
  `country_code` tinyint(4) unsigned DEFAULT NULL,
  `religion_code` tinyint(4) unsigned NOT NULL,
  `category_code` tinyint(4) unsigned DEFAULT NULL,
  `caste` varchar(50) DEFAULT NULL,
  `identification_mark` varchar(100) DEFAULT NULL,
  `appointment_date` date NOT NULL,
  `appointment_office` varchar(255) DEFAULT NULL,
  `created_by` bigint(20) unsigned NOT NULL,
  `created_at` date NOT NULL DEFAULT current_timestamp(),
  `updated_by` bigint(20) unsigned DEFAULT NULL,
  `updated_at` date DEFAULT NULL,
  `ip_address` varchar(50) NOT NULL,
  `updated_ip_address` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`emp_code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Data exporting was unselected.

-- Dumping structure for table dhs_ehrms.emp_posting_details
CREATE TABLE IF NOT EXISTS `emp_posting_details` (
  `emp_code` bigint(20) unsigned NOT NULL,
  `actual_emp_code` varchar(50) DEFAULT '',
  `current_designation` varchar(255) DEFAULT NULL,
  `current_designation_code` bigint(10) NOT NULL DEFAULT 0,
  `posting_type` char(50) NOT NULL,
  `posting_detail` varchar(50) DEFAULT NULL,
  `pay_scale` varchar(50) DEFAULT NULL,
  `order_no` char(50) NOT NULL,
  `order_date` date NOT NULL,
  `dor` date NOT NULL,
  `doj` date NOT NULL,
  `office_name` varchar(255) DEFAULT NULL,
  `department_name` varchar(255) DEFAULT NULL,
  `basic_pay` int(11) DEFAULT NULL,
  `grade` char(5) DEFAULT NULL,
  `created_at` datetime NOT NULL DEFAULT current_timestamp(),
  `created_by` bigint(20) unsigned NOT NULL,
  `updated_at` datetime DEFAULT NULL,
  `updated_by` bigint(20) unsigned DEFAULT NULL,
  `ip_address` varchar(50) NOT NULL,
  `updated_ip_address` varchar(50) DEFAULT NULL,
  UNIQUE KEY `emp_code` (`emp_code`,`order_date`,`order_no`,`doj`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Data exporting was unselected.

-- Dumping structure for table dhs_ehrms.emp_transfer_details
CREATE TABLE IF NOT EXISTS `emp_transfer_details` (
  `emp_code` bigint(20) unsigned NOT NULL,
  `actual_emp_code` varchar(50) DEFAULT NULL,
  `transfer_no` int(11) DEFAULT NULL,
  `transfer_from_desig` varchar(256) DEFAULT NULL,
  `transfer_to_desig` varchar(256) DEFAULT NULL,
  `transfer_from_dept` int(11) DEFAULT NULL,
  `transfer_to_dept` int(11) DEFAULT NULL,
  `prom` varchar(10) DEFAULT NULL,
  `transfer_date` datetime DEFAULT NULL,
  `order_no` varchar(200) DEFAULT NULL,
  `rel_date` datetime DEFAULT NULL,
  `from_ddo` varchar(50) DEFAULT NULL,
  `from_ddo_treasury_district_code` varchar(50) NOT NULL,
  `to_ddo` varchar(50) DEFAULT NULL,
  `to_ddo_treasury_district_code` varchar(50) NOT NULL,
  `last_pay_date` datetime DEFAULT NULL,
  `old_pay` varchar(50) DEFAULT NULL,
  `ordering_ddo` bigint(20) DEFAULT NULL,
  `created_at` date DEFAULT current_timestamp(),
  `created_by` bigint(20) DEFAULT NULL,
  `updated_by` bigint(20) DEFAULT NULL,
  `ip_address` varchar(50) DEFAULT NULL,
  `updated_at` date DEFAULT NULL,
  `updated_ip_address` varchar(50) DEFAULT NULL,
  KEY `emp_code` (`emp_code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Data exporting was unselected.

-- Dumping structure for table dhs_ehrms.emp_treasury_nextgen_mapping
CREATE TABLE IF NOT EXISTS `emp_treasury_nextgen_mapping` (
  `emp_id_treasury` bigint(20) NOT NULL DEFAULT 0,
  `emp_id_next_gen` varchar(50) NOT NULL DEFAULT '',
  `created_at` datetime NOT NULL DEFAULT current_timestamp(),
  `created_by` bigint(20) unsigned NOT NULL,
  `updated_at` datetime DEFAULT NULL ON UPDATE current_timestamp(),
  `updated_by` bigint(20) unsigned DEFAULT NULL,
  `ip_address` varchar(50) NOT NULL,
  `updated_ip_address` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`emp_id_treasury`,`emp_id_next_gen`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Data exporting was unselected.

-- Dumping structure for table dhs_ehrms.grievance_applications
CREATE TABLE IF NOT EXISTS `grievance_applications` (
  `grievance_id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `emp_code` bigint(20) unsigned NOT NULL DEFAULT 0,
  `grievance_type_id` tinyint(3) unsigned NOT NULL DEFAULT 0,
  `other_grievance_type` varchar(255) DEFAULT NULL,
  `description` varchar(500) NOT NULL,
  `document` varchar(255) DEFAULT NULL,
  `status` enum('In-Progress','Under Review','Closed') NOT NULL DEFAULT 'In-Progress',
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `updated_by` bigint(20) unsigned DEFAULT NULL,
  PRIMARY KEY (`grievance_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Data exporting was unselected.

-- Dumping structure for table dhs_ehrms.hc_setup_entry
CREATE TABLE IF NOT EXISTS `hc_setup_entry` (
  `post_code` int(100) DEFAULT NULL,
  `post_name` varchar(500) DEFAULT NULL,
  `pay_level` varchar(500) DEFAULT NULL,
  `post_count` tinyint(4) DEFAULT NULL,
  `created_at` date DEFAULT NULL,
  `created_by` bigint(20) DEFAULT NULL,
  `updated_at` date DEFAULT NULL,
  `updated_by` bigint(20) DEFAULT NULL,
  `updated_ip_address` varchar(50) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='setup entry for ehrms ';

-- Data exporting was unselected.

-- Dumping structure for table dhs_ehrms.health_center
CREATE TABLE IF NOT EXISTS `health_center` (
  `HC_ID_OLD` varchar(10) NOT NULL,
  `hc_id` int(11) unsigned NOT NULL DEFAULT 0,
  `type_id` int(11) unsigned DEFAULT NULL,
  `name_hi` varchar(250) DEFAULT NULL,
  `name_en` varchar(250) DEFAULT NULL,
  `district_id_old` varchar(50) DEFAULT NULL,
  `district_id` tinyint(4) DEFAULT NULL,
  `block_id` char(10) DEFAULT NULL,
  `district_code` int(11) DEFAULT NULL,
  `subdistrict_code` int(11) DEFAULT NULL,
  `is_active` bit(1) DEFAULT NULL,
  `urb_id` varchar(50) DEFAULT NULL,
  `u_chc_id` varchar(50) DEFAULT NULL,
  `u_phc_id` varchar(50) DEFAULT NULL,
  `ssk_id` varchar(50) DEFAULT NULL,
  `ssk_type` varchar(50) DEFAULT NULL,
  `BO_ID` varchar(50) DEFAULT NULL,
  `chc_id` varchar(50) DEFAULT NULL,
  `phc_id` varchar(50) DEFAULT NULL,
  `shc_id` varchar(50) DEFAULT NULL,
  `TYPE` varchar(3) DEFAULT NULL,
  `SUBTYPE` varchar(3) DEFAULT NULL,
  `TYPE_NAME` varchar(50) DEFAULT NULL,
  `R_U` char(1) DEFAULT NULL,
  `FRU_NonFRU` char(1) DEFAULT NULL,
  `FRU_Functioning` char(1) DEFAULT NULL,
  `FRU_ID` varchar(50) DEFAULT NULL,
  `DMC` char(1) DEFAULT NULL,
  `CRMC` char(1) DEFAULT NULL,
  `VDC` char(1) DEFAULT NULL,
  `LOGIN_NAME` varchar(50) DEFAULT NULL,
  `PASS` varchar(255) DEFAULT NULL,
  `REPORT_TO_HC` varchar(50) DEFAULT NULL,
  `HC_DELETED` char(1) DEFAULT NULL,
  `organisationunitid` varchar(50) DEFAULT NULL,
  `parentid` varchar(50) DEFAULT NULL,
  `Notional_CHC` char(1) DEFAULT NULL,
  `NotionalHC` char(1) DEFAULT NULL,
  `SubDtCode` varchar(50) DEFAULT NULL,
  `PID` varchar(50) DEFAULT NULL,
  `SID` varchar(50) DEFAULT NULL,
  `Accrediated` char(1) DEFAULT NULL,
  `TwentyFourBySeven` char(1) DEFAULT NULL,
  `dtDist` varchar(50) DEFAULT NULL,
  `District_IDOld` varchar(50) DEFAULT NULL,
  `dtDistOld` varchar(50) DEFAULT NULL,
  `insertdate` datetime DEFAULT NULL,
  `updatedate` datetime DEFAULT NULL,
  `remarks` varchar(500) DEFAULT NULL,
  `OLD_CHC_ID` varchar(50) DEFAULT NULL,
  `OLD_PHC_ID` varchar(50) DEFAULT NULL,
  `OLD_PID` varchar(50) DEFAULT NULL,
  `HC_SHIFT` char(1) DEFAULT NULL,
  `RemarksFrmDistt` varchar(1000) DEFAULT NULL,
  `IssueResolved_date` date DEFAULT NULL,
  `RemarksFrmDistt_date` date DEFAULT NULL,
  `DP` varchar(1) DEFAULT NULL,
  `DP_Year` int(11) DEFAULT NULL,
  `AFHC` char(10) DEFAULT NULL,
  `SNCU` char(10) DEFAULT NULL,
  `SONOGPY` char(10) DEFAULT NULL,
  `NRC` char(10) DEFAULT NULL,
  `CRMCTYPE` int(11) DEFAULT NULL,
  `OLD_HC_ID` varchar(50) DEFAULT NULL,
  `HC_Address` varchar(1000) DEFAULT NULL,
  `IS_JSSK` char(1) DEFAULT NULL,
  `isRsby` char(1) DEFAULT NULL,
  `isSanjeevn` char(1) DEFAULT NULL,
  `isBalhirday` char(1) DEFAULT NULL,
  `Random_INSP_ID` int(11) DEFAULT NULL,
  `HCAddressHin` varchar(1000) DEFAULT NULL,
  `HCAddressEng` varchar(1000) DEFAULT NULL,
  `HCPinCode` int(11) DEFAULT NULL,
  `HCContactNo` int(11) DEFAULT NULL,
  `HCEmailID` varchar(150) DEFAULT NULL,
  `is_HWC` char(1) DEFAULT NULL,
  `HWC_UpdateDt` datetime DEFAULT NULL,
  `HWC_Verify` char(1) DEFAULT NULL,
  `HWC_VerifyDt` datetime DEFAULT NULL,
  `districtIdUpdate` char(1) DEFAULT NULL,
  `IsHospital` char(1) DEFAULT NULL,
  `IsPwdChange` char(1) DEFAULT NULL,
  `PasswordChangedDt` datetime DEFAULT NULL,
  PRIMARY KEY (`hc_id`),
  KEY `district_code` (`district_code`) USING BTREE,
  KEY `subdistrict_code` (`subdistrict_code`) USING BTREE,
  KEY `HC_ID` (`HC_ID_OLD`) USING BTREE,
  KEY `BLOCK_ID` (`block_id`) USING BTREE,
  KEY `CHC_ID` (`chc_id`) USING BTREE,
  KEY `PHC_ID` (`phc_id`) USING BTREE,
  KEY `SHC_ID` (`shc_id`) USING BTREE,
  KEY `U_PHCID` (`u_phc_id`) USING BTREE,
  KEY `U_CHCID` (`u_chc_id`) USING BTREE,
  KEY `DISTRICT_ID` (`district_id`) USING BTREE,
  KEY `FK_health_center_mas_health_center_type` (`type_id`),
  KEY `IsActive` (`is_active`) USING BTREE,
  CONSTRAINT `FK_health_center_mas_health_center_type` FOREIGN KEY (`type_id`) REFERENCES `mas_health_center_type` (`type_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci ROW_FORMAT=DYNAMIC;

-- Data exporting was unselected.

-- Dumping structure for table dhs_ehrms.health_center_hfr_aebas_location_mapping
CREATE TABLE IF NOT EXISTS `health_center_hfr_aebas_location_mapping` (
  `hc_id` int(11) unsigned NOT NULL,
  `hfr_id` int(11) unsigned DEFAULT NULL,
  `loc_id` varchar(10) DEFAULT NULL,
  `created_by` bigint(20) unsigned NOT NULL,
  `created_at` datetime NOT NULL DEFAULT current_timestamp(),
  `ip_address` varchar(50) NOT NULL,
  `updated_by` bigint(20) unsigned DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL ON UPDATE current_timestamp(),
  `updated_ip_address` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`hc_id`) USING BTREE,
  UNIQUE KEY `hc_id` (`hc_id`),
  KEY `FK_health_center_hfr_aebas_location_mapping_mas_health_facility` (`hfr_id`),
  KEY `FK_health_center_hfr_aebas_location_mapping_aebas_mas_location` (`loc_id`),
  CONSTRAINT `FK_health_center_hfr_aebas_location_mapping_health_center` FOREIGN KEY (`hc_id`) REFERENCES `health_center` (`hc_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `FK_health_center_hfr_aebas_location_mapping_mas_health_facility` FOREIGN KEY (`hfr_id`) REFERENCES `mas_health_facility` (`hfr_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Data exporting was unselected.

-- Dumping structure for table dhs_ehrms.health_center_old_20250912
CREATE TABLE IF NOT EXISTS `health_center_old_20250912` (
  `HC_ID_OLD` varchar(10) NOT NULL,
  `hc_id` int(11) unsigned NOT NULL DEFAULT 0,
  `type_id` int(11) unsigned DEFAULT NULL,
  `name_hi` varchar(250) DEFAULT NULL,
  `name_en` varchar(250) DEFAULT NULL,
  `district_id_old` varchar(50) DEFAULT NULL,
  `district_id` tinyint(4) DEFAULT NULL,
  `block_id` char(10) DEFAULT NULL,
  `district_code` int(11) DEFAULT NULL,
  `subdistrict_code` int(11) DEFAULT NULL,
  `is_active` bit(1) DEFAULT NULL,
  `urb_id` varchar(50) DEFAULT NULL,
  `u_chc_id` varchar(50) DEFAULT NULL,
  `u_phc_id` varchar(50) DEFAULT NULL,
  `ssk_id` varchar(50) DEFAULT NULL,
  `ssk_type` varchar(50) DEFAULT NULL,
  `BO_ID` varchar(50) DEFAULT NULL,
  `chc_id` varchar(50) DEFAULT NULL,
  `phc_id` varchar(50) DEFAULT NULL,
  `shc_id` varchar(50) DEFAULT NULL,
  `TYPE` varchar(3) DEFAULT NULL,
  `SUBTYPE` varchar(3) DEFAULT NULL,
  `TYPE_NAME` varchar(50) DEFAULT NULL,
  `R_U` char(1) DEFAULT NULL,
  `FRU_NonFRU` char(1) DEFAULT NULL,
  `FRU_Functioning` char(1) DEFAULT NULL,
  `FRU_ID` varchar(50) DEFAULT NULL,
  `DMC` char(1) DEFAULT NULL,
  `CRMC` char(1) DEFAULT NULL,
  `VDC` char(1) DEFAULT NULL,
  `LOGIN_NAME` varchar(50) DEFAULT NULL,
  `PASS` varchar(255) DEFAULT NULL,
  `REPORT_TO_HC` varchar(50) DEFAULT NULL,
  `HC_DELETED` char(1) DEFAULT NULL,
  `organisationunitid` varchar(50) DEFAULT NULL,
  `parentid` varchar(50) DEFAULT NULL,
  `Notional_CHC` char(1) DEFAULT NULL,
  `NotionalHC` char(1) DEFAULT NULL,
  `SubDtCode` varchar(50) DEFAULT NULL,
  `PID` varchar(50) DEFAULT NULL,
  `SID` varchar(50) DEFAULT NULL,
  `Accrediated` char(1) DEFAULT NULL,
  `TwentyFourBySeven` char(1) DEFAULT NULL,
  `dtDist` varchar(50) DEFAULT NULL,
  `District_IDOld` varchar(50) DEFAULT NULL,
  `dtDistOld` varchar(50) DEFAULT NULL,
  `insertdate` datetime DEFAULT NULL,
  `updatedate` datetime DEFAULT NULL,
  `remarks` varchar(500) DEFAULT NULL,
  `OLD_CHC_ID` varchar(50) DEFAULT NULL,
  `OLD_PHC_ID` varchar(50) DEFAULT NULL,
  `OLD_PID` varchar(50) DEFAULT NULL,
  `HC_SHIFT` char(1) DEFAULT NULL,
  `RemarksFrmDistt` varchar(1000) DEFAULT NULL,
  `IssueResolved_date` date DEFAULT NULL,
  `RemarksFrmDistt_date` date DEFAULT NULL,
  `DP` varchar(1) DEFAULT NULL,
  `DP_Year` int(11) DEFAULT NULL,
  `AFHC` char(10) DEFAULT NULL,
  `SNCU` char(10) DEFAULT NULL,
  `SONOGPY` char(10) DEFAULT NULL,
  `NRC` char(10) DEFAULT NULL,
  `CRMCTYPE` int(11) DEFAULT NULL,
  `OLD_HC_ID` varchar(50) DEFAULT NULL,
  `HC_Address` varchar(1000) DEFAULT NULL,
  `IS_JSSK` char(1) DEFAULT NULL,
  `isRsby` char(1) DEFAULT NULL,
  `isSanjeevn` char(1) DEFAULT NULL,
  `isBalhirday` char(1) DEFAULT NULL,
  `Random_INSP_ID` int(11) DEFAULT NULL,
  `HCAddressHin` varchar(1000) DEFAULT NULL,
  `HCAddressEng` varchar(1000) DEFAULT NULL,
  `HCPinCode` int(11) DEFAULT NULL,
  `HCContactNo` int(11) DEFAULT NULL,
  `HCEmailID` varchar(150) DEFAULT NULL,
  `is_HWC` char(1) DEFAULT NULL,
  `HWC_UpdateDt` datetime DEFAULT NULL,
  `HWC_Verify` char(1) DEFAULT NULL,
  `HWC_VerifyDt` datetime DEFAULT NULL,
  `districtIdUpdate` char(1) DEFAULT NULL,
  `IsHospital` char(1) DEFAULT NULL,
  `IsPwdChange` char(1) DEFAULT NULL,
  `PasswordChangedDt` datetime DEFAULT NULL,
  PRIMARY KEY (`hc_id`) USING BTREE,
  KEY `district_code` (`district_code`) USING BTREE,
  KEY `subdistrict_code` (`subdistrict_code`) USING BTREE,
  KEY `HC_ID` (`HC_ID_OLD`) USING BTREE,
  KEY `BLOCK_ID` (`block_id`) USING BTREE,
  KEY `CHC_ID` (`chc_id`) USING BTREE,
  KEY `PHC_ID` (`phc_id`) USING BTREE,
  KEY `SHC_ID` (`shc_id`) USING BTREE,
  KEY `U_PHCID` (`u_phc_id`) USING BTREE,
  KEY `U_CHCID` (`u_chc_id`) USING BTREE,
  KEY `DISTRICT_ID` (`district_id`) USING BTREE,
  KEY `FK_health_center_mas_health_center_type` (`type_id`) USING BTREE,
  KEY `IsActive` (`is_active`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;

-- Data exporting was unselected.

-- Dumping structure for table dhs_ehrms.health_center_posting_setup_file_details
CREATE TABLE IF NOT EXISTS `health_center_posting_setup_file_details` (
  `hc_id` int(11) unsigned NOT NULL,
  `file_name` varchar(50) NOT NULL,
  `file_path` varchar(100) NOT NULL,
  `created_at` datetime NOT NULL DEFAULT current_timestamp(),
  `created_by` bigint(20) unsigned NOT NULL,
  `ip_address` varchar(50) NOT NULL,
  `updated_at` datetime DEFAULT NULL,
  `updated_by` bigint(20) unsigned DEFAULT NULL,
  `updated_ip_address` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`hc_id`),
  CONSTRAINT `FK_health_center_posting_setup_file_details_health_center` FOREIGN KEY (`hc_id`) REFERENCES `health_center` (`hc_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Data exporting was unselected.

-- Dumping structure for table dhs_ehrms.hs_emp_basic_details
CREATE TABLE IF NOT EXISTS `hs_emp_basic_details` (
  `emp_code` bigint(20) unsigned NOT NULL,
  `actual_emp_code` varchar(50) NOT NULL,
  `posted_hc_id` int(11) unsigned NOT NULL,
  `current_hc_id` int(11) unsigned NOT NULL,
  `ddo_code` int(11) unsigned NOT NULL,
  `name_en` varchar(200) NOT NULL,
  `doj` date NOT NULL,
  `dob` date NOT NULL,
  `ekarmik_designation_code` int(11) NOT NULL,
  `payroll_designation_code` int(11) DEFAULT NULL,
  `mobile_no` bigint(10) unsigned NOT NULL,
  `dor` date NOT NULL,
  `photo` varchar(255) DEFAULT NULL,
  `created_at` datetime NOT NULL DEFAULT current_timestamp(),
  `created_by` bigint(20) unsigned NOT NULL,
  `updated_at` datetime DEFAULT NULL,
  `updated_by` bigint(20) unsigned DEFAULT NULL,
  `ip_address` varchar(50) NOT NULL,
  `updated_ip_address` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`emp_code`) USING BTREE,
  UNIQUE KEY `mobile_no` (`mobile_no`) USING BTREE,
  UNIQUE KEY `actual_emp_code` (`actual_emp_code`) USING BTREE,
  KEY `FK_emp_basic_details_health_center` (`posted_hc_id`) USING BTREE,
  KEY `idx_empbasic_ddo` (`ddo_code`) USING BTREE,
  KEY `idx_empbasic_hc` (`current_hc_id`) USING BTREE,
  KEY `idx_empbasic_desig` (`ekarmik_designation_code`) USING BTREE,
  FULLTEXT KEY `ind_name_en` (`name_en`),
  CONSTRAINT `FK_hs_emp_basic_details_health_center` FOREIGN KEY (`posted_hc_id`) REFERENCES `health_center` (`hc_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `FK_hs_emp_basic_details_health_center_2` FOREIGN KEY (`current_hc_id`) REFERENCES `health_center` (`hc_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `FK_hs_emp_basic_details_mas_ddo_office` FOREIGN KEY (`ddo_code`) REFERENCES `mas_ddo_office` (`ddo_code`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Data exporting was unselected.

-- Dumping structure for table dhs_ehrms.late_sms_sent
CREATE TABLE IF NOT EXISTS `late_sms_sent` (
  `sms_id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `emp_code` bigint(20) unsigned NOT NULL,
  `actual_emp_code` varchar(50) NOT NULL,
  `attendance_id` varchar(50) NOT NULL,
  `log_date` date NOT NULL,
  `late_duration` time NOT NULL,
  `sms_response` varchar(200) DEFAULT NULL,
  `created_at` datetime NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`sms_id`) USING BTREE,
  UNIQUE KEY `idx_emp_date` (`emp_code`,`log_date`) USING BTREE,
  CONSTRAINT `FK_late_sms_sent_emp_basic` FOREIGN KEY (`emp_code`) REFERENCES `emp_basic_details` (`emp_code`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=63 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Data exporting was unselected.

-- Dumping structure for table dhs_ehrms.map_treasury_deisgnation
CREATE TABLE IF NOT EXISTS `map_treasury_deisgnation` (
  `hc_type_code` int(11) unsigned DEFAULT NULL,
  `designation_code` smallint(6) DEFAULT NULL,
  `post_order_id` int(2) unsigned DEFAULT NULL,
  `created_at` date DEFAULT current_timestamp(),
  `created_by` bigint(20) DEFAULT NULL,
  `updated_by` bigint(20) DEFAULT NULL,
  `ip_address` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `updated_at` date DEFAULT NULL,
  UNIQUE KEY `hc_type_code` (`hc_type_code`,`designation_code`,`post_order_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Data exporting was unselected.

-- Dumping structure for table dhs_ehrms.mas_action
CREATE TABLE IF NOT EXISTS `mas_action` (
  `action_code` smallint(5) unsigned NOT NULL AUTO_INCREMENT,
  `action_name_en` varchar(50) NOT NULL,
  `action_name_hi` varchar(50) NOT NULL,
  `action_desc` varchar(255) NOT NULL,
  `display_order` int(10) unsigned NOT NULL,
  `is_active` tinyint(3) unsigned NOT NULL DEFAULT 0,
  `role_code` varchar(50) DEFAULT NULL,
  `created_at` datetime NOT NULL DEFAULT current_timestamp(),
  `created_by` bigint(20) unsigned NOT NULL,
  `ip_address` varchar(50) NOT NULL,
  `updated_at` datetime DEFAULT NULL ON UPDATE current_timestamp(),
  `updated_by` bigint(20) unsigned DEFAULT NULL,
  `updated_ip_address` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`action_code`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Data exporting was unselected.

-- Dumping structure for table dhs_ehrms.mas_action_group
CREATE TABLE IF NOT EXISTS `mas_action_group` (
  `action_group_code` smallint(5) unsigned NOT NULL AUTO_INCREMENT,
  `group_name` varchar(50) NOT NULL,
  `is_active` tinyint(3) unsigned NOT NULL DEFAULT 0,
  `created_at` datetime NOT NULL DEFAULT current_timestamp(),
  `created_by` bigint(20) unsigned NOT NULL,
  `ip_address` varchar(50) NOT NULL,
  `updated_at` datetime DEFAULT NULL ON UPDATE current_timestamp(),
  `updated_by` bigint(20) unsigned DEFAULT NULL,
  `updated_ip_address` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`action_group_code`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Data exporting was unselected.

-- Dumping structure for table dhs_ehrms.mas_action_group_mapping
CREATE TABLE IF NOT EXISTS `mas_action_group_mapping` (
  `action_group_code` smallint(5) unsigned NOT NULL,
  `action_code` smallint(5) unsigned NOT NULL,
  `is_active` tinyint(3) unsigned NOT NULL DEFAULT 0,
  `display_order` smallint(5) unsigned NOT NULL,
  `created_at` datetime NOT NULL DEFAULT current_timestamp(),
  `created_by` bigint(20) unsigned NOT NULL,
  `ip_address` varchar(50) NOT NULL,
  `updated_at` datetime DEFAULT NULL ON UPDATE current_timestamp(),
  `updated_by` bigint(20) unsigned DEFAULT NULL,
  `updated_ip_address` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`action_group_code`,`action_code`),
  KEY `FK_mas_action_group_mapping_mas_action` (`action_code`),
  CONSTRAINT `FK_mas_action_group_mapping_mas_action` FOREIGN KEY (`action_code`) REFERENCES `mas_action` (`action_code`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `FK_mas_action_group_mapping_mas_action_group` FOREIGN KEY (`action_group_code`) REFERENCES `mas_action_group` (`action_group_code`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Data exporting was unselected.

-- Dumping structure for table dhs_ehrms.mas_block
CREATE TABLE IF NOT EXISTS `mas_block` (
  `district_id` int(11) DEFAULT NULL,
  `block_id` int(11) DEFAULT NULL,
  `district_code` int(11) DEFAULT NULL,
  `block_name_hi` varchar(200) DEFAULT NULL,
  `block_name_en` varchar(200) DEFAULT NULL,
  UNIQUE KEY `uq_district_block` (`district_code`,`block_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Data exporting was unselected.

-- Dumping structure for table dhs_ehrms.mas_category
CREATE TABLE IF NOT EXISTS `mas_category` (
  `category_code` tinyint(3) unsigned NOT NULL DEFAULT 0,
  `category_name_hi` varchar(50) NOT NULL,
  `category_name_en` varchar(50) NOT NULL,
  `category_name_hi_short` char(10) NOT NULL,
  `category_name_en_short` char(10) NOT NULL,
  PRIMARY KEY (`category_code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Data exporting was unselected.

-- Dumping structure for table dhs_ehrms.mas_country
CREATE TABLE IF NOT EXISTS `mas_country` (
  `country_code` tinyint(4) NOT NULL AUTO_INCREMENT,
  `country_name_en` varchar(100) NOT NULL,
  `country_name_hi` varchar(100) NOT NULL,
  PRIMARY KEY (`country_code`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Data exporting was unselected.

-- Dumping structure for table dhs_ehrms.mas_ddo_office
CREATE TABLE IF NOT EXISTS `mas_ddo_office` (
  `ddo_code` int(11) unsigned NOT NULL,
  `actual_ddo_code` varchar(50) NOT NULL,
  `ddo_name_en` varchar(255) NOT NULL,
  `department_name` varchar(255) NOT NULL,
  `district_code` smallint(6) unsigned NOT NULL,
  `district_name` varchar(125) NOT NULL,
  `total_emp` int(10) unsigned NOT NULL DEFAULT 0,
  PRIMARY KEY (`ddo_code`) USING BTREE,
  UNIQUE KEY `actual_ddo_code` (`actual_ddo_code`) USING BTREE,
  KEY `FK_mas_ddo_office_mas_district` (`district_code`),
  CONSTRAINT `FK_mas_ddo_office_mas_district` FOREIGN KEY (`district_code`) REFERENCES `mas_district` (`district_code`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Data exporting was unselected.

-- Dumping structure for table dhs_ehrms.mas_ddo_office_old
CREATE TABLE IF NOT EXISTS `mas_ddo_office_old` (
  `officer_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `ddo_code` int(7) unsigned zerofill NOT NULL,
  `ddo_office_name_en` varchar(300) NOT NULL DEFAULT '',
  `ddo_office_name_hi` varchar(300) NOT NULL DEFAULT '',
  `name_short` char(10) NOT NULL DEFAULT '',
  PRIMARY KEY (`officer_id`),
  UNIQUE KEY `ddo_code_old` (`ddo_code`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=34 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Data exporting was unselected.

-- Dumping structure for table dhs_ehrms.mas_deputation_designation
CREATE TABLE IF NOT EXISTS `mas_deputation_designation` (
  `designation_code` tinyint(3) unsigned NOT NULL,
  `group_code` varchar(50) NOT NULL DEFAULT '',
  `designation_name_en` varchar(50) NOT NULL,
  `designation_name_en_short` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Data exporting was unselected.

-- Dumping structure for table dhs_ehrms.mas_district
CREATE TABLE IF NOT EXISTS `mas_district` (
  `s_no` smallint(6) NOT NULL DEFAULT 0,
  `state_code` smallint(6) DEFAULT NULL,
  `state_name` varchar(255) DEFAULT NULL,
  `district_code` smallint(6) unsigned NOT NULL,
  `district_id` smallint(2) unsigned DEFAULT NULL,
  `district_name_en` varchar(255) DEFAULT NULL,
  UNIQUE KEY `district_code` (`district_code`) USING BTREE,
  KEY `Auto_Increment_Key` (`s_no`) USING BTREE,
  KEY `state_code` (`state_code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_bin ROW_FORMAT=DYNAMIC;

-- Data exporting was unselected.

-- Dumping structure for table dhs_ehrms.mas_district_aebas_district_mapping
CREATE TABLE IF NOT EXISTS `mas_district_aebas_district_mapping` (
  `aebas_dcode` varchar(10) NOT NULL,
  `mas_district_code` smallint(6) unsigned NOT NULL,
  `district_name` varchar(100) NOT NULL,
  `aebas_dcode_group` varchar(50) NOT NULL,
  PRIMARY KEY (`aebas_dcode`,`mas_district_code`),
  KEY `FK_mas_district_aebas_district_mapping_mas_district` (`mas_district_code`),
  CONSTRAINT `FK_mas_district_aebas_district_mapping_aebas_mas_district` FOREIGN KEY (`aebas_dcode`) REFERENCES `aebas_mas_district` (`dcode`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `FK_mas_district_aebas_district_mapping_mas_district` FOREIGN KEY (`mas_district_code`) REFERENCES `mas_district` (`district_code`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Data exporting was unselected.

-- Dumping structure for table dhs_ehrms.mas_district_old_hrmis
CREATE TABLE IF NOT EXISTS `mas_district_old_hrmis` (
  `District_Name` varchar(255) DEFAULT NULL,
  `District_ID` int(11) DEFAULT NULL,
  `DBStart_Name_En` varchar(255) DEFAULT NULL,
  `Backward_NonBackward` varchar(255) DEFAULT NULL,
  `Div_Id` varchar(255) DEFAULT NULL,
  `password` varchar(255) DEFAULT NULL,
  `dtDist` int(11) DEFAULT NULL,
  `AuthoritySignCopyForAPAR` varchar(255) DEFAULT NULL,
  `SwasthankScore` varchar(255) DEFAULT NULL,
  `Census_Code` varchar(255) DEFAULT NULL,
  `SeqNo` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Data exporting was unselected.

-- Dumping structure for table dhs_ehrms.mas_emp_type
CREATE TABLE IF NOT EXISTS `mas_emp_type` (
  `emp_type_code` tinyint(4) NOT NULL AUTO_INCREMENT,
  `emp_type_name_en` varchar(100) DEFAULT NULL,
  `emp_type_name_hi` varchar(50) DEFAULT NULL,
  `emp_type_name_short_en` char(50) DEFAULT NULL,
  `emp_type_name_short_hi` char(50) DEFAULT NULL,
  PRIMARY KEY (`emp_type_code`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Data exporting was unselected.

-- Dumping structure for table dhs_ehrms.mas_grievance_types
CREATE TABLE IF NOT EXISTS `mas_grievance_types` (
  `grievance_type_id` tinyint(3) unsigned NOT NULL DEFAULT 0,
  `title_en` varchar(255) NOT NULL,
  `title_hi` varchar(255) DEFAULT NULL,
  `is_active` tinyint(4) NOT NULL DEFAULT 1,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`grievance_type_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Data exporting was unselected.

-- Dumping structure for table dhs_ehrms.mas_health_center_type
CREATE TABLE IF NOT EXISTS `mas_health_center_type` (
  `type_id` int(11) unsigned NOT NULL,
  `type_short` varchar(100) DEFAULT NULL,
  `name_hi` varchar(50) DEFAULT NULL,
  `name_en` varchar(50) DEFAULT NULL,
  `parent_hc_type` int(11) DEFAULT NULL,
  `remark` varchar(350) DEFAULT NULL,
  `active_flag` tinyint(4) DEFAULT NULL,
  `order_no` tinyint(4) DEFAULT NULL,
  PRIMARY KEY (`type_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Data exporting was unselected.

-- Dumping structure for table dhs_ehrms.mas_health_facility
CREATE TABLE IF NOT EXISTS `mas_health_facility` (
  `hfr_id` int(10) unsigned NOT NULL,
  `actual_hfr_id` varchar(20) DEFAULT NULL,
  `facility_name_en` varchar(255) DEFAULT NULL,
  `state` varchar(255) DEFAULT NULL,
  `district_code` smallint(6) unsigned NOT NULL,
  `district_name_en` varchar(255) DEFAULT NULL,
  `sub_district_name_en` varchar(255) DEFAULT NULL,
  `facility_ownership` varchar(255) DEFAULT NULL,
  `ownership_sub_type` varchar(255) DEFAULT NULL,
  `facility_type` varchar(255) DEFAULT NULL,
  `facility_status` varchar(255) DEFAULT NULL,
  `system_of_medicine` varchar(255) DEFAULT NULL,
  `application_submit_date` varchar(255) DEFAULT NULL,
  `aging` varchar(255) DEFAULT NULL,
  `address` varchar(255) DEFAULT NULL,
  `facility_contact_person_name` varchar(255) DEFAULT NULL,
  `facility_contact_person_mobile_no` varchar(255) DEFAULT NULL,
  `bridge_linked` varchar(255) DEFAULT NULL,
  `remark` varchar(255) DEFAULT NULL,
  `is_active` tinyint(3) unsigned NOT NULL DEFAULT 0,
  PRIMARY KEY (`hfr_id`) USING BTREE,
  UNIQUE KEY `actual_hrf_id` (`actual_hfr_id`) USING BTREE,
  KEY `district_code` (`district_code`),
  CONSTRAINT `FK_mas_health_facility_mas_district` FOREIGN KEY (`district_code`) REFERENCES `mas_district` (`district_code`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Data exporting was unselected.

-- Dumping structure for table dhs_ehrms.mas_leave_holiday
CREATE TABLE IF NOT EXISTS `mas_leave_holiday` (
  `holiday_type_code` tinyint(4) unsigned DEFAULT NULL,
  `holiday_title_code` tinyint(4) DEFAULT NULL,
  `holiday_date` date NOT NULL,
  `day_en` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Data exporting was unselected.

-- Dumping structure for table dhs_ehrms.mas_leave_holiday_title
CREATE TABLE IF NOT EXISTS `mas_leave_holiday_title` (
  `holiday_title_code` tinyint(3) unsigned NOT NULL AUTO_INCREMENT,
  `holiday_title_name_hi` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL,
  `holiday_title_name_en` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL,
  PRIMARY KEY (`holiday_title_code`)
) ENGINE=InnoDB AUTO_INCREMENT=94 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Data exporting was unselected.

-- Dumping structure for table dhs_ehrms.mas_leave_holiday_type
CREATE TABLE IF NOT EXISTS `mas_leave_holiday_type` (
  `holiday_type_code` tinyint(4) NOT NULL DEFAULT 0,
  `holiday_type_name` varchar(50) NOT NULL,
  `compulsary_leave_yn` char(1) DEFAULT NULL,
  `weekend_yn` char(1) DEFAULT NULL,
  `created_by` bigint(20) NOT NULL DEFAULT 0,
  `updated_by` bigint(20) DEFAULT NULL,
  `created_at` date NOT NULL,
  `updated_at` date DEFAULT NULL,
  `ip_address` varchar(39) DEFAULT NULL,
  PRIMARY KEY (`holiday_type_code`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Data exporting was unselected.

-- Dumping structure for table dhs_ehrms.mas_month
CREATE TABLE IF NOT EXISTS `mas_month` (
  `month_code` int(11) NOT NULL,
  `month_name_hi` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL DEFAULT '',
  `month_name_en` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL DEFAULT '',
  `month_order` int(11) DEFAULT NULL,
  PRIMARY KEY (`month_code`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;

-- Data exporting was unselected.

-- Dumping structure for table dhs_ehrms.mas_noc_category
CREATE TABLE IF NOT EXISTS `mas_noc_category` (
  `noc_category_code` smallint(5) unsigned NOT NULL AUTO_INCREMENT,
  `noc_category_name_hi` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL,
  `noc_category_name_en` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL,
  `is_active` tinyint(3) unsigned NOT NULL DEFAULT 0,
  PRIMARY KEY (`noc_category_code`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Data exporting was unselected.

-- Dumping structure for table dhs_ehrms.mas_noc_checklist
CREATE TABLE IF NOT EXISTS `mas_noc_checklist` (
  `noc_checklist_code` smallint(5) unsigned NOT NULL AUTO_INCREMENT,
  `noc_checklist_name_hi` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL,
  `noc_checklist_name_en` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL,
  `noc_category_code` smallint(5) unsigned NOT NULL,
  `is_mandatory` tinyint(3) unsigned NOT NULL,
  `is_active` tinyint(3) unsigned NOT NULL DEFAULT 0,
  PRIMARY KEY (`noc_checklist_code`) USING BTREE,
  KEY `FK_mas_noc_checklist_mas_noc_category` (`noc_category_code`),
  CONSTRAINT `FK_mas_noc_checklist_mas_noc_category` FOREIGN KEY (`noc_category_code`) REFERENCES `mas_noc_category` (`noc_category_code`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Data exporting was unselected.

-- Dumping structure for table dhs_ehrms.mas_order
CREATE TABLE IF NOT EXISTS `mas_order` (
  `order_no` tinyint(4) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Data exporting was unselected.

-- Dumping structure for table dhs_ehrms.mas_org_build_entry_point
CREATE TABLE IF NOT EXISTS `mas_org_build_entry_point` (
  `entry_id` varchar(10) NOT NULL,
  `org_id` varchar(10) DEFAULT NULL,
  `loc_id` varchar(10) DEFAULT NULL,
  `entry_name` varchar(100) DEFAULT NULL,
  `gps_cord` varchar(50) DEFAULT NULL,
  `active_status` char(1) DEFAULT NULL,
  `created_by` varchar(50) DEFAULT NULL,
  `creation_date` datetime DEFAULT NULL,
  `last_updated` datetime DEFAULT NULL,
  `flag` tinyint(1) DEFAULT NULL,
  PRIMARY KEY (`entry_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Data exporting was unselected.

-- Dumping structure for table dhs_ehrms.mas_post_setup_details
CREATE TABLE IF NOT EXISTS `mas_post_setup_details` (
  `hc_type_code` int(11) unsigned NOT NULL,
  `hc_code` int(11) unsigned NOT NULL,
  `designation_code` smallint(6) unsigned NOT NULL,
  `sanction_post` int(11) unsigned NOT NULL DEFAULT 0,
  `in_post` int(11) unsigned NOT NULL DEFAULT 0,
  `created_at` datetime NOT NULL DEFAULT current_timestamp(),
  `created_by` bigint(20) unsigned NOT NULL,
  `updated_by` bigint(20) DEFAULT NULL,
  `ip_address` varchar(50) NOT NULL,
  `updated_at` datetime DEFAULT NULL,
  `updated_ip_address` varchar(50) DEFAULT NULL,
  UNIQUE KEY `hc_type_code` (`hc_type_code`,`designation_code`,`hc_code`) USING BTREE,
  CONSTRAINT `FK_mas_post_setup_details_mas_health_center_type` FOREIGN KEY (`hc_type_code`) REFERENCES `mas_health_center_type` (`type_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Data exporting was unselected.

-- Dumping structure for table dhs_ehrms.mas_religion
CREATE TABLE IF NOT EXISTS `mas_religion` (
  `religion_code` tinyint(4) NOT NULL AUTO_INCREMENT,
  `religion_name_en` varchar(50) NOT NULL,
  `religion_name_hi` varchar(50) NOT NULL,
  PRIMARY KEY (`religion_code`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Data exporting was unselected.

-- Dumping structure for table dhs_ehrms.mas_reporting_level
CREATE TABLE IF NOT EXISTS `mas_reporting_level` (
  `reporting_level_code` smallint(5) unsigned NOT NULL AUTO_INCREMENT,
  `reporting_level_name_en` varchar(126) NOT NULL,
  `reporting_level_name_hi` varchar(126) NOT NULL,
  `created_at` datetime NOT NULL DEFAULT current_timestamp(),
  `created_by` bigint(20) unsigned NOT NULL,
  `ip_address` varchar(50) NOT NULL,
  `updated_at` datetime DEFAULT NULL ON UPDATE current_timestamp(),
  `updated_by` bigint(20) unsigned DEFAULT NULL,
  `updated_ip_address` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`reporting_level_code`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Data exporting was unselected.

-- Dumping structure for table dhs_ehrms.mas_state
CREATE TABLE IF NOT EXISTS `mas_state` (
  `state_code` tinyint(4) DEFAULT NULL,
  `state_name_en` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_bin;

-- Data exporting was unselected.

-- Dumping structure for table dhs_ehrms.mas_status
CREATE TABLE IF NOT EXISTS `mas_status` (
  `status_code` int(11) NOT NULL,
  `status_name` varchar(50) NOT NULL DEFAULT '',
  PRIMARY KEY (`status_code`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;

-- Data exporting was unselected.

-- Dumping structure for table dhs_ehrms.mas_transfer_reason
CREATE TABLE IF NOT EXISTS `mas_transfer_reason` (
  `reason_code` int(11) NOT NULL AUTO_INCREMENT,
  `reason_name_en` varchar(500) DEFAULT NULL,
  `reason_name_hi` varchar(500) DEFAULT NULL,
  PRIMARY KEY (`reason_code`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Data exporting was unselected.

-- Dumping structure for table dhs_ehrms.mas_year
CREATE TABLE IF NOT EXISTS `mas_year` (
  `year_code` int(11) NOT NULL,
  `year_name` varchar(50) NOT NULL DEFAULT '',
  `is_current_year` char(1) NOT NULL DEFAULT 'Y',
  `year_order` int(11) DEFAULT NULL,
  PRIMARY KEY (`year_code`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;

-- Data exporting was unselected.

-- Dumping structure for table dhs_ehrms.noc_application_checklist_uploads
CREATE TABLE IF NOT EXISTS `noc_application_checklist_uploads` (
  `noc_application_checklist_uploads_code` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `noc_application_code` bigint(20) unsigned NOT NULL,
  `noc_checklist_code` smallint(5) unsigned NOT NULL,
  `file_name` varchar(256) DEFAULT NULL,
  `file_path` text DEFAULT NULL,
  `created_at` datetime NOT NULL DEFAULT current_timestamp(),
  `created_by` bigint(20) unsigned NOT NULL,
  `ip_address` varchar(50) NOT NULL,
  `updated_at` datetime DEFAULT NULL ON UPDATE current_timestamp(),
  `updated_by` bigint(20) unsigned DEFAULT NULL,
  `updated_ip_address` varchar(50) DEFAULT NULL,
  `is_checked` tinyint(4) DEFAULT NULL,
  `remark` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`noc_application_checklist_uploads_code`) USING BTREE,
  KEY `FK_noc_application_checklist_uploads_mas_noc_checklist` (`noc_checklist_code`),
  KEY `FK_noc_application_checklist_uploads_noc_application_details` (`noc_application_code`),
  CONSTRAINT `FK_noc_application_checklist_uploads_mas_noc_checklist` FOREIGN KEY (`noc_checklist_code`) REFERENCES `mas_noc_checklist` (`noc_checklist_code`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `FK_noc_application_checklist_uploads_noc_application_details` FOREIGN KEY (`noc_application_code`) REFERENCES `noc_application_details` (`noc_application_code`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Data exporting was unselected.

-- Dumping structure for table dhs_ehrms.noc_application_details
CREATE TABLE IF NOT EXISTS `noc_application_details` (
  `noc_application_code` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `noc_category_code` smallint(5) unsigned NOT NULL,
  `emp_code` bigint(20) unsigned NOT NULL,
  `emp_name` varchar(150) NOT NULL,
  `father_husband_name` varchar(150) NOT NULL,
  `current_designation_code` bigint(10) NOT NULL,
  `current_designation` varchar(255) NOT NULL,
  `posted_hc_id` int(11) unsigned NOT NULL,
  `posted_hc_name` varchar(150) NOT NULL,
  `doj` date NOT NULL,
  `dob` date NOT NULL,
  `dor` date NOT NULL,
  `appointment_cadre` varchar(255) NOT NULL,
  `five_year_service_completed_date` date NOT NULL,
  `is_education_leave_taken_earlier` char(5) NOT NULL,
  `education_leave_taken_earlier_desc` text NOT NULL,
  `requested_curriculum_desc` varchar(256) NOT NULL DEFAULT '',
  `is_departmental_inquiry_or_unauthorized_absence` char(50) NOT NULL,
  `higher_studies_from_date` date NOT NULL,
  `higher_studies_to_date` date NOT NULL,
  `period_of_higher_studies_year` int(10) unsigned NOT NULL,
  `period_of_higher_studies_month` int(10) unsigned NOT NULL,
  `period_of_higher_studies_days` int(10) unsigned NOT NULL,
  `is_training_period_completed` char(50) NOT NULL,
  `is_relates_to_field_of_work` char(50) NOT NULL,
  `is_higher_studies_beneficial_for_public_good` char(50) NOT NULL,
  `is_trial_period_completed` char(50) NOT NULL,
  `trial_period_not_completed_desc` char(50) NOT NULL,
  `is_executed_for_govt_service` char(50) NOT NULL,
  `created_at` datetime NOT NULL DEFAULT current_timestamp(),
  `created_by` bigint(20) unsigned NOT NULL,
  `ip_address` varchar(50) NOT NULL,
  `updated_at` datetime DEFAULT NULL ON UPDATE current_timestamp(),
  `updated_by` bigint(20) unsigned DEFAULT NULL,
  `updated_ip_address` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`noc_application_code`) USING BTREE,
  KEY `FK_noc_application_details_emp_basic_details` (`emp_code`) USING BTREE,
  KEY `FK_noc_application_details_health_center` (`posted_hc_id`) USING BTREE,
  KEY `FK_noc_application_details_mas_noc_category` (`noc_category_code`) USING BTREE,
  CONSTRAINT `FK_noc_application_details_emp_basic_details` FOREIGN KEY (`emp_code`) REFERENCES `emp_basic_details` (`emp_code`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `FK_noc_application_details_health_center` FOREIGN KEY (`posted_hc_id`) REFERENCES `health_center` (`hc_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `FK_noc_application_details_mas_noc_category` FOREIGN KEY (`noc_category_code`) REFERENCES `mas_noc_category` (`noc_category_code`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Data exporting was unselected.

-- Dumping structure for table dhs_ehrms.noc_dhs_officer_mapping
CREATE TABLE IF NOT EXISTS `noc_dhs_officer_mapping` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `emp_code` bigint(20) NOT NULL DEFAULT 0,
  `emp_name` varchar(50) NOT NULL DEFAULT '0',
  `level_name` varchar(50) NOT NULL DEFAULT '0',
  `active` tinyint(4) DEFAULT 1,
  `designation_id` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=36 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Data exporting was unselected.

-- Dumping structure for table dhs_ehrms.noc_study_leave_details
CREATE TABLE IF NOT EXISTS `noc_study_leave_details` (
  `noc_application_code` int(11) NOT NULL,
  `emp_code` bigint(20) unsigned NOT NULL,
  `from_date` date NOT NULL,
  `to_date` date NOT NULL,
  `remark` varchar(255) NOT NULL,
  `created_at` datetime NOT NULL DEFAULT current_timestamp(),
  `created_by` bigint(20) unsigned NOT NULL,
  `ip_address` varchar(50) NOT NULL,
  `updated_at` datetime DEFAULT NULL ON UPDATE current_timestamp(),
  `updated_by` bigint(20) unsigned DEFAULT NULL,
  `updated_ip_address` varchar(50) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Data exporting was unselected.

-- Dumping structure for table dhs_ehrms.npa
CREATE TABLE IF NOT EXISTS `npa` (
  `ddo_code` bigint(20) DEFAULT NULL,
  `emp_code` bigint(20) DEFAULT NULL,
  `name_en` text DEFAULT NULL,
  `dept_name_en` text DEFAULT NULL,
  `deisgnation_name_en` text DEFAULT NULL,
  `latest_non_practising_allowance` bigint(20) DEFAULT NULL,
  `source_sheet` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Data exporting was unselected.

-- Dumping structure for table dhs_ehrms.otp_send_log
CREATE TABLE IF NOT EXISTS `otp_send_log` (
  `emp_code` bigint(20) unsigned NOT NULL,
  `mobile_no` bigint(10) DEFAULT NULL,
  `otp` int(10) unsigned NOT NULL,
  `sms_response` varchar(200) DEFAULT NULL,
  `created_at` datetime NOT NULL DEFAULT current_timestamp(),
  `created_by` bigint(20) unsigned NOT NULL,
  `ip_address` varchar(50) NOT NULL,
  `otp_type` varchar(100) DEFAULT NULL COMMENT 'for otp type'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Data exporting was unselected.

-- Dumping structure for table dhs_ehrms.reporting_officer_mapping
CREATE TABLE IF NOT EXISTS `reporting_officer_mapping` (
  `map_code` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `emp_code` bigint(20) unsigned NOT NULL,
  `channel_purpose_code` int(11) unsigned NOT NULL,
  `reporting_officer_emp_code` bigint(20) unsigned NOT NULL,
  `reporting_level_code` smallint(5) unsigned NOT NULL,
  `action_group_code` smallint(5) unsigned NOT NULL,
  `created_at` datetime NOT NULL DEFAULT current_timestamp(),
  `action_code` smallint(6) NOT NULL DEFAULT 0,
  `created_by` bigint(20) unsigned NOT NULL,
  `ip_address` varchar(50) NOT NULL,
  `updated_at` datetime DEFAULT NULL ON UPDATE current_timestamp(),
  `updated_by` bigint(20) unsigned DEFAULT NULL,
  `updated_ip_address` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`map_code`),
  KEY `FK_reporting_officer_mapping_emp_basic_details` (`emp_code`),
  KEY `FK_reporting_officer_mapping_channel_purpose` (`channel_purpose_code`),
  KEY `FK_reporting_officer_mapping_mas_action_group` (`action_group_code`),
  KEY `FK_reporting_officer_mapping_emp_basic_details_2` (`reporting_officer_emp_code`),
  KEY `FK_reporting_officer_mapping_mas_reporting_level` (`reporting_level_code`),
  CONSTRAINT `FK_reporting_officer_mapping_channel_purpose` FOREIGN KEY (`channel_purpose_code`) REFERENCES `channel_purpose` (`channel_purpose_code`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `FK_reporting_officer_mapping_emp_basic_details` FOREIGN KEY (`emp_code`) REFERENCES `emp_basic_details` (`emp_code`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `FK_reporting_officer_mapping_emp_basic_details_2` FOREIGN KEY (`reporting_officer_emp_code`) REFERENCES `emp_basic_details` (`emp_code`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `FK_reporting_officer_mapping_mas_action_group` FOREIGN KEY (`action_group_code`) REFERENCES `mas_action_group` (`action_group_code`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `FK_reporting_officer_mapping_mas_reporting_level` FOREIGN KEY (`reporting_level_code`) REFERENCES `mas_reporting_level` (`reporting_level_code`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Data exporting was unselected.

-- Dumping structure for table dhs_ehrms.total_employees
CREATE TABLE IF NOT EXISTS `total_employees` (
  `emp_code` bigint(20) NOT NULL DEFAULT 0,
  `actual_emp_code` varchar(20) DEFAULT NULL,
  `name_eng` varchar(100) DEFAULT NULL,
  `f_name_eng` varchar(100) DEFAULT NULL,
  `designation` varchar(100) DEFAULT NULL,
  `class` varchar(10) DEFAULT NULL,
  `basic_pay` decimal(10,2) DEFAULT NULL,
  `mobile_no` varchar(20) DEFAULT NULL,
  `dob` varchar(50) DEFAULT NULL,
  `category` varchar(50) DEFAULT NULL,
  `ddo_code` varchar(20) DEFAULT NULL,
  `ddo_name` varchar(100) DEFAULT NULL,
  `doj` varchar(50) DEFAULT NULL,
  `address_p` varchar(200) DEFAULT NULL,
  `dor` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`emp_code`) USING BTREE,
  KEY `joindate` (`doj`) USING BTREE,
  KEY `date_ret` (`dor`) USING BTREE,
  KEY `ddocode` (`ddo_code`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Data exporting was unselected.

-- Dumping structure for table dhs_ehrms.total_employees24022026_old
CREATE TABLE IF NOT EXISTS `total_employees24022026_old` (
  `emp_code` bigint(20) NOT NULL DEFAULT 0,
  `actual_emp_code` varchar(20) DEFAULT NULL,
  `name_eng` varchar(100) DEFAULT NULL,
  `f_name_eng` varchar(100) DEFAULT NULL,
  `designation` varchar(100) DEFAULT NULL,
  `class` varchar(10) DEFAULT NULL,
  `basic_pay` decimal(10,2) DEFAULT NULL,
  `mobile_no` varchar(20) DEFAULT NULL,
  `dob` varchar(50) DEFAULT NULL,
  `category` varchar(50) DEFAULT NULL,
  `ddo_code` varchar(20) DEFAULT NULL,
  `ddo_name` varchar(100) DEFAULT NULL,
  `doj` varchar(50) DEFAULT NULL,
  `address_p` varchar(200) DEFAULT NULL,
  `dor` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`emp_code`) USING BTREE,
  KEY `joindate` (`doj`) USING BTREE,
  KEY `date_ret` (`dor`) USING BTREE,
  KEY `ddocode` (`ddo_code`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Data exporting was unselected.

-- Dumping structure for table dhs_ehrms.treasury_district_master
CREATE TABLE IF NOT EXISTS `treasury_district_master` (
  `DISTRICTCODE` varchar(50) NOT NULL,
  `DISTNAME` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `DISTRICT_DIVISION` int(11) DEFAULT NULL,
  `DIVISION_NAME` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  PRIMARY KEY (`DISTRICTCODE`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Data exporting was unselected.

/*!40103 SET TIME_ZONE=IFNULL(@OLD_TIME_ZONE, 'system') */;
/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IFNULL(@OLD_FOREIGN_KEY_CHECKS, 1) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40111 SET SQL_NOTES=IFNULL(@OLD_SQL_NOTES, 1) */;
