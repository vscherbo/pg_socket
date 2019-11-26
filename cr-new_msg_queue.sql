CREATE OR REPLACE FUNCTION arc_energo.new_msg_queue(tag_in character varying, ip_in inet, port_in integer, msg_id_in integer)
 RETURNS void
 LANGUAGE plpgsql
AS $function$

DECLARE 
res varchar;
host_to text;
BEGIN
        host_to := host(ip_in::inet);
        res := sock_send(host_to, port_in, msg_id_in::varchar);

       INSERT INTO arc_energo.topic_msg_queue(ip, msg_id, status, sent_result)
        VALUES(ip_in::inet, msg_id_in, 
            CASE WHEN res='' THEN 10 ELSE 20 END,
            res)
        ON CONFLICT (ip, msg_id) DO NOTHING; -- received before registered

        IF res = '' THEN
            UPDATE arc_energo.topic_subs SET err_cnt = 0 WHERE tag::text = tag_in AND ip = ip_in;
        ELSIF res LIKE '%timed out%' THEN
            UPDATE arc_energo.topic_subs SET err_cnt = COALESCE(err_cnt, 0) + 1 WHERE tag::text = tag_in AND ip = ip_in;
        END IF;
END;
$function$
;
