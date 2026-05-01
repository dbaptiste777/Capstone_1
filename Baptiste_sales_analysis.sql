-- This Analysis Is For The Connecticut Sales Territory --
Sales Manager: Ellen Lemon
Region: East


The sales manager for your assigned territory wants to know:

1. What is total revenue overall for sales in the assigned territory, plus the start date and end date
that tell you what period the data covers?

SELECT SUM(sale_amount)
FROM sample_sales.store_sales
WHERE store_id BETWEEN 865 AND 872;

-- Total Revenue For Overall Sales $2,392,222.44 --

 
SELECT transaction_date
FROM sample_sales.store_sales
WHERE store_id BETWEEN 865 AND 872;
-- Start Date and End Date 1/1/2022-12/31/2025 --


2.  What is the month by month revenue breakdown for the sales territory?

SELECT YEAR(transaction_date)  AS sales_year,
MONTH(transaction_date) AS sales_month,
SUM(sale_amount) AS monthly_sales
FROM sample_sales.store_sales
WHERE store_id BETWEEN 865 AND 872
GROUP BY
YEAR(transaction_date),
MONTH(transaction_date)
ORDER BY
Sales_year,
Sales_month;

3.  Provide a comparison of total revenue for the specific sales territory and the region it belongs to.

SELECT 'NY' AS region, SUM(sale_amount) AS total_sales
FROM sample_sales.store_sales
WHERE store_id BETWEEN 840 AND 851
UNION ALL
SELECT 'CT', SUM(sale_amount)
FROM sample_sales.store_sales
WHERE store_id BETWEEN 865 AND 872;

4.  What is the number of transactions per month and average transaction size by product category
for the sales territory?

SELECT YEAR(transaction_date) AS year, 
MONTH(transaction_date) AS month,
COUNT(transaction_date) AS "transaction_size"
FROM sample_sales.store_sales
WHERE store_id BETWEEN 865 AND 872
GROUP BY
YEAR(transaction_date),
Month(transaction_date);

SELECT 
YEAR(SS.Transaction_Date) AS Year,
MONTH(SS.Transaction_Date) AS Month,
IC.category,
COUNT(*) AS NumberOfTransactions,
ROUND(AVG(SS.Sale_Amount), 2) AS AverageTransactionSize
FROM store_sales SS
JOIN products P
ON SS.prod_num = P.ProdNum
JOIN store_locations SL
ON SL.storeid = SS.store_id
JOIN inventory_categories IC
ON P.Categoryid = IC.Categoryid
WHERE SL.State = 'Connecticut'
GROUP BY 
YEAR(SS.Transaction_Date),
MONTH(SS.Transaction_Date),
IC.category
ORDER BY 
Year,
Month,
IC.category;


5.  Can you provide a ranking of in-store sales performance by each store in the sales territory, or a
ranking of online sales performance by state within an online sales territory?

SELECT SUM(SS.sale_amount) AS total_sales,
SL.storelocation
FROM sample_sales.store_sales AS SS
JOIN store_locations AS SL
ON SL.storeid = SS.store_id
WHERE SS.store_id BETWEEN 865 AND 872
GROUP BY SL.storelocation
ORDER BY total_sales DESC;

6.  What is your recommendation for where to focus sales attention in the next quarter? 

/* As I have been analyzing the sales data for my sales territory (Connecticut) I have noticed a few trends.
I would like to begin by mentioning that our stores have been showing signs of consistent growth over the couse of the sales period.
However, there are a total of eight store locations, and among them, the stores located in Litchfield County, 
Darien, and Old Saybrook have generated less revenue over the three-year sales period compared to our other locations. One possible reason for 
this difference is that the higher-performing locations tend to be in towns with multiple colleges or universities. For example, Bridgeport 
has nine schools and also ranks second in total sales revenue. Based on this data, it suggests that we should place more sales attention 
on areas with fewer schools to help drive performance in those locations. */

