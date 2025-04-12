/* 
Muestra el nombre del departamento y el salario máximo entre sus empleados.
Filtra para que solo se incluyan los departamentos donde el salario máximo sea mayor a 10000.
Ordena los resultados de forma descendente por salario máximo.
*/
select d.department_name, max(e.salary) as max_salary
from employees e, departments d
where d.department_id = e.department_id
group by d.department_name
having max(e.salary) > 10000
order by max_salary desc;

/*
Muestra el nombre del departamento junto con la cantidad de empleados en cada uno.
Ordena de mayor a menor según la cantidad de empleados y muestra sólo los 5 primeros resultados.
*/
select d.department_name, count(*) as all_employees
from employees e, departments d
where d.department_id = e.department_id
group by d.department_name
order by all_employees desc
fetch first 5 rows only;

/*
Muestra el nombre del empleado, el nombre del departamento y su salario.
Sólo incluye a aquellos empleados cuyo salario sea mayor que el salario promedio de su respectivo departamento.
Ordena los resultados por el nombre del departamento y, dentro de cada uno, de mayor a menor salario.
*/
select e.first_name, e.last_name, d.department_name, e.salary
from employees e, departments d
where d.department_id = e.department_id
and e.salary > (select avg(e2.salary)
                from employees e2
                where e2.department_id = e.department_id)
order by d.department_name desc, e.salary desc;

/*
Calcula la suma total de los salarios de todos los empleados.
Luego, muestra los departamentos donde la suma de salarios representa más del 75% del total general.
Ordena los resultados de mayor a menor según el total de salarios en cada departamento.
*/
SELECT d.department_name, SUM(e.salary) AS sum_salary
FROM employees e, departments d
WHERE d.department_id = e.department_id
GROUP BY d.department_name
HAVING SUM(e.salary) > 0.75 * (SELECT SUM(salary) FROM employees)
ORDER BY SUM(e.salary) DESC;

/*
Calcula el porcentaje del salario total que aporta cada departamento.
Muestra los departamentos con más del 10% del total.
Ordena los resultados de mayor a menor.
*/
SELECT d.department_id, d.department_name, SUM(e.salary) AS sum_salary,
ROUND(SUM(e.salary) * 100 / (SELECT SUM(salary) FROM employees), 2) AS percentage
FROM employees e
JOIN departments d ON e.department_id = d.department_id
GROUP BY d.department_id, d.department_name
HAVING ROUND(SUM(e.salary) * 100 / (SELECT SUM(salary) FROM employees), 2) > 10
ORDER BY percentage DESC;

/*
Calcula el salario promedio de los empleados.
Obtén los empleados que ganan más del 30% por encima del promedio.
Usa funciones analíticas para ver la posición de cada salario respecto al promedio.
*/
SELECT first_name, last_name, salary, avg_salary, 
       salary - avg_salary AS diff_from_avg,
       RANK() OVER(ORDER BY salary DESC) AS salary_rank
FROM (
    SELECT first_name, last_name, salary, ROUND(AVG(salary) OVER(), 2) AS avg_salary
    FROM employees
) t 
WHERE salary > avg_salary * 1.3;

/*
Asigna un ranking (RANK()) a los empleados dentro de su departamento según el salario.
Muestra solo los tres mejor pagados de cada departamento.
*/
SELECT department_name, first_name, last_name, salary, salary_rank
FROM (
    SELECT d.department_name, e.first_name, e.last_name, e.salary, 
        RANK() OVER(PARTITION BY e.department_id ORDER BY e.salary DESC) AS salary_rank
    FROM employees e
    JOIN departments d ON e.department_id = d.department_id
) t
WHERE salary_rank <= 3;

/* 
Diferencia entre el salario de cada empleado y el de su manager
Muestra empleados junto con su salario y el de su manager.
Calcula la diferencia (salario_empleado - salario_manager).
Filtra aquellos que ganan más que su jefe.
*/
SELECT first_name, last_name, salary, salary_manager, salary - salary_manager AS diff_salary
FROM (
    SELECT e.first_name, e.last_name, e.salary, m.salary AS salary_manager
    FROM employees e
    LEFT JOIN employees m ON e.manager_id = m.employee_id
) t
WHERE salary > salary_manager;













