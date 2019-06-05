SELECT
`StockCode`,
SUM(UnitPrice*Quantity) as TOTAL_REVENUE,
COUNT(distinct InvoiceNo) as BASKETS,
COUNT(distinct CustomerID) as DISTINCT_CUSTOMERS,
ROUND(SUM(Quantity)/COUNT(distinct CustomerID), 2) as QUANTITY_PER_CUSTOMER
FROM dataset04.OnlineRetail
GROUP BY StockCode
ORDER BY TOTAL_REVENUE DESC
LIMIT 2000