/*
Muestra empleados junto con su manager y la ciudad donde trabajan.
Ordena por ciudad y luego por nombre del manager.
*/
SELECT 
e.first_name ||' '|| e.last_name AS employee_name,
COALESCE(m.first_name||' '||m.last_name, 'sin manager') AS manager_name,
l.city
FROM employees e
LEFT JOIN employees m ON e.manager_id = m.employee_id
JOIN departments d ON e.department_id = d.department_id
JOIN locations l ON d.location_id = l.location_id
ORDER BY l.city, manager_name;

/*
Muestra empleados que trabajan en ciudades donde hay oficinas en los EE.UU. (COUNTRY_ID = 'US').
*/
SELECT
TRIM(e.first_name ||' '|| e.last_name) AS employee_name,
l.city AS work_city
FROM employees e
JOIN departments d ON e.department_id = d.department_id
JOIN locations l ON d.location_id = l.location_id
WHERE l.country_id = 'US'
ORDER BY employee_name, l.city;

/* 
Muestra los puestos (JOBS.JOB_ID) con menos empleados actualmente que en el pasado.
*/
SELECT 
e.job_id, 
e.count_employees AS current_employees, 
e2.past_employees AS past_employees
FROM (
    --subconsulta para calcular la cantidad de empleados en el puesto de trabajo
    SELECT job_id, COUNT(*) AS count_employees
    FROM employees
    GROUP BY job_id
) e
JOIN (
    --subconsulta para calcular la cantidad de empleados en el pasado
    SELECT job_id, COUNT(*) AS past_employees
    FROM job_history
    GROUP BY job_id
) e2
ON e.job_id = e2.job_id --calcula la cantidad de empleados en el presente y pasado
WHERE e.count_employees < e2.past_employees;

/*
Calcula el salario promedio de los empleados por país.
Ordena de mayor a menor.
*/
SELECT 
country_name, ROUND(AVG(salary), 2) AS avg_salary
FROM (
    --subconsulta para calcular el salario y los paises de los empleados
    SELECT 
    TRIM(e.first_name ||' '|| e.last_name) AS employee_name, 
    c.country_name,
    e.salary
    FROM employees e
    JOIN departments d ON e.department_id = d.department_id
    JOIN locations l ON d.location_id = l.location_id
    JOIN countries c ON l.country_id = c.country_id
) employee_country
GROUP BY country_name
ORDER BY avg_salary DESC;

/*
Encuentra managers que tienen empleados en más de un país.
*/
SELECT 
e.manager_id,
TRIM(COALESCE(m.first_name ||' '|| m.last_name, 'sin manager')) AS manager_name,
COUNT(DISTINCT l.country_id) AS count_countries
FROM employees e
LEFT JOIN employees m ON e.manager_id = m.employee_id
JOIN departments d ON e.department_id = d.department_id
JOIN locations l ON d.location_id = l.location_id
GROUP BY e.manager_id, m.first_name, m.last_name
HAVING COUNT(DISTINCT l.country_id) > 1;













    









select * from locations;
select * from countries;
select * from departments;
select * from employees;