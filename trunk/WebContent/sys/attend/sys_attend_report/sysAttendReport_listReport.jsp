<%@page import="com.landray.kmss.util.SpringBeanUtil"%>
<%@ page language="java" contentType="text/json; charset=UTF-8"	pageEncoding="UTF-8"%>
<%@ include file="/sys/ui/jsp/common.jsp"%>
<%@ page import="com.landray.kmss.util.DateUtil,java.util.Date,java.text.DecimalFormat,java.util.Map,java.util.List" %>
<%@ page import="com.landray.kmss.sys.attend.util.AttendUtil,com.landray.kmss.util.StringUtil"%>
<%@ page import="com.landray.kmss.sys.time.util.SysTimeUtil,com.landray.kmss.util.NumberUtil"%>
<%@ page import="com.landray.kmss.util.ResourceUtil,com.landray.kmss.util.SpringBeanUtil,net.sf.json.JSONObject" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions"  prefix="fn" %>

<list:data>
	<list:data-columns var="model" list="${queryPage.list}" varIndex="status">
		<list:data-column property="fdId">
		</list:data-column>
		<list:data-column col="index">
		  ${status+1}
		</list:data-column>

		<c:set var="_docCreatorId" value="${model.docCreator.fdId }"></c:set>
		<%
			String _docCreatorId = (String) pageContext.getAttribute("_docCreatorId");
			Map<String, JSONObject> personInfoMap = (Map<String, JSONObject>)request.getAttribute("personInfoMap");
			String fdStaffNo="";
			String fdEntryTime="";
			if(null!=personInfoMap){
				JSONObject obj=personInfoMap.get(_docCreatorId);
				if(obj!=null&&obj.containsKey("fdStaffNo")) {
					fdStaffNo=obj.getString("fdStaffNo");
				}
				if(obj!=null&&obj.containsKey("fdEntryTime")) {
					fdEntryTime=obj.getString("fdEntryTime");
					if(StringUtil.isNotNull(fdEntryTime)&&!"null".equals(fdEntryTime)) {
						Date entryTime=DateUtil.convertStringToDate(fdEntryTime, DateUtil.TYPE_DATE, null);
						fdEntryTime=DateUtil.convertDateToString(entryTime, DateUtil.TYPE_DATE, null);
					}
				}
			}
			
			pageContext.setAttribute("__fdStaffNo", fdStaffNo);
			pageContext.setAttribute("__fdEntryTime", fdEntryTime);
		%>
		<c:if test="${fn:contains(fdShowCols, 'fdStaffNo')}">
		<list:data-column col="fdStaffNo" title="${lfn:message('sys-attend:sysAttendStatMonth.fdStaffNo') }" escape="false" headerStyle="min-width: 65px;">
			${__fdStaffNo}
		</list:data-column>
		</c:if>
		<list:data-column col="docCreator.fdName" title="${ lfn:message('sys-attend:sysAttendStatMonth.docCreatorName') }" escape="false" headerStyle="min-width: 65px;">
			<c:if test="${model.docCreator.fdIsAvailable}">
				${model.docCreator.fdName}
			</c:if>
			<c:if test="${!model.docCreator.fdIsAvailable}">
				${model.docCreator.fdName}${ lfn:message('sys-attend:sysAttendStatDetail.alreadyQuit') }
			</c:if>
		</list:data-column>
		
		<c:if test="${fn:contains(fdShowCols, 'fdDept')}">
		<list:data-column col="fdDept" title="${ lfn:message('sys-attend:sysAttendStatMonth.dept') }" escape="false" headerStyle="min-width: 100px;">
			${model.docCreator.fdParent != null ? model.docCreator.fdParent.fdName : ""}
		</list:data-column>
		</c:if>
		<c:if test="${fn:contains(fdShowCols, 'fdEntryTime')}">
		<list:data-column col="fdEntryTime" title="${lfn:message('sys-attend:sysAttendStatMonth.fdEntryTime') }" escape="false" headerStyle="min-width: 100px;">
			${__fdEntryTime}
		</list:data-column>
		</c:if>
		<c:if test="${fn:contains(fdShowCols, 'fdCategoryName')}">
		<list:data-column col="fdCategoryName" title="${ lfn:message('sys-attend:sysAttendStatMonth.category') }" escape="false" headerStyle="min-width: 100px;">
			${model.fdCategoryName}
		</list:data-column>
		</c:if>
		<c:choose>
			<c:when test="${fdDateType == '2' }">
				<list:data-column col="fdMonth" title="${ lfn:message('sys-attend:sysAttendStatMonth.period') }" escape="false" headerStyle="min-width: 180px;">
					<c:set var="_fdStartTime" value="${model.fdStartTime }"></c:set>
					<c:set var="_fdEndTime" value="${model.fdEndTime }"></c:set>
					<%
						Date _fdStartTime = (Date) pageContext.getAttribute("_fdStartTime");
						Date _fdEndTime = (Date) pageContext.getAttribute("_fdEndTime");
						pageContext.setAttribute("__fdStartTime", DateUtil.convertDateToString(_fdStartTime, DateUtil.TYPE_DATE, null));
						pageContext.setAttribute("__fdEndTime", DateUtil.convertDateToString(_fdEndTime, DateUtil.TYPE_DATE, null));
					%>
					${__fdStartTime}~${__fdEndTime}
				</list:data-column>
			</c:when>
			<c:otherwise>
				<list:data-column col="fdMonth" title="${ lfn:message('sys-attend:sysAttendStatMonth.fdMonth') }" escape="false" headerStyle="min-width: 65px;">
					<c:set var="_fdMonth" value="${model.fdMonth }"></c:set>
					<%
						Date _fdMonth = (Date) pageContext.getAttribute("_fdMonth");
						pageContext.setAttribute("__fdMonth", DateUtil.convertDateToString(_fdMonth, "yyyy-MM"));
					%>
					${__fdMonth}
				</list:data-column>
			</c:otherwise>
		</c:choose>
		
		<c:if test="${fn:contains(fdShowCols, 'fdShouldDays')}">
		<list:data-column col="fdShouldDays" title="${ lfn:message('sys-attend:sysAttendStatMonth.fdShouldDays') }" escape="false">
			${model.fdShouldDays}
		</list:data-column>
		</c:if>
		<c:if test="${fn:contains(fdShowCols, 'fdHolidays')}">
		<list:data-column col="fdHolidays" title="${ lfn:message('sys-attend:sysAttendStatMonth.fdShouldDaysAndHolidays') }" escape="false">
			<c:if test="${model.fdHolidays != null }">
				${model.fdShouldDays+model.fdHolidays}
			</c:if>
			<c:if test="${model.fdHolidays == null }">
				${model.fdShouldDays}
			</c:if>
		</list:data-column>
		</c:if>
		<c:if test="${fn:contains(fdShowCols, 'fdActualDays')}">
		<list:data-column col="fdActualDays" title="${ lfn:message('sys-attend:sysAttendStatMonth.fdActualDays') }" escape="false">
			${model.fdActualDays}
		</list:data-column>
		</c:if>
		
		<c:if test="${fn:contains(fdShowCols, 'fdStatusDays')}">
		<list:data-column col="fdStatusDays" title="${ lfn:message('sys-attend:sysAttendStatMonth.fdStatusDays') }" escape="false">
			${model.fdStatusDays}
		</list:data-column>
		</c:if>
		<c:if test="${fn:contains(fdShowCols, 'fdWorkDateDays')}">
			<list:data-column col="fdWorkDateDays" title="${ lfn:message('sys-attend:sysAttendStatMonth.fdWorkDateDays') }" escape="false">
				<c:if test="${not empty model.fdWorkDateDays}">${model.fdWorkDateDays }</c:if>
				<c:if test="${empty model.fdWorkDateDays}">0</c:if>
			</list:data-column>
		</c:if>
		
		<c:set var="_fdAbsentDaysCount" value="${model.fdAbsentDaysCount }"></c:set>
		<c:set var="_fdAbsentDays" value="${model.fdAbsentDays}"></c:set>
		<%
			DecimalFormat df = new DecimalFormat("#.#");
			Float _fdAbsentDaysCount = (Float) pageContext.getAttribute("_fdAbsentDaysCount");
			Integer _fdAbsentDays = (Integer) pageContext.getAttribute("_fdAbsentDays");
			pageContext.setAttribute("__fdAbsentDaysCount", _fdAbsentDaysCount == null ? (_fdAbsentDays == null ? 0 : _fdAbsentDays) : df.format(_fdAbsentDaysCount));
		%>
		<c:if test="${fn:contains(fdShowCols, 'fdAbsentDays')}">
		<list:data-column col="fdAbsentDays" title="${ lfn:message('sys-attend:sysAttendStatMonth.fdAbsentDays') }" escape="false">
			${__fdAbsentDaysCount}
		</list:data-column>
		</c:if>
		
		<c:set var="_fdTripDays" value="${model.fdTripDays }"></c:set>
		<%
			Float __fdTripDays = (Float) pageContext.getAttribute("_fdTripDays");
			pageContext.setAttribute("__fdTripDays", df.format(__fdTripDays));
		%>
		<c:if test="${fn:contains(fdShowCols, 'fdTripDays')}">
		<list:data-column col="fdTripDays" title="${ lfn:message('sys-attend:sysAttendStatMonth.fdTripDays') }" escape="false">
			${__fdTripDays}
		</list:data-column>
		</c:if>
		<c:if test="${fn:contains(fdShowCols, 'fdOffDays')}">
		<list:data-column col="fdOffDays" title="${ lfn:message('sys-attend:sysAttendStatMonth.fdOffDays') }" escape="false">
			<c:set var="_fdLeaveDays" value="${model.fdLeaveDays }"></c:set>
			<c:set var="_fdOffDays" value="${model.fdOffDays }"></c:set>
			<c:set var="_fdOffTime" value="${model.fdOffTimeHour }"></c:set>
			<%
				Float __fdLeaveDays = (Float) pageContext.getAttribute("_fdLeaveDays");
				if(__fdLeaveDays !=null && __fdLeaveDays > 0){
					//汇总中，如果直接统计了请假天，则直接使用。否则使用拼接，兼容历史数据
					pageContext.setAttribute("__fdOffDays", NumberUtil.roundDecimal(__fdLeaveDays,3));
				}else {
					Float __fdOffDays = (Float) pageContext.getAttribute("_fdOffDays");
					__fdOffDays = __fdOffDays == null ? 0f : __fdOffDays;

					Float __fdOffTime = (Float) pageContext.getAttribute("_fdOffTime");
					__fdOffTime = __fdOffTime == null ? 0 : __fdOffTime;
					pageContext.setAttribute("__fdOffDays", SysTimeUtil.formatLeaveTimeStr(__fdOffDays, __fdOffTime));
				}
			%>
			${__fdOffDays}
		</list:data-column>
		</c:if>
		<c:if test="${fn:contains(fdShowCols, 'fdLateCount')}">
		<list:data-column col="fdLateCount" title="${ lfn:message('sys-attend:sysAttendStatMonth.fdLateCount') }" escape="false">
			${model.fdLateCount}
		</list:data-column>
		</c:if>
		<c:if test="${fn:contains(fdShowCols, 'fdLateTime')}">
		<list:data-column col="fdLateTime" title="${ lfn:message('sys-attend:sysAttendStatMonth.fdLateTime') }" escape="false">
			${model.fdLateTime}
		</list:data-column>
		</c:if>
		<c:if test="${fn:contains(fdShowCols, 'fdLeftCount')}">
		<list:data-column col="fdLeftCount" title="${ lfn:message('sys-attend:sysAttendStatMonth.fdLeftCount') }" escape="false">
			${model.fdLeftCount}
		</list:data-column>
		</c:if>
		<c:if test="${fn:contains(fdShowCols, 'fdLeftTime')}">
		<list:data-column col="fdLeftTime" title="${ lfn:message('sys-attend:sysAttendStatMonth.fdLeftTime') }" escape="false">
			${model.fdLeftTime}
		</list:data-column>
		</c:if>
		<c:if test="${fn:contains(fdShowCols, 'fdOutsideCount')}">
		<list:data-column col="fdOutsideCount" title="${ lfn:message('sys-attend:sysAttendStatMonth.fdOutsideCount') }" escape="false">
			${model.fdOutsideCount}
		</list:data-column>
		</c:if>
		<c:if test="${fn:contains(fdShowCols, 'fdMissedCount')}">
		<list:data-column col="fdMissedCount" title="${ lfn:message('sys-attend:sysAttendStatMonth.fdMissedCount') }" escape="false">
			${model.fdMissedCount}
		</list:data-column>
		</c:if>
		<c:if test="${fn:contains(fdShowCols, 'fdTotalTime')}">
		<list:data-column col="fdTotalTime" title="${ lfn:message('sys-attend:sysAttendStatMonth.fdTotalTime') }" escape="false">
			<c:set var="_fdTotalTime" value="${model.fdTotalTime }"></c:set>
			<%
				Long __fdTotalTime = (Long) pageContext.getAttribute("_fdTotalTime");
			
				Integer totalTime = __fdTotalTime==null ? 0:__fdTotalTime.intValue();
	  			int hour = totalTime/60;
				int mins = totalTime%60;
				String hourTxt = "";
				String hTxt = ResourceUtil.getString("date.interval.hour");
				String mTxt = ResourceUtil.getString("date.interval.minute");
				if(hour>0){
					hourTxt+=hour+hTxt;
				}
				if(mins>0){
					hourTxt+=mins+mTxt;
				}
				pageContext.setAttribute("__fdTotalTime", hourTxt);
			%>
			${__fdTotalTime}
		</list:data-column>
		</c:if>
		<c:if test="${fn:contains(fdShowCols, 'fdOverTime')}">
		<list:data-column col="fdOverTime" title="${ lfn:message('sys-attend:sysAttendStatMonth.fdOverTime') }" escape="false">
			<c:set var="_fdOverTime" value="${model.fdOverTime }"></c:set>
			<%
				Long __fdOverTime = (Long) pageContext.getAttribute("_fdOverTime");
				Integer overTime = __fdOverTime==null ? 0:__fdOverTime.intValue();
	  			int hour = overTime/60;
				int mins = overTime%60;
				String hourTxt = "";
				String hTxt = ResourceUtil.getString("date.interval.hour");
				String mTxt = ResourceUtil.getString("date.interval.minute");
				if(hour>0){
					hourTxt+=hour+hTxt;
				}
				if(mins>0){
					hourTxt+=mins+mTxt;
				}
				pageContext.setAttribute("__fdOverTime", hourTxt);
			%>
			${__fdOverTime}
		</list:data-column>
		</c:if>
		<c:if test="${fn:contains(fdShowCols, 'fdWorkOverTime')}">
		<list:data-column col="fdWorkOverTime" title="${ lfn:message('sys-attend:sysAttendStatMonth.fdWorkOverTime') }" escape="false">
			<c:set var="_fdWorkOverTime" value="${model.fdWorkOverTime }"></c:set>
			<%
				Long __fdWorkOverTime = (Long) pageContext.getAttribute("_fdWorkOverTime");
				Integer workOverTime = __fdWorkOverTime==null ? 0:__fdWorkOverTime.intValue();
	  			int hour = workOverTime/60;
				int mins = workOverTime%60;
				String hourTxt = "";
				String hTxt = ResourceUtil.getString("date.interval.hour");
				String mTxt = ResourceUtil.getString("date.interval.minute");
				if(hour>0){
					hourTxt+=hour+hTxt;
				}
				if(mins>0){
					hourTxt+=mins+mTxt;
				}
				pageContext.setAttribute("__fdWorkOverTime", hourTxt);
			%>
			${__fdWorkOverTime}
		</list:data-column>
		</c:if>
		<c:if test="${fn:contains(fdShowCols, 'fdOffOverTime')}">
		<list:data-column col="fdOffOverTime" title="${ lfn:message('sys-attend:sysAttendStatMonth.fdOffOverTime') }" escape="false">
			<c:set var="_fdOffOverTime" value="${model.fdOffOverTime }"></c:set>
			<%
				Long __fdOffOverTime = (Long) pageContext.getAttribute("_fdOffOverTime");
				Integer OffOverTime = __fdOffOverTime==null ? 0:__fdOffOverTime.intValue();
	  			int hour = OffOverTime/60;
				int mins = OffOverTime%60;
				String hourTxt = "";
				String hTxt = ResourceUtil.getString("date.interval.hour");
				String mTxt = ResourceUtil.getString("date.interval.minute");
				if(hour>0){
					hourTxt+=hour+hTxt;
				}
				if(mins>0){
					hourTxt+=mins+mTxt;
				}
				pageContext.setAttribute("__fdOffOverTime",hourTxt);
			%>
			${__fdOffOverTime}
		</list:data-column>
		</c:if>
		<c:if test="${fn:contains(fdShowCols, 'fdHolidayOverTime')}">
		<list:data-column col="fdHolidayOverTime" title="${ lfn:message('sys-attend:sysAttendStatMonth.fdHolidayOverTime') }" escape="false">
			<c:set var="_fdHolidayOverTime" value="${model.fdHolidayOverTime }"></c:set>
			<%
				Long __fdHolidayOverTime = (Long) pageContext.getAttribute("_fdHolidayOverTime");
				Integer holidayOverTime = __fdHolidayOverTime==null ? 0:__fdHolidayOverTime.intValue();
	  			int hour = holidayOverTime/60;
				int mins = holidayOverTime%60;
				String hourTxt = "";
				String hTxt = ResourceUtil.getString("date.interval.hour");
				String mTxt = ResourceUtil.getString("date.interval.minute");
				if(hour>0){
					hourTxt+=hour+hTxt;
				}
				if(mins>0){
					hourTxt+=mins+mTxt;
				}
				pageContext.setAttribute("__fdHolidayOverTime", hourTxt);
			%>
			${__fdHolidayOverTime}
		</list:data-column>
		</c:if>

		<c:if test="${fn:contains(fdShowCols, 'fdOutgoingTime')}">
		<list:data-column col="fdOutgoingTime" title="${ lfn:message('sys-attend:sysAttendStatMonth.fdOutgoingTime') }" escape="false">
			<c:set var="_fdOutgoingTime" value="${model.fdOutgoingTime }"></c:set>
			<c:set var="_fdOutgoingDay" value="${model.fdOutgoingDay }"></c:set>
			<%
				Float _fdOutgoingDay = (Float) pageContext.getAttribute("_fdOutgoingDay");
				if(_fdOutgoingDay ==null){
					Float _fdOutgoingTime = (Float) pageContext.getAttribute("_fdOutgoingTime");
					_fdOutgoingTime = _fdOutgoingTime==null ? 0f:_fdOutgoingTime;

					pageContext.setAttribute("__fdOutgoingTime", SysTimeUtil.formatLeaveTimeStr(0f, _fdOutgoingTime));
				} else {
					pageContext.setAttribute("__fdOutgoingTime", NumberUtil.roundDecimal(_fdOutgoingDay, 2) );
				}
			%>
			${__fdOutgoingTime}
		</list:data-column>
		</c:if>
		
		<c:if test="${fn:contains(fdShowCols, 'fdMissedExcCount')}">
		<list:data-column col="fdMissedExcCount" title="${ lfn:message('sys-attend:sysAttendStatMonth.fdMissedExcCount') }" escape="false">
			${model.fdMissedExcCount==null?0:model.fdMissedExcCount}
		</list:data-column>
		</c:if>
		<c:if test="${fn:contains(fdShowCols, 'fdLateExcCount')}">
		<list:data-column col="fdLateExcCount" title="${ lfn:message('sys-attend:sysAttendStatMonth.fdLateExcCount') }" escape="false">
			${model.fdLateExcCount==null?0:model.fdLateExcCount}
		</list:data-column>
		</c:if>
		<c:if test="${fn:contains(fdShowCols, 'fdLeftExcCount')}">
		<list:data-column col="fdLeftExcCount" title="${ lfn:message('sys-attend:sysAttendStatMonth.fdLeftExcCount') }" escape="false">
			${model.fdLeftExcCount==null?0:model.fdLeftExcCount}
		</list:data-column>
		</c:if>
		
		<c:forEach items="${model.fdOffDaysDetailJson }" var="detail" varStatus="vstatus">
			<c:if test="${fn:contains(fdShowCols, detail.key)}">
				<list:data-column col="${detail.key}" title="${detail.key}" escape="false">
					${detail.value}
				</list:data-column>
			</c:if>
		</c:forEach>
			<c:if test="${fn:contains(fdShowCols, 'fdDateDetail')}">
			<c:set var="__fdId" value="${model.fdId }"></c:set>
			<c:set var="__url" value="${LUI_ContextPath}/sys/attend/sys_attend_main/sysAttendMain_index.jsp#cri.q=docCreateTime:statDate;docCreateTime:statDate;docCreator:${model.docCreator.fdId}"/>
			<%
				String fdId = (String)pageContext.getAttribute("__fdId");
				Map<String, List> statMap = (Map<String, List>)request.getAttribute("statMap");
				pageContext.setAttribute("__statList",statMap.get(fdId));
			%>
			<c:forEach items="${__statList }" var="stat" varStatus="vstatus">
				<list:data-column col="${stat.key}" title="${stat.title}" escape="false">
					<c:set var="statusValue" value="${stat.value}"></c:set>
					<c:set var="__statDate" value="${stat.statDate}"></c:set>
					<%
						String statDate = (String)pageContext.getAttribute("__statDate");
						String url = (String)pageContext.getAttribute("__url");
						pageContext.setAttribute("statusUrl",url.replaceAll("statDate", statDate));
					%>
					<c:choose>
					    <%--全天旷工 --%>
						<c:when test="${statusValue==',03'}">
							<a href="javascript:void(0)" class="lui_stat_status_red" style="cursor: auto;font-weight: bold;"><bean:message bundle="sys-attend" key="sysAttendStatMonth.fdAbsent"/></a>
						</c:when>
						<%--休息 --%>
						<c:when test="${statusValue==',02'}">
							<a href="javascript:void(0)" class="lui_stat_status_light" style="cursor: auto;"><bean:message bundle="sys-attend" key="sysAttendReport.fdStatus.rest"/></a>
						</c:when>
						<c:otherwise>
							<%--正常 --%>
							<c:if test="${fn:contains(statusValue,',01')}">
								<a href="${statusUrl}" target="_blank" class="lui_stat_status_normal">
									<bean:message bundle="sys-attend" key="sysAttendStatMonth.fdStatus"/>
								</a>
							</c:if>
							<c:if test="${!fn:contains(statusValue,',01')}">
							<a href="${statusUrl}" target="_blank" class="lui_stat_status_red">
							<%--缺卡、迟到早退、外勤 、正常--%>
							
							<%--缺卡1 --%>
							<c:if test="${fn:contains(statusValue,',071') }">
								<div style="white-space: nowrap;">
									<bean:message bundle="sys-attend" key="sysAttendMain.fdWorkType.onwork"/>
									<bean:message bundle="sys-attend" key="sysAttendMain.fdStatus.unSign"/>
								</div>
							</c:if>
							<%--迟到早退1--%>
							<c:if test="${fn:contains(statusValue,',081')||fn:contains(statusValue,',091') }">
								<div style="white-space: nowrap;">
									<bean:message bundle="sys-attend" key="sysAttendMain.fdWorkType.onwork"/>
									<bean:message bundle="sys-attend" key="sysAttendMain.fdStatus.late"/>
									<c:if test="${fn:contains(statusValue,',091') }">
									&nbsp
									<bean:message bundle="sys-attend" key="sysAttendStatMonth.fdOutside"/>
									</c:if>
								</div>
							</c:if>
							<%-- 外勤1--%>
							<c:if test="${ fn:contains(statusValue,',141')}">
								<div style="white-space: nowrap;color: #4285f4;">
									<bean:message bundle="sys-attend" key="sysAttendMain.fdWorkType.onwork"/>
									<bean:message bundle="sys-attend" key="sysAttendMain.outside"/>
								</div>
							</c:if>
							<%--正常1--%>
							<c:if test="${fn:contains(statusValue,',211') }">
								<div style="color: #343434;">
									<bean:message bundle="sys-attend" key="sysAttendMain.fdWorkType.onwork"/>
									<bean:message bundle="sys-attend" key="sysAttendStatMonth.fdStatus"/>
								</div>
							</c:if>
							
							<%--缺卡2 --%>
							<c:if test="${ fn:contains(statusValue,',101')}">
								<div style="white-space: nowrap;">
									<bean:message bundle="sys-attend" key="sysAttendMain.fdWorkType.offwork"/>
									<bean:message bundle="sys-attend" key="sysAttendMain.fdStatus.unSign"/>
								</div>
							</c:if>		
							<%--迟到早退2--%>
							<c:if test="${fn:contains(statusValue,',111')||fn:contains(statusValue,',121') }">
								<div style="white-space: nowrap;">
									<bean:message bundle="sys-attend" key="sysAttendMain.fdWorkType.offwork"/>
									<bean:message bundle="sys-attend" key="sysAttendMain.fdStatus.left"/>
									<c:if test="${fn:contains(statusValue,',121') }">
									&nbsp
									<bean:message bundle="sys-attend" key="sysAttendStatMonth.fdOutside"/>
									</c:if>
								</div>
							</c:if>
							<%-- 外勤2--%>
							<c:if test="${fn:contains(statusValue,',151') }">
								<div style="white-space: nowrap;color: #4285f4;">
									<bean:message bundle="sys-attend" key="sysAttendMain.fdWorkType.offwork"/>
									<bean:message bundle="sys-attend" key="sysAttendMain.outside"/>
								</div>
							</c:if>		
							<%--正常2--%>
							<c:if test="${fn:contains(statusValue,',212') }">
								<div style="color: #343434;">
									<bean:message bundle="sys-attend" key="sysAttendMain.fdWorkType.offwork"/>
									<bean:message bundle="sys-attend" key="sysAttendStatMonth.fdStatus"/>
								</div>
							</c:if>
												
							<%--缺卡3 --%>
							<c:if test="${fn:contains(statusValue,',072') }">
								<div style="white-space: nowrap;">
									<bean:message bundle="sys-attend" key="sysAttendMain.fdWorkType.onwork"/>
									<bean:message bundle="sys-attend" key="sysAttendMain.fdStatus.unSign"/>
								</div>
							</c:if>
							<%--迟到早退3--%>
							<c:if test="${fn:contains(statusValue,',082')||fn:contains(statusValue,',092') }">
								<div style="white-space: nowrap;">
									<bean:message bundle="sys-attend" key="sysAttendMain.fdWorkType.onwork"/>
									<bean:message bundle="sys-attend" key="sysAttendMain.fdStatus.late"/>
									<c:if test="${fn:contains(statusValue,',092') }">
									&nbsp
									<bean:message bundle="sys-attend" key="sysAttendStatMonth.fdOutside"/>
									</c:if>
								</div>
							</c:if>
							<%-- 外勤3--%>
							<c:if test="${ fn:contains(statusValue,',142')}">
								<div style="white-space: nowrap;color: #4285f4;">
									<bean:message bundle="sys-attend" key="sysAttendMain.fdWorkType.onwork"/>
									<bean:message bundle="sys-attend" key="sysAttendMain.outside"/>
								</div>
							</c:if>		
							<%--正常3--%>
							<c:if test="${fn:contains(statusValue,',213') }">
								<div style="color: #343434;">
									<bean:message bundle="sys-attend" key="sysAttendMain.fdWorkType.onwork"/>
									<bean:message bundle="sys-attend" key="sysAttendStatMonth.fdStatus"/>
								</div>
							</c:if>
							
							<%--缺卡4 --%>
							<c:if test="${ fn:contains(statusValue,',102')}">
								<div style="white-space: nowrap;">
									<bean:message bundle="sys-attend" key="sysAttendMain.fdWorkType.offwork"/>
									<bean:message bundle="sys-attend" key="sysAttendMain.fdStatus.unSign"/>
								</div>
							</c:if>
							<%--迟到早退4--%>	
							<c:if test="${fn:contains(statusValue,',112')||fn:contains(statusValue,',122') }">
								<div style="white-space: nowrap;">
									<bean:message bundle="sys-attend" key="sysAttendMain.fdWorkType.offwork"/>
									<bean:message bundle="sys-attend" key="sysAttendMain.fdStatus.left"/>
									<c:if test="${fn:contains(statusValue,',122') }">
									&nbsp
									<bean:message bundle="sys-attend" key="sysAttendStatMonth.fdOutside"/>
									</c:if>
								</div>
							</c:if>	
							<%-- 外勤4--%>			
							<c:if test="${fn:contains(statusValue,',152') }">
								<div style="white-space: nowrap;color: #4285f4;">
									<bean:message bundle="sys-attend" key="sysAttendMain.fdWorkType.offwork"/>
									<bean:message bundle="sys-attend" key="sysAttendMain.outside"/>
								</div>
							</c:if>	
							<%--正常4--%>
							<c:if test="${fn:contains(statusValue,',214') }">
								<div style="color: #343434;">
									<bean:message bundle="sys-attend" key="sysAttendMain.fdWorkType.offwork"/>
									<bean:message bundle="sys-attend" key="sysAttendStatMonth.fdStatus"/>
								</div>
							</c:if>
							
							
							<%-- 请假、出差、外出--%>
							<c:if test="${fn:contains(statusValue,',04') }">
								
									<c:if test="${not empty stat.offMap }">
									<c:forEach items="${stat.offMap.values() }" var="offValue" >
										<c:set var="fdOffTypeText" value="${offValue.fdOffTypeText}"></c:set>
										<c:set var="fdStatType" value="${offValue.fdStatType}"></c:set>
										<c:set var="fdNoonText" value="${offValue.fdNoonText}"></c:set>
										<c:set var="fdOffType" value="${offValue.fdOffType }"></c:set>
										<div style="white-space: nowrap;color: #4285f4;"><bean:message bundle="sys-attend" key="sysAttendMain.fdStatus.askforleave"/>
										<c:if test="${not empty fdOffTypeText}">
											(${fdOffTypeText})
										</c:if>
										<c:if test="${fdStatType=='2' and not empty fdNoonText}">
											(${fdNoonText})
										</c:if>
										 <c:if test="${not empty stat.fdOffTime}">
											<c:forEach items="${stat.fdOffTime }" var="offTime" >
												<c:if test="${fn:substringBefore(offTime.key,'_') eq fn:substringBefore(fdOffType,'_') }">
													(${offTime.value})
												</c:if>
											</c:forEach>
										</c:if>
										</div>
									</c:forEach>
									</c:if>
								
							</c:if>
							<c:if test="${ fn:contains(statusValue,',05')}">
								<div style="white-space: nowrap;color: #4285f4;"><bean:message bundle="sys-attend" key="sysAttendStatMonth.fdTrip"/>
								 <c:if test="${not empty stat.fdTripTime}">
										<c:forEach items="${stat.fdTripTime }" var="tripTime" >
													(${tripTime.value})
											</c:forEach>
								 </c:if>
								</div>
							</c:if>
							<c:if test="${fn:contains(statusValue,',06') }">
								<div style="white-space: nowrap;color: #4285f4;"><bean:message bundle="sys-attend" key="sysAttendStatMonth.fdOutgoing"/>
								    <c:if test="${not empty stat.fdOutgoingTime}">
										<c:forEach items="${stat.fdOutgoingTime }" var="outTime" >
													(${outTime})
											</c:forEach>
									</c:if>
								</div>
							</c:if>
							</a>
							
							<%--非全天旷工 --%>
							<c:if test="${fn:contains(statusValue,',03') }">
								<a href="javascript:void(0)" class="lui_stat_status_red" style="cursor: auto;">
									<bean:message bundle="sys-attend" key="sysAttendStatMonth.fdAbsent"/>
								</a>
							</c:if>
							
							</c:if>
							<%-- 加班 --%>
							<c:if test="${fn:contains(statusValue,',13') }">
								<div style="white-space: nowrap;color:#4285f4;font-weight: 600;">
								<a href="${statusUrl}" target="_blank" class="lui_stat_status_normal">
									<bean:message bundle="sys-attend" key="sysAttendMain.fdStatus.overtime"/>
								</a>
								</div>
							</c:if>
						</c:otherwise>
					</c:choose>
				</list:data-column>
			</c:forEach>
		</c:if>
		
	</list:data-columns>
	
	<list:data-paging page="${queryPage}" />
</list:data>