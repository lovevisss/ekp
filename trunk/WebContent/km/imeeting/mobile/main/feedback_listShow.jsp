<%@ page language="java" contentType="text/json; charset=UTF-8"	pageEncoding="UTF-8"%>
<%@ include file="/sys/ui/jsp/common.jsp"%>
<%@ taglib uri="/WEB-INF/KmssConfig/sys/person/person.tld" prefix="person"%>
<list:data>
	<list:data-columns var="kmImeetingMainFeedback" list="${queryPage.list }" varIndex="status" mobile="true">
		<list:data-column property="fdId">
		</list:data-column >
		
		 <%-- 创建者--%>
		<list:data-column col="creator" title="${ lfn:message('km-imeeting:kmImeetingMainFeedback.docCreator') }" escape="false">
			<c:out value="${kmImeetingMainFeedback.docCreator.fdName}"/>
		</list:data-column>
		
		 <%-- 创建者部门--%>
		<list:data-column col="creatorParent" title="所属部门" escape="false">
			<c:out value="${kmImeetingMainFeedback.docCreator.fdParent.fdName}"/>
		</list:data-column>
		
		 <%-- 创建者头像--%>
		<list:data-column col="icon" escape="false">
			    <person:headimageUrl personId="${kmImeetingMainFeedback.docCreator.fdId}" size="m" />
		</list:data-column>
		
		<%-- 回执留言--%>
		<list:data-column col="fdReason" title="${ lfn:message('km-imeeting:kmImeetingMainFeedback.fdReason') }" escape="false">
			<c:out value="${kmImeetingMainFeedback.fdReason}"/>
		</list:data-column>
		
		<%-- 回执类型--%>
		<list:data-column col="opt" title="${ lfn:message('km-imeeting:kmImeetingMainFeedback.fdOperateType') }" escape="false">
			<c:out value="${kmImeetingMainFeedback.fdOperateType }"></c:out>
		</list:data-column>
		
	</list:data-columns>
	
	<list:data-paging currentPage="${queryPage.pageno }"
		pageSize="${queryPage.rowsize }" totalSize="${queryPage.totalrows }">
	</list:data-paging>
</list:data>