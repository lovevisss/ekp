<%@ page language="java" contentType="text/json; charset=UTF-8"	pageEncoding="UTF-8"%>
<%@ include file="/sys/ui/jsp/common.jsp"%>
<list:data>
	<list:data-columns var="kmImissiveSendMain" list="${queryPage.list }">
		<list:data-column property="fdId">
		</list:data-column>
		<list:data-column col="docSubject" escape="false" title="${ lfn:message('km-imissive:kmImissiveSendMain.docSubject')}" style="text-align:left;min-width:150px">
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
	<c:if test="${fdstatus!=30}">		
		<!-- 当前环节和当前处理人-->	
		<list:data-column headerClass="width80" col="nodeName" title="${ lfn:message('km-imissive:sysWfNode.processingNode.currentProcess') }" escape="false">
			<kmss:showWfPropertyValues idValue="${kmImissiveSendMain.fdId}" propertyName="nodeName" />
		</list:data-column>
		<list:data-column headerClass="width80" col="handlerName" title="${ lfn:message('km-imissive:sysWfNode.processingNode.currentProcessor') }" escape="false">
		    <kmss:showWfPropertyValues idValue="${kmImissiveSendMain.fdId}" propertyName="handlerName" />
		</list:data-column>
   </c:if>  
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
		<list:data-column headerClass="width80" col="operations" title="${ lfn:message('list.operation') }" escape="false">
			<div class="conf_show_more_w">
				<div class="conf_btn_edit">
			 		<kmss:auth requestURL="/km/imissive/km_imissive_send_main/kmImissiveSendMain.do?method=delete&fdId=${kmImissiveSendMain.fdId}" requestMethod="GET">
						<a class="btn_txt" href="javascript:deleteDoc('${kmImissiveSendMain.fdId}')">${lfn:message('button.delete')}</a>
					</kmss:auth>
				</div>
			</div>
		</list:data-column>
	</list:data-columns>
	<list:data-paging currentPage="${queryPage.pageno }"
		pageSize="${queryPage.rowsize }" totalSize="${queryPage.totalrows }">
	</list:data-paging>
</list:data>
