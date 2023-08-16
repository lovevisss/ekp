<%@ page language="java" contentType="text/json; charset=UTF-8"  pageEncoding="UTF-8"%>
<%@ include file="/sys/ui/jsp/common.jsp"%>
<list:data>
	<list:data-columns var="kmImissiveData" list="${queryPage.list }">
		<list:data-column col="_fdId">
			<c:out value="${kmImissiveData.fdId}"/>
		</list:data-column>
		<list:data-column col="fdId">
			<c:out value="${kmImissiveData.fdId}_${kmImissiveData.fdType}"/>
		</list:data-column>
		<list:data-column col="docSubject" escape="false" title="标题" style="text-align:left;min-width:150px">
		      <span class="com_subject"><c:out value="${kmImissiveData.docSubject}"/></span>
		</list:data-column>
		<list:data-column headerClass="width160"  property="fdDocNum" title="字号">
			<c:out value="${kmImissiveData.fdDocNum}"/>
		</list:data-column>
		<list:data-column headerClass="width80"  col="fdType" title="类型">
			<sunbor:enumsShow value="${kmImissiveData.fdType}" enumsType="kmImissive_mainType" />
		</list:data-column>
		<list:data-column headerClass="width80"  col="_fdType" title="类型">
			<c:out value="${kmImissiveData.fdType}"/>
		</list:data-column>
		<list:data-column headerClass="width100"  property="fdDrafter" title="拟稿人">
			<c:out value="${kmImissiveData.fdDrafter}"/>
		</list:data-column>
		<list:data-column headerClass="width100"  col="fdDraftTime" title="拟稿日期">
		    <kmss:showDate value="${kmImissiveData.fdDraftTime}" type="date" />
		</list:data-column>
		<list:data-column headerClass="width80"  col="fdEmergency" title="紧急程度">
			<c:out value="${kmImissiveData.fdEmergency}"/>
		</list:data-column>
		<list:data-column headerClass="width80"  col="fdSecret" title="密级程度">
		    <c:out value="${kmImissiveData.fdSecret}"/>
		</list:data-column>
		<!-- 当前环节和当前处理人-->	
		<list:data-column headerClass="width80" col="nodeName" title="${ lfn:message('km-imissive:sysWfNode.processingNode.currentProcess') }" escape="false">
			<kmss:showWfPropertyValues var="nodevalue" idValue="${kmImissiveData.fdId}" propertyName="nodeName" />
				<div class="textEllipsis width100" title="${nodevalue}">
			        <c:out value="${nodevalue}"></c:out>
			    </div>
		</list:data-column>
		<list:data-column headerClass="width80" col="handlerName" title="${ lfn:message('km-imissive:sysWfNode.processingNode.currentProcessor') }" escape="false">
		    <kmss:showWfPropertyValues var="handlerValue" idValue="${kmImissiveData.fdId}" propertyName="handlerName" />
		    	<div class="textEllipsis width80" style="font-weight:bold;" title="${handlerValue}">
			        <c:out value="${handlerValue}"></c:out>
			    </div>
		</list:data-column>
	</list:data-columns>
	<list:data-paging currentPage="${queryPage.pageno }" pageSize="${queryPage.rowsize }" totalSize="${queryPage.totalrows }">
	</list:data-paging>
</list:data>