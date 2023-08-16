<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="/sys/ui/jsp/common.jsp"%>
<template:include ref="default.simple" sidebar="no">
	<template:replace name="body">
<script>
seajs.use(['theme!form']);
Com_IncludeFile("doclist.js|xform.js|dialog.js|calendar.js|data.js|jquery.js");
Com_IncludeFile("unitDialog.js", Com_Parameter.ContextPath+ "km/imissive/resource/js/", "js", true);
Com_IncludeFile("sysUnitDialog.js", Com_Parameter.ContextPath+ "sys/unit/resource/js/", "js", true);
Com_IncludeFile('styles.css|jquery.ui.widget.js|jquery.marcopolo.js|jquery.manifest.js','js/jquery-plugin/manifest/');
</script>
<script>
Com_SetWindowTitle('<bean:message bundle="km-imissive" key="kmImissiveSendMain.distribute.title"/>');
function submitForm(){
		
	var attArr=[];
	$('.contentAttTb').each(function(){
		var values = '';
		$('#'+this.id).find("input[name='_List_Selected']:checked").each(function(){
			values +=$(this).val() + ','; 
		});
		if(values != ''){
			var attObj = {};
			values = values.substring(0,values.length-1);
			attObj['attKey'] = this.id;
			attObj['attIds'] = values;
			attArr.push(attObj);
		}
	});
	document.getElementsByName("fdAttStr")[0].value = JSON.stringify(attArr);
	
	var auditNoteValues = '';
	$('#auditNoteTable_kmImissiveReceiveMainForm').find("input[name='List_Selected_Audit']:checked").each(function(){
		auditNoteValues +=$(this).val() + ','; 
	});
	if(auditNoteValues != ''){
		auditNoteValues = auditNoteValues.substring(0,auditNoteValues.length-1);
	}
	document.getElementsByName("fdAuditNoteStr")[0].value = auditNoteValues;
	
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
		Com_Submit(document.kmImissiveReceiveDRForm, 'updateReport');
	}
}
$(document).ready(function(){
	
	checkPdf('','${kmImissiveReceiveDRForm.fdMainId}','receive');
	
	resetNewDialog("fdMissiveMaintoIds","fdMissiveMaintoNames",";","kmImissiveUnitListWithAuthService&newSearch=true&type=report",false,"","",null);
	resetNewDialog("fdMissiveCopytoIds","fdMissiveCopytoNames",";","kmImissiveUnitListWithAuthService&newSearch=true&type=report",false,"","",null);
	resetNewDialog("fdMissiveReporttoIds","fdMissiveReporttoNames",";","kmImissiveUnitListWithAuthService&newSearch=true&type=report",false,"","",null);
});
</script>
<html:form action="/km/imissive/km_imissive_receive_dr/kmImissiveReceiveDR.do">
<center>
<table class="tb_normal" width=95% style="margin-top:20px">
	<html:hidden property="fdId"/>
	<tr id="optType" style="display: none">
	    <td class="td_normal_title" width=15%>
	   		<bean:message  bundle="km-imissive" key="kmImissiveDeliver.contentType"/>
		</td>
		<td width=85%>
			<xform:radio property="fdContentType" onValueChange="checkPdf(this.value,'${kmImissiveReceiveDRForm.fdMainId}','receive');" showStatus="edit" >
				<xform:enumsDataSource enumsType="kmImissiveDeliver_contentType"></xform:enumsDataSource>
			</xform:radio>
			<div id="fdContentTypeTips" style="display: none;color: red"></div>
		</td>
	</tr>
	<tr>
	    <td class="td_normal_title" width=15%>
	   		<bean:message  bundle="km-imissive" key="kmImissiveSendMain.distribute.addition"/>
		</td>
	    <td width=85% >
	   			 <xform:checkbox property="fdReadOpinion"  showStatus="edit" >	
	    			<xform:simpleDataSource value="1"><bean:message  bundle="km-imissive" key="kmImissiveSendMain.fdReadMissiveOpinion"/></xform:simpleDataSource>
	    		</xform:checkbox>
	    		<xform:checkbox property="fdDeliverOpinion"  showStatus="edit" >	
	    			<xform:simpleDataSource value="1"><bean:message  bundle="km-imissive" key="kmImissiveSendMain.fdReadSendOpinion"/></xform:simpleDataSource>
	    		</xform:checkbox>
	    		<xform:checkbox property="fdAttAuthFlag"  showStatus="edit" >
	    			<xform:simpleDataSource value="1"><bean:message  bundle="km-imissive" key="kmImissiveSendMain.fdAttAuthFlag"/></xform:simpleDataSource>
	    		</xform:checkbox>
		</td>
	</tr>
	<tr>
		<td class="td_normal_title" width=15%>
			分发时效
		</td>
		<td width=85%>
			<xform:radio showStatus="1" property="fdPrescription">
				<xform:enumsDataSource enumsType="kmImissive_distrbute_prescription"></xform:enumsDataSource>
			</xform:radio>
		</td>
	</tr>
	<tr>
		<td class="td_normal_title" width=15%>
			<bean:message  bundle="km-imissive" key="kmImissiveSendMain.fdAttStr.report"/>
		</td>
		<td width=85%>
			<input name="fdAttStr" type="hidden">
			<c:import url="/km/imissive/import/sysAttMain_DR_swf.jsp" charEncoding="UTF-8">
				<c:param name="showTitle" value="正文附件" />
				<c:param name="fdKey" value="${fdContentKey}" />
				<c:param name="fdModelId" value="${kmImissiveReceiveDRForm.fdMainId}" />
				<c:param name="fdModelName" value="com.landray.kmss.km.imissive.model.KmImissiveReceiveMain" />
			</c:import>
			<c:import url="/km/imissive/import/sysAttMain_DR_swf.jsp" charEncoding="UTF-8">
				<c:param name="showTitle" value="表单信息附件" />
				<c:param name="fdKey" value="baseInfoAtt" />
				<c:param name="fdModelId" value="${kmImissiveReceiveDRForm.fdMainId}" />
				<c:param name="fdModelName" value="com.landray.kmss.km.imissive.model.KmImissiveReceiveMain" />
			</c:import>
			<c:import url="/km/imissive/import/sysAttMain_DR_swf.jsp" charEncoding="UTF-8">
				<c:param name="showTitle" value="文档附件" />
				<c:param name="fdKey" value="attachment" />
				<c:param name="fdModelId" value="${kmImissiveReceiveDRForm.fdMainId}" />
				<c:param name="fdModelName" value="com.landray.kmss.km.imissive.model.KmImissiveReceiveMain" />
			</c:import>
			<c:import url="/km/imissive/import/sysAttMain_DR_swf.jsp" charEncoding="UTF-8">
				<c:param name="showTitle" value="易企签签署附件" />
				<c:param name="fdKey" value="yqqSigned" />
				<c:param name="fdModelId" value="${kmImissiveReceiveDRForm.fdMainId}" />
				<c:param name="fdModelName" value="com.landray.kmss.km.imissive.model.KmImissiveReceiveMain" />
			</c:import>
			<c:import url="/km/imissive/import/sysAttMain_DR_swf.jsp" charEncoding="UTF-8">
				<c:param name="showTitle" value="E签宝PDF签署附件" />
				<c:param name="fdKey" value="eqbSign" />
				<c:param name="fdModelId" value="${kmImissiveReceiveDRForm.fdMainId}" />
				<c:param name="fdModelName" value="com.landray.kmss.km.imissive.model.KmImissiveReceiveMain" />
			</c:import>
			<c:import url="/km/imissive/import/sysAttMain_DR_swf.jsp" charEncoding="UTF-8">
				<c:param name="showTitle" value="E签宝OFD签署附件" />
				<c:param name="fdKey" value="ofdEqbSign" />
				<c:param name="fdModelId" value="${kmImissiveReceiveDRForm.fdMainId}" />
				<c:param name="fdModelName" value="com.landray.kmss.km.imissive.model.KmImissiveReceiveMain" />
			</c:import>
			<c:import url="/km/imissive/import/sysAttMain_DR_swf.jsp" charEncoding="UTF-8">
				<c:param name="showTitle" value="金格OFD签署附件" />
				<c:param name="fdKey" value="ofdCySign" />
				<c:param name="fdModelId" value="${kmImissiveReceiveDRForm.fdMainId}" />
				<c:param name="fdModelName" value="com.landray.kmss.km.imissive.model.KmImissiveReceiveMain" />
			</c:import>
			<c:import url="/km/imissive/import/sysAttMain_DR_swf.jsp" charEncoding="UTF-8">
				<c:param name="showTitle" value="点聚签署附件" />
				<c:param name="fdKey" value="dianjuSign" />
				<c:param name="fdModelId" value="${kmImissiveReceiveDRForm.fdMainId}" />
				<c:param name="fdModelName" value="com.landray.kmss.km.imissive.model.KmImissiveReceiveMain" />
			</c:import>
			<c:import url="/km/imissive/import/sysAttMain_DR_swf.jsp" charEncoding="UTF-8">
				<c:param name="showTitle" value="书生签署附件" />
				<c:param name="fdKey" value="ofdSursenSign" />
				<c:param name="fdModelId" value="${kmImissiveReceiveDRForm.fdMainId}" />
				<c:param name="fdModelName" value="com.landray.kmss.km.imissive.model.KmImissiveReceiveMain" />
			</c:import>
			<c:import url="/km/imissive/import/sysAttMain_DR_swf.jsp" charEncoding="UTF-8">
				<c:param name="showTitle" value="pdf正文" />
				<c:param name="fdKey" value="convert_toPDF" />
				<c:param name="fdModelId" value="${kmImissiveReceiveDRForm.fdMainId}" />
				<c:param name="fdModelName" value="com.landray.kmss.km.imissive.model.KmImissiveReceiveMain" />
			</c:import>
			<c:import url="/km/imissive/import/sysAttMain_DR_swf.jsp" charEncoding="UTF-8">
				<c:param name="showTitle" value="ofd正文" />
				<c:param name="fdKey" value="convert_toOFD" />
				<c:param name="fdModelId" value="${kmImissiveReceiveDRForm.fdMainId}" />
				<c:param name="fdModelName" value="com.landray.kmss.km.imissive.model.KmImissiveReceiveMain" />
			</c:import>
		</td>
	</tr>
	<tr>
		<td class="td_normal_title" width=15%>
			<bean:message  bundle="km-imissive" key="table.kmImissiveMainMainto"/>
		</td><td width=85%>
			<input name="fdAuditNoteStr" type="hidden">
		    <xform:dialog propertyId="fdMissiveMaintoIds" propertyName="fdMissiveMaintoNames" style="width:100%" showStatus="edit" textarea="true" useNewStyle="true">
		       Dialog_UnitTreeList(false, 'fdMissiveMaintoIds', 'fdMissiveMaintoNames', ';', 'kmImissiveUnitCategoryTreeService&parentId=!{value}', '<bean:message key="kmImissiveUnit.fdCategoryId" bundle="km-imissive"/>', 'kmImissiveUnitListWithAuthService&parentId=!{value}&type=report',null,'kmImissiveUnitListWithAuthService&fdKeyWord=!{keyword}&type=report');
		    </xform:dialog>
		</td>
	</tr>
		<tr>
			<td class="td_normal_title" width=15%>
				<bean:message  bundle="km-imissive" key="table.kmImissiveMainCopyto"/>
			</td><td width=85%>
			   <xform:dialog propertyId="fdMissiveCopytoIds" propertyName="fdMissiveCopytoNames" style="width:100%" showStatus="edit" textarea="true" useNewStyle="true">
			     Dialog_UnitTreeList(false, 'fdMissiveCopytoIds', 'fdMissiveCopytoNames', ';', 'kmImissiveUnitCategoryTreeService&parentId=!{value}', '<bean:message key="kmImissiveUnit.fdCategoryId" bundle="km-imissive"/>', 'kmImissiveUnitListWithAuthService&parentId=!{value}&type=report',null,'kmImissiveUnitListWithAuthService&fdKeyWord=!{keyword}&type=report');
		       </xform:dialog>
			</td>
		</tr>
		<tr>
			<td class="td_normal_title" width=15%>
				<bean:message  bundle="km-imissive" key="table.kmImissiveReportto"/>
			</td><td width=85%>
			   <xform:dialog propertyId="fdMissiveReporttoIds" propertyName="fdMissiveReporttoNames" style="width:100%" showStatus="edit" textarea="true" useNewStyle="true">
			     Dialog_UnitTreeList(false, 'fdMissiveReporttoIds', 'fdMissiveReporttoNames', ';', 'kmImissiveUnitCategoryTreeService&parentId=!{value}', '<bean:message key="kmImissiveUnit.fdCategoryId" bundle="km-imissive"/>', 'kmImissiveUnitListWithAuthService&parentId=!{value}&type=report',null,'kmImissiveUnitListWithAuthService&fdKeyWord=!{keyword}&type=report');
		       </xform:dialog>
			</td>
		</tr>
		<tr>
			<td class="td_normal_title" width=15%>
				<bean:message  bundle="km-imissive" key="kmImissiveSendMain.fdDesc"/>
			</td><td width=85%>
			   <xform:textarea property="fdDesc" style="width:100%" showStatus="edit"></xform:textarea>
			</td>
		</tr>
		<tr>
			<td class="td_normal_title" width=15%>
				<bean:message  bundle="km-imissive" key="kmImissiveSendMain.fdNotifyType"/>
			</td>
			<td width=85%>
				<kmss:editNotifyType property="fdNotifyType"/>
				<span class="txtstrong">*</span>
			</td>
		</tr>
		<tr>
			<td colspan="2">
				<div>
					<div class="lui_form_subhead" style="padding:10px 8px ">审批意见:</div>
					<c:import url="/km/imissive/import/lbpmAuditNote_list.jsp" charEncoding="UTF-8">
						<c:param name="fdMainId" value="${kmImissiveReceiveDRForm.fdMainId}" />
						<c:param name="fdModelName" value="com.landray.kmss.km.imissive.model.KmImissiveReceiveMain" />
						<c:param name="formBeanName" value="kmImissiveReceiveMainForm"/>
					</c:import>
				</div>
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
