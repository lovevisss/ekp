<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="/sys/ui/jsp/common.jsp"%>

      <div class="lui-personnel-file-staffInfo" id="dutyInfo">
      	<c:choose>
      	<c:when test="${param.print==null }">
           <div class="lui-personnel-file-header-title">
              <div class="lui-personnel-file-header-title-left">
                <div class="lui-personnel-file-header-title-text"><bean:message key="mobile.hr.staff.view.4" bundle="hr-staff"/></div>
              </div>
              <kmss:authShow roles="ROLE_HRSTAFF_EDIT">
				  <c:if test="${!readOnly}">
	              <div class="lui-personnel-file-edit">
	                <span class="lui-personnel-file-edit-icon"></span>
	                <span class="lui-personnel-file-edit-text">${lfn:message('button.edit')}</span>
	              </div>
				  </c:if>
              </kmss:authShow>
            </div>
        </c:when>
        <c:otherwise>
	 		<div class="tr_label_title">
				<div class="title"><bean:message key="mobile.hr.staff.view.4" bundle="hr-staff"/></div>
			</div>
		</c:otherwise>
	   </c:choose>
	   <div class="lui-split-line"></div>
            <table>
                <tbody>
                    <tr>
                    	<td width="160"><bean:message key="hrStaffPersonInfo.fdStaffNo" bundle="hr-staff"/></td><td width="300">${hrStaffPersonInfoForm.fdStaffNo}</td>
                    	<td width="160"><bean:message key="hrStaffPersonInfo.fdOrgParentOrg" bundle="hr-staff"/></td><td width="300">
                    		${hrStaffPersonInfoForm.fdOrgParentOrgName}
                    	</td>
                    	
                    </tr>
                    <tr>
                    	<td><bean:message key="hrStaffPersonInfo.fdOrgParent" bundle="hr-staff"/></td>
                    	<td>
                    		<c:choose>
								<c:when test="${hrToEkpEnable == true }">
									${hrStaffPersonInfoForm.fdParentName}
								</c:when>
								<c:otherwise>
									${hrStaffPersonInfoForm.fdOrgParentName}
								</c:otherwise>
							</c:choose>
						</td>
						<!-- 汇报上级 -->
                    	<td><bean:message key="hrStaffPersonInfo.fdReportLeader" bundle="hr-staff"/></td>
                    	<td>
                    	<%-- 	<c:choose>
								<c:when test="${hrToEkpEnable == true }">
									${hrStaffPersonInfoForm.fdHrReportLeaderName }
								</c:when>
								<c:otherwise>
									${hrStaffPersonInfoForm.fdReportLeaderName }
								</c:otherwise>
							</c:choose>--%>      
 						${hrStaffPersonInfoForm.fdReportLeaderName }              	
 					</td></tr>
                    <tr>
                    	<td><bean:message key="hrStaffPersonInfo.fdOrgPosts" bundle="hr-staff"/></td>
                    	<td>
							${hrStaffPersonInfoForm.fdPostNames}
						</td>
                    	<td><bean:message key="hrStaffPersonInfo.fdStaffingLevel" bundle="hr-staff"/></td><td>${hrStaffPersonInfoForm.fdStaffingLevelName}</td>
                    </tr>
                    <tr><td><bean:message key="hrStaffPersonInfo.fdWorkAddress" bundle="hr-staff"/></td><td>${hrStaffPersonInfoForm.fdWorkAddress}</td><td><bean:message key="hrStaffPersonInfo.fdLoginName" bundle="hr-staff"/></td><td>${hrStaffPersonInfoForm.fdLoginName }</td></tr>
					<c:if test="${hrToEkpEnable == true }">
						<tr>
							<td><bean:message key="hrOrganizationGrade.fdName" bundle="hr-organization"/></td>
							<td>
								<c:if test="${not empty rankList}">
									${ranGrade eq null?"":ranGrade }
								</c:if>
							</td>
							<td><bean:message key="hrOrganizationRank.fdName" bundle="hr-organization"/></td>
							<td>
								<c:if test="${not empty rankList}">
									${hrStaffPersonInfoForm.fdOrgRankName }
								</c:if>
							</td>
						</tr>
					</c:if>
					<tr>
						<td><bean:message key="hrOrganizationElement.fdIsBusiness" bundle="hr-organization"/></td>
						<td>${hrStaffPersonInfoForm.fdIsBusiness eq 'true'?'是':'否'}</td>
						<td><bean:message key="hrStaffPersonInfo.fdCanLogin" bundle="hr-staff"/></td>
						<td>${hrStaffPersonInfoForm.fdCanLogin eq 'true'?'是':'否'}</td>
					</tr>
                </tbody>
            </table>
      </div>
<c:if test="${param.print==null}">
	<script>
	window.dialogObj = null
	seajs.use(['lui/jquery','lui/dialog','lui/topic'], function($, dialog , topic) {
		  $('#dutyInfo .lui-personnel-file-edit-text').on("click",function(){
			  dialog.iframe("/hr/staff/hr_staff_person_info/hrStaffPersonInfo.do?method=editType&fdId=${hrStaffPersonInfoForm.fdId }&key=onPost","${ lfn:message('hr-staff:hrStaffPersonInfo.jobInfo') }","",{
				  height:380,
				  width:1200,
					  buttons:[{
						  name:"${lfn:message('button.ok')}",
						  value:'',
						  fn:function(value,_dialog){
							  window.dialogObj = _dialog
							  $("#dialog_iframe iframe").get(0).contentWindow.submitBtn()
						  }
					  },
					  {
						  name:"${lfn:message('button.cancel')}",
						  value:'',
						  fn:function(value,_dialog){
							  _dialog.hide();
						  }
					  }
					  ]
			  
			  })
		  })
		  
		  window.openAccount = function(){
			  dialog.iframe("/hr/staff/hr_staff_person_info/hrStaffPersonInfo.do?method=editType&fdId=${hrStaffPersonInfoForm.fdId }&key=onPost","在职信息","",{
				  height:400,
				  width:900,
					  buttons:[{
						  name:"${lfn:message('button.ok')}",
						  value:'',
						  fn:function(value,_dialog){
							  window.dialogObj = _dialog
							  $("#dialog_iframe iframe").get(0).contentWindow.submitBtn()
						  }
					  },
					  {
						  name:"${lfn:message('button.cancel')}",
						  value:'',
						  fn:function(value,_dialog){
							  _dialog.hide();
						  }
					  }
					  ]
			  })
		  }
	})
	</script>
</c:if>