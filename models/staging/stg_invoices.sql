with source_invoices as (
    select * 
    from {{ source('silver_screen', 'invoices') }}
),

cleaned_invoices as (
    select
        movie_id,
        LOCATION_ID as location,
        date_trunc('month', MONTH) as month,
        SUM(TOTAL_INVOICE_SUM) as rental_cost  
    from source_invoices
    group by 1,2,3
)

select * from cleaned_invoices
