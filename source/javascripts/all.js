//= require_tree .

var forms = document.forms;
for (var i = 0; i < forms.length; i++) {
    if (forms[i].addEventListener) {
        forms[i].addEventListener("submit", submitForm, false);  //Modern browsers
    } else if(forms[i].attachEvent) {
        forms[i].attachEvent('onsubmit', submitForm);            //Old IE
    }
}

function submitForm(event) {
    // only include product1 inputs
    var inputs = event.target.elements["product1[]"];
    var qty = 0;
    for (var i = 0; i < inputs.length; i++) {
        // only checked checkboxes
        if (inputs[i].checked) {
            // the next input might be of type number
            if (inputs[i+1] && inputs[i+1].type == "number") {
                // if it's zero it should be 1
                +inputs[i+1].value == 0 ? inputs[i+1].value = 1 : null;
                // add the value to qty and convert string to integer
                qty += +inputs[i+1].value;
            } else {
                // if theres no following number input
                qty += 1;
            }
        // if the number input has value, the last checkbox should be checked
        } else if (inputs[i].type == "number" && inputs[i].value && !inputs[i-1].checked) {
            // since we missed the last checkbox, add the value
            qty += +inputs[i].value;
            // so that cart output is visually correct
            inputs[i-1].checked = true;
        }
    }
    event.target.elements["qty1"].value = qty;
}
