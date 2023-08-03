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

```
UPDATE imdb_movies 
SET 
    Certificate = null
WHERE
    Certificate = '';
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
In the Budget column there are nominal film production costs, but there is also data such as "Unknown" and various currencies like Dollar, Euro, Rupee, and others. The first step is to clean unnecessary characters, such as spaces and commas, and replace "Unknown" with 0. I changed "Unknown" to 0 because I will later change the data type to BIGINT.

created a new column called "Budget_USD."
```
ALTER TABLE imdb_movies
ADD COLUMN Budget_USD TEXT
```

TRIM() function is used to remove leading and trailing spaces
```
UPDATE imdb_movies 
SET 
    Budget_USD = TRIM(Budget_USD);
```
Replace "unknown" with 0 and delete comma
```
UPDATE imdb_movies
SET Budget_USD = CASE
	WHEN Budget_USD = 'Unknown' THEN 0
    ELSE REPLACE(Budget_USD, ',', '')
END;
```
delete unnecessary currency symbol
```
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
```

changing the data type of the "budget" column to BIGINT
```
ALTER TABLE `cleaning_table`.`imdb_movies` 
CHANGE COLUMN `Budget_USD` `Budget_USD` BIGINT NULL DEFAULT NULL ;
```

convert all currencies to USD
```
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

```
After cleaning unnecessary symbols and converting currencies, this is the result

<!--- ![image](https://github.com/ulumbagas/cleaning_data_imdb_movie/assets/58242856/14c0b6e5-44ed-4c4f-80c4-800a7b398b93) --->

<p align="center" width="35%">
    <img width="35%" src="https://github.com/ulumbagas/cleaning_data_imdb_movie/assets/58242856/14c0b6e5-44ed-4c4f-80c4-800a7b398b93"> 
</p>

### 5. Income
Income refers to the total amount of money earned or generated by a film through various revenue streams, such as box office ticket sales, DVD and Blu-ray sales, and more. In this coloumn i found outlier data such as “unknown” and I replace it with 0. I change Income type data to BIGINT.

replace "Unknown" with 0
```
UPDATE imdb_movies 
SET 
    income = '0'
WHERE
    income = 'Unknown';
```
TRIM() function
```
UPDATE imdb_movies 
SET 
    income = TRIM(income);
```
delete unnecessary symbol
```
UPDATE imdb_movies 
SET 
    income = REPLACE(income, ',', '');

UPDATE imdb_movies 
SET 
    income = REPLACE(income, '$', '')
where income like '%$%';
```

change Incone type data to BIGINT
```
ALTER TABLE `cleaning_table`.`imdb_movies` 
CHANGE COLUMN `Income` `Income` BIGINT NULL DEFAULT NULL;
```
After cleaning unnecessary symbols and changing the data type of the “Income" column to BIGINT. This is the result

<!--- ![image](https://github.com/ulumbagas/cleaning_data_imdb_movie/assets/58242856/0354b8d5-5ca4-406b-9117-544d09cef177)
 --->
 <p align="center" width="35%">
    <img width="35%" src="https://github.com/ulumbagas/cleaning_data_imdb_movie/assets/58242856/0354b8d5-5ca4-406b-9117-544d09cef177"> 
</p>
