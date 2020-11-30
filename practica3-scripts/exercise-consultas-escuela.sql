-- ¿Te pica la curiosidad??
--
-- NOTA 1:
-- =======
-- Si quieres ver el plan de ejecución / optimización que usa el motor de SGDB para las consultas
-- pon delante de ellas...
--      EXPLAIN ANALYZE
-- Ejemplo:
--      EXPLAIN ANALYZE SELECT * FROM escuela.beca;
--
-- Se supone que a menor suma de costes de ejecución, más eficiente es la consulta.
-- Si no se puede optimizar más por sintaxis...
-- quizás sea la hora de hacer un CREATE INDEX sobre alguna columna.
--
-- NOTA 2:
-- =======
-- Sin tener el modelo relacional o físico delante (mejor en papel) es dificil
-- decantarse por una u otra consulta en aquellas que planteo varias soluciones,
-- sobre todo cuando hay JOINS de por medio y no tienes delante las relaciones
-- para combinarlo con un INNER o un OUTER.
--
--
-- Y si realmente me conoces, o quieres esforzarte por hacerlo,
-- ve mirando las consultas detenidamente y resolviendo los enigmas.
-- AL FINAL HAY PREMIO GORDO DE NAVIDAD!!!!! <8:}
--
-- Play this SQL kata & Enjoy. Your college, David Ordás
--


-- No es necesario un USE si ponemos el nombre del schema delante de la tabla.
-- USE escuela;


/*
001). Mostrar la tabla becas
*/
DESCRIBE escuela.beca;

SHOW CREATE TABLE escuela.beca;


/*
002). Mostrar los datos de la tabla becas
*/
SELECT * FROM escuela.beca;


/*
003). ¿Cuántas becas se han otorgado?
*/
SELECT count(*) AS count_rows
-- también se puede hacer un count sobre una columna en particular. Ej: count(id)
-- si estamos en una consulta con GROUP BY actua como función de grupo
FROM escuela.beca;



/*
004). ¿Cuántas becas se han otorgado antes del año 2000?
*/
SELECT count(*) AS count_rows
FROM escuela.beca
WHERE
    -- extraemos el campo año de la fecha y filtramos
    year(fecha) < 2000;


/*
005). Media cuantía becas.
*/
SELECT avg(cuantia) AS media_cuantia
FROM escuela.beca;

-- redondeando a dos decimales....
SELECT round(avg(cuantia), 2) AS media_cuantia
FROM escuela.beca;


/*
006). Media cuantía becas (sólo contabilizar aquellas con un valor mayor a 1000).
*/
SELECT avg(cuantia) AS media_cuantia
FROM escuela.beca
WHERE cuantia > 1000;

-- redondeando a dos decimales....
SELECT round(avg(cuantia), 2) AS media_cuantia
FROM escuela.beca
WHERE cuantia > 1000;


/*
007). Obtener cuantas becas se han otorgado para cada cuantía.
*/
SELECT cuantia,
    -- Aplicamos función de grupo sobre el campo solicitado
    count(cuantia) AS count_cuantia
FROM escuela.beca
-- agrupamos
GROUP BY cuantia;


/*
008). Obtener cuantas becas se han otorgado para cada cuantía siempre que se haya entregado más que 1.
*/
SELECT cuantia,
    -- Aplicamos función de grupo sobre el campo solicitado
    count(cuantia) AS count_cuantia
FROM escuela.beca
-- agrupamos
GROUP BY cuantia
-- filtramos dicha agrupación
HAVING count_cuantia > 1;


/*
009). Obtener cuantas becas (mayores de 1000 euros) se han otorgado para cada cuantía siempre que se haya entregado más que 1.
*/
SELECT cuantia,
    -- Aplicamos función de grupo sobre el campo solicitado
    count(cuantia) AS count_cuantia
FROM escuela.beca
-- filtramos
WHERE cuantia > 1000
-- agrupamos
GROUP BY cuantia
-- filtramos dicha agrupación
HAVING count_cuantia > 1;


/*
010). ¿Cuántas becas han sido concedidas por fecha?
*/
SELECT fecha,
    -- Aplicamos función de grupo sobre el campo solicitado
    count(cuantia) AS count_cuantia
FROM escuela.beca
-- agrupamos
GROUP BY fecha;


/*
011). ¿Cuál es la cuantía economica de becas por fecha?
*/
SELECT fecha,
    -- Aplicamos función de grupo sobre el campo solicitado
    sum(cuantia) AS total_cuantia
FROM escuela.beca
-- agrupamos
GROUP BY fecha;


/*
012). ¿Cuál es la cuantía economica de becas y su incidendicia por fecha?
*/
SELECT fecha,
    -- Aplicamos funciones de grupo sobre el campo solicitado
    sum(cuantia) AS total_cuantia,
    count(cuantia) AS incidencia_cuantia
FROM escuela.beca
-- agrupamos
GROUP BY fecha;


/*
013). Mostrar todos los módulos alumno.
*/
SELECT * FROM escuela.modulo_alumno;


/*
014). Mostrar las notas de los módulos alumno.
*/
-- usamos DISTINCT para evitar repetidos
SELECT DISTINCT nota
FROM escuela.modulo_alumno
ORDER BY nota;


/*
015). Media de notas.
*/
SELECT avg(nota) AS media_notas
FROM escuela.modulo_alumno;


SELECT round(avg(nota), 2) AS media_notas
FROM escuela.modulo_alumno;


/*
016). Media de notas por módulo.
*/
SELECT cod_modulo,
    -- Aplicamos función de grupo sobre el campo solicitado
    avg(nota) AS media_notas
FROM escuela.modulo_alumno
-- agrupamos
GROUP BY cod_modulo;


/*
017). ¿Cuál es la nota máxima?
*/
SELECT max(nota) AS max_nota
FROM escuela.modulo_alumno;


-- Aplicamos DISTINCT para filtrar repetidos
SELECT DISTINCT nota AS max_nota
FROM escuela.modulo_alumno
-- con el ">= ALL" filtramos por el máximo
WHERE nota >= ALL (
        SELECT nota FROM escuela.modulo_alumno
    );


SELECT nota AS max_nota
FROM escuela.modulo_alumno
-- con el ">= ALL" filtramos por el máximo
WHERE nota >= ALL (
        SELECT nota FROM escuela.modulo_alumno
    )
-- Para coge el primero. ¿para que sacar varios valores que son todos notas máximas?
LIMIT 1;


/*
018). ¿Cuál es la nota mínima y de qué expediente alumno?
*/
SELECT num_expediente, nota
FROM escuela.modulo_alumno
WHERE nota IN (
        -- Nota minima
        SELECT min(nota) FROM escuela.modulo_alumno
    );


SELECT num_expediente, nota
FROM escuela.modulo_alumno
ORDER BY nota
LIMIT 1;


SELECT num_expediente, nota
FROM escuela.modulo_alumno
WHERE nota <= ALL (
        SELECT nota FROM escuela.modulo_alumno
    );


/*
019). Información de todos los profesores.
*/
SELECT * FROM escuela.profesor;


/*
020). ¿Cuántos módulos da cada profesor?
*/
SELECT dni_profesor, count(*) AS count_modulos
FROM escuela.modulo
GROUP BY dni_profesor;


SELECT p.*, ifnull(c.count_modulos, 0) AS count_modulos
FROM escuela.profesor p
    LEFT JOIN (
        SELECT dni_profesor, count(*) AS count_modulos
        FROM escuela.modulo
        GROUP BY dni_profesor
	) c ON (p.dni = c.dni_profesor);


/*
021). El nombre de los profesores que dan matemáticas.
*/
SELECT p.nombre
FROM escuela.profesor p
WHERE p.dni IN (
        SELECT m.dni_profesor
        FROM escuela.modulo m
        WHERE m.nombre = 'matemáticas'
    );


SELECT DISTINCT p.nombre
FROM escuela.profesor p
    INNER JOIN escuela.modulo m ON (p.dni = m.dni_profesor)
WHERE m.nombre = 'matemáticas';


SELECT p.nombre
FROM escuela.profesor p
WHERE EXISTS (
        SELECT 1
--        SELECT m.id
        FROM escuela.modulo m
        WHERE p.dni = m.dni_profesor
            AND m.nombre = 'matemáticas'
    );


/*
022). ¿Cuántos grupos hay?
*/
SELECT count(*) AS count_rows FROM escuela.grupo;


/*
023). ¿Cuántas aulas hay?
*/
SELECT count(*) AS count_rows FROM escuela.aula;


/*
024). ¿Qué grupo no tiene aula?
*/
SELECT g.*
FROM escuela.grupo g
WHERE g.id NOT IN (
        SELECT id_grupo FROM escuela.aula
    );


SELECT g.*
FROM escuela.grupo g
    -- cruzamos datos
    LEFT JOIN escuela.aula a ON (g.id = a.id_grupo)
-- nos quedamos con los de sin aula
-- (al hacer LEFT JOIN, si no tiene aula, cualquier columna de "a" es NULL)
WHERE a.id_grupo IS NULL;


/*
025). Muestra el listado de todos los grupos y el número de plazas.
*/
SELECT g.*,
    ifnull(a.num_plazas, 0) AS num_plazas
FROM escuela.grupo g
    LEFT JOIN escuela.aula a ON (a.id_grupo = g.id);


/*
026). Mostrar las notas, y el nombre del módulo de los módulos alumno.
*/
SELECT m.nombre AS nombre_modulo,
    ma.nota
FROM escuela.modulo_alumno ma
    RIGHT JOIN escuela.modulo m ON (m.id = ma.cod_modulo);



-- Keep Learning...
-- Si llegaste hasta aquí y comprendiste.... te mereces una smilie y un KIT-KAT ;-)
-- Agarrate que vienen curvas
-- Enigma: ¿De que color es el caballo blanco de Santiago?



/*
027). Mostrar los nombres completos de los alumnos, sus notas y los nombres del módulo de los módulos alumno.
*/
SELECT concat(trim(a.nombre), ' ', trim(a.apellido_1), ' ', trim(a.apellido_2)) AS alumno_fullname,
    m.nombre AS modulo_nombre,
    nota
FROM escuela.alumno a
    LEFT JOIN escuela.modulo_alumno ma ON (ma.num_expediente = a.num_expediente)
    LEFT JOIN escuela.modulo m ON (m.id = ma.cod_modulo)
ORDER BY a.apellido_1, apellido_2, a.nombre;


/*
028). Media de las notas en matemáticas.
*/
SELECT m.nombre AS modulo_nombre, avg(ma.nota) AS nota_media
FROM escuela.modulo_alumno ma
    LEFT JOIN escuela.modulo m ON (m.id = ma.cod_modulo)
WHERE m.nombre = 'matemáticas'
GROUP BY modulo_nombre;


/*
029). Alumnos sin nota en matemáticas
*/
SELECT a.num_expediente, a.nombre, a.apellido_1, apellido_2,
        concat(trim(a.nombre), ' ', trim(a.apellido_1), ' ', trim(a.apellido_2)) AS alumno_fullname,
        a.telefono, a.fecha_nacimiento
FROM escuela.alumno a
WHERE a.num_expediente NOT IN (
        -- buscamos los que tienen nota en dicho módulo
        SELECT ma.num_expediente
        FROM escuela.modulo_alumno ma
            INNER JOIN escuela.modulo m ON (m.cod_modulo = ma.cod_modulo)
        WHERE m.nombre = 'matemáticas'
    )
ORDER BY apellido_1, apellido_2, nombre;


SELECT a.num_expediente, a.nombre, a.apellido_1, apellido_2,
        concat(trim(a.nombre), ' ', trim(a.apellido_1), ' ', trim(a.apellido_2)) AS alumno_fullname,
        a.telefono, a.fecha_nacimiento
FROM escuela.alumno a
WHERE NOT EXISTS (
        -- usamos cualquier columna del FROM subconsulta
        -- (mejor entre menos bytes ocupe su tipo de dato, nunca *)
        SELECT 1
--        SELECT ma.cod_modulo
        FROM escuela.modulo_alumno ma
            INNER JOIN escuela.modulo m ON (m.cod_modulo = ma.cod_modulo)
        WHERE
            -- NOTA: para optimizar aquí habrá que ver cual es la tabla predominante en datos
            --       y poner ese AND el primero para que filtre más...
            1 = 1
            -- es más restrictivo este campo (el proyectado por el EXISTS) por eso va primero ;)
            AND ma.num_expediente = a.num_expediente
            AND m.nombre = 'matemáticas'
    )
ORDER BY a.apellido_1, a.apellido_2, a.nombre;



-- Carry on focused...
-- Ufff estas fueron largas ¿no?
-- Si tienes dudas... tómate otro KIT-KAT y pregúntame.
-- Estaré en la mesa 5 de la cafetería ;-) hasta las 5am ¿perreando?
-- Pero atento... aún se puede rizar el rizo...
-- Enigma: ¿Cuánto es (5*5 + naranja) si una naranja es medio limón y el limón es doblemente amargo que la naranja?



/*
030). Alumnos con beca y aprobados.
*/
-- De nuevo usamos DISTINCT por la PK "num_expediente" para deshacernos de duplicados que suceden al aplicar el INNER JOIN
SELECT DISTINCT a.num_expediente, a.nombre, a.apellido_1, apellido_2,
        concat(trim(a.nombre), ' ', trim(a.apellido_1), ' ', trim(a.apellido_2)) AS alumno_fullname,
        a.telefono, a.fecha_nacimiento
FROM escuela.alumno a
    INNER JOIN escuela.modulo_alumno ma ON (a.num_expediente = ma.num_expediente)
WHERE
    -- NOTA: para optimizar aquí habrá que ver cual es la tabla predominante en datos
    --       y poner ese AND el primero para que filtre más...
    1 = 1
    -- filtramos por aprobados
    AND ma.nota >= 5
    -- filtramos por los de con beca
    AND a.num_expediente IN (SELECT num_exp_alumno FROM escuela.beca);


SELECT DISTINCT a.num_expediente, a.nombre, a.apellido_1, apellido_2,
        concat(trim(a.nombre), ' ', trim(a.apellido_1), ' ', trim(a.apellido_2)) AS alumno_fullname,
        a.telefono, a.fecha_nacimiento
FROM escuela.alumno a
    INNER JOIN escuela.modulo_alumno ma ON (a.num_expediente = ma.num_expediente)
WHERE
    -- NOTA: para optimizar aquí habrá que ver cual es la tabla predominante en datos
    --       y poner ese AND el primero para que filtre más...
    1 = 1
    -- filtramos por aprobados
    AND ma.nota >= 5
    -- filtramos por los de con beca
    AND EXISTS (
        -- usamos cualquier columna del FROM subconsulta
        -- (mejor entre menos bytes ocupe su tipo de dato, nunca *)
        SELECT 1
--        SELECT b.id
        FROM escuela.beca b
        WHERE a.num_expediente = b.num_exp_alumno
        LIMIT 1
    )
ORDER BY a.apellido_1, a.apellido_2, a.nombre;


SELECT a.num_expediente, a.nombre, a.apellido_1, apellido_2,
        concat(trim(a.nombre), ' ', trim(a.apellido_1), ' ', trim(a.apellido_2)) AS alumno_fullname,
        a.telefono, a.fecha_nacimiento
FROM escuela.alumno a
WHERE
    -- NOTA: para optimizar aquí habrá que ver cual es la tabla predominante en datos
    --       y poner ese AND el primero para que filtre más....
    --       Supongamos que se dán menos casos de becas que de aprobados. ;)
    1 = 1
    -- filtramos por los de con beca
    AND EXISTS (
        -- usamos cualquier columna del FROM subconsulta
        -- (mejor entre menos bytes ocupe su tipo de dato, nunca *)
--        SELECT 1
        SELECT b.id
        FROM escuela.beca b
        WHERE a.num_expediente = b.num_exp_alumno
    )
    -- filtramos por los de algún aprobado
    AND EXISTS (
        -- usamos cualquier columna del FROM subconsulta
        -- (mejor entre menos bytes ocupe su tipo de dato, nunca *)
        SELECT 1
--        SELECT ma.cod_modulo
        FROM escuela.modulo_alumno ma
        WHERE a.num_expediente = ma.num_expediente AND ma.nota >= 5
    )
ORDER BY a.apellido_1, a.apellido_2, a.nombre;


/*
031). ¿Cuántos alumnos aprobaron por materia?
*/
SELECT m.nombre AS modulo, count(ma.nota) AS count_aprobados
FROM escuela.modulo_alumno ma
    LEFT JOIN escuela.modulo m ON (m.id = ma.cod_modulo)
-- filtramos por aprobados
WHERE ma.nota >= 5
-- agrupamos
GROUP BY modulo
-- ordenamos por mayores aprobados y nombre del módulo
ORDER BY count_aprobados DESC, modulo;


SELECT m.nombre AS modulo, count(ma.nota) AS count_aprobados
FROM escuela.modulo_alumno ma
    INNER JOIN escuela.modulo m ON (m.id = ma.cod_modulo)
-- filtramos por aprobados
WHERE ma.nota >= 5
-- agrupamos
GROUP BY modulo
-- ordenamos por mayores aprobados y nombre del módulo
ORDER BY count_aprobados DESC, modulo;


/*
032). ¿En qué aulas no hay suficientes ordenadores?
*/
SELECT g.cod_curso AS curso, g.letra AS letra,
    a.cod_aula AS aula, a.num_plazas AS plazas, a.num_ordenadores AS ordenadores,
    count(s.num_expediente) AS count_alumnos
FROM escuela.aula a
    -- para los datos del grupo
    LEFT JOIN escuela.grupo g ON (a.id_grupo = g.id)
    -- para obtener el count de alumnos
    LEFT JOIN escuela.alumno s ON (s.id_grupo = g.id)
-- agrupamos por los datos base a mostrar
GROUP BY curso, letra, aula, plazas, ordenadores
-- ifnull para evitar pete por el LEFT JOIN alumnos
HAVING ifnull(ordenadores, 0) < ifnull(count_alumnos, 0);


SELECT g.cod_curso AS curso, g.letra AS letra,
    a.cod_aula AS aula, a.num_plazas AS plazas, a.num_ordenadores AS ordenadores,
    count(s.num_expediente) AS count_alumnos
FROM escuela.aula a
    -- para los datos del grupo
    INNER JOIN escuela.grupo g ON (a.id_grupo = g.id)
    -- para obtener el count de alumnos
    LEFT JOIN escuela.alumno s ON (s.id_grupo = g.id)
-- agrupamos por los datos base a mostrar
GROUP BY curso, letra, aula, plazas, ordenadores
-- ifnull para evitar pete por el LEFT JOIN alumnos
HAVING ifnull(ordenadores, 0) < ifnull(count_alumnos, 0);




-- WEEEAAA! FIN de la KATA SQL!!!
-- ERES UN CRACK!!! Y YO... SOY TRUÁN, SOY SEÑOR, AMANTE DEL BUEN GUIÑO Y.... PROGRAMADOR!! xDDD
--
-- Whatsappeame los resultados a los enigmas.
-- SE SORTEA... y un jamón de los de Navidad y una botella de vino p-de-León :D
