select * from DIM_ProductCategory
select * from DIM_ProductSubcategory
select * from DIM_Product
select * from DIM_SalesTerritory
select * from DIM_SalesPerson
select * from DIM_Store
select * from DIM_Customer
select * from [dbo].[FACT_SalesOrderHeader]
select * from FACT_SalesOrderDetail


Select soh.SalesOrderID,
		sod.SalesOrderDetailID,
		sod.OrderQty,
		sod.UnitPrice,
		soh.OrderDate,
		soh.CustomerID

from FACT_SalesOrderDetail sod 
join [dbo].[FACT_SalesOrderHeader] soh 
on sod.SalesOrderID = soh.SalesOrderID
where soh.OrderMethod = 'Reseller'

Select soh.SalesOrderID,
		sod.SalesOrderDetailID,
		sod.OrderQty,
		sod.UnitPrice,
		soh.OrderDate,
		soh.CustomerID

from FACT_SalesOrderDetail sod 
join [dbo].[FACT_SalesOrderHeader] soh 
on sod.SalesOrderID = soh.SalesOrderID
where soh.OrderMethod = 'Online'