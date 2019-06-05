function add(){
	var Number1 = $("#Number1").val()*1;
	var Number2 = $("#Number2").val()*1;
	$("#result").html(Number2 + Number1);
}

function subtract(){
	var Number1 = $("#Number1").val()*1;
	var Number2 = $("#Number2").val()*1;
	$("#result").html(Number1 - Number2);
}

function multiply(){
	var Number1 = $("#Number1").val()*1;
	var Number2 = $("#Number2").val()*1;
	$("#result").html(Number2 * Number1);
}

function divide(){
	var Number1 = $("#Number1").val()*1;
	var Number2 = $("#Number2").val()*1;
	$("#result").html(Number1 / Number2);
}

function display(){
	var angle = $("#angle").val();
	var velocity = $("#velocity").val();
	$("#angleDisplay").html(angle);
	$("#velocityDisplay").html(velocity);
	calculate(angle,velocity);
}

function calculate(angle,velocity){
	var horizontalVelocity = velocity * Math.cos((angle*Math.PI)/180);
	var verticalVelocity = velocity * Math.sin((angle*Math.PI)/180);

	var maxHeight = verticalVelocity/9.81;
	var landing = 2*maxHeight;

	$("#maxheight").html(calHeight(verticalVelocity,maxHeight));
	$("#distancetravelled").html(calDistance(horizontalVelocity,landing));

	plottable(angle,velocity);
}

function plottable(angle,velocity){
	var horizontalVelocity = velocity * Math.cos((angle*Math.PI)/180);
	var verticalVelocity = velocity * Math.sin((angle*Math.PI)/180);

	var maxHeight = verticalVelocity/9.81;
	var landing = 2*maxHeight;

	var resultArray = [];

	if(landing < 2){
		var interval = 0.2;
	} else if(landing < 20){
		var interval = 1;
	}else{
		var interval = 10;
	}

	for(var time = 0 ; time <= landing+interval ; time+=interval){
		let obj = {};
		obj.time = time;
		var height = calHeight(verticalVelocity,time);
		if(height<0){
			height = 0;
		}
		obj.height = height;

		var distance = calDistance(horizontalVelocity,time);
		if(distance < 0){
			distance = 0;
		}

		obj.distance = distance;

		resultArray.push(obj);
	}

	updatetable(resultArray);
}

function updatetable(result){
	var syntax = "<tr><th>height</th><th>time</th><th>distance</th></tr>";
	result.forEach(function(item){
		syntax+="<tr><td>"+item.height+"</td><td>"+item.time+"</td><td>"+item.distance+"</td></tr>";
	});
	$("#result").html(syntax);
}

function calHeight(velocity,time){
	return ((velocity*time) - (0.5*9.8*time*time));
}

function calDistance(horizontalVelocity, time)  { return horizontalVelocity * time;}

function initialize(){
	var angle = document.getElementById("angle");
	var velocity = document.getElementById("velocity");

	angle.addEventListener("mouseover",validateAngle);
	velocity.addEventListener("mouseover",validateVelocity);

}

function validateAngle(){
	var angle = $("#angle").val()*1;
	if(angle > 180 || angle < 0){
		alert("angle range 0 to 180 degrees");
		$("#angle").val(0);
	}
}

function validateVelocity(){
	var velocity = $("#velocity").val()*1;
	if(velocity < 1 || velocity > 299792){
		alert("velocity range 1 to 299792");
		$("#velocity").val(1);
	}
}
