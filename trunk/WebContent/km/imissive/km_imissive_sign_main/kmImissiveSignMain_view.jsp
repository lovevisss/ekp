<%@page import="com.landray.kmss.sys.webservice2.util.SysWsUtil"%>
<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="/resource/jsp/error_import.jsp"%>
<%@ include file="/sys/ui/jsp/common.jsp"%>
<%@page import="java.util.List"%>
<%@page import="com.landray.kmss.sys.attachment.util.JgWebOffice"%>
<%@page import="com.landray.kmss.km.imissive.util.KmImissiveConfigUtil"%>
<%@page import="com.landray.kmss.km.imissive.forms.KmImissiveSignMainForm"%>
<%@page import="com.landray.kmss.util.ResourceUtil"%>
<%@page import="com.landray.kmss.sys.attachment.integrate.wps.util.SysAttWpsCloudUtil"%>
<%@page import="com.landray.kmss.sys.attachment.integrate.wps.util.SysAttWpsCenterUtil"%>
<%@ page import="com.landray.kmss.km.imissive.util.ImissiveUtil" %>
<%@ page import="com.landray.kmss.util.UserUtil" %>
<%
	pageContext.setAttribute("_isWpsCloudEnable", new Boolean(ImissiveUtil.isEnableWpsCloud()));
	pageContext.setAttribute("_isWpsCenterEnable", new Boolean(SysAttWpsCenterUtil.isEnable()));
%>
<%
	request.setAttribute("jg_LoginUserId", UserUtil.getKMSSUser(request).getPerson().getFdId());
%>
<template:include ref="default.view" sidebar="auto">
	<template:replace name="head">
		<link rel="Stylesheet"
			href="${LUI_ContextPath}/km/imissive/resource/css/att.css" />
	</template:replace>
	<template:replace name="title">
		<c:out
			value="${ kmImissiveSignMainForm.docSubject } - ${ lfn:message('km-imissive:module.km.imissive') }"></c:out>
	</template:replace>
	<template:replace name="toolbar">
		<%
			if (request.getHeader("User-Agent").toUpperCase().indexOf("MSIE") > -1) {
						request.setAttribute("isIE", true);
					} else if (request.getHeader("User-Agent").toUpperCase().indexOf("TRIDENT") > -1) {
						request.setAttribute("isIE", true);
					} else {
						request.setAttribute("isIE", false);
					}

					String isJGSignatureHTMLEnabled = ResourceUtil
							.getKmssConfigString("sys.att.isJGSignatureHTMLEnabled");
					request.setAttribute("JGSignatureHTMLEnabled", isJGSignatureHTMLEnabled);
		%>
		<script>
			Com_IncludeFile("dialog.js|jquery.js");
		</script>
		
		<script>
			//解决非ie下控件高度问题
			window.onload = function() {
				var obj = document.getElementById("JGWebOffice_editonline");
				if (obj) {
					obj.setAttribute("height", "550px");
				}
			};

			seajs
					.use(
							[ 'sys/ui/js/dialog' ],
							function(dialog) {
										window.editDocNum = function() {
											var url = Com_GetCurDnsHost()
													+ Com_Parameter.ContextPath
													+ 'km/imissive/km_imissive_sign_main/kmImissiveSignMain.do?method=editDocNum&fdId=${param.fdId}';
											dialog
													.iframe(
															url,
															'<bean:message  bundle="km-imissive" key="kmImissiveSignMain.editdocnum"/>',
															function(rtn) {
																if (rtn != null
																		&& rtn != "cancel") {
																	location
																			.reload();
																}
															}, {
																width : 500,
																height : 300
															});
										},

										window.urgeSign = function(type) {
											var url = "${KMSS_Parameter_ContextPath}km/imissive/km_imissive_regdetail_list/kmImissiveRegDetailList.do?method=urgeSign";
											var values = [];
											$(
													"input[name='" + type
															+ "']:checked")
													.each(
															function() {
																values.push($(
																		this)
																		.val());
															});
											if (values.length == 0) {
												dialog
														.alert('<bean:message key="page.noSelect"/>');
												return;
											}
											$
													.post(
															url,
															$
																	.param(
																			{
																				"List_Selected" : values
																			},
																			true),
															function(data) {
																if (data != null
																		&& data.status == true) {
																	dialog
																			.alert('<bean:message  bundle="km-imissive" key="msg.filing.success"/>');
																} else {
																	dialog
																			.alert('<bean:message  bundle="km-imissive" key="msg.filing.failure"/>');
																}
															}, 'json');
										},
										window.Delete = function(delUrl) {
											Com_Delete_Get(delUrl, 'com.landray.kmss.km.imissive.model.KmImissiveSignMain');
											/* dialog
													.confirm(
															"${lfn:message('page.comfirmDelete')}",
															function(flag) {
																if (flag == true) {
																	Com_OpenWindow(
																			'kmImissiveSignMain.do?method=delete&fdId=${param.fdId}',
																			'_self');
																} else {
																	return false;
																}
															}, "warn"); */
											return;
										},
										window.filingDoc = function() {
											dialog
													.confirm(
															"${lfn:message('km-imissive:alert.filing.msg')}",
															function(flag) {
																if (flag == true) {
																	Com_OpenWindow(
																			'kmImissiveSignMain.do?method=filing&fdId=${param.fdId}',
																			'_self');
																} else {
																	return;
																}
															}, "warn");
										}
							});
		</script>
		<script language="javascript">
		<!--
			var wnd; //定义辅助功能全局变量

			//作用：签章
			function DoJFSignature() {
				var nodeId = $("#processNodeId").text();
				var processNodeId = "fd_"
						+ nodeId.substring(0, nodeId.indexOf("."));
				kmImissiveSignMainForm.SignatureControl.FieldsList = "DOCUMENTID=文档主键值" //所保护字段
				kmImissiveSignMainForm.SignatureControl.DivId = processNodeId; //设置签章位置是相对于哪个标记的什么位置 
				kmImissiveSignMainForm.SignatureControl.RunSignature(); //执行签章操作
				//标签页是否展开
				var tab = LUI('kmImissiveSendMain_content');

				if (tab != null) {
					var panel = tab.parent;
					$.each(panel.contents, function(i) {
						if (this == tab) {
							panel.onToggle(i, false, true);
							panel.onToggle(i, false, false);
							return false;
						}
					});
				}
			}

			//作用：自动锁定文档
			function ProtectDocument() {
				var mLength = document.getElementsByName("iHtmlSignature").length;
				var mProtect = false;
				for (var i = 0; i < mLength; i++) {
					var vItem = document.getElementsByName("iHtmlSignature")[i];
					if (vItem.DocProtect) {
						mProtect = true;
						break;
					}
				}
				if (!mProtect) {
					var vItem = document.getElementsByName("iHtmlSignature")[mLength - 1];
					vItem.LockDocument(true);
				}
			}

			//作用：进行手写签名
			function DoSXSignature() {
				var isIEFlag = '${isIE}';
				if (null != isIEFlag && isIEFlag != 'true') {
					alert('<bean:message key="kmImissiveSignature.signatureIsIE" bundle="km-imissive"/>');
					return '';
				}
				var nodeId = $("#processNodeId").text();
				var processNodeId = "fd_"
						+ nodeId.substring(0, nodeId.indexOf("."));
				var siginatureDivObj = document.getElementById(processNodeId);
				if (null == siginatureDivObj || "undefined" == siginatureDivObj) {
					alert('<bean:message key="kmImissiveSignature.signatureAlert" bundle="km-imissive"/>');
					return '';
				}
				//雾化功能
				//var mXml = "<?xml version='1.0' encoding='gb2312' standalone='yes'?>";
				//mXml = mXml + "  <Signature>";
				//mXml =mXml  +  "<OtherParam>";
				//mXml = mXml + "  <IsAtomize>TRUE</IsAtomize>";
				//mXml = mXml + "  <AtomizeValue>5</AtomizeValue>";
				//mXml =mXml  +  "</OtherParam>";
				//mXml = mXml + "  </Signature>";
				//kmImissiveSignMainForm.SignatureControl.XmlConfigParam = mXml;

				//屏蔽签章中的不通过项
				var noPassXml = "<?xml version='1.0' encoding='gb2312' standalone='yes'?>";
				noPassXml = noPassXml
						+ "  <Signature><RunHandwrite> "
						+ "  <PermissionNotPassEnabled>0</PermissionNotPassEnabled>"
						+ "  </RunHandwrite></Signature>";
				kmImissiveSignMainForm.SignatureControl.XmlConfigParam = noPassXml;

				kmImissiveSignMainForm.SignatureControl.FieldsList = "DOCUMENTID=文档主键值" //所保护字段
				kmImissiveSignMainForm.SignatureControl.Position(0, 0); //手写签名位置
				kmImissiveSignMainForm.SignatureControl.HandPenWidth = 1; //设置、读取手写签名的笔宽
				kmImissiveSignMainForm.SignatureControl.HandPenColor = 100; //设置、读取手写签名
				kmImissiveSignMainForm.SignatureControl.HandPenWidth = 1; //设置、读取手写签名的笔宽
				kmImissiveSignMainForm.SignatureControl.HandPenColor = 100; //设置、读取手写签名笔颜色笔颜色
				kmImissiveSignMainForm.SignatureControl.DivId = processNodeId; //设置签章位置是相对于哪个标记的什么位置
				kmImissiveSignMainForm.SignatureControl.RunHandWrite(); //执行手写签名
			}
			//作用：删除签章
			function DeleteSignature() {
				var mLength = document.getElementsByName("iHtmlSignature").length;
				var mSigOrder = "";
				for (var i = mLength - 1; i >= 0; i--) {
					var vItem = document.getElementsByName("iHtmlSignature")[i];
					//mSigOrder := 
					if (vItem.SignatureOrder == "1") {
						vItem.DeleteSignature();
					}
				}
			}

			//作用：打印文档
			function PrintDocument() {
				//var tagElement = document.getElementById('kmImissiveSendMain_content');
				// alert(tagElement);
				// tagElement.className = 'print';                                                 //样式改变为可打印
				var mCount = kmImissiveSignMainForm.SignatureControl
						.PrintDocument(false, 2, 5); //打印控制窗体
				// alert("实际打印份数："+mCount);
				// tagElement.className = 'Noprint';                                               //样式改变为不可打印
			}
			<c:if test="${JGSignatureHTMLEnabled == 'true'}">
			window.onload = function() {
				kmImissiveSignMainForm.SignatureControl
						.ShowSignature('${param.fdId}');
			};
			window.onunload = function() {
				kmImissiveSignMainForm.SignatureControl.DeleteSignature();
			};
			</c:if>
			-->
		</script>
		<!-- 软删除配置 -->
		<c:if test="${kmImissiveSignMainForm.docDeleteFlag ==1}">
			<ui:toolbar id="toolbar" count="6"  style="display:none;"></ui:toolbar>
		</c:if>
		<c:if test="${kmImissiveSignMainForm.docDeleteFlag !=1}">
			<ui:toolbar id="toolbar" layout="sys.ui.toolbar.float" count="6"
				var-navwidth="90%" style="display:none;">

				<%-- <ui:toolbar  id="toolbar" layout="sys.ui.toolbar.float" count="5"> --%>
				<c:if test="${kmImissiveSignMainForm.fdIsFiling != true}">
					<kmss:auth
						requestURL="/km/imissive/km_imissive_sign_main/kmImissiveSignMain.do?method=edit&fdId=${param.fdId}"
						requestMethod="GET">
						<c:if
							test="${(kmImissiveSignMainForm.docStatus!='00' && kmImissiveSignMainForm.docStatus!='30') || (kmImissiveSignMainForm.docStatus == '30') }">
							<ui:button text="${lfn:message('button.edit') }" order="4"
								onclick="Com_OpenWindow('kmImissiveSignMain.do?method=edit&fdId=${param.fdId}&fdTemplateId=${kmImissiveSignMainForm.fdTemplateId}','_self');">
							</ui:button>
						</c:if>
					</kmss:auth>
					<c:if
						test="${kmImissiveSignMainForm.docStatus=='30' and kmImissiveSignMainForm.fdIsFiling!= true}">
						<%
							if (UserUtil.getKMSSUser().isAdmin()) {
						%>
						<ui:button
							text="${lfn:message('km-imissive:kmImissiveSignMain.editdocnum') }"
							order="4" onclick="editDocNum();">
						</ui:button>
						<%
							}
						%>
					</c:if>
					<%-- 归档 --%>
					<c:if test="${kmImissiveSignMainForm.docStatus == '30' || kmImissiveSignMainForm.docStatus == '00'}">
						<c:import url="/sys/archives/include/sysArchivesFileButton.jsp" charEncoding="UTF-8">
							<c:param name="fdId" value="${param.fdId}" />
							<c:param name="fdModelName" value="com.landray.kmss.km.imissive.model.KmImissiveSignMain" />
							<c:param name="serviceName" value="kmImissiveSignMainService" />
							<c:param name="moduleUrl" value="km/imissive" />
						</c:import>
					</c:if>
					<c:if test="${kmImissiveSignMainForm.docStatus =='20'}">
						<c:if
							test="${kmImissiveSignMainForm.fdNeedContent=='1' and kmImissiveSignMainForm.sysWfBusinessForm.fdNodeAdditionalInfo.redhead =='true'}">
							<c:choose>
								<c:when test="${_isWpsCloudEnable}">
									<ui:button text="${lfn:message('km-imissive:kmImissive.redhead') }" order="2"
										onclick="LoadWpsHeadWordList('com.landray.kmss.km.imissive.model.KmImissiveSignMain');">
									</ui:button>
								</c:when>
								<c:when test="${_isWpsCenterEnable}">
									<ui:button text="${lfn:message('km-imissive:kmImissive.redhead') }" order="2"
											   onclick="LoadWpsCenterHeadWordList('com.landray.kmss.km.imissive.model.KmImissiveSignMain');">
									</ui:button>
								</c:when>
								<c:otherwise>
							<%-- 套红附加选项 --%>
									<ui:button
										text="${lfn:message('km-imissive:kmImissive.redhead') }"
										order="2"
										onclick="LoadHeadWordList('com.landray.kmss.km.imissive.model.KmImissiveSignMain');">
									</ui:button>
								</c:otherwise>
							</c:choose>
						</c:if>
						<!-- 签章附加选项 -->
						<kmss:ifModuleExist path="/km/signature/">
							<c:if
								test="${kmImissiveSignMainForm.fdNeedContent=='1' and kmImissiveSignMainForm.sysWfBusinessForm.fdNodeAdditionalInfo.sigzq =='true'}">
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
						</kmss:ifModuleExist>

						<%-- 稿纸签章  --%>
						<c:if
							test="${kmImissiveSignMainForm.sysWfBusinessForm.fdNodeAdditionalInfo.signaturehtml =='true'}">
							<c:if test="${JGSignatureHTMLEnabled == 'true'}">
								<ui:button
									text="${lfn:message('km-imissive:kmImissive.sightml') }"
									order="1" onclick="DoSXSignature()"></ui:button>
							</c:if>
						</c:if>
					</c:if>
				</c:if>
				<c:if test="${kmImissiveSignMainForm.docStatus!='10'}">
					<kmss:auth
						requestURL="/km/imissive/km_imissive_sign_main/kmImissiveSignMain.do?method=print&fdId=${param.fdId}"
						requestMethod="GET">
						<ui:button text="${lfn:message('button.print') }" order="4"
							onclick="Com_OpenWindow('kmImissiveSignMain.do?method=print&fdId=${param.fdId}','_blank');">
						</ui:button>
					</kmss:auth>
				</c:if>
				<!-- 督办 -->
				<kmss:ifModuleExist path="/km/supervise/">
					<c:import url="/km/supervise/import/kmSuperviseMain_edit.jsp"
						charEncoding="UTF-8">
						<c:param name="fdModelId" value="${param.fdId}" />
						<c:param name="fdModelName"
							value="com.landray.kmss.km.imissive.model.KmImissiveSignMain" />
					</c:import>
				</kmss:ifModuleExist>

				<kmss:auth
					requestURL="/km/imissive/km_imissive_sign_main/kmImissiveSignMain.do?method=delete&fdId=${param.fdId}"
					requestMethod="GET">
					<ui:button text="${lfn:message('button.delete') }" order="4"
						onclick="Delete('kmImissiveSignMain.do?method=delete&fdId=${param.fdId}');">
					</ui:button>
				</kmss:auth>
				<ui:button text="${lfn:message('button.close')}" order="5"
					onclick="Com_CloseWindow();">
				</ui:button>
			</ui:toolbar>
			</c:if>
	</template:replace>
	<template:replace name="path">
		<ui:menu layout="sys.ui.menu.nav" id="categoryId">
			<ui:menu-item text="${ lfn:message('home.home') }"
				icon="lui_icon_s_home" href="/" target="_self"></ui:menu-item>
			<ui:menu-item
				text="${ lfn:message('km-imissive:module.km.imissive') }"
				href="/km/imissive/" target="_self"></ui:menu-item>
			<ui:menu-item
				text="${ lfn:message('km-imissive:kmImissive.nav.SignManagement') }"
				href="/km/imissive/km_imissive_sign_main/index.jsp" target="_self"></ui:menu-item>
			<ui:menu-source autoFetch="false" target="_self"
				href="/km/imissive/km_imissive_sign_main/index.jsp#cri.q=fdTemplate:${kmImissiveSignMainForm.fdTemplateId}">
				<ui:source type="AjaxJson">
					{"url":"/sys/category/criteria/sysCategoryCriteria.do?method=path&modelName=com.landray.kmss.km.imissive.model.KmImissiveSignTemplate&categoryId=${kmImissiveSignMainForm.fdTemplateId}"} 
				</ui:source>
			</ui:menu-source>
		</ui:menu>
	</template:replace>
	<template:replace name="content">
	<!-- 软删除配置 -->
	<c:import url="/sys/recycle/import/redirect.jsp">
		<c:param name="formBeanName" value="kmImissiveSignMainForm"></c:param>
	</c:import>	
		<c:if
			test="${kmImissiveSignMainForm.docStatus =='20' and kmImissiveSignMainForm.fdNeedContent=='1'}">
			<%
				if (("true".equals(KmImissiveConfigUtil.isShowImg())
										&& "false".equals(KmImissiveConfigUtil.isShowImg4Doc()))
										|| "false".equals(KmImissiveConfigUtil.isShowImg())) {
			%>
			<kmss:auth
				requestURL="/km/imissive/km_imissive_sign_main/kmImissiveSignMain.do?method=edit&fdId=${param.fdId}"
				requestMethod="GET">
				<c:set var="editStatus" value="true" />
			</kmss:auth>
			<%
				}
			%>
			<%
				if (("true".equals(KmImissiveConfigUtil.isShowImg())
										&& "false".equals(KmImissiveConfigUtil.isShowImg4Content()))
										|| "false".equals(KmImissiveConfigUtil.isShowImg())) {
			%>
			<c:if
				test="${kmImissiveSignMainForm.sysWfBusinessForm.fdNodeAdditionalInfo.editDocContent =='true'}">
				<c:set var="editStatus" value="true" />
			</c:if>
			<%
				}
			%>
			<%--标示是否编辑正文 --%>
			<c:if test="${editFlag == true}">
				<c:set var="editStatus" value="true" />
			</c:if>
			<c:if
				test="${kmImissiveSignMainForm.sysWfBusinessForm.fdNodeAdditionalInfo.redhead =='true'}">
				<c:set var="editStatus" value="true" />
			</c:if>
			<%--editStatus不为true，说明当前正文不处于编辑状态，如果当前审批人具有编号附件选项，此时需要将editStatus设置为true，且为只读状态，当用户点击文件编号按钮时再解除保护，编号完再设为保护状态--%>
			<c:if
				test="${!editStatus eq true and kmImissiveSignMainForm.sysWfBusinessForm.fdNodeAdditionalInfo.modifyDocNum eq true}">
				<c:set var="editStatus" value="true" />
				<c:set var="isReadOnly" value="true" />
			</c:if>
			<%--editStatus不为true，说明当前正文不处于编辑状态，如果当前审批人具有签发附件选项，此时需要将editStatus设置为true，且为只读状态，当用户点击文件编号按钮时再解除保护，编号完再设为保护状态--%>
			<c:if
				test="${!editStatus eq true and kmImissiveSignMainForm.sysWfBusinessForm.fdNodeAdditionalInfo.signature eq true}">
				<c:set var="editStatus" value="true" />
				<c:set var="isReadOnly" value="true" />
			</c:if>
		</c:if>
		<%
			//获取参数配置中是否展开正文的配置
						request.setAttribute("expandDoc", KmImissiveConfigUtil.isExpandContent4Sign());
						request.setAttribute("expandBaseInfo", KmImissiveConfigUtil.isExpandBaseInfo4Sign());
						request.setAttribute("showAllPage","allpage".equals(KmImissiveConfigUtil.getLoadType()) ? true : false);
		%>
		<c:if
			test="${editStatus eq true or expandDoc eq true or (not empty change)}">
			<c:set var="expandContent" value="true" />
		</c:if>
		<c:if test="${expandBaseInfo eq true}">
			<c:set var="expandBaseInfo" value="true" />
		</c:if>
		<html:form
			action="/km/imissive/km_imissive_sign_main/kmImissiveSignMain.do">
			<%-- 网页签章(首先判断是否启用了网页签章) --%>
			<c:if test="${JGSignatureHTMLEnabled == 'true'}">
				<%
					String projectServerURL = SysWsUtil.getUrlPrefix(request);
					String mServerUrl = projectServerURL + "/km/imissive/iSignatureHTML/Service.jsp";
					request.setAttribute("jgHtmlSigVersion", JgWebOffice.getJGVersion("signaturehtml"));
					request.setAttribute("jgHtmlSigUrl",projectServerURL + JgWebOffice.getJGDownLoadUrl("signaturehtml"));
				%>
				<span id="processNodeId" style="display: none;"><kmss:showWfPropertyValues
						idValue="${kmImissiveSignMainForm.fdId}"
						propertyName="handerNameDetail" /></span>
				<input type="hidden" name="DOCUMENTID"
					value="${kmImissiveSignMainForm.fdId }">
				<OBJECT id="SignatureControl"
					classid="clsid:D85C89BE-263C-472D-9B6B-5264CD85B36E"
					codebase="${jgHtmlSigUrl }#version=${jgHtmlSigVersion }" width=0
					height=0>
					<param name="ServiceUrl" value="<%=mServerUrl%>">
					<!--读去数据库相关信息-->
					<param name="PrintControlType" value=2>
					<!--打印控制方式（0:不控制  1：签章服务器控制  2：开发商控制）-->
				</OBJECT>
			</c:if>

			<ui:tabpage expand="false">
				<c:choose>
					<c:when test="${kmImissiveSignMainForm.fdNeedContent=='1'}">
						<c:if test="${kmImissiveSignMainForm.docStatus == '30'}">
							<%
								if ("content".equals(KmImissiveConfigUtil.getDiplayOrder())) {
							%>
							<ui:content
								title="${lfn:message('km-imissive:kmImissiveReceiveMain.docContent')}"
								expand="${expandContent}">
								<jsp:include page="/km/imissive/km_imissive_sign_main/kmImissiveSignMain_content.jsp"/>
							</ui:content>
							<ui:content
								title="${ lfn:message('km-imissive:kmImissiveReceiveMain.baseinfo') }"
								expand="${expandBaseInfo}">
								<jsp:include page="/km/imissive/km_imissive_sign_main/kmImissiveSignMain_baseInfo.jsp"/>
							</ui:content>
							<%
								} else {
							%>
							<ui:content
								title="${ lfn:message('km-imissive:kmImissiveReceiveMain.baseinfo') }"
								expand="${expandBaseInfo}">
								<jsp:include page="/km/imissive/km_imissive_sign_main/kmImissiveSignMain_baseInfo.jsp"/>
							</ui:content>
							<ui:content
								title="${lfn:message('km-imissive:kmImissiveReceiveMain.docContent')}"
								expand="${expandContent}">
								<jsp:include page="/km/imissive/km_imissive_sign_main/kmImissiveSignMain_content.jsp"/>
							</ui:content>
							<%
								}
							%>
						</c:if>
						<c:if test="${kmImissiveSignMainForm.docStatus != '30'}">
							<ui:content
								title="${ lfn:message('km-imissive:kmImissiveReceiveMain.baseinfo') }"
								expand="${expandBaseInfo}">
								<jsp:include page="/km/imissive/km_imissive_sign_main/kmImissiveSignMain_baseInfo.jsp"/>
							</ui:content>
							<ui:content
								title="${lfn:message('km-imissive:kmImissiveReceiveMain.docContent')}"
								expand="${expandContent}">
								<jsp:include page="/km/imissive/km_imissive_sign_main/kmImissiveSignMain_content.jsp"/>
							</ui:content>
						</c:if>
					</c:when>
					<c:otherwise>
						<ui:content
							title="${ lfn:message('km-imissive:kmImissiveReceiveMain.baseinfo') }"
							expand="true">
							<%@ include
								file="/km/imissive/km_imissive_sign_main/kmImissiveSignMain_baseInfo.jsp"%>
							<div class="lui_form_content_frame" style="padding-top: 10px">
								<c:if
									test="${not empty kmImissiveSignMainForm.attachmentForms['attachment'].attachments}">
									<div class="lui_form_spacing"></div>
									<div>
										<div class="lui_form_subhead">
											<img
												src="${KMSS_Parameter_ContextPath}sys/attachment/view/img/attachment.png">
											${ lfn:message('sys-doc:sysDocBaseInfo.docAttachments') }(${fn:length(kmImissiveSignMainForm.attachmentForms['attachment'].attachments)})
										</div>
										<c:import
											url="/sys/attachment/sys_att_main/sysAttMain_view.jsp"
											charEncoding="UTF-8">
											<c:param name="formBeanName" value="kmImissiveSignMainForm" />
											<c:param name="fdKey" value="attachment" />
										</c:import>
									</div>
								</c:if>
							</div>
						</ui:content>
					</c:otherwise>
				</c:choose>
				<!-- 以下代码为嵌入流程模板标签的代码 -->
				<kmss:auth
					requestURL="/km/imissive/km_imissive_sign_main/kmImissiveSignMain.do?method=readViewLog&fdId=${param.fdId}"
					requestMethod="GET">
					<c:import url="/sys/workflow/import/sysWfProcess_view.jsp"
						charEncoding="UTF-8">
						<c:param name="formName" value="kmImissiveSignMainForm" />
						<c:param name="fdKey" value="signMainDoc" />
						<c:param name="showHistoryOpers" value="true" />
						<c:param name="isSimpleWorkflow" value="false" />
						<c:param name="onClickSubmitButton"
							value="Com_Submit(document.kmImissiveSignMainForm, 'approveSign');" />
					</c:import>
				</kmss:auth>
				<c:import
					url="/km/imissive/km_imissive_circulation/kmImissiveCirculation_view.jsp"
					charEncoding="UTF-8">
					<c:param name="formName" value="kmImissiveSignMainForm" />
				</c:import>
				<!-- -----------------------------------------传阅完------------------------------------------------------------ -->
				<!-- 发布机制开始 -->
				<c:import url="/sys/news/import/sysNewsPublishMain_view.jsp"
					charEncoding="UTF-8">
					<c:param name="formName" value="kmImissiveSignMainForm" />
					<c:param name="fdKey" value="signMainDoc" />
				</c:import>
				<!-- 以上代码为嵌入流程模板标签的代码 -->
				<!-- 阅读机制 -->
				<c:import url="/sys/readlog/import/sysReadLog_view.jsp"
					charEncoding="UTF-8">
					<c:param name="formName" value="kmImissiveSignMainForm" />
				</c:import>
				<!-- 阅读机制 -->
				<!-- 权限机制-->
				<ui:content title="${ lfn:message('sys-right:right.moduleName') }">
					<table class="tb_normal" width=100%>
						<tr>
							<td class="td_normal_title" width="15%"><bean:message
									bundle="km-imissive"
									key="kmImissiveSignMain.authAppRecReaderIds" /></td>
							<td width="85%" colspan='3'><c:if
									test="${empty kmImissiveSignMainForm.authAppRecReaderNames}">
									<bean:message bundle="sys-right" key="right.other.person" />
								</c:if> <c:if
									test="${not empty kmImissiveSignMainForm.authAppRecReaderNames}">
									<c:out value="${kmImissiveSignMainForm.authAppRecReaderNames}"></c:out>
								</c:if></td>
						</tr>
						<c:import url="/sys/right/right_view.jsp" charEncoding="UTF-8">
							<c:param name="formName" value="kmImissiveSignMainForm" />
							<c:param name="moduleModelName"
								value="com.landray.kmss.km.imissive.model.KmImissiveSignMain" />
						</c:import>
					</table>
				</ui:content>
				<!-- 匿名机制 开始 -->
				<c:if test="${kmImissiveSignMainForm.docStatus == '30'}">
					<c:import url="/sys/anonym/import/sysAnonym_view.jsp" charEncoding="UTF-8">
						<c:param name="formName" value="kmImissiveSignMainForm" />
						<c:param name="fdKey" value="kmImissiveSignMain" />
					</c:import>
				</c:if>
				<!-- 匿名机制 结束 -->
				<c:import url="/sys/bookmark/import/bookmark_bar.jsp"
					charEncoding="UTF-8">
					<c:param name="fdSubject"
						value="${kmImissiveSignMainForm.docSubject}" />
					<c:param name="fdModelId" value="${kmImissiveSignMainForm.fdId}" />
					<c:param name="fdModelName"
						value="com.landray.kmss.km.imissive.model.KmImissiveSignMain" />
				</c:import>
			</ui:tabpage>
		</html:form>
		<%@ include file="/km/imissive/cookieUtil_script.jsp"%>
		<script>
			Com_IncludeFile("att_dynamic.js",
					"${KMSS_Parameter_ContextPath}km/imissive/", "js", true);
		</script>
		<script>
			$KMSSValidation(document.forms['kmImissiveSignMainForm']);

			seajs.use([ 'sys/ui/js/dialog' ], function(dialog) {
				window.dialog = dialog;
			});
			
			//文件编号
			function generateFileNum() {
				//文件编号的时候，审批人不一定有编辑正文的权限，先接触文档保护
				if (Attachment_ObjectInfo['editonline'] && Attachment_ObjectInfo['editonline'].ocxObj) {
					Attachment_ObjectInfo['editonline'].ocxObj.EditType = "1";
				}
				var docNum = document.getElementsByName("fdDocNum")[0];
				var fdFlowNo = document.getElementsByName("fdFlowNo")[0];
				var fdNoRule = document.getElementsByName("fdNoRule")[0];
				var fdYearNo = document.getElementsByName("fdYearNo")[0];
				var fdNumberMainId = document.getElementsByName("fdNumberMainId")[0];
				path = Com_GetCurDnsHost()
						+ Com_Parameter.ContextPath
						+ 'km/imissive/km_imissive_sign_main/kmImissiveNum.jsp?fdId=${kmImissiveSignMainForm.fdId}&fdNumberId=${fdNoId}&fdTemplateId=${kmImissiveSignMainForm.fdTemplateId}';
				dialog
						.iframe(
								path,
								'<bean:message  bundle="km-imissive" key="kmImissive.modifyDocNum"/>',
								function(rtn) {
									if (rtn != "undefined" && rtn != null) {
										var arr = rtn.fdRtnNum.split("#");
										if (arr.length == 3) {
											fdNoRule.value = arr[0];
											fdFlowNo.value = arr[1];
											fdNumberMainId.value = arr[2];
											docNum.value = rtn.fdNum;
											fdYearNo.value = rtn.fdYearNo;
											document.getElementById("docnum").innerHTML = rtn.fdNum;
										}
										//填充控件中的文号书签
										if (Attachment_ObjectInfo['editonline']&&Attachment_ObjectInfo['editonline'].hasLoad) {
											Attachment_ObjectInfo['editonline'].setBookmark('docnum',rtn.fdNum);
											if ("${isReadOnly}" == "true") {
												if(Attachment_ObjectInfo['editonline'].ocxObj){
													if (!Attachment_ObjectInfo['editonline'].canCopy) {
														Attachment_ObjectInfo['editonline'].ocxObj.CopyType = "1";
														Attachment_ObjectInfo['editonline'].ocxObj.EditType = "0,1";
													} else {
														Attachment_ObjectInfo['editonline'].ocxObj.CopyType = "1";
														Attachment_ObjectInfo['editonline'].ocxObj.EditType = "4,1";
													}
												}
											}
										}
									}
								}, {
									width : 550,
									height : 380
								});
			}

			<c:if  test="${kmImissiveSignMainForm.sysWfBusinessForm.fdNodeAdditionalInfo.modifyDocNum =='true'}">
			Com_Parameter.event["submit"]
					.push(function() {
						//删除cookie
						// delCookie();
						//操作类型为通过类型 ，才写回编号 
						if (lbpm.globals.getCurrentOperation().operation
								&& lbpm.globals.getCurrentOperation().operation['isPassType'] == true) {
							var docNum = document.getElementsByName("fdDocNum")[0];
							var fdFlowNo = document
									.getElementsByName("fdFlowNo")[0];
							var fdNoRule = document
									.getElementsByName("fdNoRule")[0];
							var fdNumberMainId = document
									.getElementsByName("fdNumberMainId")[0];
							var fdYearNo = document.getElementsByName("fdYearNo")[0];
							var isRepeat = true;
							var results;
							if ("" == docNum.value) {
								isRepeat = confirm('<bean:message key="kmImissive.number.notNull" bundle="km-imissive" />');
							} else {
								var url = "${KMSS_Parameter_ContextPath}km/imissive/km_imissive_sign_main/kmImissiveSignMain.do?method=saveDocNum";
								$
										.ajax({
											type : "post",
											url : url,
											data : {
												fdDocNum : docNum.value,
												fdFlowNo : fdFlowNo.value,
												fdNoRule : fdNoRule.value,
												fdNumberMainId : fdNumberMainId.value,
												fdId : "${kmImissiveSignMainForm.fdId}",
												fdYearNo:fdYearNo.value
											},
											async : false, //用同步方式 
											success : function(data) {
												results = eval("(" + data + ")");
												if (results['isRepeat'] == "true") {
													alert('<bean:message bundle="km-imissive" key="kmImissiveSignMain.message.error.fdDocNum.repeat"/>');
													isRepeat = false;
												}
											}
										});
								//删除cookie,避免新建每次取到同一编号
								if ("${fdNoId}" != "") {
									var docBufferNum = getTempNumberFromDb("${fdNoId}","com.landray.kmss.km.imissive.model.KmImissiveSignMain");
									if(docBufferNum){
								    	var fdVirtualNum = decodeURI(docBufferNum).split("#");
								    	var fdFlowNo = document.getElementsByName("fdFlowNo")[0];
								    	if(docNum.value == formatNum(fdVirtualNum[0],fdVirtualNum[1])|| fdFlowNo.value > fdVirtualNum[1]){
								    		 delTempNumFromDb("${fdNoId}",decodeURI(docBufferNum));
								    	}
								    }
								}
								if (results['flag'] == "false"
										&& results['isRepeat'] != "true") {
									alert("更新文档编号不成功");
									return false
								} else {
									return isRepeat;
								}
							}
							return isRepeat;
						} else {
							return true;
						}
					});
			</c:if>

			var redheadFlag = ""; //是否进行套红标示
			<c:if test="${kmImissiveSignMainForm.fdNeedContent=='1' and kmImissiveSignMainForm.sysWfBusinessForm.fdNodeAdditionalInfo.redhead =='true'}">
			Com_Parameter.event["submit"]
					.push(function() {
						var flag = true;
						if("${wpsoaassist}"!="true"){
							if(""==redheadFlag){
								flag =  confirm('<bean:message  bundle="km-imissive" key="kmImissive.redhead.comfirm.notNull"/>');
							}
						}
						return flag;
					});
			</c:if>

			//如果流程附加节点中有签发操作，则将签发日期和签发人写回
			<c:if  test="${kmImissiveSignMainForm.sysWfBusinessForm.fdNodeAdditionalInfo.signature =='true'}">
			Com_Parameter.event["submit"]
					.push(function() {
						//签发的时候，审批人不一定有编辑正文的权限，先接触文档保护
						if (Attachment_ObjectInfo['editonline'] && Attachment_ObjectInfo['editonline'].ocxObj) {
							Attachment_ObjectInfo['editonline'].ocxObj.EditType = "1";
						}
						//操作类型为通过类型，才写回
						var canStartProcess = document.getElementById("sysWfBusinessForm.canStartProcess");//canStartProcess.value等于false为暂存，等于true为提交
						if (canStartProcess.value == "true" && lbpm.globals.getCurrentOperation().operation
								&& lbpm.globals.getCurrentOperation().operation['isPassType'] == true) {
							var flag = true;
							var url = "${KMSS_Parameter_ContextPath}km/imissive/km_imissive_sign_main/kmImissiveSignMain.do?method=saveSignatureAndTime";
							$
									.ajax({
										type : "post",
										url : url,
										data : {
											fdId : "${kmImissiveSignMainForm.fdId}"
										},
										async : false, //用同步方式 
										success : function(data) {
											results = eval("(" + data + ")");
											if (results['flag'] == "true") {
												if (Attachment_ObjectInfo['editonline']&&Attachment_ObjectInfo['editonline'].hasLoad) {
													Attachment_ObjectInfo['editonline'].setBookmark('signature',results['fdSignatureName']);
													Attachment_ObjectInfo['editonline'].setBookmark('signdatecn',results['publishTimeUpper']);
													Attachment_ObjectInfo['editonline'].setBookmark('signdate',results['publishTimeNum']);
													if ("${isReadOnly}" == "true") {
														if(Attachment_ObjectInfo['editonline'].ocxObj){
															if (!Attachment_ObjectInfo['editonline'].canCopy) {
																Attachment_ObjectInfo['editonline'].ocxObj.CopyType = "1";
																Attachment_ObjectInfo['editonline'].ocxObj.EditType = "0,1";
															} else {
																Attachment_ObjectInfo['editonline'].ocxObj.CopyType = "1";
																Attachment_ObjectInfo['editonline'].ocxObj.EditType = "4,1";
															}
														}
													}
												}
											} else {
												alert('生成签发日期失败');
												flag = false;
											}
										}
									});
							return flag;
						} else {
							return true;
						}
					});
			</c:if>
		</script>
	</template:replace>
	<template:replace name="nav">
		<%--关联机制 --%>
		<c:import url="/sys/relation/import/sysRelationMain_view.jsp"
			charEncoding="UTF-8">
			<c:param name="formName" value="kmImissiveSignMainForm" />
		</c:import>
		<!-- 关联机制 -->
	</template:replace>
</template:include>
