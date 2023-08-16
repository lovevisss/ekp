<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="/sys/ui/jsp/common.jsp"%>
<template:include ref="default.view"  sidebar="no">
<template:replace name="toolbar">
	<ui:toolbar  id="toolbar" layout="sys.ui.toolbar.float" count="3">
		<ui:button text="${lfn:message('button.close')}" order="5" onclick="Com_CloseWindow();">
		</ui:button>
	</ui:toolbar>
</template:replace>
<template:replace name="content">
<p class="txttitle">意见</p>
<center>
<%@ include file="/km/imissive/km_imissive_regdetail_opinion/kmImissiveRegDetailOpinion_viewinclude.jsp"%>
</center>
</template:replace>
</template:include>