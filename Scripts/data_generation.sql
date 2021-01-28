------------MARKS
declare
  
  i integer := 4;
begin
  for k in 29495..59529
    loop
      if i = 11 then i:=4; end if;
      diploms_pack.SetMark('', i, k);
      i := i+1;
    end loop;
end;
select * from diploms;
-------------DEFEND DATES
declare
  cursor studs is select diplom_id from Diploms;
  did Diploms.diplom_id%type;
  qu Diploms.defence_queue%type := 1;
  def Diploms.defence%type := '01-07-2020';
begin
  open studs;
  fetch studs into did;
  while studs%found
  loop
    if qu = 10 then qu :=1; def := def +1; end if;
    diploms_pack.SetDefence('',def, qu, did);
    qu := qu +1;
    fetch studs into did;
  end loop;
end;

-------------DEADLINES
declare
  cursor studs is select diplom_id from Diploms;
  did Diploms.diplom_id%type;
  qu Diploms.defence_queue%type := 1;
  ded Diploms.deadline%type := '01-06-2020';
begin
  open studs;
  fetch studs into did;
  while studs%found
  loop
    if qu = 10 then qu :=1; ded := ded +1; end if;
    diploms_pack.SetDeadline('',ded,did);
    qu := qu +1;
    fetch studs into did;
  end loop;
end;


-------------SUPERVISORS
select * from Supervisors;
declare
  cursor studs is select diplom_id from Diploms;
  did Diploms.diplom_id%type;
begin
  open studs;
  fetch studs into did;
  while studs%found
  loop
    if mod(did, 21) =0 then diploms_pack.setsupervisor('', 'Блинова Е.А', did);
    elsif mod(did, 23) =0 then diploms_pack.setsupervisor('', 'Романенко Д.М.', did);
    elsif mod(did, 15) =0 then diploms_pack.setsupervisor('', 'Наркевич А.С.', did); 
    elsif mod(did, 17) =0 then diploms_pack.setsupervisor('', 'Жиляк Н.А.', did); 
    elsif mod(did, 13) =0 then diploms_pack.setsupervisor('', 'Жук Я.А.', did);
    else diploms_pack.setsupervisor('', '--не назначен--', did); end if;
    fetch studs into did;
  end loop;
  close studs;
end;

---------SETTERS
select * from Setters;
declare
  cursor studs is select diplom_id from Diploms;
  did Diploms.diplom_id%type;
begin
  open studs;
  fetch studs into did;
  while studs%found
  loop
    if mod(did, 5) =0 then diploms_pack.setsetter('', 'Петрова М.М.', did);
    elsif mod(did, 11) =0 then diploms_pack.setsetter('', 'Жигаровская С.А.', did);
    elsif mod(did, 17) =0 then diploms_pack.setsetter('', 'Ковалевская С.В.', did); 
    else diploms_pack.setsetter('', '--не назначен--', did); end if;
    fetch studs into did;
  end loop;
  close studs;
end;

-------------REVIEWERS

select * from reviewers;
declare
  cursor studs is select diplom_id from Diploms;
  did Diploms.diplom_id%type;
begin
  open studs;
  fetch studs into did;
  while studs%found
  loop
    if mod(did, 11) =0 then diploms_pack.setreviewer('', 'Блинова Е.А', did);
    elsif mod(did, 7) =0 then diploms_pack.setreviewer('', 'Романенко Д.М.', did);
    elsif mod(did, 5) =0 then diploms_pack.setreviewer('', 'Пацей Н.В.', did); 
    elsif mod(did, 13) =0 then diploms_pack.setreviewer('', 'Жиляк Н.А.', did); 
    elsif mod(did, 41) =0 then diploms_pack.setreviewer('', 'Жук Я.А.', did);
    elsif mod(did, 17) =0 then diploms_pack.setreviewer('', 'Гурин Н.И.', did);
    elsif mod(did, 53) =0 then diploms_pack.setreviewer('', 'Шиман Д.В.', did);
    else diploms_pack.setreviewer('', '--не назначен--', did); end if;
    fetch studs into did;
  end loop;
  close studs;
end;


select * from diploms;
select * from chairmen;

--------CHAIRMEN
declare
  cursor studs is select diplom_id from Diploms;
  did Diploms.diplom_id%type;
begin
  open studs;
  fetch studs into did;
  while studs%found
  loop
    if mod(did, 5) =0 then diploms_pack.setchairman('', 'Дюбков В.К.', did);
    elsif mod(did, 11) =0 then diploms_pack.setchairman('', 'Комличенко В.Н.', did);
    elsif mod(did, 17) =0 then diploms_pack.setchairman('', 'Самаль Д.И.', did); 
    else diploms_pack.setsetter('', '--не назначен--', did); end if;
    fetch studs into did;
  end loop;
  close studs;
end;

------------COMISSIONS
declare
  cursor studs is select diplom_id from Diploms;
  did Diploms.diplom_id%type;
begin
  open studs;
  fetch studs into did;
  while studs%found
  loop
    if mod(did, 91) =0 then diploms_pack.setcomission('', 'Смелов В.В.', did);
    elsif mod(did, 60) =0 then diploms_pack.setcomission('', 'Пацей Н.В.', did);
    elsif mod(did, 111) =0 then diploms_pack.setcomission('', 'Жиляк Н.А.', did); 
    elsif mod(did, 89) =0 then diploms_pack.setcomission('', 'Блинова Е.А.', did); 
    else diploms_pack.setcomission('', '--не назначен--', did); end if;
    fetch studs into did;
  end loop;
  close studs;
end;

begin
  diploms_pack.settopic('', 'Бронирование ЖД билетов', 'п', 29595);
  diploms_pack.settopic('', 'Онлайн-календарь', 'р', 30595);
  diploms_pack.settopic('', 'Интерактивная карта', 'п', 35678);
end;
