
Select * From HomeTypes


Create PROCEDURE HomeType_Update
@HomeTypeID char(36),
@Code nvarchar(20),
@Desp nvarchar(100)
AS
Update HomeType
SET
Code = @Code,
Description = @Desp
WHERE HomeTypeID = @HomeTypeID


ALTER PROC HomeType_Insert
@Code nvarchar(20),
@Desp nvarchar(100)
AS
IF Exists(SELECT Code FROM HomeType WHERE Code = @CODE AND isDelete = 0)
BEGIN
	raiserror('Code %s is already exists',16,1,@Code)
	return
END

INSERT INTO HomeType
Values(newid(),@Code,@Desp,0)
GO

Create PROC HomeType_Delete
@HomeTypeID char(36)
AS
Update HomeType
SET
isDelete = 1
WHERE HomeTypeID = @HomeTypeID
