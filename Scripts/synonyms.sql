--execute as dept_head
create or replace public synonym dpack for dept_head.diploms_pack;
create or replace public synonym exporting for dept_head.data_export;
create or replace public synonym importing for dept_head.data_import;
--tables
create or replace public synonym diploms for dept_head.Diploms;
create or replace public synonym orders for dept_head.Orders ;
create or replace public synonym specialities for dept_head.Specialities ;
create or replace public synonym supervisors for dept_head.Supervisors ;
create or replace public synonym reviewers for dept_head.Reviewers;
create or replace public synonym comissions for dept_head.Comissions;
create or replace public synonym chairmen for dept_head.Chairmen ;
--views
create or replace public synonym POITstudents for dept_head.POITstudents;
create or replace public synonym ISITstudents for dept_head.ISITstudents;
create or replace public synonym POIBMSstudents for dept_head.POIBMSstudents;
create or replace public synonym DEIVIstudents for dept_head.DEIVIstudents;
create or replace public synonym BestMarks for dept_head.BestMarks;
create or replace public synonym WorstMarks for dept_head.WorstMarks;
create or replace public synonym StudentsWithoutMarks for dept_head.StudentsWithoutMarks;
create or replace public synonym StudentsDefencesPerEachDay for dept_head.StudentsPerEachDay;
create or replace public synonym PastDefences for dept_head.PastDefences;
create or replace public synonym FutureDefences for dept_head.FutureDefences;
create or replace public synonym ClosestDeadlines for dept_head.ClosestDeadlines;
create or replace public synonym PastDeadlines for dept_head.PastDeadlines;
create or replace public synonym StudentsPerSupervisor for dept_head.StudentsPerSupervisor;
create or replace public synonym StudentsWithoutSupervisor for dept_head.StudentsWithoutSupervisor;
create or replace public synonym StudentsWithoutTopics for dept_head.StudentsWithoutTopics;


