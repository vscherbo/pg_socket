-- DROP FUNCTION arc_energo.sock_send(character varying, integer, character varying);
CREATE OR REPLACE FUNCTION arc_energo.sock_send(arg_host character varying, arg_port integer, arg_msg character varying)
 RETURNS varchar
 LANGUAGE plpython2u
AS $function$
import socket
#import time
ret = ''
sock = socket.socket()
sock.settimeout(1)
try:
    sock.connect((arg_host, arg_port))
except Exception as exc:
    ret = exc
else:
    sock.send(arg_msg.decode('utf-8').encode('cp1251'))

#time.sleep(1)
sock.close()
return ret
$function$
;
