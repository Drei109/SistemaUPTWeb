<%-- 
    Document   : reportesFaltantes
    Created on : 14-nov-2016, 20:52:58
    Author     : Drei
--%>
<%@page import="java.sql.ResultSet"%>
<%@page import="Entidad.ClsEntidadPruebaCursosFaltantes"%>
<%@page import="java.util.Iterator"%>
<%@page import="java.util.ArrayList"%>
<%@page import="Negocio.ClsNegocioPruebaEntrada"%>
<%@include file="header.jsp" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>


<%
    String id_PruebaEntrada = request.getParameter("id_PruebaEntrada");
%>
<head>
    <title>Imprimir Reportes</title>
</head>
<body class="background-gray">
        <div class="container body-padding">
            <div class="row">
                <form action="" method="post" class="form-reporte shadow">
                    <fieldset>
                        <div class="form-group">
                            <h2>Imprimir Reportes</h2>
                        </div>
                        <div class="form-group">
                            <a href="#documento"><input type="submit" class="btn btn-default" name="pdf" value="Ver en PDF"></a>
                            <input type="submit" class="btn btn-default" name="html" value="Ver en HTML">
                            <input type="submit" class="btn btn-default" name="xls" value="Descargar en Excel">
                        </div>
                    </fieldset>
                </form>
            </div>
        </div>
        <%
                String tipo = "pdf";
                if (request.getParameter("html") != null) {
                    tipo = "html";
                } else if (request.getParameter("xls") != null) {
                    tipo = "xls";
                }
                
                if(tipo.equals("pdf")){
                    %>
                    <div class="container full-height" id="documento">
                        <div class="row form-reporte shadow full-height">
                            <embed class="reporte" src="RptInformePruebaEntrada.jsp?doctype=pdf&id_PruebaEntrada=<%=id_PruebaEntrada%>" width="100%" height="100%" type='application/pdf'>
                        </div>
                    </div>
                    <%
                }
                else if(tipo.equals("html")){
                    %>
                    <div class="container full-height" id="documento">
                        <div class="row form-reporte shadow full-height">
                            <object width="100%" height="100%" class="container" type="text/html" data="RptInformePruebaEntrada.jsp?doctype=html&id_PruebaEntrada=<%=id_PruebaEntrada%>">
                            <p>backup content</p>
                            </object>
                        </div>
                    </div>
                    <%
                }
                else if(tipo.equals("xls")){
                    %>
                    <div class="container">
                        <embed class="reporte" src="RptInformePruebaEntrada.jsp?doctype=xls&id_PruebaEntrada=<%=id_PruebaEntrada%>" width="100%" height="100%" type='text/html'>
                    </div>
                    <%
                }
            %>
    </body>
</html>

