-- EJERCICIO PL/SQL
-- E1
CREATE TABLE CLIENTES_AA AS
       SELECT * FROM CLIENTES_BU;

ALTER TABLE CLIENTES_AA
      ADD CONSTRAINT clientes_aa_pk PRIMARY KEY (ID);

CREATE TABLE CELULARES_AA AS
       SELECT * FROM CELULARES_BU;

ALTER TABLE CELULARES_AA
      ADD CONSTRAINT celulares_aa_pk PRIMARY KEY (ID);

ALTER TABLE CELULARES_AA
      ADD CONSTRAINT celulares_aa_clientes_aa_fk
          FOREIGN KEY (id_cliente)
          REFERENCES CLIENTES_AA (id);

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

-- E22
DECLARE
   v_numerica number := &num;
BEGIN
   dbms_output.put_line(v_numerica);
END;

-- E23
DECLARE
   v_p1 varchar2(20) := 'palabra 1';
   v_p2 varchar2(20) := 'palabra 2';
BEGIN
  dbms_output.put_line(v_p1 || v_p2);
END;

-- E24
DECLARE
   v_num1 number := &num1;
   v_num2 number := &num2;
BEGIN
  dbms_output.put_line(v_num1 + v_num2);
END;

-- E25
DECLARE
   v_num1 number := &num1;
BEGIN
  FOR i IN (v_num1 + 1)..(v_num1 + 11) LOOP
    dbms_output.put_line(i);
  END LOOP;
END;

-- E26
DECLARE
   contador number;
BEGIN
  contador := 1;
  FOR i IN 1..10 LOOP
    FOR j IN 1..(i - 1) LOOP
      contador := contador + j;
    END LOOP;
    dbms_output.put_line(contador);
  END LOOP;
END;

-- E27
DECLARE
  v_num number := 20;
BEGIN
  if v_num > 10 then
    dbms_output.put_line('El numero es mayor a 10');
  else
    dbms_output.put_line('El numero no es mayor a 10');
  end if;
END;

-- E28
DECLARE
  v_num number := &num1
BEGIN
  if v_num > 50 then
    dbms_output.put_line('El valor es: ' || v_num);
  else
    dbms_output.put_line('El valor es menor a 50');
  end if;
END;

-- E29
DECLARE
  v_num number := &num1;
BEGIN
  if v_num < 0 then
    dbms_output.put_line('Valor anterior: ' || TO_CHAR(v_num));
    dbms_output.put_line('Valor actual: ' || TO_CHAR(ABS(v_num)));
  else
    dbms_output.put_line('Valor: ' || TO_CHAR(v_num));
  end if;
END;

-- E30
DECLARE
  v_num1 number := &num1;
  v_num2 number := &num2;
  v_sum number;
BEGIN
  v_sum = v_num1 + v_num2;

  if v_sum < 51
END;

-- E32
DECLARE
   v_cliente CLIENTES_AA%ROWTYPE;
BEGIN
  SELECT *
  INTO v_cliente
  FROM CLIENTES_AA C
  WHERE C.PROVINCIA = 'Chaco';

  if v_cliente.sueldo_neto > 50000 then
    v_cliente.sueldo_neto := v_cliente.sueldo_neto + 2;
  elsif v_cliente.sueldo_neto > 30000 then
    v_cliente.sueldo_neto := v_cliente.sueldo_neto + 10;
  else
    v_cliente.sueldo_neto := v_cliente.sueldo_neto + 14;

  end if;

  dbms_output.put_line(v_cliente.nombre);
  dbms_output.put_line(v_cliente.apellido);
  dbms_output.put_line(v_cliente.dni);
  dbms_output.put_line(v_cliente.sueldo_neto);
  dbms_output.put_line(v_cliente.provincia);
END;


