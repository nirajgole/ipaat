/*
# Operators & Clauses – Assignment
*/

-- 27) Display Highest, Lowest and Average Salaries for those earning more than 2000

SELECT MAX(SALARY) MAX_SAL, MIN(SALARY) MIN_SAL, AVG(SALARY) AVG_SAL

FROM PROGRAMMER

WHERE SALARY>2000

-- 26) Display the Number of Packages in Each Language for which Development Cost is less than 1000.

SELECT DEVELOPIN, COUNT(*) AS NO_OF_PACKAGES

FROM SOFTWARE

GROUP BY DEVELOPIN,DCOST

HAVING DCOST<1000

-- 25) Who is the least experienced Programmer?

SELECT TOP(1)

    PNAME

FROM PROGRAMMER

ORDER BY DOJ DESC

-- 24) Who is the most experienced male programmer knowing PASCAL?



SELECT TOP(1)
    PNAME

FROM PROGRAMMER

WHERE 'PASCAL' IN (PROF1,PROF2)

ORDER BY DOJ

-- 23) Which Language is known by only one Programmer?



WITH
    cte

    AS
    (
                    SELECT PROF1

            FROM PROGRAMMER

        UNION ALL

            SELECT PROF2

            FROM PROGRAMMER
    )



SELECT PROF1,

    COUNT(*) AS CNT

FROM cte

GROUP BY PROF1



-- SELECT PROF1,COUNT(*) AS CNT

-- FROM PROGRAMMER 

-- GROUP BY PROF1



-- 22) Who is the Youngest Programmer knowing DBASE?

SELECT PNAME
FROM PROGRAMMER
WHERE DOB=

(SELECT MAX(DOB)

    FROM PROGRAMMER

) AND (PROF1='DBASE' OR PROF2='DBASE')

-- 21) Which Female Programmer earning more than 3000 does not know C, C++, ORACLE or DBASE?

SELECT PNAME

FROM PROGRAMMER

WHERE GENDER='F' AND SALARY>3000 AND (PROF1 NOT IN ('C','C++','ORACLE','DBASE')) AND (PROF2 NOT IN ('C','C++','ORACLE','DBASE'))

-- 20) Which Package has the lowest selling cost?

SELECT TITLE

FROM SOFTWARE

WHERE SCOST=(SELECT MIN(SCOST)

FROM SOFTWARE)

-- 19) Who is the youngest male Programmer born in 1965?

SELECT PNAME
FROM PROGRAMMER
WHERE DOB=

(SELECT MAX(DOB)

FROM PROGRAMMER

WHERE GENDER='F' AND DATENAME(YY,DOJ)=1965)

-- 18) Who is the oldest Female Programmer who joined in 1992?

SELECT PNAME
FROM PROGRAMMER
WHERE DOB=

(SELECT MIN(DOB)

FROM PROGRAMMER

WHERE GENDER='F' AND DATENAME(YY,DOJ)=1992)

--  17) Display the details of the software developed by the male students of Sabhari.



SELECT *

FROM SOFTWARE

WHERE PNAME IN

(        SELECT PNAME

    FROM STUDIES

    WHERE INSTITUTE='Sabhari'

INTERSECT

    SELECT PNAME

    FROM PROGRAMMER

    WHERE GENDER='M')



-- 16) Display the sales cost of the packages Developed by each Programmer Language wise

SELECT *

FROM SOFTWARE

--  15) How many people draw salary 2000 to 4000?

SELECT COUNT(*) AS "people draw salary 2000 to 4000"

FROM PROGRAMMER

WHERE SALARY BETWEEN 2000 AND 4000

-- 14) What is the AVG Salary? 

SELECT AVG(CAST(SALARY AS INT)) AS AVG_SALARY

FROM PROGRAMMER

-- 1) What is the Highest Number of copies sold by a Package?

SELECT TITLE, SUM(CAST(SOLD AS INT)) AS NO_COPIES_SOLD

FROM SOFTWARE

GROUP BY TITLE

ORDER BY NO_COPIES_SOLD DESC

-- 2. Display lowest course Fee. 

SELECT MIN("COURSE FEE") AS LOWEST_COURSE_FEE

FROM STUDIES

-- 3. How old is the Oldest Male Programmer.

-- Note: here considering DOB for comparison not DOJ





SELECT PNAME, DATEDIFF(yy,DOB,GETDATE())AS "AGE(years)"

FROM PROGRAMMER

WHERE DOB=(SELECT MIN(DOB)

FROM PROGRAMMER

WHERE GENDER='M')



-- 4) What is the AVG age of Female Programmers?

SELECT AVG(DATEDIFF(yy,DOB,GETDATE())) AS AVG_AGE_FEMALE

FROM PROGRAMMER

WHERE GENDER='F'

-- 5) Calculate the Experience in Years for each Programmer and Display with their names in Descending order. 

SELECT PNAME, DATEDIFF(YY,DOJ,GETDATE()) AS "EXP(years)"

FROM PROGRAMMER

ORDER BY PNAME DESC

-- 6. How many programmers have done the PGDCA Course? 

SELECT COUNT(*) AS COUNT_PGDCA_COURSE_STUDENTS

FROM STUDIES

WHERE COURSE='PGDCA'

-- 7. How much revenue has been earned thru sales of Packages Developed in C.

SELECT SUM(CAST(SCOST AS INT)) AS REVENUE_C

FROM SOFTWARE

WHERE DEVELOPIN='C'

-- 8. How many Programmers Studied at Sabhari? 

SELECT COUNT(*) COUNT_PROGRAMMERS_STUDIED_SABHARI

FROM STUDIES

WHERE INSTITUTE='Sabhari'

-- 9. How many Packages Developed in DBASE? 

SELECT COUNT(*) AS PACKAGES_DEVELOPED_IN_DBASE

FROM SOFTWARE

WHERE DEVELOPIN='DBASE'

-- 10. How many programmers studied in Pragathi? 

SELECT COUNT(*) AS PROGRAMMERS_STUDIED_IN_PRAGATHI

FROM STUDIES S

WHERE S.INSTITUTE='Pragathi'



-- 11. How many Programmers Paid 5000 to 10000 for their course? 

SELECT COUNT(*) AS PROGRAMMERS_PAID_BETWEEN_5000_10000

FROM STUDIES S

WHERE S.[COURSE FEE] BETWEEN 5000 AND 10000



-- 12. How many Programmers know either COBOL or PASCAL? 

SELECT COUNT(*) AS "Programmers know either COBOL or PASCAL"

FROM PROGRAMMER

WHERE PROF1 IN ('COBOL','PASCAL') OR PROF2 IN ('COBOL','PASCAL')

-- 13) How many Female Programmers are there?

SELECT COUNT(*) AS FEMALE_PROGRAMMER_COUNT

FROM PROGRAMMER

WHERE GENDER='F'