<%@ page language="java" contentType="text/json; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.landray.kmss.km.imissive.model.KmImissiveRegDetailList,
                 com.landray.kmss.sys.organization.model.SysOrgElement,
                 java.util.*,com.landray.kmss.util.*,
                 com.landray.kmss.constant.SysOrgConstant"%>
<%@ include file="/sys/ui/jsp/common.jsp"%>
<list:data>
	<list:data-columns var="kmImissiveRegDetailList" list="${queryPage.list }">
		<%--ID--%> 
		<list:data-column property="fdId"></list:data-column>
		<%--名称
		<list:data-column col="kmImissiveRegDetailList.fdReg.fdName" title="${ lfn:message('km-imissive:kmImissiveReg.fdName')}" style="text-align:left;min-width:120px" escape="false">
			<span class="com_subject"><c:out value="${kmImissiveRegDetailList.fdReg.fdName}" /></span>
		</list:data-column>
		--%>
		<list:data-column headerClass="width120" property="fdUnit.fdName" title="${ lfn:message('km-imissive:kmImissiveReg.fdUnit')}">
		</list:data-column>
		<list:data-column col="kmImissiveRegDetailList.fdReg.fdDeliverType" title="${ lfn:message('km-imissive:kmImissiveReg.from')}" headerClass="width80" escape="false">
		    <sunbor:enumsShow value="${kmImissiveRegDetailList.fdReg.fdDeliverType}" enumsType="kmImissiveRegDetailList_type" bundle="km-imissive" />
		    <sunbor:enumsShow value="${kmImissiveRegDetailList.fdType}" enumsType="kmImissiveRegDetailList_unittype" bundle="km-imissive" />
		</list:data-column>
		<c:if test="${kmImissiveRegDetailList.fdReg.fdRegType != '2' }">
			<list:data-column headerClass="width120" property="fdReg.fdSendMain.fdSendtoUnit.fdName" title="${ lfn:message('km-imissive:kmImissiveReg.fdSendUnit')}">
			</list:data-column>
		</c:if>
		<list:data-column headerClass="width100"  col="docCreateTime" title="${ lfn:message('km-imissive:kmImissiveReg.docCreateTime')}">
		    <kmss:showDate value="${kmImissiveRegDetailList.docCreateTime}" type="date" />
		</list:data-column>
		<list:data-column headerClass="width120" col="fdOrgNames" title="${ lfn:message('km-imissive:kmImissiveReg.fdOrgNames')}" escape="false">
		  <c:choose>
		  	<c:when test="${kmImissiveRegDetailList.fdUnit.fdNature eq '2'}">
		  		<span style="color:#999"><无></span>
		  	</c:when>
		  	<c:otherwise>
		  		 <%
					if(pageContext.getAttribute("kmImissiveRegDetailList")!=null){
				    List<SysOrgElement> l=((KmImissiveRegDetailList)pageContext.getAttribute("kmImissiveRegDetailList")).getFdOrg();
				    List<SysOrgElement> fdOrg = new ArrayList();
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
					   request.setAttribute("fdOrg",fdOrg);
					}
					%>
				     <c:forEach items="${fdOrg}" var="org" varStatus="vstatus">
							<ui:person personId="${org.fdId}" personName="${org.fdName}"></ui:person>
					 </c:forEach>
		  	</c:otherwise>
		  </c:choose>
	    </list:data-column>
	    <list:data-column headerClass="width180"  col="fdStatus" title="${ lfn:message('km-imissive:kmImissiveReg.fdStatus')}" escape="false">
	        <c:if test="${kmImissiveRegDetailList.fdStatus != '3' and kmImissiveRegDetailList.fdStatus != '4' and kmImissiveRegDetailList.fdStatus != '7'}">
	           <c:choose>
	            <c:when test="${kmImissiveRegDetailList.fdStatus eq '2'}">
	             ${ lfn:message('km-imissive:status.signed')}(${lfn:message('km-imissive:kmImissiveReg.sign.type')}:
	              <c:choose>
		            <c:when test="${kmImissiveRegDetailList.fdSignType eq '1'}">
		               转发文
		            </c:when>
		            <c:when test="${kmImissiveRegDetailList.fdSignType eq '2'}">
		               ${ lfn:message('km-imissive:kmImissiveReg.sign.type1')}
		            </c:when>
		            <c:otherwise>
		               ${ lfn:message('km-imissive:kmImissiveReg.sign.type2')}
		            </c:otherwise>
		          </c:choose>
	             )
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
			<c:if test="${kmImissiveRegDetailList.fdStatus eq '7'}">
				<bean:message key="status.signopinion.received" bundle="km-imissive"/>
			</c:if>
		</list:data-column>
		<%--分发上报中取消功能用--%>
		<list:data-column headerClass="width80"  col="_fdStatus" title="${ lfn:message('km-imissive:kmImissiveReg.fdStatus')}" escape="false">
	        <c:out value="${kmImissiveRegDetailList.fdStatus}"/>
		</list:data-column>
		<list:data-column headerClass="width80" col="nodeName" title="${ lfn:message('km-imissive:sysWfNode.processingNode.currentProcess') }" escape="false">
			<c:choose>
				<c:when test="${kmImissiveRegDetailList.fdUnit.fdNature eq '2'}">
			  		<span style="color:#999"><无></span>
			  	</c:when>
	            <c:otherwise>
	               <c:if test="${kmImissiveRegDetailList.fdUnit.fdNature != 2}">
						<kmss:showWfPropertyValues idValue="${json[kmImissiveRegDetailList.fdId]}" propertyName="nodeName" />
					</c:if>
	            </c:otherwise>
	        </c:choose>
		</list:data-column>
		<list:data-column headerClass="width100" col="handlerName" title="${ lfn:message('km-imissive:sysWfNode.processingNode.currentProcessor') }" escape="false">
			<c:choose>
				<c:when test="${kmImissiveRegDetailList.fdUnit.fdNature eq '2'}">
			  		<span style="color:#999"><无></span>
			  	</c:when>
	            <c:otherwise>
	               <c:if test="${kmImissiveRegDetailList.fdUnit.fdNature != 2}">
			    	<kmss:showWfPropertyValues idValue="${json[kmImissiveRegDetailList.fdId]}" propertyName="handlerName" />
			    </c:if>
	            </c:otherwise>
	        </c:choose>
		</list:data-column>
	</list:data-columns>
	<list:data-paging currentPage="${queryPage.pageno }"
		pageSize="${queryPage.rowsize }" totalSize="${queryPage.totalrows }">
	</list:data-paging>
</list:data>