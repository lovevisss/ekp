<%@ page language="java" contentType="text/json; charset=UTF-8"	pageEncoding="UTF-8"%>
<%@ include file="/sys/ui/jsp/common.jsp"%>
<%@ page import="com.landray.kmss.km.imissive.model.KmImissiveSignMain"%>
<%@page import="com.landray.kmss.km.imissive.util.KmImissiveConfigUtil"%>
<%@page import="java.util.Date"%>
<%@page import="com.landray.kmss.util.StringUtil"%>
<%@page import="net.sf.json.JSONObject"%>
<list:data>
	<list:data-columns var="kmImissiveSignMain" list="${queryPage.list }">
		<list:data-column property="fdId">
		</list:data-column>
		<list:data-column col="docSubject" escape="false" title="${lfn:message('km-imissive:kmImissiveSignMain.docSubject')}" style="text-align:left">
		      <span class="com_subject"><c:out value="${kmImissiveSignMain.docSubject}"/></span>
		</list:data-column>
		<list:data-column headerStyle="width:150px" escape="false" col="fdDocNum" title="${lfn:message('km-imissive:kmImissiveSignMain.fdDocNum')}">
		    <c:if test="${empty kmImissiveSignMain.fdDocNum}">
				 <c:choose>
			       <c:when test="${kmImissiveSignMain.docStatus!='30'}">
			          <bean:message  bundle="km-imissive" key="kmImissiveSignMain.docNum.info"/>
			       </c:when>
			       <c:otherwise>
			         <bean:message  bundle="km-imissive" key="kmImissiveSignMain.docNum.info.null"/>
			       </c:otherwise>
			    </c:choose>
			</c:if>
			<c:if test="${not empty kmImissiveSignMain.fdDocNum}">
				<c:out value="${kmImissiveSignMain.fdDocNum}"/>
			</c:if>
		</list:data-column>
		<list:data-column headerClass="width80"  col="fdDraftDept.fdName" title="${ lfn:message('km-imissive:kmImissiveSignMain.fdDraftDeptId')}" escape="false">
			<c:if test="${kmImissiveSignMain.fdDraftDept != null}">
				<c:out value="${kmImissiveSignMain.fdDraftDept.fdName}"/>
			</c:if>
		</list:data-column>
		<list:data-column headerStyle="width:40px" col="fdDrafter.fdName" title="${lfn:message('km-imissive:kmImissiveSignMain.fdDraftId')}" escape="false">
		   <ui:person personId="${kmImissiveSignMain.fdDrafter.fdId}" personName="${kmImissiveSignMain.fdDrafter.fdName}"></ui:person> 
		</list:data-column>
		<list:data-column headerStyle="width:100px"  col="fdDraftTime" title="${lfn:message('km-imissive:kmImissiveSignMain.fdDraftTime')}">
		    <kmss:showDate value="${kmImissiveSignMain.fdDraftTime}" type="date" />
		</list:data-column>
		<list:data-column headerClass="width100"  col="fdDeadTime" title="${ lfn:message('km-imissive:kmImissiveSendMain.fdDeadTime')}" escape="false">
			<c:if test="${not empty kmImissiveSignMain.fdDeadTime}">
			<%
			if(pageContext.getAttribute("kmImissiveSignMain")!=null){
				KmImissiveSignMain kmImissiveSignMain=(KmImissiveSignMain)pageContext.getAttribute("kmImissiveSignMain");
				JSONObject json = new JSONObject();
				Date d1 = null;
				Date d2 = null;
				if("30".equals(kmImissiveSignMain.getDocStatus())){
					d2 = kmImissiveSignMain.getDocPublishTime();
				}else{
					d2  = new Date();
				}
				if("fdDeadTime".equals(KmImissiveConfigUtil.getDeadLineRefer())){
					d1=kmImissiveSignMain.getFdDeadTime();
					json = KmImissiveConfigUtil.getDeadLineColor(d1,d2);
				}
				if("docCreateTime".equals(KmImissiveConfigUtil.getDeadLineRefer())){
					d1=kmImissiveSignMain.getDocCreateTime();
					json = KmImissiveConfigUtil.getDeadLineColor(d1,d2);
				}
				if(!json.isEmpty()){
					String bgcolor = json.getString("color");
					if(StringUtil.isNotNull(bgcolor)){
						request.setAttribute("color","#fff");
					}else{
						request.setAttribute("color","");
					}		
					request.setAttribute("bgcolor",json.getString("color"));
					request.setAttribute("day",json.get("day"));
				}else{
					request.setAttribute("bgcolor","");
					request.setAttribute("day","");
				}
			}
			%>
			<div style="background:${bgcolor};color:${color};" title='<kmss:showDate value="${kmImissiveSignMain.fdDeadTime}" type="date" />'>
				<c:choose>
					<c:when test="${not empty day}">
						超期${day}天
					</c:when>
					<c:otherwise>
						<kmss:showDate value="${kmImissiveSignMain.fdDeadTime}" type="date" />
					</c:otherwise>
				</c:choose>
			</div>
			</c:if>
		</list:data-column>
		<list:data-column headerClass="width60"  col="fdEmergencyGrade.fdName" title="${ lfn:message('km-imissive:kmImissiveSignMain.fdEmergencyGrade')}" escape="false">
			<c:if test="${not empty kmImissiveSignMain.fdEmergencyGrade.fdColor}">
				<div style="background:${kmImissiveSignMain.fdEmergencyGrade.fdColor};color:#fff;">
			</c:if>
				<c:out value="${kmImissiveSignMain.fdEmergencyGrade.fdName }"/>
			<c:if test="${not empty kmImissiveSignMain.fdEmergencyGrade.fdColor}">
				</div>
			</c:if>
		</list:data-column>
		<list:data-column headerStyle="width:40px" col="docStatus" title="${lfn:message('km-imissive:kmImissiveSignMain.docStatus')}">
			<sunbor:enumsShow
				value="${kmImissiveSignMain.docStatus}"
				enumsType="kmImissive_common_status" />
		</list:data-column>
	<c:if test="${fdstatus!=30}">	
		<!-- 当前环节和当前处理人-->	
		<list:data-column headerStyle="width:70px" col="nodeName" title="${ lfn:message('km-imissive:sysWfNode.processingNode.currentProcess') }" escape="false">
			<kmss:showWfPropertyValues var="nodevalue" idValue="${kmImissiveSignMain.fdId}" propertyName="nodeName" />
				<div class="textEllipsis width100" title="${nodevalue}">
			        <c:out value="${nodevalue}"></c:out>
			    </div>
		</list:data-column>
		<list:data-column headerStyle="width:80px" col="handlerName" title="${ lfn:message('km-imissive:sysWfNode.processingNode.currentProcessor') }" escape="false">
		    <kmss:showWfPropertyValues var="handlerValue" idValue="${kmImissiveSignMain.fdId}" propertyName="handlerName" />
		    	 <div class="textEllipsis width80" style="font-weight:bold;" title="${handlerValue}">
			        <c:out value="${handlerValue}"></c:out>
			    </div>
		</list:data-column>
   </c:if>  
   		<list:data-column headerClass="width100"  col="docCreateTime" title="${ lfn:message('km-imissive:kmImissiveSignMain.docCreateTime')}">
		    <kmss:showDate value="${kmImissiveSignMain.docCreateTime}" type="date" />
		</list:data-column>
		<list:data-column headerClass="width50" col="fdIsFiling" title="${ lfn:message('km-imissive:kmImissiveSignMain.fdIsFiling')}">
		    <c:if test="${kmImissiveSignMain.fdIsFiling == true}">
		    	<bean:message  bundle="km-imissive" key="kmMissive.fdIsFiling.yes"/>
			</c:if>
			<c:if test="${kmImissiveSignMain.fdIsFiling == false}">
				<bean:message  bundle="km-imissive" key="kmMissive.fdIsFiling.no"/>
			</c:if>
		</list:data-column>
		<list:data-column headerStyle="width:100px"  col="docAlterTime" title="${lfn:message('km-imissive:kmImissiveSignMain.docAlterTime')}">
		    <kmss:showDate value="${kmImissiveSignMain.docAlterTime}" type="date" />
		</list:data-column>	
	</list:data-columns>
	<list:data-paging currentPage="${queryPage.pageno }"
		pageSize="${queryPage.rowsize }" totalSize="${queryPage.totalrows }">
	</list:data-paging>
</list:data>
