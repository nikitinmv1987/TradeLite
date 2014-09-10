if exists (select 1 from sysobjects where id = OBJECT_ID(N'[dbo].[tl_GetProductDictionary]')
  and OBJECTPROPERTY(id, N'IsProcedure') = 1)
    DROP PROCEDURE [dbo].[tl_GetProductDictionary]
GO
if exists (select 1 from sysobjects where id = OBJECT_ID(N'[dbo].[tl_InsProductDictionary]')
  and OBJECTPROPERTY(id, N'IsProcedure') = 1)
    DROP PROCEDURE [dbo].[tl_InsProductDictionary]
GO
if exists (select 1 from sysobjects where id = OBJECT_ID(N'[dbo].[tl_DelProductDictionary]')
  and OBJECTPROPERTY(id, N'IsProcedure') = 1)
    DROP PROCEDURE [dbo].[tl_DelProductDictionary]
GO
if exists (select 1 from sysobjects where id = OBJECT_ID(N'[dbo].[tl_UpdProductDictionary]')
  and OBJECTPROPERTY(id, N'IsProcedure') = 1)
    DROP PROCEDURE [dbo].[tl_UpdProductDictionary]
GO
if exists (select 1 from sysobjects where id = OBJECT_ID(N'[dbo].[tl_GetProductDictionaryByName]')
  and OBJECTPROPERTY(id, N'IsProcedure') = 1)
    DROP PROCEDURE [dbo].[tl_GetProductDictionaryByName]
GO

SET QUOTED_IDENTIFIER OFF
SET ANSI_NULLS ON
GO

print 'CREATE PROCEDURE [dbo].[tl_GetProductDictionary]'
GO
/*-----------------------------------------------------------------------------
  Author : Ковбаса С.Ф.
  Desc   : Выбирает все записи товаров
  Result : 0 - OK, -1 - ERROR
  Last   : Ковбаса С.Ф. / 10.06.2014
*/
CREATE PROCEDURE [dbo].[tl_GetProductDictionary]
AS BEGIN
  SET NOCOUNT ON

	select
		 [pdID]
    ,[Name]
    ,[Price]
		,[CreateAt]
		,[CreateBy]
		,[EditAt]
		,[EditBy]
		,[Note]
	from tlProductDictionary

  if @@ERROR <> 0
  begin
    RAISERROR('tl_GetProductDictionary', 16, 10) WITH SETERROR
    RETURN -1
  end

  RETURN 0
END
GO

print 'CREATE PROCEDURE [dbo].[tl_UpdProductDictionary]'
GO
/*-----------------------------------------------------------------------------
  Author : Ковбаса С.Ф.
  Desc   : Обновляет запись в ProductDictionary
  Result : 0 - OK, -1 - ERROR
  Last   : Ковбаса С.Ф. / 10.06.2014
*/
CREATE PROCEDURE [dbo].[tl_UpdProductDictionary]
   @pdID		int						-- ID записи
	,@Name		nvarchar(255)	-- Название продукта
	,@Price		int						-- Цена
	,@Note		nvarchar(255) -- Примечание
AS BEGIN
  SET NOCOUNT ON

  if @pdID is NULL
  begin
    RAISERROR('Параметр "%s" должен иметь значение', 16, 10, 'ID записи') WITH SETERROR
    RETURN -1
  end

	if NULLIF(LTRIM(RTRIM(@Name)), '') is NULL
  begin
    RAISERROR('Параметр "%s" должен иметь значение', 16, 10, 'Название продукта') WITH SETERROR
    RETURN -1
  end

	update tlProductDictionary set
		 [Name]			= @Name
		,[Price]		= @Price
		,[EditBy]		= dbo.Cm_GetLoginName()
    ,[EditAt]   = GETDATE()
		,[Note]			= @Note
	where pdID = @pdID

  if @@ERROR <> 0
  begin
    RAISERROR('tl_UpdProductDictionary', 16, 10) WITH SETERROR
    RETURN -1
  end

  RETURN 0
END
GO

print 'CREATE PROCEDURE [dbo].[tl_DelProductDictionary]'
GO
/*-----------------------------------------------------------------------------
  Author : Ковбаса С.Ф.
  Desc   : Удаляет запись из ProductDictionary
  Result : 0 - OK, -1 - ERROR
  Last   : Ковбаса С.Ф. / 10.06.2014
*/
CREATE PROCEDURE [dbo].[tl_DelProductDictionary]
   @pdID			int		-- ID записи
AS BEGIN
  SET NOCOUNT ON
	
  if @pdID is NULL
  begin
    RAISERROR('Параметр "%s" должен иметь значение', 16, 10, 'ID записи') WITH SETERROR
    RETURN -1
  end

	delete from tlProductDictionary
	where pdID = @pdID

  if @@ERROR <> 0
  begin
    RAISERROR('tl_DelProductDictionary', 16, 10) WITH SETERROR
    RETURN -1
  end

  RETURN 0
END
GO

print 'CREATE PROCEDURE [dbo].[tl_InsProductDictionary]'
GO
/*-----------------------------------------------------------------------------
  Author : Ковбаса С.Ф.
  Desc   : Добавляет запись в ProductDictionary
  Result : 0 - OK, -1 - ERROR
  Last   : Ковбаса С.Ф. / 10.06.2014
*/
CREATE PROCEDURE [dbo].[tl_InsProductDictionary]
   @Name		nvarchar(255)	-- Название продукта
	,@Price		int						-- Цена
	,@Note		nvarchar(255) -- Примечание
AS BEGIN
  SET NOCOUNT ON
  
  if NULLIF(LTRIM(RTRIM(@Name)), '') is NULL
  begin
    RAISERROR('Параметр "%s" должен иметь значение', 16, 10, 'Название продукта') WITH SETERROR
    RETURN -1
  end

	insert into tlProductDictionary(
     [Name]
    ,[Price]
		,[CreateBy]
    ,[CreateAt] 
		,[Note]
  )
  values (
     @Name
    ,@Price
		,dbo.Cm_GetLoginName()
		,GETDATE()
		,@Note
  )

  if @@ERROR <> 0
  begin
    RAISERROR('tl_InsProductDictionary', 16, 10) WITH SETERROR
    RETURN -1
  end

  RETURN 0
END
GO


print 'CREATE PROCEDURE [dbo].[tl_GetProductDictionaryByName]'
GO
/*-----------------------------------------------------------------------------
  Author : Ковбаса С.Ф.
  Desc   : Выбирает записи товара
  Result : 0 - OK, -1 - ERROR
  Last   : Ковбаса С.Ф. / 10.06.2014
*/
CREATE PROCEDURE [dbo].[tl_GetProductDictionaryByName]
   @Name		nvarchar(255)		-- название
AS BEGIN
  SET NOCOUNT ON

  if NULLIF(LTRIM(RTRIM(@Name)), '') is NULL
  begin
    RAISERROR('Параметр "%s" должен иметь значение', 16, 10, 'Название продукта') WITH SETERROR
    RETURN -1
  end

	set @Name = '%' + @Name + '%'

	select
		 p.ID
    ,pd.Name
    ,p.Size
		,pd.Price
	from Product p 
		inner join tlProductDictionary pd on pd.pdID = p.IDProduct 
    inner join Store s on s.ID = p.IDStore
	where p.[State] = 0 and pd.Name LIKE @Name 

  if @@ERROR <> 0
  begin
    RAISERROR('tl_GetProductDictionaryByName', 16, 10) WITH SETERROR
    RETURN -1
  end

  RETURN 0
END
GO
