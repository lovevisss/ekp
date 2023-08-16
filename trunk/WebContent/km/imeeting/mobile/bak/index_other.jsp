<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/sys/ui/jsp/common.jsp"%>
<c:set var="tiny" value="true" scope="request" />
<template:include ref="mobile.list" canHash="true"> 
	<template:replace name="title">
		<c:if test="${JsParam.moduleName!=null && JsParam.moduleName!=''}">
			${HtmlParam.moduleName}
		</c:if>
		<c:if test="${JsParam.moduleName==null or JsParam.moduleName==''}">
			<bean:message bundle="km-imeeting" key="module.km.imeeting"/>
		</c:if>
	</template:replace>
	<template:replace name="head">
		<link rel="Stylesheet" href="${LUI_ContextPath}/km/imeeting/mobile/resource/css/list.css?s_cache=${MUI_Cache}" />
		<link rel="Stylesheet" href="${LUI_ContextPath}/km/imeeting/mobile/resource/css/meeting.css?s_cache=${MUI_Cache}" />
	</template:replace>
	<template:replace name="content">
		
		<div id="other" data-dojo-type="mui/tabbar/TabBarView">

			<ul class="otherMenuList">
				<!-- 会议审批 -->
				<li onclick="openPlaceAudit()">
					<i class="mui_meeting_other_audit"></i>
					<span><bean:message bundle="km-imeeting" key="mobile.audit.metting" /></span>
					<i class="mui mui-forward"></i>
					<i class="mui"><span id="placeAuditBadge" style="display:none;">0</span></i>
				</li>
				<!-- 会议查询 -->
				<li onclick="openMeetingList()">
					<i class="mui_meeting_other_search"></i>
					<span><bean:message bundle="km-imeeting" key="mobile.meetingSearch" /></span>
					<i class="mui mui-forward"></i>
				</li>
				<!-- 会议统计 -->
				<li onclick="openMeetingStatistics()">
					<i class="mui_meeting_other_stat"></i>
					<span><bean:message bundle="km-imeeting" key="mobile.meetingStatistics" /></span>
					<i class="mui mui-forward"></i>
				</li>
				
			</ul>

			<script>
				
				require(['dojo/request', 'dojo/dom', 'dojo/html', 'dojo/dom-style'], function(request, dom, html, domStyle) {
					
					
					window.openPlaceAudit = function() {
						window.open('${LUI_ContextPath}/km/imeeting/mobile/audit_list.jsp', '_self');
					}
					
					window.openMeetingList = function() {
						window.open('${LUI_ContextPath}/km/imeeting/mobile/index_list.jsp', '_self');
					}
					
					window.openMeetingStatistics = function() {
						window.open('${LUI_ContextPath}/km/imeeting/mobile/statistics_list.jsp', '_self');
					}
					
					
					request('${LUI_ContextPath}/km/imeeting/km_imeeting_main/kmImeetingMain.do?method=getAuditCount', {
						method: 'get',
						handleAs: 'json'
					}).then(function(res){
						
						var count = res ? (res.count || 0) : 0;
						var placeAuditBadgeNode = dom.byId('placeAuditBadge');
						html.set(placeAuditBadgeNode, count);
						if(count <= 0) {
							domStyle.set(placeAuditBadgeNode, 'display', 'none');
						} else {
							domStyle.set(placeAuditBadgeNode, 'display', 'inline-block');
						}
						
					}, function(err) {
						console.error(err);
					});
					
				});
			
			</script>
		
		</div>
		
		<ul id="tabs"
			data-dojo-type="mui/tabbar/TabBar" fixed="bottom" 
			data-dojo-props='
				fill:"always",
				syncWithViews:true
			'>
		  	<c:choose>
				<c:when test="${JsParam.showList == true }">
				  	<li id="tab2Calendar"
				  		data-dojo-type="mui/tabbar/TabBarButton" 
				  		data-dojo-props="
				  			transition: 'none',
				  			href:'/km/imeeting/mobile/index_list_my.jsp?showList=${JsParam.showList}',
				  			icon1: '${LUI_ContextPath }/km/imeeting/mobile/resource/images/icon_footer_my@2x.png',
				  			icon2: '${LUI_ContextPath }/km/imeeting/mobile/resource/images/icon_footer_my_select@2x.png'
			  			"><bean:message bundle="km-imeeting" key="mobile.myMeeting" /> </li>
	  			</c:when>
	  			<c:otherwise>
	  				<li id="tab2Calendar"
			  		data-dojo-type="mui/tabbar/TabBarButton" 
			  		data-dojo-props="
			  			transition: 'none',
			  			href:'/km/imeeting/mobile/index.jsp',
			  			icon1: '${LUI_ContextPath }/km/imeeting/mobile/resource/images/icon_footer_my@2x.png',
			  			icon2: '${LUI_ContextPath }/km/imeeting/mobile/resource/images/icon_footer_my_select@2x.png'
		  			"><bean:message bundle="km-imeeting" key="mobile.myMeeting" /> </li>
	  			</c:otherwise>
			</c:choose>
		  	<li data-dojo-type="mui/tabbar/TabBarButton"
		  		data-dojo-props="
		  			transition: 'none',
		  			href:'/km/imeeting/mobile/index_place_new.jsp?showList=${JsParam.showList}',
		  			callback: function(){ window.navigate2View('place') },
		  			icon1: '${LUI_ContextPath }/km/imeeting/mobile/resource/images/icon_footer_place@2x.png',
		  			icon2: '${LUI_ContextPath }/km/imeeting/mobile/resource/images/icon_footer_place_select@2x.png'
		  		"><bean:message bundle="km-imeeting" key="mobile.meetingRoom" /></li>
		  	<li data-dojo-type="mui/tabbar/TabBarButton"
		  		data-dojo-props="
		  			transition: 'none',
		  			href:'/km/imeeting/mobile/index_summary.jsp?showList=${JsParam.showList}',
		  			icon1: '${LUI_ContextPath }/km/imeeting/mobile/resource/images/icon_footer_summary@2x.png',
		  			icon2: '${LUI_ContextPath }/km/imeeting/mobile/resource/images/icon_footer_summary_select@2x.png'
	  			"><bean:message bundle="km-imeeting" key="mobile.meetingSummary" /></li>
		  	<li data-dojo-type="mui/tabbar/TabBarButton"
		  		data-dojo-props="
		  			selected: true,
		  			href:'/km/imeeting/mobile/index_other.jsp?showList=${JsParam.showList}',
		  			icon1: '${LUI_ContextPath }/km/imeeting/mobile/resource/images/icon_footer_more@2x.png',
		  			icon2: '${LUI_ContextPath }/km/imeeting/mobile/resource/images/icon_footer_more_select@2x.png'
	  			"><bean:message bundle="km-imeeting" key="mobile.other" /></li>
		</ul>
		
	</template:replace>
</template:include>