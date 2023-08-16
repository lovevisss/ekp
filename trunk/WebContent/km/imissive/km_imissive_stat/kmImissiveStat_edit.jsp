<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="/sys/ui/jsp/common.jsp"%>
<%@page import="com.landray.kmss.framework.plugin.core.config.IExtension"%>
<%@page import="com.landray.kmss.km.imissive.util.KmImissiveStatExecutorPlugin"%>
<%@page import="com.landray.kmss.util.StringUtil"%>
<%
	String fdType=(String)request.getParameter("type");
	IExtension ext=KmImissiveStatExecutorPlugin.getExtensionForStat(fdType);
	if(ext!=null){
		if(StringUtil.isNotNull(KmImissiveStatExecutorPlugin.getConditionJsp(ext))){
			request.setAttribute("conditionUrl", KmImissiveStatExecutorPlugin.getConditionJsp(ext));
		}
		if(StringUtil.isNotNull(KmImissiveStatExecutorPlugin.getExtJs(ext))){
			request.setAttribute("extJs", KmImissiveStatExecutorPlugin.getExtJs(ext));
		}
	}
%>
<template:include ref="default.edit" sidebar="no">
	<%--标签页标题--%>
	<template:replace name="title">
		<c:choose>
			<c:when test="${ kmImissiveStatForm.method_GET == 'add' }">
				<c:out value="新建统计 - ${ lfn:message('km-imissive:module.km.imissive') }"></c:out>	
			</c:when>
			<c:otherwise>
				<c:out value="${kmImissiveStatForm.docSubject} - ${ lfn:message('km-imissive:module.km.imissive') }"></c:out>
			</c:otherwise>
		</c:choose>
	</template:replace>
	<template:replace name="head">
		<script language="JavaScript">
			Com_IncludeFile("validator.jsp|validation.js|plugin.js|validation.jsp|xform.js|jquery.js|dialog.js|calendar.js", null, "js");
			Com_IncludeFile("unitDialog.js", Com_Parameter.ContextPath+ "km/imissive/resource/js/", "js", true);
			Com_IncludeFile("sysUnitDialog.js", Com_Parameter.ContextPath+ "sys/unit/resource/js/", "js", true);
			seajs.use("${LUI_ContextPath}/km/imissive/resource/css/stat.css");
			seajs.use(["${LUI_ContextPath}/km/imissive/km_imissive_stat/resource/js/stat.js"],function(stat){
				window.stat = stat;
			});
			LUI.ready(function(){
				$("#div_condtionSection").attr("isShow","0");
				window.stat.expandDiv($("#div_condtionArea .div_titleArea"),'div_condtionSection');
			});
		</script>
	</template:replace>
	
	<%--操作按钮--%>
	<template:replace name="toolbar">
		<ui:toolbar id="toolbar" layout="sys.ui.toolbar.float">
				<ui:button text="${lfn:message('km-imissive:kmImissiveStat.opt.saveAndView')}"
					onclick="submitMethod(document.kmImissiveStatForm, 'save');">
				</ui:button>
			<%--关闭--%>
			<ui:button text="${lfn:message('button.close')}" order="5" onclick="Com_CloseWindow();">
			</ui:button>
		</ui:toolbar>
	</template:replace>
	
	<%--导航路径--%>
	<template:replace name="path">
		<ui:menu layout="sys.ui.menu.nav" style="height:40px;line-height:40px;">
			<ui:menu-item text="${ lfn:message('home.home') }" icon="lui_icon_s_home">
			</ui:menu-item>
			<ui:menu-item text="${ lfn:message('km-imissive:module.km.imissive') }" >
			</ui:menu-item>
		</ui:menu>
	</template:replace>	
	
	<%--任务分析表单--%>
	<template:replace name="content"> 
		<script type="text/javascript">
			Com_IncludeFile("dialog.js");
			seajs.use(['lui/jquery','lui/dialog'], function($,dialog) {
				window.validateFormData = function(){
					var flag = true;
					var analyzeStartDate = document.getElementsByName("fdStartDate")[0].value;
					var analyzeEndDate = document.getElementsByName("fdEndDate")[0].value;
					if(analyzeStartDate > analyzeEndDate){
						dialog.alert('${lfn:message("km-imissive:kmImissiveStat.compareTime.tip")}');
						flag = false;
					}
					
					if("${JsParam.type}" == '3'){
						var dateQueryTypeList;
						var fdMainType;
						var fdMainTypeDom = document.getElementsByName("fdMainType");
						for(var i = 0;i<fdMainTypeDom.length;i++){
							if(fdMainTypeDom[i].checked){
								fdMainType = fdMainTypeDom[i].value;
							}
						}
						if(fdMainType == '1'){
							dateQueryTypeList = document.getElementsByName("fdDateQueryType");
						}else{
							dateQueryTypeList = document.getElementsByName("fdDateQueryTypeReceive");
						}

						if(analyzeStartDate != undefined || analyzeEndDate != undefined) {
							if(dateQueryTypeList[0].value == ""){
								dialog.alert("<bean:message bundle='km-imissive' key='kmImissive.dateQueryType.message'/>");
								flag = false;
							}
						}
						
					}
					
					return flag;
				};
				
				window.previewFn =  function(){
					if(validateFormData()){
						window.stat.statExecutor();
					}
				};
				
				window.submitMethod = function(form,method){
					if(validateFormData()){
						Com_Submit(form, method);
					}
				};
			});
		</script>
		<html:form action="/km/imissive/km_imissive_stat/kmImissiveStat.do">
			<html:hidden property="fdId"/>
			<html:hidden property="method_GET"/>
			<p class="lui_form_subject">
				<bean:message key="km-imissive:kmImissiveStat.type.${JsParam.type}"/>
			</p>
			<div class="lui_form_content_frame" style="padding-top:20px">
				<%--条件筛选--%>	
				<div id="div_condtionArea">
					<div class="div_section">
						<div class="div_line"></div>
						<div class="div_titleArea"  onclick="window.stat.expandDiv(this,'div_condtionSection');">
							${lfn:message('km-imissive:kmImissiveStat.title.condition') }
							<span class="div_icon_coll"></span>
						</div>
					</div>	
					<c:import url="${conditionUrl}" charEncoding="UTF-8">
						<c:param name="fdType" value="${JsParam.type}"/>
						<c:param name="formName" value="kmImissiveStatForm"/>
						<c:param name="mode" value="edit"></c:param>
					</c:import>
				</div>
				<div id="div_previewArea">
					<ui:button text="${lfn:message('km-imissive:kmImissiveStat.stat.section.preview')}" onclick="previewFn();"></ui:button>
				</div>
				<div id="div_chartArea">
					<div class="div_section">
						<div class="div_line"></div>
						<div class="div_titleArea" onclick="window.stat.expandDiv(this,'div_reportSection');">
							${lfn:message('km-imissive:kmImissiveStat.stat.section.result')}
							<span class="div_icon_exp"></span>
						</div>
					</div>
					<div id="div_reportSection">
						<div id="div_chartSection">
							<%--echart图表--%>
							<ui:chart height="500px" width="1100px;" id="kmImissiveStatChart">
			  					<ui:source type="AjaxJson">
									{"url":""}
			  					</ui:source>
							</ui:chart>
						</div>
						<div id="div_listSection">
							<div id="div_list" class="div_list"></div>
						</div>
					</div>
				</div>
			</div>
		</html:form>
		<script type="text/javascript">
			Com_IncludeFile("validator.jsp|validation.js|plugin.js|validation.jsp|eventbus.js|xform.js",null,"js");
		</script>
		<script type="text/javascript">
		var statValidation  = $KMSSValidation();//加载校验框架
		</script>
	</template:replace>
	
</template:include>