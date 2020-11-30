create database peliculas character set="utf8mb4" collate="utf8mb4_unicode_ci";
use peliculas;

show tables;
show databases;

create table if not exists pelicula(
	id int unsigned auto_increment primary key,
    titulo varchar(300) not null,
    calificacion enum('TP', 'M-13', 'M-18'),
    n_actores smallint unsigned default 0
);

show create table pelicula;
describe pelicula;

create table if not exists genero(
	id int unsigned auto_increment primary key,
    nombre varchar(50) not null
);

alter table genero add constraint genero_nombre_uq1 unique(nombre);

create table if not exists oscar(
	id int unsigned auto_increment primary key,
    titulo varchar(50) not null,
    gran_categoria tinyint default 0,
    constraint oscar_tilulo_uq1 unique(titulo),
    constraint oscar_gran_categoria_ck1 
		CHECK(gran_categoria=0 or gran_categoria=1)
);

create table if not exists datos_produccion(
	id int unsigned auto_increment primary key,
    productora varchar(100) not null,
    costes int unsigned default 0,
    fecha_fin_produccion date
);


create table if not exists pelicula_genero(
	id_pelicula int unsigned primary key,
    id_genero int unsigned not null,
    constraint pelicula_genero_id_pelicula_fk1 
		foreign key (id_pelicula) references pelicula(id),
    constraint pelicula_genero_id_genero_fk2 foreign key (id_genero)
		references genero(id)
);


create table if not exists pelicula_oscar(
	id_pelicula int unsigned,
	id_oscar int unsigned,
    anho year not null,
    n_votos int unsigned default 0,
    primary key (id_pelicula, id_oscar),
    constraint pelicula_oscar_id_pelicula_fk1 
		foreign key (id_pelicula) references pelicula(id),
    constraint pelicula_oscar_id_oscar_fk2 
		foreign key (id_oscar) references oscar(id),
	constraint pelicula_oscar_id_oscar_anho_uq1 unique(id_oscar, anho)
);

create table if not exists pelicula_datos_produccion(
	id_pelicula int unsigned primary key,
    id_datos_produccion int unsigned not null,
    constraint pelicula_datos_produccion_id_pelicula_fk1 
		foreign key (id_pelicula) references pelicula(id),
    constraint pelicula_datos_produccion_id_datos_produccion_fk2 
		foreign key (id_datos_produccion) 
        references datos_produccion(id)
);

select * from pelicula;

insert into pelicula values(
	null, 'Apolo 13', 'M-13', 50
);
