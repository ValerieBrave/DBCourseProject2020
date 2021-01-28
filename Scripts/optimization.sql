
create index index_sup 
on diploms(supervisor) tablespace ts_diploms;
create index index_set 
on diploms(setter) tablespace ts_diploms;
create index index_com 
on diploms(comission) tablespace ts_diploms;
create index index_rev 
on diploms(reviewer) tablespace ts_diploms;
create index index_stud 
on diploms(student) tablespace ts_diploms;
create index index_ch 
on diploms(chairman) tablespace ts_diploms;
----

-----
explain plan for select diploms.supervisor from supervisors inner join diploms on diploms.supervisor like Supervisors.supervisor;
select * from table(dbms_xplan.display);