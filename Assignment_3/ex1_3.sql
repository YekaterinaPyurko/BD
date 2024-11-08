DROP TABLE IF EXISTS order_items CASCADE;
DROP TABLE IF EXISTS orders CASCADE;
DROP TABLE IF EXISTS products CASCADE;
DROP TABLE IF EXISTS customers CASCADE;

CREATE TABLE customers (
    customer_id INT PRIMARY KEY,
    city VARCHAR(255),
    state VARCHAR(255)
);


CREATE TABLE products (
    product_id INT PRIMARY KEY,
    category VARCHAR(255),
    price NUMERIC(10, 2),
    stock_quantity INT
);


CREATE TABLE orders (
    order_id INT PRIMARY KEY,
    customer_id INT,
    order_date TIMESTAMP,
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id)
);


CREATE TABLE order_items (
    order_item_id INT PRIMARY KEY,
    order_id INT,
    product_id INT,
    quantity INT,
    FOREIGN KEY (order_id) REFERENCES orders(order_id),
    FOREIGN KEY (product_id) REFERENCES products(product_id)
);

INSERT INTO customers (customer_id, city, state) VALUES
(1, 'New York', 'NY'),
(2, 'Los Angeles', 'CA'),
(3, 'Chicago', 'IL'),
(4, 'Houston', 'TX');

INSERT INTO products (product_id, category, price, stock_quantity) VALUES
(101, 'Electronics', 499.99, 50),
(102, 'Furniture', 299.99, 20),
(103, 'Clothing', 39.99, 100),
(104, 'Electronics', 199.99, 30);


INSERT INTO orders (order_id, customer_id, order_date) VALUES
(1001, 1, '2024-10-01 14:30:00'),
(1002, 2, '2024-10-03 09:15:00'),
(1003, 3, '2024-10-05 16:45:00'),
(1004, 4, '2024-10-06 12:00:00');

INSERT INTO order_items (order_item_id, order_id, product_id, quantity) VALUES
(1, 1001, 101, 2),
(2, 1001, 103, 3),
(3, 1002, 102, 1),
(4, 1003, 104, 4),
(5, 1003, 101, 1),
(6, 1004, 103, 5);


SELECT 
    p.category,
    c.state,
    SUM(p.price * oi.quantity) AS total_revenue
FROM order_items oi
JOIN products p ON oi.product_id = p.product_id
JOIN orders o ON oi.order_id = o.order_id
JOIN customers c ON o.customer_id = c.customer_id
GROUP BY p.category, c.state
ORDER BY p.category, c.state;


WITH category_spending AS (
    SELECT 
        p.category,
        o.customer_id,
        SUM(p.price * oi.quantity) AS total_spend
    FROM order_items oi
    JOIN products p ON oi.product_id = p.product_id
    JOIN orders o ON oi.order_id = o.order_id
    GROUP BY p.category, o.customer_id
),
max_spending AS (
    SELECT 
        category,
        MAX(total_spend) AS max_spend
    FROM category_spending
    GROUP BY category
)
SELECT 
    cs.category,
    cs.customer_id,
    cs.total_spend
FROM category_spending cs
JOIN max_spending ms ON cs.category = ms.category AND cs.total_spend = ms.max_spend
ORDER BY cs.category, cs.customer_id;


WITH daily_sales AS (
    SELECT
        oi.product_id,
        DATE(o.order_date) AS sale_date,
        SUM(oi.quantity) AS total_quantity
    FROM order_items oi
    JOIN orders o ON oi.order_id = o.order_id
    GROUP BY oi.product_id, DATE(o.order_date)
),
rolling_avg AS (
    SELECT
        product_id,
        sale_date,
        SUM(total_quantity) OVER (
            PARTITION BY product_id
            ORDER BY sale_date
            ROWS BETWEEN 6 PRECEDING AND CURRENT ROW
        ) AS rolling_sum,
        COUNT(*) OVER (
            PARTITION BY product_id
            ORDER BY sale_date
            ROWS BETWEEN 6 PRECEDING AND CURRENT ROW
        ) AS rolling_count
    FROM daily_sales
)
SELECT
    product_id,
    sale_date,
    ROUND(rolling_sum::numeric / NULLIF(rolling_count, 0), 2) AS rolling_avg_order_size
FROM rolling_avg
ORDER BY product_id, sale_date;
