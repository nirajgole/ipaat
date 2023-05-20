-- create DATABASE CASE_STUDY_THREE

-- 1) Display the count of customer in each region who has done the transaction in year 2020

SELECT region_id, COUNT(*) no_of_customers

from customers c

    left join [transaction] t on c.customer_id=t.customer_id

where year(txn_date)=2020

group by region_id



-- 2) Display the maximum, minimum of transaction amount of each transaction type

SELECT TXN_TYPE, MAX(TXN_AMOUNT) AS MAX_AMT, MIN(TXN_AMOUNT) AS MIN_AMT

FROM [TRANSACTION]

GROUP BY TXN_TYPE

-- 3) Display customer id, region name and transaction amount where transaction type is deposit and

-- transaction amount > 2000.



SELECT C.customer_id, CC.region_name, T.txn_amount
FROM CUSTOMERS C

    LEFT JOIN [TRANSACTION] T ON C.CUSTOMER_ID=T.CUSTOMER_ID

    LEFT JOIN Continent CC ON C.region_id=CC.region_id

WHERE TXN_TYPE='DEPOSIT' AND TXN_AMOUNT>2000



-- 4) Find duplicate records in a customer table.

SELECT customer_id, COUNT(*) AS NO_OF_DUPLICATE_RECORDS

FROM Customers

GROUP BY customer_id

HAVING COUNT(*) >1

ORDER BY customer_id

-- 5) Display the detail of customer id, region name, transaction type and transaction amount for the

-- minimum transaction amount in deposit.

SELECT C.customer_id, CC.region_name, T.txn_type, T.txn_amount
FROM CUSTOMERS C

    LEFT JOIN [TRANSACTION] T ON C.CUSTOMER_ID=T.CUSTOMER_ID

    LEFT JOIN Continent CC ON C.region_id=CC.region_id

WHERE TXN_TYPE='DEPOSIT' AND TXN_AMOUNT=(select min(txn_amount)
    from [Transaction]
    where txn_type='deposit')

-- 6) Create a stored procedure to display details of customer and transaction table where transaction

-- date is greater than Jun 2020.



CREATE PROCEDURE sp_display_details

AS

BEGIN

    SELECT *
    FROM Customers C

        LEFT JOIN [Transaction] T ON C.customer_id=T.customer_id

    WHERE txn_date >= '2020-07-01'

END

GO



-- drop PROCEDURE dbo.sp_display_details

EXEC dbo.sp_display_details;

-- 7) Create a stored procedure to insert a record in the continent table.

CREATE PROCEDURE sp_insert_continet

    @regionId int,

    @regionName VARCHAR(100)

AS

BEGIN

    INSERT INTO Continent
    VALUES(@regionId, @regionName);

END

GO

EXEC dbo.sp_insert_continet 100,'Citadel'

-- 8) Create a stored procedure to display the details of transactions that happened on a specific day.

CREATE PROCEDURE sp_get_txn_details_on_day(

    @txnDate DATETIME2

)

AS

BEGIN

    SELECT *
    FROM [Transaction]
    WHERE txn_date=@txnDate

END

GO

EXEC sp_get_txn_details_on_day '2020-01-13'

-- 9) Create a user defined function to add 10% of the transaction amount in a table.



CREATE FUNCTION udf_update_txn_amount()

returns TABLE

AS

return(    

        SELECT txn_amount, txn_amount*0.10 as '10% of txn_amt'
FROM [Transaction]

    );



-- CREATE FUNCTION udf_update_txn_amount()

-- returns int

-- AS

-- BEGIN

--     UPDATE [Transaction]

--     SET [txn_amount] = txn_amount*1.10

-- return 0

-- END

select *
from udf_update_txn_amount()

-- 10) Create a user defined function to find the total transaction amount for a given transaction type.

CREATE FUNCTION udf_get_total_txn_amt(@TXN_TYPE VARCHAR(50))

RETURNS TABLE

AS

RETURN (

    SELECT txn_type, SUM(txn_amount) AS TOTAL_TXN_AMT

FROM [Transaction]

WHERE txn_type=@TXN_TYPE

GROUP BY txn_type

    );

-- DROP FUNCTION DBO.udf_get_total_txn_amt

SELECT *
FROM udf_get_total_txn_amt('DEPOSIT')



-- 11) Create a table value function which comprises of the following columns customer_id,

-- region_id ,txn_date , txn_type , txn_amount which will retrieve data from the above table.

SELECT C.customer_id, CT.region_id, T.txn_date, T.txn_type, T.txn_amount

FROM Customers C

    LEFT JOIN [Transaction] T ON C.customer_id=T.customer_id

    LEFT JOIN Continent CT ON C.region_id=CT.region_id



-- 12) Create a try catch block to print a region id and region name in a single column.

BEGIN TRY

SELECT region_id + ' ' + region_name
FROM Continent

END TRY

BEGIN CATCH

 PRINT ERROR_MESSAGE();

END CATCH

GO



-- 13) Create a try catch block to insert a value in the continent table.

BEGIN TRY

INSERT INTO Continent
    (region_id,region_name)
VALUES(8, 'GLOBEM')

END TRY

BEGIN CATCH

PRINT ERROR_MESSAGE()

END CATCH

-- 14) Create a trigger to prevent deleting a table in a database.



CREATE OR ALTER TRIGGER tr_preventTableDelete

ON dbo.Continent

FOR DELETE

AS

BEGIN

    RAISERROR('You cannot delete record from this table.',16,1);

END

GO



ALTER TABLE [dbo].[Continent] ENABLE TRIGGER [tr_preventTableDelete]

GO



DELETE FROM Continent WHERE region_id=1

-- trigger for drop table 



CREATE TRIGGER tr_preventTableDrop

ON DATABASE

FOR DROP_TABLE

AS

BEGIN

    PRINT 'You must disable Trigger "drop_safe" to drop table!'

    ROLLBACK TRANSACTION

END

GO

ENABLE TRIGGER tr_preventTableDrop

ON DATABASE

GO

DROP TABLE Continent

-- 15) Create a trigger to audit the data in a table.


-- 16) Create a trigger to prevent login of the same user id in multiple pages.



-- 17) Display top n customers on the basis of transaction type.



CREATE PROCEDURE sp_display_customers(

    @tx_type VARCHAR(50),

    @no_of_cust int

)

AS

BEGIN

    SELECT TOP(@no_of_cust)
        *
    FROM [Transaction]
    WHERE txn_type=@tx_type

END

GO



EXEC sp_display_customers 'deposit', 10

-- 18) Create a pivot table to display the total purchase, withdrawal and deposit for all the customers.

SELECT *
FROM (SELECT

        txn_type, txn_amount

    FROM Customers c left join [Transaction] t on c.customer_id=t.customer_id) t

PIVOT

(

    SUM(txn_amount)

    FOR txn_type IN

    (

        [purchase],

        [deposit],

        [withdrawal]

    )

) as pivot_table