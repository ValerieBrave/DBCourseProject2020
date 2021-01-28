----------------------------------------------------- execute as dept_head
grant create session to rl_supervisor;

--object privileges
grant select on dept_head.Diploms to rl_supervisor;
grant delete on dept_head.Diploms to rl_supervisor;
grant update on dept_head.Diploms to rl_supervisor;
grant insert on dept_head.Diploms to rl_supervisor;

grant select on dept_head.Orders to rl_supervisor;
grant select on dept_head.Specialities to rl_supervisor;
grant select on dept_head.Supervisors to rl_supervisor;
grant select on dept_head.Reviewers to rl_supervisor;
grant select on dept_head.Comissions to rl_supervisor;
grant select on dept_head.Chairmen to rl_supervisor;

grant select on POITstudents to rl_supervisor;
grant select on POIBMSstudents to rl_supervisor;
grant select on ISITstudents to rl_supervisor;
grant select on DEIVIstudents to rl_supervisor;

grant select on WorstMarks to rl_supervisor;
grant select on BestMarks to rl_supervisor;
grant select on StudentsWithoutMarks to rl_supervisor;

grant select on StudentsPerEachDay to rl_supervisor;
grant select on PastDefences to rl_supervisor;
grant select on FutureDefences to rl_supervisor;

grant select on CLosestDeadlines to rl_supervisor;
grant select on PastDeadlines to rl_supervisor;

grant select on StudentsPerSupervisor to rl_supervisor;
grant select on StudentsWithoutSupervisor to rl_supervisor;

grant select on StudentsWithoutTopics to rl_supervisor;

grant execute on diploms_pack to rl_supervisor;
grant execute on data_export to rl_supervisor;