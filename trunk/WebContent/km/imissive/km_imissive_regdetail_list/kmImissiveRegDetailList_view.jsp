<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page import="java.util.ArrayList"%>
<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="/sys/ui/jsp/common.jsp"%>
<%@page import="java.util.List"%>
<%@page import="com.landray.kmss.util.SpringBeanUtil,com.landray.kmss.util.StringUtil"%>
<%@page import="com.landray.kmss.sys.attachment.service.ISysAttMainCoreInnerService"%>
<%@page import="com.landray.kmss.sys.attachment.util.JgWebOffice"%>
<%@page import="com.landray.kmss.sys.attachment.model.SysAttMain"%>
<%@page import="com.landray.kmss.km.imissive.util.KmImissiveConfigUtil"%>
<%@page import="com.landray.kmss.sys.attachment.integrate.wps.util.SysAttWpsCloudUtil"%>
<%@page import="com.landray.kmss.sys.attachment.integrate.wps.util.SysAttWpsCenterUtil"%>
<%@ page import="com.landray.kmss.km.imissive.util.ImissiveUtil"%>
<c:set var="wpsoaassist" value="<%=ImissiveUtil.isEnable()%>"/>
<c:set var="_useWpsLinuxView" value="<%=SysAttWpsCloudUtil.getUseWpsLinuxView()%>"/>
<c:set var="_wpsLinuxPreview" value="<%=SysAttWpsCloudUtil.checkWpsPreviewIsLinux()%>"/>
<%
	pageContext.setAttribute("_isWpsCloudEnable", new Boolean(ImissiveUtil.isEnableWpsCloud()));
	pageContext.setAttribute("_isWpsCenterEnable", new Boolean(SysAttWpsCenterUtil.isEnable()));
%>
<template:include ref="default.view" sidebar="no">
    <template:replace name="head">
		<link rel="Stylesheet" href="${LUI_ContextPath}/km/imissive/resource/css/att.css" />
	</template:replace>
	<template:replace name="title">
		<c:out value="${ kmImissiveRegForm.fdName } - ${ lfn:message('km-imissive:module.km.imissive') }"></c:out> 
	</template:replace>
	<template:replace name="toolbar">
		<ui:toolbar  id="toolbar" layout="sys.ui.toolbar.float" count="6">
		 <kmss:auth requestURL="/km/imissive/km_imissive_regdetail_list/kmImissiveRegDetailList.do?method=updateSign&fdId=${param.fdId}" requestMethod="GET">
			<c:choose>
				<c:when test="${kmImissiveRegDetailListForm.fdRegType eq '2' }">
						<c:if test="${kmImissiveRegDetailListForm.fdStatus eq '1'}">
						    <ui:button text="${lfn:message('km-imissive:kmImissiveReg.updateSignReceive') }" order="1" onclick="updateSignReceive();">
							</ui:button>
							<ui:button text="${lfn:message('km-imissive:kmImissiveReg.updateSignSend') }" order="1" onclick="updateSignSend();">
							</ui:button>
						</c:if>
				</c:when>
				<c:otherwise>
					 <kmss:auth requestURL="/km/imissive/km_imissive_regdetail_list/kmImissiveRegDetailList.do?method=updateSign&fdId=${param.fdId}" requestMethod="GET">
						<c:if test="${kmImissiveRegDetailListForm.fdStatus eq '1'}">
						    <ui:button text="${lfn:message('km-imissive:kmImissiveReg.updateSign') }" order="1" onclick="updateSign();">
							</ui:button>
						</c:if>
					</kmss:auth>
				</c:otherwise>
			</c:choose>
			<%--非会签才允许直接签收--%>
			<c:if test="${kmImissiveRegDetailListForm.fdRegDeliverType!='3' and  kmImissiveRegDetailListForm.fdRegDeliverType!='4' and kmImissiveRegDetailListForm.fdStatus eq '1'}">
				 <ui:button text="${lfn:message('km-imissive:kmImissiveReg.updateSignOnly') }" order="1" onclick="updateSignOnly();">
				</ui:button>
			</c:if>
			<c:if test="${canReturn  and kmImissiveRegDetailListForm.fdStatus eq '1'}">
			  <ui:button text="${lfn:message('km-imissive:kmImissiveReg.updateReturn') }" order="1" onclick="addBack();">
			  </ui:button>
			</c:if>
			
	   </kmss:auth>
		<ui:button text="${lfn:message('button.close')}" order="5" onclick="Com_CloseWindow();">
		</ui:button>
		</ui:toolbar>
</template:replace>
<template:replace name="content">
<script>
Com_IncludeFile("dialog.js");
	seajs.use(['sys/ui/js/dialog', 'lui/jquery'], function(dialog, $) {
		window.dialog=dialog;
	});
	
	window.updateSign = function() {
		var checkUrl = "${KMSS_Parameter_ContextPath}km/imissive/km_imissive_receive_main/kmImissiveReceiveMain.do?method=checkCanOpt";
		$.ajax({
			type: "post",
			url: checkUrl,
			data: {
				type: "SR",
				fdSendId: "${kmImissiveRegDetailListForm.fdRegSendId}",
				fdDetailId: "${kmImissiveRegDetailListForm.fdId}",
				justCheckCancel: "false"
			},
			async: false, //用同步方式 
			success: function(data) {
				results = eval("(" + data + ")");
				if (results['cancel'] != "true") {
					if (results['nodata'] == "true") {
						var url = "/km/imissive/km_imissive_receive_main/kmImissiveReceiveMain.do?method=addReceive&fddetaiId=${kmImissiveRegDetailListForm.fdId}&fdTemplateId=!{id}";
						dialog.categoryForNewFile(
							'com.landray.kmss.km.imissive.model.KmImissiveReceiveTemplate', url, false,
							null, null, null, "_self", null, true);
					} else if (results['fdTemplateId'] != "" && results['fdCfgId'] != "") {
						var fdTemplateId = results['fdTemplateId'];
						var fdCfgId = results['fdCfgId'];
						var url = "${LUI_ContextPath}/km/imissive/km_imissive_receive_main/kmImissiveReceiveMain.do?method=addReceive&fddetaiId=${kmImissiveRegDetailListForm.fdId}&fdTemplateId=" +
							fdTemplateId + "&fdCfgId=" + fdCfgId;
						window.open(url, "_self");
					} else {
						dialog.tree(
							'kmImissiveCfgTreeService&type=SR&fdSendId=${kmImissiveRegDetailListForm.fdRegSendId}',
							'<bean:message key="kmImissiveReg.select.template" bundle="km-imissive" />',
							function(rtn) {
								if (rtn) {
									var idString = rtn.value;
									if (idString != "") {
										var idArray = idString.split(";");
										var fdTemplateId = idArray[0];
										var fdCfgId = idArray[1];
										var url =
											"${LUI_ContextPath}/km/imissive/km_imissive_receive_main/kmImissiveReceiveMain.do?method=addReceive&fddetaiId=${kmImissiveRegDetailListForm.fdId}&fdTemplateId=" +
											fdTemplateId + "&fdCfgId=" + fdCfgId;
										window.open(url, "_self");
									}
								}
							});
					}
				} else {
					dialog.alert("该登记单已撤回，无法签收！");
				}
			}
		});
	};

	window.updateSignSend = function() {
		var checkUrl = "${KMSS_Parameter_ContextPath}km/imissive/km_imissive_receive_main/kmImissiveReceiveMain.do?method=checkCanOpt";
		$.ajax({
			type: "post",
			url: checkUrl,
			data: {
				type: "RS",
				fdReceiveId: "${kmImissiveRegDetailListForm.fdRegReceiveId}",
				fdDetailId: "${kmImissiveRegDetailListForm.fdId}",
				justCheckCancel: "false"
			},
			async: false, //用同步方式 
			success: function(data) {
				results = eval("(" + data + ")");
				if (results['cancel'] != "true") {
					if (results['nodata'] == "true") {
						var url = "/km/imissive/km_imissive_send_main/kmImissiveSendMain.do?method=addSend&fddetaiId=${kmImissiveRegDetailListForm.fdId}&fdTemplateId=!{id}";
						dialog.categoryForNewFile(
							'com.landray.kmss.km.imissive.model.KmImissiveSendTemplate', url, false,
							null, null, null, "_self", null, true);
					} else if (results['fdTemplateId'] != "" && results['fdCfgId'] != "") {
						var fdTemplateId = results['fdTemplateId'];
						var fdCfgId = results['fdCfgId'];
						var url = "${LUI_ContextPath}/km/imissive/km_imissive_send_main/kmImissiveSendMain.do?method=addSend&fddetaiId=${kmImissiveRegDetailListForm.fdId}&fdTemplateId=" +
							fdTemplateId + "&fdCfgId=" + fdCfgId;
						Com_OpenWindow(url, "_self");
					} else {
						dialog.tree(
							'kmImissiveCfgTreeService&type=RS&fdReceiveId=${kmImissiveRegDetailListForm.fdRegReceiveId}',
							'<bean:message  bundle="km-imissive" key="kmImissiveReceiveMain.select.sendTemplate"/>',
							function(rtn) {
								if (rtn) {
									var idString = rtn.value;
									if (idString != "") {
										var idArray = idString.split(";");
										var fdTemplateId = idArray[0];
										var fdCfgId = idArray[1];
										var url =
											"${LUI_ContextPath}/km/imissive/km_imissive_send_main/kmImissiveSendMain.do?method=addSend&fddetaiId=${kmImissiveRegDetailListForm.fdId}&fdTemplateId=" +
											fdTemplateId + "&fdCfgId=" + fdCfgId;
										Com_OpenWindow(url, "_self");
									}
								}
							});
					}
				} else {
					dialog.alert("该登记单已撤回，无法签收！");
				}
			}
		});
	};
	
	window.updateSignReceive = function() {
		var checkUrl = "${KMSS_Parameter_ContextPath}km/imissive/km_imissive_receive_main/kmImissiveReceiveMain.do?method=checkCanOpt";
		$.ajax({
			type: "post",
			url: checkUrl,
			data: {
				type: "RR",
				fdReceiveId: "${kmImissiveRegDetailListForm.fdRegReceiveId}",
				fdDetailId: "${kmImissiveRegDetailListForm.fdId}",
				justCheckCancel: "false"
			},
			async: false, //用同步方式 
			success: function(data) {
				results = eval("(" + data + ")");
				if (results['cancel'] != "true") {
					if (results['nodata'] == "true") {
						var url = "/km/imissive/km_imissive_receive_main/kmImissiveReceiveMain.do?method=addReceive&fddetaiId=${kmImissiveRegDetailListForm.fdId}&fdTemplateId=!{id}";
						dialog.categoryForNewFile(
							'com.landray.kmss.km.imissive.model.KmImissiveReceiveTemplate', url, false,
							null, null, null, "_self", null, true);
					} else if (results['fdTemplateId'] != "" && results['fdCfgId'] != "") {
						var fdTemplateId = results['fdTemplateId'];
						var fdCfgId = results['fdCfgId'];
						var url = "${LUI_ContextPath}/km/imissive/km_imissive_receive_main/kmImissiveReceiveMain.do?method=addReceive&fddetaiId=${kmImissiveRegDetailListForm.fdId}&fdTemplateId=" +
							fdTemplateId + "&fdCfgId=" + fdCfgId;
						Com_OpenWindow(url, "_self");
					} else {
						dialog.tree(
							'kmImissiveCfgTreeService&type=RR&fdReceiveId=${kmImissiveRegDetailListForm.fdRegReceiveId}',
							'<bean:message  bundle="km-imissive" key="kmImissiveReceiveMain.select.receiveTemplate"/>',
							function(rtn) {
								if (rtn) {
									var idString = rtn.value;
									if (idString != "") {
										var idArray = idString.split(";");
										var fdTemplateId = idArray[0];
										var fdCfgId = idArray[1];
										var url = "${LUI_ContextPath}/km/imissive/km_imissive_receive_main/kmImissiveReceiveMain.do?method=addReceive&fddetaiId=${kmImissiveRegDetailListForm.fdId}&fdTemplateId=" +
											fdTemplateId + "&fdCfgId=" + fdCfgId;
										Com_OpenWindow(url, "_self");
									}
								}
							});
					}
				} else {
					dialog.alert("该登记单已撤回，无法签收！");
				}
			}
		});
	};

	window.updateSignOnly = function() {
		var checkUrl = "${KMSS_Parameter_ContextPath}km/imissive/km_imissive_receive_main/kmImissiveReceiveMain.do?method=checkCanOpt";
		$.ajax({
			type: "post",
			url: checkUrl,
			data: {
				fdDetailId: "${kmImissiveRegDetailListForm.fdId}",
				justCheckCancel: "true"
			},
			async: false, //用同步方式 
			success: function(data) {
				results = eval("(" + data + ")");
				if (results['cancel'] != "true") {
					dialog.confirm(
						'<bean:message  bundle="km-imissive" key="kmImissiveRegDetailList.updateSignOnly.confirm"/>',
						function(flag) {
							if (flag == true) {
								var url = "${LUI_ContextPath}/km/imissive/km_imissive_receive_main/kmImissiveReceiveMain.do?method=saveReceiveOnly&fddetaiId=${kmImissiveRegDetailListForm.fdId}";
								$.ajax({
									url: url,
									async: false, //用同步方式 
									success: function(data) {
										refreshNotify();
										location.reload();
									}
								});
								// window.open(url, "_self");
							} else {
								return;
							}
						}, "warn");
				} else {
					dialog.alert("该登记单已撤回，无法签收！");
				}
			}
		});
	};

	function refreshNotify() {
		try {
			if (window.opener != null) {
				try {
					if (window.opener.LUI) {
						window.opener.LUI.fire({
							type: "topic",
							name: "successReloadPage"
						});
						return;
					}
				} catch (e) {}
				if (window.LUI) {
					LUI.fire({
						type: "topic",
						name: "successReloadPage"
					}, window.opener);
				}
				var hrefUrl = window.opener.location.href;
				var localUrl = location.href;
				if (hrefUrl.indexOf("/sys/notify/") > -1 && localUrl.indexOf("/sys/notify/") == -1)
					window.opener.location.reload();
			} else if (window.frameElement && window.frameElement.tagName == "IFRAME" && window.parent) {
				if (window.parent.LUI) {
					window.parent.LUI.fire({
						type: "topic",
						name: "successReloadPage"
					});
				}
			}
		} catch (e) {}
	};

	window.addBack = function() {
		var checkUrl = "${KMSS_Parameter_ContextPath}km/imissive/km_imissive_receive_main/kmImissiveReceiveMain.do?method=checkCanOpt";
		$.ajax({
			type: "post",
			url: checkUrl,
			data: {
				fdDetailId: "${kmImissiveRegDetailListForm.fdId}",
				justCheckCancel: "true"
			},
			async: false, //用同步方式 
			success: function(data) {
				results = eval("(" + data + ")");
				if (results['cancel'] != "true") {
					var url = "${LUI_ContextPath}/km/imissive/km_imissive_return_opinion/kmImissiveReturnOpinion.do?method=add&fdImissiveId=${kmImissiveRegDetailListForm.fdRegSendId}&fddetaiId=${kmImissiveRegDetailListForm.fdId}";
					window.open(url, "_self");
				} else {
					dialog.alert("该登记单已撤回，无法退回！");
				}
			}
		});
	};
	
	window.openDoc = function() {
		var url = "${LUI_ContextPath}${kmImissiveRegDetailListForm.fdRegLink}";
		window.open(url);
	};
	
	window.openReceiveDoc = function() {
		var url = "${LUI_ContextPath}/km/imissive/km_imissive_receive_main/kmImissiveReceiveMain.do?method=view&fdId=${kmImissiveRegDetailListForm.fdReceiveId}";
		if ("${kmImissiveRegDetailListForm.fdSignType}" == '1') {
			url = "${LUI_ContextPath}/km/imissive/km_imissive_send_main/kmImissiveSendMain.do?method=view&fdId=${kmImissiveRegDetailListForm.fdReceiveId}";
		}
		window.open(url);
	};
</script>
<script>
//解决非ie下控件高度问题
	$(document).ready(function(){
		var obj1 = document.getElementById("JGWebOffice_${kmImissiveRegDetailListForm.fdRegId}");
		if(obj1){
			obj1.setAttribute("height", "550px");
		}
	});
	
	seajs.use(['lui/topic' ], function(topic) {
		var officeIframeh = "550";
		 topic.subscribe('/sys/attachment/wpsCloud/loaded', function(obj) {
			if(obj){
				obj.iframe.style.height=(officeIframeh)+"px"
			}
		});
	});
</script>
	<div class="lui_form_content_frame" style="padding-top:10px">
		<html:form action="/km/imissive/km_imissive_regdetail_list/kmImissiveRegDetailList.do"> 
			<input type="hidden" name="fdtempId"/>
			<input type="hidden" name="fdtempName"/>
			<input type="hidden" name="fdTableHead"/>
			<kmss:ifModuleExist path="/elec/yqq/">
				<c:set var="yqqExist" value="true"/>
			</kmss:ifModuleExist>
			<kmss:ifModuleExist path="/elec/eqb/">
				<c:set var="eqbExist" value="true"/>
			</kmss:ifModuleExist>
		    <table class="tb_normal" width=100%>
			   <html:hidden property="fdId"/>
			    <tr>
					<td class="td_normal_title" colspan="4">
						 <p class="txttitle"><bean:message key="table.kmImissiveReg" bundle="km-imissive" /></p>
					</td>
				</tr>
			   <tr>
					<td class="td_normal_title" width=15%>
						<bean:message key="kmImissiveReg.fdName" bundle="km-imissive" />
					</td>
					<td width=35% colspan="3">
						<c:out value="${kmImissiveRegDetailListForm.fdRegName}" />
					</td>
				</tr>
				 <tr>
					<td class="td_normal_title" width=15%>
						<bean:message  bundle="km-imissive" key="kmImissiveSendMain.fdDocNum"/>
					</td>
					<td width=35%>
					    <c:if test="${empty kmImissiveRegDetailListForm.fdRegNo}">
					          	${lfn:message("km-imissive:kmImissiveSendMain.fdDocNum.auto") }
					    </c:if>
					    <c:if test="${not empty kmImissiveRegDetailListForm.fdRegNo}">
					              <c:out value="${kmImissiveRegDetailListForm.fdRegNo}" />
					    </c:if>
					</td>
					<td class="td_normal_title" width=15%>
						<bean:message  bundle="km-imissive" key="kmImissiveReg.docCreateTime"/>
					</td>
					<td width=35%>
						<c:out value="${kmImissiveRegDetailListForm.fdRegDocCreateTime}"/>
					</td>
				</tr>
				<tr>
					<td class="td_normal_title" width=15%>
						<bean:message  bundle="km-imissive" key="kmImissiveReg.fdSendUnit"/>
					</td>
					<td width=35%>
						<c:out value="${fdFromUnit}" />
					</td>
					<td class="td_normal_title" width=15%>
						<bean:message  bundle="km-imissive" key="kmImissiveReg.fdUnit"/>
					</td>
					<td width=35%>
						<c:out value="${kmImissiveRegDetailListForm.fdUnitName}" />
					</td>
				</tr>
				<tr>
					<td class="td_normal_title" width=15%>
						<bean:message  bundle="km-imissive" key="kmImissiveReg.fdOrgNames"/>
					</td>
					<td width=35%>
						<c:out value="${kmImissiveRegDetailListForm.fdOrgNames}" />
					</td>
					<td class="td_normal_title" width=15%>
						<bean:message  bundle="km-imissive" key="kmImissiveReg.fdStatus"/>
					</td>
					<td width=35%>
						 <sunbor:enumsShow value="${kmImissiveRegDetailListForm.fdStatus}" enumsType="kmImissiveReg_status" bundle="km-imissive" />
					</td>
				</tr>
				<c:if test="${kmImissiveRegDetailListForm.fdStatus eq '2' or kmImissiveRegDetailListForm.fdStatus eq '4'}">
					<tr>
						<td class="td_normal_title" width=15%>
							<bean:message  bundle="km-imissive" key="kmImissiveReg.fdLinkSubject"/>
						</td>
						<td width=85% colspan="3">
							<c:choose>
					            <c:when test="${not empty kmImissiveRegDetailListForm.fdReceiveId}">
					              <a class="com_btn_link" href="javascript:void(0)" onclick="openReceiveDoc();">${ReceiveDocName}</a>
					            </c:when>
					            <c:otherwise>
					               <bean:message  bundle="km-imissive" key="kmImissiveReg.fdLinkSubject.null"/>
					            </c:otherwise>
				          </c:choose>
						</td>
					</tr>
				</c:if>
				<c:if test="${not empty kmImissiveRegDetailListForm.fdDesc}">
					<tr>
						<td class="td_normal_title" width=15%>
							<c:if test="${kmImissiveRegDetailListForm.fdRegDeliverType eq '1'}">
							   <bean:message  bundle="km-imissive" key="kmImissiveReg.opinion.distribute"/>
							</c:if>
							<c:if test="${kmImissiveRegDetailListForm.fdRegDeliverType eq '2'}">
							   <bean:message  bundle="km-imissive" key="kmImissiveReg.opinion.report"/>
							</c:if>
						</td>
						<td width=85% colspan="3">
						   <c:out value="${kmImissiveRegDetailListForm.fdDesc}"/>
						</td>
					</tr>
				</c:if>
				<c:if test="${not empty kmImissiveRegDetailListForm.fdSignTime}">
					 <tr>
						<td class="td_normal_title" width=15%>
							<bean:message  bundle="km-imissive" key="kmImissiveReg.fdSignerName"/>
						</td>
						<td width=35%>
							<c:out value="${kmImissiveRegDetailListForm.fdSignerName}"/>
						</td>
						<td class="td_normal_title" width=15%>
							<bean:message  bundle="km-imissive" key="kmImissiveReg.fdSignTime"/>
						</td>
						<td width=35%>
							<c:out value="${kmImissiveRegDetailListForm.fdSignTime}"/>
						</td>
					</tr>
				</c:if>
				<c:if test="${kmImissiveRegDetailListForm.fdStatus eq '3' or kmImissiveRegDetailListForm.fdStatus eq '4'}">
					<tr>
						<td class="td_normal_title" width=15%>
						<c:if test="${kmImissiveRegDetailListForm.fdStatus eq '3'}">
							退回人
						</c:if>	
						<c:if test="${kmImissiveRegDetailListForm.fdStatus eq '4'}">
							退文人
						</c:if>
						</td>
						<td width=35%>
							<c:out value="${returnPerson}"/>
						</td>
						<td class="td_normal_title" width=15%>
						<c:if test="${kmImissiveRegDetailListForm.fdStatus eq '3'}">
							退回时间
						</c:if>	
						<c:if test="${kmImissiveRegDetailListForm.fdStatus eq '4'}">
							退文时间
						</c:if>
						</td>
						<td width=35%>
							<c:out value="${returnTime}"/>
						</td>
					</tr>
					<tr>
						<td class="td_normal_title" width=15%>
						<c:if test="${kmImissiveRegDetailListForm.fdStatus eq '3'}">
							<bean:message  bundle="km-imissive" key="kmImissiveReg.return.reason"/>
						</c:if>	
						<c:if test="${kmImissiveRegDetailListForm.fdStatus eq '4'}">
							<bean:message  bundle="km-imissive" key="kmImissiveReg.returnDoc.reason"/>
						</c:if>
						</td>
						<td width=85% colspan="3">
							<c:out value="${docContent}"/>
						</td>
					</tr>
				</c:if>
				<%
					if(request.getHeader("User-Agent").toUpperCase().indexOf("MSIE")>-1){
						request.setAttribute("isIE",true);
					}else if(request.getHeader("User-Agent").toUpperCase().indexOf("TRIDENT")>-1){
						request.setAttribute("isIE",true);
					}else{
						request.setAttribute("isIE",false);
					}
				%>
				<c:set var="fdModelId" value="${kmImissiveRegDetailListForm.fdRegId}" scope="request"/>
				<c:set var="fdModelName" value="com.landray.kmss.km.imissive.model.KmImissiveReg" scope="request"/>
				<c:set var="fdKey" value="${kmImissiveRegDetailListForm.fdRegId}" scope="request"/>
				<%
					try{
						List sysAttMains = new ArrayList();
						SysAttMain sysAttMain = null;
						String _modelName =(String) request.getAttribute("fdModelName");
						String _modelId = (String)request.getAttribute("fdModelId");
						String _key = (String)request.getAttribute("fdKey");
						if(StringUtil.isNotNull(_modelName) && StringUtil.isNotNull(_modelId) && StringUtil.isNotNull(_key)){
							ISysAttMainCoreInnerService sysAttMainService = (ISysAttMainCoreInnerService)SpringBeanUtil.getBean("sysAttMainService");
						    sysAttMains = sysAttMainService.findByModelKey(_modelName,_modelId,_key);
						}
						if(sysAttMains!=null && !sysAttMains.isEmpty()){
							sysAttMain = (SysAttMain)sysAttMains.get(0);
							pageContext.setAttribute("sysAttMain",sysAttMain);
							String suffix = sysAttMain.getFdFileName().substring(sysAttMain.getFdFileName().lastIndexOf(".")+1);
							request.setAttribute("suffix", suffix);
						}
					}catch(Exception e){
						e.printStackTrace();
					}	
				%>
				<c:set var="fdAttMainId" value="${sysAttMain.fdId}" scope="request"/>
				<c:choose>
				 <c:when test="${(kmImissiveRegDetailListForm.fdAttAuthFlag eq '1') and ('doc' eq suffix or 'docx' eq suffix) and (wpsoaassist ne 'true')}">
				   <tr>
						<td colspan="4">
				 			<%if(com.landray.kmss.sys.attachment.util.JgWebOffice.isJGEnabled()&&JgWebOffice.isExistViewPath(request)){%>
							   <c:if test="${isShowImg and editStatus != true  and _isWpsCloudEnable ne true and _isWpsCenterEnable ne true  and _useWpsLinuxView ne true}">
								  <table class="tb_normal" width="100%">
									   <tr>
									     	<td colspan="4">
									     	  <font style="text-align:center"><bean:message  bundle="km-imissive" key="kmMissiveMain.prompt"/></font>
									        </td>
									   </tr>
								    </table>
							  </c:if>
							<%}%>
							<c:if test="${_isWpsCloudEnable ne true and _isWpsCenterEnable ne true and _useWpsLinuxView ne true}">
								 <div id="missiveButtonDiv" style="text-align:right;padding-bottom:5px">&nbsp;
								      <%if(JgWebOffice.isJGEnabled()&&Boolean.parseBoolean(KmImissiveConfigUtil.isShowImg())){ %>
										<c:choose>
										 <c:when test="${isIE}">
										    <c:if test="${empty isShowImg or isShowImg eq true}">
										    <%  if(JgWebOffice.isExistViewPath(request)){ %>
											     <a href="javascript:void(0);" class="attswich com_btn_link"
													onclick="Com_OpenWindow('kmImissiveRegDetailList.do?method=view&fdId=${param.fdId}&isShowImg=${isShowImg}','_self');">
												   <bean:message  bundle="km-imissive" key="missive.button.Word"/>
												 </a>
											 <%} else{%>
											     <a href="javascript:void(0);" class="attswich com_btn_link"
													onclick="Com_OpenWindow('kmImissiveRegDetailList.do?method=view&fdId=${param.fdId}&isShowImg=${isShowImg}','_self');">
												   <bean:message  bundle="km-imissive" key="missive.button.Html"/>
												 </a>
											 <% }%>
											</c:if>
											<c:if test="${isShowImg eq false}">
											  <a href="javascript:void(0);" class="attswich com_btn_link"
												onclick="Com_OpenWindow('kmImissiveRegDetailList.do?method=view&fdId=${param.fdId}&isShowImg=${isShowImg}','_self');">
											   <bean:message  bundle="km-imissive" key="missive.button.Html"/>
											 </a>
											</c:if> 
										 </c:when>
										 <c:otherwise>
										   <%if(JgWebOffice.isJGMULEnabled()){%>
											   <a href="javascript:void(0);" class="attswich com_btn_link"
												onclick="Com_OpenWindow('kmImissiveRegDetailList.do?method=view&fdId=${param.fdId}&isShowImg=${isShowImg}','_self');">
											   ${lfn:message('km-imissive:missive.button.change.view') }
											   </a>
										    <%} %>
										 </c:otherwise>
										</c:choose>
									<%} %>
						         </div>
					         </c:if>
							 <%
									// 金格启用模式
									if(com.landray.kmss.sys.attachment.util.JgWebOffice.isJGEnabled()) {
										request.setAttribute("showAllPage","allpage".equals(KmImissiveConfigUtil.getLoadType())?true:false);
									}
							 %>
								 <c:import url="/sys/attachment/sys_att_main/jg/sysAttMain_include_viewHtml.jsp" charEncoding="UTF-8">
									<c:param name="fdKey" value="${kmImissiveRegDetailListForm.fdRegId}" />
									<c:param name="fdAttType" value="office" />
									<c:param name="fdMulti"  value="false" />
									<c:param name="fdModelId" value="${kmImissiveRegDetailListForm.fdRegId}" />
									<c:param name="fdModelName" value="com.landray.kmss.km.imissive.model.KmImissiveReg" />
									<c:param name="formBeanName" value="kmImissiveRegForm" />
									<c:param  name="contentFlag"  value="true"/>
									<c:param  name="isExpand"  value="true"/>
									<c:param name="isShowImg" value="${isShowImg}"/>
									<c:param  name="showAllPage"  value="${showAllPage}"/>
									<c:param name="buttonDiv" value="missiveButtonDiv" />
								</c:import>
									
						</td>
					</tr>
				 </c:when>
				 <c:otherwise>
					 <tr>
						<td class="td_normal_title" width=15%>
							<bean:message  bundle="km-imissive" key="kmImissiveReg.attachment.content"/>
						</td>
						<td width=85% colspan="3">
							<c:choose>
								<c:when test="${not empty attId and empty signAttId}">
									<jsp:include page="/km/imissive/km_imissive_regdetail_list/kmImissiveRegDetailList_btn_include.jsp">
										<jsp:param name="attId" value="${attId}"/>
										<jsp:param name="_isWpsCloudEnable" value="${_isWpsCloudEnable}"/>
										<jsp:param name="_wpsLinuxPreview" value="${_wpsLinuxPreview}"/>
										<jsp:param name="_isWpsCenterEnable" value="${_isWpsCenterEnable}"/>
										<jsp:param name="wpsoaassist" value="${wpsoaassist}"/>
									</jsp:include>
								</c:when>
								<c:otherwise>
									<c:import url="/sys/attachment/sys_att_main/sysAttMain_view.jsp" charEncoding="UTF-8">
										<c:param name="formBeanName" value="kmImissiveRegForm" />
										<c:param name="fdKey" value="${kmImissiveRegDetailListForm.fdRegId}" />
										<c:param name="fdModelId" value="${kmImissiveRegDetailListForm.fdRegId}" />
										<c:param name="fdModelName" value="com.landray.kmss.km.imissive.model.KmImissiveReg" />
									</c:import>
								</c:otherwise>
							</c:choose>
						</td>
					</tr>
				 </c:otherwise>
				</c:choose>
<%--				<tr>--%>
<%--					<td class="td_normal_title" width=15%>--%>
<%--						原表单信息--%>
<%--					</td>--%>
<%--					<td width=85% colspan="3">--%>
<%--					  <c:import url="/sys/attachment/sys_att_main/sysAttMain_view.jsp" charEncoding="UTF-8">--%>
<%--						<c:param name="formBeanName" value="kmImissiveRegForm" />--%>
<%--						<c:param name="fdKey" value="baseInfoAtt" />--%>
<%--						<c:param name="fdModelId" value="${kmImissiveRegDetailListForm.fdRegId}" />--%>
<%--						<c:param name="fdModelName" value="com.landray.kmss.km.imissive.model.KmImissiveReg" />--%>
<%--					  </c:import>--%>
<%--					</td>--%>
<%--				</tr>--%>
				<tr>
					<td class="td_normal_title" width=15%>
						<bean:message  bundle="km-imissive" key="kmImissiveReg.attachment"/>
					</td>
					<td width=85% colspan="3">
					  <c:import url="/sys/attachment/sys_att_main/sysAttMain_view.jsp" charEncoding="UTF-8">
						<c:param name="formBeanName" value="kmImissiveRegForm" />
						<c:param name="fdKey" value="regAtt" />
						<c:param name="fdModelId" value="${kmImissiveRegDetailListForm.fdRegId}" />
						<c:param name="fdModelName" value="com.landray.kmss.km.imissive.model.KmImissiveReg" />
					  </c:import>
					</td>
				</tr>
				<tr>
					<td class="td_normal_title" width=15%>
						签署附件
					</td>
					<td width=85% colspan="3">
						<c:choose>
							<c:when test="${not empty signAttId}">
								<jsp:include page="/km/imissive/km_imissive_regdetail_list/kmImissiveRegDetailList_btn_include.jsp">
									<jsp:param name="attId" value="${signAttId}"/>
									<jsp:param name="_isWpsCloudEnable" value="${_isWpsCloudEnable}"/>
									<jsp:param name="_wpsLinuxPreview" value="${_wpsLinuxPreview}"/>
									<jsp:param name="_isWpsCenterEnable" value="${_isWpsCenterEnable}"/>
									<jsp:param name="signAttKey" value="${signAttKey}"/>
									<jsp:param name="wpsoaassist" value="${wpsoaassist}"/>
								</jsp:include>
							</c:when>
							<c:otherwise>
								<c:if test="${yqqExist eq 'true'}">
									<c:import url="/sys/attachment/sys_att_main/sysAttMain_view.jsp" charEncoding="UTF-8">
										<c:param name="formBeanName" value="kmImissiveRegForm" />
										<c:param name="fdKey" value="yqqSigned" />
										<c:param name="fdModelId" value="${kmImissiveRegDetailListForm.fdRegId}" />
										<c:param name="fdModelName" value="com.landray.kmss.km.imissive.model.KmImissiveReg" />
									</c:import>
								</c:if>
								<c:if test="${eqbExist eq 'true'}">
									<c:import url="/sys/attachment/sys_att_main/sysAttMain_view.jsp" charEncoding="UTF-8">
										<c:param name="formBeanName" value="kmImissiveRegForm" />
										<c:param name="fdKey" value="eqbSign" />
										<c:param name="fdModelId" value="${kmImissiveRegDetailListForm.fdRegId}" />
										<c:param name="fdModelName" value="com.landray.kmss.km.imissive.model.KmImissiveReg" />
									</c:import>
									<c:import url="/sys/attachment/sys_att_main/sysAttMain_view.jsp" charEncoding="UTF-8">
										<c:param name="formBeanName" value="kmImissiveRegForm" />
										<c:param name="fdKey" value="ofdEqbSign" />
										<c:param name="fdModelId" value="${kmImissiveRegDetailListForm.fdRegId}" />
										<c:param name="fdModelName" value="com.landray.kmss.km.imissive.model.KmImissiveReg" />
									</c:import>
								</c:if>
								<c:import url="/sys/attachment/sys_att_main/sysAttMain_view.jsp" charEncoding="UTF-8">
									<c:param name="formBeanName" value="kmImissiveRegForm" />
									<c:param name="fdKey" value="ofdCySign" />
									<c:param name="fdModelId" value="${kmImissiveRegDetailListForm.fdRegId}" />
									<c:param name="fdModelName" value="com.landray.kmss.km.imissive.model.KmImissiveReg" />
								</c:import>
								<c:import url="/sys/attachment/sys_att_main/sysAttMain_view.jsp" charEncoding="UTF-8">
									<c:param name="formBeanName" value="kmImissiveRegForm" />
									<c:param name="fdKey" value="dianjuSign" />
									<c:param name="fdModelId" value="${kmImissiveRegDetailListForm.fdRegId}" />
									<c:param name="fdModelName" value="com.landray.kmss.km.imissive.model.KmImissiveReg" />
								</c:import>
								<c:import url="/sys/attachment/sys_att_main/sysAttMain_view.jsp" charEncoding="UTF-8">
									<c:param name="formBeanName" value="kmImissiveRegForm" />
									<c:param name="fdKey" value="ofdSursenSign" />
									<c:param name="fdModelId" value="${kmImissiveRegDetailListForm.fdRegId}" />
									<c:param name="fdModelName" value="com.landray.kmss.km.imissive.model.KmImissiveReg" />
								</c:import>
							</c:otherwise>
						</c:choose>
					</td>
				</tr>
				<c:if test="${kmImissiveRegDetailListForm.fdReadReviewOpinion eq '1'}">
					<tr>
						<td colspan="4" style="padding:0;"> 
							<div class="lui_form_subhead" style="padding:10px 8px ">原审批意见:</div>
							 <c:choose>
								 <c:when test="${kmImissiveRegDetailListForm.fdRegType eq '2' }">
									<c:set var="fdModelId" value="${kmImissiveRegDetailListForm.fdRegReceiveId}" scope="request"/>
									<c:set var="fdModelName" value="com.landray.kmss.km.imissive.model.KmImissiveReceiveMain" scope="request"/>
									<c:set var="formBeanName" value="kmImissiveReceiveMainFormx" scope="request"/>
								</c:when>
								<c:otherwise>
									<c:set var="fdModelId" value="${kmImissiveRegDetailListForm.fdRegSendId}" scope="request"/>
									<c:set var="fdModelName" value="com.landray.kmss.km.imissive.model.KmImissiveSendMain" scope="request"/>
									<c:set var="formBeanName" value="kmImissiveSendMainFormx" scope="request"/>
								</c:otherwise>
							</c:choose>
							<c:import url="/km/imissive/km_imissive_reg/kmImissiveReg_listNote.jsp" charEncoding="UTF-8">
								<c:param name="fdMainId" value="${fdModelId}" />
								<c:param name="fdModelName" value="${fdModelName}" />
								<c:param name="formBeanName" value="${formBeanName}"/>
								<c:param name="fdRegId" value="${kmImissiveRegDetailListForm.fdRegId}" />
							</c:import>
						</td>
					</tr>
				</c:if>
			</table>
		</html:form>	
		</div>
</template:replace>
</template:include>
