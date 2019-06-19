function creatAdminAccount(userList){
//first get the values from the fields 
	var admin = {
		"FirstName"		: "admin",
		"LastName"		: "admin",
		"DateOfBirth"	: "2010-01-01",
		"Password"		: "9999",
		"ConfirmPassword": "9999",
		"Email"			: "admin",
		"Gender"		: "Male",
		"agreedToLegal"	: false
	};

	userList.push(admin); //now add the new object

	//the save its string representation
	localStorage.setItem("userList", JSON.stringify(userList));

	console.log("Admin was Added Successfully Created ");
}

//#pageHome
//
function redirectPage(){

	currentLoginUsername = $("#pageHome #username").val();
	currentLoginPassword = $("#pageHome #passcode").val();

	console.log("currentLoginUsername= "+currentLoginUsername);
	console.log("currentLoginPassword= "+currentLoginPassword);

	try{
		var userList = localStorage.getItem("userList");

		// no data stored yet, create a new one
		if (userList == null) {
		    userList = [];//if not found, create a new array
		    creatAdminAccount(userList)
		}
		else {
		    userList = JSON.parse(userList); //if found convert back to a JSON object
		}//end if-else

		//check if user is admin
	    if (currentLoginPassword === "9999"){

	    	//go through each record
			for (var i = 0; i < userList.length; i++) {

			    var existingUsername = userList[i].Email;

			    if (existingUsername === "admin"){

			    	localStorage.setItem("currentUser", "admin");


			    	if (userList[i].agreedToLegal == false) 
			        {
			            $.mobile.changePage("#legalNotice");
						window.location.reload();
			        } 
			        else
			        {
			        	$.mobile.changePage("#pageMenu");
						window.location.reload();
			        }
			        return (true);
			    }
			}//end for 
	    }

	    //go through each record
		for (var i = 0; i < userList.length; i++) {

		    var existingUsername = userList[i].Email;
		    var existingPassword = userList[i].Password;

		    if (existingUsername == currentLoginUsername && existingPassword == currentLoginPassword){

		    	localStorage.setItem("currentUser", currentLoginUsername);

		    	if (userList[i].agreedToLegal == false) 
		        {
		            $.mobile.changePage("#legalNotice");
					window.location.reload();
		        } 
		        else
		        {
		        	$.mobile.changePage("#pageMenu");
					window.location.reload();
		        }
		        return (true);
		    }
		}//end for 

		alert("Alert! Email and Password Not in Database");

	}catch(e){
		
		//Google broser use different error constant
		if (window.navigator.vendor === "Google Inc."){
			if (e == DOMException.QUOTA_EXCEEDED_ERR) {
				alert("Error: Local Storage limit exceeds");
			}
		} else if (e == QUOTA_EXCEEDED_ERR) {
			alert("Error: Storage to local storage");
		}

		console.log(e);
	}
}

//#pageHome
//
function addValueToPassword(button){

	var passcode = document.getElementById("passcode").value

	if (button === 'bksp'){
		 document.getElementById("passcode").value = passcode.substring(0, passcode.length - 1);
	}
	else{
		document.getElementById("passcode").value += button;
	}	
}

//----------------------------------------------------------------


//#pageSignup
//store user data to local storage
function saveSignUpUser() {

	//first get the values from the fields 
	var user = {
		"FirstName"		: $("#pageSignup #signupFirstName").val(),
		"LastName"		: $("#pageSignup #signupLastName").val(),
		"DateOfBirth"	: $("#pageSignup #dateOfBirth").val(),
		"Password"		: $("#pageSignup #addPassword").val(),
		"ConfirmPassword": $("#pageSignup #confirmPassword").val(),
		"Email"			: $("#pageSignup #signupEmail").val(),
		"Gender"		: $("#pageSignup #signupgenderType option:selected").val(),
		"agreedToLegal"	: false
	};

	try{

		var userList = localStorage.getItem("userList");

		// no data stored yet, create a new one
		if (userList == null) {
		    userList = [];//if not found, create a new array
		    creatAdminAccount(userList)
		}
		else {
		    userList = JSON.parse(userList); //if found convert back to a JSON object
		}//end if-else

		userList.push(user); //now add the new object

		//the save its string representation
		localStorage.setItem("userList", JSON.stringify(userList));

		//save usrrent user
		localStorage.setItem("currentUser", $("#pageSignup #signupEmail").val());

		alert("Saving Information");
		$.mobile.changePage("#legalNotice");
		window.location.reload();

	}catch(e){
		
		//Google broser use different error constant
		if (window.navigator.vendor === "Google Inc."){
			if (e == DOMException.QUOTA_EXCEEDED_ERR) {
				alert("Error: Local Storage limit exceeds");
			}
		} else if (e == QUOTA_EXCEEDED_ERR) {
			alert("Error: Storage to local storage");
		}

		console.log(e);
	}
}

//----------------------------------------------------------------

//#legalNotice
//
function saveDisclaimer() {

	var userList = localStorage.getItem("userList");

	var currentUser = localStorage.getItem("currentUser");

	if (userList == null) {
	    //no record whatsoever, let the user know
	    alert("No record found");
	} else {
		//if data exist, convert to JSON object
		userList = JSON.parse(userList);

		//go through each record
		for (var i = 0; i < userList.length; i++) {

		    if (currentUser === userList[i].Email){

				userList[i].agreedToLegal = true;

				console.log("Last Record (agreedToLegal = true):");
				console.log(userList[i]);

				localStorage.setItem("userList", JSON.stringify(userList));
		    }
		}//end for 
	}
}

//----------------------------------------------------------------

//#pageUserInfo
//
function saveUserForm() {

	//check if list exists
	var userList = localStorage.getItem("userList");

	var currentUser = localStorage.getItem("currentUser");

	if (userList == null) {
	    //no record whatsoever, let the user know
	    alert("No record found");
	} else {

		//if data exist, convert to JSON object
		userList = JSON.parse(userList);

		//go through each record
		for (var i = 0; i < userList.length; i++) {

		    if (currentUser === userList[i].Email){

				console.log("Before Updatating User Record:");
				console.log(userList[i]);

				userList[i].FirstName = $("#pageUserInfo #signupFirstName").val();
				userList[i].LastName = $("#pageUserInfo #signupLastName").val();
				userList[i].DateOfBirth = $("#pageUserInfo #dateOfBirth").val();
				userList[i].Password = $("#pageUserInfo #editPassword").val();
				userList[i].Gender = $("#pageUserInfo #signupgenderType").val();
				userList[i].agreedToLegal = true;

				console.log("After Updatating User Record:");
				console.log(userList[i]);

				localStorage.setItem("userList", JSON.stringify(userList));

				alert("Updating Information");
				$.mobile.changePage("#pageRecords");
				window.location.reload();
		    }
		}//end for 
	}
}


function showUserForm(){
	
	//check if list exists
	var userList = localStorage.getItem("userList");

	var currentUser = localStorage.getItem("currentUser");

	if (userList == null) {
	    //no record whatsoever, let the user know
	    alert("No record found");
	} else {

		//if data exist, convert to JSON object
		userList = JSON.parse(userList);

		//go through each record
		for (var i = 0; i < userList.length; i++) {

		    if (currentUser === userList[i].Email){

				console.log("User Record (display on load of #pageUserInfo):");
				console.log(userList[i]);

				$("#pageUserInfo #signupFirstName").val(userList[i].FirstName);
				$("#pageUserInfo #signupLastName").val(userList[i].LastName);
				$("#pageUserInfo #dateOfBirth").val(userList[i].DateOfBirth);
				$("#pageUserInfo #editPassword").val(userList[i].Password);
				$("#pageUserInfo #signupEmail").val(userList[i].Email);
				$("#pageUserInfo #signupgenderType").val(userList[i].Gender).prop('selected', true).siblings('option').removeAttr('selected'); 
				$("#pageUserInfo #signupgenderType").selectmenu("refresh", true);
		    }
		}//end for 
	}
};

//----------------------------------------------------------------

//#pageRecords
//
// $(document).on('pagebeforeshow', '#pageRecords', function(){ 

// 	//check if list exists
// 	var userList = localStorage.getItem("userList");

// 	var currentUser = localStorage.getItem("currentUser");

// 	if (userList == null) {
// 	    //no record whatsoever, let the user know
// 	    alert("No record found");
// 	} else {

// 		//if data exist, convert to JSON object
// 		userList = JSON.parse(userList);

// 		var latestRecord = userList.length - 1;

// 		//go through each record
// 		for (var i = 0; i < userList.length; i++) {

// 		    if (currentUser === userList[i].Email){

// 				console.log("User Record (display on load of #pageRecords):");
// 				console.log(userList[i]);

// 				$("#divUserSection").html(
// 					"<p><b>User Profile Details: </b><br>"+
// 					"FirstName : "	+userList[i].FirstName +"<br>"+
// 					"LastName : "	+userList[i].LastName +"<br>"+
// 					"DateOfBirth : "+userList[i].DateOfBirth +"<br>"+
// 					"Password : "	+userList[i].Password +"<br>"+
// 					"Email : "		+userList[i].Email +"<br>"+
// 					"Gender : "		+userList[i].Gender +"<br>"+
// 					"</p>"
// 					);

// 				var learningList = localStorage.getItem("learningList");

// 				// no data stored yet, create a new one
// 				if (learningList == null) {
// 					$("#tblRecords").html("No Records!");
// 				}else{

// 					// $("#tblRecords").attr('border', '1').html(
// 					$("#tblRecords").html(
// 					"   <tr>" +
// 					"     <th>Data</th>" +
// 					"     <th>Learing Type</th>" +
// 					"     <th>Hours Spend</th>" +
// 					"     <th>Edit</th>" +
// 					"     <th>Delete</th>" +
// 					"   </tr>"
// 					);

// 					//use a familiar general JS table object from here
// 					//the expense tracker app uses a different way
// 					var table = document.getElementById('tblRecords');

// 					learningList = JSON.parse(learningList);

// 					var flage =0;

// 					//go through each record
// 					for (var i = 0; i < learningList.length; i++) {

// 						if (currentUser === learningList[i].CurrentUser){

// 							flage++;

// 							var date = learningList[i].LearningDate;//Name attribute
// 						    var type = learningList[i].LearningType; // Address attribute
// 						    var hours = learningList[i].LearningHours; //PhoneNumber attribute

// 						    var r = table.insertRow();
// 						    r.insertCell(-1).innerHTML = date;
// 						    r.insertCell(-1).innerHTML = type;
// 						    r.insertCell(-1).innerHTML = hours;
// 						    r.insertCell(-1).innerHTML = '<a onclick="EditExistingRecord('+i+');" class="ui-shadow ui-btn ui-corner-all ui-icon-edit ui-btn-icon-notext ui-btn-inline"></a>';
// 						    r.insertCell(-1).innerHTML = '<a onclick="DeleteExistingRecord('+i+');" class="ui-shadow ui-btn ui-corner-all ui-icon-delete ui-btn-icon-notext ui-btn-inline"></a>';
// 						    // r.insertCell(-1).innerHTML = "<button data-icon='edit'>Edit</button>";
// 						}
// 					}//end for

// 					//check if current user has any learing history records
// 					if (flage == 0){
// 						$("#tblRecords").html("No Records!");
// 					}
// 				}
// 		    }
// 		}//end for 
// 	}
// });

function loadUserInformation(){

	//check if list exists
	var userList = localStorage.getItem("userList");

	var currentUser = localStorage.getItem("currentUser");

	if (userList == null) {
	    //no record whatsoever, let the user know
	    alert("No record found");
	} else {

		//if data exist, convert to JSON object
		userList = JSON.parse(userList);

		var latestRecord = userList.length - 1;

		//go through each record
		for (var i = 0; i < userList.length; i++) {

		    if (currentUser === userList[i].Email){

				console.log("User Record (display on load of #pageRecords):");
				console.log(userList[i]);

				$("#divUserSection").html(
					"<p><b>User Profile Details: </b><br>"+
					"FirstName : "	+userList[i].FirstName +"<br>"+
					"LastName : "	+userList[i].LastName +"<br>"+
					"DateOfBirth : "+userList[i].DateOfBirth +"<br>"+
					"Password : "	+userList[i].Password +"<br>"+
					"Email : "		+userList[i].Email +"<br>"+
					"Gender : "		+userList[i].Gender +"<br>"+
					"</p>"
					);
		    }
		}//end for 
	}

}

function listRecords (){

	//check if list exists
	var learningList = localStorage.getItem("learningList");

	var currentUser = localStorage.getItem("currentUser");

	// no data stored yet, create a new one
	if (learningList == null) {
		$("#tblRecords").html("No Records!");
	}else{

		// $("#tblRecords").attr('border', '1').html(
		$("#tblRecords").html(
		"   <tr>" +
		"     <th>Data</th>" +
		"     <th>Learing Type</th>" +
		"     <th>Hours Spend</th>" +
		"     <th>Edit</th>" +
		"     <th>Delete</th>" +
		"   </tr>"
		);

		//use a familiar general JS table object from here
		//the expense tracker app uses a different way
		var table = document.getElementById('tblRecords');

		learningList = JSON.parse(learningList);

		var flage =0;

		//go through each record
		for (var i = 0; i < learningList.length; i++) {

			if (currentUser === learningList[i].CurrentUser){

				flage++;

				var date = learningList[i].LearningDate;//Name attribute
			    var type = learningList[i].LearningType; // Address attribute
			    var hours = learningList[i].LearningHours; //PhoneNumber attribute

			    var r = table.insertRow();
			    r.insertCell(-1).innerHTML = date;
			    r.insertCell(-1).innerHTML = type;
			    r.insertCell(-1).innerHTML = hours;
			    r.insertCell(-1).innerHTML = '<a onclick="EditExistingRecord('+i+');" class="ui-shadow ui-btn ui-corner-all ui-icon-edit ui-btn-icon-notext ui-btn-inline"></a>';
			    r.insertCell(-1).innerHTML = '<a onclick="DeleteExistingRecord('+i+');" class="ui-shadow ui-btn ui-corner-all ui-icon-delete ui-btn-icon-notext ui-btn-inline"></a>';
			    // r.insertCell(-1).innerHTML = "<button data-icon='edit'>Edit</button>";
			}
		}//end for

		//check if current user has any learing history records
		if (flage == 0){
			$("#tblRecords").html("No Records!");
		}
	}
}


//#pageRecords
//
function AddNewRecord() {
	console.log("Add");
	$("#btnSubmitRecord").val("Add");
}


//#pageRecords
//
function EditExistingRecord(index) {
	console.log("Edit");
	$("#btnSubmitRecord").val("Edit");
	localStorage.setItem("editIndex",index);
	$.mobile.changePage("#pageNewRecordForm");
	displayRecord ();
}

//#pageRecords
//
function DeleteExistingRecord(index) {
	console.log("Delete");

	var currentUser = localStorage.getItem("currentUser");

	var learningList = JSON.parse(localStorage.getItem("learningList")); //JSON object

	console.log("Before Deleting Learning History");
	console.log(learningList);

	learningList.splice(index,1);

	console.log("After Deleting Learning History");
	console.log(learningList);

	if (learningList.length == 0) {	            
		/* No items left in records, remove entire 
           * array from localStorage
           */
          localStorage.removeItem("learningList");
          $("#tblRecords").html("No Records!");
      } else {
          //otherwise save it back
          localStorage.setItem("learningList", JSON.stringify(learningList));

          $("#tblRecords").html(
			"   <tr>" +
			"     <th>Data</th>" +
			"     <th>Learing Type</th>" +
			"     <th>Hours Spend</th>" +
			"     <th>Edit</th>" +
			"     <th>Delete</th>" +
			"   </tr>"
			);

			//use a familiar general JS table object from here
			//the expense tracker app uses a different way
			var table = document.getElementById('tblRecords');

			var flage = 0;

			//go through each record
			for (var i = 0; i < learningList.length; i++) {

				if (currentUser === learningList[i].CurrentUser){

					flage++;

					var date = learningList[i].LearningDate;//Name attribute
				    var type = learningList[i].LearningType; // Address attribute
				    var hours = learningList[i].LearningHours; //PhoneNumber attribute

				    var r = table.insertRow();
				    r.insertCell(-1).innerHTML = date;
				    r.insertCell(-1).innerHTML = type;
				    r.insertCell(-1).innerHTML = hours;
				    r.insertCell(-1).innerHTML = '<a onclick="EditExistingRecord('+i+');" class="ui-shadow ui-btn ui-corner-all ui-icon-edit ui-btn-icon-notext ui-btn-inline"></a>';
				    r.insertCell(-1).innerHTML = '<a onclick="DeleteExistingRecord('+i+');" class="ui-shadow ui-btn ui-corner-all ui-icon-delete ui-btn-icon-notext ui-btn-inline"></a>';
				    // r.insertCell(-1).innerHTML = "<button data-icon='edit'>Edit</button>";
				}
			}//end for

			//check if current user has any learing history records
			if (flage == 0){
				$("#tblRecords").html("No Records!");
			}

      }

    
      alert("Record Deleted");

      $.mobile.changePage("#pageRecords");
}

//#pageRecords
//
function clearRecordHistory(){

	var currentUser = localStorage.getItem("currentUser");

	try{

		var learningList = localStorage.getItem("learningList");

		// no data stored yet, create a new one
		if (learningList == null) {
		    alert("No record found");
		}
		else {
		    learningList = JSON.parse(learningList); //if found convert back to a JSON object
		}//end if-else

		console.log("Before Cleaning Learing History");
		console.log(learningList);

		//go through each record
		for (var i = 0; i < learningList.length; i++) {

			if (currentUser == learningList[i].CurrentUser){

				//remove item at i, 1 object 
		        learningList.splice(i,1);
		        i--;// Prevent skipping an item
			}
		}//end for
		console.log("After Cleaning Learing History");
		console.log(learningList);

		if (learningList.length == 0) {	            
			/* No items left in records, remove entire 
             * array from localStorage
             */
            localStorage.removeItem("learningList");
        } else {
            //otherwise save it back
            localStorage.setItem("learningList", JSON.stringify(learningList));
        }
        $("#tblRecords").html("No Records!");

        alert("Record Deleted");
		
	}catch(e){
		
		//Google broser use different error constant
		if (window.navigator.vendor === "Google Inc."){
			if (e == DOMException.QUOTA_EXCEEDED_ERR) {
				alert("Error: Local Storage limit exceeds");
			}
		} else if (e == QUOTA_EXCEEDED_ERR) {
			alert("Error: Storage to local storage");
		}

		console.log(e);
	}
}

//----------------------------------------------------------------

//#pageNewRecordForm
//store user's learning data to local storage
function checkAddOrEditRecord() {

	var formOperation = $("#btnSubmitRecord").val();

	if(formOperation == "Add"){
		addRecord();
		$.mobile.changePage("#pageRecord");
	}else if(formOperation == "Edit"){
		editRecord();
		$.mobile.changePage("#pageRecord");
	}
}

//#pageNewRecordForm
//
function displayRecord(){

	var learningList = JSON.parse(localStorage.getItem("learningList")); //JSON object
	var editRecordIndex = localStorage.getItem("editIndex");

	$("#pageNewRecordForm #datLearningDate").val(learningList[editRecordIndex].LearningDate);
	$("#pageNewRecordForm #txtType").val(learningList[editRecordIndex].LearningType);
	$("#pageNewRecordForm #txtHours").val(learningList[editRecordIndex].LearningHours);
}

//#pageNewRecordForm
//
function addRecord(){

	var currentUser = localStorage.getItem("currentUser");

	//first get the values from the fields 
	var record = {
		"CurrentUser"	: currentUser,
		"LearningDate"	: $("#datLearningDate").val(),
		"LearningType"	: $("#txtType").val(),
		"LearningHours"	: $("#txtHours").val()
	};

	try{

		var learningList = localStorage.getItem("learningList");

		// no data stored yet, create a new one
		if (learningList == null) {
		    learningList = [];//if not found, create a new array
		}
		else {
		    learningList = JSON.parse(learningList); //if found convert back to a JSON object
		}//end if-else

		learningList.push(record); //now add the new object

		//the save its string representation
		localStorage.setItem("learningList", JSON.stringify(learningList));

		alert("Saving Information");

		$.mobile.changePage("#pageRecords");
		window.location.reload();

	}catch(e){
		
		//Google broser use different error constant
		if (window.navigator.vendor === "Google Inc."){
			if (e == DOMException.QUOTA_EXCEEDED_ERR) {
				alert("Error: Local Storage limit exceeds");
			}
		} else if (e == QUOTA_EXCEEDED_ERR) {
			alert("Error: Storage to local storage");
		}

		console.log(e);
	}

}


//#pageNewRecordForm
//
function editRecord (){

	var currentUser = localStorage.getItem("currentUser");

	var editRecordIndex = localStorage.getItem("editIndex");

	//first get the values from the fields 
	var editedRecord = {
		"CurrentUser"	: currentUser,
		"LearningDate"	: $("#datLearningDate").val(),
		"LearningType"	: $("#txtType").val(),
		"LearningHours"	: $("#txtHours").val()
	};

	var learningList = JSON.parse(localStorage.getItem("learningList")); //JSON object

	learningList[editRecordIndex] = editedRecord; //now add the new object

	//the save its string representation
	localStorage.setItem("learningList", JSON.stringify(learningList));

	alert("Updated Information");

	$.mobile.changePage("#pageRecords");
	window.location.reload();
}

$(document).on("pageshow", function () {
 	if ($('.ui-page-active').attr('id') =="pageUserInfo") {
    	showUserForm();
 	}else if ($('.ui-page-active').attr('id') == "pageRecords"){
    	loadUserInformation();
    	listRecords();
	}else if ($('.ui-page-active').attr('id') == "pageAdvice"){
    	drawAdvice();
    	resizeGraph();
	}else if ($('.ui-page-active').attr('id') == "pageGraph"){
    	drawGraph();
    	resizeGraph();
	}
});

//----------------------------------------------------------------

//pageGraph
//
function drawGraph(){
	var learningList = JSON.parse(localStorage.getItem("learningList"));
	learningList.sort(function(a,b){
		return Date.parse(a.LearningDate) - Date.parse(b.LearningDate);
	});
	days = Number(learningList.length);
	for(i=0;i<days;i=i+1){
		console.log(learningList[i].LearningDate+"|"+learningList[i].LearningHours);
	}
	var hoursList = [];
	var dateList = [];
	minHours = 0;
	maxHours = Number(learningList[days-1].LearningHours);
	if(days<=1){
		alert("Alert! No Graph can be drawn, Graph requires more than one learing history record");
	}else if(days<=10){
		for(i=0;i<days;i=i+1){
			record = learningList[i];
			hoursList.push(Number(record.LearningHours));
			dateList.push(record.LearningDate);
			if(maxHours<Number(record.LearningHours)){
				maxHours = Number(record.LearningHours);
			}
			if(minHours>Number(record.LearningHours)){
				minHours = Number(record.LearningHours);
			}
		}
	}else if(days>10){
		alert("Alert! Graph can only display learing history record of the last 10 days");
		for(i=days-10;i<days;i++){
			record = learningList[i];
			hoursList.push(Number(record.LearningHours));
			dateList.push(record.LearningDate);
			if(maxHours<Number(record.LearningHours)){
				maxHours = Number(record.LearningHours);
			}
			if(minHours>Number(record.LearningHours)){
				minHours = Number(record.LearningHours);
			}
		}
	}
	hoursMap = hoursList.map(Number);
	drawLines(hoursMap,maxHours,minHours,dateList);
};

//pageGraph
//
function drawLines(hoursMap,maxHours,minHours,dateList){
	console.log(dateList);
	var hoursLine = new RGraph.Line("GraphCanvas",hoursMap,0,10)
	.Set("labels",dateList)
	.Set("colors",["blue"])
	.Set("shadow",true)
	.Set("shadow.offsetx",1)
	.Set("shadow.offsety",1)
	.Set("linewidth",1)
	.Set("ymax",maxHours)
	.Set("ymin",minHours)
	.Set("numxtricks",6)
	.Set("scale.decimals",2)
	.Set("xaxispos","bottom")
	.Set("gutter.left",40)
	.Set("tickmarks","filledcircle")
	.Set("ticksize",5)
	// .Set("chart.xmargin",10)
	.Set("chart.labels.ingraph",[,,["Hours","blue","yellow",1,80],,])
	.Set("chart.title","Hours Amount")
	.Set('chart.gutter.left', 50)
	.Set('chart.gutter.right', 50)
	.Draw();
}

//----------------------------------------------------------------

//pageAdvice
//
function drawAdvice(){
	var learningList = JSON.parse(localStorage.getItem("learningList"));
	sum = 0;
	var maxDate = new Date(learningList[0].LearningDate);
	var minDate = new Date(learningList[0].LearningDate);
	// var currdate = new Date(learningList[0].Date);
	// console.log(maxDate);
	// console.log(minDate);
	for(i=0;i<learningList.length;i++){
		sum = sum+Number(learningList[i].Expense);
		var currdate = new Date(learningList[i].LearningDate);
		console.log(currdate);
		if(maxDate.getTime()<currdate.getTime()){
			maxDate = currdate;
		}
		if(minDate.getTime()>currdate.getTime()){
			minDate = currdate;
		}
	}
	// console.log(maxDate);
	// console.log(minDate);
	var days = Number((maxDate.getTime()-minDate.getTime())/86400000+1);
	// console.log(maxDate.getTime());
	// console.log((maxDate.getTime()-minDate.getTime()));
	console.log(days);
	avgHours=Number(sum)/Number(days);
	avgHours = avgHours.toFixed(2);
	var canvas = document.getElementById("AdviceCanvas");
	var ctx = canvas.getContext("2d");
	if(avgHours<1){
		alert("Alert! Insufficient Data, Amount of Hours is less that 1");
	}else{
		drawTxtAdvice(ctx,avgHours);
	}
	ctx.stroke();
};

//pageAdvice
//
function drawTxtAdvice(ctx,avgHours){
	ctx.font = "22px Arial";
	ctx.fillStyle = "black";
	ctx.fillText("Your current daily Hours Spent is "+avgHours+".",25,320);
	ctx.fillText("Your target range is: 5-10 Hours",25,350);
	levelWrite(ctx,avgHours);
	levelMeter(ctx,avgHours);
};

//pageAdvice
//
function levelWrite(ctx,avgHours){
	if((avgHours>=1)&&(avgHours<=10)){
		writeAdvice(ctx,"green");
	}else if((avgHours>10)&&(avgHours<=50)){
		writeAdvice(ctx,"yellow");
	}else{
		writeAdvice(ctx,"red");
	}
};

//pageAdvice
//
function writeAdvice(ctx,level){
	var adviceLine1 = "";
	var adviceLine2 = "";
	if(level == "red"){
		adviceLine1 = "Please invest more time.";
		adviceLine2 = "It's exceedingly more than set limit.";
	}else if(level == "yellow"){
		adviceLine1 = "The get beck on track!";
	}else if(level == "green"){
		adviceLine1 = "Your on track.";
	}
	ctx.fillText("Your Learning Schedule level is "+level+".",25,380);
	ctx.fillText(adviceLine1,25,410);
	ctx.fillText(adviceLine2,25,440);
};

//pageAdvice
//
function levelMeter(ctx,avgHours){
	if(avgHours<=100){
		var cg = new RGraph.CornerGauge("AdviceCanvas",0,100,avgHours).Set("chart.colors.ranges",[
			[50,100,"red"],
			[10,50,"yellow"],
			[1,10,"#0f0"]
		]);
	}else{
		var cg = new RGraph.CornerGauge("AdviceCanvas",0,avgHours,avgHours).Set("chart.colors.ranges",[
			[50,100,"red"],
			[10,50,"yellow"],
			[0.01,0.1,"#0f0"],
			[100.01,avgHours,"red"]
		]);
	}
	drawMeter(cg);
};

//pageAdvice
//
function drawMeter(g){
	g.Set("chart.value.text.units.post"," Hours")
	.Set("chart.value.text.boxed",false)
	.Set("chart.value.text.size",14)
	.Set("chart.value.text.font","Verdana")
	.Set("chart.value.text.bold",true)
	.Set("chart.value.text.decimals",2)
	.Set("chart.shadow.offsetx",5)
	.Set("chart.shadow.offsety",5)
	.Set("chart.scale.decimals",2)
	.Set("chart.title","Hours Limit")
	.Set("chart.radius",250)
	.Set("chart.centerx",50)
	.Set("chart.centery",250)
	.Draw();
};



//----------------------------------------------------------------


function resizeGraph(){
	if ($(window).width() < 700) {
    	$("#GraphCanvas").css({"width": $(window).width() - 50});
    	$("#AdviceCanvas").css({"width": $(window).width() - 50});
	}
};

$(window).resize(function(){
 	resizeGraph();
});


//----------------------------------------------------------------

//Validation Functions

//check empty fields
function checkEmptyFields(inputDir){

	for (var i in inputDir) {
	  if (inputDir[i] == "" || inputDir[i] == "Choose Gender"){
	  	alert("Input Fields Cannot be Empty and Gender Needs to be Selected");
	  	return (false);
	  }
	}
	return (true);
}

//check email
function checkValidEmail(email){
	var mailformat = /^\w+([\.-]?\w+)*@\w+([\.-]?\w+)*(\.\w{2,3})+$/;
	if (email.match(mailformat))
	{
		return (true);
	}
	alert("You have entered an invalid email address!");
	return (false);
}

//check password matches
function checkValidPassword(password, confirm_password){
	if (password == confirm_password) {
        return (true);
    }
    alert("You have entered Password and Confirm Password that dont match!");
	return (false);
}

//check birth date
function checkValidDate(date){
	var varDate = new Date(date); //dd-mm-YYYY
	var today = new Date();
	today.setHours(0,0,0,0);

	if(varDate >= today) {
		alert("You have entered invalid date!");
		return (false);
	}
	return (true);
}

// //check address
function checkValidAddress(address){
	
	var firstChar = address.trim().substr(0, 1);

	 if (isNaN(firstChar)) {
        alert("Address should start with a number!");
        $("#address").focus();
        return (false);
    }
	return (true);
}

// //check phone number
function checkValidPhone(phone)  {

    var tokens = phone.split('-');

	for (var i = 0; i < tokens.length; i++) {
		console.log(tokens[i]);
	    if (isNaN(tokens[i])) {
	        alert("Please use only numbers or hyphens!");
	        $("#phone").focus();
	        return (false);
	    }//end if
	}//end for

}

//clear profile form
function clearUserForm() {
	//now clean up the form
	$("#signupFirstName").val('');
	$("#signupLastName").val('');
	$("#dateOfBirth").val('');
	$("#addPassword").val('');
	$("#confirmPassword").val('');
	$("#signupEmail").val('');
}