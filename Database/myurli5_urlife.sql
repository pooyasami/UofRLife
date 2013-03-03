-- phpMyAdmin SQL Dump
-- version 3.3.8.1
-- http://www.phpmyadmin.net
--
-- Host: localhost
-- Generation Time: Apr 10, 2011 at 04:12 PM
-- Server version: 5.0.91
-- PHP Version: 5.2.9

SET SQL_MODE="NO_AUTO_VALUE_ON_ZERO";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

--
-- Database: `myurli5_urlife`
--

-- --------------------------------------------------------

--
-- Table structure for table `entities`
--

CREATE TABLE IF NOT EXISTS `entities` (
  `id` int(10) unsigned NOT NULL auto_increment,
  `user_id` int(11) unsigned NOT NULL,
  `location_id` int(11) NOT NULL,
  `type` varchar(50) NOT NULL,
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=58 ;

--
-- Dumping data for table `entities`
--

INSERT INTO `entities` (`id`, `user_id`, `location_id`, `type`) VALUES
(1, 1, 3, 'VENDOR'),
(2, 1, 9, 'VENDOR'),
(3, 3, 15, 'VENDOR'),
(4, 1, 15, 'VENDOR'),
(5, 1, 15, 'VENDOR'),
(6, 1, 15, 'VENDOR'),
(7, 1, 15, 'VENDOR'),
(8, 1, 15, 'VENDOR'),
(9, 1, 15, 'VENDOR'),
(10, 1, 13, 'VENDOR'),
(11, 1, 2, 'VENDOR'),
(12, 1, 10, 'VENDOR'),
(13, 1, 1, 'MACHINE'),
(14, 1, 1, 'MACHINE'),
(15, 1, 1, 'MACHINE'),
(16, 1, 2, 'MACHINE'),
(17, 1, 3, 'MACHINE'),
(18, 1, 3, 'MACHINE'),
(19, 1, 3, 'MACHINE'),
(20, 1, 4, 'MACHINE'),
(21, 1, 4, 'MACHINE'),
(22, 1, 7, 'MACHINE'),
(23, 1, 7, 'MACHINE'),
(24, 1, 7, 'MACHINE'),
(25, 1, 7, 'MACHINE'),
(26, 1, 7, 'MACHINE'),
(27, 1, 7, 'MACHINE'),
(28, 1, 7, 'MACHINE'),
(29, 1, 9, 'MACHINE'),
(30, 1, 9, 'MACHINE'),
(31, 1, 9, 'MACHINE'),
(32, 1, 9, 'MACHINE'),
(33, 1, 9, 'MACHINE'),
(34, 1, 9, 'MACHINE'),
(35, 1, 10, 'MACHINE'),
(36, 1, 10, 'MACHINE'),
(37, 1, 11, 'MACHINE'),
(38, 1, 12, 'MACHINE'),
(39, 1, 12, 'MACHINE'),
(40, 1, 13, 'MACHINE'),
(41, 1, 15, 'MACHINE'),
(42, 1, 16, 'MACHINE'),
(43, 1, 16, 'MACHINE'),
(44, 2, 14, 'EVENT'),
(45, 2, 13, 'EVENT'),
(46, 2, 15, 'EVENT'),
(47, 4, 7, 'EVENT'),
(48, 4, 1, 'EVENT'),
(49, 5, 14, 'event'),
(50, 4, 15, 'EVENT'),
(51, 4, 1, 'EVENT'),
(52, 6, 16, 'EVENT'),
(53, 4, 7, 'EVENT'),
(54, 4, 15, 'EVENT'),
(55, 5, 7, 'EVENT'),
(56, 4, 5, 'EVENT'),
(57, 9, 14, 'event');

-- --------------------------------------------------------

--
-- Table structure for table `establishmentfeedbacks`
--

CREATE TABLE IF NOT EXISTS `establishmentfeedbacks` (
  `id` int(10) unsigned NOT NULL auto_increment,
  `establishment_id` int(11) NOT NULL,
  `name` varchar(100) NOT NULL,
  `rate` varchar(10) NOT NULL,
  `feedback` text NOT NULL,
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 ROW_FORMAT=COMPACT AUTO_INCREMENT=8 ;

--
-- Dumping data for table `establishmentfeedbacks`
--

INSERT INTO `establishmentfeedbacks` (`id`, `establishment_id`, `name`, `rate`, `feedback`) VALUES
(1, 3, 'pooya', '', 'great sushi! I loved it'),
(2, 2, 'pooya', '', 'the pizza was pretty good.'),
(4, 3, 'admin', '', 'the burger was overcooked!'),
(5, 1, 'admin', '', 'they make great wraps!'),
(6, 5, 'craige', '', 'the food is good'),
(7, 4, 'pooya', '', 'very good');

-- --------------------------------------------------------

--
-- Table structure for table `establishmentitems`
--

CREATE TABLE IF NOT EXISTS `establishmentitems` (
  `id` int(10) unsigned NOT NULL auto_increment,
  `establishment_id` int(11) NOT NULL,
  `type` varchar(20) NOT NULL,
  `description` text NOT NULL,
  `price` varchar(5) NOT NULL,
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=28 ;

--
-- Dumping data for table `establishmentitems`
--

INSERT INTO `establishmentitems` (`id`, `establishment_id`, `type`, `description`, `price`) VALUES
(1, 1, 'Menu', 'Burgers', '8.00'),
(2, 1, 'Menu', 'Fries', '9.00'),
(3, 1, 'Menu', 'Sandwiches', '7.99'),
(4, 2, 'Menu', 'Deli Sandwich', '7.50'),
(5, 2, 'Menu', 'Pizza', '10.00'),
(6, 2, 'Menu', 'Salad', '5.99'),
(7, 2, 'Special', 'Daily soup', '3.99'),
(8, 2, 'Special', 'Daily entree', '12.00'),
(9, 4, 'Menu', 'Coffee', '2.00'),
(10, 4, 'Menu', 'Doughnuts', '1.50'),
(11, 4, 'Menu', 'Muffins', '2.50'),
(12, 5, 'Menu', 'Coffee', '1.99'),
(13, 5, 'Menu', 'Sandwiches', '5.99'),
(14, 6, 'Menu', 'Burger', '6.75'),
(15, 6, 'Menu', 'Fries', '3.75'),
(16, 7, 'Menu', 'Pizza', '10.00'),
(17, 7, 'Menu', 'Salad', '3.99'),
(18, 7, 'Special', 'Salad daily creation', '3.99'),
(19, 8, 'Menu', 'Coffee', '1.99'),
(20, 9, 'Menu', 'Stir fry', '5.99'),
(21, 9, 'Menu', 'Noodle bowl', '7.99'),
(22, 9, 'Menu', 'Salad', '3.99'),
(23, 11, 'Menu', 'Coffee', '1.75'),
(24, 11, 'Menu', 'Sandwich', '5.75'),
(25, 3, 'Beef Injection', 'Only offered on fridays', '6.00'),
(26, 3, 'Sushi', 'Fresh sushi courtesy of Wassabi... eat fresh, stay fresh', '7.25'),
(27, 3, 'Bacon & Turkey Wrap', 'Delicious wrap with buffalo sauce, tomato, cheese and lettuce.', '8.99');

-- --------------------------------------------------------

--
-- Table structure for table `establishments`
--

CREATE TABLE IF NOT EXISTS `establishments` (
  `id` int(10) unsigned NOT NULL auto_increment,
  `entity_id` int(11) NOT NULL,
  `vendor` varchar(20) NOT NULL,
  `timeOpen` time NOT NULL,
  `timeClose` time NOT NULL,
  `description` text NOT NULL,
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=13 ;

--
-- Dumping data for table `establishments`
--

INSERT INTO `establishments` (`id`, `entity_id`, `vendor`, `timeOpen`, `timeClose`, `description`) VALUES
(1, 1, 'Fast Break', '08:30:00', '15:30:00', 'Short Order Cooking - Burgers, Grilled Sandwiches, Fries, Fresh Express Items. Used as Concession during Athletic Events'),
(2, 2, 'Lab Cafe', '07:30:00', '16:30:00', 'Express Grab and Go Items, Toasted Sub-Sandwich Deli, Salad Bar, Bene Pizza, Daily Hot Entree, Daily Soup'),
(3, 3, 'The Owl', '11:00:00', '21:00:00', 'Bar and food'),
(4, 4, 'Tim Hortons', '07:30:00', '17:00:00', 'Assorted hot and cold beverages, express food items, donuts and muffins'),
(5, 5, 'Henderson Cafe', '11:00:00', '18:00:00', 'Coffee and sandwiches'),
(6, 6, 'Burger Studio', '07:00:00', '20:30:00', 'Burgers, Grilled Sandwiches, Fries'),
(7, 7, 'Topios', '11:00:00', '20:00:00', 'Daily Hot Buffet Features'),
(8, 8, 'Common Ground Coffee', '07:30:00', '17:00:00', 'Starbucks coffee, Assorted Pastry, Euro Baguette Sandwiches, Hot and Cold Beverages'),
(9, 9, 'Chopsticks', '11:00:00', '14:30:00', 'Noodle Bowls, Stir Fry Entree, Asian Salads, Fresh Rolls and Sushi'),
(10, 10, 'C-Store', '07:30:00', '17:00:00', 'Convenience Store w/Breakfast Muffins and Sandwich Wrap Deli'),
(11, 11, 'Henderson Cafe', '11:00:00', '17:00:00', 'Coffee and sandwiches'),
(12, 12, 'Luther Cafeteria', '11:00:00', '17:00:00', 'Cafeteria for Luther students');

-- --------------------------------------------------------

--
-- Table structure for table `eventfeedbacks`
--

CREATE TABLE IF NOT EXISTS `eventfeedbacks` (
  `id` int(10) unsigned NOT NULL auto_increment,
  `event_id` int(11) NOT NULL,
  `name` varchar(30) NOT NULL,
  `rate` varchar(10) NOT NULL,
  `feedback` text NOT NULL,
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=31 ;

--
-- Dumping data for table `eventfeedbacks`
--

INSERT INTO `eventfeedbacks` (`id`, `event_id`, `name`, `rate`, `feedback`) VALUES
(1, 2, 'admin', 'Awesome!!!', 'Gonna be a great time!!!'),
(2, 2, 'admin', 'Awesome!!!', 'Free drinks... Wooohooo....!!!!'),
(3, 2, 'Pooya', '', 'great!'),
(4, 2, 'Pooya', '', 'I''m impressed!'),
(25, 1, 'admin', '', 'all ages welcome 18 '),
(26, 10, 'pooya', '', 'Great presentation!'),
(27, 10, 'pooya', 'Awesome!!!', 'HEEEY\r\n'),
(28, 10, 'pooya', '', 'bla'),
(29, 9, 'pooya', '', 'lawwwww'),
(30, 2, 'pooya', '', 'feedback');

-- --------------------------------------------------------

--
-- Table structure for table `events`
--

CREATE TABLE IF NOT EXISTS `events` (
  `id` int(100) unsigned NOT NULL auto_increment,
  `entity_id` int(11) NOT NULL,
  `name` varchar(50) NOT NULL,
  `time_start` datetime NOT NULL,
  `time_end` datetime NOT NULL,
  `description` text NOT NULL,
  `ageRange` varchar(50) NOT NULL,
  `room` varchar(5) NOT NULL,
  `type` varchar(20) NOT NULL,
  PRIMARY KEY  (`id`),
  KEY `time_start` (`time_start`),
  KEY `time_end` (`time_end`),
  KEY `time_end_2` (`time_end`),
  KEY `time_end_3` (`time_end`),
  KEY `time_end_4` (`time_end`),
  KEY `time_end_5` (`time_end`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=13 ;

--
-- Dumping data for table `events`
--

INSERT INTO `events` (`id`, `entity_id`, `name`, `time_start`, `time_end`, `description`, `ageRange`, `room`, `type`) VALUES
(1, 44, 'Presentation day to faculty', '2011-03-30 00:00:00', '2011-03-30 00:30:00', '4th year project presentation for Sosftware System Enggs', 'all ages', '414', 'presentation'),
(2, 45, '::PARTY:: @ Pooyas', '2011-04-15 10:14:00', '2011-04-15 22:14:00', 'Party to celebrate graduation...\r\nGood times...', '19+', '434', 'party'),
(3, 46, 'FoooFest ', '2011-05-30 10:17:00', '2011-09-30 10:17:00', 'Come and eat as much as you want.... have a blast!!!!', 'all ages', '123', 'food'),
(5, 49, 'The Best Presentation', '2011-03-30 12:00:17', '2011-03-30 12:30:17', 'SEE 4', 'All ages of course', '414', 'presentation'),
(7, 52, 'karim events', '2011-03-30 12:38:00', '2011-12-30 12:38:00', 'Little description', '18+', '111', 'food'),
(8, 53, 'Project Day', '2011-04-02 08:30:00', '2011-04-02 16:45:00', 'Engineering project day!  Come take a look at all the projects done by the students.  Presentations will be going on throughout the day on the 6th floor.', 'All', '612', 'fair'),
(9, 54, 'Engineering Law and Ethics Party', '2011-04-19 11:30:00', '2011-04-19 13:30:00', 'Congratulations on completing your law and ethics class, come on down to the Owl and celebrate!', 'ENGG 401 students', '1', 'party'),
(10, 55, 'UofR Life Presentation', '2011-04-02 10:15:00', '2011-04-02 10:45:00', 'UofR Life is an iPhone application that displays events and available food services at the University of Regina. All events will be generated by the users, and the users will be able to subscribe to events. There is a companion website that contains additional functionality from the iPhone application.', 'All ages are welcome', '612', 'presentation'),
(11, 56, 'Copyright vs. Community', '2011-04-02 16:00:00', '2011-04-02 18:00:00', 'Dr. Richard Stallman is giving a keynote speech about the copyright process and it''s effects on the community as a whole.', 'Any', '200', 'presentation'),
(12, 57, 'yahoo', '2011-04-06 21:37:11', '2011-04-06 21:37:11', 'nice', '10-30', '308.3', 'fair');

-- --------------------------------------------------------

--
-- Table structure for table `locations`
--

CREATE TABLE IF NOT EXISTS `locations` (
  `id` int(10) unsigned NOT NULL auto_increment,
  `name` varchar(50) NOT NULL,
  `xCoordinate` int(11) NOT NULL,
  `yCoordinate` int(11) NOT NULL,
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=17 ;

--
-- Dumping data for table `locations`
--

INSERT INTO `locations` (`id`, `name`, `xCoordinate`, `yCoordinate`) VALUES
(1, 'Administration-Humanities', 0, 0),
(2, 'Campion College', 0, 0),
(3, 'Centre of Kinesiology', 0, 0),
(4, 'Classroom Building', 0, 0),
(5, 'College West', 0, 0),
(6, 'Day Care', 0, 0),
(7, 'Education Building', 0, 0),
(8, 'First Nation University of Canada', 0, 0),
(9, 'Laboratory Building', 0, 0),
(10, 'Luther College', 0, 0),
(11, 'Language Institute', 0, 0),
(12, 'Dr. John Archer Library', 0, 0),
(13, 'North Residence', 0, 0),
(14, 'Research and Innovation Centre', 0, 0),
(15, 'Dr. William Riddell Centre', 0, 0),
(16, 'South Residence', 0, 0);

-- --------------------------------------------------------

--
-- Table structure for table `subscriptions`
--

CREATE TABLE IF NOT EXISTS `subscriptions` (
  `id` int(10) unsigned NOT NULL auto_increment,
  `user_id` int(10) unsigned NOT NULL,
  `event_id` int(10) unsigned NOT NULL,
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=34 ;

--
-- Dumping data for table `subscriptions`
--

INSERT INTO `subscriptions` (`id`, `user_id`, `event_id`) VALUES
(2, 2, 2),
(5, 4, 5),
(10, 4, 10),
(11, 4, 8),
(12, 4, 1),
(19, 9, 12),
(20, 1, 10),
(21, 4, 9),
(27, 5, 10),
(30, 5, 9),
(31, 5, 8),
(32, 5, 2),
(33, 1, 3);

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE IF NOT EXISTS `users` (
  `id` int(10) unsigned NOT NULL auto_increment,
  `firstName` varchar(50) NOT NULL,
  `lastName` varchar(50) NOT NULL,
  `username` varchar(50) NOT NULL,
  `password` varchar(50) NOT NULL,
  `role` varchar(20) NOT NULL,
  `email` varchar(50) NOT NULL,
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=11 ;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `firstName`, `lastName`, `username`, `password`, `role`, `email`) VALUES
(1, 'admin', 'admin', 'admin', '94c882c8506497a9f031ca5a4db6d0143c97fe45', 'admin', ''),
(2, 'luis', 'pizarro', 'piedra2l', '88408337b145bea8f57ce56be5e63ef1d4ddec45', 'user', 'piedra2l@uregina.ca'),
(3, 'Alexis', 'Louise', 'owl@uregina', '94c882c8506497a9f031ca5a4db6d0143c97fe45', 'vendor', 'owl@uregina.ca'),
(4, 'Craig', 'Enmark', 'craige', 'a7587504f0ba513c3715a9861723f3c9e4317c19', 'user', 'enmark3c@uregina.ca'),
(5, 'Pooya', 'Sami', 'pooya', '94c882c8506497a9f031ca5a4db6d0143c97fe45', 'user', 'pooya1983@hotmail.com'),
(6, 'some', 'user', 'random', '94c882c8506497a9f031ca5a4db6d0143c97fe45', 'user', ''),
(7, 'victor', 'pizarro', 'labarthe', '54088447230ddae3162a8bcc0250f8cf52beced0', 'user', 'jpizarro0109@yahoo.com'),
(8, 'testing', 'testin', 'testing', 'ab42a3de60eecd3f7b6b38b7aa58e5e626b6967a', 'user', 'adasdasd'),
(9, 'Tanay', 'Dey', 'dtanay2004', '2eccfdabecab7e7225a7609e7a666785f5a0ca70', 'user', 'dtanay2004@yahoo.com'),
(10, 'Natalia', 'Filomeno', 'natty', '94c882c8506497a9f031ca5a4db6d0143c97fe45', 'user', 'natty@com.com');

-- --------------------------------------------------------

--
-- Table structure for table `vmachinefeedbacks`
--

CREATE TABLE IF NOT EXISTS `vmachinefeedbacks` (
  `id` int(10) unsigned NOT NULL auto_increment,
  `vmachine_id` int(11) NOT NULL,
  `name` varchar(30) NOT NULL,
  `rate` varchar(10) NOT NULL,
  `feedback` text NOT NULL,
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=13 ;

--
-- Dumping data for table `vmachinefeedbacks`
--

INSERT INTO `vmachinefeedbacks` (`id`, `vmachine_id`, `name`, `rate`, `feedback`) VALUES
(9, 7, 'admin', '', 'it never returned my change'),
(10, 9, 'admin', '', 'it didnt give me change!?'),
(11, 16, 'pooya', '', 'it never returned my change!'),
(12, 5, 'craige', '', 'bien');

-- --------------------------------------------------------

--
-- Table structure for table `vmachines`
--

CREATE TABLE IF NOT EXISTS `vmachines` (
  `id` int(10) unsigned NOT NULL auto_increment,
  `entity_id` int(11) NOT NULL,
  `cardEnable` varchar(20) NOT NULL,
  `items` text NOT NULL,
  `floor` int(10) unsigned NOT NULL,
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=32 ;

--
-- Dumping data for table `vmachines`
--

INSERT INTO `vmachines` (`id`, `entity_id`, `cardEnable`, `items`, `floor`) VALUES
(1, 13, 'yes', 'Coca-Cola drinks', 1),
(2, 14, 'no', 'Chips and snacks', 1),
(3, 15, 'no', 'Water', 1),
(4, 16, 'no', 'Coca-Cola drinks', 1),
(5, 17, 'no', 'Chips and snacks', 1),
(6, 18, 'no', 'Energy drinks', 1),
(7, 19, 'no', 'Water', 1),
(8, 20, 'yes', 'Coca-Cola drinks', 1),
(9, 21, 'no', 'Energy drinks', 1),
(10, 22, 'yes', 'Coca-Cola drinks', 1),
(11, 23, 'no', 'Pepsi drinks', 1),
(12, 24, 'no', 'Coffee', 1),
(13, 25, 'no', 'Chips and snacks', 1),
(14, 26, 'no', 'Snack food', 1),
(15, 27, 'no', 'Water', 1),
(16, 28, 'no', 'Coca-Cola drinks', 4),
(17, 29, 'yes', 'Coca-Cola drinks', 1),
(18, 30, 'no', 'Water', 1),
(19, 31, 'no', 'Energy drinks', 1),
(20, 32, 'no', 'Chips', 1),
(21, 33, 'no', 'Candy', 1),
(22, 34, 'no', 'Snack food', 1),
(23, 35, 'no', 'Pepsi drinks', 1),
(24, 36, 'no', 'Snack foods', 1),
(25, 37, 'no', 'Water', 1),
(26, 38, 'no', 'Water', 1),
(27, 39, 'no', 'Energy drinks', 1),
(28, 40, 'no', 'Pepsi drinks', 1),
(29, 41, 'yes', 'Coca-Cola drinks', 1),
(30, 42, 'yes', 'Coca-Cola drinks', 1),
(31, 43, 'no', 'Pepsi drinks', 1);
