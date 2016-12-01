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
    String dataBarras = "";
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
                                        
                                        <div id="graficoPie">                                            
                                        </div>
                                        <%
                                    } else {

                                        while (rs.next()){
                                            String name = rs.getString(1);
                                            String valor = rs.getString(2);
                                            dataBarras += "{name: '"+name+"', y: " + valor + ",drilldown: '" + name + "'},";
                                        }
                                        %>                                        
                                        <div id="graficoBarras">                                            
                                        </div>
                                        <%
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
                                        
                                        <div id="graficoPie">                                            
                                        </div>
                                        <%
                                    } else {
                                            while (rs.next()){
                                            String name = rs.getString(1);
                                            String valor = rs.getString(2);
                                            dataBarras += "{name: '"+name+"', y: " + valor + ",drilldown: '" + name + "'},";
                                        }
                                        %>                                        
                                        <div id="graficoBarras">                                            
                                        </div>
                                        <%
                                    }
                                    
                                }
                                else if (tipoInforme.equals("")){
                                    
                                }
                            %>
                            
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
    $(function () {
    // Create the chart
        Highcharts.chart('graficoBarras', {
            chart: {
                type: 'column'
            },
            title: {
                text: 'Control Informes - Prueba Final'
            },
            subtitle: {
                text: ''
            },
            xAxis: {
                type: 'category'
            },
            yAxis: {
                title: {
                    text: 'Total percent market share'
                }

            },
            legend: {
                enabled: false
            },
            plotOptions: {
                series: {
                    borderWidth: 0,
                    dataLabels: {
                        enabled: true,
                        format: '{point.y:.1f}%'
                    }
                }
            },

            tooltip: {
                headerFormat: '<span style="font-size:11px">{series.name}</span><br>',
                pointFormat: '<span style="color:{point.color}">{point.name}</span>: <b>{point.y:.2f}%</b> of total<br/>'
            },

            series: [{
                name: 'Brands',
                colorByPoint: true,
                data: [<%=dataBarras%>]
            }]        
        });
    });
    </script>
</html>

