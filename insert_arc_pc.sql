INSERT INTO arc_pc
(ip, dt_start, pc_name, user_id)
VALUES(inet_client_addr(), now(), <Windows environment COMPUTERNAME>, "Сотрудники"."Номер")
ON CONFLICT (ip) DO UPDATE SET pc_name = excluded.pc_name, user_id = excluded.user_id;
