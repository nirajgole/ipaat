-- 1. Display the details of the software developed in DBASE by Male Programmers, who belong
-- to the institute in which most number of Programmer

SELECT S.TITLE, S.DEVELOPIN, S.SCOST, S.DCOST, S.PNAME, S.SOLD
FROM SOFTWARE S LEFT JOIN PROGRAMMER P ON S.PNAME=P.PNAME LEFT JOIN STUDIES SS ON S.PNAME=SS.PNAME
WHERE S.DEVELOPIN='DBASE' AND P.GENDER='M' AND INSTITUTE IN (SELECT INSTITUTE
    FROM (SELECT INSTITUTE, RANK()OVER(ORDER BY COUNT(*) DESC) AS RANK
        FROM STUDIES
        GROUP BY INSTITUTE) A
    WHERE RANK=1)

-- 2. In which language are most of the programmer’s proficient?
SELECT PROF1
FROM (SELECT PROF1, DENSE_RANK() OVER(ORDER BY COUNT(*) DESC) RANK
    FROM (                                    SELECT PROF1
            FROM PROGRAMMER
        UNION ALL
            SELECT PROF2
            FROM PROGRAMMER) A
    GROUP BY PROF1) B
WHERE RANK=1

-- 3. In which month did the most number of programmers join?
SELECT DATENAME(MM,M)  AS "month did most number of programmers join"
FROM (SELECT MONTH(DOJ) M, DENSE_RANK() OVER(ORDER BY COUNT(*) DESC) RANK
    FROM PROGRAMMER
    GROUP BY MONTH(DOJ)) A
WHERE RANK=1

-- 4. In which year was the most number of Programmers born.
SELECT *
FROM SOFTWARE S LEFT JOIN PROGRAMMER P ON S.PNAME=P.PNAME
WHERE (GENDER='M' AND YEAR(DOB)<1965) OR (GENDER='F' AND YEAR(DOB)>1975)

-- 5. Which programmer has developed the highest number of Packages?
WITH
    CTE
    AS
    (
        SELECT PNAME, DENSE_RANK() OVER(ORDER BY COUNT(*) DESC) AS RANK
        FROM SOFTWARE
        GROUP BY PNAME
    )

SELECT PNAME
FROM CTE
WHERE RANK=1

-- 6. Which language was used to develop the most number of Packages.
SELECT DEVELOPIN
FROM (SELECT DEVELOPIN, RANK()OVER(ORDER BY COUNT(*) DESC) R
    FROM SOFTWARE
    GROUP BY DEVELOPIN) N
WHERE R=1

-- 7. Which course has below average number of Students?
WITH
    CTE
    AS
    (
        SELECT COURSE, COUNT(*) AS No_OF_STUDENTS
        FROM STUDIES
        GROUP BY COURSE
    )
SELECT COURSE
FROM CTE
WHERE No_OF_STUDENTS< (SELECT AVG(No_OF_STUDENTS)
FROM CTE)

-- 8. Which course has been done by the most of the Students?
SELECT COURSE
FROM ( SELECT COURSE, RANK() OVER(ORDER BY COUNT(*) DESC) RANK
    FROM STUDIES
    GROUP BY COURSE) A
WHERE RANK=1

-- 9. Which Institute has the most number of Students?
select institute
from (SELECT INSTITUTE, DENSE_RANK()over(ORDER BY COUNT(*) DESC) rank
    FROM STUDIES
    GROUP BY INSTITUTE) a
WHERE rank=1

-- 10. Who is the Above Programmer Referred in 50?
-- please explain and provide solution

-- 11. Display the names of the highest paid programmers for each Language
SELECT PROF1, PNAME, SALARY
FROM (SELECT PROF1, PNAME, SALARY, DENSE_RANK() OVER(PARTITION BY PROF1 ORDER BY SALARY DESC) AS RANK
    FROM (            SELECT PNAME, PROF1, SALARY
            FROM PROGRAMMER
            GROUP BY PROF1,PNAME,SALARY
        UNION ALL
            SELECT PNAME, PROF2, SALARY
            FROM PROGRAMMER
            GROUP BY PROF2,PNAME,SALARY) _
    GROUP BY PROF1,PNAME,SALARY) B
WHERE RANK=1
ORDER by SALARY












