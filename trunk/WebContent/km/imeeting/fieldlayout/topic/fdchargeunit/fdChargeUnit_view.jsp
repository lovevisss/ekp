<%-- 承办单位 --%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/resource/jsp/common.jsp"%>
<%@ include file="/km/imeeting/fieldlayout/common/param_parser.jsp"%>
    <%
		parse.addStyle("width", "control_width", "95%");
		required = Boolean.parseBoolean(parse.getParamValue("control_required", "true"));
	%>
<xform:address 
	propertyName="fdChargeUnitName" 
	propertyId="fdChargeUnitId" 
	orgType="ORG_TYPE_ORGORDEPT" 
	showStatus="view" 
	required="<%=required%>" 
	style="<%=parse.getStyle()%>"
	mobile="${param.mobile eq 'true' ? 'true' : 'false'}" />