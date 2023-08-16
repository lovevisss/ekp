<%@ page language="java" contentType="text/json; charset=UTF-8"	pageEncoding="UTF-8"%>
<%@ page import="com.landray.kmss.km.imissive.model.KmImissiveRegDetailList,
                 com.landray.kmss.sys.organization.model.SysOrgElement,
                 java.util.*,com.landray.kmss.util.*,
                 com.landray.kmss.constant.SysOrgConstant"%>
<%@ include file="/sys/ui/jsp/common.jsp"%>
<%@ taglib uri="/WEB-INF/KmssConfig/sys/person/person.tld" prefix="person"%>
<list:data>
	<list:data-columns var="kmImissiveRegDetailList" list="${queryPage.list }" varIndex="status" mobile="true">
		<%
			if(pageContext.getAttribute("kmImissiveRegDetailList")!=null){
		    List<SysOrgElement> l=((KmImissiveRegDetailList)pageContext.getAttribute("kmImissiveRegDetailList")).getFdOrg();
		    List<SysOrgElement> fdOrg = new ArrayList();
			    if(l.size()>0&&!l.isEmpty()){
					for(int i=0;i<l.size();i++){
						SysOrgElement o = l.get(i);
						if(o.getFdOrgType()==SysOrgConstant.ORG_TYPE_POST){
							ArrayUtil.concatTwoList(o.getFdPersons(),fdOrg);
						}else{
							if(!fdOrg.contains(o)){
								fdOrg.add(o);
							}
						}
					 }
			    }
			    if(fdOrg.size()>0){
			  		 request.setAttribute("fdOrgId",fdOrg.get(0).getFdId());
			   		request.setAttribute("fdOrgName",fdOrg.get(0).getFdName());
			    }else{
			    	request.setAttribute("fdOrgId","");
			   		request.setAttribute("fdOrgName","");
			    }
			}
		%>
		<list:data-column property="fdId">
		</list:data-column >
		<%--状态--%>
		<list:data-column col="status" title="${ lfn:message('sys-news:sysNewsMain.docStatus') }" escape="false">
			<span class="muiProcessStatusBorder muiProcessExamine">
			<c:if test="${kmImissiveRegDetailList.fdStatus != '3' and kmImissiveRegDetailList.fdStatus != '4'}">
	           <c:choose>
	            <c:when test="${kmImissiveRegDetailList.fdStatus eq '2'}">
	             ${ lfn:message('km-imissive:status.signed')}（${ lfn:message('km-imissive:kmImissiveReg.sign.type')}：
	              <c:choose>
		            <c:when test="${ not empty kmImissiveRegDetailList.fdReceiveId}">
		               ${ lfn:message('km-imissive:kmImissiveReg.sign.type1')}
		            </c:when>
		            <c:otherwise>
		               ${ lfn:message('km-imissive:kmImissiveReg.sign.type2')}
		            </c:otherwise>
		          </c:choose>
	             ）
	            </c:when>
	            <c:otherwise>
	               <sunbor:enumsShow value="${kmImissiveRegDetailList.fdStatus}" enumsType="kmImissiveReg_status" bundle="km-imissive" />
	            </c:otherwise>
	           </c:choose>
			</c:if>
			<c:if test="${kmImissiveRegDetailList.fdStatus eq '3'}">
				<bean:message key="status.return" bundle="km-imissive"/>
			</c:if>
			<c:if test="${kmImissiveRegDetailList.fdStatus eq '4'}">
				<bean:message key="status.returnDoc" bundle="km-imissive"/>
			</c:if>
			<span>
		</list:data-column>
	    <%-- 主题--%>	
		<list:data-column col="label" title="${ lfn:message('km-imissive:kmImissiveReg.fdName')}" escape="false">
		         <c:out value="${kmImissiveRegDetailList.fdReg.fdName}"/>
		</list:data-column>
		
		 <%-- 创建时间--%>
	 	<list:data-column col="created" title="${ lfn:message('km-imissive:kmImissiveReg.docCreateTime')}">
	        <kmss:showDate value="${kmImissiveRegDetailList.docCreateTime}" type="date"></kmss:showDate>
      	</list:data-column>
      	 <%-- 创建者--%>
		<list:data-column col="creator" title="${ lfn:message('km-imissive:kmImissiveReg.fdOrgNames')}" >
		         <c:out value="${fdOrgName}"/>
		</list:data-column>
		 <%-- 创建者头像--%>
		<list:data-column col="icon" escape="false">
			    <person:headimageUrl personId="${fdOrgId}" size="m" />
		</list:data-column>
		<%--链接--%>
		<list:data-column col="href" escape="false">
		   /km/imissive/km_imissive_regdetail_list/kmImissiveRegDetailList.do?method=view&fdId=${kmImissiveRegDetailList.fdId}
		</list:data-column>
		 <%-- 创建时间--%>
	 	<list:data-column col="summary" title="${ lfn:message('km-imissive:sysWfNode.processingNode.currentProcessor') }" escape="false">
	         <c:out value="${kmImissiveRegDetailList.fdUnit.fdName}"/>
	         (<sunbor:enumsShow value="${kmImissiveRegDetailList.fdReg.fdDeliverType}" enumsType="kmImissiveRegDetailList_type" bundle="km-imissive" />
		     <sunbor:enumsShow value="${kmImissiveRegDetailList.fdType}" enumsType="kmImissiveRegDetailList_unittype" bundle="km-imissive" />)
      	</list:data-column>
		
	</list:data-columns>
	<list:data-paging currentPage="${queryPage.pageno }"
		pageSize="${queryPage.rowsize }" totalSize="${queryPage.totalrows }">
	</list:data-paging>
</list:data>