-- EJERCICIO 1
SELECT LAST_NAME, SALARY
FROM EMPLOYEES
WHERE SALARY NOT BETWEEN 5000 AND 12000;

-- EJERCICIO 2
SELECT LAST_NAME, JOB_ID, HIRE_DATE
FROM EMPLOYEES
WHERE HIRE_DATE BETWEEN '20/02/1998' AND '01/05/1998'
ORDER BY HIRE_DATE;

-- EJERCICIO 3
SELECT E.LAST_NAME, J.JOB_TITLE
FROM EMPLOYEES E JOIN JOBS J ON E.JOB_ID = J.JOB_ID
WHERE E.MANAGER_ID IS NULL;

-- EJERCICIO 4
SELECT LAST_NAME
FROM EMPLOYEES
WHERE UPPER(LAST_NAME) LIKE '%A%' AND UPPER(LAST_NAME) LIKE '%E%';

-- EJERCICIO  5
SELECT DISTINCT J.JOB_TITLE, L.STREET_ADDRESS || ', ' || L.CITY AS "Ubicacion"
FROM EMPLOYEES E JOIN JOBS J ON E.JOB_ID = J.JOB_ID
     JOIN DEPARTMENTS D ON E.DEPARTMENT_ID = D.DEPARTMENT_ID
     JOIN LOCATIONS L ON D.LOCATION_ID = L.LOCATION_ID
WHERE D.DEPARTMENT_ID = 80;

-- EJERCICIO 6
SELECT
   E.LAST_NAME,
   E.FIRST_NAME,
   D.DEPARTMENT_NAME,
   L.LOCATION_ID,
   L.CITY
FROM EMPLOYEES E JOIN DEPARTMENTS D ON E.DEPARTMENT_ID = D.DEPARTMENT_ID
     JOIN LOCATIONS L ON D.LOCATION_ID = L.LOCATION_ID
WHERE E.COMMISSION_PCT IS NOT NULL OR E.COMMISSION_PCT > 0;

-- EJERCICIO 7
SELECT
   E.LAST_NAME,
   J.JOB_TITLE,
   L.LOCATION_ID,
   D.DEPARTMENT_NAME,
   L.CITY
FROM EMPLOYEES E JOIN JOBS J ON E.JOB_ID = J.JOB_ID
     JOIN DEPARTMENTS D ON E.DEPARTMENT_ID = D.DEPARTMENT_ID
     JOIN LOCATIONS L ON D.LOCATION_ID = L.LOCATION_ID
WHERE UPPER(L.CITY) = 'TORONTO';

-- EJERCICIO 8
SELECT
   E.LAST_NAME AS "Emp#",
   D.DEPARTMENT_ID AS "Cod Dep",
   D.DEPARTMENT_NAME AS "Descrip Dep"
FROM EMPLOYEES E LEFT JOIN DEPARTMENTS D ON E.DEPARTMENT_ID = D.DEPARTMENT_ID;

-- EJERCICIO 9
SELECT
   COUNT(DISTINCT MANAGER_ID) AS "Number of Managers"
FROM EMPLOYEES;

-- EJERCICIO 10
SELECT
   MAX(SALARY) - MIN(SALARY) AS "DIFFERENCE"
FROM EMPLOYEES;

-- EJERCICIO 11
SELECT E.MANAGER_ID, MIN(E.SALARY)
FROM EMPLOYEES E
WHERE E.MANAGER_ID IS NOT NULL
GROUP BY E.MANAGER_ID
HAVING MIN(E.SALARY) > 6000
ORDER BY MIN(E.SALARY) DESC;

-- EJERCICIO 12
SELECT DISTINCT E.DEPARTMENT_ID
FROM EMPLOYEES E
WHERE E.JOB_ID != 'ST_CLERK';

-- EJERCICIO 13
SELECT E.EMPLOYEE_ID, E.DEPARTMENT_ID
FROM EMPLOYEES E
UNION
SELECT E.EMPLOYEE_ID, D.DEPARTMENT_ID
FROM EMPLOYEES E RIGHT JOIN DEPARTMENTS D ON E.DEPARTMENT_ID = D.DEPARTMENT_ID;

-- EJERCICIO 14
SELECT E.LAST_NAME, E.HIRE_DATE
FROM EMPLOYEES E
WHERE E.DEPARTMENT_ID = (
      SELECT E1.DEPARTMENT_ID
      FROM EMPLOYEES E1
      WHERE E1.LAST_NAME = 'Zlotkey'
) AND E.LAST_NAME != 'Zlotkey';

-- EJERCICIO 15
SELECT E.EMPLOYEE_ID, E.LAST_NAME
FROM EMPLOYEES E
WHERE E.SALARY > (
      SELECT AVG(E1.SALARY)
      FROM EMPLOYEES E1
)
ORDER BY E.SALARY ASC;

-- EJERCICIO 16
SELECT E.LAST_NAME, E.DEPARTMENT_ID, E.SALARY
FROM EMPLOYEES E
WHERE (E.DEPARTMENT_ID, E.SALARY) IN (
      SELECT E1.DEPARTMENT_ID, E1.SALARY
      FROM EMPLOYEES E1
      WHERE E1.COMMISSION_PCT IS NOT NULL
            OR E1.COMMISSION_PCT > 0
);
-- o tambien
SELECT E.LAST_NAME, E.DEPARTMENT_ID, E.SALARY
FROM EMPLOYEES E
WHERE E.DEPARTMENT_ID IN (
      SELECT E1.DEPARTMENT_ID
      FROM EMPLOYEES E1
      WHERE E1.COMMISSION_PCT IS NOT NULL
            OR E1.COMMISSION_PCT > 0
) AND E.SALARY IN (
      SELECT E2.SALARY
      FROM EMPLOYEES E2
      WHERE E2.COMMISSION_PCT IS NOT NULL
            OR E2.COMMISSION_PCT > 0
);

-- EJERCICIO 17
SELECT E.*
FROM EMPLOYEES E
WHERE E.SALARY > ALL (
      SELECT E1.SALARY
      FROM EMPLOYEES E1
      WHERE E1.JOB_ID = 'SA_MAN'
)
ORDER BY E.SALARY DESC;

-- EJERCICIO 18
SELECT
   E.LAST_NAME AS "Apellido",
   E.SALARY AS "Salario",
   E.DEPARTMENT_ID AS "Id de Depto",
   ROUND(A.AVG_DEPARTMENT_SALARY, 2) AS "Salario Promedio de Depto"
FROM EMPLOYEES E INNER JOIN (
     SELECT E1.DEPARTMENT_ID, AVG(E1.SALARY) AS "AVG_DEPARTMENT_SALARY"
     FROM EMPLOYEES E1
     GROUP BY E1.DEPARTMENT_ID
) A ON E.DEPARTMENT_ID = A.DEPARTMENT_ID
WHERE E.SALARY > A.AVG_DEPARTMENT_SALARY
ORDER BY A.AVG_DEPARTMENT_SALARY;

-- EJERCICIO 19
CREATE TABLE EMP_AA (
       ID NUMBER(7),
       LAST_NAME VARCHAR2(25),
       FIRST_NAME VARCHAR2(25),
       DEPT_ID NUMBER(7)
);
COMMIT;

-- EJERCICIO 20
ALTER TABLE EMP_AA
      MODIFY LAST_NAME VARCHAR2(30);
COMMIT;

-- EJERCICIO 21
CREATE TABLE EMPLOYEES2_AA(
       ID number(6) CONSTRAINT EMPLOYEES2_AA PRIMARY KEY ,
       FIRST_NAME varchar2(20) NOT NULL,
       LAST_NAME varchar2(25) NOT NULL,
       SALARY number(8, 2),
       DEPT_ID number(6)
);
-- o
CREATE TABLE EMPLOYEES2_AA AS
       SELECT
             EMPLOYEE_ID AS "ID",
             FIRST_NAME,
             LAST_NAME,
             SALARY,
             DEPARTMENT_ID AS "DEPT_ID"
       FROM EMPLOYEES;

-- EJERCICIO 22
DROP TABLE EMP_AA;

-- EJERCICIO 23
RENAME EMPLOYEES2_AA TO EMP_AA;

-- EJERCICIO 24
ALTER TABLE EMP_AA
      DROP COLUMN FIRST_NAME
COMMIT;

-- EJERCICIO 25
ALTER TABLE EMP_AA
      ADD CONSTRAINT EMP_AA_ID_PK PRIMARY KEY (ID);

-- EJERCICIO 26
ALTER TABLE EMP_AA
      ADD COMMISSION number(4, 2) CHECK (COMMISSION > 0);

-- EJERCICIO 27
CREATE TABLE MY_EMPLOYEE_AA (
       ID number(4) CONSTRAINT MY_EMPLOYEE_AA_ID_NN NOT NULL,
       LAST_NAME varchar2(25),
       FIRST_NAME varchar2(25),
       USERID varchar2(8),
       SALARY number(9, 2)
);

-- EJERCICIO 28
INSERT INTO MY_EMPLOYEE_AA
VALUES (1, 'Patel', 'Ralph', 'Rpatel', 895);
      -- (2, 'Dancs', 'Belty', 'Bdancs', 860)
      -- (3, 'Biri', 'Ben', 'Bbiri', 1100)
      -- (4, 'Newman', 'Chad', 'Cnewman', 750)
      -- (5, 'Ropeburn', 'Audrey', 'Aropebur', 1150);

-- EJERCICIO 29
INSERT INTO MY_EMPLOYEE_AA (ID, LAST_NAME, FIRST_NAME, USERID, SALARY)
VALUES (2, 'Dancs', 'Betty', 'Bdancs', 860);

-- EJERCICIO 30
COMMIT;

-- EJERCICIO 31
UPDATE MY_EMPLOYEE_AA
      SET LAST_NAME = 'Drexler' WHERE ID = 3;

-- EJERCICIO 32
UPDATE MY_EMPLOYEE_AA
      SET SALARY = 1000 WHERE SALARY < 900;

-- EJERCICIO 33
DELETE FROM MY_EMPLOYEE_AA
      WHERE LAST_NAME = 'Dancs' AND FIRST_NAME = 'Betty'

-- EJERCICIO 34
COMMIT;

-- EJERCICIO 35
SELECT
   JOB_ID,
   DECODE(JOB_ID,
             'AD_PRES', 'A',
             'ST_MAN', 'B',
             'IT_PROG', 'C',
             'SA_REP', 'D',
             'ST_CLERK', 'F',
             '0'
   )
FROM EMPLOYEES;

-- EJERCICIO 36
SELECT
   JOB_ID,
   CASE JOB_ID
      WHEN 'AD_PRES' THEN 'A'
      WHEN 'ST_MAN' THEN 'B'
      WHEN 'IT_PROG' THEN 'C'
      WHEN 'SA_REP' THEN 'D'
      WHEN 'ST_CLERK' THEN 'F'
      ELSE '0'
   END
FROM EMPLOYEES;

-- EJERCICIO 37
SELECT
      EMPLOYEE_ID,
      LAST_NAME,
      SALARY,
      ROUND(SALARY * 1.15, 0) AS "New Salary"
FROM EMPLOYEES;

--EJERCICIO 38
SELECT
      LAST_NAME,
      NVL(COMMISSION_PCT, 'No Commission') AS "COMM"
FROM EMPLOYEES;

-- EJERCICIO 39
SELECT
      ROUND(MAX(SALARY), 0) AS "Maximum",
      ROUND(MIN(SALARY), 0) AS "Minimum",
      ROUND(SUM(SALARY), 0) AS "Sum",
      ROUND(AVG(SALARY), 0) AS "Average"
FROM EMPLOYEES;

--EJERCICIO 40
SELECT
      JOB_ID,
      ROUND(MAX(SALARY), 0) AS "Maximum",
      ROUND(MIN(SALARY), 0) AS "Minimum",
      ROUND(SUM(SALARY), 0) AS "Sum",
      ROUND(AVG(SALARY), 0) AS "Average"
FROM EMPLOYEES
GROUP BY JOB_ID;
