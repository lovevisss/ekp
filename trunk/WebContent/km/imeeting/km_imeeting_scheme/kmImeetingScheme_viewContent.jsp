<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="/sys/ui/jsp/common.jsp"%>
<html:hidden property="fdId" />
<html:hidden property="docStatus" />
<html:hidden property="method_GET" />
<c:choose>
	<c:when test="${kmImeetingSchemeForm.docStatus == '30' || kmImeetingSchemeForm.docStatus == '00'}">
		<ui:content title="详情" expand="true">
			<c:import url="/sys/xform/include/sysForm_view.jsp" charEncoding="UTF-8">
				<c:param name="formName" value="kmImeetingSchemeForm" />
				<c:param name="fdKey" value="ImeetingScheme" />
				<c:param name="useTab" value="false" />
			</c:import>
		</ui:content>
		<ui:content id="attPreview" title="正文">
			<div id="attachment_preview" style="height: 800px">
				<iframe width="100%" frameborder="0" height="100%" scrolling="auto" id="previewAttFrame" src="${LUI_ContextPath}/km/imeeting/km_imeeting_scheme/import/preview_noDataM.jsp"></iframe>
			</div>
		</ui:content>
		<ui:event event="indexChanged" args="data">
			if ("${kmImeetingSchemeForm.docStatus}" >= "30") {
				var panel = data.panel;
				var selectedContent = panel.contents[data.index.after];
				if (selectedContent.id == "attPreview") {
					initContentAtt();
				}
			}
		</ui:event>
	</c:when>
	<c:otherwise>
		<ui:content id="attPreview" title="正文">
			<div id="attachment_preview" style="height: 800px">
				<iframe width="100%" height="100%" frameborder="0" scrolling="auto" id="previewAttFrame" src="${LUI_ContextPath}/km/imeeting/km_imeeting_scheme/import/preview_noDataM.jsp"></iframe>
			</div>
		</ui:content>
		<ui:content title="详情" expand="true">
			<c:import url="/sys/xform/include/sysForm_view.jsp" charEncoding="UTF-8">
				<c:param name="formName" value="kmImeetingSchemeForm" />
				<c:param name="fdKey" value="ImeetingScheme" />
				<c:param name="useTab" value="false" />
			</c:import>
		</ui:content>
	</c:otherwise>
</c:choose>
	 
	 
