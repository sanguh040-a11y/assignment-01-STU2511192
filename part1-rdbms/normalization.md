## Anomaly Analysis
Insert Anomaly

If you want to add a new product (e.g., a new item in inventory), you cannot insert it unless an order exists.
Example:
Columns involved: product_id, product_name, category, unit_price

Problem: Product data is tied to order_id

Meaning:
You cannot store a product independently → must wait for an order → bad design

Update Anomaly

If a product or customer detail changes, it must be updated in multiple rows.

Example:

Columns: product_name, unit_price

If product price changes → appears in many rows → must update everywhere

Risk:
If one row is missed → inconsistent data

Delete Anomaly

If you delete an order, you may lose important data.

Example:

If a row with a product is deleted → product info is lost

Columns: order_id, product_id, product_name

Meaning:
Deleting one order may remove:

Product info

Customer info

Sales rep info
