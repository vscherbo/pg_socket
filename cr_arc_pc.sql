-- Drop table

-- DROP TABLE arc_energo.arc_pc;

CREATE TABLE arc_energo.arc_pc (
	ip inet NOT NULL,
	dt_start timestamp NOT NULL DEFAULT now(),
	pc_name varchar NOT NULL,
	user_id int4 NOT NULL,
	CONSTRAINT arc_pc_pk PRIMARY KEY (ip),
	CONSTRAINT arc_pc_fk FOREIGN KEY (user_id) REFERENCES "Сотрудники"("Номер")
);
COMMENT ON TABLE arc_energo.arc_pc IS 'ПК, на которых запущена база
INSERT INTO arc_pc
(ip, dt_start, pc_name, user_id)
VALUES(''192.168.1.101'', now(), ''scherbova'', -1)
ON CONFLICT (ip) DO UPDATE SET pc_name = excluded.pc_name, user_id = excluded.user_id;';

-- Permissions

ALTER TABLE arc_energo.arc_pc OWNER TO arc_energo;
GRANT ALL ON TABLE arc_energo.arc_pc TO arc_energo;
