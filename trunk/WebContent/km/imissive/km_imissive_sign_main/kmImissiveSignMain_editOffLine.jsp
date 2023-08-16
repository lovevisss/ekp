<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="/sys/ui/jsp/common.jsp"%>
<template:include ref="default.edit" sidebar="auto">
<%@ page import="com.landray.kmss.util.IDGenerator"%>

	<template:replace name="title">
		<c:choose>
			<c:when test="${ kmImissiveSignMainForm.method_GET == 'add' }">
				<c:out value="${lfn:message('km-imissive:kmImissiveSignMain.create.title') } - ${ lfn:message('km-imissive:module.km.imissive') }"></c:out>	
			</c:when>
			<c:otherwise>
				<c:out value="${kmImissiveSignMainForm.docSubject} - ${ lfn:message('km-imissive:module.km.imissive') }"></c:out>
			</c:otherwise>
		</c:choose>
	</template:replace>
	<template:replace name="toolbar">
		<%@ include file="/km/imissive/script.jsp"%>
		<!-- 软删除配置 -->
		<c:if test="${kmImissiveSignMainForm.docDeleteFlag ==1}">
			<ui:toolbar id="toolbar" style="display:none;" count="6"></ui:toolbar>
		</c:if>
		<c:if test="${kmImissiveSignMainForm.docDeleteFlag !=1}">
			<ui:toolbar id="toolbar" layout="sys.ui.toolbar.float" count="6">
				<c:if test="${kmImissiveSignMainForm.method_GET=='add'}">
					<ui:button text="${lfn:message('button.submit') }" order="2"
						onclick=" commitMethodOffLine('save','false');">
					</ui:button>
				</c:if>
				<c:if test="${kmImissiveSignMainForm.method_GET=='edit'}">
					<ui:button text="${lfn:message('button.submit') }" order="2"
						onclick="  Com_Submit(document.kmImissiveSignMainForm, 'update');">
					</ui:button>
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
							{"url":"/sys/category/criteria/sysCategoryCriteria.do?method=path&modelName=com.landray.kmss.km.imissive.model.KmImissiveSignTemplate&categoryId=${kmImissiveSignMainForm.fdTemplateId}"} 
						</ui:source>
					</ui:menu-source>
				</ui:menu>
			</div>
			<c:choose>
				<c:when test="${ kmImissiveSignMainForm.method_GET == 'add' }">
					<div class="lui_form_path_item_r">
						- 签报拟稿
					</div>
				</c:when>
				<c:otherwise>
					<kmss:showWfPropertyValues var="nodevalue" idValue="${kmImissiveSignMainForm.fdId}" propertyName="nodeName" />
					<div class="lui_form_path_item_r">
				        <c:out value="${nodevalue}"></c:out>
				    </div>
				</c:otherwise>
			</c:choose>
		</div>
	</template:replace>
	<template:replace name="content">
		<script>
			Com_IncludeFile("data.js|jquery.js");
			Com_IncludeFile('styles.css|jquery.ui.widget.js|jquery.marcopolo.js|jquery.manifest.js','js/jquery-plugin/manifest/');
		</script>
	<!-- 软删除配置 -->
	<c:import url="/sys/recycle/import/redirect.jsp" charEncoding="UTF-8">
		<c:param name="formBeanName" value="kmImissiveSignMainForm"></c:param>
	</c:import>	
	
	<%@ include file="/km/imissive/km_imissive_sign_main/kmImissiveSignMain_editScript.jsp"%>
		<html:form action="/km/imissive/km_imissive_sign_main/kmImissiveSignMain.do">
			<html:hidden property="docStatus"/>
			<html:hidden property="fdId"/>
			<html:hidden property="fdModelId" />
			<html:hidden property="fdModelName"/>
			<html:hidden property="fdNeedContent" value="0"/>
			<html:hidden property="fdIsOffLine" value="1"/>
			<input type="hidden" name="fdTemplateId" value="${kmImissiveSignMainForm.fdTemplateId}"/>
			<div class="lui_form_content_frame" style="padding-top: 5px" id="kmImissiveSignXform">
				<table class="tb_normal" width=100%>
					<tr>
						<td class="td_normal_title" width=15%>
							<bean:message bundle="km-imissive" key="kmImissiveSignMain.docSubject" />
						</td>
						<td width=85% colspan="3">
							<xform:text property="docSubject" style="width:80%;" required="true"></xform:text>
						</td>
					</tr>
					<tr>
						<td class="td_normal_title" width=15%>
							<bean:message bundle="km-imissive" key="kmImissiveSignMain.fdDraftId" />
						</td>
						<td width=35%>
							<xform:address 
							        subject="${lfn:message('km-imissive:kmImissiveSignMain.fdDraftId') }"
							        propertyId="fdDrafterId"
							        propertyName="fdDrafterName" 
							        orgType="ORG_TYPE_PERSON"
							        required="true" 
							         style="width:95%"
							        className="inputsgl">
							</xform:address>
						</td>
						<td class="td_normal_title" width=15%>
							<bean:message bundle="km-imissive" key="kmImissiveSignMain.fdDraftDeptId" />
						</td>
						<td width=35%>
							<xform:address 
							        propertyId="fdDraftDeptId"
							        propertyName="fdDraftDeptName"
							        orgType="ORG_TYPE_DEPT"
							        required="true" 
							         style="width:95%"
							        className="inputsgl">
							</xform:address>
						</td>
					</tr>
					<tr>
						<td class="td_normal_title" width=15%>
							<bean:message bundle="km-imissive" key="kmImissiveSignMain.fdDocNum" />
						</td>
						<td width=35%>
							<html:hidden property="fdDocNum" />
							<html:hidden property="fdFlowNo" />
							<html:hidden property="fdNoRule" />
							<html:hidden property="fdNumberMainId" />
							<html:hidden property="fdYearNo" />
							<span id="docnum"> 
							  <c:if test="${not empty kmImissiveSignMainForm.fdDocNum}">
							   <c:out value="${kmImissiveSignMainForm.fdDocNum}"/>
							  </c:if>
							</span>
							<ui:button text="${lfn:message('km-imissive:kmImissive.modifyDocNum') }" order="3"
								 onclick="generateFileNum();">
							 </ui:button>
						</td>
						<td class="td_normal_title" width=15%>
							<bean:message bundle="km-imissive" key="kmImissiveSignMain.fdDraftTime" />
						</td>
						<td width=35%>
							<xform:datetime property="fdDraftTime"
								required="true"
				                showStatus="edit" 
				                dateTimeType="date" 
				                subject="${lfn:message('km-imissive:kmImissiveSignMain.fdDraftTime')}" />	
						</td>
					</tr>
					<tr>
						<td class="td_normal_title" width=15%>
							附件
						</td>
						<td width=85% colspan="3">
							<c:import url="/sys/attachment/sys_att_main/sysAttMain_edit.jsp" charEncoding="UTF-8">
								<c:param name="fdKey" value="attachment" />
								<c:param name="fdModelId" value="${param.fdId}" />
								<c:param name="uploadAfterSelect" value="true" />  
								<c:param name="fdModelName" value="com.landray.kmss.km.imissive.model.KmImissiveSignMain" />
							</c:import>
						</td>
					</tr>
				</table>	
			</div>
			
			<ui:tabpage expand="false">
				<!-- 权限机制  -->
				<ui:content title="${ lfn:message('sys-right:right.moduleName') }">
					<table class="tb_normal" width=100%>
						<c:import url="/sys/right/right_edit.jsp" charEncoding="UTF-8">
							<c:param name="formName" value="kmImissiveSignMainForm" />
							<c:param name="moduleModelName" value="com.landray.kmss.km.imissive.model.KmImissiveSignMain" />
						</c:import>
					</table>
				</ui:content>
				<!-- 权限机制 -->
		  </ui:tabpage>
		  <div style="display:none">
			  <ui:tabpage expand="true">	
				<!-- 以下代码为嵌入流程模板标签的代码 -->
				<c:import url="/sys/workflow/import/sysWfProcess_edit.jsp" charEncoding="UTF-8">
					<c:param name="formName" value="kmImissiveSignMainForm" />
					<c:param name="fdKey" value="signMainDoc" />
					<c:param name="showHistoryOpers" value="true" />
					<c:param name="isExpand" value="true" />
				</c:import>
				<!-- 以上代码为嵌入流程模板标签的代码 -->
				<!--发布机制开始-->
				<c:import url="/sys/news/import/sysNewsPublishMain_edit.jsp" charEncoding="UTF-8">
					<c:param name="formName" value="kmImissiveSignMainForm" />
					<c:param name="fdKey" value="signMainDoc" />
					<c:param name="isShow" value="true" />
				</c:import>
				<!--发布机制结束-->
				<!-- 版本锁机制 -->
				<c:import url="/component/locker/import/componentLockerVersion_import.jsp" charEncoding="UTF-8">
					<c:param name="formName" value="kmImissiveSignMainForm" />
				</c:import>
			</ui:tabpage>	
		</div>
		  <html:hidden property="method_GET" />
		</html:form>
		<script language="JavaScript">
			var validation = $KMSSValidation(document.forms['kmImissiveSignMainForm']);
		</script>
	</template:replace>
</template:include>
