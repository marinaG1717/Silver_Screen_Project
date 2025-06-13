{{ config(materialized='table') }}

WITH agg_transactions AS (
    SELECT
        movie_id,
        location,
        DATE_TRUNC('month', month) AS month,
        SUM(total_tickets_sold) AS total_tickets_sold,
        SUM(total_revenue) AS total_revenue
    FROM {{ ref('union_transactions') }}
    WHERE EXTRACT(YEAR FROM month) = 2024
    GROUP BY movie_id, location, DATE_TRUNC('month', month)
),

rental AS (
    SELECT
        MOVIE_ID AS movie_id,
        LOCATION_ID AS location,
        DATE_TRUNC('month', MONTH) AS month,
        TOTAL_INVOICE_SUM AS rental_cost
    FROM {{ source('silver_screen', 'invoices') }}
),

movie_info AS (
    SELECT
        movie_id,
        movie_title,
        genre,
        studio
    FROM {{ ref('movie_catalogue_cleaned') }}
)

SELECT
    t.movie_id,
    m.movie_title,
    m.genre,
    m.studio,
    t.month,
    t.location,
    COALESCE(r.rental_cost, 0) AS rental_cost, 
    t.total_tickets_sold,
    t.total_revenue
FROM agg_transactions t
LEFT JOIN rental r
    ON t.movie_id = r.movie_id 
    AND t.location = r.location
    AND t.month = r.month
LEFT JOIN movie_info m
    ON t.movie_id = m.movie_id
