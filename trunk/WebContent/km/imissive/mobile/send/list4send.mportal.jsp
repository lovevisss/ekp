<%@ page language="java" contentType="text/json; charset=UTF-8"	pageEncoding="UTF-8"%>
<%@ include file="/sys/ui/jsp/common.jsp"%>
<%@ taglib uri="/WEB-INF/KmssConfig/sys/person/person.tld" prefix="person"%>
<list:data>
	<list:data-columns var="kmImissiveSendMain" list="${queryPage.list }" varIndex="status" mobile="true">
		<list:data-column property="fdId">
		</list:data-column >
	    <%-- 主题--%>	
		<list:data-column col="label" title="标题" escape="false">
		         <c:out value="${kmImissiveSendMain.docSubject}"/>
		</list:data-column>
			<%-- 发布时间--%>
      	<list:data-column col="created" title="签发日期">
	        <kmss:showDate value="${kmImissiveSendMain.docPublishTime}" type="date"></kmss:showDate>
      	</list:data-column>
      	<list:data-column col="listIcon" escape="false">
			mui-bookOpenLogo
		</list:data-column>
		<%--链接--%>
		<list:data-column col="href" escape="false">
		    /km/imissive/km_imissive_send_main/kmImissiveSendMain.do?method=view&fdId=${kmImissiveSendMain.fdId}
		</list:data-column>
		<c:if test="${not empty kmImissiveSendMain.fdSendtoUnit}">
			<list:data-column col="creator" escape="false" title="拟文单位">
			     <c:out value="${kmImissiveSendMain.fdSendtoUnit.fdName}"/>
			</list:data-column>
		</c:if>
		<c:if test="${kmImissiveSendMain.docStatus=='30'}">
			<list:data-column col="otherText" escape="false">
		       <c:out value="${kmImissiveSendMain.docReadCount}" escapeXml="false"/>
			</list:data-column>
		</c:if>
	</list:data-columns>
	<list:data-paging currentPage="${queryPage.pageno }"
		pageSize="${queryPage.rowsize }" totalSize="${queryPage.totalrows }">
	</list:data-paging>
</list:data>