--Seleccionar todos los empleados con su EMPLOYEE_ID, FIRST_NAME, LAST_NAME y SALARY.
select employee_id, first_name, last_name, salary
from employees;

--Obtener los nombres y apellidos de los empleados que ganan más de 7000.
select first_name, last_name
from employees
where salary > 7000;

--Listar los empleados cuyo FIRST_NAME empieza con la letra 'A'.
select first_name
from employees
where first_name like 'A%'

--Obtener los empleados contratados después del 1 de enero de 2005.
select employee_id, first_name, last_name, hire_date
from employees
where hire_date > to_date('2005-01-01', 'yyyy-mm-dd');

--Mostrar los empleados cuyo SALARY está entre 5000 y 10000.
select * from employees
where salary between 5000 and 10000;

--Listar los empleados ordenados por LAST_NAME en orden alfabético.
select last_name
from employees 
order by last_name asc;

--Obtener los empleados que NO tienen un COMMISSION_PCT.
select * from employees
where commission_pct is not null;

--Contar cuántos empleados hay en la empresa.
select count(*) as total_empleados
from employees;

--Calcular el salario promedio de todos los empleados.
select round(avg(salary)) as avg_salary
from employees;

--Mostrar el salario más alto y el más bajo registrado en la tabla.
select max(salary) as higher_salary, min(salary) as lower_salary
from employees;

--Listar los nombres de los departamentos (DEPARTMENT_NAME).
select department_name
from departments;

--Obtener los departamentos que tienen un MANAGER_ID asignado.
select department_name
from departments
where manager_id is not null;

--Mostrar los departamentos ordenados por DEPARTMENT_NAME de manera descendente.
select department_name
from departments
order by department_name desc;

--Contar cuántos departamentos hay en la empresa.
select count(*) as total_department
from departments;

--Obtener los departamentos que están en la ubicación 1700. (location_id)
select * from departments
where location_id = 1700;

--Seleccionar todos los títulos de trabajo (JOB_TITLE).
select job_title
from jobs;

--Obtener los trabajos cuyo salario mínimo es mayor a 5000.
select job_title, min_salary
from jobs
where min_salary > 5000;

--Mostrar los trabajos cuyo JOB_TITLE contiene la palabra ‘Manager’.
select job_title
from jobs
where job_title like '%Manager';

--Obtener los trabajos en orden alfabético.
select job_title
from jobs
order by job_title asc;

--Contar cuántos trabajos distintos existen en la empresa.
select count(*) as total_jobs
from jobs

--Muestra el salario promedio por departamento. 
select d.department_name, round(avg(salary)) as avg_salary
from departments d, employees e
where d.department_id = e.department_id
group by d.department_name;

select * from employees;
select * from departments;
select * from jobs;

--Muestra los departamentos donde el salario promedio sea mayor a 7000.
select d.department_name, round(avg(salary)) as avg_salary
from departments d, employees e
where d.department_id = e.department_id
group by d.department_name
having avg(e.salary) > 7000;

--Muestra los 3 empleados mejor pagados que trabajan en el departamento "IT", ordenados por salario
select e.first_name, e.last_name, d.department_name, e.salary
from departments d, employees e
where d.department_id = e.department_id and d.department_name = 'IT'
and rownum <= 3
order by e.salary desc;

--Muestra la cantidad de empleados asignados a cada puesto (JOB_ID).
--Sólo incluye aquellos puestos donde haya más de 3 empleados.
--Ordena los resultados de mayor a menor según la cantidad de empleados.
select j.job_title, count(*) as total_empleados
from employees e, jobs j
where j.job_id = e.job_id
group by j.job_title
having count(*) > 3
order by total_empleados desc;

--Muestra el nombre del departamento, la suma total de los salarios y el salario promedio de sus empleados.
--Incluye únicamente los departamentos donde la suma total de salarios sea mayor a 50000.
select d.department_name, sum(e.salary) as total_salario, round(avg(e.salary)) as avg_salary
from employees e, departments d
where d.department_id = e.department_id
group by d.department_name
having sum(e.salary) > 50000
order by total_salario desc;






