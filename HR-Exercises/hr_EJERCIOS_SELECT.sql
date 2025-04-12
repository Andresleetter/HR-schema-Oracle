SELECT * FROM EMPLOYEES; --SELECT SE UTILIZA PARA SELECCIONAR UNA COLUMNA

SELECT FIRST_NAME, LAST_NAME -- LAS COMAS SE UTILIZAN PARA SEPARAR COLUMNAS
FROM EMPLOYEES;

SELECT FIRST_NAME
FROM EMPLOYEES
ORDER BY FIRST_NAME ASC; -- ASC PARA ORDENAR DE FORMA ASCENDENTE

SELECT JOB_ID
FROM EMPLOYEES;

SELECT * FROM EMPLOYEES WHERE SALARY > 5000;

SELECT * FROM EMPLOYEES WHERE DEPARTMENT_ID=60;

--Obtener los empleados que fueron contratados después del 1 de enero de 2005.
SELECT * FROM EMPLOYEES WHERE HIRE_DATE > TO_DATE('2005-01-01', 'YYYY-MM-DD');

--Listar los empleados cuyo nombre empiece con la letra 'A'.
SELECT * FROM EMPLOYEES WHERE FIRST_NAME LIKE 'A%'; --PARA BUSCAR UNA LETRA EN ESPECIFICO SE UTILIZA LIKE '()%'

--Mostrar los empleados cuyo apellido termine con la letra 'z'.
SELECT * FROM EMPLOYEES WHERE LAST_NAME LIKE '%Z'; 

--Listar los empleados cuyo salario esté entre 3000 y 7000.
SELECT * FROM EMPLOYEES WHERE SALARY BETWEEN 3000 AND 7000;

--Obtener los empleados que tienen un bono (COMMISSION_PCT) asignado.
SELECT * FROM EMPLOYEES WHERE COMMISSION_PCT IS NOT NULL;

--Mostrar los empleados que no tienen gerente asignado.
SELECT * FROM EMPLOYEES WHERE MANAGER_ID IS NOT NULL;

--Obtener los empleados contratados en el año 2006.
SELECT * FROM EMPLOYEES WHERE EXTRACT(YEAR FROM HIRE_DATE) = 2006;

--Listar los empleados cuyo salario sea menor a 4000 o mayor a 10000.
SELECT * FROM EMPLOYEES WHERE SALARY < 4000 OR SALARY > 10000;

--Mostrar los 5 empleados con los salarios más altos.
SELECT * FROM EMPLOYEES
ORDER BY SALARY DESC 
FETCH FIRST 5 ROWS ONLY;

--Obtener la cantidad total de empleados en la empresa.
SELECT COUNT(*) AS TOTAL_EMPLEADOS
FROM EMPLOYEES;

--Calcular el salario promedio de todos los empleados.
SELECT AVG(SALARY) AS SALARIO_PROMEDIO
FROM EMPLOYEES;

--Mostrar el salario más alto y el más bajo de la empresa.
SELECT MAX(SALARY) AS SALARY_HIGHER, MIN(SALARY) AS SALARY_LOWER
FROM EMPLOYEES;

--Obtener el número de empleados por cada trabajo (JOB_ID).
SELECT JOB_ID, COUNT(*) AS CANTIDAD_EMPLEADOS
FROM EMPLOYEES
GROUP BY JOB_ID;

--Contar cuántos empleados tienen un bono asignado.
SELECT COMMISSION_PCT, COUNT(*) AS EMPLEADOS_BONOS
FROM EMPLOYEES
GROUP BY COMMISSION_PCT;









