<%@page import="com.landray.kmss.util.ArrayUtil"%>
<%@page import="java.util.List"%>
<%@page import="com.landray.kmss.km.imeeting.forms.KmImeetingSummaryForm"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/sys/ui/jsp/common.jsp"%>
<%
	Object mainForm = request.getAttribute("kmImeetingSummaryForm");
	pageContext.setAttribute("com.landray.kmss.web.taglib.FormBean", mainForm, PageContext.REQUEST_SCOPE);
%>
<%
	KmImeetingSummaryForm kmImeetingSummaryForm = (KmImeetingSummaryForm) request.getAttribute("kmImeetingSummaryForm");
	String[] fdNotifyPersonList = kmImeetingSummaryForm.getFdNotifyPersonList();
	String notifyPerson = "";
	if (fdNotifyPersonList != null && fdNotifyPersonList.length > 0) {
		notifyPerson = ArrayUtil.concat(fdNotifyPersonList, ';');
	}
	request.setAttribute("notifyPerson", notifyPerson);
%>
<template:include ref="default.simple">
	<template:replace name="body">
		<script>
			Com_IncludeFile("jquery.js|dialog.js|doclist.js");
		</script>
		<script>
			seajs.use(['lui/dialog','lui/jquery','km/imeeting/resource/js/dateUtil'],function(dialog,$,dateUtil){
				$(document).ready(function() {
					//初始化会议历时
					if('${kmImeetingSummaryForm.fdHoldDuration}'){
						//将小时分解成时分
						var timeObj=dateUtil.splitTime({"ms":"${kmImeetingSummaryForm.fdHoldDuration}"});
						$('.fdHoldDurationHourBox').html(timeObj.hour);
						$('.fdHoldDurationMinBox').html(timeObj.minute);
						if(timeObj.minute){
							$('.fdHoldDurationMinSpanBox').show();
						}else{
							$('.fdHoldDurationMinSpanBox').hide();
						}
					}
				});
			});
		</script>
		<div>
			<table class="tb_normal" width=100% id="Table_Main">
				<tr>
					<%-- 会议名称--%>
					<td class="td_normal_title" width=15%>
						<bean:message bundle="km-imeeting" key="kmImeetingSummary.fdName"/>
					</td>
					<td width="35%">
						<c:out value="${kmImeetingSummaryForm.fdName}"></c:out>
					</td>
					<%-- 会议类型--%>
					<td class="td_normal_title" width=15%>
						<bean:message bundle="km-imeeting" key="kmImeetingSummary.fdTemplate"/>
					</td>
					<td width="35%">
						<c:out value="${kmImeetingSummaryForm.fdTemplateName}"></c:out>
					</td>
				</tr>
				<tr>
					<%-- 主持人--%>
					<td class="td_normal_title" width=15%>
						<bean:message bundle="km-imeeting" key="kmImeetingSummary.fdHost"/>
					</td>
					<td colspan="3" width="85%">
						<c:out value="${kmImeetingSummaryForm.fdHostName}"></c:out>
					</td>
				</tr>
				<tr>
					<%-- 会议时间--%>
					<td class="td_normal_title" width=15%>
						<bean:message bundle="km-imeeting" key="kmImeetingMain.fdDate"/>
					</td>
					<td width="35%">
						<c:out value="${kmImeetingSummaryForm.fdHoldDate}"></c:out>~
						<c:out value="${kmImeetingSummaryForm.fdFinishDate}"></c:out>
					</td>
					<%--会议历时--%>
					<td class="td_normal_title" width=15%>
						<bean:message bundle="km-imeeting" key="kmImeetingMain.fdHoldDuration"/>
					</td>			
					<td width="35%" >
						<span id ="fdHoldDurationHour"  class="fdHoldDurationHourBox"></span><bean:message key="date.interval.hour"/>
						<span id="fdHoldDurationMinSpan" class="fdHoldDurationMinSpanBox"><span id ="fdHoldDurationMin" class="fdHoldDurationMinBox"></span><bean:message key="date.interval.minute"/></span>
					</td>
				</tr>
				<tr>
					<%-- 会议地点--%>
					<td class="td_normal_title" width=15%>
						<bean:message bundle="km-imeeting" key="kmImeetingSummary.fdPlace"/>
					</td>
					<td colspan="3" width="85%">
						<c:out value="${kmImeetingSummaryForm.fdPlaceName} ${kmImeetingSummaryForm.fdOtherPlace}"></c:out>
					</td>
				</tr>
				<tr>
					<%-- 计划参加人员--%>
					<td class="td_normal_title" width=15%>
				   		<bean:message bundle="km-imeeting" key="kmImeetingSummary.fdPlanAttendPersons" />
					</td>
					<td width="85%"  colspan="3" style="word-break:break-all">
						<c:if test="${ not empty kmImeetingSummaryForm.fdPlanAttendPersonNames }">
							<div>
								<span style="vertical-align: top;">
									<c:out value="${kmImeetingSummaryForm.fdPlanAttendPersonNames }"></c:out>
								</span>
							</div>
						</c:if>
					</td>
				</tr>
				<tr>
					<%-- 邀请参加人员--%>
					<td class="td_normal_title" width=15%>
				   		<bean:message bundle="km-imeeting" key="kmImeetingSummary.fdPlanInvitePersons" />
					</td>
					<td width="85%"  colspan="3" style="word-break:break-all">
						<c:if test="${ not empty kmImeetingSummaryForm.fdPlanInvitePersonNames }">
							<div>
								<span style="vertical-align: top;">
									<c:out value="${kmImeetingSummaryForm.fdPlanInvitePersonNames }"></c:out>
								</span>
							</div>
						</c:if>
					</td>
				</tr>
				<tr>
					<!-- 计划列席人员 -->
					<td class="td_normal_title" width=15%>
				   		<bean:message bundle="km-imeeting" key="kmImeetingSummary.fdPlanParticipantPersons" />
					</td>
					<td width="85%"  colspan="3" style="word-break:break-all">
						<c:if test="${ not empty kmImeetingSummaryForm.fdPlanParticipantPersonNames }">
							<div>
								<span style="vertical-align: top;">
									<c:out value="${kmImeetingSummaryForm.fdPlanParticipantPersonNames }"></c:out>
								</span>
							</div>
						</c:if>
					</td>
				</tr>
				<tr>
					<!-- 实际与会人员 -->
					<td class="td_normal_title" width=15%>
					   <bean:message bundle="km-imeeting" key="kmImeetingSummary.fdActualAttendPersons" />
					</td>
					<td width="85%"  colspan="3" style="word-break:break-all">
						<c:if test="${ not empty kmImeetingSummaryForm.fdActualAttendPersonNames }">
							<div>
								<span style="vertical-align: top;">
									<c:out value="${kmImeetingSummaryForm.fdActualAttendPersonNames }"></c:out>
								</span>
							</div>
						</c:if>
					</td>
				</tr>
				<tr>
					<%-- 编辑内容--%>
					<td class="td_normal_title" width=15%>
						<bean:message bundle="km-imeeting" key="kmImeetingSummary.docContent" />
					</td>
					<td width=85% colspan="3" id="contentDiv">
						<c:if test="${kmImeetingSummaryForm.fdContentType=='rtf'}">
							${kmImeetingSummaryForm.docContent}
						</c:if>
						<c:if test="${kmImeetingSummaryForm.fdContentType=='word'}">
							<c:import url="/sys/attachment/sys_att_main/sysAttMain_view.jsp" charEncoding="UTF-8">
								<c:param name="fdKey" value="editonline" />
								<c:param name="fdModelName" value="com.landray.kmss.km.imeeting.model.KmImeetingSummary" />
								<c:param name="fdModelId" value="${kmImeetingSummaryForm.fdId }" />
								<c:param name="isShowDownloadCount" value="false" />
								<c:param name="fdForceDisabledOpt" value="true" />
							</c:import>
						</c:if>
					</td>
				</tr>
				<tr>
					<%--相关资料--%>
			 		<td class="td_normal_title" width=15%>
			 			<bean:message bundle="sys-attachment" key="table.sysAttMain"/>
			 		</td>
					<td width="85%" colspan="3" >
						<c:import url="/sys/attachment/sys_att_main/sysAttMain_view.jsp" charEncoding="UTF-8">
							<c:param name="fdKey" value="attachment" />
							<c:param name="fdModelId" value="${kmImeetingSummaryForm.fdId }" />
							<c:param name="fdModelName" value="com.landray.kmss.km.imeeting.model.KmImeetingSummary" />
							<c:param name="fdForceDisabledOpt" value="true" />
							<c:param name="isShowDownloadCount" value="false" />
						</c:import>
					</td>
				</tr>
				<tr>
					<td class="td_normal_title" width=15%>
						<bean:message bundle="km-imeeting" key="kmImeetingSummary.fdNotifyType" />
					</td>
					<td colspan="3">
						<kmss:showNotifyType value="${kmImeetingSummaryForm.fdNotifyType}"></kmss:showNotifyType>
					</td>
				</tr>
				<tr>
					<td class="td_normal_title" width=15%>
						<bean:message bundle="km-imeeting" key="kmImeetingSummary.fdNotifyPerson" />
					</td>
					<td colspan="3">
						<xform:checkbox property="fdNotifyPersonList" value="${notifyPerson}" showStatus="readOnly">
							<xform:enumsDataSource enumsType="kmImeetingSummary_fdNotifyPerson"></xform:enumsDataSource>
						</xform:checkbox>
					</td>
				</tr>
				<tr>
					<%-- 纪要录入人--%>
					<td class="td_normal_title" width=15%>
						<bean:message bundle="km-imeeting" key="kmImeetingSummary.docCreator"/>
					</td>
					<td width="35%">
						<c:out value="${kmImeetingSummaryForm.docCreatorName }"></c:out>
					</td>
					<%-- 录入时间--%>
					<td class="td_normal_title" width=15%>
						<bean:message bundle="km-imeeting" key="kmImeetingSummary.docCreateTime"/>
					</td>
					<td width="35%">
						<c:out value="${kmImeetingSummaryForm.docCreateTime }"></c:out>
					</td>
				</tr>
			</table>
		</div>
	</template:replace> 
</template:include>