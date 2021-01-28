--execute as dept_head
create or replace package setters_pack as
procedure AddSetter (s Setters.setter%type);
procedure EditSetter (s_old Setters.setter%type, s_new Setters.setter%type);
procedure DeleteSetter(s Setters.setter%type);
function CountSetters return number;
end setters_pack;
------------
create or replace package specialities_pack as
procedure AddSpeciality (s Specialities.speciality%type);
procedure EditSpeciality (s_old Specialities.speciality%type, s_new Specialities.speciality%type);
procedure DeleteSpeciality(s Specialities.speciality%type);
function CountSpecialities return number;
end specialities_pack;
------------
create or replace package reviewers_pack as
procedure AddReviewer (r Reviewers.reviewer%type);
procedure EditReviewer (r_old Reviewers.reviewer%type, r_new Reviewers.reviewer%type);
procedure DeleteReviewer(r Reviewers.reviewer%type);
function CountReviewers return number;
end reviewers_pack;
-----------
create or replace package comissions_pack as
procedure AddComission (co Comissions.comission%type);
procedure EditComission (c_old Comissions.comission%type, c_new Comissions.comission%type);
procedure DeleteComission(co Comissions.comission%type);
function CountComissions return number;
end comissions_pack;
------------
create or replace package chairmen_pack as
procedure AddChairman (ch Chairmen.chairman%type);
procedure EditChairman (c_old Chairmen.chairman%type, c_new Chairmen.chairman%type);
procedure DeleteChairman(ch Chairmen.chairman%type);
function CountChairmen return number;
end chairmen_pack;
------------
create or replace package orders_pack as
procedure AddOrder(num Orders.order_number%type, dat Orders.order_date%type);
procedure EditOrder(num_old Orders.order_number%type, dat_old Orders.order_date%type, num_new Orders.order_number%type, dat_new Orders.order_date%type);
procedure SetNewOrderNumber(num_old Orders.order_number%type, dat_old Orders.order_date%type, num_new Orders.order_number%type);
procedure SetNewOrderDate(num_old Orders.order_number%type, dat_old Orders.order_date%type, dat_new Orders.order_date%type);
procedure DeleteOrder(num Orders.order_number%type, dat Orders.order_date%type);
function CountOrders return number;
end orders_pack;
-------------
create or replace package supervisors_pack as
procedure AddSupervisor (sup Supervisors.supervisor%type, em Supervisors.email%type default null);
procedure SetNewSupervisorName (sup_old Supervisors.supervisor%type, sup_new Supervisors.supervisor%type);
procedure SetNewSupervisorEmail (sup Supervisors.supervisor%type, em Supervisors.email%type default null);
procedure DeleteSupervisor(sup Supervisors.supervisor%type);
function CountSupervisors return number;
end supervisors_pack;
--------------
create or replace package diploms_pack as
  procedure AddStudent(stud Diploms.student%type, spec Diploms.speciality%type);
  procedure SetSupervisor(stud Diploms.student%type, sup Diploms.supervisor%type, i Diploms.diplom_id%type default null);
  procedure SetSetter(stud Diploms.student%type, sett Diploms.setter%type, i Diploms.diplom_id%type default null);
  procedure SetReviewer(stud Diploms.student%type, rev diploms.reviewer%type, i Diploms.diplom_id%type default null);
  procedure SetComission(stud Diploms.student%type, com diploms.comission%type, i Diploms.diplom_id%type default null);
  procedure SetChairman(stud Diploms.student%type, ch diploms.chairman%type, i Diploms.diplom_id%type default null);
  procedure ChangeSpeciality(stud Diploms.student%type, spec Diploms.speciality%type, i Diploms.diplom_id%type default null);
  procedure SetOrder(stud Diploms.student%type, or_num Orders.order_number%type, or_dat Orders.order_date%type, i Diploms.diplom_id%type default null);
  procedure SetTopic(stud Diploms.student%type, topic Diploms.topic%type, format Diploms.diplom_form%type, i Diploms.diplom_id%type default null);
  procedure SetDeadline(stud Diploms.student%type, dline Diploms.deadline%type, i Diploms.diplom_id%type default null);
  procedure SetDefence (stud Diploms.student%type, def Diploms.defence%type, qu diploms.defence_queue%type, i Diploms.diplom_id%type default null);
  procedure SetMark(stud Diploms.student%type, mk Diploms.mark%type, i Diploms.diplom_id%type default null);
  procedure DeleteStudent(stud Diploms.student%type, i Diploms.diplom_id%type default null);
end diploms_pack;
-------------------
create or replace package data_export as
  procedure ExportSupervisors;
  procedure ExportOrders;
  procedure ExportSpecialities;
  procedure ExportSetters;
  procedure ExportReviewers;
  procedure ExportComissions;
  procedure ExportChairmen;
end data_export;
-------------------
create or replace package data_import as
  procedure ImportSupervisors (fname Supervisors.supervisor%type);  
end data_import;
-------------------
create or replace package diploms_search as
  procedure SearchByStudent(stud Diploms.student%type) ;
  procedure SearchBySupervisor(sup Diploms.supervisor%type);
end diploms_search;













