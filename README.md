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



<!--- ![image](https://github.com/ulumbagas/cleaning_data_imdb_movie/assets/58242856/96374ae5-009f-4d28-9c70-3f29e0927bcc) --->

<p align="center" width="30%">
    <img width="30%" src="https://github.com/ulumbagas/cleaning_data_imdb_movie/assets/58242856/96374ae5-009f-4d28-9c70-3f29e0927bcc"> 
</p>

### 3.  Certificate
Classification or rating given by film rating boards to determine who is suitable to watch the film based on age and the content presented in the movie. There is inconsistent data, which includes “unrated“, “not rated“, and null values. For the data cleaning process, I will convert all these values to “unrated“.

```
UPDATE imdb_movies 
SET 
    Certificate = 'unrated'
WHERE
    Certificate IN ('not rated' , '');
```
<!--- ![image](https://github.com/ulumbagas/cleaning_data_imdb_movie/assets/58242856/5f1ed541-a860-43f8-94f9-3660c27090f7) --->

<p align="center" width="30%">
    <img width="30%" src="https://github.com/ulumbagas/cleaning_data_imdb_movie/assets/58242856/5f1ed541-a860-43f8-94f9-3660c27090f7"> 
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
<!--- ![image](https://github.com/ulumbagas/cleaning_data_imdb_movie/assets/58242856/027dea53-8e1d-4446-91bf-999765713009) --->

<p align="center" width="50%">
    <img width="50%" src="https://github.com/ulumbagas/cleaning_data_imdb_movie/assets/58242856/027dea53-8e1d-4446-91bf-999765713009"> 
</p>

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


