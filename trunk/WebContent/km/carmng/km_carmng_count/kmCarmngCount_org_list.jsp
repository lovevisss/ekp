<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/sys/ui/jsp/common.jsp"%>
<template:include ref="default.simple">
	<template:replace name="body">
		<script type="text/javascript">
			seajs.use([ 'theme!form' ]);
		</script>
		<script type="text/javascript" src="../js/tableSort.js"></script>

		<center>
			<html:form action="/km/carmng/km_carmng_user_fee_info/kmCarmngUserFeeInfo.do">
				<ui:tabpanel id="kmCarmngUserFeeInfoCountPanel" layout="sys.ui.tabpanel.list">
					<ui:content id="kmCarmngUserFeeInfoCountContent" title="${param.type eq 'dept' ? lfn:message('km-carmng:kmCarmng.excel.exportCarUseExcel.dept'):lfn:message('km-carmng:kmCarmng.excel.exportCarUseExcel.person') }">
						<div style="padding-top: 20px">
							<c:import
								url="/km/carmng/km_carmng_count/kmCarmngCount_common_query.jsp"
								charEncoding="UTF-8">
								<c:param name="type" value="${param.type }" />
							</c:import>
						</div>
						<div
							style="text-align: center; margin-top: 10px; margin-bottom: 10px">
							<ui:button text="${lfn:message('km-carmng:kmCarmng.button4') }"
								order="1" onclick="loadList();">
							</ui:button>
							&nbsp;&nbsp;
							<ui:button text="${lfn:message('km-carmng:kmCarmng.button3') }"
								order="2" onclick="clear_data();">
							</ui:button>
							&nbsp;&nbsp;
							<ui:button text="${lfn:message('km-carmng:kmCarmng.button1') }"
								order="3" onclick="exportExcel();">
							</ui:button>
						</div>

					</ui:content>
				</ui:tabpanel>
			</html:form>
			<div style="height: 800px;">
				<!-- 列表 -->
				<list:listview id="listview">
					<ui:source type="AjaxJson">
		            	{url:''}
		        	</ui:source>
					<!-- 列表视图 -->
					<list:colTable isDefault="true" layout="sys.ui.listview.listtable"
						name="columntable" onRowClick="loadDetail('!{fdId}','!{fdOrg}');">
						<list:col-serial />
						<list:col-auto />
					</list:colTable>
					<ui:event topic="list.loaded">
						seajs.use(['lui/jquery'], function($) {
							if(window.frameElement != null && window.frameElement.tagName=="IFRAME") {
								window.frameElement.style.height = ($(document.body).height() + 10) + "px";
							}
						});
					</ui:event>
				</list:listview>
				<!-- 翻页 -->
				<list:paging />

				<!-- 明细表-->
				<iframe id="detailIframe" width=100% height="100%" frameborder=0 scrolling=no></iframe>
			</div>
		</center>
		
		<script type="text/javascript">
			Com_IncludeFile("dialog.js|calendar.js", null, "js");
			seajs.use([ 'lui/jquery', 'lui/dialog', 'lui/topic' ], function($, dialog, topic) {
				//设置初始化时间区间显示并显示当前时间区间
				Com_AddEventListener(window, 'load', function() {
					window.chgTimeSelect();
				});

				window.loadList = function() {
					window.chgTimeSelect();
					var type = '${JsParam.type}';
					var timeType = $("input[name='fdTimeType']:checked").val();
					var fdStartDate = $("*[name='fdStartDate_" + timeType + "']").val();
					var fdEndDate = $("*[name='fdEndDate_" + timeType + "']").val();
					var fdDeptIds = "";
					var deptAll = "";
					var fdPersonIds = "";
					if (type == 'dept') {
						fdDeptIds = $("input[name='fdDeptIds']").val();
						deptAll = $("input[name='deptAll']:checked").val();
						if (null == fdDeptIds || fdDeptIds == '') {
							dialog.alert("请选择用车部门！");
							return;
						}
					} else if (type == 'person') {
						fdPersonIds = $("input[name='fdPersonIds']").val();
						if (null == fdPersonIds || fdPersonIds == '') {
							dialog.alert("请选择用车人！");
							return;
						}
					}
					// 动态传参调用统计（并使用POST传参请求）
					var url = '/km/carmng/km_carmng_user_fee_info/kmCarmngUserFeeInfo.do?method=queryOrgCount';
					var source = LUI("listview").source;
					source.params = {
							'type': type,
							'fdDeptIds': fdDeptIds,
							'deptAll': deptAll,
							'fdPersonIds': fdPersonIds,
							'timeType': timeType,
							'fdStartDate': fdStartDate,
							'fdEndDate': fdEndDate
					};
					source.url = url;
					source.ajaxConfig.url = url;
					source._url = url;
					source.get();
				}
				window.exportExcel = function() {
					var type = '${JsParam.type}';
					var timeType = $("input[name='fdTimeType']:checked").val();
					var fdStartDate = $("*[name='fdStartDate_" + timeType + "']").val();
					var fdEndDate = $("*[name='fdEndDate_" + timeType + "']").val();
					var fdDeptIds = "";
					var deptAll = "";
					var fdPersonIds = "";
					if (type == 'dept') {
						fdDeptIds = $("input[name='fdDeptIds']").val();
						deptAll = $("input[name='deptAll']:checked").val();
						if (null == fdDeptIds || fdDeptIds == '') {
							dialog.alert("请选择用车部门！");
							return;
						}
					} else if (type == 'person') {
						fdPersonIds = $("input[name='fdPersonIds']").val();
						if (null == fdPersonIds || fdPersonIds == '') {
							dialog.alert("请选择用车人！");
							return;
						}
					}
					if (fdStartDate && fdEndDate) {
						// 创建下载表单
						var exportForm = $('<form action="${KMSS_Parameter_ContextPath}km/carmng/km_carmng_user_fee_info/kmCarmngUserFeeInfo.do?method=exportQueryOrgCountExcel" method="post"/>');
						exportForm.appendTo("body");
						exportForm.append($("<input type='hidden' name='type' />").val(type));
						exportForm.append($("<input type='hidden' name='fdDeptIds' />").val(fdDeptIds));
						exportForm.append($("<input type='hidden' name='deptAll' />").val(deptAll));
						exportForm.append($("<input type='hidden' name='fdPersonIds' />").val(fdPersonIds));
						exportForm.append($("<input type='hidden' name='timeType' />").val(timeType));
						exportForm.append($("<input type='hidden' name='fdStartDate' />").val(fdStartDate));
						exportForm.append($("<input type='hidden' name='fdEndDate' />").val(fdEndDate));
						// 执行下载
						exportForm.submit();
						// 移除表单
						exportForm.remove();
					}
				}
			});
		</script>
		<script type="text/javascript">
			//加载明细表
			function loadDetail(fdId, fdOrg) {
				var timeType = $("input[name='fdTimeType']:checked").val();
				var fdStartDate = $("*[name='fdStartDate_" + timeType + "']").val();
				var fdEndDate = $("*[name='fdEndDate_" + timeType + "']").val();
				window.__fdOrg = fdOrg;
				document.getElementById("detailIframe").src = '<c:url value="/km/carmng/km_carmng_count/kmCarmngCount_org_detail_listview.jsp" />?fdId=' + fdId
						+ '&type=${JsParam.type}'
						+ '&timeType=' + timeType
						+ '&fdStartDate=' + fdStartDate
						+ '&fdEndDate=' + fdEndDate;
				setIframeHeight();
			}
			function setIframeHeight() {
				var obj = parent.document.getElementById("mainIframe"); //取得父页面IFrame对象 
				var newHeight = parseInt(obj.height) + parseInt(document.getElementById("detailIframe").height);
				if (obj.height < newHeight) {
					obj.height = newHeight; //调整父页面中IFrame的高度为此页面的高度 
				}
				document.getElementById("detailIframe").height = obj.height;
			}
		</script>
	</template:replace>
</template:include>
