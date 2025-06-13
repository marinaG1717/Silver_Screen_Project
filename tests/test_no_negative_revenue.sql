--This test fails if any rows in final_rental_movie_info have negative revenue.

SELECT *
FROM {{ ref('final_rental_movie_info') }}
WHERE total_revenue < 0