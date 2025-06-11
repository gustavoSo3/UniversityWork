function log(value){
	console.log("GS:", value);
}

function getAlumToken(email){
	var xhttp = new XMLHttpRequest();

	xhttp.onreadystatechange = function() {
    if (this.readyState == 4 && this.status == 200) {
      sessionStorage.token = JSON.parse(this.responseText).token;
    }
		log(this.responseText);
  };

	xhttp.open("GET", "https://users-dasw.herokuapp.com/api/mytoken", false);
	xhttp.setRequestHeader("Content-Type", "application/json");
	xhttp.setRequestHeader("x-email", email);
	xhttp.send();

}
getAlumToken("is722224@iteso.mx");
