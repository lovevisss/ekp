<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="/sys/ui/jsp/common.jsp"%>

<table class="tb_normal" width="100%" >
	<tr>
		<td width="15%" class="td_normal_title">
			<bean:message bundle="km-imeeting" key="kmImeetingTopic.docSubject"/>
		</td>
		<td colspan="3">
			<c:out value="${kmImeetingTopicForm.docSubject}"></c:out>
		</td>
	</tr>
	<tr>
		<td width="15%" class="td_normal_title">
			<bean:message bundle="km-imeeting" key="kmImeetingTopic.fdTopicCategory"/>
		</td>
		<td  width="35%">	
			<html:hidden property="fdTopicCategoryId"/>
			<c:out value="${kmImeetingTopicForm.fdTopicCategoryName}"></c:out>
		</td>
		<td width="15%" class="td_normal_title">
			<bean:message bundle="km-imeeting" key="kmImeetingTopic.fdNo"/>
		</td>
		<td  width="35%">
			<c:if test="${kmImeetingTopicForm.docStatus==10 || kmImeetingTopicForm.docStatus==null || kmImeetingTopicForm.docStatus=='' }">
			   提交后自动生成
			</c:if>
			<c:if test="${(not empty kmImeetingTopicForm.docNumber) && kmImeetingTopicForm.docStatus!=10 }">
             	 	${ kmImeetingTopicForm.docNumber}
          	</c:if>
		</td>
	</tr>
	<tr>
		<td width="15%" class="td_normal_title">
			<bean:message bundle="km-imeeting" key="kmImeetingTopic.fdReporter"/>
		</td>
		<td  width="35%">
			<c:out value="${kmImeetingTopicForm.fdReporterName}"></c:out>
		</td>
		<td width="15%" class="td_normal_title">
			<bean:message bundle="km-imeeting" key="kmImeetingTopic.fdChargeUnit"/>
		</td>
		<td  width="35%">
			<c:out value="${kmImeetingTopicForm.fdChargeUnitName}"></c:out>
		</td>
	</tr>
	<tr>
		<td width="15%" class="td_normal_title">
			<bean:message bundle="km-imeeting" key="kmImeetingTopic.fdMaterialStaff"/>
		</td>
		<td  width="35%">
			<c:out value="${kmImeetingTopicForm.fdMaterialStaffName}"></c:out>
		</td>
		<td width="15%" class="td_normal_title">
			<bean:message bundle="km-imeeting" key="kmImeetingTopic.fdSourceSubject"/>
		</td>
		<td  width="35%">
			<c:out value="${kmImeetingTopicForm.fdSourceSubject}"></c:out>
		</td>
	</tr>
	<tr>
		<td width="15%" class="td_normal_title">
			<bean:message bundle="km-imeeting" key="kmImeetingTopic.fdAttendUnit"/>
		</td>
		<td  width="85%" colspan="3">
			 <c:out value="${kmImeetingTopicForm.fdAttendUnitNames}"></c:out>
		</td>
	</tr>
	<tr>
		<td width="15%" class="td_normal_title">
			<bean:message bundle="km-imeeting" key="kmImeetingTopic.fdListenUnit"/>
		</td>
		<td  width="85%" colspan="3">
			 <c:out value="${kmImeetingTopicForm.fdListenUnitNames}"></c:out>
		</td>
	</tr>
	<tr>
		<td width="15%" class="td_normal_title">
			<bean:message bundle="km-imeeting" key="kmImeetingTopic.issue.text"/>
		</td>
		<td colspan="3">
			<c:import url="/sys/attachment/sys_att_main/sysAttMain_view.jsp" charEncoding="UTF-8">
				<c:param name="fdKey" value="mainonline"/>
				<c:param  name="fdMulti" value="false" />
				<c:param name="uploadAfterSelect" value="true" />  
				<c:param name="fdModelId" value="${kmImeetingTopicForm.fdId }" />
				<c:param name="fdModelName" value="com.landray.kmss.km.imeeting.model.KmImeetingTopic" />
			</c:import>
		</td>
	</tr>
	<tr>
		<td width="15%" class="td_normal_title">
			<bean:message bundle="km-imeeting" key="kmImeetingTopic.issue.material"/>
		</td>
		<td colspan="3">
			<c:import url="/sys/attachment/sys_att_main/sysAttMain_view.jsp" charEncoding="UTF-8">
				<c:param name="fdKey" value="attachment" />
				<c:param name="uploadAfterSelect" value="true" />  
				<c:param name="fdModelId" value="${kmImeetingTopicForm.fdId }" />
				<c:param name="fdModelName" value="com.landray.kmss.km.imeeting.model.KmImeetingTopic" />
			</c:import>
		</td>
	</tr>	
	<tr>
		<td width="15%" class="td_normal_title">
			<bean:message bundle="km-imeeting" key="kmImeetingTopic.fdContent"/>
		</td>
		<td  width="85%" colspan="3">
			<xform:textarea property="fdContent" style="width:97.5%;height:80px" validators="senWordsValidator(kmImeetingTopicForm)"/>
		</td>
	</tr>
</table>