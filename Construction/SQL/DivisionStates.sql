Select * From DivisionStates


CREATE PROCEDURE DivisionState_Update
@DivisionStateID char(36),
@Code nvarchar(20),
@Desp nvarchar(100)
AS
Update DivisionStates
SET
Code = @Code,
Description = @Desp
WHERE DivisionStateID = @DivisionStateID


Create PROC DivisionState_Insert
@Code nvarchar(20),
@Desp nvarchar(100)
AS
IF Exists(SELECT Code FROM DivisionStates WHERE Code = @CODE AND isDelete = 0)
BEGIN
	raiserror('Code %s is already exists',16,1,@Code)
	return
END

INSERT INTO DivisionStates
Values(newid(),@Code,@Desp,0)
GO

CREATE PROC DivisionState_Delete
@DivisionStateID char(36)
AS
Update DivisionStates
SET
isDelete = 1
WHERE DivisionStateID = @DivisionStateID

