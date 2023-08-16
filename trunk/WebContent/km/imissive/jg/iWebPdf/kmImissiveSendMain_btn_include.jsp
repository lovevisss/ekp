<%@ page import="com.landray.kmss.km.imissive.util.KmImissiveConfigUtil" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/resource/jsp/common.jsp"%>
<div id="downloadDiv" style="text-align: right;;padding-bottom:5px">&nbsp;
	<c:choose>
		<c:when test="${empty convertAttType}">
			<kmss:auth requestURL="/sys/attachment/sys_att_main/sysAttMain.do?method=download&fdId=${param.attId}" requestMethod="GET">
				<a href="javascript:void(0);" class="attdownloadcontent"
				   onclick="Com_OpenWindow('${KMSS_Parameter_ContextPath}sys/attachment/sys_att_main/sysAttMain.do?method=download&fdId=${param.attId}&downloadType=manual');">
					<bean:message  bundle="km-imissive" key="button.download"/>
				</a>
			</kmss:auth>
		</c:when>
		<c:otherwise>
			<kmss:auth requestURL="/sys/attachment/sys_att_main/sysAttMain.do?method=download&fdId=${param.attId}" requestMethod="GET">
				<a href="javascript:void(0);" class="attswich"
				   onclick="Com_OpenWindow('${KMSS_Parameter_ContextPath}sys/attachment/sys_att_main/sysAttMain.do?method=download&fdId=${param.attId}&downloadType=manual');">
					<bean:message  bundle="km-imissive" key="missive.button.downloadPdf"/>
				</a>
			</kmss:auth>
			<kmss:auth requestURL="/sys/attachment/sys_att_main/sysAttMain.do?method=download&fdId=${fdAttMainId}" requestMethod="GET">
				<a href="javascript:void(0);" class="attdownloadcontent"
				   onclick="Com_OpenWindow('${KMSS_Parameter_ContextPath}sys/attachment/sys_att_main/sysAttMain.do?method=download&fdId=${fdAttMainId}&downloadType=manual');">
					<bean:message  bundle="km-imissive" key="button.download"/>
				</a>
			</kmss:auth>
		</c:otherwise>
	</c:choose>
</div>
<c:choose>
	<c:when test="${'pdf' eq jgSignAttType || 'true' eq pdfJgSignKey}">
		<ui:event event="show">
			document.getElementById('pdfFrame').src = ("<c:url value="/sys/attachment/sys_att_main/sysAttMain.do?method=edit&fdId=${param.attId}&inner=yes&pdfJgSignKey=${param.pdfJgSignKey}&isJGSignaturePDF=true"/>");
		</ui:event>
	</c:when>
	<c:otherwise>
		<ui:event event="show">
			document.getElementById('pdfFrame').src = ("<c:url value="/sys/attachment/sys_att_main/sysAttMain.do?method=view&fdId=${param.attId}&inner=yes&pdfJgSignKey=${param.pdfJgSignKey}"/>");
		</ui:event>
	</c:otherwise>
</c:choose>
<iframe id="pdfFrame"  width="100%"  style="min-height:565px;height:565px"  frameborder="0"></iframe>