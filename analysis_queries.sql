Write a query to find how many unique books and how many total appearances each publisher
appears on our dataset, ordered by total appearances.

SELECT book_publisher
, COUNT(DISTINCT book_title) AS unique_books
, COUNT(*) AS total_appearances
FROM V_LISTS_BOOKS
GROUP BY book_publisher
ORDER BY total_appearances DESC;


Write a query that counts how many points each publisher has in our dataset, where points are
defined as such: position 1 = 15 points, position 2 = 14 points, position 3 = 13 points, etc. Do the
same for books.

-- publisher
with book_points as (
SELECT * , CASE WHEN book_rank = 1 THEN 15
                WHEN book_rank = 2 THEN 14
                WHEN book_rank = 3 THEN 13
                WHEN book_rank = 4 THEN 12
                WHEN book_rank = 5 THEN 11
                WHEN book_rank = 6 THEN 10
                WHEN book_rank = 7 THEN 9
            	  WHEN book_rank = 8 THEN 8
                WHEN book_rank = 9 THEN 7
                WHEN book_rank = 10 THEN 6
                WHEN book_rank = 11 THEN 5
                WHEN book_rank = 12 THEN 4
                WHEN book_rank = 13 THEN 3
                WHEN book_rank = 14 THEN 2
                ELSE 0 END AS points
FROM V_LISTS_BOOKS r)

select book_publisher, sum(points) points from book_points group by book_publisher order by points desc

-- books
with book_points as (
SELECT * , CASE WHEN book_rank = 1 THEN 15
                WHEN book_rank = 2 THEN 14
                WHEN book_rank = 3 THEN 13
                WHEN book_rank = 4 THEN 12
                WHEN book_rank = 5 THEN 11
                WHEN book_rank = 6 THEN 10
                WHEN book_rank = 7 THEN 9
            	  WHEN book_rank = 8 THEN 8
                WHEN book_rank = 9 THEN 7
                WHEN book_rank = 10 THEN 6
                WHEN book_rank = 11 THEN 5
                WHEN book_rank = 12 THEN 4
                WHEN book_rank = 13 THEN 3
                WHEN book_rank = 14 THEN 2
                ELSE 0 END AS points
FROM V_LISTS_BOOKS r)

select book_title, sum(points) points from book_points group by book_title order by points desc


Find which books had the longest uprising trends and how long (in months) they were, where an
uprising trend is defined as when a book has a greater or equal position in month X than in
month X - 1.

with books_month_data as(
select *, cast(substring(replace(bestsellers_date,'-'),1,6) as numeric) as bestsellers_month  FROM V_LISTS_BOOKS)

,monthly_book_lag AS (
 SELECT
  *,
  LAG(book_rank) OVER(PARTITION BY book_title ORDER BY bestsellers_month) AS previous_month_rank
  FROM books_month_data
)

SELECT
    book_title
, book_publisher
, COALESCE((round(book_rank - previous_month_rank)/previous_month_rank *100),0) AS uprising_trends
FROM monthly_book_lag;
