create or replace package body diploms_pack as
-----------------------
----------------------------------------------------------------
procedure AddStudent(stud Diploms.student%type, spec Diploms.speciality%type)
is
  correct Diploms.student%type;
  corr_s Diploms.speciality%type;
begin
  correct := trim(stud);
  corr_s := trim(spec);
  insert into Diploms(student, topic, diplom_form, 
  deadline, defence, defence_queue, mark, order_id, speciality, 
  supervisor, setter, reviewer, comission, chairman)
  values(correct, null, null, null, null, null, null, null, corr_s, null, null, null, null, null);
  dbms_output.put_line('Студент '|| correct || ' добавлен');
  exception
  when others
  then dbms_output.put_line(sqlerrm);
        dbms_output.put_line('Проверьте специальность');
end AddStudent;
----------------------------------------------------------------
procedure SetSupervisor(stud Diploms.student%type, sup Diploms.supervisor%type, i Diploms.diplom_id%type default null)
is
  corr_stud Diploms.student%type;
  corr_sup Diploms.supervisor%type;
  for_search Diploms.student%type;
  for_search_sup Diploms.supervisor%type;
  test_s Diploms.student%type;
  test_sup Diploms.supervisor%type;
  test_i Diploms.diplom_id%type;
  type curtype is ref cursor;
  cur curtype;
  stud_c Diploms.student%type;
  id_c Diploms.diplom_id%type;
  spec_c Diploms.speciality%type;
  stud_found boolean := false;
  dip_found boolean := false;
begin
  corr_stud := trim(stud);
  corr_sup := trim(sup);
  for_search := concat('%', concat(corr_stud, '%'));
  for_search_sup := concat('%', concat(corr_sup, '%'));
 
  if i is not null then
    stud_found := true;
    select diplom_id into test_i from Diploms where diplom_id like i;
    dip_found := true;
     select supervisor into test_sup from Supervisors where supervisor like for_search_sup;
    update Diploms
    set supervisor = test_sup
    where diplom_id like i;
    dbms_output.put_line('Студенту '||corr_stud||' назначен руководитель '||corr_sup);
  else 
    select student into test_s from Diploms where student like for_search;
    stud_found := true;
    dip_found:= true;
    select supervisor into test_sup from Supervisors where supervisor like for_search_sup;
    update Diploms
    set supervisor = test_sup
    where student like for_search; 
    dbms_output.put_line('Студенту '||corr_stud||' назначен руководитель '||corr_sup);
  end if;
  exception
  when no_data_found then 
    if not stud_found then dbms_output.put_line('Студент '||corr_stud||' не найден');
    elsif not dip_found then dbms_output.put_line('Диплом с ID '||i||' не найден');
    else dbms_output.put_line('Руководитель '||corr_sup||' не найден'); end if;
  when too_many_rows then
    dbms_output.put_line('Обнаружено несколько совпадений - уточните ID: ');
    open cur for select diplom_id, student, speciality from Diploms where student like for_search;
    fetch cur into id_c, stud_c, spec_c;
    while(cur%found)
      loop
        dbms_output.put_line('ID: '||id_c||', '||stud_c||', '||spec_c);
        fetch cur into id_c, stud_c, spec_c;
      end loop;
    close cur;
end SetSupervisor;
----------------------------------------------------------------
procedure SetSetter(stud Diploms.student%type, sett Diploms.setter%type, i Diploms.diplom_id%type default null)
is
  corr_stud Diploms.student%type;
  corr_sett Diploms.setter%type;
  for_search Diploms.student%type;
  for_search_sett Diploms.setter%type;
  test_s Diploms.student%type;
  test_sett Diploms.setter%type;
  test_i Diploms.diplom_id%type;
  type curtype is ref cursor;
  cur curtype;
  stud_c Diploms.student%type;
  id_c Diploms.diplom_id%type;
  spec_c Diploms.speciality%type;
  stud_found boolean := false;
  dip_found boolean := false;
begin
  corr_stud := trim(stud);
  corr_sett := trim(sett);
  for_search := concat('%', concat(corr_stud, '%'));
  for_search_sett := concat('%', concat(corr_sett, '%'));
   if i is not null then
    stud_found := true;
    select diplom_id into test_i from Diploms where diplom_id like i;
    dip_found := true;
     select setter into test_sett from Setters where setter like for_search_sett;
    update Diploms
    set setter = test_sett
    where diplom_id like i;
    dbms_output.put_line('Студенту '||corr_stud||' назначен нормоконтролер '||corr_sett);
   else
    select student into test_s from Diploms where student like for_search;
    stud_found := true;
    dip_found:= true;
    select setter into test_sett from Setters where setter like for_search_sett;
    update Diploms
    set setter = test_sett
    where student like for_search; 
    dbms_output.put_line('Студенту '||corr_stud||' назначен нормоконтролер '||corr_sett);
   end if;
   
   exception
   when no_data_found then 
    if not stud_found then dbms_output.put_line('Студент '||corr_stud||' не найден');
    elsif not dip_found then dbms_output.put_line('Диплом с ID '||i||' не найден');
    else dbms_output.put_line('Руководитель '||corr_sett||' не найден'); end if;
  when too_many_rows then
    dbms_output.put_line('Обнаружено несколько совпадений - уточните ID: ');
    open cur for select diplom_id, student, speciality from Diploms where student like for_search;
    fetch cur into id_c, stud_c, spec_c;
    while(cur%found)
      loop
        dbms_output.put_line('ID: '||id_c||', '||stud_c||', '||spec_c);
        fetch cur into id_c, stud_c, spec_c;
      end loop;
    close cur;
end SetSetter;
----------------------------------------------------------------
procedure SetReviewer(stud Diploms.student%type, rev Diploms.reviewer%type, i Diploms.diplom_id%type default null)
is
  corr_stud Diploms.student%type;
  corr_rev Diploms.reviewer%type;
  for_search Diploms.student%type;
  for_search_rev Diploms.reviewer%type;
  test_s Diploms.student%type;
  test_rev Diploms.reviewer%type;
  test_i Diploms.diplom_id%type;
  type curtype is ref cursor;
  cur curtype;
  stud_c Diploms.student%type;
  id_c Diploms.diplom_id%type;
  spec_c Diploms.speciality%type;
  stud_found boolean := false;
  dip_found boolean := false;
begin
  corr_stud := trim(stud);
  corr_rev := trim(rev);
  for_search := concat('%', concat(corr_stud, '%'));
  for_search_rev := concat('%', concat(corr_rev, '%'));
   if i is not null then
    stud_found := true;
    select diplom_id into test_i from Diploms where diplom_id like i;
    dip_found := true;
     select reviewer into test_rev from reviewers where reviewer like for_search_rev;
    update Diploms
    set reviewer = test_rev
    where diplom_id like i;
    dbms_output.put_line('Студенту '||corr_stud||' назначен рецензент '||corr_rev);
   else
    select student into test_s from Diploms where student like for_search;
    stud_found := true;
    dip_found:= true;
    select reviewer into test_rev from reviewers where reviewer like for_search_rev;
    update Diploms
    set reviewer = test_rev
    where student like for_search; 
    dbms_output.put_line('Студенту '||corr_stud||' назначен рецензент '||corr_rev);
   end if;
   
   exception
   when no_data_found then 
    if not stud_found then dbms_output.put_line('Студент '||corr_stud||' не найден');
    elsif not dip_found then dbms_output.put_line('Диплом с ID '||i||' не найден');
    else dbms_output.put_line('Рецензент '||corr_rev||' не найден'); end if;
  when too_many_rows then
    dbms_output.put_line('Обнаружено несколько совпадений - уточните ID: ');
    open cur for select diplom_id, student, speciality from Diploms where student like for_search;
    fetch cur into id_c, stud_c, spec_c;
    while(cur%found)
      loop
        dbms_output.put_line('ID: '||id_c||', '||stud_c||', '||spec_c);
        fetch cur into id_c, stud_c, spec_c;
      end loop;
    close cur;
end SetReviewer;
----------------------------------------------------------------
procedure SetComission(stud Diploms.student%type, com diploms.comission%type, i Diploms.diplom_id%type default null)
is
  corr_stud Diploms.student%type;
  corr_com Diploms.comission%type;
  for_search Diploms.student%type;
  for_search_com Diploms.comission%type;
  test_s Diploms.student%type;
  test_com Diploms.comission%type;
  test_i Diploms.diplom_id%type;
  type curtype is ref cursor;
  cur curtype;
  stud_c Diploms.student%type;
  id_c Diploms.diplom_id%type;
  spec_c Diploms.speciality%type;
  stud_found boolean := false;
  dip_found boolean := false;
begin
  corr_stud := trim(stud);
  corr_com := trim(com);
  for_search := concat('%', concat(corr_stud, '%'));
  for_search_com := concat('%', concat(corr_com, '%'));
   if i is not null then
    stud_found := true;
    select diplom_id into test_i from Diploms where diplom_id like i;
    dip_found := true;
     select comission into test_com from comissions where comission like for_search_com;
    update Diploms
    set comission = test_com
    where diplom_id like i;
    dbms_output.put_line('Студенту '||corr_stud||' назначена комиссия:  '||test_com);
   else
    select student into test_s from Diploms where student like for_search;
    stud_found := true;
    dip_found:= true;
    select comission into test_com from comissions where comission like for_search_com;
    update Diploms
    set comission = test_com
    where student like test_s; 
    dbms_output.put_line('Студенту '||corr_stud||' назначена комиссия: '||test_com);
   end if;
   
   exception
   when no_data_found then 
    if not stud_found then dbms_output.put_line('Студент '||corr_stud||' не найден');
    elsif not dip_found then dbms_output.put_line('Диплом с ID '||i||' не найден');
    else dbms_output.put_line('Комиссия '||corr_com||' не найдена'); end if;
  when too_many_rows then
    dbms_output.put_line('Обнаружено несколько совпадений - уточните ID: ');
    open cur for select diplom_id, student, speciality from Diploms where student like for_search;
    fetch cur into id_c, stud_c, spec_c;
    while(cur%found)
      loop
        dbms_output.put_line('ID: '||id_c||', '||stud_c||', '||spec_c);
        fetch cur into id_c, stud_c, spec_c;
      end loop;
    close cur;
end SetComission;
----------------------------------------------------------------
procedure SetChairman(stud Diploms.student%type, ch diploms.chairman%type, i Diploms.diplom_id%type default null)
is
  corr_stud Diploms.student%type;
  corr_ch Diploms.chairman%type;
  for_search Diploms.student%type;
  for_search_ch Diploms.chairman%type;
  test_s Diploms.student%type;
  test_ch Diploms.chairman%type;
  test_i Diploms.diplom_id%type;
  type curtype is ref cursor;
  cur curtype;
  stud_c Diploms.student%type;
  id_c Diploms.diplom_id%type;
  spec_c Diploms.speciality%type;
  stud_found boolean := false;
  dip_found boolean := false;
begin
  corr_stud := trim(stud);
  corr_ch := trim(ch);
  for_search := concat('%', concat(corr_stud, '%'));
  for_search_ch := concat('%', concat(corr_ch, '%'));
  if i is not null then
    stud_found := true;
    select diplom_id into test_i from Diploms where diplom_id like i;
    dip_found := true;
    select chairman into test_ch from chairmen where chairman like for_search_ch;
    update Diploms
    set chairman = test_ch
    where diplom_id like i;
    dbms_output.put_line('Студенту '||corr_stud||' назначен председатель ГЭК:  '||test_ch);
   else
    select student into test_s from Diploms where student like for_search;
    stud_found := true;
    dip_found:= true;
    select chairman into test_ch from chairmen where chairman like for_search_ch;
    update Diploms
    set chairman = test_ch
    where student like test_s; 
    dbms_output.put_line('Студенту '||corr_stud||' назначен председатель ГЭК: '||test_ch);
   end if;
   
   exception
   when no_data_found then 
    if not stud_found then dbms_output.put_line('Студент '||corr_stud||' не найден');
    elsif not dip_found then dbms_output.put_line('Диплом с ID '||i||' не найден');
    else dbms_output.put_line('Председатель ГЭК  '||corr_ch||' не найден'); end if;
  when too_many_rows then
    dbms_output.put_line('Обнаружено несколько совпадений - уточните ID: ');
    open cur for select diplom_id, student, speciality from Diploms where student like for_search;
    fetch cur into id_c, stud_c, spec_c;
    while(cur%found)
      loop
        dbms_output.put_line('ID: '||id_c||', '||stud_c||', '||spec_c);
        fetch cur into id_c, stud_c, spec_c;
      end loop;
    close cur;
end SetChairman;
----------------------------------------------------------------
procedure ChangeSpeciality(stud Diploms.student%type, spec Diploms.speciality%type, i Diploms.diplom_id%type default null)
is
  corr_stud Diploms.student%type;
  corr_spec Diploms.speciality%type;
  for_search Diploms.student%type;
  for_search_spec Diploms.speciality%type;
  test_s Diploms.student%type;
  test_spec Diploms.speciality%type;
  test_i Diploms.diplom_id%type;
  type curtype is ref cursor;
  cur curtype;
  stud_c Diploms.student%type;
  id_c Diploms.diplom_id%type;
  spec_c Diploms.speciality%type;
  stud_found boolean := false;
  dip_found boolean := false;
begin
  corr_stud := trim(stud);
  corr_spec := trim(spec);
  for_search := concat('%', concat(corr_stud, '%'));
  for_search_spec := concat('%', concat(corr_spec, '%'));
  if i is not null then
    stud_found := true;
    select diplom_id into test_i from Diploms where diplom_id like i;
    dip_found := true;
    select speciality into test_spec from specialities where speciality like for_search_spec;
    update Diploms
    set speciality = test_spec
    where diplom_id like i;
    dbms_output.put_line('Студенту '||corr_stud||' изменена специальность:  '||test_spec);
  else
    select student into test_s from Diploms where student like for_search;
    stud_found := true;
    dip_found:= true;
   select speciality into test_spec from specialities where speciality like for_search_spec;
    update Diploms
    set speciality = test_spec
    where student like test_s; 
    dbms_output.put_line('Студенту '||corr_stud||' изменена специальность:  '||test_spec);
  end if;
  
  exception
   when no_data_found then 
    if not stud_found then dbms_output.put_line('Студент '||corr_stud||' не найден');
    elsif not dip_found then dbms_output.put_line('Диплом с ID '||i||' не найден');
    else dbms_output.put_line('Специальность  '||corr_spec||' не найдена'); end if;
  when too_many_rows then
    dbms_output.put_line('Обнаружено несколько совпадений - уточните ID: ');
    open cur for select diplom_id, student, speciality from Diploms where student like for_search;
    fetch cur into id_c, stud_c, spec_c;
    while(cur%found)
      loop
        dbms_output.put_line('ID: '||id_c||', '||stud_c||', '||spec_c);
        fetch cur into id_c, stud_c, spec_c;
      end loop;
    close cur;
end;
----------------------------------------------------------------
procedure SetOrder(stud Diploms.student%type, or_num Orders.order_number%type, or_dat Orders.order_date%type, i Diploms.diplom_id%type default null)
is
  corr_stud Diploms.student%type;
  for_search Diploms.student%type;
  order_idt Diploms.order_id%type;
  test_s Diploms.student%type;
  test_spec Diploms.speciality%type;
  test_i Diploms.diplom_id%type;
  test_num Orders.order_number%type;
  test_dat Orders.order_date%type;
  stud_found boolean := false;
  order_found boolean := false;
  type curtype is ref cursor;
  cur curtype;
  stud_c Diploms.student%type;
  id_c Diploms.diplom_id%type;
  spec_c Diploms.speciality%type;
begin
  corr_stud := trim(stud);
  for_search := concat('%', concat(corr_stud, '%'));
  if i is not null then
    stud_found:= true;
    select order_number, order_date into test_num, test_dat from Orders where order_number = or_num and order_date = or_dat;
    order_found := true;
    select diplom_id into test_i from Diploms where diplom_id like i;
    order_idt := concat(to_char(or_num), to_char(or_dat));
    update Diploms
    set order_id = order_idt
    where diplom_id like i;
  else
    select student into test_s from Diploms where student like for_search;
    stud_found:= true;
    select order_number, order_date into test_num, test_dat from Orders where order_number = or_num and order_date = or_dat;
    order_found := true;
    order_idt := concat(to_char(or_num), concat('/', to_char(or_dat)));
    update Diploms
    set order_id = order_idt
    where student like test_s;
  end if;
  dbms_output.put_line('Студенту '||corr_stud||' назначен приказ '||order_idt);
  exception
  when no_data_found then
    if stud_found and not order_found then dbms_output.put_line('Приказ '||or_num||'/'||or_dat||' не найден'); end if;
    if not stud_found and not order_found then dbms_output.put_line('Студент '||corr_stud||' не найден'); end if;
    if stud_found and order_found then  dbms_output.put_line('Диплом с ID '||i||' не найден'); end if;
   when too_many_rows then
    dbms_output.put_line('Обнаружено несколько совпадений - уточните ID: ');
    open cur for select diplom_id, student, speciality from Diploms where student like for_search;
    fetch cur into id_c, stud_c, spec_c;
    while(cur%found)
      loop
        dbms_output.put_line('ID: '||id_c||', '||stud_c||', '||spec_c);
        fetch cur into id_c, stud_c, spec_c;
      end loop;
    close cur;
  when others then dbms_output.put_line(sqlerrm);
end SetOrder;
----------------------------------------------------------------
procedure SetTopic(stud Diploms.student%type, topic Diploms.topic%type, format Diploms.diplom_form%type, i Diploms.diplom_id%type default null)
is
  corr_stud Diploms.student%type;
  for_search Diploms.student%type;
  corr_topic Diploms.topic%type;
  test_s Diploms.student%type;
  
  test_i Diploms.diplom_id%type;
  stud_found boolean := false;
  type curtype is ref cursor;
  cur curtype;
  stud_c Diploms.student%type;
  id_c Diploms.diplom_id%type;
  spec_c Diploms.speciality%type;
  
  wrong_format exception;
begin
  corr_stud := trim(stud);
  corr_topic := trim(topic);
  for_search :=concat('%', concat(corr_stud, '%'));
  if i is not null then
    stud_found:= true;
    select diplom_id into test_i from Diploms where diplom_id like i;
    if lower(format) = 'р' or lower(format) = 'п' then
      update Diploms
      set topic = corr_topic, diplom_form = lower(format)
      where diplom_id like test_i;
    else raise wrong_format; end if;
  else
    select student into test_s from Diploms where student like for_search;
    stud_found := true;
    if lower(format) ='р' or lower(format) ='п' then
      update Diploms
      set topic = corr_topic, diplom_form = lower(format)
      where student like test_s;
    else raise wrong_format; end if;
  end if;
  dbms_output.put_line('Студенту '||corr_stud||' назначена тема '||topic);
  exception
  when no_data_found then
    if stud_found then dbms_output.put_line('Диплом с ID '||i||' не найден'); end if;
    if not stud_found then dbms_output.put_line('Студент '||corr_stud||' не найден'); end if;
  when wrong_format then dbms_output.put_line('Формат должен быть вида: р(работа), п(проект)');
   when too_many_rows then
    dbms_output.put_line('Обнаружено несколько совпадений - уточните ID: ');
    open cur for select diplom_id, student, speciality from Diploms where student like for_search;
    fetch cur into id_c, stud_c, spec_c;
    while(cur%found)
      loop
        dbms_output.put_line('ID: '||id_c||', '||stud_c||', '||spec_c);
        fetch cur into id_c, stud_c, spec_c;
      end loop;
    close cur;
  when others then dbms_output.put_line(sqlerrm);
end SetTopic;
----------------------------------------------------------------
procedure SetDeadline(stud Diploms.student%type, dline Diploms.deadline%type, i Diploms.diplom_id%type default null)
is
  corr_stud Diploms.student%type;
  for_search Diploms.student%type;
  test_i Diploms.diplom_id%type;
  test_s Diploms.student%type;
  stud_found boolean := false;
  test_def Diploms.defence%type;
  type curtype is ref cursor;
  cur curtype;
  stud_c Diploms.student%type;
  id_c Diploms.diplom_id%type;
  spec_c Diploms.speciality%type;
  bad_date exception;
begin
  corr_stud := trim(stud);
  for_search :=concat('%', concat(corr_stud, '%'));
  if i is not null then
    stud_found:= true;
    select diplom_id, defence into test_i, test_def from Diploms where diplom_id like i;
    if test_def is null then
      update Diploms
      set deadline = dline
      where diplom_id like test_i;
     else
      if test_def <= dline then raise bad_date; end if;
        update Diploms
        set deadline = dline
        where diplom_id like test_i;
     end if;
  else
    select student, defence into test_s, test_def from Diploms where student like for_search;
    stud_found := true;
    if test_def is null then
      update Diploms
      set deadline = dline
      where student like test_s;
     else
      if test_def <= dline then raise bad_date; end if;
      update Diploms
      set deadline = dline
      where student like test_s;
     end if;
  end if;
  dbms_output.put_line('Студенту '||corr_stud||' назначен срок сдачи '||dline);
  exception
  when no_data_found then
    if stud_found then dbms_output.put_line('Диплом с ID '||i||' не найден'); end if;
    if not stud_found then dbms_output.put_line('Студент '||corr_stud||' не найден'); end if;
  when bad_date then dbms_output.put_line('Срок сдачи не может быть раньше защиты :'||test_def);
  when too_many_rows then
    dbms_output.put_line('Обнаружено несколько совпадений - уточните ID: ');
    open cur for select diplom_id, student, speciality from Diploms where student like for_search;
    fetch cur into id_c, stud_c, spec_c;
    while(cur%found)
      loop
        dbms_output.put_line('ID: '||id_c||', '||stud_c||', '||spec_c);
        fetch cur into id_c, stud_c, spec_c;
      end loop;
    close cur;
  when others then dbms_output.put_line(sqlerrm);
end SetDeadline;
----------------------------------------------------------------
procedure SetDefence (stud Diploms.student%type, def Diploms.defence%type, qu diploms.defence_queue%type, i Diploms.diplom_id%type default null)
is
  corr_stud Diploms.student%type;
  for_search Diploms.student%type;
  test_i Diploms.diplom_id%type;
  test_s Diploms.student%type;
  stud_found boolean := false;
  test_dline Diploms.deadline%type;
  type curtype is ref cursor;
  cur curtype;
  stud_c Diploms.student%type;
  id_c Diploms.diplom_id%type;
  spec_c Diploms.speciality%type;
  bad_date exception;
  bad_qu exception;
begin
  if qu <=0 then raise bad_qu; end if;
  corr_stud := trim(stud);
  for_search :=concat('%', concat(corr_stud, '%'));
  if i is not null then
    stud_found:= true;
    select diplom_id, deadline into test_i, test_dline from Diploms where diplom_id like i;
    if test_dline is null then
      update Diploms
      set defence = def, defence_queue = qu
      where diplom_id like test_i;
     else
      if test_dline >= def then raise bad_date; end if;
        update Diploms
        set defence = def, defence_queue = qu
        where diplom_id like test_i;
     end if;
  else
    select student, deadline into test_s, test_dline from Diploms where student like for_search;
    stud_found := true;
    if test_dline is null then
      update Diploms
      set defence = def, defence_queue = qu
      where student like test_s;
     else
      if test_dline >= def then raise bad_date; end if;
        update Diploms
        set defence = def, defence_queue = qu
        where student like test_s;
     end if;
  end if;
  dbms_output.put_line('Студенту '||corr_stud||' назначен срок защиты '||def);
  exception
  when bad_qu then dbms_output.put_line('Очередь отсчитывается с 1');
  when no_data_found then
    if stud_found then dbms_output.put_line('Диплом с ID '||i||' не найден'); end if;
    if not stud_found then dbms_output.put_line('Студент '||corr_stud||' не найден'); end if;
  when bad_date then dbms_output.put_line('Срок защиты не может быть раньше сдачи :'||test_dline);
  when too_many_rows then
    dbms_output.put_line('Обнаружено несколько совпадений - уточните ID: ');
    open cur for select diplom_id, student, speciality from Diploms where student like for_search;
    fetch cur into id_c, stud_c, spec_c;
    while(cur%found)
      loop
        dbms_output.put_line('ID: '||id_c||', '||stud_c||', '||spec_c);
        fetch cur into id_c, stud_c, spec_c;
      end loop;
    close cur;
  when others then dbms_output.put_line(sqlerrm);
end SetDefence;
----------------------------------------------------------------
procedure SetMark(stud Diploms.student%type, mk Diploms.mark%type, i Diploms.diplom_id%type default null)
is
  corr_stud Diploms.student%type;
  for_search Diploms.student%type;
  test_i Diploms.diplom_id%type;
  test_s Diploms.student%type;
  stud_found boolean := false;
  type curtype is ref cursor;
  cur curtype;
  stud_c Diploms.student%type;
  id_c Diploms.diplom_id%type;
  spec_c Diploms.speciality%type;
  bad_mark exception;
begin
  if mk < 1 or mk > 10 then raise bad_mark; end if;
  corr_stud := trim(stud);
  for_search :=concat('%', concat(corr_stud, '%'));
  if i is not null then
    stud_found:= true;
    select diplom_id into test_i from Diploms where diplom_id like i;
    update Diploms
    set mark = mk
    where diplom_id like test_i;
  else
    select student into test_s from Diploms where student like for_search;
    stud_found := true;
    update Diploms
    set mark = mk
    where student like test_s;
  end if;
  dbms_output.put_line('Студенту ' || corr_stud||' выставлена оценка '|| mk);
  exception
  when bad_mark then dbms_output.put_line('Оценка должна быть в пределах 1-10');
  when no_data_found then
    if stud_found then dbms_output.put_line('Диплом с ID '||i||' не найден'); end if;
    if not stud_found then dbms_output.put_line('Студент '||corr_stud||' не найден'); end if;
  when too_many_rows then
    dbms_output.put_line('Обнаружено несколько совпадений - уточните ID: ');
    open cur for select diplom_id, student, speciality from Diploms where student like for_search;
    fetch cur into id_c, stud_c, spec_c;
    while(cur%found)
      loop
        dbms_output.put_line('ID: '||id_c||', '||stud_c||', '||spec_c);
        fetch cur into id_c, stud_c, spec_c;
      end loop;
    close cur;
  when others then dbms_output.put_line(sqlerrm);
end SetMark;
--------------------------------------------------------------
procedure DeleteStudent(stud Diploms.student%type, i Diploms.diplom_id%type default null)
is
  corr_stud Diploms.student%type;
  for_search Diploms.student%type;
  test_s Diploms.student%type;
  test_i Diploms.diplom_id%type;
  stud_found boolean := false;
  type curtype is ref cursor;
  cur curtype;
  stud_c Diploms.student%type;
  id_c Diploms.diplom_id%type;
  spec_c Diploms.speciality%type;
begin
  corr_stud := trim(stud);
  for_search :=concat('%', concat(corr_stud, '%'));
  if i is not null then
    stud_found := true;
    select diplom_id into test_i from Diploms where diplom_id like i;
    delete Diploms where diplom_id like test_i; 
  else
    select student into test_s from Diploms where student like for_search;
    stud_found := true;
    delete Diploms where student like test_s;
  end if;
  dbms_output.put_line('Студент '||corr_stud||' удален');
  exception
  when no_data_found then
    if stud_found then dbms_output.put_line('Диплом с ID '||i||' не найден'); end if;
    if not stud_found then dbms_output.put_line('Студент '||corr_stud||' не найден'); end if;
  when too_many_rows then
    dbms_output.put_line('Обнаружено несколько совпадений - уточните ID: ');
    open cur for select diplom_id, student, speciality from Diploms where student like for_search;
    fetch cur into id_c, stud_c, spec_c;
    while(cur%found)
      loop
        dbms_output.put_line('ID: '||id_c||', '||stud_c||', '||spec_c);
        fetch cur into id_c, stud_c, spec_c;
      end loop;
    close cur;
  when others then dbms_output.put_line(sqlerrm);
end DeleteStudent;
----------------------------------------------------------------
-----------------------
end diploms_pack;