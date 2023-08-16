<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="/sys/ui/jsp/common.jsp"%>
<%@ include file="/resource/jsp/error_import.jsp"%>
<%@page import="java.util.List"%>
<%@page import="com.landray.kmss.sys.attachment.util.JgWebOffice"%>
<%@page import="com.landray.kmss.km.imissive.util.KmImissiveConfigUtil"%>
<%@page import="com.landray.kmss.km.imissive.forms.KmImissiveSendMainForm"%>
<%@ page import="com.landray.kmss.util.IDGenerator"%>
<%@page import="com.landray.kmss.util.ResourceUtil"%>
<%@page import="com.landray.kmss.util.StringUtil"%>

<%
	String isJGSignatureHTMLEnabled = ResourceUtil.getKmssConfigString("sys.att.isJGSignatureHTMLEnabled");
	request.setAttribute("JGSignatureHTMLEnabled",isJGSignatureHTMLEnabled);
%>
<%if("tab".equals(KmImissiveConfigUtil.getDisplayMode())){ %>
<template:include ref="missive.view"  sidebar="auto" >
	<jsp:include page="/km/imissive/km_imissive_send_main/kmImissiveSendMain_viewHead.jsp"/>
	<jsp:include page="/km/imissive/km_imissive_send_main/kmImissiveSendMain_tabContent.jsp"/>
</template:include>
<%}else{ %>
<template:include ref="default.view"  sidebar="auto" >
	<jsp:include page="/km/imissive/km_imissive_send_main/kmImissiveSendMain_viewHead.jsp"/>
	<jsp:include page="/km/imissive/km_imissive_send_main/kmImissiveSendMain_flatContent.jsp"/>
</template:include>
<%} %>
