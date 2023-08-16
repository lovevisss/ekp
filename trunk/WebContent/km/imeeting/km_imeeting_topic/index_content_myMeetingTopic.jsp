<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="/sys/ui/jsp/common.jsp"%>
<%@ page import="com.landray.kmss.util.UserUtil"%>
<template:include ref="default.simple" spa="true">
	<template:replace name="head">
		<link rel="Stylesheet" href="${LUI_ContextPath}/km/imeeting/resource/css/listview.css?s_cache=${MUI_Cache}" />
	</template:replace>
	<template:replace name="body">
		<script type="text/javascript">
			seajs.use(['theme!list']);	
		</script>
	  <list:criteria id="sendCriteria">
	  		 <list:tab-criterion title="" key="docStatus"> 
				<list:box-select>
					<list:item-select  cfg-if="(param['mytopic'] == 'myCreate')" cfg-enable="true" cfg-required="${(JsParam.required==null)?'':(JsParam.required)}" cfg-defaultValue="${(JsParam.defaultValue==null)?'':(JsParam.defaultValue)}" type="lui/criteria/select_panel!TabCriterionSelectDatas">
						<ui:source type="Static">
							[{text:'${ lfn:message('status.draft')}', value:'10'},
							 {text:'${ lfn:message('status.examine')}',value:'20'},
							 {text:'${ lfn:message('km-imeeting:kmImeeting.status.refuse')}',value:'11'},
							 {text:'${ lfn:message('km-imeeting:kmImeeting.status.publish')}',value:'30'}]
						</ui:source>
					</list:item-select>
				</list:box-select>
			</list:tab-criterion>
			<list:tab-criterion title="" key="docStatus">
				<list:box-select>
					<list:item-select cfg-required ="${(JsParam.required==null)?'':(JsParam.required)}" cfg-defaultValue ="${(JsParam.defaultValue==null)?'':(JsParam.defaultValue)}" cfg-enable="true" type="lui/criteria/select_panel!TabCriterionSelectDatas"  cfg-if="(param['mytopic'] == 'myApproved')">
						<ui:source type="Static">
								[
								{text:'${ lfn:message('km-imeeting:kmImeeting.status.refuse')}',value:'11'},
								{text:'${ lfn:message('km-imeeting:kmImeeting.status.publish') }', value:'30'}
								]
						</ui:source>
					</list:item-select>
				</list:box-select>
			</list:tab-criterion>
	        <list:cri-ref key="docSubject" ref="criterion.sys.docSubject">
			</list:cri-ref>
			<list:cri-ref ref="criterion.sys.simpleCategory" key="fdTopicCategory" multi="false" title="${ lfn:message('km-imeeting:kmImeetingTopic.fdTopicCategory') }" expand="false">
			  <list:varParams modelName="com.landray.kmss.km.imeeting.model.KmImeetingTopicCategory"/>
			</list:cri-ref>
			<list:cri-auto modelName="com.landray.kmss.km.imeeting.model.KmImeetingTopic" property="fdChargeUnit,fdReporter,docCreateTime" />
		</list:criteria>
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
								<list:sortgroup>
									<list:sort property="docCreateTime" text="${lfn:message('km-imeeting:kmImeetingTopic.docCreateTime')}" group="sort.list" value="down"></list:sort>
									<list:sort property="docPublishTime" text="${lfn:message('km-imeeting:kmImeetingTopic.docPublishTime')}" group="sort.list"></list:sort>
								    <list:sort property="fdNo" text="${lfn:message('km-imeeting:kmImeetingTopic.fdNo')}" group="sort.list"></list:sort>
							    </list:sortgroup>
							</ui:toolbar>
						</div>
					</div>
					<!-- 分页 -->
					<div class="lui_list_operation_page_top">	
						<list:paging layout="sys.ui.paging.top" > 		
						</list:paging>
					</div>	
					<div style="float:right">
						<div style="display: inline-block;vertical-align: middle;"> 
						<ui:toolbar count="3" id="Btntoolbar">
							<ui:button text="${lfn:message('button.add')}" onclick="addDoc()" order="1"></ui:button>	
						</ui:toolbar>
				  </div>
			</div>
		</div>
		<ui:fixed elem=".lui_list_operation"></ui:fixed>
		<list:listview id="listview_send">
			<ui:source type="AjaxJson">
					{url:'/km/imeeting/km_imeeting_topic/kmImeetingTopic.do?method=list'}
			</ui:source>
			<list:colTable url="${LUI_ContextPath }/sys/profile/listShow/sys_listShow/sysListShow.do?method=getSort&modelName=com.landray.kmss.km.imeeting.model.KmImeetingTopic"  isDefault="false" layout="sys.ui.listview.columntable" 
				rowHref="/km/imeeting/km_imeeting_topic/kmImeetingTopic.do?method=view&fdId=!{fdId}"  name="columntable">
				<list:col-checkbox></list:col-checkbox>
				<list:col-serial></list:col-serial>
				<list:col-auto props=""></list:col-auto>
			</list:colTable>
		</list:listview> 
	 	<list:paging></list:paging>	 
	 	<script type="text/javascript">
	 	var SYS_SEARCH_MODEL_NAME ="com.landray.kmss.km.imeeting.model.KmImeetingMain;com.landray.kmss.km.imeeting.model.KmImeetingSummary";
		
		seajs.use(['lui/jquery', 'lui/util/str', 'lui/dialog','lui/topic','lui/toolbar'], function($, strutil, dialog , topic ,toolbar) {
	 	//新建
			window.addDoc = function() {
					dialog.simpleCategoryForNewFile(
							'com.landray.kmss.km.imeeting.model.KmImeetingTopicCategory',
							'/km/imeeting/km_imeeting_topic/kmImeetingTopic.do?method=add&fdTemplateId=!{id}',false,null,null,null);
			};
		});
		</script>
	</template:replace>	 
</template:include>