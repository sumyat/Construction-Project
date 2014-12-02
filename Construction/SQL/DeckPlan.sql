
Alter Proc Plan_Insert
@HomeTypeID char(36) = null,
@Code nvarchar(20),
@Name nvarchar(100),
@Width numeric(18,2),
@Length numeric(18,2),
@Height numeric(18,2),
@Desp nvarchar(1000),
@PlanType char(1),
@SampleImage image = null
AS
IF Exists(SELECT Code FROM Plans WHERE Code = @CODE AND isDelete = 0 AND PlanType = @PlanType)
BEGIN
	raiserror('Code %s is already exists',16,1,@Code)
	return
END
INSERT INTO Plans
VALUES(newid(),@HomeTypeID,@Code,@Name,
@Width,@Length,@Height,@Desp,@PlanType,@SampleImage,0)
GO

ALTER PROCEDURE Plan_Update
@PlanID char(36),
@HomeTypeID char(36),
@Code nvarchar(20),
@Name nvarchar(100),
@Width numeric(18,2),
@Length numeric(18,2),
@Height numeric(18,2),
@Desp nvarchar(1000),
@PlanType char(1),
@SampleImage image 
AS
Update Plans
SET
HomeTypeID = @HomeTypeID,
Code = @Code,
Name = @Name,
Width = @Width,
Length = @Length,
Height = @Height,
Description = @Desp,
PlanType = @PlanType,
SampleImage = @SampleImage
WHERE PlanID = @PlanID
GO

Create PROC Plan_Delete
@PlanID char(36)
AS
Update Plans
SET
isDelete = 1
WHERE PlanID = @PlanID
GO

Create Proc PlanFile_Insert
@PlanImageID char(36) = null,
@PlanID char(36),
@FileExt varchar(10),
@FileName varchar(200),
@FilePath nvarchar(1000),
@Remark nvarchar(1000),
@isImage bit
AS
IF Exists(SELECT FilName FROM Plans WHERE Code = @CODE AND isDelete = 0 AND PlanType = @PlanType)
BEGIN
	raiserror('Code %s is already exists',16,1,@Code)
	return
END
INSERT INTO Plans
VALUES(newid(),@HomeTypeID,@Code,@Name,
@Width,@Length,@Height,@Desp,@PlanType,0)
GO


Select * from Plans