<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/sys/ui/jsp/common.jsp"%>

<template:include ref="config.profile.list">
	<template:replace name="title">${ lfn:message('sys-organization:sysOrgElement.org') }</template:replace>
	<template:replace name="content">
		<!-- 筛选器 -->
		<list:criteria id="criteria1">
			<list:cri-ref key="fdSearchName" ref="criterion.sys.docSubject" title="${lfn:message('sys-organization:sysOrgElement.search1') }" style="width: 400px;"></list:cri-ref>
			<list:cri-criterion title="${ lfn:message('sys-property:custom.field.status') }" key="isAvailable"> 
				<list:box-select>
					<list:item-select cfg-defaultValue="true">
						<ui:source type="Static">
							[{text:'${ lfn:message('sys-property:custom.field.status.false') }',value:'false'},
							{text:'${ lfn:message('sys-property:custom.field.status.true') }',value:'true'}]
						</ui:source>
					</list:item-select>
				</list:box-select>
			</list:cri-criterion>
		</list:criteria>
		
		<!-- 操作栏 -->
		<div class="lui_list_operation">
			<!-- 排序 -->
			<div style='color: #979797;float: left;padding-top:1px;'>
				<%@ include file="/sys/organization/sys_org_element_external/sysOrgExternal_common_select.jsp"%>
				${ lfn:message('list.orderType') }：
			</div>
			<div style="float:left">
				<div style="display: inline-block;vertical-align: middle;">
					<ui:toolbar layout="sys.ui.toolbar.sort" style="float:left" >
					<list:sortgroup>
						<list:sort property="fdOrder" text="${lfn:message('sys-organization:sysOrgDept.fdOrder') }" group="sort.list" value="up"></list:sort>
						<list:sort property="fdName" text="${lfn:message('sys-organization:sysOrgElementExternal.fdName') }" group="sort.list"></list:sort>
					</list:sortgroup>
					</ui:toolbar>
				</div>
			</div>
			<!-- mini分页 -->
			<div style="float:left;">	
				<list:paging layout="sys.ui.paging.top" > 		
				</list:paging>
			</div>
			<!-- 操作按钮 -->
			<div style="float:right">
				<div style="display: inline-block;vertical-align: middle;">
					<ui:toolbar id="Btntoolbar" count="5">
						<kmss:auth requestURL="/sys/organization/sys_org_element_external/sysOrgElementExternalDept.do?method=add&parent=${param.parent}">
							<!-- 增加 -->
							<c:choose>
								<c:when test="${'4' ne param.subType && ('1' eq param.nodeType || '2' eq param.subType)}">
									<ui:button text="${lfn:message('sys-organization:sysOrgElementExternal.add')}" onclick="add()" order="1" ></ui:button>
								</c:when>
								<c:otherwise>
									<ui:button text="${lfn:message('sys-organization:sysOrgElementExternal.addSub')}" onclick="addSub()" order="1" ></ui:button>
								</c:otherwise>
							</c:choose>
						</kmss:auth>
						<kmss:auth requestURL="/sys/organization/sys_org_element_external/sysOrgElementExternalDept.do?method=invalidatedAll&cateId=${param.parent}" requestMethod="POST">
							<!-- 所有置为无效 -->
							<ui:button text="${lfn:message('sys-organization:organization.invalidated')}" onclick="invalidatedAll()" order="3" ></ui:button>
						</kmss:auth>
						<kmss:auth requestURL="/sys/organization/sys_org_element_external/sysOrgElementExternalDept.do?method=invalidatedAll&cateId=${param.parent}" requestMethod="POST">
							<!-- 快速排序 -->
							<c:import url="/sys/profile/common/change_order_num.jsp" charEncoding="UTF-8">
								<c:param name="modelName" value="com.landray.kmss.sys.organization.model.SysOrgDept"></c:param>
								<c:param name="property" value="fdOrder"></c:param>
							</c:import>
						</kmss:auth>
					</ui:toolbar>
				</div>
			</div>
		</div>
		<ui:fixed elem=".lui_list_operation"></ui:fixed>
		<!-- 内容列表 -->
		<list:listview cfg-needMinHeight="false">
			<ui:source type="AjaxJson">
				{url:'/sys/organization/sys_org_element_external/sysOrgElementExternalDept.do?method=list&parent=${JsParam.parent}&subType=${JsParam.subType}'}
			</ui:source>
			<list:colTable isDefault="true" layout="sys.ui.listview.columntable" onRowClick="view('!{fdId}', '!{isView}');">
				<list:col-checkbox></list:col-checkbox>
				<list:col-auto></list:col-auto>
			</list:colTable>
			<ui:event topic="list.loaded">
				Dropdown.init();
			</ui:event>
		</list:listview>
		<br>
		<!-- 分页 -->
	 	<list:paging/>
	 	
	 	<script type="text/javascript">
			Com_IncludeFile("dialog.js");
			// 查看
			window.view = function(id, isView) {
				if('true' == isView)
					Com_OpenWindow('<c:url value="/sys/organization/sys_org_element_external/sysOrgElementExternalDept.do" />?method=view&fdId=' + id);
			};
			//新增
			window.addAction = function(parentId){
				Com_OpenWindow('<c:url value="/sys/organization/sys_org_element_external/sysOrgElementExternalDept.do" />?method=add&parent='+parentId);
			}
		 	seajs.use(['lui/jquery', 'lui/dialog', 'lui/topic'], function($, dialog, topic) {
		 		// 监听新建更新等成功后刷新
				topic.subscribe('successReloadPage', function() {
					topic.publish("list.refresh");
				});
				topic.subscribe('list.loaded', function(event) {
					if(event.table && event.table.kvData) {
						for(var i in event.table.kvData) {
							var data = event.table.kvData[i];
							if('true' != data.isView) {
								// 删除多选按钮，移除可点击样式
								$(":checkbox[value='" + data.fdId + "']").remove();
								$("tr[kmss_fdid='" + data.fdId + "']").css("cursor", "");
							}
						}
					}
				});
			 	// 增加组织
		 		window.add = function() {
					var parent = '${JsParam.parent}';
					if(parent){
						Com_OpenWindow('<c:url value="/sys/organization/sys_org_element_external/sysOrgElementExternalDept.do" />?method=add&parent=${JsParam.parent}');
					}else{
						var url = "sysOrgElementExternalService&type=cate&parent=!{value}&allOrg=all";
						// 选择外部组织
						Dialog_Tree(false, null, null, null, url, "${ lfn:message('sys-organization:sysOrgEco.name') }", null, function(result) {
							if(result && result.data && result.data.length > 0) {
								window.addAction(result.data[0].id);
							}
						}, null, null, null, "${ lfn:message('sys-organization:sysOrgElementExternal.selectOrg') }");
					}
				}
				// 增加子组织
				window.addSub = function() {
					var parent = '${JsParam.parent}';
					if(parent && '1'!='${JsParam.nodeType}'){
						Com_OpenWindow('<c:url value="/sys/organization/sys_org_element_external/sysOrgElementExternalDept.do" />?method=add&parent=${JsParam.parent}');
					}else{
						var url = "sysOrgElementExternalService&type=cate&parent=!{value}&cateId=${JsParam.parent}";
						// 选择外部组织
						Dialog_Tree(false, null, null, null, url, "${ lfn:message('sys-organization:sysOrgEco.name') }", null, function(result) {
							if(result && result.data && result.data.length > 0) {
								window.addAction(result.data[0].id);
							}
						}, null, null, null, "${ lfn:message('sys-organization:sysOrgElementExternal.selectOrg') }");
					}
				}
		 		// 编辑
		 		window.edit = function(id) {
			 		if(id)
		 				Com_OpenWindow('<c:url value="/sys/organization/sys_org_element_external/sysOrgElementExternalDept.do" />?method=edit&fdId=' + id);
		 		};
				// 所有置为无效
				window.invalidatedAll = function() {
		 			var values = [];
		 			$("input[name='List_Selected']:checked").each(function() {
						values.push($(this).val());
					});
					if(values.length==0){
						dialog.alert('<bean:message key="page.noSelect"/>');
						return;
					}
					dialog.confirm('<bean:message key="organization.invalidatedAll.comfirm" bundle="sys-organization"/>', function(value) {
						if(value == true) {
							window.del_load = dialog.loading();
							$.ajax({
								url : '<c:url value="/sys/organization/sys_org_element_external/sysOrgElementExternalDept.do?method=invalidatedAll"/>&cateId=${JsParam.parent}',
								type : 'POST',
								data : $.param({"List_Selected" : values}, true),
								dataType : 'json',
								error : function(data) {
									if(window.del_load != null) {
										window.del_load.hide(); 
									}
									if(data.responseJSON.message && data.responseJSON.message.length > 0)
										dialog.alert(data.responseJSON.message[0].msg);
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
				// 置为无效
		 		window.invalidated = function(id) {
					if(!id || id.length==0){
						dialog.alert('<bean:message key="page.noSelect"/>');
						return;
					}
					dialog.confirm('<bean:message key="organization.invalidatedAll.comfirm" bundle="sys-organization"/>', function(value) {
						if(value == true) {
							window.del_load = dialog.loading();
							$.ajax({
								url : '<c:url value="/sys/organization/sys_org_element_external/sysOrgElementExternalDept.do?method=invalidated"/>',
								type : 'GET',
								data : $.param({"fdId" : id}, true),
								dataType : 'json',
								error : function(data) {
									if(window.del_load != null) {
										window.del_load.hide(); 
									}
									if(data.responseJSON.message && data.responseJSON.message.length > 0)
										dialog.alert(data.responseJSON.message[0].msg);
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
				// 查看日志
		 		window.viewLog = function(id, fdName) {
		 			if(id) {
						var url = '<c:url value="/sys/organization/sys_log_organization/index.jsp" />?fdId=' + id;
						url = Com_SetUrlParameter(url, "fdName", encodeURI("${lfn:message('sys-organization:sysOrgElement.dept')}-" + fdName));
		 				Com_OpenWindow(url);
			 		}
			 	};
		 	});
	 	</script>
	</template:replace>
</template:include>
