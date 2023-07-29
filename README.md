# cleaning_data_imdb_movie
This project is focus on how to clean the IMDb movies dataset using SQL. Dataset comprises 2000 rows and 12 columns, In the data columns, there are the following attributes Title, Rating, Year, Month, Certificate, Runtime, Director, Stars, Genre, Filming Location, Budget, Income, and Country of Origin. Dataset contains missing values, outliers and inconsistencies.

### 1. Rating 
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

### 2.  Month
There are 2 outlier data in the Month column, which are 2008 and 2014. I will replace the outlier data with "unknown"

```
UPDATE imdb_movies 
SET 
    Month = 'unknown'
WHERE
    Month IN ('2008' , '2014');
```

<!--- ![Untitled](https://github.com/ulumbagas/cleaning_data_imdb_movie/assets/58242856/0366de2f-bba2-4ca2-80d1-e1601720cd9d) --->

<p align="center" width="70%">
    <img width="70%" src="https://github.com/ulumbagas/cleaning_data_imdb_movie/assets/58242856/0366de2f-bba2-4ca2-80d1-e1601720cd9d"> 
</p>

### 3. Filming location
Film location column contains inconsistent data and noise, such as "UK" and "United Kingdom", as well as "Official Facebook" which does not indicate a specific location. Next, "Official Facebook" will be replaced with "Unknown", "The Netherland" will be replaced with "Netherlands", and "UK" will be replaced with "United Kingdom".

```
UPDATE imdb_movies
SET
    Filming_location = 
    CASE 
        WHEN Filming_location = 'The Netherlands' THEN 'Netherlands'
        WHEN Filming_location = 'Official Facebook' THEN 'unknown'
        WHEN Filming_location = 'UK' THEN 'United Kingdom'
        ELSE Filming_location
    END;
```

### 4. Budget
In the "budget" column, there are nominal film production costs, but there is also data such as "Unknown" and various currencies like Dollar, Euro, Rupee, and others.
<!--- isi gambar dari ini
select Budget from imdb_movies
where left(Budget,1) != '$' AND Budget != 'Unknown' ; --->

The initial step is to clean unnecessary characters, such as spaces and commas, and replace "Unknown" with 0. I changed "Unknown" to 0 because later I will change the data type to BIGINT.
```
UPDATE imdb_movies 
SET 
    Budget = REPLACE(REPLACE(REPLACE(TRIM(Budget), ',', ''), ' ', ''), 'Unknown', '0');

```
Next, the currency will be converted into dollars using the following code:
