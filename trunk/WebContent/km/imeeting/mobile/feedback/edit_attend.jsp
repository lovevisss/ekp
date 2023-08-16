<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/resource/jsp/common.jsp"%>
<c:set var="editStatus" value="view" ></c:set>
<c:if test="${empty kmImeetingMainFeedbackForm.fdOperateType && isFeedBackDeadline eq false}">
	<c:set var="editStatus" value="edit" ></c:set>
</c:if>
<table class="muiSimple" cellpadding="0" cellspacing="0">
	<tr>
		<td class="muiTitle">
			参会人
		</td>
		<td>
			<xform:address propertyName="docAttendName" propertyId="docAttendId" orgType="ORG_TYPE_PERSON" showStatus="readOnly" mobile="true" htmlElementProperties="class='docAttendBox'"/>
		</td>
	</tr>
	<tr>
		<td class="muiTitle">
			职务
		</td>
		<td>
			<div class="meetingRightBox">
				<span id="fdStaffingLevelIdSpan"></span>
			</div>
			<input name="fdStaffingLevelId" type="hidden">
		</td>
	</tr>
	<tr>
		<td class="muiTitle">
			手机号码
		</td>
		<td>
			<xform:text property="fdMobileNo" style="width:98%" validators="phoneNumber"  showStatus="${editStatus}" required="true" mobile="true"/>
		</td>
	</tr>
	<tr>
		<td class="muiTitle">
			回执结果
		</td>
		<td>
			<xform:select property="fdOperateType" showPleaseSelect="false" showStatus="${editStatus}" mobile="true" required="true">
				<xform:enumsDataSource enumsType="km_imeeting_main_feedback_fd_operate_type" />
			</xform:select>
		</td>
	</tr>
	<tr>
		<td class="muiTitle">
			回执备注
		</td>
		<td>
			<xform:textarea property="fdReason" style="width:98%" showStatus="${editStatus}" mobile="true" subject="回执备注" htmlElementProperties="class='fdReasonBox'" />
		</td>
	</tr>
	<tr>
		<td class="muiTitle">
			请假附件
		</td>
		<td>
			<c:choose>
				<c:when test="${editStatus eq 'edit'}">
					<c:import url="/sys/attachment/mobile/import/edit.jsp" charEncoding="UTF-8">
						<c:param name="fdKey" value="fdAttKey" />
		                <c:param name="formName" value="kmImeetingMainFeedbackForm"/>
		                <c:param name="fdAttType" value="byte" />
						<c:param name="fdMulti" value="true" />
					</c:import>
				</c:when>
				<c:otherwise>
					<c:import url="/sys/attachment/mobile/import/view.jsp" charEncoding="UTF-8">
						<c:param name="fdKey" value="fdAttKey" />
		                <c:param name="formName" value="kmImeetingMainFeedbackForm"/>
		                <c:param name="fdAttType" value="byte" />
						<c:param name="fdMulti" value="true" />
					</c:import>
				</c:otherwise>
			</c:choose>
		</td>
	</tr>
</table>
<script type="text/javascript">
	require(['dojo/ready', 'dojo/request', 'mui/util', 'dojo/query'], 
			function(ready, request, util, query){
		
		ready(function() {
			var docCreatorId = "${kmImeetingMainFeedbackForm.docCreatorId}";
			if (docCreatorId) {
				request(util.formatUrl("/km/imeeting/km_imeeting_main_feedback/kmImeetingMainFeedback.do?method=getPostInfo"), {
					method : 'post', // dojo这里命名为method好奇怪
					data : {
						"attendId" : docCreatorId
					}
				}).then(function(data) {
					dataJson = eval('(' + data + ')');
					if(dataJson.fdId && dataJson.fdName) {
						query("[name='fdStaffingLevelId']").val(dataJson.fdId);
						query("#fdStaffingLevelIdSpan").text(dataJson.fdName);
					}
				});
			}
		});
		
	 });
</script>