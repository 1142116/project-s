create database minipro;
use minipro;

CREATE TABLE chemicals (
    chemical_id INT AUTO_INCREMENT PRIMARY KEY,
    chemical_name VARCHAR(100) NOT NULL,
    price_per_unit DECIMAL(10, 2) NOT NULL,
    stock_quantity INT NOT NULL
);

-- Create suppliers table
CREATE TABLE suppliers (
    supplier_id INT AUTO_INCREMENT PRIMARY KEY,
    supplier_name VARCHAR(100) NOT NULL,
    contact_number VARCHAR(15),
    location VARCHAR(150)
);

-- Create customers table
CREATE TABLE customers (
    customer_id INT AUTO_INCREMENT PRIMARY KEY,
    customer_name VARCHAR(100) NOT NULL,
    contact_number VARCHAR(15),
    email VARCHAR(100),
    address VARCHAR(200)
);

-- Create sales table
CREATE TABLE sales (
    sale_id INT AUTO_INCREMENT PRIMARY KEY,
    sale_date DATE NOT NULL,
    customer_id INT,
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id)
);

-- Create sales_items table
CREATE TABLE sales_items (
    sale_item_id INT AUTO_INCREMENT PRIMARY KEY,
    sale_id INT,
    chemical_id INT,
    quantity_sold INT NOT NULL,
    FOREIGN KEY (sale_id) REFERENCES sales(sale_id),
    FOREIGN KEY (chemical_id) REFERENCES chemicals(chemical_id)
);

-- Create inventory table
CREATE TABLE inventory (
    inventory_id INT AUTO_INCREMENT PRIMARY KEY,
    chemical_id INT,
    supplier_id INT,
    quantity_added INT NOT NULL,
    date_added DATE NOT NULL,
    FOREIGN KEY (chemical_id) REFERENCES chemicals(chemical_id),
    FOREIGN KEY (supplier_id) REFERENCES suppliers(supplier_id)
);

INSERT INTO chemicals (chemical_name, price_per_unit, stock_quantity) 
VALUES 
('Sodium Hydroxide', 50.00, 500),
('Acetic Acid', 75.00, 300),
('Sulfuric Acid', 45.50, 450),
('Ammonium Nitrate', 60.00, 200);

INSERT INTO suppliers (supplier_name, contact_number, location) 
VALUES 
('ChemPro Suppliers', '1234567890', 'New York, USA'),
('BioChem Distributors', '0987654321', 'Chicago, USA'),
('Apex Chemicals', '1112223334', 'Los Angeles, USA');

INSERT INTO customers (customer_name, contact_number, email, address) 
VALUES 
('John Doe', '9998887777', 'john@example.com', '123 Street, NY'),
('Jane Smith', '8887776666', 'jane@example.com', '456 Avenue, LA'),
('Acme Industries', '7776665555', 'acme@industries.com', '789 Boulevard, Chicago');

INSERT INTO sales (sale_date, customer_id) 
VALUES 
('2024-09-01', 1),
('2024-09-05', 2),
('2024-09-10', 3);

INSERT INTO sales_items (sale_id, chemical_id, quantity_sold) 
VALUES 
(1, 1, 100),  -- John Doe purchased 100 units of Sodium Hydroxide
(2, 2, 50),   -- Jane Smith purchased 50 units of Acetic Acid
(3, 3, 150);  -- Acme Industries purchased 150 units of Sulfuric Acid

-- quarry
SELECT c.customer_name, SUM(si.quantity_sold * ch.price_per_unit) AS total_sales
FROM sales_items si
JOIN sales s ON si.sale_id = s.sale_id
JOIN customers c ON s.customer_id = c.customer_id
JOIN chemicals ch ON si.chemical_id = ch.chemical_id
GROUP BY c.customer_name;

-- 2
SELECT ch.chemical_name, SUM(i.quantity_added) AS total_quantity, ch.stock_quantity
FROM inventory i
JOIN chemicals ch ON i.chemical_id = ch.chemical_id
GROUP BY ch.chemical_name;

