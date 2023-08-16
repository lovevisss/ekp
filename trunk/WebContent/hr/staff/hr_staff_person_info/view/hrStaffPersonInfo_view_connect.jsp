<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="/sys/ui/jsp/common.jsp"%>
      <div class="lui-personnel-file-staffInfo" id="contactInfo">
      	<c:choose>
      	<c:when test="${param.print==null }">
         <div class="lui-personnel-file-header-title">
             <div class="lui-personnel-file-header-title-left">
               <div class="lui-personnel-file-header-title-text"><bean:message key="hrStaffPersonInfo.contactInfo" bundle="hr-staff"/></div>
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
				<div class="title"><bean:message key="hrStaffPersonInfo.contactInfo" bundle="hr-staff"/></div>
			</div>
		</c:otherwise>
	   </c:choose>
	   	   <div class="lui-split-line"></div>
           <table>
               <tbody>
                   <tr>
                   	<td width="160"><bean:message key="hrStaffEntry.fdMobileNo" bundle="hr-staff"/></td><td width="300">${hrStaffPersonInfoForm.fdMobileNo }</td>
                   	<td width="160"><bean:message key="hrStaffEntry.fdEmail" bundle="hr-staff"/></td><td width="300">${hrStaffPersonInfoForm.fdEmail }</td>
                   </tr>
                   <tr><td ><bean:message key="hrStaffPersonInfo.fdOfficeLocation" bundle="hr-staff"/></td><td  >${hrStaffPersonInfoForm.fdOfficeLocation }</td><td  ><bean:message key="hrStaffPersonInfo.fdWorkPhone" bundle="hr-staff"/></td><td  >${hrStaffPersonInfoForm.fdWorkPhone }</td></tr>
                   <tr><td ><bean:message key="hrStaffPersonInfo.fdEmergencyContact" bundle="hr-staff"/></td><td  >${hrStaffPersonInfoForm.fdEmergencyContact }</td><td  ><bean:message key="hrStaffPersonInfo.fdEmergencyContactPhone" bundle="hr-staff"/></td><td  >${hrStaffPersonInfoForm.fdEmergencyContactPhone }</td></tr>
                   <tr><td ><bean:message key="hrStaffPersonInfo.fdOtherContact" bundle="hr-staff"/></td><td  >${hrStaffPersonInfoForm.fdOtherContact }</td></tr>
               </tbody>
           </table>
     </div>
<c:if test="${param.print==null}">
    <script>
    window.dialogObj = null
	seajs.use(['lui/jquery','lui/dialog','lui/topic'], function($, dialog , topic) {
		  $('#contactInfo .lui-personnel-file-edit-text').on("click",function(){
			  dialog.iframe("/hr/staff/hr_staff_person_info/hrStaffPersonInfo.do?method=editType&fdId=${hrStaffPersonInfoForm.fdId }&key=connect","${ lfn:message('hr-staff:hrStaffPersonInfo.contactInfo') }","",{
				  height:400,
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
	})
	</script>
</c:if>