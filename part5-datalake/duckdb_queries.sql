-- Q1: List all customers along with the total number of orders they have placed
SELECT
  c.customer_id,
  c.name,
  c.city,
  COUNT(o.order_id) AS total_orders
FROM read_csv_auto('customers.csv') AS c
LEFT JOIN read_json_auto('orders.json') AS o
  ON o.customer_id = c.customer_id
GROUP BY c.customer_id, c.name, c.city
ORDER BY total_orders DESC, c.customer_id;


-- Q2: Find the top 3 customers by total order value
SELECT
  c.customer_id,
  c.name,
  SUM(o.total_amount) AS total_order_value
FROM read_csv_auto('customers.csv') AS c
JOIN read_json_auto('orders.json') AS o
  ON o.customer_id = c.customer_id
GROUP BY c.customer_id, c.name
ORDER BY total_order_value DESC
LIMIT 3;


-- Q3: List all products purchased by customers from Bangalore
-- Assumes orders.json has order line items with product_id (or similar).
-- If your orders.json instead has a single product_id field, adapt accordingly.
SELECT DISTINCT
  p.product_id,
  p.product_name
FROM read_csv_auto('customers.csv') AS c
JOIN read_json_auto('orders.json') AS o
  ON o.customer_id = c.customer_id
-- If orders has an items array: [{"product_id":..., "quantity":...}, ...]
CROSS JOIN UNNEST(o.items) AS i
JOIN read_parquet('products.parquet') AS p
  ON p.product_id = i.product_id
WHERE c.city = 'Bangalore'
ORDER BY p.product_name;


-- Q4: Join all three files to show: customer name, order date, product name, and quantity
-- Assumes orders.json has items array with product_id and quantity.
SELECT
  c.name AS customer_name,
  o.order_date,
  p.product_name,
  i.quantity
FROM read_csv_auto('customers.csv') AS c
JOIN read_json_auto('orders.json') AS o
  ON o.customer_id = c.customer_id
CROSS JOIN UNNEST(o.items) AS i
JOIN read_parquet('products.parquet') AS p
  ON p.product_id = i.product_id
ORDER BY o.order_date, c.name, p.product_name;