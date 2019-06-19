
function display(){
	
}

/* Adds given text value to the password text 
 * field
 */
function addValueToPassword(button) {
    var currVal = $("#passcode").val();
    if (button === "bksp") {
        $("#passcode").val(currVal.substring(0, currVal.length - 1));
    } else {
        $("#passcode").val(currVal.concat(button));
    }
}

/**Function to store the data on click of sign up **/
function saveSignUpUser(){
	var user={
		"FirstName":$("#signupFirstName").val(),
		"LastName":$("#signupLastName").val(),
		"DateOfBirth":$("#dateOfBirth").val(),
		"NewPassword":$("#confirmPassword").val(),
    "Email":$("#signupEmail").val(),
		"Gender":$("#signupgenderType option:selected").val()
	};
 console.log(user);
	try{
		localStorage.setItem("user", JSON.stringify(user));
		alert("Saving Information");
		$.mobile.changePage("#legalNotice");
		window.location.reload();
	} catch(e){
		if(window.navigator.vendor === "Google Inc."){
			if(e == DOMException.QUOTA_EXCEEDED_ERR){
				alert("Error: local Storage limit exceeds.");
			}
		} else if (e == QUOTA_EXCEEDED_ERR){
			alert("Error: Saving to local storage.");
		}

		console.log(e);
	}
}

function saveDisclaimer(){
	localStorage.setItem("agreedToLegal","true");
	$.mobile.changePage("#pageMenu");
	window.location.reload();
}

function redirectPage(){
	//if the password matches
  var user_credentials = JSON.parse(localStorage.getItem("user"));
  var password = user_credentials.NewPassword;
  var userName = user_credentials.FirstName;
    if (document.getElementById("passcode").value === password && document.getElementById("username").value === userName )
    {
        //if not agreed yet
        if (localStorage.getItem("agreedToLegal") === null) 
       {
            $("#btnEnter").attr("href","#legalNotice").button();
        } 
        else if (localStorage.getItem("agreedToLegal") === "true") 
        {
               $("#btnEnter").attr("href","#pageMenu").button();
        }
    }
 	else {
        alert("Incorrect username/password, please try again.");
    }

}

function saveUserForm(){

var user={
    "FirstName":$("#profile_firstname").val(),
    "LastName":$("#profile_lastname").val(),
    "DateOfBirth":$("#profile_date").val(),
    "NewPassword":$("#profile_editpassword").val(),
    "Email":$("#profile_signupEmail").val(),
    "Gender":$("#profile_gender option:selected").val()
  };

  console.log(user);
  try{
    localStorage.setItem("user", JSON.stringify(user));
    alert("updating Information");
   // $.mobile.changePage("#legalNotice");
   // window.location.reload();
  } catch(e){
    if(window.navigator.vendor === "Google Inc."){
      if(e == DOMException.QUOTA_EXCEEDED_ERR){
        alert("Error: local Storage limit exceeds.");
      }
    } else if (e == QUOTA_EXCEEDED_ERR){
      alert("Error: Saving to local storage.");
    }

    console.log(e);
  }

}

function showUserForm(){
  var u = JSON.parse(localStorage.getItem("user"));
  console.log(u);
  $("#profile_firstname").val(u.FirstName);
  $("#profile_lastname").val(u.LastName);
  $("#profile_date").val(u.DateOfBirth);
  $("#profile_signupEmail").val(u.Email);
  $("#profile_gender").val(u.Gender);
  $("#profile_gender").selectmenu("refresh")
}

function loadUserInformation(){
  var u = JSON.parse(localStorage.getItem("user"));
  console.log(u);
  $("#show_firstname").html(u.FirstName);
  $("#show_lastname").html(u.LastName);
  $("#show_dob").html(u.DateOfBirth);
  $("#show_email").html(u.Email);
  $("#show_gender").html(u.Gender);
}

function AddNewRecord(){
  /*.button("refresh") function forces jQuery
   * Mobile to refresh the text on the button
   */
   
   $.mobile.changePage("#pageNewRecordForm");
   window.location.reload();
  $("#btnSubmitRecord").val("Add Learning").button("refresh");

}

function listRecords(){
  var data = localStorage.getItem("records");
  var html = "<thead><tr><th>Date</th><th>Type</th><th>Hours</th><th></th><th></th></tr></thead><tbody>";
  if(data){
    data = JSON.parse(data);
    for (var i = 0; i < data.length; i++) {
      html = html + "<tr><td>"+data[i].Date+"</td><td>"+data[i].Type+"</td><td>"+data[i].Amount+"</td><td>"+editTemplate(i)+"</td><td>"+deleteTemplate(i)+"</td></tr>";
    }
  }
  html = html + "</tbody>";
  $("#tblRecords").html(html);
  $('#tblRecords').DataTable();
}

function editTemplate(i){
  return "<a href='#pageNewRecordForm' data-icon='edit' id='button_"+i+"' onclick='editRecord("+i+")'>Edit</a>";
}


function deleteTemplate(i){
  return "<a href='#' data-icon='delete' id='button_"+i+"' onclick='deleteRecord("+i+")'>Delete</a>";
}


// Removes all record data from localStorage 
function clearRecordHistory() {
  localStorage.removeItem("records");
  listRecords();
  alert("All records have been deleted.");
};

function checkAddOrEditRecord() {
  var formOperation = $("#btnSubmitRecord").val();
  if (formOperation == "Add Learning") {
    addRecord();
    $.mobile.changePage("#pageRecords");
  } else if (formOperation == "Update Learning") {
    updateRecord($("#btnSubmitRecord").attr("indexToEdit"));
    $.mobile.changePage("#pageRecords");
    $("#btnSubmitRecord").removeAttr("indexToEdit");
  }
  /*Must return false, or else submitting form
   * results in reloading the page
   */
  return false;

}

function updateRecord(index){
  var record = {
    "Date":$("#datLearningDate").val(),
    "Type":$("#txtType").val(),
    "Amount":$("#txtAmount").val()
  };
  let data = localStorage.getItem("records");
  if(data){
    data = JSON.parse(data);
    data.splice(index,1,record);
  } else {
    data = [];
    data.push(record);
  }
  localStorage.setItem("records",JSON.stringify(data));
}

function editRecord(index){
   $.mobile.changePage("#pageNewRecordForm");
  // window.location.reload();
$("#btnSubmitRecord").val("Update Learning").button("refresh");
$("#btnSubmitRecord").attr("indexToEdit",index);
var data = localStorage.getItem("records");
if(data){
  data = JSON.parse(data);
  data = data[index];
  $("#datLearningDate").val(data.Date);
  $("#txtType").val(data.Type);
  $("#txtAmount").val(data.Amount);
}

}

function deleteRecord(index){
  var data = localStorage.getItem("records");
  if(data){
    data = JSON.parse(data);
    data.splice(index,1);
    localStorage.setItem("records",JSON.stringify(data));
  }
  listRecords();
}

function addRecord(){
  var record = {
    "Date":$("#datLearningDate").val(),
    "Type":$("#txtType").val(),
    "Amount":$("#txtAmount").val()
  };
  let data = localStorage.getItem("records");
  if(data){
    data = JSON.parse(data);
    data.push(record);
  } else {
    data = [];
    data.push(record);
  }
  localStorage.setItem("records",JSON.stringify(data));
}

function drawAdviceCanvas(ctx, expense) {
  ctx.font = "22px Arial";
  ctx.fillStyle = "black";
  ctx.fillText("Your current expense is " + expense +  ".", 25, 320);

    ctx.fillText(
      "Your target Expense range is: 50-100CAD",  25, 350);
    levelwrite(ctx, expense);
    levelMeter(ctx, expense);
}

//For deciding what to write for given values
function levelwrite(ctx, expense) {
  if ((expense >= 1) && (expense <= 10)) {
    writeAdvice(ctx, "green");
  } else if ((expense > 10) && (expense <= 50)) {
    writeAdvice(ctx, "yellow");
  } else {
    writeAdvice(ctx, "red");
  }
}

function writeAdvice(ctx, level) {
  var adviceLine1 = "";
  var adviceLine2 = "";

  if (level == "red") {
    adviceLine1 = "Please take care of the learning.";
    adviceLine2 = "Its exceedingly more than set limit.";
  } else if (level == "yellow") {
    adviceLine1 = "The learning needs to be checked!!";
  } else if (level = "green") {
    adviceLine1 =
      "Your learning are on track .";
  }
  ctx.fillText("Your Expense is " + level +
    ".", 25, 380);
  ctx.fillText(adviceLine1, 25, 410);
  ctx.fillText(adviceLine2, 25, 440);
}


//----------------------------------------------------------------

//pageGraph
//
function drawGraph(){
  var records = JSON.parse(localStorage.getItem("records"));
  records.sort(function(a,b){
    return Date.parse(a.Date) - Date.parse(b.Date);
  });
  days = Number(records.length);
  for(i=0;i<days;i=i+1){
    console.log(records[i].Date+"|"+records[i].Amount);
  }
  var hoursList = [];
  var dateList = [];
  minHours = 0;
  maxHours = Number(records[days-1].Amount);
  if(days<=1){
    alert("Alert! No Graph can be drawn, Graph requires more than one learing history record");
  }else if(days<=10){
    for(i=0;i<days;i=i+1){
      record = records[i];
      hoursList.push(Number(record.Amount));
      dateList.push(record.Date);
      if(maxHours<Number(record.Amount)){
        maxHours = Number(record.Amount);
      }
      if(minHours>Number(record.Amount)){
        minHours = Number(record.Amount);
      }
    }
  }else if(days>10){
    alert("Alert! Graph can only display learing history record of the last 10 days");
    for(i=days-10;i<days;i++){
      record = records[i];
      hoursList.push(Number(record.Amount));
      dateList.push(record.Date);
      if(maxHours<Number(record.Amount)){
        maxHours = Number(record.Amount);
      }
      if(minHours>Number(record.Amount)){
        minHours = Number(record.Amount);
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
function advicePage(){
  var records = JSON.parse(localStorage.getItem("records"));
  sum = 0;
  var maxDate = new Date(records[0].Date);
  var minDate = new Date(records[0].Date);
  // var currdate = new Date(records[0].Date);
  // console.log(maxDate);
  // console.log(minDate);
  for(i=0;i<records.length;i++){
    sum = sum+Number(records[i].Amount);
    var currdate = new Date(records[i].Date);
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

