USE SQL_PRACTICE
-- 1. Find out the selling cost AVG for packages developed in PascaL

SELECT AVG(CAST(SCOST AS FLOAT)) AS PASCAL_SCOST_AVG
FROM SOFTWARE
WHERE DEVELOPIN = 'PASCAL';



-- 2. Display Names, Ages of all Programmers

SELECT PNAME AS NAME,
       DATEDIFF(YY, DOB, GETDATE()) AS "AGES(YEARS)"
FROM PROGRAMMER;


-- 3. Display the Names of those who have done the DAP Course.

SELECT PNAME AS NAME
FROM STUDIES
WHERE COURSE = 'DAP'

-- 4. Display the Names and Date of Births of all Programmers Born in January.

SELECT PNAME AS NAME,
       DOB AS "DATE OF BIRTH"
FROM PROGRAMMER
WHERE DATENAME(MM, DOB) LIKE 'JAN%'


-- 5. Display the Details of the Software Developed by Ramesh.

SELECT TITLE,
       DEVELOPIN,
       SCOST,
       DCOST,
       SOLD
FROM SOFTWARE
WHERE PNAME = 'RAMESH'


-- 6. Display the Details of Packages for which Development Cost have been recovered.

SELECT TITLE
FROM SOFTWARE
WHERE CAST(SCOST AS FLOAT) > CAST(DCOST AS FLOAT)
GROUP BY TITLE


-- 7. Display the details of the Programmers Knowing C.

SELECT *
FROM PROGRAMMER
WHERE PROF1 = 'C'
      OR PROF2 = 'C'


-- 8. What are the Languages studied by Male Programmers?

SELECT PROF1 AS MALE_DEV_LAN
FROM PROGRAMMER
WHERE GENDER = 'M'
UNION
SELECT PROF2
FROM PROGRAMMER
WHERE GENDER = 'M'


-- 9. Display the details of the Programmers who joined before 1990.

SELECT *
FROM PROGRAMMER
WHERE DATENAME(YY, DOJ) < 1990



-- 10. Who are the authors of the Packages, which have recovered more than double the Development cost

SELECT PNAME
FROM SOFTWARE
WHERE CAST(SCOST AS FLOAT) > CAST(DCOST AS FLOAT) * 2
GROUP BY PNAME