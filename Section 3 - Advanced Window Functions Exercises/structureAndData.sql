-- 1. Channels table
CREATE TABLE channels (
    id SERIAL PRIMARY KEY,
    channel_name VARCHAR(100) NOT NULL
);

-- 2. Customers table
CREATE TABLE customers (
    customer_id SERIAL PRIMARY KEY,
    email VARCHAR(255) UNIQUE NOT NULL,
    full_name VARCHAR(150) NOT NULL,
    address VARCHAR(255),
    city VARCHAR(100),
    region VARCHAR(100),
    postal_code VARCHAR(20),
    country VARCHAR(100),
    phone VARCHAR(50),
    registration_date DATE NOT NULL,
    channel_id INT REFERENCES channels(id) ON DELETE SET NULL,
    first_order_id INT,
    first_order_date DATE,
    last_order_id INT,
    last_order_date DATE
);

-- 3. Categories table
CREATE TABLE categories (
    category_id SERIAL PRIMARY KEY,
    category_name VARCHAR(100) NOT NULL,
    description TEXT
);

-- 4. Products table
CREATE TABLE products (
    product_id SERIAL PRIMARY KEY,
    product_name VARCHAR(150) NOT NULL,
    category_id INT REFERENCES categories(category_id) ON DELETE CASCADE,
    unit_price NUMERIC(10,2) NOT NULL CHECK (unit_price >= 0),
    discontinued BOOLEAN DEFAULT FALSE
);

-- 5. Orders table
CREATE TABLE orders (
    order_id SERIAL PRIMARY KEY,
    customer_id INT REFERENCES customers(customer_id) ON DELETE CASCADE,
    order_date DATE NOT NULL,
    total_amount NUMERIC(12,2) NOT NULL CHECK (total_amount >= 0),
    ship_name VARCHAR(150),
    ship_address VARCHAR(255),
    ship_city VARCHAR(100),
    ship_region VARCHAR(100),
    ship_postalcode VARCHAR(20),
    ship_country VARCHAR(100),
    shipped_date DATE
);

-- 6. Order_Items table
CREATE TABLE order_items (
    order_id INT REFERENCES orders(order_id) ON DELETE CASCADE,
    product_id INT REFERENCES products(product_id) ON DELETE CASCADE,
    unit_price NUMERIC(10,2) NOT NULL CHECK (unit_price >= 0),
    quantity INT NOT NULL CHECK (quantity > 0),
    discount NUMERIC(4,2) DEFAULT 0 CHECK (discount >= 0),
    PRIMARY KEY (order_id, product_id)
);



--  ###			INSERTION COMMANDS			###

-- CHANNEL'S TABLE

INSERT INTO channels (channel_name) VALUES
('Google Ads'),
('Facebook'),
('Instagram'),
('Referral'),
('Direct'),
('YouTube'),
('LinkedIn'),
('Twitter'),
('Newsletter'),
('Affiliate');


-- CATEGORIES TABLE

INSERT INTO categories (category_name, description) VALUES
('Beverages', 'Soft drinks, coffees, teas, beers, and ales'),
('Condiments', 'Sweet and savory sauces, relishes, spreads, and seasonings'),
('Confections', 'Desserts, candies, and sweet breads'),
('Dairy Products', 'Cheeses and dairy'),
('Grains/Cereals', 'Breads, crackers, pasta, and cereal'),
('Meat/Poultry', 'Prepared meats'),
('Produce', 'Dried fruit and bean curd'),
('Seafood', 'Seaweed, fish, and seafood'),
('Snacks', 'Chips, nuts, and snack foods'),
('Frozen Foods', 'Frozen meals and ingredients');


-- PRODUCT'S TABLE

INSERT INTO products (product_name, category_id, unit_price, discontinued) VALUES
('Chai', 1, 18.00, FALSE),
('Chang', 1, 19.00, FALSE),
('Aniseed Syrup', 2, 10.00, FALSE),
('Chef Anton''s Cajun Seasoning', 2, 22.00, FALSE),
('Grandma''s Boysenberry Spread', 2, 25.00, FALSE),
('Chocolate Biscuits', 3, 15.00, FALSE),
('Camembert Cheese', 4, 35.00, FALSE),
('Pasta Spirals', 5, 12.00, FALSE),
('Tinned Sardines', 8, 14.00, FALSE),
('Frozen Pizza', 10, 8.00, FALSE);


-- CUSTOMER'S TABLE

INSERT INTO customers (email, full_name, address, city, region, postal_code, country, phone, registration_date, channel_id, first_order_id, first_order_date, last_order_id, last_order_date) VALUES
('ali.khan@example.com', 'Ali Khan', '123 Main St', 'Karachi', NULL, '74000', 'Pakistan', '+92-3001234567', '2024-01-10', 1, NULL, NULL, NULL, NULL),
('sara.malik@example.com', 'Sara Malik', '45 Garden Rd', 'Lahore', NULL, '54000', 'Pakistan', '+92-3212345678', '2024-02-05', 2, NULL, NULL, NULL, NULL),
('hassan.raza@example.com', 'Hassan Raza', '78 Park Lane', 'Islamabad', NULL, '44000', 'Pakistan', '+92-3339876543', '2024-02-20', 3, NULL, NULL, NULL, NULL),
('ayesha.shah@example.com', 'Ayesha Shah', '12 Clifton St', 'Karachi', NULL, '75000', 'Pakistan', '+92-3454567890', '2024-03-01', 4, NULL, NULL, NULL, NULL),
('omar.iqbal@example.com', 'Omar Iqbal', '90 Canal View', 'Lahore', NULL, '54010', 'Pakistan', '+92-3555678901', '2024-03-15', 5, NULL, NULL, NULL, NULL),
('zara.khalid@example.com', 'Zara Khalid', '14 Gulberg Rd', 'Lahore', NULL, '54020', 'Pakistan', '+92-3666789012', '2024-04-01', 6, NULL, NULL, NULL, NULL),
('bilal.ahmed@example.com', 'Bilal Ahmed', '33 Saddar St', 'Karachi', NULL, '74010', 'Pakistan', '+92-3777890123', '2024-04-15', 7, NULL, NULL, NULL, NULL),
('noor.fatima@example.com', 'Noor Fatima', '55 Model Town', 'Lahore', NULL, '54030', 'Pakistan', '+92-3888901234', '2024-05-05', 8, NULL, NULL, NULL, NULL),
('usman.tariq@example.com', 'Usman Tariq', '22 Defence Rd', 'Islamabad', NULL, '44020', 'Pakistan', '+92-3999012345', '2024-05-20', 9, NULL, NULL, NULL, NULL),
('hina.mehmood@example.com', 'Hina Mehmood', '77 Johar Town', 'Lahore', NULL, '54040', 'Pakistan', '+92-3111122334', '2024-06-01', 10, NULL, NULL, NULL, NULL);


-- ORDER'S TABLE

INSERT INTO orders (customer_id, order_date, total_amount, ship_name, ship_address, ship_city, ship_region, ship_postalcode, ship_country, shipped_date) VALUES
(1, '2024-06-10', 100.00, 'Ali Khan', '123 Main St', 'Karachi', NULL, '74000', 'Pakistan', '2024-06-12'),
(2, '2024-06-15', 150.00, 'Sara Malik', '45 Garden Rd', 'Lahore', NULL, '54000', 'Pakistan', '2024-06-17'),
(3, '2024-06-20', 200.00, 'Hassan Raza', '78 Park Lane', 'Islamabad', NULL, '44000', 'Pakistan', '2024-06-22'),
(4, '2024-07-01', 50.00, 'Ayesha Shah', '12 Clifton St', 'Karachi', NULL, '75000', 'Pakistan', '2024-07-03'),
(5, '2024-07-05', 80.00, 'Omar Iqbal', '90 Canal View', 'Lahore', NULL, '54010', 'Pakistan', '2024-07-07'),
(6, '2024-07-10', 120.00, 'Zara Khalid', '14 Gulberg Rd', 'Lahore', NULL, '54020', 'Pakistan', '2024-07-12'),
(7, '2024-07-12', 90.00, 'Bilal Ahmed', '33 Saddar St', 'Karachi', NULL, '74010', 'Pakistan', '2024-07-14'),
(8, '2024-07-15', 130.00, 'Noor Fatima', '55 Model Town', 'Lahore', NULL, '54030', 'Pakistan', '2024-07-17'),
(9, '2024-07-20', 170.00, 'Usman Tariq', '22 Defence Rd', 'Islamabad', NULL, '44020', 'Pakistan', '2024-07-22'),
(10, '2024-07-25', 200.00, 'Hina Mehmood', '77 Johar Town', 'Lahore', NULL, '54040', 'Pakistan', '2024-07-27');


-- ORDER ITEMS TABLE

INSERT INTO order_items (order_id, product_id, unit_price, quantity, discount) VALUES
(1, 1, 18.00, 2, 0),
(1, 3, 10.00, 5, 0.10),
(2, 2, 19.00, 4, 0),
(2, 6, 15.00, 3, 0.05),
(3, 4, 22.00, 6, 0.15),
(3, 7, 35.00, 2, 0),
(4, 10, 8.00, 5, 0),
(5, 8, 12.00, 4, 0.05),
(6, 9, 14.00, 10, 0.20),
(7, 5, 25.00, 2, 0),
(8, 6, 15.00, 7, 0.10),
(9, 1, 18.00, 3, 0),
(10, 2, 19.00, 8, 0.10);





INSERT INTO orders (order_id, customer_id, order_date, total_amount, ship_name, ship_address, ship_city, ship_region, ship_postalcode, ship_country, shipped_date)
VALUES
(101, 1, '2025-01-05', 120.00, 'Alice Smith', '123 Main St', 'London', 'London', 'SW1A1AA', 'UK', '2025-01-07'),
(102, 1, '2025-02-10', 150.00, 'Alice Smith', '123 Main St', 'London', 'London', 'SW1A1AA', 'UK', '2025-02-12'),
(103, 1, '2025-03-15', 90.00,  'Alice Smith', '123 Main St', 'London', 'London', 'SW1A1AA', 'UK', '2025-03-16'),

(104, 2, '2025-01-20', 200.00, 'Bob Johnson', '456 High St', 'Paris', NULL, '75001', 'France', '2025-01-21'),
(105, 2, '2025-02-25', 180.00, 'Bob Johnson', '456 High St', 'Paris', NULL, '75001', 'France', '2025-02-26'),
(106, 2, '2025-03-30', 220.00, 'Bob Johnson', '456 High St', 'Paris', NULL, '75001', 'France', '2025-04-01'),

(107, 3, '2025-01-18', 75.00,  'Charlie Brown', '789 Oak Rd', 'Berlin', NULL, '10115', 'Germany', '2025-01-19'),
(108, 3, '2025-02-22', 95.00,  'Charlie Brown', '789 Oak Rd', 'Berlin', NULL, '10115', 'Germany', '2025-02-23');

