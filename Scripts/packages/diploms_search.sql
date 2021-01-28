create or replace package body diploms_search as
----------------------------------------------------
  procedure SearchByStudent(stud Diploms.student%type) 
  is
    stud_cor Diploms.student%type;
    type curtype is ref cursor;
    cur curtype;
    stud_c Diploms.student%type;
    id_c Diploms.diplom_id%type;
    spec_c Diploms.speciality%type;
  begin
    stud_cor := trim(stud);
    open cur for select diplom_id, student, speciality from Diploms where student like concat('%', concat(stud_cor, '%'));
    fetch cur into id_c, stud_c, spec_c;
    while cur%found loop
      dbms_output.put_line(id_c||' '||stud_c||' '||spec_c);
      fetch cur into id_c, stud_c, spec_c;
    end loop;
    close cur;
  end SearchByStudent;
------------------------------------------------------
  procedure SearchBySupervisor(sup Diploms.supervisor%type)
  is
    sup_cor Diploms.supervisor%type;
    type curtype is ref cursor;
    cur curtype;
    stud_c Diploms.student%type;
    id_c Diploms.diplom_id%type;
    spec_c Diploms.speciality%type;
    sup_c Diploms.supervisor%type;
  begin
    sup_cor := trim(sup);
    open cur for select diplom_id, student, speciality, supervisor from Diploms
    where supervisor like concat('%', concat(sup_cor, '%'));
    fetch cur into id_c, stud_c, spec_c, sup_c;
    while cur%found loop
      dbms_output.put_line(id_c||' '||stud_c||' '||spec_c||' '||sup_c);
      fetch cur into id_c, stud_c, spec_c, sup_c;
    end loop;
    close cur;
  end SearchBySupervisor;
end diploms_search;


begin
  diploms_search.SearchBySupervisor('Смелов');
end;
commit;

