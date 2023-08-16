<%@ page language="java" pageEncoding="UTF-8"%>
<%@ page import="com.landray.kmss.hr.staff.util.HrStaffPersonUtil"%>
<%@ include file="/sys/ui/jsp/common.jsp"%>
<%@ page import="com.landray.kmss.hr.staff.util.HrStaffPersonUtil,
				com.landray.kmss.hr.organization.model.HrOrganizationSyncSetting"%>
<%
	HrOrganizationSyncSetting syncSetting = new HrOrganizationSyncSetting();
	request.setAttribute("hrToEkpEnable", syncSetting.getHrToEkpEnable());
%>

<template:include ref="default.dialog">
	<template:replace name="head">
		<script type="text/javascript">
			Com_IncludeFile("validation.jsp|validation.js|plugin.js|eventbus.js|xform.js", null, "js");
		</script>
	</template:replace>
	<template:replace name="content">
		<center>
		<html:form action="/hr/staff/hr_staff_person_track_record/hrStaffTrackRecord.do?method=save" >
			<input type="hidden" name="fdPersonInfoId" value="${param.fdPersonInfoId}" />
			<table class="tb_normal" style="margin: 20px 0" width=98%>
				<tr>
					<td width="15%" class="td_normal_title">
						${lfn:message('hr-staff:hrStaffTrackRecord.startTime')}
					</td>
					<td width="35%" >
						<xform:datetime required="true" dateTimeType="date" showStatus="true" property="fdEntranceBeginDate" style="width:98%;" validators="compareEntranceDate"></xform:datetime>
					</td>
					<td width="15%" class="td_normal_title">
						${lfn:message('hr-staff:hrStaffTrackRecord.finishTime')}
					</td>
					<td width="35%">
						<xform:datetime required="true"  dateTimeType="date" showStatus="true" property="fdEntranceEndDate" style="width:98%;" validators="compareEntranceDate"></xform:datetime>
					</td>
				</tr>
				<tr>
					<td width="15%" class="td_normal_title">
						${lfn:message('hr-staff:hrStaffPersonInfo.fdStaffingLevel')}
					</td>
					<td width="35%">
						<xform:staffingLevel showStatus="true" propertyName="fdStaffingLevelName" propertyId="fdStaffingLevelId" style="width:98%;"></xform:staffingLevel>
					</td>
					<td width="15%" class="td_normal_title">
						${lfn:message('hr-staff:mobile.hr.staff.list.5')}
					</td>
					<td width="35%">
						<c:choose>
							<c:when test="${hrToEkpEnable == true }">
								<xform:address isHrAddress="true" required="true" orgType="ORG_TYPE_DEPT" showStatus="true"  propertyName="fdHrOrgDeptName" propertyId="fdHrOrgDeptId" style="width:98%;"></xform:address>
							</c:when>
							<c:otherwise>
								<xform:address required="true" orgType="ORG_TYPE_DEPT" showStatus="true"  propertyName="fdRatifyDeptName" propertyId="fdRatifyDeptId" style="width:98%;"></xform:address>
							</c:otherwise>
						</c:choose>
					</td>
				</tr>
				<tr>
					<td width="15%" class="td_normal_title">
						${lfn:message('hr-staff:mobile.hr.staff.list.4')}
					</td>
					<td width="35%" colspan="3">
						<c:choose>
							<c:when test="${hrToEkpEnable == true }">
								<xform:address isHrAddress="true"  required="true"  showStatus="true" orgType="ORG_TYPE_POST"  propertyName="fdHrOrgPostName" propertyId="fdHrOrgPostId" style="width:99%;"></xform:address>
							</c:when>
							<c:otherwise>
								<xform:address required="true"  showStatus="true" orgType="ORG_TYPE_POST"  propertyName="fdOrgPostsNames" propertyId="fdOrgPostsIds" style="width:99%;"></xform:address>
							</c:otherwise>
						</c:choose>
					</td>
				</tr>
				<tr>
					<td width="15%" class="td_normal_title">
						${lfn:message('hr-staff:hrStaffPersonExperience.fdMemo')}
					</td>
					<td colspan="3">
						<xform:textarea showStatus="true" property="fdMemo" style="width:98%;height:50px;"/>
					</td>
				</tr>
			</table>
		</html:form>
		<%@ include file="/hr/staff/hr_staff_person_experience/experience_common_add.jsp"%>
		</center>
	</template:replace>
</template:include>