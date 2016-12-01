<%-- 
    Document   : reportesFaltantes
    Created on : 14-nov-2016, 20:52:58
    Author     : Drei
--%>
<%@page import="java.sql.ResultSet"%>
<%@page import="Entidad.ClsEntidadPruebaCursosFaltantes"%>
<%@page import="java.util.Iterator"%>
<%@page import="java.util.ArrayList"%>
<%@page import="Negocio.ClsNegocioPruebaEntrada"%>
<%@include file="header.jsp" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>


<%
    String tipoInforme = "";
    String tipoGrafico = "";
    if (request.getParameter("tipoInforme")!= null && request.getParameter("tipoGrafico") != null) {
            tipoInforme = request.getParameter("tipoInforme");
            tipoGrafico = request.getParameter("tipoGrafico");
        }
    ResultSet rs = null;
    ClsNegocioPruebaEntrada negocio = new ClsNegocioPruebaEntrada();

    String dataPie = "";
%>
<head>
    <title>Imprimir Reportes</title>
</head>
<body class="background-gray">
    
    <script src="js/charts/highcharts2.js"></script>
    <script src="js/charts/funnel.js"></script>
    <script src="js/charts/exporting2.js"></script>
    
        <div class="container body-padding">
            <div class="row">
                <form action="" method="post" class="form-reporte shadow">
                    <fieldset>
                        <div class="form-group">
                            <h2>Imprimir Reportes</h2>
                        </div>
                        <div class="form-group">
                            <%
                                if (tipoInforme.equals("Prueba Entrada")) {
                                    rs = negocio.verInformesTotalesGraficos(tipoInforme);
                                    
                                    if (tipoGrafico.equals("Pie")) {
                                        
                                        while (rs.next()){
                                            String name = rs.getString(1);
                                            String valor = rs.getString(2);
                                            dataPie += "{ name: '" + name + "', y: " + valor + "}, ";
                                        }
                                        
                                        %>
                                        <h1>PE</h1>
                                        <div id="graficoPie">                                            
                                        </div>
                                        <%
                                    } else {
                                    }
                                } 
                                else if (tipoInforme.equals("Informe Final Curso")){
                                    rs = negocio.verInformesTotalesGraficos(tipoInforme);
                                    
                                    if (tipoGrafico.equals("Pie")) {
                                        
                                        while (rs.next()){
                                            String name = rs.getString(1);
                                            String valor = rs.getString(2);
                                            dataPie += "{ name: '" + name + "', y: " + valor + "}, ";
                                        }
                                        
                                        %>
                                        <h1>IF</h1>
                                        <div id="graficoPie">                                            
                                        </div>
                                        <%
                                    } else {
                                    }
                                    
                                }
                                else if (tipoInforme.equals("")){
                                    
                                }
                            %>
                            <a href="#documento"><input type="submit" class="btn btn-default" name="pdf" value="Ver en PDF"></a>
                            <input type="submit" class="btn btn-default" name="html" value="Ver en HTML">
                            <input type="submit" class="btn btn-default" name="xls" value="Descargar en Excel">
                        </div>
                    </fieldset>
                </form>
            </div>
        </div>        
    </body>
    <script>
    $(function () {
        $(document).ready(function () {
            // Build the chart
            Highcharts.chart('graficoPie', {
                chart: {
                    plotBackgroundColor: null,
                    plotBorderWidth: null,
                    plotShadow: false,
                    type: 'pie'
                },
                title: {
                    text: 'Reporte de Control - Informes de Prueba de Entrada'
                },
                tooltip: {
                    pointFormat: '{series.name}: <b>{point.percentage:.1f}%</b>'
                },
                plotOptions: {
                    pie: {
                        allowPointSelect: true,
                        cursor: 'pointer',
                        dataLabels: {
                            enabled: false
                        },
                        showInLegend: true
                    }
                },
                series: [{
                    name: 'Brands',
                    colorByPoint: true,
                    data: [<%=dataPie%>]
                }]
            });
        });
    });
    </script>
</html>

