Select * From BankAccounts


ALTER PROC BankAccount_Insert
@BankID char(36),
@Code nvarchar(20),
@Name nvarchar(100)
AS
IF Exists(SELECT Code FROM Banks WHERE Code = @CODE AND BankID = @BankID AND isDelete = 0)
BEGIN
	raiserror('Bank Code %s is already exists',16,1,@Code)
	return
END

INSERT INTO BankAccounts
Values(newid(),@BankID,@Code,@Name,0)
GO

ALTER PROCEDURE BankAccount_Update
@BankAccountID char(36),
@BankID char(36),
@Code nvarchar(20),
@Name nvarchar(100)
AS
Update BankAccounts
SET
BankID = @BankID,
BankCOde = @Code,
UserName = @Name
WHERE BankAccountID = @BankAccountID


CREATE PROC BankAccount_Delete
@BankAccountID char(36)
AS
Update BankAccounts
SET
isDelete = 1
WHERE BankAccountID = @BankAccountID

ALTER VIEW BankAccounts_vw
AS
SELECT Ba.*,B.Code Bank,B.Description BankDesp
FROM BankAccounts BA, Banks B
WHERE BA.BankID = B.BankID
AND BA.isDelete = 0
GO

SELECT * FROM BankAccounts_VW