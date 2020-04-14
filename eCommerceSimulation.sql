-- 1. Create 3 tables following the criteria in the summary.
CREATE TABLE users
(id SERIAL PRIMARY KEY,
 name VARCHAR(100) NOT NULL,
 email VARCHAR(100) NOT NULL
);

CREATE TABLE products
(id SERIAL PRIMARY KEY,
 name VARCHAR(100) NOT NULL,
 price INTEGER NOT NULL
);

CREATE TABLE orders
(id SERIAL PRIMARY KEY,
 product_id INTEGER,
 FOREIGN KEY (id) references products(id)
);

-- 2. Add some data to fill up each table. At least 3 users, 3 products, 3 orders.
INSERT INTO users 
(name, email)
VALUES 
('Jeremy', 'Jeremy@gmail.com'),
('Bennett', 'Bennett@gmail.com'),
('Dude', 'Dude@gmail.com');

INSERT INTO products 
(name, price)
VALUES 
('Modern Warfare', 60),
('Red Dead 2', 60),
('Xbox', 500);

INSERT INTO orders
(product_id)
VALUES
(1), (2), (3);

-- 3. Run queries against your data.
    -- Get all products for the first order.
SELECT * FROM products AS p
INNER JOIN orders AS o
ON p.id = o.id
WHERE o.id = 1;

    -- Get all orders.
SELECT * FROM orders;

    -- Get the total cost of an order ( sum the price of all products on an order ).
SELECT o.id, SUM(p.price)
FROM products AS p
INNER JOIN orders AS o 
ON p.id = o.id
WHERE o.id = 3
GROUP BY o.id;

-- 4. Add a foreign key reference from orders to users.
ALTER TABLE users
ADD COLUMN order_id INTEGER
REFERENCES orders(id);

-- 5. Update the orders table to link a user to each order.
UPDATE users
SET order_id = 1
WHERE id = 1;

UPDATE users
SET order_id = 2
WHERE id = 2;

UPDATE users
SET order_id = 3
WHERE id = 3;

-- 6. Run queries against your data.
    -- Get all orders for a user.
SELECT * FROM users AS u
INNER JOIN orders AS o
ON o.id = u.order_id
WHERE u.id = 3;

    -- Get how many orders each user has.
SELECT COUNT(*) FROM users AS u
INNER JOIN orders AS o
ON o.id = u.order_id
WHERE u.id = 2;