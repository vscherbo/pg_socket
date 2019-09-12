-- Drop table

-- DROP TABLE arc_energo.topic_subs;

CREATE TABLE arc_energo.topic_subs (
	tag varchar NOT NULL,
	ip inet NOT NULL,
	dt_subs timestamp NOT NULL DEFAULT now(),
	CONSTRAINT topic_subs_pk PRIMARY KEY (tag, ip),
	CONSTRAINT topic_subs_pc_fk FOREIGN KEY (ip) REFERENCES arc_pc(ip),
	CONSTRAINT topic_subs_topic_fk FOREIGN KEY (tag) REFERENCES topic(tag) ON UPDATE CASCADE
);
COMMENT ON TABLE arc_energo.topic_subs IS 'Подписки на темы сообщений';

-- Permissions

ALTER TABLE arc_energo.topic_subs OWNER TO arc_energo;
GRANT ALL ON TABLE arc_energo.topic_subs TO arc_energo;
