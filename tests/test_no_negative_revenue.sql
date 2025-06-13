SELECT *
FROM {{ ref('final_rental_movie_info') }}
WHERE total_revenue < 0