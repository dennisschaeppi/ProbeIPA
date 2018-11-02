<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<link rel="stylesheet" type="text/css" href="style/style.css">
	<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
	<title>Login</title>
</head>
<body>
	<h1>Registrieren</h1>
	<form method="post">
		<table>
		
			<tr>
				<td><span>Benutzername:</span></td>
				<td><input type="text" maxlength="20" placeholder="Benutzername"></td>
			</tr>
			<tr>
				<td><span>Vorname:</span></td>
				<td><input type="text" maxlength="30" placeholder="Vorname"></td>
			</tr>
			<tr>
				<td><span>Nachname:</span></td>
				<td><input type="text" maxlength="30" placeholder="Nachname"></td>
			</tr>
			<tr>
				<td><span>Email:</span></td>
				<td><input type="email" maxlength="50" placeholder="Email"></td>
			</tr>
			<tr>
				<td><span>Profilbild:</span></td>
				<td><img src="xyz"><br><input type="file" value="Profilbild ändern"></td>
			</tr>
		</table>
		<input type="submit" value="Senden">
	</form>
		
		
		
		
		
		
		
	
</body>
</html>