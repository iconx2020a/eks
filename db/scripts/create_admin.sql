CREATE DATABASE IF NOT EXISTS `testdb` DEFAULT CHARACTER SET utf8 COLLATE utf8_general_ci;
GO
USE `testdb`;
GO
CREATE TABLE `Admin` (
  `ID` int(11) NOT NULL,
  `Password` varchar(25) NOT NULL DEFAULT '' 
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

