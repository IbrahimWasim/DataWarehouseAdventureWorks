.LOGON 192.168.254.128/dbc,dbc; 

CREATE MULTISET TABLE DB_RDM.Vendor 
AS DB_STG2.Vendor
WITH DATA;


CREATE MULTISET TABLE DB_RDM.ShipMethod 
AS DB_STG2.ShipMethod
WITH DATA;


CREATE MULTISET TABLE DB_RDM.ProductVendor 
AS DB_STG2.ProductVendor
WITH DATA;

--Partitioned_Tables

CREATE MULTISET TABLE DB_RDM.PurchaseOrderHeader ( 
 PurchaseOrderID INTEGER,
		   ShipMethodID INTEGER,
		   VendorID INTEGER,
		   RevisionNumber INTEGER,
		   Status INTEGER,
		   EmployeeID INTEGER,
		   OrderDate DATE FORMAT 'MM/DD/YYYY',
		   ShipDate DATE FORMAT 'MM/DD/YYYY',
		   SubTotal DECIMAL(9,2),
		   TaxAmt DECIMAL(7,2),
		   Freight DECIMAL(7,2),
		   TotalDue DECIMAL(9,2)
)
PRIMARY INDEX(PurchaseOrderID)
PARTITION BY RANGE_N(OrderDate  BETWEEN DATE '2005-01-01' AND '2020-12-31' EACH INTERVAL '1' DAY );

INSERT INTO DB_RDM.PurchaseOrderHeader
SELECT * FROM  DB_STG2.PurchaseOrderHeader ;


CREATE MULTISET TABLE DB_RDM.PurchaseOrderDetail ( 
       PurchaseOrderID INTEGER,
           PurchaseOrderDetailID INTEGER,
		   DueDate DATE FORMAT 'MM/DD/YYYY',
		   ProductID INTEGER,
		   OrderQty INTEGER,
		   UnitPrice DECIMAL(7,2),
		   LineTotal DECIMAL(9,2),
		   ReceivedQty INTEGER,
		   RejectedQty INTEGER,
		   StockedQty INTEGER
)
PRIMARY INDEX(PurchaseOrderID,PurchaseOrderDetailID)
PARTITION BY ProductID;

INSERT INTO DB_RDM.PurchaseOrderDetail
SELECT * FROM  DB_STG2.PurchaseOrderDetail;
.LOGOFF;

