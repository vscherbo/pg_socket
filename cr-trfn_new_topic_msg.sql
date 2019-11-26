CREATE OR REPLACE FUNCTION arc_energo.new_topic_msg()
 RETURNS trigger
 LANGUAGE plpgsql
AS $function$
DECLARE 
loc_port integer;
rec RECORD;

BEGIN

SELECT port INTO loc_port FROM arc_energo.topic WHERE tag = NEW.tag;

FOR rec IN SELECT tag, ip, err_cnt FROM arc_energo.topic_subs WHERE tag = NEW.tag AND (err_cnt < 3 OR err_cnt IS NULL)
    LOOP
		PERFORM new_msg_queue (rec.tag, rec.ip, loc_port, NEW.msg_id);
    END LOOP;

   RETURN NEW;
END;
$function$
;
