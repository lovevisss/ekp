<%@ page language="java" contentType="text/json; charset=UTF-8"	pageEncoding="UTF-8"%>
<%@ include file="/sys/ui/jsp/common.jsp"%>
<%@ taglib uri="/WEB-INF/KmssConfig/sys/person/person.tld" prefix="person"%>
<list:data>
	<list:data-columns var="kmImissiveRegDetailList" list="${queryPage.list }" varIndex="status" mobile="true">
		<list:data-column property="fdId">
		</list:data-column >
	    <%-- 主题--%>	
		<list:data-column col="label" title="标题" escape="false">
		        <c:out value="${kmImissiveRegDetailList.fdReg.fdName}" />
		</list:data-column>
		 <%-- 创建者--%>
		<list:data-column col="creator" title="收件人" >
		     <c:forEach items="${kmImissiveRegDetailList.fdOrg}" var="fdOrg" varStatus="vstatus">
		          <c:out value="${fdOrg.fdName}"/>
			 </c:forEach>
		</list:data-column>
		 <%-- 创建者头像--%>
		<list:data-column col="icon" escape="false">
		    <% request.setAttribute("userId",UserUtil.getUser().getFdId());%>
			    <person:headimageUrl personId="${userId}" size="m" />
		</list:data-column>
		 <%-- 创建时间--%>
	 	<list:data-column col="created" title="拟稿时间">
	        <kmss:showDate value="${kmImissiveRegDetailList.docCreateTime}" type="date" />
      	</list:data-column>
		<%--链接--%>
		<list:data-column col="href" escape="false">
		    /km/imissive/km_imissive_regdetail_list/kmImissiveRegDetailList.do?method=view&fdId=${kmImissiveRegDetailList.fdId}
		</list:data-column>
	</list:data-columns>
	<list:data-paging currentPage="${queryPage.pageno }"
		pageSize="${queryPage.rowsize }" totalSize="${queryPage.totalrows }">
	</list:data-paging>
</list:data>