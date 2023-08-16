<%@page import="com.landray.kmss.util.StringUtil"%>
<%@ page language="java" contentType="text/json; charset=UTF-8"	pageEncoding="UTF-8"%>
<%@ include file="/sys/ui/jsp/common.jsp"%>
<%@ page import="com.landray.kmss.km.imissive.model.KmImissiveSendMain"%>
<%@page import="com.landray.kmss.km.imissive.util.KmImissiveConfigUtil"%>
<%@page import="java.util.Date"%>
<%@page import="com.landray.kmss.util.StringUtil"%>
<%@page import="net.sf.json.JSONObject"%>
<list:data>
	<list:data-columns var="kmImissiveSendMain" list="${querylist}">
		<list:data-column property="fdId">
		</list:data-column>
		<list:data-column col="docSubject" escape="false" title="${ lfn:message('km-imissive:kmImissiveSendMain.docSubject')}" style="text-align:left;min-width:120px">
		      <span class="com_subject"><c:out value="${kmImissiveSendMain.docSubject}"/></span>
		</list:data-column>
		<list:data-column headerClass="width120" col="fdDocNum" title="${ lfn:message('km-imissive:kmImissiveSendMain.fdDocNum')}">
		    <c:if test="${empty kmImissiveSendMain.fdDocNum}">
			    <c:choose>
			       <c:when test="${kmImissiveSendMain.docStatus!='30'}">
			          <bean:message  bundle="km-imissive" key="kmImissiveSendMain.docNum.info"/>
			       </c:when>
			       <c:otherwise>
			         <bean:message  bundle="km-imissive" key="kmImissiveSendMain.docNum.info.null"/>
			       </c:otherwise>
			    </c:choose>
			</c:if>
			<c:if test="${not empty kmImissiveSendMain.fdDocNum}">
				<c:out value="${kmImissiveSendMain.fdDocNum}"/>
			</c:if>
		</list:data-column>
		<list:data-column headerClass="width50" col="fdIsFiling" title="${ lfn:message('km-imissive:kmImissiveSendMain.fdIsFiling')}">
		    <c:if test="${kmImissiveSendMain.fdIsFiling == true}">
		    	<bean:message  bundle="km-imissive" key="kmMissive.fdIsFiling.yes"/>
			</c:if>
			<c:if test="${kmImissiveSendMain.fdIsFiling == false}">
				<bean:message  bundle="km-imissive" key="kmMissive.fdIsFiling.no"/>
			</c:if>
		</list:data-column>
		<list:data-column headerClass="width80"  col="fdSendtoUnit.fdName" title="${ lfn:message('km-imissive:kmImissiveSendMain.fdSendtoDept')}" escape="false">
			<c:if test="${kmImissiveSendMain.fdSendtoUnit != null}">
				<c:out value="${kmImissiveSendMain.fdSendtoUnit.fdName}"/>
			</c:if>
		</list:data-column>
		<list:data-column headerClass="width60" col="fdDrafter.fdName" title="${ lfn:message('km-imissive:kmImissiveSendMain.fdDraftId')}" escape="false">
		   <ui:person personId="${kmImissiveSendMain.fdDrafter.fdId}" personName="${kmImissiveSendMain.fdDrafter.fdName}"></ui:person> 
		</list:data-column>
		<list:data-column headerClass="width100"  col="fdDraftTime" title="${ lfn:message('km-imissive:kmImissiveSendMain.fdDraftTime')}">
		    <kmss:showDate value="${kmImissiveSendMain.fdDraftTime}" type="date" />
		</list:data-column>
		<list:data-column headerClass="width100"  col="fdDeadTime" title="${ lfn:message('km-imissive:kmImissiveSendMain.fdDeadTime')}" escape="false">
			<c:if test="${not empty kmImissiveSendMain.fdDeadTime}">
			<%
			if(pageContext.getAttribute("kmImissiveSendMain")!=null){
				KmImissiveSendMain kmImissiveSendMain=(KmImissiveSendMain)pageContext.getAttribute("kmImissiveSendMain");
				JSONObject json = new JSONObject();
				Date d1 = null;
				Date d2 = null;
				if("30".equals(kmImissiveSendMain.getDocStatus())){
					d2 = kmImissiveSendMain.getDocPublishTime();
				}else{
					d2  = new Date();
				}
				if("fdDeadTime".equals(KmImissiveConfigUtil.getDeadLineRefer())){
					d1=kmImissiveSendMain.getFdDeadTime();
					json = KmImissiveConfigUtil.getDeadLineColor(d1,d2);
				}
				if("docCreateTime".equals(KmImissiveConfigUtil.getDeadLineRefer())){
					d1=kmImissiveSendMain.getDocCreateTime();
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
			<div style="background:${bgcolor};color:${color};" title='<kmss:showDate value="${kmImissiveSendMain.fdDeadTime}" type="date" />'>
				<c:choose>
					<c:when test="${not empty day}">
						超期${day}天
					</c:when>
					<c:otherwise>
						<kmss:showDate value="${kmImissiveSendMain.fdDeadTime}" type="date" />
					</c:otherwise>
				</c:choose>
			</div>
			</c:if>
		</list:data-column>
		<list:data-column headerClass="width100"  col="fdPrintTime" title="${ lfn:message('km-imissive:kmImissiveSendMain.fdPrintTime')}">
		    <kmss:showDate value="${kmImissiveSendMain.fdPrintTime}" type="date" />
		</list:data-column>
		<list:data-column headerClass="width60"  col="fdEmergencyGrade.fdName" title="${ lfn:message('km-imissive:kmImissiveSendMain.fdEmergencyGrade')}" escape="false">
			<c:if test="${not empty kmImissiveSendMain.fdEmergencyGrade.fdColor}">
				<div style="background:${kmImissiveSendMain.fdEmergencyGrade.fdColor};color:#fff;">
			</c:if>
				<c:out value="${kmImissiveSendMain.fdEmergencyGrade.fdName }"/>
			<c:if test="${not empty kmImissiveSendMain.fdEmergencyGrade.fdColor}">
				</div>
			</c:if>
		</list:data-column>
		<list:data-column headerClass="width40" col="docStatus" title="${ lfn:message('km-imissive:kmImissiveSendMain.docStatus')}">
			<sunbor:enumsShow
				value="${kmImissiveSendMain.docStatus}"
				enumsType="kmImissive_common_status" />
		</list:data-column>
		<!-- 当前环节和当前处理人-->	
		<list:data-column headerClass="width80" col="nodeName" title="${ lfn:message('km-imissive:sysWfNode.processingNode.currentProcess') }" escape="false">
			<kmss:showWfPropertyValues var="nodevalue" idValue="${kmImissiveSendMain.fdId}" propertyName="nodeName" />
				<div class="textEllipsis width100" title="${nodevalue}">
			        <c:out value="${nodevalue}"></c:out>
			    </div>
		</list:data-column>
		<list:data-column headerClass="width80" col="handlerName" title="${ lfn:message('km-imissive:sysWfNode.processingNode.currentProcessor') }" escape="false">
		    <kmss:showWfPropertyValues var="handlerValue" idValue="${kmImissiveSendMain.fdId}" propertyName="handlerName" />
		    	<div class="textEllipsis width80" style="font-weight:bold;" title="${handlerValue}">
			        <c:out value="${handlerValue}"></c:out>
			    </div>
		</list:data-column>
   		<list:data-column headerClass="width100"  col="docAlterTime" title="${ lfn:message('km-imissive:kmImissiveSendMain.docAlterTime')}">
		    <kmss:showDate value="${kmImissiveSendMain.docAlterTime}" type="date" />
		</list:data-column>
		<list:data-column headerClass="width50" col="fdMissiveType" title="${ lfn:message('km-imissive:kmImissiveSendMain.fdMissiveType')}">
		    <c:if test="${kmImissiveSendMain.fdMissiveType == '0'}">
		    	<bean:message  bundle="km-imissive" key="missiveType.unlimited"/>
			</c:if>
			<c:if test="${kmImissiveSendMain.fdMissiveType == '1'}">
				<bean:message  bundle="km-imissive" key="missiveType.distribute"/>
			</c:if>
			<c:if test="${kmImissiveSendMain.fdMissiveType == '2'}">
				<bean:message  bundle="km-imissive" key="missiveType.report"/>
			</c:if>
		</list:data-column>
		<list:data-column headerClass="width100"  col="docCreateTime" title="${ lfn:message('km-imissive:kmImissiveSendMain.docCreateTime')}">
		    <kmss:showDate value="${kmImissiveSendMain.docCreateTime}" type="date" />
		</list:data-column>
		<list:data-column headerClass="width100"  col="docPublishTime" title="${ lfn:message('km-imissive:kmImissiveSendMain.docPublishTime')}">
		    <kmss:showDate value="${kmImissiveSendMain.docPublishTime}" type="date" />
		</list:data-column>	
	</list:data-columns>
	<list:data-paging currentPage="${queryPage.pageno }"
		pageSize="${queryPage.rowsize }" totalSize="${queryPage.totalrows }">
	</list:data-paging>
</list:data>
