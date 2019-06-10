function draw(){
	var canvas = document.getElementById("canvasElement");
	var canvasContext = canvas.getContext("2d");
	drawAxes(canvasContext,"black","black",500,300,100);
}

function drawAxes(ctx,xColor,yColor,maxX,maxY,labelStep){
	ctx.fillStyle = xColor;
	ctx.fillRect(0,0,maxX,2);
	ctx.beginPath();
	ctx.moveTo(maxX+5,0);
	ctx.lineTo(maxX-10,10);
	ctx.lineTo(maxX-10,0);
	ctx.closePath();
	ctx.fill();
	ctx.fillText("X",maxX+20,10);
	for(var stop=labelStep;stop<=maxX;stop+=labelStep){
		ctx.fillRect(stop,0,2,5);
		ctx.fillText(stop,stop-5,20);
	}
	//y-axis
	ctx.fillStyle = yColor;ctx.fillRect(0,0,2,maxY);
	//arrow head
	ctx.beginPath();ctx.moveTo(0,maxY+5);ctx.lineTo(10,maxY-10);ctx.lineTo(0,maxY-10);ctx.closePath();ctx.fill();ctx.fillText("Y",10,maxY+20);
	//labels
	for(var stop=labelStep;stop<=maxY;stop+=labelStep){ctx.fillRect(0,stop,5,2);ctx.fillText(stop,10,stop+5);}
	//end fo
}