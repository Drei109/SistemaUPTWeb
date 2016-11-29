<%@page import="net.sf.jasperreports.engine.export.JRXlsExporterParameter"%>
<%@page import="net.sf.jasperreports.engine.export.JRXlsExporter"%>
<%@page import="java.io.ByteArrayOutputStream"%>
<%@page import="java.io.OutputStream"%>
<%@page import="net.sf.jasperreports.engine.export.JRHtmlExporterParameter"%>
<%@page import="net.sf.jasperreports.engine.JRExporterParameter"%>
<%@page import="net.sf.jasperreports.engine.export.JRHtmlExporter"%>
<%@page import="net.sf.jasperreports.engine.JasperManager"%>
<%@page import="net.sf.jasperreports.engine.JRExporter"%>
<%@page import="java.util.Map"%>
<%@page import="java.util.HashMap"%>
<%@page import="net.sf.jasperreports.engine.JRException"%>
<%@page import="java.io.FileNotFoundException"%>
<%@page import="net.sf.jasperreports.engine.JasperExportManager"%>
<%@page import="net.sf.jasperreports.engine.JasperPrint"%>
<%@page import="net.sf.jasperreports.engine.JasperReport"%>
<%@page import="net.sf.jasperreports.engine.JasperFillManager"%>
<%@page import="net.sf.jasperreports.engine.JasperCompileManager"%>
<%@page import="java.io.InputStream"%>
<%@page import="java.io.FileInputStream"%>
<%@page import="java.io.File"%>
<%@page import="Conexion.ClsConexion"%>
<%@page import="java.sql.Connection"%>

<%
//    Connection cnx = null;
    String doctype = request.getParameter("doctype");
    String id_InformeFinal = request.getParameter("id_InformeFinal");
    Connection cnx = null;
    Map p = new HashMap();
    p.put("ID", Integer.parseInt(id_InformeFinal));
//    String ruta = session.getServletContext().getRealPath("/");
    
    
    if (doctype.equals("pdf")) {
        try {
            cnx = new ClsConexion().getConnection();

            File f = new File(session.getServletContext().getRealPath("/rpt/RptInformeFinalCurso.jrxml"));

            InputStream input = new FileInputStream(f);
            response.setContentType("application/pdf");

            JasperReport Report = JasperCompileManager.compileReport(input);
            JasperPrint Print = JasperFillManager.fillReport(Report, p,cnx);

            JasperExportManager.exportReportToPdfStream(Print, response.getOutputStream());

        } catch (FileNotFoundException e) {
            e.printStackTrace();
        } 
        catch (JRException e){
            e.printStackTrace();
        }
        finally{
            if(cnx!=null){
                cnx.close();
            }
        }
        
    }
    else if(doctype.equals("html")){
        response.setContentType("text/html");
        JasperReport js;
        JasperPrint jp;
        JRExporter exporter=null;
        try{
            cnx = new ClsConexion().getConnection();

            File f = new File(session.getServletContext().getRealPath("/rpt/RptInformeFinalCurso.jrxml"));

            InputStream input = new FileInputStream(f);
            
            
            js = JasperCompileManager.compileReport(input);
            jp = JasperFillManager.fillReport(js, p,cnx);
            
        
            exporter = new JRHtmlExporter();
            exporter.setParameter(JRExporterParameter.JASPER_PRINT,jp);
            exporter.setParameter(JRExporterParameter.OUTPUT_WRITER,response.getWriter());
//            exporter.setParameter(JRHtmlExporterParameter.IMAGES_URI, request.getContextPath() + "/image?image=");
            exporter.setParameter(JRHtmlExporterParameter.IS_USING_IMAGES_TO_ALIGN, Boolean.FALSE);            
            
            if(exporter!=null){
                exporter.exportReport();
            }else{
                %><h1>:(</h1><%
            }
        }
        catch(Exception e){
        
        }
    }
    else if(doctype.equals("xls")){
        response.setContentType("text/html");
        JasperReport js;
        JasperPrint jp;
        JRExporter exporter=null;
        try{
            cnx = new ClsConexion().getConnection();

            File f = new File(session.getServletContext().getRealPath("/rpt/RptInformeFinalCurso.jrxml"));

            InputStream input = new FileInputStream(f);
            
            
            js = JasperCompileManager.compileReport(input);
            jp = JasperFillManager.fillReport(js, p,cnx);
            OutputStream output = response.getOutputStream();
        
            ByteArrayOutputStream arrayOutputStream = new ByteArrayOutputStream();
            JRXlsExporter exporterXLS = new JRXlsExporter();                

            exporterXLS.setParameter(JRXlsExporterParameter.JASPER_PRINT, jp);
            exporterXLS.setParameter(JRXlsExporterParameter.OUTPUT_STREAM, arrayOutputStream);
            exporterXLS.setParameter(JRXlsExporterParameter.IS_ONE_PAGE_PER_SHEET, Boolean.FALSE);
            exporterXLS.setParameter(JRXlsExporterParameter.IS_DETECT_CELL_TYPE, Boolean.TRUE);
            exporterXLS.setParameter(JRXlsExporterParameter.IS_WHITE_PAGE_BACKGROUND, Boolean.FALSE);
            exporterXLS.setParameter(JRXlsExporterParameter.IS_REMOVE_EMPTY_SPACE_BETWEEN_ROWS, Boolean.TRUE);
            exporterXLS.exportReport();

            response.setHeader("Content-disposition", "attachment; filename=reporte.xls");
            response.setContentType("application/vnd.ms-excel");
            response.setContentLength(arrayOutputStream.toByteArray().length);
            output.write(arrayOutputStream.toByteArray());
            output.flush();
            output.close();
        }
        catch(Exception e){
        
        }
    }

    
%>