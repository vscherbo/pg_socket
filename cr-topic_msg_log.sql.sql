-- Drop table

-- DROP TABLE arc_energo.topic_msg_log;

CREATE TABLE arc_energo.topic_msg_log (
	id serial NOT NULL,
	dt_create timestamp NOT NULL DEFAULT now(),
	msg_id int4 NOT NULL,
	msg_log varchar NULL,
	CONSTRAINT topic_msg_log_pk PRIMARY KEY (id),
	CONSTRAINT topic_msg_log_fk FOREIGN KEY (msg_id) REFERENCES topic_msg_queue(msg_id)
);

-- Permissions

ALTER TABLE arc_energo.topic_msg_log OWNER TO arc_energo;
GRANT ALL ON TABLE arc_energo.topic_msg_log TO arc_energo;
