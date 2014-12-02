
Select * From Address

Select * From Customers

Select CityTownshipID,Code + ' | ' + Description as Desp From CityTownship


Alter PROCEDURE Customer_Update
@CustomerID char(36),
@UserName nvarchar(100),
@Password nvarchar(50),
@FirstName nvarchar(50),
@LastName nvarchar(50),
@NRCNo nvarchar(100),
@Email nvarchar(100),
@AddressID char(36),
@Phone nvarchar(100),
@Remark nvarchar(1000),
@Status char(1)
AS
Update Customers
SET
UserName = @UserName,
Password = @Password,
FirstName = @FirstName,
LastName = @LastName,
NRCNo = @NRCNo,
Email = @Email,
AddressID = @AddressID,
Phone = @Phone,
Remark = @Remark,
Status = @Status
WHERE CustomerID = @CustomerID

ALTER Proc Address_Insert
@DivisionStateID char(36),
@CityTownshipID char(36),
@Address nvarchar(400)
AS
Declare @ID char(36)
set @ID = newid()
Insert Into Address
Values(@ID,@DivisionStateID,@CityTownshipID,
@Address,0)
Select @ID
GO

Alter Proc Address_Delete
@AddressID char(36)
AS
Update Address
Set isDelete = 1
WHERE AddressID = @AddressID
GO

ALTER PROC Customer_Insert
@UserName nvarchar(100),
@Password nvarchar(50),
@FirstName nvarchar(50),
@LastName nvarchar(50),
@NRCNo nvarchar(100),
@Email nvarchar(100),
@AddressID char(36),
@Phone nvarchar(100),
@Remark nvarchar(1000)
AS
IF Exists(SELECT UserName FROM Customers WHERE UserName = @UserName AND Status <> 'D')
BEGIN
	raiserror('%s is already exists',16,1,@UserName)
	return
END
IF Exists(SELECT UserName FROM Customers WHERE Email = @Email AND Status <> 'D')
BEGIN
	raiserror('%s Email is already exists',16,1,@Email)
	return
END

INSERT INTO Customers
Values(newid(),@UserName,@Password,@FirstName,@LastName,@NRCNo,
@Email,@AddressID,@Phone,@Remark,'P')
GO

ALTER PROC Customer_Delete
@CustomerID char(36)
AS
Update Customers
SET
Status = 'D'
WHERE CustomerID = @CustomerID

