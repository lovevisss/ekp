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
		$("#missiveButtonDiv").show();
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
		requestURL="/km/imissive/km_imissive_receive_template/kmImissiveReceiveTemplate.do?method=edit&fdId=${param.fdId}"
		requestMethod="GET">
		<input type="button" value="<bean:message key="button.edit"/>"
			onclick="Com_OpenWindow('kmImissiveReceiveTemplate.do?method=edit&fdId=${param.fdId}','_self');">
	</kmss:auth> 
	<kmss:auth
		requestURL="/km/imissive/km_imissive_receive_template/kmImissiveReceiveTemplate.do?method=clone&cloneModelId=${param.fdId}"
		requestMethod="GET">
	<input type="button" value="<kmss:message key="km-imissive:button.copy"/>"
			onclick="Com_OpenWindow('kmImissiveReceiveTemplate.do?method=clone&cloneModelId=${param.fdId}','_blank');">
	</kmss:auth>
	<kmss:auth
		requestURL="/km/imissive/km_imissive_receive_template/kmImissiveReceiveTemplate.do?method=delete&fdId=${param.fdId}"
		requestMethod="GET">
		<input type="button" value="<bean:message key="button.delete"/>"
			onclick="if(!confirmDelete())return;Com_OpenWindow('kmImissiveReceiveTemplate.do?method=delete&fdId=${param.fdId}','_self');">
	</kmss:auth>
	 <input type="button" value="<bean:message key="button.close"/>"
		onclick="Com_CloseWindow();">
</div>
<p class="txttitle"><bean:message bundle="km-imissive"
	key="table.kmImissiveReceiveTemplate" /></p>
<center>
<c:if test="${kmImissiveReceiveTemplateForm.fdNeedContent=='1'}">
<div id="content" style="position:absolute;height: 1px;width: 1px;">
	<c:choose>
		<c:when test="${wpsoaassist eq 'true'}">
		</c:when>
		<c:when test="${_isWpsCloudEnable}">
			<c:import url="/sys/attachment/sys_att_main/wps/cloud/sysAttMain_view.jsp" charEncoding="UTF-8">
				<c:param name="fdKey" value="editonline" />
				<c:param name="fdModelId" value="${kmImissiveReceiveTemplateForm.fdId}" />
				<c:param name="fdModelName" value="com.landray.kmss.km.imissive.model.KmImissiveReceiveTemplate" />
				<c:param name="load" value="false" />
				<c:param name="formBeanName" value="kmImissiveReceiveTemplateForm" />
			</c:import>
		</c:when>
		<c:when test="${_isWpsCenterEnable}">
			<c:import url="/sys/attachment/sys_att_main/wps/center/sysAttMain_view.jsp" charEncoding="UTF-8">
				<c:param name="fdKey" value="editonline" />
				<c:param name="fdModelId" value="${kmImissiveReceiveTemplateForm.fdId}" />
				<c:param name="fdModelName" value="com.landray.kmss.km.imissive.model.KmImissiveReceiveTemplate" />
				<c:param name="formBeanName" value="kmImissiveReceiveTemplateForm" />
				<c:param name="load" value="false" />
				<c:param name="wpsPreview" value="0010000" />
			</c:import>
		</c:when>
		<c:otherwise>
			<c:import url="/sys/attachment/sys_att_main/jg/sysAttMain_view.jsp" charEncoding="UTF-8">
				<c:param
					name="fdKey"
					value="editonline" />
				<c:param
					name="fdAttType"
					value="office" />
				<c:param
					name="fdModelId"
					value="${param.fdId}" />
				<c:param
					name="buttonDiv"
					value="missiveButtonDiv" />
				<c:param 
					name="isTemplate"
					value="true"/>
				<c:param
					name="fdModelName"
					value="com.landray.kmss.km.imissive.model.KmImissiveReceiveTemplate" />
			</c:import>
		</c:otherwise>
	</c:choose>
</div>
</c:if>
<table id="Label_Tabel" width=95%>
	<tr
		LKS_LabelName="<bean:message bundle='km-imissive' key='kmImissiveReceiveTemplate.templateinfo'/>">
		<td><html:hidden name="kmImissiveReceiveTemplateForm" property="fdId" />
		<table class="tb_normal" width=100%>
			<!-- 模板名称 -->
			<tr>
				<td class="td_normal_title" width=15%>
				  <bean:message bundle="km-imissive" key="kmImissiveReceiveTemplate.fdName" />
				 </td>
				<td width=85% colspan="3"><bean:write name="kmImissiveReceiveTemplateForm"
					property="fdName" /></td>
			</tr>
			<!-- 适用类别 -->
			<tr>
				<td class="td_normal_title" width=15%>
				 <bean:message bundle="km-imissive" key="kmImissiveReceiveTemplate.fdCatoryName" />
				</td>
				<td width=85% colspan="3"><bean:write name="kmImissiveReceiveTemplateForm"
					property="fdCategoryName" /></td>
			</tr>
			<tr>
				<td class="td_normal_title" width=15%>
					<bean:message bundle="km-imissive" key="kmImissiveReceiveTemplate.fdFlowId" />
				</td>
				<td width=85% colspan="3">
					<%
						request.setAttribute("fdAllNumberFlag","1");
					    request.setAttribute("modelName","com.landray.kmss.km.imissive.model.KmImissiveReceiveMain");
					%>
					<xform:select property="fdFlowId"  htmlElementProperties="id='numberSelect'" style="width:200px" showStatus="view">
						<xform:customizeDataSource className="com.landray.kmss.sys.number.service.spring.SysNumberMainDataSource"></xform:customizeDataSource>
					</xform:select>
					<font color="red">
						<bean:message bundle="km-imissive" key="kmImissiveReceiveTemplate.fdFlowId.tips" /></br>
						<bean:message bundle="km-imissive" key="kmImissiveReceiveTemplate.fdFlowId.tips1" /></br>
						<bean:message bundle="km-imissive" key="kmImissiveReceiveTemplate.fdFlowId.tips2" />
					</font>
				</td>
			</tr>
			<tr>
				<!-- 排序号 -->
				<td class="td_normal_title" width=15%><bean:message
						bundle="km-imissive" key="kmImissiveReceiveTemplate.fdOrder" /></td>
				<td width=35% >
				<bean:write name="kmImissiveReceiveTemplateForm" property="fdOrder" /></td>
				<td class="td_normal_title" width=15%>
							<bean:message bundle="km-imissive" key="kmImissiveTemplate.fdIsAvailable" />
						</td>
					<td width=35%>
						 <c:if test="${kmImissiveReceiveTemplateForm.fdIsAvailable}">
							<bean:message bundle="km-imissive" key="kmImissiveTemplate.fdIsAvailable.true" />
						</c:if>
						<c:if test="${!kmImissiveReceiveTemplateForm.fdIsAvailable}">
							<bean:message bundle="km-imissive" key="kmImissiveTemplate.fdIsAvailable.false" />
						</c:if>
					</td>
			</tr>
			<%-- 所属场所 --%>
			<c:import url="/sys/authorization/sys_auth_area/sysAuthArea_field.jsp" charEncoding="UTF-8">
                <c:param name="id" value="${kmImissiveReceiveTemplateForm.authAreaId}"/>
            </c:import>			
			<!-- 可使用者 -->
			<tr>
				<td class="td_normal_title" width=15%><bean:message
						bundle="km-imissive" key="kmImissiveReceiveTemplate.authReaderIds" /></td>
				<td width=85% colspan="3"><bean:write name="kmImissiveReceiveTemplateForm"
					property="authReaderNames" /></td>
			</tr>
			<!-- 可维护者 -->
			<tr>
				<td class="td_normal_title" width=15%><bean:message
						bundle="km-imissive" key="kmImissiveReceiveTemplate.authEditorIds" /></td>
				<td width=85% colspan="3"><bean:write name="kmImissiveReceiveTemplateForm"
					property="authEditorNames" /></td>
			</tr>
			<tr>
				<td class="td_normal_title" width=15%><bean:message
					bundle="km-imissive" key="kmImissiveReceiveTemplate.authAppRecReaderIds" /></td>
				<td width=85% colspan="3">
				<bean:write name="kmImissiveReceiveTemplateForm" property="authTmpAppRecReaderNames" />
				</td>
			</tr>
			<tr>
				<!-- 创建人 -->
				<td class="td_normal_title" width=15%><bean:message
						bundle="km-imissive" key="kmImissiveReceiveTemplate.docCreatorId" /></td>
				<td width=35%><bean:write name="kmImissiveReceiveTemplateForm"
					property="docCreatorName" /></td>
			<!-- 创建时间 -->
				<td class="td_normal_title" width=15%><bean:message
						bundle="km-imissive" key="kmImissiveReceiveTemplate.docCreateTime" /></td>
				<td width=35%><bean:write name="kmImissiveReceiveTemplateForm"
					property="docCreateTime" /></td>
			</tr>
			<c:if test="${not empty kmImissiveReceiveTemplateForm.docAlterorName}">
			<tr>
				<!-- 修改人 -->
				<td class="td_normal_title" width=15%><bean:message
						bundle="km-imissive" key="kmImissiveReceiveTemplate.docAlterorId" /></td>
				<td width=35%><bean:write name="kmImissiveReceiveTemplateForm"
					property="docAlterorName" /></td>
				<!-- 修改时间 -->
				<td class="td_normal_title" width=15%><bean:message
						bundle="km-imissive" key="kmImissiveReceiveTemplate.docAlterTime" /></td>
				<td width=35%><bean:write name="kmImissiveReceiveTemplateForm"
					property="docAlterTime" /></td>
			</tr>
			</c:if>
		</table>
		</td>
	</tr>
	<!-- 表单 -->
	<c:import url="/sys/xform/include/sysFormTemplate_view.jsp"
		charEncoding="UTF-8">
		<c:param name="formName" value="kmImissiveReceiveTemplateForm" />
		<c:param name="fdKey" value="receiveMainDoc" />
		<c:param name="fdMainModelName" value="com.landray.kmss.km.imissive.model.KmImissiveReceiveMain" />
		<c:param name="messageKey" value="km-imissive:kmImissiveReceiveTemplate.baseinfo" />
	</c:import>
	<c:if test="${kmImissiveReceiveTemplateForm.fdNeedContent=='1'}">
		<tr id="tr_content" LKS_LabelName="<bean:message bundle="km-imissive" key="kmImissiveReceiveTemplate.docContent" />">
			<td id="td_content">
				<div id="missiveButtonDiv" style="text-align:right">
				</div>
				<c:if test="${wpsoaassist eq 'true'}">
					<c:choose>
						<c:when test="${xinChuangWps eq 'true'}">
							<c:import url="/sys/attachment/sys_att_main/wps/oaassist/linux/sysAttMain_view.jsp" charEncoding="UTF-8">
								<c:param name="formBeanName" value="kmImissiveReceiveTemplateForm" />
								<c:param name="fdKey" value="editonline" />
								<c:param name="fdModelId" value="${kmImissiveReceiveTemplateForm.fdId}" />
								<c:param name="fdModelName" value="com.landray.kmss.km.imissive.model.KmImissiveReceiveTemplate" />
							</c:import>
						</c:when>
						<c:otherwise>
							<c:import url="/sys/attachment/sys_att_main/sysAttMain_view.jsp" charEncoding="UTF-8">
								<c:param name="formBeanName" value="kmImissiveReceiveTemplateForm" />
								<c:param name="fdKey" value="editonline" />
								<c:param name="fdModelId" value="${kmImissiveReceiveTemplateForm.fdId}" />
								<c:param name="fdModelName" value="com.landray.kmss.km.imissive.model.KmImissiveReceiveTemplate" />
							</c:import>
						</c:otherwise>
					</c:choose>
				</c:if>
			</td>
		</tr>
	</c:if>
	<%----编号机制开始--%>
		<c:import url="/sys/number/include/sysNumberMappTemplate_view.jsp" charEncoding="UTF-8">
			<c:param name="formName" value="kmImissiveReceiveTemplateForm" />
			<c:param name="modelName" value="com.landray.kmss.km.imissive.model.KmImissiveReceiveMain"/>
		</c:import>
	<%----编号机制结束--%>
	
	<!-- 流程 -->
	<c:import url="/sys/workflow/include/sysWfTemplate_view.jsp"
		charEncoding="UTF-8">
		<c:param name="formName" value="kmImissiveReceiveTemplateForm" />
		<c:param name="fdKey" value="receiveMainDoc" />
	</c:import>
	<tr LKS_LabelName="<bean:message bundle="sys-right" key="right.moduleName" />">
		<td>
			<table class="tb_normal" width=100%>
				<c:import url="/sys/right/tmp_right_view.jsp" charEncoding="UTF-8">
					<c:param
						name="formName"
						value="kmImissiveReceiveTemplateForm" />
					<c:param
						name="moduleModelName"
						value="com.landray.kmss.km.imissive.model.KmImissiveReceiveTemplate" />
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
			var type = '${kmImissiveReceiveTemplateForm.fdNeedContent}';
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
			<c:param name="formName" value="kmImissiveReceiveTemplateForm" />
			<c:param name="fdKey" value="receiveMainDoc" />
	</c:import>
	<% } %>	
	
	<!-- 打印机制 -->
	<c:import url="/sys/print/include/sysPrintTemplate_view.jsp" charEncoding="UTF-8">
		<c:param name="formName" value="kmImissiveReceiveTemplateForm" />
		<c:param name="fdKey" value="receiveMainDoc" />
		<c:param name="modelName" value="com.landray.kmss.km.imissive.model.KmImissiveReceiveMain"></c:param>
		<c:param name="templateModelName" value="com.landray.kmss.km.imissive.model.KmImissiveReceiveTemplate"></c:param>
	</c:import>
	<!-- 归档设置 -->
	<c:import url="/sys/archives/include/sysArchivesFileSetting_view.jsp" charEncoding="UTF-8">
		<c:param name="formName" value="kmImissiveReceiveTemplateForm" />
		<c:param name="modelName" value="com.landray.kmss.km.imissive.model.KmImissiveReceiveMain" />
		<c:param name="templateService" value="kmImissiveReceiveTemplateService" />
		<c:param name="moduleUrl" value="km/imissive" />
	</c:import>
	<c:import url="/kms/multidoc/kms_multidoc_subside/include/kmsSubsideFileSetting_view.jsp" charEncoding="UTF-8">
		<c:param name="formName" value="kmImissiveReceiveTemplateForm" />
		<c:param name="modelName" value="com.landray.kmss.km.imissive.model.KmImissiveReceiveMain" />
		<c:param name="templateService" value="kmImissiveReceiveTemplateService" />
	</c:import>
	<!-- 规则机制 -->
	<c:import url="/sys/rule/sys_ruleset_temp/sysRuleTemplate_view.jsp" charEncoding="UTF-8">
		<c:param name="formName" value="kmImissiveReceiveTemplateForm" />
		<c:param name="fdKey" value="receiveMainDoc" />
		<c:param name="templateModelName" value="com.landray.kmss.km.imissive.model.KmImissiveReceiveTemplate"></c:param>
	</c:import>
</table>
</center>
<%@ include file="/resource/jsp/view_down.jsp"%>
