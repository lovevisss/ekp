<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="/sys/ui/jsp/common.jsp"%>
<%@ taglib uri="/WEB-INF/KmssConfig/sys/portal/portal.tld" prefix="portal"%>
<!doctype html>
<html>
<head>
<meta http-equiv="X-UA-Compatible" content="IE=edge" />
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="renderer" content="webkit" />
<%@ include file="/sys/ui/jsp/jshead.jsp"%>
<title>
<portal:title/>
</title>
<script>
	seajs.use(['theme!portal']);
	// 定义设计器初始化配置（allowUploadBackgroundImage表示是否允许上传内容区背景图片）
	var designerConfig = {"allowUploadBackgroundImage":true};
</script>
<style>
	.lui_t_banner_design [portal-key='body1']{
		min-height: 240px!important;
	}
</style>
</head>
<body class="lui_portal_body" onselectstart="return false;">
<div class="lui_t_banner_design" style="margin: 0px auto;width: 980px;display: table;">
	<div class="design_heder">
		<portal:header/>
	</div>	
	<portal:guide/>
	<template:block name="body1"></template:block>
	<!-- 内容区域 -->
	<div style="margin:0 10px;border: 1px #e5e5e5 solid;">
		<template:block name="body2"></template:block>
	</div>
	<div style="margin: 0px auto;height: 50px;border: 1px #e5e5e5 solid;background: #c8c8c8;text-align: center;">
	 	<portal:footer/>
	</div>
</div> 
</body>
</html>
