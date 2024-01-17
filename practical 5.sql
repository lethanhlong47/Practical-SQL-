ex1: hackerrank-average-population-of-each-continent.
  Select 
    COUNTRY.Continent,
    Floor(avg(CITY.Population))
From CITY JOIN COUNTRY ON CITY.CountryCode = COUNTRY.Code
Group by COUNTRY.Continent

--ex2: datalemur-signup-confirmation-rate.
SELECT 
  ROUND(SUM(CASE WHEN t.signup_action = 'Confirmed' THEN 1 ELSE 0 END) :: Decimal
  / COUNT(t.signup_action),2)
FROM emails e LEFT JOIN texts t  
ON e.email_id  = t.email_id

--ex3: datalemur-time-spent-snaps.
SELECT 
  age_breakdown.age_bucket, 
  ROUND(100.0 * 
    SUM(activities.time_spent) FILTER (WHERE activities.activity_type = 'send')/
      SUM(activities.time_spent),2) AS send_perc, 
  ROUND(100.0 * 
    SUM(activities.time_spent) FILTER (WHERE activities.activity_type = 'open')/
      SUM(activities.time_spent),2) AS open_perc
FROM activities
INNER JOIN age_breakdown  
  ON activities.user_id = age_breakdown.user_id 
WHERE activities.activity_type IN ('send', 'open') 
GROUP BY age_breakdown.age_bucket;

--ex4: datalemur-supercloud-customer.
SELECT 
  customer_contracts.customer_id
FROM 
  customer_contracts 
LEFT JOIN 
  products 
  ON customer_contracts.product_id = products.product_id
GROUP BY 
  customer_contracts.customer_id
HAVING 
  COUNT(DISTINCT products.product_category) = 3;

--ex5: leetcode-the-number-of-employees-which-report-to-each-employee.
Select  Employees.employee_id, 
        Employees.name,
        count(report.reports_to) as reports_count,
        round(avg(report.age)) as average_age
from Employees join Employees as report on Employees.employee_id = report.reports_to
Group by Employees.employee_id,Employees.name
order by Employees.employee_id asc

--ex6: leetcode-list-the-products-ordered-in-a-period.
Select  products.product_name,
        sum(Orders.unit) as unit
from products join orders on products.product_id = Orders.product_id
Where     order_date BETWEEN '2020-02-01' AND '2020-02-29'
group by products.product_name
Having unit >=100

-- ex7: leetcode-sql-page-with-no-likes.
SELECT page_id
FROM pages
EXCEPT
SELECT page_id
FROM page_likes

------------------------------------------------------------------
--Mid course test
--Q1
Select  
	Distinct replacement_cost
From film
Order by replacement_cost ASC
Limit 1

--Q2
Select 
	count(*)
From film
Where (Case
		When replacement_cost between 9.99 and 19.99 Then 'low'
		When replacement_cost between 20.00  and 24.99 Then 'medium'
		When replacement_cost between 25.00  and 29.99 Then 'high'
	End ) = 'low'

--Q3
Select 	title,
		length,
		name
From film 	join public.film_category on film.film_id = film_category.film_id 
			join public.category on public.film_category.category_id=category.category_id
Where name in ('Drama' , 'Sports')
Order by length DESC
  
--Q4
Select 	count(distinct title),
		category.category_id,
		name
From 
film 	join public.film_category 
			on film.film_id = film_category.film_id 
		join public.category 
			on public.film_category.category_id=category.category_id
group by category.category_id
order by count(distinct title) Desc

--Q5
Select 	actor.actor_id,
		first_name,
		last_name, 
		count(film_actor.film_id)
From actor join film_actor on actor.actor_id = film_actor.actor_id
group by actor.actor_id
Order by count( film_actor.film_id) DESC
			
--Q6
Select customer.address_id, address
From 
address left join public.customer on customer.address_id = address.address_id
Where customer.address_id is null

--Q7
Select city.city_id,city.city, sum(payment.amount)
From
City join address on City.city_id = address.city_id
	join customer on address.address_id = customer.address_id
	join payment  on customer.customer_id = payment.customer_id
group by city.city_id
Order by sum(payment.amount) DESC

--Q8
Select city || ', ' || country as "city,country",
 sum(payment.amount)
From 
city join country on city.country_id = country.country_id
     join address on City.city_id = address.city_id
	 join customer on address.address_id = customer.address_id
	 join payment  on customer.customer_id = payment.customer_id
group by city,country
Order by sum(payment.amount) DESC
