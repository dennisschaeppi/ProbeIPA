<%@page import="App.Benutzer"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
 <%
 	//Variablen für die Benutzereingaben
 	String benutzername = request.getParameter("benutzername");
 	String vorname = request.getParameter("vorname");
 	String nachname = request.getParameter("nachname");
 	String email = request.getParameter("email");
 	String passwort = request.getParameter("passwort");
 	String passwort_r = request.getParameter("passwort_r");
 	String profilbildurl="";
 	
 	
 	//Neues Benutzer-Objekt erstellen
 	Benutzer b = new Benutzer();
 	//Eigabedaten überprüfen und dann in DB eintragen
 	if(benutzername!=null && vorname!=null && nachname!=null && email!=null && passwort!=null && passwort_r!=null){
 		if(benutzername!="" && vorname!="" && nachname!="" && email!="" && passwort!="" && passwort_r!=""){
 	 		b.registrieren(benutzername, passwort, email, vorname, nachname, profilbildurl);
 	 		response.sendRedirect("login.jsp");//Weiterleitung zum Login
 	 	}	
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
	<div class="title"><h1>Registrieren</h1></div>
	<div class="content">
		<form method="post">
			<input type="text" name="benutzername" maxlength="20" placeholder="Benutzername"><br>
			<input type="text" name="vorname" maxlength="30" placeholder="Vorname"><br>
			<input type="text" name="nachname" maxlength="30" placeholder="Nachname"><br>
			<input type="email" name="email" maxlength="50" placeholder="Email"><br>
			<input type="password" name="passwort" maxlength="30" placeholder="Passwort"><br>
			<input type="password"n name="passwort_r" maxlength="30" placeholder="Passwort wiederholen"><br>
			<input type="file"><br>
			<input type="submit" value="Senden">
		</form>
	</div>
	
</body>
</html>