------------TEST DEPT_HEAD PACKAGES------------
-----------------------------SETTERS PACKAGE
begin
  setters_pack.AddSetter('Петрова М.М.');
end;

begin
  setters_pack.EditSetter('   Петрова С.К.  ', ' Петрова М.М.  ');
end;

begin
  setters_pack.DeleteSetter('ddd');
end;

begin
  dbms_output.put_line(setters_pack.countsetters());
end;

----------------------------SPECIALITIES PACKAGE

begin
  specialities_pack.AddSpeciality('ИСиТ');
end;

begin
  specialities_pack.EditSpeciality('ПОИТ', 'ПОИБМС');
end;

begin
  specialities_pack.DeleteSpeciality('ПОИБМС');
end;

begin
  dbms_output.put_line(specialities_pack.countspecialities);
end;

----------------------------------REVIWERS PACKAGE

begin
  reviewers_pack.AddReviewer('Белодед Н.И.');
end;

begin
  reviewers_pack.editreviewer('Белодед Н.И.', 'ssss');
end;

begin
  reviewers_pack.deletereviewer('ssss');
end;

begin
  dbms_output.put_line(reviewers_pack.countreviewers);
end;
select * from Reviewers;

-------------------------------COMISSIONS PACKAGE

begin 
  comissions_pack.AddComission('Смелов В.В.');
end;

begin
  comissions_pack.editcomission('Блинова Е.А.', 'Смелов В.В.');
end;

begin
  comissions_pack.deletecomission('Смелов');
end;

begin
  dbms_output.put_line(comissions_pack.countcomissions);
end;
select * from Comissions;

-------------------------------CHAIRMEN PACKAGE

begin
  chairmen_pack.AddChairman('Самаль Д.И.');
end;

begin
  chairmen_pack.editchairman('Самаль Д.И.', 'Дюбков В.К.');
end;

begin
  chairmen_pack.deletechairman('Дюбков');
end;

begin
  dbms_output.put_line(chairmen_pack.countchairmen);
end;
select * from Chairmen;

-----------------------------ORDERS PACKAGE

begin
  orders_pack.addorder(null, '10-10-2020');
  --orders_pack.addorder(2, '10-10-2020');
end;

begin
  orders_pack.editorder(-10, '10-10-2021', 2, '10-10-2020');
end;

begin
  orders_pack.setnewordernumber(2, '10-10-2020', 3);
end;

begin
  orders_pack.SetNewOrderDate(3, '10-10-2020','10-10-2022');
end;

begin
  orders_pack.DeleteOrder(3, '10-10-2022');
end;

begin
  dbms_output.put_line(orders_pack.CountOrders);
end;

select * from Orders;

---------------------------------SUPERVISORS PACK

begin
  supervisors_pack.AddSupervisor('Смелов В.В.', 'smw60@mail.ru');
  supervisors_pack.AddSupervisor('Жиляк Н.А.');
end;

begin
  supervisors_pack.SetNewSupervisorName('Жук Я.А.', 'Смелов В.В.');
end;

begin
  supervisors_pack.SetNewSupervisorEmail('Жук', 'jhykh@gmail.com');
  supervisors_pack.SetNewSupervisorEmail('sss', 'jhykh@gmail.com');
  supervisors_pack.SetNewSupervisorEmail('Жук');
end;

begin
  supervisors_pack.DeleteSupervisor('sss');
  supervisors_pack.DeleteSupervisor('Жук');
end;

begin
  dbms_output.put_line(supervisors_pack.CountSupervisors);
end;
commit;
select * from Supervisors;

-----------------------------------DIPLOMS PACKAGE

begin
  diploms_pack.AddStudent('Сидоров П.К.', 'ПОИБМС');
end;

begin
  diploms_pack.SetSupervisor('Сидоров П.К.', 'Блинова Е.А.', 3);
end;

begin
  diploms_pack.SetSetter('Смелова','Жигаровская С.А.');
end;

begin
  diploms_pack.SetReviewer('Смелова', 'Белодед', 8);
end;

begin
  diploms_pack.SetComission('Сидоров П.К.', 'кккк',3 );
end;

begin
  diploms_pack.SetChairman('ш', 'Самаль Д.И.');
end;


begin
  --diploms_pack.ChangeSpeciality('Сидоров П.К.', 'ПОИТ');
  --diploms_pack.ChangeSpeciality('Сидоров П.К.', 'ПОИТ', 4);
  diploms_pack.ChangeSpeciality('Смелова', 'ДЭиВИ');
end;

begin
  diploms_pack.SetOrder('Сидоров', 3, '10-10-2021', 10);
end;


begin
  diploms_pack.SetTopic('Сидоров', null, 'Р', 4);
end;

begin
  diploms_pack.SetDeadline('Смелова', '07-07-2021');
end;

begin
  dept_head.diploms_pack.setdefence('Сидоров', '11-10-2021', 4, 3);
end;

begin
  diploms_pack.setmark('sss', 8);
end;

begin
  diploms_pack.deletestudent('Петров', 2501);
end;

select * from chairmen;
select * from Orders;
select count(*) from Diploms where speciality like '%ДЭиВИ%';
select * from Specialities;

update Diploms
set defence = '10-7-2021'
where diplom_id like 1;

------------------TEST FOR SUPERVISOR-USER
begin
  dpack.ADDSTUDENT('Петров Ф.Д.', 'ПОИБМС');
end;



select * from diploms where student like '%Фаина%';

select  distinct student from diploms;















