<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<%@ include file="/sys/ui/jsp/common.jsp"%>
<template:include ref="config.view">
	<template:replace name="toolbar">
		<ui:toolbar id="toolbar" layout="sys.ui.toolbar.float" var-navwidth="95%">
			<ui:button text="${ lfn:message('button.close') }" onclick="Com_CloseWindow();"></ui:button>	
		</ui:toolbar>
	</template:replace>
	<template:replace name="content">
<script>
	Com_IncludeFile("config.css", "${LUI_ContextPath}/dbcenter/echarts/common/", "css", true);
</script>
<center>
<br>
<table class="tb_normal" width=95%> 
	<tr class="tr_normal_title">
		<td colspan="4" class="config_title">
			${ lfn:message('dbcenter-echarts:shiyongshuoming') }
		</td>
	</tr>
	<tr>
		<td colspan="4">
			<%@ include file="/dbcenter/echarts/common/input_help.jsp"%>
			<%@ include file="/dbcenter/echarts/common/query_help.jsp"%>
			<%@ include file="/dbcenter/echarts/common/output_help.jsp"%>
			<%@ include file="charts_data_help.jsp"%>
			<%@ include file="charts_options_help.jsp"%>
			<%@ include file="charts_sample_help.jsp"%>
		</td>
	</tr>
</table>
<br>
</center>
	</template:replace>
</template:include>