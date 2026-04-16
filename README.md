✈️ INDIGO FLIGHT DELAY & TRAFFIC ANALYSIS (SQL) 

📌 Project Overview
This project focuses on analyzing flight data to identify traffic patterns, passenger distribution, and the correlation between city population and air traffic. The analysis is built upon a comprehensive master dataset, which was transformed into a structured relational database for deeper insights.

📂 Data Source (The Master Table)
The foundation of this project is the Master_Meta_Data (from Airport_Project_Data.csv). This master table contains raw flight records including:

Carrier Info: Unique Carrier Codes, Names, and Entities.

Geographic Data: Origin/Destination Airport IDs, City Names, and State details.

Flight Metrics: Number of Passengers, Freight, Mail, and Distance.

Temporal Data: Year, Quarter, and Month of operations.

🏗️ ETL & Database Architecture (Normalization)
To optimize the raw data, I performed an ETL (Extract, Transform, Load) process to break the flat master table into a normalized schema:

Airline Table: Extracted from UNIQUE_CARRIER_NAME to remove redundancy.

Airport Table: Created by mapping unique AIRPORT_ID with city and state attributes.

Flight Table: Centralized flight schedules linked to Airlines and Airports via Foreign Keys.

FlightMetrics Table: Stores quantitative values (Passengers, Freight) linked to each unique FLIGHT_ID.

City Table: Integrated external population data to analyze traffic density.

🛠️ Technical Implementation
Language: SQL (MySQL)

Data Cleaning: Used SUBSTRING_INDEX to clean city names (e.g., removing state codes from city strings) and handled null values in FREIGHT and MAIL columns.

Advanced SQL Objects:

Stored Procedures: Developed State_level_traffic for dynamic reporting.

Views: Created Pass_Pop_Des and Pass_Pop_Ori to simplify the complex relationship between population and traffic volume.

📊 Key Business Insights
Busiest Corridors: Identified top 10 routes based on flight frequency and passenger load.

Traffic vs. Population: Discovered cities where air traffic significantly exceeds the local population, indicating major transit hubs.

Trend Analysis: Monthly reporting of passenger volume (in Millions) to identify seasonal peaks.

🔍 Featured SQL Query: Data Transformation
This is how I populated the normalized Flight table from the Master dataset:

SQL
INSERT INTO Flight (AIRLINE_ID, ORIGIN_AIRPORT_ID, DEST_AIRPORT_ID, DISTANCE, YEAR, QUARTER, MONTH, CLASS)
SELECT 
    AIRLINE_ID, ORIGIN_AIRPORT_ID, DEST_AIRPORT_ID, DISTANCE, YEAR, QUARTER, MONTH, CLASS
FROM Master_Meta_Data;
🚀 How to Run
Load the Airport_Project_Data.csv as Master_Meta_Data.

Execute Table Creation.sql to build the relational structure.

Run Data_Insertion.sql to migrate data from the master table to normalized tables.

Execute analysis scripts for insights.
