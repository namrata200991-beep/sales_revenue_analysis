# Sales & Revenue Performance Analysis

## Project Overview

## Dataset

The dataset contains transactional sales information including order dates, customers, products, categories, sub-categories, regions, cities, customer segments, sales, profit, and discount.

The analysis is performed at the transaction level using PostgreSQL, with Power BI used to create an interactive business dashboard.

## Power BI Dashboard

![Sales Revenue Dashboard](powerbi/Sales_dashboard.png)

An interactive Power BI dashboard was created to provide a consolidated view of sales and profitability performance.

### Dashboard Components

**KPI Cards**

* Total Sales
* Total Profit
* Total Orders
* Profit Margin

**Visual Analysis**

* Monthly Sales & Profit Trend
* Sales & Profit by Category
* Sales & Profit by Region
* Profit by Sub-category

**Interactive Filters**

* Date
* Category
* Region

The dashboard allows users to filter the analysis dynamically and evaluate how sales and profitability change across different time periods, categories, and regions.

The project combines **PostgreSQL** for data analysis and **Power BI** for interactive dashboard development.

## Objectives

* Analyze overall sales and profit performance
* Identify high-value and high-profit customers
* Evaluate product and sub-category profitability
* Compare regional and city-level performance
* Analyze sales and profit across customer segments
* Identify areas with high sales but low profitability
* Build an interactive Power BI dashboard for business reporting

## Tools Used

* PostgreSQL
* SQL
* Power BI
* DAX
* GitHub

```markdown
## Project Structure

```text
sales_revenue_analysis/
│
├── data/
│   └── sales_revenue_analysis_cleaned.csv
│
├── sql/
│   └── sales_analysis.sql
│
├── powerbi/
│   ├── sales_revenue_analysis.pbix
│   └── Sales_dashboard.png
│
└── README.md

## SQL Analysis

The SQL analysis was performed using PostgreSQL to evaluate sales, profitability, customer performance, product performance, and regional trends.

### Key Analysis Areas

* Monthly sales and month-over-month performance
* Top customers by sales and profitability
* Average order value by customer
* Top-performing products by sales
* Product-level profit margin
* Regional sales and profitability
* Top cities by sales
* High-sales, low-margin cities
* Sub-category profitability
* Most profitable sub-category within each category
* Segment-level sales and profitability
* Lowest-profit customer segment by region

### SQL Concepts Used

* GROUP BY
* Aggregate functions such as `SUM()`, `COUNT()`
* COUNT(DISTINCT ...)
* ROUND()
* ORDER BY
* LIMIT
* Common Table Expressions (CTEs)
* Window functions
* RANK()
* PARTITION BY
* Conditional filtering

## Key Business Insights

* Evaluated overall sales and profitability to understand business performance.
* Identified the strongest and weakest-performing categories and sub-categories based on sales, profit, and profit margin.
* Analyzed monthly sales performance and month-over-month growth to identify changes in business performance over time.
* Identified high-value customers based on revenue, profitability, order frequency, and average order value.
* Analyzed regional and city-level performance to identify locations with strong sales but relatively lower profitability.
* Examined loss-making transactions and products to identify potential areas for profitability improvement.
* Compared customer segments across regions to identify the most profitable segments.

## Skills Demonstrated

* SQL data analysis
* PostgreSQL
* Data aggregation and KPI analysis
* CTEs and window functions
* Profitability and margin analysis
* Customer and product analysis
* Geographic and segment analysis
* Power BI dashboard development
* DAX
* Business insight generation

## Project Workflow

Raw Sales Data → PostgreSQL → SQL Analysis → Business Insights → Power BI Dashboard

