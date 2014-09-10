if exists (select * from sysobjects where id = OBJECT_ID(N'[dbo].[tlProductDictionary]') 
   and OBJECTPROPERTY(id, N'IsUserTable') = 1)
     DROP TABLE [dbo].[tlProductDictionary]
 GO
 if exists (select * from sysobjects where id = OBJECT_ID(N'[dbo].[DUP_tlProductDictionary]') 
   and OBJECTPROPERTY(id, N'IsUserTable') = 1)
     DROP TABLE [dbo].[DUP_tlProductDictionary]
 GO

Print 'CREATE TABLE [dbo].[tlProductDictionary]'
GO
/*-----------------------------------------------------------------------------
  Author : Никитин М.В., Ковбаса С.Ф.
  Desc   : Таблица товаров
  Last   : Ковбаса С.Ф. / 2014-09-10
*/
CREATE TABLE [dbo].[tlProductDictionary] (
   [HIID]         timestamp					NOT NULL -- Версия
  ,[pdID]					int IDENTITY(1,1)	NOT NULL -- ID записи
	,[Name]         nvarchar(255)			NOT NULL -- название
  ,[Price]        int										NULL -- цена
  ,[CreateAt]			datetime					NOT NULL -- дата создания
  ,[CreateBy]     nvarchar(255)					NULL -- кто создал
	,[EditAt]				datetime					NOT NULL -- дата редактирования
	,[EditBy]				nvarchar(255)					NULL -- кто редактировал
  ,[Note]         nvarchar(255)					NULL -- примечание
) ON [PRIMARY]
GO

-- PK
ALTER TABLE [dbo].[tlProductDictionary] WITH NOCHECK ADD 
  CONSTRAINT [PK_tlProductDictionary] PRIMARY KEY ([pdID]) WITH  FILLFACTOR = 90
GO
-- DF
ALTER TABLE [dbo].[tlProductDictionary] ADD CONSTRAINT [DF_tlProductDictionary_CreateAt]
  DEFAULT (GETDATE()) FOR [CreateAt]
GO
ALTER TABLE [dbo].[tlProductDictionary] ADD CONSTRAINT [DF_tlProductDictionary_CreateBy]
  DEFAULT (SYSTEM_USER) FOR [CreateBy]
GO
-- IX
CREATE INDEX [IX_tlProductDictionary_Name] ON [dbo].[tlProductDictionary] ([Name])
  WITH FILLFACTOR = 90 ON [PRIMARY]
GO


Print 'CREATE TABLE [dbo].[DUP_tlProductDictionary]'
GO
/*-----------------------------------------------------------------------------
  Author : Никитин М.В., Ковбаса С.Ф.
  Desc   : DUP Таблица товаров
  Last   : Ковбаса С.Ф. / 2014-09-10
*/
CREATE TABLE [dbo].[DUP_tlProductDictionary] (
   [OLD_HIID]						binary(8)					NULL	-- старая версия
  ,[DUP_insTime]				datetime			NOT NULL	-- время изменения
  ,[DUP_action]					char(1)				NOT NULL	-- действие
  ,[DUP_UserName]				varchar(30)		NOT NULL	-- пользователь	
	,[DUP_HostName]				varchar(128)	NOT NULL	-- хост
	,[DUP_AplicationName] varchar(128)	NOT NULL  -- имя приложения
  ,[HIID]								binary(8)			NOT NULL	-- Версия
  ,[pdID]								int						NOT NULL	-- ID записи
	,[Name]								nvarchar(255)	NOT NULL	-- название
  ,[Price]							int								NULL	-- цена
  ,[CreateAt]						datetime			NOT NULL -- дата создания
  ,[CreateBy]						nvarchar(255)			NULL -- кто создал
	,[EditAt]							datetime			NOT NULL -- дата редактирования
	,[EditBy]							nvarchar(255)			NULL -- кто редактировал
  ,[Note]								nvarchar(255)			NULL	-- примечание
) ON [PRIMARY]
GO

ALTER TABLE [dbo].[DUP_tlProductDictionary] ADD
  CONSTRAINT [PK_DUP_tlProductDictionary] PRIMARY KEY CLUSTERED ([HIID], [DUP_Action]) 
  WITH FILLFACTOR = 90 ON [PRIMARY]
GO

CREATE INDEX IX_DUP_tlProductDictionary_pdID on [DUP_tlProductDictionary] ([pdID])
  WITH FILLFACTOR = 90 ON [PRIMARY]
GO