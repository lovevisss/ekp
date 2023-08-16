<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="/WEB-INF/kmss-bean.tld" prefix="bean"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="/WEB-INF/kmss-xform.tld" prefix="xform"%>
<%@ taglib uri="/WEB-INF/KmssConfig/sys/person/person.tld" prefix="person"%>
<c:set var="__kmImeetingMainForm" value="${requestScope[param.formBeanName]}" />
<div class="muiImeetingInfoNewBanner">

	<div class="muiImeetingInfoMask"></div>

	<div class="muiImeetingInfoCard">
		
		<div class="muiImeetingInfoHeaderBox">
			<!-- 会议名称 -->
			<div class="muiImeetingInfoTitle">
				<xform:text property="fdName"></xform:text>
			</div>
			<!-- 主持人 -->
			<div class="muiImeetingHostBox">
				<div class="muiImeetingInfoHost">
					<div class="avatar" onclick="window.dialPhone('${__kmImeetingMainForm.fdHostMobileNo}');">
						<img src="<person:headimageUrl contextPath="true"  personId="${__kmImeetingMainForm.fdHostId}" size="xm" />" alt="" />
						<!-- <i class="mui mui-tel"></i> -->
					</div>
					<div class="name">
						<xform:text property="fdHostName"></xform:text>
					</div>
				</div>
			</div>
			<!-- 会议状态 -->
			<div class="muiImeetingMStatus">
				<c:import url="/km/imeeting/mobile/import/meetingStatus_view.jsp"  charEncoding="UTF-8">
					<c:param name="status" value="${__kmImeetingMainForm.docStatus }"></c:param>
					<c:param name="isBegin" value="${isBegin }"></c:param>
					<c:param name="isEnd" value="${isEnd }"></c:param>
				</c:import>
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
								<xform:datetime property="fdHoldDate" dateTimeType="datetime"></xform:datetime>
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
								<xform:datetime property="fdFinishDate" dateTimeType="datetime"></xform:datetime>
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
						<c:when test="${not empty __kmImeetingMainForm.fdVicePlaceNames or not empty __kmImeetingMainForm.fdOtherVicePlace }">
							<div class="kmImeetingHeaderPlace">
								<xform:text property="fdPlaceName"></xform:text>
								<c:if test="${not empty __kmImeetingMainForm.fdOtherPlace}">
									<xform:text property="fdOtherPlace"></xform:text>
								</c:if>
							</div>
							<div class="kmImeetingHeaderPlace">
								<xform:text property="fdVicePlaceNames"></xform:text>
								<xform:text property="fdOtherVicePlace"></xform:text>
							</div>
						</c:when>
						<c:otherwise>
							<c:if test="${not empty __kmImeetingMainForm.fdPlaceName or not empty __kmImeetingMainForm.fdOtherPlace }">
								<div class="kmImeetingHeaderPlace">
									<xform:text property="fdPlaceName"></xform:text>
									<c:if test="${not empty __kmImeetingMainForm.fdOtherPlace}">
										<xform:text property="fdOtherPlace"></xform:text>
									</c:if>	
								</div>
							</c:if>
						</c:otherwise>
					</c:choose>
				</td>
			</tr>
			<tr>
				<td class="bannerTile">
					参会人数
				</td>
				<td class="attendCountsTd">
					<span name="attendCounts" class="">-</span><bean:message key="mobile.info.person" bundle="km-imeeting"/>（预计）
				</td>
			</tr>
		</table>
		
		<!-- 重复规则-->
		<%-- <c:if test="${ not empty __kmImeetingMainForm.fdRecurrenceStr}">
			<div class="muiImeetingInfoItem" style="display: flex;">
				<span><bean:message bundle="km-imeeting" key="mobile.info.repeat"/>：</span>
				<span>
					<c:out value="${__kmImeetingMainForm.fdRepeatFrequency }"></c:out>
					<c:out value="${__kmImeetingMainForm.fdRepeatTime }">
					</c:out><c:out value="${__kmImeetingMainForm.fdRepeatUtil }"></c:out>
				</span>
			</div>
		</c:if> --%>
		
		<%-- 坐席安排座位号 --%>
		<%-- <c:if test="${not empty seatNumbers}">
			<div class="muiImeetingInfoItem">
				<bean:message bundle="km-imeeting" key="mobile.info.seat.number"/>：
				<c:forEach items="${seatNumbers }" var="seatNumber" varStatus="varStatus">
					<c:choose>
						<c:when test="${varStatus.index == 0}">
							<span title="${seatNumber}">
							<c:if test="${fn:length(seatNumber)>16}">
							<c:out value="${fn:substring(seatNumber,0,6)}"/><c:out value="..."/><c:out value="${fn:substring(seatNumber,fn:length(seatNumber)-10,fn:length(seatNumber))}"/>
							</c:if>
							<c:if test="${fn:length(seatNumber)<=16}">
								<c:out value="${seatNumber}"/>
							</c:if>
							<br/></span>
						</c:when>
						<c:otherwise>
							<span title="${seatNumber}" style="margin-left: 56px;">
							<c:if test="${fn:length(seatNumber)>16}">
							<c:out value="${fn:substring(seatNumber,0,6)}"/><c:out value="..."/><c:out value="${fn:substring(seatNumber,fn:length(seatNumber)-10,fn:length(seatNumber))}"/>
							</c:if>
							<c:if test="${fn:length(seatNumber)<=16}">
								<c:out value="${seatNumber}"/>
							</c:if>
							<br/>
							</span>
						</c:otherwise>
					</c:choose>
				</c:forEach>
			</div>
		</c:if> --%>
	</div>

</div>
<c:if test="${not empty param.loading and param.loading == 'true' }">
	<div style="height: 100%;padding-top: 10rem;">
		<%@ include file="/sys/mobile/extend/combin/loading.jsp"%>
	</div>
</c:if>