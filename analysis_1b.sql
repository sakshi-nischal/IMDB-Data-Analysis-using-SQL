spool C:\Users\saksh\Documents\FoundationOfComputing\Project3TextFiles\analysis_1b.txt
set echo on
set timing on
column column_name format a15
set linesize 200
SELECT
    name,
    range                 AS date_range,
    SUM(number_of_movies) AS number_of_movies,
    AVG(average_rating)   AS average_rating
FROM
    (
        SELECT
            nb.primaryname        AS name,
            AVG(tr.averagerating) AS average_rating,
            tb.startyear,
            COUNT(*)              AS number_of_movies,
            CASE
                
                WHEN startyear BETWEEN 1931 AND 1940 THEN
                    '1931-1940'
                WHEN startyear BETWEEN 1941 AND 1950 THEN
                    '1941-1950'
                WHEN startyear BETWEEN 1951 AND 1960 THEN
                    '1951-1960'
                WHEN startyear BETWEEN 1961 AND 1970 THEN
                    '1961-1970'
                WHEN startyear BETWEEN 1971 AND 1980 THEN
                    '1971-1980'
                WHEN startyear BETWEEN 1981 AND 1990 THEN
                    '1981-1990'
                WHEN startyear BETWEEN 1991 AND 2000 THEN
                    '1991-2000'
                WHEN startyear BETWEEN 2001 AND 2010 THEN
                    '2001-2010'
                WHEN startyear BETWEEN 2011 AND 2020 THEN
                    '2011- 2020'
                ELSE
                    '2021-2030'
            END                   AS range
        FROM
            imdb00.title_ratings    tr,
            imdb00.name_basics      nb,
            imdb00.title_principals tp,
            imdb00.title_basics     tb
        WHERE
                nb.nconst = tp.nconst
            AND tp.tconst = tb.tconst
            AND nb.nconst IN ( 
        SELECT
            nconst
        FROM
            imdb00.name_basics
        WHERE
            lower(primaryname) IN ( 'johnny depp', 'judy garland', 'angelina jolie', 'gary oldman' )
     )
            AND tp.tconst = tr.tconst
            AND lower(tb.titletype) = 'movie'
            AND lower(tp.category) IN ( 'actor', 'actress' )
            AND tb.startyear NOT LIKE '\N'
        GROUP BY
            nb.nconst,
            nb.primaryname,
            tb.startyear
        ORDER BY
            tb.startyear DESC
    )
GROUP BY
    name,
    range
ORDER BY
    name,
    range;
Set timing off   
Set echo off
Spool off