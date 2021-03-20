CREATE TABLE `ngwd_vehicles` (
    `id` Int(11) AUTO_INCREMENT NOT NULL,
    `owner` varchar(48) NOT NULL,
    `modelHash` varchar(55) NOT NULL,
    `modelName` varchar(55) DEFAULT NULL,
    `plate` varchar(12) NOT NULL,
    `garage` varchar(60) DEFAULT 'Legion',
    PRIMARY KEY (`id`)
);