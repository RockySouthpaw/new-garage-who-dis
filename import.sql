CREATE TABLE `ngwd_garage` (
	`identifier` VARCHAR(48) NOT NULL,
	`plate` varchar(12) NOT NULL,
	`vehicle` longtext,
	`class` varchar(15) NOT NULL,
	`Engine Health` varchar(5) NOT NULL DEFAULT '1000',
	`Body Health` varchar(5) NOT NULL DEFAULT '1000',
	`Tank Health` varchar(5) NOT NULL DEFAULT '1000',
	`garage_location` varchar(60) NOT NULL DEFAULT 'Garage_1',
	PRIMARY KEY (`identifier`)
);