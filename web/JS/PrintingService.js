//get the request
var requestModal = document.getElementById("myRequest");

//get the button that open the request 
var btn=document.getElementById("requestBtn");

//get the span element to close the request
var span = document.getElementById("close_front");

var buttonPrint = document.getElementsByClassName("buttonSubmit")[0];


//when the user clicks the button, open request
btn.onclick = function(){
    requestModal.style.display="block";
}

//when user click close symbol close
span.onclick = function(){
    requestModal.style.display="none";
}


buttonPrint.onclick = function(){
    alert("Submitted!");
    requestModal.style.display="none";
}

var requestConfirm = document.getElementById("myHelp");
var requestConfirm1 = document.getElementById("myHelp1");
var requestConfirm2 = document.getElementById("myHelp2");

var helpBtn = document.querySelectorAll(".helpButton").length;

var span2 = document.querySelectorAll(".close").length;

var buttonHelp = document.querySelectorAll(".buttonHelp").length;

for (var i = 0; i<helpBtn; i++){
    document.querySelectorAll(".helpButton")[i].addEventListener("click",function(){
        requestConfirm.style.display="block";
        requestConfirm1.style.display="block";
        requestConfirm2.style.display="block";
    });
}
//when user click close symbol close
for (var i=1; i<span2; i++)
{
    document.querySelectorAll(".close")[i].addEventListener("click",function(){
        requestConfirm.style.display="none";
        requestConfirm1.style.display="none";
        requestConfirm2.style.display="none";
    });
}

