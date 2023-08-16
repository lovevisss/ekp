<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/sys/ui/jsp/common.jsp"%>
<%@ taglib uri="/WEB-INF/KmssConfig/sys/mobile/mui.tld" prefix="mui"%>
<template:include compatibleMode="true" file="/sys/mobile/template/edit_tiny.jsp">
	<template:replace name="head">
		<mui:min-file name="mui-imeeting-edit.css"/>
		<link rel="Stylesheet" href="${LUI_ContextPath}/km/imeeting/mobile/resource/css/edit_feedback.css" />
		<link rel="Stylesheet" href="${LUI_ContextPath}/km/imeeting/mobile/resource/css/commonDialogMul.css" />
	</template:replace>
	<template:replace name="content">
	</template:replace>
</template:include>
