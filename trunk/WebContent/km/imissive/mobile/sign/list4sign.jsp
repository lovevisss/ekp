<%@ page language="java" contentType="text/json; charset=UTF-8"	pageEncoding="UTF-8"%>
<%@ include file="/sys/ui/jsp/common.jsp"%>
<%@ taglib uri="/WEB-INF/KmssConfig/sys/person/person.tld" prefix="person"%>
<list:data>
	<list:data-columns var="kmImissiveSignMain" list="${queryPage.list }" varIndex="status" mobile="true">
		<list:data-column property="fdId">
		</list:data-column >
		 <%-- 主题--%>	
		<list:data-column col="label" title="标题" escape="false">
		 <c:if test="${not empty kmImissiveSignMain.fdEmergencyGrade.fdColor}">
				<div class="muiMissiveItemDSubjectLeft" style="border:1px solid ${kmImissiveSignMain.fdEmergencyGrade.fdColor};color:${kmImissiveSignMain.fdEmergencyGrade.fdColor};">
					<span class="muiFontSizeS"><c:out value="${kmImissiveSignMain.fdEmergencyGrade.fdName }"/></span>
				</div>
			</c:if>
		     <div class="muiMissiveItemDSubjectRight"> <c:out value="${kmImissiveSignMain.docSubject}"/></div>
		</list:data-column>
			<%-- 发布时间--%>
      	<list:data-column col="docPublishTime" title="签发日期">
      		<c:choose>
      			<c:when test="${kmImissiveSignMain.docStatus eq '30'}">
      				<kmss:showDate value="${kmImissiveSignMain.docPublishTime}" type="date"></kmss:showDate>
      			</c:when>
      			<c:otherwise>
      				<kmss:showDate value="${kmImissiveSignMain.fdDraftTime}" type="date"></kmss:showDate>
      			</c:otherwise>
      		</c:choose>
      	</list:data-column>
      	<list:data-column col="listIcon" escape="false">
			muis-official-doc
		</list:data-column>
		<%--链接--%>
		<list:data-column col="href" escape="false">
		    /km/imissive/km_imissive_sign_main/kmImissiveSignMain.do?method=view&fdId=${kmImissiveSignMain.fdId}
		</list:data-column>
		<c:if test="${not empty kmImissiveSignMain.fdDraftDept}">
			<list:data-column col="docDeptName" escape="false" title="拟稿部门">
			     <c:out value="${kmImissiveSignMain.fdDraftDept.fdName}"/>
			</list:data-column>
		</c:if>
		<c:if test="${kmImissiveSignMain.docStatus=='30'}">
			<list:data-column col="docReadCount" escape="false">
		       <c:out value="${kmImissiveSignMain.docReadCount}" escapeXml="false"/>
			</list:data-column>
		</c:if>
		 <%-- 当前节点--%>
	 	<list:data-column col="summary" title="${ lfn:message('km-imissive:sysWfNode.processingNode.currentProcess') }" escape="false">
	        <kmss:showWfPropertyValues idValue="${kmImissiveSignMain.fdId}" propertyName="summary" />
      	</list:data-column>
	</list:data-columns>
	<list:data-paging currentPage="${queryPage.pageno }"
		pageSize="${queryPage.rowsize }" totalSize="${queryPage.totalrows }">
	</list:data-paging>
</list:data>