-- ******* 1 Split City State Country into 3 individual columns namely ‘City’, ‘State’, ‘Country’.

-- for that first created a tables city ,state, country

ALTER TABLE orderlist
ADD COLUMN Country VARCHAR(255)

SELECT * FROM orderlist
SELECT citystatecountry , SPLIT_PART(citystatecountry,',',1) FROM orderlist
-- CITY
UPDATE orderlist
SET CITY = SPLIT_PART(citystatecountry,',',1),
	State = SPLIT_PART(citystatecountry,',',2),
	country = SPLIT_PART(citystatecountry,',',3)

ALTER TABLE orderlist
DROP COLUMN citystatecountry


-- *******2. Add a new Category Column using the following mapping as per the first 3 characters in the
-- Product Name Column:
-- a. TEC- Technology
-- b. OFS – Office Supplies
-- c. FUR - Furniture

SELECT * FROM eachorderbreakdown

ALTER TABLE eachorderbreakdown
ADD COLUMN CATEGORY VARCHAR(255)


SELECT productname  , LEFT(productname,3) FROM eachorderbreakdown

UPDATE eachorderbreakdown
SET CATEGORY = CASE WHEN LEFT(productname,3) = 'TEC' THEN 'Technology'
					WHEN LEFT(productname,3) = 'OFS' THEN 'Office Supplies'
					WHEN LEFT(productname,3) = 'FUR' THEN 'Furniture'
				END

-- *******3.Delete the first 4 characters from the ProductName Column.

UPDATE eachorderbreakdown
SET ProductName = substring(ProductName from 5)
WHERE ProductName IS NOT NULL;


-- SOME productname had space in between then replace - with blank
UPDATE eachorderbreakdown
SET productname = REPLACE(productname,'-','')

SELECT productname, LEN('produtname')
FROM eachorderbreakdown

-- *******4.Remove duplicate rows from EachOrderBreakdown table, if all column values are matching*******

-- THIS is way in sql but PostgreSQL the subsequent DELETE statement. PostgreSQL 
-- has a scope limitation that prevents you from referencing a CTE in a DELETE, UPDATE, or INSERT statement
-- that's not immediately following the CTE definition.
-- WITH CTE AS (
--     SELECT *,
--            ROW_NUMBER() OVER (
--                PARTITION BY orderid, productname, discount, sales, profit, quantity, subcategory, category
--                ORDER BY orderid -- You can change the ORDER BY clause if necessary
--            ) AS RN
--     FROM eachorderbreakdown
-- )
-- SELECT *
-- FROM CTE

-- Rather Using this use
DELETE FROM eachorderbreakdown
WHERE (orderid, productname, discount, sales, profit, quantity, subcategory, category) IN (
    SELECT orderid, productname, discount, sales, profit, quantity, subcategory, category
    FROM eachorderbreakdown
    GROUP BY orderid, productname, discount, sales, profit, quantity, subcategory, category
    HAVING COUNT(*) > 1
);


--******* 5.Replace blank with NA in OrderPriority Column in OrdersList table
UPDATE orderlist
SET orderpriority ='Na'
WHERE orderpriority is NULL

SELECT * FROM orderlist 





