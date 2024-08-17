USE ParkData;

CREATE TABLE IF NOT EXISTS ParkData.Parks (
	ParkId INT auto_increment NOT NULL,
	ParkName nvarchar(256) NOT NULL,
	CreatedTimeStamp DATETIME NOT NULL,
	CONSTRAINT Parks_PK PRIMARY KEY (ParkId)
)
ENGINE=InnoDB
DEFAULT CHARSET=utf8mb4
COLLATE=utf8mb4_0900_ai_ci;
ALTER TABLE ParkData.Parks ADD INDEX Parks_ParkId_IDX USING BTREE (ParkId);