<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="/sys/ui/jsp/common.jsp"%>
<template:include ref="default.edit" sidebar="auto">
<%@ page import="com.landray.kmss.util.IDGenerator"%>

	<template:replace name="title">
		<c:choose>
			<c:when test="${ kmImissiveSendMainForm.method_GET == 'add' }">
				<c:out value="${lfn:message('km-imissive:kmImissiveSendMain.create.title') } - ${ lfn:message('km-imissive:module.km.imissive') }"></c:out>	
			</c:when>
			<c:otherwise>
				<c:out value="${kmImissiveSendMainForm.docSubject} - ${ lfn:message('km-imissive:module.km.imissive') }"></c:out>
			</c:otherwise>
		</c:choose>
	</template:replace>
	<template:replace name="toolbar">
		<%@ include file="/km/imissive/script.jsp"%>
		<!-- 软删除配置 -->
		<c:if test="${kmImissiveSendMainForm.docDeleteFlag ==1}">
			<ui:toolbar id="toolbar" style="display:none;" count="6"></ui:toolbar>
		</c:if>
		<c:if test="${kmImissiveSendMainForm.docDeleteFlag !=1}">
			<ui:toolbar id="toolbar" layout="sys.ui.toolbar.float" count="6">
				<c:if test="${kmImissiveSendMainForm.method_GET=='add'}">
					<ui:button text="${lfn:message('button.submit') }" order="2"
						onclick=" commitMethodOffLine('save','false');">
					</ui:button>
				</c:if>
				<c:if test="${kmImissiveSendMainForm.method_GET=='edit'}">
					<ui:button text="${lfn:message('button.submit') }" order="2"
						onclick="  Com_Submit(document.kmImissiveSendMainForm, 'update');">
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
							{"url":"/sys/category/criteria/sysCategoryCriteria.do?method=path&modelName=com.landray.kmss.km.imissive.model.KmImissiveSendTemplate&categoryId=${kmImissiveSendMainForm.fdTemplateId}"} 
						</ui:source>
					</ui:menu-source>
				</ui:menu>
			</div>
			<c:choose>
				<c:when test="${ kmImissiveSendMainForm.method_GET == 'add' }">
					<div class="lui_form_path_item_r">
						- 发文拟稿
					</div>
				</c:when>
				<c:otherwise>
					<kmss:showWfPropertyValues var="nodevalue" idValue="${kmImissiveSendMainForm.fdId}" propertyName="nodeName" />
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
		<c:param name="formBeanName" value="kmImissiveSendMainForm"></c:param>
	</c:import>	
	
	<%@ include file="/km/imissive/km_imissive_send_main/kmImissiveSendMain_editScript.jsp"%>
		<html:form action="/km/imissive/km_imissive_send_main/kmImissiveSendMain.do">
			<html:hidden property="fdId" />
			<html:hidden property="docStatus"/>
			<html:hidden property="fdDetailId" />
			<html:hidden property="fdMainId" />
			<html:hidden property="fdModelId" />
			<html:hidden property="fdModelName" />
			<html:hidden property="fdReadSendOpinion" value="0"/>
			<html:hidden property="fdIsFromOut" value="0"/>
			<html:hidden property="fdNeedContent" value="0"/>
			<html:hidden property="fdIsOffLine" value="1"/>
			<input type="hidden" name="fdTemplateId" value="${kmImissiveSendMainForm.fdTemplateId}"/>
			<div class="lui_form_content_frame" style="padding-top: 5px" id="kmImissiveSendXform">
				<table class="tb_normal" width=100%>
					<tr>
						<td class="td_normal_title" width=15%>
							<bean:message bundle="km-imissive" key="kmImissiveSendMain.docSubject" />
						</td>
						<td width=85% colspan="3">
							<xform:text property="docSubject" style="width:80%;" required="true"></xform:text>
						</td>
					</tr>
					<tr>
						<td class="td_normal_title" width=15%>
							<bean:message bundle="km-imissive" key="kmImissiveSendMain.fdDraftId" />
						</td>
						<td width=35%>
							<xform:address 
							        subject="${lfn:message('km-imissive:kmImissiveSendMain.fdDraftId') }"
							        propertyId="fdDrafterId"
							        propertyName="fdDrafterName" 
							        orgType="ORG_TYPE_PERSON"
							        required="true" 
							         style="width:95%"
							        className="inputsgl">
							</xform:address>
						</td>
						<td class="td_normal_title" width=15%>
							<bean:message bundle="km-imissive" key="kmImissiveSendMain.fdDraftDeptId2" />
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
							<bean:message bundle="km-imissive" key="kmImissiveSendMain.fdDocNum" />
						</td>
						<td width=35%>
							<html:hidden property="fdDocNum" />
							<html:hidden property="fdFlowNo" />
							<html:hidden property="fdNoRule" />
							<html:hidden property="fdNumberMainId" />
							<html:hidden property="fdYearNo" />
							<span id="docnum"> 
							  <c:if test="${not empty kmImissiveSendMainForm.fdDocNum}">
							   <c:out value="${kmImissiveSendMainForm.fdDocNum}"/>
							  </c:if>
							  <c:if test="${empty kmImissiveSendMainForm.fdDocNum and required != 'true'}">
							    <bean:message  bundle="km-imissive" key="kmImissiveSendMain.docNum.info.submit"/>
							  </c:if>
							</span>
							<ui:button text="${lfn:message('km-imissive:kmImissive.modifyDocNum') }" order="3"
								 onclick="generateFileNum();">
							 </ui:button>
						</td>
						<td class="td_normal_title" width=15%>
							<bean:message bundle="km-imissive" key="kmImissiveSendMain.fdDraftTime" />
						</td>
						<td width=35%>
							<xform:datetime property="fdDraftTime"
								required="true"
				                showStatus="edit" 
				                dateTimeType="date" 
				                subject="${lfn:message('km-imissive:kmImissiveSendMain.fdDraftTime')}" />	
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
								<c:param name="fdModelName" value="com.landray.kmss.km.imissive.model.KmImissiveSendMain" />
							</c:import>
						</td>
					</tr>
				</table>	
			</div>
			<ui:tabpage expand="false">
				<ui:content title="${ lfn:message('sys-right:right.moduleName') }">
					<table class="tb_normal" width=100%>
						<c:import url="/sys/right/right_edit.jsp" charEncoding="UTF-8">
							<c:param name="formName" value="kmImissiveSendMainForm" />
							<c:param name="moduleModelName" value="com.landray.kmss.km.imissive.model.KmImissiveSendMain" />
						</c:import>
					</table>
				</ui:content>
			</ui:tabpage>
			<div style="display:none">
				<ui:tabpage expand="true">
					<!-- 以下代码为嵌入流程模板标签的代码 -->
					<c:import url="/sys/workflow/import/sysWfProcess_edit.jsp"
						charEncoding="UTF-8">
						<c:param name="formName" value="kmImissiveSendMainForm" />
						<c:param name="fdKey" value="sendMainDoc" />
						<c:param name="showHistoryOpers" value="true" />
						<c:param name="method" value="${param.method == 'addSend' or param.method == 'addSendOuter'? 'add':param.method}" />
						<c:param name="isExpand" value="true" />
					</c:import>
					<!-- 以上代码为嵌入流程模板标签的代码 -->
					<!--发布机制开始-->
					<c:import url="/sys/news/import/sysNewsPublishMain_edit.jsp"
						charEncoding="UTF-8">
						<c:param name="formName" value="kmImissiveSendMainForm" />
						<c:param name="fdKey" value="sendMainDoc" />
						<c:param name="isShow" value="true" />
					</c:import>
					<!--发布机制结束-->
					<!-- 版本锁机制 -->
					<c:import url="/component/locker/import/componentLockerVersion_import.jsp" charEncoding="UTF-8">
						<c:param name="formName" value="kmImissiveSendMainForm" />
					</c:import>
				</ui:tabpage>
			</div>
		  <html:hidden property="method_GET" />
		</html:form>
		<script language="JavaScript">
			var validation = $KMSSValidation(document.forms['kmImissiveSendMainForm']);
			
			//提交时校验的数组
			var kmImissiveEvent = kmImissiveEvent || new Array;
			kmImissiveEvent.push(function(){
				 var dtd = $.Deferred();
				var docNum = document.getElementsByName("fdDocNum")[0];
				if(docNum.value == ""){
					dialog.confirm('<bean:message key="kmImissive.number.notNull" bundle="km-imissive" />',function(rtn){
						if(rtn==true){ 
							if("${fdNoId}" != ""){
							    generateAutoNum();
							    dtd.resolve();
							}else{
								 dtd.resolve();
							}
						}else{
							dtd.reject();
						}
					});
				}else{
					 dtd.resolve();
				}
				return dtd;
			});
		</script>
	</template:replace>
</template:include>
