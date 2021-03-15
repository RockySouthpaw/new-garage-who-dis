CREATE TABLE `ngwd_vehicles` (
    `id` Int(11) AUTO_INCREMENT NOT NULL,
    `owner` varchar(48) NOT NULL,
    `model` varchar(55) NOT NULL,
    `plate` varchar(12) NOT NULL,
    `garage` varchar(60) NOT NULL DEFAULT 'Legion',
    // Properties, Condition, Mods still need to go here
    PRIMARY KEY (`id`)
);