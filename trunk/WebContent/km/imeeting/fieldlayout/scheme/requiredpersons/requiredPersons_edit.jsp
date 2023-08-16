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
<div id="_requiredPerson" valField="requiredPersonIds" xform_type="address">
 <xform:address 
            isLoadDataDict="false"
            showStatus="edit"
            mobile="${param.mobile eq 'true'? 'true':'false'}"
			required="true" style="<%=parse.getStyle()%>"
			subject="${lfn:message('km-imeeting:kmImeetingScheme.requiredPerson')}"
			propertyId="requiredPersonIds" propertyName="requiredPersonNames"
			mulSelect="true"
			orgType='ORG_TYPE_ALL' className="input" >
   </xform:address>
   </div>
