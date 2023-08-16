<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="/sys/ui/jsp/common.jsp" %>
<%@page import="com.landray.kmss.km.imeeting.util.KmImeetingConfigUtil"%>
<%
	String imissiveSummaryEnable = KmImeetingConfigUtil.imissiveSummaryEnable();
	request.setAttribute("imissiveSummaryEnable", imissiveSummaryEnable);
%>
<%
	request.setAttribute("isCurAdmin", UserUtil.getKMSSUser().isAdmin());
%>
<template:include ref="default.list" spa="true" rwd="true">
	<template:replace name="title">
		<c:out value="${ lfn:message('km-imeeting:module.km.imeeting') }" />
	</template:replace>
    <template:replace name="nav">
        <div class="lui_list_nav_frame">
        	<ui:accordionpanel>
        		<ui:content title="会议管理">
                  	<ui:combin ref="menu.nav.simple">
  						<ui:varParam name="source">
  							<ui:source type="Static">
  								[
								<kmss:authShow roles="ROLE_KMIMEETING_WORKBENCH_READER">
									{
										"text" : "个人工作台",
										"href" :  "/myWorkbench",
										"router" : true,
										"icon" : "lui_iconfont_navleft_com_calendar"
									},
								</kmss:authShow>
								{
  									"text" : "我的日历",
			  						"href" :  "/mycalendar",
									"router" : true,
									"icon" : "lui_iconfont_navleft_com_calendar"	
  								}, {
  									"text" : "会议看板",
			  						"href" :  "/mainBoard",
									"router" : true,
									"icon" : "lui_iconfont_navleft_com_calendar"	
  								}]
  							</ui:source>
  						</ui:varParam>
  					</ui:combin>
  				</ui:content>
        	</ui:accordionpanel>
            <ui:accordionpanel>
               	<ui:content title="会议议题">
                  	<ui:combin ref="menu.nav.simple">
  						<ui:varParam name="source">
  							<ui:source type="Static">
  								[
  									{
	  									"text" : "议题申报",
				  						"href" :  "/topicDraft",
										"router" : true,
										"icon" : "lui_iconfont_navleft_com_my_drafted"	
	  									},
	  								{
	  									"text" : "议题审批",
				  						"href" :  "/topicApproval",
										"router" : true,
										"icon" : "lui_iconfont_navleft_imissive_beapproval"
  									},
  									{
	  									"text" : "议题库",
				  						"href" :  "/allTopic",
										"router" : true,
										"icon" : "lui_iconfont_navleft_imissive_outgoingdepot"
		  							}
	  							]
  							</ui:source>
  						</ui:varParam>
  					</ui:combin>
  				</ui:content>
				<ui:content title="会议方案">
                  	<ui:combin ref="menu.nav.simple">
  						<ui:varParam name="source">
  							<ui:source type="Static">
  								[
  									{
	  									"text" : "会议方案申报",
				  						"href" :  "/schemeDrafted",
										"router" : true,
										"icon" : "lui_iconfont_navleft_com_my_drafted"	
	  									},
	  								{
	  									"text" : "会议方案审批",
				  						"href" :  "/schemeApproval",
										"router" : true,
										"icon" : "lui_iconfont_navleft_imissive_beapproval"
  									},
  									{
	  									"text" : "会议方案库",
				  						"href" :  "/allScheme",
										"router" : true,
										"icon" : "lui_iconfont_navleft_imissive_outgoingdepot"
		  							}
	  							]
  							</ui:source>
  						</ui:varParam>
  					</ui:combin>
  				</ui:content>
               	<ui:content title="会议通知">
                  	<ui:combin ref="menu.nav.simple">
  						<ui:varParam name="source">
  							<ui:source type="Static">
  								[
  									{
	  									"text" : "通知起草",
				  						"href" :  "/imeetingDraft",
										"router" : true,
										"icon" : "lui_iconfont_navleft_com_my_drafted"	
	  								},
  									{
	  									"text" : "通知审批",
				  						"href" :  "/mainApproval",
										"router" : true,
										"icon" : "lui_iconfont_navleft_com_my_beapproval"
		  							},
  									{
	  									"text" : "通知查看",
				  						"href" :  "/mainView",
										"router" : true,
										"icon" : "lui_iconfont_navleft_com_my_approvaled"
		  							}
	  							]
  							</ui:source>
  						</ui:varParam>
  					</ui:combin>
  				</ui:content>
  				<ui:content title="会议纪要">
                  	<ui:combin ref="menu.nav.simple">
  						<ui:varParam name="source">
  							<ui:source type="Static">
  								[
  									{
	  									"text" : "起草纪要",
				  						"href" :  "/summaryDrafted",
										"router" : true,
										"icon" : "lui_iconfont_navleft_com_my_drafted"	
	  								},
  									{
	  									"text" : "纪要审批",
				  						"href" :  "/summaryApproval",
										"router" : true,
										"icon" : "lui_iconfont_navleft_imissive_beapproval"
		  							},
  									{
	  									"text" : "纪要查看",
				  						"href" :  "/summaryView",
										"router" : true,
										"icon" : "lui_iconfont_navleft_imissive_outgoingdepot"
		  							}
	  							]
  							</ui:source>
  						</ui:varParam>
  					</ui:combin>
  				</ui:content>
  				<ui:content title="${ lfn:message('km-imeeting:kmImeeting.tree.stat') }">
					<ui:combin ref="menu.nav.simple">
  						<ui:varParam name="source">
		  					<ui:source type="Static">
			  					[
				  					{
				  						"text" : "${ lfn:message('km-imeeting:kmImeeting.tree.stat.dept')}",
				  						"href" :  "/dept_stat",
				  						"router" : true,
					  					"icon" : "lui_iconfont_navleft_com_calendar"
				  					}, 
				  					{
				  						"text" : "${ lfn:message('km-imeeting:kmImeeting.tree.stat.person')}",
				  						"href" :  "/person_stat",
				  						"router" : true,
					  					"icon" : "lui_iconfont_navleft_imeeting_reserve"
				  					}, {
				  						"text" : "${ lfn:message('km-imeeting:kmImeeting.tree.stat.res')}",
				  						"href" :  "/resource_stat",
				  						"router" : true,
					  					"icon" : "lui_iconfont_navleft_imeeting_reserve"
				  					}
				  				]
		  					</ui:source>
				  		</ui:varParam>
			  		</ui:combin>
				</ui:content>
  				<ui:content title="其他操作">
  					<ui:combin ref="menu.nav.simple">
  						<ui:varParam name="source">
  							<ui:source type="Static">
  								[
  									{
					  					"text" : "${lfn:message('km-imeeting:kmImeeting.abandom') }",
										"href" :  "/discard",
										"router" : true,  					
					  					"icon" : "lui_iconfont_navleft_com_discard"
		  							}
		  							<kmss:authShow roles="ROLE_KMIMEETING_BACKSTAGE_MANAGER">
		  							, {
  										"text" : "${ lfn:message('list.manager') }",
										"href":"javascript:LUI.pageOpen('${LUI_ContextPath }/sys/profile/moduleindex.jsp?nav=/km/imeeting/tree.jsp','_rIframe');",
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
	    <style>
			.lui_tabpanel_list_navs_item_l{
			    max-width: 20%!important;
			}
		</style>
        <ui:tabpanel id="kmImeetingPanel" layout="sys.ui.tabpanel.list" cfg-router="true">
        	<ui:content id="mycalendar" title="会议议题" cfg-route="{path:'/mycalendar'}">
			 	<ui:iframe cfg-takeHash="true" src="${LUI_ContextPath }/km/imeeting/km_imeeting_calendar/mycalendar_gov.jsp"></ui:iframe>
			</ui:content>
        	<!-- 待我审的议题 -->
			<ui:content id="topicMyTodo" title="待我审的" cfg-route="{path:'/topicMyTodo'}">
			 	<ui:iframe 
			 		cfg-takeHash="true" 
			 		src="${LUI_ContextPath }/km/imeeting/km_imeeting_topic/index_approval.jsp">
			 	</ui:iframe>
			</ui:content>
       		 <!-- 我已审的议题 -->
			<ui:content id="topicMyDone" title="我已审的" cfg-route="{path:'/topicMyDone'}">
			 	<ui:iframe 
			 		cfg-takeHash="true" 
			 		src="${LUI_ContextPath }/km/imeeting/km_imeeting_topic/index_approved.jsp">
			 	</ui:iframe>
			</ui:content>
			
			<!-- 待我审的方案 -->
			<ui:content id="schemeMyTodo" title="待我审的" cfg-route="{path:'/schemeMyTodo'}">
			 	<ui:iframe 
			 		cfg-takeHash="true" 
			 		src="${LUI_ContextPath }/km/imeeting/km_imeeting_scheme/index_approval.jsp">
			 	</ui:iframe>
			</ui:content>
			<!-- 我已审的方案 -->
			<ui:content id="schemeMyDone" title="我已审的" cfg-route="{path:'/schemeMyDone'}">
			 	<ui:iframe 
			 		cfg-takeHash="true" 
			 		src="${LUI_ContextPath }/km/imeeting/km_imeeting_scheme/index_approved.jsp">
			 	</ui:iframe>
			</ui:content>

			<!-- 会议看板 -->
		  	<ui:content id="mainBoard" title="会议看板" cfg-route="{path:'/mainBoard'}">
		 	 	<ui:iframe src="${LUI_ContextPath }/km/imeeting/km_imeeting_calendar/index_content_place.jsp" ></ui:iframe>
		  	</ui:content>

			<!-- 会议工作台 -->
			<ui:content id="myWorkbench" title="会议工作台" cfg-route="{path:'/myWorkbench'}">
				<ui:iframe src="${LUI_ContextPath }/km/imeeting/km_imeeting_main/kmImeetingMain_workBench.jsp" ></ui:iframe>
			</ui:content>

		  	<!-- 我起草的会议 -->
		  	<ui:content id="mainDraft" title="我起草的" cfg-route="{path:'/mainDraft'}">
		 	 	<ui:iframe
		 	 		src="${LUI_ContextPath }/km/imeeting/km_imeeting_main/index_myDraft.jsp?j_path=%2FmeetingMain%2FmainDraft&docType=myDraft" >
		 	 	</ui:iframe>
			</ui:content>

			<!-- 待我审的通知 -->
			<ui:content id="mainMyTodo" title="待我审的" cfg-route="{path:'/mainMyTodo'}">
				<ui:iframe
					src="${LUI_ContextPath }/km/imeeting/km_imeeting_main/index_approval.jsp">
				</ui:iframe>
			</ui:content>

			<!-- 我已审的通知 -->
			<ui:content id="mainMyDone" title="我已审的" cfg-route="{path:'/mainMyDone'}">
				<ui:iframe
					src="${LUI_ContextPath }/km/imeeting/km_imeeting_main/index_approved.jsp">
				</ui:iframe>
			</ui:content>
		  	
		  	<c:choose>
	        	<c:when test="${imissiveSummaryEnable == 'true'}">
					<!-- 待我审的纪要 -->
					<ui:content id="summaryMyTodo" title="待我审的" cfg-route="{path:'/summaryMyTodo'}">
					 	<ui:iframe 
					 		cfg-takeHash="true" 
					 		src="${LUI_ContextPath }/km/imissive/include/send/index_content_send_approval.jsp?urlParam=fdModelName:com.landray.kmss.km.imeeting.model.KmImeetingMain@isRelationFile:1">
					 	</ui:iframe>
					</ui:content>
					
					<!-- 我已审的纪要 -->
					<ui:content id="summaryMyDone" title="我已审的" cfg-route="{path:'/summaryMyDone'}">
					 	<ui:iframe 
					 		cfg-takeHash="true" 
					 		src="${LUI_ContextPath }/km/imissive/include/send/index_content_send_approved.jsp?urlParam=fdModelName:com.landray.kmss.km.imeeting.model.KmImeetingMain@isRelationFile:1">
					 	</ui:iframe>
					</ui:content>
				</c:when>
				<c:otherwise>
					<!-- 待我审的纪要 -->
					<ui:content id="summaryMyTodo" title="待我审的" cfg-route="{path:'/summaryMyTodo'}">
					 	<ui:iframe cfg-takeHash="true" src="${LUI_ContextPath }/km/imeeting/km_imeeting_summary/index_approval.jsp"></ui:iframe>
					</ui:content>
					
					<!-- 我已审的纪要 -->
					<ui:content id="summaryMyDone" title="我已审的" cfg-route="{path:'/summaryMyDone'}">
					 	<ui:iframe cfg-takeHash="true" src="${LUI_ContextPath }/km/imeeting/km_imeeting_summary/index_approved.jsp"></ui:iframe>
					</ui:content>
				</c:otherwise>
			</c:choose>
			
			<% if (UserUtil.getKMSSUser().isAdmin()) { %>
				<ui:content id="allTopic" title="议题库" cfg-route="{path:'/allTopic'}">
				 	<ui:iframe 
				 		cfg-takeHash="true" 
				 		src="${LUI_ContextPath }/km/imeeting/km_imeeting_topic/index_admin.jsp">
				 	</ui:iframe>
				</ui:content>
				<ui:content id="allScheme" title="方案库" cfg-route="{path:'/allScheme'}">
				 	<ui:iframe 
				 		cfg-takeHash="true" 
				 		src="${LUI_ContextPath }/km/imeeting/km_imeeting_scheme/index_admin.jsp">
				 	</ui:iframe>
				</ui:content>
				<ui:content id="mainView" title="通知查看" cfg-route="{path:'/mainView'}">
			 	 	<ui:iframe 
			 	 		src="${LUI_ContextPath }/km/imeeting/km_imeeting_main/index_content_admin.jsp">
			 	 	</ui:iframe>
			  	</ui:content>
			  	<c:choose>
		        	<c:when test="${imissiveSummaryEnable == 'true'}">
						<ui:content id="summaryView" title="纪要查看" cfg-route="{path:'/summaryView'}">
						 	<ui:iframe 
						 		cfg-takeHash="true" 
						 		src="${LUI_ContextPath }/km/imissive/include/send/index_content_send_admin.jsp?urlParam=fdModelName:com.landray.kmss.km.imeeting.model.KmImeetingMain@isRelationFile:1">
						 	</ui:iframe>
						</ui:content>
					</c:when>
					<c:otherwise>
						<ui:content id="summaryView" title="纪要查看" cfg-route="{path:'/summaryView'}">
						 	<ui:iframe cfg-takeHash="true" src="${LUI_ContextPath }/km/imeeting/km_imeeting_summary/index_admin.jsp"></ui:iframe>
						</ui:content>
					</c:otherwise>
				</c:choose>
			<% } else { %>
				<ui:content id="allTopic" title="议题库" cfg-route="{path:'/allTopic'}">
				 	<ui:iframe 
				 		cfg-takeHash="true" 
				 		src="${LUI_ContextPath }/km/imeeting/km_imeeting_topic/index.jsp">
				 	</ui:iframe>
				</ui:content>
				<ui:content id="allScheme" title="方案库" cfg-route="{path:'/allScheme'}">
				 	<ui:iframe 
				 		cfg-takeHash="true" 
				 		src="${LUI_ContextPath }/km/imeeting/km_imeeting_scheme/index.jsp">
				 	</ui:iframe>
				</ui:content>
				<ui:content id="mainView" title="通知查看" cfg-route="{path:'/mainView'}">
			 	 	<ui:iframe 
			 	 		src="${LUI_ContextPath }/km/imeeting/km_imeeting_main/index_content_meetingFixed.jsp">
			 	 	</ui:iframe>
			  	</ui:content>
			  	<c:choose>
		        	<c:when test="${imissiveSummaryEnable == 'true'}">
						<ui:content id="summaryView" title="纪要查看" cfg-route="{path:'/summaryView'}">
						 	<ui:iframe 
						 		cfg-takeHash="true" 
						 		src="${LUI_ContextPath }/km/imissive/include/send/index_content_send.jsp?urlParam=fdModelName:com.landray.kmss.km.imeeting.model.KmImeetingMain@isRelationFile:1">
						 	</ui:iframe>
						</ui:content>
					</c:when>
					<c:otherwise>
						<ui:content id="summaryView" title="纪要查看" cfg-route="{path:'/summaryView'}">
						 	<ui:iframe cfg-takeHash="true" src="${LUI_ContextPath }/km/imeeting/km_imeeting_summary/index_content_summary.jsp"></ui:iframe>
						</ui:content>
					</c:otherwise>
				</c:choose>
			<% } %>
			<!-- 议题废弃箱 -->
			<ui:content id="topicDiscard" title="会议议题" cfg-route="{path:'/topicDiscard'}">
			 	<ui:iframe cfg-takeHash="true" src="${LUI_ContextPath }/km/imeeting/km_imeeting_topic/index_discard.jsp"></ui:iframe>
			</ui:content>
			
			<!-- 方案废弃箱 -->
			<ui:content id="schemeDiscard" title="会议方案" cfg-route="{path:'/schemeDiscard'}">
			 	<ui:iframe cfg-takeHash="true" src="${LUI_ContextPath }/km/imeeting/km_imeeting_scheme/index_discard.jsp"></ui:iframe>
			</ui:content>
			
			<!-- 通知废弃箱 -->
			<ui:content id="mainDiscard" title="会议通知" cfg-route="{path:'/mainDiscard'}">
			 	<ui:iframe cfg-takeHash="true" src="${LUI_ContextPath }/km/imeeting/km_imeeting_main/index_discard.jsp"></ui:iframe>
			</ui:content>
			<c:choose>
		        <c:when test="${imissiveSummaryEnable == 'true'}">
					<!-- 纪要废弃箱 -->
					<ui:content id="summaryDiscard" title="会议纪要" cfg-route="{path:'/summaryDiscard'}">
					 	<ui:iframe cfg-takeHash="true" src="${LUI_ContextPath }/km/imissive/include/send/index_content_send_discard.jsp?fdModelName=com.landray.kmss.km.imeeting.model.KmImeetingMain"></ui:iframe>
					</ui:content>
				</c:when>
				<c:otherwise>
					<ui:content id="summaryDiscard" title="会议纪要" cfg-route="{path:'/summaryView'}">
					 	<ui:iframe cfg-takeHash="true" src="${LUI_ContextPath }/km/imeeting/km_imeeting_summary/index_discard.jsp"></ui:iframe>
					</ui:content>
				</c:otherwise>
			</c:choose>
			
			 <ui:content id="deptStat" title="${lfn:message('list.manager') }" cfg-route="{path:'/dept_stat'}">
		 	 	<ui:iframe src="${LUI_ContextPath }/km/imeeting/import/kmImeeting_stat.jsp?stat_key=dept.stat&title=kmImeetingStat.dept.stat"></ui:iframe>
		 	</ui:content>
		    <ui:content id="deptStatMon" title="${lfn:message('list.manager') }" cfg-route="{path:'/dept_statMon'}">
		 		<ui:iframe src="${LUI_ContextPath }/km/imeeting/import/kmImeeting_stat.jsp?stat_key=dept.statMon&title=kmImeetingStat.dept.statMon"></ui:iframe>
		  	</ui:content>
		 	<ui:content id="personStat" title="${lfn:message('list.manager') }" cfg-route="{path:'/person_stat'}">
		 		<ui:iframe src="${LUI_ContextPath }/km/imeeting/import/kmImeeting_stat.jsp?stat_key=person.stat&title=kmImeetingStat.person.stat"></ui:iframe>
		  	</ui:content>
			<ui:content id="personStatMon" title="${lfn:message('list.manager') }" cfg-route="{path:'/person_statMon'}">
				<ui:iframe src="${LUI_ContextPath }/km/imeeting/import/kmImeeting_stat.jsp?stat_key=person.statMon&title=kmImeetingStat.person.statMon"></ui:iframe>
			</ui:content>
			<ui:content id="resourceStat" title="${lfn:message('list.manager') }" cfg-route="{path:'/resource_stat'}">
				<ui:iframe src="${LUI_ContextPath }/km/imeeting/import/kmImeeting_stat.jsp?stat_key=resource.stat&title=kmImeetingStat.resource.stat"></ui:iframe>
			</ui:content>
			<ui:content id="resourceStatMon" title="${lfn:message('list.manager') }" cfg-route="{path:'/resource_statMon'}">
				<ui:iframe src="${LUI_ContextPath }/km/imeeting/import/kmImeeting_stat.jsp?stat_key=resource.statMon&title=kmImeetingStat.resource.statMon"></ui:iframe>
			</ui:content>
			
		</ui:tabpanel>
		<%-- 当前用户是否用户查阅工作台角色 --%>
		<c:set var="isWorkbenchReader" value="false" />
		<kmss:authShow roles="ROLE_KMIMEETING_WORKBENCH_READER">
			<c:set var="isWorkbenchReader" value="true" />
		</kmss:authShow>

        <script>
	        seajs.use(['lui/framework/module', 'lui/framework/router/router-utils'], function(Module, routerUtils){
	        	window.openSearch = function(url) {
	    			LUI.pageOpen(url,'_rIframe');
	    		};

	        	// 是否管理员
	    		var isCurAdmin = "${isCurAdmin}";
	    		// 是否拥有查阅工作台权限
	    		var isWorkbenchReader = "${isWorkbenchReader}";

	    		/**
				 * startpath : 二级页面的默认页面
				 * 如果有查阅工作台权限，默认展示个人工作台
				 * 否则展示我的日历
	    		 */
				var startpath = "/mycalendar";
				if (isWorkbenchReader == "true") {
					startpath = "/myWorkbench";
				}

	        	Module.install('kmImeeting',{
					//模块变量
					$var : {
						isCurAdmin : isCurAdmin,
						startpath : startpath
					},
					//模块多语言
					$lang : {
					},
				});
	        });
        </script>
        <c:choose>
        	<c:when test="${imissiveSummaryEnable == 'true'}">
        		<script type="text/javascript" src="${LUI_ContextPath}/km/imeeting/resource/js/index_gov.js"></script>
    		</c:when>
    		<c:otherwise>
    			<script type="text/javascript" src="${LUI_ContextPath}/km/imeeting/resource/js/index_gov2.js"></script>
    		</c:otherwise>
        </c:choose>
        
    </template:replace>
</template:include>