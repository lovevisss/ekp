<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/sys/ui/jsp/common.jsp"%>
<%@ include file="/sys/mobile/jsp/ajax-accept.jsp" %>
<template:include ref="mobile.edit" compatibleMode="true">
	<template:replace name="title">
		<c:out value="${ lfn:message('km-imissive:kmImissive.report') }"></c:out>
	</template:replace>
	<template:replace name="head">
		<link rel="Stylesheet" href="${LUI_ContextPath}/km/imissive/mobile/resource/css/imissive.css?s_cache=${MUI_Cache}" />
	</template:replace>
	<template:replace name="content">
		<html:form action="/km/imissive/km_imissive_receive_dr/kmImissiveReceiveDR.do">
			<div data-dojo-type="mui/view/DocScrollableView" data-dojo-mixins="mui/form/_ValidateMixin" id="scrollView">
				<div data-dojo-type="mui/panel/AccordionPanel" class="editPanel">
					<div data-dojo-type="mui/panel/Content" data-dojo-props="title:'上报',icon:'mui-ul'">
						<table class="muiSimple headTb" cellpadding="0" cellspacing="0" >
							<html:hidden property="fdId"/>
							<tr id="optType" style="display: none">
							    <td class="muiTitle" width=15%>
							   		<bean:message  bundle="km-imissive" key="kmImissiveDeliver.contentType"/>
								</td>
								<td>
									<xform:radio property="fdContentType" onValueChange="checkPdf(this.value,'${kmImissiveReceiveDRForm.fdMainId}','receive');" showStatus="edit" mobile="true">
										<xform:enumsDataSource enumsType="kmImissiveDeliver_contentType"></xform:enumsDataSource>
									</xform:radio>
									<div id="fdContentTypeTips" style="display: none;color: red"></div>
								</td>
							</tr>
							<tr>
							    <td class="muiTitle" >
							   		<bean:message  bundle="km-imissive" key="kmImissiveSendMain.distribute.addition"/>
								</td>
							    <td>
						    		<xform:checkbox property="fdReadOpinion"  showStatus="edit" mobile="true" >	
						    			<xform:simpleDataSource value="1"><bean:message  bundle="km-imissive" key="kmImissiveSendMain.fdReadMissiveOpinion"/></xform:simpleDataSource>
						    		</xform:checkbox>
						    		<xform:checkbox property="fdDeliverOpinion"  showStatus="edit" mobile="true">	
						    			<xform:simpleDataSource value="1"><bean:message  bundle="km-imissive" key="kmImissiveSendMain.fdReadSendOpinion"/></xform:simpleDataSource>
						    		</xform:checkbox>
						    		<xform:checkbox property="fdAttAuthFlag"  showStatus="edit" mobile="true">
						    			<xform:simpleDataSource value="1"><bean:message  bundle="km-imissive" key="kmImissiveSendMain.fdAttAuthFlag"/></xform:simpleDataSource>
						    		</xform:checkbox>
								</td>
							</tr>
							<tr>
								<td class="muiTitle">
									分发时效
								</td>
								<td>
									<xform:radio showStatus="1" property="fdPrescription">
										<xform:enumsDataSource enumsType="kmImissive_distrbute_prescription"></xform:enumsDataSource>
									</xform:radio>
								</td>
							</tr>
							<tr>
								<td class="muiTitle">
									<bean:message  bundle="km-imissive" key="kmImissiveSendMain.fdAttStr.report"/>
								</td>
								<td>
									<input name="fdAttStr" type="hidden">
									<c:import url="/km/imissive/import/sysAttMain_DR_swf.jsp" charEncoding="UTF-8">
										<c:param name="showTitle" value="正文附件" />
										<c:param name="fdKey" value="${fdContentKey}" />
										<c:param name="fdModelId" value="${kmImissiveReceiveDRForm.fdMainId}" />
										<c:param name="fdModelName" value="com.landray.kmss.km.imissive.model.KmImissiveReceiveMain" />
										<c:param name="mobile" value="true" />
									</c:import>
									<c:import url="/km/imissive/import/sysAttMain_DR_swf.jsp" charEncoding="UTF-8">
										<c:param name="showTitle" value="表单信息附件" />
										<c:param name="fdKey" value="baseInfoAtt" />
										<c:param name="fdModelId" value="${kmImissiveReceiveDRForm.fdMainId}" />
										<c:param name="fdModelName" value="com.landray.kmss.km.imissive.model.KmImissiveReceiveMain" />
										<c:param name="mobile" value="true" />
									</c:import>
									<c:import url="/km/imissive/import/sysAttMain_DR_swf.jsp" charEncoding="UTF-8">
										<c:param name="showTitle" value="文档附件" />
										<c:param name="fdKey" value="attachment" />
										<c:param name="fdModelId" value="${kmImissiveReceiveDRForm.fdMainId}" />
										<c:param name="fdModelName" value="com.landray.kmss.km.imissive.model.KmImissiveReceiveMain" />
										<c:param name="mobile" value="true" />
									</c:import>
									<c:import url="/km/imissive/import/sysAttMain_DR_swf.jsp" charEncoding="UTF-8">
										<c:param name="showTitle" value="易企签签署附件" />
										<c:param name="fdKey" value="yqqSigned" />
										<c:param name="fdModelId" value="${kmImissiveReceiveDRForm.fdMainId}" />
										<c:param name="fdModelName" value="com.landray.kmss.km.imissive.model.KmImissiveReceiveMain" />
										<c:param name="mobile" value="true" />
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
								<td class="muiTitle" >
									<bean:message  bundle="km-imissive" key="table.kmImissiveMainMainto"/>
								</td>
								<td>
									<input name="fdAuditNoteStr" type="hidden">
								    <input type="hidden" name="fdMissiveMaintoIds" value="${kmImissiveReceiveDRForm.fdMissiveMaintoIds}">
								    <input type="hidden" name="fdMissiveMaintoGroupIds" value="${kmImissiveReceiveDRForm.fdMissiveMaintoGroupIds}">
									<input type="hidden" name="fdMaintoUnitGroupIds" value="${kmImissiveReceiveDRForm.fdMaintoUnitGroupIds}">
									<div id="main_s">
								    	<div data-dojo-type='sys/unit/mobile/selectdialog/UnitSelectDialog' id="dialog_main_s"
									    	 data-dojo-props='"afterSelect":function(evt){afterSelectMain(evt);},"idField":"fdMaintoIds","nameField":"fdMaintoNames","curIds":"${defaultFdMaintoIds}","curNames":"${defaultFdMaintoNames}","subject":"主送单位","title":"主送单位","showStatus":"edit","isMul":false,"required":false,
									   		 "listDataUrl":"/sys/common/datajson.jsp?s_bean=kmImissiveUnitMobileAuthDataBeanService&showAll=false&parentId=!{parentId}&type=report",
									   		 "searchDataUrl":"/sys/common/datajson.jsp?s_bean=kmImissiveUnitMobileSearchDataBeanService&type=report&fdKeyWord=!{keyword}",
									   		 "detailUrl":"/sys/common/datajson.jsp?s_bean=kmImissiveUnitDetailService&curIds=!{curIds}",
									   		 "headerUrl":"/sys/common/datajson.jsp?s_bean=kmImissiveUnitHeaderService&curId=!{curId}"'>
										</div>
									</div>
								    
								    <span id="mainUnit"></span>
								</td>
							</tr>
								<tr>
									<td class="muiTitle" >
										<bean:message  bundle="km-imissive" key="table.kmImissiveMainCopyto"/>
									</td>
									<td class="muiTitle" >
									 <input type="hidden" name="fdMissiveCopytoIds" value="${kmImissiveReceiveDRForm.fdMissiveCopytoIds}">
								     <input type="hidden" name="fdMissiveCopytoGroupIds" value="${kmImissiveReceiveDRForm.fdMissiveCopytoGroupIds}">
									 <input type="hidden" name="fdCopytoUnitGroupIds" value="${kmImissiveReceiveDRForm.fdCopytoUnitGroupIds}">

										<div id="copy_s">
								    	<div data-dojo-type='sys/unit/mobile/selectdialog/UnitSelectDialog' id="dialog_copy_s"
									    	 data-dojo-props='"afterSelect":function(evt){afterSelectCopy(evt);},"idField":"fdCopytoIds","nameField":"fdCopytoNames","curIds":"${defaultFdCopytoIds}","curNames":"${defaultFdCopytoNames}","subject":"抄送单位","title":"抄送单位","showStatus":"edit","isMul":false,"required":false,
									   		 "listDataUrl":"/sys/common/datajson.jsp?s_bean=kmImissiveUnitMobileAuthDataBeanService&showAll=false&parentId=!{parentId}&type=report",
									   		 "searchDataUrl":"/sys/common/datajson.jsp?s_bean=kmImissiveUnitMobileSearchDataBeanService&type=report&fdKeyWord=!{keyword}",
									   		  "detailUrl":"/sys/common/datajson.jsp?s_bean=kmImissiveUnitDetailService&curIds=!{curIds}",
									   		 "headerUrl":"/sys/common/datajson.jsp?s_bean=kmImissiveUnitHeaderService&curId=!{curId}"'>
										</div>
									</div>
								     <span id="copyUnit"></span>
									</td>
								</tr>
								<tr>
									<td class="muiTitle" >
										<bean:message  bundle="km-imissive" key="table.kmImissiveReportto"/>
									</td>
									<td>
									   <input type="hidden" name="fdMissiveReporttoIds" value="${kmImissiveReceiveDRForm.fdMissiveReporttoIds}">
								       <input type="hidden" name="fdMissiveReporttoGroupIds" value="${kmImissiveReceiveDRForm.fdMissiveReporttoGroupIds}">
										<input type="hidden" name="fdReporttoUnitGroupIds" value="${kmImissiveReceiveDRForm.fdReporttoUnitGroupIds}">

										<div id="report_s">
									    	<div data-dojo-type='sys/unit/mobile/selectdialog/UnitSelectDialog' id="dialog_report_s"
										    	 data-dojo-props='"afterSelect":function(evt){afterSelectReport(evt);},"idField":"fdReporttoIds","nameField":"fdReporttoNames","curIds":"${defaultFdReporttoIds}","curNames":"${defaultFdReporttoNames}","subject":"抄报单位","title":"抄报单位","showStatus":"edit","isMul":false,"validate":"required","required":false,
										   		 "listDataUrl":"/sys/common/datajson.jsp?s_bean=kmImissiveUnitMobileAuthDataBeanService&showAll=false&parentId=!{parentId}&type=report",
										   		  "searchDataUrl":"/sys/common/datajson.jsp?s_bean=kmImissiveUnitMobileSearchDataBeanService&type=report&fdKeyWord=!{keyword}",
										   		  "detailUrl":"/sys/common/datajson.jsp?s_bean=kmImissiveUnitDetailService&curIds=!{curIds}",
										   		 "headerUrl":"/sys/common/datajson.jsp?s_bean=kmImissiveUnitHeaderService&curId=!{curId}"'>
											</div>
										</div>
									     <span id="reportUnit"></span>
									</td>
								</tr>
								<tr>
									<td class="muiTitle" >
										<bean:message  bundle="km-imissive" key="kmImissiveSendMain.fdDesc"/>
									</td>
									<td>
								       <xform:textarea property="fdDesc" mobile="true" style="width:100%" showStatus="edit"></xform:textarea>
									</td>
								</tr>
								<tr>
									<td class="muiTitle" >
										<bean:message  bundle="km-imissive" key="kmImissiveSendMain.fdNotifyType"/>
									</td>
									<td>
										<kmss:editNotifyType property="fdNotifyType" mobile="true" required=""/>
									</td>
								</tr>
								<tr>
									<td colspan="2">
										<div  style="padding:10px 8px 12px;font-size: 1.6rem ">审批意见:</div>
										<c:import url="/km/imissive/mobile/import/lbpmAuditNote_list.jsp" charEncoding="UTF-8">
											<c:param name="fdModelId" value="${kmImissiveReceiveDRForm.fdMainId}" />
											<c:param name="fdModelName" value="com.landray.kmss.km.imissive.model.KmImissiveReceiveMain" />
											<c:param name="formBeanName" value="kmImissiveReceiveMainForm"/>
										</c:import>
									</td>
								</tr>
								
						</table>
					</div>
				</div>
				<ul data-dojo-type="mui/tabbar/TabBar" fixed="bottom" data-dojo-props='fill:"grid"'>
				  	<li data-dojo-type="mui/tabbar/TabBarButton" onclick="submitReport();"><bean:message  key="button.submit"/></li>
				</ul>
			</div>
			<%@include file="/km/imissive/mobile/DRScript.jsp"%> 
			<script type="text/javascript">
			require(["mui/form/ajax-form!kmImissiveReceiveDRForm"]);
			require(["mui/dialog/BarTip", "dojo/ready"], function(BarTip, ready) {
				ready(function() {
					checkPdf('0','${kmImissiveReceiveDRForm.fdMainId}','receive');
				}); 
			});
			require(['dojo/ready','dijit/registry','dojo/topic','dojo/query','dojo/dom-style','dojo/dom-class',"dojo/_base/lang","mui/dialog/Tip","dojo/request","mui/device/adapter","mui/util",'dojo/date/locale'],
				function(ready,registry,topic,query,domStyle,domClass,lang,Tip,req,adapter,util,locale){
				 window.submitReport = function (){
					 
					 var attArr=[];
					 var tb = query('.contentAttTb');
					 for(var i = 0;i < tb.length;i++){
						 var values = '';
						 var gs = document.getElementById(tb[i].id);
						 var selected = query("[name='List_Selected']",gs);
						 for(var j = 0;j < selected.length;j++){
							if(selected[j].value){
								values +=selected[j].value + ','; 
							}
						 }
						 if(values != ''){
							var attObj = {};
							values = values.substring(0,values.length-1);
							attObj['attKey'] = tb[i].id;
							attObj['attIds'] = values;
							attArr.push(attObj);
						 }
					 }
					 document.getElementsByName("fdAttStr")[0].value = JSON.stringify(attArr);
					 getAuditNotes();
					 
					var validateFlag = true;
					var fdNotifyType = document.getElementsByName("fdNotifyType")[0];
					if(fdNotifyType.value == null || fdNotifyType.value == ""){
						Tip.tip({icon:'mui mui-warn', text:'<bean:message key="kmImissiveSendMain.message.error.fdNotifyType" bundle="km-imissive" />',width:'280',height:'60'});
						validateFlag = false;
						return;
					}
					var fdMaintoIds = document.getElementsByName("fdMaintoIds")[0];
					var fdCopytoIds = document.getElementsByName("fdCopytoIds")[0];
					var fdReporttoIds = document.getElementsByName("fdReporttoIds")[0];
					if(fdMaintoIds.value == "" && fdCopytoIds.value == "" && fdReporttoIds.value==""){
						Tip.tip({icon:'mui mui-warn', text:'<bean:message key="kmImissiveSendMain.message.error.distribute" bundle="km-imissive" />',width:'280',height:'80'});
						validateFlag = false;
						return;
					}
					if(validateFlag){
						Com_Submit(document.kmImissiveReceiveDRForm, 'updateReport');
					}
				}
			});	
		</script>
		</html:form>
	</template:replace>
</template:include>
