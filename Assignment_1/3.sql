CREATE TABLE monthly_sales (
year INTEGER PRIMARY KEY,
month INTEGER NOT NULL,
total_sales INTEGER NOT NULL,
region TEXT NOT NULL
);

INSERT INTO monthly_sales VALUES (2023, 7, 10000,SKO);
INSERT INTO monthly_sales VALUES (2020,4, 5000,Almaty);
INSERT INTO monthly_sales VALUES (2017, 2, 3000, Astana);
INSERT INTO monthly_sales VALUES (2014, 9, 13000, Shymkent);
INSERT INTO monthly_sales VALUES (2011, 5, 9000,VKO);

SELECT * FROM monthly_sales ;


SELECT year, month, region, SUM(total_sales) AS total_sales
FROM monthly_sales
GROUP BY year, month, region
ORDER BY year ASC, month ASC;
SELECT * FROM monthly_sales ;