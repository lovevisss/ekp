<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="/sys/ui/jsp/common.jsp"%>
<%@page import="com.landray.kmss.km.imeeting.util.KmImeetingConfigUtil"%>
<%@page import="com.landray.kmss.km.imeeting.forms.KmImeetingMainForm"%>
<script>Com_IncludeFile("doclist.js");</script>

<script type="text/javascript">

	$(document).ready(function() {
		var topicIds = "";
		var topicIdArray = new Array();
		topicIdArray = $("[id='detail_fdTopicId']");
		if (topicIdArray) {
			$.each(topicIdArray, function(item, value) {
				topicIds += value.value + ";";
			});
			buildAttendUnits(topicIds);
		}
	});

	function buildAttendUnits(ids) {
		if (!ids) {
			return;
		}
		var data = new KMSSData();
	    var url = "${KMSS_Parameter_ContextPath}km/imeeting/km_imeeting_topic/kmImeetingTopic.do?method=loadAttendUnitList&ids="+ ids;
	    data.SendToUrl(url, function(data) {
	    	var results = eval("(" + data.responseText + ")");
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
	    });
	};
</script>
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
					<input type="hidden" name="kmImeetingVicePlaceDetailForms[${vstatus.index}].fdId" value="${kmImeetingVicePlaceDetailitem.fdId}" /> 
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
	<c:forEach items="${kmImeetingMainForm.kmImeetingTopicForms}"  var="kmImeetingTopicItem" varStatus="vstatus">
		<tr KMSS_IsContentRow="1">
			<td KMSS_IsContentRow="1"  width="4%" class="index_num">
				<input type="hidden" name="kmImeetingTopicForms[${vstatus.index}].fdId" value="${kmImeetingTopicItem.fdId}" id="detail_fdTopicId"/> 
				<i class="meeting-content-num">${vstatus.index+1}</i>
			</td>
			<td  width="95%">
				<div class="meeting-content-item">
	                <div class="meeting-content-panel">
	                  <div>
	                    <div class="meeting-view-title clearfix">
	                      <p class="meeting-view-title-name td_reporter" title="${kmImeetingTopicItem.fdReporterName}">
	                      	${kmImeetingTopicItem.fdReporterName}
	                      </p>
	                      <div class="meeting-view-title-time clearfix">
	                        <p><c:out value="${kmImeetingTopicItem.fdExpectStartTime}"></c:out></p>
	                      </div>
	                    </div>
	                    <div class="meeting-view-content">
	                      <div class="meeting-view-content-top">
	                        <div>
	                          <p class="meeting-view-content-title td_subject"><c:out value="${kmImeetingTopicItem.docSubject}"></c:out></p>
	                          <div class="meeting-view-content-line">
	                            <p class="meeting-view-content-desc"><bean:message bundle="km-imeeting" key="kmImeetingTopic.organizer" />：</p>
	                            <p class="meeting-view-content-info td_chargeUnit">
	                            	${kmImeetingTopicItem.fdChargeUnitName}
	                            </p>
	                          </div>
	                          <div class="meeting-view-content-line">
	                            <p class="meeting-view-content-desc">${lfn:message('km-imeeting:kmImeetingAgenda.docRespons')}：</p>
	                            <p class="meeting-view-content-info td_respons">
	                            	${kmImeetingTopicItem.fdMaterialStaffName}
	                            </p>
	                          </div>
	                          <div class="meeting-view-content-line">
	                            <p class="meeting-view-content-desc">${lfn:message('km-imeeting:kmImeetingAgenda.attachmentName')}：</p>
	                           <%--  <span class="td_fromTopic">
									<input type="hidden" name="kmImeetingTopicForms[${vstatus.index}].fdFromTopicId" value="${kmImeetingTopicItem.fdFromTopicId}" class="muiTopicId"/>
								</span> --%>
								<p class="meeting-view-content-info td_attachment">
									<c:import url="/sys/attachment/sys_att_main/sysAttMain_view.jsp" charEncoding="UTF-8">
										<c:param name="fdKey" value="attachment" />
										<c:param name="fdModelName" value="com.landray.kmss.km.imeeting.model.KmImeetingTopic" />
										<c:param name="fdModelId" value="${kmImeetingTopicItem.fdId}" />
										<c:param name="isShowDownloadCount" value="false" />
									</c:import>
								</p>
	                          </div>
	                          <%
							 	if(KmImeetingConfigUtil.isBoenEnable()){
							 %>
	                          <div class="meeting-view-content-line">
	                            <p class="meeting-view-content-desc"><bean:message bundle="km-imeeting" key="kmImeetingTopic.pizhufujian" />：</p>
	                           <%--  <span class="td_fromTopic">
									<input type="hidden" name="kmImeetingTopicForms[${vstatus.index}].fdFromTopicId" value="${kmImeetingTopicItem.fdFromTopicId}" class="muiTopicId"/>
								</span> --%>
								<p class="meeting-view-content-info">
									<c:import url="/sys/attachment/sys_att_main/sysAttMain_view.jsp" charEncoding="UTF-8">
										<c:param name="fdKey" value="issueAttBoen_${kmImeetingTopicItem.fdId }" />
										<c:param name="fdModelName" value="com.landray.kmss.km.imeeting.model.KmImeetingMain" />
										<c:param name="fdModelId" value="${kmImeetingMainForm.fdId }" />
										<c:param name="isShowDownloadCount" value="false" />
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
	                            	 ${kmImeetingTopicItem.fdAttendUnitNames}
	                            </li>
	                          </ul>
	                        </div>
	                        <div class="meeting-view-content-line">
	                          <p class="meeting-view-content-desc"><bean:message bundle="km-imeeting" key="kmImeetingTopic.suggested.listening.units" />：</p>
	                          <ul class="meeting-view-content-list clearfix">
	                            <li class="td_listenUnit">
	                            	${kmImeetingTopicItem.fdListenUnitNames}
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
	</c:forEach>
</table>