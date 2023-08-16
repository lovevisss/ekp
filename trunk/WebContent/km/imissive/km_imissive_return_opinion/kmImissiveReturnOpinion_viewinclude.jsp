<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="/sys/ui/jsp/common.jsp"%>
<table class="tb_normal" width=95% style="margin-top:20px">
	<tr>
		<td class="td_normal_title" width=15%>
			<bean:message  bundle="km-imissive" key="kmImissiveReturnOpinion.fdUnitName"/>
		</td>
		<td width=35% >
			<c:out value="${kmImissiveReturnOpinionForm.fdUnitName}"></c:out>
		</td>
		<td class="td_normal_title" width=15%>
			<bean:message  bundle="km-imissive" key="kmImissiveReturnOpinion.docCreateTime"/>
		</td>
		<td width=35%>
			<c:out value="${kmImissiveReturnOpinionForm.docCreateTime}"></c:out>
		</td>
	</tr>
	<tr>
		<td class="td_normal_title" width=15%>
			<bean:message  bundle="km-imissive" key="kmImissiveReturnOpinion.docContent"/>
		</td>
		<td width=85% colspan="3">
			<xform:textarea property="docContent"></xform:textarea>
		</td>
	</tr>
	<c:if test="${fn:length(kmImissiveReturnOpinionForm.attachmentForms['opinionAtt'].attachments)>0}">
		<tr>
			<td class="td_normal_title" width=15%>
				意见附件
			</td>
			<td width=85% colspan="3">
				<c:import url="/sys/attachment/sys_att_main/sysAttMain_view.jsp" charEncoding="UTF-8">
					<c:param name="fdKey" value="opinionAtt" />
					<c:param name="fdMulti" value="true" />
					<c:param name="formBeanName" value="kmImissiveReturnOpinionForm" />
					<c:param name="fdModelId" value="${kmImissiveReturnOpinionForm.fdId }" />
					<c:param name="fdModelName" value="com.landray.kmss.km.imissive.model.KmImissiveReturnOpinion" />
				</c:import>
			</td>
		</tr>
	</c:if>
	<c:if test="${fn:length(kmImissiveReturnOpinionForm.fdAuditNoteListForms)>0}">
		<tr>
		    <td colspan="4">
			<div class="lui_form_subhead" style="padding:10px 8px ">审批意见:</div> 
			<table style="width:100%" class="tb_normal">
				<tr class="tr_normal">
					<td width="12%" class="td_normal_title">
						<bean:message bundle="sys-lbpmservice-support" key="lbpmAuditNote.list.date" />
					</td>
					<td width="15%" class="td_normal_title">
						<bean:message bundle="sys-lbpmservice-support" key="lbpmAuditNote.list.fdHandlerId" />
					</td>
					<td width="15%" class="td_normal_title">
						审批人部门
					</td>
					<td width="43%" class="td_normal_title">
						<bean:message bundle="sys-lbpmservice-support" key="lbpmAuditNote.list.fdAuditNote" />
					</td>
				</tr>
				<c:forEach items="${kmImissiveReturnOpinionForm.fdAuditNoteListForms}" var="opinion" varStatus="vsStatus">
					<tr>
						<td>
							<c:out value="${opinion.fdApprovalTime}"></c:out>
						</td>
						<td>
							<c:out value="${opinion.fdApprover}"></c:out>
						</td>
						<td>
							<c:out value="${opinion.fdApproverDept}"></c:out>
						</td>
						<td>
							<table class="tb_noborder" width="100%">
								<tr>
									<td style="word-wrap: break-word;word-break: break-all;">
										${opinion.fdContent}
									</td>
								</tr>
								<c:import url="/sys/attachment/import/OpinionAtt/sysAttMain_view_qz.jsp" charEncoding="UTF-8">
									<c:param name="fdKey" value="${opinion.fdApprovalRecodeId}_qz"/>
									<c:param name="formBeanName" value="kmImissiveReturnOpinionForm"/>
									<c:param name="fdModelName" value="com.landray.kmss.km.imissive.model.KmImissiveReturnOpinion" />
									<c:param name="fdModelId" value="${kmImissiveReturnOpinionForm.fdId}" />
								</c:import>
								<c:import url="/sys/attachment/import/OpinionAtt/sysAttMain_view_hw.jsp" charEncoding="UTF-8">
										<c:param name="fdKey" value="${opinion.fdApprovalRecodeId}_hw"/>
										<c:param name="formBeanName" value="kmImissiveReturnOpinionForm"/>
										<c:param name="fdAttType" value="pic"></c:param>
										<c:param name="fdExtendClass" value="muiAuditHandLog"/>
										<c:param name="fdModelName" value="com.landray.kmss.km.imissive.model.KmImissiveReturnOpinion" />
										<c:param name="fdModelId" value="${kmImissiveReturnOpinionForm.fdId}" />
								</c:import>
								<tr>	
									<td>
										<c:import url="/sys/attachment/sys_att_main/sysAttMain_view.jsp" charEncoding="UTF-8">
											<c:param name="fdKey" value="${opinion.fdApprovalRecodeId}_sp"/>
											<c:param name="formBeanName" value="kmImissiveReturnOpinionForm"/>
											<c:param name="fdViewType" value="simple" />
											<c:param name="fdModelName" value="com.landray.kmss.km.imissive.model.KmImissiveReturnOpinion" />
											<c:param name="fdModelId" value="${kmImissiveReturnOpinionForm.fdId}" />
										   	<c:param name="fdForceDisabledOpt" value="edit" />
										</c:import>
									</td>
								</tr>
								<tr>	
									<td>
										<c:import url="/sys/attachment/sys_att_main/sysAttMain_view.jsp" charEncoding="UTF-8">
											<c:param name="fdKey" value="${opinion.fdApprovalRecodeId}_sq"/>
											<c:param name="formBeanName" value="kmImissiveReturnOpinionForm"/>
											<c:param name="fdViewType" value="simple" />
											<c:param name="fdModelName" value="com.landray.kmss.km.imissive.model.KmImissiveReturnOpinion" />
											<c:param name="fdModelId" value="${kmImissiveReturnOpinionForm.fdId}" />
										   	<c:param name="fdForceDisabledOpt" value="edit" />
										</c:import>
									</td>
								</tr>
								<tr>	
									<td>
										<c:import url="/sys/attachment/sys_att_main/sysAttMain_view.jsp" charEncoding="UTF-8">
								          <c:param name="formBeanName" value="kmImissiveReturnOpinionForm"/>
								          <c:param name="fdKey" value="${opinion.fdApprovalRecodeId}"/>
								          <c:param name="fdModelId" value="${opinion.fdId}"/>
								          <c:param name="fdModelName" value="com.landray.kmss.km.imissive.model.KmImissiveReturnOpinion"/>
								          <c:param name="fdViewType" value="byte" />
								          <c:param name="fdForceDisabledOpt" value="edit" />
								        </c:import>
									</td>
								</tr>
							</table>
						</td>
					</tr>
				</c:forEach>
			</table>
			</td>
		</tr>
	</c:if>
</table>