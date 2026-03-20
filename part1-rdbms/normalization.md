### Anomaly Analysis
## Insert Anomaly

In the dataset, product-related columns such as product_id, product_name, category, and unit_price are always tied to an order_id.

Example rows:

Row with order_id = ORD1027 (product: Notebook)

Row with order_id = ORD1002 (product: Headphones)

Problem:
There is no row where a product exists without an order.
This means a new product (e.g., a new laptop) cannot be inserted unless an order is created.

Columns involved:
product_id, product_name, unit_price, order_id

Conclusion:
This is an Insert Anomaly because the system does not allow independent insertion of product data.

## Update Anomaly

The product “Pen Set” appears in multiple rows:

Example rows:

order_id = ORD1114

order_id = ORD1153

order_id = ORD1118

order_id = ORD1132

order_id = ORD1037

(All these rows have product_name = 'Pen Set' and same price)

Problem:
If the unit_price of “Pen Set” changes (e.g., 250 → 300),
it must be updated in all these rows.

Risk:
If one row is missed → inconsistent data

Columns involved:
product_name, unit_price

Conclusion:
This is an Update Anomaly because duplicate data must be updated in multiple places.

## Delete Anomaly (with exact row)

Consider this row:

Example:

order_id = ORD1002

product_id = P005

product_name = Headphones

Problem:
If this row is deleted and it is the only occurrence of that product in some cases,
then all information about the product is lost.

This includes:

product name

category

price

Columns involved:
order_id, product_id, product_name

Conclusion:
This is a Delete Anomaly because deleting an order can remove important product data.

These anomalies arise because multiple entities such as customers, products, orders, and sales representatives are stored in a single table, violating normalization principles.