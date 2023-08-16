<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/sys/ui/jsp/common.jsp"%>
<%@ page import="com.landray.kmss.km.imeeting.util.ImeetingCateUtil"%>
<%@page import="com.landray.kmss.km.imeeting.util.KmImeetingConfigUtil"%>
<%@page import="com.landray.kmss.util.ResourceUtil"%>
<%@page import="com.landray.kmss.util.DateUtil"%>
<%@page import="java.util.Date"%>
<% 
	request.setAttribute("userId", UserUtil.getUser().getFdId());
	request.setAttribute("defaultCateId", ImeetingCateUtil.getfirstCate()); 
	request.setAttribute("nowDate", DateUtil.convertDateToString(new Date(), ResourceUtil.getString("date.format.date")));
	request.setAttribute("useCycle", KmImeetingConfigUtil.isCycle());
%>
<c:set var="tiny" value="true" scope="request" />
<template:include ref="mobile.list" > 
	<template:replace name="title">
		<c:if test="${JsParam.moduleName!=null && JsParam.moduleName!=''}">
			${HtmlParam.moduleName}
		</c:if>
		<c:if test="${JsParam.moduleName==null or JsParam.moduleName==''}">
			<bean:message bundle="km-imeeting" key="module.km.imeeting"/>
		</c:if>
	</template:replace>
	<template:replace name="head">
		<link rel="Stylesheet" href="${LUI_ContextPath}/km/imeeting/mobile/resource/css/index.css?s_cache=${MUI_Cache}" />
		<link rel="Stylesheet" href="${LUI_ContextPath}/km/imeeting/mobile/resource/css/list.css?s_cache=${MUI_Cache}" />
		<mui:min-file name="mui-imeeting.js"/>
	</template:replace>
	<template:replace name="content">
		
		<c:set var="canCreateMeeting" value="false"></c:set>
		<c:set var="canCreateCloud" value="false"></c:set>
		<c:set var="canCreateBook" value="false"></c:set>
		
		<kmss:authShow roles="ROLE_KMIMEETING_CREATE">
			<c:set var="canCreateMeeting" value="true"></c:set>
		</kmss:authShow>
		<c:if test="${useCloud}"> 
			<kmss:authShow roles="ROLE_KMIMEETING_CREATE_CLOUD">
				<c:set var="canCreateCloud" value="true"></c:set>
			</kmss:authShow>
		</c:if>
		<kmss:authShow roles="ROLE_KMIMEETING_BOOKCREATE">
			<c:set var="canCreateBook" value="true"></c:set>
		</kmss:authShow>
		
		<div id="place" data-dojo-type="mui/tabbar/TabBarView">

			<div data-dojo-type="mui/header/Header" class="meetingHeader" data-dojo-props="height:'4rem'"  style="border-bottom: none">
				 
				 <div data-dojo-type="km/imeeting/mobile/resource/js/list/PlaceCateSelect" class="placeCateSelect" style="height:100%"
				 	  data-dojo-props="url:'/km/imeeting/km_imeeting_res/kmImeetingRes.do?method=getAllCate',name:'fdPeriodId',mul:false,showStatus:'edit',value:'${defaultCateId}'">
				 </div>
				 
				 <!--  
				 <div data-dojo-type="km/imeeting/mobile/resource/js/list/PlaceDateSelect" class="placeCateSelect" style="height:100%"
				 	  data-dojo-props="url:'/km/imeeting/km_imeeting_book/kmImeetingBook.do?method=generateTime',name:'fdTime',mul:false,showStatus:'edit'">
				 </div>
				 -->
				 
		 		 <div data-dojo-type="km/imeeting/mobile/resource/js/list/PlaceDatePicker" class="placeCateSelect" style="height:100%"
		 		 		data-dojo-mixins="mui/datetime/_DateMixin"
						data-dojo-props="canClear: false, value:'${nowDate }'">
				 </div>
				 
			</div> 
			
			<div class="muiMeetingBookContainer">
				<div id="timeBar" data-dojo-type="km/imeeting/mobile/resource/js/list/TimeBar" ></div>
				<div data-dojo-type="km/imeeting/mobile/resource/js/list/PlaceBar"  data-dojo-props="curCateId:'${defaultCateId}'">
				</div>
				<div id="placeContent" data-dojo-type="km/imeeting/mobile/resource/js/list/PlaceContentScrollView">
					<div data-dojo-type="km/imeeting/mobile/resource/js/list/PlaceContent" class="placeContentContainer"></div>
				</div>
			</div>
			
			
			<div data-dojo-type="km/imeeting/mobile/resource/js/list/PlaceBottom"  
				data-dojo-mixins="km/imeeting/mobile/resource/js/PlaceBottomMixin"
				data-dojo-props="height:'27.5rem'">
			</div>
			
			<div id="ImeetingCreateFrame">
			
				<c:if test="${canCreateBook == true }">
					<div onclick="createBook()">
						<div class="create_title">会议预约</div>
						<div class="create_desc">直接占用会议室,可用于非会议场景</div>
					</div>
				</c:if>
			
				<c:if test="${canCreateCloud == true }">
					<div onclick="createCloudMeeting()">
						<div class="create_title">临时会议</div>
						<div class="create_desc">临时性直接召开,无需走模版流程</div>
					</div>
				</c:if>
				<c:if test="${canCreateMeeting == true }">
					<div data-dojo-type="km/imeeting/mobile/resource/js/CreateButton"
						data-dojo-mixins="mui/syscategory/SysCategoryMixin" 
				   		data-dojo-props="
				   			createUrl:'/km/imeeting/km_imeeting_main/kmImeetingMain.do?method=add&fdTemplateId=!{curIds}&fdTime=!{fdTime}&fdStratTime=!{fdStartTime}&fdFinishTime=!{fdFinishTime}&resId=!{resId}',
				   			mainModelName:'com.landray.kmss.km.imeeting.model.KmImeetingMain',
				   			modelName:'com.landray.kmss.km.imeeting.model.KmImeetingTemplate',
				   			showFavoriteCate:'true',
				   			authType: '02',
				   			icon1:'',
				   			key: 'normalMeeting'"
						>
						<div class="create_title">会议安排</div>
						<div class="create_desc">内置会议安排模版,提前统筹各项工作</div>
					</div>
				</c:if>
				
				<c:if test="${useCycle eq 'true'}">
					<c:if test="${canCreateMeeting == true }">
						<div data-dojo-type="km/imeeting/mobile/resource/js/CreateButton"
							data-dojo-mixins="mui/syscategory/SysCategoryMixin" 
					   		data-dojo-props="
					   			createUrl:'/km/imeeting/km_imeeting_main/kmImeetingMain.do?method=add&fdTemplateId=!{curIds}&fdTime=!{fdTime}&fdStratTime=!{fdStartTime}&fdFinishTime=!{fdFinishTime}&resId=!{resId}&isCycle=true',
					   			mainModelName:'com.landray.kmss.km.imeeting.model.KmImeetingMain',
					   			modelName:'com.landray.kmss.km.imeeting.model.KmImeetingTemplate',
					   			showFavoriteCate:'true',
					   			authType: '02',
					   			icon1:'',
					   			key: 'cycleMeeting'"
							>
							<div class="create_title">周期会议</div>
							<div class="create_desc">设置会议周期规则,快捷批量设置</div>
						</div>
					</c:if>
				</c:if>
			</div>
			
			<script>
		        require(['dijit/registry', 'dojo/dom', 'dojo/on', 'dojo/dom-attr', 'dojo/topic', 'mui/util', 'dojo/_base/lang',
		                 'mui/dialog/Tip', 'dojo/domReady'],
		        		function(registry, dom, on, domAttr, topic, util, lang, Tip, ready){
		    		
					var placeNode = dom.byId('place');
					
					window.__MEETING_CREATE_PAYLOAD__ = {};
					
					on(dom.byId('ImeetingCreateFrame'), 'click', function(e) {
						var target = e.target;
						if(target && target.id == 'ImeetingCreateFrame') {
							domAttr.set(placeNode, 'data-create-active', 'false');
						}
					});
		        	
		        	topic.subscribe('/km/imeeting/create', function(ctx, payload) {
		        		
		        		if('${canCreateCloud}' == 'true' || '${canCreateMeeting}' == 'true' || '${canCreateBook}' == 'true') {        			
			        		domAttr.set(placeNode, 'data-create-active', 'true');
			        		window.__MEETING_CREATE_PAYLOAD__ = payload;
		        		} else {
		        			Tip.tip({icon:'mui mui-warn', text:'很抱歉，您没有预约会议权限！',width:'260',height:'60'});
		        		}
		        		
		        	});
		        	
		        	topic.subscribe('/km/imeeting/changeview', function(view) {
		        		
		        		if(view != 'place') {
		        			return;
		        		}
		        		
		        		topic.publish('/km/imeeting/place/resize');
		    			topic.publish('/km/imeeting/timeNavBar/resetTransform');
		    			topic.publish('/km/imeeting/placeNavBar/resetTransform');
		        	});
		        	
					window.createBook = function() {
						
						var url = lang.replace('${LUI_ContextPath}/km/imeeting/km_imeeting_book/kmImeetingBook.do?method=add&' + 
								'fdTime={fdTime}&fdStratTime={fdStartTime}&fdFinishTime={fdFinishTime}&resId={resId}', window.__MEETING_CREATE_PAYLOAD__ || {});
						
						window.open(url, '_self');
					}
					
					window.createCloudMeeting = function() {
						
						var url = lang.replace('${LUI_ContextPath}/km/imeeting/km_imeeting_main/kmImeetingMain.do?method=add&' + 
								'fdTime={fdTime}&fdStratTime={fdStartTime}&fdFinishTime={fdFinishTime}&resId={resId}', window.__MEETING_CREATE_PAYLOAD__ || {});
						
						window.open(url, '_self');
						
					}
		
					window.onresize = function(){
		    	        	
						var timeBar = registry.byId('timeBar');
						var placeContent = registry.byId('placeContent');
		    			 
						timeBar.setTransformMaxHeight();
						placeContent.resize();
		    			 
		    	    };
		    	    
		    	    // 解决首次进入会议室列表错位情况
		    	    ready(function() {
		    	    	topic.publish('/km/imeeting/changeview', 'place');
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
		  			selected: true,
		  			href:'/km/imeeting/mobile/index_place_new.jsp?showList=${JsParam.showList}',
		  			callback: function(){ window.navigate2View('place') },
		  			icon1: '${LUI_ContextPath }/km/imeeting/mobile/resource/images/icon_footer_place@2x.png',
		  			icon2: '${LUI_ContextPath }/km/imeeting/mobile/resource/images/icon_footer_place_select@2x.png'
		  		"><bean:message bundle="km-imeeting" key="mobile.meetingRoom" /></li>
		  	<li data-dojo-type="mui/tabbar/TabBarButton"
		  		data-dojo-props="
		  			href:'/km/imeeting/mobile/index_summary.jsp?showList=${JsParam.showList}',
		  			transition: 'none',
		  			icon1: '${LUI_ContextPath }/km/imeeting/mobile/resource/images/icon_footer_summary@2x.png',
		  			icon2: '${LUI_ContextPath }/km/imeeting/mobile/resource/images/icon_footer_summary_select@2x.png'
	  			"><bean:message bundle="km-imeeting" key="mobile.meetingSummary" /></li>
		  	<li data-dojo-type="mui/tabbar/TabBarButton"
		  		data-dojo-props="
		  			href:'/km/imeeting/mobile/index_other.jsp?showList=${JsParam.showList}',
		  			transition: 'none',
		  			icon1: '${LUI_ContextPath }/km/imeeting/mobile/resource/images/icon_footer_more@2x.png',
		  			icon2: '${LUI_ContextPath }/km/imeeting/mobile/resource/images/icon_footer_more_select@2x.png'
	  			"><bean:message bundle="km-imeeting" key="mobile.other" /></li>
		</ul>
		
	</template:replace>
</template:include>