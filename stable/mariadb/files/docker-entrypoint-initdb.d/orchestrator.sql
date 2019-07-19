CREATE USER 'orc_client_user'@'%' IDENTIFIED BY 'orc_client_user_password';
GRANT SUPER, PROCESS, REPLICATION SLAVE, REPLICATION CLIENT, RELOAD ON *.* TO 'orc_client_user'@'%';
GRANT SELECT ON meta.* TO 'orc_client_user'@'%';
