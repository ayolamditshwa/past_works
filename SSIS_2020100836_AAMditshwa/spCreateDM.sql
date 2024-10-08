USE [CSID6853_MditshwaAA]
GO
/****** Object:  StoredProcedure [dbo].[spCreateDM]    Script Date: 6/3/2024 5:45:52 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

ALTER PROCEDURE [dbo].[spCreateDM]
AS
BEGIN
    -- Drop existing tables if they exist
    IF OBJECT_ID('dbo.CustomerDim', 'U') IS NOT NULL
        DROP TABLE dbo.CustomerDim;
    IF OBJECT_ID('dbo.SalesPersonDim', 'U') IS NOT NULL
        DROP TABLE dbo.SalesPersonDim;
    IF OBJECT_ID('dbo.ProductDim', 'U') IS NOT NULL
        DROP TABLE dbo.ProductDim;
    IF OBJECT_ID('dbo.StoreDim', 'U') IS NOT NULL
        DROP TABLE dbo.StoreDim;
    IF OBJECT_ID('dbo.TimeDim', 'U') IS NOT NULL
        DROP TABLE dbo.TimeDim;
	IF OBJECT_ID('dbo.PromotiontDim', 'U') IS NOT NULL
        DROP TABLE dbo.PromotionDim;
    IF OBJECT_ID('dbo.SalesInformationFact', 'U') IS NOT NULL
        DROP TABLE dbo.SalesInformationDim;



    -- Create CustomerDim table
    CREATE TABLE dbo.CustomerDim (
        PK_Customer INT PRIMARY KEY IDENTITY(1,1) NOT NULL,
        Customer_Name NVARCHAR(100),
        Address NVARCHAR(50),
        City NVARCHAR(50),
		State nchar(2),
		ZipCode nchar (5),
		Homeowner char (1),
		MaritalStatus char (1),
		NumCarsOwned smallint,
		NumChildrenAtHome smallint
    );

    -- Create ProductDim table
    CREATE TABLE dbo.ProductDim (
        PK_Product INT PRIMARY KEY IDENTITY(1,1) NOT NULL,
        Product_Name NVARCHAR(100),
        Product_Type NVARCHAR(100),
        RetailPrice float,
        Weight float(50),
    );

	    -- Create SalesPersonDim table
    CREATE TABLE dbo.SalesPersonDim (
        PK_Sales_Person INT PRIMARY KEY IDENTITY(1,1) NOT NULL,
        Sales_Person_Name NVARCHAR(50),
        Sales_Person_SCD_Original_ID int,
        Sales_Person_SCD_Status NVARCHAR(100),
		Sales_Person_SCD_Start_Date datetime,
		Sales_Person_SCD_End_Date datetime,
        Sales_Person_Territory int,
    );

	   -- Create StoreDim table
    CREATE TABLE dbo.StoreDim (
        PK_Store INT PRIMARY KEY IDENTITY(1,1) NOT NULL,
        Store_Name VARCHAR(100),
        Store_Type VARCHAR(100),
        Country_Code VARCHAR(100),
		Country_Name VARCHAR(100),
		Region VARCHAR(100),
        Account int,
    );
	   
	   -- Create PromotionDim table
    CREATE TABLE dbo.PromotionDim (
        PK_Promotion INT PRIMARY KEY IDENTITY(1,1) NOT NULL,
        Promotion_Name NVARCHAR(50)
    );

    -- Create TimeDim table
    CREATE TABLE dbo.TimeDim(
        PK_Date INT PRIMARY KEY IDENTITY(1,1) NOT NULL,
        Date_Name nvarchar(123),
        Year int,
		Year_Name nvarchar (123),
        Quarter int,
		Quarter_Name nvarchar,
		Month date,
		Month_Name nvarchar(123),
		Day_Of_Year int,
		Day_Of_Year_Name nvarchar(123),
		Day_Of_Quarter  int,
		Day_Of_Quarter_Name nvarchar(123),
		Day_Of_Month nvarchar(50),
		Month_Of_Year nvarchar(50),
		Month_Of_Year_Name nvarchar(123),
		Month_Of_Quarter int,
		Month_Of_Quarter_Name nvarchar(50),
		Quarter_Of_Year nvarchar(50),
		Quarter_Of_Year_Name nvarchar(123)
    );

	-- Create SalesInformationFact table
	CREATE TABLE dbo.SalesInformationFact(
	FK_Time int FOREIGN KEY (FK_Time)  REFERENCES TimeDim(PK_Date),
	FK_Customer int FOREIGN KEY (FK_Customer) REFERENCES dbo.CustomerDim(PK_Customer),
	FK_Product int FOREIGN KEY (FK_Product) REFERENCES dbo.ProductDim(PK_Product),
	FK_Promotion int FOREIGN KEY (FK_Promotion) REFERENCES dbo.PromotionDim(PK_Promotion),
	FK_Sales_Person int FOREIGN KEY (FK_Sales_Person) REFERENCES dbo.SalesPersonDim(PK_Sales_Person),
	FK_Store int FOREIGN KEY (FK_Store) REFERENCES dbo.StoreDim(PK_Store),
	Sales_in_Dollars decimal (18,2),
	Sales_in_Units int,
	Sales_Tax decimal (18,2),
	Shipping decimal (18,2),
	);

END;