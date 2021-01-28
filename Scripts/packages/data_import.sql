CREATE TABLE tab1 (
  id        NUMBER,
  clob_data CLOB
)tablespace ts_diploms; -----------таблица для заполнения из файлов

select * from tab1;

create or replace package body data_import as
------------------------------------
------------------------------------
  procedure ImportSupervisors (fname Supervisors.supervisor%type)
  is
    ---для работы с файлом
    l_bfile  BFILE;
    l_clob   CLOB;
    l_dest_offset   INTEGER := 1;
    l_src_offset    INTEGER := 1;
    l_bfile_csid    NUMBER  := 0;
    l_lang_context  INTEGER := 0;
    l_warning       INTEGER := 0;
    ---для работы с данными
    xml clob;
    type curtype is ref cursor;
    cur curtype;
    sup_row Supervisors%rowtype;
  begin
    --заполнение таблицы данными из файла
    INSERT INTO tab1 (id, clob_data)
    VALUES (1, empty_clob())  --заполнение пустой строкой
    RETURN clob_data INTO l_clob;
    
    l_bfile := BFILENAME('EXPORT_DIR', fname);  --дескриптор файла
    DBMS_LOB.fileopen(l_bfile, DBMS_LOB.file_readonly); --открываем файл
    DBMS_LOB.loadclobfromfile ( --считываем данные в таблицу
    dest_lob      => l_clob,
    src_bfile     => l_bfile,
    amount        => DBMS_LOB.lobmaxsize,
    dest_offset   => l_dest_offset,
    src_offset    => l_src_offset,
    bfile_csid    => l_bfile_csid ,
    lang_context  => l_lang_context,
    warning       => l_warning);
    DBMS_LOB.fileclose(l_bfile);  --закрываем файл
    COMMIT;
    --работа с таблицей
    select clob_data into xml from tab1;
    open cur for select *
                FROM XMLTABLE('/Supervisors/Supervisor'  
                PASSING   
                xmltype( to_char(xml))
                COLUMNS   
                        supervisor  varchar2(50)    PATH './supervisor',  
                        email varchar2(100)    PATH './email');  
    fetch cur into sup_row;
    while cur%found loop
      supervisors_pack.addsupervisor(sup_row.supervisor, sup_row.email);
    fetch cur into sup_row;
    end loop;
    close cur;
    --truncate table tab1;
    EXECUTE IMMEDIATE 'TRUNCATE TABLE tab1';
    commit;
    exception
    when others then dbms_output.put_line(sqlerrm);
  end ImportSupervisors;
---------------------------------------
---------------------------------------
end data_import;

begin
  data_import.ImportSupervisors('test.xml');
end;
