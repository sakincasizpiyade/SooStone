
ALTER TABLE nyc_sales ALTER COLUMN SALE_PRICE float ---Change the data type of SALE_PRICE


---Calculate Z-Score of Sale Price as normalized entire data set.

WITH cte1
AS
(SELECT AVG(SALE_PRICE) as mean, STDEV(SALE_PRICE) as sd
 FROM nyc_sales)
SELECT *, ROUND(ABS(SALE_PRICE - mean) /sd, 3) as sale_price_zscore
FROM nyc_sales, cte1;



---Calculate Z-Score of Sale Price as normalized based on BUILDING_CLASS_CATEGORY and  NEIGHBORHOOD


WITH cte2
AS
(SELECT BUILDING_CLASS_CATEGORY, NEIGHBORHOOD, AVG(SALE_PRICE) as mean, STDEV(SALE_PRICE) AS sd
 FROM nyc_sales
 GROUP BY BUILDING_CLASS_CATEGORY, NEIGHBORHOOD )
SELECT n.BUILDING_CLASS_CATEGORY, n.NEIGHBORHOOD, SALE_PRICE, ROUND(ABS(SALE_PRICE - mean) /NULLIF(sd,0),3) AS sale_price_zscore_neighborhood,
       LAND_SQUARE_FEET/NULLIF(TOTAL_UNITS,0) AS square_ft_per_unit, ROUND(SALE_PRICE/NULLIF(TOTAL_UNITS,0),3) AS price_per_unit
FROM nyc_sales n INNER JOIN cte2
   ON n.BUILDING_CLASS_CATEGORY = cte2.BUILDING_CLASS_CATEGORY AND n.NEIGHBORHOOD = cte2.NEIGHBORHOOD


---Columns Square Feet Per Unit and Price Per Unit.


SELECT LAND_SQUARE_FEET/NULLIF(TOTAL_UNITS,0) AS square_ft_per_unit, ROUND(SALE_PRICE/NULLIF(TOTAL_UNITS,0),3) AS price_per_unit
FROM nyc_sales;


SELECT *
FROM nyc_sales;