<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="/sys/ui/jsp/common.jsp"%>
<template:replace name="head">
	<style type="text/css">
		.tb_simple>tbody>tr>.td_normal_title {
    		text-align: left;
		}
	</style>
</template:replace>
<template:replace name="title">
	<c:choose>
		<c:when test="${ kmImeetingSchemeForm.method_GET == 'add' }">
			<c:out value="${ lfn:message('km-imeeting:module.km.imeeting') }"></c:out>	
		</c:when>
		<c:otherwise>
			<c:out value="${kmImeetingSchemeForm.docSubject} - ${ lfn:message('km-imeeting:module.km.imeeting') }"></c:out>
		</c:otherwise>
	</c:choose>
</template:replace>
<template:replace name="toolbar">
  <ui:toolbar id="toolbar" layout="sys.ui.toolbar.float" count="6"> 
  	<c:choose>
		<c:when test="${ kmImeetingSchemeForm.method_GET == 'add' }">
			<ui:button text="${lfn:message('button.savedraft') }" order="2" onclick="commitMethod('save','true');">
			</ui:button>
			<c:choose>
				<c:when test="${param.approveModel eq 'right'}">
					<ui:button text="${lfn:message('button.submit') }" order="2" onclick="commitMethod('save','false');" styleClass="lui_widget_btn_primary" isForcedAddClass="true">
					</ui:button>
				</c:when>
				<c:otherwise>
					<ui:button text="${lfn:message('button.submit') }" order="2" onclick="commitMethod('save','false');">
					</ui:button>
				</c:otherwise>
			</c:choose>
		</c:when>
		<c:when test="${ kmImeetingSchemeForm.method_GET == 'edit' }">
			<c:if test="${kmImeetingSchemeForm.docStatusFirstDigit=='1'}">
				<ui:button text="${lfn:message('button.savedraft') }" order="2" onclick="commitMethod('update','true');">
				</ui:button>
			</c:if>
			<c:choose>
				<c:when test="${param.approveModel eq 'right'}">
					<c:if test="${kmImeetingSchemeForm.docStatusFirstDigit<'3'}">
						<ui:button text="${lfn:message('button.submit') }" order="2" onclick="commitMethod('update','false');" styleClass="lui_widget_btn_primary" isForcedAddClass="true">
						</ui:button>
					</c:if>
					<c:if test="${kmImeetingSchemeForm.docStatusFirstDigit>='3'}">
						<ui:button text="${lfn:message('button.submit') }" order="2" onclick="Com_Submit(document.kmImeetingSchemeForm, 'update');" styleClass="lui_widget_btn_primary" isForcedAddClass="true">
						</ui:button>
					</c:if>
				</c:when>
				<c:otherwise>
					<c:if test="${kmImeetingSchemeForm.docStatusFirstDigit<'3'}">
						<ui:button text="${lfn:message('button.submit') }" order="2" onclick="commitMethod('update','false');">
						</ui:button>
					</c:if>
					<c:if test="${kmImeetingSchemeForm.docStatusFirstDigit>='3'}">
						<ui:button text="${lfn:message('button.submit') }" order="2" onclick="Com_Submit(document.kmImeetingSchemeForm, 'update');">
						</ui:button>
					</c:if>	
				</c:otherwise>
			</c:choose>
		</c:when>
	</c:choose>
     <ui:button text="${ lfn:message('button.close') }" order="5"  onclick="Com_CloseWindow()">
	 </ui:button>
	</ui:toolbar>
</template:replace>
<template:replace name="path">
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
</template:replace>	