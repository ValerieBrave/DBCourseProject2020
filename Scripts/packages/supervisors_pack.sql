create or replace package body supervisors_pack as
-----------------------
----------------------------------------------------------------
procedure AddSupervisor (sup Supervisors.supervisor%type, em Supervisors.email%type default null)
is
  corr_sup Supervisors.supervisor%type;
  corr_em Supervisors.email%type := null;
begin
  corr_sup := trim(sup);
  if em is not null then corr_em := trim(em); end if;
  insert into Supervisors(supervisor, email) values(corr_sup, corr_em);
  dbms_output.put_line('Руководитель '||corr_sup||' успешно добавлен');
  exception
  when DUP_VAL_ON_INDEX
  then dbms_output.put_line('Руководитель '||corr_sup||' уже существует');
  when others
  then dbms_output.put_line(sqlerrm);
end AddSupervisor;
----------------------------------------------------------------
procedure SetNewSupervisorName (sup_old Supervisors.supervisor%type, sup_new Supervisors.supervisor%type)
is 
  corr_old Supervisors.supervisor%type;
  corr_new Supervisors.supervisor%type;
  for_search Supervisors.supervisor%type;
  test_s Supervisors.supervisor%type;
begin
  corr_old := trim(sup_old);
  corr_new := trim(sup_new);
  for_search := concat('%', concat(corr_old, '%'));
  select supervisor into test_s from Supervisors where supervisor like for_search;
  update Supervisors
  set supervisor = corr_new
  where supervisor like for_search;
  dbms_output.put_line('Руководитель '||test_s||' изменен на '||corr_new);
  exception
  when no_data_found 
  then  dbms_output.put_line('Руководитель '||corr_old||' не найден');
  when DUP_VAL_ON_INDEX
  then dbms_output.put_line('Руководитель '||corr_new||' уже существует');
  when others
  then dbms_output.put_line(sqlerrm);
end SetNewSupervisorName;
----------------------------------------------------------------
procedure SetNewSupervisorEmail (sup Supervisors.supervisor%type, em Supervisors.email%type)
is
  corr_sup Supervisors.supervisor%type;
  corr_em Supervisors.email%type;
  for_search Supervisors.supervisor%type;
  test_s Supervisors.supervisor%type;
begin
  corr_sup := trim(sup);
  for_search := concat('%', concat(corr_sup, '%'));
  select supervisor into test_s from Supervisors where supervisor like for_search;
  if em is not null
  then
    corr_em := trim(em);
    update Supervisors
    set email = corr_em
    where supervisor like for_search;
    dbms_output.put_line('Почта руководителя '||test_s||' изменена на '||corr_em);
  else
    update Supervisors
    set email = null
    where supervisor like for_search;
    dbms_output.put_line('Почта руководителя '||test_s||' сброшена');
  end if;
  exception
  when no_data_found 
  then  dbms_output.put_line('Руководитель '||corr_sup||' не найден');
end SetNewSupervisorEmail;
----------------------------------------------------------------
procedure DeleteSupervisor(sup Supervisors.supervisor%type)
is
  corr_sup Supervisors.supervisor%type;
  for_search Supervisors.supervisor%type;
  test_s Supervisors.supervisor%type;
begin
  corr_sup := trim(sup);
  for_search := concat('%', concat(corr_sup, '%'));
  select supervisor into test_s from Supervisors where supervisor like for_search;
  delete Supervisors where supervisor like for_search;
  dbms_output.put_line('Руководитель '||corr_sup||' удален');
  exception
  when no_data_found 
  then  dbms_output.put_line('Руководитель '||corr_sup||' не найден');
end DeleteSupervisor;
----------------------------------------------------------------
function CountSupervisors 
return number
is
  num integer;
begin
  select count(*) into num from Supervisors;
  return num;
end CountSupervisors;
----------------------------------------------------------------
-----------------------
end supervisors_pack;