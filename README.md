# 🎬 Silver Screen Analytics — dbt Project

This project models and analyzes rental and ticket sales data from the **Silver Screen** movie platform using dbt.  
It transforms raw invoice and transaction data into clean, report-ready tables for monthly movie performance tracking.

---

## 📁 Project Structure
<pre>
├── models/
│ ├── staging/
│ │ ├── stg_invoices.sql
│ │ └── stg_movie_catalogue_cleaned.sql
│ 
│ ├── final_rental_movie_info.sql

│ ├── union_transactions.sql
│
├── tests/
│ └── test_final_rental_movie_info_duplicates.sql
  └── test_final_rental_movie_info_unique_combination.sql
│
├── schema.yml
└── README.md
</pre>

## 📊 Data Models

### `stg_movie_catalogue_cleaned`

> Cleans and standardizes movie metadata. Missing genres are replaced with `'Unknown'`.

**Columns**:

- `movie_id` (PK, not null)
- `movie_title` (not null)
- `genre`
- `studio`

---

### `stg_invoices`

> Aggregates raw invoice data by `movie_id`, `location`, and `month`.

**Columns**:

- `movie_id` (FK)
- `location`
- `month`
- `rental_cost`

---

### `union_transactions`

> Unifies ticket sales from three sources (`transactions_l1`, `l2`, `l3`) with monthly aggregation.

**Columns**:

- `movie_id`
- `location`
- `month`
- `total_tickets_sold`
- `total_revenue`

---

### `final_rental_movie_info`

> Final fact model that combines rental and transaction data with movie metadata.

**Columns**:

- `movie_id`
- `movie_title`
- `genre`
- `studio`
- `month`
- `location`
- `rental_cost`
- `total_tickets_sold`
- `total_revenue`

---

## ✅ Tests

- **Singular test**: `test_final_rental_movie_info_duplicates.sql`  
  Ensures no duplicate rows exist for a given `movie_id`, `location`, and `month`.

---

## 📌 Usage

To run the project:

```bash
dbt deps
dbt seed
dbt run
dbt test
```

---

### 📌 📅 Target Use Cases

Financial reporting per location

Monthly movie rental revenue tracking

Studio performance comparison

Genre-based trend analysis

---

## 🔗 Sources

Source data is defined in `schema.yml` under the `silver_screen` source.

**Included tables**:

- `movie_catalogue`: original metadata on movies
- `invoices`: raw rental data
- `transactions_l1`, `transactions_l2`, `transactions_l3`: ticket sale sources

Defined using:

```yaml
sources:
  - name: silver_screen
    schema: PUBLIC
    tables:
      - name: movie_catalogue
      - name: invoices
      - name: transactions_l1
      - name: transactions_l2
      - name: transactions_l3
```
