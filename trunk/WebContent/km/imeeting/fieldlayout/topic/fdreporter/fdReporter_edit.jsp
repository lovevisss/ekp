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
		required = Boolean.parseBoolean(parse.getParamValue("control_required", "true"));
	%>
<div id="_fdReporter" valField="fdReporterId" xform_type="address">
<xform:address 
	propertyId="fdReporterId" 
	propertyName="fdReporterName" 
	subject="${lfn:message('km-imeeting:kmImeetingTopic.fdReporter')}" 
	orgType="ORG_TYPE_PERSON" 
	required="<%=required%>" 
	style="<%=parse.getStyle()%>" 
	mobile="${param.mobile eq 'true'? 'true':'false'}" />
</div>