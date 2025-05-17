-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: May 17, 2025 at 07:47 AM
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
  `order` int NOT NULL DEFAULT '1',
  `status` enum('active','inactive') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'active',
  `stats` json DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `candidates`
--

INSERT INTO `candidates` (`id`, `category_id`, `name`, `image`, `order`, `status`, `stats`, `created_at`, `updated_at`) VALUES
(1, 3, 'DARCHO Novic', 'candidates/WNtbvi8lxZZH8KGdKh7PhAINEW1KYhV2txcqnNcx.jpg', 1, 'active', NULL, '2025-04-30 10:26:23', '2025-04-30 10:36:52'),
(2, 3, 'GATERA Moussa', 'candidates/PswxuEKz3qMP7qEixyzT4HYBxkVPdzlLfxNQra7Y.jpg', 7, 'active', NULL, '2025-04-30 10:27:05', '2025-04-30 10:51:21'),
(3, 3, 'HABIMANA Sosthene', 'candidates/j2c5jAXfxlAOYPzN6VkukbbseIJ2afW8rqcrZbHg.jpg', 8, 'active', NULL, '2025-04-30 10:27:33', '2025-04-30 10:44:58'),
(4, 3, 'KARISA Alain', 'candidates/3dHLy9AjZDGQxMagql0bmraoRecnYDCr4snEdX9q.jpg', 5, 'active', NULL, '2025-04-30 10:39:05', '2025-04-30 10:44:43'),
(5, 3, 'AHFAMIA Lotfi', 'candidates/5F43dbPuwlpZlRu6611xklRHwzLZdBwfd1fFLyzk.jpg', 3, 'active', NULL, '2025-04-30 10:39:40', '2025-04-30 10:54:01'),
(6, 3, 'MASHAMI. Vincent', 'candidates/lF0icxw317xE2CR8vpAPRJEpnMKf38ZBeZm8kRNe.jpg', 10, 'active', NULL, '2025-04-30 10:40:10', '2025-04-30 10:45:09'),
(7, 3, 'NIYONGABO Amars', 'candidates/zJkYPObEnomwX35u4z8M6NqwCbWm2p2wYSaWaMwG.jpg', 6, 'active', NULL, '2025-04-30 10:41:05', '2025-04-30 10:45:01'),
(8, 3, 'Roberto Oliveira', 'candidates/Rq6sN7AXxpoxjXx9paUWlmOB0BFpSoMz2gAlehN9.jpg', 2, 'active', NULL, '2025-04-30 10:41:57', '2025-04-30 10:44:01'),
(9, 3, 'MBARUSHIMANA Shaban', 'candidates/cStzc8HVqp2oML2G1reZ96tVccmd9brEmcz5ddML.jpg', 4, 'active', NULL, '2025-04-30 10:43:15', '2025-04-30 10:44:40'),
(10, 3, 'MALICK Wade', 'candidates/PgT87gb7Fl4r7DkiDQIFCbxiz25cruDxDphVGv8i.jpg', 9, 'active', NULL, '2025-04-30 10:43:46', '2025-04-30 10:51:25'),
(12, 1, 'BIGIRIMANA Abedi', 'candidates/cfsmCk2B5YMQdeyEvaNN5Hx1JE7nZrEcoGFR5Ar7.jpg', 28, 'active', NULL, '2025-04-30 11:12:43', '2025-04-30 11:45:47'),
(13, 1, 'AKAYEZU Jean Bosco', 'candidates/zdr7SbFY906XQrYnAl7KK4ik91KRhXDY4DwW5BRC.jpg', 24, 'active', NULL, '2025-04-30 11:13:16', '2025-04-30 11:13:16'),
(14, 1, 'AKBAR Muderi', 'candidates/M6a8mQNRhJERIJpssYbtWmfIKxsdVR12ZSe1pkp7.jpg', 10, 'active', NULL, '2025-04-30 11:13:52', '2025-04-30 11:13:52'),
(15, 1, 'ANI Elijah', 'candidates/QSK6NDMCWpNfSSW5kKic2OofQxMxSrKSx2HBrdHK.jpg', 29, 'active', NULL, '2025-04-30 11:14:41', '2025-04-30 11:45:47'),
(16, 1, 'AGYENIM Boateng', 'candidates/pCXiQXX19DoyyMf2Xhl757yVTCnKLuSzDqnsttoE.jpg', 17, 'active', NULL, '2025-04-30 11:15:19', '2025-04-30 11:15:19'),
(17, 1, 'BRIRINGIRO Gilbert', 'candidates/I7LQkgKdBtGnwL3bbw9j5Tj9YBQ50DvgVCdLJbp6.jpg', 23, 'active', NULL, '2025-04-30 11:15:53', '2025-04-30 11:26:04'),
(18, 1, 'DAUDA Yussif Seidu', 'candidates/1oB2K8ih9vsmOMpVUbyLHo0bl1cmNLVyTyqYzsZR.jpg', 26, 'active', NULL, '2025-04-30 11:16:36', '2025-04-30 11:16:36'),
(19, 1, 'FALL Ngagne', 'candidates/U7k0NCY2C8MG0jO6YgYWDpdSwQFaFquQelHGH0ZV.jpg', 1, 'active', NULL, '2025-04-30 11:17:02', '2025-04-30 11:17:34'),
(20, 1, 'FRANKLIN Onyeabor', 'candidates/o4Wf9MgXNL1pLHZk2eCelzzZNwBZTs91AJPOcjn1.jpg', 25, 'active', NULL, '2025-04-30 11:18:20', '2025-04-30 11:18:20'),
(21, 1, 'HABIMANA Yves', 'candidates/i3Mj9xeF1sWYbCme4WVxkhmQ52cE6q5kDU2JM3Ld.jpg', 8, 'active', NULL, '2025-04-30 11:18:45', '2025-04-30 11:18:45'),
(22, 1, 'JORDAN DIBUMBA Nzao', 'candidates/Mkkkx5wSbMJhDz83Q366DmdmMrUGnspqDi6yULcO.jpg', 18, 'active', NULL, '2025-04-30 11:19:27', '2025-04-30 11:19:27'),
(23, 1, 'JOSEPH Sackey', 'candidates/wnrZVb7gQMplqTbJpGzCxwgwvEADFCFtffjHrXHH.jpg', 20, 'active', NULL, '2025-04-30 11:25:40', '2025-04-30 11:25:51'),
(24, 1, 'KHADIME Ndiaye', 'candidates/XmHq1RIlp6BjzUJVYTKCbLPthqAi4Xtq7r5zurXo.jpg', 14, 'active', NULL, '2025-04-30 11:29:52', '2025-04-30 11:30:00'),
(25, 1, 'MASUDI Narcisse', 'candidates/XMDze7kygN2CmD1i5wQume84uuOguuezRfbOhTQm.jpg', 16, 'active', NULL, '2025-04-30 11:30:32', '2025-04-30 11:30:32'),
(26, 1, 'MUHIRE Kevin', 'candidates/j1cbqBaIwSta4O5y7XGuFvP49QYaSz6MrtXtaZLO.jpg', 2, 'active', NULL, '2025-04-30 11:31:16', '2025-04-30 11:31:16'),
(27, 1, 'MSANGA Henry', 'candidates/ZUH2GLTlCUhf0OyzIUeXWBebqfOI1xFd6AyV5b6q.jpg', 12, 'active', NULL, '2025-04-30 11:32:45', '2025-04-30 11:32:45'),
(28, 1, 'NDAYISHIMIYE Richard', 'candidates/1F1dmGMqZQHOLM2vXCD5XI8jQC4BDBc8MbuIY0at.jpg', 22, 'active', NULL, '2025-04-30 11:33:28', '2025-04-30 11:33:28'),
(29, 1, 'NIYIGENA Clement', 'candidates/pMaVkVjiFyt074XefsoCoZCsCfLIQPJQjOKx6XlK.jpg', 4, 'active', NULL, '2025-04-30 11:34:00', '2025-04-30 11:34:00'),
(30, 1, 'NIYOMUGABO Cloude', 'candidates/WzaxKMMaiy66FMRbJY5iffSrv2K3TFm5iOmztblU.jpg', 13, 'active', NULL, '2025-04-30 11:34:33', '2025-04-30 11:34:33'),
(31, 1, 'EMMANUEL Okwi', 'candidates/DSeAms07hMuk8HVBmdmR2X4SJHQOu0e7UXipxH56.jpg', 7, 'active', NULL, '2025-04-30 11:35:29', '2025-04-30 11:35:29'),
(32, 1, 'ISHIMWE Jean Pierre', 'candidates/BG9xk6hGxllVajrEG50sJjdQb3KQBpcOzLWdtAIz.jpg', 15, 'active', NULL, '2025-04-30 11:35:58', '2025-04-30 11:35:58'),
(33, 1, 'POTTY MASIMANGO Fiston', 'candidates/falJiroIqoenV9cFRCjwjITs9BM9eTWecfQmv4Yw.jpg', 11, 'active', NULL, '2025-04-30 11:36:51', '2025-04-30 11:36:51'),
(34, 1, 'RUBONEKA Jean Bosco', 'candidates/MsJyYu6pxDAEbpbUB9fI77fEKIBut9DKj8YwQDmv.jpg', 3, 'active', NULL, '2025-04-30 11:37:51', '2025-04-30 11:37:51'),
(35, 1, 'USENI Seraphin', 'candidates/kj54WIvwvITua0N6DltcMktifNYRc1tRQoCcbAnK.jpg', 5, 'active', NULL, '2025-04-30 11:38:35', '2025-04-30 11:38:35'),
(36, 1, 'SUNDAY Inemesit', 'candidates/13SmGhoOa4JyOfEuQpCsmQy0W7DW5wL2qypSiJi2.jpg', 19, 'active', NULL, '2025-04-30 11:39:11', '2025-04-30 11:39:11'),
(37, 1, 'UMAR Abba', 'candidates/XIiQXZxyEStUyzoqHbFb5JNv5HcY5xgazjrygEPZ.jpg', 6, 'active', NULL, '2025-04-30 11:39:45', '2025-04-30 11:39:45'),
(38, 1, 'USABIMANA olivier', 'candidates/b57T0JfiLiAjBuDGajQUv9nnxdl76HJHfPxhRuVn.jpg', 9, 'active', NULL, '2025-04-30 11:40:11', '2025-04-30 11:40:11'),
(39, 1, 'UWAMUKIZA Obed', 'candidates/wrQ3PLBZ6pl3E63WNu1Py7sX33d0Vmmd1Q9xHAaT.jpg', 27, 'active', NULL, '2025-04-30 11:41:06', '2025-04-30 11:45:52'),
(40, 1, 'VICTOR Murdah', 'candidates/jY9BrWcoEUpftPCa083UnyfHDYsHJUAauxWSTEsq.jpg', 30, 'active', NULL, '2025-04-30 11:42:29', '2025-04-30 11:42:29'),
(41, 1, 'youssuou DIAGNE', 'candidates/wM086DqLZ7MJ4LIJwskBl5RCJW65ASavVwDrxJVD.jpg', 21, 'active', NULL, '2025-04-30 11:43:27', '2025-04-30 11:43:27'),
(45, 4, 'ADAMA Bagayogo', 'candidates/1747467699_WhatsApp Image 2025-05-16 at 20.21.30.jpeg', 7, 'active', NULL, '2025-05-17 05:41:39', '2025-05-17 05:46:21'),
(46, 4, 'MUTUNZI Darcy', 'candidates/1747467733_WhatsApp Image 2025-05-16 at 20.21.31 (1).jpeg', 1, 'active', NULL, '2025-05-17 05:42:13', '2025-05-17 05:43:49'),
(47, 4, 'HABIMANA Fils Francois', 'candidates/1747467762_WhatsApp Image 2025-05-16 at 20.21.31.jpeg', 6, 'active', NULL, '2025-05-17 05:42:42', '2025-05-17 05:46:21'),
(48, 4, 'NIYO David', 'candidates/1747467784_WhatsApp Image 2025-05-16 at 20.21.32 (1).jpeg', 2, 'active', NULL, '2025-05-17 05:43:04', '2025-05-17 05:43:54'),
(49, 4, 'NDAYISHIMIYE Didier', 'candidates/1747467823_WhatsApp Image 2025-05-16 at 20.21.32.jpeg', 8, 'active', NULL, '2025-05-17 05:43:43', '2025-05-17 05:46:13'),
(50, 4, 'POTTY Masimango Fiston', 'candidates/1747467868_WhatsApp Image 2025-05-16 at 20.21.33.jpeg', 4, 'active', NULL, '2025-05-17 05:44:28', '2025-05-17 05:46:10'),
(51, 4, 'SULTAN Bob', 'candidates/1747467891_WhatsApp Image 2025-05-16 at 20.21.34 (1).jpeg', 3, 'active', NULL, '2025-05-17 05:44:51', '2025-05-17 05:46:00'),
(52, 4, 'USENI Seraphin', 'candidates/1747467909_WhatsApp Image 2025-05-16 at 20.21.34.jpeg', 5, 'active', NULL, '2025-05-17 05:45:09', '2025-05-17 05:46:18');

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
(5, 'men', 'Umunyezamu mwiza', 'Umunyezamu mwiza', 'active', '2025-04-30 09:54:29', '2025-05-03 14:41:04');

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
(27, '2025_05_06_055347_create_u_s_s_d_sessions_table', 11),
(28, '2024_03_21_create_news_table', 12),
(29, '2025_05_11_172323_create_settings_table', 13),
(30, '2025_05_02_200407_create_payments_table', 14),
(32, '2025_05_02_203643_create_votes_table', 15);

-- --------------------------------------------------------

--
-- Table structure for table `news`
--

CREATE TABLE `news` (
  `id` bigint UNSIGNED NOT NULL,
  `title` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `slug` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `image` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `short_description` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `long_description` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `status` enum('draft','published') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'draft',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `news`
--

INSERT INTO `news` (`id`, `title`, `slug`, `image`, `short_description`, `long_description`, `status`, `created_at`, `updated_at`) VALUES
(3, 'Abakunzi b\'umupira w\'amaguru bazagira uruhare mu gutora abakinnyi bazahembwa muri RPL Awards 2025', 'abakunzi-bumupira-wamaguru-bazagira-uruhare-mu-gutora-abakinnyi-bazahembwa-muri-rpl-awards-2025', '/news/1746998961_fans.jpeg', 'Mu birori byo guhemba abakinnyi bitwaye neza mu mwaka w\'imikino wa 2024/2025 byiswe Rwanda Premier League Awards 2025, abakunzi b\'umupira w\'amaguru mu Rwanda ndetse no ku isi hose nabo bazagira uruhare mukwitorera abazahabwa ibhembobitandukanye.\r\nBitandukanye n\'umwaka ushize aho akana k\'impuguke ariko kagize uruhare 100% mu gutora abatsindiye ibihembo mu mwaka w\'imikino wa 2023/2024,', '<p><span style=\"color: rgb(55, 65, 81);\">Mu birori byo guhemba abakinnyi bitwaye neza mu mwaka w\'imikino wa 2024/2025 byiswe Rwanda Premier League Awards 2025, abakunzi b\'umupira w\'amaguru mu Rwanda ndetse no ku isi hose nabo bazagira uruhare mukwitorera abazahabwa ibhembobitandukanye.</span></p><p><span style=\"color: rgb(55, 65, 81);\">Bitandukanye n\'umwaka ushize aho akana k\'impuguke ariko kagize uruhare 100% mu gutora abatsindiye ibihembo mu mwaka w\'imikino wa 2023/2024, kuri iyi nshuro, abafana babyifuza bazatora hakoreshejwe uburyo bw\'ikoranabuhanga banyuze ku rubugarwa www.rplawards.rw ndetse no kuri USSD bazagira uruhare mu gutora abakinnyi mu byiciro byose bihatanirwa.</span></p><p><span style=\"color: rgb(55, 65, 81);\">Amajwi y\'abakunzi b\'umupira azahesha uzatsinda amahirwe ku kigero cya 15%. Ibibyakozwe mu rwego rwo kugira ngo abafana nabo bihitiremo nk\'abakurikiranye imikinoya shampiyona.</span></p><p><span style=\"color: rgb(55, 65, 81);\">Mu rwego rwo kugabanya amarangamutima muri iki gikorwa hashyizweho amafarangamake atuma utora aha agaciro iki gikorwa kandi agahesha umukinnyi koko abonaubikwiriye.</span></p><p><span style=\"color: rgb(55, 65, 81);\">Biteganyijwe ko abasaga 500 aribo bazitabira ibi birori biteganyijwe kuzaba ku itari ya30 Gicurasi 2025 aho hazahembwa ibyiciro 9 mu bagabo ndetse na 4 mu barin\'abategarugori.</span></p>', 'draft', '2025-05-11 10:16:51', '2025-05-11 19:29:21'),
(4, 'Rwanda Premier League igihe gutanga ibihembo kubakinnyi bitwaye neza', 'rwanda-premier-league-igihe-gutanga-ibihembo-kubakinnyi-bitwaye-neza', '/news/1746998905_awards1.jpg', 'Rwanda Premier League (RPL) igiye guhemba abakinnyi bitwaye neza mu mwakaw\'imikino wa 2024/2025. Ni ibihembo bigiye gutangwa ku nshuro ya kabiriyikurikiranya nyuma yaho umwaka w\'imikino wa 2023/2024 hari hahembwe abakinnyibitwaye neza.\r\n\r\nIbi bihembo bizatangirwa mu birori byiza bibereye ijisho bizitabirwa n\'abakinnyi, abayobozi b\'amakipe, abatoza, abayobora amashyirahamwe y\'imikino itandukanye mu Rwanda, abayobozi mu nego za leta zitandukanye, abikorera ndetse n\'itangazamakuru. Abakinnyi bazahembwa bazaba bari mu byiciro', '<p><span style=\"color: rgb(55, 65, 81);\">Rwanda Premier League (RPL) igiye guhemba abakinnyi bitwaye neza mu mwakaw\'imikino wa 2024/2025. Ni ibihembo bigiye gutangwa ku nshuro ya kabiriyikurikiranya nyuma yaho umwaka w\'imikino wa 2023/2024 hari hahembwe abakinnyibitwaye neza.</span></p><p><span style=\"color: rgb(55, 65, 81);\">Ibi bihembo bizatangirwa mu birori byiza bibereye ijisho bizitabirwa n\'abakinnyi, abayobozi b\'amakipe, abatoza, abayobora amashyirahamwe y\'imikino itandukanye mu Rwanda, abayobozi mu nego za leta zitandukanye, abikorera ndetse n\'itangazamakuru. Abakinnyi bazahembwa bazaba bari mu byiciro bitandukanye ariby:</span></p><ul><li><span style=\"color: rgb(55, 65, 81);\">Umukinnyi mwiza wa shampiyona</span></li><li><span style=\"color: rgb(55, 65, 81);\">Umukinnyi watsinze ibitego byinshi</span></li><li><span style=\"color: rgb(55, 65, 81);\">Umukinnyi mwiza ukiri muto</span></li><li><span style=\"color: rgb(55, 65, 81);\">Umunyezamu mwiza</span></li><li><span style=\"color: rgb(55, 65, 81);\">Igitego cyiza</span></li><li><span style=\"color: rgb(55, 65, 81);\">Abakinnyi 11 beza ba shampiyona</span></li><li><span style=\"color: rgb(55, 65, 81);\">Umutoza mwiza</span></li><li><span style=\"color: rgb(55, 65, 81);\">Umusifuzi mwiza</span></li></ul><p><span style=\"color: rgb(55, 65, 81);\">Usibye ibi byiciro bizahembwa mubagabo, uyu mwaka hazanahembwa abakinnyi bezamu cyiciro cy\'abari n\'abategarugori mu rwego rwo kuzamura urwego rw\'irushanwaryabo. Muri iki kiciro hazahembwa:</span></p><ul><li><span style=\"color: rgb(55, 65, 81);\">Umukinnyi mwiza wa shampiyona</span></li><li><span style=\"color: rgb(55, 65, 81);\">Umukinnyi watsinze ibitego byinshi</span></li><li><span style=\"color: rgb(55, 65, 81);\">Umutoza mwiza</span></li><li><span style=\"color: rgb(55, 65, 81);\">Umusifuzi mwiza.</span></li></ul><p><span style=\"color: rgb(55, 65, 81);\">Biteganyijwe ko abasaga 500 aribo bazitabira ibi birori biteganyijwe kuzaba ku itari ya30 Gicurasi 2025.</span></p>', 'draft', '2025-05-10 10:20:32', '2025-05-11 19:28:25'),
(5, 'Rwanda Premier League Awards 2025 izagaragaramo abahanzi', 'rwanda-premier-league-awards-2025-izagaragaramo-abahanzi', '/news/1746999004_rwandan-traditional-dance.jpg', 'Mu birori byo guhemba abakinnyi bitwaye neza muri uyu mwaka w\'imikino wa 2024/2025, hazagaragaramo abahanzi bazasusurutsa abazaba bitabiriye ibi birori.\r\nNi ibirori bizarangwa no guhuza cyane umuco nyarwanda aho hazitabira itorero gakondo, hazanitabira kandi abana bazagaragaza impano zabo ndetse n\'amwe mumazi y\'abahanzibakunzwe mu Rwanda.', '<p><span style=\"color: rgb(55, 65, 81);\">Mu birori byo guhemba abakinnyi bitwaye neza muri uyu mwaka w\'imikino wa 2024/2025, hazagaragaramo abahanzi bazasusurutsa abazaba bitabiriye ibi birori.</span></p><p><span style=\"color: rgb(55, 65, 81);\">Ni ibirori bizarangwa no guhuza cyane umuco nyarwanda aho hazitabira itorero gakondo, hazanitabira kandi abana bazagaragaza impano zabo ndetse n\'amwe mumazi y\'abahanzibakunzwe mu Rwanda.</span></p><p><span style=\"color: rgb(55, 65, 81);\">Ni ibirori biteganyijwe kuzaba kuwa 30 Gicurasi 2025 bikazitabirwa n\'abagera kuir 500.</span></p>', 'draft', '2025-05-12 19:30:04', '2025-05-11 19:30:04');

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
  `category_id` bigint UNSIGNED NOT NULL,
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

INSERT INTO `payments` (`id`, `candidate_id`, `category_id`, `phone_number`, `payment_method`, `amount`, `votes`, `status`, `transaction_id`, `payment_details`, `created_at`, `updated_at`) VALUES
(1, 26, 1, '0785522140', 'mtn', 400, 4, 'initiated', 'VP17469892359716', NULL, '2025-05-11 16:47:15', '2025-05-11 16:47:15'),
(2, 6, 3, '0785522140', 'mtn', 1000, 10, 'initiated', 'VP17469894561868', NULL, '2025-05-11 16:50:56', '2025-05-11 16:50:56'),
(3, 22, 1, '0785438999', 'mtn', 100, 1, 'initiated', '03fa3b32-dca6-4790-92b3-906586808f14', NULL, '2025-05-11 17:06:22', '2025-05-11 17:06:22'),
(4, 26, 1, '0785436130', 'mtn', 100, 1, 'successful', 'ff94b87a-8460-4fda-9a8a-e70be484040e', '{\"data\": {\"fee\": 2.3, \"ref\": \"ff94b87a-8460-4fda-9a8a-e70be484040e\", \"kind\": \"CASHIN\", \"amount\": 100, \"client\": \"0785436135\", \"status\": \"successful\", \"merchant\": \"G3MR8I\", \"metadata\": null, \"provider\": \"mtn\", \"user_ref\": \"QUARKSZclyPxC7QG\", \"created_at\": \"2025-05-11T19:29:31.708845Z\", \"processed_at\": \"2025-05-11T19:30:03.615623303Z\"}, \"kind\": \"transaction:processed\", \"event_id\": \"564e494e-2e9e-11f0-87c9-dead131a2dd9\", \"webhooks\": [\"46VNTS\"], \"created_at\": \"2025-05-11T19:30:03.615487Z\"}', '2025-05-11 17:29:30', '2025-05-11 17:30:04'),
(5, 5, 3, '07854361887', 'mtn', 100, 1, 'successful', '3c650658-2f2d-45e1-bb8f-568003c9d640', '{\"data\": {\"fee\": 2.3, \"ref\": \"3c650658-2f2d-45e1-bb8f-568003c9d640\", \"kind\": \"CASHIN\", \"amount\": 100, \"client\": \"0785436135\", \"status\": \"successful\", \"merchant\": \"G3MR8I\", \"metadata\": null, \"provider\": \"mtn\", \"user_ref\": \"QUARKSiSNM1Ucyer\", \"created_at\": \"2025-05-11T20:08:00.924526Z\", \"processed_at\": \"2025-05-11T20:08:18.748393085Z\"}, \"kind\": \"transaction:processed\", \"event_id\": \"ae4fc5d2-2ea3-11f0-b286-dead131a2dd9\", \"webhooks\": [\"46VNTS\"], \"created_at\": \"2025-05-11T20:08:18.74817Z\"}', '2025-05-11 18:08:00', '2025-05-11 18:08:26'),
(6, 26, 1, '0785436109', 'mtn', 100, 1, 'successful', '84c227cc-78d1-4fba-8948-9cec486bb89f', '{\"data\": {\"fee\": 2.3, \"ref\": \"84c227cc-78d1-4fba-8948-9cec486bb89f\", \"kind\": \"CASHIN\", \"amount\": 100, \"client\": \"0785436135\", \"status\": \"successful\", \"merchant\": \"G3MR8I\", \"metadata\": null, \"provider\": \"mtn\", \"user_ref\": \"QUARKS10QTIlj8yO\", \"created_at\": \"2025-05-11T20:18:53.397443Z\", \"processed_at\": \"2025-05-11T20:19:33.707439467Z\"}, \"kind\": \"transaction:processed\", \"event_id\": \"409e5484-2ea5-11f0-af5c-dead131a2dd9\", \"webhooks\": [\"46VNTS\"], \"created_at\": \"2025-05-11T20:19:33.707034Z\"}', '2025-05-11 18:18:52', '2025-05-11 18:20:14'),
(7, 30, 1, '0785636135', 'mtn', 100, 1, 'successful', '66379362-3909-48d6-929c-0b8c8ef73cd8', '{\"data\": {\"fee\": 2.3, \"ref\": \"66379362-3909-48d6-929c-0b8c8ef73cd8\", \"kind\": \"CASHIN\", \"amount\": 100, \"client\": \"0785436135\", \"status\": \"successful\", \"merchant\": \"G3MR8I\", \"metadata\": null, \"provider\": \"mtn\", \"user_ref\": \"QUARKSWelKBlueWy\", \"created_at\": \"2025-05-11T20:28:52.736502Z\", \"processed_at\": \"2025-05-11T20:29:14.012457062Z\"}, \"kind\": \"transaction:processed\", \"event_id\": \"9a81d6aa-2ea6-11f0-af5c-dead131a2dd9\", \"webhooks\": [\"46VNTS\"], \"created_at\": \"2025-05-11T20:29:14.012266Z\"}', '2025-05-11 18:28:51', '2025-05-11 18:29:15'),
(8, 12, 1, '0785436135', 'mtn', 100, 1, 'successful', '16bc90a5-0094-4795-afa7-179d190c7651', '{\"data\": {\"fee\": 2.3, \"ref\": \"16bc90a5-0094-4795-afa7-179d190c7651\", \"kind\": \"CASHIN\", \"amount\": 100, \"client\": \"0785436135\", \"status\": \"successful\", \"merchant\": \"G3MR8I\", \"metadata\": null, \"provider\": \"mtn\", \"user_ref\": \"QUARKSfvj7ycVCh4\", \"created_at\": \"2025-05-11T21:11:00.505434Z\", \"processed_at\": \"2025-05-11T21:11:18.693613549Z\"}, \"kind\": \"transaction:processed\", \"event_id\": \"7b55b03e-2eac-11f0-9dba-dead131a2dd9\", \"webhooks\": [\"46VNTS\"], \"created_at\": \"2025-05-11T21:11:18.693699Z\"}', '2025-05-11 19:10:59', '2025-05-11 19:11:21'),
(9, 26, 1, '0782394665', 'mtn', 100, 1, 'initiated', NULL, NULL, '2025-05-12 03:10:50', '2025-05-12 03:10:50');

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
('p6VjV5DYFLRbZ9GQiDeJETjmMmzACkxEnljekHFt', 1, '127.0.0.1', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'YTo0OntzOjY6Il90b2tlbiI7czo0MDoiaDNHY2tlQlplZ3A5RWNMZ3YwWm5meXNXT0YxTVJIR2VnbUI2MnlTdSI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6Mzg6Imh0dHA6Ly9ycGwtYXdhcmRzLXYyLnRlc3QvY2F0ZWdvcmllcy80Ijt9czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319czo1MDoibG9naW5fd2ViXzU5YmEzNmFkZGMyYjJmOTQwMTU4MGYwMTRjN2Y1OGVhNGUzMDk4OWQiO2k6MTt9', 1747467981);

-- --------------------------------------------------------

--
-- Table structure for table `settings`
--

CREATE TABLE `settings` (
  `id` bigint UNSIGNED NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `value` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `settings`
--

INSERT INTO `settings` (`id`, `name`, `value`, `created_at`, `updated_at`) VALUES
(1, 'vote_amount', '100', '2025-05-11 17:44:04', '2025-05-11 17:44:04');

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
(1, 'BYAMUNGU Lewis', 'byamungulewis@gmail.com', '0785436135', 'super_admin', 'active', '2025-04-27 05:29:07', '$2y$12$agIcW8GRsLUNNOoQJKQ9..Xnj5rM6i6bn94zwCQyw00ug70efW1kS', '2025-05-17 05:46:18', 'zdJlQyTIOaH1isQnNQzk0KFpmtSHCOqeCtVlq12ShON76qC6qkN7udvGvqDu', '2025-04-27 05:29:08', '2025-05-17 05:46:18'),
(3, 'Kylie Ayers', 'duziqymem@mailinator.com', '+1 (317) 114-8376', 'admin', 'active', NULL, '$2y$12$VjyWZTfm5lIy.GU/gM/dVuo4M0soUTgsyi2ZSD.zsFtZLGX6GWV4a', NULL, NULL, '2025-04-27 05:39:44', '2025-04-27 05:39:44'),
(4, 'Sigourney Waller', 'lusihuje@mailinator.com', '+1 (273) 518-1257', 'inspector', 'inactive', NULL, '$2y$12$n.lydz2zjsknpp.cvIVYZ.pu0CZzNR1gvdzsUybflPLsxirF3dldy', NULL, NULL, '2025-04-27 05:39:50', '2025-04-30 08:21:11'),
(6, 'Ginger Morales', 'tafoxadu@mailinator.com', '+1 (673) 674-9352', 'admin', 'active', NULL, '$2y$12$Mc4mPRI7HjGjRtT7iEWkWeXwAYmMnZw8wWudqS4AlT7zwemHnYROy', NULL, NULL, '2025-04-27 06:04:00', '2025-04-27 06:04:00'),
(15, 'Jules MURERWA', 'julesmurerwa@gmail.com', '0786665544', 'inspector', 'active', NULL, '$2y$12$msqckoulmV5aTTUhNS6y..xrs8PVw27oABvqRffUlPhDyMOwSmjWq', NULL, NULL, '2025-04-30 08:20:49', '2025-04-30 08:20:49');

-- --------------------------------------------------------

--
-- Table structure for table `ussd_sessions`
--

CREATE TABLE `ussd_sessions` (
  `id` bigint UNSIGNED NOT NULL,
  `phone_number` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `level` int NOT NULL DEFAULT '0',
  `data` json DEFAULT NULL,
  `last_activity` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `ussd_sessions`
--

INSERT INTO `ussd_sessions` (`id`, `phone_number`, `level`, `data`, `last_activity`, `created_at`, `updated_at`) VALUES
(16, '250785436135', 1, '{\"inputs\": [\"1\"]}', '2025-05-12 03:47:47', '2025-05-12 03:47:37', '2025-05-12 03:47:47');

-- --------------------------------------------------------

--
-- Table structure for table `votes`
--

CREATE TABLE `votes` (
  `id` bigint UNSIGNED NOT NULL,
  `candidate_id` bigint UNSIGNED NOT NULL,
  `category_id` bigint UNSIGNED NOT NULL,
  `ip_address` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `votes`
--

INSERT INTO `votes` (`id`, `candidate_id`, `category_id`, `ip_address`, `created_at`, `updated_at`) VALUES
(1, 26, 1, '127.0.0.1', '2025-05-17 05:07:20', '2025-05-17 05:07:20'),
(2, 8, 3, '127.0.0.1', '2025-05-17 05:10:46', '2025-05-17 05:10:46');

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
-- Indexes for table `news`
--
ALTER TABLE `news`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `news_slug_unique` (`slug`);

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
  ADD KEY `payments_candidate_id_foreign` (`candidate_id`),
  ADD KEY `payments_category_id_foreign` (`category_id`);

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
-- Indexes for table `settings`
--
ALTER TABLE `settings`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `users_email_unique` (`email`),
  ADD UNIQUE KEY `users_phone_unique` (`phone`);

--
-- Indexes for table `ussd_sessions`
--
ALTER TABLE `ussd_sessions`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `ussd_sessions_phone_number_unique` (`phone_number`);

--
-- Indexes for table `votes`
--
ALTER TABLE `votes`
  ADD PRIMARY KEY (`id`),
  ADD KEY `votes_candidate_id_foreign` (`candidate_id`),
  ADD KEY `votes_category_id_foreign` (`category_id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `candidates`
--
ALTER TABLE `candidates`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=53;

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
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `migrations`
--
ALTER TABLE `migrations`
  MODIFY `id` int UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=33;

--
-- AUTO_INCREMENT for table `news`
--
ALTER TABLE `news`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `payments`
--
ALTER TABLE `payments`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- AUTO_INCREMENT for table `personal_access_tokens`
--
ALTER TABLE `personal_access_tokens`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `settings`
--
ALTER TABLE `settings`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=16;

--
-- AUTO_INCREMENT for table `ussd_sessions`
--
ALTER TABLE `ussd_sessions`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=17;

--
-- AUTO_INCREMENT for table `votes`
--
ALTER TABLE `votes`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

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
  ADD CONSTRAINT `payments_candidate_id_foreign` FOREIGN KEY (`candidate_id`) REFERENCES `candidates` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `payments_category_id_foreign` FOREIGN KEY (`category_id`) REFERENCES `categories` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `votes`
--
ALTER TABLE `votes`
  ADD CONSTRAINT `votes_candidate_id_foreign` FOREIGN KEY (`candidate_id`) REFERENCES `candidates` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `votes_category_id_foreign` FOREIGN KEY (`category_id`) REFERENCES `categories` (`id`) ON DELETE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
