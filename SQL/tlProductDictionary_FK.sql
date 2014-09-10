 if exists (select 1 from sysobjects where id = OBJECT_ID(N'[dbo].[tlProductDictionary]')
   and OBJECTPROPERTY(id, N'IsUserTable') = 1)
   and exists (select 1 from sysobjects
     where id = OBJECT_ID(N'[dbo].[FK_depDepartments_emEmployees_CreatedBy]')
     and OBJECTPROPERTY(id, N'IsForeignKey') = 1)
   ALTER TABLE [dbo].[depDepartments] DROP CONSTRAINT [FK_depDepartments_emEmployees_CreatedBy]
 GO
 if exists (select 1 from sysobjects where id = OBJECT_ID(N'[dbo].[depDepartments]')
   and OBJECTPROPERTY(id, N'IsUserTable') = 1)
   and exists (select 1 from sysobjects
     where id = OBJECT_ID(N'[dbo].[FK_depDepartments_emEmployees_CreatedBy]')
     and OBJECTPROPERTY(id, N'IsForeignKey') = 1)
   ALTER TABLE [dbo].[depDepartments] DROP CONSTRAINT [FK_depDepartments_emEmployees_CreatedBy]
 GO

ALTER TABLE [dbo].[depDepartments] ADD
  CONSTRAINT [FK_depDepartments_emEmployees_CreatedBy]
    FOREIGN KEY ([CreatedBy]) REFERENCES [dbo].[emEmployees] ([emID])
  NOT FOR REPLICATION
GO
ALTER TABLE [dbo].[depDepartments] ADD
  CONSTRAINT [FK_depDepartments_emEmployees_CreatedBy]
    FOREIGN KEY ([CreatedBy]) REFERENCES [dbo].[emEmployees] ([emID])
  NOT FOR REPLICATION
GO