--execute as dept_head
CREATE OR REPLACE DIRECTORY source_dir AS 'D:\LERA\DBCourseProj\Source';
CREATE OR REPLACE DIRECTORY export_dir AS 'D:\LERA\DBCourseProj\Export';

---execute as dept_head
create tablespace ts_diploms
datafile 'D:\LERA\DBCourseProj\Datafiles\TS_DIPLOMS.DBF'
size 20m
online;
alter tablespace ts_diploms add datafile 'D:\LERA\DBCourseProj\Datafiles\TS_DIPLOMS2.DBF' size 50m;
---execute as system
alter user dept_head quota unlimited on ts_diploms;

---execute as dept_head
create table Orders
(
  order_number integer not null,
  order_date date not null,
  constraint pk_order primary key(order_number, order_date)
) tablespace ts_diploms;

create table Specialities
(
  speciality varchar2(10) primary key
)tablespace ts_diploms;
create table Supervisors
(
  supervisor varchar2(50) primary key,
  email varchar2(100)
)tablespace ts_diploms;
create table Setters
(
  setter varchar2(50) primary key
)tablespace ts_diploms;
create table Reviewers
(
  reviewer varchar2(50) primary key
)tablespace ts_diploms;
create table Comissions
(
  comission varchar2(50) primary key
)tablespace ts_diploms;
create table Chairmen
(
  chairman varchar2(50) primary key
)tablespace ts_diploms;


create table Diploms
(
  diplom_id number generated always as identity primary key,
  student varchar2(50) not null,      --DONE
  topic varchar2(200),            --DONE
  diplom_form char(1),            --DONE
  deadline date,                  --DONE
  defence date,                   --DONE
  defence_queue number,           --DONE
  mark number,                    --DONE
  order_id varchar2(20),          --DONE
  speciality varchar2(10),        --DONE
  supervisor varchar2(50),        --DONE
  setter varchar2(50),            --DONE
  reviewer varchar2(50),          --DONE
  comission varchar2(50),         --DONE
  chairman varchar2(50),          --DONE
  ------------------------------constraints---------------------------------
  --constraint pk_diplomid primary key (diplom_id),
  constraint fk_speciality foreign key (speciality) references dept_head.Specialities(speciality),
  constraint fk_supervisor foreign key (supervisor) references dept_head.Supervisors(supervisor),
  constraint fk_setter foreign key (setter) references dept_head.Setters(setter),
  constraint fk_reviewer foreign key (reviewer) references dept_head.Reviewers(reviewer),
  constraint fk_comission foreign key (comission) references dept_head.Comissions(comission),
  constraint fk_chairman foreign key (chairman) references dept_head.Chairmen(chairman)
  --diplom_form 
)tablespace ts_diploms;
--drop table Diploms;
select * from user_objects;