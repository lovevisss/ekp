<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<div data-dojo-type="dojox/mobile/View" id="baseinfoView">
<div data-dojo-type="mui/panel/Content">
	<div data-dojo-type="mui/table/ScrollableHContainer" data-dojo-mixins="mui/form/_AlignMixin">
		<div data-dojo-type="mui/table/ScrollableHView" class="muiFormContent">
			<c:import url="/sys/xform/mobile/import/sysForm_mobile.jsp" charEncoding="UTF-8">
				<c:param name="formName" value="kmImissiveSignMainForm" />
				<c:param name="fdKey" value="signMainDoc" />
				<c:param name="backTo" value="scrollView" />
			</c:import>
			<c:if test="${empty loadAtt and 'true' eq existAtt}">
				<c:if test="${not empty kmImissiveSignMainForm.attachmentForms['attachment'].attachments}">
					<c:choose>
						<c:when test="${kmImissiveSignMainForm.sysWfBusinessForm.fdNodeAdditionalInfo.editAtt =='true'}">
							<c:import url="/sys/attachment/mobile/import/view.jsp" charEncoding="UTF-8">
								<c:param name="formName" value="kmImissiveSignMainForm"></c:param>
								<c:param name="fdKey" value="attachment"></c:param>
								<c:param name="imissiveCanEdit" value="true"></c:param>
							</c:import>
						</c:when>
						<c:otherwise>
							<c:import url="/sys/attachment/mobile/import/view.jsp" charEncoding="UTF-8">
								<c:param name="formName" value="kmImissiveSignMainForm"></c:param>
								<c:param name="fdKey" value="attachment"></c:param>
							</c:import>
						</c:otherwise>
					</c:choose>
				</c:if>
			</c:if>
			<c:if test="${not empty kmImissiveSignMainForm.attachmentForms['yqqSigned'].attachments}">
			<c:import url="/sys/attachment/mobile/import/view.jsp" charEncoding="UTF-8">
				<c:param name="formName" value="kmImissiveSignMainForm"></c:param>
				<c:param name="fdKey" value="yqqSigned"></c:param>
				<c:param name="fdModelId" value="${param.fdId}" />
				<c:param name="fdModelName" value="com.landray.kmss.km.imissive.model.KmImissiveSignMain" />
			</c:import>
		</c:if>
		</div>
	</div>
</div>
</div>