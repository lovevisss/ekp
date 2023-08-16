<%@page import="com.landray.kmss.sys.webservice2.util.SysWsUtil"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/sys/ui/jsp/common.jsp"%>
<template:replace name="content">
 <link rel="Stylesheet" href="${LUI_ContextPath}/km/imissive/resource/css/att.css?s_cache=${MUI_Cache}" />
    <html:form action="/km/imissive/km_imissive_send_main/kmImissiveSendMain.do"> 
    	<%-- 网页签章(首先判断是否启用了网页签章) --%>
    	<c:if test="${JGSignatureHTMLEnabled == 'true'}">
			<%
				String projectServerURL = SysWsUtil.getUrlPrefix(request);
				String mServerUrl=projectServerURL+"/km/imissive/iSignatureHTML/Service.jsp";
			  	request.setAttribute("jgHtmlSigVersion",JgWebOffice.getJGVersion("signaturehtml"));
			  	String signatureHtmlUrl = ResourceUtil.getKmssConfigString("sys.att.jg.signaturehtmlurl");
			  	if (StringUtil.isNull(signatureHtmlUrl)) {
			  		request.setAttribute("jgHtmlSigUrl",projectServerURL + JgWebOffice.getJGDownLoadUrl("signaturehtml"));
			  	} else {
			  		request.setAttribute("jgHtmlSigUrl",signatureHtmlUrl);
			  	}
			%>
	    	<span id="processNodeId" style="display: none;"><kmss:showWfPropertyValues idValue="${kmImissiveSendMainForm.fdId}" propertyName="handerNameDetail" /></span>
	    	<input type="hidden" name="DOCUMENTID" value="${kmImissiveSendMainForm.fdId }">
	    	<OBJECT id="SignatureControl"   classid="clsid:D85C89BE-263C-472D-9B6B-5264CD85B36E"  codebase="${jgHtmlSigUrl }#version=${jgHtmlSigVersion }" width=0 height=0>
				<param name="ServiceUrl" value="<%=mServerUrl%>"><!--读去数据库相关信息-->
				<param name="PrintControlType" value=2>               <!--打印控制方式（0:不控制  1：签章服务器控制  2：开发商控制）-->
			</OBJECT>	
		</c:if>   	
       <kmss:showWfPropertyValues  var="nodevalue" idValue="${kmImissiveSendMainForm.fdId}" propertyName="nodeName" />
       <ui:tabpage expand="false" >
	       <c:if test="${kmImissiveSendMainForm.docStatus == '30'}">
		         <%if("content".equals(KmImissiveConfigUtil.getDiplayOrder())){ %>
		              <ui:content title="${ lfn:message('km-imissive:kmImissiveSendMain.docContent') }" expand="${expandContent}">
					 	 <jsp:include page="/km/imissive/km_imissive_send_main/kmImissiveSendMain_content.jsp"></jsp:include>
					  </ui:content>
					  <ui:content id="kmImissiveSendMain_baseinfo" title="${ lfn:message('km-imissive:kmImissiveSendMain.baseinfo') }" expand="${expandBaseInfo}">
					  	<c:import url="/km/imissive/km_imissive_send_main/kmImissiveSendMain_baseInfo.jsp" charEncoding="UTF-8">
					  		<c:param name="formName" value="kmImissiveSendMainForm" />
					  	</c:import>
					  	<c:import url="/km/imissive/km_imissive_send_main/kmImissiveSendMain_relateInfo.jsp" charEncoding="UTF-8">
					  		<c:param name="formName" value="kmImissiveSendMainForm" />
					  	</c:import>
					  </ui:content>
				  <%}else{ %>
					  <ui:content id="kmImissiveSendMain_baseinfo" title="${ lfn:message('km-imissive:kmImissiveSendMain.baseinfo') }" expand="${expandBaseInfo}">
					    	<c:import url="/km/imissive/km_imissive_send_main/kmImissiveSendMain_baseInfo.jsp" charEncoding="UTF-8">
						  		<c:param name="formName" value="kmImissiveSendMainForm" />
						  	</c:import>
						  	<c:import url="/km/imissive/km_imissive_send_main/kmImissiveSendMain_relateInfo.jsp" charEncoding="UTF-8">
						  		<c:param name="formName" value="kmImissiveSendMainForm" />
						  	</c:import>
						  	<div class="lui_form_content_frame" style="padding-top: 10px">
								<table class="tb_normal" width="100%">
									<html:hidden property="fdNeedContent" value="1"/>
									<tr>
										<td colspan="4">
											<ui:button id="ok_ck" text="查看正文" order="2"  onclick="openDoc();">
											</ui:button>
											<ui:button id="ok_bj" text="编辑正文" order="2"  onclick="openEditDoc();">
											</ui:button>
										</td>
									</tr>
								</table>
							</div>
					  </ui:content>
					 
				  <%} %>
			</c:if>  
			<c:if test="${kmImissiveSendMainForm.docStatus != '30'}">
				  <ui:content id="kmImissiveSendMain_baseinfo" title="${ lfn:message('km-imissive:kmImissiveSendMain.baseinfo') }" expand="${expandBaseInfo}">
				    <c:import url="/km/imissive/km_imissive_send_main/kmImissiveSendMain_baseInfo.jsp" charEncoding="UTF-8">
				  		<c:param name="formName" value="kmImissiveSendMainForm" />
				  	</c:import>
				  	<c:import url="/km/imissive/km_imissive_send_main/kmImissiveSendMain_relateInfo.jsp" charEncoding="UTF-8">
				  		<c:param name="formName" value="kmImissiveSendMainForm" />
				  	</c:import>
				  	<div class="lui_form_content_frame" style="padding-top: 10px">
						<table class="tb_normal" width="100%">
							<html:hidden property="fdNeedContent" value="1"/>
							<tr>
								<td colspan="4">
									<ui:button id="ok_ck" text="查看正文" order="2"  onclick="openDoc();">
									</ui:button>
									<ui:button id="ok_bj" text="编辑正文" order="2"  onclick="openEditDoc();">
									</ui:button>
								</td>
							</tr>
						</table>
					</div>
				  </ui:content>
			</c:if>
	<!-- 以下代码为嵌入流程模板标签的代码 -->
	<kmss:auth requestURL="/km/imissive/km_imissive_send_main/kmImissiveSendMain.do?method=readViewLog&fdId=${kmImissiveSendMainForm.fdId}" requestMethod="GET">
		<c:import url="/sys/workflow/import/sysWfProcess_view.jsp"
			charEncoding="UTF-8">
			<c:param name="formName" value="kmImissiveSendMainForm" />
			<c:param name="fdKey" value="sendMainDoc" />
			<c:param name="showHistoryOpers" value="true" />
			<c:param name="isSimpleWorkflow" value="false" />
			<c:param name="onClickSubmitButton" value="Com_submitReview();" />
		</c:import>
	</kmss:auth>
	<c:import url="/km/imissive/km_imissive_send_main/kmImissiveSendMain_import.jsp" charEncoding="UTF-8">
		<c:param name="formName" value="kmImissiveSendMainForm" />
	</c:import>	
	<!-- 督办 -->
	<kmss:ifModuleExist path="/km/supervise/">
		<c:import url="/km/supervise/import/kmSuperviseMain_edit.jsp"
			charEncoding="UTF-8">
			<c:param name="fdModelId" value="${kmImissiveSendMainForm.fdId}" />
			<c:param name="fdModelName"
				value="com.landray.kmss.km.imissive.model.KmImissiveSendMain" />
		</c:import>
	</kmss:ifModuleExist>
</ui:tabpage>
</html:form>
<%@include file="/km/imissive/km_imissive_send_main/kmImissiveSendMain_viewScript.jsp"%>
<script>
$(document).ready(function(){
	
	//解决非ie下控件高度问题
	var obj1 = document.getElementById("JGWebOffice_editonline");
	var obj2 = document.getElementById("JGWebOffice_mainonline");
	if(obj1){
		obj1.setAttribute("height", "550px");
	}
	if(obj2){
		obj2.setAttribute("height", "550px");
	}
	//解决非ie下控件高度问题
	//如果没有会签字段则不显示会签记录
	var fdCounterSignDeptNames = document.getElementsByName("counterSignDeptFlag");
	if(fdCounterSignDeptNames.length<1 && document.getElementById("signDeptTr")){ 
		document.getElementById("signDeptTr").style.display="none";
	}
	
	$(".com_approval_bar2").bind('click', function(event) {
		var tab = LUI('kmImissiveSendMain_baseinfo');
		if (tab != null) {
			if (!tab.isShow) {
				var panel = tab.parent;
				$.each(panel.contents, function(i) {
					if (this == tab) {
						panel.onToggle(i, false, false);
						return false;
					}
				});
			}
		}
		$('html, body').animate({
	        scrollTop: $("#descriptionRow").offset().top - 200 
	    }, 800); // scrollIntoView
	});
});


</script>
</template:replace>
<template:replace name="nav">
    <%--关联机制 --%>
		<c:import url="/sys/relation/import/sysRelationMain_view.jsp" charEncoding="UTF-8">
			<c:param name="formName" value="kmImissiveSendMainForm" />
		</c:import>
	<!-- 关联机制 -->
</template:replace>