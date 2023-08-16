<%@ page language="java" contentType="text/json; charset=UTF-8"  pageEncoding="UTF-8"%>
<%@ include file="/sys/ui/jsp/common.jsp"%>
<%@page import="com.landray.kmss.km.imeeting.model.KmImeetingScheme"%>
<list:data>
	<list:data-columns var="KmImeetingScheme" list="${queryPage.list }">
		<%--ID--%> 
		<list:data-column property="fdId"></list:data-column>
		<%--方案编号--%>
		<list:data-column  headerClass="width200" col="docNumber" title="方案编号"  escape="false">
			<span class="com_subject"><c:out value="${KmImeetingScheme.docNumber}" /></span>
		</list:data-column>
		<%--方案类型--%>
		<list:data-column  headerClass="width200" col="fdType" title="方案类型"  escape="false">
			<span class="com_subject"><c:out value="${KmImeetingScheme.fdType}" /></span>
		</list:data-column>
		<%--方案名称--%>
		<list:data-column  headerClass="width200" col="docSubject" title="方案名称"  escape="false">
			<span class="com_subject"><c:out value="${KmImeetingScheme.docSubject}" /></span>
		</list:data-column>
		<%-- 召开时间~结束时间 --%>
		<list:data-column col="created" escape="false">
			<c:if test="${not empty  KmImeetingScheme.fdBeginDate or not empty KmImeetingScheme.fdEndDate}">
				<kmss:showDate value="${KmImeetingScheme.fdBeginDate}" type="datetime"></kmss:showDate>
			 	~
			 	<kmss:showDate value="${KmImeetingScheme.fdEndDate}" type="datetime"></kmss:showDate>
			</c:if>
		</list:data-column>
		<%--主持人--%>
		<list:data-column  headerClass="width200" col="fdHost" title="主持人" escape="false">
			<span class="com_subject"><c:out value="${KmImeetingScheme.fdHost.fdName}" /></span>
		</list:data-column>
		<%--方案开始时间--%>
		<list:data-column  headerClass="width200" col="fdBeginDate" title="方案开始时间" escape="false">
			<span class="com_subject"><kmss:showDate value="${KmImeetingScheme.fdBeginDate}" type="datetime"></kmss:showDate></span>
		</list:data-column>
		<%--方案结束时间--%>
		<list:data-column  headerClass="width200" col="fdEndDate" title="方案结束时间" escape="false">
			<span class="com_subject"><kmss:showDate value="${KmImeetingScheme.fdEndDate}" type="datetime"></kmss:showDate></span>
		</list:data-column>
		<%--方案地点--%>
		<list:data-column  headerClass="width200" col="fdSchemePlace" title="方案地点" escape="false">
			<span class="com_subject"><c:out value="${KmImeetingScheme.fdSchemePlace}" /></span>
		</list:data-column>
		<list:data-column col="href" escape="false">
			/km/imeeting/km_imeeting_scheme/kmImeetingScheme.do?method=view&fdId=${KmImeetingScheme.fdId}
		</list:data-column>
	</list:data-columns>
	<list:data-paging currentPage="${queryPage.pageno }"
		pageSize="${queryPage.rowsize }" totalSize="${queryPage.totalrows }">
	</list:data-paging>
</list:data>