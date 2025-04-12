--Reto 1: Muestra los nombres de los empleados junto con el nombre de su departamento usando un INNER JOIN
SELECT 
    e.first_name || ' ' || e.last_name AS employee_name, d.department_name
FROM employees e
INNER JOIN departments d ON e.department_id = d.department_id;

--Reto 2: Lista todos los departamentos y muestra también a los empleados asignados, si los hay, usando un LEFT JOIN.
SELECT 
    COALESCE(e.first_name || ' ' || e.last_name, 'without employee') AS employee_name,
    d.department_name,
    COALESCE(emp_count.count_employees, 0) AS count_employees
FROM departments d
LEFT JOIN employees e ON d.department_id = e.department_id
LEFT JOIN (
    SELECT 
        department_id, COUNT(*) AS count_employees
    FROM employees
    GROUP BY department_id
) emp_count
ON d.department_id = emp_count.department_id
ORDER BY d.department_name;

--Reto 3: Lista todos los empleados junto con los departamentos, pero muestra también los departamentos sin empleados usando un RIGHT JOIN.
SELECT 
    COALESCE(e.first_name || ' ' || e.last_name, 'without employee') AS employee_name,
    COALESCE(d.department_name,'without department') AS department_name,
    COALESCE(count_emp.count_employees, 0) AS count_employees
FROM employees e
RIGHT JOIN departments d ON d.department_id = e.department_id
LEFT JOIN (
    SELECT
        department_id, COUNT(*) AS count_employees
    FROM employees
    GROUP BY department_id
) count_emp
ON d.department_id = count_emp.department_id
ORDER BY COALESCE(d.department_name, 'without department');


--Reto 4: Muestra una lista de todos los empleados y todos los departamentos, aunque no haya coincidencias, usando un FULL JOIN

SELECT 
    COALESCE(d.department_name, 'without department') AS department_name,
    COALESCE(e.first_name || ' ' || e.last_name, 'without employee') AS employee_name
FROM employees e
FULL JOIN departments d ON e.department_id = d.department_id;


--Reto 5: Encuentra el nombre y salario de los empleados que ganan más que el salario promedio de la empresa.

SELECT
    first_name || ' ' || last_name AS employee_name,
    salary
FROM employees
WHERE salary > (SELECT AVG(salary) AS avg_salary FROM employees);

--Reto 6: Muestra los empleados que tienen el mismo trabajo que ‘Steven King’ sin usar JOINS.
SELECT 
    first_name || ' ' || last_name AS employee_name, job_id
FROM employees 
WHERE job_id = (SELECT job_id FROM employees WHERE first_name = 'Steven' AND last_name = 'King');

--Reto 7: Lista los empleados cuyo salario sea mayor que el salario máximo del departamento 60.
SELECT 
    e.first_name || ' ' || e.last_name AS employee_name,
    e.salary,
    (SELECT MAX(salary) FROM employees WHERE department_id = 60) AS max_salary_dept_60
FROM employees e
WHERE e.salary > (
    SELECT 
        MAX(salary) AS max_salary
    FROM employees
    WHERE department_id = 60 
);

--Reto 8: Calcula el salario total pagado por cada departamento.
SELECT 
    COALESCE(d.department_name, 'without department') AS department_name,
    COALESCE(SUM(e.salary), 0) AS total_salary
FROM employees e
LEFT JOIN departments d ON e.department_id = d.department_id
GROUP BY d.department_name
ORDER BY total_salary ASC;

--Reto 9: Obtén el promedio de salarios de los empleados en cada trabajo.
SELECT 
    j.job_title,
    avg_salary_jobs.avg_salary
FROM (
    SELECT
        job_id, AVG(salary) AS avg_salary
    FROM employees 
    GROUP BY job_id
) avg_salary_jobs
LEFT JOIN jobs j ON j.job_id = avg_salary_jobs.job_id
ORDER BY avg_salary DESC;

--Reto 10: Cuenta cuántos empleados hay en cada departamento y ordénalos de mayor a menor.
SELECT
    d.department_name,
    COALESCE(emp_count.count_employees, 0) AS count_employees  --para contar tambien los dept sin empleados
FROM departments d
LEFT JOIN (
    SELECT 
        department_id,
        COUNT(*) AS count_employees
    FROM employees
    GROUP BY department_id
) emp_count
ON d.department_id = emp_count.department_id
ORDER BY count_employees DESC;

--Reto 11: Encuentra empleados que trabajen en departamentos que tienen al menos un empleado usando EXISTS.
SELECT
    d.department_name,
    e.first_name || ' ' || e.last_name AS employee_name
FROM employees e
JOIN departments d ON e.department_id = d.department_id
WHERE EXISTS (
    SELECT 1 
    FROM employees e2 
    WHERE e2.department_id = e.department_id
    AND e2.employee_id <> e.employee_id
);

--Reto 12: Muestra los empleados que pertenecen a los departamentos 10, 20 o 30 usando IN.
SELECT
    department_id,
    first_name || ' ' || last_name AS employee_name
FROM employees
WHERE department_id IN (10, 20, 30);

/*
Reto 13: Crea una consulta que agregue una columna "Categoría de Salario" donde:
‘ALTO’ si el salario es mayor a 10000,
‘MEDIO’ si está entre 5000 y 10000,
‘BAJO’ si es menor a 5000 (usa CASE).
*/
SELECT 
    first_name || ' ' || last_name,
    salary,
    CASE 
        WHEN salary > 10000 THEN 'ALTO'
        WHEN salary BETWEEN 5000 AND 10000 THEN 'MEDIO'
        ELSE 'BAJO'
    END AS salary_category
FROM employees;

--Reto 14: Muestra los empleados junto con su comisión, pero si no tienen comisión, muestra "SIN COMISIÓN" usando NVL.
SELECT
    first_name || ' ' || last_name AS employee_name,
    salary,
    commission_pct,
    NVL(TO_CHAR(commission_pct * 100, '999.9') || '%', 'without commission') AS commission_status
FROM employees;






SELECT * FROM employees;
SELECT * FROM jobs;
SELECT * FROM departments;



   