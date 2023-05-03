-- 1. Get all the details from the person table including email ID, phone number, and phone number type 
SELECT TOP 100
    P.FirstName, PE.EmailAddress, PP.PhoneNumber , PT.Name
FROM Person.Person P
    LEFT JOIN Person.EmailAddress PE ON P.BusinessEntityID=PE.BusinessEntityID
    LEFT JOIN Person.PersonPhone PP ON P.BusinessEntityID=PP.BusinessEntityID
    LEFT JOIN Person.PhoneNumberType PT ON PP.PhoneNumberTypeID=PT.PhoneNumberTypeID

--2. Get the details of the sales header order made in May 2011
SELECT TOP 100
    *
FROM Sales.SalesOrderHeader
WHERE OrderDate BETWEEN '2011-05-01' AND '2011-05-31'

--3. Get the details of the sales details order made in the month of May 2011
SELECT TOP 100
    *
FROM Sales.SalesOrderDetail SOD LEFT JOIN Sales.SalesOrderHeader SOH ON SOD.SalesOrderID=SOH.SalesOrderID
WHERE OrderDate BETWEEN '2011-05-01' AND '2011-05-31'

--4. Get the total sales made in May 2011
SELECT TOP 100
    SUM(SOD.OrderQty*(SOD.UnitPrice-SOD.UnitPriceDiscount)) AS TOTAL_SALES_MAY_2011
FROM Sales.SalesOrderDetail SOD LEFT JOIN Sales.SalesOrderHeader SOH ON SOD.SalesOrderID=SOH.SalesOrderID
WHERE OrderDate BETWEEN '2011-05-01' AND '2011-05-31'

--5. Get the total sales made in the year 2011 by month order by increasing sales
SELECT TOP 100
    DATENAME(MM,OrderDate) AS MONTH,
    SUM(SOD.OrderQty*(SOD.UnitPrice-SOD.UnitPriceDiscount)) AS TOTAL_SALES_MAY_2011
FROM Sales.SalesOrderDetail SOD LEFT JOIN Sales.SalesOrderHeader SOH ON SOD.SalesOrderID=SOH.SalesOrderID
WHERE YEAR(OrderDate) = 2011
GROUP BY DATENAME(MM,OrderDate)
ORDER BY TOTAL_SALES_MAY_2011

-- 6. Get the total sales made to the customer with FirstName='Gustavo' and LastName='Achong'
SELECT SUM(SOD.OrderQty*(SOD.UnitPrice-SOD.UnitPriceDiscount)) AS TOTAL_SALES_MAY_2011
FROM Person.Person pp
JOIN Sales.Customer sc ON pp.BusinessEntityID = sc.PersonID
JOIN Sales.SalesOrderHeader soh ON sc.CustomerID = soh.CustomerID
JOIN Sales.SalesOrderDetail sod ON soh.SalesOrderID=sod.SalesOrderID
WHERE FirstName = 'Gustavo'
	AND LastName = 'Achong'