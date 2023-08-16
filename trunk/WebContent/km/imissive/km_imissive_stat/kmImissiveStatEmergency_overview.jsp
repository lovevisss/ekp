<%@ page language="java" contentType="text/json; charset=UTF-8"	pageEncoding="UTF-8"%>
<%@ include file="/sys/ui/jsp/common.jsp"%>

<ui:chart-data gridMargin="80 110 80 40" text="${result.title.text}"  xAxisData="${result.xAxis[0].data}" xAxisShowAll="true" xAxisRotate="-90" yAxisName="${result.yAxis[0].name}" legendPosition="hidden">
	
	<ui:chart-property name="title.x" value="center"></ui:chart-property>
	<ui:chart-property name="title.y" value="top"></ui:chart-property>
	
	<ui:chart-property name="toolbox" merge="false">
		{
			"show" : true,
			"right" : "20px",
	        "feature" : {
	           "dataZoom" : {"show" : false},
	           "restore" : {"show": true},
	           "saveAsImage" : {"show": true},
	           "dataTableView":{
	           		"show":true,
	           		"title":"${lfn:message('km-imissive:kmImissiveStat.stat.section.switch')}",
	           		"icon":"${LUI_ContextPath}/km/imissive/resource/images/switch.png"
	           }
	        }
		}
	</ui:chart-property>
	<ui:chart-property name="toolbox.feature.dataTableView.onclick" isScript="true" merge="true">
		function(){
			stat.switchChart("1");
		}
	</ui:chart-property>
	<c:forEach var="item" items="${result.seriesData}">
		<ui:chart-series name="${item.name}" type="${item.type}"  data="${item.data}" stack="${item.stack}">
			<ui:chart-property name="label" merge="true">
		 	 {
                "normal": {
                    "show": true,
                    "position": "inside"
                }
             }
            </ui:chart-property>
		</ui:chart-series>
	</c:forEach>
</ui:chart-data>