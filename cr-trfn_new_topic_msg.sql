CREATE OR REPLACE FUNCTION arc_energo.new_topic_msg()
 RETURNS trigger
 LANGUAGE plpgsql
AS $function$
DECLARE 
loc_port integer;
host_to text;
rec RECORD;
res varchar;
BEGIN
SELECT port INTO loc_port FROM arc_energo.topic WHERE tag = NEW.tag;

    FOR rec IN SELECT tag, ip FROM arc_energo.topic_subs WHERE tag = NEW.tag
    LOOP
        host_to := host(rec.ip);
        -- res := NULLIF(sock_send(host_to, loc_port, NEW.msg_id::varchar), '');
        res := sock_send(host_to, loc_port, NEW.msg_id::varchar);
        INSERT INTO arc_energo.topic_msg_queue(ip, msg_id, status, sent_result)
        VALUES(rec.ip, NEW.msg_id, 
            CASE WHEN res='' THEN 10 ELSE 20 END,
            res);
    END LOOP;
RETURN NEW;
END;
$function$
;
