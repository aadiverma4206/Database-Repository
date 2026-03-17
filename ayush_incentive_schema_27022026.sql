-- --------------------------------------------------------
-- Host:                         127.0.0.1
-- Server version:               11.4.9-MariaDB - MariaDB Server
-- Server OS:                    Win64
-- HeidiSQL Version:             12.11.0.7065
-- --------------------------------------------------------

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8 */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;


-- Dumping database structure for ayush_incentive_schema
CREATE DATABASE IF NOT EXISTS `ayush_incentive_schema` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci */;
USE `ayush_incentive_schema`;

-- Dumping structure for table ayush_incentive_schema.ayush_mitanin_details
CREATE TABLE IF NOT EXISTS `ayush_mitanin_details` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `mips_mitanin_id` varchar(50) NOT NULL,
  `hc_id` varchar(50) NOT NULL,
  `entryby` varchar(50) NOT NULL,
  `entrydatetime` datetime NOT NULL DEFAULT current_timestamp(),
  `ip_address` varchar(50) NOT NULL,
  `is_active` tinyint(3) unsigned NOT NULL DEFAULT 1,
  `unmap_ip_address` varchar(100) DEFAULT NULL,
  `unmap_by` varchar(50) DEFAULT NULL,
  `unmap_dt` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `hc_id` (`hc_id`),
  KEY `mips_mitanin_id` (`mips_mitanin_id`),
  KEY `is_active` (`is_active`)
) ENGINE=InnoDB AUTO_INCREMENT=1751 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Data exporting was unselected.

-- Dumping structure for table ayush_incentive_schema.emp_pfms_details
CREATE TABLE IF NOT EXISTS `emp_pfms_details` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `pfms_id` varchar(50) NOT NULL,
  `designation_code` int(11) NOT NULL,
  `emp_code` varchar(50) NOT NULL,
  `emp_name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `account_no` varchar(100) NOT NULL,
  `bank_ifsc_code` varchar(100) NOT NULL,
  `mobile_no` varchar(20) NOT NULL,
  `district_code` int(11) NOT NULL,
  `hc_id` int(11) NOT NULL,
  `entryby` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `entrydatetime` datetime NOT NULL DEFAULT current_timestamp(),
  `ip_address` varchar(50) NOT NULL,
  `updateby` varchar(50) DEFAULT NULL,
  `updatedatetime` datetime DEFAULT NULL ON UPDATE current_timestamp(),
  `update_ip_address` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `emp_code` (`emp_code`),
  UNIQUE KEY `pfms_id` (`pfms_id`),
  KEY `designation_code` (`designation_code`),
  KEY `district_code` (`district_code`),
  KEY `hc_id` (`hc_id`),
  CONSTRAINT `FK_emp_pfms_details_mas_team_incentive_amt` FOREIGN KEY (`designation_code`) REFERENCES `mas_team_incentive_amt` (`designation_code`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=2683 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;

-- Data exporting was unselected.

-- Dumping structure for table ayush_incentive_schema.incentive_entry_details
CREATE TABLE IF NOT EXISTS `incentive_entry_details` (
  `entry_id` int(11) NOT NULL AUTO_INCREMENT,
  `activity_code` int(11) NOT NULL,
  `target_entry_id` int(11) NOT NULL,
  `monthly_target_value` int(11) DEFAULT NULL,
  `target_achieved_value` int(11) unsigned NOT NULL DEFAULT 0,
  `performance_grade` int(11) NOT NULL,
  `performance_percent` int(11) unsigned NOT NULL,
  `total_prev_target_achieved_value` int(11) DEFAULT NULL,
  `entryby` varchar(50) NOT NULL,
  `entrydatetime` datetime NOT NULL DEFAULT current_timestamp(),
  `ip_address` varchar(50) NOT NULL,
  `updateby` varchar(50) DEFAULT NULL,
  `updatedatetime` datetime DEFAULT NULL ON UPDATE current_timestamp(),
  `update_ip_address` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`entry_id`),
  UNIQUE KEY `activity_code_target_entry_id` (`activity_code`,`target_entry_id`),
  KEY `activity_code` (`activity_code`),
  KEY `performance_grade` (`performance_grade`),
  KEY `target_entry_id` (`target_entry_id`),
  CONSTRAINT `FK_incentive_entry_details_mas_activity` FOREIGN KEY (`activity_code`) REFERENCES `mas_activity` (`activity_code`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `FK_incentive_entry_details_mas_grade` FOREIGN KEY (`performance_grade`) REFERENCES `mas_grade` (`grade_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `FK_incentive_entry_details_target_entry_details` FOREIGN KEY (`target_entry_id`) REFERENCES `target_entry_details` (`target_entry_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=37920 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Data exporting was unselected.

-- Dumping structure for table ayush_incentive_schema.incentive_entry_status_details
CREATE TABLE IF NOT EXISTS `incentive_entry_status_details` (
  `status_id` int(11) NOT NULL AUTO_INCREMENT,
  `target_entry_id` int(11) NOT NULL,
  `hc_lock_status` enum('pending','approve') CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT 'pending',
  `hc_lock_dt` datetime DEFAULT NULL,
  `hc_lock_ip_address` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `dist_status` enum('pending','approve','reject') CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT 'pending',
  `dist_status_dt` datetime DEFAULT NULL,
  `dist_status_ip_address` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `is_dawapatrak_unlock` enum('Y','N') NOT NULL DEFAULT 'N',
  `dawapatrak_unlock_dt` datetime DEFAULT NULL,
  `dawapatrak_unlock_ip_address` varchar(50) DEFAULT NULL,
  `dawapatrak_unlock_reason` varchar(200) DEFAULT NULL,
  `state_approve_status` char(4) DEFAULT 'N',
  `state_approve_dt` datetime DEFAULT NULL,
  `state_approve_ip_address` varchar(50) DEFAULT NULL,
  `excel_filename` varchar(300) DEFAULT NULL,
  `is_send_for_payment` char(4) DEFAULT 'N',
  `send_for_payment_dt` datetime DEFAULT NULL,
  `send_for_payment_ip_address` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`status_id`),
  UNIQUE KEY `target_entry_id` (`target_entry_id`),
  KEY `FK_incentive_entry_status_details_target_entry_details` (`target_entry_id`),
  KEY `hc_lock_status` (`hc_lock_status`),
  KEY `dist_status` (`dist_status`),
  KEY `is_dawapatrak_unlock` (`is_dawapatrak_unlock`),
  KEY `state_approve_status` (`state_approve_status`),
  KEY `is_send_for_payment` (`is_send_for_payment`),
  CONSTRAINT `FK_incentive_entry_status_details_target_entry_details` FOREIGN KEY (`target_entry_id`) REFERENCES `target_entry_details` (`target_entry_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=3771 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Data exporting was unselected.

-- Dumping structure for table ayush_incentive_schema.incentive_six_month_amt_details
CREATE TABLE IF NOT EXISTS `incentive_six_month_amt_details` (
  `six_month_amt_id` int(11) NOT NULL AUTO_INCREMENT,
  `inc_tm_amt_id` int(11) NOT NULL,
  `target_entry_id` int(11) NOT NULL,
  `amount` int(11) NOT NULL,
  `entryby` varchar(50) NOT NULL,
  `entrydatetime` datetime NOT NULL,
  `ip_address` varchar(50) NOT NULL,
  `updateby` varchar(50) DEFAULT NULL,
  `updatedatetime` datetime DEFAULT NULL,
  `update_ip_address` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`six_month_amt_id`) USING BTREE,
  UNIQUE KEY `inc_tm_amt_id_unique` (`inc_tm_amt_id`),
  KEY `FK_incentive_team_amt_details_target_entry_details` (`target_entry_id`) USING BTREE,
  KEY `inc_tm_amt_id` (`inc_tm_amt_id`),
  CONSTRAINT `FK_incentice_six_month_amt_details_incentive_team_amt_details` FOREIGN KEY (`inc_tm_amt_id`) REFERENCES `incentive_team_amt_details` (`inc_tm_amt_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `FK_incentive_six_month_amt_details_target_entry_details` FOREIGN KEY (`target_entry_id`) REFERENCES `target_entry_details` (`target_entry_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=23354 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Data exporting was unselected.

-- Dumping structure for table ayush_incentive_schema.incentive_team_amt_details
CREATE TABLE IF NOT EXISTS `incentive_team_amt_details` (
  `inc_tm_amt_id` int(11) NOT NULL AUTO_INCREMENT,
  `target_entry_id` int(11) NOT NULL,
  `designation_code` int(11) NOT NULL,
  `emp_code` varchar(100) NOT NULL,
  `emp_name` varchar(100) NOT NULL,
  `account_no` varchar(100) NOT NULL,
  `bank_ifsc_code` varchar(100) NOT NULL,
  `mobile_no` varchar(20) DEFAULT NULL,
  `amount` int(11) NOT NULL,
  `entryby` varchar(50) NOT NULL,
  `entrydatetime` datetime NOT NULL,
  `ip_address` varchar(50) NOT NULL,
  `updateby` varchar(50) DEFAULT NULL,
  `updatedatetime` datetime DEFAULT NULL,
  `update_ip_address` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`inc_tm_amt_id`) USING BTREE,
  UNIQUE KEY `target_entry_id_designation_code_emp_code` (`target_entry_id`,`designation_code`,`emp_code`),
  KEY `FK_incentive_team_amt_details_target_entry_details` (`target_entry_id`),
  KEY `hr_id` (`designation_code`) USING BTREE,
  CONSTRAINT `FK_incentive_team_amt_details_mas_team_incentive_amt` FOREIGN KEY (`designation_code`) REFERENCES `mas_team_incentive_amt` (`designation_code`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `FK_incentive_team_amt_details_target_entry_details` FOREIGN KEY (`target_entry_id`) REFERENCES `target_entry_details` (`target_entry_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=22326 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='ifsc code ko bank code nad branch code se mila kar niklna hai';

-- Data exporting was unselected.

-- Dumping structure for table ayush_incentive_schema.log_emp_pfms_details
CREATE TABLE IF NOT EXISTS `log_emp_pfms_details` (
  `log_id` int(11) NOT NULL AUTO_INCREMENT,
  `id` int(11) DEFAULT NULL,
  `pfms_id` varchar(50) DEFAULT NULL,
  `designation_code` int(11) DEFAULT NULL,
  `emp_code` varchar(50) DEFAULT NULL,
  `emp_name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `account_no` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `bank_ifsc_code` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `mobile_no` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `district_code` int(11) DEFAULT NULL,
  `hc_id` int(11) NOT NULL,
  `entryby` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `entrydatetime` datetime DEFAULT current_timestamp(),
  `ip_address` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `updateby` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `updatedatetime` datetime DEFAULT NULL,
  `update_ip_address` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `status` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`log_id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;

-- Data exporting was unselected.

-- Dumping structure for table ayush_incentive_schema.log_incentive_entry_details
CREATE TABLE IF NOT EXISTS `log_incentive_entry_details` (
  `log_entry_id` int(11) NOT NULL AUTO_INCREMENT,
  `entry_id` int(11) NOT NULL,
  `activity_code` int(11) NOT NULL,
  `target_entry_id` int(11) NOT NULL,
  `monthly_target_value` varchar(50) DEFAULT NULL,
  `target_achieved_value` varchar(50) DEFAULT NULL,
  `performance_grade` int(11) DEFAULT NULL,
  `performance_percent` int(11) DEFAULT NULL,
  `total_prev_target_achieved_value` int(11) DEFAULT NULL,
  `entryby` varchar(50) DEFAULT NULL,
  `entrydatetime` datetime NOT NULL DEFAULT current_timestamp(),
  `ip_address` varchar(50) DEFAULT NULL,
  `updateby` varchar(50) DEFAULT NULL,
  `updatedatetime` datetime DEFAULT NULL,
  `update_ip_address` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`log_entry_id`) USING BTREE,
  KEY `activity_code` (`activity_code`) USING BTREE,
  KEY `performance_grade` (`performance_grade`) USING BTREE,
  KEY `target_entry_id` (`target_entry_id`) USING BTREE,
  CONSTRAINT `log_incentive_entry_details_ibfk_1` FOREIGN KEY (`activity_code`) REFERENCES `mas_activity` (`activity_code`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `log_incentive_entry_details_ibfk_2` FOREIGN KEY (`performance_grade`) REFERENCES `mas_grade` (`grade_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `log_incentive_entry_details_ibfk_3` FOREIGN KEY (`target_entry_id`) REFERENCES `target_entry_details` (`target_entry_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=5675 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Data exporting was unselected.

-- Dumping structure for table ayush_incentive_schema.log_incentive_entry_status_details
CREATE TABLE IF NOT EXISTS `log_incentive_entry_status_details` (
  `log_status_id` int(11) NOT NULL AUTO_INCREMENT,
  `status_id` int(11) NOT NULL,
  `target_entry_id` int(11) NOT NULL,
  `hc_lock_status` enum('pending','approve') CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT 'pending',
  `hc_lock_dt` datetime DEFAULT NULL,
  `hc_lock_ip_address` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `dist_status` enum('pending','approve','reject') CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT 'pending',
  `dist_decline_id` int(11) DEFAULT NULL,
  `dist_reject_other_reason` varchar(200) DEFAULT NULL,
  `dist_status_dt` datetime DEFAULT NULL,
  `dist_status_ip_address` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `is_dawapatrak_unlock` enum('Y','N') NOT NULL DEFAULT 'N',
  `dawapatrak_unlock_dt` datetime DEFAULT NULL,
  `dawapatrak_unlock_ip_address` varchar(50) DEFAULT NULL,
  `dawapatrak_unlock_reason` varchar(200) DEFAULT NULL,
  `state_approve_status` char(4) DEFAULT 'N',
  `state_approve_dt` datetime DEFAULT NULL,
  `state_approve_ip_address` varchar(50) DEFAULT NULL,
  `excel_filename` varchar(300) DEFAULT NULL,
  `is_send_for_payment` char(4) DEFAULT 'N',
  `send_for_payment_dt` datetime DEFAULT NULL,
  `send_for_payment_ip_address` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`log_status_id`) USING BTREE,
  KEY `FK_incentive_entry_status_details_target_entry_details` (`target_entry_id`) USING BTREE,
  KEY `FK_log_incentive_entry_status_details_mas_decline` (`dist_decline_id`),
  CONSTRAINT `FK_log_incentive_entry_status_details_mas_decline` FOREIGN KEY (`dist_decline_id`) REFERENCES `mas_decline` (`decline_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `log_incentive_entry_status_details_ibfk_1` FOREIGN KEY (`target_entry_id`) REFERENCES `target_entry_details` (`target_entry_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=6181 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Data exporting was unselected.

-- Dumping structure for table ayush_incentive_schema.log_incentive_six_month_amt_details
CREATE TABLE IF NOT EXISTS `log_incentive_six_month_amt_details` (
  `log_six_month_amt_id` int(11) NOT NULL AUTO_INCREMENT,
  `six_month_amt_id` int(11) NOT NULL,
  `inc_tm_amt_id` int(11) NOT NULL,
  `target_entry_id` int(11) NOT NULL,
  `amount` int(11) NOT NULL,
  `entryby` varchar(50) DEFAULT NULL,
  `entrydatetime` datetime DEFAULT NULL,
  `ip_address` varchar(50) DEFAULT NULL,
  `updateby` varchar(50) DEFAULT NULL,
  `updatedatetime` datetime DEFAULT NULL,
  `update_ip_address` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`log_six_month_amt_id`),
  KEY `FK_incentive_team_amt_details_target_entry_details` (`target_entry_id`) USING BTREE,
  KEY `inc_tm_amt_id` (`inc_tm_amt_id`) USING BTREE,
  KEY `six_month_amt_id1` (`six_month_amt_id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=4053 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Data exporting was unselected.

-- Dumping structure for table ayush_incentive_schema.log_incentive_team_amt_details
CREATE TABLE IF NOT EXISTS `log_incentive_team_amt_details` (
  `log_inc_tm_amt_id` int(11) NOT NULL AUTO_INCREMENT,
  `inc_tm_amt_id` int(11) NOT NULL,
  `target_entry_id` int(11) NOT NULL,
  `designation_code` int(11) NOT NULL,
  `emp_code` varchar(100) NOT NULL,
  `emp_name` varchar(100) NOT NULL,
  `account_no` varchar(100) NOT NULL,
  `bank_code` int(11) DEFAULT NULL,
  `branch_code` int(11) DEFAULT NULL,
  `bank_ifsc_code` varchar(100) DEFAULT NULL,
  `mobile_no` varchar(20) DEFAULT NULL,
  `amount` int(11) NOT NULL,
  `entryby` varchar(50) DEFAULT NULL,
  `entrydatetime` datetime DEFAULT NULL,
  `ip_address` varchar(50) DEFAULT NULL,
  `updateby` varchar(50) DEFAULT NULL,
  `updatedatetime` datetime DEFAULT NULL,
  `update_ip_address` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`log_inc_tm_amt_id`) USING BTREE,
  KEY `FK_incentive_team_amt_details_target_entry_details` (`target_entry_id`) USING BTREE,
  KEY `hr_id` (`designation_code`) USING BTREE,
  CONSTRAINT `log_incentive_team_amt_details_ibfk_1` FOREIGN KEY (`designation_code`) REFERENCES `mas_team_incentive_amt` (`designation_code`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `log_incentive_team_amt_details_ibfk_2` FOREIGN KEY (`target_entry_id`) REFERENCES `target_entry_details` (`target_entry_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=3519 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Data exporting was unselected.

-- Dumping structure for table ayush_incentive_schema.log_mas_login
CREATE TABLE IF NOT EXISTS `log_mas_login` (
  `HC_ID` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `hcname_en` varchar(100) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL,
  `hcname_hi` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL,
  `district_code` int(11) DEFAULT NULL,
  `district_id` int(11) DEFAULT NULL,
  `block_code` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL,
  `role` tinyint(4) NOT NULL DEFAULT 0,
  `password` varchar(100) NOT NULL DEFAULT '$2b$12$HBwr9bSIvyumwcrSWeRCPuHS9DKJwgFOfYAT1B/gZuJHH0HMhJGFu' COMMENT '$2b$12$HBwr9bSIvyumwcrSWeRCPuHS9DKJwgFOfYAT1B/gZuJHH0HMhJGFu',
  `ischangepwd` char(2) DEFAULT 'N',
  `pass_update_by` varchar(50) DEFAULT NULL,
  `pass_update_ip_address` varchar(100) DEFAULT NULL,
  `pass_update_dt` datetime DEFAULT NULL,
  `is_active` char(2) DEFAULT 'Y'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Data exporting was unselected.

-- Dumping structure for table ayush_incentive_schema.log_mas_menu
CREATE TABLE IF NOT EXISTS `log_mas_menu` (
  `pk_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `menu_code` int(11) NOT NULL,
  `role` tinyint(4) NOT NULL,
  `module_type` varchar(30) NOT NULL,
  `title` enum('Dashboard','Forms','Reports','Payment','Programs') DEFAULT NULL,
  `is_title` tinyint(4) NOT NULL,
  `display_name` varchar(50) NOT NULL,
  `route` varchar(100) NOT NULL,
  `icon` varchar(20) DEFAULT NULL,
  `is_active` enum('Y','N') NOT NULL,
  `menu_order` int(11) DEFAULT NULL,
  `title_order` int(11) DEFAULT NULL,
  `create_date` datetime NOT NULL,
  `end_date` datetime DEFAULT NULL,
  `can_access_working_hwc` enum('Y','N') DEFAULT NULL,
  `action` varchar(10) DEFAULT NULL,
  `action_dtstamp` datetime DEFAULT current_timestamp(),
  `log_type` char(2) DEFAULT 'DB',
  `changed_by` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`pk_id`)
) ENGINE=InnoDB AUTO_INCREMENT=53 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Data exporting was unselected.

-- Dumping structure for table ayush_incentive_schema.log_payment_response_details
CREATE TABLE IF NOT EXISTS `log_payment_response_details` (
  `id` bigint(20) NOT NULL,
  `payment_id` bigint(20) DEFAULT NULL,
  `pfms_id` varchar(50) NOT NULL,
  `hc_id` int(11) DEFAULT NULL,
  `year` int(11) DEFAULT NULL,
  `month` int(11) DEFAULT NULL,
  `designation_code` int(11) DEFAULT NULL,
  `emp_code` varchar(100) DEFAULT NULL,
  `emp_name` varchar(100) DEFAULT NULL,
  `bank_ifsc_code` varchar(100) DEFAULT NULL,
  `account_no` varchar(100) DEFAULT NULL,
  `amount` int(11) DEFAULT 0,
  `six_month_amount` int(11) DEFAULT 0,
  `total_amount` int(11) DEFAULT 0,
  `send_by` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `send_dt` datetime DEFAULT NULL,
  `send_ip_address` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;

-- Data exporting was unselected.

-- Dumping structure for table ayush_incentive_schema.log_program_ayurvidya_entry
CREATE TABLE IF NOT EXISTS `log_program_ayurvidya_entry` (
  `pk_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `ayurvidya_entry_id` int(10) unsigned NOT NULL,
  `year_id` int(10) unsigned NOT NULL,
  `month_id` int(10) unsigned NOT NULL,
  `emp_code` varchar(50) NOT NULL,
  `district_code` varchar(50) NOT NULL,
  `district_id` varchar(50) NOT NULL,
  `block_id` varchar(50) NOT NULL,
  `hc_id` varchar(50) NOT NULL,
  `entry_status` enum('D','L','F') NOT NULL,
  `number_of_schools` int(10) unsigned NOT NULL,
  `visits_per_month` int(10) unsigned NOT NULL,
  `visit_level_1` int(10) unsigned NOT NULL,
  `visit_level_2` int(10) unsigned NOT NULL,
  `visit_level_3` int(10) unsigned NOT NULL,
  `visit_level_4` int(10) unsigned NOT NULL,
  `awareness_lectures_given` int(10) unsigned NOT NULL,
  `awareness_lecture_beneficiaries` int(10) unsigned NOT NULL,
  `medicinal_plants_planted` int(10) unsigned NOT NULL,
  `yoga_camps_in_school` int(10) unsigned NOT NULL,
  `yoga_beneficiaries` int(10) unsigned NOT NULL,
  `prakriti_parikshan_count` int(10) unsigned NOT NULL,
  `prakriti_awareness_lectures` int(10) unsigned NOT NULL,
  `diseased_children_found` int(10) unsigned NOT NULL,
  `diseased_children_attended_hospital` int(10) unsigned NOT NULL,
  `num_diseased_children_reffered` int(10) unsigned NOT NULL,
  `stressed_students_11th_12th` int(10) unsigned NOT NULL,
  `garden_hospital_visit_count` int(10) unsigned NOT NULL,
  `students_visited_dispensary_garden_hospital` int(10) unsigned NOT NULL,
  `program_forwarded_district_by` varchar(50) DEFAULT NULL,
  `program_forwarded_district_at` datetime DEFAULT NULL,
  `program_forwarded_district_ip_address` varchar(50) DEFAULT NULL,
  `program_unlocked_state_reason` varchar(256) DEFAULT NULL,
  `program_unlocked_state_by` varchar(50) DEFAULT NULL,
  `program_unlocked_state_at` datetime DEFAULT NULL,
  `program_unlocked_state_ip_address` varchar(50) DEFAULT NULL,
  `created_by` varchar(50) NOT NULL,
  `created_at` datetime NOT NULL,
  `ip_address` varchar(50) NOT NULL,
  `updated_by` varchar(50) DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `updated_ip_address` varchar(50) DEFAULT NULL,
  `action` varchar(10) DEFAULT NULL,
  `action_dtstamp` datetime DEFAULT current_timestamp(),
  `log_type` char(2) DEFAULT 'DB',
  `changed_by` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`pk_id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Data exporting was unselected.

-- Dumping structure for table ayush_incentive_schema.log_program_checklist_mapping
CREATE TABLE IF NOT EXISTS `log_program_checklist_mapping` (
  `pk_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `mapping_id` int(10) unsigned NOT NULL,
  `program_id` int(10) unsigned NOT NULL,
  `checklist_id` int(10) unsigned NOT NULL,
  `is_active` tinyint(1) unsigned NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `updated_at` timestamp NULL DEFAULT NULL,
  `created_by` varchar(50) NOT NULL,
  `updated_by` varchar(50) DEFAULT NULL,
  `ip_address` varchar(50) NOT NULL,
  `action` varchar(10) DEFAULT NULL,
  `action_dtstamp` datetime DEFAULT current_timestamp(),
  `log_type` char(2) DEFAULT 'DB',
  `changed_by` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`pk_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Data exporting was unselected.

-- Dumping structure for table ayush_incentive_schema.log_program_doctor_assignment
CREATE TABLE IF NOT EXISTS `log_program_doctor_assignment` (
  `pk_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `assignment_id` bigint(20) unsigned NOT NULL,
  `details_id` int(10) unsigned NOT NULL,
  `program_id` int(10) unsigned NOT NULL,
  `is_active` tinyint(1) unsigned NOT NULL COMMENT '0: Inactive; 1: Active',
  `created_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `created_by` varchar(50) NOT NULL,
  `ip_address` varchar(50) NOT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `updated_by` varchar(50) DEFAULT NULL,
  `updated_ip_address` varchar(50) DEFAULT NULL,
  `action` varchar(10) DEFAULT NULL,
  `action_dtstamp` datetime DEFAULT current_timestamp(),
  `log_type` char(2) DEFAULT 'DB',
  `changed_by` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`pk_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Data exporting was unselected.

-- Dumping structure for table ayush_incentive_schema.log_program_doctor_details
CREATE TABLE IF NOT EXISTS `log_program_doctor_details` (
  `pk_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `details_id` int(10) unsigned NOT NULL,
  `mapped_district_code` varchar(50) NOT NULL,
  `emp_code` varchar(50) NOT NULL,
  `hc_id` varchar(10) NOT NULL,
  `emp_name` varchar(255) NOT NULL,
  `designation` varchar(255) NOT NULL,
  `mobile_no` varchar(10) NOT NULL,
  `post_code` varchar(10) DEFAULT NULL,
  `district_id` int(11) NOT NULL,
  `block_id` varchar(10) NOT NULL,
  `is_active` tinyint(1) unsigned NOT NULL COMMENT '0: Inactive; 1: Active',
  `created_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `created_by` varchar(50) NOT NULL,
  `ip_address` varchar(50) NOT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `updated_by` varchar(50) DEFAULT NULL,
  `updated_ip_address` varchar(50) DEFAULT NULL,
  `action` varchar(10) DEFAULT NULL,
  `action_dtstamp` datetime DEFAULT current_timestamp(),
  `log_type` char(2) DEFAULT 'DB',
  `changed_by` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`pk_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Data exporting was unselected.

-- Dumping structure for table ayush_incentive_schema.log_program_entry_schedules
CREATE TABLE IF NOT EXISTS `log_program_entry_schedules` (
  `pk_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `schedule_id` int(10) unsigned NOT NULL,
  `program_id` int(10) unsigned NOT NULL,
  `start_date` int(10) unsigned NOT NULL,
  `end_date` int(10) unsigned NOT NULL,
  `start_time` time NOT NULL,
  `end_time` time NOT NULL,
  `start_date_original` int(10) unsigned NOT NULL,
  `end_date_original` int(10) unsigned NOT NULL,
  `start_time_original` time NOT NULL,
  `end_time_original` time NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `updated_at` timestamp NULL DEFAULT NULL,
  `created_by` varchar(50) NOT NULL,
  `updated_by` varchar(50) DEFAULT NULL,
  `ip_address` varchar(50) NOT NULL,
  `action` varchar(10) DEFAULT NULL,
  `action_dtstamp` datetime DEFAULT current_timestamp(),
  `log_type` char(2) DEFAULT 'DB',
  `changed_by` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`pk_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Data exporting was unselected.

-- Dumping structure for table ayush_incentive_schema.log_program_karunya_palliative_entry
CREATE TABLE IF NOT EXISTS `log_program_karunya_palliative_entry` (
  `pk_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `karunya_palliative_entry_id` int(11) unsigned NOT NULL,
  `year_id` int(10) unsigned NOT NULL,
  `month_id` int(10) unsigned NOT NULL,
  `emp_code` varchar(50) NOT NULL,
  `district_code` varchar(50) NOT NULL,
  `district_id` varchar(50) NOT NULL,
  `block_id` varchar(50) NOT NULL,
  `hc_id` varchar(50) NOT NULL,
  `entry_status` enum('D','L','F') DEFAULT NULL,
  `home_visit_place_village` int(10) unsigned NOT NULL,
  `home_visit_place_city_ward` int(10) unsigned NOT NULL,
  `num_home_bond_patient` int(10) unsigned NOT NULL,
  `diagnosis_cancer_home_bond` int(10) unsigned NOT NULL,
  `diagnosis_cancer_opd` int(10) unsigned NOT NULL,
  `diagnosis_stroke_or_spinal_cord_home_bond` int(10) unsigned NOT NULL,
  `diagnosis_stroke_or_spinal_cord_opd` int(10) unsigned NOT NULL,
  `diagnosis_chronic_neurological_diseases_home_bond` int(10) unsigned NOT NULL,
  `diagnosis_chronic_neurological_diseases_opd` int(10) unsigned NOT NULL,
  `diagnosis_old_age_conditions_home_bond` int(10) unsigned NOT NULL,
  `diagnosis_old_age_conditions_opd` int(10) unsigned NOT NULL,
  `diagnosis_children_with_cerebral_palsy_home_bond` int(10) unsigned NOT NULL,
  `diagnosis_children_with_cerebral_palsy_opd` int(10) unsigned NOT NULL,
  `diagnosis_psycho_social_supports_organ_failures_home_bond` int(10) unsigned NOT NULL,
  `diagnosis_psycho_social_supports_organ_failures_opd` int(10) unsigned NOT NULL,
  `diagnosis_auto_immune_diseases_home_bond` int(10) unsigned NOT NULL,
  `diagnosis_auto_immune_diseases_opd` int(10) unsigned NOT NULL,
  `diagnosis_other_diseases_home_bond` int(10) unsigned NOT NULL,
  `diagnosis_other_diseases_opd` int(10) unsigned NOT NULL,
  `care_plan_serv_home_bond_pt_medicine` int(10) unsigned NOT NULL,
  `care_plan_serv_home_bond_pt_councelling` int(10) unsigned NOT NULL,
  `care_plan_serv_home_bond_pt_therapy` int(10) unsigned NOT NULL,
  `status_home_bond_pt_active` int(10) unsigned NOT NULL,
  `status_home_bond_pt_referred` int(10) unsigned NOT NULL,
  `status_home_bond_pt_expired` int(10) unsigned NOT NULL,
  `num_opd_pt_registered_village` int(10) unsigned NOT NULL,
  `num_opd_pt_registered_city_ward` int(10) unsigned NOT NULL,
  `care_plan_serv_opd_pt_therapy` int(10) unsigned NOT NULL,
  `care_plan_serv_opd_pt_councelling` int(10) unsigned NOT NULL,
  `care_plan_serv_opd_pt_medicine` int(10) unsigned NOT NULL,
  `status_opd_pt_referred` int(10) unsigned NOT NULL,
  `status_opd_pt_active` int(10) unsigned NOT NULL,
  `status_opd_pt_expired` int(10) unsigned NOT NULL,
  `num_patient_improvement_quality_life` int(10) unsigned NOT NULL,
  `family_advice` int(10) unsigned NOT NULL,
  `program_forwarded_district_by` varchar(50) DEFAULT NULL,
  `program_forwarded_district_at` datetime DEFAULT NULL,
  `program_forwarded_district_ip_address` varchar(50) DEFAULT NULL,
  `program_unlocked_state_reason` varchar(256) DEFAULT NULL,
  `program_unlocked_state_by` varchar(50) DEFAULT NULL,
  `program_unlocked_state_at` datetime DEFAULT NULL,
  `program_unlocked_state_ip_address` varchar(50) DEFAULT NULL,
  `created_by` varchar(50) NOT NULL,
  `created_at` datetime NOT NULL,
  `ip_address` varchar(50) NOT NULL,
  `updated_by` varchar(50) DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `updated_ip_address` varchar(50) DEFAULT NULL,
  `action` varchar(10) DEFAULT NULL,
  `action_dtstamp` datetime DEFAULT current_timestamp(),
  `log_type` char(2) DEFAULT 'DB',
  `changed_by` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`pk_id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Data exporting was unselected.

-- Dumping structure for table ayush_incentive_schema.log_program_master
CREATE TABLE IF NOT EXISTS `log_program_master` (
  `pk_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `program_id` int(10) unsigned NOT NULL,
  `program_name_en` varchar(255) NOT NULL,
  `program_name_hi` varchar(255) NOT NULL,
  `route_name` varchar(50) NOT NULL,
  `entry_table_name` varchar(50) NOT NULL,
  `program_emp_count` int(10) unsigned NOT NULL,
  `schedule_type_id` int(10) unsigned NOT NULL COMMENT '1: Daily; 2: Monthly',
  `is_active` tinyint(1) unsigned NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `updated_at` timestamp NULL DEFAULT NULL,
  `created_by` varchar(50) NOT NULL,
  `updated_by` varchar(50) DEFAULT NULL,
  `ip_address` varchar(50) NOT NULL,
  `action` varchar(10) DEFAULT NULL,
  `action_dtstamp` datetime DEFAULT current_timestamp(),
  `log_type` char(2) DEFAULT 'DB',
  `changed_by` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`pk_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Data exporting was unselected.

-- Dumping structure for table ayush_incentive_schema.log_program_mas_checklist
CREATE TABLE IF NOT EXISTS `log_program_mas_checklist` (
  `pk_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `checklist_id` int(10) unsigned NOT NULL,
  `checklist_name_en` varchar(255) NOT NULL,
  `checklist_name_hi` varchar(255) NOT NULL,
  `is_active` tinyint(1) unsigned NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `updated_at` timestamp NULL DEFAULT NULL,
  `created_by` varchar(50) NOT NULL,
  `updated_by` varchar(50) DEFAULT NULL,
  `ip_address` varchar(50) NOT NULL,
  `action` varchar(10) DEFAULT NULL,
  `action_dtstamp` datetime DEFAULT current_timestamp(),
  `log_type` char(2) DEFAULT 'DB',
  `changed_by` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`pk_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Data exporting was unselected.

-- Dumping structure for table ayush_incentive_schema.log_program_mas_designation
CREATE TABLE IF NOT EXISTS `log_program_mas_designation` (
  `pk_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `designation_code` int(11) unsigned NOT NULL,
  `designation_name_hi` varchar(50) NOT NULL,
  `designation_name_en` varchar(50) NOT NULL,
  `is_active` tinyint(3) unsigned NOT NULL,
  `action` varchar(10) DEFAULT NULL,
  `action_dtstamp` datetime DEFAULT current_timestamp(),
  `log_type` char(2) DEFAULT 'DB',
  `changed_by` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`pk_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Data exporting was unselected.

-- Dumping structure for table ayush_incentive_schema.log_program_mas_entry_schedule
CREATE TABLE IF NOT EXISTS `log_program_mas_entry_schedule` (
  `pk_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `schedule_type_id` int(10) unsigned NOT NULL,
  `schedule_type_name` varchar(20) NOT NULL,
  `action` varchar(10) DEFAULT NULL,
  `action_dtstamp` datetime DEFAULT current_timestamp(),
  `log_type` char(2) DEFAULT 'DB',
  `changed_by` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`pk_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Data exporting was unselected.

-- Dumping structure for table ayush_incentive_schema.log_program_mas_kpi_indicator
CREATE TABLE IF NOT EXISTS `log_program_mas_kpi_indicator` (
  `pk_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `kpi_id` int(11) unsigned NOT NULL,
  `program_id` int(11) unsigned NOT NULL,
  `kpi_name` varchar(255) NOT NULL,
  `kpi_description` text NOT NULL,
  `entry_table_name` varchar(120) NOT NULL,
  `entry_column_name` varchar(255) NOT NULL,
  `calculation_type` enum('SUM','COUNT','AVG','FORMULA','CUSTOM') NOT NULL,
  `formula_expression` text DEFAULT NULL,
  `display_order` int(10) unsigned NOT NULL,
  `is_active` tinyint(1) unsigned NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `created_by` varchar(50) NOT NULL,
  `ip_address` varchar(50) NOT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `updated_by` varchar(50) DEFAULT NULL,
  `updated_ip_address` varchar(50) DEFAULT NULL,
  `action` varchar(10) DEFAULT NULL,
  `action_dtstamp` datetime DEFAULT current_timestamp(),
  `log_type` char(2) DEFAULT 'DB',
  `changed_by` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`pk_id`)
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Data exporting was unselected.

-- Dumping structure for table ayush_incentive_schema.log_program_mas_month
CREATE TABLE IF NOT EXISTS `log_program_mas_month` (
  `pk_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `month_id` int(11) unsigned NOT NULL,
  `month_name_en` varchar(20) NOT NULL,
  `month_name_hi` varchar(20) NOT NULL,
  `month_order` tinyint(4) unsigned NOT NULL,
  `action` varchar(10) DEFAULT NULL,
  `action_dtstamp` datetime DEFAULT current_timestamp(),
  `log_type` char(2) DEFAULT 'DB',
  `changed_by` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`pk_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Data exporting was unselected.

-- Dumping structure for table ayush_incentive_schema.log_program_mas_qualification
CREATE TABLE IF NOT EXISTS `log_program_mas_qualification` (
  `pk_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `qualification_code` smallint(6) NOT NULL,
  `qualification_name_hi` varchar(50) NOT NULL,
  `qualification_name_en` varchar(50) NOT NULL,
  `is_active` tinyint(3) unsigned NOT NULL,
  `action` varchar(10) DEFAULT NULL,
  `action_dtstamp` datetime DEFAULT current_timestamp(),
  `log_type` char(2) DEFAULT 'DB',
  `changed_by` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`pk_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Data exporting was unselected.

-- Dumping structure for table ayush_incentive_schema.log_program_mas_week
CREATE TABLE IF NOT EXISTS `log_program_mas_week` (
  `pk_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `week_id` int(10) unsigned NOT NULL,
  `week_name_en` varchar(20) NOT NULL,
  `week_name_hi` varchar(20) NOT NULL,
  `week_order` tinyint(4) unsigned NOT NULL,
  `action` varchar(10) DEFAULT NULL,
  `action_dtstamp` datetime DEFAULT current_timestamp(),
  `log_type` char(2) DEFAULT 'DB',
  `changed_by` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`pk_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Data exporting was unselected.

-- Dumping structure for table ayush_incentive_schema.log_program_mas_year
CREATE TABLE IF NOT EXISTS `log_program_mas_year` (
  `pk_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `year_id` int(11) unsigned NOT NULL,
  `year_name` varchar(20) NOT NULL,
  `is_current_year` char(1) NOT NULL,
  `year_order` tinyint(4) unsigned NOT NULL,
  `action` varchar(10) DEFAULT NULL,
  `action_dtstamp` datetime DEFAULT current_timestamp(),
  `log_type` char(2) DEFAULT 'DB',
  `changed_by` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`pk_id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Data exporting was unselected.

-- Dumping structure for table ayush_incentive_schema.log_program_mmu_entry
CREATE TABLE IF NOT EXISTS `log_program_mmu_entry` (
  `pk_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `mmu_entry_id` int(11) unsigned NOT NULL,
  `year_id` int(10) unsigned NOT NULL,
  `month_id` int(10) unsigned NOT NULL,
  `week_id` int(10) unsigned NOT NULL,
  `emp_code` varchar(50) NOT NULL,
  `district_code` varchar(50) NOT NULL,
  `district_id` varchar(50) NOT NULL,
  `block_id` varchar(50) NOT NULL,
  `hc_id` varchar(50) NOT NULL,
  `entry_status` enum('D','L','F') NOT NULL,
  `village_code` varchar(50) NOT NULL,
  `visit_block_id` varchar(50) NOT NULL,
  `visit_date` date NOT NULL,
  `visit_day` varchar(20) NOT NULL,
  `num_camp_conduct` int(10) unsigned NOT NULL,
  `total_num_beneficiaries` int(10) unsigned NOT NULL,
  `num_male` int(10) unsigned NOT NULL,
  `num_female` int(10) unsigned NOT NULL,
  `abujhmad_pvtg` int(10) unsigned NOT NULL COMMENT 'PVTG',
  `baiga_pvtg` int(10) unsigned NOT NULL COMMENT 'PVTG',
  `birhor_pvtg` int(10) unsigned NOT NULL COMMENT 'PVTG',
  `pahadi_korva_pvtg` int(10) unsigned NOT NULL COMMENT 'PVTG',
  `kamar_pvtg` int(10) unsigned NOT NULL COMMENT 'PVTG',
  `other_pvtg` int(10) unsigned NOT NULL COMMENT 'PVTG',
  `disease_total_num_resprespetory_tract_infections` int(10) unsigned NOT NULL,
  `disease_total_num_skin_diseases` int(10) unsigned NOT NULL,
  `disease_total_num_disorder_joint` int(10) unsigned NOT NULL,
  `disease_total_num_obs_gyn_disease` int(10) unsigned NOT NULL,
  `disease_total_num_git_disorder` int(10) unsigned NOT NULL,
  `disease_total_num_heart_disease` int(10) unsigned NOT NULL,
  `disease_total_num_diabetes` int(10) unsigned NOT NULL,
  `disease_total_num_htn` int(10) unsigned NOT NULL,
  `disease_total_num_mental_disorder` int(10) unsigned NOT NULL,
  `disease_total_num_fever` int(10) unsigned NOT NULL,
  `disease_total_num_ent` int(10) unsigned NOT NULL,
  `disease_total_num_eye_disorder` int(10) unsigned NOT NULL,
  `disease_total_num_dental` int(10) unsigned NOT NULL,
  `disease_total_num_tb` int(10) unsigned NOT NULL,
  `disease_total_num_leprosy` int(10) unsigned NOT NULL,
  `disease_total_num_filaria` int(10) unsigned NOT NULL,
  `disease_total_num_other_disease` int(10) unsigned NOT NULL,
  `total_num_investigation` int(10) unsigned NOT NULL,
  `total_num_beneficiaries_whose_health_status_improved` int(10) unsigned NOT NULL,
  `total_num_patient_referred` int(10) unsigned NOT NULL,
  `is_capture_location` tinyint(2) unsigned DEFAULT NULL,
  `latitude` decimal(11,8) unsigned DEFAULT NULL,
  `longitude` decimal(11,8) unsigned DEFAULT NULL,
  `capture_at` datetime DEFAULT NULL,
  `program_forwarded_district_by` varchar(50) DEFAULT NULL,
  `program_forwarded_district_at` datetime DEFAULT NULL,
  `program_forwarded_district_ip_address` varchar(50) DEFAULT NULL,
  `program_unlocked_state_reason` varchar(256) DEFAULT NULL,
  `program_unlocked_state_by` varchar(50) DEFAULT NULL,
  `program_unlocked_state_at` datetime DEFAULT NULL,
  `program_unlocked_state_ip_address` varchar(50) DEFAULT NULL,
  `created_by` varchar(50) NOT NULL,
  `created_at` datetime NOT NULL,
  `ip_address` varchar(50) NOT NULL,
  `updated_by` varchar(50) DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `updated_ip_address` varchar(50) DEFAULT NULL,
  `action` varchar(10) DEFAULT NULL,
  `action_dtstamp` datetime DEFAULT current_timestamp(),
  `log_type` char(2) DEFAULT 'DB',
  `changed_by` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`pk_id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Data exporting was unselected.

-- Dumping structure for table ayush_incentive_schema.log_program_nam_employee_details
CREATE TABLE IF NOT EXISTS `log_program_nam_employee_details` (
  `pk_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `emp_code` varchar(50) NOT NULL,
  `designation_code` int(11) unsigned NOT NULL,
  `role` tinyint(4) NOT NULL,
  `district_code` varchar(50) NOT NULL,
  `district_id` varchar(50) NOT NULL,
  `block_id` varchar(50) NOT NULL,
  `hc_id` varchar(50) NOT NULL,
  `emp_name_en` varchar(50) NOT NULL,
  `pan_number` varchar(10) NOT NULL,
  `emp_name_hi` varchar(50) NOT NULL,
  `father_husband` varchar(50) NOT NULL COMMENT '1 = पिता, 2  = पति',
  `f_hname` varchar(50) NOT NULL,
  `mobile_number` bigint(20) NOT NULL,
  `dob` date NOT NULL,
  `doj` date NOT NULL,
  `email` varchar(50) NOT NULL,
  `age` tinyint(4) NOT NULL,
  `gender` enum('Male','Female','Transgender') NOT NULL,
  `address` text NOT NULL,
  `hpr_id` varchar(50) DEFAULT NULL,
  `hfr_id` varchar(50) DEFAULT NULL,
  `order_copy_file_url` varchar(255) NOT NULL,
  `order_copy_file_name` varchar(255) NOT NULL,
  `is_uploaded_order_copy` char(2) NOT NULL,
  `password` varchar(100) NOT NULL,
  `ischangepwd` char(2) NOT NULL,
  `is_verified` char(2) NOT NULL,
  `is_active` tinyint(4) unsigned NOT NULL,
  `created_by` varchar(50) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `ip_address` varchar(50) NOT NULL,
  `updated_by` varchar(50) DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `updated_ip_address` varchar(50) DEFAULT NULL,
  `action` varchar(10) DEFAULT NULL,
  `action_dtstamp` datetime DEFAULT current_timestamp(),
  `log_type` char(2) DEFAULT 'DB',
  `changed_by` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`pk_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Data exporting was unselected.

-- Dumping structure for table ayush_incentive_schema.log_program_npcdcs_entry
CREATE TABLE IF NOT EXISTS `log_program_npcdcs_entry` (
  `pk_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `npcdcs_entry_id` bigint(20) unsigned NOT NULL,
  `month_id` int(10) unsigned NOT NULL,
  `year_id` int(10) unsigned NOT NULL,
  `emp_code` varchar(50) NOT NULL,
  `district_code` varchar(50) NOT NULL,
  `district_id` varchar(50) NOT NULL,
  `hc_id` varchar(50) NOT NULL,
  `entry_status` enum('D','L','F') NOT NULL,
  `num_of_yoga_instructor` int(11) unsigned NOT NULL,
  `age_30_40` int(11) unsigned NOT NULL COMMENT 'Age',
  `age_40_50` int(11) unsigned NOT NULL COMMENT 'Age',
  `age_60_above` int(11) unsigned NOT NULL COMMENT 'Age',
  `sex_female` int(11) unsigned NOT NULL COMMENT 'Sex',
  `sex_male` int(11) unsigned NOT NULL COMMENT 'Sex',
  `total_pt_registered_till_date_facility` int(11) unsigned NOT NULL,
  `total_num_new_pt_in_month` int(11) unsigned NOT NULL,
  `total_num_followup_pt_in_month` int(11) unsigned NOT NULL,
  `total_pt_registered_htn_num_pt` int(11) unsigned NOT NULL COMMENT 'Total pt. registered',
  `total_pt_registered_htn_num_pt_improvement` int(11) unsigned NOT NULL COMMENT 'Total pt. registered',
  `total_pt_registered_dm_num_pt` int(11) unsigned NOT NULL COMMENT 'Total pt. registered',
  `total_pt_registered_dm_num_pt_impovement` int(11) unsigned NOT NULL COMMENT 'Total pt. registered',
  `total_pt_registered_cancer_num_pt` int(11) unsigned NOT NULL COMMENT 'Total pt. registered',
  `total_pt_registered_hd_num_pt` int(11) unsigned NOT NULL COMMENT 'Total pt. registered',
  `total_pt_registered_stroke_num_pt` int(11) unsigned NOT NULL COMMENT 'Total pt. registered',
  `total_pt_registered_other_ds_num_pt` int(11) unsigned NOT NULL COMMENT 'Total pt. registered',
  `total_pt_registered_other_ds_num_pt_improvement` int(11) unsigned NOT NULL COMMENT 'Total pt. registered',
  `total_num_of_camp_conducted` int(11) unsigned NOT NULL,
  `num_pt_reg_till_date_camp` int(11) unsigned NOT NULL,
  `total_pt_reg_till_date_facility_plus_camp` int(11) unsigned NOT NULL,
  `total_num_of_beneficiarys_camp` int(11) unsigned NOT NULL,
  `total_num_of_yoga_beneficiaries_camp` int(11) unsigned NOT NULL,
  `total_num_of_yoga_beneficiaries_opd` int(11) unsigned NOT NULL,
  `total_num_of_ayush_intervention_camp` int(11) unsigned NOT NULL,
  `total_num_of_ayush_intervention_facility` int(11) unsigned NOT NULL,
  `total_reduction_allopathic_med` int(11) unsigned NOT NULL,
  `num_of_referred_pt_allopathic` int(11) unsigned NOT NULL,
  `num_of_referred_pt_ayush_higher_center` int(11) unsigned NOT NULL,
  `total_num_of_yoga_instructor_training` int(11) unsigned NOT NULL,
  `num_of_pt_improvement_after_yoga` int(11) unsigned NOT NULL,
  `program_forwarded_district_by` varchar(50) DEFAULT NULL,
  `program_forwarded_district_at` datetime DEFAULT NULL,
  `program_forwarded_district_ip_address` varchar(50) DEFAULT NULL,
  `program_unlocked_state_reason` varchar(256) DEFAULT NULL,
  `program_unlocked_state_by` varchar(50) DEFAULT NULL,
  `program_unlocked_state_at` datetime DEFAULT NULL,
  `program_unlocked_state_ip_address` varchar(50) DEFAULT NULL,
  `created_at` datetime NOT NULL,
  `created_by` varchar(50) NOT NULL COMMENT 'type_of_disorder',
  `ip_address` varchar(50) NOT NULL,
  `updated_by` varchar(50) DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `updated_ip_address` varchar(50) DEFAULT NULL,
  `action` varchar(10) DEFAULT NULL,
  `action_dtstamp` datetime DEFAULT current_timestamp(),
  `log_type` char(2) DEFAULT 'DB',
  `changed_by` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`pk_id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Data exporting was unselected.

-- Dumping structure for table ayush_incentive_schema.log_program_opd_entry
CREATE TABLE IF NOT EXISTS `log_program_opd_entry` (
  `pk_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `entry_id` bigint(20) unsigned NOT NULL,
  `entry_status_id` bigint(20) unsigned NOT NULL,
  `checklist_id` int(10) unsigned NOT NULL,
  `new_patient_value` int(11) DEFAULT NULL,
  `followup_patient_value` int(11) DEFAULT NULL,
  `created_by` varchar(50) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `updated_by` varchar(50) DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `ip_address` varchar(50) NOT NULL,
  `action` varchar(10) DEFAULT NULL,
  `action_dtstamp` datetime DEFAULT current_timestamp(),
  `log_type` char(2) DEFAULT 'DB',
  `changed_by` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`pk_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Data exporting was unselected.

-- Dumping structure for table ayush_incentive_schema.log_program_opd_entry_status
CREATE TABLE IF NOT EXISTS `log_program_opd_entry_status` (
  `pk_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `entry_status_id` bigint(20) unsigned NOT NULL,
  `program_id` int(10) unsigned NOT NULL,
  `emp_code` varchar(50) NOT NULL,
  `entry_at` date NOT NULL,
  `status` enum('D','L') NOT NULL,
  `created_by` varchar(50) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `updated_by` varchar(50) DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `ip_address` varchar(50) NOT NULL,
  `updated_ip_address` varchar(50) DEFAULT NULL,
  `action` varchar(10) DEFAULT NULL,
  `action_dtstamp` datetime DEFAULT current_timestamp(),
  `log_type` char(2) DEFAULT 'DB',
  `changed_by` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`pk_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Data exporting was unselected.

-- Dumping structure for table ayush_incentive_schema.log_program_osteo_entry
CREATE TABLE IF NOT EXISTS `log_program_osteo_entry` (
  `pk_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `osteo_entry_id` bigint(20) unsigned NOT NULL,
  `year_id` int(10) unsigned NOT NULL,
  `month_id` int(10) unsigned NOT NULL,
  `emp_code` varchar(50) NOT NULL,
  `district_code` varchar(50) NOT NULL,
  `district_id` varchar(50) NOT NULL,
  `block_id` varchar(50) NOT NULL,
  `hc_id` varchar(50) NOT NULL,
  `entry_status` enum('D','L','F') NOT NULL,
  `expected_population_of_block` int(11) unsigned NOT NULL,
  `eight_percent_of_expected_population_block` int(11) unsigned NOT NULL,
  `num_camp_conducted` int(11) unsigned NOT NULL,
  `num_person_attending_camp` int(11) unsigned NOT NULL,
  `num_pt_reg_till_date` int(11) unsigned NOT NULL,
  `num_new_pt_reg` int(11) unsigned NOT NULL,
  `num_follow_up_pt` int(11) unsigned NOT NULL,
  `osteoarthritis_diseases_diagnosed` int(11) unsigned NOT NULL,
  `frozen_shoulder_diseases_diagnosed` int(11) unsigned NOT NULL,
  `gout_diseases_diagnosed` int(11) unsigned NOT NULL,
  `cervical_spondylitis_diseases_diagnosed` int(11) unsigned NOT NULL,
  `lumber_spondylitis_diseases_diagnosed` int(11) unsigned NOT NULL,
  `sciatica_diseases_diagnosed` int(11) unsigned NOT NULL,
  `bells_palsy_diseases_diagnosed` int(11) unsigned NOT NULL,
  `planter_facitis_diseases_diagnosed` int(11) unsigned NOT NULL,
  `rheumatoid_arthritis_diseases_diagnosed` int(11) unsigned NOT NULL,
  `other_disease_diseases_diagnosed` int(11) unsigned NOT NULL,
  `num_pt_lifestyle_diet_ayushinter` int(11) unsigned NOT NULL,
  `num_pt_yoga_advice_ayushinter` int(11) unsigned NOT NULL,
  `num_panchkarma_counselling_ayushinter` int(11) unsigned NOT NULL,
  `num_pt_high_pain` int(11) unsigned NOT NULL,
  `num_pt_med_pain` int(11) unsigned NOT NULL,
  `num_pt_low_pain` int(11) unsigned NOT NULL,
  `num_pt_pain_clinicalimpr` int(11) unsigned NOT NULL,
  `num_pt_improvement_pain_clinicalimpr` int(11) unsigned NOT NULL,
  `num_pt_swelling_clinicalimpr` int(11) unsigned NOT NULL,
  `num_pt_improvement_swelling_clinicalimpr` int(11) unsigned NOT NULL,
  `num_pt_restricted_clinicalimpr` int(11) unsigned NOT NULL,
  `num_pt_improvement_restricted_clinicalimpr` int(11) unsigned NOT NULL,
  `num_patients_otherimpr` int(11) unsigned NOT NULL,
  `num_patients_improvement_otherimpr` int(11) unsigned NOT NULL,
  `num_pt_hwc_facility` int(11) unsigned NOT NULL,
  `num_pt_polyclinic_facility` int(11) unsigned NOT NULL,
  `num_pt_dh_ayushwing_facility` int(11) unsigned NOT NULL,
  `num_pt_allopathic_facility` int(11) unsigned NOT NULL,
  `num_pt_total_facility` int(11) unsigned NOT NULL,
  `num_ayush_treatment_received` int(11) unsigned NOT NULL,
  `total_num_followup` int(11) unsigned NOT NULL,
  `is_capture_location` tinyint(2) unsigned DEFAULT NULL,
  `latitude` decimal(11,8) unsigned DEFAULT NULL,
  `longitude` decimal(11,8) unsigned DEFAULT NULL,
  `capture_at` datetime DEFAULT NULL,
  `program_forwarded_district_by` varchar(50) DEFAULT NULL,
  `program_forwarded_district_at` datetime DEFAULT NULL,
  `program_forwarded_district_ip_address` varchar(50) DEFAULT NULL,
  `program_unlocked_state_reason` varchar(256) DEFAULT NULL,
  `program_unlocked_state_by` varchar(50) DEFAULT NULL,
  `program_unlocked_state_at` datetime DEFAULT NULL,
  `program_unlocked_state_ip_address` varchar(50) DEFAULT NULL,
  `created_by` varchar(50) NOT NULL,
  `created_at` datetime NOT NULL,
  `ip_address` varchar(50) NOT NULL,
  `updated_by` varchar(50) DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `updated_ip_address` varchar(50) DEFAULT NULL,
  `action` varchar(10) DEFAULT NULL,
  `action_dtstamp` datetime DEFAULT current_timestamp(),
  `log_type` char(2) DEFAULT 'DB',
  `changed_by` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`pk_id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Data exporting was unselected.

-- Dumping structure for table ayush_incentive_schema.log_program_supraja_anc_entry
CREATE TABLE IF NOT EXISTS `log_program_supraja_anc_entry` (
  `pk_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `supraja_anc_entry_id` int(10) unsigned NOT NULL,
  `year_id` int(10) unsigned NOT NULL,
  `month_id` int(10) unsigned NOT NULL,
  `emp_code` varchar(50) NOT NULL,
  `district_code` varchar(50) NOT NULL,
  `district_id` varchar(50) NOT NULL,
  `block_id` varchar(50) NOT NULL,
  `hc_id` varchar(50) NOT NULL,
  `entry_status` enum('D','L','F') NOT NULL,
  `num_anc_case_cumulative` int(10) unsigned NOT NULL,
  `num_anc_cases_registered_month` int(10) unsigned NOT NULL,
  `total_cases_delivered` int(10) unsigned NOT NULL,
  `num_left_cases_drop_out_cases` int(10) unsigned NOT NULL,
  `remaining_anc_cases_after_excluding` int(10) NOT NULL,
  `old_case_num_anc_checkup` int(10) unsigned NOT NULL,
  `new_case_num_anc_checkup` int(10) unsigned NOT NULL,
  `number_couple_counseling` int(10) unsigned NOT NULL,
  `garbh_sanskar_camp_conducted` int(10) unsigned NOT NULL,
  `total_num_beneficiaries` int(10) unsigned NOT NULL,
  `num_beneficiaries_monthly_yoga_practice` int(10) unsigned NOT NULL,
  `total_num_pt_advised_on_diet_yoga` int(10) unsigned NOT NULL,
  `num_cases_treated_for_minor_complications` int(10) unsigned NOT NULL,
  `num_beneficiaries_provided_ayurvedic_medicines` int(10) unsigned NOT NULL,
  `num_cases_referred_to_higher_centre` int(10) unsigned NOT NULL,
  `num_camps_conducted_in_reporting_month` int(10) unsigned NOT NULL,
  `remark` varchar(256) NOT NULL,
  `program_forwarded_district_by` varchar(50) DEFAULT NULL,
  `program_forwarded_district_at` datetime DEFAULT NULL,
  `program_forwarded_district_ip_address` varchar(50) DEFAULT NULL,
  `program_unlocked_state_reason` varchar(256) DEFAULT NULL,
  `program_unlocked_state_by` varchar(50) DEFAULT NULL,
  `program_unlocked_state_at` datetime DEFAULT NULL,
  `program_unlocked_state_ip_address` varchar(50) DEFAULT NULL,
  `created_by` varchar(50) NOT NULL,
  `created_at` datetime NOT NULL,
  `ip_address` varchar(50) NOT NULL,
  `updated_by` varchar(50) DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `updated_ip_address` varchar(50) DEFAULT NULL,
  `action` varchar(10) DEFAULT NULL,
  `action_dtstamp` datetime DEFAULT current_timestamp(),
  `log_type` char(2) DEFAULT 'DB',
  `changed_by` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`pk_id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Data exporting was unselected.

-- Dumping structure for table ayush_incentive_schema.log_program_supraja_pnc_entry
CREATE TABLE IF NOT EXISTS `log_program_supraja_pnc_entry` (
  `pk_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `supraja_pnc_entry_id` int(10) unsigned NOT NULL,
  `year_id` int(10) unsigned NOT NULL,
  `month_id` int(10) unsigned NOT NULL,
  `emp_code` varchar(50) NOT NULL,
  `district_code` varchar(50) NOT NULL,
  `district_id` varchar(50) NOT NULL,
  `block_id` varchar(50) NOT NULL,
  `hc_id` varchar(50) NOT NULL,
  `entry_status` enum('D','L','F') NOT NULL,
  `total_num_new_enrolled_patients_delivered` int(10) unsigned NOT NULL,
  `total_num_old_enrolled_patients_delivered` int(10) unsigned NOT NULL,
  `num_enrolled_patients_delivered_vaginally` int(10) unsigned NOT NULL,
  `num_enrolled_patients_delivered_by_cesarean_section` int(10) unsigned NOT NULL,
  `num_full_term_normal_deliveries_without_complications` int(10) unsigned NOT NULL,
  `num_pre_term_deliveries` int(10) unsigned NOT NULL,
  `num_deliveries_with_complications` int(10) unsigned NOT NULL,
  `num_neonatal_babies_with_normal_birth_weight` int(10) unsigned NOT NULL,
  `num_neonatal_babies_with_birth_weight_lt_twofivekg` int(10) unsigned NOT NULL,
  `puerperal_cases_provided_ayurvedic_medicine_given_care_yn` enum('Y','N') NOT NULL,
  `num_cases_in_which_neonatal_examinations_and_care_provided` int(10) unsigned NOT NULL,
  `num_cases_in_which_neonatal_swarn_praashan_immunization` int(10) unsigned NOT NULL,
  `num_cases_who_received_breast_feeding_guidence` int(10) unsigned NOT NULL,
  `remark` varchar(256) NOT NULL,
  `program_forwarded_district_by` varchar(50) DEFAULT NULL,
  `program_forwarded_district_at` datetime DEFAULT NULL,
  `program_forwarded_district_ip_address` varchar(50) DEFAULT NULL,
  `program_unlocked_state_reason` varchar(256) DEFAULT NULL,
  `program_unlocked_state_by` varchar(50) DEFAULT NULL,
  `program_unlocked_state_at` datetime DEFAULT NULL,
  `program_unlocked_state_ip_address` varchar(50) DEFAULT NULL,
  `created_by` varchar(50) NOT NULL,
  `created_at` datetime NOT NULL,
  `ip_address` varchar(50) NOT NULL,
  `updated_by` varchar(50) DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `updated_ip_address` varchar(50) DEFAULT NULL,
  `action` varchar(10) DEFAULT NULL,
  `action_dtstamp` datetime DEFAULT current_timestamp(),
  `log_type` char(2) DEFAULT 'DB',
  `changed_by` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`pk_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Data exporting was unselected.

-- Dumping structure for table ayush_incentive_schema.log_program_vayomitra_entry
CREATE TABLE IF NOT EXISTS `log_program_vayomitra_entry` (
  `pk_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `vayomitra_entry_id` int(10) unsigned NOT NULL,
  `year_id` int(10) unsigned NOT NULL,
  `month_id` int(10) unsigned NOT NULL,
  `emp_code` varchar(50) NOT NULL,
  `district_code` varchar(50) NOT NULL,
  `district_id` varchar(50) NOT NULL,
  `block_id` varchar(50) NOT NULL,
  `hc_id` varchar(50) NOT NULL,
  `entry_status` enum('D','L','F') NOT NULL,
  `expected_population_block` int(10) unsigned NOT NULL,
  `eight_percent_of_expected_population_block` int(10) unsigned NOT NULL,
  `num_camp_conducted` int(10) unsigned NOT NULL,
  `num_person_attending_camp` int(10) unsigned NOT NULL,
  `total_num_patient_reg_till_date` int(10) unsigned NOT NULL,
  `total_num_new_patient_reg` int(10) unsigned NOT NULL,
  `total_num_of_follow_up_patient` int(10) unsigned NOT NULL,
  `age_total_num_pt_60_69` int(10) unsigned NOT NULL,
  `age_total_num_pt_70_80` int(10) unsigned NOT NULL,
  `age_total_num_pt_more_than_80` int(10) unsigned NOT NULL,
  `disease_total_num_pt_osteoarthritis` int(10) unsigned NOT NULL COMMENT 'Types of Disease',
  `disease_total_num_pt_frozen_shoulder` int(10) unsigned NOT NULL COMMENT 'Types of Disease',
  `disease_total_num_pt_gout` int(10) unsigned NOT NULL COMMENT 'Types of Disease',
  `disease_total_num_pt_seiatica` int(10) unsigned NOT NULL COMMENT 'Types of Disease',
  `disease_total_num_pt_spondilitis` int(10) unsigned NOT NULL COMMENT 'Types of Disease',
  `disease_total_num_pt_hypertention` int(10) unsigned NOT NULL COMMENT 'Types of Disease',
  `disease_total_num_pt_diabetes` int(10) unsigned NOT NULL COMMENT 'Types of Disease',
  `disease_total_num_pt_bells_palsy` int(10) unsigned NOT NULL COMMENT 'Types of Disease',
  `disease_total_num_pt_ent` int(10) unsigned NOT NULL COMMENT 'Types of Disease',
  `disease_total_num_pt_git_gastritis` int(10) unsigned NOT NULL COMMENT 'Types of Disease',
  `disease_total_num_pt_respiratory_disorder` int(10) unsigned NOT NULL COMMENT 'Types of Disease',
  `disease_total_num_pt_other_disease` int(10) unsigned NOT NULL COMMENT 'Types of Disease',
  `daily_status_scal_mild_num_patient` int(10) unsigned NOT NULL,
  `daily_status_scal_mild_num_patient_impr` int(10) unsigned NOT NULL,
  `daily_status_scal_moderate_num_patient` int(10) unsigned NOT NULL,
  `daily_status_scal_moderate_num_patient_impr` int(10) unsigned NOT NULL,
  `daily_status_scal_severe_num_patient` int(10) unsigned NOT NULL,
  `daily_status_scal_severe_num_patient_impr` int(10) unsigned NOT NULL,
  `instrumental_activity_scale_mild_num_patient` int(10) unsigned NOT NULL,
  `instrumental_activity_scale_mild_num_patient_impr` int(10) unsigned NOT NULL,
  `instrumental_activity_scale_moderate_num_patient` int(10) unsigned NOT NULL,
  `instrumental_activity_scale_moderate_num_patient_impr` int(10) unsigned NOT NULL,
  `instrumental_activity_scale_severe_num_patient` int(10) unsigned NOT NULL,
  `instrumental_activity_scale_severe_num_patient_impr` int(10) unsigned NOT NULL,
  `num_pt_prescribed_medicine` int(10) unsigned NOT NULL,
  `num_ayush_intervention_lifestyle_changes_and_diet_councelling` int(10) unsigned NOT NULL,
  `num_ayush_intervention_yoga_advice` int(10) unsigned NOT NULL,
  `num_ayush_intervention_panchkrma` int(10) unsigned NOT NULL,
  `num_follow_up_suggested` int(10) unsigned NOT NULL,
  `refferal_status_hwc` int(10) unsigned NOT NULL,
  `refferal_status_hwc_polyclinic_stc` int(10) unsigned NOT NULL,
  `refferal_status_hwc_dh_ayushwing` int(10) unsigned NOT NULL,
  `refferal_status_hwc_allopathy_centre` int(10) unsigned NOT NULL,
  `total_num_improvement_qol` int(10) unsigned NOT NULL,
  `num_pt_reason_for_refer_panchkarma_mental_health` int(10) unsigned NOT NULL,
  `num_pt_linkage_with_other_dpt_shc_panchayt` int(10) unsigned NOT NULL,
  `is_capture_location` tinyint(2) unsigned DEFAULT NULL,
  `latitude` decimal(11,8) unsigned DEFAULT NULL,
  `longitude` decimal(11,8) unsigned DEFAULT NULL,
  `capture_at` datetime DEFAULT NULL,
  `program_forwarded_district_by` varchar(50) DEFAULT NULL,
  `program_forwarded_district_at` datetime DEFAULT NULL,
  `program_forwarded_district_ip_address` varchar(50) DEFAULT NULL,
  `program_unlocked_state_reason` varchar(256) DEFAULT NULL,
  `program_unlocked_state_by` varchar(50) DEFAULT NULL,
  `program_unlocked_state_at` datetime DEFAULT NULL,
  `program_unlocked_state_ip_address` varchar(50) DEFAULT NULL,
  `created_by` varchar(50) NOT NULL,
  `created_at` datetime NOT NULL,
  `ip_address` varchar(50) NOT NULL,
  `updated_by` varchar(50) DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `updated_ip_address` varchar(50) DEFAULT NULL,
  `action` varchar(10) DEFAULT NULL,
  `action_dtstamp` datetime DEFAULT current_timestamp(),
  `log_type` char(2) DEFAULT 'DB',
  `changed_by` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`pk_id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Data exporting was unselected.

-- Dumping structure for table ayush_incentive_schema.log_pts_details
CREATE TABLE IF NOT EXISTS `log_pts_details` (
  `log_id` int(11) NOT NULL AUTO_INCREMENT,
  `pts_id` int(11) DEFAULT NULL,
  `emp_code` varchar(50) DEFAULT NULL,
  `hc_id` varchar(50) NOT NULL,
  `designation_code` int(11) DEFAULT NULL,
  `emp_name_en` varchar(50) NOT NULL,
  `emp_name_hi` varchar(50) NOT NULL,
  `father_husband` varchar(50) NOT NULL COMMENT '1 = पिता, 2  = पति',
  `f_hname` varchar(50) NOT NULL,
  `mobile_number` bigint(20) NOT NULL,
  `dob` date DEFAULT NULL,
  `age` tinyint(4) DEFAULT NULL,
  `gender` enum('Male','Female','Transgender') DEFAULT NULL,
  `qualification` varchar(50) DEFAULT NULL,
  `account_no` varchar(50) DEFAULT NULL,
  `state_code` int(11) DEFAULT NULL,
  `bank_district_code` int(11) DEFAULT NULL,
  `branch_code` int(11) DEFAULT NULL,
  `bank_code` int(11) DEFAULT NULL,
  `bank_ifsc_code` varchar(50) DEFAULT NULL,
  `address` text DEFAULT NULL,
  `district_code` int(11) DEFAULT NULL,
  `block_code` varchar(50) DEFAULT NULL,
  `entrydatetime` datetime DEFAULT NULL,
  `entryby` varchar(50) DEFAULT NULL,
  `ip_address` varchar(50) DEFAULT NULL,
  `is_active` tinyint(4) NOT NULL DEFAULT 1,
  `update_by` varchar(50) DEFAULT NULL,
  `update_ip_address` varchar(50) DEFAULT NULL,
  `update_dt` datetime DEFAULT NULL,
  PRIMARY KEY (`log_id`) USING BTREE,
  KEY `hc_id` (`hc_id`) USING BTREE,
  KEY `FK_pts_details_mas_team_incentive_amt` (`designation_code`) USING BTREE,
  CONSTRAINT `log_pts_details_ibfk_1` FOREIGN KEY (`designation_code`) REFERENCES `mas_team_incentive_amt` (`designation_code`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Data exporting was unselected.

-- Dumping structure for table ayush_incentive_schema.log_target_entry_details
CREATE TABLE IF NOT EXISTS `log_target_entry_details` (
  `log_target_id` int(11) NOT NULL AUTO_INCREMENT,
  `target_entry_id` int(11) NOT NULL,
  `year` int(11) NOT NULL,
  `month` int(11) NOT NULL,
  `hc_id` varchar(50) NOT NULL,
  `village_count` int(11) DEFAULT NULL,
  `family_count` int(11) DEFAULT NULL,
  `person_count` int(11) DEFAULT NULL,
  `age_gt_thirtee_person_count` int(11) DEFAULT NULL,
  `high_bp_pt_count` int(11) DEFAULT NULL,
  `diabetes_pt_count` int(11) DEFAULT NULL,
  `entrydatetime` datetime DEFAULT NULL,
  `entryby` varchar(50) DEFAULT NULL,
  `ip_address` varchar(50) DEFAULT NULL,
  `is_target_reset` enum('Y','N') CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'N',
  `target_reset_dt` datetime DEFAULT NULL,
  `target_reset_ip_address` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `target_reset_reason` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `is_dawapatrak_reset` enum('Y','N') NOT NULL DEFAULT 'N',
  `dawapatrak_reset_dt` datetime DEFAULT NULL,
  `dawapatrak_reset_ip_address` varchar(50) DEFAULT NULL,
  `dawapatrak_reset_reason` varchar(200) DEFAULT NULL,
  PRIMARY KEY (`log_target_id`),
  KEY `entrymonth` (`month`) USING BTREE,
  KEY `entryyear` (`year`) USING BTREE,
  KEY `hc_id` (`hc_id`) USING BTREE,
  KEY `target_entry_id` (`target_entry_id`)
) ENGINE=InnoDB AUTO_INCREMENT=4571 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Data exporting was unselected.

-- Dumping structure for table ayush_incentive_schema.mas_activity
CREATE TABLE IF NOT EXISTS `mas_activity` (
  `activity_code` int(11) NOT NULL AUTO_INCREMENT,
  `mulyank_indicator` text NOT NULL,
  `prativedan_source` text NOT NULL,
  `monthly_target` varchar(50) NOT NULL,
  `target_indicator_name` varchar(50) DEFAULT NULL,
  `target_calc_type` enum('value','percent') DEFAULT NULL,
  `calc_value` int(11) DEFAULT NULL,
  `calc_percent` int(11) DEFAULT NULL,
  `amount_calculation_type` enum('Monthly','Yearly','HalfYearly') NOT NULL,
  `fifty_percent_perf` varchar(100) NOT NULL,
  `seventyfive_percent_perf` varchar(100) NOT NULL,
  `hundred_percent_perf` varchar(100) NOT NULL,
  `is_active` tinyint(4) unsigned NOT NULL DEFAULT 1,
  `orderby` tinyint(4) NOT NULL,
  `effective_date_from` date NOT NULL,
  `effective_date_to` date DEFAULT NULL,
  PRIMARY KEY (`activity_code`),
  KEY `is_active` (`is_active`)
) ENGINE=InnoDB AUTO_INCREMENT=111 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Data exporting was unselected.

-- Dumping structure for table ayush_incentive_schema.mas_bank
CREATE TABLE IF NOT EXISTS `mas_bank` (
  `bank_code` int(11) NOT NULL,
  `bank_name` varchar(99) NOT NULL,
  `updated_at` datetime NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`bank_code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;

-- Data exporting was unselected.

-- Dumping structure for table ayush_incentive_schema.mas_bankbranch
CREATE TABLE IF NOT EXISTS `mas_bankbranch` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `bank_code` int(11) NOT NULL,
  `bank_name` varchar(100) NOT NULL,
  `branch_code` int(11) NOT NULL,
  `branch_name` varchar(100) NOT NULL,
  `ifsc_code` char(11) NOT NULL,
  `state_code` int(11) NOT NULL,
  `district_code` int(11) DEFAULT NULL,
  `district_name` varchar(100) DEFAULT NULL,
  `updated_at` datetime NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`id`),
  UNIQUE KEY `branch_code` (`branch_code`) USING BTREE,
  KEY `FK_mas_bankbranch_mas_bank_state` (`state_code`),
  KEY `bank_code` (`bank_code`),
  CONSTRAINT `FK_mas_bankbranch_mas_bank_state` FOREIGN KEY (`state_code`) REFERENCES `mas_bank_state` (`state_code`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=156103 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;

-- Data exporting was unselected.

-- Dumping structure for table ayush_incentive_schema.mas_bank_state
CREATE TABLE IF NOT EXISTS `mas_bank_state` (
  `state_code` int(11) NOT NULL,
  `state_name` varchar(50) NOT NULL,
  `update_dt` datetime NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`state_code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;

-- Data exporting was unselected.

-- Dumping structure for table ayush_incentive_schema.mas_decline
CREATE TABLE IF NOT EXISTS `mas_decline` (
  `decline_id` int(11) NOT NULL AUTO_INCREMENT,
  `decline_reason` varchar(50) NOT NULL,
  `is_active` tinyint(4) NOT NULL DEFAULT 1,
  PRIMARY KEY (`decline_id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Data exporting was unselected.

-- Dumping structure for table ayush_incentive_schema.mas_grade
CREATE TABLE IF NOT EXISTS `mas_grade` (
  `grade_id` int(11) NOT NULL AUTO_INCREMENT,
  `grade_desc` varchar(100) NOT NULL,
  PRIMARY KEY (`grade_id`)
) ENGINE=InnoDB AUTO_INCREMENT=102 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Data exporting was unselected.

-- Dumping structure for table ayush_incentive_schema.mas_login
CREATE TABLE IF NOT EXISTS `mas_login` (
  `HC_ID` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `user_login_id` int(11) NOT NULL DEFAULT 0,
  `hcname_en` varchar(100) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `hcname_hi` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL,
  `district_code` int(11) DEFAULT NULL,
  `district_id` int(11) DEFAULT NULL,
  `block_code` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL,
  `role` tinyint(4) NOT NULL,
  `password` varchar(100) NOT NULL DEFAULT '$2b$12$InEr2xNzRvKqqAZsc0oDau33bhqGpwBgjMNh7Y9ujKviiWubr6vNe' COMMENT '$2b$12$HBwr9bSIvyumwcrSWeRCPuHS9DKJwgFOfYAT1B/gZuJHH0HMhJGFu',
  `ischangepwd` char(2) NOT NULL DEFAULT 'N',
  `pass_update_by` varchar(50) DEFAULT NULL,
  `pass_update_ip_address` varchar(100) DEFAULT NULL,
  `pass_update_dt` datetime DEFAULT NULL,
  `is_active` char(2) NOT NULL DEFAULT 'Y',
  `is_working_hwc` enum('Y','N') NOT NULL DEFAULT 'N',
  PRIMARY KEY (`HC_ID`) USING BTREE,
  UNIQUE KEY `user_login_id` (`user_login_id`),
  KEY `district_code` (`district_code`),
  KEY `block_code` (`block_code`),
  KEY `FK_ayush_health_center_mas_role` (`role`),
  KEY `district_id` (`district_id`),
  KEY `is_active` (`is_active`),
  CONSTRAINT `FK_ayush_health_center_mas_role` FOREIGN KEY (`role`) REFERENCES `mas_role` (`role_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Data exporting was unselected.

-- Dumping structure for table ayush_incentive_schema.mas_menu
CREATE TABLE IF NOT EXISTS `mas_menu` (
  `menu_code` int(11) NOT NULL AUTO_INCREMENT,
  `role` tinyint(4) NOT NULL,
  `module_type` varchar(30) NOT NULL,
  `title` enum('Dashboard','Forms','Reports','Payment','Programs','KPI Report') NOT NULL,
  `is_title` tinyint(4) NOT NULL DEFAULT 0,
  `display_name` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `route` varchar(100) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `icon` varchar(20) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `is_active` enum('Y','N') CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL DEFAULT 'Y',
  `menu_order` int(11) NOT NULL,
  `title_order` int(11) NOT NULL,
  `create_date` datetime NOT NULL DEFAULT current_timestamp(),
  `end_date` datetime DEFAULT NULL,
  `can_access_working_hwc` enum('Y','N') CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT 'N',
  PRIMARY KEY (`menu_code`) USING BTREE,
  KEY `role` (`role`) USING BTREE,
  CONSTRAINT `FK_mas_menu_new_mas_role` FOREIGN KEY (`role`) REFERENCES `mas_role` (`role_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=98 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Data exporting was unselected.

-- Dumping structure for table ayush_incentive_schema.mas_month
CREATE TABLE IF NOT EXISTS `mas_month` (
  `month_no` int(11) NOT NULL,
  `month_name` varchar(50) NOT NULL,
  `month_name_en` varchar(50) NOT NULL,
  `month_order` int(11) NOT NULL,
  PRIMARY KEY (`month_no`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;

-- Data exporting was unselected.

-- Dumping structure for table ayush_incentive_schema.mas_role
CREATE TABLE IF NOT EXISTS `mas_role` (
  `role_id` tinyint(5) NOT NULL,
  `role_name_hi` char(50) NOT NULL,
  `role_name_en` char(50) NOT NULL,
  `created_at` datetime NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`role_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Data exporting was unselected.

-- Dumping structure for table ayush_incentive_schema.mas_team_incentive_amt
CREATE TABLE IF NOT EXISTS `mas_team_incentive_amt` (
  `designation_code` int(11) NOT NULL AUTO_INCREMENT,
  `designation_name` varchar(100) NOT NULL,
  `per_ind_per_month_rate` int(11) NOT NULL,
  `indicator_count` int(11) NOT NULL,
  `max_amt_per_month` int(11) NOT NULL,
  `max_amt_per_year` int(11) NOT NULL,
  `less_fifty_percent_per_ind` int(11) NOT NULL,
  `fifty_percent_per_ind` int(11) NOT NULL,
  `seventyfive_percent_per_ind` int(11) NOT NULL,
  `hundred_percent_per_ind` int(11) NOT NULL,
  `is_active` tinyint(3) NOT NULL DEFAULT 1,
  PRIMARY KEY (`designation_code`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='incentive amount for team\r\n';

-- Data exporting was unselected.

-- Dumping structure for table ayush_incentive_schema.mas_year
CREATE TABLE IF NOT EXISTS `mas_year` (
  `id` int(11) NOT NULL,
  `year` varchar(50) NOT NULL,
  `is_current_year` char(1) NOT NULL DEFAULT 'Y',
  `year_order` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;

-- Data exporting was unselected.

-- Dumping structure for table ayush_incentive_schema.payment_response_details
CREATE TABLE IF NOT EXISTS `payment_response_details` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `payment_id` bigint(20) NOT NULL,
  `hc_id` int(11) NOT NULL,
  `pfms_id` varchar(50) NOT NULL,
  `year` int(11) NOT NULL,
  `month` int(11) NOT NULL,
  `designation_code` int(11) NOT NULL,
  `emp_code` varchar(100) NOT NULL,
  `emp_name` varchar(100) NOT NULL,
  `bank_ifsc_code` varchar(100) NOT NULL,
  `account_no` varchar(100) NOT NULL,
  `amount` int(11) NOT NULL,
  `six_month_amount` int(11) NOT NULL,
  `total_amount` int(11) NOT NULL,
  `send_by` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `send_dt` datetime NOT NULL,
  `send_ip_address` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `payment_id` (`payment_id`),
  KEY `hc_id` (`hc_id`),
  KEY `year` (`year`),
  KEY `month` (`month`),
  KEY `pfms_id` (`pfms_id`)
) ENGINE=InnoDB AUTO_INCREMENT=996 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;

-- Data exporting was unselected.

-- Dumping structure for table ayush_incentive_schema.program_ayurvidya_entry
CREATE TABLE IF NOT EXISTS `program_ayurvidya_entry` (
  `ayurvidya_entry_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `year_id` int(10) unsigned NOT NULL,
  `month_id` int(10) unsigned NOT NULL,
  `emp_code` varchar(50) NOT NULL,
  `district_code` varchar(50) NOT NULL,
  `district_id` varchar(50) NOT NULL,
  `block_id` varchar(50) NOT NULL,
  `hc_id` varchar(50) NOT NULL,
  `entry_status` enum('D','L','F') NOT NULL DEFAULT 'D',
  `number_of_schools` int(10) unsigned NOT NULL,
  `visits_per_month` int(10) unsigned NOT NULL,
  `visit_level_1` int(10) unsigned NOT NULL,
  `visit_level_2` int(10) unsigned NOT NULL,
  `visit_level_3` int(10) unsigned NOT NULL,
  `visit_level_4` int(10) unsigned NOT NULL,
  `awareness_lectures_given` int(10) unsigned NOT NULL,
  `awareness_lecture_beneficiaries` int(10) unsigned NOT NULL,
  `medicinal_plants_planted` int(10) unsigned NOT NULL,
  `yoga_camps_in_school` int(10) unsigned NOT NULL,
  `yoga_beneficiaries` int(10) unsigned NOT NULL,
  `prakriti_parikshan_count` int(10) unsigned NOT NULL,
  `prakriti_awareness_lectures` int(10) unsigned NOT NULL,
  `diseased_children_found` int(10) unsigned NOT NULL,
  `diseased_children_attended_hospital` int(10) unsigned NOT NULL,
  `num_diseased_children_reffered` int(10) unsigned NOT NULL,
  `stressed_students_11th_12th` int(10) unsigned NOT NULL,
  `garden_hospital_visit_count` int(10) unsigned NOT NULL,
  `students_visited_dispensary_garden_hospital` int(10) unsigned NOT NULL,
  `program_forwarded_district_by` varchar(50) DEFAULT NULL,
  `program_forwarded_district_at` datetime DEFAULT NULL,
  `program_forwarded_district_ip_address` varchar(50) DEFAULT NULL,
  `program_unlocked_state_reason` varchar(256) DEFAULT NULL,
  `program_unlocked_state_by` varchar(50) DEFAULT NULL,
  `program_unlocked_state_at` datetime DEFAULT NULL,
  `program_unlocked_state_ip_address` varchar(50) DEFAULT NULL,
  `created_by` varchar(50) NOT NULL,
  `created_at` datetime NOT NULL DEFAULT current_timestamp(),
  `ip_address` varchar(50) NOT NULL,
  `updated_by` varchar(50) DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL ON UPDATE current_timestamp(),
  `updated_ip_address` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`ayurvidya_entry_id`) USING BTREE,
  UNIQUE KEY `year_id_month_id_emp_code` (`year_id`,`month_id`,`emp_code`),
  KEY `FK_program_ayurvidya_entry_program_mas_month` (`month_id`),
  KEY `FK_program_ayurvidya_entry_program_doctor_details` (`emp_code`),
  KEY `entry_status` (`entry_status`),
  KEY `block_id` (`block_id`),
  KEY `hc_id` (`hc_id`),
  KEY `district_code` (`district_code`),
  KEY `district_id` (`district_id`),
  CONSTRAINT `FK_program_ayurvidya_entry_program_doctor_details` FOREIGN KEY (`emp_code`) REFERENCES `program_doctor_details` (`emp_code`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `FK_program_ayurvidya_entry_program_mas_month` FOREIGN KEY (`month_id`) REFERENCES `program_mas_month` (`month_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `FK_program_ayurvidya_entry_program_mas_year` FOREIGN KEY (`year_id`) REFERENCES `program_mas_year` (`year_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=40 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Data exporting was unselected.

-- Dumping structure for table ayush_incentive_schema.program_checklist_mapping
CREATE TABLE IF NOT EXISTS `program_checklist_mapping` (
  `mapping_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `program_id` int(10) unsigned NOT NULL DEFAULT 1,
  `checklist_id` int(10) unsigned NOT NULL,
  `is_active` tinyint(1) unsigned NOT NULL DEFAULT 1,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NULL DEFAULT NULL ON UPDATE current_timestamp(),
  `created_by` varchar(50) NOT NULL,
  `updated_by` varchar(50) DEFAULT NULL,
  `ip_address` varchar(50) NOT NULL,
  PRIMARY KEY (`mapping_id`),
  UNIQUE KEY `program_id_checklist_id` (`program_id`,`checklist_id`),
  KEY `FK_program_checklist_mapping_program_mas_checklist` (`checklist_id`),
  CONSTRAINT `FK_program_checklist_mapping_program_mas_checklist` FOREIGN KEY (`checklist_id`) REFERENCES `program_mas_checklist` (`checklist_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=35 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Data exporting was unselected.

-- Dumping structure for table ayush_incentive_schema.program_doctor_assignment
CREATE TABLE IF NOT EXISTS `program_doctor_assignment` (
  `assignment_id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `details_id` int(10) unsigned NOT NULL DEFAULT 0,
  `program_id` int(10) unsigned NOT NULL,
  `is_active` tinyint(1) unsigned NOT NULL DEFAULT 1 COMMENT '0: Inactive; 1: Active',
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `created_by` varchar(50) NOT NULL,
  `ip_address` varchar(50) NOT NULL,
  `updated_at` timestamp NULL DEFAULT NULL ON UPDATE current_timestamp(),
  `updated_by` varchar(50) DEFAULT NULL,
  `updated_ip_address` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`assignment_id`) USING BTREE,
  UNIQUE KEY `unique_details_id_program_id` (`details_id`,`program_id`),
  KEY `FK_programs_details` (`program_id`),
  CONSTRAINT `FK_doctors_details` FOREIGN KEY (`details_id`) REFERENCES `program_doctor_details` (`details_id`) ON DELETE CASCADE ON UPDATE NO ACTION,
  CONSTRAINT `FK_programs_details` FOREIGN KEY (`program_id`) REFERENCES `program_master` (`program_id`) ON DELETE CASCADE ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=449 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Data exporting was unselected.

-- Dumping structure for table ayush_incentive_schema.program_doctor_details
CREATE TABLE IF NOT EXISTS `program_doctor_details` (
  `details_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `mapped_district_code` varchar(50) NOT NULL,
  `emp_code` varchar(50) NOT NULL,
  `hc_id` varchar(10) NOT NULL,
  `emp_name` varchar(255) NOT NULL,
  `designation` varchar(255) NOT NULL,
  `mobile_no` varchar(10) NOT NULL,
  `post_code` varchar(10) DEFAULT NULL,
  `district_id` int(11) NOT NULL,
  `block_id` varchar(10) NOT NULL,
  `is_active` tinyint(1) unsigned NOT NULL DEFAULT 1 COMMENT '0: Inactive; 1: Active',
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `created_by` varchar(50) NOT NULL,
  `ip_address` varchar(50) NOT NULL,
  `updated_at` timestamp NULL DEFAULT NULL ON UPDATE current_timestamp(),
  `updated_by` varchar(50) DEFAULT NULL,
  `updated_ip_address` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`details_id`) USING BTREE,
  UNIQUE KEY `mapped_district_code_emp_code` (`mapped_district_code`,`emp_code`),
  KEY `hc_id` (`hc_id`),
  KEY `doctor_emp_code` (`emp_code`) USING BTREE,
  KEY `mapped_by` (`mapped_district_code`) USING BTREE,
  CONSTRAINT `FK_program_doctor_details_program_nam_employee_details` FOREIGN KEY (`emp_code`) REFERENCES `program_nam_employee_details` (`emp_code`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=78 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Data exporting was unselected.

-- Dumping structure for table ayush_incentive_schema.program_entry_schedules
CREATE TABLE IF NOT EXISTS `program_entry_schedules` (
  `schedule_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `program_id` int(10) unsigned NOT NULL,
  `start_date` int(10) unsigned NOT NULL,
  `end_date` int(10) unsigned NOT NULL,
  `start_time` time NOT NULL,
  `end_time` time NOT NULL,
  `start_date_original` int(10) unsigned NOT NULL DEFAULT 0,
  `end_date_original` int(10) unsigned NOT NULL DEFAULT 0,
  `start_time_original` time NOT NULL,
  `end_time_original` time NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NULL DEFAULT NULL ON UPDATE current_timestamp(),
  `created_by` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `updated_by` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `ip_address` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`schedule_id`) USING BTREE,
  UNIQUE KEY `unique_program_id` (`program_id`) USING BTREE,
  KEY `key_program_id` (`program_id`),
  CONSTRAINT `FK_program_id` FOREIGN KEY (`program_id`) REFERENCES `program_master` (`program_id`) ON DELETE CASCADE ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;

-- Data exporting was unselected.

-- Dumping structure for table ayush_incentive_schema.program_karunya_palliative_entry
CREATE TABLE IF NOT EXISTS `program_karunya_palliative_entry` (
  `karunya_palliative_entry_id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `year_id` int(10) unsigned NOT NULL,
  `month_id` int(10) unsigned NOT NULL,
  `emp_code` varchar(50) NOT NULL,
  `district_code` varchar(50) NOT NULL,
  `district_id` varchar(50) NOT NULL,
  `block_id` varchar(50) NOT NULL,
  `hc_id` varchar(50) NOT NULL,
  `entry_status` enum('D','L','F') DEFAULT 'D',
  `home_visit_place_village` int(10) unsigned NOT NULL,
  `home_visit_place_city_ward` int(10) unsigned NOT NULL,
  `num_home_bond_patient` int(10) unsigned NOT NULL,
  `diagnosis_cancer_home_bond` int(10) unsigned NOT NULL,
  `diagnosis_cancer_opd` int(10) unsigned NOT NULL,
  `diagnosis_stroke_or_spinal_cord_home_bond` int(10) unsigned NOT NULL,
  `diagnosis_stroke_or_spinal_cord_opd` int(10) unsigned NOT NULL,
  `diagnosis_chronic_neurological_diseases_home_bond` int(10) unsigned NOT NULL,
  `diagnosis_chronic_neurological_diseases_opd` int(10) unsigned NOT NULL,
  `diagnosis_old_age_conditions_home_bond` int(10) unsigned NOT NULL,
  `diagnosis_old_age_conditions_opd` int(10) unsigned NOT NULL,
  `diagnosis_children_with_cerebral_palsy_home_bond` int(10) unsigned NOT NULL,
  `diagnosis_children_with_cerebral_palsy_opd` int(10) unsigned NOT NULL,
  `diagnosis_psycho_social_supports_organ_failures_home_bond` int(10) unsigned NOT NULL,
  `diagnosis_psycho_social_supports_organ_failures_opd` int(10) unsigned NOT NULL,
  `diagnosis_auto_immune_diseases_home_bond` int(10) unsigned NOT NULL,
  `diagnosis_auto_immune_diseases_opd` int(10) unsigned NOT NULL,
  `diagnosis_other_diseases_home_bond` int(10) unsigned NOT NULL,
  `diagnosis_other_diseases_opd` int(10) unsigned NOT NULL,
  `care_plan_serv_home_bond_pt_medicine` int(10) unsigned NOT NULL,
  `care_plan_serv_home_bond_pt_councelling` int(10) unsigned NOT NULL,
  `care_plan_serv_home_bond_pt_therapy` int(10) unsigned NOT NULL,
  `status_home_bond_pt_active` int(10) unsigned NOT NULL,
  `status_home_bond_pt_referred` int(10) unsigned NOT NULL,
  `status_home_bond_pt_expired` int(10) unsigned NOT NULL,
  `num_opd_pt_registered_village` int(10) unsigned NOT NULL,
  `num_opd_pt_registered_city_ward` int(10) unsigned NOT NULL,
  `care_plan_serv_opd_pt_therapy` int(10) unsigned NOT NULL,
  `care_plan_serv_opd_pt_councelling` int(10) unsigned NOT NULL,
  `care_plan_serv_opd_pt_medicine` int(10) unsigned NOT NULL,
  `status_opd_pt_referred` int(10) unsigned NOT NULL,
  `status_opd_pt_active` int(10) unsigned NOT NULL,
  `status_opd_pt_expired` int(10) unsigned NOT NULL,
  `num_patient_improvement_quality_life` int(10) unsigned NOT NULL,
  `family_advice` int(10) unsigned NOT NULL,
  `program_forwarded_district_by` varchar(50) DEFAULT NULL,
  `program_forwarded_district_at` datetime DEFAULT NULL,
  `program_forwarded_district_ip_address` varchar(50) DEFAULT NULL,
  `program_unlocked_state_reason` varchar(256) DEFAULT NULL,
  `program_unlocked_state_by` varchar(50) DEFAULT NULL,
  `program_unlocked_state_at` datetime DEFAULT NULL,
  `program_unlocked_state_ip_address` varchar(50) DEFAULT NULL,
  `created_by` varchar(50) NOT NULL,
  `created_at` datetime NOT NULL DEFAULT current_timestamp(),
  `ip_address` varchar(50) NOT NULL,
  `updated_by` varchar(50) DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL ON UPDATE current_timestamp(),
  `updated_ip_address` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`karunya_palliative_entry_id`) USING BTREE,
  UNIQUE KEY `year_id_month_id_emp_code` (`year_id`,`month_id`,`emp_code`),
  KEY `FK_program_karunya_palliative_entry_program_mas_month` (`month_id`),
  KEY `FK_program_karunya_palliative_entry_program_doctor_details` (`emp_code`),
  KEY `entry_status` (`entry_status`),
  KEY `block_id` (`block_id`),
  KEY `hc_id` (`hc_id`),
  KEY `district_code` (`district_code`),
  KEY `district_id` (`district_id`),
  CONSTRAINT `FK_program_karunya_palliative_entry_program_doctor_details` FOREIGN KEY (`emp_code`) REFERENCES `program_doctor_details` (`emp_code`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `FK_program_karunya_palliative_entry_program_mas_month` FOREIGN KEY (`month_id`) REFERENCES `program_mas_month` (`month_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `FK_program_karunya_palliative_entry_program_mas_year` FOREIGN KEY (`year_id`) REFERENCES `program_mas_year` (`year_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=23 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Data exporting was unselected.

-- Dumping structure for table ayush_incentive_schema.program_master
CREATE TABLE IF NOT EXISTS `program_master` (
  `program_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `program_name_en` varchar(255) NOT NULL,
  `program_name_hi` varchar(255) NOT NULL,
  `route_name` varchar(50) NOT NULL,
  `entry_table_name` varchar(50) NOT NULL,
  `program_emp_count` int(10) unsigned NOT NULL,
  `schedule_type_id` int(10) unsigned NOT NULL COMMENT '1: Daily; 2: Monthly',
  `is_active` tinyint(1) unsigned NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NULL DEFAULT NULL ON UPDATE current_timestamp(),
  `created_by` varchar(50) NOT NULL,
  `updated_by` varchar(50) DEFAULT NULL,
  `ip_address` varchar(50) NOT NULL,
  PRIMARY KEY (`program_id`),
  UNIQUE KEY `program_name_en` (`program_name_en`),
  KEY `program_id` (`program_id`),
  KEY `FK_program_master_program_mas_entry_schedule` (`schedule_type_id`),
  CONSTRAINT `FK_program_master_program_mas_entry_schedule` FOREIGN KEY (`schedule_type_id`) REFERENCES `program_mas_entry_schedule` (`schedule_type_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Data exporting was unselected.

-- Dumping structure for table ayush_incentive_schema.program_mas_checklist
CREATE TABLE IF NOT EXISTS `program_mas_checklist` (
  `checklist_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `checklist_name_en` varchar(255) NOT NULL,
  `checklist_name_hi` varchar(255) NOT NULL,
  `is_active` tinyint(1) unsigned NOT NULL DEFAULT 1,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NULL DEFAULT NULL ON UPDATE current_timestamp(),
  `created_by` varchar(50) NOT NULL,
  `updated_by` varchar(50) DEFAULT NULL,
  `ip_address` varchar(50) NOT NULL,
  PRIMARY KEY (`checklist_id`)
) ENGINE=InnoDB AUTO_INCREMENT=41 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Data exporting was unselected.

-- Dumping structure for table ayush_incentive_schema.program_mas_designation
CREATE TABLE IF NOT EXISTS `program_mas_designation` (
  `designation_code` int(11) unsigned NOT NULL,
  `designation_name_hi` varchar(50) NOT NULL,
  `designation_name_en` varchar(50) NOT NULL,
  `is_active` tinyint(3) unsigned NOT NULL DEFAULT 0,
  PRIMARY KEY (`designation_code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Data exporting was unselected.

-- Dumping structure for table ayush_incentive_schema.program_mas_entry_schedule
CREATE TABLE IF NOT EXISTS `program_mas_entry_schedule` (
  `schedule_type_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `schedule_type_name` varchar(20) NOT NULL,
  PRIMARY KEY (`schedule_type_id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Data exporting was unselected.

-- Dumping structure for table ayush_incentive_schema.program_mas_kpi_indicator
CREATE TABLE IF NOT EXISTS `program_mas_kpi_indicator` (
  `kpi_id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `program_id` int(11) unsigned NOT NULL,
  `kpi_name` varchar(255) NOT NULL,
  `kpi_description` text NOT NULL,
  `entry_table_name` varchar(120) NOT NULL,
  `entry_column_name` varchar(255) NOT NULL,
  `calculation_type` enum('SUM','COUNT','AVG','FORMULA','CUSTOM') NOT NULL,
  `formula_expression` text DEFAULT NULL,
  `display_order` int(10) unsigned NOT NULL,
  `is_active` tinyint(1) unsigned NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `created_by` varchar(50) NOT NULL,
  `ip_address` varchar(50) NOT NULL,
  `updated_at` timestamp NULL DEFAULT NULL ON UPDATE current_timestamp(),
  `updated_by` varchar(50) DEFAULT NULL,
  `updated_ip_address` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`kpi_id`),
  UNIQUE KEY `entry_table_name_entry_column_name` (`entry_table_name`,`entry_column_name`),
  KEY `fk_program_kpi` (`program_id`),
  CONSTRAINT `fk_program_kpi` FOREIGN KEY (`program_id`) REFERENCES `program_master` (`program_id`)
) ENGINE=InnoDB AUTO_INCREMENT=40 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Data exporting was unselected.

-- Dumping structure for table ayush_incentive_schema.program_mas_month
CREATE TABLE IF NOT EXISTS `program_mas_month` (
  `month_id` int(11) unsigned NOT NULL,
  `month_name_en` varchar(20) NOT NULL,
  `month_name_hi` varchar(20) NOT NULL,
  `month_order` tinyint(4) unsigned NOT NULL,
  PRIMARY KEY (`month_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;

-- Data exporting was unselected.

-- Dumping structure for table ayush_incentive_schema.program_mas_qualification
CREATE TABLE IF NOT EXISTS `program_mas_qualification` (
  `qualification_code` smallint(6) NOT NULL AUTO_INCREMENT,
  `qualification_name_hi` varchar(50) NOT NULL,
  `qualification_name_en` varchar(50) NOT NULL,
  `is_active` tinyint(3) unsigned NOT NULL DEFAULT 0,
  PRIMARY KEY (`qualification_code`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=101 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;

-- Data exporting was unselected.

-- Dumping structure for table ayush_incentive_schema.program_mas_week
CREATE TABLE IF NOT EXISTS `program_mas_week` (
  `week_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `week_name_en` varchar(20) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `week_name_hi` varchar(20) NOT NULL,
  `week_order` tinyint(4) unsigned NOT NULL,
  PRIMARY KEY (`week_id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Data exporting was unselected.

-- Dumping structure for table ayush_incentive_schema.program_mas_year
CREATE TABLE IF NOT EXISTS `program_mas_year` (
  `year_id` int(11) unsigned NOT NULL,
  `year_name` varchar(20) NOT NULL,
  `is_current_year` char(1) NOT NULL DEFAULT 'Y',
  `year_order` tinyint(4) unsigned NOT NULL,
  PRIMARY KEY (`year_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;

-- Data exporting was unselected.

-- Dumping structure for table ayush_incentive_schema.program_mmu_entry
CREATE TABLE IF NOT EXISTS `program_mmu_entry` (
  `mmu_entry_id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `year_id` int(10) unsigned NOT NULL,
  `month_id` int(10) unsigned NOT NULL,
  `week_id` int(10) unsigned NOT NULL,
  `emp_code` varchar(50) NOT NULL,
  `district_code` varchar(50) NOT NULL,
  `district_id` varchar(50) NOT NULL,
  `block_id` varchar(50) NOT NULL,
  `hc_id` varchar(50) NOT NULL,
  `entry_status` enum('D','L','F') NOT NULL DEFAULT 'D',
  `village_code` varchar(50) NOT NULL,
  `visit_block_id` varchar(50) NOT NULL,
  `visit_date` date NOT NULL,
  `visit_day` varchar(20) NOT NULL,
  `num_camp_conduct` int(10) unsigned NOT NULL,
  `total_num_beneficiaries` int(10) unsigned NOT NULL,
  `num_male` int(10) unsigned NOT NULL,
  `num_female` int(10) unsigned NOT NULL,
  `abujhmad_pvtg` int(10) unsigned NOT NULL COMMENT 'PVTG',
  `baiga_pvtg` int(10) unsigned NOT NULL COMMENT 'PVTG',
  `birhor_pvtg` int(10) unsigned NOT NULL COMMENT 'PVTG',
  `pahadi_korva_pvtg` int(10) unsigned NOT NULL COMMENT 'PVTG',
  `kamar_pvtg` int(10) unsigned NOT NULL COMMENT 'PVTG',
  `other_pvtg` int(10) unsigned NOT NULL COMMENT 'PVTG',
  `disease_total_num_resprespetory_tract_infections` int(10) unsigned NOT NULL,
  `disease_total_num_skin_diseases` int(10) unsigned NOT NULL,
  `disease_total_num_disorder_joint` int(10) unsigned NOT NULL,
  `disease_total_num_obs_gyn_disease` int(10) unsigned NOT NULL,
  `disease_total_num_git_disorder` int(10) unsigned NOT NULL,
  `disease_total_num_heart_disease` int(10) unsigned NOT NULL,
  `disease_total_num_diabetes` int(10) unsigned NOT NULL,
  `disease_total_num_htn` int(10) unsigned NOT NULL,
  `disease_total_num_mental_disorder` int(10) unsigned NOT NULL,
  `disease_total_num_fever` int(10) unsigned NOT NULL,
  `disease_total_num_ent` int(10) unsigned NOT NULL,
  `disease_total_num_eye_disorder` int(10) unsigned NOT NULL,
  `disease_total_num_dental` int(10) unsigned NOT NULL,
  `disease_total_num_tb` int(10) unsigned NOT NULL,
  `disease_total_num_leprosy` int(10) unsigned NOT NULL,
  `disease_total_num_filaria` int(10) unsigned NOT NULL,
  `disease_total_num_other_disease` int(10) unsigned NOT NULL,
  `total_num_investigation` int(10) unsigned NOT NULL,
  `total_num_beneficiaries_whose_health_status_improved` int(10) unsigned NOT NULL,
  `total_num_patient_referred` int(10) unsigned NOT NULL,
  `is_capture_location` tinyint(2) unsigned DEFAULT NULL,
  `latitude` decimal(11,8) unsigned DEFAULT NULL,
  `longitude` decimal(11,8) unsigned DEFAULT NULL,
  `capture_at` datetime DEFAULT NULL,
  `program_forwarded_district_by` varchar(50) DEFAULT NULL,
  `program_forwarded_district_at` datetime DEFAULT NULL,
  `program_forwarded_district_ip_address` varchar(50) DEFAULT NULL,
  `program_unlocked_state_reason` varchar(256) DEFAULT NULL,
  `program_unlocked_state_by` varchar(50) DEFAULT NULL,
  `program_unlocked_state_at` datetime DEFAULT NULL,
  `program_unlocked_state_ip_address` varchar(50) DEFAULT NULL,
  `created_by` varchar(50) NOT NULL,
  `created_at` datetime NOT NULL DEFAULT current_timestamp(),
  `ip_address` varchar(50) NOT NULL,
  `updated_by` varchar(50) DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL ON UPDATE current_timestamp(),
  `updated_ip_address` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`mmu_entry_id`),
  UNIQUE KEY `year_id_month_id_week_id_emp_code` (`year_id`,`month_id`,`week_id`,`emp_code`),
  KEY `FK_program_mmu_entry_program_mas_month` (`month_id`),
  KEY `FK_program_mmu_entry_program_mas_week` (`week_id`),
  KEY `entry_status` (`entry_status`),
  KEY `block_id` (`block_id`),
  KEY `hc_id` (`hc_id`),
  KEY `district_code` (`district_code`),
  KEY `district_id` (`district_id`),
  KEY `FK_program_mmu_entry_program_doctor_details` (`emp_code`),
  KEY `village_code` (`village_code`),
  CONSTRAINT `FK_program_mmu_entry_program_doctor_details` FOREIGN KEY (`emp_code`) REFERENCES `program_doctor_details` (`emp_code`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `FK_program_mmu_entry_program_mas_month` FOREIGN KEY (`month_id`) REFERENCES `program_mas_month` (`month_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `FK_program_mmu_entry_program_mas_week` FOREIGN KEY (`week_id`) REFERENCES `program_mas_week` (`week_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `FK_program_mmu_entry_program_mas_year` FOREIGN KEY (`year_id`) REFERENCES `program_mas_year` (`year_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Data exporting was unselected.

-- Dumping structure for table ayush_incentive_schema.program_nam_employee_details
CREATE TABLE IF NOT EXISTS `program_nam_employee_details` (
  `emp_code` varchar(50) NOT NULL,
  `designation_code` int(11) unsigned NOT NULL,
  `role` tinyint(4) NOT NULL,
  `district_code` varchar(50) NOT NULL,
  `district_id` varchar(50) NOT NULL,
  `block_id` varchar(50) NOT NULL,
  `hc_id` varchar(50) NOT NULL,
  `emp_name_en` varchar(50) NOT NULL,
  `pan_number` varchar(10) NOT NULL,
  `emp_name_hi` varchar(50) NOT NULL,
  `father_husband` varchar(50) NOT NULL COMMENT '1 = पिता, 2  = पति',
  `f_hname` varchar(50) NOT NULL,
  `mobile_number` bigint(20) NOT NULL,
  `dob` date NOT NULL,
  `doj` date NOT NULL,
  `email` varchar(50) NOT NULL,
  `age` tinyint(4) NOT NULL,
  `gender` enum('Male','Female','Transgender') NOT NULL,
  `address` text NOT NULL,
  `hpr_id` varchar(50) DEFAULT NULL,
  `hfr_id` varchar(50) DEFAULT NULL,
  `order_copy_file_url` varchar(255) NOT NULL,
  `order_copy_file_name` varchar(255) NOT NULL,
  `is_uploaded_order_copy` char(2) NOT NULL DEFAULT 'N',
  `password` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '$2b$12$xnEJxQQKJ4udnWLADDWHg.tz./j6F3YF0Q7tm6fq7Z7nV2G1lxJbS',
  `ischangepwd` char(2) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT 'N',
  `is_verified` char(2) NOT NULL DEFAULT 'N',
  `is_active` tinyint(4) unsigned NOT NULL,
  `created_by` varchar(50) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `ip_address` varchar(50) NOT NULL,
  `updated_by` varchar(50) DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL ON UPDATE current_timestamp(),
  `updated_ip_address` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`emp_code`),
  UNIQUE KEY `mobile_number` (`mobile_number`),
  UNIQUE KEY `email` (`email`),
  UNIQUE KEY `pan_number` (`pan_number`),
  KEY `FK_program_nam_employee_details_program_mas_designation` (`designation_code`),
  KEY `FK_program_nam_employee_details_mas_role` (`role`),
  KEY `district_id` (`district_id`),
  KEY `block_id` (`block_id`),
  KEY `hc_id` (`hc_id`),
  KEY `district_code` (`district_code`),
  CONSTRAINT `FK_program_nam_employee_details_mas_role` FOREIGN KEY (`role`) REFERENCES `mas_role` (`role_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `FK_program_nam_employee_details_program_mas_designation` FOREIGN KEY (`designation_code`) REFERENCES `program_mas_designation` (`designation_code`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Data exporting was unselected.

-- Dumping structure for table ayush_incentive_schema.program_npcdcs_entry
CREATE TABLE IF NOT EXISTS `program_npcdcs_entry` (
  `npcdcs_entry_id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `month_id` int(10) unsigned NOT NULL,
  `year_id` int(10) unsigned NOT NULL,
  `emp_code` varchar(50) NOT NULL,
  `district_code` varchar(50) NOT NULL,
  `district_id` varchar(50) NOT NULL,
  `hc_id` varchar(50) NOT NULL,
  `entry_status` enum('D','L','F') NOT NULL DEFAULT 'D',
  `num_of_yoga_instructor` int(11) unsigned NOT NULL,
  `age_30_40` int(11) unsigned NOT NULL COMMENT 'Age',
  `age_40_50` int(11) unsigned NOT NULL COMMENT 'Age',
  `age_60_above` int(11) unsigned NOT NULL COMMENT 'Age',
  `sex_female` int(11) unsigned NOT NULL COMMENT 'Sex',
  `sex_male` int(11) unsigned NOT NULL COMMENT 'Sex',
  `total_pt_registered_till_date_facility` int(11) unsigned NOT NULL,
  `total_num_new_pt_in_month` int(11) unsigned NOT NULL,
  `total_num_followup_pt_in_month` int(11) unsigned NOT NULL,
  `total_pt_registered_htn_num_pt` int(11) unsigned NOT NULL COMMENT 'Total pt. registered',
  `total_pt_registered_htn_num_pt_improvement` int(11) unsigned NOT NULL COMMENT 'Total pt. registered',
  `total_pt_registered_dm_num_pt` int(11) unsigned NOT NULL COMMENT 'Total pt. registered',
  `total_pt_registered_dm_num_pt_impovement` int(11) unsigned NOT NULL COMMENT 'Total pt. registered',
  `total_pt_registered_cancer_num_pt` int(11) unsigned NOT NULL COMMENT 'Total pt. registered',
  `total_pt_registered_hd_num_pt` int(11) unsigned NOT NULL COMMENT 'Total pt. registered',
  `total_pt_registered_stroke_num_pt` int(11) unsigned NOT NULL COMMENT 'Total pt. registered',
  `total_pt_registered_other_ds_num_pt` int(11) unsigned NOT NULL COMMENT 'Total pt. registered',
  `total_pt_registered_other_ds_num_pt_improvement` int(11) unsigned NOT NULL COMMENT 'Total pt. registered',
  `total_num_of_camp_conducted` int(11) unsigned NOT NULL,
  `num_pt_reg_till_date_camp` int(11) unsigned NOT NULL,
  `total_pt_reg_till_date_facility_plus_camp` int(11) unsigned NOT NULL,
  `total_num_of_beneficiarys_camp` int(11) unsigned NOT NULL,
  `total_num_of_yoga_beneficiaries_camp` int(11) unsigned NOT NULL,
  `total_num_of_yoga_beneficiaries_opd` int(11) unsigned NOT NULL,
  `total_num_of_ayush_intervention_camp` int(11) unsigned NOT NULL,
  `total_num_of_ayush_intervention_facility` int(11) unsigned NOT NULL,
  `total_reduction_allopathic_med` int(11) unsigned NOT NULL,
  `num_of_referred_pt_allopathic` int(11) unsigned NOT NULL,
  `num_of_referred_pt_ayush_higher_center` int(11) unsigned NOT NULL,
  `total_num_of_yoga_instructor_training` int(11) unsigned NOT NULL,
  `num_of_pt_improvement_after_yoga` int(11) unsigned NOT NULL,
  `program_forwarded_district_by` varchar(50) DEFAULT NULL,
  `program_forwarded_district_at` datetime DEFAULT NULL,
  `program_forwarded_district_ip_address` varchar(50) DEFAULT NULL,
  `program_unlocked_state_reason` varchar(256) DEFAULT NULL,
  `program_unlocked_state_by` varchar(50) DEFAULT NULL,
  `program_unlocked_state_at` datetime DEFAULT NULL,
  `program_unlocked_state_ip_address` varchar(50) DEFAULT NULL,
  `created_at` datetime NOT NULL DEFAULT current_timestamp(),
  `created_by` varchar(50) NOT NULL COMMENT 'type_of_disorder',
  `ip_address` varchar(50) NOT NULL,
  `updated_by` varchar(50) DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL ON UPDATE current_timestamp(),
  `updated_ip_address` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`npcdcs_entry_id`),
  UNIQUE KEY `month_id_year_id_emp_code` (`month_id`,`year_id`,`emp_code`),
  KEY `FK_program_npcdcs_entry_program_mas_year` (`year_id`),
  KEY `entry_status` (`entry_status`),
  KEY `hc_id` (`hc_id`),
  KEY `district_code` (`district_code`),
  KEY `district_id` (`district_id`),
  KEY `FK_program_npcdcs_entry_program_doctor_details` (`emp_code`),
  CONSTRAINT `FK_program_npcdcs_entry_program_doctor_details` FOREIGN KEY (`emp_code`) REFERENCES `program_doctor_details` (`emp_code`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `FK_program_npcdcs_entry_program_mas_month` FOREIGN KEY (`month_id`) REFERENCES `program_mas_month` (`month_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `FK_program_npcdcs_entry_program_mas_year` FOREIGN KEY (`year_id`) REFERENCES `program_mas_year` (`year_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Data exporting was unselected.

-- Dumping structure for table ayush_incentive_schema.program_opd_entry
CREATE TABLE IF NOT EXISTS `program_opd_entry` (
  `entry_id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `entry_status_id` bigint(20) unsigned NOT NULL,
  `checklist_id` int(10) unsigned NOT NULL,
  `new_patient_value` int(11) DEFAULT NULL,
  `followup_patient_value` int(11) DEFAULT NULL,
  `created_by` varchar(50) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_by` varchar(50) DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL ON UPDATE current_timestamp(),
  `ip_address` varchar(50) NOT NULL,
  PRIMARY KEY (`entry_id`),
  UNIQUE KEY `entry_status_id_checklist_id` (`entry_status_id`,`checklist_id`),
  KEY `FK_program_checklist_entry_program_mas_checklist` (`checklist_id`),
  CONSTRAINT `FK_program_checklist_entry_program_checklist_entry_status` FOREIGN KEY (`entry_status_id`) REFERENCES `program_opd_entry_status` (`entry_status_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `FK_program_checklist_entry_program_mas_checklist` FOREIGN KEY (`checklist_id`) REFERENCES `program_mas_checklist` (`checklist_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Data exporting was unselected.

-- Dumping structure for table ayush_incentive_schema.program_opd_entry_status
CREATE TABLE IF NOT EXISTS `program_opd_entry_status` (
  `entry_status_id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `program_id` int(10) unsigned NOT NULL,
  `emp_code` varchar(50) NOT NULL,
  `entry_at` date NOT NULL,
  `status` enum('D','L') NOT NULL DEFAULT 'D',
  `created_by` varchar(50) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_by` varchar(50) DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL ON UPDATE current_timestamp(),
  `ip_address` varchar(50) NOT NULL,
  `updated_ip_address` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`entry_status_id`),
  UNIQUE KEY `program_id_emp_code_entry_at` (`program_id`,`emp_code`,`entry_at`),
  KEY `FK_program_opd_entry_status_program_doctor_details` (`emp_code`),
  CONSTRAINT `FK_program_opd_entry_status_program_doctor_details` FOREIGN KEY (`emp_code`) REFERENCES `program_doctor_details` (`emp_code`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Data exporting was unselected.

-- Dumping structure for table ayush_incentive_schema.program_osteo_entry
CREATE TABLE IF NOT EXISTS `program_osteo_entry` (
  `osteo_entry_id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `year_id` int(10) unsigned NOT NULL,
  `month_id` int(10) unsigned NOT NULL,
  `emp_code` varchar(50) NOT NULL,
  `district_code` varchar(50) NOT NULL,
  `district_id` varchar(50) NOT NULL,
  `block_id` varchar(50) NOT NULL,
  `hc_id` varchar(50) NOT NULL,
  `entry_status` enum('D','L','F') NOT NULL DEFAULT 'D',
  `expected_population_of_block` int(11) unsigned NOT NULL,
  `eight_percent_of_expected_population_block` int(11) unsigned NOT NULL,
  `num_camp_conducted` int(11) unsigned NOT NULL,
  `num_person_attending_camp` int(11) unsigned NOT NULL,
  `num_pt_reg_till_date` int(11) unsigned NOT NULL,
  `num_new_pt_reg` int(11) unsigned NOT NULL,
  `num_follow_up_pt` int(11) unsigned NOT NULL,
  `osteoarthritis_diseases_diagnosed` int(11) unsigned NOT NULL,
  `frozen_shoulder_diseases_diagnosed` int(11) unsigned NOT NULL,
  `gout_diseases_diagnosed` int(11) unsigned NOT NULL,
  `cervical_spondylitis_diseases_diagnosed` int(11) unsigned NOT NULL,
  `lumber_spondylitis_diseases_diagnosed` int(11) unsigned NOT NULL,
  `sciatica_diseases_diagnosed` int(11) unsigned NOT NULL,
  `bells_palsy_diseases_diagnosed` int(11) unsigned NOT NULL,
  `planter_facitis_diseases_diagnosed` int(11) unsigned NOT NULL,
  `rheumatoid_arthritis_diseases_diagnosed` int(11) unsigned NOT NULL,
  `other_disease_diseases_diagnosed` int(11) unsigned NOT NULL,
  `num_pt_lifestyle_diet_ayushinter` int(11) unsigned NOT NULL,
  `num_pt_yoga_advice_ayushinter` int(11) unsigned NOT NULL,
  `num_panchkarma_counselling_ayushinter` int(11) unsigned NOT NULL,
  `num_pt_high_pain` int(11) unsigned NOT NULL,
  `num_pt_med_pain` int(11) unsigned NOT NULL,
  `num_pt_low_pain` int(11) unsigned NOT NULL,
  `num_pt_pain_clinicalimpr` int(11) unsigned NOT NULL,
  `num_pt_improvement_pain_clinicalimpr` int(11) unsigned NOT NULL,
  `num_pt_swelling_clinicalimpr` int(11) unsigned NOT NULL,
  `num_pt_improvement_swelling_clinicalimpr` int(11) unsigned NOT NULL,
  `num_pt_restricted_clinicalimpr` int(11) unsigned NOT NULL,
  `num_pt_improvement_restricted_clinicalimpr` int(11) unsigned NOT NULL,
  `num_patients_otherimpr` int(11) unsigned NOT NULL,
  `num_patients_improvement_otherimpr` int(11) unsigned NOT NULL,
  `num_pt_hwc_facility` int(11) unsigned NOT NULL,
  `num_pt_polyclinic_facility` int(11) unsigned NOT NULL,
  `num_pt_dh_ayushwing_facility` int(11) unsigned NOT NULL,
  `num_pt_allopathic_facility` int(11) unsigned NOT NULL,
  `num_pt_total_facility` int(11) unsigned NOT NULL,
  `num_ayush_treatment_received` int(11) unsigned NOT NULL,
  `total_num_followup` int(11) unsigned NOT NULL,
  `is_capture_location` tinyint(2) unsigned DEFAULT NULL,
  `latitude` decimal(11,8) unsigned DEFAULT NULL,
  `longitude` decimal(11,8) unsigned DEFAULT NULL,
  `capture_at` datetime DEFAULT NULL,
  `program_forwarded_district_by` varchar(50) DEFAULT NULL,
  `program_forwarded_district_at` datetime DEFAULT NULL,
  `program_forwarded_district_ip_address` varchar(50) DEFAULT NULL,
  `program_unlocked_state_reason` varchar(256) DEFAULT NULL,
  `program_unlocked_state_by` varchar(50) DEFAULT NULL,
  `program_unlocked_state_at` datetime DEFAULT NULL,
  `program_unlocked_state_ip_address` varchar(50) DEFAULT NULL,
  `created_by` varchar(50) NOT NULL,
  `created_at` datetime NOT NULL DEFAULT current_timestamp(),
  `ip_address` varchar(50) NOT NULL,
  `updated_by` varchar(50) DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL ON UPDATE current_timestamp(),
  `updated_ip_address` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`osteo_entry_id`),
  UNIQUE KEY `year_id_month_id_emp_code` (`year_id`,`month_id`,`emp_code`),
  KEY `FK_program_osteo_entry_program_mas_month` (`month_id`),
  KEY `FK_program_osteo_entry_program_doctor_details` (`emp_code`),
  KEY `entry_status` (`entry_status`),
  KEY `block_id` (`block_id`),
  KEY `hc_id` (`hc_id`),
  KEY `district_code` (`district_code`),
  KEY `district_id` (`district_id`),
  CONSTRAINT `FK_program_osteo_entry_program_doctor_details` FOREIGN KEY (`emp_code`) REFERENCES `program_doctor_details` (`emp_code`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `FK_program_osteo_entry_program_mas_month` FOREIGN KEY (`month_id`) REFERENCES `program_mas_month` (`month_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `FK_program_osteo_entry_program_mas_year` FOREIGN KEY (`year_id`) REFERENCES `program_mas_year` (`year_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=23 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Data exporting was unselected.

-- Dumping structure for table ayush_incentive_schema.program_supraja_anc_entry
CREATE TABLE IF NOT EXISTS `program_supraja_anc_entry` (
  `supraja_anc_entry_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `year_id` int(10) unsigned NOT NULL,
  `month_id` int(10) unsigned NOT NULL,
  `emp_code` varchar(50) NOT NULL,
  `district_code` varchar(50) NOT NULL,
  `district_id` varchar(50) NOT NULL,
  `block_id` varchar(50) NOT NULL,
  `hc_id` varchar(50) NOT NULL,
  `entry_status` enum('D','L','F') NOT NULL DEFAULT 'D',
  `num_anc_case_cumulative` int(10) unsigned NOT NULL,
  `num_anc_cases_registered_month` int(10) unsigned NOT NULL,
  `total_cases_delivered` int(10) unsigned NOT NULL,
  `num_left_cases_drop_out_cases` int(10) unsigned NOT NULL,
  `remaining_anc_cases_after_excluding` int(10) NOT NULL,
  `old_case_num_anc_checkup` int(10) unsigned NOT NULL,
  `new_case_num_anc_checkup` int(10) unsigned NOT NULL,
  `number_couple_counseling` int(10) unsigned NOT NULL,
  `garbh_sanskar_camp_conducted` int(10) unsigned NOT NULL,
  `total_num_beneficiaries` int(10) unsigned NOT NULL,
  `num_beneficiaries_monthly_yoga_practice` int(10) unsigned NOT NULL,
  `total_num_pt_advised_on_diet_yoga` int(10) unsigned NOT NULL,
  `num_cases_treated_for_minor_complications` int(10) unsigned NOT NULL,
  `num_beneficiaries_provided_ayurvedic_medicines` int(10) unsigned NOT NULL,
  `num_cases_referred_to_higher_centre` int(10) unsigned NOT NULL,
  `num_camps_conducted_in_reporting_month` int(10) unsigned NOT NULL,
  `remark` varchar(256) NOT NULL DEFAULT '',
  `program_forwarded_district_by` varchar(50) DEFAULT NULL,
  `program_forwarded_district_at` datetime DEFAULT NULL,
  `program_forwarded_district_ip_address` varchar(50) DEFAULT NULL,
  `program_unlocked_state_reason` varchar(256) DEFAULT NULL,
  `program_unlocked_state_by` varchar(50) DEFAULT NULL,
  `program_unlocked_state_at` datetime DEFAULT NULL,
  `program_unlocked_state_ip_address` varchar(50) DEFAULT NULL,
  `created_by` varchar(50) NOT NULL,
  `created_at` datetime NOT NULL DEFAULT current_timestamp(),
  `ip_address` varchar(50) NOT NULL,
  `updated_by` varchar(50) DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL ON UPDATE current_timestamp(),
  `updated_ip_address` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`supraja_anc_entry_id`),
  UNIQUE KEY `year_id_month_id_emp_code` (`year_id`,`month_id`,`emp_code`),
  KEY `FK_program_supraja_anc_entry_program_mas_month` (`month_id`),
  KEY `FK_program_supraja_anc_entry_program_doctor_details` (`emp_code`),
  KEY `entry_status` (`entry_status`),
  KEY `block_id` (`block_id`),
  KEY `hc_id` (`hc_id`),
  KEY `district_code` (`district_code`),
  KEY `district_id` (`district_id`),
  CONSTRAINT `FK_program_supraja_anc_entry_program_doctor_details` FOREIGN KEY (`emp_code`) REFERENCES `program_doctor_details` (`emp_code`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `FK_program_supraja_anc_entry_program_mas_month` FOREIGN KEY (`month_id`) REFERENCES `program_mas_month` (`month_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `FK_program_supraja_anc_entry_program_mas_year` FOREIGN KEY (`year_id`) REFERENCES `program_mas_year` (`year_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Data exporting was unselected.

-- Dumping structure for table ayush_incentive_schema.program_supraja_pnc_entry
CREATE TABLE IF NOT EXISTS `program_supraja_pnc_entry` (
  `supraja_pnc_entry_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `year_id` int(10) unsigned NOT NULL,
  `month_id` int(10) unsigned NOT NULL,
  `emp_code` varchar(50) NOT NULL,
  `district_code` varchar(50) NOT NULL,
  `district_id` varchar(50) NOT NULL,
  `block_id` varchar(50) NOT NULL,
  `hc_id` varchar(50) NOT NULL,
  `entry_status` enum('D','L','F') NOT NULL DEFAULT 'D',
  `total_num_new_enrolled_patients_delivered` int(10) unsigned NOT NULL,
  `total_num_old_enrolled_patients_delivered` int(10) unsigned NOT NULL,
  `num_enrolled_patients_delivered_vaginally` int(10) unsigned NOT NULL,
  `num_enrolled_patients_delivered_by_cesarean_section` int(10) unsigned NOT NULL,
  `num_full_term_normal_deliveries_without_complications` int(10) unsigned NOT NULL,
  `num_pre_term_deliveries` int(10) unsigned NOT NULL,
  `num_deliveries_with_complications` int(10) unsigned NOT NULL,
  `num_neonatal_babies_with_normal_birth_weight` int(10) unsigned NOT NULL,
  `num_neonatal_babies_with_birth_weight_lt_twofivekg` int(10) unsigned NOT NULL,
  `puerperal_cases_provided_ayurvedic_medicine_given_care_yn` enum('Y','N') NOT NULL,
  `num_cases_in_which_neonatal_examinations_and_care_provided` int(10) unsigned NOT NULL,
  `num_cases_in_which_neonatal_swarn_praashan_immunization` int(10) unsigned NOT NULL,
  `num_cases_who_received_breast_feeding_guidence` int(10) unsigned NOT NULL,
  `remark` varchar(256) NOT NULL,
  `program_forwarded_district_by` varchar(50) DEFAULT NULL,
  `program_forwarded_district_at` datetime DEFAULT NULL,
  `program_forwarded_district_ip_address` varchar(50) DEFAULT NULL,
  `program_unlocked_state_reason` varchar(256) DEFAULT NULL,
  `program_unlocked_state_by` varchar(50) DEFAULT NULL,
  `program_unlocked_state_at` datetime DEFAULT NULL,
  `program_unlocked_state_ip_address` varchar(50) DEFAULT NULL,
  `created_by` varchar(50) NOT NULL,
  `created_at` datetime NOT NULL DEFAULT current_timestamp(),
  `ip_address` varchar(50) NOT NULL,
  `updated_by` varchar(50) DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL ON UPDATE current_timestamp(),
  `updated_ip_address` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`supraja_pnc_entry_id`),
  UNIQUE KEY `year_id_month_id_emp_code` (`year_id`,`month_id`,`emp_code`),
  KEY `entry_status` (`entry_status`),
  KEY `FK_program_supraja_pnc_entry_program_mas_month` (`month_id`),
  KEY `FK_program_supraja_pnc_entry_program_doctor_details` (`emp_code`),
  KEY `block_id` (`block_id`),
  KEY `hc_id` (`hc_id`),
  KEY `district_code` (`district_code`),
  KEY `district_id` (`district_id`),
  CONSTRAINT `FK_program_supraja_pnc_entry_program_doctor_details` FOREIGN KEY (`emp_code`) REFERENCES `program_doctor_details` (`emp_code`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `FK_program_supraja_pnc_entry_program_mas_month` FOREIGN KEY (`month_id`) REFERENCES `program_mas_month` (`month_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `FK_program_supraja_pnc_entry_program_mas_year` FOREIGN KEY (`year_id`) REFERENCES `program_mas_year` (`year_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Data exporting was unselected.

-- Dumping structure for table ayush_incentive_schema.program_vayomitra_entry
CREATE TABLE IF NOT EXISTS `program_vayomitra_entry` (
  `vayomitra_entry_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `year_id` int(10) unsigned NOT NULL,
  `month_id` int(10) unsigned NOT NULL,
  `emp_code` varchar(50) NOT NULL,
  `district_code` varchar(50) NOT NULL,
  `district_id` varchar(50) NOT NULL,
  `block_id` varchar(50) NOT NULL,
  `hc_id` varchar(50) NOT NULL,
  `entry_status` enum('D','L','F') NOT NULL DEFAULT 'D',
  `expected_population_block` int(10) unsigned NOT NULL,
  `eight_percent_of_expected_population_block` int(10) unsigned NOT NULL,
  `num_camp_conducted` int(10) unsigned NOT NULL,
  `num_person_attending_camp` int(10) unsigned NOT NULL,
  `total_num_patient_reg_till_date` int(10) unsigned NOT NULL,
  `total_num_new_patient_reg` int(10) unsigned NOT NULL,
  `total_num_of_follow_up_patient` int(10) unsigned NOT NULL,
  `age_total_num_pt_60_69` int(10) unsigned NOT NULL,
  `age_total_num_pt_70_80` int(10) unsigned NOT NULL,
  `age_total_num_pt_more_than_80` int(10) unsigned NOT NULL,
  `disease_total_num_pt_osteoarthritis` int(10) unsigned NOT NULL COMMENT 'Types of Disease',
  `disease_total_num_pt_frozen_shoulder` int(10) unsigned NOT NULL COMMENT 'Types of Disease',
  `disease_total_num_pt_gout` int(10) unsigned NOT NULL COMMENT 'Types of Disease',
  `disease_total_num_pt_seiatica` int(10) unsigned NOT NULL COMMENT 'Types of Disease',
  `disease_total_num_pt_spondilitis` int(10) unsigned NOT NULL COMMENT 'Types of Disease',
  `disease_total_num_pt_hypertention` int(10) unsigned NOT NULL COMMENT 'Types of Disease',
  `disease_total_num_pt_diabetes` int(10) unsigned NOT NULL COMMENT 'Types of Disease',
  `disease_total_num_pt_bells_palsy` int(10) unsigned NOT NULL COMMENT 'Types of Disease',
  `disease_total_num_pt_ent` int(10) unsigned NOT NULL COMMENT 'Types of Disease',
  `disease_total_num_pt_git_gastritis` int(10) unsigned NOT NULL COMMENT 'Types of Disease',
  `disease_total_num_pt_respiratory_disorder` int(10) unsigned NOT NULL COMMENT 'Types of Disease',
  `disease_total_num_pt_other_disease` int(10) unsigned NOT NULL COMMENT 'Types of Disease',
  `daily_status_scal_mild_num_patient` int(10) unsigned NOT NULL,
  `daily_status_scal_mild_num_patient_impr` int(10) unsigned NOT NULL,
  `daily_status_scal_moderate_num_patient` int(10) unsigned NOT NULL,
  `daily_status_scal_moderate_num_patient_impr` int(10) unsigned NOT NULL,
  `daily_status_scal_severe_num_patient` int(10) unsigned NOT NULL,
  `daily_status_scal_severe_num_patient_impr` int(10) unsigned NOT NULL,
  `instrumental_activity_scale_mild_num_patient` int(10) unsigned NOT NULL,
  `instrumental_activity_scale_mild_num_patient_impr` int(10) unsigned NOT NULL,
  `instrumental_activity_scale_moderate_num_patient` int(10) unsigned NOT NULL,
  `instrumental_activity_scale_moderate_num_patient_impr` int(10) unsigned NOT NULL,
  `instrumental_activity_scale_severe_num_patient` int(10) unsigned NOT NULL,
  `instrumental_activity_scale_severe_num_patient_impr` int(10) unsigned NOT NULL,
  `num_pt_prescribed_medicine` int(10) unsigned NOT NULL,
  `num_ayush_intervention_lifestyle_changes_and_diet_councelling` int(10) unsigned NOT NULL,
  `num_ayush_intervention_yoga_advice` int(10) unsigned NOT NULL,
  `num_ayush_intervention_panchkrma` int(10) unsigned NOT NULL,
  `num_follow_up_suggested` int(10) unsigned NOT NULL,
  `refferal_status_hwc` int(10) unsigned NOT NULL,
  `refferal_status_hwc_polyclinic_stc` int(10) unsigned NOT NULL,
  `refferal_status_hwc_dh_ayushwing` int(10) unsigned NOT NULL,
  `refferal_status_hwc_allopathy_centre` int(10) unsigned NOT NULL,
  `total_num_improvement_qol` int(10) unsigned NOT NULL,
  `num_pt_reason_for_refer_panchkarma_mental_health` int(10) unsigned NOT NULL,
  `num_pt_linkage_with_other_dpt_shc_panchayt` int(10) unsigned NOT NULL,
  `is_capture_location` tinyint(2) unsigned DEFAULT NULL,
  `latitude` decimal(11,8) unsigned DEFAULT NULL,
  `longitude` decimal(11,8) unsigned DEFAULT NULL,
  `capture_at` datetime DEFAULT NULL,
  `program_forwarded_district_by` varchar(50) DEFAULT NULL,
  `program_forwarded_district_at` datetime DEFAULT NULL,
  `program_forwarded_district_ip_address` varchar(50) DEFAULT NULL,
  `program_unlocked_state_reason` varchar(256) DEFAULT NULL,
  `program_unlocked_state_by` varchar(50) DEFAULT NULL,
  `program_unlocked_state_at` datetime DEFAULT NULL,
  `program_unlocked_state_ip_address` varchar(50) DEFAULT NULL,
  `created_by` varchar(50) NOT NULL,
  `created_at` datetime NOT NULL DEFAULT current_timestamp(),
  `ip_address` varchar(50) NOT NULL,
  `updated_by` varchar(50) DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL ON UPDATE current_timestamp(),
  `updated_ip_address` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`vayomitra_entry_id`),
  UNIQUE KEY `year_id_month_id_emp_code` (`year_id`,`month_id`,`emp_code`),
  KEY `FK_program_vayomitra_entry_program_mas_month` (`month_id`),
  KEY `FK_program_vayomitra_entry_program_doctor_details` (`emp_code`),
  KEY `entry_status` (`entry_status`),
  KEY `block_id` (`block_id`),
  KEY `hc_id` (`hc_id`),
  KEY `district_code` (`district_code`),
  KEY `district_id` (`district_id`),
  CONSTRAINT `FK__program_mas_year` FOREIGN KEY (`year_id`) REFERENCES `program_mas_year` (`year_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `FK_program_vayomitra_entry_program_doctor_details` FOREIGN KEY (`emp_code`) REFERENCES `program_doctor_details` (`emp_code`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `FK_program_vayomitra_entry_program_mas_month` FOREIGN KEY (`month_id`) REFERENCES `program_mas_month` (`month_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Data exporting was unselected.

-- Dumping structure for table ayush_incentive_schema.pts_details
CREATE TABLE IF NOT EXISTS `pts_details` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `emp_code` varchar(50) NOT NULL,
  `designation_code` int(11) NOT NULL,
  `hc_id` varchar(50) NOT NULL,
  `emp_name_en` varchar(50) NOT NULL,
  `emp_name_hi` varchar(50) NOT NULL,
  `father_husband` varchar(50) NOT NULL COMMENT '1 = पिता, 2  = पति',
  `f_hname` varchar(50) NOT NULL,
  `mobile_number` bigint(20) NOT NULL,
  `dob` date DEFAULT NULL,
  `age` tinyint(4) DEFAULT NULL,
  `gender` enum('Male','Female','Transgender') NOT NULL,
  `qualification` varchar(50) NOT NULL,
  `account_no` varchar(50) NOT NULL,
  `state_code` int(11) NOT NULL,
  `bank_district_code` int(11) DEFAULT NULL,
  `branch_code` int(11) NOT NULL,
  `bank_code` int(11) NOT NULL,
  `bank_ifsc_code` varchar(50) NOT NULL,
  `address` text NOT NULL,
  `district_code` int(11) NOT NULL,
  `block_code` varchar(50) DEFAULT NULL,
  `entrydatetime` datetime NOT NULL,
  `entryby` varchar(50) NOT NULL,
  `ip_address` varchar(50) NOT NULL,
  `is_active` tinyint(4) unsigned NOT NULL DEFAULT 1,
  `update_by` varchar(50) DEFAULT NULL,
  `update_ip_address` varchar(50) DEFAULT NULL,
  `update_dt` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `mobile_number` (`mobile_number`),
  UNIQUE KEY `account_no` (`account_no`),
  UNIQUE KEY `emp_code` (`emp_code`),
  KEY `hc_id` (`hc_id`),
  KEY `FK_pts_details_mas_team_incentive_amt` (`designation_code`),
  KEY `state_code` (`state_code`),
  CONSTRAINT `FK_pts_details_mas_team_incentive_amt` FOREIGN KEY (`designation_code`) REFERENCES `mas_team_incentive_amt` (`designation_code`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=396 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Data exporting was unselected.

-- Dumping structure for table ayush_incentive_schema.reject_incentive_entry_details
CREATE TABLE IF NOT EXISTS `reject_incentive_entry_details` (
  `entry_id` int(11) NOT NULL AUTO_INCREMENT,
  `activity_code` int(11) NOT NULL,
  `target_entry_id` int(11) NOT NULL,
  `status_id` int(11) unsigned NOT NULL,
  `monthly_target_value` varchar(50) DEFAULT NULL,
  `target_achieved_value` varchar(50) DEFAULT NULL,
  `performance_grade` int(11) NOT NULL,
  `performance_percent` int(11) NOT NULL,
  `total_prev_target_achieved_value` int(11) DEFAULT NULL,
  `entryby` varchar(50) NOT NULL,
  `entrydatetime` datetime NOT NULL DEFAULT current_timestamp(),
  `ip_address` varchar(50) NOT NULL,
  `updateby` varchar(50) DEFAULT NULL,
  `updatedatetime` datetime DEFAULT NULL,
  `update_ip_address` varchar(50) DEFAULT NULL,
  `is_reject` tinyint(4) NOT NULL,
  `reject_reason` varchar(150) NOT NULL,
  PRIMARY KEY (`entry_id`) USING BTREE,
  KEY `activity_code` (`activity_code`) USING BTREE,
  KEY `performance_grade` (`performance_grade`) USING BTREE,
  KEY `target_entry_id` (`target_entry_id`) USING BTREE,
  KEY `status_id` (`status_id`),
  CONSTRAINT `reject_incentive_entry_details_ibfk_1` FOREIGN KEY (`activity_code`) REFERENCES `mas_activity` (`activity_code`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `reject_incentive_entry_details_ibfk_2` FOREIGN KEY (`performance_grade`) REFERENCES `mas_grade` (`grade_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `reject_incentive_entry_details_ibfk_3` FOREIGN KEY (`target_entry_id`) REFERENCES `target_entry_details` (`target_entry_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=37470 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Data exporting was unselected.

-- Dumping structure for table ayush_incentive_schema.reject_incentive_entry_status_details
CREATE TABLE IF NOT EXISTS `reject_incentive_entry_status_details` (
  `status_id` int(11) NOT NULL AUTO_INCREMENT,
  `target_entry_id` int(11) NOT NULL,
  `hc_lock_status` enum('pending','approve') CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT 'pending',
  `hc_lock_dt` datetime NOT NULL,
  `hc_lock_ip_address` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `dist_status` enum('pending','approve','reject') CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT 'pending',
  `dist_decline_id` int(11) NOT NULL,
  `dist_reject_other_reason` varchar(200) DEFAULT NULL,
  `dist_status_dt` datetime NOT NULL,
  `dist_status_ip_address` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `generate_excel` enum('Y','N') NOT NULL DEFAULT 'N',
  `generate_excel_filename` varchar(200) DEFAULT NULL,
  `generate_excel_dt` datetime DEFAULT NULL,
  `generate_excel_ip_address` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`status_id`) USING BTREE,
  KEY `FK_incentive_entry_status_details_target_entry_details` (`target_entry_id`) USING BTREE,
  KEY `FK_incentive_entry_status_details_mas_decline` (`dist_decline_id`) USING BTREE,
  CONSTRAINT `reject_incentive_entry_status_details_ibfk_1` FOREIGN KEY (`dist_decline_id`) REFERENCES `mas_decline` (`decline_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `reject_incentive_entry_status_details_ibfk_2` FOREIGN KEY (`target_entry_id`) REFERENCES `target_entry_details` (`target_entry_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=3726 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Data exporting was unselected.

-- Dumping structure for table ayush_incentive_schema.reject_incentive_six_month_amt_details
CREATE TABLE IF NOT EXISTS `reject_incentive_six_month_amt_details` (
  `six_month_amt_id` int(11) NOT NULL AUTO_INCREMENT,
  `inc_tm_amt_id` int(11) NOT NULL,
  `target_entry_id` int(11) NOT NULL,
  `amount` int(11) NOT NULL,
  `entryby` varchar(50) NOT NULL,
  `entrydatetime` datetime NOT NULL,
  `ip_address` varchar(50) NOT NULL,
  `updateby` varchar(50) DEFAULT NULL,
  `updatedatetime` datetime DEFAULT NULL,
  `update_ip_address` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`six_month_amt_id`) USING BTREE,
  UNIQUE KEY `inc_tm_amt_id_unique` (`inc_tm_amt_id`) USING BTREE,
  KEY `FK_incentive_team_amt_details_target_entry_details` (`target_entry_id`) USING BTREE,
  KEY `inc_tm_amt_id` (`inc_tm_amt_id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=23091 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Data exporting was unselected.

-- Dumping structure for table ayush_incentive_schema.reject_incentive_team_amt_details
CREATE TABLE IF NOT EXISTS `reject_incentive_team_amt_details` (
  `inc_tm_amt_id` int(11) NOT NULL AUTO_INCREMENT,
  `target_entry_id` int(11) NOT NULL,
  `designation_code` int(11) NOT NULL,
  `status_id` int(11) unsigned NOT NULL,
  `emp_code` varchar(100) NOT NULL,
  `emp_name` varchar(100) NOT NULL,
  `account_no` varchar(100) NOT NULL,
  `bank_ifsc_code` varchar(100) NOT NULL,
  `mobile_no` varchar(20) DEFAULT NULL,
  `amount` int(11) NOT NULL,
  `entryby` varchar(50) NOT NULL,
  `entrydatetime` datetime NOT NULL,
  `ip_address` varchar(50) NOT NULL,
  `updateby` varchar(50) DEFAULT NULL,
  `updatedatetime` datetime DEFAULT NULL,
  `update_ip_address` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`inc_tm_amt_id`) USING BTREE,
  KEY `FK_incentive_team_amt_details_target_entry_details` (`target_entry_id`) USING BTREE,
  KEY `hr_id` (`designation_code`) USING BTREE,
  KEY `status_id` (`status_id`),
  CONSTRAINT `reject_incentive_team_amt_details_ibfk_1` FOREIGN KEY (`designation_code`) REFERENCES `mas_team_incentive_amt` (`designation_code`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `reject_incentive_team_amt_details_ibfk_2` FOREIGN KEY (`target_entry_id`) REFERENCES `target_entry_details` (`target_entry_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=22063 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Data exporting was unselected.

-- Dumping structure for table ayush_incentive_schema.sessions
CREATE TABLE IF NOT EXISTS `sessions` (
  `session_id` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `expires` int(11) unsigned NOT NULL,
  `data` mediumtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL,
  `user_id` varchar(50) DEFAULT NULL,
  `dt_stamp` datetime DEFAULT current_timestamp(),
  `ip_address` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`session_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Data exporting was unselected.

-- Dumping structure for table ayush_incentive_schema.session_login_history
CREATE TABLE IF NOT EXISTS `session_login_history` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `session_id` varchar(50) DEFAULT NULL,
  `user_id` varchar(50) DEFAULT NULL,
  `logged_in` datetime DEFAULT NULL,
  `logged_out` datetime DEFAULT NULL,
  `dt_stamp` datetime DEFAULT NULL,
  `ip_address` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=7333 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;

-- Data exporting was unselected.

-- Dumping structure for table ayush_incentive_schema.target_entry_details
CREATE TABLE IF NOT EXISTS `target_entry_details` (
  `target_entry_id` int(11) NOT NULL AUTO_INCREMENT,
  `year` int(11) NOT NULL,
  `month` int(11) NOT NULL,
  `hc_id` varchar(50) NOT NULL,
  `village_count` int(11) unsigned NOT NULL,
  `family_count` int(11) unsigned NOT NULL,
  `person_count` int(11) unsigned NOT NULL,
  `age_gt_thirtee_person_count` int(11) unsigned NOT NULL,
  `high_bp_pt_count` int(11) unsigned NOT NULL,
  `diabetes_pt_count` int(11) unsigned NOT NULL,
  `entrydatetime` datetime NOT NULL,
  `entryby` varchar(50) NOT NULL,
  `ip_address` varchar(50) NOT NULL,
  PRIMARY KEY (`target_entry_id`) USING BTREE,
  UNIQUE KEY `year_month_hc_id` (`year`,`month`,`hc_id`) USING BTREE,
  KEY `entrymonth` (`month`) USING BTREE,
  KEY `entryyear` (`year`) USING BTREE,
  KEY `hc_id` (`hc_id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=3679 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Data exporting was unselected.

/*!40103 SET TIME_ZONE=IFNULL(@OLD_TIME_ZONE, 'system') */;
/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IFNULL(@OLD_FOREIGN_KEY_CHECKS, 1) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40111 SET SQL_NOTES=IFNULL(@OLD_SQL_NOTES, 1) */;
