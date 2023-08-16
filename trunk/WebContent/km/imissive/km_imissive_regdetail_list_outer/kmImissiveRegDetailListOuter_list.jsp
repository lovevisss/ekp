<%@ page language="java" contentType="text/json; charset=UTF-8"
   pageEncoding="UTF-8"%>
<%@ include file="/sys/ui/jsp/common.jsp"%>
<list:data>
	<list:data-columns var="kmImissiveRegDetailListOuter" list="${queryPage.list }">
		<%--ID--%> 
		<list:data-column property="fdId"></list:data-column>
		<%--名称--%>
		<list:data-column col="fdRegName" title="${ lfn:message('km-imissive:kmImissiveReg.fdName')}" escape="false" style="text-align:left;min-width:150px">
			<span class="com_subject"><c:out value="${kmImissiveRegDetailListOuter.fdRegName}" /></span>
		</list:data-column>
		<list:data-column headerClass="width120" col="kmImissiveRegDetailListOuter.fdRegDeliverType" title="${ lfn:message('km-imissive:kmImissiveReg.from')}">
			 <c:choose>
			    <c:when test="${kmImissiveRegDetailListOuter.fdRegType eq '2' }">
			    	${ lfn:message('km-imissive:kmImissiveReg.fdRegType.receive')}
			    </c:when>
			    <c:otherwise>
			    	${ lfn:message('km-imissive:kmImissiveReg.fdRegType.send')}
			    </c:otherwise>
		    </c:choose>
		    <sunbor:enumsShow value="${kmImissiveRegDetailListOuter.fdRegDeliverType}" enumsType="kmImissiveRegDetailList_type" bundle="km-imissive" />
		    <sunbor:enumsShow value="${kmImissiveRegDetailListOuter.fdType}" enumsType="kmImissiveRegDetailList_unittype" bundle="km-imissive" />
		</list:data-column>
		<list:data-column headerClass="width120" col="fdFromUnit" title="${ lfn:message('km-imissive:kmImissiveReg.fdSendUnit')}"  escape="false">
				<c:out value="${kmImissiveRegDetailListOuter.fdFromUnit.fdName}" />
		</list:data-column>
		<list:data-column headerClass="width120"  property="fdUnit.fdName" title="${ lfn:message('km-imissive:kmImissiveReg.fdUnit')}">
		</list:data-column>
		<list:data-column headerClass="width120"  col="docCreateTime" title="${ lfn:message('km-imissive:kmImissiveReg.docCreateTime')}">
		    <kmss:showDate value="${kmImissiveRegDetailListOuter.docCreateTime}" type="date" />
		</list:data-column>
		<list:data-column headerClass="width80" col="fdOrgNames" title="${ lfn:message('km-imissive:kmImissiveReg.fdOrgNames')}" escape="false">
		     <c:forEach items="${kmImissiveRegDetailListOuter.fdOrg}" var="fdOrg" varStatus="vstatus">
					<ui:person personId="${fdOrg.fdId}" personName="${fdOrg.fdName}"></ui:person>
			 </c:forEach>
	    </list:data-column>
	    <list:data-column headerClass="width80"  col="fdStatus" title="${ lfn:message('km-imissive:kmImissiveReg.fdStatus')}" escape="false">
	         <sunbor:enumsShow value="${kmImissiveRegDetailListOuter.fdStatus}" enumsType="kmImissiveReg_status" bundle="km-imissive" />
		</list:data-column>
	</list:data-columns>
	<list:data-paging currentPage="${queryPage.pageno }"
		pageSize="${queryPage.rowsize }" totalSize="${queryPage.totalrows }">
	</list:data-paging>
</list:data>