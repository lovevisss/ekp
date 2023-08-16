<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@page import="com.landray.kmss.sys.attachment.model.SysAttMain"%>
<%@ include file="/sys/ui/jsp/common.jsp"%>
<%@page import="com.landray.kmss.util.ResourceUtil"%>
<%@page import="com.landray.kmss.sys.lbpmservice.support.model.LbpmSetting" %>
<template:replace name="title">
	<c:out
		value="${ kmImissiveSendMainForm.docSubject } - ${ lfn:message('km-imissive:module.km.imissive') }"></c:out>
</template:replace>
<template:replace name="head">
	<style>
	 	.handle_source_url{color: #57a7da !important;}
		.handle_source_url:hover{color: #4285f4 !important;text-decoration: underline;}
	</style>
</template:replace>
<template:replace name="toolbar">
<script>
    Com_IncludeFile("data.js|jquery.js");
    Com_IncludeFile('styles.css|jquery.ui.widget.js|jquery.marcopolo.js|jquery.manifest.js','js/jquery-plugin/manifest/');
</script>
<script>
   	 	Com_IncludeFile("jquery.js|base64.js");
	</script>
	<script src="${KMSS_Parameter_ContextPath}km/imissive/resource/js/base64.js"></script>
    <script src="${KMSS_Parameter_ContextPath}km/imissive/resource/js/jquery.min.js"></script>
	<script src="${KMSS_Parameter_ContextPath}km/imissive/resource/js/checkwps.js"></script>
    <script src="${KMSS_Parameter_ContextPath}km/imissive/resource/js/launchwps.js"></script>
    <script src="${KMSS_Parameter_ContextPath}km/imissive/resource/js/wps.js"></script>
    <script>
    
	    function openDoc() {
	        _wps.openDoc({
	            "docId": "${mobileEditAttId}",
	            "fileName":Com_GetCurDnsHost()+"${KMSS_Parameter_ContextPath}third/pda/attdownloadWps.jsp?fdId=${mobileEditAttId}",
	            "uploadPath":Com_GetCurDnsHost()+"${KMSS_Parameter_ContextPath}third/pda/attuploadWps.jsp?fdId=${mobileEditAttId}",
	            "buttonGroups": "btnOpenRevision,btnShowRevision,btnChangeToPDF,btnChangeToUOT,btnChangeToUOF",
	            "revisionCtrl": {
                    "bOpenRevision": false,
                    "bShowRevision": false
                },
	            "openType": { //文档打开方式
                    //文档保护类型，-1：不启用保护模式，0：只允许对现有内容进行修订，1：只允许添加批注，2：只允许修改窗体域(禁止拷贝功能)，3：只读
                    "protectType": 3,
                    "password": "123456"
                }
	        });
	    }

        function openEditDoc() {
            _wps.openDoc({
                "docId": "${mobileEditAttId}",
                "fileName":Com_GetCurDnsHost()+"${KMSS_Parameter_ContextPath}third/pda/attdownloadWps.jsp?fdId=${mobileEditAttId}",
                "uploadPath":Com_GetCurDnsHost()+"${KMSS_Parameter_ContextPath}third/pda/attuploadWps.jsp?fdId=${mobileEditAttId}",
                "buttonGroups": "",
                "revisionCtrl": {
                    "bOpenRevision": true,
                    "bShowRevision": true
                }
            });
        }

        function protectOpen() {
            _wps.openDoc({
                "docId": docId, //文档ID
                "uploadPath": "http://dev.wpseco.cn/file/place?id=" + docId + "&type=1", //保存文档接口
                "fileName": fileName + docId, //根据文档id获取服务器文档接口
                "buttonGroups": "btnChangeToPDF,btnChangeToUOT,btnChangeToUOF",
                "openType": { //文档打开方式
                    //文档保护类型，-1：不启用保护模式，0：只允许对现有内容进行修订，1：只允许添加批注，2：只允许修改窗体域(禁止拷贝功能)，3：只读
                    "protectType": 3,
                    "password": "123456"
                }
            });
        }

        function revisionCtrlOpen() {
            _wps.openDoc({
                "docId": docId, //文档ID
                "uploadPath": uploadPath + docId, //保存文档接口
                "fileName": fileName + docId, //根据文档id获取服务器文档接口
                "buttonGroups": "btnOpenRevision,btnShowRevision,btnAcceptAllRevisions,btnRejectAllRevisions",
                "userName": 'wangyifei',//用户名
                "revisionCtrl": {
                    "bOpenRevision": true,
                    "bShowRevision": true
                }
            });
        }

        function onlineEdit() {
            _wps.onlineEditDoc({
                "docId": docId, //文档ID
                "uploadPath": uploadPath + docId, //保存文档接口
                "fileName": fileName + docId, //根据文档id获取服务器文档接口
                "strBookmarkDataPath": "123456",//书签列表接口
                "templatePath": "1233456",//正文模板列表接口
                "buttonGroups": "btnSaveAsFile,btnImportDoc,btnPageSetup,btnInsertDate,btnSelectBookmark,btnImportTemplate",
                "userName": '王五',//用户名
                "revisionCtrl": {
                    "bOpenRevision": false,
                    "bShowRevision": true
                }
            })
        }
        
        

      function fillRedhead() {
        	Dialog_SimpleCategoryForNewFile("com.landray.kmss.km.imissive.model.KmImissiveRedHeadTemplate","createUrl?&fdTemplateId=!{id}&fdTemplateName=!{name}",false,true,"02",function(rtnVal){
				var selAttId = rtnVal[0].id;
				if(selAttId!=null){
					var templateUrl = Com_GetCurDnsHost()+"${KMSS_Parameter_ContextPath}third/pda/attdownloadWps.jsp?fdId="+selAttId;
					_wps.insertRedHeadDocFromWeb({
						"docId": "${mobileEditAttId}",
		                "fileName":Com_GetCurDnsHost()+"${KMSS_Parameter_ContextPath}third/pda/attdownloadWps.jsp?fdId=${mobileEditAttId}",
		                "uploadPath":Com_GetCurDnsHost()+"${KMSS_Parameter_ContextPath}third/pda/attuploadWps.jsp?fdId=${mobileEditAttId}",
		                "buttonGroups": "btnInsertRedHeader",
		            }, templateUrl, "Content");//红头模板中填充正文的位置书签名
				}else {//取消 
					return
				}
		},true,'<bean:message bundle="km-imissive" key="kmImissiveRedheadset.select"/>');
	   
	 }
        	
        	
        	
            

        
        function checkwps() {
            checkWPSProtocol(scb, fcb);
        }

        

       

       
    </script>


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
			
			request.setAttribute("jg_LoginUserId",UserUtil.getKMSSUser(request).getPerson().getFdId());
	%>
	<c:if test="${kmImissiveSendMainForm.fdNeedContent=='0'}">
		<c:set var="contentKey" value="mainonline" scope="request"/>
		<c:set var="fdKeyPdf" value="mainonline_pdf" scope="request"/>
		<c:set var="attForms" value="${kmImissiveSendMainForm.attachmentForms['mainonline']}" scope="request"/>
	</c:if>
	<c:if test="${kmImissiveSendMainForm.fdNeedContent=='1'}">
		<c:set var="contentKey" value="editonline" scope="request"/>
		<c:set var="fdKeyPdf" value="editonline_pdf" scope="request"/>
		<c:set var="attForms" value="${kmImissiveSendMainForm.attachmentForms['editonline']}" scope="request"/>
	</c:if>
	<c:if test="${not empty attForms.attachments and fn:length(attForms.attachments)==1}">
		<c:set var="sysAttMain" value="${attForms.attachments[0]}" scope="request" />
		<%
			SysAttMain sysAttMain = (SysAttMain) request.getAttribute("sysAttMain");
			String suffix = sysAttMain.getFdFileName()
					.substring(sysAttMain.getFdFileName().lastIndexOf(".") + 1);
			if ("doc".equals(suffix) || "docx".equals(suffix)) {
				request.setAttribute("attType", "word");
			}
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
				<kmss:auth
					requestURL="/km/imissive/km_imissive_send_main/kmImissiveSendMain.do?method=edit&fdId=${param.fdId}"
					requestMethod="GET">
						<ui:button text="${lfn:message('button.edit') }" order="4"
							onclick="editDoc();">
						</ui:button>
				</kmss:auth>
				<c:set var="distribute" value="false" scope="request"></c:set>
				<c:set var="report" value="false" scope="request"></c:set>
				<c:if
					test="${kmImissiveSendMainForm.docStatus=='30' and kmImissiveSendMainForm.fdIsFiling!= true}">
					<kmss:auth
						requestURL="/km/imissive/km_imissive_send_main/kmImissiveSendMain.do?method=editDocNum&fdId=${param.fdId}"
						requestMethod="GET">
						<ui:button
							text="${lfn:message('km-imissive:kmImissiveSendMain.editdocnum') }"
							order="4" onclick="editDocNum();">
						</ui:button>
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
					<c:if test="${kmImissiveSendMainForm.sysWfBusinessForm.fdNodeAdditionalInfo.saveRevisions =='true'}">
							<c:if test="${kmImissiveSendMainForm.fdNeedContent=='0'}">
								<ui:button
									text="${lfn:message('km-imissive:kmImissive.saveRevisions') }"
									order="2"
									onclick="saveRevisions('mainonline');">
								</ui:button>
							</c:if>
							<c:if test="${kmImissiveSendMainForm.fdNeedContent=='1'}">
								<ui:button
									text="${lfn:message('km-imissive:kmImissive.saveRevisions') }"
									order="2"
									onclick="saveRevisions('editonline');">
								</ui:button>
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

					<c:if
						test="${kmImissiveSendMainForm.fdNeedContent=='1' or attType eq 'word'}">
						<%-- 清稿附加选项 --%>
						<c:if
							test="${kmImissiveSendMainForm.sysWfBusinessForm.fdNodeAdditionalInfo.cleardraft =='true'}">
							<c:if test="${kmImissiveSendMainForm.fdNeedContent=='0'}">
								<ui:button
									text="${lfn:message('km-imissive:kmImissiveSendMain.cleardraft') }"
									order="3" onclick="cleardraft('mainonline');">
								</ui:button>
							</c:if>
							<c:if test="${kmImissiveSendMainForm.fdNeedContent=='1'}">
								<ui:button
									text="${lfn:message('km-imissive:kmImissiveSendMain.cleardraft') }"
									order="3" onclick="cleardraft('editonline');">
								</ui:button>
							</c:if>
						</c:if>
						<%-- 套红附加选项 --%>
							<ui:button
								text="${lfn:message('km-imissive:kmImissive.redhead') }"
								order="2"
								onclick="fillRedhead();">
							</ui:button>
						
						<c:if
							test="${kmImissiveSendMainForm.sysWfBusinessForm.fdNodeAdditionalInfo.redhead =='true'}">
							<c:if test="${kmImissiveSendMainForm.fdNeedContent=='0'}">
								<ui:button
									text="${lfn:message('km-imissive:kmImissive.redhead') }"
									order="2"
									onclick="LoadHeadWordList('com.landray.kmss.km.imissive.model.KmImissiveSendMain','mainonline');">
								</ui:button>
							</c:if>
							<c:if test="${kmImissiveSendMainForm.fdNeedContent=='1'}">
								<ui:button
									text="${lfn:message('km-imissive:kmImissive.redhead') }"
									order="2"
									onclick="LoadHeadWordList('com.landray.kmss.km.imissive.model.KmImissiveSendMain','editonline');">
								</ui:button>
							</c:if>
						</c:if>
						<!-- 签章附加选项 -->
						<kmss:ifModuleExist path="/km/signature/">
							<c:if
								test="${kmImissiveSendMainForm.sysWfBusinessForm.fdNodeAdditionalInfo.sigzq =='true'}">
								<c:if test="${kmImissiveSendMainForm.fdNeedContent=='0'}">
									<ui:button
										text="${lfn:message('km-imissive:kmImissive.sigzq') }"
										order="2" onclick="WebOpenSignature('mainonline','${jg_LoginUserId}');">
									</ui:button>
								</c:if>
								<c:if test="${kmImissiveSendMainForm.fdNeedContent=='1'}">
									<ui:button
										text="${lfn:message('km-imissive:kmImissive.sigzq') }"
										order="2" onclick="WebOpenSignature('editonline','${jg_LoginUserId}');">
									</ui:button>
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
					</c:import>
				</c:if>
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
			if(window.lbpm && window.lbpm.isSubForm && typeof subform_print_BySubformId != "undefined"){
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
	</script>
</template:replace>
<template:replace name="path">
<!-- 软删除配置 -->
<c:import url="/sys/recycle/import/redirect.jsp" charEncoding="UTF-8">
	<c:param name="formBeanName" value="kmImissiveSendMainForm"></c:param>
</c:import>
	<ui:menu layout="sys.ui.menu.nav" id="categoryId">
		<ui:menu-item text="${ lfn:message('home.home') }"
			icon="lui_icon_s_home" href="/" target="_self"></ui:menu-item>
		<ui:menu-item
			text="${ lfn:message('km-imissive:module.km.imissive') }"
			href="/km/imissive/" target="_self"></ui:menu-item>
		<ui:menu-item
			text="${ lfn:message('km-imissive:kmImissive.nav.SendManagement') }"
			href="/km/imissive/" target="_self"></ui:menu-item>
		<ui:menu-source autoFetch="false" target="_self"
			href="/km/imissive/#j_path=/listAll/send&cri.q=fdTemplate:${kmImissiveSendMainForm.fdTemplateId}">
			<ui:source type="AjaxJson">
					{"url":"/sys/category/criteria/sysCategoryCriteria.do?method=path&modelName=com.landray.kmss.km.imissive.model.KmImissiveSendTemplate&categoryId=${kmImissiveSendMainForm.fdTemplateId}"} 
				</ui:source>
		</ui:menu-source>
	</ui:menu>
</template:replace>
<c:if test="${kmImissiveSendMainForm.docStatus == '20'}">
	<%
		if (("true".equals(KmImissiveConfigUtil.isShowImg())
					&& "false".equals(KmImissiveConfigUtil.isShowImg4Doc()))
					|| "false".equals(KmImissiveConfigUtil.isShowImg())) {
	%>
	<kmss:auth requestURL="/km/imissive/km_imissive_send_main/kmImissiveSendMain.do?method=edit&fdId=${param.fdId}" requestMethod="GET">
		<c:set var="editStatus" value="true" scope="request" />
	</kmss:auth>
	<%
		}
	%>
	<%
		if (("true".equals(KmImissiveConfigUtil.isShowImg())
					&& "false".equals(KmImissiveConfigUtil.isShowImg4Content()))
					|| "false".equals(KmImissiveConfigUtil.isShowImg())) {
	%>
	<%--编辑正文 --%>
	<c:if
		test="${kmImissiveSendMainForm.sysWfBusinessForm.fdNodeAdditionalInfo.editDocContent =='true'}">
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
	<c:if
		test="${kmImissiveSendMainForm.sysWfBusinessForm.fdNodeAdditionalInfo.sigzq =='true'}">
		<c:set var="editStatus" value="true" scope="request" />
	</c:if>
	<%--套红 --%>
	<c:if
		test="${kmImissiveSendMainForm.sysWfBusinessForm.fdNodeAdditionalInfo.redhead =='true'}">
		<c:set var="editStatus" value="true" scope="request" />
	</c:if>
	<%--清稿 --%>
	<c:if
		test="${kmImissiveSendMainForm.sysWfBusinessForm.fdNodeAdditionalInfo.cleardraft =='true'}">
		<c:set var="editStatus" value="true" scope="request" />
	</c:if>
	<%--不强制留痕--%>
	<c:if
		test="${kmImissiveSendMainForm.sysWfBusinessForm.fdNodeAdditionalInfo.forceRevisions =='true' and editStatus == true}">
		<c:set var="forceRevisions" value="false" scope="request" />
	</c:if>
	<%--editStatus不为true，说明当前正文不处于编辑状态，如果当前审批人具有编号附件选项，此时需要将editStatus设置为true，且为只读状态，当用户点击文件编号按钮时再解除保护，编号完再设为保护状态--%>
	<c:set var="isReadOnly" value="false" scope="request" />
	<c:if
		test="${!editStatus eq true and kmImissiveSendMainForm.sysWfBusinessForm.fdNodeAdditionalInfo.modifyDocNum eq true}">
		<c:set var="editStatus" value="true" scope="request" />
		<c:set var="isReadOnly" value="true" scope="request" />
	</c:if>
	<%--editStatus不为true，说明当前正文不处于编辑状态，如果当前审批人具有签发附件选项，此时需要将editStatus设置为true，且为只读状态，当用户点击文件编号按钮时再解除保护，编号完再设为保护状态--%>
	<c:if
		test="${!editStatus eq true and kmImissiveSendMainForm.sysWfBusinessForm.fdNodeAdditionalInfo.signature eq true}">
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