CREATE OR REPLACE VIEW V_LISTS_BOOKS AS
select replace(f.value:title, '\"') as book_title -- removing quote character "
, f.value:rank as book_rank
, replace(f.value:publisher, '\"') as book_publisher -- removing quote character "
, list_name
, list_name_encoded
, bestsellers_date
from V_LISTS
, lateral flatten (input => books) f
