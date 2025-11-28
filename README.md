# Retail Sales Analysis SQL Project

## Project Overview

**Project Title**: Retail Sales Analysis  
**Level**: Beginner  
**Database**: `Sql_project_1`

This project is designed to demonstrate SQL skills and techniques typically used by data analysts to explore, clean, and analyze retail sales data. The project involves setting up a retail sales database, performing exploratory data analysis (EDA), and answering specific business questions through SQL queries.

## Objectives

1. **Set up a retail sales database**: Create and populate a retail sales database with the provided sales data.
2. **Data Cleaning**: Identify and remove any records with missing or null values.
3. **Exploratory Data Analysis (EDA)**: Perform basic exploratory data analysis to understand the dataset.
4. **Business Analysis**: Use SQL to answer specific business questions and derive insights from the sales data.

## Project Structure

### 1. Database Setup

- **Database Creation**: The project starts by creating a database named `Sql_project_1`.
- **Table Creation**: A table named `retail_sales` is created to store the sales data. The table structure includes columns for transaction ID, sale date, sale time, customer ID, gender, age, product category, quantity sold, price per unit, cost of goods sold (COGS), and total sale amount.

```sql
CREATE DATABASE p1_retail_db;

Whole Table Creation Process

The entire table was created by importing the CSV file into SQL Server using the Import File option. The steps followed during the import process are documented below:

 - Open SQL Server Management Studio (SSMS) and connect to the database server.

 - Navigate to the desired database, right-click → Tasks → Import Flat File / Import Data.

 - Browse and upload the required .csv file from the system storage.

 - Review the data preview displayed by the wizard to ensure file structure and headers are correct.

 - Map each column and assign appropriate data types (INT, VARCHAR, DATE, FLOAT etc.) as required.

 - Provide the desired table name (Retail_Sales) for storing the imported data.

 - Execute the import by clicking Finish, after which SQL Server automatically generates the table and loads the data.

 - Finally, validate the import using:

SELECT TOP 10 * FROM Retail_Sales;

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
```
## Findings

- **Customer Demographics**: The dataset includes customers from various age groups, with sales distributed across different categories such as Clothing and Beauty.
- **High-Value Transactions**: Several transactions had a total sale amount greater than 1000, indicating premium purchases.
- **Sales Trends**: Monthly analysis shows variations in sales, helping identify peak seasons.
- **Customer Insights**: The analysis identifies the top-spending customers and the most popular product categories.

## Reports

- **Sales Summary**: A detailed report summarizing total sales, customer demographics, and category performance.
- **Trend Analysis**: Insights into sales trends across different months and shifts.
- **Customer Insights**: Reports on top customers and unique customer counts per category.

## Conclusion

This project serves as a comprehensive introduction to SQL for data analysts, covering database setup, data cleaning, exploratory data analysis, and business-driven SQL queries. The findings from this project can help drive business decisions by understanding sales patterns, customer behavior, and product performance.

## How to Use

1. **Clone the Repository**: Clone this project repository from GitHub.
2. **Set Up the Database**: Run the SQL scripts provided in the `database_setup.sql` file to create and populate the database.
3. **Run the Queries**: Use the SQL queries provided in the `analysis_queries.sql` file to perform your analysis.
4. **Explore and Modify**: Feel free to modify the queries to explore different aspects of the dataset or answer additional business questions.

## Author - Hetanshi Gandhi

This project is part of my portfolio, showcasing the SQL skills essential for data analyst roles. If you have any questions, feedback, or would like to collaborate, feel free to get in touch!

### Stay Updated and Join the Community

Thank you for your support, and I look forward to connecting with you!

