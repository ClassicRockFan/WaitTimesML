USE ParkData;
DROP TABLE IF EXISTS ParkData.Parks ;

CREATE TABLE ParkData.Parks (
	ParkId INT auto_increment NOT NULL,
	ParkName nvarchar(256) NOT NULL,
	CreatedTimeStamp DATETIME NOT NULL,
	CONSTRAINT Parks_PK PRIMARY KEY (ParkId)
)
ENGINE=InnoDB
DEFAULT CHARSET=utf8mb4
COLLATE=utf8mb4_0900_ai_ci;
CREATE INDEX Parks_ParkId_IDX USING BTREE ON ParkData.Parks (ParkId);