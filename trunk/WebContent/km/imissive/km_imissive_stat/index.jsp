<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="/sys/ui/jsp/common.jsp"%>
<template:include ref="default.simple" spa="true">
	<template:replace name="body">
	<script type="text/javascript">
		seajs.use(['theme!list']);	
	</script>
	<%--右侧--%>
		<script type="text/javascript">
		Com_IncludeFile("data.js");
		 	seajs.use(['lui/jquery','lui/dialog','lui/topic','lui/toolbar','lui/spa/const'], function($, dialog , topic,toolbar, spaConst) {
				
		 		topic.subscribe(spaConst.SPA_CHANGE_VALUES, function(evt) {
					if(LUI('add')&&evt.value['type'] != null){
						 LUI('toolbar').removeButton(LUI('add'));
						var btn=toolbar.buildButton({text:'${lfn:message("km-imissive:kmImissiveStat.analyze.create.button")}',id:'add',click:'addAnalyze("'+evt.value.type+'")',order:'2'});
						 LUI('toolbar').addButton(btn);
					}
				});
		 		// 监听新建更新等成功后刷新
				topic.subscribe('successReloadPage', function() {
					topic.publish('list.refresh');
				});
				
		 		//新建
				window.addAnalyze = function(type) {
					window.open('${LUI_ContextPath}/km/imissive/km_imissive_stat/kmImissiveStat.do?method=add&type='+type);
				};
				
				//删除
				window.delAnalyze = function(){
					var values = [];
					$("input[name='List_Selected']:checked").each(function(){
							values.push($(this).val());
						});
					if(values.length==0){
						dialog.alert('<bean:message key="page.noSelect"/>');
						return;
					}
					dialog.confirm('<bean:message key="page.comfirmDelete"/>',function(value){
						if(value==true){
							window.delAnalyze_load = dialog.loading();
							$.post('<c:url value="/km/imissive/km_imissive_stat/kmImissiveStat.do?method=deleteall"/>',
									$.param({"List_Selected":values},true),delAnalyzeCallback,'json');
						}
					});
				};
				
				window.doSearchAction = function(evt){
					var topicEvent = {
							criterions : [],
							query : []
						};
					var obj = {};
					var values = [];
					values.push(evt.searchText);
					obj.key = "docSubject";
					obj.value = values;
					topicEvent.criterions.push(obj);
					var j_path_value="/preview";
					var obj2 = {};
					var values2 = [];
					values2.push(j_path_value);
					obj2.key = "j_path";
					obj2.value = values2;
					topicEvent.criterions.push(obj2);
					topic.publish("criteria.changed", topicEvent);
				}
				
				//删除回调函数
				window.delAnalyzeCallback = function(data){
					if(window.delAnalyze_load!=null)
						window.delAnalyze_load.hide();
					if(data!=null && data.status==true){
						topic.publish("list.refresh");
						dialog.success('<bean:message key="return.optSuccess" />');
					}else{
						dialog.failure('<bean:message key="return.optFailure" />');
					}
				};
			 });
	 	</script>	
		
		<%--操作栏--%>
		<div class="lui_list_operation">
			<div style="float:left">
				<div style="display: inline-block;vertical-align: middle;">
					<ui:toolbar id="toolbar" count="2">
						<%--新建--%>
						<kmss:auth requestURL="/km/imissive/km_imissive_stat/kmImissiveStat.do?method=add" requestMethod="GET">
							<ui:button id="add" text="${lfn:message('km-imissive:kmImissiveStat.analyze.create.button')}" onclick="addAnalyze('1')" order="2"></ui:button>	
						</kmss:auth>
						<%--删除--%>
						<kmss:auth requestURL="/km/imissive/km_imissive_stat/kmImissiveStat.do?method=deleteall" requestMethod="GET">						
							<ui:button text="${lfn:message('button.deleteall')}" onclick="delAnalyze()" order="4"></ui:button>
						</kmss:auth>
					</ui:toolbar>
				</div>
			</div>
			<div class="gkp_list_operation_item_r"> 
				<div data-lui-type="lui/search_box_new!SearchBox" class="searchBox">
					<script type="text/config">
					{
						placeholder: "请输入标题",
						width: '200px'
					}
				</script>
					<ui:event event="search.changed" args="evt">
						doSearchAction(evt);
					</ui:event>
				</div>
			</div>
		</div>		
		<ui:fixed elem=".lui_list_operation"></ui:fixed>
		<%--list视图--%>
		<list:listview id="listview">
			<ui:source type="AjaxJson">
				{url:'/km/imissive/km_imissive_stat/kmImissiveStat.do?method=list'}
			</ui:source>
			<%--列表形式--%>
			<list:colTable url="${LUI_ContextPath }/sys/profile/listShow/sys_listShow/sysListShow.do?method=getSort&modelName=com.landray.kmss.km.imissive.model.KmImissiveStat" isDefault="false" layout="sys.ui.listview.columntable" 
				rowHref="/km/imissive/km_imissive_stat/kmImissiveStat.do?method=view&fdId=!{fdId}&type=!{fdAnalyzeType}"  name="columntable">
				<list:col-checkbox></list:col-checkbox>
				<list:col-serial></list:col-serial>
				<list:col-auto props="docSubject,fdMainType,fdStartDate,fdEndDate,docCreator.fdName,docCreateTime"></list:col-auto>
			</list:colTable>   
		</list:listview> 
	 	<list:paging cfg-key="${param.contentId}"  id="paging-${param.contentId}"></list:paging>	 
	</template:replace>
</template:include>