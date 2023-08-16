<%@page import="com.landray.kmss.util.StringUtil"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/resource/jsp/common.jsp"%>
<%@ include file="/km/imeeting/fieldlayout/common/param_parser.jsp"%>
<%
	String isMobileC = (String)request.getParameter("mobile");
	if (StringUtil.isNull(isMobileC) || "false".equals(isMobileC)) {
		parse.addStyle("width", "control_width", "45%");
	}
%>
<c:choose>
	<c:when test='${kmImeetingSchemeForm.docNumber!=null}'>
		<c:if test="${param.mobile eq 'true'}">
			<span style="float: right;margin-right: .5rem;">
		</c:if>
	    <xform:text property="docNumber" showStatus="view" style="<%=parse.getStyle()%>" mobile="${param.mobile eq 'true' ? 'true' : 'false'}" />
	    <c:if test="${param.mobile eq 'true'}">
	    	</span>
	    </c:if>
	</c:when>
	<c:otherwise>
		<c:if test="${param.mobile eq 'true'}">
			<span style="float: right;margin-right: .5rem;">
		</c:if>
		<bean:message bundle="km-imeeting" key="kmImeetingScheme.auto.number" />
		<c:if test="${param.mobile eq 'true'}">
	    	</span>
	    </c:if>
	</c:otherwise>
</c:choose>
