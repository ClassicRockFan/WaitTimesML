// include the Themeparks library
const Themeparks = require("themeparks");
//include mysql
const mysql = require("mysql2");

//configure the timeout because of Disney couchbase stuff I think
const timeout = 4 * 60 * 1000;

// configure where SQLite DB sits
// optional - will be created in node working directory if not configured
// Themeparks.Settings.Cache = __dirname + "/themeparks.db";

//setup the parks we want to use
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

console.log("Starting service");
var conn = mysql.createConnection({
	host: process.env.DATABASE_HOST,
	user: process.env.DATABASE_USERNAME,
	password: process.env.DATABASE_PASSWORD,
	database: 'ParkData'
});

conn.connect(function (err) {
	if (err) throw err;
	console.log("connected to mysql")
	// Access wait times by Promise
	console.log("starting data grab");
	parks.forEach((park) => {
		console.log(`Grabbbing data for ${park.Name}`)
		park.GetWaitTimes().then((rideTimes) => {
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
		}).catch((error) => {
			console.error(error);
			return false;
		});
		return true;
	});
});

setTimeout(function () {
	process.exit(0);	
}, timeout); 
