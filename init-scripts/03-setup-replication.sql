-- Настройка репликации для Master-Slave конфигурации
-- Этот скрипт выполняется на slave серверах

-- Настройка репликации для Shard 1 Slave
-- (Выполняется на mysql-shard1-slave)
CHANGE MASTER TO
    MASTER_HOST='mysql-shard1-master',
    MASTER_PORT=3306,
    MASTER_USER='root',
    MASTER_PASSWORD='rootpassword',
    MASTER_AUTO_POSITION=1;

START SLAVE;

-- Настройка репликации для Shard 2 Slave  
-- (Выполняется на mysql-shard2-slave)
CHANGE MASTER TO
    MASTER_HOST='mysql-shard2-master',
    MASTER_PORT=3306,
    MASTER_USER='root',
    MASTER_PASSWORD='rootpassword',
    MASTER_AUTO_POSITION=1;

START SLAVE;

-- Проверка статуса репликации
SHOW SLAVE STATUS\G
