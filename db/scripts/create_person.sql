CREATE DATABASE IF NOT EXISTS `testdb` DEFAULT CHARACTER SET utf8 COLLATE utf8_general_ci;
GO
USE `testdb`;
GO
CREATE TABLE `Person` (
  `ID` int(11) NOT NULL,
  `firstName` varchar(25) NOT NULL DEFAULT '',
  `lastName` varchar(25) 
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

