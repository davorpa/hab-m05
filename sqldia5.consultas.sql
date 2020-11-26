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

-- Segunda forma de insertar datos (especificando campos en el orden definido)
INSERT INTO usuario
		VALUES (NULL, 'Manolo', 'Gómez', 'López', '1950-01-14', 'manolo@test.me', 0, 1, NULL),
			   (NULL, 'Marío', 'De La Rosa', 'Pompillón-Jiménez', '1998-01-25', 'mariopj@test.me', 1, 1, 'Notas'); 
               
INSERT INTO usuario VALUES
	(NULL, "Laura", "Master", "Rockefeller", "1971-03-04", "lauramr@atm.com", 1, DEFAULT, NULL),
	(NULL, "Joseba", "Loco", "Motora", "1982-10-24", "joseba@atm.com", DEFAULT, DEFAULT, NULL);

-- Segunda forma de insertar datos (uso de SET) Al menos especificar los NOT NULL
INSERT INTO usuario SET
		nombre = 'Dolores', apellido1 = 'De Muelas', apellido2 = 'Sindientes', fecha_nacimiento = '1944-12-14';
