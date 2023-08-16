<%@ page language="java" contentType="text/json; charset=UTF-8"	pageEncoding="UTF-8"%>
<%@ include file="/sys/ui/jsp/common.jsp"%>
<list:data>
	<list:data-columns var="education" list="${queryPage.list }" varIndex="status">
		<list:data-column property="fdId">
		</list:data-column>
		<list:data-column col="personInfoId">
			${education.fdPersonInfo.fdId}
		</list:data-column>
		<list:data-column col="index">
		  ${status+1}
		</list:data-column>
		<!-- 姓名（账号）-->
		<list:data-column headerClass="width100" col="nameAccount" title="${ lfn:message('hr-staff:hrStaffPersonExperience.nameAccount') }" escape="false">
		    <span class="com_subject">${education.fdPersonInfo.nameAccount}</span>
		</list:data-column>
		<!--学校名称-->
		<list:data-column headerClass="width120" property="fdSchoolName" title="${ lfn:message('hr-staff:hrStaffPersonExperience.education.fdSchoolName') }"> 
		</list:data-column>
		<!--专业-->
		<list:data-column headerClass="width120" property="fdMajor" title="${ lfn:message('hr-staff:hrStaffPersonExperience.education.fdMajor') }"> 
		</list:data-column>
		<!--学历--> 
		<list:data-column headerClass="width100" property="fdEducation" title="${ lfn:message('hr-staff:hr.staff.tree.education') }"> 
		</list:data-column>
		<!--学位-->
		<list:data-column headerClass="width100" property="fdDegree" title="${ lfn:message('hr-staff:hrStaffPersonExperience.education.fdDegree') }"> 
		</list:data-column>
		<!--入学时间-->
		<list:data-column headerClass="width100" col="fdBeginDate" title="${ lfn:message('hr-staff:hrStaffPersonExperience.education.fdBeginDate') }">
		    <kmss:showDate value="${education.fdBeginDate}" type="date" /> 
		</list:data-column>
		<!--毕业时间-->
		<list:data-column headerClass="width100" col="fdEndDate" title="${ lfn:message('hr-staff:hrStaffPersonExperience.education.fdEndDate') }">
			<kmss:showDate value="${education.fdEndDate}" type="date" /> 
		</list:data-column> 
		<!--备注-->
		<list:data-column headerClass="width100" col="fdMemo" title="${ lfn:message('hr-staff:hrStaffPersonExperience.fdMemo') }" escape="false">
			<span style="width:120px" class="textEllipsis" title="${ lfn:escapeHtml(education.fdMemo) }">${ lfn:escapeHtml(education.fdMemo) }</span>
		</list:data-column> 
		<!-- 其它操作 -->
		<list:data-column headerClass="width100" col="operations" title="${ lfn:message('list.operation') }" escape="false">
			<!--操作按钮 开始-->
			<div class="conf_show_more_w">
				<div class="conf_btn_edit">
					<!-- 删除 -->
					<a class="btn_txt" href="javascript:_delete('${LUI_ContextPath}/hr/staff/hr_staff_person_experience/education/hrStaffPersonExperienceEducation.do?method=deleteall', '${education.fdId}')">${ lfn:message('button.delete') }</a>
				</div>
			</div>
			<!--操作按钮 结束-->
		</list:data-column>
	</list:data-columns>
	<list:data-paging currentPage="${queryPage.pageno }" pageSize="${queryPage.rowsize }" totalSize="${queryPage.totalrows }">
	</list:data-paging>
</list:data>