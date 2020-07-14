USE ParkData;

DROP TABLE IF EXISTS ParkData.RideUpdate ;

CREATE TABLE ParkData.RideUpdate (
	RideUpdateId INT auto_increment NOT NULL,
	RideId INT NOT NULL,
	WaitTime INT,
	CreatedTimeStamp DATETIME NOT NULL,
	Status varchar(16) NOT NULL,
	IsActive BOOLEAN NOT NULL,
	CONSTRAINT RideUpdate_PK PRIMARY KEY (RideUpdateId),
	CONSTRAINT RideUpdates_Rides_FK FOREIGN KEY (RideId) REFERENCES ParkData.Rides (RideId)
)
ENGINE=InnoDB
DEFAULT CHARSET=utf8mb4
COLLATE=utf8mb4_0900_ai_ci;
CREATE INDEX RideUpdates_RideUpdateId_IDX USING BTREE ON ParkData.RideUpdate (RideUpdateId);