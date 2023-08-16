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
	$('#auditNoteTable_kmImissiveSendMainForm').find("input[name='List_Selected_Audit']:checked").each(function(){
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
	var fdMaintoIds = document.getElementsByName("fdMaintoIds")[0];
	var fdCopytoIds = document.getElementsByName("fdCopytoIds")[0];
	var fdReporttoIds = document.getElementsByName("fdReporttoIds")[0];
	if(fdMaintoIds.value == "" && fdCopytoIds.value == "" && fdReporttoIds.value==""){
		alert('<bean:message key="kmImissiveSendMain.message.error.distribute" bundle="km-imissive" />');
		validateFlag = false;
		return;
	}
	if(validateFlag){
		
		Com_Submit(document.kmImissiveSendDRForm, 'updateDistribute');
	}
}
$(document).ready(function(){
	
	checkPdf('','${kmImissiveSendDRForm.fdMainId}','send');
	
	var mainIds = document.getElementsByName("fdMaintoIds")[0].value;
	var mainNames = document.getElementsByName("fdMaintoNames")[0].value;
	//resetNewDialog("fdMaintoIds","fdMaintoNames",";","kmImissiveUnitListWithAuthService&newSearch=true&type=distribute",true,"","",mainCalBackFn);
	if(mainIds && mainNames){
		initNewDialog("fdMaintoIds","fdMaintoNames",";","kmImissiveUnitListWithAuthService&newSearch=true&type=distribute",true,"","",null);
		resetNewDialog("fdMaintoIds","fdMaintoNames",";","kmImissiveUnitListWithAuthService&newSearch=true&type=distribute",true,mainIds,mainNames,null);
	}else{
		initNewDialog("fdMaintoIds","fdMaintoNames",";","kmImissiveUnitListWithAuthService&newSearch=true&type=distribute",true,"","",null);
	}
	
	var copyIds = document.getElementsByName("fdCopytoIds")[0].value;
	var copyNames = document.getElementsByName("fdCopytoNames")[0].value;
	//resetNewDialog("fdCopytoIds","fdCopytoNames",";","kmImissiveUnitListWithAuthService&newSearch=true&type=distribute",true,"","",copyCalBackFn);
	if(copyIds && copyNames){
		initNewDialog("fdCopytoIds","fdCopytoNames",";","kmImissiveUnitListWithAuthService&newSearch=true&type=distribute",true,"","",null);
		resetNewDialog("fdCopytoIds","fdCopytoNames",";","kmImissiveUnitListWithAuthService&newSearch=true&type=distribute",true,copyIds,copyNames,null);
	}else{
		initNewDialog("fdCopytoIds","fdCopytoNames",";","kmImissiveUnitListWithAuthService&newSearch=true&type=distribute",true,"","",null);
	}
	
	var reportIds = document.getElementsByName("fdReporttoIds")[0].value;
	var reportNames = document.getElementsByName("fdReporttoNames")[0].value;
	//resetNewDialog("fdReporttoIds","fdReporttoNames",";","kmImissiveUnitListWithAuthService&newSearch=true&type=distribute",true,"","",reportCalBackFn);
	if(reportIds && reportNames){
		initNewDialog("fdReporttoIds","fdReporttoNames",";","kmImissiveUnitListWithAuthService&newSearch=true&type=distribute",true,"","",null);
		resetNewDialog("fdReporttoIds","fdReporttoNames",";","kmImissiveUnitListWithAuthService&newSearch=true&type=distribute",true,reportIds,reportNames,null);
	}else{
		initNewDialog("fdReporttoIds","fdReporttoNames",";","kmImissiveUnitListWithAuthService&newSearch=true&type=distribute",true,"","",null);
	}
	//mainCalBackFn();
	//copyCalBackFn();
	//reportCalBackFn();
});


function getAuthUnit(fdIds,fdgIds,unitSpan){
	var fdUnitGIds;
	if(unitSpan == "mainUnit"){
		fdUnitGIds = document.getElementsByName("fdMaintoUnitGroupIds")[0].value;
	}
	if(unitSpan == "copyUnit"){
		fdUnitGIds = document.getElementsByName("fdCopytoUnitGroupIds")[0].value;
	}
	if(unitSpan == "reportUnit"){
		fdUnitGIds = document.getElementsByName("fdReporttoUnitGroupIds")[0].value;
	}

	 var url="${KMSS_Parameter_ContextPath}km/imissive/km_imissive_send_main/kmImissiveSendMain.do?method=getAuthUnit"; 
	 $.ajax({     
	     type:"post",   
	     url:url,     
	     data:{fdIds:fdIds,fdgIds:fdgIds,fdUnitGIds:fdUnitGIds},
	     async:false,    //用同步方式 
	     success:function(data){
		     if(data!=""){
	    		 var results =  eval("("+data+")");
	    	    document.getElementById(unitSpan).innerHTML = "<bean:message key='kmImissive.distribute.result.title' bundle='km-imissive'/>: <font color='red'>"+results['names']+"</font>";
		     }else{
		    	document.getElementById(unitSpan).innerHTML = "<font color='red'><bean:message key='kmImissive.distribute.result.title' bundle='km-imissive'/></font>";
			 }
		}    
   });
}


function mainCalBackFn(){
	var ids = document.getElementsByName("fdMaintoIds")[0].value;
	if(ids!=""){
		var fdMissiveMaintoIds = "";
		var fdMissiveMaintoGroupIds="";
		var fdMaintoUnitGroupIds="";
		var idsArray = ids.split(";");
		for(var i=0;i<idsArray.length;i++){
			if(idsArray[i]!=""){
				if(idsArray[i].indexOf("cate")>-1){
					fdMissiveMaintoGroupIds += idsArray[i].substring(0,idsArray[i].indexOf("cate")-1)+";";
				}else if(idsArray[i].indexOf("group")>-1){
					fdMaintoUnitGroupIds += idsArray[i].substring(0,idsArray[i].indexOf("group")-1)+";";
				} else{
					fdMissiveMaintoIds += idsArray[i]+";";
				}
			}
		}
		fdMissiveMaintoIds = fdMissiveMaintoIds.substring(0,fdMissiveMaintoIds.length-1);
		fdMissiveMaintoGroupIds = fdMissiveMaintoGroupIds.substring(0,fdMissiveMaintoGroupIds.length-1);
		fdMaintoUnitGroupIds = fdMaintoUnitGroupIds.substring(0,fdMaintoUnitGroupIds.length-1);
		document.getElementsByName("fdMissiveMaintoIds")[0].value = fdMissiveMaintoIds;
		document.getElementsByName("fdMissiveMaintoGroupIds")[0].value=fdMissiveMaintoGroupIds;
		document.getElementsByName("fdMaintoUnitGroupIds")[0].value=fdMaintoUnitGroupIds;
		getAuthUnit(fdMissiveMaintoIds,fdMissiveMaintoGroupIds,"mainUnit");
	}else{
		document.getElementById("mainUnit").innerHTML = "";
	}
}
function copyCalBackFn(){
	var ids = document.getElementsByName("fdCopytoIds")[0].value;
	if(ids!=""){
		var fdMissiveCopytoIds = "";
		var fdMissiveCopytoGroupIds="";
		var fdCopytoUnitGroupIds="";
		var idsArray = ids.split(";");
		for(var i=0;i<idsArray.length;i++){
			if(idsArray[i].indexOf("cate")>-1){
				fdMissiveCopytoGroupIds += idsArray[i].substring(0,idsArray[i].indexOf("cate")-1)+";";
			}else if(idsArray[i].indexOf("group")>-1){
				fdCopytoUnitGroupIds += idsArray[i].substring(0,idsArray[i].indexOf("group")-1)+";";
			}else{
				fdMissiveCopytoIds += idsArray[i]+";";
			}
		}
		fdMissiveCopytoIds = fdMissiveCopytoIds.substring(0,fdMissiveCopytoIds.length-1);
		fdMissiveCopytoGroupIds = fdMissiveCopytoGroupIds.substring(0,fdMissiveCopytoGroupIds.length-1);
		fdCopytoUnitGroupIds = fdCopytoUnitGroupIds.substring(0,fdCopytoUnitGroupIds.length-1);
		document.getElementsByName("fdMissiveCopytoIds")[0].value = fdMissiveCopytoIds;
		document.getElementsByName("fdMissiveCopytoGroupIds")[0].value=fdMissiveCopytoGroupIds;
		document.getElementsByName("fdCopytoUnitGroupIds")[0].value=fdCopytoUnitGroupIds;
		getAuthUnit(fdMissiveCopytoIds,fdMissiveCopytoGroupIds,"copyUnit");
	}else{
		document.getElementById("copyUnit").innerHTML = "";
	}
}
function reportCalBackFn(){
	var ids = document.getElementsByName("fdReporttoIds")[0].value;
	if(ids!=""){
		var fdMissiveReporttoIds = "";
		var fdMissiveReporttoGroupIds="";
		var fdReporttoUnitGroupIds="";
		var idsArray = ids.split(";");
		for(var i=0;i<idsArray.length;i++){
			if(idsArray[i].indexOf("cate")>-1){
				fdMissiveReporttoGroupIds += idsArray[i].substring(0,idsArray[i].indexOf("cate")-1)+";";
			}else if(idsArray[i].indexOf("group")>-1){
				fdReporttoUnitGroupIds += idsArray[i].substring(0,idsArray[i].indexOf("group")-1)+";";
			}else{
				fdMissiveReporttoIds += idsArray[i]+";";
			}
		}
		fdMissiveReporttoIds = fdMissiveReporttoIds.substring(0,fdMissiveReporttoIds.length-1);
		fdMissiveReporttoGroupIds = fdMissiveReporttoGroupIds.substring(0,fdMissiveReporttoGroupIds.length-1);
		fdReporttoUnitGroupIds = fdReporttoUnitGroupIds.substring(0,fdReporttoUnitGroupIds.length-1);
		document.getElementsByName("fdMissiveReporttoIds")[0].value = fdMissiveReporttoIds;
		document.getElementsByName("fdMissiveReporttoGroupIds")[0].value=fdMissiveReporttoGroupIds;
		document.getElementsByName("fdReporttoUnitGroupIds")[0].value=fdReporttoUnitGroupIds;
		getAuthUnit(fdMissiveReporttoIds,fdMissiveReporttoGroupIds,"reportUnit");
	}else{
		document.getElementById("reportUnit").innerHTML = "";
	}
}
</script>
<html:form action="/km/imissive/km_imissive_send_dr/kmImissiveSendDR.do">
<center>
<table class="tb_normal" width=95% style="margin-top:20px">
	<html:hidden property="fdId"/>
	<tr id="optType" style="display: none">
	    <td class="td_normal_title" width=15%>
	   		<bean:message  bundle="km-imissive" key="kmImissiveDeliver.contentType"/>
		</td>
		<td width=85%>
			<xform:radio property="fdContentType" onValueChange="checkPdf(this.value,'${kmImissiveSendDRForm.fdMainId}','send');" showStatus="edit" >
				<xform:enumsDataSource enumsType="kmImissiveDeliver_contentType"></xform:enumsDataSource>
			</xform:radio>
			<div id="fdContentTypeTips" style="display: none;color: #ff0000"></div>
		</td>
	</tr>	
	<tr>
	    <td class="td_normal_title" width=15%>
	   		<bean:message  bundle="km-imissive" key="kmImissiveSendMain.distribute.addition"/>
		</td>
	    <td width=85%>
	    		<xform:checkbox property="fdReadOpinion"  showStatus="edit"  >	
	    			<xform:simpleDataSource value="1"><bean:message  bundle="km-imissive" key="kmImissiveSendMain.fdReadMissiveOpinion"/></xform:simpleDataSource>
	    		</xform:checkbox>
	    		<xform:checkbox property="fdDeliverOpinion"  showStatus="edit" >	
	    			<xform:simpleDataSource value="1"><bean:message  bundle="km-imissive" key="kmImissiveSendMain.fdReadSendOpinion"/></xform:simpleDataSource>
	    		</xform:checkbox>
	    		<xform:checkbox property="fdAttAuthFlag"  showStatus="edit">
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
			<bean:message  bundle="km-imissive" key="kmImissiveSendMain.fdAttStr.distribute"/>
		</td>
		<td width=85%>
			<input name="fdAttStr" type="hidden">
			<c:import url="/km/imissive/import/sysAttMain_DR_swf.jsp" charEncoding="UTF-8">
				<c:param name="showTitle" value="正文附件" />
				<c:param name="fdKey" value="${fdContentKey}" />
				<c:param name="fdModelId" value="${kmImissiveSendDRForm.fdMainId}" />
				<c:param name="fdModelName" value="com.landray.kmss.km.imissive.model.KmImissiveSendMain" />
			</c:import>
			<c:import url="/km/imissive/import/sysAttMain_DR_swf.jsp" charEncoding="UTF-8">
				<c:param name="showTitle" value="表单信息附件" />
				<c:param name="fdKey" value="baseInfoAtt" />
				<c:param name="fdModelId" value="${kmImissiveSendDRForm.fdMainId}" />
				<c:param name="fdModelName" value="com.landray.kmss.km.imissive.model.KmImissiveSendMain" />
			</c:import>
			<c:import url="/km/imissive/import/sysAttMain_DR_swf.jsp" charEncoding="UTF-8">
				<c:param name="showTitle" value="文档附件" />
				<c:param name="fdKey" value="attachment" />
				<c:param name="fdModelId" value="${kmImissiveSendDRForm.fdMainId}" />
				<c:param name="fdModelName" value="com.landray.kmss.km.imissive.model.KmImissiveSendMain" />
			</c:import>
			<c:import url="/km/imissive/import/sysAttMain_DR_swf.jsp" charEncoding="UTF-8">
				<c:param name="showTitle" value="易企签签署附件" />
				<c:param name="fdKey" value="yqqSigned" />
				<c:param name="fdModelId" value="${kmImissiveSendDRForm.fdMainId}" />
				<c:param name="fdModelName" value="com.landray.kmss.km.imissive.model.KmImissiveSendMain" />
			</c:import>
			<c:import url="/km/imissive/import/sysAttMain_DR_swf.jsp" charEncoding="UTF-8">
				<c:param name="showTitle" value="E签宝PDF签署附件" />
				<c:param name="fdKey" value="eqbSign" />
				<c:param name="fdModelId" value="${kmImissiveSendDRForm.fdMainId}" />
				<c:param name="fdModelName" value="com.landray.kmss.km.imissive.model.KmImissiveSendMain" />
			</c:import>
			<c:import url="/km/imissive/import/sysAttMain_DR_swf.jsp" charEncoding="UTF-8">
				<c:param name="showTitle" value="E签宝OFD签署附件" />
				<c:param name="fdKey" value="ofdEqbSign" />
				<c:param name="fdModelId" value="${kmImissiveSendDRForm.fdMainId}" />
				<c:param name="fdModelName" value="com.landray.kmss.km.imissive.model.KmImissiveSendMain" />
			</c:import>
			<c:import url="/km/imissive/import/sysAttMain_DR_swf.jsp" charEncoding="UTF-8">
				<c:param name="showTitle" value="金格OFD签署附件" />
				<c:param name="fdKey" value="ofdCySign" />
				<c:param name="fdModelId" value="${kmImissiveSendDRForm.fdMainId}" />
				<c:param name="fdModelName" value="com.landray.kmss.km.imissive.model.KmImissiveSendMain" />
			</c:import>
			<c:import url="/km/imissive/import/sysAttMain_DR_swf.jsp" charEncoding="UTF-8">
				<c:param name="showTitle" value="点聚签署附件" />
				<c:param name="fdKey" value="dianjuSign" />
				<c:param name="fdModelId" value="${kmImissiveSendDRForm.fdMainId}" />
				<c:param name="fdModelName" value="com.landray.kmss.km.imissive.model.KmImissiveSendMain" />
			</c:import>
			<c:import url="/km/imissive/import/sysAttMain_DR_swf.jsp" charEncoding="UTF-8">
				<c:param name="showTitle" value="书生OFD签署附件" />
				<c:param name="fdKey" value="ofdSursenSign" />
				<c:param name="fdModelId" value="${kmImissiveSendDRForm.fdMainId}" />
				<c:param name="fdModelName" value="com.landray.kmss.km.imissive.model.KmImissiveSendMain" />
			</c:import>
			<c:import url="/km/imissive/import/sysAttMain_DR_swf.jsp" charEncoding="UTF-8">
				<c:param name="showTitle" value="pdf正文" />
				<c:param name="fdKey" value="convert_toPDF" />
				<c:param name="fdModelId" value="${kmImissiveSendDRForm.fdMainId}" />
				<c:param name="fdModelName" value="com.landray.kmss.km.imissive.model.KmImissiveSendMain" />
			</c:import>
			<c:import url="/km/imissive/import/sysAttMain_DR_swf.jsp" charEncoding="UTF-8">
				<c:param name="showTitle" value="ofd正文" />
				<c:param name="fdKey" value="convert_toOFD" />
				<c:param name="fdModelId" value="${kmImissiveSendDRForm.fdMainId}" />
				<c:param name="fdModelName" value="com.landray.kmss.km.imissive.model.KmImissiveSendMain" />
			</c:import>
		</td>
	</tr>
	<tr>
		<td class="td_normal_title" width=15%>
			<bean:message  bundle="km-imissive" key="table.kmImissiveMainMainto"/>
		</td>
		<td width=85%>
			<input name="fdAuditNoteStr" type="hidden">
		    <input type="hidden" name="fdMissiveMaintoIds" value="${kmImissiveSendDRForm.fdMissiveMaintoIds}">
		    <input type="hidden" name="fdMissiveMaintoGroupIds" value="${kmImissiveSendDRForm.fdMissiveMaintoGroupIds}">
			<input type="hidden" name="fdMaintoUnitGroupIds" value="${kmImissiveSendDRForm.fdMaintoUnitGroupIds}">
		    <xform:dialog propertyId="fdMaintoIds" propertyName="fdMaintoNames" style="width:100%" showStatus="edit" textarea="true"  useNewStyle="true">
		      Dialog_UnitTreeList(true, 'fdMaintoIds', 'fdMaintoNames', ';', 'kmImissiveUnitAllCategoryTreeService&parentId=!{value}', '<bean:message key="kmImissiveUnit.fdCategoryId" bundle="km-imissive"/>', 'kmImissiveUnitListWithAuthService&parentId=!{value}&showUnitGroup=true&type=distribute&fdUnitId=${kmImissiveSendDRForm.fdUnitId}',mainCalBackFn,'kmImissiveUnitListWithAuthService&fdKeyWord=!{keyword}&type=distribute');
		    </xform:dialog>
		    <span id="mainUnit"></span>
		</td>
	</tr>
		<tr>
			<td class="td_normal_title" width=15%>
				<bean:message  bundle="km-imissive" key="table.kmImissiveMainCopyto"/>
			</td>
			<td width=85%>
			 	<input type="hidden" name="fdMissiveCopytoIds" value="${kmImissiveSendDRForm.fdMissiveCopytoIds}">
		        <input type="hidden" name="fdMissiveCopytoGroupIds" value="${kmImissiveSendDRForm.fdMissiveCopytoGroupIds}">
				<input type="hidden" name="fdCopytoUnitGroupIds" value="${kmImissiveSendDRForm.fdCopytoUnitGroupIds}">
				<xform:dialog propertyId="fdCopytoIds" propertyName="fdCopytoNames" style="width:100%" showStatus="edit" textarea="true"  useNewStyle="true">
				  Dialog_UnitTreeList(true, 'fdCopytoIds', 'fdCopytoNames', ';', 'kmImissiveUnitAllCategoryTreeService&parentId=!{value}', '<bean:message key="kmImissiveUnit.fdCategoryId" bundle="km-imissive"/>', 'kmImissiveUnitListWithAuthService&parentId=!{value}&showUnitGroup=true&type=distribute&fdUnitId=${kmImissiveSendDRForm.fdUnitId}',copyCalBackFn,'kmImissiveUnitListWithAuthService&fdKeyWord=!{keyword}&type=distribute');
			    </xform:dialog>
		     <span id="copyUnit"></span>
			</td>
		</tr>
		<tr>
			<td class="td_normal_title" width=15%>
				<bean:message  bundle="km-imissive" key="table.kmImissiveReportto"/>
			</td>
			<td width=85%>
			   <input type="hidden" name="fdMissiveReporttoIds" value="${kmImissiveSendDRForm.fdMissiveReporttoIds}">
		       <input type="hidden" name="fdMissiveReporttoGroupIds" value="${kmImissiveSendDRForm.fdMissiveReporttoGroupIds}">
				<input type="hidden" name="fdReporttoUnitGroupIds" value="${kmImissiveSendDRForm.fdReporttoUnitGroupIds}">
				<xform:dialog propertyId="fdReporttoIds" propertyName="fdReporttoNames" style="width:100%" showStatus="edit" textarea="true"  useNewStyle="true">
				  Dialog_UnitTreeList(true, 'fdReporttoIds', 'fdReporttoNames', ';', 'kmImissiveUnitAllCategoryTreeService&parentId=!{value}', '<bean:message key="kmImissiveUnit.fdCategoryId" bundle="km-imissive"/>', 'kmImissiveUnitListWithAuthService&parentId=!{value}&showUnitGroup=true&type=distribute&fdUnitId=${kmImissiveSendDRForm.fdUnitId}',reportCalBackFn,'kmImissiveUnitListWithAuthService&fdKeyWord=!{keyword}&type=distribute');
			    </xform:dialog>
			     <span id="reportUnit"></span>
			</td>
		</tr>
		<tr>
			<td class="td_normal_title" width=15%>
				<bean:message  bundle="km-imissive" key="kmImissiveSendMain.fdDesc"/>
			</td>
			<td width=85%>
		       <xform:textarea property="fdDesc" style="width:99%" showStatus="edit"></xform:textarea>
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
						<c:param name="fdMainId" value="${kmImissiveSendDRForm.fdMainId}" />
						<c:param name="fdModelName" value="com.landray.kmss.km.imissive.model.KmImissiveSendMain" />
						<c:param name="formBeanName" value="kmImissiveSendMainForm"/>
					</c:import>
				</div>
			</td> 
		</tr>
		 
</table>
<div style="padding-top:17px;padding-bottom:20px">
	   <ui:button text="${ lfn:message('km-imissive:kmImissiveSendMain.distribute') }"  onclick="submitForm();">
	   </ui:button>
	   <ui:button text="${ lfn:message('button.close') }" order="5" styleClass="lui_toolbar_btn_gray"  onclick="$dialog.hide('cancel');">
	    </ui:button>
 </div>
</center>
<html:hidden property="method_GET"/>
</html:form>
</template:replace>
</template:include>