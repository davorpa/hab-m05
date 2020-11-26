DROP DATABASE IF EXISTS`HOLLYWOOD_OSCARS`;
CREATE DATABASE `HOLLYWOOD_OSCARS` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
USE `HOLLYWOOD_OSCARS`; 

# 
# ENTIDADES / TABLAS PRINCIPALES.
#

DROP TABLE IF EXISTS `Prize`;
CREATE TABLE `Prize` (
	`id`				INT UNSIGNED NOT NULL AUTO_INCREMENT				COMMENT 'Identificador',
    `title`				VARCHAR(255) NOT NULL								COMMENT 'Título/Denominación',
    `great_category`	TINYINT UNSIGNED DEFAULT 0							COMMENT 'Flag de gran categoría',
    CONSTRAINT `prize_pk` PRIMARY KEY(`id`),
    CONSTRAINT `title_uniq` UNIQUE (`title`),
    -- restringimos a dato BIT
    CONSTRAINT `great_category_bool_ck` CHECK (`great_category` = 0 OR `great_category` = 1)
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

DROP TABLE IF EXISTS `ProductionData`;
CREATE TABLE `ProductionData` (
	`id`				BIGINT UNSIGNED NOT NULL AUTO_INCREMENT				COMMENT 'Identificador',
    `producer_company`	VARCHAR(255) NOT NULL								COMMENT 'Nombre de la productora encargada de la película',
	`cost`				DECIMAL(12,2) NOT NULL								COMMENT 'Coste de dinero asociado a la producción',
    `end_production_date` TIMESTAMP NOT NULL								COMMENT 'Fecha en la que finalizó',
    CONSTRAINT `production_data_pk` PRIMARY KEY(`id`),
    CONSTRAINT `production_cost_positive_ck` CHECK (`cost` >= 0)
);


# 
# RELACIÓN (N:M) PREMIOS QUE GANÓ UNA PELÍCULA.
#
DROP TABLE IF EXISTS `FilmPrizes`;
CREATE TABLE `FilmPrizes` (
	`id_prize`				INT UNSIGNED NOT NULL								COMMENT 'Identificador de premio',
	`id_film`				BIGINT UNSIGNED NOT NULL							COMMENT 'Identificador de película',
    `votes`					INT UNSIGNED DEFAULT 0								COMMENT 'Número de votos recibidos',
    `year`					SMALLINT UNSIGNED NOT NULL							COMMENT 'Año de adquisición',
    CONSTRAINT `filmprize_pk` PRIMARY KEY(`id_film`, `id_prize`),
    CONSTRAINT `filmprize_id_prize_fk` FOREIGN KEY(`id_prize`) REFERENCES `Prize`(`id`) 
			ON DELETE NO ACTION
            ON UPDATE NO ACTION,
    CONSTRAINT `filmprize_id_film_fk` FOREIGN KEY(`id_film`) REFERENCES `Film`(`id`)
			ON DELETE NO ACTION
            ON UPDATE NO ACTION,
    CONSTRAINT `filmprize_year_gt_ck` CHECK (`year` > 1700)
);

# 
# RELACIÓN (0:N) GENEROS EN LOS QUE SE CLASIFICA UNA PELÍCULA.
#
DROP TABLE IF EXISTS `FilmGenres`;
CREATE TABLE `FilmGenres` (
	`id_film`				BIGINT UNSIGNED NOT NULL							COMMENT 'Identificador de película',
	`id_genre`				INT UNSIGNED NOT NULL								COMMENT 'Identificador de género',
    CONSTRAINT `filmgenre_pk` PRIMARY KEY(`id_film`, `id_genre`),
    CONSTRAINT `filmgenre_id_film_fk` FOREIGN KEY(`id_film`) REFERENCES `Film`(`id`)
			ON DELETE NO ACTION
            ON UPDATE NO ACTION
);

# 
# RELACIÓN (0:N) DATOS DE PRODUCCIÓN QUE POSEE UNA PELÍCULA.
#
DROP TABLE IF EXISTS `FilmProductionData`;
CREATE TABLE `FilmProductionData` (
	`id_film`				BIGINT UNSIGNED NOT NULL							COMMENT 'Identificador de película',
	`id_genre`				INT UNSIGNED NOT NULL								COMMENT 'Identificador de género',
    CONSTRAINT `filmproduction_pk` PRIMARY KEY(`id_film`, `id_genre`),
    CONSTRAINT `filmproduction_id_film_fk` FOREIGN KEY(`id_film`) REFERENCES `Film`(`id`)
			ON DELETE NO ACTION
            ON UPDATE NO ACTION,
    CONSTRAINT `filmproduction_id_genre_fk` FOREIGN KEY(`id_genre`) REFERENCES `Genre`(`id`)
			ON DELETE NO ACTION
            ON UPDATE NO ACTION
);
