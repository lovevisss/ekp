<%@ page language="java" contentType="text/json; charset=UTF-8"	pageEncoding="UTF-8"%>
<%@ include file="/sys/ui/jsp/common.jsp"%>
<list:data>
	<list:data-columns var="kmImissiveReceiveMain" list="${queryPage.list }" custom="false"> 
		<list:data-column property="fdId">
		</list:data-column>
		 <list:data-column col="docSubject" headerStyle="min-width: 150px;" title="${ lfn:message('km-imissive:kmImissiveReceiveMain.docSubject') }" style="text-align:left;min-width:180px" escape="false">
		   <a class="com_subject textEllipsis" title="${kmImissiveReceiveMain.docSubject}" href="${LUI_ContextPath}/km/imissive/km_imissive_receive_main/kmImissiveReceiveMain.do?method=view&fdId=${kmImissiveReceiveMain.fdId}" target="_blank">
			   <c:out value="${kmImissiveReceiveMain.docSubject}"/>
			</a>
		 </list:data-column>
		 <list:data-column headerClass="width120" styleClass="width120" col="fdReceiveNum" title="${ lfn:message('km-imissive:kmImissiveReceiveMain.fdReceiveNum') }">
		        <c:if test="${empty kmImissiveReceiveMain.fdReceiveNum}">
				    <bean:message  bundle="km-imissive" key="kmImissiveReceiveMain.fdReceiveNum.docNum.info"/>
				</c:if>
				<c:if test="${not empty kmImissiveReceiveMain.fdReceiveNum}">
					<c:out value="${kmImissiveReceiveMain.fdReceiveNum}"/>
				</c:if>
		  </list:data-column>
		  <list:data-column headerClass="width120" styleClass="width120"  col="fdSendtoUnit.fdName" title="${ lfn:message('km-imissive:kmImissiveReceiveMain.fdSendtoDept') }">
		   		<c:out value="${kmImissiveReceiveMain.fdSendtoUnit.fdName}" /><c:out value="${kmImissiveReceiveMain.fdOutSendto}" />
		  </list:data-column> 
		  <list:data-column headerClass="width100" styleClass="width100" col="fdReceiveTime" title="${ lfn:message('km-imissive:kmImissiveReceiveMain.fdReceiveTime') }">
	         <kmss:showDate value="${kmImissiveReceiveMain.fdReceiveTime}" type="date" />
		  </list:data-column>
	</list:data-columns>
</list:data>

