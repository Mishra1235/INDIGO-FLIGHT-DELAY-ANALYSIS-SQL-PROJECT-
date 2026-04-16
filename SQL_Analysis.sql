### Data Analysis

### Route wise Flight analysis 

SELECT 
     f.ORIGIN_AIRPORT_ID,
     f.DEST_AIRPORT_ID,
     a1.CITY_NAME AS ORIGIN_CITY,
     a2.CITY_NAME AS DEST_CITY,
     SUM(fm.PASSENGERS) AS TOTAL_PASSENGERS
FROM Flight f 
JOIN Flightmetrics fm ON f.FLIGHT_ID = fm.FLIGHT_ID
JOIN Airport a1 ON f.ORIGIN_AIRPORT_ID = a1.AIRPORT_ID
JOIN Airport a2 ON f.DEST_AIRPORT_ID = a2.AIRPORT_ID
GROUP BY f.ORIGIN_AIRPORT_ID, f.DEST_AIRPORT_ID    
ORDER BY TOTAL_PASSENGERS DESC
limit 10;

## Total Passengers Served in the duration.   

SELECT
     f.YEAR,
     f.MONTH,
     round(SUM(fm.PASSENGERS)/1000000,2) AS TOTAL_PASSENGERS
FROM Flight f      
JOIN Flightmetrics fm ON f.FLIGHT_ID = fm.FLIGHT_ID  
GROUP BY f.YEAR, f.MONTH  
ORDER BY f.YEAR, f.MONTH;  

## Determine average passengers per flight for various routes and airports.  
 
 use flight_analysis;
 
## Average Passengers Per origin city 
 
 SELECT
	 f.ORIGIN_AIRPORT_ID,
     a.CITY_NAME AS ORIGIN_CITY,
     COUNT(f.FLIGHT_ID) AS TOTAL_FLIGHTS,
     SUM(fm.PASSENGERS) AS TOTAL_PASSENGERS,
     ROUND(AVG(fm.PASSENGERS), 2) AS AVG_PASSENGERS_PER_FLIGHT  
FROM Flight f 
JOIN Flightmetrics fm ON f.FLIGHT_ID = fm.FLIGHT_ID 
JOIN Airport a ON f.ORIGIN_AIRPORT_ID = a.AIRPORT_ID 
GROUP BY f.ORIGIN_AIRPORT_ID 
ORDER BY AVG_PASSENGERS_PER_FLIGHT DESC;    

## Average Passengers Per Destination city  

SELECT 
     F.DEST_AIRPORT_ID,  
     a.CITY_NAME AS DEST_CITY, 
     COUNT(f.FLIGHT_ID) AS TOTAL_FLIGHTS, 
     SUM(fm.PASSENGERS) AS TOTAL_PASSENGERS,
     ROUND(AVG(fm.PASSENGERS), 2) AS AVG_PASSENGERS_PER_FLIGHT  
FROM Flight f 
JOIN Flightmetrics fm ON f.FLIGHT_ID = fm.FLIGHT_ID 
JOIN Airport a ON f.DEST_AIRPORT_ID = a.AIRPORT_ID  
GROUP BY f.DEST_AIRPORT_ID  
ORDER BY AVG_PASSENGERS_PER_FLIGHT DESC;   
 




