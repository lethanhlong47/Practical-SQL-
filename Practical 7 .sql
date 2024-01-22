--ex1: datalemur-yoy-growth-rate.
SELECT 
  EXTRACT(year From transaction_date) as year,
  Product_id,
  spend as curr_year_spend,
  Lag(spend) OVER(PARTITION BY product_id 
             ORDER BY EXTRACT(year From transaction_date)) as prev_year_spend,
  ROUND(100 * 
    (spend - Lag(spend) OVER(PARTITION BY product_id 
             ORDER BY EXTRACT(year From transaction_date)))
    / Lag(spend) OVER(PARTITION BY product_id 
             ORDER BY EXTRACT(year From transaction_date))
  , 2) AS yoy_rate 
FROM user_transactions;

--ex2: datalemur-card-launch-success.
With CTE_RANK AS 
(SELECT 
  card_name,
  issue_month,
  issue_year,
  issued_amount,
  RANK() OVER(PARTITION BY card_name ORDER BY issue_year,issue_month) as rank
FROM monthly_cards_issued
)
SELECT
  card_name,
  issued_amount
FROM CTE_RANK 
WHERE rank =1
ORDER BY issued_amount DESC

ex3: datalemur-third-transaction.
With CTE_RANK AS
(SELECT 
  user_id,
  spend,
  transaction_date,
  RANK() OVER(PARTITION BY user_id ORDER BY transaction_date) as rank 
FROM transactions
)
SELECT
  user_id,
  spend,
  transaction_date
FROM CTE_RANK
WHERE rank = 3

--ex4: datalemur-histogram-users-purchases.
WITH CTE_RANK AS
(SELECT 
  product_id,
  user_id,
  spend,
  transaction_date,
  RANK() OVER(PARTITION BY user_id ORDER BY transaction_date DESC) AS rank 
FROM user_transactions
)
SELECT
  transaction_date,
  user_id,
  COUNT(product_id) as purchase_count
FROM CTE_RANK
WHERE rank =1
GROUP BY transaction_date, user_id

--ex5: datalemur-rolling-average-tweets.
  --1
  SELECT
  t1.user_id,
  t1.tweet_date,
  ROUND(AVG(t2.tweet_count), 2) AS rolling_avg_3d
FROM
  tweets t1
LEFT OUTER JOIN
  tweets t2 
ON (t2.tweet_date BETWEEN t1.tweet_date - INTERVAL '2' day AND t1.tweet_date)
  AND t1.user_id = t2.user_id
GROUP BY t1.tweet_date, t1.user_id
ORDER BY
  t1.user_id, t1.tweet_date

--2
SELECT    
  user_id,    
  tweet_date,   
  ROUND(AVG(tweet_count) OVER (
    PARTITION BY user_id     
    ORDER BY tweet_date     
    ROWS BETWEEN 2 PRECEDING AND CURRENT ROW)
  ,2) AS rolling_avg_3d
FROM tweets;

--ex6: datalemur-repeated-payments.

WITH identical_transaction AS (
SELECT transaction_id
  merchant_id, 
  credit_card_id, 
  amount, 
  transaction_timestamp as current_transaction,
  LAG(transaction_timestamp) OVER(PARTITION BY merchant_id, credit_card_id, amount ORDER BY transaction_timestamp) AS previous_transaction
FROM transactions
)

SELECT COUNT(merchant_id) as payment_count
FROM identical_transaction
WHERE current_transaction-previous_transaction <= INTERVAL '10 minutes'

--ex7: datalemur-highest-grossing.
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

--ex8: datalemur-top-fans-rank.
WITH top_10_cte AS (
  SELECT 
    artists.artist_name,
    DENSE_RANK() OVER (
      ORDER BY COUNT(songs.song_id) DESC) AS artist_rank
  FROM artists
  INNER JOIN songs
    ON artists.artist_id = songs.artist_id
  INNER JOIN global_song_rank AS ranking
    ON songs.song_id = ranking.song_id
  WHERE ranking.rank <= 10
  GROUP BY artists.artist_name
)

SELECT artist_name, artist_rank
FROM top_10_cte
WHERE artist_rank <= 5;
