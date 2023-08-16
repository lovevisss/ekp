<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="/sys/ui/jsp/common.jsp"%>
<%@page import="java.util.List"%>
<%@page import="com.landray.kmss.util.ResourceUtil"%>
<%@page import="com.landray.kmss.sys.attachment.util.JgWebOffice"%>
<template:include ref="default.archive">
	<template:replace name="head">
	</template:replace>
	<template:replace name="title">
		<c:out value="${ kmImissiveSendMainForm.docSubject } - ${ lfn:message('km-imissive:module.km.imissive') }"></c:out> 
	</template:replace>
	<template:replace name="toolbar">
</template:replace>
<template:replace name="content">
<html:form action="/km/imissive/km_imissive_send_main/kmImissiveSendMain.do">
<div id="printTable" class="tb_normal" style="border: none;font-size: 12px;max-width:1000px;">
 	<div class="lui_form_content_frame" style="padding-top:10px">
	    <table width=100% style="margin-top: 20px;">
			<tr>
				<td colspan="4">
				<c:import url="/resource/html_locate/sysForm.jsp" charEncoding="UTF-8">
					<c:param name="formName" value="kmImissiveSendMainForm" />
					<c:param name="fdKey" value="sendMainDoc" />
					<c:param name="messageKey" value="km-imissive:kmImissiveSendMain.baseinfo"/>
					<c:param name="useTab" value="false"/>
					<c:param name="isPrintGw" value="true" />
				</c:import>
				</td>
			</tr>
		</table>
	</div>
	<!-- 审批记录 -->
	<c:if test="${saveApproval }">
		<div class="lui_form_content_frame" style="padding-top:10px" id="wflogDiv">
	    <div class="titleDiv"><bean:message bundle="km-imissive" key="kmImissive.print.review.record"/></div>
	    <table width=100% style="margin-top: 20px;">
			<tr>
				<td colspan="4">
				   <c:import url="/resource/html_locate/lbpmAuditNote.jsp" charEncoding="UTF-8">
						<c:param name="formName" value="kmImissiveSendMainForm" />
					</c:import>
				</td>
			</tr>
		</table>
		</div>
	</c:if>
	<!-- 附件跟踪 -->
		<script>
			seajs.use(["theme!list"]);
		</script>
		<tr>	  
			 <td>
			  <div style="margin-top: 15px;">
			   	<div style="float:left">
					 <b><bean:message  bundle="km-imissive" key="kmImissiveSendMain.tracking.attachment"/></b>
			 	 </div>
				 <div style="height:15px;">
				 </div>
			  </div>
			  <div style="height: 15px;"></div>
				<table width="100%" class="lui_listview_columntable_listtable>
					<thead class="lui_listview_listtable_thead">
						<tr>
							<th class="lui_listview_listtable_th">${ lfn:message('km-imissive:kmImissiveAttTrack.fdNodeName') }</th>
							<th class="lui_listview_listtable_th">${ lfn:message('km-imissive:kmImissiveAttTrack.docCreator') }</th>
							<th class="lui_listview_listtable_th">${ lfn:message('km-imissive:kmImissiveAttTrack.docCreateTime') }</th>
							<th class="lui_listview_listtable_th">${ lfn:message('km-imissive:kmImissiveAttTrack.fileType') }</th>
							<th class="lui_listview_listtable_th">${ lfn:message('km-imissive:kmImissiveAttTrack.fileName') }</th>
						</tr>
					</thead>
					<tbody>
						<c:forEach items="${tracks }" var="track">
							<tr class="lui_listview_listtable_tr">
								<td class="lui_listview_listtable_td">${track.fdNodeName }</td>
								<td class="lui_listview_listtable_td">${track.docCreator.fdName }</td>
								<td class="lui_listview_listtable_td"><kmss:showDate value="${track.docCreateTime}" type="datetime" /></td>
								<td class="lui_listview_listtable_td"><sunbor:enumsShow value="${track.fileType}" enumsType="kmImissiveAttTrack_fileType" bundle="km-imissive" /></td>
								<td class="lui_listview_listtable_td"><c:out value="${track.fileName}"/></td>
							</tr>
						</c:forEach>
					</tbody>
				</table>
			 </td>
		</tr>
</div>
</html:form>
</template:replace>
</template:include>
