Select * From CityTownships


Alter PROC CityTownship_Insert
@DivisionStateID char(36),
@Code nvarchar(20),
@Desp nvarchar(100),
@isCity bit
AS
IF Exists(SELECT Code FROM CityTownship WHERE Code = @CODE AND DivsionStateID = @DivisionStateID AND isDelete = 0)
BEGIN
	raiserror('Code %s is already exists',16,1,@Code)
	return
END

INSERT INTO CityTownship
Values(newid(),@DivisionStateID,@Code,@Desp,@isCity,0)
GO

ALTER PROCEDURE CityTownship_Update
@CityTownshipID char(36),
@DivisionStateID char(36),
@Code nvarchar(20),
@Desp nvarchar(100),
@isCity bit
AS
Update CityTownship
SET
DivsionStateID = @DivisionStateID,
Code = @Code,
Description = @Desp,
isCity = @isCity
WHERE CityTownshipID = @CityTownshipID


ALTER PROC CityTownship_Delete
@CityTownshipID char(36)
AS
Update CityTownship
SET
isDelete = 1
WHERE CityTownshipID = @CityTownshipID

CREATE VIEW CityTownships_vw
AS
SELECT CT.*,DS.Code DivisionState,DS.Description DivisionStateDesp
FROM CityTownship CT, DivisionStates DS
WHERE CT.DivsionStateID = DS.DivisionStateID
AND CT.isDelete = 0
GO

SELECT * FROM CityTownships_VW