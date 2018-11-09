<%@page import="Database.Datenbank"%>
<%@page import="App.Beitrag"%>
<%@page import="java.util.Calendar"%>
<%@page import="java.util.GregorianCalendar"%>
<%@page import="java.sql.Date"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%
	//�berpr�fen ob eingeloggt
	if(session.getAttribute("id").toString().isEmpty()){
		response.sendRedirect("login.jsp");
	}
	
	
	Datenbank db = new Datenbank();
	
	//Variablen f�r den neuen Beitrag
	String titel = request.getParameter("titel");
	String beschreibung = request.getParameter("beschreibung");
	
	//Aktuelles Datum ermitteln
	Calendar cal = new GregorianCalendar();
	Date dt = new Date(cal.getTime().getTime());
	
	//Benutzer-ID gesetzt
	int benutzer = Integer.parseInt(session.getAttribute("id").toString());
	
	//Neues Objekt f�r neuen Beitrag erstellen
	Beitrag b = new Beitrag(db.getConnect());
	
	//Felder �berpr�fen und Informationen in Datenbank schreiben (Beitrag posten)
	if(titel!=null && beschreibung!=null){
		if(titel!="" && beschreibung!=""){
			b.neu(titel, beschreibung, dt, benutzer);
			response.sendRedirect("beitrag.jsp");
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
	<div class="title"><h1>Neuer Beitrag</h1></div>
	<div class="content">
		<form method="post">
			<div class="container">
				<input name="titel" type="text" placeholder="Titel"><br>
				<textarea name="beschreibung"></textarea><br>
				<input type="Submit" value="Erstellen">
			</div>
		</form>
	</div>
	
</body>
</html>