<%@ page language="java" contentType="text/json; charset=UTF-8"	pageEncoding="UTF-8"%>
<%@ include file="/sys/ui/jsp/common.jsp"%>
<list:data>
	<list:data-columns var="familyInfo" list="${queryPage.list }" varIndex="status">
		<list:data-column property="fdId">
		</list:data-column>
		<list:data-column col="personInfoId">
			${familyInfo.fdPersonInfo.fdId}
		</list:data-column>
		<list:data-column title="${ lfn:message('page.serial') }" col="index">
		  ${status+1}
		</list:data-column>
		<list:data-column headerClass="width100" col="fdStaffFdName" title="${ lfn:message('hr-staff:hrStaffPerson.family.eployee.name') }">
		    ${familyInfo.fdPersonInfo.fdName}
		</list:data-column>
		<list:data-column headerClass="width100" col="fdRelated" title="${ lfn:message('hr-staff:hrStaffPerson.family.relationship') }">
		    ${familyInfo.getFdRelated()}
		</list:data-column>
		<list:data-column headerClass="width100" col="fdName" title="${ lfn:message('hr-staff:hrStaffPerson.family.related.name') }">
		     ${familyInfo.getFdName()} 
		</list:data-column>
		<list:data-column headerClass="width100" col="fdCompany" title="${ lfn:message('hr-staff:hrStaffPerson.family.company') }">
		    ${familyInfo.getFdCompany()} 
		</list:data-column>
		<list:data-column headerClass="width100" col="fdOccupation" title="${ lfn:message('hr-staff:hrStaffPerson.family.occupation') }">
		    ${familyInfo.getFdOccupation()} 
		</list:data-column>
		<list:data-column headerClass="width100" col="fdMemo" title="${ lfn:message('hr-staff:hrStaffPerson.family.memo') }">
			${familyInfo.getFdMemo()}
		</list:data-column>
		<list:data-column headerClass="width80" col="operations" title="${ lfn:message('list.operation') }" escape="false">
			<!--操作按钮 开始-->
			<div class="conf_show_more_w">
				<div class="conf_btn_edit">
					<!-- 删除 -->
					<a class="btn_txt" href="javascript:_delete('${familyInfo.fdId}')">${ lfn:message('button.delete') }</a>
				</div>
			</div>
			<!--操作按钮 结束-->
		</list:data-column>
	</list:data-columns>
	<list:data-paging currentPage="${queryPage.pageno }" pageSize="${queryPage.rowsize }" totalSize="${queryPage.totalrows }">
	</list:data-paging>
</list:data>