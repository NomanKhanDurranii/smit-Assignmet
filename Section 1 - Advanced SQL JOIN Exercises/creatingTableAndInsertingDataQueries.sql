-- 1. Color Table
CREATE TABLE color (
    id SERIAL PRIMARY KEY,
    name VARCHAR(50) NOT NULL UNIQUE,
    extra_fee NUMERIC(10,2) DEFAULT 0 CHECK (extra_fee >= 0)
);

-- 2. Customer Table
CREATE TABLE customer (
    id SERIAL PRIMARY KEY,
    first_name VARCHAR(100) NOT NULL,
    last_name VARCHAR(100) NOT NULL,
    favorite_color_id INT REFERENCES color(id) ON DELETE SET NULL
);

-- 3. Category Table
CREATE TABLE category (
    id SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    parent_id INT REFERENCES category(id) ON DELETE CASCADE
);

-- 4. Clothing Table
CREATE TABLE clothing (
    id SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    size VARCHAR(5) CHECK (size IN ('S','M','L','XL','2XL','3XL')),
    price NUMERIC(10,2) NOT NULL CHECK (price >= 0),
    color_id INT REFERENCES color(id) ON DELETE CASCADE,
    category_id INT REFERENCES category(id) ON DELETE CASCADE
);

-- 5. Clothing Order Table
CREATE TABLE clothing_order (
    id SERIAL PRIMARY KEY,
    customer_id INT NOT NULL REFERENCES customer(id) ON DELETE CASCADE,
    clothing_id INT NOT NULL REFERENCES clothing(id) ON DELETE CASCADE,
    items INT NOT NULL CHECK (items > 0),
    order_date DATE NOT NULL DEFAULT CURRENT_DATE
);


-- ####			 INSERTION COMMANDS			 ####

-- COLOR TABLE INSERTION COMMANDS

INSERT INTO color (name, extra_fee) VALUES
('Red', 0),
('Blue', 2.50),
('Black', 3.00),
('White', 0),
('Green', 1.50);

-- CUSTOMER TABLE INSERTION COMMANDS

INSERT INTO customer (first_name, last_name, favorite_color_id) VALUES
('Ali', 'Khan', 1),   
('Sara', 'Malik', 2), 
('Hassan', 'Shah', 3),
('Ayesha', 'Raza', NULL), 
('Omar', 'Iqbal', 5); 

-- CUSTOMER TABLE INSERTION COMMANDS

-- Main categories
INSERT INTO category (name, parent_id) VALUES
('Men', NULL),
('Women', NULL),
('Kids', NULL),
('Accessories', NULL),
('Footwear', NULL);

-- Optional subcategories 
INSERT INTO category (name, parent_id) VALUES
('T-Shirts', 1),  -- under Men
('Dresses', 2),   -- under Women
('Sneakers', 5);  -- under Footwear


-- CLOTHING TABLE INSERTION COMMANDS

INSERT INTO clothing (name, size, price, color_id, category_id) VALUES
('Men T-Shirt Basic', 'M', 15.00, 1, 6),   -- Red, Men -> T-Shirts
('Men Hoodie', 'L', 40.00, 3, 1),          -- Black, Men
('Women Dress Casual', 'M', 55.00, 2, 7),  -- Blue, Women -> Dresses
('Kids T-Shirt', 'S', 12.00, 5, 3),        -- Green, Kids
('Running Sneakers', 'XL', 65.00, 4, 8);   -- White, Footwear -> Sneakers


-- CLOTHING ORDER TABLE INSERTION COMMANDS

INSERT INTO clothing_order (customer_id, clothing_id, items, order_date) VALUES
(1, 1, 2, '2025-09-10'), -- Ali buys 2 Red T-Shirts
(2, 3, 1, '2025-09-12'), -- Sara buys 1 Women Dress
(3, 2, 1, '2025-09-13'), -- Hassan buys 1 Hoodie
(4, 4, 3, '2025-09-15'), -- Ayesha buys 3 Kids T-Shirts
(5, 5, 1, '2025-09-18'); -- Omar buys 1 Sneakers


