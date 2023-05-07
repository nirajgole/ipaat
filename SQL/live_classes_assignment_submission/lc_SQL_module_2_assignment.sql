CREATE DATABASE LiveClassAssignment

USE LiveClassAssignment

-- 1.Create a customer table which comprises of these columns    customer_id ,  first_name ,  last_name ,
--  email ,  address ,  city , state , zip 
CREATE TABLE CUSTOMER
(
	CUSTOMER_ID INT ,
	FIRST_NAME VARCHAR(30) ,
	LAST_NAME VARCHAR(20),
	EMAIL VARCHAR(30),
	ADDRESS VARCHAR(30),
	CITY VARCHAR(20)  ,
	STATE VARCHAR(20) ,
	ZIP INT
)


-- 2.Insert 5 new records into the table
INSERT INTO CUSTOMER
VALUES(10, 'NEHA', 'SIGH', 'NEHA@GMAIL.COM', 'SHANTINAGAR', 'BANGALORE', 'KARNATAKA', 11),
	(20, 'SUNIL', 'KUMAR', 'SUNIL@GMAIL.COM', 'GANDHI NAGAR', 'BANGALORE', 'KARNATAKA', 12),
	(30, 'GAGANA', 'CHOWDHARY', 'GAGANA@GMAIL.COM', 'K R PURAM', 'SAN JOSE', 'KERALA', 13),
	(40, 'CHANDAN', 'GOWDA', 'CHANDAN@GMAIL.COM', 'VV NAGAR', 'SHIVA KASHI', 'TAMIL NADU', 14),
	(50, 'NASEEHA', 'SIGH', 'NASEEHA@GMAIL.COM', 'SHANTINAGAR', 'CHENNAI', 'TAMIL NADU', 15)


-- 3.Select only the  first_name  &  last_name  columns from the customer table
SELECT FIRST_NAME , LAST_NAME
FROM CUSTOMER

-- 4.Select those records where  first_name  starts with  G  and city is  San Jose 
SELECT *
FROM CUSTOMER
WHERE FIRST_NAME LIKE 'G%' AND CITY='SAN JOSE'