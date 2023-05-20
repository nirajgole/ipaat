-- 1 Display the “FIRST_NAME” from Employee table using the alias name 

-- as Employee_name.

SELECT FIRST_NAME Employee_name
FROM EmployeeDetails

-- 2 Display “LAST_NAME” from Employee table in upper case.

SELECT UPPER(LAST_NAME) AS LAST_NAME
FROM EmployeeDetails

-- 3 Display unique values of DEPARTMENT from EMPLOYEE table.

SELECT DISTINCT Department
FROM EmployeeDetails

-- 4 Display the first three characters of LAST_NAME from EMPLOYEE table.

SELECT SUBSTRING(Last_Name,1,3)
FROM EmployeeDetails

-- 5 Display the unique values of DEPARTMENT from EMPLOYEE table and 

-- prints its length.

SELECT DISTINCT LEN(DEPARTMENT)
FROM EmployeeDetails

-- 6 Display the FIRST_NAME and LAST_NAME from EMPLOYEE table into a 

-- single column AS FULL_NAME. 

--  a space char should separate them.

SELECT CONCAT_WS(' ',First_name,Last_Name) AS FULL_NAME

FROM EmployeeDetails

-- 7 DISPLAY all EMPLOYEE details from the employee table 

-- order by FIRST_NAME Ascending.

SELECT *
FROM EmployeeDetails
ORDER BY First_name

-- 8. Display all EMPLOYEE details order by FIRST_NAME Ascending and

-- DEPARTMENT Descending.

SELECT *
FROM EmployeeDetails
ORDER BY First_name, Department DESC

-- 9 Display details for EMPLOYEE with the first name as “VEENA” and 

-- “KARAN” from EMPLOYEE table.

SELECT *
FROM EmployeeDetails
WHERE First_name IN ('VEENA','KARAN')

-- 10 Display details of EMPLOYEE with DEPARTMENT name as “Admin”.

SELECT *
FROM EmployeeDetails
WHERE Department='ADMIN'

-- 11 DISPLAY details of the EMPLOYEES whose FIRST_NAME contains ‘V’.

SELECT *
FROM EmployeeDetails
WHERE First_name LIKE 'v%'

-- 12 DISPLAY details of the EMPLOYEES whose SALARY lies between 

-- 100000 and 500000.

SELECT *
FROM EmployeeDetails
WHERE Salary BETWEEN 100000 AND 500000

-- 13 Display details of the employees who have joined in Feb-2020.

SELECT *
FROM EmployeeDetails
WHERE Joining_date BETWEEN '2020-02-01' AND '2020-02-29'

-- 14 Display employee names with salaries >= 50000 and <= 100000.

SELECT First_name
FROM EmployeeDetails
WHERE Salary BETWEEN 50000 AND 100000

-- 15 Display the number of Employees for each department in the 

-- descenting order.

SELECT Department, COUNT(*) AS "number of Employees"
FROM EmployeeDetails
GROUP BY Department

-- 16 DISPLAY details of the EMPLOYEES who are also Managers.

SELECT *
FROM EmployeeDetails E LEFT JOIN EmployeeTitle ET ON E.Employee_id=ET.Employee_ref_id
WHERE Employee_Title='Manager'

-- 17 DISPLAY duplicate records having matching data in some fields of a 

-- table. 

-- ???????????? please explain this 

-- 18 Display only odd rows from a table. 

SELECT *
FROM (SELECT *, ROW_NUMBER() OVER(ORDER BY Employee_id) AS RWN
    FROM EmployeeDetails) A
WHERE RWN%2!=0

-- 19 Clone a new table from EMPLOYEE table.

-- SIMPLE CLONING

-- select *

-- into EMPD1

-- from EmployeeDetails

-- where 1 = 0;



-- DEEP CLONING

select *

into EMPD1

from EmployeeDetails

-- 20 DISPLAY the TOP 2 highest salary from a table.

SELECT DISTINCT TOP 2
    SALARY
FROM EmployeeDetails
ORDER BY Salary DESC

-- 21. DISPLAY the list of employees with the same salary.

SELECT *

FROM EmployeeDetails

WHERE SALARY IN (SELECT SALARY

FROM EmployeeDetails

GROUP BY Salary

HAVING COUNT(*)>1)

-- 22 Display the second highest salary from a table. 

SELECT SALARY

FROM (SELECT SALARY, DENSE_RANK()OVER(ORDER BY SALARY DESC) AS RANK

    FROM EmployeeDetails

    GROUP BY SALARY) A

WHERE RANK=2

-- 23 Display the first 50% records from a table. 

SELECT *
FROM (SELECT *, NTILE(2) OVER(ORDER BY Employee_id) AS NTILE
    FROM EmployeeDetails) A
WHERE NTILE=1

-- 24. Display the departments that have less than 4 people in it.

SELECT DEPARTMENT
FROM EmployeeDetails
GROUP BY Department
HAVING COUNT(*)<4

-- 25. Display all departments along with the number of people in there.

SELECT DEPARTMENT, COUNT(*) AS NO_OF_EMP
FROM EmployeeDetails
GROUP BY Department

-- 26 Display the name of employees having the highest salary in 

-- each department.

SELECT First_name, Department

FROM (SELECT First_name, Department, DENSE_RANK()OVER(PARTITION BY DEPARTMENT ORDER BY SALARY DESC) RNK

    FROM EmployeeDetails

    GROUP BY Department,SALARY,First_name) A

WHERE RNK=1

-- 27 Display the names of employees who earn the highest salary.

SELECT First_name
FROM EmployeeDetails
WHERE SALARY = (SELECT MAX(SALARY)
FROM EmployeeDetails)

-- 28 Diplay the average salaries for each department 

SELECT Department, AVG(SALARY) AS AVG_SAL
FROM EmployeeDetails
GROUP BY Department

-- 29 display the name of the employee who has got maximum bonus

SELECT *

FROM EmployeeDetails E LEFT JOIN EmployeeBonus EB ON E.Employee_id=EB.Employee_ref_id_FK

WHERE Bonus_Amount=(SELECT MAX(Bonus_Amount)

FROM EmployeeBonus)

-- 30 Display the first name and title of all the employees

SELECT First_name, Employee_title
FROM EmployeeDetails ED LEFT JOIN EmployeeTitle ET ON ED.Employee_id=ET.Employee_ref_id