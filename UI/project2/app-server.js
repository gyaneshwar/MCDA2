var express = require("express");
var mongodb = require("mongodb").MongoClient;
var bodyParse = require("body-parser");
var cors = require("cors");
var fs = require('fs');
const FILE_NAME = "result.txt";
const SERVER_PORT = 8150;


var user="gr_nampally";
var password="A00433014";
var database = "gr_nampally";
var NAME_OF_COLLECTION = 'universities';
var database_object;

var host="localhost";
var port = '27017';//default mongoDB port.

var connectionString = 'mongodb://'+ user+":"+password+'@'+host+':'+port+'/'+database;

console.log(connectionString);

//CORS Middleware, causes Express to allow Cross-Origin Requests
var allowCrossDomain = function(req,rest,next){
	res.header('Access-Control-Allow-Origin','*');
	rest.header('Access-Control-Allow-Methods','GET,PUT,POST,DELETE');
	rest.header('Access-Control-Allow-Headers','Content-Type');
	next();
};

//set up server variables
var app = express();
app.use(cors());
app.use(bodyParse.json());
app.use(bodyParse.urlencoded({extended: true}));
app.use('/scripts',express.static(__dirname + '/scripts'));
app.use('/css',express.static(__dirname + '/css'));
app.use(express.static(__dirname));

mongodb.connect(connectionString, function(error,client){
	if(error){
		console.error(error);
		return;
	}
	console.log("Connected successfully to the server");
	database_object = client.db(database);

	//close the database connection and server whe nthe application ends.
	process.on('SIGTERM',function(){
		console.log("Shutting server down");
		client.close();
		app.close();
	});

	//now start the application server
	var server = app.listen(SERVER_PORT,function(){
	console.log('Listening on port %d',	server.address().port);
	});

	app.get('/allUniversities',function(request,response){
		let collection = database_object.collection(NAME_OF_COLLECTION);
		collection.find().toArray(
			function(err,result){
				if(err){
					console.log(err);
					return response.send("An error occured in getting records");
				}
				console.log(JSON.stringify(result));
				return response.send(JSON.stringify(result));
			}
		);
	});

	app.post('/saveUniversity',function(request,response){
		
		let record = {
			"name": request.body.name,
			"address": request.body.address,
			"phone": request.body.phone
		};
		console.log(record);
		let collection = database_object.collection(NAME_OF_COLLECTION);
		collection.insertOne(record,
			function(err,result){
				if(err){
					return response.send("An error occured in saving records");
				}
				return response.send('Record inserted successfully');
			});
	});

	app.delete('/deleteUniversity',function(request,response){
		let record = {
			"name": request.body.name,
			"address": request.body.address,
			"phone": request.body.phone
		};
		console.log(record);
		let collection = database_object.collection(NAME_OF_COLLECTION);
		collection.remove(record,
			function(err,result){
				if(err){
					return response.send("An error occured in removing records");
				}
				return response.send('Record removed successfully');
			});
	});

	app.get('/searchUniversity/:search',function(request,response){
		let search = request.params.search;
		let collection = database_object.collection(NAME_OF_COLLECTION);
		let query = {$or:[{"name": search},{"address":search},{"phone":search}]};
		collection.find(query).toArray(
			function(err,result){
				if(err){
					console.log(err);
					return response.send("An error occured in getting records");
				}
				console.log(JSON.stringify(result));
				return response.send(JSON.stringify(result));
			}
			);
	});
});





