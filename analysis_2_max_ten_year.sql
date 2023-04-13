spool C:\Users\saksh\Documents\FoundationOfComputing\Project3TextFiles\analysis_2_max_ten_year.txt
set echo on
set timing on
column column_name format a15
set linesize 200
--Analysis 2
--Actor & and Actress who did maximum movies in span of 10 years
(
    SELECT
        nb.nconst
        || ' ; '
        || nb.primaryname
        --|| ';'
        --|| tb.startyear
        || ' ; '
        || COUNT(tb.titletype)
        || ' ; '
        || tp.category AS "ID ; Name ; MaxMovieCount ; Category"
    FROM
             imdb00.name_basics nb
        JOIN imdb00.title_principals tp ON ( nb.nconst = tp.nconst )
        JOIN imdb00.title_basics     tb ON ( tp.tconst = tb.tconst )
    WHERE
        tp.category LIKE '%actor%'
        AND tb.titletype LIKE '%movie%'
        AND tb.startyear != '\N'
        AND ( tb.startyear BETWEEN '1953' AND '1962' )
        AND tp.category = 'actor'
    GROUP BY
        nb.primaryname,
        --tb.startyear,
        nb.nconst,
        tp.category
    HAVING
        COUNT(tb.titletype) >= 3
    ORDER BY
        COUNT(tb.titletype) DESC
    FETCH FIRST 1 ROW WITH TIES
)
UNION ALL
(
    SELECT
        nb.nconst
        || ' ; '
        || nb.primaryname
        --|| ';'
        --|| tb.startyear
        || ' ; '
        || COUNT(tb.titletype)
        || ' ; '
        || tp.category AS "ID ; Name ; MaxMovieCount ; Category"
    FROM
             imdb00.name_basics nb
        JOIN imdb00.title_principals tp ON ( nb.nconst = tp.nconst )
        JOIN imdb00.title_basics     tb ON ( tp.tconst = tb.tconst )
    WHERE
        tp.category LIKE '%actress%'
        AND tb.titletype LIKE '%movie%'
        AND tb.startyear != '\N'
        AND ( tb.startyear BETWEEN '1953' AND '1962' )
        AND tp.category = 'actress'
    GROUP BY
        nb.primaryname,
        --tb.startyear,
        nb.nconst,
        tp.category
    HAVING
        COUNT(tb.titletype) >= 3
    ORDER BY
        COUNT(tb.titletype) DESC
    FETCH FIRST 1 ROW WITH TIES
);

Set timing off   
Set echo off
Spool off