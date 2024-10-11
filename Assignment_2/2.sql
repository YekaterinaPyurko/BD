DROP TABLE IF EXISTS order_items CASCADE;
DROP TABLE IF EXISTS orders CASCADE;
DROP TABLE IF EXISTS products CASCADE;
DROP TABLE IF EXISTS customers CASCADE;
DROP TABLE IF EXISTS categories CASCADE;

CREATE TABLE customers (
    customer_id SERIAL PRIMARY KEY,
    customer_name TEXT NOT NULL,
    email TEXT,
    phone TEXT,
    address TEXT
);


CREATE TABLE categories (
    category_id SERIAL PRIMARY KEY,
    category_name TEXT NOT NULL
);


CREATE TABLE products (
    product_id SERIAL PRIMARY KEY,
    product_name TEXT NOT NULL,
    category_id INTEGER REFERENCES categories(category_id),
    description TEXT
);


CREATE TABLE orders (
    order_id SERIAL PRIMARY KEY,
    customer_id INTEGER REFERENCES customers(customer_id),
    order_date DATE,
    total_amount NUMERIC
);


CREATE TABLE order_items (
    order_item_id SERIAL PRIMARY KEY,
    order_id INTEGER REFERENCES orders(order_id),
    product_id INTEGER REFERENCES products(product_id),
    quantity INTEGER,
    unit_price NUMERIC
);

INSERT INTO categories (category_name) VALUES
('Electronics'), ('Books'), ('Clothing'), ('Home Appliances'), ('Toys');


INSERT INTO products (product_name, category_id, description) VALUES
('Laptop', 1, 'High-end gaming laptop'),
('Headphones', 1, 'Noise-cancelling headphones'),
('Novel', 2, 'Fiction book'),
('Shirt', 3, 'Cotton shirt'),
('Refrigerator', 4, 'Double-door refrigerator'),
('Action Figure', 5, 'Superhero action figure'),
('Smartphone', 1, 'Latest smartphone'),
('Blender', 4, 'High-power blender'),
('Jeans', 3, 'Denim jeans'),
('Board Game', 5, 'Strategy board game');


INSERT INTO customers (customer_name, email, phone, address) VALUES
('Alice Smith', 'alice@example.com', '1234567890', '123 Elm St'),
('Bob Johnson', 'bob@example.com', '0987654321', '456 Oak St'),
('Charlie Lee', 'charlie@example.com', '5551234567', '789 Pine St'),
('Diana Ross', 'diana@example.com', '7779876543', '101 Maple St'),
('Eve Davis', 'eve@example.com', '6666543210', '202 Birch St'),
('Frank Miller', 'frank@example.com', '8881122334', '303 Cedar St'),
('Grace Adams', 'grace@example.com', '4442233445', '404 Walnut St'),
('Hank Green', 'hank@example.com', '9999988776', '505 Ash St'),
('Ivy Carter', 'ivy@example.com', '3333344556', '606 Willow St'),
('Jack Brown', 'jack@example.com', '7776655443', '707 Poplar St');


INSERT INTO orders (customer_id, order_date, total_amount) VALUES
(1, '2024-01-01', 500),
(2, '2024-01-02', 300),
(3, '2024-01-03', 200),
(4, '2024-01-04', 1000),
(5, '2024-01-05', 250),
(6, '2024-01-06', 450),
(7, '2024-01-07', 600),
(8, '2024-01-08', 150),
(9, '2024-01-09', 350),
(10, '2024-01-10', 700);


INSERT INTO order_items (order_id, product_id, quantity, unit_price) VALUES
(1, 1, 1, 500),
(2, 2, 2, 150),
(3, 3, 1, 200),
(4, 1, 1, 500),
(5, 5, 1, 250),
(6, 6, 3, 450),
(7, 7, 2, 600),
(8, 8, 2, 150),
(9, 9, 1, 350),
(10, 10, 1, 700);


SELECT 
    c.customer_name, 
    COUNT(o.order_id) AS total_orders
FROM customers c
JOIN orders o ON c.customer_id = o.customer_id
GROUP BY c.customer_id, c.customer_name
ORDER BY total_orders DESC
LIMIT 1;


SELECT 
    p.product_name, 
    SUM(oi.quantity) AS total_quantity
FROM products p
JOIN order_items oi ON p.product_id = oi.product_id
GROUP BY p.product_id, p.product_name
ORDER BY total_quantity DESC
LIMIT 1;


SELECT 
    p.product_name, 
    SUM(oi.quantity * oi.unit_price) AS total_revenue
FROM products p
JOIN order_items oi ON p.product_id = oi.product_id
GROUP BY p.product_id, p.product_name
ORDER BY total_revenue DESC
LIMIT 1;


WITH most_orders_customer AS (
    SELECT 
        o.customer_id
    FROM orders o
    GROUP BY o.customer_id
    ORDER BY COUNT(o.order_id) DESC
    LIMIT 1
)
SELECT 
    c.customer_name, 
    SUM(o.total_amount) AS total_revenue
FROM customers c
JOIN orders o ON c.customer_id = o.customer_id
WHERE c.customer_id = (SELECT customer_id FROM most_orders_customer)
GROUP BY c.customer_name;
