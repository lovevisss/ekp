<%@ page language="java" contentType="text/json; charset=UTF-8"	pageEncoding="UTF-8"%>
<%@ include file="/sys/ui/jsp/common.jsp"%>
<%@ taglib uri="/WEB-INF/KmssConfig/sys/person/person.tld" prefix="person"%>
<list:data>
	<list:data-columns var="kmImissiveReceiveMain" list="${queryPage.list }" varIndex="status" mobile="true">
		<list:data-column property="fdId">
		</list:data-column >
		 <%-- 主题--%>	
		<list:data-column col="label" title="标题" escape="false">
		     <c:if test="${not empty kmImissiveReceiveMain.fdEmergencyGrade.fdColor}">
				<div class="muiMissiveItemDSubjectLeft" style="border:1px solid ${kmImissiveReceiveMain.fdEmergencyGrade.fdColor};color:${kmImissiveReceiveMain.fdEmergencyGrade.fdColor};">
					<span class="muiFontSizeS"><c:out value="${kmImissiveReceiveMain.fdEmergencyGrade.fdName }"/></span>
				</div>
			</c:if>
		     <div class="muiMissiveItemDSubjectRight"><c:out value="${kmImissiveReceiveMain.docSubject}"/></div>
		</list:data-column>
			<%-- 发布时间--%>
      	<list:data-column col="docPublishTime" title="签收日期">	
      		<c:choose>
      			<c:when test="${kmImissiveReceiveMain.docStatus eq '30'}">
      				 <kmss:showDate value="${kmImissiveReceiveMain.docPublishTime}" type="date"></kmss:showDate>
      			</c:when>
      			<c:otherwise>
      				<kmss:showDate value="${kmImissiveReceiveMain.fdSignTime}" type="date"></kmss:showDate>
      			</c:otherwise>
      		</c:choose>
      	</list:data-column>
      	<list:data-column col="listIcon" escape="false">
			muis-official-doc
		</list:data-column>
		<%--链接--%>
		<list:data-column col="href" escape="false">
		    /km/imissive/km_imissive_receive_main/kmImissiveReceiveMain.do?method=view&fdId=${kmImissiveReceiveMain.fdId}
		</list:data-column>
		<list:data-column col="docDeptName" escape="false" title="拟文单位">
		     <c:out value="${kmImissiveReceiveMain.fdSendtoUnit.fdName}" /><c:out value="${kmImissiveReceiveMain.fdOutSendto}" />
		</list:data-column>
		<c:if test="${kmImissiveReceiveMain.docStatus=='30'}">
			<list:data-column col="docReadCount" escape="false">
		       <c:out value="${kmImissiveReceiveMain.docReadCount}" escapeXml="false"/>
			</list:data-column>
		</c:if>
		 <%-- 当前节点--%>
	 	<list:data-column col="summary" title="${ lfn:message('km-imissive:sysWfNode.processingNode.currentProcess') }" escape="false">
	        <kmss:showWfPropertyValues idValue="${kmImissiveReceiveMain.fdId}" propertyName="summary" />
      	</list:data-column>
	</list:data-columns>
	<list:data-paging currentPage="${queryPage.pageno }"
		pageSize="${queryPage.rowsize }" totalSize="${queryPage.totalrows }">
	</list:data-paging>
</list:data>