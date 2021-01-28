BEGIN
  UTL_MAIL.send(sender     => 'smw@belstu.by',
                recipients => 'smw60@diskstation.belstu.by',
                cc         => null,
                bcc        => null,
                subject    => 'UTL_MAIL Test',
                message    => 'sent from system');
END;
 ALTER SYSTEM SET smtp_out_server='diskstation.belstu.by:25';
show parameter smtp_out_server
---execute as sys
