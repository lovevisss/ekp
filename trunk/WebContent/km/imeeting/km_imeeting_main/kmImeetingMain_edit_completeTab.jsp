<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/sys/ui/jsp/common.jsp"%>
<%@page import="com.landray.kmss.km.imeeting.util.BoenUtil"%>
<%@ page import=" com.landray.kmss.util.ResourceUtil"%>
<%@page import="com.landray.kmss.util.SpringBeanUtil"%>
<%@page import="com.landray.kmss.km.imeeting.util.KmImeetingConfigUtil"%>
<%@page import="com.landray.kmss.km.imeeting.util.KKUtil"%>
<%@page import="com.landray.kmss.sys.appconfig.service.ISysAppConfigService"%>
<%@page import="java.util.Map"%>	
<%
	pageContext.setAttribute("_isBoenEnable", new Boolean(KmImeetingConfigUtil.isBoenEnable()));
%>
<template:replace name="content"> 
<%@include file="/km/imeeting/km_imeeting_scheme/kmImeetingScheme_editScheme.jsp"%>
	<c:if test="${param.approveModel ne 'right'}">
		<form name="kmImeetingMainForm" method="post" action ="${KMSS_Parameter_ContextPath}km/imeeting/km_imeeting_main/kmImeetingMain.do">
	</c:if>	
		<html:hidden property="fdId" />
		<html:hidden property="docStatus" />
		<html:hidden property="docCreatorId" />
		<html:hidden property="docCreateTime" />
		<html:hidden property="fdNotifyerId" />
		<html:hidden property="fdChangeMeetingFlag" />
		<html:hidden property="fdSummaryFlag" />
		<html:hidden property="method_GET"/>
		<html:hidden property="fdIsTopic" value="${kmImeetingMainForm.fdIsTopic}"/>
		<html:hidden property="fdModelId" value = "${kmImeetingMainForm.fdModelId}" />
		<html:hidden property="fdModelName" value = "${kmImeetingMainForm.fdModelName}" />
		<html:hidden property="fdPhaseId" value = "${kmImeetingMainForm.fdPhaseId}" />
		<html:hidden property="fdWorkId" value = "${kmImeetingMainForm.fdWorkId}" />
		<html:hidden property="fdChangeType" value = "${kmImeetingMainForm.fdChangeType}" />
		<html:hidden property="fdTemplateId" value = "${kmImeetingMainForm.fdTemplateId}" />
		<html:hidden property="fdTemplateName" value = "${kmImeetingMainForm.fdTemplateName}" />
		<html:hidden property="fdSchemeId" value = "${kmImeetingMainForm.fdSchemeId}" />
		<html:hidden property="bookId" value="${HtmlParam.bookId }"/>
		
		
		<c:set var="formShowStatus" value="edit"></c:set>
		<c:if test="${not empty kmImeetingMainForm.fdSchemeId}">
			<c:set var="formShowStatus" value="readOnly"></c:set>
		</c:if>
		
		<div class="lui_form_content_frame" style="padding-top:20px"> 
			<table class="tb_normal" width=100% id="Table_Main">
				<tr>
					<td colspan="4" id="docSubject" style="text-align:center">
						<xform:text property="fdName" style="text-align:center;width:50%" ></xform:text>
						<span id="docSubjectSpan">通知单</span>
					</td>
				</tr>
				<tr>
					<td colspan="4" class="com_subject">
						<div>
							<div style="margin-left:0px;font-size: 110%;font-weight: bold;display:inline-block">
								会议方案信息&nbsp;&nbsp;&nbsp;
							</div>
							<a href="${LUI_ContextPath }/km/imeeting/km_imeeting_scheme/kmImeetingScheme.do?method=view&fdId=${kmImeetingMainForm.fdSchemeId}" target="_blank">${kmImeetingMainForm.fdSchemeName}</a>
							<input type="button" class="lui_form_button" value="选择方案"
								onclick="selectSchemeList();"/>
						</div>
					</td>
				</tr>
				<c:if test="${kmImeetingMainForm.fdChangeMeetingFlag=='true' }">
					<tr>
						<td class="td_normal_title" width=15%>
							<bean:message bundle="km-imeeting" key="kmImeetingMain.changeMeetingReason"/>
						</td>
						<td colspan="3">
							<xform:textarea property="changeMeetingReason" style="width:95%;" htmlElementProperties="data-actor-expand='true'"
								required="true" showStatus="edit" validators="maxLength(1500)" subject="变更事由"></xform:textarea>
							<html:hidden property="beforeChangeContent"/>
						</td>
					</tr>
				</c:if>
				<tr >
					<td class="td_normal_title" width="15%">
						<bean:message key="kmImeetingMain.fdMeetingNum" bundle="km-imeeting" />
					</td>
					<td width="35%">
						<span calss="td_subject">
							<c:choose>
								<c:when test='${kmImeetingMainForm.docNumber!=null}'>
								    <xform:text property="docNumber" showStatus="view" style="width:95%;" />
								</c:when>
								<c:otherwise>
									<bean:message bundle="km-imeeting" key="kmImeetingScheme.auto.number" />
								</c:otherwise>
							</c:choose>
						</span>
					</td>
					<td class="td_normal_title" width="15%">
						<bean:message key="kmImeetingMain.fdDate" bundle="km-imeeting" />
					</td>
					<td width="35%" >
						<%-- dateDomStatus 在setValueFromScheme() 中定义 --%>
						<c:if test="${empty dateDomStatus}">
							<c:set var="dateDomStatus" value="edit" />
						</c:if>
						<xform:datetime property="fdHoldDate" dateTimeType="datetime" showStatus="${dateDomStatus}"
							 onValueChange="changeDateTime" required="true" validators="after compareTime"></xform:datetime>
						<span style="position: relative;top:-5px;">~</span>
						<xform:datetime property="fdFinishDate" dateTimeType="datetime" showStatus="${dateDomStatus}"
							onValueChange="changeDateTime" required="true" validators="after compareTime"></xform:datetime>
						<%--隐藏域,保存改变前的时间，用于回退--%>
						<input type="hidden" name="fdHoldDateTmp" value="${HtmlParam.kmImeetingMainForm.fdHoldDate}">
						<input type="hidden" name="fdFinishDateTmp" value="${HtmlParam.kmImeetingMainForm.fdFinishDate}">
						<xform:text property="fdHoldDuration" showStatus="noShow" validators="validateDuration" subject="${lfn:message('km-imeeting:kmImeetingMain.fdHoldDuration')}"/>
					</td>
				</tr>
				<tr >
					<td class="td_normal_title" width="15%">
						<bean:message bundle="km-imeeting" key="kmImeetingMain.fdNeedPlace" />
					</td>
					<td width="35%">
						<c:choose>
							<c:when test="${fdNeedMultiRes}">
					 			<xform:dialog propertyId="fdPlaceId" propertyName="fdPlaceName" showStatus="edit" validators="validateplace validateUserTime" className="inputsgl" style="width:90%;" 
					 				subject="${lfn:message('km-imeeting:kmImeetingMain.fdMainPlace') }"  htmlElementProperties="placeholder='${lfn:message('km-imeeting:kmImeetingMain.fdMainPlace') }'">
							  	 	selectHoldPlace();
								</xform:dialog>
								<input type="hidden" name="fdPlaceUserTime" value="${ kmImeetingMainForm.fdUserTime}"
										subject="${lfn:message('km-imeeting:kmImeetingMain.fdMainPlace') }"/>
								<br>
					 			<c:set var="hasSysAttend" value="false"></c:set>
								<kmss:ifModuleExist path="/sys/attend">
									<c:set var="hasSysAttend" value="true"></c:set>
								</kmss:ifModuleExist>
								<c:if test="${hasSysAttend == true }">
									<c:import url="/sys/attend/import/map_tag.jsp" charEncoding="UTF-8">
										<c:param name="propertyName" value="fdOtherPlace"></c:param>
										<c:param name="propertyCoordinate" value="fdOtherPlaceCoordinate"></c:param>
										<c:param name="validators" value="validateplace"></c:param>
										<c:param name="placeholder" value="km-imeeting:kmImeetingMain.fdOtherMainPlace"></c:param>
										<c:param name="subject" value="${ lfn:message('km-imeeting:kmImeetingMain.fdPlace')}"></c:param>
										<c:param name="style" value="width:90%;"></c:param>
									</c:import>
								</c:if>
								<c:if test="${hasSysAttend == false }">
									<xform:text property="fdOtherPlace" style="width:90%;" validators="validateplace" subject="${lfn:message('km-imeeting:kmImeetingMain.fdPlace') }" htmlElementProperties="placeholder='${lfn:message('km-imeeting:kmImeetingMain.fdOtherMainPlace') }'"></xform:text>
								</c:if>
								<span class="txtstrong">*</span>
								<div class="roomDetail" style="display: none;margin: 5px 0;padding: 5px;background-color: #fff5d8;border: 1px solid #e0a385;"></div>
								<br/><br/>
								
					 			<xform:dialog propertyId="fdVicePlaceIds" propertyName="fdVicePlaceNames" showStatus="edit" validators="validateViceUserTime"
					 				className="inputsgl" style="width:90%;"  htmlElementProperties="placeholder='${lfn:message('km-imeeting:kmImeetingMain.fdVicePlaces') }'"
					 				subject="${lfn:message('km-imeeting:kmImeetingMain.fdOtherVicePlace') }">
							  	 	selectHoldVicePlace();
								</xform:dialog>
								<br/><br/>
								<c:if test="${hasSysAttend == true }">
									<c:import url="/sys/attend/import/map_tag.jsp" charEncoding="UTF-8">
										<c:param name="propertyName" value="fdOtherVicePlace"></c:param>
										<c:param name="propertyCoordinate" value="fdOtherVicePlaceCoord"></c:param>
										<c:param name="placeholder" value="km-imeeting:kmImeetingMain.fdOtherVicePlace"></c:param>
										<c:param name="subject" value="${ lfn:message('km-imeeting:kmImeetingMain.fdOtherMainPlace')}"></c:param>
										<c:param name="style" value="width:90%;"></c:param>
									</c:import>
								</c:if>
								<c:if test="${hasSysAttend == false }">
									<xform:text property="fdOtherVicePlace" style="width:90%;" subject="${lfn:message('km-imeeting:kmImeetingMain.fdOtherVicePlace') }"  htmlElementProperties="placeholder='${lfn:message('km-imeeting:kmImeetingMain.fdOtherVicePlace') }'"></xform:text>
								</c:if>
								<input type="hidden" name="fdVicePlaceUserTimes" value="${ kmImeetingMainForm.fdVicePlaceUserTimes}"/>
							</c:when>
							<c:otherwise>
					 			<xform:dialog propertyId="fdPlaceId" propertyName="fdPlaceName" showStatus="edit" validators="validateplace validateUserTime"
					 				className="inputsgl" style="width:90%;" 
					 				subject="${lfn:message('km-imeeting:kmImeetingMain.fdPlace') }">
							  	 	selectHoldPlace();
								</xform:dialog>
								<input type="hidden" name="fdPlaceUserTime" value="${ kmImeetingMainForm.fdUserTime}"
										subject="${lfn:message('km-imeeting:kmImeetingMain.fdPlace') }"/>
								<br/><br/>
					 			<c:set var="hasSysAttend" value="false"></c:set>
								<kmss:ifModuleExist path="/sys/attend">
									<c:set var="hasSysAttend" value="true"></c:set>
								</kmss:ifModuleExist>
								<c:if test="${hasSysAttend == true }">
									<c:import url="/sys/attend/import/map_tag.jsp" charEncoding="UTF-8">
										<c:param name="propertyName" value="fdOtherPlace"></c:param>
										<c:param name="propertyCoordinate" value="fdOtherPlaceCoordinate"></c:param>
										<c:param name="validators" value="validateplace"></c:param>
										<c:param name="placeholder" value="km-imeeting:kmImeetingMain.fdOtherPlace"></c:param>
										<c:param name="subject" value="${ lfn:message('km-imeeting:kmImeetingMain.fdPlace')}"></c:param>
										<c:param name="style" value="width:90%;"></c:param>
									</c:import>
								</c:if>
								<c:if test="${hasSysAttend == false }">
									<xform:text property="fdOtherPlace" style="width:90%;" validators="validateplace" subject="${lfn:message('km-imeeting:kmImeetingMain.fdPlace') }" htmlElementProperties="placeholder='${lfn:message('km-imeeting:kmImeetingMain.fdOtherPlace') }'"></xform:text>
								</c:if>
								<span class="txtstrong">*</span>
								<div class="roomDetail" style="display: none;margin: 5px 0;padding: 5px;background-color: #fff5d8;border: 1px solid #e0a385;"></div>
							</c:otherwise>
						</c:choose>
						<c:if test="${not empty kmImeetingMainForm.fdSchemePlace}">
						<span id="schemePlace" class="txtstrong">建议会议地点:${kmImeetingMainForm.fdSchemePlace}</span>
						</c:if>
					</td>
					<td class="td_normal_title" width="15%">
						报名截止时间
					</td>
					<td width="35%">
						<xform:datetime style="width:90%" property="fdFeedBackDeadline" dateTimeType="datetime" showStatus="edit" subject="${lfn:message('km-imeeting:kmImeetingMain.fdFeedBackDeadline')}" required="true" validators="after valDeadline"></xform:datetime>
					</td>
				</tr>
				<tr >
					<td class="td_normal_title" width="15%">
						<bean:message bundle="km-imeeting" key="kmImeetingMain.fdHost"/>
					</td>
					<td width="35%">
						<xform:address propertyName="fdHostName" propertyId="fdHostId" showStatus="${formShowStatus}" onValueChange="addPost" orgType="ORG_TYPE_PERSON" style="width:90%;"  required="${_isBoenEnable}" subject="主持人"></xform:address>
					</td>
					<script>
						seajs.use(['lui/jquery', 'lui/dialog', 'lui/topic'],function($, dialog, topic){
							window.addPost = function(obj){
								var fdStaffingLevel = $('[name="fdPosition"]')[0];
								var fdTransferStaffId = $('input[name="fdHostId"]').val();
								if(fdTransferStaffId){
									$.ajax({
										url : '${LUI_ContextPath}/km/imeeting/km_imeeting_scheme/kmImeetingScheme.do?method=getPersonInfo',
										type: 'POST',
										dataType: 'json',
										data : {
											id : fdTransferStaffId
										},
										success : function(data, textStatus, xhr){
											var d = eval(data);
											if(fdStaffingLevel && d.level)
												fdStaffingLevel.value = d.level.name;
											if (d.level==undefined) {
												fdStaffingLevel.value = '';
											}
										}
									});
								}else{
									if(fdStaffingLevel)
										fdStaffingLevel.value = '';
								}
							};
						});
					</script>
					<td class="td_normal_title" width="15%">
						职务<br>
					</td>
					<td width="35%">
						<xform:text property="fdPosition" className="inputread_normal" showStatus="readOnly" style="width:90%;"/>
					</td>
				</tr>
				<tr>
					<td class="td_normal_title" width="15%">
						会议发起人
					</td>
					<td width="35%" >
						<c:out value="${kmImeetingMainForm.docCreatorName}"></c:out>
					</td>
					<td class="td_normal_title" width="15%">
						发起人部门
					</td>
					<td width="35%" >
						<input name="fdCreatorDeptId" type="hidden" value="${kmImeetingMainForm.fdCreatorDeptId}">
						<input name="fdCreatorDeptName" type="hidden" value="${kmImeetingMainForm.fdCreatorDeptName}">
						<c:out value="${kmImeetingMainForm.fdCreatorDeptName}"></c:out>
					</td>
				</tr>
				<tr>
					<td class="td_normal_title" width="15%">
						出席会议人员
					</td>
					<td width="85%" colspan="3">
						<%-- attendDomStatus 在setValueFromScheme() 中定义 --%>
						<c:if test="${empty attendDomStatus}">
							<c:set var="attendDomStatus" value="edit" />
						</c:if>
						<xform:address  style="width:96%;" textarea="true" showStatus="${attendDomStatus}"  propertyId="fdAttendPersonIds" propertyName="fdAttendPersonNames"
									orgType="ORG_TYPE_ALL" mulSelect="true" validators="validateattend"
									subject="${lfn:message('km-imeeting:kmImeetingMain.fdAttendPersons') }" required="true">
						</xform:address>
					</td>
				</tr>
				<tr >
					<td class="td_normal_title" width="15%">
						邀请参加人员
					</td>
					<td width="85%" colspan="3">
						<xform:address  style="width:96%;" textarea="true" showStatus="${formShowStatus}"  propertyId="fdInvitePersonIds" propertyName="fdInvitePersonNames" 
									orgType="ORG_TYPE_ALL" mulSelect="true" subject="${lfn:message('km-imeeting:kmImeetingMain.fdInvitePersons') }">
						</xform:address>
					</td>
				</tr>
				<tr >
					<td class="td_normal_title" width="15%">
						列席会议人员
					</td>
					<td width="85%" colspan="3">
						<xform:address style="width:96%;" textarea="true" showStatus="${formShowStatus}"  propertyId="fdParticipantPersonIds" propertyName="fdParticipantPersonNames" orgType="ORG_TYPE_ALL" mulSelect="true"></xform:address>
					</td>
				</tr>
				<tr >
					<td class="td_normal_title" width="15%">
						<!-- 纪要人员 -->
						<bean:message key="kmImeetingMain.createStep.base.fdSummaryInputPerson" bundle="km-imeeting" />
					</td>
					<td width="35%">
						<xform:address style="width:90%;"   propertyId="fdSummaryInputPersonId" propertyName="fdSummaryInputPersonName" 
									orgType="ORG_TYPE_PERSON" validators="validateSummaryInputPerson">
						</xform:address>
					</td>
					<td class="td_normal_title" width="15%">
						会服人员
					</td>
					<td width="35%">
						<xform:address style="width:90%" showStatus="edit"  propertyId="fdAssistPersonIds" propertyName="fdAssistPersonNames" orgType="ORG_TYPE_ALL" mulSelect="true" required="${_isBoenEnable}" subject="会服人员"></xform:address>
					</td>
				</tr>
				<tr>
					<td class="td_normal_title" width="15%">
						<!-- 工作安排 -->
						<bean:message key="kmimeetingmain.workArrangement" bundle="km-imeeting" />
					</td>
					<td colspan="3" width="85%">
						<xform:textarea property="workArrangement" showStatus="${formShowStatus}" style="width:95%"></xform:textarea>
					</td>
				</tr>
			</table>
			
			<div class="lui_form_content_frame" style="margin-top:25px">
				<table class="tb_normal" width=100% id="Table_Main"> 
					<tr>
						<td colspan="4" class="com_subject" style="font-size: 110%;font-weight: bold;">
							<c:out value="会议议题信息"></c:out>
							&nbsp;&nbsp;&nbsp;
							<c:if test="${empty kmImeetingMainForm.fdSchemeId}">
								<input type="button" class="lui_form_button" value="<bean:message key="kmImeetingAgenda.operation.addDetailTopic.mobile" bundle="km-imeeting"/>"
									onclick="selectTopicList();"/>
							</c:if>
						</td>
					</tr>
					<tr>
						<%--会议议题信息--%>
						<td colspan="4">
							<html:hidden property="fdIsTopic" value="1"/>
							<c:set var="isOnMainPage" value="true"></c:set>
							<%@include file="/km/imeeting/km_imeeting_agenda/kmImeetingAgenda_editTopic.jsp"%>
						</td>
					</tr>
				</table>
			</div>
			<%@include file="/km/imeeting/import/kmImeeting_attendUnit.jsp"%>
			<%-- 会议通知 --%>
			<div class="lui_form_content_frame">
				<table class="tb_normal" width=100%>
					<%-- 会议通知选项 --%>
					<td colspan="4" class="com_subject" style="font-size: 110%;font-weight: bold;">
						${lfn:message('km-imeeting:kmImeetingMain.createStep.sendNotify') }
					</tr>
					<tr style="display:none">
						<td class="td_normal_title" width=15%>
							<bean:message bundle="km-imeeting" key="kmImeetingMain.fdNotifyType"/>
						</td>
						<td width="85%" colspan="3">
							<xform:radio property="fdNotifyType" showStatus="edit" value="1">
		     							<xform:enumsDataSource enumsType="km_imeeting_main_fd_notify_type" />
							</xform:radio>
						</td>
					</tr>
					<%-- 会议通知方式 --%>
					<tr>
						<td class="td_normal_title" width=15%>
							<bean:message bundle="km-imeeting" key="kmImeetingMain.fdNotifyWay"/>
						</td>
						<td width="85%" colspan="3">
							 <kmss:editNotifyType property="fdNotifyWay" />
						</td>
					</tr>
				</table>
			</div>
			
			<div class="lui_form_content_frame">
				<table class="tb_normal" width=100% id="Table_Main"> 
					<tr>
						<td colspan="4" class="com_subject" style="font-size: 110%;font-weight: bold;">
							<c:out value="会议辅助资源"></c:out>
						</td>
					</tr>
					<tr class="toggleRes" >
					 		<%--会议室辅助设备--%>
					 		<td class="td_normal_title" width=15% title="${lfn:message('km-imeeting:kmImeetingMain.kmImeetingEquipment.tip') }">
					 			<bean:message bundle="km-imeeting" key="kmImeetingMain.kmImeetingEquipment"/>
					 		</td>
					 		<td width="85%" colspan="3" >
								<xform:dialog propertyId="kmImeetingEquipmentIds" propertyName="kmImeetingEquipmentNames" showStatus="edit" 
					 				className="inputsgl" style="width:98%;float:left">
							  	 	selectEquipment();
								</xform:dialog>
							</td>
					 	</tr>
					 	<tr class="toggleRes" >
					 		<%--会议室辅助服务--%>
					 		<td class="td_normal_title" width=15% title="${lfn:message('km-imeeting:kmImeetingMain.kmImeetingDevices.tip') }">
					 			<bean:message bundle="km-imeeting" key="kmImeetingMain.kmImeetingDevices"/>
					 		</td>
					 		<td width="85%" colspan="3" class="meeting-device-style">
								<ui:dataview>
									<ui:source type="AjaxJson">
										{url:'/km/imeeting/km_imeeting_device/kmImeetingDevice.do?method=listDevices&orderby=fdOrder&ordertype=up'}
									</ui:source>
									<ui:render type="Template">
										<c:import url="/km/imeeting/resource/tmpl/devices.jsp" charEncoding="UTF-8"></c:import>
									</ui:render>
								</ui:dataview>
							</td>
					 	</tr>
				</table>
			</div>
			
			<div class="lui_form_content_frame">
				<table class="tb_normal" width=100% id="Table_Main"> 
					<tr>
						<td colspan="4" class="com_subject" style="font-size: 110%;font-weight: bold;">
							<c:out value="短信内容"></c:out>
						</td>
					</tr>
					<tr>
						<!-- 短息内容 -->
						<td class="td_normal_title" width="15%">
							<c:out value="短信内容"></c:out>
						</td>
						<td>
							<xform:textarea property="fdSMSContent" style="width:95%"></xform:textarea>
							<span class="txtstrong">&nbsp;&nbsp;勾选短消息并且填写短信内容才生效</span>
						</td>
					</tr>
				</table>
			</div>
		</div>
		
		<%-- 会议历史操作信息 --%>
		<div style="display: none;">
			<c:forEach items="${kmImeetingMainForm.kmImeetingMainHistoryForms}"  var="kmImeetingMainHistoryItem" varStatus="vstatus">
				<input type="hidden" name="kmImeetingMainHistoryForms[${vstatus.index}].fdId" value="${kmImeetingMainHistoryItem.fdId}" /> 
			</c:forEach>
		</div>
		
		<ui:tabpanel suckTop="true" layout="sys.ui.tabpanel.sucktop" var-count="5" var-average='false' var-useMaxWidth='true'
				var-supportExpand="true" var-expand="true">
			<%@include file="/km/imeeting/km_imeeting_main/kmImeetingMain_edit_completeContent.jsp"%>
		</ui:tabpanel>
	<c:if test="${param.approveModel ne 'right'}">
	 </form>
	</c:if>
	<%@include file="/km/imeeting/km_imeeting_main/kmImeetingMain_add_js.jsp"%>
	<%@include file="/km/imeeting/km_imeeting_main/kmImeetingMain_edit_complete_js.jsp"%>
</template:replace>
<c:if test="${param.approveModel eq 'right'}">
	<template:replace name="barRight">
		<ui:tabpanel layout="sys.ui.tabpanel.vertical.icon" id="barRightPanel">
			<%--流程--%>
			<c:import url="/sys/workflow/import/sysWfProcess_edit.jsp" charEncoding="UTF-8">
				<c:param name="formName" value="kmImeetingMainForm" />
				<c:param name="fdKey" value="ImeetingMain" />
				<c:param name="showHistoryOpers" value="true" />
				<c:param name="isExpand" value="true" />
				<c:param name="approveType" value="right" />
				<c:param name="approvePosition" value="right" />
			</c:import>
		</ui:tabpanel>
	</template:replace>
</c:if>
