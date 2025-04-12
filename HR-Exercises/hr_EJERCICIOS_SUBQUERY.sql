/*
Muestra los empleados que no tienen un manager asignado (MANAGER_ID IS NULL).
Ordena por LAST_NAME.
*/
SELECT last_name
FROM employees
WHERE manager_id IS NULL
ORDER BY last_name;
/*
Calcula la cantidad promedio de empleados por departamento.
Muestra solo los departamentos con menos empleados que el promedio.
Ordena de menor a mayor según la cantidad de empleados.
*/
SELECT department_id, total_employees
FROM (
        --subconsulta que calcula la cantidad de empleados que hay en los departamentos
        SELECT department_id, COUNT(*) AS total_employees 
        FROM employees
        GROUP BY department_id
) dept_counts
WHERE total_employees < (
    --subconsulta que calcula el promedio de empleados por departamentos
    SELECT AVG(total_employees)
    FROM (
        SELECT department_id, COUNT(*) AS total_employees 
        FROM employees
        GROUP BY department_id
    )
)
ORDER BY total_employees ASC;

/* 
Muestra empleados junto con su manager.
Filtra los que tienen el mismo JOB_ID que su manager.
*/
SELECT emp.first_name, emp.last_name, mgr.first_name AS manager_name, mgr.last_name AS manager_last_name
FROM employees emp
INNER JOIN employees mgr ON emp.manager_id = mgr.employee_id
WHERE emp.job_id = mgr.job_id
ORDER BY manager_name, emp.first_name;

/*
Calcula el salario promedio por departamento.
Muestra solo los tres departamentos con mejor salario promedio.
*/
SELECT department_name, avg_salary
FROM (
    --subconsulta que calcula el salario promedio por departamento
    SELECT department_name, ROUND(AVG(e.salary), 2) AS avg_salary
    FROM employees e
    JOIN departments d ON e.department_id = d.department_id --iguala el department_id de la tabla departments con la department_id de la tabla employees
    GROUP BY department_name
) avg_dpt --nombre de la subconsuta avg_department
ORDER BY avg_salary DESC
FETCH FIRST 3 ROWS ONLY;

/*
Calcula cuántos años ha trabajado cada empleado (SYSDATE - HIRE_DATE).
Agrupa por departamento y muestra el promedio de años trabajados.
Ordena de mayor a menor.
*/
SELECT d.department_name, e.first_name, e.last_name,
    ROUND(MONTHS_BETWEEN(SYSDATE - e.hire_date) / 12, 2) AS seniority,
    (SELECT ROUND(AVG(MONTHS_BETWEEN(SYSDATE, e2.hire_date) / 12), 2)
        FROM employees e2
        WHERE e2.department_id = e.department_id) AS avg_seniority
FROM employees e
JOIN departments d ON e.department_id = d.department_id
ORDER BY d.department_name, seniority DESC;

/*
Muestra empleados con su SALARY, JOB_ID y el salario minimo permitido (MIN_SALARY).
Filtra aquellos que tienen un SALARY mayor que el MIN_SALARY de su puesto.
*/
SELECT j.job_id, e.first_name ||' '|| e.last_name AS employee_name, e.salary, j.min_salary
FROM employees e
JOIN jobs j ON e.job_id = j.job_id
WHERE e.salary > COALESCE(j.min_salary, 0);

















