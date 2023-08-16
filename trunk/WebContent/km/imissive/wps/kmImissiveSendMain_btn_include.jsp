<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/resource/jsp/common.jsp"%>
<%@page import="com.landray.kmss.km.imissive.util.ImissiveUtil"%>
<%@page import="com.landray.kmss.km.imissive.util.KmImissiveConfigUtil"%>
<script>
	function downloadPdf(){
		var url = "${LUI_ContextPath}/sys/attachment/sys_att_main/sysAttMain.do?method=downloadPdf&fdId=${fdAttMainId}&convertType=${_isPdfServiceName}&fdFileName="+encodeURI('${kmImissiveSendMainForm.docSubject}');
		Com_OpenWindow(url,'_blank');
	}
	function downloadOfd(){
		var url = "${LUI_ContextPath}/sys/attachment/sys_att_main/sysAttMain.do?method=downloadOfd&fdId=${fdAttMainId}&convertType=${_isOfdServiceName}&fdFileName="+encodeURI('${kmImissiveSendMainForm.docSubject}');
		Com_OpenWindow(url,'_blank');
	}
</script>
<c:set var="isFileType" value="<%=ImissiveUtil.isPdfOrOfd(request)%>"/>
<c:if test="${isFileType ne 'true'}">
<c:choose>
	<c:when test="${param.redhead=='true' || param.cleardraft =='true' || param.editDocContent =='true' || 
						param.editStatus =='true' || param.canEdit == 'true'}">
		<table class="tb_normal" width="100%">
			<tr>
				<td colspan="4">
					<font style="text-align:center"><bean:message  bundle="km-imissive" key="kmMissiveMain.editPrompt"/></font>
				</td>
			</tr>
		</table>
	</c:when>
	<c:otherwise>
		<table class="tb_normal" width="100%">
		   <tr>
		     	<td colspan="4">
		     	  <font style="text-align:center"><bean:message  bundle="km-imissive" key="kmMissiveMain.viewPrompt"/></font>
		        </td>
		   </tr>
	    </table>
	</c:otherwise>
</c:choose>
</c:if>
<kmss:auth requestURL="/sys/attachment/sys_att_main/sysAttMain.do?method=download&fdId=${fdAttMainId}" requestMethod="GET">
	<a href="javascript:void(0);" class="attswich com_btn_link"
	   onclick="Com_OpenWindow('${KMSS_Parameter_ContextPath}sys/attachment/sys_att_main/sysAttMain.do?method=download&fdId=${fdAttMainId}&downloadType=manual');">
		<bean:message  bundle="km-imissive" key="button.download"/>
	</a>
</kmss:auth>
<c:if test="${isFileType ne 'true'}">
	<kmss:auth requestURL="/sys/attachment/sys_att_main/sysAttMain.do?method=downloadPdf&fdModelName=${param.fdModelName}&fdId=${fdAttMainId}" requestMethod="GET">
		<%
			if(KmImissiveConfigUtil.checkExistPdfReq(request)){
		%>
		 <a href="javascript:void(0);" class="attswich com_btn_link"
			onclick="downloadPdf();">
		   <bean:message  bundle="km-imissive" key="missive.button.downloadPdf"/>
		 </a>
		<%
			}
		%>
	</kmss:auth>
	<kmss:auth requestURL="/sys/attachment/sys_att_main/sysAttMain.do?method=downloadOfd&fdModelName=${param.fdModelName}&fdId=${fdAttMainId}" requestMethod="GET">
		<%
			//取fdAttMainId的值判断附件是否已经转换OFd
			if(KmImissiveConfigUtil.checkExistOdfReq(request)){
		%>
		 <a href="javascript:void(0);" class="attswich com_btn_link"
				onclick="downloadOfd();">
		   下载ofd
		 </a>
		<%
			}
		%>
	</kmss:auth>
</c:if>
<script type="text/javascript">
	Com_IncludeFile("wps_utils.js",Com_Parameter.ContextPath + "sys/attachment/sys_att_main/wps/oaassist/js/","js",true);
	Com_IncludeFile("kmImissiveSendRedhead_script.js",Com_Parameter.ContextPath + "km/imissive/wps/","js",true);
	function openWpsFile(fdId){
		var wpsParam = {};
		wpsParam['wpsExtAppModel'] = "kmImissive";
		wpsParam['signTrue'] = '${param.signtrue}';
		openWpsOAAssit(fdId,wpsParam);
	};
	function editWpsFile(fdId){
		var wpsParam = {};
		var books = addBookMarksByWpsAddIn('${param.bookMarks}');
		wpsParam['wpsExtAppModel'] = "kmImissive";
		wpsParam['cleardraft'] = '${param.cleardraft}';
		wpsParam['redhead'] = '${param.redhead}';
		wpsParam['signTrue'] = '${param.signtrue}';
		wpsParam['bookMarks'] = books;
		wpsParam['nodevalue'] = '${param.nodevalue}';
		wpsParam['saveRevisions'] = '${param.saveRevisions}';
		wpsParam['forceRevisions'] = '${param.forceRevisions}';
		editWpsOAAssit(fdId,wpsParam);
	}		

</script>
<c:if test="${isFileType ne 'true'}">
  	<c:choose>
		<c:when test="${(param.redhead=='true' || param.cleardraft =='true' || param.editDocContent =='true' || param.editStatus =='true' || param.canEdit == 'true')}">
			<c:import url="/km/imissive/import/xformBookmark_include.jsp"	charEncoding="UTF-8">
				<c:param name="formName" value="${param.formName}" />
				<c:param name="fdTemplateId" value="${param.fdTemplateId}" />
			</c:import>
			<a href="javascript:void(0);" class="attbook" onclick="openBookmarkHelp(Com_Parameter.ContextPath+'km/imissive/km_imissive_${param.modelFlag}_main/bookMarks.jsp');">
				<bean:message key="kmImissive.bookMarks.title" bundle="km-imissive" />
			</a>
			<a href="javascript:void(0);" class="attswich com_btn_link" onclick="editWpsFile('${param.attachmentId}')">
				  编辑正文
			</a>
		</c:when>
		<c:otherwise>
				<a href="javascript:void(0);" class="attswich com_btn_link" onclick="openWpsFile('${param.attachmentId}')">
				  	查看正文
				 </a>
		</c:otherwise>
	</c:choose>
</c:if>