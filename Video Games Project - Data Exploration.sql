/*
VIDEO GAME SALES DATA EXPLORATION 

SKILLS USED: CTE's, Windows Functions, Aggregate Functions

*/

-- TOP 10 GAMES BY GLOBAL SALES--
Select *
From vgsales;

Select row_number() over(order by Global_Sales desc) as `Rank`, 
`Name`, Global_sales, Platform
From vgsales
Order by Global_Sales desc
Limit 10;

-- COMPARE AVG SALES IN AMERICA, JAPAN AND EUROPE BY GENRE OR PLATFORM--
Select Platform, round(avg(NA_sales), 2), round(avg(EU_sales),2), round(avg(JP_sales),2)
From vgsales
Group by Platform;

-- SALES TRENDS OVER THE YEARS--
Select `Year`, Round(sum(Global_Sales), 2) as Total_Global_sales
From Vgsales
Group by `Year`
Order by 1 asc;

-- CALCULATING TOTAL SALES PER GENRE
With Genre_sales as (
Select Genre, 
Round(Sum(Global_sales), 2) as Total_Global_sales,
Round(Sum(Other_sales), 2) as Total_other_sales,
Round(Sum(JP_sales), 2) as Toatal_JP_sales,
Round(Sum(EU_sales), 2) as Total_EU_sales,
Round(Sum(NA_sales), 2) as Total_NA_sales
From vgsales 
Group by Genre
)
Select *
From Genre_sales
Order by 2 desc;

-- TOP 3 GAMES WITH THE HIGHEST SALES YEARLY WITH THEIR RANK EACH YEAR
With Yearly_cte as (
Select Row_number() Over(partition by `Year` order by Global_sales) as Sales_Rank,
`Year`,
`Name`,
Global_sales
From Vgsales
)
Select *
From Yearly_cte
Where Sales_rank <= 3
Order by 2, 4;

-- TOP 10 PUBLISHERS WITH HIGHEST NUMBER OF TOP-SELLING GAMES
Select Publisher, count(*) as Game_count
From vgsales
Group by Publisher
Order by 2 desc
Limit 10;
