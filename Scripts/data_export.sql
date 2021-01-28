---execute as dept_head
create or replace package body data_export as
-------------------------------------
------------------------------------
  procedure ExportSupervisors
  is
    l_file        UTL_FILE.file_type; --для дескриптора
    l_file_name   VARCHAR2 (60) := 'supervisors.xml'; --имя файла
    cursor all_sups is select * from Supervisors;
    one_sup xmltype;  --одна запись в xml
    sup Supervisors%rowtype;  --для курсора
    sup_string varchar2(200); --для записи в файл
  begin
    l_file := UTL_FILE.fopen ('EXPORT_DIR', l_file_name, 'w');
    UTL_FILE.put_line (l_file, '<?xml version= "1.0" ?>');
    UTL_FILE.put_line (l_file, '<Supervisors>');
    open all_sups;
    fetch all_sups into sup;
    while all_sups%found loop
      select  XMLElement("Supervisor", 
              XMLElement("supervisor", sup.supervisor), 
              XMLElement("email", sup.email)) into one_sup from dual;
      sup_string := one_sup.getStringVal();
      UTL_FILE.put_line (l_file, sup_string);
      fetch all_sups into sup;
    end loop;
    close all_sups;
    UTL_FILE.put_line (l_file, '</Supervisors>');
    UTL_FILE.fclose (l_file);
  end ExportSupervisors;
  
  ------------------------------------
  procedure ExportOrders
  is
    l_file        UTL_FILE.file_type;
    l_file_name   VARCHAR2 (60) := 'orders.xml';
    cursor all_ords is select * from Orders;
    one_ord xmltype;
    ord Orders%rowtype;
    ord_string varchar2(200);
  begin
    l_file := UTL_FILE.fopen ('EXPORT_DIR', l_file_name, 'w');
    UTL_FILE.put_line (l_file, '<?xml version= "1.0" ?>');
    UTL_FILE.put_line (l_file, '<Orders>');
    open all_ords;
    fetch all_ords into ord;
    while all_ords%found loop
      select  XMLElement("Order", XMLElement("order_number", ord.order_number), XMLElement("order_date", ord.order_date)) into one_ord from dual;
      ord_string := one_ord.getStringVal();
      UTL_FILE.put_line (l_file, ord_string);
      fetch all_ords into ord;
    end loop;
    close all_ords;
    UTL_FILE.put_line (l_file, '</Orders>');
    UTL_FILE.fclose (l_file);
  end ExportOrders;
-------------------------------------
  procedure ExportSpecialities
  is
    l_file        UTL_FILE.file_type;
    l_file_name   VARCHAR2 (60) := 'specialities.xml';
    cursor all_spec is select * from Specialities;
    one_spec xmltype;
    spec Specialities%rowtype;
    spec_string varchar2(200);
  begin
    l_file := UTL_FILE.fopen ('EXPORT_DIR', l_file_name, 'w');
    UTL_FILE.put_line (l_file, '<?xml version= "1.0" ?>');
    UTL_FILE.put_line (l_file, '<Specialities>');
    open all_spec;
    fetch all_spec into spec;
    while all_spec%found loop
      select  XMLElement("Speciality", spec.speciality) into one_spec from dual;
      spec_string := one_spec.getStringVal();
      UTL_FILE.put_line (l_file, spec_string);
      fetch all_spec into spec;
    end loop;
    close all_spec;
    UTL_FILE.put_line (l_file, '</Specialities>');
    UTL_FILE.fclose (l_file);
  end ExportSpecialities;
-------------------------------------
  procedure ExportSetters
  is
    l_file        UTL_FILE.file_type;
    l_file_name   VARCHAR2 (60) := 'setters.xml';
    cursor all_sett is select * from Setters;
    one_sett xmltype;
    sett Setters%rowtype;
    sett_string varchar2(200);
  begin
    l_file := UTL_FILE.fopen ('EXPORT_DIR', l_file_name, 'w');
    UTL_FILE.put_line (l_file, '<?xml version= "1.0" ?>');
    UTL_FILE.put_line (l_file, '<Setters>');
    open all_sett;
    fetch all_sett into sett;
    while all_sett%found loop
      select  XMLElement("Setter", sett.setter) into one_sett from dual;
      sett_string := one_sett.getStringVal();
      UTL_FILE.put_line (l_file, sett_string);
      fetch all_sett into sett;
    end loop;
    close all_sett;
    UTL_FILE.put_line (l_file, '</Specialities>');
    UTL_FILE.fclose (l_file);
  end ExportSetters;
-------------------------------------
  procedure ExportReviewers
  is
    l_file        UTL_FILE.file_type;
    l_file_name   VARCHAR2 (60) := 'reviewers.xml';
    cursor all_rev is select * from Reviewers;
    one_rev xmltype;
    rev Reviewers%rowtype;
    rev_string varchar2(200);
  begin
    l_file := UTL_FILE.fopen ('EXPORT_DIR', l_file_name, 'w');
    UTL_FILE.put_line (l_file, '<?xml version= "1.0" ?>');
    UTL_FILE.put_line (l_file, '<Reviewers>');
    open all_rev;
    fetch all_rev into rev;
    while all_rev%found loop
      select  XMLElement("Reviewer", rev.reviewer) into one_rev from dual;
      rev_string := one_rev.getStringVal();
      UTL_FILE.put_line (l_file, rev_string);
      fetch all_rev into rev;
    end loop;
    close all_rev;
    UTL_FILE.put_line (l_file, '</Reviewers>');
    UTL_FILE.fclose (l_file);
  end ExportReviewers;
------------------------------------
  procedure ExportComissions
  is
    l_file        UTL_FILE.file_type;
    l_file_name   VARCHAR2 (60) := 'comissions.xml';
    cursor all_com is select * from Comissions;
    one_com xmltype;
    com Comissions%rowtype;
    com_string varchar2(200);
  begin
    l_file := UTL_FILE.fopen ('EXPORT_DIR', l_file_name, 'w');
    UTL_FILE.put_line (l_file, '<?xml version= "1.0" ?>');
    UTL_FILE.put_line (l_file, '<Comissions>');
    open all_com;
    fetch all_com into com;
    while all_com%found loop
      select  XMLElement("Comission", com.comission) into one_com from dual;
      com_string := one_com.getStringVal();
      UTL_FILE.put_line (l_file, com_string);
      fetch all_com into com;
    end loop;
    close all_com;
    UTL_FILE.put_line (l_file, '</Comissions>');
    UTL_FILE.fclose (l_file);
  end ExportComissions;
------------------------------------
  procedure ExportChairmen
  is
    l_file        UTL_FILE.file_type;
    l_file_name   VARCHAR2 (60) := 'chairmen.xml';
    cursor all_ch is select * from Chairmen;
    one_ch xmltype;
    ch Chairmen%rowtype;
    ch_string varchar2(200);
  begin
    l_file := UTL_FILE.fopen ('EXPORT_DIR', l_file_name, 'w');
    UTL_FILE.put_line (l_file, '<?xml version= "1.0" ?>');
    UTL_FILE.put_line (l_file, '<Chairmen>');
    open all_ch;
    fetch all_ch into ch;
    while all_ch%found loop
      select  XMLElement("Chairman", ch.chairman) into one_ch from dual;
      ch_string := one_ch.getStringVal();
      UTL_FILE.put_line (l_file, ch_string);
      fetch all_ch into ch;
    end loop;
    close all_ch;
    UTL_FILE.put_line (l_file, '</Chairmen>');
    UTL_FILE.fclose (l_file);
  end ExportChairmen;
------------------------------------
------------------------------------
end data_export;
  
begin
  data_export.exportchairmen();
end;





--select sysdate from dual;