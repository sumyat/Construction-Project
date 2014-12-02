Select * From banks


Create PROCEDURE Bank_Update
@BankID char(36),
@Code nvarchar(20),
@Desp nvarchar(100)
AS
Update Banks
SET
Code = @Code,
Description = @Desp
WHERE BankID = @BankID


Create PROC Bank_Insert
@Code nvarchar(20),
@Desp nvarchar(100)
AS
IF Exists(SELECT Code FROM Banks WHERE Code = @CODE AND isDelete = 0)
BEGIN
	raiserror('Code %s is already exists',16,1,@Code)
	return
END

INSERT INTO Banks
Values(newid(),@Code,@Desp,0)
GO

Create PROC Bank_Delete
@BankID char(36)
AS
Update Banks
SET
isDelete = 1
WHERE BankID = @BankID

