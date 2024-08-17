USE ParkData;

CREATE TABLE IF NOT EXISTS ParkData.Rides (
	RideId INT auto_increment NOT NULL,
	ParkId INT NOT NULL,
	RideName nvarchar(256) NOT NULL,
	CreatedTimeStamp DATETIME NOT NULL,
	CurrentRideUpdateId INT,
	CONSTRAINT Rides_PK PRIMARY KEY (RideId),
	CONSTRAINT Rides_Parks_FK FOREIGN KEY (ParkId) REFERENCES ParkData.Parks (ParkId)
)
ENGINE=InnoDB
DEFAULT CHARSET=utf8mb4
COLLATE=utf8mb4_0900_ai_ci;
CREATE INDEX IF NOT EXISTS Rides_RideId_IDX USING BTREE ON ParkData.Rides (RideId);
