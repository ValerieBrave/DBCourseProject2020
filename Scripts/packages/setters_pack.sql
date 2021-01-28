---execute as dept_head
create or replace package body setters_pack as
-----------------------
----------------------------------------------------------------
procedure AddSetter(s Setters.setter%type)
is
  correct Setters.setter%type;
begin
  correct := trim(s);
  insert into Setters(setter) values(correct);
  exception
  when DUP_VAL_ON_INDEX
  then
  dbms_output.put_line('Нормоконтролер '||s||' уже существует');
end AddSetter;
-----------------------------------------------------------------
procedure EditSetter (s_old Setters.setter%type, s_new Setters.setter%type)
is
  correct_old Setters.setter%type;
  correct_new Setters.setter%type;
  for_search Setters.setter%type;
  test_s Setters.setter%type;
begin
  correct_old := trim(s_old);
  correct_new := trim(s_new);
  for_search:= concat('%', concat(correct_old, '%'));
  select setter into test_s from Setters where setter like for_search;
  --dbms_output.put_line(for_search);
  update Setters
  set setter = correct_new
  where setter like for_search;
  dbms_output.put_line('Нормоконтролер '||correct_old||' изменен на '|| correct_new);
  exception
    when DUP_VAL_ON_INDEX then
    dbms_output.put_line('Нормоконтролер '||correct_new||' уже существует');
    when no_data_found then
    dbms_output.put_line('Нормоконтролер '||correct_old||' не найден');
end EditSetter;
------------------------------------------------------------------
procedure DeleteSetter(s Setters.setter%type)
is
  test_s Setters.setter%type;
  for_search Setters.setter%type;
begin
  for_search := concat('%', concat(trim(s), '%'));
  select setter into test_s from Setters where setter like for_search;  
  delete Setters where setter like for_search;
  exception
    when no_data_found then
    dbms_output.put_line('Нормоконтролер '||s||' не найден');
end;
------------------------------------------------------------------
function CountSetters 
return number
is
  num number;
begin
  select count(*) into num from Setters;
return num;
end CountSetters;
-------------------------------------------------------------------
-----------------------
end setters_pack;