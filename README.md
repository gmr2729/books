# books api integration

The main objective of the task to read json data from books api and load the required data into Snowflake. Create table and views on top on Snowflake and run the analytical queries as per the requirement.

The python code is written in AWS Lambda which read json from books api and fetch required list based on list_name. Once the data fetch is completed for 5 list_names the data is pushed into S3. 
The handshaking code between AWS and S3 can also be found out in aws_sf_configuration.sql. 
I have created variant type table to handle json loading and using copy command to load the data into snowflake.

As per the requirement we are also creating views on top of the json data and extracting the json data and flattening json data as per requirement. I have also showcased the analytical queries as per the case study.


