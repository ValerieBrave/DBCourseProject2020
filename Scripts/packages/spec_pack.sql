create or replace package body specialities_pack as
-----------------------
----------------------------------------------------------------
procedure AddSpeciality (s Specialities.speciality%type)
is
  correct Specialities.speciality%type;
begin
  correct := trim(s);
  insert into Specialities(speciality) values(correct);
  dbms_output.put_line('Специальность '||s||'  успешно добавлена');
exception
  when DUP_VAL_ON_INDEX
  then
  dbms_output.put_line('Специальность '||s||' уже существует');
end AddSpeciality;
----------------------------------------------------------------
procedure EditSpeciality (s_old Specialities.speciality%type, s_new Specialities.speciality%type)
is
  correct_old Specialities.speciality%type;
  correct_new Specialities.speciality%type;
  for_search Specialities.speciality%type;
  test_s Specialities.speciality%type;
begin
  correct_old := trim(s_old);
  correct_new := trim(s_new);
  for_search:= concat('%', concat(correct_old, '%'));
  select speciality into test_s from Specialities where speciality like for_search;
  update Specialities
  set speciality = s_new
  where speciality like for_search;
  dbms_output.put_line('Специальность '||test_s||' изменена на '|| correct_new);
  exception
    when DUP_VAL_ON_INDEX then
    dbms_output.put_line('Специальность '||correct_new||' уже существует');
    when no_data_found then
    dbms_output.put_line('Специальность '||correct_old||' не найдена');
end EditSpeciality;
-----------------------------------------------------------------
procedure DeleteSpeciality(s Specialities.speciality%type)
is
  test_s Specialities.speciality%type;
  for_search Specialities.speciality%type;
begin
  for_search := concat('%', concat(trim(s), '%'));
  select speciality into test_s from Specialities where speciality like for_search; 
  delete Specialities where speciality like for_search;
  dbms_output.put_line('Специальность '||test_s||' удалена ');
  exception
    when no_data_found then
    dbms_output.put_line('Специальность '||s||' не найдена');
end DeleteSpeciality;
-----------------------------------------------------------------
function CountSpecialities 
return number
is
  num number;
begin 
  select count(*) into num from Specialities;
  return num;
end CountSpecialities;
-----------------------------------------------------------------
----------------------
end specialities_pack;