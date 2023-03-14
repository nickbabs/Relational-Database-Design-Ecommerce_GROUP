-- ----------------------------------------------------------
-- File          : NAME.sql 
-- Desc          : INFO605 Final Project
-- Author        : Nawaf Alhumaid, Nick Babcock, Samyak Jain, Mithila Chintala,  Ibrahim Alabi   
-- Create Date   : 4 Mar 2021 
-- Modifications :    
-- ----------------------------------------------------------    

-- View existing tables 
select * from tab ;

-- ############################################################
-- ############################################################

-- Drop the table if is already existed  

DELETE FROM Payment;
DELETE FROM Invoice;
DELETE FROM Product_In_Category;
DELETE FROM Product_In_Orders;
DELETE FROM Orders;
DELETE FROM Product;
DELETE FROM Seller;
DELETE FROM Category;
DELETE FROM Customer;
DELETE FROM Delivery_Company;


DROP TABLE Payment;
DROP TABLE Invoice;
DROP TABLE Product_In_Category;
DROP TABLE Product_In_Orders;
DROP TABLE Orders;
DROP TABLE Product;
DROP TABLE Seller;
DROP TABLE Category;
DROP TABLE Customer;
DROP TABLE Delivery_Company;


select * from tab ;

-- ############################################################
-- ############################################################

-- Database Implementation “ DDL” 

-- Create Seller table 
CREATE TABLE Seller( 
	sellerId CHAR(12) CONSTRAINT seller_pk PRIMARY KEY, 
	sellerName VARCHAR(25), 
	phoneNumber CHAR(10), 
	email VARCHAR(25) CONSTRAINT seller_nn_email NOT NULL 
); 

-- Create Category table 
CREATE TABLE Category( 
	categoryId CHAR(12) CONSTRAINT category_pk PRIMARY KEY, 
	categoryName VARCHAR(12) CONSTRAINT category_nn_categoryname NOT NULL, 
	categoryDescription VARCHAR(50)  
); 

-- Create Customer table 
CREATE TABLE Customer( 
	customerId CHAR(12) CONSTRAINT customer_pk PRIMARY KEY, 
	name VARCHAR(25), 
	phoneNumber CHAR(10), 
	addressHouseNumber VARCHAR(12), 
	addressStreet VARCHAR(25), 
	addressZip NUMBER, 
	addressCity VARCHAR(12), 
	email VARCHAR(25) CONSTRAINT customer_nn_email NOT NULL, 
	dateOfBirth DATE 
); 

-- Create Delivery Company table 
CREATE TABLE Delivery_Company( 
	companyId CHAR(12) CONSTRAINT deliverycompany_pk PRIMARY KEY, 
	companyName VARCHAR(25) CONSTRAINT deliverycompany_nn_companyname NOT NULL, 
	phoneNumber NUMBER 
); 

-- Create Product table 
CREATE TABLE Product( 
	productId CHAR(12) CONSTRAINT product_pk PRIMARY KEY, 
	productName VARCHAR(25) CONSTRAINT product_nn_productname NOT NULL, 
	description VARCHAR(50), 
	stock NUMBER, 
	price NUMBER CONSTRAINT product_nn_price NOT NULL, 
	sellerId CHAR(12) CONSTRAINT product_fk_sellerid REFERENCES Seller(sellerId)  ON DELETE SET NULL
); 

-- Create Product In Category table 
CREATE TABLE Product_In_Category( 
	productId CHAR(12) CONSTRAINT pic_fk_productid REFERENCES Product(productId)  ON DELETE CASCADE,
	categoryId CHAR(12) CONSTRAINT pic_fk_categoryid REFERENCES Category(categoryId)  ON DELETE CASCADE,
	CONSTRAINT pic_pk PRIMARY KEY (productId, categoryId)  
);  

-- Create Orders table 
CREATE TABLE Orders(
	orderId CHAR(12) CONSTRAINT order_pk PRIMARY KEY, 
	orderDate DATE CONSTRAINT order_nn_orderdate NOT NULL, 
	orderStatus VARCHAR(3) CONSTRAINT order_nn_orderstatus NOT NULL, 
	total NUMBER CONSTRAINT order_nn_total NOT NULL, 
	customerId CHAR(12) CONSTRAINT order_fk_customerid REFERENCES Customer(customerId)  ON DELETE SET NULL, 
	companyId CHAR(12) CONSTRAINT order_fk_companyid REFERENCES Delivery_Company(companyId)   ON DELETE SET NULL
); 

-- Create Product In Orders table 
CREATE TABLE Product_In_Orders( 
	productId CHAR(12) 		CONSTRAINT pio_fk_productid REFERENCES Product(productId)  ON DELETE CASCADE, 
	orderId CHAR(12) 		CONSTRAINT pio_fk_categoryid REFERENCES Orders(orderId)  ON DELETE CASCADE, 
							CONSTRAINT pio_pk PRIMARY KEY (productId, orderId), 
	quantity NUMBER 		CONSTRAINT pio_nn_quantity NOT NULL, 
	soldItemPrice NUMBER 	CONSTRAINT pio_nn_solditemprice NOT NULL 
); 

-- Create Invoice table 
CREATE TABLE Invoice( 
	invoiceNo CHAR(12) CONSTRAINT invoice_pk PRIMARY KEY, 
	subTotalBeforeTax NUMBER, 
	Tax NUMBER, 
	subTotalAfterTax NUMBER, 
	discount NUMBER, 
	amountDue NUMBER, 
	billedTo VARCHAR(25), 
	dateOfIssue DATE, 
	orderId CHAR(12) CONSTRAINT invoice_fk_orderid REFERENCES Orders(orderId)  ON DELETE SET NULL
); 

-- Create Payment table 
CREATE TABLE Payment( 
	paymentId CHAR(12) CONSTRAINT payment_pk PRIMARY KEY, 
	amount NUMBER, 
	payment_type VARCHAR(12), 
	status VARCHAR(12), 
	payment_date DATE, 
	customerId CHAR(12) CONSTRAINT customerid_fk REFERENCES Customer(customerId)  ON DELETE SET NULL, 
	invoiceNo CHAR(12) CONSTRAINT invoiceno_fk REFERENCES Invoice(invoiceNo)  ON DELETE SET NULL
); 

-- ############################################################
-- ############################################################

-- View existing tables 
select * from tab ;

-- ############################################################
-- ############################################################


-- Data Inserts “DML” 

 
-- Populate data for Seller table  
INSERT INTO Seller(sellerId, sellerName, phoneNumber, email) VALUES('123456789', 'Robert',    	'10000001', 'robert@gmail.com'); 
INSERT INTO Seller(sellerId, sellerName, phoneNumber, email) VALUES('234567890', 'Pattinson', 	'10000002', 'pattinson@gmail.com'); 
INSERT INTO Seller(sellerId, sellerName, phoneNumber, email) VALUES('345678901', 'Paul', 		'10000003', 'paul@gmail.com'); 
INSERT INTO Seller(sellerId, sellerName, phoneNumber, email) VALUES('456789012', 'Dano', 		'10000004', 'dano@gmail.com'); 
INSERT INTO Seller(sellerId, sellerName, phoneNumber, email) VALUES('567890123', 'Zoe', 		'10000005', 'zoe@gmail.com'); 

SELECT * FROM Seller;

-- Populate data for Category table 
INSERT INTO Category(categoryId, categoryName, categoryDescription) VALUES('1', 'Dry Skincare', 'For Dry Skin'); 
INSERT INTO Category(categoryId, categoryName, categoryDescription) VALUES('2', 'Haircare', 'For Silky Hair'); 
INSERT INTO Category(categoryId, categoryName, categoryDescription) VALUES('3', 'Toys', 'Children’s toys'); 
INSERT INTO Category(categoryId, categoryName, categoryDescription) VALUES('4', 'Skincare', 'For Smooth Skin'); 
INSERT INTO Category(categoryId, categoryName, categoryDescription) VALUES('5', 'Tan Skincare', 'For Tan Skin'); 

SELECT * FROM Category;

-- Populate data for Customer table 
INSERT INTO Customer(customerId, name, phoneNumber,addressHouseNumber, addressStreet, addressZip, addressCity, email, dateOfBirth) 
			VALUES('12345678', 'Jack', 		'1234567890', '45', '34th Chestnut', 10904, 'Philadelphia', 'jack@gmail', '09-JUN-1997'); 
INSERT INTO Customer(customerId, name, phoneNumber,addressHouseNumber, addressStreet, addressZip, addressCity, email, dateOfBirth) 
			VALUES('12345677', 'Colin', 	'1234566666', '24', '33rd Walnut', 10945,'Philadelphia','colin@gmail', '01-JUL-1969'); 
INSERT INTO Customer(customerId, name, phoneNumber,addressHouseNumber, addressStreet, addressZip, addressCity, email, dateOfBirth) 
			VALUES('12345688', 'Jaffrey', 	'1234577777', '63', '32nd Chestnut', 10974,'Philadelphia','jaffrey@gmail', '22-DEC-1988'); 
INSERT INTO Customer(customerId, name, phoneNumber,addressHouseNumber, addressStreet, addressZip, addressCity, email, dateOfBirth) 
			VALUES('12345666', 'Barry', 	'1234588888', '73', '31st Spruce', 10910,'NYC','barry@gmail', '30-MAY-1999'); 
INSERT INTO Customer(customerId, name, phoneNumber,addressHouseNumber, addressStreet, addressZip, addressCity, email, dateOfBirth) 
			VALUES('12345555', 'Andy', 		'1234599999', '987', '30th Walnut', 10908,'Philadelphia','andy@gmail', '15-OCT-1981'); 

SELECT * FROM Customer;			

-- Populate data for Delivery Company table 
INSERT INTO Delivery_Company(companyId, companyName, phoneNumber) VALUES('1212121212', 'Neutrogena', 		'1111111111'); 
INSERT INTO Delivery_Company(companyId, companyName, phoneNumber) VALUES('1313131313', 'Panteen', 		'2222222222'); 
INSERT INTO Delivery_Company(companyId, companyName, phoneNumber) VALUES('1414141414', 'DHL', 			'3333333333'); 
INSERT INTO Delivery_Company(companyId, companyName, phoneNumber) VALUES('1515151515', 'BathandBody', 	'4444444444'); 
INSERT INTO Delivery_Company(companyId, companyName, phoneNumber) VALUES('1616161616', 'The Body Shop', 	'5555555555'); 

SELECT * FROM Delivery_Company;	

-- Populate data for Product table 
INSERT INTO Product(productId, productName, description, stock, price, sellerId) VALUES('1122334455', 'Bodywash', 'Glowing Skin', 20, 7.99, 			'123456789'); 
INSERT INTO Product(productId, productName, description, stock, price, sellerId) VALUES('2233445566', 'Shampoo', 'Anti Hairfall', 30, 8.99, 			'234567890'); 
INSERT INTO Product(productId, productName, description, stock, price, sellerId) VALUES('3344556677', 'Conditioner', 'Shining Hair', 40, 8.99, 		'345678901'); 
INSERT INTO Product(productId, productName, description, stock, price, sellerId) VALUES('4455667788', 'Moisturizer', 'Soft and Healthy', 50, 5.99, 	'456789012'); 
INSERT INTO Product(productId, productName, description, stock, price, sellerId) VALUES('5566778899', 'Sunscreen', 'Damage Control', 60, 4.99, 		'567890123'); 

SELECT * FROM Product;	

-- Populate data for Product In Category table 
INSERT INTO Product_In_Category(productId, categoryId) VALUES('1122334455', '1');  
INSERT INTO Product_In_Category(productId, categoryId) VALUES('2233445566', '2'); 
INSERT INTO Product_In_Category(productId, categoryId) VALUES('3344556677', '3'); 
INSERT INTO Product_In_Category(productId, categoryId) VALUES('4455667788', '4'); 
INSERT INTO Product_In_Category(productId, categoryId) VALUES('5566778899', '5'); 

SELECT * FROM Product_In_Category;	

-- Populate data for Orders table 
INSERT INTO Orders(orderId, orderDate, orderStatus, total, customerId, companyId) VALUES('1000000001', '01-JAN-2000', 'D', 21.99, 	'12345678', '1212121212'); 
INSERT INTO Orders(orderId, orderDate, orderStatus, total, customerId, companyId) VALUES('2000000002', '02-FEB-2001', 'OFD', 19.99, '12345677', '1313131313'); 
INSERT INTO Orders(orderId, orderDate, orderStatus, total, customerId, companyId) VALUES('3000000003', '03-MAR-2002', 'D', 9.99, 	'12345688', '1414141414'); 
INSERT INTO Orders(orderId, orderDate, orderStatus, total, customerId, companyId) VALUES('4000000004', '01-APR-2003', 'P', 13.99, 	'12345666', '1515151515'); 
INSERT INTO Orders(orderId, orderDate, orderStatus, total, customerId, companyId) VALUES('5000000005', '01-MAY-2004', 'C', 11.99, 	'12345555', '1616161616'); 

SELECT * FROM Orders;	

-- Populate data for Product In Orders table 
INSERT INTO Product_In_Orders(productId, orderId, quantity, soldItemPrice) VALUES('1122334455', '1000000001', 2, 7.99); 
INSERT INTO Product_In_Orders(productId, orderId, quantity, soldItemPrice) VALUES('2233445566', '2000000002', 3, 8.99); 
INSERT INTO Product_In_Orders(productId, orderId, quantity, soldItemPrice) VALUES('3344556677', '3000000003', 4, 8.99); 
INSERT INTO Product_In_Orders(productId, orderId, quantity, soldItemPrice) VALUES('4455667788', '4000000004', 5, 5.99); 
INSERT INTO Product_In_Orders(productId, orderId, quantity, soldItemPrice) VALUES('5566778899', '5000000005', 6, 4.99); 

SELECT * FROM Product_In_Orders;	

-- Populate data for Invoice table 
INSERT INTO Invoice(invoiceNo, subTotalBeforeTax, Tax, SubTotalAfterTax, discount, amountDue, billedTo, dateOfIssue, orderId) 
	VALUES('1000000000', 9.99, 2.99, 12.98, 1, 11.98, 'Jack', '02-JAN-2021', 		'1000000001');  
INSERT INTO Invoice(invoiceNo, subTotalBeforeTax, Tax, SubTotalAfterTax, discount, amountDue, billedTo, dateOfIssue, orderId) 
	VALUES('2000000000', 19.99, 2.99, 22.98, 1, 21.98, 'Colin', '03-JUN-2021', 	'2000000002');  
INSERT INTO Invoice(invoiceNo, subTotalBeforeTax, Tax, SubTotalAfterTax, discount, amountDue, billedTo, dateOfIssue, orderId) 
	VALUES('3000000000', 29.99, 2.99, 32.98, 1, 31.98, 'Jaffrey', '04-APR-2021', 	'3000000003'); 
INSERT INTO Invoice(invoiceNo, subTotalBeforeTax, Tax, SubTotalAfterTax, discount, amountDue, billedTo, dateOfIssue, orderId) 
	VALUES('4000000000', 39.99, 2.99, 42.98, 1, 41.98, 'Barry', '05-SEP-2021',	'4000000004'); 
INSERT INTO Invoice(invoiceNo, subTotalBeforeTax, Tax, SubTotalAfterTax, discount, amountDue, billedTo, dateOfIssue, orderId) VALUES('5000000000', 49.99, 2.99, 52.98, 1, 51.98, 'Andy', '06-OCT-2021',		'5000000005'); 

SELECT * FROM Invoice;	

-- Populate data for Payment table 
INSERT INTO Payment(paymentId, amount, payment_type, status, payment_date, customerId, invoiceNo) VALUES('1000000001', 10.99, 'Cash', 'Paid', '09-DEC-2021', 	'12345678', '1000000000'); 
INSERT INTO Payment(paymentId, amount, payment_type, status, payment_date, customerId, invoiceNo) VALUES('2000000002', 20.99, 'Debit', 'Paid', '08-NOV-2021', 	'12345677', '2000000000'); 
INSERT INTO Payment(paymentId, amount, payment_type, status, payment_date, customerId, invoiceNo) VALUES('3000000003', 30.99, 'Credit', 'Paid', '07-OCT-2021', 	'12345688', '3000000000'); 
INSERT INTO Payment(paymentId, amount, payment_type, status, payment_date, customerId, invoiceNo) VALUES('4000000004', 40.99, 'Cash', 'Paid', '06-SEP-2021', 	'12345666', '4000000000'); 
INSERT INTO Payment(paymentId, amount, payment_type, status, payment_date, customerId, invoiceNo) VALUES('5000000005', 50.99, 'Cash', 'Paid', '05-AUG-2021', 	'12345555', '5000000000');

SELECT * FROM Payment;	


COMMIT;


-- ############################################################
-- ############################################################

-- SQL Queries


-- Display setting   
SET pagesize 100;    
SET linesize 160; 
SET FEEDBACK ON;


-- Display all data of each table

SELECT * FROM Seller;
SELECT * FROM Category;
SELECT * FROM Customer;	
SELECT * FROM Delivery_Company;	
SELECT * FROM Product;	
SELECT * FROM Product_In_Category;	
SELECT * FROM Orders;
SELECT * FROM Product_In_Orders;
SELECT * FROM Invoice;	
SELECT * FROM Payment;


# How many orders do we have?
SELECT COUNT(*) AS "Number of Orders" FROM Orders;
# How many Products do we have?
SELECT COUNT(*) AS "Number of Products" FROM Product;
# How many Customers do we have?
SELECT COUNT(*) AS "Number of Customers" FROM Customer;
# What is the Products that were ordered for the highest price?
SELECT productName,price FROM Product Order by price desc;	

# Show me the Payments greater than $20 
SELECT * FROM Payment WHERE amount > 20;

# Show me the Customers born after 15-OCT-1981
SELECT * FROM Customer WHERE dateOfBirth > '15-OCT-1981';

# Show me the seller with a name like t?
select * from Seller where sellerName like '%t%';

# Show me the customer we have in Philadelphia?
select * from Customer where addressCity = 'Philadelphia';

# Show me Shampoo or Conditioner Products?
SELECT * FROM Product WHERE productName In ('Shampoo', 'Conditioner');

# Show me Cash Payments?
SELECT * FROM Payment WHERE payment_type = 'Cash';

# Total sales per Category?
select 
	Category.categoryName, 
	sum(Product_In_Orders.soldItemPrice) AS "Total sales" 
from Product_In_Orders
join Product_In_Category on Product_In_Category.productId = Product_In_Orders.productId
join Category on Category.categoryId = Product_In_Category.categoryId
group by Category.categoryName ;

# Customers orders?
SELECT
	Customer.customerId, 
	Customer.name, 
	count(Orders.orderId)  AS "Numer of orders"
from Customer 
left join Orders on Orders.customerId = Customer.customerId 
group by Customer.customerId, Customer.name ;

# Total sales per seller?
select 
	Seller.sellerName,
	sum(Product_In_Orders.soldItemPrice) AS "Total sales" 
from Seller 
join Product on Seller.sellerId = Product.sellerId
join Product_In_Orders on Product_In_Orders.productId = Product.productId
group by Seller.sellerName ;


# Number of products per Category
select 
	Category.categoryName, 
	count( Product_In_Category.productId) AS "Numer of products" 
from 
	Category 
left join Product_In_Category on Product_In_Category.categoryId = Category.categoryId
group by Category.categoryName ;


# Number of delivered orders per Delivery Company
SELECT 
	Delivery_Company.companyName,
	count(orders.orderId)  AS "Numer of delivered orders" 
from
	Delivery_Company
left join orders on orders.companyId = Delivery_Company.companyId and orders.orderStatus = 'D'
group by Delivery_Company.companyName ;

-- ############################################################
-- ############################################################

-- Data Manipulations 

select * from Seller WHERE sellerName = 'Robert';  
UPDATE Seller SET phoneNumber = '26781054', email = 'robert554@gmail.com' WHERE sellerName = 'Robert'; 
select * from Seller WHERE sellerName = 'Robert';  

select * from Category WHERE categoryId= '4';  
UPDATE Category SET categoryDescription= 'For all Skin' WHERE categoryId= '4'; 
select * from Category WHERE categoryId= '4';  

select * from Orders WHERE orderId= '5000000005';   
UPDATE Orders SET orderStatus= 'OFD' WHERE orderId= '5000000005'; 
select * from Orders WHERE orderId= '5000000005';   

select * from Product WHERE productName = 'Bodywash';
UPDATE Product SET price = 10.48 WHERE productName = 'Bodywash'; 
select * from Product WHERE productName = 'Bodywash';

select * from Delivery_Company WHERE companyName = 'DHL';
UPDATE Delivery_Company SET phoneNumber = '6666666666' WHERE companyName = 'DHL';
select * from Delivery_Company WHERE companyName = 'DHL';

select * from Payment;
DELETE FROM Payment WHERE paymentId = '1000000001'; 
select * from Payment;

select * from Customer;
DELETE FROM Customer WHERE name = 'Jack'; 
select * from Customer;

select * from Product;
DELETE FROM Product WHERE productName = 'Shampoo'; 
select * from Product;

select * from Orders;
DELETE FROM Orders WHERE orderDate = '02-FEB-2001'; 
select * from Orders;

select * from Delivery_Company;
DELETE FROM Delivery_Company WHERE companyName = 'DHL'; 
select * from Delivery_Company;

-- ############################################################
-- ############################################################
