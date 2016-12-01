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
    ArrayList<ClsNegocioPruebaEntrada> dato = null;
    String nivelUsuario = String.valueOf(session.getAttribute("nivelUsuario"));  
    String codDocente = String.valueOf(session.getAttribute("codDocente"));
    ResultSet rs = null;
    
    String criterio = "";
    String busqueda = "";
    
    String mensaje = "";
    
    ArrayList<String> DatosPruebaEntradaUsuario = new ArrayList<String>();    
    ArrayList<String> DatosPruebaEntradaAdministrador = new ArrayList<String>();  
    
//    ArrayList<String> DatosInformeFinalUsuario = new ArrayList<String>();    
//    ArrayList<String> DatosInformeFinalAdministrador = new ArrayList<String>();

    String tipoInforme = "";
    
    if(request.getParameter("Listar")!=null){
        
        tipoInforme = String.valueOf(request.getParameter("tipoReporte"));
        
        switch(tipoInforme){
            case "Entrada":
                ClsNegocioPruebaEntrada negPruebaEntrada = new ClsNegocioPruebaEntrada();

                criterio = request.getParameter("criterio");
                busqueda = request.getParameter("busqueda");

                switch(nivelUsuario){
                case "Usuario":
                    try {
                    rs  =negPruebaEntrada.ConsultaInformeUsuario(criterio, busqueda,codDocente);

                    boolean encuentra = false;
                    
                    String Campo[] = new String[5];
                    
                    while (rs.next()) {
                        DatosPruebaEntradaUsuario.add((String) rs.getString(1)); 
                        DatosPruebaEntradaUsuario.add((String) rs.getString(2)); 
                        DatosPruebaEntradaUsuario.add((String) rs.getString(3)); 
                        DatosPruebaEntradaUsuario.add((String) rs.getString(4)); 
                        DatosPruebaEntradaUsuario.add((String) rs.getString(5)); 
                        
                        encuentra = true;
                    }

                    if (encuentra == false) {
                        mensaje = "No se encuentra.";
                    }
                    rs.close();
                    negPruebaEntrada.conexion.close();
                    } catch (Exception ex) {
                    }
                    break;
                case "Supervisor":            
                case "Administrador":
                    try {
                    rs  =negPruebaEntrada.ConsultaInformeAdministrador(criterio, busqueda);

                    boolean encuentra = false;
                    String Campo[] = new String[8];
                    
                    while (rs.next()) {
                        DatosPruebaEntradaAdministrador.add(String.valueOf(rs.getString(1))); 
                        DatosPruebaEntradaAdministrador.add(String.valueOf(rs.getString(2))); 
                        DatosPruebaEntradaAdministrador.add(String.valueOf(rs.getString(3))); 
                        DatosPruebaEntradaAdministrador.add(String.valueOf(rs.getString(4))); 
                        DatosPruebaEntradaAdministrador.add(String.valueOf(rs.getString(5))); 
                        DatosPruebaEntradaAdministrador.add(String.valueOf(rs.getString(6))); 
                        DatosPruebaEntradaAdministrador.add(String.valueOf(rs.getString(7))); 
                        DatosPruebaEntradaAdministrador.add(String.valueOf(rs.getString(8))); 
                        
                        
                        
                        encuentra = true;
                    }

                    if (encuentra == false) {
                        mensaje = "No se encuentra.";
                    }
                    rs.close();
                    negPruebaEntrada.conexion.close();
                    } catch (Exception ex) {
                    }
                    break;
                }      
                break;
                
            case "Final":
                ClsNegocioInformeFinalCurso negInformeFinalCurso = new ClsNegocioInformeFinalCurso();

                criterio = request.getParameter("criterio");
                busqueda = request.getParameter("busqueda");

                switch(nivelUsuario){
                case "Usuario":                    
                    try {
                    rs  =negInformeFinalCurso.ConsultaInformeUsuario(criterio, busqueda,codDocente);

                    boolean encuentra = false;
                    
                    String Campo[] = new String[5];
                    
                    while (rs.next()) {
                        DatosPruebaEntradaUsuario.add((String) rs.getString(1)); 
                        DatosPruebaEntradaUsuario.add((String) rs.getString(2)); 
                        DatosPruebaEntradaUsuario.add((String) rs.getString(3)); 
                        DatosPruebaEntradaUsuario.add((String) rs.getString(4)); 
                        DatosPruebaEntradaUsuario.add((String) rs.getString(5)); 
                        
                        encuentra = true;
                    }

                    if (encuentra == false) {
                        mensaje = "No se encuentra.";
                    }
                    rs.close();
                    negInformeFinalCurso.conexion.close();
                    } catch (Exception ex) {
                    }
                    break;
                case "Supervisor":            
                case "Administrador":
                    try {
                        rs  =negInformeFinalCurso.ConsultaInformeAdministrador(criterio, busqueda);

                        boolean encuentra = false;
                        String Campo[] = new String[8];

                        while (rs.next()) {
                            DatosPruebaEntradaAdministrador.add(String.valueOf(rs.getString(1))); 
                            DatosPruebaEntradaAdministrador.add(String.valueOf(rs.getString(2))); 
                            DatosPruebaEntradaAdministrador.add(String.valueOf(rs.getString(3))); 
                            DatosPruebaEntradaAdministrador.add(String.valueOf(rs.getString(4))); 
                            DatosPruebaEntradaAdministrador.add(String.valueOf(rs.getString(5))); 
                            DatosPruebaEntradaAdministrador.add(String.valueOf(rs.getString(6))); 
                            DatosPruebaEntradaAdministrador.add(String.valueOf(rs.getString(7))); 
                            DatosPruebaEntradaAdministrador.add(String.valueOf(rs.getString(8)));
                            encuentra = true;
                        }

                        if (encuentra == false) {
                            mensaje = "No se encuentra.";
                        }
                        rs.close();
                        negInformeFinalCurso.conexion.close();
                    } catch (Exception ex) {
                    }
                    break;
                }      
                break;
        }
    }

%>
<head>
    <title>Imprimir Reportes</title>
</head>
<body class="background-gray">
        <div class="container body-padding">
            <div class="row">
                <form class="form-reporte shadow">
                    <fieldset>
                        <div class="form-group">
                            <h2>Informes Faltantes</h2>
                        </div>
                        <div class="form-group">
                            <label for="select" class="control-label">Tipo de reporte</label>
                            <div class="">
                              <select class="form-control" id="select" name="tipoReporte">
                                <option value="Entrada">Informe Prueba de Entrada</option>
                                <option value="Final">Informe Final</option>
                                <option value="Portafolio">Informe de Portafolio</option>
                              </select>
                            </div>
                        </div>
                        
                        <div class="form-group">
                            <label for="select" class="control-label">Criterio</label>
                            <div class="">
                              <select class="form-control" id="select" name="criterio">
                                  <%
                                    if (nivelUsuario.equals("Usuario")) {
                                        %>
                                        <option value="Todos">Todos</option>
                                        <option value="Código Curso">Código Curso</option>
                                        <option value="Nombre Curso">Nombre Curso</option>
                                        <option value="Fecha">Fecha</option>
                                        <% 
                                    }
                                    else if(nivelUsuario.equals("Supervisor") || nivelUsuario.equals("Administrador")){
                                        %>
                                        <option value="Todos">Todos</option>
                                        <option value="Código Docente">Código Docente</option>
                                        <option value="Nombre Docente">Nombre Docente</option>
                                        <option value="Semestre">Semestre</option>
                                        <option value="Código Curso">Código Curso</option>
                                        <option value="Nombre Curso">Nombre Curso</option>
                                        <option value="Fecha">Fecha</option>
                                        <%
                                    }
                                  %>
                              </select>
                            </div>
                        </div>
                              
                        <div class="form-group">
                            <label for="busqueda" class="control-label">Búsqueda</label>
                            <div class="">                              
                                <input name="busqueda" type="text" class="form-control" id="busqueda" placeholder="Búsqueda">
                            </div>
                        </div>
                              
                        <div class="form-group">
                            <input class="btn btn-success" type="submit" name="Listar" value="Listar Tabla">
                        </div>
                              
                        <div class="form-group">
                            <div class="table-responsive">
                                <table class="table table-striped table-prueba-entrada" border="1">
                                    <thead>
                                        <tr>
                                            <%
                                                if (nivelUsuario.equals("Usuario")) {
                                                    %>
                                                        <th>ID</th>
                                                        <th>Cod Curso</th>
                                                        <th>Curso</th>
                                                        <th>Fecha</th>
                                                        <th>Estado</th>
                                                        <th>Controles</th>
                                                    <% 
                                                }
                                                else if(nivelUsuario.equals("Supervisor") || nivelUsuario.equals("Administrador")){
                                                    %>
                                                        <th>ID</th>
                                                        <th>Cod Docente</th>
                                                        <th>Docente</th>
                                                        <th>Cod Curso</th>
                                                        <th>Semestre</th>
                                                        <th>Curso</th>
                                                        <th>Fecha</th>
                                                        <th>Estado</th>
                                                        <th>Controles</th>
                                                    <%
                                                }
                                            %>                                            
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <%
                                            if (request.getParameter("Listar")!=null) {
                                                if (nivelUsuario.equals("Usuario")) {
                                                    for (int i = 0; i < DatosPruebaEntradaUsuario.size(); i+=5) {
                                                        %>
                                                            <tr>
                                                                <td><%=DatosPruebaEntradaUsuario.get(i)%></td>
                                                                <td><%=DatosPruebaEntradaUsuario.get(i+1)%></td>
                                                                <td><%=DatosPruebaEntradaUsuario.get(i+2)%></td>
                                                                <td><%=DatosPruebaEntradaUsuario.get(i+3)%></td>
                                                                <td><%=DatosPruebaEntradaUsuario.get(i+4)%></td>
                                                                <td>
                                                                    <%
                                                                        if(tipoInforme.equals("Entrada")){
                                                                    %>
                                                                            <a href="ReporteInformePruebaEntrada.jsp?id_PruebaEntrada=<%=DatosPruebaEntradaUsuario.get(i)%>" class="btn btn-info btn-xs btn-controles">Imprimir informe</a>
                                                                    <%
                                                                        }
                                                                        else if(tipoInforme.equals("Final")){
                                                                    %>
                                                                            <a href="ReporteInformeFinal.jsp?id_InformeFinal=<%=DatosPruebaEntradaUsuario.get(i)%>" class="btn btn-info btn-xs btn-controles">Imprimir informe</a>
                                                                    <%
                                                                        }
                                                                    %>
                                                                    
                                                                    
                                                                </td>
                                                            </tr>
                                                        <%
                                                    }
                                                }
                                                
                                                if (nivelUsuario.equals("Supervisor") || nivelUsuario.equals("Administrador")) {
                                                    for (int i = 0; i < DatosPruebaEntradaAdministrador.size(); i+=8) {
                                                        %>
                                                            <tr>
                                                                <td><%=DatosPruebaEntradaAdministrador.get(i)%></td>
                                                                <td><%=DatosPruebaEntradaAdministrador.get(i+1)%></td>
                                                                <td><%=DatosPruebaEntradaAdministrador.get(i+2)%></td>
                                                                <td><%=DatosPruebaEntradaAdministrador.get(i+3)%></td>
                                                                <td><%=DatosPruebaEntradaAdministrador.get(i+4)%></td>
                                                                <td><%=DatosPruebaEntradaAdministrador.get(i+5)%></td>
                                                                <td><%=DatosPruebaEntradaAdministrador.get(i+6)%></td>
                                                                <td><%=DatosPruebaEntradaAdministrador.get(i+7)%></td>
                                                                <td>
                                                                     <%
                                                                        if(tipoInforme.equals("Entrada")){
                                                                    %>
                                                                            <a href="ReporteInformePruebaEntrada.jsp?id_PruebaEntrada=<%=DatosPruebaEntradaAdministrador.get(i)%>" class="btn btn-info btn-xs btn-controles">Imprimir informe</a>
                                                                    <%
                                                                        }
                                                                        else if(tipoInforme.equals("Final")){
                                                                    %>
                                                                            <a href="ReporteInformeFinal.jsp?id_InformeFinal=<%=DatosPruebaEntradaAdministrador.get(i)%>" class="btn btn-info btn-xs btn-controles">Imprimir informe</a>
                                                                    <%
                                                                        }
                                                                    %>
                                                                </td>
                                                            </tr>
                                                        <%
                                                    }
                                                }                                               
                                            }
                                        %>
                                    </tbody>
                                </table>
                            </div>
                        </div>
                                    
                        <div class="form-group">
                            <p><%=mensaje%></p>
                        </div>
                        
                    </fieldset>
                </form>
            </div>
        </div>        
    </body>
</html>

