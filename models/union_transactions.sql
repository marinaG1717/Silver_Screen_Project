{{ config(materialized='table') }}

WITH unioned AS (
    SELECT
        DISTINCT MOVIE_ID AS movie_id,
        'NJ_001' AS location,
        DATE_TRUNC('month', TIMESTAMP) AS month,
        TICKET_AMOUNT AS ticket_quantity,
        PRICE AS price
    FROM {{ source('silver_screen', 'transactions_l1') }}
    
    

    UNION ALL

    SELECT
        MOVIE_ID AS movie_id,
        'NJ_002' AS location,
        DATE_TRUNC('month', DATE) AS month,
        TICKET_AMOUNT AS ticket_quantity,
        TICKET_PRICE AS price
    FROM {{ source('silver_screen', 'transactions_l2') }}
    

    UNION ALL

    SELECT
        DETAILS AS movie_id,
        'NJ_003' AS location,
        DATE_TRUNC('month', TIMESTAMP) AS month,
        AMOUNT AS ticket_quantity,
        PRICE AS price
    FROM {{ source('silver_screen', 'transactions_l3') }}
    WHERE PRODUCT_TYPE = 'ticket' 
)

SELECT
    movie_id,
    location,
    month,
    SUM(ticket_quantity) AS total_tickets_sold,
    SUM(ticket_quantity * price) AS total_revenue
FROM unioned
GROUP BY movie_id, location, month
