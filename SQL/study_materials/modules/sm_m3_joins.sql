/*
## Module 3 Joins - Joins SQL Assignment
*/

-- 1. How many Programmers Don’t know PASCAL and C

SELECT COUNT(*) AS "Programmers Don’t know PASCAL and C"

FROM PROGRAMMER

WHERE PROF1 NOT IN ('PASCAL','C') AND PROF2 NOT IN ('PASCAL','C')

-- 2. Display the details of those who don’t know Clipper, COBOL or PASCAL.

-- DECLARE @ABC VARCHAR(255) = ('COBOL PASCAL')

SELECT *

FROM PROGRAMMER

WHERE PROF1 NOT IN ('Clipper','COBOL','PASCAL') AND PROF2 NOT IN ('Clipper','COBOL','PASCAL')

-- 3. Display each language name with AVG Development Cost, AVG Selling Cost and AVG Price per Copy.

SELECT TITLE, COUNT(*), AVG(DCOST) AS AVG_DCOST, AVG(SCOST) AS AVG_SCOST, AVG(SOLD*SCOST) AS AVG_PRICE_PER_COPY

FROM SOFTWARE

GROUP BY TITLE

-- 4. List the programmer names (from the programmer table) and No. Of Packages each has developed.

SELECT PNAME, COUNT(*) AS NO_OF_PACKAGES

FROM SOFTWARE

GROUP BY PNAME

-- 5. List each PROF with the number of Programmers having that 

-- PROF and the number of the packages in that PROF.



SELECT P.PROF1, P.NO_OF_PROGRAMMER, S.NO_OF_PACKAGES
FROM (SELECT PROF1, SUM(NO_OF_PROGRAMMER) AS NO_OF_PROGRAMMER
    FROM

        (            SELECT PROF1, COUNT(*) AS NO_OF_PROGRAMMER

            FROM PROGRAMMER

            GROUP BY PROF1

        UNION ALL

            SELECT PROF2, COUNT(*) AS NO_OF_PROGRAMMER

            FROM PROGRAMMER

            GROUP BY PROF2) P

    GROUP BY PROF1) P

    INNER JOIN (

    SELECT DEVELOPIN, COUNT(*) AS NO_OF_PACKAGES

    FROM SOFTWARE

    GROUP BY DEVELOPIN

) S ON P.PROF1=S.DEVELOPIN



-- 6. How many packages are developed by the most experienced programmer from BDPS.



SELECT TOP 1
    S.PNAME, COUNT(*) AS NO_OF_PACKAGES

FROM SOFTWARE S INNER JOIN STUDIES SS ON S.PNAME=SS.PNAME INNER JOIN PROGRAMMER P ON S.PNAME=P.PNAME

GROUP BY S.PNAME,SS.INSTITUTE,P.DOJ

HAVING SS.INSTITUTE='BDPS'

ORDER BY P.DOJ ASC

-- 7. How many packages were developed by the female programmers earning more than the

-- highest paid male programmer?

SELECT COUNT(*) AS NO_OF_PACKAGES

FROM SOFTWARE S INNER JOIN PROGRAMMER P ON S.PNAME=P.PNAME

WHERE GENDER='F' AND P.SALARY > (SELECT MAX(SALARY)

    FROM PROGRAMMER

    WHERE GENDER='M')

-- 8. How much does the person who developed the highest selling package earn and what course

-- did HE/SHE undergo.



SELECT TOP 1
    P.PNAME, P.SALARY, SS.COURSE

FROM SOFTWARE S INNER JOIN PROGRAMMER P ON S.PNAME=P.PNAME INNER JOIN STUDIES SS ON S.PNAME=SS.PNAME

ORDER BY SCOST DESC

-- 9. In which institute did the person who developed the costliest package study?

SELECT TOP 1
    S.PNAME, SS.INSTITUTE

FROM SOFTWARE S INNER JOIN STUDIES SS ON S.PNAME=SS.PNAME

ORDER BY DCOST DESC

-- 10. Display the names of the programmers who have not developed any packages.

SELECT P.PNAME

FROM PROGRAMMER P LEFT JOIN SOFTWARE S ON P.PNAME=S.PNAME

WHERE DEVELOPIN IS NULL

-- 11. Display the details of the software that has developed in the language which is neither the

-- first nor the second proficiency

SELECT TITLE

FROM PROGRAMMER P LEFT JOIN SOFTWARE S ON P.PNAME=S.PNAME

WHERE S.DEVELOPIN NOT IN (P.PROF1,P.PROF2)

-- 12. Display the details of the software Developed by the male programmers Born before 1965

-- and female programmers born after 1975

    SELECT S.PNAME, S.TITLE, S.DCOST, S.SCOST, S.SOLD, S.DEVELOPIN

    FROM SOFTWARE S JOIN PROGRAMMER P ON S.PNAME=P.PNAME

    WHERE YEAR(DOB) < 1965 AND GENDER='M'

UNION ALL

    SELECT S.PNAME, S.TITLE, S.DCOST, S.SCOST, S.SOLD, S.DEVELOPIN

    FROM SOFTWARE S JOIN PROGRAMMER P ON S.PNAME=P.PNAME

    WHERE YEAR(DOB) > 1975 AND GENDER='F'

-- 13. Display the number of packages, No. of Copies Sold and sales value of each programmer

-- institute wise.

SELECT P.PNAME, SS.INSTITUTE, COUNT(TITLE) AS NO_OF_PACKAGES, SUM(S.SOLD) AS "No. of Copies Sold", SUM(S.SCOST) AS "sales value"

FROM PROGRAMMER P LEFT JOIN SOFTWARE S ON P.PNAME=S.PNAME LEFT JOIN STUDIES SS ON P.PNAME=SS.PNAME

GROUP BY P.PNAME,SS.INSTITUTE

ORDER BY P.PNAME

-- 14. Display the details of the Software Developed by the Male Programmers Earning More than

-- 3000

SELECT S.PNAME, S.TITLE, S.DCOST, S.DEVELOPIN, S.SCOST, S.SOLD

FROM SOFTWARE S JOIN PROGRAMMER P ON S.PNAME=P.PNAME

WHERE GENDER='M' AND SALARY>3000

-- 15. Who are the Female Programmers earning more than the Highest Paid male?

SELECT *

FROM PROGRAMMER P

WHERE GENDER='F' AND

    SALARY >

(SELECT MAX(SALARY)

    FROM PROGRAMMER

    WHERE GENDER='M')

-- 16. Who are the male programmers earning below the AVG salary of Female Programmers?

SELECT *

FROM PROGRAMMER P

WHERE GENDER='M' AND SALARY < (SELECT AVG(SALARY)

    FROM PROGRAMMER

    WHERE GENDER='F')

-- 17. Display the language used by each programmer to develop the Highest Selling and

-- Lowest-selling package.

-- 18. Display the names of the packages, which have sold less than the AVG number of copies.

SELECT TITLE

FROM SOFTWARE

WHERE SOLD< (SELECT AVG(SOLD)

FROM SOFTWARE)

-- 19. Which is the costliest package developed in PASCAL.

-- SELECT TITLE

-- FROM SOFTWARE

-- WHERE DEVELOPIN='PASCAL' AND SCOST=(SELECT MAX(SCOST)

--     FROM SOFTWARE WHERE DEVELOPIN='PASCAL')

SELECT TITLE

FROM SOFTWARE S JOIN (SELECT MAX(SCOST) AS MAX_SCOST

    FROM SOFTWARE

    WHERE DEVELOPIN='PASCAL') A ON S.SCOST=A.MAX_SCOST

-- 20. How many copies of the package that has the least difference between development and

-- selling cost were sold.

SELECT TITLE, SOLD

FROM SOFTWARE

WHERE ABS(SCOST-DCOST) = (SELECT MIN(ABS(SCOST-DCOST))

FROM SOFTWARE)



-- 21. Which language has been used to develop the package, which has the highest sales

-- amount?

SELECT DEVELOPIN

FROM SOFTWARE

WHERE (SCOST*SOLD) = (SELECT MAX(SOLD*SCOST)

FROM SOFTWARE)

-- 22. Who Developed the Package that has sold the least number of copies?

SELECT PNAME
FROM SOFTWARE
WHERE SOLD=(SELECT MIN(SOLD)
FROM SOFTWARE)

-- 23. Display the names of the courses whose fees are within 1000 (+ or -) of the Average Fee

WITH

    CTE

    AS

    (

        SELECT AVG([COURSE FEE]) AS AVG_FEE

        FROM STUDIES

    )



SELECT *

FROM STUDIES

WHERE [COURSE FEE] BETWEEN ((SELECT AVG_FEE

FROM CTE)-1000) AND ((SELECT AVG_FEE

FROM CTE)+1000)



-- 24. Display the name of the Institute and Course, which has below AVG course fee.

SELECT INSTITUTE, COURSE

FROM STUDIES

WHERE [COURSE FEE]<(SELECT AVG([COURSE FEE])

FROM STUDIES)



-- 25. Which Institute conducts costliest course.

SELECT INSTITUTE

FROM STUDIES

WHERE [COURSE FEE]=(SELECT MAX([COURSE FEE])

FROM STUDIES)

-- 26. What is the Costliest course?

SELECT COURSE
FROM STUDIES
WHERE [COURSE FEE]=(SELECT MAX([COURSE FEE])
FROM STUDIES)