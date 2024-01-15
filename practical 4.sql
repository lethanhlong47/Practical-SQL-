--ex1: datalemur-laptop-mobile-viewership.
SELECT 
  SUM(CASE WHEN device_type = 'laptop' THEN 1 
      END) AS laptop_views, 
  SUM(CASE WHEN device_type IN ('tablet', 'phone') THEN 1 
      END) AS mobile_views 
FROM viewership;

--ex2: datalemur-triangle-judgement.
Select x,y,z,
    CASE
        When    x + y > z 
            and x + z > y 
            and y + z > x 
        Then 'Yes'
        Else 'No'
    END as triangle
From Triangle
Group by x,y,z

--ex3: datalemur-uncategorized-calls-percentage.
SELECT 
  ROUND(100.0 * 
    COUNT(case_id)/
      (SELECT COUNT(*) FROM callers),1) AS uncategorised_call_pct
FROM callers
WHERE call_category IS NULL 
  OR call_category = 'n/a';

--ex4: datalemur-find-customer-referee.
SELECT name
FROM Customer
WHERE COALESCE(referee_id,0) <> 2;

--ex5: stratascratch the-number-of-survivors.
select survived,
    Sum(Case
     When pclass = 1 Then pclass else 0
    END) as first_class,
    Sum(Case
     When pclass = 2 Then pclass else 0
    END) as second_class,
    Sum(Case
     When pclass = 3  Then pclass else 0
    END) as third_class
from titanic
Group by survived;
