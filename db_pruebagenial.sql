CREATE DATABASE prueba_genial CHARACTER SET="latin7";
USE prueba_genial;
CREATE TABLE genio (nombre VARCHAR(20));
INSERT INTO genio VALUES("ñu"),("vacío"),("€"),("€");
DROP DATABASE prueba_genial;

CREATE DATABASE prueba_genial CHARACTER SET="utf8mb4" COLLATE="utf8mb4_spanish_ci";
USE prueba_genial;
CREATE TABLE genio (nombre VARCHAR(20));
INSERT INTO genio VALUES("ñu"),("vacío"),("€"),("€");

SELECT * FROM genio;
DROP TABLE genio;

DESCRIBE genio;