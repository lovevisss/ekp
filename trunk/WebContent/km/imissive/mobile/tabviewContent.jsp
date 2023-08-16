<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<c:choose>
	<c:when test="${'0' eq _onlineToolType and '0' eq _jGForMobile}">
		<c:import url="/sys/attachment/mobile/import/viewContent.jsp" charEncoding="UTF-8">
			<c:param name="formName" value="${formImissiveMainForm}"></c:param>
			<c:param name="fdKey" value="${contentKey}"></c:param>
			<c:param  name="contentFlag"  value="true"/>
			<c:param name="editContent" value="${editContent}"></c:param>
		</c:import>
	</c:when>
	<c:when test="${canViewOnline eq 'true' and _isWpsCloudEnable eq 'true'}">
		<c:choose>
			<c:when test="${not empty _formBean.attachmentForms[signedKey].attachments}">
				<c:import url="/sys/attachment/mobile/viewer/wps/cloud/sysAttMain_view.jsp" charEncoding="UTF-8">
					<c:param name="fdKey" value="${signedKey}" />
					<c:param name="fdModelId" value="${fdJgConvertModelId}" />
					<c:param name="fdAttImissiveId" value="${attId}" />
					<c:param name="fdModelName" value="${fdJgConvertModelName}" />
					<c:param name="formBeanName" value="${formImissiveMainForm}" />
					<c:param name="load" value="false" />
				</c:import>
			</c:when>
			<c:when test="${canEditOnline and editContent eq 'true'}">
				<c:import url="/sys/attachment/mobile/viewer/wps/cloud/sysAttMain_edit.jsp" charEncoding="UTF-8">
					<c:param name="fdKey" value="${contentKey}" />
					<c:param name="fdModelId" value="${fdJgConvertModelId}" />
					<c:param name="fdModelName" value="${fdJgConvertModelName}" />
					<c:param name="formBeanName" value="${formImissiveMainForm}" />
					<c:param name="load" value="false" />
				</c:import>
			</c:when>
			<c:otherwise>
				<c:import url="/sys/attachment/mobile/viewer/wps/cloud/sysAttMain_view.jsp" charEncoding="UTF-8">
					<c:param name="fdKey" value="${contentKey}" />
					<c:param name="fdModelId" value="${fdJgConvertModelId}" />
					<c:param name="fdModelName" value="${fdJgConvertModelName}" />
					<c:param name="formBeanName" value="${formImissiveMainForm}" />
					<c:param name="load" value="false" />
				</c:import>
			</c:otherwise>
		</c:choose>
	</c:when>
	<c:when test="${canViewOnline eq 'true' and _isWpsCenterEnable eq 'true'}">
		<c:choose>
			<c:when test="${not empty _formBean.attachmentForms[signedKey].attachments}">
				<c:import url="/sys/attachment/mobile/viewer/wps/center/sysAttMain_view.jsp" charEncoding="UTF-8">
					<c:param name="fdKey" value="${signedKey}" />
					<c:param name="fdModelId" value="${fdJgConvertModelId}" />
					<c:param name="fdAttImissiveId" value="${attId}" />
					<c:param name="fdModelName" value="${fdJgConvertModelName}" />
					<c:param name="formBeanName" value="${formImissiveMainForm}" />
					<c:param name="load" value="false" />
				</c:import>
			</c:when>
			<c:when test="${canEditOnline and editContent eq 'true'}">
				<c:import url="/sys/attachment/mobile/viewer/wps/center/sysAttMain_edit.jsp" charEncoding="UTF-8">
					<c:param name="fdKey" value="${contentKey}" />
					<c:param name="fdModelId" value="${fdJgConvertModelId}" />
					<c:param name="fdModelName" value="${fdJgConvertModelName}" />
					<c:param name="formBeanName" value="${formImissiveMainForm}" />
					<c:param name="load" value="false" />
				</c:import>
			</c:when>
			<c:otherwise>
				<c:import url="/sys/attachment/mobile/viewer/wps/center/sysAttMain_view.jsp" charEncoding="UTF-8">
					<c:param name="fdKey" value="${contentKey}" />
					<c:param name="fdModelId" value="${fdJgConvertModelId}" />
					<c:param name="fdModelName" value="${fdJgConvertModelName}" />
					<c:param name="formBeanName" value="${formImissiveMainForm}" />
					<c:param name="load" value="false" />
				</c:import>
			</c:otherwise>
		</c:choose>
	</c:when>
	<c:when test="${(_wpsPreviewIsLinux eq 'true' and '2' eq _readOLConfig) or 'true' eq hasViewer}">
		<c:import url="/sys/attachment/mobile/viewer/wps/cloud/sysAttMain_view.jsp" charEncoding="UTF-8">
			<c:param name="fdKey" value="${contentKey}" />
			<c:param name="fdModelId" value="${fdJgConvertModelId}" />
			<c:param name="fdModelName" value="${fdJgConvertModelName}" />
			<c:param name="formBeanName" value="${formImissiveMainForm}" />
			<c:param name="load" value="false" />
		</c:import>
	</c:when>
	<c:when test="${(_isWpsCenterBt eq 'true' and '5' eq _readOLConfig) or 'true' eq hasViewer}">
		<c:import url="/sys/attachment/mobile/viewer/wps/center/sysAttMain_view.jsp" charEncoding="UTF-8">
			<c:param name="fdKey" value="${contentKey}" />
			<c:param name="fdModelId" value="${fdJgConvertModelId}" />
			<c:param name="fdModelName" value="${fdJgConvertModelName}" />
			<c:param name="formBeanName" value="${formImissiveMainForm}" />
			<c:param name="load" value="false" />
		</c:import>
	</c:when>
	<c:otherwise>
		<c:if test="${not empty _formBean.attachmentForms[signedKey].attachments}">
			<c:set var="contentKey" value="${signedKey}"/>
		</c:if>
		<c:import url="/sys/attachment/mobile/import/viewContent.jsp" charEncoding="UTF-8">
			<c:param name="formName" value="${formImissiveMainForm}"></c:param>
			<c:param name="fdKey" value="${contentKey}"></c:param>
			<c:param  name="contentFlag"  value="true"/>
			<c:param name="editContent" value="${editContent}"></c:param>
		</c:import>
	</c:otherwise>
</c:choose>

<script type="text/javascript" >
	require(['dojo/topic'],function(topic){
		if("${_isWpsCloudEnable}" == 'true'){
			topic.subscribe('/sys/attachment/wpsCloud/loaded',function(obj,evt){
				if(evt && evt.height){
					obj.iframe.style.height = (evt.height-45) + "px";
				}
			});
		}
		if("${_isWpsCenterEnable}" == 'true'){
			topic.subscribe('/sys/attachment/wpsCenter/loaded',function(obj,evt){
				if(evt && evt.height){
					obj.iframe.style.height = (evt.height-45) + "px";
				}
			});
		}
	});
</script>
