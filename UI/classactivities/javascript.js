function display(){
	var angle = $("#angle").val();
	var velocity = $("#velocity").val();
	$("#angleDisplay").html(angle);
	$("#velocityDisplay").html(velocity);
}

function save_assignment3(){
	var name = $("#name").val();
	var address = $("#address").val();
	var phone = $("#phone").val();

	if(name == ""){
		alert("Please enter the name of the university");
		$("#name").focus();
		return false;
	}
	if(address == ""){
		alert("Please enter the address of the university");
		$("#address").focus();
		return false;
	}

	var address_start = address.trim().substring(0,1);
	if(isNaN(address_start)){
		alert("address should start with number");
		$("#address").focus();
		return false;
	}

	var pattern = /[a-z]/i;
	if(!(pattern.test(address))){
		alert("address should contain letters");
		$("#address").focus();
		return false;
	}

	if(phone == ""){
		alert("Please enter the phone no of the university");
		$("#phone").focus();
		return false;
	}

	var phone_split = phone.trim().split('-');
	for(var i = 0 ; i < phone_split.length; i++){
		if(isNaN(phone_split[i])){
			alert("Please enter the numeric digits in phone number.");
			$("#phone").focus();
			return false;
		}
	}


	var object_store = { "name": name, "address": address , "phone": phone };

	store = localStorage.getItem("universities");
	if(store == null){
		store = [];
	} else {
		store = JSON.parse(store);
	}

	store.push(object_store);
	localStorage.setItem("universities",JSON.stringify(store));
	clearData();
}

function clearData(){
	$("#name").val("");
	$("#address").val("");
	$("#phone").val("");
	$("#search").val("");

}

function search_assignment3(){
	var search_item = $("#search").val();
	result = [];
	store = localStorage.getItem("universities");
	if(store == null){
		store = [];
	} else {
		store = JSON.parse(store);
	}
	for(var i = 0; i < store.length; i++){
		check_val = store[i];
		if(check_val.name == search_item || check_val.address == search_item || check_val.phone == search_item){
				$("#name").val(check_val.name);
				$("#address").val(check_val.address);
				$("#phone").val(check_val.phone);
				return;

				//display search values:
				result.push(check_val);
		}
	}

	//display the results
	var result_table = "<tr><th>Name</th><th>Address</th><th>Phone</th></tr>";
	for(var i = 0 ; i < result.length ; i++){
		result_table += "<tr><td>"+result[i].name+"</td><td>"+result[i].address+"</td><td>"+result[i].phone+"</td></tr>";
	}
	$("#data").html(result_table);
}


function displayall_assignment3(){
	store = localStorage.getItem("universities");
	if(store == null){
		store = [];
	} else {
		store = JSON.parse(store);
	}
	var result_table = "<tr><th>Name</th><th>Address</th><th>Phone</th></tr>";
	for(var i = 0 ; i < store.length ; i++){
		result_table += "<tr><td>"+store[i].name+"</td><td>"+store[i].address+"</td><td>"+store[i].phone+"</td></tr>";
	}
	$("#data").html(result_table);
}

function delete_assignment3(){
	var name = $("#name").val();
	var address = $("#address").val();
	var phone = $("#phone").val();
	result = [];
	store = localStorage.getItem("universities");
	if(store == null){
		store = [];
	} else {
		store = JSON.parse(store);
	}
	for(var i = 0; i < store.length; i++){
		check_val = store[i];
		if(check_val.name == name || check_val.address == address || check_val.phone == phone){
			store.splice(i,1);
			localStorage.setItem("universities",JSON.stringify(store));
			clearData();
			return;
		}
	}
}