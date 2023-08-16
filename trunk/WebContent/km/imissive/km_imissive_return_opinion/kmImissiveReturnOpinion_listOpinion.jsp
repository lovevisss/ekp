<%@ page language="java" contentType="text/json; charset=UTF-8"
   pageEncoding="UTF-8"%>
<%@ include file="/sys/ui/jsp/common.jsp"%>
<list:data>
	<list:data-columns var="kmImissiveReturnOpinion" list="${queryList }">
		<list:data-column property="fdId">
		</list:data-column>
		<list:data-column headerClass="width160"  property="fdUnit.fdName" title="单位">
		</list:data-column>
		<list:data-column style="text-align:left;min-width:200px"  property="docContent" title="意见">
		</list:data-column>
		<list:data-column headerClass="width160"  col="docCreateTime" title="操作时间">
		    <kmss:showDate value="${kmImissiveReturnOpinion.docCreateTime}" type="date" />
		</list:data-column>
	</list:data-columns>
</list:data>