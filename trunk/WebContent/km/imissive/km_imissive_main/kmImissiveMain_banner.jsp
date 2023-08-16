<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="/sys/ui/jsp/common.jsp"%>
<%@page import="com.landray.kmss.km.imissive.util.KmImissiveConfigUtil"%>
<link type="text/css" rel="stylesheet" href="${LUI_ContextPath}/km/imissive/resource/css/banner.css"/>
<c:set var="__kmImissiveMainForm" value="${requestScope[param.formName]}" />
<c:if test="${__kmImissiveMainForm.docStatus eq '30' || __kmImissiveMainForm.docStatus eq '00'}">
	<%if("flat".equals(KmImissiveConfigUtil.getDisplayMode())){ %>
		<%if("content".equals(KmImissiveConfigUtil.getDiplayOrder())){ %>
			<div class="lbpm_flowInfoW" style="left:80%;top:100px;margin-top:-100px;position: relative">
		<% }else{%>
			<div class="lbpm_flowInfoW" style="left:80%;top:100px">
		<%}%>
	<% }else{%>
		<div class="lbpm_flowInfoW" style="left:80%">
	<%}%>
		<c:if test="${__kmImissiveMainForm.docStatus eq '30'}">
	   		<div class="lbpmProcessStatus">
	   			<div class="lbpmProcessText">已办结</div>
	      	</div>
	    </c:if>
	   	<c:if test="${__kmImissiveMainForm.docStatus eq '00'}">
	    	<div class="lbpmProcessStatus lbpmDiscardStatus">
	      		<div class="lbpmProcessText">已废弃</div>
	      	</div>
	   	</c:if>
	</div>
</c:if>