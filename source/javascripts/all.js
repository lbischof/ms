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
            qty += 1;
        // only filled number inputs
        } else if (inputs[i].type == "number" && inputs[i].value) {
            qty += +inputs[i].value;
            // so that cart output is visually correct
            inputs[i-1].checked = true;
        }
    }
    event.target.elements["qty1"].value = qty;
}
