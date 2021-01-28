---execute as dept_head



create profile pf_supervisor limit
sessions_per_user 3 
failed_login_attempts 3
connect_time 180;

create role rl_supervisor;

create user fit_supervisor identified by fit_supervisor
default tablespace ts_diploms quota unlimited on ts_diploms
profile pf_supervisor
account unlock;

grant rl_supervisor to fit_supervisor;


