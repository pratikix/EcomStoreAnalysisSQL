-- Parent Table
CREATE TABLE orderlist(
	
	OrderID VARCHAR(255) PRIMARY KEY NOT NULL ,
	OrderDate DATE ,
	CustomerName VARCHAR(255),
	CityStateCountry  VARCHAR(255),
	Region VARCHAR(255),
	Segment VARCHAR(255),	
	ShipDate DATE,
	ShipMode  VARCHAR(255),	
	OrderPriority  VARCHAR(255)

)
-- Child Table
CREATE TABLE EachOrderBreakdown (
	OrderID VARCHAR(255) NOT NULL,
	ProductName VARCHAR(255),
	Discount FLOAT ,
	Sales FLOAT ,
	Profit FLOAT ,
	Quantity INT,
	SubCategory VARCHAR(255),
	FOREIGN KEY (OrderID) REFERENCES orderlist(OrderID)	
);
