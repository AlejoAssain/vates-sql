-- E1
CREATE TABLE Notebook_aa (
  Id number
  ,  Nro_serie number
  ,  Marca varchar2(50)
  ,  Fecha_compra date
  , id_cliente number(3)
  ,  CONSTRAINT pk_notebook_aa primary key (id)
  ,  CONSTRAINT fk_id_cliente_aa FOREIGN KEY (id_cliente) REFERENCES clientes_aa (id)
);

CREATE SEQUENCE SEC_NOTEBOOK_AA;

CREATE OR REPLACE
  procedure crear_notebook_aa(
    p_nro_serie notebook_aa.nro_serie%type,
    p_marca notebook_aa.marca%type,
    p_fecha_compra notebook_aa.fecha_compra%type,
    p_id_cliente notebook_aa.id_cliente%type
  ) IS
BEGIN
  INSERT INTO NOTEBOOK_AA VALUES
    (sec_notebook_aa.nextval,p_nro_serie,p_marca,p_fecha_compra,p_id_cliente);
END;

BEGIN
  crear_notebook_aa(4876,'Lenovo',to_date('01/01/2018','DD/MM/YYYY'),1);
  crear_notebook_aa(5468,'Dell',to_date('04/10/2016','DD/MM/YYYY'),2);
  crear_notebook_aa(8476,'Acer',to_date('14/08/2014','DD/MM/YYYY'),1);
  crear_notebook_aa(8764,'Apple',to_date('22/09/2012','DD/MM/YYYY'),3);
  crear_notebook_aa(4654,'Lenovo',to_date('12/12/2020','DD/MM/YYYY'),4);
  crear_notebook_aa(4678,'Lenovo',to_date('24/05/2021','DD/MM/YYYY'),2);
END;

-- E2
DECLARE
  CURSOR c_notebooks(p_fecha_compra notebook_aa.fecha_compra%type) is
    SELECT *
    FROM NOTEBOOK_AA
    WHERE fecha_compra < p_fecha_compra;
  
  v_fecha_compra varchar2(20) := &fecha;
  v_cant_note number;
  NO_HAY_NOTEBOOKS_ANTES EXCEPTION;
BEGIN
  SELECT COUNT(*)
  INTO v_cant_note
  FROM NOTEBOOK_AA
  WHERE fecha_compra < v_fecha_compra;
  
  if v_cant_note > 0 then
    for note in c_notebooks(to_date(v_fecha_compra, 'DD/MM/YYYY')) loop
      dbms_output.put_line('Id           : ' || note.id);
      dbms_output.put_line('Nro. Serie   : ' || note.nro_serie);
      dbms_output.put_line('Marca        : ' || note.marca);
      dbms_output.put_line('Fecha compra : ' || note.fecha_compra);
      dbms_output.put_line('Id cliente   : ' || note.id_cliente);
      dbms_output.put_line('');
    end loop;
  else
    RAISE NO_HAY_NOTEBOOKS_ANTES;
  end if;
EXCEPTION
  WHEN NO_HAY_NOTEBOOKS_ANTES THEN 
    dbms_output.put_line('No hay notebooks compradas con fecha menor a la ingresada');
END;

-- E3
CREATE OR REPLACE
  procedure mostrar_clientes_note_aa(p_opcion number) IS
    
  CURSOR c_cli_con_note is
    SELECT DISTINCT CLI.*
    FROM CLIENTES_AA CLI 
      JOIN NOTEBOOK_AA NOTE ON CLI.ID = NOTE.ID_CLIENTE;
  
  CURSOR c_cli_sin_note is
    SELECT *
    FROM CLIENTES_AA CLI
    WHERE CLI.ID NOT IN (
      SELECT CLI1.ID
      FROM CLIENTES_AA CLI1
        JOIN NOTEBOOK_AA NOTE1 ON CLI1.ID = NOTE1.ID_CLIENTE
    );
BEGIN
  -- opcion 1 para mostrar clientes que tienen notebooks
  if p_opcion = 0 then
    for cli in c_cli_con_note loop
      dbms_output.put_line('Id:       ', cli.id);
      dbms_output.put_line('Nombre:   ', cli.nombre);
      dbms_output.put_line('Apellido: ', cli.apellido);
      dbms_output.put_line('');
    end loop;
    
  -- opcion 2 para mostrar clientes que no tienen notebooks
  elsif p_opcion = 1 then
    for cli in c_cli_sin_note loop
      dbms_output.put_line('Id:       ', cli.id);
      dbms_output.put_line('Nombre:   ', cli.nombre);
      dbms_output.put_line('Apellido: ', cli.apellido);
      dbms_output.put_line('');
    end loop;
   
  -- otro numero, se muestra que la opcion fue incorrecta
  else
    dbms_output.put_line('Opcion incorrecta...');
  end if;
END;

DECLARE
  v_opcion number := &opcion;
BEGIN
  mostrar_clientes_note_aa(v_opcion);
END;

-- E5
CREATE OR REPLACE PACKAGE cli_note_package_aa AS 
  FUNCTION cant_notebookxcli(p_cli_id clientes_aa.id%type) return number;
END cli_note_package_aa;

CREATE OR REPLACE PACKAGE BODY cli_note_package_aa AS
  function cant_notebookxcli(p_cli_id clientes_aa.id%type) return number IS
    v_cant_note number;
  BEGIN
    SELECT COUNT(*)
    INTO v_cant_note
    FROM NOTEBOOK_AA
    WHERE ID_CLIENTE = p_cli_id;
    
    return v_cant_note;
  END cant_notebookxcli;
END cli_note_package_aa;

DECLARE
  v_cli_id number := &cli_id;
  v_cli CLIENTES_AA%ROWTYPE;
BEGIN
  SELECT *
  INTO v_cli
  FROM CLIENTES_AA
  WHERE ID = v_cli_id;
  
  dbms_output.put_line('Id       : ' || v_cli.id);
  dbms_output.put_line('Nombre   : ' || v_cli.nombre);
  dbms_output.put_line('Apellido : ' || v_cli.apellido);  
  dbms_output.put_line('Tiene ' || cli_note_package_aa.cant_notebookxcli(v_cli_id) || ' notebooks');
EXCEPTION
  WHEN NO_DATA_FOUND THEN
    dbms_output.put_line('No existe el cliente con el id ingresado');
END;
