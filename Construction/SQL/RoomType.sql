
Select * From RoomType


Create PROCEDURE RoomType_Update
@RoomTypeID char(36),
@Code nvarchar(20),
@Desp nvarchar(100)
AS
Update RoomType
SET
Code = @Code,
Description = @Desp
WHERE RoomTypeID = @RoomTypeID


Create PROC RoomType_Insert
@Code nvarchar(20),
@Desp nvarchar(100)
AS
IF Exists(SELECT Code FROM RoomType WHERE Code = @CODE AND isDelete = 0)
BEGIN
	raiserror('Code %s is already exists',16,1,@Code)
	return
END

INSERT INTO RoomType
Values(newid(),@Code,@Desp,0)
GO

Create PROC RoomType_Delete
@RoomTypeID char(36)
AS
Update RoomType
SET
isDelete = 1
WHERE RoomTypeID = @RoomTypeID
