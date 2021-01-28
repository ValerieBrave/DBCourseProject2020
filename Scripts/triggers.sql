---------BEFORE DELETE
create or replace trigger before_supervisor_delete
before delete
on Supervisors
for each row
declare
  cursor sup_studs is select diplom_id from Diploms where supervisor like :old.supervisor;
  did Diploms.diplom_id%type;
begin
  if :old.supervisor not like '--не назначен--' then
  open sup_studs;
  fetch sup_studs into did;
  while sup_studs%found
  loop
    diploms_pack.setsupervisor('',  '--не назначен--', did);
    fetch sup_studs into did;
  end loop;
  close sup_studs;
  else 
    open sup_studs;
  fetch sup_studs into did;
  while sup_studs%found
  loop
    update Diploms
    set supervisor = null
    where diplom_id = did;
    fetch sup_studs into did;
  end loop;
  close sup_studs;
  end if;
end;

delete Supervisors where supervisor like 'Жук Я.А.';
select * from Diploms where supervisor like 'Жук Я.А.';
--------------------------
create or replace trigger before_speciality_delete
before delete
on Specialities
for each row
declare
  cursor sup_studs is select diplom_id from Diploms where speciality like :old.speciality;
  did Diploms.diplom_id%type;
begin
  if :old.speciality not like '--нет--' then
    open sup_studs;
    fetch sup_studs into did;
    while sup_studs%found
    loop
      diploms_pack.changespeciality('', '--нет--', did);
      fetch sup_studs into did;
    end loop;
    close sup_studs;
  else 
    open sup_studs;
    fetch sup_studs into did;
    while sup_studs%found
    loop
      update Diploms
      set speciality = null
      where diplom_id = did;
      fetch sup_studs into did;
    end loop;
    close sup_studs;
  end if;
end;

delete Specialities where speciality like 'ДЭиВИ';
select * from DIploms where speciality like '--нет--';
---------------------------

create or replace trigger before_setter_delete
before delete
on Setters
for each row
declare
  cursor sup_studs is select diplom_id from Diploms where setter like :old.setter;
  did Diploms.diplom_id%type;
begin
  if :old.setter not like '--не назначен--' then
    open sup_studs;
    fetch sup_studs into did;
    while sup_studs%found
    loop
      diploms_pack.setsetter('','--не назначен--' ,did);
      fetch sup_studs into did;
    end loop;
    close sup_studs;
  else 
    open sup_studs;
    fetch sup_studs into did;
    while sup_studs%found
    loop
      update Diploms
      set setter = null
      where diplom_id = did;
      fetch sup_studs into did;
    end loop;
    close sup_studs;
  end if;
end;
select * from Setters;
select * from diploms where setter like '%Жигаровская%';

-----------------
create or replace trigger before_reviewer_delete
before delete
on Reviewers
for each row
declare
  cursor sup_studs is select diplom_id from Diploms where reviewer like :old.reviewer;
  did Diploms.diplom_id%type;
begin
  if :old.reviewer not like '--не назначен--' then
    open sup_studs;
    fetch sup_studs into did;
    while sup_studs%found
    loop
      diploms_pack.setreviewer('','--не назначен--', did);
      fetch sup_studs into did;
    end loop;
    close sup_studs;
  else 
    open sup_studs;
    fetch sup_studs into did;
    while sup_studs%found
    loop
      update Diploms
      set reviewer = null
      where diplom_id = did;
      fetch sup_studs into did;
    end loop;
    close sup_studs;
  end if;
end;

select * from reviewers;
---------------------------
create or replace trigger before_comission_delete
before delete
on Comissions
for each row
declare
  cursor sup_studs is select diplom_id from Diploms where comission like :old.comission;
  did Diploms.diplom_id%type;
begin
  if :old.comission not like '--не назначен--' then
    open sup_studs;
    fetch sup_studs into did;
    while sup_studs%found
    loop
      diploms_pack.setcomission('','--не назначен--', did);
      fetch sup_studs into did;
    end loop;
    close sup_studs;
  else 
    open sup_studs;
    fetch sup_studs into did;
    while sup_studs%found
    loop
      update Diploms
      set comission = null
      where diplom_id = did;
      fetch sup_studs into did;
    end loop;
    close sup_studs;
  end if;
end;

--------------------
create or replace trigger before_chairman_delete
before delete
on Chairmen
for each row
declare
  cursor sup_studs is select diplom_id from Diploms where chairman like :old.chairman;
  did Diploms.diplom_id%type;
begin
  if :old.chairman not like '--не назначен--' then
    open sup_studs;
    fetch sup_studs into did;
    while sup_studs%found
    loop
      diploms_pack.setchairman('','--не назначен--', did);
      fetch sup_studs into did;
    end loop;
    close sup_studs;
  else 
    open sup_studs;
    fetch sup_studs into did;
    while sup_studs%found
    loop
      update Diploms
      set chairman = null
      where diplom_id = did;
      fetch sup_studs into did;
    end loop;
    close sup_studs;
  end if;
end;

-------------------BEFORE UPDATE
create or replace trigger after_speciality_update
after update on Specialities
for each row
begin
  update Diploms
  set speciality = :new.speciality
  where speciality like :old.speciality;
end;
-------------
create or replace trigger after_supervisor_update
after update on Supervisors
for each row
begin
  update Diploms
  set supervisor = :new.supervisor
  where supervisor like :old.supervisor;
end;
------------
create or replace trigger after_setters_update
after update on Setters
for each row
begin
  update Diploms
  set setter = :new.setter
  where setter like :old.setter;
end;
-----------
create or replace trigger after_reviewers_update
after update on reviewers
for each row
begin
  update Diploms
  set reviewer = :new.reviewer
  where reviewer like :old.reviewer;
end;
-----------
create or replace trigger after_comissions_update
after update on comissions
for each row
begin
  update Diploms
  set comission = :new.comission
  where comission like :old.comission;
end;
------------
create or replace trigger after_chairmen_update
after update on chairmen
for each row
begin
  update Diploms
  set chairman = :new.chairman
  where chairman like :old.chairman;
end;

update supervisors
set supervisor = 'Блинова Е.А.'
where supervisor like 'Блинчикова';
select * from SPecialities;
select * from diploms where supervisor like 'Блинчикова';


