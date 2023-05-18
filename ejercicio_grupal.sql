-- Mostrar el apelido, el id de departamento de Los empleados
-- que en su departamento tengan una letra A
-- en el nombre de la ciudad donde esta ubicado
-- Tambien mostrar el nombre de la ciudad

SELECT 
   E.LAST_NAME AS "Apellido", 
   E.DEPARTMENT_ID AS "Departamento", 
   L.CITY AS "Ciudad"
FROM EMPLOYEES E 
     JOIN DEPARTMENTS D ON E.DEPARTMENT_ID = D.DEPARTMENT_ID
     JOIN LOCATIONS L ON D.LOCATION_ID = L.LOCATION_ID
WHERE UPPER(L.CITY) LIKE '%A%';
