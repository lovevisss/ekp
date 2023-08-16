<%@ page language="java" contentType="text/json; charset=UTF-8"	pageEncoding="UTF-8"%>
<%@ include file="/sys/ui/jsp/common.jsp"%>
<%@ taglib uri="/WEB-INF/KmssConfig/sys/person/person.tld" prefix="person"%>
<list:data>
	<list:data-columns var="kmImeetingTopic" list="${queryPage.list }" varIndex="status" mobile="true">
		<list:data-column property="fdId">
		</list:data-column >
	    <%-- 主题--%>	
		<list:data-column col="label" title="标题" escape="false">
		    	<div class="muiMeetingItemDSubjectRight"><c:out value="${kmImeetingTopic.docSubject}"/></div>
		</list:data-column>
		
		<%-- 发布时间--%>
      	<list:data-column col="docPublishTime" title="发布时间">
	        <kmss:showDate value="${kmImeetingTopic.docPublishTime}" type="datetime"></kmss:showDate>
      	</list:data-column>
      	
      	<list:data-column col="created" title="创建时间">
	        <kmss:showDate value="${kmImeetingTopic.docCreateTime}" type="datetime"></kmss:showDate>
      	</list:data-column>
      	
      	<list:data-column col="listIcon" escape="false">
			muis-official-doc
		</list:data-column>
		
		<list:data-column col="creator" title="创建人">
			<c:out value="${kmImeetingTopic.docCreator.fdName}"></c:out>
      	</list:data-column>
		
		<%--链接--%>
		<list:data-column col="href" escape="false">
		    /km/imeeting/km_imeeting_topic/kmImeetingTopic.do?method=view&fdId=${kmImeetingTopic.fdId}
		</list:data-column>
		
		<%-- 当前节点--%>
	 	<list:data-column col="summary" title="当前节点" escape="false">
	        <kmss:showWfPropertyValues idValue="${kmImeetingTopic.fdId}" propertyName="summary" />
      	</list:data-column>
		
	</list:data-columns>
	<list:data-paging currentPage="${queryPage.pageno }"
		pageSize="${queryPage.rowsize }" totalSize="${queryPage.totalrows }">
	</list:data-paging>
</list:data>