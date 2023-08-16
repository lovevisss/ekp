<%@ page language="java" contentType="text/json; charset=UTF-8"  pageEncoding="UTF-8"%>
<%@ include file="/sys/ui/jsp/common.jsp"%>
<list:data>
	<list:data-columns var="kmImeetingAgenda" list="${queryPage.list }">
	
		<%--ID--%> 
		<list:data-column property="fdId"></list:data-column>
		
		<%-- 主题--%>	
		<list:data-column col="docSubject" title="标题" escape="false">
			<c:out value="${kmImeetingAgenda.docSubject}"/>
		</list:data-column>
		
		<%-- 汇报人 --%>
		<list:data-column col="docReporter" title="汇报人"  escape="false">
			<c:out value="${kmImeetingAgenda.docReporter.fdName}" />
		</list:data-column>
		
		<%-- 创建人 --%>
		<list:data-column col="docRespons" title="材料负责人">
			<c:out value="${kmImeetingAgenda.docRespons.fdName}"></c:out>
      	</list:data-column>
		
	</list:data-columns>
	
	<list:data-paging currentPage="${queryPage.pageno }"
		pageSize="${queryPage.rowsize }" totalSize="${queryPage.totalrows }">
	</list:data-paging>
</list:data>