<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/sys/ui/jsp/common.jsp"%>
<template:include ref="default.simple" sidebar="no">
	<template:replace name="body">
	<link rel="stylesheet" type="text/css" href="${KMSS_Parameter_ContextPath}sys/attachment/sys_att_main/resource/css/nodata.css">
			<div class="lui_imissive_noData_L_container">
		        <div class="lui_imissive_noData_L_wrapper">
		            <div class="lui_imissive_noData_img"></div>
		             <p>目前暂无附件，请先到方案详情上传相关附件哦！</p>
		        </div>
		    </div>
	</template:replace>
</template:include>	


