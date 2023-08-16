<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="/sys/ui/jsp/common.jsp"%>
<template:include ref="default.edit"  sidebar="no">
<template:replace name="toolbar">
<ui:toolbar id="toolbar" layout="sys.ui.toolbar.float"> 
   <ui:button text="${lfn:message('button.submit')}" order="2" onclick=" Com_SubmitMethod('saveOuter');">
   </ui:button>
   <ui:button text="${ lfn:message('button.close')}" order="5"  onclick="Com_CloseWindow();">
   </ui:button>
</ui:toolbar>
</template:replace>
<template:replace name="content">
<html:form action="/km/imissive/km_imissive_return_opinion/kmImissiveReturnOpinion.do">
<p class="txttitle"><bean:message bundle="km-imissive" key="kmImissiveReceiveMain.opinion.title"/></p>
<center>
<table class="tb_normal" width=95%>
	<html:hidden property="fdId"/>
	<html:hidden property="fdImissiveId"/>
	<html:hidden property="fdDetailId"/>
	<html:hidden property="fdUnitId"/>
	<html:hidden property="fdDeliverType"/>
	<html:hidden property="fdRegType"/>
	<tr>
		<td class="td_normal_title" width=15%>
			意见反馈
		</td>
		<td width=85%>
			<xform:textarea property="docContent" style="width:85%" required="true"></xform:textarea>
		</td>
	</tr>
	<tr>
		<td class="td_normal_title" width=15%>
			意见附件
		</td>
		<td width=85%>
			<c:import url="/sys/attachment/sys_att_main/sysAttMain_edit.jsp" charEncoding="UTF-8">
			<c:param name="fdKey" value="opinionAtt" />
			<c:param name="fdMulti" value="true" />
			<c:param name="fdModelId" value="${kmImissiveReturnOpinionForm.fdId }" />
			<c:param name="fdModelName" value="com.landray.kmss.km.imissive.model.KmImissiveReturnOpinion" />
		</c:import>
		</td>
	</tr>
	<%--
	<tr>
		<td colspan="2">
			<input name="fdAuditNoteIds" type="hidden">
			<div>
				<div class="lui_form_subhead" style="padding:10px 8px ">审批意见:</div>
				<c:import url="/km/imissive/import/lbpmAuditNote_list.jsp" charEncoding="UTF-8">
					<c:param name="fdMainId" value="${kmImissiveReturnOpinionForm.fdImissiveId}" />
					<c:param name="fdModelName" value="com.landray.kmss.km.imissive.model.KmImissiveReceiveMain" />
					<c:param name="formBeanName" value="kmImissiveReceiveMainForm"/>
				</c:import>
			</div>
		</td>
	</tr>
	 --%>
</table>
</center>
<html:hidden property="method_GET"/>
</html:form>
<script language="JavaScript">
	$KMSSValidation(document.forms['kmImissiveReturnOpinionForm']);
	
	function Com_SubmitMethod(operation){
		/*
		var auditNoteValues = '';
		$('#auditNoteTable_kmImissiveReceiveMainForm').find("input[name='List_Selected_Audit']:checked").each(function(){
			auditNoteValues +=$(this).val() + ','; 
		});
		if(auditNoteValues != ''){
			auditNoteValues = auditNoteValues.substring(0,auditNoteValues.length-1);
		}
		document.getElementsByName("fdAuditNoteIds")[0].value = auditNoteValues;
		*/
		
		Com_Submit(document.kmImissiveReturnOpinionForm,operation);
	}
	
</script>
</template:replace>
</template:include>