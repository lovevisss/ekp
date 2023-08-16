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
<div id="_fdEndDate"  xform_type="datetime">
	<xform:datetime property="fdEndDate" mobile="${param.mobile eq 'true'? 'true':'false'}"
				required="true"
                showStatus="edit" 
                dateTimeType="datetime" 
                className="schemeEndDate"
                validators="after schemeTime"
                subject="${lfn:message('km-imeeting:kmImeetingScheme.fdEndDate')}"
                style="<%=parse.getStyle()%>" />	
</div>
