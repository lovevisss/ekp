<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="/sys/ui/jsp/common.jsp"%>
<%@page import="java.util.List"%>
<template:include ref="default.print">
	<template:replace name="head">
		<%
			if(request.getHeader("User-Agent").toUpperCase().indexOf("MSIE")>-1){
				request.setAttribute("isIE",true);
			}else if(request.getHeader("User-Agent").toUpperCase().indexOf("TRIDENT")>-1){
				request.setAttribute("isIE",true);
			}else{
				request.setAttribute("isIE",false);
			}
		%>
		<script>
			function changeItemValue(obj) {
				if (obj.checked) {
					$("#" + obj.id + "Div").show();
				} else {
					$("#" + obj.id + "Div").hide();
				}
			}
			seajs.use(['lui/jquery'], function($) {
				$(document).ready(function() {
					//$("#attDiv").hide();
					$("#wflogDiv").hide();
					$("#relationDiv").hide();
					if ($("#circulationDiv")) {
						$("#circulationDiv").hide();
					}
					if ($("#disandrepDiv")) {
						$("#disandrepDiv").hide();
					}
					$("#readlogDiv").hide();
					if ($("#publiclogDiv")) {
						$("#publiclogDiv").hide();
					}
					//ZoomFontSize(3);
				});
			});

			function ZoomFontSize(size) {
				var root = document.getElementById("printTable");
				var i = 0;
				for (i = 0; i < root.childNodes.length; i++) {
					SetZoomFontSize(root.childNodes[i], size);
				}
				var tag_fontsize;
				if (root.currentStyle) {
					tag_fontsize = root.currentStyle.fontSize;
				} else {
					tag_fontsize = getComputedStyle(root, null).fontSize;
				}
				root.style.fontSize = parseInt(tag_fontsize) + size + 'px';
			}

			function SetZoomFontSize(dom, size) {
				if (dom.nodeType == 1 && dom.tagName != 'OBJECT' && dom.tagName != 'SCRIPT' && dom.tagName != 'STYLE' && dom
					.tagName != 'HTML') {
					for (var i = 0; i < dom.childNodes.length; i++) {
						if (dom.childNodes[i].tagName == 'IFRAME') {
							SetZoomFontSize(dom.childNodes[i].contentDocument.body, size);
						} else {
							SetZoomFontSize(dom.childNodes[i], size);
						}
					}
					var tag_fontsize;
					if (dom.currentStyle) {
						tag_fontsize = dom.currentStyle.fontSize;
					} else {
						tag_fontsize = getComputedStyle(dom, null).fontSize;
					}
					dom.style.fontSize = parseInt(tag_fontsize) + size + 'px';
				}
			}
		</script>
		<style type="text/css">
			.titleDiv {
				padding-bottom: 5px;
				border-bottom: 2px;
				border-bottom-style: dotted;
				border-bottom-color: rgb(240, 20, 87);
				font-family: Microsoft YaHei, Geneva, "sans-serif", SimSun;
				font-size: 14px;
				font-weight: bold
			}

			@media print {
				#toolBarDiv {
					display: none;
				}
			}

			.lui_upload_img_box .upload_opt_td,
			.lui_upload_img_box .upload_list_operation,
			.lui_upload_img_box .upload_list_download_count {
				display: none;
			}
			
			body .lui_form_content_frame {
				margin-bottom: 0!important;
			}
			
			.print-frame {
				margin-top: 15px;
			}
		</style>
		<link rel="Stylesheet" href="${LUI_ContextPath}/km/imeeting/resource/css/view.css?s_cache=${MUI_Cache}" />
		<link rel="Stylesheet" href="${LUI_ContextPath}/km/imeeting/resource/css/attend.css?s_cache=${MUI_Cache}" />
		<link rel="Stylesheet" href="${LUI_ContextPath}/km/imeeting/resource/css/mainPrint.css?s_cache=${MUI_Cache}" />
	</template:replace>
	<template:replace name="title">
		<c:out value="${ kmImeetingMainForm.fdName } - ${ lfn:message('km-imeeting:module.km.imeeting') }">
		</c:out>
	</template:replace>
	<template:replace name="toolbar">
		<ui:toolbar id="toolbar" layout="sys.ui.toolbar.float" count="6">
			<ui:button text="${ lfn:message('button.print') }" onclick="window.print();"></ui:button>
			<ui:button text="${ lfn:message('km-imeeting:kmImeeting.btn.zoom.in') }" order="5" onclick="ZoomFontSize(3);"></ui:button>
			<ui:button text="${ lfn:message('km-imeeting:kmImeeting.btn.zoom.out') }" order="5" onclick="ZoomFontSize(-3);"></ui:button>
			<c:import url="/sys/print/import/switchNewButton.jsp" charEncoding="UTF-8"></c:import>
			<c:import url="/sys/common/exportButton.jsp" charEncoding="UTF-8"></c:import>
			<ui:button text="${lfn:message('button.close')}" order="5" onclick="Com_CloseWindow();"></ui:button>
		</ui:toolbar>
	</template:replace>
	<template:replace name="content">
		<html:form action="/km/imeeting/km_imeeting_main/kmImeetingMain.do">
			<center>
				<div id="toolBarDiv" style="padding-top: 12px;max-width:1000px;" data-remove="false">
					<table class="tb_normal" width=98%>
						<tr>
							<td>
								<label>
									<input id="wflog" type="checkbox" onchange="changeItemValue(this);" />
									<bean:message bundle="km-imeeting" key="kmImeeting.print.review.record" />
								</label>
							</td>
						</tr>
					</table>
				</div>
			</center>
			<div id="printTable" class="tb_normal" style="border: none;font-size: 12px;max-width:1000px;">
				<div class="lui_form_content_frame" style="padding-top:10px">
					<table width=100% style="margin-top: 20px;">
						<tr>
							<td colspan="4">
								<table class="tb_normal" width=100% id="Table_Main">
									<tr>
										<td colspan="4" id="docSubject" style="text-align:center">
											<xform:text property="fdName" style="text-align:center"></xform:text>
											<span id="docSubjectSpan">通知单</span>
										</td>
									</tr>
									<tr>
										<td colspan="4"  class="com_subject">
											<div style="margin-left:0px">
												<span style="margin-right:25px;font-weight: bold;">关联会议方案：</span>
												<a href="${LUI_ContextPath }/km/imeeting/km_imeeting_scheme/kmImeetingScheme.do?method=view&fdId=${kmImeetingMainForm.fdSchemeId}" target="_blank" style="color: #4285f4;">${kmImeetingMainForm.fdSchemeName}</a>
											</div>
										</td>
									</tr>
									<c:if test="${kmImeetingMainForm.fdChangeMeetingFlag eq 'true'}">
										<tr>
											<td class="td_normal_title" width=15%>
												<bean:message bundle="km-imeeting" key="kmImeetingMain.changeMeetingReason"/>
											</td>
											<td colspan="3" width="85%" style="color: red;">
												<xform:textarea property="changeMeetingReason" style="width:95%;color:red;" required="true" 
													showStatus="view" subject="变更事由">
												</xform:textarea>
												<html:hidden property="beforeChangeContent"/>
											</td>
										</tr>
									</c:if>
									<tr>
									<tr >
										<td class="td_normal_title" width="15%">
											<bean:message key="kmImeetingMain.fdMeetingNum" bundle="km-imeeting" />
										</td>
										<td width="35%">
											<xform:text property="fdMeetingNum" showStatus="view" />
										</td>
										<td class="td_normal_title" width="15%">
											<bean:message key="kmImeetingMain.fdDate" bundle="km-imeeting" />
										</td>
										<td width="35%" >
											<xform:datetime property="fdHoldDate" dateTimeType="datetime" showStatus="view" 
												onValueChange="changeDateTime"  required="true" validators="after compareTime"></xform:datetime>
											<span style="position: relative;">~</span>
											<xform:datetime property="fdFinishDate" dateTimeType="datetime" showStatus="view" 
												onValueChange="changeDateTime" required="true" validators="after compareTime"></xform:datetime>
										</td>
									</tr>
									<tr >
										<td class="td_normal_title" width="15%">
											<bean:message bundle="km-imeeting" key="kmImeetingMain.fdNeedPlace" />
										</td>
										<td width="35%">
											<c:out value="${kmImeetingMainForm.fdPlaceName}"></c:out>
											<c:if test="${not empty kmImeetingMainForm.fdPlaceName and not empty kmImeetingMainForm.fdOtherPlace}">
												<br>
											</c:if>
											<c:out value="${kmImeetingMainForm.fdOtherPlace}"></c:out>
										</td>
										<td class="td_normal_title" width="15%">
											报名截止时间
										</td>
										<td width="35%">
											<xform:datetime style="width:90%" property="fdFeedBackDeadline" dateTimeType="datetime" showStatus="view" subject="${lfn:message('km-imeeting:kmImeetingMain.fdFeedBackDeadline')}" required="true" validators="after valDeadline"></xform:datetime>
										</td>
									</tr>
									<tr >
										<td class="td_normal_title" width="15%">
											<bean:message bundle="km-imeeting" key="kmImeetingMain.fdHost"/>
										</td>
										<td width="35%">
											<xform:address propertyName="fdHostName" propertyId="fdHostId" orgType="ORG_TYPE_PERSON" style="width:90%;" ></xform:address>
										</td>
										<td class="td_normal_title" width="15%">
											职务
										</td>
										<td width="35%">
											<%-- <xform:staffingLevel propertyName="fdStaffingLevelName" propertyId="fdStaffingLevelId" style="width:95%;"></xform:staffingLevel> --%>
											<xform:text property="fdPosition" showStatus="view" />
										</td>
									</tr>
									<tr>
										<td class="td_normal_title" width="15%">
											会议发起人
										</td>
										<td width="35%" >
											<c:out value="${kmImeetingMainForm.docCreatorName}"></c:out>
										</td>
										<td class="td_normal_title" width="15%">
											发起人部门
										</td>
										<td width="35%" >
											<c:out value="${kmImeetingMainForm.fdCreatorDeptName}"></c:out>
										</td>
									</tr>
									<tr >
										<td class="td_normal_title" width="15%">
											出席会议人员
										</td>
										<td width="85%" colspan="3" >
											<xform:address  style="width:90%;" textarea="true" showStatus="view"  propertyId="fdAttendPersonIds" propertyName="fdAttendPersonNames" 
														orgType="ORG_TYPE_ALL" mulSelect="true" validators="validateattend"
														subject="${lfn:message('km-imeeting:kmImeetingMain.fdAttendPersons') }" required="true">
											</xform:address>
										</td>
									</tr>
									<tr >
										<td class="td_normal_title" width="15%">
											邀请参加人员
										</td>
										<td width="85%" colspan="3">
											<xform:address  style="width:90%;" textarea="true" showStatus="view"  propertyId="fdInvitePersonIds" propertyName="fdInvitePersonNames" 
														orgType="ORG_TYPE_ALL" mulSelect="true" subject="${lfn:message('km-imeeting:kmImeetingMain.fdInvitePersons') }">
											</xform:address>
										</td>
									</tr>
									<tr >
										<td class="td_normal_title" width="15%">
											列席会议人员
										</td>
										<td width="85%" colspan="3">
											<xform:address style="width:90%;" textarea="true" showStatus="view"  propertyId="fdParticipantPersonIds" propertyName="fdParticipantPersonNames" orgType="ORG_TYPE_ALL" mulSelect="true"></xform:address>
										</td>
									</tr>
									<tr >
										<td class="td_normal_title" width="15%">
											<!-- 纪要人员 -->
											<bean:message key="kmImeetingMain.createStep.base.fdSummaryInputPerson" bundle="km-imeeting" />
										</td>
										<td width="35%">
											<xform:address style="width:90%;"   propertyId="fdSummaryInputPersonId" propertyName="fdSummaryInputPersonName" 
														orgType="ORG_TYPE_PERSON" validators="validateSummaryInputPerson">
											</xform:address>
										</td>
										<td class="td_normal_title" width="15%">
											会服人员
										</td>
										<td width="35%">
											<xform:address style="width:90%" showStatus="view"  propertyId="fdAssistPersonIds" propertyName="fdAssistPersonNames" orgType="ORG_TYPE_ALL" mulSelect="true"></xform:address>
										</td>
									</tr>
									<tr>
										<td class="td_normal_title" width="15%">
											<!-- 工作安排 -->
											<bean:message key="kmimeetingmain.workArrangement" bundle="km-imeeting" />
										</td>
										<td colspan="3" width="85%">
											<xform:textarea property="workArrangement" showStatus="view"></xform:textarea>
										</td>
									</tr>
								</table>
								
								<div class="lui_form_content_frame" style="margin-top:15px">
									<table class="tb_normal" width=100% id="Table_Main"> 
										<tr>
											<td colspan="4" class="com_subject" style="font-size: 110%;font-weight: bold;">
												<bean:message bundle="km-imeeting" key="kmImeetingMain.createStep.base.agenda"/>
											</td>
										</tr>
										<tr>
											<%--会议议题信息--%>
											<td colspan="4">
												<html:hidden property="fdIsTopic" value="1"/>
												<c:set var="isOnMainPage" value="true"></c:set>
												<%@include file="/km/imeeting/km_imeeting_agenda/kmImeetingAgenda_viewTopic_print.jsp"%>
											</td>
										</tr>
									</table>
								</div>
								
								<!-- 出席单位 -->
								<jsp:include page="/km/imeeting/import/kmImeeting_attendUnit.jsp">
									<jsp:param value="true" name="isPrint"/>
								</jsp:include>
								
								<div class="lui_form_content_frame" style="margin-top: 15px;">
									<table class="tb_normal" width=100% id="Table_Main"> 
										<tr>
											<td colspan="4" class="com_subject" style="font-size: 110%;font-weight: bold;">
												<c:out value="会议辅助资源"></c:out>
											</td>
										</tr>
										<tr>
								 		<%--会议室辅助设备--%>
								 		<td class="td_normal_title" width=15% title="${lfn:message('km-imeeting:kmImeetingMain.kmImeetingEquipment.tip') }">
								 			<bean:message bundle="km-imeeting" key="kmImeetingMain.kmImeetingEquipment"/>
								 		</td>
								 		<td width="85%"  colspan="3">
								 			 <input type="hidden" name="kmImeetingEquipmentIds" value="${kmImeetingMainForm.kmImeetingEquipmentIds}"/>
								 			<c:out value="${kmImeetingMainForm.kmImeetingEquipmentNames}"></c:out>
										</td>
								 	</tr>
								 	<tr>
								 		<%--会议室辅助服务--%>
								 		<td class="td_normal_title" width=15% title="${lfn:message('km-imeeting:kmImeetingMain.kmImeetingDevices.tip') }">
								 			<bean:message bundle="km-imeeting" key="kmImeetingMain.kmImeetingDevices"/>
								 		</td>
								 		<td width="85%"  colspan="3" class="meeting-device-style">
								 			<c:out value="${kmImeetingMainForm.kmImeetingDeviceNames}"></c:out>
										</td>
								 	</tr>
									</table>
								</div>
								
								<div class="lui_form_content_frame" style="margin-top: 15px;">
									<table class="tb_normal" width=100% id="Table_Main"> 
										<tr>
											<td colspan="4" class="com_subject" style="font-size: 110%;font-weight: bold;">
												<c:out value="短信内容"></c:out>
											</td>
										</tr>
										<tr>
											<!-- 短息内容 -->
											<td class="td_normal_title" width="15%">
												<c:out value="短信内容"></c:out>
											</td>
											<td>
												<xform:textarea property="fdSMSContent" style="width:95%"></xform:textarea>
											</td>
										</tr>
									</table>
								</div>
								
								<!-- 变更记录 -->
								<div class="lui_form_content_frame">
									<c:import url="/km/imeeting/km_imeeting_main/import/kmImeetingMain_changList_print.jsp" charEncoding="UTF-8">
										<c:param name="meetingId" value="${JsParam.fdId }"></c:param>
									</c:import>
								</div>
							</td>
						</tr>
					</table>
				</div>
				<div class="lui_form_content_frame" style="padding-top:10px" id="wflogDiv">
					<div class="titleDiv">
						<bean:message bundle="km-imeeting" key="kmImeeting.print.review.record" />
					</div>
					<table width=100% style="margin-top: 20px;">
						<tr>
							<td colspan="4">
								<c:import url="/sys/workflow/include/sysWfProcess_log.jsp" charEncoding="UTF-8">
									<c:param name="formName" value="kmImeetingMainForm" />
								</c:import>
							</td>
						</tr>
					</table>
				</div>
				<jsp:include page="/km/imeeting/km_imeeting_main/kmImeetingMain_printQrCode.jsp">
					<jsp:param value="kmImeetingMain" name="qrcodeModelName" />
					<jsp:param value="${kmImeetingMainForm.fdId}" name="fdModelId" />
				</jsp:include>
			</div>
		</html:form>
		<script>
			function outputPDF() {
				seajs.use(['lui/jquery', 'lui/export/export'], function($, exp) {
					$("#toolBarDiv").hide();
					exp.exportPdf(document.getElementById('printTable'), {
						title: '${ kmImeetingMainForm.fdName }',
						callback: function() {
							$("#toolBarDiv").css("display", "");
							setTimeout(function() {
								$("#printTable").unwrap();
							}, 500);
						}
					});
				});
			}

			function outputMHT() {
				seajs.use(['lui/export/export'], function(exp) {
					exp.exportMht({
						title: '${ kmImeetingMainForm.fdName }'
					});
				});
			}
		</script>
	</template:replace>
</template:include>
