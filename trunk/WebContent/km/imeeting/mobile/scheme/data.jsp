<%@ page language="java" contentType="text/json; charset=UTF-8"  pageEncoding="UTF-8"%>
<%@ include file="/sys/ui/jsp/common.jsp"%>
<%@page import="com.landray.kmss.km.imeeting.model.KmImeetingScheme"%>
<list:data>
	<list:data-columns var="KmImeetingScheme" list="${queryPage.list }">
		<%--ID--%> 
		<list:data-column property="fdId"></list:data-column>
		
		<%--方案名称--%>
		<list:data-column col="fdName" title="方案名称"  escape="false">
			<c:out value="${KmImeetingScheme.docSubject}" />
		</list:data-column>
		
		<%-- 主题--%>	
		<list:data-column col="label" title="标题" escape="false">
		  <c:out value="${KmImeetingScheme.docSubject}"/>
		</list:data-column>
		
		<list:data-column col="created" escape="false" title="创建时间">
			<kmss:showDate value="${KmImeetingScheme.docCreateTime}" type="datetime"></kmss:showDate>
		</list:data-column>
		
		<list:data-column col="creator" title="创建人">
			<c:out value="${KmImeetingScheme.docCreator.fdName}"></c:out>
      	</list:data-column>
		
		<%-- 发布时间--%>
      	<list:data-column col="docPublishTime" title="发布时间">
	        <kmss:showDate value="${KmImeetingScheme.docPublishTime}" type="datetime"></kmss:showDate>
      	</list:data-column>
      	
		<%-- 召开时间~结束时间 --%>
		<list:data-column col="fdHostTime" escape="false">
			<c:if test="${not empty  KmImeetingScheme.fdBeginDate or not empty KmImeetingScheme.fdEndDate}">
				<kmss:showDate value="${KmImeetingScheme.fdBeginDate}" type="datetime"></kmss:showDate>
			 	~
			 	<kmss:showDate value="${KmImeetingScheme.fdEndDate}" type="datetime"></kmss:showDate>
			</c:if>
		</list:data-column>
		
		<%-- 当前节点--%>
	 	<list:data-column col="summary" title="当前节点" escape="false">
	        <kmss:showWfPropertyValues idValue="${KmImeetingScheme.fdId}" propertyName="summary" />
      	</list:data-column>
		
		<%--主持人--%>
		<list:data-column  headerClass="creator" col="fdHost" title="主持人" escape="false">
			<c:out value="${KmImeetingScheme.fdHost.fdName}" />
		</list:data-column>
		
		<list:data-column col="href" escape="false">
			/km/imeeting/km_imeeting_scheme/kmImeetingScheme.do?method=view&fdId=${KmImeetingScheme.fdId}
		</list:data-column>
		
	</list:data-columns>
	<list:data-paging currentPage="${queryPage.pageno }"
		pageSize="${queryPage.rowsize }" totalSize="${queryPage.totalrows }">
	</list:data-paging>
</list:data>