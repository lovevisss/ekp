<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="com.landray.kmss.sys.attachment.integrate.wps.util.SysAttWpsCloudUtil" %>
<%@page import="com.landray.kmss.sys.attachment.integrate.wps.util.SysAttWpsCenterUtil" %>
<%@ page import="com.landray.kmss.sys.attachment.util.SysAttConfigUtil" %>
<%@page import="com.landray.kmss.km.imissive.util.KmImissiveConfigUtil"%>
<%@page import="com.landray.kmss.km.imissive.service.IKmImissiveSendMainService"%>
<%@page import="com.landray.kmss.util.SpringBeanUtil"%>
<%@page import="com.landray.kmss.util.StringUtil" %>
<%@page import="com.landray.kmss.sys.attachment.service.ISysAttMainCoreInnerService"%>
<%@page import="com.landray.kmss.sys.attachment.model.SysAttMain"%>
<%@page import="com.landray.kmss.sys.attachment.util.SysAttViewerUtil" %>
<%@ page import="com.landray.kmss.common.forms.IExtendForm" %>
<%
	String formBeanName = request.getParameter("formBeanName");
	Object formBean = null;

	if(formBeanName != null && formBeanName.trim().length() != 0){
		formBean = pageContext.getAttribute(formBeanName);
		if(formBean == null){
			formBean = request.getAttribute(formBeanName);
		}
		if(formBean == null){
			formBean = session.getAttribute(formBeanName);
		}
		pageContext.setAttribute("_formBean", formBean);
	}else{
		formBeanName = "com.landray.kmss.web.taglib.FormBean";
	}
	pageContext.setAttribute("com.landray.kmss.web.taglib.FormBean", formBean);
	if(formBean == null){
		formBean = com.landray.kmss.web.taglib.TagUtils.getInstance().lookup(pageContext,
				formBeanName, null);
		pageContext.setAttribute("_formBean", formBean);
	}
%>
<%
	pageContext.setAttribute("_isWpsCloudEnable", new Boolean(SysAttWpsCloudUtil.isEnable(true)));//云文档移动端
	pageContext.setAttribute("_isWpsCenterEnable", new Boolean(SysAttWpsCenterUtil.isWPSCenterEnableMobile(true)));//中台移动端
	pageContext.setAttribute("_wpsPreviewIsLinux", new Boolean(SysAttWpsCloudUtil.checkWpsPreviewIsLinux()));//是否开启wps在线预览
	pageContext.setAttribute("_readOLConfig", new String(SysAttConfigUtil.getReadOLConfig()));//pc预览
	pageContext.setAttribute("_jGForMobile", new String(SysAttConfigUtil.getMobileOnlineToolType()));//是否是金格移动端
	pageContext.setAttribute("_isWpsCenterBt", new Boolean(SysAttConfigUtil.isWpsCenterEnabled()));//中台是否开启
	pageContext.setAttribute("_onlineToolType", new String(SysAttConfigUtil.getOnlineToolType()));//pc在线编辑配置
%>

<%-- #144713 开启wps中台时，正文为空，则pc端和移动端均需要去掉正文页签 --%>
<c:set var="isShowContentTabpanel" value="false"/>
<c:choose>
    <c:when test="${_isWpsCenterEnable}">
        <c:choose>
            <c:when test="${_formBean.fdNeedContent eq '0' and not empty _formBean.attachmentForms['mainonline'].attachments}">
                <c:set var="isShowContentTabpanel" value="true"/>
            </c:when>
            <c:when test="${_formBean.fdNeedContent eq '1' and not empty _formBean.attachmentForms['editonline'].attachments}">
                <c:set var="isShowContentTabpanel" value="true"/>
            </c:when>
        </c:choose>
    </c:when>
    <c:when test="${not empty _formBean.attachmentForms['editonline'].attachments or not empty _formBean.attachmentForms['mainonline'].attachments}">
        <c:set var="isShowContentTabpanel" value="true"/>
    </c:when>
</c:choose>



<%--兼容专业版升级政企版附件显示--%>
<c:set var="existAtt" value="false" scope="request"/>
<c:if test="${not empty _formBean.attachmentForms['attachment'].attachments}">
	<c:set var="existAtt" value="true" scope="request"/>
</c:if>

<%--流版签与正文内容信息--%>
<c:if test="${'true' eq isShowContentTabpanel}">
	<c:choose>
		<c:when test="${_formBean.fdNeedContent=='1'}">
			<c:set var="attForms" value="${_formBean.attachmentForms['editonline']}"/>
		</c:when>
		<c:otherwise>
			<c:set var="attForms" value="${_formBean.attachmentForms['mainonline']}"/>
		</c:otherwise>
	</c:choose>
	<c:if test="${attForms!=null && fn:length(attForms.attachments)>0}">
		<c:forEach var="sysAttMain" items="${attForms.attachments}" varStatus="vsStatus">
			<c:set var="attMainId" value="${sysAttMain.fdId }" scope="request"></c:set>
			<c:set var="fdAttMainId" value="${sysAttMain.fdId }" scope="request"></c:set>
			<%
				SysAttMain sysAttMain = (SysAttMain) pageContext
						.getAttribute("sysAttMain");
				String path = SysAttViewerUtil.getViewerPath(
						sysAttMain, request);
				if (StringUtil.isNotNull(path)) {
					pageContext.setAttribute("hasThumbnail", "true");
					pageContext.setAttribute("hasViewer", "true");
				}
				pageContext.setAttribute("_sysAttMain", sysAttMain);
			%>
		</c:forEach>
	</c:if>
	<c:set var="fdYqqKeyPdf" value="yqqSigned" />
	<c:set var="fdEqbKeyPdf" value="eqbSign" />
	<c:set var="fdEqbKeyOfd" value="ofdEqbSign" />
	<c:set var="fdCyKeyOfd" value="ofdCySign" />
	<c:set var="fdDianjuSign" value="dianjuSign" />
	<c:set var="fdSsKeyOfd" value="ofdSursenSign" />
	<c:set var="fdConvertPdf" value="convert_toPDF" />
	<c:set var="fdConvertOfd" value="convert_toOFD" />
	<c:choose>
		<c:when  test="${not empty _formBean.attachmentForms[fdYqqKeyPdf].attachments}">
			<c:set var="signedKey" value="yqqSigned" scope="request"/>
		</c:when>
		<c:when test="${not empty _formBean.attachmentForms[fdEqbKeyPdf].attachments}">
			<c:set var="signedKey" value="eqbSign" scope="request"/>
		</c:when>
		<c:when test="${not empty _formBean.attachmentForms[fdEqbKeyOfd].attachments}">
			<c:set var="signedKey" value="ofdEqbSign" scope="request"/>
		</c:when>
		<c:when test="${not empty _formBean.attachmentForms[fdCyKeyOfd].attachments}">
			<c:set var="signedKey" value="ofdCySign" scope="request"/>
		</c:when>
		<c:when test="${not empty _formBean.attachmentForms[fdDianjuSign].attachments}">
			<c:set var="signedKey" value="dianjuSign" scope="request"/>
		</c:when>
		<c:when test="${not empty _formBean.attachmentForms[fdSsKeyOfd].attachments}">
			<c:set var="signedKey" value="ofdSursenSign" scope="request"/>
		</c:when>
		<c:when test="${not empty _formBean.attachmentForms[fdConvertPdf].attachments}">
			<c:set var="signedKey" value="convert_toPDF" scope="request"/>
		</c:when>
		<c:when test="${not empty _formBean.attachmentForms[fdConvertOfd].attachments}">
			<c:set var="signedKey" value="convert_toOFD" scope="request"/>
		</c:when>
		<c:otherwise>
			<c:set var="signedKey" value="" scope="request"/>
		</c:otherwise>
	</c:choose>
	<c:if test="${not empty _formBean.attachmentForms[signedKey].attachments}">
		<%
			IKmImissiveSendMainService kmImissiveSendMainService = (IKmImissiveSendMainService) SpringBeanUtil.getBean("kmImissiveSendMainService");
			String signedKey = (String) request.getAttribute("signedKey");
			IExtendForm form = (IExtendForm)pageContext.getAttribute("_formBean");
			String attId=kmImissiveSendMainService.findLaTestAtt(form.getFdId(), signedKey);
			request.setAttribute("attId", attId);
		%>
	</c:if>
	<%
		String fdAttId = (String)request.getAttribute("attId");
		if(StringUtil.isNull(fdAttId)){
			fdAttId = (String)request.getAttribute("attMainId");
		}
		boolean canViewOnline = false;
		boolean canEditOnline = false;
		ISysAttMainCoreInnerService sysAttMainService = (ISysAttMainCoreInnerService)SpringBeanUtil.getBean("sysAttMainService");
		SysAttMain sysAttMain = (SysAttMain) sysAttMainService.findByPrimaryKey(fdAttId);
		if(sysAttMain != null) {
			String suffix = sysAttMain.getFdFileName().substring(sysAttMain.getFdFileName().lastIndexOf(".") + 1).toLowerCase();
			boolean wpsCloudEnable = SysAttWpsCloudUtil.isEnable(true);
			boolean wpsCenterEnable = SysAttWpsCenterUtil.isWPSCenterEnableMobile(true);
			boolean wpsPreviewIsLinux = SysAttWpsCloudUtil.checkWpsPreviewIsLinux();
			if ("doc".equals(suffix) || "docx".equals(suffix) || "wps".equals(suffix)) {
				request.setAttribute("attType", "word");
				canViewOnline = true;
				canEditOnline = true;
			} else if (("pdf".equals(suffix) || "ofd".equals(suffix))
					&& (wpsCloudEnable || wpsPreviewIsLinux || wpsCenterEnable)) {
				canViewOnline = true;
				request.setAttribute("attType", suffix);
			}
		}
		request.setAttribute("canViewOnline", canViewOnline);
		request.setAttribute("canEditOnline", canEditOnline);
	%>
</c:if>