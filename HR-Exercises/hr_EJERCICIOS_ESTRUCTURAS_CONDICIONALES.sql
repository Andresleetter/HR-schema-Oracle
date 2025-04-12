SET SERVEROUTPUT ON;

--Ejercicio 1: Declara una variable edad, asígnale un valor y usa IF para imprimir si la persona es mayor o menor de edad.
DECLARE
    age INTEGER := 21;
BEGIN
    IF age >= 18 THEN
        DBMS_OUTPUT.PUT_LINE('Es mayor de edad');
    ELSE
        DBMS_OUTPUT.PUT_LINE('Es menor de edad');
    END IF;
END;
/

/*
Ejercicio 2: Declara una variable salario, asígnale un valor y usa IF para aplicar un aumento:
Si el salario es menor a 3000, aumenta en 20%.
Si está entre 3000 y 7000, aumenta en 10%.
Si es mayor a 7000, aumenta en 5%.
*/
DECLARE
    salary NUMBER := 8000;
    new_salary NUMBER;
BEGIN
    IF salary < 3000 THEN
        new_salary := salary * 1.2;
    ELSIF salary BETWEEN 3000 AND 7000 THEN
        new_salary := salary * 1.1;
    ELSE 
        new_salary := salary * 1.05;
    END IF;
    
    DBMS_OUTPUT.PUT_LINE('salario: ' || salary);
    DBMS_OUTPUT.PUT_LINE('Nuevo salario: ' || new_salary);
END;
/

--Ejercicio 3: Usa un LOOP para imprimir los números del 1 al 10.
DECLARE
    contador NUMBER := 1;
BEGIN
    LOOP
        DBMS_OUTPUT.PUT_LINE('Numero: ' || contador);
        contador := contador + 1;
        EXIT WHEN contador > 10;
    END LOOP;
END;
/

--Ejercicio 4: Crea un LOOP que multiplique un número n por valores de 1 a 5 y muestre los resultados como tabla de multiplicar.
DECLARE 
    n NUMBER := 9;
    multiplier NUMBER := 1;
    RESULT NUMBER;  
BEGIN
    LOOP
        RESULT := n * multiplier;
        DBMS_OUTPUT.PUT_LINE(n || ' x ' || multiplier || ' = ' || RESULT);
        multiplier := multiplier + 1;
        EXIT WHEN multiplier > 10;
    END LOOP; 
END;
/

--Ejercicio 5: Usa un FOR para recorrer los números del 10 al 1 en orden descendente e imprimirlos.
BEGIN
    FOR i IN REVERSE 10..1 LOOP
        DBMS_OUTPUT.PUT_LINE('Iteracion: ' || i);
    END LOOP;
END;
/

--Ejercicio 6: Usa un WHILE para encontrar el primer número mayor a 100 que sea divisible entre 7.
DECLARE
    n NUMBER := 101;
BEGIN
    WHILE TRUE LOOP
        IF MOD(n, 7) = 0 THEN
            DBMS_OUTPUT.PUT_LINE('El 1er numero divisible por 7 es: ' || n);
            EXIT;
        END IF;
        n := n + 1;
    END LOOP;
END;
/

/*
Ejercicio 7: Usa CASE para clasificar un número en:
“Par” si es divisible por 2.
“Impar” si no lo es.
*/
DECLARE
    n NUMBER := 7;
    label VARCHAR(10);
BEGIN
    label := CASE
        WHEN MOD(n, 2) = 0 THEN 'Par'
        ELSE 'Impar'
    END;
    DBMS_OUTPUT.PUT_LINE('El numero: ' || n || ' es ' || label);
END;
/

/*
Ejercicio 8: Obtén el job_id de un empleado desde employees y usa CASE para clasificarlo en:
"Gerente" si contiene 'MAN'.
"Técnico" si contiene 'TEC'.
"Otro" si no coincide con los anteriores.
*/












    