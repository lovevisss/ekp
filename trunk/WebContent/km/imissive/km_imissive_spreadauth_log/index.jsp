<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="/sys/ui/jsp/common.jsp"%>
<template:include ref="config.profile.list">
	
	<%-- 右边框内容 --%>
	<template:replace name="content">
		<!-- 操作栏 -->
		<div class="lui_list_operation">
			<!-- 全选 -->
			<div class="lui_list_operation_order_btn">
				<list:selectall></list:selectall>
			</div>
			<!-- 分割线 -->
			<div class="lui_list_operation_line"></div>
			<!-- 排序 -->
			<div class="lui_list_operation_sort_btn">
				<div class="lui_list_operation_order_text">
					${ lfn:message('list.orderType') }：
				</div>
				<div class="lui_list_operation_sort_toolbar">
					<ui:toolbar layout="sys.ui.toolbar.sort" style="float:left" >
						<list:sort property="docCreateTime" text="创建时间" group="sort.list" value="down"></list:sort>
					</ui:toolbar>
				</div>
			</div>
			<!-- 分页 -->
			<div class="lui_list_operation_page_top">	
				<list:paging layout="sys.ui.paging.top" > 		
				</list:paging>
			</div>
			<!-- 操作按钮 -->
			<div style="float:right">
				<div style="display: inline-block;vertical-align: middle;">
					<ui:toolbar>
						<ui:button text="${lfn:message('button.deleteall')}" order="1" onclick="delDoc();" style="margin-right:10px"></ui:button>
					</ui:toolbar>
				</div>
			</div>
		</div>
		
		<ui:fixed elem=".lui_list_operation"></ui:fixed>
		<list:listview id="listview">
			<ui:source type="AjaxJson">
				{url:'/km/imissive/km_imissive_spreadauth_log/kmImissiveSpreadAuthLog.do?method=docLogList'}
			</ui:source>
			<%--列表形式--%>
			<list:colTable isDefault="false" layout="sys.ui.listview.columntable" rowHref="!{actionUrl}" name="columntable">
				<list:col-checkbox></list:col-checkbox>
				<list:col-serial></list:col-serial>
				<list:col-auto props=""></list:col-auto>
			</list:colTable>   
		</list:listview> 
		<script type="text/javascript">
		seajs.use(['lui/jquery', 'lui/dialog','lui/topic'], function($, dialog , topic) {
			// 监听新建更新等成功后刷新
			topic.subscribe('successReloadPage', function() {
				topic.publish("list.refresh");
			});
			
		 	//删除
	 		window.delDoc = function(id){
	 			var values = [];
	 			if(id) {
	 				values.push(id);
		 		} else {
					$("input[name='List_Selected']:checked").each(function() {
						values.push($(this).val());
					});
		 		}
				if(values.length==0){
					dialog.alert('<bean:message key="page.noSelect"/>');
					return;
				}
				var url  = '<c:url value="/km/imissive/km_imissive_spreadauth_log/kmImissiveSpreadAuthLog.do?method=deleteall"/>';
				dialog.confirm('<bean:message key="page.comfirmDelete"/>', function(value) {
					if(value == true) {
						console.log(values);
						window.del_load = dialog.loading();
						$.ajax({
							url : url,
							type : 'POST',
							data : $.param({"List_Selected" : values}, true),
							dataType : 'json',
							error : function(data) {
								if(window.del_load != null) {
									window.del_load.hide(); 
								}
								dialog.result(data.responseJSON);
							},
							success: function(data) {
								if(window.del_load != null){
									window.del_load.hide(); 
									topic.publish("list.refresh");
								}
								dialog.result(data);
							}
					   });
					}
				});
			};
	 	});
		</script>
		<br>
	 	<list:paging></list:paging>
	</template:replace>
</template:include>