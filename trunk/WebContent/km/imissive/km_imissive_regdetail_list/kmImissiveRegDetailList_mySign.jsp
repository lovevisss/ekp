<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="/sys/ui/jsp/common.jsp"%>
<template:include ref="default.simple" sidebar="no" rwd="true">
	<template:replace name="body">
<script>
seajs.use(['theme!form','theme!list']);
</script>
<div>
     <list:criteria id="regDetailCriteria" cfg-canExpand="false">
      		<list:tab-criterion title="" key="fdStatus">
				<list:box-select>
					<list:item-select type="lui/criteria/select_panel!TabCriterionSelectDatas">
						<ui:source type="Static">
							[{text:'${ lfn:message('km-imissive:status.noOpen') }', value:'0'},
							{text:'${ lfn:message('km-imissive:status.waitSign') }',value:'1'},
							{text:'${ lfn:message('km-imissive:status.signed') }',value:'2'}]
						</ui:source>
					</list:item-select>
				</list:box-select>
		  </list:tab-criterion>
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
			</div>
	   </div>
	<ui:fixed elem=".lui_list_operation"></ui:fixed>
	<list:listview id="listview">
		<ui:source type="AjaxJson">
				{url:'/km/imissive/km_imissive_regdetail_list/kmImissiveRegDetailList.do?method=list&owner=true&mySign=true&q.j_path=${JsParam.path}'}
		</ui:source>
		<list:colTable isDefault="false" layout="sys.ui.listview.columntable" 
				rowHref="/km/imissive/km_imissive_regdetail_list/kmImissiveRegDetailList.do?method=view&fdId=!{fdId}"  name="columntable">
				<%-- <list:col-checkbox></list:col-checkbox> --%>
				<list:col-serial></list:col-serial>
				<list:col-auto props=""></list:col-auto>
		</list:colTable>
	</list:listview> 
</div>
<script type="text/javascript">
			seajs.use(['lui/jquery','lui/topic'], function($, topic) {
				window.pageResize=function(){
					if(parent.document.all("mainIframe")){
						parent.document.all("mainIframe").style.height=(document.body.offsetHeight+50)+'px';
					}
				};
				topic.subscribe('list.loaded', function() {
					setTimeout(pageResize, 100);
				});
		    });
</script>
</template:replace>
</template:include>