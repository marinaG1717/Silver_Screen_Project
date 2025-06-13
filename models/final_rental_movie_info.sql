with movies as (
    select * from {{ ref('stg_movie_catalogue_cleaned') }}
),

transactions as (
    select * from {{ ref('union_transactions') }}
),

invoices as (
    select * from {{ ref('stg_invoices') }}
)

select
    m.movie_id,
    m.movie_title,
    m.genre,
    m.studio,
    t.month,
    t.location,
    i.rental_cost,
    t.total_tickets_sold,
    t.total_revenue
from transactions t
inner join movies m
    on t.movie_id = m.movie_id
inner join invoices i
    on t.movie_id = i.movie_id
    and t.location = i.location
    and t.month = i.month


