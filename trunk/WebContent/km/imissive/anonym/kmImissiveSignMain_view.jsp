<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/sys/ui/jsp/common.jsp"%>
<%@page import="com.landray.kmss.sys.attachment.util.JgWebOffice"%>
<%@ page import="java.util.List" %>
<c:set var="sysAttMains" value="${sysAnonymCommonForm.attachmentForms['fileContentKey'].attachments}"></c:set>
<%
	List sysAttMains = (List)pageContext.getAttribute("sysAttMains");
	int attSize = 0;
	if (sysAttMains != null) {
		attSize = sysAttMains.size();
	}
%>

<template:include ref="default.view" >
 	<template:replace name="head">
 		<style type="text/css">
	 		.headline{
	 			margin: 15px 0;
				line-height: 1.42857143;
				text-align: left;
				padding: 10px 0;
				border-bottom: 1px solid #d7d7d7;
	 		}
	 	</style>
    </template:replace>
	<template:replace name="title">
		<c:out value="${sysAnonymCommonForm.fdName} - ${ lfn:message('km-imissive:module.km.imissive') }"></c:out>
	</template:replace>
	<template:replace name="toolbar">
		<ui:toolbar id="toolbar" layout="sys.ui.toolbar.float" count="5">
			<ui:button text="${lfn:message('button.close')}" order="5"
				onclick="Com_CloseWindow();">
			</ui:button>
		</ui:toolbar>
	</template:replace>
	<template:replace name="content">
		<div class='lui_form_title_frame'>
			<div class='lui_form_subject'>
				<bean:write name="sysAnonymCommonForm" property="fdName" />
			</div>
			<div class='lui_form_baseinfo'>
				<!--发布日期-->
				<c:if test="${ not empty sysAnonymCommonForm.docPublishTime }">
					<span><bean:write name="sysAnonymCommonForm" property="docPublishTime" /></span>
				</c:if>
				<!-- 拟稿人 -->
				<bean:message bundle="km-imissive" key="kmImissiveSendMain.fdDraftId" />：
					<span>
						<c:out value="${sysAnonymCommonForm.docCreatorName}"></c:out>
					</span>
			</div>
		</div>
		<div class="headline"></div>
		<!--内容-->
		<%
		    if (attSize > 1 || !JgWebOffice.isExistViewPath(request)) { 
	    %>
		
		<div class="lui_form_spacing"></div>
			<div>
				<c:import url="/sys/anonym/dataview/attachment/sysAttMain_view.jsp" charEncoding="UTF-8">
					<c:param name="fdViewType" value="/sys/anonym/dataview/attachment/anoym_display.js" />
					<c:param name="formBeanName" value="sysAnonymCommonForm" />
					<c:param name="fdKey" value="fileContentKey" />
					<c:param name="fdModelName" value="com.landray.kmss.sys.anonym.model.SysAnonymCommon" />
				</c:import>
			</div>
		</div>
		
		<% } else { %>
		
		<div class="lui_form_content_frame clearfloat" id="lui_form_content_frame">
			<div style="min-height: 150px;" id="contentDiv">
			<c:out value="${sysAnonymCommonForm.fdId}"></c:out>
				<c:import url="/sys/anonym/dataview/attachment/sysAttMain_viewHtml.jsp" charEncoding="UTF-8">
					<c:param name="fdKey" value="fileContentKey" />
					<c:param name="fdAttType" value="office" />
					<c:param name="fdModelId" value="${sysAnonymCommonForm.fdId}" />
					<c:param name="fdModelName" value="com.landray.kmss.sys.anonym.model.SysAnonymCommon" />
					<c:param name="isExpand" value="true" />
				</c:import>
			</div>
		</div>
			
		<% } %>
	</template:replace>
</template:include>