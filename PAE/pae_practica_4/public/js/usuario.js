function userToHTML(user) {
	return `
	<div class="media col-8 mt-2">
		<div class="media-left align-self-center mr-3">
			<img class="rounded-circle" src="${user.url}">
		</div>
		<div class="media-body">
			<h4> ${user.nombre + " " + user.apellido}</h4>
			<p>Correo: ${user.correo}</p>
			<p>Sexo: ${user.sexo}</p>
			<p>Fecha: ${user.fecha}</p>
		</div>
		<div class="media-rigth">
    	<button class="btn btn-primary" onclick="returnToUsers()">Regresar</button>
		</div>
  </div>
	`;
}
function returnToUsers(){
	window.location.href = "/consulta.html";
}

function getParameterByName(name, url = window.location.href) {
	name = name.replace(/[\[\]]/g, '\\$&');
	var regex = new RegExp('[?&]' + name + '(=([^&#]*)|&|#|$)'),results = regex.exec(url);
	if (!results) return null;
	if (!results[2]) return '';
	return decodeURIComponent(results[2].replace(/\+/g, ' '));
}

let main = document.getElementById('main');

let userEmail = getParameterByName('user');
let user;

var xhttp = new XMLHttpRequest();
	
xhttp.onreadystatechange = function() {
	if (this.readyState == 4 && this.status == 200) {
		user = JSON.parse(this.responseText);
	}
};

xhttp.open("GET", `https://users-dasw.herokuapp.com/api/users/${userEmail}`, false);
xhttp.setRequestHeader("Content-Type", "application/json");
xhttp.setRequestHeader("x-admin", sessionStorage.token);
xhttp.setRequestHeader("x-auth", sessionStorage.userToken);
xhttp.send();


main.innerHTML = userToHTML(user);