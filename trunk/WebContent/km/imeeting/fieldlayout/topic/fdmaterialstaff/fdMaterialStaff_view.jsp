<%-- 承办单位 --%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/resource/jsp/common.jsp"%>
<%@ include file="/km/imissive/fieldlayout/common/param_parser.jsp"%>
    <%
		parse.addStyle("width", "control_width", "95%");
		required = Boolean.parseBoolean(parse.getParamValue("control_required", "true"));
	%>
<xform:address 
	propertyId="fdMaterialStaffId" 
	propertyName="fdMaterialStaffName" 
	orgType="ORG_TYPE_PERSON" 
	required="<%=required%>" 
	style="<%=parse.getStyle()%>" 
	showStatus="view" 
	mobile="${param.mobile eq 'true'? 'true':'false'}"/>
