spend1();
function spend1() {
    var pic = document.createElement("img");
    pic.setAttribute("id", "board");
    pic.setAttribute("src", "board.png");
    pic.setAttribute("onclick", "spend2(event)");
    document.body.appendChild(pic);
    document.body.appendChild(document.createElement("br"));
}
function spend2(event) {
    //var pic = document.getElementById("board");
    loc = getOffset(event);
    Y = Math.round((loc.x-10) / 19)+1;
    X = Math.round((loc.y-10) / 19)+1;
    console.log(X);
    console.log(Y);
    variable_get(["play", X, Y], spend3);
}
function spend3(x) {
    var pic = document.getElementById("board");
    pic.setAttribute("src", "board.png?" + new Date().getTime());

	//var fee = parseInt(spend_fee.value, 16);
	//local_get(["doit", fee]);
	//console.log(spend_fee.value);
	//variable_get([spend_fee.value, ds], doit2);
	//console.log(ABC.value);

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
