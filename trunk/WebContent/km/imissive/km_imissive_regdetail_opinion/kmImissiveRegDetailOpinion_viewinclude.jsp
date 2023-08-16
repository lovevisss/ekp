<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="/sys/ui/jsp/common.jsp"%>
<table class="tb_normal" width=95%>
	<tr>
		<td class="td_normal_title" width=15%>
			<bean:message  bundle="km-imissive" key="kmImissiveReturnOpinion.fdUnitName"/>
		</td>
		<td width=85% colspan="3">
			<c:out value="${kmImissiveRegDetailOpinionForm.fdUnitName}"></c:out>
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
	<tr>
		<td class="td_normal_title" width=15%>
			<bean:message  bundle="km-imissive" key="kmImissiveReturnOpinion.docCreator"/>
		</td>
		<td width=35%>
			<c:out value="${kmImissiveRegDetailOpinionForm.docCreatorName}"></c:out>
		</td>
		<td class="td_normal_title" width=15%>
			<bean:message  bundle="km-imissive" key="kmImissiveReturnOpinion.docCreateTime"/>
		</td>
		<td width=35%>
			<c:out value="${kmImissiveRegDetailOpinionForm.docCreateTime}"></c:out>
		</td>
	</tr>
	<tr>
		<td class="td_normal_title" width=15%>
			意见附件
		</td>
		<td width=85% colspan="3">
			<c:import url="/sys/attachment/sys_att_main/sysAttMain_view.jsp" charEncoding="UTF-8">
				<c:param name="fdKey" value="opinionAtt" />
				<c:param name="formBeanName" value="kmImissiveRegDetailOpinionForm" />
				<c:param name="fdModelId" value="${kmImissiveRegDetailOpinionForm.fdId }" />
				<c:param name="fdModelName" value="com.landray.kmss.km.imissive.model.KmImissiveRegDetailOpinion" />
			</c:import>
		</td>
	</tr>
	<tr>
		<td colspan="4" style="border:none">
			<div style="margin-top: 15px;">
				<c:import url="/km/imissive/km_imissive_regdetail_opinion/kmImissiveRegDetailOpinion_listNote.jsp" charEncoding="UTF-8">
					<c:param name="fdMainId" value="${kmImissiveRegDetailOpinionForm.fdImissiveId}" />
					<c:param name="fdModelName" value="com.landray.kmss.km.imissive.model.KmImissiveReceiveMain" />
					<c:param name="formBeanName" value="kmImissiveReceiveMainForm"/>
					<c:param name="fdOpinionId" value="${kmImissiveRegDetailOpinionForm.fdId}" />
				</c:import>
			</div>
		</td>
	</tr>
</table>