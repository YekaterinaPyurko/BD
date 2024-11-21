CREATE TABLE RestaurantData (
    Rank INT PRIMARY KEY,
    Restaurant VARCHAR(100) NOT NULL,
    Sales INT NOT NULL,
    Units INT NOT NULL,
    Segment_Category VARCHAR(100) NOT NULL
);


INSERT INTO RestaurantData (Rank, Restaurant, Sales, Units, Segment_Category)
VALUES
(1, 'McDonalds', 40412, 13846, 'Quick Service & Burger'),
(2, 'Starbucks', 21380, 15049, 'Quick Service & Coffee Cafe'),
(3, 'Chick-fil-A', 11320, 2470, 'Quick Service & Chicken'),
(4, 'Taco Bell', 11293, 6766, 'Quick Service & Mexican'),
(5, 'Burger King', 10204, 7346, 'Quick Service & Burger'),
(6, 'Subway', 10200, 23801, 'Quick Service & Sandwich'),
(7, 'Wendys', 9762, 5852, 'Quick Service & Burger'),
(8, 'Dunkin', 9228, 9630, 'Quick Service & Coffee Cafe'),
(9, 'Dominos', 7044, 6126, 'Quick Service & Pizza'),
(10, 'Panera Bread', 5890, 2160, 'Fast Casual & Bakery Cafe'),
(11, 'Pizza Hut', 5558, 7306, 'Quick Service & Pizza'),
(12, 'Chipotle Mexican Grill', 5509, 2584, 'Fast Casual & Mexican'),
(13, 'Sonic Drive-In', 4687, 3526, 'Quick Service & Burger'),
(14, 'KFC', 4546, 4065, 'Quick Service & Chicken'),
(15, 'Olive Garden', 4287, 866, 'Casual Dining & Italian/Pizza'),
(16, 'Applebees', 4085, 1665, 'Casual Dining & Varied Menu'),
(17, 'Panda Express', 3946, 2209, 'Fast Casual & Asian/Noodle'),
(18, 'Arbys', 3884, 3359, 'Quick Service & Sandwich'),
(19, 'Popeyes Louisiana Kitchen', 3812, 2476, 'Quick Service & Chicken'),
(20, 'Little Caesars', 3811, 4237, 'Quick Service & Pizza'),
(21, 'Dairy Queen', 3760, 4381, 'Quick Service & Frozen Desserts'),
(22, 'Buffalo Wild Wings', 3669, 1206, 'Casual Dining & Sports Bar'),
(23, 'Chilis Grill & Bar', 3563, 1242, 'Casual Dining & Varied Menu'),
(24, 'Jack in the Box', 3504, 2243, 'Quick Service & Burger'),
(25, 'IHOP', 3266, 1710, 'Family Dining & Family Style'),
(26, 'Texas Roadhouse', 3016, 553, 'Casual Dining & Steak'),
(27, 'Dennys', 2691, 1558, 'Family Dining & Family Style'),
(28, 'Papa Johns', 2638, 3142, 'Quick Service & Pizza'),
(29, 'Outback Steakhouse', 2635, 724, 'Casual Dining & Steak'),
(30, 'Whataburger', 2556, 830, 'Quick Service & Burger'),
(31, 'Red Lobster', 2490, 679, 'Casual Dining & Seafood'),
(32, 'Cracker Barrel', 2482, 660, 'Family Dining & Family Style'),
(33, 'The Cheesecake Factory', 2180, 206, 'Casual Dining & Varied Menu'),
(34, 'Jimmy Johns Gourmet Sandwiches', 2105, 2787, 'Fast Casual & Sandwich'),
(35, 'Hardees', 2020, 1820, 'Quick Service & Burger'),
(36, 'Zaxbys', 1886, 910, 'Fast Casual & Chicken'),
(37, 'LongHorn Steakhouse', 1867, 530, 'Casual Dining & Steak'),
(38, 'Culvers', 1795, 732, 'Quick Service & Burger'),
(39, 'Golden Corral', 1746, 483, 'Quick Service & Family Casual'),
(40, 'Five Guys Burgers and Fries', 1661, 1368, 'Fast Casual & Burger'),
(41, 'Red Robin Gourmet Burgers and Brews', 1548, 556, 'Casual Dining & Varied Menu'),
(42, 'Raising Canes Chicken Fingers', 1466, 457, 'Fast Casual & Chicken'),
(43, 'Carls Jr.', 1423, 1095, 'Quick Service & Burger'),
(44, 'Wingstop', 1363, 1231, 'Fast Casual & Chicken'),
(45, 'Waffle House', 1344, 1959, 'Family Dining & Family Style'),
(46, 'Jersey Mikes Subs', 1340, 1667, 'Fast Casual & Sandwich'),
(47, 'Bojangles', 1331, 746, 'Quick Service & Chicken'),
(48, 'BJs Restaurant & Brewhouse', 1161, 208, 'Casual Dining & Varied Menu'),
(49, 'TGI Fridays', 1085, 385, 'Casual Dining & Varied Menu'),
(50, 'In-N-Out Burger', 957, 351, 'Quick Service & Burger');



--1. Total Sales Across All Restaurants
SELECT SUM(Sales) AS Total_Sales FROM RestaurantData;

--2. Average Sales per Restaurant
SELECT AVG(Sales) AS Average_Sales FROM RestaurantData;

--3. Total Number of Units Across All Restaurants
SELECT SUM(Units) AS Total_Units FROM RestaurantData;

--4. Top 5 Restaurants by Sales
SELECT Rank, Restaurant, Sales 
FROM RestaurantData 
ORDER BY Sales DESC 
LIMIT 5;

--5. Top 5 Restaurants with Most Units
SELECT Rank, Restaurant, Units 
FROM RestaurantData 
ORDER BY Units DESC 
LIMIT 5;

--6. Average Number of Units per Restaurant
SELECT AVG(Units) AS Average_Units FROM RestaurantData;

--7. Count of Restaurants by Segment Category
SELECT Segment_Category, COUNT(*) AS Restaurant_Count 
FROM RestaurantData 
GROUP BY Segment_Category 
ORDER BY Restaurant_Count DESC;

--8. Restaurant with the Lowest Sales
SELECT Rank, Restaurant, Sales 
FROM RestaurantData 
ORDER BY Sales ASC 
LIMIT 1;

--9. Restaurant with the Highest Units
SELECT Rank, Restaurant, Units 
FROM RestaurantData 
ORDER BY Units DESC 
LIMIT 1;

--10. Total Sales by Segment Category
SELECT Segment_Category, SUM(Sales) AS Total_Sales 
FROM RestaurantData 
GROUP BY Segment_Category 
ORDER BY Total_Sales DESC;

--11. Average Sales by Segment Category
SELECT Segment_Category, AVG(Sales) AS Average_Sales 
FROM RestaurantData 
GROUP BY Segment_Category 
ORDER BY Average_Sales DESC;

--12. List Restaurants with Units Greater than 10,000
SELECT Rank, Restaurant, Units 
FROM RestaurantData 
WHERE Units > 10000 
ORDER BY Units DESC;

--13. List Restaurants with Sales Between 1,000 and 5,000
SELECT Rank, Restaurant, Sales 
FROM RestaurantData 
WHERE Sales BETWEEN 1000 AND 5000 
ORDER BY Sales ASC;

--14. Percentage Contribution of Each Segment Category to Total Sales
SELECT Segment_Category, 
       SUM(Sales) AS Total_Sales, 
       ROUND((SUM(Sales) * 100.0 / (SELECT SUM(Sales) FROM RestaurantData)), 2) AS Percentage_Contribution
FROM RestaurantData 
GROUP BY Segment_Category 
ORDER BY Percentage_Contribution DESC;

--15. Top 3 Segments with the Most Units
SELECT Segment_Category, SUM(Units) AS Total_Units 
FROM RestaurantData 
GROUP BY Segment_Category 
ORDER BY Total_Units DESC 
LIMIT 3;



