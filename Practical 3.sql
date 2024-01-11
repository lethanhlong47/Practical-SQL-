--ex1: hackerrank-more-than-75-marks.
Select 
        name
From STUDENTS
Where Marks > 75
Order by Right(name,3), id ASC

--ex2: leetcode-fix-names-in-a-table.
Select  user_id,
        Concat( Upper(Left(name,1)),
        Lower(Right(name,Length(name)-1))) as name
From Users
Order by user_id

--ex3: datalemur-total-drugs-sales.
SELECT 
        manufacturer,
        '$' || Round(SUM(Total_sales)/1000000,0) || ' ' || 'million' as sale
FROM pharmacy_sales
GROUP BY manufacturer
ORDER BY Round(SUM(Total_sales)) DESC, manufacturer

--ex4: avg-review-ratings.
SELECT 
        EXTRACT(month from submit_date) AS mth,
        product_id,
        Round(AVG(stars),2) as avg_stars
FROM reviews
GROUP BY EXTRACT(month from submit_date), Product_id
ORDER BY mth, product_id;

--ex5: teams-power-users.
SELECT 
  sender_id,
  COUNT(message_id) as message_count
FROM messages
WHERE EXTRACT(month from sent_date) = '08'
And EXTRACT(year from sent_date) = '2022'
GROUP BY sender_id
ORDER BY message_count DESC
LIMIT 2

--ex6: invalid-tweets.
Select tweet_id
From Tweets
Where length(content) > 15

--ex7: user-activity-for-the-past-30-days.
Select 
    activity_date as day, 
    count(distinct user_id) as active_users 
From Activity
Where activity_date between date_add('2019-07-27', interval -29 day) and '2019-07-27'
Group by  activity_date

--ex8: number-of-hires-during-specific-time-period.
Select count(id)
From employees
Where extract(day from joining_date) between 1 and 8
And extract(year from joining_date) ='2022';

--ex9: positions-of-letter-a.
Select 
    position('a' in first_name)
From Worker
Where first_name = 'Amitah'

--ex10: macedonian-vintages.
Select substring(title, length(winery)+2,4)
From winemag_p2
Where country = 'Macedonia'
