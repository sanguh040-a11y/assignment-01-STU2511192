-- DATABASE SCHEMA DESIGN
--Customers
CREATE TABLE Customers (
    customer_id VARCHAR(10) PRIMARY KEY,
    customer_name VARCHAR(100) NOT NULL,
    customer_email VARCHAR(100) NOT NULL,
    customer_city VARCHAR(50) NOT NULL
);

--Products
CREATE TABLE Products (
    product_id VARCHAR(10) PRIMARY KEY,
    product_name VARCHAR(100) NOT NULL,
    category VARCHAR(50),
    unit_price DECIMAL(10,2) NOT NULL
);

--Sales Representatives
CREATE TABLE Sales_Reps (
    sales_rep_id VARCHAR(10) PRIMARY KEY,
    sales_rep_name VARCHAR(100),
    sales_rep_email VARCHAR(100),
    office_address VARCHAR(200)
);

--Orders

CREATE TABLE Orders (
    order_id VARCHAR(10) PRIMARY KEY,
    customer_id VARCHAR(10),
    sales_rep_id VARCHAR(10),
    order_date DATE,
    FOREIGN KEY (customer_id) REFERENCES Customers(customer_id),
    FOREIGN KEY (sales_rep_id) REFERENCES Sales_Reps(sales_rep_id)
);

-- Order Details
CREATE TABLE Order_Details (
    order_id VARCHAR(10),
    product_id VARCHAR(10),
    quantity INT NOT NULL,
    PRIMARY KEY (order_id, product_id),
    FOREIGN KEY (order_id) REFERENCES Orders(order_id),
    FOREIGN KEY (product_id) REFERENCES Products(product_id)
);

--INSERT data

INSERT INTO Customers VALUES
('C001','Rahul Sharma','rahul@email.com','Mumbai'),
('C002','Amit Verma','amit@email.com','Delhi'),
('C003','Sneha Iyer','sneha@email.com','Chennai'),
('C004','Priya Singh','priya@email.com','Mumbai'),
('C005','Karan Mehta','karan@email.com','Pune');

INSERT INTO Products VALUES
('P001','Laptop','Electronics',50000),
('P002','Mobile Phone','Electronics',30000),
('P003','Desk Chair','Furniture',8500),
('P004','Notebook','Stationery',120),
('P005','Headphones','Electronics',3200),
('P006','Standing Desk','Furniture',22000),
('P007','Pen Set','Stationery',250);

INSERT INTO Sales_Reps VALUES
('SR01','Rahul Singh','rahul@company.com','Mumbai HQ, Nariman Point, Mumbai'),
('SR02','Anjali Verma','anjali@company.com','Delhi Office, Connaught Place, New Delhi'),
('SR03','Kiran Kumar','kiran@company.com','Bangalore Office, MG Road'),
('SR04','Pooja Nair','pooja@company.com','Chennai Office, T Nagar'),
('SR05','Arjun Patel','arjun@company.com','Ahmedabad Office, SG Highway');


INSERT INTO Orders VALUES
('ORD1001','C001','SR01','2023-01-10'),
('ORD1002','C002','SR02','2023-01-17'),
('ORD1003','C003','SR03','2023-02-05'),
('ORD1004','C004','SR04','2023-02-20'),
('ORD1005','C005','SR01','2023-03-12'),
('ORD1006','C006','SR02','2023-03-25'),
('ORD1007','C001','SR01','2023-04-10'),
('ORD1008','C002','SR02','2023-04-18');


INSERT INTO Order_Details VALUES
('ORD1001','P001',1),
('ORD1001','P004',5),

('ORD1002','P005',2),

('ORD1003','P002',1),
('ORD1003','P007',3),

('ORD1004','P003',1),

('ORD1005','P006',1),

('ORD1006','P004',10),

('ORD1007','P007',4),

('ORD1008','P005',1);

