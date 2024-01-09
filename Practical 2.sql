--ex1: hackerrank-weather-observation-station-
Select Distinct(CITY)
From Station
Where ID%2=0

--ex2: hackerrank-weather-observation-station-4.
Select count(city)-count(distinct(city))
From STATION

--ex3: hackerrank-the-blunder.
Select ceil(avg(salary)-avg(replace(salary,0,''))) 
From EMPLOYEES

--ex4: datalemur-alibaba-compressed-mean.
SELECT 
  ROUND(SUM(item_count::DECIMAL*order_occurrences)
    /SUM(order_occurrences),1) AS mean
FROM items_per_order;

--ex5: datalemur-matching-skills.
SELECT candidate_id
FROM candidates
WHERE skill IN ('Python', 'Tableau', 'PostgreSQL')
GROUP BY candidate_id
HAVING COUNT(skill) = 3
ORDER BY candidate_id;

--ex6: datalemur-verage-post-hiatus-1.
SELECT 
	user_id, 
    date(MAX(post_date)) - date(MIN(post_date)) AS days_between
FROM posts
WHERE DATE_PART('year', DATE(post_date)) = 2021  
GROUP BY user_id
HAVING COUNT(post_id)>1;

--ex7: datalemur-cards-issued-difference. 
