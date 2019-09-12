CREATE OR REPLACE FUNCTION arc_energo.put_msg(arg_tag character varying, arc_msg character varying)
 RETURNS void
 LANGUAGE sql
AS $function$
INSERT INTO topic_msg(tag, msg) VALUES(arg_tag, arc_msg);
$function$
;

