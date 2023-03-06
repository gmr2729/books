--  copy command to load the required ndjson files into snowflake from s3
COPY INTO NATURAL_CYCLES.PUBLIC.RAW_BOOKS 
FROM '@sf_s3_stage/'
FILES=('combined-print-and-e-book-fiction.ndjson', 'combined-print-and-e-book-nonfiction.ndjson', 'hardcover-fiction.ndjson','hardcover-nonfiction.ndjson','trade-fiction-paperback.ndjson')
FILE_FORMAT = (TYPE = 'JSON' STRIP_OUTER_ARRAY = TRUE);
