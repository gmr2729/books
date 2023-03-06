# books api integration

The main objective of the task to read json data from books api and load the required data into Snowflake. Create table and views on top on Snowflake and run the analytical queries as per the requirement.

# Architecture

![image](https://user-images.githubusercontent.com/127125623/223197314-04a15fbd-ae4d-40d4-a1ae-10ce12a2b824.png)

The python code is written in AWS Lambda which read json from books api and fetch required list based on list_name. 
Once the data fetch is completed for 5 list_names the data is pushed into S3. 
The handshaking code between AWS and S3 can also be found out in aws_sf_configuration.sql. 
Created variant type table to handle json loading and using copy command to load the data into snowflake.

As per the requirement I am also creating views on top of the json data and extracting the json data and flattening json data as per requirement. I have also showcased the analytical queries as per the case study.



# Histogram of total appearances of each publisher

![image](https://user-images.githubusercontent.com/127125623/223199305-c97a20c9-85c3-47d3-bfec-6e6adbf2b05e.png)
