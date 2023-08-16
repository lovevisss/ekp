<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/sys/ui/jsp/common.jsp"%>
<template:include ref="default.simple">
	<template:replace name="body">	
		<c:import url="/sys/xform/include/sysForm_view.jsp" charEncoding="UTF-8">
	        <c:param name="formName" value="kmImeetingSchemeForm" />
			<c:param name="fdKey" value="ImeetingScheme" />
			<c:param name="useTab" value="false" />
	    </c:import>
	</template:replace> 
</template:include>