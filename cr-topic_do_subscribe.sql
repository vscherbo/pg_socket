CREATE OR REPLACE FUNCTION arc_energo.topic_do_subscribe(arg_tag character varying)
 RETURNS void
 LANGUAGE sql
AS $function$
INSERT INTO arc_energo.topic_subs
(tag, ip)
VALUES(arg_tag, inet_client_addr())
ON CONFLICT (tag, ip) DO UPDATE SET dt_subs = clock_timestamp(), err_cnt = 0;
$function$
;

