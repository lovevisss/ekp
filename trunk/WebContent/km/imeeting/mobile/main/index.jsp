<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/sys/ui/jsp/common.jsp"%>
<c:set var="tiny" value="true" scope="request" />
<template:include ref="mobile.list" canHash="true">
	<template:replace name="head">
		<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/km/imeeting/mobile/resource/css/list.css?s_cache=${MUI_Cache}" />
		<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/km/imeeting/mobile/resource/css/header.css?s_cache=${MUI_Cache}" />
		<link rel="Stylesheet" type="text/css" href="${LUI_ContextPath}/km/imeeting/mobile/resource/css/meeting.css?s_cache=${MUI_Cache}" />   
	</template:replace>
	<template:replace name="title">
		<c:if test="${param.moduleName!=null && param.moduleName!=''}">
			<c:out value="${param.moduleName}"/>
		</c:if>
		<c:if test="${param.moduleName==null || param.moduleName==''}">
			<c:out value="${lfn:message('km-imeeting:table.kmImeetingMain')}"/>
		</c:if>
	</template:replace>
	<template:replace name="content">
		<c:choose>
			<c:when test="${param.docType eq 'approval'}">
				<c:import url="/km/imeeting/mobile/main/listview_approval.jsp" charEncoding="UTF-8"/>
			</c:when>
			<c:otherwise>
				<c:import url="/km/imeeting/mobile/main/listview.jsp" charEncoding="UTF-8"/>
			</c:otherwise>
		</c:choose>
	</template:replace>
</template:include>
