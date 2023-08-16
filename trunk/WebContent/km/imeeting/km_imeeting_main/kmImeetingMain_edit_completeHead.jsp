<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/sys/ui/jsp/common.jsp"%>
<%@ page import=" com.landray.kmss.util.ResourceUtil"%>
<%@page import="com.landray.kmss.util.SpringBeanUtil"%>
<%@page import="com.landray.kmss.km.imeeting.util.KmImeetingConfigUtil"%>
<%@page import="com.landray.kmss.sys.appconfig.service.ISysAppConfigService"%>
<%@page import="java.util.Map"%>
<%
	String modelName = "com.landray.kmss.km.imeeting.model.KmImeetingConfig";
	ISysAppConfigService sysAppConfigService = (ISysAppConfigService) SpringBeanUtil.getBean("sysAppConfigService");
	Map map = sysAppConfigService.findByKey(modelName);
	request.setAttribute("kmImeetingConfig", map);
	request.setAttribute("userId", UserUtil.getUser().getFdId());
	request.setAttribute("dateTimeFormatter",ResourceUtil.getString("date.format.datetime"));
%>
<template:replace name="head">
	<%-- 样式 --%>
	<style>
		.lui_imeeting_title{
			width: 60%;
			font-size: 16px;
			padding-left: 8px;
			line-height: 30px;
			height: 30px;
			border-bottom: 1px #d9d9d9 solid;
			margin-bottom: 10px;
		}
	</style>
	<script type="text/javascript">
		 Com_IncludeFile("security.js");
	     Com_IncludeFile("domain.js");
	     Com_IncludeFile("form.js");
	     Com_IncludeFile("sysUnitDialog.js", Com_Parameter.ContextPath+ "sys/unit/resource/js/", "js", true);
	     Com_IncludeFile("form_option.js", "${LUI_ContextPath}/km/imeeting/km_imeeting_main/", 'js', true);
	     Com_IncludeFile("main_edit.js", "${LUI_ContextPath}/km/imeeting/resource/js/", 'js', true);
	     Com_IncludeFile("swf_attachment.js", "${KMSS_Parameter_ContextPath}sys/attachment/js/", "js", true);
	     Com_IncludeFile('styles.css|jquery.ui.widget.js|jquery.marcopolo.js|jquery.manifest.js','js/jquery-plugin/manifest/');
     </script>
	<link rel="stylesheet" type="text/css" href="${LUI_ContextPath}/km/imeeting/resource/css/book.css"></link>
	<link rel="stylesheet" type="text/css" href="${LUI_ContextPath}/km/imeeting/resource/css/view.css"></link>
</template:replace>
<template:replace name="title">
	<c:choose>
		<c:when test="${ kmImeetingMainForm.method_GET == 'add' }">
			<c:out value="${ lfn:message('km-imeeting:kmImeetingMain.opt.create') } - ${ lfn:message('km-imeeting:module.km.imeeting') }"></c:out>	
		</c:when>
		<c:otherwise>
			<c:out value="${kmImeetingMainForm.fdName} - ${ lfn:message('km-imeeting:module.km.imeeting') }"></c:out>
		</c:otherwise>
	</c:choose>
</template:replace>

<template:replace name="toolbar">
	<ui:toolbar id="toolbar" layout="sys.ui.toolbar.float"> 
		<c:choose>
			<c:when test="${ kmImeetingMainForm.method_GET == 'add' }">
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
			<c:when test="${ kmImeetingMainForm.method_GET == 'edit' }">
				<c:if test="${kmImeetingMainForm.fdChangeMeetingFlag=='true'}">
					<c:if test="${kmImeetingMainForm.docStatus=='10'}">
						<c:choose>
							<c:when test="${param.approveModel eq 'right'}">
								<ui:button text="${lfn:message('km-imeeting:kmImeeting.changeMeeting') }" order="2" onclick="commitMethodChange('updateChange', 'false','true');" styleClass="lui_widget_btn_primary" isForcedAddClass="true">
								</ui:button> 
							</c:when>
							<c:otherwise>
								<ui:button text="${lfn:message('km-imeeting:kmImeeting.changeMeeting') }" order="2" onclick="commitMethodChange('updateChange', 'false','true');">
								</ui:button> 
							</c:otherwise>
						</c:choose>
					</c:if>
					<c:if test="${kmImeetingMainForm.docStatus !='10'}">
						<c:choose>
							<c:when test="${param.approveModel eq 'right'}">
								<ui:button text="${lfn:message('km-imeeting:kmImeeting.changeMeeting') }" order="2" onclick="commitMethodChange('update', 'false','true');" styleClass="lui_widget_btn_primary" isForcedAddClass="true">
								</ui:button>
							</c:when>
							<c:otherwise>
								<ui:button text="${lfn:message('km-imeeting:kmImeeting.changeMeeting') }" order="2" onclick="commitMethodChange('update', 'false','true');">
								</ui:button>
							</c:otherwise>
						</c:choose>
					</c:if>
				</c:if>
				<c:if test="${kmImeetingMainForm.fdChangeMeetingFlag=='false'}">
					<c:if test="${kmImeetingMainForm.docStatus=='10'}">
						 <ui:button text="${lfn:message('button.savedraft') }" order="2" onclick="commitMethodChange('update', 'true');">
						 </ui:button>
						 <c:choose>
							<c:when test="${param.approveModel eq 'right'}">
								<ui:button text="${lfn:message('button.submit') }" order="2" onclick="commitMethodChange('update', 'false');" styleClass="lui_widget_btn_primary" isForcedAddClass="true">
						 		</ui:button>
							</c:when>
							<c:otherwise>
								<ui:button text="${lfn:message('button.submit') }" order="2" onclick="commitMethodChange('update', 'false');">
						 		</ui:button>
							</c:otherwise>
						</c:choose>
					</c:if>
					<c:if test="${kmImeetingMainForm.docStatus=='11'}">
						<ui:button text="${lfn:message('button.savedraft') }" order="2" onclick="commitMethodChange('update', 'true');">
						</ui:button>
						<c:choose>
							<c:when test="${param.approveModel eq 'right'}">
								<ui:button text="${lfn:message('button.submit') }" order="2" onclick="commitMethodChange('update', 'false');" styleClass="lui_widget_btn_primary" isForcedAddClass="true">
						 		</ui:button>
							</c:when>
							<c:otherwise>
								<ui:button text="${lfn:message('button.submit') }" order="2" onclick="commitMethodChange('update', 'false');">
						 		</ui:button>
							</c:otherwise>
						</c:choose>
					</c:if>
					<c:if test="${kmImeetingMainForm.docStatus=='20'}">
						<c:choose>
							<c:when test="${param.approveModel eq 'right'}">
								<ui:button text="${lfn:message('button.submit') }" order="2" onclick="commitMethodChange('update', 'false');" styleClass="lui_widget_btn_primary" isForcedAddClass="true">
					 			</ui:button>
							</c:when>
							<c:otherwise>
								<ui:button text="${lfn:message('button.submit') }" order="2" onclick="commitMethodChange('update', 'false');">
					 			</ui:button>
							</c:otherwise>
						</c:choose>
					</c:if>
					<c:if test="${kmImeetingMainForm.docStatus>='30'}">
						<c:choose>
							<c:when test="${param.approveModel eq 'right'}">
								<ui:button text="${lfn:message('button.submit') }" order="2" onclick="commitMethodChange('update', 'false');" styleClass="lui_widget_btn_primary" isForcedAddClass="true">
					 			</ui:button>
							</c:when>
							<c:otherwise>
								<ui:button text="${lfn:message('button.submit') }" order="2" onclick="commitMethodChange('update', 'false');">
					 			</ui:button>
							</c:otherwise>
						</c:choose>
					</c:if>				
				</c:if> 
			</c:when>
		</c:choose>
		<ui:button text="${ lfn:message('button.close') }" order="5"  onclick="Com_CloseWindow()">
		</ui:button>
	</ui:toolbar>
</template:replace>

<template:replace name="path">
	<ui:menu layout="sys.ui.menu.nav"  id="categoryId"> 
		<ui:menu-item text="${ lfn:message('home.home') }" icon="lui_icon_s_home"></ui:menu-item>
		<ui:menu-item text="${ lfn:message('km-imeeting:module.km.imeeting') }" ></ui:menu-item>
		<ui:menu-item text="${ lfn:message('km-imeeting:table.kmImeetingMain') }"></ui:menu-item>
		<ui:menu-source autoFetch="false">
			<ui:source type="AjaxJson">
				{"url":"/sys/category/criteria/sysCategoryCriteria.do?method=path&modelName=com.landray.kmss.km.imeeting.model.KmImeetingTemplate&categoryId=${kmImeetingMainForm.fdTemplateId}"} 
			</ui:source>
		</ui:menu-source>
	</ui:menu>
</template:replace>