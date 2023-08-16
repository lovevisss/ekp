<%@ page language="java" contentType="text/json; charset=UTF-8"	pageEncoding="UTF-8"%>
<%@ include file="/sys/ui/jsp/common.jsp"%>
<list:data>
	<list:data-columns var="kmImissiveSignMain" list="${queryPage.list }"  custom="false">
		<list:data-column property="fdId">
		</list:data-column>
		<list:data-column headerStyle="min-width: 150px;" col="docSubject" title="${ lfn:message('km-imissive:kmImissiveSignMain.docSubject') }" style="text-align:left;min-width:180px" escape="false">
			<a class="com_subject textEllipsis" title="${kmImissiveSignMain.docSubject}" href="${LUI_ContextPath}/km/imissive/km_imissive_sign_main/kmImissiveSignMain.do?method=view&fdId=${kmImissiveSignMain.fdId}" target="_blank">
			   <c:out value="${kmImissiveSignMain.docSubject}"/>
			 </a>
		</list:data-column>
		<list:data-column headerClass="width120" styleClass="width120" col="fdDocNum" title="${ lfn:message('km-imissive:kmImissiveSignMain.fdDocNum') }">
		    <c:if test="${empty kmImissiveSignMain.fdDocNum}">
				<bean:message  bundle="km-imissive" key="kmImissiveSignMain.docNum.info"/>
			</c:if>
			<c:if test="${not empty kmImissiveSignMain.fdDocNum}">
				<c:out value="${kmImissiveSignMain.fdDocNum}"/>
			</c:if>
		</list:data-column>
	  <list:data-column  headerClass="width120" styleClass="width120" property="fdDraftDept.fdName" title="${ lfn:message('km-imissive:kmImissiveSignMain.fdDraftDeptId')}">
		</list:data-column>
		<list:data-column  headerClass="width120" styleClass="width120"  col="docPublishTime" title="${ lfn:message('km-imissive:kmImissiveSignMain.docPublishTime') }">
		    <kmss:showDate value="${kmImissiveSignMain.docPublishTime}" type="date" />
		</list:data-column>
	</list:data-columns>
</list:data>
