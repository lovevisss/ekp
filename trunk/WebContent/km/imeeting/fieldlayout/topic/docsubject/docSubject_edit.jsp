<%-- 议题名称 --%>
<%@page import="com.landray.kmss.util.StringUtil"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/resource/jsp/common.jsp"%>
<%@ include file="/km/imeeting/fieldlayout/common/param_parser.jsp"%>
    <%
	   // String docSubject = parse.getParamValue("defaultValue");
	   // String defaultDocSubject = parse.acquireValue("docSubject",docSubject);
	   String isMobileC = (String)request.getParameter("mobile");
	   if (StringUtil.isNull(isMobileC) || "false".equals(isMobileC)) {
		   parse.addStyle("width", "control_width", "95%");
	   }
		required = Boolean.parseBoolean(parse.getParamValue("control_required", "true"));
	%>

<div id="_docSubject"  xform_type="xtext">
	<xform:xtext property="docSubject" mobile="${param.mobile eq 'true'? 'true':'false'}"  required="<%=required%>" style="<%=parse.getStyle()%>"  validators="maxLength(100)"/>
</div>	