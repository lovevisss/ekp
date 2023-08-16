<%@page import="com.landray.kmss.util.StringUtil"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/resource/jsp/common.jsp"%>
<%@ include file="/km/imeeting/fieldlayout/common/param_parser.jsp"%>
<%
	String isMobileC = (String)request.getParameter("mobile");
	if (StringUtil.isNull(isMobileC) || "false".equals(isMobileC)) {
		parse.addStyle("width", "control_width", "90%");
	}
%>
<div id="_workArrangement"  xform_type="textarea">
<xform:textarea property="workArrangement" mobile="${param.mobile eq 'true'? 'true':'false'}" validators="maxLength(1500)" required="true" style="<%=parse.getStyle()%>" htmlElementProperties="class='kmImeetingTextArea textAreaRequired'"/>
</div>