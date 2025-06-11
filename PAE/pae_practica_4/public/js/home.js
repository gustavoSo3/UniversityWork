let registerForm = document.getElementById('registerForm');

let registerName = document.getElementById('registerName');
let registerLastName = document.getElementById('registerLastName');
let registerEmail = document.getElementById('registerEmail');
let registerPassword = document.getElementById('registerPassword');
let registerRPassword = document.getElementById('registerRPassword');
let registerDate = document.getElementById('registerDate');
let registerURL = document.getElementById('registerURL');
let registerButton = document.getElementById('registerButton');

let loginButton = document.getElementById('loginButton');
let loginEmail = document.getElementById('loginEmail');
let loginPassword = document.getElementById('loginPassword');

registerForm.addEventListener("change", (e) => {
	const invalid = document.querySelectorAll('input:invalid');
	let areValid = true;
	if(invalid.length > 0) areValid = false;
	if(registerPassword.value != registerRPassword.value) areValid = false;


	if(areValid){
		registerButton.classList.remove("disabled");
	}else { 
		registerButton.classList.add("disabled");
		log("Campo invalido");
	}
});

registerForm.addEventListener("submit", (e) => {
	let sexo = getSex();
	let user = {
    nombre:	registerName.value,
    apellido:	registerLastName.value,
    correo:	registerEmail.value,
    url: "",
    sexo:	sexo,
    fecha:	registerDate.value,
  	password:	registerPassword.value
	};

	var xhttp = new XMLHttpRequest();

	xhttp.onreadystatechange = function() {
		let success = document.getElementById("successRegister");
		let fail = document.getElementById("failRegister");
    if (this.status == 201) {
			success.classList.remove("d-none");
			fail.classList.add("d-none");
    }else {
			success.classList.add("d-none");
			fail.classList.remove("d-none");
			log(this.responseText);
		}
  };

	xhttp.open("POST", "https://users-dasw.herokuapp.com/api/users", true);
	xhttp.setRequestHeader("Content-Type", "application/json");
	xhttp.setRequestHeader("x-admin", sessionStorage.token);
	xhttp.send(JSON.stringify(user));
	e.preventDefault();
});

loginButton.addEventListener("click", (e) => {
	let user = {
  	correo: loginEmail.value,
  	password: loginPassword.value
	};
	log(loginPassword);

	var xhttp = new XMLHttpRequest();

	xhttp.onreadystatechange = function() {
    if (this.readyState == 4 && this.status == 200) {
			sessionStorage.userToken = JSON.parse(this.responseText).token;
			window.location.href = "/consulta.html";
    }
		log(this.responseText);
  };

	xhttp.open("POST", "https://users-dasw.herokuapp.com/api/login", true);
	xhttp.setRequestHeader("Content-Type", "application/json");
	xhttp.setRequestHeader("x-admin", sessionStorage.token);
	xhttp.send(JSON.stringify(user));
	e.preventDefault();
});

function getSex(){
	const rbs = document.querySelectorAll('input[name="sexo"]');
	for (const rb of rbs) {
		if (rb.checked) {
			return rb.value;
		}
	}
}