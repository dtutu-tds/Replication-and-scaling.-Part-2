-- Вставка тестовых данных для демонстрации шардинга

-- Пользователи (будут распределены по шардам по user_id % 3)
INSERT INTO users (id, username, email, first_name, last_name) VALUES
(1, 'alice_johnson', 'alice@example.com', 'Alice', 'Johnson'),
(2, 'bob_smith', 'bob@example.com', 'Bob', 'Smith'),
(3, 'charlie_brown', 'charlie@example.com', 'Charlie', 'Brown'),
(4, 'diana_prince', 'diana@example.com', 'Diana', 'Prince'),
(5, 'eve_adams', 'eve@example.com', 'Eve', 'Adams'),
(6, 'frank_miller', 'frank@example.com', 'Frank', 'Miller'),
(7, 'grace_hopper', 'grace@example.com', 'Grace', 'Hopper'),
(8, 'henry_ford', 'henry@example.com', 'Henry', 'Ford'),
(9, 'iris_west', 'iris@example.com', 'Iris', 'West');

-- Магазины (справочные данные)
INSERT INTO stores (id, name, address, city, country, phone, email) VALUES
(1, 'BookWorld Central', '123 Main St', 'New York', 'USA', '+1-555-0101', 'central@bookworld.com'),
(2, 'BookWorld Downtown', '456 Oak Ave', 'New York', 'USA', '+1-555-0102', 'downtown@bookworld.com'),
(3, 'BookWorld Mall', '789 Pine St', 'Los Angeles', 'USA', '+1-555-0103', 'mall@bookworld.com'),
(4, 'BookWorld Plaza', '321 Elm St', 'Chicago', 'USA', '+1-555-0104', 'plaza@bookworld.com'),
(5, 'BookWorld Square', '654 Maple Ave', 'Boston', 'USA', '+1-555-0105', 'square@bookworld.com');

-- Книги (будут распределены по шардам по user_id)
INSERT INTO books (id, title, author, isbn, price, description, user_id, store_id) VALUES
(1, 'The Great Gatsby', 'F. Scott Fitzgerald', '978-0-7432-7356-5', 12.99, 'A classic American novel', 1, 1),
(2, 'To Kill a Mockingbird', 'Harper Lee', '978-0-06-112008-4', 14.99, 'A story of racial injustice', 2, 1),
(3, '1984', 'George Orwell', '978-0-452-28423-4', 13.99, 'Dystopian fiction', 3, 2),
(4, 'Pride and Prejudice', 'Jane Austen', '978-0-14-143951-8', 11.99, 'Romantic novel', 4, 2),
(5, 'The Catcher in the Rye', 'J.D. Salinger', '978-0-316-76948-0', 15.99, 'Coming-of-age story', 5, 3),
(6, 'Lord of the Flies', 'William Golding', '978-0-571-05686-5', 12.99, 'Allegorical novel', 6, 3),
(7, 'The Hobbit', 'J.R.R. Tolkien', '978-0-547-92822-7', 16.99, 'Fantasy adventure', 7, 4),
(8, 'Animal Farm', 'George Orwell', '978-0-452-28424-1', 10.99, 'Political allegory', 8, 4),
(9, 'The Chronicles of Narnia', 'C.S. Lewis', '978-0-06-447119-0', 18.99, 'Fantasy series', 9, 5);

-- Связи пользователь-книга
INSERT INTO user_books (user_id, book_id, purchase_date, price_paid) VALUES
(1, 1, '2024-01-15', 12.99),
(2, 2, '2024-01-20', 14.99),
(3, 3, '2024-02-01', 13.99),
(4, 4, '2024-02-10', 11.99),
(5, 5, '2024-02-15', 15.99),
(6, 6, '2024-03-01', 12.99),
(7, 7, '2024-03-10', 16.99),
(8, 8, '2024-03-20', 10.99),
(9, 9, '2024-04-01', 18.99);
