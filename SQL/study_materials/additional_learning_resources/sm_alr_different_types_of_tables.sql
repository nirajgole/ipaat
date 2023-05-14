-- 1. Use the inbuilt functions and find the minimum, maximum and average amount from the orders table
SELECT MIN(AMOUNT) AS MIN_AMT , MAX(AMOUNT) AS MAX_AMT, AVG(AMOUNT) AS AVG_AMT
FROM dbo.ORDERS

--2. Create a user-defined function, which will multiply the given number with 10
CREATE FUNCTION [dbo].[PrintTable] (@num int)
RETURNS @result TABLE (val varchar(255))
AS
BEGIN
    DECLARE @i int = 1;
    WHILE @i <= 10
    BEGIN
        INSERT INTO @result
        SELECT CAST(@num AS varchar) + ' x ' + CAST(@i AS varchar) + ' = ' + CAST((@num * @i) AS varchar);
        SET @i = @i + 1;
    END;
    RETURN;
END;


SELECT *
from dbo.PrintTable(6)

--3. Use the case statement to check if 100 is less than 200, 
-- greater than 200 or equal to 2oo and print the corresponding value
SELECT CASE WHEN 100<200 THEN 'LESS' WHEN 100>200 THEN 'GREATER' ELSE 'EQUAL' END

