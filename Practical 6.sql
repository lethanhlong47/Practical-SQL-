--ex1: datalemur-duplicate-job-listings.
  With CTE_JOBCOUNT AS (
SELECT 
  company_id,
  title,
  description,
  COUNT(job_id)  as j_count
From job_listings 
GROUP BY company_id, title, description)
SELECT 
 COUNT(company_id)
From CTE_JOBCOUNT
Where j_count > 1

--ex2: datalemur-highest-grossing.
WITH rank_cte AS (
  SELECT 
    category, 
    product, 
    SUM(spend) AS total_spend,
    RANK() OVER (
      PARTITION BY category 
      ORDER BY SUM(spend) DESC) AS ranking 
  FROM product_spend
  WHERE EXTRACT(YEAR FROM transaction_date) = 2022
  GROUP BY category, product
)

SELECT 
  category, 
  product, 
  total_spend 
FROM rank_cte 
WHERE ranking <= 2 
ORDER BY category, ranking;

--ex3: datalemur-frequent-callers.
SELECT COUNT(policy_holder_id) AS member_count
FROM (
  SELECT
    policy_holder_id,
    COUNT(case_id) 
  FROM callers
  GROUP BY policy_holder_id
  HAVING COUNT(case_id) > 2
) AS call_records;

--ex4: datalemur-page-with-no-likes.
SELECT page_id
FROM pages
EXCEPT
SELECT page_id
FROM page_likes

--ex5: datalemur-user-retention.
SELECT 
  EXTRACT(MONTH FROM curr_month.event_date) AS mth, 
  COUNT(DISTINCT curr_month.user_id) AS monthly_active_users 
FROM user_actions AS curr_month
WHERE EXISTS (
  SELECT last_month.user_id 
  FROM user_actions AS last_month
  WHERE last_month.user_id = curr_month.user_id
    AND EXTRACT(MONTH FROM last_month.event_date) =
    EXTRACT(MONTH FROM curr_month.event_date - interval '1 month')
)
  AND EXTRACT(MONTH FROM curr_month.event_date) = 7
  AND EXTRACT(YEAR FROM curr_month.event_date) = 2022
GROUP BY EXTRACT(MONTH FROM curr_month.event_date);

--ex6: leetcode-monthly-transactions.
SELECT  DATE_FORMAT(trans_date, '%Y-%m') as month, 
        country, 
        COUNT(id) AS trans_count, 
        SUM(CASE WHEN state = 'approved' THEN 1 ELSE 0 END) AS approved_count,
       SUM(amount) AS trans_total_amount,
       SUM(CASE WHEN state = 'approved' THEN amount ELSE 0 END) AS approved_total_amount
FROM  Transactions
GROUP BY month,country

ex7: leetcode-product-sales-analysis.
  With CTE_RANK AS (
SELECT 
    product_id, 
    year, 
    quantity, 
    price, 
    RANK() OVER(partition by product_id order by year) as rank
FROM Sales
)
Select  
    product_id,
    year as first_year,
    quantity,
    price 
From CTE_RANK
Where rank = 1

--ex8: leetcode-customers-who-bought-all-products.
select customer_id 
from Customer 
group by customer_id
having count(distinct (product_key))=(select count(product_key) from Product )

--ex9: leetcode-employees-whose-manager-left-the-company.
SELECT employee_id
FROM Employees
WHERE salary < 30000
AND manager_id NOT IN (
  SELECT employee_id FROM Employees
)
ORDER BY employee_id;

--
