CREATE DATABASE IF NOT EXISTS escuela CHARACTER SET="utf8mb4" COLLATE="utf8mb4_unicode_ci";

USE escuela;

CREATE TABLE IF NOT EXISTS curso (
    cod_curso INTEGER AUTO_INCREMENT PRIMARY KEY,
	num_curso INTEGER NOT NULL,
	nivel_educativo VARCHAR(50)
)  ENGINE=INNODB;

CREATE TABLE IF NOT EXISTS grupo (
	id INTEGER AUTO_INCREMENT PRIMARY KEY,
    cod_curso INTEGER NOT NULL,
    letra VARCHAR(2) NOT NULL,
    CONSTRAINT grupo_cod_curso_fk1
    FOREIGN KEY(cod_curso) REFERENCES curso(cod_curso) ON DELETE CASCADE
) ENGINE=INNODB;

CREATE TABLE IF NOT EXISTS aula (
    cod_aula INTEGER AUTO_INCREMENT PRIMARY KEY,
	id_grupo INTEGER NOT NULL,
	num_plazas INTEGER NOT NULL,
    num_ordenadores INTEGER NOT NULL,
    CONSTRAINT aula_id_grupo_fk1
    FOREIGN KEY(id_grupo) REFERENCES grupo(id) ON DELETE CASCADE
) ENGINE=INNODB;

CREATE TABLE IF NOT EXISTS alumno (
    num_expediente INTEGER AUTO_INCREMENT PRIMARY KEY,
    id_grupo INTEGER NOT NULL,
    nombre VARCHAR(50) NOT NULL,
    apellido_1 VARCHAR(50) NOT NULL,
    apellido_2 VARCHAR(50) NOT NULL,
    telefono VARCHAR(50) NOT NULL,
    fecha_nacimiento DATE,
	CONSTRAINT alumno_id_grupo_fk1
    FOREIGN KEY (id_grupo) REFERENCES grupo(id) ON DELETE CASCADE
) ENGINE=INNODB;

CREATE TABLE IF NOT EXISTS beca (
    id INTEGER AUTO_INCREMENT PRIMARY KEY,
	num_exp_alumno INTEGER NOT NULL UNIQUE,
    cuantia INTEGER,
	fecha DATE,
    CONSTRAINT beca_num_exp_alumno_fk1
    FOREIGN KEY(num_exp_alumno) REFERENCES alumno(num_expediente) ON DELETE CASCADE
) ENGINE=INNODB;

#EMPRESAS

CREATE TABLE IF NOT EXISTS empresa (
    cod_empresa INTEGER AUTO_INCREMENT PRIMARY KEY,
	nombre VARCHAR(50)
)  ENGINE=INNODB;

CREATE TABLE IF NOT EXISTS profesor (
	dni VARCHAR(9) PRIMARY KEY,
    cod_empresa INTEGER NOT NULL,
	nombre VARCHAR(50),
	telefono VARCHAR(20),
    direccion VARCHAR(100),
	CONSTRAINT profesor_cod_empresa_fk1
    FOREIGN KEY(cod_empresa) REFERENCES empresa(cod_empresa) ON DELETE CASCADE
) ENGINE=INNODB;

CREATE TABLE IF NOT EXISTS modulo (
	id INTEGER AUTO_INCREMENT PRIMARY KEY,
    cod_modulo VARCHAR(3) NOT NULL,
    dni_profesor VARCHAR(9) NOT NULL, 
	nombre VARCHAR(50),
	CONSTRAINT modulo_dni_profesor_fk1
    FOREIGN KEY(dni_profesor) REFERENCES profesor(dni) ON DELETE CASCADE
) ENGINE=INNODB;

CREATE TABLE IF NOT EXISTS tema (
	cod_tema INTEGER AUTO_INCREMENT NOT NULL PRIMARY KEY,
	cod_modulo INTEGER NOT NULL,
    titulo VARCHAR(50) NOT NULL, 
	CONSTRAINT tema_cod_modulo_fk1
    FOREIGN KEY(cod_modulo) REFERENCES modulo(id) ON DELETE CASCADE
) ENGINE=INNODB;

#asociacion modulo alumno 
CREATE TABLE IF NOT EXISTS modulo_alumno (
	cod_modulo INTEGER NOT NULL,
    num_expediente INTEGER NOT NULL,
    nota INTEGER NOT NULL,
    PRIMARY KEY(cod_modulo, num_expediente),
	CONSTRAINT modulo_alumno_cod_modulo_fk1
    FOREIGN KEY(cod_modulo) REFERENCES modulo(id) ON DELETE CASCADE,
    CONSTRAINT modulo_alumno_num_expedient2_fk2
	FOREIGN KEY(num_expediente) REFERENCES alumno(num_expediente) ON DELETE CASCADE
) ENGINE=INNODB;