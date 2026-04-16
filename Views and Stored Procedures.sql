## Creating Views  

use flight_analysis;  
create view Pass_Pop_Des as 
 SELECT  
     c.CITY_NAME, 
     c.POPULATION, 
     sum(fm.PASSENGERS) AS TOTAL_PASSENGERS, 
     count(f.flight_id) as TOTAL_Flights,
     round(SUM(fm.PASSENGERS)/c.Population,2) as Pass_Pop_Ratio
FROM City c 
JOIN Airport a ON a.CITY_NAME = c.CITY_NAME 
JOIN Flight f ON f.Dest_AIRPORT_ID = a.AIRPORT_ID 
JOIN Flightmetrics fm ON f.FLIGHT_ID = fm.FLIGHT_ID 
GROUP BY c.CITY_NAME, c.POPULATION 
ORDER BY Pass_Pop_ratio DESC;  

select * from Pass_Pop_Des;   

create view Pass_Pop_Ori as 
 SELECT  
     c.CITY_NAME, 
     c.POPULATION, 
     sum(fm.PASSENGERS) AS TOTAL_PASSENGERS,  
     round(SUM(fm.PASSENGERS)/c.Population,2) as Pass_Pop_Ratio
FROM City c 
JOIN Airport a ON a.CITY_NAME = c.CITY_NAME 
JOIN Flight f ON f.ORIGIN_AIRPORT_ID = a.AIRPORT_ID 
JOIN Flightmetrics fm ON f.FLIGHT_ID = fm.FLIGHT_ID 
GROUP BY c.CITY_NAME, c.POPULATION 
ORDER BY Pass_Pop_ratio DESC;  

 select * from Pass_Pop_Ori;  
 
 ## Stored Procedures 
 
 DELIMITER //  
 create procedure traffic() 
 Begin 
 SELECT 
     a.CITY_NAME AS ORIGIN_CITY,  
     SUM(fm.PASSENGERS) AS TOTAL_PASSENGERS,
     COUNT(f.FLIGHT_ID) AS TOTAL_FLIGHTS  
FROM Flight f 
JOIN Flightmetrics fm ON f.FLIGHT_ID = fm.FLIGHT_ID 
JOIN Airport a ON f.Dest_AIRPORT_ID = a.AIRPORT_ID 
GROUP BY a.CITY_NAME  
ORDER BY Total_Flights DESC; 
End //   


DELIMITER //  
Create Procedure State_level_traffic(IN State varchar(30))  
Begin  
 SELECT 
     a.CITY_NAME AS ORIGIN_CITY,  
     SUM(fm.PASSENGERS) AS TOTAL_PASSENGERS,
     COUNT(f.FLIGHT_ID) AS TOTAL_FLIGHTS  
FROM Flight f 
JOIN Flightmetrics fm ON f.FLIGHT_ID = fm.FLIGHT_ID 
JOIN Airport a ON f.Dest_AIRPORT_ID = a.AIRPORT_ID
where a.state_nm = State 
GROUP BY a.CITY_NAME  
ORDER BY Total_Flights DESC; 
End //   
   
call state_level_traffic("Florida");  


DELIMITER // 

CREATE PROCEDURE sp_top_routes_by_passenger(IN threshold INT)   
BEGIN  
     SELECT   
          a1.CITY_NAME AS ORIGIN_CITY,  
          a2.CITY_NAME AS DEST_CITY, 
          SUM(fm.PASSENGERS) AS TOTAL_PASSENGERS  
          FROM Flight f  
          JOIN Flightmetrics fm ON f.FLIGHT_ID = fm.FLIGHT_ID  
          JOIN Airport a1 ON f.ORIGIN_AIRPORT_ID = a1.AIRPORT_ID  
          JOIN Airport a2 ON f.DEST_AIRPORT_ID = a2.AIRPORT_ID  
          GROUP BY a1.CITY_NAME, a2.CITY_NAME 
          HAVING TOTAL_PASSENGERS > threshold  
          ORDER BY TOTAL_PASSENGERS DESC;  
END //          

DELIMITER ;

call sp_top_routes_by_passenger(100000);    





  