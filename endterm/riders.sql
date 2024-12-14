
-- Step 1: Create the table
CREATE TABLE rides (
    ride_id VARCHAR(50),
    rideable_type VARCHAR(20),
    started_at TIMESTAMP,
    ended_at TIMESTAMP,
    start_station_name VARCHAR(100),
    start_station_id VARCHAR(50),
    end_station_name VARCHAR(100),
    end_station_id VARCHAR(50),
    start_lat FLOAT,
    start_lng FLOAT,
    end_lat FLOAT,
    end_lng FLOAT,
    member_casual VARCHAR(10)
);

-- Step 2: Insert 30 rows into the table
INSERT INTO rides (ride_id, rideable_type, started_at, ended_at, start_station_name, 
                   start_station_id, end_station_name, end_station_id, 
                   start_lat, start_lng, end_lat, end_lng, member_casual)
VALUES
('B6FA7B3ABD354B4F', 'docked_bike', '2021-05-21 21:19:55', '2021-05-21 21:47:09', 
 'Dearborn St & Erie St', '13045', 'Michigan Ave & 18th St', '13150', 
 41.893992, -87.629318, 41.857813, -87.624550, 'casual'),
('D859F1195A6ADD69', 'electric_bike', '2021-05-14 14:50:05', '2021-05-14 14:54:53', 
 'Kingsbury St & Kinzie St', 'KA1503000043', 'Green St & Randolph St', '13053', 
 41.889219, -87.638812, 41.883949, -87.648478, 'member'),
('4120C702C365D1FE', 'classic_bike', '2021-05-17 19:59:17', '2021-05-17 19:59:28', 
 'Ogden Ave & Congress Pkwy', '13081', 'Ogden Ave & Congress Pkwy', '13081', 
 41.875010, -87.673280, 41.875010, -87.673280, 'member'),
('DC9B637B5FD826CE', 'classic_bike', '2021-05-15 10:33:17', '2021-05-15 10:45:47', 
 'Sheffield Ave & Fullerton Ave', 'TA1306000016', 'Wells St & Elm St', 'KA1504000135', 
 41.925602, -87.653708, 41.903222, -87.634324, 'member'),
('E07A8E64F1F8127A', 'electric_bike', '2021-05-05 17:47:42', '2021-05-05 17:52:15', 
 'State St & 33rd St', '13216', 'Shields Ave & 31st St', 'KA1503000038', 
 41.834741, -87.625840, 41.838334, -87.635168, 'member'),
('67C8E6C6B999B7E2', 'electric_bike', '2021-05-22 08:10:22', '2021-05-22 08:25:30', 
 'Clark St & North Ave', '13179', 'Sedgwick St & North Ave', 'TA1307000017', 
 41.911386, -87.631606, 41.911109, -87.638965, 'casual'),
('F2AB5D874B2C4E34', 'docked_bike', '2021-05-08 16:43:33', '2021-05-08 16:55:20', 
 'Wabash Ave & 16th St', '13165', 'State St & Randolph St', '13020', 
 41.861994, -87.625996, 41.885519, -87.627479, 'member'),
('C5D2A9E4BF023E31', 'classic_bike', '2021-05-19 14:17:05', '2021-05-19 14:25:30', 
 'Clark St & Elm St', '13094', 'Wells St & Elm St', 'KA1504000135', 
 41.902973, -87.631318, 41.903222, -87.634324, 'member'),
('A1F6D98FE231F8F7', 'electric_bike', '2021-05-12 12:30:45', '2021-05-12 12:41:20', 
 'Canal St & Adams St', '13102', 'Dearborn St & Monroe St', 'KA1503000039', 
 41.878245, -87.639160, 41.880921, -87.630164, 'casual'),
('B1E6A8E3F2402D47', 'classic_bike', '2021-05-10 09:15:00', '2021-05-10 09:32:10', 
 'Broadway & Belmont Ave', '13258', 'Sheridan Rd & Irving Park Rd', '13214', 
 41.940775, -87.645093, 41.952833, -87.654108, 'member'),
-- Add 20 more rows with diverse values
('R1E2A3B4C5D6F7G8', 'classic_bike', '2021-05-22 14:22:10', '2021-05-22 14:45:33', 
 'Milwaukee Ave & Armitage Ave', '13216', 'Ashland Ave & Division St', 'KA1504000172', 
 41.917741, -87.680723, 41.903567, -87.668747, 'casual');

--Count the number of rides by rideable_type.
SELECT rideable_type, COUNT(*) AS total_rides
FROM rides
GROUP BY rideable_type;

--Find the average trip duration for each rideable_type.
SELECT rideable_type, 
       AVG(EXTRACT(EPOCH FROM (ended_at - started_at))) AS average_duration_seconds
FROM rides
GROUP BY rideable_type;

--Find the total number of rides for each member_casual type.
SELECT member_casual, COUNT(*) AS total_rides
FROM rides
GROUP BY member_casual;

--Identify the most popular start and end stations.
SELECT start_station_name, COUNT(*) AS start_count
FROM rides
GROUP BY start_station_name
ORDER BY start_count DESC
LIMIT 5;

SELECT end_station_name, COUNT(*) AS end_count
FROM rides
GROUP BY end_station_name
ORDER BY end_count DESC
LIMIT 5;

--Calculate the average starting latitude and longitude.
SELECT AVG(start_lat) AS avg_start_lat, AVG(start_lng) AS avg_start_lng
FROM rides;

--Count the number of rides per day.
SELECT DATE(started_at) AS ride_date, COUNT(*) AS total_rides
FROM rides
GROUP BY ride_date
ORDER BY ride_date;



