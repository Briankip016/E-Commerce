CREATE DATABASE Ecommerce;
USE Ecommerce;

-- CREATING BRAND TABLE
CREATE TABLE brand(
brand_id INT  PRIMARY KEY AUTO_INCREMENT,
name VARCHAR(50) NOT NULL,
description TEXT
);

-- CHANGING THE BRAND_ID NAME TO ID
ALTER TABLE brand
RENAME COLUMN brand_id to id;

-- VIEWING WHAT IS IN THE BRAND TABLE
DESCRIBE brand;

-- CRETAING PRODUCT CATEGORY TABLE
CREATE TABLE product_category (
id INT PRIMARY KEY AUTO_INCREMENT,
name VARCHAR(50) NOT NULL
);

-- CREATING PRODUCT TABLE
CREATE TABLE product (
id INT PRIMARY KEY AUTO_INCREMENT,
name VARCHAR(50) NOT NULL,
brand_id INT,
category_id INT,
price DECIMAL (10,2),
FOREIGN KEY (brand_id) REFERENCES brand(id),
FOREIGN KEY (category_id) REFERENCES product_category(id)
);

-- CREATING PRODUCT IMAGE TABLE
CREATE TABLE product_image(
id INT PRIMARY KEY AUTO_INCREMENT,
product_id INT,
url VARCHAR (300) NOT NULL,
FOREIGN KEY (product_id) REFERENCES product(id)
);

-- CREATING COLOR TABLE
CREATE TABLE color(
id INT PRIMARY KEY AUTO_INCREMENT, 
name VARCHAR (50)
);

-- CREATING SIZE CATEGORY TABLE
CREATE TABLE size_category(
id INT PRIMARY KEY AUTO_INCREMENT,
name VARCHAR (50)
);

-- CREATING SIZE OPTION TABLE
CREATE TABLE size_option(
id INT AUTO_INCREMENT PRIMARY KEY,
name VARCHAR (50),
category_id INT,
FOREIGN KEY (category_id) REFERENCES size_category (id)
);

-- CREATING PRODUCT VARIATION TABLE
CREATE TABLE product_variation(
id INT PRIMARY KEY AUTO_INCREMENT,
product_id INT,
color_id INT,
size_option_id INT,
FOREIGN KEY (product_id) REFERENCES product(id),
FOREIGN KEY (color_id) REFERENCES color(id),
FOREIGN KEY (size_option_id) REFERENCES size_option(id)
);


-- CREATING PRODUCT ITEM TABLE
CREATE TABLE product_item (
    id INT AUTO_INCREMENT PRIMARY KEY,
    variation_id INT,
    sku VARCHAR(50) NOT NULL,
    stock_quantity INT,
    price DECIMAL(10,2),
    FOREIGN KEY (variation_id) REFERENCES product_variation(id)
);

-- CREATING ATTRIBUTE CATEGORY TABLE
CREATE TABLE attribute_category (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(50) NOT NULL
);

-- CREATING ATTRIBUTE TYPE TABLE
CREATE TABLE attribute_type (
    id INT AUTO_INCREMENT PRIMARY KEY,
    category_id INT,
    name VARCHAR(50) NOT NULL,
    FOREIGN KEY (category_id) REFERENCES attribute_category(id)
);


-- CREATING PRODUCT ATTRIBUTE TABLE
CREATE TABLE product_attribute (
    id INT AUTO_INCREMENT PRIMARY KEY,
    product_id INT,
    type_id INT,
    value VARCHAR(100),
    FOREIGN KEY (product_id) REFERENCES product(id),
    FOREIGN KEY (type_id) REFERENCES attribute_type(id)
);

-- INSERTING DATA INTO THE TABLES
INSERT INTO brand (name, description) VALUES
('Nike', 'Leading sportswear brand'),
('Apple', 'Innovative technology company');

INSERT INTO product_category (name) VALUES
('Clothing'),
('Electronics');

INSERT INTO color (name) VALUES
('Red'),
('Blue'),
('Black');

INSERT INTO size_category (name) VALUES
('Clothing Size'),
('Shoe Size');

INSERT INTO size_option (category_id, name) VALUES
(1, 'S'),
(1, 'M'),
(1, 'L'),
(2, '42'),
(2, '43');

INSERT INTO attribute_category (name) VALUES
('Physical'),
('Technical');

INSERT INTO attribute_type (category_id, name) VALUES
(1, 'Material'),
(1, 'Weight'),
(2, 'Battery Life');

INSERT INTO product (name, brand_id, category_id, price) VALUES
('Running Shoes', 1, 1, 79.99),
('Smartphone', 2, 2, 699.99);

INSERT INTO product_image (product_id, url) VALUES
(1, 'images/shoes1.jpg'),
(2, 'images/phone1.jpg');

-- Example: Red, Size M Running Shoes
INSERT INTO product_variation (product_id, color_id, size_option_id) VALUES
(1, 1, 2);

-- -- Example: SKU for Red, Size M Running Shoes
INSERT INTO product_item (variation_id, sku, stock_quantity, price) VALUES
(1, 'RS-RED-M', 10, 79.99);

-- -- Example: Material for Running Shoes
INSERT INTO product_attribute (product_id, type_id, value) VALUES
(1, 1, 'Mesh'),
(1, 2, '250g');

SELECT *FROM product_attribute;

SELECT DISTINCT b.name AS BrandName, p.name AS ProductName
FROM brand b
INNER JOIN product p ON b.id = p.brand_id;

SELECT b.name AS BrandName, COUNT(p.id) AS ProductCount
FROM brand b
LEFT JOIN product p ON b.id = p.brand_id
GROUP BY b.name;


-- TESTING THE CODE
select *from product_category;

SELECT
    p.name AS ProductName,
    b.name AS BrandName,
    pc.name AS CategoryName
FROM
    product p
INNER JOIN
    brand b ON p.brand_id = b.id
INNER JOIN
    product_category pc ON p.category_id = pc.id;


SELECT
    p.name AS ProductName,
    pi.url AS ImageURL
FROM
    product p
LEFT JOIN
    product_image pi ON p.id = pi.product_id;

SELECT
    b.name AS BrandName,
    p.name AS ProductName
FROM
    product p
RIGHT JOIN
    brand b ON p.brand_id = b.id;

SELECT 
    b.id AS BrandID, 
    b.name AS BrandName, 
    p.id AS ProductID, 
    p.name AS ProductName,
    p.price AS price
FROM 
    brand b
LEFT JOIN 
    product p ON b.id = p.brand_id;

