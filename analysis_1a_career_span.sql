spool C:\Users\saksh\Documents\FoundationOfComputing\Project3TextFiles\analysis_1a_career_span.txt
set echo on
set timing on
column column_name format a15
set linesize 200
SELECT
    nb.primaryname
    || ' ; '
    || min(tb.startyear)
    || ' - ' 
    || max(tb.startyear)
    || ' ; '
    || (max(tb.startyear)-min(tb.startyear))
    || ' ; '
    || count(*)
    as "Name ; Year Range ; CareerSpan ; Number of Movies"
FROM
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
    AND lower(tb.titletype) = 'movie'
    AND lower(tp.category) IN ( 'actor', 'actress' )
    AND tb.startyear NOT LIKE '\N'
GROUP BY
    nb.nconst,
    nb.primaryname
ORDER BY
    nb.primaryname;
Set timing off   
Set echo off
Spool off