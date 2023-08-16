<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/resource/jsp/common.jsp"%>
<%@page import="com.landray.kmss.sys.attachment.util.JgWebOffice"%>
<c:set var="_isExistViewPath" value="<%=JgWebOffice.isExistViewPath(request)%>"/>
<c:choose>
	<c:when  test="${param._useWpsLinuxView eq 'true' or _isExistViewPath eq 'true'}">
		<div id="downloadDiv" style="text-align: right;;padding-bottom:5px">&nbsp;
			<kmss:authShow roles="ROLE_KMIMISSIVE_RECEIVE_DOWNLOADCONTENT">
				<kmss:auth requestURL="/sys/attachment/sys_att_main/sysAttMain.do?method=download&fdId=${param.attId}" requestMethod="GET">
					<a href="javascript:void(0);" class="attdownloadcontent"
					   onclick="Com_OpenWindow('${KMSS_Parameter_ContextPath}sys/attachment/sys_att_main/sysAttMain.do?method=download&fdId=${param.attId}&downloadType=manual');">
						<bean:message  bundle="km-imissive" key="button.download"/>
					</a>&nbsp;&nbsp;&nbsp;
				</kmss:auth>
			</kmss:authShow>
		</div>
		<iframe id="pdfFrame"  width="100%"  style="min-height:565px;"  frameborder="0"></iframe>
		<script type="text/javascript">
			//在普通编辑模式不会加载ui:event事件所以改为ready
			$(document).ready(function(){
				document.getElementById('pdfFrame').src='<c:url value="/sys/attachment/sys_att_main/sysAttMain.do?method=view&fdId=${param.attId}&showAllPage=true&newOpen=true&inner=yes"/>';
			});
		</script>
	</c:when>
	<c:otherwise>
		<c:import url="/sys/attachment/sys_att_main/sysAttMain_view.jsp" charEncoding="UTF-8">
			<c:param name="formBeanName" value="kmImissiveReceiveMainForm" />
			<c:param name="fdKey" value="${param.fdKey}" />
			<c:param name="fdModelId" value="${param.fdModelId}" />
			<c:param name="fdModelName" value="com.landray.kmss.km.imissive.model.KmImissiveReceiveMain" />
			<c:param  name="bookMarks"  value="${param.bookmarkJson}"/>
			<c:param  name="nodevalue"  value="${param.nodevalue}"/>
			<c:param  name="signtrue"  value="${param.signtrue}"/>
			<c:param name="wpsExtAppModel" value="kmImissive" />
			<c:param name="fdShowMsg" value="false"/>
			<c:param  name="fdViewType"  value="imissive"/>
			<c:param name="cleardraft" value="${param.cleardraft}" />
			<c:param  name="saveRevisions"  value="${param.saveRevisions}"/>
			<c:param  name="forceRevisions"  value="${param.forceRevisions}"/>
			<c:param name="canDownload" value="${param.canDownload}" />
			<c:param name="canEdit" value="${param.canEdit}" />
		</c:import>
	</c:otherwise>
</c:choose>