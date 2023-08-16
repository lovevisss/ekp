<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/sys/ui/jsp/common.jsp"%>
<%@page import="com.landray.kmss.sys.attachment.integrate.wps.util.SysAttWpsCloudUtil"%>
<%@page import="com.landray.kmss.sys.attachment.integrate.wps.util.SysAttWpsCenterUtil"%>
<%@page import="java.util.List"%>
<%@page import="com.landray.kmss.sys.attachment.util.JgWebOffice"%>
<%@page import="com.landray.kmss.km.imissive.util.KmImissiveConfigUtil"%>
<%@ page import="com.landray.kmss.util.IDGenerator"%>
<%@page import="com.landray.kmss.util.ResourceUtil"%>
<%@page import="com.landray.kmss.util.StringUtil"%>
<%@page import="com.landray.kmss.sys.webservice2.util.SysWsUtil"%>
<%@ page import="com.landray.kmss.km.imissive.util.ImissiveUtil" %>

<%
	pageContext.setAttribute("_isWpsCloudEnable", new Boolean(ImissiveUtil.isEnableWpsCloud()));
	pageContext.setAttribute("_isWpsCenterEnable", new Boolean(SysAttWpsCenterUtil.isEnable()));
%>
<template:replace name="content">
	<link rel="Stylesheet" href="${LUI_ContextPath}/km/imissive/resource/css/att.css?s_cache=${MUI_Cache}" />
	<%-- 压缩js --%>
	<jsp:include page="/km/imissive/compressJs/compressJs_flatContent.jsp">
		<jsp:param name="fdType" value="receive"/>
	</jsp:include>

	<html:form action="/km/imissive/km_imissive_receive_main/kmImissiveReceiveMain.do">
		<%-- 网页签章(首先判断是否启用了网页签章) --%>
    	<c:if test="${JGSignatureHTMLEnabled == 'true'}">
			<%
				String projectServerURL = SysWsUtil.getUrlPrefix(request);
				String mServerUrl=projectServerURL+"/km/imissive/iSignatureHTML/Service.jsp";
			  	request.setAttribute("jgHtmlSigVersion",JgWebOffice.getJGVersion("signaturehtml"));
			  	request.setAttribute("jgHtmlSigUrl",projectServerURL + JgWebOffice.getJGDownLoadUrl("signaturehtml"));
			%>
	    	<span id="processNodeId" style="display: none;"><kmss:showWfPropertyValues idValue="${kmImissiveReceiveMainForm.fdId}" propertyName="handerNameDetail" /></span>
	    	<input type="hidden" name="DOCUMENTID" value="${kmImissiveReceiveMainForm.fdId }">
	    	<OBJECT id="SignatureControl"   classid="clsid:D85C89BE-263C-472D-9B6B-5264CD85B36E"  codebase="${jgHtmlSigUrl }#version=${jgHtmlSigVersion }" width=0 height=0>
				<param name="ServiceUrl" value="<%=mServerUrl%>"><!--读去数据库相关信息-->
				<param name="PrintControlType" value=2>               <!--打印控制方式（0:不控制  1：签章服务器控制  2：开发商控制）-->
			</OBJECT>	
		</c:if>
		
	    <input type="hidden" name="fdSendtempId"/>
		<input type="hidden" name="fdSendtempName"/>
		<input type="hidden" name="fdReceivetempId"/>
		<input type="hidden" name="fdReceivetempName"/>	
		<c:choose>
			<c:when test="${not empty kmImissiveReceiveMainForm.attachmentForms['ofdEqbSign'].attachments}">
				<c:set var="fdSignKey" value="ofdEqbSign" />
			</c:when>
			<c:when test="${not empty kmImissiveReceiveMainForm.attachmentForms['eqbSign'].attachments}">
				<c:set var="fdSignKey" value="eqbSign" />
			</c:when>
			<c:when test="${not empty kmImissiveReceiveMainForm.attachmentForms['yqqSigned'].attachments}">
				<c:set var="fdSignKey" value="yqqSigned" />
			</c:when>
			<c:otherwise>
				<c:set var="fdSignKey" value="" />
			</c:otherwise>
		</c:choose>

		 <%-- #144713 开启wps中台时，正文为空，则pc端和移动端均需要去掉正文页签 --%>
		 <c:set var="isShowContentTabpanel" value="false" />
		 <c:choose>
			 <c:when test="${_isWpsCenterEnable}">
				 <c:choose>
					 <c:when test="${kmImissiveReceiveMainForm.fdNeedContent eq '0' and not empty kmImissiveReceiveMainForm.attachmentForms['mainonline'].attachments}">
						 <c:set var="isShowContentTabpanel" value="true" />
					 </c:when>
					 <c:when test="${kmImissiveReceiveMainForm.fdNeedContent eq '1' and not empty kmImissiveReceiveMainForm.attachmentForms['editonline'].attachments}">
						 <c:set var="isShowContentTabpanel" value="true" />
					 </c:when>
				 </c:choose>
			 </c:when>
			 <c:when test="${not empty kmImissiveReceiveMainForm.attachmentForms['editonline'].attachments or not empty kmImissiveReceiveMainForm.attachmentForms['mainonline'].attachments}">
				 <c:set var="isShowContentTabpanel" value="true" />
			 </c:when>
		 </c:choose>
	    <ui:tabpage expand="false" collapsed="false">
	    <c:if test="${kmImissiveReceiveMainForm.docStatus =='30'}">
	     <%if("content".equals(KmImissiveConfigUtil.getDiplayOrder())){ %>
			<c:if test="${isShowContentTabpanel eq 'true'}">
				<ui:content title="${lfn:message('km-imissive:kmImissiveReceiveMain.docContent')}" expand="${expandContent}">
					<jsp:include page="/km/imissive/km_imissive_receive_main/kmImissiveReceiveMain_content.jsp"></jsp:include>
					<c:if test="${not empty kmImissiveReceiveMainForm.attachmentForms[fdSignKey].attachments}">
						<table class="tb_normal" width="100%" style="margin-top: 16px">
							<tr>
								<td class="td_normal_title" width="15%">最新签署文件</td>
								<td colspan="3" width="85.0%">
										<%-- 最新签署文件--%>
									<c:import url="/sys/attachment/sys_att_main/sysAttMain_view.jsp" charEncoding="UTF-8">
										<c:param name="fdKey" value="${fdSignKey}" />
										<c:param name="fdModelName"
												 value="com.landray.kmss.km.imissive.model.KmImissiveReceiveMain" />
									</c:import>
								</td>
							</tr>
						</table>
					</c:if>
				</ui:content>
			</c:if>
	        <ui:content id="kmImissiveReceiveMain_baseinfo" title="${ lfn:message('km-imissive:kmImissiveReceiveMain.baseinfo') }" expand="${expandBaseInfo}">
				<c:import url="/km/imissive/km_imissive_receive_main/kmImissiveReceiveMain_baseInfo.jsp" charEncoding="UTF-8">
			  		<c:param name="formName" value="kmImissiveReceiveMainForm" />
			  	</c:import>
				<c:if test="${empty loadAtt and 'true' eq existAtt}">
					<jsp:include page="/km/imissive/km_imissive_receive_main/kmImissiveReceiveMain_attachment.jsp"></jsp:include>
				</c:if>
				<c:import url="/km/imissive/km_imissive_receive_main/kmImissiveReceiveMain_relateInfo.jsp" charEncoding="UTF-8">
			  		<c:param name="formName" value="kmImissiveReceiveMainForm" />
			  	</c:import>
			</ui:content>
	     <%}else{ %>
	        <ui:content id="kmImissiveReceiveMain_baseinfo" title="${ lfn:message('km-imissive:kmImissiveReceiveMain.baseinfo') }" expand="${expandBaseInfo}">
				<c:import url="/km/imissive/km_imissive_receive_main/kmImissiveReceiveMain_baseInfo.jsp">
			  		<c:param name="formName" value="kmImissiveReceiveMainForm" />
			  	</c:import>
				<c:if test="${empty loadAtt and 'true' eq existAtt}">
					<jsp:include page="/km/imissive/km_imissive_receive_main/kmImissiveReceiveMain_attachment.jsp"></jsp:include>
				</c:if>
				<c:import url="/km/imissive/km_imissive_receive_main/kmImissiveReceiveMain_relateInfo.jsp" charEncoding="UTF-8">
			  		<c:param name="formName" value="kmImissiveReceiveMainForm" />
			  	</c:import>
			</ui:content>
			<c:if test="${isShowContentTabpanel eq 'true'}">
				<ui:content title="${lfn:message('km-imissive:kmImissiveReceiveMain.docContent')}" expand="${expandContent}">
				  <jsp:include page="/km/imissive/km_imissive_receive_main/kmImissiveReceiveMain_content.jsp"></jsp:include>
				  <c:if test="${not empty kmImissiveReceiveMainForm.attachmentForms[fdSignKey].attachments}">
							<table class="tb_normal" width="100%" style="margin-top: 16px">
								<tr>
									<td class="td_normal_title" width="15%">最新签署文件</td>
									<td colspan="3" width="85.0%">
											<%-- 最新签署文件--%>
										<c:import url="/sys/attachment/sys_att_main/sysAttMain_view.jsp" charEncoding="UTF-8">
											<c:param name="fdKey" value="${fdSignKey}" />
											<c:param name="fdModelName"
													 value="com.landray.kmss.km.imissive.model.KmImissiveReceiveMain" />
										</c:import>
									</td>
								</tr>
							</table>
						</c:if>
				</ui:content>
			</c:if>
	     <%} %>
	    </c:if> 
	    <c:if test="${kmImissiveReceiveMainForm.docStatus !='30'}">
	    	<%if("content".equals(KmImissiveConfigUtil.getDiplayOrder4Approval())){ %>
				<c:if test="${isShowContentTabpanel eq 'true'}">
					<ui:content title="${lfn:message('km-imissive:kmImissiveReceiveMain.docContent')}" expand="${expandContent}">
					  <jsp:include page="/km/imissive/km_imissive_receive_main/kmImissiveReceiveMain_content.jsp"></jsp:include>
					  <c:if test="${not empty kmImissiveReceiveMainForm.attachmentForms[fdSignKey].attachments}">
							<table class="tb_normal" width="100%" style="margin-top: 16px">
								<tr>
									<td class="td_normal_title" width="15%">最新签署文件</td>
									<td colspan="3" width="85.0%">
											<%-- 最新签署文件--%>
										<c:import url="/sys/attachment/sys_att_main/sysAttMain_view.jsp" charEncoding="UTF-8">
											<c:param name="fdKey" value="${fdSignKey}" />
											<c:param name="fdModelName"
													 value="com.landray.kmss.km.imissive.model.KmImissiveReceiveMain" />
										</c:import>
									</td>
								</tr>
							</table>
						</c:if>
					</ui:content>
				</c:if>
		        <ui:content id="kmImissiveReceiveMain_baseinfo" title="${ lfn:message('km-imissive:kmImissiveReceiveMain.baseinfo') }" expand="${expandBaseInfo}">
					<c:import url="/km/imissive/km_imissive_receive_main/kmImissiveReceiveMain_baseInfo.jsp" charEncoding="UTF-8">
				  		<c:param name="formName" value="kmImissiveReceiveMainForm" />
				  	</c:import>
					<c:if test="${empty loadAtt and 'true' eq existAtt}">
						<jsp:include page="/km/imissive/km_imissive_receive_main/kmImissiveReceiveMain_attachment.jsp"></jsp:include>
					</c:if>
					<c:import url="/km/imissive/km_imissive_receive_main/kmImissiveReceiveMain_relateInfo.jsp" charEncoding="UTF-8">
				  		<c:param name="formName" value="kmImissiveReceiveMainForm" />
				  	</c:import>
				</ui:content>
		     <%}else{ %>
		        <ui:content id="kmImissiveReceiveMain_baseinfo" title="${ lfn:message('km-imissive:kmImissiveReceiveMain.baseinfo') }" expand="${expandBaseInfo}">
					<c:import url="/km/imissive/km_imissive_receive_main/kmImissiveReceiveMain_baseInfo.jsp">
				  		<c:param name="formName" value="kmImissiveReceiveMainForm" />
				  	</c:import>
					<c:if test="${empty loadAtt and 'true' eq existAtt}">
						<jsp:include page="/km/imissive/km_imissive_receive_main/kmImissiveReceiveMain_attachment.jsp"></jsp:include>
					</c:if>
					<c:import url="/km/imissive/km_imissive_receive_main/kmImissiveReceiveMain_relateInfo.jsp" charEncoding="UTF-8">
				  		<c:param name="formName" value="kmImissiveReceiveMainForm" />
				  	</c:import>
				</ui:content>
				<c:if test="${isShowContentTabpanel eq 'true'}">
					<ui:content title="${lfn:message('km-imissive:kmImissiveReceiveMain.docContent')}" expand="${expandContent}">
					  <jsp:include page="/km/imissive/km_imissive_receive_main/kmImissiveReceiveMain_content.jsp"></jsp:include>
						<c:if test="${not empty kmImissiveReceiveMainForm.attachmentForms[fdSignKey].attachments}">
							<table class="tb_normal" width="100%" style="margin-top: 16px">
								<tr>
									<td class="td_normal_title" width="15%">最新签署文件</td>
									<td colspan="3" width="85.0%">
											<%-- 最新签署文件--%>
										<c:import url="/sys/attachment/sys_att_main/sysAttMain_view.jsp" charEncoding="UTF-8">
											<c:param name="fdKey" value="${fdSignKey}" />
											<c:param name="fdModelName"
													 value="com.landray.kmss.km.imissive.model.KmImissiveReceiveMain" />
										</c:import>
									</td>
								</tr>
							</table>
						</c:if>
					</ui:content>
				</c:if>
		     <%} %>
	    </c:if>
	    <!-- 以下代码为嵌入流程模板标签的代码 -->
		<kmss:auth requestURL="/km/imissive/km_imissive_receive_main/kmImissiveReceiveMain.do?method=readViewLog&fdId=${kmImissiveReceiveMainForm.fdId}" requestMethod="GET">
			<c:import url="/sys/workflow/import/sysWfProcess_view.jsp" charEncoding="UTF-8">
				<c:param name="formName" value="kmImissiveReceiveMainForm" />
				<c:param name="fdKey" value="receiveMainDoc" />
				<c:param name="showHistoryOpers" value="true" />
				<c:param name="isSimpleWorkflow" value="false" />
				<c:param name="onClickSubmitButton" value="Com_submitReview();" />
			</c:import>
		</kmss:auth>
		<c:import url="/km/imissive/km_imissive_receive_main/kmImissiveReceiveMain_import.jsp" charEncoding="UTF-8">
			<c:param name="formName" value="kmImissiveReceiveMainForm" />
		</c:import>
	</ui:tabpage>
	</html:form>
	<%@include file="/km/imissive/km_imissive_receive_main/kmImissiveReceiveMain_viewScript.jsp"%>
<script>
$(document).ready(function(){
	
	var obj1 = document.getElementById("JGWebOffice_editonline");
	var obj2 = document.getElementById("JGWebOffice_mainonline");
	if(obj1){
		obj1.setAttribute("height", "550px");
	}
	if(obj2){
		obj2.setAttribute("height", "550px");
	}
	
	if("${_isWpsCloudEnable}" == 'true'){
		if($('#IFrame_Content')){
			$('#IFrame_Content').height("560px");
		}
	}
	if("${_isWpsCenterEnable}" == 'true'){
		if($('#IFrame_Content')){
			$('#IFrame_Content').height("560px");
		}
	}
	
	$(".com_approval_bar2").bind('click', function(event) {
		var tab = LUI('kmImissiveReceiveMain_baseinfo');
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
	
	var ofdCyFlag = '${kmImissiveReceiveMainForm.sysWfBusinessForm.fdNodeAdditionalInfo.ofdCySign =="true"}';
	if(ofdCyFlag == "true"){
		$("object[id*='surread']").each(function(i,_obj){
			_obj.value = "1";
	  	});
	}
});

</script>
 </template:replace>
 <template:replace name="nav">
 		<c:if test="${existOpinion}">
			<ui:accordionpanel  style="min-width:200px;min-height:100px;" layout="sys.ui.accordionpanel.simpletitle"> 
				<ui:content  title="传阅意见"  id="circulation" >
					<ui:iframe src="${KMSS_Parameter_ContextPath}sys/circulation/sys_circulation_opinion/sysCirculationOpinion.do?method=edit&fdModelId=${kmImissiveReceiveMainForm.fdId}&fdModelName=com.landray.kmss.km.imissive.model.KmImissiveReceiveMain">
					</ui:iframe>
				</ui:content>
			</ui:accordionpanel>
		</c:if>
		<%--关联机制 --%>
		<c:import url="/sys/relation/import/sysRelationMain_view.jsp" charEncoding="UTF-8">
			<c:param name="formName" value="kmImissiveReceiveMainForm" />
		</c:import>
	    <!-- 关联机制 -->
</template:replace>
