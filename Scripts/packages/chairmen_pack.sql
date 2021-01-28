create or replace package body chairmen_pack as
-----------------------
----------------------------------------------------------------
procedure AddChairman (ch Chairmen.chairman%type)
is
  correct Chairmen.chairman%type;
begin
  correct := trim(ch);
  insert into Chairmen(chairman) values(correct);
  dbms_output.put_line('Председатель ГЭК '||correct||'  успешно добавлен');
  exception
  when DUP_VAL_ON_INDEX
  then
  dbms_output.put_line('Председатель ГЭК '||correct||' уже существует');
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
    dbms_output.put_line('Председатель ГЭК '||correct_new||' уже существует');
    when no_data_found then
    dbms_output.put_line('Председатель ГЭК '||correct_old||' не найден');
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
  dbms_output.put_line('Председатель ГЭК '||test_s||' удален');
  exception
    when no_data_found then
    dbms_output.put_line('Председатель ГЭК '||ch||' не найден');
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