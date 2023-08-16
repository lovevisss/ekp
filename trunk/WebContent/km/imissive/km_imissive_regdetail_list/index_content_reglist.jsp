<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="/sys/ui/jsp/common.jsp"%>
<template:include ref="default.simple" spa="true" rwd="true">
	<template:replace name="body">
		<script type="text/javascript">
			seajs.use(['theme!list']);	
		</script>
    <list:criteria id="regDetailCriteria" cfg-canExpand="false" >
      <list:tab-criterion title="" key="fdStatus">
			<list:box-select>
				<list:item-select type="lui/criteria/select_panel!TabCriterionSelectDatas">
					<ui:source type="Static">
						[{text:'${ lfn:message('km-imissive:status.noOpen') }', value:'0'},
						{text:'${ lfn:message('km-imissive:status.waitSign') }', value:'1'},
						{text:'${ lfn:message('km-imissive:status.signed') }', value:'2'},
						{text:'${ lfn:message('km-imissive:status.return') }', value:'3'},
						{text:'${ lfn:message('km-imissive:status.returnDoc') }',value:'4'}]
					</ui:source>
				</list:item-select>
			</list:box-select>
	  </list:tab-criterion>
	  <list:cri-ref key="docSubject" ref="criterion.sys.docSubject"> 
	  </list:cri-ref>
	  <list:cri-criterion title="${ lfn:message('km-imissive:kmImissiveReg.fdRegType') }" key="fdRegType" multi="false">
			<list:box-select>
				<list:item-select>
					<ui:source type="Static">
						[{text:'${ lfn:message('km-imissive:kmImissiveReg.fdRegType.send') }', value:'1'},{text:'${ lfn:message('km-imissive:kmImissiveReg.fdRegType.receive') }',value:'2'}]
					</ui:source>
				</list:item-select>
			</list:box-select>
	</list:cri-criterion>
	</list:criteria>
	<div class="lui_list_operation">
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
			<div class="moreSearchBtn" >
				<a onclick="expanded();">高级搜索</a>
			</div>
		</div>
	</div>
	<ui:fixed elem=".lui_list_operation"></ui:fixed>
	<list:listview id="listview_reglist">
		<ui:source type="AjaxJson">
				{url:'/km/imissive/km_imissive_regdetail_list/kmImissiveRegDetailList.do?method=list&owner=true&q.j_path=${JsParam.path}'}
		</ui:source>
		<list:colTable isDefault="false" layout="sys.ui.listview.columntable" 
			rowHref="/km/imissive/km_imissive_regdetail_list/kmImissiveRegDetailList.do?method=view&fdId=!{fdId}"  name="columntable">
			<%-- <list:col-checkbox></list:col-checkbox> --%>
			<list:col-serial></list:col-serial>
			<list:col-auto props=""></list:col-auto>
		</list:colTable>
	</list:listview> 
 	<list:paging  cfg-key="${param.contentId}"  id="paging-${param.contentId}"  ></list:paging>
 	<script type="text/javascript">
 	  var SYS_SEARCH_MODEL_NAME ="com.landray.kmss.km.imissive.model.KmImissiveRegDetailList";
 	 seajs.use(['lui/jquery','lui/dialog','lui/topic','lui/toolbar'], function($, dialog , topic,toolbar) {
	 	 window.expanded = function(){
	 		
	 		LUI('regDetailCriteria').expandCriterions(!LUI('regDetailCriteria').expand);
	 		
	 	};
	 	
	 	window.doSearchAction = function(evt){
	 		var topicEvent = {
	 				criterions : LUI("regDetailCriteria")._buildCriteriaSelectedValues(),
	 				query : []
	 			};
	 		var obj = {};
			var values = [];
			values.push(evt.searchText);
			obj.key = "docSubject";
			obj.value = values;
			topicEvent.criterions.push(obj);
			var j_path_value="/exchange/myreceive";
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
