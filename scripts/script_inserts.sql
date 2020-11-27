INSERT INTO curso VALUES (null, 1, "inicial");
INSERT INTO curso VALUES (null, 2, "medio");
INSERT INTO curso VALUES (null, 3, "experto");

##CURSO 1
INSERT INTO `escuela`.`grupo`(`cod_curso`,`letra`)
VALUES ((select curso.cod_curso from curso where num_curso=1),"A");
INSERT INTO `escuela`.`grupo`(`cod_curso`,`letra`)
VALUES ((select curso.cod_curso from curso where num_curso=1),"B");
INSERT INTO `escuela`.`grupo`(`cod_curso`,`letra`)
VALUES ((select curso.cod_curso from curso where num_curso=1),"C");

##CURSO 2
INSERT INTO `escuela`.`grupo`(`cod_curso`,`letra`)
VALUES ((select curso.cod_curso from curso where num_curso=2),"A");
INSERT INTO `escuela`.`grupo`(`cod_curso`,`letra`)
VALUES ((select curso.cod_curso from curso where num_curso=2),"B");

##CURSO 3
INSERT INTO `escuela`.`grupo`(`cod_curso`,`letra`)
VALUES ((select curso.cod_curso from curso where num_curso=3),"A");

##ERROR
#INSERT INTO `escuela`.`grupo`(`cod_curso`,`letra`)
#VALUES ((select curso.cod_curso from curso where num_curso=9),"B");

##### AULA
INSERT INTO `escuela`.`aula`(`id_grupo`, `num_plazas`, `num_ordenadores`) 
VALUES ((select grupo.id from grupo where cod_curso=1 and letra="A"), 10, 4);
INSERT INTO `escuela`.`aula`(`id_grupo`, `num_plazas`, `num_ordenadores`) 
VALUES ((select grupo.id from grupo where cod_curso=1 and letra="B"), 10, 4);
INSERT INTO `escuela`.`aula`(`id_grupo`, `num_plazas`, `num_ordenadores`) 
VALUES ((select grupo.id from grupo where cod_curso=1 and letra="C"), 10, 5);

INSERT INTO `escuela`.`aula`(`id_grupo`, `num_plazas`, `num_ordenadores`) 
VALUES ((select grupo.id from grupo where cod_curso=2 and letra="A"), 10, 5);

INSERT INTO `escuela`.`aula`(`id_grupo`, `num_plazas`, `num_ordenadores`) 
VALUES ((select grupo.id from grupo where cod_curso=3 and letra="A"), 10, 3);

#### ALUMNOS

#1A
INSERT INTO `escuela`.`alumno` (`id_grupo`, `nombre`, `apellido_1`, `apellido_2`, `telefono`, `fecha_nacimiento`)
VALUES ((select grupo.id from grupo where cod_curso=1 and letra="A"), "Mariano", "Toledo", "Garcia", "981112233", DATE("1983-10-30"));

INSERT INTO `escuela`.`alumno` (`id_grupo`, `nombre`, `apellido_1`, `apellido_2`, `telefono`, `fecha_nacimiento`)
VALUES ((select grupo.id from grupo where cod_curso=1 and letra="A"), "Jacobo", "Freire", "", "981112244", DATE("1983-01-30"));

INSERT INTO `escuela`.`alumno` (`id_grupo`, `nombre`, `apellido_1`, `apellido_2`, `telefono`, `fecha_nacimiento`)
VALUES ((select grupo.id from grupo where cod_curso=1 and letra="A"), "Rogelio", "Muñiz", "Alvarez", "981112255", DATE("1983-06-30"));

INSERT INTO `escuela`.`alumno` (`id_grupo`, `nombre`, `apellido_1`, `apellido_2`, `telefono`, `fecha_nacimiento`)
VALUES ((select grupo.id from grupo where cod_curso=1 and letra="A"), "Beatriz", "Palomo", "Vidal", "981112266", DATE("1983-01-02"));

INSERT INTO `escuela`.`beca` (`num_exp_alumno`, `cuantia`, `fecha`)
VALUES ((select num_expediente from alumno where nombre="Beatriz" and apellido_1="Palomo"), 1000, DATE("1982-02-20"));

INSERT INTO `escuela`.`alumno` (`id_grupo`, `nombre`, `apellido_1`, `apellido_2`, `telefono`, `fecha_nacimiento`)
VALUES ((select grupo.id from grupo where cod_curso=1 and letra="A"), "Irina", "Barrero", "Caamaño", "981112233", DATE("1983-06-15"));

INSERT INTO `escuela`.`beca` (`num_exp_alumno`, `cuantia`, `fecha`)
VALUES ((select num_expediente from alumno where nombre="Irina" and apellido_1="Barrero"), 2000, DATE("2020-09-15"));



#1B
INSERT INTO `escuela`.`alumno` (`id_grupo`, `nombre`, `apellido_1`, `apellido_2`, `telefono`, `fecha_nacimiento`)
VALUES ((select grupo.id from grupo where cod_curso=1 and letra="B"), "Benigno ", "Olmedo", "Garcia", "981456789", DATE("1983-04-10"));

INSERT INTO `escuela`.`alumno` (`id_grupo`, `nombre`, `apellido_1`, `apellido_2`, `telefono`, `fecha_nacimiento`)
VALUES ((select grupo.id from grupo where cod_curso=1 and letra="B"), "Aitziber", "Muriel", "Maza", "", DATE("1983-05-11"));

INSERT INTO `escuela`.`alumno` (`id_grupo`, `nombre`, `apellido_1`, `apellido_2`, `telefono`, `fecha_nacimiento`)
VALUES ((select grupo.id from grupo where cod_curso=1 and letra="B"), "Erica", "Polo", "Gisbert", "", DATE("1983-08-20"));

INSERT INTO `escuela`.`beca` (`num_exp_alumno`, `cuantia`, `fecha`)
VALUES ((select num_expediente from alumno where nombre="Erica" and apellido_1="Polo"), 1000, DATE("2020-09-02"));



#1C
INSERT INTO `escuela`.`alumno` (`id_grupo`, `nombre`, `apellido_1`, `apellido_2`, `telefono`, `fecha_nacimiento`)
VALUES ((select grupo.id from grupo where cod_curso=1 and letra="C"), "Marcos", "Perea", "Bermudez", "981112236", DATE("1982-03-15"));

INSERT INTO `escuela`.`alumno` (`id_grupo`, `nombre`, `apellido_1`, `apellido_2`, `telefono`, `fecha_nacimiento`)
VALUES ((select grupo.id from grupo where cod_curso=1 and letra="C"), "Cesar", "Escribano", "Garcia", "981112237", DATE("1983-02-15"));

INSERT INTO `escuela`.`alumno` (`id_grupo`, `nombre`, `apellido_1`, `apellido_2`, `telefono`, `fecha_nacimiento`)
VALUES ((select grupo.id from grupo where cod_curso=1 and letra="C"), "Candida", "Gilabert", "Garcia", "981112238", DATE("1983-01-15"));


#2A
INSERT INTO `escuela`.`alumno` (`id_grupo`, `nombre`, `apellido_1`, `apellido_2`, `telefono`, `fecha_nacimiento`)
VALUES ((select grupo.id from grupo where cod_curso=2 and letra="A"), "Alma", "Solis", "Garcia", "981112233", DATE("1982-06-15"));

INSERT INTO `escuela`.`alumno` (`id_grupo`, `nombre`, `apellido_1`, `apellido_2`, `telefono`, `fecha_nacimiento`)
VALUES ((select grupo.id from grupo where cod_curso=2 and letra="A"), "Candida", "Piñero", "Cespedes", "981112233", DATE("1982-03-15"));

INSERT INTO `escuela`.`alumno` (`id_grupo`, `nombre`, `apellido_1`, `apellido_2`, `telefono`, `fecha_nacimiento`)
VALUES ((select grupo.id from grupo where cod_curso=2 and letra="A"), "Jordi", "Canales", "Luque", "981112233", DATE("1982-08-23"));

INSERT INTO `escuela`.`alumno` (`id_grupo`, `nombre`, `apellido_1`, `apellido_2`, `telefono`, `fecha_nacimiento`)
VALUES ((select grupo.id from grupo where cod_curso=2 and letra="A"), "Saul", "Montoya", "Sevillano", "981112233", DATE("1982-10-17"));

INSERT INTO `escuela`.`alumno` (`id_grupo`, `nombre`, `apellido_1`, `apellido_2`, `telefono`, `fecha_nacimiento`)
VALUES ((select grupo.id from grupo where cod_curso=2 and letra="A"), "Luisa", "Domingo", "Palma", "981112233", DATE("1982-12-19"));

INSERT INTO `escuela`.`alumno` (`id_grupo`, `nombre`, `apellido_1`, `apellido_2`, `telefono`, `fecha_nacimiento`)
VALUES ((select grupo.id from grupo where cod_curso=2 and letra="A"), "Nayara", "Paniagua", "Peña", "981112233", DATE("1982-02-05"));

INSERT INTO `escuela`.`beca` (`num_exp_alumno`, `cuantia`, `fecha`)
VALUES ((select num_expediente from alumno where nombre="Nayara" and apellido_1="Paniagua"), 2000, DATE("2020-09-15"));


#3A
INSERT INTO `escuela`.`alumno` (`id_grupo`, `nombre`, `apellido_1`, `apellido_2`, `telefono`, `fecha_nacimiento`)
VALUES ((select grupo.id from grupo where cod_curso=3 and letra="A"), "Saul", "Coca", "", "981112233", DATE("1981-02-14"));

INSERT INTO `escuela`.`alumno` (`id_grupo`, `nombre`, `apellido_1`, `apellido_2`, `telefono`, `fecha_nacimiento`)
VALUES ((select grupo.id from grupo where cod_curso=3 and letra="A"), "Abraham", "Paredes", "Rosa", "981132233", DATE("1981-07-02"));

INSERT INTO `escuela`.`alumno` (`id_grupo`, `nombre`, `apellido_1`, `apellido_2`, `telefono`, `fecha_nacimiento`)
VALUES ((select grupo.id from grupo where cod_curso=3 and letra="A"), "Ramona", "Estevez", "Pina", "981114233", DATE("1981-03-25"));

INSERT INTO `escuela`.`alumno` (`id_grupo`, `nombre`, `apellido_1`, `apellido_2`, `telefono`, `fecha_nacimiento`)
VALUES ((select grupo.id from grupo where cod_curso=3 and letra="A"), "Angel", "Rodriguez", "Cespedes", "981512233", DATE("1980-03-15"));

INSERT INTO `escuela`.`alumno` (`id_grupo`, `nombre`, `apellido_1`, `apellido_2`, `telefono`, `fecha_nacimiento`)
VALUES ((select grupo.id from grupo where cod_curso=3 and letra="A"), "Moises", "Granado", "Alcantara", "981112233", DATE("1981-09-05"));

INSERT INTO `escuela`.`beca` (`num_exp_alumno`, `cuantia`, `fecha`)
VALUES ((select num_expediente from alumno where nombre="Moises" and apellido_1="Granado"), 1200, DATE("2020-09-06"));

INSERT INTO `escuela`.`alumno` (`id_grupo`, `nombre`, `apellido_1`, `apellido_2`, `telefono`, `fecha_nacimiento`)
VALUES ((select grupo.id from grupo where cod_curso=3 and letra="A"), "Delfina", "Toledo", "Maza", "9811122433", DATE("1981-02-05"));

INSERT INTO `escuela`.`beca` (`num_exp_alumno`, `cuantia`, `fecha`)
VALUES ((select num_expediente from alumno where nombre="Delfina" and apellido_1="Toledo"), 1000, DATE("2020-09-05"));


#### EMPRESA
INSERT INTO `escuela`.`empresa` (`nombre`)
VALUES ("ACME");

INSERT INTO `escuela`.`empresa` (`nombre`)
VALUES ("EVIL CORP");

#### PROFESOR
INSERT INTO `escuela`.`profesor` (`dni`, `cod_empresa`, `nombre`, `telefono`, `direccion`)
VALUES ("12345678A", (select cod_empresa from empresa where nombre="ACME"), "Juan Manuel Garcia", "981123456","San Andres 11, A Coruna");

INSERT INTO `escuela`.`profesor` (`dni`, `cod_empresa`, `nombre`, `telefono`, `direccion`)
VALUES ("12345678B", (select cod_empresa from empresa where nombre="ACME"), "Daniel Gonzalez", "981777333","San Andres 12, A Coruna");

INSERT INTO `escuela`.`profesor` (`dni`, `cod_empresa`, `nombre`, `telefono`, `direccion`)
VALUES ("12345678C", (select cod_empresa from empresa where nombre="EVIL CORP"), "Maria Vazquez", "981568568","San Andres 13, A Coruna");

INSERT INTO `escuela`.`profesor` (`dni`, `cod_empresa`, `nombre`, `telefono`, `direccion`)
VALUES ("12345678D", (select cod_empresa from empresa where nombre="EVIL CORP"), "Manuela Gutierrez", "981124124","San Andres 14, A Coruna");

#INSERT INTO `escuela`.`profesor` (`dni`, `cod_empresa`, `nombre`, `telefono`, `direccion`)
#VALUES ("12345678E", (select cod_empresa from empresa where nombre="EVIL CORP"), "John Doe", "981124125","San Andres 14, A Coruna");

##PROFE SIN modulo
INSERT INTO `escuela`.`profesor` (`dni`, `cod_empresa`, `nombre`, `telefono`, `direccion`)
VALUES ("12345678F", (select cod_empresa from empresa where nombre="EVIL CORP"), "John Doe", "981124125","San Andres 16, A Coruna");

#### MODULO

#PROFE 1
INSERT INTO `escuela`.`modulo` (`cod_modulo`, `dni_profesor`, `nombre`)
VALUES ("001", "12345678A" , "Matematicas");
INSERT INTO `escuela`.`modulo` (`cod_modulo`, `dni_profesor`, `nombre`)
VALUES ("002", "12345678A" , "Fisica");
INSERT INTO `escuela`.`modulo` (`cod_modulo`, `dni_profesor`, `nombre`)
VALUES ("003", "12345678A" , "Quimica");

INSERT INTO `escuela`.`modulo` (`cod_modulo`, `dni_profesor`, `nombre`)
VALUES ("001", "12345678B" , "Matematicas");

INSERT INTO `escuela`.`modulo` (`cod_modulo`, `dni_profesor`, `nombre`)
VALUES ("004", "12345678C" , "Lengua");
INSERT INTO `escuela`.`modulo` (`cod_modulo`, `dni_profesor`, `nombre`)
VALUES ("005", "12345678C" , "Ingles");
INSERT INTO `escuela`.`modulo` (`cod_modulo`, `dni_profesor`, `nombre`)
VALUES ("006", "12345678C" , "Historia");

INSERT INTO `escuela`.`modulo` (`cod_modulo`, `dni_profesor`, `nombre`)
VALUES ("005", "12345678D" , "Ingles");
INSERT INTO `escuela`.`modulo` (`cod_modulo`, `dni_profesor`, `nombre`)
VALUES ("006", "12345678D" , "Frances");

#PROFE 1
INSERT INTO `escuela`.`tema` ( `cod_modulo`, `titulo`)
VALUES ( (select cod_modulo from modulo where modulo.cod_modulo="001" and modulo.dni_profesor="12345678A"), "Integrales");
INSERT INTO `escuela`.`tema` ( `cod_modulo`, `titulo`)
VALUES ( (select cod_modulo from modulo where modulo.cod_modulo="001" and modulo.dni_profesor="12345678A"), "Derivadas");

INSERT INTO `escuela`.`tema` ( `cod_modulo`, `titulo`)
VALUES ( (select cod_modulo from modulo where modulo.cod_modulo="002" and modulo.dni_profesor="12345678A"), "Fuerzas");
INSERT INTO `escuela`.`tema` ( `cod_modulo`, `titulo`)
VALUES ( (select cod_modulo from modulo where modulo.cod_modulo="002" and modulo.dni_profesor="12345678A"), "Electromagnetismo");

INSERT INTO `escuela`.`tema` ( `cod_modulo`, `titulo`)
VALUES ( (select cod_modulo from modulo where modulo.cod_modulo="003" and modulo.dni_profesor="12345678A"), "Composicion");
INSERT INTO `escuela`.`tema` ( `cod_modulo`, `titulo`)
VALUES ( (select cod_modulo from modulo where modulo.cod_modulo="003" and modulo.dni_profesor="12345678A"), "Formulas");

#PROFE 2
INSERT INTO `escuela`.`tema` ( `cod_modulo`, `titulo`)
VALUES ( (select cod_modulo from modulo where modulo.cod_modulo="001" and modulo.dni_profesor="12345678B"), "Geometria");
INSERT INTO `escuela`.`tema` ( `cod_modulo`, `titulo`)
VALUES ( (select cod_modulo from modulo where modulo.cod_modulo="001" and modulo.dni_profesor="12345678B"), "Trigonometria");

#PROFE 3
INSERT INTO `escuela`.`tema` ( `cod_modulo`, `titulo`)
VALUES ( (select cod_modulo from modulo where modulo.cod_modulo="004" and modulo.dni_profesor="12345678C"), "Verbos");
INSERT INTO `escuela`.`tema` ( `cod_modulo`, `titulo`)
VALUES ( (select cod_modulo from modulo where modulo.cod_modulo="004" and modulo.dni_profesor="12345678C"), "Analisis sintactico");
INSERT INTO `escuela`.`tema` ( `cod_modulo`, `titulo`)
VALUES ( (select cod_modulo from modulo where modulo.cod_modulo="004" and modulo.dni_profesor="12345678C"), "Lexico");
INSERT INTO `escuela`.`tema` ( `cod_modulo`, `titulo`)
VALUES ( (select cod_modulo from modulo where modulo.cod_modulo="004" and modulo.dni_profesor="12345678C"), "Conjunciones");

INSERT INTO `escuela`.`tema` ( `cod_modulo`, `titulo`)
VALUES ( (select cod_modulo from modulo where modulo.cod_modulo="005" and modulo.dni_profesor="12345678C"), "Verbs");
INSERT INTO `escuela`.`tema` ( `cod_modulo`, `titulo`)
VALUES ( (select cod_modulo from modulo where modulo.cod_modulo="005" and modulo.dni_profesor="12345678C"), "Phrasal Verbs");

INSERT INTO `escuela`.`tema` ( `cod_modulo`, `titulo`)
VALUES ( (select cod_modulo from modulo where modulo.cod_modulo="006" and modulo.dni_profesor="12345678C"), "Mundo antiguo");
INSERT INTO `escuela`.`tema` ( `cod_modulo`, `titulo`)
VALUES ( (select cod_modulo from modulo where modulo.cod_modulo="006" and modulo.dni_profesor="12345678C"), "Mundo Moderno");
INSERT INTO `escuela`.`tema` ( `cod_modulo`, `titulo`)
VALUES ( (select cod_modulo from modulo where modulo.cod_modulo="006" and modulo.dni_profesor="12345678C"), "WWII");

#PROFE 4
INSERT INTO `escuela`.`tema` ( `cod_modulo`, `titulo`)
VALUES ( (select cod_modulo from modulo where modulo.cod_modulo="005" and modulo.dni_profesor="12345678D"), "Adverbs");
INSERT INTO `escuela`.`tema` ( `cod_modulo`, `titulo`)
VALUES ( (select cod_modulo from modulo where modulo.cod_modulo="005" and modulo.dni_profesor="12345678D"), "Idioms");

INSERT INTO `escuela`.`tema` ( `cod_modulo`, `titulo`)
VALUES ( (select cod_modulo from modulo where modulo.cod_modulo="006" and modulo.dni_profesor="12345678D"), "Vocabulario");
INSERT INTO `escuela`.`tema` ( `cod_modulo`, `titulo`)
VALUES ( (select cod_modulo from modulo where modulo.cod_modulo="006" and modulo.dni_profesor="12345678D"), "Gramatica");

## MODULO_ALUMNO

##1A MATES
INSERT INTO `escuela`.`modulo_alumno` (`cod_modulo`, `num_expediente`, `nota`) 
VALUES ((select cod_modulo from modulo where modulo.cod_modulo="001" and modulo.dni_profesor="12345678A"),
 (select num_expediente from alumno where nombre="Mariano" and apellido_1="Toledo"), 5);

INSERT INTO `escuela`.`modulo_alumno` (`cod_modulo`, `num_expediente`, `nota`) 
VALUES ((select cod_modulo from modulo where modulo.cod_modulo="001" and modulo.dni_profesor="12345678A"),
 (select num_expediente from alumno where nombre="Jacobo" and apellido_1="Freire"), 6);
  
 INSERT INTO `escuela`.`modulo_alumno` (`cod_modulo`, `num_expediente`, `nota`) 
VALUES ((select cod_modulo from modulo where modulo.cod_modulo="001" and modulo.dni_profesor="12345678A"),
 (select num_expediente from alumno where nombre="Rogelio" and apellido_1="Muñiz"), 8);
 
 INSERT INTO `escuela`.`modulo_alumno` (`cod_modulo`, `num_expediente`, `nota`) 
VALUES ((select cod_modulo from modulo where modulo.cod_modulo="001" and modulo.dni_profesor="12345678A"),
 (select num_expediente from alumno where nombre="Beatriz" and apellido_1="Palomo"), 4);
 
 INSERT INTO `escuela`.`modulo_alumno` (`cod_modulo`, `num_expediente`, `nota`) 
VALUES ((select cod_modulo from modulo where modulo.cod_modulo="001" and modulo.dni_profesor="12345678A"),
 (select num_expediente from alumno where nombre="Irina" and apellido_1="Barrero"), 3);
 
##1A INGLES
INSERT INTO `escuela`.`modulo_alumno` (`cod_modulo`, `num_expediente`, `nota`) 
VALUES ((select cod_modulo from modulo where modulo.cod_modulo="006" and modulo.dni_profesor="12345678C"),
 (select num_expediente from alumno where nombre="Mariano" and apellido_1="Toledo"), 9);

INSERT INTO `escuela`.`modulo_alumno` (`cod_modulo`, `num_expediente`, `nota`) 
VALUES ((select cod_modulo from modulo where modulo.cod_modulo="006" and modulo.dni_profesor="12345678C"),
 (select num_expediente from alumno where nombre="Jacobo" and apellido_1="Freire"), 8);
  
 INSERT INTO `escuela`.`modulo_alumno` (`cod_modulo`, `num_expediente`, `nota`) 
VALUES ((select cod_modulo from modulo where modulo.cod_modulo="006" and modulo.dni_profesor="12345678C"),
 (select num_expediente from alumno where nombre="Rogelio" and apellido_1="Muñiz"), 10);
 
 INSERT INTO `escuela`.`modulo_alumno` (`cod_modulo`, `num_expediente`, `nota`) 
VALUES ((select cod_modulo from modulo where modulo.cod_modulo="006" and modulo.dni_profesor="12345678C"),
 (select num_expediente from alumno where nombre="Beatriz" and apellido_1="Palomo"), 5);
 
 INSERT INTO `escuela`.`modulo_alumno` (`cod_modulo`, `num_expediente`, `nota`) 
VALUES ((select cod_modulo from modulo where modulo.cod_modulo="006" and modulo.dni_profesor="12345678C"),
 (select num_expediente from alumno where nombre="Irina" and apellido_1="Barrero"), 7);
 
##2A 
INSERT INTO `escuela`.`modulo_alumno` (`cod_modulo`, `num_expediente`, `nota`) 
VALUES ((select cod_modulo from modulo where modulo.cod_modulo="001" and modulo.dni_profesor="12345678A"),
 (select num_expediente from alumno where nombre="Alma" and apellido_1="Solis"), 2);

INSERT INTO `escuela`.`modulo_alumno` (`cod_modulo`, `num_expediente`, `nota`) 
VALUES ((select cod_modulo from modulo where modulo.cod_modulo="001" and modulo.dni_profesor="12345678A"),
 (select num_expediente from alumno where nombre="Candida" and apellido_1="Piñero"), 3);
  
 INSERT INTO `escuela`.`modulo_alumno` (`cod_modulo`, `num_expediente`, `nota`) 
VALUES ((select cod_modulo from modulo where modulo.cod_modulo="001" and modulo.dni_profesor="12345678A"),
 (select num_expediente from alumno where nombre="Jordi" and apellido_1="Canales"), 8);
 
 INSERT INTO `escuela`.`modulo_alumno` (`cod_modulo`, `num_expediente`, `nota`) 
VALUES ((select cod_modulo from modulo where modulo.cod_modulo="001" and modulo.dni_profesor="12345678A"),
 (select num_expediente from alumno where nombre="Saul" and apellido_1="Montoya"), 4);
 
 INSERT INTO `escuela`.`modulo_alumno` (`cod_modulo`, `num_expediente`, `nota`) 
VALUES ((select cod_modulo from modulo where modulo.cod_modulo="001" and modulo.dni_profesor="12345678A"),
 (select num_expediente from alumno where nombre="Luisa" and apellido_1="Domingo"), 3);

 INSERT INTO `escuela`.`modulo_alumno` (`cod_modulo`, `num_expediente`, `nota`) 
VALUES ((select cod_modulo from modulo where modulo.cod_modulo="001" and modulo.dni_profesor="12345678A"),
 (select num_expediente from alumno where nombre="Nayara" and apellido_1="Paniagua"), 3);


##3A MATES
INSERT INTO `escuela`.`modulo_alumno` (`cod_modulo`, `num_expediente`, `nota`) 
VALUES ((select cod_modulo from modulo where modulo.cod_modulo="001" and modulo.dni_profesor="12345678A"),
 (select num_expediente from alumno where nombre="Saul" and apellido_1="Coca"), 5);

INSERT INTO `escuela`.`modulo_alumno` (`cod_modulo`, `num_expediente`, `nota`) 
VALUES ((select cod_modulo from modulo where modulo.cod_modulo="001" and modulo.dni_profesor="12345678A"),
 (select num_expediente from alumno where nombre="Abraham" and apellido_1="Paredes"), 5);
  
 INSERT INTO `escuela`.`modulo_alumno` (`cod_modulo`, `num_expediente`, `nota`) 
VALUES ((select cod_modulo from modulo where modulo.cod_modulo="001" and modulo.dni_profesor="12345678A"),
 (select num_expediente from alumno where nombre="Ramona" and apellido_1="Estevez"), 9);
 
 INSERT INTO `escuela`.`modulo_alumno` (`cod_modulo`, `num_expediente`, `nota`) 
VALUES ((select cod_modulo from modulo where modulo.cod_modulo="001" and modulo.dni_profesor="12345678A"),
 (select num_expediente from alumno where nombre="Angel" and apellido_1="Rodriguez"), 10);
 
 INSERT INTO `escuela`.`modulo_alumno` (`cod_modulo`, `num_expediente`, `nota`) 
VALUES ((select cod_modulo from modulo where modulo.cod_modulo="001" and modulo.dni_profesor="12345678A"),
 (select num_expediente from alumno where nombre="Moises" and apellido_1="Granado"), 7);
 
##3A INGLES
INSERT INTO `escuela`.`modulo_alumno` (`cod_modulo`, `num_expediente`, `nota`) 
VALUES ((select cod_modulo from modulo where modulo.cod_modulo="005" and modulo.dni_profesor="12345678C"),
 (select num_expediente from alumno where nombre="Saul" and apellido_1="Coca"), 5);

INSERT INTO `escuela`.`modulo_alumno` (`cod_modulo`, `num_expediente`, `nota`) 
VALUES ((select cod_modulo from modulo where modulo.cod_modulo="005" and modulo.dni_profesor="12345678C"),
 (select num_expediente from alumno where nombre="Abraham" and apellido_1="Paredes"), 5);
  
 INSERT INTO `escuela`.`modulo_alumno` (`cod_modulo`, `num_expediente`, `nota`) 
VALUES ((select cod_modulo from modulo where modulo.cod_modulo="005" and modulo.dni_profesor="12345678C"),
 (select num_expediente from alumno where nombre="Ramona" and apellido_1="Estevez"), 9);
 
 INSERT INTO `escuela`.`modulo_alumno` (`cod_modulo`, `num_expediente`, `nota`) 
VALUES ((select cod_modulo from modulo where modulo.cod_modulo="005" and modulo.dni_profesor="12345678C"),
 (select num_expediente from alumno where nombre="Angel" and apellido_1="Rodriguez"), 10);
 
 INSERT INTO `escuela`.`modulo_alumno` (`cod_modulo`, `num_expediente`, `nota`) 
VALUES ((select cod_modulo from modulo where modulo.cod_modulo="005" and modulo.dni_profesor="12345678C"),
 (select num_expediente from alumno where nombre="Moises" and apellido_1="Granado"), 7);
 
