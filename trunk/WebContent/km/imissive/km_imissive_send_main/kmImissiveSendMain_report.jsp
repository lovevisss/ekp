<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="/sys/ui/jsp/common.jsp"%>
<template:include ref="default.simple" sidebar="no">
	<template:replace name="body">
<script>
seajs.use(['theme!form']);
Com_IncludeFile("doclist.js|dialog.js|calendar.js");
Com_IncludeFile("unitDialog.js", Com_Parameter.ContextPath+ "km/imissive/resource/js/", "js", true);
Com_IncludeFile("sysUnitDialog.js", Com_Parameter.ContextPath+ "sys/unit/resource/js/", "js", true);
</script>
<script>
Com_SetWindowTitle('<bean:message bundle="km-imissive" key="kmImissiveSendMain.distribute.title"/>');
function submitForm(){
	var validateFlag = true;
	var fdNotifyType = document.getElementsByName("fdNotifyType")[0];
	if(fdNotifyType.value == null || fdNotifyType.value == ""){
		alert('<bean:message key="kmImissiveSendMain.message.error.fdNotifyType" bundle="km-imissive" />');
		validateFlag = false;
		return;
	}
	var fdMissiveMaintoIds = document.getElementsByName("fdMissiveMaintoIds")[0];
	var fdMissiveCopytoIds = document.getElementsByName("fdMissiveCopytoIds")[0];
	var fdMissiveReporttoIds = document.getElementsByName("fdMissiveReporttoIds")[0];
	if(fdMissiveMaintoIds.value == "" && fdMissiveCopytoIds.value == "" && fdMissiveReporttoIds.value==""){
		alert('<bean:message key="kmImissiveSendMain.message.error.distribute" bundle="km-imissive" />');
		validateFlag = false;
		return;
	}
	if(validateFlag){
		var opinion = document.getElementsByName("opinion")[0];
		if(opinion.checked)
			document.getElementsByName("fdReadMissiveOpinion")[0].value="1";
		else
			document.getElementsByName("fdReadMissiveOpinion")[0].value="0";
		
		var sendOpinion = document.getElementsByName("sendOpinion")[0];
		if(sendOpinion.checked)
			document.getElementsByName("fdReadSendOpinion")[0].value="1";
		else
			document.getElementsByName("fdReadSendOpinion")[0].value="0";
		
		var attAuthFlag = document.getElementsByName("attAuthFlag")[0];
		if(attAuthFlag.checked)
			document.getElementsByName("fdAttAuthFlag")[0].value="1";
		else
			document.getElementsByName("fdAttAuthFlag")[0].value="0";

		Com_Submit(document.kmImissiveSendMainForm, 'updateReport');
	}
}
</script>
<html:form action="/km/imissive/km_imissive_send_main/kmImissiveSendMain.do">
<div style="padding: 10px 0px">
<p class="txttitle"><bean:message bundle="km-imissive" key="kmImissiveSendMain.report.title"/></p>
</div>
<center>
<table class="tb_normal" width=95%>
	<html:hidden property="fdId"/>
	<tr>
		<td class="td_normal_title" width=15%>
			<bean:message  bundle="km-imissive" key="kmImissiveSendMain.docSubject"/>
		</td><td width=85% colspan="2">
			${kmImissiveSendMainForm.docSubject }
			<html:hidden property="docSubject" />
		</td>
	</tr>
	<tr>
		<td class="td_normal_title" width=15%>
			<bean:message  bundle="km-imissive" key="kmImissiveSendMain.fdNotifyType"/>
		</td>
		<td width=85% colspan="2">
			<kmss:editNotifyType property="fdNotifyType"/>
			<span class="txtstrong">*</span>
		</td>
	</tr>
	<tr>
	    <td class="td_normal_title" width=15%>
	   		<bean:message  bundle="km-imissive" key="kmImissiveSendMain.distribute.addition"/>
		</td>
	    <td colspan="2">
			    <input name="fdReadMissiveOpinion" type="hidden" value="0">
			    <input type="checkbox" name="opinion"><bean:message  bundle="km-imissive" key="kmImissiveSendMain.fdReadMissiveOpinion"/>&nbsp;&nbsp;&nbsp;
			    <input name="fdReadSendOpinion" type="hidden" value="0">
			    <input type="checkbox" name="sendOpinion"><bean:message  bundle="km-imissive" key="kmImissiveSendMain.fdReadSendOpinion"/>&nbsp;&nbsp;&nbsp;
			    <input name="fdAttAuthFlag" type="hidden" value="0">
			    <input type="checkbox" name="attAuthFlag"><bean:message  bundle="km-imissive" key="kmImissiveSendMain.fdAttAuthFlag"/>
		</td>
	</tr>
	<tr>
		<td class="td_normal_title" width=15%>
			<bean:message  bundle="km-imissive" key="table.kmImissiveMainMainto"/>
		</td><td width=85% colspan="2">
		    <xform:dialog propertyId="fdMissiveMaintoIds" propertyName="fdMissiveMaintoNames" style="width:100%" showStatus="edit" textarea="true">
		       Dialog_UnitTreeList(false, 'fdMissiveMaintoIds', 'fdMissiveMaintoNames', ';', 'kmImissiveUnitCategoryTreeService', '<bean:message key="kmImissiveUnit.fdCategoryId" bundle="km-imissive"/>', 'kmImissiveUnitListWithAuthService&parentId=!{value}&type=report',null,'kmImissiveUnitListWithAuthService&fdKeyWord=!{keyword}&type=report');
		    </xform:dialog>
		</td>
	</tr>
		<tr>
			<td class="td_normal_title" width=15%>
				<bean:message  bundle="km-imissive" key="table.kmImissiveMainCopyto"/>
			</td><td width=85% colspan="2">
			   <xform:dialog propertyId="fdMissiveCopytoIds" propertyName="fdMissiveCopytoNames" style="width:100%" showStatus="edit" textarea="true">
			     Dialog_UnitTreeList(true, 'fdMissiveCopytoIds', 'fdMissiveCopytoNames', ';', 'kmImissiveUnitCategoryTreeService', '<bean:message key="kmImissiveUnit.fdCategoryId" bundle="km-imissive"/>', 'kmImissiveUnitListWithAuthService&parentId=!{value}&type=report',null,'kmImissiveUnitListWithAuthService&fdKeyWord=!{keyword}&type=report');
		       </xform:dialog>
			</td>
		</tr>
		<tr>
			<td class="td_normal_title" width=15%>
				<bean:message  bundle="km-imissive" key="table.kmImissiveReportto"/>
			</td><td width=85% colspan="2">
			   <xform:dialog propertyId="fdMissiveReporttoIds" propertyName="fdMissiveReporttoNames" style="width:100%" showStatus="edit" textarea="true">
			     Dialog_UnitTreeList(true, 'fdMissiveReporttoIds', 'fdMissiveReporttoNames', ';', 'kmImissiveUnitCategoryTreeService', '<bean:message key="kmImissiveUnit.fdCategoryId" bundle="km-imissive"/>', 'kmImissiveUnitListWithAuthService&parentId=!{value}&type=report',null,'kmImissiveUnitListWithAuthService&fdKeyWord=!{keyword}&type=report');
		       </xform:dialog>
			</td>
		</tr>
		<tr>
			<td class="td_normal_title" width=15%>
				<bean:message  bundle="km-imissive" key="kmImissiveSendMain.fdDesc"/>
			</td><td width=85% colspan="2">
			   <xform:textarea property="fdDesc" style="width:100%" showStatus="edit"></xform:textarea>
			</td>
		</tr>
</table>
<div style="padding-top:17px;padding-bottom:20px">
	   <ui:button text="${ lfn:message('km-imissive:kmImissiveSendMain.report') }"  onclick="submitForm();">
	   </ui:button>
	   <ui:button text="${ lfn:message('button.close') }" order="5" styleClass="lui_toolbar_btn_gray"  onclick="$dialog.hide('cancel');">
	    </ui:button>
 </div>
</center>
<html:hidden property="method_GET"/>
</html:form>
	</template:replace>
</template:include>
