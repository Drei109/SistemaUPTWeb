<%-- 
    Document   : index
    Created on : 13-nov-2016, 19:53:14
    Author     : Drei
--%>
<%@page import="Negocio.ClsNegocioUsuario" %>
<%@page import="java.sql.*" %>
<%@page import="Negocio.ClsNegocioUsuario" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<%
    
    ResultSet rs = null;
    String codDocente;
    String nivelUsuario;
    String mensaje = "";
    
    String usu = request.getParameter("txtUsuario");
    String pass = request.getParameter("txtPassword");   
    
    ClsNegocioUsuario usuario = new ClsNegocioUsuario();

    if((usu!=null) && (pass!=null)){
        boolean existe = false;
        rs = usuario.LoginUsuario(usu, pass);
        
        while (rs.next()) {                
                if (usu.equals(rs.getString(2)) && pass.equals(rs.getString(3))) {
                    if ("Activo".equals(rs.getString(5))) {
                        
                        session.setAttribute("codDocente", rs.getString(2));
                        session.setAttribute("nivelUsuario", rs.getString(4));
                        session.setAttribute("estadoUsuario", rs.getString(5));  
                        session.setAttribute("nombreDocente", rs.getString(6));
                        rs.close();
                        usuario.conexion.close();
                        response.sendRedirect("index.jsp");
                    }
                    else{
                        mensaje = "Lo sentimos: Te encuetras desactivado";
                    }
                
                }
                existe = true;
                break;
            }            
        if (existe == false) {
            mensaje = "El usuario no se encuentra registrado.";
        }
    }
    
    if(request.getParameter("Cancelar")!= null){
        mensaje = "";
    }
%>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <link href="css/bootstrap.min.css" rel="stylesheet" type="text/css"/>
        <link href="css/styles.css" rel="stylesheet" type="text/css"/>
        <script src="js/jquery-3.1.1.min.js" type="text/javascript"></script>
        <script src="js/bootstrap.min.js" type="text/javascript"></script>
        
        <title>Sistema UPT - Login</title> 
    </head>
    <body>
        <div class="container-fluid background">
            
            <div class="row row-login-container">
                <div class="col-lg-4 col-lg-offset-4 col-md-4 col-md-offset-4 col-xs-12 login-container">
                    <form name="frmlogin" method="POST" class="modal-form">
                        <div class="modal-dialog">
                          <div class="modal-content">
                            <div class="modal-header">
                              <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                              <h4 class="modal-title">Login</h4>
                            </div>
                            <div class="modal-body">
                                <label class="control-label">Usuario : </label>
                                <input class="form-control" type="text" name="txtUsuario" placeholder="Ingresa usuario">
                                <label class="control-label">Password : </label>
                                <input class="form-control" type="password" name="txtPassword" placeholder="Ingresa password">                                
                                <%
                                    if (mensaje != "") {
                                            out.println("<p class='mensaje-login'>" + mensaje + "</p>");
                                        }
                                %>
                            </div>
                            <div class="modal-footer">
                                <input class="btn btn-primary" type="submit" name="Enviar" value="Ingresar">
                                <input class="btn btn-danger" type="submit" name="Cancelar" value="Cancelar">
                            </div>
                          </div>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </body>
</html>
