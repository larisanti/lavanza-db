/*
  File: lavanza_db_schema.sql
  Purpose: Database schema for Lavanza, an artisanal soap business. It defines the tables, relationships, and constraints for its database.
  Author: Larissa de Santi (GitHub: https://github.com/larisanti)
  Created: 13-02-2025
  Notes: Run this script in MySQL to create the database structure. Execute this before inserting data.
*/

CREATE DATABASE IF NOT EXISTS lavanza;
USE lavanza;

CREATE TABLE customers (
    customer_id INT PRIMARY KEY AUTO_INCREMENT,
    first_name VARCHAR(20) NOT NULL,
    last_name VARCHAR(45) NOT NULL,
    email VARCHAR(64) UNIQUE NOT NULL,
    phone VARCHAR(20)
);
ALTER TABLE customers AUTO_INCREMENT = 1000;

CREATE TABLE addresses (
    address_id INT PRIMARY KEY AUTO_INCREMENT,
    customer_id INT NOT NULL,
    street VARCHAR(64) NOT NULL,
    number VARCHAR(10) NOT NULL,
    complement VARCHAR(45),
    city VARCHAR(45) NOT NULL,
    state VARCHAR(45) NOT NULL,
    zip_code VARCHAR(20) NOT NULL,
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id)
);

CREATE TABLE orders (
    order_id INT PRIMARY KEY AUTO_INCREMENT,
    customer_id INT NOT NULL,
    address_id INT NOT NULL,
    channel_id INT NOT NULL,
    order_date DATE NOT NULL,
    integration_status ENUM('Pending', 'In Production', 'Produced', 'Packed', 'Shipped', 'Delivered', 'Cancelled') DEFAULT 'Pending',
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id),
    FOREIGN KEY (address_id) REFERENCES addresses(address_id),
    FOREIGN KEY (channel_id) REFERENCES sales_channels(channel_id)
);

CREATE TABLE order_items (
    order_item_id INT PRIMARY KEY AUTO_INCREMENT,
    order_id INT NOT NULL,
    product_id INT NOT NULL,
    quantity INT NOT NULL,
    price_at_order DECIMAL(10,2) NOT NULL,
    FOREIGN KEY (order_id) REFERENCES orders(order_id),
    FOREIGN KEY (product_id) REFERENCES products(product_id)
);

CREATE TABLE products (
    product_id INT PRIMARY KEY AUTO_INCREMENT,
    category_id INT NOT NULL,
    name VARCHAR(200) NOT NULL,
    description TEXT,
    price DECIMAL(10,2) NOT NULL,
    FOREIGN KEY (category_id) REFERENCES product_type(category_id)
);

CREATE TABLE categories (
    category_id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(45) NOT NULL
);

CREATE TABLE sales_channels (
    channel_id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(45) NOT NULL,
    url VARCHAR(1000)
);

CREATE TABLE product_stock (
    product_stock_id INT PRIMARY KEY AUTO_INCREMENT,
    product_id INT NOT NULL,
    channel_id INT NOT NULL,
    quantity INT NOT NULL,
    FOREIGN KEY (product_id) REFERENCES products(product_id),
    FOREIGN KEY (channel_id) REFERENCES sales_channels(channel_id)
);

CREATE TABLE production (
    production_id INT PRIMARY KEY AUTO_INCREMENT,
    product_id INT NOT NULL,
    production_date DATE NOT NULL,
    quantity_produced INT NOT NULL,
    FOREIGN KEY (product_id) REFERENCES products(product_id)
);

CREATE TABLE production_materials (
    production_id INT NOT NULL,
    material_id INT NOT NULL,
    unit VARCHAR(45) NOT NULL,
    quantity DECIMAL(10,2) NOT NULL, 
    PRIMARY KEY (production_id, material_id),
    FOREIGN KEY (production_id) REFERENCES production(production_id),
    FOREIGN KEY (material_id) REFERENCES materials(material_id)
);

CREATE TABLE materials (
    material_id INT PRIMARY KEY AUTO_INCREMENT,
    supplier_id INT NOT NULL,
    name VARCHAR(45) NOT NULL,
    type ENUM('Ingredient', 'Packing', 'Shipping') NOT NULL,
    unit VARCHAR(45) NOT NULL,
    stock_quantity DECIMAL(10,2) NOT NULL,
    FOREIGN KEY (supplier_id) REFERENCES suppliers(supplier_id)
);

CREATE TABLE packing_materials (
    product_id INT NOT NULL,
    material_id INT NOT NULL,
    quantity DECIMAL(10,2) NOT NULL,
    unit VARCHAR(45) NOT NULL,
    PRIMARY KEY (product_id, material_id),
    FOREIGN KEY (product_id) REFERENCES products(product_id),
    FOREIGN KEY (material_id) REFERENCES materials(material_id)
);

CREATE TABLE shipping_materials (
    order_id INT NOT NULL,
    material_id INT NOT NULL,
    quantity DECIMAL(10,2) NOT NULL,
    unit VARCHAR(45) NOT NULL,
    PRIMARY KEY (order_id, material_id),
    FOREIGN KEY (order_id) REFERENCES orders(order_id),
    FOREIGN KEY (material_id) REFERENCES materials(material_id)
);

CREATE TABLE recipe_materials (
    recipe_id INT NOT NULL,
    material_id INT NOT NULL,
    quantity DECIMAL(10,2) NOT NULL,
    unit VARCHAR(45) NOT NULL,
    PRIMARY KEY (recipe_id, material_id),
    FOREIGN KEY (recipe_id) REFERENCES recipes(recipe_id),
    FOREIGN KEY (material_id) REFERENCES materials(material_id)
);

CREATE TABLE recipes (
    recipe_id INT PRIMARY KEY AUTO_INCREMENT,
    product_id INT NOT NULL, 
    category_id INT NOT NULL,
    name VARCHAR(100) NOT NULL,
    instructions VARCHAR(1000) NOT NULL,
    description VARCHAR(1000),
		created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
		updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
    FOREIGN KEY (product_id) REFERENCES products(product_id)
);

CREATE TABLE suppliers (
    supplier_id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(45) NOT NULL,
    phone VARCHAR(20),
    email VARCHAR(64) UNIQUE,
    url VARCHAR(1000)
);
