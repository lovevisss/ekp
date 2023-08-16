<%@ page language="java" contentType="text/json; charset=UTF-8"	pageEncoding="UTF-8"%>
<%@ include file="/sys/ui/jsp/common.jsp"%>
<%@ taglib uri="/WEB-INF/KmssConfig/sys/person/person.tld" prefix="person"%>
<list:data>
	<list:data-columns var="kmImissiveReceiveMain" list="${queryPage.list }" varIndex="status" mobile="true">
		<list:data-column property="fdId">
		</list:data-column >
		 <%-- 主题--%>	
		<list:data-column col="label" title="标题" escape="false">
		         <c:out value="${kmImissiveReceiveMain.docSubject}"/>
		</list:data-column>
			<%-- 发布时间--%>
      	<list:data-column col="created" title="签收日期">
	        <kmss:showDate value="${kmImissiveReceiveMain.fdSignTime}" type="date"></kmss:showDate>
      	</list:data-column>
      	<list:data-column col="listIcon" escape="false">
			mui-bookOpenLogo
		</list:data-column>
		<%--链接--%>
		<list:data-column col="href" escape="false">
		    /km/imissive/km_imissive_receive_main/kmImissiveReceiveMain.do?method=view&fdId=${kmImissiveReceiveMain.fdId}
		</list:data-column>
		<list:data-column col="creator" escape="false" title="拟文单位">
		     <c:out value="${kmImissiveReceiveMain.fdSendtoUnit.fdName}" /><c:out value="${kmImissiveReceiveMain.fdOutSendto}" />
		</list:data-column>
		<c:if test="${kmImissiveReceiveMain.docStatus=='30'}">
			<list:data-column col="otherText" escape="false">
		       <c:out value="${kmImissiveReceiveMain.docReadCount}" escapeXml="false"/>
			</list:data-column>
		</c:if>
	</list:data-columns>
	<list:data-paging currentPage="${queryPage.pageno }"
		pageSize="${queryPage.rowsize }" totalSize="${queryPage.totalrows }">
	</list:data-paging>
</list:data>