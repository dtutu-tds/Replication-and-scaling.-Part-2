#!/bin/bash

# Скрипт для запуска системы шардинга

echo "🚀 Запуск системы шардинга баз данных..."

# Остановка существующих контейнеров
echo "⏹️  Остановка существующих контейнеров..."
docker-compose down

# Удаление старых volumes (опционально)
echo "🗑️  Очистка старых данных..."
docker volume prune -f

# Запуск системы
echo "▶️  Запуск контейнеров..."
docker-compose up -d

# Ожидание запуска сервисов
echo "⏳ Ожидание запуска сервисов..."
sleep 30

# Проверка статуса
echo "📊 Статус контейнеров:"
docker-compose ps

echo ""
echo "🔗 Подключения к сервисам:"
echo "ProxySQL (маршрутизатор): mysql -h localhost -P 6032 -u sharduser -pshardpass"
echo "Shard 1 Master: mysql -h localhost -P 3306 -u sharduser -pshardpass"
echo "Shard 1 Slave:  mysql -h localhost -P 3307 -u sharduser -pshardpass"
echo "Shard 2 Master: mysql -h localhost -P 3308 -u sharduser -pshardpass"
echo "Shard 2 Slave:  mysql -h localhost -P 3309 -u sharduser -pshardpass"
echo "Shard 3:        mysql -h localhost -P 3310 -u sharduser -pshardpass"

echo ""
echo "✅ Система шардинга запущена!"
echo "📝 Для тестирования используйте скрипты из папки init-scripts/"
