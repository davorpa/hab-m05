DROP DATABASE IF EXISTS`HOLLYWOOD_OSCARS`;
CREATE DATABASE `HOLLYWOOD_OSCARS` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
USE `HOLLYWOOD_OSCARS`; 

# 
# ENTIDADES / TABLAS PRINCIPALES
#

DROP TABLE IF EXISTS `Prize`;
CREATE TABLE `Prize` (
	`id`				INT UNSIGNED NOT NULL AUTO_INCREMENT				COMMENT 'Identificador',
    `title`				VARCHAR(255) NOT NULL								COMMENT 'Título/Denominación',
    `great_category`	TINYINT UNSIGNED DEFAULT 0							COMMENT 'Flag de gran categoría',
    CONSTRAINT `prize_pk` PRIMARY KEY(`id`),
    CONSTRAINT `title_uniq` UNIQUE (`title`),
    -- restringimos a dato BIT
    CONSTRAINT `great_category_boolck` CHECK (`great_category` = 0 OR `great_category` = 1)
);

DROP TABLE IF EXISTS `Film`;
CREATE TABLE `Film` (
	`id`				BIGINT UNSIGNED NOT NULL AUTO_INCREMENT								COMMENT 'Identificador',
    `title`				VARCHAR(255) NOT NULL												COMMENT 'Título',
    `qualification`		ENUM("TP", "+3", "+5", "+8", "+10", "+13", "+18") DEFAULT "TP"		COMMENT 'Calificación pública',
    CONSTRAINT `film_pk` PRIMARY KEY(`id`)
);

DROP TABLE IF EXISTS `Genre`;
CREATE TABLE `Genre` (
	`id`				INT UNSIGNED NOT NULL AUTO_INCREMENT				COMMENT 'Identificador',
    `name`				VARCHAR(255) NOT NULL								COMMENT 'Nombre/Denominación',
    CONSTRAINT `genre_pk` PRIMARY KEY(`id`),
    CONSTRAINT `name_uniq` UNIQUE (`name`)
);


# 
# RELACIÓN (N:M) PREMIOS QUE GANÓ UNA PELÍCULA
#
DROP TABLE IF EXISTS `FilmPrizes`;
CREATE TABLE `FilmPrizes` (
	`id_prize`				INT UNSIGNED NOT NULL								COMMENT 'Identificador de premio',
	`id_film`				BIGINT UNSIGNED NOT NULL							COMMENT 'Identificador de película',
    `votes`					INT UNSIGNED DEFAULT 0								COMMENT 'Número de votos recibidos',
    `year`					SMALLINT UNSIGNED NOT NULL							COMMENT 'Año de adquisición',
    CONSTRAINT `filmprizes_pk` PRIMARY KEY(`id_film`, `id_prize`),
    CONSTRAINT `id_prize_fk` FOREIGN KEY(`id_prize`) REFERENCES Prize(`id`) 
			ON DELETE NO ACTION
            ON UPDATE NO ACTION,
    CONSTRAINT `id_film_fk` FOREIGN KEY(`id_film`) REFERENCES Film(`id`)
			ON DELETE NO ACTION
            ON UPDATE NO ACTION,
    CONSTRAINT `year_greather_than_ck1` CHECK (year > 1700)
);
