------------TEST DEPT_HEAD PACKAGES------------
-----------------------------SETTERS PACKAGE
begin
  setters_pack.AddSetter('������� �.�.');
end;

begin
  setters_pack.EditSetter('   ������� �.�.  ', ' ������� �.�.  ');
end;

begin
  setters_pack.DeleteSetter('ddd');
end;

begin
  dbms_output.put_line(setters_pack.countsetters());
end;

----------------------------SPECIALITIES PACKAGE

begin
  specialities_pack.AddSpeciality('����');
end;

begin
  specialities_pack.EditSpeciality('����', '������');
end;

begin
  specialities_pack.DeleteSpeciality('������');
end;

begin
  dbms_output.put_line(specialities_pack.countspecialities);
end;

----------------------------------REVIWERS PACKAGE

begin
  reviewers_pack.AddReviewer('������� �.�.');
end;

begin
  reviewers_pack.editreviewer('������� �.�.', 'ssss');
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
  comissions_pack.AddComission('������ �.�.');
end;

begin
  comissions_pack.editcomission('������� �.�.', '������ �.�.');
end;

begin
  comissions_pack.deletecomission('������');
end;

begin
  dbms_output.put_line(comissions_pack.countcomissions);
end;
select * from Comissions;

-------------------------------CHAIRMEN PACKAGE

begin
  chairmen_pack.AddChairman('������ �.�.');
end;

begin
  chairmen_pack.editchairman('������ �.�.', '������ �.�.');
end;

begin
  chairmen_pack.deletechairman('������');
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
  supervisors_pack.AddSupervisor('������ �.�.', 'smw60@mail.ru');
  supervisors_pack.AddSupervisor('����� �.�.');
end;

begin
  supervisors_pack.SetNewSupervisorName('��� �.�.', '������ �.�.');
end;

begin
  supervisors_pack.SetNewSupervisorEmail('���', 'jhykh@gmail.com');
  supervisors_pack.SetNewSupervisorEmail('sss', 'jhykh@gmail.com');
  supervisors_pack.SetNewSupervisorEmail('���');
end;

begin
  supervisors_pack.DeleteSupervisor('sss');
  supervisors_pack.DeleteSupervisor('���');
end;

begin
  dbms_output.put_line(supervisors_pack.CountSupervisors);
end;
commit;
select * from Supervisors;

-----------------------------------DIPLOMS PACKAGE

begin
  diploms_pack.AddStudent('������� �.�.', '������');
end;

begin
  diploms_pack.SetSupervisor('������� �.�.', '������� �.�.', 3);
end;

begin
  diploms_pack.SetSetter('�������','����������� �.�.');
end;

begin
  diploms_pack.SetReviewer('�������', '�������', 8);
end;

begin
  diploms_pack.SetComission('������� �.�.', '����',3 );
end;

begin
  diploms_pack.SetChairman('�', '������ �.�.');
end;


begin
  --diploms_pack.ChangeSpeciality('������� �.�.', '����');
  --diploms_pack.ChangeSpeciality('������� �.�.', '����', 4);
  diploms_pack.ChangeSpeciality('�������', '�����');
end;

begin
  diploms_pack.SetOrder('�������', 3, '10-10-2021', 10);
end;


begin
  diploms_pack.SetTopic('�������', null, '�', 4);
end;

begin
  diploms_pack.SetDeadline('�������', '07-07-2021');
end;

begin
  dept_head.diploms_pack.setdefence('�������', '11-10-2021', 4, 3);
end;

begin
  diploms_pack.setmark('sss', 8);
end;

begin
  diploms_pack.deletestudent('������', 2501);
end;

select * from chairmen;
select * from Orders;
select count(*) from Diploms where speciality like '%�����%';
select * from Specialities;

update Diploms
set defence = '10-7-2021'
where diplom_id like 1;

------------------TEST FOR SUPERVISOR-USER
begin
  dpack.ADDSTUDENT('������ �.�.', '������');
end;



select * from diploms where student like '%�����%';

select  distinct student from diploms;















