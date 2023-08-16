<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<%@ include file="/resource/jsp/common.jsp"%>
<%@page import="java.util.Date"%>
<%@page import="com.landray.kmss.util.DateUtil"%>
<%@page import="com.landray.kmss.km.imeeting.forms.KmImeetingMainForm"%>
<%@page import="com.landray.kmss.sys.authorization.constant.ISysAuthConstant"%>
<%@page import="com.landray.kmss.km.imeeting.util.KmImeetingConfigUtil"%>
<%@page import="com.landray.kmss.km.imeeting.util.KKUtil"%>
<%--管理员、会议审批人员看到的会议通知单详情--%>
<div style="float: right;margin:10px;">
	<span style="margin-right: 10px;">
		<bean:message bundle="km-imeeting" key="kmImeetingMain.fdMeetingNum"/>：
		<c:out value="${kmImeetingMainForm.fdMeetingNum}"></c:out>
		<c:if test="${empty  kmImeetingMainForm.fdMeetingNum}">
			<bean:message bundle="km-imeeting" key="kmImeetingMain.createStep.base.fdMeetingNum.tip"/>
		</c:if>
	</span>
	<span>
		<bean:message bundle="km-imeeting" key="kmImeetingMain.docStatus"/>：
		<c:if test="${kmImeetingMainForm.docStatus!='30' && kmImeetingMainForm.docStatus!='41' }">
			<sunbor:enumsShow value="${kmImeetingMainForm.docStatus}" enumsType="kmImeeting_common_status" />
		</c:if>
		<%--未召开--%>
		<c:if test="${kmImeetingMainForm.docStatus=='30' && isBegin==false }">
			<bean:message bundle="km-imeeting" key="kmImeeting.status.publish.unHold"/>
		</c:if>
		<%--正在召开--%>
		<c:if test="${kmImeetingMainForm.docStatus=='30' && isBegin==true && isEnd==false }">
			<bean:message bundle="km-imeeting" key="kmImeeting.status.publish.holding"/>
		</c:if>
		<%--已召开--%>
		<c:if test="${kmImeetingMainForm.docStatus=='30' && isEnd==true }">
			<bean:message bundle="km-imeeting" key="kmImeeting.status.publish.hold"/>
		</c:if>
		<%--已取消--%>
		<c:if test="${kmImeetingMainForm.docStatus=='41' }">
			<bean:message bundle="km-imeeting" key="kmImeeting.status.cancel"/>
		</c:if>
	</span>
</div>

<div class="lui_form_content_frame" style="padding-top:20px"> 
	<table class="tb_normal" width=100% id="Table_Main">
		<tr>
			<td colspan="4" id="docSubject" style="text-align:center">
				<xform:text property="fdName" style="text-align:center"></xform:text>
				<span id="docSubjectSpan">通知单</span>
			</td>
		</tr>
		<tr>
			<td colspan="4">
				<div style="margin-left:0px">
					<span style="margin-right:25px;font-weight: bold;">关联会议方案：</span>
					<xform:dialog propertyName="fdSchemeName" propertyId="fdSchemeId" showStatus="view">
						dialogSelect(false,'km_imeeting_findScheme','fdMeetingId','fdMeetingName');
					</xform:dialog>
				</div>
			</td>
		</tr>
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
				<span style="position: relative;top:-5px;">~</span>
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
								<c:param name="style" value="width:46%;"></c:param>
							</c:import>
						</c:if>
						<c:if test="${hasSysAttend == false }">
							<xform:text property="fdOtherPlace" style="width:46%;" validators="validateplace" subject="${lfn:message('km-imeeting:kmImeetingMain.fdPlace') }" htmlElementProperties="placeholder='${lfn:message('km-imeeting:kmImeetingMain.fdOtherMainPlace') }'"></xform:text>
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
								<c:param name="style" value="width:46%;"></c:param>
							</c:import>
						</c:if>
						<c:if test="${hasSysAttend == false }">
							<xform:text property="fdOtherVicePlace" style="width:46%;" showStatus="view" subject="${lfn:message('km-imeeting:kmImeetingMain.fdOtherVicePlace') }"  htmlElementProperties="placeholder='${lfn:message('km-imeeting:kmImeetingMain.fdOtherVicePlace') }'"></xform:text>
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
								<c:param name="style" value="width:46%;"></c:param>
							</c:import>
						</c:if>
						<c:if test="${hasSysAttend == false }">
							<xform:text property="fdOtherPlace" style="width:46%;" showStatus="view" validators="validateplace" subject="${lfn:message('km-imeeting:kmImeetingMain.fdPlace') }" htmlElementProperties="placeholder='${lfn:message('km-imeeting:kmImeetingMain.fdOtherPlace') }'"></xform:text>
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
				<xform:address propertyName="fdHostName" propertyId="fdHostId" orgType="ORG_TYPE_PERSON" style="width:90%;" showStatus="view" ></xform:address>
			</td>
			<td class="td_normal_title" width="15%">
				职务
			</td>
			<td width="35%">
				<%-- <xform:staffingLevel propertyName="fdStaffingLevelName" propertyId="fdStaffingLevelId" style="width:95%;"></xform:staffingLevel> --%>
				<xform:text property="fdPosition" showStatus="view" />
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
			<td width="85%" colspan="3">
				<xform:address style="width:90%;"   propertyId="fdSummaryInputPersonId" propertyName="fdSummaryInputPersonName" 
							orgType="ORG_TYPE_PERSON" validators="validateSummaryInputPerson" showStatus="view">
				</xform:address>
			</td>
		</tr>
	</table>
			
</div> 
