CREATE OR REPLACE FUNCTION arc_energo.topic_msg_received(arg_msg_id integer)
 RETURNS void
 LANGUAGE sql
AS $function$
UPDATE topic_msg_queue SET delivered = array_append(delivered, inet_client_addr())
WHERE msg_id=arg_msg_id;
$function$
;
