-- Q1: Total sales revenue by product category for each month
SELECT
    dd.year,
    dd.month,
    pd.category,
    SUM(fs.total_amount) AS total_revenue
FROM fact_sales fs
JOIN dim_date dd ON fs.date_id = dd.date_id
JOIN dim_product pd ON fs.product_id = pd.product_id
GROUP BY dd.year, dd.month, pd.category
ORDER BY dd.year, dd.month, pd.category;

-- Q2: Top 2 performing stores by total revenue
SELECT
    ds.store_name,
    SUM(fs.total_amount) AS total_revenue
FROM fact_sales fs
JOIN dim_store ds ON fs.store_id = ds.store_id
GROUP BY ds.store_name
ORDER BY total_revenue DESC
LIMIT 2;

-- Q3: Month-over-month sales trend across all stores
SELECT
    dd.year,
    dd.month,
    SUM(fs.total_amount) AS monthly_revenue
FROM fact_sales fs
JOIN dim_date dd ON fs.date_id = dd.date_id
GROUP BY dd.year, dd.month
ORDER BY dd.year, dd.month;