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

select distinct(Certificate) from imdb_movies
order by Certificate; #not rated unrated blanks
