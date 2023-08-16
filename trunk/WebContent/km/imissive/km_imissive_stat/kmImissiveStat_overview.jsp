<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="/sys/ui/jsp/common.jsp"%>
<template:include  ref="default.simple" sidebar="no" spa="true">
	<template:replace name="body">
	<link type="text/css" rel="stylesheet" href="${LUI_ContextPath}/km/imissive/resource/css/overview.css?s_cache=${LUI_Cache}"/>
	<script type="text/javascript">
		seajs.use(['theme!module']);
		
		function loadSummaryCount(){
			$.ajax({     
			     url:"${LUI_ContextPath}/km/imissive/km_imissive_send_main/kmImissiveSendMain.do?method=findByStatusCount",     
			     async:true,
			     dataType : 'json',
			     success:function(data){
			    	 $("#stat_docStatus20").html(data.docStatus20);
			    	 $("#stat_docStatus30").html(data.docStatus30);
			    	 $("#stat_docStatus41").html(data.docStatus41);
			    	 $("#stat_docStatus00").html(data.docStatus00);
			    	 
			  	 }
		    });
		}

		function clickHref(status) {
			var paramObj = {};
			switch (status) {
				case "/stat_docStatus20":
					paramObj.cri = {'cri.q': 'docStatus:20'};
					break;
				case "/stat_docStatus30":
					paramObj = getThisMonthIntervalCri("docPublishTime");
					paramObj.cri["cri.q"] += ";docStatus:30";
					break;
				case "/stat_docStatus41":
					paramObj = getThisMonthIntervalCri("fdFilingTime");
					break;
				case "/stat_docStatus00":
					paramObj.cri = {'cri.q': 'discardStat:1'};
					break
				default :
					break;
			}
			window.parent.newPageWithParam(status, paramObj);
		}

		/**
		 * 获取本月到现在的时间区间筛选
		 */
		function getThisMonthIntervalCri(dateType) {
			var currentDate = new Date();
			var year = currentDate.getFullYear();
			var month = currentDate.getMonth() + 1;
			var day = currentDate.getDate();
			var beginningMonth;
			var today;
			beginningMonth = year + "-";
			today = year + "-";
			if (month < 10) {
				month = "0" + month;
			}
			beginningMonth += month + "-";
			today += month + "-";
			if (day < 10) {
				day = "0" + day;
			}
			beginningMonth += "01";
			today += day;
			var criObj = {};
			criObj.cri = {'cri.q': dateType + ':' + beginningMonth + ';' + dateType + ':' + today};
			return criObj;
		}
		
		function setCurrTimeVal(type){
			 var url = "/km/imissive/km_imissive_stat/kmImissiveStat.do?method=getChartByType";
			//加载图标数据
			LUI('chart_'+type).replaceDataSource({
				"type":"AjaxJson",
				"commitType":"post",
				"params":{
					fdDate:$("*[name='fdDate_"+type+"']").val(),
					type:type
				},
				"url":url
			});
		}
		
		window.onload=function(){
			if(document.body.clientWidth==0){
				var url = '${LUI_ContextPath}/km/imissive/km_imissive_stat/kmImissiveStat_overview.jsp';
				LUI.pageOpen(url, '_self');
			}
			loadSummaryCount();
		}
	</script>

	  <ui:tabpanel layout="sys.ui.tabpanel.list">
		  <ui:content title="${lfn:message('km-imissive:tree.preview') }">
		  <div class="head_div_wrap">
				<div class="head_div_box" onclick="clickHref('/stat_docStatus20');">
					<div class="item">
						<span class="head_div_box_number" id="stat_docStatus20">0</span>
						<span class="head_div_box_text">流转中</span>
					</div>
				</div>
				<div class="head_div_box" onclick="clickHref('/stat_docStatus30');">
					<div class="item">
						<span class="head_div_box_number" id="stat_docStatus30">0</span>
						<span class="head_div_box_text">本月办结</span>
					</div>
				</div>
				<div class="head_div_box" onclick="clickHref('/stat_docStatus41');">
					<div class="item">
						<span class="head_div_box_number" id="stat_docStatus41">0</span>
						<span class="head_div_box_text">本月归档</span>
					</div>
				</div>
				<div class="head_div_box" onclick="clickHref('/stat_docStatus00');">
					<div class="item">
						<span class="head_div_box_number" id="stat_docStatus00">0</span>
						<span class="head_div_box_text">本月废弃</span>
					</div>
				</div>
		</div>
			
		<table width="100%" class="lui_hr_staff_overview_card_frame">
			<tr>
				<td colspan="4" align="center">
					<div class="lui_hr_staff_panel_overview_frame">
					<div class="lui_hr_staff_panel_title">
						<kmss:period property="fdDate_type" periodTypeValue="1" value=""  onChangeExAfter="setCurrTimeVal('type');"/>
						<span class="panel_title"><bean:message key="kmImissiveStat.overview.type" bundle="km-imissive"/></span>
					</div>
					<div class="lui_hr_staff_panel_content">
						<ui:chart width="100%" height="350px" id="chart_type">
		  					<ui:source type="AjaxJson">
								{"url":"/km/imissive/km_imissive_stat/kmImissiveStat.do?method=getChartByType&type=type"}
		  					</ui:source>
						</ui:chart>
					</div>
					</div>
				</td>
				<td colspan="4" align="center">
					<div class="lui_hr_staff_panel_overview_frame">
					<div class="lui_hr_staff_panel_title">
						<kmss:period property="fdDate_num" periodTypeValue="5" value="" onChangeExAfter="setCurrTimeVal('num');"/>
						<span class="panel_title"><bean:message key="kmImissiveStat.overview.num" bundle="km-imissive"/></span>
					</div>
					<div class="lui_hr_staff_panel_content">
						<ui:chart width="100%" height="350px" id="chart_num">
		  					<ui:source type="AjaxJson">
								{"url":"/km/imissive/km_imissive_stat/kmImissiveStat.do?method=getChartByType&type=num"}
		  					</ui:source>
						</ui:chart>
					</div>
					</div>
				</td>
			</tr>
			<tr>
				<td colspan="4" align="center">
					<div class="lui_hr_staff_panel_overview_frame">
					<div class="lui_hr_staff_panel_title">
						<kmss:period property="fdDate_emergency" periodTypeValue="3" value="" onChangeExAfter="setCurrTimeVal('emergency');"/>
						<span class="panel_title"><bean:message key="kmImissiveStat.overview.emergency" bundle="km-imissive"/></span>
					</div>
						<ui:chart width="100%" height="350px" id="chart_emergency">
		  					<ui:source type="AjaxJson">
								{"url":"/km/imissive/km_imissive_stat/kmImissiveStat.do?method=getChartByType&type=emergency"}
		  					</ui:source>
						</ui:chart>
					</div>
				</td>
				<td colspan="4" align="center">
					<div class="lui_hr_staff_panel_overview_frame">
					<div class="lui_hr_staff_panel_title">
						<kmss:period property="fdDate_status" periodTypeValue="1" value="" onChangeExAfter="setCurrTimeVal('status');"/>
						<span class="panel_title"><bean:message key="kmImissiveStat.overview.status" bundle="km-imissive"/></span>
					</div>
					<ui:chart width="100%" height="350px" id="chart_status">
	  					<ui:source type="AjaxJson">
							{"url":"/km/imissive/km_imissive_stat/kmImissiveStat.do?method=getChartByType&type=status"}
	  					</ui:source>
					</ui:chart>
					</div>
				</td>
			</tr>
		</table>
	</ui:content>
</ui:tabpanel>
	</template:replace>
</template:include>
