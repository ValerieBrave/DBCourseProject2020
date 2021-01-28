create or replace package body orders_pack as
-----------------------
----------------------------------------------------------------
procedure AddOrder(num Orders.order_number%type, dat Orders.order_date%type)
is
  bad_numbers exception;
begin
  if num < 0 then raise bad_numbers; end if;
  insert into Orders(order_number, order_date) values (num, dat);
  dbms_output.put_line('������ '||num||'/'||dat||' ������� ��������');
  exception
  when bad_numbers
  then dbms_output.put_line('����� ������� �� ����� ���� �������������');
  when DUP_VAL_ON_INDEX
  then dbms_output.put_line('������ '||num||'/'||dat||' ��� ����������');
  when others
  then dbms_output.put_line(sqlerrm);
end AddOrder;
----------------------------------------------------------------
procedure EditOrder(num_old Orders.order_number%type, dat_old Orders.order_date%type, num_new Orders.order_number%type, dat_new Orders.order_date%type)
is
  test_num Orders.order_number%type;
  bad_numbers exception;
begin
  if num_old < 0 or num_new < 0 then raise bad_numbers; end if;
  select order_number into test_num from Orders where order_number like num_old and order_date like dat_old;
  update Orders
  set order_number = num_new, order_date = dat_new
  where order_number like num_old and order_date like dat_old;
  dbms_output.put_line('������ '||num_old||'/'||dat_old||' ������� �� '||num_new||'/'||dat_new);
  exception
  when bad_numbers
  then dbms_output.put_line('����� ������� �� ����� ���� �������������');
  when no_data_found 
  then  dbms_output.put_line('������ '||num_old||'/'||dat_old||' �� ������');
  when DUP_VAL_ON_INDEX 
  then dbms_output.put_line('������ '||num_new||'/'||dat_new||' ��� ����������');
  when others
  then dbms_output.put_line(sqlerrm);
end EditOrder;
----------------------------------------------------------------
procedure SetNewOrderNumber(num_old Orders.order_number%type, dat_old Orders.order_date%type, num_new Orders.order_number%type)
is
  test_num Orders.order_number%type;
  bad_numbers exception;
begin
  if num_old < 0 or num_new < 0 then raise bad_numbers; end if;
  select order_number into test_num from Orders where order_number like num_old and order_date like dat_old;
  update Orders
  set order_number = num_new
  where order_number like num_old and order_date like dat_old;
  dbms_output.put_line('������ '||num_old||'/'||dat_old||' ������� �� '||num_new||'/'||dat_old);
  exception
  when bad_numbers
  then dbms_output.put_line('����� ������� �� ����� ���� �������������');
  when no_data_found 
  then  dbms_output.put_line('������ '||num_old||'/'||dat_old||' �� ������');
  when DUP_VAL_ON_INDEX 
  then dbms_output.put_line('������ '||num_new||'/'||dat_old||' ��� ����������');
  when others
  then dbms_output.put_line(sqlerrm);
end SetNewOrderNumber;
----------------------------------------------------------------
procedure SetNewOrderDate(num_old Orders.order_number%type, dat_old Orders.order_date%type, dat_new Orders.order_date%type)
is
  test_num Orders.order_number%type;
  bad_numbers exception;
begin
  if num_old < 0  then raise bad_numbers; end if;
  select order_number into test_num from Orders where order_number like num_old and order_date like dat_old;
  update Orders
  set order_date = dat_new
  where order_number like num_old and order_date like dat_old;
  dbms_output.put_line('������ '||num_old||'/'||dat_old||' ������� �� '||num_old||'/'||dat_new);
  exception
  when bad_numbers
  then dbms_output.put_line('����� ������� �� ����� ���� �������������');
  when no_data_found 
  then  dbms_output.put_line('������ '||num_old||'/'||dat_old||' �� ������');
  when DUP_VAL_ON_INDEX 
  then dbms_output.put_line('������ '||num_old||'/'||dat_new||' ��� ����������');
  when others
  then dbms_output.put_line(sqlerrm);
end SetNewOrderDate;
----------------------------------------------------------------
procedure DeleteOrder(num Orders.order_number%type, dat Orders.order_date%type)
is
  test_num Orders.order_number%type;
  bad_numbers exception;
begin
  if num < 0  then raise bad_numbers; end if;
  select order_number into test_num from Orders where order_number like num and order_date like dat;
  delete Orders 
  where order_number like num and order_date like dat;
  dbms_output.put_line('������ '||num||'/'||dat||' ������');
  exception
  when bad_numbers
  then dbms_output.put_line('����� ������� �� ����� ���� �������������');
  when no_data_found 
  then  dbms_output.put_line('������ '||num||'/'||dat||' �� ������');
end DeleteOrder;
----------------------------------------------------------------
function CountOrders 
return number
is
  num integer;
begin
  select count(*) into num from Orders;
  return num;
end CountOrders;
----------------------------------------------------------------
-----------------------
end orders_pack;