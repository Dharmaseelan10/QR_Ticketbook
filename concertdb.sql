-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Mar 27, 2024 at 04:10 AM
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
-- Database: `concertdb`
--

-- --------------------------------------------------------

--
-- Table structure for table `bookings`
--

CREATE TABLE `bookings` (
  `id` int(11) NOT NULL,
  `concertId` int(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  `phoneNumber` varchar(20) NOT NULL,
  `selectedSeat` int(11) NOT NULL,
  `bookingTime` timestamp NOT NULL DEFAULT current_timestamp(),
  `qrCodeUrl` varchar(255) DEFAULT NULL,
  `userId` int(11) DEFAULT NULL,
  `concertName` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `bookings`
--

INSERT INTO `bookings` (`id`, `concertId`, `name`, `phoneNumber`, `selectedSeat`, `bookingTime`, `qrCodeUrl`, `userId`, `concertName`) VALUES
(148, 1, 'Lee', '01046875211', 1, '2024-03-27 02:39:40', 'http://localhost/php-vue/qr_code/qr_code_Ed Sheeran Tour (30th March 2024)_148.png', 5, NULL),
(149, 2, 'Lee', '03543544412', 1, '2024-03-27 02:41:02', 'http://localhost/php-vue/qr_code/qr_code_Music of the Spheres World Tour (31st March 2024)_149.png', 5, NULL),
(151, 1, 'Dharmaseelan', '57454442', 2, '2024-03-27 02:47:39', 'http://localhost/php-vue/qr_code/qr_code_Ed Sheeran Tour (30th March 2024)_151.png', 3, NULL),
(152, 1, 'Dharmaseelan', '57454442', 3, '2024-03-27 02:48:01', 'http://localhost/php-vue/qr_code/qr_code_Ed Sheeran Tour (30th March 2024)_152.png', 3, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `concerts`
--

CREATE TABLE `concerts` (
  `id` int(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  `image` varchar(255) NOT NULL,
  `concertName` varchar(255) NOT NULL,
  `seatsCapacity` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `concerts`
--

INSERT INTO `concerts` (`id`, `name`, `image`, `concertName`, `seatsCapacity`) VALUES
(1, 'Ed Sheeran Tour (30th March 2024)', 'https://static.promediateknologi.id/crop/0x0:0x0/0x0/webp/photo/p2/01/2023/11/03/F95m-ZSaQAAW8fT-3228084999.jpg', 'Ed Sheeran Tour', 10),
(2, 'Music of the Spheres World Tour (31st March 2024)', 'https://media.karousell.com/media/photos/products/2023/6/21/cold_play_malaysia_concert_202_1687310359_38d9eece_progressive.jpg', 'Music of the Spheres World Tour', 10),
(3, 'Tom Jones Ages & Stages Tour (10th June 2024)', 'https://images.lifestyleasia.com/wp-content/uploads/sites/5/2024/01/10170711/Snapinsta.app_401095539_17939237780745883_6301259909790717595_n_1080.jpg', 'Tom Jones Ages & Stages Tour', 10);

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `userId` int(11) NOT NULL,
  `username` varchar(255) NOT NULL,
  `password` varchar(255) NOT NULL,
  `email` varchar(255) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`userId`, `username`, `password`, `email`, `created_at`) VALUES
(3, 'Dharmaseelan10', '$2b$10$aPrQy4aKTlobsRHCSmTuNuW22QQA5SVw21Eaye/PLjwdaz8WB6awu', 'dseelan563@gmail.com', '2024-03-18 02:51:02'),
(4, 'kong10', '$2b$10$qz/c0ykCXdnR9Mto5YnG.uaVr51S9XKO2Uby4IXrLUrsRuJCAU5yO', 'kong@gmail.com', '2024-03-18 03:15:32'),
(5, 'Lee10', '$2b$10$Ng01Ge4.DRJaC7cx7zMS.Otq4hulR92LEVYPqF.pTVOneGHgBRx8.', 'lee@gmail.com', '2024-03-20 04:55:45');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `bookings`
--
ALTER TABLE `bookings`
  ADD PRIMARY KEY (`id`),
  ADD KEY `concertId` (`concertId`),
  ADD KEY `fk_userId` (`userId`);

--
-- Indexes for table `concerts`
--
ALTER TABLE `concerts`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`userId`),
  ADD UNIQUE KEY `username` (`username`),
  ADD UNIQUE KEY `email` (`email`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `bookings`
--
ALTER TABLE `bookings`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=153;

--
-- AUTO_INCREMENT for table `concerts`
--
ALTER TABLE `concerts`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `userId` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `bookings`
--
ALTER TABLE `bookings`
  ADD CONSTRAINT `bookings_ibfk_1` FOREIGN KEY (`concertId`) REFERENCES `concerts` (`id`),
  ADD CONSTRAINT `fk_userId` FOREIGN KEY (`userId`) REFERENCES `users` (`userId`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
