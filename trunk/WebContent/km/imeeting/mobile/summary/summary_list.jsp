<%@ page language="java" contentType="text/json; charset=UTF-8"	pageEncoding="UTF-8"%>
<%@ include file="/sys/ui/jsp/common.jsp"%>
<%@ taglib uri="/WEB-INF/KmssConfig/sys/person/person.tld" prefix="person"%>
<%@page import="com.landray.kmss.util.ModelUtil"%>
<%@page import="com.landray.kmss.util.StringUtil"%>
<%@page import="java.util.ArrayList"%>
<%@page import="com.landray.kmss.km.imeeting.model.KmImeetingRes"%>
<%@page import="java.util.List"%>
<%@page import="com.landray.kmss.km.imeeting.model.KmImeetingSummary"%>
<list:data>
	<list:data-columns var="kmImeetingSummary" list="${queryPage.list }" varIndex="status" mobile="true">
		<list:data-column property="fdId">
		</list:data-column >
	    <%-- 主题--%>	
		<list:data-column col="label" title="${ lfn:message('km-imeeting:kmImeetingMain.fdName') }" escape="false">
		         <c:out value="${kmImeetingSummary.fdName}"/>
		</list:data-column>
		
		<list:data-column col="created" title="录入时间">
	        <kmss:showDate value="${kmImeetingSummary.docCreateTime}" type="datetime"></kmss:showDate>
      	</list:data-column>
		
		<list:data-column col="creator" title="录入人">
			<c:out value="${kmImeetingSummary.docCreator.fdName}"></c:out>
      	</list:data-column>
		
		 <%-- 纪要人--%>
		<list:data-column col="host" title="${ lfn:message('km-imeeting:kmImeetingMain.docCreator') }" escape="false">
			<c:if test="${not empty kmImeetingSummary.docCreator}">
				<c:out value="${kmImeetingSummary.docCreator.fdName}"/>
			</c:if>
			<c:if test="${empty kmImeetingSummary.docCreator }">
				<c:out value=""/>
			</c:if>
		</list:data-column>
		
		<list:data-column col="listIcon" escape="false">
			muis-official-doc
		</list:data-column>
		
		<%-- 当前节点--%>
	 	<list:data-column col="summary" title="当前节点" escape="false">
	        <kmss:showWfPropertyValues idValue="${kmImeetingSummary.fdId}" propertyName="summary" />
      	</list:data-column>
		
		<%--链接--%>
		<list:data-column col="href" escape="false">
			/km/imeeting/km_imeeting_summary/kmImeetingSummary.do?method=view&fdId=${kmImeetingSummary.fdId}
		</list:data-column>
		
		<%-- 文档状态 --%>
        <%-- <list:data-column col="docStatus" title="${lfn:message('km-supervise:kmImeetingSummary.docStatus')}">
			<c:choose>
				<c:when test="${kmImeetingSummary.docStatus=='10' }">
					<bean:message key="status.draft"></bean:message>
				</c:when>
				<c:when test="${kmImeetingSummary.docStatus=='20' }">
					<bean:message key="kmImeeting.status.append" bundle="km-imeeting"/>
				</c:when>
				<c:when test="${kmImeetingSummary.docStatus=='11' }">
					<bean:message key="status.refuse"></bean:message>
				</c:when>
				<c:when test="${kmImeetingSummary.docStatus=='30' || kmImeetingSummary.docStatus=='40' }">
					<bean:message key="status.publish"></bean:message>
				</c:when>
				<c:when test="${kmImeetingSummary.docStatus=='00' }">
					<bean:message key="status.discard"></bean:message>
				</c:when>
			</c:choose>
		</list:data-column>
		<list:data-column col="docStatusNew" title="${lfn:message('km-supervise:kmImeetingSummary.docStatus')}">
			<c:out value="${kmImeetingSummary.docStatus}"/>
		</list:data-column> --%>
	</list:data-columns>
	
	<list:data-paging currentPage="${queryPage.pageno }"
		pageSize="${queryPage.rowsize }" totalSize="${queryPage.totalrows }">
	</list:data-paging>
</list:data>