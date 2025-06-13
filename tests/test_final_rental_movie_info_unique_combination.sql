SELECT
  movie_id,
  location,
  month,
  COUNT(*) AS row_count
FROM {{ ref('final_rental_movie_info') }}
GROUP BY 1, 2, 3
HAVING COUNT(*) > 1