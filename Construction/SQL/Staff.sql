Select * From Staffs


Create PROCEDURE Staff_Update
@StaffID char(36),
@Code nvarchar(20),
@Name nvarchar(100),
@Password nvarchar(40)
AS
Update Staffs
SET
StaffCode = @Code,
StaffName = @Name,
Password = @Password
WHERE StaffID = @StaffID


Create PROC Staff_Insert
@Code nvarchar(20),
@Name nvarchar(100),
@Password nvarchar(40)
AS
IF Exists(SELECT StaffCode FROM Staffs WHERE StaffCode = @CODE AND isDelete = 0)
BEGIN
	raiserror('Code %s is already exists',16,1,@Code)
	return
END

INSERT INTO Staffs
Values(newid(),@Code,@Name,@Password,0)
GO

Create PROC Staff_Delete
@StaffID char(36)
AS
Update Staffs
SET
isDelete = 1
WHERE StaffID = @StaffID

