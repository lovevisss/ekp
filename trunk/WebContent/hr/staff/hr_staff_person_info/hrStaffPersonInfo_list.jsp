<%@ page language="java" contentType="text/json; charset=UTF-8"	pageEncoding="UTF-8"%>
<%@ include file="/sys/ui/jsp/common.jsp"%>
<%@ page import="com.landray.kmss.hr.staff.util.HrStaffPersonUtil,
				com.landray.kmss.hr.organization.model.HrOrganizationSyncSetting"%>
<%
	HrOrganizationSyncSetting syncSetting = new HrOrganizationSyncSetting();
	request.setAttribute("hrToEkpEnable", syncSetting.getHrToEkpEnable());
%>

<list:data>
	<list:data-columns var="hrStaffPersonInfo" list="${queryPage.list }" varIndex="status">
		<list:data-column property="fdId">
		</list:data-column>
		<list:data-column col="fdIsAvailable">
			${hrStaffPersonInfo.fdOrgPerson.fdIsAvailable}
		</list:data-column>
		<list:data-column col="imgUrl">
			${urlJson[hrStaffPersonInfo.fdId]}
		</list:data-column>
		<list:data-column col="index" headerClass="width20">
		  ${status+1}
		</list:data-column>
		<!-- 姓名-->
		<list:data-column headerClass="width160" col="fdName" title="${ lfn:message('hr-staff:hrStaffPersonInfo.fdName') }" escape="false">
			<span class="com_subject"><c:out value="${hrStaffPersonInfo.fdName}" /></span>
		</list:data-column>
		<!-- 性别-->
		<list:data-column headerClass="width100"  col="fdSex" title="${ lfn:message('hr-staff:hrStaffPersonInfo.fdSex') }" escape="false">
			<c:choose>
				<c:when test="${param.IsHrOrg }">
			      	<sunbor:enumsShow value="${hrStaffPersonInfo.fdSex}" enumsType="sys_org_person_sex" />
			    </c:when>
			    <c:otherwise>
			       <c:out value="${hrStaffPersonInfo.fdSex}" />
			    </c:otherwise>
			</c:choose>
		</list:data-column>
		
		<!-- 工作时间 -->
		<list:data-column  col="fdWorkingYears" title="${ lfn:message('hr-staff:hrStaffPersonInfo.fdWorkingYears') }" escape="false">
			<c:out value="${hrStaffPersonInfo.fdWorkingYears}" />
		</list:data-column>
		<list:data-column col="personInfoName" title="${ lfn:message('hr-staff:hrStaffPersonInfo.fdName') }">
			<c:out value="${hrStaffPersonInfo.fdName}" />
		</list:data-column>
		<!--系统账号-->
		<list:data-column headerClass="width80" col="fdLoginName" title="${ lfn:message('hr-staff:hrStaffPersonInfo.fdLoginName') }"> 
		     <c:if test="${hrStaffPersonInfo.fdOrgPerson != null}">
	    		${hrStaffPersonInfo.fdOrgPerson.fdLoginName}
	    	</c:if>
	    	  <c:if test="${hrStaffPersonInfo.fdOrgPerson == null}">
	    		${hrStaffPersonInfo.fdLoginName}
	    	</c:if>
		</list:data-column>
		<!--到本单位时间-->
		<list:data-column headerClass="width100" col="fdTimeOfEnterprise" title="${ lfn:message('hr-staff:hrStaffPersonInfo.fdTimeOfEnterprise') }">
		    <kmss:showDate value="${hrStaffPersonInfo.fdTimeOfEnterprise}" type="date" /> 
		</list:data-column>
		<!--部门-->
		<list:data-column headerClass="width200" col="fdDeptName" title="${ lfn:message('hr-staff:hrStaffPersonInfo.fdOrgParent') }">
			<c:choose>
				<c:when test="${hrToEkpEnable == true }">
					<c:if test="${not empty hrStaffPersonInfo.fdParent}">
						${hrStaffPersonInfo.fdParent.fdName}
					</c:if>
				</c:when>
				<c:otherwise>
						${hrStaffPersonInfo.fdParent.fdName}
					<c:if test="${empty hrStaffPersonInfo.fdOrgParentsName}">
						${hrStaffPersonInfo.fdOrgParentDeptName}
					</c:if>
				</c:otherwise>
			</c:choose>
		</list:data-column>
		<!--工号-->
		<list:data-column headerClass="width100" property="fdStaffNo" title="${ lfn:message('hr-staff:hrStaffPersonInfo.fdStaffNo') }">
		</list:data-column>
		<!--员工状态-->
		<list:data-column headerClass="width100" col="fdStatus" title="${ lfn:message('hr-staff:hrStaffPersonInfo.fdStatus') }">
			<sunbor:enumsShow value="${ hrStaffPersonInfo.fdStatus }" enumsType="hrStaffPersonInfo_fdStatus" />
		</list:data-column>
		<!-- 其它操作 -->
		<list:data-column headerClass="width100" col="operations" title="${ lfn:message('list.operation') }" escape="false">
			<!--操作按钮 开始-->
			<div class="conf_show_more_w">
				<div class="conf_btn_edit">
					<kmss:authShow roles="ROLE_HRSTAFF_EDIT">
					<!-- 编辑 -->
					<a class="btn_txt" href="javascript:edit('${hrStaffPersonInfo.fdId}')">${lfn:message('button.edit')}</a>
					</kmss:authShow>
					<kmss:authShow roles="ROLE_HRSTAFF_DELETE">
					<!-- 删除 -->
					<a class="btn_txt" href="javascript:del('${hrStaffPersonInfo.fdId}')">${ lfn:message('button.delete') }</a>
			    	</kmss:authShow>
				</div>
			</div>
			<!--操作按钮 结束-->
		</list:data-column>
		<list:data-column headerClass="width100" col="hrOperations" title="${ lfn:message('list.operation') }" escape="false">
			<!--操作按钮 开始-->
			<div class="conf_show_more_w">
				<div class="conf_btn_edit">
					<a class="btn_txt" href="javascript:viewInfo('${hrStaffPersonInfo.fdId}')">详情</a>
				</div>
			</div>
			<!--操作按钮 结束-->
		</list:data-column>		
		<!--门户补充  start-->
		<!--岗位-->
		<list:data-column headerClass="width200" col="fdOrgPostNames" title="${ lfn:message('hr-staff:hrStaffPersonInfo.fdOrgPosts') }">
			<c:forEach items="${ hrStaffPersonInfo.fdOrgPosts }" varStatus="vstatus" var = "post">
			${post.fdName};
			</c:forEach>
		</list:data-column>
		<!--岗位fdPosts-->
		<list:data-column headerClass="width200" col="fdPosts" title="${ lfn:message('hr-staff:hrStaffPersonInfo.fdOrgPosts') }">
			<c:forEach items="${ hrStaffPersonInfo.fdPosts }" varStatus="vstatus" var = "post">
				${post.fdName};
			</c:forEach>
		</list:data-column>
		<!--入职时间-->
		<list:data-column headerClass="width100" col="fdEntryTime" title="${ lfn:message('hr-staff:hrStaffPersonInfo.fdEntryTime') }">
		    <kmss:showDate value="${hrStaffPersonInfo.fdEntryTime}" type="date" /> 
		</list:data-column>
		<!--转正时间-->
		<list:data-column headerClass="width100" col="fdPositiveTime" title="${ lfn:message('hr-staff:hrStaffPersonInfo.fdPositiveTime') }">
		    <kmss:showDate value="${hrStaffPersonInfo.fdPositiveTime}" type="date" /> 
		</list:data-column>
		<!--出生时间-->
		<list:data-column headerClass="width100" col="fdDateOfBirth" title="${ lfn:message('hr-staff:hrStaffPersonInfo.fdDateOfBirth') }">
		    <kmss:showDate value="${hrStaffPersonInfo.fdDateOfBirth}" type="date" /> 
		</list:data-column>
		<list:data-column headerClass="width100" col="fdOrder" title="排序号">
		   ${hrStaffPersonInfo.fdOrder}
		</list:data-column>
		<list:data-column headerClass="width100" col="fdReportLeaderName" title="汇报上级">
		   ${hrStaffPersonInfo.fdReportLeader.fdName}
		</list:data-column>					
	</list:data-columns>
	<list:data-paging currentPage="${queryPage.pageno }" pageSize="${queryPage.rowsize }" totalSize="${queryPage.totalrows }">
	</list:data-paging>
</list:data>