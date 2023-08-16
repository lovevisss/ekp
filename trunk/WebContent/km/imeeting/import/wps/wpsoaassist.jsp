<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/resource/jsp/common.jsp"%>
<%@page import="com.landray.kmss.sys.attachment.util.JgWebOffice"%>
<c:set var="_isExistViewPath" value="<%=JgWebOffice.isExistViewPath(request)%>"/>
<c:choose>
	<c:when  test="${_isExistViewPath eq 'true'}">
		<iframe id="kmImeetingSummary" width="100%" style="min-height:565px;" frameborder="0"></iframe>
		<script type="text/javascript">
			//在普通编辑模式不会加载ui:event事件所以改为ready
			$(document).ready(function(){
				document.getElementById('kmImeetingSummary').src='<c:url value="/sys/attachment/sys_att_main/sysAttMain.do?method=view&fdId=${param.attId}&showAllPage=true&newOpen=true&inner=yes"/>';
			});
		</script>
	</c:when>
	<c:otherwise>
		<c:import url="/sys/attachment/sys_att_main/sysAttMain_view.jsp" charEncoding="UTF-8">
			<c:param name="formBeanName" value="kmImeetingSummary" />
			<c:param name="fdKey" value="editonline" />
			<c:param name="fdModelId" value="${kmImeetingSummaryForm.fdId}" />
			<c:param name="fdModelName" value="com.landray.kmss.km.imeeting.model.KmImeetingSummary" />
			<c:param name="wpsExtAppModel" value="kmImeeting" />
			<c:param name="fdShowMsg" value="false"/>
			<c:param  name="fdViewType"  value="kmImeeting"/>
		</c:import>
	</c:otherwise>
</c:choose>