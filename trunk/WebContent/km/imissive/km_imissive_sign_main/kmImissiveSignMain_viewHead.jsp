<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/sys/ui/jsp/common.jsp"%>
<%@page import="java.util.List"%>
<%@page import="com.landray.kmss.sys.attachment.util.JgWebOffice"%>
<%@page import="com.landray.kmss.sys.attachment.model.SysAttMain"%>
<%@page import="com.landray.kmss.util.StringUtil"%>
<%@page import="com.landray.kmss.km.imissive.util.KmImissiveConfigUtil"%>
<%@page import="com.landray.kmss.km.imissive.forms.KmImissiveSignMainForm"%>
<%@page import="com.landray.kmss.util.ResourceUtil"%>
<%@page import="com.landray.kmss.sys.lbpmservice.support.model.LbpmSetting" %>
<%@page import="com.landray.kmss.sys.webservice2.util.SysWsUtil"%>
<%@page import="com.landray.kmss.sys.attachment.integrate.wps.util.SysAttWpsCloudUtil"%>
<%@page import="com.landray.kmss.sys.attachment.integrate.wps.util.SysAttWpsCenterUtil"%>
<%@ page import="com.landray.kmss.km.imissive.util.ImissiveUtil"%>
<%@ page import="com.landray.kmss.sys.attachment.util.SysAttConfigUtil" %>
<%@ page import="com.landray.kmss.util.UserUtil" %>
<%@ page import="com.landray.kmss.sys.ui.util.PcJsOptimizeUtil" %>
<c:set var="wpsoaassist" value="<%=ImissiveUtil.isEnable()%>"/>
<%
	request.setAttribute("jg_LoginUserId", UserUtil.getKMSSUser(request).getPerson().getFdId());
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
	<c:out value="${ kmImissiveSignMainForm.docSubject } - ${ lfn:message('km-imissive:module.km.imissive') }"></c:out> 
</template:replace>
<template:replace name="head">
<script>
    Com_IncludeFile("jquery.js|data.js");
    Com_IncludeFile('styles.css|jquery.ui.widget.js|jquery.marcopolo.js|jquery.manifest.js','js/jquery-plugin/manifest/');
</script>
</template:replace>
<template:replace name="toolbar">
<%
	if(request.getHeader("User-Agent").toUpperCase().indexOf("MSIE")>-1){
		request.setAttribute("isIE",true);
	}else if(request.getHeader("User-Agent").toUpperCase().indexOf("TRIDENT")>-1){
		request.setAttribute("isIE",true);
	}else{
		request.setAttribute("isIE",false);
	}

	String isJGSignatureHTMLEnabled = ResourceUtil.getKmssConfigString("sys.att.isJGSignatureHTMLEnabled");
	request.setAttribute("JGSignatureHTMLEnabled",isJGSignatureHTMLEnabled);
%>

	<c:if test="${kmImissiveSignMainForm.docDeleteFlag ==1}">
		<ui:toolbar id="toolbar" count="6" style="display:none;"></ui:toolbar>
	</c:if>
	<c:if test="${kmImissiveSignMainForm.docDeleteFlag !=1}">
	<ui:toolbar  id="toolbar" layout="sys.ui.toolbar.float" count="6">
	<c:if test="${kmImissiveSignMainForm.fdIsFiling != true}">
		<kmss:auth requestURL="/km/imissive/km_imissive_sign_main/kmImissiveSignMain.do?method=edit&fdId=${param.fdId}" requestMethod="GET">
			<c:if test="${(kmImissiveSignMainForm.docStatus!='00' && kmImissiveSignMainForm.docStatus!='30') }">
				<ui:button text="${lfn:message('button.edit') }" order="4" 
				onclick="editDoc();">
			    </ui:button>
			</c:if>
		</kmss:auth>
		<c:if test="${kmImissiveSignMainForm.docStatus=='30' and kmImissiveSignMainForm.fdIsFiling!= true}">
		 <kmss:auth requestURL="/km/imissive/km_imissive_sign_main/kmImissiveSignMain.do?method=editDocNum&fdId=${param.fdId}" requestMethod="GET">
			<ui:button text="${lfn:message('km-imissive:kmImissiveSignMain.editdocnum') }" order="4" 
			onclick="editDocNum();">
		    </ui:button>
		</kmss:auth>
		
		<c:if test="${kmImissiveSignMainForm.fdSuperviseFlag ne true and not empty fdSuperviseId }">
			<ui:button text="核发督办" id="confirmSuperVisedBtn" style="vertical-align:top;"  onclick="confirmSupervised();"></ui:button>
		</c:if>
			<c:if test="${kmImissiveSignMainForm.fdNeedContent=='0'}">
				<c:set var="fdKeyPdf" value="mainonline_pdf" scope="request"/>
			</c:if>
			<c:if test="${kmImissiveSignMainForm.fdNeedContent=='1'}">
				<c:set var="fdKeyPdf" value="editonline_pdf" scope="request"/>
			</c:if>
		</c:if>
		<%-- 归档 --%>
		<c:if test="${kmImissiveSignMainForm.docStatus == '30' || kmImissiveSignMainForm.docStatus == '00'}">
			<c:import url="/sys/archives/include/sysArchivesFileButton.jsp" charEncoding="UTF-8">
				<c:param name="fdId" value="${param.fdId}" />
				<c:param name="fdModelName" value="com.landray.kmss.km.imissive.model.KmImissiveSignMain" />
				<c:param name="serviceName" value="kmImissiveSignMainService" />
				<c:param name="userSetting" value="true" />
				<c:param name="cateName" value="fdTemplate" />
				<c:param name="moduleUrl" value="km/imissive" />
			</c:import>
		</c:if>
		<c:set var="existAtt" value="false" scope="request"/>
		<c:if test="${not empty kmImissiveSignMainForm.attachmentForms['attachment'].attachments}">
			<c:set var="existAtt" value="true" scope="request"/>
		</c:if>
		<c:if test="${kmImissiveSignMainForm.docStatus =='20'}">
			<c:if test="${fn:length(kmImissiveSignMainForm.attachmentForms['editonline'].attachments)==1}">
				<c:set var="sysAttMain" value="${kmImissiveSignMainForm.attachmentForms['editonline'].attachments[0]}" scope="request" />
				<%
					SysAttMain sysAttMain = (SysAttMain) request.getAttribute("sysAttMain");
					String suffix = sysAttMain.getFdFileName()
							.substring(sysAttMain.getFdFileName().lastIndexOf(".") + 1);
					if (StringUtil.isNotNull(suffix)&&("doc".equals(suffix.toLowerCase()) || "docx".equals(suffix.toLowerCase()) || "wps".equals(suffix.toLowerCase()))) {
						request.setAttribute("attType", "word");
					}
					request.setAttribute("attFileType", suffix);
				%>
			</c:if>
			<c:if test="${kmImissiveSignMainForm.fdNeedContent=='1' and kmImissiveSignMainForm.sysWfBusinessForm.fdNodeAdditionalInfo.redhead =='true'
			 						and 'word' eq attType and signAttsFlag ne true}">
				<%-- 套红附加选项 --%>
				<c:choose>
					<c:when test="${wpsoaassist eq 'true'}">
					</c:when>
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
					   <ui:button text="${lfn:message('km-imissive:kmImissive.redhead') }" order="2"
					     onclick="LoadHeadWordList('com.landray.kmss.km.imissive.model.KmImissiveSignMain');">
					   </ui:button>
				   </c:otherwise>
				</c:choose>
		  	</c:if>
		  	<!-- 签章附加选项 -->
			<kmss:ifModuleExist path="/km/signature/">
			<c:if test="${kmImissiveSignMainForm.fdNeedContent=='1' and kmImissiveSignMainForm.sysWfBusinessForm.fdNodeAdditionalInfo.sigzq =='true'}">
				<c:choose>
					<c:when test="${wpsoaassist eq 'true'}">
					</c:when>
					<c:when test="${_isWpsCloudEnable}">
					</c:when>
					<c:when test="${_isWpsCenterEnable}">
					</c:when>
					<c:otherwise>
						<ui:button text="${lfn:message('km-imissive:kmImissive.sigzq') }" order="2" onclick="WebOpenSignature('editonline','${jg_LoginUserId}');">
						</ui:button>
					</c:otherwise>
				</c:choose>
			</c:if>
			</kmss:ifModuleExist>
			
			<%-- 稿纸签章  --%>
			<c:if test="${kmImissiveSignMainForm.sysWfBusinessForm.fdNodeAdditionalInfo.signaturehtml =='true'}">
				<c:if test="${JGSignatureHTMLEnabled == 'true'}">
					<ui:button text="${lfn:message('km-imissive:kmImissive.sightml') }" order="1" onclick="DoSXSignature()"></ui:button>
				</c:if>
			</c:if>
		</c:if>
	</c:if>
	<c:if test="${eSignatureModuleExist=='true'&&kmImissiveSignMainForm.sysWfBusinessForm.fdNodeAdditionalInfo.sign == 'true'}">
				<ui:button id="signBtn" text="签署" onclick="cfca()"></ui:button>
	</c:if>
	<c:if test="${kmImissiveSignMainForm.sysWfBusinessForm.fdNodeAdditionalInfo.convertPdf =='true' and 'word' eq attType and signAttsFlag ne true}">
		<ui:button text="转pdf" onclick="convertFileType('pdf')"></ui:button>
	</c:if>
	<c:if test="${kmImissiveSignMainForm.sysWfBusinessForm.fdNodeAdditionalInfo.convertOfd =='true' and 'word' eq attType and signAttsFlag ne true}">
		<ui:button text="转ofd" onclick="convertFileType('ofd')"></ui:button>
	</c:if>
	<c:if test="${kmImissiveSignMainForm.sysWfBusinessForm.fdNodeAdditionalInfo.yqqSignzq =='true' && yqqFlag=='true'}">
		<c:if test="${not empty kmImissiveSignMainForm.attachmentForms['editonline'].attachments}">
	      	  <c:if test="${kmImissiveSignMainForm.fdNeedContent=='1'}">
		     	 <%-- 集成了易企签、勾选了附件选项 --%>
		      	 <ui:button text="${lfn:message('km-imissive:kmImissive.sign.zhixingqianshu')}" onclick="yqq('editonline');" order="2" />
	      	 </c:if>
      	 </c:if>
    </c:if>
	<%-- 书生ofd签章--%>
	<c:if test="${kmImissiveSignMainForm.sysWfBusinessForm.fdNodeAdditionalInfo.ofdSursenSign =='true'}">
		<ui:button text="${lfn:message('km-imissive:kmImissive.ofdSursenSign') }" order="1" onclick="ofdSursen('editonline')"></ui:button>
	</c:if>
	<c:if test="${kmImissiveSignMainForm.sysWfBusinessForm.fdNodeAdditionalInfo.eqbSign =='true' && eqbFlag eq 'true'}">
		<ui:button text="发送e签宝PDF签署" onclick="eqb('PDF')" order="1" />
	</c:if>
	<c:if test="${kmImissiveSignMainForm.sysWfBusinessForm.fdNodeAdditionalInfo.ofdEqbSign =='true' && eqbFlag eq 'true'}">
		<ui:button text="发送e签宝OFD签署" onclick="eqb('OFD')" order="1" />
	</c:if>
	<!-- 纳入议题 -->
	<c:if test="${kmImissiveSignMainForm.sysWfBusinessForm.fdNodeAdditionalInfo.addTopic eq 'true'}">
		<c:import url="/km/imeeting/include/km_imeeting_topic/kmImeetingTopicButton.jsp" charEncoding="UTF-8">
			<c:param name="formName" value="kmImissiveSignMainForm" />
			<c:param name="fdModelId" value="${param.fdId}" />
			<c:param name="fdModelName" value="com.landray.kmss.km.imissive.model.KmImissiveSignMain" />
		</c:import>
	</c:if>
	<c:if test="${kmImissiveSignMainForm.docStatus == '30' || kmImissiveSignMainForm.docStatus == '00'}">
		<!-- 沉淀-->
		<kmss:auth requestURL="/kms/multidoc/kms_multidoc_subside/kmsMultidocSubside.do?method=fileDoc&modelName=com.landray.kmss.km.imissive.model.KmImissiveSignMain&fdId=${param.fdId}" requestMethod="GET">
			<c:import url="/kms/multidoc/kms_multidoc_subside/subsideButton.jsp" charEncoding="UTF-8">
				<c:param name="fdId" value="${param.fdId}" />
				<c:param name="fdModelName" value="com.landray.kmss.km.imissive.model.KmImissiveSignMainForm" />
				<c:param name="serviceName" value="kmImissiveSignMainService" />
			</c:import>
		</kmss:auth>
	</c:if>
	<c:if test="${kmImissiveSignMainForm.docStatus!='10'}">
			<kmss:auth
				requestURL="/km/imissive/km_imissive_sign_main/kmImissiveSignMain.do?method=print&fdId=${param.fdId}&s_xform=${kmImissiveSignMainForm.sysWfBusinessForm.fdSubFormId}"
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
				onclick="Com_OpenWindow('kmImissiveSignMain.do?method=printLattice&fdId=${param.fdId}','_blank');">
			</ui:button>
			<%}%>
	</c:if>
	<kmss:auth requestURL="/km/imissive/km_imissive_sign_main/kmImissiveSignMain.do?method=delete&fdId=${param.fdId}" requestMethod="GET">
		 <ui:button text="${lfn:message('button.delete') }" order="4"
		       onclick="Delete('kmImissiveSignMain.do?method=delete&fdId=${param.fdId}');">
		 </ui:button>
	</kmss:auth>
	<ui:button text="${lfn:message('button.close')}" order="5" onclick="Com_CloseWindow();">
	</ui:button>
	</ui:toolbar>
	</c:if>
	<script>
		function printDoc(){
			if(typeof subform_print_BySubformId != "undefined"){
				subform_print_BySubformId('kmImissiveSignMain.do?method=print&fdId=${param.fdId}');
			}else{
				Com_OpenWindow('kmImissiveSignMain.do?method=print&fdId=${param.fdId}','_blank');
			}
			return;
		};
		
		function editDoc(){
			if(window.lbpm && window.lbpm.isSubForm && typeof subform_edit_BySubformId != "undefined"){
				subform_edit_BySubformId('kmImissiveSignMain.do?method=edit&fdId=${param.fdId}&fdTemplateId=${kmImissiveSignMainForm.fdTemplateId}','_self');
			}else{
				Com_OpenWindow('kmImissiveSignMain.do?method=edit&fdId=${param.fdId}&fdTemplateId=${kmImissiveSignMainForm.fdTemplateId}','_self');
			}
			return;
		};
	</script>
</template:replace>
<template:replace name="path">
<!-- 软删除配置 -->
<c:import url="/sys/recycle/import/redirect.jsp" charEncoding="UTF-8">
	<c:param name="formBeanName" value="kmImissiveSignMainForm"></c:param>
</c:import>
<div class="lui_form_path">
	<div class="lui_form_path_item_l">
		流程:
	</div>
	<div class="lui_form_path_item_c">
	<ui:menu layout="sys.ui.menu.nav" id="categoryId">
		<ui:menu-source autoFetch="false">
			<ui:source type="AjaxJson">
				{"url":"/sys/category/criteria/sysCategoryCriteria.do?method=path&modelName=com.landray.kmss.km.imissive.model.KmImissiveSignTemplate&categoryId=${kmImissiveSignMainForm.fdTemplateId}"} 
			</ui:source>
		</ui:menu-source>
	</ui:menu>
	</div>
	<c:if test="${ kmImissiveSignMainForm.docStatus == '20' }">
		<kmss:showWfPropertyValues var="nodevalue" idValue="${kmImissiveSignMainForm.fdId}" propertyName="nodeName" />
		<div class="lui_form_path_item_r">
	        - <c:out value="${nodevalue}"></c:out>
	    </div>
	</c:if>
</div>

<%--
	<ui:combin ref="menu.path.category">
		<ui:varParams moduleTitle="${ lfn:message('km-imissive:module.km.imissive') }"
		    modulePath="/km/imissive/" 
			modelName="com.landray.kmss.km.imissive.model.KmImissiveSignTemplate"
		    autoFetch="false" 
		    extHash="j_path=/listAll/sign&cri.q=fdTemplate:!{value}"
		    href="/km/imissive/"
			categoryId="${kmImissiveSignMainForm.fdTemplateId}" />
	</ui:combin>
 --%>
</template:replace>	
<c:if test="${kmImissiveSignMainForm.fdNeedContent=='1'}">
<%--驳回起草节点直接编辑 --%>
<c:if test="${kmImissiveSignMainForm.docStatus eq '11' and not empty curNode and curNode eq 'N2'}">
	<c:set var="editStatus" value="true" scope="request" />
</c:if>
<c:if test="${kmImissiveSignMainForm.docStatus =='20'}">
	<%
    if (KmImissiveConfigUtil.checkCanEditByImgDoc()) {
  	%>
		<kmss:auth requestURL="/km/imissive/km_imissive_sign_main/kmImissiveSignMain.do?method=edit&fdId=${param.fdId}" requestMethod="GET">							
			<c:set var="editStatus" value="true" scope="request"/>	
		</kmss:auth>
	<%
	}
	if (KmImissiveConfigUtil.checkCanEditByImgContent()) {
	%>
		<c:if  test="${kmImissiveSignMainForm.sysWfBusinessForm.fdNodeAdditionalInfo.editDocContent =='true'}">
			<c:set var="editStatus" value="true" scope="request"/>
		</c:if>
	<%} %>
    <%--标示是否编辑正文 --%>
	<c:if  test="${editFlag == true}">
		<c:set var="editStatus" value="true" scope="request"/>
	</c:if>
	<c:if
		test="${kmImissiveSignMainForm.sysWfBusinessForm.fdNodeAdditionalInfo.sigzq =='true'}">
		<c:set var="editStatus" value="true" scope="request" />
	</c:if>
	<c:if  test="${kmImissiveSignMainForm.sysWfBusinessForm.fdNodeAdditionalInfo.redhead =='true'}">
		<c:set var="editStatus" value="true" scope="request"/>
	</c:if>
	<%--能编辑且是当前处理人活着管理员#92305 --%>
	<c:if test="${editStatus eq true and canEditContent eq true}">
		<c:set var="editStatus" value="true" scope="request" />
	</c:if>
	<%--editStatus不为true，说明当前正文不处于编辑状态，如果当前审批人具有编号附件选项，此时需要将editStatus设置为true，且为只读状态，当用户点击文件编号按钮时再解除保护，编号完再设为保护状态--%>
	<c:if test="${!editStatus eq true and kmImissiveSignMainForm.sysWfBusinessForm.fdNodeAdditionalInfo.modifyDocNum eq true}">
	    <c:set var="editStatus" value="true" scope="request"/>
	    <c:set var="isReadOnly" value="true" scope="request"/>
	</c:if>
	<%--editStatus不为true，说明当前正文不处于编辑状态，如果当前审批人具有签发附件选项，此时需要将editStatus设置为true，且为只读状态，当用户点击文件编号按钮时再解除保护，编号完再设为保护状态--%>
	<c:if test="${!editStatus eq true and kmImissiveSignMainForm.sysWfBusinessForm.fdNodeAdditionalInfo.signature eq true}">
	    <c:set var="editStatus" value="true" scope="request"/>
	    <c:set var="isReadOnly" value="true" scope="request"/>
	</c:if>
</c:if>
</c:if>
<c:if test="${kmImissiveSignMainForm.sysWfBusinessForm.fdNodeAdditionalInfo.editAtt =='true'}">
	<c:set var="editAtt" value="true" scope="request" />
</c:if>
<%
	//获取参数配置中是否展开正文的配置
				request.setAttribute("expandDoc", KmImissiveConfigUtil.isExpandContent4Sign());
				request.setAttribute("expandBaseInfo", KmImissiveConfigUtil.isExpandBaseInfo4Sign());
				request.setAttribute("showAllPage","allpage".equals(KmImissiveConfigUtil.getLoadType()) ? true : false);
%>
<c:if
	test="${editStatus eq true or expandDoc eq true or (not empty change)}">
	<c:set var="expandContent" value="true" scope="request"/>
</c:if>
<c:if test="${expandBaseInfo eq true}">
	<c:set var="expandBaseInfo" value="true" scope="request"/>
</c:if>
<kmss:authShow roles="ROLE_KMIMISSIVE_SIGN_DOWNLOADCONTENT_EDIT">
	<c:set var="protectstatus" value="false" scope="request"></c:set>
</kmss:authShow>