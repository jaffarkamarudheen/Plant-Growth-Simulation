-- phpMyAdmin SQL Dump
-- version 5.2.3
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1:3306
-- Generation Time: Apr 11, 2026 at 07:40 AM
-- Server version: 8.4.7
-- PHP Version: 8.3.28

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `plant_simulation`
--

-- --------------------------------------------------------

--
-- Table structure for table `cache`
--

DROP TABLE IF EXISTS `cache`;
CREATE TABLE IF NOT EXISTS `cache` (
  `key` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `value` mediumtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `expiration` int NOT NULL,
  PRIMARY KEY (`key`),
  KEY `cache_expiration_index` (`expiration`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `cache_locks`
--

DROP TABLE IF EXISTS `cache_locks`;
CREATE TABLE IF NOT EXISTS `cache_locks` (
  `key` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `owner` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `expiration` int NOT NULL,
  PRIMARY KEY (`key`),
  KEY `cache_locks_expiration_index` (`expiration`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `failed_jobs`
--

DROP TABLE IF EXISTS `failed_jobs`;
CREATE TABLE IF NOT EXISTS `failed_jobs` (
  `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT,
  `uuid` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `connection` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `queue` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `payload` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `exception` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `failed_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `failed_jobs_uuid_unique` (`uuid`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `jobs`
--

DROP TABLE IF EXISTS `jobs`;
CREATE TABLE IF NOT EXISTS `jobs` (
  `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT,
  `queue` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `payload` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `attempts` tinyint UNSIGNED NOT NULL,
  `reserved_at` int UNSIGNED DEFAULT NULL,
  `available_at` int UNSIGNED NOT NULL,
  `created_at` int UNSIGNED NOT NULL,
  PRIMARY KEY (`id`),
  KEY `jobs_queue_index` (`queue`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `job_batches`
--

DROP TABLE IF EXISTS `job_batches`;
CREATE TABLE IF NOT EXISTS `job_batches` (
  `id` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `name` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `total_jobs` int NOT NULL,
  `pending_jobs` int NOT NULL,
  `failed_jobs` int NOT NULL,
  `failed_job_ids` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `options` mediumtext COLLATE utf8mb4_unicode_ci,
  `cancelled_at` int DEFAULT NULL,
  `created_at` int NOT NULL,
  `finished_at` int DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `migrations`
--

DROP TABLE IF EXISTS `migrations`;
CREATE TABLE IF NOT EXISTS `migrations` (
  `id` int UNSIGNED NOT NULL AUTO_INCREMENT,
  `migration` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `batch` int NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=10 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `migrations`
--

INSERT INTO `migrations` (`id`, `migration`, `batch`) VALUES
(1, '0001_01_01_000000_create_users_table', 1),
(2, '0001_01_01_000001_create_cache_table', 1),
(3, '0001_01_01_000002_create_jobs_table', 1),
(4, '2026_04_11_042103_create_simulations_table', 1),
(5, '2026_04_11_043619_create_personal_access_tokens_table', 2),
(6, '2026_04_11_062520_create_plants_table', 3),
(7, '2026_04_11_062520_create_user_plants_table', 3),
(8, '2026_04_11_064707_add_history_to_user_plants_table', 4),
(9, '2026_04_11_065238_add_care_levels_to_user_plants', 5);

-- --------------------------------------------------------

--
-- Table structure for table `password_reset_tokens`
--

DROP TABLE IF EXISTS `password_reset_tokens`;
CREATE TABLE IF NOT EXISTS `password_reset_tokens` (
  `email` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `token` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`email`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `personal_access_tokens`
--

DROP TABLE IF EXISTS `personal_access_tokens`;
CREATE TABLE IF NOT EXISTS `personal_access_tokens` (
  `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT,
  `tokenable_type` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `tokenable_id` bigint UNSIGNED NOT NULL,
  `name` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `token` varchar(64) COLLATE utf8mb4_unicode_ci NOT NULL,
  `abilities` text COLLATE utf8mb4_unicode_ci,
  `last_used_at` timestamp NULL DEFAULT NULL,
  `expires_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `personal_access_tokens_token_unique` (`token`),
  KEY `personal_access_tokens_tokenable_type_tokenable_id_index` (`tokenable_type`,`tokenable_id`),
  KEY `personal_access_tokens_expires_at_index` (`expires_at`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `plants`
--

DROP TABLE IF EXISTS `plants`;
CREATE TABLE IF NOT EXISTS `plants` (
  `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT,
  `name` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `category` enum('small','medium','tree') COLLATE utf8mb4_unicode_ci NOT NULL,
  `base_growth_days` int NOT NULL,
  `water_requirement` enum('low','medium','high') COLLATE utf8mb4_unicode_ci NOT NULL,
  `sunlight_requirement` enum('low','medium','high') COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `plants`
--

INSERT INTO `plants` (`id`, `name`, `category`, `base_growth_days`, `water_requirement`, `sunlight_requirement`, `created_at`, `updated_at`) VALUES
(1, 'Aloe Vera', 'medium', 115, 'medium', 'high', NULL, '2026-04-11 01:13:16'),
(2, 'Tomato', 'medium', 120, 'medium', 'high', NULL, NULL),
(3, 'Oak Tree', 'tree', 1825, 'medium', 'medium', NULL, NULL),
(4, 'Aloe Vera', 'small', 45, 'low', 'high', NULL, NULL),
(5, 'Tomato', 'medium', 120, 'medium', 'high', NULL, NULL),
(6, 'Oak Tree', 'tree', 1825, 'medium', 'medium', NULL, NULL),
(7, '1234', 'small', 10, 'low', 'low', '2026-04-11 01:34:53', '2026-04-11 01:34:53');

-- --------------------------------------------------------

--
-- Table structure for table `sessions`
--

DROP TABLE IF EXISTS `sessions`;
CREATE TABLE IF NOT EXISTS `sessions` (
  `id` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `user_id` bigint UNSIGNED DEFAULT NULL,
  `ip_address` varchar(45) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `user_agent` text COLLATE utf8mb4_unicode_ci,
  `payload` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `last_activity` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `sessions_user_id_index` (`user_id`),
  KEY `sessions_last_activity_index` (`last_activity`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `sessions`
--

INSERT INTO `sessions` (`id`, `user_id`, `ip_address`, `user_agent`, `payload`, `last_activity`) VALUES
('H9t60I9ewzK04nLtZ39kwWFWiYSCsOMTkGJZPUIP', NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36 Edg/146.0.0.0', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiVTg2elIzajlkemJKNnFmQnNPeHRPNnNaQzFLUVpmeUVuS1pRdnlsRCI7czo5OiJfcHJldmlvdXMiO2E6Mjp7czozOiJ1cmwiO3M6MjE6Imh0dHA6Ly9sb2NhbGhvc3Q6ODAwMCI7czo1OiJyb3V0ZSI7Tjt9czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319fQ==', 1775883060),
('zyiZmBhgrLkzv0JzoSzclOFCqOA6UAkF3UBo30bn', NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36 Edg/146.0.0.0', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoibUgwSFU1VmJJZWtUNEJ3bnhDWXJnTkFmSmVWQ2xNd3UwSnVhVTV3ciI7czo5OiJfcHJldmlvdXMiO2E6Mjp7czozOiJ1cmwiO3M6MjE6Imh0dHA6Ly8xMjcuMC4wLjE6ODAwMCI7czo1OiJyb3V0ZSI7Tjt9czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319fQ==', 1775883125),
('rqkgJSWDltz12nAfJCgJHcHQZGMapsBPOpsjypOq', NULL, '127.0.0.1', 'PostmanRuntime/7.51.1', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoib2Jsb1hkcmdvU3dienVBSVJMdDlMQ0FmQnZkdGF6VzBZMFdtZXg3NSI7czo5OiJfcHJldmlvdXMiO2E6Mjp7czozOiJ1cmwiO3M6MjE6Imh0dHA6Ly8xMjcuMC4wLjE6ODAwMCI7czo1OiJyb3V0ZSI7Tjt9czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319fQ==', 1775883334),
('Fj9t5QqDyEhTSBKNTJhAArRz1xj1lhZ5rEID4UyS', NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36 Edg/146.0.0.0', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoib2FmcHNwTTZDWkpRT0xoY1FNWVdkUjhaU1JGZTZpOTZNejRScG0wbSI7czo5OiJfcHJldmlvdXMiO2E6Mjp7czozOiJ1cmwiO3M6MjE6Imh0dHA6Ly8xMjcuMC4wLjE6ODAwMCI7czo1OiJyb3V0ZSI7Tjt9czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319fQ==', 1775893198);

-- --------------------------------------------------------

--
-- Table structure for table `simulations`
--

DROP TABLE IF EXISTS `simulations`;
CREATE TABLE IF NOT EXISTS `simulations` (
  `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT,
  `plant_name` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'Succulent',
  `current_day` int NOT NULL DEFAULT '0',
  `growth_percentage` double NOT NULL DEFAULT '0',
  `health_percentage` double NOT NULL DEFAULT '100',
  `last_water_level` double NOT NULL DEFAULT '50',
  `last_sunlight_level` double NOT NULL DEFAULT '50',
  `status` enum('growing','matured','withered','dead') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'growing',
  `history` json DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `simulations`
--

INSERT INTO `simulations` (`id`, `plant_name`, `current_day`, `growth_percentage`, `health_percentage`, `last_water_level`, `last_sunlight_level`, `status`, `history`, `created_at`, `updated_at`) VALUES
(1, 'Super Green', 23, 100, 100, 61, 100, 'matured', '[{\"day\": 1, \"water\": 50, \"growth\": 6, \"health\": 100, \"status\": \"growing\", \"sunlight\": 50, \"timestamp\": \"2026-04-11T05:30:10.603963Z\"}, {\"day\": 2, \"water\": 50, \"growth\": 12, \"health\": 100, \"status\": \"growing\", \"sunlight\": 50, \"timestamp\": \"2026-04-11T05:30:11.122855Z\"}, {\"day\": 3, \"water\": 50, \"growth\": 18, \"health\": 100, \"status\": \"growing\", \"sunlight\": 50, \"timestamp\": \"2026-04-11T05:30:11.979507Z\"}, {\"day\": 4, \"water\": 50, \"growth\": 24, \"health\": 100, \"status\": \"growing\", \"sunlight\": 50, \"timestamp\": \"2026-04-11T05:30:12.736839Z\"}, {\"day\": 5, \"water\": 50, \"growth\": 30, \"health\": 100, \"status\": \"growing\", \"sunlight\": 50, \"timestamp\": \"2026-04-11T05:30:13.752170Z\"}, {\"day\": 6, \"water\": 50, \"growth\": 36, \"health\": 100, \"status\": \"growing\", \"sunlight\": 50, \"timestamp\": \"2026-04-11T05:30:14.989205Z\"}, {\"day\": 7, \"water\": 50, \"growth\": 42, \"health\": 100, \"status\": \"growing\", \"sunlight\": 50, \"timestamp\": \"2026-04-11T05:30:15.570937Z\"}, {\"day\": 8, \"water\": 50, \"growth\": 48, \"health\": 100, \"status\": \"growing\", \"sunlight\": 50, \"timestamp\": \"2026-04-11T05:30:16.217403Z\"}, {\"day\": 9, \"water\": 50, \"growth\": 54, \"health\": 100, \"status\": \"growing\", \"sunlight\": 50, \"timestamp\": \"2026-04-11T05:30:16.713517Z\"}, {\"day\": 10, \"water\": 50, \"growth\": 60, \"health\": 100, \"status\": \"growing\", \"sunlight\": 50, \"timestamp\": \"2026-04-11T05:30:17.296430Z\"}, {\"day\": 11, \"water\": 50, \"growth\": 66, \"health\": 100, \"status\": \"growing\", \"sunlight\": 50, \"timestamp\": \"2026-04-11T05:30:17.818052Z\"}, {\"day\": 12, \"water\": 50, \"growth\": 72, \"health\": 100, \"status\": \"growing\", \"sunlight\": 50, \"timestamp\": \"2026-04-11T05:30:18.434842Z\"}, {\"day\": 13, \"water\": 50, \"growth\": 78, \"health\": 100, \"status\": \"growing\", \"sunlight\": 50, \"timestamp\": \"2026-04-11T05:30:19.199454Z\"}, {\"day\": 14, \"water\": 50, \"growth\": 82, \"health\": 100, \"status\": \"growing\", \"sunlight\": 100, \"timestamp\": \"2026-04-11T05:30:21.821718Z\"}, {\"day\": 15, \"water\": 50, \"growth\": 86, \"health\": 100, \"status\": \"growing\", \"sunlight\": 100, \"timestamp\": \"2026-04-11T05:30:22.569725Z\"}, {\"day\": 16, \"water\": 50, \"growth\": 90, \"health\": 100, \"status\": \"growing\", \"sunlight\": 100, \"timestamp\": \"2026-04-11T05:30:23.131437Z\"}, {\"day\": 17, \"water\": 50, \"growth\": 94, \"health\": 100, \"status\": \"growing\", \"sunlight\": 100, \"timestamp\": \"2026-04-11T05:30:28.010290Z\"}, {\"day\": 18, \"water\": 50, \"growth\": 98, \"health\": 100, \"status\": \"growing\", \"sunlight\": 100, \"timestamp\": \"2026-04-11T05:30:28.375491Z\"}, {\"day\": 19, \"water\": 50, \"growth\": 100, \"health\": 100, \"status\": \"matured\", \"sunlight\": 100, \"timestamp\": \"2026-04-11T05:30:28.758234Z\"}, {\"day\": 20, \"water\": 50, \"growth\": 100, \"health\": 100, \"status\": \"matured\", \"sunlight\": 100, \"timestamp\": \"2026-04-11T05:30:29.276391Z\"}, {\"day\": 21, \"water\": 50, \"growth\": 100, \"health\": 100, \"status\": \"matured\", \"sunlight\": 100, \"timestamp\": \"2026-04-11T05:30:29.728017Z\"}, {\"day\": 22, \"water\": 50, \"growth\": 100, \"health\": 100, \"status\": \"matured\", \"sunlight\": 100, \"timestamp\": \"2026-04-11T05:30:30.802153Z\"}, {\"day\": 23, \"water\": 50, \"growth\": 100, \"health\": 100, \"status\": \"matured\", \"sunlight\": 100, \"timestamp\": \"2026-04-11T05:30:31.086253Z\"}]', '2026-04-10 23:26:07', '2026-04-11 00:00:31'),
(2, 'Super Green', 0, 0, 100, 50, 50, 'growing', '[]', '2026-04-11 00:17:16', '2026-04-11 00:17:16'),
(3, 'Super Green', 19, 67.8, 50, 50, 50, 'growing', '[{\"day\": 1, \"water\": 0, \"growth\": 4, \"health\": 100, \"status\": \"growing\", \"sunlight\": 0, \"timestamp\": \"2026-04-11T05:49:01.742555Z\"}, {\"day\": 2, \"water\": 0, \"growth\": 8, \"health\": 100, \"status\": \"growing\", \"sunlight\": 0, \"timestamp\": \"2026-04-11T05:49:02.846822Z\"}, {\"day\": 3, \"water\": 0, \"growth\": 12, \"health\": 100, \"status\": \"growing\", \"sunlight\": 0, \"timestamp\": \"2026-04-11T05:49:03.538300Z\"}, {\"day\": 4, \"water\": 0, \"growth\": 16, \"health\": 100, \"status\": \"growing\", \"sunlight\": 0, \"timestamp\": \"2026-04-11T05:49:04.002218Z\"}, {\"day\": 5, \"water\": 1, \"growth\": 20, \"health\": 100, \"status\": \"growing\", \"sunlight\": 4, \"timestamp\": \"2026-04-11T05:49:10.478629Z\"}, {\"day\": 6, \"water\": 1, \"growth\": 24, \"health\": 100, \"status\": \"growing\", \"sunlight\": 4, \"timestamp\": \"2026-04-11T05:49:11.133932Z\"}, {\"day\": 7, \"water\": 1, \"growth\": 28, \"health\": 100, \"status\": \"growing\", \"sunlight\": 4, \"timestamp\": \"2026-04-11T05:49:11.584427Z\"}, {\"day\": 8, \"water\": 1, \"growth\": 32, \"health\": 100, \"status\": \"growing\", \"sunlight\": 4, \"timestamp\": \"2026-04-11T05:49:12.035569Z\"}, {\"day\": 9, \"water\": 1, \"growth\": 36, \"health\": 100, \"status\": \"growing\", \"sunlight\": 4, \"timestamp\": \"2026-04-11T05:49:12.346080Z\"}, {\"day\": 10, \"water\": 1, \"growth\": 40, \"health\": 100, \"status\": \"growing\", \"sunlight\": 4, \"timestamp\": \"2026-04-11T05:49:12.845587Z\"}, {\"day\": 11, \"water\": 1, \"growth\": 44, \"health\": 100, \"status\": \"growing\", \"sunlight\": 4, \"timestamp\": \"2026-04-11T05:49:13.415986Z\"}, {\"day\": 12, \"water\": 1, \"growth\": 48, \"health\": 100, \"status\": \"growing\", \"sunlight\": 4, \"timestamp\": \"2026-04-11T05:49:13.782433Z\"}, {\"day\": 13, \"water\": 100, \"growth\": 51.6, \"health\": 90, \"status\": \"growing\", \"sunlight\": 4, \"timestamp\": \"2026-04-11T05:49:16.430983Z\"}, {\"day\": 14, \"water\": 100, \"growth\": 54.8, \"health\": 80, \"status\": \"growing\", \"sunlight\": 4, \"timestamp\": \"2026-04-11T05:49:17.129707Z\"}, {\"day\": 15, \"water\": 100, \"growth\": 58, \"health\": 80, \"status\": \"growing\", \"sunlight\": 100, \"timestamp\": \"2026-04-11T05:49:20.344989Z\"}, {\"day\": 16, \"water\": 100, \"growth\": 61.2, \"health\": 80, \"status\": \"growing\", \"sunlight\": 100, \"timestamp\": \"2026-04-11T05:49:21.091035Z\"}, {\"day\": 17, \"water\": 0, \"growth\": 63.8, \"health\": 65, \"status\": \"growing\", \"sunlight\": 100, \"timestamp\": \"2026-04-11T05:49:23.470723Z\"}, {\"day\": 18, \"water\": 0, \"growth\": 65.8, \"health\": 50, \"status\": \"growing\", \"sunlight\": 100, \"timestamp\": \"2026-04-11T05:49:23.946273Z\"}, {\"day\": 19, \"water\": 51, \"growth\": 67.8, \"health\": 50, \"status\": \"growing\", \"sunlight\": 100, \"timestamp\": \"2026-04-11T05:49:26.706393Z\"}]', '2026-04-11 00:17:17', '2026-04-11 00:19:26');

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
CREATE TABLE IF NOT EXISTS `users` (
  `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT,
  `name` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `email` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `email_verified_at` timestamp NULL DEFAULT NULL,
  `password` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `remember_token` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `users_email_unique` (`email`)
) ENGINE=MyISAM AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `name`, `email`, `email_verified_at`, `password`, `remember_token`, `created_at`, `updated_at`) VALUES
(1, 'Default User', 'user@example.com', NULL, '$2y$12$lTRNUhVXYbVXbFkQ1p7jZ.jOhupTxPB4v2oKvFz63b/jCU/ENGqye', NULL, '2026-04-11 00:59:37', '2026-04-11 00:59:37');

-- --------------------------------------------------------

--
-- Table structure for table `user_plants`
--

DROP TABLE IF EXISTS `user_plants`;
CREATE TABLE IF NOT EXISTS `user_plants` (
  `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT,
  `user_id` bigint UNSIGNED NOT NULL,
  `plant_id` bigint UNSIGNED NOT NULL,
  `planted_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `growth_percentage` double NOT NULL DEFAULT '0',
  `growth_stage` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'Seed',
  `health` int NOT NULL DEFAULT '100',
  `last_watered_at` timestamp NULL DEFAULT NULL,
  `last_sunlight_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `history` json DEFAULT NULL,
  `age_days` int NOT NULL DEFAULT '0',
  `current_water_level` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'low',
  `current_sunlight_level` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'low',
  PRIMARY KEY (`id`),
  KEY `user_plants_user_id_foreign` (`user_id`),
  KEY `user_plants_plant_id_foreign` (`plant_id`)
) ENGINE=MyISAM AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `user_plants`
--

INSERT INTO `user_plants` (`id`, `user_id`, `plant_id`, `planted_at`, `growth_percentage`, `growth_stage`, `health`, `last_watered_at`, `last_sunlight_at`, `created_at`, `updated_at`, `history`, `age_days`, `current_water_level`, `current_sunlight_level`) VALUES
(6, 1, 7, '2026-04-11 01:58:35', 60, 'Growing', 0, '2026-04-11 01:59:35', '2026-04-11 01:59:57', '2026-04-11 01:58:35', '2026-04-11 02:00:26', '[{\"day\": 1, \"growth\": 0, \"health\": 95}, {\"day\": 2, \"growth\": 0, \"health\": 90}, {\"day\": 3, \"growth\": 0, \"health\": 85}, {\"day\": 4, \"growth\": 12, \"health\": 90}, {\"day\": 5, \"growth\": 24, \"health\": 95}, {\"day\": 6, \"growth\": 24, \"health\": 90}, {\"day\": 7, \"growth\": 24, \"health\": 85}, {\"day\": 8, \"growth\": 24, \"health\": 80}, {\"day\": 9, \"growth\": 24, \"health\": 75}, {\"day\": 10, \"growth\": 24, \"health\": 70}, {\"day\": 11, \"growth\": 36, \"health\": 75}, {\"day\": 12, \"growth\": 48, \"health\": 80}, {\"day\": 13, \"growth\": 60, \"health\": 85}, {\"day\": 14, \"growth\": 60, \"health\": 80}, {\"day\": 15, \"growth\": 60, \"health\": 75}, {\"day\": 16, \"growth\": 60, \"health\": 70}, {\"day\": 17, \"growth\": 60, \"health\": 65}, {\"day\": 18, \"growth\": 60, \"health\": 60}, {\"day\": 19, \"growth\": 60, \"health\": 55}, {\"day\": 20, \"growth\": 60, \"health\": 50}, {\"day\": 21, \"growth\": 60, \"health\": 45}, {\"day\": 22, \"growth\": 60, \"health\": 40}, {\"day\": 23, \"growth\": 60, \"health\": 35}, {\"day\": 24, \"growth\": 60, \"health\": 30}, {\"day\": 25, \"growth\": 60, \"health\": 25}, {\"day\": 26, \"growth\": 60, \"health\": 20}, {\"day\": 27, \"growth\": 60, \"health\": 15}, {\"day\": 28, \"growth\": 60, \"health\": 10}, {\"day\": 29, \"growth\": 60, \"health\": 5}, {\"day\": 30, \"growth\": 60, \"health\": 0}, {\"day\": 31, \"growth\": 60, \"health\": 0}, {\"day\": 32, \"growth\": 60, \"health\": 0}, {\"day\": 33, \"growth\": 60, \"health\": 0}, {\"day\": 34, \"growth\": 60, \"health\": 0}, {\"day\": 35, \"growth\": 60, \"health\": 0}, {\"day\": 36, \"growth\": 60, \"health\": 0}, {\"day\": 37, \"growth\": 60, \"health\": 0}, {\"day\": 38, \"growth\": 60, \"health\": 0}, {\"day\": 39, \"growth\": 60, \"health\": 0}, {\"day\": 40, \"growth\": 60, \"health\": 0}, {\"day\": 41, \"growth\": 60, \"health\": 0}]', 41, 'high', 'high');
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
