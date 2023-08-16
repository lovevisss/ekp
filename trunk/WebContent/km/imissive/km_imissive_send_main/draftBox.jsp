<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="/sys/ui/jsp/common.jsp"%>
<%@ page import="com.landray.kmss.util.UserUtil"%>
<link type="text/css" rel="stylesheet" href="${LUI_ContextPath}/sys/profile/resource/css/operations.css?s_cache=${LUI_Cache}"/>
		<div class="lui_list_operation">
			<!-- 全选 -->
			<%-- <div class="lui_list_operation_order_btn">
				<list:selectall></list:selectall>
			</div> --%>
			<!-- 分割线 -->
			<!-- <div class="lui_list_operation_line"></div> -->
			<!-- 排序 -->
			<div class="lui_list_operation_sort_btn">
				<div class="lui_list_operation_order_text">
					${ lfn:message('list.orderType') }：
				</div>
				<div class="lui_list_operation_sort_toolbar">
				<ui:toolbar layout="sys.ui.toolbar.sort" style="float:left" >
					<list:sort property="docCreateTime" text="${lfn:message('km-imissive:kmImissiveSendMain.docCreateTime')}" group="sort.list" value="down"></list:sort>
				</ui:toolbar>
				</div>
			</div>
			<!-- 分页 -->
			<div class="lui_list_operation_page_top">	
				<list:paging layout="sys.ui.paging.top" > 		
				</list:paging>
			</div>
		</div>
		<ui:fixed elem=".lui_list_operation"></ui:fixed>
		<list:listview id="listview_send">
			<ui:source type="AjaxJson">
					{url:'/km/imissive/km_imissive_send_main/kmImissiveSendMain.do?method=listChildren&forwardStr=draftlist&q.docStatus=10&q.j_path=${JsParam.j_path}'}
			</ui:source>
			<list:colTable url="${LUI_ContextPath }/sys/profile/listShow/sys_listShow/sysListShow.do?method=getSort&modelName=com.landray.kmss.km.imissive.model.KmImissiveSendMain" isDefault="false" layout="sys.ui.listview.columntable" 
				rowHref="/km/imissive/km_imissive_send_main/kmImissiveSendMain.do?method=view&fdId=!{fdId}"  name="columntable">
				<%-- <list:col-checkbox></list:col-checkbox> --%>
				<list:col-serial></list:col-serial>
				<list:col-auto props=""></list:col-auto>
			</list:colTable>
			<ui:event></ui:event>
		</list:listview> 
	 	<list:paging></list:paging>	 
	 	<script type="text/javascript">

			seajs.use(['lui/jquery','lui/dialog','lui/topic','lui/toolbar'], function($, dialog , topic,toolbar) {
				
				// 监听新建更新等成功后刷新
				topic.subscribe('successReloadPage', function() {
					topic.publish('list.refresh');
				});
				
				//删除
				window.delDoc = function(){
					var values = [];
					$("input[name='List_Selected']:checked").each(function(){
							values.push($(this).val());
						});
					if(values.length==0){
						dialog.alert('<bean:message key="page.noSelect"/>');
						return;
					}
					/* 软删除配置 */
					var url='<c:url value="/km/imissive/km_imissive_send_main/kmImissiveSendMain.do?method=deleteall&draft=true"/>';
					var config = {
						url : url, // 删除数据的URL
						data : $.param({"List_Selected":values},true), // 要删除的数据
						modelName : "com.landray.kmss.km.imissive.model.KmImissiveSendMain"
					};
					// 通用删除方法
					Com_Delete(config, delCallback);
				};
				
				window.deleteDoc = function(fdId){
					var values = [];
						values.push(fdId);
						var url='<c:url value="/km/imissive/km_imissive_send_main/kmImissiveSendMain.do?method=deleteall&draft=true"/>';
					var config = {
						url : url, // 删除数据的URL
						data : $.param({"List_Selected":values},true), // 要删除的数据
						modelName : "com.landray.kmss.km.imissive.model.KmImissiveSendMain" // 主要是判断此文档是否有部署软删除
					};
					// 通用删除方法
					Com_Delete(config, delCallback);
				};
				
				window.delCallback = function(data){
					topic.publish("list.refresh");
					dialog.result(data);
				};
			});
		</script>
	