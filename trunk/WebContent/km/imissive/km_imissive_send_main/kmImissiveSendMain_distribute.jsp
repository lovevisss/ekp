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
	var fdMaintoIds = document.getElementsByName("fdMaintoIds")[0];
	var fdCopytoIds = document.getElementsByName("fdCopytoIds")[0];
	var fdReporttoIds = document.getElementsByName("fdReporttoIds")[0];
	if(fdMaintoIds.value == "" && fdCopytoIds.value == "" && fdReporttoIds.value==""){
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
		
		Com_Submit(document.kmImissiveSendMainForm, 'updateDistribute');
	}
}
$(document).ready(function(){
	mainCalBackFn();
	copyCalBackFn();
	reportCalBackFn();
});
function getAuthUnit(fdIds,fdgIds,unitSpan){
	 var url="${KMSS_Parameter_ContextPath}km/imissive/km_imissive_send_main/kmImissiveSendMain.do?method=getAuthUnit"; 
	 $.ajax({     
	     type:"post",     
	     url:url,     
	     data:{fdIds:fdIds,fdgIds:fdgIds},    
	     async:false,    //用同步方式 
	     success:function(data){
		     if(data!=""){
	    	 var results =  eval("("+data+")");
	    	    document.getElementById(unitSpan).innerHTML = "单位包括: <font color='red'>"+results['names']+"</font>";
		     }else{
		    	document.getElementById(unitSpan).innerHTML = "<font color='red'>已选单位分类下没任何可用单位</font>";
			 }
		}    
   });
}
function mainCalBackFn(){
	var ids = document.getElementsByName("fdMaintoIds")[0].value;
	if(ids!=""){
		var fdMissiveMaintoIds = "";
		var fdMissiveMaintoGroupIds="";
		var idsArray = ids.split(";");
		for(var i=0;i<idsArray.length;i++){
			if(idsArray[i].indexOf("cate")>-1){
				fdMissiveMaintoGroupIds += idsArray[i].substring(0,idsArray[i].indexOf("cate")-1)+";";
			}else{
				fdMissiveMaintoIds += idsArray[i]+";";
			}
		}
		fdMissiveMaintoIds = fdMissiveMaintoIds.substring(0,fdMissiveMaintoIds.length-1);
		fdMissiveMaintoGroupIds = fdMissiveMaintoGroupIds.substring(0,fdMissiveMaintoGroupIds.length-1);
		document.getElementsByName("fdMissiveMaintoIds")[0].value = fdMissiveMaintoIds;
		document.getElementsByName("fdMissiveMaintoGroupIds")[0].value=fdMissiveMaintoGroupIds;
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
		var idsArray = ids.split(";");
		for(var i=0;i<idsArray.length;i++){
			if(idsArray[i].indexOf("cate")>-1){
				fdMissiveCopytoGroupIds += idsArray[i].substring(0,idsArray[i].indexOf("cate")-1)+";";
			}else{
				fdMissiveCopytoIds += idsArray[i]+";";
			}
		}
		fdMissiveCopytoIds = fdMissiveCopytoIds.substring(0,fdMissiveCopytoIds.length-1);
		fdMissiveCopytoGroupIds = fdMissiveCopytoGroupIds.substring(0,fdMissiveCopytoGroupIds.length-1);
		document.getElementsByName("fdMissiveCopytoIds")[0].value = fdMissiveCopytoIds;
		document.getElementsByName("fdMissiveCopytoGroupIds")[0].value=fdMissiveCopytoGroupIds;
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
		var idsArray = ids.split(";");
		for(var i=0;i<idsArray.length;i++){
			if(idsArray[i].indexOf("cate")>-1){
				fdMissiveReporttoGroupIds += idsArray[i].substring(0,idsArray[i].indexOf("cate")-1)+";";
			}else{
				fdMissiveReporttoIds += idsArray[i]+";";
			}
		}
		fdMissiveReporttoIds = fdMissiveReporttoIds.substring(0,fdMissiveReporttoIds.length-1);
		fdMissiveReporttoGroupIds = fdMissiveReporttoGroupIds.substring(0,fdMissiveReporttoGroupIds.length-1);
		document.getElementsByName("fdMissiveReporttoIds")[0].value = fdMissiveReporttoIds;
		document.getElementsByName("fdMissiveReporttoGroupIds")[0].value=fdMissiveReporttoGroupIds;
		getAuthUnit(fdMissiveReporttoIds,fdMissiveReporttoGroupIds,"reportUnit");
	}else{
		document.getElementById("reportUnit").innerHTML = "";
	}
}
</script>
<html:form action="/km/imissive/km_imissive_send_main/kmImissiveSendMain.do">
<div style="padding: 10px 0px">
<p class="txttitle"><bean:message bundle="km-imissive" key="kmImissiveSendMain.distribute.title"/></p>
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
		    <input type="hidden" name="fdMissiveMaintoIds" value="">
		    <input type="hidden" name="fdMissiveMaintoGroupIds" value="">
		    <xform:dialog propertyId="fdMaintoIds" propertyName="fdMaintoNames" style="width:100%" showStatus="edit" textarea="true">
		      Dialog_UnitTreeList(true, 'fdMaintoIds', 'fdMaintoNames', ';', 'kmImissiveUnitAllCategoryTreeService', '<bean:message key="kmImissiveUnit.fdCategoryId" bundle="km-imissive"/>', 'kmImissiveUnitListWithAuthService&parentId=!{value}&type=distribute',mainCalBackFn,'kmImissiveUnitListWithAuthService&fdKeyWord=!{keyword}&type=distribute');
		    </xform:dialog>
		    <span id="mainUnit"></span>
		</td>
	</tr>
		<tr>
			<td class="td_normal_title" width=15%>
				<bean:message  bundle="km-imissive" key="table.kmImissiveMainCopyto"/>
			</td><td width=85% colspan="2">
			 <input type="hidden" name="fdMissiveCopytoIds" value="">
		     <input type="hidden" name="fdMissiveCopytoGroupIds" value="">
			<xform:dialog propertyId="fdCopytoIds" propertyName="fdCopytoNames" style="width:100%" showStatus="edit" textarea="true">
			  Dialog_UnitTreeList(true, 'fdCopytoIds', 'fdCopytoNames', ';', 'kmImissiveUnitAllCategoryTreeService', '<bean:message key="kmImissiveUnit.fdCategoryId" bundle="km-imissive"/>', 'kmImissiveUnitListWithAuthService&parentId=!{value}&type=distribute',copyCalBackFn,'kmImissiveUnitListWithAuthService&fdKeyWord=!{keyword}&type=distribute');
		    </xform:dialog>
		     <span id="copyUnit"></span>
			</td>
		</tr>
		<tr>
			<td class="td_normal_title" width=15%>
				<bean:message  bundle="km-imissive" key="table.kmImissiveReportto"/>
			</td><td width=85% colspan="2">
			   <input type="hidden" name="fdMissiveReporttoIds" value="">
		       <input type="hidden" name="fdMissiveReporttoGroupIds" value="">
				<xform:dialog propertyId="fdReporttoIds" propertyName="fdReporttoNames" style="width:100%" showStatus="edit" textarea="true">
				  Dialog_UnitTreeList(true, 'fdReporttoIds', 'fdReporttoNames', ';', 'kmImissiveUnitAllCategoryTreeService', '<bean:message key="kmImissiveUnit.fdCategoryId" bundle="km-imissive"/>', 'kmImissiveUnitListWithAuthService&parentId=!{value}&type=distribute',reportCalBackFn,'kmImissiveUnitListWithAuthService&fdKeyWord=!{keyword}&type=distribute');
			    </xform:dialog>
			     <span id="reportUnit"></span>
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
