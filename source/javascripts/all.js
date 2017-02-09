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

// Google Analytics
(function(i,s,o,g,r,a,m){i['GoogleAnalyticsObject']=r;i[r]=i[r]||function(){
(i[r].q=i[r].q||[]).push(arguments)},i[r].l=1*new Date();a=s.createElement(o),
m=s.getElementsByTagName(o)[0];a.async=1;a.src=g;m.parentNode.insertBefore(a,m)
})(window,document,'script','//www.google-analytics.com/analytics.js','ga');

ga('create', 'UA-20956567-2', 'auto');
ga('send', 'pageview');
