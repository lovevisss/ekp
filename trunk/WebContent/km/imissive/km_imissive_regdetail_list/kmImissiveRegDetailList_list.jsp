<%@ page language="java" contentType="text/json; charset=UTF-8"
   pageEncoding="UTF-8"%>
<%@ include file="/sys/ui/jsp/common.jsp"%>
<list:data>
	<list:data-columns var="kmImissiveRegDetailList" list="${queryPage.list }">
		<%--ID--%> 
		<list:data-column property="fdId"></list:data-column>
		<%--名称--%>
		<list:data-column col="kmImissiveRegDetailList.fdReg.fdName" title="${ lfn:message('km-imissive:kmImissiveReg.fdName')}" escape="false" style="text-align:left;min-width:150px">
			<span class="com_subject"><c:out value="${kmImissiveRegDetailList.fdReg.fdName}" /></span>
		</list:data-column>
		<list:data-column headerClass="width120" col="kmImissiveRegDetailList.fdReg.fdDeliverType" title="${ lfn:message('km-imissive:kmImissiveReg.from')}" escape="false">
			 <c:choose>
			    <c:when test="${kmImissiveRegDetailList.fdReg.fdRegType eq '2' }">
			    	${ lfn:message('km-imissive:kmImissiveReg.fdRegType.receive')}
			    </c:when>
			    <c:otherwise>
			    	${ lfn:message('km-imissive:kmImissiveReg.fdRegType.send')}
			    </c:otherwise>
		    </c:choose>
		    <sunbor:enumsShow value="${kmImissiveRegDetailList.fdReg.fdDeliverType}" enumsType="kmImissiveRegDetailList_type" bundle="km-imissive" />
		    <sunbor:enumsShow value="${kmImissiveRegDetailList.fdType}" enumsType="kmImissiveRegDetailList_unittype" bundle="km-imissive" />
		</list:data-column>
		<list:data-column headerClass="width120" col="fdFromUnit" title="${ lfn:message('km-imissive:kmImissiveReg.fdSendUnit')}"  escape="false">
			<c:choose>
				<c:when test="${kmImissiveRegDetailList.fdReg.fdRegType eq '2'}">
					<c:out value="${kmImissiveRegDetailList.fdReg.fdReceiveMain.fdReceiveUnit.fdName}" />
				</c:when>
				<c:otherwise>
					<c:out value="${kmImissiveRegDetailList.fdReg.fdSendMain.fdSendtoUnit.fdName}" />
				</c:otherwise>
			</c:choose>
		</list:data-column>
		<list:data-column headerClass="width120"  property="fdUnit.fdName" title="${ lfn:message('km-imissive:kmImissiveReg.fdUnit')}">
		</list:data-column>
		<list:data-column headerClass="width120"  col="docCreateTime" title="${ lfn:message('km-imissive:kmImissiveReg.docCreateTime')}">
		    <kmss:showDate value="${kmImissiveRegDetailList.docCreateTime}" type="date" />
		</list:data-column>
		<list:data-column headerClass="width80" col="fdOrgNames" title="${ lfn:message('km-imissive:kmImissiveReg.fdOrgNames')}" escape="false">
		     <c:forEach items="${kmImissiveRegDetailList.fdOrg}" var="fdOrg" varStatus="vstatus">
					<ui:person personId="${fdOrg.fdId}" personName="${fdOrg.fdName}"></ui:person>
			 </c:forEach>
	    </list:data-column>
	    <list:data-column headerClass="width80"  col="fdStatus" title="${ lfn:message('km-imissive:kmImissiveReg.fdStatus')}" escape="false">
	         <sunbor:enumsShow value="${kmImissiveRegDetailList.fdStatus}" enumsType="kmImissiveReg_status" bundle="km-imissive" />
		</list:data-column>
		<list:data-column headerClass="width80" col="nodeName" title="${ lfn:message('km-imissive:sysWfNode.processingNode.currentProcess') }" escape="false">
			<c:if test="${kmImissiveRegDetailList.fdUnit.fdNature != 2}">
				<kmss:showWfPropertyValues idValue="${json[kmImissiveRegDetailList.fdId]}" propertyName="nodeName" />
			</c:if>
		</list:data-column>
		<list:data-column headerClass="width80" col="handlerName" title="${ lfn:message('km-imissive:sysWfNode.processingNode.currentProcessor') }" escape="false">
		    <c:if test="${kmImissiveRegDetailList.fdUnit.fdNature != 2}">
		    	<kmss:showWfPropertyValues idValue="${json[kmImissiveRegDetailList.fdId]}" propertyName="handlerName" />
			</c:if>
		</list:data-column>
	</list:data-columns>
	<list:data-paging currentPage="${queryPage.pageno }"
		pageSize="${queryPage.rowsize }" totalSize="${queryPage.totalrows }">
	</list:data-paging>
</list:data>