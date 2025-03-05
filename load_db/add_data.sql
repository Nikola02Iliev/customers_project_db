--Insert data in Customers Table
COPY customers
FROM 'C:\Projects\customers_project_db\csv_files\customers.csv'
WITH (FORMAT csv, HEADER true, DELIMITER ',', ENCODING 'UTF8');

--Insert data in Addresses Table
COPY addresses
FROM 'C:\Projects\customers_project_db\csv_files\addresses.csv'
WITH (FORMAT csv, HEADER true, DELIMITER ',', ENCODING 'UTF8');

--Insert data in Orders Table
COPY orders
FROM 'C:\Projects\customers_project_db\csv_files\orders.csv'
WITH (FORMAT csv, HEADER true, DELIMITER ',', ENCODING 'UTF8');

--Insert data in Order Items Table
COPY order_items
FROM 'C:\Projects\customers_project_db\csv_files\order_items.csv'
WITH (FORMAT csv, HEADER true, DELIMITER ',', ENCODING 'UTF8');

--Insert data in Interactions Table
COPY interactions
FROM 'C:\Projects\customers_project_db\csv_files\interactions.csv'
WITH (FORMAT csv, HEADER true, DELIMITER ',', ENCODING 'UTF8');