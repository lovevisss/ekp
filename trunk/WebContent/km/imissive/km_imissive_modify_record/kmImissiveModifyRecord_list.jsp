<%@ page language="java" contentType="text/json; charset=UTF-8"
   pageEncoding="UTF-8"%>
<%@ include file="/sys/ui/jsp/common.jsp"%>
<list:data>
	<list:data-columns var="kmImissiveModifyRecord" list="${queryPage.list}">
		<list:data-column style="text-align:left;min-width:200px"  property="docContent" title="${ lfn:message('km-imissive:kmImissiveModifyRecord.docContent') }">
		</list:data-column>
		<list:data-column headerClass="width160"  col="docCreateTime" title="${ lfn:message('km-imissive:kmImissiveModifyRecord.docCreateTime') }">
		    <kmss:showDate value="${kmImissiveModifyRecord.docCreateTime}" type="datetime" />
		</list:data-column>
		<list:data-column headerClass="width160" col="docCreator.fdName" title="${ lfn:message('km-imissive:kmImissiveModifyRecord.docCreator') }" escape="false">
			    <ui:person personId="${kmImissiveModifyRecord.docCreator.fdId}" personName="${kmImissiveModifyRecord.docCreator.fdName}"></ui:person> 
	    </list:data-column>
	</list:data-columns>
		<list:data-paging currentPage="${queryPage.pageno }"
		pageSize="${queryPage.rowsize }" totalSize="${queryPage.totalrows }">
	</list:data-paging>
</list:data>