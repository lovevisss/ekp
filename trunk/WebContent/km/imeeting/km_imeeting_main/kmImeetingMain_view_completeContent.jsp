<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/sys/ui/jsp/common.jsp"%>
<ui:content title="详情" expand="true"  cfg-order="1" >
	<div class="lui_form_content_frame" style="padding-top:20px"> 
		<table class="tb_normal" width=100% id="Table_Main">
			<tr>
				<td colspan="4" id="docSubject" style="text-align:center">
					<xform:text property="fdName" style="text-align:center"></xform:text>
					<span id="docSubjectSpan">通知单</span>
				</td>
			</tr>
			<tr>
				<td colspan="4"  class="com_subject">
					<div style="margin-left:0px">
						<span style="margin-right:25px;font-weight: bold;">关联会议方案：</span>
						<a href="${LUI_ContextPath }/km/imeeting/km_imeeting_scheme/kmImeetingScheme.do?method=view&fdId=${kmImeetingMainForm.fdSchemeId}" target="_blank" style="color: #4285f4;">${kmImeetingMainForm.fdSchemeName}</a>
					</div>
				</td>
			</tr>
			<c:if test="${kmImeetingMainForm.fdChangeMeetingFlag eq 'true'}">
				<tr>
					<td class="td_normal_title" width=15%>
						<bean:message bundle="km-imeeting" key="kmImeetingMain.changeMeetingReason"/>
					</td>
					<td colspan="3" width="85%" style="color: red;">
						<xform:textarea property="changeMeetingReason" style="width:95%;color:red;" required="true" 
							showStatus="view" subject="变更事由">
						</xform:textarea>
						<html:hidden property="beforeChangeContent"/>
					</td>
				</tr>
			</c:if>
			<tr>
			<tr >
				<td class="td_normal_title" width="15%">
					<bean:message key="kmImeetingMain.fdMeetingNum" bundle="km-imeeting" />
				</td>
				<td width="35%">
					<xform:text property="fdMeetingNum" showStatus="view" />
				</td>
				<td class="td_normal_title" width="15%">
					<bean:message key="kmImeetingMain.fdDate" bundle="km-imeeting" />
				</td>
				<td width="35%" >
					<xform:datetime property="fdHoldDate" dateTimeType="datetime" showStatus="view" 
						onValueChange="changeDateTime"  required="true" validators="after compareTime"></xform:datetime>
					<span style="position: relative;">~</span>
					<xform:datetime property="fdFinishDate" dateTimeType="datetime" showStatus="view" 
						onValueChange="changeDateTime" required="true" validators="after compareTime"></xform:datetime>
					<%--隐藏域,保存改变前的时间，用于回退--%>
					<input type="hidden" name="fdHoldDateTmp" value="${HtmlParam.kmImeetingMainForm.fdHoldDate}">
					<input type="hidden" name="fdFinishDateTmp" value="${HtmlParam.kmImeetingMainForm.fdFinishDate}">
				</td>
			</tr>
			<tr >
				<td class="td_normal_title" width="15%">
					<bean:message bundle="km-imeeting" key="kmImeetingMain.fdNeedPlace" />
				</td>
				<td width="35%">
					<c:choose>
						<c:when test="${fdNeedMultiRes}">
				 			<xform:dialog propertyId="fdPlaceId" propertyName="fdPlaceName" showStatus="view" validators="validateplace validateUserTime" className="inputsgl" style="width:46%;" 
				 				subject="${lfn:message('km-imeeting:kmImeetingMain.fdMainPlace') }"  htmlElementProperties="placeholder='${lfn:message('km-imeeting:kmImeetingMain.fdMainPlace') }'">
						  	 	selectHoldPlace();
							</xform:dialog>
							<input type="hidden" name="fdPlaceUserTime" value="${ kmImeetingMainForm.fdUserTime}"
									subject="${lfn:message('km-imeeting:kmImeetingMain.fdMainPlace') }"/>
							&nbsp;	&nbsp;
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
									<c:param name="style" value="width:95%;display:block;"></c:param>
								</c:import>
							</c:if>
							<c:if test="${hasSysAttend == false }">
								<xform:text property="fdOtherPlace" style="width:95%;display:block;" validators="validateplace" subject="${lfn:message('km-imeeting:kmImeetingMain.fdPlace') }" htmlElementProperties="placeholder='${lfn:message('km-imeeting:kmImeetingMain.fdOtherMainPlace') }'"></xform:text>
							</c:if>
							<div class="roomDetail" style="display: none;margin: 5px 0;padding: 5px;background-color: #fff5d8;border: 1px solid #e0a385;"></div>
							<br/><br/>
							
				 			<xform:dialog propertyId="fdVicePlaceIds" propertyName="fdVicePlaceNames" showStatus="view" validators="validateViceUserTime"
				 				className="inputsgl" style="width:46%;"  htmlElementProperties="placeholder='${lfn:message('km-imeeting:kmImeetingMain.fdVicePlaces') }'"
				 				subject="${lfn:message('km-imeeting:kmImeetingMain.fdOtherVicePlace') }">
						  	 	selectHoldVicePlace();
							</xform:dialog>
							&nbsp;	&nbsp;
							<c:if test="${hasSysAttend == true }">
								<c:import url="/sys/attend/import/map_tag.jsp" charEncoding="UTF-8">
									<c:param name="propertyName" value="fdOtherVicePlace"></c:param>
									<c:param name="propertyCoordinate" value="fdOtherVicePlaceCoord"></c:param>
									<c:param name="placeholder" value="km-imeeting:kmImeetingMain.fdOtherVicePlace"></c:param>
									<c:param name="subject" value="${ lfn:message('km-imeeting:kmImeetingMain.fdOtherMainPlace')}"></c:param>
									<c:param name="style" value="width:95%;display:block;"></c:param>
								</c:import>
							</c:if>
							<c:if test="${hasSysAttend == false }">
								<xform:text property="fdOtherVicePlace" style="width:46%;" subject="${lfn:message('km-imeeting:kmImeetingMain.fdOtherVicePlace') }"  htmlElementProperties="placeholder='${lfn:message('km-imeeting:kmImeetingMain.fdOtherVicePlace') }'"></xform:text>
							</c:if>
							<input type="hidden" name="fdVicePlaceUserTimes" value="${ kmImeetingMainForm.fdVicePlaceUserTimes}"/>
						</c:when>
						<c:otherwise>
				 			<xform:dialog propertyId="fdPlaceId" propertyName="fdPlaceName" showStatus="view" validators="validateplace validateUserTime"
				 				className="inputsgl" style="width:46%;" 
				 				subject="${lfn:message('km-imeeting:kmImeetingMain.fdPlace') }">
						  	 	selectHoldPlace();
							</xform:dialog>
							<input type="hidden" name="fdPlaceUserTime" value="${ kmImeetingMainForm.fdUserTime}"
									subject="${lfn:message('km-imeeting:kmImeetingMain.fdPlace') }"/>
							&nbsp;	&nbsp;
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
									<c:param name="style" value="width:95%;display:block;"></c:param>
								</c:import>
							</c:if>
							<c:if test="${hasSysAttend == false }">
								<xform:text property="fdOtherPlace" style="width:95%;display:block;" validators="validateplace" subject="${lfn:message('km-imeeting:kmImeetingMain.fdPlace') }" htmlElementProperties="placeholder='${lfn:message('km-imeeting:kmImeetingMain.fdOtherPlace') }'"></xform:text>
							</c:if>
							<div class="roomDetail" style="display: none;margin: 5px 0;padding: 5px;background-color: #fff5d8;border: 1px solid #e0a385;"></div>
						</c:otherwise>
					</c:choose>
				</td>
				<td class="td_normal_title" width="15%">
					报名截止时间
				</td>
				<td width="35%">
					<xform:datetime style="width:90%" property="fdFeedBackDeadline" dateTimeType="datetime" showStatus="view" subject="${lfn:message('km-imeeting:kmImeetingMain.fdFeedBackDeadline')}" required="true" validators="after valDeadline"></xform:datetime>
				</td>
			</tr>
			<tr >
				<td class="td_normal_title" width="15%">
					<bean:message bundle="km-imeeting" key="kmImeetingMain.fdHost"/>
				</td>
				<td width="35%">
					<xform:address propertyName="fdHostName" propertyId="fdHostId" orgType="ORG_TYPE_PERSON" style="width:90%;" ></xform:address>
				</td>
				<td class="td_normal_title" width="15%">
					职务
				</td>
				<td width="35%">
					<%-- <xform:staffingLevel propertyName="fdStaffingLevelName" propertyId="fdStaffingLevelId" style="width:95%;"></xform:staffingLevel> --%>
					<xform:text property="fdPosition" showStatus="view" />
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
					<c:out value="${kmImeetingMainForm.fdCreatorDeptName}"></c:out>
				</td>
			</tr>
			<tr >
				<td class="td_normal_title" width="15%">
					出席会议人员
				</td>
				<td width="85%" colspan="3" >
					<xform:address  style="width:90%;" textarea="true" showStatus="view"  propertyId="fdAttendPersonIds" propertyName="fdAttendPersonNames" 
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
					<xform:address  style="width:90%;" textarea="true" showStatus="view"  propertyId="fdInvitePersonIds" propertyName="fdInvitePersonNames" 
								orgType="ORG_TYPE_ALL" mulSelect="true" subject="${lfn:message('km-imeeting:kmImeetingMain.fdInvitePersons') }">
					</xform:address>
				</td>
			</tr>
			<tr >
				<td class="td_normal_title" width="15%">
					列席会议人员
				</td>
				<td width="85%" colspan="3">
					<xform:address style="width:90%;" textarea="true" showStatus="view"  propertyId="fdParticipantPersonIds" propertyName="fdParticipantPersonNames" orgType="ORG_TYPE_ALL" mulSelect="true"></xform:address>
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
					<xform:address style="width:90%" showStatus="view"  propertyId="fdAssistPersonIds" propertyName="fdAssistPersonNames" orgType="ORG_TYPE_ALL" mulSelect="true"></xform:address>
				</td>
			</tr>
			<tr>
				<td class="td_normal_title" width="15%">
					<!-- 工作安排 -->
					<bean:message key="kmimeetingmain.workArrangement" bundle="km-imeeting" />
				</td>
				<td colspan="3" width="85%">
					<xform:textarea property="workArrangement" showStatus="view"></xform:textarea>
				</td>
			</tr>
		</table>
		
		<div class="lui_form_content_frame" style="margin-top:15px">
			<table class="tb_normal" width=100% id="Table_Main"> 
				<tr>
					<td colspan="4" class="com_subject" style="font-size: 110%;font-weight: bold;">
						<bean:message bundle="km-imeeting" key="kmImeetingMain.createStep.base.agenda"/>
					</td>
				</tr>
				<tr>
					<%--会议议题信息--%>
					<td colspan="4">
						<html:hidden property="fdIsTopic" value="1"/>
						<c:set var="isOnMainPage" value="true"></c:set>
						<%@include file="/km/imeeting/km_imeeting_agenda/kmImeetingAgenda_viewTopic.jsp"%>
					</td>
				</tr>
			</table>
		</div>
		
		<!-- 出席单位 -->
		<%@include file="/km/imeeting/import/kmImeeting_attendUnit.jsp"%>
		
		<div class="lui_form_content_frame">
			<table class="tb_normal" width=100% id="Table_Main"> 
				<tr>
					<td colspan="4" class="com_subject" style="font-size: 110%;font-weight: bold;">
						<c:out value="会议辅助资源"></c:out>
					</td>
				</tr>
				<tr>
			 		<%--会议室辅助设备--%>
			 		<td class="td_normal_title" width=15% title="${lfn:message('km-imeeting:kmImeetingMain.kmImeetingEquipment.tip') }">
			 			<bean:message bundle="km-imeeting" key="kmImeetingMain.kmImeetingEquipment"/>
			 		</td>
			 		<td width="85%"  colspan="3">
			 			 <input type="hidden" name="kmImeetingEquipmentIds" value="${kmImeetingMainForm.kmImeetingEquipmentIds}"/>
			 			<c:out value="${kmImeetingMainForm.kmImeetingEquipmentNames}"></c:out>
					</td>
			 	</tr>
			 	<tr>
			 		<%--会议室辅助服务--%>
			 		<td class="td_normal_title" width=15% title="${lfn:message('km-imeeting:kmImeetingMain.kmImeetingDevices.tip') }">
			 			<bean:message bundle="km-imeeting" key="kmImeetingMain.kmImeetingDevices"/>
			 		</td>
			 		<td width="85%"  colspan="3" class="meeting-device-style">
			 			<c:out value="${kmImeetingMainForm.kmImeetingDeviceNames}"></c:out>
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
					</td>
				</tr>
			</table>
		</div>
		
		<%-- 会议历史操作信息 --%>
		<div style="display: none;">
			<c:forEach items="${kmImeetingMainForm.kmImeetingMainHistoryForms}"  var="kmImeetingMainHistoryItem" varStatus="vstatus">
				<input type="hidden" name="kmImeetingMainHistoryForms[${vstatus.index}].fdId" value="${kmImeetingMainHistoryItem.fdId}" /> 
			</c:forEach>
		</div>
		
		<!-- 变更记录 -->
		<div class="lui_form_content_frame">
			<ui:dataview>
				<ui:source type="AjaxJson">
					{url:'/km/imeeting/km_imeeting_main_history/kmImeetingMainHistory.do?method=getChangeHistorysByMeeting&meetingId=${JsParam.fdId }'}
				</ui:source>
				<ui:render type="Template">
					<c:import url="/km/imeeting/resource/tmpl/changeHistory.jsp" charEncoding="UTF-8"></c:import>
				</ui:render>
			</ui:dataview>
		</div>
		
		<c:if test="${kmImeetingMainForm.docStatus eq '30' && param.isCanLookFeedback eq 'true'}">
			<div class="lui_form_content_frame">
				<div class="feedbackBody">
					<div class="feedbackHead">
						<span class="imeetingFeedbakTitle">
							参会回执
						</span>
						<div class="feedbackBtns">
							<kmss:authShow roles="ROLE_KMIMEETING_FEEDBACK_TRANSPORT_EXPORT">
								<a class="feedbackBtn exportFeedbacks">
									导出
								</a>
							</kmss:authShow>
							<a class="feedbackBtn feedbackSelected" id="doneBtn">
								已回执
							</a>
							<a class="feedbackBtn" id="todoBtn">
								未回执
							</a>
						</div>
						
						<div class="kmImeetingFeedbackBorder"></div>
						<div style="margin-top:12px;width: 100%">
							<list:listview id="listViewFeedback">
								<ui:source type="AjaxJson">
									{url:'/km/imeeting/km_imeeting_main_feedback/kmImeetingMainFeedback.do?method=listShow&meetingId=${kmImeetingMainForm.fdId}&feedbackStatus=06&type=docCreateTime&sort=desc'}
								</ui:source>
								<list:colTable isDefault="false"  name="columntable">
									<list:col-auto props="" />
								</list:colTable>
							</list:listview>
							<list:paging></list:paging>
						</div>
					</div>
				</div>
			</div>
		</c:if>
	</div>
</ui:content>