<%@ page language="java" contentType="text/json; charset=UTF-8"
   import="com.landray.kmss.km.imissive.model.KmImissiveReg,com.landray.kmss.km.imissive.model.KmImissiveRegDetailList,com.landray.kmss.sys.organization.model.SysOrgElement,java.util.*,com.landray.kmss.util.*"
   pageEncoding="UTF-8"%>
<%@ include file="/sys/ui/jsp/common.jsp"%>

<%@page import="com.landray.kmss.sys.unit.model.KmImissiveUnit"%>
<list:data>
	<list:data-columns var="kmImissiveReg" list="${queryPage.list }">
		<%--ID--%> 
		<list:data-column property="fdId"></list:data-column>
		<list:data-column headerClass="width140"  col="docCreateTime" title="${ lfn:message('km-imissive:kmImissiveReg.docCreateTime')}">
		    <kmss:showDate value="${kmImissiveReg.docCreateTime}" type="datetime" />
		</list:data-column>
		<%--名称--%>
		<list:data-column  headerClass="width200" col="fdName" title="${ lfn:message('km-imissive:kmImissiveReg.fdName')}" style="text-align:left" escape="false">
			<span class="com_subject"><c:out value="${kmImissiveReg.fdName}" /></span>
		</list:data-column>
		<%--发往单位 --%>
		<list:data-column  col="fdDetailList" escape="false" title="${ lfn:message('km-imissive:kmImissiveReg.fdUnit')}">
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
			<p title="${unitNames}">
				<c:forEach items="${kmImissiveReg.fdDetailList}" var="fdDetail" varStatus="vstatus">
					${fdDetail.fdUnit.fdName}
				</c:forEach>
			</p>
		</list:data-column>
		<list:data-column headerClass="width100" col="fdDeliverType" title="${ lfn:message('km-imissive:kmImissiveReg.from')}">
		    <sunbor:enumsShow value="${kmImissiveReg.fdDeliverType}" enumsType="kmImissiveRegDetailList_type" bundle="km-imissive" />
		</list:data-column>
		<list:data-column headerClass="width100" col="fdRegType" title="${ lfn:message('km-imissive:kmImissiveReg.fdRegType')}">
		    <c:choose>
			    <c:when test="${kmImissiveReg.fdRegType eq '2' }">
			    	${ lfn:message('km-imissive:kmImissiveReg.fdRegType.receive')}
			    </c:when>
			    <c:otherwise>
			    	${ lfn:message('km-imissive:kmImissiveReg.fdRegType.send')}
			    </c:otherwise>
		    </c:choose>
		</list:data-column>
	</list:data-columns>

	<list:data-paging currentPage="${queryPage.pageno }"
		pageSize="${queryPage.rowsize }" totalSize="${queryPage.totalrows }">
	</list:data-paging>
</list:data>