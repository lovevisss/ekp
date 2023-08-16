<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/sys/ui/jsp/common.jsp"%>
<ui:content title="${lfn:message('km-imissive:kmImissiveSendMain.baseinfo')}" titleicon="lui-fm-icon-2">
	<table class="tb_normal lui-fm-noneBorderTable" width=100%>
		<tr>
			<td class="tr_normal_title" width=30%>
				<bean:message bundle="km-imissive" key="kmImissiveSendMain.fdDraftId" />
			</td>
			<td>
				<c:out  value="${kmImissiveSendMainForm.fdDrafterName }"></c:out>
			</td>
		</tr>
		<tr>
			<td class="tr_normal_title" width=30%>
				<bean:message bundle="km-imissive" key="kmImissiveSendMain.fdDraftDeptId2" />
			</td>
			<td>
				<c:out  value="${kmImissiveSendMainForm.fdDraftDeptName }"></c:out>
			</td>
		</tr>
		<tr>
			<td class="tr_normal_title" width=30%>
				<bean:message bundle="km-imissive" key="kmImissiveSendMain.fdDraftTime" />
			</td>
			<td>
				<c:out  value="${kmImissiveSendMainForm.fdDraftTime}"></c:out>
			</td>
		</tr>
		<tr>
			<td class="tr_normal_title" width=30%>
				<bean:message bundle="km-imissive" key="kmImissiveSendMain.docStatus" />
			</td>
			<td>
				<sunbor:enumsShow value="${kmImissiveSendMainForm.docStatus}" enumsType="kmImissive_common_status" />
			</td>
		</tr>
		<tr>
			<td class="tr_normal_title" width=30%>
				<bean:message bundle="km-imissive" key="kmImissiveSendMain.fdDocNum" />
			</td>
			<td>
				 <c:if test="${not empty kmImissiveSendMainForm.fdDocNum}">
				   <c:out value="${kmImissiveSendMainForm.fdDocNum}"/>
				</c:if>
				 <c:if test="${empty kmImissiveSendMainForm.fdDocNum}">
				   <bean:message  bundle="km-imissive" key="kmImissiveSendMain.docNum.info"/>
				</c:if>
			</td>
		</tr>
		<%-- 所属场所 --%>
		<c:import url="/sys/authorization/sys_auth_area/sysAuthArea_field.jsp" charEncoding="UTF-8">
               <c:param name="id" value="${kmImissiveSendMainForm.authAreaId}"/>
               <c:param name="rightModel" value="true"/>
           </c:import> 
	</table>
</ui:content>