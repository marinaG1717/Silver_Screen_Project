{{ config(materialized='table') }}

SELECT
  movie_id,
  movie_title,
  director,
  COALESCE(genre, 'Unknown') AS genre,
  minutes,        
  budget,
  country,
  rating,
  DATE_TRUNC('month', release_date) AS month,
  studio
FROM {{ source('silver_screen', 'movie_catalogue') }}