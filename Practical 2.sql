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
SELECT  card_name,
        MAX(issued_amount)-MIN(issued_amount) as soluong
FROM monthly_cards_issued
GROUP BY card_name
ORDER BY MAX(issued_amount)-MIN(issued_amount) DESC;

--ex8: datalemur-non-profitable-drugs.
SELECT
  manufacturer,
  COUNT(drug) AS drug_count, 
  SUM(cogs - total_sales) AS total_loss
FROM pharmacy_sales
WHERE cogs > total_sales
GROUP BY manufacturer
ORDER BY total_loss DESC;

--ex9: leetcode-not-boring-movies.
Select *
From Cinema
Where id%2 <>0
And description not like '%boring%'
Order by id DESC

--ex10: leetcode-number-of-unique-subject.
Select  teacher_id,
        count(distinct subject_id) as cnt
From Teacher
group by teacher_id

--ex11: leetcode-find-followers-count.
Select  user_id,
        count(follower_id) as followers_count
From Followers
Group by user_id

--ex12:leetcode-classes-more-than-5-students.
Select class
From Courses
Group by class
Having count(student) >=5
