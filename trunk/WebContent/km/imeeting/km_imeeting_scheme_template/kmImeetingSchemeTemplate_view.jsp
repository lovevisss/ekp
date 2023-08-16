<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="/WEB-INF/kmss-xform.tld" prefix="xform"%>
<%@ include file="/sys/ui/jsp/common.jsp"%>
<%@ include file="/sys/ui/jsp/jshead.jsp"%>
<%@ include file="/resource/jsp/view_top.jsp"%>
<script>Com_IncludeFile("data.js");</script>
<script>
	function confirmDelete(msg){
	var del = confirm('<bean:message key="page.comfirmDelete"/>');
	return del;
}
</script>
<div id="optBarDiv">
	<kmss:auth requestURL="/km/imeeting/km_imeeting_scheme_template/kmImeetingSchemeTemplate.do?method=edit&fdId=${JsParam.fdId}" requestMethod="GET">
		<input type="button"
			value="<bean:message key="button.edit"/>"
			onclick="Com_OpenWindow('kmImeetingSchemeTemplate.do?method=edit&fdId=${JsParam.fdId}','_self');">
	</kmss:auth>
	<kmss:auth requestURL="/km/imeeting/km_imeeting_scheme_template/kmImeetingSchemeTemplate.do?method=delete&fdId=${JsParam.fdId}" requestMethod="GET">
		<input type="button"
			value="<bean:message key="button.delete"/>"
			onclick="if(!confirmDelete())return;Com_OpenWindow('kmImeetingSchemeTemplate.do?method=delete&fdId=${JsParam.fdId}','_self');">
	</kmss:auth>
	<input type="button"
		value="<bean:message key="button.close"/>"
		onclick="Com_CloseWindow();">
</div>

<p class="txttitle"><bean:message bundle="km-imeeting" key="kmImeetingScheme.config"/></p>

<center>
<table id="Label_Tabel" width=95%>
	<%--会务安排--%>
	<tr LKS_LabelName="基本信息">
		<td>
		<table class="tb_normal" width=100%>
			<tr>
				<%--模板名称--%>
				<td class="td_normal_title" width=15%>
					<bean:message bundle="km-imeeting" key="kmImeetingTemplate.fdName"/>
				</td>
				<td width="85%" colspan="3">
					<xform:text property="fdName" style="width:85%" />
				</td>
			</tr>
			<tr>
				<%--类别--%>
				<td class="td_normal_title" width=15%>
					<bean:message bundle="km-imeeting" key="kmImeetingTemplate.docCategoryId"/>
				</td>
				<td colspan="3">
					<c:out value="${kmImeetingSchemeTemplateForm.docCategoryName}" />
				</td>
			</tr>
			<tr>
				<%--排序号--%>
				<td class="td_normal_title" width=15%>
					<bean:message bundle="km-imeeting" key="kmImeetingTemplate.fdOrder"/>
				</td>
				<td width="85%" colspan="3">
					<xform:text property="fdOrder" style="width:100px" />
				</td>
			</tr>
			<tr>
				<%--是否可用 --%>
				<td class="td_normal_title" width=15%><bean:message
					bundle="km-imeeting" key="kmImeetingTemplate.fdIsAvailable" /></td>
				<td width="85%" colspan="3">
					<label class="weui_switch">
						<input type="checkbox" style="display:none;" ${'true' eq kmImeetingSchemeTemplateForm.fdIsAvailable ? 'checked' : '' } disabled />
						<span style="cursor:default;"></span>
						<small style="cursor:default;"></small>
						<span id="fdIsAvailableText"></span>
					</label>
					<script type="text/javascript">
						function setText(status) {
							if(status) {
								$("#fdIsAvailableText").text('<bean:message bundle="km-imeeting" key="kmImeetingTemplate.fdIsAvailable.true" />');
							} else {
								$("#fdIsAvailableText").text('<bean:message bundle="km-imeeting" key="kmImeetingTemplate.fdIsAvailable.false" />');
							}
						}
						setText(${kmImeetingSchemeTemplateForm.fdIsAvailable});
					</script>
				</td>
			</tr>
			<tr>
				<%--可使用者--%>
				<td class="td_normal_title" width=15%>
					<bean:message bundle="km-imeeting" key="kmImeetingTemplate.authReaders"/>
				</td>
				<td width="85%" colspan="3">
					<xform:address textarea="true"  propertyId="authReaderIds" propertyName="authReaderNames" orgType="ORG_TYPE_ALL" style="width:85%" />
				</td>
			</tr>
			<tr>
				<%--可维护者--%>
				<td class="td_normal_title" width=15%>
					<bean:message bundle="km-imeeting" key="kmImeetingTemplate.authEditors"/>
				</td>
				<td width="85%" colspan="3">
					<xform:address textarea="true"  propertyId="authEditorIds" propertyName="authEditorNames" orgType="ORG_TYPE_ALL" style="width:85%" />
				</td>
			</tr>
		</table>
		</td>
	</tr>
	<tr LKS_LabelName="表单控件" style="display:none">
	    <td>
	        <c:import url="/sys/xform/include/sysFormTemplate_view.jsp" charEncoding="UTF-8">
	            <c:param name="formName" value="kmImeetingSchemeTemplateForm" />
	            <c:param name="fdKey" value="ImeetingScheme" />
	            <c:param name="fdMainModelName" value="com.landray.kmss.km.imeeting.model.KmImeetingScheme" />
	            <c:param name="useLabel" value="false" />
	        </c:import>
	    </td>
     </tr>
	<%-- 会议主文档--%>
	<c:import url="/sys/workflow/include/sysWfTemplate_view.jsp" charEncoding="UTF-8">
		<c:param name="formName" value="kmImeetingSchemeTemplateForm" />
		<c:param name="fdKey" value="ImeetingScheme" />
		<c:param name="messageKey" value="km-imeeting:kmImeetingTemplate.mainflow" />
	</c:import>
	<%-- 权限--%>	
	<tr LKS_LabelName="<bean:message bundle="sys-right" key="right.moduleName" />">
		<td>
			<table class="tb_normal" width=100%>
				<c:import  url="/sys/right/tmp_right_view.jsp" charEncoding="UTF-8">
					<c:param name="formName" value="kmImeetingTemplateForm" />
					<c:param name="moduleModelName" value="com.landray.kmss.km.imeeting.model.KmImeetingTemplate" />
				</c:import>
			</table>
		</td>
	</tr>
	<!--发布机制-->
		<c:import url="/sys/news/include/sysNewsPublishCategory_view.jsp" charEncoding="UTF-8">
		<c:param name="formName" value="kmImeetingSchemeTemplateForm" />
		<c:param name="fdKey" value="ImeetingScheme" />
	</c:import>
	<c:import url="/sys/number/include/sysNumberMappTemplate_view.jsp" charEncoding="UTF-8">
		<c:param name="formName" value="kmImeetingSchemeTemplateForm" />
	    <c:param name="modelName" value="com.landray.kmss.km.imeeting.model.KmImeetingMain"/>
	 </c:import>
</table>
</center>
<%@ include file="/resource/jsp/view_down.jsp"%>