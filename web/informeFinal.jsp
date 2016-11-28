<%-- 
    Document   : reportesFaltantes
    Created on : 14-nov-2016, 20:52:58
    Author     : Drei
--%>
<%@page import="Negocio.ClsNegocioUsuario"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="Negocio.ClsNegocioDetallePruebaEntrada"%>
<%@page import="Entidad.ClsEntidadPruebaEntrada"%>
<%@page import="Entidad.ClsEntidadDetallePruebaEntrada"%>
<%@page import="java.util.Enumeration"%>
<%@page import="Entidad.ClsEntidadPruebaCursosFaltantes"%>
<%@page import="java.util.Iterator"%>
<%@page import="java.util.ArrayList"%>
<%@page import="Negocio.ClsNegocioPruebaEntrada"%>
<%@include file="header.jsp" %>

<%@ page import = "java.util.Map" %>

<%@page contentType="text/html" pageEncoding="UTF-8"%>


<%   
    
    // CARGAR DATOS CABECERA
    
    String codDocente = String.valueOf(session.getAttribute("codDocente"));
    String nivelUsuario = String.valueOf(session.getAttribute("nivelUsuario"));   
    String busqueda = "Prueba Entrada";
    String idCurso = request.getParameter("id_Curso");
    
    
%>

<head>
    <title>Informe Prueba Entrada</title>
</head>
<body class="background-gray">
        <div class="container body-padding">
            <div class="row">
                <div class="form-reporte shadow">
                    <form class="" method="post">
                        <fieldset>

                            <div class="form-group">

                                <div class="sub-title">  
                                    <h2>Informe Final del Curso</h2>
                                    <h4>Semestre</h4>
                                    <br>
                                    <h4>Datos del curso :</h4>
                                </div>

                                <div class="row">

                                    <label class="col-lg-2 ">Nombre :</label>
                                    <div class="col-lg-4">
                                        <input type="text" class="form-control input-sm" id="" value=''>
                                    </div>   

                                    <label class="col-lg-2 ">Código :</label>
                                    <div class="col-lg-3">
                                        <input type="text" class="form-control input-sm" id="" value=''>
                                    </div>


                                </div>

                                <div class="row">

                                    <label class="col-lg-2 ">Teórico :</label>
                                    <div class="col-lg-1">
                                        <input type="checkbox" min="0" class="" id="" name='matriculados' value=''>
                                    </div>

                                    <label class="col-lg-2 ">Práctico :</label>
                                    <div class="col-lg-1">
                                        <input type="checkbox" min="0" class="" id="" value=''>
                                    </div>              


                                </div>

                                <div class="row">   
                                    <label class="col-lg-2 ">Laboratorio :</label>
                                    <div class="col-lg-1">
                                        <input type="checkbox" min="0" class="" id="" value=''>
                                    </div>

                                    <label class="col-lg-2 ">Taller :</label>
                                    <div class="col-lg-1">
                                      <input type="checkbox" min="0" class="" id="" name='evaluados' value="">
                                    </div>                                
                                </div>

                                <div class="sub-title">                                
                                    <h4>Datos del docente :</h4>
                                </div>

                                <div class="row">                                
                                    <label class="col-lg-2 ">Nombre :</label>
                                    <div class="col-lg-4">
                                        <input type="text" class="form-control input-sm" id="" value=''>
                                    </div>                      
                                </div>

                                <div class="row">

                                    <label class="col-lg-2 ">Email :</label>
                                    <div class="col-lg-4">
                                        <input type="number" min="0" class="form-control input-sm" id="" value=''>
                                    </div>

                                    <label class="col-lg-2 ">Celular :</label>
                                    <div class="col-lg-3">
                                      <input type="number" min="0" class="form-control input-sm" id="" value=''>
                                    </div>                                
                                </div>

                            </div>

                            <div class="form-group">   
                                <div class="row">
                                    <div class="col-lg-5">
                                        <h4>Resumen del curso</h4>
                                    </div>
                                    <div class="col-lg-1 text-center">
                                        <h4>Nº</h4>
                                    </div>
                                    <div class="col-lg-1 text-center">
                                        <h4>%</h4>
                                    </div>
                                </div>                            
                                <div class="row">                                
                                    <label class="col-lg-5 ">Porcentaje de cumplimiento del sílabo</label>
                                    <div class="col-lg-1">
                                        <input type="text" class="form-control input-sm" id="" value=''>
                                    </div>  
                                    <div class="col-lg-1">
                                        <input type="text" class="form-control input-sm" id="" value=''>
                                    </div>  
                                </div>
                                <div class="row">                                
                                    <label class="col-lg-5 ">Prácticas calificadas realizadas</label>
                                    <div class="col-lg-1">
                                        <input type="text" class="form-control input-sm" id="" value=''>
                                    </div>  
                                    <div class="col-lg-1">
                                        <input type="text" class="form-control input-sm" id="" value=''>
                                    </div>  
                                </div>
                                <div class="row">                                
                                    <label class="col-lg-5 ">Experiencias de laboratorio realizadas</label>
                                    <div class="col-lg-1">
                                        <input type="text" class="form-control input-sm" id="" value=''>
                                    </div>  
                                    <div class="col-lg-1">
                                        <input type="text" class="form-control input-sm" id="" value=''>
                                    </div>  
                                </div>
                                <div class="row">                                
                                    <label class="col-lg-5 ">Proyectos y/o trabajos de investigación realizados</label>
                                    <div class="col-lg-1">
                                        <input type="text" class="form-control input-sm" id="" value=''>
                                    </div>  
                                    <div class="col-lg-1">
                                        <input type="text" class="form-control input-sm" id="" value=''>
                                    </div>  
                                </div>
                                <div class="row">                                
                                    <label class="col-lg-5 ">Estudiantes matriculados</label>
                                    <div class="col-lg-1">
                                        <input type="text" class="form-control input-sm" id="" value=''>
                                    </div>  
                                    <div class="col-lg-1">
                                        <input type="text" class="form-control input-sm" id="" value=''>
                                    </div>  
                                </div>
                                <div class="row">                                
                                    <label class="col-lg-5 ">Estudiantes retirados</label>
                                    <div class="col-lg-1">
                                        <input type="text" class="form-control input-sm" id="" value=''>
                                    </div>  
                                    <div class="col-lg-1">
                                        <input type="text" class="form-control input-sm" id="" value=''>
                                    </div>  
                                </div>
                                <div class="row">                                
                                    <label class="col-lg-5 ">Estudiantes con abandono</label>
                                    <div class="col-lg-1">
                                        <input type="text" class="form-control input-sm" id="" value=''>
                                    </div>  
                                    <div class="col-lg-1">
                                        <input type="text" class="form-control input-sm" id="" value=''>
                                    </div>  
                                </div>
                                <div class="row">                                
                                    <label class="col-lg-5 ">Estudiantes que asisten</label>
                                    <div class="col-lg-1">
                                        <input type="text" class="form-control input-sm" id="" value=''>
                                    </div>  
                                    <div class="col-lg-1">
                                        <input type="text" class="form-control input-sm" id="" value=''>
                                    </div>  
                                </div>
                                <div class="row">                                
                                    <label class="col-lg-5 ">Estudiantes aprobados</label>
                                    <div class="col-lg-1">
                                        <input type="text" class="form-control input-sm" id="" value=''>
                                    </div>  
                                    <div class="col-lg-1">
                                        <input type="text" class="form-control input-sm" id="" value=''>
                                    </div>  
                                </div>
                                <div class="row">                                
                                    <label class="col-lg-5 ">Estudiantes desaprobados</label>
                                    <div class="col-lg-1">
                                        <input type="text" class="form-control input-sm" id="" value=''>
                                    </div>  
                                    <div class="col-lg-1">
                                        <input type="text" class="form-control input-sm" id="" value=''>
                                    </div>  
                                </div>
                                <div class="row">                                
                                    <label class="col-lg-5 ">Nota final más alta</label>
                                    <div class="col-lg-1">
                                        <input type="text" class="form-control input-sm" id="" value=''>
                                    </div>  
                                </div>
                                <div class="row">                                
                                    <label class="col-lg-5 ">Nota final promedio</label>
                                    <div class="col-lg-1">
                                        <input type="text" class="form-control input-sm" id="" value=''>
                                    </div>  
                                </div>
                                <div class="row">                                
                                    <label class="col-lg-5 ">Nota final más baja</label>
                                    <div class="col-lg-1">
                                        <input type="text" class="form-control input-sm" id="" value=''>
                                    </div>   
                                </div>                            
                            </div>    

                            <div class="form-group">
                                <label><a id="calc_percentages" class="btn btn-primary">Calcular Porcentajes</a></label>
                                <div><p id='permessage' ></p></div>
                            </div>    

                            <div class="form-group">
                                <div class="sub-title">  
                                    <h4>Indicaciones :</h4>
                                    <p>Según su apreciación deberá maracar el nivel que han alcanzado los estudiantes 
                                        en los diferentes aspectos que se mencionan a continuación:</p>
                                </div>
                                <table class="table table-striped table-hover ">
                                    <thead>
                                        <tr>
                                            <th>N</th>
                                            <th>P</th>
                                            <th>A</th>
                                            <th>B</th>
                                            <th>M</th>
                                        </tr>
                                    </thead>
                                    <thead>
                                        <tr class="">
                                            <th>Nada</th>
                                            <th>Poco</th>
                                            <th>Aceptable</th>
                                            <th>Bien</th>
                                            <th>Muy Bien</th>
                                        </tr>
                                    </thead>
                                </table>

                                <div class="sub-title">  
                                    <p>Logros de capacidades del curso:</p>                                
                                </div>
                                
                                <div class="form-group table-responsive">
                                    <table class="table table-striped table-responsive table-prueba-entrada" id="tab_logic">
                                        <thead>
                                            <th class="col-md-7">Capacidades del curso</th>
                                            <th class="col-md-1">N</th>
                                            <th class="col-md-1">P</th>
                                            <th class="col-md-1">A</th>
                                            <th class="col-md-1">B</th>
                                            <th class="col-md-1">M</th>
                                        </thead>
                                        <tbody>
                                            <tr>
                                                <td><input value="" type="text" class="form-control"/></td>
                                                <td><input value="" type="text" class="form-control"/></td>
                                                <td><input value="" type="text" class="form-control"/></td>
                                                <td><input value="" type="text" class="form-control"/></td>
                                                <td><input value="" type="text" class="form-control"/></td>
                                                <td><input value="" type="text" class="form-control"/></td>
                                            </tr>
                                        </tbody>
                                    </table>
                                </div>
                                <label><a id="add_row" class="btn btn-success">Agregar Fila</a></label>
                                <label><a id='delete_row' class="btn btn-danger ">Eliminar Fila</a></label>
                                <div><p id='permessage' ></p></div>
                            </div>  

                            <div class="form-group" id="medidas_logic">
                                <label>Cuál cree que ha sido el motivo por el cual los estudiantes no alcanzaron el logro de capacidades</label>
                                <div id="mc0">
                                    <p>Para Nº 1<p>
                                    <textarea name="medCorrectiva" class="form-control"></textarea>
                                </div>   
                                <div id="mc1"></div>
                            </div>   
                            
                            <div class="form-group">
                                <div class="sub-title">  
                                    <h4>Observaciones :</h4>                                    
                                </div>
                                <div class="observaciones">
                                    <label>1.</label>
                                    <textarea class="form-control" rows="3"></textarea>
                                </div>
                                <div class="observaciones">
                                    <label>2.</label>
                                    <textarea class="form-control" rows="3"></textarea>
                                </div>
                                <div class="observaciones">
                                    <label>3.</label>
                                    <textarea class="form-control" rows="3"></textarea>
                                </div>
                                <div class="observaciones">
                                    <label>4.</label>
                                    <div class="row">
                                        <label class="col-lg-2 ">Material del curso :</label>
                                        <div class="col-lg-1">
                                            <input type="checkbox" min="0" class="" id="" name='materialcurso' value=''>
                                        </div>
                                        <label class="col-lg-2 ">Cuestionarios :</label>
                                        <div class="col-lg-1">
                                            <input type="checkbox" min="0" class="" id="" name='cuestionarios' value=''>
                                        </div>
                                        <label class="col-lg-2 ">Tareas encargadas:</label>
                                        <div class="col-lg-1">
                                            <input type="checkbox" min="0" class="" id="" name='tareasencargadas' value=''>
                                        </div>
                                    </div>
                                    <div class="row">
                                        <label class="col-lg-2 ">Foros :</label>
                                        <div class="col-lg-1">
                                            <input type="checkbox" min="0" class="" id="" name='foros' value=''>
                                        </div>
                                        <label class="col-lg-2 ">Examenes virtuales :</label>
                                        <div class="col-lg-1">
                                            <input type="checkbox" min="0" class="" id="" name='examenesvirtuales' value=''>
                                        </div>
                                        <label class="col-lg-2 ">Slideshow :</label>
                                        <div class="col-lg-1">
                                            <input type="checkbox" min="0" class="" id="" name='slideshow' value=''>
                                        </div>
                                    </div>
                                </div>
                                <div class="observaciones">
                                    <label>5.</label>
                                    <textarea class="form-control" rows="3"></textarea>
                                </div>
                                <div class="observaciones">
                                    <label>6.</label>
                                    <textarea class="form-control" rows="3"></textarea>
                                </div>
                                <div class="observaciones">
                                    <label>7.</label>
                                    <textarea class="form-control" rows="3"></textarea>
                                </div>
                                <div class="observaciones">
                                    <label>8.</label>
                                    <textarea class="form-control" rows="3"></textarea>
                                </div>
                                <div class="observaciones">
                                    <label>9.</label>
                                    <textarea class="form-control" rows="3"></textarea>
                                </div>
                                
                            </div>


                            <div class="form-group">
                                 <%if(nivelUsuario.equals("Usuario")){
                                    %>
                                    <input class="btn btn-primary" type="submit" name="Guardar" value="Guardar">
                                    <input class="btn btn-primary" type="submit" name="Enviar" value="Enviar">
                                    <%   
                                }
                                %>
                                <%if(nivelUsuario.equals("Administrador") || nivelUsuario.equals("Supervisor")){
                                    %>
                                    <input class="btn btn-success" type="submit" name="Aceptar" value="Aceptar">
                                    <input class="btn btn-danger" type="submit" name="Rechazar" value="Rechazar">
                                    <%   
                                }
                                %>


                                <input class="btn btn-primary" type="submit" name="Informe" value="Hacer Informe">
                                <a href="consultaPruebaEntrada.jsp" class="btn btn-primary"> Volver</a>
                            </div>

                            <div class="form-group">
                                <p></p>
                            </div>

                        </fieldset>
                    </form>
                </div>
            </div>
        </div>   
        <script>
             var i=1;
             var calculadoPorcentajes = false;
            $("#add_row").click(function(){
                
                $('#addr'+i).html("<td><input value='" + (i+1) + "' type='text' class='form-control'/></td>"+
                               "<td><input name='detalleCon"+i+"' type='text' class='form-control'/></td>"+
                               "<td><input name='detalleNa"+i+"' type='text' class='form-control'/></td>"+
                               "<td><input name='naPer"+i+"' type='text' class='form-control'/></td>"+
                               "<td><input name='detalleSu"+i+"' type='text' class='form-control'/></td>"+
                               "<td><input name='suPer"+i+"' type='text' class='form-control'/></td>"+
                               "<td><input name='detalleBu"+i+"' type='text' class='form-control'/></td>"+
                               "<td><input name='buPer"+i+"' type='text' class='form-control'/></td>"+
                               "<td><input name='total"+i+"' type='text' class='form-control'/></td>");                               

                $('#tab_logic').append('<tr id="addr'+(i+1)+'"></tr>');

                $('#mc'+i).html("<p>Para Nº "+(i+1)+"<p><textarea name='medCorrectiva"+i+"' class='form-control'></textarea>");
             
                $('#medidas_logic').append("<div id='mc"+(i+1)+"'></div>");
             
             i++; 
         });
            $("#delete_row").click(function(){
                if(i>1){
                $("#addr"+(i-1)).html('');
                $("#mc"+(i-1)).html('');
                i--;
                }
            });
            
            $("#calc_percentages").click(function(){
                var filas = i;
                var permessage = "";
                if ($("input[name=evaluados]").val() !== "") {
                    var evaluados = $("input[name=evaluados]").val();
                    var matriculados = $("input[name=matriculados]").val();
                    var CantNoAceptable = 0;
                    var CantSuficiente  = 0;
                    var CantBueno       = 0;  

                    //3 5 7

                    if (!(filas <= 0 || evaluados <= 0 || evaluados > matriculados)) {

                        for (var k = 0; k < filas; k++) {

                            if (!($("input[name=detalleNa"+k+"]").val() === "" || $("input[name=detalleSu"+k+"]").val() === "" || $("input[name=detalleBu"+k+"]").val() === "" )) {
                                CantNoAceptable = parseInt($("input[name=detalleNa"+k+"]").val());
                                CantSuficiente  = parseInt($("input[name=detalleSu"+k+"]").val());
                                CantBueno       = parseInt($("input[name=detalleBu"+k+"]").val());
                                
                                if ((CantNoAceptable+CantSuficiente+CantBueno) > evaluados) {
                                    permessage = "Cantidades de la tabla superior a los evaluados";
                                    break;
                                }
                                else{
                                    $("input[name=naPer"+k+"]").val(CantNoAceptable*100/evaluados);
                                    $("input[name=suPer"+k+"]").val(CantSuficiente*100/evaluados);
                                    $("input[name=buPer"+k+"]").val(CantBueno*100/evaluados);
                                    $("input[name=total"+k+"]").val(((CantNoAceptable*100)/evaluados) + ((CantSuficiente*100)/evaluados) + ((CantBueno*100)/evaluados));

                                    calculadoPorcentajes = true;
                                }
                            }
                            else{
                                permessage = "Datos de la Tabla Vacios.";
                                break;
                            }

                        }

                    }
                    else{
                        permessage = "Datos incorrectos (tabla).";
                    }
                }
                else{
                    permessage = "Ingrese la cantidad de evaluados.";
                }
                $("#permessage").html('');
                $("#permessage").append(permessage);
            });
        </script>
                                    
    </body>
</html>
