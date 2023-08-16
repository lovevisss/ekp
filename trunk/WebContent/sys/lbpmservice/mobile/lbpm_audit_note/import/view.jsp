<%@page import="com.landray.kmss.util.StringUtil"%>
<%@page import="com.landray.kmss.util.ResourceUtil"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/sys/ui/jsp/common.jsp"%>
<%@ taglib uri="/WEB-INF/KmssConfig/sys/mobile/mui.tld" prefix="mui"%>
<c:if test="${empty JsParam._data }">
   <mui:cache-file name="sys-lbpm-note.js" cacheType="md5"/>
</c:if>
<jsp:include page="/sys/lbpmservice/mobile/lbpm_audit_note/import/view_include.jsp">
	<jsp:param name="processId" value="${param.fdModelId}" />
</jsp:include>
<c:set var="_sysWfBusinessForm" value="${requestScope[param.formBeanName]}" />

<script>
	<%-- 兼容脚本加载顺序 --%>
	if (!window.showProcessStatus) { window.showProcessStatus = function() { } }
	if (!window.showFlowChart) { window.showFlowChart = function() { } }
</script>
<div data-dojo-type="dojox/mobile/ListItem" class="lbpmFlowChartForward"
	 data-dojo-props='icon:"mui mui-processState",rightIcon:"mui mui-forward",clickable:true,noArrow:true,onClick:showProcessStatus'>
	 <%-- 查看流程状态 --%>
	 <bean:message bundle="sys-lbpmservice-support" key="lbpm.process.status.viewProcessStatus" />
</div>
<div data-dojo-type="dojox/mobile/ListItem" class="lbpmFlowChartForward"
	 data-dojo-props='icon:"mui mui-picview",rightIcon:"mui mui-forward",clickable:true,noArrow:true,onClick:showFlowChart'>
	 <bean:message bundle="sys-lbpmservice" key="lbpm.process.pda.chart.show" />
</div>
<div
	data-dojo-type="sys/lbpmservice/mobile/lbpm_audit_note/js/LbpmserviceAuditNote"
	data-dojo-props="fdModelId:'${param.fdModelId }',fdModelName:'${ param.fdModelName}',formBeanName:'${param.formBeanName}',
	docStatus:'${_sysWfBusinessForm.docStatus}'">
</div>
