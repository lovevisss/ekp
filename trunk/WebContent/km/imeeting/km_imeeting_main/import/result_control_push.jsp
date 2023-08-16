<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/sys/ui/jsp/common.jsp"%>
<template:include ref="default.simple" rwd="true">
	<template:replace name="body">
		<style>
			.lui_imeeting_criterions {
			  background: #f7f7f7;
			  padding: 16px 16px 1px;
			  padding-top: 10px;
			}
			.lui_imeeting_criterion_item {
			  overflow: hidden;
			  margin: 10px 0;
			  line-height: 26px;
			}
			.lui_imeeting_criterion_title {
			  width: 80px;
			  text-align: right;
			  float: left;
			  color: #666;
			}
			.lui_imeeting_criterion_selectBox {
			  margin-left: 85px;
			}
			.lui_imeeting_criterion_selectBox ul {
			}
			.lui_imeeting_criterion_selectBox li {
			  list-style: none;
			  display: inline-block;
			  cursor: pointer;
			  padding: 1px 5px;
			  margin-bottom: 5px;
			  border-radius: 3px;
			}
			.lui_imeeting_criterion_selectBox li.lui_imeeting_criterion_dropdown {
			  margin-right: 10px;
			}
			.lui_imeeting_criterion_selectBox li.lui_imeeting_criterion_dropdown span {
			  display: inline-block;
			  height: 26px;
			  line-height: 26px;
			  background: #fff;
			  padding-left: 10px;
			  padding-right: 10px;
			}
			.lui_imeeting_criterion_selectBox .lui_imeeting_criterion_dropdown span {
			}
			.lui_imeeting_criterion_selectBox .lui_imeeting_criterion_selectItem {
			  margin-right: 15px;
			}
			
			.sclpitl_item_active {
			  border: 1px solid;
			}

			.lui_result_tb {
				padding-top:10px;
				overflow:auto;
			}
			
			.lui_result_tb th {
			  background: #f7f7f7;
			  border: 1px solid #dfdfdf;
			  white-space: nowrap;
			  line-height: 20px;
			  font-weight: normal;
			  color: #354052;
			  padding-top: 10px;
			  padding-bottom: 10px;
			  padding-left: 10px;
			  padding-right: 10px;
			}
			
			.lui_result_tb td {
			  padding: 10px;
			  border: 1px solid #dfdfdf;
			  font-size: 12px;
			  min-width: 50px;
			  color:#666666;
			}
		</style>
		<div>
			<ui:dataview>
				<ui:source type="Static">
					[
						{text:'${ lfn:message('km-imeeting:km_imeeting_push_type_01') }', value:'01'},
						{text:'${ lfn:message('km-imeeting:km_imeeting_push_type_02') }', value:'02'},
						{text:'${ lfn:message('km-imeeting:km_imeeting_push_type_03') }', value:'03'},
						{text:'${ lfn:message('km-imeeting:km_imeeting_push_type_04') }', value:'04'},
						{text:'${ lfn:message('km-imeeting:km_imeeting_push_type_05') }', value:'05'},
						{text:'${ lfn:message('km-imeeting:km_imeeting_push_type_06') }', value:'06'},
						{text:'${ lfn:message('km-imeeting:km_imeeting_push_type_07') }', value:'07'},
						{text:'${ lfn:message('km-imeeting:km_imeeting_push_type_08') }', value:'08'},
						{text:'${ lfn:message('km-imeeting:km_imeeting_push_type_09') }', value:'09'},
						{text:'${ lfn:message('km-imeeting:km_imeeting_push_type_10') }', value:'10'},
						{text:'${ lfn:message('km-imeeting:km_imeeting_push_type_11') }', value:'11'}
					]
				</ui:source>
				<ui:render type="Template">
					<c:import url="/km/imeeting/km_imeeting_main/import/criteria_push.jsp" charEncoding="UTF-8"></c:import>
				</ui:render>
				<ui:event event="load">
					var firstPush = document.getElementById("firstPush");
					if (firstPush) {
						firstPush.click();
					}
				</ui:event>
		    </ui:dataview>
			
			<list:listview id="listview">
				<ui:source type="AjaxJson">
				</ui:source>
				<list:colTable isDefault="true" layout="sys.ui.listview.columntable" name="columntable">
					<list:col-auto props="userName;msgType;sendTime;sendStatus;receiveTime;responseTime;responseStatus;errorDesc"></list:col-auto>
				</list:colTable>
				<ui:event topic="list.loaded">  
				   seajs.use(['lui/jquery'],function($){
						if(window.frameElement!=null && window.frameElement.tagName=="IFRAME"){
							if($(document.body).height() > 0){
								window.frameElement.style.height =  $(document.body).height() + 10 + "px";
							}
						}
					});
			</ui:event>
			</list:listview>
			<div style="height: 10px;"></div>
			<list:paging layout="sys.ui.paging.simple"></list:paging>
			<script>
				function pushChange(val,node){
					var newSrc = "/km/imeeting/km_imeeting_main/kmImeetingMain.do?method=getControlResult&fdMainId=${JsParam.fdId}&fdType=2&fdPushType=" + val;
					LUI("listview").source.setUrl(newSrc);
					LUI("listview").source.get();
					$(node).addClass('sclpitl_item_active lui_text_primary').siblings().removeClass('sclpitl_item_active lui_text_primary');
				}
			</script>
		</div>
	</template:replace>
</template:include>