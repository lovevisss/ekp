<%@ page import="com.landray.kmss.km.imissive.util.KmImissiveConfigUtil" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/resource/jsp/common.jsp"%>
<c:choose>
	<c:when test="${param._wpsLinuxPreview eq 'true' or param._isWpsCloudEnable eq 'true' or param._isWpsCenterEnable eq 'true'}">
		<div id="downloadDiv" style="text-align: right;;padding-bottom:5px">&nbsp;
			<kmss:authShow roles="ROLE_KMIMISSIVE_SEND_PRINTCONTENT">
				<kmss:auth requestURL="/sys/attachment/sys_att_main/sysAttMain.do?method=print&fdId=${param.attId}" requestMethod="GET">
					<a href="javascript:void(0);" class="attprint"
					   onclick="Com_OpenWindow('${KMSS_Parameter_ContextPath}sys/attachment/sys_att_main/sysAttMain.do?method=print&fdId=${param.attId }','_blank')">
						<bean:message  bundle="km-imissive" key="button.printText"/>
					</a>&nbsp;
				</kmss:auth>
			</kmss:authShow>
			<kmss:authShow roles="ROLE_KMIMISSIVE_SEND_DOWNLOADCONTENT">
				<kmss:auth requestURL="/sys/attachment/sys_att_main/sysAttMain.do?method=download&fdId=${param.attId}" requestMethod="GET">
					<a href="javascript:void(0);" class="attdownloadcontent"
					   onclick="Com_OpenWindow('${KMSS_Parameter_ContextPath}sys/attachment/sys_att_main/sysAttMain.do?method=download&fdId=${param.attId}&downloadType=manual');">
						<bean:message  bundle="km-imissive" key="button.download"/>
					</a>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
				</kmss:auth>
			</kmss:authShow>
		</div>
		<iframe id="pdfFrame"  width="100%"  style="min-height:565px;height:565px"  frameborder="0"></iframe>
		<script type="text/javascript">
			$(document).ready(function(){
				document.getElementById('pdfFrame').src = ("<c:url value="/sys/attachment/sys_att_main/sysAttMain.do?method=view&fdId=${param.attId}&inner=yes"/>");
			});
		</script>
	</c:when>
	<c:otherwise>
		<c:choose>
			<c:when test="${not empty param.signAttKey}">
				<c:import url="/sys/attachment/sys_att_main/sysAttMain_view.jsp" charEncoding="UTF-8">
					<c:param name="formBeanName" value="kmImissiveRegForm" />
					<c:param name="fdKey" value="${param.signAttKey}" />
					<c:param name="fdModelId" value="${kmImissiveRegDetailListForm.fdRegId}" />
					<c:param name="fdModelName" value="com.landray.kmss.km.imissive.model.KmImissiveReg" />
				</c:import>
			</c:when>
			<c:otherwise>
				<c:import url="/sys/attachment/sys_att_main/sysAttMain_view.jsp" charEncoding="UTF-8">
					<c:param name="formBeanName" value="kmImissiveRegForm" />
					<c:param name="fdKey" value="${kmImissiveRegDetailListForm.fdRegId}" />
					<c:param name="fdModelId" value="${kmImissiveRegDetailListForm.fdRegId}" />
					<c:param name="fdModelName" value="com.landray.kmss.km.imissive.model.KmImissiveReg" />
				</c:import>
			</c:otherwise>
		</c:choose>
	</c:otherwise>
</c:choose>