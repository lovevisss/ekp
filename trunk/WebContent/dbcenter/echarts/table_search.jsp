﻿<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/sys/ui/jsp/common.jsp"%>
<template:include file="/sys/profile/resource/template/list.jsp">
	<template:replace name="content">
		<!-- 筛选器 -->
		<list:criteria id="criteria">
		     <list:cri-ref key="docSubject" ref="criterion.sys.docSubject" title="${lfn:message('dbcenter-echarts:dbEchartsTable.docSubject') }">
			</list:cri-ref>
			<list:cri-auto modelName="com.landray.kmss.dbcenter.echarts.model.DbEchartsTable" 
				property="dbEchartsTemplate" />
		</list:criteria>
		<!-- 操作栏 -->
		<div class="lui_list_operation">
			<!-- 排序 -->
			<div style='color: #979797;float: left;padding-top:1px;'>
				${ lfn:message('list.orderType') }：
			</div>
			<div style="float:left">
				<div style="display: inline-block;vertical-align: middle;">
					<ui:toolbar layout="sys.ui.toolbar.sort" style="float:left" >
					   <list:sort property="docCreateTime" text="${lfn:message('dbcenter-echarts:dbEchartsTable.docCreateTime') }" group="sort.list"></list:sort>
					</ui:toolbar>
				</div>
			</div>
			<div style="float:left;">	
				<list:paging layout="sys.ui.paging.top" > 		
				</list:paging>
			</div>
			<!-- 操作按钮 -->
			<div style="float:right">
				<div style="display: inline-block;vertical-align: middle;">
					<ui:toolbar id="Btntoolbar">
						<kmss:auth requestURL="/dbcenter/echarts/db_echarts_table/dbEchartsTable.do?method=add">
							<ui:button text="${ lfn:message('button.add') }" 
								onclick="add();">
							</ui:button>
						</kmss:auth>
						<kmss:auth requestURL="/dbcenter/echarts/db_echarts_table/dbEchartsTable.do?method=deleteall">
							<ui:button text="${ lfn:message('button.deleteall') }"
								onclick="deleteAll();">
							</ui:button>
						</kmss:auth>		
					</ui:toolbar>	
				</div>
			</div>
		</div>
		<ui:fixed elem=".lui_list_operation"></ui:fixed>
		<!-- 内容列表 -->
		<list:listview>
			<ui:source type="AjaxJson">
				{url:'/dbcenter/echarts/db_echarts_table/dbEchartsTable.do?method=list'}
			</ui:source>
			<list:colTable isDefault="true" layout="sys.ui.listview.columntable" 
			     rowHref="/dbcenter/echarts/db_echarts_table/dbEchartsTable.do?method=view&fdId=!{fdId}&chartDefault=1">
				<list:col-checkbox></list:col-checkbox>
				<list:col-serial></list:col-serial>
				<list:col-auto props="docSubject,docCreateTime,docCreator.fdName,operations"></list:col-auto>
			</list:colTable>
		</list:listview>
		<br>
		<!-- 分页 -->
	 	<list:paging/>
	 	<script type="text/javascript">
		 	seajs.use(['lui/jquery', 'lui/dialog', 'lui/topic'], function($, dialog, topic) {
		 		
		 		window.add = function(){
		 			var url = "/dbcenter/echarts/db_echarts_table/dbEchartsTable_mode.jsp?fdTemplateId=${JsParam.categoryId}";
		 			var height = "455";
					var width = "600";
		 			dialog.iframe(url,"选择模式",null,{width:width,height : height});
		 		}
		 		
		 		window.edit = function(id){
					if(id){
						Com_OpenWindow('db_echarts_table/dbEchartsTable.do?method=edit&fdId='+id);
					}
			 	};
		 		
		 		window.deleteAll = function(id){
					var values = [];
					if(id){
						values.push(id);
					}else{
					    $("input[name='List_Selected']:checked").each(function(){
							values.push($(this).val());
						});
					}
					if(values.length==0){
						dialog.alert('<bean:message key="page.noSelect"/>');
						return;
					}
					dialog.confirm('<bean:message key="page.comfirmDelete"/>',function(value){
						if(value==true){
							window.del_load = dialog.loading();
							$.post('<c:url value="/dbcenter/echarts/db_echarts_table/dbEchartsTable.do?method=deleteall"/>',
									$.param({"List_Selected":values},true),delCallback,'json');
						}
					});
				};
				window.delCallback = function(data){
					if(window.del_load!=null){
						window.del_load.hide();
					}
					topic.publish("list.refresh");
					dialog.result(data);
				};
		 	});
	 	</script>
	</template:replace>
</template:include>
