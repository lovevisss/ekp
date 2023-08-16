<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/sys/ui/jsp/common.jsp"%>
<template:include file="/sys/profile/resource/template/list.jsp">
	<template:replace name="content">
		<!-- 筛选器 -->
		<list:criteria id="criteria">
		     <list:cri-ref key="fdName" ref="criterion.sys.docSubject" title="${lfn:message('km-imissive:kmImissiveReceiveTemplate.fdName') }">
			</list:cri-ref>
			<%-- 搜索条件:是否有效 --%>
			<list:cri-criterion title="${ lfn:message('km-imissive:kmImissiveReg.fdStatus')}" key="fdIsAvailable" multi="false" >
				<list:box-select>
					<list:item-select cfg-defaultValue="1">
						<ui:source type="Static">
							[{text:'${ lfn:message('km-imissive:kmImissiveTemplate.fdIsAvailable.true')}', value:'1'},
							{text:'${ lfn:message('km-imissive:kmImissiveTemplate.fdIsAvailable.false')}',value:'0'}]
						</ui:source>
					</list:item-select>
				</list:box-select>
			</list:cri-criterion>
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
						    <list:sort property="fdOrder" text="${lfn:message('km-imissive:kmImissiveReceiveTemplate.fdOrder') }" group="sort.list" value="up"></list:sort>
							<list:sort property="docCreateTime" text="${lfn:message('km-imissive:kmImissiveReceiveTemplate.docCreateTime') }" group="sort.list" ></list:sort>
							<list:sort property="fdName" text="${lfn:message('km-imissive:kmImissiveReceiveTemplate.fdName') }" group="sort.list"></list:sort>
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
					<ui:toolbar id="Btntoolbar" count="2">
					    <kmss:auth requestURL="/km/imissive/km_imissive_receive_template/kmImissiveReceiveTemplate.do?method=save&fdCategoryId=${param.parentId}" requestMethod="GET">
							<ui:button text="${lfn:message('button.add')}"  onclick="add();" order="1" ></ui:button>
						</kmss:auth>
						<kmss:auth requestURL="/km/imissive/km_imissive_receive_template/kmImissiveReceiveTemplate.do?method=deleteall&parentId=${param.parentId}" requestMethod="GET">
							<ui:button text="${lfn:message('button.deleteall')}" onclick="deleteAll();" order="2" ></ui:button>
						</kmss:auth>
						<c:import url="/sys/right/cchange_tmp_right/cchange_tmp_right_button_new.jsp" charEncoding="UTF-8">
							<c:param name="mainModelName" value="com.landray.kmss.km.imissive.model.KmImissiveReceiveMain" />
							<c:param name="tmpModelName" value="com.landray.kmss.km.imissive.model.KmImissiveReceiveTemplate" />
							<c:param name="templateName" value="fdTemplate" />
							<c:param name="categoryId" value="${param.parentId}"/>
							<c:param name="authReaderNoteFlag" value="2" />
						</c:import>
						<c:import url="/sys/workflow/import/sysWfTemplate_auditorBtn.jsp" charEncoding="UTF-8">
							<c:param name="fdModelName" value="com.landray.kmss.km.imissive.model.KmImissiveReceiveTemplate"/>
							<c:param name="cateid" value="${param.parentId}"/>
						</c:import>
						<kmss:auth requestURL="/km/imissive/km_imissive_receive_template/kmImissiveReceiveTemplate.do?method=deleteall&parentId=${param.parentId}" requestMethod="GET">
							<!-- 快速排序 -->
							<c:import url="/sys/profile/common/change_order_num.jsp" charEncoding="UTF-8">
								<c:param name="modelName" value="com.landray.kmss.km.imissive.model.KmImissiveReceiveTemplate"></c:param>
								<c:param name="property" value="fdOrder"></c:param>
							</c:import>
						</kmss:auth>
						<c:import url="/sys/xform/lang/include/sysFormCommonMultiLang_button_new.jsp" charEncoding="UTF-8">
							<c:param name="fdModelName" value="com.landray.kmss.km.imissive.model.KmImissiveReceiveTemplate" />
							<c:param name="isCommonTemplate" value ="false"/>
						</c:import>
					</ui:toolbar>
				</div>
			</div>
		</div>
		<ui:fixed elem=".lui_list_operation"></ui:fixed>
		<!-- 内容列表 -->
		<list:listview>
			<ui:source type="AjaxJson">
				{url:'/km/imissive/km_imissive_receive_template/kmImissiveReceiveTemplate.do?method=listChildren&parentId=${param.parentId}&ower=1'}
			</ui:source>
			<list:colTable isDefault="true" layout="sys.ui.listview.columntable" 
			    rowHref="/km/imissive/km_imissive_receive_template/kmImissiveReceiveTemplate.do?method=view&fdId=!{fdId}">
				<list:col-checkbox></list:col-checkbox>
				
				<list:col-auto props="fdOrder,fdName,fdIsAvailable,docCreator.fdName,docCreateTime,operations"></list:col-auto>
			</list:colTable>
		</list:listview>
		<br>
		<!-- 分页 -->
	 	<list:paging/>
	 	
	 	<script type="text/javascript">
		 	seajs.use(['lui/jquery', 'lui/dialog', 'lui/topic'], function($, dialog, topic) {
		 		// 新建收文
		 		window.addDoc = function(fdId) {
		 			Com_OpenWindow('<c:url value="/km/imissive/km_imissive_receive_main/kmImissiveReceiveMain.do" />?method=add&fdTemplateId='+fdId);
		 		};
			 	// 增加
		 		window.add = function() {
		 			Com_OpenWindow('<c:url value="/km/imissive/km_imissive_receive_template/kmImissiveReceiveTemplate.do" />?method=add&parentId=${param.parentId}');
		 		};
		 	    // 编辑
		 		window.edit = function(id) {
			 		if(id)
		 				Com_OpenWindow('<c:url value="/km/imissive/km_imissive_receive_template/kmImissiveReceiveTemplate.do" />?method=edit&fdId=' + id);
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
					var url = '<c:url value="/km/imissive/km_imissive_receive_template/kmImissiveReceiveTemplate.do?method=deleteall"/>';
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
				// 监听新建更新等成功后刷新
				topic.subscribe('successReloadPage', function() {
					topic.publish('list.refresh');
				});
		 	});
	 	</script>
	</template:replace>
</template:include>
