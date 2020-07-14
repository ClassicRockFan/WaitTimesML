USE ParkData;

DROP PROCEDURE IF EXISTS ParkData.uspRideUpdate_Create;


DELIMITER //
CREATE PROCEDURE ParkData.uspRideUpdate_Create (in RideName varchar(255), in ParkName varchar(255), in WaitTime int, in Status varchar(16), in IsActive boolean)
BEGIN
	SET @RideId = -1;
	SET @ParkId = -1; 
   	SET @Now = NOW();

   	-- Create park if it doesnt exist
   	INSERT INTO Parks (ParkName, CreatedTimeStamp)
	SELECT * FROM (SELECT ParkName , @Now) AS tmp
	WHERE NOT EXISTS (
    	SELECT ParkName FROM Parks P WHERE P.ParkName = ParkName
	)LIMIT 1;
   
    SELECT P.ParkId INTO @ParkId FROM Parks P WHERE P.ParkName = ParkName;
	
    -- Create ride if it doesnt exist
   	INSERT INTO Rides (RideName, ParkId, CreatedTimeStamp)
	SELECT * FROM (SELECT RideName , @ParkId, @Now) AS tmp
	WHERE NOT EXISTS (
    	SELECT RideName 
        FROM Rides R 
        WHERE R.RideName = RideName
                AND R.ParkId = @ParkId  
	)LIMIT 1;

	SELECT R.RideId INTO @RideId FROM Rides R WHERE R.RideName = RideName AND R.ParkId = @ParkId;
	
	INSERT INTO RideUpdate (RideId, WaitTime, CreatedTimeStamp, Status, IsActive) VALUES (@RideId, WaitTime, @Now, Status, IsActive);
	
	UPDATE Rides 
	SET CurrentRideUpdateId = LAST_INSERT_ID()
	WHERE RideId = @RideId;
END //

DELIMITER ;

CALL ParkData.uspRideUpdate_Create ('Hello', 'World', 5, "Closed", FALSE);
CALL ParkData.uspRideUpdate_Create ('Hello', 'World', NULL, "Open", TRUE);
SELECT * FROM RideUpdate ru ;