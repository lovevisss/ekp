<%@ page language="java" contentType="text/json; charset=UTF-8"	pageEncoding="UTF-8"%>
<%@ include file="/sys/ui/jsp/common.jsp"%>
<%@ page import="com.landray.kmss.km.imissive.model.KmImissiveReceiveMain"%>
<%@page import="com.landray.kmss.km.imissive.util.KmImissiveConfigUtil"%>
<%@page import="java.util.Date"%>
<%@page import="com.landray.kmss.util.StringUtil"%>
<%@page import="net.sf.json.JSONObject"%>
<list:data>
	<list:data-columns var="kmImissiveReceiveMain" list="${queryPage.list }"> 
		<list:data-column property="fdId">
		</list:data-column>
		<list:data-column col="docSubject"  title="${ lfn:message('km-imissive:kmImissiveReceiveMain.docSubject') }" style="text-align:left;min-width:150px" escape="false">
		   <span class="com_subject" title="${kmImissiveReceiveMain.docSubject}"><c:out value="${kmImissiveReceiveMain.docSubject}"/></span>
		</list:data-column>
		  <list:data-column headerClass="width100" col="fdSendtoUnit.fdName" title="${ lfn:message('km-imissive:kmImissiveReceiveMain.fdSendtoDept') }">
		   <c:out value="${kmImissiveReceiveMain.fdSendtoUnit.fdName}" /><c:out value="${kmImissiveReceiveMain.fdOutSendto}" />
		  </list:data-column>
		  <list:data-column headerClass="width120" escape="false" property="fdReceiveNum" title="${ lfn:message('km-imissive:kmImissiveReceiveMain.fdReceiveNum') }">
		      <c:if test="${empty kmImissiveReceiveMain.fdReceiveNum}">
			    <c:choose>
			       <c:when test="${kmImissiveReceiveMain.docStatus!='30'}">
			          <bean:message  bundle="km-imissive" key="kmImissiveReceiveMain.fdReceiveNum.docNum.info"/>
			       </c:when>
			       <c:otherwise>
			         <bean:message  bundle="km-imissive" key="kmImissiveReceiveMain.fdReceiveNum.docNum.info.null"/>
			       </c:otherwise>
			    </c:choose>
			</c:if>
			<c:if test="${not empty kmImissiveReceiveMain.fdReceiveNum}">
				<c:out value="${kmImissiveReceiveMain.fdReceiveNum}"/>
			</c:if>
		  </list:data-column>
		  <list:data-column headerClass="width100" col="fdReceiveTime" title="${ lfn:message('km-imissive:kmImissiveReceiveMain.fdReceiveTime') }">
		     <kmss:showDate value="${kmImissiveReceiveMain.fdReceiveTime}" type="date" />
		  </list:data-column>
		  <list:data-column headerClass="width100"  col="fdDeadTime" title="${ lfn:message('km-imissive:kmImissiveSendMain.fdDeadTime')}" escape="false">
			<c:if test="${not empty kmImissiveReceiveMain.fdDeadTime}">
			<%
			if(pageContext.getAttribute("kmImissiveReceiveMain")!=null){
				KmImissiveReceiveMain kmImissiveReceiveMain=(KmImissiveReceiveMain)pageContext.getAttribute("kmImissiveReceiveMain");
				JSONObject json = new JSONObject();
				Date d1 = null;
				Date d2 = null;
				if("30".equals(kmImissiveReceiveMain.getDocStatus())){
					d2 = kmImissiveReceiveMain.getDocPublishTime();
				}else{
					d2  = new Date();
				}
				if("fdDeadTime".equals(KmImissiveConfigUtil.getDeadLineRefer())){
					d1=kmImissiveReceiveMain.getFdDeadTime();
					json = KmImissiveConfigUtil.getDeadLineColor(d1,d2);
				}
				if("docCreateTime".equals(KmImissiveConfigUtil.getDeadLineRefer())){
					d1=kmImissiveReceiveMain.getDocCreateTime();
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
			<div style="background:${bgcolor};color:${color};" title='<kmss:showDate value="${kmImissiveReceiveMain.fdDeadTime}" type="date" />'>
				<c:choose>
					<c:when test="${not empty day}">
						超期${day}天
					</c:when>
					<c:otherwise>
						<kmss:showDate value="${kmImissiveReceiveMain.fdDeadTime}" type="date" />
					</c:otherwise>
				</c:choose>
			</div>
			</c:if>
		</list:data-column>
		  <list:data-column headerClass="width60"  col="fdEmergencyGrade.fdName" title="${ lfn:message('km-imissive:kmImissiveReceiveMain.fdEmergencyGrade')}" escape="false">
			<c:if test="${not empty kmImissiveReceiveMain.fdEmergencyGrade.fdColor}">
				<div style="background:${kmImissiveReceiveMain.fdEmergencyGrade.fdColor};color:#fff;">
			</c:if>
				<c:out value="${kmImissiveReceiveMain.fdEmergencyGrade.fdName }"/>
			<c:if test="${not empty kmImissiveReceiveMain.fdEmergencyGrade.fdColor}">	
				</div>
			</c:if>
		</list:data-column>
		<list:data-column headerClass="width60" col="docStatus" title="${ lfn:message('km-imissive:kmImissiveReceiveMain.docStatus') }">
			<sunbor:enumsShow
				value="${kmImissiveReceiveMain.docStatus}"
				enumsType="kmImissive_common_status" />
		</list:data-column> 
		<c:if test="${fdstatus!=30}">	
		<!-- 当前环节和当前处理人-->	
		<list:data-column headerClass="width80" col="nodeName" title="${ lfn:message('km-imissive:sysWfNode.processingNode.currentProcess') }" escape="false">
			<kmss:showWfPropertyValues var="nodevalue" idValue="${kmImissiveReceiveMain.fdId}" propertyName="nodeName" />
				<div class="textEllipsis width100" title="${nodevalue}">
			        <c:out value="${nodevalue}"></c:out>
			    </div>
		</list:data-column>
		<list:data-column headerClass="width80" col="handlerName" title="${ lfn:message('km-imissive:sysWfNode.processingNode.currentProcessor') }" escape="false">
		    <kmss:showWfPropertyValues var="handlerValue" idValue="${kmImissiveReceiveMain.fdId}" propertyName="handlerName" />
		    	 <div class="textEllipsis width80" style="font-weight:bold;" title="${handlerValue}">
			        <c:out value="${handlerValue}"></c:out>
			    </div>
		</list:data-column>
		</c:if>
		<list:data-column headerClass="width100"  col="docCreateTime" title="${ lfn:message('km-imissive:kmImissiveReceiveMain.docCreateTime')}">
		    <kmss:showDate value="${kmImissiveReceiveMain.docCreateTime}" type="date" />
		</list:data-column>
		<list:data-column headerClass="width100"  col="fdSignTime" title="${ lfn:message('km-imissive:kmImissiveReceiveMain.fdSignTime')}">
		    <kmss:showDate value="${kmImissiveReceiveMain.fdSignTime}" type="date" />
		</list:data-column>
		<list:data-column headerClass="width100"  col="fdRecordTime" title="${ lfn:message('km-imissive:kmImissiveReceiveMain.fdRecordTime')}">
		    <kmss:showDate value="${kmImissiveReceiveMain.fdRecordTime}" type="date" />
		</list:data-column>
		<list:data-column headerClass="width50" col="fdIsFiling" title="${ lfn:message('km-imissive:kmImissiveReceiveMain.fdIsFiling')}">
		    <c:if test="${kmImissiveReceiveMain.fdIsFiling == true}">
		    	<bean:message  bundle="km-imissive" key="kmMissive.fdIsFiling.yes"/>
			</c:if>
			<c:if test="${kmImissiveReceiveMain.fdIsFiling == false}">
				<bean:message  bundle="km-imissive" key="kmMissive.fdIsFiling.no"/>
			</c:if>
		</list:data-column>
		<list:data-column headerClass="width50" col="fdIsReturn" title="${ lfn:message('km-imissive:kmImissiveReceiveMain.fdIsReturn')}">
		    <c:if test="${kmImissiveReceiveMain.fdIsReturn == true}">
		    	<bean:message  bundle="km-imissive" key="kmImissiveReceiveMain.fdIsReturn.yes"/>
			</c:if>
			<c:if test="${kmImissiveReceiveMain.fdIsReturn == false}">
				<bean:message  bundle="km-imissive" key="kmImissiveReceiveMain.fdIsReturn.yes"/>
			</c:if>
		</list:data-column>
		<list:data-column headerClass="width100" col="docAlterTime" title="${ lfn:message('km-imissive:kmImissiveReceiveMain.docAlterTime') }">
		     <kmss:showDate value="${kmImissiveReceiveMain.docAlterTime}" type="date" />
		  </list:data-column>
	</list:data-columns>
	<list:data-paging currentPage="${queryPage.pageno }"
		pageSize="${queryPage.rowsize }" totalSize="${queryPage.totalrows }">
	</list:data-paging>
</list:data>

