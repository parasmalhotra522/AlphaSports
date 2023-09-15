# -------- CSD2206_2022FALL_DBMS --------
# ----- PROFESSOR: MEHRNOUSH ASHRAFI -----
# -------- ALPHA SPORTS DATABASE --------
# ------------  BY GROUP 3 --------------
# ---- ** TEAM MEMBERS ** 			** PROJECT CONTRIBUTION **
# 1) Paras Malhotra (c0880638)		Worked on ER Diagram, Creation of Database, Insertion of Data,  Designing and Executing Complex Query Questions
# 2) Janaki Sampath (c0872536)		Worked on ER Diagram, Creation of Database, Insertion of Data,  Designing and Executing Complex Query Questions
# 3) Lavanya Srinivisan (c0880731)	Worked on ER Diagram, Worked on Relational Model and Business Rules and the required Technical Document
# 4) Aakarshan Dutt (c0865917)		Worked on Relational Model and Helped with providing the data to be inserted 
# 5) Amanjot Kaur (c0880957)		Helped with the ER diagram, Gave 7 Question Statements on Complex queries 
# 6) Ayush Goyal (c0880611)			Worked on ERD Language




DROP DATABASE database_project;
CREATE DATABASE database_project;
use database_project;
show tables;


# ---------------- ALL THE TABLES --------- 
# 	1) CUSTOMER
#	2) ORDERS
#	3) CATEGORY 
#	4) PRODUCT
# 	5) ORDER_DETAIL 
#	6) INVOICE 
#	7) SUPPLIER 
#	8) PRODUCT_SUPPLY
# 	9) ZIP 
#	10) LOCATION 
#	11) WAREHOUSE 
#	12) INVENTORY 
#	13) DEPARTMENT
#   14) STORE 
#	15) EMPLOYEE 
#	16) LOCATION_DEPARTMENT
  
    
# ----- Creating tables & Constraints---------------

# --------- CUSTOMER TABLE --------

CREATE TABLE CUSTOMER (
	customer_id INT AUTO_INCREMENT PRIMARY KEY NOT NULL,
    first_name VARCHAR(100) NOT NULL,
    last_name VARCHAR(100) NOT NULL,
    mobile_number NUMERIC(10),
    email_id VARCHAR(100) UNIQUE NOT NULL,
    address VARCHAR(300),
    city VARCHAR(70),
    state VARCHAR(70),
    country VARCHAR(70),
    postal_code NUMERIC(6)
);
ALTER TABLE CUSTOMER ADD CONSTRAINT check_mobile_no CHECK (LENGTH(mobile_number) = 10);
ALTER TABLE CUSTOMER ADD CONSTRAINT check_postal_code CHECK (LENGTH(postal_code) = 6);


#---------- ORDER TABLE -----------------

CREATE TABLE ORDERS (
	order_id INT AUTO_INCREMENT PRIMARY KEY NOT NULL ,
    customer_id INT NOT NULL,
    transaction_id NUMERIC UNIQUE NOT NULL,
    order_date DATE,
    shipping_date DATE,
    payment_status VARCHAR(15),
    payment_date DATE
);
ALTER TABLE ORDERS ADD CONSTRAINT orders_customerid_fk FOREIGN KEY(customer_id) REFERENCES CUSTOMER(customer_id);


# --------- CATEGORY TABLE ----------

CREATE TABLE CATEGORY (
	category_id NUMERIC NOT NULL,
    category_name VARCHAR(50)	
);
ALTER TABLE CATEGORY ADD CONSTRAINT category_id_pk PRIMARY KEY(category_id);


# --------- PRODUCT TABLE  -------

CREATE TABLE PRODUCT(
	product_id NUMERIC NOT NULL,
    product_name VARCHAR(50) NOT NULL,
    category_id NUMERIC NOT NULL,
    product_price NUMERIC(5,2) NOT NULL DEFAULT 0.00,
	product_brand VARCHAR(30),
    product_subcategory VARCHAR(30),
    quantity_in_stock INT,
    product_description VARCHAR(250),
    product_size VARCHAR(10),
    product_color VARCHAR(30)
    );
ALTER TABLE PRODUCT ADD CONSTRAINT product_id_pk PRIMARY KEY (product_id);
ALTER TABLE PRODUCT ADD CONSTRAINT  FOREIGN KEY(category_id) REFERENCES CATEGORY(category_id);


# --------- ORDER_DETAIL TABLE (INTERSECTION TABLE B/W PRODUCT & ORDER) ----

CREATE TABLE ORDER_DETAIL(
	order_id INT NOT NULL,
	product_id NUMERIC NOT NULL,
    quantity INT,
    discount NUMERIC(2, 0)
); 
ALTER TABLE ORDER_DETAIL ADD CONSTRAINT order_product_item_id_pk PRIMARY KEY (order_id, product_id);
ALTER TABLE ORDER_DETAIL ADD CONSTRAINT order_id_fk FOREIGN KEY (order_id) REFERENCES ORDERS(order_id);
ALTER TABLE ORDER_DETAIL ADD CONSTRAINT product_id_fk FOREIGN KEY (product_id) REFERENCES PRODUCT(product_id);
ALTER TABLE ORDER_DETAIL ADD CONSTRAINT discount_check_fk CHECK (discount >=0 AND discount < 100);


# --------- SUPPLIER TABLE ------------

CREATE TABLE SUPPLIER(
	supplier_id NUMERIC NOT NULL,
    supplier_name VARCHAR(50) NOT NULL,
    supplier_contact NUMERIC(10)  NOT NULL    
);
ALTER TABLE SUPPLIER ADD CONSTRAINT supplier_id_pk PRIMARY KEY (supplier_id);
ALTER TABLE SUPPLIER ADD CONSTRAINT supplier_contact_uk UNIQUE KEY (supplier_contact);
ALTER TABLE SUPPLIER ADD CONSTRAINT supplier_contact_len CHECK (LENGTH(supplier_contact) = 10);


# --------- PRODUCT_SUPPLY (INTERSECTION TABLE B/W PRODUCT & SUPPLY) -

CREATE TABLE PRODUCT_SUPPLY(
	product_id NUMERIC NOT NULL,
    supplier_id NUMERIC NOT NULL
);
ALTER TABLE PRODUCT_SUPPLY ADD CONSTRAINT product_supplier_pk PRIMARY KEY (product_id, supplier_id);
ALTER TABLE PRODUCT_SUPPLY ADD CONSTRAINT product_id_fk2 FOREIGN KEY (product_id) REFERENCES PRODUCT(product_id);
ALTER TABLE PRODUCT_SUPPLY ADD CONSTRAINT supplier_id_prod_fk FOREIGN KEY (supplier_id) REFERENCES SUPPLIER(supplier_id);


# ---------- ZIP CODE TABLE ---------

CREATE TABLE ZIP(
	postal_code VARCHAR(6) NOT NULL,
    city VARCHAR(20) NOT NULL,
    state_province VARCHAR(20) NOT NULL
);
ALTER TABLE ZIP ADD CONSTRAINT postal_code_pk PRIMARY KEY (postal_code);
ALTER TABLE ZIP ADD CONSTRAINT postal_code_check CHECK (LENGTH(postal_code)=6);


#  --------- LOCATION TABLE ----------

CREATE TABLE LOCATION(
	location_id NUMERIC NOT NULL,
    postal_code VARCHAR(6) NOT NULL,
    street_address VARCHAR(70)
);
ALTER TABLE LOCATION ADD CONSTRAINT location_id_pk PRIMARY KEY (location_id);
ALTER TABLE LOCATION ADD CONSTRAINT postal_code_fk FOREIGN KEY (postal_code) REFERENCES ZIP(postal_code); 


# ---------- WAREHOUSE TABLE ----------

CREATE TABLE WAREHOUSE(
	warehouse_id NUMERIC NOT NULL,
	location_id NUMERIC NOT NULL
);
ALTER TABLE WAREHOUSE ADD CONSTRAINT warehouse_id_pk PRIMARY KEY (warehouse_id);
ALTER TABLE WAREHOUSE ADD CONSTRAINT location_id_fk FOREIGN KEY (location_id) REFERENCES LOCATION(location_id); 


# ---------- INVENTORY TABLE (INTERSECTION TABLE B/W PRODUCT & WAREHOUSE) ---------

CREATE TABLE INVENTORY(
	warehouse_id NUMERIC NOT NULL,
    product_id NUMERIC NOT NULL,
    quantity INT NOT NULL
);
ALTER TABLE INVENTORY ADD CONSTRAINT warehouse_product_id PRIMARY KEY(warehouse_id, product_id);
ALTER TABLE INVENTORY ADD CONSTRAINT warehouse_p_fk FOREIGN KEY(warehouse_id) REFERENCES WAREHOUSE(warehouse_id);
ALTER TABLE INVENTORY ADD CONSTRAINT product_p_fk FOREIGN KEY(product_id) REFERENCES PRODUCT(product_id);


# ---------- DEPARTMENT TABLE ------

CREATE TABLE DEPARTMENT(
	dept_id NUMERIC NOT NULL,
    department_name VARCHAR(50)
);
ALTER TABLE DEPARTMENT ADD CONSTRAINT department_dept_id_pk PRIMARY KEY(dept_id);


# ---------- STORE TABLE ---------

CREATE TABLE STORE(
	store_id NUMERIC NOT NULL,
    store_name VARCHAR(50),
    store_location NUMERIC
);
ALTER TABLE STORE ADD CONSTRAINT store_id_pk PRIMARY KEY (store_id);
ALTER TABLE STORE ADD CONSTRAINT store_loc_fk FOREIGN KEY(store_location) REFERENCES LOCATION(location_id);


# --------- EMPLOYEE TABLE --------

CREATE TABLE EMPLOYEE(
	employee_id NUMERIC NOT NULL,
    first_name VARCHAR(30) NOT NULL,
    last_name VARCHAR(30) NOT NULL,
    email_id VARCHAR(50) NOT NULL,
    mobile_number NUMERIC(10) UNIQUE KEY,
    birth_date DATE,
    sin_number NUMERIC(10) UNIQUE KEY,
    address VARCHAR(100),
    gender VARCHAR(1),
    salary NUMERIC,
    hire_date DATE NOT NULL,
    job_type VARCHAR(20),
    department_id NUMERIC,
    designation VARCHAR(50),
    store_id NUMERIC,
    manager_id NUMERIC
);
ALTER TABLE EMPLOYEE ADD CONSTRAINT employee_id_pk PRIMARY KEY(employee_id);
ALTER TABLE EMPLOYEE ADD CONSTRAINT email_id_uk UNIQUE KEY(email_id);
ALTER TABLE EMPLOYEE ADD CONSTRAINT sin_check CHECK (LENGTH(sin_number)=10);
ALTER TABLE EMPLOYEE ADD CONSTRAINT gender_check CHECK (gender IN ('M', 'F'));
ALTER TABLE EMPLOYEE ADD CONSTRAINT chk_phone CHECK (LENGTH(mobile_number)=10);
ALTER TABLE EMPLOYEE ADD CONSTRAINT store_fk FOREIGN KEY(store_id) REFERENCES STORE(store_id);
ALTER TABLE EMPLOYEE ADD CONSTRAINT dept_fk FOREIGN KEY(department_id) REFERENCES DEPARTMENT(dept_id);
ALTER TABLE EMPLOYEE ADD CONSTRAINT manager_fk FOREIGN KEY(manager_id) REFERENCES EMPLOYEE(employee_id);


# --------LOCATION_DEPARTMENT TABLE (INTERSECTION TABLE B/W LOCATION & DEPARTMENT) ------

CREATE TABLE LOCATION_DEPARTMENT(
	location_id NUMERIC NOT NULL,
    department_id NUMERIC NOT NULL,
    department_manager NUMERIC 
);
ALTER TABLE LOCATION_DEPARTMENT ADD CONSTRAINT loc_dept_id_pk PRIMARY KEY (location_id, department_id);
ALTER TABLE LOCATION_DEPARTMENT ADD CONSTRAINT loc_id_fk FOREIGN KEY (location_id) REFERENCES LOCATION(location_id);
ALTER TABLE LOCATION_DEPARTMENT ADD CONSTRAINT dep_fk FOREIGN KEY(department_id) REFERENCES DEPARTMENT(dept_id);
ALTER TABLE LOCATION_DEPARTMENT ADD CONSTRAINT dep_manager_fk FOREIGN KEY(department_manager) REFERENCES EMPLOYEE(employee_id);


# --------INVOICE TABLE (AS VIEW) ------

CREATE VIEW INVOICE AS
	(SELECT  od.order_id, c.first_name, c.last_name, p.product_name, p.product_price, od.quantity, (p.product_price*od.quantity) as Total
	from order_detail od, orders o, product p, customer c
	where (od.order_id = o.order_id and c.customer_id = o.customer_id and od.product_id = p.product_id));


# ------------------------------------- INSERTION OF DATA ----------------------------------------

# -------- CUSTOMER TABLE -----------

INSERT INTO CUSTOMER(first_name, last_name, mobile_number, email_id, address, city, state, country, postal_code)
VALUES('Louanne','Martin',5198923451,'louanne.martin@hotmail.com','1 Campfire Ave. ','Yuba City','AB', 'Canada',959913);
 
INSERT INTO CUSTOMER(first_name, last_name, mobile_number, email_id, address, city, state, country, postal_code) 
VALUES('Violet','Valenzuela',2198923452,'violet.valenzuela@msn.com','8668 Piper Street ','Plattsburgh','ON', 'Canada',129021);

INSERT INTO CUSTOMER(first_name, last_name, mobile_number, email_id, address, city, state, country, postal_code) 
VALUES('Carie','Kidd',NULL,'carie.kidd@yahoo.com','6 East Clinton Street ','Monroe','ON','Canada',109502);

INSERT INTO CUSTOMER(first_name, last_name, mobile_number, email_id, address, city, state, country, postal_code) 
VALUES('Kellie','Franco',NULL,'kellie.franco@yahoo.com','444 South Walnut Rd. ','Commack','ON', 'Canada',109502);

INSERT INTO CUSTOMER(first_name, last_name, mobile_number, email_id, address, city, state, country, postal_code) 
VALUES('Nichelle','Howell',NULL,'nichelle.howell@aol.com','7670 Forest St. ','Scarsdale','QC', 'Canada', 105832);

INSERT INTO CUSTOMER(first_name, last_name, mobile_number, email_id, address, city, state, country, postal_code)
VALUES('Sarthak','Bhaijaan',3197873457,'sarthak.shah96@gmail.com','77 Shephard Ave. ', 'Calgary', 'AB', 'Canada',311164);
 
INSERT INTO CUSTOMER(first_name, last_name, mobile_number, email_id, address, city, state, country, postal_code) 
VALUES('Ashwin','Rajput',9999923459,'rajput_ashwin69@outlook.com', '36 Piper Street ', 'Vancouver','BC', 'Canada', 528013);

INSERT INTO CUSTOMER(first_name, last_name, mobile_number, email_id, address, city, state, country, postal_code) 
VALUES('Britney','Spears',NULL,'britney_spears@yahoo.com','York Knight Street ', 'Quebec', 'QC', 'Canada',889715);

INSERT INTO CUSTOMER(first_name, last_name, mobile_number, email_id, address, city, state, country, postal_code) 
VALUES('Sheila','Francis',8720978218,'francissheila@gmail.com','Apple street Park','Ottawa','ON', 'Canada',197255);

INSERT INTO CUSTOMER(first_name, last_name, mobile_number, email_id, address, city, state, country, postal_code) 
VALUES('Tim','Williamson',1236789103,'williamsontim98@agmail.com','78 York street','Winnipeg','MB', 'Canada', 109834);


# ----------------ORDERS TABLE-----------------------

INSERT INTO ORDERS(customer_id,order_date, shipping_date, payment_status, payment_date, transaction_id) 
VALUES(2, '2022-07-25', '2022-07-28', "APPROVED",'2022-07-26', 79314);

INSERT INTO ORDERS(customer_id, order_date, shipping_date, payment_status, payment_date, transaction_id) 
VALUES(2, '2022-10-01', '2022-10-02', "APPROVED", '2022-10-01', 84214);

INSERT INTO ORDERS(customer_id, order_date, shipping_date, payment_status, payment_date, transaction_id) 
VALUES(2, '2021-12-17', NULL, "NOT APPROVED", NULL, 93458);

INSERT INTO ORDERS(customer_id, order_date, shipping_date, payment_status, payment_date, transaction_id) 
VALUES(1, '2022-05-01', '2022-05-04', "APPROVED", '2022-05-04', 32145);

INSERT INTO ORDERS(customer_id, order_date, shipping_date, payment_status, payment_date, transaction_id) 
VALUES(3, '2021-09-07', '2021-09-10', "APPROVED", '2021-09-08', 66732);

INSERT INTO ORDERS(customer_id, order_date, shipping_date, payment_status, payment_date, transaction_id) 
VALUES(8, '2022-09-07', '2022-09-09', "APPROVED", '2022-09-07', 99732);

INSERT INTO ORDERS(customer_id, order_date, shipping_date, payment_status, payment_date, transaction_id) 
VALUES(8, '2022-09-07', '2022-09-09', "APPROVED", '2022-09-07', 99632);

INSERT INTO ORDERS(customer_id, order_date, shipping_date, payment_status, payment_date, transaction_id) 
VALUES(6, '2022-11-07', '2022-11-09', "APPROVED", '2022-11-07', 87132);

INSERT INTO ORDERS(customer_id, order_date, shipping_date, payment_status, payment_date, transaction_id) 
VALUES(6, '2022-11-07', '2022-11-09', "APPROVED", '2022-11-07', 87133);

INSERT INTO ORDERS(customer_id, order_date, shipping_date, payment_status, payment_date, transaction_id) 
VALUES(4, '2022-12-02', '2022-12-03', "APPROVED", '2022-12-02', 87134);

INSERT INTO ORDERS(customer_id, order_date, shipping_date, payment_status, payment_date, transaction_id) 
VALUES(4, '2022-12-02', '2022-12-03', "APPROVED", '2022-12-02', 87135);

INSERT INTO ORDERS(customer_id, order_date, shipping_date, payment_status, payment_date, transaction_id) 
VALUES(10, '2020-12-02', '2020-12-02', "APPROVED", '2020-12-02', 87136);

INSERT INTO ORDERS(customer_id, order_date, shipping_date, payment_status, payment_date, transaction_id) 
VALUES(10, '2022-12-06', '2022-12-06', "APPROVED", '2022-12-06', 87137);

INSERT INTO ORDERS(customer_id, order_date, shipping_date, payment_status, payment_date, transaction_id) 
VALUES(10, '2021-12-05', '2021-12-05', "APPROVED", '2021-12-05', 87138);


#------- CATEGORY TABLE ----
# --- ---PRODUCT CATEGORY ['ACTIVEWEAR', SHOES, JACKETS, SPORT EQUIPMENT, FORMAL, PANTS, ACCESSORIES]

INSERT INTO CATEGORY( category_id, category_name)
VALUES(7467,"ACTIVEWEAR");

INSERT INTO CATEGORY( category_id, category_name)
VALUES(4676,"SHOES");

INSERT INTO CATEGORY( category_id, category_name)
VALUES(9875,"JACKETS");

INSERT INTO CATEGORY( category_id, category_name)
VALUES(3245,"SPORT EQUIPMENT");

INSERT INTO CATEGORY( category_id, category_name)
VALUES(3249,"FORMAL");

INSERT INTO CATEGORY( category_id, category_name)
VALUES(5425,"PANTS");

INSERT INTO CATEGORY( category_id, category_name)
VALUES(5897,"ACCESSORIES");


# ------- PRODUCT TABLE  -----

INSERT INTO PRODUCT (product_id, product_name, category_id, product_price, product_brand, product_subcategory, quantity_in_stock, 
product_description, product_size, product_color)
VALUES(6565, "NIKE T", 7467, 29.99, "NIKE", "T-SHIRT", 254, "Gym wear T-shirt", "Medium", "Olive Green");

INSERT INTO PRODUCT(product_id, product_name, category_id, product_price, product_brand, product_subcategory,
quantity_in_stock, product_description, product_size, product_color)
VALUES(6581, "PANTS Under Armour", 5425, 76.25, "Under Armour", "Pants", 83, "sweatpants", "Large", "Black");

INSERT INTO PRODUCT(product_id, product_name,category_id, product_price, product_brand, product_subcategory,
quantity_in_stock, product_description, product_size, product_color)
VALUES(9245, "Addidas shoes",4676, 145.75, "Addidas", "Shoes", 26, "shoes", "US 9", "White");

INSERT INTO PRODUCT(product_id, product_name,category_id, product_price, product_brand, product_subcategory,
quantity_in_stock, product_description, product_size, product_color)
VALUES(5031, "Trucker Jacket", 9875, 250, "GAP", "jacket", 16, "winter Trucker Jacket", "Medium", "Blue");

INSERT INTO PRODUCT(product_id, product_name,category_id, product_price, product_brand, product_subcategory,
quantity_in_stock, product_description, product_size, product_color)
VALUES(5032, "Puffer Jacket", 9875, 50, "Columbia", "jacket", 16, "winter Puffer Jacket", "Medium", "Green");

INSERT INTO PRODUCT(product_id, product_name,category_id, product_price, product_brand, product_subcategory,
quantity_in_stock, product_description, product_size, product_color)
VALUES(5033, "Puffer Jacket", 9875, 52.45, "Columbia", "jacket", 16, "winter Puffer Jacket", "Small", "Blue");

INSERT INTO PRODUCT(product_id, product_name,category_id, product_price, product_brand, product_subcategory,
quantity_in_stock, product_description, product_size, product_color)
VALUES(5034, "Puffer Jacket", 9875, 52.45, "Columbia", "jacket", 16, "winter Puffer Jacket", "Large", "Blue");

INSERT INTO PRODUCT(product_id, product_name,category_id, product_price, product_brand, product_subcategory,
quantity_in_stock, product_description, product_size, product_color)
VALUES(5035, "Puffer Jacket", 9875, 52.45, "Columbia", "jacket", 16, "winter Puffer Jacket", "X Large", "Black");

INSERT INTO PRODUCT(product_id, product_name,category_id, product_price, product_brand, product_subcategory,
quantity_in_stock, product_description, product_size, product_color)
VALUES(5036, "Puffer Jacket", 9875, 52.45, "Columbia", "jacket", 16, "winter Puffer Jacket", "XX Large", "Blue");

INSERT INTO PRODUCT(product_id, product_name,category_id, product_price, product_brand, product_subcategory,
quantity_in_stock, product_description, product_size, product_color)
VALUES(5037, "Goose Jacket", 9875, 252.45, "Goose", "jacket", 16, "Canada's best jackets. Superior quaality, 
Trustful to wear during the winters", "Large", "Green");

INSERT INTO PRODUCT(product_id, product_name,category_id, product_price, product_brand, product_subcategory,
quantity_in_stock, product_description, product_size, product_color)
VALUES(5038, "Goose Jacket", 9875, 252.45, "Goose", "jacket", 16, "Canada's best jackets. Superior quaality, 
Trustful to wear during the winters", "Large", "Green");

INSERT INTO PRODUCT(product_id, product_name,category_id, product_price, product_brand, product_subcategory,
quantity_in_stock, product_description, product_size, product_color)
VALUES(5039, "Goose Jacket", 9875, 252.45, "Goose", "jacket", 16, "Canada's best jackets. Superior quaality, 
Trustful to wear during the winters", "X Large", "White");

INSERT INTO PRODUCT(product_id, product_name,category_id, product_price, product_brand, product_subcategory,
quantity_in_stock, product_description, product_size, product_color)
VALUES(5040, "Goose Jacket", 9875, 252.45, "Goose", "jacket", 16, "Canada's best jackets. Superior quaality, 
Trustful to wear during the winters", "X Large", "Black");

INSERT INTO PRODUCT(product_id, product_name,category_id, product_price, product_brand, product_subcategory,
quantity_in_stock, product_description, product_size, product_color)
VALUES(5041, "Goose Jacket", 9875, 252.45, "Goose", "jacket", 16, "Canada's best jackets. Superior quaality, 
Trustful to wear during the winters", "Medium", "Black");

INSERT INTO PRODUCT(product_id, product_name,category_id, product_price, product_brand, product_subcategory,
quantity_in_stock, product_description, product_size, product_color)
VALUES(5042, "Goose Jacket", 9875, 252.45, "Goose", "jacket", 16, "Canada's best jackets. Superior quaality, 
Trustful to wear during the winters", "Small", "Black");

INSERT INTO PRODUCT(product_id, product_name,category_id, product_price, product_brand, product_subcategory,quantity_in_stock,
product_description, product_size, product_color)
VALUES(2945, "Football", 3245, 75.25, "Puma", "football", 18, "soccer ball", "universal", "White");

INSERT INTO PRODUCT(product_id, product_name,category_id, product_price, product_brand, product_subcategory,quantity_in_stock,
product_description, product_size, product_color)
VALUES(2946, "Football", 3245, 75.25, "Nike", "football", 18, "soccer ball", "universal", "Black");

INSERT INTO PRODUCT(product_id, product_name,category_id, product_price, product_brand, product_subcategory,quantity_in_stock,
product_description, product_size, product_color)
VALUES(2947, "Football", 3245, 75.25, "Nike", "football", 18, "soccer ball", "universal", "Red");

INSERT INTO PRODUCT(product_id, product_name,category_id, product_price, product_brand, product_subcategory,quantity_in_stock, 
product_description, product_size, product_color)
VALUES(3185,"Hockey Stick", 3245, 119.99, "sherwood", "sticks", 16, "Hockey Stick with leather covered handle for better grip", "Medium", "Black");

INSERT INTO PRODUCT(product_id, product_name,category_id, product_price, product_brand, product_subcategory,quantity_in_stock, 
product_description, product_size, product_color)
VALUES(3186,"Hockey Stick", 3245, 175.99, "sherwood", "sticks", 16, "Made from the Deodar wood. One of the best in the market.", "Large", "Black");

INSERT INTO PRODUCT(product_id, product_name,category_id, product_price, product_brand, product_subcategory,quantity_in_stock, 
product_description, product_size, product_color)
VALUES(3187,"Hockey Stick", 3245, 175.99, "sherwood", "sticks", 16, "Made from the Deodar wood. One of the best in the market.", "Medium", "Black");

INSERT INTO PRODUCT(product_id, product_name,category_id, product_price, product_brand, product_subcategory,quantity_in_stock, 
product_description, product_size, product_color)
VALUES(3188,"Hockey Stick", 3245, 215.99, "sherwood", "sticks", 16, "Made from the Deodar wood. One of the best in the market. 
And signed by the famous hockey player Wayne Gretzky ", "Medium", "Black");

INSERT INTO PRODUCT(product_id, product_name,category_id, product_price, product_brand, product_subcategory,
quantity_in_stock, product_description, product_size, product_color)
VALUES(5460,"Neck Gaiter", 5897, 25.20 , "North Face", "Accessories", 68, 
"Woolen scarf manufactured by the most trustworthy brand around the world", "Universal", "Brown");

INSERT INTO PRODUCT(product_id, product_name,category_id, product_price, product_brand, product_subcategory,
quantity_in_stock, product_description, product_size, product_color)
VALUES(5461,"Neck Gaiter", 5897, 35.20 , "North Face", "Accessories", 68, 
"Polyster scarf with fleece inside,manufactured by the most trustworthy brand around the world", "Universal", "Black");

INSERT INTO PRODUCT(product_id, product_name,category_id, product_price, product_brand, product_subcategory,
quantity_in_stock, product_description, product_size, product_color)
VALUES(5462,"Neck Gaiter", 5897, 35.20 , "North Face", "Accessories", 68, 
"Polyster scarf with fleece inside,manufactured by the most trustworthy brand around the world", "Universal", "Grey");

INSERT INTO PRODUCT(product_id, product_name,category_id, product_price, product_brand, 
product_subcategory,quantity_in_stock, product_description, product_size, product_color)
VALUES(9865,"Full Suit", 3249, 745.75, "Van Huesen", "Suit", 23, "Formal Attire makes you look smart and 
stand out of the crowd", "Medium", "Black");

INSERT INTO PRODUCT(product_id, product_name,category_id, product_price, product_brand, 
product_subcategory,quantity_in_stock, product_description, product_size, product_color)
VALUES(9866,"Full Suit", 3249, 345.75, "Van Huesen", "Suit", 3, "Formal Attire makes you look smart and 
stand out of the crowd", "Small", "Black");

INSERT INTO PRODUCT(product_id, product_name,category_id, product_price, product_brand, 
product_subcategory,quantity_in_stock, product_description, product_size, product_color)
VALUES(9867,"Full Suit", 3249, 545.75, "Raymond", "Suit", 14, "Every Gentleman's Choice", "Medium", "Grey");

INSERT INTO PRODUCT(product_id, product_name,category_id, product_price, product_brand, 
product_subcategory,quantity_in_stock, product_description, product_size, product_color)
VALUES(9868,"Full Suit", 3249, 545.75, "Raymond", "Suit", 14, "Every Gentleman's Choice", "Medium", "Light Blue");

INSERT INTO PRODUCT(product_id, product_name,category_id, product_price, product_brand, 
product_subcategory,quantity_in_stock, product_description, product_size, product_color)
VALUES(9869,"Glasses", 5897, 90.50, "Ray Ban", "Glasses", 0, "The Best Glasses", "Universal", "Golden");

INSERT INTO PRODUCT(product_id, product_name,category_id, product_price, product_brand, 
product_subcategory,quantity_in_stock, product_description, product_size, product_color)
VALUES(9870,"Glasses", 5897, 100.50, "Glass Hut", "Glasses", 0, "The Best Glasses", "Universal", "Golden");

INSERT INTO PRODUCT(product_id, product_name,category_id, product_price, product_brand, 
product_subcategory,quantity_in_stock, product_description, product_size, product_color)
VALUES(9871,"Glasses", 5897, 190.50, "Burbury", "Glasses", 0, "Gentlemen's Glasses", "Universal", "Black");

INSERT INTO PRODUCT(product_id, product_name,category_id, product_price, product_brand, 
product_subcategory,quantity_in_stock, product_description, product_size, product_color)
VALUES(9872, "Nike Flex Shoes", 4676, 150.75, "Nike", "Nike", 0, "Best for running", "US 10", "Black");

INSERT INTO PRODUCT(product_id, product_name,category_id, product_price, product_brand, 
product_subcategory,quantity_in_stock, product_description, product_size, product_color)
VALUES(9873, "New Balance Shoes", 4676, 118.75, "New Balance", "New Balance", 0, "Best for walking", "US 9", "White");


# ------------ ORDER DETAIL ---------

INSERT INTO ORDER_DETAIL (order_id, product_id, quantity, discount)
VALUES
(1, 3185, 2, 0.0),
(1, 5031, 1, 0.0),
(1, 5461, 1, 0.0);

INSERT INTO ORDER_DETAIL(order_id, product_id, quantity, discount)
VALUES
(2, 9865, 1, 0.0),
(2, 9245, 2, 0.0),
(2, 6565, 1, 0.0),

(4, 5041, 1, 0.0),
(4, 9245, 1, 0.0),
(4, 2946, 1, 0.0),

(5, 5033, 1, 0.0),
(5, 5460, 2, 0.0),
(5, 6565, 1, 0.0),
(5, 9865, 1, 0.0),
(5, 2946, 1, 0.0);

INSERT INTO ORDER_DETAIL(order_id, product_id, quantity, discount)
VALUES
(13, 9865, 1, 0.0),
(13, 9245, 2, 0.0),
(13, 6565, 1, 0.0),
(13, 9873,2,0.0),
(13,9868,1,0.0),
(13,5461,1,0.0);


# ----------- SUPPLIER ----

INSERT INTO SUPPLIER(supplier_id, supplier_name, supplier_contact)
VALUES(65423, "Mega Footwear", 6472674509);

INSERT INTO SUPPLIER(supplier_id, supplier_name, supplier_contact)
VALUES(54698, "FashionTIY", 6471232207);

INSERT INTO SUPPLIER(supplier_id, supplier_name, supplier_contact)
VALUES(12876, "Tata", 6478762306);

INSERT INTO SUPPLIER(supplier_id, supplier_name, supplier_contact)
VALUES(45321, "Reliance Logistics", 4373567634);

INSERT INTO SUPPLIER(supplier_id, supplier_name, supplier_contact)
VALUES(68732, "Adani Group", 2372340546);

INSERT INTO SUPPLIER(supplier_id, supplier_name, supplier_contact)
VALUES(23598, "Adi Group", 4371237689);


# -------- PRODUCT_SUPPLY --------

INSERT INTO PRODUCT_SUPPLY
VALUES
(2945, 12876),
(2946,12876),
(2947,12876),
(3185,12876),
(3186,12876),
(3187,12876),
(3188,12876),
(5031,54698),
(5032,54698),
(5033,54698),
(5034,54698),
(5035,54698),
(5036,54698),
(5037,54698),
(5038,54698),
(5039,54698),
(5040,54698),
(5041,54698),
(5042,54698),
(5460,23598),
(5461,23598),
(5462,23598),
(6565,45321),
(6581,45321),
(9245,65423),
(9865,68732),
(9866,68732),
(9867,68732),
(9868,68732);


# -------- ZIP -----------

INSERT INTO ZIP (postal_code, city, state_province) 
VALUES
(959913,"YubaCity","AB"),
(129021,"Plattsburgh","ON"),
(109502,"Monroe","ON"),
(105832,"Scarsdale","QC"),
(311164,"Calgary","AB"),
(311168,"Calgary","AB"),
(311165,"Calgary","AB"),
(311166,"Calgary","AB"),
(311167,"Calgary","AB"),
(321184,"Edmonton","AB"),
(321189,"Edmonton","AB"),
(321191,"Edmonton","AB"),
(528013,"Vancouver","BC"),
(889715,"Quebec","QC"),
(197255,"Ottawa","ON"),
(109834,"Winnipeg","MB"),
(934882,"Sudbury","ON"),
(107882,"Surrey","BC"),
(107902,"Victoria","BC");


# ----------- LOCATION TABLE --------

INSERT INTO LOCATION (location_id, postal_code, street_address)
VALUES
(77, 105832, "306 116 SW"),
(78, 109502, "106 Churchill Street"),
(79, 109834, "16 Williams Street"),
(80, 129021, "02 Rathburn Street"),
(81, 197255, "9 Moffat Avenue"),
(82, 311164, "22 8921 Skylar Circle"),
(83, 311165, "312 118 North East"),
(84, 311166, "411 789 North East Avenue"),
(85, 311167, "511 989 North West Avenue"),
(86, 311168, "97 778 South West Avenue"),
(87, 321184, "887 211 South East Avenue"),
(88, 321189, "993 111 South East Avenue"),
(89, 321191, "783 121 South West Avenue"),
(90, 528013, "88 Victoria Street"),
(91, 889715, "12 Malton Street"),
(92, 934882, "63 David Street"),
(93, 959913, "61 Trudeau Street");


# -------- WAREHOUSE TABLE ------

INSERT INTO WAREHOUSE(warehouse_id, location_id)
VALUES
(113,  77),
(114,  78),
(115,  79),
(116,  80),
(117,  81),
(118,  82),
(119,  83);


# ---------- INVENTORY TABLE ------

INSERT INTO INVENTORY (warehouse_id, product_id, quantity)
VALUES
(113,2945,200),
(113,2946,30),
(113,2947,10),
(113,3185,40),
(113,3186,39),
(113,3187,18),
(113,3188,18),
(113,5462,67),
(113,9245,23),
(114,5031,23),
(114,5032,13),
(114,5033,232),
(114,5034,223),
(114,5035,13),
(114,5036,33),
(114,5037,78),
(114,5038,99),
(114,5039,89),
(114,5040,19),
(114,5041,300),
(114,5042,99),
(114,5462,223),
(114,9245,88),
(115,5460,19),
(115,5461,44),
(115,5462,23),
(115,6581,48),
(116,6565,34),
(116,6581,492),
(117,9245,988),
(117,9868,08),
(118,9865,64),
(118,9866,49),
(118,9867,67),
(118,9868,83),
(119,9868,33);


# ------------ DEPARTMENT TABLE ------

INSERT INTO DEPARTMENT(dept_id, department_name)
VALUES
(2310, "Administrative"),
(2311, "HR Department"),
(2312, "Packing"),
(2313, "Sales"),
(2314, "Marketing"),
(2315, "Technology");


# ---------- STORE TABLE ----------------

INSERT INTO STORE(store_id, store_name, store_location)
VALUES 
(8049, "Alpha Sports, Churchill Centre", 78),
(8050, "Alpha Sports, Williams Centre", 79),
(8051, "Alpha Sports, Rathburn Centre", 80),
(8052, "Alpha Sports, Moffat Centre", 81),
(8053, "Alpha Sports, Skylar Circle", 82);

# ------------------- EMPLOYEE TABLE ------------

INSERT INTO EMPLOYEE(employee_id, first_name, last_name, email_id, mobile_number,birth_date, sin_number, address, gender, 
salary, hire_date, job_type, department_id, 
 designation, store_id, manager_id)
VALUES
(87824, "Danny", "Carter", "carter78@gmail.com", 6478672568, "1990-11-23", 7556523020, "89 William Ave", "M",
 52632, "2018-09-12", "Full time", 2310, "Store Manager",  8049, NULL),
(87821, "Jenna", "Joseph", "jeenajp9@gmail.com", 3006327564, "1989-02-23", 9886352300, "45 queens street", "F", 
43215, "2019-09-12", "Full time", 2310, "Admin Associate",  8049, 87824),

(87822, "Emma", "Watson", "emma89@gmail.com", 5076227564, "1996-06-13", 7856352300, "123 younge ave","F",
 28632, "2022-09-12", "Part time", 2311, "HR",  8049, 87824),
 
 (87823, "Janaki", "Sampath", "sampath_janki8@gmail.com", 5198972345, "1998-06-13", 7556252300, "89 William Ave", "F",
 32632, "2022-09-12", "Full time", 2311, "HR",  8049, 87824),

  

 (87825, "Aakarshan", "Dutt", "dutt_akarshan99@gmail.com", 5178970068, "1998-07-03", 7976230092, "89 Brampton Ave", "M",
 52632, "2020-09-12", "Full time", 2312, "Inventory Manager",  8049, 87824),
 
 (87826, "Daine", "Panella", "dianp@gmail.com", 9876660092, "1986-05-11", 9855652302, "6 forest laneway","F",
 20000, "2022-09-12", "Full time", 2313, "Sales Associate",  8049, 87824),

 (87827, "Oliver", "Ethan", "oliver@gmail.com", 4376767864, "1998-03-08", 9005652301, "2 forest laneway","M",
 20000, "2022-09-12", "Full time", 2313, "Sales Associate",  8049, 87824),

 (87828, "Joan", "Moore", "joan@gmail.com", 9074990064, "1985-03-07", 1005652304, "4 forest laneway","F",
 20000, "2022-09-12", "Part time", 2312, "Packaging Technician",  8049, 87824),

 (87829, "Lucas", "Chris", "chris.lucas@gmail.com", 9976767864, "1992-02-14", 2005652305, "689 finch street","M",
 20000, "2022-09-12", "Full time", 2312, "Packaging Technician",  8049, 87824),

 (87830, "Jacob", "Marvel", "jacobmarvel@gmail.com", 4976760064, "1990-01-16", 3005652305, "100 Doris Avenue","M",
 20000, "2022-09-12", "Full time", 2315, "Business Associate",  8049, 87824);

INSERT INTO EMPLOYEE
VALUES (87831, "Martin", "King", "martin_king45@gmail.com", 7071124064, "1990-01-16", 3105652335, "132 Shephard Avenue","M",
 40000, "2022-09-12", "Full time", 2315, "Business Associate",  8049, 87824);
INSERT INTO EMPLOYEE
VALUES (87832, "Himanshu", "Mathur", "mathur_him78@gmail.com", 9070124064, "1997-01-16", 9105652335, "22 Shephard Avenue","M",
 60000, "2022-09-12", "Full time", 2315, "District Business Associate",  8049, 87824);
 INSERT INTO EMPLOYEE
VALUES (87833, "Lavanya", "Sk", "lavanyask_99@gmail.com", 8073124064, "1998-01-16", 3133544335, "02 Shephard Avenue","F",
 55000, "2022-09-12", "Full time", 2315, "Lead Business Associate",  8049, 87824);


INSERT INTO EMPLOYEE
VALUES (87834, "Karen", "Sword", "sword_karen88@gmail.com", 4042124064, "1990-01-16", 2003544335, "8080 Dundas Street","F",
 65000, "2020-01-12", "Full time", 2310, "Store Admin",  8050, NULL);
INSERT INTO EMPLOYEE
VALUES (87835, "Andrea", "Cuttler", "andrea_cutler99@gmail.com", 2149124064, "1992-01-16", 3000014235, "8081 Dundas Street East","F",
 62000, "2019-01-12", "Full time", 2313, "Lead Sales",  8050, 87834);

INSERT INTO EMPLOYEE
VALUES (87838, 'Andru', 'Mason', 'andrumason@gmail.com', 9149124064, '1992-01-16', 8900014235, '8081 Dundas Street East','F',
62000, '2019-01-12', 'Full time', 2313, 'Lead Sales',  8050, 87834);
# -------- LOCATION DEPARTMENT --------

INSERT INTO LOCATION_DEPARTMENT(location_id, department_id, department_manager)
VALUES
(78, 2310, 87821),
(78, 2311, 87823),
(78, 2312, 87828),
(78, 2313, 87827),
(78, 2315, 87830);


# -------------------------------
#drop database database_project;
# -------------------------------
#SET SQL_SAFE_UPDATES = 0;
# -------------------------------


# -------------------------------- CONSTRAINT TESTING --------------------------------

# --- PRIMARY KEY (AUTO_GENERATED)
INSERT INTO CUSTOMER(customer_id,first_name, last_name, mobile_number, email_id, address, city, state, country, postal_code) 
VALUES(10, 'Tim','Williamson',1236789103,'williamsontim98@agmail.com','78 York street','Winnipeg','MB', 'Canada', 109834);

INSERT INTO ORDERS(order_id, customer_id, order_date, shipping_date, payment_status, payment_date, transaction_id) 
VALUES(14, 10, '2021-12-05', '2021-12-05', 'APPROVED', '2021-12-05', 87138);


# --- PRIMARY KEY (16)
INSERT INTO CATEGORY( category_id, category_name)
VALUES(5897,'ACCESSORIES');

INSERT INTO PRODUCT(product_id, product_name,category_id, product_price, product_brand, 
product_subcategory,quantity_in_stock, product_description, product_size, product_color)
VALUES(9873, 'New Balance Shoes', 4676, 118.75, 'New Balance', 'New Balance', 0, 'Best for walking', 'US 9', 'White');

INSERT INTO ORDER_DETAIL(order_id, product_id, quantity, discount)
VALUES (13, 9865, 1, 0.0);

INSERT INTO SUPPLIER(supplier_id, supplier_name, supplier_contact)
VALUES(23598, 'Adi Group', 4371237689);

INSERT INTO PRODUCT_SUPPLY 
VALUES (2945, 12876);

INSERT INTO ZIP (postal_code, city, state_province) 
VALUES (959913, 'Yuba City', 'AB');

INSERT INTO LOCATION (location_id, postal_code, street_address)
VALUES(77, 105832, '306 116 SW');

INSERT INTO WAREHOUSE(warehouse_id, location_id)
VALUES (113,  77);

INSERT INTO INVENTORY (warehouse_id, product_id, quantity)
VALUES (113, 2945, 200);

INSERT INTO DEPARTMENT(dept_id, department_name)
VALUES (2310, 'Administrative');

INSERT INTO STORE(store_id, store_name, store_location)
VALUES (8049, 'Alpha Sports, Churchill Centre', 78);

INSERT INTO LOCATION_DEPARTMENT(location_id, department_id, department_manager)
VALUES (78, 2310, 87821);

INSERT INTO EMPLOYEE(employee_id, first_name, last_name, email_id, mobile_number,birth_date, sin_number, address, gender, 
salary, hire_date, job_type, department_id, designation, store_id, manager_id)
VALUES (87824, 'Danny', 'Carter', 'carter78@gmail.com', 6478672568, '1990-11-23', 7556523020, '89 William Ave', 'M',
 52632, '2018-09-12', 'Full time', 2310, 'Store Manager',  8049, NULL);


 # --- UNIQUE KEY (6)
INSERT INTO CUSTOMER(first_name, last_name, mobile_number, email_id, address, city, state, country, postal_code) 
VALUES('Tim','Williamson',1236789103,'williamsontim98@agmail.com','78 York street','Winnipeg','MB', 'Canada', 109834);

INSERT INTO ORDERS(customer_id, order_date, shipping_date, payment_status, payment_date, transaction_id) 
VALUES(10, '2021-12-05', '2021-12-05', 'APPROVED', '2021-12-05', 87138);

INSERT INTO SUPPLIER(supplier_id, supplier_name, supplier_contact)
VALUES(23599, 'Adi Group', 4371237689);

INSERT INTO EMPLOYEE
VALUES (87837, 'Andrea', 'Cuttler', 'andrea_cutler99@gmail.com', 9949124064, '1992-01-16', 8900014566, '8081 Dundas Street East','F', 
62000, '2019-01-12', 'Full time', 2313, 'Lead Sales',  8050, 87834);

INSERT INTO EMPLOYEE
VALUES (87838, 'Andru', 'Mason', 'andrumason@gmail.com', 9149124064, '1992-01-16', 8900014235, '8081 Dundas Street East','F',
62000, '2019-01-12', 'Full time', 2313, 'Lead Sales',  8050, 87834);

INSERT INTO EMPLOYEE
VALUES (87838, 'Andru', 'Mason', 'andrumason@gmail.com', 9149124064, '1992-01-16', 8900014239, '8081 Dundas Street East','F',
62000, '2019-01-12', 'Full time', 2313, 'Lead Sales',  8050, 87834);


# --- FOREIGN KEY (17)
INSERT INTO ORDERS(customer_id, order_date, shipping_date, payment_status, payment_date, transaction_id) 
VALUES(1001, '2021-12-05', '2021-12-05', 'APPROVED', '2021-12-05', 87238);

INSERT INTO EMPLOYEE
VALUES (87838, 'Michelle', 'Obama', 'michelle_obama@gmail.com', 6479125064, '1992-01-16', 8900014239, '8081 Dundas Street East','F',
62000, '2019-01-12', 'Full time', 2313, 'Lead Sales',  80000, 87834);

INSERT INTO EMPLOYEE
VALUES (87838, 'Michelle', 'Obama', 'michelle_obama@gmail.com', 6479125064, '1992-01-16', 8900014239, '8081 Dundas Street East','F',
62000, '2019-01-12', 'Full time', 2000, 'Lead Sales',  8050, 87834);

INSERT INTO EMPLOYEE
VALUES (87840, 'Michelle', 'Obama', 'michelle_obama@gmail.com', 6479125064, '1992-01-16', 8900014239, '8081 Dundas Street East','F',
62000, '2019-01-12', 'Full time', 2313, 'Lead Sales',  8050, 8000000);

INSERT INTO LOCATION_DEPARTMENT(location_id, department_id, department_manager)
VALUES (100, 2310, 87821);

INSERT INTO LOCATION_DEPARTMENT(location_id, department_id, department_manager)
VALUES (78, 4000, 87821);

INSERT INTO LOCATION_DEPARTMENT(location_id, department_id, department_manager)
VALUES (78, 2314, 1010);

INSERT INTO PRODUCT(product_id, product_name,category_id, product_price, product_brand, product_subcategory,
quantity_in_stock, product_description, product_size, product_color)
VALUES(9874,'Glasses', 100000, 90.50, 'Ray Ban', 'Glasses', 0, 'The Best Glasses', 'Universal', 'Golden');

INSERT INTO ORDER_DETAIL (order_id, product_id, quantity, discount)
VALUES (10000, 3185, 2, 0.0);

INSERT INTO ORDER_DETAIL (order_id, product_id, quantity, discount)
VALUES (1, 318500, 2, 0.0);

INSERT INTO PRODUCT_SUPPLY
VALUES (294500, 12876);

INSERT INTO PRODUCT_SUPPLY
VALUES (2945, 12876000);

INSERT INTO LOCATION (location_id, postal_code, street_address)
VALUES (94, 10, '306 116 SW');

INSERT INTO WAREHOUSE(warehouse_id, location_id)
VALUES (120,  100);

INSERT INTO INVENTORY (warehouse_id, product_id, quantity)
VALUES (120, 2945, 200);

INSERT INTO INVENTORY (warehouse_id, product_id, quantity)
VALUES (113, 1, 200);

INSERT INTO STORE(store_id, store_name, store_location)
VALUES (8054, 'Alpha Sports, Churchill Centre', 100);


# --- NOT NULL (36)
INSERT INTO CUSTOMER(first_name, last_name, mobile_number, email_id, address, city, state, country, postal_code) 
VALUES(NULL,'Valenzuela',2198923452,'violet.valenzuela@msn.com','8668 Piper Street ','Plattsburgh','ON', 'Canada',129021);

INSERT INTO CUSTOMER(first_name, last_name, mobile_number, email_id, address, city, state, country, postal_code) 
VALUES('Violet',NULL,2198923452,'violet.valenzuela@msn.com','8668 Piper Street ','Plattsburgh','ON', 'Canada',129021);

INSERT INTO CUSTOMER(first_name, last_name, mobile_number, email_id, address, city, state, country, postal_code) 
VALUES('Violet','Valenzuela',2198923452,NULL,'8668 Piper Street ','Plattsburgh','ON', 'Canada',129021);

INSERT INTO ORDERS(customer_id,order_date, shipping_date, payment_status, payment_date, transaction_id) 
VALUES(NULL, '2022-07-25', '2022-07-28', 'APPROVED','2022-07-26', 79314);

INSERT INTO ORDERS(customer_id,order_date, shipping_date, payment_status, payment_date, transaction_id) 
VALUES(2, '2022-07-25', '2022-07-28', 'APPROVED','2022-07-26', NULL);

INSERT INTO CATEGORY( category_id, category_name)
VALUES(NULL,'ACTIVEWEAR');

INSERT INTO PRODUCT(product_id, product_name, category_id, product_price, product_brand, product_subcategory,
quantity_in_stock, product_description, product_size, product_color)
VALUES(NULL, 'PANTS Under Armour', 5425, 76.25, 'Under Armour', 'Pants', 83, 'sweatpants', 'Large', 'Black');

INSERT INTO PRODUCT(product_id, product_name, category_id, product_price, product_brand, product_subcategory,
quantity_in_stock, product_description, product_size, product_color)
VALUES(6581, NULL, 5425, 76.25, 'Under Armour', 'Pants', 83, 'sweatpants', 'Large', 'Black');

INSERT INTO PRODUCT(product_id, product_name, category_id, product_price, product_brand, product_subcategory,
quantity_in_stock, product_description, product_size, product_color)
VALUES(6581, 'PANTS Under Armour', NULL, 76.25, 'Under Armour', 'Pants', 83, 'sweatpants', 'Large', 'Black');

INSERT INTO PRODUCT(product_id, product_name, category_id, product_price, product_brand, product_subcategory,
quantity_in_stock, product_description, product_size, product_color)
VALUES(6581, 'PANTS Under Armour', 5425, NULL, 'Under Armour', 'Pants', 83, 'sweatpants', 'Large', 'Black');

INSERT INTO ORDER_DETAIL (order_id, product_id, quantity, discount)
VALUES (NULL, 3185, 2, 0.0);

INSERT INTO ORDER_DETAIL (order_id, product_id, quantity, discount)
VALUES (1, NULL, 2, 0.0);

INSERT INTO SUPPLIER(supplier_id, supplier_name, supplier_contact)
VALUES(NULL, 'Mega Footwear', 6472674509);

INSERT INTO SUPPLIER(supplier_id, supplier_name, supplier_contact)
VALUES(65423, NULL, 6472674509);

INSERT INTO SUPPLIER(supplier_id, supplier_name, supplier_contact)
VALUES(65423, 'Mega Footwear', NULL);

INSERT INTO PRODUCT_SUPPLY
VALUES (NULL, 12876);

INSERT INTO PRODUCT_SUPPLY
VALUES (2945, NULL);

INSERT INTO ZIP (postal_code, city, state_province) 
VALUES (NULL, 'Yuba City', 'AB');

INSERT INTO ZIP (postal_code, city, state_province) 
VALUES (959913, NULL, 'AB');

INSERT INTO ZIP (postal_code, city, state_province) 
VALUES (959913, 'Yuba City', NULL);

INSERT INTO LOCATION (location_id, postal_code, street_address)
VALUES (NULL, 105832, '306 116 SW');

INSERT INTO LOCATION (location_id, postal_code, street_address)
VALUES (94, NULL, '306 116 SW');

INSERT INTO WAREHOUSE(warehouse_id, location_id)
VALUES (NULL,  77);

INSERT INTO WAREHOUSE(warehouse_id, location_id)
VALUES (113,  NULL);

INSERT INTO INVENTORY (warehouse_id, product_id, quantity)
VALUES (NULL, 2945, 200);

INSERT INTO INVENTORY (warehouse_id, product_id, quantity)
VALUES (113, NULL, 200);

INSERT INTO INVENTORY (warehouse_id, product_id, quantity)
VALUES (113, 2945, NULL);

INSERT INTO DEPARTMENT(dept_id, department_name)
VALUES (NULL, 'Administrative');

INSERT INTO STORE(store_id, store_name, store_location)
VALUES (NULL, 'Alpha Sports, Churchill Centre', 78);

INSERT INTO EMPLOYEE
VALUES (NULL, 'Danny', 'Carter', 'carter78@gmail.com', 6478672568, '1990-11-23', 7556523020, '89 William Ave', 'M',
52632, '2018-09-12', 'Full time', 2310, 'Store Manager',  8049, NULL);

INSERT INTO EMPLOYEE
VALUES (87838, NULL, 'Mason', 'andrumason@gmail.com', 9149124064, '1992-01-16', 8900014239, '8081 Dundas Street East','F',
62000, '2019-01-12', 'Full time', 2313, 'Lead Sales',  8050, 87834); 

INSERT INTO EMPLOYEE
VALUES (87838, 'Andru', NULL, 'andrumason@gmail.com', 9149124064, '1992-01-16', 8900014239, '8081 Dundas Street East','F',
62000, '2019-01-12', 'Full time', 2313, 'Lead Sales',  8050, 87834);

INSERT INTO EMPLOYEE
VALUES (87838, 'Andru', 'Mason',NULL, 9149124064, '1992-01-16', 8900014239, '8081 Dundas Street East','F',
62000, '2019-01-12', 'Full time', 2313, 'Lead Sales',  8050, 87834);

INSERT INTO EMPLOYEE
VALUES (87838, 'Andru', 'Mason', 'andrumason@gmail.com', 9149124064, '1992-01-16', 8900014239, '8081 Dundas Street East','F',
62000, NULL, 'Full time', 2313, 'Lead Sales',  8050, 87834);

INSERT INTO LOCATION_DEPARTMENT(location_id, department_id, department_manager)
VALUES (NULL, 2310, 87821);

INSERT INTO LOCATION_DEPARTMENT(location_id, department_id, department_manager)
VALUES (78, NULL, 87821);


# --- DEFAULT (1)
INSERT INTO PRODUCT(product_id, product_name,category_id, product_brand, product_subcategory,quantity_in_stock, 
	product_description, product_size, product_color)
VALUES(1940,'Batminton Racket', 3245,  'Yonex', 'Rackets', 100, 'Shuttle Rackets', 'Universal', 'Green');

SELECT product_id, product_name, product_price FROM PRODUCT WHERE product_id = 1940;


# --- CHECK (7)
INSERT INTO CUSTOMER(first_name, last_name, mobile_number, email_id, address, city, state, country, postal_code) 
VALUES('Sheila','Francis',56,'fF@gmail.com','Apple street Park','Ottawa','ON', 'Canada',197255);

INSERT INTO CUSTOMER(first_name, last_name, mobile_number, email_id, address, city, state, country, postal_code) 
VALUES('Sheila','Francis',6473456754,'fF@gmail.com','Apple street Park','Ottawa','ON', 'Canada',12);

INSERT INTO ORDER_DETAIL (order_id, product_id, quantity, discount)
VALUES (11, 3185, 2, -67);

INSERT INTO SUPPLIER(supplier_id, supplier_name, supplier_contact)
VALUES(65493, 'Mega Footwear', 78);

INSERT INTO EMPLOYEE
VALUES (87871, 'Martin', 'King', 'martking45@gmail.com', 90, '1990-01-16', 4105652335, '132 Shephard Avenue','M',
40000, '2022-09-12', 'Full time', 2315, 'Business Associate',  8049, 87824);

INSERT INTO EMPLOYEE
VALUES (87871, 'Martin', 'King', 'martking45@gmail.com', 8976543456, '1990-01-16', 4105652335, '132 Shephard Avenue','O',
40000, '2022-09-12', 'Full time', 2315, 'Business Associate',  8049, 87824);

INSERT INTO EMPLOYEE
VALUES (87871, 'Martin', 'King', 'martking45@gmail.com', 8976543456, '1990-01-16', 4105, '132 Shephard Avenue','M',
40000, '2022-09-12', 'Full time', 2315, 'Business Associate',  8049, 87824);


# -------------------------------- COMPLEX QUERIES --------------------------------


# 1) Display All information of employee who are below the age 30 and earning higher than their managers

		SELECT * from employee 
		WHERE salary > (select salary from employee where ISNULL(manager_id) AND store_id="8049") AND year(curdate())-year(birth_date) < 30 ;

# 2) Find employee id, name and salary of all employees whose salary is greater than the Average Salary

		SELECT employee_id as "Employee Id",
		CONCAT(first_name," ", last_name) as "Employee Name", salary from employee 
		WHERE salary > (select AVG(salary) from employee);

# 3) Find the store which has the maximum no of employees working for it

		SELECT TABLE1.store_id AS "Store Id",store_name AS "Store Name", count as "Number of Employees" FROM STORE s
		JOIN 
		(select count(employee_id) as count, store_id from employee group by store_id order by count desc limit 1) TABLE1
		ON s.store_id=TABLE1.store_id;

# 4) Show All Customer_name, customer_id, email_address, and order_details whose payment failed/not approved

		SELECT  o.order_id,CONCAT(c.first_name, " ", c.last_name) AS "CUSTOMER NAME",
		c.email_id, o.order_date, o.payment_status
		from customer c join orders o
		WHERE c.customer_id = o.customer_id AND o.payment_status="NOT APPROVED";

# 5) Return all the orders placed by Sarthak Bhaijaan 

		SELECT o.order_id,CONCAT(c.first_name, " ", c.last_name) AS "CUSTOMER NAME",
		c.email_id, o.order_date, o.payment_status
		from customer c join orders o
		WHERE c.customer_id = o.customer_id AND CONCAT(c.first_name, " ", c.last_name)="Sarthak Bhaijaan";

# 6) Find the department_manager of respective department order by their department names

		SELECT  d.dept_id as "Department Id", d.department_name as "Department Name",CONCAT(e.first_name," ", e.last_name) AS "Department Manager" 
		from employee e, department d, location_department ld
		WHERE e.employee_id=ld.department_manager AND d.dept_id=ld.department_id
		ORDER BY d.department_name; 

# 7) How many products of Category JACKETS are there in inventory with their brand names and their size

		SELECT TABLE1.product_name AS "PRODUCT NAME", TABLE1.product_brand AS "PRODUCT BRAND",
		TABLE1.product_size AS "PRODUCT SIZE", i.quantity AS "QUANTITY"
		FROM inventory i
		JOIN
		(select * from product where category_id=(SELECT category_id FROM CATEGORY WHERE category_name="JACKETS")) TABLE1
		WHERE TABLE1.product_id=i.product_id;
		
# 8) Find the count of the product we got from each supplier

		SELECT s.supplier_id AS "Supplier Id", s.supplier_name AS "Supplier Name", 
		TABLE1.Count_P AS "Count of Products" 
		FROM
		SUPPLIER s JOIN
		(select COUNT(product_id) as "Count_P", supplier_id from product_supply GROUP BY supplier_id) TABLE1
		ON TABLE1.supplier_id=s.supplier_id
		ORDER BY TABLE1.Count_P DESC;
		
# 9) Display the list of Customer who had placed orders between 2022-06-01 AND 2022-12-06 
# 	 and arrange them according to customer_name

		SELECT DISTINCT(c.customer_id) AS "CUSTOMER ID", 
		CONCAT(c.first_name, ' ', c.last_name) AS "CUSTOMER NAME",
		c.email_id AS "EMAIL ADDRESS" 
		FROM CUSTOMER c JOIN ORDERS o
		ON ((o.customer_id = c.customer_id) AND (o.order_date  BETWEEN "2022-06-01" AND "2022-12-06"))
		ORDER BY CONCAT(c.first_name, ' ', c.last_name);

# 10) Display All the Warehouses based in Ontario Province with their address 

		SELECT LOCATION AS "LOCATION", ADDRESS, CITY, PROVINCE 
		FROM 
		(SELECT l.postal_code AS "ZIP CODE",l.location_id AS "LOCATION",
		l.street_address as "ADDRESS", z.city AS "CITY", z.state_province AS "PROVINCE" 
		FROM LOCATION l 
		JOIN ZIP z
		ON z.postal_code=l.postal_code AND (z.state_province="ON")) TABLE1
		JOIN 
		(SELECT w.location_id, w.warehouse_id AS "WAREHOUSE ID" FROM WAREHOUSE w ) TABLE2
		ON TABLE2.location_id=TABLE1.LOCATION;


# 11) Display orders which were ordered after 2020-09-01 and the total price of each order

		SELECT TABLE1.order_id AS "Order Id",o.order_date as "Order Date",SUM(TABLE1.product_price) as "Total Price" FROM ORDERS o
		JOIN
		(select od.order_id, p.product_name,p.product_brand, od.quantity,p.product_price
		from order_detail od join product p
		WHERE p.product_id = od.product_id 
		) TABLE1
		ON 
		o.order_id=TABLE1.order_id AND o.shipping_date>"2020-09-01" 
		GROUP BY TABLE1.order_id;
	

# 12) Show all the product names, product brand, product price and the quantity ordered by customer named Carrie Kidd

		SELECT  TABLE1.order_id AS "Order Id" ,CONCAT(first_name," ",last_name) AS "Customer Name", email_id as "Email Address",
		order_date as "Order Date", product_name AS "Product Name", product_brand AS "Product Brand",
		quantity AS "Quantity Ordered", product_price AS "Price"
		 FROM 
		(select o.order_id, c.first_name,c.last_name,
		c.email_id, o.order_date, o.payment_status
		from customer c join orders o
		WHERE c.customer_id = o.customer_id AND c.first_name="Carie" AND c.last_name="Kidd") TABLE1
		JOIN
		(select od.order_id, p.product_name,p.product_brand, od.quantity,p.product_price
		from order_detail od join product p
		WHERE p.product_id = od.product_id) TABLE2
		ON TABLE1.order_id=TABLE2.order_id;

# 13) Show all the product names, product brand, product price and the quantity ordered by all the customers after 2021-10-07

		SELECT  TABLE1.order_id AS "Order Id" ,CONCAT(first_name," ",last_name) AS "Customer Name", email_id as "Email Address",
		order_date as "Order Date", product_name AS "Product Name", product_brand AS "Product Brand",
		quantity AS "Quantity Ordered", product_price AS "Price"
		 FROM 
		(select o.order_id, c.first_name,c.last_name,
		c.email_id, o.order_date, o.payment_status
		from customer c join orders o
		WHERE c.customer_id = o.customer_id AND (o.order_date > "2021-10-07")) TABLE1
		JOIN
		(select od.order_id, p.product_name,p.product_brand, od.quantity,p.product_price
		from order_detail od join product p
		WHERE p.product_id = od.product_id) TABLE2
		ON TABLE1.order_id=TABLE2.order_id;


# 14) write a SQL query to find those employees whose salary matches the 
# highest salary of any of the departments. Return first name, last name and department ID with their department Name
# and arrange it according to the employee names.

		SELECT CONCAT(first_name,' ',last_name) AS "Employee Name", 
		SALARY AS "Salary", department_id AS "Department Id",
		department_name AS "Department Name"
		FROM  (select first_name, last_name, salary, department_id 
		FROM EMPLOYEE
		WHERE salary IN (SELECT MAX(salary) FROM EMPLOYEE GROUP BY department_id)) TABLE1
		JOIN DEPARTMENT d
		ON TABLE1.department_id=d.dept_id
		ORDER BY CONCAT(TABLE1.first_name,' ',TABLE1.last_name);

# 15) INVOICE GENERATION
		
       
		SELECT o.order_id AS "INVOICE ID",
		o.customer_id AS "CUSTOMER ID",
		TABLE1.CustomerName AS "CUSTOMER NAME",
		o.transaction_id AS "TRANSACTION ID",
		o.order_date AS "Date of Purchase",
		o.payment_status AS "Payment Status",
		o.payment_date AS "Payment Date",
		TABLE1.PNAME AS "ITEMS SOLD",
		TABLE1.Total_Payable AS "Total Amount Payable"
		from ORDERS o
		JOIN
		(select order_id, CONCAT(first_name," ", last_name) as "CustomerName" , COUNT(product_name) AS "PNAME",SUM(Total) as "Total_Payable"
		from INVOICE WHERE order_id=13) TABLE1
		On TABLE1.order_id = o.order_id;




---------------------------------------------- END OF SQL FILE ---------------------------------------------------
