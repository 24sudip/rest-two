-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Nov 30, 2024 at 07:39 AM
-- Server version: 10.4.32-MariaDB
-- PHP Version: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `rest_two`
--

-- --------------------------------------------------------

--
-- Table structure for table `comments`
--

CREATE TABLE `comments` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `user_id` int(11) NOT NULL,
  `task_id` int(11) NOT NULL,
  `comment` text NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `departments`
--

CREATE TABLE `departments` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `user_id` int(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `departments`
--

INSERT INTO `departments` (`id`, `user_id`, `name`, `created_at`, `updated_at`) VALUES
(1, 1, 'HR Department', '2024-07-06 22:44:24', '2024-07-06 22:44:24'),
(2, 1, 'IT Department', '2024-07-06 23:57:53', '2024-07-06 23:57:53'),
(3, 1, 'MIS Department', '2024-07-06 23:58:18', '2024-07-06 23:58:18');

-- --------------------------------------------------------

--
-- Table structure for table `failed_jobs`
--

CREATE TABLE `failed_jobs` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `uuid` varchar(255) NOT NULL,
  `connection` text NOT NULL,
  `queue` text NOT NULL,
  `payload` longtext NOT NULL,
  `exception` longtext NOT NULL,
  `failed_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `jobs`
--

CREATE TABLE `jobs` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `queue` varchar(255) NOT NULL,
  `payload` longtext NOT NULL,
  `attempts` tinyint(3) UNSIGNED NOT NULL,
  `reserved_at` int(10) UNSIGNED DEFAULT NULL,
  `available_at` int(10) UNSIGNED NOT NULL,
  `created_at` int(10) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `migrations`
--

CREATE TABLE `migrations` (
  `id` int(10) UNSIGNED NOT NULL,
  `migration` varchar(255) NOT NULL,
  `batch` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `migrations`
--

INSERT INTO `migrations` (`id`, `migration`, `batch`) VALUES
(1, '0000_00_00_000000_create_websockets_statistics_entries_table', 1),
(2, '2014_10_12_000000_create_users_table', 1),
(3, '2014_10_12_100000_create_password_reset_tokens_table', 1),
(4, '2014_10_12_200000_add_two_factor_columns_to_users_table', 1),
(5, '2016_06_01_000001_create_oauth_auth_codes_table', 1),
(6, '2016_06_01_000002_create_oauth_access_tokens_table', 1),
(7, '2016_06_01_000003_create_oauth_refresh_tokens_table', 1),
(8, '2016_06_01_000004_create_oauth_clients_table', 1),
(9, '2016_06_01_000005_create_oauth_personal_access_clients_table', 1),
(10, '2019_08_19_000000_create_failed_jobs_table', 1),
(11, '2019_12_14_000001_create_personal_access_tokens_table', 1),
(12, '2024_06_21_104102_create_departments_table', 1),
(13, '2024_06_28_104526_laratrust_setup_tables', 1),
(14, '2024_07_01_104604_add_department_id_to_users_table', 1),
(15, '2024_07_11_053315_create_tasks_table', 1),
(16, '2024_07_11_071633_create_task_user_table', 1),
(17, '2024_07_14_095720_add_user_level_to_users_table', 1),
(18, '2024_07_28_132208_create_comments_table', 1),
(19, '2024_07_30_131945_create_notifications_table', 1),
(20, '2024_08_02_053951_create_jobs_table', 1);

-- --------------------------------------------------------

--
-- Table structure for table `notifications`
--

CREATE TABLE `notifications` (
  `id` char(36) NOT NULL,
  `type` varchar(255) NOT NULL,
  `notifiable_type` varchar(255) NOT NULL,
  `notifiable_id` bigint(20) UNSIGNED NOT NULL,
  `data` text NOT NULL,
  `read_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `oauth_access_tokens`
--

CREATE TABLE `oauth_access_tokens` (
  `id` varchar(100) NOT NULL,
  `user_id` bigint(20) UNSIGNED DEFAULT NULL,
  `client_id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(255) DEFAULT NULL,
  `scopes` text DEFAULT NULL,
  `revoked` tinyint(1) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `expires_at` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `oauth_access_tokens`
--

INSERT INTO `oauth_access_tokens` (`id`, `user_id`, `client_id`, `name`, `scopes`, `revoked`, `created_at`, `updated_at`, `expires_at`) VALUES
('253dedd6a79432812be4e7c5bd13b56021f3cbad4895ba1f5b2f8253f06df735a5388534335a1557', 1, 5, 'task_token', '[]', 1, '2024-08-13 05:12:08', '2024-08-13 05:12:08', '2025-08-13 11:12:08'),
('47668ce3e851619555e2a7b7a845a029b11594c70bbf293cff11a1d0e4e9b13d79b76a5a340cad89', 1, 3, 'task_token', '[]', 0, '2024-08-13 01:01:45', '2024-08-13 01:01:45', '2025-08-13 07:01:45'),
('b08bfc0472e0a6b146e583550c309e64c4dc460181829e4a6f5e44646534f78748c20c648faa0ad1', 1, 7, 'task_token', '[]', 1, '2024-08-14 05:08:38', '2024-08-14 05:08:40', '2025-08-14 11:08:38');

-- --------------------------------------------------------

--
-- Table structure for table `oauth_auth_codes`
--

CREATE TABLE `oauth_auth_codes` (
  `id` varchar(100) NOT NULL,
  `user_id` bigint(20) UNSIGNED NOT NULL,
  `client_id` bigint(20) UNSIGNED NOT NULL,
  `scopes` text DEFAULT NULL,
  `revoked` tinyint(1) NOT NULL,
  `expires_at` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `oauth_clients`
--

CREATE TABLE `oauth_clients` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `user_id` bigint(20) UNSIGNED DEFAULT NULL,
  `name` varchar(255) NOT NULL,
  `secret` varchar(100) DEFAULT NULL,
  `provider` varchar(255) DEFAULT NULL,
  `redirect` text NOT NULL,
  `personal_access_client` tinyint(1) NOT NULL,
  `password_client` tinyint(1) NOT NULL,
  `revoked` tinyint(1) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `oauth_clients`
--

INSERT INTO `oauth_clients` (`id`, `user_id`, `name`, `secret`, `provider`, `redirect`, `personal_access_client`, `password_client`, `revoked`, `created_at`, `updated_at`) VALUES
(1, NULL, 'Laravel Personal Access Client', 'RMHMTevNQ3EsJ3wB6CQJiXLGXWP7NtOOrd0Mtl7W', NULL, 'http://localhost', 1, 0, 0, '2024-08-13 00:58:50', '2024-08-13 00:58:50'),
(2, NULL, 'Laravel Password Grant Client', 'fSdVeM60JLjYdbpIMOZJ5bLpHpiFPhVUmPyxM0lD', 'users', 'http://localhost', 0, 1, 0, '2024-08-13 00:58:50', '2024-08-13 00:58:50'),
(3, NULL, 'Laravel Personal Access Client', 'mojKSukEhpatFHWBdmHH0bVhhf25jce45pDGZ3F4', NULL, 'http://localhost', 1, 0, 0, '2024-08-13 01:01:44', '2024-08-13 01:01:44'),
(4, NULL, 'Laravel Password Grant Client', 'THsASLooHZ05P2yANH7CUWC46WTqGTuTeRhnPePI', 'users', 'http://localhost', 0, 1, 0, '2024-08-13 01:01:44', '2024-08-13 01:01:44'),
(5, NULL, 'Laravel Personal Access Client', 'M6OOcKxvuyqEIZ2SQAiQk5xWTbXccLTsPgimTZiK', NULL, 'http://localhost', 1, 0, 0, '2024-08-13 05:12:07', '2024-08-13 05:12:07'),
(6, NULL, 'Laravel Password Grant Client', 'vKHNqoKDVYr9KhC4Isr4A18WEHLj6lN394SbyNDG', 'users', 'http://localhost', 0, 1, 0, '2024-08-13 05:12:07', '2024-08-13 05:12:07'),
(7, NULL, 'Laravel Personal Access Client', 'BheIPyBUEvvh1Oyv0sAXc3XhMd00DxwU3Hn2CHIq', NULL, 'http://localhost', 1, 0, 0, '2024-08-14 05:08:35', '2024-08-14 05:08:35'),
(8, NULL, 'Laravel Password Grant Client', 'XU9HPv1a3BI1ShfSWxdxHb7dteE5qOQ9MHaNeFjZ', 'users', 'http://localhost', 0, 1, 0, '2024-08-14 05:08:35', '2024-08-14 05:08:35');

-- --------------------------------------------------------

--
-- Table structure for table `oauth_personal_access_clients`
--

CREATE TABLE `oauth_personal_access_clients` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `client_id` bigint(20) UNSIGNED NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `oauth_personal_access_clients`
--

INSERT INTO `oauth_personal_access_clients` (`id`, `client_id`, `created_at`, `updated_at`) VALUES
(1, 1, '2024-08-13 00:58:50', '2024-08-13 00:58:50'),
(2, 3, '2024-08-13 01:01:44', '2024-08-13 01:01:44'),
(3, 5, '2024-08-13 05:12:07', '2024-08-13 05:12:07'),
(4, 7, '2024-08-14 05:08:35', '2024-08-14 05:08:35');

-- --------------------------------------------------------

--
-- Table structure for table `oauth_refresh_tokens`
--

CREATE TABLE `oauth_refresh_tokens` (
  `id` varchar(100) NOT NULL,
  `access_token_id` varchar(100) NOT NULL,
  `revoked` tinyint(1) NOT NULL,
  `expires_at` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `password_reset_tokens`
--

CREATE TABLE `password_reset_tokens` (
  `email` varchar(255) NOT NULL,
  `token` varchar(255) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `permissions`
--

CREATE TABLE `permissions` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(255) NOT NULL,
  `display_name` varchar(255) DEFAULT NULL,
  `description` varchar(255) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `permissions`
--

INSERT INTO `permissions` (`id`, `name`, `display_name`, `description`, `created_at`, `updated_at`) VALUES
(1, 'departments-create', 'Create Departments', 'Create Departments', '2024-07-04 23:14:07', '2024-07-04 23:14:07'),
(2, 'departments-read', 'Read Departments', 'Read Departments', '2024-07-04 23:14:07', '2024-07-04 23:14:07'),
(3, 'departments-update', 'Update Departments', 'Update Departments', '2024-07-04 23:14:07', '2024-07-04 23:14:07'),
(4, 'departments-delete', 'Delete Departments', 'Delete Departments', '2024-07-04 23:14:07', '2024-07-04 23:14:07'),
(5, 'roles-create', 'Create Roles', 'Create Roles', '2024-07-04 23:14:07', '2024-07-04 23:14:07'),
(6, 'roles-read', 'Read Roles', 'Read Roles', '2024-07-04 23:14:07', '2024-07-04 23:14:07'),
(7, 'roles-update', 'Update Roles', 'Update Roles', '2024-07-04 23:14:07', '2024-07-04 23:14:07'),
(8, 'roles-delete', 'Delete Roles', 'Delete Roles', '2024-07-04 23:14:07', '2024-07-04 23:14:07'),
(9, 'permissions-create', 'Create Permissions', 'Create Permissions', '2024-07-04 23:14:07', '2024-07-04 23:14:07'),
(10, 'permissions-read', 'Read Permissions', 'Read Permissions', '2024-07-04 23:14:07', '2024-07-04 23:14:07'),
(11, 'permissions-update', 'Update Permissions', 'Update Permissions', '2024-07-04 23:14:07', '2024-07-04 23:14:07'),
(12, 'permissions-delete', 'Delete Permissions', 'Delete Permissions', '2024-07-04 23:14:07', '2024-07-04 23:14:07'),
(13, 'users-create', 'Create Users', 'Create Users', '2024-07-04 23:14:07', '2024-07-04 23:14:07'),
(14, 'users-read', 'Read Users', 'Read Users', '2024-07-04 23:14:07', '2024-07-04 23:14:07'),
(15, 'users-update', 'Update Users', 'Update Users', '2024-07-04 23:14:07', '2024-07-04 23:14:07'),
(16, 'users-delete', 'Delete Users', 'Delete Users', '2024-07-04 23:14:07', '2024-07-04 23:14:07'),
(17, 'profile-read', 'Read Profile', 'Read Profile', '2024-07-04 23:14:07', '2024-07-04 23:14:07'),
(18, 'profile-update', 'Update Profile', 'Update Profile', '2024-07-04 23:14:07', '2024-07-04 23:14:07'),
(19, 'profile-password-update', 'Profile Password Update', 'Profile Password Update', '2024-07-05 20:49:16', '2024-07-05 20:49:16'),
(21, 'tasks-create', 'Tasks Create', 'Tasks Create', '2024-07-10 20:35:15', '2024-07-10 20:35:15'),
(22, 'tasks-read', 'Tasks Read', 'Tasks Read', '2024-07-10 20:35:15', '2024-07-10 20:35:15'),
(23, 'tasks-update', 'Tasks Update', 'Tasks Update', '2024-07-10 20:35:15', '2024-07-10 20:35:15'),
(24, 'tasks-delete', 'Tasks Delete', 'Tasks Delete', '2024-07-10 20:35:15', '2024-07-10 20:35:15'),
(25, 'inbox-read', 'Inbox Read', 'Inbox Read', '2024-07-14 19:08:44', '2024-07-14 19:08:44'),
(26, 'inbox-update', 'Inbox Update', 'Inbox Update', '2024-07-14 19:08:44', '2024-07-14 19:08:44'),
(27, 'completed-read', 'Completed Read', 'Completed Read', '2024-07-17 00:48:42', '2024-07-17 00:48:42'),
(28, 'completed-update', 'Completed Update', 'Completed Update', '2024-07-17 00:48:42', '2024-07-17 00:48:42'),
(29, 'subs-create', 'Subs Create', 'Subs Create', '2024-07-26 01:13:39', '2024-07-26 01:13:39'),
(30, 'subs-read', 'Subs Read', 'Subs Read', '2024-07-26 01:13:39', '2024-07-26 01:13:39'),
(31, 'subs-update', 'Subs Update', 'Subs Update', '2024-07-26 01:13:39', '2024-07-26 01:13:39'),
(32, 'subs-delete', 'Subs Delete', 'Subs Delete', '2024-07-26 01:13:39', '2024-07-26 01:13:39'),
(33, 'comments-create', 'Comments Create', 'Comments Create', '2024-07-28 02:13:39', '2024-07-28 02:13:39'),
(34, 'comments-read', 'Comments Read', 'Comments Read', '2024-07-28 02:13:39', '2024-07-28 02:13:39'),
(35, 'comments-update', 'Comments Update', 'Comments Update', '2024-07-28 02:13:39', '2024-07-28 02:13:39'),
(36, 'comments-delete', 'Comments Delete', 'Comments Delete', '2024-07-28 02:13:39', '2024-07-28 02:13:39'),
(37, 'reports-create', 'Reports Create', 'Reports Create', '2024-08-09 21:20:40', '2024-08-09 21:20:40'),
(38, 'reports-read', 'Reports Read', 'Reports Read', '2024-08-09 21:20:40', '2024-08-09 21:20:40');

-- --------------------------------------------------------

--
-- Table structure for table `permission_role`
--

CREATE TABLE `permission_role` (
  `permission_id` bigint(20) UNSIGNED NOT NULL,
  `role_id` bigint(20) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `permission_user`
--

CREATE TABLE `permission_user` (
  `permission_id` bigint(20) UNSIGNED NOT NULL,
  `user_id` bigint(20) UNSIGNED NOT NULL,
  `user_type` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `permission_user`
--

INSERT INTO `permission_user` (`permission_id`, `user_id`, `user_type`) VALUES
(1, 1, 'App\\Models\\User'),
(2, 1, 'App\\Models\\User'),
(3, 1, 'App\\Models\\User'),
(4, 1, 'App\\Models\\User'),
(5, 1, 'App\\Models\\User'),
(6, 1, 'App\\Models\\User'),
(7, 1, 'App\\Models\\User'),
(8, 1, 'App\\Models\\User'),
(9, 1, 'App\\Models\\User'),
(10, 1, 'App\\Models\\User'),
(11, 1, 'App\\Models\\User'),
(12, 1, 'App\\Models\\User'),
(13, 1, 'App\\Models\\User'),
(14, 1, 'App\\Models\\User'),
(15, 1, 'App\\Models\\User'),
(16, 1, 'App\\Models\\User'),
(17, 1, 'App\\Models\\User'),
(18, 1, 'App\\Models\\User'),
(19, 1, 'App\\Models\\User'),
(21, 1, 'App\\Models\\User'),
(22, 1, 'App\\Models\\User'),
(23, 1, 'App\\Models\\User'),
(24, 1, 'App\\Models\\User'),
(25, 1, 'App\\Models\\User'),
(26, 1, 'App\\Models\\User'),
(27, 1, 'App\\Models\\User'),
(28, 1, 'App\\Models\\User'),
(29, 1, 'App\\Models\\User'),
(30, 1, 'App\\Models\\User'),
(31, 1, 'App\\Models\\User'),
(32, 1, 'App\\Models\\User'),
(33, 1, 'App\\Models\\User'),
(34, 1, 'App\\Models\\User'),
(35, 1, 'App\\Models\\User'),
(36, 1, 'App\\Models\\User'),
(37, 1, 'App\\Models\\User'),
(38, 1, 'App\\Models\\User'),
(17, 2, 'App\\Models\\User'),
(18, 2, 'App\\Models\\User'),
(17, 3, 'App\\Models\\User'),
(18, 3, 'App\\Models\\User'),
(17, 4, 'App\\Models\\User'),
(18, 4, 'App\\Models\\User'),
(17, 7, 'App\\Models\\User'),
(18, 7, 'App\\Models\\User'),
(19, 7, 'App\\Models\\User'),
(21, 7, 'App\\Models\\User'),
(22, 7, 'App\\Models\\User'),
(23, 7, 'App\\Models\\User'),
(24, 7, 'App\\Models\\User'),
(33, 7, 'App\\Models\\User'),
(34, 7, 'App\\Models\\User'),
(35, 7, 'App\\Models\\User'),
(36, 7, 'App\\Models\\User'),
(37, 7, 'App\\Models\\User'),
(38, 7, 'App\\Models\\User'),
(17, 8, 'App\\Models\\User'),
(18, 8, 'App\\Models\\User'),
(19, 8, 'App\\Models\\User'),
(21, 8, 'App\\Models\\User'),
(22, 8, 'App\\Models\\User'),
(23, 8, 'App\\Models\\User'),
(24, 8, 'App\\Models\\User'),
(25, 8, 'App\\Models\\User'),
(26, 8, 'App\\Models\\User'),
(27, 8, 'App\\Models\\User'),
(28, 8, 'App\\Models\\User'),
(29, 8, 'App\\Models\\User'),
(30, 8, 'App\\Models\\User'),
(31, 8, 'App\\Models\\User'),
(32, 8, 'App\\Models\\User'),
(33, 8, 'App\\Models\\User'),
(34, 8, 'App\\Models\\User'),
(35, 8, 'App\\Models\\User'),
(36, 8, 'App\\Models\\User'),
(37, 8, 'App\\Models\\User'),
(38, 8, 'App\\Models\\User'),
(17, 9, 'App\\Models\\User'),
(18, 9, 'App\\Models\\User'),
(19, 9, 'App\\Models\\User'),
(25, 9, 'App\\Models\\User'),
(26, 9, 'App\\Models\\User'),
(27, 9, 'App\\Models\\User'),
(28, 9, 'App\\Models\\User'),
(33, 9, 'App\\Models\\User'),
(34, 9, 'App\\Models\\User'),
(35, 9, 'App\\Models\\User'),
(36, 9, 'App\\Models\\User'),
(37, 9, 'App\\Models\\User'),
(38, 9, 'App\\Models\\User'),
(17, 10, 'App\\Models\\User'),
(18, 10, 'App\\Models\\User'),
(19, 10, 'App\\Models\\User'),
(25, 10, 'App\\Models\\User'),
(26, 10, 'App\\Models\\User'),
(27, 10, 'App\\Models\\User'),
(28, 10, 'App\\Models\\User'),
(33, 10, 'App\\Models\\User'),
(34, 10, 'App\\Models\\User'),
(35, 10, 'App\\Models\\User'),
(36, 10, 'App\\Models\\User'),
(37, 10, 'App\\Models\\User'),
(38, 10, 'App\\Models\\User'),
(17, 11, 'App\\Models\\User'),
(18, 11, 'App\\Models\\User'),
(19, 11, 'App\\Models\\User'),
(21, 11, 'App\\Models\\User'),
(22, 11, 'App\\Models\\User'),
(23, 11, 'App\\Models\\User'),
(24, 11, 'App\\Models\\User'),
(33, 11, 'App\\Models\\User'),
(34, 11, 'App\\Models\\User'),
(35, 11, 'App\\Models\\User'),
(36, 11, 'App\\Models\\User'),
(37, 11, 'App\\Models\\User'),
(38, 11, 'App\\Models\\User'),
(17, 12, 'App\\Models\\User'),
(18, 12, 'App\\Models\\User'),
(19, 12, 'App\\Models\\User'),
(21, 12, 'App\\Models\\User'),
(22, 12, 'App\\Models\\User'),
(23, 12, 'App\\Models\\User'),
(24, 12, 'App\\Models\\User'),
(25, 12, 'App\\Models\\User'),
(26, 12, 'App\\Models\\User'),
(27, 12, 'App\\Models\\User'),
(28, 12, 'App\\Models\\User'),
(29, 12, 'App\\Models\\User'),
(30, 12, 'App\\Models\\User'),
(31, 12, 'App\\Models\\User'),
(32, 12, 'App\\Models\\User'),
(33, 12, 'App\\Models\\User'),
(34, 12, 'App\\Models\\User'),
(35, 12, 'App\\Models\\User'),
(36, 12, 'App\\Models\\User'),
(37, 12, 'App\\Models\\User'),
(38, 12, 'App\\Models\\User'),
(17, 13, 'App\\Models\\User'),
(18, 13, 'App\\Models\\User'),
(19, 13, 'App\\Models\\User'),
(25, 13, 'App\\Models\\User'),
(26, 13, 'App\\Models\\User'),
(27, 13, 'App\\Models\\User'),
(28, 13, 'App\\Models\\User'),
(33, 13, 'App\\Models\\User'),
(34, 13, 'App\\Models\\User'),
(35, 13, 'App\\Models\\User'),
(36, 13, 'App\\Models\\User'),
(37, 13, 'App\\Models\\User'),
(38, 13, 'App\\Models\\User');

-- --------------------------------------------------------

--
-- Table structure for table `personal_access_tokens`
--

CREATE TABLE `personal_access_tokens` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `tokenable_type` varchar(255) NOT NULL,
  `tokenable_id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(255) NOT NULL,
  `token` varchar(64) NOT NULL,
  `abilities` text DEFAULT NULL,
  `last_used_at` timestamp NULL DEFAULT NULL,
  `expires_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `roles`
--

CREATE TABLE `roles` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(255) NOT NULL,
  `display_name` varchar(255) DEFAULT NULL,
  `description` varchar(255) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `roles`
--

INSERT INTO `roles` (`id`, `name`, `display_name`, `description`, `created_at`, `updated_at`) VALUES
(1, 'admin', 'Admin', 'Admin', '2024-07-04 23:14:07', '2024-07-04 23:14:07'),
(2, 'director', 'Director', 'Director', '2024-07-04 23:14:08', '2024-07-04 23:14:08'),
(3, 'manager', 'Manager', 'Manager', '2024-07-04 23:14:08', '2024-07-04 23:14:08'),
(4, 'employee', 'Employee', 'Employee', '2024-07-04 23:14:08', '2024-07-04 23:14:08');

-- --------------------------------------------------------

--
-- Table structure for table `role_user`
--

CREATE TABLE `role_user` (
  `role_id` bigint(20) UNSIGNED NOT NULL,
  `user_id` bigint(20) UNSIGNED NOT NULL,
  `user_type` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `role_user`
--

INSERT INTO `role_user` (`role_id`, `user_id`, `user_type`) VALUES
(1, 1, 'App\\Models\\User'),
(2, 2, 'App\\Models\\User'),
(3, 3, 'App\\Models\\User'),
(4, 4, 'App\\Models\\User'),
(2, 7, 'App\\Models\\User'),
(3, 8, 'App\\Models\\User'),
(4, 9, 'App\\Models\\User'),
(4, 10, 'App\\Models\\User'),
(2, 11, 'App\\Models\\User'),
(3, 12, 'App\\Models\\User'),
(4, 13, 'App\\Models\\User');

-- --------------------------------------------------------

--
-- Table structure for table `tasks`
--

CREATE TABLE `tasks` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `user_id` int(11) NOT NULL,
  `parent_id` int(11) NOT NULL DEFAULT 0,
  `department_id` int(11) NOT NULL,
  `performed_by` int(11) NOT NULL DEFAULT 0,
  `title` varchar(255) NOT NULL,
  `description` text NOT NULL,
  `priority` varchar(255) NOT NULL,
  `start_date` varchar(255) NOT NULL,
  `end_date` varchar(255) NOT NULL,
  `progress` int(11) NOT NULL DEFAULT 0,
  `result` text DEFAULT NULL,
  `file` varchar(255) DEFAULT NULL,
  `status` tinyint(1) NOT NULL DEFAULT 0,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `task_user`
--

CREATE TABLE `task_user` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `task_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `department_id` int(11) NOT NULL DEFAULT 0,
  `user_level` int(11) NOT NULL DEFAULT 0,
  `name` varchar(255) NOT NULL,
  `email` varchar(255) NOT NULL,
  `email_verified_at` timestamp NULL DEFAULT NULL,
  `password` varchar(255) NOT NULL,
  `two_factor_secret` text DEFAULT NULL,
  `two_factor_recovery_codes` text DEFAULT NULL,
  `two_factor_confirmed_at` timestamp NULL DEFAULT NULL,
  `remember_token` varchar(100) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `department_id`, `user_level`, `name`, `email`, `email_verified_at`, `password`, `two_factor_secret`, `two_factor_recovery_codes`, `two_factor_confirmed_at`, `remember_token`, `created_at`, `updated_at`) VALUES
(1, 0, 0, 'Admin', 'admin@app.com', NULL, '$2y$12$OxzP9j6mncejnC/kWv3ycOSaEIyvehTIefSpnBKhHD6bSc8jb/uu6', NULL, NULL, NULL, NULL, '2024-07-04 23:14:08', '2024-08-11 21:54:00'),
(2, 0, 1, 'Director', 'director@app.com', NULL, '$2y$12$7xc8hwN5XaffwdlPeu3n2eVS3q3uVJVz0aTJTLfyRRicldYnq4fp6', NULL, NULL, NULL, NULL, '2024-07-04 23:14:08', '2024-07-13 23:24:46'),
(3, 0, 2, 'Manager', 'manager@app.com', NULL, '$2y$12$4L4GOAz2D3ArLWumOkD6L.0EQqyOZUbVOj.r1sJ6sXW8EUppp9pXa', NULL, NULL, NULL, NULL, '2024-07-04 23:14:08', '2024-07-13 23:24:24'),
(4, 0, 3, 'Employee', 'employee@app.com', NULL, '$2y$12$u4x8Y01DoAzkqVcpmmeTR.sGxs9T5JDRQjcZnap6kogohbMIhEJ1G', NULL, NULL, NULL, NULL, '2024-07-04 23:14:09', '2024-07-13 23:23:53'),
(7, 2, 1, 'IT Director', 'itdirector@app.com', NULL, '$2y$12$14xnl.iTrYp2deDwwU.O/uyLhbACoVcIn3N1qWJ8NcgPKVlJ75W2K', NULL, NULL, NULL, NULL, '2024-07-10 20:40:43', '2024-08-09 21:22:21'),
(8, 2, 2, 'IT Manager', 'itmanager@app.com', NULL, '$2y$12$.2s.vQBGRG54CRcvqZQeHODCSvQP/zKK5lm0tFfb.MKocOo78W9Iq', NULL, NULL, NULL, NULL, '2024-07-10 20:43:21', '2024-08-09 21:23:13'),
(9, 2, 3, 'IT Employee 1', 'itemployee1@app.com', NULL, '$2y$12$xAir5KVRPqvoa5WnmpQCW.hpVS26MK87pIYuLJy0qfprhQTxQ8gua', NULL, NULL, NULL, NULL, '2024-07-10 20:47:18', '2024-08-09 21:25:10'),
(10, 2, 3, 'IT Employee 2', 'itemployee2@app.com', NULL, '$2y$12$ge.n0QCp8LblvaKrPh5quO5ro.dznn3cMVvHBhe2DDIHI4ASYnMsu', NULL, NULL, NULL, NULL, '2024-07-10 20:49:46', '2024-08-09 21:25:56'),
(11, 1, 1, 'HR Director', 'hrdirector@app.com', NULL, '$2y$12$icklAvCr4kai0b/N.kgeNuKcMMYCv0j537AVGfF6mK4geu8R5DKpa', NULL, NULL, NULL, NULL, '2024-07-10 20:52:21', '2024-08-09 21:26:46'),
(12, 1, 2, 'HR Manager', 'hrmanager@app.com', NULL, '$2y$12$Ku2xqq603i8Z8DMQbicDQO0aIh8jopKeuW0vF57yoC/ZgLFqKiSEu', NULL, NULL, NULL, NULL, '2024-07-10 20:55:21', '2024-08-09 21:27:35'),
(13, 1, 3, 'HR Employee', 'hremployee@app.com', NULL, '$2y$12$eTCnv/UTr8dcgzzhLXQDdOPpstWBF73PZA3pxk5QFO4HL2uCqJJrG', NULL, NULL, NULL, NULL, '2024-07-10 20:57:36', '2024-08-09 21:28:13');

-- --------------------------------------------------------

--
-- Table structure for table `websockets_statistics_entries`
--

CREATE TABLE `websockets_statistics_entries` (
  `id` int(10) UNSIGNED NOT NULL,
  `app_id` varchar(255) NOT NULL,
  `peak_connection_count` int(11) NOT NULL,
  `websocket_message_count` int(11) NOT NULL,
  `api_message_count` int(11) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `comments`
--
ALTER TABLE `comments`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `departments`
--
ALTER TABLE `departments`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `failed_jobs`
--
ALTER TABLE `failed_jobs`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `failed_jobs_uuid_unique` (`uuid`);

--
-- Indexes for table `jobs`
--
ALTER TABLE `jobs`
  ADD PRIMARY KEY (`id`),
  ADD KEY `jobs_queue_index` (`queue`);

--
-- Indexes for table `migrations`
--
ALTER TABLE `migrations`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `notifications`
--
ALTER TABLE `notifications`
  ADD PRIMARY KEY (`id`),
  ADD KEY `notifications_notifiable_type_notifiable_id_index` (`notifiable_type`,`notifiable_id`);

--
-- Indexes for table `oauth_access_tokens`
--
ALTER TABLE `oauth_access_tokens`
  ADD PRIMARY KEY (`id`),
  ADD KEY `oauth_access_tokens_user_id_index` (`user_id`);

--
-- Indexes for table `oauth_auth_codes`
--
ALTER TABLE `oauth_auth_codes`
  ADD PRIMARY KEY (`id`),
  ADD KEY `oauth_auth_codes_user_id_index` (`user_id`);

--
-- Indexes for table `oauth_clients`
--
ALTER TABLE `oauth_clients`
  ADD PRIMARY KEY (`id`),
  ADD KEY `oauth_clients_user_id_index` (`user_id`);

--
-- Indexes for table `oauth_personal_access_clients`
--
ALTER TABLE `oauth_personal_access_clients`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `oauth_refresh_tokens`
--
ALTER TABLE `oauth_refresh_tokens`
  ADD PRIMARY KEY (`id`),
  ADD KEY `oauth_refresh_tokens_access_token_id_index` (`access_token_id`);

--
-- Indexes for table `password_reset_tokens`
--
ALTER TABLE `password_reset_tokens`
  ADD PRIMARY KEY (`email`);

--
-- Indexes for table `permissions`
--
ALTER TABLE `permissions`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `permissions_name_unique` (`name`);

--
-- Indexes for table `permission_role`
--
ALTER TABLE `permission_role`
  ADD PRIMARY KEY (`permission_id`,`role_id`),
  ADD KEY `permission_role_role_id_foreign` (`role_id`);

--
-- Indexes for table `permission_user`
--
ALTER TABLE `permission_user`
  ADD PRIMARY KEY (`user_id`,`permission_id`,`user_type`),
  ADD KEY `permission_user_permission_id_foreign` (`permission_id`);

--
-- Indexes for table `personal_access_tokens`
--
ALTER TABLE `personal_access_tokens`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `personal_access_tokens_token_unique` (`token`),
  ADD KEY `personal_access_tokens_tokenable_type_tokenable_id_index` (`tokenable_type`,`tokenable_id`);

--
-- Indexes for table `roles`
--
ALTER TABLE `roles`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `roles_name_unique` (`name`);

--
-- Indexes for table `role_user`
--
ALTER TABLE `role_user`
  ADD PRIMARY KEY (`user_id`,`role_id`,`user_type`),
  ADD KEY `role_user_role_id_foreign` (`role_id`);

--
-- Indexes for table `tasks`
--
ALTER TABLE `tasks`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `task_user`
--
ALTER TABLE `task_user`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `users_email_unique` (`email`);

--
-- Indexes for table `websockets_statistics_entries`
--
ALTER TABLE `websockets_statistics_entries`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `comments`
--
ALTER TABLE `comments`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `departments`
--
ALTER TABLE `departments`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `failed_jobs`
--
ALTER TABLE `failed_jobs`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `jobs`
--
ALTER TABLE `jobs`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `migrations`
--
ALTER TABLE `migrations`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=21;

--
-- AUTO_INCREMENT for table `oauth_clients`
--
ALTER TABLE `oauth_clients`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT for table `oauth_personal_access_clients`
--
ALTER TABLE `oauth_personal_access_clients`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `permissions`
--
ALTER TABLE `permissions`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=39;

--
-- AUTO_INCREMENT for table `personal_access_tokens`
--
ALTER TABLE `personal_access_tokens`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `roles`
--
ALTER TABLE `roles`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `tasks`
--
ALTER TABLE `tasks`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `task_user`
--
ALTER TABLE `task_user`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=14;

--
-- AUTO_INCREMENT for table `websockets_statistics_entries`
--
ALTER TABLE `websockets_statistics_entries`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `permission_role`
--
ALTER TABLE `permission_role`
  ADD CONSTRAINT `permission_role_permission_id_foreign` FOREIGN KEY (`permission_id`) REFERENCES `permissions` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `permission_role_role_id_foreign` FOREIGN KEY (`role_id`) REFERENCES `roles` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `permission_user`
--
ALTER TABLE `permission_user`
  ADD CONSTRAINT `permission_user_permission_id_foreign` FOREIGN KEY (`permission_id`) REFERENCES `permissions` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `role_user`
--
ALTER TABLE `role_user`
  ADD CONSTRAINT `role_user_role_id_foreign` FOREIGN KEY (`role_id`) REFERENCES `roles` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
