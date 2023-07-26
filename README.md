# cleaning_data_imdb_movie
This project is focus on how to clean the IMDb movies dataset using SQL. Dataset comprises 2000 rows and 12 columns, In the data columns, there are the following attributes Title, Rating, Year, Month, Certificate, Runtime, Director, Stars, Genre, Filming Location, Budget, Income, and Country of Origin. Dataset contains missing values, outliers and inconsistencies.

# 1. Rating 
In the Rating column, there are null values that I will replace with 'nan' to indicate that the data was originally missing or unknown. While it is possible to replace them with the average or median, one should be cautious of potential bias. Therefore, I prefer to use 'nan' to maintain data integrity.

```
UPDATE imdb_movies 
SET 
    Rating = 'nan'
WHERE
    Rating = '';
```
<!--- ![2  Rating4](https://github.com/ulumbagas/cleaning_data_imdb_movie/assets/58242856/28d83327-c3ec-44cf-aaa4-5e685547912f) --->

<p align="center" width="25%">
    <img width="25%" src="https://github.com/ulumbagas/cleaning_data_imdb_movie/assets/58242856/28d83327-c3ec-44cf-aaa4-5e685547912f"> 
</p>


<br/>

<h1 align="center">Detail coming soon</h1>
