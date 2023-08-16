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
		<link rel="Stylesheet" href="${LUI_ContextPath}/km/imissive/mobile/resource/css/imissive.css?s_cache=${MUI_Cache}" />
	</template:replace>
	<template:replace name="title">
		<c:out value="${kmImissiveSignMainForm.docSubject}"></c:out>
	</template:replace>
	<template:replace name="content">
	<xform:config  orient="vertical">
		<html:form action="/km/imissive/km_imissive_sign_main/kmImissiveSignMain.do">	
		<div id="scrollView" class="gray" data-dojo-type="mui/view/DocScrollableView" data-dojo-mixins="mui/form/_ValidateMixin">
			<div class="muiViewBanner">
				<c:set var="attForms" value="${kmImissiveSignMainForm.attachmentForms['editonline']}" />
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
							<c:when test="${kmImissiveSignMainForm.docStatus=='00'}">
								<c:set var="statusBg" value="muiSmissiveDiscard"/>
								<c:set var="statusText" value="${ lfn:message('status.discard')}"/>
							</c:when>
							<c:when test="${kmImissiveSignMainForm.docStatus=='10'}">
								<c:set var="statusBg" value="muiSmissiveDraft"/>
								<c:set var="statusText" value="${ lfn:message('status.draft')}"/>
							</c:when>
							<c:when test="${kmImissiveSignMainForm.docStatus=='11'}">
								<c:set var="statusBg" value="muiSmissiveRefuse"/>
								<c:set var="statusText" value="${ lfn:message('km-imissive:kmImissive.status.refuse')}"/>
							</c:when>
							<c:when test="${kmImissiveSignMainForm.docStatus=='20'}">
								<c:set var="statusBg" value="muiSmissiveExamine"/>
								<c:set var="statusText" value="${ lfn:message('status.examine')}"/>
							</c:when>
							<c:when test="${kmImissiveSignMainForm.docStatus=='30'}">
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
							<span><bean:message  bundle="km-imissive" key="kmImissiveSignMain.fdSigntoDept"/>：<c:out value="${kmImissiveSignMainForm.fdDraftDeptName}" /></span>
						</li>
						<li>
							<span><bean:message  bundle="km-imissive" key="kmImissiveSignMain.fdDocNum"/>：<c:out value="${kmImissiveSignMainForm.fdDocNum}" /></span>
						</li>
					</ul>
				</div>
			</div>
			<div data-dojo-type="mui/panel/AccordionPanel" class="flatContentView">
				<%--签署附件key--%>
				<c:set var="fdYqqKeyPdf" value="yqqSigned" />
				<c:set var="fdEqbKeyPdf" value="eqbSign" />
				<c:set var="fdEqbKeyOfd" value="ofdEqbSign" />
				<c:set var="fdCyKeyOfd" value="ofdCySign" />
				<c:set var="fdSsKeyOfd" value="ofdSursenSign" />
				<c:set var="fdConvertPdf" value="convert_toPDF" />
				<c:set var="fdConvertOfd" value="convert_toOFD" />
				<c:choose>
					<c:when  test="${not empty kmImissiveSignMainForm.attachmentForms[fdYqqKeyPdf].attachments}">
						<c:set var="signedKey" value="yqqSigned" scope="request"/>
					</c:when>
					<c:when test="${not empty kmImissiveSignMainForm.attachmentForms[fdEqbKeyPdf].attachments}">
						<c:set var="signedKey" value="eqbSign" scope="request"/>
					</c:when>
					<c:when test="${not empty kmImissiveSignMainForm.attachmentForms[fdEqbKeyOfd].attachments}">
						<c:set var="signedKey" value="ofdEqbSign" scope="request"/>
					</c:when>
					<c:when test="${not empty kmImissiveSignMainForm.attachmentForms[fdCyKeyOfd].attachments}">
						<c:set var="signedKey" value="ofdCySign" scope="request"/>
					</c:when>
					<c:when test="${not empty kmImissiveSignMainForm.attachmentForms[fdSsKeyOfd].attachments}">
						<c:set var="signedKey" value="ofdSursenSign" scope="request"/>
					</c:when>
					<c:when test="${not empty kmImissiveSignMainForm.attachmentForms[fdConvertPdf].attachments}">
						<c:set var="signedKey" value="convert_toPDF" scope="request"/>
					</c:when>
					<c:when test="${not empty kmImissiveSignMainForm.attachmentForms[fdConvertOfd].attachments}">
						<c:set var="signedKey" value="convert_toOFD" scope="request"/>
					</c:when>
					<c:otherwise>
						<c:set var="signedKey" value="" scope="request"/>
					</c:otherwise>
				</c:choose>
				<c:choose>
		            <c:when test="${not empty kmImissiveSignMainForm.attachmentForms[signedKey].attachments}">
		            	<c:import url="/km/imissive/mobile/import/viewContent.jsp" charEncoding="UTF-8">
							<c:param name="fdKey" value="${signedKey}" />
							<c:param name="fdModelId" value="${kmImissiveSignMainForm.fdId}" />
							<c:param name="fdModelName" value="com.landray.kmss.km.imissive.model.KmImissiveSignMain" />
							<c:param name="formBeanName" value="kmImissiveSignMainForm" />
						</c:import>
		            </c:when>
		            <c:otherwise>
		            	<c:if test="${kmImissiveSignMainForm.fdNeedContent=='1'}">
							<c:if test="${not empty _sysAttMain.fdId }">
								<%--是否有编辑正文权限--%>
							     <c:set var="editContent" value="false"/>
								 <c:if  test="${kmImissiveSignMainForm.sysWfBusinessForm.fdNodeAdditionalInfo.editDocContent =='true'}">
									<c:set var="editContent" value="true"/>
								 </c:if>
							    <c:import url="/sys/attachment/mobile/import/viewContent.jsp" charEncoding="UTF-8">
									<c:param name="formName" value="kmImissiveSignMainForm"></c:param>
									<c:param name="fdKey" value="editonline"></c:param>
									<c:param  name="contentFlag"  value="true"/>
									<c:param name="editContent" value="${editContent}"></c:param>
								</c:import>
							</c:if>
						</c:if>
		            </c:otherwise>
		        </c:choose>
				<c:set var="existAtt" value="false" scope="request"/>
				<c:if test="${not empty kmImissiveSignMainForm.attachmentForms['attachment'].attachments}">
					<c:set var="existAtt" value="true" scope="request"/>
				</c:if>
				<c:if test="${kmImissiveSignMainForm.docStatus eq '10' or kmImissiveSignMainForm.docStatus eq '11' or kmImissiveSignMainForm.docStatus eq '20'}">
					<div class="revisionInfo_wrapper">
						<div class="detailInfo">
							<div data-dojo-type="dojox/mobile/ListItem" class="baseInfoNav"
								data-dojo-props='icon:"mui mui-bookViewDetail",rightIcon:"mui mui-forward",clickable:true,noArrow:true,moveTo:"opinionView",transitionDir:1,transition:"slide"'>传阅意见</div>
						</div>
					</div>
				</c:if>
				<%--草稿，驳回和审批的文档稿纸和流程默认展开 --%>
				<c:if test="${kmImissiveSignMainForm.docStatus eq '10' or kmImissiveSignMainForm.docStatus eq '11' or kmImissiveSignMainForm.docStatus eq '20'}">
					<div data-dojo-type="mui/panel/Content"   data-dojo-props="title:'<bean:message  bundle="km-imissive" key="kmImissiveSignMain.baseinfo"/>',icon:'mui-ul'">
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
							</div>
						</div>
					</div>
					<c:if test="${not empty kmImissiveSignMainForm.attachmentForms[signedKey].attachments}">
						<c:import url="/sys/attachment/mobile/import/view.jsp" charEncoding="UTF-8">
							<c:param name="formName" value="kmImissiveSignMainForm"></c:param>
							<c:param name="fdKey" value="${signedKey}"></c:param>
							<c:param name="fdModelId" value="${param.fdId}" />
							<c:param name="fdModelName" value="com.landray.kmss.km.imissive.model.KmImissiveSignMain" />
						</c:import>
					</c:if>
					<kmss:auth requestURL="/km/imissive/km_imissive_sign_main/kmImissiveSignMain.do?method=readViewLog&fdId=${param.fdId}" requestMethod="GET">
					<div data-dojo-type="mui/panel/Content" data-dojo-props="title:'<bean:message  bundle="km-imissive" key="mui.process.records"/>',icon:'mui-ul'">
						<c:import url="/sys/lbpmservice/mobile/lbpm_audit_note/import/view.jsp" charEncoding="UTF-8">
							<c:param name="fdModelId" value="${kmImissiveSignMainForm.fdId }"/>
							<c:param name="fdModelName" value="com.landray.kmss.km.imissive.model.KmImissiveSignMain"/>
							<c:param name="formBeanName" value="kmImissiveSignMainForm"/>
					   </c:import>
				   </div>
					</kmss:auth>
				</c:if>
			</div>
			<%--发布和废弃的文档稿纸和流程默认折叠 --%>
			<c:if test="${kmImissiveSignMainForm.docStatus eq '30' or kmImissiveSignMainForm.docStatus eq '00' }">
				<div class="detailInfo_wrapper">
					<div class="detailInfo">
						<div data-dojo-type="dojox/mobile/ListItem" class="baseInfoNav"
		 					data-dojo-props='icon:"mui mui-bookViewDetail",rightIcon:"mui mui-forward",clickable:true,noArrow:true,onClick:viewDetailInfo'><bean:message  bundle="km-imissive" key="kmImissiveSignMain.baseinfo.title"/></div>
					</div>
			        <kmss:auth requestURL="/km/imissive/km_imissive_sign_main/kmImissiveSignMain.do?method=readViewLog&fdId=${param.fdId}" requestMethod="GET">
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
				            docStatus="${kmImissiveSignMainForm.docStatus}" 
							formName="kmImissiveSignMainForm"
							viewName="lbpmView"
							allowReview="true">
				<template:replace name="flowArea">
					<c:choose>
						<c:when test="${kmImissiveSignMainForm.docStatus < '20' && kmImissiveSignMainForm.docStatus >= '10'}">
							<c:if test="${ kmImissiveSignMainForm.sysWfBusinessForm.fdIsHander == 'true'}">
								<%--起草人草稿编辑操作 --%>
								<kmss:auth requestURL="/km/imissive/km_imissive_sign_main/kmImissiveSignMain.do?method=edit&fdId=${param.fdId }">
									<div data-dojo-type="mui/tabbar/TabBarButton"
										 data-dojo-props="colSize:1,href:'/km/imissive/km_imissive_sign_main/kmImissiveSignMain.do?method=edit&fdId=${param.fdId }'">
										<bean:message key="button.edit"/>
									</div>
								</kmss:auth>
							</c:if>
						</c:when>
					</c:choose>
					<c:if test="${existOpinion}">
						<div data-dojo-type="mui/tabbar/TabBarButton" onclick="circulate();">
							传阅意见
						</div>
					</c:if>
				   <c:import url="/sys/bookmark/mobile/import/view.jsp" charEncoding="UTF-8">
					  <c:param name="fdModelName" value="com.landray.kmss.km.imissive.model.KmImissiveSignMain"></c:param>
					  <c:param name="fdModelId" value="${kmImissiveSignMainForm.fdId}"></c:param>
					  <c:param name="fdSubject" value="${kmImissiveSignMainForm.docSubject}"></c:param>
				      <c:param name="showOption" value="label"></c:param>
				  </c:import>
				  <c:if test="${kmImissiveSignMainForm.sysWfBusinessForm.fdNodeAdditionalInfo.yqqSignzq =='true' && yqqFlag=='true'}">
						<c:if test="${not empty kmImissiveSignMainForm.attachmentForms['editonline'].attachments or not empty kmImissiveSignMainForm.attachmentForms['mainonline'].attachments}">
					     	 <c:if test="${kmImissiveSignMainForm.fdNeedContent=='0'}">
						     	 <%-- 集成了易企签、勾选了附件选项 --%>
						     	 <div data-dojo-type="mui/tabbar/TabBarButton" onclick="yqq('mainonline');">
						 			<bean:message  bundle="km-imissive" key="kmImissive.sign.zhixingqianshu"/>
						 		</div>
					      	 </c:if>
					      	  <c:if test="${kmImissiveSignMainForm.fdNeedContent=='1'}">
						     	 <%-- 集成了易企签、勾选了附件选项 --%>
						      	 <div data-dojo-type="mui/tabbar/TabBarButton" onclick="yqq('editonline');">
						 			<bean:message  bundle="km-imissive" key="kmImissive.sign.zhixingqianshu"/>
						 		</div>
					      	 </c:if>
				      	 </c:if>
				  </c:if>
				  <c:import url="/sys/relation/mobile/import/view.jsp" charEncoding="UTF-8">
						<c:param name="formName" value="kmImissiveSignMainForm"></c:param>
						<c:param name="showOption" value="label"></c:param>
				  </c:import>
				   <c:import url="/km/imissive/mobile/circulation/view.jsp" charEncoding="UTF-8">
					    <c:param name="formName" value="kmImissiveSignMainForm"></c:param>
					    <c:param name="showOption" value="label"></c:param>
					    <c:param name="isNew" value="true"></c:param>
				    </c:import>
				</template:replace>
				<template:replace name="publishArea">
					<c:if test="${existOpinion}">
						<div data-dojo-type="mui/tabbar/TabBarButton" onclick="circulate();">
							传阅意见
						</div>
					</c:if>
				  <c:import url="/sys/bookmark/mobile/import/view.jsp" charEncoding="UTF-8">
					  <c:param name="fdModelName" value="com.landray.kmss.km.imissive.model.KmImissiveSignMain"></c:param>
					  <c:param name="fdModelId" value="${kmImissiveSignMainForm.fdId}"></c:param>
					  <c:param name="fdSubject" value="${kmImissiveSignMainForm.docSubject}"></c:param>
				      <c:param name="showOption" value="label"></c:param>
				  </c:import>
				  <c:if test="${kmImissiveSignMainForm.sysWfBusinessForm.fdNodeAdditionalInfo.yqqSignzq =='true' && yqqFlag=='true'}">
						<c:if test="${not empty kmImissiveSignMainForm.attachmentForms['editonline'].attachments or not empty kmImissiveSignMainForm.attachmentForms['mainonline'].attachments}">
					     	 <c:if test="${kmImissiveSignMainForm.fdNeedContent=='0'}">
						     	 <%-- 集成了易企签、勾选了附件选项 --%>
						     	 <div data-dojo-type="mui/tabbar/TabBarButton" onclick="yqq('mainonline');">
						 			<bean:message  bundle="km-imissive" key="kmImissive.sign.zhixingqianshu"/>
						 		</div>
					      	 </c:if>
					      	  <c:if test="${kmImissiveSignMainForm.fdNeedContent=='1'}">
						     	 <%-- 集成了易企签、勾选了附件选项 --%>
						      	 <div data-dojo-type="mui/tabbar/TabBarButton" onclick="yqq('editonline');">
						 			<bean:message  bundle="km-imissive" key="kmImissive.sign.zhixingqianshu"/>
						 		</div>
					      	 </c:if>
				      	 </c:if>
				  </c:if>
				  <c:import url="/sys/relation/mobile/import/view.jsp" charEncoding="UTF-8">
						<c:param name="formName" value="kmImissiveSignMainForm"></c:param>
						<c:param name="showOption" value="label"></c:param>
				  </c:import>
				      <c:import url="/km/imissive/mobile/circulation/view.jsp" charEncoding="UTF-8">
					    <c:param name="formName" value="kmImissiveSignMainForm"></c:param>
					    <c:param name="showOption" value="label"></c:param>
					    <c:param name="isNew" value="true"></c:param>
				      </c:import>
				</template:replace>
			</template:include>
		</div>
		<c:if  test="${kmImissiveSignMainForm.sysWfBusinessForm.fdNodeAdditionalInfo.modifyDocNum =='true' and (_isWpsCloudEnable eq 'true' or _isWpsCenterEnable eq 'true')}">
			<%@ include file="/km/imissive/mobile/cookieUtil_script.jsp"%>
			<%@ include file="/km/imissive/mobile/sign/number_include.jsp"%>
		</c:if>
		<c:import url="/sys/right/mobile/edit_hidden.jsp" charEncoding="UTF-8">
			<c:param name="formName" value="kmImissiveSignMainForm" />
			<c:param name="moduleModelName" value="com.landray.kmss.km.imissive.model.KmImissiveSignMain" />
		</c:import>
		<!-- 版本锁机制 -->
		<c:import url="/component/locker/import/componentLockerVersion_import.jsp" charEncoding="UTF-8">
			<c:param name="formName" value="kmImissiveSignMainForm" />
		</c:import>
		<!-- 钉钉图标 -->
		<kmss:ifModuleExist path="/third/ding">
			<c:import url="/third/ding/import/ding_view.jsp" charEncoding="UTF-8">
				<c:param name="formName" value="kmImissiveSignMainForm" />
			</c:import>
		</kmss:ifModuleExist>
		<kmss:ifModuleExist path="/third/lding">
			<c:import url="/third/lding/import/ding_view.jsp" charEncoding="UTF-8">
				<c:param name="formName" value="kmImissiveSignMainForm" />
			</c:import>
		</kmss:ifModuleExist>
		<kmss:ifModuleExist path="/third/govding">
			<c:import url="/third/govding/import/ding_view.jsp" charEncoding="UTF-8">
				<c:param name="formName" value="kmImissiveSignMainForm" />
			</c:import>
		</kmss:ifModuleExist>
		<!-- 钉钉图标 end -->
		<c:import url="/sys/lbpmservice/mobile/import/view.jsp" charEncoding="UTF-8">
			<c:param name="formName" value="kmImissiveSignMainForm" />
			<c:param name="fdKey" value="signMainDoc" />
			<c:param name="viewName" value="lbpmView" />
			<c:param name="backTo" value="scrollView" />
			<c:param name="onClickSubmitButton" value="Com_submitReview();" />
		</c:import>
		<c:if test="${kmImissiveSignMainForm.docStatus eq '30' or kmImissiveSignMainForm.docStatus eq '00' }">
			<%--查看详细稿纸 --%>
			<div id='basicInfoTemp' data-dojo-type="mui/form/Template"  style="display:none">
				<div data-dojo-type="mui/table/ScrollableHContainer" data-dojo-mixins="mui/form/_AlignMixin">
					<div   class="muiFormContent muiAccordionPanelContent" >
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
					</div>	
				</div>
			</div>
			<c:if test="${not empty kmImissiveSignMainForm.attachmentForms[signedKey].attachments}">
				<c:import url="/sys/attachment/mobile/import/view.jsp" charEncoding="UTF-8">
					<c:param name="formName" value="kmImissiveSignMainForm"></c:param>
					<c:param name="fdKey" value="${signedKey}"></c:param>
					<c:param name="fdModelId" value="${param.fdId}" />
					<c:param name="fdModelName" value="com.landray.kmss.km.imissive.model.KmImissiveSignMain" />
				</c:import>
			</c:if>
			<%--流程审批记录 --%>
		      <kmss:auth requestURL="/km/imissive/km_imissive_sign_main/kmImissiveSignMain.do?method=readViewLog&fdId=${param.fdId}" requestMethod="GET">
				<div id='workFlowView' data-dojo-type="dojox/mobile/View">
					<div class="muiHeaderBasicInfo" data-dojo-type="mui/header/Header" fixed="top" data-dojo-props="height:'3.8rem'">
						<div class="muiHeaderBasicInfoTitle"><bean:message  bundle="km-imissive" key="mui.process.records"/></div>
						<div class="muiHeaderBasicInfoBack" onclick="backToDocView(this)">
							<i class="mui mui-close"></i>
						</div>
					</div>
					<div data-dojo-type="mui/view/DocScrollableView">
						<div data-dojo-type="mui/table/ScrollableHContainer">
						  <div data-dojo-type="mui/table/ScrollableHView" class="muiFormContent">
						    <div data-dojo-type="mui/panel/Content" data-dojo-props="title:'',icon:'mui-ul'">
								<c:import url="/sys/lbpmservice/mobile/lbpm_audit_note/import/view.jsp" charEncoding="UTF-8">
									<c:param name="fdModelId" value="${kmImissiveSignMainForm.fdId }"/>
									<c:param name="fdModelName" value="com.landray.kmss.km.imissive.model.KmImissiveSignMain"/>
									<c:param name="formBeanName" value="kmImissiveSignMainForm"/>
								</c:import>
							</div>
						  </div>
						</div>
					</div>
				</div>
			</kmss:auth>
		</c:if>
		<div id='opinionView' data-dojo-type="dojox/mobile/View">
			<div class="muiHeaderBasicInfo" data-dojo-type="mui/header/Header" fixed="top" data-dojo-props="height:'3.8rem'">
				<div class="muiHeaderBasicInfoTitle">传阅意见</div>
				<div class="muiHeaderBasicInfoBack" onclick="backToDocView(this)">
					<i class="mui mui-close"></i>
				</div>
			</div>
			<div data-dojo-type="mui/view/DocScrollableView">
				<ul
			    	data-dojo-type="mui/list/JsonStoreList"
			    	data-dojo-mixins="mui/list/ProcessItemListMixin"
			    	data-dojo-props="url:'/sys/circulation/sys_circulation_opinion/sysCirculationOpinion.do?method=list&fdModelId=${kmImissiveSignMainForm.fdId}&fdModelName=com.landray.kmss.km.imissive.model.KmImissiveSignMain&isOpinion=true',lazy:false">
				</ul>
			</div>
		</div>
		<%@ include file="/km/imissive/mobile/sign/view_import.jsp"%>
		<script>
			require(["mui/form/ajax-form!kmImissiveSignMainForm"]);
		</script>
		<script type="text/javascript">
			require(["dojo/ready","dojo/dom-style","dojo/dom","mui/dialog/Tip"], function(ready,domStyle,dom,Tip) {
				<c:if test="${kmImissiveSignMainForm.sysWfBusinessForm.fdNodeAdditionalInfo.yqqSignzq =='true' && yqqFlag=='true'}">
			    Com_Parameter.event["submit"].push(function(){
			   	//操作类型为通过类型 ，才判断是否已经签署
				var canStartProcess = document.getElementById("sysWfBusinessForm.canStartProcess");
			   	if($(canStartProcess).val() == "true" && lbpm.globals.getCurrentOperation().operation && lbpm.globals.getCurrentOperation().operation['isPassType'] == true){
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
require(["dojo/parser", "dojo/dom", "dojo/dom-construct", "dijit/registry","dojo/topic",'dojo/query',"mui/rtf/RtfResize","dojo/_base/lang","mui/dialog/Dialog"], function(parser, dom, domConstruct, registry, topic,query,Rtf,lang,Dialog){
	//var dialog;
	window.viewDetailInfo=function(){
		//if(!dialog){
			query('.imissiveBaseInfo').remove();
			var contentNode = registry.byId("basicInfoTemp");
			var appendTo = document.getElementById("scrollView");
			var dialog = new Dialog.claz({ 
				'title':'<bean:message  bundle="km-imissive" key="kmImissiveSignMain.baseinfo"/>',
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
			//contentNode.destroy();
		//}else{
		//	dialog.show();
		//}
	};
});
</script>
