// CheckBox Function to enable/disable submit button
function goFurther(){
  var submitBtn = document.getElementById('btnSubmit');
  if (document.getElementById("chkAgree").checked) {
      submitBtn.style.background = 'linear-gradient(to right, #FA4B37, #DF2771)';
      submitBtn.disabled = false; // Enable the button
  } else {
      submitBtn.style.background = 'lightgray';
      submitBtn.disabled = true; // Disable the button
  }
}

// Initially disable the submit button and set the background color
document.getElementById('btnSubmit').style.background = 'lightgray';
document.getElementById('btnSubmit').disabled = true;


// For LOGIN and REGISTER switching
var x = document.getElementById("login");
var y = document.getElementById("register");
var z = document.getElementById("btn");
var a = document.getElementById("log");
var b = document.getElementById("reg");
var w = document.getElementById("other");

function register() {
  x.style.left = "-400px";
  y.style.left = "50px";
  z.style.left = "110px";
  b.style.color = "#fff";
  a.style.color = "#000";
}

function login() {
  x.style.left = "50px";
  y.style.left = "450px";
  z.style.left = "0px";
  a.style.color = "#fff";
  b.style.color = "#000";
}



