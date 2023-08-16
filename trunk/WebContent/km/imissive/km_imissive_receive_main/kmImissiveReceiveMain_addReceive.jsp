<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="/sys/ui/jsp/common.jsp"%>
<template:include ref="default.edit"   sidebar="auto">
<%@page import="com.landray.kmss.km.imissive.util.KmImissiveConfigUtil"%>
<%@page import="com.landray.kmss.sys.attachment.integrate.wps.util.SysAttWpsCloudUtil"%>
	<%@page import="com.landray.kmss.sys.attachment.integrate.wps.util.SysAttWpsCenterUtil"%>
	<%@ page import="com.landray.kmss.km.imissive.util.ImissiveUtil" %>
	<%
	pageContext.setAttribute("_isWpsCloudEnable", new Boolean(ImissiveUtil.isEnableWpsCloud()));
	pageContext.setAttribute("_isWpsCenterEnable", new Boolean(SysAttWpsCenterUtil.isEnable()));
%>
	<template:replace name="title">
		<c:out value="${lfn:message('km-imissive:kmImissiveReceiveMain.create.title') } - ${ lfn:message('km-imissive:module.km.imissive') }"></c:out>	
	</template:replace>
	<template:replace name="toolbar">
	  <ui:toolbar id="toolbar" layout="sys.ui.toolbar.float" count="6"> 
	   <%@ include file="/km/imissive/script.jsp"%>
			<ui:button text="${lfn:message('button.savedraft') }" order="2" onclick="commitMethod('saveReceive','true');">
			</ui:button>
			<ui:button text="${lfn:message('button.submit') }" order="2" onclick="commitMethod('saveReceive','false');">
			</ui:button>
	     <ui:button text="${ lfn:message('button.close') }" order="5"  onclick="Com_CloseWindow()">
		 </ui:button>
		</ui:toolbar>
	</template:replace>
	<template:replace name="path">
	<ui:menu layout="sys.ui.menu.nav"  id="categoryId"> 
			<ui:menu-item text="${ lfn:message('home.home') }" icon="lui_icon_s_home"></ui:menu-item>
			<ui:menu-item text="${ lfn:message('km-imissive:module.km.imissive') }" ></ui:menu-item>
			<ui:menu-item text="${ lfn:message('km-imissive:kmImissive.nav.ReceiveManagement') }"></ui:menu-item>
			<ui:menu-source autoFetch="false">
				<ui:source type="AjaxJson">
					{"url":"/sys/category/criteria/sysCategoryCriteria.do?method=path&modelName=com.landray.kmss.km.imissive.model.KmImissiveReceiveTemplate&categoryId=${kmImissiveReceiveMainForm.fdTemplateId}"} 
				</ui:source>
			</ui:menu-source>
		</ui:menu>
	</template:replace>
<template:replace name="content"> 
<html:form action="/km/imissive/km_imissive_receive_main/kmImissiveReceiveMain.do">
			<div class="lui_form_content_frame" style="padding-top: 5px" id="kmImissiveReceiveXform">
				<c:import url="/sys/xform/include/sysForm_edit.jsp"
					charEncoding="UTF-8">
					<c:param name="formName" value="kmImissiveReceiveMainForm" />
					<c:param name="fdKey" value="receiveMainDoc"/>
					<c:param name="messageKey" value="km-imissive:kmImissiveReceiveMain.baseinfo"/>
					<c:param name="useTab" value="false" />
				</c:import>
			</div>
			<div class="lui_form_content_frame" style="padding-top:10px">
		    <table class="tb_normal" width="100%">
					<html:hidden property="fdId"/>
					<html:hidden property="docStatus" />
					<html:hidden property="fdReceiveStatus" />
					<html:hidden property="fdModelId" />
					<html:hidden property="fdModelName"/>
					<html:hidden property="fdMainId"/>
					<html:hidden property="fdDetailId"/>
					<html:hidden property="fdDeliverType"/>
					<html:hidden property="fdTemplateId" />
					<html:hidden property="fdNeedContent"/>
					<html:hidden property="fdReadSendOpinion"/>
				<tr>
					<td class="td_normal_title" width=15%>
						<bean:message key="kmImissiveReceiveTemplate.fdNeedContent" bundle="km-imissive" />
					</td>
					<td width="85%" colspan="3">
						<xform:radio property="fdEditType" showStatus="edit" value="${kmImissiveReceiveMainForm.fdNeedContent}" onValueChange="checkEditType">
							<xform:enumsDataSource enumsType="kmImissiveReceiveTemplate_fdNeedContent" />
						</xform:radio>
					</td>
				</tr>
				<tr>
					<td colspan="4">
					<div id="wordEdit"  <c:if test="${kmImissiveReceiveMainForm.fdNeedContent!='1'}">style="width:0px;height:0px;"</c:if>>
					   <%@ include file="/km/imissive/km_imissive_receive_main/kmImissiveReceiveBookMark_script.jsp"%>
					   <c:choose>
					 		<c:when test="${_isWpsCloudEnable}">
					 			<c:import url="/km/imissive/import/xformBookmark_include.jsp"	charEncoding="UTF-8">
									<c:param name="formName" value="kmImissiveReceiveMainForm" />
									<c:param name="fdTemplateId" value="${kmImissiveReceiveMainForm.fdTemplateId }" />
								</c:import>
								<div id="missiveButtonDiv" style="text-align:right;">&nbsp;
									<a href="javascript:void(0);" class="attbook"
								   		onclick="Com_OpenWindow(Com_Parameter.ContextPath+'km/imissive/km_imissive_receive_main/bookMarks.jsp','_blank');">
							     		<bean:message key="kmImissive.bookMarks.title" bundle="km-imissive" />
							     	</a>
								</div>
								<div id="wordEditWrapper"></div>
								<div id="wordEditFloat" style="width:0px;height:0px;filter:alpha(opacity=0);opacity:0;">
									<c:import url="/sys/attachment/sys_att_main/wps/cloud/sysAttMain_edit.jsp" charEncoding="UTF-8">
										<c:param name="fdKey" value="editonline" />
										<c:param name="load" value="false" />
										<c:param name="bindSubmit" value="false"/>	
										<c:param name="fdModelId" value="${kmImissiveReceiveMainForm.fdId}" />
										<c:param name="fdModelName" value="com.landray.kmss.km.imissive.model.KmImissiveReceiveMain" />
										<c:param name="formBeanName" value="kmImissiveReceiveMainForm" />
										<c:param name="fdTemplateModelId" value="${kmImissiveReceiveMainForm.fdTemplateId}" />
										<c:param name="fdTemplateModelName" value="com.landray.kmss.km.imissive.model.KmImissiveReceiveTemplate" />
										<c:param name="fdTemplateKey" value="editonline" />
										<c:param name="fdTempKey" value="${kmImissiveReceiveMainForm.fdTemplateId}" />
										<c:param name="buttonDiv" value="missiveButtonDiv" />
									</c:import>
								</div>
							</c:when>
						   <c:when test="${_isWpsenterEnable}">
							   <c:import url="/km/imissive/import/xformBookmark_include.jsp"	charEncoding="UTF-8">
								   <c:param name="formName" value="kmImissiveReceiveMainForm" />
								   <c:param name="fdTemplateId" value="${kmImissiveReceiveMainForm.fdTemplateId }" />
							   </c:import>
							   <div id="missiveButtonDiv" style="text-align:right;">&nbsp;
								   <a href="javascript:void(0);" class="attbook"
									  onclick="Com_OpenWindow(Com_Parameter.ContextPath+'km/imissive/km_imissive_receive_main/bookMarks.jsp','_blank');">
									   <bean:message key="kmImissive.bookMarks.title" bundle="km-imissive" />
								   </a>
							   </div>
							   <div id="wordEditWrapper"></div>
							   <div id="wordEditFloat" style="width:0px;height:0px;filter:alpha(opacity=0);opacity:0;">
								   <c:import url="/sys/attachment/sys_att_main/wps/center/sysAttMain_edit.jsp" charEncoding="UTF-8">
									   <c:param name="fdKey" value="editonline" />
									   <c:param name="load" value="true" />
									   <c:param name="bindSubmit" value="false"/>
									   <c:param name="fdModelId" value="${kmImissiveReceiveMainForm.fdId}" />
									   <c:param name="fdModelName" value="com.landray.kmss.km.imissive.model.KmImissiveReceiveMain" />
									   <c:param name="formBeanName" value="kmImissiveReceiveMainForm" />
									   <c:param name="fdTemplateModelId" value="${kmImissiveReceiveMainForm.fdTemplateId}" />
									   <c:param name="fdTemplateModelName" value="com.landray.kmss.km.imissive.model.KmImissiveReceiveTemplate" />
									   <c:param name="fdTemplateKey" value="editonline" />
									   <c:param name="fdTempKey" value="${kmImissiveReceiveMainForm.fdTemplateId}" />
									   <c:param name="buttonDiv" value="missiveButtonDiv" />
								   </c:import>
							   </div>
						   </c:when>
							<c:otherwise>
					   			<%@ include file="/sys/attachment/sys_att_main/jg/sysAttMain_CheckJgSupport.jsp"%>
					    		<c:if test="${supportJg eq 'supported'}">
							   		<c:import url="/km/imissive/import/xformBookmark_include.jsp"	charEncoding="UTF-8">
										<c:param name="formName" value="kmImissiveReceiveMainForm" />
										<c:param name="fdTemplateId" value="${kmImissiveReceiveMainForm.fdTemplateId }" />
									</c:import>
									<div id="missiveButtonDiv" style="text-align:right;">&nbsp;
										<a href="javascript:void(0);" class="attbook"
									   		onclick="Com_OpenWindow(Com_Parameter.ContextPath+'km/imissive/km_imissive_receive_main/bookMarks.jsp','_blank');">
								     		<bean:message key="kmImissive.bookMarks.title" bundle="km-imissive" />
								     	</a>
									</div>
								</c:if>
								<div id="wordEditWrapper"></div>
								<div id="wordEditFloat" style="width:0px;height:0px;filter:alpha(opacity=0);opacity:0;">
									<c:import url="/sys/attachment/sys_att_main/jg/sysAttMain_edit.jsp" charEncoding="UTF-8">
									    <c:param name="fdKey" value="editonline" />
										<c:param name="fdAttType" value="office" />
									    <c:param name="load" value="false" />
										<c:param name="bindSubmit" value="false"/>
										<c:param name="fdMulti" value="false" />
										<c:param name="fdModelId" value="${kmImissiveReceiveMainForm.fdId}" />
										<c:param name="fdModelName" value="com.landray.kmss.km.imissive.model.KmImissiveReceiveMain" />
										<c:param name="formBeanName" value="kmImissiveReceiveMainForm" />
										<c:param name="fdTemplateModelId" value="${kmImissiveReceiveMainForm.fdTemplateId}" />
										<c:param name="fdTemplateModelName" value="com.landray.kmss.km.imissive.model.KmImissiveReceiveTemplate" />
										<c:param name="fdTemplateKey" value="editonline"/>
										<c:param name="templateBeanName" value="kmImissiveReceiveTemplateForm" />
										<c:param name="buttonDiv" value="missiveButtonDiv" />
										<c:param name="isToImg" value="<%=KmImissiveConfigUtil.isShowImg()%>"/>
									    <c:param  name="bookMarks"  value="${bookmarkJson}"/>
									    <c:param name="attHeight" value="566"/>
									 </c:import>
								</div>
							</c:otherwise>
						</c:choose>
					</div>
					  <div id="attEdit" <c:if test="${kmImissiveReceiveMainForm.fdNeedContent!='0'}">style="display:none"</c:if>>
					      <div class="lui_form_spacing"></div> 
				            <div>
							   <div class="lui_form_subhead"><img src="${KMSS_Parameter_ContextPath}sys/attachment/view/img/attachment.png">正文附件</div>
								<c:import url="/sys/attachment/sys_att_main/sysAttMain_edit.jsp" charEncoding="UTF-8">
									<c:param name="fdKey" value="mainonline" />
									<c:param  name="fdMulti" value="false" />
									<c:param name="uploadAfterSelect" value="true" />
									<c:param name="fdModelId" value="${kmImissiveReceiveMainForm.fdId }" />
									<c:param name="fdModelName" value="com.landray.kmss.km.imissive.model.KmImissiveReceiveMain" />
								</c:import>
							</div>
						</div>
					</td>
				</tr>
			</table>
			</div>
			<div class="lui_form_content_frame" style="padding-top:10px">
				<div style="padding-left:9px;padding-top: 5px;padding-bottom: 15px;">
					<div class="lui_form_subhead"><img src="${KMSS_Parameter_ContextPath}sys/attachment/view/img/attachment.png"> ${ lfn:message('sys-doc:sysDocBaseInfo.docAttachments') }</div>
				    <c:import
						url="/sys/attachment/sys_att_main/sysAttMain_edit.jsp"
						charEncoding="UTF-8">
						<c:param name="fdKey" value="attachment" />
						<c:param name="fdModelId" value="${param.fdId }" />
						<c:param name="fdModelName"
							value="com.landray.kmss.km.imissive.model.KmImissiveReceiveMain" />
					</c:import>
				</div> 	
		   </div>
			<ui:tabpage expand="false">
		<!-- 以下代码为嵌入流程模板标签的代码 -->
		<c:import url="/sys/workflow/import/sysWfProcess_edit.jsp"
			charEncoding="UTF-8">
			<c:param name="formName" value="kmImissiveReceiveMainForm" />
			<c:param name="fdKey" value="receiveMainDoc" />
			<c:param name="showHistoryOpers" value="true" />
			<c:param name="isExpand" value="true" />
		</c:import>
		<!-- 以上代码为嵌入流程模板标签的代码 -->
		<!--发布机制开始-->
		<c:import url="/sys/news/import/sysNewsPublishMain_edit.jsp"
			charEncoding="UTF-8">
			<c:param name="formName" value="kmImissiveReceiveMainForm" />
			<c:param name="fdKey" value="receiveMainDoc" />
			<c:param name="isShow" value="true" />
		</c:import>
		<!--发布机制结束-->
		<!-- 权限机制-->
	
		<c:import url="/sys/right/import/right_edit.jsp" charEncoding="UTF-8">
			<c:param name="formName" value="kmImissiveReceiveMainForm" />
			<c:param name="moduleModelName" value="com.landray.kmss.km.imissive.model.KmImissiveReceiveMain" />
		</c:import>
	</ui:tabpage>
<html:hidden property="method_GET"/>
</html:form>
<script language="JavaScript">
		var validation = $KMSSValidation(document.forms['kmMissiveReceiveMainForm']);
</script>
<%@ include file="/km/imissive/cookieUtil_script.jsp"%>
<script language="JavaScript">
seajs.use(['sys/ui/js/dialog'], function(dialog) {
	window.dialog = dialog;
});
</script>
<%@ include file="/km/imissive/km_imissive_receive_main/kmImissiveNumber_script.jsp"%>
</template:replace>
<template:replace name="nav">
       <!-- 关联机制 -->
	    <c:import url="/sys/relation/import/sysRelationMain_edit.jsp" charEncoding="UTF-8">
			<c:param name="formName" value="kmImissiveReceiveMainForm" />
		</c:import>
		<!-- 关联机制 -->
</template:replace>
</template:include>
