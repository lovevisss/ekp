<%@ page language="java" contentType="text/json; charset=UTF-8"	pageEncoding="UTF-8"%>
<%@ include file="/sys/ui/jsp/common.jsp"%>
<%@ taglib uri="/WEB-INF/KmssConfig/sys/person/person.tld" prefix="person"%>
<list:data>
	<list:data-columns var="kmImissiveSignMain" list="${queryPage.list }" varIndex="status" mobile="true">
		<list:data-column property="fdId">
		</list:data-column >
		 <%-- 主题--%>	
		<list:data-column col="label" title="标题" escape="false">
		         <c:out value="${kmImissiveSignMain.docSubject}"/>
		</list:data-column>
			<%-- 发布时间--%>
      	<list:data-column col="created" title="签发日期">
	        <kmss:showDate value="${kmImissiveSignMain.docPublishTime}" type="date"></kmss:showDate>
      	</list:data-column>
      	<list:data-column col="listIcon" escape="false">
			mui-bookOpenLogo
		</list:data-column>
		<%--链接--%>
		<list:data-column col="href" escape="false">
		    /km/imissive/km_imissive_sign_main/kmImissiveSignMain.do?method=view&fdId=${kmImissiveSignMain.fdId}
		</list:data-column>
		<c:if test="${not empty kmImissiveSignMain.fdDraftDept}">
			<list:data-column col="creator" escape="false" title="拟稿部门">
			     <c:out value="${kmImissiveSignMain.fdDraftDept.fdName}"/>
			</list:data-column>
		</c:if>
		<c:if test="${kmImissiveSignMain.docStatus=='30'}">
			<list:data-column col="otherText" escape="false">
		       <c:out value="${kmImissiveSignMain.docReadCount}" escapeXml="false"/>
			</list:data-column>
		</c:if>
	</list:data-columns>
	<list:data-paging currentPage="${queryPage.pageno }"
		pageSize="${queryPage.rowsize }" totalSize="${queryPage.totalrows }">
	</list:data-paging>
</list:data>