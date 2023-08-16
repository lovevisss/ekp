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
<div id="_invitationPerson" valField="invitationPersonIds" xform_type="address">
 <xform:address 
            isLoadDataDict="false"
            showStatus="edit"
            mobile="${param.mobile eq 'true'? 'true':'false'}"
			required="<%=required%>" style="<%=parse.getStyle()%>"
			subject="${lfn:message('km-imeeting:kmImeetingScheme.invitationPerson')}"
			propertyId="invitationPersonIds" propertyName="invitationPersonNames"
			mulSelect="true"
			orgType='ORG_TYPE_ALL' className="input" >
   </xform:address>
</div>
<%-- <xform:textarea property="invitationPerson" showStatus="edit" required="true" style="<%=parse.getStyle()%>" mobile="${param.mobile eq 'true'? 'true':'false'}"></xform:textarea> --%>