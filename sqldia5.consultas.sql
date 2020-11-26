DROP DATABASE IF EXISTS`SQLDIA5`;
CREATE DATABASE `SQLDIA5` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
USE `SQLDIA5`;

DROP TABLE IF EXISTS usuario;
CREATE TABLE usuario (
	id					BIGINT UNSIGNED AUTO_INCREMENT,
    nombre				VARCHAR(255) NOT NULL,
    apellido1			VARCHAR(255) NOT NULL,
    apellido2			VARCHAR(255) NOT NULL,
    fecha_nacimiento 	DATE NOT NULL,
    email				VARCHAR(255),
    empleado			TINYINT DEFAULT 0,
    activo				TINYINT DEFAULT 1,
    notas				TEXT,
    CONSTRAINT usuario_id_pk1 PRIMARY KEY(id),
    CONSTRAINT usuario_email_uk1 UNIQUE(email),
    CONSTRAINT usuario_fullname_uk1 UNIQUE(nombre, apellido1, apellido2),
    CONSTRAINT email_format_ck1 CHECK (activo = 0 OR activo = 1),
    CONSTRAINT empleado_bool_ck1 CHECK (empleado = 0 OR empleado = 1),
    CONSTRAINT activo_bool_ck1 CHECK (activo = 0 OR activo = 1)
);


-- Primera forma de insertar datos (especificando campos obligatorios)
INSERT INTO usuario (email, fecha_nacimiento, nombre, apellido1, apellido2)
		VALUES ('laura@tm.com', '1990-10-14', 'Laura', 'Rockefeller', 'Gizburg'),
			   ('manuel@atm.com', '1984-08-14', 'Manuel', 'García', 'Lopez'); 
