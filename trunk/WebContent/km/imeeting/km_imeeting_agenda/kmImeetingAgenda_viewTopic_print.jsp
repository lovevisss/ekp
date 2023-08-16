<%@page import="com.landray.kmss.util.StringUtil"%>
<%@page import="net.sf.json.JSONArray"%>
<%@page import="com.landray.kmss.util.SpringBeanUtil"%>
<%@page import="com.landray.kmss.km.imeeting.service.IKmImeetingAgendaService"%>
<%@page import="com.landray.kmss.km.imeeting.forms.KmImeetingMainFeedbackForm"%>
<%@ page language="java" pageEncoding="UTF-8" contentType="text/html; charset=UTF-8"%>
<%@ include file="/sys/ui/jsp/common.jsp"%>
<%@page import="com.landray.kmss.km.imeeting.util.KmImeetingConfigUtil"%>
<%@page import="com.landray.kmss.km.imeeting.util.KmImeetingTopicUtil"%>
<%@page import="com.landray.kmss.km.imeeting.forms.KmImeetingMainForm"%>
<%@page import="com.landray.kmss.km.imeeting.forms.KmImeetingAgendaForm"%>
<c:if test="${not empty kmImeetingMainForm.kmImeetingVicePlaceDetailForms}">
	<table class="tb_normal" width=100% id="TABLE_ViceDocList" align="center">
		<tr align="center">
			<%--序号--%> 
			<td class="td_normal_title">
				<bean:message key="page.serial"/>
			</td>
			<td class="td_normal_title">
				<bean:message key="kmImeetingMain.fdVicePlace" bundle="km-imeeting"/>
			</td>
			<td class="td_normal_title">
				<bean:message key="kmImeetingMain.fdOtherPlace" bundle="km-imeeting"/>
			</td>
		</tr>
		<%--内容行--%>
		<c:forEach items="${kmImeetingMainForm.kmImeetingVicePlaceDetailForms}"  var="kmImeetingVicePlaceDetailitem" varStatus="vstatus">
			<tr KMSS_IsContentRow="1">
				<td align="center">
					<input type="hidden" name="kmImeetingVicePlaceDetailForms[${vstatus.index}].fdId" value="${kmImeetingVicePlaceDetailitem.fdId}"/> 
					${vstatus.index+1}
				</td>
				<td align="center">
					<input type="hidden" name="kmImeetingVicePlaceDetailForms[${vstatus.index}].fdMeetingId" value="${kmImeetingVicePlaceDetailitem.fdMeetingId}" />
					<input type="hidden" name="kmImeetingVicePlaceDetailForms[${vstatus.index}].fdPlaceId" value="${kmImeetingVicePlaceDetailitem.fdPlaceId }"/>
					<c:out value="${kmImeetingVicePlaceDetailitem.fdPlaceName }"></c:out>
				</td>
				<td align="center">
					<c:if test="${not empty kmImeetingVicePlaceDetailitem.fdOtherPlace }">
						<c:set var="hasSysAttend" value="false"></c:set>
						<kmss:ifModuleExist path="/sys/attend">
							<c:set var="hasSysAttend" value="true"></c:set>
						</kmss:ifModuleExist>
						<c:if test="${hasSysAttend == true }">
							<c:import url="/sys/attend/import/map_tag.jsp" charEncoding="UTF-8">
								<c:param name="propertyName" value="kmImeetingVicePlaceDetailForms[${vstatus.index}].fdOtherPlace"></c:param>
								<c:param name="nameValue" value="${kmImeetingVicePlaceDetailitem.fdOtherPlace }"></c:param>
								<c:param name="propertyCoordinate" value="kmImeetingVicePlaceDetailForms[${vstatus.index}].fdOtherPlaceCoordinate"></c:param>
								<c:param name="coordinateValue" value="${kmImeetingVicePlaceDetailitem.fdOtherPlaceCoordinate }"></c:param>
							</c:import>
						</c:if>
						<c:if test="${hasSysAttend == false }">
							<c:out value="${kmImeetingVicePlaceDetailitem.fdOtherPlace }"></c:out>
						</c:if>
					</c:if>
				</td>
			</tr>
		</c:forEach>
	</table>
	<br>
</c:if>
<table width=100% id="TABLE_DocList" align="center">
	<tr style=" visibility:hidden">
		<td class="td_normal_title" width="4%"></td>
		<td class="td_normal_title"></td>
	</tr>
	<%--内容行--%>
	<% String fdIds = ""; %>
	<c:forEach items="${kmImeetingMainForm.kmImeetingAgendaForms}"  var="kmImeetingAgendaitem" varStatus="vstatus">
		<% 
		if(request.getAttribute("kmImeetingMainForm")!=null && pageContext.getAttribute("kmImeetingAgendaitem")!=null){
			String isMeetingPage = (String)request.getAttribute("fdIsMeetingPage");
			KmImeetingAgendaForm kmImeetingAgendaForm = (KmImeetingAgendaForm)pageContext.getAttribute("kmImeetingAgendaitem");
			KmImeetingMainFeedbackForm kmImeetingMainFeedbackForm = (KmImeetingMainFeedbackForm)request.getAttribute("kmImeetingMainFeedbackForm");
			boolean canView = false;
			if (kmImeetingMainFeedbackForm != null 
					&& kmImeetingMainFeedbackForm.getFdDetailForms() != null
					&& !kmImeetingMainFeedbackForm.getFdDetailForms().isEmpty()) {
				canView = KmImeetingTopicUtil.viewTopicEnable((KmImeetingMainForm)request.getAttribute("kmImeetingMainForm"),
						kmImeetingAgendaForm, kmImeetingMainFeedbackForm, false);
			} else {
				if ("true".equals(isMeetingPage)) {
					canView = KmImeetingTopicUtil.viewTopicEnable((KmImeetingMainForm)request.getAttribute("kmImeetingMainForm"),
							kmImeetingAgendaForm, null, true);
				} else {
					canView = KmImeetingTopicUtil.viewTopicEnable((KmImeetingMainForm)request.getAttribute("kmImeetingMainForm"),
							kmImeetingAgendaForm, null, false);
				}
			}
			if(canView){
				fdIds += kmImeetingAgendaForm.getFdId() + ";";
		%>
		<tr KMSS_IsContentRow="1">
			<td KMSS_IsContentRow="1"  width="4%" class="index_num">
				<!-- isOnMainPage 若为true代表通知页面引入该页面 -->
				<c:choose>
					<c:when test="${isOnMainPage eq 'true' && not empty kmImeetingAgendaitem.fdAttKeyId}">
						<input type="hidden" name="kmImeetingAgendaForms[${vstatus.index}].fdId" value="${kmImeetingAgendaitem.fdAttKeyId}" id="detail_fdTopicId_${param.forIndex}" /> 
					</c:when>
					<c:otherwise>
						<input type="hidden" name="kmImeetingAgendaForms[${vstatus.index}].fdId" value="${kmImeetingAgendaitem.fdId}" id="detail_fdTopicId_${param.forIndex}" /> 
					</c:otherwise>
				</c:choose>
				<i class="meeting-content-num">${vstatus.index+1}</i>
			</td>
			<td  width="95%">
				<div class="meeting-content-item">
	                <div class="meeting-content-panel">
	                  <div>
	                    <div class="meeting-view-title clearfix">
	                      <p class="meeting-view-title-name td_reporter" title="${kmImeetingAgendaitem.docReporterName}">
	                      	${kmImeetingAgendaitem.docReporterName}
	                      </p>
	                      <div class="meeting-view-title-time clearfix">
	                        <p><c:out value="${kmImeetingAgendaitem.fdExpectStartTime}"></c:out></p>
	                      </div>
	                    </div>
	                    <div class="meeting-view-content">
	                      <div class="meeting-view-content-top">
	                        <div>
	                          <p class="meeting-view-content-title td_subject"><c:out value="${kmImeetingAgendaitem.docSubject}"></c:out></p>
	                          <div class="meeting-view-content-line">
	                            <p class="meeting-view-content-desc"><bean:message bundle="km-imeeting" key="kmImeetingTopic.organizer" />：</p>
	                            <p class="meeting-view-content-info td_chargeUnit">
	                            	${kmImeetingAgendaitem.fdChargeUnitName}
	                            </p>
	                          </div>
	                          <div class="meeting-view-content-line">
	                            <p class="meeting-view-content-desc">${lfn:message('km-imeeting:kmImeetingAgenda.docRespons')}：</p>
	                            <p class="meeting-view-content-info td_respons">
	                            	${kmImeetingAgendaitem.docResponsName}
	                            </p>
	                          </div>
	                          <div class="meeting-view-content-line">
	                            <p class="meeting-view-content-desc">${lfn:message('km-imeeting:kmImeetingAgenda.attachmentName')}：</p>
	                            <span class="td_fromTopic">
									<input type="hidden" name="kmImeetingAgendaForms[${vstatus.index}].fdFromTopicId" value="${kmImeetingAgendaitem.fdFromTopicId}" class="muiTopicId"/>
								</span>
								
								<p class="meeting-view-content-info td_attachment">
									<c:choose>
										<c:when test="${not empty kmImeetingAgendaitem.fdAttKeyId }">
											<c:import url="/sys/attachment/sys_att_main/sysAttMain_view.jsp" charEncoding="UTF-8">
												<c:param name="fdKey" value="ImeetingUploadAtt_${kmImeetingAgendaitem.fdAttKeyId }" />
												<c:param name="fdModelName" value="com.landray.kmss.km.imeeting.model.KmImeetingMain" />
												<c:param name="fdModelId" value="${kmImeetingMainForm.fdId }" />
												<c:param name="isShowDownloadCount" value="false" />
												<c:param name="fdForceDisabledOpt" value="true" />
											</c:import>
										</c:when>
										<c:otherwise>
											<c:import url="/sys/attachment/sys_att_main/sysAttMain_view.jsp" charEncoding="UTF-8">
												<c:param name="fdKey" value="ImeetingUploadAtt_${kmImeetingAgendaitem.fdId }" />
												<c:param name="fdModelName" value="com.landray.kmss.km.imeeting.model.KmImeetingMain" />
												<c:param name="fdModelId" value="${kmImeetingMainForm.fdId }" />
												<c:param name="isShowDownloadCount" value="false" />
												<c:param name="fdForceDisabledOpt" value="true" />
											</c:import>
										</c:otherwise>
									</c:choose>
								</p>
	                          </div>
	                          <%
							 	if(KmImeetingConfigUtil.isBoenEnable()){
							 %>
	                          <div class="meeting-view-content-line">
	                            <p class="meeting-view-content-desc"><bean:message bundle="km-imeeting" key="kmImeetingTopic.pizhufujian" />：</p>
	                            <span class="td_fromTopic">
									<input type="hidden" name="kmImeetingAgendaForms[${vstatus.index}].fdFromTopicId" value="${kmImeetingAgendaitem.fdFromTopicId}" class="muiTopicId"/>
								</span>
								<p class="meeting-view-content-info">
									<c:import url="/sys/attachment/sys_att_main/sysAttMain_view.jsp" charEncoding="UTF-8">
										<c:param name="fdKey" value="issueAttBoen_${kmImeetingAgendaitem.fdId }" />
										<c:param name="fdModelName" value="com.landray.kmss.km.imeeting.model.KmImeetingMain" />
										<c:param name="fdModelId" value="${kmImeetingMainForm.fdId }" />
										<c:param name="isShowDownloadCount" value="false" />
										<c:param name="fdForceDisabledOpt" value="true" />
									</c:import>
								</p>
	                          </div>
	                          <%} %>
	                        </div>
	                      </div>
	                      <div class="meeting-view-content-bottom">
	                        <div class="meeting-view-content-line">
	                          <p class="meeting-view-content-desc"><bean:message bundle="km-imeeting" key="kmImeetingTopic.recommended.attendance.units" />：</p>
	                          <ul class="meeting-view-content-list clearfix">
	                            <li class="td_attendUnit">
	                            	 ${kmImeetingAgendaitem.fdAttendUnitNames}
	                            </li>
	                          </ul>
	                        </div>
	                        <div class="meeting-view-content-line">
	                          <p class="meeting-view-content-desc"><bean:message bundle="km-imeeting" key="kmImeetingTopic.suggested.listening.units" />：</p>
	                          <ul class="meeting-view-content-list clearfix">
	                            <li class="td_listenUnit">
	                            	${kmImeetingAgendaitem.fdListenUnitNames}
	                            </li>
	                          </ul>
	                        </div>
	                      </div>
	                    </div>
	                  </div>
	                </div>
	             </div>
			</td>
		</tr>
		<%
			} 
		}
		%>
	</c:forEach>
	<%
		if (StringUtil.isNotNull(fdIds)) {
			fdIds = fdIds.substring(0, fdIds.length());
			String[] fdIdArray = fdIds.split(";");
			IKmImeetingAgendaService kmImeetingAgendaService = (IKmImeetingAgendaService) SpringBeanUtil.getBean("kmImeetingAgendaService");
			JSONArray jsonArr = kmImeetingAgendaService.loadAttendUnitList(fdIdArray);
			request.setAttribute("unitListInfo", jsonArr.toString());
		}
	%>
</table>
<script>Com_IncludeFile("doclist.js");</script>
<script type="text/javascript">
	$(document).ready(function() {
		var unitListInfo = ${unitListInfo};
		if (unitListInfo) {
			buildAttendUnits(unitListInfo);
		}
	});

	window.buildAttendUnits = function(results) {
    	var firstTr = $("#attendUnitFirstTr");
    	firstTr.nextAll().html("");
    	var html = "";
    	for (var i = 0; i < results.length; i++) {
    		html += '<tr>'
    			+ '<td>'
						+ '<input type="hidden" name="fdAttendUnit" ' + 'value="' + results[i].fdUnitId + '" id="fdAttendUnit" >'
						+ results[i].fdUnitName 
				+ '</td>'
				+ '<td>'
					+ '<input type="hidden" name="fdMeetingerId" ' + 'value="' + results[i].fdMeetingerId + '" id="fdAttendUnit" >'
					+ results[i].fdMeetingerName
				+ '</td>'
				+ '<td>'
					+ results[i].fdTopicName
				+ '</td>'
			+ '</tr>';
    	}
    	if (html) {
    		firstTr.after(html);
    	}
	};
</script>