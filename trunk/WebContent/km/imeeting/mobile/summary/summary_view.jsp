<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.landray.kmss.util.DateUtil"%>
<%@ page import="com.landray.kmss.km.imeeting.forms.KmImeetingSummaryForm"%>
<%@page import="com.landray.kmss.util.StringUtil"%>
<%@page import="com.landray.kmss.sys.attachment.model.SysAttMain"%>
<%@page import="com.landray.kmss.sys.attachment.util.SysAttViewerUtil"%>
<%@ page import="com.landray.kmss.sys.attachment.integrate.wps.util.SysAttWpsCloudUtil" %>
<%@ page import="com.landray.kmss.sys.attachment.integrate.wps.util.SysAttWpsCenterUtil" %>
<%@ taglib uri="/WEB-INF/KmssConfig/sys/mobile/mui.tld" prefix="mui"%>
<%@ taglib uri="/WEB-INF/KmssConfig/sys/person/person.tld" prefix="person"%>
<%@ include file="/sys/ui/jsp/common.jsp"%>
<%
	//移动端发布时间只显示日期，不显示时间
	KmImeetingSummaryForm kmImeetingSummaryForm = (KmImeetingSummaryForm)request.getAttribute("kmImeetingSummaryForm");
	kmImeetingSummaryForm.setDocPublishTime(DateUtil.convertDateToString(DateUtil.convertStringToDate(
			kmImeetingSummaryForm.getDocPublishTime(), DateUtil.TYPE_DATETIME,null), DateUtil.TYPE_DATE,null));
%>

<%
	// WPS云文档
	pageContext.setAttribute("_isWpsWebCloudEnable", new Boolean(SysAttWpsCloudUtil.isEnable()));
	// WPS中台
	pageContext.setAttribute("_isWpsCenterEnable", new Boolean(SysAttWpsCenterUtil.isEnable()));
%>
<template:include ref="mobile.view" compatibleMode="true">
	<template:replace name="head">
		<mui:min-file name="mui-imeeting-summaryview.css"/>
		<mui:min-file name="mui-task-view.css"/>
		<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/km/imeeting/mobile/resource/css/view.css" />
	</template:replace>
	
	<template:replace name="title">
		<c:if test="${not empty kmImeetingSummaryForm.fdName}">
			<c:out value="${ kmImeetingSummaryForm.fdName}"></c:out>
		</c:if>
		<c:if test="${empty kmImeetingSummaryForm.fdName}">
			<bean:message bundle="km-imeeting" key="module.km.imeeting"/>
		</c:if>
	</template:replace>
	
	<template:replace name="content">
		<div id="scrollView"  class="gray"
			data-dojo-type="mui/view/DocScrollableView">
			
			
			<div class="muiImeetingInfoNewBanner">

				<div class="muiImeetingInfoMask"></div>
			
				<div class="muiImeetingInfoCard">
					
					<div class="muiImeetingInfoHeaderBox">
						<!-- 会议名称 -->
						<div class="muiImeetingInfoTitle">
							<xform:text property="fdName"/>
						</div>
						<!-- 主持人 -->
						<div class="muiImeetingHostBox">
							<div class="muiImeetingInfoHost">
								<div class="avatar">
									<img src="<person:headimageUrl contextPath="true"  personId="${kmImeetingSummaryForm.fdHostId}" size="xm" />" alt="" />
									<!-- <i class="mui mui-tel"></i> -->
								</div>
								<div class="name">
									<xform:text property="fdHostName"/>
								</div>
							</div>
						</div>
						<!-- 会议状态 -->
						<div class="muiImeetingMStatus">
						</div>
					</div>
					<div class="muiImeetingUnderline"></div>
					
					<table class="bannerMeetingHeaderInfo">
						<tr>
							<td class="bannerTile">
								会议时间
							</td>
							<td>
								<div class="kmImeetingHeaderTimeBox">
									<div class="kmImeetingHeaderHoldTitleBox">
										<span id="meetingHoldDate" style="display: none;">
											<xform:datetime property="fdHoldDate" dateTimeType="datetime"/>
										</span>
										<div class="kmImeetingHeaderHoldTitle">
											开始
										</div>
										<div class="kmImeetingHeaderHoldDate" id="headerHoldDate">
										</div>
										<div class="kmImeetingHeaderHoldTime" id="headerHoldTime">
										</div>
									</div>
									
									<div class="kmImeetingHeaderTimeMiddleIcon">
									</div>
									
									<div class="kmImeetingHeaderEndTitleBox">
										<span id="meetingFinishDate" style="display: none;">
											<xform:datetime property="fdFinishDate" dateTimeType="datetime"/>
										</span>
										<div class="kmImeetingHeaderEndTitle">
											结束
										</div>
										<div class="kmImeetingHeaderEndDate" id="headerEndDate">
										</div>
										<div class="kmImeetingHeaderEndTime" id="headerEndTime">
										</div>
									</div>
								</div>
							</td>
						</tr>
						<tr>
							<td class="bannerTile">
								会议地点
							</td>
							<td>
								<c:choose>
									<c:when test="${not empty kmImeetingSummaryForm.fdVicePlaceNames or not empty kmImeetingSummaryForm.fdOtherVicePlace }">
										<div class="kmImeetingHeaderPlace">
											<xform:text property="fdPlaceName"/>
											<c:if test="${not empty kmImeetingSummaryForm.fdOtherPlace}">
												<xform:text property="fdOtherPlace"/>
											</c:if>
										</div>
										<div class="kmImeetingHeaderPlace">
											<xform:text property="fdVicePlaceNames"/>
											<xform:text property="fdOtherVicePlace"/>
										</div>
									</c:when>
									<c:otherwise>
										<c:if test="${not empty kmImeetingSummaryForm.fdPlaceName or not empty kmImeetingSummaryForm.fdOtherPlace }">
											<div class="kmImeetingHeaderPlace">
												<xform:text property="fdPlaceName"/>
												<c:if test="${not empty kmImeetingSummaryForm.fdOtherPlace}">
													<xform:text property="fdOtherPlace"/>
												</c:if>	
											</div>
										</c:if>
									</c:otherwise>
								</c:choose>
							</td>
						</tr>
					</table>
				</div>
			</div>
			
			<div data-dojo-type="mui/fixed/Fixed" id="fixed">
				<div data-dojo-type="mui/fixed/FixedItem"  class="ImeetingFixedItem">
					<%--切换页签--%>
					<div class="muiHeader">
						<div
							data-dojo-type="mui/nav/MobileCfgNavBar" 
							data-dojo-props=" defaultUrl:'/km/imeeting/mobile/summary/summary_view_nav.jsp?docStatus=${kmImeetingSummaryForm.docStatus }' ">
						</div>
					</div>
				</div>
			</div>
			
			<%--会议信息页签--%>
			<div id="contentView" data-dojo-type="dojox/mobile/View">
			
				<%-- 
				<kmss:auth requestURL="/sys/task/sys_task_main/sysTaskMain.do?method=add" requestMethod="GET">
					<ul data-dojo-type="sys/task/mobile/resource/js/OverflowTabBar">
    					<li data-dojo-type="mui/tabbar/TabBarButton" class="muiBtn muiBtnFeedback" 
  							data-dojo-props="icon:'mui mui-task-icon',colSize:2,href:'/sys/task/sys_task_main/sysTaskMain.do?method=add&fdModelId=${JsParam.fdId}&fdModelName=com.landray.kmss.km.imeeting.model.KmImeetingSummary'">${lfn:message('sys-task:tag.task')}</li>
					</ul>
				</kmss:auth>
				--%>
				
				<div class="muiAccordionPanelContent muiSummaryPanelContent" style="margin-top: 0;">
					<div class="muiFormContent">
						<table class="muiSimple" cellpadding="0" cellspacing="0">
							<%--会议模板--%>
							<tr>
								<td class="muiTitle">
									<bean:message bundle="km-imeeting" key="kmImeetingSummary.fdTemplate" />
								</td>
								<td>
									<xform:text property="fdTemplateName" mobile="true"/>
								</td>
							</tr>
							<%--会议主持人 --%>
							<tr>
								<td class="muiTitle">
									<bean:message bundle="km-imeeting" key="kmImeetingSummary.fdHost" />
								</td>
								<td>
									<c:if test="${not empty kmImeetingSummaryForm.fdHostId }">
										<xform:address propertyName="fdHostName" propertyId="fdHostId" mobile="true"/>
									</c:if>
									<c:if test="${not empty kmImeetingSummaryForm.fdOtherHostPerson }">
										&nbsp;<xform:text property="fdOtherHostPerson"/>
									</c:if>
								</td>
							</tr>
							<%--会议地点--%>
							<c:choose>
								<c:when test="${not empty kmImeetingSummaryForm.fdVicePlaceNames or not empty kmImeetingSummaryForm.fdOtherVicePlace }">
									<tr>
										<td class="muiTitle">
											<bean:message bundle="km-imeeting" key="kmImeetingMain.fdMainPlace"/>
										</td>
										<td>
											<xform:text property="fdPlaceName"/>
											<xform:text property="fdOtherPlace"/>
										</td>
									</tr>
									<tr>
										<td class="muiTitle">
											<bean:message bundle="km-imeeting" key="kmImeetingMain.fdVicePlace"/>
										</td>
										<td>
											<xform:text property="fdVicePlaceNames"/>
											<xform:text property="fdOtherVicePlace"/>
										</td>
									</tr>										
								</c:when>
								<c:otherwise>
									<tr>
										<td class="muiTitle">
											<bean:message bundle="km-imeeting" key="kmImeetingSummary.fdPlace" />
										</td>
										<td>
											<xform:text property="fdPlaceName"/>
											<xform:text property="fdOtherPlace"/>
										</td>
									</tr>
								</c:otherwise>
							</c:choose>
							<%--会议时间--%>
							<tr>
								<td class="muiTitle">
									<bean:message bundle="km-imeeting" key="kmImeetingMain.fdDate" />
								</td>
								<td>
									<c:out value="${kmImeetingSummaryForm.fdHoldDate }"/> ~
									<c:out value="${kmImeetingSummaryForm.fdFinishDate }"/>
								</td>
							</tr>
						</table>
					</div>
				</div>
				<div data-dojo-type="mui/panel/AccordionPanel" data-dojo-props="fixed:false">
					<%-- 相关任务 --%>
					<kmss:ifModuleExist path="/sys/task/">
						<div data-dojo-type="mui/panel/Content" data-dojo-props="title:'相关任务',icon:'mui-task-icon'">
							<div data-dojo-type="dojox/mobile/View">
								<ul data-dojo-type="sys/task/mobile/resource/js/list/SysTaskJsonStoreList"
									data-dojo-mixins="sys/task/mobile/resource/js/list/CalendarItemListMixin"
									data-dojo-props="url:'/sys/task/sys_task_main/sysTaskIndex.do?method=list&fdModelId=${kmImeetingSummaryForm.fdId}&fdModelName=com.landray.kmss.km.imeeting.model.KmImeetingSummary',lazy:false">
								</ul>

								<div class="muiAccordionPanelContentBottom">
									<kmss:auth requestURL="/sys/task/sys_task_main/sysTaskMain.do?method=add" requestMethod="GET">
										<button type="button"
												class="muiAccordionPanelContentBtn"
												onclick="window.open('${LUI_ContextPath }/sys/task/sys_task_main/sysTaskMain.do?method=add&fdModelId=${JsParam.fdId}&fdModelName=com.landray.kmss.km.imeeting.model.KmImeetingSummary', '_self')">
											+<bean:message bundle="km-imeeting" key="mobile.button.task.plan"/>
										</button>
									</kmss:auth>
								</div>
							</div>
						</div>
					</kmss:ifModuleExist>
				</div>
			</div>
			
			<%--会议人员页签--%>
			<div id="personView" data-dojo-type="dojox/mobile/View">
				<div data-dojo-type="mui/panel/AccordionPanel" data-dojo-props="fixed:false" style="margin-top: 0;">
					<%--参加人员 --%>
					<div data-dojo-type="mui/panel/Content" data-dojo-props="title:'<bean:message bundle="km-imeeting" key="kmImeetingSummary.fdPlanAttendPersons"/>',icon:''">
						<div class="txtContent">
							<ul class="muiMeetingList">
								<c:if test="${not empty kmImeetingSummaryForm.fdPlanAttendPersonIds }">
									<li>
										<div data-dojo-type="mui/person/PersonList" style="margin-left:.8rem;"
											data-dojo-props="title:'<bean:message bundle="km-imeeting"  key="mobile.kmImeetingMain.person.inner"/>',detailTitle:'<bean:message bundle="km-imeeting"  key="kmImeetingMain.fdAttendPersons"/>',personId:'${kmImeetingSummaryForm.fdPlanAttendPersonIds }'">											
										</div>
									</li>
								</c:if>
								<c:if test="${not empty kmImeetingSummaryForm.fdPlanOtherAttendPerson }">
									<li>
										<strong>
											<bean:message bundle="km-imeeting" key="kmImeetingMain.fdOtherPerson"/>
										</strong>
										<div class="staffList">
											<c:out value="${kmImeetingSummaryForm.fdPlanOtherAttendPerson }"/>
										</div>
									</li>
								</c:if>
							</ul>
						</div>
					</div>

					<!-- 邀请人员 -->
					<div data-dojo-type="mui/panel/Content" data-dojo-props="title:'<bean:message bundle="km-imeeting" key="kmImeetingSummary.fdPlanInvitePersons"/>',icon:''">
						<div class="txtContent">
							<ul class="muiMeetingList">
								<c:if test="${not empty kmImeetingSummaryForm.fdPlanInvitePersonIds  }">
									<li>
										<div data-dojo-type="mui/person/PersonList" style="margin-left:.8rem;"
											data-dojo-props="title:'<bean:message bundle="km-imeeting"  key="mobile.kmImeetingMain.person.inner"/>',detailTitle:'<bean:message bundle="km-imeeting"  key="kmImeetingMain.fdAttendPersons"/>',personId:'${kmImeetingSummaryForm.fdPlanInvitePersonIds }'">											
										</div>
									</li>
								</c:if>
							</ul>
						</div>
					</div>
					
					<%--列席人员 --%>
					<div data-dojo-type="mui/panel/Content" data-dojo-props="title:'<bean:message bundle="km-imeeting" key="kmImeetingSummary.fdPlanParticipantPersons"/>',icon:''">
						<div class="txtContent">
							<ul class="muiMeetingList">
								<c:if test="${not empty kmImeetingSummaryForm.fdPlanParticipantPersonIds }">
									<li>
										<div data-dojo-type="mui/person/PersonList" style="margin-left:.8rem;"
											data-dojo-props="title:'<bean:message bundle="km-imeeting"  key="mobile.kmImeetingMain.person.inner"/>',detailTitle:'<bean:message bundle="km-imeeting"  key="kmImeetingMain.fdParticipantPersons"/>',personId:'${kmImeetingSummaryForm.fdPlanParticipantPersonIds }'">
										</div>
									</li>
								</c:if>
								<c:if test="${not empty kmImeetingSummaryForm.fdPlanOtherParticipantPersons }">
									<li>
										<strong>
											<bean:message bundle="km-imeeting" key="kmImeetingMain.fdOtherPerson"/>
										</strong>
										<div class="staffList">
											<c:out value="${kmImeetingSummaryForm.fdPlanOtherParticipantPersons }"/>
										</div>
									</li>
								</c:if>
							</ul>
						</div>
					</div>
					
					<%--实际参加人员 --%>
					<div data-dojo-type="mui/panel/Content" data-dojo-props="title:'<bean:message bundle="km-imeeting" key="kmImeetingSummary.fdActualAttendPersons"/>',icon:''">
						<div class="txtContent">
							<ul class="muiMeetingList">
								<c:if test="${not empty kmImeetingSummaryForm.fdActualAttendPersonIds }">
									<li>
										<div data-dojo-type="mui/person/PersonList" style="margin-left:.8rem;"
										data-dojo-props="title:'<bean:message bundle="km-imeeting"  key="mobile.kmImeetingMain.person.inner"/>',detailTitle:'<bean:message bundle="km-imeeting"  key="kmImeetingSummary.fdActualAttendPersons"/>',personId:'${kmImeetingSummaryForm.fdActualAttendPersonIds }'">											
										</div>
									</li>
								</c:if>
								<c:if test="${not empty kmImeetingSummaryForm.fdActualOtherAttendPersons }">
									<li>
										<strong>
											<bean:message bundle="km-imeeting" key="kmImeetingMain.fdOtherPerson"/>
										</strong>
										<div class="staffList">
											<c:out value="${kmImeetingSummaryForm.fdActualOtherAttendPersons }"/>
										</div>
									</li>
								</c:if>
							</ul>
						</div>
					</div>
				</div>
			</div>

			<%--会议决议 --%>
			<div id="processView" data-dojo-type="dojox/mobile/View">
				<div data-dojo-type="mui/panel/AccordionPanel"
					data-dojo-props="fixed:false"
					style="margin-top: 0;">
					<div data-dojo-type="mui/panel/Content" class="proceePanelContent" data-dojo-props="title:'<bean:message bundle="km-imeeting" key="mobile.kmImeetingSummary.desion"/>',icon:''">
						<c:if test="${kmImeetingSummaryForm.fdContentType=='rtf'}">
							<div id="_____rtf_____docContent" class="muiFieldRtf">
								${kmImeetingSummaryForm.docContent}
							</div>
						</c:if>
						<c:if test="${kmImeetingSummaryForm.fdContentType=='word'}">
							<c:choose>
								<c:when test="${pageScope._isWpsWebCloudEnable == 'true'}">
									<c:import url="/sys/attachment/mobile/viewer/wps/cloud/sysAttMain_view.jsp" charEncoding="UTF-8">
										<c:param name="fdKey" value="editonline" />
										<c:param name="fdModelId" value="${kmImeetingSummaryForm.fdId}" />
										<c:param name="fdModelName" value="com.landray.kmss.km.imeeting.model.KmImeetingSummary" />
										<c:param name="formBeanName" value="kmImeetingSummaryForm" />
										<c:param name="load" value="false" />
									</c:import>
								</c:when>
								<c:when test="${pageScope._isWpsCenterEnable == 'true'}">
									<c:import url="/sys/attachment/mobile/viewer/wps/center/sysAttMain_view.jsp" charEncoding="UTF-8">
										<c:param name="fdKey" value="editonline" />
										<c:param name="fdModelId" value="${kmImeetingSummaryForm.fdId}" />
										<c:param name="fdModelName" value="com.landray.kmss.km.imeeting.model.KmImeetingSummary" />
										<c:param name="formBeanName" value="kmImeetingSummaryForm" />
										<c:param name="load" value="false" />
									</c:import>
								</c:when>
								<c:otherwise>
									<c:set var="___attForms" value="${kmImeetingSummaryForm.attachmentForms['editonline']}" />
									<c:if test="${___attForms!=null && fn:length(___attForms.attachments)>0}">
										<c:forEach var="sysAttMain" items="${___attForms.attachments}" varStatus="vsStatus">
											<c:set var="attMainId" value="${sysAttMain.fdId }"></c:set>
											<%
												SysAttMain sysAttMain = (SysAttMain) pageContext.getAttribute("sysAttMain");
												String path = SysAttViewerUtil.getViewerPath(sysAttMain, request);
												if (StringUtil.isNotNull(path)){
													pageContext.setAttribute("hasThumbnail", "true");
													pageContext.setAttribute("hasViewer", "true");
												}
												pageContext.setAttribute("_sysAttMain", sysAttMain);
											%>
										</c:forEach>
									</c:if>
									<div class="muiReadButton" >
										<c:import url="/sys/attachment/mobile/import/viewContent.jsp" charEncoding="UTF-8">
											<c:param name="formName" value="kmImeetingSummaryForm"/>
											<c:param name="fdKey" value="editonline"/>
										</c:import>
									</div>
								</c:otherwise>
							</c:choose>
						</c:if>
						
						<%--附件--%>
						<c:import url="/sys/attachment/mobile/import/view.jsp" charEncoding="UTF-8">
							<c:param name="formName" value="kmImeetingSummaryForm" />
							<c:param name="fdKey" value="attachment" />
							<c:param name="fdModelId" value="${JsParam.fdId }" />
							<c:param name="fdModelName" value="com.landray.kmss.km.imeeting.model.KmImeetingSummary" />
						</c:import> 
						
						<%--查阅会议纪要--%>
						<c:if test="${not empty kmImeetingSummaryForm.fdMeetingId}">
						<kmss:auth
							requestURL="/km/imeeting/km_imeeting_main/kmImeetingMain.do?method=view&fdId=${kmImeetingSummaryForm.fdMeetingId}"
							requestMethod="GET">
							<div class="muiReadButton" onclick="window.open('${LUI_ContextPath}/km/imeeting/km_imeeting_main/kmImeetingMain.do?method=view&fdId=${kmImeetingSummaryForm.fdMeetingId}','_self')">
	        					<bean:message bundle="km-imeeting"  key="mobile.kmImeetingSummary.viewNotify"/>
	        				</div>
						</kmss:auth>
						</c:if>
						
					</div>
					
					<c:if test="${kmImeetingSummaryForm.docStatus < '30'}">
						<div data-dojo-type="mui/panel/Content" class="muiImeetingPanelContent" data-dojo-props="title:'流程记录',icon:''">
							<c:import url="/sys/lbpmservice/mobile/lbpm_audit_note/import/view.jsp" charEncoding="UTF-8">
								<c:param name="fdModelId" value="${kmImeetingSummaryForm.fdId }"/>
								<c:param name="fdModelName" value="com.landray.kmss.km.imeeting.model.KmImeetingSummary"/>
								<c:param name="formBeanName" value="kmImeetingSummaryForm"/>
							</c:import>
						</div>
					</c:if>
				</div>
			</div>
			
			<%-- editUrl="javascript:building();" --%>
			<%--底部按钮 --%>
			<template:include file="/sys/lbpmservice/mobile/import/tarbar.jsp"
				  formName="kmImeetingSummaryForm"
				  viewName="lbpmView"
				  allowReview="true">
				<template:replace name="flowArea">
					<c:import url="/sys/bookmark/mobile/import/view.jsp" charEncoding="UTF-8">
					  <c:param name="fdModelName" value="com.landray.kmss.km.imeeting.model.KmImeetingSummary"/>
					  <c:param name="fdModelId" value="${kmImeetingSummaryForm.fdId}"/>
					  <c:param name="fdSubject" value="${kmImeetingSummaryForm.fdName}"/>
					  <c:param name="showOption" value="label"/>
				  	</c:import>
				</template:replace>
				<template:replace name="publishArea">
					<c:import url="/sys/bookmark/mobile/import/view.jsp" charEncoding="UTF-8">
					  <c:param name="fdModelName" value="com.landray.kmss.km.imeeting.model.KmImeetingSummary"/>
					  <c:param name="fdModelId" value="${kmImeetingSummaryForm.fdId}"/>
					  <c:param name="fdSubject" value="${kmImeetingSummaryForm.fdName}"/>
					  <c:param name="showOption" value="label"/>
				  	</c:import>
				</template:replace>
			</template:include>
		</div>
			
		<%--流程信息 --%>	
		<c:import url="/sys/lbpmservice/mobile/import/view.jsp" charEncoding="UTF-8">
			<c:param name="formName" value="kmImeetingSummaryForm" />
			<c:param name="fdKey" value="ImeetingSummary" />
			<c:param name="viewName" value="lbpmView" />
			<c:param name="backTo" value="scrollView" />
		</c:import>	
		
		<!-- 钉钉图标 -->
		<kmss:ifModuleExist path="/third/ding">
			<c:import url="/third/ding/import/ding_view.jsp" charEncoding="UTF-8">
				<c:param name="formName" value="kmImeetingSummaryForm" />
			</c:import>
		</kmss:ifModuleExist>
		<kmss:ifModuleExist path="/third/lding">
			<c:import url="/third/lding/import/ding_view.jsp" charEncoding="UTF-8">
				<c:param name="formName" value="kmImeetingSummaryForm" />
			</c:import>
		</kmss:ifModuleExist>
		<kmss:ifModuleExist path="/third/govding">
			<c:import url="/third/govding/import/ding_view.jsp" charEncoding="UTF-8">
				<c:param name="formName" value="kmImeetingSummaryForm" />
			</c:import>
		</kmss:ifModuleExist>
		<!-- 钉钉图标 end -->
	</template:replace>


</template:include>
<script type="text/javascript">
require(['dojo/ready', 'dojo/_base/array','dojo/topic','dojo/query','dijit/registry','dojo/dom-geometry','mui/rtf/RtfResize', 'mui/util'],
		function(ready, array,topic,query,registry,domGeometry,RtfResize, util){
	
	//切换标签重新计算高度
	var _position=domGeometry.position(query('#fixed')[0]),
		_scrollTop=0;
	topic.subscribe("/mui/list/_runSlideAnimation",function(srcObj, evt) {
		_scrollTop= Math.abs(evt.to.y);
	});
	topic.subscribe("/mui/navitem/_selected",function(){
		var view=registry.byId("scrollView");
		
		if(_scrollTop > _position.y){
			view.handleToTopTopic(null,{
				y: 0 - (_position.y)
			});
		}
	});
	
	//切换标签时resize rtf中的表格
	var hasResize=false;
	topic.subscribe("/mui/navitem/_selected",function(widget,args){
		setTimeout(function(){
			var processView=registry.byId("processView");
			if(!hasResize && processView && processView.isVisible() ){
				var arr=query('.muiFieldRtf');
				array.forEach(arr,function(item){
					new RtfResize({
						containerNode:item
					});
				});
				hasResize=true;
			}
		},100);
	});
	
	// 阅读word形式的纪要
	window.readWord = function() {
		var type = "${_sysAttMain.fdContentType}";
		var href = '${KMSS_Parameter_ContextPath}sys/attachment/sys_att_main/sysAttMain.do?method=view&fdId=${_sysAttMain.fdId}&viewer=aspose_mobilehtmlviewer';
		var downLoadUrl = "${KMSS_Parameter_ContextPath}sys/attachment/sys_att_main/sysAttMain.do?method=download&fdId=${_sysAttMain.fdId}";
		var hasViewer = "${hasViewer }";
		if(hasViewer !='true' && type !='img'){
			href = downLoadUrl;
		}
		window.location.href=href;
	};
	
	function initMeetingDate() {
		var fdHoldTimeStr = query('#meetingHoldDate')[0].innerText.trim();
		var fdEndTimeStr = query('#meetingFinishDate')[0].innerText.trim();
		if (fdHoldTimeStr) {
			var fdHoldTimeObj = util.parseDate(fdHoldTimeStr, "yyyy-MM-dd HH:mm");
			query('#content #headerHoldDate')[0].innerHTML = getDateTimeMessage(fdHoldTimeObj, "MM:dd:D");
			query('#content #headerHoldTime')[0].innerHTML = getDateTimeMessage(fdHoldTimeObj, "HH:mm");
		}
		
		if (fdEndTimeStr) {
			var fdEndTimeObj = util.parseDate(fdEndTimeStr, "yyyy-MM-dd HH:mm");
			query('#content #headerEndDate')[0].innerHTML = getDateTimeMessage(fdEndTimeObj, "MM:dd:D");
			query('#content #headerEndTime')[0].innerHTML = getDateTimeMessage(fdEndTimeObj, "HH:mm");
		}
		
	}
	
	ready(function(){
		initMeetingDate();
	});
	
	function getDateTimeMessage(fdTime, type) {
		
		// 小时分钟
		if ("HH:mm" == type) {
			
			// 小时
			var hour =  fdTime.getHours() < 10 ? "0" + fdTime.getHours() : fdTime.getHours();
			
			// 分钟
			var min = fdTime.getMinutes() < 10 ? "0" + fdTime.getMinutes() : fdTime.getMinutes();
			
			return hour + ":" + min;
		}
		
		// 月份日期带周几
		if ("MM:dd:D" == type) {
			
			var week = new Array("周日", "周一", "周二", "周三", "周四", "周五", "周六");
			
			// 月份
			var month = fdTime.getMonth();
			
			// 号
			var date = fdTime.getDate();
			
			// 礼拜几
			var day = fdTime.getDay();
			
			return (month + 1) + "月" + date + "号" + " " + week[day];
		}
	};
	
	
});
$(document).ready(function(){
	var ul = $('ul[data-dojo-type="sys/task/mobile/resource/js/OverflowTabBar"]');
	if(ul.length&&ul.length>0){
		$('.muiSummaryPanelContent').css('margin','0px');
		ul.css('background-color','#eeeeee');
	}
});
</script>


