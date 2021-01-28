---- execute as system
grant create any directory to dept_head;
grant read, write on directory source_dir to dept_head;
grant read, write on directory export_dir to dept_head;


grant grant any privilege to dept_head;
grant create user to dept_head;
grant alter user to dept_head;
grant drop user to dept_head;

grant create role to dept_head;
grant alter any role to dept_head;
grant drop any role to dept_head;

grant create profile to dept_head;
grant alter  profile to dept_head;
grant drop  profile to dept_head;

grant create tablespace to dept_head;
grant alter tablespace to dept_head;
grant drop tablespace to dept_head;

grant create sequence to dept_head;

grant create table to dept_head;
grant create any table to dept_head;
grant alter any table to dept_head;
grant drop any table to dept_head;

grant create public synonym to dept_head;
grant drop public synonym to dept_head;

grant create any view to dept_head;
grant drop any view to dept_head;

grant create trigger to dept_head;
grant drop any trigger  to dept_head;

grant create any index to dept_head;

grant create any procedure to dept_head;

grant create job to dept_head;
GRANT SCHEDULER_ADMIN TO dept_head;
GRANT MANAGE SCHEDULER TO dept_head;
grant select on dba_scheduler_running_jobs to dept_head;
