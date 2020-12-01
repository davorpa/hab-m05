
-- -----------------------------------------------------
-- Schema `ohollywood`
-- -----------------------------------------------------

USE `ohollywood`;



-- -----------------------------------------------------
-- Table `film_production`
-- (RELACIÓN (0:N:1) Pelicula producida por Productora)
-- -----------------------------------------------------

DROP TABLE IF EXISTS `film_production`;

CREATE TABLE IF NOT EXISTS `film_production` (
    `id_film`           BIGINT UNSIGNED
                        NOT NULL
                        COMMENT 'Identificador de película',
    `id_producer`       INT UNSIGNED
                        NOT NULL
                        COMMENT 'Identificador de productora',
    `ts_created_at`     TIMESTAMP
                        NOT NULL
                        DEFAULT CURRENT_TIMESTAMP
                        COMMENT 'Fecha de creación del registro',
    `ts_updated_at`     TIMESTAMP
                        NULL
                        ON UPDATE CURRENT_TIMESTAMP
                        COMMENT 'Fecha de última actualización del registro',
    CONSTRAINT `filmproduction_PK`
        PRIMARY KEY (`id_film`),
    CONSTRAINT `filmproduction_id_film_FK`
        FOREIGN KEY (`id_film`)
        REFERENCES `film` (`id`),
    CONSTRAINT `filmproduction_id_producer_FK`
        FOREIGN KEY (`id_producer`)
        REFERENCES `production_company` (`id`)
)
ENGINE = INNODB
COMMENT 'Relación PRODUCE (0:N-1:1) de Película y Productora';



-- -----------------------------------------------------
-- Table `datos_produccion`
-- -----------------------------------------------------

-- Bloqueamos tablas implicadas en el FIX de datos
LOCK TABLE  `production_company` AS pc    write,
            `production_data`             write,
            `production_data` AS pdu      write,
            `film_production`             write;


-- Pasamos los datos de una tabla a otra ...
INSERT INTO `film_production` (`id_film`, `id_producer`)
    SELECT DISTINCT `id_film`, `id_producer`
    FROM `production_data` pdu
        INNER JOIN `production_company` pc ON (pdu.id_producer = pc.id);


-- Eliminamos columna e índices de `production_data`.`id_producer`
-- que en v02 podía ser nullable
ALTER TABLE `production_data`
    DROP FOREIGN KEY `production_data_id_producer_FK`,
    DROP INDEX `production_data_id_producer_FK`;

ALTER TABLE `production_data`
    DROP COLUMN `id_producer`;


-- Desbloqueamos tablas anteriores
UNLOCK TABLES;
