if exists (select 1 from sysobjects where id = OBJECT_ID(N'[dbo].[tl_InsProductDictionary]')
  and OBJECTPROPERTY(id, N'IsProcedure') = 1)
    DROP PROCEDURE [dbo].[tl_InsProductDictionary]
GO

SET QUOTED_IDENTIFIER OFF
SET ANSI_NULLS ON
GO

print 'CREATE PROCEDURE [dbo].[tl_InsProductDictionary]'
GO
/*-----------------------------------------------------------------------------
  Author : ������� �.�.
  Desc   : ��������� ������ � ProductDictionary
  Result : 0 - OK, -1 - ERROR
  Last   : ������� �.�. / 10.06.2014
*/
CREATE PROCEDURE [dbo].[tl_InsProductDictionary]
   @Name nvarchar(255)	-- �������� ��������
	,@Price int						-- ����
AS BEGIN
  SET NOCOUNT ON
  
  if NULLIF(LTRIM(RTRIM(@Name)), '') is NULL
  begin
    RAISERROR('�������� "%s" ������ ����� ��������', 16, 10, '�������� ��������') WITH SETERROR
    RETURN -1
  end
  if @Price is NULL
  begin
    RAISERROR('�������� "%s" ������ ����� ��������', 16, 10, '����') WITH SETERROR
    RETURN -1
  end

	insert into ProductDictionary(
     Name
    ,Price
  )
  values (
     @Name
    ,@Price
  )

  if @@ERROR <> 0
  begin
    RAISERROR('pm7_GetFoldersLookup', 16, 10) WITH SETERROR
    RETURN -1
  end

  RETURN 0
END
