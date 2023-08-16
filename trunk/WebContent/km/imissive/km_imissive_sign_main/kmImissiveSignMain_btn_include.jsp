<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/resource/jsp/common.jsp"%>
<%@page import="com.landray.kmss.sys.attachment.util.JgWebOffice"%>
<%@page import="com.landray.kmss.km.imissive.util.KmImissiveConfigUtil"%>
<%@page import="com.landray.kmss.sys.attachment.integrate.wps.util.SysAttWpsCloudUtil"%>
<%@page import="com.landray.kmss.sys.attachment.integrate.wps.util.SysAttWpsCenterUtil"%>
<%@ page import="com.landray.kmss.km.imissive.util.ImissiveUtil" %>
<c:set var="xinChuangWps" value="<%=ImissiveUtil.isWPSOAassistEmbed(request)%>"/>
<%
    request.setAttribute("isExistViewPath", JgWebOffice.isExistViewPath(request));
	request.setAttribute("isJGMULEnabled", JgWebOffice.isJGMULEnabled());
	pageContext.setAttribute("_isJGEnabled", new Boolean(ImissiveUtil.isJGEnabled()));
	pageContext.setAttribute("_isWpsCloudEnable", new Boolean(ImissiveUtil.isEnableWpsCloud()));
	pageContext.setAttribute("_isWpsCenterEnable", new Boolean(SysAttWpsCenterUtil.isEnable()));
%>
<script>
	function downloadPdf(){
		var url = "${LUI_ContextPath}/sys/attachment/sys_att_main/sysAttMain.do?method=downloadPdf&fdId=${fdAttMainId}&fdFileName="+encodeURI('${kmImissiveSignMainForm.docSubject}')+"&convertType=${_isPdfServiceName}";
		Com_OpenWindow(url,'_blank');
	}
	function downloadOfd(){
		var url = "${LUI_ContextPath}/sys/attachment/sys_att_main/sysAttMain.do?method=downloadOfd&fdId=${fdAttMainId}&fdFileName="+encodeURI('${kmImissiveSignMainForm.docSubject}')+"&convertType=${_isOfdServiceName}";
		Com_OpenWindow(url,'_blank');
	}
</script>
<%
	if(KmImissiveConfigUtil.checkExistPdfReq(request)){
%>
<kmss:auth requestURL="/sys/attachment/sys_att_main/sysAttMain.do?method=downloadPdf&fdModelName=com.landray.kmss.km.imissive.model.KmImissiveSignMain&fdId=${fdAttMainId}" requestMethod="GET">
	<a href="javascript:void(0);" class="attswich com_btn_link"
	   onclick="downloadPdf();">
		<bean:message  bundle="km-imissive" key="missive.button.downloadPdf"/>
	</a>
</kmss:auth>
<%
	}
	//取fdAttMainId的值判断附件是否已经转换OFd
	if(KmImissiveConfigUtil.checkExistOdfReq(request)){
%>
<kmss:auth requestURL="/sys/attachment/sys_att_main/sysAttMain.do?method=downloadOfd&fdModelName=com.landray.kmss.km.imissive.model.KmImissiveSignMain&fdId=${fdAttMainId}" requestMethod="GET">
	<a href="javascript:void(0);" class="attswich com_btn_link"
	   onclick="downloadOfd();">
		下载ofd
	</a>
</kmss:auth>
<%
	}
%>

<c:if test="${editStatus eq 'true'}">
	<c:import url="/km/imissive/import/xformBookmark_include.jsp"	charEncoding="UTF-8">
		<c:param name="formName" value="kmImissiveSignMainForm" />
	</c:import>
	<a href="javascript:void(0);" class="attbook"
	   onclick="openBookmarkHelp(Com_Parameter.ContextPath+'km/imissive/km_imissive_sign_main/bookMarks.jsp');">
		<bean:message key="kmImissive.bookMarks.title" bundle="km-imissive" />
	</a>
</c:if>

<c:set var="_useViewDowload" value="${_useWpsLinuxView}"/>
<c:if test="${_useWpsLinuxView ne 'true'}">
	<c:if test="${xinChuangWps eq 'true'}">
		<c:set var="_useViewDowload" value="true"/>
	</c:if>
</c:if>

<c:choose>
	<c:when test="${kmImissiveSignMainForm.docStatus!='30'}">
		<c:if test="${(_isJGEnabled ne 'true' and _useViewDowload eq 'true' and not empty readOlCOnfig) or (isExistViewPath eq 'true' and readOlCOnfig eq '1')}">
			<kmss:auth requestURL="/sys/attachment/sys_att_main/sysAttMain.do?method=download&fdId=${attId}" requestMethod="GET">
				<a href="javascript:void(0);" class="attdownloadcontent"
				   onclick="Com_OpenWindow('${KMSS_Parameter_ContextPath}sys/attachment/sys_att_main/sysAttMain.do?method=download&fdId=${attId}&downloadType=manual');">
					<bean:message  bundle="km-imissive" key="button.download"/>
				</a>&nbsp;&nbsp;&nbsp;
			</kmss:auth>
		</c:if>
	</c:when>
	<c:otherwise>
		<kmss:authShow roles="ROLE_KMIMISSIVE_SIGN_DOWNLOADCONTENT">
			<c:if test="${(_isJGEnabled ne 'true' and _useViewDowload eq 'true' and not empty readOlCOnfig) or (isExistViewPath eq 'true' and readOlCOnfig eq '1')}">
				<kmss:auth requestURL="/sys/attachment/sys_att_main/sysAttMain.do?method=download&fdId=${attId}" requestMethod="GET">
					<a href="javascript:void(0);" class="attdownloadcontent"
					   onclick="Com_OpenWindow('${KMSS_Parameter_ContextPath}sys/attachment/sys_att_main/sysAttMain.do?method=download&fdId=${attId}&downloadType=manual');">
						<bean:message  bundle="km-imissive" key="button.download"/>
					</a>&nbsp;&nbsp;&nbsp;
				</kmss:auth>
			</c:if>
		</kmss:authShow>
	</c:otherwise>
</c:choose>

<c:if test="${_isWpsCloudEnable ne true && _isWpsCenterEnable ne true and _useWpsLinuxView ne true and 'true' ne xinChuangWps}">
<%if(JgWebOffice.isJGEnabled()&&Boolean.parseBoolean(KmImissiveConfigUtil.isShowImg())){ %>
	<c:choose>
	 <c:when test="${isIE}">
	    <c:if test="${empty isShowImg or isShowImg eq true}">
	    <c:choose>
	    	 <c:when test="${isExistViewPath}">
		     	 <a href="javascript:void(0);" class="attswich com_btn_link"
					onclick="Com_OpenWindow('kmImissiveSignMain.do?method=view&fdId=${JsParam.fdId}&isShowImg=${isShowImg}&change=true','_self');">
				   <bean:message  bundle="km-imissive" key="missive.button.Word"/>
				 </a>
		     </c:when>	
		     <c:otherwise>
			     <a href="javascript:void(0);" class="attswich com_btn_link"
					onclick="Com_OpenWindow('kmImissiveSignMain.do?method=view&fdId=${JsParam.fdId}&isShowImg=${isShowImg}&change=true','_self');">
				    <bean:message  bundle="km-imissive" key="missive.button.Html"/>
				 </a>
		     </c:otherwise>
	    </c:choose>
		</c:if>
		<c:if test="${isShowImg eq false}">
		  <a href="javascript:void(0);" class="attswich com_btn_link"
			onclick="Com_OpenWindow('kmImissiveSignMain.do?method=view&fdId=${JsParam.fdId}&isShowImg=${isShowImg}&change=true','_self');">
		  <bean:message  bundle="km-imissive" key="missive.button.Html"/>
		 </a>
		</c:if> 
	 </c:when>
	 <c:otherwise>
		  <c:if test="${isJGMULEnabled}">
			   <a href="javascript:void(0);" class="attswich com_btn_link"
				onclick="Com_OpenWindow('kmImissiveSignMain.do?method=view&fdId=${JsParam.fdId}&isShowImg=${isShowImg}&change=true','_self');">
			   ${lfn:message('km-imissive:missive.button.change.view') }
			   </a>
		   </c:if>
	 </c:otherwise>
	</c:choose>
<%} %>
</c:if>