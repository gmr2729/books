-- database schema created
create database NATURAL_CYCLES
create schema NATURAL_CYCLES.PUBLIC

-- variant type table created to store the raw data from S3
create table NATURAL_CYCLES.PUBLIC.RAW_BOOKS
(SRC_JSON VARIANT)

-- json format created
create or replace file format json_format
type = 'JSON'
compression = 'AUTO'
field_delimiter = 'none' 
record_delimiter = '\n';

-- storage integration created for handshanking aws and snowflake
CREATE STORAGE INTEGRATION s3_int
  TYPE = EXTERNAL_STAGE
  STORAGE_PROVIDER = 'S3'
  ENABLED = TRUE
  STORAGE_AWS_ROLE_ARN = 'arn:aws:iam::478945680190:role/snowflakerole'
  STORAGE_ALLOWED_LOCATIONS = ('s3://api-ingestion-nc')


  DESC INTEGRATION s3_int;

-- Roles created to assign required permisson to the stage and storage integration 
  CREATE ROLE sfrole;
  
  GRANT CREATE STAGE ON SCHEMA NATURAL_CYCLES.PUBLIC TO ROLE sfrole;

  GRANT USAGE ON INTEGRATION s3_int TO ROLE sfrole;

-- stage created based on s3 bucket
  CREATE OR REPLACE STAGE sf_s3_stage
  STORAGE_INTEGRATION = s3_int
  URL = 's3://api-ingestion-nc/'

  list @sf_s3_stage -- we can visualise s3 files for the bucket using list on snowflake
