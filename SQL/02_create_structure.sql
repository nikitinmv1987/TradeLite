USE [TradeLite]
/* -------------------------------- */
/*           TABLES                 */
/* -------------------------------- */
CREATE TABLE dbo.ProductDictionary(
  ID           int IDENTITY(1,1) NOT NULL,
  Name         nvarchar(255)     NOT NULL,
  Price        int,
  CreateDate   datetime          NOT NULL DEFAULT GETDATE(),
  UserName     nvarchar(255)     DEFAULT SYSTEM_USER,
  Note         nvarchar(255)
);

CREATE TABLE dbo.Store(
  ID            int IDENTITY(1,1) NOT NULL,
  Name          nvarchar(255)     NOT NULL,
  CreateDate    datetime          NOT NULL DEFAULT GETDATE(),
  UserName      nvarchar(255)     DEFAULT SYSTEM_USER
);

CREATE TABLE dbo.Product(
  ID            int IDENTITY(1,1) NOT NULL,
  IDProduct     int               NOT NULL,
  IDStore       int               NOT NULL,
  Size          nvarchar(255),
  State         bit               DEFAULT 0,  -- "1" - sold
  CreateDate    datetime          NOT NULL DEFAULT GETDATE(),
  UserName      nvarchar(255)     DEFAULT SYSTEM_USER,
  Note          nvarchar(255)
);
GO

/* -------------------------------- */
/*           PRIMARY                */
/* -------------------------------- */
ALTER TABLE dbo.ProductDictionary ADD CONSTRAINT ProductDictionary$ID PRIMARY KEY (ID);
ALTER TABLE dbo.Store             ADD CONSTRAINT Store$ID             PRIMARY KEY (ID);
ALTER TABLE dbo.Product           ADD CONSTRAINT Product$ID           PRIMARY KEY (ID);
GO

/* -------------------------------- */
/*           INDEX                  */
/* -------------------------------- */
CREATE INDEX ProductDictionary$Name     ON dbo.ProductDictionary (Name);
GO

/* -------------------------------- */
/*           FOREIGN                */
/* -------------------------------- */
ALTER TABLE dbo.Product ADD CONSTRAINT Product$IDProduct FOREIGN KEY(IDProduct) REFERENCES dbo.ProductDictionary (ID);
ALTER TABLE dbo.Product ADD CONSTRAINT Product$IDStore   FOREIGN KEY(IDStore)   REFERENCES dbo.Store (ID);
GO
