<%@ page language="java" contentType="text/json; charset=UTF-8"
   import="com.landray.kmss.km.imissive.model.KmImissiveRegQu,net.sf.json.JSONArray,net.sf.json.JSONObject,java.util.*,com.landray.kmss.util.*"
   pageEncoding="UTF-8"%>
<%@ include file="/sys/ui/jsp/common.jsp"%>
<list:data>
	<list:data-columns var="kmImissiveOpinionOutQu" list="${queryPage.list }">
		<%--ID--%> 
		<list:data-column property="fdId"></list:data-column>
		<%--名称--%>
		<list:data-column  headerClass="width200" col="docSubject" title="${ lfn:message('km-imissive:kmImissiveOpinionOutQu.docSubject')}" style="text-align:left" escape="false">
			<span class="com_subject"><c:out value="${kmImissiveOpinionOutQu.docSubject}" /></span>
		</list:data-column>
		<list:data-column headerClass="width140"  col="docCreateTime" title="${ lfn:message('km-imissive:kmImissiveOpinionOutQu.docCreateTime')}">
		    <kmss:showDate value="${kmImissiveOpinionOutQu.docCreateTime}" type="datetime" />
		</list:data-column>
		<list:data-column headerClass="width140"  col="fdStatus" title="${ lfn:message('km-imissive:kmImissiveOpinionOutQu.fdStatus')}">
		   <sunbor:enumsShow value="${kmImissiveOpinionOutQu.fdStatus}" enumsType="kmImissiveOpinionOutQu_status" />
		</list:data-column>
	</list:data-columns>
	<list:data-paging currentPage="${queryPage.pageno }"
		pageSize="${queryPage.rowsize }" totalSize="${queryPage.totalrows }">
	</list:data-paging>
</list:data>