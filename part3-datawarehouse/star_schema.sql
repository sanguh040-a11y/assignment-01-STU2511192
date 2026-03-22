-- Dimension table: date
CREATE TABLE dim_date (
    date_id INT PRIMARY KEY,
    date DATE,
    year INT,
    month INT,
    day INT
);

-- Dimension table: store
CREATE TABLE dim_store (
    store_id INT PRIMARY KEY,
    store_name VARCHAR(100),
    city VARCHAR(50)
);

-- Dimension table: product
CREATE TABLE dim_product (
    product_id VARCHAR(20) PRIMARY KEY,
    product_name VARCHAR(100),
    category VARCHAR(50),
    brand VARCHAR(50)
);

-- Fact table: sales
CREATE TABLE fact_sales (
    sales_id INT PRIMARY KEY,
    date_id INT,
    store_id INT,
    product_id VARCHAR(20),
    units_sold INT,
    total_amount DECIMAL(10,2),
    FOREIGN KEY (date_id) REFERENCES dim_date(date_id),
    FOREIGN KEY (store_id) REFERENCES dim_store(store_id),
    FOREIGN KEY (product_id) REFERENCES dim_product(product_id)
);

-- Insert sample data (example for date dimension)
INSERT INTO dim_date VALUES
(20230101, '2023-01-01', 2023, 1, 1),
(20230102, '2023-01-02', 2023, 1, 2),
-- ... Continue for 10+ dates

-- Insert into store
INSERT INTO dim_store VALUES
(1, 'Bangalore MG', 'Bangalore'),
(2, 'Delhi South', 'Delhi'),
-- ... Additional stores

-- Insert into product
INSERT INTO dim_product VALUES
('CUST007', 'Jeans', 'Clothing', 'Levis'),
('CUST037', 'Pulses 1kg', 'Grocery', 'Organic Farms'),
-- ... Additional products

-- Insert into fact_sales (standardized and cleaned)
INSERT INTO fact_sales VALUES
(1001, 20230101, 1, 'CUST007', 16, 2317.47 * 16),
(1002, 20230102, 2, 'CUST037', 10, 2317.47 * 10),
-- ... and at least 8 more rows