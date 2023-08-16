<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@page import="com.landray.kmss.sys.readlog.actions.SysReadLogAction" %>
<%@ include file="/resource/jsp/common.jsp" %>
<c:set var="fdModelId" value="${requestScope[param.formName].fdId}" scope="request"/>
<c:set var="fdModelName" value="${requestScope[param.formName].modelClass.name}" scope="request"/>
<% new SysReadLogAction().viewReadLogPrint(request, response);%>
<table width=100%>
	<tr>
		<td class="lui_form_subhead">
			<bean:message key="sysReadLog.showText.readerList" bundle="sys-readlog" />
			(${fdReadNameCount})
		</td>
	</tr>
	<tr>
		<td>
			<div id="readerList" class="read_readed_detail">
				<c:out value="${fdReaderNameList}" />
			</div>
		</td>
	</tr>
</table>