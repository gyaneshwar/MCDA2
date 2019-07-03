
var complete_url = "http://dev.cs.smu.ca:8150";

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
	var save_url = complete_url+'/saveUniversity';
	$.ajax({url:save_url,type:'POST',crossDomain: true,data:object_store, success:function(data){
		alert(data);
		console.log(data);
		clearData();
	},error:function(data){
		console.log(data);
	}});
}


function clearData(){
	$("#name").val("");
	$("#address").val("");
	$("#phone").val("");

}


function search_assignment3(){
	var search_item = $("#search").val();
	var total_url = complete_url+'/searchUniversity/'+search_item;
	$.ajax({url:total_url,type:'GET',crossDomain: true, success:function(store){
	console.log(store);
	displayValues(store);
},error:function(store){
	console.log(store);
	displayValues(store);
	console.log("error in get");
}});	
}


function displayall_assignment3(){
	var display_url = complete_url+'/allUniversities';
	$.ajax({url:display_url,type:'GET',crossDomain: true, success:function(store){
	console.log(store);
	displayValues(store);
},error:function(data){
	console.log(data);
	displayValues(data);
	console.log("error in get");
}});	
}

function displayValues(store){
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
	var object_store = { "name": name, "address": address , "phone": phone };
	var delete_url = complete_url+'/deleteUniversity';
	$.ajax({url:delete_url,crossDomain: true,type:'DELETE',data:object_store,success:function(data){
		alert(data);
		console.log(data);
		clearData();
	},fail:function(data){
		console.log(data);
	}});
}