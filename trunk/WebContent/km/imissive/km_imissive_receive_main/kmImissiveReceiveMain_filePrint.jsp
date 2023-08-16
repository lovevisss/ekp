<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="/sys/ui/jsp/common.jsp"%>
<%@page import="java.util.List"%>
<%@page import="com.landray.kmss.util.ResourceUtil"%>
<%@page import="com.landray.kmss.sys.attachment.util.JgWebOffice"%>
<template:include ref="default.archive"> 
	<template:replace name="head">
	</template:replace>
	<template:replace name="title">
		<c:out value="${ kmImissiveReceiveMainForm.docSubject } - ${ lfn:message('km-imissive:module.km.imissive') }"></c:out> 
	</template:replace>
	<template:replace name="toolbar">
	</template:replace>
<template:replace name="content">
<html:form action="/km/imissive/km_imissive_receive_main/kmImissiveReceiveMain.do">
<div id="printTable" class="tb_normal" style="border: none;font-size: 12px;max-width:1000px;">
	    <div class="lui_form_content_frame" style="padding-top:10px">
	    <table   width=100% style="margin-top: 20px;">
			<tr>
				<td colspan="4">
				 <c:import url="/resource/html_locate/sysForm.jsp" charEncoding="UTF-8">
					<c:param name="formName" value="kmImissiveReceiveMainForm" />
					<c:param name="fdKey" value="receiveMainDoc" />
					<c:param name="messageKey" value="km-imissive:kmImissiveSendMain.baseinfo"/>
					<c:param name="useTab" value="false"/>
				    <c:param name="isPrintGw" value="true" />
				</c:import>
				</td>
			</tr>
		</table>
		</div>
		<c:if test="${saveApproval }">
			<div class="lui_form_content_frame" style="padding-top:10px" id="wflogDiv">
		    <div class="titleDiv"><bean:message bundle="km-imissive" key="kmImissive.print.review.record"/></div>
		    <table     width=100% style="margin-top: 20px;">
				<tr>
					<td colspan="4">
					  	<c:import url="/resource/html_locate/lbpmAuditNote.jsp" charEncoding="UTF-8">
							<c:param name="formName" value="kmImissiveReceiveMainForm" />
						</c:import>
					</td>
				</tr>
			</table>
			</div>
		</c:if>
 </div>
 </html:form>
</template:replace>
</template:include>
