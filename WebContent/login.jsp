<%@page import="App.Login"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%
String benutzername = request.getParameter("benutzername");
String passwort = request.getParameter("passwort");
String message = "Anmelden";
System.out.println(benutzername + "--- "+passwort);
if(benutzername != null && passwort != null && benutzername!= "" && passwort != ""){
	Login login = new Login(benutzername, passwort);
	if(login.getLogged()){
		message="YEY";
		response.sendRedirect("beitrag.jsp");
	}else{
		
	}
}else{
	message="Benutzername";
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
	<h1>Login</h1>
	<form method="post">
		<input type="text" name="benutzername" maxlength="30"><br>
		<input type="password" name="passwort"><br>
		<input type="submit" value="Login">
		<p><%=message %></p>
	</form>
</body>
</html>