Create database AdventureWork

use AdventureWork
go

-- 1) Create table DIM_ProductCategory
Create table DIM_ProductCategory
(
 ProductCategoryID int not null primary key,
 ProductCategoryName nvarchar(50) not null

 Constraint PK_DIM_ProductCategory primary key(ProductCategoryID)
)
go

-- 2) Create table DIM_ProductSubcategory
Create table DIM_ProductSubcategory
(
 ProductSubcategoryID int not null,
 ProductCategoryID int,
 ProductSubcategoryName nvarchar(50) not null

Constraint PK_DIM_ProductSubcategory primary key(ProductSubcategoryID)
Constraint FK_DIM_ProductSubcategory_to_DIM_ProductCategory foreign key (ProductCategoryID) references DIM_ProductCategory(ProductCategoryID)
)
go

-- 3) Create table DIM_Product
Create table DIM_Product
(
 ProductID int not null,
 ProductSubcategoryID int,
 ProductName nvarchar(50) not null,
 ProductNumber nvarchar(25) not null,
 MakeFlag nvarchar(21) not null, 
 Color nvarchar(15), 
 StandardCost money not null,
 ProductLine nvarchar(8) null,
 Style nvarchar(9) null,
 ListPrice money not null

Constraint PK_DIM_Product primary key(ProductID)
Constraint FK_DIM_Product_to_DIM_ProductSubcategory foreign key (ProductSubcategoryID) references DIM_ProductSubcategory(ProductSubcategoryID)
)
l
go

-- 4) Create table DIM_SalesTerritory
Create TABLE DIM_SalesTerritory
(
    TerritoryID int NOT NULL,
	TerritoryName nvarchar(50) not null,
    CountryRegionCodeID nvarchar(3) NOT NULL,
	Country nvarchar(50) not null,
	Continent nvarchar(50) not null,
    
CONSTRAINT PK_DIM_SalesTerritory PRIMARY KEY (TerritoryID)
    
)
-- 6) Create table DIM_SalesPerSon
CREATE TABLE DIM_SalesPerSon
(
    SalesPerSonID int NOT NULL,    
	TerritoryID int NULL,
	SalesQuota money null,
	Title nvarchar(8),
	FirstName nvarchar(50) not null,
	MiddleName nvarchar(50) null,
	LastName nvarchar(50) not null,
	FullName nvarchar(152),
	Gender Nvarchar(9)
	    
    CONSTRAINT PK_SalesPerSon PRIMARY KEY (SalesPerSonID),    
	CONSTRAINT FK_SalesPerSon_to_DIM_SalesTerritory FOREIGN KEY (TerritoryID) REFERENCES DIM_SalesTerritory(TerritoryID)    
)
Go


-- 5) Create table DIM_Store
CREATE TABLE DIM_Store
(
    StoreID int NOT NULL,
	SalesPerSonID int NULL,
    StoreName nvarchar(50) NOT NULL,    
    CONSTRAINT PK_DIM_Store PRIMARY KEY (StoreID),    
)
Go


-- 6) Create table DIM_Customer
CREATE TABLE DIM_Customer
(
    CustomerID int NOT NULL,
    PersonID int NULL,
	StoreID int NULL,
	TerritoryID int NULL,
	Title nvarchar(8),
	FirstName nvarchar(50) not null,
	MiddleName nvarchar(50) null,
	LastName nvarchar(50) not null,
	FullName nvarchar(152),
	Gender Nvarchar(9)
	    
    CONSTRAINT PK_DIM_Customer PRIMARY KEY (CustomerID),
    CONSTRAINT FK_DIM_Customer_to_DIM_Store FOREIGN KEY (StoreID) REFERENCES DIM_Store(StoreID),
	CONSTRAINT FK_DIM_Customer_to_DIM_SalesTerritory FOREIGN KEY (TerritoryID) REFERENCES DIM_SalesTerritory(TerritoryID)    
)
Go

-- 7) Create table FACT_SalesOrderHeader
CREATE TABLE FACT_SalesOrderHeader
(
    SalesOrderID int NOT NULL,
    CustomerID int NOT NULL,	
	TerritoryID int NULL,
	OrderDate datetime not null,
	DueDate datetime not null,
	ShipDate datetime not null,
	Status tinyint not null,
	OnlineOrderFlag bit not null,	
	OrderMethod nvarchar(8)
	    
    CONSTRAINT PK_FACT_SalesOrderHeader PRIMARY KEY (SalesOrderID),
    CONSTRAINT FK_FACT_SalesOrderHeader_to_DIM_Customer FOREIGN KEY (CustomerID) REFERENCES DIM_Customer(CustomerID),	
	CONSTRAINT FK_FACT_SalesOrderHeader_to_DIM_SalesTerritory FOREIGN KEY (TerritoryID) REFERENCES DIM_SalesTerritory(TerritoryID),   
)
Go


-- 8) Create table FACT_SalesOrderDetail
CREATE TABLE FACT_SalesOrderDetail
(
    SalesOrderID int NOT NULL,
	SalesOrderDetailID int NOT NULL,
    ProductID int NOT NULL,	
	OrderQty smallint not null,
	UnitPrice money not null,
	UnitPriceDiscount money not null,
	LineTotal numeric(38,6) not null	

    CONSTRAINT PK_FACT_SalesOrderDetail PRIMARY KEY (SalesOrderID, SalesOrderDetailID),
    CONSTRAINT FK_FACT_SalesOrderDetail_to_FACT_SalesOrderHeader FOREIGN KEY (SalesOrderID) REFERENCES FACT_SalesOrderHeader(SalesOrderID),
	CONSTRAINT FK_FACT_SalesOrderDetail_to_Dim_Product FOREIGN KEY (ProductID) REFERENCES Dim_Product(ProductID)  
)
Go


