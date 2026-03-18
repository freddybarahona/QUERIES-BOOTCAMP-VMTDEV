--ADVENTURE WORKS											Piensen en el servicio
--1. Total de Clientes.										1.Uso de variables
SELECT COUNT(FirstName) FROM SalesLT.Customer

--2.Total de ventas en el mes de Octubre.					2.Utilizar alias
DECLARE @Dia varchar = '01';
DECLARE @Mes varchar = '06';
DECLARE @Ano varchar = '2008';
--DECLARE @Fecha_ini datetime2 = '2008-06-01';
DECLARE @Fecha_ini datetime2 = '2008-06-01';
DECLARE @Fecha_fin datetime2 = EOMONTH(@Fecha_ini);

SELECT
	SUM(TotalDue) AS TotalVentasOctubre
FROM SalesLT.SalesOrderHeader
	WHERE DueDate BETWEEN @Fecha_ini AND @Fecha_fin

--3.Ordenar las categorias por nombre.						3.Utilizar solo columnas necesarias
SELECT 
	Name,ProductCategoryID
FROM SalesLT.ProductCategory
ORDER BY Name 

--4.Que relacionen cabecera y detalle factura


--5.Implementacion paginacion


--6.Uso de distinct y top



