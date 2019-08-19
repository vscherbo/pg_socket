CREATE OR REPLACE FUNCTION arc_energo.topic_send(arg_msg_id integer)
 RETURNS character varying
 LANGUAGE plpgsql
AS $function$
DECLARE 
loc_msg record;
rec RECORD;
res varchar;
BEGIN
SELECT *, t.port INTO loc_msg FROM arc_energo.topic_msg_queue q 
JOIN arc_energo.topic t ON t.tag = loc_msg.tag
WHERE q.id=arg_msg_id;
IF FOUND THEN 
    FOR rec IN SELECT host(s.ip) AS host_to FROM arc_energo.topic_subs s WHERE tag = arg_topic_tag
    LOOP
        -- res := sock_send(host_to, loc_msg.port, loc_msg.msg);
        res := sock_send(host_to, loc_msg.port, arg_msg_id);
        IF res <> '' THEN
            INSERT INTO arc_energo.topic_msg_log(msg_id, msg_log)
            VALUES(arg_msg_id, format('ошибка отправки host_to=%s', host_to));
        END IF;
    END LOOP;
ELSE 
    INSERT INTO arc_energo.topic_msg_log(msg_id, msg_log)
    VALUES(arg_msg_id, 'сообщение не найдено');
END IF;
END
$function$
;
