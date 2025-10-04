-- Примеры запросов для демонстрации шардинга

-- 1. Запросы для проверки распределения данных по шардам
-- Проверка пользователей по шардам
SELECT 
    shard_key,
    COUNT(*) as user_count,
    GROUP_CONCAT(username) as usernames
FROM users 
GROUP BY shard_key 
ORDER BY shard_key;

-- 2. Запросы для тестирования маршрутизации
-- Получение пользователя по ID (должен попасть в соответствующий шард)
SELECT * FROM users WHERE id = 1;  -- Shard 1
SELECT * FROM users WHERE id = 2;  -- Shard 2  
SELECT * FROM users WHERE id = 3;  -- Shard 3

-- 3. Запросы для проверки связей между таблицами
-- Получение книг пользователя (должны быть в том же шарде)
SELECT 
    u.username,
    b.title,
    b.author,
    b.price
FROM users u
JOIN books b ON u.id = b.user_id
WHERE u.id = 1;

-- 4. Аналитические запросы (для демонстрации чтения с slave)
-- Статистика по пользователям
SELECT 
    shard_key,
    COUNT(*) as total_users,
    AVG(price) as avg_book_price
FROM users u
LEFT JOIN books b ON u.id = b.user_id
GROUP BY shard_key;

-- 5. Запросы для проверки репликации
-- Проверка, что данные реплицируются на slave
-- (Эти запросы должны выполняться на slave серверах)
SELECT COUNT(*) as user_count FROM users;
SELECT COUNT(*) as book_count FROM books;
SELECT COUNT(*) as store_count FROM stores;

-- 6. Тестовые запросы для проверки шардинга
-- Вставка нового пользователя (должен попасть в соответствующий шард)
INSERT INTO users (username, email, first_name, last_name) 
VALUES ('test_user_10', 'test10@example.com', 'Test', 'User');

-- Вставка книги для пользователя (должна попасть в тот же шард)
INSERT INTO books (title, author, price, user_id, store_id)
VALUES ('Test Book', 'Test Author', 9.99, LAST_INSERT_ID(), 1);

-- 7. Запросы для демонстрации вертикального шардинга
-- Запрос только к таблице пользователей (Shard 1)
SELECT username, email FROM users WHERE created_at > '2024-01-01';

-- Запрос только к таблице книг (Shard 2)  
SELECT title, author, price FROM books WHERE price > 15.00;

-- Запрос только к таблице магазинов (Shard 3)
SELECT name, city, country FROM stores WHERE country = 'USA';

-- 8. Сложные запросы, требующие JOIN между шардами
-- (Эти запросы будут выполняться через ProxySQL)
SELECT 
    u.username,
    b.title,
    s.name as store_name,
    s.city
FROM users u
JOIN books b ON u.id = b.user_id  
JOIN stores s ON b.store_id = s.id
WHERE u.id = 1;
