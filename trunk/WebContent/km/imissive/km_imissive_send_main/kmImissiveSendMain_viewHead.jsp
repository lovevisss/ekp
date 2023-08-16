<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/sys/ui/jsp/common.jsp"%>
<%@page import="com.landray.kmss.util.ResourceUtil"%>
<%@page import="com.landray.kmss.sys.attachment.model.SysAttMain"%>
<%@page import="com.landray.kmss.sys.lbpmservice.support.model.LbpmSetting" %>
<%@page import="com.landray.kmss.sys.attachment.util.JgWebOffice"%>
<%@page import="com.landray.kmss.km.imissive.util.KmImissiveConfigUtil"%>
<%@page import="com.landray.kmss.km.imissive.forms.KmImissiveSendMainForm"%>
<%@ page import="com.landray.kmss.util.IDGenerator"%>
<%@page import="com.landray.kmss.util.StringUtil"%>
<%@page import="com.landray.kmss.sys.webservice2.util.SysWsUtil"%>
<%@page import="com.landray.kmss.sys.attachment.integrate.wps.util.SysAttWpsCloudUtil"%>
<%@page import="com.landray.kmss.sys.attachment.integrate.wps.util.SysAttWpsCenterUtil"%>
<%@ page import="com.landray.kmss.km.imissive.util.ImissiveUtil"%>
<%@ page import="com.landray.kmss.util.UserUtil" %>
<%@ page import="com.landray.kmss.sys.attachment.util.SysAttConfigUtil" %>
<%@ page import="com.landray.kmss.sys.ui.util.PcJsOptimizeUtil" %>
<c:set var="wpsoaassist" value="<%=ImissiveUtil.isEnable()%>"/>
<%
	pageContext.setAttribute("_isWpsCloudEnable", new Boolean(ImissiveUtil.isEnableWpsCloud()));
	pageContext.setAttribute("_isWpsCenterEnable", new Boolean(SysAttWpsCenterUtil.isEnable()));
%>
<template:replace name="preloadJs">
	<c:choose>
		<c:when test="${compressSwitch eq 'true' && lfn:jsCompressEnabled('kmImissiveCompressExecutor', 'km_imissive_view_comJs_combined')}">
			<script src="<%= PcJsOptimizeUtil.getScriptSrcByExtension("kmImissiveCompressExecutor","km_imissive_view_comJs_combined") %>?s_cache=${ LUI_Cache }">
			</script>
		</c:when>
	</c:choose>
</template:replace>
<template:replace name="title">
	<c:out
		value="${ kmImissiveSendMainForm.docSubject } - ${ lfn:message('km-imissive:module.km.imissive') }"></c:out>
</template:replace>
<template:replace name="head">
	<style>
	 	.handle_source_url{color: #57a7da !important;}
		.handle_source_url:hover{color: #4285f4 !important;text-decoration: underline;}
	</style>
<script>
    Com_IncludeFile("data.js|jquery.js");
    Com_IncludeFile('styles.css|jquery.ui.widget.js|jquery.marcopolo.js|jquery.manifest.js','js/jquery-plugin/manifest/');
</script>
</template:replace>
<template:replace name="toolbar">
	<%
		//out.print(request.getHeader("User-Agent"));
			if (request.getHeader("User-Agent").toUpperCase().indexOf("MSIE") > -1) {
				request.setAttribute("isIE", true);
			} else if (request.getHeader("User-Agent").toUpperCase().indexOf("TRIDENT") > -1) {
				request.setAttribute("isIE", true);
			} else {
				request.setAttribute("isIE", false);
			}
			String isJGSignatureHTMLEnabled = ResourceUtil.getKmssConfigString("sys.att.isJGSignatureHTMLEnabled");
			request.setAttribute("JGSignatureHTMLEnabled",isJGSignatureHTMLEnabled);
			
			request.setAttribute("jg_LoginUserId", UserUtil.getKMSSUser(request).getPerson().getFdId());
	%>
	<c:if test="${kmImissiveSendMainForm.fdNeedContent=='0'}">
		<c:set var="contentKey" value="mainonline" scope="request"/>
		<c:set var="fdKeyPdf" value="mainonline_pdf" scope="request"/>
	</c:if>
	<c:if test="${kmImissiveSendMainForm.fdNeedContent=='1'}">
		<c:set var="contentKey" value="editonline" scope="request"/>
		<c:set var="fdKeyPdf" value="editonline_pdf" scope="request"/>
	</c:if>
	<c:set var="existAtt" value="false" scope="request"/>
	<c:if test="${not empty kmImissiveSendMainForm.attachmentForms['attachment'].attachments}">
		<c:set var="existAtt" value="true" scope="request"/>
	</c:if>
	<c:if test="${fn:length(kmImissiveSendMainForm.attachmentForms[contentKey].attachments)==1}">
		<c:set var="sysAttMain" value="${kmImissiveSendMainForm.attachmentForms[contentKey].attachments[0]}" scope="request" />
		<%
			SysAttMain sysAttMain = (SysAttMain) request.getAttribute("sysAttMain");
			String suffix = sysAttMain.getFdFileName()
					.substring(sysAttMain.getFdFileName().lastIndexOf(".") + 1).toLowerCase();
			if (StringUtil.isNotNull(suffix) && ("doc".equals(suffix) || "docx".equals(suffix) || "wps".equals(suffix))) {
				request.setAttribute("attType", "word");
			}
			request.setAttribute("attFileType", suffix);
		%>
	</c:if>
	<!-- 软删除配置 -->
	<c:if test="${kmImissiveSendMainForm.docDeleteFlag ==1}">
		<ui:toolbar id="toolbar" count="6" style="display:none;"></ui:toolbar>
	</c:if>
	<c:if test="${kmImissiveSendMainForm.docDeleteFlag !=1}">
		<ui:toolbar id="toolbar" layout="sys.ui.toolbar.float" count="6"
			var-navwidth="90%" style="display:none;">
			<%-- <ui:toolbar  id="toolbar" layout="sys.ui.toolbar.float" count="5"> --%>
			<c:if test="${kmImissiveSendMainForm.fdIsFiling != true}">
				<c:if test="${kmImissiveSendMainForm.docStatus ne '00'}">
					<kmss:auth
							requestURL="/km/imissive/km_imissive_send_main/kmImissiveSendMain.do?method=edit&fdId=${param.fdId}"
							requestMethod="GET">
						<ui:button text="${lfn:message('button.edit') }" order="4"
							onclick="editDoc();">
						</ui:button>
					</kmss:auth>
				</c:if>
				<c:set var="distribute" value="false" scope="request"></c:set>
				<c:set var="report" value="false" scope="request"></c:set>
				<c:if test="${kmImissiveSendMainForm.docStatus=='30' and kmImissiveSendMainForm.fdIsFiling!= true}">
					<kmss:auth
						requestURL="/km/imissive/km_imissive_send_main/kmImissiveSendMain.do?method=editDocNum&fdId=${param.fdId}"
						requestMethod="GET">
						<c:choose>
							<c:when test="${not empty  kmImissiveSendMainForm.fdDocNum and not empty kmImissiveSendMainForm.fdFlowNo}">
								<ui:button text="${lfn:message('km-imissive:kmImissiveSendMain.editdocnum') }"
									order="4" onclick="editDocNum();">
								</ui:button>
							</c:when>
							<c:otherwise>
								<ui:button id="generateFileNum4Publsh" text="生成编号" order="2" onclick="generateFileNum4Publsh();">
								</ui:button>
							</c:otherwise>
						</c:choose>
					</kmss:auth>
					<kmss:auth
						requestURL="/km/imissive/km_imissive_send_main/kmImissiveSendMain.do?method=distribute&fdId=${param.fdId}"
						requestMethod="GET">
						<c:set var="distribute" value="true" scope="request"></c:set>
					</kmss:auth>
					<kmss:auth
						requestURL="/km/imissive/km_imissive_send_main/kmImissiveSendMain.do?method=report&fdId=${param.fdId}"
						requestMethod="GET">
						<c:set var="report" value="true" scope="request"></c:set>
					</kmss:auth>
					<c:if test="${kmImissiveSendMainForm.fdSuperviseFlag ne true and not empty fdSuperviseId }">
						<ui:button text="核发督办" id="confirmSuperVisedBtn" style="vertical-align:top;"  onclick="confirmSupervised();"></ui:button>
					</c:if>
				</c:if>
				<%--分发 --%>
				<c:if test="${kmImissiveSendMainForm.fdMissiveType !=  '2'}">
					<c:if
						test="${kmImissiveSendMainForm.sysWfBusinessForm.fdNodeAdditionalInfo.distribute =='true'}">
						<c:set var="distribute" value="true" scope="request"></c:set>
					</c:if>
					<c:if test="${distribute eq 'true'}">
						<ui:button
							text="${lfn:message('km-imissive:kmImissiveSendMain.distribute') }"
							order="4" onclick="distributeDoc();">
						</ui:button>
					</c:if>
				</c:if>
				<%--上报 --%>
				<c:if test="${kmImissiveSendMainForm.fdMissiveType != '1'}">
					<c:if
						test="${kmImissiveSendMainForm.sysWfBusinessForm.fdNodeAdditionalInfo.report =='true'}">
						<c:set var="report" value="true" scope="request"></c:set>
					</c:if>
					<c:if test="${report eq 'true'}">
						<ui:button
							text="${lfn:message('km-imissive:kmImissiveSendMain.report') }"
							order="4" onclick="report();">
						</ui:button>
					</c:if>
				</c:if>
				<c:if test="${kmImissiveSendMainForm.docStatus =='20'}">
					<c:if test="${kmImissiveSendMainForm.sysWfBusinessForm.fdNodeAdditionalInfo.saveRevisions =='true' and attType eq 'word' and signAttsFlag ne true}">
							<c:if test="${kmImissiveSendMainForm.fdNeedContent=='0'}">
								<c:choose>
									<c:when test="${wpsoaassist eq 'true'}">
									</c:when>
									<c:when test="${_isWpsCloudEnable}">
										<ui:button text="${lfn:message('km-imissive:kmImissive.saveRevisions') }"
											order="2" onclick="saveRevisionsByWps('mainonline');">
										</ui:button>
									</c:when>
									<c:when test="${_isWpsCenterEnable}">
										<ui:button text="${lfn:message('km-imissive:kmImissive.saveRevisions') }"
												   order="2" onclick="saveRevisionsByWpsCenter('mainonline');">
										</ui:button>
									</c:when>
									<c:otherwise>
										<ui:button text="${lfn:message('km-imissive:kmImissive.saveRevisions') }"
											order="2" onclick="saveRevisions('mainonline');">
										</ui:button>
									</c:otherwise>
								</c:choose>	
							</c:if>
							<c:if test="${kmImissiveSendMainForm.fdNeedContent=='1'}">
								<c:choose>
									<c:when test="${wpsoaassist eq 'true'}">
									</c:when>
									<c:when test="${_isWpsCloudEnable}">
										<ui:button text="${lfn:message('km-imissive:kmImissive.saveRevisions') }"
											order="2" onclick="saveRevisionsByWps('editonline');">
										</ui:button>
									</c:when>
									<c:when test="${_isWpsCenterEnable}">
										<ui:button text="${lfn:message('km-imissive:kmImissive.saveRevisions') }"
												   order="2" onclick="saveRevisionsByWpsCenter('editonline');">
										</ui:button>
									</c:when>
									<c:otherwise>
										<ui:button text="${lfn:message('km-imissive:kmImissive.saveRevisions') }"
											order="2" onclick="saveRevisions('editonline');">
										</ui:button>
									</c:otherwise>
								</c:choose>	
							</c:if>
					</c:if>
					<%-- 稿纸签章--%>
					<c:if
						test="${kmImissiveSendMainForm.sysWfBusinessForm.fdNodeAdditionalInfo.signaturehtml =='true'}">
						<c:if test="${JGSignatureHTMLEnabled == 'true'}">
							<ui:button
								text="${lfn:message('km-imissive:kmImissive.sightml') }"
								order="1" onclick="DoSXSignature()"></ui:button>
						</c:if>
					</c:if>

					<%-- 书生ofd签章--%>
					<c:if test="${kmImissiveSendMainForm.sysWfBusinessForm.fdNodeAdditionalInfo.ofdSursenSign =='true'}">
						<ui:button text="${lfn:message('km-imissive:kmImissive.ofdSursenSign') }" order="1" onclick="ofdSursen('${contentKey}')"></ui:button>
					</c:if>

					<c:if
						test="${attType eq 'word' and signAttsFlag ne true}">
						<%-- 清稿附加选项 --%>
						<c:if
							test="${kmImissiveSendMainForm.sysWfBusinessForm.fdNodeAdditionalInfo.cleardraft =='true'}">
							<c:if test="${kmImissiveSendMainForm.fdNeedContent=='0'}">
								<c:choose>
									<c:when test="${wpsoaassist eq 'true'}">
									</c:when>
									<c:when test="${_isWpsCloudEnable}">
										<ui:button
											text="${lfn:message('km-imissive:kmImissiveSendMain.cleardraft') }"
											order="3" onclick="cleardraftByWps('mainonline');">
										</ui:button>
									</c:when>
									<c:when test="${_isWpsCenterEnable}">
										<ui:button
												text="${lfn:message('km-imissive:kmImissiveSendMain.cleardraft') }"
												order="3" onclick="cleardraftByWpsCenter('mainonline');">
										</ui:button>
									</c:when>
									<c:otherwise>
										<ui:button
											text="${lfn:message('km-imissive:kmImissiveSendMain.cleardraft') }"
											order="3" onclick="cleardraft('mainonline');">
										</ui:button>
									</c:otherwise>
								</c:choose>
							</c:if>
							<c:if test="${kmImissiveSendMainForm.fdNeedContent=='1'}">
								<c:choose>
									<c:when test="${wpsoaassist eq 'true'}">
									</c:when>
									<c:when test="${_isWpsCloudEnable}">
										<ui:button
											text="${lfn:message('km-imissive:kmImissiveSendMain.cleardraft') }"
											order="3" onclick="cleardraftByWps('editonline');">
										</ui:button>
									</c:when>
									<c:when test="${_isWpsCenterEnable}">
										<ui:button
												text="${lfn:message('km-imissive:kmImissiveSendMain.cleardraft') }"
												order="3" onclick="cleardraftByWpsCenter('editonline');">
										</ui:button>
									</c:when>
									<c:otherwise>
										<ui:button
											text="${lfn:message('km-imissive:kmImissiveSendMain.cleardraft') }"
											order="3" onclick="cleardraft('editonline');">
										</ui:button>
									</c:otherwise>
								</c:choose>
								
							</c:if>
						</c:if>
						<%-- 套红附加选项 --%>
						<c:if
							test="${kmImissiveSendMainForm.sysWfBusinessForm.fdNodeAdditionalInfo.redhead =='true'}">
							<c:if test="${kmImissiveSendMainForm.fdNeedContent=='0'}">
								<c:choose>
									<c:when test="${wpsoaassist eq 'true'}">
									</c:when>
									<c:when test="${_isWpsCloudEnable}">
										<ui:button
											text="${lfn:message('km-imissive:kmImissive.redhead') }"
											order="2"
											onclick="LoadWpsHeadWordList('com.landray.kmss.km.imissive.model.KmImissiveSendMain','mainonline');">
										</ui:button>
									</c:when>
									<c:when test="${_isWpsCenterEnable}">
										<ui:button
												text="${lfn:message('km-imissive:kmImissive.redhead') }"
												order="2"
												onclick="LoadWpsCenterHeadWordList('com.landray.kmss.km.imissive.model.KmImissiveSendMain','mainonline');">
										</ui:button>
									</c:when>
									<c:otherwise>
										<ui:button
											text="${lfn:message('km-imissive:kmImissive.redhead') }"
											order="2"
											onclick="LoadHeadWordList('com.landray.kmss.km.imissive.model.KmImissiveSendMain','mainonline');">
										</ui:button>
									</c:otherwise>
								</c:choose>
							</c:if>
							<c:if test="${kmImissiveSendMainForm.fdNeedContent=='1'}">
								<c:choose>
									<c:when test="${wpsoaassist eq 'true'}">
									</c:when>
									<c:when test="${_isWpsCloudEnable}">
										<ui:button
											text="${lfn:message('km-imissive:kmImissive.redhead') }"
											order="2"
											onclick="LoadWpsHeadWordList('com.landray.kmss.km.imissive.model.KmImissiveSendMain','editonline');">
										</ui:button>
									</c:when>
									<c:when test="${_isWpsCenterEnable}">
										<ui:button
												text="${lfn:message('km-imissive:kmImissive.redhead') }"
												order="2"
												onclick="LoadWpsCenterHeadWordList('com.landray.kmss.km.imissive.model.KmImissiveSendMain','editonline');">
										</ui:button>
									</c:when>
									<c:otherwise>
										<ui:button
											text="${lfn:message('km-imissive:kmImissive.redhead') }"
											order="2"
											onclick="LoadHeadWordList('com.landray.kmss.km.imissive.model.KmImissiveSendMain','editonline');">
										</ui:button>
									</c:otherwise>
								</c:choose>
							</c:if>
						</c:if>
						<!-- 签章附加选项 -->
						<kmss:ifModuleExist path="/km/signature/">
								<c:if
									test="${kmImissiveSendMainForm.sysWfBusinessForm.fdNodeAdditionalInfo.sigzq =='true'}">
									<c:if test="${kmImissiveSendMainForm.fdNeedContent=='0'}">
										<c:choose>
											<c:when test="${wpsoaassist eq 'true'}">
											</c:when>
											<c:when test="${_isWpsCloudEnable}">
											</c:when>
											<c:when test="${_isWpsCenterEnable}">
											</c:when>
											<c:otherwise>
												<ui:button
														text="${lfn:message('km-imissive:kmImissive.sigzq') }"
														order="2" onclick="WebOpenSignature('mainonline','${jg_LoginUserId}');">
												</ui:button>
											</c:otherwise>
										</c:choose>
									</c:if>
									<c:if test="${kmImissiveSendMainForm.fdNeedContent=='1'}">
										<c:choose>
											<c:when test="${wpsoaassist eq 'true'}">
											</c:when>
											<c:when test="${_isWpsCloudEnable}">
											</c:when>
											<c:when test="${_isWpsCenterEnable}">
											</c:when>
											<c:otherwise>
												<ui:button
														text="${lfn:message('km-imissive:kmImissive.sigzq') }"
														order="2" onclick="WebOpenSignature('editonline','${jg_LoginUserId}');">
												</ui:button>
											</c:otherwise>
										</c:choose>
									</c:if>
								</c:if>
						</kmss:ifModuleExist>
					</c:if>
				</c:if>
				<%-- 归档 --%>
				<c:if test="${kmImissiveSendMainForm.docStatus == '30' || kmImissiveSendMainForm.docStatus == '00'}">
					<c:import url="/sys/archives/include/sysArchivesFileButton.jsp" charEncoding="UTF-8">
						<c:param name="fdId" value="${param.fdId}" />
						<c:param name="fdModelName" value="com.landray.kmss.km.imissive.model.KmImissiveSendMain" />
						<c:param name="serviceName" value="kmImissiveSendMainService" />
						<c:param name="userSetting" value="true" />
						<c:param name="cateName" value="fdTemplate" />
						<c:param name="moduleUrl" value="km/imissive" />
					</c:import>
				</c:if>
			</c:if>
			
			<c:if test="${kmImissiveSendMainForm.sysWfBusinessForm.fdNodeAdditionalInfo.yqqSignzq =='true' && yqqFlag=='true'}">
				<c:if test="${not empty kmImissiveSendMainForm.attachmentForms['editonline'].attachments or not empty kmImissiveSendMainForm.attachmentForms['mainonline'].attachments}">
			     	 <c:if test="${kmImissiveSendMainForm.fdNeedContent=='0'}">
				     	 <%-- 集成了易企签、勾选了附件选项 --%>
				      	 <ui:button text="${lfn:message('km-imissive:kmImissive.sign.zhixingqianshu')}" onclick="yqq('mainonline');" order="2" />
			      	 </c:if>
			      	  <c:if test="${kmImissiveSendMainForm.fdNeedContent=='1'}">
				     	 <%-- 集成了易企签、勾选了附件选项 --%>
				      	 <ui:button text="${lfn:message('km-imissive:kmImissive.sign.zhixingqianshu')}" onclick="yqq('editonline');" order="2" />
			      	 </c:if>
		      	 </c:if>
		    </c:if>

			<c:if test="${kmImissiveSendMainForm.sysWfBusinessForm.fdNodeAdditionalInfo.eqbSign =='true'}">
				<ui:button text="发送e签宝PDF签署" onclick="eqb('PDF')" order="1" />
			</c:if>
			<c:if test="${kmImissiveSendMainForm.sysWfBusinessForm.fdNodeAdditionalInfo.ofdEqbSign =='true'}">
				<ui:button text="发送e签宝OFD签署" onclick="eqb('OFD')" order="1" />
			</c:if>
					<%-- 本地化电子签署 --%>
         	<%--  <c:if test="${eSignatureModuleExist=='true'&&kmImissiveSendMainForm.sysWfBusinessForm.fdNodeAdditionalInfo.sign == 'true'}">
		         	<c:import url="/elec/signature/elec_signature_task/import/sign_task_btns.jsp">
					    <c:param name="modelId" value="${kmImissiveSendMainForm.fdId}"></c:param>
					   	<c:param name="formBeanName" value="kmImissiveSendMainForm"></c:param>
					</c:import>
			</c:if> --%>
			<c:if test="${eSignatureModuleExist=='true'&&kmImissiveSendMainForm.sysWfBusinessForm.fdNodeAdditionalInfo.sign == 'true'}">
				<ui:button id="signBtn" text="签署" onclick="cfca()"></ui:button>
			</c:if>

			<c:if test="${kmImissiveSendMainForm.sysWfBusinessForm.fdNodeAdditionalInfo.convertPdf =='true' and 'word' eq attType and signAttsFlag ne true}">
				<ui:button text="转pdf" onclick="convertFileType('pdf')"></ui:button>
			</c:if>
			<c:if test="${kmImissiveSendMainForm.sysWfBusinessForm.fdNodeAdditionalInfo.convertOfd =='true' and 'word' eq attType and signAttsFlag ne true}">
				<ui:button text="转ofd" onclick="convertFileType('ofd')"></ui:button>
			</c:if>
		    
		    <!-- 纳入议题 -->
			<c:if test="${kmImissiveSendMainForm.sysWfBusinessForm.fdNodeAdditionalInfo.addTopic eq 'true'}">
				<c:import url="/km/imeeting/include/km_imeeting_topic/kmImeetingTopicButton.jsp" charEncoding="UTF-8">
					<c:param name="formName" value="kmImissiveSendMainForm" />
					<c:param name="fdModelId" value="${param.fdId}" />
					<c:param name="fdModelName" value="com.landray.kmss.km.imissive.model.KmImissiveSendMain" />
				</c:import>
			</c:if>
			<!-- 沉淀-->
			<c:if test="${kmImissiveSendMainForm.docStatus == '30' || kmImissiveSendMainForm.docStatus == '00'}">
				<kmss:auth requestURL="/kms/multidoc/kms_multidoc_subside/kmsMultidocSubside.do?method=fileDoc&modelName=com.landray.kmss.km.imissive.model.KmImissiveSendMain&fdId=${param.fdId}" requestMethod="GET">
					<c:import url="/kms/multidoc/kms_multidoc_subside/subsideButton.jsp" charEncoding="UTF-8">
						<c:param name="fdId" value="${param.fdId}" />
						<c:param name="fdModelName" value="com.landray.kmss.km.imissive.model.KmImissiveSendMain" />
						<c:param name="serviceName" value="kmImissiveSendMainService" />
					</c:import>
				</kmss:auth>
			</c:if>	
			<c:if test="${kmImissiveSendMainForm.docStatus!='10'}">
				<kmss:auth
					requestURL="/km/imissive/km_imissive_send_main/kmImissiveSendMain.do?method=print&fdId=${param.fdId}&s_xform=${kmImissiveSendMainForm.sysWfBusinessForm.fdSubFormId}"
					requestMethod="GET">
					<ui:button text="${lfn:message('button.print') }" order="4"
						onclick="printDoc();">
					</ui:button>
				</kmss:auth>
				<%
				String isTstudyEnabled = ResourceUtil.getKmssConfigString("sys.tstudy.enable");
				LbpmSetting lbpmSetting = new LbpmSetting();
				if(lbpmSetting.getIsHandSignatureEnabled().equalsIgnoreCase("true") 
						&& "true".equalsIgnoreCase(isTstudyEnabled)
						&& lbpmSetting.getHandSignatureType().equalsIgnoreCase("tsd")){
				%>
				<!-- 点阵打印 -->
				<ui:button order="4" text="${ lfn:message('sys-lbpmservice-support:lbpmSetting.handSignatureType.print') }" 
					onclick="Com_OpenWindow('${KMSS_Parameter_ContextPath}km/imissive/km_imissive_send_main/kmImissiveSendMain.do?method=printLattice&fdId=${param.fdId}');">
				</ui:button>
				<%}%>
			</c:if>
			<c:if
				test="${kmImissiveSendMainForm.fdDistributeTime == null and kmImissiveSendMainForm.fdReportTime == null}">
				<kmss:auth
					requestURL="/km/imissive/km_imissive_send_main/kmImissiveSendMain.do?method=delete&fdId=${param.fdId}"
					requestMethod="GET">
					<ui:button text="${lfn:message('button.delete') }" order="4"
						onclick="Delete('kmImissiveSendMain.do?method=delete&fdId=${param.fdId}');">
					</ui:button>
				</kmss:auth>
			</c:if>
			<ui:button text="${lfn:message('button.close')}" order="5"
				onclick="Com_CloseWindow();">
			</ui:button>
		</ui:toolbar>
	</c:if>
	<script>
		function printDoc(){
			if(typeof subform_print_BySubformId != "undefined"){
				subform_print_BySubformId('kmImissiveSendMain.do?method=print&fdId=${param.fdId}');
			}else{
				Com_OpenWindow('kmImissiveSendMain.do?method=print&fdId=${param.fdId}','_blank');
			}
			return;
		};
		
		function editDoc(){
			if(window.lbpm && window.lbpm.isSubForm && typeof subform_edit_BySubformId != "undefined"){
				subform_edit_BySubformId('kmImissiveSendMain.do?method=edit&fdId=${param.fdId}&fdTemplateId=${kmImissiveSendMainForm.fdTemplateId}','_self');
			}else{
				Com_OpenWindow('kmImissiveSendMain.do?method=edit&fdId=${param.fdId}&fdTemplateId=${kmImissiveSendMainForm.fdTemplateId}','_self');
			}
			return;
		};
		
		function useLocalSign(){
 			return true;
 		}
	</script>
</template:replace>
<template:replace name="path">
<!-- 软删除配置 -->
<c:import url="/sys/recycle/import/redirect.jsp" charEncoding="UTF-8">
	<c:param name="formBeanName" value="kmImissiveSendMainForm"></c:param>
</c:import>

	<div class="lui_form_path">
		<div class="lui_form_path_item_l">
			流程:
		</div>
		<div class="lui_form_path_item_c">
			<ui:menu layout="sys.ui.menu.nav" id="categoryId">
				<ui:menu-source autoFetch="false">
					<ui:source type="AjaxJson">
						{"url":"/sys/category/criteria/sysCategoryCriteria.do?method=path&modelName=com.landray.kmss.km.imissive.model.KmImissiveSendTemplate&categoryId=${kmImissiveSendMainForm.fdTemplateId}"} 
					</ui:source>
				</ui:menu-source>
			</ui:menu>
		</div>
		<c:if test="${ kmImissiveSendMainForm.docStatus == '20' }">
			<kmss:showWfPropertyValues var="nodevalue" idValue="${kmImissiveSendMainForm.fdId}" propertyName="nodeName" />
			<div class="lui_form_path_item_r">
		        - <c:out value="${nodevalue}"></c:out>
		    </div>
		</c:if>
	</div>
	<%--
	<ui:combin ref="menu.path.category">
		<ui:varParams moduleTitle="${ lfn:message('km-imissive:module.km.imissive') }"
		    modulePath="/km/imissive/" 
			modelName="com.landray.kmss.km.imissive.model.KmImissiveSendTemplate"
		    autoFetch="false" 
		    extHash="j_path=/listAll/send&cri.q=fdTemplate:!{value}"
		    href="/km/imissive/"
			categoryId="${kmImissiveSendMainForm.fdTemplateId}" />
	</ui:combin>
	 --%>
</template:replace>
<%--驳回起草节点直接编辑 --%>
<c:if test="${kmImissiveSendMainForm.docStatus eq '11' and not empty curNode and curNode eq 'N2'}">
	<c:set var="editStatus" value="true" scope="request" />
</c:if>
<c:if test="${kmImissiveSendMainForm.docStatus == '20'}">
	  <%
	    if (KmImissiveConfigUtil.checkCanEditByImgDoc()) {
	  %>
	    <kmss:auth requestURL="/km/imissive/km_imissive_send_main/kmImissiveSendMain.do?method=edit&fdId=${param.fdId}" requestMethod="GET">
	      <c:set var="editStatus" value="true" scope="request" />
	    </kmss:auth>
	  <%
	    }
	  	if (KmImissiveConfigUtil.checkCanEditByImgContent()) {
	  %>
	    <%--编辑正文 --%>
	    <c:if test="${kmImissiveSendMainForm.sysWfBusinessForm.fdNodeAdditionalInfo.editDocContent =='true'}">
	      <c:set var="editStatus" value="true" scope="request" />
	    </c:if>
	  <%
	    }
	  %>
  
	<c:if test="${kmImissiveSendMainForm.sysWfBusinessForm.fdNodeAdditionalInfo.editAtt =='true'}">
		<c:set var="editAtt" value="true" scope="request" />
	</c:if>
	<%--标示是否编辑正文 --%>
	<c:if test="${editFlag == true}">
		<c:set var="editStatus" value="true" scope="request" />
	</c:if>
	<%--签章 --%>
	<c:if test="${kmImissiveSendMainForm.sysWfBusinessForm.fdNodeAdditionalInfo.sigzq =='true'}">
		<c:set var="editStatus" value="true" scope="request" />
	</c:if>
	<%--套红 --%>
	<c:if test="${kmImissiveSendMainForm.sysWfBusinessForm.fdNodeAdditionalInfo.redhead =='true'}">
		<c:set var="editStatus" value="true" scope="request" />
	</c:if>
	<%--清稿 --%>
	<c:if test="${kmImissiveSendMainForm.sysWfBusinessForm.fdNodeAdditionalInfo.cleardraft =='true'}">
		<c:set var="editStatus" value="true" scope="request" />
	</c:if>
	<%--不强制留痕--%>
	<c:if test="${kmImissiveSendMainForm.sysWfBusinessForm.fdNodeAdditionalInfo.forceRevisions =='true' and editStatus == true}">
		<c:set var="forceRevisions" value="false" scope="request" />
	</c:if>
 	<%--能编辑且是当前处理人活着管理员#92305 --%>
	<c:if test="${editStatus eq true and canEditContent eq true}">
		<c:set var="editStatus" value="true" scope="request" />
	</c:if>
	<%--editStatus不为true，说明当前正文不处于编辑状态，如果当前审批人具有编号附件选项，此时需要将editStatus设置为true，且为只读状态，当用户点击文件编号按钮时再解除保护，编号完再设为保护状态--%>
	<c:set var="isReadOnly" value="false" scope="request" />
	<c:if
		test="${!editStatus eq true and kmImissiveSendMainForm.sysWfBusinessForm.fdNodeAdditionalInfo.modifyDocNum eq true}">
		<c:set var="editStatus" value="true" scope="request" />
		<c:set var="isReadOnly" value="true" scope="request" />
	</c:if>
	<%--editStatus不为true，说明当前正文不处于编辑状态，如果当前审批人具有签发附件选项，此时需要将editStatus设置为true，且为只读状态，当用户点击文件编号按钮时再解除保护，编号完再设为保护状态--%>
	<c:if test="${!editStatus eq true and kmImissiveSendMainForm.sysWfBusinessForm.fdNodeAdditionalInfo.signature eq true}">
		<c:set var="editStatus" value="true" scope="request" />
		<c:set var="isReadOnly" value="true" scope="request" />
	</c:if>
	<c:if test="${!editStatus eq true and kmImissiveSendMainForm.sysWfBusinessForm.fdNodeAdditionalInfo.saveRevisions eq true}">
		<!-- 拥有保存痕迹稿的附件选项时，文档处于只读状态，编辑模式 -->
		<c:set var="editStatus" value="true" scope="request" />
		<c:set var="isReadOnly" value="true" scope="request" />
	</c:if>
</c:if>
<% 
    //获取参数配置中是否展开正文的配置
    request.setAttribute("expandDoc",KmImissiveConfigUtil.isExpandContent4Send());
    request.setAttribute("expandBaseInfo",KmImissiveConfigUtil.isExpandBaseInfo4Send());
    request.setAttribute("showAllPage","allpage".equals(KmImissiveConfigUtil.getLoadType())?true:false);
%>
<c:if test="${editStatus eq true or expandDoc eq true or (not empty change)}">
    <c:set var="expandContent" value="true" scope="request"/>
</c:if>
<c:if test="${expandBaseInfo eq true}">
    <c:set var="expandBaseInfo" value="true" scope="request"/>
</c:if>
<kmss:authShow roles="ROLE_KMIMISSIVE_SEND_DOWNLOADCONTENT_EDIT">
	<c:set var="protectstatus" value="false" scope="request"></c:set>
</kmss:authShow>