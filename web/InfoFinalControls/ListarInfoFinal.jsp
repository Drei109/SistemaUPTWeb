<%@page import="Entidad.ClsEntidadPruebaCursosFaltantes"%>
<%@page import="java.util.Iterator"%>
<%@page import="Negocio.ClsNegocioPruebaEntrada"%>
<%@page import="java.util.ArrayList"%>
<%
    String codDocente = String.valueOf(request.getSession().getAttribute("codDocente"));
    String nivelUsuario = String.valueOf(request.getSession().getAttribute("nivelUsuario"));   
    String busqueda = "Prueba Entrada";
    String idCurso = request.getParameter("id_Curso");

    

    ArrayList<ClsNegocioPruebaEntrada> dato = null;
    ClsNegocioPruebaEntrada datos = new ClsNegocioPruebaEntrada();
    dato = datos.hacerInformePruebaFaltante(codDocente,"Informe Final Curso");
    Iterator iterator = dato.iterator();
    String campo[] = new String[11];

    if(idCurso!= null){
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

    request.setAttribute("campo", campo);
    request.getRequestDispatcher("../informeFinal.jsp").forward(request, response);
%>
