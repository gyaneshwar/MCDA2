
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
		"LastName":$("signupLastName").val(),
		"DateOfBirth":$("dateOfBirth").val(),
		"SINNumber":$("signupsinNumber").val(),
		"NewPassword":$("#confirmPassword").val(),
		"Gender":$("#signgenderType option:selected").val()
	};

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

}

function AddNewRecord(){
  /*.button("refresh") function forces jQuery
   * Mobile to refresh the text on the button
   */
  $("#btnSubmitRecord").val("Add").button(
    "refresh");

}

// Removes all record data from localStorage 
function clearRecordHistory() {
  localStorage.removeItem("tbRecords");
  listRecords();
  alert("All records have been deleted.");
};

function checkAddOrEditRecord() {
  var formOperation = $("#btnSubmitRecord").val();

  if (formOperation == "Add Expense") {
    addRecord();
    $.mobile.changePage("#pageRecords");
  } else if (formOperation == "Update Expense") {
    editRecord($("#btnSubmitRecord").attr("indexToEdit"));
    $.mobile.changePage("#pageRecords");
    $("#btnSubmitRecord").removeAttr("indexToEdit");
  }
  /*Must return false, or else submitting form
   * results in reloading the page
   */
  return false;

}

