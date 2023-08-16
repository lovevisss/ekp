<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/sys/ui/jsp/common.jsp"%>
<c:set var="mainForm" value="${requestScope[param.formName]}" />
<%@page import="com.landray.kmss.km.imissive.util.KmImissiveConfigUtil"%>
<%@ page import="com.landray.kmss.sys.attachment.integrate.wps.util.SysAttWpsCenterUtil" %>
<%
	String norecodeLayout = "default";
	if("flat".equals(KmImissiveConfigUtil.getDisplayMode())){
		norecodeLayout = "simple";
	}
	request.setAttribute("norecodeLayout", norecodeLayout);
	pageContext.setAttribute("_isWpsCenterEnable", new Boolean(SysAttWpsCenterUtil.isEnable()));
%>
<c:import url="/km/imissive/import/kmImissiveOpinion.jsp" charEncoding="UTF-8">
	<c:param name="formBeanName" value="kmImissiveSignMainForm" />
	<c:param name="fdModelId" value="${mainForm.fdId }" />
	<c:param name="fdModelName" value="com.landray.kmss.km.imissive.model.KmImissiveSignMain" />
	<c:param name="authUrl" value="/km/imissive/km_imissive_sign_main/kmImissiveSignMain.do?method=readViewLog" />
</c:import>
<!-- 版本锁机制 -->
<c:import url="/component/locker/import/componentLockerVersion_import.jsp" charEncoding="UTF-8">
	<c:param name="formName" value="kmImissiveSignMainForm" />
</c:import>
<%--传阅机制--%>
<c:import url="/km/imissive/km_imissive_circulation/kmImissiveCirculation_view.jsp" charEncoding="UTF-8">
	<c:param name="formName" value="kmImissiveSignMainForm" />
	<c:param name="titleicon" value="lui-tab-icon tab-icon-11" />
	<c:param name="norecodeLayout" value="${norecodeLayout}" />
</c:import>

<!-- 督办 -->
<c:if test="${kmImissiveSignMainForm.docStatus eq '30'}">
	<kmss:ifModuleExist path="/km/supervise/">
		<c:import url="/km/supervise/import/kmSuperviseMain_edit.jsp"	charEncoding="UTF-8">
			<c:param name="fdModelId" value="${param.fdId}" />
			<c:param name="fdModelName" value="com.landray.kmss.km.imissive.model.KmImissiveSignMain" />
			<c:param name="titleicon" value="lui-tab-icon tab-icon-08" />
			<c:param name="norecodeLayout" value="${norecodeLayout}" />
		</c:import>
	</kmss:ifModuleExist>
</c:if>

<c:if test="${_isWpsCenterEnable}">
	<kmss:auth requestURL="/km/imissive/km_imissive_sign_main/kmImissiveSignMain.do?method=readViewLog&fdId=${mainForm.fdId}" requestMethod="GET">
		<ui:content title="签报跟踪" titleicon="lui-tab-icon tab-icon-03">
			<table width=100% class="tb_normal">
				<!-- 附件跟踪 -->
				<c:import url="/km/imissive/km_imissive_sign_main/kmImissiveSignMain_attTrack.jsp" charEncoding="UTF-8">
					<c:param name="formName" value="kmImissiveSignMainForm" />
				</c:import>
			</table>
		</ui:content>
	</kmss:auth>
</c:if>

<!-- 发布机制开始 -->
<c:import url="/sys/news/import/sysNewsPublishMain_view.jsp" charEncoding="UTF-8">
	<c:param name="formName" value="kmImissiveSignMainForm" />
	<c:param name="fdKey" value="signMainDoc" />
	<c:param name="titleicon" value="lui-tab-icon tab-icon-12" />
	<c:param name="norecodeLayout" value="${norecodeLayout}" />
</c:import>
<!-- 以上代码为嵌入流程模板标签的代码 -->
<!-- 阅读机制 -->
<c:import url="/sys/readlog/import/sysReadLog_view.jsp" charEncoding="UTF-8">
	<c:param name="formName" value="kmImissiveSignMainForm" />
	<c:param name="titleicon" value="lui-tab-icon tab-icon-04" />
</c:import>
<!-- 阅读机制 -->
<c:import url="/sys/bookmark/import/bookmark_bar.jsp"
		charEncoding="UTF-8">
		<c:param name="fdSubject" value="${mainForm.docSubject}" />
		<c:param name="fdModelId" value="${mainForm.fdId}" />
		<c:param name="fdModelName" value="com.landray.kmss.km.imissive.model.KmImissiveSignMain" />
</c:import>
<%-- 沉淀记录 --%>
<kmss:ifModuleExist path="/kms/multidoc/">
	<c:import url="/kms/multidoc/kms_multidoc_subside/subsideRecord.jsp" charEncoding="UTF-8">
		<c:param name="fdId" value="${mainForm.fdId }" />
		<c:param name="titleicon" value="lui-tab-icon tab-icon-01" />
		<c:param name="norecodeLayout" value="${norecodeLayout}" />
	</c:import>
</kmss:ifModuleExist>
<!-- 权限机制-->
<ui:content title="${ lfn:message('sys-right:right.moduleName') }" titleicon="lui-tab-icon tab-icon-07">
	<table class="tb_normal" width=100%>
		<tr>
			<td class="td_normal_title" width="15%"><bean:message  bundle="km-imissive" key="kmImissiveSignMain.authAppRecReaderIds"/></td>
			<td width="85%" colspan='3'>
				<c:if test="${empty mainForm.authAppRecReaderNames}">
					<bean:message bundle="sys-right" key="right.other.person" />
				</c:if>
				<c:if test="${not empty mainForm.authAppRecReaderNames}">
					<c:out value="${mainForm.authAppRecReaderNames}"></c:out>
				</c:if>
			</td>
		</tr>
		<c:import url="/sys/right/right_view.jsp" charEncoding="UTF-8">
			<c:param name="formName" value="kmImissiveSignMainForm" />
			<c:param name="moduleModelName" value="com.landray.kmss.km.imissive.model.KmImissiveSignMain" />
		</c:import>
	</table>
</ui:content>
<!-- 匿名机制 -->
<c:if test="${mainForm.docStatus =='30'}">
	<kmss:authShow roles="ROLE_KMIMISSIVE_ANONYMPUBLISH">
		<c:import url="/sys/anonym/import/sysAnonym_view.jsp" charEncoding="UTF-8">
			<c:param name="formName" value="kmImissiveSignMainForm" />
			<c:param name="fdKey" value="kmImissiveSignMain" />
			<c:param name="titleicon" value="lui-tab-icon tab-icon-12" />
		</c:import>
	</kmss:authShow>
</c:if>