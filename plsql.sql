-- EJERCICIO PL/SQL
-- E1
CREATE TABLE CLIENTES_AA AS 
       SELECT * FROM CLIENTES WHERE ROWNUM < 1;

ALTER TABLE CLIENTES_AA
      ADD CONSTRAINT clientes_aa_pk PRIMARY KEY (ID);
       
CREATE TABLE CELULARES_AA AS
       SELECT * FROM CELULARES WHERE ROWNUM < 1;

ALTER TABLE CELULARES_AA
      ADD CONSTRAINT celulares_aa_pk PRIMARY KEY (ID);

ALTER TABLE CELULARES_AA
      ADD CONSTRAINT celulares_aa_clientes_aa_fk
          FOREIGN KEY (id_cliente)
          REFERENCES clientes (id);
          
-- E2
SELECT 'MI PRIMER ' || 'EJERCICIO' FROM DUAL;

-- E3
SELECT UPPER('mi primier ejercicio en clase') FROM DUAL;

-- E4
SELECT LTRIM('    mi primer ejercicio en clase') FROM DUAL; 

-- E5
SELECT SUBSTR('mi primer ejercicio', -5) FROM DUAL;

-- E6
SELECT RTRIM('mi primer ejercicio en clase   ') FROM DUAL; 

-- E7
SELECT LOWER('Mi primier ejercicio en clase') FROM DUAL;

-- E8
SELECT REPLACE('Ya las conozco', 'a', 'o') FROM DUAL;

-- E9
SELECT TRIM('   MI PRIMER EJERCICIO EN CLASE   ') FROM DUAL;

-- E10
SELECT LENGTH('MI PRIMER EJERCICIO EN CLASE') FROM DUAL;

-- E11
SELECT CEIL(21.46) FROM DUAL;

-- E12
SELECT FLOOR(21.46) FROM DUAL;

-- E13
SELECT MOD(24, 5) FROM DUAL; 

-- E14
SELECT POWER(8, 3) FROM DUAL;

-- E15
SELECT TRUNC(142.12323412, 2) FROM DUAL;

-- E16
SELECT ADD_MONTHS(TO_DATE('01/01/2020', 'DD/MM/YYYY'), 10) FROM DUAL;

-- E17
SELECT LENGTH(REPLACE('mi primer' || 'ejercicio en clase  ' ,' ', '')) FROM DUAL;

-- E18
SELECT UPPER('mi primer' || REPLACE('   ejercicio en clase ', ' ', '')) FROM DUAL;

-- E19
BEGIN
  dbms_output.put_line('hola mundo!');
END;

-- E20
DECLARE
   saludo varchar2(20):= 'hello world';
BEGIN
  dbms_output.put_line(saludo);
END;

-- E21
DECLARE
   saludo varchar2(20):= '   hello world!   ';
BEGIN
  saludo:= TRIM(saludo);
  dbms_output.put_line(saludo);
END;
