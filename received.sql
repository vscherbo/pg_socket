UPDATE topic_msg_queue SET delivered = array_append(delivered, '192.168.1.102'::inet)
WHERE msg_id=1;
