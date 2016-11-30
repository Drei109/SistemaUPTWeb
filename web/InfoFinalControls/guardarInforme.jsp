
<%@page import="Negocio.ClsNegocioObservacionesInformeFinalCurso"%>
<%@page import="Entidad.ClsEntidadObservaFinalCurso"%>
<%@page import="Entidad.ClsEntidadCacidadInformeFinalCurso"%>
<%@page import="java.util.Enumeration"%>
<%@page import="java.util.ArrayList"%>
<%@page import="Negocio.ClsNegocioCapadidadInformeFinalCurso"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="Negocio.ClsNegocioUsuario"%>
<%@page import="Negocio.ClsNegocioInformeFinalCurso"%>
<%@page import="Entidad.ClsEntidadInformeFinalCurso"%>
<%

    String codDocente = String.valueOf(request.getSession().getAttribute("codDocente"));
    String idCurso = request.getParameter("idCurso");
    String id_PruebaEntrada = request.getParameter("id_PruebaEntrada");
    String estado = "";
    
    if (request.getParameter("Guardar") != null) {
        estado = "Guardado";
    }
    else if(request.getParameter("Enviar") != null){
        estado = "Enviado";
    }
    
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
        int cumpliSilabo = Integer.parseInt(request.getParameter("porSilabo"));
        int caliRealizadas = Integer.parseInt(request.getParameter("caliRealizadas"));
        int laboRealizada = Integer.parseInt(request.getParameter("laboRealizada"));
        int proyeRealizado = Integer.parseInt(request.getParameter("proyeRealizado"));
        int estAsiste = Integer.parseInt(request.getParameter("estAsiste"));
        int estAprobado = Integer.parseInt(request.getParameter("estAprobado"));
        int estDesapro = Integer.parseInt(request.getParameter("estDesapro"));
        int notaMasAlta = Integer.parseInt(request.getParameter("notaMasAlta"));
        int notaProm = Integer.parseInt(request.getParameter("notaProm"));
        int notaMasBaja = Integer.parseInt(request.getParameter("notaMasBaja"));

        String Lab = request.getParameter("Lab") != null ? "Si" : "No";
        String Taller = request.getParameter("Taller") != null ? "Si" : "No";


        entiInfoFinal.setIdCargaAcademica(Integer.parseInt(idCargaAcademica));
        entiInfoFinal.setEstadoInformeFinalCurso(estado);
        entiInfoFinal.setCumpliSilabo(cumpliSilabo);
        entiInfoFinal.setPractiRealizadas(caliRealizadas);
        entiInfoFinal.setLaboratoRealizadas(laboRealizada);
        entiInfoFinal.setProyectoRealizado(proyeRealizado);
        entiInfoFinal.setEstudianteAsiste(estAsiste);
        entiInfoFinal.setEstudienteAproado(estAprobado);
        entiInfoFinal.setEstudianteDesaprobado(estDesapro);
        entiInfoFinal.setNotaMasAlta(notaMasAlta);
        entiInfoFinal.setNotaPromedio(notaProm);
        entiInfoFinal.setNotaMasBaja(notaMasBaja);
        entiInfoFinal.setLab(Lab);
        entiInfoFinal.setTaller(Taller);
        
        if (idCurso != null) {
            negoInfoFinal.AgregarInformeFinal(entiInfoFinal);
        }
        else if( id_PruebaEntrada != null){
            negoInfoFinal.ModificarInformeFinal(id_PruebaEntrada, entiInfoFinal);
        }

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
        ArrayList<String> idinfo = negocioCapacidadIdInfo.obtenerInfoFinalDocente(codDocente, idCurso);
        String id[] = idinfo.toArray(new String[idinfo.size()]);
        /*FIN*/
        
        
        if( id_PruebaEntrada != null){
            negocioCapacidadIdInfo.EliminarDetallInfoFinalTodo(id[0]);;
        }

        /* recibir datos Capacidades */
        ArrayList<String> datosTabla = new ArrayList<>();
        ArrayList<String> datosMedidasCorrectivas = new ArrayList<>();

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

        ClsEntidadCacidadInformeFinalCurso entiCapa = new ClsEntidadCacidadInformeFinalCurso();
        ClsNegocioCapadidadInformeFinalCurso negoCapa = new ClsNegocioCapadidadInformeFinalCurso();
        int l = 0;
        for (int i = 0; i < datosTabla.size(); i+=6) {
            entiCapa.setDescripcion(datosTabla.get(i));

            String n = datosTabla.get(i+1).toLowerCase().equals("x") ? "Si":"No";
            String p = datosTabla.get(i+2).toLowerCase().equals("x") ? "Si":"No";
            String a = datosTabla.get(i+3).toLowerCase().equals("x") ? "Si":"No";
            String b = datosTabla.get(i+4).toLowerCase().equals("x") ? "Si":"No";
            String m = datosTabla.get(i+5).toLowerCase().equals("x") ? "Si":"No";

            if(n.equals("Si")) entiCapa.setIdnivelcapacidad(1);
            if(p.equals("Si")) entiCapa.setIdnivelcapacidad(11);
            if(a.equals("Si")) entiCapa.setIdnivelcapacidad(21);
            if(b.equals("Si")) entiCapa.setIdnivelcapacidad(31);
            if(m.equals("Si")) entiCapa.setIdnivelcapacidad(41);

            entiCapa.setIdinformefinalcurso(Integer.parseInt(id[0]));

            entiCapa.setMedidaCorectiva(datosMedidasCorrectivas.get(l));
            l++;
            negoCapa.AgregarDetallePruebaEntrada(entiCapa);
        }

        /* fin guardar datos capacidad */


        /* recibir datos observaciones */
        ClsEntidadObservaFinalCurso entiObserva = new ClsEntidadObservaFinalCurso();
        ClsNegocioObservacionesInformeFinalCurso negoObserva = new ClsNegocioObservacionesInformeFinalCurso();

        if( id_PruebaEntrada != null){
            negoObserva.EliminarObservaInfoFinalTodo(id[0]);
        }
        
        ArrayList<String> datosObservaciones = new ArrayList<>();
    //    ArrayList<String> datosObservacionesP4 = new ArrayList<>();

        Enumeration parameterListObs = request.getParameterNames();
        while( parameterListObs.hasMoreElements() )
        {
          String sName = parameterListObs.nextElement().toString();
          if(sName.toLowerCase().startsWith("obs")){
            datosObservaciones.add(request.getParameter(sName));
          }
        }  

        String materal = request.getParameter("usoAulamaterialcurso") != null ? "Material del Curso" : "No";
        String foros = request.getParameter("usoAulaforos") != null ? "Foros" : "No";
        String cuestionarios = request.getParameter("usoAulacuestionarios") != null ? "Cuestionarios" : "No";
        String examenes = request.getParameter("usoAulaexamenesvirtuales") != null ? "Examenes Virtuales" : "No";
        String tareas = request.getParameter("usoAulatareasencargadas") != null ? "Tareas Encargadas" : "No";
        String ppt = request.getParameter("usoAulaslideshow") != null ? "Presentaciones" : "No";
        String total = materal + "," + foros + "," + cuestionarios + "," + examenes + "," + tareas + "," + ppt;

        int p = 1;
        String da[] = new String[9];
        int idObs = 1;
        int i = 0;
        for ( i = 0; i < datosObservaciones.size(); i++) {
            entiObserva.setIdObservaciones(idObs);
            entiObserva.setIdinformefinalcurso(Integer.parseInt(id[0]));
            if (idObs == 4) {
                da[i] = total;
                entiObserva.setDescripcion(total);
                i--;
            }
            else{
                da[i] = datosObservaciones.get(i);
                entiObserva.setDescripcion(datosObservaciones.get(i));
            }

            idObs++;
            negoObserva.AgregarPruebaEntrada(entiObserva);
        }

        /* fin recibir */

        /* guardar datos observaciones */
        try {
            negoObserva.cst.close();
            negoObserva.conexion.close();
        } catch (Exception e) {
        }
        /* fin de guardar datos observaciones */
    }

%>
