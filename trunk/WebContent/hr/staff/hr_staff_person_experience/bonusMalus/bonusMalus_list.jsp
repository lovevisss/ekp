<%@ page language="java" contentType="text/json; charset=UTF-8"	pageEncoding="UTF-8"%>
<%@ include file="/sys/ui/jsp/common.jsp"%>
<list:data>
	<list:data-columns var="bonusMalus" list="${queryPage.list }" varIndex="status">
		<list:data-column property="fdId">
		</list:data-column>
		<list:data-column col="personInfoId">
			${bonusMalus.fdPersonInfo.fdId}
		</list:data-column>
		<list:data-column col="index">
		  ${status+1}
		</list:data-column>
		<!-- 姓名（账号）-->
		<list:data-column col="nameAccount" title="${ lfn:message('hr-staff:hrStaffPersonExperience.nameAccount') }" escape="false">
		    <span class="com_subject">${bonusMalus.fdPersonInfo.nameAccount}</span>
		</list:data-column>
		<!--奖惩名称-->
		<list:data-column headerClass="width160" property="fdBonusMalusName" title="${ lfn:message('hr-staff:hrStaffPersonExperience.bonusMalus.fdBonusMalusName') }"> 
		</list:data-column>
		<list:data-column headerClass="width160" property="fdBonusMalusType" title="${ lfn:message('hr-staff:hrStaffPersonExperience.bonusMalus.fdBonusType') }"> 
		</list:data-column>
		
		
		<!--奖惩日期-->
		<list:data-column headerClass="width100" col="fdBonusMalusDate" title="${ lfn:message('hr-staff:hrStaffPersonExperience.bonusMalus.fdBonusMalusDate') }">
		    <kmss:showDate value="${bonusMalus.fdBonusMalusDate}" type="date" /> 
		</list:data-column>
		<!--备注-->
		<list:data-column headerClass="width120" col="fdMemo" title="${ lfn:message('hr-staff:hrStaffPersonExperience.fdMemo') }" escape="false">
			<span style="width:120px" class="textEllipsis" title="${ lfn:escapeHtml(bonusMalus.fdMemo) }">${ lfn:escapeHtml(bonusMalus.fdMemo) }</span>
		</list:data-column> 
		<!-- 其它操作 -->
		<list:data-column headerClass="width60" col="operations" title="${ lfn:message('list.operation') }" escape="false">
			<!--操作按钮 开始-->
			<div class="conf_show_more_w">
				<div class="conf_btn_edit">
					<!-- 删除 -->
					<a class="btn_txt" href="javascript:_delete('${LUI_ContextPath}/hr/staff/hr_staff_person_experience/bonusMalus/hrStaffPersonExperienceBonusMalus.do?method=deleteall', '${bonusMalus.fdId}')">${ lfn:message('button.delete') }</a>
				</div>
			</div>
			<!--操作按钮 结束-->
		</list:data-column>
	</list:data-columns>
	<list:data-paging currentPage="${queryPage.pageno }" pageSize="${queryPage.rowsize }" totalSize="${queryPage.totalrows }">
	</list:data-paging>
</list:data>