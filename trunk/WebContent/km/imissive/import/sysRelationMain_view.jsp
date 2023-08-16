<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/resource/jsp/common.jsp"%>
<c:set var="mainModelForm" value="${requestScope[param.formName]}" scope="request"/>
<c:set var="sysRelationMainForm" value="${mainModelForm.sysRelationMainForm}" scope="request"/>
<c:set var="currModelId" value="${mainModelForm.fdId}" scope="request"/>
<c:set var="currModelName" value="${mainModelForm.modelClass.name}" scope="request"/>
<c:if test="${not empty sysRelationMainForm.sysRelationEntryFormList}">
	<c:if test="${param.showContent != 'false'}">
		 <ui:content title="关联信息" titleicon="${not empty param.titleicon?param.titleicon:''}">
		 	<%@include file="/km/imissive/import/sysRelationMain_view_include.jsp"%>
		 </ui:content>	
	 </c:if>
	 <c:if test="${param.showContent == 'false'}">
	 	<%@include file="/km/imissive/import/sysRelationMain_view_include.jsp"%>
	 </c:if>
</c:if>