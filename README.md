
# NATURAL CYCLES DWH Solution: 

# Basic architecture overview 
The overview of the architecture is to take data from firestore or various sources, have ELT process setup around Snowflake. Transform the data as per business rules in Snowflake various layers and populate the data in Analytics layer so that the reporting teams can consume the data and business decisions can be made. 

# ELT DESIGN

![image](https://user-images.githubusercontent.com/127125623/223420329-c66790c2-e324-4e90-b2cc-70cc1beeb055.png)


SOURCE : Load source data as it is coming from data sources  
STAGING : Load the data from source layer, segregation, cleansing , take required columns into staging  
CURATED : Handles the business transformation logic and scd types depending on the use cases  
WAREHOUSE : Building of data warehouse by consuming the dimension tables  
ANALYTICS : Creating Views as per business use case and pass the views to reporting team

# Reduces the time to making changes considering integration complexity and the handles new data sources

1. Adding Source identifier  
2. Load the data as it is and take required columns into staging   
3. Transformation of data in desired target format  
4. Proper maintaining of the audit columns( ins_dt, upd_dt, flag, surrogate_key)  
5. Designing based on requirements and maintain the history data based on scd types   

# Delivering data warehouse pipelines using business rules, clean and reliable data

1. Data profiling  
2. Checking row level duplicates   
3. Checking column level constraint violations   
4. Type casting of columns as per the requirements  
5. Open Communication with the source team if something changes from their side  


# Snowflake Data warehouse best practices

1.	Data files roughly 100-250 MB (or larger) in size compressed  
2.	Using Snowpipe to auto ingest continious data into Snowflake  
3.	Dedicating Separate Warehouses to Load and Query Operations  
4.	Proper use of Scale up and Scale out for Virtual Warehouses  

# books api integration

The main objective of the task to read json data from books api and load the required data into Snowflake. Create table and views on top on Snowflake and run the analytical queries as per the requirement.

# Architecture

![image](https://user-images.githubusercontent.com/127125623/223197314-04a15fbd-ae4d-40d4-a1ae-10ce12a2b824.png)

1. The python code is written in AWS Lambda which read json from books api and fetch required list based on list_name.  
   
2. Once the data fetch is completed for 5 list_names the data is pushed into S3.

   python code - newest_list.py, retrieve_books_api.py

3. The handshaking code between AWS and S3 can also be found out in aws_sf_configuration.sql. 

-- storage integration created for handshanking aws and snowflake  

-- Roles created to assign required permisson to the stage and storage integration   

-- stage created based on s3 bucket  
 
-- list @sf_s3_stage -- to visualise s3 files for the bucket using list on snowflake

4. Created variant type table to handle json loading and using copy command to load the data into snowflake.  

As per the requirement I am also creating views on top of the json data and extracting the json data and flattening json data as per requirement. I have also showcased the analytical queries as per the case study.



# Histogram of total appearances of each publisher

![image](https://user-images.githubusercontent.com/127125623/223199305-c97a20c9-85c3-47d3-bfec-6e6adbf2b05e.png)
