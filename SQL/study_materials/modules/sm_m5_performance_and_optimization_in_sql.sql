-- 1. Display the names of the highest paid programmers for each Language

SELECT PROF1, PNAME, SALARY
FROM (SELECT PROF1, PNAME, SALARY, DENSE_RANK() OVER(PARTITION BY PROF1 ORDER BY SALARY DESC) AS RANK
    FROM (SELECT PNAME, PROF1, SALARY
            FROM PROGRAMMER
            GROUP BY PROF1,PNAME,SALARY
        UNION ALL
            SELECT PNAME, PROF2, SALARY
            FROM PROGRAMMER
            GROUP BY PROF2,PNAME,SALARY) _
    GROUP BY PROF1,PNAME,SALARY) B
WHERE RANK=1

-- 2. Display the details of those who are drawing the same salary..
SELECT * FROM PROGRAMMER WHERE SALARY IN (SELECT SALARY
FROM PROGRAMMER
GROUP BY SALARY HAVING COUNT(*)>1)

-- 3. Who are the programmers who joined on the same day?
SELECT PNAME,DOJ
FROM PROGRAMMER
WHERE DOJ IN (
SELECT DOJ
FROM PROGRAMMER
GROUP BY DOJ
HAVING COUNT(*)>1
)
ORDER BY DOJ

-- 4. Who are the programmers who have the same Prof2?
SELECT PNAME,PROF2
FROM PROGRAMMER
WHERE PROF2 IN (
    SELECT PROF2
FROM PROGRAMMER
GROUP BY PROF2
HAVING COUNT(*)>1
)
ORDER BY PROF2

-- 5. How many packages were developed by the person who developed the cheapest package, where did he/she study?
WITH
    CTE_CHEAP_DEV
    AS
    (
        SELECT PNAME
        FROM SOFTWARE
        WHERE DCOST=(SELECT MIN(DCOST)
        FROM SOFTWARE)
    )
SELECT S.PNAME, COUNT(*) NO_OF_PACKAGES_DEVELOPED, SS.INSTITUTE
FROM SOFTWARE S LEFT JOIN STUDIES SS ON S.PNAME=SS.PNAME
WHERE S.PNAME IN (SELECT PNAME
FROM CTE_CHEAP_DEV)
GROUP BY S.PNAME, SS.INSTITUTE