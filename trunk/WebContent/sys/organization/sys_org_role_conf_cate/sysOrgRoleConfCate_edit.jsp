<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/resource/jsp/edit_top.jsp"%>
<script type="text/javascript">
Com_IncludeFile("dialog.js");
</script>
<html:form action="/sys/organization/sys_org_role_conf_cate/sysOrgRoleConfCate.do" onsubmit="return validateSysOrgRoleConfCateForm(this);">
<div id="optBarDiv">
	<logic:equal name="sysOrgRoleConfCateForm" property="method_GET" value="edit">
		<input type=button value="<bean:message key="button.update"/>"
			onclick="Com_Submit(document.sysOrgRoleConfCateForm, 'update');">
	</logic:equal>
	<logic:equal name="sysOrgRoleConfCateForm" property="method_GET" value="add">
		<input type=button value="<bean:message key="button.save"/>"
			onclick="Com_Submit(document.sysOrgRoleConfCateForm, 'save');">
		<input type=button value="<bean:message key="button.saveadd"/>"
			onclick="Com_Submit(document.sysOrgRoleConfCateForm, 'saveadd');">
	</logic:equal>
<input type="button" value="<bean:message key="button.close"/>" onClick="Com_CloseWindow();">
</div>
<p class="txttitle"><bean:message bundle="sys-organization" key="table.sysOrgRoleConfCate"/><bean:message key="button.edit"/></p>
<center>
<table class="tb_normal" width=95%>
	<tr>
		<td width=15% class="td_normal_title">
			<bean:message bundle="sys-organization" key="sysOrgRoleConfCate.fdParent"/>
		</td><td width=35%>
			<html:hidden property="fdParentId"/>
			<html:text property="fdParentName" readonly="true" styleClass="inputsgl"/>
			<a href="#" onclick="Dialog_Tree(
				false,
				'fdParentId',
				'fdParentName',
				null,
				Tree_GetBeanNameFromService('sysOrgRoleConfCateService', 'hbmParent', 'fdName:fdId'),
				'<bean:message bundle="sys-organization" key="table.sysOrgRoleConfCate"/>',
				null,
				null,
				'<bean:write name="sysOrgRoleConfCateForm" property="fdId"/>');">
				<bean:message key="dialog.selectOther"/>
			</a>
		</td>
		<td width=15% class="td_normal_title">
			<bean:message bundle="sys-organization" key="sysOrgRoleConfCate.fdName"/>
		</td><td width=35%>
		<%-- 
			<html:text property="fdName"/>
			<span class="txtstrong">*</span>
			--%>
			<xform:text property="fdName" style="width:80%" required="true"></xform:text>
			
		</td>
	</tr>
</table>
</center>
<html:hidden property="method_GET"/>
<html:hidden property="fdId"/>
</html:form>
<html:javascript formName="sysOrgRoleConfCateForm"  cdata="false"
      dynamicJavascript="true" staticJavascript="false"/>
<%@ include file="/resource/jsp/edit_down.jsp"%>