<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/sys/ui/jsp/common.jsp"%>
<%@page import="net.sf.json.JSONObject"%>
<%@page import="org.apache.commons.lang.StringEscapeUtils"%>

<template:include ref="mobile.view" scale="true">

	<template:replace name="title">
		<c:out value="${param.title }"></c:out>
	</template:replace>
	
	<template:replace name="head">
		<link rel="stylesheet" type="text/css"
		href="${LUI_ContextPath}/sys/attachment/mobile/viewer/base/css/attViewer.css?s_cache=${MUI_Cache}"></link>
	</template:replace>
	<template:replace name="content">
		<%
			JSONObject jsonobj=new JSONObject();
			jsonobj.accumulate("fdId",request.getAttribute("fdId"));
			jsonobj.accumulate("viewerParam",request.getAttribute("viewerParam"));
			jsonobj.accumulate("viewerStyle",request.getAttribute("viewerStyle"));
			jsonobj.accumulate("converterKey",request.getAttribute("converterKey"));
			jsonobj.accumulate("waterMarkConfig",JSONObject.fromObject(request.getAttribute("waterMarkConfig")));
			jsonobj.accumulate("fileKeySufix",request.getAttribute("fileKeySufix"));
			jsonobj.accumulate("highFidelity",request.getAttribute("highFidelity"));
			jsonobj.accumulate("scaleStr",request.getAttribute("scaleStr"));
			String jsonStr = jsonobj.toString();
			request.setAttribute("jsonParam",StringEscapeUtils.escapeHtml(jsonStr.substring(1,jsonStr.length()-1)));
		%>
		
		<script type="text/javascript">
		var attachmentCanCopy = false; // 附件是否可拷贝
		<kmss:auth requestURL="/sys/attachment/sys_att_main/sysAttMain.do?method=copy&fdId=${fdId}" requestMethod="GET">
		   attachmentCanCopy = true;
	    </kmss:auth>
	    
	    var attachmentCanDownload = false; // 附件是否可下载
		<kmss:auth requestURL="/sys/attachment/sys_att_main/sysAttMain.do?method=download&fdId=${fdId}" requestMethod="GET">
		attachmentCanDownload = true;
	    </kmss:auth>
	    
		</script>
				
		<div data-dojo-type="sys/attachment/mobile/viewer/pageviewer/PageViewer"
			data-dojo-props="${jsonParam}"></div>
			
		<!-- 页面计时组件 -->
		<c:if test="${not empty param._templateId && not empty param._contentId}">
			<div data-dojo-type="sys/attachment/mobile/js/AttachmentViewPageTime"
				data-dojo-props="fdId:'${param.fdId}',_templateId:'${param._templateId}',_contentId:'${param._contentId}'" />
		</c:if>
	</template:replace>
</template:include>
