<%@page import="java.util.Date"%>
<%@page import="com.landray.kmss.util.ResourceUtil"%>
<%@page import="com.landray.kmss.util.DateUtil"%>
<%@page import="com.landray.kmss.km.imeeting.util.KmImeetingConfigUtil"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/sys/ui/jsp/common.jsp"%>
<%@ include file="/km/imeeting/import/time.jsp"%>

<template:include ref="mobile.view" compatibleMode="true" tiny="true">
	
	<template:replace name="csshead">
		<mui:cache-file name="mui-imeeting-view.css" cacheType="md5"/>
		<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/km/imeeting/mobile/resource/css/view.css" />
		<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/sys/task/mobile/resource/css/view.css" />
	</template:replace>
	
	<template:replace name="head">
		<mui:min-file name="mui-imeeting.js"/>
	</template:replace>
	
	<template:replace name="loading">
		<c:import url="/km/imeeting/mobile/main/view_banner.jsp"  charEncoding="UTF-8">
			<c:param name="formBeanName" value="kmImeetingMainForm" />
			<c:param name="loading" value="true" />
		</c:import>
	</template:replace>
	
	<template:replace name="title">
		<c:if test="${not empty kmImeetingMainForm.fdName}">
			<c:out value="${ kmImeetingMainForm.fdName}"></c:out>
		</c:if>
		<c:if test="${empty kmImeetingMainForm.fdName}">
			<bean:message bundle="km-imeeting" key="module.km.imeeting"/>
		</c:if>
	</template:replace>
	<template:replace name="content">
		<div id="scrollView"  class="gray"
			data-dojo-type="mui/view/DocScrollableView"
			data-dojo-mixins="mui/list/_ViewPushAppendMixin">
			
			<%-- 会议历史操作信息隐藏域 --%>
			<div style="display: none;">
				<c:forEach items="${kmImeetingMainForm.kmImeetingMainHistoryForms}"  var="kmImeetingMainHistoryItem" varStatus="vstatus">
					<input type="hidden" name="kmImeetingMainHistoryForms[${vstatus.index}].fdId" value="${kmImeetingMainHistoryItem.fdId}" /> 
				</c:forEach>
			</div>
			
			<!-- 头部卡片 -->
			<c:import url="/km/imeeting/mobile/main/view_banner.jsp"  charEncoding="UTF-8">
				<c:param name="formBeanName" value="kmImeetingMainForm" />
			</c:import>
			
				<div data-dojo-type="mui/fixed/Fixed" id="fixed">
					<div data-dojo-type="mui/fixed/FixedItem" class="ImeetingFixedItem">
						<%--切换页签--%>
						<div class="muiHeader">
							<c:choose>
								<c:when test="${kmImeetingMainForm.docStatusFirstDigit=='3' and kmImeetingMainForm.fdNeedFeedback eq 'true'}">
									<div
										data-dojo-type="mui/nav/MobileCfgNavBar" 
										data-dojo-props="defaultUrl:'/km/imeeting/mobile/main/view_nav.jsp?docStatus=${kmImeetingMainForm.docStatus }&fromSysAttend=${param.fromSysAttend}&fdMeetingId=${kmImeetingMainForm.fdId}&isCanLookFeedback=${isCanLookFeedback}' ">
									</div>
								</c:when>
								<c:otherwise>
									<div
										data-dojo-type="mui/nav/MobileCfgNavBar" 
										data-dojo-props="defaultUrl:'/km/imeeting/mobile/main/view_simple_nav.jsp?docStatus=${kmImeetingMainForm.docStatus }&fromSysAttend=${param.fromSysAttend}' ">
									</div>
								</c:otherwise>
							</c:choose>
						</div>
					</div>
				</div>
				
				<%--会议内容页签--%>
				<div id="contentView" data-dojo-type="dojox/mobile/View">
					
					<div class="muiAccordionPanelContentBottom" style="text-align: left;padding:1rem;background-color: #ffffff">
						<div class="meetingDocContent" >
							<table class="muiSimple" cellpadding="0" cellspacing="0">
								<tr>
									<td class="m-meeting-title" >
										关联会议方案
									</td>
									<td>
										<c:out value="${kmImeetingMainForm.fdSchemeName}"></c:out>
									</td>
								</tr>
								<tr>
									<td class="m-meeting-title" >
										会议编号
									</td>
									<td>
										<c:out value="${kmImeetingMainForm.fdMeetingNum}"></c:out>
									</td>
								</tr>
								<tr>
									<td class="m-meeting-title" >
										会议时间
									</td>
									<td>
										<xform:datetime property="fdHoldDate" dateTimeType="datetime" showStatus="view" mobile="true"></xform:datetime>
										<span>~</span>
										<xform:datetime property="fdFinishDate" dateTimeType="datetime" showStatus="view" mobile="true"></xform:datetime>
									</td>
								</tr>
								<tr>
									<td class="m-meeting-title" >
										会议地点
									</td>
									<td>
										<span>${kmImeetingMainForm.fdPlaceName}</span>&nbsp;&nbsp;<span>${kmImeetingMainForm.fdOtherPlace}</span>
									</td>
								</tr>
								<tr>
									<td class="m-meeting-title" >
										报名截止时间
									</td>
									<td>
										<xform:datetime property="fdFeedBackDeadline" dateTimeType="datetime" showStatus="view" mobile="true"></xform:datetime>
									</td>
								</tr>
								<tr>
									<td class="m-meeting-title" >
										会议发起人
									</td>
									<td>
										<xform:address propertyName="docCreatorName" propertyId="docCreatorId" subject="会议发起人"
											orgType="ORG_TYPE_PERSON" required="false" mobile="true" showStatus="view"  htmlElementProperties="class='kmImeetingLLContent'">
										</xform:address>
									</td>
								</tr>
								<tr>
									<td class="m-meeting-title" >
										发起人部门
									</td>
									<td>
										<xform:address propertyName="fdCreatorDeptName" propertyId="fdCreatorDeptId" subject="发起人部门"
											 orgType="ORG_TYPE_ALL" required="false" mobile="true" showStatus="view"  htmlElementProperties="class='kmImeetingLLContent'">
										</xform:address>
									</td>
								</tr>
							</table>							
						</div>						
					</div>
					
					<div data-dojo-type="mui/panel/AccordionPanel" data-dojo-props="fixed:false" style="margin-top: 0.5rem">
						<c:if test="${not empty kmImeetingMainForm.fdTemplateId}">
							<%--会议议题--%>
							<div data-dojo-type="mui/panel/Content" data-dojo-props="title:'${lfn:message('km-imeeting:mobile.kmImeetingMain.nav.content') }',icon:''">
								<div class="txtContent">
									<%@include file="/km/imeeting/mobile/topic/agenda_viewTopic.jsp"%>
									<br/>
									<c:import url="/sys/attachment/mobile/import/view.jsp" charEncoding="UTF-8">
										<c:param name="formName" value="kmImeetingMainForm" />
										<c:param name="fdKey" value="attachment" />
									</c:import>
								</div>
							</div>
							<%--查阅会议纪要--%>
							<c:if test="${kmImeetingMainForm.docStatusFirstDigit eq '3' and kmImeetingMainForm.fdSummaryFlag=='true' and (not empty summaryId)}">
								<c:choose>
									<c:when test="${not empty summaryType && summaryType eq 'imeeting'}">
										<%-- 会议纪要(会议纪要创建后，所有可阅读者可见) --%>
										<kmss:auth requestMethod="GET"
												   requestURL="/km/imeeting/km_imeeting_summary/kmImeetingSummary.do?method=view&fdId=${summaryId}">
											<div data-dojo-type="mui/panel/Content" data-dojo-props="title:'${lfn:message('km-imeeting:kmImeetingMain.kmImeetingSummarys') }',icon:''" class="summaryBtnBox">
												<div class="txtContent summaryBtn">
													<div class="muiReadButton" onclick="window.open('${LUI_ContextPath}/km/imeeting/km_imeeting_summary/kmImeetingSummary.do?method=view&fdId=${summaryId}','_self')">
														<bean:message bundle="km-imeeting" key="mobile.kmImeetingSummary.view"/>
													</div>
												</div>
											</div>
										</kmss:auth>
									</c:when>
									<c:when test="${not empty summaryType && summaryType eq 'imissive'}">
										<kmss:auth requestMethod="GET"
												   requestURL="/km/imissive/km_imissive_send_main/kmImissiveSendMain.do?method=view&fdId=${summaryId}">
											<div data-dojo-type="mui/panel/Content" data-dojo-props="title:'${lfn:message('km-imeeting:kmImeetingMain.kmImeetingSummarys') }',icon:''" class="summaryBtnBox">
												<div class="txtContent summaryBtn">
													<div class="muiReadButton" onclick="window.open('${LUI_ContextPath}/km/imissive/km_imissive_send_main/kmImissiveSendMain.do?method=view&fdId=${summaryId}','_self')">
														<bean:message bundle="km-imeeting" key="mobile.kmImeetingSummary.view"/>
													</div>
												</div>
											</div>
										</kmss:auth>
									</c:when>
								</c:choose>
							</c:if>
						</c:if>
					</div>
					
					<!-- 会议室资源 -->
					<div data-dojo-type="mui/panel/AccordionPanel" data-dojo-props="fixed:false">
						<div data-dojo-type="mui/panel/Content" data-dojo-props="title:'会议室辅助资源',icon:''" class="summaryBtnBox">
							<table class="muiSimple" cellpadding="0" cellspacing="0">
								<c:if test="${not empty kmImeetingMainForm.kmImeetingEquipmentNames}">
									<tr>
										<td class="m-meeting-title">
											<bean:message bundle="km-imeeting" key="kmImeetingMain.kmImeetingEquipment"/>
										</td>
										<td>
											<c:out value="${kmImeetingMainForm.kmImeetingEquipmentNames}"></c:out>
										</td>
									</tr>
								</c:if>
								<c:if test="${not empty kmImeetingMainForm.kmImeetingDeviceNames}">
									<tr>
										<td class="m-meeting-title">
											<bean:message bundle="km-imeeting" key="kmImeetingMain.kmImeetingDevices"/>
										</td>
										<td>
											<c:out value="${kmImeetingMainForm.kmImeetingDeviceNames}"></c:out>
										</td>
									</tr>
								</c:if>
							</table>
							<div style="height: 2rem;"></div>
	        			</div>
					</div>
				</div>
				
				<%--会议人员页签--%>
				<div id="personView" data-dojo-type="dojox/mobile/View">
					<div data-dojo-type="mui/panel/AccordionPanel" data-dojo-props="fixed:false">
						<div class="txtContent">
							<div class="muiImeetingAttenders">
								<table class="muiSimple" cellpadding="0" cellspacing="0">
									<!-- 主持人 -->
									<tr>
										<td class="muiTitle">
											<bean:message bundle="km-imeeting"  key="kmImeetingMain.fdHost"/>
										</td>
										<td class="muiImeetingContent">
											<c:out value="${kmImeetingMainForm.fdHostName}"></c:out>
										</td>
									</tr>
									<!-- 出席人员 -->
									<tr>
										<td class="muiTitle">
											<bean:message bundle="km-imeeting"  key="mobile.attendMeetinger"/>
										</td>
										<td class="muiImeetingContent">
											<span id="attendPersonNames">${attendPersonNamesM}</span>
										</td>
									</tr>
									
									<!-- 邀请人员 -->
									<c:if test="${not empty kmImeetingMainForm.fdInvitePersonIds}">
										<tr>
											<td class="muiTitle">
												<bean:message bundle="km-imeeting"  key="mobile.inviteMeetinger"/>
											</td>
											<td class="muiImeetingContent">
												<span id="invitePersonNames">${fdInvitePersonNamesM}</span>
											</td>
										</tr>
									</c:if>
									
									<!-- 列席人员 -->
									<c:if test="${not empty kmImeetingMainForm.fdParticipantPersonIds}">
										<tr>
											<td class="muiTitle">
												<bean:message bundle="km-imeeting"  key="mobile.participantMeetinger"/>
											</td>
											<td class="muiImeetingContent">
												<span id="participantPersonNames">${participantPersonNamesM}</span>
											</td>
										</tr>
									</c:if>
									
									<!-- 纪要人员 -->
									<c:if test="${not empty kmImeetingMainForm.fdSummaryInputPersonId}">
										<tr>
											<td class="muiTitle">
												<bean:message bundle="km-imeeting"  key="kmImeetingMain.createStep.base.fdSummaryInputPerson"/>
											</td>
											<td class="muiImeetingContent">
												${kmImeetingMainForm.fdSummaryInputPersonName}
											</td>
										</tr>
									</c:if>
									
									<!-- 会服人员 -->
									<c:if test="${not empty kmImeetingMainForm.fdAssistPersonIds}">
										<tr>
											<td class="muiTitle">
												<bean:message bundle="km-imeeting"  key="kmImeetingMain.fdAssistPersons"/>
											</td>
											<td class="muiImeetingContent">
												<span id="assistPersonNames">${assistPersonListNamesM}</span>
											</td>
										</tr>
									</c:if>
								</table>
							</div>
						</div>
					</div>
				</div>
				
				<%--会议回执页签--%>
				<c:if test="${kmImeetingMainForm.docStatus >= '30' && isCanLookFeedback eq 'true'}">
					<div id="feedbackListView" data-dojo-type="dojox/mobile/View">
					
						<div class="muiMeetingFeedbackHeader gray">
							<div data-dojo-type="mui/property/TagFilterItem"
								class="feedbackFilter"
								data-dojo-props="
									isTagCount:true,
									name: 'criteriaType',
									options:[
										{name:'全部',value:''},
										{name:'未回执',value:'04'},
										{name:'参加',value:'01'},
										{name:'不参加',value:'02'},
										{name:'已报名',value:'07'}
									],
									values:{criteriaType:''}">
							</div>
						</div>
						<div class="muiImeetingFeedbackUnderline"></div>
						<ul id="muiMeetingFeedbackList" class="muiMeetingFeedbackList" 
				    		data-dojo-type="km/imeeting/mobile/resource/js/list/FeedbackJsonStoreList" 
				    		data-dojo-mixins="km/imeeting/mobile/resource/js/list/FeedbackItemListMixin"
				    		data-dojo-props="url:'/km/imeeting/km_imeeting_main_feedback/kmImeetingMainFeedback.do?method=listShow&meetingId=${kmImeetingMainForm.fdId }',lazy:false,isShowTag:true">
						</ul>
						
					</div>
				</c:if>					
				<%--会议流程信息 --%>
				<div id="processView" data-dojo-type="dojox/mobile/View">
					<div class="ProcessAccordionPanel" data-dojo-type="mui/panel/AccordionPanel" data-dojo-props="fixed:false">
						<div class="muiAccordionPanelContent muiImeetingPanelContent">
							<c:import url="/sys/lbpmservice/mobile/lbpm_audit_note/import/view.jsp" charEncoding="UTF-8">
								<c:param name="fdModelId" value="${kmImeetingMainForm.fdId }"/>
								<c:param name="fdModelName" value="com.landray.kmss.km.imeeting.model.KmImeetingMain"/>
								<c:param name="formBeanName" value="kmImeetingMainForm"/>
							</c:import>
						</div>
					</div>
				</div>
				
				
				<%if(!KmImeetingConfigUtil.isBoenEnable()){ %>
					<kmss:ifModuleExist path="/sys/attend/">
						<div id="attendView"  data-dojo-type="dojox/mobile/View">
							<c:import url="/sys/attend/mobile/import/view.jsp" charEncoding="UTF-8">
								<c:param name="fdModelName" value="com.landray.kmss.km.imeeting.model.KmImeetingMain"></c:param>
								<c:param name="fdModelId" value="${kmImeetingMainForm.fdId}"></c:param>
							</c:import>
						</div>
					</kmss:ifModuleExist>
				<%}%>
	
			<%-- 有模板会议（完整形式） --%>
			<template:include file="/sys/lbpmservice/mobile/import/tarbar.jsp" 
				  formName="kmImeetingMainForm"
				  viewName="lbpmView"
				  allowReview="true">
				<template:replace name="flowArea">
										
					<%-- 编辑文档 --%> 
					<c:if test="${kmImeetingMainForm.docStatus!='00' and kmImeetingMainForm.docStatus!='30' and kmImeetingMainForm.docStatus!='41'}">
						<kmss:auth 
							requestURL="/km/imeeting/km_imeeting_main/kmImeetingMain.do?method=edit&fdId=${kmImeetingMainForm.fdId}" 
							requestMethod="GET">
							<li data-dojo-type="mui/tabbar/TabBarButton" class="muiBtnSubmit muiBtnEdit" onclick="window.open('${LUI_ContextPath}/km/imeeting/km_imeeting_main/kmImeetingMain.do?method=edit&fdId=${kmImeetingMainForm.fdId }','_self')"
								data-dojo-props="colSize:2">
								<bean:message key="button.edit"/>
							</li>  
						</kmss:auth>
					</c:if>
				</template:replace>
				
				<template:replace name="publishArea">
					 	<%--未召开且已发送会议通知单的会议才显示回执按钮--%>
						<c:if test="${kmImeetingMainForm.isNotify==true and kmImeetingMainForm.fdNeedFeedback eq 'true' && not empty feedbackInfos}">
							<%--是参会人才显示回执按钮--%>
							<c:if test="${not empty optType}">
								<li data-dojo-type="mui/tabbar/TabBarButton" class="muiBtnFeedback"  id="feedbackListBtn" >
								 	${lfn:message('km-imeeting:mobile.feedback')}
								 </li> 
							</c:if>
						</c:if>
						
						<c:if test="${isBegin == false and kmImeetingMainForm.docStatus == '30'}">
							<kmss:auth requestURL="/km/imeeting/km_imeeting_main/kmImeetingMainCancel.do?method=cancelMeeting&fdId=${kmImeetingMainForm.fdId}" requestMethod="GET">
								<li data-dojo-type="mui/tabbar/TabBarButton" id="cancelMeetingButton" class="muiBtnSubmit"
									data-dojo-props="colSize:2">
									<bean:message bundle="km-imeeting" key="kmImeeting.btn.cancelMeeting"/>
								</li>
							</kmss:auth>
					 	</c:if>
						
						<!-- 钉钉电话会议 -->
						<c:if test="${!isEnd && canEnter}">
							<li id="dingCallButton" class="muiBtnNext"  data-dojo-type="mui/tabbar/TabBarButton"
								  	data-dojo-props="colSize:2" onclick="callDingding();" style="display: none">电话会议</li>
					 	</c:if>
					 	
						<%-- 会议取消，条件：1、创建者 2、会议未开始 --%>
						<c:if test="${kmImeetingMainForm.docStatus=='30' and isBegin==false}">
							<kmss:auth requestURL="/km/imeeting/km_imeeting_main/kmImeetingMainCancel.do?method=cancelMeeting&fdId=${kmImeetingMainForm.fdId}" requestMethod="GET">
								<c:set var="showCancelBtn" value="true"></c:set>
							</kmss:auth>
						</c:if>
						
						<c:if test="${kmImeetingMainForm.docStatus=='30' && kmImeetingMainForm.isNotify==true && not empty feedbackInfos}">
							<%--是参会人才显示回执按钮--%>
							<c:if test="${not empty optType  and kmImeetingMainForm.fdNeedFeedback eq 'true' }">
								<c:set var="showfeedbackBtn" value="true"></c:set>
							</c:if>
						</c:if>	
						
						<!-- 会议变更 -->
						 <c:if test="${kmImeetingMainForm.fdSummaryFlag=='false' and isBegin==false and kmImeetingMainForm.docStatus == '30'}">
							<kmss:auth requestURL="/km/imeeting/km_imeeting_main/kmImeetingMain.do?method=changeMeeting&fdId=${kmImeetingMainForm.fdId}" requestMethod="GET">
								<li data-dojo-type="mui/tabbar/TabBarButton" id="changeMeetingButton" class="muiBtnSubmit" 
									data-dojo-props="colSize:2">
									<bean:message bundle="km-imeeting" key="kmImeeting.change"/>
								</li>
							</kmss:auth>
					 	</c:if>
				</template:replace>
			</template:include>
		</div>
		
		<%-- <%@ include file="/km/imeeting/mobile/import/kkMeeting.jsp"%> --%>
		<c:if test="${not empty kmImeetingMainForm.fdTemplateId}">
			<%--流程页面 --%>
			<c:import url="/sys/lbpmservice/mobile/import/view.jsp" charEncoding="UTF-8">
				<c:param name="formName" value="kmImeetingMainForm" />
				<c:param name="fdKey" value="ImeetingMain" />
				<c:param name="viewName" value="lbpmView" />
				<c:param name="backTo" value="scrollView" />
			</c:import>
		</c:if>
		
		<!-- 钉钉图标 -->
		<kmss:ifModuleExist path="/third/ding">
			<c:import url="/third/ding/import/ding_view.jsp" charEncoding="UTF-8">
				<c:param name="formName" value="kmImeetingMainForm" />
				<c:param name="fdEmceeId" value="${kmImeetingMainForm.fdEmceeId  }" />
				<c:param name="fdHostId" value="${kmImeetingMainForm.fdHostId  }" />
				<c:param name="fdAttendPersonIds" value="${kmImeetingMainForm.fdAttendPersonIds }" />
				<c:param name="fdParticipantPersonIds" value="${kmImeetingMainForm.fdParticipantPersonIds }" />
				<c:param name="fdFinishDate" value="${kmImeetingMainForm.fdFinishDate }" />
				<c:param name="isMeeting" value="true" />
			</c:import>
		</kmss:ifModuleExist>
		
		<kmss:ifModuleExist path="/third/lding">
			<c:import url="/third/lding/import/ding_view.jsp" charEncoding="UTF-8">
				<c:param name="formName" value="kmImeetingMainForm" />
			</c:import>
		</kmss:ifModuleExist>
		<kmss:ifModuleExist path="/third/govding">
			<c:import url="/third/govding/import/ding_view.jsp" charEncoding="UTF-8">
				<c:param name="formName" value="kmImeetingMainForm" />
				<c:param name="fdEmceeId" value="${kmImeetingMainForm.fdEmceeId  }" />
				<c:param name="fdHostId" value="${kmImeetingMainForm.fdHostId  }" />
				<c:param name="fdAttendPersonIds" value="${kmImeetingMainForm.fdAttendPersonIds }" />
				<c:param name="fdParticipantPersonIds" value="${kmImeetingMainForm.fdParticipantPersonIds }" />
				<c:param name="fdFinishDate" value="${kmImeetingMainForm.fdFinishDate }" />
				<c:param name="isMeeting" value="true" />
			</c:import>
		</kmss:ifModuleExist>
		<c:if test="${showfeedbackBtn eq true }">
			<div id="kmImeetingMain_otherBox" style="display:none;" >
	  			<div id="kmImeetingMain_other" class="kmImeetingMain_other">
					<ul>
				    	<c:if test="${not empty feedbackInfos and kmImeetingMainForm.isNotify==true and kmImeetingMainForm.fdNeedFeedback eq 'true'}">
				    		<c:forEach	items="${feedbackInfos}" varStatus="infoIndex" var="feedbackInfo">
				    			<li data-dojo-type="mui/tabbar/TabBarButton" class="muiBtnSubmit " 
						    		onclick="window.open('${LUI_ContextPath}${feedbackInfo['fdUrl']}','_self')"
									data-dojo-props="colSize:2">
									<c:choose>
										<c:when test="${feedbackInfo['fdType'] eq '09'}">
											<bean:message bundle="km-imeeting" key="mobile.meetingLiasion"/>
											<c:out value="(${feedbackInfo['fdUnitName']})"></c:out>
										</c:when>
										
										<c:otherwise>
											<bean:message bundle="km-imeeting" key="mobile.attendPerson"/>
										</c:otherwise>
									</c:choose>
									<c:choose>
										<c:when test="${feedbackInfo['fdOptType'] eq '07'}">
											<c:out value="- 已报名"></c:out>
										</c:when>
										<c:when test="${feedbackInfo['fdOptType'] eq '01'}">
											<c:out value="- 参加"></c:out>
										</c:when>
										<c:when test="${feedbackInfo['fdOptType'] eq '02'}">
											<c:out value="- 不参加"></c:out>
										</c:when>
										<c:otherwise>
											<c:out value="- 未回执"></c:out>
										</c:otherwise>
									</c:choose>
								</li>
				    		</c:forEach>
						</c:if>
			 		</ul>
			 		<div class="otherDialogCancel">
						${lfn:message('km-imeeting:button.cancel')}
					</div>
			 	</div>
			 </div>
			 </c:if> 
			 
			 <div id="kmImeetingMain_changeMeetingBox" style="display:none;" >
			 	<div id="kmImeetingMain_changeMeeting" class="kmImeetingMain_other">
			 		<ul>
			 			<li data-dojo-type="mui/tabbar/TabBarButton" class="muiBtnSubmit" onclick="updateCur()"
							data-dojo-props="colSize:2">
							<bean:message bundle="km-imeeting" key="oper.change.cur"/>
						</li>
						<li data-dojo-type="mui/tabbar/TabBarButton" class="muiBtnSubmit" onclick="updateAfter()"
							data-dojo-props="colSize:2">
							<bean:message bundle="km-imeeting" key="oper.change.after"/>
						</li>
						<li data-dojo-type="mui/tabbar/TabBarButton" style="color: #475669;" onclick="changeMeetingCancel()"
							data-dojo-props="colSize:2">
							<bean:message bundle="km-imeeting" key="button.cancel"/>
						</li>
			 		</ul>
			 	</div>
			 </div>
			 
			 <div id="kmImeetingMain_cancelMeetingBox" style="display:none;" >
			 	<div id="kmImeetingMain_cancelMeeting" class="kmImeetingMain_other">
			 		<ul>
			 			<li data-dojo-type="mui/tabbar/TabBarButton" class="muiBtnSubmit" onclick="cancelCur()"
							data-dojo-props="colSize:2">
							<bean:message bundle="km-imeeting" key="oper.cancel.cur"/>
						</li>
						<li data-dojo-type="mui/tabbar/TabBarButton" class="muiBtnSubmit" onclick="cancelAfter()"
							data-dojo-props="colSize:2">
							<bean:message bundle="km-imeeting" key="oper.cancel.after"/>
						</li>
						<li data-dojo-type="mui/tabbar/TabBarButton" style="color: #475669;" onclick="cancelMeetingCancel()"
							data-dojo-props="colSize:2">
							<bean:message bundle="km-imeeting" key="button.cancel"/>
						</li>
			 		</ul>
			 	</div>
			 </div>
			 
			 <div id="kmImeetingMain_cancelMeeting_reasonBox" style="display:none;" >
			 	<div id="kmImeetingMain_cancelMeeting_reason" class="cancelMeetingReasonDialogView">
			 		<xform:textarea 
			 			property="fdCancelReason" 
			 			showStatus="edit" 
			 			mobile="true" 
			 			placeholder="${lfn:message('km-imeeting:KmImeeting.cancel.reason') }" 
			 			validators="maxLength(1500) required"/>
			 	</div>
			 </div>
	</template:replace>
</template:include>
<%@ include file="/km/imeeting/mobile/main/view_simple_js.jsp"%>
<script>
	require(["dojo/dom",
			'dojo/topic',
	         'dojo/ready',
	         'dijit/registry',
	         'dojox/mobile/TransitionEvent',
	         'dojo/request',
	         'dojo/query',
	         'dojo/dom-construct',
	         'dojo/dom-style',
	         'dojo/dom-geometry',
	         'mui/util',
	         'mui/dialog/BarTip',
	         "dojo/_base/lang",
	         "dojo/request",
	         'mui/dialog/Tip',
			 'mui/dialog/Dialog',
			 'dojo/_base/array'
	         ],function(dom,topic,ready,registry,TransitionEvent,request,query,domConstruct,
			 domStyle,domGeometry,util,BarTip,lang,req,Tip,Dialog,array){
		
		window.isShowFeedbackStatusTag = true;
		
		window.openLink = function(url){
			window.open(url,'_self'); 
		};
		 /* 回执操作 */
		 var feedbackListBtn = dom.byId("feedbackListBtn");
		 if(feedbackListBtn){
			 var selectList = dom.byId("kmImeetingMain_other");
			 dom.byId("feedbackListBtn").onclick= function (){
					var DialogObj = new Dialog.claz({
						element:selectList,
						scrollable:false,
						parseable:false,
						position:"bottom",
						canClose:false
					});
					DialogObj.show();
				    var dialogCancel =  query(".muiDialogElementContainer_bottom .otherDialogCancel");
					dialogCancel[0].onclick=function(){
						DialogObj.hide();
					}; 					
			  } 
		 }
		 
		var changeMeetingButton = dom.byId('changeMeetingButton'),cancelMeetingButton = dom.byId('cancelMeetingButton');
		if(changeMeetingButton){
			changeMeetingButton.onclick = function(){
				window.changeMeeting();
			}
		}
		if(cancelMeetingButton){
			cancelMeetingButton.onclick = function(){
				window.cancelMeeting();
			}
		}
		
		window.changeMeeting=function(){
			window.open('${LUI_ContextPath}/km/imeeting/km_imeeting_main/kmImeetingMain.do?method=changeMeeting&fdId=${kmImeetingMainForm.fdId}','_self');
		}
		 
		window.callDingding=function(){
			var url = "${LUI_ContextPath}/km/imeeting/km_imeeting_main/kmImeetingMain.do?method=expand2PersonIds";
			req(url, {
				handleAs : 'json',
				method : 'post',
				data : {
					orgIds:'${kmImeetingMainForm.fdAttendPersonIds}'
				}
			}).then(lang.hitch(this, function(data) {
				if (data['personIds']){
					window.callPhone(data['personIds'], '${kmImeetingMainForm.fdHostId }','${kmImeetingMainForm.fdName}');
				}
			}));
		};
		
		window.cancelMeeting=function(){
			window.cancelMeetingReason();
		}
		
		var cancelMeetingReasonDialog;
		var cancelMeetingReason = dom.byId("kmImeetingMain_cancelMeeting_reason");
		window.cancelMeetingReason = function(){
			var url = "${LUI_ContextPath}/km/imeeting/km_imeeting_main_cancel/kmImeetingMainCancel.do?method=mobileCancelMeeting";
			cancelMeetingReasonDialog = new Dialog.claz({
				element:cancelMeetingReason,
				scrollable:false,
				parseable:false,
				position:"center",
				canClose:false,
				buttons: [{
					title : "${lfn:message('km-imeeting:button.cancel')}",
					fn : function(dialog) {
						dialog.hide();
					}
				} ,{
					title : "${lfn:message('km-imeeting:button.submit')}",
					fn : lang.hitch(this,function(dialog) {
						var fdReason = query('[name="fdCancelReason"]',this.domNode);
						if(fdReason[0].value && fdReason[0].value != ""){
							var processing = Tip.processing();
							req(url, {
								handleAs : 'json',
								method : 'post',
								data : {
									fdCancelReason:fdReason[0].value,
									meetingId:"${kmImeetingMainForm.fdId}",
								}
							}).then(lang.hitch(this, function(data) {
								if (data){
								    if(data['flag'] == '1'){
								    	dialog.hide();
								    	processing.hide();
								    	Tip.success({
											text:"${lfn:message('km-imeeting:mobile.success.tip')}"
										});
								    	location.reload()
									}
								}
							}));
						}else{
							Tip.fail({
								text:"${lfn:message('km-imeeting:mobile.error.tip2')}"
							});
							return;
						}
					})
				}]
			});
			cancelMeetingReasonDialog.show();
			
		}
		
		var updateEmccDialog;
		window.updateEmcc=function(){
			updateEmccDialog = new Dialog.claz({
				'element' : '<br/><br/><div><bean:message bundle="km-imeeting" key="kmImeeting.undertake.work"/>？</div><br/><br/>',
				'destroyAfterClose':true,
				'closeOnClickDomNode':true,
				'scrollable' : false,
				'showClass' : 'muiAttendDialogShow',
				'parseable': true,
				'position':'center',
				'buttons' : [{
					title : "${lfn:message('km-imeeting:button.cancel')}",
					fn : function(dialog) {
						dialog.hide();
					}
				} ,{
					title : "${lfn:message('km-imeeting:button.submit')}",
					fn : lang.hitch(this,function(dialog) {
						var url = "${LUI_ContextPath}/km/imeeting/km_imeeting_main/kmImeetingMain.do?method=updateEmcc&emccFlag=emcc&fdId=${kmImeetingMainForm.fdId}";
						var processing = Tip.processing();
						var promise = request.post(url);
						promise.response.then(function(data) {
							if (data.status == 200 && data.getHeader("lui-status") == "true" ) {
								dialog.hide();
						    	processing.hide();
						    	Tip.success({
									text:"${lfn:message('km-imeeting:mobile.success.tip')}"
								});
						    	location.reload();
							}else
								Tip.fail({
									text : "${lfn:message('km-imeeting:mobile.fail.tip')}"
								});
						});
					})
				} ]
			});
			updateEmccDialog.show();
		};
		
		<c:if test="${type=='admin' or type=='attend' or type=='cc' }">
			//切换标签重新计算高度
			var _position=domGeometry.position(query('#fixed')[0]),
				_scrollTop=0;
			topic.subscribe("/mui/list/_runSlideAnimation",function(srcObj, evt) {
				_scrollTop= Math.abs(evt.to.y);//记录当前位置
			});
			topic.subscribe("/mui/navitem/_selected",function(){
				var view=registry.byId("scrollView"),
					evt={ y : 0 - _scrollTop };
				if(_scrollTop > _position.y){
					evt={ y : 0 - _position.y };
				}
				view.handleToTopTopic(null,evt);
			});
		</c:if>
		
		//拨打主持人号码
		window.dialPhone=function(mobileNo){
			if(mobileNo){
				location.href = 'tel:'+mobileNo;
			}else{
				Tip.fail({
					text:'<bean:message bundle="km-imeeting"  key="mobile.kmImeetingMian.phone.notnull"/>'
				});
			}
		};
		
		function initMeetingDate() {
			var fdHoldTimeStr = document.getElementById('meetingHoldDate').innerText.trim();
			var fdEndTimeStr = document.getElementById('meetingFinishDate').innerText.trim();
			//var fdHoldTimeStr = $("#meetingHoldDate").find("span")[0].innerHTML.trim();
			//var fdEndTimeStr = $("#meetingFinishDate").find("span")[0].innerHTML.trim();
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
		
		//初始化时间
		try {
			var meetingHoldDate = Com_GetDate(document.getElementById('meetingHoldDate').innerHTML.trim());
			var meetingFinishDate = Com_GetDate(document.getElementById('meetingFinishDate').innerHTML.trim());
			if(meetingHoldDate && meetingFinishDate) {
				var _meetingHoldDate = new Date(meetingHoldDate.getFullYear(), meetingHoldDate.getMonth(), meetingHoldDate.getDate());
				var _meetingFinishDate = new Date(meetingFinishDate.getFullYear(), meetingFinishDate.getMonth(), meetingFinishDate.getDate());
				
				if(_meetingHoldDate.getTime() == _meetingFinishDate.getTime()) {
					
					var meetingDateNode = query('.meeting-date');
					array.forEach(meetingDateNode, function(node) {
						node.innerHTML = util.formatDate(_meetingHoldDate, dojoConfig.Date_format) + 
											' ' + 
											util.formatDate(meetingHoldDate, dojoConfig.Time_format) + 
											' ~ ' +
											util.formatDate(meetingFinishDate,dojoConfig.Time_format)
					});
	
				}
			}
		} catch(e) {}

		//校验对象
		ready(function(){
			
			initMeetingDate();
			
			var ul = query('ul[data-dojo-type="sys/task/mobile/resource/js/OverflowTabBar"]');
			if(ul.length&&ul.length>0){
				var accordionPanelNode = query('div[data-dojo-type="mui/panel/AccordionPanel"]')[0];
				accordionPanelNode && (domStyle.set(accordionPanelNode, 'margin', '0px'));
			}
			
			//AJAX,到后台计算出与会人数
			var caculateAttendNum = function(){
				
				var fdHostId="${kmImeetingMainForm.fdHostId }" !="" ? ("${kmImeetingMainForm.fdHostId }") : "";//主持人
				var fdAttendPersonIds="${kmImeetingMainForm.fdAttendPersonIds }" !="" ? ("${kmImeetingMainForm.fdAttendPersonIds }") : "";
				var	fdAttendPersonArray=fdAttendPersonIds?fdAttendPersonIds.split(';'):[];//参与人员
				var fdInvitePersonIds="${kmImeetingMainForm.fdInvitePersonIds }" !="" ? ("${kmImeetingMainForm.fdInvitePersonIds }") : "";
				var	fdInvitePersonArray=fdInvitePersonIds?fdInvitePersonIds.split(';'):[];//邀请人员
				var fdParticipantPersonIds="${kmImeetingMainForm.fdParticipantPersonIds }" !="" ? ("${kmImeetingMainForm.fdParticipantPersonIds }") : "";
				var	fdParticipantPersonArray=fdParticipantPersonIds?fdParticipantPersonIds.split(';'):[];//列席人员
				var fdSummaryInputPersonId="${kmImeetingMainForm.fdSummaryInputPersonId }" !="" ? ("${kmImeetingMainForm.fdSummaryInputPersonId }") : "";//会议纪要人
				var personArray=[];
				personArray=personArray.concat(fdAttendPersonArray);
				personArray=personArray.concat(fdParticipantPersonArray);
				personArray=personArray.concat(fdInvitePersonArray);
				if(fdHostId){
					personArray.push(fdHostId);
				}
				if(fdSummaryInputPersonId){
					personArray.push(fdSummaryInputPersonId);
				}
				var personIds=personArray.join(';');
				
				request.post('${LUI_ContextPath}/km/imeeting/km_imeeting_main/kmImeetingMain.do?method=caculateAttendNumber', {
					handleAs: 'json',
					data: {personIds: personIds,fdMeetingId:'${kmImeetingMainForm.fdId}'}
				}).then(function(res) {
					if(res && res.number >= 0) {
						var attendCountsNode = query('[name="attendCounts"]');
						array.forEach(attendCountsNode, function(node) {
							node.innerHTML = res.number
						});
					}
				});
			};
			
			//初始化
			caculateAttendNum();

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
</script>

<!-- 钉钉电话会议 -->
<c:import url="/sys/mobile/jsp/ding.jsp" charEncoding="UTF-8">
</c:import>
<c:if test="${prefixDing=='ding' }">
	<c:import url="/third/ding/mobile/ding_call.jsp" charEncoding="UTF-8">
	</c:import>
</c:if>
<c:if test="${prefixDing=='lding' }">
	<c:import url="/third/lding/import/ding_call.jsp" charEncoding="UTF-8">
	</c:import>
</c:if>
<c:if test="${prefixDing=='govding' }">
	<c:import url="/third/govding/mobile/ding_call.jsp" charEncoding="UTF-8">
	</c:import>
</c:if>