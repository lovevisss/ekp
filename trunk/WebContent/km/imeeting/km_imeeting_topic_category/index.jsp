<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/sys/ui/jsp/common.jsp"%>
<template:include file="/sys/profile/resource/template/list.jsp">
	<template:replace name="content">
		<!-- 筛选器 -->
		<list:criteria id="criteria">
			<list:cri-ref style="width:145px;" key="fdName" ref="criterion.sys.docSubject" title="${lfn:message('km-imeeting:kmImeetingTemplate.fdName') }"></list:cri-ref>
			<list:cri-ref ref="criterion.sys.category" key="docCategory" multi="false" title="${lfn:message('sys-category:menu.sysCategory.index') }" expand="true">
			  <list:varParams modelName="com.landray.kmss.km.imeeting.model.KmImeetingTopicCategory"/>
			  <list:varParams showTemp="false"/>
			</list:cri-ref>
		</list:criteria>
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
						<list:sortgroup>
							<list:sort property="fdOrder" text="${lfn:message('km-imeeting:kmImeetingTopicCategory.fdOrder') }" group="sort.list" value="up"></list:sort>
							<list:sort property="docCreateTime" text="${lfn:message('km-imeeting:kmImeetingTopicCategory.docCreateTime') }" group="sort.list"></list:sort>
						</list:sortgroup>
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
					<ui:toolbar id="toolbar">
						<kmss:auth requestURL="/km/imeeting/km_imeeting_topic_category/kmImeetingTopicCategory.do?method=add">
						    <ui:button text="${lfn:message('button.add')}" onclick="add();" order="1" ></ui:button>
						</kmss:auth>
						<kmss:auth requestURL="/km/imeeting/km_imeeting_topic_category/kmImeetingTopicCategory.do?method=deleteall&parentId=${JsParam.parentId}">
						    <ui:button id="del" text="${lfn:message('button.deleteall')}" onclick="deleteAll();" order="2" ></ui:button>
						    <!-- 快速排序 -->
							<c:import url="/sys/profile/common/change_order_num.jsp" charEncoding="UTF-8">
								<c:param name="modelName" value="com.landray.kmss.km.imeeting.model.KmImeetingTopicCategory"></c:param>
								<c:param name="property" value="fdOrder"></c:param>
							</c:import>
						</kmss:auth>
					</ui:toolbar>
				</div>
			</div>
		</div>
	
		<ui:fixed elem=".lui_list_operation"></ui:fixed>
		
		<!-- 内容列表 -->
		<list:listview>
			<ui:source type="AjaxJson">
				{url:'/km/imeeting/km_imeeting_topic_category/kmImeetingTopicCategory.do?method=listChildren&parentId=${JsParam.parentId}&contentType=json'}
			</ui:source>
			<list:colTable isDefault="true" layout="sys.ui.listview.columntable"
				rowHref="/km/imeeting/km_imeeting_topic_category/kmImeetingTopicCategory.do?method=view&fdId=!{fdId}" name="columntable">
				<list:col-checkbox></list:col-checkbox>
				<list:col-auto props="fdOrder,fdName,docCategory.fdName,docCreator.fdName,docCreateTime,operations"></list:col-auto>
			</list:colTable>
		</list:listview>
		<!-- 分页 -->
	 	<list:paging/>
	
		<script type="text/javascript">
			seajs.use(['lui/jquery','lui/topic','lui/dialog','lui/toolbar'],function($,topic,dialog,toolbar){
				
				// 监听新建更新等成功后刷新
				topic.subscribe('successReloadPage', function() {
					topic.publish('list.refresh');
				});
				
				//根据筛选器分类异步校验权限
				topic.subscribe('criteria.changed',function(evt){
					if(LUI('del')){ LUI('toolbar').removeButton(LUI('del'));}
					var hasCate = false;
					for(var i=0;i<evt['criterions'].length;i++){
						if(evt['criterions'][i].key=="docCategory"){
							hasCate = true;
		                 	 var cateId= evt['criterions'][i].value[0];
			                 //分类变化或者带有分类刷新
			                 if(getValueByHash("docCategory")!=cateId){
			                	 showButtons(cateId);
			                 }
						}
					}
					//清空模板,校验无分类情况
					if(hasCate == false){
						showButtons("","");
					}
				});
				
				//根据地址获取key对应的筛选值
				function getValueByHash(key){
					var hash = window.location.hash;
	                if(hash.indexOf(key)<0){
	                    return "";
	                }
	            	var url = hash.split("cri.q=")[1];
	  			    var reg = new RegExp("(^|;)"+ key +":([^;]*)(;|$)");
				    var r=url.match(reg);
					if(r!=null){
						return unescape(r[2]);
					}
					return "";
				}
				
				//按钮显示隐藏控制
				function showButtons(parentId){
					var checkDelUrl = "/km/imeeting/km_imeeting_topic_category/kmImeetingTopicCategory.do?method=deleteall&parentId="+parentId;
					var data = [];
					data.push(['del',checkDelUrl]);
					$.ajax({
		       			url: "${LUI_ContextPath}/sys/authorization/SysAuthUrlCheckAction.do?method=checkUrlAuth",
		       			dataType:"json",
		       			type:"post",
		       			data:{"data":LUI.stringify(data)},
		       			async:false,
		       			success: function(rtn){
			       			for(var i=0;i<rtn.length;i++){
				            	if(rtn[i]['del'] == 'true'){
				                	if(LUI('del')){ LUI('toolbar').removeButton(LUI('del'));}
				                 		var delBtn = toolbar.buildButton({id:'del',order:'2',text:'${lfn:message("button.deleteall")}',click:'deleteAll()'});
				    					LUI('toolbar').addButton(delBtn);
				                   	}
			  		            }
		       			  	}
		       		 });
				}
				
				//新建
				window.add = function(){
			 		Com_OpenWindow('<c:url value="/km/imeeting/km_imeeting_topic_category/kmImeetingTopicCategory.do" />?method=add&parentId=${param.parentId}');
				};
				//编辑
		 		window.edit = function(id) {
			 		if(id)
		 				Com_OpenWindow('<c:url value="/km/imeeting/km_imeeting_topic_category/kmImeetingTopicCategory.do" />?method=edit&fdId=' + id);
		 		};
				//删除
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
					var url = '<c:url value="/km/imeeting/km_imeeting_topic_category/kmImeetingTopicCategory.do?method=deleteall"/>';
					dialog.confirm('<bean:message key="page.comfirmDelete"/>',function(value){
						if(value==true){
							window.del_load = dialog.loading();
							
							$.ajax({
								url: url,
								type: 'POST',
								data:$.param({"List_Selected":values},true),
								dataType: 'json',
								error: function(data){
									if(window.del_load!=null){
										window.del_load.hide(); 
									}
									dialog.result(data.responseJSON);
								},
								success: delCallback
						   });
						}
					});
				};
				window.delCallback = function(data){
					if(window.del_load!=null){
						window.del_load.hide();
						topic.publish("list.refresh");
					}
					dialog.result(data);
				};
			});
		</script>
	
	</template:replace>
</template:include>