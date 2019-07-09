<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@page import="App.Login"%>
<%

//Anmeldeinformationen in Parameter speichern
String benutzername = request.getParameter("benutzername");
String passwort = request.getParameter("passwort");

//Rückmeldung für das Login
String message = "Anmelden";

//Anmeldeinformationen überpfrüfen
if(benutzername != null && passwort != null && benutzername!= "" && passwort != ""){
	Login login = new Login(benutzername, passwort);
	//Wenn Login erfolgreich, dann Session setzten und weiterleiten
	if(login.getLogged()){
		HttpSession s = request.getSession(true);
		session.setAttribute("id", login.getId());
		session.setAttribute("rolle", login.getRolle());
		response.sendRedirect("beitrag.jsp");
	}
}else{
	message="Benutzername und Passwort eingeben";
}



%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<link rel="stylesheet" type="text/css" href="style/style.css">
	<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
	<title>Login</title>
</head>
<body>
	<div class="container-login">
		<div class="title"><h1>Login</h1></div>
		<div class="content">
			<form method="post">
				<input type="text" name="benutzername" maxlength="30"><br>
				<input type="password" name="passwort"><br>
				<input type="submit" value="Login">
				<p><%=message %></p>
			</form>
		</div>
	</div>
	
	
</body>
</html>