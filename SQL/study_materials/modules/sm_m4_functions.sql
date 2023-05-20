/*
## Study Material-M4-SQL-Functions-Assignment
*/

-- 1. What is the cost of the costliest software development in Basic?

SELECT TITLE, DCOST

FROM SOFTWARE

WHERE DEVELOPIN='BASIC' AND DCOST=(SELECT MAX(DCOST)

    FROM SOFTWARE
    WHERE DEVELOPIN='BASIC')



-- 2. Display details of Packages whose sales crossed the 2000 Mark.

SELECT *

FROM SOFTWARE S JOIN ( SELECT TITLE, SUM(SCOST*SOLD) AS TOTAL_SALES

    FROM SOFTWARE

    GROUP BY TITLE) A

    ON S.TITLE=A.TITLE

WHERE A.TOTAL_SALES>2000

-- 3. Who are the Programmers who celebrate their Birthdays during the Current Month?

SELECT *
FROM PROGRAMMER
WHERE MONTH(DOB) = MONTH(GETDATE())



-- 4. Display the Cost of Package Developed By each Programmer.

SELECT PNAME, SUM(DCOST) TOTAL_DCOST
FROM SOFTWARE
GROUP BY PNAME



-- 5. Display the sales values of the Packages Developed by each Programmer.

SELECT PNAME, TITLE, SUM(SCOST*SOLD) TOTAL_SALES
FROM SOFTWARE
GROUP BY PNAME,TITLE

-- 6. Display the Number of Packages sold by Each Programmer.

SELECT PNAME, SUM(SOLD) AS NO_OF_PACKAGES
FROM SOFTWARE
GROUP BY PNAME



CREATE FUNCTION get_details()

returns table as return

SELECT PNAME, MAX(SCOST) AS MAX_SCOST, MIN(SCOST) AS MIN_SCOST

FROM SOFTWARE

GROUP BY PNAME

-- CREATE FUNCTION get_result(@col_name varchar(50), @col varchar(50))

-- returns table return

-- SELECT S.PNAME, TITLE AS [@col_name]

-- FROM SOFTWARE S JOIN dbo.get_details() C ON S.PNAME=C.PNAME AND S.SCOST=C.[@col]

-- 7. Display each programmer’s name, costliest and cheapest Packages Developed by him or her.

SELECT C_MAX.PNAME, costliest, cheapest
FROM

    (SELECT S.PNAME, TITLE AS costliest

    FROM SOFTWARE S JOIN dbo.get_details() C ON S.PNAME=C.PNAME AND S.SCOST=C.MAX_SCOST) C_MAX

    JOIN

    (SELECT S.PNAME, TITLE AS cheapest

    FROM SOFTWARE S JOIN dbo.get_details() C ON S.PNAME=C.PNAME AND S.SCOST=C.MIN_SCOST) C_MIN

    ON C_MAX.PNAME=C_MIN.PNAME

-- 8. Display each institute name with the number of Courses, Average Cost per Course.

SELECT INSTITUTE, COUNT(COURSE) AS NO_OF_COURSES, AVG([COURSE FEE]) AS AVG_COST_PER_COURSE

FROM STUDIES

GROUP BY INSTITUTE

-- 9. Display each institute Name with Number of Students.

SELECT INSTITUTE, COUNT(PNAME) AS "Number of Students"

FROM STUDIES

GROUP BY INSTITUTE

-- 10. List the programmers (form the software table) and the institutes they studied.

SELECT DISTINCT S.PNAME, SS.INSTITUTE

FROM SOFTWARE S LEFT JOIN STUDIES SS ON S.PNAME=SS.PNAME



-- 11. How many packages were developed by students, 

-- who studied in institute that charge the lowest course fee?

SELECT S.PNAME, COUNT(TITLE) AS NO_OF_PACKAGES

FROM SOFTWARE S LEFT JOIN STUDIES SS ON S.PNAME=SS.PNAME

GROUP BY S.PNAME,SS.[COURSE FEE]

HAVING SS.[COURSE FEE]=(SELECT MIN([COURSE FEE])

FROM STUDIES)

-- 12. What is the AVG salary for those whose software sales is more than 50,000/-.

SELECT AVG(P.SALARY) AS "AVG salary for those whose software sales is more than 50,000"

FROM PROGRAMMER P JOIN (SELECT PNAME

    FROM SOFTWARE

    WHERE SCOST*SOLD>50000

    GROUP BY PNAME) A ON P.PNAME=A.PNAME

-- 13. Which language listed in prof1, prof2 has not been used to develop any package.

SELECT PROF1

FROM (        SELECT PROF1

        FROM PROGRAMMER

    UNION

        SELECT PROF2

        FROM PROGRAMMER) P LEFT JOIN SOFTWARE S ON P.PROF1=S.DEVELOPIN

WHERE DEVELOPIN IS NULL

-- 14. Display the total sales value of the software, institute wise.

SELECT INSTITUTE, SUM(SCOST*SOLD) AS TOTAL_SALES_VALUE

FROM SOFTWARE S LEFT JOIN STUDIES SS ON S.PNAME=SS.PNAME

GROUP BY SS.INSTITUTE

-- 15. Display the details of the Software Developed in C By female programmers of Pragathi

SELECT *

FROM SOFTWARE S LEFT JOIN PROGRAMMER P ON S.PNAME=P.PNAME LEFT JOIN STUDIES SS ON S.PNAME=SS.PNAME
WHERE

DEVELOPIN='C' AND GENDER='F' AND SS.INSTITUTE='Pragathi'

-- 16. Display the details of the packages developed in Pascal by the Female Programmers.

SELECT S.TITLE, S.PNAME, S.DCOST, S.DEVELOPIN, S.SCOST, S.SOLD
FROM SOFTWARE S LEFT JOIN PROGRAMMER P ON S.PNAME=P.PNAME
WHERE GENDER='F' AND DEVELOPIN='PASCAL'

-- 17. Which language has been stated as the proficiency by most of the Programmers?

SELECT PROF1

FROM (SELECT PROF1, DENSE_RANK()OVER(ORDER BY COUNT(PROF1) DESC) AS RANK

    FROM (                        SELECT PROF1

            FROM PROGRAMMER

        UNION ALL

            SELECT PROF2

            FROM PROGRAMMER) A

    GROUP BY PROF1) B

WHERE RANK=1

-- 18. Who is the Author of the Costliest Package?

SELECT PNAME
FROM SOFTWARE
WHERE SCOST = (SELECT MAX(SCOST)
FROM SOFTWARE)

-- 19. Which package has the Highest Development cost?

SELECT TITLE
FROM SOFTWARE
WHERE DCOST = (SELECT MAX(DCOST)
FROM SOFTWARE)

-- 20. Who is the Highest Paid Female COBOL Programmer?

SELECT PNAME
FROM (SELECT PNAME, DENSE_RANK()OVER(ORDER BY SALARY DESC) AS RANK

    FROM PROGRAMMER

    WHERE GENDER='F' AND 'COBOL' IN (PROF1,PROF2)) A
WHERE RANK=1

-- 21. Display the Name of Programmers and Their Packages.

SELECT P.PNAME, S.TITLE

FROM PROGRAMMER P LEFT JOIN SOFTWARE S ON P.PNAME=S.PNAME

GROUP BY P.PNAME,S.TITLE



-- 22. Display the Number of Packages in Each Language Except C and C++.

SELECT DEVELOPIN, COUNT(TITLE) AS NO_OF_PACKAGES
FROM SOFTWARE
WHERE DEVELOPIN NOT IN ('C','C++')
GROUP BY DEVELOPIN

-- 23. Display AVG Difference between SCOST, DCOST for Each Package.

SELECT TITLE, ABS(AVG(SCOST)-AVG(DCOST)) AVG_DIFFERENCE
FROM SOFTWARE
GROUP BY TITLE

-- 24. Display the total SCOST, DCOST and amount to Be Recovered for each Programmer for

-- Those Whose Cost has not yet been Recovered.

SELECT P.PNAME, SUM(SCOST*SOLD) AS TOTAL_SCOST, SUM(DCOST) AS TOTAL_DCOST, (SUM(DCOST)-SUM(SCOST*SOLD)) AS AMOUNT_TO_BE_RECOVER6

FROM SOFTWARE S LEFT JOIN PROGRAMMER P ON S.PNAME=P.PNAME

WHERE (SCOST*SOLD) <DCOST

GROUP BY P.PNAME



-- 25. Who is the Highest Paid C Programmers?

WITH CTE
AS
(

    SELECT *
FROM PROGRAMMER
WHERE 'C' IN (PROF1,PROF2)

)



SELECT PNAME
FROM CTE
WHERE SALARY=(SELECT MAX(SALARY)
FROM CTE)



-- 26. Who is the Highest Paid Female COBOL Programmer

WITH

    CTE

    AS



    (

        SELECT *

        FROM PROGRAMMER

        WHERE GENDER='F' AND 'COBOL' IN (PROF1,PROF2)

    )

SELECT PNAME
FROM CTE
WHERE SALARY=(SELECT MAX(SALARY)
FROM CTE)