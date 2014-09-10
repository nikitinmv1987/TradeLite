if exists (select 1 from sysobjects where id = OBJECT_ID(N'[dbo].[tI_tlProductDictionary]')
  and OBJECTPROPERTY(id, N'IsTrigger') = 1)
    DROP TRIGGER [dbo].[tI_tlProductDictionary]
GO
if exists (select 1 from sysobjects where id = OBJECT_ID(N'[dbo].[tU_tlProductDictionary]')
  and OBJECTPROPERTY(id, N'IsTrigger') = 1)
    DROP TRIGGER [dbo].[tU_tlProductDictionary]
GO
if exists (select 1 from sysobjects where id = OBJECT_ID(N'[dbo].[tD_tlProductDictionary]')
  and OBJECTPROPERTY(id, N'IsTrigger') = 1)
    DROP TRIGGER [dbo].[tD_tlProductDictionary]
GO


SET QUOTED_IDENTIFIER OFF
SET ANSI_NULLS ON
GO


print 'CREATE TRIGGER [dbo].[tI_tlProductDictionary]'
GO
/*-----------------------------------------------------------------------------
  Author : Иванов И.И.
  Desc   : Триггер на вставку таблицы [tlProductDictionary]. Осуществляет протоколирование вставок.
  Last   : Иванов И.И. / 2009-12-04
*/
CREATE TRIGGER [dbo].[tI_tlProductDictionary] ON [dbo].[tlProductDictionary]
FOR INSERT
AS BEGIN
  SET NOCOUNT ON
  --
  declare
     @UserName varchar(30)
    ,@ProgName varchar(128)
    ,@HostName varchar(128)
  --
  set @UserName = dbo.Cm_GetLoginName()
  set @ProgName = dbo.Cm_GetProgramName()
  set @HostName = dbo.Cm_GetHostName()
  --
  insert into DUP_tlProductDictionary (
     OLD_HIID
    ,DUP_insTime
    ,DUP_Action
    ,DUP_UserName
    ,DUP_HostName       
    ,DUP_AplicationName
    ,HIID
    ,pdID
    ,Name
    ,Price
    ,CreateAt
    ,CreateBy
		,EditAt
		,EditBy
    ,Note
  )
  select
     OLD_HIID								= NULL
    ,DUP_insTime						= GETDATE()
    ,DUP_action							= 'I'
    ,DUP_UserName						= @UserName
    ,DUP_HostName						= @HostName
    ,DUP_AplicationName			= @ProgName
    ,i.HIID
    ,i.pdID
    ,i.Name
    ,i.Price
    ,i.CreateAt
    ,i.CreateBy
		,i.EditAt
		,i.EditBy
    ,i.Note
  from Inserted i
  --
  if @@ERROR <> 0
  begin
    RAISERROR(60004, 16, 10, 'DUP_tlProductDictionary') WITH SETERROR  
    ROLLBACK TRAN
    RETURN
  end
  --
  RETURN
END
GO


print 'CREATE TRIGGER [dbo].[tU_tlProductDictionary]'
GO
/*-----------------------------------------------------------------------------
  Author : Иванов И.И.
  Desc   : Триггер на обновление таблицы [tlProductDictionary]. Осуществляет протоколирование обновлений.
  Last   : Иванов И.И. / 2009-12-04
*/
CREATE TRIGGER [dbo].[tU_tlProductDictionary] ON [dbo].[tlProductDictionary]
FOR UPDATE
AS BEGIN
  SET NOCOUNT ON
  --
  declare
     @UserName varchar(30)
    ,@ProgName varchar(128)
    ,@HostName varchar(128)
  --
  set @UserName = dbo.Cm_GetLoginName()
  set @ProgName = dbo.Cm_GetProgramName()
  set @HostName = dbo.Cm_GetHostName()
  --
  insert into DUP_tlProductDictionary  (
     OLD_HIID
    ,DUP_insTime
    ,DUP_Action
    ,DUP_UserName
    ,DUP_HostName       
    ,DUP_AplicationName 
    ,HIID
    ,pdID
    ,Name
    ,Price
    ,CreateAt
    ,CreateBy
		,EditAt
		,EditBy
    ,Note
  )
  select
     OLD_HIID								= d.HIID
    ,DUP_insTime						= GETDATE()
    ,DUP_Action							= 'U'
    ,DUP_UserName						= @UserName
    ,DUP_HostName						= @HostName
    ,DUP_AplicationName			= @ProgName    
    ,i.HIID
    ,i.pdID
    ,i.Name
    ,i.Price
    ,i.CreateAt
    ,i.CreateBy
		,i.EditAt
		,i.EditBy
    ,i.Note
  from Inserted i
    inner join Deleted d on i.pdID = d.pdID
  --
  if @@ERROR <> 0
  begin
    RAISERROR(60004, 16, 10, 'DUP_tlProductDictionary') WITH SETERROR
    ROLLBACK TRAN    
    RETURN
  end
  --
  RETURN
END  -- trigger
GO


print 'CREATE TRIGGER [dbo].[tD_tlProductDictionary]'
GO
/*-----------------------------------------------------------------------------	 
  Author : Иванов И.И. 
  Desc   : Триггер на удаление таблицы [tlProductDictionary]. Осуществляет протоколирование удалений.
  Last   : Иванов И.И. / 2009-12-04
*/
CREATE TRIGGER [dbo].[tD_tlProductDictionary] ON [dbo].[tlProductDictionary]
FOR DELETE
AS BEGIN
  SET NOCOUNT ON
  --
  declare
     @UserName varchar(30)
    ,@ProgName varchar(128)
    ,@HostName varchar(128)
  --
  set @UserName = dbo.Cm_GetLoginName()
  set @ProgName = dbo.Cm_GetProgramName()
  set @HostName = dbo.Cm_GetHostName()
  --
  insert into DUP_tlProductDictionary   (
     OLD_HIID
    ,DUP_insTime
    ,DUP_Action
    ,DUP_UserName
    ,DUP_HostName       
    ,DUP_AplicationName
		,HIID
    ,pdID
    ,Name
    ,Price
    ,CreateAt
    ,CreateBy
		,EditAt
		,EditBy
    ,Note
  )
  select
     OLD_HIID								= d.HIID
    ,DUP_insTime						= GETDATE()
    ,DUP_action							= 'D'
    ,DUP_UserName						= @UserName
    ,DUP_HostName						= @HostName
    ,DUP_AplicationName			= @ProgName   
    ,d.HIID
    ,d.pdID
    ,d.Name
    ,d.Price
    ,d.CreateAt
    ,d.CreateBy
		,d.EditAt
		,d.EditBy
    ,d.Note
  from Deleted d
  --
  if @@ERROR <> 0
  begin
    RAISERROR(60004, 16, 10, 'DUP_tlProductDictionary') WITH SETERROR  
    ROLLBACK TRAN
    RETURN
  end
  --
  RETURN
END  -- trigger
GO






