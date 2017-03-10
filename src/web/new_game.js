spend1();
function spend1() {
    var days = document.createElement("INPUT");
    days.setAttribute("type", "text"); 
    var days_info = document.createElement("h8");
    days_info.innerHTML = "how big: ";
    document.body.appendChild(days_info);
    document.body.appendChild(days);
    document.body.appendChild(document.createElement("br"));
    
    
    var spend_button = document.createElement("BUTTON");
    spend_button.id = "spend_button";
    var spend_button_text = document.createTextNode("new game");
    spend_button.appendChild(spend_button_text);
    spend_button.onclick = function() {
	var ds = parseInt(days.value, 10);
	variable_get(["new_game", ds], spend3);
    };
    document.body.appendChild(spend_button);
    document.body.appendChild(document.createElement("br"));

}

