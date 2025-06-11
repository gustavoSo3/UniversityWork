let users = []; 
let searchUser = [];
let filteredUsers = [];
let nUsers;
let nPages;

let selectedUser;

let page = 0;

let userSearch = document.getElementById('userSearch');
let userSearchButton = document.getElementById('userSearchButton');
let paginationBar = document.getElementById('paginationBar');

let prevButton;
let nextButton;

let updateForm = document.getElementById('updateForm');
let updateName = document.getElementById('updateName');
let updateLastName = document.getElementById('updateLastName');
let updateEmail = document.getElementById('updateEmail');
let updateDate = document.getElementById('updateDate');
let updatePassword = document.getElementById('updatePassword');
let updateRPassword = document.getElementById('updateRPassword');
let updateURL = document.getElementById('updateURL');
let updateButton = document.getElementById('updateButton');
let successUpdate = document.getElementById('successUpdate');
let failUpdate = document.getElementById('failUpdate');
let deleteUserButton = document.getElementById('deleteUserButton');

deleteUserButton.addEventListener('click', e => {
	deleteUser(selectedUser.correo);
	location.reload();
});

updateForm.addEventListener('change', (e) => {
	const invalid = document.querySelectorAll('input:invalid');
	let areValid = true;
	if(invalid.length > 0) areValid = false;
	if(updatePassword.value != updateRPassword.value) areValid = false;

	if(areValid){
		updateButton.classList.remove("disabled");
	}else { 
		updateButton.classList.add("disabled");
		log("Mising update Field");
	}
});

updateForm.addEventListener('submit', (e) => {
	let sexo = getSex();
	let user = {
    nombre:	updateName.value,
    apellido:	updateLastName.value,
    correo:	updateEmail.value,
    url: updateURL.value,
    sexo:	sexo,
    fecha:	updateDate.value,
  	password:	updatePassword.value
	};

	var xhttp = new XMLHttpRequest();
	
	xhttp.onreadystatechange = function() {
		let success = document.getElementById("successUpdate");
		let fail = document.getElementById("failUpdate");
    if (this.readyState == 4 && this.status == 200) {
			success.classList.remove("d-none");
			fail.classList.add("d-none");
			updateFilter();
    }else {
			success.classList.add("d-none");
			fail.classList.remove("d-none");
			log(this.responseText);
		}
	};

	xhttp.open("PUT", `https://users-dasw.herokuapp.com/api/users/${selectedUser.correo}`, false);
	xhttp.setRequestHeader("Content-Type", "application/json");
	xhttp.setRequestHeader("x-admin", sessionStorage.token);
	xhttp.setRequestHeader("x-auth", sessionStorage.userToken);
	xhttp.send(JSON.stringify(user));
});

function userToHTML(user) {
	return `
	<div class="media col-8 mt-2">
		<div class="media-left align-self-center mr-3">
			<img class="rounded-circle" src="${user.url}">
		</div>
		<div class="media-body">
			<h4> ${user.nombre + " " + user.apellido}</h4>
			<p>Correo: ${user.correo}</p>
		</div>
		<div class="media-right align-self-center">
			<div class="row">
					<a href="#" class="btn btn-primary edit" onclick="verDetalle('${user.correo}')"><i class="fas fa-search edit"></i></a>
			</div>
			<div class="row">
					<a href="#" class="btn btn-primary mt-2" onclick="editarUsuario('${user.correo}')" data-toggle="modal" data-target="#updateDataModal"><i class="fas fa-pencil-alt edit"></i></a>
			</div>
			<div class="row">
					<a href="#" class="btn btn-primary mt-2" onclick="eliminarUsuario('${user.correo}')" data-toggle="modal" data-target="#deleteModal"><i class="fas fa-trash-alt edit"></i></a>
			</div>
		</div>
  </div>
	`;
}
function getPaginationBar(n){
	let str = `<li class="page-item" id="previousPage"><a class="page-link" href="#">&laquo;</a></li>`;
	for(let i = 0; i < n; i++){
		str += `<li class="page-item"><a class="page-link" href="#" onclick="selectPage(${i})">${i+1}</a></li>`;
	}
	str += `<li class="page-item" id="nextPage"><a class="page-link" href="#">&raquo;</a></li>`;
	return str;
}
function getSex(){
	const rbs = document.querySelectorAll('input[name="sexo"]');
	for (const rb of rbs) {
		if (rb.checked) {
			return rb.value;
		}
	}
}

function verDetalle(email){
	getUser(email);
	log(`User: ${selectedUser.nombre}`);
	window.location.href = `/detalle.html?user=${email.trim('"')}`;
}
function editarUsuario(email){
	getUser(email);
	log(`User: ${selectedUser.nombre}`);
	updateName.value = selectedUser.nombre;
	updateLastName.value = selectedUser.apellido;
	updateEmail.value = selectedUser.correo;
	updateDate.value = selectedUser.fecha;
	if(selectedUser.sexo === 'H'){
		document.getElementById('Hombre').checked = true;
	}else document.getElementById('Mujer').checked = true;
	updateURL.value = selectedUser.url;
}
function eliminarUsuario(email){
	getUser(email);
	log(`User: ${selectedUser.nombre}`);
	let div = document.getElementById('deleteModaldiv');
	div.innerHTML = `<h3>Cuidado!!</h3><p>Estas por eliminar el usuario: ${selectedUser.nombre}</p>`;
}

function deleteUser(email){
	var xhttp = new XMLHttpRequest();
	
	xhttp.onreadystatechange = function() {
		if (this.readyState == 4 && this.status == 200) {
			getUsers();
			updateFilter();
			alert("Usuario eliminado");
		}
	};

	xhttp.open("DELETE", `https://users-dasw.herokuapp.com/api/users/${email}`, false);
	xhttp.setRequestHeader("Content-Type", "application/json");
	xhttp.setRequestHeader("x-admin", sessionStorage.token);
	xhttp.setRequestHeader("x-auth", sessionStorage.userToken);
	xhttp.send();
}

function getUser(email){
	var xhttp = new XMLHttpRequest();
	
	xhttp.onreadystatechange = function() {
		if (this.readyState == 4 && this.status == 200) {
			selectedUser = JSON.parse(this.responseText);
		}
		log(this.responseText);
	};

	xhttp.open("GET", `https://users-dasw.herokuapp.com/api/users/${email}`, false);
	xhttp.setRequestHeader("Content-Type", "application/json");
	xhttp.setRequestHeader("x-admin", sessionStorage.token);
	xhttp.setRequestHeader("x-auth", sessionStorage.userToken);
	xhttp.send();
}

function updateFilter(){
	filteredUsers = searchUser.slice(page*2, page*2+2);
	nPages = Math.ceil(searchUser.length / 2);
	updateUserHTMLList(filteredUsers);
}

function getUsers(){
	var xhttp = new XMLHttpRequest();
	
	xhttp.onreadystatechange = function() {
		if (this.readyState == 4 && this.status == 200) {
			users = JSON.parse(this.responseText);
			nUsers = users.length;
			updateFilter();
		}
		log(this.responseText);
	};

	xhttp.open("GET", "https://users-dasw.herokuapp.com/api/users", false);
	xhttp.setRequestHeader("Content-Type", "application/json");
	xhttp.setRequestHeader("x-admin", sessionStorage.token);
	xhttp.setRequestHeader("x-auth", sessionStorage.userToken);
	xhttp.send();
}

function updateUserHTMLList(userArr){
	let userList = document.getElementById("lista");
	userList.innerHTML = "";

	for(let i = 0; i < userArr.length; i++){
		userList.innerHTML += userToHTML(userArr[i]);
	}

	paginationBar.innerHTML = getPaginationBar(nPages);

	prevButton = document.getElementById('previousPage');
	nextButton = document.getElementById('nextPage');
	checkPage();

	prevButton.addEventListener('click', e => {
		if(page >= 1) page -= 1; 		
		checkPage();
		updateFilter();
	});
	
	nextButton.addEventListener('click', e => {
		if(page < nPages - 1) page += 1;
		checkPage();
		updateFilter();
	});	
}

function selectPage(p){
	page = p;
	checkPage();
	updateFilter();
}

function checkPage(){
	if(page === nPages-1) nextButton.classList.add("disabled");
	else nextButton.classList.remove("disabled");

	if(page === 0) prevButton.classList.add("disabled");
	else prevButton.classList.remove("disabled");
}

userSearch.addEventListener('change', (e) => {
	searchUser = users.filter((element) => {
		return element.nombre.includes(userSearch.value);
	});
	page = 0;
	log(page);
	updateFilter();
});

getUsers();
searchUser = users;
updateFilter();

