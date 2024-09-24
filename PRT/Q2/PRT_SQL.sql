CREATE TABLE sales_data
(
    ORDERNUMBER varchar(20) PRIMARY KEY,
    QUANTITYORDERED int,
    PRICEEACH decimal(10,2),
    ORDERLINENUMBER int,
    SALES decimal(10,2),
    ORDERDATE date,
    DAYS_SINCE_LASTORDER int,
    STATUS varchar(20),
    PRODUCTLINE varchar(50),
    MSRP decimal(10,2),
    PRODUCTCODE varchar(20),
    CUSTOMERNAME varchar(255),
    PHONE varchar(20),
    ADDRESSLINE1 varchar(255),
    CITY varchar(50),
    POSTALCODE varchar(20),
    COUNTRY varchar(20),
    CONTACTLASTNAME varchar(50),
    CONTACTFIRSTNAME varchar(50),
    DEALSIZE varchar(20)
);

SELECT *
from sales_data limit
10

SELECT pg_typeof(orderdate) AS data_type
FROM sales_data;

-- a. Find out the total sales made by each DEALSIZE from the given data.
select DEALSIZE, sum(sales) as total_sales
from sales_data
GROUP by DEALSIZE

-- b. Delete the data which are having S10 in productcode also which check if country is USA and order quantity is less than 30.
SELECT count(*)
FROM sales_data
WHERE productcode
ilike '%S10%' AND
country = 'USA' AND
QUANTITYORDERED < 30

SELECT count(*)
from sales_data

BEGIN;
    DELETE FROM sales_data
WHERE productcode
    ilike '%S10%' AND
country = 'USA' AND
QUANTITYORDERED < 30

    SELECT COUNT(*) AS rows_to_be_deleted
    FROM sales_data
    WHERE productcode
    ilike '%S10%' AND
  country = 'USA' AND
  QUANTITYORDERED < 30;
END;

  