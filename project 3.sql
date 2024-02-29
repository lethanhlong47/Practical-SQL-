--1) Doanh thu theo từng ProductLine, Year  và DealSize?
--Output: PRODUCTLINE, YEAR_ID, DEALSIZE, REVENUE
Select * From public.sales_dataset_rfm_prj_clean
Select 
	PRODUCTLINE, 
	YEAR_ID, 
	DEALSIZE, 
	sum(sales) Over(partition by PRODUCTLINE, YEAR_ID, DEALSIZE order by YEAR_ID) as REVENUE
From public.sales_dataset_rfm_prj_clean

--2) Đâu là tháng có bán tốt nhất mỗi năm?
--Output: MONTH_ID, REVENUE, ORDER_NUMBER
with cte_rank as (Select 
	MONTH_ID, 
	year_id,
	COUNT(ordernumber) AS ORDER_NUMBER,
	sum(sales) as REVENUE,
	Rank() Over(partition by year_id order by (sum(sales)) DESC ) as rank
From public.sales_dataset_rfm_prj_clean
group by month_id, year_id)
Select 
	MONTH_ID,
	REVENUE,
	ORDER_NUMBER
From cte_rank 
Where rank =1
 
--3) Product line nào được bán nhiều ở tháng 11?
--Output: MONTH_ID, REVENUE, ORDER_NUMBER
with cte_rank as 
(Select 
 	Productline,
	MONTH_ID, 
	COUNT(ordernumber) AS ORDER_NUMBER,
	sum(sales) as REVENUE
From public.sales_dataset_rfm_prj_clean
Where month_id =11
group by Productline, month_id
Order by COUNT(ordernumber) DESC
)
Select 
	MONTH_ID,
	REVENUE,
	ORDER_NUMBER
From cte_rank 
Limit 1

--4) Đâu là sản phẩm có doanh thu tốt nhất ở UK mỗi năm? 
--Xếp hạng các các doanh thu đó theo từng năm.
--Output: YEAR_ID, PRODUCTLINE,REVENUE, RANK
Select 
	Year_id,
	PRODUCTLINE,
	Sum(sales) as REVENUE,
	RANK() Over( Partition by year_id Order by(Sum(sales)) DESC )
From public.sales_dataset_rfm_prj_clean
Where country = 'UK'
Group by PRODUCTLINE, year_id

--5) Ai là khách hàng tốt nhất, phân tích dựa vào RFM 
--(sử dụng lại bảng customer_segment ở buổi học 23)
CREATE TABLE segment_score
(
    segment Varchar,
    scores Varchar)
Select * From public.segment_score

Select 
	*
From public.sales_dataset_rfm_prj_clean;

With RFM_CTE as (
Select 
	customername,
	current_date - Max(orderdate) as R,
	count(Distinct ordernumber) as F,
	sum(sales) as M
From public.sales_dataset_rfm_prj_clean
Group by customername)
, RFM_SCORE AS (
Select 
	customername,
	ntile(5) Over(Order by R DESC) AS R_Score,
	ntile(5) Over(Order by F) as F_Score,
	ntile(5) Over(Order by M) as M_Score
From RFM_CTE)
, RFM_FINAL AS (
Select 
	customername,
	cast(R_Score as varchar) || cast(F_Score as varchar) || cast(M_Score as varchar) as RFM
From RFM_SCORE)

Select 
	customername,
	RFM,
	segment
From RFM_FINAL a join public.segment_score b on a.RFM =b.scores;
Select 
	segment,
	count(*)
From RFM_SEGMENT
Group by segment