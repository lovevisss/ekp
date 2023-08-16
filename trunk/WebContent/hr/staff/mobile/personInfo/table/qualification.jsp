<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="/sys/ui/jsp/common.jsp"%>
<%@ page import="com.landray.kmss.hr.staff.util.HrStaffPersonUtil"%>
<template:include ref="mobile.view" compatibleMode="true">
	<template:replace name="title">
		<bean:message bundle="hr-staff" key="hrStaffPersonExperience.type.qualification"/>
	</template:replace>
	<template:replace name="head">
  		<link rel="stylesheet" href="<%=request.getContextPath()%>/hr/staff/mobile/resource/css/view.css">
	</template:replace>
	<template:replace name="content">
		<c:set var="canEdit" value="true"></c:set>
		<%
			request.setAttribute("mobileField", true);
		%>
		<div class="file-view-tips"><bean:message bundle="hr-staff" key="mobile.hr.staff.view.7"/></div>
		<form data-dojo-type="mui/view/DocScrollableView" data-dojo-mixins="mui/form/_ValidateMixin" Id="baseInfoForm">
			<input type="hidden" name="fdPersonInfoId" value="${param.personInfoId}" />
			<div class="file-view-content">
			    <div class="ppc_c_list newdate">
	       			<div class="ppc_c_list_head"><bean:message bundle="hr-staff" key="hrStaffPersonExperience.qualification.fdBeginDate"/></div>
	       			<div class="ppc_c_list_body">
	       				<xform:datetime property="fdBeginDate" dateTimeType="date" mobile="true" showStatus="${canEdit?'edit':'view'}" validators="compareDate"></xform:datetime>
	       			</div>
	       		</div>
			    <div class="ppc_c_list newdate">
	       			<div class="ppc_c_list_head"><bean:message bundle="hr-staff" key="hrStaffPersonExperience.qualification.fdEndDate"/></div>
	       			<div class="ppc_c_list_body">
	       				<xform:datetime  property="fdEndDate" dateTimeType="date" mobile="true" showStatus="${canEdit?'edit':'view'}" validators="compareDate"></xform:datetime>
	       			</div>
	       		</div>
			    <div class="ppc_c_list inputstring">
	       			<div class="ppc_c_list_head"><bean:message bundle="hr-staff" key="hrStaffPersonExperience.qualification.fdCertificateName"/></div>
	       			<div class="ppc_c_list_body">
						<xform:text property="fdCertificateName"  required="true"  showStatus="${canEdit?'edit':'view'}"></xform:text>		       			
	       			</div>
	       		</div>
			    <div class="ppc_c_list inputstring">
	       			<div class="ppc_c_list_head"><bean:message bundle="hr-staff" key="hrStaffPersonExperience.qualification.fdAwardUnit"/></div>
	       			<div class="ppc_c_list_body">
	       				<xform:text property="fdAwardUnit" showStatus="${canEdit?'edit':'view'}"></xform:text>
	       			</div>
	       		</div>    			       		       			 	       			       			       		
			</div>
		</form>
       	<c:import url="/hr/staff/mobile/personInfo/table/save.jsp">
       		<c:param name="personInfoId" value="${param.personInfoId}" />
       		<c:param name="canEdit" value="${canEdit }"/>
       		<c:param name="url" value="/hr/staff/hr_staff_person_experience/qualification/hrStaffPersonExperienceQualification.do?method=${hrStaffPersonExperienceQualificationForm.method_GET eq 'add'?'save':'update'}&fdId=${param.fdId }"/>
       	</c:import>
       	<%@ include file="/hr/staff/mobile//personInfo/table/experience_common_add.jsp"%>		
	</template:replace>
</template:include>