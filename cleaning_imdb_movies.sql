select * from imdb_movies;

SELECT DISTINCT
    (Rating)
FROM
    imdb_movies
ORDER BY Rating;

#update blank to nan not a number
UPDATE imdb_movies 
SET 
    Rating = 'nan'
WHERE
    Rating = '';

select distinct(Year) from imdb_movies
order by Year;

select distinct(Month) from imdb_movies
order by Month;

#update 2008 and 2014 to unknown
update imdb_movies set
Month = 'unknown'
where Month in ('2008','2014');

#update blank and not rated to unrated
update imdb_movies set
Certificate = 'unrated'
where Certificate in ('not rated','');

select distinct(Runtime) from imdb_movies
order by Runtime;

select distinct(Stars) from imdb_movies
order by Stars;

select distinct(Genre) from imdb_movies
order by Genre;

select distinct(Filming_location) from imdb_movies
order by Filming_location; #'The Netherlands' facebook  UK 'United Kingdom'

update imdb_movies set
Filming_location = 'Netherlands'
where Filming_location = 'The Netherlands';

update imdb_movies set
Filming_location = 'unknown'
where Filming_location = 'Official Facebook';

update imdb_movies set
Filming_location = 'United Kingdom'
where Filming_location = 'UK';

select Distinct(Left(Budget,1)) from imdb_movies;

select Budget_copy from imdb_movies;

select Budget_copy from imdb_movies
where Budget like '%C%' Or
Budget like '%S%' Or
Budget like '%D%' Or
Budget like '%A%' Or
Budget like '%N%' And
Budget not like '%Unknown%' ;


ALTER TABLE imdb_movies
ADD COLUMN Budget_Copy TEXT;

update imdb_movies set  Budget_copy = Budget;

update imdb_movies set  Budget_copy = trim(Budget_copy);

update imdb_movies set  Budget_copy = replace(Budget_copy,',','');

update imdb_movies set  Budget_copy = replace(Budget_copy,' ','');

update imdb_movies set  Budget_copy = replace(Budget_copy,'Unknown','0');

update imdb_movies set  Budget_copy = 
Case 
when left(Budget_copy,3)= 'CA$' then replace(Budget_copy,'CA$','')
when left(Budget_copy,3)= 'SEK' then replace(Budget_copy,'SEK','')
when left(Budget_copy,3)= 'DKK' then replace(Budget_copy,'DKK','')
when left(Budget_copy,2)= 'A$' then replace(Budget_copy,'A$','')
when left(Budget_copy,3)= 'NOK' then replace(Budget_copy,'NOK','')
when left(Budget_copy,3)= 'CN¥' then replace(Budget_copy,'CN¥','')
when left(Budget_copy,1)= '€' then replace(Budget_copy,'€','')
when left(Budget_copy,1)= '₹' then replace(Budget_copy,'₹','')
when left(Budget_copy,1)= '£' then replace(Budget_copy,'£','')
when left(Budget_copy,1)= '₩' then replace(Budget_copy,'₩','')
when left(Budget_copy,1)= '¥' then replace(Budget_copy,'¥','')
when left(Budget_copy,1)= '$' then replace(Budget_copy,'$','')
else Budget_copy end;

ALTER TABLE `belajar_gan`.`imdb_movies` 
CHANGE COLUMN `Budget_Copy` `Budget_Copy` BIGINT NULL DEFAULT NULL ;

select Budget,Budget_copy from imdb_movies
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

ALTER TABLE `belajar_gan`.`imdb_movies` 
CHANGE COLUMN `Income` `Income` BIGINT NULL DEFAULT NULL;
