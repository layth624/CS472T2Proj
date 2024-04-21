-- phpMyAdmin SQL Dump
-- version 4.7.1
-- https://www.phpmyadmin.net/
--
-- Host: sql3.freemysqlhosting.net
-- Generation Time: Mar 28, 2024 at 08:05 PM
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
(1, 'Ghaith Ishaq', 'admin1', '1234', 'all'),
(2, 'Agustin Sandoval', 'admin2', '1234', 'all'),
(3, 'Adan Delgado', 'admin3', '1234', 'all'),
(4, 'Rymma Won', 'admin4', '1234', 'all'),
(5, 'Mike Supervisor', 'mikesupervisor', 'anotherpassword', 'room management');

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
(3, 3, '1250.00', '2024-04-20', 'bank transfer', 'pending');

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
(3, 3, 3, '2024-04-20', '2024-04-25', '1250.00', 'cancelled');

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
(1, 'single', '100.00', 'available', '1st Floor', '101'),
(2, 'double', '150.00', 'booked', '2nd Floor', '202'),
(3, 'suite', '250.00', 'available', '3rd Floor', '303');

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
(1, 'John Doe', '1234 Elm Street, Springfield', 'johndoe@example.com', '555-1234', '1990-05-15', 'johndoe', 'password123'),
(2, 'Jane Smith', '5678 Oak Street, Metropolis', 'janesmith@example.com', '555-5678', '1985-08-25', 'janesmith', 'smithpassword'),
(3, 'Alice Johnson', '9101 Pine Street, Gotham', 'alicejohnson@example.com', '555-9101', '1992-12-10', 'alicejohnson', 'alicepass');

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
  MODIFY `AdminID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;
--
-- AUTO_INCREMENT for table `Payment`
--
ALTER TABLE `Payment`
  MODIFY `PaymentID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;
--
-- AUTO_INCREMENT for table `Reservation`
--
ALTER TABLE `Reservation`
  MODIFY `ReservationID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;
--
-- AUTO_INCREMENT for table `Room`
--
ALTER TABLE `Room`
  MODIFY `RoomID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;
--
-- AUTO_INCREMENT for table `RoomReservation`
--
ALTER TABLE `RoomReservation`
  MODIFY `RoomReservationID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;
--
-- AUTO_INCREMENT for table `Users`
--
ALTER TABLE `Users`
  MODIFY `UserID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;
--
-- Constraints for dumped tables
--

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
