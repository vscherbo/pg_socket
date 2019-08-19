CREATE OR REPLACE FUNCTION arc_energo.new_topic_msg()
 RETURNS trigger
 LANGUAGE plpgsql
AS $function$
DECLARE 
loc_port integer;
host_to varchar;
rec RECORD;
res varchar;
loc_status integer := 0;
loc_dt timestamp; -- without timezone;
BEGIN
SELECT port INTO loc_port FROM arc_energo.topic WHERE tag = NEW.tag;

    FOR rec IN SELECT tag, ip FROM arc_energo.topic_subs WHERE tag = NEW.tag
    LOOP
        host_to = host(rec.ip);
        res := sock_send(host_to, loc_port, NEW.msg_id::varchar);
        IF res <> '' THEN
            loc_status := GREATEST(loc_status, 20);
            INSERT INTO arc_energo.topic_msg_log(msg_id, msg_log)
            VALUES(NEW.msg_id, format('ошибка отправки [%s] host_to=%s', res, host_to));
        ELSE
            loc_status := GREATEST(loc_status, 10);
            UPDATE arc_energo.topic_subs SET last_msg_id=NEW.msg_id WHERE tag=rec.tag AND ip = rec.ip;    
        END IF;
    END LOOP;
    UPDATE arc_energo.topic_msg_queue SET dt_sent=now(), status=loc_status WHERE msg_id=NEW.msg_id;
RETURN NEW;
END;
$function$
;
