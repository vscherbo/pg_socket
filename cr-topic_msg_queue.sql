-- Drop table

DROP TABLE arc_energo.topic_msg_queue;

CREATE TABLE arc_energo.topic_msg_queue (
	ip inet NOT NULL,
	msg_id int4 NOT NULL,
    dt_sent timestamp NULL DEFAULT clock_timestamp(),
    status int4 NOT NULL DEFAULT 0,
    dt_delivered timestamp NULL,
	sent_result varchar NULL,
	CONSTRAINT topic_msg_queue_pk PRIMARY KEY (ip, msg_id),
	CONSTRAINT topic_msg_fk FOREIGN KEY (msg_id) REFERENCES topic_msg(msg_id)
);

COMMENT ON COLUMN arc_energo.topic_msg_queue.status IS '0 - created, 10 - sent with success, 20 - sent with error, 90 - received';

-- Permissions

ALTER TABLE arc_energo.topic_msg_queue OWNER TO arc_energo;
GRANT ALL ON TABLE arc_energo.topic_msg_queue TO arc_energo;
