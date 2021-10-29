CREATE TABLE `ngwd_vehicles` (
    `id` Int(11) AUTO_INCREMENT NOT NULL,
    `owner` varchar(48) NOT NULL,
    `modelName` varchar(55) DEFAULT NULL,
    `modelHash` Int(11) NOT NULL,
    `modelClass` varchar(55) DEFAULT NULL,
    `localizedName` varchar(55) DEFAULT NULL,
    `plate` varchar(12) NOT NULL,
    `garage` varchar(60) DEFAULT 'Legion',
    `preview` varchar(255) DEFAULT 'https://i.imgur.com/CHmtRZL.png',
    `vehicleCondition` longtext,
    `vehicleProperties` longtext,
    `vehicleMods` longtext,
    PRIMARY KEY (`id`)
);
