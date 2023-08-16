<%@ page language="java" contentType="text/json; charset=UTF-8"	pageEncoding="UTF-8"%>
<%@ include file="/sys/ui/jsp/common.jsp"%>
<list:data>
	<list:data-columns var="kmImissiveSignMain" list="${queryPage.list }">
		<list:data-column property="fdId">
		</list:data-column>
		<list:data-column col="docSubject" escape="false" title="${lfn:message('km-imissive:kmImissiveSignMain.docSubject')}" style="text-align:left">
		      <span class="com_subject"><c:out value="${kmImissiveSignMain.docSubject}"/></span>
		</list:data-column>
		<list:data-column headerStyle="width:150px" col="fdDocNum" title="${lfn:message('km-imissive:kmImissiveSignMain.fdDocNum')}">
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
		<list:data-column headerStyle="width:40px" col="fdDrafter.fdName" title="${lfn:message('km-imissive:kmImissiveSignMain.fdDraftId')}" escape="false">
		   <ui:person personId="${kmImissiveSignMain.fdDrafter.fdId}" personName="${kmImissiveSignMain.fdDrafter.fdName}"></ui:person> 
		</list:data-column>
		<list:data-column headerStyle="width:100px"  col="fdDraftTime" title="${lfn:message('km-imissive:kmImissiveSignMain.fdDraftTime')}">
		    <kmss:showDate value="${kmImissiveSignMain.fdDraftTime}" type="date" />
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
			<kmss:showWfPropertyValues idValue="${kmImissiveSignMain.fdId}" propertyName="nodeName" />
		</list:data-column>
		<list:data-column headerStyle="width:80px" col="handlerName" title="${ lfn:message('km-imissive:sysWfNode.processingNode.currentProcessor') }" escape="false">
		    <kmss:showWfPropertyValues idValue="${kmImissiveSignMain.fdId}" propertyName="handlerName" />
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
		<list:data-column headerClass="width80" col="operations" title="${ lfn:message('list.operation') }" escape="false">
			<div class="conf_show_more_w">
				<div class="conf_btn_edit">
			 		<kmss:auth requestURL="/km/imissive/km_imissive_sign_main/kmImissiveSignMain.do?method=delete&fdId=${kmImissiveSignMain.fdId}" requestMethod="GET">
						<a class="btn_txt" href="javascript:deleteDoc('${kmImissiveSignMain.fdId}')">${lfn:message('button.delete')}</a>
					</kmss:auth>
				</div>
			</div>
		</list:data-column>
	</list:data-columns>
	<list:data-paging currentPage="${queryPage.pageno }"
		pageSize="${queryPage.rowsize }" totalSize="${queryPage.totalrows }">
	</list:data-paging>
</list:data>
