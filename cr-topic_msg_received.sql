CREATE OR REPLACE FUNCTION arc_energo.topic_msg_received(arg_msg_id integer)
 RETURNS void
 LANGUAGE sql
AS $function$
UPDATE topic_msg_queue SET dt_delivered = clock_timestamp(), status=90
WHERE msg_id=arg_msg_id and ip = inet_client_addr() ;
$function$
;
