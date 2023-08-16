<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/sys/ui/jsp/common.jsp"%>
<%@ taglib uri="/WEB-INF/KmssConfig/sys/mobile/mui.tld" prefix="mui"%>
<%@page import="com.landray.kmss.km.imeeting.util.KmImeetingConfigUtil"%>
<%
	String imissiveSummaryEnable = KmImeetingConfigUtil.imissiveSummaryEnable();
	request.setAttribute("imissiveSummaryEnable", imissiveSummaryEnable);
%>
<c:set var="tiny" value="true" scope="request" />
<template:include ref="mobile.list" canHash="true">
	<template:replace name="title">
		<c:out value="${lfn:message('km-imeeting:mobile.myApproval')}"></c:out>
	</template:replace>
	<template:replace name="head">
		<link rel="Stylesheet" type="text/css" href="${LUI_ContextPath}/km/imeeting/mobile/resource/css/index.css?s_cache=${MUI_Cache}" />
		<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/km/imeeting/mobile/resource/css/button.css?s_cache=${MUI_Cache}"></link>
		<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/km/imeeting/mobile/resource/css/list.css?s_cache=${MUI_Cache}"></link>
		<link rel="Stylesheet" type="text/css" href="${LUI_ContextPath}/km/imeeting/mobile/resource/css/meeting.css?s_cache=${MUI_Cache}" />   
	</template:replace>
	<template:replace name="content">
	
		<c:set var="canCreateTopic" value="false"></c:set>
		<c:set var="canCreateScheme" value="false"></c:set>
		<c:set var="canCreateMain" value="false"></c:set>
		<c:set var="canCreateSummary" value="false"></c:set>
		
		<kmss:authShow roles="ROLE_KMIMEETING_TOPIC_CREATE">
			<c:set var="canCreateTopic" value="true"></c:set>
		</kmss:authShow>
		<kmss:authShow roles="ROLE_KMIMEETING_SCHEME_CREATE">
			<c:set var="canCreateScheme" value="true"></c:set>
		</kmss:authShow>
		<kmss:authShow roles="ROLE_KMIMEETING_CREATE">
			<c:set var="canCreateMain" value="true"></c:set>
		</kmss:authShow>
		
		<c:if test="${imissiveSummaryEnable=='true'}">
			<kmss:authShow roles="ROLE_KMIMISSIVE_SEND_CREATE">
				<c:set var="canCreateSummary" value="true"></c:set>
			</kmss:authShow>
		</c:if>
		
		<script type="text/javascript">
			window.isImissiveRole = "false";
			<kmss:authShow roles="ROLE_KMIMISSIVE_DEFAULT">
				window.isImissiveRole = "true";
			</kmss:authShow>
		</script>
		
		<div>
		<%-- 导航头部，通常放导航页签、搜索 --%>
		<div data-dojo-type="mui/header/Header" data-dojo-props="height:'4.4rem'" class="muiHeaderNav">
		    <%-- Tab页签（注：当使用MobileCfgNavBar构建页签栏时，如果有模块有配置扩展点，则优先通过modelName从“移动办公--移动应用管理--应用页签配置”）读取数据 ，若无相关配置数据则读取defaultUrl配置的静态数据 --%>
			<div data-dojo-type="mui/nav/MobileCfgNavBar"
				 data-dojo-props="defaultUrl:'/km/imeeting/mobile/nav_approval.jsp'"> 
			</div>
		</div>
		
		<!-- 二级筛选 -->
		<div data-dojo-type="mui/header/NavHeader"></div>
		
		<!--  页签内容展示区域，可纵向上下滑动   -->
		<div data-dojo-type="mui/list/NavView">
			<ul data-dojo-type="mui/list/HashJsonStoreList"
				data-dojo-mixins="km/imeeting/mobile/resource/js/CommonItemListMixin">
			</ul>
		</div>
		
		<c:if test="${param.showBottomTabBar eq 'true'}">
			<ul id="tabs" fixed="bottom"
				data-dojo-type="mui/tabbar/TabBar"
				data-dojo-props='fill:"always",syncWithViews:true'>
			  	<li id="tab2Calendar"
				  		data-dojo-type="mui/tabbar/TabBarButton" 
				  		data-dojo-props="href:'/km/imeeting/mobile/index.jsp',transition: 'none',
			  			icon1: '${LUI_ContextPath }/km/imeeting/mobile/resource/images/btn_huiyi_normal@1x.png',
		  				icon2: '${LUI_ContextPath }/km/imeeting/mobile/resource/images/btn_huiyi_press@1x.png'">
			  		<bean:message bundle="km-imeeting" key="mobile.myMeeting" />
			  	</li>
			  	<li data-dojo-type="mui/tabbar/TabBarButton" class="kmImeetingIndexTabLi"
			  			data-dojo-props="selected: true,href:'/km/imeeting/mobile/index_approval.jsp?showBottomTabBar=true',transition: 'none',
			  			icon1: '${LUI_ContextPath }/km/imeeting/mobile/resource/images/btn_shenpi_normal@1x.png',
		  				icon2: '${LUI_ContextPath }/km/imeeting/mobile/resource/images/btn_shenpi_press@1x.png'">
				  	<bean:message bundle="km-imeeting" key="mobile.myApproval" />
				</li>
			  	<c:choose>
					<c:when test="${imissiveSummaryEnable == 'true'}">
						<kmss:authShow roles="ROLE_KMIMISSIVE_DEFAULT">
							<li data-dojo-type="mui/tabbar/TabBarButton"
						  			data-dojo-props="href:'/km/imeeting/mobile/summary/imissive/index.jsp',transition: 'none',
						  			icon1: '${LUI_ContextPath }/km/imeeting/mobile/resource/images/btn_huiyijiyao_normal@1x.png',
					  				icon2: '${LUI_ContextPath }/km/imeeting/mobile/resource/images/btn_huiyijiyao_press@1x.png'">
						  		<bean:message bundle="km-imeeting" key="mobile.meetingSummary" />
						  	</li>
						</kmss:authShow>
					</c:when>
					<c:otherwise>
						<li data-dojo-type="mui/tabbar/TabBarButton"
					  			data-dojo-props="href:'/km/imeeting/mobile/summary/index.jsp',transition: 'none',
					  			icon1: '${LUI_ContextPath }/km/imeeting/mobile/resource/images/btn_huiyijiyao_normal@1x.png',
				  				icon2: '${LUI_ContextPath }/km/imeeting/mobile/resource/images/btn_huiyijiyao_press@1x.png'">
					  		<bean:message bundle="km-imeeting" key="mobile.meetingSummary" />
					  	</li>
					</c:otherwise>
				</c:choose>
			</ul>
			
		</c:if>
		</div>
		
		<!-- 新建摁钮 -->
		<c:if test="${canCreateTopic eq 'true' || canCreateScheme eq 'true' || canCreateMain eq 'true' || canCreateSummary eq 'true'}">
			<div data-dojo-type="sys/mportal/module/mobile/elements/Button"
				data-dojo-props="icon:'muis-new',datas:[
				<c:if test="${canCreateTopic eq 'true'}">
					{
					'icon':'${LUI_ContextPath }/km/imeeting/mobile/resource/images/add_topic@1x.png',
					'text':'<bean:message bundle="km-imeeting" key="mobile.btn.addTopiv" />',
					'click':function(){
							require(['mui/simplecategory/SimpleCategoryUtil'], function(SimpleCategoryUtil){
								SimpleCategoryUtil.create({
									  key: 'createTopic',
					                  createUrl: '/km/imeeting/km_imeeting_topic/kmImeetingTopic.do?method=add&i.docTemplate=!{curIds}&fdTemplateId=!{curIds}&mobile=true',
					                  modelName: 'com.landray.kmss.km.imeeting.model.KmImeetingTopicCategory',
					                  mainModelName: 'com.landray.kmss.km.imeeting.model.KmImeetingTopic',
					                  showFavoriteCate:'false',
					         		  authType: '02'
					            });
							});
				    	}
					},
				</c:if>
				<c:if test="${canCreateScheme eq 'true'}">
					{
					'icon':'${LUI_ContextPath }/km/imeeting/mobile/resource/images/add_scheme@1x.png',
					'text':'<bean:message bundle="km-imeeting" key="mobile.btn.addScheme" />',
				    'click': function(){
							require(['mui/syscategory/SysCategoryUtil'], function(SysCategoryUtil){
				   	    		SysCategoryUtil.create({
									  key: 'createScheme',
					                  createUrl: '/km/imeeting/km_imeeting_scheme/kmImeetingScheme.do?method=add&i.docTemplate=!{curIds}&fdTemplateId=!{curIds}&mobile=true',
					                  modelName: 'com.landray.kmss.km.imeeting.model.KmImeetingSchemeTemplate',
					                  mainModelName: 'com.landray.kmss.km.imeeting.model.KmImeetingScheme',
					                  showFavoriteCate:'true',
					         		  authType: '02'
					            });
			   	    		});
			   	   	 	}
					},
				</c:if>
				<c:if test="${canCreateMain eq 'true'}">
					{
					'icon':'${LUI_ContextPath }/km/imeeting/mobile/resource/images/add_main@1x.png',
					'text':'<bean:message bundle="km-imeeting" key="mobile.btn.addMain" />',
					'click':function(){
							require(['mui/syscategory/SysCategoryUtil'], function(SysCategoryUtil){
								SysCategoryUtil.create({
									  key: 'createMeeting',
					                  createUrl: '/km/imeeting/km_imeeting_main/kmImeetingMain.do?method=add&fdTemplateId=!{curIds}&mobile=true',
					                  modelName: 'com.landray.kmss.km.imeeting.model.KmImeetingTemplate',
					                  mainModelName: 'com.landray.kmss.km.imeeting.model.KmImeetingMain',
					                  showFavoriteCate:'true',
					         		  authType: '02'
					            });
							});
				    	}
					},
				</c:if>
				<c:if test="${canCreateSummary eq 'true'}">
					{
					'icon':'${LUI_ContextPath }/km/imeeting/mobile/resource/images/add_summary@1x.png',
					'text':'<bean:message bundle="km-imeeting" key="mobile.btn.addSummary" />',
					'click':function(){
							require(['mui/syscategory/SysCategoryUtil'], function(SysCategoryUtil){
								SysCategoryUtil.create({
									  key: 'createSummary',
					                  createUrl: '/km/imissive/km_imissive_send_main/kmImissiveSendMain.do?method=add&fdModelName=com.landray.kmss.km.imeeting.model.KmImeetingMain&isRelationFile=1&fdTemplateId=!{curIds}&mobile=true',
					                  modelName: 'com.landray.kmss.km.imissive.model.KmImissiveSendTemplate',
					                  mainModelName: 'com.landray.kmss.km.imissive.model.KmImissiveSendMain',
					                  showFavoriteCate:'true',
					         		  authType: '02'
					            });
							});
				    	}
					}
				</c:if>
				]">
			</div>
		</c:if>
		 <c:if test="${JsParam.swapIndex != null && JsParam.swapIndex != ''}">
			<script>
				localStorage['swapIndex:${LUI_ContextPath}/km/imeeting/mobile/index_approval.jsp'] = '${JsParam.swapIndex}';
			</script>
		</c:if>
		
	</template:replace>
</template:include>

