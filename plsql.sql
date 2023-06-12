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
  v_sum := v_num1 + v_num2;

  if v_sum < 51 then
    dbms_output.put_line('Suma entre 2 y 50');
  elsif v_sum < 101 then
    dbms_output.put_line('Suma entre 51 y 100');
  elsif v_sum < 201 then
    dbms_output.put_line('Suma entre 101 y 200');
  else
    dbms_output.put_line('No se contrempla resultado');
  end if;
END;

-- E31
DECLARE
  v_num number := &num1;
  v_str varchar2(20);
BEGIN
  case
    when v_num = 1 then v_str := 'aa';
    when v_num = 2 then v_str := 'bb';
    when v_num = 3 then v_str := 'cc';
    when v_num = 4 then v_str := 'dd';
  end case;
  
  dbms_output.put_line(v_str);
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

-- E33
DECLARE
   v_csam number;
   v_cmot number;
   v_fecha date;
BEGIN
   SELECT COUNT(*)
   INTO v_csam
   FROM CELULARES_AA
   WHERE LOWER(MARCA) = 'samsung';
   
   SELECT COUNT(*)
   INTO v_cmot
   FROM CELULARES_AA
   WHERE LOWER(MARCA) = 'motorola';
   
   if v_csam > v_cmot then
     SELECT MIN(FECHA_COMPRA)
     INTO v_fecha
     FROM CELULARES_AA
     WHERE LOWER(MARCA) = 'samsung';
   else
     SELECT MIN(FECHA_COMPRA)
     INTO v_fecha
     FROM CELULARES_AA
     WHERE LOWER(MARCA) = 'motorola';
   end if;
   
   dbms_output.put_line(v_fecha);
END;

-- E34
DECLARE
   v_cliente CLIENTES_AA%ROWTYPE;
BEGIN
  SELECT *
  INTO v_cliente
  FROM CLIENTES_AA C
  WHERE C.SUELDO_NETO = (
        SELECT MAX(C1.SUELDO_NETO)
        FROM CLIENTES_AA C1
  );
  
  CASE
    when LOWER(v_cliente.provincia) = 'cordoba' then
      dbms_output.put_line(v_cliente.nombre);
    when LOWER(v_cliente.provincia) = 'tucuman' then
      dbms_output.put_line(v_cliente.direccion);
    when LOWER(v_cliente.provincia) = 'jujuy' then
      dbms_output.put_line(v_cliente.apellido);
    when LOWER(v_cliente.provincia) = 'chaco' then
      dbms_output.put_line(v_cliente.fecha_nac);
    else 
      dbms_output.put_line(v_cliente.dni);
  END CASE;

END;

-- E35
DECLARE
   v_cod number := &num1;
   v_nom varchar2(40);
BEGIN
  SELECT C.NOMBRE
  INTO v_nom
  FROM CLIENTES_AA C
  WHERE C.ID = v_cod;
  
  dbms_output.put_line(v_nom);
END;

-- E36
DECLARE
   v_cod number := &num1;
   v_cli CLIENTES_AA%ROWTYPE;
BEGIN
  SELECT *
  INTO v_cli
  FROM CLIENTES_AA C
  WHERE C.ID = v_cod;
  
  dbms_output.put_line(v_cli.nombre);
  dbms_output.put_line(v_cli.apellido);
  dbms_output.put_line(v_cli.dni);
END;

-- E37
DECLARE
   v_cod number := &num1;
   v_cant_cel number;
   v_cel CELULAR_AA%ROWTYPE;
BEGIN
  SELECT COUNT(*)
  INTO v_cant_cel
  FROM CELULARES_AA
  WHERE ID_CLIENTE = v_cod;
  
  if v_cant_cel = 1 then
    SELECT *
    INTO v_cel
    FROM CELULARES_AA
    WHERE ID_CLIENTE = v_cod;
    
    dbms_output.put_line('Id: ' || TO_CHAR(v_cel.id));
    dbms_output.put_line('Cod. area: ' || v_cel.cod_area);
    dbms_output.put_line('Numero: ' || TO_CHAR(v_cel.numero));
    dbms_output.put_line('Marca: ' || v_cel.marca);
    dbms_output.put_line('Id cliente: ' || TO_CHAR(v_cel));
    
  elsif v_cant_cel > 1 then
    dbms_output.put_line('El cliente no tiene numeros registrados');

  else
    dbms_output.put_line('El cliente tiene varios numeros registrados');
    
END;
  
