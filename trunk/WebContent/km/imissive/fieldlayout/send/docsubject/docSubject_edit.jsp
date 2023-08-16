<%-- 文档状态 --%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/resource/jsp/common.jsp"%>
<%@ include file="/km/imissive/fieldlayout/common/param_parser.jsp"%>
<%@page import="com.landray.kmss.sys.authorization.constant.ISysAuthConstant"%>	
    <%
	   // String docSubject = parse.getParamValue("defaultValue");
	   // String defaultDocSubject = parse.acquireValue("docSubject",docSubject);
		parse.addStyle("width", "control_width", "95%");
		required = Boolean.parseBoolean(parse.getParamValue("control_required", "true"));
	%>
<% if(ISysAuthConstant.IS_AREA_ENABLED) { %> 
	<input type="hidden" name="authAreaId" value="${kmImissiveSendMainForm.authAreaId}"> 
<% } %>
<input type="hidden" name="fdTemplateId" value="${kmImissiveSendMainForm.fdTemplateId}"/>
<div id="_docSubject" xform_type="xtext">
<xform:xtext property="docSubject" mobile="${param.mobile eq 'true'? 'true':'false'}"  validators="maxLength(500) senWordsValidator(kmImissiveSendMainForm)" required="<%=required%>" style="<%=parse.getStyle()%>"/>
</div>	