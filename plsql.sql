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
   v_cel CELULARES_AA%ROWTYPE;
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
    dbms_output.put_line('Id cliente: ' || v_cel.id_cliente);

  elsif v_cant_cel > 1 then
    dbms_output.put_line('El cliente no tiene numeros registrados');
  else
    dbms_output.put_line('El cliente tiene varios numeros registrados');
  end if;

END;

-- E38
DECLARE
  v_cont number := 1;
BEGIN
  while v_cont < 51 loop
    dbms_output.put_line(v_cont);
    v_cont := v_cont + 1;
  end loop;
END;

-- E39
BEGIN
  for i in 1..50 loop
    dbms_output.put_line(i);
  end loop;
END;

-- E40
DECLARE
  v_cont number := 1;
BEGIN
  loop
    dbms_output.put_line(v_cont);
    v_cont := v_cont + 1;
    exit when v_cont > 50;
  end loop;
END;

-- E41
DECLARE
  v_cont number := 0;
BEGIN
  for i in 1..100 loop
    if mod(i, 3) = 0 then
      v_cont := v_cont + 1;
      dbms_output.put_line(i);
    end if;
  end loop;
  dbms_output.put_line('Hay ' || v_cont || ' multiplos de 3 entre 1 y 100');
END;

-- E42
DECLARE
  cursor c_cli is
    SELECT *
    FROM CLIENTES_AA
    WHERE ROWNUM <= 10;
BEGIN
  for cli in c_cli loop
    if mod(cli.id, 2) = 0 then
      dbms_output.put_line('Id: ' || cli.id);
      dbms_output.put_line('Nombre: ' || cli.nombre);
      dbms_output.put_line('Apellido: ' || cli.apellido);
      dbms_output.put_line('');
    end if;
  end loop;
END;

-- E43
DECLARE
  v_sueldo_prom number;
  v_cli clientes_aa%rowtype;
BEGIN
  SELECT AVG(sueldo_neto)
  INTO v_sueldo_prom
  FROM CLIENTES_AA;

  SELECT *
  INTO v_cli
  FROM CLIENTES_AA
  WHERE ID = 8;

  if v_sueldo_prom < v_cli.sueldo_neto then
    for i in 9..11 loop
      SELECT *
      INTO v_cli
      FROM CLIENTES_AA
      WHERE ID = i;

      dbms_output.put_line('Id: ' || v_cli.id);
      dbms_output.put_line('Nombre: ' || v_cli.nombre);
      dbms_output.put_line('Apellido: ' || v_cli.apellido);
      dbms_output.put_line('');
    end loop;
  else
    for i in 7..5 loop
      SELECT *
      INTO v_cli
      FROM CLIENTES_AA
      WHERE ID = i;

      dbms_output.put_line('Id: ' || v_cli.id);
      dbms_output.put_line('Nombre: ' || v_cli.nombre);
      dbms_output.put_line('Apellido: ' || v_cli.apellido);
      dbms_output.put_line('');
    end loop;
  end if;
  dbms_output.put_line('Sueldo prom: ' || round(v_sueldo_prom, 2));
END;

-- E44
DECLARE
  v_word varchar(30) := &word;
  v_letter varchar(1);
  v_cont_v number := 0;
  v_cont_c number := 0;
BEGIN
  for i in 1..length(v_word) loop
    v_letter := substr(v_word, i, 1);
    if lower(v_letter) in ('a', 'e', 'i', 'o', 'u') then
      v_cont_v := v_cont_v + 1;
    else
      v_cont_c := v_cont_c + 1;
    end if;
  end loop;

  dbms_output.put_line('Cant de vocales: ' || v_cont_v);
  dbms_output.put_line('Cant de consonantes: ' || v_cont_c);
END;

-- E45
DECLARE
  v_num number := 20;
BEGIN
  dbms_output.put_line(v_num);
  v_num := v_num + 1;
  dbms_output.put_line(v_num);
  v_num := v_num + 1;
  dbms_output.put_line(v_num);
  v_num := v_num + 1;
  dbms_output.put_line(v_num);
  v_num := v_num + 1;
  dbms_output.put_line(v_num);
  v_num := v_num + 1;
  dbms_output.put_line(v_num);
  v_num := v_num + 1;
  dbms_output.put_line(v_num);
  v_num := v_num + 1;
  dbms_output.put_line(v_num);
  v_num := v_num + 1;
  dbms_output.put_line(v_num);
  v_num := v_num + 1;
  dbms_output.put_line(v_num);
  v_num := v_num + 1;
  dbms_output.put_line(v_num);
END;

-- E46
DECLARE
   v_idcli number := &idcli;
   v_cli CLIENTES_AA%ROWTYPE;
BEGIN
  SELECT *
  INTO v_cli
  FROM CLIENTES_AA
  WHERE ID = v_idcli;

  dbms_output.put_line('Nombre: ' || v_cli.nombre);
  dbms_output.put_line('Apellido: ' || v_cli.apellido);
END;

-- E47
DECLARE
   v_idcel number := &idcel;
   v_cel CELULARES_AA%ROWTYPE;
BEGIN
  SELECT *
  INTO v_cel
  FROM CELULARES_AA
  WHERE ID = v_idcel;

  dbms_output.put_line('Carac: ' || v_cel.cod_area);
  dbms_output.put_line('Numero: ' || v_cel.numero);
END;

-- E48
DECLARE
   v_cod number := &cod;
   v_num number := &nume;
   v_cli CLIENTES_AA%ROWTYPE;
BEGIN
  SELECT CLI.*
  INTO v_cli
  FROM CELULARES_AA CEL
    JOIN CLIENTES_AA CLI ON CEL.ID_CLIENTE = CLI.ID
  WHERE CEL.cod_area = v_cod
    AND CEL.numero = v_num;

  dbms_output.put_line('Nombre: ' || v_cli.nombre);
  dbms_output.put_line('Apellido: ' || v_cli.apellido);
END;

-- E49
DECLARE
   CURSOR c_cli IS
     SELECT *
     FROM CLIENTES_AA
     WHERE SUELDO_NETO > 40000;
BEGIN
  FOR v_cli IN c_cli LOOP
    dbms_output.put_line('Nombre: ' || v_cli.nombre);
    dbms_output.put_line('Apellido: ' || v_cli.apellido);
  END LOOP;
END;

-- E50
DECLARE
   CURSOR c_prov IS
     SELECT DISTINCT provincia
     FROM CLIENTES_AA;
   CURSOR c_cli(p_prov IN VARCHAR2) IS
     SELECT *
     FROM CLIENTES_AA
     WHERE PROVINCIA = p_prov;
BEGIN
  FOR prov IN c_prov LOOP
    dbms_output.put_line(prov.provincia);
    FOR cli IN c_cli(prov.provincia) LOOP
      dbms_output.put_line('  Nombre: ' || cli.nombre);
      dbms_output.put_line('  Apellido: ' || cli.apellido);
    END LOOP;
  END LOOP;
END;

-- E51
DECLARE
   CURSOR c_cli_cel IS
     SELECT CLI.ID, COUNT(CEL.ID)
     FROM CLIENTES_AA CLI JOIN CELULARES_AA CEL
       ON CLI.ID = CEL.ID_CLIENTE
     GROUP BY CLI.ID
     HAVING COUNT(CEL.ID) > 1;

   v_cli CLIENTES_AA%ROWTYPE;
BEGIN
  FOR cli_id IN c_cli_cel LOOP
    SELECT *
    INTO v_cli
    FROM CLIENTES_AA C
    WHERE C.ID = cli_id.id;

    dbms_output.put_line('  Nombre: ' || v_cli.nombre);
    dbms_output.put_line('  Apellido: ' || v_cli.apellido);
    dbms_output.put_line('');

  END LOOP;
END;

-- E52
DECLARE
  cursor c_cli is
    SELECT *
    FROM CLIENTES_AA;
  v_cant_cel number;
  v_cli_encontrado boolean := false;
  v_utl_id number;
BEGIN
  for cli in c_cli loop
    if not v_cli_encontrado then
      SELECT COUNT(*)
      INTO v_cant_cel
      FROM CELULARES_AA
      WHERE ID_CLIENTE = cli.id;

      if v_cant_cel = 0 then
        SELECT MAX(ID)
        INTO v_utl_id
        FROM CELULARES_AA;

        INSERT INTO CELULARES_AA
          (id,cod_area,NUMERO,MARCA,FECHA_COMPRA,ID_CLIENTE)
        VALUES (v_utl_id + 1, 351, 4657642, 'Motorola', '01-04-2020', cli.id);

        dbms_output.put_line('Celular agregado para cliente ' || cli.id);

        v_cli_encontrado := true;
      end if;

    end if;
  end loop;
END;

-- E53
DECLARE
  CURSOR c_cli is
    SELECT *
    FROM CLIENTES_AA
    WHERE SUELDO_NETO > 80000;
BEGIN
  for cli in c_cli loop
    UPDATE CLIENTES_AA
    SET SUELDO_NETO = SUELDO_NETO - 100
    WHERE CURRENT OF c_cli;

    dbms_output.put_line('Cliente ' || cli.id || ' actualizado');
  end loop;
END;

-- E54
DECLARE
  cursor c_cli is
    SELECT *
    FROM CLIENTES_AA;

  cursor c_cel(cli_id number) is
    SELECT *
    FROM CELULARES_AA
    WHERE ID_CLIENTE = cli_id;

  v_cant_cel number;
BEGIN
  for cli in c_cli loop
    SELECT COUNT(*)
    INTO v_cant_cel
    FROM CELULARES_AA
    WHERE ID_CLIENTE = cli.id;

    if v_cant_cel > 0 then
      dbms_output.put_line('');
      dbms_output.put_line('');
      dbms_output.put_line('Nombre: ' || cli.nombre);
      dbms_output.put_line('Apellido: ' || cli.apellido);
      dbms_output.put_line('Tiene ' || v_cant_cel || ' celulares:');

      for cel in c_cel(cli.id) loop
        dbms_output.put_line('  Cod. area: ' || cel.cod_area);
        dbms_output.put_line('  Numero: ' || cel.numero);
        dbms_output.put_line('  Marca: ' || cel.marca);
        dbms_output.put_line('  Fecha compra: ' || cel.fecha_compra);
      end loop;
    end if;
  end loop;
END;

-- E55
DECLARE
  cursor c_cli is
    SELECT *
    FROM CLIENTES_AA;

BEGIN
  for cli in c_cli loop
    if lower(cli.provincia) = 'buenos aires' then
      if cli.fecha_nac > to_date('01/01/2000', 'DD/MM/YYYY') then
        dbms_output.put_line('');
        dbms_output.put_line('Nombre: ' || cli.nombre);
        dbms_output.put_line('Apellido: ' || cli.apellido);
      else
        dbms_output.put_line('');        
        dbms_output.put_line(cli.nombre|| ' '|| cli.apellido || 'de Buenos Aires pero antes del 01/01/2000');
      end if;
    else
      dbms_output.put_line('');    
      dbms_output.put_line(cli.nombre|| ' '|| cli.apellido || ' no es de Buenos Aires');
    end if;
  end loop;
END;
        
-- E56
DECLARE
   v_cli CLIENTES_AA%ROWTYPE;
BEGIN
  SELECT *
  INTO v_cli
  FROM CLIENTES_AA
  WHERE UPPER(PROVINCIA) = 'FORMOSA';

  dbms_output.put_line(v_cli.nombre || v_cli.apellido);

EXCEPTION
  WHEN NO_DATA_FOUND THEN
    dbms_output.put_line('No se encontraron datos');
END;

-- E57
DECLARE
   v_cel CELULARES_AA%ROWTYPE;
BEGIN
  SELECT *
  INTO v_cel
  FROM CELULARES_AA
  WHERE COD_AREA = 351;

  dbms_output.put_line(v_cel.numero);
EXCEPTION
  WHEN NO_DATA_FOUND THEN
    dbms_output.put_line('No se encontraron datos');
  WHEN TOO_MANY_ROWS THEN
    dbms_output.put_line('La consulate devuelve demasiadas columnas');
END;

-- E58
DECLARE
   v_div number;
BEGIN
  v_div := 1/0;
  dbms_output.put_line('El resultado es: ' || TO_CHAR(v_div));
EXCEPTION
  WHEN ZERO_DIVIDE THEN
    dbms_output.put_line('No se puede dividir por cero');
END;

-- E59
DECLARE
   CURSOR c_cli IS
     SELECT *
     FROM CLIENTES_AA;
   SALDO_INSUFICIENTE EXCEPTION;
BEGIN
  FOR cli IN c_cli LOOP
    if cli.sueldo_neto > 25000 then
      dbms_output.put_line('Tiene suficiente dinero para celu nuevo');
    else
      dbms_output.put_line('El cliente ' || cli.nombre || ' ' || cli.apellido || ' no tiene salario suficiente');
      RAISE SALDO_INSUFICIENTE;
    end if;
  END LOOP;
EXCEPTION
  WHEN SALDO_INSUFICIENTE THEN
    dbms_output.put_line('EL SALDO ES INSUFICIENTE');
END;

-- E60
DECLARE
   CURSOR c_cli IS
     SELECT cli.id, cli.nombre, cli.apellido, count(cel.id) AS cantidad_cel
     FROM CLIENTES_AA cli
       JOIN CELULARES_AA cel ON cli.id = cel.id_cliente
     GROUP BY cli.id, cli.nombre, cli.apellido;
   VARIOS_CELULARES EXCEPTION;
BEGIN
  for cli in c_cli loop
    if cli.cantidad_cel > 1 then
      dbms_output.put_line('El cliente ' || cli.nombre || ' ' || cli.apellido || ' tiene varios celulares');
      RAISE VARIOS_CELULARES;
    end if;
  end loop;
EXCEPTION
  WHEN VARIOS_CELULARES THEN
    dbms_output.put_line('Contacte al cliente');
END;

-- E61
DECLARE
   CURSOR c_cli is
     SELECT * FROM CLIENTES_AA;

   OFRECER_CEL EXCEPTION;
   DEJAR_DE_OFRECER_CEL EXCEPTION;
   CANDIDATO_ENCONTRADO EXCEPTION;
BEGIN
  for cli in c_cli loop
    CASE
      WHEN cli.sueldo_neto > 80000 then RAISE OFRECER_CEL;
      WHEN cli.sueldo_neto > 25000 then RAISE CANDIDATO_ENCONTRADO;
      ELSE RAISE DEJAR_DE_OFRECER_CEL;
    END CASE;
  end loop;
EXCEPTION
  WHEN OFRECER_CEL THEN
    dbms_output.put_line('Ofrecer celular a cliente');
  WHEN DEJAR_DE_OFRECER_CEL THEN
    dbms_output.put_line('No ofrecer mas celulares a cliente');
  WHEN CANDIDATO_ENCONTRADO THEN
    dbms_output.put_line('Posible candidato');
END;

-- E62
CREATE OR REPLACE FUNCTION valor_max_aa(v_num1 number, v_num2 number)
       return number IS
BEGIN
  if v_num1 > v_num2 then
    return v_num1;
  else
    return v_num2;
  end if;

END;

DECLARE
    v_num1 number := &num1;
    v_num2 number := &num2;
    v_res number;
BEGIN
  if v_num1 = v_num2 then
    dbms_output.put_line('Los numeros ingresados son iguales');
  else
    v_res := valor_max_aa(v_num1, v_num2);
    dbms_output.put_line('El numero mayor es: ' || to_char(v_res));
  end if;
END;

-- E63
CREATE OR REPLACE PROCEDURE fecha_actual_aa IS
BEGIN
  dbms_output.put_line(SYSDATE);
END;

BEGIN
  fecha_actual_aa;
END;

-- E64
CREATE OR REPLACE FUNCTION cant_cel_aa(v_cod number) return number IS
       v_res number;
BEGIN
  SELECT COUNT(*) INTO v_res
  FROM CELULARES_AA
  WHERE cod_area = v_cod;

  return v_res;
END;

DECLARE
  v_cod number := &cod;
BEGIN
  dbms_output.put_line('Cant de celulares: ' || to_char(cant_cel_aa(v_cod)));
END;

-- E65
CREATE OR REPLACE
  FUNCTION obtener_estado_alumno(v_nota number) return varchar2 IS
BEGIN
  if v_nota < 4 then
    return 'El alumno desprobo';
  elsif v_nota < 8 then
    return 'El alumno regularizo';
  else
    return 'El alumno promociono';
  end if;
END;

DECLARE
  v_nota number := &nota;
  v_res varchar2(100);
BEGIN
  v_res := obtener_estado_alumno(v_nota);
  dbms_output.put_line('Estado: ' || v_res);
END;

-- E66
CREATE OR REPLACE
  FUNCTION sum_sueldo_prov_aa(v_prov varchar2) return number IS
    v_res number;
BEGIN
  SELECT SUM(sueldo_neto) INTO v_res
  FROM CLIENTES_AA
  WHERE UPPER(PROVINCIA) = UPPER(v_prov);

  if v_res:
    return v_res;
  else
    return -1;
END;

DECLARE
  v_prov varchar2(50) := &prov;
  v_sueldo number;
BEGIN
  v_sueldo := sum_sueldo_prov_aa(v_prov);
  dbms_output.put_line('Sueldo de ' || v_prov || ': '|| to_char(v_sueldo));
END;

-- E67
CREATE OR REPLACE
  function cant_cel(cli_id number) return number is
  v_cant_cel number;
BEGIN
  SELECT COUNT(*)
  INTO v_cant_cel
  FROM CELULARES_AA
  WHERE ID_CLIENTE = cli_id;
  
  if v_cant_cel > 0 then
    return v_cant_cel;
  else
    return -1;
  end if;
END;

DECLARE
  v_cli_id number := &cli_id;
BEGIN
  dbms_output.put_line('La cantidad de celulares del cliente ' || v_cli_id || ' es ' || cant_cel(v_cli_id));
END;
    
-- E68
CREATE OR REPLACE
  function max_cel_cli() return varchar2(40) is
    apellido varchar2(40);
    max_cel number;
BEGIN
  
    


-- E79
CREATE SEQUENCE SEC_CLIENTES_AA
START WITH 21
INCREMENT BY 1
MAXVALUE 999999;

-- E80
INSERT INTO CLIENTES_AA VALUES (
  SEC_CLIENTES_AA.NEXTVAL,
  'Agustin',
  'Gonzalez',
  43245562,
  20000,
  'San Martin 3100',
  '20-10-2000',
  'Buenos Aires'
);

SELECT * FROM CLIENTES_AA ORDER BY ID DESC;

-- E81
SELECT * FROM ALL_SEQUENCES ORDER BY SEQUENCE_NAME;

-- E82
DECLARE
    v_nombre varchar(30) := &nombre;
    v_apellido varchar(30) := &apellido;
    v_dni number := &dni;
    v_sueldo number := &sueldo;
    v_direccion varchar(40) := &direccion;
    v_fecha_nac varchar(20) := &fecha_nac;
    v_provincia varchar(30) := &provincia;
BEGIN
  INSERT INTO CLIENTES_AA VALUES (
    SEC_CLIENTES_AA.NEXTVAL,
    v_nombre,
    v_apellido,
    v_dni,
    v_sueldo,
    v_direccion,
    v_fecha_nac,
    v_provincia
  );
END;

-- E83


