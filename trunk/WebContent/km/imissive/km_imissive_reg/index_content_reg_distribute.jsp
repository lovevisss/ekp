<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="/sys/ui/jsp/common.jsp"%>
<%@page import="com.landray.kmss.km.imissive.util.KmImissiveConfigUtil"%>
<template:include ref="default.simple" spa="true" rwd="true">
	<template:replace name="body">
		<script type="text/javascript">
			seajs.use(['theme!list']);	
		</script>
  <list:criteria id="regCriteria" multi="false" cfg-canExpand="false">
     <%-- <list:cri-criterion title="${ lfn:message('km-imissive:kmImissiveReg.create.my') }" key="fdDeliverType" multi="false" channel="true" expand="false">
			<list:box-select>
				<list:item-select>
					<ui:source type="Static">
						[{text:'${ lfn:message('km-imissive:kmImissive.tree.mydistribute') }', value:'1'},{text:'${ lfn:message('km-imissive:kmImissive.tree.myreport') }',value:'2'}]
					</ui:source>
				</list:item-select>
			</list:box-select>
		</list:cri-criterion> --%>
	  <%if("poly".equals(KmImissiveConfigUtil.getNavigationMode())){ %>
		  <list:tab-criterion title="" key="fdRegType">
			  <list:box-select>
				  <list:item-select type="lui/criteria/select_panel!TabCriterionSelectDatas" >
					  <ui:source type="Static">
						  [{text:'${ lfn:message('km-imissive:kmImissiveReg.fdRegType.send') }', value:'1'},
						  {text:'${ lfn:message('km-imissive:kmImissiveReg.fdRegType.receive') }',value:'2'}]
					  </ui:source>
				  </list:item-select>
			  </list:box-select>
		  </list:tab-criterion>
	  <%}%>
	</list:criteria>
	  <div class="lui_list_operation">
			<div class="gkp_list_operation_item_l">
				<div style="display: inline-block;vertical-align: middle;">
				<ui:toolbar count="3" id="Btntoolbar">
					<kmss:authShow roles="ROLE_KMIMISSIVE_REG_DELETE">
						<ui:button text="${lfn:message('button.deleteall')}" onclick="delDoc()" order="1"></ui:button> 
					</kmss:authShow>
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
	<list:listview id="listview_reg_distribute"  >
		<ui:source type="AjaxJson">
				{url:'/km/imissive/km_imissive_reg/kmImissiveReg.do?method=list&q.fdDeliverType=1&q.j_path=${JsParam.path}&q.fdRegType=${JsParam.fdRegType}'}
		</ui:source>
		<list:colTable isDefault="false" layout="sys.ui.listview.columntable" 
			rowHref="/km/imissive/km_imissive_reg/kmImissiveReg.do?method=view&fdId=!{fdId}"  name="columntable">
			<list:col-checkbox></list:col-checkbox>
			<list:col-serial></list:col-serial>
			<list:col-auto props=""></list:col-auto>
		</list:colTable>
	</list:listview> 
 	<list:paging cfg-key="${param.contentId}"  id="paging-${param.contentId}" ></list:paging>
 	<script type="text/javascript">
 	var SYS_SEARCH_MODEL_NAME ="com.landray.kmss.km.imissive.model.KmImissiveReg";
 	seajs.use(['lui/jquery','lui/dialog','lui/topic'], function($, dialog , topic) {
			window.delDoc = function(){
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
						window.del_load = dialog.loading();
						$.post('<c:url value="/km/imissive/km_imissive_reg/kmImissiveReg.do?method=deleteall"/>',
								$.param({"List_Selected":values},true),delCallback,'json');
					}
				});
			};
			window.delCallback = function(data){
				if(window.del_load!=null)
					window.del_load.hide();
				if(data!=null && data.status==true){
					topic.publish("list.refresh");
					dialog.success('<bean:message key="return.optSuccess" />');
				}else{
					dialog.failure('<bean:message key="return.optFailure" />');
				}
			};
			window.doSearchAction = function(evt){
	 	 		var topicEvent = {
	 	 				criterions :LUI("regCriteria")._buildCriteriaSelectedValues(),
	 	 				query : []
	 	 			};
	 	 		var obj = {};
				var values = [];
				values.push(evt.searchText);
				obj.key = "fdName";
				obj.value = values;
				topicEvent.criterions.push(obj);
				var j_path_value = "/exchange/mydistribute";
				var obj2 = {};
				var values2 = [];
				values2.push(j_path_value);
				obj2.key = "j_path";
				obj2.value = values2;
				topicEvent.criterions.push(obj2);
				topic.publish("criteria.changed", topicEvent);
	 	 	}
 	});
 	</script>
</template:replace>
</template:include>	
