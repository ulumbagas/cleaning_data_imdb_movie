select * from imdb_movies;

select distinct(Rating) from imdb_movies
order by Rating;

#update blank to nan not a number
update imdb_movies set
Rating = 'nan'
where Rating = '';

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

/*ALTER TABLE imdb_movies
ADD COLUMN Budget_Copy TEXT;*/