create or replace package body chairmen_pack as
-----------------------
----------------------------------------------------------------
procedure AddChairman (ch Chairmen.chairman%type)
is
  correct Chairmen.chairman%type;
begin
  correct := trim(ch);
  insert into Chairmen(chairman) values(correct);
  dbms_output.put_line('������������ ��� '||correct||'  ������� ��������');
  exception
  when DUP_VAL_ON_INDEX
  then
  dbms_output.put_line('������������ ��� '||correct||' ��� ����������');
end AddChairman;
----------------------------------------------------------------
procedure EditChairman (c_old Chairmen.chairman%type, c_new Chairmen.chairman%type)
is
  correct_old Chairmen.chairman%type;
  correct_new Chairmen.chairman%type;
  for_search Chairmen.chairman%type;
  test_s Chairmen.chairman%type;
begin
  correct_old := trim(c_old);
  correct_new := trim(c_new);
  for_search:= concat('%', concat(correct_old, '%'));
  select chairman into test_s from Chairmen where chairman like for_search;
  update Chairmen
  set chairman = correct_new
  where chairman like test_s;
  exception
    when DUP_VAL_ON_INDEX then
    dbms_output.put_line('������������ ��� '||correct_new||' ��� ����������');
    when no_data_found then
    dbms_output.put_line('������������ ��� '||correct_old||' �� ������');
end EditChairman;
----------------------------------------------------------------
procedure DeleteChairman(ch Chairmen.chairman%type)
is
  test_s Chairmen.chairman%type;
  for_search Chairmen.chairman%type;
begin
  for_search := concat('%', concat(trim(ch), '%'));
  select chairman into test_s from Chairmen where chairman like for_search;
  delete Chairmen where chairman like test_s; 
  dbms_output.put_line('������������ ��� '||test_s||' ������');
  exception
    when no_data_found then
    dbms_output.put_line('������������ ��� '||ch||' �� ������');
end DeleteChairman;
-----------------------------------------------------------------
function CountChairmen 
return number
is
  num number;
begin
  select count(*) into num from Chairmen;
  return num;
end CountChairmen;
----------------------------------------------------------------
-----------------------
end chairmen_pack;