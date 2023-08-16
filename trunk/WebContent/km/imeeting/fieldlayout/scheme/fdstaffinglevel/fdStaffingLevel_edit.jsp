<%-- 入职职级 --%>
<%@page import="com.landray.kmss.util.StringUtil"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/resource/jsp/common.jsp"%>
<%@ include file="/km/imeeting/fieldlayout/common/param_parser.jsp"%>
<%
	String isMobileC = (String)request.getParameter("mobile");
	if (StringUtil.isNull(isMobileC) || "false".equals(isMobileC)) {
		parse.addStyle("width", "control_width", "45%");
	}
%>

<c:choose>
	<c:when test="${param.mobile eq 'true'}">
		<span id="staffingLevelN" style="float: right;margin-right: 1.2rem;"></span>
		<input type="hidden" name="fdStaffingLevel" value="${kmImeetingSchemeForm.fdStaffingLevel}" >
	</c:when>
	<c:otherwise>
		<div id="_docSubject"  xform_type="xtext">
			<xform:xtext 
				property="fdStaffingLevel" 
				showStatus="readOnly" 
				validators="maxLength(200)" 
				required="true" 
				style="<%=parse.getStyle()%>"
				htmlElementProperties="id='fdStaffingLevel'"/>
		</div>
	</c:otherwise>
</c:choose>