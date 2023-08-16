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
<div id="_fdBeginDate"  xform_type="datetime">
	<xform:datetime property="fdBeginDate" mobile="${param.mobile eq 'true'? 'true':'false'}"
				required="true"
                showStatus="edit" 
                dateTimeType="datetime" 
                validators="after schemeTime"
                className="schemeBeginDate"
                subject="${lfn:message('km-imeeting:kmImeetingScheme.fdBeginDate')}"
                style="<%=parse.getStyle()%>" />
</div>