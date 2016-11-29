<%-- 
    Document   : header
    Created on : 13-nov-2016, 19:53:01
    Author     : Drei
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        
<!--        <link href="css/bootstrap-theme.min.css" rel="stylesheet" type="text/css"/>-->
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <link href="../css/bootstrap.min.css" rel="stylesheet" type="text/css"/>
        <link href="../css/styles.css" rel="stylesheet" type="text/css"/>
        <script src="../js/jquery-3.1.1.min.js" type="text/javascript"></script>
        <script src="../js/bootstrap.min.js" type="text/javascript"></script>
    </head>
    <body>
        <div class="navbar navbar-default navbar-fixed-top shadow">
            <div class="container">
                <div class="navbar-header">
                    <button type="button" class="navbar-toggle" data-toggle="collapse" data-target=".navbar-collapse">
                        <span class="icon-bar"></span>
                        <span class="icon-bar"></span>
                        <span class="icon-bar"></span>                    
                    </button>
<!--                    <div class="logo navbar-brand"></div>-->
<!--                    <img src="img/logo.png" class="navbar-brand logo">-->
                    <a href="#" class="navbar-brand brand"> Sistema Informes UPT</a>
                </div>  
                <div class="navbar-collapse collapse">
                    <ul class="nav navbar-nav">
                        <li class="dropdown">
                            <a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" area-hashpopup="false" area-expanded="false">
                                Informes<span class="caret"></span>
                            </a>
                            <ul class="dropdown-menu">
                                <li><a href="../reportesFaltantes.jsp">Ver informes restantes</a></li>
                            </ul>                    
                        </li>
                        <li class="dropdown">
                            <a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" area-hashpopup="true" area-expanded="false">
                                Consultas<span class="caret"></span>
                            </a>
                            <ul class="dropdown-menu">
                                <li><a href="../consultaPruebaEntrada.jsp">Consulta Informe de prueba entrada</a></li>
                                <li><a href="#">Consulta Informe final del curso </a></li>
                                <li><a href="#">Consulta Informe final del curso - doc </a></li>
                                <li><a href="#">Consulta Informe de portafolio</a></li>
                            </ul>
                        </li>
                        <li class="dropdown">
                            <a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" area-hashpopup="false" area-expanded="false">
                                Imprimir<span class="caret"></span>
                            </a>
                            <ul class="dropdown-menu">
                                <li><a href="../imprimirReporte.jsp">Imprimir informes aprobados</a></li>
                            </ul>                    
                        </li>
                        <li class="dropdown">
                            <a href="#" class="">
                                Ayuda
                            </a>                  
                        </li>
                    </ul>

                    <ul class="nav navbar-nav navbar-right">
                    <%
                        if (session.getAttribute("codDocente") != null)
                        {
                    %>   
                        <li><a href="#" id="loginlink">Bienvenido: <%=session.getAttribute("nombreDocente")%></a></li>
                        <li><a href="../cerrarSession.jsp" id="loginlink">Cerrar sesión</a></li>
                    <%          
                        }else{ %>
                        <li><a href="../login.jsp" id="loginlink">No ha iniciado sesión</a></li>
                    <%
                        }
                    %>                    
                    </ul>
                </div>
            </div>
        </div>

