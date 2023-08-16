<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="/sys/ui/jsp/common.jsp"%>

<table class="muiSimple" cellpadding="0" cellspacing="0">
	<tr>
		<td class="muiTitle">
			<bean:message bundle="km-imeeting" key="kmImeetingTopic.docSubject"/>
		</td>
		<td>
			<c:out value="${kmImeetingTopicForm.docSubject}"/>
		</td>
	</tr>
	<tr>
		<td class="muiTitle">
			<bean:message bundle="km-imeeting" key="kmImeetingTopic.fdTopicCategory"/>
		</td>
		<td>
			<div>
				<html:hidden property="fdTopicCategoryId"/>
				<span>
					<c:out value="${kmImeetingTopicForm.fdTopicCategoryName}"></c:out>
				</span>
			</div>
		</td>
	</tr>
	<tr>
		<td class="muiTitle">
			<bean:message bundle="km-imeeting" key="kmImeetingTopic.fdNo"/>
		</td>
		<td>
			<c:choose>
				<c:when test="${not empty kmImeetingTopicForm.docNumber}">
					<c:out value="${kmImeetingTopicForm.docNumber}"></c:out>
				</c:when>
				<c:otherwise>
					<span style="float: right;margin-right: 1.2rem;">
						<c:out value="${lfn:message('km-imeeting:kmImeetingTopic.docNumber.edit')}"></c:out>
					</span>
				</c:otherwise>
			</c:choose>
		</td>
	</tr>
	<tr>
		<td class="muiTitle">
			<bean:message bundle="km-imeeting" key="kmImeetingTopic.fdReporter"/>
		</td>
		<td>
			<xform:address 
				propertyId="fdReporterId" 
				propertyName="fdReporterName" 
				subject="${lfn:message('km-imeeting:kmImeetingTopic.fdReporter')}" 
				orgType="ORG_TYPE_PERSON" 
				required="true" 
				showStatus="view"
				mobile="true" />
		</td>
	</tr>
	<tr>
		<td class="muiTitle">
			<bean:message bundle="km-imeeting" key="kmImeetingTopic.fdChargeUnit"/>
		</td>
		<td>
			<xform:address
				propertyName="fdChargeUnitName" 
				propertyId="fdChargeUnitId" 
				required="true"
				showStatus="view"
				orgType="ORG_TYPE_ORGORDEPT"
				mobile="true" />
		</td>
	</tr>
	<tr>
		<td class="muiTitle">
			<bean:message bundle="km-imeeting" key="kmImeetingTopic.fdMaterialStaff"/>
		</td>
		<td>
			<xform:address 
				propertyId="fdMaterialStaffId" 
				propertyName="fdMaterialStaffName" 
				orgType="ORG_TYPE_PERSON" 
				required="true" 
				showStatus="view"
				mobile="true" />
		</td>
	</tr>
	<tr>
		<td class="muiTitle">
			<bean:message bundle="km-imeeting" key="kmImeetingTopic.fdSourceSubject"/>
		</td>
		<td>
			<xform:text property="fdSourceSubject" showStatus="view" mobile="true" />
		</td>
	</tr>
	<tr>
		<td class="muiTitle">
			<bean:message bundle="km-imeeting" key="kmImeetingTopic.fdAttendUnit"/>
		</td>
		<td>
			<html:hidden property="fdAttendUnitIds" value="${kmImeetingTopicForm.fdAttendUnitIds}" />
			<c:out value="${kmImeetingTopicForm.fdAttendUnitNames}"></c:out>
		</td>
	</tr>
	<tr>
		<td class="muiTitle">
			<bean:message bundle="km-imeeting" key="kmImeetingTopic.fdListenUnit"/>
		</td>
		<td>
			<html:hidden property="fdListenUnitIds" value="${kmImeetingTopicForm.fdListenUnitIds}" />
			<c:out value="${kmImeetingTopicForm.fdListenUnitNames}"></c:out>
		</td>
	</tr>
	<tr>
		<td class="muiTitle">
			<bean:message bundle="km-imeeting" key="kmImeetingTopic.issue.text"/>
		</td>
		<td>
			<c:import url="/sys/attachment/mobile/import/view.jsp" charEncoding="UTF-8">
				<c:param name="fdKey" value="mainonline" />
				<c:param  name="fdMulti" value="false" />
				<c:param name="fdModelId" value="${kmImeetingTopicForm.fdId}" />
				<c:param name="fdModelName" value="com.landray.kmss.km.imeeting.model.KmImeetingTopic" />
				<c:param name="formName" value="kmImeetingTopicForm"/>
				<c:param name="enabledFileType" value="doc,docx,xls,xlsx,ppt,pptx,xlc,mppx,xlcx,wps,et,vsd,rtf,pdf" />
			</c:import>
		</td>
	</tr>
	<tr>
		<td class="muiTitle">
			<bean:message bundle="km-imeeting" key="kmImeetingTopic.issue.material"/>
		</td>
		<td>
			<c:import url="/sys/attachment/mobile/import/view.jsp" charEncoding="UTF-8">
				<c:param name="fdKey" value="attachment" />
				<c:param name="fdModelId" value="${kmImeetingTopicForm.fdId}" />
				<c:param name="fdModelName" value="com.landray.kmss.km.imeeting.model.KmImeetingTopic" />
				<c:param name="formName" value="kmImeetingTopicForm"/>
				<c:param name="enabledFileType" value="doc,docx,xls,xlsx,ppt,pptx,xlc,mppx,xlcx,wps,et,vsd,rtf,pdf" />
			</c:import>
		</td>
	</tr>
</table>