CREATE TABLE  sales (
product_id INTEGER PRIMARY KEY,
date DATE NOT NULL,
revenue INTEGER NOT NULL
);

INSERT INTO sales VALUES (1, '2024-09-21', 10000);
INSERT INTO sales VALUES (2, '2020-05-17', 5000);
INSERT INTO sales VALUES (3, '2006-12-18', 3000);
INSERT INTO sales VALUES (4, '2015-06-04', 13000);
INSERT INTO sales VALUES (5, '2017-06-04', 9000);

SELECT * FROM sales;

SELECT product_id, 
SUM(revenue) AS total_revenue, 
MAX(date) AS most_recent_sale
FROM sales
GROUP BY product_id
ORDER BY total_revenue DESC, most_recent_sale DESC
LIMIT 5;
SELECT * FROM sales;