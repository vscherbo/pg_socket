-- Drop table

-- DROP TABLE arc_energo.topic_msg;

CREATE TABLE arc_energo.topic_msg (
	msg_id serial NOT NULL,
	dt_create timestamp NOT NULL DEFAULT now(),
	tag varchar NOT NULL,
	sender varchar NOT NULL DEFAULT 0,
	msg varchar NOT NULL,
	CONSTRAINT topic_msg_pk PRIMARY KEY (msg_id),
	CONSTRAINT topic_msg_fk FOREIGN KEY (tag) REFERENCES topic(tag) ON UPDATE CASCADE
);
COMMENT ON TABLE arc_energo.topic_msg IS 'Cообщения для рассылки подписчикам';


-- Table Triggers

-- DROP TRIGGER topic_msg_ai ON arc_energo.topic_msg;

CREATE TRIGGER topic_msg_ai AFTER
INSERT
    ON
    arc_energo.topic_msg FOR EACH ROW EXECUTE PROCEDURE new_topic_msg();

-- Permissions

ALTER TABLE arc_energo.topic_msg OWNER TO arc_energo;
GRANT ALL ON TABLE arc_energo.topic_msg TO arc_energo;
