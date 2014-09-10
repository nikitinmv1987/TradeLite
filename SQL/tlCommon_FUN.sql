if exists (select 1 from sysobjects where id = OBJECT_ID(N'[dbo].[Cm_GetProgramName]')
  and OBJECTPROPERTY(id, N'IsScalarFunction') = 1)
    DROP FUNCTION [dbo].[Cm_GetProgramName]
GO
if exists (select 1 from sysobjects where id = OBJECT_ID(N'[dbo].[Cm_GetHostName]')
  and OBJECTPROPERTY(id, N'IsScalarFunction') = 1)
    DROP FUNCTION [dbo].[Cm_GetHostName]
GO
if exists (select 1 from sysobjects where id = OBJECT_ID(N'[dbo].[Cm_GetLoginName]')
  and OBJECTPROPERTY(id, N'IsScalarFunction') = 1)
    DROP FUNCTION [dbo].[Cm_GetLoginName]
GO


SET QUOTED_IDENTIFIER OFF
SET ANSI_NULLS ON
GO

PRINT 'CREATE FUNCTION [dbo].[Cm_GetProgramName]'
GO
/*---------------------------------------------------------------------------
  Autor  : Ковбаса С.Ф.
  Desc   : Возвращает программу клиента у пользователя
  Result : varchar(128)
  Last   : Ковбаса С.Ф. / 2014-09-10
*/
CREATE FUNCTION [dbo].[Cm_GetProgramName] ()
RETURNS varchar(128)
AS BEGIN
  declare
    @ProgramName varchar(128);
  set @ProgramName = ISNULL(NULLIF(APP_NAME(), ''), '[Not Defined]'); -- PROGRAM_NAME()
  RETURN @ProgramName;
END;
GO

PRINT 'CREATE FUNCTION [dbo].[Cm_GetHostName]'
GO
/*---------------------------------------------------------------------------
  Autor  : Ковбаса С.Ф.
  Desc   : Возвращает ProgramName клиента пользователя
  Result : varchar(128)
  Last   : Ковбаса С.Ф. / 2014-09-10
*/
CREATE FUNCTION [dbo].[Cm_GetHostName] ()
RETURNS varchar(128)
AS BEGIN
  declare
    @HostName varchar(128);
  set @HostName = HOST_NAME();
  RETURN @HostName;
END;
GO

print 'CREATE FUNCTION [dbo].[Cm_GetLoginName]'
GO
/*---------------------------------------------------------------------------
  Autor  : Ковбаса С.Ф.
  Desc   : Возвращает LoginName пользователя
  Result : varchar(30)
  Last   : Ковбаса С.Ф. / 2014-09-10
*/
CREATE FUNCTION [dbo].[Cm_GetLoginName] ()
RETURNS varchar(30)
AS BEGIN
  RETURN SUSER_SNAME()
END
GO