<%@page import="java.util.Enumeration"%>
<%@page import="App.Benutzer"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>
<%@page import="Database.Datenbank"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    
<%
	if(session.getAttribute("rolle").toString().isEmpty()){
		response.sendRedirect("login.jsp");
	}

	Datenbank db = new Datenbank();
	Connection con = db.getConnect();
	PreparedStatement ps;
	ResultSet rs;
	Benutzer profil = new Benutzer();
	
	Integer benutzer = Integer.parseInt(session.getAttribute("id").toString());
	
	ps = con.prepareStatement("CALL loadBenutzer(?)");
	ps.setString(1, benutzer.toString());
	rs = ps.executeQuery();
	
	if(rs.next()){
		profil.setBenutzername(rs.getString("benutzername"));
		profil.setVorname(rs.getString("vorname"));
		profil.setNachname(rs.getString("nachname"));
		profil.setEmail(rs.getString("email"));
	}
	
	String benutzername = "";
	
	Enumeration<String> en = request.getParameterNames();
	
	while(en.hasMoreElements()){
		String parameter = en.nextElement();
		if(parameter.equals("aendern")){
			System.out.println("ändern");
			profil.datenAendern(benutzer, request.getParameter("benutzername"), request.getParameter("vorname"), request.getParameter("nachname"), request.getParameter("email"));
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
	<div class="title"><h1>Mein Profil</h1></div>
	<div class="menu">
		<p class="logged">Benutzer-ID: <%=session.getAttribute("id") %></p>
		<p><a href="neuerbeitrag.jsp">Neuer Beitrag</a><p>
		<p><a href="meinprofil.jsp">Mein Profil</a><p>
		<p><a href="beitrag.jsp">Beiträge</a><p>
		<p><a href="logout.jsp">Logout</a><p>
	</div>
	<div class="content">
		<form method="post">
			<table>
			
				<tr>
					<td><span>Benutzername:</span></td>
					<td><input name="benutzername" type="text" maxlength="20" placeholder="Benutzername" value="<%=profil.getBenutzername() %>"></td>
				</tr>
				<tr>
					<td><span>Vorname:</span></td>
					<td><input name="vorname" type="text" maxlength="30" placeholder="Vorname" value="<%=profil.getVorname() %>"></td>
				</tr>
				<tr>
					<td><span>Nachname:</span></td>
					<td><input name="nachname" type="text" maxlength="30" placeholder="Nachname" value="<%=profil.getNachname() %>"></td>
				</tr>
				<tr>
					<td><span>Email:</span></td>
					<td><input name="email" type="email" maxlength="50" placeholder="Email" value="<%=profil.getEmail() %>"></td>
				</tr>
				<tr>
					<td><span>Profilbild:</span></td>
					<td><img src=""><br><input type="file" value="Profilbild ändern"></td>
				</tr>
			</table>
			<input name="aendern" type="submit" value="Speichern">
		</form>
	</div>
	
		
		
		
		
		
		
		
	
</body>
</html>