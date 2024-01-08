--ex1: hackerank-revising-the-select-query.
Select NAME 
From CITY
Where population > 120000
And countrycode = 'USA';

--ex2: hackerank-japanese-cities-attributes.
Select * From CITY
where countrycode = 'JPN';

--ex3: hackerank-weather-observation-station-1.
Select city, state From station;

--ex4: hackerank-weather-observation-station-6.
SELECT DISTINCT(CITY)
FROM STATION 
WHERE SUBSTR(CITY, 1, 1) IN ('A', 'E', 'I', 'O', 'U');

--ex5: hackerank-weather-observation-station-7.
Select distinct(city) 
From station
Where RIGHT(city,1) in ('A', 'E', 'I', 'O', 'U')

--ex6: hackerank-weather-observation-station-9.
SELECT DISTINCT(CITY)
FROM STATION 
WHERE SUBSTR(CITY, 1, 1) not IN ('A', 'E', 'I', 'O', 'U');

--ex7: hackerank-name-of-employees.
Select name 
From Employee
Order by name ASC

--ex8: hackerank-salary-of-employees.
Select name
From Employee
Where   salary > 2000
And     months < 10
Order by employee_id ASC

--ex9: leetcode-recyclable-and-low-fat-products.
Select product_id 
From Products
Where   low_fats = 'Y'
And     recyclable = 'Y'

--ex10: leetcode-find-customer-referee.
SELECT name 
FROM customer                                          
WHERE   referee_id <> 2 
OR      referee_id IS NULL;

--ex11: leetcode-big-countries.
Select  name,
        population,
        area
From    World
Where   area >= 3000000
OR      population >=25000000

--ex12: leetcode-article-views.
Select  distinct author_id as id
From    Views
Where   Viewer_id = author_id
Order by author_id   ASC

--ex13: datalemur-tesla-unfinished-part.
SELECT  part ,  
        assembly_step
FROM parts_assembly
WHERE finish_date is NULL;

--ex14: datalemur-lyft-driver-wages.
Select *
From    lyft_drivers
Where   yearly_salary <= 30000
Or      yearly_salary >= 70000

--ex15: datalemur-find-the-advertising-channel.
Select advertising_channel
From    uber_advertising
Where   money_spent > 100000
