<%@ page language="java" contentType="text/json; charset=UTF-8"	pageEncoding="UTF-8"%>
<%@ include file="/sys/ui/jsp/common.jsp"%>
<%@ taglib uri="/WEB-INF/KmssConfig/sys/person/person.tld" prefix="person"%>
<%@ page import="com.landray.kmss.sys.attachment.util.SysAttConfigUtil" %>
<%
	pageContext.setAttribute("_readOLConfig", new String(SysAttConfigUtil.getReadOLConfig()));
%>
<list:data>
	<list:data-columns var="kmImissiveAttTrack" list="${queryPage.list }" varIndex="status" mobile="true">
		<list:data-column property="fdId">
		</list:data-column >
	    <%-- 主题--%>	
		<list:data-column col="label" title="${ lfn:message('km-imissive:kmImissiveAttTrack.fileName') }" escape="false">
			<c:out value="${kmImissiveAttTrack.fileName}"/>
		</list:data-column>
		 <%-- 创建者--%>
		<list:data-column col="creator" title="${ lfn:message('km-imissive:kmImissiveAttTrack.docCreator') }" >
		         <c:out value="${kmImissiveAttTrack.docCreator.fdName}"/>
		</list:data-column>
		 <%-- 创建者头像--%>
		<list:data-column col="icon" escape="false">
			    <person:headimageUrl personId="${kmImissiveAttTrack.docCreator.fdId}" size="m" />
		</list:data-column>
		
		 <%-- 发布时间--%>
	 	<list:data-column col="created" title="${ lfn:message('km-imissive:kmImissiveAttTrack.docCreateTime') }">
	        <kmss:showDate value="${kmImissiveAttTrack.docCreateTime}" type="date"></kmss:showDate>
      	</list:data-column>
		<%--链接--%>
		<c:choose>
			<c:when test="${'-1' ne _readOLConfig and '1' ne _readOLConfig}">
				<list:data-column col="href" escape="false">
					/sys/attachment/sys_att_main/sysAttMain.do?method=view&fdId=${kmImissiveAttTrack.fileId}
				</list:data-column>
			</c:when>
			<c:otherwise>
				<list:data-column col="href" escape="false">
					/third/pda/attdownload.jsp?fdId=${kmImissiveAttTrack.fileId}
				</list:data-column>
			</c:otherwise>
		</c:choose>
		<list:data-column col="fileId" escape="false">
			<c:out value="${kmImissiveAttTrack.fileId}"/>
		</list:data-column>
		<list:data-column col="summary" title="${ lfn:message('km-imissive:kmImissiveAttTrack.fdNodeName') }" escape="false">
	       <c:out value="${kmImissiveAttTrack.fdNodeName}"/>
      	</list:data-column>
	</list:data-columns>
	
	<list:data-paging currentPage="${queryPage.pageno }"
		pageSize="${queryPage.rowsize }" totalSize="${queryPage.totalrows }">
	</list:data-paging>
</list:data>