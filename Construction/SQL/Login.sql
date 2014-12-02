Select * From customers

Select * From staffs

Exec Check_Login 'C','ABC'

ALTER Proc Check_Login
@Type char(1),
@UserName nvarchar(40)
AS
IF @Type = 'C'
BEGIN 
	SELECT CustomerID as ID,UserName as UserName,Password as Password FROM Customers 
	WHERE UserName = @UserName
	AND Status = 'A';
END
Else
	Select StaffID as ID,StaffCode as UserName,Password as Password From Staffs
	WHERE StaffCode = @UserName
	AND isDelete = 0;
GO

CREATE Proc Select_UserInfo
@Type char(1),
@ID char(36)
AS
IF @Type = 'C'
BEGIN 
	SELECT * FROM Customers 
	WHERE CustomerID = @ID
	AND Status = 'A';
END
Else
	Select * From Staffs
	WHERE StaffID = @ID
	AND isDelete = 0;
GO