create or replace package body comissions_pack as
-----------------------
----------------------------------------------------------------
procedure AddComission (co Comissions.comission%type)
is
  correct  Comissions.comission%type;
begin
  correct := trim(co);
  insert into Comissions(comission) values (correct);
  dbms_output.put_line('������������ '||correct||'  ������� ��������');
  exception
  when DUP_VAL_ON_INDEX
  then
  dbms_output.put_line('������������ '||correct||' ��� ����������');
end;
----------------------------------------------------------------
procedure EditComission (c_old Comissions.comission%type, c_new Comissions.comission%type)
is
  correct_old Comissions.comission%type;
  correct_new Comissions.comission%type;
  for_search Comissions.comission%type;
  test_s Comissions.comission%type;
begin
  correct_old := trim(c_old);
  correct_new := trim(c_new);
  for_search:= concat('%', concat(correct_old, '%'));
  select comission into test_s from Comissions where comission like for_search;
  update Comissions
  set comission = correct_new
  where comission like for_search;
  dbms_output.put_line('������������ '||test_s||' ������� �� '|| correct_new);
  exception
    when DUP_VAL_ON_INDEX then
    dbms_output.put_line('������������ '||correct_new||' ��� ����������');
    when no_data_found then
    dbms_output.put_line('������������ '||correct_old||' �� ������');
end EditComission;
----------------------------------------------------------------
procedure DeleteComission(co Comissions.comission%type)
is
  test_s Comissions.comission%type;
  for_search Comissions.comission%type;
begin
  for_search := concat('%', concat(trim(co), '%'));
  select comission into test_s from Comissions where comission like for_search;
  delete Comissions where comission like test_s;
  dbms_output.put_line('������������ '||test_s||' ������ ');
   exception
    when no_data_found then
    dbms_output.put_line('������������ '||co||' �� ������');
end DeleteComission;
-------------------------------------------------------------------
function CountComissions 
return number
is
  num integer;
begin
  select count(*) into num from Comissions;
  return num;
end CountComissions;
----------------------------------------------------------------
-----------------------
end comissions_pack;