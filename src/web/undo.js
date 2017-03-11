undo1();
function undo1() {
    
    var spend_button = document.createElement("BUTTON");
    spend_button.id = "undo_button";
    var spend_button_text = document.createTextNode("undo");
    spend_button.appendChild(spend_button_text);
    spend_button.onclick = function() {
	variable_get(["undo"], spend3);
    };
    document.body.appendChild(document.createElement("br"));
    document.body.appendChild(spend_button);
    document.body.appendChild(document.createElement("br"));
}

    
