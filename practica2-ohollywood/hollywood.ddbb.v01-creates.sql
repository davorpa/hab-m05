-- -----------------------------------------------------
-- Schema `ohollywood`
-- -----------------------------------------------------

DROP DATABASE IF EXISTS `ohollywood`;

CREATE DATABASE IF NOT EXISTS `ohollywood`
        DEFAULT CHARACTER SET utf8mb4
        COLLATE utf8mb4_unicode_ci;

USE `ohollywood`;


--
-- ENTIDADES / TABLAS PRINCIPALES.
--



-- -----------------------------------------------------
-- Table `premio`
-- -----------------------------------------------------

DROP TABLE IF EXISTS `prize`;

CREATE TABLE IF NOT EXISTS `prize` (
    `id`                INT UNSIGNED
                        NOT NULL
                        AUTO_INCREMENT
                        COMMENT 'Identificador',
    `title`             VARCHAR(255)
                        NOT NULL
                        COMMENT 'Título/Denominación',
    `great_category`    TINYINT UNSIGNED
                        NULL
                        DEFAULT 0
                        COMMENT 'Flag de gran categoría',
    `ts_created_at`     TIMESTAMP
                        NOT NULL
                        DEFAULT CURRENT_TIMESTAMP
                        COMMENT 'Fecha de creación del registro',
    `ts_updated_at`     TIMESTAMP
                        NULL
                        ON UPDATE CURRENT_TIMESTAMP
                        COMMENT 'Fecha de última actualización del registro',
    CONSTRAINT `prize_PK`
        PRIMARY KEY (`id`),
    CONSTRAINT `title_UK`
        UNIQUE (`title`),
    CONSTRAINT `great_category_CK`
        CHECK (`great_category` = 0 OR `great_category` = 1)
)
ENGINE = INNODB
COMMENT 'Entidad Premios Oscar';

-- Indexes en campos de búsqueda
CREATE FULLTEXT INDEX `prize_title_full_IDX`
    ON `prize` (`title`)
        COMMENT 'FULLTXT Título/Denominación search index';

CREATE INDEX `prize_title_IDX`
    ON `prize` (`title`)
        COMMENT 'BTREE Título/Denominación search index';

CREATE INDEX `prize_gcat_IDX`
    ON `prize` (`great_category`)
        COMMENT 'BTREE Flag Gran Categoría search index';



-- -----------------------------------------------------
-- Table `pelicula`
-- -----------------------------------------------------

DROP TABLE IF EXISTS `film`;

CREATE TABLE IF NOT EXISTS `film` (
    `id`                BIGINT UNSIGNED
                        NOT NULL
                        AUTO_INCREMENT
                        COMMENT 'Identificador',
    `title`             VARCHAR(255)
                        NOT NULL
                        COMMENT 'Título',
    `num_actors`        SMALLINT UNSIGNED
                        NOT NULL
                        COMMENT 'Número de actores',
    `qualification`     ENUM('TP', 'M-3', 'M-5', 'M-8', 'M-10', 'M-13', 'M-18')
                        NULL
                        DEFAULT 'TP'
                        COMMENT 'Calificación pública',
    `ts_created_at`     TIMESTAMP
                        NOT NULL
                        DEFAULT CURRENT_TIMESTAMP
                        COMMENT 'Fecha de creación del registro',
    `ts_updated_at`     TIMESTAMP
                        NULL
                        ON UPDATE CURRENT_TIMESTAMP
                        COMMENT 'Fecha de última actualización del registro',
    CONSTRAINT `film_PK`
        PRIMARY KEY (`id`)
)
ENGINE = INNODB
COMMENT 'Entidad Película';

-- Indexes en campos de búsqueda
CREATE FULLTEXT INDEX `film_title_full_IDX`
    ON `film` (`title`)
        COMMENT 'FULLTXT Título search index';

CREATE INDEX `film_title_IDX`
    ON `film` (`title`)
        COMMENT 'BTREE Título search index';

CREATE INDEX `film_qualification_IDX`
    ON `film` (`qualification`)
        COMMENT 'BTREE Calificación search index';



-- -----------------------------------------------------
-- Table `genero`
-- -----------------------------------------------------

DROP TABLE IF EXISTS `genre`;

CREATE TABLE IF NOT EXISTS `genre` (
    `id`                INT UNSIGNED
                        NOT NULL
                        AUTO_INCREMENT
                        COMMENT 'Identificador',
    `name`              VARCHAR(255)
                        NOT NULL
                        COMMENT 'Nombre/Denominación',
    `ts_created_at`     TIMESTAMP
                        NOT NULL
                        DEFAULT CURRENT_TIMESTAMP
                        COMMENT 'Fecha de creación del registro',
    `ts_updated_at`     TIMESTAMP
                        NULL
                        ON UPDATE CURRENT_TIMESTAMP
                        COMMENT 'Fecha de última actualización del registro',
    CONSTRAINT `genre_PK`
        PRIMARY KEY (`id`),
    CONSTRAINT `name_UK`
        UNIQUE (`name`)
)
ENGINE = INNODB
COMMENT 'Entidad Género';

-- Indexes en campos de búsqueda
CREATE FULLTEXT INDEX `genre_name_full_IDX`
    ON `genre` (`name`)
        COMMENT 'FULLTXT Nombre/Denominación search index';

CREATE INDEX `genre_name_IDX`
    ON `genre` (`name`)
        COMMENT 'BTREE Nombre/Denominación search index';



-- -----------------------------------------------------
-- Table `datos_produccion`
-- -----------------------------------------------------

DROP TABLE IF EXISTS `production_data`;

CREATE TABLE IF NOT EXISTS `production_data` (
    `id`                BIGINT UNSIGNED
                        NOT NULL
                        AUTO_INCREMENT
                        COMMENT 'Identificador',
    `producer_company`  VARCHAR(255)
                        NOT NULL
                        COMMENT 'Nombre de la productora encargada de la película',
    `cost`              DECIMAL(12 , 2)
                        NOT NULL
                        COMMENT 'Coste de dinero asociado a la producción',
    `end_production_date` TIMESTAMP
                        NOT NULL
                        COMMENT 'Fecha en la que finalizó',
    `ts_created_at`     TIMESTAMP
                        NOT NULL
                        DEFAULT CURRENT_TIMESTAMP
                        COMMENT 'Fecha de creación del registro',
    `ts_updated_at`     TIMESTAMP
                        NULL
                        ON UPDATE CURRENT_TIMESTAMP
                        COMMENT 'Fecha de última actualización del registro',
    CONSTRAINT `production_data_PK` PRIMARY KEY (`id`),
    CONSTRAINT `production_cost_CK`
        CHECK (`cost` >= 0)
)
ENGINE = INNODB
COMMENT 'Entidad Datos de Producción';

-- Indexes en campos de búsqueda
CREATE FULLTEXT INDEX `production_data_producer_full_IDX`
    ON `production_data` (`producer_company`)
        COMMENT 'FULLTXT Nombre productora search index';

CREATE INDEX `production_data_producer_IDX`
    ON `production_data` (`producer_company`)
        COMMENT 'BTREE Nombre productora search index';

CREATE INDEX `production_data_cost_IDX`
    ON `production_data` (`cost`)
        COMMENT 'BTREE Coste de dinero search index';



-- -----------------------------------------------------
-- Table `pelicula_premios`
-- (RELACIÓN (N:M) PREMIOS QUE GANÓ UNA PELÍCULA)
-- -----------------------------------------------------

DROP TABLE IF EXISTS `film_prizes`;

CREATE TABLE IF NOT EXISTS `film_prizes` (
    `id_prize`          INT UNSIGNED
                        NOT NULL
                        COMMENT 'Identificador de premio',
    `id_film`           BIGINT UNSIGNED
                        NOT NULL
                        COMMENT 'Identificador de película',
    `votes`             INT UNSIGNED
                        NULL
                        DEFAULT 0
                        COMMENT 'Número de votos recibidos',
    `year`              SMALLINT UNSIGNED
                        NOT NULL
                        COMMENT 'Año de adquisición',
    `ts_created_at`     TIMESTAMP
                        NOT NULL
                        DEFAULT CURRENT_TIMESTAMP
                        COMMENT 'Fecha de creación del registro',
    `ts_updated_at`     TIMESTAMP
                        NULL
                        ON UPDATE CURRENT_TIMESTAMP
                        COMMENT 'Fecha de última actualización del registro',
    CONSTRAINT `filmprize_PK`
        PRIMARY KEY (`id_film`, `id_prize`),
    CONSTRAINT `filmprize_id_prize_FK`
        FOREIGN KEY (`id_prize`)
        REFERENCES `prize` (`id`),
    CONSTRAINT `filmprize_id_film_FK`
        FOREIGN KEY (`id_film`)
        REFERENCES `film` (`id`),
    CONSTRAINT `filmprize_year_CK`
        CHECK (`year` > 1700)
)
ENGINE = INNODB
COMMENT 'Relación (N:M) de Premios Óscar que ganó una Película';

-- Indexes en campos de búsqueda
CREATE INDEX `filmprize_year_IDX`
		ON `film_prizes` (`year`)
        COMMENT 'FULLTXT Año del premio search index';



-- -----------------------------------------------------
-- Table `pelicula_generos`
-- (RELACIÓN (0:N) GÉNEROS EN LOS QUE SE CLASIFICA UNA PELÍCULA.)
-- -----------------------------------------------------

DROP TABLE IF EXISTS `film_genres`;

CREATE TABLE IF NOT EXISTS `film_genres` (
    `id_film`           BIGINT UNSIGNED
                        NOT NULL
                        COMMENT 'Identificador de película',
    `id_genre`          INT UNSIGNED
                        NOT NULL
                        COMMENT 'Identificador de género',
    `ts_created_at`     TIMESTAMP
                        NOT NULL
                        DEFAULT CURRENT_TIMESTAMP
                        COMMENT 'Fecha de creación del registro',
    `ts_updated_at`     TIMESTAMP
                        NULL
                        ON UPDATE CURRENT_TIMESTAMP
                        COMMENT 'Fecha de última actualización del registro',
    CONSTRAINT `filmgenre_PK`
        PRIMARY KEY (`id_film`),
    CONSTRAINT `filmgenre_id_film_fk`
        FOREIGN KEY (`id_film`)
        REFERENCES `film` (`id`),
    CONSTRAINT `filmgenre_id_genre_fk`
        FOREIGN KEY (`id_genre`)
        REFERENCES `genre` (`id`)
)
ENGINE = INNODB
COMMENT 'Relación (0:N) de los Géneros en los que se clasifica una Película';



-- -----------------------------------------------------
-- Table `pelicula_datos_produccion`
-- (RELACIÓN (0:N) DATOS DE PRODUCCIÓN QUE POSEE UNA PELÍCULA.)
-- -----------------------------------------------------

DROP TABLE IF EXISTS `film_production_data`;

CREATE TABLE IF NOT EXISTS `film_production_data` (
    `id_film`           BIGINT UNSIGNED
                        NOT NULL
                        COMMENT 'Identificador de película',
    `id_production_data` BIGINT UNSIGNED
                        NOT NULL
                        COMMENT 'Identificador de datos de producción',
    `ts_created_at`     TIMESTAMP
                        NOT NULL
                        DEFAULT CURRENT_TIMESTAMP
                        COMMENT 'Fecha de creación del registro',
    `ts_updated_at`     TIMESTAMP NULL
                        ON UPDATE CURRENT_TIMESTAMP
                        COMMENT 'Fecha de última actualización del registro',
    CONSTRAINT `filmproduction_PK`
        PRIMARY KEY (`id_film`, `id_production_data`),
    CONSTRAINT `filmproduction_id_film_FK`
        FOREIGN KEY (`id_film`)
        REFERENCES `film` (`id`),
    CONSTRAINT `filmproduction_id_production_data_FK`
        FOREIGN KEY (`id_production_data`)
        REFERENCES `production_data` (`id`)
)
ENGINE = INNODB
COMMENT 'Relación (0:N) de los Datos de Producción que posee una Película';


--
-- COMPROBAR CREACIONES.
--

SHOW tables;
SHOW databases;

SHOW CREATE TABLE `film`;
DESCRIBE `film`;
