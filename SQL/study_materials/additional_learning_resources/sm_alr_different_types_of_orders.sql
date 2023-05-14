use LiveClassAssignment

-- 1. Arrange the ‘Orders’ dataset in decreasing order of amount
SELECT *
FROM ORDERS
ORDER BY AMOUNT DESC

-- 2. Create a table with name ‘Employee_details1’ and comprising of these columns – ‘Emp_id’, ‘Emp_name’, ‘Emp_salary’. 
-- Create another table with name ‘Employee_details2’, which comprises of same columns as first table.

CREATE TABLE #Employee_details1
(
    emp_id int,
    emp_name VARCHAR(100),
    emp_salary FLOAT
)
CREATE TABLE #Employee_details2
(
    emp_id int,
    emp_name VARCHAR(100),
    emp_salary FLOAT
)

INSERT INTO #Employee_details1
    (emp_id, emp_name, emp_salary)
SELECT employee_id, first_name, salary
FROM EmployeeDetails

INSERT INTO #Employee_details2
    (emp_id, emp_name, emp_salary)
SELECT top 6
    employee_id, first_name, salary
FROM EmployeeDetails

-- 3. Apply the union operator on these two tables
    SELECT *
    FROM #Employee_details1
UNION
    SELECT *
    FROM #Employee_details2

-- 4. Apply the intersect operator on these two tables
    SELECT *
    FROM #Employee_details1
INTERSECT
    SELECT *
    FROM #Employee_details2

-- 5. Apply the except operator on these two tables
    SELECT *
    FROM #Employee_details1
EXCEPT
    SELECT *
    FROM #Employee_details2