<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="/sys/ui/jsp/common.jsp"%>

<template:include ref="default.dialog">
	<template:replace name="head">
		<script type="text/javascript">
			Com_IncludeFile("validation.jsp|validation.js|plugin.js|eventbus.js|xform.js", null, "js");
		</script>
		<style>
			.cancel{
				display: none;
			}
		</style>
	</template:replace>
	<template:replace name="content">
		<center>
		<html:form action="/hr/staff/hr_staff_person_experience/contract/hrStaffPersonExperienceContract.do?method=save" >
			<input type="hidden" name="fdPersonInfoId" value="${HtmlParam.personInfoId}" />
			<input type="hidden" name="personInfoId" value="${HtmlParam.personInfoId}" />
			<input type="hidden" name="type" value="contract" />
			<table class="tb_normal" style="margin: 20px 0" width=98%>
				<tr>
					<!-- 合同名称-->
					<td width="15%" class="td_normal_title">
						${ lfn:message('hr-staff:hrStaffPersonExperience.contract.fdName') }
					</td>
					<td colspan="3">
						<xform:text property="fdName" style="width:98%;" showStatus="edit"  validators="maxLength(200)"/>
					</td>
				</tr>
				<tr>
					<!-- 合同类型 -->
					<td class="td_normal_title">
						<bean:message bundle="hr-staff" key="hrStaffPersonExperience.contract.fdContType" />
					</td>
					<td>
						<xform:select property="fdStaffContTypeId" showPleaseSelect="true">
							<xform:beanDataSource serviceBean="hrStaffContractTypeService" selectBlock="fdId,fdName" orderBy="fdOrder" />
						</xform:select>
					</td>
					<!-- 合同状态 -->
					<td class="td_normal_title">
						<bean:message bundle="hr-staff" key="hrStaffPersonExperience.contract.fdContStatus" />
					</td>
					<td>
						<xform:select property="fdContStatus" onValueChange="showCancel(this.value);">
							<xform:enumsDataSource enumsType="hrStaffPersonExperienceContract_fdContStatus" />
						</xform:select>
					</td>
				</tr>
				<tr>
					<!-- 开始时间-->
					<td width="15%" class="td_normal_title">
						${ lfn:message('hr-staff:hrStaffPersonExperience.contract.fdBeginDate') }
					</td>
					<td width="35%">
						<xform:datetime property="fdBeginDate" dateTimeType="date" validators="compareDate"></xform:datetime>
					</td>
					<!-- 结束时间-->
					<td width="15%" class="td_normal_title">
						${ lfn:message('hr-staff:hrStaffPersonExperience.contract.fdEndDate') }
					</td>
					<td width="35%">
						<xform:datetime property="fdEndDate" dateTimeType="date" validators="compareDate checkLongterm"></xform:datetime>
						<xform:checkbox property="fdIsLongtermContract" value="${hrStaffPersonExperienceContractForm.fdIsLongtermContract}" onValueChange="cancelEndDate" showStatus="edit">
							<xform:simpleDataSource value="true"><bean:message bundle="hr-staff" key="hrStaffPersonExperience.contract.fdIsLongtermContract.1"/></xform:simpleDataSource>
						</xform:checkbox>
					</td>
				</tr>
				<tr>
					<!-- 合同办理时间 -->
					<td class="td_normal_title">
						<bean:message bundle="hr-staff" key="hrStaffPersonExperience.contract.fdHandleDate" />
					</td>
					<td>
						<xform:datetime property="fdHandleDate" dateTimeType="date" />
					</td>
					<!-- 签订标识 -->
					<td class="td_normal_title">
						<bean:message bundle="hr-staff" key="hrStaffPersonExperience.contract.fdSignType" />
					</td>
					<td>
						<c:choose>
							<c:when test="${hrStaffPersonExperienceContractForm.method_GET eq 'add' }">
								<xform:radio property="fdSignType">
									<xform:enumsDataSource enumsType="hrStaffPersonExperienceContract_fdSignType" />
								</xform:radio>
							</c:when>
							<c:otherwise>
								<c:choose>
									<c:when test="${hrStaffPersonExperienceContractForm.fdSignType eq '1' or hrStaffPersonExperienceContractForm.fdSignType eq '2' or empty hrStaffPersonExperienceContractForm.fdSignType}">
										<xform:radio property="fdSignType">
											<xform:enumsDataSource enumsType="hrStaffPersonExperienceContract_fdSignType" />
										</xform:radio>
									</c:when>
									<c:otherwise>
										<c:choose>
											<c:when test="${fn:endsWith(hrStaffPersonExperienceContractForm.fdSignType,'null') }">
												<xform:radio property="fdSignType">
													<xform:enumsDataSource enumsType="hrStaffPersonExperienceContract_fdSignType" />
												</xform:radio>
											</c:when>
											<c:otherwise>
												<html:hidden property="fdSignType" />
												<c:out value="${signType }" />
											</c:otherwise>
										</c:choose>
									</c:otherwise>
								</c:choose>
							</c:otherwise>
						</c:choose>
					</td>
					
				</tr>
				<tr>
					<!-- 备注-->
					<td width="15%" class="td_normal_title">
						${ lfn:message('hr-staff:hrStaffPersonExperience.fdMemo') }
					</td>
					<td colspan="3">
						<xform:textarea property="fdMemo" style="width:98%;height:50px;"/>
					</td>
				</tr>
				<tr>
					<!-- 合同附件 -->
					<td class="td_normal_title">
						<bean:message bundle="hr-staff" key="hrStaffPersonExperience.contract.autoHashMap" />
					</td>
					<td colspan="3">
						<c:import url="/sys/attachment/sys_att_main/sysAttMain_edit.jsp" charEncoding="UTF-8">
							<c:param name="fdKey" value="attHrExpCont"/>
							<c:param name="formBeanName" value="hrStaffPersonExperienceContractForm" />
						</c:import>
					</td>
				</tr>
				<tr class="cancel">
					<!-- 合同解除时间 -->
					<td class="td_normal_title">
						<bean:message bundle="hr-staff" key="hrStaffPersonExperience.contract.fdCancelDate" />
					</td>
					<td colspan="3">
						<xform:datetime property="fdCancelDate" dateTimeType="date" /><span style="display: none;" class="txtstrong" id="isRequiredFlag">*</span>	
					</td>
				</tr>
				<tr class="cancel">
					<!-- 合同解除原因 -->
					<td class="td_normal_title">
						<bean:message bundle="hr-staff" key="hrStaffPersonExperience.contract.fdCancelReason" />
					</td>
					<td colspan="3">
						<xform:textarea property="fdCancelReason" style="width:98%;height:50px;" />
					</td>
				</tr>
			</table>
		</html:form>
		<ui:button text="${lfn:message('button.save')}" onclick="_submit();" height="35" width="120" ></ui:button>
		</center>
	</template:replace>
</template:include>
<script type="text/javascript">
	// 表单校验
	var _validation = $KMSSValidation();

	seajs.use( [ 'lui/jquery', 'lui/dialog', 'hr/staff/resource/js/dateUtil' ], function($, dialog, dateUtil) {
		// 表单序列化成JSON对象
			$.fn.serializeObject = function() {
				var o = {};
				var a = this.serializeArray();
				$.each(a, function() {
					if (o[this.name] !== undefined) {
						if (!o[this.name].push) {
							o[this.name] = [ o[this.name] ];
						}
						o[this.name].push(this.value || '');
					} else {
						o[this.name] = this.value || '';
					}
				});
				return o;
			};

			// 确认提交
			window._submit = function() {
			   	if ($KMSSValidation().validate()) {
					var method = Com_GetUrlParameter(location.href,'method');
					var fdName = $('[name="fdName"]').val();
					var fdEndDate = $('[name="fdEndDate"]').val();
					var fdBeginDate = $('[name="fdBeginDate"]').val();
					var fdIsLongtermContract = $('[name="fdIsLongtermContract"]').val();
					var fdStaffContTypeId = $('select[name="fdStaffContTypeId"] option:selected').val();
					$.ajax({
						url : "${LUI_ContextPath}/hr/staff/hr_staff_person_experience/contract/hrStaffPersonExperienceContract.do?method=getRepeatContract",
						type : 'POST',
						data: {
							"personInfoId":"${HtmlParam.personInfoId}",
							"fdId":"${HtmlParam.fdId}",
							"fdContType":fdStaffContTypeId,
							"fdName":fdName,
							"fdBeginDate":fdBeginDate,
							"fdEndDate":fdEndDate,
							"fdIsLongtermContract":fdIsLongtermContract
						},
						dataType : 'json',
						success: function(data) {
							if(data.result){
								if(method == 'add'){
									Com_Submit(document.hrStaffPersonExperienceContractForm,'save');
								} else {
									Com_Submit(document.hrStaffPersonExperienceContractForm,'update');
								}
							}else{
								dialog.alert("${ lfn:message('hr-staff:hrStaff.import.error.contract.repeat') }");
							}
						}
					});
						/* if ($KMSSValidation().validate()) {
							window.$dialog.hide($("form").serializeObject());
						} */
				 } 
			};

			// 取消
			window._cancel = function() {
				window.$dialog.hide();
			};

			var compareDateMsg = '${ lfn:message("hr-staff:hrStaffPersonExperience.compareDate.error1") }';
			switch('${JsParam.type}'){
			case 'contract':{
				compareDateMsg = '${ lfn:message("hr-staff:hrStaffPersonExperience.compareDate.error2") }';
				break;
			}
			case 'education':{
				compareDateMsg = '${ lfn:message("hr-staff:hrStaffPersonExperience.compareDate.error3") }';
				break;
			}
			case 'qualification':{
				compareDateMsg = '${ lfn:message("hr-staff:hrStaffPersonExperience.compareDate.error4") }';
				break;
			}
			}

			// 日期区间校验
			_validation.addValidator('compareDate', compareDateMsg, function(v, e, o) {
				var fdBeginDate = $('[name="fdBeginDate"]');
				var fdEndDate = $('[name="fdEndDate"]');
				var result = true;
				if (fdBeginDate.val() && fdEndDate.val()) {
					var start = dateUtil.parseDate(fdBeginDate.val());
					var end = dateUtil.parseDate(fdEndDate.val());
					if (start.getTime() > end.getTime()) {
						result = false;
					}
				}
				return result;
			});

			// 勾选长期有效校验
			_validation.addValidator('checkLongterm', "${ lfn:message("hr-staff:hrStaffPersonExperience.contract.fdIsLongtermContract.error") }", function(v, e, o) {
				var result = true;
				var longtermContract = $('[name="fdIsLongtermContract"]').val();
				if(v){
					if(longtermContract == 'true'){
						result = false;
					}
				}
				return result;
			});
		});
		
	function showCancel(value){
		var fdCancelDate = $(".cancel [name='fdCancelDate']");
		if(value == '3'){
			$(".cancel").show();
			_validation.addElements(fdCancelDate[0],'required');
			$("#isRequiredFlag").show();
		}else{
			$(".cancel").hide();
			fdCancelDate.val('');
			_validation.removeElements(fdCancelDate[0],'required');
			$("#isRequiredFlag").hide();
			$(".cancel [name='fdCancelReason']").val('');
		}
	}
    // 长期有效勾选清空到期时间
	function cancelEndDate(){
		var longtermContract = $('[name="fdIsLongtermContract"]').val();
		if(longtermContract == 'true'){
			$('[name="fdEndDate"]').val('');
		}
	}
	LUI.ready(function(){
		showCancel('${hrStaffPersonExperienceContractForm.fdContStatus}');
	});
</script>