--Truy vấn vào bảng [Production].[ProductCategory] để xem công ty đang bán những danh mục sản phẩm nào?
Select * from [Production].[ProductCategory]

--Truy vấn vào bảng [Production].[ProductSubcategory] để xem công ty có những danh mục con nào?
Select * from [Production].[ProductSubcategory]

--Truy vấn vào bảng [Production].[Product] để xem công ty có những sản phẩm nào?
Select * from [Production].[Product]

-- Đây là 3 bảng chứa các thông tin về sản phẩm và có liên kết với nhau qua các khóa ngoại, truy vấn nối 3 bảng để kiểm tra mối quan hệ.
select * 
from [Production].[Product] pp  
join [Production].[ProductSubcategory] pps
on pp.ProductSubcategoryID = pps.ProductSubcategoryID
join [Production].[ProductCategory] ppc
on pps.ProductCategoryID = ppc.ProductCategoryID

-- Truy vấn vào bảng [Person].[Person]
select * from [Person].[Person]

--Truy vấn vào bảng [Sales].[Customer]
select * from [Sales].[Customer]

--Truy vấn bảng Sales.Store

Select * from [Sales].[Store]

--Kiểm tra mối quan hệ giữa 2 bảng [Person].[Person] và [Sales].[Customer]
Select *
from [Sales].[Customer] sc
join [Person].[Person] pp
on sc.PersonID = pp.BusinessEntityID

--Truy vấn kiểm tra mối quan hệ giữa 2 bảng [Sales].[Customer] và [Sales].[Store]
select *
from [Sales].[Customer] sc
join [Sales].[Store] ss
on sc.StoreID = ss.BusinessEntityID

--Truy vấn bảng [Sales].[SalesTerritory]

Select * from [Sales].[SalesTerritory]

--Truy vấn bảng [Person].[CountryRegion]

Select * from [Person].[CountryRegion]

--Truy vấn bảng [Sales].[SalesOrderHeader]

Select * from [Sales].[SalesOrderHeader]

--Truy vấn bảng [Sales].[SalesOrderDetail]

select * from [Sales].[SalesOrderDetail]

--Truy vấn khám phá các bảng và các mối quan hệ
select pp.ProductID,
	   pp.Name,
	   pps.Name,
	   ppc.Name,
	   pp.StandardCost,
	   sso.OrderQty,
	   sso.UnitPrice,
	   Total = sso.OrderQty * sso.UnitPrice
from [Production].[ProductCategory] ppc 
join [Production].[ProductSubcategory] pps on ppc.ProductCategoryID = pps.ProductCategoryID 
join [Production].[Product] pp on pp.ProductSubcategoryID = pps.ProductSubcategoryID
join [Sales].[SalesOrderDetail] sso on pp.ProductID = sso.ProductID
order by pp.ProductID


select * from [Sales].[SalesOrderHeader] ssh join [Sales].[SalesOrderDetail] ssd on ssh.SalesOrderID = ssd.SalesOrderID
where ssh.OnlineOrderFlag = 0

select * from [Sales].[Customer] sc join [Person].[Person] pp on sc.PersonID = pp.BusinessEntityID

select * from [Sales].[SalesTerritory] sst join [Sales].[SalesOrderHeader] ssh on sst.TerritoryID = ssh.TerritoryID

select * from [Sales].[SalesOrderHeader] ssh join [Sales].[Customer] sc on ssh.CustomerID = sc.CustomerID join [Sales].[Store] ss on sc.StoreID = ss.BusinessEntityID

select * from [Sales].[SalesPerson] ssp join [Person].[Person] pp on ssp.BusinessEntityID = pp.BusinessEntityID

select * from [Production].[ProductInventory] ppi join [Production].[Location] pl on ppi.LocationID = pl.LocationID

select * from [Sales].[Customer]  sc join [Sales].[Store] ss on sc.StoreID = ss.BusinessEntityID



-- Có bao nhiêu sản phẩm là do công ty tự sản xuất?
select COUNT(Distinct Name) from Production.Product where MakeFlag = 1

-- Có bao nhiêu sản phẩm là nhập từ công ty khác?
select COUNT(Distinct Name) from Production.Product where MakeFlag = 0

-- Tất cả các ProductID < 679 tại bảng [Production].Product đều không có thông tin về khóa ngoại tham chiếu đến bảng ProductSubcategoryID
select ss.ProductSubcategoryID 
from [Production].Product pp join [Production].ProductSubcategory ss 
on pp.ProductSubcategoryID = ss.ProductSubcategoryID 
where pp.ProductID < 679

-- Tất cả các ProductID < 679 tại bảng Sales.SalesOrderDetail đều không có thông tin về đơn hàng bán
select * from Sales.SalesOrderDetail where ProductID < 679

-- Check những ProductID < 679 xem có thông tin mua hàng hay không?
select * from [Production].[Product] pp join [Purchasing].[PurchaseOrderDetail] ppo on pp.ProductID = ppo.ProductID where pp.ProductID < 679

-- Kiểm tra hàng tồn kho đối với những ProductID < 679
select * from [Production].[ProductInventory] ppi join [Production].[Location] pl on ppi.LocationID = pl.LocationID where ppi.ProductID < 679

--


-- Tính số ngày lưu kho của các mặt hàng ProductID < 679
SELECT 
    ppd.ProductID,
    pp.Name AS ProductName,
    DATEDIFF(day, ppd.ModifiedDate, (select MAX(ModifiedDate) from Purchasing.PurchaseOrderDetail))AS StorageCost
FROM 
    Purchasing.PurchaseOrderDetail ppd
JOIN 
	[Production].[Product] pp
on ppd.ProductID = pp.ProductID
JOIN
	[Production].[ProductInventory] ppi
on pp.ProductID = ppi.ProductID

where pp.ProductSubcategoryID is null

select MAX(ModifiedDate) from Purchasing.PurchaseOrderDetail

select * from [Production].[ProductInventory] where ProductID = 952
---
select * from Production.Product where ProductID = 952
select SUM(OrderQty) from [Sales].[SalesOrderDetail] where ProductID = 952
`
select * from Person.CountryRegion
select * from [Sales].[SalesTerritory]
select * 
from [Sales].[SalesOrderHeader] sso 
join [Sales].[Customer] sc 
on sso.CustomerID = sc.CustomerID
join [Sales].[Store] ss
on sc.StoreID = ss.BusinessEntityID
where sso.OnlineOrderFlag = 0

select * from [Purchasing].[PurchaseOrderHeader] ppo join [Purchasing].[Vendor] pv on ppo.VendorID = pv.BusinessEntityID

select * from [Purchasing].[PurchaseOrderHeader] ppo join [Person].[Person] pp on ppo.EmployeeID = pp.BusinessEntityID

select * from [Purchasing].[PurchaseOrderDetail] order by ProductID
select SUM(OrderQty) from Sales.SalesOrderDetail where ProductID = 712

select * from [Sales].[SalesOrderHeader]

select * from [Sales].[SalesPerson]

UPDATE [Person].[Person]
SET Title = 'Ms.'
WHERE Title	is null and BusinessEntityID > 10000

select * from [Production].[Culture]

select * from Sales.Customer sc join Person.Person pp on sc.PersonID = pp.BusinessEntityID join [HumanResources].[Employee] he on pp.BusinessEntityID = he.BusinessEntityID

select * from [Sales].[SalesPerson] ss join [Sales].[SalesOrderHeader] so on ss.BusinessEntityID = so.SalesPersonID 

Select * from [Purchasing].[ProductVendor]

select * from [Sales].[SpecialOffer]

select * from [Sales].[Store]