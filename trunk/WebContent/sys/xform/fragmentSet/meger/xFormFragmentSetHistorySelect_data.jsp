<%@ page language="java" contentType="text/json; charset=UTF-8"	pageEncoding="UTF-8"%> 
<%@ include file="/sys/ui/jsp/common.jsp"%>
<list:data>
	<list:data-columns var="sysFormFragmentSet" list="${queryPage.list}">
		<list:data-column property="fdId" title="ID">
		</list:data-column>
		<list:data-column property="fdName" title="${ lfn:message('sys-xform-fragmentSet:sysFormFragmentSet.fdName') }">
		</list:data-column>
		<list:data-column col="fdTemplateEdition" title="${ lfn:message('sys-xform-fragmentSet:sysFormFragmentSet.fdFragmentSetEdition') }">
			v<c:out value="${sysFormFragmentSet.fdTemplateEdition }"></c:out>
		</list:data-column>
	</list:data-columns>
	
	<list:data-paging page="${ queryPage }"></list:data-paging>
</list:data>