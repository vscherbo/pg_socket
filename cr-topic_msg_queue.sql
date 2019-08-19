-- Drop table

-- DROP TABLE arc_energo.topic_msg_queue;

CREATE TABLE arc_energo.topic_msg_queue (
	msg_id serial NOT NULL,
	dt_create timestamp NOT NULL DEFAULT now(),
	status int4 NOT NULL DEFAULT 0, -- 0 - к отправке¶10 - удачно отправлен всем¶20 - удачно отправлен хотя бы одному
	tag varchar NOT NULL,
	sender varchar NOT NULL DEFAULT 0,
	msg varchar NOT NULL,
	dt_sent timestamp NULL,
	delivered inet[] NULL,
	CONSTRAINT topic_msg_queue_pk PRIMARY KEY (msg_id),
	CONSTRAINT topic_msg_queue_fk FOREIGN KEY (tag) REFERENCES topic(tag) ON UPDATE CASCADE
);
COMMENT ON TABLE arc_energo.topic_msg_queue IS 'Очередь сообщений для рассылки подписчикам';

-- Column comments

COMMENT ON COLUMN arc_energo.topic_msg_queue.status IS '0 - к отправке
10 - удачно отправлен всем
20 - удачно отправлен хотя бы одному';

-- Table Triggers

-- DROP TRIGGER topic_msg_queue_ai ON arc_energo.topic_msg_queue;

CREATE TRIGGER topic_msg_queue_ai AFTER
INSERT
    ON
    arc_energo.topic_msg_queue FOR EACH ROW EXECUTE PROCEDURE new_topic_msg();

-- Permissions

ALTER TABLE arc_energo.topic_msg_queue OWNER TO arc_energo;
GRANT ALL ON TABLE arc_energo.topic_msg_queue TO arc_energo;
