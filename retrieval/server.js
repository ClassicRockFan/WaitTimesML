// include the Themeparks library
const Themeparks = require("themeparks");
//include mysql
const mysql = require("mysql2");

console.log("Starting service");

console.log("Creating parks instances");
const parks = [
	new Themeparks.Parks.WaltDisneyWorldMagicKingdom(),
	new Themeparks.Parks.WaltDisneyWorldEpcot(),
	new Themeparks.Parks.WaltDisneyWorldHollywoodStudios(),
	new Themeparks.Parks.WaltDisneyWorldAnimalKingdom(),
	new Themeparks.Parks.UniversalStudiosFlorida(),
	new Themeparks.Parks.UniversalIslandsOfAdventure(),
	new Themeparks.Parks.SeaworldOrlando(),
	new Themeparks.Parks.BuschGardensTampa()
];
setInterval(retrieveTimes, process.env.QUERY_INTERVAL*1000); 

function retrieveTimes() {
	var conn = build_db_conn();
	conn.connect(function (err) {
		if (err) throw err;	
		console.log("connected to mysql");
		console.log("Initiating retrieval");
		parks.forEach((park) => {
			return updatePark(park, conn);
		});
	});
}

function updatePark(park, conn) {
	console.log(`Grabbbing data for ${park.Name}`);
	park.GetWaitTimes().then((rideTimes) => {
		return updateRide(rideTimes, park, conn);
	}).catch((error) => {
		console.error(error);
		return false;
	});
	return true;
}

function updateRide(rideTimes, park, conn) {
	rideTimes.forEach((ride) => {
		var cmd = `CALL ParkData.uspRideUpdate_Create ("${ride.name.replace(/"/g, "")}", "${park.Name.replace(/"/g, "")}", ${ride.waitTime}, "${ride.status}", ${ride.active});`;
		conn.query(cmd, function (err, result) {
			if (err) throw err;
			console.log(`${result.affectedRows} record inserted for ${cmd}`);
			return true;
		});
		return true;
	});
	return true;
}

function build_db_conn() {
	console.log("Connecting to host " + process.env.DATABASE_HOST + " with username " + process.env.DATABASE_USERNAME);
	var conn = mysql.createConnection({
		host: process.env.DATABASE_HOST,
		user: process.env.DATABASE_USERNAME,
		password: process.env.DATABASE_PASSWORD,
		database: 'ParkData'
	});
	return conn;
}
