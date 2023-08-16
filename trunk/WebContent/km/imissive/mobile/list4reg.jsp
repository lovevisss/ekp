<%@ page language="java" contentType="text/json; charset=UTF-8"	pageEncoding="UTF-8"%>
<%@ include file="/sys/ui/jsp/common.jsp"%>
<%@ taglib uri="/WEB-INF/KmssConfig/sys/person/person.tld" prefix="person"%>
<%@ page  import="com.landray.kmss.km.imissive.model.KmImissiveReg,
com.landray.kmss.km.imissive.model.KmImissiveRegDetailList,
com.landray.kmss.sys.organization.model.SysOrgElement,
java.util.*,com.landray.kmss.util.*"%>
<list:data>
	<list:data-columns var="kmImissiveReg" list="${queryPage.list }" varIndex="status" mobile="true">
		<list:data-column property="fdId">
		</list:data-column >
	    <%-- 主题--%>	
		<list:data-column col="label" title="${ lfn:message('km-imissive:kmImissiveReg.fdName')}111" escape="false">
		         <c:out value="${kmImissiveReg.fdName}"/>
		</list:data-column>
			<%-- 发布时间--%>
      	<list:data-column col="docPublishTime" title="${ lfn:message('km-imissive:kmImissiveReg.docCreateTime')}">
	        <kmss:showDate value="${kmImissiveReg.docCreateTime}" type="date"></kmss:showDate>
      	</list:data-column>
      	<list:data-column col="listIcon" escape="false">
			muis-official-doc
		</list:data-column>
		<%--链接--%>
		<list:data-column col="href" escape="false">
		   /km/imissive/km_imissive_reg/kmImissiveReg.do?method=view&fdId=${kmImissiveReg.fdId}
		</list:data-column>
		<list:data-column col="docDeptName" title="${ lfn:message('km-imissive:kmImissiveReg.fdUnit')}" >
		    <%
			if(pageContext.getAttribute("kmImissiveReg")!=null){
		    List fdDetailList=((KmImissiveReg)pageContext.getAttribute("kmImissiveReg")).getFdDetailList();
			String unitNames="";
				for(int i=0;i<fdDetailList.size();i++){
					if(i==fdDetailList.size()-1){
						unitNames+=((KmImissiveRegDetailList)fdDetailList.get(i)).getFdUnit().getFdName();	
					}else{
						unitNames+=((KmImissiveRegDetailList)fdDetailList.get(i)).getFdUnit().getFdName()+";";
					}
				 }
			request.setAttribute("unitNames",unitNames);
			}
			%>
			<c:choose>
				<c:when test="${kmImissiveReg.fdDeliverType eq '1' }">
					${ lfn:message('km-imissive:kmImissiveReg.fdUnit')}:
				</c:when>
				<c:otherwise>
					${ lfn:message('km-imissive:kmImissiveReg.fdUnit')}:
				</c:otherwise>
			</c:choose>
			<c:forEach items="${kmImissiveReg.fdDetailList}" var="fdDetail" varStatus="vstatus">
				${fdDetail.fdUnit.fdName}
				<c:if test="${fn:length(kmImissiveReg.fdDetailList)>(vstatus.index+1)}">
				 ;
				</c:if>
			</c:forEach>
		</list:data-column>
	</list:data-columns>
	<list:data-paging currentPage="${queryPage.pageno }"
		pageSize="${queryPage.rowsize }" totalSize="${queryPage.totalrows }">
	</list:data-paging>
</list:data>