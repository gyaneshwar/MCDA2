
function display(){
	var min = $("#min").val()*1;
	var max = $("#max").val()*1;
	var syntax = "<tr><th>N</th><th>N<sup>2</sup></th><th>N<sup>3</sup></th></tr>";
	for(;min <= max;min += 5){
		syntax+="<tr><td>"+Math.pow(min,1)+"</td><td>"+Math.pow(min,2)+"</td><td>"+Math.pow(min,3)+"</td></tr>";
	}
	$("#data").html(syntax);
}
