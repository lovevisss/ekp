<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/resource/jsp/common.jsp"%>
<c:choose>
    <c:when test="${param.mobile eq 'true'}">
    	<c:import url="/sys/attachment/mobile/import/edit.jsp" charEncoding="UTF-8">
			<c:param name="fdKey" value="mainonline" />
			<c:param name="fdMulti" value="false" />
			<c:param name="fdModelId" value="${kmImeetingTopicForm.fdId}" />
			<c:param name="fdModelName" value="com.landray.kmss.km.imeeting.model.KmImeetingTopic" />
			<c:param name="formName" value="kmImeetingTopicForm"/>
			<c:param name="enabledFileType" value="doc|docx|xls|xlsx|ppt|pptx|xlc|mppx|xlcx|wps|et|vsd|rtf|pdf" />
		</c:import> 
    </c:when>
    <c:otherwise>
    	<c:import url="/sys/attachment/sys_att_main/sysAttMain_edit.jsp" charEncoding="UTF-8">
			<c:param name="fdKey" value="mainonline"/>
			<c:param name="fdMulti" value="false" />
			<c:param name="uploadAfterSelect" value="true" />  
			<c:param name="enabledFileType" value="doc,docx,xls,xlsx,ppt,pptx,xlc,mppx,xlcx,wps,et,vsd,rtf,pdf" />
			<c:param name="fdModelId" value="${kmImeetingTopicForm.fdId }" />
			<c:param name="fdModelName" value="com.landray.kmss.km.imeeting.model.KmImeetingTopic" />
		</c:import>
		<c:if test="${isAddFormOther eq 'true' and fdIsAddPdf ne 'true'}">
			<div style="font-size: smaller;color: #eb2e2eba;" class="addPdf-tip-box">
				提示：公文正文未带入到议题，可能是公文正文附件未转成PDF格式，请稍后再试或联系相关人员处理附件转换问题
			</div>
		</c:if>
    </c:otherwise>
</c:choose>