<%@ page language="java" contentType="text/json; charset=UTF-8"
   import="com.landray.kmss.km.imissive.model.KmImissiveRegQu,net.sf.json.JSONArray,net.sf.json.JSONObject,java.util.*,com.landray.kmss.util.*"
   pageEncoding="UTF-8"%>
<%@ include file="/sys/ui/jsp/common.jsp"%>
<list:data>
	<list:data-columns var="kmImissiveRegQu" list="${queryPage.list }">
		<%--ID--%> 
		<list:data-column property="fdId"></list:data-column>
		<%--名称--%>
		<list:data-column  headerClass="width200" col="docSubject" title="${ lfn:message('km-imissive:kmImissiveRegQu.docSubject')}" style="text-align:left" escape="false">
			<span class="com_subject"><c:out value="${kmImissiveRegQu.docSubject}" /></span>
		</list:data-column>
		<list:data-column headerClass="width140"  col="docCreateTime" title="${ lfn:message('km-imissive:kmImissiveRegQu.docCreateTime')}">
		    <kmss:showDate value="${kmImissiveRegQu.docCreateTime}" type="datetime" />
		</list:data-column>
		<%--发往单位 --%>
		<list:data-column  col="fdUnits" escape="false" title="${ lfn:message('km-imissive:kmImissiveRegQu.fdDetail')}">
			<%
			if(pageContext.getAttribute("kmImissiveRegQu")!=null){
				KmImissiveRegQu kmImissiveRegQu = (KmImissiveRegQu)pageContext.getAttribute("kmImissiveRegQu");
				String fdDetail = kmImissiveRegQu.getFdDetail();
				JSONArray unitArr = JSONArray.fromObject(fdDetail);
				String unitNames="";
				for(int i=0;i<unitArr.size();i++){
					JSONObject unit = (JSONObject)unitArr.get(i);
					if(i==unitArr.size()-1){
						unitNames+=unit.getString("fdName");	
					}else{
						unitNames+=unit.getString("fdName")+";";
					}
				}
				request.setAttribute("unitNames",unitNames);
			}
			%>
			<p title="${unitNames}">
				${unitNames}
			</p>
		</list:data-column>
		<list:data-column headerClass="width100" col="fdType" title="${ lfn:message('km-imissive:kmImissiveRegQu.fdType')}">
		    <c:choose>
			    <c:when test="${kmImissiveRegQu.fdType eq '2' }">
			    	${ lfn:message('km-imissive:kmImissiveReg.fdRegType.receive')}
			    </c:when>
			    <c:otherwise>
			    	${ lfn:message('km-imissive:kmImissiveReg.fdRegType.send')}
			    </c:otherwise>
		    </c:choose>
		</list:data-column>
		<list:data-column headerClass="width140"  col="fdStatus" title="${ lfn:message('km-imissive:kmImissiveRegQu.fdStatus')}">
		   <sunbor:enumsShow value="${kmImissiveRegQu.fdStatus}" enumsType="kmImissiveRegQu_status" />
		</list:data-column>
	</list:data-columns>

	<list:data-paging currentPage="${queryPage.pageno }"
		pageSize="${queryPage.rowsize }" totalSize="${queryPage.totalrows }">
	</list:data-paging>
</list:data>