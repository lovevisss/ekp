<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="/sys/ui/jsp/common.jsp"%>
<%@page import="com.landray.kmss.km.imissive.util.KmImissiveConfigUtil"%>
<%
	request.setAttribute("getNavigationMode", KmImissiveConfigUtil.getNavigationMode());
%>
<template:include ref="default.list" spa="true">
	<template:replace name="title">
		<c:out value="${ lfn:message('km-imissive:kmImissive.tree.title') }"></c:out>
	</template:replace>

	<%if("poly".equals(KmImissiveConfigUtil.getNavigationMode())){ %>
		<template:replace name="nav">
			<div id="menu_nav" class="lui_list_nav_frame">
					<%-- 是否拥有查看线下公文角色 --%>
				<c:set value="false" var="isOffLineReader" />
				<kmss:authShow roles="ROLE_KMIMISSIVE_READER_OFFLINE">
					<c:set value="true" var="isOffLineReader" />
				</kmss:authShow>
				<ui:accordionpanel>
					<ui:content title="${lfn:message('km-imissive:kmImissive.nav.manage') }" expand="true">
						<ui:combin ref="menu.nav.simple">
							<ui:varParam name="source">
								<ui:source type="Static">
									[
									<kmss:authShow roles="ROLE_KMIMISSIVE_SEND_CREATE;ROLE_KMIMISSIVE_RECEIVE_CREATE;ROLE_KMIMISSIVE_SIGN_CREATE">
										{
										"text": "公文登记簿",
										"href": "/listCreateDoc",
										"router" : true,
										"icon": "lui_iconfont_navleft_imissive_depot"
										},
									</kmss:authShow>
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
									{
									"text": "办结公文",
									"href": "/listAllPublish",
									"router" : true,
									"icon": "lui_iconfont_navleft_imissive_depot"
									},
									{
									"text": "公文查询",
									"href": "/listAll",
									"router" : true,
									"icon": "lui_iconfont_navleft_imissive_depot"
									},
									{
									"text": "我的公文",
									"href": "/listCreate",
									"router" : true,
									"icon": "lui_iconfont_navleft_imissive_depot"
									},
									<c:if test="${isOffLineReader eq 'true'}">
										{
										"text": "线下公文",
										"href": "/listOffLine",
										"router" : true,
										"icon": "lui_iconfont_navleft_imissive_depot"
										},
									</c:if>
									{
									"text": "公文交换",
									"href": "/exchange",
									"router" : true,
									"icon": "lui_iconfont_navleft_imissive_exchange"
									}
									<% if (com.landray.kmss.sys.subordinate.util.SubordinateUtil.getInstance().getModelByModuleAndUser("km-imissive:module.km.imissive").size() > 0) { %>
									,{
									"text" : "下属公文",
									"href" :  "/sys/subordinate",
									"router" : true,
									"icon" : "lui_iconfont_navleft_subordinate"
									}
									<% } %>
									]
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

					<ui:content title="${ lfn:message('list.otherOpt') }" expand="true">

						<ui:combin ref="menu.nav.simple">
							<ui:varParam name="source">
								<ui:source type="Static">
									[
									<%
										if(KmImissiveConfigUtil.getSysArchEnabled()){
									%>
									{
									"text" : "${lfn:message('km-imissive:kmImissive.tree.fillingBox') }",
									"href" :  "/filing",
									"router" : true,
									"icon" : "lui_iconfont_navleft_com_file"
									},
									<%
										}
									%>
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
	<%}else{ %>
		<template:replace name="nav">
			<div id="menu_nav" class="lui_list_nav_frame">
					<%-- 是否拥有查看线下公文角色 --%>
				<c:set value="false" var="isOffLineReader" />
				<kmss:authShow roles="ROLE_KMIMISSIVE_READER_OFFLINE">
					<c:set value="true" var="isOffLineReader" />
				</kmss:authShow>
				<ui:accordionpanel>
					<ui:content title="${lfn:message('km-imissive:setting.navigationModel.approvalSend') }" expand="true">
						<ui:combin ref="menu.nav.simple">
							<ui:varParam name="source">
								<ui:source type="Static">
									[
									<kmss:authShow roles="ROLE_KMIMISSIVE_SEND_CREATE">
										{
										"text" : "${lfn:message('km-imissive:kmImissiveSendMain.create.title') }",
										"href" :  "simpleGw/createSend",
										"router" : true,
										"icon" : "lui_iconfont_navleft_imissive_drafted"
										},
									</kmss:authShow>
									{
									"text" : "${lfn:message('km-imissive:setting.navigationModel.dealtSend') }",
									"href" :  "simpleGw/listApprovalSend",
									"router" : true,
									"icon" : "lui_iconfont_navleft_imissive_beapproval"
									},
									{
									"text": "发文查询",
									"href": "simpleGw/list/send",
									"router" : true,
									"icon": "lui_iconfont_navleft_imissive_depot"
									}]
								</ui:source>
							</ui:varParam>
						</ui:combin>
					</ui:content>

					<ui:content title="收文办理" expand="true">
						<ui:combin ref="menu.nav.simple">
							<ui:varParam name="source">
								<ui:source type="Static">
									[
									<kmss:authShow roles="ROLE_KMIMISSIVE_RECEIVE_CREATE">
										{
										"text" : "${lfn:message('km-imissive:kmImissiveReceiveMain.create.title') }",
										"href" :  "simpleGw/createReceive",
										"router" : true,
										"icon" : "lui_iconfont_navleft_com_my_drafted"
										},
									</kmss:authShow>
									{
									"text" : "${lfn:message('km-imissive:setting.navigationModel.dealtReceive') }",
									"href" :  "simpleGw/listApprovalReceive",
									"router" : true,
									"icon" : "lui_iconfont_navleft_imissive_beapproval"
									},
									{
									"text": "收文查询",
									"href": "simpleGw/list/receive",
									"router" : true,
									"icon": "lui_iconfont_navleft_imissive_depot"
									}]
								</ui:source>
							</ui:varParam>
						</ui:combin>
					</ui:content>

					<ui:content title="签报管理" expand="true">
						<ui:combin ref="menu.nav.simple">
							<ui:varParam name="source">
								<ui:source type="Static">
									[
									<kmss:authShow roles="ROLE_KMIMISSIVE_SIGN_CREATE">
										{
										"text" : "${lfn:message('km-imissive:kmImissiveSignMain.create.title') }",
										"href" :  "simpleGw/createSign",
										"router" : true,
										"icon" : "lui_iconfont_navleft_com_my_drafted"
										},
									</kmss:authShow>
									{
									"text" : "${lfn:message('km-imissive:setting.navigationModel.dealtSign') }",
									"href" :  "simpleGw/listApprovalSign",
									"router" : true,
									"icon" : "lui_iconfont_navleft_imissive_beapproval"
									},
									{
									"text": "签报查询",
									"href": "simpleGw/list/sign",
									"router" : true,
									"icon": "lui_iconfont_navleft_imissive_depot"
									}]
								</ui:source>
							</ui:varParam>
						</ui:combin>
					</ui:content>

					<ui:content title="流程查询" expand="true">
						<ui:combin ref="menu.nav.simple">
							<ui:varParam name="source">
								<ui:source type="Static">
									[
									{
									"text": "${lfn:message('km-imissive:setting.navigationModel.doneReview') }",
									"href": "simpleGw/listApproved",
									"router" : true,
									"icon": "lui_iconfont_navleft_com_my_approvaled"
									},
									{
									"text": "${lfn:message('km-imissive:setting.navigationModel.issuedReview') }",
									"href": "simpleGw/listAllPublish",
									"router" : true,
									"icon": "lui_iconfont_navleft_com_my_drafted"
									}
									<c:if test="${isOffLineReader eq 'true'}">
										,{
										"text": "线下公文",
										"href": "simpleGw/listOffLine",
										"router" : true,
										"icon": "lui_iconfont_navleft_imissive_depot"
										}
									</c:if>]
								</ui:source>
							</ui:varParam>
						</ui:combin>
					</ui:content>

					<ui:content title="公文交换" expand="true">
						<ui:combin ref="menu.nav.simple">
							<ui:varParam name="source">
								<ui:source type="Static">
									[
									{
									"text": "单位发文",
									"href": "simpleGw/exchangeSend",
									"router" : true,
									"icon": "lui_iconfont_navleft_imissive_exchange"
									},
									{
									"text": "单位收文",
									"href": "simpleGw/exchangeReceive",
									"router" : true,
									"icon": "lui_iconfont_navleft_imissive_exchange"
									}]
								</ui:source>
							</ui:varParam>
						</ui:combin>
					</ui:content>

					<kmss:authShow roles="ROLE_KMIMISSIVE_STAT_OVERVIEW">
					<ui:content title="${ lfn:message('km-imissive:kmImissive.nav.Stat') }"  expand="true">
						<ui:combin ref="menu.nav.simple">
							<ui:varParam name="source">
								<ui:source type="Static">
									[
										{
										"text" : "${ lfn:message('km-imissive:setting.navigationModel.countSend') }",
										"href" :  "/preview",
										"router" : true,
										"icon" : "lui_iconfont_navleft_task_load_analysis"
										},
										{
										"text" : "${ lfn:message('km-imissive:setting.navigationModel.countReceive') }",
										"href" :  "/previewReceive",
										"router" : true,
										"icon" : "lui_iconfont_navleft_task_load_analysis"
										}
									]
								</ui:source>
							</ui:varParam>
						</ui:combin>
					</ui:content>
					</kmss:authShow>

					<ui:content title="${ lfn:message('list.otherOpt') }" expand="true">

						<ui:combin ref="menu.nav.simple">
							<ui:varParam name="source">
								<ui:source type="Static">
									[
									<%
										if(KmImissiveConfigUtil.getSysArchEnabled()){
									%>
									{
									"text" : "${lfn:message('km-imissive:kmImissive.tree.fillingBox') }",
									"href" :  "simpleGw/filing",
									"router" : true,
									"icon" : "lui_iconfont_navleft_com_file"
									},
									<%
										}
									%>
									{
									"text" : "${lfn:message('km-imissive:kmImissive.tree.discardBox') }",
									"href" :  "simpleGw/discard",
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
	<%} %>

	<template:replace name="content">
		<style>
			.lui_tabpanel_list_navs_item_l{
				max-width: 20%!important;
			}
		</style>
		<ui:tabpanel id="kmImissivePanel" layout="sys.ui.tabpanel.list" cfg-router="true" var-average = 'false'>
			<%--<ui:content id="subordinateContent" title="下属公文" cfg-route="{path:'/sys/subordinate'}">
				<ui:iframe id="subordinate" src="${LUI_ContextPath }/sys/subordinate/moduleindex.jsp?moduleMessageKey=km-imissive:module.km.imissive"></ui:iframe>
			</ui:content>--%>

			<ui:content
					id="myApprovalTodoContent"
					title="办件"
					cfg-route="{path:'/myApproval/todo'}"
					countUrl="/km/imissive/km_imissive_main/kmImissiveMain.do?method=listDoc&mydoc=approval&getCount=true">
				<ui:iframe  src="${LUI_ContextPath }/km/imissive/km_imissive_main/index.jsp?contentId=myApprovalTodoContent&mydoc=approval"></ui:iframe>
			</ui:content>
			<ui:content
					id="myApprovalToReadContent"
					title="阅件"
					cfg-route="{path:'/myApproval/toread'}"
					countUrl="/km/imissive/km_imissive_main/kmImissiveMain.do?method=listRead&mydoc=approval&getCount=true">
				<ui:iframe  src="${LUI_ContextPath }/km/imissive/km_imissive_main/index_cir.jsp?contentId=myApprovalToReadContent&mydoc=approval"></ui:iframe>
			</ui:content>
			<ui:content
					id="myApprovedDoneContent"
					title="办件"
					cfg-route="{path:'/myApproved/done'}"
					countUrl="/km/imissive/km_imissive_main/kmImissiveMain.do?method=listDoc&mydoc=approved&getCount=true">
				<ui:iframe  src="${LUI_ContextPath }/km/imissive/km_imissive_main/index.jsp?contentId=myApprovedDoneContent&mydoc=approved"></ui:iframe>
			</ui:content>
			<ui:content
					id="myApprovedReadedContent"
					title="阅件"
					cfg-route="{path:'/myApproved/readed'}"
					countUrl="/km/imissive/km_imissive_main/kmImissiveMain.do?method=listRead&mydoc=approved&getCount=true">
				<ui:iframe  src="${LUI_ContextPath }/km/imissive/km_imissive_main/index_cir.jsp?contentId=myApprovedReadedContent&mydoc=approved"></ui:iframe>
			</ui:content>

			<ui:content
					id="kmImissiveSendPContent"
					title="${lfn:message('km-imissive:kmImissive.tree.Send') }"
					cfg-route="{path:'/listAllPublish/send'}"
					countUrl="/km/imissive/km_imissive_send_main/kmImissiveSendMain.do?method=getContentCount&q.flag=finished">
				<ui:iframe  src="${LUI_ContextPath }/km/imissive/km_imissive_send_main/index_content_send.jsp?contentId=kmImissiveSendPContent&rwd=true"></ui:iframe>
			</ui:content>
			<ui:content
					id="kmImissiveReceivePContent"
					title="${lfn:message('km-imissive:kmImissive.tree.Receive') }"
					cfg-route="{path:'/listAllPublish/receive'}"
					countUrl="/km/imissive/km_imissive_receive_main/kmImissiveReceiveMain.do?method=getContentCount&q.flag=finished">
				<ui:iframe  src="${LUI_ContextPath }/km/imissive/km_imissive_receive_main/index_content_receive.jsp?contentId=kmImissiveReceivePContent&rwd=true"></ui:iframe>
			</ui:content>
			<ui:content
					id="kmImissiveSignPContent"
					title="${lfn:message('km-imissive:kmImissive.tree.Sign') }"
					cfg-route="{path:'/listAllPublish/sign'}"
					countUrl="/km/imissive/km_imissive_sign_main/kmImissiveSignMain.do?method=getContentCount&q.flag=finished">
				<ui:iframe src="${LUI_ContextPath }/km/imissive/km_imissive_sign_main/index_content_sign.jsp?contentId=kmImissiveSignPContent&rwd=true"></ui:iframe>
			</ui:content>

			<%--普通模式--%>
			<ui:content
					id="kmImissiveSendPGwContent"
					title="${lfn:message('km-imissive:kmImissive.tree.Send') }"
					cfg-route="{path:'simpleGw/listAllPublish/send'}"
					countUrl="/km/imissive/km_imissive_send_main/kmImissiveSendMain.do?method=getContentCount&q.flag=finished">
				<ui:iframe  src="${LUI_ContextPath }/km/imissive/km_imissive_send_main/index_content_send.jsp?contentId=kmImissiveSendPGwContent&rwd=true"></ui:iframe>
			</ui:content>
			<ui:content
					id="kmImissiveReceivePGwContent"
					title="${lfn:message('km-imissive:kmImissive.tree.Receive') }"
					cfg-route="{path:'simpleGw/listAllPublish/receive'}"
					countUrl="/km/imissive/km_imissive_receive_main/kmImissiveReceiveMain.do?method=getContentCount&q.flag=finished">
				<ui:iframe  src="${LUI_ContextPath }/km/imissive/km_imissive_receive_main/index_content_receive.jsp?contentId=kmImissiveReceivePGwContent&rwd=true"></ui:iframe>
			</ui:content>
			<ui:content
					id="kmImissiveSignPGwContent"
					title="${lfn:message('km-imissive:kmImissive.tree.Sign') }"
					cfg-route="{path:'simpleGw/listAllPublish/sign'}"
					countUrl="/km/imissive/km_imissive_sign_main/kmImissiveSignMain.do?method=getContentCount&q.flag=finished">
				<ui:iframe src="${LUI_ContextPath }/km/imissive/km_imissive_sign_main/index_content_sign.jsp?contentId=kmImissiveSignPGwContent&rwd=true"></ui:iframe>
			</ui:content>

			<ui:content
					id="kmImissiveSendCContent"
					title="${lfn:message('km-imissive:kmImissive.tree.Send') }"
					cfg-route="{path:'/listAllPublish/send'}"
					countUrl="/km/imissive/km_imissive_send_main/kmImissiveSendMain.do?method=getContentCount&q.mydoc=create">
				<ui:iframe  src="${LUI_ContextPath }/km/imissive/km_imissive_send_main/index_content_send.jsp?contentId=kmImissiveSendCContent&rwd=true"></ui:iframe>
			</ui:content>
			<ui:content
					id="kmImissiveReceiveCContent"
					title="${lfn:message('km-imissive:kmImissive.tree.Receive') }"
					cfg-route="{path:'/listAllPublish/receive'}"
					countUrl="/km/imissive/km_imissive_receive_main/kmImissiveReceiveMain.do?method=getContentCount&q.mydoc=create">
				<ui:iframe  src="${LUI_ContextPath }/km/imissive/km_imissive_receive_main/index_content_receive.jsp?contentId=kmImissiveReceiveCContent&rwd=true"></ui:iframe>
			</ui:content>
			<ui:content
					id="kmImissiveSignCContent"
					title="${lfn:message('km-imissive:kmImissive.tree.Sign') }"
					cfg-route="{path:'/listAllPublish/sign'}"
					countUrl="/km/imissive/km_imissive_sign_main/kmImissiveSignMain.do?method=getContentCount&q.mydoc=create">
				<ui:iframe src="${LUI_ContextPath }/km/imissive/km_imissive_sign_main/index_content_sign.jsp?contentId=kmImissiveSignCContent&rwd=true"></ui:iframe>
			</ui:content>

			<ui:content
					id="kmImissiveSendFContent"
					title="${lfn:message('km-imissive:kmImissive.tree.Send') }"
					cfg-route="{path:'/filing/send'}"
					countUrl="/km/imissive/km_imissive_send_main/kmImissiveSendMain.do?method=getContentCount&q.fdIsFiling=1">
				<ui:iframe src="${LUI_ContextPath }/km/imissive/km_imissive_send_main/index_content_send.jsp?contentId=kmImissiveSendFContent&filingBox=true&rwd=true"></ui:iframe>
			</ui:content>
			<ui:content
					id="kmImissiveReceiveFContent"
					title="${lfn:message('km-imissive:kmImissive.tree.Receive') }"
					cfg-route="{path:'/filing/receive'}"
					countUrl="/km/imissive/km_imissive_receive_main/kmImissiveReceiveMain.do?method=getContentCount&q.fdIsFiling=1">
				<ui:iframe  src="${LUI_ContextPath }/km/imissive/km_imissive_receive_main/index_content_receive.jsp?contentId=kmImissiveReceiveFContent&filingBox=true&rwd=true"></ui:iframe>
			</ui:content>
			<ui:content
					id="kmImissiveSignFContent"
					title="${lfn:message('km-imissive:kmImissive.tree.Sign') }"
					cfg-route="{path:'/filing/sign'}"
					countUrl="/km/imissive/km_imissive_sign_main/kmImissiveSignMain.do?method=getContentCount&q.fdIsFiling=1">
				<ui:iframe src="${LUI_ContextPath }/km/imissive/km_imissive_sign_main/index_content_sign.jsp?contentId=kmImissiveSignFContent&filingBox=true&rwd=true"></ui:iframe>
			</ui:content>

			<%--普通模式--%>
			<ui:content
					id="kmImissiveSendFGwContent"
					title="${lfn:message('km-imissive:kmImissive.tree.Send') }"
					cfg-route="{path:'simpleGw/filing/send'}"
					countUrl="/km/imissive/km_imissive_send_main/kmImissiveSendMain.do?method=getContentCount&q.fdIsFiling=1">
				<ui:iframe src="${LUI_ContextPath }/km/imissive/km_imissive_send_main/index_content_send.jsp?contentId=kmImissiveSendFContent&filingBox=true&rwd=true"></ui:iframe>
			</ui:content>
			<ui:content
					id="kmImissiveReceiveFGwContent"
					title="${lfn:message('km-imissive:kmImissive.tree.Receive') }"
					cfg-route="{path:'simpleGw/filing/receive'}"
					countUrl="/km/imissive/km_imissive_receive_main/kmImissiveReceiveMain.do?method=getContentCount&q.fdIsFiling=1">
				<ui:iframe  src="${LUI_ContextPath }/km/imissive/km_imissive_receive_main/index_content_receive.jsp?contentId=kmImissiveReceiveFContent&filingBox=true&rwd=true"></ui:iframe>
			</ui:content>
			<ui:content
					id="kmImissiveSignFGwContent"
					title="${lfn:message('km-imissive:kmImissive.tree.Sign') }"
					cfg-route="{path:'simpleGw/filing/sign'}"
					countUrl="/km/imissive/km_imissive_sign_main/kmImissiveSignMain.do?method=getContentCount&q.fdIsFiling=1">
				<ui:iframe src="${LUI_ContextPath }/km/imissive/km_imissive_sign_main/index_content_sign.jsp?contentId=kmImissiveSignFContent&filingBox=true&rwd=true"></ui:iframe>
			</ui:content>

			<ui:content
					id="kmImissiveSendDContent"
					title="${lfn:message('km-imissive:kmImissive.tree.Send') }"
					cfg-route="{path:'/discard/send'}"
					countUrl="/km/imissive/km_imissive_send_main/kmImissiveSendMain.do?method=getContentCount&q.docStatus=00">
				<ui:iframe  src="${LUI_ContextPath }/km/imissive/km_imissive_send_main/index_content_send.jsp?contentId=kmImissiveSendDContent&rwd=true"></ui:iframe>
			</ui:content>
			<ui:content
					id="kmImissiveReceiveDContent"
					title="${lfn:message('km-imissive:kmImissive.tree.Receive') }"
					cfg-route="{path:'/discard/receive'}"
					countUrl="/km/imissive/km_imissive_receive_main/kmImissiveReceiveMain.do?method=getContentCount&q.docStatus=00">
				<ui:iframe  src="${LUI_ContextPath }/km/imissive/km_imissive_receive_main/index_content_receive.jsp?contentId=kmImissiveReceiveDContent&rwd=true"></ui:iframe>
			</ui:content>
			<ui:content
					id="kmImissiveSignDContent"
					title="${lfn:message('km-imissive:kmImissive.tree.Sign') }"
					cfg-route="{path:'/discard/sign'}"
					countUrl="/km/imissive/km_imissive_sign_main/kmImissiveSignMain.do?method=getContentCount&q.docStatus=00">
				<ui:iframe src="${LUI_ContextPath }/km/imissive/km_imissive_sign_main/index_content_sign.jsp?contentId=kmImissiveSignDContent&rwd=true"></ui:iframe>
			</ui:content>

			<%--普通模式--%>
			<ui:content
					id="kmImissiveSendDGwContent"
					title="${lfn:message('km-imissive:kmImissive.tree.Send') }"
					cfg-route="{path:'simpleGw/discard/send'}"
					countUrl="/km/imissive/km_imissive_send_main/kmImissiveSendMain.do?method=getContentCount&q.docStatus=00">
				<ui:iframe  src="${LUI_ContextPath }/km/imissive/km_imissive_send_main/index_content_send.jsp?contentId=kmImissiveSendDContent&rwd=true"></ui:iframe>
			</ui:content>
			<ui:content
					id="kmImissiveReceiveDGwContent"
					title="${lfn:message('km-imissive:kmImissive.tree.Receive') }"
					cfg-route="{path:'simpleGw/discard/receive'}"
					countUrl="/km/imissive/km_imissive_receive_main/kmImissiveReceiveMain.do?method=getContentCount&q.docStatus=00">
				<ui:iframe  src="${LUI_ContextPath }/km/imissive/km_imissive_receive_main/index_content_receive.jsp?contentId=kmImissiveReceiveDContent&rwd=true"></ui:iframe>
			</ui:content>
			<ui:content
					id="kmImissiveSignDGwContent"
					title="${lfn:message('km-imissive:kmImissive.tree.Sign') }"
					cfg-route="{path:'simpleGw/discard/sign'}"
					countUrl="/km/imissive/km_imissive_sign_main/kmImissiveSignMain.do?method=getContentCount&q.docStatus=00">
				<ui:iframe src="${LUI_ContextPath }/km/imissive/km_imissive_sign_main/index_content_sign.jsp?contentId=kmImissiveSignDContent&rwd=true"></ui:iframe>
			</ui:content>

			<%--普通模式--%>
			<ui:content
					id="kmImissiveSendGwContent"
					title="${lfn:message('km-imissive:setting.navigationModel.dealtSend') }"
					cfg-route="{path:'simpleGw/listApprovalSend'}">
				<ui:iframe id="kmImissiveSend" src="${LUI_ContextPath }/km/imissive/km_imissive_send_main/index_content_send.jsp?contentId=kmImissiveSendGwContent&rwd=true"></ui:iframe>
			</ui:content>
			<ui:content
					id="kmImissiveReceiveGwContent"
					title="${lfn:message('km-imissive:setting.navigationModel.dealtReceive') }"
					cfg-route="{path:'simpleGw/listApprovalReceive'}">
				<ui:iframe  id="kmImissiveReceive"  src="${LUI_ContextPath }/km/imissive/km_imissive_receive_main/index_content_receive.jsp?contentId=kmImissiveReceiveGwContent&rwd=true"></ui:iframe>
			</ui:content>
			<ui:content
					id="kmImissiveSignGwContent"
					title="${lfn:message('km-imissive:setting.navigationModel.dealtSign') }"
					cfg-route="{path:'simpleGw/listApprovalSign'}">
				<ui:iframe id="kmImissiveSign" src="${LUI_ContextPath }/km/imissive/km_imissive_sign_main/index_content_sign.jsp?contentId=kmImissiveSignGwContent&rwd=true"></ui:iframe>
			</ui:content>

			<ui:content
					id="kmImissiveSendContent"
					title="${lfn:message('km-imissive:kmImissive.tree.Send') }"
					cfg-route="{path:'simpleGw/listApproved/send'}"
					countUrl="/km/imissive/km_imissive_send_main/kmImissiveSendMain.do?method=getContentCount">
				<ui:iframe id="kmImissiveSend" src="${LUI_ContextPath }/km/imissive/km_imissive_send_main/index_content_send.jsp?contentId=kmImissiveSendContent&rwd=true"></ui:iframe>
			</ui:content>
			<ui:content
					id="kmImissiveReceiveContent"
					title="${lfn:message('km-imissive:kmImissive.tree.Receive') }"
					cfg-route="{path:'simpleGw/listApproved/receive'}"
					countUrl="/km/imissive/km_imissive_receive_main/kmImissiveReceiveMain.do?method=getContentCount">
				<ui:iframe  id="kmImissiveReceive"  src="${LUI_ContextPath }/km/imissive/km_imissive_receive_main/index_content_receive.jsp?contentId=kmImissiveReceiveContent&rwd=true"></ui:iframe>
			</ui:content>
			<ui:content
					id="kmImissiveSignContent"
					title="${lfn:message('km-imissive:kmImissive.tree.Sign') }"
					cfg-route="{path:'simpleGw/listApproved/sign'}"
					countUrl="/km/imissive/km_imissive_sign_main/kmImissiveSignMain.do?method=getContentCount">
				<ui:iframe id="kmImissiveSign" src="${LUI_ContextPath }/km/imissive/km_imissive_sign_main/index_content_sign.jsp?contentId=kmImissiveSignContent&rwd=true"></ui:iframe>
			</ui:content>

			<%--普通模式--%>
			<ui:content
					id="kmImissiveSendMessage"
					title="${lfn:message('km-imissive:kmImissive.tree.Send') }"
					cfg-route="{path:'simpleGw/list/send'}"
					countUrl="/km/imissive/km_imissive_send_main/kmImissiveSendMain.do?method=getContentCount">
				<ui:iframe id="kmImissiveSend" src="${LUI_ContextPath }/km/imissive/km_imissive_send_main/index_content_send.jsp?contentId=kmImissiveSendMessage&rwd=true"></ui:iframe>
			</ui:content>
			<ui:content
					id="kmImissiveReceiveMessage"
					title="${lfn:message('km-imissive:kmImissive.tree.Receive') }"
					cfg-route="{path:'simpleGw/list/receive'}"
					countUrl="/km/imissive/km_imissive_receive_main/kmImissiveReceiveMain.do?method=getContentCount">
				<ui:iframe  id="kmImissiveReceive"  src="${LUI_ContextPath }/km/imissive/km_imissive_receive_main/index_content_receive.jsp?contentId=kmImissiveReceiveMessage&rwd=true"></ui:iframe>
			</ui:content>
			<ui:content
					id="kmImissiveSignMessage"
					title="${lfn:message('km-imissive:kmImissive.tree.Sign') }"
					cfg-route="{path:'simpleGw/list/sign'}"
					countUrl="/km/imissive/km_imissive_sign_main/kmImissiveSignMain.do?method=getContentCount">
				<ui:iframe id="kmImissiveSign" src="${LUI_ContextPath }/km/imissive/km_imissive_sign_main/index_content_sign.jsp?contentId=kmImissiveSignMessage&rwd=true"></ui:iframe>
			</ui:content>

			<c:choose>
				<c:when test="${isOffLineReader eq 'true'}">
					<ui:content
							id="kmImissiveSendOContent"
							title="${lfn:message('km-imissive:kmImissive.tree.Send') }"
							cfg-route="{path:'/listAll/send'}"
							countUrl="/km/imissive/km_imissive_send_main/kmImissiveSendMain.do?method=getContentCount&q.fdIsOffLine=1">
						<ui:iframe id="kmImissiveSend" src="${LUI_ContextPath }/km/imissive/km_imissive_send_main/index_content_send.jsp?contentId=kmImissiveSendOContent&rwd=true"></ui:iframe>
					</ui:content>
					<ui:content
							id="kmImissiveReceiveOContent"
							title="${lfn:message('km-imissive:kmImissive.tree.Receive') }"
							cfg-route="{path:'/listAll/receive'}"
							countUrl="/km/imissive/km_imissive_receive_main/kmImissiveReceiveMain.do?method=getContentCount&q.fdIsOffLine=1">
						<ui:iframe  id="kmImissiveReceive"  src="${LUI_ContextPath }/km/imissive/km_imissive_receive_main/index_content_receive.jsp?contentId=kmImissiveReceiveOContent&rwd=true"></ui:iframe>
					</ui:content>
					<ui:content
							id="kmImissiveSignOContent"
							title="${lfn:message('km-imissive:kmImissive.tree.Sign') }"
							cfg-route="{path:'/listAll/sign'}"
							countUrl="/km/imissive/km_imissive_sign_main/kmImissiveSignMain.do?method=getContentCount&q.fdIsOffLine=1">
						<ui:iframe id="kmImissiveSign" src="${LUI_ContextPath }/km/imissive/km_imissive_sign_main/index_content_sign.jsp?contentId=kmImissiveSignOContent&rwd=true"></ui:iframe>
					</ui:content>

					<%--普通模式--%>
					<ui:content
							id="kmImissiveSendSGwContent"
							title="${lfn:message('km-imissive:kmImissive.tree.Send') }"
							cfg-route="{path:'simpleGw/listOffLine/send'}"
							countUrl="/km/imissive/km_imissive_send_main/kmImissiveSendMain.do?method=getContentCount&q.fdIsOffLine=1">
						<ui:iframe id="kmImissiveSend" src="${LUI_ContextPath }/km/imissive/km_imissive_send_main/index_content_send.jsp?contentId=kmImissiveSendSGwContent&rwd=true"></ui:iframe>
					</ui:content>
					<ui:content
							id="kmImissiveReceiveSGwContent"
							title="${lfn:message('km-imissive:kmImissive.tree.Receive') }"
							cfg-route="{path:'simpleGw/listOffLine/receive'}"
							countUrl="/km/imissive/km_imissive_receive_main/kmImissiveReceiveMain.do?method=getContentCount&q.fdIsOffLine=1">
						<ui:iframe  id="kmImissiveReceive"  src="${LUI_ContextPath }/km/imissive/km_imissive_receive_main/index_content_receive.jsp?contentId=kmImissiveReceiveSGwContent&rwd=true"></ui:iframe>
					</ui:content>
					<ui:content
							id="kmImissiveSignSGwContent"
							title="${lfn:message('km-imissive:kmImissive.tree.Sign') }"
							cfg-route="{path:'simpleGw/listOffLine/sign'}"
							countUrl="/km/imissive/km_imissive_sign_main/kmImissiveSignMain.do?method=getContentCount&q.fdIsOffLine=1">
						<ui:iframe id="kmImissiveSign" src="${LUI_ContextPath }/km/imissive/km_imissive_sign_main/index_content_sign.jsp?contentId=kmImissiveSignSGwContent&rwd=true"></ui:iframe>
					</ui:content>
				</c:when>
				<c:otherwise>
					<ui:content
							id="kmImissiveSendOContent"
							title="${lfn:message('km-imissive:kmImissive.tree.Send') }">
						<ui:iframe id="kmImissiveSend" src="${LUI_ContextPath }/resource/jsp/e403.jsp"></ui:iframe>
					</ui:content>
					<ui:content
							id="kmImissiveReceiveOContent"
							title="${lfn:message('km-imissive:kmImissive.tree.Receive') }">
						<ui:iframe  id="kmImissiveReceive"  src="${LUI_ContextPath }/resource/jsp/e403.jsp"></ui:iframe>
					</ui:content>
					<ui:content
							id="kmImissiveSignOContent"
							title="${lfn:message('km-imissive:kmImissive.tree.Sign') }">
						<ui:iframe id="kmImissiveSign" src="${LUI_ContextPath }/resource/jsp/e403.jsp"></ui:iframe>
					</ui:content>
				</c:otherwise>
			</c:choose>

			<ui:content
					title="${lfn:message('km-imissive:kmImissive.tree.distributeRecord') }"
					id="kmImissiveMyDistributeContent"
					cfg-route="{path:'/exchange/mydistribute'}"
					countUrl="/km/imissive/km_imissive_reg/kmImissiveReg.do?method=getContentCount&q.fdDeliverType=1">
				<ui:iframe id="distribute" src="${LUI_ContextPath }/km/imissive/km_imissive_reg/index_content_reg_distribute.jsp?contentId=kmImissiveMyDistributeContent&rwd=true&path=/exchange/mydistribute"></ui:iframe>
			</ui:content>
			<ui:content
					title="${ lfn:message('km-imissive:kmImissive.tree.reportRecord') }"
					id="kmImissiveMyReportContent"
					cfg-route="{path:'/exchange/myreport'}"
					countUrl="/km/imissive/km_imissive_reg/kmImissiveReg.do?method=getContentCount&q.fdDeliverType=2">
				<ui:iframe id="distribute" src="${LUI_ContextPath }/km/imissive/km_imissive_reg/index_content_reg_report.jsp?contentId=kmImissiveMyReportContent&rwd=true&path=/exchange/myreport"></ui:iframe>
			</ui:content>
			<ui:content
					title="${ lfn:message('km-imissive:kmImissive.tree.mysign') }"
					id="kmImissiveMySignContent"
					cfg-route="{path:'/exchange/mysign'}"
					countUrl="/km/imissive/km_imissive_regdetail_list/kmImissiveRegDetailList.do?method=getContentCount&owner=true&mySign=true">
				<ui:iframe id="sign" src="${LUI_ContextPath }/km/imissive/km_imissive_regdetail_list/kmImissiveRegDetailList_mySign.jsp?contentId=kmImissiveMySignContent&rwd=true&path=/exchange/mysign"></ui:iframe>
			</ui:content>
			<ui:content
					title="${ lfn:message('km-imissive:kmImissive.tree.myreceive') }(内部)"
					id="kmImissiveMyReceiveContent"
					cfg-route="{path:'/exchange/myreceive'}"
					countUrl="/km/imissive/km_imissive_regdetail_list/kmImissiveRegDetailList.do?method=getContentCount&owner=true">
				<ui:iframe id="detaillist" src="${LUI_ContextPath }/km/imissive/km_imissive_regdetail_list/index_content_reglist.jsp?contentId=kmImissiveMyReceiveContent&rwd=true&path=/exchange/myreceive"></ui:iframe>
			</ui:content>
			<ui:content
					title="${ lfn:message('km-imissive:kmImissive.tree.myreceive') }(外部)"
					id="kmImissiveMyReceiveOuterContent"
					cfg-route="{path:'/exchange/myreceiveout'}"
					countUrl="/km/imissive/km_imissive_regdetail_list_outer/kmImissiveRegDetailListOuter.do?method=getContentCount&owner=true">
				<ui:iframe id="detaillistout" src="${LUI_ContextPath }/km/imissive/km_imissive_regdetail_list_outer/index_content_reglist.jsp?contentId=kmImissiveMyReceiveOuterContent&rwd=true&path=/exchange/myreceiveout"></ui:iframe>
			</ui:content>

			<%--普通模式--%>
			<ui:content
					title="${lfn:message('km-imissive:kmImissive.tree.distributeRecord') }"
					id="kmImissiveMyDistributeModel"
					cfg-route="{path:'simpleGw/exchangeSend/mydistribute'}"
					countUrl="/km/imissive/km_imissive_reg/kmImissiveReg.do?method=getContentCount&q.fdDeliverType=1">
				<ui:iframe id="distribute" src="${LUI_ContextPath }/km/imissive/km_imissive_reg/index_content_reg_distribute.jsp?contentId=kmImissiveMyDistributeModel&rwd=true&path=simpleGw/exchangeSend/mydistribute&fdRegType=1"></ui:iframe>
			</ui:content>
			<ui:content
					title="${ lfn:message('km-imissive:kmImissive.tree.reportRecord') }"
					id="kmImissiveMyReportModel"
					cfg-route="{path:'simpleGw/exchangeSend/myreport'}"
					countUrl="/km/imissive/km_imissive_reg/kmImissiveReg.do?method=getContentCount&q.fdDeliverType=2">
				<ui:iframe id="distribute" src="${LUI_ContextPath }/km/imissive/km_imissive_reg/index_content_reg_report.jsp?contentId=kmImissiveMyReportModel&rwd=true&path=simpleGw/exchangeSend/myreport&fdRegType=1"></ui:iframe>
			</ui:content>

			<%--收文--%>
			<ui:content
					title="${ lfn:message('km-imissive:kmImissive.tree.myreceive') }(内部)"
					id="kmImissiveMyReceiveReceive"
					cfg-route="{path:'simpleGw/exchangeReceive/myreceive'}"
					countUrl="/km/imissive/km_imissive_regdetail_list/kmImissiveRegDetailList.do?method=getContentCount&owner=true">
				<ui:iframe id="detaillist" src="${LUI_ContextPath }/km/imissive/km_imissive_regdetail_list/index_content_reglist.jsp?contentId=kmImissiveMyReceiveReceive&rwd=true&path=simpleGw/exchangeReceive/myreceive"></ui:iframe>
			</ui:content>
			<ui:content
					title="${ lfn:message('km-imissive:kmImissive.tree.myreceive') }(外部)"
					id="kmImissiveMyReceiveOuterReceive"
					cfg-route="{path:'simpleGw/exchangeReceive/myreceiveout'}"
					countUrl="/km/imissive/km_imissive_regdetail_list_outer/kmImissiveRegDetailListOuter.do?method=getContentCount&owner=true">
				<ui:iframe id="detaillistout" src="${LUI_ContextPath }/km/imissive/km_imissive_regdetail_list_outer/index_content_reglist.jsp?contentId=kmImissiveMyReceiveOuterReceive&rwd=true&path=simpleGw/exchangeReceive/myreceiveout"></ui:iframe>
			</ui:content>

			<ui:content id="kmImissiveStatContent" cfg-route="{path:'/preview'}" title="公文统计">
				<ui:iframe id="kmImissiveStatIframe" src="${LUI_ContextPath }/km/imissive/km_imissive_stat/index.jsp?contentId=kmImissiveStatContent&rwd=true"></ui:iframe>
			</ui:content>
		</ui:tabpanel>
	</template:replace>

	<template:replace name="script">
		<!-- JSP中建议只出现·安装模块·的JS代码，其余JS代码采用引入方式 -->
		<script type="text/javascript">
			seajs.use(['lui/framework/module', 'lui/framework/router/router-utils'],function(Module,routerUtils){
				var mode = '${getNavigationMode}';
				var modeStart;
				if("poly" == mode){
					modeStart = '/listCreateDoc';
				}else{
					modeStart = 'simpleGw/createSend';
				}
				Module.install('kmImissive',{
					//模块变量
					$var : {
						modeStart : modeStart
					},
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
				window.newPageWithParam = function(href, param){
					var router = routerUtils.getRouter();
					if (router) {
						router.push(href, param);
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
