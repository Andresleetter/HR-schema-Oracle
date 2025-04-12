/*
Encuentra los empleados que tienen al menos un subordinado (considerando que el manager_id en la tabla employees indica quién es su jefe).
*/
SELECT 
    e.first_name || ' ' || e.last_name AS employee_name,
    --consulta extra
    (SELECT COUNT(*) FROM employees e2 WHERE e.employee_id = e2.manager_id) AS subordinates_count
FROM employees e
WHERE EXISTS (
    SELECT 1
    FROM employees e2
    WHERE e.employee_id = e2.manager_id
)
ORDER BY subordinates_count DESC;

--Lista los departamentos que tienen empleados asignados.
SELECT 
    d.department_name,
    (SELECT COUNT(*) FROM employees e2 WHERE e2.department_id = d.department_id) AS count_emp_dpt
FROM departments d
WHERE EXISTS (
    SELECT 1
    FROM employees e2
    WHERE e2.department_id = d.department_id
);

--Muestra los empleados que trabajan en un departamento que tiene al menos un gerente registrado en la tabla employees.
SELECT 
    d.department_name,
    e.first_name || ' ' || e.last_name AS employee_name
FROM employees e
JOIN departments d ON e.department_id = d.department_id
WHERE EXISTS (
    SELECT 1
    FROM employees e2
    WHERE e.department_id = e2.department_id
    AND e2.employee_id IN (SELECT DISTINCT manager_id FROM employees WHERE manager_id IS NOT NULL)
);

--Encuentra los empleados cuyo trabajo está en las categorías ‘IT_PROG’, ‘SA_REP’ o ‘HR_REP’.
SELECT
    first_name || ' ' || last_name AS employee_name
FROM employees
WHERE job_id IN ('IT_PROG', 'SA_REP', 'HR_REP');

--Muestra los empleados cuyo ID de departamento coincide con los departamentos ubicados en ‘United States’ (usa una subconsulta con IN y la tabla locations).
SELECT 
    e.first_name || ' ' || e.last_name AS employee_name
FROM employees e
WHERE e.department_id IN (
    SELECT
        department_id
    FROM departments d
    WHERE d.location_id IN (
        SELECT
            l.location_id
        FROM locations l
        WHERE l.country_id = 'US'
    )
);

--Lista los empleados cuyo salario es igual a los salarios más altos en cualquier departamento (usa IN con una subconsulta).
SELECT 
    first_name || ' ' || last_name AS employee_name
FROM employees e
WHERE e.salary IN (
    SELECT
        MAX(e2.salary) AS max_salary
    FROM employees e2
    GROUP BY e2.department_id
);   
    
    
    
    
    
    
    
    
    
    
    
    



SELECT * FROM countries;
SELECT * FROM departments;
SELECT * FROM employees;
SELECT * FROM locations;
