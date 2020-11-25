DROP DATABASE IF EXISTS SPORTIUM;
CREATE DATABASE SPORTIUM;
USE SPORTIUM;


CREATE TABLE LIGA(
	cod_liga			VARCHAR(9),
	nombre				VARCHAR(9),
	fecha_ini			DATE,
	fecha_fin			DATE,
	CONSTRAINT liga_pk PRIMARY KEY (cod_liga),
	CONSTRAINT liga_ck1 CHECK (fecha_fin > fecha_ini)
);

CREATE TABLE EQUIPO(
	cod_equipo			VARCHAR(9),
	cod_liga			VARCHAR(9),
	nombre				VARCHAR(9),
	CONSTRAINT equipo_pk PRIMARY KEY (cod_equipo),
	CONSTRAINT equipo_codliga_fk1 FOREIGN KEY (cod_liga)
		REFERENCES LIGA(cod_liga) ON DELETE RESTRICT
);

INSERT INTO LIGA VALUES('LIG1', 'LIGA 1', '2020-01-01', '2020-12-31');
INSERT INTO EQUIPO VALUES('EQUI1', 'LIG1', 'EQ PONG');

-- Error por la FK
DELETE FROM LIGA WHERE cod_liga = 'LIG1';
-- Error por la FK
ALTER TABLE LIGA DROP PRIMARY KEY;
-- Error debido a la CK: liga_ck1
ALTER TABLE LIGA DROP COLUMN fecha_ini;
-- Error debido a la CK: liga_ck1
ALTER TABLE LIGA RENAME COLUMN fecha_ini TO fecha_ini_new;

