select * from imdb_movies;

SELECT distinct(Rating)
FROM
    imdb_movies
ORDER BY Rating;

select avg(Rating_copy1) from imdb_movies;

#update blank to nan not a number
UPDATE imdb_movies 
SET 
    Rating = 'nan'
WHERE
    Rating = '';

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
update imdb_movies set
Certificate = 'unrated'
where Certificate in ('not rated','');


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

select Budget from imdb_movies
where Budget like '%C%' Or
Budget like '%S%' Or
Budget like '%D%' Or
Budget like '%A%' Or
Budget like '%N%' And
Budget not like '%Unknown%' ;


ALTER TABLE imdb_movies
ADD COLUMN Budget_USD TEXT;

update imdb_movies set  Budget_USD = Budget;

update imdb_movies set  Budget_USD = trim(Budget_USD);

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

select Budget,Budget_USD from imdb_movies
where Budget not like '%$%' and Budget != 'Unknown';

#cleaning income
select Income from imdb_movies
where Income != '0';

update imdb_movies set
income = '0'
where income = 'Unknown';

update imdb_movies set
income = trim(income);

update imdb_movies set
income = replace(income,',','');

update imdb_movies set
income = replace(income,'$','')
where income like '%$%';

ALTER TABLE `cleaning_table`.`imdb_movies` 
CHANGE COLUMN `Income` `Income` BIGINT NULL DEFAULT NULL;
