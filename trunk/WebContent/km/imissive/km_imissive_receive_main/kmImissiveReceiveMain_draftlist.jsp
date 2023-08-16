<%@ page language="java" contentType="text/json; charset=UTF-8"	pageEncoding="UTF-8"%>
<%@ include file="/sys/ui/jsp/common.jsp"%>
<list:data>
	<list:data-columns var="kmImissiveReceiveMain" list="${queryPage.list }"> 
		<list:data-column property="fdId">
		</list:data-column>
		<list:data-column col="docSubject" headerClass="width120" title="${ lfn:message('km-imissive:kmImissiveReceiveMain.docSubject') }" style="text-align:left;min-width:150px" escape="false">
		   <span class="com_subject" title="${kmImissiveReceiveMain.docSubject}"><c:out value="${kmImissiveReceiveMain.docSubject}"/></span>
		</list:data-column>
		  <list:data-column headerClass="width100" col="fdSendtoUnit.fdName" title="${ lfn:message('km-imissive:kmImissiveReceiveMain.fdSendtoDept') }">
		   <c:out value="${kmImissiveReceiveMain.fdSendtoUnit.fdName}" /><c:out value="${kmImissiveReceiveMain.fdOutSendto}" />
		  </list:data-column>
		  <list:data-column headerClass="width120" property="fdReceiveNum" title="${ lfn:message('km-imissive:kmImissiveReceiveMain.fdReceiveNum') }">
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
			<kmss:showWfPropertyValues idValue="${kmImissiveReceiveMain.fdId}" propertyName="nodeName" />
		</list:data-column>
		<list:data-column headerClass="width80" col="handlerName" title="${ lfn:message('km-imissive:sysWfNode.processingNode.currentProcessor') }" escape="false">
		    <kmss:showWfPropertyValues idValue="${kmImissiveReceiveMain.fdId}" propertyName="handlerName" />
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
		  <list:data-column headerClass="width80" col="operations" title="${ lfn:message('list.operation') }" escape="false">
			<div class="conf_show_more_w">
				<div class="conf_btn_edit">
			 		<kmss:auth requestURL="/km/imissive/km_imissive_receive_main/kmImissiveReceiveMain.do?method=delete&fdId=${kmImissiveReceiveMain.fdId}" requestMethod="GET">
						<a class="btn_txt" href="javascript:deleteDoc('${kmImissiveReceiveMain.fdId}')">${lfn:message('button.delete')}</a>
					</kmss:auth>
				</div>
			</div>
		</list:data-column>
	</list:data-columns>
	<list:data-paging currentPage="${queryPage.pageno }"
		pageSize="${queryPage.rowsize }" totalSize="${queryPage.totalrows }">
	</list:data-paging>
</list:data>

