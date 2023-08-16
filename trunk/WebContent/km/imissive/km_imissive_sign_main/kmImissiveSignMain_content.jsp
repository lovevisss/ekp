<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/resource/jsp/common.jsp"%>
<%@ include file="/km/imissive/kmImissiveSignRedhead_script.jsp"%>
<%@page import="com.landray.kmss.sys.attachment.util.JgWebOffice"%>
<%@page import="com.landray.kmss.sys.attachment.model.SysAttMain"%>
<%@page import="com.landray.kmss.km.imissive.util.KmImissiveConfigUtil"%>
<%@ include file="/km/imissive/km_imissive_sign_main/kmImissiveSignRedhead_script.jsp"%>
<%@page import="com.landray.kmss.sys.attachment.integrate.wps.util.SysAttWpsCloudUtil"%>
<%@page import="com.landray.kmss.sys.attachment.integrate.wps.util.SysAttWpsCenterUtil"%>
<%@ page import="com.landray.kmss.km.imissive.util.ImissiveUtil"%>
<c:set var="_useWpsLinuxView" value="<%=SysAttWpsCloudUtil.getUseWpsLinuxView()%>"/>
<c:set var="wpsoaassist" value="<%=ImissiveUtil.isEnable()%>"/>
<c:set var="xinChuangWps" value="<%=ImissiveUtil.isWPSOAassistEmbed(request)%>"/>
<%
	pageContext.setAttribute("_isWpsCloudEnable", new Boolean(ImissiveUtil.isEnableWpsCloud()));
	pageContext.setAttribute("_isWpsCenterEnable", new Boolean(SysAttWpsCenterUtil.isEnable()));
	pageContext.setAttribute("_isOfdServiceName", new String(KmImissiveConfigUtil.getAttOfdServiceName()));
	pageContext.setAttribute("_isPdfServiceName", new String(KmImissiveConfigUtil.getAttPdfServiceName()));
%>
<%
	request.setAttribute("isExistViewPath", JgWebOffice.isExistViewPath(request));
	request.setAttribute("isJGMULEnabled", JgWebOffice.isJGMULEnabled());

%>
<kmss:showWfPropertyValues  var="nodevalue" idValue="${kmImissiveSignMainForm.fdId}" propertyName="nodeName" />
<c:if test="${not empty kmImissiveSignMainForm.attachmentForms['editonline'].attachments}">
	<c:set var="fdYqqKeyPdf" value="yqqSigned" />
	<c:set var="fdEqbKeyPdf" value="eqbSign" />
	<c:set var="fdEqbKeyOfd" value="ofdEqbSign" />
	<c:set var="fdSsKeyOfd" value="ofdSursenSign" />
	<c:choose>
		<c:when  test="${not empty kmImissiveSignMainForm.attachmentForms[fdYqqKeyPdf].attachments}">
			<c:set var="fdSignKey" value="yqqSigned" />
		</c:when>
		<c:when test="${not empty kmImissiveSignMainForm.attachmentForms[fdEqbKeyPdf].attachments}">
			<c:set var="fdSignKey" value="eqbSign" />
		</c:when>
		<c:when  test="${not empty kmImissiveSignMainForm.attachmentForms[fdEqbKeyOfd].attachments}">
			<c:set var="fdSignKey" value="ofdEqbSign" />
		</c:when>
		<c:when  test="${not empty kmImissiveSignMainForm.attachmentForms[fdSsKeyOfd].attachments}">
			<c:set var="fdSignKey" value="ofdSursenSign" />
		</c:when>
		<c:otherwise>
			<c:set var="fdSignKey" value="" />
		</c:otherwise>
	</c:choose>
	<c:if test="${kmImissiveSignMainForm.fdNeedContent=='0'}">
		<c:set var="fdKeyPdf" value="mainonline_pdf" scope="request"/>
	</c:if>
	<c:if test="${kmImissiveSignMainForm.fdNeedContent=='1'}">
		<c:set var="fdKeyPdf" value="editonline_pdf" scope="request"/>
	</c:if>
<c:forEach items="${kmImissiveSignMainForm.attachmentForms['editonline'].attachments}" var="sysAttMain"	varStatus="vstatus">
			<c:set var="fdAttMainId" value="${sysAttMain.fdId}" scope="request"/>
			<c:set var="attId" value="${sysAttMain.fdId}" scope="request"/>
		</c:forEach>
	<c:if test="${wpsoaassist eq 'true' }">
		<c:choose>
			<c:when test="${kmImissiveSignMainForm.sysWfBusinessForm.fdNodeAdditionalInfo.redhead =='true'}">
				<c:set var="redhead" value="true" />
			</c:when>
			<c:otherwise>
				<c:set var="redhead" value="false" />
			</c:otherwise>
		</c:choose>
		<c:if test="${kmImissiveSignMainForm.sysWfBusinessForm.fdNodeAdditionalInfo.yqqSignzq =='true' && yqqFlag=='true'}">
			<c:set var="signtrue" value="true" />
		</c:if>
		<c:choose>
			<c:when test="${kmImissiveSignMainForm.sysWfBusinessForm.fdNodeAdditionalInfo.editDocContent =='true'}">
				<c:set var="editDocContent" value="true" />
				<c:set var="canEdit" value="true" />
			</c:when>
			<c:otherwise>
				<c:set var="editDocContent" value="false" />
			</c:otherwise>
		</c:choose>
		<c:choose>
			<c:when test="${kmImissiveSignMainForm.sysWfBusinessForm.fdNodeAdditionalInfo.redhead =='true'}">
				<c:set var="redhead" value="true" />
				<c:set var="canEdit" value="true" />
			</c:when>
			<c:otherwise>
				<c:set var="redhead" value="false" />
			</c:otherwise>
		</c:choose>
	</c:if>
	<c:choose>
		<c:when test="${not empty fdSignKey}">
			<c:forEach items="${kmImissiveSignMainForm.attachmentForms[fdSignKey].attachments}" var="sysAttMainx"  varStatus="vstatus">
				<c:set var="attId" value="${sysAttMainx.fdId}" scope="request"/>
				<c:set var="fdAttMainId" value="${sysAttMainx.fdId}" scope="request"/>
			</c:forEach>
			<c:choose>
				<c:when test="${wpsoaassist eq 'true'}">
					<jsp:include page="/km/imissive/wps/kmImissive_wpsoaassist_sign.jsp">
						<jsp:param name="attId" value="${attId}" />
						<jsp:param name="fdKey" value="${fdSignKey}" />
						<jsp:param name="fdModelId" value="${kmImissiveSignMainForm.fdModelId}" />
						<jsp:param name="canEdit" value="${canEdit}" />
						<jsp:param name="_useWpsLinuxView" value="${_useWpsLinuxView}" />
					</jsp:include>
				</c:when>
				<c:otherwise>
					<jsp:include page="/km/imissive/km_imissive_sign_main/kmImissiveSignMain_btn_include2.jsp">
						<jsp:param name="attId" value="${attId}"/>
					</jsp:include>
				</c:otherwise>
			</c:choose>
		</c:when>
		<c:when test="${kmImissiveSignMainForm.sysWfBusinessForm.fdNodeAdditionalInfo.ofdCySign =='true' and ofdFileFlag ne 'false'}">
			<!-- ofd超阅签章 -->
			<c:if test="${kmImissiveSignMainForm.convertShowFlag eq 'toOFD'}">
				<c:if test="${not empty convertAttId}">
					<c:set var="attId" value="${convertAttId}"/>
				</c:if>
			</c:if>
		<c:if test="${not empty kmImissiveSignMainForm.attachmentForms['ofdCySign'].attachments}">
			<c:forEach items="${kmImissiveSignMainForm.attachmentForms['ofdCySign'].attachments}" var="sysAttMainx"  varStatus="vstatus">
				<c:set var="attId" value="${sysAttMainx.fdId}" scope="request"/>
			</c:forEach>
		</c:if>
			<jsp:include page="/km/imissive/km_imissive_jgcy_ofd/kmImissiveSignJgOfdSignHead.jsp">
				<jsp:param name="attId" value="${attId}"/>
				<jsp:param name="fileName" value="${kmImissiveSignMainForm.docSubject}"/>
				<jsp:param name="convertType" value="${_isOfdServiceName}"/>
			</jsp:include>
			<jsp:include page="/km/imissive/km_imissive_jgcy_ofd/KmimissiveOfdCySIgn.jsp">
				<jsp:param name="attId" value="${attId}"/>
				<jsp:param name="fdModelName" value="com.landray.kmss.km.imissive.model.KmImissiveSignMain"/>
			</jsp:include>
		</c:when>
		<c:when test="${not empty kmImissiveSignMainForm.attachmentForms['ofdCySign'].attachments}">
			<!-- ofd超阅展示 -->
			<c:forEach items="${kmImissiveSignMainForm.attachmentForms['ofdCySign'].attachments}" var="sysAttMainx"  varStatus="vstatus">
				<c:set var="attId" value="${sysAttMainx.fdId}" scope="request"/>
			</c:forEach>
			<jsp:include page="/km/imissive/km_imissive_jgcy_ofd/kmImissiveSignJgOfdSignHead.jsp">
				<jsp:param name="attId" value="${attId}"/>
				<jsp:param name="fileName" value="${kmImissiveSignMainForm.docSubject}"/>
				<jsp:param name="convertType" value="${_isOfdServiceName}"/>
			</jsp:include>
			<c:choose>
				<c:when test="${not empty wpsOfdOrPdfUrl}">
					<iframe id="pdfFrame"  width="100%"  style="min-height:565px;height:565px"  frameborder="0"></iframe>
					<ui:event event="show">
						document.getElementById('pdfFrame').src='<c:url value="${wpsOfdOrPdfUrl }"/>';
					</ui:event>
				</c:when>
				<c:otherwise>
					<c:import url="/sys/attachment/sys_att_main/sysAttMain_view.jsp" charEncoding="UTF-8">
						<c:param name="fdKey" value="ofdCySign" />
						<c:param name="fdModelId" value="${kmImissiveSignMainForm.fdId}" />
						<c:param name="fdModelName" value="com.landray.kmss.km.imissive.model.KmImissiveSignMain" />
					</c:import>
				</c:otherwise>
			</c:choose>
		</c:when>
		<c:when test="${(kmImissiveSignMainForm.sysWfBusinessForm.fdNodeAdditionalInfo.dianjuOfdSign =='true'
			or kmImissiveSignMainForm.sysWfBusinessForm.fdNodeAdditionalInfo.dianjuPdfSign =='true') and not empty dianJuDownloadUrl}">
			<%--点聚签章--%>
			<c:if test="${kmImissiveSignMainForm.sysWfBusinessForm.fdNodeAdditionalInfo.dianjuOfdSign =='true'}">
				<c:set var="fileName" value="${kmImissiveSignMainForm.docSubject}.ofd" scope="request"/>
			</c:if>
			<c:if test="${kmImissiveSignMainForm.sysWfBusinessForm.fdNodeAdditionalInfo.dianjuPdfSign =='true'}">
				<c:set var="fileName" value="${kmImissiveSignMainForm.docSubject}.pdf" scope="request"/>
			</c:if>
			<c:set var="dianjuDownloadUrl" value="${dianJuDownloadUrl}" scope="request"/>
			<c:set var="modelId" value="${kmImissiveSignMainForm.fdId}" scope="request"/>
			<c:set var="modelName" value="com.landray.kmss.km.imissive.model.KmImissiveSignMain" scope="request"/>
			<c:choose>
				<c:when test="${not empty kmImissiveSignMainForm.attachmentForms['dianjuSign'].attachments}">
					<c:forEach items="${kmImissiveSignMainForm.attachmentForms['dianjuSign'].attachments}" var="sysAttMainx"  varStatus="vstatus">
						<c:set var="attMainId" value="${sysAttMainx.fdId}" scope="request"/>
						<c:set var="fdFileName" value="${sysAttMainx.fdFileName}" scope="request"/>
					</c:forEach>
				</c:when>
				<c:otherwise>
					<c:forEach items="${kmImissiveSignMainForm.attachmentForms[contentKey].attachments}" var="sysAttMainx"  varStatus="vstatus">
						<c:set var="attMainId" value="${sysAttMainx.fdId}" scope="request"/>
					</c:forEach>
				</c:otherwise>
			</c:choose>
			<jsp:include page="/sys/attachment/sys_att_main/dianju/format/dianju_format_include.jsp">
				<jsp:param name="attachmentId" value="${attId}"/>
			</jsp:include>
		</c:when>
		<c:when test="${not empty kmImissiveSignMainForm.attachmentForms['dianjuSign'].attachments}">
			<%--点聚展示--%>
			<c:forEach items="${kmImissiveSignMainForm.attachmentForms['dianjuSign'].attachments}" var="sysAttMainx"  varStatus="vstatus">
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
						<c:param name="fdModelId" value="${kmImissiveSignMainForm.fdId}" />
						<c:param name="fdModelName" value="com.landray.kmss.km.imissive.model.KmImissiveSignMain" />
					</c:import>
				</c:otherwise>
			</c:choose>
		</c:when>
		<c:when test="${kmImissiveSignMainForm.sysWfBusinessForm.fdNodeAdditionalInfo.pdfJgSign =='true' and ('pdf' eq attType or convertAttType eq 'toPDF')}">
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
			<jsp:include page="/km/imissive/jg/iWebPdf/kmImissiveSignMain_btn_include.jsp">
				<jsp:param name="attId" value="${attId}"/>
				<jsp:param name="pdfJgSignKey" value="true"/>
			</jsp:include>
			<%}else{%>
			<c:set var="pdfJgSignKey" value="false" scope="request"/>
			<c:forEach items="${kmImissiveSignMainForm.attachmentForms['convert_toPDF'].attachments}" var="sysAttMainx"  varStatus="vstatus">
				<c:set var="attId" value="${sysAttMainx.fdId}" scope="request"/>
				<c:set var="pdfJgSignKey" value="true" scope="request"/>
			</c:forEach>
			<jsp:include page="/km/imissive/jg/iWebPdf/kmImissiveSignMain_btn_include.jsp">
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
				<jsp:include page="/km/imissive/km_imissive_sign_main/kmImissiveSignMain_btn_includeConvert.jsp"></jsp:include>
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
						<jsp:param name="fdModelId" value="${kmImissiveSignMainForm.fdId}"/>
						<jsp:param name="fdModelName" value="com.landray.kmss.km.imissive.model.KmImissiveSignMain"/>
						<jsp:param name="formBeanName" value="kmImissiveSignMainForm"/>
						<jsp:param name="load" value="false"/>
						<jsp:param name="nodevalue" value="${nodevalue}"/>
						<jsp:param name="bookMarks" value="${bookmarkJson}"/>
						<jsp:param  name="redhead"  value="${redhead}"/>
						<jsp:param name="editDocContent"  value="${editDocContent}"/>
					</jsp:include>
				</c:when>
				<c:otherwise>
					<%-- 非信创加载项控件  --%>
					<c:import url="/km/imissive/wps/sysAttMain_include_viewHtml.jsp" charEncoding="UTF-8">
						<c:param  name="bookMarks"  value="${bookmarkJson}"/>
						<c:param  name="nodevalue"  value="${nodevalue}"/>
						<c:param name="fdKey" value="editonline" />
						<c:param name="fdModelId" value="${kmImissiveSignMainForm.fdId}" />
						<c:param name="fdModelName" value="com.landray.kmss.km.imissive.model.KmImissiveSignMain" />
						<c:param name="formBeanName" value="kmImissiveSignMainForm" />
						<c:param  name="signtrue"  value="${signtrue}"/>
						<c:param  name="redhead"  value="${redhead}"/>
						<c:param  name="editStatus"  value="${editStatus}"/>
						<c:param  name="editDocContent"  value="${editDocContent}"/>
						<c:param  name="canEdit"  value="${canEdit}"/>
						<c:param name="_useWpsLinuxView" value="${_useWpsLinuxView}" />
						<c:param name="docSubject" value="${kmImissiveSignMainForm.docSubject}" />
						<c:param name="method" value="sign" />
						<c:param name="fdTemplateId" value="${kmImissiveSignMainForm.fdTemplateId }" />
						<c:param name="formName" value="kmImissiveSignMainForm" />
						<c:param name="modelFlag" value="sign" />
					</c:import>
				</c:otherwise>
			</c:choose>
		</c:when>
		<c:when test="${not empty kmImissiveSignMainForm.attachmentForms[fdKeyPdf].attachments and kmImissiveSignMainForm.docStatus eq '30'}">
			<c:forEach items="${kmImissiveSignMainForm.attachmentForms[fdKeyPdf].attachments}" var="sysAttMainx"  varStatus="vstatus">
				<c:set var="attId" value="${sysAttMainx.fdId}" scope="request"/>
			</c:forEach>
			<jsp:include page="/km/imissive/km_imissive_sign_main/kmImissiveSignMain_btn_include2.jsp">
				<jsp:param name="attId" value="${attId}"/>
			</jsp:include>
		</c:when>
		<c:otherwise>
			<div class="lui_form_content_frame">
				<!-- 提示信息 -->
		<%if(ImissiveUtil.isJGEnabled()){%>
				<c:if test="${isShowImg and editStatus != true and isExistViewPath and (isJGMULEnabled or isIE)}">
					<table class="tb_normal" width="100%">
						<tr>
							<td colspan="4">
								<font style="text-align:center"><bean:message  bundle="km-imissive" key="kmMissiveMain.prompt"/></font>
							</td>
						</tr>
					</table>
				</c:if>
				<%} %>
				<c:if test="${editStatus == true or editFlag == true}">
					<kmss:auth requestURL="/km/imissive/km_imissive_sign_main/kmImissiveSignMain.do?method=edit&fdId=${param.fdId}" requestMethod="GET">
						<c:set var="isReadOnly" value="false" scope="request" />
					</kmss:auth>
					<c:if  test="${kmImissiveSignMainForm.sysWfBusinessForm.fdNodeAdditionalInfo.editDocContent =='true' and editFlag != true}">
						<c:set var="isReadOnly" value="false" scope="request" />
					</c:if>
					<div id="missiveButtonDiv">
						<c:if test="${_isWpsCenterEnable}">
							<%--<a href="javascript:void(0);" class="officialSmart" id="smartTypesettingBtn"
							   onclick="smartTypesetting('sign', '${kmImissiveSignMainForm.method_GET}')">
								<c:out value="智能排版" />
							</a>--%>
						</c:if>
						<jsp:include page="/km/imissive/km_imissive_sign_main/kmImissiveSignMain_btn_include.jsp"></jsp:include>
					</div>
					<c:choose>
						<c:when test="${_isWpsCloudEnable}">
							<c:choose>
								<c:when test="${isReadOnly}">
									<c:import url="/sys/attachment/sys_att_main/wps/cloud/sysAttMain_view.jsp" charEncoding="UTF-8">
										<c:param name="fdKey" value="editonline" />
										<c:param name="load" value="false" />
										<c:param name="fdModelId" value="${kmImissiveSignMainForm.fdId}" />
										<c:param name="fdModelName" value="com.landray.kmss.km.imissive.model.KmImissiveSignMain" />
										<c:param name="formBeanName" value="kmImissiveSignMainForm" />
										<c:param  name="contentFlag"  value="true"/>
									</c:import>
								</c:when>
								<c:otherwise>
									<c:import url="/sys/attachment/sys_att_main/wps/cloud/sysAttMain_edit.jsp" charEncoding="UTF-8">
										<c:param name="fdKey" value="editonline" />
										<c:param name="load" value="false" />
										<c:param name="bindSubmit" value="false"/>
										<c:param name="fdModelId" value="${kmImissiveSignMainForm.fdId}" />
										<c:param name="fdModelName" value="com.landray.kmss.km.imissive.model.KmImissiveSignMain" />
										<c:param name="formBeanName" value="kmImissiveSignMainForm" />
										<c:param name="fdTemplateModelId" value="${kmImissiveSignMainForm.fdTemplateId}" />
										<c:param name="fdTemplateModelName" value="com.landray.kmss.km.imissive.model.KmImissiveSignTemplate" />
										<c:param name="fdTemplateKey" value="editonline" />
										<c:param name="fdTempKey" value="${kmImissiveSignMainForm.fdTemplateId}" />
										<c:param name="buttonDiv" value="missiveButtonDiv" />
									</c:import>
								</c:otherwise>
							</c:choose>
						</c:when>
						<c:when test="${_isWpsCenterEnable}">
							<c:choose>
								<c:when test="${isReadOnly}">
									<c:import url="/sys/attachment/sys_att_main/wps/center/sysAttMain_view.jsp" charEncoding="UTF-8">
										<c:param name="fdKey" value="editonline" />
										<c:param name="fdModelId" value="${kmImissiveSignMainForm.fdId}" />
										<c:param name="fdModelName" value="com.landray.kmss.km.imissive.model.KmImissiveSignMain" />
										<c:param name="formBeanName" value="kmImissiveSignMainForm" />
										<c:param  name="contentFlag"  value="true"/>
										<c:param name="load" value="false" />
										<c:param name="wpsPreview" value="0010000" />
									</c:import>
								</c:when>
								<c:otherwise>
									<c:import url="/sys/attachment/sys_att_main/wps/center/sysAttMain_edit.jsp" charEncoding="UTF-8">
										<c:param name="fdKey" value="editonline" />
										<c:param name="load" value="false" />
										<c:param name="bindSubmit" value="false"/>
										<c:param name="fdModelId" value="${kmImissiveSignMainForm.fdId}" />
										<c:param name="fdModelName" value="com.landray.kmss.km.imissive.model.KmImissiveSignMain" />
										<c:param name="formBeanName" value="kmImissiveSignMainForm" />
										<c:param name="fdTemplateModelId" value="${kmImissiveSignMainForm.fdTemplateId}" />
										<c:param name="fdTemplateModelName" value="com.landray.kmss.km.imissive.model.KmImissiveSignTemplate" />
										<c:param name="fdTemplateKey" value="editonline" />
										<c:param name="fdTempKey" value="${kmImissiveSignMainForm.fdTemplateId}" />
										<c:param name="buttonDiv" value="missiveButtonDiv" />
									</c:import>
								</c:otherwise>
							</c:choose>
						</c:when>
						<c:otherwise>
							<c:import url="/sys/attachment/sys_att_main/jg/sysAttMain_edit.jsp" charEncoding="UTF-8">
								<c:param name="fdKey" value="editonline" />
								<c:param name="fdAttType" value="office" />
								<c:param name="fdModelId" value="${kmImissiveSignMainForm.fdId}" />
								<c:param name="fdModelName" value="com.landray.kmss.km.imissive.model.KmImissiveSignMain" />
								<c:param name="formBeanName" value="kmImissiveSignMainForm" />
								<c:param name="bookMarks"  value="${bookmarkJson}" />
								<c:param name="buttonDiv" value="missiveButtonDiv" />
								<c:param name="isReadOnly" value="${isReadOnly}"/>
								<c:param name="isToImg" value="false"/>
								<c:param name="showRevisions" value="<%=KmImissiveConfigUtil.isShowRevision()%>" />
								<c:param name="attHeight" value="566"/>
								<c:param name="loadJg" value="false"/>
							</c:import>
						</c:otherwise>
					</c:choose>
				</c:if>
				<c:if test="${editStatus != true}">
					<%if(("true".equals(KmImissiveConfigUtil.isShowImg())&&"true".equals(KmImissiveConfigUtil.isShowImg4Content()))||"false".equals(KmImissiveConfigUtil.isShowImg())){ %>
					<%--编辑正文 --%>
					<c:if  test="${kmImissiveSignMainForm.sysWfBusinessForm.fdNodeAdditionalInfo.editDocContent =='true' and editFlag != true}">
						<c:choose>
							<c:when test="${isIE}">
								<c:set var="editable" value="true"></c:set>
							</c:when>
							<c:otherwise>
								<c:if test="${isJGMULEnabled}">
									<c:set var="editable" value="true"></c:set>
								</c:if>
							</c:otherwise>
						</c:choose>
					</c:if>
					<%} %>
					<div id="missiveButtonDiv">
						<jsp:include page="/km/imissive/km_imissive_sign_main/kmImissiveSignMain_btn_include.jsp"></jsp:include>
						<c:if test="${editable eq true}">
							<a href="javascript:void(0);" class="editContent com_btn_link"
							   onclick="Com_OpenWindow('kmImissiveSignMain.do?method=view&fdId=${JsParam.fdId}&editFlag=true','_self');">
								编辑正文
							</a>
						</c:if>
						<%if(("true".equals(KmImissiveConfigUtil.isShowImg())&&"true".equals(KmImissiveConfigUtil.isShowImg4Content()))||"false".equals(KmImissiveConfigUtil.isShowImg())){ %>
						<c:if  test="${kmImissiveSignMainForm.sysWfBusinessForm.fdNodeAdditionalInfo.editDocContent =='true' and editFlag == true}">
							<a href="javascript:void(0);" class="back com_btn_link"
							   onclick="Com_OpenWindow('kmImissiveSignMain.do?method=view&fdId=${JsParam.fdId}','_self');">
								返回
							</a>
						</c:if>
						<%} %>
					</div>
					<c:import url="/sys/attachment/sys_att_main/jg/sysAttMain_include_viewHtml.jsp" charEncoding="UTF-8">
						<c:param name="fdKey" value="editonline" />
						<c:param name="fdAttType" value="office" />
						<c:param name="isLoadJG" value="false" />
						<c:param name="fdModelId" value="${kmImissiveSignMainForm.fdId}" />
						<c:param name="fdModelName" value="com.landray.kmss.km.imissive.model.KmImissiveSignMain" />
						<c:param name="formBeanName" value="kmImissiveSignMainForm" />
						<c:param  name="contentFlag"  value="true"/>
						<c:param  name="protectstatus"  value="${protectstatus}"/>
						<c:param  name="bookMarks" value="${bookmarkJson}" />
						<c:param name="buttonDiv" value="missiveButtonDiv" />
						<c:param name="isShowImg" value="${isShowImg}"/>
						<c:param  name="showAllPage"  value="${showAllPage}"/>
						<c:param name="loadJg" value="false"/>
					</c:import>
				</c:if>
			</div>
		</c:otherwise>
	</c:choose>
</c:if>
<c:if test="${kmImissiveSignMainForm.docStatus ne '30'}">
	<c:if test="${not empty kmImissiveSignMainForm.attachmentForms[fdKeyPdf].attachments}">
		<table class="tb_normal" width="100%" style="margin-top: 16px">
			<tr>
				<td class="td_normal_title" width="15%">最新签署文件</td>
				<td colspan="3" width="85.0%">
					最新签署文件
					<c:import url="/sys/attachment/sys_att_main/sysAttMain_view.jsp" charEncoding="UTF-8">
						<c:param name="fdKey" value="${fdKeyPdf}" />
						<c:param name="fdModelName"
								 value="com.landray.kmss.km.imissive.model.KmImissiveSignMain" />
						<c:param name="fdModelId" value="${param.formId}" />
					</c:import>
				</td>
			</tr>
		</table>
	</c:if>
</c:if>

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
				officeIframeh = contentH-70;
			}
			if($('#office-iframe')){
				$('#office-iframe').height((officeIframeh)+"px");
			}
		},100);
	});
</script>
