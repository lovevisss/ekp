<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@page import="com.landray.kmss.sys.xform.util.LangUtil"%>
<%@ include file="/resource/jsp/view_top.jsp"%>
<%@page import="com.landray.kmss.sys.attachment.integrate.wps.util.SysAttWpsCloudUtil"%>
<%@page import="com.landray.kmss.sys.attachment.integrate.wps.util.SysAttWpsCenterUtil"%>
<%@ page import="com.landray.kmss.km.imissive.util.ImissiveUtil"%>
<c:set var="wpsoaassist" value="<%=ImissiveUtil.isEnable()%>"/>
<c:set var="xinChuangWps" value="<%=ImissiveUtil.isWPSOAassistEmbed(request)%>"/>
<%
	pageContext.setAttribute("_isWpsCloudEnable", new Boolean(ImissiveUtil.isEnableWpsCloud()));
	pageContext.setAttribute("_isWpsCenterEnable", new Boolean(SysAttWpsCenterUtil.isEnable()));
%>
<script>
window.onload = function(){
	setTimeout("Doc_SetCurrentLabel('Label_Tabel', 2, true);", 500);
	// 添加标签切换事件
	var table = document.getElementById("Label_Tabel");
	if(table != null && window.Doc_AddLabelSwitchEvent){
		Doc_AddLabelSwitchEvent(table, "aaa");
	}
};
function aaa(tableName, index){
	var trs = document.getElementById(tableName).rows;
	if(trs[index].id =="tr_content"){
		$("#content").css({
			left:'34px',
			top:'135px',
			width:'95%',
			height:'550px'
		});
		if("${_isWpsCloudEnable}" == "true"){
			if($('#office-iframe')){
				var contentH = document.documentElement.clientHeight || document.body.clientHeight;
		 		$('#office-iframe').height( (contentH-180)+"px");
		 	}
		}
		if("${_isWpsCenterEnable}" == "true"){
			if($('#office-iframe')){
				var contentH = document.documentElement.clientHeight || document.body.clientHeight;
				$('#office-iframe').height( (contentH-180)+"px");
				$('#office-iframe').width("100%");
			}
		}
	}else{
		$("#missiveButtonDiv").hide();
		$("#content").css({
			left:'0px',
			top:'0px',
			width:'0px',
			height:'0px'

		});
	}
}
function confirmDelete(msg){
	var del = confirm("<bean:message key="page.comfirmDelete"/>");
	return del;
}
</script>
<div id="optBarDiv">
<kmss:auth
	requestURL="/km/imissive/km_imissive_sign_template/kmImissiveSignTemplate.do?method=edit&fdId=${param.fdId}"
	requestMethod="GET">
	<input type="button" value="<bean:message key="button.edit"/>"
		onclick="Com_OpenWindow('kmImissiveSignTemplate.do?method=edit&fdId=${param.fdId}','_self');">
</kmss:auth> 

<kmss:auth
	requestURL="/km/imissive/km_imissive_sign_template/kmImissiveSignTemplate.do?method=clone&cloneModelId=${param.fdId}"
	requestMethod="GET">
<input type="button" value="<kmss:message key="km-imissive:button.copy"/>"
		onclick="Com_OpenWindow('kmImissiveSignTemplate.do?method=clone&cloneModelId=${param.fdId}','_blank');">
</kmss:auth>

<kmss:auth
	requestURL="/km/imissive/km_imissive_sign_template/kmImissiveSignTemplate.do?method=delete&fdId=${param.fdId}"
	requestMethod="GET">
	<input type="button" value="<bean:message key="button.delete"/>"
		onclick="if(!confirmDelete())return;Com_OpenWindow('kmImissiveSignTemplate.do?method=delete&fdId=${param.fdId}','_self');">
</kmss:auth> <input type="button" value="<bean:message key="button.close"/>"
	onclick="Com_CloseWindow();"></div>
<p class="txttitle"><bean:message bundle="km-imissive"
	key="table.kmImissiveSignTemplate" /></p>
<center>
<c:if test="${kmImissiveSignTemplateForm.fdNeedContent=='1'}">
<div id="content" style="position:absolute;height: 1px;width: 1px;">
	<c:choose>
		<c:when test="${wpsoaassist eq 'true'}">
		</c:when>
		<c:when test="${_isWpsCloudEnable}">
			<c:import url="/sys/attachment/sys_att_main/wps/cloud/sysAttMain_view.jsp" charEncoding="UTF-8">
				<c:param name="fdKey" value="editonline" />
				<c:param name="fdModelId" value="${kmImissiveSignTemplateForm.fdId}" />
				<c:param name="fdModelName" value="com.landray.kmss.km.imissive.model.KmImissiveSignTemplate" />
				<c:param name="formBeanName" value="kmImissiveSignTemplateForm" />
				<c:param name="load" value="false" />
			</c:import>
		</c:when>
		<c:when test="${_isWpsCenterEnable}">
			<c:import url="/sys/attachment/sys_att_main/wps/center/sysAttMain_view.jsp" charEncoding="UTF-8">
				<c:param name="fdKey" value="editonline" />
				<c:param name="fdModelId" value="${kmImissiveSignTemplateForm.fdId}" />
				<c:param name="fdModelName" value="com.landray.kmss.km.imissive.model.KmImissiveSignTemplate" />
				<c:param name="formBeanName" value="kmImissiveSignTemplateForm" />
				<c:param name="wpsPreview" value="0010000" />
				<c:param name="load" value="false" />
			</c:import>
		</c:when>
		<c:otherwise>
			<c:import url="/sys/attachment/sys_att_main/jg/sysAttMain_view.jsp" charEncoding="UTF-8">
				<c:param name="fdKey" value="editonline" />
				<c:param name="fdAttType" value="office" />
				<c:param name="fdModelId" value="${param.fdId}" />
				<c:param name="buttonDiv" value="missiveButtonDiv" />
				<c:param name="isTemplate" value="true"/>
				<c:param name="fdModelName" value="com.landray.kmss.km.imissive.model.KmImissiveSignTemplate" />
			</c:import>
		</c:otherwise>
	</c:choose>
</div>
</c:if>
<table id="Label_Tabel" width=95% LKS_LabelDefaultIndex="2">
	<tr
		LKS_LabelName="<bean:message bundle='km-imissive' key='kmImissiveSignTemplate.templateinfo'/>">
		<td><html:hidden name="kmImissiveSignTemplateForm" property="fdId" />
		<table class="tb_normal" width=100%>
			<!-- 模板名称 -->
			<tr>
				<td class="td_normal_title" width=15%><bean:message
					bundle="km-imissive" key="kmImissiveSignTemplate.fdName" /></td>
				<td width=85% colspan="3"><bean:write name="kmImissiveSignTemplateForm"
					property="fdName" /></td>
			</tr>
			<!-- 适用类别 -->
			<tr>
				<td class="td_normal_title" width=15%><bean:message
					bundle="km-imissive" key="kmImissiveSignTemplate.fdCatoryName" /></td>
				<td width=85% colspan="3"><bean:write name="kmImissiveSignTemplateForm"
					property="fdCategoryName" /></td>
			</tr>
			<tr>
				<td class="td_normal_title" width=15%>
					<bean:message bundle="km-imissive" key="kmImissiveSignTemplate.fdFlowId" />
				</td>
				<td width=85% colspan="3">
					<%
						request.setAttribute("fdAllNumberFlag","1");
					    request.setAttribute("modelName","com.landray.kmss.km.imissive.model.KmImissiveSignMain");
					%>
					<xform:select property="fdFlowId"  htmlElementProperties="id='numberSelect'" style="width:200px" showStatus="view">
						<xform:customizeDataSource className="com.landray.kmss.sys.number.service.spring.SysNumberMainDataSource"></xform:customizeDataSource>
					</xform:select>
					<font color="red">
						<bean:message bundle="km-imissive" key="kmImissiveSignTemplate.fdFlowId.tips" />
						<bean:message bundle="km-imissive" key="kmImissiveSignTemplate.fdFlowId.tips1" />
						<bean:message bundle="km-imissive" key="kmImissiveSignTemplate.fdFlowId.tips2" />
					</font>
				</td>
			</tr>
			<tr>
				<!-- 排序号 -->
				<td class="td_normal_title" width=15%><bean:message
					bundle="km-imissive" key="kmImissiveSignTemplate.fdOrder" /></td>
				<td width=35%>
				<bean:write name="kmImissiveSignTemplateForm" property="fdOrder" /></td>
				<td class="td_normal_title" width=15%>
							<bean:message bundle="km-imissive" key="kmImissiveTemplate.fdIsAvailable" />
						</td>
					<td width=35%>
						 <c:if test="${kmImissiveSignTemplateForm.fdIsAvailable}">
							<bean:message bundle="km-imissive" key="kmImissiveTemplate.fdIsAvailable.true" />
						</c:if>
						<c:if test="${!kmImissiveSignTemplateForm.fdIsAvailable}">
							<bean:message bundle="km-imissive" key="kmImissiveTemplate.fdIsAvailable.false" />
						</c:if>
					</td>
			</tr>
			<%-- 所属场所 --%>
			<c:import url="/sys/authorization/sys_auth_area/sysAuthArea_field.jsp" charEncoding="UTF-8">
                <c:param name="id" value="${kmImissiveSignTemplateForm.authAreaId}"/>
            </c:import>	
			<!-- 可使用者 -->
			<tr>
				<td class="td_normal_title" width=15%><bean:message
					bundle="km-imissive" key="kmImissiveSignTemplate.authReaderIds" /></td>
				<td width=85% colspan="3"><bean:write name="kmImissiveSignTemplateForm"
					property="authReaderNames" /></td>
			</tr>
			<!-- 可维护者 -->
			<tr>
				<td class="td_normal_title" width=15%><bean:message
					bundle="km-imissive" key="kmImissiveSignTemplate.authEditorIds" /></td>
				<td width=85% colspan="3"><bean:write name="kmImissiveSignTemplateForm"
					property="authEditorNames" /></td>
			</tr>
			<tr>
					<td class="td_normal_title" width=15%><bean:message
						bundle="km-imissive" key="kmImissiveSignTemplate.authAppRecReaderIds" /></td>
					<td width=85% colspan="3">
					<bean:write name="kmImissiveSignTemplateForm" property="authTmpAppRecReaderNames" />
					</td>
			</tr>
			<tr>
				<!-- 创建人 -->
				<td class="td_normal_title" width=15%><bean:message
					bundle="km-imissive" key="kmImissiveSignTemplate.docCreatorId" /></td>
				<td width=35%><bean:write name="kmImissiveSignTemplateForm"
					property="docCreatorName" /></td>
			<!-- 创建时间 -->
				<td class="td_normal_title" width=15%><bean:message
					bundle="km-imissive" key="kmImissiveSignTemplate.docCreateTime" /></td>
				<td width=35%><bean:write name="kmImissiveSignTemplateForm"
					property="docCreateTime" /></td>
			</tr>
			<c:if test="${not empty kmImissiveSignTemplateForm.docAlterorName}">
			<tr>
				<!-- 修改人 -->
				<td class="td_normal_title" width=15%><bean:message
					bundle="km-imissive" key="kmImissiveSignTemplate.docAlterorId" /></td>
				<td width=35%><bean:write name="kmImissiveSignTemplateForm"
					property="docAlterorName" /></td>
				<!-- 修改时间 -->
				<td class="td_normal_title" width=15%><bean:message
					bundle="km-imissive" key="kmImissiveSignTemplate.docAlterTime" /></td>
				<td width=35%><bean:write name="kmImissiveSignTemplateForm"
					property="docAlterTime" /></td>
			</tr>
			</c:if>
		</table>
		</td>
	</tr>
	<!-- 表单 -->
	<c:import url="/sys/xform/include/sysFormTemplate_view.jsp"
		charEncoding="UTF-8">
		<c:param name="formName" value="kmImissiveSignTemplateForm" />
		<c:param name="fdKey" value="signMainDoc" />
		<c:param name="fdMainModelName" value="com.landray.kmss.km.imissive.model.KmImissiveSignMain" />
		<c:param name="messageKey" value="km-imissive:kmImissiveSignTemplate.baseinfo" />
	</c:import>
	<c:if test="${kmImissiveSignTemplateForm.fdNeedContent=='1'}">
	<tr id="tr_content" LKS_LabelName="<bean:message bundle="km-imissive" key="kmImissiveSendTemplate.docContent" />">
		<td id="td_content">
			<div id="missiveButtonDiv" style="text-align:right">
			</div>
			<c:if test="${wpsoaassist eq 'true'}">
				<c:choose>
					<c:when test="${xinChuangWps eq 'true'}">
						<c:import url="/sys/attachment/sys_att_main/wps/oaassist/linux/sysAttMain_view.jsp" charEncoding="UTF-8">
							<c:param name="formBeanName" value="kmImissiveSignTemplateForm" />
							<c:param name="fdKey" value="editonline" />
							<c:param name="fdModelId" value="${param.fdId}" />
							<c:param name="fdModelName" value="com.landray.kmss.km.imissive.model.KmImissiveSignTemplate" />
							<c:param name="load" value="${param.load}" />
						</c:import>
					</c:when>
					<c:otherwise>
						<c:import url="/sys/attachment/sys_att_main/sysAttMain_view.jsp" charEncoding="UTF-8">
							<c:param name="formBeanName" value="kmImissiveSignTemplateForm" />
							<c:param name="fdKey" value="editonline" />
							<c:param name="fdModelId" value="${param.fdId}" />
							<c:param name="fdModelName" value="com.landray.kmss.km.imissive.model.KmImissiveSignTemplate" />
						</c:import>
					</c:otherwise>
				</c:choose>
			</c:if>
		</td>
	</tr>
	</c:if>
	<%----编号机制开始--%>
		<c:import url="/sys/number/include/sysNumberMappTemplate_view.jsp" charEncoding="UTF-8">
			<c:param name="formName" value="kmImissiveSignTemplateForm" />
			<c:param name="modelName" value="com.landray.kmss.km.imissive.model.KmImissiveSignMain"/>
		</c:import>
	<%----编号机制结束--%>
	
	<!-- 流程 -->
	<c:import url="/sys/workflow/include/sysWfTemplate_view.jsp"
		charEncoding="UTF-8">
		<c:param name="formName" value="kmImissiveSignTemplateForm" />
		<c:param name="fdKey" value="signMainDoc" />
	</c:import>
	<tr LKS_LabelName="<bean:message bundle="sys-right" key="right.moduleName" />">
		<td>
			<table class="tb_normal" width=100%>
				<c:import url="/sys/right/tmp_right_view.jsp" charEncoding="UTF-8">
					<c:param
						name="formName"
						value="kmImissiveSignTemplateForm" />
					<c:param
						name="moduleModelName"
						value="com.landray.kmss.km.imissive.model.KmImissiveSignTemplate" />
				</c:import>
			</table>
		</td>
	</tr>

	<script>
		var _isXinChuangWps = "${xinChuangWps}";
		$(document).ready(function(){
			var table = document.getElementById("Label_Tabel");
			if(table != null && window.Doc_AddLabelSwitchEvent){
				if(_isXinChuangWps == "true"){
					Doc_AddLabelSwitchEvent(table, "showXinChuangWps");
				}
			}
		});
		function showXinChuangWps(tableName,index){
			var type = '${kmImissiveSignTemplateForm.fdNeedContent}';
			var trs = document.getElementById(tableName).rows;
			if("1" == type && trs[index].id =="tr_content"){
				setTimeout(function(){
					wps_linux_editonline.load();
				}, 800);
			}
		}
	</script>
	
	<%--多语言 --%>
	<%  if(LangUtil.isEnableMultiLang(request.getParameter("fdMainModelName"), "model") && LangUtil.isEnableAdminDoMultiLang()) {%>
	<c:import url="/sys/xform/lang/include/sysFormMultiLang_view.jsp"	charEncoding="UTF-8">
			<c:param name="formName" value="kmImissiveSignTemplateForm" />
			<c:param name="fdKey" value="signMainDoc" />
	</c:import>
	<% } %>	
	
	<!-- 打印机制 -->
	<c:import url="/sys/print/include/sysPrintTemplate_view.jsp" charEncoding="UTF-8">
		<c:param name="formName" value="kmImissiveSignTemplateForm" />
		<c:param name="fdKey" value="signMainDoc" />
		<c:param name="modelName" value="com.landray.kmss.km.imissive.model.KmImissiveSignMain"></c:param>
		<c:param name="templateModelName" value="com.landray.kmss.km.imissive.model.KmImissiveSignTemplate"></c:param>
	</c:import>
	<!-- 归档设置 -->
	<c:import url="/sys/archives/include/sysArchivesFileSetting_view.jsp" charEncoding="UTF-8">
		<c:param name="formName" value="kmImissiveSignTemplateForm" />
		<c:param name="modelName" value="com.landray.kmss.km.imissive.model.KmImissiveSignMain" />
		<c:param name="templateService" value="kmImissiveSignTemplateService" />
		<c:param name="moduleUrl" value="km/imissive" />
	</c:import>
	<c:import url="/kms/multidoc/kms_multidoc_subside/include/kmsSubsideFileSetting_view.jsp" charEncoding="UTF-8">
		<c:param name="formName" value="kmImissiveSignTemplateForm" />
		<c:param name="modelName" value="com.landray.kmss.km.imissive.model.KmImissiveSignMain" />
		<c:param name="templateService" value="kmImissiveSignTemplateService" />
	</c:import>
	<!-- 规则机制 -->
	<c:import url="/sys/rule/sys_ruleset_temp/sysRuleTemplate_view.jsp" charEncoding="UTF-8">
		<c:param name="formName" value="kmImissiveSignTemplateForm" />
		<c:param name="fdKey" value="signMainDoc" />
		<c:param name="templateModelName" value="com.landray.kmss.km.imissive.model.KmImissiveSignTemplate"></c:param>
	</c:import>
</table>
</center>
<%@ include file="/resource/jsp/view_down.jsp"%>
