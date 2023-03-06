CREATE OR REPLACE VIEW V_LISTS
(list_name, list_name_encoded, bestsellers_date, books)
AS
(
with json_data as
(SELECT json_extract_path_text (SRC_JSON,'results') as results
FROM RAW_BOOKS)

select json_extract_path_text(results,'list_name') as list_name
, json_extract_path_text(results,'list_name_encoded') as list_name_encoded
, to_date(json_extract_path_text(results,'bestsellers_date')) as bestsellers_date
, parse_json(json_extract_path_text(results,'books')) as books 
  from json_data )
