var c = document.getElementById("myCanvas");
var ctx = c.getContext("2d");
var empty = document.createElement("img");
empty.setAttribute("src", "empty.png");
var black = document.createElement("img");
black.setAttribute("src", "black.png");
var white = document.createElement("img");
white.setAttribute("src", "white.png");
variable_get(["board"], board);
function spend2(event) {
    loc = getOffset(event);
    Y = Math.round((loc.x-10) / 19)+1;
    X = Math.round((loc.y-10) / 19)+1;
    console.log(X);
    console.log(Y);
    local_get(["play", X, Y]);
    variable_get(["board"], function(x){board2(x, Y, X);} );
}
var pixels = 19;
function board(x) {
    console.log("board");
    console.log(x);
    xLength = x.length;
    for (var i = 0; i < xLength; i++) {
	for (var j = 0; j < xLength; j++) {
	    board2(x, i, j);
	}
    }
}
function board2(x, i, j) {
    var b = x[j][i];
    if(b=="empty"){ctx.drawImage(empty, (i-1)*pixels, (j-1)*pixels);}
    if(b=="black"){ctx.drawImage(black, (i-1)*pixels, (j-1)*pixels);}
    if(b=="white"){ctx.drawImage(white, (i-1)*pixels, (j-1)*pixels);}
}
    
function getOffset(evt) {
    var el = evt.target,
	x = 0,
	y = 0;

    while (el && !isNaN(el.offsetLeft) && !isNaN(el.offsetTop)) {
	x += el.offsetLeft - el.scrollLeft;
	y += el.offsetTop - el.scrollTop;
	el = el.offsetParent;
    }

    x = evt.clientX - x;
    y = evt.clientY - y;

    return { x: x, y: y };
}

c.addEventListener("mousedown", spend2, false);
