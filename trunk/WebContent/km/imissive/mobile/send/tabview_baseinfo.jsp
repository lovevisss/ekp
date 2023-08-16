<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<div data-dojo-type="dojox/mobile/View" id="baseinfoView">
	<div class="muiAccordionPanelContent">
		<div data-dojo-type="mui/panel/Content">
			<div data-dojo-type="mui/table/ScrollableHContainer" data-dojo-mixins="mui/form/_AlignMixin">
				<div data-dojo-type="mui/table/ScrollableHView" class="muiFormContent">
					<c:import url="/sys/xform/mobile/import/sysForm_mobile.jsp" charEncoding="UTF-8">
						<c:param name="formName" value="kmImissiveSendMainForm" />
						<c:param name="fdKey" value="sendMainDoc" />
						<c:param name="backTo" value="scrollView" />
					</c:import>
					<c:if test="${empty loadAtt and 'true' eq existAtt}">
						<c:if test="${not empty kmImissiveSendMainForm.attachmentForms['attachment'].attachments}">
							<c:choose>
								<c:when test="${kmImissiveSendMainForm.sysWfBusinessForm.fdNodeAdditionalInfo.editAtt =='true'}">
									<c:import url="/sys/attachment/mobile/import/view.jsp" charEncoding="UTF-8">
										<c:param name="formName" value="kmImissiveSendMainForm"></c:param>
										<c:param name="fdKey" value="attachment"></c:param>
										<c:param name="imissiveCanEdit" value="true"></c:param>
									</c:import>
								</c:when>
								<c:otherwise>
									<c:import url="/sys/attachment/mobile/import/view.jsp" charEncoding="UTF-8">
										<c:param name="formName" value="kmImissiveSendMainForm"></c:param>
										<c:param name="fdKey" value="attachment"></c:param>
									</c:import>
								</c:otherwise>
							</c:choose>
						</c:if>
					</c:if>
					<c:set var="fdYqqKeyPdf" value="yqqSigned" />
					<c:if test="${not empty kmImissiveSendMainForm.attachmentForms[fdYqqKeyPdf].attachments}">
						<c:import url="/sys/attachment/mobile/import/view.jsp" charEncoding="UTF-8">
							<c:param name="formName" value="kmImissiveSendMainForm"></c:param>
							<c:param name="fdKey" value="yqqSigned"></c:param>
							<c:param name="fdModelId" value="${param.fdId}" />
							<c:param name="fdModelName" value="com.landray.kmss.km.imissive.model.KmImissiveSendMain" />
						</c:import>
					</c:if>
					<c:if test="${not empty kmImissiveSendMainForm.fdMainId and not empty relatedSubject}">
						<div class="lui_form_content_frame" style="padding-top:10px">
							<div  class="lui_form_subhead">
								关联收文: <a href="#" onclick="window.open('<c:url value="/km/imissive/km_imissive_send_main/kmImissiveSendMain.do?method=view&fdId=${kmImissiveSendMainForm.fdId}&spreadAuth=true"/>');"><span class="handle_source_url"><c:out value="${relatedSubject}"></c:out></span></a>
							</div>
						</div>
					</c:if>
				</div>
			</div>
		</div>
	</div>
</div>