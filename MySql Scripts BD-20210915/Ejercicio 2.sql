/* 1. Obtener los datos completos de los empleados.
2. Obtener los datos completos de los departamentos.
3. Listar el nombre de los departamentos.
4. Obtener el nombre y salario de todos los empleados.
5. Listar todas las comisiones.
6. Obtener los datos de los empleados cuyo cargo sea ‘Secretaria’.
7. Obtener los datos de los empleados vendedores, ordenados por nombre
alfabéticamente */

SELECT * FROM empleados; -- 1
SELECT * FROM departamentos; -- 2 
SELECT nombre_depto FROM departamentos; -- 3
SELECT nombre , (sal_emp ) FROM empleados; -- 4
SELECT nombre , comision_emp FROM empleados; -- 5
SELECT nombre FROM empleados WHERE cargo_emp = 'Secretaria'  ; -- 6
SELECT * FROM empleados WHERE cargo_emp = 'vendedor' ORDER BY nombre ASC ;  -- 7

/*8. Obtener el nombre y cargo de todos los empleados, ordenados por salario de
menor a mayor.
9. Elabore un listado donde para cada fila, figure el alias ‘Nombre’ y ‘Cargo’ para
las respectivas tablas de empleados.
10. Listar los salarios y comisiones de los empleados del departamento 2000,
ordenado por comisión de menor a mayor.
11. Obtener el valor total a pagar que resulta de sumar el salario y la comisión de los
empleados del departamento 3000 una bonificación de 500, en orden alfabético
del empleado.
12. Muestra los empleados cuyo nombre empiece con la letra J.*/

SELECT  nombre , cargo_emp FROM empleados ORDER BY sal_emp ASC; -- 8
SELECT  nombre AS Nombre , cargo_emp AS Cargo FROM empleados ORDER BY sal_emp ASC; -- 9
SELECT nombre, sal_emp , comision_emp FROM empleados WHERE id_depto = 2000 ORDER BY comision_emp ASC; -- 10
SELECT nombre , ( sal_emp + comision_emp + 500) FROM empleados WHERE id_depto = 3000 ORDER BY nombre ASC; -- 11
SELECT nombre FROM empleados WHERE nombre LIKE 'j%'; -- 12

/*
13. Listar el salario, la comisión, el salario total (salario + comisión) y nombre, de
aquellos empleados que tienen comisión superior a 1000.
14. Obtener un listado similar al anterior, pero de aquellos empleados que NO
tienen comisión.
15. Obtener la lista de los empleados que ganan una comisión superior a su sueldo.
16. Listar los empleados cuya comisión es menor o igual que el 30% de su sueldo.
17. Hallar los empleados cuyo nombre no contiene la cadena “MA”
*/

SELECT nombre, comision_emp , (sal_emp + comision_emp) FROM empleados WHERE comision_emp >1000; 
SELECT nombre, comision_emp , (sal_emp + comision_emp) FROM empleados WHERE comision_emp = 0; 
SELECT nombre , comision_emp, sal_emp FROM empleados WHERE comision_emp > sal_emp;
SELECT nombre , sal_emp , comision_emp FROM empleados WHERE comision_emp <= (sal_emp * 0.3);  
SELECT nombre FROM empleados WHERE nombre LIKE '%ma%';

/* 
18. Obtener los nombres de los departamentos que sean “Ventas” ni “Investigación”
ni ‘Mantenimiento.
19. Ahora obtener los nombres de los departamentos que no sean “Ventas” ni
“Investigación” ni ‘Mantenimiento.
20. Mostrar el salario más alto de la empresa.
21. Mostrar el nombre del último empleado de la lista por orden alfabético.
22. Hallar el salario más alto, el más bajo y la diferencia entre ellos.
23. Hallar el salario promedio por departamento.
*/

SELECT nombre_depto FROM departamentos WHERE nombre_depto IN ( 'Ventas' , 'Investigación' ,'Mantenimiento'); -- 18
SELECT nombre_depto FROM departamentos WHERE nombre_depto NOT IN ( 'Ventas' , 'Investigación' ,'Mantenimiento'); -- 19
SELECT nombre , MAX(sal_emp) FROM empleados;
SELECT MAX(nombre) FROM empleados ;  -- 21
SELECT MAX(sal_emp) , MIN(sal_emp) , (MAX(sal_emp) - MIN(sal_emp) ) AS Diferencia FROM empleados;

SELECT  ROUND(AVG (sal_emp)) FROM  empleados ; 

SELECT ROUND(AVG (sal_emp))   FROM  empleados   ORDER BY  id_depto ; 

select d.nombre_depto , ROUND(AVG (e.sal_emp))
from departamentos d, empleados e
where d.id_depto=e.id_depto
group by d.nombre_depto;

/*
Consultas con Having
24. Hallar los departamentos que tienen más de tres empleados. Mostrar el número
de empleados de esos departamentos.
25. Mostrar el código y nombre de cada jefe, junto al número de empleados que
dirige. Solo los que tengan más de dos empleados (2 incluido).
26. Hallar los departamentos que no tienen empleados
*/
 

SELECT id_depto AS 'ID DEPARTAMENTO', count(id_emp) AS 'CANTIDAD DE EMPLEADOS' 
FROM empleados
GROUP BY id_depto 
HAVING count(id_emp)>3;   --  Ejercicio 24

 SELECT id_depto AS 'ID DEPARTAMENTO', count(id_emp) AS 'CANTIDAD DE EMPLEADOS' 
FROM empleados
GROUP BY id_depto ;

SELECT id_emp ,  nombre  AS 'Jefes' , count(id_depto)  as 'Empleados a cargo'
FROM empleados 
WHERE cargo_emp  LIKE 'Jefe%'   -- EJ 25 no esta bien
having count(id_depto) >= 2;


SELECT id_emp AS 'Num Empleado',  nombre  AS 'Jefes' -- , count(id_depto)  as 'Empleados a cargo'
FROM empleados e , (SELECT id_depto AS 'ID DEPARTAMENTO', count(id_emp) AS 'CANTIDAD DE EMPLEADOS' 
FROM e
GROUP BY id_depto 
HAVING count(id_emp)>3)
WHERE cargo_emp LIKE 'Jefe%'   ;  -- EJ 25 no esta bien
 
 
SELECT e.nombre, e.cod_jefe, count(*) AS 'Nº EMPLEADOS'
FROM departamentos d, empleados e
WHERE cargo_emp LIKE 'Jefe%' -- WHERE d.cod_director = e.cod_jefe
GROUP BY e.cod_jefe          -- TAMPOCO ESTA BIEN
HAVING count(*) >= 2;

SELECT e.nombre, e.cod_jefe, count(*) AS 'Nº EMPLEADOS'
FROM   empleados e
LEFT JOIN departamentos d
ON d.cod_director = e.cod_jefe   
WHERE e.cargo_emp LIKE 'Jefe%' -- WHERE d.cod_director = e.cod_jefe
GROUP BY e.cod_jefe          -- TAMPOCO ESTA BIEN
HAVING count(*) >= 2;
 
SELECT e.cod_jefe  AS 'Codigo Jefe', e.nombre AS 'Nombre Jefe', COUNT(*) AS 'N° Empleados'
FROM empleados e, departamentos d
WHERE d.cod_director = e.cod_jefe  -- TAMPOCO ESTA BIEN
GROUP BY e.cod_jefe
HAVING COUNT(*) >= 2;


SELECT d.nombre_depto, d.id_depto, count(e.id_emp)
FROM departamentos d
LEFT JOIN empleados e
ON d.id_depto = e.id_depto     -- EJERCICIO 26
GROUP BY d.id_depto
HAVING count(e.id_emp) = 0;

-- 27. Mostrar la lista de los empleados cuyo salario es mayor o igual 
-- que el promedio de la empresa. Ordenarlo por departamento.
SELECT AVG(sal_emp) FROM Empleados;  -- PRUEBA PARA SABER EL PROMEDIO DE SALARIO

SELECT nombre , sal_emp FROM empleados  -- EJ 27
WHERE sal_emp >= (SELECT AVG(sal_emp) FROM Empleados);

 

 
