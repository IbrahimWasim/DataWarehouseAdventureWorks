.LOGON 192.168.254.128/dbc,dbc; 
DATABASE DB_STG2;

--HR Module

INSERT INTO DB_STG2.Department(DepartmentID,DepartmentName,GroupName)
SELECT DISTINCT  1,Name1,GroupName
FROM DB_STG1.HR;

INSERT INTO DB_STG2.Shift(ShiftID, Name1,StartTime, EndTime)
SELECT DISTINCT  
1,
		CASE WHEN Name2 ='NULL' THEN 'N/A' ELSE Name2 END AS Name2,
		CAST (SUBSTR(StartTime,1,10) AS TIME),
		CAST (SUBSTR(EndTime,1,10) AS TIME)
FROM DB_STG1.HR;

INSERT INTO DB_STG2.Employee(BusinessEntityID, NationalIDNumber,LoginID,
JobTitle,BirthDate, Gender,HireDate,VacationHours,SickLeaveHours)
SELECT DISTINCT  
CASE WHEN BusinessEntityID = 'NULL' THEN -1 ELSE BusinessEntityID END AS BusinessEntityID,
		CASE WHEN NationalIDNumber ='NULL' THEN -1 ELSE NationalIDNumber END AS NationalIDNumber,
		CASE WHEN LoginID = 'NULL' THEN 'N/A' ELSE LoginID END AS LoginID,
		CASE WHEN JobTitle = 'NULL' THEN 'N/A' ELSE JobTitle END AS JobTitle,
		CAST (BirthDate AS DATE FORMAT 'yyyy-mm-dd'),
		CASE WHEN Gender = 'NULL' THEN '-' ELSE Gender END AS Gender,
		CAST (HireDate AS DATE FORMAT 'yyyy-mm-dd'),
		CASE WHEN VacationHours = 'NULL' THEN 0 ELSE VacationHours END AS VacationHours,
		CASE WHEN SickLeaveHours= 'NULL' THEN 0 ELSE SickLeaveHours END AS SickLeaveHours
FROM DB_STG1.HR;

INSERT INTO DB_STG2.EmployeeDepartmentHistory(BusinessEntityID,DepartmentID,StartDate,ShiftID,EndDate)

SELECT DISTINCT
CASE WHEN a.BusinessEntityID = 'NULL' THEN -1 ELSE BusinessEntityID END AS BusinessEntityID,
CASE WHEN b.DepartmentID IS NULL THEN -1 ELSE DepartmentID END AS DepartmentID,
CASE WHEN StartDate = 'NULL' THEN  CAST ('1900-01-01' AS DATE FORMAT 'YYYY-MM-DD') ELSE CAST(a.StartDate AS DATE FORMAT 'YYYY-MM-DD') END AS StartDate,
CASE WHEN c.ShiftID IS NULL THEN -1 ELSE ShiftID END AS ShiftID,
CASE WHEN EndDate = 'NULL' THEN  CAST ('1900-01-01' AS DATE FORMAT 'YYYY-MM-DD') ELSE CAST(EndDate AS DATE FORMAT 'YYYY-MM-DD') END AS EndDate
FROM DB_STG1.HR a
INNER JOIN
 DB_STG2.Department b
ON a.Name1 = b.DepartmentName
INNER JOIN
DB_STG2.Shift c
ON a.Name2 = c.Name1;


--Purchase Module

INSERT INTO DB_STG2.ProductVendor(BusinessEntityID, ProductID, AverageLeadTime,StandardPrice,
LastReceiptCost,LastReceiptDate,MinOrderQty,MaxOrderQty,OnOrderQty,UnitMeasureCode)
SELECT DISTINCT
CASE WHEN BusinessEntityID1 = 'NULL' THEN -1 ELSE BusinessEntityID1 END AS BusinessEntityID1,
CASE WHEN ProductID1 = 'NULL' THEN -1 ELSE ProductID1 END AS ProductID1,
CASE WHEN AverageLeadTime = 'NULL' THEN -1 ELSE AverageLeadTime END AS AverageLeadTime,
CASE WHEN  StandardPrice = 'NULL' THEN -1 ELSE  CAST(StandardPrice AS DECIMAL(4,2)) END AS  StandardPrice,
CASE WHEN  LastReceiptCost = 'NULL' THEN -1 ELSE  CAST(LastReceiptCost AS DECIMAL(4,2)) END AS LastReceiptCost,
CASE WHEN LastReceiptDate = 'NULL' THEN CAST('1900-01-01' AS DATE FORMAT 'YYYY-MM-DD') ELSE CAST(SUBSTR(LastReceiptDate,1,10) AS DATE FORMAT 'YYYY-MM-DD') END AS LastReceiptDate,
CASE WHEN MinOrderQty = 'NULL' THEN -1 ELSE MinOrderQty END AS MinOrderQty,
CASE WHEN MaxOrderQty = 'NULL' THEN -1 ELSE MaxOrderQty END AS MaxOrderQty,
CASE WHEN OnOrderQty = 'NULL' THEN -1 ELSE OnOrderQty END AS OnOrderQty,
CASE WHEN UnitMeasureCode = 'NULL' THEN 'N/A' ELSE CAST(UnitMeasureCode AS CHAR(3)) END AS UnitMeasureCode
FROM DB_STG1.Purchase;

INSERT INTO DB_STG2.PurchaseOrderDetail(PurchaseOrderID, PurchaseOrderDetailID,DueDate,
ProductID, OrderQty,UnitPrice,LineTotal, ReceivedQty,RejectedQty,StockedQty)
SELECT DISTINCT
CASE WHEN PurchaseOrderID1 = 'NULL' THEN -1 ELSE PurchaseOrderID1 END AS PurchaseOrderID,
CASE WHEN PurchaseOrderDetailID = 'NULL' THEN -1 ELSE PurchaseOrderDetailID END AS PurchaseOrderDetailID,
CASE WHEN DueDate = 'NULL' THEN  CAST ('1900-01-01' AS DATE FORMAT 'YYYY-MM-DD') ELSE CAST(SUBSTR(DueDate,1,10) AS DATE FORMAT 'YYYY-MM-DD') END AS DueDate,
CASE WHEN ProductID1 = 'NULL' THEN -1 ELSE ProductID1 END AS ProductID1,
CASE WHEN OrderQty = 'NULL' THEN -1 ELSE OrderQty END AS OrderQty,
CASE WHEN UnitPrice = 'NULL' THEN -1 ELSE CAST(UnitPrice AS DECIMAL(7,2)) END AS UnitPrice,
CASE WHEN LineTotal = 'NULL' THEN -1 ELSE CAST( LineTotal AS DECIMAL(9,2)) END AS  LineTotal,
CASE WHEN ReceivedQty = 'NULL' THEN -1 ELSE ReceivedQty END AS ReceivedQty,
CASE WHEN RejectedQty = 'NULL' THEN -1 ELSE RejectedQty END AS RejectedQty,
CASE WHEN StockedQty = 'NULL' THEN -1 ELSE StockedQty END AS StockedQty
FROM DB_STG1.Purchase;

INSERT INTO DB_STG2.PurchaseOrderHeader(PurchaseOrderID,ShipMethodID,VendorID,
RevisionNumber,Status,EmployeeID,OrderDate,ShipDate,SubTotal,TaxAmt,Freight,TotalDue)
SELECT DISTINCT
CASE WHEN PurchaseOrderID2 = 'NULL' THEN -1 ELSE PurchaseOrderID2 END AS PurchaseOrderID,
CASE WHEN ShipMethodID1 = 'NULL' THEN -1 ELSE ShipMethodID1 END AS ShipMethodID1,
CASE WHEN VendorID = 'NULL' THEN -1 ELSE VendorID END AS VendorID,
CASE WHEN RevisionNumber = 'NULL' THEN -1 ELSE RevisionNumber END AS RevisionNumber,
CASE WHEN Status = 'NULL' THEN -1 ELSE Status END AS Status,
CASE WHEN EmployeeID = 'NULL' THEN -1 ELSE EmployeeID END AS EmployeeID,
CASE WHEN OrderDate = 'NULL' THEN  CAST ('1900-01-01' AS DATE FORMAT 'YYYY-MM-DD') ELSE CAST(SUBSTR(OrderDate,1,10) AS DATE FORMAT 'YYYY-MM-DD') END AS OrderDate,
CASE WHEN ShipDate = 'NULL' THEN  CAST ('1900-01-01' AS DATE FORMAT 'YYYY-MM-DD') ELSE CAST(SUBSTR(ShipDate,1,10) AS DATE FORMAT 'YYYY-MM-DD') END AS ShipDate,
CASE WHEN SubTotal = 'NULL' THEN -1 ELSE CAST(SubTotal AS DECIMAL(9,2)) END AS SubTotal,
CASE WHEN TaxAmt = 'NULL' THEN -1 ELSE CAST(TaxAmt AS DECIMAL(7,2)) END AS TaxAmt,
CASE WHEN Freight = 'NULL' THEN -1 ELSE CAST(Freight AS DECIMAL(7,2)) END AS Freight,
CASE WHEN TotalDue = 'NULL' THEN -1 ELSE CAST(TotalDue AS DECIMAL(9,2)) END AS TotalDue
FROM DB_STG1.Purchase;

INSERT INTO DB_STG2.ShipMethod(ShipMethodID, Name1,ShipBase,ShipRate)
SELECT DISTINCT
CASE WHEN ShipMethodID2 = 'NULL' THEN -1 ELSE ShipMethodID2 END AS ShipMethodID2,
CASE WHEN Name2 = 'NULL' THEN 'N/A' ELSE Name2 END AS Name2, 
CASE WHEN ShipBase = 'NULL' THEN -1 ELSE CAST(ShipBase AS DECIMAL(4,2)) END AS ShipBase,
CASE WHEN ShipRate = 'NULL' THEN -1 ELSE CAST(ShipRate AS DECIMAL(4,2)) END AS  ShipRate
FROM DB_STG1.Purchase;

INSERT INTO DB_STG2.Vendor(BusinessEntityID, AccountNumber, Name1,CreditRating, PreferredVendorStatus,ActiveFlag,PurchasingWebServiceURL)
SELECT DISTINCT
CASE WHEN BusinessEntityID1 = 'NULL' THEN -1 ELSE BusinessEntityID1 END AS BusinessEntityID1,
CASE WHEN AccountNumber = 'NULL' THEN 'N/A' ELSE AccountNumber END AS AccountNumber,
CASE WHEN Name1 = 'NULL' THEN 'N/A' ELSE Name1 END AS Name1,
CASE WHEN CreditRating = 'NULL' THEN -1 ELSE CreditRating END AS CreditRating,
CASE WHEN PreferredVendorStatus = 'NULL' THEN -1 ELSE PreferredVendorStatus END AS PreferredVendorStatus,
CASE WHEN ActiveFlag = 'NULL' THEN -1 ELSE CAST(ActiveFlag AS BYTEINT) END AS ActiveFlag,
CASE WHEN PurchasingWebServiceURL = 'NULL' THEN 'N/A' ELSE PurchasingWebServiceURL END AS PurchasingWebServiceURL
FROM DB_STG1.Purchase;

--Person Module

INSERT INTO DB_STG2.Address
SELECT DISTINCT
CASE WHEN AddressID1 = 'NULL' THEN -1 ELSE AddressID1 END AS AddressID1,
CASE WHEN AddressLine1 IS NULL THEN 'N/A' ELSE AddressLine1 END AS AddressLine1,
CASE WHEN AddressLine2 IS NULL THEN 'N/A' ELSE AddressLine2 END AS AddressLine2,
CASE WHEN City= 'NULL' THEN 'N/A' ELSE City END AS City,
CASE WHEN StateProvinceID1 = 'NULL' THEN -1 ELSE StateProvinceID1 END AS StateProvinceID,
CASE WHEN PostalCode IS NULL THEN 'N/A' ELSE PostalCode END AS PostalCode,
CASE WHEN SpatialLocation IS NULL THEN 'N/A' ELSE SpatialLocation END AS SpatialLocation
FROM DB_STG1.Person;

INSERT INTO DB_STG2.AddressType
SELECT DISTINCT
CASE WHEN AddressTypeID1 = 'NULL' THEN -1 ELSE AddressTypeID1 END AS AddressTypeID,
CASE WHEN Name4 = 'NULL' THEN 'N/A' ELSE Name4 END AS Name4
FROM DB_STG1.Person;

INSERT INTO DB_STG2.BusinessEntity
SELECT DISTINCT
CASE WHEN BusinessEntityID1 = 'NULL' THEN -1 ELSE BusinessEntityID1 END AS BusinessEntityID1
FROM DB_STG1.Person;

INSERT INTO DB_STG2.BusinessEntityAddress
SELECT DISTINCT
CASE WHEN AddressID1 = 'NULL' THEN -1 ELSE AddressID1 END AS AddressID1,
CASE WHEN BusinessEntityID1 = 'NULL' THEN -1 ELSE BusinessEntityID1 END AS BusinessEntityID1,
CASE WHEN AddressTypeID1 = 'NULL' THEN -1 ELSE AddressTypeID1 END AS AddressTypeID
FROM DB_STG1.Person;

INSERT INTO DB_STG2.ContactType
SELECT DISTINCT
CASE WHEN BusinessEntityID1 = 'NULL' THEN -1 ELSE BusinessEntityID1 END AS BusinessEntityID1,
CASE WHEN Name1 = 'NULL' THEN 'N/A' ELSE Name1 END AS Name1
FROM DB_STG1.Person;

INSERT INTO DB_STG2.CountryRegion
SELECT DISTINCT
CASE WHEN CountryRegionCode1 = 'NULL' THEN 'N/A' ELSE CAST(CountryRegionCode1 AS CHAR(4)) END AS CountryRegionCode,
CASE WHEN Name3 = 'NULL' THEN 'N/A' ELSE Name3 END AS Name3
FROM DB_STG1.Person;

INSERT INTO DB_STG2.EmailAddress
SELECT DISTINCT
CASE WHEN BusinessEntityID1 = 'NULL' THEN -1 ELSE BusinessEntityID1 END AS BusinessEntityID1,
CASE WHEN EmailAddressID = 'NULL' THEN -1 ELSE EmailAddressID END AS EmailAddressID,
CASE WHEN EmailAddress = 'NULL' THEN 'N/A' ELSE EmailAddress END AS EmailAddress
FROM DB_STG1.Person;

INSERT INTO DB_STG2.Passwords
SELECT DISTINCT
CASE WHEN BusinessEntityID1 = 'NULL' THEN -1 ELSE BusinessEntityID1 END AS BusinessEntityID1,
CASE WHEN PasswordHash = 'NULL' THEN 'N/A' ELSE PasswordHash END AS PasswordHash,
CASE WHEN PasswordSalt = 'NULL' THEN 'N/A' ELSE PasswordSalt END AS PasswordSalt
FROM DB_STG1.Person;

INSERT INTO DB_STG2.Person
SELECT DISTINCT
CASE WHEN BusinessEntityID1 = 'NULL' THEN -1 ELSE BusinessEntityID1 END AS BusinessEntityID1,
CASE WHEN PersonType = 'NULL' THEN 'N/A' ELSE PersonType END AS PersonType,
CASE WHEN "Title" = 'NULL' THEN 'N/A' ELSE CAST("Title" AS CHAR(4)) END AS "Title",
CASE WHEN FirstName = 'NULL' THEN 'N/A' ELSE FirstName END AS FirstName,
CASE WHEN MiddleName = 'NULL' THEN 'N/A' ELSE MiddleName END AS MiddleName,
CASE WHEN LastName = 'NULL' THEN 'N/A' ELSE LastName END AS LastName,
CASE WHEN Suffix = 'NULL' THEN 'N/A' ELSE CAST(Suffix AS CHAR(5)) END AS Suffix,
CASE WHEN EmailPromotion = 'NULL' THEN -1 ELSE CAST(EmailPromotion AS BYTEINT) END AS EmailPromotion,
CASE WHEN DEMOGRAPHICS = 'NULL' THEN 'N/A' ELSE DEMOGRAPHICS END AS DEMOGRAPHICS
FROM DB_STG1.Person;

INSERT INTO DB_STG2.PhoneNumberType
SELECT DISTINCT
1,
CASE WHEN Name1 = 'NULL' THEN 'N/A' ELSE Name1 END AS Name1
FROM DB_STG1.Person;

INSERT INTO DB_STG2.PersonPhone
SELECT DISTINCT
CASE WHEN a.BusinessEntityID1 = 'NULL' THEN -1 ELSE BusinessEntityID1 END AS BusinessEntityID1,
CASE WHEN a.PhoneNumber = 'NULL' THEN -1 ELSE PhoneNumber END AS PhoneNumber,
CASE WHEN b.PhoneNumberTypeID IS NULL THEN -1 ELSE PhoneNumberTypeID END AS PhoneNumberTypeID
FROM DB_STG1.Person a
INNER JOIN
DB_STG2.PhoneNumberType b
ON a.Name1 = b.Name1;

INSERT INTO DB_STG2.StateProvince
SELECT DISTINCT
CASE WHEN StateProvinceID1 = 'NULL' THEN -1 ELSE StateProvinceID1 END AS StateProvinceID,
CASE WHEN StateProvinceCode IS NULL THEN 'N/A' ELSE StateProvinceCode END AS StateProvinceCode,
--StateProvinceCode,
CASE WHEN CountryRegionCode1 = 'NULL' THEN 'N/A' ELSE CAST(CountryRegionCode1 AS CHAR(6)) END AS CountryRegionCode,
CASE WHEN isOnlyStateProvinceFlag = 'NULL' THEN -1 ELSE CAST(isOnlyStateProvinceFlag AS BYTEINT) END AS isOnlyStateProvinceFlag,
CASE WHEN Name2 = 'NULL' THEN 'N/A' ELSE Name2 END AS Name2,
CASE WHEN TerritoryID = 'NULL' THEN -1 ELSE TerritoryID END AS TerritoryID
FROM DB_STG1.Person;

--Purchase Module

INSERT INTO DB_STG2.BillofMaterials
SELECT DISTINCT
CASE BillOfMaterialsID WHEN 'NULL' THEN -1 ELSE CAST (BillOfMaterialsID AS INTEGER) END AS BillOfMaterialsID,
CASE ProductAssemblyID WHEN 'NULL' THEN -1 ELSE CAST (ProductAssemblyID AS INTEGER) END AS ProductAssemblyID,
CASE ComponentID WHEN 'NULL' THEN -1 ELSE CAST (ComponentID AS INTEGER) END AS ComponentID,
CASE StartDate WHEN 'NULL' THEN CAST ('1900-01-01' AS DATE FORMAT 'YYYY-MM-DD') ELSE CAST (SUBSTR(StartDate,1,10) AS DATE FORMAT 'YYYY-MM-DD')  END AS StartDate,
CASE EndDate WHEN 'NULL' THEN CAST ('1900-01-01' AS DATE FORMAT 'YYYY-MM-DD') ELSE CAST (SUBSTR(EndDate,1,10) AS DATE FORMAT 'YYYY-MM-DD')  END AS EndDate,
CASE UnitMeasureCode WHEN 'NULL' THEN 'N/A' ELSE UnitMeasureCode END AS UnitMeasureCode,
CASE BOMLevel WHEN 'NULL' THEN -1 ELSE CAST (BOMLevel AS INTEGER) END AS BOMLevel,
CASE PerAssemblyQty WHEN 'NULL' THEN -1 ELSE CAST (PerAssemblyQty AS DECIMAL(10,2)) END AS PerAssemblyQty
FROM  DB_STG1.BillOfMaterials_Production;

INSERT INTO DB_STG2.Culture 
SELECT DISTINCT
CASE CultureID1 WHEN 'NULL' THEN 'N/A' ELSE CultureID1 END AS CultureID,
CASE Name6 WHEN 'NULL' THEN 'N/A' ELSE Name6 END AS Name6
FROM  DB_STG1.Production;

INSERT INTO DB_STG2.Product
SELECT DISTINCT
CASE WHEN ProductID1 = 'NULL' THEN -1 ELSE ProductID1 END AS ProductID,
CASE WHEN Name1 = 'NULL' THEN 'N/A' ELSE Name1 END AS Name1,
CASE WHEN ProductNumber = 'NULL' THEN 'N/A' ELSE ProductNumber END AS ProductNumber,
CASE WHEN MakeFlag = 'NULL' THEN -1 ELSE CAST(MakeFlag AS BYTEINT) END AS MakeFlag,
CASE WHEN FinishedGoodsFlag = 'NULL' THEN -1 ELSE CAST(FinishedGoodsFlag AS BYTEINT) END AS FinishedGoodsFlag,
CASE WHEN Color = 'NULL' THEN 'N/A' ELSE Color END AS Color,
CASE WHEN SafetyStockLevel = 'NULL' THEN -1 ELSE SafetyStockLevel END AS SafetyStockLevel,
CASE WHEN ReorderPoint = 'NULL' THEN -1 ELSE ReorderPoint END AS ReorderPoint,
CASE WHEN StandardCost1 = 'NULL' THEN -1 ELSE CAST(StandardCost1 AS DECIMAL(10,2)) END AS StandardCost,
CASE WHEN ListPrice1 = 'NULL' THEN -1 ELSE CAST(ListPrice1 AS DECIMAL(10,2)) END AS ListPrice,
CASE WHEN SIZE = 'NULL' THEN 'N/A' ELSE CAST(SIZE AS CHAR(4)) END AS Size1,
CASE WHEN SizeUnitMeasureCode = 'NULL' THEN 'N/A' ELSE SizeUnitMeasureCode END AS SizeUnitMeasureCode,
CASE WHEN WeightUnitMeasureCode = 'NULL' THEN 'N/A' ELSE WeightUnitMeasureCode END AS WeightUnitMeasureCode,
CASE WHEN Weight = 'NULL' THEN -1 ELSE CAST(Weight AS DECIMAL(5,2)) END AS Weight,
CASE WHEN DaysToManufacture = 'NULL' THEN -1 ELSE CAST(DaysToManufacture AS SMALLINT) END AS DaysToManufacture,
CASE WHEN ProductLine = 'NULL' THEN 'N/A' ELSE ProductLine END AS ProductLine,
CASE WHEN "CLASS" = 'NULL' THEN 'N/A' ELSE "CLASS" END AS "CLASS",
CASE WHEN STYLE = 'NULL' THEN 'N/A' ELSE STYLE END AS Style1,
CASE WHEN ProductSubcategoryID1 = 'NULL' THEN -1 ELSE ProductSubcategoryID1 END AS ProductSubcategoryID,
CASE WHEN ProductModelID1 = 'NULL' THEN -1 ELSE ProductModelID1 END AS ProductModelID,
CASE WHEN SellStartDate = 'NULL' THEN CAST('1900-01-01' AS DATE FORMAT 'YYYY-MM-DD') ELSE CAST(SUBSTR(SellStartDate,1,10) AS DATE FORMAT 'YYYY-MM-DD') END AS SellStartDate,
CASE WHEN SellEndDate = 'NULL' THEN CAST('1900-01-01' AS DATE FORMAT 'YYYY-MM-DD') ELSE CAST(SUBSTR(SellEndDate,1,10) AS DATE FORMAT 'YYYY-MM-DD') END AS SellEndDate,
CASE WHEN DiscontinuedDate = 'NULL' THEN CAST('1900-01-01' AS DATE FORMAT 'YYYY-MM-DD') ELSE CAST(SUBSTR(DiscontinuedDate,1,10) AS DATE FORMAT 'YYYY-MM-DD') END AS DiscontinuedDate
FROM DB_STG1.Production;

INSERT INTO DB_STG2.ProductCategory 
SELECT  DISTINCT
CASE ProductCategoryID1 WHEN 'NULL' THEN -1 ELSE CAST (ProductCategoryID1 AS SMALLINT) END AS ProductCategoryID,
CASE Name3 WHEN 'NULL' THEN 'N/A' ELSE Name3 END AS Name1
FROM  DB_STG1.Production ;

INSERT INTO DB_STG2.ProductCostHistory 
SELECT DISTINCT
CASE ProductID1 WHEN 'NULL' THEN -1 ELSE ProductID1 END AS ProductID,
CASE StartDate1 WHEN 'NULL' THEN CAST ('1900-01-01' AS DATE FORMAT 'YYYY-MM-DD') ELSE CAST (SUBSTR(StartDate1,1,10) AS DATE FORMAT 'YYYY-MM-DD')  END AS StartDate,
CASE EndDate1 WHEN 'NULL' THEN CAST ('1900-01-01' AS DATE FORMAT 'YYYY-MM-DD') ELSE CAST (SUBSTR(EndDate1,1,10) AS DATE FORMAT 'YYYY-MM-DD')  END AS EndDate,
CASE StandardCost2 WHEN 'NULL' THEN -1 ELSE CAST (StandardCost2 AS DECIMAL(10,2)) END AS StandardCost
FROM  DB_STG1.Production ;

INSERT INTO DB_STG2.ProductDescription 
SELECT DISTINCT 
CASE ProductDescriptionID1 WHEN 'NULL' THEN -1 ELSE ProductDescriptionID1 END AS ProductDescriptionID,
CASE Description WHEN 'NULL' THEN 'N/A' ELSE Description END AS Description
FROM  DB_STG1.Production ;

INSERT INTO DB_STG2.ProductInventory 
SELECT DISTINCT
CASE ProductID1 WHEN 'NULL' THEN -1 ELSE ProductID1 END AS ProductID,
CASE LocationID1 WHEN 'NULL' THEN -1 ELSE CAST (LocationID1 AS SMALLINT) END AS LocationID,
CASE Shelf WHEN 'NULL' THEN 'N/A' ELSE Shelf END AS Shelf,
CASE Bin WHEN 'NULL' THEN -1 ELSE CAST (Bin AS SMALLINT) END AS Bin,
CASE Quantity1 WHEN 'NULL' THEN -1 ELSE CAST (Quantity1 AS SMALLINT) END AS Quantity
FROM  DB_STG1.Production ;

INSERT INTO DB_STG2.ProductListPriceHistory 
SELECT DISTINCT
CASE ProductID1 WHEN 'NULL' THEN -1 ELSE CAST (ProductID1 AS INTEGER) END AS ProductID,
CASE StartDate1 WHEN 'NULL' THEN CAST ('1900-01-01' AS DATE FORMAT 'YYYY-MM-DD') ELSE CAST (SUBSTR(StartDate1,1,10) AS DATE FORMAT 'YYYY-MM-DD')  END AS StartDate,
CASE EndDate1 WHEN 'NULL' THEN CAST ('1900-01-01' AS DATE FORMAT 'YYYY-MM-DD') ELSE CAST (SUBSTR(EndDate1,1,10) AS DATE FORMAT 'YYYY-MM-DD')  END AS EndDate,
CASE ListPrice1 WHEN 'NULL' THEN -1 ELSE CAST (ListPrice1 AS DECIMAL(10,2)) END AS ListPrice
FROM  DB_STG1.Production ;

INSERT INTO DB_STG2.ProductModel 
SELECT DISTINCT
CASE ProductModelID1 WHEN 'NULL' THEN -1 ELSE CAST (ProductModelID1 AS SMALLINT) END AS ProductModelID,
CASE Name5 WHEN 'NULL' THEN 'N/A' ELSE Name5 END AS Name5,
CASE CatalogDescription WHEN 'NULL' THEN 'N/A' ELSE CatalogDescription END AS CatalogDescription,
CASE Instructions WHEN 'NULL' THEN 'N/A' ELSE Instructions END AS Instructions
FROM  DB_STG1.Production ;

INSERT INTO DB_STG2.ProductModelProductDesctriptionCulture 
SELECT DISTINCT
CASE ProductModelID3 WHEN 'NULL' THEN -1 ELSE CAST (ProductModelID3 AS SMALLINT) END AS ProductModelID,
CASE ProductDescriptionID1 WHEN 'NULL' THEN -1 ELSE ProductDescriptionID1 END AS ProductDescriptionID,
CASE CultureID1 WHEN 'NULL' THEN 'N/A' ELSE CultureID1 END AS CultureID
FROM  DB_STG1.Production;

INSERT INTO DB_STG2.ProductSubCategory 
SELECT  DISTINCT
CASE ProductSubCategoryID1 WHEN 'NULL' THEN -1 ELSE CAST (ProductSubCategoryID1 AS SMALLINT) END AS ProductSubCategoryID,
CASE ProductCategoryID1 WHEN 'NULL' THEN -1 ELSE CAST (ProductCategoryID1 AS SMALLINT) END AS ProductCategoryID,
CASE Name2 WHEN 'NULL' THEN 'N/A' ELSE Name2 END AS Name1
FROM  DB_STG1.Production ;

INSERT INTO DB_STG2.ScrapReason 
SELECT 
CASE ScrapReasonID WHEN 'NULL' THEN -1 ELSE ScrapReasonID END AS ScrapReasonID,
CASE Name WHEN 'NULL' THEN 'N/A' ELSE Name END AS Name
FROM  DB_STG1.ScrapReason_Production;

INSERT INTO DB_STG2.TransactionHistory 
SELECT DISTINCT
CASE TransactionID WHEN 'NULL' THEN -1 ELSE TransactionID END AS TransactionID,
CASE ProductID1 WHEN 'NULL' THEN -1 ELSE ProductID1  END AS ProductID,
CASE ReferenceOrderID WHEN 'NULL' THEN -1 ELSE ReferenceOrderID END AS ReferenceOrderID,
CASE ReferenceOrderLineID WHEN 'NULL' THEN -1 ELSE CAST (ReferenceOrderLineID AS SMALLINT) END AS ReferenceOrderLineID,
CASE TransactionDate WHEN 'NULL' THEN CAST ('1900-01-01' AS DATE FORMAT 'YYYY-MM-DD') ELSE CAST (SUBSTR(TransactionDate,1,10) AS DATE FORMAT 'YYYY-MM-DD')  END AS TransactionDate,
CASE TransactionType WHEN 'NULL' THEN 'N/A' ELSE TransactionType END AS TransactionType,
CASE Quantity1 WHEN 'NULL' THEN -1 ELSE CAST (Quantity1 AS SMALLINT) END AS Quantity,
CASE ActualCost WHEN 'NULL' THEN -1 ELSE CAST (ActualCost AS DECIMAL(10,2)) END AS ActualCost
FROM  DB_STG1.Production ;

INSERT INTO DB_STG2.UnitMeasure 
SELECT 
CASE UnitMeasureCode WHEN 'NULL' THEN 'N/A' ELSE CAST(UnitMeasureCode AS CHAR(8)) END AS UnitMeasureCode,
CASE Name WHEN 'NULL' THEN 'N/A' ELSE Name END AS Name
FROM  DB_STG1.UnitMeasure_Production;

INSERT INTO DB_STG2.WorkOrder 
SELECT DISTINCT
CASE WorkOrderID WHEN 'NULL' THEN -1 ELSE WorkOrderID END AS WorkOrderID,
CASE ProductID WHEN 'NULL' THEN -1 ELSE ProductID END AS ProductID,
CASE OrderQty WHEN 'NULL' THEN -1 ELSE OrderQty END AS OrderQty,
CASE StockedQty WHEN 'NULL' THEN -1 ELSE StockedQty END AS StockedQty,
CASE ScrappedQty WHEN 'NULL' THEN -1 ELSE ScrappedQty END AS ScrappedQty,
CASE StartDate WHEN 'NULL' THEN CAST ('1900-01-01' AS DATE FORMAT 'YYYY-MM-DD') ELSE CAST (SUBSTR(StartDate,1,10) AS DATE FORMAT 'YYYY-MM-DD')  END AS StartDate,
CASE EndDate WHEN 'NULL' THEN CAST ('1900-01-01' AS DATE FORMAT 'YYYY-MM-DD') ELSE CAST (SUBSTR(EndDate,1,10) AS DATE FORMAT 'YYYY-MM-DD')  END AS EndDate,
CASE DueDate WHEN 'NULL' THEN CAST ('1900-01-01' AS DATE FORMAT 'YYYY-MM-DD') ELSE CAST (SUBSTR(DueDate,1,10) AS DATE FORMAT 'YYYY-MM-DD')  END AS DueDate,
CASE ScrapReasonID WHEN 'NULL' THEN -1 ELSE ScrapReasonID END AS ScrapReasonID
FROM  DB_STG1.WorkOrder_Production;

INSERT INTO DB_STG2.WorkOrderRouting
SELECT DISTINCT
CASE WorkOrderID WHEN 'NULL' THEN -1 ELSE WorkOrderID END AS WorkOrderID,
CASE ProductID WHEN 'NULL' THEN -1 ELSE ProductID END AS ProductID,
CASE OperationSequence WHEN 'NULL' THEN -1 ELSE OperationSequence END AS OperationSequence,
CASE LocationID WHEN 'NULL' THEN -1 ELSE LocationID END AS LocationID,
CASE ScheduledStartDate WHEN 'NULL' THEN CAST ('1900-01-01' AS DATE FORMAT 'YYYY-MM-DD') ELSE CAST (SUBSTR(ScheduledStartDate,1,10) AS DATE FORMAT 'YYYY-MM-DD')  END AS ScheduledStartDate,
CASE ScheduledEndDate WHEN 'NULL' THEN CAST ('1900-01-01' AS DATE FORMAT 'YYYY-MM-DD') ELSE CAST (SUBSTR(ScheduledEndDate,1,10) AS DATE FORMAT 'YYYY-MM-DD')  END AS ScheduledEndDate,
CASE ActualStartDate WHEN 'NULL' THEN CAST ('1900-01-01' AS DATE FORMAT 'YYYY-MM-DD') ELSE CAST (SUBSTR(ActualStartDate,1,10) AS DATE FORMAT 'YYYY-MM-DD')  END AS ActualStartDate,
CASE ActualEndDate WHEN 'NULL' THEN CAST ('1900-01-01' AS DATE FORMAT 'YYYY-MM-DD') ELSE CAST (SUBSTR(ActualEndDate,1,10) AS DATE FORMAT 'YYYY-MM-DD')  END AS ActualEndDate,
CASE ActualResourceHrs WHEN 'NULL' THEN -1 ELSE CAST (ActualResourceHrs AS DECIMAL(10,2)) END AS ActualResourceHrs,
CASE PlannedCost WHEN 'NULL' THEN -1 ELSE CAST (PlannedCost AS DECIMAL(10,2)) END AS PlannedCost,
CASE ActualCost WHEN 'NULL' THEN -1 ELSE CAST (ActualCost AS DECIMAL(10,2)) END AS ActualCost
FROM  DB_STG1.WorkOrderRouting_Production;

--Sales

INSERT INTO DB_STG2.CreditCard	
SELECT DISTINCT 
	CASE WHEN CreditCardID1='NULL' THEN -1 ELSE CreditCardID1 END AS  CreditCardID,
	CASE WHEN CardType='NULL' THEN 'N/A' ELSE CardType END  AS CardType,
	CASE WHEN CardNumber = 'NULL' THEN 'NA' ELSE CardNumber END AS CardNumber,
	CASE WHEN ExpMonth='NULL' THEN -1 ELSE CAST(ExpMonth AS SMALLINT) END AS  ExpMonth,
	CASE WHEN ExpYear='NULL' THEN -1 ELSE CAST(ExpYear AS SMALLINT) END AS  ExpYear
FROM DB_STG1.Sales
UNION
SELECT DISTINCT 
	CASE WHEN CreditCardID1='NULL' THEN -1 ELSE CreditCardID1 END AS  CreditCardID,
	CASE WHEN CardType='NULL' THEN 'N/A' ELSE CardType END  AS CardType,
	CASE WHEN CardNumber = 'NULL' THEN 'NA' ELSE CardNumber END AS CardNumber,
	CASE WHEN ExpMonth='NULL' THEN -1 ELSE CAST(ExpMonth AS SMALLINT) END AS  ExpMonth,
	CASE WHEN ExpYear='NULL' THEN -1 ELSE CAST(ExpYear AS SMALLINT) END AS  ExpYear
FROM DB_STG1.Sales_April_1_10
UNION
SELECT DISTINCT 
	CASE WHEN CreditCardID1='NULL' THEN -1 ELSE CreditCardID1 END AS  CreditCardID,
	CASE WHEN CardType='NULL' THEN 'N/A' ELSE CardType END  AS CardType,
	CASE WHEN CardNumber = 'NULL' THEN 'NA' ELSE CardNumber END AS CardNumber,
	CASE WHEN ExpMonth='NULL' THEN -1 ELSE CAST(ExpMonth AS SMALLINT) END AS  ExpMonth,
	CASE WHEN ExpYear='NULL' THEN -1 ELSE CAST(ExpYear AS SMALLINT) END AS  ExpYear
FROM DB_STG1.Sales_April_11_20
UNION
SELECT DISTINCT 
	CASE WHEN CreditCardID1='NULL' THEN -1 ELSE CreditCardID1 END AS  CreditCardID,
	CASE WHEN CardType='NULL' THEN 'N/A' ELSE CardType END  AS CardType,
	CASE WHEN CardNumber = 'NULL' THEN 'NA' ELSE CardNumber END AS CardNumber,
	CASE WHEN ExpMonth='NULL' THEN -1 ELSE CAST(ExpMonth AS SMALLINT) END AS  ExpMonth,
	CASE WHEN ExpYear='NULL' THEN -1 ELSE CAST(ExpYear AS SMALLINT) END AS  ExpYear
FROM DB_STG1.Sales_April_21_30
UNION
SELECT DISTINCT 
	CASE WHEN CreditCardID1='NULL' THEN -1 ELSE CreditCardID1 END AS  CreditCardID,
	CASE WHEN CardType='NULL' THEN 'N/A' ELSE CardType END  AS CardType,
	CASE WHEN CardNumber = 'NULL' THEN 'NA' ELSE CardNumber END AS CardNumber,
	CASE WHEN ExpMonth='NULL' THEN -1 ELSE CAST(ExpMonth AS SMALLINT) END AS  ExpMonth,
	CASE WHEN ExpYear='NULL' THEN -1 ELSE CAST(ExpYear AS SMALLINT) END AS  ExpYear
FROM DB_STG1.Sales_May_06_10
UNION
SELECT DISTINCT 
	CASE WHEN CreditCardID1='NULL' THEN -1 ELSE CreditCardID1 END AS  CreditCardID,
	CASE WHEN CardType='NULL' THEN 'N/A' ELSE CardType END  AS CardType,
	CASE WHEN CardNumber = 'NULL' THEN 'NA' ELSE CardNumber END AS CardNumber,
	CASE WHEN ExpMonth='NULL' THEN -1 ELSE CAST(ExpMonth AS SMALLINT) END AS  ExpMonth,
	CASE WHEN ExpYear='NULL' THEN -1 ELSE CAST(ExpYear AS SMALLINT) END AS  ExpYear
FROM DB_STG1.Sales_May_11_20
UNION
SELECT DISTINCT 
	CASE WHEN CreditCardID1='NULL' THEN -1 ELSE CreditCardID1 END AS  CreditCardID,
	CASE WHEN CardType='NULL' THEN 'N/A' ELSE CardType END  AS CardType,
	CASE WHEN CardNumber = 'NULL' THEN 'NA' ELSE CardNumber END AS CardNumber,
	CASE WHEN ExpMonth='NULL' THEN -1 ELSE CAST(ExpMonth AS SMALLINT) END AS  ExpMonth,
	CASE WHEN ExpYear='NULL' THEN -1 ELSE CAST(ExpYear AS SMALLINT) END AS  ExpYear
FROM DB_STG1.Sales_May_21_31;

INSERT INTO DB_STG2.Currency
SELECT DISTINCT 
	CASE WHEN CurrencyCode = 'NULL' THEN -1 ELSE CAST(CurrencyCode AS CHAR(6)) END AS  CurrencyCode,
	CASE WHEN Name2 = 'NULL' THEN 'N/A' ELSE Name2 END AS Name1
FROM DB_STG1.Sales_May_06_10;

INSERT INTO DB_STG2.CurrencyRate
SELECT DISTINCT 
	CASE WHEN CurrencyRateID1='NULL' THEN -1 ELSE CurrencyRateID1 END AS CurrencyRateID1,
	CASE WHEN CurrencyRateDate = 'NULL' THEN CAST('1900-01-01' AS DATE FORMAT 'YYYY-MM-DD') ELSE CAST(SUBSTR(CurrencyRateDate,1,10) AS DATE FORMAT 'YYYY-MM-DD') END AS CurrencyRateDate,
	CASE WHEN FromCurrencyCode = 'NULL' THEN '-1' ELSE FromCurrencyCode END AS FromCurrencyCode,
	CASE WHEN ToCurrencyCode = 'NULL' THEN '-1' ELSE ToCurrencyCode END AS ToCurrencyCode,
	CASE WHEN AverageRate='NULL' THEN -1 ELSE CAST(AverageRate AS DECIMAL(8,2)) END AS AverageRate,
	CASE WHEN EndOfDayRate='NULL' THEN -1 ELSE CAST(EndOfDayRate AS DECIMAL(8,2)) END AS EndOfDayRate
FROM DB_STG1.Sales_April_1_10
UNION
SELECT DISTINCT 
	CASE WHEN CurrencyRateID1='NULL' THEN -1 ELSE CurrencyRateID1 END AS CurrencyRateID1,
	CASE WHEN CurrencyRateDate = 'NULL' THEN CAST('1900-01-01' AS DATE FORMAT 'YYYY-MM-DD') ELSE CAST(SUBSTR(CurrencyRateDate,1,10) AS DATE FORMAT 'YYYY-MM-DD') END AS CurrencyRateDate,
	CASE WHEN FromCurrencyCode = 'NULL' THEN '-1' ELSE FromCurrencyCode END AS FromCurrencyCode,
	CASE WHEN ToCurrencyCode = 'NULL' THEN '-1' ELSE ToCurrencyCode END AS ToCurrencyCode,
	CASE WHEN AverageRate='NULL' THEN -1 ELSE CAST(AverageRate AS DECIMAL(8,2)) END AS AverageRate,
	CASE WHEN EndOfDayRate='NULL' THEN -1 ELSE CAST(EndOfDayRate AS DECIMAL(8,2)) END AS EndOfDayRate
FROM DB_STG1.Sales_April_11_20
UNION
SELECT DISTINCT 
	CASE WHEN CurrencyRateID1='NULL' THEN -1 ELSE CurrencyRateID1 END AS CurrencyRateID1,
	CASE WHEN CurrencyRateDate = 'NULL' THEN CAST('1900-01-01' AS DATE FORMAT 'YYYY-MM-DD') ELSE CAST(SUBSTR(CurrencyRateDate,1,10) AS DATE FORMAT 'YYYY-MM-DD') END AS CurrencyRateDate,
	CASE WHEN FromCurrencyCode = 'NULL' THEN '-1' ELSE FromCurrencyCode END AS FromCurrencyCode,
	CASE WHEN ToCurrencyCode = 'NULL' THEN '-1' ELSE ToCurrencyCode END AS ToCurrencyCode,
	CASE WHEN AverageRate='NULL' THEN -1 ELSE CAST(AverageRate AS DECIMAL(8,2)) END AS AverageRate,
	CASE WHEN EndOfDayRate='NULL' THEN -1 ELSE CAST(EndOfDayRate AS DECIMAL(8,2)) END AS EndOfDayRate
FROM DB_STG1.Sales_April_21_30
UNION
SELECT DISTINCT 
	CASE WHEN CurrencyRateID1='NULL' THEN -1 ELSE CurrencyRateID1 END AS CurrencyRateID1,
	CASE WHEN CurrencyRateDate = 'NULL' THEN CAST('1900-01-01' AS DATE FORMAT 'YYYY-MM-DD') ELSE CAST(SUBSTR(CurrencyRateDate,1,10) AS DATE FORMAT 'YYYY-MM-DD') END AS CurrencyRateDate,
	CASE WHEN FromCurrencyCode = 'NULL' THEN '-1' ELSE FromCurrencyCode END AS FromCurrencyCode,
	CASE WHEN ToCurrencyCode = 'NULL' THEN '-1' ELSE ToCurrencyCode END AS ToCurrencyCode,
	CASE WHEN AverageRate='NULL' THEN -1 ELSE CAST(AverageRate AS DECIMAL(8,2)) END AS AverageRate,
	CASE WHEN EndOfDayRate='NULL' THEN -1 ELSE CAST(EndOfDayRate AS DECIMAL(8,2)) END AS EndOfDayRate
FROM DB_STG1.Sales_May_06_10
UNION
SELECT DISTINCT 
	CASE WHEN CurrencyRateID1='NULL' THEN -1 ELSE CurrencyRateID1 END AS CurrencyRateID1,
	CASE WHEN CurrencyRateDate = 'NULL' THEN CAST('1900-01-01' AS DATE FORMAT 'YYYY-MM-DD') ELSE CAST(SUBSTR(CurrencyRateDate,1,10) AS DATE FORMAT 'YYYY-MM-DD') END AS CurrencyRateDate,
	CASE WHEN FromCurrencyCode = 'NULL' THEN '-1' ELSE FromCurrencyCode END AS FromCurrencyCode,
	CASE WHEN ToCurrencyCode = 'NULL' THEN '-1' ELSE ToCurrencyCode END AS ToCurrencyCode,
	CASE WHEN AverageRate='NULL' THEN -1 ELSE CAST(AverageRate AS DECIMAL(8,2)) END AS AverageRate,
	CASE WHEN EndOfDayRate='NULL' THEN -1 ELSE CAST(EndOfDayRate AS DECIMAL(8,2)) END AS EndOfDayRate
FROM DB_STG1.Sales_May_11_20
UNION
SELECT DISTINCT 
	CASE WHEN CurrencyRateID1='NULL' THEN -1 ELSE CurrencyRateID1 END AS CurrencyRateID1,
	CASE WHEN CurrencyRateDate = 'NULL' THEN CAST('1900-01-01' AS DATE FORMAT 'YYYY-MM-DD') ELSE CAST(SUBSTR(CurrencyRateDate,1,10) AS DATE FORMAT 'YYYY-MM-DD') END AS CurrencyRateDate,
	CASE WHEN FromCurrencyCode = 'NULL' THEN '-1' ELSE FromCurrencyCode END AS FromCurrencyCode,
	CASE WHEN ToCurrencyCode = 'NULL' THEN '-1' ELSE ToCurrencyCode END AS ToCurrencyCode,
	CASE WHEN AverageRate='NULL' THEN -1 ELSE CAST(AverageRate AS DECIMAL(8,2)) END AS AverageRate,
	CASE WHEN EndOfDayRate='NULL' THEN -1 ELSE CAST(EndOfDayRate AS DECIMAL(8,2)) END AS EndOfDayRate
FROM DB_STG1.Sales_May_21_31;

INSERT INTO DB_STG2.Customer
SELECT DISTINCT 
 CASE WHEN  CustomerID ='NULL' THEN -1 ELSE  CustomerID END AS  CustomerID,
    CASE WHEN  PersonID  = 'NULL' THEN -1 ELSE  PersonID END AS PersonID,
	CASE WHEN  StoreID  = 'NULL'  THEN -1 ELSE  StoreID END AS StoreID,
	CASE WHEN  TerritoryID = 'NULL' THEN -1 ELSE  TerritoryID END AS TerritoryID,
	CASE WHEN AccountNumber = 'NULL' THEN 'N/A' ELSE AccountNumber END AS AccountNumber
FROM  DB_STG1.Customer_Sales;

INSERT INTO DB_STG2.PersonCreditCard	
SELECT DISTINCT 
    CASE WHEN BusinessEntityID1='NULL' THEN -1 ELSE BusinessEntityID1 END AS  BusinessEntityID,
	CASE WHEN CreditCardID1='NULL' THEN -1 ELSE CreditCardID1 END AS  CreditCardID
FROM DB_STG1.Sales
UNION
SELECT DISTINCT 
	CASE WHEN BusinessEntityID1='NULL' THEN -1 ELSE BusinessEntityID1 END AS  BusinessEntityID,
	CASE WHEN CreditCardID1='NULL' THEN -1 ELSE CreditCardID1 END AS  CreditCardID
FROM DB_STG1.Sales_April_1_10
UNION
SELECT DISTINCT 
	CASE WHEN BusinessEntityID1='NULL' THEN -1 ELSE BusinessEntityID1 END AS  BusinessEntityID,
	CASE WHEN CreditCardID1='NULL' THEN -1 ELSE CreditCardID1 END AS  CreditCardID
FROM DB_STG1.Sales_April_11_20
UNION
SELECT DISTINCT 
	CASE WHEN BusinessEntityID1='NULL' THEN -1 ELSE BusinessEntityID1 END AS  BusinessEntityID,
	CASE WHEN CreditCardID1='NULL' THEN -1 ELSE CreditCardID1 END AS  CreditCardID
FROM DB_STG1.Sales_April_21_30
UNION
SELECT DISTINCT 
	CASE WHEN BusinessEntityID1='NULL' THEN -1 ELSE BusinessEntityID1 END AS  BusinessEntityID,
	CASE WHEN CreditCardID1='NULL' THEN -1 ELSE CreditCardID1 END AS  CreditCardID
FROM DB_STG1.Sales_May_06_10
UNION
SELECT DISTINCT 
	CASE WHEN BusinessEntityID1='NULL' THEN -1 ELSE BusinessEntityID1 END AS  BusinessEntityID,
	CASE WHEN CreditCardID1='NULL' THEN -1 ELSE CreditCardID1 END AS  CreditCardID
FROM DB_STG1.Sales_May_11_20
UNION
SELECT DISTINCT 
	CASE WHEN BusinessEntityID1='NULL' THEN -1 ELSE BusinessEntityID1 END AS  BusinessEntityID,
	CASE WHEN CreditCardID1='NULL' THEN -1 ELSE CreditCardID1 END AS  CreditCardID
FROM DB_STG1.Sales_May_21_31;

INSERT INTO DB_STG2.SalesOrderDetail
	SELECT DISTINCT
	CASE WHEN BusinessEntityID1 = 'NULL' THEN -1 ELSE BusinessEntityID1 END AS BusinessEntityID1,
	CASE WHEN SalesOrderID1 = 'NULL' THEN -1 ELSE SalesOrderID1 END AS SalesOrderID1,
	CASE WHEN SalesOrderDetailID = 'NULL' THEN -1 ELSE SalesOrderDetailID END AS SalesOrderDetailID,
	CASE WHEN CarrierTrackingNumber = 'NULL' THEN 'N/A' ELSE CarrierTrackingNumber END AS CarrierTrackingNumber,
	CASE WHEN OrderQty = 'NULL' THEN -1 ELSE OrderQty END AS OrderQty,
	CASE WHEN ProductID1 = 'NULL' THEN -1 ELSE ProductID1 END AS ProductID,
	CASE WHEN SpecialOfferID1 = 'NULL' THEN -1 ELSE SpecialOfferID1 END AS SpecialOfferID,
	CASE WHEN  UnitPrice = 'NULL' THEN -1 ELSE  CAST(UnitPrice AS DECIMAL(10,2)) END AS UnitPrice,
	CASE WHEN UnitPriceDiscount = 'NULL' THEN -1 ELSE  CAST(UnitPriceDiscount AS DECIMAL(6,2)) END AS UnitPriceDiscount,
	CASE WHEN  LineTotal = 'NULL' THEN -1 ELSE  CAST(LineTotal AS DECIMAL(10,2)) END AS LineTotal
	FROM DB_STG1.Sales
	UNION
	SELECT DISTINCT
	CASE WHEN BusinessEntityID1 = 'NULL' THEN -1 ELSE BusinessEntityID1 END AS BusinessEntityID1,
	CASE WHEN SalesOrderID1 = 'NULL' THEN -1 ELSE SalesOrderID1 END AS SalesOrderID1,
	CASE WHEN SalesOrderDetailID = 'NULL' THEN -1 ELSE SalesOrderDetailID END AS SalesOrderDetailID,
	CASE WHEN CarrierTrackingNumber = 'NULL' THEN 'N/A' ELSE CarrierTrackingNumber END AS CarrierTrackingNumber,
	CASE WHEN OrderQty = 'NULL' THEN -1 ELSE OrderQty END AS OrderQty,
	CASE WHEN ProductID1 = 'NULL' THEN -1 ELSE ProductID1 END AS ProductID,
	CASE WHEN SpecialOfferID1 = 'NULL' THEN -1 ELSE SpecialOfferID1 END AS SpecialOfferID,
	CASE WHEN  UnitPrice = 'NULL' THEN -1 ELSE  CAST(UnitPrice AS DECIMAL(10,2)) END AS UnitPrice,
	CASE WHEN UnitPriceDiscount = 'NULL' THEN -1 ELSE  CAST(UnitPriceDiscount AS DECIMAL(6,2)) END AS UnitPriceDiscount,
	CASE WHEN  LineTotal = 'NULL' THEN -1 ELSE  CAST(LineTotal AS DECIMAL(10,2)) END AS LineTotal
	FROM DB_STG1.Sales_April_1_10
	UNION
	SELECT DISTINCT
	CASE WHEN BusinessEntityID1 = 'NULL' THEN -1 ELSE BusinessEntityID1 END AS BusinessEntityID1,
	CASE WHEN SalesOrderID1 = 'NULL' THEN -1 ELSE SalesOrderID1 END AS SalesOrderID1,
	CASE WHEN SalesOrderDetailID = 'NULL' THEN -1 ELSE SalesOrderDetailID END AS SalesOrderDetailID,
	CASE WHEN CarrierTrackingNumber = 'NULL' THEN 'N/A' ELSE CarrierTrackingNumber END AS CarrierTrackingNumber,
	CASE WHEN OrderQty = 'NULL' THEN -1 ELSE OrderQty END AS OrderQty,
	CASE WHEN ProductID1 = 'NULL' THEN -1 ELSE ProductID1 END AS ProductID,
	CASE WHEN SpecialOfferID1 = 'NULL' THEN -1 ELSE SpecialOfferID1 END AS SpecialOfferID,
	CASE WHEN  UnitPrice = 'NULL' THEN -1 ELSE  CAST(UnitPrice AS DECIMAL(10,2)) END AS UnitPrice,
	CASE WHEN UnitPriceDiscount = 'NULL' THEN -1 ELSE  CAST(UnitPriceDiscount AS DECIMAL(6,2)) END AS UnitPriceDiscount,
	CASE WHEN  LineTotal = 'NULL' THEN -1 ELSE  CAST(LineTotal AS DECIMAL(10,2)) END AS LineTotal
	FROM DB_STG1.Sales_April_11_20
	UNION
	SELECT DISTINCT
	CASE WHEN BusinessEntityID1 = 'NULL' THEN -1 ELSE BusinessEntityID1 END AS BusinessEntityID1,
	CASE WHEN SalesOrderID1 = 'NULL' THEN -1 ELSE SalesOrderID1 END AS SalesOrderID1,
	CASE WHEN SalesOrderDetailID = 'NULL' THEN -1 ELSE SalesOrderDetailID END AS SalesOrderDetailID,
	CASE WHEN CarrierTrackingNumber = 'NULL' THEN 'N/A' ELSE CarrierTrackingNumber END AS CarrierTrackingNumber,
	CASE WHEN OrderQty = 'NULL' THEN -1 ELSE OrderQty END AS OrderQty,
	CASE WHEN ProductID1 = 'NULL' THEN -1 ELSE ProductID1 END AS ProductID,
	CASE WHEN SpecialOfferID1 = 'NULL' THEN -1 ELSE SpecialOfferID1 END AS SpecialOfferID,
	CASE WHEN  UnitPrice = 'NULL' THEN -1 ELSE  CAST(UnitPrice AS DECIMAL(10,2)) END AS UnitPrice,
	CASE WHEN UnitPriceDiscount = 'NULL' THEN -1 ELSE  CAST(UnitPriceDiscount AS DECIMAL(6,2)) END AS UnitPriceDiscount,
	CASE WHEN  LineTotal = 'NULL' THEN -1 ELSE  CAST(LineTotal AS DECIMAL(10,2)) END AS LineTotal
	FROM DB_STG1.Sales_April_21_30
	UNION
	SELECT DISTINCT
	CASE WHEN BusinessEntityID1 = 'NULL' THEN -1 ELSE BusinessEntityID1 END AS BusinessEntityID1,
	CASE WHEN SalesOrderID1 = 'NULL' THEN -1 ELSE SalesOrderID1 END AS SalesOrderID1,
	CASE WHEN SalesOrderDetailID = 'NULL' THEN -1 ELSE SalesOrderDetailID END AS SalesOrderDetailID,
	CASE WHEN CarrierTrackingNumber = 'NULL' THEN 'N/A' ELSE CarrierTrackingNumber END AS CarrierTrackingNumber,
	CASE WHEN OrderQty = 'NULL' THEN -1 ELSE OrderQty END AS OrderQty,
	CASE WHEN ProductID1 = 'NULL' THEN -1 ELSE ProductID1 END AS ProductID,
	CASE WHEN SpecialOfferID1 = 'NULL' THEN -1 ELSE SpecialOfferID1 END AS SpecialOfferID,
	CASE WHEN  UnitPrice = 'NULL' THEN -1 ELSE  CAST(UnitPrice AS DECIMAL(10,2)) END AS UnitPrice,
	CASE WHEN UnitPriceDiscount = 'NULL' THEN -1 ELSE  CAST(UnitPriceDiscount AS DECIMAL(6,2)) END AS UnitPriceDiscount,
	CASE WHEN  LineTotal = 'NULL' THEN -1 ELSE  CAST(LineTotal AS DECIMAL(10,2)) END AS LineTotal
	FROM DB_STG1.Sales_May_06_10
	UNION
	SELECT DISTINCT
	CASE WHEN BusinessEntityID1 = 'NULL' THEN -1 ELSE BusinessEntityID1 END AS BusinessEntityID1,
	CASE WHEN SalesOrderID1 = 'NULL' THEN -1 ELSE SalesOrderID1 END AS SalesOrderID1,
	CASE WHEN SalesOrderDetailID = 'NULL' THEN -1 ELSE SalesOrderDetailID END AS SalesOrderDetailID,
	CASE WHEN CarrierTrackingNumber = 'NULL' THEN 'N/A' ELSE CarrierTrackingNumber END AS CarrierTrackingNumber,
	CASE WHEN OrderQty = 'NULL' THEN -1 ELSE OrderQty END AS OrderQty,
	CASE WHEN ProductID1 = 'NULL' THEN -1 ELSE ProductID1 END AS ProductID,
	CASE WHEN SpecialOfferID1 = 'NULL' THEN -1 ELSE SpecialOfferID1 END AS SpecialOfferID,
	CASE WHEN  UnitPrice = 'NULL' THEN -1 ELSE  CAST(UnitPrice AS DECIMAL(10,2)) END AS UnitPrice,
	CASE WHEN UnitPriceDiscount = 'NULL' THEN -1 ELSE  CAST(UnitPriceDiscount AS DECIMAL(6,2)) END AS UnitPriceDiscount,
	CASE WHEN  LineTotal = 'NULL' THEN -1 ELSE  CAST(LineTotal AS DECIMAL(10,2)) END AS LineTotal
	FROM DB_STG1.Sales_May_11_20
	UNION
	SELECT DISTINCT
	CASE WHEN BusinessEntityID1 = 'NULL' THEN -1 ELSE BusinessEntityID1 END AS BusinessEntityID1,
	CASE WHEN SalesOrderID1 = 'NULL' THEN -1 ELSE SalesOrderID1 END AS SalesOrderID1,
	CASE WHEN SalesOrderDetailID = 'NULL' THEN -1 ELSE SalesOrderDetailID END AS SalesOrderDetailID,
	CASE WHEN CarrierTrackingNumber = 'NULL' THEN 'N/A' ELSE CarrierTrackingNumber END AS CarrierTrackingNumber,
	CASE WHEN OrderQty = 'NULL' THEN -1 ELSE OrderQty END AS OrderQty,
	CASE WHEN ProductID1 = 'NULL' THEN -1 ELSE ProductID1 END AS ProductID,
	CASE WHEN SpecialOfferID1 = 'NULL' THEN -1 ELSE SpecialOfferID1 END AS SpecialOfferID,
	CASE WHEN  UnitPrice = 'NULL' THEN -1 ELSE  CAST(UnitPrice AS DECIMAL(10,2)) END AS UnitPrice,
	CASE WHEN UnitPriceDiscount = 'NULL' THEN -1 ELSE  CAST(UnitPriceDiscount AS DECIMAL(6,2)) END AS UnitPriceDiscount,
	CASE WHEN  LineTotal = 'NULL' THEN -1 ELSE  CAST(LineTotal AS DECIMAL(10,2)) END AS LineTotal
	FROM DB_STG1.Sales_May_21_31
	UNION
	SELECT DISTINCT
	CASE WHEN BusinessEntityID = 'NULL' THEN -1 ELSE BusinessEntityID END AS BusinessEntityID,
	CASE WHEN SalesOrderID1 = 'NULL' THEN -1 ELSE SalesOrderID1 END AS SalesOrderID1,
	CASE WHEN SalesOrderDetailID1 = 'NULL' THEN -1 ELSE SalesOrderDetailID1 END AS SalesOrderDetailID,
	CASE WHEN CarrierTrackingNumber1 = 'NULL' THEN 'N/A' ELSE CarrierTrackingNumber1 END AS CarrierTrackingNumber,
	CASE WHEN OrderQty1 = 'NULL' THEN -1 ELSE OrderQty1 END AS OrderQty,
	CASE WHEN ProductID1 = 'NULL' THEN -1 ELSE ProductID1 END AS ProductID,
	CASE WHEN SpecialOfferID1 = 'NULL' THEN -1 ELSE SpecialOfferID1 END AS SpecialOfferID,
	CASE WHEN  UnitPrice1 = 'NULL' THEN -1 ELSE  CAST(UnitPrice1 AS DECIMAL(10,2)) END AS UnitPrice,
	CASE WHEN UnitPriceDiscount1 = 'NULL' THEN -1 ELSE  CAST(UnitPriceDiscount1 AS DECIMAL(6,2)) END AS UnitPriceDiscount,
	CASE WHEN  LineTotal = 'NULL' THEN -1 ELSE  CAST(LineTotal AS DECIMAL(10,2)) END AS LineTotal
	FROM DB_STG1.Sales_3;
	
INSERT INTO DB_STG2.SalesOrderHeader
SELECT DISTINCT
CASE WHEN BusinessEntityID1 = 'NULL' THEN -1 ELSE BusinessEntityID1 END AS BusinessEntityID1,
CASE WHEN SalesOrderID1 = 'NULL' THEN -1 ELSE SalesOrderID1 END AS SalesOrderID1,
CASE WHEN ShipMethodID = 'NULL' THEN -1 ELSE ShipMethodID END AS ShipMethodID,
CASE WHEN BusinessEntityID2 = 'NULL' THEN -1 ELSE BusinessEntityID2 END AS SalesPersonID,
CASE WHEN RevisionNumber = 'NULL' THEN -1 ELSE RevisionNumber END AS RevisionNumber,
CASE WHEN OrderDate = 'NULL' THEN CAST('1900-01-01' AS DATE FORMAT 'YYYY-MM-DD') ELSE CAST(SUBSTR(OrderDate,1,10) AS DATE FORMAT 'YYYY-MM-DD') END AS OrderDate,
CASE WHEN DueDate = 'NULL' THEN CAST('1900-01-01' AS DATE FORMAT 'YYYY-MM-DD') ELSE CAST(SUBSTR(DueDate,1,10) AS DATE FORMAT 'YYYY-MM-DD') END AS DueDate,
CASE WHEN ShipDate = 'NULL' THEN CAST('1900-01-01' AS DATE FORMAT 'YYYY-MM-DD') ELSE CAST(SUBSTR(ShipDate,1,10) AS DATE FORMAT 'YYYY-MM-DD') END AS ShipDate,
CASE WHEN Status = 'NULL' THEN -1 ELSE CAST(Status AS BYTEINT) END AS Status,
CASE WHEN OnlineOrderFlag = 'NULL' THEN -1 ELSE CAST(OnlineOrderFlag AS BYTEINT) END AS OnlineOrderFlag,
CASE WHEN SalesOrderNumber IS NULL THEN 'N/A' ELSE SalesOrderNumber END AS SalesOrderNumber,
CASE WHEN PurchaseOrderNumber IS NULL THEN 'N/A' ELSE PurchaseOrderNumber END AS PurchaseOrderNumber,
CASE WHEN AccountNumber= 'NULL' THEN 'N/A' ELSE AccountNumber END AS AccountNumber,
CASE WHEN TerritoryID1 = 'NULL' THEN -1 ELSE TerritoryID1 END AS TerritoryID1,
CASE WHEN BillToAddressID = 'NULL' THEN -1 ELSE BillToAddressID END AS BillToAddressID,
CASE WHEN ShipToAddressID = 'NULL' THEN -1 ELSE ShipToAddressID END AS ShipToAddressID,
CASE WHEN CreditCardID1 = 'NULL' THEN -1 ELSE CreditCardID1 END AS CreditCardID1,
CASE WHEN CreditCardApprovalCode IS NULL THEN 'N/A' ELSE CreditCardApprovalCode END AS CreditCardApprovalCode,
CASE WHEN CurrencyRateID1 = 'NULL' THEN -1 ELSE CurrencyRateID1 END AS CurrencyRateID1,
CASE WHEN  SubTotal = 'NULL' THEN -1 ELSE  CAST(SubTotal AS DECIMAL(10,2)) END AS SubTotal,
CASE WHEN  TaxAmt = 'NULL' THEN -1 ELSE  CAST(TaxAmt AS DECIMAL(10,2)) END AS TaxAmt,
CASE WHEN  Freight = 'NULL' THEN -1 ELSE  CAST(Freight AS DECIMAL(10,2)) END AS Freight,
CASE WHEN  TotalDue = 'NULL' THEN -1 ELSE  CAST(TotalDue AS DECIMAL(10,2)) END AS TotalDue
FROM DB_STG1.Sales
UNION
--Sales_April1_10
--INSERT INTO DB_STG2.SalesOrderHeader
SELECT DISTINCT
CASE WHEN BusinessEntityID1 = 'NULL' THEN -1 ELSE BusinessEntityID1 END AS BusinessEntityID1,
CASE WHEN SalesOrderID1 = 'NULL' THEN -1 ELSE SalesOrderID1 END AS SalesOrderID1,
CASE WHEN ShipMethodID = 'NULL' THEN -1 ELSE ShipMethodID END AS ShipMethodID,
CASE WHEN BusinessEntityID2 = 'NULL' THEN -1 ELSE BusinessEntityID2 END AS SalesPersonID,
CASE WHEN RevisionNumber = 'NULL' THEN -1 ELSE RevisionNumber END AS RevisionNumber,
CASE WHEN OrderDate = 'NULL' THEN CAST('1900-01-01' AS DATE FORMAT 'YYYY-MM-DD') ELSE CAST(SUBSTR(OrderDate,1,10) AS DATE FORMAT 'YYYY-MM-DD') END AS OrderDate,
CASE WHEN DueDate = 'NULL' THEN CAST('1900-01-01' AS DATE FORMAT 'YYYY-MM-DD') ELSE CAST(SUBSTR(DueDate,1,10) AS DATE FORMAT 'YYYY-MM-DD') END AS DueDate,
CASE WHEN ShipDate = 'NULL' THEN CAST('1900-01-01' AS DATE FORMAT 'YYYY-MM-DD') ELSE CAST(SUBSTR(ShipDate,1,10) AS DATE FORMAT 'YYYY-MM-DD') END AS ShipDate,
CASE WHEN Status = 'NULL' THEN -1 ELSE CAST(Status AS BYTEINT) END AS Status,
CASE WHEN OnlineOrderFlag = 'NULL' THEN -1 ELSE CAST(OnlineOrderFlag AS BYTEINT) END AS OnlineOrderFlag,
CASE WHEN SalesOrderNumber IS NULL THEN 'N/A' ELSE SalesOrderNumber END AS SalesOrderNumber,
CASE WHEN PurchaseOrderNumber IS NULL THEN 'N/A' ELSE PurchaseOrderNumber END AS PurchaseOrderNumber,
CASE WHEN AccountNumber= 'NULL' THEN 'N/A' ELSE AccountNumber END AS AccountNumber,
CASE WHEN TerritoryID1 = 'NULL' THEN -1 ELSE TerritoryID1 END AS TerritoryID1,
CASE WHEN BillToAddressID = 'NULL' THEN -1 ELSE BillToAddressID END AS BillToAddressID,
CASE WHEN ShipToAddressID = 'NULL' THEN -1 ELSE ShipToAddressID END AS ShipToAddressID,
CASE WHEN CreditCardID1 = 'NULL' THEN -1 ELSE CreditCardID1 END AS CreditCardID1,
CASE WHEN CreditCardApprovalCode IS NULL THEN 'N/A' ELSE CreditCardApprovalCode END AS CreditCardApprovalCode,
CASE WHEN CurrencyRateID1 = 'NULL' THEN -1 ELSE CurrencyRateID1 END AS CurrencyRateID1,
CASE WHEN  SubTotal = 'NULL' THEN -1 ELSE  CAST(SubTotal AS DECIMAL(10,2)) END AS SubTotal,
CASE WHEN  TaxAmt = 'NULL' THEN -1 ELSE  CAST(TaxAmt AS DECIMAL(10,2)) END AS TaxAmt,
CASE WHEN  Freight = 'NULL' THEN -1 ELSE  CAST(Freight AS DECIMAL(10,2)) END AS Freight,
CASE WHEN  TotalDue = 'NULL' THEN -1 ELSE  CAST(TotalDue AS DECIMAL(10,2)) END AS TotalDue
FROM DB_STG1.Sales_April_1_10
UNION
-- Sales_April_11_20
--INSERT INTO DB_STG2.SalesOrderHeader
SELECT DISTINCT
CASE WHEN BusinessEntityID1 = 'NULL' THEN -1 ELSE BusinessEntityID1 END AS BusinessEntityID1,
CASE WHEN SalesOrderID1 = 'NULL' THEN -1 ELSE SalesOrderID1 END AS SalesOrderID1,
CASE WHEN ShipMethodID = 'NULL' THEN -1 ELSE ShipMethodID END AS ShipMethodID,
CASE WHEN BusinessEntityID2 = 'NULL' THEN -1 ELSE BusinessEntityID2 END AS SalesPersonID,
CASE WHEN RevisionNumber = 'NULL' THEN -1 ELSE RevisionNumber END AS RevisionNumber,
CASE WHEN OrderDate = 'NULL' THEN CAST('1900-01-01' AS DATE FORMAT 'YYYY-MM-DD') ELSE CAST(SUBSTR(OrderDate,1,10) AS DATE FORMAT 'YYYY-MM-DD') END AS OrderDate,
CASE WHEN DueDate = 'NULL' THEN CAST('1900-01-01' AS DATE FORMAT 'YYYY-MM-DD') ELSE CAST(SUBSTR(DueDate,1,10) AS DATE FORMAT 'YYYY-MM-DD') END AS DueDate,
CASE WHEN ShipDate = 'NULL' THEN CAST('1900-01-01' AS DATE FORMAT 'YYYY-MM-DD') ELSE CAST(SUBSTR(ShipDate,1,10) AS DATE FORMAT 'YYYY-MM-DD') END AS ShipDate,
CASE WHEN Status = 'NULL' THEN -1 ELSE CAST(Status AS BYTEINT) END AS Status,
CASE WHEN OnlineOrderFlag = 'NULL' THEN -1 ELSE CAST(OnlineOrderFlag AS BYTEINT) END AS OnlineOrderFlag,
CASE WHEN SalesOrderNumber IS NULL THEN 'N/A' ELSE SalesOrderNumber END AS SalesOrderNumber,
CASE WHEN PurchaseOrderNumber IS NULL THEN 'N/A' ELSE PurchaseOrderNumber END AS PurchaseOrderNumber,
CASE WHEN AccountNumber= 'NULL' THEN 'N/A' ELSE AccountNumber END AS AccountNumber,
CASE WHEN TerritoryID1 = 'NULL' THEN -1 ELSE TerritoryID1 END AS TerritoryID1,
CASE WHEN BillToAddressID = 'NULL' THEN -1 ELSE BillToAddressID END AS BillToAddressID,
CASE WHEN ShipToAddressID = 'NULL' THEN -1 ELSE ShipToAddressID END AS ShipToAddressID,
CASE WHEN CreditCardID1 = 'NULL' THEN -1 ELSE CreditCardID1 END AS CreditCardID1,
CASE WHEN CreditCardApprovalCode IS NULL THEN 'N/A' ELSE CreditCardApprovalCode END AS CreditCardApprovalCode,
CASE WHEN CurrencyRateID1 = 'NULL' THEN -1 ELSE CurrencyRateID1 END AS CurrencyRateID,
CASE WHEN  SubTotal = 'NULL' THEN -1 ELSE  CAST(SubTotal AS DECIMAL(10,2)) END AS SubTotal,
CASE WHEN  TaxAmt = 'NULL' THEN -1 ELSE  CAST(TaxAmt AS DECIMAL(10,2)) END AS TaxAmt,
CASE WHEN  Freight = 'NULL' THEN -1 ELSE  CAST(Freight AS DECIMAL(10,2)) END AS Freight,
CASE WHEN  TotalDue = 'NULL' THEN -1 ELSE  CAST(TotalDue AS DECIMAL(10,2)) END AS TotalDue
FROM DB_STG1.Sales_April_11_20
UNION
--Sales_April21_30

SELECT DISTINCT
CASE WHEN BusinessEntityID1 = 'NULL' THEN -1 ELSE BusinessEntityID1 END AS BusinessEntityID1,
CASE WHEN SalesOrderID1 = 'NULL' THEN -1 ELSE SalesOrderID1 END AS SalesOrderID1,
CASE WHEN ShipMethodID = 'NULL' THEN -1 ELSE ShipMethodID END AS ShipMethodID,
CASE WHEN BusinessEntityID2 = 'NULL' THEN -1 ELSE BusinessEntityID2 END AS SalesPersonID,
CASE WHEN RevisionNumber = 'NULL' THEN -1 ELSE RevisionNumber END AS RevisionNumber,
CASE WHEN OrderDate = 'NULL' THEN CAST('1900-01-01' AS DATE FORMAT 'YYYY-MM-DD') ELSE CAST(SUBSTR(OrderDate,1,10) AS DATE FORMAT 'YYYY-MM-DD') END AS OrderDate,
CASE WHEN DueDate = 'NULL' THEN CAST('1900-01-01' AS DATE FORMAT 'YYYY-MM-DD') ELSE CAST(SUBSTR(DueDate,1,10) AS DATE FORMAT 'YYYY-MM-DD') END AS DueDate,
CASE WHEN ShipDate = 'NULL' THEN CAST('1900-01-01' AS DATE FORMAT 'YYYY-MM-DD') ELSE CAST(SUBSTR(ShipDate,1,10) AS DATE FORMAT 'YYYY-MM-DD') END AS ShipDate,
CASE WHEN Status = 'NULL' THEN -1 ELSE CAST(Status AS BYTEINT) END AS Status,
CASE WHEN OnlineOrderFlag = 'NULL' THEN -1 ELSE CAST(OnlineOrderFlag AS BYTEINT) END AS OnlineOrderFlag,
CASE WHEN SalesOrderNumber IS NULL THEN 'N/A' ELSE SalesOrderNumber END AS SalesOrderNumber,
CASE WHEN PurchaseOrderNumber IS NULL THEN 'N/A' ELSE PurchaseOrderNumber END AS PurchaseOrderNumber,
CASE WHEN AccountNumber= 'NULL' THEN 'N/A' ELSE AccountNumber END AS AccountNumber,
CASE WHEN TerritoryID1 = 'NULL' THEN -1 ELSE TerritoryID1 END AS TerritoryID1,
CASE WHEN BillToAddressID = 'NULL' THEN -1 ELSE BillToAddressID END AS BillToAddressID,
CASE WHEN ShipToAddressID = 'NULL' THEN -1 ELSE ShipToAddressID END AS ShipToAddressID,
CASE WHEN CreditCardID1 = 'NULL' THEN -1 ELSE CreditCardID1 END AS CreditCardID1,
CASE WHEN CreditCardApprovalCode IS NULL THEN 'N/A' ELSE CreditCardApprovalCode END AS CreditCardApprovalCode,
CASE WHEN CurrencyRateID1 = 'NULL' THEN -1 ELSE CurrencyRateID1 END AS CurrencyRateID,
CASE WHEN  SubTotal = 'NULL' THEN -1 ELSE  CAST(SubTotal AS DECIMAL(10,2)) END AS SubTotal,
CASE WHEN  TaxAmt = 'NULL' THEN -1 ELSE  CAST(TaxAmt AS DECIMAL(10,2)) END AS TaxAmt,
CASE WHEN  Freight = 'NULL' THEN -1 ELSE  CAST(Freight AS DECIMAL(10,2)) END AS Freight,
CASE WHEN  TotalDue = 'NULL' THEN -1 ELSE  CAST(TotalDue AS DECIMAL(10,2)) END AS TotalDue
FROM DB_STG1.Sales_April_21_30
UNION
--Sales_May06_10
SELECT DISTINCT
CASE WHEN BusinessEntityID1 = 'NULL' THEN -1 ELSE BusinessEntityID1 END AS BusinessEntityID1,
CASE WHEN SalesOrderID1 = 'NULL' THEN -1 ELSE SalesOrderID1 END AS SalesOrderID1,
CASE WHEN ShipMethodID = 'NULL' THEN -1 ELSE ShipMethodID END AS ShipMethodID,
CASE WHEN BusinessEntityID2 = 'NULL' THEN -1 ELSE BusinessEntityID2 END AS SalesPersonID,
CASE WHEN RevisionNumber = 'NULL' THEN -1 ELSE RevisionNumber END AS RevisionNumber,
CASE WHEN OrderDate = 'NULL' THEN CAST('1900-01-01' AS DATE FORMAT 'YYYY-MM-DD') ELSE CAST(SUBSTR(OrderDate,1,10) AS DATE FORMAT 'YYYY-MM-DD') END AS OrderDate,
CASE WHEN DueDate = 'NULL' THEN CAST('1900-01-01' AS DATE FORMAT 'YYYY-MM-DD') ELSE CAST(SUBSTR(DueDate,1,10) AS DATE FORMAT 'YYYY-MM-DD') END AS DueDate,
CASE WHEN ShipDate = 'NULL' THEN CAST('1900-01-01' AS DATE FORMAT 'YYYY-MM-DD') ELSE CAST(SUBSTR(ShipDate,1,10) AS DATE FORMAT 'YYYY-MM-DD') END AS ShipDate,
CASE WHEN Status = 'NULL' THEN -1 ELSE CAST(Status AS BYTEINT) END AS Status,
CASE WHEN OnlineOrderFlag = 'NULL' THEN -1 ELSE CAST(OnlineOrderFlag AS BYTEINT) END AS OnlineOrderFlag,
CASE WHEN SalesOrderNumber IS NULL THEN 'N/A' ELSE SalesOrderNumber END AS SalesOrderNumber,
CASE WHEN PurchaseOrderNumber IS NULL THEN 'N/A' ELSE PurchaseOrderNumber END AS PurchaseOrderNumber,
CASE WHEN AccountNumber= 'NULL' THEN 'N/A' ELSE AccountNumber END AS AccountNumber,
CASE WHEN TerritoryID1 = 'NULL' THEN -1 ELSE TerritoryID1 END AS TerritoryID1,
CASE WHEN BillToAddressID = 'NULL' THEN -1 ELSE BillToAddressID END AS BillToAddressID,
CASE WHEN ShipToAddressID = 'NULL' THEN -1 ELSE ShipToAddressID END AS ShipToAddressID,
CASE WHEN CreditCardID1 = 'NULL' THEN -1 ELSE CreditCardID1 END AS CreditCardID1,
CASE WHEN CreditCardApprovalCode IS NULL THEN 'N/A' ELSE CreditCardApprovalCode END AS CreditCardApprovalCode,
CASE WHEN CurrencyRateID1 = 'NULL' THEN -1 ELSE CurrencyRateID1 END AS CurrencyRateID,
CASE WHEN  SubTotal = 'NULL' THEN -1 ELSE  CAST(SubTotal AS DECIMAL(10,2)) END AS SubTotal,
CASE WHEN  TaxAmt = 'NULL' THEN -1 ELSE  CAST(TaxAmt AS DECIMAL(10,2)) END AS TaxAmt,
CASE WHEN  Freight = 'NULL' THEN -1 ELSE  CAST(Freight AS DECIMAL(10,2)) END AS Freight,
CASE WHEN  TotalDue = 'NULL' THEN -1 ELSE  CAST(TotalDue AS DECIMAL(10,2)) END AS TotalDue
FROM DB_STG1.Sales_May_06_10
UNION
--Sales_May11_20
SELECT DISTINCT
CASE WHEN BusinessEntityID1 = 'NULL' THEN -1 ELSE BusinessEntityID1 END AS BusinessEntityID1,
CASE WHEN SalesOrderID1 = 'NULL' THEN -1 ELSE SalesOrderID1 END AS SalesOrderID1,
CASE WHEN ShipMethodID = 'NULL' THEN -1 ELSE ShipMethodID END AS ShipMethodID,
CASE WHEN BusinessEntityID2 = 'NULL' THEN -1 ELSE BusinessEntityID2 END AS SalesPersonID,
CASE WHEN RevisionNumber = 'NULL' THEN -1 ELSE RevisionNumber END AS RevisionNumber,
CASE WHEN OrderDate = 'NULL' THEN CAST('1900-01-01' AS DATE FORMAT 'YYYY-MM-DD') ELSE CAST(SUBSTR(OrderDate,1,10) AS DATE FORMAT 'YYYY-MM-DD') END AS OrderDate,
CASE WHEN DueDate = 'NULL' THEN CAST('1900-01-01' AS DATE FORMAT 'YYYY-MM-DD') ELSE CAST(SUBSTR(DueDate,1,10) AS DATE FORMAT 'YYYY-MM-DD') END AS DueDate,
CASE WHEN ShipDate = 'NULL' THEN CAST('1900-01-01' AS DATE FORMAT 'YYYY-MM-DD') ELSE CAST(SUBSTR(ShipDate,1,10) AS DATE FORMAT 'YYYY-MM-DD') END AS ShipDate,
CASE WHEN Status = 'NULL' THEN -1 ELSE CAST(Status AS BYTEINT) END AS Status,
CASE WHEN OnlineOrderFlag = 'NULL' THEN -1 ELSE CAST(OnlineOrderFlag AS BYTEINT) END AS OnlineOrderFlag,
CASE WHEN SalesOrderNumber IS NULL THEN 'N/A' ELSE SalesOrderNumber END AS SalesOrderNumber,
CASE WHEN PurchaseOrderNumber IS NULL THEN 'N/A' ELSE PurchaseOrderNumber END AS PurchaseOrderNumber,
CASE WHEN AccountNumber= 'NULL' THEN 'N/A' ELSE AccountNumber END AS AccountNumber,
CASE WHEN TerritoryID1 = 'NULL' THEN -1 ELSE TerritoryID1 END AS TerritoryID1,
CASE WHEN BillToAddressID = 'NULL' THEN -1 ELSE BillToAddressID END AS BillToAddressID,
CASE WHEN ShipToAddressID = 'NULL' THEN -1 ELSE ShipToAddressID END AS ShipToAddressID,
CASE WHEN CreditCardID1 = 'NULL' THEN -1 ELSE CreditCardID1 END AS CreditCardID1,
CASE WHEN CreditCardApprovalCode IS NULL THEN 'N/A' ELSE CreditCardApprovalCode END AS CreditCardApprovalCode,
CASE WHEN CurrencyRateID1 = 'NULL' THEN -1 ELSE CurrencyRateID1 END AS CurrencyRateID,
CASE WHEN  SubTotal = 'NULL' THEN -1 ELSE  CAST(SubTotal AS DECIMAL(10,2)) END AS SubTotal,
CASE WHEN  TaxAmt = 'NULL' THEN -1 ELSE  CAST(TaxAmt AS DECIMAL(10,2)) END AS TaxAmt,
CASE WHEN  Freight = 'NULL' THEN -1 ELSE  CAST(Freight AS DECIMAL(10,2)) END AS Freight,
CASE WHEN  TotalDue = 'NULL' THEN -1 ELSE  CAST(TotalDue AS DECIMAL(10,2)) END AS TotalDue
FROM DB_STG1.Sales_May_11_20
UNION
--Sales_May21_31
SELECT DISTINCT
CASE WHEN BusinessEntityID1 = 'NULL' THEN -1 ELSE BusinessEntityID1 END AS BusinessEntityID1,
CASE WHEN SalesOrderID1 = 'NULL' THEN -1 ELSE SalesOrderID1 END AS SalesOrderID1,
CASE WHEN ShipMethodID = 'NULL' THEN -1 ELSE ShipMethodID END AS ShipMethodID,
CASE WHEN BusinessEntityID2 = 'NULL' THEN -1 ELSE BusinessEntityID2 END AS SalesPersonID,
CASE WHEN RevisionNumber = 'NULL' THEN -1 ELSE RevisionNumber END AS RevisionNumber,
CASE WHEN OrderDate = 'NULL' THEN CAST('1900-01-01' AS DATE FORMAT 'YYYY-MM-DD') ELSE CAST(SUBSTR(OrderDate,1,10) AS DATE FORMAT 'YYYY-MM-DD') END AS OrderDate,
CASE WHEN DueDate = 'NULL' THEN CAST('1900-01-01' AS DATE FORMAT 'YYYY-MM-DD') ELSE CAST(SUBSTR(DueDate,1,10) AS DATE FORMAT 'YYYY-MM-DD') END AS DueDate,
CASE WHEN ShipDate = 'NULL' THEN CAST('1900-01-01' AS DATE FORMAT 'YYYY-MM-DD') ELSE CAST(SUBSTR(ShipDate,1,10) AS DATE FORMAT 'YYYY-MM-DD') END AS ShipDate,
CASE WHEN Status = 'NULL' THEN -1 ELSE CAST(Status AS BYTEINT) END AS Status,
CASE WHEN OnlineOrderFlag = 'NULL' THEN -1 ELSE CAST(OnlineOrderFlag AS BYTEINT) END AS OnlineOrderFlag,
CASE WHEN SalesOrderNumber IS NULL THEN 'N/A' ELSE SalesOrderNumber END AS SalesOrderNumber,
CASE WHEN PurchaseOrderNumber IS NULL THEN 'N/A' ELSE PurchaseOrderNumber END AS PurchaseOrderNumber,
CASE WHEN AccountNumber= 'NULL' THEN 'N/A' ELSE AccountNumber END AS AccountNumber,
CASE WHEN TerritoryID1 = 'NULL' THEN -1 ELSE TerritoryID1 END AS TerritoryID1,
CASE WHEN BillToAddressID = 'NULL' THEN -1 ELSE BillToAddressID END AS BillToAddressID,
CASE WHEN ShipToAddressID = 'NULL' THEN -1 ELSE ShipToAddressID END AS ShipToAddressID,
CASE WHEN CreditCardID1 = 'NULL' THEN -1 ELSE CreditCardID1 END AS CreditCardID1,
CASE WHEN CreditCardApprovalCode IS NULL THEN 'N/A' ELSE CreditCardApprovalCode END AS CreditCardApprovalCode,
CASE WHEN CurrencyRateID1 = 'NULL' THEN -1 ELSE CurrencyRateID1 END AS CurrencyRateID2,
CASE WHEN  SubTotal = 'NULL' THEN -1 ELSE  CAST(SubTotal AS DECIMAL(10,2)) END AS SubTotal,
CASE WHEN  TaxAmt = 'NULL' THEN -1 ELSE  CAST(TaxAmt AS DECIMAL(10,2)) END AS TaxAmt,
CASE WHEN  Freight = 'NULL' THEN -1 ELSE  CAST(Freight AS DECIMAL(10,2)) END AS Freight,
CASE WHEN  TotalDue = 'NULL' THEN -1 ELSE  CAST(TotalDue AS DECIMAL(10,2)) END AS TotalDue
FROM DB_STG1.Sales_May_21_31
UNION
SELECT DISTINCT
CASE WHEN BusinessEntityID = 'NULL' THEN -1 ELSE BusinessEntityID END AS BusinessEntityID,
CASE WHEN SalesOrderID1 = 'NULL' THEN -1 ELSE SalesOrderID1 END AS SalesOrderID1,
CASE WHEN ShipMethodID = 'NULL' THEN -1 ELSE ShipMethodID END AS ShipMethodID,
CASE WHEN SalesPersonID2 = 'NULL' THEN -1 ELSE SalesPersonID2 END AS SalesPersonID,
CASE WHEN RevisionNumber1 = 'NULL' THEN -1 ELSE RevisionNumber1 END AS RevisionNumber,
CASE WHEN OrderDate IS NULL THEN CAST('01/01/1900' AS DATE FORMAT 'MM/DD/YYYY') ELSE CAST(SUBSTR(OrderDate,1,10) AS DATE FORMAT 'MM/DD/YYYY') END AS OrderDate,
CASE WHEN DueDate = 'NULL' THEN CAST('01/01/1900' AS DATE FORMAT 'MM/DD/YYYY') ELSE CAST(SUBSTR(DueDate,1,10) AS DATE FORMAT 'MM/DD/YYYY') END AS DueDate,
CASE WHEN ShipDate = 'NULL' THEN CAST('01/01/1900' AS DATE FORMAT 'MM/DD/YYYY') ELSE CAST(SUBSTR(ShipDate,1,10) AS DATE FORMAT 'MM/DD/YYYY') END AS ShipDate,
CASE WHEN Status = 'NULL' THEN -1 ELSE CAST(Status AS BYTEINT) END AS Status,
CASE WHEN OnlineOrderFlag = 'NULL' THEN -1 ELSE CAST(OnlineOrderFlag AS BYTEINT) END AS OnlineOrderFlag,
CASE WHEN SalesOrderNumber1 IS NULL THEN 'N/A' ELSE SalesOrderNumber1 END AS SalesOrderNumber,
CASE WHEN PurchaseOrderNumber1 IS NULL THEN 'N/A' ELSE PurchaseOrderNumber1 END AS PurchaseOrderNumber,
CASE WHEN AccountNumber= 'NULL' THEN 'N/A' ELSE AccountNumber END AS AccountNumber,
CASE WHEN TerritoryID = 'NULL' THEN -1 ELSE TerritoryID END AS TerritoryID1,
CASE WHEN BillToAddressID = 'NULL' THEN -1 ELSE BillToAddressID END AS BillToAddressID,
CASE WHEN ShipToAddressID = 'NULL' THEN -1 ELSE ShipToAddressID END AS ShipToAddressID,
CASE WHEN CreditCardID = 'NULL' THEN -1 ELSE CreditCardID END AS CreditCardID,
CASE WHEN CreditCardApprovalCode IS NULL THEN 'N/A' ELSE CreditCardApprovalCode END AS CreditCardApprovalCode,
CASE WHEN CurrencyRateID = 'NULL' THEN -1 ELSE CurrencyRateID END AS CurrencyRateID2,
CASE WHEN  SubTotal = 'NULL' THEN -1 ELSE  CAST(SubTotal AS DECIMAL(10,2)) END AS SubTotal,
CASE WHEN  TaxAmt = 'NULL' THEN -1 ELSE  CAST(TaxAmt AS DECIMAL(10,2)) END AS TaxAmt,
CASE WHEN  Freight = 'NULL' THEN -1 ELSE  CAST(Freight AS DECIMAL(10,2)) END AS Freight,
CASE WHEN  TotalDue = 'NULL' THEN -1 ELSE  CAST(TotalDue AS DECIMAL(10,2)) END AS TotalDue
FROM DB_STG1.Sales2;

INSERT INTO DB_STG2.SalesOrderHeaderSalesReason
SELECT DISTINCT 
    CASE WHEN BusinessEntityID1 ='NULL' THEN -1 ELSE BusinessEntityID1 END AS BusinessEntityID1,
    CASE WHEN SalesOrderID1 ='NULL' THEN -1 ELSE SalesOrderID1 END AS SalesOrderID,
	CASE WHEN SalesReasonID1 ='NULL' THEN -1 ELSE SalesReasonID1 END AS SalesReasonID
FROM DB_STG1.Sales
UNION
SELECT DISTINCT 
	CASE WHEN BusinessEntityID1 ='NULL' THEN -1 ELSE BusinessEntityID1 END AS BusinessEntityID1,
    CASE WHEN SalesOrderID1 ='NULL' THEN -1 ELSE SalesOrderID1 END AS SalesOrderID,
	CASE WHEN SalesReasonID1 ='NULL' THEN -1 ELSE SalesReasonID1 END AS SalesReasonID
FROM DB_STG1.Sales_April_1_10
UNION
SELECT DISTINCT 
	CASE WHEN BusinessEntityID1 ='NULL' THEN -1 ELSE BusinessEntityID1 END AS BusinessEntityID1,
    CASE WHEN SalesOrderID1 ='NULL' THEN -1 ELSE SalesOrderID1 END AS SalesOrderID,
	CASE WHEN SalesReasonID1 ='NULL' THEN -1 ELSE SalesReasonID1 END AS SalesReasonID
FROM DB_STG1.Sales_April_11_20
UNION
SELECT DISTINCT 
	CASE WHEN BusinessEntityID1 ='NULL' THEN -1 ELSE BusinessEntityID1 END AS BusinessEntityID1,
    CASE WHEN SalesOrderID1 ='NULL' THEN -1 ELSE SalesOrderID1 END AS SalesOrderID,
	CASE WHEN SalesReasonID1 ='NULL' THEN -1 ELSE SalesReasonID1 END AS SalesReasonID
FROM DB_STG1.Sales_April_21_30
UNION
SELECT DISTINCT 
	CASE WHEN BusinessEntityID1 ='NULL' THEN -1 ELSE BusinessEntityID1 END AS BusinessEntityID1,
    CASE WHEN SalesOrderID1 ='NULL' THEN -1 ELSE SalesOrderID1 END AS SalesOrderID,
	CASE WHEN SalesReasonID1 ='NULL' THEN -1 ELSE SalesReasonID1 END AS SalesReasonID
FROM DB_STG1.Sales_May_06_10
UNION
SELECT DISTINCT 
	CASE WHEN BusinessEntityID1 ='NULL' THEN -1 ELSE BusinessEntityID1 END AS BusinessEntityID1,
    CASE WHEN SalesOrderID1 ='NULL' THEN -1 ELSE SalesOrderID1 END AS SalesOrderID,
	CASE WHEN SalesReasonID1 ='NULL' THEN -1 ELSE SalesReasonID1 END AS SalesReasonID
FROM DB_STG1.Sales_May_11_20
UNION
SELECT DISTINCT 
	CASE WHEN BusinessEntityID1 ='NULL' THEN -1 ELSE BusinessEntityID1 END AS BusinessEntityID1,
    CASE WHEN SalesOrderID1 ='NULL' THEN -1 ELSE SalesOrderID1 END AS SalesOrderID,
	CASE WHEN SalesReasonID1 ='NULL' THEN -1 ELSE SalesReasonID1 END AS SalesReasonID
FROM DB_STG1.Sales_May_21_31;

--Sales
INSERT INTO DB_STG2.SalesPerson
SELECT DISTINCT
CASE WHEN BusinessEntityID2 = 'NULL' THEN -1 ELSE BusinessEntityID2 END AS BusinessEntityID2,
CASE WHEN TerritoryID1 = 'NULL' THEN -1 ELSE TerritoryID1 END AS TerritoryID1,
CASE WHEN  SalesQuota2 = 'NULL' THEN -1 ELSE  CAST(SalesQuota2 AS DECIMAL(10,2)) END AS SalesQuota,
CASE WHEN  Bonus = 'NULL' THEN -1 ELSE  CAST(Bonus AS DECIMAL(10,2)) END AS Bonus,
CASE WHEN  CommissionPct = 'NULL' THEN -1 ELSE  CAST(CommissionPct AS DECIMAL(10,2)) END AS CommissionPct,
CASE WHEN  SalesYTD2 = 'NULL' THEN -1 ELSE  CAST(SalesYTD2 AS DECIMAL(10,2)) END AS SalesYTD,
CASE WHEN  SalesLastYear1 = 'NULL' THEN -1 ELSE  CAST(SalesLastYear1 AS DECIMAL(10,2)) END AS SalesLastYear
FROM DB_STG1.Sales
UNION
--Sales_April1_10
--INSERT INTO DB_STG2.SalesPerson
SELECT DISTINCT
CASE WHEN BusinessEntityID2 = 'NULL' THEN -1 ELSE BusinessEntityID2 END AS BusinessEntityID2,
CASE WHEN TerritoryID1 = 'NULL' THEN -1 ELSE TerritoryID1 END AS TerritoryID1,
CASE WHEN  SalesQuota2 = 'NULL' THEN -1 ELSE  CAST(SalesQuota2 AS DECIMAL(10,2)) END AS SalesQuota2,
CASE WHEN  Bonus = 'NULL' THEN -1 ELSE  CAST(Bonus AS DECIMAL(10,2)) END AS Bonus,
CASE WHEN  CommissionPct = 'NULL' THEN -1 ELSE  CAST(CommissionPct AS DECIMAL(10,2)) END AS CommissionPct,
CASE WHEN  SalesYTD2 = 'NULL' THEN -1 ELSE  CAST(SalesYTD2 AS DECIMAL(10,2)) END AS SalesYTD,
CASE WHEN  SalesLastYear1 = 'NULL' THEN -1 ELSE  CAST(SalesLastYear1 AS DECIMAL(10,2)) END AS SalesLastYear
FROM DB_STG1.Sales_April_1_10
UNION
--Sales_April11_20
--INSERT INTO DB_STG2.SalesPerson
SELECT DISTINCT
CASE WHEN BusinessEntityID2 = 'NULL' THEN -1 ELSE BusinessEntityID2 END AS BusinessEntityID2,
CASE WHEN TerritoryID1 = 'NULL' THEN -1 ELSE TerritoryID1 END AS TerritoryID1,
CASE WHEN  SalesQuota2 = 'NULL' THEN -1 ELSE  CAST(SalesQuota2 AS DECIMAL(10,2)) END AS SalesQuota2,
CASE WHEN  Bonus = 'NULL' THEN -1 ELSE  CAST(Bonus AS DECIMAL(10,2)) END AS Bonus,
CASE WHEN  CommissionPct = 'NULL' THEN -1 ELSE  CAST(CommissionPct AS DECIMAL(10,2)) END AS CommissionPct,
CASE WHEN  SalesYTD2 = 'NULL' THEN -1 ELSE  CAST(SalesYTD2 AS DECIMAL(10,2)) END AS SalesYTD,
CASE WHEN  SalesLastYear1 = 'NULL' THEN -1 ELSE  CAST(SalesLastYear1 AS DECIMAL(10,2)) END AS SalesLastYear
FROM DB_STG1.Sales_April_11_20
UNION
--Sales_April21_30
--INSERT INTO DB_STG2.SalesPerson
SELECT DISTINCT
CASE WHEN BusinessEntityID2 = 'NULL' THEN -1 ELSE BusinessEntityID2 END AS BusinessEntityID2,
CASE WHEN TerritoryID1 = 'NULL' THEN -1 ELSE TerritoryID1 END AS TerritoryID1,
CASE WHEN  SalesQuota2 = 'NULL' THEN -1 ELSE  CAST(SalesQuota2 AS DECIMAL(10,2)) END AS SalesQuota2,
CASE WHEN  Bonus = 'NULL' THEN -1 ELSE  CAST(Bonus AS DECIMAL(10,2)) END AS Bonus,
CASE WHEN  CommissionPct = 'NULL' THEN -1 ELSE  CAST(CommissionPct AS DECIMAL(10,2)) END AS CommissionPct,
CASE WHEN  SalesYTD2 = 'NULL' THEN -1 ELSE  CAST(SalesYTD2 AS DECIMAL(10,2)) END AS SalesYTD,
CASE WHEN  SalesLastYear1 = 'NULL' THEN -1 ELSE  CAST(SalesLastYear1 AS DECIMAL(10,2)) END AS SalesLastYear
FROM DB_STG1.Sales_April_21_30
UNION
--Sales_May06_10
--INSERT INTO DB_STG2.SalesPerson
SELECT DISTINCT
CASE WHEN BusinessEntityID2 = 'NULL' THEN -1 ELSE BusinessEntityID2 END AS BusinessEntityID2,
CASE WHEN TerritoryID1 = 'NULL' THEN -1 ELSE TerritoryID1 END AS TerritoryID1,
CASE WHEN  SalesQuota2 = 'NULL' THEN -1 ELSE  CAST(SalesQuota2 AS DECIMAL(10,2)) END AS SalesQuota,
CASE WHEN  Bonus = 'NULL' THEN -1 ELSE  CAST(Bonus AS DECIMAL(10,2)) END AS Bonus,
CASE WHEN  CommissionPct = 'NULL' THEN -1 ELSE  CAST(CommissionPct AS DECIMAL(10,2)) END AS CommissionPct,
CASE WHEN  SalesYTD2 = 'NULL' THEN -1 ELSE  CAST(SalesYTD2 AS DECIMAL(10,2)) END AS SalesYTD,
CASE WHEN  SalesLastYear1 = 'NULL' THEN -1 ELSE  CAST(SalesLastYear1 AS DECIMAL(10,2)) END AS SalesLastYear
FROM DB_STG1.Sales_May_06_10
UNION
--Sales_May11_20
--INSERT INTO DB_STG2.SalesPerson
SELECT DISTINCT
CASE WHEN BusinessEntityID2 = 'NULL' THEN -1 ELSE BusinessEntityID2 END AS BusinessEntityID2,
CASE WHEN TerritoryID1 = 'NULL' THEN -1 ELSE TerritoryID1 END AS TerritoryID1,
CASE WHEN  SalesQuota2 = 'NULL' THEN -1 ELSE  CAST(SalesQuota2 AS DECIMAL(10,2)) END AS SalesQuota,
CASE WHEN  Bonus = 'NULL' THEN -1 ELSE  CAST(Bonus AS DECIMAL(10,2)) END AS Bonus,
CASE WHEN  CommissionPct = 'NULL' THEN -1 ELSE  CAST(CommissionPct AS DECIMAL(10,2)) END AS CommissionPct,
CASE WHEN  SalesYTD2 = 'NULL' THEN -1 ELSE  CAST(SalesYTD2 AS DECIMAL(10,2)) END AS SalesYTD,
CASE WHEN  SalesLastYear1 = 'NULL' THEN -1 ELSE  CAST(SalesLastYear1 AS DECIMAL(10,2)) END AS SalesLastYear
FROM DB_STG1.Sales_May_11_20
UNION
--Sales_May21_31
--INSERT INTO DB_STG2.SalesPerson
SELECT DISTINCT
CASE WHEN BusinessEntityID2 = 'NULL' THEN -1 ELSE BusinessEntityID2 END AS BusinessEntityID2,
CASE WHEN TerritoryID1 = 'NULL' THEN -1 ELSE TerritoryID1 END AS TerritoryID1,
CASE WHEN  SalesQuota2 = 'NULL' THEN -1 ELSE  CAST(SalesQuota2 AS DECIMAL(10,2)) END AS SalesQuota,
CASE WHEN  Bonus = 'NULL' THEN -1 ELSE  CAST(Bonus AS DECIMAL(10,2)) END AS Bonus,
CASE WHEN  CommissionPct = 'NULL' THEN -1 ELSE  CAST(CommissionPct AS DECIMAL(10,2)) END AS CommissionPct,
CASE WHEN  SalesYTD2 = 'NULL' THEN -1 ELSE  CAST(SalesYTD2 AS DECIMAL(10,2)) END AS SalesYTD,
CASE WHEN  SalesLastYear1 = 'NULL' THEN -1 ELSE  CAST(SalesLastYear1 AS DECIMAL(10,2)) END AS SalesLastYear
FROM DB_STG1.Sales_May_21_31;


INSERT INTO DB_STG2.SalesPersonQuotaHistory
SELECT DISTINCT 
    CASE WHEN  BusinessEntityID2 ='NULL' THEN -1 ELSE  BusinessEntityID2 END AS  BusinessEntityID,
    CASE WHEN  SalesQuota1 = 'NULL' THEN -1 ELSE  CAST(SalesQuota1 AS DECIMAL(10,2)) END AS SalesQuota,
	CASE WHEN QuotaDate = 'NULL' THEN CAST('1900-01-01' AS DATE FORMAT 'YYYY-MM-DD') ELSE CAST(SUBSTR(QuotaDate,1,10) AS DATE FORMAT 'YYYY-MM-DD') END AS QuotaDate
FROM DB_STG1.Sales
UNION
SELECT DISTINCT 
	CASE WHEN  BusinessEntityID2 ='NULL' THEN -1 ELSE  BusinessEntityID2 END AS  BusinessEntityID,
    CASE WHEN  SalesQuota1 = 'NULL' THEN -1 ELSE  CAST(SalesQuota1 AS DECIMAL(10,2)) END AS SalesQuota,
	CASE WHEN QuotaDate = 'NULL' THEN CAST('1900-01-01' AS DATE FORMAT 'YYYY-MM-DD') ELSE CAST(SUBSTR(QuotaDate,1,10) AS DATE FORMAT 'YYYY-MM-DD') END AS QuotaDate
FROM DB_STG1.Sales_April_1_10
UNION
SELECT DISTINCT 
	CASE WHEN  BusinessEntityID2 ='NULL' THEN -1 ELSE  BusinessEntityID2 END AS  BusinessEntityID,
    CASE WHEN  SalesQuota1 = 'NULL' THEN -1 ELSE  CAST(SalesQuota1 AS DECIMAL(10,2)) END AS SalesQuota,
	CASE WHEN QuotaDate = 'NULL' THEN CAST('1900-01-01' AS DATE FORMAT 'YYYY-MM-DD') ELSE CAST(SUBSTR(QuotaDate,1,10) AS DATE FORMAT 'YYYY-MM-DD') END AS QuotaDate
FROM DB_STG1.Sales_April_11_20
UNION
SELECT DISTINCT 
CASE WHEN  BusinessEntityID2 ='NULL' THEN -1 ELSE  BusinessEntityID2 END AS  BusinessEntityID,
    CASE WHEN  SalesQuota1 = 'NULL' THEN -1 ELSE  CAST(SalesQuota1 AS DECIMAL(10,2)) END AS SalesQuota,
	CASE WHEN QuotaDate = 'NULL' THEN CAST('1900-01-01' AS DATE FORMAT 'YYYY-MM-DD') ELSE CAST(SUBSTR(QuotaDate,1,10) AS DATE FORMAT 'YYYY-MM-DD') END AS QuotaDate
FROM DB_STG1.Sales_April_21_30
UNION
SELECT DISTINCT 
	CASE WHEN  BusinessEntityID2 ='NULL' THEN -1 ELSE  BusinessEntityID2 END AS  BusinessEntityID,
    CASE WHEN  SalesQuota1 = 'NULL' THEN -1 ELSE  CAST(SalesQuota1 AS DECIMAL(10,2)) END AS SalesQuota,
	CASE WHEN QuotaDate = 'NULL' THEN CAST('1900-01-01' AS DATE FORMAT 'YYYY-MM-DD') ELSE CAST(SUBSTR(QuotaDate,1,10) AS DATE FORMAT 'YYYY-MM-DD') END AS QuotaDate
FROM DB_STG1.Sales_May_06_10
UNION
SELECT DISTINCT 
	CASE WHEN  BusinessEntityID2 ='NULL' THEN -1 ELSE  BusinessEntityID2 END AS  BusinessEntityID,
    CASE WHEN  SalesQuota1 = 'NULL' THEN -1 ELSE  CAST(SalesQuota1 AS DECIMAL(10,2)) END AS SalesQuota,
	CASE WHEN QuotaDate = 'NULL' THEN CAST('1900-01-01' AS DATE FORMAT 'YYYY-MM-DD') ELSE CAST(SUBSTR(QuotaDate,1,10) AS DATE FORMAT 'YYYY-MM-DD') END AS QuotaDate
FROM DB_STG1.Sales_May_11_20
UNION
SELECT DISTINCT 
	CASE WHEN  BusinessEntityID2 ='NULL' THEN -1 ELSE  BusinessEntityID2 END AS  BusinessEntityID,
    CASE WHEN  SalesQuota1 = 'NULL' THEN -1 ELSE  CAST(SalesQuota1 AS DECIMAL(10,2)) END AS SalesQuota,
	CASE WHEN QuotaDate = 'NULL' THEN CAST('1900-01-01' AS DATE FORMAT 'YYYY-MM-DD') ELSE CAST(SUBSTR(QuotaDate,1,10) AS DATE FORMAT 'YYYY-MM-DD') END AS QuotaDate
FROM DB_STG1.Sales_May_21_31;

INSERT INTO DB_STG2.SalesReason
SELECT DISTINCT 
	CASE WHEN SalesReasonID1 ='NULL' THEN -1 ELSE SalesReasonID1 END AS SalesReasonID,
	CASE WHEN Name1 = 'NULL' THEN 'N/A' ELSE Name1 END AS Name1,
	CASE WHEN ReasonType = 'NULL' THEN 'N/A' ELSE ReasonType END AS ReasonType
FROM DB_STG1.Sales;

INSERT INTO DB_STG2.SalesTerritory
SELECT DISTINCT 
    CASE WHEN TerritoryID1 ='NULL' THEN -1 ELSE TerritoryID1 END AS TerritoryID,
	CASE WHEN Name3 ='NULL' THEN 'N/A' ELSE Name3 END AS Name3,
	CASE WHEN  CountryRegionCode ='NULL' THEN 'N/A' ELSE  CountryRegionCode END AS  CountryRegionCode,
	CASE WHEN "Group" ='NULL' THEN 'N/A' ELSE "Group" END AS "Group",
	CASE WHEN SalesYtd1 ='NULL' THEN -1 ELSE CAST(SalesYtd1 AS DECIMAL(15,2)) END AS SalesYtd,
	CASE WHEN SalesLastYear1 ='NULL' THEN -1 ELSE CAST(SalesLastYear1 AS DECIMAL(15,2)) END AS SalesLastYear,
	CASE WHEN CostYtd ='NULL' THEN -1 ELSE CAST(CostYtd AS DECIMAL(15,2)) END AS CostYtd,
	CASE WHEN CostLastYear ='NULL' THEN -1 ELSE CAST(CostLastYear AS DECIMAL(15,2)) END AS CostLastYear
FROM DB_STG1.Sales
UNION
SELECT DISTINCT 
	CASE WHEN TerritoryID1 ='NULL' THEN -1 ELSE TerritoryID1 END AS TerritoryID,
	CASE WHEN Name3 ='NULL' THEN 'N/A' ELSE Name3 END AS Name1,
	CASE WHEN  CountryRegionCode ='NULL' THEN 'N/A' ELSE  CountryRegionCode END AS  CountryRegionCode,
	CASE WHEN "Group" ='NULL' THEN 'N/A' ELSE "Group" END AS "Group",
	CASE WHEN SalesYtd1 ='NULL' THEN -1 ELSE CAST(SalesYtd1 AS DECIMAL(15,2)) END AS SalesYtd,
	CASE WHEN SalesLastYear1 ='NULL' THEN -1 ELSE CAST(SalesLastYear1 AS DECIMAL(15,2)) END AS SalesLastYear,
	CASE WHEN CostYtd ='NULL' THEN -1 ELSE CAST(CostYtd AS DECIMAL(15,2)) END AS CostYtd,
	CASE WHEN CostLastYear ='NULL' THEN -1 ELSE CAST(CostLastYear AS DECIMAL(15,2)) END AS CostLastYear
FROM DB_STG1.Sales_April_1_10
UNION
SELECT DISTINCT 
	CASE WHEN TerritoryID1 ='NULL' THEN -1 ELSE TerritoryID1 END AS TerritoryID,
	CASE WHEN Name3 ='NULL' THEN 'N/A' ELSE Name3 END AS Name1,
	CASE WHEN  CountryRegionCode ='NULL' THEN 'N/A' ELSE  CountryRegionCode END AS  CountryRegionCode,
	CASE WHEN "Group" ='NULL' THEN 'N/A' ELSE "Group" END AS "Group",
	CASE WHEN SalesYtd1 ='NULL' THEN -1 ELSE CAST(SalesYtd1 AS DECIMAL(15,2)) END AS SalesYtd,
	CASE WHEN SalesLastYear1 ='NULL' THEN -1 ELSE CAST(SalesLastYear1 AS DECIMAL(15,2)) END AS SalesLastYear,
	CASE WHEN CostYtd ='NULL' THEN -1 ELSE CAST(CostYtd AS DECIMAL(15,2)) END AS CostYtd,
	CASE WHEN CostLastYear ='NULL' THEN -1 ELSE CAST(CostLastYear AS DECIMAL(15,2)) END AS CostLastYear
FROM DB_STG1.Sales_April_11_20
UNION
SELECT DISTINCT 
	CASE WHEN TerritoryID1 ='NULL' THEN -1 ELSE TerritoryID1 END AS TerritoryID,
	CASE WHEN Name3 ='NULL' THEN 'N/A' ELSE Name3 END AS Name1,
	CASE WHEN  CountryRegionCode ='NULL' THEN 'N/A' ELSE  CountryRegionCode END AS  CountryRegionCode,
	CASE WHEN "Group" ='NULL' THEN 'N/A' ELSE "Group" END AS "Group",
	CASE WHEN SalesYtd1 ='NULL' THEN -1 ELSE CAST(SalesYtd1 AS DECIMAL(15,2)) END AS SalesYtd,
	CASE WHEN SalesLastYear1 ='NULL' THEN -1 ELSE CAST(SalesLastYear1 AS DECIMAL(15,2)) END AS SalesLastYear,
	CASE WHEN CostYtd ='NULL' THEN -1 ELSE CAST(CostYtd AS DECIMAL(15,2)) END AS CostYtd,
	CASE WHEN CostLastYear ='NULL' THEN -1 ELSE CAST(CostLastYear AS DECIMAL(15,2)) END AS CostLastYear
FROM DB_STG1.Sales_April_21_30
UNION
SELECT DISTINCT 
	CASE WHEN TerritoryID1 ='NULL' THEN -1 ELSE TerritoryID1 END AS TerritoryID,
	CASE WHEN Name3 ='NULL' THEN 'N/A' ELSE Name3 END AS Name1,
	CASE WHEN  CountryRegionCode ='NULL' THEN 'N/A' ELSE  CountryRegionCode END AS  CountryRegionCode,
	CASE WHEN "Group" ='NULL' THEN 'N/A' ELSE "Group" END AS "Group",
	CASE WHEN SalesYtd1 ='NULL' THEN -1 ELSE CAST(SalesYtd1 AS DECIMAL(15,2)) END AS SalesYtd,
	CASE WHEN SalesLastYear1 ='NULL' THEN -1 ELSE CAST(SalesLastYear1 AS DECIMAL(15,2)) END AS SalesLastYear,
	CASE WHEN CostYtd ='NULL' THEN -1 ELSE CAST(CostYtd AS DECIMAL(15,2)) END AS CostYtd,
	CASE WHEN CostLastYear ='NULL' THEN -1 ELSE CAST(CostLastYear AS DECIMAL(15,2)) END AS CostLastYear
FROM DB_STG1.Sales_May_06_10
UNION
SELECT DISTINCT 
	CASE WHEN TerritoryID1 ='NULL' THEN -1 ELSE TerritoryID1 END AS TerritoryID,
	CASE WHEN Name3 ='NULL' THEN 'N/A' ELSE Name3 END AS Name1,
	CASE WHEN  CountryRegionCode ='NULL' THEN 'N/A' ELSE  CountryRegionCode END AS  CountryRegionCode,
	CASE WHEN "Group" ='NULL' THEN 'N/A' ELSE "Group" END AS "Group",
	CASE WHEN SalesYtd1 ='NULL' THEN -1 ELSE CAST(SalesYtd1 AS DECIMAL(15,2)) END AS SalesYtd,
	CASE WHEN SalesLastYear1 ='NULL' THEN -1 ELSE CAST(SalesLastYear1 AS DECIMAL(15,2)) END AS SalesLastYear,
	CASE WHEN CostYtd ='NULL' THEN -1 ELSE CAST(CostYtd AS DECIMAL(15,2)) END AS CostYtd,
	CASE WHEN CostLastYear ='NULL' THEN -1 ELSE CAST(CostLastYear AS DECIMAL(15,2)) END AS CostLastYear
FROM DB_STG1.Sales_May_11_20
UNION
SELECT DISTINCT 
	CASE WHEN TerritoryID1 ='NULL' THEN -1 ELSE TerritoryID1 END AS TerritoryID,
	CASE WHEN Name3 ='NULL' THEN 'N/A' ELSE Name3 END AS Name1,
	CASE WHEN  CountryRegionCode ='NULL' THEN 'N/A' ELSE  CountryRegionCode END AS  CountryRegionCode,
	CASE WHEN "Group" ='NULL' THEN 'N/A' ELSE "Group" END AS "Group",
	CASE WHEN SalesYtd1 ='NULL' THEN -1 ELSE CAST(SalesYtd1 AS DECIMAL(15,2)) END AS SalesYtd,
	CASE WHEN SalesLastYear1 ='NULL' THEN -1 ELSE CAST(SalesLastYear1 AS DECIMAL(15,2)) END AS SalesLastYear,
	CASE WHEN CostYtd ='NULL' THEN -1 ELSE CAST(CostYtd AS DECIMAL(15,2)) END AS CostYtd,
	CASE WHEN CostLastYear ='NULL' THEN -1 ELSE CAST(CostLastYear AS DECIMAL(15,2)) END AS CostLastYear
FROM DB_STG1.Sales_May_21_31;

INSERT INTO DB_STG2.SalesTaxRate
SELECT DISTINCT 
	CASE WHEN SalesTaxRateID = 'NULL' THEN -1 ELSE SalesTaxRateID END AS  SalesTaxRateID,
	CASE WHEN StateProvinceID = 'NULL' THEN -1 ELSE StateProvinceID END AS  StateProvinceID,
	CASE WHEN TaxType = 'NULL' THEN -1 ELSE CAST(TaxType AS BYTEINT) END AS  TaxType,
	CASE WHEN TaxRate = 'NULL' THEN -1 ELSE CAST(TaxRate AS DECIMAL(4,2)) END AS  TaxRate,
	CASE WHEN "Name" ='NULL' THEN 'N/A' ELSE "Name" END  AS "Name"
FROM DB_STG1.SalesTaxRate_Sales;

INSERT INTO DB_STG2.SalesTerritoryHistory
SELECT DISTINCT 
    CASE WHEN  BusinessEntityID1 ='NULL' THEN -1 ELSE  BusinessEntityID1 END AS  BusinessEntityID,
    CASE WHEN TerritoryID1 ='NULL' THEN -1 ELSE TerritoryID1 END AS TerritoryID,
	CASE WHEN StartDate1 = 'NULL' THEN CAST('1900-01-01' AS DATE FORMAT 'YYYY-MM-DD') ELSE CAST(SUBSTR(StartDate1,1,10) AS DATE FORMAT 'YYYY-MM-DD') END AS StartDate,
	CASE WHEN EndDate1 = 'NULL' THEN CAST('1900-01-01' AS DATE FORMAT 'YYYY-MM-DD') ELSE CAST(SUBSTR(EndDate1,1,10) AS DATE FORMAT 'YYYY-MM-DD') END AS EndDate
FROM DB_STG1.Sales
UNION
SELECT DISTINCT 
	CASE WHEN  BusinessEntityID1 ='NULL' THEN -1 ELSE  BusinessEntityID1 END AS  BusinessEntityID,
    CASE WHEN TerritoryID1 ='NULL' THEN -1 ELSE TerritoryID1 END AS TerritoryID,
	CASE WHEN StartDate1 = 'NULL' THEN CAST('1900-01-01' AS DATE FORMAT 'YYYY-MM-DD') ELSE CAST(SUBSTR(StartDate1,1,10) AS DATE FORMAT 'YYYY-MM-DD') END AS StartDate,
	CASE WHEN EndDate1 = 'NULL' THEN CAST('1900-01-01' AS DATE FORMAT 'YYYY-MM-DD') ELSE CAST(SUBSTR(EndDate1,1,10) AS DATE FORMAT 'YYYY-MM-DD') END AS EndDate
FROM DB_STG1.Sales_April_1_10
UNION
SELECT DISTINCT 
	CASE WHEN  BusinessEntityID1 ='NULL' THEN -1 ELSE  BusinessEntityID1 END AS  BusinessEntityID,
    CASE WHEN TerritoryID1 ='NULL' THEN -1 ELSE TerritoryID1 END AS TerritoryID,
	CASE WHEN StartDate1 = 'NULL' THEN CAST('1900-01-01' AS DATE FORMAT 'YYYY-MM-DD') ELSE CAST(SUBSTR(StartDate1,1,10) AS DATE FORMAT 'YYYY-MM-DD') END AS StartDate,
	CASE WHEN EndDate1 = 'NULL' THEN CAST('1900-01-01' AS DATE FORMAT 'YYYY-MM-DD') ELSE CAST(SUBSTR(EndDate1,1,10) AS DATE FORMAT 'YYYY-MM-DD') END AS EndDate
FROM DB_STG1.Sales_April_11_20
UNION
SELECT DISTINCT 
CASE WHEN  BusinessEntityID1 ='NULL' THEN -1 ELSE  BusinessEntityID1 END AS  BusinessEntityID,
    CASE WHEN TerritoryID1 ='NULL' THEN -1 ELSE TerritoryID1 END AS TerritoryID,
	CASE WHEN StartDate1 = 'NULL' THEN CAST('1900-01-01' AS DATE FORMAT 'YYYY-MM-DD') ELSE CAST(SUBSTR(StartDate1,1,10) AS DATE FORMAT 'YYYY-MM-DD') END AS StartDate,
	CASE WHEN EndDate1 = 'NULL' THEN CAST('1900-01-01' AS DATE FORMAT 'YYYY-MM-DD') ELSE CAST(SUBSTR(EndDate1,1,10) AS DATE FORMAT 'YYYY-MM-DD') END AS EndDate
FROM DB_STG1.Sales_April_21_30
UNION
SELECT DISTINCT 
	CASE WHEN  BusinessEntityID1 ='NULL' THEN -1 ELSE  BusinessEntityID1 END AS  BusinessEntityID,
    CASE WHEN TerritoryID1 ='NULL' THEN -1 ELSE TerritoryID1 END AS TerritoryID,
	CASE WHEN StartDate1 = 'NULL' THEN CAST('1900-01-01' AS DATE FORMAT 'YYYY-MM-DD') ELSE CAST(SUBSTR(StartDate1,1,10) AS DATE FORMAT 'YYYY-MM-DD') END AS StartDate,
	CASE WHEN EndDate1 = 'NULL' THEN CAST('1900-01-01' AS DATE FORMAT 'YYYY-MM-DD') ELSE CAST(SUBSTR(EndDate1,1,10) AS DATE FORMAT 'YYYY-MM-DD') END AS EndDate
FROM DB_STG1.Sales_May_06_10
UNION
SELECT DISTINCT 
	CASE WHEN  BusinessEntityID1 ='NULL' THEN -1 ELSE  BusinessEntityID1 END AS  BusinessEntityID,
    CASE WHEN TerritoryID1 ='NULL' THEN -1 ELSE TerritoryID1 END AS TerritoryID,
	CASE WHEN StartDate1 = 'NULL' THEN CAST('1900-01-01' AS DATE FORMAT 'YYYY-MM-DD') ELSE CAST(SUBSTR(StartDate1,1,10) AS DATE FORMAT 'YYYY-MM-DD') END AS StartDate,
	CASE WHEN EndDate1 = 'NULL' THEN CAST('1900-01-01' AS DATE FORMAT 'YYYY-MM-DD') ELSE CAST(SUBSTR(EndDate1,1,10) AS DATE FORMAT 'YYYY-MM-DD') END AS EndDate
FROM DB_STG1.Sales_May_11_20
UNION
SELECT DISTINCT 
	CASE WHEN  BusinessEntityID1 ='NULL' THEN -1 ELSE  BusinessEntityID1 END AS  BusinessEntityID,
    CASE WHEN TerritoryID1 ='NULL' THEN -1 ELSE TerritoryID1 END AS TerritoryID,
	CASE WHEN StartDate1 = 'NULL' THEN CAST('1900-01-01' AS DATE FORMAT 'YYYY-MM-DD') ELSE CAST(SUBSTR(StartDate1,1,10) AS DATE FORMAT 'YYYY-MM-DD') END AS StartDate,
	CASE WHEN EndDate1 = 'NULL' THEN CAST('1900-01-01' AS DATE FORMAT 'YYYY-MM-DD') ELSE CAST(SUBSTR(EndDate1,1,10) AS DATE FORMAT 'YYYY-MM-DD') END AS EndDate
FROM DB_STG1.Sales_May_21_31;

INSERT INTO DB_STG2.ShoppingCartItem
SELECT DISTINCT 
	CASE WHEN ShoppingCartItemID = 'NULL' THEN -1 ELSE ShoppingCartItemID END AS  ShoppingCartItemID,
	CASE WHEN ShoppingCartID = 'NULL' THEN -1 ELSE ShoppingCartID END AS ShoppingCartID,
	CASE WHEN Quantity = 'NULL' THEN -1 ELSE Quantity END AS  Quantity,
	CASE WHEN ProductID = 'NULL' THEN -1 ELSE ProductID END AS  ProductID,
	CASE WHEN DateCreated = 'NULL' THEN CAST('1900-01-01' AS DATE FORMAT 'YYYY-MM-DD') ELSE CAST(SUBSTR(DateCreated,1,10) AS DATE FORMAT 'YYYY-MM-DD') END AS DateCreated
FROM DB_STG1.ShoppingCartItem_Sales;

INSERT INTO DB_STG2.SpecialOffer
SELECT DISTINCT 
    CASE WHEN SpecialOfferID1 ='NULL' THEN -1 ELSE SpecialOfferID1 END AS SpecialOfferID1,
	CASE WHEN Description ='NULL' THEN 'N/A' ELSE Description END AS Description,
	CASE WHEN DiscountPct ='NULL' THEN -1 ELSE CAST(DiscountPct AS DECIMAL(8,2)) END AS DiscountPct,
	CASE WHEN "Type" ='NULL' THEN 'N/A' ELSE "Type" END AS "Type",
	CASE WHEN Category ='NULL' THEN 'N/A' ELSE Category END AS Category,
	CASE WHEN StartDate1 = 'NULL' THEN CAST('1900-01-01' AS DATE FORMAT 'YYYY-MM-DD') ELSE CAST(SUBSTR(StartDate1,1,10) AS DATE FORMAT 'YYYY-MM-DD') END AS StartDate,
	CASE WHEN EndDate1 = 'NULL' THEN CAST('1900-01-01' AS DATE FORMAT 'YYYY-MM-DD') ELSE CAST(SUBSTR(EndDate1,1,10) AS DATE FORMAT 'YYYY-MM-DD') END AS EndDate,
    CASE WHEN MinQty ='NULL' THEN -1 ELSE MinQty END AS MinQty,
	CASE WHEN MaxQty ='NULL' THEN -1 ELSE MaxQty END AS MaxQty
FROM DB_STG1.Sales
UNION
SELECT DISTINCT 
	CASE WHEN SpecialOfferID1 ='NULL' THEN -1 ELSE SpecialOfferID1 END AS SpecialOfferID1,
	CASE WHEN Description ='NULL' THEN 'N/A' ELSE Description END AS Description,
	CASE WHEN DiscountPct ='NULL' THEN -1 ELSE CAST(DiscountPct AS DECIMAL(8,2)) END AS DiscountPct,
	CASE WHEN "Type" ='NULL' THEN 'N/A' ELSE "Type" END AS "Type",
	CASE WHEN Category ='NULL' THEN 'N/A' ELSE Category END AS Category,
	CASE WHEN StartDate1 = 'NULL' THEN CAST('1900-01-01' AS DATE FORMAT 'YYYY-MM-DD') ELSE CAST(SUBSTR(StartDate1,1,10) AS DATE FORMAT 'YYYY-MM-DD') END AS StartDate,
	CASE WHEN EndDate1 = 'NULL' THEN CAST('1900-01-01' AS DATE FORMAT 'YYYY-MM-DD') ELSE CAST(SUBSTR(EndDate1,1,10) AS DATE FORMAT 'YYYY-MM-DD') END AS EndDate,
    CASE WHEN MinQty ='NULL' THEN -1 ELSE MinQty END AS MinQty,
	CASE WHEN MaxQty ='NULL' THEN -1 ELSE MaxQty END AS MaxQty
FROM DB_STG1.Sales_April_1_10
UNION
SELECT DISTINCT 
	CASE WHEN SpecialOfferID1 ='NULL' THEN -1 ELSE SpecialOfferID1 END AS SpecialOfferID1,
	CASE WHEN Description ='NULL' THEN 'N/A' ELSE Description END AS Description,
	CASE WHEN DiscountPct ='NULL' THEN -1 ELSE CAST(DiscountPct AS DECIMAL(8,2)) END AS DiscountPct,
	CASE WHEN "Type" ='NULL' THEN 'N/A' ELSE "Type" END AS "Type",
	CASE WHEN Category ='NULL' THEN 'N/A' ELSE Category END AS Category,
	CASE WHEN StartDate1 = 'NULL' THEN CAST('1900-01-01' AS DATE FORMAT 'YYYY-MM-DD') ELSE CAST(SUBSTR(StartDate1,1,10) AS DATE FORMAT 'YYYY-MM-DD') END AS StartDate,
	CASE WHEN EndDate1 = 'NULL' THEN CAST('1900-01-01' AS DATE FORMAT 'YYYY-MM-DD') ELSE CAST(SUBSTR(EndDate1,1,10) AS DATE FORMAT 'YYYY-MM-DD') END AS EndDate,
    CASE WHEN MinQty ='NULL' THEN -1 ELSE MinQty END AS MinQty,
	CASE WHEN MaxQty ='NULL' THEN -1 ELSE MaxQty END AS MaxQty
FROM DB_STG1.Sales_April_11_20
UNION
SELECT DISTINCT 
	CASE WHEN SpecialOfferID1 ='NULL' THEN -1 ELSE SpecialOfferID1 END AS SpecialOfferID1,
	CASE WHEN Description ='NULL' THEN 'N/A' ELSE Description END AS Description,
	CASE WHEN DiscountPct ='NULL' THEN -1 ELSE CAST(DiscountPct AS DECIMAL(8,2)) END AS DiscountPct,
	CASE WHEN "Type" ='NULL' THEN 'N/A' ELSE "Type" END AS "Type",
	CASE WHEN Category ='NULL' THEN 'N/A' ELSE Category END AS Category,
	CASE WHEN StartDate1 = 'NULL' THEN CAST('1900-01-01' AS DATE FORMAT 'YYYY-MM-DD') ELSE CAST(SUBSTR(StartDate1,1,10) AS DATE FORMAT 'YYYY-MM-DD') END AS StartDate,
	CASE WHEN EndDate1 = 'NULL' THEN CAST('1900-01-01' AS DATE FORMAT 'YYYY-MM-DD') ELSE CAST(SUBSTR(EndDate1,1,10) AS DATE FORMAT 'YYYY-MM-DD') END AS EndDate,
    CASE WHEN MinQty ='NULL' THEN -1 ELSE MinQty END AS MinQty,
	CASE WHEN MaxQty ='NULL' THEN -1 ELSE MaxQty END AS MaxQty
FROM DB_STG1.Sales_April_21_30
UNION
SELECT DISTINCT 
	CASE WHEN SpecialOfferID1 ='NULL' THEN -1 ELSE SpecialOfferID1 END AS SpecialOfferID1,
	CASE WHEN Description ='NULL' THEN 'N/A' ELSE Description END AS Description,
	CASE WHEN DiscountPct ='NULL' THEN -1 ELSE CAST(DiscountPct AS DECIMAL(8,2)) END AS DiscountPct,
	CASE WHEN "Type" ='NULL' THEN 'N/A' ELSE "Type" END AS "Type",
	CASE WHEN Category ='NULL' THEN 'N/A' ELSE Category END AS Category,
	CASE WHEN StartDate1 = 'NULL' THEN CAST('1900-01-01' AS DATE FORMAT 'YYYY-MM-DD') ELSE CAST(SUBSTR(StartDate1,1,10) AS DATE FORMAT 'YYYY-MM-DD') END AS StartDate,
	CASE WHEN EndDate1 = 'NULL' THEN CAST('1900-01-01' AS DATE FORMAT 'YYYY-MM-DD') ELSE CAST(SUBSTR(EndDate1,1,10) AS DATE FORMAT 'YYYY-MM-DD') END AS EndDate,
    CASE WHEN MinQty ='NULL' THEN -1 ELSE MinQty END AS MinQty,
	CASE WHEN MaxQty ='NULL' THEN -1 ELSE MaxQty END AS MaxQty
FROM DB_STG1.Sales_May_06_10
UNION
SELECT DISTINCT 
	CASE WHEN SpecialOfferID1 ='NULL' THEN -1 ELSE SpecialOfferID1 END AS SpecialOfferID1,
	CASE WHEN Description ='NULL' THEN 'N/A' ELSE Description END AS Description,
	CASE WHEN DiscountPct ='NULL' THEN -1 ELSE CAST(DiscountPct AS DECIMAL(8,2)) END AS DiscountPct,
	CASE WHEN "Type" ='NULL' THEN 'N/A' ELSE "Type" END AS "Type",
	CASE WHEN Category ='NULL' THEN 'N/A' ELSE Category END AS Category,
	CASE WHEN StartDate1 = 'NULL' THEN CAST('1900-01-01' AS DATE FORMAT 'YYYY-MM-DD') ELSE CAST(SUBSTR(StartDate1,1,10) AS DATE FORMAT 'YYYY-MM-DD') END AS StartDate,
	CASE WHEN EndDate1 = 'NULL' THEN CAST('1900-01-01' AS DATE FORMAT 'YYYY-MM-DD') ELSE CAST(SUBSTR(EndDate1,1,10) AS DATE FORMAT 'YYYY-MM-DD') END AS EndDate,
    CASE WHEN MinQty ='NULL' THEN -1 ELSE MinQty END AS MinQty,
	CASE WHEN MaxQty ='NULL' THEN -1 ELSE MaxQty END AS MaxQty
FROM DB_STG1.Sales_May_11_20
UNION
SELECT DISTINCT 
	CASE WHEN SpecialOfferID1 ='NULL' THEN -1 ELSE SpecialOfferID1 END AS SpecialOfferID1,
	CASE WHEN Description ='NULL' THEN 'N/A' ELSE Description END AS Description,
	CASE WHEN DiscountPct ='NULL' THEN -1 ELSE CAST(DiscountPct AS DECIMAL(8,2)) END AS DiscountPct,
	CASE WHEN "Type" ='NULL' THEN 'N/A' ELSE "Type" END AS "Type",
	CASE WHEN Category ='NULL' THEN 'N/A' ELSE Category END AS Category,
	CASE WHEN StartDate1 = 'NULL' THEN CAST('1900-01-01' AS DATE FORMAT 'YYYY-MM-DD') ELSE CAST(SUBSTR(StartDate1,1,10) AS DATE FORMAT 'YYYY-MM-DD') END AS StartDate,
	CASE WHEN EndDate1 = 'NULL' THEN CAST('1900-01-01' AS DATE FORMAT 'YYYY-MM-DD') ELSE CAST(SUBSTR(EndDate1,1,10) AS DATE FORMAT 'YYYY-MM-DD') END AS EndDate,
    CASE WHEN MinQty ='NULL' THEN -1 ELSE MinQty END AS MinQty,
	CASE WHEN MaxQty ='NULL' THEN -1 ELSE MaxQty END AS MaxQty
FROM DB_STG1.Sales_May_21_31;

INSERT INTO DB_STG2.SpecialOfferProduct
SELECT DISTINCT 
    CASE WHEN SpecialOfferID1 ='NULL' THEN -1 ELSE SpecialOfferID1 END AS SpecialOfferID1,
    CASE WHEN ProductID1 ='NULL' THEN -1 ELSE ProductID1 END AS ProductID1
FROM DB_STG1.Sales
UNION
SELECT DISTINCT 
	CASE WHEN SpecialOfferID1 ='NULL' THEN -1 ELSE SpecialOfferID1 END AS SpecialOfferID1,
    CASE WHEN ProductID1 ='NULL' THEN -1 ELSE ProductID1 END AS ProductID1
FROM DB_STG1.Sales_April_1_10
UNION
SELECT DISTINCT 
	CASE WHEN SpecialOfferID1 ='NULL' THEN -1 ELSE SpecialOfferID1 END AS SpecialOfferID1,
    CASE WHEN ProductID1 ='NULL' THEN -1 ELSE ProductID1 END AS ProductID1
FROM DB_STG1.Sales_April_11_20
UNION
SELECT DISTINCT 
	CASE WHEN SpecialOfferID1 ='NULL' THEN -1 ELSE SpecialOfferID1 END AS SpecialOfferID1,
    CASE WHEN ProductID1 ='NULL' THEN -1 ELSE ProductID1 END AS ProductID1
FROM DB_STG1.Sales_April_21_30
UNION
SELECT DISTINCT 
	CASE WHEN SpecialOfferID1 ='NULL' THEN -1 ELSE SpecialOfferID1 END AS SpecialOfferID1,
    CASE WHEN ProductID1 ='NULL' THEN -1 ELSE ProductID1 END AS ProductID1
FROM DB_STG1.Sales_May_06_10
UNION
SELECT DISTINCT 
	CASE WHEN SpecialOfferID1 ='NULL' THEN -1 ELSE SpecialOfferID1 END AS SpecialOfferID1,
    CASE WHEN ProductID1 ='NULL' THEN -1 ELSE ProductID1 END AS ProductID1
FROM DB_STG1.Sales_May_11_20
UNION
SELECT DISTINCT 
	CASE WHEN SpecialOfferID1 ='NULL' THEN -1 ELSE SpecialOfferID1 END AS SpecialOfferID1,
    CASE WHEN ProductID1 ='NULL' THEN -1 ELSE ProductID1 END AS ProductID1
FROM DB_STG1.Sales_May_21_31;

INSERT INTO DB_STG2.Store	
SELECT DISTINCT 
	CASE WHEN BusinessEntityID='NULL' THEN -1 ELSE BusinessEntityID END AS  BusinessEntityID,
	CASE WHEN SalesPersonID='NULL' THEN -1 ELSE SalesPersonID END AS  SalesPersonID,
	CASE WHEN Name='NULL' THEN 'N/A' ELSE Name END  AS Name,
	CASE WHEN DEMOGRAPHICS = 'NULL' THEN 'N/A' ELSE DEMOGRAPHICS END AS DEMOGRAPHICS
FROM DB_STG1.Store_Sales;



.LOGOFF
1:35 AM 10/11/2023

2:15 AM 10/11/2023
