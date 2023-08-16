<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="/sys/ui/jsp/common.jsp"%>
<template:include ref="default.view" sidebar="auto">
<%@ page import="com.landray.kmss.util.IDGenerator"%>

<template:replace name="title">
	<c:out
		value="${ kmImissiveSendMainForm.docSubject } - ${ lfn:message('km-imissive:module.km.imissive') }"></c:out>
</template:replace>

	<template:replace name="toolbar">
		<script>
			function editDoc(){
				Com_OpenWindow('kmImissiveSendMain.do?method=edit&fdId=${param.fdId}&fdTemplateId=${kmImissiveSendMainForm.fdTemplateId}','_self');
			};
		</script>
		<%@ include file="/km/imissive/script.jsp"%>
		<!-- 软删除配置 -->
		<c:if test="${kmImissiveSendMainForm.docDeleteFlag ==1}">
			<ui:toolbar id="toolbar" style="display:none;" count="6"></ui:toolbar>
		</c:if>
		<c:if test="${kmImissiveSendMainForm.docDeleteFlag !=1}">
			<ui:toolbar id="toolbar" layout="sys.ui.toolbar.float" count="6">
				<c:if test="${kmImissiveSendMainForm.fdIsFiling != true}">
					<kmss:auth
						requestURL="/km/imissive/km_imissive_send_main/kmImissiveSendMain.do?method=edit&fdId=${param.fdId}"
						requestMethod="GET">
							<ui:button text="${lfn:message('button.edit') }" order="4"
								onclick="editDoc();">
							</ui:button>
					</kmss:auth>
				</c:if>
				<ui:button text="${ lfn:message('button.close') }" order="5"
					onclick="Com_CloseWindow()">
				</ui:button>
			</ui:toolbar>
		</c:if>
	</template:replace>
	<template:replace name="path">
		<div class="lui_form_path">
			<div class="lui_form_path_item_l">
				流程:
			</div>
			<div class="lui_form_path_item_c">
				<ui:menu layout="sys.ui.menu.nav" id="categoryId">
					<ui:menu-source autoFetch="false">
						<ui:source type="AjaxJson">
							{"url":"/sys/category/criteria/sysCategoryCriteria.do?method=path&modelName=com.landray.kmss.km.imissive.model.KmImissiveSendTemplate&categoryId=${kmImissiveSendMainForm.fdTemplateId}"} 
						</ui:source>
					</ui:menu-source>
				</ui:menu>
			</div>
		</div>
	</template:replace>
	<template:replace name="content">
	<!-- 软删除配置 -->
	<c:import url="/sys/recycle/import/redirect.jsp" charEncoding="UTF-8">
		<c:param name="formBeanName" value="kmImissiveSendMainForm"></c:param>
	</c:import>	
	
	<div class="lui_form_content_frame" style="padding-top: 5px" id="kmImissiveSendXform">
		<table class="tb_normal" width=100%>
			<tr>
				<td class="td_normal_title" width=15%>
					<bean:message bundle="km-imissive" key="kmImissiveSendMain.docSubject" />
				</td>
				<td width=85% colspan="3">
					<c:out value="${kmImissiveSendMainForm.docSubject}"/>
				</td>
			</tr>
			<tr>
				<td class="td_normal_title" width=15%>
					<bean:message bundle="km-imissive" key="kmImissiveSendMain.fdDraftId" />
				</td>
				<td width=35%>
					<c:out value="${kmImissiveSendMainForm.fdDrafterName}"/>
				</td>
				<td class="td_normal_title" width=15%>
					<bean:message bundle="km-imissive" key="kmImissiveSendMain.fdDraftDeptId2" />
				</td>
				<td width=35%>
					<c:out value="${kmImissiveSendMainForm.fdDraftDeptName}"/>
				</td>
			</tr>
			<tr>
				<td class="td_normal_title" width=15%>
					<bean:message bundle="km-imissive" key="kmImissiveSendMain.fdDocNum" />
				</td>
				<td width=35%>
					<c:out value="${kmImissiveSendMainForm.fdDocNum}"/>
				</td>
				<td class="td_normal_title" width=15%>
					<bean:message bundle="km-imissive" key="kmImissiveSendMain.fdDraftTime" />
				</td>
				<td width=35%>
					<xform:datetime property="fdDraftTime"   dateTimeType="date"  />	
				</td>
			</tr>
			<tr>
				<td class="td_normal_title" width=15%>
					附件
				</td>
				<td width=85% colspan="3">
					<c:import url="/sys/attachment/sys_att_main/sysAttMain_view.jsp"  charEncoding="UTF-8">
						<c:param name="formBeanName" value="kmImissiveSendMainForm" />
						<c:param name="fdKey" value="attachment" />
					</c:import>
				</td>
			</tr>
		</table>	
	</div>
	<ui:tabpage expand="false">
		<!-- 权限机制-->
		<ui:content title="${ lfn:message('sys-right:right.moduleName') }" titleicon="lui-tab-icon tab-icon-07">
			<table class="tb_normal" width=100%>
				<c:import url="/sys/right/right_view.jsp" charEncoding="UTF-8">
					<c:param name="formName" value="kmImissiveSendMainForm" />
					<c:param name="moduleModelName" value="com.landray.kmss.km.imissive.model.KmImissiveSendMain" />
				</c:import>
			</table>
		</ui:content>
	</ui:tabpage>
	</template:replace>
</template:include>
