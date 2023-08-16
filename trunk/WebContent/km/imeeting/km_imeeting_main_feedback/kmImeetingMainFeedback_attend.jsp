<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="/sys/ui/jsp/common.jsp"%>
<table id="TABLE_DetailList" class="tb_normal" style="width: 100%;text-align: center;margin-top: -15px">
	<tr>
  		<td class="td_normal_title" style="width: 8%">
  			参会人
  		</td>
  		<td class="td_normal_title" style="width: 10%">
  			职务
  		</td>
  		<td class="td_normal_title" style="width: 10%">
  			手机号码
  		</td>
  		<td class="td_normal_title" style="width: 7%">
  			回执结果
  		</td>
  		<td class="td_normal_title" style="width: 35%">
  			回执备注
  		</td>
  		<td class="td_normal_title" style="width: 30%">
  			请假附件
  		</td>
	</tr>
	<tr align="center">
		<td>
			<xform:address propertyName="docAttendName" propertyId="docAttendId" orgType="ORG_TYPE_PERSON" showStatus="readOnly" />
		</td>
		<td>
			<span id="fdStaffingLevelIdSpan"></span>
			<input name="fdStaffingLevelId" type="hidden">
		</td>
		<td>
			<xform:text property="fdMobileNo" style="width:98%" validators="phoneNumber"  showStatus="${editStatus}" required="true"/>
		</td>
		<td>
			<xform:select property="fdOperateType" showPleaseSelect="false" showStatus="${editStatus}">
				<xform:enumsDataSource enumsType="km_imeeting_main_feedback_fd_operate_type" />
			</xform:select>
		</td>
		<td>
			<xform:textarea property="fdReason" style="width:98%" showStatus="${editStatus}" />
		</td>
		<td>
			<c:choose>
				<c:when test="${editStatus eq 'edit'}">
					<c:import url="/sys/attachment/sys_att_main/sysAttMain_edit.jsp" charEncoding="UTF-8">
						<c:param name="fdAttType" value="byte" />
						<c:param name="fdMulti" value="true" />
						<c:param name="fdKey" value="fdAttKey" />
						<c:param name="formBeanName" value="kmImeetingMainFeedbackForm" />
						<c:param name="enabledFileType" value="doc,docx,xls,xlsx,ppt,pptx,xlc,mppx,xlcx,wps,et,vsd,rtf,txt,pdf,jpg,jpeg,png,gif" />
					</c:import>
				</c:when>
				<c:otherwise>
					<c:import url="/sys/attachment/sys_att_main/sysAttMain_view.jsp" charEncoding="UTF-8">
						<c:param name="fdAttType" value="byte" />
						<c:param name="fdMulti" value="true" />
						<c:param name="fdKey" value="fdAttKey" />
						<c:param name="formBeanName" value="kmImeetingMainFeedbackForm" />
						<c:param name="enabledFileType" value="doc,docx,xls,xlsx,ppt,pptx,xlc,mppx,xlcx,wps,et,vsd,rtf,txt,pdf,jpg,jpeg,png,gif" />
					</c:import>
				</c:otherwise>
			</c:choose>
		</td>
	</tr>
</table>
<script>
seajs.use([
 	      'lui/jquery',
 	      'lui/dialog',
 	      'lui/dialog_common'
 	        ],function($,dialog,dialogCommon){
		
	window.onload = function () {
			var attendId = "${kmImeetingMainFeedbackForm.docCreatorId}";
			var getPostUrl = "${KMSS_Parameter_ContextPath}km/imeeting/km_imeeting_main_feedback/kmImeetingMainFeedback.do?method=getPostInfo";
			$.ajax({
				url: getPostUrl,
				type : 'POST',
				data: {
					attendId: attendId
				},
				async: false,
				success :function(rtnValue) {
					rtnValue = eval('(' + rtnValue + ')');
					if (rtnValue) {
						$("span#fdStaffingLevelIdSpan").text(rtnValue.fdName);
						$("[name='fdStaffingLevelId']").val(rtnValue.fdId);
					}
				}
			});
        	
        	data = new KMSSData();
        	data.AddBeanData("kmImeetingFeedbackService&type=mobile&attendId="+attendId);
	    	data.PutToField("fdMobileNo","fdMobileNo","",false);
		}

    });
</script>