-- Создание таблиц для шардинга
-- Этот скрипт выполняется на всех шардах

-- Таблица пользователей (основная для шардинга)
CREATE TABLE IF NOT EXISTS users (
    id BIGINT AUTO_INCREMENT PRIMARY KEY,
    username VARCHAR(50) NOT NULL UNIQUE,
    email VARCHAR(100) NOT NULL UNIQUE,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    shard_key INT GENERATED ALWAYS AS (id % 3) STORED,
    INDEX idx_shard_key (shard_key),
    INDEX idx_username (username),
    INDEX idx_email (email)
) ENGINE=InnoDB;

-- Таблица книг
CREATE TABLE IF NOT EXISTS books (
    id BIGINT AUTO_INCREMENT PRIMARY KEY,
    title VARCHAR(200) NOT NULL,
    author VARCHAR(100) NOT NULL,
    isbn VARCHAR(20),
    price DECIMAL(10,2),
    description TEXT,
    user_id BIGINT, -- Связь с пользователем
    store_id BIGINT, -- Связь с магазином
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    shard_key INT GENERATED ALWAYS AS (user_id % 3) STORED,
    INDEX idx_shard_key (shard_key),
    INDEX idx_user_id (user_id),
    INDEX idx_store_id (store_id),
    INDEX idx_title (title),
    INDEX idx_author (author)
) ENGINE=InnoDB;

-- Таблица магазинов
CREATE TABLE IF NOT EXISTS stores (
    id BIGINT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    address TEXT,
    city VARCHAR(50),
    country VARCHAR(50),
    phone VARCHAR(20),
    email VARCHAR(100),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    shard_key INT GENERATED ALWAYS AS (id % 3) STORED,
    INDEX idx_shard_key (shard_key),
    INDEX idx_name (name),
    INDEX idx_city (city)
) ENGINE=InnoDB;

-- Таблица связей пользователь-книга (для демонстрации)
CREATE TABLE IF NOT EXISTS user_books (
    id BIGINT AUTO_INCREMENT PRIMARY KEY,
    user_id BIGINT NOT NULL,
    book_id BIGINT NOT NULL,
    purchase_date DATE,
    price_paid DECIMAL(10,2),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    shard_key INT GENERATED ALWAYS AS (user_id % 3) STORED,
    INDEX idx_shard_key (shard_key),
    INDEX idx_user_id (user_id),
    INDEX idx_book_id (book_id),
    UNIQUE KEY unique_user_book (user_id, book_id)
) ENGINE=InnoDB;
