BEGIN
  DBMS_NETWORK_ACL_ADMIN.create_acl (
    acl          => 'dept_head_email.xml', 
    description  => 'Email for DEPT_HEAD',
    principal    => 'DEPT_HEAD',
    is_grant     => TRUE, 
    privilege    => 'connect',
    start_date   => SYSTIMESTAMP,
    end_date     => NULL);

  COMMIT;
END;

BEGIN
  DBMS_NETWORK_ACL_ADMIN.assign_acl (
    acl => 'dept_head_email.xml',
    host => 'diskstation.belstu.by', 
    lower_port => 25,
    upper_port => 25); 
  COMMIT;
END;