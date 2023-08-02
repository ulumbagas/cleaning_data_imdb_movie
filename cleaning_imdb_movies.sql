select * from copy_imdb_movies;

#update blank to nan not a number
UPDATE imdb_movies 
SET 
    Rating = ''
WHERE
    Rating = 'nan';

select distinct(Year) from imdb_movies
order by Year;

select distinct(`Month`) from imdb_movies;

#update 2008 and 2014 to unknown
UPDATE imdb_movies 
SET 
    Month = 'unknown'
WHERE
    Month IN ('2008' , '2014');
    
#update blank and not rated to unrated
UPDATE imdb_movies 
SET 
    Certificate = 'unrated'
WHERE
    Certificate IN ('not rated' , '');

UPDATE imdb_movies 
SET 
    Certificate = null
WHERE
    Certificate = '';

select distinct(Certificate) from imdb_movies;

select distinct(Filming_location) from imdb_movies
order by Filming_location; #'The Netherlands' facebook  UK 'United Kingdom'

UPDATE imdb_movies
SET
    Filming_location = 
    CASE 
        WHEN Filming_location = 'The Netherlands' THEN 'Netherlands'
        WHEN Filming_location = 'Official Facebook' THEN 'unknown'
        WHEN Filming_location = 'UK' THEN 'United Kingdom'
        ELSE Filming_location
    END;
    

select Distinct(Left(Budget,1)) from imdb_movies;

select Budget_USD from imdb_movies;

SELECT 
    Budget, Budget_USD
FROM
    imdb_movies
WHERE
    Budget LIKE '%C%' OR Budget LIKE '%S%'
        OR Budget LIKE '%D%'
        OR Budget LIKE '%A%'
        OR Budget LIKE '%N%'
        AND Budget NOT LIKE '%Unknown%';


ALTER TABLE imdb_movies
ADD COLUMN Budget_USD TEXT;

update imdb_movies set  Budget_USD = Budget;

UPDATE imdb_movies 
SET 
    Budget_USD = TRIM(Budget_USD);

UPDATE imdb_movies
SET Budget_USD = CASE
	WHEN Budget_USD = 'Unknown' THEN 0
    ELSE REPLACE(Budget_USD, ',', '')
END;

update imdb_movies set  Budget_USD = 
Case 
when left(Budget_USD,3)= 'CA$' then replace(Budget_USD,'CA$','')
when left(Budget_USD,3)= 'SEK' then replace(Budget_USD,'SEK','')
when left(Budget_USD,3)= 'DKK' then replace(Budget_USD,'DKK','')
when left(Budget_USD,2)= 'A$' then replace(Budget_USD,'A$','')
when left(Budget_USD,3)= 'NOK' then replace(Budget_USD,'NOK','')
when left(Budget_USD,3)= 'CN¥' then replace(Budget_USD,'CN¥','')
when left(Budget_USD,1)= '€' then replace(Budget_USD,'€','')
when left(Budget_USD,1)= '₹' then replace(Budget_USD,'₹','')
when left(Budget_USD,1)= '£' then replace(Budget_USD,'£','')
when left(Budget_USD,1)= '₩' then replace(Budget_USD,'₩','')
when left(Budget_USD,1)= '¥' then replace(Budget_USD,'¥','')
when left(Budget_USD,1)= '$' then replace(Budget_USD,'$','')
else Budget_USD end;

ALTER TABLE `cleaning_table`.`imdb_movies` 
CHANGE COLUMN `Budget_USD` `Budget_USD` BIGINT NULL DEFAULT NULL ;

UPDATE imdb_movies SET Budget_USD = 
	CASE 
	WHEN LEFT(Budget,1) = '€'   THEN Budget_USD * 1.10 
	WHEN LEFT(Budget,1) = '₹'   THEN Budget_USD * 0.012 
	WHEN LEFT(Budget,1) = '£'   THEN Budget_USD * 1.24 
	WHEN LEFT(Budget,1) = '₩'   THEN Budget_USD * 0.00076 
	WHEN LEFT(Budget,1) = '¥'   THEN Budget_USD * 0.00076 
	WHEN LEFT(Budget,3) = 'CA$' THEN Budget_USD * 0.754688 
	WHEN LEFT(Budget,3) = 'SEK' THEN Budget_USD * 0.095 
	WHEN LEFT(Budget,3) = 'DKK' THEN Budget_USD * 0.15 
	WHEN LEFT(Budget,2) = 'A$'  THEN Budget_USD * 0.667143 
	WHEN LEFT(Budget,3) = 'NOK' THEN Budget_USD * 0.098 
	WHEN LEFT(Budget,3) = 'CN¥' THEN Budget_USD * 0.13994
    else Budget_USD
	END;


#cleaning income
select Income from imdb_movies
where Income != '0';

UPDATE imdb_movies 
SET 
    income = '0'
WHERE
    income = 'Unknown';

UPDATE imdb_movies 
SET 
    income = TRIM(income);

UPDATE imdb_movies 
SET 
    income = REPLACE(income, ',', '');

UPDATE imdb_movies 
SET 
    income = REPLACE(income, '$', '')
where income like '%$%';

select Income `After` from imdb_movies;

ALTER TABLE `cleaning_table`.`imdb_movies` 
CHANGE COLUMN `Income` `Income` BIGINT NULL DEFAULT NULL;
