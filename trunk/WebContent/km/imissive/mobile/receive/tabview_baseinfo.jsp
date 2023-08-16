<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<div data-dojo-type="dojox/mobile/View" id="baseinfoView">
	<div data-dojo-type="mui/panel/Content">
		<div data-dojo-type="mui/table/ScrollableHContainer" data-dojo-mixins="mui/form/_AlignMixin">
			<div data-dojo-type="mui/table/ScrollableHView" class="muiFormContent">
				<c:import url="/sys/xform/mobile/import/sysForm_mobile.jsp" charEncoding="UTF-8">
					<c:param name="formName" value="kmImissiveReceiveMainForm" />
					<c:param name="fdKey" value="receiveMainDoc" />
					<c:param name="backTo" value="scrollView" />
				</c:import>
				<c:if test="${empty loadAtt and 'true' eq existAtt}">
					<c:if test="${not empty kmImissiveReceiveMainForm.attachmentForms['attachment'].attachments}">
						<c:choose>
							<c:when test="${kmImissiveReceiveMainForm.sysWfBusinessForm.fdNodeAdditionalInfo.editAtt =='true'}">
								<c:import url="/sys/attachment/mobile/import/view.jsp" charEncoding="UTF-8">
									<c:param name="formName" value="kmImissiveReceiveMainForm"></c:param>
									<c:param name="fdKey" value="attachment"></c:param>
									<c:param name="imissiveCanEdit" value="true"></c:param>
								</c:import>
							</c:when>
							<c:otherwise>
								<c:import url="/sys/attachment/mobile/import/view.jsp" charEncoding="UTF-8">
									<c:param name="formName" value="kmImissiveReceiveMainForm"></c:param>
									<c:param name="fdKey" value="attachment"></c:param>
								</c:import>
							</c:otherwise>
						</c:choose>
					</c:if>
				</c:if>
				<c:if test="${not empty kmImissiveReceiveMainForm.fdMainId and empty kmImissiveReceiveMainForm.fdDetailId and not empty relatedSubject}">
					<div class="lui_form_content_frame" style="padding-top:10px">
						<div  class="lui_form_subhead">
							关联收文: <a href="#" onclick="window.open('<c:url value="/km/imissive/km_imissive_receive_main/kmImissiveReceiveMain.do?method=view&fdId=${kmImissiveReceiveMainForm.fdId}&spreadAuth=true"/>');"><span class="handle_source_url"><c:out value="${relatedSubject}"></c:out></span></a>
						</div>
					</div>
				</c:if>
			</div>
		</div>
		<c:if test="${not empty fdModelId and not empty fdModelName and not empty formBeanName and not empty fdRegId }">
			<div style="font-weight: bold; margin: 1rem 0px;"><bean:message  bundle="km-imissive" key="kmImissiveReg.signRecord"/>:</div>
			<c:import url="/km/imissive/mobile/import/kmImissiveReg_listNote.jsp" charEncoding="UTF-8">
				<c:param name="fdMainId" value="${fdModelId}" />
				<c:param name="fdModelName" value="${fdModelName}" />
				<c:param name="formBeanName" value="${formBeanName}"/>
				<c:param name="fdRegId" value="${fdRegId}" />
				<c:param name="showCheckBox" value="false" />
			</c:import>
		</c:if>
		<c:if test="${not empty kmImissiveReceiveMainForm.attachmentForms['yqqSigned'].attachments}">
			<c:import url="/sys/attachment/mobile/import/view.jsp" charEncoding="UTF-8">
				<c:param name="formName" value="kmImissiveReceiveMainForm"></c:param>
				<c:param name="fdKey" value="yqqSigned"></c:param>
				<c:param name="fdModelId" value="${param.fdId}" />
				<c:param name="fdModelName" value="com.landray.kmss.km.imissive.model.KmImissiveReceiveMain" />
			</c:import>
		</c:if>
	</div>
	
</div>