<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="com.landray.kmss.util.StringUtil"%>
<%@page import="com.landray.kmss.sys.attachment.model.SysAttMain"%>
<%@page import="com.landray.kmss.sys.attachment.util.SysAttViewerUtil"%>
<%@ include file="/sys/ui/jsp/common.jsp"%>
<%@ taglib uri="/WEB-INF/KmssConfig/sys/person/person.tld" prefix="person"%>
<%@page import="com.landray.kmss.sys.attachment.integrate.wps.util.SysAttWpsCloudUtil"%>
<%@page import="com.landray.kmss.sys.attachment.integrate.wps.util.SysAttWpsCenterUtil"%>
<%@ include file="/component/locker/import/componentLockerVersion_show.jsp"%>
<%
	pageContext.setAttribute("_isWpsCloudEnable", new Boolean(SysAttWpsCloudUtil.isEnable(true)));
	pageContext.setAttribute("_isWpsCenterEnable", new Boolean(SysAttWpsCenterUtil.isWPSCenterEnableMobile(true)));
%>
<template:include ref="mobile.view" compatibleMode="true">
	<template:replace name="head">
		<link rel="Stylesheet" href="${LUI_ContextPath}/km/imissive/mobile/resource/css/dis.css?s_cache=${MUI_Cache}" />
		<link rel="Stylesheet" href="${LUI_ContextPath}/km/imissive/mobile/resource/css/imissive.css?s_cache=${MUI_Cache}" />
		<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/sys/mobile/css/themes/default/listview.css?s_cache=${MUI_Cache}"></link>
	</template:replace>
	<template:replace name="title">
		<c:out value="${kmImissiveReceiveMainForm.docSubject}"></c:out>
	</template:replace>
	<template:replace name="content">
		<xform:config  orient="vertical">
			<html:form action="/km/imissive/km_imissive_receive_main/kmImissiveReceiveMain.do">
				<div id="scrollView" class="gray" data-dojo-type="mui/view/DocScrollableView" data-dojo-mixins="mui/form/_ValidateMixin">
					<div class="muiViewBanner">
						<c:choose>
							<c:when test="${kmImissiveReceiveMainForm.fdNeedContent=='1'}">
								<c:set var="attForms" value="${kmImissiveReceiveMainForm.attachmentForms['editonline']}" />
							</c:when>
							<c:otherwise>
								<c:set var="attForms" value="${kmImissiveReceiveMainForm.attachmentForms['mainonline']}" />
							</c:otherwise>
						</c:choose>
						<c:if test="${attForms!=null && fn:length(attForms.attachments)>0}">
							<c:forEach var="sysAttMain" items="${attForms.attachments}" varStatus="vsStatus">
								<c:set var="attMainId" value="${sysAttMain.fdId }"></c:set>
								<%
									SysAttMain sysAttMain = (SysAttMain) pageContext
											.getAttribute("sysAttMain");
									String path = SysAttViewerUtil.getViewerPath(
											sysAttMain, request);
									if (StringUtil.isNotNull(path)){
										pageContext.setAttribute("hasThumbnail", "true");
										pageContext.setAttribute("hasViewer", "true");
									}
									pageContext.setAttribute("_sysAttMain", sysAttMain);
								%>
							</c:forEach>
						</c:if>
						<div class="leftInfo">
							<c:if test="${hasThumbnail =='true'}">
								<img class="muiSummaryImg" src="${LUI_ContextPath}/sys/attachment/sys_att_main/sysAttMain.do?method=view&filethumb=yes&fdId=${attMainId }" onerror="this.src='${LUI_ContextPath}/km/imissive/mobile/resource/images/thumbnail.png'" alt="" />
							</c:if>
							<c:if test="${hasThumbnail !='true'}">
								<img class="muiSummaryImg" src="${LUI_ContextPath}/km/imissive/mobile/resource/images/thumbnail.png" alt="" />
							</c:if>
							<c:choose>
								<c:when test="${kmImissiveReceiveMainForm.docStatus=='00'}">
									<c:set var="statusBg" value="muiSmissiveDiscard"/>
									<c:set var="statusText" value="${ lfn:message('status.discard')}"/>
								</c:when>
								<c:when test="${kmImissiveReceiveMainForm.docStatus=='10'}">
									<c:set var="statusBg" value="muiSmissiveDraft"/>
									<c:set var="statusText" value="${ lfn:message('status.draft')}"/>
								</c:when>
								<c:when test="${kmImissiveReceiveMainForm.docStatus=='11'}">
									<c:set var="statusBg" value="muiSmissiveRefuse"/>
									<c:set var="statusText" value="${ lfn:message('km-imissive:kmImissive.status.refuse')}"/>
								</c:when>
								<c:when test="${kmImissiveReceiveMainForm.docStatus=='20'}">
									<c:set var="statusBg" value="muiSmissiveExamine"/>
									<c:set var="statusText" value="${ lfn:message('status.examine')}"/>
								</c:when>
								<c:when test="${kmImissiveReceiveMainForm.docStatus=='30'}">
									<c:set var="statusBg" value="muiSmissivePublish"/>
									<c:set var="statusText" value="${ lfn:message('km-imissive:kmImissive.status.publish')}"/>
								</c:when>
							</c:choose>
							<div class="muiSmissiveStatus ${statusBg}">
									${statusText }
							</div>
						</div>
						<div class="rightInfo">
					<span class="title">
						<xform:text property="docSubject"></xform:text>
					</span>
						<ul>
							<li>
								<span><bean:message  bundle="km-imissive" key="kmImissiveReceiveMain.fdSendtoDept"/>：<c:out value="${kmImissiveReceiveMainForm.fdSendtoUnitName}" /><c:out value="${kmImissiveReceiveMainForm.fdOutSendto}" /></span>
							</li>
							<li>
								<span><bean:message  bundle="km-imissive" key="kmImissiveReceiveMain.fdReceiveNum"/>：<c:out value="${kmImissiveReceiveMainForm.fdReceiveNum}" /></span>
							</li>
						</ul>
						</div>

					</div>
					<div data-dojo-type="mui/panel/AccordionPanel" class="flatContentView">
						<c:if test="${not empty _sysAttMain.fdId }">
							<%--是否有编辑正文权限--%>
							<c:set var="editContent" value="false"/>
							<c:if  test="${kmImissiveReceiveMainForm.sysWfBusinessForm.fdNodeAdditionalInfo.editDocContent =='true'}">
								<c:set var="editContent" value="true"/>
							</c:if>
							<%--签署附件key--%>
							<c:set var="fdYqqKeyPdf" value="yqqSigned" />
							<c:set var="fdEqbKeyPdf" value="eqbSign" />
							<c:set var="fdEqbKeyOfd" value="ofdEqbSign" />
							<c:set var="fdCyKeyOfd" value="ofdCySign" />
							<c:set var="fdSsKeyOfd" value="ofdSursenSign" />
							<c:set var="fdConvertPdf" value="convert_toPDF" />
							<c:set var="fdConvertOfd" value="convert_toOFD" />
							<c:choose>
								<c:when  test="${not empty kmImissiveReceiveMainForm.attachmentForms[fdYqqKeyPdf].attachments}">
									<c:set var="signedKey" value="yqqSigned" scope="request"/>
								</c:when>
								<c:when test="${not empty kmImissiveReceiveMainForm.attachmentForms[fdEqbKeyPdf].attachments}">
									<c:set var="signedKey" value="eqbSign" scope="request"/>
								</c:when>
								<c:when test="${not empty kmImissiveReceiveMainForm.attachmentForms[fdEqbKeyOfd].attachments}">
									<c:set var="signedKey" value="ofdEqbSign" scope="request"/>
								</c:when>
								<c:when test="${not empty kmImissiveReceiveMainForm.attachmentForms[fdCyKeyOfd].attachments}">
									<c:set var="signedKey" value="ofdCySign" scope="request"/>
								</c:when>
								<c:when test="${not empty kmImissiveReceiveMainForm.attachmentForms[fdSsKeyOfd].attachments}">
									<c:set var="signedKey" value="ofdSursenSign" scope="request"/>
								</c:when>
								<c:when test="${not empty kmImissiveReceiveMainForm.attachmentForms[fdConvertPdf].attachments}">
									<c:set var="signedKey" value="convert_toPDF" scope="request"/>
								</c:when>
								<c:when test="${not empty kmImissiveReceiveMainForm.attachmentForms[fdConvertOfd].attachments}">
									<c:set var="signedKey" value="convert_toOFD" scope="request"/>
								</c:when>
								<c:otherwise>
									<c:set var="signedKey" value="" scope="request"/>
								</c:otherwise>
							</c:choose>
							<c:choose>
								<c:when test="${not empty signedKey}">
									<c:import url="/km/imissive/mobile/import/viewContent.jsp" charEncoding="UTF-8">
										<c:param name="fdKey" value="${signedKey}" />
										<c:param name="fdModelId" value="${kmImissiveReceiveMainForm.fdId}" />
										<c:param name="fdModelName" value="com.landray.kmss.km.imissive.model.KmImissiveReceiveMain" />
										<c:param name="formBeanName" value="kmImissiveReceiveMainForm" />
									</c:import>
								</c:when>
								<c:when test="${kmImissiveReceiveMainForm.fdNeedContent=='1'}">
									<c:import url="/sys/attachment/mobile/import/viewContent.jsp" charEncoding="UTF-8">
										<c:param name="formName" value="kmImissiveReceiveMainForm"></c:param>
										<c:param name="fdKey" value="editonline"></c:param>
										<c:param  name="contentFlag"  value="true"/>
										<c:param name="editContent" value="${editContent}"></c:param>
									</c:import>
								</c:when>
								<c:otherwise>
									<c:import url="/sys/attachment/mobile/import/viewContent.jsp" charEncoding="UTF-8">
										<c:param name="formName" value="kmImissiveReceiveMainForm"></c:param>
										<c:param name="fdKey" value="mainonline"></c:param>
										<c:param  name="contentFlag"  value="true"/>
										<c:param name="editContent" value="${editContent}"></c:param>
									</c:import>
								</c:otherwise>
							</c:choose>
						</c:if>
						<c:set var="existAtt" value="false" scope="request"/>
						<c:if test="${not empty kmImissiveReceiveMainForm.attachmentForms['attachment'].attachments}">
							<c:set var="existAtt" value="true" scope="request"/>
						</c:if>
						<c:if test="${kmImissiveReceiveMainForm.docStatus eq '10' or kmImissiveReceiveMainForm.docStatus eq '11' or kmImissiveReceiveMainForm.docStatus eq '20'}">
							<div class="revisionInfo_wrapper">
								<div class="detailInfo">
									<div data-dojo-type="dojox/mobile/ListItem" class="baseInfoNav"
										 data-dojo-props='icon:"mui mui-bookViewDetail",rightIcon:"mui mui-forward",clickable:true,noArrow:true,moveTo:"opinionView",transitionDir:1,transition:"slide"'>传阅意见</div>
								</div>
							</div>
						</c:if>
							<%--草稿，驳回和审批的文档稿纸和流程默认展开 --%>
						<c:if test="${kmImissiveReceiveMainForm.docStatus eq '10' or kmImissiveReceiveMainForm.docStatus eq '11' or kmImissiveReceiveMainForm.docStatus eq '20'}">
							<div data-dojo-type="mui/panel/Content"  data-dojo-props="title:'<bean:message  bundle="km-imissive" key="kmImissiveReceiveMain.baseinfo"/>',icon:'mui-ul'">
								<div data-dojo-type="mui/table/ScrollableHContainer">
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
								<c:if test="${not empty kmImissiveReceiveMainForm.attachmentForms[signedKey].attachments}">
									<c:import url="/sys/attachment/mobile/import/view.jsp" charEncoding="UTF-8">
										<c:param name="formName" value="kmImissiveReceiveMainForm"></c:param>
										<c:param name="fdKey" value="${signedKey}"></c:param>
										<c:param name="fdModelId" value="${param.fdId}" />
										<c:param name="fdModelName" value="com.landray.kmss.km.imissive.model.KmImissiveReceiveMain" />
									</c:import>
								</c:if>
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
							</div>
							<kmss:auth requestURL="/km/imissive/km_imissive_receive_main/kmImissiveReceiveMain.do?method=readViewLog&fdId=${param.fdId}" requestMethod="GET">
							<div data-dojo-type="mui/panel/Content" data-dojo-props="title:'<bean:message  bundle="km-imissive" key="mui.process.records"/>',icon:'mui-ul'">
								<c:import url="/sys/lbpmservice/mobile/lbpm_audit_note/import/view.jsp" charEncoding="UTF-8">
									<c:param name="fdModelId" value="${kmImissiveReceiveMainForm.fdId }"/>
									<c:param name="fdModelName" value="com.landray.kmss.km.imissive.model.KmImissiveReceiveMain"/>
									<c:param name="formBeanName" value="kmImissiveReceiveMainForm"/>
								</c:import>
							</div>
							</kmss:auth>
						</c:if>
					</div>
						<%--发布和废弃的文档稿纸和流程默认折叠 --%>
					<c:if test="${kmImissiveReceiveMainForm.docStatus eq '30' or kmImissiveReceiveMainForm.docStatus eq '00' }">
						<div class="detailInfo_wrapper">
							<div class="detailInfo">
								<div data-dojo-type="dojox/mobile/ListItem" class="baseInfoNav"
									 data-dojo-props='icon:"mui mui-bookViewDetail",rightIcon:"mui mui-forward",clickable:true,noArrow:true,onClick:viewDetailInfo'><bean:message  bundle="km-imissive" key="kmImissiveReceiveMain.baseinfo.title"/></div>
							</div>
							<div class="detailInfo">
								<div data-dojo-type="dojox/mobile/ListItem" class="baseInfoNav"
									 data-dojo-props='icon:"mui mui-bookViewDetail",rightIcon:"mui mui-forward",clickable:true,noArrow:true,moveTo:"distributeRecordView",transitionDir:1,transition:"slide"'>分发记录</div>
							</div>
							<div class="detailInfo">
								<div data-dojo-type="dojox/mobile/ListItem" class="baseInfoNav"
									 data-dojo-props='icon:"mui mui-bookViewDetail",rightIcon:"mui mui-forward",clickable:true,noArrow:true,moveTo:"reportRecordView",transitionDir:1,transition:"slide"'>上报记录</div>
							</div>
							<kmss:auth requestURL="/km/imissive/km_imissive_receive_main/kmImissiveReceiveMain.do?method=readViewLog&fdId=${param.fdId}" requestMethod="GET">
								<div class="detailInfo">
									<div data-dojo-type="dojox/mobile/ListItem" class="baseInfoNav"
										 data-dojo-props='icon:"mui mui-flowRecord",rightIcon:"mui mui-forward",clickable:true,noArrow:true,moveTo:"workFlowView",transitionDir:1,transition:"slide"'><bean:message  bundle="km-imissive" key="mui.process.records"/></div>
								</div>
							</kmss:auth>
							<div class="detailInfo">
								<div data-dojo-type="dojox/mobile/ListItem" class="baseInfoNav"
									 data-dojo-props='icon:"mui mui-bookViewDetail",rightIcon:"mui mui-forward",clickable:true,noArrow:true,moveTo:"opinionView",transitionDir:1,transition:"slide"'>传阅意见</div>
							</div>
						</div>
					</c:if>
					<template:include file="/sys/lbpmservice/mobile/import/tarbar.jsp"
									  docStatus="${kmImissiveReceiveMainForm.docStatus}"
									  formName="kmImissiveReceiveMainForm"
									  viewName="lbpmView"
									  allowReview="true">
						<template:replace name="flowArea">
							<c:choose>
								<c:when test="${kmImissiveReceiveMainForm.docStatus < '20' && kmImissiveReceiveMainForm.docStatus >= '10'}">
									<c:if test="${ kmImissiveReceiveMainForm.sysWfBusinessForm.fdIsHander == 'true'}">
										<%--起草人草稿编辑操作 --%>
										<kmss:auth requestURL="/km/imissive/km_imissive_receive_main/kmImissiveReceiveMain.do?method=edit&fdId=${param.fdId }">
											<div data-dojo-type="mui/tabbar/TabBarButton"
												 data-dojo-props="colSize:1,href:'/km/imissive/km_imissive_receive_main/kmImissiveReceiveMain.do?method=edit&fdId=${param.fdId }'">
												<bean:message key="button.edit"/>
											</div>
										</kmss:auth>
									</c:if>
								</c:when>
							</c:choose>
							<c:if test="${kmImissiveReceiveMainForm.docStatus =='20'}">
								<%--分发 --%>
								<c:if test="${kmImissiveReceiveMainForm.sysWfBusinessForm.fdNodeAdditionalInfo.distribute =='true'}">
									<div data-dojo-type="mui/tabbar/TabBarButton" onclick="distribute();">
										<bean:message  bundle="km-imissive" key="kmImissiveSendMain.distribute"/>
									</div>
								</c:if>
								<c:if test="${kmImissiveReceiveMainForm.sysWfBusinessForm.fdNodeAdditionalInfo.yqqSignzq =='true' && yqqFlag=='true'}">
									<c:if test="${not empty kmImissiveReceiveMainForm.attachmentForms['editonline'].attachments or not empty kmImissiveReceiveMainForm.attachmentForms['mainonline'].attachments}">
										<c:if test="${kmImissiveReceiveMainForm.fdNeedContent=='0'}">
											<%-- 集成了易企签、勾选了附件选项 --%>
											<div data-dojo-type="mui/tabbar/TabBarButton" onclick="yqq('mainonline');">
												<bean:message  bundle="km-imissive" key="kmImissive.sign.zhixingqianshu"/>
											</div>
										</c:if>
										<c:if test="${kmImissiveReceiveMainForm.fdNeedContent=='1'}">
											<%-- 集成了易企签、勾选了附件选项 --%>
											<div data-dojo-type="mui/tabbar/TabBarButton" onclick="yqq('editonline');">
												<bean:message  bundle="km-imissive" key="kmImissive.sign.zhixingqianshu"/>
											</div>
										</c:if>
									</c:if>
								</c:if>
								<%--上报 --%>
								<c:if test="${kmImissiveReceiveMainForm.sysWfBusinessForm.fdNodeAdditionalInfo.report =='true'}">
									<div data-dojo-type="mui/tabbar/TabBarButton" onclick="report();">
										<bean:message  bundle="km-imissive" key="kmImissiveSendMain.report"/>
									</div>
								</c:if>
								<c:if test="${existOpinion}">
									<div data-dojo-type="mui/tabbar/TabBarButton" onclick="circulate();">
										传阅意见
									</div>
								</c:if>
							</c:if>
							<c:import url="/sys/bookmark/mobile/import/view.jsp" charEncoding="UTF-8">
								<c:param name="fdModelName" value="com.landray.kmss.km.imissive.model.KmImissiveReceiveMain"></c:param>
								<c:param name="fdModelId" value="${kmImissiveReceiveMainForm.fdId}"></c:param>
								<c:param name="fdSubject" value="${kmImissiveReceiveMainForm.docSubject}"></c:param>
								<c:param name="showOption" value="label"></c:param>
							</c:import>
							<c:import url="/sys/relation/mobile/import/view.jsp" charEncoding="UTF-8">
								<c:param name="formName" value="kmImissiveReceiveMainForm"></c:param>
								<c:param name="showOption" value="label"></c:param>
							</c:import>
							<c:import url="/km/imissive/mobile/circulation/view.jsp" charEncoding="UTF-8">
								<c:param name="formName" value="kmImissiveReceiveMainForm"></c:param>
								<c:param name="showOption" value="label"></c:param>
								<c:param name="isNew" value="true"></c:param>
							</c:import>
						</template:replace>
						<template:replace name="publishArea">
							<c:if test="${kmImissiveReceiveMainForm.docStatus=='30' and kmImissiveReceiveMainForm.fdIsFiling!= true}">
								<kmss:auth requestURL="/km/imissive/km_imissive_receive_main/kmImissiveReceiveMain.do?method=distribute&fdId=${param.fdId}" requestMethod="GET">
									<div data-dojo-type="mui/tabbar/TabBarButton" onclick="distribute();">
										<bean:message  bundle="km-imissive" key="kmImissiveSendMain.distribute"/>
									</div>
								</kmss:auth>
								<c:if test="${kmImissiveReceiveMainForm.sysWfBusinessForm.fdNodeAdditionalInfo.yqqSignzq =='true' && yqqFlag=='true'}">
									<c:if test="${not empty kmImissiveReceiveMainForm.attachmentForms['editonline'].attachments or not empty kmImissiveReceiveMainForm.attachmentForms['mainonline'].attachments}">
										<c:if test="${kmImissiveReceiveMainForm.fdNeedContent=='0'}">
											<%-- 集成了易企签、勾选了附件选项 --%>
											<div data-dojo-type="mui/tabbar/TabBarButton" onclick="yqq('mainonline');">
												<bean:message  bundle="km-imissive" key="kmImissive.sign.zhixingqianshu"/>
											</div>
										</c:if>
										<c:if test="${kmImissiveReceiveMainForm.fdNeedContent=='1'}">
											<%-- 集成了易企签、勾选了附件选项 --%>
											<div data-dojo-type="mui/tabbar/TabBarButton" onclick="yqq('editonline');">
												<bean:message  bundle="km-imissive" key="kmImissive.sign.zhixingqianshu"/>
											</div>
										</c:if>
									</c:if>
								</c:if>
								<kmss:auth requestURL="/km/imissive/km_imissive_receive_main/kmImissiveReceiveMain.do?method=report&fdId=${param.fdId}" requestMethod="GET">
									<div data-dojo-type="mui/tabbar/TabBarButton" onclick="report();">
										<bean:message  bundle="km-imissive" key="kmImissiveSendMain.report"/>
									</div>
								</kmss:auth>
							</c:if>
							<c:if test="${existOpinion}">
								<div data-dojo-type="mui/tabbar/TabBarButton" onclick="circulate();">
									传阅意见
								</div>
							</c:if>
							<c:import url="/sys/bookmark/mobile/import/view.jsp" charEncoding="UTF-8">
								<c:param name="fdModelName" value="com.landray.kmss.km.imissive.model.KmImissiveReceiveMain"></c:param>
								<c:param name="fdModelId" value="${kmImissiveReceiveMainForm.fdId}"></c:param>
								<c:param name="fdSubject" value="${kmImissiveReceiveMainForm.docSubject}"></c:param>
								<c:param name="showOption" value="label"></c:param>
							</c:import>
							<c:import url="/sys/relation/mobile/import/view.jsp" charEncoding="UTF-8">
								<c:param name="formName" value="kmImissiveReceiveMainForm"></c:param>
								<c:param name="showOption" value="label"></c:param>
							</c:import>
							<c:import url="/km/imissive/mobile/circulation/view.jsp" charEncoding="UTF-8">
								<c:param name="formName" value="kmImissiveReceiveMainForm"></c:param>
								<c:param name="showOption" value="label"></c:param>
								<c:param name="isNew" value="true"></c:param>
							</c:import>
						</template:replace>
					</template:include>
				</div>
				<c:if  test="${kmImissiveReceiveMainForm.sysWfBusinessForm.fdNodeAdditionalInfo.modifyDocNum =='true' and (_isWpsCloudEnable eq 'true' or _isWpsCenterEnable eq 'true')}">
					<%@ include file="/km/imissive/mobile/cookieUtil_script.jsp"%>
					<%@ include file="/km/imissive/mobile/receive/number_include.jsp"%>
				</c:if>
				<!-- 钉钉图标 -->
				<kmss:ifModuleExist path="/third/ding">
					<c:import url="/third/ding/import/ding_view.jsp" charEncoding="UTF-8">
						<c:param name="formName" value="kmImissiveReceiveMainForm" />
					</c:import>
				</kmss:ifModuleExist>
				<kmss:ifModuleExist path="/third/lding">
					<c:import url="/third/lding/import/ding_view.jsp" charEncoding="UTF-8">
						<c:param name="formName" value="kmImissiveReceiveMainForm" />
					</c:import>
				</kmss:ifModuleExist>
				<kmss:ifModuleExist path="/third/govding">
					<c:import url="/third/govding/import/ding_view.jsp" charEncoding="UTF-8">
						<c:param name="formName" value="kmImissiveReceiveMainForm" />
					</c:import>
				</kmss:ifModuleExist>
				<c:import url="/sys/right/mobile/edit_hidden.jsp" charEncoding="UTF-8">
					<c:param name="formName" value="kmImissiveReceiveMainForm" />
					<c:param name="moduleModelName" value="com.landray.kmss.km.imissive.model.KmImissiveReceiveMain" />
				</c:import>
				<!-- 版本锁机制 -->
				<c:import url="/component/locker/import/componentLockerVersion_import.jsp" charEncoding="UTF-8">
					<c:param name="formName" value="kmImissiveReceiveMainForm" />
				</c:import>
				<!-- 钉钉图标 end -->
				<c:import url="/sys/lbpmservice/mobile/import/view.jsp" charEncoding="UTF-8">
					<c:param name="formName" value="kmImissiveReceiveMainForm" />
					<c:param name="fdKey" value="receiveMainDoc" />
					<c:param name="viewName" value="lbpmView" />
					<c:param name="backTo" value="scrollView" />
					<c:param name="onClickSubmitButton" value="Com_submitReview();" />
				</c:import>
				<c:if test="${kmImissiveReceiveMainForm.docStatus eq '30' or kmImissiveReceiveMainForm.docStatus eq '00' }">
					<div id='basicInfoTemp' data-dojo-type="mui/form/Template"  style="display:none">
						<div data-dojo-type="mui/table/ScrollableHContainer" data-dojo-mixins="mui/form/_AlignMixin">
							<div  class="muiFormContent muiAccordionPanelContent" >
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
						<c:if test="${not empty kmImissiveReceiveMainForm.attachmentForms['yqqSigned'].attachments}">
							<c:import url="/sys/attachment/mobile/import/view.jsp" charEncoding="UTF-8">
								<c:param name="formName" value="kmImissiveReceiveMainForm"></c:param>
								<c:param name="fdKey" value="yqqSigned"></c:param>
								<c:param name="fdModelId" value="${param.fdId}" />
								<c:param name="fdModelName" value="com.landray.kmss.km.imissive.model.KmImissiveReceiveMain" />
							</c:import>
						</c:if>
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
					</div>
					<%--流程审批记录 --%>
					<kmss:auth requestURL="/km/imissive/km_imissive_receive_main/kmImissiveReceiveMain.do?method=readViewLog&fdId=${param.fdId}" requestMethod="GET">
						<div id='workFlowView' data-dojo-type="dojox/mobile/View">
							<div class="muiHeaderBasicInfo" data-dojo-type="mui/header/Header" fixed="top" data-dojo-props="height:'3.8rem'">
								<div class="muiHeaderBasicInfoTitle"><bean:message  bundle="km-imissive" key="mui.process.records"/></div>
								<div class="muiHeaderBasicInfoBack" onclick="backToDocView(this,'scrollView')">
									<i class="mui mui-close"></i>
								</div>
							</div>
							<div data-dojo-type="mui/view/DocScrollableView">
								<div data-dojo-type="mui/table/ScrollableHContainer">
									<div data-dojo-type="mui/table/ScrollableHView" class="muiFormContent">
										<div data-dojo-type="mui/panel/Content" data-dojo-props="title:'',icon:'mui-ul'">
											<c:import url="/sys/lbpmservice/mobile/lbpm_audit_note/import/view.jsp" charEncoding="UTF-8">
												<c:param name="fdModelId" value="${kmImissiveReceiveMainForm.fdId }"/>
												<c:param name="fdModelName" value="com.landray.kmss.km.imissive.model.KmImissiveReceiveMain"/>
												<c:param name="formBeanName" value="kmImissiveReceiveMainForm"/>
											</c:import>
										</div>
									</div>
								</div>
							</div>
						</div>
					</kmss:auth>
				</c:if>
				<%@ include file="/km/imissive/mobile/receive/view_import.jsp"%>
				<script>
					require(["mui/form/ajax-form!kmImissiveReceiveMainForm"]);
				</script>
				<script type="text/javascript">
					require(["dojo/ready","dojo/dom-style","dojo/dom","mui/dialog/Tip"], function(ready,domStyle,dom,Tip) {
						<c:if test="${kmImissiveReceiveMainForm.sysWfBusinessForm.fdNodeAdditionalInfo.yqqSignzq =='true' && yqqFlag=='true'}">
						Com_Parameter.event["submit"].push(function(){
							//操作类型为通过类型 ，才判断是否已经签署
							var canStartProcess = document.getElementById("sysWfBusinessForm.canStartProcess");
							if($(canStartProcess).val() == "true" &&  lbpm.globals.getCurrentOperation().operation && lbpm.globals.getCurrentOperation().operation['isPassType'] == true){
								var flag = true;
								var url = Com_Parameter.ContextPath+"km/imissive/km_imissive_out_sign/kmImissiveOutSign.do?method=queryFinish&signId=${param.fdId}";
								$.ajax({
									url : url,
									type : 'post',
									data : {},
									dataType : 'text',
									async : false,
									error : function(){
										Tip.tip({icon:'mui mui-warn', text:'请求出错',width:'180',height:'60'});
										flag = false;
									} ,
									success:function(data){
										if(data == "true"){
											flag = true;
										}else{
											Tip.tip({icon:'mui mui-warn', text:'当前签署任务未完成，无法提交！！',width:'240',height:'120'});
											flag = false;
										}
									}
								});
								return flag;
							}else{
								return true;
							}
						});
						</c:if>
					});
				</script>
			</html:form>
		</xform:config>
	</template:replace>
</template:include>

<script type="text/javascript">
	require(["dojo/parser",
		"dojo/dom",
		"dojo/dom-construct",
		"dijit/registry",
		"dojo/topic",
		'dojo/query',
		"mui/rtf/RtfResize",
		"dojo/_base/lang",
		"mui/dialog/Dialog"], function(parser, dom, domConstruct, registry, topic, query,Rtf, lang, Dialog){
		//var dialog;
		window.viewDetailInfo=function(){
			//if(!dialog){
			query('.imissiveBaseInfo').remove();
			var contentNode = registry.byId("basicInfoTemp");
			var appendTo = document.getElementById("scrollView");
			var dialog = new Dialog.claz({
				'title':'<bean:message  bundle="km-imissive" key="kmImissiveReceiveMain.baseinfo"/>',
				'element' : contentNode.domNode.innerHTML,
				'appendTo':appendTo,
				'destroyAfterClose':true,
				'closeOnClickDomNode':true,
				'parseable': true,
				'canClose':true,
				'showClass':'muiDialogElementShow imissiveBaseInfo',
				'transform':'bottom',
				'position':'bottom',
				'buttons' : []
			});
			dialog.show();
			// contentNode.destroy();
			//}else{
			//dialog.show();
			//}
		};
	});
</script>
