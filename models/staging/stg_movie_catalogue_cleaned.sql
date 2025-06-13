SELECT 
DISTINCT movie_id,
  movie_title,
  COALESCE(genre, 'Unknown') AS genre,
  studio
FROM {{ source('silver_screen', 'movie_catalogue') }}
-- for staging
 
