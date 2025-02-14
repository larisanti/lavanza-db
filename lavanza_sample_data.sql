/*
  File: lavanza_sample_data.sql
  Purpose: Inserts sample data into the Lavanza database for demonstration and testing.
  Author: Larissa de Santi (GitHub: https://github.com/larisanti)
  Created: 13-02-2025
  Notes: Ensure the database schema is set up before running this script.
*/

-- Insert sample data for Customers
INSERT INTO customers (first_name, last_name, email, phone) VALUES
('Ana', 'Silva', 'ana.silva@email.com', '+55 11 98765-4321'),
('Carlos', 'Oliveira', 'carlos.oliveira@email.com', '+55 21 99876-5432'),
('Mariana', 'Santos', 'mariana.santos@email.com', '+55 31 91234-5678'),
('João', 'Pereira', 'joao.pereira@email.com', '+55 41 92345-6789');

-- Insert sample data for Addresses
INSERT INTO addresses (customer_id, street, number, complement, city, state, zip_code) VALUES
(1000, 'Rua das Rosas', '123', 'Apto 101', 'São Paulo', 'SP', '01000-000'),
(1001, 'Av. Atlântica', '500', NULL, 'Rio de Janeiro', 'RJ', '22000-000'),
(1002, 'Rua Sete de Setembro', '45', 'Bloco B', 'Belo Horizonte', 'MG', '30100-000'),
(1003, 'Rua XV de Novembro', '789', NULL, 'Curitiba', 'PR', '80000-000');

-- Insert sample data for Sales Channels
INSERT INTO sales_channels (name, url) VALUES
('Channel 1', 'https://example.com'),
('Channel 2', 'https://example.com'),
('Channel 3', 'https://example.com');

-- Insert sample data for Categories
INSERT INTO categories (name) VALUES
('Sabonetes Artesanais'),
('Kits de Presentes'),
('Acessórios para Banho');

-- Insert sample data for Products
INSERT INTO products (category_id, name, description, price) VALUES
(1, 'Sabonete de Lavanda', 'Sabonete relaxante com óleo essencial de lavanda.', 15.90),
(1, 'Sabonete de Carvão Ativado', 'Limpeza profunda para pele oleosa.', 18.50),
(2, 'Kit Spa Relaxante', 'Conjunto com sabonete, esfoliante e vela aromática.', 49.90),
(3, 'Porta-sabonete de Madeira', 'Feito de bambu sustentável.', 25.00);

-- Insert sample data for Orders
INSERT INTO orders (customer_id, address_id, channel_id, order_date, integration_status) VALUES
(1000, 1, 1, '2025-02-10', 'Pending'),
(1001, 2, 2, '2025-02-11', 'Shipped'),
(1002, 3, 3, '2025-02-12', 'Delivered');

-- Insert sample data for Order Items
INSERT INTO order_items (order_id, product_id, quantity, price_at_order) VALUES
(1, 1, 2, 15.90),
(2, 3, 1, 49.90),
(3, 2, 3, 18.50);

-- Insert sample data for Suppliers
INSERT INTO suppliers (name, phone, email, url) VALUES
('Fornecedora Natural', '+55 11 96543-2100', 'contato@fornecedoranatural.com', 'https://fornecedoranatural.com'),
('Eco Sabão', '+55 21 98765-4321', 'vendas@ecosabao.com', 'https://ecosabao.com');

-- Insert sample data for Materials
INSERT INTO materials (supplier_id, name, type, unit, stock_quantity) VALUES
(1, 'Óleo de Coco', 'Ingredient', 'Litros', 50.00),
(1, 'Manteiga de Karité', 'Ingredient', 'Kg', 20.00),
(2, 'Caixas de Papelão', 'Packing', 'Unidades', 100),
(2, 'Fitas Decorativas', 'Packing', 'Metros', 200);

-- Insert sample data for Production
INSERT INTO production (product_id, production_date, quantity_produced) VALUES
(1, '2025-02-05', 100),
(2, '2025-02-06', 80);

-- Insert sample data for Recipe Materials
INSERT INTO recipe_materials (recipe_id, material_id, quantity, unit) VALUES
(1, 1, 1.5, 'Litros'),
(1, 2, 0.5, 'Kg');
