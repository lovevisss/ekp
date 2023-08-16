<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="/sys/ui/jsp/common.jsp"%>
<%@page import="com.landray.kmss.km.imissive.util.KmImissiveConfigUtil"%>
<%@page import="com.landray.kmss.sys.attachment.integrate.wps.util.SysAttWpsCloudUtil"%>
<%@page import="com.landray.kmss.sys.attachment.integrate.wps.util.SysAttWpsCenterUtil"%>
<%@ page import="com.landray.kmss.km.imissive.util.ImissiveUtil"%>
<c:set var="wpsoaassist" value="<%=ImissiveUtil.isEnable()%>"/>
<c:set var="xinChuangWps" value="<%=ImissiveUtil.isWPSOAassistEmbed(request)%>"/>
<%
	pageContext.setAttribute("_isWpsCloudEnable", new Boolean(ImissiveUtil.isEnableWpsCloud()));
	pageContext.setAttribute("_isWpsCenterEnable", new Boolean(SysAttWpsCenterUtil.isEnable()));
	pageContext.setAttribute("_isOfdServiceName", new String(KmImissiveConfigUtil.getAttOfdServiceName()));
	pageContext.setAttribute("_isPdfServiceName", new String(KmImissiveConfigUtil.getAttPdfServiceName()));
%>
<template:replace name="head">
	<%-- 压缩JS --%>
	<jsp:include page="/km/imissive/compressJs/compressJs_singleTabEditContent.jsp">
		<jsp:param name="fdType" value="sign"/>
	</jsp:include>
	<link rel="Stylesheet" href="${LUI_ContextPath}/km/imissive/resource/css/att.css?s_cache=${MUI_Cache}" />
</template:replace>
<template:replace name="toolbar">
		<%@ include file="/km/imissive/script.jsp"%>
		<!-- 软删除配置 -->
		<c:if test="${kmImissiveSignMainForm.docDeleteFlag ==1}">
			<ui:toolbar id="toolbar" style="display:none;" count="6"></ui:toolbar>
		</c:if>
		<c:if test="${kmImissiveSignMainForm.docDeleteFlag !=1}">
		<ui:toolbar id="toolbar" layout="sys.ui.toolbar.float" count="6"> 
			<c:if test="${kmImissiveSignMainForm.method_GET=='add'}">
			    <ui:button text="${lfn:message('button.savedraft') }" order="2" onclick=" commitMethod('save','true');">
				</ui:button>
				<ui:button text="${lfn:message('button.submit') }" order="2"  styleClass="lui_widget_btn_primary" isForcedAddClass="true" onclick=" commitMethod('save','false');">
				</ui:button>
			</c:if>
			<c:if test="${kmImissiveSignMainForm.method_GET=='edit'}">
				<c:if test="${kmImissiveSignMainForm.docStatus=='11'}">
					<ui:button text="${ lfn:message('button.savedraft') }" order="2" 
							onclick="_updateDraft();">
					</ui:button>
				</c:if>
				<c:if test="${kmImissiveSignMainForm.docStatus=='10'}">
					<ui:button text="${lfn:message('button.savedraft') }" order="2" onclick=" commitMethod('update','true');">
					</ui:button>
				</c:if>
				<c:if test="${kmImissiveSignMainForm.docStatus<'20'}">
				    <ui:button text="${lfn:message('button.submit') }" order="2" styleClass="lui_widget_btn_primary" isForcedAddClass="true" onclick=" commitMethod('update','false');">
					</ui:button>
				</c:if>
				<c:if test="${kmImissiveSignMainForm.docStatus=='20'}">
				    <ui:button text="${lfn:message('button.submit') }" order="2" styleClass="lui_widget_btn_primary" isForcedAddClass="true" onclick=" submitOrUpdateDoc(document.kmImissiveSignMainForm, 'update');">
					</ui:button>
				</c:if>
				<c:if test="${kmImissiveSignMainForm.docStatus>='30'}">
				    <ui:button text="${lfn:message('button.submit') }" order="2" styleClass="lui_widget_btn_primary" isForcedAddClass="true" onclick=" submitOrUpdateDoc(document.kmImissiveSignMainForm, 'update');">
					</ui:button>
				</c:if>
				 </c:if>
				 <%-- 套红附加选项 --%>
				<c:if  test="${nodeExtAttributeMap['redhead4Draft'] == 'true' or nodeAdditionalMap['redhead'] == 'true' or nodeAdditionalMap['redhead'] == 'on'}">
				   <ui:button text="${lfn:message('km-imissive:kmImissive.redhead') }" order="2"
				   	 onclick="doRedHead();">
				   </ui:button>
				</c:if>
			 	<ui:button text="${ lfn:message('button.close') }" order="5"  onclick="Com_CloseWindow()">
			 	</ui:button>
			</ui:toolbar>
			</c:if>
		</template:replace>
		<template:replace name="path">
			<div class="lui_form_path_item_l">
				流程:
			</div>
			<div class="lui_form_path_item_c">
				<ui:menu layout="sys.ui.menu.nav"  id="categoryId"> 
					<ui:menu-source autoFetch="false">
						<ui:source type="AjaxJson">
							{"url":"/sys/category/criteria/sysCategoryCriteria.do?method=path&modelName=com.landray.kmss.km.imissive.model.KmImissiveSignTemplate&categoryId=${kmImissiveSignMainForm.fdTemplateId}"} 
						</ui:source>
					</ui:menu-source>
				</ui:menu>
			</div>
			<c:choose>
				<c:when test="${ kmImissiveSignMainForm.method_GET == 'add' }">
					<div class="lui_form_path_item_r">
						- 签报拟稿
					</div>
				</c:when>
				<c:otherwise>
					<kmss:showWfPropertyValues var="nodevalue" idValue="${kmImissiveSignMainForm.fdId}" propertyName="nodeName" />
					<div class="lui_form_path_item_r">
				        <c:out value="${nodevalue}"></c:out>
				    </div>
				</c:otherwise>
			</c:choose>
	</template:replace>
	<template:replace name="content"> 
		<c:import url="/sys/recycle/import/redirect.jsp" charEncoding="UTF-8">
			<c:param name="formBeanName" value="kmImissiveSignMainForm"></c:param>
		</c:import>	
		<c:if test="${kmImissiveSignMainForm.method_GET=='add'}">
			<script type="text/javascript">
				window.changeDocTemp = function(modelName,url,canClose){
					if(modelName==null || modelName=='' || url==null || url=='')
						return;
			 		seajs.use(['sys/ui/js/dialog'],function(dialog) {
					 	dialog.categoryForNewFile(modelName,url,false,null,function(rtn) {
							// 无分类状态下（一般于门户快捷操作）创建文档，取消操作同时关闭当前窗口
							if (!rtn)
								window.close();
						},'${JsParam.categoryId}','_self',canClose);
				 	});
			 	};
			 	
				if('${JsParam.fdTemplateId}'==''){
					window.changeDocTemp('com.landray.kmss.km.imissive.model.KmImissiveSignTemplate','/km/imissive/km_imissive_sign_main/kmImissiveSignMain.do?method=add&fdTemplateId=!{id}&fdModelId=${JsParam.fdModelId}&fdModelName=${JsParam.fdModelName}',true);
				}
			</script>
		</c:if>
		<script type="text/javascript">
		//解决非ie下控件高度问题
		var contentH; 
		$(document).ready(function(){
			setTimeout(function(){
				contentH = $('.content').height();
			 	if($('#IFrame_Content')){
			 		$('#IFrame_Content').height( (contentH-135)+"px");
			 	}
			 	if($('#attachment_content')){
			 		$('#attachment_content').height( (contentH)+"px");
			 	}
			 	if($('#previewAttFrame')){
					$('#previewAttFrame').height( (contentH-140)+"px");
				}
				if($('#previewAttListFrame')){
					$('#previewAttListFrame').height( (contentH-140)+"px");
				}
			},500);
			//解决超阅控件点击更多高度问题
			var ofdCyFlag = '${kmImissiveSignMainForm.sysWfBusinessForm.fdNodeAdditionalInfo.ofdCySign =="true"}';
			if(ofdCyFlag == "true"){
				document.getElementById("attContent").style="margin-top:32px";
			}
			if($('#pdfFrame')){
				var contentH = 520;
				//如果是左右结构，则重新计算高度
				if($('.content')&&$('.content').height()){
					contentH = $('.content').height()-100;
				}
				$('#pdfFrame').css('min-height', (contentH)+'px');
				$('#pdfFrame').css('height', (contentH+20)+'px');
				$('#pdfFrame').prop('scrolling', "no");
			}
		});

		
		/*正文为在线编辑方式，动态切换页签加载金格会报错，暂时屏蔽
		var jgLoadInterval;
		function setJgHeight(){
			var obj = document.getElementById("JGWebOffice_editonline");
			if(obj&&Attachment_ObjectInfo['editonline']&&jg_attachmentObject_editonline.hasLoad &&jg_attachmentObject_editonline.ocxObj){
		 		obj.setAttribute("height",(contentH-120)+"px");
		  	   	LUI("tabpanelDiv").setSelectedIndex(0);
		  	   	if(jgLoadInterval){
		  	   		clearInterval(jgLoadInterval);
		  	   	}
			}
		}
		LUI.ready(function(){
			setTimeout(function(){
			 	var type =  document.getElementsByName("fdNeedContent");
			 	if(type.length >0 && type[0].value == '1'){
			 		if(LUI("tabpanelDiv")){
						var contents = LUI("tabpanelDiv").contents;
				  	   	for(var i = 0;i< contents.length;i++){
				  	   		if(contents[i].id == "attContent"){
				  	   			LUI("tabpanelDiv").setSelectedIndex(i);
				  	   			checkEditType("${kmImissiveSignMainForm.fdNeedContent}", null);	
					  	   		jgLoadInterval = setInterval(function(){
					  	   			setJgHeight();
					  			},500);
				  	   		}
				  	   	}
					 }
			 	}
			},300);
		});
		*/
	</script>
	<ui:tabpanel id="tabpanelDiv" layout="sys.ui.tabpanel.view" var-count="4" var-average = 'false'>
			<ui:content id="kmImissiveSignMain_baseinfo" titleicon="lui-tab-icon tab-icon-02" title="${ lfn:message('km-imissive:kmImissiveSendMain.baseinfo') }" expand="${expandBaseInfo}">
 			<html:hidden property="docStatus" />
			<html:hidden property="fdId"/>
			<html:hidden property="fdModelId" />
			<html:hidden property="fdModelName"/>
			<html:hidden property="fdNeedContent" value="${kmImissiveSignMainForm.fdNeedContent}"/>
			<html:hidden property="method_GET" />
 			<div class="lui_form_content_frame" style="padding-top: 5px" id ="kmImissiveSignXform">
				<c:import url="/sys/xform/include/sysForm_edit.jsp"
					charEncoding="UTF-8">
					<c:param name="formName" value="kmImissiveSignMainForm" />
					<c:param name="fdKey" value="signMainDoc"/>
					<c:param name="messageKey" value="km-imissive:kmImissiveSignMain.baseinfo"/>
					<c:param name="useTab" value="false" />
				</c:import>
			</div>
			</ui:content>
			<c:if test="${kmImissiveSignMainForm.fdNeedContent eq '1'}">
		  <ui:content  title="${ lfn:message('km-imissive:kmImissiveSendMain.docContent') }" style="padding:6px" id="attContent" titleicon="lui-tab-icon tab-icon-10">
		  	<div class="lui_form_content_frame"  id="wordEdit"  <c:if test="${kmImissiveSignMainForm.fdNeedContent!='word'}">style="width:0px;height:0px;"</c:if>>
		        <%@ include file="/km/imissive/kmImissiveSignRedhead_script.jsp"%>
		        <%@ include file="/km/imissive/km_imissive_sign_main/kmImissiveSignRedhead_script.jsp"%>
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
								 </jsp:include>
							 </c:when>
							 <c:otherwise>
								 <jsp:include page="/km/imissive/km_imissive_sign_main/kmImissiveSignMain_btn_include2.jsp">
									 <jsp:param name="attId" value="${attId}"/>
								 </jsp:include>
							 </c:otherwise>
						 </c:choose>
					 </c:when>
				 	<c:when test="${not empty kmImissiveSignMainForm.attachmentForms['ofdCySign'].attachments}">
						 <%-- ofd超阅展示 --%>
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
								 <iframe id="pdfFrame"  width="100%"  style="min-height:565px;"  frameborder="0"></iframe>
								 <script type="text/javascript">
									 //在普通编辑模式不会加载ui:event事件所以改为ready
									 $(document).ready(function(){
										 document.getElementById('pdfFrame').src='<c:url value="${wpsOfdOrPdfUrl }"/>';
									 });
								 </script>
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
		         	<c:when test="${wpsoaassist eq 'true'}">
		         		<c:if test="${kmImissiveSignMainForm.sysWfBusinessForm.fdNodeAdditionalInfo.yqqSignzq =='true' && yqqFlag=='true'}">
							<c:set var="signtrue" value="true" />
						</c:if>
						<div id="wpsAddIn">
							<c:choose>
								<c:when test="${xinChuangWps eq 'true'}">
									<jsp:include page="/km/imissive/wps/oaassist/sysAttMain_edit.jsp">
										<jsp:param name="fdKey" value="editonline"/>
										<jsp:param name="fdModelId" value="${kmImissiveSignMainForm.fdId}"/>
										<jsp:param name="fdModelName" value="com.landray.kmss.km.imissive.model.KmImissiveSignMain"/>
										<jsp:param name="formBeanName" value="kmImissiveSignMainForm"/>
										<jsp:param name="load" value="false"/>
										<jsp:param name="redhead" value="${redhead}"/>
										<jsp:param name="nodevalue" value="${nodevalue}"/>
										<jsp:param name="bookmarkJson" value="${bookmarkJson}"/>
										<jsp:param name="newFlag" value="true"/>
									</jsp:include>
								</c:when>
								<c:otherwise>
									<jsp:include page="/km/imissive/wps/sysAttMain_include_editWpsView.jsp">
										<jsp:param name="methodGet" value="${kmImissiveSignMainForm.method_GET}"/>
										<jsp:param name="fdModelId" value="${kmImissiveSignMainForm.fdId }"/>
										<jsp:param name="redhead" value="${redhead}"/>
										<jsp:param name="nodevalue" value="${nodevalue}"/>
										<jsp:param name="bookmarkJson" value="${bookmarkJson}"/>
										<jsp:param name="fdTemplateId" value="${kmImissiveSignMainForm.fdTemplateId}"/>
										<jsp:param name="fdModelName" value="com.landray.kmss.km.imissive.model.KmImissiveSignMain"/>
										<jsp:param name="formName" value="kmImissiveSignMainForm"/>
										<jsp:param name="initAttId" value="${initAttId}"/>
										<jsp:param name="modelFlag" value="sign"/>
									</jsp:include>
								</c:otherwise>
							</c:choose>
						</div>
					</c:when>
					<c:when test="${_isWpsCloudEnable}">
						<div id="child">	
					      	<c:import url="/km/imissive/import/xformBookmark_include.jsp"	charEncoding="UTF-8">
								<c:param name="formName" value="kmImissiveSignMainForm" />
								<c:param name="fdTemplateId" value="${kmImissiveSignMainForm.fdTemplateId }" />
							</c:import>	
						  	<div id="missiveButtonDiv" style="text-align:right;">
							    <a href="javascript:void(0);" class="attbook" onclick="openBookmarkHelp(Com_Parameter.ContextPath+'km/imissive/km_imissive_sign_main/bookMarks.jsp','_blank');">
									<bean:message key="kmImissive.bookMarks.title" bundle="km-imissive" />
								</a>
						   	</div>
						   <div id="wordEditWrapper"></div>
						   <div id="wordEditFloat" style="width:0px;height:0px;filter:alpha(opacity=0);opacity:0;">
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
							</div>
						</div>
					</c:when>
					 <c:when test="${_isWpsCenterEnable}">
						 <div id="child">
							 <c:import url="/km/imissive/import/xformBookmark_include.jsp"	charEncoding="UTF-8">
								 <c:param name="formName" value="kmImissiveSignMainForm" />
								 <c:param name="fdTemplateId" value="${kmImissiveSignMainForm.fdTemplateId }" />
							 </c:import>
							 <div id="missiveButtonDiv" style="text-align:right;">
								 <%--<a href="javascript:void(0);" class="officialSmart" id="smartTypesettingBtn"
									onclick="smartTypesetting('sign', '${kmImissiveSignMainForm.method_GET}')">
									 <c:out value="智能排版" />
								 </a>--%>
								 <a href="javascript:void(0);" class="attbook" onclick="openBookmarkHelp(Com_Parameter.ContextPath+'km/imissive/km_imissive_sign_main/bookMarks.jsp','_blank');">
									 <bean:message key="kmImissive.bookMarks.title" bundle="km-imissive" />
								 </a>
							 </div>
							 <div id="wordEditWrapper"></div>
							 <div id="wordEditFloat" style="width:0px;height:0px;filter:alpha(opacity=0);opacity:0;">
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
							 </div>
						 </div>
					 </c:when>
					<c:otherwise>
						<div id="child">	
							<%@ include file="/sys/attachment/sys_att_main/jg/sysAttMain_CheckJgSupport.jsp"%>
					      <c:if test="${supportJg eq 'supported'}">	
					      	<c:import url="/km/imissive/import/xformBookmark_include.jsp"	charEncoding="UTF-8">
								<c:param name="formName" value="kmImissiveSignMainForm" />
								<c:param name="fdTemplateId" value="${kmImissiveSignMainForm.fdTemplateId }" />
							</c:import>	
						  	<div id="missiveButtonDiv" style="text-align:right;">
							    <a href="javascript:void(0);" class="attbook" onclick="openBookmarkHelp(Com_Parameter.ContextPath+'km/imissive/km_imissive_sign_main/bookMarks.jsp','_blank');">
								<bean:message key="kmImissive.bookMarks.title" bundle="km-imissive" />
								</a>
						   	</div>
						  </c:if>
						   <div id="wordEditWrapper"></div>
						   <div id="wordEditFloat" style="width:0px;height:0px;filter:alpha(opacity=0);opacity:0;">
							   <c:import url="/sys/attachment/sys_att_main/jg/sysAttMain_edit.jsp" charEncoding="UTF-8">
									<c:param name="fdModelId" value="${kmImissiveSignMainForm.fdId}" />
									<c:param name="fdModelName" value="com.landray.kmss.km.imissive.model.KmImissiveSignMain" />
									<c:param name="fdKey" value="editonline" />
									<c:param name="formBeanName" value="kmImissiveSignMainForm" />
									<c:param name="fdAttType" value="office"/>
									 <c:param name="load" value="false" />
									<c:param name="bindSubmit" value="false"/>
									<c:param name="fdTemplateModelId" value="${kmImissiveSignMainForm.fdTemplateId}" />
									<c:param name="fdTemplateModelName" value="com.landray.kmss.km.imissive.model.KmImissiveSignTemplate" />
									<c:param name="fdTemplateKey" value="editonline" />
									<c:param name="bookMarks" value="${bookmarkJson}" />
									<c:param name="buttonDiv" value="missiveButtonDiv"/>
									<c:param name="isToImg" value="false"/>
								</c:import>
							</div>
						</div>
					</c:otherwise>
				</c:choose>
			</div>
		  </ui:content>
	    </c:if>
		<c:if test="${xinChuangWps ne 'true'}">
	     <ui:content  title="附件预览" id="attPreview" titleicon="lui-tab-icon tab-icon-05">
 	  			<div id="attachment_preview">
 	  				<iframe width="100%" height="100%" frameborder="0" scrolling="auto" id="previewAttFrame" src=""></iframe>
				</div>
 	 	  </ui:content>
		</c:if>
 	 	  <c:import url="/sys/workflow/import/sysWfProcess_edit.jsp" charEncoding="UTF-8">
			<c:param name="formName" value="kmImissiveSignMainForm" />
			<c:param name="fdKey" value="signMainDoc" />
			<c:param name="showHistoryOpers" value="true" />
			<c:param name="isExpand" value="true" />
			<c:param name="approveType" value="right" />
			<c:param name="titleicon" value="lui-tab-icon tab-icon-06" />
		</c:import> 
		<c:import url="/sys/news/import/sysNewsPublishMain_edit.jsp" charEncoding="UTF-8">
			<c:param name="formName" value="kmImissiveSignMainForm" />
			<c:param name="fdKey" value="sendMainDoc" />
			<c:param name="isShow" value="true" />
			<c:param name="titleicon" value="lui-tab-icon tab-icon-12" />
		</c:import>
		<!-- 版本锁机制 -->
		<c:import url="/component/locker/import/componentLockerVersion_import.jsp" charEncoding="UTF-8">
			<c:param name="formName" value="kmImissiveSignMainForm" />
		</c:import>
		<ui:content title="${ lfn:message('sys-right:right.moduleName') }" titleicon="lui-tab-icon tab-icon-07">
			<table class="tb_normal" width=100%>
				<tr>
					<td class="td_normal_title" width="15%"><bean:message  bundle="km-imissive" key="kmImissiveSignMain.authAppRecReaderIds"/></td>
					<td width="85%" colspan='3'>
						<xform:address textarea="true" mulSelect="true" propertyId="authAppRecReaderIds" propertyName="authAppRecReaderNames" style="width:97%;height:90px;" ></xform:address>
					    <br><span class="com_help"><bean:message bundle="sys-right" key="right.read.authReaders.note1" /></span>
					</td>
				</tr>
				<c:import url="/sys/right/right_edit.jsp" charEncoding="UTF-8">
					<c:param name="formName" value="kmImissiveSignMainForm" />
					<c:param name="moduleModelName" value="com.landray.kmss.km.imissive.model.KmImissiveSignMain" />
				</c:import>
			</table>
		</ui:content>
		<input type="hidden" id="wpsFlag" value="false">
		<ui:event event="indexChanged" args="data">
		  	    var panel = data.panel;
		  	    var selectedContent = panel.contents[data.index.after];
		  	    if(selectedContent.id == "attContent"){
					var contents = LUI("barRightPanel").contents;
					for(var i = 0;i< contents.length;i++){
						if(contents[i].id == "process_review_tabcontent_right"){
							LUI("barRightPanel").setSelectedIndex(i);
						}
					}
			  	    checkEditType("${kmImissiveSignMainForm.fdNeedContent}", null);
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
					if(selectedContent.id == "attPreview"){
						openOnePreview("edit");
					}
			  	     if(selectedContent.id == "attPreview" || selectedContent.id == "attContent" && "${_isWpsCloudEnable}" != 'true'&& "${_isWpsCenterEnable}" != 'true'){
				  	     $(LUI("tabpanelDiv").element).find('[data-lui-mark="panel.contents"]').animate({
					        scrollTop: 0
					    }, 100);
		  	   		 	$(LUI("tabpanelDiv").element).find('[data-lui-mark="panel.contents"]').css('overflow','hidden');
				  	 }else{
				  	    $(LUI("tabpanelDiv").element).find('[data-lui-mark="panel.contents"]').css('overflow','auto');
				  	 }
		  	    }
		</ui:event>
	</ui:tabpanel>	
	<script language="JavaScript">
		var validation = $KMSSValidation(document.forms['kmImissiveSignMainForm']);
	</script>
	<%@ include file="/km/imissive/km_imissive_sign_main/kmImissiveSignMain_editScript.jsp"%>
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
	<ui:tabpanel id="barRightPanel" channel="barRightPanel" layout="${layout}">
		<c:import url="/sys/workflow/import/sysWfProcess_edit.jsp" charEncoding="UTF-8">
			<c:param name="formName" value="kmImissiveSignMainForm" />
			<c:param name="fdKey" value="signMainDoc" />
			<c:param name="showHistoryOpers" value="true" />
			<c:param name="isExpand" value="true" />
			<c:param name="approveType" value="right" />
			<c:param name="approvePosition" value="right" />
		</c:import>
		<ui:content  title="附件列表" id="attPreviewList" titleicon="lui-fm-icon lui-fm-icon-2">
			<c:import url="/km/imissive/km_att_preview/sysAttPreview_view2.jsp" charEncoding="UTF-8">
				<c:param name="wpsoaassist" value="${wpsoaassist}"/>
			</c:import>
 	    </ui:content>
 	     <c:import url="/sys/relation/import/sysRelationMain_edit.jsp" charEncoding="UTF-8">
			<c:param name="formName" value="kmImissiveReceiveMainForm" />
			<c:param name="approveType" value="right" />
			<c:param name="needTitle" value="true" />
		</c:import>
 	    <ui:event event="indexChanged" args="data" >
			if($('#main').hasClass("lui-slide-main-spread") && data.panel.id == 'barRightPanel'){
		  	   $("[data-lui-slide-btn]").trigger("click");
		  	}
			var panel = data.panel;
			var selectedContent = panel.contents[data.index.after];
			if(selectedContent.id =='attPreviewList' && attCount == 0 && $('#previewAttListFrame').attr('src') == ""){
				var url = getHost() + Com_Parameter.ContextPath+"sys/attachment/sys_att_main/sysAttMain_preview_noDataS.jsp";
				$('#previewAttListFrame').attr('src',url);
			}
		</ui:event>
	</ui:tabpanel>
</template:replace>

