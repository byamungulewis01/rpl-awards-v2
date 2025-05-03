-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: May 03, 2025 at 04:54 PM
-- Server version: 8.0.33
-- PHP Version: 8.3.15

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `rpl_awards`
--

-- --------------------------------------------------------

--
-- Table structure for table `cache`
--

CREATE TABLE `cache` (
  `key` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `value` mediumtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `expiration` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `cache_locks`
--

CREATE TABLE `cache_locks` (
  `key` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `owner` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `expiration` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `candidates`
--

CREATE TABLE `candidates` (
  `id` bigint UNSIGNED NOT NULL,
  `category_id` bigint UNSIGNED NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `image` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `code` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `order` int NOT NULL DEFAULT '1',
  `status` enum('active','inactive') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'active',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `candidates`
--

INSERT INTO `candidates` (`id`, `category_id`, `name`, `image`, `code`, `order`, `status`, `created_at`, `updated_at`) VALUES
(1, 3, 'DARCHO Novic', 'candidates/WNtbvi8lxZZH8KGdKh7PhAINEW1KYhV2txcqnNcx.jpg', '21', 1, 'active', '2025-04-30 10:26:23', '2025-04-30 10:36:52'),
(2, 3, 'GATERA Moussa', 'candidates/PswxuEKz3qMP7qEixyzT4HYBxkVPdzlLfxNQra7Y.jpg', '23', 7, 'active', '2025-04-30 10:27:05', '2025-04-30 10:51:21'),
(3, 3, 'HABIMANA Sosthene', 'candidates/j2c5jAXfxlAOYPzN6VkukbbseIJ2afW8rqcrZbHg.jpg', '33', 8, 'active', '2025-04-30 10:27:33', '2025-04-30 10:44:58'),
(4, 3, 'KARISA Alain', 'candidates/3dHLy9AjZDGQxMagql0bmraoRecnYDCr4snEdX9q.jpg', '34', 5, 'active', '2025-04-30 10:39:05', '2025-04-30 10:44:43'),
(5, 3, 'AHFAMIA Lotfi', 'candidates/5F43dbPuwlpZlRu6611xklRHwzLZdBwfd1fFLyzk.jpg', '29', 3, 'active', '2025-04-30 10:39:40', '2025-04-30 10:54:01'),
(6, 3, 'MASHAMI. Vincent', 'candidates/lF0icxw317xE2CR8vpAPRJEpnMKf38ZBeZm8kRNe.jpg', '22', 10, 'active', '2025-04-30 10:40:10', '2025-04-30 10:45:09'),
(7, 3, 'NIYONGABO Amars', 'candidates/zJkYPObEnomwX35u4z8M6NqwCbWm2p2wYSaWaMwG.jpg', '44', 6, 'active', '2025-04-30 10:41:05', '2025-04-30 10:45:01'),
(8, 3, 'Roberto Oliveira', 'candidates/Rq6sN7AXxpoxjXx9paUWlmOB0BFpSoMz2gAlehN9.jpg', '41', 2, 'active', '2025-04-30 10:41:57', '2025-04-30 10:44:01'),
(9, 3, 'MBARUSHIMANA Shaban', 'candidates/cStzc8HVqp2oML2G1reZ96tVccmd9brEmcz5ddML.jpg', '32', 4, 'active', '2025-04-30 10:43:15', '2025-04-30 10:44:40'),
(10, 3, 'MALICK Wade', 'candidates/PgT87gb7Fl4r7DkiDQIFCbxiz25cruDxDphVGv8i.jpg', '25', 9, 'active', '2025-04-30 10:43:46', '2025-04-30 10:51:25'),
(12, 1, 'BIGIRIMANA Abedi', 'candidates/cfsmCk2B5YMQdeyEvaNN5Hx1JE7nZrEcoGFR5Ar7.jpg', '28', 28, 'active', '2025-04-30 11:12:43', '2025-04-30 11:45:47'),
(13, 1, 'AKAYEZU Jean Bosco', 'candidates/zdr7SbFY906XQrYnAl7KK4ik91KRhXDY4DwW5BRC.jpg', '24', 24, 'active', '2025-04-30 11:13:16', '2025-04-30 11:13:16'),
(14, 1, 'AKBAR Muderi', 'candidates/M6a8mQNRhJERIJpssYbtWmfIKxsdVR12ZSe1pkp7.jpg', '10', 10, 'active', '2025-04-30 11:13:52', '2025-04-30 11:13:52'),
(15, 1, 'ANI Elijah', 'candidates/QSK6NDMCWpNfSSW5kKic2OofQxMxSrKSx2HBrdHK.jpg', '290', 29, 'active', '2025-04-30 11:14:41', '2025-04-30 11:45:47'),
(16, 1, 'AGYENIM Boateng', 'candidates/pCXiQXX19DoyyMf2Xhl757yVTCnKLuSzDqnsttoE.jpg', '122', 17, 'active', '2025-04-30 11:15:19', '2025-04-30 11:15:19'),
(17, 1, 'BRIRINGIRO Gilbert', 'candidates/I7LQkgKdBtGnwL3bbw9j5Tj9YBQ50DvgVCdLJbp6.jpg', '223', 23, 'active', '2025-04-30 11:15:53', '2025-04-30 11:26:04'),
(18, 1, 'DAUDA Yussif Seidu', 'candidates/1oB2K8ih9vsmOMpVUbyLHo0bl1cmNLVyTyqYzsZR.jpg', '111', 26, 'active', '2025-04-30 11:16:36', '2025-04-30 11:16:36'),
(19, 1, 'FALL Ngagne', 'candidates/U7k0NCY2C8MG0jO6YgYWDpdSwQFaFquQelHGH0ZV.jpg', '121', 1, 'active', '2025-04-30 11:17:02', '2025-04-30 11:17:34'),
(20, 1, 'FRANKLIN Onyeabor', 'candidates/o4Wf9MgXNL1pLHZk2eCelzzZNwBZTs91AJPOcjn1.jpg', '331', 25, 'active', '2025-04-30 11:18:20', '2025-04-30 11:18:20'),
(21, 1, 'HABIMANA Yves', 'candidates/i3Mj9xeF1sWYbCme4WVxkhmQ52cE6q5kDU2JM3Ld.jpg', '81', 8, 'active', '2025-04-30 11:18:45', '2025-04-30 11:18:45'),
(22, 1, 'JORDAN DIBUMBA Nzao', 'candidates/Mkkkx5wSbMJhDz83Q366DmdmMrUGnspqDi6yULcO.jpg', '18', 18, 'active', '2025-04-30 11:19:27', '2025-04-30 11:19:27'),
(23, 1, 'JOSEPH Sackey', 'candidates/wnrZVb7gQMplqTbJpGzCxwgwvEADFCFtffjHrXHH.jpg', '124', 20, 'active', '2025-04-30 11:25:40', '2025-04-30 11:25:51'),
(24, 1, 'KHADIME Ndiaye', 'candidates/XmHq1RIlp6BjzUJVYTKCbLPthqAi4Xtq7r5zurXo.jpg', '333', 14, 'active', '2025-04-30 11:29:52', '2025-04-30 11:30:00'),
(25, 1, 'MASUDI Narcisse', 'candidates/XMDze7kygN2CmD1i5wQume84uuOguuezRfbOhTQm.jpg', '166', 16, 'active', '2025-04-30 11:30:32', '2025-04-30 11:30:32'),
(26, 1, 'MUHIRE Kevin', 'candidates/j1cbqBaIwSta4O5y7XGuFvP49QYaSz6MrtXtaZLO.jpg', '202', 2, 'active', '2025-04-30 11:31:16', '2025-04-30 11:31:16'),
(27, 1, 'MSANGA Henry', 'candidates/ZUH2GLTlCUhf0OyzIUeXWBebqfOI1xFd6AyV5b6q.jpg', '128', 12, 'active', '2025-04-30 11:32:45', '2025-04-30 11:32:45'),
(28, 1, 'NDAYISHIMIYE Richard', 'candidates/1F1dmGMqZQHOLM2vXCD5XI8jQC4BDBc8MbuIY0at.jpg', '220', 22, 'active', '2025-04-30 11:33:28', '2025-04-30 11:33:28'),
(29, 1, 'NIYIGENA Clement', 'candidates/pMaVkVjiFyt074XefsoCoZCsCfLIQPJQjOKx6XlK.jpg', '404', 4, 'active', '2025-04-30 11:34:00', '2025-04-30 11:34:00'),
(30, 1, 'NIYOMUGABO Cloude', 'candidates/WzaxKMMaiy66FMRbJY5iffSrv2K3TFm5iOmztblU.jpg', '130', 13, 'active', '2025-04-30 11:34:33', '2025-04-30 11:34:33'),
(31, 1, 'EMMANUEL Okwi', 'candidates/DSeAms07hMuk8HVBmdmR2X4SJHQOu0e7UXipxH56.jpg', '707', 7, 'active', '2025-04-30 11:35:29', '2025-04-30 11:35:29'),
(32, 1, 'ISHIMWE Jean Pierre', 'candidates/BG9xk6hGxllVajrEG50sJjdQb3KQBpcOzLWdtAIz.jpg', '150', 15, 'active', '2025-04-30 11:35:58', '2025-04-30 11:35:58'),
(33, 1, 'POTTY MASIMANGO Fiston', 'candidates/falJiroIqoenV9cFRCjwjITs9BM9eTWecfQmv4Yw.jpg', '118', 11, 'active', '2025-04-30 11:36:51', '2025-04-30 11:36:51'),
(34, 1, 'RUBONEKA Jean Bosco', 'candidates/MsJyYu6pxDAEbpbUB9fI77fEKIBut9DKj8YwQDmv.jpg', '303', 3, 'active', '2025-04-30 11:37:51', '2025-04-30 11:37:51'),
(35, 1, 'USENI Seraphin', 'candidates/kj54WIvwvITua0N6DltcMktifNYRc1tRQoCcbAnK.jpg', '505', 5, 'active', '2025-04-30 11:38:35', '2025-04-30 11:38:35'),
(36, 1, 'SUNDAY Inemesit', 'candidates/13SmGhoOa4JyOfEuQpCsmQy0W7DW5wL2qypSiJi2.jpg', '190', 19, 'active', '2025-04-30 11:39:11', '2025-04-30 11:39:11'),
(37, 1, 'UMAR Abba', 'candidates/XIiQXZxyEStUyzoqHbFb5JNv5HcY5xgazjrygEPZ.jpg', '606', 6, 'active', '2025-04-30 11:39:45', '2025-04-30 11:39:45'),
(38, 1, 'USABIMANA olivier', 'candidates/b57T0JfiLiAjBuDGajQUv9nnxdl76HJHfPxhRuVn.jpg', '909', 9, 'active', '2025-04-30 11:40:11', '2025-04-30 11:40:11'),
(39, 1, 'UWAMUKIZA Obed', 'candidates/wrQ3PLBZ6pl3E63WNu1Py7sX33d0Vmmd1Q9xHAaT.jpg', '291', 27, 'active', '2025-04-30 11:41:06', '2025-04-30 11:45:52'),
(40, 1, 'VICTOR Murdah', 'candidates/jY9BrWcoEUpftPCa083UnyfHDYsHJUAauxWSTEsq.jpg', '302', 30, 'active', '2025-04-30 11:42:29', '2025-04-30 11:42:29'),
(41, 1, 'youssuou DIAGNE', 'candidates/wM086DqLZ7MJ4LIJwskBl5RCJW65ASavVwDrxJVD.jpg', '210', 21, 'active', '2025-04-30 11:43:27', '2025-04-30 11:43:27');

-- --------------------------------------------------------

--
-- Table structure for table `categories`
--

CREATE TABLE `categories` (
  `id` bigint UNSIGNED NOT NULL,
  `league` enum('men','women') COLLATE utf8mb4_unicode_ci NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `description` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `status` enum('active','inactive') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'active',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `categories`
--

INSERT INTO `categories` (`id`, `league`, `name`, `description`, `status`, `created_at`, `updated_at`) VALUES
(1, 'men', 'Umukinnyi mwiza wa shampiyona', 'Umukinnyi mwiza wa shampiyona', 'active', '2025-04-30 09:53:16', '2025-05-03 14:38:54'),
(2, 'men', 'Igitego cyiza', 'Igitego cyiza', 'active', '2025-04-30 09:53:36', '2025-05-03 14:41:49'),
(3, 'men', 'Umutoza mwiza', 'Umutoza mwiza', 'active', '2025-04-30 09:53:50', '2025-05-03 14:41:29'),
(4, 'men', 'Umukinnyi mwiza ukiri muto', 'Umukinnyi mwiza ukiri muto', 'active', '2025-04-30 09:54:17', '2025-05-03 14:40:41'),
(5, 'men', 'Umunyezamu mwiza', 'Umunyezamu mwiza', 'active', '2025-04-30 09:54:29', '2025-05-03 14:41:04'),
(7, 'women', 'Umukinnyi mwiza wa shampiyona', 'Umukinnyi mwiza wa shampiyona', 'active', '2025-04-30 09:54:56', '2025-05-03 14:42:40'),
(8, 'women', 'Umutoza mwiza', 'Umutoza mwiza', 'active', '2025-04-30 09:55:12', '2025-05-03 14:43:02');

-- --------------------------------------------------------

--
-- Table structure for table `failed_jobs`
--

CREATE TABLE `failed_jobs` (
  `id` bigint UNSIGNED NOT NULL,
  `uuid` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `connection` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `queue` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `payload` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `exception` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `failed_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `jobs`
--

CREATE TABLE `jobs` (
  `id` bigint UNSIGNED NOT NULL,
  `queue` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `payload` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `attempts` tinyint UNSIGNED NOT NULL,
  `reserved_at` int UNSIGNED DEFAULT NULL,
  `available_at` int UNSIGNED NOT NULL,
  `created_at` int UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `job_batches`
--

CREATE TABLE `job_batches` (
  `id` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `total_jobs` int NOT NULL,
  `pending_jobs` int NOT NULL,
  `failed_jobs` int NOT NULL,
  `failed_job_ids` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `options` mediumtext COLLATE utf8mb4_unicode_ci,
  `cancelled_at` int DEFAULT NULL,
  `created_at` int NOT NULL,
  `finished_at` int DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `migrations`
--

CREATE TABLE `migrations` (
  `id` int UNSIGNED NOT NULL,
  `migration` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `batch` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `migrations`
--

INSERT INTO `migrations` (`id`, `migration`, `batch`) VALUES
(1, '0001_01_01_000001_create_cache_table', 1),
(2, '0001_01_01_000002_create_jobs_table', 1),
(3, '2025_03_16_000000_create_users_table', 1),
(19, '2025_04_29_214251_create_personal_access_tokens_table', 8),
(23, '2025_04_27_114503_create_categories_table', 9),
(24, '2025_04_27_195720_create_candidates_table', 9),
(25, '2025_05_02_200407_create_payments_table', 10),
(26, '2025_05_02_203643_create_votes_table', 10);

-- --------------------------------------------------------

--
-- Table structure for table `password_reset_tokens`
--

CREATE TABLE `password_reset_tokens` (
  `email` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `token` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `payments`
--

CREATE TABLE `payments` (
  `id` bigint UNSIGNED NOT NULL,
  `candidate_id` bigint UNSIGNED NOT NULL,
  `phone_number` varchar(20) COLLATE utf8mb4_unicode_ci NOT NULL,
  `payment_method` varchar(20) COLLATE utf8mb4_unicode_ci NOT NULL,
  `amount` int NOT NULL,
  `votes` int NOT NULL,
  `status` varchar(20) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'pending',
  `transaction_id` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `payment_details` json DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `payments`
--

INSERT INTO `payments` (`id`, `candidate_id`, `phone_number`, `payment_method`, `amount`, `votes`, `status`, `transaction_id`, `payment_details`, `created_at`, `updated_at`) VALUES
(1, 26, '0785522140', 'mtn', 2000, 10, 'initiated', 'VP17462206188601', NULL, '2025-05-02 19:16:58', '2025-05-02 19:16:58'),
(2, 5, '0785589976', 'mtn', 800, 4, 'initiated', 'VP17462206598733', NULL, '2025-05-02 19:17:39', '2025-05-02 19:17:39'),
(3, 19, '0785589776', 'mtn', 3400, 17, 'initiated', 'VP17462208685859', NULL, '2025-05-02 19:21:08', '2025-05-02 19:21:08'),
(4, 38, '0785534231', 'mtn', 600, 3, 'initiated', 'VP17462210221715', NULL, '2025-05-02 19:23:42', '2025-05-02 19:23:42'),
(5, 28, '0785436135', 'mtn', 600, 3, 'initiated', 'VP17462213831554', NULL, '2025-05-02 19:29:43', '2025-05-02 19:29:43'),
(6, 40, '0785522140', 'airtel', 1200, 6, 'initiated', 'VP17462214007686', NULL, '2025-05-02 19:30:00', '2025-05-02 19:30:00'),
(7, 17, '0785522112', 'mtn', 400, 2, 'initiated', 'VP17462214194680', NULL, '2025-05-02 19:30:19', '2025-05-02 19:30:19'),
(8, 24, '0789818378', 'mtn', 800, 4, 'initiated', 'VP17462214342822', NULL, '2025-05-02 19:30:34', '2025-05-02 19:30:34'),
(9, 19, '0785522140', 'mtn', 7800, 39, 'initiated', 'VP17462214652309', NULL, '2025-05-02 19:31:05', '2025-05-02 19:31:05'),
(10, 24, '0786655432', 'airtel', 1000, 5, 'initiated', 'VP17462888745299', NULL, '2025-05-03 14:14:34', '2025-05-03 14:14:34');

-- --------------------------------------------------------

--
-- Table structure for table `personal_access_tokens`
--

CREATE TABLE `personal_access_tokens` (
  `id` bigint UNSIGNED NOT NULL,
  `tokenable_type` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `tokenable_id` bigint UNSIGNED NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `token` varchar(64) COLLATE utf8mb4_unicode_ci NOT NULL,
  `abilities` text COLLATE utf8mb4_unicode_ci,
  `last_used_at` timestamp NULL DEFAULT NULL,
  `expires_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `sessions`
--

CREATE TABLE `sessions` (
  `id` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `user_id` bigint UNSIGNED DEFAULT NULL,
  `ip_address` varchar(45) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `user_agent` text COLLATE utf8mb4_unicode_ci,
  `payload` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `last_activity` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `sessions`
--

INSERT INTO `sessions` (`id`, `user_id`, `ip_address`, `user_agent`, `payload`, `last_activity`) VALUES
('0t1hZXlLQcmF6r51gPE5Y5tmwn4e37w95jvIteJK', NULL, '127.0.0.1', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoibDBOWDR4Z1I0VmhRT3lJWVdvQVJJampPZUxPakJYcU95bXhPR3dzUCI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MjU6Imh0dHA6Ly9ycGwtYXdhcmRzLXYyLnRlc3QiO31zOjY6Il9mbGFzaCI7YToyOntzOjM6Im9sZCI7YTowOnt9czozOiJuZXciO2E6MDp7fX19', 1746252841),
('2eqkg6c95KsUnQb1KtJWJPrvgmua8H5aioXlgpxK', 1, '127.0.0.1', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36', 'YTo0OntzOjY6Il90b2tlbiI7czo0MDoiVWxhaXpiYWRSd2l6QmVxYlNCN0xDREJqN05tdndTT0hFNTlaNzJMWiI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MzY6Imh0dHA6Ly9ycGwtYXdhcmRzLXYyLnRlc3QvY2F0ZWdvcmllcyI7fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fXM6NTA6ImxvZ2luX3dlYl81OWJhMzZhZGRjMmIyZjk0MDE1ODBmMDE0YzdmNThlYTRlMzA5ODlkIjtpOjE7fQ==', 1746224261),
('e3Lx5JEHs17SOXgSpgwsE4fFi84ZWhCR1qRPmBaF', NULL, '127.0.0.1', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiWThueDN1cGxtNkxLVDRxT1lJUEJvaDN6b2JFSjhGM0hQNHVsSXlISCI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MjU6Imh0dHA6Ly9ycGwtYXdhcmRzLXYyLnRlc3QiO31zOjY6Il9mbGFzaCI7YToyOntzOjM6Im9sZCI7YTowOnt9czozOiJuZXciO2E6MDp7fX19', 1746290618),
('NQbIPBtnXNd6PUeFF7d7aRcvUyc0ZCprBqsBdzlo', NULL, '127.0.0.1', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoidTQ0Wng3N0NTNDdWbTRQemhQYktsVU5GOXFhaVRTdk5UczBsYkJVWCI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MjU6Imh0dHA6Ly9ycGwtYXdhcmRzLXYyLnRlc3QiO31zOjY6Il9mbGFzaCI7YToyOntzOjM6Im9sZCI7YTowOnt9czozOiJuZXciO2E6MDp7fX19', 1746279147),
('qbL2VWGKbQVgTmbt2WrLIkgZtLLdIwP2BQno61vk', NULL, '127.0.0.1', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoibWNzZk9hYkIyMzZCYnFCQlB0VGxVbWJzZXZEZEM1SmpYRFJaRDkzUyI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MzE6Imh0dHA6Ly9ycGwtYXdhcmRzLXYyLnRlc3QvbG9naW4iO31zOjY6Il9mbGFzaCI7YToyOntzOjM6Im9sZCI7YTowOnt9czozOiJuZXciO2E6MDp7fX19', 1746261422),
('uBgF2Gosp4PQUaiJttFTTirXhQ10HY2ajWdZ3nNW', 1, '127.0.0.1', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36', 'YTo0OntzOjY6Il90b2tlbiI7czo0MDoieVUwSFZJRk1oSW1TWXZFeDRQWnk5QThnbVl1SnhFSzUzMzdqTlA4VSI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MjU6Imh0dHA6Ly9ycGwtYXdhcmRzLXYyLnRlc3QiO31zOjY6Il9mbGFzaCI7YToyOntzOjM6Im9sZCI7YTowOnt9czozOiJuZXciO2E6MDp7fX1zOjUwOiJsb2dpbl93ZWJfNTliYTM2YWRkYzJiMmY5NDAxNTgwZjAxNGM3ZjU4ZWE0ZTMwOTg5ZCI7aToxO30=', 1746290582),
('UUD1T5ebkO7CceUw9y4OZ5Ak2IPC1UlvisV6OhWi', NULL, '127.0.0.1', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36', 'YTo0OntzOjY6Il90b2tlbiI7czo0MDoiV0gwNXlvVHBJUmN2SjNpbnk4VEdjOHAxSDA0SDUyRVRxNzNCb2FlSSI7czozOiJ1cmwiO2E6MTp7czo4OiJpbnRlbmRlZCI7czozNjoiaHR0cDovL3JwbC1hd2FyZHMtdjIudGVzdC9jYXRlZ29yaWVzIjt9czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MjU6Imh0dHA6Ly9ycGwtYXdhcmRzLXYyLnRlc3QiO31zOjY6Il9mbGFzaCI7YToyOntzOjM6Im9sZCI7YTowOnt9czozOiJuZXciO2E6MDp7fX19', 1746253316);

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `id` bigint UNSIGNED NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `email` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `phone` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `role` enum('super_admin','admin','inspector') CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `status` enum('active','inactive') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'active',
  `email_verified_at` timestamp NULL DEFAULT NULL,
  `password` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `last_login` timestamp NULL DEFAULT NULL,
  `remember_token` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `name`, `email`, `phone`, `role`, `status`, `email_verified_at`, `password`, `last_login`, `remember_token`, `created_at`, `updated_at`) VALUES
(1, 'BYAMUNGU Lewis', 'byamungulewis@gmail.com', '0785436135', 'super_admin', 'active', '2025-04-27 05:29:07', '$2y$12$agIcW8GRsLUNNOoQJKQ9..Xnj5rM6i6bn94zwCQyw00ug70efW1kS', '2025-05-03 14:42:40', '34zdmckh4BcpFokHDK6cpYnzsd0MBfF7SG1MCPOQE1Mg7JL8KoOwYPSRD2xH', '2025-04-27 05:29:08', '2025-05-03 14:42:40'),
(3, 'Kylie Ayers', 'duziqymem@mailinator.com', '+1 (317) 114-8376', 'admin', 'active', NULL, '$2y$12$VjyWZTfm5lIy.GU/gM/dVuo4M0soUTgsyi2ZSD.zsFtZLGX6GWV4a', NULL, NULL, '2025-04-27 05:39:44', '2025-04-27 05:39:44'),
(4, 'Sigourney Waller', 'lusihuje@mailinator.com', '+1 (273) 518-1257', 'inspector', 'inactive', NULL, '$2y$12$n.lydz2zjsknpp.cvIVYZ.pu0CZzNR1gvdzsUybflPLsxirF3dldy', NULL, NULL, '2025-04-27 05:39:50', '2025-04-30 08:21:11'),
(6, 'Ginger Morales', 'tafoxadu@mailinator.com', '+1 (673) 674-9352', 'admin', 'active', NULL, '$2y$12$Mc4mPRI7HjGjRtT7iEWkWeXwAYmMnZw8wWudqS4AlT7zwemHnYROy', NULL, NULL, '2025-04-27 06:04:00', '2025-04-27 06:04:00'),
(15, 'Jules MURERWA', 'julesmurerwa@gmail.com', '0786665544', 'inspector', 'active', NULL, '$2y$12$msqckoulmV5aTTUhNS6y..xrs8PVw27oABvqRffUlPhDyMOwSmjWq', NULL, NULL, '2025-04-30 08:20:49', '2025-04-30 08:20:49');

-- --------------------------------------------------------

--
-- Table structure for table `votes`
--

CREATE TABLE `votes` (
  `id` bigint UNSIGNED NOT NULL,
  `candidate_id` bigint UNSIGNED NOT NULL,
  `payment_id` bigint UNSIGNED NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `votes`
--

INSERT INTO `votes` (`id`, `candidate_id`, `payment_id`, `created_at`, `updated_at`) VALUES
(10, 26, 1, '2025-05-02 19:16:58', '2025-05-02 19:16:58'),
(14, 5, 2, '2025-05-02 19:17:39', '2025-05-02 19:17:39'),
(15, 19, 3, '2025-05-02 19:21:08', '2025-05-02 19:21:08'),
(16, 38, 4, '2025-05-02 19:23:42', '2025-05-02 19:23:42'),
(17, 28, 5, '2025-05-02 19:29:43', '2025-05-02 19:29:43'),
(18, 40, 6, '2025-05-02 19:30:00', '2025-05-02 19:30:00'),
(19, 17, 7, '2025-05-02 19:30:19', '2025-05-02 19:30:19'),
(20, 24, 8, '2025-05-02 19:30:34', '2025-05-02 19:30:34'),
(21, 19, 9, '2025-05-02 19:31:05', '2025-05-02 19:31:05'),
(22, 24, 10, '2025-05-03 14:14:34', '2025-05-03 14:14:34');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `cache`
--
ALTER TABLE `cache`
  ADD PRIMARY KEY (`key`);

--
-- Indexes for table `cache_locks`
--
ALTER TABLE `cache_locks`
  ADD PRIMARY KEY (`key`);

--
-- Indexes for table `candidates`
--
ALTER TABLE `candidates`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `candidates_code_unique` (`code`),
  ADD KEY `candidates_category_id_foreign` (`category_id`);

--
-- Indexes for table `categories`
--
ALTER TABLE `categories`
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
-- Indexes for table `job_batches`
--
ALTER TABLE `job_batches`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `migrations`
--
ALTER TABLE `migrations`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `password_reset_tokens`
--
ALTER TABLE `password_reset_tokens`
  ADD PRIMARY KEY (`email`);

--
-- Indexes for table `payments`
--
ALTER TABLE `payments`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `payments_transaction_id_unique` (`transaction_id`),
  ADD KEY `payments_candidate_id_foreign` (`candidate_id`);

--
-- Indexes for table `personal_access_tokens`
--
ALTER TABLE `personal_access_tokens`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `personal_access_tokens_token_unique` (`token`),
  ADD KEY `personal_access_tokens_tokenable_type_tokenable_id_index` (`tokenable_type`,`tokenable_id`);

--
-- Indexes for table `sessions`
--
ALTER TABLE `sessions`
  ADD PRIMARY KEY (`id`),
  ADD KEY `sessions_user_id_index` (`user_id`),
  ADD KEY `sessions_last_activity_index` (`last_activity`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `users_email_unique` (`email`),
  ADD UNIQUE KEY `users_phone_unique` (`phone`);

--
-- Indexes for table `votes`
--
ALTER TABLE `votes`
  ADD PRIMARY KEY (`id`),
  ADD KEY `votes_candidate_id_foreign` (`candidate_id`),
  ADD KEY `votes_payment_id_foreign` (`payment_id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `candidates`
--
ALTER TABLE `candidates`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=42;

--
-- AUTO_INCREMENT for table `categories`
--
ALTER TABLE `categories`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- AUTO_INCREMENT for table `failed_jobs`
--
ALTER TABLE `failed_jobs`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `jobs`
--
ALTER TABLE `jobs`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `migrations`
--
ALTER TABLE `migrations`
  MODIFY `id` int UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=27;

--
-- AUTO_INCREMENT for table `payments`
--
ALTER TABLE `payments`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT for table `personal_access_tokens`
--
ALTER TABLE `personal_access_tokens`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=16;

--
-- AUTO_INCREMENT for table `votes`
--
ALTER TABLE `votes`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=23;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `candidates`
--
ALTER TABLE `candidates`
  ADD CONSTRAINT `candidates_category_id_foreign` FOREIGN KEY (`category_id`) REFERENCES `categories` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `payments`
--
ALTER TABLE `payments`
  ADD CONSTRAINT `payments_candidate_id_foreign` FOREIGN KEY (`candidate_id`) REFERENCES `candidates` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `votes`
--
ALTER TABLE `votes`
  ADD CONSTRAINT `votes_candidate_id_foreign` FOREIGN KEY (`candidate_id`) REFERENCES `candidates` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `votes_payment_id_foreign` FOREIGN KEY (`payment_id`) REFERENCES `payments` (`id`) ON DELETE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
