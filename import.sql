CREATE TABLE `ngwd_vehicle` (
    `id` Int(11) AUTO_INCREMENT NOT NULL,
    `owner` VARCHAR(48) NOT NULL,
    `plate` varchar(12) NOT NULL,
    `garage_location` varchar(60) NOT NULL DEFAULT 'Legion',
    PRIMARY KEY (`id`)
);