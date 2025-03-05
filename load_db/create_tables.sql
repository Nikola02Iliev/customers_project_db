--Create Customers Table
CREATE TABLE public.customers (
  customer_id INT PRIMARY KEY,
  first_name VARCHAR(50) NOT NULL,
  last_name VARCHAR(50) NOT NULL,
  email VARCHAR(100) UNIQUE NOT NULL,
  phone VARCHAR(20),
  created_at TIMESTAMP,
  updated_at TIMESTAMP
);



--Create Addresses Table
CREATE TABLE public.addresses (
  address_id INT PRIMARY KEY,
  customer_id INT NOT NULL,
  street VARCHAR(255) NOT NULL,
  city VARCHAR(50) NOT NULL,
  state VARCHAR(50),
  zip_code VARCHAR(20),
  address_type VARCHAR(20) NOT NULL,
  FOREIGN KEY (customer_id) REFERENCES customers(customer_id)
);


--Create Customers Orders
CREATE TABLE public.orders (
  order_id INT PRIMARY KEY,
  customer_id INT NOT NULL,
  address_id INT NOT NULL,
  order_date TIMESTAMP NOT NULL,
  total_amount DECIMAL(10, 2) NOT NULL,
  status VARCHAR(15),
  FOREIGN KEY (customer_id) REFERENCES customers(customer_id),
  FOREIGN KEY (address_id) REFERENCES addresses(address_id)
);


--Create Order Items Table
CREATE TABLE public.order_items (
  order_item_id INT PRIMARY KEY,
  order_id INT NOT NULL,
  product_name VARCHAR(255) NOT NULL,
  quantity INT NOT NULL,
  price_per_unit DECIMAL(10, 2) NOT NULL,
  FOREIGN KEY (order_id) REFERENCES orders(order_id)
);


--Create Interactions Table
CREATE TABLE public.interactions (
  interaction_id INT PRIMARY KEY,
  customer_id INT NOT NULL,
  interaction_date TIMESTAMP NOT NULL,
  type VARCHAR(15) NOT NULL,
  details TEXT,
  agent_name VARCHAR(100),
  status VARCHAR(15),
  FOREIGN KEY (customer_id) REFERENCES customers(customer_id)
);


--Give ownership to "postgres" user
ALTER TABLE public.customers OWNER to postgres;
ALTER TABLE public.addresses OWNER to postgres;
ALTER TABLE public.orders OWNER to postgres;
ALTER TABLE public.order_items OWNER to postgres;
ALTER TABLE public.interactions OWNER to postgres;


--Add indexes to every foreign key for better performance 
CREATE INDEX idx_customer_id_addresses ON public.addresses (customer_id);
CREATE INDEX idx_customer_id_orders ON public.orders (customer_id);
CREATE INDEX idx_address_id_orders ON public.orders (address_id);
CREATE INDEX idx_order_id_order_items ON public.order_items (order_id);
CREATE INDEX idx_customer_id_interactions ON public.interactions (customer_id);
