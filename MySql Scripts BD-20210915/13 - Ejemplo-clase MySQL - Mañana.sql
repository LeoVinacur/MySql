#CREAMOS LA BASE DE DATOS -> HAY DISTINTAS FORMAS
CREATE DATABASE ejemplo;
CREATE SCHEMA ejemplo;
#CREAMOS LA BASE DE DATOS SI ESTA NO EXISTE (tiene en cuenta mayusculas)
CREATE DATABASE IF NOT EXISTS ejemplo;

#SELECCIONAMOS LA BASE DE DATOS EN LA QUE QUIERO ACTUAR
USE ejemplo;
#TAMBIEN SE PUEDE HACER DOBLE CLICK EN LA BASE DE DATOS

#CREACION DE TABLA
CREATE TABLE alumnos (
#es un entero, no lleva signo(solo podria ser positivo),aumentaria el id de uno en uno y no puede ser null
id_alumno INT UNSIGNED AUTO_INCREMENT NOT NULL,
nombre VARCHAR(50) DEFAULT NULL, #(por defecto sera nulo)
apellido VARCHAR(50) DEFAULT NULL, #(por defecto sera nulo)
dni INT NOT NULL,
email VARCHAR(100),
PRIMARY KEY (id_alumno)
);
#INSERTAR VALORES A LA TABLA
INSERT INTO alumnos VALUES(1,'Pablo','Gomez',33322211,'pablogomez@mail.com');
INSERT INTO alumnos VALUES(2,'Maria','Perez',22222222,'mariaperez@mail.com');
INSERT INTO alumnos VALUES(3,'German','Godoy',44332222,'germangodoy@mail.com');
INSERT INTO alumnos VALUES(4,'Nicolas','Martinez',162737362,'nicomartinez@mail.com');

#CONSULTAS E INSTRUCCIONES
SELECT * FROM alumnos; #(aca mostramos todos los datos)
SELECT nombre,apellido from alumnos;
SELECT apellido FROM alumnos;

SELECT MAX(dni) FROM alumnos;
SELECT MAX(dni) AS 'DNI mas alto' FROM alumnos;

SELECT * FROM alumnos
WHERE nombre LIKE 'p%'; #buscamos nombres que empiecen con p

SELECT * FROM alumnos
WHERE nombre LIKE '%a%'; #buscamos nombres que tengan una a

SELECT nombre, char_length(nombre) as 'Longitud del nombre' 
FROM alumnos 
WHERE char_length(nombre) > 5; #seleccionamos los nombres que sean mas largos que 5 caracteres

SELECT * FROM alumnos 
ORDER BY apellido ASC; #pedimos toda la tabla de alumnos pero ordenados por apellido en forma ascendente

DELETE FROM alumnos WHERE nombre LIKE 'pablo';

#ELIMINAMOS LA BASE DE DATOS
DROP database ejemplo;
