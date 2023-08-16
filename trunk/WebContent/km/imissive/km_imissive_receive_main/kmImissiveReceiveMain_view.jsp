<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="/sys/ui/jsp/common.jsp"%>
<%@ include file="/resource/jsp/error_import.jsp"%>
<%@page import="com.landray.kmss.sys.attachment.util.JgWebOffice"%>
<%@page import="com.landray.kmss.util.StringUtil"%>
<%@page import="com.landray.kmss.km.imissive.util.KmImissiveConfigUtil"%>
<%@page import="com.landray.kmss.util.ResourceUtil"%>

<%
	//out.print(request.getHeader("User-Agent"));
	if(request.getHeader("User-Agent").toUpperCase().indexOf("MSIE")>-1){
		request.setAttribute("isIE",true);
	}else if(request.getHeader("User-Agent").toUpperCase().indexOf("TRIDENT")>-1){
		request.setAttribute("isIE",true);
	}else{
		request.setAttribute("isIE",false);
	}
	
	String isJGSignatureHTMLEnabled = ResourceUtil.getKmssConfigString("sys.att.isJGSignatureHTMLEnabled");
	request.setAttribute("JGSignatureHTMLEnabled",isJGSignatureHTMLEnabled);
%>
<%if("tab".equals(KmImissiveConfigUtil.getDisplayMode())){ %>
<template:include ref="missive.view"  sidebar="auto" >
	<jsp:include page="/km/imissive/km_imissive_receive_main/kmImissiveReceiveMain_viewHead.jsp"/>
	<jsp:include page="/km/imissive/km_imissive_receive_main/kmImissiveReceiveMain_tabContent.jsp"/>
</template:include>
<%}else{ %>
<template:include ref="default.view"  sidebar="auto" >
	<jsp:include page="/km/imissive/km_imissive_receive_main/kmImissiveReceiveMain_viewHead.jsp"/>
	<jsp:include page="/km/imissive/km_imissive_receive_main/kmImissiveReceiveMain_flatContent.jsp"/>
</template:include>
<%} %>	
