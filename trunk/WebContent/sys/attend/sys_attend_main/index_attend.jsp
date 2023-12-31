<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="/sys/ui/jsp/common.jsp"%>
<template:include ref="default.simple4list">
	<template:replace name="title">
		<c:out value="${ lfn:message('sys-attend:module.sys.attend') }"></c:out>
	</template:replace>
	<template:replace name="nav">
		<!-- 新建按钮 -->
		<div class="lui_list_noCreate_frame">
			<ui:combin ref="menu.nav.create">
				<ui:varParam name="title" value="${ lfn:message('sys-attend:module.sys.attend') }" />
				<ui:varParam name="button">
					[
						{
							"text": "${ lfn:message('sys-attend:module.sys.attend') }",
							"href": "javascript:void(0)",
							"icon": "lui_icon_l_icon_89"
						}
					]
				</ui:varParam>				
			</ui:combin>
		</div>
		<div class="lui_list_nav_frame">
			<ui:accordionpanel>
			 	<c:import url="/sys/attend/nav.jsp" charEncoding="UTF-8">
				   <c:param name="key" value="sysAttendMain"></c:param>
				   <c:param name="criteria" value="attendMainCriteria"></c:param>
				</c:import>		 
			</ui:accordionpanel>
		</div>
	</template:replace>
	<template:replace name="content">
		<ui:tabpanel layout="sys.ui.tabpanel.list">
			<ui:content title="${ lfn:message('sys-attend:sysAttend.nav.all.record') }">
				<!-- 查询条件  -->
				<list:criteria id="attendMainCriteria" expand="false">
					<list:cri-auto modelName="com.landray.kmss.sys.attend.model.SysAttendMain" property="docCreateTime" />
					<list:cri-ref key="docCreator" ref="criterion.sys.person" multi="false" title="${lfn:message('sys-attend:sysAttendMain.docCreator') }" />
					<list:cri-ref key="docCreatorDept" ref="criterion.sys.dept" multi="false" title="${lfn:message('sys-attend:sysAttendMain.docCreatorDept') }" />
					<list:cri-criterion title="${ lfn:message('sys-attend:sysAttendMain.fdStatus')}" key="fdStatus"> 
						<list:box-select>
							<list:item-select>
								<ui:source type="Static">
									[{text:'${ lfn:message('sys-attend:sysAttendMain.fdStatus.ok')}', value:'1'},
									{text:'${ lfn:message('sys-attend:sysAttendMain.fdOutside')}', value:'11'},
									{text:'${ lfn:message('sys-attend:sysAttendMain.fdStatus.late')}',value:'2'},
									{text:'${ lfn:message('sys-attend:sysAttendMain.fdStatus.left')}',value:'3'},
									{text:'${ lfn:message('sys-attend:sysAttendMain.fdStatus.business')}',value:'4'},
									{text:'${ lfn:message('sys-attend:sysAttendMain.fdStatus.askforleave')}',value:'5'},
									{text:'${ lfn:message('sys-attend:sysAttendMain.fdStatus.outgoing')}',value:'6'}]
								</ui:source>
							</list:item-select>
						</list:box-select>
					</list:cri-criterion>
					<list:cri-ref key="fdCategoryName" ref="criterion.sys.string" title="${ lfn:message('sys-attend:sysAttendCategory.attend') }"></list:cri-ref>
				</list:criteria>
				 
				<!-- 列表工具栏 -->
				<div class="lui_list_operation">
					<div style='color: #979797;float: left;padding-top:1px;'>
						${ lfn:message('list.orderType') }：
					</div>
					<div style="float:left">
						<div style="display: inline-block;vertical-align: middle;">
							<ui:toolbar layout="sys.ui.toolbar.sort" style="float:left" >
								<list:sort property="sysAttendMain.docCreateTime" text="${lfn:message('sys-attend:sysAttendMain.docCreateTime') }" group="sort.list" value="down"></list:sort>
							</ui:toolbar>
						</div>
					</div>
					<div style="float:left;">
						<list:paging layout="sys.ui.paging.top" > 		
						</list:paging>
					</div>
					<div style="float:right">
						<div style="display: inline-block;vertical-align: middle;">
							<ui:toolbar count="3">
								<kmss:auth requestURL="/sys/attend/sys_attend_main/sysAttendMain.do?method=exportRecordExcel">					 								
									<ui:button text="${lfn:message('button.export')}" onclick="exportRecordExcel();" order="2"></ui:button>
								</kmss:auth>
							</ui:toolbar>
						</div>
					</div>
				</div>
				
				<ui:fixed elem=".lui_list_operation"></ui:fixed>
				 
				 
			 	<list:listview id="listview">
					<ui:source type="AjaxJson">
							{url:'/sys/attend/sys_attend_main/sysAttendMain.do?method=list&categoryType=attend&noMissed=true'}
					</ui:source>
					<!-- 列表视图 -->	
					<list:colTable isDefault="false"
						rowHref="/sys/attend/sys_attend_main/sysAttendMain.do?method=view&fdId=!{fdId}"  name="columntable">
<%--						<list:col-checkbox></list:col-checkbox>--%>
						<list:col-serial></list:col-serial>
						<list:col-auto props="docCreator.fdName;docCreateTime;fdSignType;fdLocation;fdAppName;fdCategory.fdName;fdStatus;fdState"></list:col-auto>
					</list:colTable>
				</list:listview> 
				 
			 	<list:paging></list:paging>	
			</ui:content>
		</ui:tabpanel>
		 
	 	
	 	<script>
			seajs.use(['lui/jquery','lui/dialog','lui/topic'], function($, dialog , topic){
				window.exportRecordExcel=function(){
					var listview = LUI('listview'),
						_url = listview.source.url;
					var	__url = '${LUI_ContextPath}/sys/attend/sys_attend_main/sysAttendMain.do?method=exportRecordExcel&cateType=attend' + _url.match(/&.*/);
					// sysAttendMain.docCreateTime
					console.info(__url);
					var paramName ='q.docCreateTime';
					if(__url.indexOf(paramName)==-1){
						dialog.alert('${lfn:message('sys-attend:sysAttendMain.export.tip')}');
						return;
					}
					dialog.confirm('${lfn:message('sys-attend:sysAttendMain.export.tip1')}', function(value) {
						if(value == true) {
							var del_load = dialog.loading();
							var iframe = document.createElement("iframe");
							iframe.src = __url;
							iframe.style.display = 'none';
							document.body.appendChild(iframe);
							setTimeout(function(){
								if(del_load != null){
									del_load.hide();
								}
							}, 0);
						}
					})

				};
				window.switchAttendPage = function(url,hash){
					url = Com_SetUrlParameter(url,'j_iframe','true');
					url = Com_SetUrlParameter(url,'j_aside','false');
					if(hash){
						url = url + hash;
					}
					LUI.pageOpen(url,'_rIframe');
				}
			});
		</script>
	</template:replace>
</template:include>
