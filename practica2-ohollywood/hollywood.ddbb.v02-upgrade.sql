
-- -----------------------------------------------------
-- Schema `ohollywood`
-- -----------------------------------------------------

USE `ohollywood`;



-- -----------------------------------------------------
-- Table `genero`
-- -----------------------------------------------------

-- Agregamos columna de tipo BIT
ALTER TABLE `genre`
    ADD COLUMN
    `children_suitable` TINYINT UNSIGNED
                        NULL
                        DEFAULT 0
                        COMMENT 'Apto para niños'
    AFTER `name`,
    ADD
    CONSTRAINT `children_suitable_CK`
        CHECK (`children_suitable` = 0 OR `children_suitable` = 1);



-- -----------------------------------------------------
-- Table `productora`
-- -----------------------------------------------------

CREATE TABLE IF NOT EXISTS `production_company` (
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
    CONSTRAINT `production_company_PK`
        PRIMARY KEY (`id`),
    CONSTRAINT `name_UK`
        UNIQUE (`name`)
)
ENGINE = INNODB
COMMENT 'Entidad Productora';

-- Indexes en campos de búsqueda
CREATE FULLTEXT INDEX `production_company_name_full_IDX`
    ON `production_company` (`name`)
        COMMENT 'FULLTXT Nombre/Denominación search index';

CREATE INDEX `production_company_name_IDX`
    ON `production_company` (`name`)
        COMMENT 'BTREE Nombre/Denominación search index';



-- -----------------------------------------------------
-- Table `datos_produccion`
-- -----------------------------------------------------

-- Bloqueamos tablas implicadas en el FIX de datos
LOCK TABLE  `production_company`          write,
            `production_company` AS pcu   write,
            `production_data`             write,
            `film_production_data`        write;


-- Modificamos la tabla para ...
ALTER TABLE `production_data`
    -- Soportar Relación PRODUCE 0:N con Productora
    ADD COLUMN
    `id_producer`       INT UNSIGNED
                        NULL
                        DEFAULT NULL
                        COMMENT 'Identificador Productora'
        AFTER `end_production_date`,
    ADD CONSTRAINT `production_data_id_producer_FK`
        FOREIGN KEY (`id_producer`)
        REFERENCES `production_company` (`id`);


-- Pasamos los datos de una tabla a otra ...
-- con lo que se generan IDs autoicrementales en Productora
INSERT INTO `production_company` (`name`)
    SELECT DISTINCT `producer_company`
    FROM `production_data`
    WHERE
        -- No se aceptan valores NULL en `name`
            `producer_company` IS NOT NULL
        -- No se aceptan duplicados en `name` (es UNIQUE)
        AND `producer_company` NOT IN (
                SELECT `name`
                FROM `production_company` pcu
        );

-- Seteamos los IDs generados
UPDATE `production_data`
        INNER JOIN `production_company`
            ON `production_company`.`name` = `production_data`.`producer_company`
    SET `production_data`.`id_producer` = `production_company`.`id`;
-- where clause can go here
;

-- Eliminamos columna e índices de `production_data`.`producer_company`
ALTER TABLE `production_data`
    DROP COLUMN `producer_company`,
    DROP INDEX `production_data_producer_full_IDX`,
    DROP INDEX `production_data_producer_IDX`;




-- La tabla relación `film_production_data` se va a eliminar más abajo
-- ya que pasa a ser una relación 1:1

-- Modificamos la tabla para ...
ALTER TABLE `production_data`
    -- Soportar Relación TIENE 1:1 con Película
    -- (Las constraints se hacen más abajo)
    ADD COLUMN
    `id_film`           BIGINT UNSIGNED
                        NOT NULL
                        COMMENT 'Identificador Película'
        FIRST;

-- Pasamos IDs de película de `film_production_data` a `production_data`
UPDATE `production_data`
        INNER JOIN `film_production_data`
            ON `film_production_data`.`id_production_data` = `production_data`.`id`
    SET `production_data`.`id_film` = `film_production_data`.`id_film`;
-- where clause can go here
;

-- Modificamos la tabla para quitar restricciones que permitan
-- eliminar tabla relación `film_production_data` más abajo
-- ya que pasa a ser una relación 1:1
ALTER TABLE `film_production_data`
    DROP FOREIGN KEY `filmproduction_id_film_FK`,
    DROP FOREIGN KEY `filmproduction_id_production_data_FK`,
    DROP INDEX `filmproduction_id_production_data_FK`;
ALTER TABLE `film_production_data`
    DROP PRIMARY KEY;


-- Modificamos la tabla para ...
ALTER TABLE `production_data`
    -- Eliminar tabla relación `film_production_data` más abajo
    -- ya que pasa a ser una relación 1:1
    DROP PRIMARY KEY,
    DROP COLUMN `id`,
    -- Soportar Relación TIENE 1:1 con Película
    ADD CONSTRAINT `production_data_PK`
        PRIMARY KEY (`id_film`),
    ADD CONSTRAINT `production_data_id_film_FK`
        FOREIGN KEY (`id_film`)
        REFERENCES `film` (`id`);


-- Desbloqueamos tablas anteriores
UNLOCK TABLES;



-- -----------------------------------------------------
-- Table `pelicula_generos`
-- (RELACIÓN (0:N) GÉNEROS EN LOS QUE SE CLASIFICA UNA PELÍCULA.)
-- -----------------------------------------------------

-- Actualizamos campos PK ya que la relación pasa a N:M
ALTER TABLE `film_genres`
    DROP PRIMARY KEY,
    ADD
    CONSTRAINT `filmgenre_PK`
        PRIMARY KEY (`id_film`, `id_genre`);



-- -----------------------------------------------------
-- Table `pelicula_datos_produccion`
-- (RELACIÓN (0:1-1:0) DATOS DE PRODUCCIÓN QUE POSEE UNA PELÍCULA.)
-- -----------------------------------------------------

-- Desaparece al pasar la cadinalidad a 1:1
DROP TABLE `film_production_data`;
