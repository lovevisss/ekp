<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="/sys/ui/jsp/common.jsp"%>
<%@page import="java.util.List"%>
<%@page import="com.landray.kmss.util.ResourceUtil"%>
<template:include ref="default.print">
<template:replace name="head">
</template:replace>
	<template:replace name="title">
		<c:out value="${kmImissiveSignMainForm.docSubject }"></c:out>
	</template:replace>
<template:replace name="content">

	<!-- 打印机制 -->
	<c:import url="/sys/print/import/sysPrintMain_view.jsp" charEncoding="UTF-8">
		<c:param name="formName" value="kmImissiveSignMainForm" />
		<c:param name="modelName" value="com.landray.kmss.km.imissive.model.KmImissiveSignTemplate"></c:param>
	</c:import>
</template:replace>
		
</template:include>

