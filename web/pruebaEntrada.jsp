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

<%!
    
%>


<%   
    
    // CARGAR DATOS DE FORMULARIO
    
    String codDocente = String.valueOf(session.getAttribute("codDocente"));
    String nivelUsuario = String.valueOf(session.getAttribute("nivelUsuario"));   
    String busqueda = "Prueba Entrada";
    String idCurso = request.getParameter("id_Curso");
    
    ArrayList<ClsNegocioPruebaEntrada> dato = null;
    ClsNegocioPruebaEntrada datos = new ClsNegocioPruebaEntrada();
    dato = datos.hacerInformePruebaFaltante(codDocente,busqueda);
    Iterator iterator = dato.iterator();
    String campo[] = new String[11];
    

    while (iterator.hasNext()) {
        ClsEntidadPruebaCursosFaltantes objenti = new ClsEntidadPruebaCursosFaltantes();

        objenti = (ClsEntidadPruebaCursosFaltantes) iterator.next();

        if (idCurso.equals(String.valueOf(objenti.getIdCurso()))) {
            campo[0] = objenti.getIdCurso();
            campo[1] = objenti.getNombreCurso();
            campo[2] = String.valueOf(objenti.getHorasTeoricas());
            campo[3] = String.valueOf(objenti.getHoraPracticas());
            campo[4] = String.valueOf(objenti.getAlumnosMatriculados());
            campo[5] = String.valueOf(objenti.getAlumnosRetirados());
            campo[6] = String.valueOf(objenti.getAlumnosAbandono());
            campo[7] = String.valueOf(objenti.getCodigoDocente());
            campo[8] = String.valueOf(objenti.getNombreDocente());
            campo[9] = objenti.getEmailDocente();
            campo[10]= objenti.getCeluDocente();
            break;
        }

    }
    
    // FIN DE CARGAR DATOS DE FORMULARIO
    
    
    /*************************************************************************/
    
    
    // OBTENIENDO EL PLAN DE ESTUDIOS
    
    String idPlanEstudios = "";
    //Instanciar la clase NegocioUsuario
    ClsNegocioUsuario docente = new ClsNegocioUsuario();

    //Obtiene el resultado de la consulta hecha a la BD
    ResultSet rsDocente = docente.obtenerDatosPruebaEntrada(campo[7], campo[0]);

    //itera los valores hechas en la consulta
    while (rsDocente.next()) {
        //llenar los valores con los valores respectivos
//        lblSemestre.setText("Semestre " + rsDocente.getString(7));
        idPlanEstudios = rsDocente.getString(8);
    }
    docente.conexion.close();
    
    // FIN DE OBTENIENDO EL PLAN DE ESTUDIOS
      
    /*************************************************************************/
    
    // GUARDAR DATOS
    
    ArrayList<String> datosTabla = new ArrayList<>();
    ArrayList<String> datosMedidasCorrectivas = new ArrayList<>();
    String mensaje = "";
    
    ClsEntidadDetallePruebaEntrada entidadDetalle = new ClsEntidadDetallePruebaEntrada();
    ClsNegocioPruebaEntrada negocioPrueba = new ClsNegocioPruebaEntrada();
    ClsEntidadPruebaEntrada entidadPrueba = new ClsEntidadPruebaEntrada();
    
    if (request.getParameter("Guardar")!=null) {
        mensaje = "Hello World <br>";
        
    /*************************************************************************/
    
    // OBTENIENDO DATOS DEL FORMULARIO
        Enumeration parameterList = request.getParameterNames();
        while( parameterList.hasMoreElements() )
        {
          String sName = parameterList.nextElement().toString();
          if(sName.toLowerCase().startsWith("detalle")){
            datosTabla.add(request.getParameter(sName));
          }
          if(sName.toLowerCase().startsWith("medcorrectiva")){
            datosMedidasCorrectivas.add(request.getParameter(sName));
          }
        }        
        
    /*************************************************************************/
        
    //FUNCION GUARDAR
    //GUARDAR PRUEBA DE ENTRADA
        String estado = "Guardado";
        String IDPruebaEntrada = "";
        
        entidadPrueba.setIdCargaAcademica(Integer.parseInt(idPlanEstudios));
        entidadPrueba.setEstado(estado);
        entidadPrueba.setEvaluados(Integer.parseInt(request.getParameter("evaluados")));

        negocioPrueba.AgregarPruebaEntrada(entidadPrueba);
        negocioPrueba.cst.close();
        negocioPrueba.conexion.close();

        //GUARDAR DETALLE DE PRUEBA DE ENTRADA
        ClsNegocioDetallePruebaEntrada negocioDetalle = new ClsNegocioDetallePruebaEntrada();
        ResultSet rs = negocioDetalle.ObtenerIdPruebaEntrada(idPlanEstudios);
        while (rs.next()) {
            IDPruebaEntrada = rs.getString(1);
        }

        int l = 0;
        for (int i = 0; i < datosTabla.size(); i+=4) {
            entidadDetalle.setIdPruebaEntrada(Integer.parseInt(IDPruebaEntrada));
            entidadDetalle.setHabilidad(datosTabla.get(i));
            entidadDetalle.setCantNoAceptalbe(Integer.parseInt(datosTabla.get(i+1)));
            entidadDetalle.setCantSuficiente(Integer.parseInt(datosTabla.get(i+2)));
            entidadDetalle.setCantBueno(Integer.parseInt(datosTabla.get(i+3)));            
            entidadDetalle.setMedidasCorrectivas(datosMedidasCorrectivas.get(l));
            l++;
            negocioDetalle.AgregarDetallePruebaEntrada(entidadDetalle);
        }
        
        negocioDetalle.conexion.close();
    }
    
    
    /*************************************************************************/
    
    for (int j = 0; j < datosTabla.size(); j++) {
        mensaje += datosTabla.get(j) + " - ";
        if((j+1) % 4 == 0){
            mensaje += "<br>";
        }
    }
    for (int j = 0; j < datosMedidasCorrectivas.size(); j++) {
        mensaje += datosMedidasCorrectivas.get(j) + " - ";
        mensaje += "<br>";
    }
%>

<head>
    <title>Informe Prueba Entrada</title>
</head>
<body class="background-gray">
        <div class="container body-padding">
            <div class="row">
                <form class="form-reporte shadow" method="post">
                    <fieldset>
                        <div class="form-group">
                            <h2>Informe Prueba Entrada</h2>
                            <h4>Semestre</h4>
                        </div>
                        <div class="form-group">
                            
                            <input type="hidden" id="" value='<%=campo[7]%>'>
                            
                            <div class="row">
                                <label class="col-lg-2 ">Código :</label>
                                <div class="col-lg-2">
                                    <input type="text" class="form-control input-sm" id="" value='<%=campo[0]%>'>
                                </div>
                                
                                <label class="col-lg-offset-1 col-lg-2 ">Matriculados :</label>
                                <div class="col-lg-1">
                                    <input type="number" min="0" class="form-control input-sm" id="" name='matriculados' value='<%=campo[4]%>'>
                                </div>
                                
                                <label class="col-lg-2 ">Abandono :</label>
                                <div class="col-lg-1">
                                    <input type="number" min="0" class="form-control input-sm" id="" value='<%=campo[6]%>'>
                                </div>                                
                            </div>
                            
                            <div class="row">
                                <label class="col-lg-2 ">Nombre :</label>
                                <div class="col-lg-2">
                                    <input type="text" class="form-control input-sm" id="" value='<%=campo[1]%>'>
                                </div>
                                
                                <label class="col-lg-offset-1 col-lg-2 ">Retirados :</label>
                                <div class="col-lg-1">
                                    <input type="number" min="0" class="form-control input-sm" id="" value='<%=campo[5]%>'>
                                </div>
                                
                                <label class="col-lg-2 ">Evaluados :</label>
                                <div class="col-lg-1">
                                  <input type="number" min="0" class="form-control input-sm" id="" name='evaluados'>
                                </div>                                
                            </div>
                            
                            <div class="row">
                                <label class="col-lg-2 ">Docente :</label>
                                <div class="col-lg-2">
                                    <input type="text" class="form-control input-sm" id="" value='<%=campo[8]%>'>
                                </div>
                                
                                <label class="col-lg-offset-1 col-lg-2 ">Teórico :</label>
                                <div class="col-lg-1">
                                    <input type="number" min="0" class="form-control input-sm" id="" value='<%=campo[2]%>'>
                                </div>
                                
                                <label class="col-lg-2 ">Práctico :</label>
                                <div class="col-lg-1">
                                  <input type="number" min="0" class="form-control input-sm" id="" value='<%=campo[3]%>'>
                                </div>                                
                            </div>
                        </div>
                        
                        <div class="form-group table-responsive">
                            <table class="table table-striped table-responsive table-prueba-entrada" id="tab_logic">
                                <thead>
                                    <th class="col-md-1">Nro</th>
                                    <th class="col-md-4">Conocimiento o Habilidad</th>
                                    <th class="col-md-1">No Aceptable</th>
                                    <th class="col-md-1">%</th>
                                    <th class="col-md-1">Suficiente</th>
                                    <th class="col-md-1">%</th>
                                    <th class="col-md-1">Bueno</th>
                                    <th class="col-md-1">%</th>
                                    <th class="col-md-1">Total</th>
                                </thead>
                                <tbody>
                                  <tr id='addr0'>
                                    <td><input value="1" type="text" class="form-control"/></td>
                                    <td><input name="detalleCon0" type="text" class="form-control"/></td>
                                    <td><input name="detalleNa0" type="text" class="form-control"/></td>
                                    <td><input name='naPer0' type="text" class="form-control"/></td>
                                    <td><input name="detalleSu0" type="text" class="form-control"/></td>
                                    <td><input name='suPer0' type="text" class="form-control"/></td>
                                    <td><input name="detalleBu0" type="text" class="form-control"/></td>
                                    <td><input name='buPer0' type="text" class="form-control"/></td>
                                    <td><input name='total0' type="text" class="form-control"/></td>
                                  </tr>
                                  <tr id='addr1'></tr>
                                </tbody>
                            </table>
                        </div>
                        
                        <div class="form-group">
                            <label><a id="calc_percentages" class="btn btn-primary">Calcular Porcentajes</a></label>
                            <label><a id="add_row" class="btn btn-warning">Agregar Fila</a></label>
                            <label><a id='delete_row' class="btn btn-warning ">Eliminar Fila</a></label>
                            <div><p id='permessage' ></p></div>
                        </div>    
                        
                        <div class="form-group" id="medidas_logic">
                            <label>Describa las medidas correctivas que tomará en los casos de grado no aceptable:</label>
                            <div id="mc0">
                                <p>Para Nº 1<p>
                                <textarea name="medCorrectiva0" class="form-control"></textarea>
                            </div>    
                            <div id="mc1"></div>
                        </div>   
                        
                        
                        
                        <div class="form-group">
                            <input class="btn btn-primary" type="submit" name="Guardar" value="Guardar">
                        </div>
                        
                        <div class="form-group">
                            <p><%//mensaje%></p>
                        </div>
                        
                    </fieldset>
                </form>
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
