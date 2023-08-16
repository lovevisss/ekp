<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/sys/ui/jsp/common.jsp"%>
<%@ page import="com.landray.kmss.km.imissive.util.ImissiveUtil"%>
<%@ page import="com.landray.kmss.sys.webservice2.util.SysWsUtil" %>
<%@ page import="com.landray.kmss.sys.attachment.util.JgWebOffice" %>
<%@ page import="com.landray.kmss.util.ResourceUtil" %>
<%@ page import="com.landray.kmss.km.imissive.util.KmImissiveConfigUtil" %>
<%@page import="com.landray.kmss.sys.attachment.integrate.wps.util.SysAttWpsCloudUtil"%>
<%@page import="com.landray.kmss.sys.attachment.integrate.wps.util.SysAttWpsCenterUtil"%>
<%@ page import="com.landray.kmss.util.StringUtil" %>
<%@ page import="com.landray.kmss.sys.ui.util.PCJsCompressUtil" %>
<%@ page import="java.util.Arrays" %>

<%
	pageContext.setAttribute("_isWpsCloudEnable", new Boolean(ImissiveUtil.isEnableWpsCloud()));
	pageContext.setAttribute("_isWpsCenterEnable", new Boolean(SysAttWpsCenterUtil.isEnable()));
	pageContext.setAttribute("_isPriorityDoc", new Boolean(KmImissiveConfigUtil.isPriorityDoc()));
%>

<c:set var="wpsoaassist" value="<%=ImissiveUtil.isEnable()%>"/>
<c:set var="xinChuangWps" value="<%=ImissiveUtil.isWPSOAassistEmbed(request)%>"/>

<template:replace name="preloadJs">
	<jsp:include page="/km/imissive/compressJs/compressJs_send_preloadJs.jsp" />
</template:replace>


<template:replace name="content">
	<%-- 压缩JS --%>
	<jsp:include page="/km/imissive/compressJs/compressJs_singleTabContent.jsp">
		<jsp:param name="fdType" value="send"/>
	</jsp:include>

	<c:choose>
		<c:when test="${not empty kmImissiveSendMainForm.attachmentForms['yqqSigned'].attachments}">
			<c:set var="fdSignKey" value="yqqSigned" />
		</c:when>
		<c:when test="${not empty kmImissiveSendMainForm.attachmentForms['eqbSign'].attachments}">
			<c:set var="fdSignKey" value="eqbSign" />
		</c:when>
		<c:when test="${not empty kmImissiveSendMainForm.attachmentForms['ofdEqbSign'].attachments}">
			<c:set var="fdSignKey" value="ofdEqbSign" />
		</c:when>
		<c:otherwise>
			<c:set var="fdSignKey" value="" />
		</c:otherwise>
	</c:choose>
<link rel="Stylesheet" href="${LUI_ContextPath}/km/imissive/resource/css/att.css?s_cache=${MUI_Cache}" />
   	<%-- 网页签章(首先判断是否启用了网页签章) --%>
   	<c:if test="${JGSignatureHTMLEnabled == 'true'}">
		<%
			String projectServerURL = SysWsUtil.getUrlPrefix(request);
			String mServerUrl=projectServerURL+"/km/imissive/iSignatureHTML/Service.jsp";
		  	request.setAttribute("jgHtmlSigVersion", JgWebOffice.getJGVersion("signaturehtml"));
		  	String signatureHtmlUrl = ResourceUtil.getKmssConfigString("sys.att.jg.signaturehtmlurl");
		  	if (StringUtil.isNull(signatureHtmlUrl)) {
		  		request.setAttribute("jgHtmlSigUrl",projectServerURL + JgWebOffice.getJGDownLoadUrl("signaturehtml"));
		  	} else {
		  		request.setAttribute("jgHtmlSigUrl",signatureHtmlUrl);
		  	}
		%>
    	<span id="processNodeId" style="display: none;"><kmss:showWfPropertyValues idValue="${kmImissiveSendMainForm.fdId}" propertyName="handerNameDetail" /></span>
    	<input type="hidden" name="DOCUMENTID" value="${kmImissiveSendMainForm.fdId }">
    	<OBJECT id="SignatureControl"   classid="clsid:D85C89BE-263C-472D-9B6B-5264CD85B36E"  codebase="${jgHtmlSigUrl }#version=${jgHtmlSigVersion }" width=0 height=0>
			<param name="ServiceUrl" value="<%=mServerUrl%>"><!--读去数据库相关信息-->
			<param name="PrintControlType" value=2>               <!--打印控制方式（0:不控制  1：签章服务器控制  2：开发商控制）-->
		</OBJECT>	
	</c:if>    	
      <kmss:showWfPropertyValues  var="nodevalue" idValue="${kmImissiveSendMainForm.fdId}" propertyName="nodeName" />
  <ui:tabpanel id="tabpanelDiv" layout="sys.ui.tabpanel.view" var-count="5" var-average = 'false'>
	  <%-- #144713 开启wps中台时，正文为空，则pc端和移动端均需要去掉正文页签 --%>
	  <c:set var="isShowContentTabpanel" value="false" />
	  <c:choose>
		  <c:when test="${_isWpsCenterEnable}">
			  <c:choose>
				  <c:when test="${kmImissiveSendMainForm.fdNeedContent eq '0' and not empty kmImissiveSendMainForm.attachmentForms['mainonline'].attachments}">
					  <c:set var="isShowContentTabpanel" value="true" />
				  </c:when>
				  <c:when test="${kmImissiveSendMainForm.fdNeedContent eq '1' and not empty kmImissiveSendMainForm.attachmentForms['editonline'].attachments}">
					  <c:set var="isShowContentTabpanel" value="true" />
				  </c:when>
			  </c:choose>
		  </c:when>
		  <c:when test="${not empty kmImissiveSendMainForm.attachmentForms['editonline'].attachments or not empty kmImissiveSendMainForm.attachmentForms['mainonline'].attachments}">
			  <c:set var="isShowContentTabpanel" value="true" />
		  </c:when>
	  </c:choose>
	  	<c:if test="${kmImissiveSendMainForm.docStatus == '30'}">
	         <%if("content".equals(KmImissiveConfigUtil.getDiplayOrder())){ %>
	             <c:if test="${isShowContentTabpanel eq 'true'}">
					  <ui:content  title="${ lfn:message('km-imissive:kmImissiveSendMain.docContent') }" id="attContent"  titleicon="lui-tab-icon tab-icon-10">
				 			<div id="attachment_content">
								<div class="missive_content">
								 	<jsp:include page="/km/imissive/km_imissive_send_main/kmImissiveSendMain_content.jsp"></jsp:include>
								 </div>
							</div>			
					  </ui:content>
				  </c:if>
				  <ui:content id="kmImissiveSendMain_baseinfo" titleicon="lui-tab-icon tab-icon-02" title="${ lfn:message('km-imissive:kmImissiveSendMain.baseinfo') }" expand="${expandBaseInfo}">
				  	<c:import url="/km/imissive/km_imissive_send_main/kmImissiveSendMain_baseInfo.jsp" charEncoding="UTF-8">
				  		<c:param name="formName" value="kmImissiveSendMainForm" />
				  	</c:import>

					  <c:if test="${empty loadAtt and 'true' eq existAtt}">
						  <jsp:include page="/km/imissive/km_imissive_send_main/kmImissiveSendMain_attachment.jsp"></jsp:include>
					  </c:if>
					<c:import url="/km/imissive/km_imissive_send_main/kmImissiveSendMain_relateInfo.jsp" charEncoding="UTF-8">
				  		<c:param name="formName" value="kmImissiveSendMainForm" />
				  	</c:import>
				  </ui:content>
			  <%}else{ %>
				 <ui:content id="kmImissiveSendMain_baseinfo" titleicon="lui-tab-icon tab-icon-02" title="${ lfn:message('km-imissive:kmImissiveSendMain.baseinfo') }" expand="${expandBaseInfo}">
				  	<c:import url="/km/imissive/km_imissive_send_main/kmImissiveSendMain_baseInfo.jsp" charEncoding="UTF-8">
				  		<c:param name="formName" value="kmImissiveSendMainForm" />
						</c:import>
						
					 <c:if test="${empty loadAtt and 'true' eq existAtt}">
						 <jsp:include page="/km/imissive/km_imissive_send_main/kmImissiveSendMain_attachment.jsp"></jsp:include>
					 </c:if>
					<c:import url="/km/imissive/km_imissive_send_main/kmImissiveSendMain_relateInfo.jsp" charEncoding="UTF-8">
				  		<c:param name="formName" value="kmImissiveSendMainForm" />
				  	</c:import>
				  </ui:content>
				  <c:if test="${isShowContentTabpanel eq 'true'}">
					  <ui:content  title="${ lfn:message('km-imissive:kmImissiveSendMain.docContent') }" id="attContent"  titleicon="lui-tab-icon tab-icon-10">
				 			<div id="attachment_content">
								<div class="missive_content">
								 	<jsp:include page="/km/imissive/km_imissive_send_main/kmImissiveSendMain_content.jsp"></jsp:include>
								 </div>
							</div>			
					  </ui:content>
				  </c:if>
			  <%} %>
		</c:if> 
	  
	  	<c:if test="${kmImissiveSendMainForm.docStatus != '30'}">
			<%if("content".equals(KmImissiveConfigUtil.getDiplayOrder4Approval())){ %>

	             <c:if test="${isShowContentTabpanel eq 'true'}">
					  <ui:content  title="${ lfn:message('km-imissive:kmImissiveSendMain.docContent') }" id="attContent"  titleicon="lui-tab-icon tab-icon-10">
							<div id="attachment_content">
								<div class="missive_content">
									<jsp:include page="/km/imissive/km_imissive_send_main/kmImissiveSendMain_content.jsp"></jsp:include>
								 </div>
							</div>
					  </ui:content>
				  </c:if>
				  <ui:content id="kmImissiveSendMain_baseinfo" titleicon="lui-tab-icon tab-icon-02" title="${ lfn:message('km-imissive:kmImissiveSendMain.baseinfo') }" expand="${expandBaseInfo}">
				  	<c:import url="/km/imissive/km_imissive_send_main/kmImissiveSendMain_baseInfo.jsp" charEncoding="UTF-8">
				  		<c:param name="formName" value="kmImissiveSendMainForm" />
				  	</c:import>
					  <c:if test="${empty loadAtt and 'true' eq existAtt}">
						   <jsp:include page="/km/imissive/km_imissive_send_main/kmImissiveSendMain_attachment.jsp"></jsp:include>
					  </c:if>
					<c:import url="/km/imissive/km_imissive_send_main/kmImissiveSendMain_relateInfo.jsp" charEncoding="UTF-8">
				  		<c:param name="formName" value="kmImissiveSendMainForm" />
				  	</c:import>
				  </ui:content>
			  <%}else{ %>
				 <ui:content id="kmImissiveSendMain_baseinfo" titleicon="lui-tab-icon tab-icon-02" title="${ lfn:message('km-imissive:kmImissiveSendMain.baseinfo') }" expand="${expandBaseInfo}">
				  	<c:import url="/km/imissive/km_imissive_send_main/kmImissiveSendMain_baseInfo.jsp" charEncoding="UTF-8">
				  		<c:param name="formName" value="kmImissiveSendMainForm" />
				  	</c:import>
					 <c:if test="${empty loadAtt and 'true' eq existAtt}">
						 <jsp:include page="/km/imissive/km_imissive_send_main/kmImissiveSendMain_attachment.jsp"></jsp:include>
					 </c:if>
					<c:import url="/km/imissive/km_imissive_send_main/kmImissiveSendMain_relateInfo.jsp" charEncoding="UTF-8">
				  		<c:param name="formName" value="kmImissiveSendMainForm" />
				  	</c:import>
				  </ui:content>
				  <c:if test="${isShowContentTabpanel eq 'true'}">
					  <ui:content  title="${ lfn:message('km-imissive:kmImissiveSendMain.docContent') }" id="attContent"  titleicon="lui-tab-icon tab-icon-10">
				 			<div id="attachment_content">
								<div class="missive_content">
								 	<jsp:include page="/km/imissive/km_imissive_send_main/kmImissiveSendMain_content.jsp"></jsp:include>
								 </div>
							</div>			
					  </ui:content>
				  </c:if>
			  <%} %>
		</c:if>
	  <c:if test="${not empty kmImissiveSendMainForm.attachmentForms['yqqSigned'].attachments}">
		<div class="lui_form_content_frame" style="padding-top:10px">
		<div class="lui_form_spacing"></div> 
		<div>
			<div class="lui_form_subhead"><img src="${KMSS_Parameter_ContextPath}sys/attachment/view/img/attachment.png"> ${ lfn:message('km-imissive:kmImissive.yqq.signed') }</div>
			<c:import url="/sys/attachment/sys_att_main/sysAttMain_view.jsp"  charEncoding="UTF-8">
				<c:param name="formBeanName" value="kmImissiveSendMainForm" />
				<c:param name="fdKey" value="yqqSigned" />
			</c:import>
		</div>	
	  </div>
	</c:if>
	<c:if test="${not empty kmImissiveSendMainForm.attachmentForms['eqbSign'].attachments}">
		<div class="lui_form_content_frame" style="padding-top:10px">
			<div class="lui_form_spacing"></div>
			<div>
				<div class="lui_form_subhead"><img src="${KMSS_Parameter_ContextPath}sys/attachment/view/img/attachment.png"> ${ lfn:message('km-imissive:kmImissive.yqq.signed') }</div>
				<c:import url="/sys/attachment/sys_att_main/sysAttMain_view.jsp"  charEncoding="UTF-8">
					<c:param name="formBeanName" value="kmImissiveSendMainForm" />
					<c:param name="fdKey" value="eqbSign" />
				</c:import>
			</div>
		</div>
	</c:if>

	  <c:if test="${not empty fdSignKey}">
		<div class="lui_form_content_frame" style="padding-top:10px">
			<div class="lui_form_spacing"></div>
			<div>
				<div class="lui_form_subhead"><img src="${KMSS_Parameter_ContextPath}sys/attachment/view/img/attachment.png"> ${ lfn:message('km-imissive:kmImissive.yqq.signed') }</div>
				<c:import url="/sys/attachment/sys_att_main/sysAttMain_view.jsp"  charEncoding="UTF-8">
					<c:param name="formBeanName" value="kmImissiveSendMainForm" />
				<c:param name="fdKey" value="${fdSignKey}" />
				</c:import>
			</div>
		</div>
	</c:if>
	  <c:if test="${xinChuangWps ne 'true'}">
		  <ui:content  title="${ lfn:message('km-imissive:kmImissiveSendMain.attContent') }" id="attPreview" titleicon="lui-tab-icon tab-icon-05">
			  <div id="attachment_preview">
				  <iframe width="100%" height="100%" frameborder="0" scrolling="auto" id="previewAttFrame" src=""></iframe>
			  </div>
		  </ui:content>
	  </c:if>
	 	<kmss:auth requestURL="/km/imissive/km_imissive_send_main/kmImissiveSendMain.do?method=readViewLog&fdId=${kmImissiveSendMainForm.fdId}" requestMethod="GET">
 	 	<c:if test="${kmImissiveSendMainForm.docStatus != '30'}">
			<c:set var="needInitLbpm" value="false"></c:set>
	 	</c:if>
	 	<c:if test="${kmImissiveSendMainForm.docStatus == '30' || kmImissiveSendMainForm.docStatus == '00'|| kmImissiveSendMainForm.docStatus == '10'}">
	 		<c:set var="needInitLbpm" value="true"></c:set>
	 	</c:if>
 	 	 <c:import url="/sys/workflow/import/sysWfProcess_view.jsp" charEncoding="UTF-8">
			<c:param name="formName" value="kmImissiveSendMainForm" />
			<c:param name="fdKey" value="sendMainDoc" />
			<c:param name="showHistoryOpers" value="true" />
			<c:param name="onClickSubmitButton" value="Com_submitReview();" />
			<c:param name="titleicon" value="lui-tab-icon tab-icon-06" />
			<c:param name="approveType" value="right" />
			<c:param name="needInitLbpm" value="${needInitLbpm}" />
		</c:import>
	</kmss:auth>
	<c:import url="/km/imissive/km_imissive_send_main/kmImissiveSendMain_import.jsp" charEncoding="UTF-8">
		<c:param name="formName" value="kmImissiveSendMainForm" />
	</c:import>
	  <input type="hidden" id="wpsFlag" value="false">
	<ui:event event="indexChanged" args="data" >
	  	    var panel = data.panel;
	  	    var selectedContent = panel.contents[data.index.after];
	  	    if(LUI("barRightPanel")){
		  	    if(selectedContent.id == "attPreview"){
		  	    	var contents = LUI("barRightPanel").contents;
			  	   	for(var i = 0;i< contents.length;i++){
			  	   		if(contents[i].id == "attPreviewList"){
			  	   			LUI("barRightPanel").setSelectedIndex(i);
			  	   		}
			  	   	}
		  	    }else{
		  	    	//LUI("barRightPanel").setSelectedIndex(0);
		  	    }
	  	    }
	  	    if(LUI("tabpanelDiv")){
					if(selectedContent.id == "attContent"){
						var contents = LUI("barRightPanel").contents;
							for(var i = 0;i< contents.length;i++){
								if(contents[i].id == "process_review_tabcontent_right"){
									LUI("barRightPanel").setSelectedIndex(i);
								}
						}
						$("object[id*='surread']").each(function(i,_obj){
							if(_obj.value =="" || _obj.value==undefined){
								surreadFinished("true");
								_obj.value = "1";
							}
						});
						var wpsFlag1 = $('#wpsFlag1').val();
						if('${xinChuangWps}' == 'true'){
							var fdNeedContent = '${kmImissiveSendMainForm.fdNeedContent!='1'}';
							var contentKey = ''
							if('true' == fdNeedContent){
								contentKey = 'mainonline';
							}else{
								contentKey = 'editonline';
							}
							showWpsXinChuang(contentKey);
							$('#wpsFlag').val('true');
						}

					}else{
						var wpsFlag = $('#wpsFlag').val();
						if('${xinChuangWps}' == 'true' && wpsFlag =='true'){
							$('#wpsFlag').val('false');
							var fdNeedContent = '${kmImissiveSendMainForm.fdNeedContent!='1'}';
							var contentKey = ''
							if('true' == fdNeedContent){
								contentKey = 'mainonline';
							}else{
								contentKey = 'editonline';
							}
							var wpsObject;
							if (contentKey == 'editonline' && wps_linux_editonline){
								wpsObject = wps_linux_editonline;
							}
							if (contentKey == 'mainonline' && wps_linux_mainonline){
								wpsObject = wps_linux_mainonline;
							}
							if(wpsObject){
								wpsObject.setTmpFileByAttKey();
								wpsObject.isCurrent=false;
							}
						}
					}
					if(selectedContent.id == "attPreview"){
						openOnePreview();
					}
					if(selectedContent.id == "attPreview" || selectedContent.id == "attContent"){
		  	   	 	$(LUI("tabpanelDiv").element).find('[data-lui-mark="panel.contents"]').animate({
				        scrollTop: 0
				    }, 100);
		  	   		$(LUI("tabpanelDiv").element).find('[data-lui-mark="panel.contents"]').css('overflow','hidden');
		  	   		 if("${_isWpsCloudEnable}" == 'true' && $('#office-iframe')){
		  	   		 	$(LUI("tabpanelDiv").element).find('[data-lui-mark="panel.contents"]').css('overflow','auto');
		  	   		 }else if("${_isWpsCenterEnable}" == 'true' && $('#office-iframe')){
						$(LUI("tabpanelDiv").element).find('[data-lui-mark="panel.contents"]').css('overflow','auto');
		             }
		  	    }else{
		  	  		 $(LUI("tabpanelDiv").element).find('[data-lui-mark="panel.contents"]').css('overflow','auto');
		  	    }
	  	    }
	  	     
	</ui:event>
</ui:tabpanel>
<%@include file="/km/imissive/km_imissive_send_main/kmImissiveSendMain_viewScript.jsp"%>
<script>
$(document).ready(function(){
	var contentH = $('.content').height();
	if($('#IFrame_Content')){
		$('#IFrame_Content').height( (contentH-135)+"px");
	}
	if($('#attachment_content') && "${_isWpsCloudEnable}" != "true" && "${_isWpsCenterEnable}" != "true"){
		$('#attachment_content').height( (contentH)+"px");
	}
	if($('#previewAttFrame')){
		$('#previewAttFrame').height( (contentH-135)+"px");
	}
	if($('#previewAttListFrame')){
		$('#previewAttListFrame').height( (contentH-135)+"px");
	}
	//解决非ie下控件高度问题
	var obj1 = document.getElementById("JGWebOffice_editonline");
	var obj2 = document.getElementById("JGWebOffice_mainonline");
	if(obj1){
		obj1.setAttribute("height", (contentH-120)+"px");
	}
	if(obj2){
		obj2.setAttribute("height", (contentH-120)+"px");
	}
	//解决非ie下控件高度问题
	//如果没有会签字段则不显示会签记录
	var fdCounterSignDeptNames = document.getElementsByName("counterSignDeptFlag");
	if(fdCounterSignDeptNames.length<1 && document.getElementById("signDeptTr")){
		document.getElementById("signDeptTr").style.display="none";
	}
	
	if("${kmImissiveSendMainForm.docStatus}" >= 30){
		$('.bar-right').css('overflow','auto');
	}
	
	//解决超阅控件点击更多高度问题
	var ofdCyFlag = '${kmImissiveSendMainForm.sysWfBusinessForm.fdNodeAdditionalInfo.ofdCySign =="true"}';
	if(ofdCyFlag == "true"){
		document.getElementById("attContent").style="margin-top:32px";
	}
});
/*
var jgLoadInterval;
function setJgHeight(){
	if("${kmImissiveSendMainForm.fdNeedContent}" == '1'){
		var obj1 = document.getElementById("JGWebOffice_editonline");
		if(obj1&&Attachment_ObjectInfo['editonline']&&jg_attachmentObject_editonline.hasLoad){
	  	   	LUI("tabpanelDiv").setSelectedIndex(0);
	  	   	if(jgLoadInterval){
	  	   		clearInterval(jgLoadInterval);
	  	   	}
		}
	}else{
		var obj2 = document.getElementById("JGWebOffice_mainonline");
		if(obj2&&Attachment_ObjectInfo['mainonline']&&jg_attachmentObject_mainonline.hasLoad){
	  	   	LUI("tabpanelDiv").setSelectedIndex(0);
	  	   	if(jgLoadInterval){
	  	   		clearInterval(jgLoadInterval);
	  	   	}
		}
	}
}
*/
var wpsCenterFlag = false;
LUI.ready(function(){ 
	//从待办进入查看页面，如果是传阅待办，默认定位到传阅页签
	if("${param.flag}"=='circulation'){
		 if(LUI("barRightPanel")){
			var contents = LUI("barRightPanel").contents;
	  	   	for(var i = 0;i< contents.length;i++){
	  	   		if(contents[i].id == "circulation"){
	  	   			LUI("barRightPanel").setSelectedIndex(i);
	  	   		}
	  	   	}
		 }
	}
	if("${_isPriorityDoc}"=="true"){
		if("${editStatus}" == 'true'){
			if(LUI("tabpanelDiv")){
				var contents = LUI("tabpanelDiv").contents;
				for(var j = 0;j< contents.length;j++){
					if(contents[j].id == "attContent"){
						LUI("tabpanelDiv").setSelectedIndex(j);
						if("${_isWpsCloudEnable}" == "true"){
							var officeIframeh = "560";
							if($('.content').length > 0){
								var contentH = $('.content').height();
								officeIframeh = contentH-110;
							}
							if($('#office-iframe')){
								$('#office-iframe').height((officeIframeh)+"px");
							}
						}else if("${_isWpsCenterEnable}" == "true" && !wpsCenterFlag){
							if("${kmImissiveSendMainForm.fdNeedContent}" == '1'){
								wps_center_editonline.load();
							}else{
								wps_center_mainonline.load();
							}
							var officeIframeh = "560";
							if($('.content').length > 0){
								var contentH = $('.content').height();
								officeIframeh = contentH-110;
							}
							if($('#office-iframe')){
								$('#office-iframe').height((officeIframeh)+"px");
							}
							wpsCenterFlag  =true;
						}
					}
				}
			}
		}
	}

	if("${kmImissiveSendMainForm.docStatus}" == '10'){
		setTimeout(function(){
			$("i.lui-fm-icon-5").closest(".lui_tabpanel_vertical_icon_navs_item_l").click();
		},200);
	}
});
</script>
</template:replace>
<template:replace name="barRight">
<%
	String layout = "sys.ui.tabpanel.view";
	if(KmImissiveConfigUtil.getNavMode() == "vertical"){
		layout = "sys.ui.tabpanel.vertical.icon";
	}
	request.setAttribute("layout", layout);
	request.setAttribute("navMode", KmImissiveConfigUtil.getNavMode());
%>
	<c:set var="showRelation" value="false"></c:set>
	<c:if test="${not empty kmImissiveSendMainForm.sysRelationMainForm.sysRelationEntryFormList}">
		<c:set var="showRelation" value="true"></c:set>
		<c:if test="${fn:length(kmImissiveSendMainForm.sysRelationMainForm.sysRelationEntryFormList) == 1 and kmImissiveSendMainForm.sysRelationMainForm.sysRelationEntryFormList[0].fdIsTemplate eq 'true'}">
			<c:set var="showRelation" value="false"></c:set>
		</c:if>
	</c:if>
	<c:choose>	<%--sys.ui.tabpanel.vertical.icon--%>
		<c:when test="${kmImissiveSendMainForm.docStatus != '30' && kmImissiveSendMainForm.docStatus != '00'}">
			<ui:tabpanel id="barRightPanel" channel="barRightPanel" layout="${layout}">
				<kmss:auth requestURL="/km/imissive/km_imissive_send_main/kmImissiveSendMain.do?method=readViewLog&fdId=${kmImissiveSendMainForm.fdId}" requestMethod="GET">
					<c:if test="${kmImissiveSendMainForm.docStatus != '10'}">
						<c:import url="/sys/workflow/import/sysWfProcess_view.jsp" charEncoding="UTF-8">
							<c:param name="formName" value="kmImissiveSendMainForm" />
							<c:param name="fdKey" value="sendMainDoc" />
							<c:param name="showHistoryOpers" value="true" />
							<c:param name="onClickSubmitButton" value="Com_submitReview();" />
							<c:param name="isExpand" value="true" />
							<c:param name="approveType" value="right" />
							<c:param name="approvePosition" value="right" />
						</c:import>
					</c:if>
				</kmss:auth>
				<c:if test="${existOpinion}">
					<ui:content  title="${ lfn:message('km-imissive:kmImissiveSendMain.cirList') }" titleicon="lui-fm-icon lui-fm-icon-3" id="circulation">
						<ui:iframe src="${KMSS_Parameter_ContextPath}sys/circulation/sys_circulation_opinion/sysCirculationOpinion.do?method=edit&fdModelId=${kmImissiveSendMainForm.fdId}&fdModelName=com.landray.kmss.km.imissive.model.KmImissiveSendMain">
						</ui:iframe>
					</ui:content>
				</c:if>
				<ui:content  title="${ lfn:message('km-imissive:kmImissiveSendMain.attList') }" id="attPreviewList" titleicon="lui-fm-icon lui-fm-icon-5">
					<c:import url="/km/imissive/km_att_preview/sysAttPreview_view2.jsp" charEncoding="UTF-8">
						<c:param name="wpsoaassist" value="${wpsoaassist}"/>
					</c:import>
		 	    </ui:content>
		 	    <kmss:auth requestURL="/km/imissive/km_imissive_send_main/kmImissiveSendMain.do?method=readViewLog&fdId=${kmImissiveSendMainForm.fdId}" requestMethod="GET">
		 	    	<c:import url="/sys/lbpmservice/support/lbpm_audit_note/lbpmAuditNote_list_content.jsp" charEncoding="UTF-8">
						<c:param name="formName" value="kmImissiveSendMainForm" />
						<c:param name="fdModelId" value="${kmImissiveSendMainForm.fdId}" />
						<c:param name="fdModelName" value="com.landray.kmss.km.imissive.model.KmImissiveSendMain" />
					</c:import>
		 	    </kmss:auth>
		 	    <c:if test="${showRelation eq 'true' }">
			 	     <c:import url="/km/imissive/import/sysRelationMain_view.jsp" charEncoding="UTF-8">
						<c:param name="layout" value="sys.ui.accordionpanel.simpletitle"/>
						<c:param name="formName" value="kmImissiveSendMainForm" />
						<c:param name="titleicon" value="lui-fm-icon lui-fm-icon-1" />
					</c:import>
				</c:if>
				<ui:event event="indexChanged" args="data" >
					if($('#main').hasClass("lui-slide-main-spread") && data.panel.id == 'barRightPanel'){
				  	   $("[data-lui-slide-btn]").trigger("click");
				  	}
					var panel = data.panel;
					var selectedContent = panel.contents[data.index.after];
					if(selectedContent.id =='attPreviewList' && attCount == 0 && $('#previewAttListFrame').attr('src') == ""){
						var url = getHost() + Com_Parameter.ContextPath+"sys/attachment/sys_att_main/sysAttMain_preview_noDataS.jsp";
						$('#previewAttListFrame').attr('src',url);
						var contentH = $('.content').height();
						$('#previewAttListFrame').css("height",(contentH-90) + "px");
					}
				</ui:event>
			</ui:tabpanel>
		</c:when>
		<c:otherwise>
			<ui:accordionpanel>
				<c:if test="${existOpinion}">
					<ui:content  title="${ lfn:message('km-imissive:kmImissiveSendMain.cirList') }" titleicon="lui-fm-icon lui-fm-icon-3" id="circulation">
						<ui:iframe src="${KMSS_Parameter_ContextPath}sys/circulation/sys_circulation_opinion/sysCirculationOpinion.do?method=edit&fdModelId=${kmImissiveSendMainForm.fdId}&fdModelName=com.landray.kmss.km.imissive.model.KmImissiveSendMain">
						</ui:iframe>
					</ui:content>
				</c:if>
				<ui:content  title="${ lfn:message('km-imissive:kmImissiveSendMain.attList') }" id="attPreviewList" titleicon="lui-fm-icon lui-fm-icon-5">
					<c:import url="/km/imissive/km_att_preview/sysAttPreview_view2.jsp" charEncoding="UTF-8">
						<c:param name="wpsoaassist" value="${wpsoaassist}"/>
					</c:import>
		 	    </ui:content>
		 	    <c:if test="${showRelation eq 'true' }">
			 	    <c:import url="/km/imissive/import/sysRelationMain_view.jsp" charEncoding="UTF-8">
						<c:param name="layout" value="sys.ui.accordionpanel.simpletitle"/>
						<c:param name="formName" value="kmImissiveSendMainForm" />
						<c:param name="titleicon" value="lui-fm-icon lui-fm-icon-1" />
					</c:import>
				</c:if>
				<script>
					$(document).ready(function(){
						setTimeout(function(){
							if(attCount == 0 && $('#previewAttListFrame').attr('src') == ""){
								var url = getHost() + Com_Parameter.ContextPath+"sys/attachment/sys_att_main/sysAttMain_preview_noDataS.jsp";
								$('#previewAttListFrame').attr('src',url);
								var contentH = $('.content').height();
								$('#previewAttListFrame').css("height",(contentH-90) + "px");
							}
						},100);
					});
				</script>
			</ui:accordionpanel>
		</c:otherwise>
	</c:choose>
</template:replace>

