<%@ page language="java" contentType="text/json; charset=UTF-8"	pageEncoding="UTF-8"%>
<%@ include file="/sys/ui/jsp/common.jsp"%>
<list:data>
	<list:data-columns var="kmImissiveSendMain" list="${queryPage.list }" custom="false">
		<list:data-column property="fdId">
		</list:data-column>
		<list:data-column col="docSubject" headerStyle="min-width: 150px;" title="${ lfn:message('km-imissive:kmImissiveSendMain.docSubject') }" style="text-align:left;min-width:180px" escape="false">
			<a class="com_subject textEllipsis" title="${kmImissiveSendMain.docSubject}" href="${LUI_ContextPath}/km/imissive/km_imissive_send_main/kmImissiveSendMain.do?method=view&fdId=${kmImissiveSendMain.fdId}" target="_blank">
			   <c:out value="${kmImissiveSendMain.docSubject}"/>
			 </a>
		</list:data-column>
		<list:data-column headerClass="width140" styleClass="width140"  col="fdDocNum" title="${ lfn:message('km-imissive:kmImissiveSendMain.fdDocNum') }">
		    <c:if test="${empty kmImissiveSendMain.fdDocNum}">
				<bean:message  bundle="km-imissive" key="kmImissiveSendMain.docNum.info"/>
			</c:if>
			<c:if test="${not empty kmImissiveSendMain.fdDocNum}">
				<c:out value="${kmImissiveSendMain.fdDocNum}"/>
			</c:if>
		</list:data-column>
		
 		<list:data-column  headerClass="width120" styleClass="width120" property="fdDrafter.fdName" title="${ lfn:message('km-imissive:kmImissiveSendMain.fdDraftId')}">
		</list:data-column>
		<list:data-column headerClass="width120" styleClass="width120"  col="docPublishTime" title="${ lfn:message('km-imissive:kmImissiveSendMain.docPublishTime') }">
		    <kmss:showDate value="${kmImissiveSendMain.docPublishTime}" type="date" />
		</list:data-column>
	</list:data-columns>
</list:data>
