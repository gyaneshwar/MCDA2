-- SUM(`Quantity`) ==> The Sum of Quantities is going to adjust the aggregation of buying and returning a product
-- count(distinct `StockCode`) ==> The count of unique product brought by the customer
-- sum(UnitPrice * Quantity) ==> The Total cost spent by the customer is UnitPrice * Quantity
-- COUNT(distinct `InvoiceNo`) ==> the count of unique invoices can give the number of visits of the Customer
-- PRODUCT_QUANTITY > 0 AND TOTAL_REVENUE > 0 ==> To remove the customer whose purchase quantity is either negative or zero

SELECT 
`CustomerID`, 
SUM(`Quantity`) AS PRODUCT_QUANTITY, 
COUNT(distinct `StockCode`) AS DISTINCT_PRODUCT,
SUM(UnitPrice * Quantity) as TOTAL_REVENUE,
COUNT(distinct `InvoiceNo`) as VISITS
FROM `OnlineRetail` 
wHERE InvoiceNo != 0
GROUP BY CustomerID 
HAVING PRODUCT_QUANTITY > 0 AND TOTAL_REVENUE > 0
ORDER BY TOTAL_REVENUE DESC
LIMIT 2000
