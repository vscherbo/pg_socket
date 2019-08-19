-- Drop table

-- DROP TABLE arc_energo.topic;

CREATE TABLE arc_energo.topic (
	tag varchar NOT NULL,
	"comment" varchar NULL,
	port int4 NOT NULL,
	CONSTRAINT topic_pk PRIMARY KEY (tag)
);
COMMENT ON TABLE arc_energo.topic IS 'Темы сообщений для подписки';

-- Permissions

ALTER TABLE arc_energo.topic OWNER TO arc_energo;
GRANT ALL ON TABLE arc_energo.topic TO arc_energo;
