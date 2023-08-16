<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="/sys/ui/jsp/common.jsp"%>
<%@page import="java.util.List"%>
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
		<c:out value="${ kmImeetingTopicForm.docSubject } - ${ lfn:message('km-imeeting:module.km.imeeting') }">
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
					$("div[id^=" + obj.id + "Div]").show();;
				} else {
					$("div[id^=" + obj.id + "Div]").hide();
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
		<html:form action="/km/imeeting/km_imeeting_topic/kmImeetingTopic.do">
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
								<c:import url="/sys/xform/include/sysForm_view.jsp" charEncoding="UTF-8">
									<c:param name="formName" value="kmImeetingTopicForm" />
									<c:param name="fdKey" value="mainTopic" />
									<c:param name="messageKey" value="km-imeeting:py.JiBenXinXi" />
									<c:param name="useTab" value="false" />
									<c:param name="isPrint" value="true" />
								</c:import>
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
									<c:param name="formName" value="kmImeetingTopicForm" />
								</c:import>
							</td>
						</tr>
					</table>
				</div>
				<jsp:include page="/km/imeeting/km_imeeting_main/kmImeetingMain_printQrCode.jsp">
					<jsp:param value="kmImeetingTopic" name="qrcodeModelName" />
					<jsp:param value="${kmImeetingTopicForm.fdId}" name="fdModelId" />
				</jsp:include>
			</div>
		</html:form>
		<script>
			function outputPDF() {
				seajs.use(['lui/jquery', 'lui/export/export'], function($, exp) {
					$("#toolBarDiv").hide();
					exp.exportPdf(document.getElementById('printTable'), {
						title: '${ kmImeetingTopicForm.docSubject }',
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
						title: '${ kmImeetingTopicForm.docSubject }'
					});
				});
			}
		</script>
	</template:replace>
</template:include>
