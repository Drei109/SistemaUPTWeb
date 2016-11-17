<%-- 
    Document   : cerrarSession
    Created on : 08-nov-2016, 17:04:00
    Author     : Drei
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    session.setAttribute("codDocente", null);
    session.setAttribute("nivelUsuario", null);
    session.setAttribute("estadoUsuario", null);
    session.setAttribute("nombreDocente", null);
    response.sendRedirect("login.jsp");
%>