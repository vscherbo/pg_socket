CREATE OR REPLACE FUNCTION arc_energo.topic_msg_received(arg_msg_id integer)
 RETURNS void
 LANGUAGE sql
AS $function$
INSERT INTO arc_energo.topic_msg_queue(ip, msg_id, dt_delivered, status, sent_result)
        VALUES(inet_client_addr(), arg_msg_id, clock_timestamp(), 90, 'before queued') 
ON CONFLICT (ip, msg_id) DO UPDATE SET dt_delivered = clock_timestamp(), status=90;
/**
UPDATE topic_msg_queue SET dt_delivered = clock_timestamp(), status=90
WHERE msg_id=arg_msg_id and ip = inet_client_addr() ;
**/
$function$
;
