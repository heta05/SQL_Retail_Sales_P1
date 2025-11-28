Select top 10 * from Retail_Sales

Select top 10 Count(*) from Retail_Sales
---
--- Checking Null Values in Data---

Select * From 
Retail_Sales 
where transactions_id IS NULL;

-- Then checked for all other columns in combined -- 
Select * From 
Retail_Sales 
where transactions_id IS NULL
	or sale_date is null
	or sale_time is null
	or customer_id is null
	or gender is null
	or category is null
	or quantiy is null
	or price_per_unit is null	
	or cogs is null	
	or total_sale is null;

---- Now Delete the all the Rows which has null values

Delete from Retail_Sales
where transactions_id IS NULL
	or sale_date is null
	or sale_time is null
	or customer_id is null
	or gender is null
	or category is null
	or quantiy is null
	or price_per_unit is null	
	or cogs is null	
	or total_sale is null;

Select * from Retail_Sales

----- DATA Exploration ----

---- 1.How many sales we have ? --- 
Select Count(*) AS toatal_sales from Retail_Sales

--- 2.How Many unique Customer we have ?---
Select Count(distinct customer_id) AS toatal_customers from Retail_Sales

--- 3.How Many unique category we have ?

Select distinct category AS Category_Name from Retail_Sales

--- Data Analysis & Business Key Problems & Answers --

-- My Analysis & Findings

-- Q.1 Write a SQL query to retrieve all columns for sales made on '2022-11-05

Select * from Retail_Sales
where sale_date = '2022-11-05'

-- Q.2 Write a SQL query to retrieve all transactions where the category is 'Clothing' and the quantity sold is more than 3 in the month of Nov-2022

SELECT *
FROM Retail_Sales
WHERE category = 'Clothing'
  AND quantiy > 3
  AND YEAR(sale_date) = 2022
  AND MONTH(sale_date) = 11;

--Q.3 Write a SQL query to calculate the total sales (total_sale) for each category.

select category,Sum(total_sale) As Total_sale
From Retail_Sales
group by category;

-- Q.4 Write a SQL query to find the average age of customers who purchased items from the 'Beauty' category.

Select avg(age) AS AVG_Age_of_Customers 
from Retail_Sales 
where category = 'Beauty'

-- Q.5 Write a SQL query to find all transactions where the total_sale is greater than 1000.

select * from Retail_Sales
where total_sale > 1000;

-- Q.6 Write a SQL query to find the total number of transactions (transaction_id) made by each gender in each category.

select gender, category,count(transactions_id) As total_Transaction from Retail_Sales
group by gender,category
order by gender,category;

-- Q.7 Write a SQL query to calculate the average sale for each month. Find out best selling month in each year

Select month(sale_date) AS Month, Avg(total_sale) AS Avg_sale from Retail_Sales group by MONTH(sale_date) order by Month;

WITH MonthlySales AS (
    SELECT 
        YEAR(sale_date) AS Year,
        DATENAME(MONTH, sale_date) AS MonthName,
        AVG(total_sale) AS AVG_Monthly_Sale
    FROM Retail_Sales
    GROUP BY YEAR(sale_date), DATENAME(MONTH, sale_date)
)

SELECT *
FROM MonthlySales m
WHERE AVG_Monthly_Sale = (
    SELECT MAX(AVG_Monthly_Sale)
    FROM MonthlySales
    WHERE Year = m.Year
)
ORDER BY Year;

-- Q.8 Write a SQL query to find the top 5 customers based on the highest total sales 
Select top 5 customer_id,sum(total_sale) As Total_Sale
From Retail_Sales
group by customer_id
order by sum(total_sale) desc;

-- Q.9 Write a SQL query to find the number of unique customers who purchased items from each category.

Select category, count( distinct customer_id) As Unique_customers
from Retail_Sales
group by category
order by Unique_customers desc;


-- Q.10 Write a SQL query to create each shift and number of orders (Example Morning <=12, Afternoon Between 12 & 17, Evening >17)

SELECT 
    CASE 
        WHEN DATEPART(HOUR, sale_time) < 12 THEN 'Morning'
        WHEN DATEPART(HOUR, sale_time) BETWEEN 12 AND 17 THEN 'Afternoon'
        ELSE 'Evening'
    END AS Shift,
    COUNT(*) AS Total_Orders
FROM Retail_Sales
GROUP BY 
    CASE 
        WHEN DATEPART(HOUR, sale_time) < 12 THEN 'Morning'
        WHEN DATEPART(HOUR, sale_time) BETWEEN 12 AND 17 THEN 'Afternoon'
        ELSE 'Evening'
    END
ORDER BY Total_Orders DESC;






