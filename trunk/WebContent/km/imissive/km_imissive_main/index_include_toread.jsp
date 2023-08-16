<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="/sys/ui/jsp/common.jsp"%>
<%@ page import="com.landray.kmss.util.UserUtil"%>
<template:include ref="default.simple" spa="true">
	<template:replace name="body">
		<script type="text/javascript">
			seajs.use(['theme!list']);	
		</script>
	  	<list:listview id="listview3" channel="list_toview">
				<ui:source type="AjaxJson">
						{url:'/sys/notify/sys_notify_todo/sysNotifyMainIndex.do?method=list&dataType=toview&fdType=2'}
				</ui:source>
				<list:colTable isDefault="false" layout="sys.ui.listview.columntable" 
					 name="columntable_3" id="fixedForTable_toView">
					<list:col-checkbox name="List_Selected"></list:col-checkbox>
					<list:col-serial></list:col-serial>
					<list:col-html   title="${ lfn:message('sys-notify:sysNotifyTodo.fdSubject') }" style="text-align:left">
						{$ <a class="lui_notify_alink" onclick="onNotifyClick(this,'{%row._fdType%}')" href="${KMSS_Parameter_ContextPath}sys/notify/sys_notify_todo/sysNotifyTodo.do?method=view&fdId={%row.fdId%}" target="_blank">{%row['todo.subject4View']%} </a>$}
					</list:col-html>
					<list:col-auto props="star;fdType4View"></list:col-auto>
					<list:col-html headerStyle="width:150px;" title="${ lfn:message('sys-notify:sysNotifyTodo.moduleName') }">
						{$<c:if test="${not empty HtmlParam.fdAppName}">{%row['appName']%}</c:if><c:if test="${empty HtmlParam.fdAppName}">{%row['modelNameText']%}</c:if>$}
					</list:col-html>
					<list:col-auto props="docCreatorName;fdCreateTime4View"></list:col-auto>
				</list:colTable>
			</list:listview> 
		 	<list:paging channel="list_toview"></list:paging>
	</template:replace>	 
</template:include>