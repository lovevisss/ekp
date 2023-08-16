<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="/sys/ui/jsp/common.jsp"%>
<template:include ref="default.edit" sidebar="auto">
<%@ page import="com.landray.kmss.util.IDGenerator"%>
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
	<template:replace name="title">
		<c:choose>
			<c:when test="${ kmImissiveSendMainForm.method_GET == 'add' }">
				<c:out value="${lfn:message('km-imissive:kmImissiveSendMain.create.title') } - ${ lfn:message('km-imissive:module.km.imissive') }"></c:out>	
			</c:when>
			<c:otherwise>
				<c:out value="${kmImissiveSendMainForm.docSubject} - ${ lfn:message('km-imissive:module.km.imissive') }"></c:out>
			</c:otherwise>
		</c:choose>
	</template:replace>
	<template:replace name="head">
		<%-- JS压缩 --%>
		<jsp:include page="/km/imissive/compressJs/compressJs_edit.jsp">
			<jsp:param name="fdType" value="send"/>
		</jsp:include>
		<link rel="Stylesheet" href="${LUI_ContextPath}/km/imissive/resource/css/att.css?s_cache=${MUI_Cache}" />
	</template:replace>
	<template:replace name="toolbar">
		<%@ include file="/km/imissive/script.jsp"%>
		<!-- 软删除配置 -->
		<c:if test="${kmImissiveSendMainForm.docDeleteFlag ==1}">
			<ui:toolbar id="toolbar" style="display:none;" count="6"></ui:toolbar>
		</c:if>
		<c:if test="${kmImissiveSendMainForm.docDeleteFlag !=1}">
			<ui:toolbar id="toolbar" layout="sys.ui.toolbar.float" count="6">
				<c:if test="${kmImissiveSendMainForm.method_GET=='add'}">
					<c:choose>
						<%--签收单转发文 --%>
						<c:when test="${not empty fddetaiId or not empty param.fdReceiveId}">
							<ui:button text="${lfn:message('button.savedraft') }" order="2"
								onclick="commitMethod('saveSend','true');">
							</ui:button>
							<ui:button text="${lfn:message('button.submit') }" order="2"
								onclick=" commitMethod('saveSend','false');">
							</ui:button>
						</c:when>
						<c:otherwise>
							<ui:button text="${lfn:message('button.savedraft') }" order="2"
								onclick="commitMethod('save','true');">
							</ui:button>
							<ui:button text="${lfn:message('button.submit') }" order="2"
								onclick=" commitMethod('save','false');">
							</ui:button>
						</c:otherwise>
					</c:choose>

				</c:if>
				<c:if test="${kmImissiveSendMainForm.method_GET=='edit'}">
					<c:if test="${kmImissiveSendMainForm.docStatus=='11'}">
						<ui:button text="${ lfn:message('button.savedraft') }" order="2" 
								onclick="_updateDraft();">
						</ui:button>
					</c:if>
					<c:if test="${kmImissiveSendMainForm.docStatus=='10'}">
						<ui:button text="${lfn:message('button.savedraft') }" order="2"
							onclick=" commitMethod('update','true');">
						</ui:button>
					</c:if>
					<c:if test="${kmImissiveSendMainForm.docStatus<'20'}">
						<ui:button text="${lfn:message('button.submit') }" order="2"
							onclick=" commitMethod('update','false');">
						</ui:button>
					</c:if>
					<c:if test="${kmImissiveSendMainForm.docStatus=='20'}">
						<ui:button text="${lfn:message('button.submit') }" order="2"
							onclick=" submitOrUpdateDoc(document.kmImissiveSendMainForm, 'update');">
						</ui:button>
					</c:if>
					<c:if test="${kmImissiveSendMainForm.docStatus>='30'}">
						<ui:button text="${lfn:message('button.submit') }" order="2"
							onclick=" submitOrUpdateDoc(document.kmImissiveSendMainForm, 'update');">
						</ui:button>
					</c:if>
				</c:if>
				<%-- 套红附加选项 --%>
				<c:if test="${nodeExtAttributeMap['redhead4Draft'] == 'true' or nodeAdditionalMap['redhead'] == 'true' or nodeAdditionalMap['redhead'] == 'on' }">
					<ui:button text="${lfn:message('km-imissive:kmImissive.redhead') }"
						order="2" onclick="doRedHead();">
					</ui:button>
				</c:if>
				<ui:button text="${ lfn:message('button.close') }" order="5"
					onclick="Com_CloseWindow()">
				</ui:button>
			</ui:toolbar>
		</c:if>
	</template:replace>
	<template:replace name="path">
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
			<c:choose>
				<c:when test="${ kmImissiveSendMainForm.method_GET == 'add' }">
					<div class="lui_form_path_item_r">
						- 发文拟稿
					</div>
				</c:when>
				<c:otherwise>
					<kmss:showWfPropertyValues var="nodevalue" idValue="${kmImissiveSendMainForm.fdId}" propertyName="nodeName" />
					<div class="lui_form_path_item_r">
				        <c:out value="${nodevalue}"></c:out>
				    </div>
				</c:otherwise>
			</c:choose>
		</div>
	</template:replace>
	<template:replace name="content">
	<!-- 软删除配置 -->
	<c:import url="/sys/recycle/import/redirect.jsp" charEncoding="UTF-8">
		<c:param name="formBeanName" value="kmImissiveSendMainForm"></c:param>
	</c:import>	
	<c:if test="${kmImissiveSendMainForm.method_GET=='add'}">
		<script type="text/javascript">
			window.changeDocTemp = function(modelName,url,canClose){
				if(modelName==null || modelName=='' || url==null || url=='')
					return;
		 		seajs.use(['sys/ui/js/dialog'],function(dialog) {
				 	dialog.categoryForNewFile(modelName,url,false,null,function(rtn) {
						// 无分类状态下（一般于门户快捷操作）创建文档，取消操作同时关闭当前窗口
						if (!rtn)
							window.close();
					},'${param.categoryId}','_self',canClose);
			 	});
		 	};
		 	
			if('${param.fdTemplateId}'==''){
				window.changeDocTemp('com.landray.kmss.km.imissive.model.KmImissiveSendTemplate','/km/imissive/km_imissive_send_main/kmImissiveSendMain.do?method=add&fdTemplateId=!{id}&fdModelId=${param.fdModelId}&fdModelName=${param.fdModelName}',true);
			}
		</script>
	</c:if>
	<script type="text/javascript">
	//解决非ie下控件高度问题
		$(document).ready(function(){
			checkEditType("${kmImissiveSendMainForm.fdNeedContent}", null);
			var obj = document.getElementById("JGWebOffice_editonline");
			if(obj){
				obj.setAttribute("height", "550px");
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
		function useLocalSign(){
 			return true;
 		}
	</script>
	<%@ include file="/km/imissive/km_imissive_send_main/kmImissiveSendMain_editScript.jsp"%>
		<html:form action="/km/imissive/km_imissive_send_main/kmImissiveSendMain.do">
			<html:hidden property="docStatus" />
			<html:hidden property="fdId" />
			<html:hidden property="fdDetailId" />
			<html:hidden property="fdMainId" />
			<html:hidden property="fdModelId" />
			<html:hidden property="fdModelName" />
			<html:hidden property="fdReadSendOpinion" />
			<html:hidden property="fdIsFromOut" />
			<kmss:showWfPropertyValues var="nodevalue"
				idValue="${kmImissiveSendMainForm.fdId}" propertyName="nodeName" />
			<div class="lui_form_content_frame" style="padding-top: 5px" id="kmImissiveSendXform">
				
				<c:choose>
					<c:when test="${not empty param.fdModelName && (not empty param.fdModelId || param.isRelationFile eq '1')}">
						<c:import url="/km/imissive/import/kmImissiveMain_relationFile.jsp" charEncoding="UTF-8">
							<c:param name="fdModelId" value="${param.fdModelId}" />
							<c:param name="fdModelName" value="${param.fdModelName}" />
							<c:param name="docStatus" value="${kmImissiveSendMainForm.docStatus}" />
							<c:param name="method_GET" value="${kmImissiveSendMainForm.method_GET}" />
							<c:param name="isRelationFile" value="${param.isRelationFile}" />
						</c:import>
					</c:when>
					<c:when test="${not empty kmImissiveSendMainForm.fdModelId && not empty kmImissiveSendMainForm.fdModelName}">
						<c:import url="/km/imissive/import/kmImissiveMain_relationFile.jsp" charEncoding="UTF-8">
							<c:param name="fdModelId" value="${kmImissiveSendMainForm.fdModelId}" />
							<c:param name="fdModelName" value="${kmImissiveSendMainForm.fdModelName}" />
							<c:param name="docStatus" value="${kmImissiveSendMainForm.docStatus}" />
							<c:param name="method_GET" value="${kmImissiveSendMainForm.method_GET}" />
						</c:import>
					</c:when>
				</c:choose>
				
				<c:import url="/sys/xform/include/sysForm_edit.jsp"
					charEncoding="UTF-8">
					<c:param name="formName" value="kmImissiveSendMainForm" />
					<c:param name="fdKey" value="sendMainDoc" />
					<c:param name="messageKey"
						value="km-imissive:kmImissiveSendMain.baseinfo" />
					<c:param name="useTab" value="false" />
				</c:import>
			</div>
			<div class="lui_form_content_frame">
				<table class="tb_normal" width="100%">
					<html:hidden property="fdNeedContent" />
					<c:if test="${kmImissiveSendMainForm.method_GET=='add'}">
						<tr>
							<td class="td_normal_title" width=15%>
								<bean:message key="kmImissiveReceiveTemplate.fdNeedContent" bundle="km-imissive" />
							</td>
							<td width="85%">
								<xform:radio property="fdEditType" showStatus="edit" value="${kmImissiveSendMainForm.fdNeedContent}" onValueChange="checkEditType">
									<xform:enumsDataSource enumsType="kmImissiveReceiveTemplate_fdNeedContent" />
								</xform:radio>
							</td>
						</tr>
					</c:if>
					<tr>
						<td colspan="4">
							<kmss:showWfPropertyValues  var="nodevalue" idValue="${kmImissiveSendMainForm.fdId}" propertyName="nodeName" />
							<c:choose>
							    <c:when test="${nodeExtAttributeMap['redhead4Draft'] == 'true' or nodeAdditionalMap['redhead'] == 'true' or nodeAdditionalMap['redhead'] == 'on' }">
							    	<c:set var="redhead" value="true" />
							    </c:when>
							    <c:otherwise>
							    	<c:set var="redhead" value="false" />
							    </c:otherwise>
							</c:choose>
							<c:choose>
								<c:when test="${not empty fdSignKey}">
									<c:forEach items="${kmImissiveSendMainForm.attachmentForms[fdSignKey].attachments}" var="sysAttMainx"  varStatus="vstatus">
										<c:set var="attId" value="${sysAttMainx.fdId}" scope="request"/>
										<c:set var="fdAttMainId" value="${sysAttMainx.fdId}" scope="request"/>
									</c:forEach>
									<c:choose>
										<c:when test="${wpsoaassist eq 'true'}">
											<jsp:include page="/km/imissive/wps/kmImissive_wpsoaassist.jsp">
												<jsp:param name="attId" value="${attId}" />
												<jsp:param name="fdKey" value="${fdSignKey}" />
												<jsp:param name="fdModelId" value="${kmImissiveSendMainForm.fdModelId}" />
											</jsp:include>
										</c:when>
										<c:otherwise>
											<jsp:include page="/km/imissive/km_imissive_send_main/kmImissiveSendMain_btn_include2.jsp">
												<jsp:param name="attId" value="${attId}"/>
											</jsp:include>
										</c:otherwise>
									</c:choose>
								</c:when>
								<c:when test="${not empty kmImissiveSendMainForm.attachmentForms['ofdCySign'].attachments}">
									<%-- ofd超阅展示 --%>
									<c:forEach items="${kmImissiveSendMainForm.attachmentForms['ofdCySign'].attachments}" var="sysAttMainx"  varStatus="vstatus">
										<c:set var="attId" value="${sysAttMainx.fdId}" scope="request"/>
									</c:forEach>
									<jsp:include page="/km/imissive/km_imissive_jgcy_ofd/kmImissiveSendJgOfdSignHead.jsp">
										<jsp:param name="attId" value="${attId}"/>
										<jsp:param name="fileName" value="${kmImissiveSendMainForm.docSubject}"/>
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
												<c:param name="fdModelId" value="${kmImissiveSendMainForm.fdId}" />
												<c:param name="fdModelName" value="com.landray.kmss.km.imissive.model.KmImissiveSendMain" />
											</c:import>
										</c:otherwise>
									</c:choose>
								</c:when>
								<c:when test="${not empty restDownloadUrl}">
								<%-- 转PDF or OFD正文展示  --%>
									<c:forEach items="${kmImissiveSendMainForm.attachmentForms[contentKey].attachments}" var="sysAttMainx"  varStatus="vstatus">
										<c:set var="attId" value="${sysAttMainx.fdId}" scope="request"/>
										<c:set var="fdAttMainId" value="${sysAttMainx.fdId}" scope="request"/>
									</c:forEach>
									<div id="missiveButtonDiv" >
									  	<jsp:include page="/km/imissive/km_imissive_send_main/kmImissiveSendMain_btn_include.jsp"></jsp:include>
									 </div>
									<iframe id="pdfFrame"  width="100%"  style="min-height:565px;"  frameborder="0"></iframe>
									<script type="text/javascript">
										//在普通编辑模式不会加载ui:event事件所以改为ready
										$(document).ready(function(){
											document.getElementById('pdfFrame').src='<c:url value="${restDownloadUrl }"/>';
										});
									</script>
								</c:when>
								<c:otherwise>
									<div id="wordEdit"							
										<c:if test="${kmImissiveSendMainForm.fdNeedContent!='1'}">style="width:0px;height:0px;"</c:if>>
										<%-- --套红头 -- --%>
										<%@ include file="/km/imissive/kmImissiveRedhead_script.jsp"%>
										<%@ include file="/km/imissive/km_imissive_send_main/kmImissiveSendRedhead_script.jsp"%>
										<c:choose>
											<c:when test="${wpsoaassist eq 'true'}">
												<div id="wpsAddIn">
													<c:choose>
														<c:when test="${xinChuangWps eq 'true'}">
															<jsp:include page="/km/imissive/wps/oaassist/sysAttMain_edit.jsp">
																<jsp:param name="fdKey" value="editonline"/>
																<jsp:param name="fdModelId" value="${kmImissiveSendMainForm.fdId}"/>
																<jsp:param name="fdModelName" value="com.landray.kmss.km.imissive.model.KmImissiveSendMain"/>
																<jsp:param name="formBeanName" value="kmImissiveSendMainForm"/>
																<jsp:param name="load" value="false"/>
																<jsp:param name="redhead" value="${redhead}"/>
																<jsp:param name="nodevalue" value="${nodevalue}"/>
																<jsp:param name="bookmarkJson" value="${bookmarkJson}"/>
																<jsp:param name="fdTemplateId" value="${kmImissiveSendMainForm.fdTemplateId}"/>
																<jsp:param name="newFlag" value="true"/>
															</jsp:include>
															<script type="text/javascript">
																$(document).ready(function(){
																	showWpsXinChuang('editonline');
																});
															</script>
														</c:when>
														<c:otherwise>
															<jsp:include page="/km/imissive/wps/sysAttMain_include_editWpsView.jsp">
																<jsp:param name="methodGet" value="${kmImissiveSendMainForm.method_GET}"/>
																<jsp:param name="fdModelId" value="${kmImissiveSendMainForm.fdId }"/>
																<jsp:param name="redhead" value="${redhead}"/>
																<jsp:param name="nodevalue" value="${nodevalue}"/>
																<jsp:param name="bookmarkJson" value="${bookmarkJson}"/>
																<jsp:param name="fdTemplateId" value="${kmImissiveSendMainForm.fdTemplateId}"/>
																<jsp:param name="fdModelName" value="com.landray.kmss.km.imissive.model.KmImissiveSendMain"/>
																<jsp:param name="formName" value="kmImissiveSendMainForm"/>
																<jsp:param name="initAttId" value="${initAttId }"/>
																<jsp:param name="modelFlag" value="send"/>
															</jsp:include>
														</c:otherwise>
													</c:choose>
												</div>
											</c:when>
											<c:when test="${_isWpsCloudEnable}">
												<c:import url="/km/imissive/import/xformBookmark_include.jsp"	charEncoding="UTF-8">
													<c:param name="formName" value="kmImissiveSendMainForm" />
													<c:param name="fdTemplateId" value="${kmImissiveSendMainForm.fdTemplateId }" />
												</c:import>
												<div id="missiveButtonDiv" style="text-align:right;">
													<a href="javascript:void(0);" class="attbook"
														onclick="openBookmarkHelp(Com_Parameter.ContextPath+'km/imissive/km_imissive_send_main/bookMarks.jsp');">
														<bean:message key="kmImissive.bookMarks.title"
															bundle="km-imissive" />
													</a>
												</div>
												<div id="wordEditWrapper"></div>
												<div id="wordEditFloat" style="width: 1px; height: 1px; filter: alpha(opacity = 0); opacity: 0;">
													<c:import url="/sys/attachment/sys_att_main/wps/cloud/sysAttMain_edit.jsp" charEncoding="UTF-8">
														<c:param name="fdKey" value="editonline" />
														<c:param name="load" value="false" />
														<c:param name="bindSubmit" value="false"/>	
														<c:param name="fdModelId" value="${kmImissiveSendMainForm.fdId}" />
														<c:param name="fdModelName" value="com.landray.kmss.km.imissive.model.KmImissiveSendMain" />
														<c:param name="formBeanName" value="kmImissiveSendMainForm" />
														<c:param name="fdTemplateModelId" value="${kmImissiveSendMainForm.fdTemplateId}" />
														<c:param name="fdTemplateModelName" value="com.landray.kmss.km.imissive.model.KmImissiveSendTemplate" />
														<c:param name="fdTemplateKey" value="editonline" />
														<c:param name="buttonDiv" value="missiveButtonDiv" />
														<c:param name="fdTempKey" value="${kmImissiveSendMainForm.fdTemplateId}" />
													</c:import>
												</div>
											</c:when>
											<c:when test="${_isWpsCenterEnable}">
												<c:import url="/km/imissive/import/xformBookmark_include.jsp"	charEncoding="UTF-8">
													<c:param name="formName" value="kmImissiveSendMainForm" />
													<c:param name="fdTemplateId" value="${kmImissiveSendMainForm.fdTemplateId }" />
												</c:import>
												<div id="missiveButtonDiv" style="text-align:right;">
													<%--<a href="javascript:void(0);" class="officialSmart" id="smartTypesettingBtn"
													   onclick="smartTypesetting('send', '${kmImissiveSendMainForm.method_GET}')">
														<c:out value="智能排版" />
													</a>--%>
													<a href="javascript:void(0);" class="attbook"
													   onclick="openBookmarkHelp(Com_Parameter.ContextPath+'km/imissive/km_imissive_send_main/bookMarks.jsp');">
														<bean:message key="kmImissive.bookMarks.title"
																	  bundle="km-imissive" />
													</a>
												</div>
												<div id="wordEditWrapper"></div>
												<div id="wordEditFloat" style="width: 1px; height: 1px; filter: alpha(opacity = 0); opacity: 0;">
													<c:import url="/sys/attachment/sys_att_main/wps/center/sysAttMain_edit.jsp" charEncoding="UTF-8">
														<c:param name="fdKey" value="editonline" />
														<c:param name="load" value="false" />
														<c:param name="bindSubmit" value="false"/>
														<c:param name="fdModelId" value="${kmImissiveSendMainForm.fdId}" />
														<c:param name="fdModelName" value="com.landray.kmss.km.imissive.model.KmImissiveSendMain" />
														<c:param name="formBeanName" value="kmImissiveSendMainForm" />
														<c:param name="fdTemplateModelId" value="${kmImissiveSendMainForm.fdTemplateId}" />
														<c:param name="fdTemplateModelName" value="com.landray.kmss.km.imissive.model.KmImissiveSendTemplate" />
														<c:param name="fdTemplateKey" value="editonline" />
														<c:param name="buttonDiv" value="missiveButtonDiv" />
														<c:param name="fdTempKey" value="${kmImissiveSendMainForm.fdTemplateId}" />
														<c:param name="buttonDiv" value="missiveButtonDiv" />
													</c:import>
												</div>
											</c:when>
											<c:otherwise>
												<%@ include
													file="/sys/attachment/sys_att_main/jg/sysAttMain_CheckJgSupport.jsp"%>
												<c:if test="${supportJg eq 'supported'}">
													<c:import url="/km/imissive/import/xformBookmark_include.jsp"	charEncoding="UTF-8">
														<c:param name="formName" value="kmImissiveSendMainForm" />
														<c:param name="fdTemplateId" value="${kmImissiveSendMainForm.fdTemplateId }" />
													</c:import>
													<div id="missiveButtonDiv" style="text-align:right;">
														<a href="javascript:void(0);" class="attbook"
															onclick="openBookmarkHelp(Com_Parameter.ContextPath+'km/imissive/km_imissive_send_main/bookMarks.jsp');">
															<bean:message key="kmImissive.bookMarks.title"
																bundle="km-imissive" />
														</a>
													</div>
												</c:if>
												<div id="wordEditWrapper"></div>
												<div id="wordEditFloat" style="width: 1px; height: 1px; filter: alpha(opacity = 0); opacity: 0;">
													<c:import url="/sys/attachment/sys_att_main/jg/sysAttMain_edit.jsp" charEncoding="UTF-8">
														<c:param name="fdKey" value="editonline" />
														<c:param name="fdAttType" value="office" />
														<c:param name="load" value="false" />
														<c:param name="bindSubmit" value="false" />
														<c:param name="fdModelId" value="${kmImissiveSendMainForm.fdId}" />
														<c:param name="fdModelName" value="com.landray.kmss.km.imissive.model.KmImissiveSendMain" />
														<c:param name="formBeanName" value="kmImissiveSendMainForm" />
														<c:param name="fdTemplateModelId" value="${kmImissiveSendMainForm.fdTemplateId}" />
														<c:param name="fdTemplateModelName" value="com.landray.kmss.km.imissive.model.KmImissiveSendTemplate" />
														<c:param name="fdTemplateKey" value="editonline" />
														<c:param name="templateBeanName" value="kmImissiveSendTemplateForm" />
														<c:param name="buttonDiv" value="missiveButtonDiv" />
														<c:param name="isToImg" value="false" />
														<c:param name="bookMarks" value="${bookmarkJson}" />
													</c:import>
												</div>
											</c:otherwise>
										</c:choose>
									</div>
									<div id="attEdit"
										<c:if test="${kmImissiveSendMainForm.fdNeedContent!='0'}">style="display:none"</c:if>>
										<div>
											<div class="lui_form_subhead">
												<img src="${KMSS_Parameter_ContextPath}sys/attachment/view/img/attachment.png">&nbsp;
												<bean:message key="kmImissiveMain.mainonline.upload" bundle="km-imissive" />
											</div>
											<c:import url="/sys/attachment/sys_att_main/sysAttMain_edit.jsp" charEncoding="UTF-8">
												<c:param name="fdKey" value="mainonline" />
												<c:param name="uploadAfterSelect" value="true" />
												<c:param name="fdMulti" value="false" />
												<c:param name="fdModelId" value="${kmImissiveSendMainForm.fdId }" />
												<c:param name="fdModelName" value="com.landray.kmss.km.imissive.model.KmImissiveSendMain" />
												<c:param name="redhead" value="${redhead}" />
												<c:param name="bookMarks" value="${bookmarkJson}" />	
												<c:param name="nodevalue" value="${nodevalue}" />
											</c:import>
										</div>
									</div>
								</c:otherwise>
							</c:choose>
						</td>
					</tr>
				</table>
			</div>
			<ui:tabpage expand="false">
				<!-- 以下代码为嵌入流程模板标签的代码 -->
				<c:import url="/sys/workflow/import/sysWfProcess_edit.jsp"
					charEncoding="UTF-8">
					<c:param name="formName" value="kmImissiveSendMainForm" />
					<c:param name="fdKey" value="sendMainDoc" />
					<c:param name="showHistoryOpers" value="true" />
					<c:param name="method" value="${param.method == 'addSend' or param.method == 'addSendOuter'? 'add':param.method}" />
					<c:param name="isExpand" value="true" />
				</c:import>
				<!-- 以上代码为嵌入流程模板标签的代码 -->
				<!--发布机制开始-->
				<c:import url="/sys/news/import/sysNewsPublishMain_edit.jsp"
					charEncoding="UTF-8">
					<c:param name="formName" value="kmImissiveSendMainForm" />
					<c:param name="fdKey" value="sendMainDoc" />
					<c:param name="isShow" value="true" />
				</c:import>
				<!--发布机制结束-->
				<!-- 版本锁机制 -->
				<c:import url="/component/locker/import/componentLockerVersion_import.jsp" charEncoding="UTF-8">
					<c:param name="formName" value="kmImissiveSendMainForm" />
				</c:import>
				<!-- 权限机制  -->
				<ui:content title="${ lfn:message('sys-right:right.moduleName') }">
					<table class="tb_normal" width=100%>
						<tr>
							<td class="td_normal_title" width="15%"><bean:message key="kmImissiveSendMain.authAppRecReaderIds" bundle="km-imissive" /></td>
							<td width="85%" colspan='3'>
								<xform:address textarea="true" mulSelect="true" propertyId="authAppRecReaderIds" 	propertyName="authAppRecReaderNames" style="width:97%;height:90px;"></xform:address> <br>
								<span class="com_help">
									<bean:message bundle="sys-right" key="right.read.authReaders.note1" />
								</span>
							</td>
						</tr>
						<c:import url="/sys/right/right_edit.jsp" charEncoding="UTF-8">
							<c:param name="formName" value="kmImissiveSendMainForm" />
							<c:param name="moduleModelName" value="com.landray.kmss.km.imissive.model.KmImissiveSendMain" />
						</c:import>
					</table>
				</ui:content>
				<!-- 权限机制 -->
			</ui:tabpage>
			<html:hidden property="method_GET" />
		</html:form>
		<script language="JavaScript">
			var validation = $KMSSValidation(document.forms['kmImissiveSendMainForm']);
		</script>
	</template:replace>
	<template:replace name="nav">
		<!-- 关联机制 -->
		<c:import url="/sys/relation/import/sysRelationMain_edit.jsp"
			charEncoding="UTF-8">
			<c:param name="formName" value="kmImissiveSendMainForm" />
		</c:import>
		<!-- 关联机制 -->
	</template:replace>
</template:include>
