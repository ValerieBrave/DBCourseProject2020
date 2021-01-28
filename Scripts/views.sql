--execute as dept_head

------BY SPECIALITIES
create view POITstudents as select diplom_id, student, speciality from dept_head.Diploms where speciality like 'ÏÎÈÒ' order by diplom_id;
create view POIBMSstudents as select diplom_id, student, speciality from dept_head.Diploms where speciality like 'ÏÎÈÁÌÑ' order by diplom_id;
create view ISITstudents as select diplom_id, student, speciality from dept_head.Diploms where speciality like 'ÈÑèÒ' order by diplom_id;
create view DEIVIstudents as select diplom_id, student, speciality from dept_head.Diploms where speciality like 'ÄİèÂÈ' order by diplom_id;
select * from POITstudents;
select * from POIBMSstudents;
select * from ISITstudents;
select * from DEIVIstudents;
------BY MARKS
create view BestMarks as select diplom_id, student, speciality, topic, mark from dept_head.Diploms where mark > 8;
create view WorstMarks as select diplom_id, student, speciality, topic, mark from dept_head.Diploms where mark < 6;
create view StudentsWithoutMarks as select diplom_id, student, mark from Diploms where mark is null;
select * from BestMarks;
select * from WorstMarks;
select * from StudentsWithoutMarks;
------BY DEFEND
create view StudentsPerEachDay as select defence, count(*) at_all from Diploms group by defence;
create view PastDefences as select student, speciality, defence from Diploms where defence < sysdate order by defence;
create view FutureDefences as select student, speciality, defence from Diploms where defence > sysdate order by defence;
select * from StudentsPerEachDay;
select * from PastDefences;
select * from FutureDefences;
------BY DEADLINE
create view ClosestDeadlines as select diplom_id, student, speciality, deadline from Diploms where deadline > sysdate order by deadline;
create view PastDeadlines as select diplom_id, student, speciality, deadline from Diploms where deadline < sysdate order by deadline desc;
select * from CLosestDeadlines;
select * from PastDeadlines;
------BY SUPERVISORS
create view StudentsPerSupervisor as select  d.supervisor, count(*) at_all 
from (select supervisor from Diploms where supervisor  not like '--íå íàçíà÷åí--')  d
inner join
      Supervisors
      on Supervisors.supervisor like d.supervisor
group by d.supervisor;
create view StudentsWithoutSupervisor as select diplom_id, student, speciality, supervisor from Diploms where supervisor like '--íå íàçíà÷åí--';
select * from StudentsPerSupervisor;
select * from StudentsWithoutSupervisor;
------BY TOPICS
create view StudentsWithoutTopics as select diplom_id, student, speciality, topic from Diploms where topic is null or topic like '';
select * from studentswithouttopics;










