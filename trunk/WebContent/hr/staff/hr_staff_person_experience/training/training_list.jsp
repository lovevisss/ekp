<%@ page language="java" contentType="text/json; charset=UTF-8"	pageEncoding="UTF-8"%>
<%@ include file="/sys/ui/jsp/common.jsp"%>
<list:data>
	<list:data-columns var="training" list="${queryPage.list }" varIndex="status">
		<list:data-column property="fdId">
		</list:data-column>
		<list:data-column col="personInfoId">
			${training.fdPersonInfo.fdId}
		</list:data-column>
		<list:data-column col="index">
		  ${status+1}
		</list:data-column>
		<!-- 姓名（账号）-->
		<list:data-column col="nameAccount" title="${ lfn:message('hr-staff:hrStaffPersonExperience.nameAccount') }" escape="false">
		    <span class="com_subject"> ${training.fdPersonInfo.nameAccount}</span>
		</list:data-column>
		<!--培训名称-->
		<list:data-column headerClass="width120" property="fdTrainingName" title="${ lfn:message('hr-staff:hrStaffPersonExperience.training.fdTrainingName') }"> 
		</list:data-column>
		<!--开始日期-->
		<list:data-column headerClass="width80" col="fdBeginDate" title="${ lfn:message('hr-staff:hrStaffPersonExperience.fdBeginDate') }">
		    <kmss:showDate value="${training.fdBeginDate}" type="date" /> 
		</list:data-column>
		<!--结束日期-->
		<list:data-column headerClass="width80" col="fdEndDate" title="${ lfn:message('hr-staff:hrStaffPersonExperience.fdEndDate') }">
			<kmss:showDate value="${training.fdEndDate}" type="date" /> 
		</list:data-column> 
		<!--培训单位-->
		<list:data-column headerClass="width120" property="fdTrainingUnit" title="${ lfn:message('hr-staff:hrStaffPersonExperience.training.fdTrainingUnit') }"> 
		</list:data-column>
		<!--备注-->
		<list:data-column headerClass="width80" col="fdMemo" title="${ lfn:message('hr-staff:hrStaffPersonExperience.fdMemo') }" escape="false">
			<span style="width:130px" class="textEllipsis" title="${ lfn:escapeHtml(training.fdMemo) }">${ lfn:escapeHtml(training.fdMemo) }</span>
		</list:data-column> 
		<!-- 其它操作 -->
		<list:data-column headerClass="width60" col="operations" title="${ lfn:message('list.operation') }" escape="false">
			<!--操作按钮 开始-->
			<div class="conf_show_more_w">
				<div class="conf_btn_edit">
					<!-- 删除 -->
					<a class="btn_txt" href="javascript:_delete('${LUI_ContextPath}/hr/staff/hr_staff_person_experience/training/hrStaffPersonExperienceTraining.do?method=deleteall', '${training.fdId}')">${ lfn:message('button.delete') }</a>
				</div>
			</div>
			<!--操作按钮 结束-->
		</list:data-column>
	</list:data-columns>
	<list:data-paging currentPage="${queryPage.pageno }" pageSize="${queryPage.rowsize }" totalSize="${queryPage.totalrows }">
	</list:data-paging>
</list:data>