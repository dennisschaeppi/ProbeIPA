<%@page import="java.util.Enumeration"%>
<%@page import="java.util.Map"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.util.HashMap"%>
<%@page import="App.Beitrag"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="Database.Datenbank"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    
<%
	//Überprüfen ob eingeloggt
	if(session.getAttribute("id").toString().isEmpty()){
		response.sendRedirect("login.jsp");
	}

	//Datenbankverbindung herstellen
	Datenbank db = new Datenbank();
	Connection con = db.getConnect();
	
	//Benutzer-ID gesetzt
	int benutzer = Integer.parseInt(session.getAttribute("id").toString());
	
	//Variablen für Datenbankabfragen
	PreparedStatement ps;
	PreparedStatement psCom;
	ResultSet rs;
	ResultSet rsCom;
	
	//Liste der vorhandenen Beiträge
	HashMap<Integer, Beitrag> beitraege = new HashMap<Integer, Beitrag>();
	
	//Lade alle Beiträge
	ps = con.prepareStatement("CALL loadBeitraege()");
	rs = ps.executeQuery();
	
	while(rs.next()){
		//Erstelle ein neues Objekt für Beitrag
		Beitrag beitrag = new Beitrag(db.getConnect());
		//Die ermittelten Informationen in das Objekt speichern
		beitrag.setBenutzername(rs.getString("benutzername"));
		beitrag.setTitel(rs.getString("titel"));
		beitrag.setBeschreibung(rs.getString("beschreibung"));
		beitrag.setDatum(rs.getDate("datum"));
		beitrag.setId(rs.getInt("id_beitrag"));
		
		//Schreibe den Beitrag in die Liste
		beitraege.put(beitrag.getId(), beitrag);
	}
	
	//Ermitteln aller Formular-Elemente
	Enumeration<String> en = request.getParameterNames();
	while(en.hasMoreElements()){
		
		String parameter = en.nextElement();
		
		//Wenn Kommentar abgesendet dann in DB schreiben
		if(parameter.contains("comment-writer")){
			int beitrag = Integer.parseInt(parameter.split("-")[2]);
			Beitrag b = new Beitrag(db.getConnect());
			
			b.schreibeKommentar(beitrag, benutzer, request.getParameter(parameter));
		}
	}
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<link rel="stylesheet" type="text/css" href="style/style.css">
	<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
	<title>Beiträge</title>
</head>
<body>
	<div class="title"><h1>Beiträge</h1></div>
	
	<div class="menu">
		<p class="logged">Benutzer-ID: <%=session.getAttribute("id") %></p>
		<p><a href="neuerbeitrag.jsp">Neuer Beitrag</a><p>
		<p><a href="meinprofil.jsp">Mein Profil</a><p>
		<p><a href="beitrag.jsp">Beiträge</a><p>
		<p><a href="logout.jsp">Logout</a><p>
	</div>
	
	
	<% for(Map.Entry<Integer, Beitrag> hmb : beitraege.entrySet()){
			int id = hmb.getKey();
			Beitrag b = hmb.getValue();
	%>
			<div class="container">
				<div class="infohead">
					<p>Von: <%=b.getBenutzername() %>	Gepostet am:<%=b.getDatum() %></p>
					<!--  <p><a>Melden</a><a>Löschen</a></p>-->
				</div>
				<div class="content-beitrag">
					<h3><%=b.getTitel() %></h3>
					<p>
						<%=b.getBeschreibung() %>
					</p>
				</div>
				<!--  <div class="gefaellt">
					<p>Gefälllt</p>
				</div>-->
				<div class="comment">
					<div class="write-comment">
						<form method="post">
							<input name="comment-writer-<%=b.getId() %>" type="text" placeholder="Kommentar schreiben">
							<input type="submit" value="Senden">
						</form>
					</div>
					<div class="comment-container">
						<%
							psCom = con.prepareStatement("CALL loadKommentare(?)");
							psCom.setInt(1, b.getId());
							rsCom = psCom.executeQuery();
							
							while(rsCom.next()){
						%>
								<p>Kommentar von: <%=rsCom.getString("benutzername") %>
									<br>
									<%=rsCom.getString("text") %>
								</p>
						<%
							}
						%>
						
					</div>
					
				</div>
			</div>	
		
	<% } %>
</body>
</html>