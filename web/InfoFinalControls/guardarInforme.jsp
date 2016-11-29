
<%@page import="java.sql.ResultSet"%>
<%@page import="Negocio.ClsNegocioUsuario"%>
<%@page import="Negocio.ClsNegocioInformeFinalCurso"%>
<%@page import="Entidad.ClsEntidadInformeFinalCurso"%>
<%

    String codDocente = request.getParameter("codDocente");
    String idCurso = request.getParameter("idCurso");
    
    
    //OBTENER EL ID DE LA CARGA ACEDEMICA
    ClsEntidadInformeFinalCurso entiInfoFinal = new ClsEntidadInformeFinalCurso();
    ClsNegocioInformeFinalCurso negoInfoFinal = new ClsNegocioInformeFinalCurso();
    
    String idCargaAcademica = "";
    ClsNegocioUsuario docente = new ClsNegocioUsuario();
    ResultSet rsDocente = docente.obtenerDatosPruebaEntrada(codDocente, idCurso);

    while (rsDocente.next()) {
        idCargaAcademica = rsDocente.getString(8);
    }
    docente.conexion.close();
    
    /* recibir los datos Principal */
    
    entiInfoFinal.setIdCargaAcademica(Integer.parseInt(idCargaAcademica));
    negoInfoFinal.AgregarInformeFinal(entiInfoFinal);
    
    /* fin recibir datos principal */

    /* guardar datos principal */
    try {
        negoInfoFinal.cst.close();
        negoInfoFinal.conexion.close();
    } catch (Exception e) {
    }
    /* fin guardar datos principal */


    /*OBTENER EL ID DEL INFORME FINAL DEL CURSO*/
    ClsNegocioCapadidadInformeFinalCurso negocioCapacidadIdInfo = new ClsNegocioCapadidadInformeFinalCurso();
    ArrayList<String> idinfo = negocioCapacidadIdInfo.obtenerInfoFinalDocente(request.getParameter("cod_doc"), request.getParameter("id_Curso"));
    String id[] = idinfo.toArray(new String[idinfo.size()]);
    /*FIN*/


    /* recibir datos Capacidades */
    ClsEntidadCacidadInformeFinalCurso entiCapacidad = new ClsEntidadCacidadInformeFinalCurso();
    ClsNegocioCapadidadInformeFinalCurso negoCapacidad = new ClsNegocioCapadidadInformeFinalCurso();

    /* fin recibir datos capacidad */

    /* guardar datos capacidad */
    try {
        negoCapacidad.cst.close();
        negoCapacidad.conexion.close();
    } catch (Exception e) {
    }
    /* fin guardar datos capacidad */

    /* recibir datos observaciones */
    ClsEntidadObservaFinalCurso entiObserva = new ClsEntidadObservaFinalCurso();
    ClsNegocioObservacionesInformeFinalCurso negoObserva = new ClsNegocioObservacionesInformeFinalCurso();

    /* fin recibir */

    /* guardar datos observaciones */
    try {
        negoObserva.cst.close();
        negoObserva.conexion.close();
    } catch (Exception e) {
    }
    /* fin de guardar datos observaciones */

%>