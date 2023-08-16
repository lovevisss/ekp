<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="/sys/ui/jsp/common.jsp"%>
<%@ page import="com.landray.kmss.util.UserUtil"%>
<template:include ref="default.list" spa="true">
	<template:replace name="title">
		<c:out value="${ lfn:message('km-imissive:kmImissive.tree.title') }"></c:out>
	</template:replace>
	
	<template:replace name="nav">
		<ui:combin ref="menu.nav.title">
			<ui:varParam name="title" value="${ lfn:message('km-imissive:kmImissive.tree.title') }" />
			<%-- <ui:varParam name="info" >
				<ui:source type="Static">
					[
						{
							"text": "${lfn:message('km-imissive:kmImissive.tree.Send') }",
							"href": "/listAllSend",
							"router" : true,
							"count_url": "/km/imissive/km_imissive_send_main/kmImissiveSendMain.do?method=getCount"
						},
						{
							"text": "${lfn:message('km-imissive:kmImissive.tree.Receive') }",
							"href": "/listAllReceive",
							"router" : true,
							"count_url": "/km/imissive/km_imissive_receive_main/kmImissiveReceiveMain.do?method=getCount"
						},
						{
							"text": "${lfn:message('km-imissive:kmImissive.tree.Sign') }",
							"href": "/listAllSign",
							"router" : true,
							"count_url": "/km/imissive/km_imissive_sign_main/kmImissiveSignMain.do?method=getCount"
						}
					]
				</ui:source>
			</ui:varParam> --%>
			<ui:varParam name="operation">
				<ui:source type="Static">
				[
					{
						"text": "${lfn:message('km-imissive:kmImissive.tree.all') }",
						"href": "/listAll",
						"router" : true,
						"icon": "lui_iconfont_navleft_imissive_depot"
					},
					{
						"text": "${lfn:message('km-imissive:kmImissive.nav.Exchange.all') }",
						"href": "/exchange",
						"router" : true,
						"icon": "lui_iconfont_navleft_imissive_exchange"
					},
					{
						"text": "${lfn:message('km-imissive:kmImissive.nav.Create.my') }",
						"href": "/listCreate",
						"router" : true,
						"icon": "lui_iconfont_navleft_com_my_drafted"
					}
					,
					{
						"text": "${lfn:message('km-imissive:kmImissive.tree.myapproval') }",
						"href": "/listApproval",
						"router" : true,
						"icon": "lui_iconfont_navleft_com_my_beapproval"
					},
					{
						"text": "${lfn:message('km-imissive:kmImissive.tree.myapproved') }",
						"href": "/listApproved",
						"router" : true,
						"icon": "lui_iconfont_navleft_com_my_approvaled"
					}
					
				]
				</ui:source>
			</ui:varParam>				
		</ui:combin>
	<div id="menu_nav" class="lui_list_nav_frame">
	  <ui:accordionpanel>
	  		<ui:content title="${lfn:message('km-imissive:kmImissive.tree.circulation') }" expand="true" >
	  			<ui:combin ref="menu.nav.simple">
	  				<ui:varParam name="source">
	  					<ui:source type="Static">
	  					[
	  					{
							"text": "${lfn:message('km-imissive:workbench.title') }",
							"href": "/myWorkbench",
							"router" : true,
							"icon": "lui_iconfont_navleft_imissive_depot"
						},
						{
							"text": "待办公文",
							"href": "/myApproval",
							"router" : true,
							"icon": "lui_iconfont_navleft_imissive_depot"
						},
						{
							"text": "在办公文",
							"href": "/myApproved",
							"router" : true,
							"icon": "lui_iconfont_navleft_imissive_depot"
						},
	  					<kmss:authShow roles="ROLE_KMIMISSIVE_SEND_CREATE">
	  					{
		  					"text" : "${lfn:message('km-imissive:kmImissiveSendMain.create.title') }",
							"href" :  "/createSend",
							"router" : true,		  					
		  					"icon" : "lui_iconfont_navleft_imissive_drafted"
		  				},
		  				</kmss:authShow>
		  				{
		  					"text" : "${lfn:message('km-imissive:kmImissive.tree.myapproval.send') }",
							"href" :  "/listApprovalSend",
							"router" : true,  					
		  					"icon" : "lui_iconfont_navleft_imissive_beapproval"
		  				},{
		  					"text" : "${lfn:message('km-imissive:kmImissive.nav.Send') }",
							"href" :  "/searchSend",
							"router" : true,		  					
		  					"icon" : "lui_iconfont_navleft_com_query"
		  				},{
		  					"text" : "${lfn:message('km-imissive:kmImissive.tree.allSend') }",
							"href" :  "/listAllSend",
							"router" : true,		  					
		  					"icon" : "lui_iconfont_navleft_imissive_outgoingdepot"
		  				}]
	  					</ui:source>
	  				</ui:varParam>
	  			</ui:combin>
	  			<div class="lui_border_b"></div>
	  		
	  			<ui:combin ref="menu.nav.simple">
	  				<ui:varParam name="source">
	  					<ui:source type="Static">
	  					[
	  					<kmss:authShow roles="ROLE_KMIMISSIVE_RECEIVE_CREATE">
	  					{
		  					"text" : "${lfn:message('km-imissive:kmImissiveReceiveMain.create.title') }",
							"href" :  "/createReceive",
							"router" : true,		  					
		  					"icon" : "lui_iconfont_navleft_com_my_drafted"
		  				},
		  				</kmss:authShow>
		  				{
		  					"text" : "${lfn:message('km-imissive:kmImissive.tree.myapproval.receive') }",
							"href" :  "/listApprovalReceive",
							"router" : true,  					
		  					"icon" : "lui_iconfont_navleft_imissive_beapproval"
		  				},{
		  					"text" : "${lfn:message('km-imissive:kmImissive.nav.Receive') }",
							"href" :  "/searchReceive",
							"router" : true,		  					
		  					"icon" : "lui_iconfont_navleft_com_query"
		  				},{
		  					"text" : "${lfn:message('km-imissive:kmImissive.tree.allReceive') }",
							"href" :  "/listAllReceive",
							"router" : true,		  					
		  					"icon" : "lui_iconfont_navleft_imissive_outgoingdepot"
		  				}]
	  					</ui:source>
	  				</ui:varParam>
	  			</ui:combin>
	  		
	  			<div class="lui_border_b"></div>
				
				<ui:combin ref="menu.nav.simple">
	  				<ui:varParam name="source">
	  					<ui:source type="Static">
	  					[
	  					<kmss:authShow roles="ROLE_KMIMISSIVE_SIGN_CREATE">
	  					{
		  					"text" : "${lfn:message('km-imissive:kmImissiveSignMain.create.title') }",
							"href" :  "/createSign",
							"router" : true,		  					
		  					"icon" : "lui_iconfont_navleft_com_my_drafted"
		  				},
		  				</kmss:authShow>
		  				{
		  					"text" : "${lfn:message('km-imissive:kmImissive.tree.myapproval.sign') }",
							"href" :  "/listApprovalSign",
							"router" : true,  					
		  					"icon" : "lui_iconfont_navleft_imissive_beapproval"
		  				},{
		  					"text" : "${lfn:message('km-imissive:kmImissive.nav.Sign') }",
							"href" :  "/searchSign",
							"router" : true,		  					
		  					"icon" : "lui_iconfont_navleft_com_query"
		  				},{
		  					"text" : "${lfn:message('km-imissive:kmImissive.tree.allSign') }",
							"href" :  "/listAllSign",
							"router" : true,		  					
		  					"icon" : "lui_iconfont_navleft_imissive_outgoingdepot"
		  				}]
	  					</ui:source>
	  				</ui:varParam>
	  			</ui:combin>
			
			</ui:content>
			<ui:content title="${lfn:message('km-imissive:kmImissive.nav.Exchange') }" expand="false">
				<ui:combin ref="menu.nav.simple">
	  				<ui:varParam name="source">
	  					<ui:source type="Static">
	  					[
	  					{
		  					"text" : "${lfn:message('km-imissive:kmImissive.tree.mydistribute') }",
							"href" :  "/mydistribute",
							"router" : true,		  					
		  					"icon" : "lui_iconfont_navleft_imissive_exchange"
		  				},
		  				{
		  					"text" : "${ lfn:message('km-imissive:kmImissive.tree.myreport') }",
							"href" :  "/myreport",
							"router" : true,  					
		  					"icon" : "lui_iconfont_navleft_imissive_exchange"
		  				},{
		  					"text" : "${ lfn:message('km-imissive:kmImissive.tree.mysign') }",
							"href" :  "/mysign",
							"router" : true,		  					
		  					"icon" : "lui_iconfont_navleft_imissive_exchange"
		  				},{
		  					"text" : "${ lfn:message('km-imissive:kmImissive.tree.myreceive') }",
							"href" :  "/myreceive",
							"router" : true,		  					
		  					"icon" : "lui_iconfont_navleft_imissive_exchange"
		  				}]
	  					</ui:source>
	  				</ui:varParam>
	  			</ui:combin>
			</ui:content>
			<ui:content title="${ lfn:message('km-imissive:kmImissive.nav.Stat') }"  expand="false">
				<ui:combin ref="menu.nav.simple">
	  				<ui:varParam name="source">
	  					<ui:source type="Static">
	  					[
	  					<kmss:authShow roles="ROLE_KMIMISSIVE_STAT_OVERVIEW">
		  				{
		  					"text" : "${ lfn:message('km-imissive:tree.preview') }",
							"href" :  "/preview",
							"router" : true,  					
		  					"icon" : "lui_iconfont_navleft_task_load_analysis"
		  				},
		  				</kmss:authShow>
		  				{
		  					"text" : "${ lfn:message('km-imissive:tree.deliver') }",
							"href" :  "/deliver",
							"router" : true,		  					
		  					"icon" : "lui_iconfont_navleft_task_satisfaction_analysis"
		  				},{
		  					"text" : "${ lfn:message('km-imissive:tree.trend') }",
							"href" :  "/trend",
							"router" : true,		  					
		  					"icon" : "lui_iconfont_navleft_task_type_analysis"
		  				},{
		  					"text" : "${ lfn:message('km-imissive:tree.type') }",
							"href" :  "/type",
							"router" : true,		  					
		  					"icon" : "lui_iconfont_navleft_task_trend_analysis"
		  				}]
	  					</ui:source>
	  				</ui:varParam>
	  			</ui:combin>
			</ui:content>	
			
			<ui:content title="${ lfn:message('list.otherOpt') }" expand="false">
			
				<ui:combin ref="menu.nav.simple">
	  				<ui:varParam name="source">
	  					<ui:source type="Static">
	  					[{
		  					"text" : "${lfn:message('km-imissive:kmImissive.tree.fillingBox') }",
							"href" :  "/filing",
							"router" : true,		  					
		  					"icon" : "lui_iconfont_navleft_com_file"
		  				},
		  				{
		  					"text" : "${lfn:message('km-imissive:kmImissive.tree.discardBox') }",
							"href" :  "/discard",
							"router" : true,  					
		  					"icon" : "lui_iconfont_navleft_com_discard"
		  				}
		  				<%-- 关闭回收站功能时，模块首页不显示“回收站” --%>
		  				<% if(com.landray.kmss.sys.recycle.util.SysRecycleUtil.isEnableSoftDelete("com.landray.kmss.km.imissive.model.KmImissiveSendMain;com.landray.kmss.km.imissive.model.KmImissiveReceiveMain;com.landray.kmss.km.imissive.model.KmImissiveSignMain")) { %>
		  				,{
		  					"text" : "${ lfn:message('sys-recycle:module.sys.recycle') }",
							"href" :  "/recover",
							"router" : true,
		  					"icon" : "lui_iconfont_navleft_com_recycle"
		  				}
		  				<% } %>
		  				<kmss:authShow roles="ROLE_KMIMISSIVE_BACKSTAGE_MANAGER">
	  					,{
	  						"text" : "${ lfn:message('list.manager') }",
	  						"href" : "/management",
	  						"router" : true,	
		  					"icon" : "lui_iconfont_navleft_com_background"
	  					}
		  				</kmss:authShow>
		  				]
	  					</ui:source>
	  				</ui:varParam>
	  			</ui:combin>
			</ui:content>
		</ui:accordionpanel>
	</div>
	</template:replace>
	<template:replace name="content">
	  <ui:tabpanel id="kmImissivePanel" layout="sys.ui.tabpanel.list" cfg-router="true" var-average = 'false'>
		  <ui:content 
		  			id="myApprovalTodoContent"
		  			title="办件"
		  			cfg-route="{path:'/myApproval/todo'}"
		  			countUrl="/sys/notify/sys_notify_todo/sysNotifyTodo.do?method=getCount&fdType=todo">
		  		<ui:iframe  src="${LUI_ContextPath }/km/imissive/km_imissive_main/index.jsp?mydoc=approval"></ui:iframe>
	      </ui:content>
	       <ui:content 
					id="myApprovalToReadContent"
		  			title="阅件"
		  			cfg-route="{path:'/myApproval/toread'}"
		  			countUrl="/sys/notify/sys_notify_todo/sysNotifyMainIndex.do?method=list&dataType=toview&fdType=2">
		  		<ui:iframe  src="${LUI_ContextPath }/km/imissive/km_imissive_main/index_toread.jsp?"></ui:iframe>
	      </ui:content>
	      <ui:content 
		  			id="myApprovedDoneContent"
		  			title="办件"
		  			cfg-route="{path:'/myApproved/done'}" 
		  			countUrl="/sys/notify/sys_notify_todo/sysNotifyTodo.do?method=getCount&fdType=toview&fdAppName=">
	       		<ui:iframe  src="${LUI_ContextPath }/km/imissive/km_imissive_main/index.jsp?mydoc=approved"></ui:iframe>
	      </ui:content>
		 <ui:content 
					id="myApprovedReadedContent"
		  			title="阅件"
		  			cfg-route="{path:'/myApproved/readed'}"
		  			countUrl="/sys/notify/sys_notify_todo/sysNotifyMainIndex.do?method=list&dataType=toviewdone&fdType=2">
		        <ui:iframe  src="${LUI_ContextPath }/km/imissive/km_imissive_main/index_readed.jsp?"></ui:iframe>
	      </ui:content>
		 <ui:content 
		 		id="kmImissiveSendContent" 
		 		title="${lfn:message('km-imissive:kmImissive.tree.Send') }"
		 		cfg-route="{path:'/listAll/send'}">
		 	  <ui:iframe id="kmImissiveSend" src="${LUI_ContextPath }/km/imissive/km_imissive_send_main/index_content_send.jsp?rwd=true"></ui:iframe>
		  </ui:content>
		  <ui:content 
		  		id="kmImissiveReceiveContent" 
		  		title="${lfn:message('km-imissive:kmImissive.tree.Receive') }"
		  		cfg-route="{path:'/listAll/receive'}">
		 	 <ui:iframe  id="kmImissiveReceive"  src="${LUI_ContextPath }/km/imissive/km_imissive_receive_main/index_content_receive.jsp?rwd=true"></ui:iframe>
		  </ui:content>
		   <ui:content 
		   		id="kmImissiveSignContent" 
		   		title="${lfn:message('km-imissive:kmImissive.tree.Sign') }"
		   		cfg-route="{path:'/listAll/sign'}">
		 	  <ui:iframe id="kmImissiveSign" src="${LUI_ContextPath }/km/imissive/km_imissive_sign_main/index_content_sign.jsp?rwd=true"></ui:iframe>
		  </ui:content>
		   <ui:content
		   		title="${lfn:message('km-imissive:kmImissive.tree.mydistribute') }"
		   		id="kmImissiveMyDistributeContent"  
		   		cfg-route="{path:'/exchange/mydistribute'}">
		 	 <ui:iframe id="distribute" src="${LUI_ContextPath }/km/imissive/km_imissive_reg/index_content_reg_distribute.jsp?rwd=true&path=/exchange/mydistribute"></ui:iframe>
		  </ui:content>
		  <%--
		  <ui:content title=""
		   		id="kmImissiveCreateSendContent"  
		   		cfg-route="{path:'/createSend'}">
		 	 <ui:iframe id="kmImissiveSendCreate" src="${LUI_ContextPath }/km/imissive/km_imissive_send_main/createDoc_send.jsp?mainModelName=com.landray.kmss.km.imissive.model.KmImissiveSendMain&modelName=com.landray.kmss.km.imissive.model.KmImissiveSendTemplate&isSimpleCategory=false&j_path=/createSend"></ui:iframe>
		  </ui:content>
		   --%>
		  <ui:content 
		  		title="${ lfn:message('km-imissive:kmImissive.tree.myreport') }"
		  		id="kmImissiveMyReportContent"  
		   		cfg-route="{path:'/exchange/myreport'}">
		  	<ui:iframe id="distribute" src="${LUI_ContextPath }/km/imissive/km_imissive_reg/index_content_reg_report.jsp?rwd=true&path=/exchange/myreport"></ui:iframe>
		  </ui:content>
		   <ui:content 
		   		title="${ lfn:message('km-imissive:kmImissive.tree.mysign') }"
		   		id="kmImissiveMySignContent"  
		   		cfg-route="{path:'/exchange/mysign'}">
		   	<ui:iframe id="sign" src="${LUI_ContextPath }/km/imissive/km_imissive_regdetail_list/kmImissiveRegDetailList_mySign.jsp?rwd=true&path=/exchange/mysign"></ui:iframe>
		  </ui:content>
		   <ui:content 
		   		title="${ lfn:message('km-imissive:kmImissive.tree.myreceive') }(内部)"
		   		id="kmImissiveMyReceiveContent"  
		   		cfg-route="{path:'/exchange/myreceive'}">
		  	 <ui:iframe id="detaillist" src="${LUI_ContextPath }/km/imissive/km_imissive_regdetail_list/index_content_reglist.jsp?rwd=true&path=/exchange/myreceive"></ui:iframe>
		  </ui:content>
		   <ui:content 
		   		title="${ lfn:message('km-imissive:kmImissive.tree.myreceive') }(外部)"
		   		id="kmImissiveMyReceiveOuterContent"  
		   		cfg-route="{path:'/exchange/myreceiveout'}">
		  	 <ui:iframe id="detaillistout" src="${LUI_ContextPath }/km/imissive/km_imissive_regdetail_list_outer/index_content_reglist.jsp?rwd=true&path=/exchange/myreceiveout"></ui:iframe>
		  </ui:content>
		  <ui:content id="kmImissiveStatContent" cfg-route="{path:'/preview'}" title="公文统计">
	 	 	<ui:iframe id="kmImissiveStatIframe" src="${LUI_ContextPath }/km/imissive/km_imissive_stat/index.jsp?rwd=true"></ui:iframe>
	 	 </ui:content>
	  </ui:tabpanel>
	</template:replace>
	<template:replace name="script">
		<!-- JSP中建议只出现·安装模块·的JS代码，其余JS代码采用引入方式 -->
		<script type="text/javascript">
			seajs.use(['lui/framework/module', 'lui/framework/router/router-utils'],function(Module,routerUtils){
				Module.install('kmImissive',{
					//模块变量
					$var : {},
					//模块多语言
					$lang : {
						'kmImissiveNavSend' : '${lfn:message("km-imissive:kmImissive.nav.Send")}',
						'kmImissiveNavReceive' : '${lfn:message("km-imissive:kmImissive.nav.Receive")}',
						'kmImissiveNavSign' : '${lfn:message("km-imissive:kmImissive.nav.Sign")}'
					},
					//搜索标识符
					$search : ''
				});
				window.newPage = function(status){
					var router = routerUtils.getRouter();
					if (router) {
						router.push(status);
					}
				};
				window.newPageWithParam = function(href,param){
					var router = routerUtils.getRouter();
					if (router) {
						router.push(href,param);
					}
					//移除导航选中状态
					LUI.$("[data-lui-type*=AccordionPanel] li").removeClass("lui_list_nav_selected");
					LUI.$("[data-path='"+href+"']").addClass('lui_list_nav_selected');
				};
			});
		</script>
		<!-- 引入JS -->
		<script type="text/javascript" src="${LUI_ContextPath}/km/imissive/resource/js/index.js"></script>
	</template:replace>
</template:include>
