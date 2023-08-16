<%@page import="com.landray.kmss.util.ArrayUtil"%>
<%@page import="com.landray.kmss.km.imeeting.forms.KmImeetingSummaryForm"%>
<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="/sys/ui/jsp/common.jsp"%>
<%@page import="java.util.List"%>
<%
	KmImeetingSummaryForm kmImeetingSummaryForm = (KmImeetingSummaryForm) request.getAttribute("kmImeetingSummaryForm");
	String[] fdNotifyPersonList = kmImeetingSummaryForm.getFdNotifyPersonList();
	String notifyPerson = "";
	if (fdNotifyPersonList != null && fdNotifyPersonList.length > 0) {
		notifyPerson = ArrayUtil.concat(fdNotifyPersonList, ';');
	}
	request.setAttribute("notifyPerson", notifyPerson);
%>
<template:include ref="default.print">
	<template:replace name="head">
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
		</style>
	</template:replace>
	<template:replace name="title">
		<c:out value="${ kmImeetingSummaryForm.fdName } - ${ lfn:message('km-imeeting:module.km.imeeting') }">
		</c:out>
	</template:replace>
	<template:replace name="toolbar">
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
			seajs.use(['lui/jquery', 'km/imeeting/resource/js/dateUtil'], function($, dateUtil) {
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
					//初始化会议历时
					if('${kmImeetingSummaryForm.fdHoldDuration}'){
						//将小时分解成时分
						var timeObj=dateUtil.splitTime({"ms":"${kmImeetingSummaryForm.fdHoldDuration}"});
						$('#fdHoldDurationHour').html(timeObj.hour);
						$('#fdHoldDurationMin').html(timeObj.minute);
						if(timeObj.minute){
							$('#fdHoldDurationMinSpan').show();
						}else{
							$('#fdHoldDurationMinSpan').hide();
						}
					}
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
		<html:form action="/km/imeeting/km_imeeting_summary/kmImeetingSummary.do">
			<center>
				<div id="toolBarDiv" style="padding-top: 12px;max-width:1000px;" data-remove="false">
					<table class="tb_normal" width=98%>
						<tr>
							<td>
								<label>
									<input id="wflog" type="checkbox" onclick="changeItemValue(this);" />
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
										<%-- 会议名称--%>
										<td class="td_normal_title" width=15%>
											<bean:message bundle="km-imeeting" key="kmImeetingSummary.fdName" />
										</td>
										<td width="35%">
											<xform:text property="fdName" style="width:80%" />
										</td>
										<%-- 会议类型--%>
										<td class="td_normal_title" width=15%>
											<bean:message bundle="km-imeeting" key="kmImeetingSummary.fdTemplate" />
										</td>
										<td width="35%">
											<c:out value="${kmImeetingSummaryForm.fdTemplateName}"></c:out>
										</td>
									</tr>
									<tr>
										<%-- 主持人--%>
										<td class="td_normal_title" width=15%>
											<bean:message bundle="km-imeeting" key="kmImeetingSummary.fdHost" />
										</td>
										<td colspan="3" width="85%">
											<c:out
												value="${kmImeetingSummaryForm.fdHostName} ${kmImeetingSummaryForm.fdOtherHostPerson}">
											</c:out>
										</td>
									</tr>
									<tr>
										<%-- 会议时间--%>
										<td class="td_normal_title" width=15%>
											<bean:message bundle="km-imeeting" key="kmImeetingMain.fdDate" />
										</td>
										<td width="35%">
											<xform:datetime property="fdHoldDate" dateTimeType="datetime" style="width:36%">
											</xform:datetime>~
											<xform:datetime property="fdFinishDate" dateTimeType="datetime"
												style="width:36%"></xform:datetime>
										</td>
										<%--会议历时--%>
										<td class="td_normal_title" width=15%>
											<bean:message bundle="km-imeeting" key="kmImeetingMain.fdHoldDuration" />
										</td>
										<td width="35%">
											<span id="fdHoldDurationHour"></span>
											<bean:message key="date.interval.hour" />
											<span id="fdHoldDurationMinSpan"><span id="fdHoldDurationMin"></span>
												<bean:message key="date.interval.minute" />
											</span>
										</td>
									</tr>
									<tr>
										<%-- 会议地点--%>
										<td class="td_normal_title" width=15%>
											<bean:message bundle="km-imeeting" key="kmImeetingSummary.fdPlace" />
										</td>
										<td colspan="3" width="85%">
											<c:out
												value="${kmImeetingSummaryForm.fdPlaceName} ${kmImeetingSummaryForm.fdOtherPlace}">
											</c:out>
										</td>
									</tr>
									<tr>
										<%-- 计划参加人员--%>
										<td class="td_normal_title" width=15%>
											<bean:message bundle="km-imeeting"
												key="kmImeetingSummary.fdPlanAttendPersons" />
										</td>
										<td width="85%" colspan="3" style="word-break:break-all">
											<c:if test="${ not empty kmImeetingSummaryForm.fdPlanAttendPersonNames }">
												<div>
													<span style="vertical-align: top;">
														<c:out value="${kmImeetingSummaryForm.fdPlanAttendPersonNames }">
														</c:out>
													</span>
												</div>
											</c:if>
										</td>
									</tr>
									<tr>
										<%-- 邀请参加人员--%>
										<td class="td_normal_title" width=15%>
											<bean:message bundle="km-imeeting"
												key="kmImeetingSummary.fdPlanInvitePersons" />
										</td>
										<td width="85%" colspan="3" style="word-break:break-all">
											<c:if test="${ not empty kmImeetingSummaryForm.fdPlanInvitePersonNames }">
												<div>
													<span style="vertical-align: top;">
														<c:out value="${kmImeetingSummaryForm.fdPlanInvitePersonNames }">
														</c:out>
													</span>
												</div>
											</c:if>
										</td>
									</tr>
									<tr>
										<!-- 计划列席人员 -->
										<td class="td_normal_title" width=15%>
											<bean:message bundle="km-imeeting"
												key="kmImeetingSummary.fdPlanParticipantPersons" />
										</td>
										<td width="85%" colspan="3" style="word-break:break-all">
											<c:if test="${ not empty kmImeetingSummaryForm.fdPlanParticipantPersonNames }">
												<div>
													<span style="vertical-align: top;">
														<c:out
															value="${kmImeetingSummaryForm.fdPlanParticipantPersonNames }">
														</c:out>
													</span>
												</div>
											</c:if>
										</td>
									</tr>
									<tr>
										<!-- 实际与会人员 -->
										<td class="td_normal_title" width=15%>
											<bean:message bundle="km-imeeting"
												key="kmImeetingSummary.fdActualAttendPersons" />
										</td>
										<td width="85%" colspan="3" style="word-break:break-all">
											<c:if test="${ not empty kmImeetingSummaryForm.fdActualAttendPersonNames }">
												<div>
													<span style="vertical-align: top;">
														<c:out value="${kmImeetingSummaryForm.fdActualAttendPersonNames }">
														</c:out>
													</span>
												</div>
											</c:if>
										</td>
									</tr>
									<tr>
										<%-- 编辑内容--%>
										<td class="td_normal_title" width=15%>
											<bean:message bundle="km-imeeting" key="kmImeetingSummary.docContent" />
										</td>
										<td width=85% colspan="3" id="contentDiv">
											<c:if test="${kmImeetingSummaryForm.fdContentType=='rtf'}">
												<xform:rtf property="docContent"></xform:rtf>
											</c:if>
											<c:if test="${kmImeetingSummaryForm.fdContentType=='word'}">
												<c:import url="/sys/attachment/sys_att_main/sysAttMain_view.jsp" charEncoding="UTF-8">
													<c:param name="fdKey" value="editonline" />
													<c:param name="fdModelName" value="com.landray.kmss.km.imeeting.model.KmImeetingSummary" />
													<c:param name="fdModelId" value="${kmImeetingSummaryForm.fdId }" />
													<c:param name="isShowDownloadCount" value="false" />
													<c:param name="fdForceDisabledOpt" value="true" />
												</c:import>
											</c:if>
										</td>
									</tr>
									<tr>
										<%--相关资料--%>
								 		<td class="td_normal_title" width=15%>
								 			<bean:message bundle="sys-attachment" key="table.sysAttMain"/>
								 		</td>
										<td width="85%" colspan="3" >
											<c:import url="/sys/attachment/sys_att_main/sysAttMain_view.jsp" charEncoding="UTF-8">
												<c:param name="fdKey" value="attachment" />
												<c:param name="fdModelId" value="${kmImeetingSummaryForm.fdId }" />
												<c:param name="fdModelName" value="com.landray.kmss.km.imeeting.model.KmImeetingSummary" />
												<c:param name="fdForceDisabledOpt" value="true" />
												<c:param name="isShowDownloadCount" value="false" />
											</c:import>
										</td>
									</tr>
									<tr>
										<td class="td_normal_title" width=15%>
											<bean:message bundle="km-imeeting" key="kmImeetingSummary.fdNotifyType" />
										</td>
										<td colspan="3">
											<kmss:showNotifyType value="${kmImeetingSummaryForm.fdNotifyType}"></kmss:showNotifyType>
										</td>
									</tr>
									<tr>
										<td class="td_normal_title" width=15%>
											<bean:message bundle="km-imeeting" key="kmImeetingSummary.fdNotifyPerson" />
										</td>
										<td colspan="3">
											<xform:checkbox property="fdNotifyPersonList" value="${notifyPerson}" showStatus="readOnly">
												<xform:enumsDataSource enumsType="kmImeetingSummary_fdNotifyPerson"></xform:enumsDataSource>
											</xform:checkbox>
										</td>
									</tr>
									<tr>
										<%-- 纪要录入人--%>
										<td class="td_normal_title" width=15%>
											<bean:message bundle="km-imeeting" key="kmImeetingSummary.docCreator" />
										</td>
										<td width="35%">
											<html:hidden property="docCreatorId" />
											<html:hidden property="docCreatorName" />
											<c:out value="${kmImeetingSummaryForm.docCreatorName }"></c:out>
										</td>
										<%-- 录入时间--%>
										<td class="td_normal_title" width=15%>
											<bean:message bundle="km-imeeting" key="kmImeetingSummary.docCreateTime" />
										</td>
										<td width="35%">
											<html:hidden property="docCreateTime" />
											<c:out value="${kmImeetingSummaryForm.docCreateTime }"></c:out>
										</td>
									</tr>
								</table>
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
									<c:param name="formName" value="kmImeetingSummaryForm" />
								</c:import>
							</td>
						</tr>
					</table>
				</div>
				<jsp:include page="/km/imeeting/km_imeeting_main/kmImeetingMain_printQrCode.jsp">
					<jsp:param value="kmImeetingSummary" name="qrcodeModelName" />
					<jsp:param value="${kmImeetingSummaryForm.fdId}" name="fdModelId" />
				</jsp:include>
			</div>
		</html:form>
		<script>
			function outputPDF() {
				seajs.use(['lui/jquery', 'lui/export/export'], function($, exp) {
					$("#toolBarDiv").hide();
					exp.exportPdf(document.getElementById('printTable'), {
						title: '${ kmImeetingSummaryForm.fdName }',
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
						title: '${ kmImeetingSummaryForm.fdName }'
					});
				});
			}
		</script>
	</template:replace>
</template:include>
