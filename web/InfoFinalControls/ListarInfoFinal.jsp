<%@page import="Negocio.ClsNegocioObservacionesInformeFinalCurso"%>
<%@page import="Entidad.ClsEntidadCacidadInformeFinalCurso"%>
<%@page import="Negocio.ClsNegocioCapadidadInformeFinalCurso"%>
<%@page import="Negocio.ClsNegocioInformeFinalCurso"%>
<%@page import="Entidad.ClsEntidadPruebaCursosFaltantes"%>
<%@page import="java.util.Iterator"%>
<%@page import="Negocio.ClsNegocioPruebaEntrada"%>
<%@page import="java.util.ArrayList"%>
<%
    String codDocente = String.valueOf(request.getSession().getAttribute("codDocente"));
    String nivelUsuario = String.valueOf(request.getSession().getAttribute("nivelUsuario"));   
    String busqueda = "Prueba Entrada";
    String idCurso = request.getParameter("id_Curso");
    String idInfoFinal = request.getParameter("id_Final");
    
    String campo[]  = new String[11];
    String campo2[] = new String[25];
    String campo3[] = new String[10];
    String campo4[] = new String[9];
    ArrayList<String> da = new ArrayList<>();
    String pu = "nada";
    
    int pa = 0;
    if (idCurso != null) {
        ArrayList<ClsNegocioPruebaEntrada> dato = null;
        ClsNegocioPruebaEntrada datos = new ClsNegocioPruebaEntrada();
        dato = datos.hacerInformePruebaFaltante(codDocente,"Informe Final Curso");
        Iterator iterator = dato.iterator();
            
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
        
    }
    else if(idInfoFinal != null){
        ClsNegocioInformeFinalCurso negNegocioPruebaEntrada = new ClsNegocioInformeFinalCurso();
        ArrayList<String> pruebaEntrada = negNegocioPruebaEntrada.seleccionarInforCurso(idInfoFinal);
        campo2 = pruebaEntrada.toArray(new String[pruebaEntrada.size()]);
        
        
        ClsNegocioCapadidadInformeFinalCurso detalleInfoFinal = new ClsNegocioCapadidadInformeFinalCurso();
        ArrayList<ClsEntidadCacidadInformeFinalCurso> detalle = detalleInfoFinal.seleccionarDetalleInfoFinal(idInfoFinal);
                
        
        for (ClsEntidadCacidadInformeFinalCurso elem : detalle) {
            da.add( String.valueOf(elem.getIdcapacidad()) );
            da.add( elem.getDescripcion() );
            da.add( String.valueOf(elem.getIdnivelcapacidad()) );
            da.add( String.valueOf(elem.getIdinformefinalcurso()) );
            da.add( elem.getMedidaCorectiva() );
        }
        campo3 = da.toArray(new String[da.size()]);
        
        ClsNegocioObservacionesInformeFinalCurso negoObserva =  new ClsNegocioObservacionesInformeFinalCurso();
        ArrayList<String> negoobs = negoObserva.ListarObservacionesID(idInfoFinal);
        campo4 = negoobs.toArray(new String[negoobs.size()]);
        
    }
    
    if (idCurso != null) {
        request.setAttribute("campo", campo);
        request.getRequestDispatcher("../informeFinal.jsp?id_Curso="+idCurso).forward(request, response);
    }
    else if(idInfoFinal != null){
        request.setAttribute("campo2", campo2);
        request.setAttribute("campo3", campo3);
        request.setAttribute("campo4", campo4);
        request.getRequestDispatcher("../informeFinal.jsp?id_PruebaEntrada="+idInfoFinal).forward(request, response);
    }
%>
