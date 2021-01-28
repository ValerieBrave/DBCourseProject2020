create or replace procedure supervisors_mailing     -- функция для job
as
  cursor emails is select supervisor, email from Supervisors;
  rec supervisors.email%type;
  sup supervisors.supervisor%type;
  type stinf is ref cursor return Diploms%rowtype;
  stud_list stinf;
  student Diploms%rowtype;
  need_to_send boolean := false;
  message clob:=' ';
begin
  open emails;
  fetch emails into sup, rec;
  while emails%found loop   -- цикл по преподавателям
    if rec is not null then   -- если указана почта
      open stud_list for select * from Diploms where supervisor like sup;   --студенты под выбранным преподавателем
      fetch stud_list into student;
      while stud_list%found loop
        if student.topic is null or student.topic like '' then
        need_to_send := true; message := concat('topic  ', message); end if;
        if student.diplom_form is null then
        need_to_send := true; message := concat('diplom form  ', message);end if;
        if student.deadline is null then
        need_to_send := true; message := concat('deadline  ', message);end if;
        if student.defence is null then
        need_to_send := true; message := concat('defence  ', message);end if;
        if student.defence_queue is null then
        need_to_send := true; message := concat('defence queue  ', message);end if;
        if student.mark is null then
        need_to_send := true; message := concat('mark  ', message);end if;
        if student.order_id is null then
        need_to_send := true; message := concat('order  ', message);end if;
        if student.speciality is null or student.speciality like '--нет--' then
        need_to_send := true; message := concat('speciality  ', message);end if;
        if student.setter is null or student.setter like '--не назначен--' then
        need_to_send := true; message := concat('setter  ', message);end if;
        if student.reviewer is null or student.reviewer like '--не назначен--' then
        need_to_send := true; message := 'reviewer  '|| message; end if;
        if student.comission is null or student.comission like '--не назначен--' then
        need_to_send := true; message := concat('comission  ', message);end if;
        if student.chairman is null or student.chairman like '--не назначен--' then
        need_to_send := true; message := concat('chairman  ', message);end if;
        
        if need_to_send then
          message := concat(concat(concat('For student ', concat(student.student, concat(' ', to_char(student.diplom_id)))), ' still unmentioned: '), message);
          UTL_MAIL.send(sender     => 'smw@belstu.by',
                recipients => rec,
                cc         => null,
                bcc        => null,
                subject    => 'Diplom works',
                message    => message);
        end if;
        need_to_send := false;
        message := ' ';
        fetch stud_list into student;
      end loop;
      close stud_list;
      
    end if;
    fetch emails into sup, rec;
  end loop;
  close emails;
end supervisors_mailing;

begin
  supervisors_mailing();
end;

---------------program for job
BEGIN
DBMS_SCHEDULER.CREATE_PROGRAM (
  program_name      => 'PROG_SUPERVISORS_MAILING',
  program_action     => 'SUPERVISORS_MAILING',
  program_type      => 'STORED_PROCEDURE');
END;
---------------enable program
exec dbms_scheduler.enable('PROG_SUPERVISORS_MAILING');


BEGIN 
DBMS_SCHEDULER.DROP_PROGRAM( 
program_name => 'PROG_SUPERVISORS_MAILING', 
force => TRUE 
); 
END; 

---------------shedule
BEGIN
DBMS_SCHEDULER.CREATE_SCHEDULE (
 schedule_name   => 'my_weekly_mail_sending',
 start_date    => SYSTIMESTAMP,
 repeat_interval  => 'FREQ=WEEKLY; BYDAY=MON,WED,FRI;',
 end_date     => SYSTIMESTAMP + INTERVAL '30' day,
 comments     => 'weekly spaming');
END;

BEGIN 
DBMS_SCHEDULER.DROP_SCHEDULE( 
schedule_name => 'my_weekly_mail_sending', 
force => TRUE 
); 
END;
---------------job
BEGIN
DBMS_SCHEDULER.CREATE_JOB (
  job_name     => 'my_weekly_mail_sending_job',
  program_name   => 'PROG_SUPERVISORS_MAILING',
  schedule_name   => 'my_weekly_mail_sending');
END;
---------------enable job
exec dbms_scheduler.enable('my_weekly_mail_sending_job');



begin
DBMS_SCHEDULER.drop_job(job_name => 'my_weekly_mail_sending_job');
end;


select job_name, status, run_duration, cpu_used
from USER_SCHEDULER_JOB_RUN_DETAILS;  --05/12/2020 было 11 - во вторник должно быть 12

select *
from USER_SCHEDULER_JOB_RUN_DETAILS;

commit;

