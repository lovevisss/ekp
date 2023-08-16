<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/resource/jsp/common.jsp"%>
<c:set var="kmImissiveSendMainForm" value="${requestScope[param.formName]}" />
<%@ page import="com.landray.kmss.km.imissive.util.ImissiveUtil"%>
<%@ page import="com.landray.kmss.sys.attachment.integrate.wps.util.SysAttWpsCloudUtil" %>
<c:set var="_useWpsLinuxView" value="<%=SysAttWpsCloudUtil.getUseWpsLinuxView()%>"/>
<c:set var="wpsoaassist" value="<%=ImissiveUtil.isEnable()%>"/>
<c:set var="xinChuangWps" value="<%=ImissiveUtil.isWPSOAassistEmbed(request)%>"/>
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
	  <c:if test="${wpsoaassist eq 'true'}">
	 	 <script>Com_IncludeFile("wps_utils.js",Com_Parameter.ContextPath + "sys/attachment/sys_att_main/wps/oaassist/js/","js",true);</script>
	  </c:if>
	<script type="text/javascript">
			function openfile(fdId){
				if ('${wpsoaassist}'=="true" && '${_useWpsLinuxView}'!='true' && '${xinChuangWps}' != 'true') {
					var wpsParam = {};
					wpsParam['wpsExtAppModel'] = "kmImissive";
					openWpsOAAssit(fdId,wpsParam);
				}else{
				 var url="${KMSS_Parameter_ContextPath}sys/attachment/sys_att_main/sysAttMain.do?method=view&fdModelName=com.landray.kmss.km.imissive.model.KmImissiveAttTrack&fdSendId=${kmImissiveSendMainForm.fdId}&fdId="+fdId+"&directPreview=1110110";
				 Com_OpenWindow(url,"_blank");
			  }
			}
			function downLoadFile(fdId){

				var url="${KMSS_Parameter_ContextPath}sys/attachment/sys_att_main/sysAttMain.do?method=download&fdModelName=com.landray.kmss.km.imissive.model.KmImissiveAttTrack&fdId="+fdId;
				Com_OpenWindow(url,"_blank");

			}
	</script>
	  	<list:listview id="att" channel="att">
			<ui:source type="AjaxJson">
				{"url":"/km/imissive/km_imissive_att_track/kmImissiveAttTrack.do?method=list&fdMainId=${kmImissiveSendMainForm.fdId}"}
			</ui:source>
			<list:colTable isDefault="true" layout="sys.ui.listview.listtable" cfg-norecodeLayout="simple">
				<list:col-auto props="fdNodeName,docCreator.fdName,docCreateTime,fileType,fileName"></list:col-auto>
				<list:col-html style="width:150px;">
					if(row.downloadAuth == 'true'){
						{$<a href="javascript:;" style="float:right;padding-right:6px" onclick="downLoadFile('{%row.fdFileId%}')" class="com_btn_link">下载</a>$}
					}
				</list:col-html>
			</list:colTable>
		</list:listview>
		<div style="height: 15px;"></div>
		<list:paging layout="sys.ui.paging.simple"  channel="att"></list:paging>
	 </td>
</tr>