<%@ page language="java" contentType="text/json; charset=UTF-8"
   pageEncoding="UTF-8"%>
 <%@ page import="com.landray.kmss.km.imissive.model.KmImissiveRegDetailList,
                  com.landray.kmss.km.imissive.model.KmImissiveReturnOpinion,
                  java.util.List,com.landray.kmss.util.DateUtil,
                  com.landray.kmss.km.imissive.service.IKmImissiveReturnOpinionService"%>
<%@ page import="com.landray.kmss.util.SpringBeanUtil"%>
<%@ include file="/sys/ui/jsp/common.jsp"%>
<list:data>
	<list:data-columns var="kmImissiveRegDetailList" list="${queryPage.list}">
	    <%
			if(pageContext.getAttribute("kmImissiveRegDetailList")!=null){
				KmImissiveRegDetailList kmImissiveRegDetailList = (KmImissiveRegDetailList)pageContext.getAttribute("kmImissiveRegDetailList");
				IKmImissiveReturnOpinionService kmImissiveReturnOpinionService = (IKmImissiveReturnOpinionService)SpringBeanUtil.getBean("kmImissiveReturnOpinionService");
				List<KmImissiveReturnOpinion> list =kmImissiveReturnOpinionService.findOpinionsByDetailId(kmImissiveRegDetailList.getFdId());
				if(list.size()>0){
					KmImissiveReturnOpinion kmImissiveReturnOpinion =list.get(0);
					request.setAttribute("fdUnitName", kmImissiveReturnOpinion.getFdUnit().getFdName());
					request.setAttribute("fdReturnTime",DateUtil.convertDateToString(kmImissiveReturnOpinion.getDocCreateTime(),DateUtil.PATTERN_DATETIME));
					request.setAttribute("fdReturnOrgId",kmImissiveReturnOpinion.getDocCreator().getFdId());
					request.setAttribute("fdReturnOrgName",kmImissiveReturnOpinion.getDocCreator().getFdName());
					request.setAttribute("fdContent", kmImissiveReturnOpinion.getDocContent());
				}
			}
		%>
		<%--ID--%> 
		<list:data-column property="fdId"></list:data-column>
		<%--名称--%>
		<list:data-column  headerClass="width120" col="kmImissiveRegDetailList.fdReg.fdName" title="名称" style="text-align:left;min-width:150px" escape="false">
			<span class="com_subject"><c:out value="${kmImissiveRegDetailList.fdReg.fdName}" /></span>
		</list:data-column>
		<list:data-column headerClass="width80" col="kmImissiveRegDetailList.fdReg.fdDeliverType" title="来源">
		    <sunbor:enumsShow value="${kmImissiveRegDetailList.fdReg.fdDeliverType}" enumsType="kmImissiveRegDetailList_type" bundle="km-imissive" />
		    <sunbor:enumsShow value="${kmImissiveRegDetailList.fdType}" enumsType="kmImissiveRegDetailList_unittype" bundle="km-imissive" />
		</list:data-column>
		<list:data-column headerClass="width100" col="fdUnitName" title="${ lfn:message('km-imissive:kmImissiveRegDetailList.fdUnitName')}" escape="false">
		    <c:out value="${fdUnitName}" />
		</list:data-column>
		<list:data-column headerClass="width80" col="fdReturnOrg" title="${ lfn:message('km-imissive:kmImissiveRegDetailList.fdReturnOrg')}" escape="false">
		      <ui:person personId="${fdReturnOrgId}" personName="${fdReturnOrgName}"></ui:person>
	    </list:data-column>
		<list:data-column headerClass="width80"  col="fdReturnTime" title="${ lfn:message('km-imissive:kmImissiveRegDetailList.fdReturnTime')}" escape="false">
		    <c:out value="${fdReturnTime}" />
		</list:data-column>
		<list:data-column  headerClass="width120" col="fdContent"  title="${ lfn:message('km-imissive:kmImissiveRegDetailList.fdContent')}" escape="false">
			 <div class="width120 textEllipsis" style="min-width:120px" title="${fdContent}">
			  <c:out value="${fdContent}" />
			 </div>
	    </list:data-column>
	</list:data-columns>
	<list:data-paging currentPage="${queryPage.pageno }"
		pageSize="${queryPage.rowsize }" totalSize="${queryPage.totalrows }">
	</list:data-paging>
</list:data>