/*
Muestra el department_name, el first_name y last_name del empleado con el salario más alto en cada departamento.
Usa una subconsulta correlacionada para encontrar al empleado con el salario máximo.
Ordena por department_name.
*/
SELECT department_name, first_name ||' '|| last_name AS employee_name
FROM (
    SELECT d.department_name, e.first_name, e.last_name, e.salary
    FROM employees e
    JOIN departments d ON e.department_id = d.department_id
    WHERE e.salary = (
        SELECT MAX(e2.salary) AS max_salary
        FROM employees e2
        WHERE e2.department_id = e.department_id
    )
) employee_max_salary
ORDER BY department_name;

/*
Muestra department_name, first_name, last_name, salary y la diferencia entre el salario del empleado y el salario promedio de su departamento.
Usa AVG(salary) OVER (PARTITION BY department_id) para calcular el promedio por departamento.
Ordena por department_name y salary DESC.
*/
SELECT 
    department_name, first_name ||' '|| last_name AS employee_name, salary,
        salary - ROUND(AVG(salary) OVER(PARTITION BY department_id), 2) AS diff_department_avg_salary
FROM (
    SELECT
        d.department_name, e.first_name, e.last_name, e.salary, e.department_id
    FROM employees e
    JOIN departments d ON e.department_id = d.department_id
) subquery
ORDER BY department_name, salary DESC;

/*
Muestra country_name y la cantidad total de empleados en cada país.
Usa JOIN para unir las tablas necesarias.
Agrupa por país y usa HAVING para mostrar solo países con más de 5 empleados.
Ordena de mayor a menor cantidad de empleados.
*/
SELECT
    country_name,
    count_employees 
FROM (
    SELECT c.country_name, COUNT(*) AS count_employees
    FROM employees e
    JOIN departments d ON e.department_id = d.department_id
    JOIN locations l ON d.location_id = l.location_id  
    JOIN countries c ON l.country_id = c.country_id
    GROUP BY c.country_name
    HAVING COUNT(*) > 5
) country_employees
ORDER BY count_employees DESC;

/*
Muestra department_name, first_name, last_name, salary y el ranking de salario dentro del departamento.
Usa RANK() OVER (PARTITION BY department_id ORDER BY salary DESC).
Ordena por department_name y ranking.
*/
SELECT
    first_name ||' '|| last_name AS employee_name,department_name, salary, salary_rank
FROM (
    SELECT
    d.department_name, e.first_name, e.last_name, e.salary, 
        RANK() OVER(PARTITION BY e.department_id ORDER BY e.salary DESC) AS salary_rank
    FROM employees e
    JOIN departments d ON e.department_id = d.department_id
) t
ORDER BY department_name, salary_rank;

/*
Muestra department_name, first_name, last_name y la antigüedad de los empleados.
Usa MONTHS_BETWEEN(SYSDATE, hire_date) / 12 para calcular la antigüedad.
Usa DENSE_RANK() OVER (PARTITION BY department_id ORDER BY hire_date ASC) para encontrar los 3 empleados con mayor antigüedad en cada departamento.
Ordena por department_name y ranking de antigüedad.
*/
SELECT
    department_name, first_name ||' '|| last_name AS employee_name, seniority, seniority_rank
FROM (
    SELECT
        d.department_name, e.first_name, e.last_name, ROUND(MONTHS_BETWEEN(SYSDATE, e.hire_date) / 12, 2) AS seniority,
        DENSE_RANK() OVER(PARTITION BY e.department_id ORDER BY e.hire_date ASC) AS seniority_rank
    FROM employees e
    JOIN departments d ON e.department_id = d.department_id
) count_seniority
WHERE seniority_rank <= 3
ORDER BY department_name, seniority, seniority_rank;

/*
Muestra job_title, first_name, last_name, salary y la diferencia entre el salario del empleado y el salario promedio de su cargo.
Usa una subconsulta en el SELECT para calcular el salario promedio de cada job_id.
Ordena por job_title y salary DESC.
*/
SELECT 
    job_title, first_name ||' '|| last_name AS employee_name, salary,
        salary - ROUND(AVG(salary) OVER(PARTITION BY job_id), 2) AS diff_job_avg_salary
FROM (
    SELECT
        j.job_title, e.first_name, e.last_name, e.job_id, e.salary
    FROM employees e
    JOIN jobs j ON e.job_id = j.job_id
) t
ORDER BY job_title, salary DESC;












select * from locations;
select * from countries;
select * from departments;
select * from employees;