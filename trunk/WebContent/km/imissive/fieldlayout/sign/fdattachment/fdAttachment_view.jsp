<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/resource/jsp/common.jsp"%>	
<%@page import="com.landray.kmss.km.imissive.util.KmImissiveConfigUtil"%>
<c:if test="${not empty kmImissiveSignMainForm.attachmentForms['attachment'].attachments}">
<c:set var="loadAtt" value="true" scope="request"/>
<c:choose>
	<c:when test="${'true' eq param.isPrintGw}">
		<c:import url="/resource/html_locate/sysAttMain_view.jsp" charEncoding="UTF-8">
			<c:param name="fdMulti" value="true" />
			<c:param name="formBeanName" value="kmImissiveSignMainForm" />
			<c:param name="fdKey" value="attachment" />
		</c:import>
	</c:when>
	<c:otherwise>
		<c:choose>
			<c:when test="${param.mobile eq 'true'}">
				<c:choose>
					<c:when test="${kmImissiveSignMainForm.sysWfBusinessForm.fdNodeAdditionalInfo.editAtt =='true'}">
						<c:import url="/sys/attachment/mobile/import/view.jsp" charEncoding="UTF-8">
							<c:param name="formName" value="kmImissiveSignMainForm"></c:param>
							<c:param name="fdKey" value="attachment"></c:param>
							<c:param name="fdModelId" value="${param.fdId}" />
							<c:param name="imissiveCanEdit" value="true"></c:param>
							<c:param name="fdModelName" value="com.landray.kmss.km.imissive.model.KmImissiveReceiveMain" />
						</c:import>
					</c:when>
					<c:otherwise>
						<c:import url="/sys/attachment/mobile/import/view.jsp" charEncoding="UTF-8">
							<c:param name="formName" value="kmImissiveSignMainForm"></c:param>
							<c:param name="fdKey" value="attachment"></c:param>
							<c:param name="fdModelId" value="${param.fdId}" />
							<c:param name="fdModelName" value="com.landray.kmss.km.imissive.model.KmImissiveReceiveMain" />
						</c:import>
					</c:otherwise>
				</c:choose>
			</c:when>
			<c:otherwise>
				<%if("flat".equals(KmImissiveConfigUtil.getDisplayMode())){ %>
				<div class="lui_form_content_frame" style="padding-top:10px">
					<div>
						<c:choose>
							<c:when test="${editAtt eq true}">
								<c:import url="/sys/attachment/sys_att_main/sysAttMain_edit.jsp" charEncoding="UTF-8">
									<c:param name="formBeanName" value="kmImissiveSignMainForm" />
									<c:param name="fdKey" value="attachment" />
									<c:param name="fdModelId" value="${param.fdId}" />
									<c:param name="fdModelName" value="com.landray.kmss.km.imissive.model.KmImissiveSignMain" />
								</c:import>
							</c:when>
							<c:otherwise>
								<c:choose>
									<c:when test="${kmImissiveSignMainForm.method_GET eq 'viewXformInfo'}">
										<c:import url="/resource/html_locate/sysAttMain_view.jsp"  charEncoding="UTF-8">
											<c:param name="formBeanName" value="kmImissiveSignMainForm" />
											<c:param name="fdKey" value="attachment" />
										</c:import>
									</c:when>
									<c:otherwise>
										<c:import url="/sys/attachment/sys_att_main/sysAttMain_view.jsp"  charEncoding="UTF-8">
											<c:param name="formBeanName" value="kmImissiveSignMainForm" />
											<c:param name="fdKey" value="attachment" />
										</c:import>
									</c:otherwise>
								</c:choose>

							</c:otherwise>
						</c:choose>
					</div>
				</div>
				<%}else if("singletab".equals(KmImissiveConfigUtil.getDisplayMode())){%>
				<div style="padding-left:9px;padding-bottom: 15px;">
					<c:choose>
						<c:when test="${editAtt eq true}">
							<c:import url="/sys/attachment/sys_att_main/sysAttMain_edit.jsp" charEncoding="UTF-8">
								<c:param name="formBeanName" value="kmImissiveSignMainForm" />
								<c:param name="fdKey" value="attachment" />
								<c:param name="uploadAfterSelect" value="true" />
								<c:param name="fdModelId" value="${param.fdId}" />
								<c:param name="fdModelName" value="com.landray.kmss.km.imissive.model.KmImissiveSignMain" />
								<c:param name="fdLabel" value="文档附件" />
								<c:param name="fdGroup" value="documentAtt" />
							</c:import>
						</c:when>
						<c:otherwise>
							<c:choose>
								<c:when test="${kmImissiveSignMainForm.method_GET eq 'viewXformInfo'}">
									<c:import url="/resource/html_locate/sysAttMain_view.jsp"  charEncoding="UTF-8">
										<c:param name="formBeanName" value="kmImissiveSignMainForm" />
										<c:param name="fdKey" value="attachment" />
										<c:param name="fdModelId" value="${param.fdId}" />
										<c:param name="fdModelName" value="com.landray.kmss.km.imissive.model.KmImissiveSignMain" />
										<c:param name="fdLabel" value="文档附件" />
										<c:param name="fdGroup" value="documentAtt" />
									</c:import>
								</c:when>
								<c:otherwise>
									<c:import url="/sys/attachment/sys_att_main/sysAttMain_view.jsp" charEncoding="UTF-8">
										<c:param name="formBeanName" value="kmImissiveSignMainForm" />
										<c:param name="fdKey" value="attachment" />
										<c:param name="fdModelId" value="${param.fdId}" />
										<c:param name="fdModelName" value="com.landray.kmss.km.imissive.model.KmImissiveSignMain" />
										<c:param name="fdLabel" value="文档附件" />
										<c:param name="fdGroup" value="documentAtt" />
									</c:import>
								</c:otherwise>
							</c:choose>
						</c:otherwise>
					</c:choose>
				</div>
				<%}%>
			</c:otherwise>
		</c:choose>
	</c:otherwise>
</c:choose>

</c:if>