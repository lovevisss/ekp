<%-- 承办单位 --%>
<%@page import="com.landray.kmss.util.StringUtil"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/resource/jsp/common.jsp"%>
<%@ include file="/km/imeeting/fieldlayout/common/param_parser.jsp"%>
    <%
    	String isMobileC = (String)request.getParameter("mobile");
	   if (StringUtil.isNull(isMobileC) || "false".equals(isMobileC)) {
		   parse.addStyle("width", "control_width", "95%");
	   }
		required = Boolean.parseBoolean(parse.getParamValue("control_required", "false"));
	%>

<c:choose>
	<c:when test="${not empty kmImeetingTopicForm.fdModelId}">
		<html:hidden property="fdSourceSubject" value="${kmImeetingTopicForm.fdSourceSubject}" />
		<xform:text property="fdSourceSubject" required="<%=required%>" style="<%=parse.getStyle()%>" showStatus="view" mobile="${param.mobile eq 'true'? 'true':'false'}"/>
	</c:when>
	<c:otherwise>
		<div id="_fdSourceSubject"  xform_type="text">
			<xform:text property="fdSourceSubject" required="<%=required%>" style="<%=parse.getStyle()%>" showStatus="edit" mobile="${param.mobile eq 'true'? 'true':'false'}" />
		</div>
	</c:otherwise>
</c:choose>
