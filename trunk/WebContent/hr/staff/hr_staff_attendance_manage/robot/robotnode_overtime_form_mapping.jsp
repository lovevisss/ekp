<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="/sys/ui/jsp/common.jsp"%>

<%-- 个人加班机器人 --%>
<template:include ref="default.simple" sidebar="auto">
	<template:replace name="body"> 
		<script type="text/javascript" src="${LUI_ContextPath}/resource/js/jquery.js?s_cache=${LUI_Cache}"></script>
		<script type="text/javascript">
			var _NodeContent = eval('(' + parent.NodeContent + ')');
			var allparams = {};
			if(_NodeContent) {
				allparams = _NodeContent.params;
			}

			function serializeObject(form) {
				var o = {};
			    var a = form.serializeArray();
			    $.each(a, function() {
			        if (o[this.name] !== undefined) {
			            if (!o[this.name].push) {
			                o[this.name] = [o[this.name]];
			            }
			            o[this.name].push(this.value || '');
			        } else {
			            o[this.name] = this.value || '';
			        }
			    });
			    
			    // 保存下拉选择的文本值，因为在view页面不能读取表单数据，所以只能在这里保存
			    var _s = new Array("fdApplicant","fdLeaveDays","fdBeginDate","fdEndDate","fdLeaveType");
			    $.each(_s, function(i, n) {
			    	var name = n + "_text";
			    	o[name] = $("select[name=" + n + "]").find("option:selected").text();
			    });
			    return o;
			}

			// 必须实现的方法，供父窗口(attribute_robotnode.html)调用。
			function returnValue() {
				return "{\"params\":" + LUI.stringify(serializeObject($("#mainForm"))) + "}";
			};

			function setLeaveType() {
				var _allparams = allparams || {};
				// 设置下拉框内容
				$.each($("#mainForm select"), function(i, n) {
					if(n.options.length == 1)
						n.options[0].innerText = _allparams[$(n).attr("name") + "_text"];
				});
			};

			/**
			 * 获取所有表单字段
			 */
			function transFormFieldList() {
				var rtnResult = new Array();
				var fieldList = parent.FlowChartObject.FormFieldList;
				if (!fieldList)
					return rtnResult;
				// 转换成option支持的格式
				for ( var i = 0, length = fieldList.length; i < length; i++) {
					rtnResult.push( {
						value : fieldList[i].name,
						name : fieldList[i].label
					});
				}
				return rtnResult;
			};

			LUI.ready(function(){
				createSelectElementHTML("fdApplicant");
				createSelectElementHTML("fdLeaveDays");
				createSelectElementHTML("fdBeginDate");
				createSelectElementHTML("fdEndDate");
				createSelectElementHTML("fdLeaveType");
				
				setLeaveType();
			});

			function createSelectElementHTML(fieldName) {
				var _allparams = allparams || {};
				var options = [];
				if('fdLeaveType' == fieldName) {
					options.push({value: 'takeWorking', name: '<bean:message key="hrStaff.robot.optionValue.overtime.takeWorking" bundle="hr-staff"/>'});
					options.push({value: 'annualLeave', name: '<bean:message key="hrStaff.robot.optionValue.overtime.annualLeave" bundle="hr-staff"/>'});
					options.push({value: 'sickLeave', name: '<bean:message key="hrStaff.robot.optionValue.overtime.sickLeave" bundle="hr-staff"/>'});
				} else {
					options = transFormFieldList();
				}
				var rtnResult = new Array();
				var checkVal = _allparams[fieldName];
				if (options == null || options.length == 0) {
					rtnResult.push('<option value=\'\' selected><bean:message key="hrStaff.robot.select" bundle="hr-staff"/></option>');
				} else {
					for ( var i = 0, length = options.length; i < length; i++) {
						var option = options[i], value = option.value || option.name;
						rtnResult.push('<option value=\'' + value + '\'');
						if (value == checkVal)
							rtnResult.push(' selected');
						rtnResult.push('>' + option.name + '</option>');
					}
				}
				var select = '<select name=\'' + fieldName + '\'>' + rtnResult.join('') + '</select>';
				$("#" + fieldName).html(select);
			};
		</script>
		
		<center>
			<form id="mainForm" action="">
			<h3>${lfn:message('hr-staff:hrStaff.robot.formMapping') }</h3>
			<table width="100%" class="tb_normal">
				<tr align="center">
					<td width="20%">
						${lfn:message('hr-staff:hrStaff.robot.overtime.attendanceAttribute') }
					</td>
					<td width="30%">
						${lfn:message('hr-staff:hrStaff.robot.formField') }
					</td>
					<td width="20%">
						${lfn:message('hr-staff:hrStaff.robot.overtime.attendanceAttribute') }
					</td>
					<td width="30%">
						${lfn:message('hr-staff:hrStaff.robot.formField') }
					</td>
				</tr>
				<tr align="center">
					<td>
						${lfn:message('hr-staff:hrStaff.robot.overtime.applicant') }
					</td>
					<td id="fdApplicant">
					</td>
					<td>
						${lfn:message('hr-staff:hrStaff.robot.overtime.days') }
					</td>
					<td id="fdLeaveDays">
					</td>
				</tr>
				<tr align="center">
					<td>
						${lfn:message('hr-staff:hrStaffAttendanceManageDetailed.fdBeginDate') }
					</td>
					<td id="fdBeginDate">
					</td>
					<td>
						${lfn:message('hr-staff:hrStaffAttendanceManageDetailed.fdEndDate') }
					</td>
					<td id="fdEndDate">
					</td>
				</tr>
				<tr align="center">
					<td>
						${lfn:message('hr-staff:hrStaff.robot.overtime.fdLeaveType') }
					</td>
					<td id="fdLeaveType">
					</td>
					<td colspan="2">
						<span style="word-wrap:break-word;word-break:break-all;">${lfn:message('hr-staff:hrStaff.robot.overtime.fdLeaveType.desc') }</span>
					</td>
				</tr>
				<%-- <tr>
					<td colspan="4">
						${lfn:message('hr-staff:hrStaff.robot.attendanceDesc') }
					</td>
				</tr> --%>
			</table>
			</form>
		</center>
	</template:replace>
</template:include>