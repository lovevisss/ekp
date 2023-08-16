<%-- 承办单位 --%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/resource/jsp/common.jsp"%>
<%@ include file="/km/imissive/fieldlayout/common/param_parser.jsp"%>
    <%
		parse.addStyle("width", "control_width", "95%");
		required = Boolean.parseBoolean(parse.getParamValue("control_required", "true"));
	%>
<html:hidden property="fdListenUnitIds" value="${kmImeetingTopicForm.fdListenUnitIds}" />
<c:out value="${kmImeetingTopicForm.fdListenUnitNames}"></c:out>