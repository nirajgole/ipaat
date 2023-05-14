-- Module 6 Stored Procedure in SQL

-- 1. Create a view named ‘customer_san_jose’ which comprises of only those customers who are from san jose
CREATE VIEW vw_customer_san_jose
AS
    SELECT *
    FROM CUSTOMER
    WHERE CITY='SAN JOSE'

-- 2. Inside a transaction, update the first name of the customer to Francis, where the last name is Jordan
--     a. Rollback the transaction
--     b. Set the first name of customer to Alex, where the last name is Jordan

BEGIN TRAN t1;
UPDATE customer
SET first_name = 'Gautham'
WHERE last_name = 'sigh';
ROLLBACK TRAN;
BEGIN TRAN t2;
UPDATE customer
SET first_name = 'Giri'
WHERE last_name = 'sigh';
COMMIT TRAN t2;

-- 3. Inside a try catch block, divide 100 with 0, print the default error message

BEGIN TRY

SELECT 100/0

END TRY
BEGIN CATCH

PRINT 'Error occurred:';
PRINT ERROR_MESSAGE();

END CATCH
