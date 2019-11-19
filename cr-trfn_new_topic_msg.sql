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

    FOR rec IN SELECT tag, ip, err_cnt FROM arc_energo.topic_subs WHERE tag = NEW.tag AND (err_cnt < 3 OR err_cnt IS NULL)
    LOOP
        host_to := host(rec.ip);
        -- res := NULLIF(sock_send(host_to, loc_port, NEW.msg_id::varchar), '');
        res := sock_send(host_to, loc_port, NEW.msg_id::varchar);
        IF res = '' THEN
            UPDATE arc_energo.topic_subs SET err_cnt = 0 WHERE tag = rec.tag AND ip = rec.ip;
        ELSIF res LIKE '%timed out%' THEN
            UPDATE arc_energo.topic_subs SET err_cnt = COALESCE(rec.err_cnt, 0) + 1 WHERE tag = rec.tag AND ip = rec.ip;
        END IF;

        INSERT INTO arc_energo.topic_msg_queue(ip, msg_id, status, sent_result)
        VALUES(rec.ip, NEW.msg_id, 
            CASE WHEN res='' THEN 10 ELSE 20 END,
            res);
    END LOOP;
RETURN NEW;
END;
$function$
;
