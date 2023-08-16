<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/resource/jsp/view_top.jsp"%>
<div id="optBarDiv">
	<input type="button"
		value="<bean:message key="button.close"/>"
		onclick="Com_CloseWindow();">
</div>
<div class="txttitle"><bean:message bundle="sys-log" key="table.sysLogApp"/></div>
<center>
<table class="tb_normal" width=95%>
	<tr>
		<td class="td_normal_title" width=15%>
			<bean:message bundle="sys-log" key="sysLogApp.fdCreateTime"/>
		</td><td width=35%>
			<bean:write name="hrOrganizationLogForm" property="fdCreateTime"/>
		</td>
		<td class="td_normal_title" width=15%>
			<bean:message bundle="sys-log" key="sysLogApp.fdIp"/>
		</td><td width=35%>
			<bean:write name="hrOrganizationLogForm" property="fdIp"/>
		</td>
	</tr>
	<tr>
		<td class="td_normal_title" width=15%>
			<bean:message bundle="sys-log" key="sysLogApp.fdOperator"/>
		</td><td width=35%>
			<bean:write name="hrOrganizationLogForm" property="fdOperator"/>
		</td>
		<td class="td_normal_title" width=15%>
			<bean:message bundle="sys-log" key="sysLogApp.fdOperatorId"/>
		</td><td width=35%>
			<bean:write name="hrOrganizationLogForm" property="fdOperatorId"/>
		</td>
	</tr>
	<tr>
		<td class="td_normal_title" width=15%>
			<bean:message bundle="sys-log" key="sysLogApp.fdParaMethod"/>
		</td><td width=35%>
			<% try{ %>
				<bean:message key="button.${sysLogAppForm.fdParaMethod}"/>
			<% }catch(Exception e){ %>
				<bean:write name="hrOrganizationLogForm" property="fdParaMethod"/>
			<% } %>
		</td>
		<td class="td_normal_title" width=15%>
			<bean:message bundle="sys-log" key="sysLogApp.fdTargetId"/>
		</td><td width=35%>
			<bean:write name="hrOrganizationLogForm" property="fdTargetId"/>
		</td>
	</tr>
	<tr>
		<td class="td_normal_title" width=15%>
			<bean:message bundle="sys-log" key="sysLogApp.fdUrl"/>
		</td><td colspan=3>
			<bean:write name="hrOrganizationLogForm" property="fdUrl"/>
		</td>
	</tr>
	<tr>
		<td class="td_normal_title" width=15%>
			<bean:message bundle="sys-log" key="sysLogApp.fdMethod"/>
		</td><td width=35% colspan=3> 
			<bean:write name="hrOrganizationLogForm" property="fdMethod"/>
		</td>
	<tr>
		<td class="td_normal_title" width=15%>
			<bean:message bundle="sys-log" key="sysLogOrganization.fdBrowser"/>
		</td><td width=35%> 
			<bean:write name="hrOrganizationLogForm" property="fdBrowser"/>
		</td>
		<td class="td_normal_title" width=15%>
			<bean:message bundle="sys-log" key="sysLogOrganization.fdEquipment"/>
		</td><td width=35%> 
			<bean:write name="hrOrganizationLogForm" property="fdEquipment"/>
		</td>
	</tr>
	<tr>
		<td class="td_normal_title" width=15%>
			<bean:message bundle="sys-log" key="sysLogOrganization.fdDetails"/>
		</td><td width=35% colspan="3">
			<bean:write name="hrOrganizationLogForm" property="fdDetails"/>
		</td>
	</tr>
</table>
</center>
<%@ include file="/resource/jsp/view_down.jsp"%>