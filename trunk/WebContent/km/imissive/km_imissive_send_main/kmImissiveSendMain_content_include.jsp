<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/resource/jsp/common.jsp"%>
<%@page import="com.landray.kmss.km.imissive.util.ImissiveUtil"%>
<%@page import="com.landray.kmss.km.imissive.util.KmImissiveConfigUtil"%>
<%@page import="com.landray.kmss.sys.attachment.integrate.wps.util.SysAttWpsCenterUtil"%>
<%@page import="com.landray.kmss.sys.attachment.model.SysAttMain"%>
<%@page import="com.landray.kmss.sys.attachment.util.JgWebOffice"%>
<c:set var="wpsoaassist" value="<%=ImissiveUtil.isEnable()%>"/>
<c:set var="xinChuangWps" value="<%=ImissiveUtil.isWPSOAassistEmbed(request)%>"/>
<%
	pageContext.setAttribute("_isWpsCloudEnable", new Boolean(ImissiveUtil.isEnableWpsCloud()));
	pageContext.setAttribute("_isWpsCenterEnable", new Boolean(SysAttWpsCenterUtil.isEnable()));
%>
<kmss:showWfPropertyValues  var="nodevalue" idValue="${kmImissiveSendMainForm.fdId}" propertyName="nodeName" />
<c:set var="fdYqqKeyPdf" value="yqqSigned" />
<c:set var="fdEqbKeyPdf" value="eqbSign" />
<c:set var="fdEqbKeyOfd" value="ofdEqbSign" />
<c:set var="fdSsKeyOfd" value="ofdSursenSign" />
<c:choose>
	<c:when  test="${not empty kmImissiveSendMainForm.attachmentForms[fdYqqKeyPdf].attachments}">
		<c:set var="fdSignKey" value="yqqSigned" />
	</c:when>
	<c:when test="${not empty kmImissiveSendMainForm.attachmentForms[fdEqbKeyPdf].attachments}">
		<c:set var="fdSignKey" value="eqbSign" />
	</c:when>
	<c:when test="${not empty kmImissiveSendMainForm.attachmentForms[fdEqbKeyOfd].attachments}">
		<c:set var="fdSignKey" value="ofdEqbSign" />
	</c:when>
	<c:when test="${not empty kmImissiveSendMainForm.attachmentForms[fdSsKeyOfd].attachments}">
		<c:set var="fdSignKey" value="ofdSursenSign" />
	</c:when>
	<c:otherwise>
		<c:set var="fdSignKey" value="" />
	</c:otherwise>
</c:choose>
<c:if test="${not empty kmImissiveSendMainForm.attachmentForms[contentKey].attachments}">
	<c:forEach items="${kmImissiveSendMainForm.attachmentForms[contentKey].attachments}" var="sysAttMainx"  varStatus="vstatus">
		<c:set var="fdAttMainId" value="${sysAttMainx.fdId}" scope="request"/>
		<c:set var="attId" value="${sysAttMainx.fdId}" scope="request"/>
	</c:forEach>
<c:if test="${wpsoaassist eq 'true' }">
	<c:if test="${kmImissiveSendMainForm.sysWfBusinessForm.fdNodeAdditionalInfo.yqqSignzq =='true' && yqqFlag=='true'}">
			<c:set var="signtrue" value="true" />
		</c:if>
		<c:choose>
			<c:when test="${kmImissiveSendMainForm.sysWfBusinessForm.fdNodeAdditionalInfo.redhead =='true'}">
				<c:set var="redhead" value="true" />
				<c:set var="canEdit" value="true" />
			</c:when>
			<c:otherwise>
				<c:set var="redhead" value="false" />
			</c:otherwise>
		</c:choose>
		<c:choose>
			<c:when test="${kmImissiveSendMainForm.sysWfBusinessForm.fdNodeAdditionalInfo.cleardraft =='true'}">
				<c:set var="cleardraft" value="true" />
				<c:set var="canEdit" value="true" />
			</c:when>
			<c:otherwise>
				<c:set var="cleardraft" value="false" />
			</c:otherwise>
		</c:choose>
		<c:choose>
			<c:when test="${kmImissiveSendMainForm.sysWfBusinessForm.fdNodeAdditionalInfo.saveRevisions =='true'}">
				<c:set var="saveRevisions" value="true" />
				<c:set var="canEdit" value="true" />
			</c:when>
			<c:otherwise>
				<c:set var="saveRevisions" value="false" />
			</c:otherwise>
		</c:choose>
		<c:choose>
			<c:when test="${kmImissiveSendMainForm.sysWfBusinessForm.fdNodeAdditionalInfo.forceRevisions =='true'}">
				<c:set var="forceRevisions" value="true" />
				<c:set var="canEdit" value="true" />
			</c:when>
			<c:otherwise>
				<c:set var="forceRevisions" value="false" />
			</c:otherwise>
		</c:choose>
		<c:choose>
			<c:when test="${kmImissiveSendMainForm.sysWfBusinessForm.fdNodeAdditionalInfo.editDocContent =='true'}">
				<c:set var="editDocContent" value="true" />
				<c:set var="canEdit" value="true" />
			</c:when>
			<c:otherwise>
				<c:set var="editDocContent" value="false" />
			</c:otherwise>
		</c:choose>
	</c:if>
	<c:choose>
		<c:when test="${not empty fdSignKey}">
			<c:forEach items="${kmImissiveSendMainForm.attachmentForms[fdSignKey].attachments}" var="sysAttMainx"  varStatus="vstatus">
				<c:set var="attId" value="${sysAttMainx.fdId}" scope="request"/>
				<c:set var="fdAttMainId" value="${sysAttMainx.fdId}" scope="request"/>
			</c:forEach>
			<c:choose>
				<c:when test="${wpsoaassist eq 'true'}">
					<jsp:include page="/km/imissive/wps/kmImissive_wpsoaassist.jsp">
						<jsp:param name="attId" value="${attId}" />
						<jsp:param name="fdKey" value="${fdSignKey}" />
						<jsp:param name="fdModelId" value="${kmImissiveSendMainForm.fdModelId}" />
						<jsp:param name="canEdit" value="${canEdit}" />
						<jsp:param name="_useWpsLinuxView" value="${_useWpsLinuxView}" />
					</jsp:include>
				</c:when>
				<c:otherwise>
					<jsp:include page="/km/imissive/km_imissive_send_main/kmImissiveSendMain_btn_include2.jsp">
						<jsp:param name="attId" value="${attId}"/>
					</jsp:include>
				</c:otherwise>
			</c:choose>
		</c:when>
		<c:when test="${kmImissiveSendMainForm.sysWfBusinessForm.fdNodeAdditionalInfo.ofdCySign =='true' and ofdFileFlag ne 'false'}">
			<%-- ofd超阅签章 --%>
			<c:if test="${kmImissiveSendMainForm.convertShowFlag eq 'toOFD'}">
				<c:if test="${not empty convertAttId}">
					<c:set var="attId" value="${convertAttId}"/>
				</c:if>
			</c:if>
			<c:if test="${not empty kmImissiveSendMainForm.attachmentForms['ofdCySign'].attachments}">
				<c:forEach items="${kmImissiveSendMainForm.attachmentForms['ofdCySign'].attachments}" var="sysAttMainx"  varStatus="vstatus">
					<c:set var="attId" value="${sysAttMainx.fdId}" scope="request"/>
				</c:forEach>
			</c:if>
			<jsp:include page="/km/imissive/km_imissive_jgcy_ofd/kmImissiveSendJgOfdSignHead.jsp">
				<jsp:param name="attId" value="${attId}"/>
				<jsp:param name="fileName" value="${kmImissiveSendMainForm.docSubject}"/>
				<jsp:param name="convertType" value="${_isOfdServiceName}"/>
			</jsp:include>
			<jsp:include page="/km/imissive/km_imissive_jgcy_ofd/KmimissiveOfdCySIgn.jsp">
					<jsp:param name="attId" value="${attId}"/>
					<jsp:param name="fdModelName" value="com.landray.kmss.km.imissive.model.KmImissiveSendMain"/>
			</jsp:include>
		</c:when>
		<c:when test="${not empty kmImissiveSendMainForm.attachmentForms['ofdCySign'].attachments}">
			<%-- ofd超阅展示 --%>
			<c:forEach items="${kmImissiveSendMainForm.attachmentForms['ofdCySign'].attachments}" var="sysAttMainx"  varStatus="vstatus">
				<c:set var="attId" value="${sysAttMainx.fdId}" scope="request"/>
			</c:forEach>
			<jsp:include page="/km/imissive/km_imissive_jgcy_ofd/kmImissiveSendJgOfdSignHead.jsp">
				<jsp:param name="attId" value="${attId}"/>
				<jsp:param name="fileName" value="${kmImissiveSendMainForm.docSubject}"/>
				<jsp:param name="convertType" value="${_isOfdServiceName}"/>
			</jsp:include>
			<c:choose>
				<c:when test="${not empty wpsOfdOrPdfUrl}">
					<iframe id="pdfFrame"  width="100%"  style="min-height:565px;"  frameborder="0"></iframe>
					<ui:event event="show">
						document.getElementById('pdfFrame').src='<c:url value="${wpsOfdOrPdfUrl }"/>';
					</ui:event>
				</c:when>
				<c:otherwise>
					<c:import url="/sys/attachment/sys_att_main/sysAttMain_view.jsp" charEncoding="UTF-8">
						<c:param name="fdKey" value="ofdCySign" />
						<c:param name="fdModelId" value="${kmImissiveSendMainForm.fdId}" />
						<c:param name="fdModelName" value="com.landray.kmss.km.imissive.model.KmImissiveSendMain" />
					</c:import>
				</c:otherwise>
			</c:choose>
		</c:when>
		<c:when test="${(kmImissiveSendMainForm.sysWfBusinessForm.fdNodeAdditionalInfo.dianjuOfdSign =='true'
			or kmImissiveSendMainForm.sysWfBusinessForm.fdNodeAdditionalInfo.dianjuPdfSign =='true') and not empty dianJuDownloadUrl}">
		<%--点聚签章--%>
			<c:if test="${kmImissiveSendMainForm.sysWfBusinessForm.fdNodeAdditionalInfo.dianjuOfdSign =='true'}">
				<c:set var="fileName" value="${kmImissiveSendMainForm.docSubject}.ofd" scope="request"/>
			</c:if>
			<c:if test="${kmImissiveSendMainForm.sysWfBusinessForm.fdNodeAdditionalInfo.dianjuPdfSign =='true'}">
				<c:set var="fileName" value="${kmImissiveSendMainForm.docSubject}.pdf" scope="request"/>
			</c:if>
			<c:set var="dianjuDownloadUrl" value="${dianJuDownloadUrl}" scope="request"/>
			<c:set var="modelId" value="${kmImissiveSendMainForm.fdId}" scope="request"/>
			<c:set var="modelName" value="com.landray.kmss.km.imissive.model.KmImissiveSendMain" scope="request"/>
			<c:choose>
				<c:when test="${not empty kmImissiveSendMainForm.attachmentForms['dianjuSign'].attachments}">
					<c:forEach items="${kmImissiveSendMainForm.attachmentForms['dianjuSign'].attachments}" var="sysAttMainx"  varStatus="vstatus">
						<c:set var="attMainId" value="${sysAttMainx.fdId}" scope="request"/>
						<c:set var="fdFileName" value="${sysAttMainx.fdFileName}" scope="request"/>
					</c:forEach>
				</c:when>
				<c:otherwise>
					<c:forEach items="${kmImissiveSendMainForm.attachmentForms[contentKey].attachments}" var="sysAttMainx"  varStatus="vstatus">
						<c:set var="attMainId" value="${sysAttMainx.fdId}" scope="request"/>
					</c:forEach>
				</c:otherwise>
			</c:choose>
			<jsp:include page="/sys/attachment/sys_att_main/dianju/format/dianju_format_include.jsp">
				<jsp:param name="attachmentId" value="${attId}"/>
			</jsp:include>
		</c:when>
		<c:when test="${not empty kmImissiveSendMainForm.attachmentForms['dianjuSign'].attachments}">
			<%--点聚展示--%>
			<c:forEach items="${kmImissiveSendMainForm.attachmentForms['dianjuSign'].attachments}" var="sysAttMainx"  varStatus="vstatus">
				<c:set var="attMainId" value="${sysAttMainx.fdId}" scope="request"/>
			</c:forEach>
			<c:choose>
				<c:when test="${not empty dianJuDownloadUrl}">
					<iframe id="pdfFrame"  width="100%"  style="min-height:565px;"  frameborder="0"></iframe>
					<ui:event event="show">
						document.getElementById('pdfFrame').src = ("<c:url value="/sys/attachment/sys_att_main/sysAttMain.do?method=view&fdId=${attMainId}&inner=yes"/>");
					</ui:event>
				</c:when>
				<c:otherwise>
					<c:import url="/sys/attachment/sys_att_main/sysAttMain_view.jsp" charEncoding="UTF-8">
						<c:param name="fdKey" value="dianJuSign" />
						<c:param name="fdModelId" value="${kmImissiveSendMainForm.fdId}" />
						<c:param name="fdModelName" value="com.landray.kmss.km.imissive.model.KmImissiveSendMain" />
					</c:import>
				</c:otherwise>
			</c:choose>
		</c:when>
		<c:when test="${kmImissiveSendMainForm.sysWfBusinessForm.fdNodeAdditionalInfo.pdfJgSign =='true' and ('pdf' eq attType or convertAttType eq 'toPDF')}">
			<%-- 金格pdf签章  --%>
			<%
				SysAttMain sysAttMain = (SysAttMain) request.getAttribute("sysAttMain");
				if(sysAttMain!=null){
					request.setAttribute("attId",sysAttMain.getFdId());
					String suffix = sysAttMain.getFdFileName().substring(
							sysAttMain.getFdFileName().lastIndexOf(".")+1);
					request.setAttribute("jgSignAttType", suffix.toLowerCase());
					if("pdf".equals(suffix.toLowerCase())){
			%>
			<jsp:include page="/km/imissive/jg/iWebPdf/kmImissiveSendMain_btn_include.jsp">
				<jsp:param name="attId" value="${attId}"/>
				<jsp:param name="pdfJgSignKey" value="true"/>
			</jsp:include>
			<%}else{%>
			<c:set var="pdfJgSignKey" value="false" scope="request"/>
			<c:forEach items="${kmImissiveSendMainForm.attachmentForms['convert_toPDF'].attachments}" var="sysAttMainx"  varStatus="vstatus">
				<c:set var="attId" value="${sysAttMainx.fdId}" scope="request"/>
				<c:set var="pdfJgSignKey" value="true" scope="request"/>
			</c:forEach>
			<jsp:include page="/km/imissive/jg/iWebPdf/kmImissiveSendMain_btn_include.jsp">
				<jsp:param name="attId" value="${attId}"/>
				<jsp:param name="pdfJgSignKey" value="${pdfJgSignKey}"/>
			</jsp:include>
			<%
					}
				}
			%>
		</c:when>
		<c:when test="${not empty convertAttId}">
			<%-- 转PDF or OFD正文展示  --%>
			<c:set var="fdAttMainId" value="${convertAttId}" scope="request"/>
			<div id="missiveButtonDiv" >
				<jsp:include page="/km/imissive/km_imissive_send_main/kmImissiveSendMain_btn_includeConvert.jsp"></jsp:include>
			</div>
			<iframe id="pdfFrame"  width="100%"  style="min-height:565px;"  frameborder="0"></iframe>
			<ui:event event="show">
				document.getElementById('pdfFrame').src = ("<c:url value="/sys/attachment/sys_att_main/sysAttMain.do?method=view&fdId=${convertAttId}"/>");
			</ui:event>
		</c:when>
		<c:when test="${wpsoaassist eq 'true'}">
			<c:choose>
				<c:when test="${('word' eq attType  and 'true' eq xinChuangWps)}">
					<%-- 信创加载项控件  --%>
					<jsp:include page="/km/imissive/wps/oaassist/sysAttMain_edit.jsp">
						<jsp:param name="fdKey" value="${contentKey}"/>
						<jsp:param name="fdModelId" value="${kmImissiveSendMainForm.fdId}"/>
						<jsp:param name="fdModelName" value="com.landray.kmss.km.imissive.model.KmImissiveSendMain"/>
						<jsp:param name="formBeanName" value="kmImissiveSendMainForm"/>
						<jsp:param name="load" value="false"/>
						<jsp:param name="nodevalue" value="${nodevalue}"/>
						<jsp:param name="bookMarks" value="${bookmarkJson}"/>
						<jsp:param  name="redhead"  value="${redhead}"/>
						<jsp:param  name="cleardraft"  value="${cleardraft}"/>
						<jsp:param  name="saveRevisions"  value="${saveRevisions}"/>
						<jsp:param name="editDocContent"  value="${editDocContent}"/>
						<jsp:param name="editStatus" value="${editStatus}" />
					</jsp:include>
				</c:when>
				<c:otherwise>
					<%-- 非信创加载项控件  --%>
					<c:import url="/km/imissive/wps/sysAttMain_include_viewHtml.jsp" charEncoding="UTF-8">
						<c:param  name="bookMarks"  value="${bookmarkJson}"/>
						<c:param  name="nodevalue"  value="${nodevalue}"/>
						<c:param  name="fdMulti"  value="false" />
						<c:param  name="contentFlag"  value="true"/>
						<c:param name="buttonDiv" value="missiveButtonDiv" />
						<c:param name="isShowImg" value="${isShowImg}"/>
						<c:param name="fdKey" value="${contentKey}" />
						<c:param  name="fdMulti"  value="false" />
						<c:param name="fdModelId" value="${kmImissiveSendMainForm.fdId}" />
						<c:param name="fdModelName" value="com.landray.kmss.km.imissive.model.KmImissiveSendMain" />
						<c:param name="formBeanName" value="kmImissiveSendMainForm" />
						<c:param  name="contentFlag"  value="true"/>
						<c:param  name="protectstatus"  value="${protectstatus}"/>
						<c:param  name="showAllPage"  value="${showAllPage}"/>
						<c:param  name="signtrue"  value="${signtrue}"/>
						<c:param  name="redhead"  value="${redhead}"/>
						<c:param  name="cleardraft"  value="${cleardraft}"/>
						<c:param  name="saveRevisions"  value="${saveRevisions}"/>
						<c:param  name="forceRevisions"  value="${forceRevisions}"/>
						<c:param  name="editDocContent"  value="${editDocContent}"/>
						<c:param name="fdTemplateId" value="${kmImissiveSendMainForm.fdTemplateId }" />
						<c:param name="editStatus" value="${editStatus}" />
						<c:param name="canEdit" value="${canEdit}" />
						<c:param name="_useWpsLinuxView" value="${_useWpsLinuxView}" />
						<c:param name="formName" value="kmImissiveSendMainForm" />
						<c:param name="modelFlag" value="send" />
					</c:import>
				</c:otherwise>
			</c:choose>
		</c:when>
		<c:when test="${not empty kmImissiveSendMainForm.attachmentForms[fdKeyPdf].attachments && kmImissiveSendMainForm.docStatus eq '30'}">
	<%-- cfca  --%>
			<c:forEach items="${kmImissiveSendMainForm.attachmentForms[fdKeyPdf].attachments}" var="sysAttMainx"  varStatus="vstatus">
				<c:set var="attId" value="${sysAttMainx.fdId}" scope="request"/>
			</c:forEach>
			<jsp:include page="/km/imissive/km_imissive_send_main/kmImissiveSendMain_btn_include2.jsp">
				<jsp:param name="attId" value="${attId}"/>
			</jsp:include>
		</c:when>
		<c:otherwise>
			<c:if test="${not empty kmImissiveSendMainForm.attachmentForms[contentKey].attachments}">
				<c:choose>
					<c:when test="${fn:length(kmImissiveSendMainForm.attachmentForms[contentKey].attachments)>1}">
						<div>
							<c:import url="/sys/attachment/sys_att_main/sysAttMain_view.jsp" charEncoding="UTF-8">
								<c:param name="formBeanName" value="kmImissiveSendMainForm" />
								<c:param name="fdKey" value="${contentKey}" />
								<c:param name="fdModelId" value="${kmImissiveSendMainForm.fdId}" />
								<c:param name="fdModelName" value="com.landray.kmss.km.imissive.model.KmImissiveSendMain" />
							</c:import>
						</div>
					</c:when>
					<c:otherwise>
						<%
							if("tab".equals(KmImissiveConfigUtil.getDisplayMode())){
								request.setAttribute("disPlayMode", "tab");
							}
							SysAttMain sysAttMain = (SysAttMain) request.getAttribute("sysAttMain");
							if(sysAttMain!=null){
								request.setAttribute("attId",sysAttMain.getFdId());
								String suffix = sysAttMain.getFdFileName().substring(
										sysAttMain.getFdFileName().lastIndexOf(".")+1);
								if("doc".equals(suffix.toLowerCase()) || "docx".equals(suffix.toLowerCase()) || "wps".equals(suffix.toLowerCase())){
						%>
						<c:if test="${editStatus == true or editFlag == true}">
							<kmss:auth requestURL="/km/imissive/km_imissive_send_main/kmImissiveSendMain.do?method=edit&fdId=${param.fdId}" requestMethod="GET">
								<c:set var="isReadOnly" value="false" scope="request" />
							</kmss:auth>
							<c:if  test="${kmImissiveSendMainForm.sysWfBusinessForm.fdNodeAdditionalInfo.editDocContent =='true' and editFlag != true}">
								<c:set var="isReadOnly" value="false" scope="request" />
							</c:if>
							<%-- 操作按钮  --%>
						   <div id="missiveButtonDiv" >
							   <c:if test="${_isWpsCenterEnable}">
								   <%--<a href="javascript:void(0);" class="officialSmart" id="smartTypesettingBtn"
									  onclick="smartTypesetting('send', '${kmImissiveSendMainForm.method_GET}')">
									   <c:out value="智能排版" />
								   </a>--%>
							   </c:if>
							   <jsp:include page="/km/imissive/km_imissive_send_main/kmImissiveSendMain_btn_include.jsp"></jsp:include>
						   </div>
							<c:choose>
								<c:when test="${_isWpsCloudEnable}">
									<c:choose>
										<c:when test="${isReadOnly}">
											<c:import url="/sys/attachment/sys_att_main/wps/cloud/sysAttMain_view.jsp" charEncoding="UTF-8">
												<c:param name="fdKey" value="${contentKey}" />
												<c:param name="load" value="false" />
												<c:param name="fdModelId" value="${kmImissiveSendMainForm.fdId}" />
												<c:param name="fdModelName" value="com.landray.kmss.km.imissive.model.KmImissiveSendMain" />
												<c:param name="formBeanName" value="kmImissiveSendMainForm" />
												<c:param  name="contentFlag"  value="true"/>
											</c:import>
										</c:when>
										<c:otherwise>
											<c:import url="/sys/attachment/sys_att_main/wps/cloud/sysAttMain_edit.jsp" charEncoding="UTF-8">
												<c:param name="fdKey" value="${contentKey}" />
												<c:param name="load" value="false" />
												<c:param name="bindSubmit" value="false"/>
												<c:param name="fdModelId" value="${kmImissiveSendMainForm.fdId}" />
												<c:param name="fdModelName" value="com.landray.kmss.km.imissive.model.KmImissiveSendMain" />
												<c:param name="formBeanName" value="kmImissiveSendMainForm" />
												<c:param name="fdTemplateModelId" value="${kmImissiveSendMainForm.fdTemplateId}" />
												<c:param name="fdTemplateModelName" value="com.landray.kmss.km.imissive.model.KmImissiveSendTemplate" />
												<c:param name="fdTemplateKey" value="editonline" />
												<c:param name="fdTempKey" value="${kmImissiveSendMainForm.fdTemplateId}" />
												<c:param name="buttonDiv" value="missiveButtonDiv" />
											</c:import>
										</c:otherwise>
									</c:choose>
								</c:when>
								<c:when test="${_isWpsCenterEnable}">
									<c:choose>
										<c:when test="${isReadOnly}">
											<c:import url="/sys/attachment/sys_att_main/wps/center/sysAttMain_view.jsp" charEncoding="UTF-8">
												<c:param name="fdKey" value="${contentKey}" />
												<c:param name="fdModelId" value="${kmImissiveSendMainForm.fdId}" />
												<c:param name="fdModelName" value="com.landray.kmss.km.imissive.model.KmImissiveSendMain" />
												<c:param name="formBeanName" value="kmImissiveSendMainForm" />
												<c:param  name="contentFlag"  value="true"/>
												<c:param name="load" value="false" />
												<c:param name="wpsPreview" value="0010000" />
											</c:import>
										</c:when>
										<c:otherwise>
											<c:import url="/sys/attachment/sys_att_main/wps/center/sysAttMain_edit.jsp" charEncoding="UTF-8">
												<c:param name="fdKey" value="${contentKey}" />
												<c:param name="load" value="false" />
												<c:param name="bindSubmit" value="false"/>
												<c:param name="fdModelId" value="${kmImissiveSendMainForm.fdId}" />
												<c:param name="fdModelName" value="com.landray.kmss.km.imissive.model.KmImissiveSendMain" />
												<c:param name="formBeanName" value="kmImissiveSendMainForm" />
												<c:param name="fdTemplateModelId" value="${kmImissiveSendMainForm.fdTemplateId}" />
												<c:param name="fdTemplateModelName" value="com.landray.kmss.km.imissive.model.KmImissiveSendTemplate" />
												<c:param name="fdTemplateKey" value="editonline" />
												<c:param name="fdTempKey" value="${kmImissiveSendMainForm.fdTemplateId}" />
												<c:param name="buttonDiv" value="missiveButtonDiv" />
											</c:import>
										</c:otherwise>
									</c:choose>
								</c:when>
								<c:otherwise>
									<c:import url="/sys/attachment/sys_att_main/jg/sysAttMain_edit.jsp" charEncoding="UTF-8">
										<c:param name="fdKey" value="${contentKey}" />
										<c:param name="fdAttType" value="office" />
										<c:param name="extKey" value="${kmImissiveSendMainForm.fdId}" />
										<c:param  name="fdMulti"  value="false" />
										<c:param name="fdModelId" value="${kmImissiveSendMainForm.fdId}" />
										<c:param name="fdModelName" value="com.landray.kmss.km.imissive.model.KmImissiveSendMain" />
										<c:param name="formBeanName" value="kmImissiveSendMainForm" />
										<c:param name="buttonDiv" value="missiveButtonDiv" />
										<c:param name="isToImg" value="false"/>
										<c:param name="isReadOnly" value="${isReadOnly}"/>
										<c:param  name="bookMarks"  value="${bookmarkJson}"/>
										<c:param name="showRevisions" value="<%=KmImissiveConfigUtil.isShowRevision()%>" />
										<c:param name="forceRevisions" value="${forceRevisions}"/>
										<c:param name="trackRevisions" value="${trackRevisions}"/>
										<c:param name="attHeight" value="566"/>
										<c:param name="loadJg" value="false"/>
									</c:import>
								</c:otherwise>
							</c:choose>
						</c:if>
						<c:if test="${editStatus != true}">
							<c:set var="editable" value="false"></c:set>
							<%if(ImissiveUtil.isJGEnabled()){%>
								<%if(KmImissiveConfigUtil.checkSpeedByImgContent()){ %>
									<c:set var="authEditContent" value="false" scope="request" />
									<c:if test="${kmImissiveSendMainForm.sysWfBusinessForm.fdNodeAdditionalInfo.editDocContent =='true'}">
										<c:set var="authEditContent" value="true" scope="request" />
									</c:if>
									<%--编辑正文 --%>
									<c:if  test="${isReadOnly != 'true' and editFlag != true}">
										<c:if test="${authEditContent eq true}">
											<c:choose>
												<c:when test="${isIE}">
													<c:set var="editable" value="true"></c:set>
												</c:when>
												<c:otherwise>
													<%if(JgWebOffice.isJGMULEnabled()){%>
													<c:set var="editable" value="true"></c:set>
													<%} %>
												</c:otherwise>
											</c:choose>
										</c:if>
									</c:if>
								<%} %>
							<%} %>
							<div id="${contentKey}">
								<%if(ImissiveUtil.getJgConvertHtmlFlag(request)){%>
									<%--金格模式下，并且文件转换成功默认展示html --%>
									<c:if test="${isShowImg and authEditContent ne true  and _isWpsCloudEnable ne true and _isWpsCenterEnable ne true and _useWpsLinuxView ne 'true'}">
										<table class="tb_normal" width="100%">
											<tr>
												<td colspan="4">
													<font style="text-align:center"><bean:message  bundle="km-imissive" key="kmMissiveMain.prompt"/></font>
												</td>
											</tr>
										</table>
									</c:if>
								<%} %>
								<div id="missiveButtonDiv" >
									<!-- 重复展示待定 -->
									<jsp:include page="/km/imissive/km_imissive_send_main/kmImissiveSendMain_btn_include.jsp"></jsp:include>
									<c:if test="${editable eq true}">
										<a href="javascript:void(0);" class="editContent com_btn_link" onclick="Com_OpenWindow('kmImissiveSendMain.do?method=view&fdId=${param.fdId}&editFlag=true','_self');">
											<bean:message  bundle="km-imissive" key="button.editText"/>
										</a>
									</c:if>
									<%if(KmImissiveConfigUtil.checkSpeedByImgContent()){ %>
									<c:if  test="${authEditContent eq true and editFlag == true}">
										<a href="javascript:void(0);" class="back com_btn_link" onclick="Com_OpenWindow('kmImissiveSendMain.do?method=view&fdId=${param.fdId}','_self');">
											<bean:message  bundle="km-imissive" key="button.return"/>
										</a>
									</c:if>
									<%} %>
								</div>
								<c:import url="/sys/attachment/sys_att_main/jg/sysAttMain_include_viewHtml.jsp" charEncoding="UTF-8">
									<c:param name="fdKey" value="${contentKey}" />
									<c:param name="fdAttType" value="office" />
									<c:param  name="fdMulti"  value="false" />
									<c:param name="fdModelId" value="${param.fdId}" />
									<c:param name="fdModelName" value="com.landray.kmss.km.imissive.model.KmImissiveSendMain" />
									<c:param name="formBeanName" value="kmImissiveSendMainForm" />
									<c:param  name="contentFlag"  value="true"/>
									<c:param  name="protectstatus"  value="${protectstatus}"/>
									<c:param name="isShowImg" value="${isShowImg}"/>
									<c:param  name="showAllPage"  value="${showAllPage}"/>
									<c:param name="buttonDiv" value="missiveButtonDiv" />
									<c:param  name="bookMarks"  value="${bookmarkJson}"/>
									<c:param name="loadJg" value="false"/>
								</c:import>
							</div>
						</c:if>
						<% }else if(("pdf".equals(suffix.toLowerCase()) || "ofd".equals(suffix.toLowerCase()))&&(JgWebOffice.isOfficePDFJudge()||JgWebOffice.isExistViewPath(request)||ImissiveUtil.isEnableWpsCloud() || SysAttWpsCenterUtil.isEnable())){%>
							<jsp:include page="/km/imissive/km_imissive_send_main/kmImissiveSendMain_btn_include2.jsp">
								<jsp:param name="attId" value="${attId}"/>
							</jsp:include>
						<%}else{ %>
						<div class="lui_form_spacing"></div>
						<div>
							<div class="lui_form_subhead"><img src="${KMSS_Parameter_ContextPath}sys/attachment/view/img/attachment.png"><bean:message key="kmImissiveReceiveMain.mainonline" bundle="km-imissive" /></div>
							<c:import url="/sys/attachment/sys_att_main/sysAttMain_view.jsp" charEncoding="UTF-8">
								<c:param name="formBeanName" value="kmImissiveSendMainForm" />
								<c:param name="fdKey" value="${contentKey}" />
								<c:param name="fdModelId" value="${param.fdId}" />
								<c:param name="fdModelName" value="com.landray.kmss.km.imissive.model.KmImissiveSendMain" />
							</c:import>
						</div>
						<% 		}
						}
						%>
					</c:otherwise>
				</c:choose>
			</c:if>
		</c:otherwise>
	</c:choose>
	<script type="text/javascript">
		$(document).ready(function(){
			if($('#pdfFrame')){
				var contentH = 520;
				var showAllPage = '${showAllPage}';
				//如果是左右结构，则重新计算高度
				if($('.content')&&$('.content').height()){
					contentH = $('.content').height()-100;
				}
				$('#pdfFrame').css('min-height', (contentH)+'px');
				$('#pdfFrame').css('height', (contentH+20)+'px');
				if(showAllPage == 'true'){
					$('#pdfFrame').prop('scrolling', "no");
				}
			}
			setTimeout(function(){
				var officeIframeh = "560";
				if($('.content').length > 0){
					var contentH = $('.content').height();
					officeIframeh = contentH-100;
				}
				if($('#office-iframe')){
					$('#office-iframe').height((officeIframeh)+"px");
				}
			},100);
		});
	</script>
</c:if>
