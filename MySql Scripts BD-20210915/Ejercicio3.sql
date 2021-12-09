/* 1. Lista el nombre de todos los productos que hay en la tabla producto.
2. Lista los nombres y los precios de todos los productos de la tabla producto.
3. Lista todas las columnas de la tabla producto.
4. Lista los nombres y los precios de todos los productos de la tabla producto,
redondeando el valor del precio.
5. Lista el código de los fabricantes que tienen productos en la tabla producto.*/

SELECT nombre FROM producto;  -- EJ 1
SELECT nombre, precio FROM producto;
SELECT * FROM producto;
SELECT nombre, ROUND(precio) FROM producto;
SELECT * FROM fabricante; -- prueba
SELECT f.codigo , f.nombre FROM fabricante f -- EJ 5 hasta abajo
INNER JOIN producto p
ON f.codigo = p.codigo_fabricante ; 

/* 10. Lista el código de los fabricantes que tienen productos en la tabla producto, sin
mostrar los repetidos.
11. Lista los nombres de los fabricantes ordenados de forma ascendente.
12. Lista los nombres de los productos ordenados en primer lugar por el nombre de
forma ascendente y en segundo lugar por el precio de forma descendente.
13. Devuelve una lista con las 5 primeras filas de la tabla fabricante.
14. Lista el nombre y el precio del producto más barato. (Utilice solamente las cláusulas
ORDER BY y LIMIT)
15. Lista el nombre y el precio del producto más caro. (Utilice solamente las cláusulas
ORDER BY y LIMIT) */

SELECT f.codigo , f.nombre FROM fabricante f -- EJ 10 inicio
INNER JOIN producto p
ON f.codigo = p.codigo_fabricante GROUP BY f.nombre; --  EJ 10 FIN

SELECT nombre FROM fabricante ORDER BY nombre ASC; -- EJ 11
SELECT nombre , precio FROM producto ORDER BY nombre ASC , precio DESC; -- EJ 14
SELECT nombre , MAX(precio) FROM producto LIMIT 2 ; -- EJ 15

/*16. Lista el nombre de los productos que tienen un precio menor o igual a $120.
17. Lista todos los productos que tengan un precio entre $60 y $200. Utilizando el
operador BETWEEN.
18. Lista todos los productos donde el código de fabricante sea 1, 3 o 5. Utilizando el
operador IN.
23. Devuelve una lista con el nombre de todos los productos que contienen la cadena
Portátil en el nombre*/

SELECT nombre , precio FROM producto WHERE precio <= 120; -- EJ 16
SELECT nombre , precio FROM producto WHERE precio BETWEEN 60 AND 200; -- EJ 17
SELECT nombre , codigo_fabricante FROM producto WHERE codigo_fabricante IN (1,3,5);
SELECT nombre FROM producto WHERE nombre LIKE '%portatil%'; -- EJ 23

/*Consultas Multitabla

1. Devuelve una lista con el código del producto, nombre del producto, código del
fabricante y nombre del fabricante, de todos los productos de la base de datos.
2. Devuelve una lista con el nombre del producto, precio y nombre de fabricante de
todos los productos de la base de datos. Ordene el resultado por el nombre del
fabricante, por orden alfabético.
3. Devuelve el nombre del producto, su precio y el nombre de su fabricante, del
producto más barato.
4. Devuelve una lista de todos los productos del fabricante Lenovo. */
SELECT  p.codigo,  p.nombre ,  f.codigo , f.nombre FROM producto p, fabricante f;
SELECT p.nombre , p.precio , f.nombre FROM producto p , fabricante f 
WHERE f.codigo = p.codigo_fabricante ORDER BY f.nombre ASC; -- EJ 2
SELECT p.nombre , MIN(p.precio) , f.nombre FROM producto p , fabricante f ; -- EJ 3
SELECT p.nombre , f.nombre FROM producto p, fabricante f WHERE f.nombre LIKE 'lenovo';

/*
5. Devuelve una lista de todos los productos del fabricante Crucial que tengan un
precio mayor que $200.
6. Devuelve un listado con todos los productos de los fabricantes Asus, HewlettPackard. Utilizando el operador IN.
7. Devuelve un listado con el nombre de producto, precio y nombre de fabricante, de
todos los productos que tengan un precio mayor o igual a $180. Ordene el resultado
en primer lugar por el precio (en orden descendente) y en segundo lugar por el
nombre (en orden ascendente)*/

SELECT p.nombre , p.precio FROM producto p , fabricante f WHERE f.nombre LIKE 'crucial' AND p.precio>200; 
SELECT p.nombre FROM producto p, fabricante f WHERE f.nombre IN ('Asus' , 'HewlettPackard');
SELECT p.nombre , p.precio, f.nombre FROM producto p, fabricante f 
WHERE f.codigo = p.codigo_fabricante AND p.precio>=180 ORDER BY p.precio DESC , p.nombre ASC ;

/* Consultas Multitabla
Resuelva todas las consultas utilizando las cláusulas LEFT JOIN y RIGHT JOIN.
1. Devuelve un listado de todos los fabricantes que existen en la base de datos, junto
con los productos que tiene cada uno de ellos. El listado deberá mostrar también
aquellos fabricantes que no tienen productos asociados.
2. Devuelve un listado donde sólo aparezcan aquellos fabricantes que no tienen
ningún producto asociado */

SELECT f.nombre , p.nombre FROM fabricante f  LEFT JOIN producto p ON f.codigo = p.codigo_fabricante;
SELECT f.nombre , p.nombre FROM producto p RIGHT JOIN  fabricante f ON f.codigo = p.codigo_fabricante;
 
SELECT *
FROM fabricante   -- EJERCICIO 2
WHERE codigo
NOT IN(SELECT codigo_fabricante FROM producto);

/* Subconsultas (En la cláusula WHERE)
Con operadores básicos de comparación
1. Devuelve todos los productos del fabricante Lenovo. (Sin utilizar INNER JOIN).
2. Devuelve todos los datos de los productos que tienen el mismo precio que el
producto más caro del fabricante Lenovo. (Sin utilizar INNER JOIN).
3. Lista el nombre del producto más caro del fabricante Lenovo.
4. Lista todos los productos del fabricante Asus que tienen un precio superior al precio
medio de todos sus productos. */

SELECT p.nombre , f.nombre FROM producto p, fabricante f WHERE f.nombre LIKE 'lenovo';

SELECT  p.nombre FROM producto p , fabricante f 
WHERE p.precio = (SELECT MAX(precio) FROM producto p, fabricante f WHERE f.nombre LIKE 'lenovo'
) ;
  
SELECT MAX(precio) , p.nombre , f.nombre  FROM producto p , fabricante f WHERE f.nombre LIKE 'lenovo';

SELECT AVG(p.precio) FROM producto p , fabricante f WHERE f.nombre LIKE 'asus'; 

SELECT p.nombre , p.precio FROM producto p, fabricante f 
WHERE f.nombre LIKE 'asus' AND p.precio> (SELECT AVG(p.precio) FROM producto p , fabricante f WHERE f.nombre LIKE 'asus' 
);

/* Subconsultas con IN y NOT IN
1. Devuelve los nombres de los fabricantes que tienen productos asociados.
(Utilizando IN o NOT IN).
2. Devuelve los nombres de los fabricantes que no tienen productos asociados.
(Utilizando IN o NOT IN). */



/*Subconsultas (En la cláusula HAVING)
1. Devuelve un listado con todos los nombres de los fabricantes que tienen el mismo
número de productos que el fabricante Lenovo. */


SELECT f.nombre, count(*)
FROM producto p, fabricante f
WHERE p.codigo_fabricante = f.codigo
GROUP BY f.nombre
HAVING count(*) = (SELECT count(*)
FROM producto p, fabricante f
WHERE p.codigo_fabricante = f.codigo
AND f.nombre = 'Lenovo');
