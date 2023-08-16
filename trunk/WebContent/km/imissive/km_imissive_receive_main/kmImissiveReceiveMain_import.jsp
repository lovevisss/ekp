<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/sys/ui/jsp/common.jsp"%>
<%@page import="com.landray.kmss.km.imissive.util.KmImissiveConfigUtil"%>
<%@ page import="com.landray.kmss.sys.attachment.integrate.wps.util.SysAttWpsCenterUtil" %>
<c:set var="mainForm" value="${requestScope[param.formName]}" />
<%
	String norecodeLayout = "default";
	if("flat".equals(KmImissiveConfigUtil.getDisplayMode())){
		norecodeLayout = "simple";
	}
	request.setAttribute("norecodeLayout", norecodeLayout);
	pageContext.setAttribute("_isWpsCenterEnable", new Boolean(SysAttWpsCenterUtil.isEnable()));
%>

<c:if test="${mainForm.fdDeliverType eq '4' and not empty mainForm.fdMainId}">
	<c:import url="/km/imissive/km_imissive_receive_main/kmImissiveReceiveMain_sendAuditRecord.jsp" charEncoding="UTF-8">
		<c:param name="formBeanName" value="kmImissiveReceiveMainForm" />
	</c:import>
</c:if>
<!-- 版本锁机制 -->
<c:import url="/component/locker/import/componentLockerVersion_import.jsp" charEncoding="UTF-8">
	<c:param name="formName" value="kmImissiveReceiveMainForm" />
</c:import>
<c:import url="/km/imissive/import/kmImissiveOpinion_receive.jsp" charEncoding="UTF-8">
	<c:param name="formBeanName" value="kmImissiveReceiveMainForm" />
	<c:param name="fdModelId" value="${mainForm.fdId }" />
	<c:param name="fdModelName" value="com.landray.kmss.km.imissive.model.KmImissiveReceiveMain" />
	<c:param name="authUrl" value="/km/imissive/km_imissive_receive_main/kmImissiveReceiveMain.do?method=readViewLog" />
</c:import>
<%--传阅机制--%>
<c:import url="/km/imissive/km_imissive_circulation/kmImissiveCirculation_view.jsp" charEncoding="UTF-8">
	<c:param name="formName" value="kmImissiveReceiveMainForm" />
	<c:param name="titleicon" value="lui-tab-icon tab-icon-11" />
	<c:param name="norecodeLayout" value="${norecodeLayout}" />
</c:import>
<!-- 督办 -->
<c:if test="${kmImissiveReceiveMainForm.docStatus eq '30'}">
	<kmss:ifModuleExist path="/km/supervise/">
		<c:import url="/km/supervise/import/kmSuperviseMain_edit.jsp" charEncoding="UTF-8">
			<c:param name="fdModelId" value="${mainForm.fdId}" />
			<c:param name="fdModelName" value="com.landray.kmss.km.imissive.model.KmImissiveReceiveMain" />
			<c:param name="titleicon" value="lui-tab-icon tab-icon-08" />
			<c:param name="norecodeLayout" value="${norecodeLayout}" />
		</c:import>
	</kmss:ifModuleExist>
</c:if>

<ui:content title="${ lfn:message('km-imissive:kmImissiveReceiveMain.tracking.record') }"  titleicon="lui-tab-icon tab-icon-03">
     <div id ="trackArea">
		<table width=100% class="tb_normal">
			  <!--分发记录 -->
		  	 <c:import url="/km/imissive/km_imissive_send_main/kmImissiveSendMain_distributeDoc.jsp" charEncoding="UTF-8">
				<c:param name="fdRegType" value="receive" />
				<c:param name="fdMainId" value="${mainForm.fdId}" />
			 </c:import>
		 	 <!-- 上报记录 -->
		  	 <c:import url="/km/imissive/km_imissive_send_main/kmImissiveSendMain_reportDoc.jsp" charEncoding="UTF-8">
				<c:param name="fdRegType" value="receive" />
				<c:param name="fdMainId" value="${mainForm.fdId}" />
			 </c:import>
			 <tr>	  
			   <td>
			    <div style="margin-top: 15px;">
				    <div style="float:left">
						 <b><bean:message  bundle="km-imissive" key="kmImissiveSendMain.tracking.change2send"/>
						 </b>
					 </div>
					 <div style="margin-right:10px;text-align:right">&nbsp;&nbsp;&nbsp;
				     </div>
			    </div>
			 	<div style="height: 15px;"></div>
			 		<div>
						<list:listview channel="change2send">
							<ui:source type="AjaxJson">
									{url:'/km/imissive/km_imissive_send_main/kmImissiveSendMain.do?method=listSend&fdMainId=${mainForm.fdId}'}
							</ui:source>
							<list:colTable  isDefault="true" layout="sys.ui.listview.listtable" cfg-norecodeLayout="simple"  name="columntable">
								<list:col-serial></list:col-serial>
								<list:col-auto props=""></list:col-auto>
							</list:colTable>						
						</list:listview>
						<div style="height: 15px;"></div>
						<list:paging channel="change2send" layout="sys.ui.paging.simple"></list:paging>
					</div>
				 </td>
			  </tr>
			  
			  <tr>	  
			   <td>
			    <div style="margin-top: 15px;">
				    <div style="float:left">
						 <b><bean:message  bundle="km-imissive" key="kmImissiveSendMain.tracking.change2receive"/>
						 </b>
					 </div>
					 <div style="margin-right:10px;text-align:right">&nbsp;&nbsp;&nbsp;
				     </div>
			    </div>
			 	<div style="height: 15px;"></div>
			    <div>
					<list:listview channel="change2receive">
						<ui:source type="AjaxJson">
								{url:'/km/imissive/km_imissive_receive_main/kmImissiveReceiveMain.do?method=listReceive&fdMainId=${mainForm.fdId}'}
						</ui:source>
						<list:colTable  isDefault="true" layout="sys.ui.listview.listtable" cfg-norecodeLayout="simple" name="columntable">
							<list:col-serial></list:col-serial>
							<list:col-auto props=""></list:col-auto>
						</list:colTable>
					</list:listview>
					<div style="height: 15px;"></div>
						<list:paging channel="change2receive" layout="sys.ui.paging.simple"></list:paging>
					</div>
				 </td>
			  </tr>

			  <c:if test="${mainForm.docStatus =='30'}">
			   <tr>	  
			   <td>
			    <div style="margin-top: 15px;">
				    <div style="float:left">
						 <b><bean:message  bundle="km-imissive" key="kmImissiveSendMain.tracking.publish"/>
						 </b>
					 </div>
					 <div style="margin-right:10px;text-align:right">&nbsp;&nbsp;&nbsp;
				     </div>
			    </div>
			 	<div style="height: 15px;"></div>
					<c:import url="/sys/news/import/sysNewsPublishMain_view.jsp" charEncoding="UTF-8">
						<c:param name="formName" value="kmImissiveReceiveMainForm" />
						<c:param name="fdKey" value="receiveMainDoc" />
						<c:param name="isShowUiContent" value="false" />
				    </c:import>
			   </td>
			  </tr>
			  </c:if>
		</table> 
	</div>
</ui:content>
<!-- 阅读机制 -->
<c:import url="/sys/readlog/import/sysReadLog_view.jsp" charEncoding="UTF-8">
	<c:param name="formName" value="kmImissiveReceiveMainForm" />
	<c:param name="titleicon" value="lui-tab-icon tab-icon-04" />
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
			<td class="td_normal_title" width="15%"><bean:message key="kmImissiveReceiveMain.authAppRecReaderIds" bundle="km-imissive" /></td>
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
			<c:param name="formName" value="kmImissiveReceiveMainForm" />
			<c:param name="moduleModelName" value="com.landray.kmss.km.imissive.model.KmImissiveReceiveMain" />
		</c:import>
	</table>
</ui:content>
<!-- 权限机制 -->
<c:import url="/sys/bookmark/import/bookmark_bar.jsp"
	charEncoding="UTF-8">
	<c:param name="fdSubject" value="${mainForm.docSubject}" />
	<c:param name="fdModelId" value="${mainForm.fdId}" />
	<c:param name="fdModelName"
		value="com.landray.kmss.km.imissive.model.KmImissiveReceiveMain" />
</c:import>
<!-- 匿名机制 -->
<c:if test="${mainForm.docStatus =='30'}">
	<kmss:authShow roles="ROLE_KMIMISSIVE_ANONYMPUBLISH">
		<c:import url="/sys/anonym/import/sysAnonym_view.jsp" charEncoding="UTF-8">
			<c:param name="formName" value="kmImissiveReceiveMainForm" />
			<c:param name="fdKey" value="kmImissiveReceiveMain" />
			<c:param name="titleicon" value="lui-tab-icon tab-icon-12" />
		</c:import>
	</kmss:authShow>
</c:if>