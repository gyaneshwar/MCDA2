SELECT
`StockCode`,
SUM(UnitPrice*Quantity) as TOTAL_REVENUE,
COUNT(distinct InvoiceNo) as BASKETS,
COUNT(distinct CustomerID) as DISTINCT_CUSTOMERS,
AVG(UnitPrice*Quantity) as AVERAGE_PRICE
FROM dataset04.OnlineRetail
GROUP BY StockCode
HAVING TOTAL_REVENUE > 0 
ORDER BY TOTAL_REVENUE DESC
LIMIT 2000