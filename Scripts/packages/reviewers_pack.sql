create or replace package body reviewers_pack as
-----------------------
----------------------------------------------------------------
procedure AddReviewer(r Reviewers.reviewer%type)
is
  correct  Reviewers.reviewer%type;
begin
  correct := trim(r);
  insert into Reviewers(reviewer) values(correct);
  dbms_output.put_line('Рецензент '||correct||'  успешно добавлен');
  exception
  when DUP_VAL_ON_INDEX
  then
  dbms_output.put_line('Рецензент '||correct||' уже существует');
end AddReviewer;
-----------------------------------------------------------------
procedure EditReviewer (r_old Reviewers.reviewer%type, r_new Reviewers.reviewer%type)
is
  correct_old Reviewers.reviewer%type;
  correct_new Reviewers.reviewer%type;
  for_search Reviewers.reviewer%type;
  test_s Reviewers.reviewer%type;
begin
  correct_old := trim(r_old);
  correct_new := trim(r_new);
  for_search:= concat('%', concat(correct_old, '%'));
  select reviewer into test_s from Reviewers where reviewer like for_search;
  update Reviewers
  set reviewer = r_new
  where reviewer like for_search;
  dbms_output.put_line('Рецензент '||test_s||' изменен на '|| correct_new);
  exception
    when DUP_VAL_ON_INDEX then
    dbms_output.put_line('Рецензент '||correct_new||' уже существует');
    when no_data_found then
    dbms_output.put_line('Рецензент '||correct_old||' не найден');
end EditReviewer;
------------------------------------------------------------------
procedure DeleteReviewer(r Reviewers.reviewer%type)
is
  test_s Reviewers.reviewer%type;
  for_search Reviewers.reviewer%type;
begin
  for_search := concat('%', concat(trim(r), '%'));
  select reviewer into test_s from Reviewers where reviewer like for_search;
  delete Reviewers where reviewer like for_search;
  dbms_output.put_line('Рецензент '||test_s||' удален ');
   exception
    when no_data_found then
    dbms_output.put_line('Рецензент '||r||' не найден');
end DeleteReviewer;
------------------------------------------------------------------
function CountReviewers 
return number
is
  num number;
begin
  select count(*) into num from Reviewers;
  return num;
end CountReviewers;
------------------------------------------------------------------
----------------------
end reviewers_pack;