/*
Antes de ejecutar esto, asegúrate de habilitar la salida en SQL*Plus o SQL Developer con:
*/
SET SERVEROUTPUT ON;

--Ejercicio 1: Escribe un bloque PL/SQL que simplemente muestre el mensaje "¡Hola, PL/SQL!".
BEGIN
    DBMS_OUTPUT.PUT_LINE('¡Hola, PL/SQL!');
END;
/

--Ejercicio 2: Declara una variable mensaje de tipo VARCHAR2, asígnale el valor "Aprendiendo PL/SQL" y muéstrala en la salida.
DECLARE
    mensaje VARCHAR2(100) := 'Aprendiendo PL/SQL';
BEGIN
    DBMS_OUTPUT.PUT_LINE(mensaje);
END;
/

--Ejercicio 3: Declara dos variables numéricas num1 y num2, asígnales valores y muestra su suma.
DECLARE
    num1 NUMBER := 20;
    num2 NUMBER := 30;
BEGIN
    DBMS_OUTPUT.PUT_LINE('la suma es: ' || (num1 + num2));
END;
/

--Ejercicio 4: Declara una variable radio y calcula el área de un círculo (π * r^2).
DECLARE
    r NUMBER := 23;
    PI NUMBER := 3.1416;
    area NUMBER;
BEGIN
    area := PI * r**2;
    DBMS_OUTPUT.PUT_LINE('El area del circulo es: ' || area);
END;
/

--Ejercicio 5: Declara una variable edad, asígnale un valor y usa un IF para verificar si es mayor o menor de edad.
DECLARE
    edad INTEGER := 16;
BEGIN
    IF edad > 18 THEN
        DBMS_OUTPUT.PUT_LINE('Es mayor de edad');
    ELSE 
        DBMS_OUTPUT.PUT_LINE('Es menor de edad');
    END IF;
END;
/

--Ejercicio 6: Usa un LOOP para imprimir los números del 1 al 5 en la salida.
DECLARE
    numero INTEGER := 1;
BEGIN
LOOP
    DBMS_OUTPUT.PUT_LINE('Numero: ' || numero);
    numero := numero + 1;
    
    EXIT WHEN numero > 5;
END LOOP;
END;
/

--Ejercicio 7: Usa CASE para clasificar un número en "POSITIVO", "NEGATIVO" o "CERO".
DECLARE
    numero INTEGER := 0;
    clasificacion VARCHAR(50);
BEGIN
    clasificacion := CASE
                WHEN numero > 0 THEN 'positivo'
                WHEN numero < 0 THEN 'negativo'
                ELSE 'cero'
            END;
    DBMS_OUTPUT.PUT_LINE('EL numero es: ' || clasificacion);
END;
/

--Ejercicio 8: Declara una variable para almacenar el nombre de un empleado (first_name) y recupera su valor desde la tabla employees con un SELECT INTO.
DECLARE
    v_nombre employees.first_name%TYPE;
BEGIN
    SELECT 
        first_name
    INTO 
        v_nombre
    FROM employees
    WHERE ROWNUM = 1;
    DBMS_OUTPUT.PUT_LINE('El nombre del empleado es: '|| v_nombre);
END;
/

--Ejercicio 9: Declara una variable salario, obtén el salario de un empleado y aumenta un 10%.

DECLARE
    v_name employees.first_name%TYPE;
    v_salary employees.salary%TYPE;
BEGIN
    SELECT
        first_name, 
        salary
    INTO
        v_name,
        v_salary
    FROM employees
    WHERE ROWNUM = 1;
    DBMS_OUTPUT.PUT_LINE('Empleado: '|| v_name || ' | Salario: '|| v_salary || ' | Nuevo salario: ' || (v_salary * 0.1 + v_salary) );
END;
/

/*
Ejercicio 10: Declara una variable fecha_contratacion, obtén la fecha de contratación de un empleado de employees y
muestra cuántos años han pasado desde su contratación.
*/

DECLARE
    v_hiring employees.hire_date%TYPE;
    v_seniority NUMBER;
BEGIN
    SELECT
        hire_date
    INTO
        v_hiring
    FROM employees
    WHERE ROWNUM = 1;
    
    v_seniority := ROUND(MONTHS_BETWEEN(SYSDATE, v_hiring) / 12, 1);
    
    DBMS_OUTPUT.PUT_LINE('Antiguedad: '|| v_seniority || ' años');
END;
/












