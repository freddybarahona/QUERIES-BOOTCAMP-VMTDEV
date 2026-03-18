DECLARE @PAGE_NUMBER INT = 3;
DECLARE @ROWS_PER_PAGE INT = 10;

SELECT * FROM salesLT.ProductCategory
ORDER BY Name
offset (@PAGE_NUMBER - 1) * @ROWS_PER_PAGE ROWS
FETCH NEXT @ROWS_PER_PAGE ROWS only;

SELECT * FROM SalesLT.ProductCategory
ORDER BY Name DESC

--------------LIKE------------------
SELECT * FROM SalesLT.Customer
WHERE FirstName LIKE '%R%';

SELECT * FROM SalesLT.Customer
WHERE FirstName = 'ROBERT';

--------------BETWEEN----------------
SELECT FirstName, LastName, ModifiedDate FROM SalesLT.Customer
WHERE ModifiedDate between '2006-01-01' AND '2007-01-01';

------------COUNT---------------------
SELECT COUNT(*) AS total_customers FROM SalesLT.Customer

SELECT SUM(TotalDue) AS total_ventas FROM SalesLT.SalesOrderHeader

SELECT * FROM SalesLT.Product p
INNER JOIN SalesLT.ProductCategory pc
	ON p.ProductCategoryID = pc.ProductCategoryID

SELECT * FROM SalesLT.SalesOrderHeader soh
INNER JOIN SalesLT.Customer c
	ON c.CustomerID = soh.CustomerID