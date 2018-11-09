<%@page import="App.Login"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%
//Session beenden und alle Variablen löschen
request.getSession().invalidate();
request.getSession().setAttribute("id", null);
request.getSession().setAttribute("rolle", null);

if(session!=null){
	session = null;
	
}

//Zurück zum Login
response.sendRedirect("login.jsp");

%>