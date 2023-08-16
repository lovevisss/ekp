<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="/WEB-INF/kmss-xform.tld" prefix="xform"%>
<%@ include file="/sys/ui/jsp/common.jsp"%>
<%@ include file="/sys/ui/jsp/jshead.jsp"%>
<%@ include file="/resource/jsp/view_top.jsp"%>
<script>Com_IncludeFile("data.js");</script>
<script>
	function confirmDelete(msg){
	var del = confirm('<bean:message key="page.comfirmDelete"/>');
	return del;
}
</script>
<div id="optBarDiv">
	<kmss:auth requestURL="/km/imeeting/km_imeeting_topic_category/kmImeetingTopicCategory.do?method=edit&fdId=${JsParam.fdId}" requestMethod="GET">
		<input type="button"
			value="<bean:message key="button.edit"/>"
			onclick="Com_OpenWindow('kmImeetingTopicCategory.do?method=edit&fdId=${JsParam.fdId}','_self');">
	</kmss:auth>
	<kmss:auth requestURL="/km/imeeting/km_imeeting_topic_category/kmImeetingTopicCategory.do?method=delete&fdId=${JsParam.fdId}" requestMethod="GET">
		<input type="button"
			value="<bean:message key="button.delete"/>"
			onclick="if(!confirmDelete())return;Com_OpenWindow('kmImeetingTopicCategory.do?method=delete&fdId=${JsParam.fdId}','_self');">
	</kmss:auth>
	<input type="button"
		value="<bean:message key="button.close"/>"
		onclick="Com_CloseWindow();">
</div>

<p class="txttitle">${ lfn:message('km-imeeting:table.kmImeetingTopicCategory') }</p>

<center>
	<table id="Label_Tabel" width="95%" LKS_LabelDefaultIndex="2">
		<c:import url="/sys/simplecategory/include/sysCategoryMain_view.jsp"
			charEncoding="UTF-8">
			<c:param name="formName" value="kmImeetingTopicCategoryForm" />
			<c:param name="fdModelName" value="com.landray.kmss.km.imeeting.model.KmImeetingTopic" />
		</c:import>
		
       <c:import url="/sys/xform/include/sysFormTemplate_view.jsp" charEncoding="UTF-8">
           <c:param name="formName" value="kmImeetingTopicCategoryForm" />
           <c:param name="fdKey" value="mainTopic" />
           <c:param name="messageKey" value="km-imeeting:py.BiaoDanMuBan" />
           <c:param name="fdMainModelName" value="com.landray.kmss.km.imeeting.model.KmImeetingTopic" />
       </c:import>
		<!-- 流程 -->
		<c:import url="/sys/workflow/include/sysWfTemplate_view.jsp"
			charEncoding="UTF-8">
			<c:param name="formName" value="kmImeetingTopicCategoryForm" />
			<c:param name="fdKey" value="mainTopic" /> 
		</c:import>
		<tr LKS_LabelName="<bean:message bundle="sys-right" key="right.moduleName" />">
			<td>
			<table class="tb_normal" width=100%>
				<c:import url="/sys/right/tmp_right_view.jsp" charEncoding="UTF-8">
					<c:param name="formName" value="kmImeetingTopicCategoryForm" />
					<c:param name="moduleModelName" value="com.landray.kmss.km.imeeting.model.KmImeetingTopicCategory" />
				</c:import>
			</table>
			</td>
		</tr>
		<!-- 编号机制 -->
		<c:import url="/sys/number/include/sysNumberMappTemplate_view.jsp" charEncoding="UTF-8">
			<c:param name="formName" value="kmImeetingTopicCategoryForm" />
			<c:param name="modelName" value="com.landray.kmss.km.imeeting.model.KmImeetingTopic"/>
		</c:import>
	</table>
</center>
<html:hidden property="fdId" />
<html:hidden property="method_GET" />


<%@ include file="/resource/jsp/view_down.jsp"%>