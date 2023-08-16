<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="/sys/ui/jsp/common.jsp"%>
     <div class="lui-personnel-file-staffInfo" id="staffStatus">
      <c:choose>
      	<c:when test="${param.print==null }">
          <div class="lui-personnel-file-header-title">
             <div class="lui-personnel-file-header-title-left">
               <div class="lui-personnel-file-header-title-text"><bean:message key="hrStaffPersonInfo.fdStatus" bundle="hr-staff"/></div>
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
				<div class="title"><bean:message key="hrStaffPersonInfo.fdStatus" bundle="hr-staff"/></div>
			</div>
		</c:otherwise>
	   </c:choose>
	   <div class="lui-split-line"></div>
           <table>
               <tbody>
                   <tr>
	                   	<td width="160"><bean:message key="hrStaffPersonInfo.fdStatus" bundle="hr-staff"/></td>
	                   	<td width="300">
	                   		<c:if test="${not empty hrStaffPersonInfoForm.fdStatus}">
	                   			<bean:message bundle="hr-staff" key="hrStaffPersonInfo.fdStatus.${hrStaffPersonInfoForm.fdStatus}"/>
	                   		</c:if>
	                   	</td>
	                   	<td width="160"><bean:message key="hr.staff.tree.category" bundle="hr-staff"/></td>
	                   	<td width="300">
	                   		${hrStaffPersonInfoForm.fdStaffType}
	                   	</td>
                   </tr>
                   <tr><td><bean:message key="hrStaffPersonInfo.fdNatureWork" bundle="hr-staff"/></td><td>${hrStaffPersonInfoForm.fdNatureWork}</td><td><bean:message key="hrStaffPersonInfo.fdEntryTime" bundle="hr-staff"/></td><td>${hrStaffPersonInfoForm.fdEntryTime}</td></tr>
                   <tr><td><bean:message key="hrStaffPersonInfo.fdEmploymentPeriod" bundle="hr-staff"/></td><td>${hrStaffPersonInfoForm.fdEmploymentPeriod}</td><td><bean:message key="hrStaffPersonInfo.fdPositiveTime" bundle="hr-staff"/></td><td>${hrStaffPersonInfoForm.fdPositiveTime}</td></tr>
                   <tr>
                   		<td><bean:message key="hrStaffPersonInfo.fdTrialOperationPeriod" bundle="hr-staff"/></td>
                   		<td>${hrStaffPersonInfoForm.fdTrialOperationPeriod}</td>
                   		<td><bean:message key="hrStaffPersonInfo.fdTrialExpirationTime" bundle="hr-staff"/></td>
                   		<td>${hrStaffPersonInfoForm.fdTrialExpirationTime}</td>
                   </tr>
               </tbody>
           </table>
     </div>
	<script>
	window.dialogObj=null
	seajs.use(['lui/jquery','lui/dialog','lui/topic'], function($, dialog , topic) {
		  $('#staffStatus .lui-personnel-file-edit-text').on("click",function(){
			  dialog.iframe("/hr/staff/hr_staff_person_info/hrStaffPersonInfo.do?method=editType&fdId=${hrStaffPersonInfoForm.fdId }&key=staffStatus","${lfn:message('hr-staff:hrStaffPersonInfo.fdStatus')}","",{
				  height:400,
				  width:1200,
					  buttons:[{
						  name:"${lfn:message('button.ok')}",
						  value:'',
						  fn:function(value,_dialog){
							  window.dialogObj = _dialog
							  $("#dialog_iframe iframe").get(0).contentWindow.submit();
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
	})
	</script>