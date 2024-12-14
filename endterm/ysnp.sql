CREATE TABLE IF NOT EXISTS attractions (
    attraction_id SERIAL PRIMARY KEY,
    name VARCHAR(255),
    category VARCHAR(50),
    location VARCHAR(100),
    rating FLOAT,
    visitors INTEGER
);


INSERT INTO attractions (name, category, location, rating, visitors) VALUES
('Old Faithful', 'Geothermal Feature', 'Yellowstone National Park', 4.9, 1000000),
('Grand Prismatic Spring', 'Geothermal Feature', 'Yellowstone National Park', 4.8, 900000),
('Mammoth Hot Springs', 'Geothermal Feature', 'Yellowstone National Park', 4.7, 800000),
('Lower Falls of the Yellowstone River', 'Waterfall', 'Yellowstone National Park', 4.9, 1200000),
('Hayden Valley', 'Scenic Area', 'Yellowstone National Park', 4.8, 850000),
('Lamar Valley', 'Scenic Area', 'Yellowstone National Park', 4.7, 750000),
('Yellowstone Lake', 'Lake', 'Yellowstone National Park', 4.6, 600000),
('Norris Geyser Basin', 'Geothermal Feature', 'Yellowstone National Park', 4.7, 700000),
('Tower Fall', 'Waterfall', 'Yellowstone National Park', 4.5, 500000),
('West Thumb Geyser Basin', 'Geothermal Feature', 'Yellowstone National Park', 4.4, 400000),
('Artist Point', 'Scenic Viewpoint', 'Yellowstone National Park', 4.9, 1100000),
('Mount Washburn', 'Hiking Area', 'Yellowstone National Park', 4.6, 550000),
('Mud Volcano', 'Geothermal Feature', 'Yellowstone National Park', 4.5, 450000),
('Fountain Paint Pot', 'Geothermal Feature', 'Yellowstone National Park', 4.4, 400000),
('Midway Geyser Basin', 'Geothermal Feature', 'Yellowstone National Park', 4.8, 800000),
('Firehole River', 'River', 'Yellowstone National Park', 4.5, 500000),
('Gibbon Falls', 'Waterfall', 'Yellowstone National Park', 4.3, 300000),
('Biscuit Basin', 'Geothermal Feature', 'Yellowstone National Park', 4.4, 350000),
('Black Sand Basin', 'Geothermal Feature', 'Yellowstone National Park', 4.3, 300000),
('Lewis Falls', 'Waterfall', 'Yellowstone National Park', 4.2, 250000),
('Cascade Lake Trail', 'Hiking Trail', 'Yellowstone National Park', 4.1, 200000),
('Bechler Falls', 'Waterfall', 'Yellowstone National Park', 4.0, 150000),
('Soda Butte', 'Geothermal Feature', 'Yellowstone National Park', 4.1, 200000),
('Steamboat Geyser', 'Geothermal Feature', 'Yellowstone National Park', 4.9, 1000000),
('Sylvan Lake', 'Lake', 'Yellowstone National Park', 4.2, 250000),
('Pelican Valley', 'Scenic Area', 'Yellowstone National Park', 4.3, 300000),
('Clear Lake', 'Lake', 'Yellowstone National Park', 4.1, 200000),
('Hellroaring Creek', 'River', 'Yellowstone National Park', 4.0, 150000),
('Sheepeater Cliff', 'Scenic Area', 'Yellowstone National Park', 4.1, 200000),
('Observation Point Trail', 'Hiking Trail', 'Yellowstone National Park', 4.2, 250000);


--List all attractions with a rating greater than 4.5.
SELECT name, rating
FROM attractions
WHERE rating > 4.5
ORDER BY rating DESC;


--Count the total number of attractions by category.
SELECT category, COUNT(*) AS total_attractions
FROM attractions
GROUP BY category
ORDER BY total_attractions DESC;


--Find the location with the highest number of visitors.
SELECT location, SUM(visitors) AS total_visitors
FROM attractions
GROUP BY location
ORDER BY total_visitors DESC
LIMIT 1;


--Calculate the average rating for each location.
SELECT location, AVG(rating) AS average_rating
FROM attractions
GROUP BY location
ORDER BY average_rating DESC;


--Find attractions with the least number of visitors (top 5).
SELECT name, visitors
FROM attractions
ORDER BY visitors ASC
LIMIT 5;


--Identify the most popular category based on the total number of visitors.
SELECT category, SUM(visitors) AS total_visitors
FROM attractions
GROUP BY category
ORDER BY total_visitors DESC
LIMIT 1;

--Total Recreation Visits by Year
SELECT 
    EXTRACT(YEAR FROM TO_DATE("Year/Month/Day", 'YYYY/MM/DD')) AS year, 
    SUM("Recreation Visits") AS total_visits
FROM 
    ysnp_data
GROUP BY 
    year
ORDER BY 
    year;


--Average Temperature by Month
SELECT 
    EXTRACT(MONTH FROM TO_DATE("Year/Month/Day", 'YYYY/MM/DD')) AS month, 
    AVG("MeanTemperature(F)") AS avg_temp
FROM 
    ysnp_data
GROUP BY 
    month
ORDER BY 
    month;






