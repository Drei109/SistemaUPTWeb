/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Servlet;

import Entidad.ClsEntidadCacidadInformeFinalCurso;
import Entidad.ClsEntidadInformeFinalCurso;
import Entidad.ClsEntidadObservaFinalCurso;
import Negocio.ClsNegocioCapadidadInformeFinalCurso;
import Negocio.ClsNegocioInformeFinalCurso;
import Negocio.ClsNegocioObservacionesInformeFinalCurso;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 *
 * @author enzocv
 */
public class agregarInforme extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet agregarInforme</title>");            
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet agregarInforme at " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
        
        /* recibir los datos Principal */
        ClsEntidadInformeFinalCurso entiInfoFinal = new ClsEntidadInformeFinalCurso();
        ClsNegocioInformeFinalCurso negoInfoFinal = new ClsNegocioInformeFinalCurso();
        
        
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
        
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
