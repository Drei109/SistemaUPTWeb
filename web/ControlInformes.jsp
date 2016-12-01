<%-- 
    Document   : reportesFaltantes
    Created on : 14-nov-2016, 20:52:58
    Author     : Drei
--%>
<%@page import="Negocio.ClsNegocioInformeFinalCurso"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="Entidad.ClsEntidadPruebaCursosFaltantes"%>
<%@page import="java.util.Iterator"%>
<%@page import="java.util.ArrayList"%>
<%@page import="Negocio.ClsNegocioPruebaEntrada"%>
<%@include file="header.jsp" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>


<%
    String codDocente = String.valueOf(session.getAttribute("codDocente"));
    String nivelUsuario = String.valueOf(session.getAttribute("nivelUsuario"));    
    
    ResultSet rs = null;
    
    ClsNegocioPruebaEntrada negPruebaEntrada = new ClsNegocioPruebaEntrada();
        
    String criterio = request.getParameter("criterio");
    String busqueda = request.getParameter("busqueda");
    
    String mensaje = "";
    
    ArrayList<ClsNegocioPruebaEntrada> dato = null;
%>
<head>
    
    
    <title>Control de Informes</title>
</head>
<body class="background-gray">
        <div class="container body-padding">
            <div class="row">
                <form class="form-reporte form-consulta shadow">
                    <fieldset>
                        <div class="form-group">
                            <h2>Control de Informes</h2>
                        </div>
                        <div class="form-group">
                            <label for="select" class="control-label">Tipo Informe</label>
                            <div class="">
                              <select class="form-control" id="select" name="Informe">
                                  <option value="Prueba Entrada">Prueba de Entrada</option>
                                  <option value="Informe Final Curso">Informe Final del Curso</option>
                                  <option value="Portafolio">Portafolio</option>
                              </select>
                            </div>
                        </div>
                        
                        <div class="form-group">
                            <input class="btn btn-info" type="submit" name="Buscar" value="Buscar">
                        </div>
                              
                        <div class="form-group">
                            <div class="table-responsive">
                                <table class="table table-striped table-prueba-entrada" border="1" id="tabla">
                                    <thead>
                                        <tr>                                               
                                            <th>ID</th>
                                            <th>Cod Doc</th>
                                            <th>Nombre Docente</th>
                                            <th>Cod Curso</th>
                                            <th>Curso</th>
                                            <th>Fecha</th>
                                            <th>Estado</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <% 
                                            String tipoInforme = request.getParameter("Informe");
                                            if (request.getParameter("Buscar")!=null) {
                                                tipoInforme = request.getParameter("Informe");
                                                ClsNegocioPruebaEntrada datos = new ClsNegocioPruebaEntrada();

                                                dato = datos.verInformesTotales(tipoInforme);

                                                Iterator iterator = dato.iterator();

                                                while (iterator.hasNext()) {
                                                    ClsEntidadPruebaCursosFaltantes objenti = new ClsEntidadPruebaCursosFaltantes();

                                                    objenti = (ClsEntidadPruebaCursosFaltantes) iterator.next();
                                                    %>
                                                    <tr>
                                                            <td> <%= objenti.getCargaAcademica()%> </td>
                                                            <td> <%= objenti.getCodigoDocente()%> </td>
                                                            <td> <%= objenti.getNombreDocente()%> </td>
                                                            <td> <%= objenti.getIdCurso()%> </td>
                                                            <td> <%= objenti.getNombreCurso()%> </td>
                                                            <%
                                                                if(objenti.getFechaPrueba()!=null){
                                                                %>
                                                                    <td> <%= objenti.getFechaPrueba()%> </td>
                                                                <%
                                                                }
                                                                else{
                                                                %>
                                                                    <td>-</td>
                                                                <%
                                                                }
                                                            %>
                                                            <%
                                                                if(objenti.getEstadoPrueba().equals("SIN COMPLETAR")){
                                                                    %>
                                                                    <td class="btn-danger"> <%= objenti.getEstadoPrueba()%> </td>
                                                                    <%
                                                                }
                                                                else if(objenti.getEstadoPrueba().equals("FALTA APROBAR")){
                                                                    %>
                                                                    <td class="btn-warning"> <%= objenti.getEstadoPrueba()%> </td>
                                                                    <%
                                                                }

                                                                else{
                                                                    %>
                                                                    <td class="btn-success"> <%= objenti.getEstadoPrueba()%> </td>
                                                                    <%
                                                                }
                                                            %>                                                                                                                        
                                                    <%
                                                   
                                                }
                                                datos.conexion.close();
                                            }                                            
                                        %>
                                    </tbody>                                    
                                </table>
                            </div>
                            <a href="ReporteControlInformes.jsp?tipoInforme=<%=tipoInforme%>&tipoGrafico=Pie" class="btn btn-info" target="Pie">Ver Informe (Pie)</a>
                            <a href="ReporteControlInformes.jsp?tipoInforme=<%=tipoInforme%>&tipoGrafico=Barras" class="btn btn-info" target="Barras">Ver Informe (Barras)</a>
                        </div>
                        <div class="form-group">
                            <p><%=mensaje%></p>
                        </div>
                    </fieldset>
                </form>
            </div>
        </div>  
                        
        <script>
            $(document).ready(function() {
                $('#tabla').DataTable();
            } );
        </script>
        
    </body>
</html>

