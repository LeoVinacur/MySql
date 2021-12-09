DROP DATABASE IF EXISTS superheroes;
CREATE DATABASE superheroes CHARACTER SET utf8mb4;
USE superheroes;

-- Abrir el script llamado “superhéroes” y ejecutarlo de modo tal que se cree la base de
-- datos y todas sus tablas. Posteriormente, crear las tablas que se muestran en el
-- siguiente modelo de entidad relación: 

CREATE TABLE creador (
id_creador INT UNSIGNED AUTO_INCREMENT PRIMARY KEY, 
  nombre VARCHAR(20) NOT NULL
);


CREATE TABLE personajes (
  id_personaje INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  nombre_real VARCHAR(20) NOT NULL,
  personaje VARCHAR(20) NOT NULL,
  inteligencia INT(10) NOT NULL,
  fuerza VARCHAR(10) NOT NULL,
  velocidad INT(11) NOT NULL,
  poder INT(11) NOT NULL,
  aparicion INT(11) NOT NULL,
  ocupacion VARCHAR(30) NULL,
  id_creador INT UNSIGNED NOT NULL,
  FOREIGN KEY (id_creador) REFERENCES creador(id_creador)
  );

-- Insertar en las tablas creadas los siguientes datos:

 INSERT INTO creador VALUES(1, 'Marvel') , (2, 'DC Comics');
-- INSERT INTO creador VALUES(2, 'DC Comics'); 
 

INSERT INTO personajes VALUES(1, 'Bruce Banner' , 'Hulk' , 160  , '600 mil' , 75 , 98 , 1962 , 'Fisico Nuclear' , 1  ); 
INSERT INTO personajes VALUES(2, 'Tony Stark' , 'Iron Man' , 170  , '200 mil' , 70, 123 , 1963 , 'Inventor Industrial' , 1 );
INSERT INTO personajes VALUES(3, 'Thor Odinson' , 'Thor' , 145  , 'infinita' , 100, 235 , 1962 , 'Rey Asgard' , 1 );
INSERT INTO personajes VALUES(4, 'Wanda Maximof' , 'Bruja Escarlata' , 170  , '100 mil' , 90, 345 , 1964 , 'Bruja' , 1 );
INSERT INTO personajes VALUES(5, 'Carol Danvers' , 'Capitana Marvel' , 157  , '250 mil' , 85, 128 , 1968, 'Oficial de Inteligencia' , 1 ); 
INSERT INTO personajes VALUES(6, 'Thanos' , 'Thanos' , 170  , 'infinita' , 40, 306 , 1973 , 'Adorador de la muerte' , 1 );
INSERT INTO personajes VALUES(7, 'Peter Parker' , 'Spiderman' , 165  , '25 mil' , 80 , 74 , 1962  , 'Fotografo' , 1 );
INSERT INTO personajes VALUES(8, 'Steve Rogers' , 'Capitan América' , 145  , '600 mil' , 45 , 60  , 1941  , 'Oficial Federal' , 1 );
INSERT INTO personajes VALUES(9, 'Bobby Drake' , 'Ice Man' , 140  , '2 mil' , 64 , 122 , 1963 , 'Contador' , 1 );
INSERT INTO personajes VALUES(10, 'Barry Allen' , 'Flash' , 160  , '10 mil' , 120 , 168 , 1956 , 'Científico Forense' , 2 );
INSERT INTO personajes VALUES(11, 'Bruce Wayne' , 'Batman' , 170  , '500 mil' , 32 , 47 , 1939 , 'Hombre de Negocios' , 2 );
INSERT INTO personajes VALUES
 (12, 'Clarck Kent' , 'Superman' , 165  , 'infinita' , 120, 182 , 1948 , 'Reportero' , 2 ) ,
 (13, 'Diana Prince' , 'Mujer Maravilla' , 160  , 'infinita' , 95, 127 , 1949 , 'Princesa Guerrera' , 2 );
 -- Los dos últimos los hice juntos

SELECT * FROM  superheroes.personajes ;
SELECT * FROM superheroes.creador;
-- WHERE p.id_creador = c.id_personajes;

-- b) Cambiar en la tabla personajes el año de aparición a 1938 del personaje Superman.
-- A continuación, realizar un listado de toda la tabla para verificar que el personaje
-- haya sido actualizado.

UPDATE `superheroes`.`personajes` SET `aparicion`='1938' WHERE `id_personaje`='12';

-- c) Eiminar el registro que contiene al personaje Flash. A continuación, mostrar toda la tabla
-- para verificar que el registro haya sido eliminado

DELETE FROM `superheroes`.`personajes` WHERE `id_personaje`='10';

-- d) Eliminar la base de datos superhéroes.
drop schema `superheroes`;  -- no lo voy a hacer
