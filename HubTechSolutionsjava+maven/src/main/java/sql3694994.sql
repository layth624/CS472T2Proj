-- phpMyAdmin SQL Dump
-- version 4.7.1
-- https://www.phpmyadmin.net/
--
-- Host: sql3.freemysqlhosting.net
-- Generation Time: May 05, 2024 at 10:40 PM
-- Server version: 5.5.54-0ubuntu0.12.04.1
-- PHP Version: 7.0.33-0ubuntu0.16.04.16

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `sql3694994`
--

-- --------------------------------------------------------

--
-- Table structure for table `Admin`
--

CREATE TABLE `Admin` (
  `AdminID` int(11) NOT NULL,
  `Name` varchar(255) NOT NULL,
  `AdminUsername` varchar(255) NOT NULL,
  `AdminPassword` varchar(255) NOT NULL,
  `Role` enum('room management','booking management','all') NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `Admin`
--

INSERT INTO `Admin` (`AdminID`, `Name`, `AdminUsername`, `AdminPassword`, `Role`) VALUES
(1, 'Concurrent Update 1', 'admin1', '1234', 'all'),
(2, 'Agustin Sandoval', 'admin2', '1234', 'all'),
(3, 'Adan Delgado', 'admin3', '1234', 'all'),
(4, 'Rymma Won', 'admin4', '1234', 'all'),
(5, 'Mike Supervisor', 'mikesupervisor', 'anotherpassword', 'room management'),
(6, 'asdf', 'asdf', '$2a$10$Xr2Yiwjn1cDYKilljFOSrOYG2p5i64sUakRpcrxaF5UbE3.zwwNQq', 'all'),
(8, 'zxcv', 'zxcv', '$2a$10$JwQB460RNSrSfusNDLkLJO2LD3goWkq37CM8ErsoPt0V45IOPJbRW', 'room management'),
(9, 'vcxz', 'vcxz', '$2a$10$hZLT4RTxsQtpZK.gOTZTFOCt/VxQoAfFc5RUhEfP13NHXntrd/aBa', 'room management'),
(10, 'Harry', 'Harry', '$2a$10$k8YjOtGiEHCiyVa93Ysqc.u4n7nslZdUgQbZkCjW1qZj51r./692q', 'room management'),
(11, 'Roberto', 'Roberto', '$2a$10$zwUwtic1n0s1i93DLS5ITeNdsqupGhQZDPre6JU95w0hGx9FBynUq', 'all'),
(12, 'Hariet', 'Hariet', '$2a$10$gVNjzpVlHJnsv0RmZi2s6upTjgpNobRpvq1ClsdAolHnhV/P/z5gu', 'all'),
(13, 'Diego', 'Diego', '$2a$10$uT6D.YECnWZeQ7IoRKfYeeKZTH5xHnhahch/c3bcsfG0QxYkHD/P2', 'all'),
(14, 'admin 213', '@realAdmin21324', '$2a$10$dL/dQIgDbKunpMDp7obIBeMoK03mIpFrh00pzsUH8d7/yqHjJTbLa', 'room management'),
(15, 'Room', 'Room', '$2a$10$u0Bs2VwZYelCu3vlyZ/ZPOXr6kO5NHJImILH30Dt3kOQ0hW0WkB8u', 'room management'),
(16, 'Booking', 'Booking', '$2a$10$rvRiP4kuUzHPeeRH6smWXuualdDN7GLVxPt7uLAICcGdvkz/B7wZ2', 'booking management'),
(17, 'All', 'All', '$2a$10$pso7DOCGvJ/DeGXC3L1Cie/Hm1X3ngPAvOya1LZ.6xlanZueCiooa', 'all');

-- --------------------------------------------------------

--
-- Table structure for table `Card`
--

CREATE TABLE `Card` (
  `CardID` int(11) NOT NULL,
  `PaymentID` int(11) DEFAULT NULL,
  `CardNumber` varchar(16) DEFAULT NULL,
  `Expiration` varchar(7) DEFAULT NULL,
  `CVC` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `Card`
--

INSERT INTO `Card` (`CardID`, `PaymentID`, `CardNumber`, `Expiration`, `CVC`) VALUES
(1, 27, '3485234845672381', '05/2025', 123),
(2, 28, '3245465674322', '04/2026', 123),
(3, 29, '345236375478657', '04/2026', 123);

-- --------------------------------------------------------

--
-- Table structure for table `Payment`
--

CREATE TABLE `Payment` (
  `PaymentID` int(11) NOT NULL,
  `ReservationID` int(11) NOT NULL,
  `Amount` decimal(10,2) NOT NULL,
  `Date` date NOT NULL,
  `PaymentMethod` enum('credit card','PayPal','cash','bank transfer') NOT NULL,
  `Status` enum('pending','completed','refunded') NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `Payment`
--

INSERT INTO `Payment` (`PaymentID`, `ReservationID`, `Amount`, `Date`, `PaymentMethod`, `Status`) VALUES
(1, 1, '500.00', '2024-04-01', 'credit card', 'completed'),
(2, 2, '750.00', '2024-04-10', 'PayPal', 'completed'),
(3, 3, '1250.00', '2024-04-20', 'bank transfer', 'pending'),
(4, 5, '1300.00', '2024-04-26', 'cash', 'completed'),
(5, 11, '600.00', '2024-04-26', 'cash', 'completed'),
(6, 12, '400.00', '2024-04-26', 'cash', 'completed'),
(7, 13, '300.00', '2024-04-26', 'cash', 'completed'),
(8, 14, '500.00', '2024-04-26', 'cash', 'completed'),
(9, 15, '400.00', '2024-04-26', 'cash', 'completed'),
(10, 16, '400.00', '2024-04-30', 'cash', 'completed'),
(11, 17, '2400.00', '2024-04-30', 'cash', 'completed'),
(12, 18, '250.00', '2024-04-30', 'cash', 'completed'),
(13, 20, '700.00', '2024-04-30', 'cash', 'completed'),
(14, 21, '450.00', '2024-04-30', 'cash', 'completed'),
(15, 22, '900.00', '2024-04-30', 'cash', 'completed'),
(16, 23, '800.00', '2024-04-30', 'cash', 'completed'),
(17, 25, '750.00', '2024-05-02', 'cash', 'completed'),
(18, 25, '750.00', '2024-05-02', 'cash', 'completed'),
(19, 25, '750.00', '2024-05-02', 'cash', 'completed'),
(20, 25, '750.00', '2024-05-02', 'cash', 'completed'),
(21, 26, '1250.00', '2024-05-02', 'cash', 'completed'),
(22, 27, '500.00', '2024-05-02', 'cash', 'completed'),
(23, 27, '500.00', '2024-05-02', 'cash', 'completed'),
(24, 27, '500.00', '2024-05-02', 'cash', 'completed'),
(25, 28, '1050.00', '2024-05-03', 'cash', 'completed'),
(27, 29, '600.00', '2024-05-03', 'credit card', 'pending'),
(28, 30, '600.00', '2024-05-03', 'credit card', 'pending'),
(29, 33, '300.00', '2024-05-03', 'credit card', 'pending');

-- --------------------------------------------------------

--
-- Table structure for table `Reservation`
--

CREATE TABLE `Reservation` (
  `ReservationID` int(11) NOT NULL,
  `UserID` int(11) NOT NULL,
  `RoomID` int(11) NOT NULL,
  `CheckInDate` date NOT NULL,
  `CheckOutDate` date NOT NULL,
  `TotalCost` decimal(10,2) NOT NULL,
  `Status` enum('active','cancelled','completed') NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `Reservation`
--

INSERT INTO `Reservation` (`ReservationID`, `UserID`, `RoomID`, `CheckInDate`, `CheckOutDate`, `TotalCost`, `Status`) VALUES
(1, 1, 1, '2024-04-01', '2024-04-05', '500.00', 'active'),
(2, 2, 2, '2024-04-10', '2024-04-15', '750.00', 'completed'),
(3, 9, 3, '2024-04-20', '2024-04-25', '1250.00', 'cancelled'),
(5, 9, 6, '2024-04-17', '2024-04-30', '1300.00', 'cancelled'),
(6, 9, 4, '2024-04-17', '2024-04-20', '300.00', 'cancelled'),
(10, 9, 1, '2024-04-24', '2024-05-01', '700.00', 'cancelled'),
(11, 9, 1, '2024-04-26', '2024-05-02', '600.00', 'cancelled'),
(12, 9, 18, '2024-04-26', '2024-04-30', '400.00', 'cancelled'),
(13, 9, 14, '2024-04-26', '2024-04-29', '300.00', 'cancelled'),
(14, 9, 14, '2024-04-26', '2024-05-01', '500.00', 'cancelled'),
(15, 9, 15, '2024-04-26', '2024-04-30', '400.00', 'cancelled'),
(16, 9, 13, '2024-04-26', '2024-04-30', '400.00', 'cancelled'),
(17, 9, 3, '2024-04-30', '2024-05-10', '2400.00', 'cancelled'),
(18, 9, 35, '2024-05-01', '2024-05-02', '250.00', 'cancelled'),
(20, 9, 43, '2024-05-01', '2024-05-08', '700.00', 'cancelled'),
(21, 9, 19, '2024-05-01', '2024-05-04', '450.00', 'cancelled'),
(22, 9, 4, '2024-04-30', '2024-05-09', '900.00', 'cancelled'),
(23, 9, 1, '2024-05-01', '2024-05-09', '800.00', 'cancelled'),
(25, 9, 13, '2024-05-03', '2024-05-08', '750.00', 'cancelled'),
(26, 9, 37, '2024-05-02', '2024-05-07', '1250.00', 'cancelled'),
(27, 9, 6, '2024-05-03', '2024-05-08', '500.00', 'cancelled'),
(28, 9, 14, '2024-05-02', '2024-05-09', '1050.00', 'completed'),
(29, 9, 4, '2024-05-03', '2024-05-09', '600.00', 'cancelled'),
(30, 9, 1, '2024-05-03', '2024-05-09', '600.00', 'completed'),
(31, 9, 4, '2024-05-03', '2024-05-09', '600.00', 'active'),
(32, 9, 13, '2024-05-02', '2024-05-04', '300.00', 'active'),
(33, 9, 15, '2024-05-02', '2024-05-04', '300.00', 'completed');

-- --------------------------------------------------------

--
-- Table structure for table `Room`
--

CREATE TABLE `Room` (
  `RoomID` int(11) NOT NULL,
  `RoomType` enum('single','double','suite') NOT NULL,
  `Price` decimal(10,2) NOT NULL,
  `Status` enum('available','booked') NOT NULL,
  `FloorLocation` varchar(50) NOT NULL,
  `RoomNumber` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `Room`
--

INSERT INTO `Room` (`RoomID`, `RoomType`, `Price`, `Status`, `FloorLocation`, `RoomNumber`) VALUES
(1, 'single', '101.00', 'booked', '1st Floor', '101'),
(2, 'double', '150.00', 'booked', '2nd Floor', '202'),
(3, 'suite', '250.00', 'available', '3rd Floor', '303'),
(4, 'single', '100.00', 'booked', '1st Floor', '102'),
(5, 'single', '100.00', 'booked', '1st Floor', '103'),
(6, 'single', '100.00', 'available', '1st Floor', '104'),
(7, 'single', '100.00', 'booked', '1st Floor', '105'),
(8, 'single', '100.00', 'booked', '1st Floor', '106'),
(9, 'single', '100.00', 'booked', '1st Floor', '107'),
(10, 'single', '100.00', 'booked', '1st Floor', '108'),
(11, 'single', '100.00', 'booked', '1st Floor', '109'),
(12, 'single', '100.00', 'booked', '1st Floor', '110'),
(13, 'double', '150.00', 'booked', '2nd Floor', '201'),
(14, 'double', '150.00', 'booked', '2nd Floor', '203'),
(15, 'double', '150.00', 'booked', '2nd Floor', '204'),
(16, 'double', '150.00', 'booked', '2nd Floor', '205'),
(17, 'double', '150.00', 'booked', '2nd Floor', '206'),
(18, 'double', '150.00', 'available', '2nd Floor', '207'),
(19, 'double', '150.00', 'available', '2nd Floor', '208'),
(20, 'double', '150.00', 'available', '2nd Floor', '209'),
(21, 'double', '150.00', 'booked', '2nd Floor', '210'),
(22, 'suite', '250.00', 'booked', '3rd Floor', '301'),
(35, 'suite', '250.00', 'available', '3rd Floor', '302'),
(36, 'suite', '250.00', 'booked', '3rd Floor', '304'),
(37, 'suite', '250.00', 'available', '3rd Floor', '305'),
(38, 'suite', '250.00', 'available', '3rd Floor', '306'),
(39, 'suite', '250.00', 'available', '3rd Floor', '307'),
(40, 'suite', '250.00', 'booked', '3rd Floor', '308'),
(41, 'suite', '250.00', 'booked', '3rd Floor', '309'),
(42, 'suite', '250.00', 'available', '3rd Floor', '310'),
(43, 'single', '100.00', 'available', '1st Floor', '111'),
(47, 'single', '100.00', 'available', '1st Floor', '114');

-- --------------------------------------------------------

--
-- Table structure for table `RoomReservation`
--

CREATE TABLE `RoomReservation` (
  `RoomReservationID` int(11) NOT NULL,
  `RoomID` int(11) NOT NULL,
  `ReservationID` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `RoomReservation`
--

INSERT INTO `RoomReservation` (`RoomReservationID`, `RoomID`, `ReservationID`) VALUES
(1, 1, 1),
(2, 2, 1),
(3, 3, 2);

-- --------------------------------------------------------

--
-- Table structure for table `Users`
--

CREATE TABLE `Users` (
  `UserID` int(11) NOT NULL,
  `Name` varchar(255) NOT NULL,
  `Address` text NOT NULL,
  `Email` varchar(255) NOT NULL,
  `PhoneNumber` varchar(20) NOT NULL,
  `Dob` date NOT NULL,
  `Username` varchar(255) NOT NULL,
  `Password` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `Users`
--

INSERT INTO `Users` (`UserID`, `Name`, `Address`, `Email`, `PhoneNumber`, `Dob`, `Username`, `Password`) VALUES
(1, 'John Doe', '1234 Elm Street, Springfield', 'johndoe@example.com', '555-1234-9034', '1990-05-15', 'johndoe', 'password123'),
(2, 'Jane Smith', '5678 Oak Street, Metropolis', 'janesmith@example.com', '555-5678-0834', '1985-08-25', 'janesmith', 'smithpassword'),
(3, 'Alice Johnson', '9101 Pine Street, Gotham', 'alicejohnson@example.com', '555-9101-9340', '1992-12-10', 'alicejohnson', 'alicepass'),
(4, 'GHAITH ISHAQ', '5923 Modern Address, hoage, homerston', 'dmh60806@bcaoo.com', '7034493290', '2024-04-16', 'admin2132', '1234'),
(9, 'me frfrfrfr', '5923 Modern Address, hoage, homerston', 'ceritama@mailgolem.com', '703449329043', '2021-07-07', 'admin21324', '$2a$10$9Kg31dF.nPwJkA0DUocJrOUuZhhs9MMLWrNxOMa4htGKWP1WAIb.O'),
(10, 'Jane', '111 Main St', 'janedoe@gmail.com', '777-777-7777', '1985-01-18', 'Doe', '$2a$10$ZrzXZxbRG3tnJt615.TyaeH/6H3l2147mp5v6if4oABNb/wXUDb1q'),
(14, 'me frfrfrfr', '5923 Modern Address, hoage, homerston', 'dmh608dss06@bcadoo.com', '7034493298', '2024-04-23', 'admin2133', '$2a$10$Iqn0cMMcX1XM0rTU6xU96.rY3Q6uEblVt.z5bqRUXP4HsVdMHZc.G'),
(16, 'Rob', 'Rob Land', 'Rob@rob.com', '343452', '2024-04-11', 'Roberto', '1234');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `Admin`
--
ALTER TABLE `Admin`
  ADD PRIMARY KEY (`AdminID`),
  ADD UNIQUE KEY `AdminUsername` (`AdminUsername`);

--
-- Indexes for table `Card`
--
ALTER TABLE `Card`
  ADD PRIMARY KEY (`CardID`),
  ADD KEY `PaymentID` (`PaymentID`);

--
-- Indexes for table `Payment`
--
ALTER TABLE `Payment`
  ADD PRIMARY KEY (`PaymentID`),
  ADD KEY `ReservationID` (`ReservationID`);

--
-- Indexes for table `Reservation`
--
ALTER TABLE `Reservation`
  ADD PRIMARY KEY (`ReservationID`),
  ADD KEY `UserID` (`UserID`),
  ADD KEY `RoomID` (`RoomID`);

--
-- Indexes for table `Room`
--
ALTER TABLE `Room`
  ADD PRIMARY KEY (`RoomID`),
  ADD UNIQUE KEY `RoomNumber` (`RoomNumber`);

--
-- Indexes for table `RoomReservation`
--
ALTER TABLE `RoomReservation`
  ADD PRIMARY KEY (`RoomReservationID`),
  ADD UNIQUE KEY `RoomID` (`RoomID`,`ReservationID`),
  ADD KEY `ReservationID` (`ReservationID`);

--
-- Indexes for table `Users`
--
ALTER TABLE `Users`
  ADD PRIMARY KEY (`UserID`),
  ADD UNIQUE KEY `Email` (`Email`),
  ADD UNIQUE KEY `PhoneNumber` (`PhoneNumber`),
  ADD UNIQUE KEY `Username` (`Username`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `Admin`
--
ALTER TABLE `Admin`
  MODIFY `AdminID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=18;
--
-- AUTO_INCREMENT for table `Card`
--
ALTER TABLE `Card`
  MODIFY `CardID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;
--
-- AUTO_INCREMENT for table `Payment`
--
ALTER TABLE `Payment`
  MODIFY `PaymentID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=30;
--
-- AUTO_INCREMENT for table `Reservation`
--
ALTER TABLE `Reservation`
  MODIFY `ReservationID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=34;
--
-- AUTO_INCREMENT for table `Room`
--
ALTER TABLE `Room`
  MODIFY `RoomID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=48;
--
-- AUTO_INCREMENT for table `RoomReservation`
--
ALTER TABLE `RoomReservation`
  MODIFY `RoomReservationID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;
--
-- AUTO_INCREMENT for table `Users`
--
ALTER TABLE `Users`
  MODIFY `UserID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=19;
--
-- Constraints for dumped tables
--

--
-- Constraints for table `Card`
--
ALTER TABLE `Card`
  ADD CONSTRAINT `Card_ibfk_1` FOREIGN KEY (`PaymentID`) REFERENCES `Payment` (`PaymentID`);

--
-- Constraints for table `Payment`
--
ALTER TABLE `Payment`
  ADD CONSTRAINT `Payment_ibfk_1` FOREIGN KEY (`ReservationID`) REFERENCES `Reservation` (`ReservationID`);

--
-- Constraints for table `Reservation`
--
ALTER TABLE `Reservation`
  ADD CONSTRAINT `Reservation_ibfk_1` FOREIGN KEY (`UserID`) REFERENCES `Users` (`UserID`),
  ADD CONSTRAINT `Reservation_ibfk_2` FOREIGN KEY (`RoomID`) REFERENCES `Room` (`RoomID`);

--
-- Constraints for table `RoomReservation`
--
ALTER TABLE `RoomReservation`
  ADD CONSTRAINT `RoomReservation_ibfk_1` FOREIGN KEY (`RoomID`) REFERENCES `Room` (`RoomID`),
  ADD CONSTRAINT `RoomReservation_ibfk_2` FOREIGN KEY (`ReservationID`) REFERENCES `Reservation` (`ReservationID`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
