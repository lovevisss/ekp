<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="/sys/ui/jsp/common.jsp"%>
<template:include ref="default.edit" sidebar="auto">
	<template:replace name="title">
		<c:choose>
			<c:when test="${ kmImeetingSchemeForm.method_GET == 'add' }">
				<c:out value="${lfn:message('km-imissive:kmImissiveSendMain.create.title') } - ${ lfn:message('km-imissive:module.km.imissive') }"></c:out>	
			</c:when>
			<c:otherwise>
				<c:out value="${kmImeetingSchemeForm.docSubject} - ${ lfn:message('km-imissive:module.km.imissive') }"></c:out>
			</c:otherwise>
		</c:choose>
	</template:replace>
	<template:replace name="toolbar">
		<ui:toolbar id="toolbar" layout="sys.ui.toolbar.float" count="6">
			<ui:button text="${ lfn:message('button.savedraft') }" order="2" onclick="_updateDraft();"></ui:button>
			<ui:button text="${lfn:message('button.submit') }" order="2" styleClass="lui_widget_btn_primary" isForcedAddClass="true" onclick="save('saveSend','false');">
						</ui:button>
		</ui:toolbar>
		
	</template:replace>
	<template:replace name="path">
		<ui:menu layout="sys.ui.menu.nav" id="categoryId">
		<ui:menu-item text="${ lfn:message('home.home') }"
			icon="lui_icon_s_home"></ui:menu-item>
		<ui:menu-item
			text="会议方案"></ui:menu-item>
		<ui:menu-item
			text="会议方案申报"></ui:menu-item>
		<ui:menu-source autoFetch="false">
			<ui:source type="AjaxJson">
				{"url":"/sys/category/criteria/sysCategoryCriteria.do?method=path&modelName=com.landray.kmss.km.imeeting.model.KmImeetingSchemeTemplate&categoryId=${kmImeetingSchemeForm.fdSchemeTemplateId}"} 
			</ui:source>
		</ui:menu-source>
	</ui:menu>
	</template:replace>
	<template:replace name="content">
	<form name="kmImeetingTopicForm" method="post" action ="${KMSS_Parameter_ContextPath}km/imeeting/km_imeeting_scheme/kmImeetingScheme.do">
	<html:hidden property="fdId" />
	<html:hidden property="method_GET" />
		 <ui:tabpanel id="tabpanelDiv" layout="sys.ui.tabpanel.view" var-count="4" var-average = 'false'>
	 	<ui:content id="kmImissiveSendMain_baseinfo" titleicon="lui-tab-icon tab-icon-02" title="详情">
	 	1
	 		<c:import url="/sys/xform/include/sysForm_edit.jsp" charEncoding="UTF-8">
				<c:param name="formName" value="kmImeetingSchemeForm" />
				<c:param name="fdKey" value="ImeetingScheme" />
				<c:param name="useTab" value="false" />
			</c:import>
	 	</ui:content>
	 	<ui:content id="kmImissiveSendMain_baseinfo" titleicon="lui-tab-icon tab-icon-02" title="正文">
	 		2
	 	</ui:content>
	 	<ui:content id="kmImissiveSendMain_baseinfo" titleicon="lui-tab-icon tab-icon-02" title="流程">
	 		3
	 	</ui:content>
	</form>
		
 	</ui:tabpanel>
	</template:replace>
</template:include>
