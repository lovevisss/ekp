<%@ page language="java" contentType="text/html; charset=UTF-8" 	pageEncoding="UTF-8"%>
<%@ include file="/sys/ui/jsp/common.jsp"%>
<%@page import="com.landray.kmss.sys.attachment.integrate.wps.util.SysAttWpsCloudUtil"%>
<%@page import="com.landray.kmss.sys.attachment.integrate.wps.util.SysAttWpsCenterUtil"%>
<%@ page import="com.landray.kmss.km.imissive.util.ImissiveUtil" %>
<%@ page import="com.landray.kmss.sys.webservice2.util.SysWsUtil" %>
<%@ page import="com.landray.kmss.sys.attachment.util.JgWebOffice" %>
<%@ page import="com.landray.kmss.km.imissive.util.KmImissiveConfigUtil" %>
<c:set var="xinChuangWps" value="<%=ImissiveUtil.isWPSOAassistEmbed(request)%>"/>
<%
	pageContext.setAttribute("_isWpsCloudEnable", new Boolean(ImissiveUtil.isEnableWpsCloud()));
	pageContext.setAttribute("_isWpsCenterEnable", new Boolean(SysAttWpsCenterUtil.isEnable()));
%>
<template:replace name="content">

	<c:choose>
		<c:when test="${not empty kmImissiveSignMainForm.attachmentForms['yqqSigned'].attachments }">
			<c:set var="fdSignKey" value="yqqSigned" />
		</c:when>
		<c:when test="${not empty kmImissiveSignMainForm.attachmentForms['eqbSign'].attachments }">
			<c:set var="fdSignKey" value="eqbSign" />
		</c:when>
		<c:when test="${not empty kmImissiveSignMainForm.attachmentForms['ofdEqbSign'].attachments }">
			<c:set var="fdSignKey" value="ofdEqbSign" />
		</c:when>
		<c:otherwise>
			<c:set var="fdSignKey" value="" />
		</c:otherwise>
	</c:choose>

	<%-- 压缩JS --%>
	<jsp:include page="/km/imissive/compressJs/compressJs_tabContent.jsp">
		<jsp:param name="fdType" value="sign"/>
	</jsp:include>
	<link rel="Stylesheet" href="${LUI_ContextPath}/km/imissive/resource/css/att.css?s_cache=${MUI_Cache}" />
	<%-- 网页签章(首先判断是否启用了网页签章) --%>
   	<c:if test="${JGSignatureHTMLEnabled == 'true'}">
		<%
			String projectServerURL = SysWsUtil.getUrlPrefix(request);
			String mServerUrl=projectServerURL+"/km/imissive/iSignatureHTML/Service.jsp";
		  	request.setAttribute("jgHtmlSigVersion", JgWebOffice.getJGVersion("signaturehtml"));
		  	request.setAttribute("jgHtmlSigUrl",projectServerURL + JgWebOffice.getJGDownLoadUrl("signaturehtml"));
		%>
    	<span id="processNodeId" style="display: none;"><kmss:showWfPropertyValues idValue="${kmImissiveSignMainForm.fdId}" propertyName="handerNameDetail" /></span>
    	<input type="hidden" name="DOCUMENTID" value="${kmImissiveSignMainForm.fdId }">
    	<OBJECT id="SignatureControl"   classid="clsid:D85C89BE-263C-472D-9B6B-5264CD85B36E"  codebase="${jgHtmlSigUrl }#version=${jgHtmlSigVersion }" width=0 height=0>
			<param name="ServiceUrl" value="<%=mServerUrl%>"><!--读去数据库相关信息-->
			<param name="PrintControlType" value=2>               <!--打印控制方式（0:不控制  1：签章服务器控制  2：开发商控制）-->
		</OBJECT>
	</c:if>
	<ui:tabpanel id="tabpanelDiv" layout="sys.ui.tabpanel.view" var-count="4" var-average = 'false'>
       		<ui:content id="kmImissiveSignMain_baseinfo" titleicon="lui-tab-icon tab-icon-02" title="${ lfn:message('km-imissive:kmImissiveReceiveMain.baseinfo') }" expand="${expandBaseInfo}">
				<jsp:include page="/km/imissive/km_imissive_sign_main/kmImissiveSignMain_baseInfo.jsp"/>
				<c:if test="${empty loadAtt and 'true' eq existAtt}">
					<jsp:include page="/km/imissive/km_imissive_sign_main/kmImissiveSignMain_attachment.jsp"></jsp:include>
				</c:if>
				<div class="lui_form_content_frame" style="padding-top:10px">
				<!-- 以下代码为嵌入流程模板标签的代码 -->
				<kmss:auth requestURL="/km/imissive/km_imissive_sign_main/kmImissiveSignMain.do?method=readViewLog&fdId=${param.fdId}" requestMethod="GET">
				<table class="flowOptTb">
					<c:import url="/km/imissive/import/sysLbpmProcess_view.jsp" charEncoding="UTF-8">
						<c:param name="formName" value="kmImissiveSignMainForm" />
						<c:param name="fdKey" value="signMainDoc" />
						<c:param name="showHistoryOpers" value="true" />
						<c:param name="isSimpleWorkflow" value="true" />
						<c:param name="onClickSubmitButton" value="Com_submitReview();" />
					</c:import>
				</table>
				</kmss:auth>
				</div>
		   </ui:content>
		 <c:import url="/km/imissive/km_imissive_sign_main/kmImissiveSignMain_import.jsp" charEncoding="UTF-8">
			<c:param name="formName" value="kmImissiveSignMainForm" />
		</c:import>
		<ui:event event="indexChanged" args="data" >
			$('.lui_tabpanel_view_content_c').animate({
		        scrollTop: 0
		    }, 1);
		</ui:event>
	</ui:tabpanel>
<%@include file="/km/imissive/km_imissive_sign_main/kmImissiveSignMain_viewScript.jsp"%>
<script>
$(document).ready(function(){
	var contentH = $('.content').height();
	var IFrameContenth = contentH-155;
	 if("${_isWpsCloudEnable}" == 'true' || "${_isWpsCenterEnable}" == 'true'){
		 IFrameContenth = contentH-70;
	 }

	if($('#IFrame_Content')){
		$('#IFrame_Content').height(IFrameContenth+"px");
	}

	if($('#attachment_content')){
		$('#attachment_content').height( (contentH)+"px");
	}

	var obj = document.getElementById("JGWebOffice_editonline");
	if(obj){
		obj.setAttribute("height",(contentH-120)+"px");
	}

	if($(".com_approval_bar2")){
		$(".com_approval_bar2").bind('click', function(event) {
			LUI('tabpanelDiv').setSelectedIndex(0);
			$('.lui_tabpanel_view_content_c').animate({
		        scrollTop:$("#descriptionRow").position().top
		    }, 800);
		});
	}
});
</script>
</template:replace>
<template:replace name="barRight">
	<%@ include file="/km/imissive/import/kmImissiveAttPreview.jsp" %>
	<%if("tab".equals(KmImissiveConfigUtil.getDisplayMode())){ %>
	<c:set var="showRightBar" value="false"></c:set>
	<c:set var="showRelation" value="fale"></c:set>
	<c:if test="${not empty kmImissiveSignMainForm.sysRelationMainForm.sysRelationEntryFormList}">
		<c:set var="showRightBar" value="true"></c:set>
		<c:set var="showRelation" value="true"></c:set>
		<c:if test="${fn:length(kmImissiveSignMainForm.sysRelationMainForm.sysRelationEntryFormList) == 1 and kmImissiveSignMainForm.sysRelationMainForm.sysRelationEntryFormList[0].fdIsTemplate eq 'true'}">
			<c:set var="showRightBar" value="false"></c:set>
			<c:set var="showRelation" value="false"></c:set>
		</c:if>
	</c:if>
	<c:if test="${not empty kmImissiveSignMainForm.attachmentForms['attachment'].attachments or not empty kmImissiveSignMainForm.attachmentForms['editonline'].attachments}">
		<c:set var="showRightBar" value="true"></c:set>
	</c:if>
	<c:if test="${existOpinion}">
	 	<c:set var="showRightBar" value="true"></c:set>
	 </c:if>
	<c:choose>
		<c:when test="${showRightBar eq true }">
			 <ui:tabpanel id="barRightPanel" layout="sys.ui.tabpanel.view">
			  <c:if test="${kmImissiveSignMainForm.fdNeedContent=='1'}">
				  <ui:content  title="${lfn:message('km-imissive:kmImissiveSignMain.docContent')}" id="attContent">
			 			<div id="attachment_content">
							 <div class="missive_content">
								<%@ include file="/km/imissive/km_imissive_sign_main/kmImissiveSignMain_content.jsp"%>
							 </div>
							 <div id="content_preview" style="display: none">
								<div class="content_preview_close" style="text-align: right;">
									<img title="${lfn:message('button.close') }" src="${LUI_ContextPath }/resource/style/common/ftsearch/del.png" style="cursor: pointer;"
										onclick="Frame_CloseWindow('online')">
								</div>
								<iframe width="100%" height="100%" frameborder="0" scrolling="auto" id="readFrame"></iframe>
							</div>
						</div>
				  </ui:content>
			 </c:if>
			 <c:if test="${existOpinion}">
					<ui:content  title="传阅意见"  id="circulation">
						<ui:iframe src="${KMSS_Parameter_ContextPath}sys/circulation/sys_circulation_opinion/sysCirculationOpinion.do?method=edit&fdModelId=${kmImissiveSignMainForm.fdId}&fdModelName=com.landray.kmss.km.imissive.model.KmImissiveSignMain">
						</ui:iframe>
					</ui:content>
				</c:if>
			  <c:if test="${not empty kmImissiveSignMainForm.attachmentForms['attachment'].attachments or not empty fdSignKey}">
				   <ui:content   title="${ lfn:message('sys-doc:sysDocBaseInfo.docAttachments') }">
						<div class="attContent"  style="margin-top: 10px">
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
									<c:import url="/sys/attachment/sys_att_main/sysAttMain_view.jsp" charEncoding="UTF-8">
										<c:param name="formBeanName" value="kmImissiveSignMainForm" />
										<c:param name="fdKey" value="attachment" />
										<c:param name="fdModelName" value="com.landray.kmss.km.imissive.model.KmImissiveSignMain" />
									</c:import>
								</c:otherwise>
							</c:choose>
							<c:if test="${not empty fdSignKey}">
								<div class="lui_form_content_frame" style="padding-top:10px">
									<div class="lui_form_spacing"></div> 
									<div>
										<div class="lui_form_subhead"><img src="${KMSS_Parameter_ContextPath}sys/attachment/view/img/attachment.png"> ${ lfn:message('km-imissive:kmImissive.yqq.signed') }</div>
											<c:import url="/sys/attachment/sys_att_main/sysAttMain_view.jsp"  charEncoding="UTF-8">
												<c:param name="formBeanName" value="kmImissiveSignMainForm" />
												<c:param name="fdKey" value="${fdSignKey}" />
												<c:param name="fdModelName" value="com.landray.kmss.km.imissive.model.KmImissiveSignMain" />
											</c:import>
									</div>
						  		</div>
							</c:if>
						</div>
						<div id="attachment_preview"  style="display: none">
							<div class="attachment_preview_close" style="text-align: right;">
								<img title="${lfn:message('button.close') }" src="${LUI_ContextPath }/resource/style/common/ftsearch/del.png" style="cursor: pointer;"
									onclick="Frame_CloseWindow('attachment')">
							</div>
							<iframe width="100%" height="100%" frameborder="0" scrolling="auto" id="readFrame"></iframe>
						</div>
				  </ui:content>
			  </c:if>
			  <c:if test="${showRelation eq 'true' }">
				  <c:import url="/km/imissive/import/sysRelationMain_view.jsp" charEncoding="UTF-8">
					<c:param name="layout" value="sys.ui.accordionpanel.simpletitle"/>
					<c:param name="formName" value="kmImissiveSignMainForm" />
				</c:import>
			 </c:if>
			 <input type="hidden" id="wpsFlag" value="false">
			 <ui:event event="indexChanged" args="data" >
			  	    var panel = data.panel;
			  	    var selectedContent = panel.contents[data.index.after];
			  	    if(LUI("barRightPanel")){
				  	    if(selectedContent.id == "attContent"){
				  	   		 $(LUI("barRightPanel").element).find('[data-lui-mark="panel.contents"]').css('overflow','hidden');
							 $("object[id*='surread']").each(function(i,_obj){
								 _obj.value = "1";
							 });
							 if('${xinChuangWps}' == 'true'){
								 var fdNeedContent = '${kmImissiveSignMainForm.fdNeedContent =='1'}';
								 var contentKey = ''
								 if('true' == fdNeedContent){
									 contentKey = 'editonline';
								 }
								 showWpsXinChuang(contentKey);
								 $('#wpsFlag').val('true');
							 }
				  	    }else{
				  	  		 $(LUI("barRightPanel").element).find('[data-lui-mark="panel.contents"]').css('overflow','auto');
							 var wpsFlag = $('#wpsFlag').val();
							 if('${xinChuangWps}' == 'true' && wpsFlag =='true'){
								 $('#wpsFlag').val('false');
								 var fdNeedContent = '${kmImissiveSignMainForm.fdNeedContent =='1'}';
								 var contentKey = ''
								 if('true' == fdNeedContent){
									 contentKey = 'editonline';
								 }
								 var wpsObject;
								 if (contentKey == 'editonline' && wps_linux_editonline){
									 wpsObject = wps_linux_editonline;
								 }
								 if(wpsObject){
									 wpsObject.setTmpFileByAttKey();
									 wpsObject.isCurrent=false;
								 }
							 }
				  	    }
			  	    }
			</ui:event>
			</ui:tabpanel>
		</c:when>
		<c:otherwise>
			<script type="text/javascript">
			$(document).ready(function(){
				setTimeout(function(){
					$('.contentArea').hide();
					$('.jg_tip_container').hide();
					if($('.bar-right') && $('.content')){
						$('.bar-right').css('width','0px');
						$('.content').css('margin-right','0px');
						$('.slide-btn-container').hide();
					}
				},100);
			});
			</script>
		</c:otherwise>
	</c:choose>
	<%} %>
</template:replace>
