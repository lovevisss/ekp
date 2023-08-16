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
<div id="_fdChargeUnit" valField="fdChargeUnitId" xform_type="address">
	<xform:address
		propertyName="fdChargeUnitName" 
		propertyId="fdChargeUnitId" 
		orgType="ORG_TYPE_ORGORDEPT" 
		required="<%=required%>" 
		style="<%=parse.getStyle()%>"  
		mobile="${param.mobile eq 'true' ? 'true' : 'false'}"/>
</div>