--source_dir
---------------¬ ›“ŒÃ ‘¿…À≈ ﬂ œ–Œ¬≈–ﬂﬁ — –»œ“€ »« “”“Œ–»¿ÀŒ¬
--------------------------------------------------------------
CREATE TABLE t (doc clob)
  ORGANIZATION EXTERNAL
    (
    TYPE ORACLE_LOADER
    DEFAULT DIRECTORY source_dir
    ACCESS PARAMETERS
    (   )
   LOCATION ('students.txt')
   )
   REJECT LIMIT UNLIMITED;
   drop table t;
   --drop table Diploms;
   commit;
select count(*) from t;
select count(*) from Diploms order by diplom_id desc;

declare
  cursor clob_studs is select distinct concat(to_char(doc), ' xxx') from t;
  stud clob;
  s Diploms.student%type;
  i number :=1;
begin
  open clob_studs;
  fetch clob_studs into stud;
  while clob_studs%found
    loop
      s := to_char(stud);
      if mod(i,2) = 0 then diploms_pack.AddStudent(s, '»—Ë“');
      elsif mod(i, 3) = 0 then diploms_pack.AddStudent(s, 'œŒ»“');
      elsif mod(i, 5) = 0 then diploms_pack.AddStudent(s, 'œŒ»¡Ã—');
      else diploms_pack.AddStudent(s, 'ƒ›Ë¬»'); end if;
      fetch clob_studs into stud;
      i := i+1;
    end loop;
  close clob_studs;
end;
commit;


