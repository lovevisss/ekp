<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/sys/ui/jsp/common.jsp"%>
<c:set var="tiny" value="true" scope="request" />
<template:include ref="mobile.list" canHash="true">
	<template:replace name="head">
		<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/km/imeeting/mobile/resource/css/list.css?s_cache=${MUI_Cache}"></link>
		<link rel="Stylesheet" type="text/css" href="${LUI_ContextPath}/km/imeeting/mobile/resource/css/meeting.css?s_cache=${MUI_Cache}" />   
	</template:replace>
	<template:replace name="title">
		<c:if test="${param.moduleName!=null && param.moduleName!=''}">
			<c:out value="${param.moduleName}"></c:out>
		</c:if>
		<c:if test="${param.moduleName==null || param.moduleName==''}">
			<c:out value="${lfn:message('km-imeeting:table.kmImeetingTopic')}"></c:out>
		</c:if>
	</template:replace>
	<template:replace name="content">
		<c:choose>
			<c:when test="${param.docType eq 'approval'}">
				<c:import url="/km/imeeting/mobile/topic/listview_approval.jsp" charEncoding="UTF-8"></c:import>
			</c:when>
			<c:otherwise>
				<c:import url="/km/imeeting/mobile/topic/listview.jsp" charEncoding="UTF-8"></c:import>
			</c:otherwise>
		</c:choose>
	</template:replace>
</template:include>
