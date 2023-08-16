<%@ page language="java" contentType="text/json; charset=UTF-8"	pageEncoding="UTF-8"%>
<%@ include file="/sys/ui/jsp/common.jsp"%>
<list:data>
	<list:data-columns var="record" list="${data}" varIndex="status">
		<list:data-column col="index">
				${status+1}
		</list:data-column>
		<c:forEach items="${table.columns}" var="column" >
			<list:data-column col="${column.key}" escape="false">
				${record[column.key]}
			</list:data-column>
		</c:forEach>
		
	</list:data-columns>
	
	<list:data-paging page="${page}"/>
</list:data>
